Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55806D1266D
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 08:02:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQhn9-0000Kw-CL; Wed, 03 Dec 2025 03:00:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vQhmu-000089-97; Wed, 03 Dec 2025 03:00:41 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vQhmr-0006yW-6o; Wed, 03 Dec 2025 03:00:36 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E901E17076D;
 Wed, 03 Dec 2025 10:59:22 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id B6E4032B494;
 Wed, 03 Dec 2025 10:59:40 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.7 096/116] gitlab-ci: Update QEMU_JOB_AVOCADO and
 QEMU_CI_AVOCADO_TESTING
Date: Wed,  3 Dec 2025 10:59:16 +0300
Message-ID: <20251203075939.2366131-15-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.7-20251203105830@cover.tls.msk.ru>
References: <qemu-stable-10.0.7-20251203105830@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

From: Thomas Huth <thuth@redhat.com>

Since we don't run the Avocado jobs in the CI anymore, rename
these variables to QEMU_JOB_FUNCTIONAL and QEMU_CI_FUNCTIONAL.

Also, there was a mismatch between the documentation and the
implementation of QEMU_CI_AVOCADO_TESTING: While the documentation
said that you had to "Set this variable to have the tests using the
Avocado framework run automatically", you indeed needed to set it
to make the pipelines appear in your dashboard - but they were never
run automatically in forks and had to be triggered manually. Let's
improve this now: No need to hide these pipelines from the users
by default anymore (the functional tests should be stable enough
nowadays), and rather allow the users to run the pipelines auto-
matically with this switch now instead, as was documented.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20250414113031.151105-15-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
(cherry picked from commit f8c54844175922d77faa8b586f451e379d53a191)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/.gitlab-ci.d/base.yml b/.gitlab-ci.d/base.yml
index 25b88aaa06..60a24a9d14 100644
--- a/.gitlab-ci.d/base.yml
+++ b/.gitlab-ci.d/base.yml
@@ -69,10 +69,6 @@ variables:
     - if: '$QEMU_CI != "1" && $QEMU_CI != "2" && $CI_PROJECT_NAMESPACE != $QEMU_CI_UPSTREAM'
       when: never
 
-    # Avocado jobs don't run in forks unless $QEMU_CI_AVOCADO_TESTING is set
-    - if: '$QEMU_JOB_AVOCADO && $QEMU_CI_AVOCADO_TESTING != "1" && $CI_PROJECT_NAMESPACE != $QEMU_CI_UPSTREAM'
-      when: never
-
 
     #############################################################
     # Stage 2: fine tune execution of jobs in specific scenarios
@@ -101,8 +97,8 @@ variables:
       when: manual
       allow_failure: true
 
-    # Avocado jobs can be manually start in forks if $QEMU_CI_AVOCADO_TESTING is unset
-    - if: '$QEMU_JOB_AVOCADO && $CI_PROJECT_NAMESPACE != $QEMU_CI_UPSTREAM'
+    # Functional jobs can be manually started in forks
+    - if: '$QEMU_JOB_FUNCTIONAL && $QEMU_CI_FUNCTIONAL != "1" && $CI_PROJECT_NAMESPACE != $QEMU_CI_UPSTREAM'
       when: manual
       allow_failure: true
 
diff --git a/.gitlab-ci.d/buildtest-template.yml b/.gitlab-ci.d/buildtest-template.yml
index 13fa4f4a4f..d4f145fdb5 100644
--- a/.gitlab-ci.d/buildtest-template.yml
+++ b/.gitlab-ci.d/buildtest-template.yml
@@ -114,4 +114,4 @@
     - cd build
     - du -chs ${CI_PROJECT_DIR}/*-cache
   variables:
-    QEMU_JOB_AVOCADO: 1
+    QEMU_JOB_FUNCTIONAL: 1
diff --git a/docs/devel/testing/ci-jobs.rst.inc b/docs/devel/testing/ci-jobs.rst.inc
index 3756bbe355..f1c541cc25 100644
--- a/docs/devel/testing/ci-jobs.rst.inc
+++ b/docs/devel/testing/ci-jobs.rst.inc
@@ -126,10 +126,10 @@ QEMU_JOB_PUBLISH
 The job is for publishing content after a branch has been
 merged into the upstream default branch.
 
-QEMU_JOB_AVOCADO
-~~~~~~~~~~~~~~~~
+QEMU_JOB_FUNCTIONAL
+~~~~~~~~~~~~~~~~~~~
 
-The job runs the Avocado integration test suite
+The job runs the functional test suite
 
 Contributor controlled runtime variables
 ----------------------------------------
@@ -149,13 +149,12 @@ the jobs to be manually started from the UI
 Set this variable to 2 to create the pipelines and run all
 the jobs immediately, as was the historical behaviour
 
-QEMU_CI_AVOCADO_TESTING
-~~~~~~~~~~~~~~~~~~~~~~~
-By default, tests using the Avocado framework are not run automatically in
-the pipelines (because multiple artifacts have to be downloaded, and if
-these artifacts are not already cached, downloading them make the jobs
-reach the timeout limit). Set this variable to have the tests using the
-Avocado framework run automatically.
+QEMU_CI_FUNCTIONAL
+~~~~~~~~~~~~~~~~~~
+By default, tests using the functional framework are not run automatically
+in the pipelines (because multiple artifacts have to be downloaded, which
+might cause a lot of network traffic). Set this variable to have the tests
+using the functional framework run automatically.
 
 Other misc variables
 --------------------
-- 
2.47.3


