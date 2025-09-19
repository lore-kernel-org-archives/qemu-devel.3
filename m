Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C657CAC592
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 13:37:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzbHo-0007Eq-0O; Fri, 19 Sep 2025 09:36:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1uzbGc-0006Mt-PP
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 09:35:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1uzbGX-0003ZV-Mu
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 09:35:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758288903;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sgCh1yYP3QHceD9LdOa2/YVBV6zI2sYyfHCquKKnMXI=;
 b=arxWkjQplM/ynRMANq+lqY50GVmIMlQjoWjLO/O60uOpUPRcJaD7wAGvTdJEr7RyWbZ2Td
 Lzq+RLfttDa/kZufSrjG75nGRwBqDBOhCIOBPus2zrVdCGh6d4iQ/hbxk/Mj/PtKt25m4R
 7C7o8731uHRnNqIqbvL3leWafgdDMQs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-516-MpNXSPU0OXuRq4L-YbCQnw-1; Fri,
 19 Sep 2025 09:34:54 -0400
X-MC-Unique: MpNXSPU0OXuRq4L-YbCQnw-1
X-Mimecast-MFC-AGG-ID: MpNXSPU0OXuRq4L-YbCQnw_1758288892
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ABDE018004D4; Fri, 19 Sep 2025 13:34:52 +0000 (UTC)
Received: from localhost (unknown [10.45.242.27])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 957E819560BB; Fri, 19 Sep 2025 13:34:50 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, Ed Maste <emaste@freebsd.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>, Kyle Evans <kevans@freebsd.org>
Subject: [PATCH 14/24] tests: move mips to debian-legacy-test-cross
Date: Fri, 19 Sep 2025 17:33:08 +0400
Message-ID: <20250919133320.240145-15-marcandre.lureau@redhat.com>
In-Reply-To: <20250919133320.240145-1-marcandre.lureau@redhat.com>
References: <20250919133320.240145-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.105,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Marc-André Lureau <marcandre.lureau@redhat.com>

We are updating debian which dropped support for it:
https://www.debian.org/releases/trixie/release-notes/issues.html#mips-architectures-removed

Cc: alex.bennee@linaro.org
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 configure                                     |   2 +-
 .gitlab-ci.d/buildtest.yml                    |   6 +-
 .gitlab-ci.d/container-cross.yml              |  12 --
 .gitlab-ci.d/crossbuild-template.yml          |   4 +-
 .gitlab-ci.d/crossbuilds.yml                  |  36 ----
 tests/docker/Makefile.include                 |   1 -
 .../dockerfiles/debian-all-test-cross.docker  |   8 -
 .../debian-legacy-test-cross.docker           |   5 +
 .../dockerfiles/debian-mips64el-cross.docker  | 185 ------------------
 .../dockerfiles/debian-mipsel-cross.docker    | 185 ------------------
 tests/lcitool/libvirt-ci                      |   2 +-
 tests/lcitool/refresh                         |  10 -
 12 files changed, 12 insertions(+), 444 deletions(-)
 delete mode 100644 tests/docker/dockerfiles/debian-mips64el-cross.docker
 delete mode 100644 tests/docker/dockerfiles/debian-mipsel-cross.docker

diff --git a/configure b/configure
index c2f4534964..8d84e3c5c0 100755
--- a/configure
+++ b/configure
@@ -1505,7 +1505,7 @@ probe_target_compiler() {
         container_cross_prefix=microblaze-linux-musl-
         ;;
       mips64el)
-        container_image=debian-all-test-cross
+        container_image=debian-legacy-test-cross
         container_cross_prefix=mips64el-linux-gnuabi64-
         ;;
       tricore)
diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index f8d7b6c3ac..8378b663b6 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -368,7 +368,7 @@ build-user:
   variables:
     IMAGE: debian-all-test-cross
     CONFIGURE_ARGS: --disable-tools --disable-system
-      --target-list-exclude=alpha-linux-user,sh4-linux-user
+      --target-list-exclude=alpha-linux-user,sh4-linux-user,mips-linux-user,mipsel-linux-user,mips64-linux-user
     MAKE_CHECK_ARGS: check-tcg
 
 build-user-static:
@@ -378,7 +378,7 @@ build-user-static:
   variables:
     IMAGE: debian-all-test-cross
     CONFIGURE_ARGS: --disable-tools --disable-system --static
-      --target-list-exclude=alpha-linux-user,sh4-linux-user
+      --target-list-exclude=alpha-linux-user,sh4-linux-user,mips-linux-user,mipsel-linux-user,mips64-linux-user
     MAKE_CHECK_ARGS: check-tcg
 
 # targets stuck on older compilers
@@ -388,7 +388,7 @@ build-legacy:
     - job: amd64-debian-legacy-cross-container
   variables:
     IMAGE: debian-legacy-test-cross
-    TARGETS: alpha-linux-user alpha-softmmu sh4-linux-user
+    TARGETS: alpha-linux-user alpha-softmmu sh4-linux-user mips-linux-user mips-softmmu mipsel-linux-user mipsel-softmmu mips64-linux-user mips64-softmmu
     CONFIGURE_ARGS: --disable-tools
     MAKE_CHECK_ARGS: check-tcg
 
diff --git a/.gitlab-ci.d/container-cross.yml b/.gitlab-ci.d/container-cross.yml
index 8d3be53b75..818ddb38ce 100644
--- a/.gitlab-ci.d/container-cross.yml
+++ b/.gitlab-ci.d/container-cross.yml
@@ -46,18 +46,6 @@ i686-debian-cross-container:
   variables:
     NAME: debian-i686-cross
 
-mips64el-debian-cross-container:
-  extends: .container_job_template
-  stage: containers
-  variables:
-    NAME: debian-mips64el-cross
-
-mipsel-debian-cross-container:
-  extends: .container_job_template
-  stage: containers
-  variables:
-    NAME: debian-mipsel-cross
-
 ppc64el-debian-cross-container:
   extends: .container_job_template
   stage: containers
diff --git a/.gitlab-ci.d/crossbuild-template.yml b/.gitlab-ci.d/crossbuild-template.yml
index 58136d06e4..751a6626e5 100644
--- a/.gitlab-ci.d/crossbuild-template.yml
+++ b/.gitlab-ci.d/crossbuild-template.yml
@@ -26,8 +26,8 @@
     - ../configure --enable-werror --disable-docs --enable-fdt=system
         --disable-user $QEMU_CONFIGURE_OPTS $EXTRA_CONFIGURE_OPTS
         --target-list-exclude="arm-softmmu
-          i386-softmmu microblaze-softmmu mips-softmmu mipsel-softmmu
-          mips64-softmmu ppc-softmmu riscv32-softmmu sh4-softmmu
+          i386-softmmu microblaze-softmmu
+          ppc-softmmu riscv32-softmmu sh4-softmmu
           sparc-softmmu xtensa-softmmu $CROSS_SKIP_TARGETS"
     - section_end configure
     - section_start build "Building QEMU"
diff --git a/.gitlab-ci.d/crossbuilds.yml b/.gitlab-ci.d/crossbuilds.yml
index 8ff0c27f74..541bd426f0 100644
--- a/.gitlab-ci.d/crossbuilds.yml
+++ b/.gitlab-ci.d/crossbuilds.yml
@@ -68,34 +68,6 @@ cross-i686-tci:
     # would otherwise be using a parallelism of 9.
     MAKE_CHECK_ARGS: check check-tcg -j2
 
-cross-mipsel-system:
-  extends: .cross_system_build_job
-  needs:
-    - job: mipsel-debian-cross-container
-  variables:
-    IMAGE: debian-mipsel-cross
-
-cross-mipsel-user:
-  extends: .cross_user_build_job
-  needs:
-    - job: mipsel-debian-cross-container
-  variables:
-    IMAGE: debian-mipsel-cross
-
-cross-mips64el-system:
-  extends: .cross_system_build_job
-  needs:
-    - job: mips64el-debian-cross-container
-  variables:
-    IMAGE: debian-mips64el-cross
-
-cross-mips64el-user:
-  extends: .cross_user_build_job
-  needs:
-    - job: mips64el-debian-cross-container
-  variables:
-    IMAGE: debian-mips64el-cross
-
 cross-ppc64el-system:
   extends: .cross_system_build_job
   needs:
@@ -154,14 +126,6 @@ cross-s390x-kvm-only:
     IMAGE: debian-s390x-cross
     EXTRA_CONFIGURE_OPTS: --disable-tcg --enable-trace-backends=ftrace
 
-cross-mips64el-kvm-only:
-  extends: .cross_accel_build_job
-  needs:
-    - job: mips64el-debian-cross-container
-  variables:
-    IMAGE: debian-mips64el-cross
-    EXTRA_CONFIGURE_OPTS: --disable-tcg --target-list=mips64el-softmmu
-
 cross-win64-system:
   extends: .cross_system_build_job
   needs:
diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 3959d8a028..4e9b5b9818 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -82,7 +82,6 @@ endif
 
 # For non-x86 hosts not all cross-compilers have been packaged
 ifneq ($(HOST_ARCH),x86_64)
-DOCKER_PARTIAL_IMAGES += debian-mipsel-cross debian-mips64el-cross
 DOCKER_PARTIAL_IMAGES += debian-ppc64el-cross
 DOCKER_PARTIAL_IMAGES += debian-s390x-cross
 DOCKER_PARTIAL_IMAGES += fedora
diff --git a/tests/docker/dockerfiles/debian-all-test-cross.docker b/tests/docker/dockerfiles/debian-all-test-cross.docker
index 420a4e33e6..7ec54c7125 100644
--- a/tests/docker/dockerfiles/debian-all-test-cross.docker
+++ b/tests/docker/dockerfiles/debian-all-test-cross.docker
@@ -40,14 +40,6 @@ ENV AVAILABLE_COMPILERS gcc-aarch64-linux-gnu \
         libc6-dev-arm64-cross \
         gcc-arm-linux-gnueabihf \
         libc6-dev-armhf-cross \
-        gcc-mips-linux-gnu \
-        libc6-dev-mips-cross \
-        gcc-mips64-linux-gnuabi64 \
-        libc6-dev-mips64-cross \
-        gcc-mips64el-linux-gnuabi64 \
-        libc6-dev-mips64el-cross \
-        gcc-mipsel-linux-gnu \
-        libc6-dev-mipsel-cross \
         gcc-powerpc64le-linux-gnu \
         libc6-dev-ppc64el-cross \
         gcc-riscv64-linux-gnu \
diff --git a/tests/docker/dockerfiles/debian-legacy-test-cross.docker b/tests/docker/dockerfiles/debian-legacy-test-cross.docker
index 5a6616b7d3..8c922b47f5 100644
--- a/tests/docker/dockerfiles/debian-legacy-test-cross.docker
+++ b/tests/docker/dockerfiles/debian-legacy-test-cross.docker
@@ -5,6 +5,7 @@
 #
 #   libc6.1-dev-alpha-cross: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1054412
 #   sh4-linux-user: binaries don't run with bookworm compiler
+#   mips: https://www.debian.org/releases/trixie/release-notes/issues.html#mips-architectures-removed
 #
 # As we are targeting check-tcg here we only need minimal qemu
 # dependencies and the relevant cross compilers.
@@ -33,6 +34,10 @@ RUN DEBIAN_FRONTEND=noninteractive eatmydata \
         libc6.1-dev-alpha-cross \
         gcc-sh4-linux-gnu \
         libc6-dev-sh4-cross \
+        gcc-mips64el-linux-gnuabi64 \
+        libc6-dev-mips64el-cross \
+        gcc-mipsel-linux-gnu \
+        libc6-dev-mipsel-cross \
         python3-pip \
         python3-setuptools \
         python3-venv \
diff --git a/tests/docker/dockerfiles/debian-mips64el-cross.docker b/tests/docker/dockerfiles/debian-mips64el-cross.docker
deleted file mode 100644
index cca04a4594..0000000000
--- a/tests/docker/dockerfiles/debian-mips64el-cross.docker
+++ /dev/null
@@ -1,185 +0,0 @@
-# THIS FILE WAS AUTO-GENERATED
-#
-#  $ lcitool dockerfile --layers all --cross-arch mips64el debian-12 qemu
-#
-# https://gitlab.com/libvirt/libvirt-ci
-
-FROM docker.io/library/debian:12-slim
-
-RUN export DEBIAN_FRONTEND=noninteractive && \
-    apt-get update && \
-    apt-get install -y eatmydata && \
-    eatmydata apt-get dist-upgrade -y && \
-    eatmydata apt-get install --no-install-recommends -y \
-                      bash \
-                      bc \
-                      bindgen \
-                      bison \
-                      bsdextrautils \
-                      bzip2 \
-                      ca-certificates \
-                      ccache \
-                      dbus \
-                      debianutils \
-                      diffutils \
-                      exuberant-ctags \
-                      findutils \
-                      flex \
-                      gcc \
-                      gcovr \
-                      gettext \
-                      git \
-                      hostname \
-                      libclang-rt-dev \
-                      libglib2.0-dev \
-                      llvm \
-                      locales \
-                      make \
-                      mtools \
-                      ncat \
-                      ninja-build \
-                      openssh-client \
-                      pkgconf \
-                      python3 \
-                      python3-numpy \
-                      python3-opencv \
-                      python3-pillow \
-                      python3-pip \
-                      python3-setuptools \
-                      python3-sphinx \
-                      python3-sphinx-rtd-theme \
-                      python3-venv \
-                      python3-wheel \
-                      python3-yaml \
-                      rpm2cpio \
-                      rustc-web \
-                      sed \
-                      socat \
-                      sparse \
-                      swtpm \
-                      tar \
-                      tesseract-ocr \
-                      tesseract-ocr-eng \
-                      vulkan-tools \
-                      xorriso \
-                      zstd && \
-    eatmydata apt-get autoremove -y && \
-    eatmydata apt-get autoclean -y && \
-    sed -Ei 's,^# (en_US\.UTF-8 .*)$,\1,' /etc/locale.gen && \
-    dpkg-reconfigure locales && \
-    rm -f /usr/lib*/python3*/EXTERNALLY-MANAGED
-
-RUN /usr/bin/pip3 install meson==1.8.1
-
-ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
-ENV LANG "en_US.UTF-8"
-ENV MAKE "/usr/bin/make"
-ENV NINJA "/usr/bin/ninja"
-ENV PYTHON "/usr/bin/python3"
-
-RUN export DEBIAN_FRONTEND=noninteractive && \
-    dpkg --add-architecture mips64el && \
-    eatmydata apt-get update && \
-    eatmydata apt-get dist-upgrade -y && \
-    eatmydata apt-get install --no-install-recommends -y dpkg-dev && \
-    eatmydata apt-get install --no-install-recommends -y \
-                      gcc-mips64el-linux-gnuabi64 \
-                      libaio-dev:mips64el \
-                      libasound2-dev:mips64el \
-                      libattr1-dev:mips64el \
-                      libbpf-dev:mips64el \
-                      libbrlapi-dev:mips64el \
-                      libbz2-dev:mips64el \
-                      libc6-dev:mips64el \
-                      libcacard-dev:mips64el \
-                      libcap-ng-dev:mips64el \
-                      libcapstone-dev:mips64el \
-                      libcbor-dev:mips64el \
-                      libcmocka-dev:mips64el \
-                      libcurl4-gnutls-dev:mips64el \
-                      libdaxctl-dev:mips64el \
-                      libdrm-dev:mips64el \
-                      libepoxy-dev:mips64el \
-                      libfdt-dev:mips64el \
-                      libffi-dev:mips64el \
-                      libfuse3-dev:mips64el \
-                      libgbm-dev:mips64el \
-                      libgcrypt20-dev:mips64el \
-                      libglib2.0-dev:mips64el \
-                      libglusterfs-dev:mips64el \
-                      libgnutls28-dev:mips64el \
-                      libgtk-3-dev:mips64el \
-                      libgtk-vnc-2.0-dev:mips64el \
-                      libibverbs-dev:mips64el \
-                      libiscsi-dev:mips64el \
-                      libjemalloc-dev:mips64el \
-                      libjpeg62-turbo-dev:mips64el \
-                      libjson-c-dev:mips64el \
-                      liblttng-ust-dev:mips64el \
-                      liblzo2-dev:mips64el \
-                      libncursesw5-dev:mips64el \
-                      libnfs-dev:mips64el \
-                      libnuma-dev:mips64el \
-                      libpam0g-dev:mips64el \
-                      libpcre2-dev:mips64el \
-                      libpipewire-0.3-dev:mips64el \
-                      libpixman-1-dev:mips64el \
-                      libpng-dev:mips64el \
-                      libpulse-dev:mips64el \
-                      librbd-dev:mips64el \
-                      librdmacm-dev:mips64el \
-                      libsasl2-dev:mips64el \
-                      libsdl2-dev:mips64el \
-                      libsdl2-image-dev:mips64el \
-                      libseccomp-dev:mips64el \
-                      libselinux1-dev:mips64el \
-                      libslirp-dev:mips64el \
-                      libsnappy-dev:mips64el \
-                      libsndio-dev:mips64el \
-                      libspice-protocol-dev:mips64el \
-                      libspice-server-dev:mips64el \
-                      libssh-dev:mips64el \
-                      libstd-rust-dev:mips64el \
-                      libsystemd-dev:mips64el \
-                      libtasn1-6-dev:mips64el \
-                      libudev-dev:mips64el \
-                      liburing-dev:mips64el \
-                      libusb-1.0-0-dev:mips64el \
-                      libusbredirhost-dev:mips64el \
-                      libvdeplug-dev:mips64el \
-                      libvirglrenderer-dev:mips64el \
-                      libvte-2.91-dev:mips64el \
-                      libxdp-dev:mips64el \
-                      libzstd-dev:mips64el \
-                      nettle-dev:mips64el \
-                      systemtap-sdt-dev:mips64el \
-                      zlib1g-dev:mips64el && \
-    eatmydata apt-get autoremove -y && \
-    eatmydata apt-get autoclean -y && \
-    mkdir -p /usr/local/share/meson/cross && \
-    printf "[binaries]\n\
-c = '/usr/bin/mips64el-linux-gnuabi64-gcc'\n\
-ar = '/usr/bin/mips64el-linux-gnuabi64-gcc-ar'\n\
-strip = '/usr/bin/mips64el-linux-gnuabi64-strip'\n\
-pkgconfig = '/usr/bin/mips64el-linux-gnuabi64-pkg-config'\n\
-\n\
-[host_machine]\n\
-system = 'linux'\n\
-cpu_family = 'mips64'\n\
-cpu = 'mips64el'\n\
-endian = 'little'\n" > /usr/local/share/meson/cross/mips64el-linux-gnuabi64 && \
-    dpkg-query --showformat '${Package}_${Version}_${Architecture}\n' --show > /packages.txt && \
-    mkdir -p /usr/libexec/ccache-wrappers && \
-    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/mips64el-linux-gnuabi64-cc && \
-    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/mips64el-linux-gnuabi64-gcc
-
-ENV ABI "mips64el-linux-gnuabi64"
-ENV MESON_OPTS "--cross-file=mips64el-linux-gnuabi64"
-ENV RUST_TARGET "mips64el-unknown-linux-gnuabi64"
-ENV QEMU_CONFIGURE_OPTS --cross-prefix=mips64el-linux-gnuabi64-
-ENV DEF_TARGET_LIST mips64el-softmmu,mips64el-linux-user
-# As a final step configure the user (if env is defined)
-ARG USER
-ARG UID
-RUN if [ "${USER}" ]; then \
-  id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi
diff --git a/tests/docker/dockerfiles/debian-mipsel-cross.docker b/tests/docker/dockerfiles/debian-mipsel-cross.docker
deleted file mode 100644
index 59c6f92248..0000000000
--- a/tests/docker/dockerfiles/debian-mipsel-cross.docker
+++ /dev/null
@@ -1,185 +0,0 @@
-# THIS FILE WAS AUTO-GENERATED
-#
-#  $ lcitool dockerfile --layers all --cross-arch mipsel debian-12 qemu
-#
-# https://gitlab.com/libvirt/libvirt-ci
-
-FROM docker.io/library/debian:12-slim
-
-RUN export DEBIAN_FRONTEND=noninteractive && \
-    apt-get update && \
-    apt-get install -y eatmydata && \
-    eatmydata apt-get dist-upgrade -y && \
-    eatmydata apt-get install --no-install-recommends -y \
-                      bash \
-                      bc \
-                      bindgen \
-                      bison \
-                      bsdextrautils \
-                      bzip2 \
-                      ca-certificates \
-                      ccache \
-                      dbus \
-                      debianutils \
-                      diffutils \
-                      exuberant-ctags \
-                      findutils \
-                      flex \
-                      gcc \
-                      gcovr \
-                      gettext \
-                      git \
-                      hostname \
-                      libclang-rt-dev \
-                      libglib2.0-dev \
-                      llvm \
-                      locales \
-                      make \
-                      mtools \
-                      ncat \
-                      ninja-build \
-                      openssh-client \
-                      pkgconf \
-                      python3 \
-                      python3-numpy \
-                      python3-opencv \
-                      python3-pillow \
-                      python3-pip \
-                      python3-setuptools \
-                      python3-sphinx \
-                      python3-sphinx-rtd-theme \
-                      python3-venv \
-                      python3-wheel \
-                      python3-yaml \
-                      rpm2cpio \
-                      rustc-web \
-                      sed \
-                      socat \
-                      sparse \
-                      swtpm \
-                      tar \
-                      tesseract-ocr \
-                      tesseract-ocr-eng \
-                      vulkan-tools \
-                      xorriso \
-                      zstd && \
-    eatmydata apt-get autoremove -y && \
-    eatmydata apt-get autoclean -y && \
-    sed -Ei 's,^# (en_US\.UTF-8 .*)$,\1,' /etc/locale.gen && \
-    dpkg-reconfigure locales && \
-    rm -f /usr/lib*/python3*/EXTERNALLY-MANAGED
-
-RUN /usr/bin/pip3 install meson==1.8.1
-
-ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
-ENV LANG "en_US.UTF-8"
-ENV MAKE "/usr/bin/make"
-ENV NINJA "/usr/bin/ninja"
-ENV PYTHON "/usr/bin/python3"
-
-RUN export DEBIAN_FRONTEND=noninteractive && \
-    dpkg --add-architecture mipsel && \
-    eatmydata apt-get update && \
-    eatmydata apt-get dist-upgrade -y && \
-    eatmydata apt-get install --no-install-recommends -y dpkg-dev && \
-    eatmydata apt-get install --no-install-recommends -y \
-                      gcc-mipsel-linux-gnu \
-                      libaio-dev:mipsel \
-                      libasound2-dev:mipsel \
-                      libattr1-dev:mipsel \
-                      libbpf-dev:mipsel \
-                      libbrlapi-dev:mipsel \
-                      libbz2-dev:mipsel \
-                      libc6-dev:mipsel \
-                      libcacard-dev:mipsel \
-                      libcap-ng-dev:mipsel \
-                      libcapstone-dev:mipsel \
-                      libcbor-dev:mipsel \
-                      libcmocka-dev:mipsel \
-                      libcurl4-gnutls-dev:mipsel \
-                      libdaxctl-dev:mipsel \
-                      libdrm-dev:mipsel \
-                      libepoxy-dev:mipsel \
-                      libfdt-dev:mipsel \
-                      libffi-dev:mipsel \
-                      libfuse3-dev:mipsel \
-                      libgbm-dev:mipsel \
-                      libgcrypt20-dev:mipsel \
-                      libglib2.0-dev:mipsel \
-                      libglusterfs-dev:mipsel \
-                      libgnutls28-dev:mipsel \
-                      libgtk-3-dev:mipsel \
-                      libgtk-vnc-2.0-dev:mipsel \
-                      libibverbs-dev:mipsel \
-                      libiscsi-dev:mipsel \
-                      libjemalloc-dev:mipsel \
-                      libjpeg62-turbo-dev:mipsel \
-                      libjson-c-dev:mipsel \
-                      liblttng-ust-dev:mipsel \
-                      liblzo2-dev:mipsel \
-                      libncursesw5-dev:mipsel \
-                      libnfs-dev:mipsel \
-                      libnuma-dev:mipsel \
-                      libpam0g-dev:mipsel \
-                      libpcre2-dev:mipsel \
-                      libpipewire-0.3-dev:mipsel \
-                      libpixman-1-dev:mipsel \
-                      libpng-dev:mipsel \
-                      libpulse-dev:mipsel \
-                      librbd-dev:mipsel \
-                      librdmacm-dev:mipsel \
-                      libsasl2-dev:mipsel \
-                      libsdl2-dev:mipsel \
-                      libsdl2-image-dev:mipsel \
-                      libseccomp-dev:mipsel \
-                      libselinux1-dev:mipsel \
-                      libslirp-dev:mipsel \
-                      libsnappy-dev:mipsel \
-                      libsndio-dev:mipsel \
-                      libspice-protocol-dev:mipsel \
-                      libspice-server-dev:mipsel \
-                      libssh-dev:mipsel \
-                      libstd-rust-dev:mipsel \
-                      libsystemd-dev:mipsel \
-                      libtasn1-6-dev:mipsel \
-                      libudev-dev:mipsel \
-                      liburing-dev:mipsel \
-                      libusb-1.0-0-dev:mipsel \
-                      libusbredirhost-dev:mipsel \
-                      libvdeplug-dev:mipsel \
-                      libvirglrenderer-dev:mipsel \
-                      libvte-2.91-dev:mipsel \
-                      libxdp-dev:mipsel \
-                      libzstd-dev:mipsel \
-                      nettle-dev:mipsel \
-                      systemtap-sdt-dev:mipsel \
-                      zlib1g-dev:mipsel && \
-    eatmydata apt-get autoremove -y && \
-    eatmydata apt-get autoclean -y && \
-    mkdir -p /usr/local/share/meson/cross && \
-    printf "[binaries]\n\
-c = '/usr/bin/mipsel-linux-gnu-gcc'\n\
-ar = '/usr/bin/mipsel-linux-gnu-gcc-ar'\n\
-strip = '/usr/bin/mipsel-linux-gnu-strip'\n\
-pkgconfig = '/usr/bin/mipsel-linux-gnu-pkg-config'\n\
-\n\
-[host_machine]\n\
-system = 'linux'\n\
-cpu_family = 'mips'\n\
-cpu = 'mipsel'\n\
-endian = 'little'\n" > /usr/local/share/meson/cross/mipsel-linux-gnu && \
-    dpkg-query --showformat '${Package}_${Version}_${Architecture}\n' --show > /packages.txt && \
-    mkdir -p /usr/libexec/ccache-wrappers && \
-    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/mipsel-linux-gnu-cc && \
-    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/mipsel-linux-gnu-gcc
-
-ENV ABI "mipsel-linux-gnu"
-ENV MESON_OPTS "--cross-file=mipsel-linux-gnu"
-ENV RUST_TARGET "mipsel-unknown-linux-gnu"
-ENV QEMU_CONFIGURE_OPTS --cross-prefix=mipsel-linux-gnu-
-ENV DEF_TARGET_LIST mipsel-softmmu,mipsel-linux-user
-# As a final step configure the user (if env is defined)
-ARG USER
-ARG UID
-RUN if [ "${USER}" ]; then \
-  id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi
diff --git a/tests/lcitool/libvirt-ci b/tests/lcitool/libvirt-ci
index 7a92fe388f..9da20ff7c3 160000
--- a/tests/lcitool/libvirt-ci
+++ b/tests/lcitool/libvirt-ci
@@ -1 +1 @@
-Subproject commit 7a92fe388f55d1bbc33e639e3484533f88c542ec
+Subproject commit 9da20ff7c3bc9067804a7561c2ff87583b434853
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index 6f98a91277..917ff4abfb 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -215,16 +215,6 @@ try:
                                             "x86_64-linux-user,"
                                             "i386-softmmu,i386-linux-user"))
 
-    generate_dockerfile("debian-mips64el-cross", "debian-12",
-                        cross="mips64el",
-                        trailer=cross_build("mips64el-linux-gnuabi64-",
-                                            "mips64el-softmmu,mips64el-linux-user"))
-
-    generate_dockerfile("debian-mipsel-cross", "debian-12",
-                        cross="mipsel",
-                        trailer=cross_build("mipsel-linux-gnu-",
-                                            "mipsel-softmmu,mipsel-linux-user"))
-
     generate_dockerfile("debian-ppc64el-cross", "debian-12",
                         cross="ppc64le",
                         trailer=cross_build("powerpc64le-linux-gnu-",
-- 
2.51.0


