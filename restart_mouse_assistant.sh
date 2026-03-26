#!/bin/bash

APP_NAME="MouseAssistant"
APP_PATH="/Applications/MouseAssistant.app"

echo "Stopping $APP_NAME..."

# 1. AppleScriptを使用してアプリに正規の終了信号を送る
osascript -e "tell application \"$APP_NAME\" to quit"

# 2. 完全に終了するまで少し待機
for i in {1..5}; do
    if ! pgrep -i "$APP_NAME" > /dev/null; then
        break
    fi
    sleep 1
done

# 3. 残っているプロセスがあれば強制終了
if pgrep -i "$APP_NAME" > /dev/null; then
    echo "Force killing remaining processes..."
    pkill -i "$APP_NAME"
fi

echo "Starting $APP_NAME..."

# 4. アプリを起動
open "$APP_PATH"

echo "Done!"
