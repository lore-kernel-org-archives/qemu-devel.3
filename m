Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B107FCA16A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 18:07:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzf0D-0004Gd-Oh; Mon, 09 Mar 2026 14:06:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vzf01-00040M-42
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 14:06:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vzezx-0006gM-Ai
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 14:06:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773079592;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ba4T/cWXaHshRAbg1PE3UCwKYbftxQfC8woBgSFQRJ8=;
 b=fryNQxJ+u9Z1fCKKoiHHE6bLqYkCbthMDgkAEQVj9a7b12koFKJJlE2wP3n8Fn3fP44SUg
 7lnk2DDsF0dFBbdIoRr8pPZNu3ygsN2OnAz3xvUlUc8nR6b7jIGIXAJEJDf7iA0ts5fJ5z
 ulZr5MMQB16wNQhtlaU8Mhp+2UbOxj4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-561-FRAQW4mkNDe-UlsK9S60eA-1; Mon,
 09 Mar 2026 14:06:28 -0400
X-MC-Unique: FRAQW4mkNDe-UlsK9S60eA-1
X-Mimecast-MFC-AGG-ID: FRAQW4mkNDe-UlsK9S60eA_1773079585
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F290918002C8; Mon,  9 Mar 2026 18:06:24 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.81.1])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9378918001FE; Mon,  9 Mar 2026 18:06:16 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Warner Losh <imp@bsdimp.com>,
 qemu-block@nongnu.org, Michael Roth <michael.roth@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ed Maste <emaste@freebsd.org>, Maksim Davydov <davydov-max@yandex-team.ru>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Fabiano Rosas <farosas@suse.de>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Cleber Rosa <crosa@redhat.com>
Subject: [PULL 2/4] python: replace avocado tests with pytest
Date: Mon,  9 Mar 2026 14:05:59 -0400
Message-ID: <20260309180601.164435-3-jsnow@redhat.com>
In-Reply-To: <20260309180601.164435-1-jsnow@redhat.com>
References: <20260309180601.164435-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Following suit with the rest of this repository, drop avocado and
replace it with the Python standard "pytest" package.

Our ultimate goal is to merge these python tests with the meson test
suite, so the use of 'pytest' here is only a stop-gap solution to get
the GitLab CI 'check-python-tox' passing again following recent Python
packaging ecosystem changes.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20260226213400.1254014-3-jsnow@redhat.com>
[ran black autoformatter. --js]
Signed-off-by: John Snow <jsnow@redhat.com>
---
 python/Makefile          |   4 +-
 python/setup.cfg         |   1 +
 python/tests/linters.py  | 114 +++++++++++++++++++++++++++++++++++++++
 python/tests/minreqs.txt |   1 +
 4 files changed, 118 insertions(+), 2 deletions(-)
 create mode 100644 python/tests/linters.py

diff --git a/python/Makefile b/python/Makefile
index b6c9cd1bce2..42994d39618 100644
--- a/python/Makefile
+++ b/python/Makefile
@@ -105,7 +105,7 @@ develop:
 
 .PHONY: check
 check:
-	@avocado --config avocado.cfg run tests/
+	@pytest -v tests/*.py
 
 .PHONY: check-tox
 check-tox:
@@ -113,7 +113,7 @@ check-tox:
 
 .PHONY: check-coverage
 check-coverage:
-	@coverage run -m avocado --config avocado.cfg run tests/*.py
+	@coverage run -m pytest -v tests/*.py
 	@coverage combine
 	@coverage html
 	@coverage report
diff --git a/python/setup.cfg b/python/setup.cfg
index c46a95f8d41..03344526730 100644
--- a/python/setup.cfg
+++ b/python/setup.cfg
@@ -43,6 +43,7 @@ devel =
     mypy >= 1.4.0
     pylint >= 2.17.3
     pylint != 3.2.4; python_version<"3.9"
+    pytest >= 6.0.2
     tox >= 3.18.0
     sphinx >= 3.4.3
 
diff --git a/python/tests/linters.py b/python/tests/linters.py
new file mode 100644
index 00000000000..9696c0b71b8
--- /dev/null
+++ b/python/tests/linters.py
@@ -0,0 +1,114 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import os
+from subprocess import check_call
+import sys
+
+
+class TestLinters:
+
+    def test_flake8_pkg(self):
+        check_call([sys.executable, "-m", "flake8", "qemu/"])
+
+    def test_flake8_scripts(self):
+        check_call([sys.executable, "-m", "flake8", "scripts/"])
+
+    def test_flake8_qapi(self):
+        check_call(
+            [
+                sys.executable,
+                "-m",
+                "flake8",
+                "../scripts/qapi/",
+                "../docs/sphinx/qapidoc.py",
+                "../docs/sphinx/qapi_domain.py",
+            ]
+        )
+
+    def test_isort_pkg(self):
+        check_call([sys.executable, "-m", "isort", "-c", "qemu/"])
+
+    def test_isort_scripts(self):
+        check_call([sys.executable, "-m", "isort", "-c", "scripts/"])
+
+    def test_isort_qapi(self):
+        check_call(
+            [
+                sys.executable,
+                "-m",
+                "isort",
+                "--sp",
+                ".",
+                "-c",
+                "../scripts/qapi/",
+            ]
+        )
+
+    def test_isort_qapi_sphinx(self):
+        # Force isort to recognize 'compat' as a local module and not
+        # third-party
+        check_call(
+            [
+                sys.executable,
+                "-m",
+                "isort",
+                "--sp",
+                ".",
+                "-c",
+                "-p",
+                "compat",
+                "../docs/sphinx/qapi_domain.py",
+                "../docs/sphinx/qapidoc.py",
+            ]
+        )
+
+    def test_mypy_pkg(self):
+        check_call([sys.executable, "-m", "mypy", "-p", "qemu"])
+
+    def test_mypy_scripts(self):
+        check_call([sys.executable, "-m", "mypy", "scripts/"])
+
+    def test_mypy_qapi(self):
+        check_call([sys.executable, "-m", "mypy", "../scripts/qapi"])
+
+    def test_mypy_iotests(self):
+        check_call(
+            [sys.executable, "-m", "linters", "--mypy"],
+            cwd="../tests/qemu-iotests/",
+        )
+
+    # Setuptools v60 introduced the SETUPTOOLS_USE_DISTUTILS=stdlib
+    # workaround; stdlib distutils was fully removed in Python
+    # 3.12+. Once we are on >=3.12+ exclusively, this workaround can be
+    # dropped safely. Until then, it is needed for some versions on
+    # Fedora/Debian distributions which relied upon distro-patched
+    # setuptools present in CPython, but not within setuptools itself.
+
+    def test_pylint_pkg(self):
+        os.environ["SETUPTOOLS_USE_DISTUTILS"] = "stdlib"
+        check_call([sys.executable, "-m", "pylint", "qemu/"])
+
+    def test_pylint_scripts(self):
+        os.environ["SETUPTOOLS_USE_DISTUTILS"] = "stdlib"
+        check_call([sys.executable, "-m", "pylint", "scripts/"])
+
+    def test_pylint_qapi(self):
+        os.environ["SETUPTOOLS_USE_DISTUTILS"] = "stdlib"
+        check_call(
+            [
+                sys.executable,
+                "-m",
+                "pylint",
+                "--rcfile=../scripts/qapi/pylintrc",
+                "../scripts/qapi/",
+                "../docs/sphinx/qapidoc.py",
+                "../docs/sphinx/qapi_domain.py",
+            ]
+        )
+
+    def test_pylint_iotests(self):
+        os.environ["SETUPTOOLS_USE_DISTUTILS"] = "stdlib"
+        check_call(
+            [sys.executable, "-m", "linters", "--pylint"],
+            cwd="../tests/qemu-iotests/",
+        )
diff --git a/python/tests/minreqs.txt b/python/tests/minreqs.txt
index 38b17d17e14..19912027076 100644
--- a/python/tests/minreqs.txt
+++ b/python/tests/minreqs.txt
@@ -32,6 +32,7 @@ fusepy==2.0.4
 
 # Test-runners, utilities, etc.
 avocado-framework==90.0
+pytest==6.0.2
 
 # Linters
 flake8==5.0.4
-- 
2.53.0


