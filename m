Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9E64C021B3
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 03:39:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmPI6-0001Ml-1D; Sun, 23 Feb 2025 22:37:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tmPI4-0001MR-Cn
 for qemu-devel@nongnu.org; Sun, 23 Feb 2025 22:37:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tmPI2-0005QQ-38
 for qemu-devel@nongnu.org; Sun, 23 Feb 2025 22:37:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740368272;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uMKnABVrs8WDUSLAe63r5ZpgVJ7qK/QCZKTVO7yUAO8=;
 b=XcTAj8Z/7il34UXkl1G5oHScpwaYPMzFN7VM3bWjlAkHkIYuvtb1MA6H6LbJuukgx0w56+
 AIQdjo9rLYzKRZkxENj5ZXU3YiflL/JMTGWbau+FMomjDrvRXwr+O9Ed2jf47FZIUM11is
 Aii2kzMnxg9dnTRC478RBYl6jmDopmU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-693-i2dTjIZrP7GwchZHL3h93g-1; Sun,
 23 Feb 2025 22:37:51 -0500
X-MC-Unique: i2dTjIZrP7GwchZHL3h93g-1
X-Mimecast-MFC-AGG-ID: i2dTjIZrP7GwchZHL3h93g_1740368270
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DB8F2190FF83; Mon, 24 Feb 2025 03:37:49 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.88])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E0FE919560A3; Mon, 24 Feb 2025 03:37:47 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 02/10] python: add qapi static analysis tests
Date: Sun, 23 Feb 2025 22:37:33 -0500
Message-ID: <20250224033741.222749-3-jsnow@redhat.com>
In-Reply-To: <20250224033741.222749-1-jsnow@redhat.com>
References: <20250224033741.222749-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.446,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
python directory. pylint continues to use the special configuration
located in scripts/qapi/ - that configuration is more permissive. If we
wish to unify the two configurations, that's a separate series and a
discussion for a later date.

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
 python/tests/qapi-flake8.sh | 2 ++
 python/tests/qapi-isort.sh  | 2 ++
 python/tests/qapi-mypy.sh   | 2 ++
 python/tests/qapi-pylint.sh | 4 ++++
 4 files changed, 10 insertions(+)
 create mode 100755 python/tests/qapi-flake8.sh
 create mode 100755 python/tests/qapi-isort.sh
 create mode 100755 python/tests/qapi-mypy.sh
 create mode 100755 python/tests/qapi-pylint.sh

diff --git a/python/tests/qapi-flake8.sh b/python/tests/qapi-flake8.sh
new file mode 100755
index 00000000000..51916a9019d
--- /dev/null
+++ b/python/tests/qapi-flake8.sh
@@ -0,0 +1,2 @@
+#!/bin/sh -e
+python3 -m flake8 ../scripts/qapi/
diff --git a/python/tests/qapi-isort.sh b/python/tests/qapi-isort.sh
new file mode 100755
index 00000000000..60ed5eeb34d
--- /dev/null
+++ b/python/tests/qapi-isort.sh
@@ -0,0 +1,2 @@
+#!/bin/sh -e
+python3 -m isort --sp . -c ../scripts/qapi/
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
index 00000000000..d4869578e54
--- /dev/null
+++ b/python/tests/qapi-pylint.sh
@@ -0,0 +1,4 @@
+#!/bin/sh -e
+SETUPTOOLS_USE_DISTUTILS=stdlib python3 -m pylint \
+                                --rcfile=../scripts/qapi/pylintrc \
+                                ../scripts/qapi/
-- 
2.48.1


