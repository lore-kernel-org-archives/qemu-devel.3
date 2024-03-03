Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BA85C54E49
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Mar 2024 07:42:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rggS0-0001rS-08; Sun, 03 Mar 2024 02:40:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rggRy-0001qb-7H; Sun, 03 Mar 2024 02:39:58 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rggRw-0001lf-IF; Sun, 03 Mar 2024 02:39:57 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 5678A5275A;
 Sun,  3 Mar 2024 10:40:18 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 02EB68E84F;
 Sun,  3 Mar 2024 10:39:35 +0300 (MSK)
Received: (nullmailer pid 1350616 invoked by uid 1000);
 Sun, 03 Mar 2024 07:39:34 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.10 53/54] tests/unit/test-blockjob: Disable
 complete_in_standby test
Date: Sun,  3 Mar 2024 10:39:32 +0300
Message-Id: <20240303073934.1350568-6-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.10-20240303092734@cover.tls.msk.ru>
References: <qemu-stable-7.2.10-20240303092734@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Peter Maydell <peter.maydell@linaro.org>

The blockjob/complete_in_standby test is flaky and fails
intermittently in CI:

172/621 qemu:unit / test-blockjob
           ERROR           0.26s   killed by signal 6 SIGABRT
11:03:46 MALLOC_PERTURB_=176
G_TEST_SRCDIR=/Users/pm215/src/qemu-for-merges/tests/unit
G_TEST_BUILDDIR=/Users/pm215/src/qemu-for-merges/build/all/tests/unit
/Users/pm215/src/qemu-for-merges/build/all/tests/unit/test-blockjob
--tap -k
----------------------------------- output -----------------------------------
stdout:
# random seed: R02S8c79d6e1c01ce0b25475b2210a253242
1..9
# Start of blockjob tests
ok 1 /blockjob/ids
stderr:
Assertion failed: (job->status == JOB_STATUS_STANDBY), function
test_complete_in_standby, file ../../tests/unit/test-blockjob.c, line
499.

Seen on macOS/x86_64, FreeBSD 13/x86_64, msys2-64bit, eg:

https://gitlab.com/qemu-project/qemu/-/jobs/3872508803
https://gitlab.com/qemu-project/qemu/-/jobs/3950667240

Disable this subtest until somebody has time to investigate.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20230317143534.1481947-1-peter.maydell@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
(cherry picked from commit b6903cbe3a2e3feb7204636209b5607e70fee998)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tests/unit/test-blockjob.c b/tests/unit/test-blockjob.c
index c0426bd10c..a130f6fefb 100644
--- a/tests/unit/test-blockjob.c
+++ b/tests/unit/test-blockjob.c
@@ -531,6 +531,13 @@ int main(int argc, char **argv)
     g_test_add_func("/blockjob/cancel/standby", test_cancel_standby);
     g_test_add_func("/blockjob/cancel/pending", test_cancel_pending);
     g_test_add_func("/blockjob/cancel/concluded", test_cancel_concluded);
-    g_test_add_func("/blockjob/complete_in_standby", test_complete_in_standby);
+
+    /*
+     * This test is flaky and sometimes fails in CI and otherwise:
+     * don't run unless user opts in via environment variable.
+     */
+    if (getenv("QEMU_TEST_FLAKY_TESTS")) {
+        g_test_add_func("/blockjob/complete_in_standby", test_complete_in_standby);
+    }
     return g_test_run();
 }
-- 
2.39.2


