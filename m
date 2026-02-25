Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90740FD45F4
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 21:04:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvM3i-0006F6-MF; Wed, 25 Feb 2026 16:04:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vvM3e-0006Cw-KP
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 16:04:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vvM3a-0006ot-Lm
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 16:04:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772053470;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HWRUA8tj40Tz3RR9F8yelmtXUdPZZ2umwgoMnemQSdQ=;
 b=c8FjGhltUqwrldHg+gjUBdoH5vuxWV7nmaNryOMxYgb8yKBJF9J1n63kKLne+sfCJ/vGow
 T17tbH8cgmdR7ZAYV6o+uNrhpZtnbH/xFmTMcel+6pviH8KeOHUaYG6TLeOAPp+nnwJn/G
 O8kgzrXJKsY+B6hYu5T8ZCJa3KXUr/k=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-218-p0Ar6X4AOk-NCcB0xmXWXA-1; Wed,
 25 Feb 2026 16:04:27 -0500
X-MC-Unique: p0Ar6X4AOk-NCcB0xmXWXA-1
X-Mimecast-MFC-AGG-ID: p0Ar6X4AOk-NCcB0xmXWXA_1772053466
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 821B61956050; Wed, 25 Feb 2026 21:04:26 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.89.212])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 71C411800671; Wed, 25 Feb 2026 21:04:25 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v3 3/4] python: drop avocado
Date: Wed, 25 Feb 2026 16:04:14 -0500
Message-ID: <20260225210415.972192-4-jsnow@redhat.com>
In-Reply-To: <20260225210415.972192-1-jsnow@redhat.com>
References: <20260225210415.972192-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 27
X-Spam_score: 2.7
X-Spam_bar: ++
X-Spam_report: (2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.734,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.78, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Avocado-framework is no longer used for anything, so it can be removed.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 python/README.rst              |  2 --
 python/avocado.cfg             | 13 -------------
 python/setup.cfg               |  1 -
 python/tests/flake8.sh         |  3 ---
 python/tests/iotests-mypy.sh   |  4 ----
 python/tests/iotests-pylint.sh |  5 -----
 python/tests/isort.sh          |  3 ---
 python/tests/minreqs.txt       |  1 -
 python/tests/mypy.sh           |  3 ---
 python/tests/pylint.sh         |  4 ----
 python/tests/qapi-flake8.sh    |  6 ------
 python/tests/qapi-isort.sh     |  8 --------
 python/tests/qapi-mypy.sh      |  4 ----
 python/tests/qapi-pylint.sh    |  8 --------
 14 files changed, 65 deletions(-)
 delete mode 100644 python/avocado.cfg
 delete mode 100755 python/tests/flake8.sh
 delete mode 100755 python/tests/iotests-mypy.sh
 delete mode 100755 python/tests/iotests-pylint.sh
 delete mode 100755 python/tests/isort.sh
 delete mode 100755 python/tests/mypy.sh
 delete mode 100755 python/tests/pylint.sh
 delete mode 100755 python/tests/qapi-flake8.sh
 delete mode 100755 python/tests/qapi-isort.sh
 delete mode 100755 python/tests/qapi-mypy.sh
 delete mode 100755 python/tests/qapi-pylint.sh

diff --git a/python/README.rst b/python/README.rst
index ec5cb5e971b..e34d1a1c7b1 100644
--- a/python/README.rst
+++ b/python/README.rst
@@ -108,8 +108,6 @@ Files in this directory
 
 - ``qemu/`` Python 'qemu' namespace package source directory.
 - ``tests/`` Python package tests directory.
-- ``avocado.cfg`` Configuration for the Avocado test-runner.
-  Used by ``make check`` et al.
 - ``Makefile`` provides some common testing/installation invocations.
   Try ``make help`` to see available targets.
 - ``MANIFEST.in`` is read by python setuptools, it specifies additional files
diff --git a/python/avocado.cfg b/python/avocado.cfg
deleted file mode 100644
index a4604200594..00000000000
--- a/python/avocado.cfg
+++ /dev/null
@@ -1,13 +0,0 @@
-[run]
-test_runner = nrunner
-
-[simpletests]
-# Don't show stdout/stderr in the test *summary*
-status.failure_fields = ['status']
-
-[job]
-# Don't show the full debug.log output; only select stdout/stderr.
-output.testlogs.logfiles = ['stdout', 'stderr']
-
-# Show full stdout/stderr only on tests that FAIL
-output.testlogs.statuses = ['FAIL']
diff --git a/python/setup.cfg b/python/setup.cfg
index 03344526730..e5bf498f0e1 100644
--- a/python/setup.cfg
+++ b/python/setup.cfg
@@ -35,7 +35,6 @@ install_requires =
 [options.extras_require]
 # Remember to update tests/minreqs.txt if changing anything below:
 devel =
-    avocado-framework >= 90.0
     distlib >= 0.3.6
     flake8 >= 5.0.4
     fusepy >= 2.0.4
diff --git a/python/tests/flake8.sh b/python/tests/flake8.sh
deleted file mode 100755
index e0136996453..00000000000
--- a/python/tests/flake8.sh
+++ /dev/null
@@ -1,3 +0,0 @@
-#!/bin/sh -e
-python3 -m flake8 qemu/
-python3 -m flake8 scripts/
diff --git a/python/tests/iotests-mypy.sh b/python/tests/iotests-mypy.sh
deleted file mode 100755
index ee764708199..00000000000
--- a/python/tests/iotests-mypy.sh
+++ /dev/null
@@ -1,4 +0,0 @@
-#!/bin/sh -e
-
-cd ../tests/qemu-iotests/
-python3 -m linters --mypy
diff --git a/python/tests/iotests-pylint.sh b/python/tests/iotests-pylint.sh
deleted file mode 100755
index 33c5ae900a5..00000000000
--- a/python/tests/iotests-pylint.sh
+++ /dev/null
@@ -1,5 +0,0 @@
-#!/bin/sh -e
-
-cd ../tests/qemu-iotests/
-# See commit message for environment variable explainer.
-SETUPTOOLS_USE_DISTUTILS=stdlib python3 -m linters --pylint
diff --git a/python/tests/isort.sh b/python/tests/isort.sh
deleted file mode 100755
index 66c2f7df0fd..00000000000
--- a/python/tests/isort.sh
+++ /dev/null
@@ -1,3 +0,0 @@
-#!/bin/sh -e
-python3 -m isort -c qemu/
-python3 -m isort -c scripts/
diff --git a/python/tests/minreqs.txt b/python/tests/minreqs.txt
index 19912027076..05c3bdb89f8 100644
--- a/python/tests/minreqs.txt
+++ b/python/tests/minreqs.txt
@@ -31,7 +31,6 @@ distlib==0.3.6
 fusepy==2.0.4
 
 # Test-runners, utilities, etc.
-avocado-framework==90.0
 pytest==6.0.2
 
 # Linters
diff --git a/python/tests/mypy.sh b/python/tests/mypy.sh
deleted file mode 100755
index a33a3f58ab3..00000000000
--- a/python/tests/mypy.sh
+++ /dev/null
@@ -1,3 +0,0 @@
-#!/bin/sh -e
-python3 -m mypy -p qemu
-python3 -m mypy scripts/
diff --git a/python/tests/pylint.sh b/python/tests/pylint.sh
deleted file mode 100755
index 2b68da90df7..00000000000
--- a/python/tests/pylint.sh
+++ /dev/null
@@ -1,4 +0,0 @@
-#!/bin/sh -e
-# See commit message for environment variable explainer.
-SETUPTOOLS_USE_DISTUTILS=stdlib python3 -m pylint qemu/
-SETUPTOOLS_USE_DISTUTILS=stdlib python3 -m pylint scripts/
diff --git a/python/tests/qapi-flake8.sh b/python/tests/qapi-flake8.sh
deleted file mode 100755
index c69f9ea2e00..00000000000
--- a/python/tests/qapi-flake8.sh
+++ /dev/null
@@ -1,6 +0,0 @@
-#!/bin/sh -e
-# SPDX-License-Identifier: GPL-2.0-or-later
-
-python3 -m flake8 ../scripts/qapi/ \
-        ../docs/sphinx/qapidoc.py \
-        ../docs/sphinx/qapi_domain.py
diff --git a/python/tests/qapi-isort.sh b/python/tests/qapi-isort.sh
deleted file mode 100755
index 067c16d5d94..00000000000
--- a/python/tests/qapi-isort.sh
+++ /dev/null
@@ -1,8 +0,0 @@
-#!/bin/sh -e
-# SPDX-License-Identifier: GPL-2.0-or-later
-
-python3 -m isort --sp . -c ../scripts/qapi/
-# Force isort to recognize "compat" as a local module and not third-party
-python3 -m isort --sp . -c -p compat \
-        ../docs/sphinx/qapi_domain.py \
-        ../docs/sphinx/qapidoc.py
diff --git a/python/tests/qapi-mypy.sh b/python/tests/qapi-mypy.sh
deleted file mode 100755
index 363dbaf8c06..00000000000
--- a/python/tests/qapi-mypy.sh
+++ /dev/null
@@ -1,4 +0,0 @@
-#!/bin/sh -e
-# SPDX-License-Identifier: GPL-2.0-or-later
-
-python3 -m mypy ../scripts/qapi
diff --git a/python/tests/qapi-pylint.sh b/python/tests/qapi-pylint.sh
deleted file mode 100755
index 8767d9d2a2d..00000000000
--- a/python/tests/qapi-pylint.sh
+++ /dev/null
@@ -1,8 +0,0 @@
-#!/bin/sh -e
-# SPDX-License-Identifier: GPL-2.0-or-later
-
-SETUPTOOLS_USE_DISTUTILS=stdlib python3 -m pylint \
-                                --rcfile=../scripts/qapi/pylintrc \
-                                ../scripts/qapi/ \
-                                ../docs/sphinx/qapidoc.py \
-                                ../docs/sphinx/qapi_domain.py
-- 
2.53.0


