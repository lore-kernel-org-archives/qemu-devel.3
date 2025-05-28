Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FC6BC5AE59
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 07:55:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKBcK-0006yG-Su; Wed, 28 May 2025 03:54:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uKBcG-0006xW-R9; Wed, 28 May 2025 03:54:24 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uKBcE-0001zj-Es; Wed, 28 May 2025 03:54:24 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D3C53125B4E;
 Wed, 28 May 2025 10:54:06 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 9E33E21846A;
 Wed, 28 May 2025 10:54:12 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [Stable-10.0.2] Revert "Drop support for Python 3.8"
Date: Wed, 28 May 2025 10:53:44 +0300
Message-Id: <20250528075408.34066-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-10.0.2-20250528105127@cover.tls.msk.ru>
References: <qemu-stable-10.0.2-20250528105127@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This reverts commit 3d5b2f81fbc6b96b70271af1820674731a441ff7.

It should not be in 10.0.x branch, since we do support python 3.8
in 10.0.

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/configure b/configure
index a2f5597fa0..02f1dd2311 100755
--- a/configure
+++ b/configure
@@ -540,17 +540,17 @@ if test -n "$linux_arch" && ! test -d "$source_path/linux-headers/asm-$linux_arc
 fi
 
 check_py_version() {
-    # We require python >= 3.9.
+    # We require python >= 3.8.
     # NB: a True python conditional creates a non-zero return code (Failure)
-    "$1" -c 'import sys; sys.exit(sys.version_info < (3,9))'
+    "$1" -c 'import sys; sys.exit(sys.version_info < (3,8))'
 }
 
 first_python=
 if test -z "${PYTHON}"; then
     # A bare 'python' is traditionally python 2.x, but some distros
     # have it as python 3.x, so check in both places.
-    for binary in python3 python python3.13 python3.12 python3.11 \
-                          python3.10 python3.9 ; do
+    for binary in python3 python python3.12 python3.11 \
+                          python3.10 python3.9 python3.8; do
         if has "$binary"; then
             python=$(command -v "$binary")
             if check_py_version "$python"; then
@@ -933,7 +933,7 @@ then
     # If first_python is set, there was a binary somewhere even though
     # it was not suitable.  Use it for the error message.
     if test -n "$first_python"; then
-        error_exit "Cannot use '$first_python', Python >= 3.9 is required." \
+        error_exit "Cannot use '$first_python', Python >= 3.8 is required." \
             "Use --python=/path/to/python to specify a supported Python."
     else
         error_exit "Python not found. Use --python=/path/to/python"
@@ -941,11 +941,11 @@ then
 fi
 
 if ! check_py_version "$python"; then
-  error_exit "Cannot use '$python', Python >= 3.9 is required." \
+  error_exit "Cannot use '$python', Python >= 3.8 is required." \
              "Use --python=/path/to/python to specify a supported Python." \
              "Maybe try:" \
              "  openSUSE Leap 15.3+: zypper install python39" \
-             "  CentOS: dnf install python3.12"
+             "  CentOS 8: dnf install python38"
 fi
 
 # Resolve PATH
diff --git a/docs/about/build-platforms.rst b/docs/about/build-platforms.rst
index c352a99544..1552b1a704 100644
--- a/docs/about/build-platforms.rst
+++ b/docs/about/build-platforms.rst
@@ -101,7 +101,7 @@ Python runtime
   option of the ``configure`` script to point QEMU to a supported
   version of the Python runtime.
 
-  As of QEMU |version|, the minimum supported version of Python is 3.9.
+  As of QEMU |version|, the minimum supported version of Python is 3.8.
 
 Python build dependencies
   Some of QEMU's build dependencies are written in Python.  Usually these
diff --git a/python/Makefile b/python/Makefile
index 764b79ccb2..1fa4ba2498 100644
--- a/python/Makefile
+++ b/python/Makefile
@@ -9,13 +9,13 @@ help:
 	@echo "make check-minreqs:"
 	@echo "    Run tests in the minreqs virtual environment."
 	@echo "    These tests use the oldest dependencies."
-	@echo "    Requires: Python 3.9"
-	@echo "    Hint (Fedora): 'sudo dnf install python3.9'"
+	@echo "    Requires: Python 3.8"
+	@echo "    Hint (Fedora): 'sudo dnf install python3.8'"
 	@echo ""
 	@echo "make check-tox:"
 	@echo "    Run tests against multiple python versions."
 	@echo "    These tests use the newest dependencies."
-	@echo "    Requires: Python 3.9 - 3.11, and tox."
+	@echo "    Requires: Python 3.8 - 3.11, and tox."
 	@echo "    Hint (Fedora): 'sudo dnf install python3-tox python3.11'"
 	@echo "    The variable QEMU_TOX_EXTRA_ARGS can be use to pass extra"
 	@echo "    arguments to tox".
@@ -59,7 +59,7 @@ PIP_INSTALL = pip install --disable-pip-version-check
 min-venv: $(QEMU_MINVENV_DIR) $(QEMU_MINVENV_DIR)/bin/activate
 $(QEMU_MINVENV_DIR) $(QEMU_MINVENV_DIR)/bin/activate: setup.cfg tests/minreqs.txt
 	@echo "VENV $(QEMU_MINVENV_DIR)"
-	@python3.9 -m venv $(QEMU_MINVENV_DIR)
+	@python3.8 -m venv $(QEMU_MINVENV_DIR)
 	@(								\
 		echo "ACTIVATE $(QEMU_MINVENV_DIR)";			\
 		. $(QEMU_MINVENV_DIR)/bin/activate;			\
diff --git a/python/setup.cfg b/python/setup.cfg
index c48dff280a..cf5af7e664 100644
--- a/python/setup.cfg
+++ b/python/setup.cfg
@@ -14,6 +14,7 @@ classifiers =
     Natural Language :: English
     Operating System :: OS Independent
     Programming Language :: Python :: 3 :: Only
+    Programming Language :: Python :: 3.8
     Programming Language :: Python :: 3.9
     Programming Language :: Python :: 3.10
     Programming Language :: Python :: 3.11
@@ -22,7 +23,7 @@ classifiers =
     Typing :: Typed
 
 [options]
-python_requires = >= 3.9
+python_requires = >= 3.8
 packages =
     qemu.qmp
     qemu.machine
@@ -77,7 +78,7 @@ exclude = __pycache__,
 
 [mypy]
 strict = True
-python_version = 3.9
+python_version = 3.8
 warn_unused_configs = True
 namespace_packages = True
 warn_unused_ignores = False
@@ -185,7 +186,7 @@ multi_line_output=3
 # of python available on your system to run this test.
 
 [tox:tox]
-envlist = py39, py310, py311, py312, py313
+envlist = py38, py39, py310, py311, py312, py313
 skip_missing_interpreters = true
 
 [testenv]
diff --git a/python/tests/minreqs.txt b/python/tests/minreqs.txt
index 6445407ba8..a3f423efd8 100644
--- a/python/tests/minreqs.txt
+++ b/python/tests/minreqs.txt
@@ -1,5 +1,5 @@
 # This file lists the ***oldest possible dependencies*** needed to run
-# "make check" successfully under ***Python 3.9***. It is used primarily
+# "make check" successfully under ***Python 3.8***. It is used primarily
 # by GitLab CI to ensure that our stated minimum versions in setup.cfg
 # are truthful and regularly validated.
 #
diff --git a/scripts/qapi/mypy.ini b/scripts/qapi/mypy.ini
index c9dbcec2db..8109470a03 100644
--- a/scripts/qapi/mypy.ini
+++ b/scripts/qapi/mypy.ini
@@ -1,4 +1,4 @@
 [mypy]
 strict = True
 disallow_untyped_calls = False
-python_version = 3.9
+python_version = 3.8
diff --git a/tests/docker/dockerfiles/python.docker b/tests/docker/dockerfiles/python.docker
index 59e70a0248..8f0af9ef25 100644
--- a/tests/docker/dockerfiles/python.docker
+++ b/tests/docker/dockerfiles/python.docker
@@ -15,6 +15,7 @@ ENV PACKAGES \
     python3.11 \
     python3.12 \
     python3.13 \
+    python3.8 \
     python3.9
 
 RUN dnf install -y $PACKAGES
-- 
2.39.5


