Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC4C6CF64B1
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 04:32:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMdCc-0002Di-GB; Fri, 21 Nov 2025 21:18:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMd6a-0004S2-NK; Fri, 21 Nov 2025 21:12:04 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMd5w-0003z7-Ue; Fri, 21 Nov 2025 21:12:01 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8E4F716C6F8;
 Fri, 21 Nov 2025 16:51:56 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id E787C321995;
 Fri, 21 Nov 2025 16:52:04 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.1.3 32/76] target/s390x: Fix missing interrupts for small
 CKC values
Date: Fri, 21 Nov 2025 16:51:10 +0300
Message-ID: <20251121135201.1114964-32-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.1.3-20251121155857@cover.tls.msk.ru>
References: <qemu-stable-10.1.3-20251121155857@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

Suppose TOD clock value is 0x1111111111111111 and clock-comparator
value is 0, in which case clock-comparator interruption should occur
immediately.

With the current code, tod2time(env->ckc - td->base.low) ends up being
a very large number, so this interruption never happens.

Fix by firing the timer immediately if env->ckc < td->base.low.

Cc: qemu-stable@nongnu.org
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-ID: <20251016175954.41153-2-iii@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
(cherry picked from commit df7e9243d540ee130f044f975af8de33c45f5299)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/s390x/tcg/misc_helper.c b/target/s390x/tcg/misc_helper.c
index f7101be574..e54338b784 100644
--- a/target/s390x/tcg/misc_helper.c
+++ b/target/s390x/tcg/misc_helper.c
@@ -199,11 +199,15 @@ static void update_ckc_timer(CPUS390XState *env)
         return;
     }
 
-    /* difference between origins */
-    time = env->ckc - td->base.low;
+    if (env->ckc < td->base.low) {
+        time = 0;
+    } else {
+        /* difference between origins */
+        time = env->ckc - td->base.low;
 
-    /* nanoseconds */
-    time = tod2time(time);
+        /* nanoseconds */
+        time = tod2time(time);
+    }
 
     timer_mod(env->tod_timer, time);
 }
-- 
2.47.3


