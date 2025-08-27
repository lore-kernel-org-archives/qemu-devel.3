Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 337B5CA0FFB
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 17:05:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urJZg-00062q-Rt; Wed, 27 Aug 2025 13:04:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1urJZf-00061O-AG; Wed, 27 Aug 2025 13:04:39 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1urJZT-0007du-GA; Wed, 27 Aug 2025 13:04:37 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 5EDF714C728;
 Wed, 27 Aug 2025 20:03:29 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 6D9332698EE;
 Wed, 27 Aug 2025 20:03:56 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.20 06/18] target/arm/sme: Reset SVE state in
 aarch64_set_svcr()
Date: Wed, 27 Aug 2025 20:03:41 +0300
Message-ID: <20250827170356.2698446-6-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <qemu-stable-7.2.20-20250827180339@cover.tls.msk.ru>
References: <qemu-stable-7.2.20-20250827180339@cover.tls.msk.ru>
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

From: Richard Henderson <richard.henderson@linaro.org>

Move arm_reset_sve_state() calls to aarch64_set_svcr().

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20230112102436.1913-5-philmd@linaro.org
Message-Id: <20230112004322.161330-1-richard.henderson@linaro.org>
[PMD: Split patch in multiple tiny steps]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 7f2a01e7368f960fadea38f437d0f6de7f249686)
(Mjt: re-apply v7.2.15-32-g3559e90146d8 (v9.2.0-1311-g1edc3d43f20d)
 "target/arm: arm_reset_sve_state() should set FPSR, not FPCR"
 on top of this one, as it's been picked up for 7.2.x series earlier
 with adjustments for this change)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/aarch64/cpu_loop.c b/linux-user/aarch64/cpu_loop.c
index d53742e10b..5e93d27d8f 100644
--- a/linux-user/aarch64/cpu_loop.c
+++ b/linux-user/aarch64/cpu_loop.c
@@ -96,7 +96,6 @@ void cpu_loop(CPUARMState *env)
             aarch64_set_svcr(env, 0, R_SVCR_SM_MASK);
             if (FIELD_EX64(env->svcr, SVCR, SM)) {
                 arm_rebuild_hflags(env);
-                arm_reset_sve_state(env);
             }
             ret = do_syscall(env,
                              env->xregs[8],
diff --git a/linux-user/aarch64/signal.c b/linux-user/aarch64/signal.c
index b6e4dcb494..a326a6def5 100644
--- a/linux-user/aarch64/signal.c
+++ b/linux-user/aarch64/signal.c
@@ -665,14 +665,8 @@ static void target_setup_frame(int usig, struct target_sigaction *ka,
         env->btype = 2;
     }
 
-    /*
-     * Invoke the signal handler with both SM and ZA disabled.
-     * When clearing SM, ResetSVEState, per SMSTOP.
-     */
+    /* Invoke the signal handler with both SM and ZA disabled. */
     aarch64_set_svcr(env, 0, R_SVCR_SM_MASK | R_SVCR_ZA_MASK);
-    if (FIELD_EX64(env->svcr, SVCR, SM)) {
-        arm_reset_sve_state(env);
-    }
     if (env->svcr) {
         arm_rebuild_hflags(env);
     }
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 8acfd3af4c..02a084c962 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1119,7 +1119,6 @@ void aarch64_sve_narrow_vq(CPUARMState *env, unsigned vq);
 void aarch64_sve_change_el(CPUARMState *env, int old_el,
                            int new_el, bool el0_a64);
 void aarch64_set_svcr(CPUARMState *env, uint64_t new, uint64_t mask);
-void arm_reset_sve_state(CPUARMState *env);
 
 /*
  * SVE registers are encoded in KVM's memory in an endianness-invariant format.
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 86b97daf7e..7268fccb69 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6429,11 +6429,24 @@ static CPAccessResult access_esm(CPUARMState *env, const ARMCPRegInfo *ri,
     return CP_ACCESS_OK;
 }
 
+/* ResetSVEState */
+static void arm_reset_sve_state(CPUARMState *env)
+{
+    memset(env->vfp.zregs, 0, sizeof(env->vfp.zregs));
+    /* Recall that FFR is stored as pregs[16]. */
+    memset(env->vfp.pregs, 0, sizeof(env->vfp.pregs));
+    vfp_set_fpsr(env, 0x0800009f);
+}
+
 void aarch64_set_svcr(CPUARMState *env, uint64_t new, uint64_t mask)
 {
     uint64_t change = (env->svcr ^ new) & mask;
 
     env->svcr ^= change;
+
+    if (change & R_SVCR_SM_MASK) {
+        arm_reset_sve_state(env);
+    }
 }
 
 static void svcr_write(CPUARMState *env, const ARMCPRegInfo *ri,
diff --git a/target/arm/sme_helper.c b/target/arm/sme_helper.c
index 7717dab64f..56a8fbe691 100644
--- a/target/arm/sme_helper.c
+++ b/target/arm/sme_helper.c
@@ -29,22 +29,12 @@
 #include "vec_internal.h"
 #include "sve_ldst_internal.h"
 
-/* ResetSVEState */
-void arm_reset_sve_state(CPUARMState *env)
-{
-    memset(env->vfp.zregs, 0, sizeof(env->vfp.zregs));
-    /* Recall that FFR is stored as pregs[16]. */
-    memset(env->vfp.pregs, 0, sizeof(env->vfp.pregs));
-    vfp_set_fpsr(env, 0x0800009f);
-}
-
 void helper_set_pstate_sm(CPUARMState *env, uint32_t i)
 {
     if (i == FIELD_EX64(env->svcr, SVCR, SM)) {
         return;
     }
     aarch64_set_svcr(env, 0, R_SVCR_SM_MASK);
-    arm_reset_sve_state(env);
     arm_rebuild_hflags(env);
 }
 
-- 
2.47.2


