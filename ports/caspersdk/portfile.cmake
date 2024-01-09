set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_from_github(
  OUT_SOURCE_PATH
  SOURCE_PATH
  REPO
  matterfi/casper-cpp-sdk
  REF
  c580d34aff9892dde7fac54306c16735d270eb82
  SHA512
  b3bb24f98d257309b8bb1bd8bb1e825822889b819c898b5a18b5f0fc5031ac3b4bfc2de415e20610259e8ffe6ddd3e04313e99de9fbf4cbbf00fd8109a099053
  HEAD_REF
  main)

file(READ "${SOURCE_PATH}/tools/cmake/caspersdk-find-dependencies.cmake"
     FIND_DEPENDENCIES_VCPKG_WORKAROUND)
file(READ "${SOURCE_PATH}/tools/cmake/CasperSDKConfig.cmake.in"
     CASPERSDK_CONFIG_VCPKG_WORKAROUND)
string(REPLACE "include(caspersdk-find-dependencies)"
               "${FIND_DEPENDENCIES_VCPKG_WORKAROUND}" VCPKG_IS_BROKEN
               "${CASPERSDK_CONFIG_VCPKG_WORKAROUND}")
file(WRITE "${SOURCE_PATH}/tools/cmake/CasperSDKConfig.cmake.in"
     "${VCPKG_IS_BROKEN}")

vcpkg_cmake_configure(
  SOURCE_PATH
  "${SOURCE_PATH}"
  DISABLE_PARALLEL_CONFIGURE
  OPTIONS
  -DCASPERSDK_BUILD_TESTS=OFF
  OPTIONS_RELEASE
  -DCASPERSDK_DEBUG_BUILD=OFF
  -DCASPERSDK_INSTALL_LICENSE=ON
  -DCASPERSDK_LICENSE_FILE_NAME=copyright
  OPTIONS_DEBUG
  -DCASPERSDK_DEBUG_BUILD=ON
  -DCASPERSDK_PEDANTIC_BUILD=OFF
  -DCASPERSDK_INSTALL_HEADERS=OFF
  -DCASPERSDK_INSTALL_LICENSE=OFF
  -DCASPERSDK_HEADER_INSTALL_PATH=../include
  -DCASPERSDK_CMAKE_INSTALL_PATH=${CURRENT_PACKAGES_DIR}/share/CasperSDK/cmake)

vcpkg_cmake_install()