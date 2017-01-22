# Is netcdf-4 and/or DAP enabled?
NC4=1
DAP=1

# Is visual studio being used?
VS=yes
#CYGWIN=yes

if test "x$VS" = x ; then
#CC=mpicc
CC=gcc
export CC
fi

FLAGS="-DCMAKE_PREFIX_PATH=c:/tools/nccmake"

if test "x$DAP" = x ; then
FLAGS="$FLAGS -DENABLE_DAP=false"
fi
if test "x$NC4" = x ; then
FLAGS="$FLAGS -DENABLE_NETCDF_4=false"
fi
FLAGS="$FLAGS -DENABLE_CONVERSION_WARNINGS=false"
FLAGS="$FLAGS -DENABLE_DAP_REMOTE_TESTS=true"
FLAGS="$FLAGS -DENABLE_TESTS=true"

rm -fr build
mkdir build
cd build

cmake $FLAGS ..
#cmake --build .
CTEST_OUTPUT_ON_FAILURE=1 cmake --build . --target RUN_TESTS
