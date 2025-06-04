Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01508C5B552
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 20:04:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMuLM-0005tY-3l; Wed, 04 Jun 2025 16:04:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uMuLK-0005sg-1l
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 16:04:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uMuLH-0008Hx-ID
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 16:04:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749067445;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x5/lVmbeVAAmKZOjTgHN0gBaVFmiqY8sn3LfygFHyzc=;
 b=bSJW9filTbQ8yzex7cH20bJD6tVZ/5y2ekJlSPmr9z9QDQFZqa/MyRsI5zbXwwbWWjA8c8
 GZxN5EhEmCOrlVvwzrPP+sC1d/cLGtx7vMSR577dknTwMiWx9P13U+Sc5mHW5GJ20BbWDx
 ltIcj79R6PR9/3VUsx3FMCVYNSz6Dzk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-465-BgEEmRE0M1-_vsA1eV7Rkw-1; Wed,
 04 Jun 2025 16:04:04 -0400
X-MC-Unique: BgEEmRE0M1-_vsA1eV7Rkw-1
X-Mimecast-MFC-AGG-ID: BgEEmRE0M1-_vsA1eV7Rkw_1749067443
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 773741800378; Wed,  4 Jun 2025 20:04:03 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.163])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 32D3130002C3; Wed,  4 Jun 2025 20:04:02 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Cleber Rosa <crosa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v5 4/6] python: add qapi static analysis tests
Date: Wed,  4 Jun 2025 16:03:52 -0400
Message-ID: <20250604200354.459501-5-jsnow@redhat.com>
In-Reply-To: <20250604200354.459501-1-jsnow@redhat.com>
References: <20250604200354.459501-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Update the python tests to also check QAPI and the QAPI Sphinx
extensions. The docs/sphinx/qapidoc_legacy.py file is not included in
these checks, as it is destined for removal soon. mypy is also not
called on the QAPI Sphinx extensions, owing to difficulties supporting
Sphinx 3.x - 8.x while maintaining static type checking support. mypy
*is* called on all of the QAPI tools themselves, though.

flake8, isort and mypy use the tool configuration from the existing
python directory (in setup.cfg). pylint continues to use the special
configuration located in scripts/qapi/ - that configuration is more
permissive. If we wish to unify the two configurations, that's a
separate series and a discussion for a later date.

The list of pylint ignores is also updated, owing again to the wide
window of pylint version support: newer versions require pragmas to
occasionally silence the "too many positional arguments" warning, but
older versions do not have such a warning category and will instead yelp
about an unrecognized option. Silence that warning, too.

As a result of this patch, one would be able to run any of the following
tests locally from the qemu.git/python directory and have it cover the
QAPI tooling as well. All of the following options run the python tests,
static analysis tests, and linter checks; but with different
combinations of dependencies and interpreters.

- "make check-minreqs" Run tests specifically under our oldest supported
  Python and our oldest supported dependencies. This is the test that
  runs on GitLab as "check-python-minreqs". This helps ensure we do not
  regress support on older platforms accidentally.

- "make check-tox" Runs the tests under the newest supported
  dependencies, but under each supported version of Python in turn. At
  time of writing, this is Python 3.8 to 3.13 inclusive. This test helps
  catch bleeding-edge problems before they become problems for developer
  workstations. This is the GitLab test "check-python-tox" and is an
  optionally run, may-fail test due to the unpredictable nature of new
  dependencies being released into the ecosystem that may cause
  regressions.

- "make check-dev" Runs the tests under the newest supported
  dependencies using whatever version of Python the user happens to have
  installed. This is a quick convenience check that does not map to any
  particular GitLab test.

  (Note! check-dev may be busted on Fedora 41 and bleeding edge versions
  of setuptools. That's unrelated to this patch and I'll address it
  separately and soon. Thank you for your patience, --mgmt)

Finally, finally, finally: this means that QAPI tooling will be linted
and type-checked from the GitLab pipelines.

Signed-off-by: John Snow <jsnow@redhat.com>

add licenses or whatever

Signed-off-by: John Snow <jsnow@redhat.com>
---
 python/setup.cfg            |  1 +
 python/tests/minreqs.txt    | 27 +++++++++++++++++++++++++++
 python/tests/qapi-flake8.sh |  6 ++++++
 python/tests/qapi-isort.sh  |  8 ++++++++
 python/tests/qapi-mypy.sh   |  4 ++++
 python/tests/qapi-pylint.sh |  8 ++++++++
 scripts/qapi/pylintrc       |  1 +
 7 files changed, 55 insertions(+)
 create mode 100755 python/tests/qapi-flake8.sh
 create mode 100755 python/tests/qapi-isort.sh
 create mode 100755 python/tests/qapi-mypy.sh
 create mode 100755 python/tests/qapi-pylint.sh

diff --git a/python/setup.cfg b/python/setup.cfg
index c48dff280a3..d21304cadd1 100644
--- a/python/setup.cfg
+++ b/python/setup.cfg
@@ -46,6 +46,7 @@ devel =
     urwid >= 2.1.2
     urwid-readline >= 0.13
     Pygments >= 2.9.0
+    sphinx >= 3.4.3
 
 # Provides qom-fuse functionality
 fuse =
diff --git a/python/tests/minreqs.txt b/python/tests/minreqs.txt
index d3d53e0da81..cd2e2a81c3d 100644
--- a/python/tests/minreqs.txt
+++ b/python/tests/minreqs.txt
@@ -11,6 +11,15 @@
 # When adding new dependencies, pin the very oldest non-yanked version
 # on PyPI that allows the test suite to pass.
 
+# For some reason, the presence of packaging==14.0 below requires us to
+# also pin setuptools to version 70 or below. Otherwise, the
+# installation of the QEMU package itself fails, failing to find
+# setuptools.
+setuptools<=70
+
+# Dependencies for qapidoc/qapi_domain et al
+sphinx==3.4.3
+
 # Dependencies for the TUI addon (Required for successful linting)
 urwid==2.1.2
 urwid-readline==0.13
@@ -49,3 +58,21 @@ platformdirs==2.2.0
 toml==0.10.0
 tomlkit==0.10.1
 wrapt==1.14.0
+
+# Transitive sphinx dependencies
+Jinja2==2.7
+MarkupSafe==1.1.0
+alabaster==0.7.1
+babel==1.3
+docutils==0.12
+imagesize==0.5.0
+packaging==14.0
+pytz==2011b0
+requests==2.5.0
+snowballstemmer==1.1
+sphinxcontrib-applehelp==1.0.0
+sphinxcontrib-devhelp==1.0.0
+sphinxcontrib-htmlhelp==1.0.0
+sphinxcontrib-jsmath==1.0.0
+sphinxcontrib-qthelp==1.0.0
+sphinxcontrib-serializinghtml==1.0.0
diff --git a/python/tests/qapi-flake8.sh b/python/tests/qapi-flake8.sh
new file mode 100755
index 00000000000..2211b6c7f41
--- /dev/null
+++ b/python/tests/qapi-flake8.sh
@@ -0,0 +1,6 @@
+#!/bin/sh -e
+# SPDX-License-Identifier: LGPL-2.1-or-later
+
+python3 -m flake8 ../scripts/qapi/ \
+        ../docs/sphinx/qapidoc.py \
+        ../docs/sphinx/qapi_domain.py
diff --git a/python/tests/qapi-isort.sh b/python/tests/qapi-isort.sh
new file mode 100755
index 00000000000..e546f5a7b5c
--- /dev/null
+++ b/python/tests/qapi-isort.sh
@@ -0,0 +1,8 @@
+#!/bin/sh -e
+# SPDX-License-Identifier: LGPL-2.1-or-later
+
+python3 -m isort --sp . -c ../scripts/qapi/
+# Force isort to recognize "compat" as a local module and not third-party
+python3 -m isort --sp . -c -p compat -p qapidoc_legacy \
+        ../docs/sphinx/qapi_domain.py \
+        ../docs/sphinx/qapidoc.py
diff --git a/python/tests/qapi-mypy.sh b/python/tests/qapi-mypy.sh
new file mode 100755
index 00000000000..50fb8ed1e3e
--- /dev/null
+++ b/python/tests/qapi-mypy.sh
@@ -0,0 +1,4 @@
+#!/bin/sh -e
+# SPDX-License-Identifier: LGPL-2.1-or-later
+
+python3 -m mypy ../scripts/qapi
diff --git a/python/tests/qapi-pylint.sh b/python/tests/qapi-pylint.sh
new file mode 100755
index 00000000000..5f1b79c1883
--- /dev/null
+++ b/python/tests/qapi-pylint.sh
@@ -0,0 +1,8 @@
+#!/bin/sh -e
+# SPDX-License-Identifier: LGPL-2.1-or-later
+
+SETUPTOOLS_USE_DISTUTILS=stdlib python3 -m pylint \
+                                --rcfile=../scripts/qapi/pylintrc \
+                                ../scripts/qapi/ \
+                                ../docs/sphinx/qapidoc.py \
+                                ../docs/sphinx/qapi_domain.py
diff --git a/scripts/qapi/pylintrc b/scripts/qapi/pylintrc
index d24eece7411..e16283ada3d 100644
--- a/scripts/qapi/pylintrc
+++ b/scripts/qapi/pylintrc
@@ -19,6 +19,7 @@ disable=consider-using-f-string,
         too-many-instance-attributes,
         too-many-positional-arguments,
         too-many-statements,
+        unknown-option-value,
         useless-option-value,
 
 [REPORTS]
-- 
2.48.1


