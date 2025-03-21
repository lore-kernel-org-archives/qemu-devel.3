Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9292DC36002
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 22:25:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvkmm-0002Ke-Nf; Fri, 21 Mar 2025 18:24:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tvkmj-0002KL-Gp
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 18:24:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tvkmh-0004Qe-PD
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 18:24:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742595851;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9VfGsKwd1UTbunkEuBrAVbD3LE9qtPehkmPXuUZIt4w=;
 b=OGCQGmyfNra2JA436Q+1JK/0wxintqV5Vw460cNg2C4NmseLm5vJiBFnQGwmhJlm06iutC
 /Wf5fz2AowEXO3GN7PZEk9A+agkGb5AzP5mmFwj47Kg05u1V5cRL8xBYTRmDn09m9179d/
 3qJuO4QlvSw1j68uaBwjkazaw0zBz/c=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-139-J_Ky_qnnNhi4oj21yKUyUQ-1; Fri,
 21 Mar 2025 18:24:04 -0400
X-MC-Unique: J_Ky_qnnNhi4oj21yKUyUQ-1
X-Mimecast-MFC-AGG-ID: J_Ky_qnnNhi4oj21yKUyUQ_1742595843
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 677A41801A07; Fri, 21 Mar 2025 22:24:03 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.31])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6FEBF3001D16; Fri, 21 Mar 2025 22:24:01 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 4/5] python: add qapi static analysis tests
Date: Fri, 21 Mar 2025 18:23:46 -0400
Message-ID: <20250321222347.299121-5-jsnow@redhat.com>
In-Reply-To: <20250321222347.299121-1-jsnow@redhat.com>
References: <20250321222347.299121-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Update the python tests to also check qapi. No idea why I didn't do this
before. I guess I was counting on moving it under python/ and then just
forgot after that was NACKed. Oops, this turns out to be really easy.

flake8, isort and mypy use the tool configuration from the existing
python directory (in setup.cfg). pylint continues to use the special
configuration located in scripts/qapi/ - that configuration is more
permissive. If we wish to unify the two configurations, that's a
separate series and a discussion for a later date.

As a result of this patch, one would be able to run any of the following
tests locally from the qemu.git/python directory and have it cover the
scripts/qapi/ module as well. All of the following options run the
python tests, static analysis tests, and linter checks; but with
different combinations of dependencies and interpreters.

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

Signed-off-by: John Snow <jsnow@redhat.com>
---
 python/setup.cfg            |  1 +
 python/tests/minreqs.txt    | 21 +++++++++++++++++++++
 python/tests/qapi-flake8.sh |  4 ++++
 python/tests/qapi-isort.sh  |  6 ++++++
 python/tests/qapi-mypy.sh   |  2 ++
 python/tests/qapi-pylint.sh |  6 ++++++
 scripts/qapi/pylintrc       |  1 +
 7 files changed, 41 insertions(+)
 create mode 100755 python/tests/qapi-flake8.sh
 create mode 100755 python/tests/qapi-isort.sh
 create mode 100755 python/tests/qapi-mypy.sh
 create mode 100755 python/tests/qapi-pylint.sh

diff --git a/python/setup.cfg b/python/setup.cfg
index cf5af7e6641..84d8a1fd30d 100644
--- a/python/setup.cfg
+++ b/python/setup.cfg
@@ -47,6 +47,7 @@ devel =
     urwid >= 2.1.2
     urwid-readline >= 0.13
     Pygments >= 2.9.0
+    sphinx >= 3.4.3
 
 # Provides qom-fuse functionality
 fuse =
diff --git a/python/tests/minreqs.txt b/python/tests/minreqs.txt
index 19c0f5e4c50..94928936d44 100644
--- a/python/tests/minreqs.txt
+++ b/python/tests/minreqs.txt
@@ -11,6 +11,9 @@
 # When adding new dependencies, pin the very oldest non-yanked version
 # on PyPI that allows the test suite to pass.
 
+# Dependencies for qapidoc/qapi_domain et al
+sphinx==3.4.3
+
 # Dependencies for the TUI addon (Required for successful linting)
 urwid==2.1.2
 urwid-readline==0.13
@@ -49,3 +52,21 @@ platformdirs==2.2.0
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
index 00000000000..7b5983d64a9
--- /dev/null
+++ b/python/tests/qapi-flake8.sh
@@ -0,0 +1,4 @@
+#!/bin/sh -e
+python3 -m flake8 ../scripts/qapi/ \
+        ../docs/sphinx/qapidoc.py \
+        ../docs/sphinx/qapi_domain.py
diff --git a/python/tests/qapi-isort.sh b/python/tests/qapi-isort.sh
new file mode 100755
index 00000000000..f31f12d3425
--- /dev/null
+++ b/python/tests/qapi-isort.sh
@@ -0,0 +1,6 @@
+#!/bin/sh -e
+python3 -m isort --sp . -c ../scripts/qapi/
+# Force isort to recognize "compat" as a local module and not third-party
+python3 -m isort --sp . -c -p compat -p qapidoc_legacy \
+        ../docs/sphinx/qapi_domain.py \
+        ../docs/sphinx/qapidoc.py
diff --git a/python/tests/qapi-mypy.sh b/python/tests/qapi-mypy.sh
new file mode 100755
index 00000000000..377b29b873b
--- /dev/null
+++ b/python/tests/qapi-mypy.sh
@@ -0,0 +1,2 @@
+#!/bin/sh -e
+python3 -m mypy ../scripts/qapi
diff --git a/python/tests/qapi-pylint.sh b/python/tests/qapi-pylint.sh
new file mode 100755
index 00000000000..f4bb7a5a795
--- /dev/null
+++ b/python/tests/qapi-pylint.sh
@@ -0,0 +1,6 @@
+#!/bin/sh -e
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


