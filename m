Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BAC9C30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 15:58:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPOm0-0000Xa-Vj; Thu, 04 Jul 2024 11:53:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sPOlz-0000XE-VS; Thu, 04 Jul 2024 11:53:27 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sPOlw-00026Q-Ic; Thu, 04 Jul 2024 11:53:27 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id F0C9A77499;
 Thu,  4 Jul 2024 18:52:46 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id B7A6BFEAE4;
 Thu,  4 Jul 2024 18:52:51 +0300 (MSK)
Received: (nullmailer pid 1481702 invoked by uid 1000);
 Thu, 04 Jul 2024 15:52:51 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.6 11/18] tests: Update our CI to use CentOS Stream 9
 instead of 8
Date: Thu,  4 Jul 2024 18:52:42 +0300
Message-Id: <20240704155251.1481617-11-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.6-20240704154854@cover.tls.msk.ru>
References: <qemu-stable-8.2.6-20240704154854@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

RHEL 9 (and thus also the derivatives) have been available since two
years now, so according to QEMU's support policy, we can drop the active
support for the previous major version 8 now.

Another reason for doing this is that Centos Stream 8 will go EOL soon:

https://blog.centos.org/2023/04/end-dates-are-coming-for-centos-stream-8-and-centos-linux-7/

  "After May 31, 2024, CentOS Stream 8 will be archived
   and no further updates will be provided."

Thus upgrade our CentOS Stream container to major version 9 now.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20240418101056.302103-5-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
(cherry picked from commit 641b1efe01b2dd6e7ac92f23d392dcee73508746)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index 96d6744525..0ac3124c23 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -158,9 +158,9 @@ build-system-centos:
     - .native_build_job_template
     - .native_build_artifact_template
   needs:
-    job: amd64-centos8-container
+    job: amd64-centos9-container
   variables:
-    IMAGE: centos8
+    IMAGE: centos9
     CONFIGURE_ARGS: --disable-nettle --enable-gcrypt --enable-vfio-user-server
       --enable-modules --enable-trace-backends=dtrace --enable-docs
     TARGETS: ppc64-softmmu or1k-softmmu s390x-softmmu
@@ -173,7 +173,7 @@ check-system-centos:
     - job: build-system-centos
       artifacts: true
   variables:
-    IMAGE: centos8
+    IMAGE: centos9
     MAKE_CHECK_ARGS: check
 
 avocado-system-centos:
@@ -182,7 +182,7 @@ avocado-system-centos:
     - job: build-system-centos
       artifacts: true
   variables:
-    IMAGE: centos8
+    IMAGE: centos9
     MAKE_CHECK_ARGS: check-avocado
     AVOCADO_TAGS: arch:ppc64 arch:or1k arch:390x arch:x86_64 arch:rx
       arch:sh4 arch:nios2
@@ -258,9 +258,9 @@ avocado-system-flaky:
 build-tcg-disabled:
   extends: .native_build_job_template
   needs:
-    job: amd64-centos8-container
+    job: amd64-centos9-container
   variables:
-    IMAGE: centos8
+    IMAGE: centos9
   script:
     - mkdir build
     - cd build
@@ -585,9 +585,9 @@ build-tci:
 build-without-defaults:
   extends: .native_build_job_template
   needs:
-    job: amd64-centos8-container
+    job: amd64-centos9-container
   variables:
-    IMAGE: centos8
+    IMAGE: centos9
     CONFIGURE_ARGS:
       --without-default-devices
       --without-default-features
diff --git a/.gitlab-ci.d/container-core.yml b/.gitlab-ci.d/container-core.yml
index 08f8450fa1..5459447676 100644
--- a/.gitlab-ci.d/container-core.yml
+++ b/.gitlab-ci.d/container-core.yml
@@ -1,10 +1,10 @@
 include:
   - local: '/.gitlab-ci.d/container-template.yml'
 
-amd64-centos8-container:
+amd64-centos9-container:
   extends: .container_job_template
   variables:
-    NAME: centos8
+    NAME: centos9
 
 amd64-fedora-container:
   extends: .container_job_template
diff --git a/tests/docker/dockerfiles/centos8.docker b/tests/docker/dockerfiles/centos9.docker
similarity index 82%
rename from tests/docker/dockerfiles/centos8.docker
rename to tests/docker/dockerfiles/centos9.docker
index d97c30e96a..9fc9b27eb7 100644
--- a/tests/docker/dockerfiles/centos8.docker
+++ b/tests/docker/dockerfiles/centos9.docker
@@ -1,15 +1,14 @@
 # THIS FILE WAS AUTO-GENERATED
 #
-#  $ lcitool dockerfile --layers all centos-stream-8 qemu
+#  $ lcitool dockerfile --layers all centos-stream-9 qemu
 #
 # https://gitlab.com/libvirt/libvirt-ci
 
-FROM quay.io/centos/centos:stream8
+FROM quay.io/centos/centos:stream9
 
 RUN dnf distro-sync -y && \
     dnf install 'dnf-command(config-manager)' -y && \
-    dnf config-manager --set-enabled -y powertools && \
-    dnf install -y centos-release-advanced-virtualization && \
+    dnf config-manager --set-enabled -y crb && \
     dnf install -y epel-release && \
     dnf install -y epel-next-release && \
     dnf install -y \
@@ -42,7 +41,6 @@ RUN dnf distro-sync -y && \
         glib2-static \
         glibc-langpack-en \
         glibc-static \
-        glusterfs-api-devel \
         gnutls-devel \
         gtk3-devel \
         hostname \
@@ -82,6 +80,7 @@ RUN dnf distro-sync -y && \
         lzo-devel \
         make \
         mesa-libgbm-devel \
+        meson \
         mtools \
         ncurses-devel \
         nettle-devel \
@@ -95,25 +94,25 @@ RUN dnf distro-sync -y && \
         pixman-devel \
         pkgconfig \
         pulseaudio-libs-devel \
-        python38 \
-        python38-PyYAML \
-        python38-numpy \
-        python38-pip \
-        python38-setuptools \
-        python38-wheel \
+        python3 \
+        python3-PyYAML \
+        python3-numpy \
+        python3-pillow \
+        python3-pip \
+        python3-sphinx \
+        python3-sphinx_rtd_theme \
+        python3-tomli \
         rdma-core-devel \
         sed \
         snappy-devel \
         socat \
         spice-protocol \
-        spice-server-devel \
         swtpm \
         systemd-devel \
         systemtap-sdt-devel \
         tar \
         usbredir-devel \
         util-linux \
-        virglrenderer-devel \
         vte291-devel \
         which \
         xfsprogs-devel \
@@ -131,18 +130,11 @@ RUN dnf distro-sync -y && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/g++ && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/gcc
 
-RUN /usr/bin/pip3.8 install \
-                    meson==0.63.2 \
-                    pillow \
-                    sphinx \
-                    sphinx-rtd-theme \
-                    tomli
-
 ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
 ENV LANG "en_US.UTF-8"
 ENV MAKE "/usr/bin/make"
 ENV NINJA "/usr/bin/ninja"
-ENV PYTHON "/usr/bin/python3.8"
+ENV PYTHON "/usr/bin/python3"
 # As a final step configure the user (if env is defined)
 ARG USER
 ARG UID
diff --git a/tests/lcitool/mappings.yml b/tests/lcitool/mappings.yml
index 407c03301b..03b974ad02 100644
--- a/tests/lcitool/mappings.yml
+++ b/tests/lcitool/mappings.yml
@@ -1,66 +1,50 @@
 mappings:
   flake8:
-    CentOSStream8:
     OpenSUSELeap15:
 
   meson:
-    CentOSStream8:
     OpenSUSELeap15:
 
   python3:
-    CentOSStream8: python38
     OpenSUSELeap15: python311-base
 
   python3-PyYAML:
-    CentOSStream8: python38-PyYAML
     OpenSUSELeap15:
 
   python3-devel:
-    CentOSStream8: python38-devel
     OpenSUSELeap15: python311-devel
 
   python3-docutils:
-    CentOSStream8:
     OpenSUSELeap15:
 
   python3-numpy:
-    CentOSStream8: python38-numpy
     OpenSUSELeap15:
 
   python3-opencv:
-    CentOSStream8:
     OpenSUSELeap15:
 
   python3-pillow:
-    CentOSStream8:
     OpenSUSELeap15:
 
   python3-pip:
-    CentOSStream8: python38-pip
     OpenSUSELeap15: python311-pip
 
   python3-pillow:
-    CentOSStream8:
     OpenSUSELeap15:
 
   python3-selinux:
-    CentOSStream8:
     OpenSUSELeap15:
 
   python3-setuptools:
-    CentOSStream8: python38-setuptools
     OpenSUSELeap15: python311-setuptools
 
   python3-sphinx:
-    CentOSStream8:
     OpenSUSELeap15:
 
   python3-sphinx-rtd-theme:
-    CentOSStream8:
     OpenSUSELeap15:
 
   python3-sqlite3:
-    CentOSStream8: python38
     OpenSUSELeap15: python311
 
   python3-tomli:
@@ -69,15 +53,11 @@ mappings:
     Fedora:
     Debian12:
     OpenSUSELeap15:
-    # Not available for Python 3.8
-    CentOSStream8:
 
   python3-venv:
-    CentOSStream8: python38
     OpenSUSELeap15: python311-base
 
   python3-wheel:
-    CentOSStream8: python38-wheel
     OpenSUSELeap15: python311-pip
 
 pypi_mappings:
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index 0c93557ad6..767fa312de 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -125,7 +125,7 @@ try:
     # Standard native builds
     #
     generate_dockerfile("alpine", "alpine-318")
-    generate_dockerfile("centos8", "centos-stream-8")
+    generate_dockerfile("centos9", "centos-stream-9")
     generate_dockerfile("debian", "debian-12",
                         trailer="".join(debian12_extras))
     generate_dockerfile("fedora", "fedora-38")
diff --git a/tests/vm/centos b/tests/vm/centos
index 097a9ca14d..d25c8f8b5b 100755
--- a/tests/vm/centos
+++ b/tests/vm/centos
@@ -26,8 +26,8 @@ class CentosVM(basevm.BaseVM):
         export SRC_ARCHIVE=/dev/vdb;
         sudo chmod a+r $SRC_ARCHIVE;
         tar -xf $SRC_ARCHIVE;
-        make docker-test-block@centos8 {verbose} J={jobs} NETWORK=1;
-        make docker-test-quick@centos8 {verbose} J={jobs} NETWORK=1;
+        make docker-test-block@centos9 {verbose} J={jobs} NETWORK=1;
+        make docker-test-quick@centos9 {verbose} J={jobs} NETWORK=1;
     """
 
     def build_image(self, img):
-- 
2.39.2


