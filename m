Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0D36D1266D
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 08:01:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQhmD-0008GH-54; Wed, 03 Dec 2025 02:59:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vQhmA-0008Eh-DD; Wed, 03 Dec 2025 02:59:50 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vQhm8-0006MO-9M; Wed, 03 Dec 2025 02:59:49 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 07E09170760;
 Wed, 03 Dec 2025 10:59:22 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id C91CB32B487;
 Wed, 03 Dec 2025 10:59:39 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.7 083/116] gitlab-ci: Remove the avocado tests from the
 CI pipelines
Date: Wed,  3 Dec 2025 10:59:03 +0300
Message-ID: <20251203075939.2366131-2-mjt@tls.msk.ru>
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

We are going to move the remaining Avocado tests step by step
into the functional test framework. Unfortunately, Avocado fails
with an error if it cannot determine a test to run, so disable
the tests here now to avoid failures in the Gitlab-CI during the
next steps.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20250414113031.151105-2-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
(cherry picked from commit 22baa5f340d4fe3e7f271d275367b806ef3da834)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/.gitlab-ci.d/buildtest-template.yml b/.gitlab-ci.d/buildtest-template.yml
index 39da7698b0..13fa4f4a4f 100644
--- a/.gitlab-ci.d/buildtest-template.yml
+++ b/.gitlab-ci.d/buildtest-template.yml
@@ -95,7 +95,6 @@
   cache:
     key: "${CI_JOB_NAME}-cache"
     paths:
-      - ${CI_PROJECT_DIR}/avocado-cache
       - ${CI_PROJECT_DIR}/functional-cache
     policy: pull-push
   artifacts:
@@ -109,16 +108,6 @@
     reports:
       junit: build/tests/results/latest/results.xml
   before_script:
-    - mkdir -p ~/.config/avocado
-    - echo "[datadir.paths]" > ~/.config/avocado/avocado.conf
-    - echo "cache_dirs = ['${CI_PROJECT_DIR}/avocado-cache']"
-           >> ~/.config/avocado/avocado.conf
-    - echo -e '[job.output.testlogs]\nstatuses = ["FAIL", "INTERRUPT"]'
-           >> ~/.config/avocado/avocado.conf
-    - if [ -d ${CI_PROJECT_DIR}/avocado-cache ]; then
-        du -chs ${CI_PROJECT_DIR}/*-cache ;
-      fi
-    - export AVOCADO_ALLOW_UNTRUSTED_CODE=1
     - export QEMU_TEST_ALLOW_UNTRUSTED_CODE=1
     - export QEMU_TEST_CACHE_DIR=${CI_PROJECT_DIR}/functional-cache
   after_script:
diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index e22d407dbf..01f7168162 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -29,8 +29,7 @@ functional-system-alpine:
       artifacts: true
   variables:
     IMAGE: alpine
-    MAKE_CHECK_ARGS: check-avocado check-functional
-    AVOCADO_TAGS: arch:avr arch:loongarch64 arch:mips64 arch:mipsel
+    MAKE_CHECK_ARGS: check-functional
 
 build-system-ubuntu:
   extends:
@@ -60,8 +59,7 @@ functional-system-ubuntu:
       artifacts: true
   variables:
     IMAGE: ubuntu2204
-    MAKE_CHECK_ARGS: check-avocado check-functional
-    AVOCADO_TAGS: arch:alpha arch:microblazeel arch:mips64el
+    MAKE_CHECK_ARGS: check-functional
 
 build-system-debian:
   extends:
@@ -92,8 +90,7 @@ functional-system-debian:
       artifacts: true
   variables:
     IMAGE: debian
-    MAKE_CHECK_ARGS: check-avocado check-functional
-    AVOCADO_TAGS: arch:arm arch:i386 arch:riscv64 arch:sh4 arch:sparc arch:xtensa
+    MAKE_CHECK_ARGS: check-functional
 
 crash-test-debian:
   extends: .native_test_job_template
@@ -155,9 +152,7 @@ functional-system-fedora:
       artifacts: true
   variables:
     IMAGE: fedora
-    MAKE_CHECK_ARGS: check-avocado check-functional
-    AVOCADO_TAGS: arch:microblaze arch:mips arch:xtensa arch:m68k
-      arch:riscv32 arch:ppc arch:sparc64
+    MAKE_CHECK_ARGS: check-functional
 
 crash-test-fedora:
   extends: .native_test_job_template
@@ -278,9 +273,7 @@ functional-system-centos:
       artifacts: true
   variables:
     IMAGE: centos9
-    MAKE_CHECK_ARGS: check-avocado check-functional
-    AVOCADO_TAGS: arch:ppc64 arch:or1k arch:s390x arch:x86_64 arch:rx
-      arch:sh4
+    MAKE_CHECK_ARGS: check-functional
 
 build-system-opensuse:
   extends:
@@ -309,8 +302,7 @@ functional-system-opensuse:
       artifacts: true
   variables:
     IMAGE: opensuse-leap
-    MAKE_CHECK_ARGS: check-avocado check-functional
-    AVOCADO_TAGS: arch:s390x arch:x86_64 arch:aarch64
+    MAKE_CHECK_ARGS: check-functional
 
 #
 # Flaky tests. We don't run these by default and they are allow fail
@@ -338,10 +330,9 @@ functional-system-flaky:
   allow_failure: true
   variables:
     IMAGE: debian
-    MAKE_CHECK_ARGS: check-avocado check-functional
+    MAKE_CHECK_ARGS: check-functional
     QEMU_JOB_OPTIONAL: 1
     QEMU_TEST_FLAKY_TESTS: 1
-    AVOCADO_TAGS: flaky
 
 # This jobs explicitly disable TCG (--disable-tcg), KVM is detected by
 # the configure script. The container doesn't contain Xen headers so
@@ -482,8 +473,8 @@ clang-user:
 # Since slirp callbacks are used in QEMU Timers, we cannot use libslirp with
 # CFI builds, and thus have to disable it here.
 #
-# Split in three sets of build/check/avocado to limit the execution time of each
-# job
+# Split in three sets of build/check/functional to limit the execution time
+# of each job
 build-cfi-aarch64:
   extends:
     - .native_build_job_template
@@ -520,7 +511,7 @@ functional-cfi-aarch64:
       artifacts: true
   variables:
     IMAGE: fedora
-    MAKE_CHECK_ARGS: check-avocado check-functional
+    MAKE_CHECK_ARGS: check-functional
 
 build-cfi-ppc64-s390x:
   extends:
@@ -558,7 +549,7 @@ functional-cfi-ppc64-s390x:
       artifacts: true
   variables:
     IMAGE: fedora
-    MAKE_CHECK_ARGS: check-avocado check-functional
+    MAKE_CHECK_ARGS: check-functional
 
 build-cfi-x86_64:
   extends:
@@ -592,7 +583,7 @@ functional-cfi-x86_64:
       artifacts: true
   variables:
     IMAGE: fedora
-    MAKE_CHECK_ARGS: check-avocado check-functional
+    MAKE_CHECK_ARGS: check-functional
 
 tsan-build:
   extends: .native_build_job_template
-- 
2.47.3


