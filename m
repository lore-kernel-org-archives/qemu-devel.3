Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1B4ECFC51E
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 10:34:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMd1Q-0000uW-HE; Fri, 21 Nov 2025 21:06:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMcEM-0000Vc-2Y; Fri, 21 Nov 2025 20:16:02 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMcCK-0005HT-9F; Fri, 21 Nov 2025 20:15:58 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id ACB1D16CA5E;
 Fri, 21 Nov 2025 21:44:24 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 326E2321C9A;
 Fri, 21 Nov 2025 21:44:33 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.7 35/81] target/s390x: Fix missing clock-comparator
 interrupts after reset
Date: Fri, 21 Nov 2025 21:43:34 +0300
Message-ID: <20251121184424.1137669-35-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.7-20251121170317@cover.tls.msk.ru>
References: <qemu-stable-10.0.7-20251121170317@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
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

After reset, CKC value is set to 0, so if clock-comparator interrupts
are enabled, one should occur very shortly thereafter.

Currently the code that loads the respective control register does not
set tod_timer, so this does not happen.

Fix by adding a tcg_s390_tod_updated() call to LCTL and LCTLG.

Cc: qemu-stable@nongnu.org
Suggested-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-ID: <20251016175954.41153-3-iii@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
(cherry picked from commit dacfec5157fb9e2249cf393a143bd545e80a6e31)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/s390x/tcg/mem_helper.c b/target/s390x/tcg/mem_helper.c
index 8187b917ba..116349b17c 100644
--- a/target/s390x/tcg/mem_helper.c
+++ b/target/s390x/tcg/mem_helper.c
@@ -1956,6 +1956,10 @@ void HELPER(lctlg)(CPUS390XState *env, uint32_t r1, uint64_t a2, uint32_t r3)
         if (env->cregs[i] != val && i >= 9 && i <= 11) {
             PERchanged = true;
         }
+        if (i == 0 && !(env->cregs[i] & CR0_CKC_SC) && (val & CR0_CKC_SC)) {
+            BQL_LOCK_GUARD();
+            tcg_s390_tod_updated(env_cpu(env), RUN_ON_CPU_NULL);
+        }
         env->cregs[i] = val;
         HELPER_LOG("load ctl %d from 0x%" PRIx64 " == 0x%" PRIx64 "\n",
                    i, src, val);
@@ -1986,10 +1990,15 @@ void HELPER(lctl)(CPUS390XState *env, uint32_t r1, uint64_t a2, uint32_t r3)
 
     for (i = r1;; i = (i + 1) % 16) {
         uint32_t val = cpu_ldl_data_ra(env, src, ra);
+        uint64_t val64 = deposit64(env->cregs[i], 0, 32, val);
         if ((uint32_t)env->cregs[i] != val && i >= 9 && i <= 11) {
             PERchanged = true;
         }
-        env->cregs[i] = deposit64(env->cregs[i], 0, 32, val);
+        if (i == 0 && !(env->cregs[i] & CR0_CKC_SC) && (val64 & CR0_CKC_SC)) {
+            BQL_LOCK_GUARD();
+            tcg_s390_tod_updated(env_cpu(env), RUN_ON_CPU_NULL);
+        }
+        env->cregs[i] = val64;
         HELPER_LOG("load ctl %d from 0x%" PRIx64 " == 0x%x\n", i, src, val);
         src += sizeof(uint32_t);
 
-- 
2.47.3


