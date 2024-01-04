$ROOT_DIR = Join-Path "$PSScriptRoot" "/../.."

$ONETBB_SRC_DIR = Join-Path "$ROOT_DIR" "/oneTBB"
$ONETBB_BUILD_DIR = Join-Path "$ROOT_DIR" "/build/oneTBB"
$ONETBB_INSTALL_DIR = Join-Path "$ROOT_DIR" "/install"

Remove-Item -Recurse -Force "$ONETBB_BUILD_DIR"
mkdir "$ONETBB_BUILD_DIR" -ea 0

# docs:
# https://oneapi-src.github.io/oneTBB/main/tbb_userguide/Debug_Versus_Release_Libraries.html

cmake                                                `
    -DCMAKE_INSTALL_PREFIX="$ONETBB_INSTALL_DIR"     `
    -DBUILD_SHARED_LIBS=ON                           `
    -DTBB_TEST=OFF                                   `
    -DTBB_DISABLE_HWLOC_AUTOMATIC_SEARCH=TRUE        `
    -B "$ONETBB_BUILD_DIR"                           `
    -S "$ONETBB_SRC_DIR"                             `
    --fresh

#cmake --build "$ONETBB_BUILD_DIR" --config Debug
cmake --build "$ONETBB_BUILD_DIR" --config Release
cmake --install "$ONETBB_BUILD_DIR"

