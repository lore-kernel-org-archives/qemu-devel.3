Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47033C48BF6
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 08:23:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rchr2-00016Z-II; Wed, 21 Feb 2024 03:21:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rchqt-00014a-7W; Wed, 21 Feb 2024 03:21:15 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rchqp-0002AG-SC; Wed, 21 Feb 2024 03:21:14 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 530384F3C5;
 Wed, 21 Feb 2024 11:21:20 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 1D5B2860A4;
 Wed, 21 Feb 2024 11:20:59 +0300 (MSK)
Received: (nullmailer pid 2142007 invoked by uid 1000);
 Wed, 21 Feb 2024 08:20:58 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Jan=20Kl=C3=B6tzke?= <jan.kloetzke@kernkonzept.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.2 07/60] target/arm: fix exception syndrome for AArch32
 bkpt insn
Date: Wed, 21 Feb 2024 11:19:55 +0300
Message-Id: <20240221082058.2141850-7-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.2-20240221110049@cover.tls.msk.ru>
References: <qemu-stable-8.2.2-20240221110049@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Jan Klötzke <jan.kloetzke@kernkonzept.com>

Debug exceptions that target AArch32 Hyp mode are reported differently
than on AAarch64. Internally, Qemu uses the AArch64 syndromes. Therefore
such exceptions need to be either converted to a prefetch abort
(breakpoints, vector catch) or a data abort (watchpoints).

Cc: qemu-stable@nongnu.org
Signed-off-by: Jan Klötzke <jan.kloetzke@kernkonzept.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240127202758.3326381-1-jan.kloetzke@kernkonzept.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit f670be1aad33e801779af580398895b9455747ee)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 2746d3fdac..6515c5e89c 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -10823,6 +10823,24 @@ static void arm_cpu_do_interrupt_aarch32(CPUState *cs)
     }
 
     if (env->exception.target_el == 2) {
+        /* Debug exceptions are reported differently on AArch32 */
+        switch (syn_get_ec(env->exception.syndrome)) {
+        case EC_BREAKPOINT:
+        case EC_BREAKPOINT_SAME_EL:
+        case EC_AA32_BKPT:
+        case EC_VECTORCATCH:
+            env->exception.syndrome = syn_insn_abort(arm_current_el(env) == 2,
+                                                     0, 0, 0x22);
+            break;
+        case EC_WATCHPOINT:
+            env->exception.syndrome = syn_set_ec(env->exception.syndrome,
+                                                 EC_DATAABORT);
+            break;
+        case EC_WATCHPOINT_SAME_EL:
+            env->exception.syndrome = syn_set_ec(env->exception.syndrome,
+                                                 EC_DATAABORT_SAME_EL);
+            break;
+        }
         arm_cpu_do_interrupt_aarch32_hyp(cs);
         return;
     }
diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
index 95454b5b3b..eccb759da6 100644
--- a/target/arm/syndrome.h
+++ b/target/arm/syndrome.h
@@ -25,6 +25,8 @@
 #ifndef TARGET_ARM_SYNDROME_H
 #define TARGET_ARM_SYNDROME_H
 
+#include "qemu/bitops.h"
+
 /* Valid Syndrome Register EC field values */
 enum arm_exception_class {
     EC_UNCATEGORIZED          = 0x00,
@@ -80,6 +82,7 @@ typedef enum {
     SME_ET_InactiveZA,
 } SMEExceptionType;
 
+#define ARM_EL_EC_LENGTH 6
 #define ARM_EL_EC_SHIFT 26
 #define ARM_EL_IL_SHIFT 25
 #define ARM_EL_ISV_SHIFT 24
@@ -91,6 +94,11 @@ static inline uint32_t syn_get_ec(uint32_t syn)
     return syn >> ARM_EL_EC_SHIFT;
 }
 
+static inline uint32_t syn_set_ec(uint32_t syn, uint32_t ec)
+{
+    return deposit32(syn, ARM_EL_EC_SHIFT, ARM_EL_EC_LENGTH, ec);
+}
+
 /*
  * Utility functions for constructing various kinds of syndrome value.
  * Note that in general we follow the AArch64 syndrome values; in a
-- 
2.39.2


