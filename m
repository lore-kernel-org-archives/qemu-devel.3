Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50DF1C3ABDD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 18:23:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uH583-0002ff-Gi; Mon, 19 May 2025 14:22:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uH57t-0002cy-16
 for qemu-devel@nongnu.org; Mon, 19 May 2025 14:22:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uH57q-0000by-KU
 for qemu-devel@nongnu.org; Mon, 19 May 2025 14:22:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747678929;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m2iR8HmasrCFaEgqZX0MEMY7c6lB0t/HWqm2yXF4vAA=;
 b=TVzEcARSXdLeto+C2ubKGev58DhQLFHO1tToAYgl4Vq0//GZEvFsCL9fpN02LMokzjisc5
 0XL7ymlARpjTuIbZnT4n2J4Hyh1f3hhK885SjGVnGn2iSmaP4tIGDCDUtPChXZbC1nMZOp
 0V9yR+ED7NvIGDXr/6c247oQXpL8UO4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-662-6XTOROiXOe-sCPjAOEciCQ-1; Mon,
 19 May 2025 14:22:06 -0400
X-MC-Unique: 6XTOROiXOe-sCPjAOEciCQ-1
X-Mimecast-MFC-AGG-ID: 6XTOROiXOe-sCPjAOEciCQ_1747678924
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 94B4D18003FC; Mon, 19 May 2025 18:22:04 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.89.235])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0674A19560B0; Mon, 19 May 2025 18:22:00 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-rust@nongnu.org,
 John Snow <jsnow@redhat.com>, Maksim Davydov <davydov-max@yandex-team.ru>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH 1/8] python: convert packages to PEP517/pyproject.toml
Date: Mon, 19 May 2025 14:21:45 -0400
Message-ID: <20250519182153.3835722-2-jsnow@redhat.com>
In-Reply-To: <20250519182153.3835722-1-jsnow@redhat.com>
References: <20250519182153.3835722-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.13,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

Newer versions of setuptools increasingly expect that packages are
defined using the pyproject.toml/PEP517 packaging layout format. With
3.9 as our minimum, I believe it's finally appropriate to make the shift
away from the legacy packaging format.

Update documentation and dependencies that change as a result of the
different build/packaging/installation pathways.

This change has the effect of fixing "make check-dev", which has been
broken on newer versions of Fedora for a while, now.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 python/README.rst        | 33 ++++++++++++++++-----------------
 python/Makefile          | 18 +++++++++---------
 python/pyproject.toml    |  8 ++++++++
 python/setup.py          | 40 ----------------------------------------
 python/tests/minreqs.txt |  4 +++-
 5 files changed, 36 insertions(+), 67 deletions(-)
 create mode 100644 python/pyproject.toml
 delete mode 100755 python/setup.py

diff --git a/python/README.rst b/python/README.rst
index d62e71528d2..befa84e3261 100644
--- a/python/README.rst
+++ b/python/README.rst
@@ -5,24 +5,23 @@ This directory houses Python tooling used by the QEMU project to build,
 configure, and test QEMU. It is organized by namespace (``qemu``), and
 then by package (e.g. ``qemu/machine``, ``qemu/qmp``, etc).
 
-``setup.py`` is used by ``pip`` to install this tooling to the current
-environment. ``setup.cfg`` provides the packaging configuration used by
-``setup.py``. You will generally invoke it by doing one of the following:
+``pyproject.toml`` and ``setup.cfg`` are used by ``pip`` to install this
+tooling to the current environment. ``setup.cfg`` provides the packaging
+configuration, while ``pyproject.toml`` describes the package build
+system requirements.
 
-1. ``pip3 install .`` will install these packages to your current
-   environment. If you are inside a virtual environment, they will
-   install there. If you are not, it will attempt to install to the
-   global environment, which is **not recommended**.
+You will generally install these packages by invoking ``pip3 install
+.``; which will install these packages to your current environment. If
+you are inside a virtual environment, they will install there. If you
+are not, modern versions of pip will attempt instead to install to your
+local user environment. Older versions of pip will attempt to install to
+the global environment, which is **not recommended**.
 
-2. ``pip3 install --user .`` will install these packages to your user's
-   local python packages. If you are inside of a virtual environment,
-   this will fail; you want the first invocation above.
-
-If you append the ``--editable`` or ``-e`` argument to either invocation
-above, pip will install in "editable" mode. This installs the package as
-a forwarder ("qemu.egg-link") that points to the source tree. In so
-doing, the installed package always reflects the latest version in your
-source tree.
+If you append the ``--editable`` or ``-e`` argument to the above
+invocation, pip will install in "editable" mode. This installs the
+package as a "forwarder" that points to the source tree, so that the
+installed package always reflects the latest version in your source
+tree.
 
 Installing ".[devel]" instead of "." will additionally pull in required
 packages for testing this package. They are not runtime requirements,
@@ -81,4 +80,4 @@ Files in this directory
 - ``VERSION`` contains the PEP-440 compliant version used to describe
   this package; it is referenced by ``setup.cfg``.
 - ``setup.cfg`` houses setuptools package configuration.
-- ``setup.py`` is the setuptools installer used by pip; See above.
+- ``pyproject.toml`` lists build system requirements for the Python packages.
diff --git a/python/Makefile b/python/Makefile
index 764b79ccb23..845fbb66cf4 100644
--- a/python/Makefile
+++ b/python/Makefile
@@ -15,8 +15,8 @@ help:
 	@echo "make check-tox:"
 	@echo "    Run tests against multiple python versions."
 	@echo "    These tests use the newest dependencies."
-	@echo "    Requires: Python 3.9 - 3.11, and tox."
-	@echo "    Hint (Fedora): 'sudo dnf install python3-tox python3.11'"
+	@echo "    Requires: Python 3.9 - 3.13, and tox."
+	@echo "    Hint (Fedora): 'sudo dnf install python3-tox python3.13'"
 	@echo "    The variable QEMU_TOX_EXTRA_ARGS can be use to pass extra"
 	@echo "    arguments to tox".
 	@echo ""
@@ -63,12 +63,12 @@ $(QEMU_MINVENV_DIR) $(QEMU_MINVENV_DIR)/bin/activate: setup.cfg tests/minreqs.tx
 	@(								\
 		echo "ACTIVATE $(QEMU_MINVENV_DIR)";			\
 		. $(QEMU_MINVENV_DIR)/bin/activate;			\
-		echo "INSTALL wheel $(QEMU_MINVENV_DIR)";               \
-		$(PIP_INSTALL) wheel 1>/dev/null;		               \
+		echo "INSTALL wheel $(QEMU_MINVENV_DIR)";		\
+		$(PIP_INSTALL) wheel 1>/dev/null;			\
 		echo "INSTALL -r tests/minreqs.txt $(QEMU_MINVENV_DIR)";\
 		$(PIP_INSTALL) -r tests/minreqs.txt 1>/dev/null;	\
 		echo "INSTALL -e qemu $(QEMU_MINVENV_DIR)";		\
-		$(PIP_INSTALL) -e . 1>/dev/null;			\
+		$(PIP_INSTALL) -e . --config-settings=editable_mode=compat 1>/dev/null;			\
 	)
 	@touch $(QEMU_MINVENV_DIR)
 
@@ -103,7 +103,7 @@ check-dev: dev-venv
 
 .PHONY: develop
 develop:
-	$(PIP_INSTALL) -e .[devel]
+	$(PIP_INSTALL) -e .[devel] --config-settings=editable_mode=compat
 
 .PHONY: check
 check:
@@ -122,12 +122,12 @@ check-coverage:
 
 .PHONY: clean
 clean:
-	python3 setup.py clean --all
-	rm -f pyproject.toml
+	rm -rf build/
 
 .PHONY: distclean
 distclean: clean
-	rm -rf qemu.egg-info/ .eggs/ dist/
+	rm -rf qemu.egg-info/
 	rm -rf $(QEMU_VENV_DIR) $(QEMU_MINVENV_DIR) .tox/
+	rm -rf .mypy_cache/
 	rm -f .coverage .coverage.*
 	rm -rf htmlcov/
diff --git a/python/pyproject.toml b/python/pyproject.toml
new file mode 100644
index 00000000000..a9eebdcc319
--- /dev/null
+++ b/python/pyproject.toml
@@ -0,0 +1,8 @@
+[build-system]
+requires = [
+    "setuptools>=39.2",
+    "wheel",
+]
+build-backend = "setuptools.build_meta"
+
+[tool.setuptools_scm]
diff --git a/python/setup.py b/python/setup.py
deleted file mode 100755
index c5bc45919a4..00000000000
--- a/python/setup.py
+++ /dev/null
@@ -1,40 +0,0 @@
-#!/usr/bin/env python3
-"""
-QEMU tooling installer script
-Copyright (c) 2020-2021 John Snow for Red Hat, Inc.
-"""
-
-import setuptools
-from setuptools.command import bdist_egg
-import sys
-import pkg_resources
-
-
-class bdist_egg_guard(bdist_egg.bdist_egg):
-    """
-    Protect against bdist_egg from being executed
-
-    This prevents calling 'setup.py install' directly, as the 'install'
-    CLI option will invoke the deprecated bdist_egg hook. "pip install"
-    calls the more modern bdist_wheel hook, which is what we want.
-    """
-    def run(self):
-        sys.exit(
-            'Installation directly via setup.py is not supported.\n'
-            'Please use `pip install .` instead.'
-        )
-
-
-def main():
-    """
-    QEMU tooling installer
-    """
-
-    # https://medium.com/@daveshawley/safely-using-setup-cfg-for-metadata-1babbe54c108
-    pkg_resources.require('setuptools>=39.2')
-
-    setuptools.setup(cmdclass={'bdist_egg': bdist_egg_guard})
-
-
-if __name__ == '__main__':
-    main()
diff --git a/python/tests/minreqs.txt b/python/tests/minreqs.txt
index 3cc6f7bf4e3..a97d8fc9b2d 100644
--- a/python/tests/minreqs.txt
+++ b/python/tests/minreqs.txt
@@ -11,6 +11,9 @@
 # When adding new dependencies, pin the very oldest non-yanked version
 # on PyPI that allows the test suite to pass.
 
+# Avocado requires setuptools at runtime, and it requires an older one.
+setuptools<71
+
 # Dependencies for qapidoc/qapi_domain et al
 sphinx==3.4.3
 
@@ -49,7 +52,6 @@ astroid==2.15.4
 dill==0.2
 lazy-object-proxy==1.4.0
 platformdirs==2.2.0
-toml==0.10.0
 tomlkit==0.10.1
 wrapt==1.14.0
 
-- 
2.48.1


