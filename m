Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 767D0C61DBD
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 21:59:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyzBM-00062z-SF; Tue, 25 Aug 2026 17:59:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wyzBL-000622-RB
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 17:59:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wyzBJ-0000Oa-HP
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 17:59:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787695184;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1/LvuhIQ2HlgnbwtwO5LLJPOO7VGQBVamf0yaB6bBDI=;
 b=OGEQSmZdMc9A+7sKRDB1mnp7rxfTf0LVG6Uv6Etj5oRRxfK+O7oUHZ48XOzpAlWsojWz1J
 wxp5WST9UnkaTRAoh3utXjL/5AYqaI53odlfGoGg2PYU2FO9DOgAa7yhoRVt8tRC9s3wCh
 n6VuibrolM7eV5TDrwTvvhnPn5gIukc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-266-QYjMbmT4M6ache3WVvUgbw-1; Tue,
 25 Aug 2026 17:59:40 -0400
X-MC-Unique: QYjMbmT4M6ache3WVvUgbw-1
X-Mimecast-MFC-AGG-ID: QYjMbmT4M6ache3WVvUgbw_1787695178
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 756C718C104C; Tue, 25 Aug 2026 21:59:38 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.17])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4F1F919560AB; Tue, 25 Aug 2026 21:59:34 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Michael Roth <michael.roth@amd.com>, Reinoud Zandijk <reinoud@netbsd.org>,
 Kyle Evans <kevans@freebsd.org>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 09/16] python: upgrade to Python3.12+
Date: Tue, 25 Aug 2026 17:58:44 -0400
Message-ID: <20260825215851.1780608-10-jsnow@redhat.com>
In-Reply-To: <20260825215851.1780608-1-jsnow@redhat.com>
References: <20260825215851.1780608-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

With Python3.9 EOL and Python3.10 soon to be EOL (October 2026), and
with ... no other supported build platform actually using Python 3.11,
require the use of Python3.12 or later.

Additionally, as part of this upgrade, remove the use of tomllib from
mkvenv as it is now standard in the Python stdlib: leaving this
transitional code in causes a regression with mypy which becomes
confused about the overloaded use of 'tomllib'.

Our current minimum requirements as determined by standard repository
packages on supported distributions is as follows:

distro            EOS         python3  pip     setuptools  sphinx  wheel
-------------------------------------------------------------------------
centos_stream_9   2026-12-12  3.9.25   21.3.1  53.0.0      3.4.3   0.36.2
centos_stream_9+  2026-12-12  3.12.13  23.2.1  68.2.2      ---     0.41.2
freebsd           --          3.12.14  23.3.2  63.1.0      9.0.4   0.48.0
ubuntu_24_04      2028-04-23  3.12.3   24.0    68.1.2      7.2.6   0.42.0
centos_stream_10  2030-01-01  3.12.13  23.3.2  69.0.3      7.2.6   0.41.2
alpine_3_21       2026-11-01  3.12.14  24.3.1  70.3.0      8.1.3   0.43.0
debian_13         2028-08-09  3.13.5   25.1.1  78.1.1      8.1.3   0.46.1
fedora_43         2026-12-09  3.14.7   25.1.1  78.1.1      8.2.3   0.45.1
ubuntu_26_04      2031-05-29  3.14.4   25.1.1  78.1.1      8.2.3   0.46.3
fedora_44         2027-06-02  3.14.7   26.0.1  80.10.2     8.2.3   0.45.1
macports          --          3.14.7   26.0.1  80.10.2     9.1.0   0.48.0
alpine_3_22       2027-05-01  3.12.14  25.1.1  80.9.0      8.2.3   0.46.3
alpine_3_23       2027-11-01  3.12.14  25.1.1  80.9.0      8.2.3   0.46.3
openbsd           --          3.14.6   26.2.1  80.9.0      9.1.0   0.48.0
alpine_3_24       2028-06-01  3.14.7   26.1.2  82.0.1      9.1.0   0.47.0
pkgsrc_current    --          3.13.15  26.2.1  84.0.0      9.1.0   0.48.0

CentOS stream 9 note: python3.12, python3.12-pip,
python3.12-setuptools and python3.12-wheel are available as optional
packages in the standard repository. Sphinx is not available, but can
be side-loaded from PyPI using pip3.12.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 configure                | 11 ++++---
 python/Makefile          | 10 +++----
 python/scripts/mkvenv.py | 63 ++++------------------------------------
 python/setup.cfg         | 17 ++++-------
 python/tests/minreqs.txt | 41 ++++++++++++--------------
 pythondeps.toml          |  9 ++----
 6 files changed, 43 insertions(+), 108 deletions(-)

diff --git a/configure b/configure
index 56158cd95f7..46cbcc085b3 100755
--- a/configure
+++ b/configure
@@ -503,17 +503,16 @@ if test -n "$linux_arch" && ! test -d "$source_path/linux-headers/asm-$linux_arc
 fi
 
 check_py_version() {
-    # We require python >= 3.9.
+    # We require python >= 3.12.
     # NB: a True python conditional creates a non-zero return code (Failure)
-    "$1" -c 'import sys; sys.exit(sys.version_info < (3,9))'
+    "$1" -c 'import sys; sys.exit(sys.version_info < (3,12))'
 }
 
 first_python=
 if test -z "${PYTHON}"; then
     # A bare 'python' is traditionally python 2.x, but some distros
     # have it as python 3.x, so check in both places.
-    for binary in python3 python python3.14 python3.13 python3.12 \
-                          python3.11 python3.10 python3.9 ; do
+    for binary in python3 python python3.14 python3.13 python3.12; do
         if has "$binary"; then
             python=$(command -v "$binary")
             if check_py_version "$python"; then
@@ -902,7 +901,7 @@ then
     # If first_python is set, there was a binary somewhere even though
     # it was not suitable.  Use it for the error message.
     if test -n "$first_python"; then
-        error_exit "Cannot use '$first_python', Python >= 3.9 is required." \
+        error_exit "Cannot use '$first_python', Python >= 3.12 is required." \
             "Use --python=/path/to/python to specify a supported Python."
     else
         error_exit "Python not found. Use --python=/path/to/python"
@@ -910,7 +909,7 @@ then
 fi
 
 if ! check_py_version "$python"; then
-  error_exit "Cannot use '$python', Python >= 3.9 is required." \
+  error_exit "Cannot use '$python', Python >= 3.12 is required." \
              "Use --python=/path/to/python to specify a supported Python." \
              "Maybe try:" \
              "  CentOS: dnf install python3.12"
diff --git a/python/Makefile b/python/Makefile
index 42994d39618..7868a48a232 100644
--- a/python/Makefile
+++ b/python/Makefile
@@ -9,14 +9,14 @@ help:
 	@echo "make check-minreqs:"
 	@echo "    Run tests in the minreqs virtual environment."
 	@echo "    These tests use the oldest dependencies."
-	@echo "    Requires: Python 3.9"
-	@echo "    Hint (Fedora): 'sudo dnf install python3.9'"
+	@echo "    Requires: Python 3.12"
+	@echo "    Hint (Fedora): 'sudo dnf install python3.12'"
 	@echo ""
 	@echo "make check-tox:"
 	@echo "    Run tests against multiple python versions."
 	@echo "    These tests use the newest dependencies."
-	@echo "    Requires: Python 3.9 - 3.11, and tox."
-	@echo "    Hint (Fedora): 'sudo dnf install python3-tox python3.11'"
+	@echo "    Requires: Python 3.12 - 3.14, and tox."
+	@echo "    Hint (Fedora): 'sudo dnf install python3-tox python3.14'"
 	@echo "    The variable QEMU_TOX_EXTRA_ARGS can be use to pass extra"
 	@echo "    arguments to tox".
 	@echo ""
@@ -59,7 +59,7 @@ PIP_INSTALL = pip install --disable-pip-version-check
 min-venv: $(QEMU_MINVENV_DIR) $(QEMU_MINVENV_DIR)/bin/activate
 $(QEMU_MINVENV_DIR) $(QEMU_MINVENV_DIR)/bin/activate: setup.cfg tests/minreqs.txt
 	@echo "VENV $(QEMU_MINVENV_DIR)"
-	@python3.9 -m venv $(QEMU_MINVENV_DIR)
+	@python3.12 -m venv $(QEMU_MINVENV_DIR)
 	@(								\
 		echo "ACTIVATE $(QEMU_MINVENV_DIR)";			\
 		. $(QEMU_MINVENV_DIR)/bin/activate;			\
diff --git a/python/scripts/mkvenv.py b/python/scripts/mkvenv.py
index 8ed6a354505..e3954bb6d60 100644
--- a/python/scripts/mkvenv.py
+++ b/python/scripts/mkvenv.py
@@ -75,6 +75,7 @@
 import subprocess
 import sys
 import sysconfig
+import tomllib
 from types import SimpleNamespace
 from typing import (
     Any,
@@ -134,20 +135,6 @@
 HAVE_PACKAGING_VERSION = _import_ok
 
 
-# Try to load tomllib, with a fallback to tomli.
-# HAVE_TOMLLIB is checked below, just-in-time, so that mkvenv does not fail
-# outside the venv or before a potential call to ensurepip in checkpip().
-_import_ok = True
-try:
-    import tomllib
-except ImportError:
-    try:
-        import tomli as tomllib
-    except ImportError:
-        _import_ok = False
-
-HAVE_TOMLLIB = _import_ok
-
 # Do not add any mandatory dependencies from outside the stdlib:
 # This script *must* be usable standalone!
 
@@ -261,36 +248,6 @@ def get_parent_libpath(self) -> Optional[str]:
             return sysconfig.get_path("purelib")
         return None
 
-    @staticmethod
-    def compute_venv_libpath(context: SimpleNamespace) -> str:
-        """
-        Compatibility wrapper for context.lib_path for Python < 3.12
-        """
-        # Python 3.12+, not strictly necessary because it's documented
-        # to be the same as 3.10 code below:
-        if sys.version_info >= (3, 12):
-            return context.lib_path
-
-        # Python 3.10+
-        if "venv" in sysconfig.get_scheme_names():
-            lib_path = sysconfig.get_path(
-                "purelib", scheme="venv", vars={"base": context.env_dir}
-            )
-            assert lib_path is not None
-            return lib_path
-
-        # For Python <= 3.9 we need to hardcode this. Fortunately the
-        # code below was the same in Python 3.6-3.10, so there is only
-        # one case.
-        if sys.platform == "win32":
-            return os.path.join(context.env_dir, "Lib", "site-packages")
-        return os.path.join(
-            context.env_dir,
-            "lib",
-            "python%d.%d" % sys.version_info[:2],
-            "site-packages",
-        )
-
     def ensure_directories(self, env_dir: DirType) -> SimpleNamespace:
         logger.debug("ensure_directories(env_dir=%s)", env_dir)
         self._context = super().ensure_directories(env_dir)
@@ -313,7 +270,8 @@ def post_post_setup(self, context: SimpleNamespace) -> None:
             assert parent_libpath is not None
             logger.debug("parent_libpath: %s", parent_libpath)
 
-            our_libpath = self.compute_venv_libpath(context)
+            assert isinstance(context.lib_path, str)
+            our_libpath = context.lib_path
             logger.debug("our_libpath: %s", our_libpath)
 
             pth_file = os.path.join(our_libpath, "nested.pth")
@@ -810,19 +768,8 @@ def _do_ensure(
 
 
 def _parse_groups(file: str) -> Dict[str, Dict[str, Any]]:
-    if not HAVE_TOMLLIB:
-        if sys.version_info < (3, 11):
-            raise Ouch("found no usable tomli, please install it")
-
-        raise Ouch(
-            "Python >=3.11 does not have tomllib... what have you done!?"
-        )
-
-    # Use loads() to support both tomli v1.2.x (Ubuntu 22.04,
-    # Debian bullseye-backports) and v2.0.x
-    with open(file, "r", encoding="ascii") as depfile:
-        contents = depfile.read()
-        return tomllib.loads(contents)  # type: ignore
+    with open(file, "rb") as depfile:
+        return tomllib.load(depfile)
 
 
 def ensure_group(
diff --git a/python/setup.cfg b/python/setup.cfg
index ad4121a58d8..8f62b7c1cdb 100644
--- a/python/setup.cfg
+++ b/python/setup.cfg
@@ -14,16 +14,13 @@ classifiers =
     Natural Language :: English
     Operating System :: OS Independent
     Programming Language :: Python :: 3 :: Only
-    Programming Language :: Python :: 3.9
-    Programming Language :: Python :: 3.10
-    Programming Language :: Python :: 3.11
     Programming Language :: Python :: 3.12
     Programming Language :: Python :: 3.13
     Programming Language :: Python :: 3.14
     Typing :: Typed
 
 [options]
-python_requires = >= 3.9
+python_requires = >= 3.12
 packages =
     qemu.machine
     qemu.utils
@@ -39,12 +36,10 @@ devel =
     distlib >= 0.3.6
     flake8 >= 5.0.4
     fusepy >= 2.0.4
-    isort >= 5.6.0
-    # Max ver is temporary until we drop 3.9
-    mypy >= 1.4.0, <2.0.0
+    isort >= 5.11.3
+    mypy >= 1.4.0
     pylint >= 2.17.3
-    pylint != 3.2.4; python_version<"3.9"
-    pytest >= 6.0.2
+    pytest >= 6.2.4
     tox >= 3.18.0
     sphinx >= 3.4.3
 
@@ -69,7 +64,7 @@ exclude = __pycache__,
 
 [mypy]
 strict = True
-python_version = 3.9
+python_version = 3.12
 namespace_packages = True
 warn_unused_ignores = False
 
@@ -164,7 +159,7 @@ multi_line_output=3
 # of python available on your system to run this test.
 
 [tox:tox]
-envlist = py39, py310, py311, py312, py313, py314
+envlist = py312, py313, py314
 skip_missing_interpreters = true
 
 [testenv]
diff --git a/python/tests/minreqs.txt b/python/tests/minreqs.txt
index 05c3bdb89f8..85cfa08cf76 100644
--- a/python/tests/minreqs.txt
+++ b/python/tests/minreqs.txt
@@ -1,5 +1,5 @@
 # This file lists the ***oldest possible dependencies*** needed to run
-# "make check" successfully under ***Python 3.9***. It is used primarily
+# "make check" successfully under ***Python 3.12***. It is used primarily
 # by GitLab CI to ensure that our stated minimum versions in setup.cfg
 # are truthful and regularly validated.
 #
@@ -11,18 +11,11 @@
 # When adding new dependencies, pin the very oldest non-yanked version
 # on PyPI that allows the test suite to pass.
 
-# For some reason, the presence of packaging==14.0 below requires us to
-# also pin setuptools to version 70 or below. Otherwise, the
-# installation of the QEMU package itself fails, failing to find
-# setuptools.
-setuptools<=70
-wheel==0.34.2
-
 # Dependencies for qapidoc/qapi_domain et al
 sphinx==3.4.3
 
 # Dependencies for qemu.machine
-qemu.qmp==0.0.5
+qemu.qmp==0.0.6
 
 # Dependencies for mkvenv
 distlib==0.3.6
@@ -31,32 +24,28 @@ distlib==0.3.6
 fusepy==2.0.4
 
 # Test-runners, utilities, etc.
-pytest==6.0.2
+pytest==6.2.4
 
 # Linters
-flake8==5.0.4
-isort==5.6.0
+flake8==6.1.0
+isort==5.11.3
 mypy==1.4.0
-pylint==2.17.3
+pylint==3.0.0
 
 # Transitive flake8 dependencies
 mccabe==0.7.0
-pycodestyle==2.9.1
-pyflakes==2.5.0
+pycodestyle==2.11.0
+pyflakes==3.1.0
 
 # Transitive mypy dependencies
 mypy-extensions==1.0.0
-tomli==1.1.0
 typing-extensions==4.7.1
 
 # Transitive pylint dependencies
-astroid==2.15.4
-dill==0.2
-lazy-object-proxy==1.4.0
+astroid==3.0.0
+dill==0.3.7
 platformdirs==2.2.0
-toml==0.10.0
 tomlkit==0.10.1
-wrapt==1.14.0
 
 # Transitive sphinx dependencies
 Jinja2==2.7
@@ -66,7 +55,8 @@ babel==1.3
 docutils==0.12
 imagesize==0.5.0
 packaging==14.0
-pytz==2011b0
+Pygments==2.0
+pytz==2014.9
 requests==2.5.0
 snowballstemmer==1.1
 sphinxcontrib-applehelp==1.0.0
@@ -75,3 +65,10 @@ sphinxcontrib-htmlhelp==1.0.0
 sphinxcontrib-jsmath==1.0.0
 sphinxcontrib-qthelp==1.0.0
 sphinxcontrib-serializinghtml==1.0.0
+
+# Transitive pytest dependencies
+attrs==19.2.0
+iniconfig==1.0.0
+pluggy==0.13
+py==1.11.0
+toml==0.10.0
diff --git a/pythondeps.toml b/pythondeps.toml
index 061f0cff0c4..b1879c1a4da 100644
--- a/pythondeps.toml
+++ b/pythondeps.toml
@@ -38,14 +38,11 @@ sphinx_rtd_theme = { accepted = ">=0.5", installed = "1.2.2" }
 [tooling]
 "qemu.qmp" = { accepted = ">=0.0.5", installed = "0.0.6" }
 "qemu" = { path = "python/" }
-# NB: The following dependencies should be a little bit more modern than
-# the versions listed here, but we are still using Debian 11 for several
-# GitLab CI tests, so we are further restricted.
-"setuptools" = { accepted = ">=44.1.1" }
-"wheel" = { accepted = ">=0.34.2" }
+"setuptools" = { accepted = ">=63.1.0" }
+"wheel" = { accepted = ">=0.41.2" }
 # pip should be guaranteed by mkvenv, this is merely a sanity check for
 # which version we are counting on being present.
-"pip" = { accepted = ">=20.3.4" }
+"pip" = { accepted = ">=23.2.1" }
 
 # This test group is for functional tests, and can include dependencies
 # fetched from PyPI.
-- 
2.55.0


