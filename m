Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B370BC3271E
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 12:49:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPLtm-0004gQ-C4; Thu, 04 Jul 2024 08:49:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sPLtd-0004Vn-59; Thu, 04 Jul 2024 08:49:09 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sPLta-0006Tg-7H; Thu, 04 Jul 2024 08:49:08 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 66969773A2;
 Thu,  4 Jul 2024 15:48:22 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id F28EDFE787;
 Thu,  4 Jul 2024 15:48:26 +0300 (MSK)
Received: (nullmailer pid 1471789 invoked by uid 1000);
 Thu, 04 Jul 2024 12:48:26 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.13 08/17] ci,
 docker: update CentOS and OpenSUSE Python to non-EOL versions
Date: Thu,  4 Jul 2024 15:48:15 +0300
Message-Id: <20240704124826.1471715-8-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.13-20240704143502@cover.tls.msk.ru>
References: <qemu-stable-7.2.13-20240704143502@cover.tls.msk.ru>
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

From: Paolo Bonzini <pbonzini@redhat.com>

Python 3.6 is at end-of-life.  Update the libvirt-ci module to a
version that supports overrides for targets and package mappings;
this way, QEMU can use the newer versions provided by CentOS 8 (Python
3.8) and OpenSUSE 15.3 (Python 3.9).

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit d639cf79783a1eba349b7705e0fb270fa76118a4)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
index 98c26ecf18..b4c99be195 100644
--- a/docs/devel/testing.rst
+++ b/docs/devel/testing.rst
@@ -473,6 +473,12 @@ thus some extra preparation steps will be required first
    the ``libvirt-ci`` submodule to point to a commit that contains
    the ``mappings.yml`` update.
 
+For enterprise distros that default to old, end-of-life versions of the
+Python runtime, QEMU uses a separate set of mappings that work with more
+recent versions.  These can be found in ``tests/lcitool/mappings.yml``.
+Modifying this file should not be necessary unless the new pre-requisite
+is a Python library or tool.
+
 
 Adding new OS distros
 ^^^^^^^^^^^^^^^^^^^^^
diff --git a/tests/docker/dockerfiles/centos8.docker b/tests/docker/dockerfiles/centos8.docker
index 1f70d41aeb..cc09402eb3 100644
--- a/tests/docker/dockerfiles/centos8.docker
+++ b/tests/docker/dockerfiles/centos8.docker
@@ -82,7 +82,6 @@ RUN dnf distro-sync -y && \
         lzo-devel \
         make \
         mesa-libgbm-devel \
-        meson \
         ncurses-devel \
         nettle-devel \
         ninja-build \
@@ -95,13 +94,12 @@ RUN dnf distro-sync -y && \
         pixman-devel \
         pkgconfig \
         pulseaudio-libs-devel \
-        python3 \
-        python3-PyYAML \
-        python3-numpy \
-        python3-pillow \
-        python3-pip \
-        python3-sphinx \
-        python3-sphinx_rtd_theme \
+        python38 \
+        python38-PyYAML \
+        python38-numpy \
+        python38-pip \
+        python38-setuptools \
+        python38-wheel \
         rdma-core-devel \
         rpm \
         sed \
@@ -130,8 +128,14 @@ RUN dnf distro-sync -y && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/g++ && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/gcc
 
+RUN /usr/bin/pip3.8 install \
+                    meson==0.63.2 \
+                    pillow \
+                    sphinx \
+                    sphinx-rtd-theme
+
 ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
 ENV LANG "en_US.UTF-8"
 ENV MAKE "/usr/bin/make"
 ENV NINJA "/usr/bin/ninja"
-ENV PYTHON "/usr/bin/python3"
+ENV PYTHON "/usr/bin/python3.8"
diff --git a/tests/docker/dockerfiles/opensuse-leap.docker b/tests/docker/dockerfiles/opensuse-leap.docker
index 4361b01464..4f1191dc05 100644
--- a/tests/docker/dockerfiles/opensuse-leap.docker
+++ b/tests/docker/dockerfiles/opensuse-leap.docker
@@ -90,16 +90,9 @@ RUN zypper update -y && \
            pcre-devel-static \
            perl-base \
            pkgconfig \
-           python3-Pillow \
-           python3-PyYAML \
-           python3-Sphinx \
-           python3-base \
-           python3-numpy \
-           python3-opencv \
-           python3-pip \
-           python3-setuptools \
-           python3-sphinx_rtd_theme \
-           python3-wheel \
+           python39-base \
+           python39-pip \
+           python39-setuptools \
            rdma-core-devel \
            rpm \
            sed \
@@ -131,10 +124,15 @@ RUN zypper update -y && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/g++ && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/gcc
 
-RUN /usr/bin/pip3 install meson==0.56.0
+RUN /usr/bin/pip3.9 install \
+                    PyYAML \
+                    meson==0.63.2 \
+                    pillow \
+                    sphinx \
+                    sphinx-rtd-theme
 
 ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
 ENV LANG "en_US.UTF-8"
 ENV MAKE "/usr/bin/make"
 ENV NINJA "/usr/bin/ninja"
-ENV PYTHON "/usr/bin/python3"
+ENV PYTHON "/usr/bin/python3.9"
diff --git a/tests/docker/dockerfiles/ubuntu2004.docker b/tests/docker/dockerfiles/ubuntu2004.docker
index 9417bca2fa..39c744eba9 100644
--- a/tests/docker/dockerfiles/ubuntu2004.docker
+++ b/tests/docker/dockerfiles/ubuntu2004.docker
@@ -140,7 +140,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/g++ && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/gcc
 
-RUN /usr/bin/pip3 install meson==0.56.0
+RUN /usr/bin/pip3 install meson==0.63.2
 
 ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
 ENV LANG "en_US.UTF-8"
diff --git a/tests/lcitool/mappings.yml b/tests/lcitool/mappings.yml
new file mode 100644
index 0000000000..e4719e4551
--- /dev/null
+++ b/tests/lcitool/mappings.yml
@@ -0,0 +1,77 @@
+mappings:
+  flake8:
+    CentOSStream8:
+    OpenSUSELeap153:
+
+  meson:
+    CentOSStream8:
+    OpenSUSELeap153:
+
+  python3:
+    CentOSStream8: python38
+    OpenSUSELeap153: python39-base
+
+  python3-PyYAML:
+    CentOSStream8: python38-PyYAML
+    OpenSUSELeap153:
+
+  python3-devel:
+    CentOSStream8: python38-devel
+    OpenSUSELeap153: python39-devel
+
+  python3-docutils:
+    CentOSStream8:
+    OpenSUSELeap153:
+
+  python3-numpy:
+    CentOSStream8: python38-numpy
+    OpenSUSELeap153:
+
+  python3-opencv:
+    CentOSStream8:
+    OpenSUSELeap153:
+
+  python3-pillow:
+    CentOSStream8:
+    OpenSUSELeap153:
+
+  python3-pip:
+    CentOSStream8: python38-pip
+    OpenSUSELeap153: python39-pip
+
+  python3-pillow:
+    CentOSStream8:
+    OpenSUSELeap153:
+
+  python3-selinux:
+    CentOSStream8:
+    OpenSUSELeap153:
+
+  python3-setuptools:
+    CentOSStream8: python38-setuptools
+    OpenSUSELeap153: python39-setuptools
+
+  python3-sphinx:
+    CentOSStream8:
+    OpenSUSELeap153:
+
+  python3-sphinx-rtd-theme:
+    CentOSStream8:
+    OpenSUSELeap153:
+
+  python3-venv:
+    CentOSStream8: python38
+    OpenSUSELeap153: python39-base
+
+  python3-wheel:
+    CentOSStream8: python38-wheel
+    OpenSUSELeap153: python39-pip
+
+pypi_mappings:
+  # Request more recent version
+  meson:
+    default: meson==0.63.2
+
+  # Drop packages that need devel headers
+  python3-numpy:
+    OpenSUSELeap153:
diff --git a/tests/lcitool/targets/centos-stream-8.yml b/tests/lcitool/targets/centos-stream-8.yml
new file mode 100644
index 0000000000..6b11160fd1
--- /dev/null
+++ b/tests/lcitool/targets/centos-stream-8.yml
@@ -0,0 +1,3 @@
+paths:
+  pip3: /usr/bin/pip3.8
+  python: /usr/bin/python3.8
diff --git a/tests/lcitool/targets/opensuse-leap-153.yml b/tests/lcitool/targets/opensuse-leap-153.yml
new file mode 100644
index 0000000000..683016e007
--- /dev/null
+++ b/tests/lcitool/targets/opensuse-leap-153.yml
@@ -0,0 +1,3 @@
+paths:
+  pip3: /usr/bin/pip3.9
+  python: /usr/bin/python3.9
-- 
2.39.2


