Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4398C28B30
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Mar 2025 06:20:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ttKrj-0003TY-Ut; Sat, 15 Mar 2025 02:19:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ttKrF-00039p-3Q; Sat, 15 Mar 2025 02:18:53 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ttKrC-0003FO-4K; Sat, 15 Mar 2025 02:18:52 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 844F8FF9D4;
 Sat, 15 Mar 2025 09:17:07 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 5BBC81CAC3D;
 Sat, 15 Mar 2025 09:18:01 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 3E38F558BF; Sat, 15 Mar 2025 09:18:01 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.2.3 08/51] target/arm: Correct errors in WFI/WFE trapping
Date: Sat, 15 Mar 2025 09:17:14 +0300
Message-Id: <20250315061801.622606-8-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.2.3-20250315091645@cover.tls.msk.ru>
References: <qemu-stable-9.2.3-20250315091645@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Peter Maydell <peter.maydell@linaro.org>

The code for WFI/WFE trapping has several errors:
 * it wasn't using arm_sctlr(), so it would look at SCTLR_EL1
   even if the CPU was in the EL2&0 translation regime
 * it was raising UNDEF, not Monitor Trap, for traps to
   AArch32 EL3 because of SCR.{TWE,TWI}
 * it was not honouring SCR.{TWE,TWI} when running in
   AArch32 at EL3 not in Monitor mode
 * it checked SCR.{TWE,TWI} even on v7 CPUs which don't have
   those bits

Fix these bugs.

Cc: qemu-stable@nongnu.org
Fixes: b1eced713d99 ("target-arm: Add WFx instruction trap support")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250130182309.717346-15-peter.maydell@linaro.org
(cherry picked from commit 2b95a2d01b04afadf510a49ac14b38a59be8c5f5)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index 7cde2337ac..5aef45d9c4 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -313,15 +313,19 @@ void HELPER(check_bxj_trap)(CPUARMState *env, uint32_t rm)
 }
 
 #ifndef CONFIG_USER_ONLY
-/* Function checks whether WFx (WFI/WFE) instructions are set up to be trapped.
+/*
+ * Function checks whether WFx (WFI/WFE) instructions are set up to be trapped.
  * The function returns the target EL (1-3) if the instruction is to be trapped;
  * otherwise it returns 0 indicating it is not trapped.
+ * For a trap, *excp is updated with the EXCP_* trap type to use.
  */
-static inline int check_wfx_trap(CPUARMState *env, bool is_wfe)
+static inline int check_wfx_trap(CPUARMState *env, bool is_wfe, uint32_t *excp)
 {
     int cur_el = arm_current_el(env);
     uint64_t mask;
 
+    *excp = EXCP_UDEF;
+
     if (arm_feature(env, ARM_FEATURE_M)) {
         /* M profile cores can never trap WFI/WFE. */
         return 0;
@@ -331,18 +335,9 @@ static inline int check_wfx_trap(CPUARMState *env, bool is_wfe)
      * WFx instructions being trapped to EL1. These trap bits don't exist in v7.
      */
     if (cur_el < 1 && arm_feature(env, ARM_FEATURE_V8)) {
-        int target_el;
-
         mask = is_wfe ? SCTLR_nTWE : SCTLR_nTWI;
-        if (arm_is_secure_below_el3(env) && !arm_el_is_aa64(env, 3)) {
-            /* Secure EL0 and Secure PL1 is at EL3 */
-            target_el = 3;
-        } else {
-            target_el = 1;
-        }
-
-        if (!(env->cp15.sctlr_el[target_el] & mask)) {
-            return target_el;
+        if (!(arm_sctlr(env, cur_el) & mask)) {
+            return exception_target_el(env);
         }
     }
 
@@ -358,9 +353,12 @@ static inline int check_wfx_trap(CPUARMState *env, bool is_wfe)
     }
 
     /* We are not trapping to EL1 or EL2; trap to EL3 if SCR_EL3 requires it */
-    if (cur_el < 3) {
+    if (arm_feature(env, ARM_FEATURE_V8) && !arm_is_el3_or_mon(env)) {
         mask = (is_wfe) ? SCR_TWE : SCR_TWI;
         if (env->cp15.scr_el3 & mask) {
+            if (!arm_el_is_aa64(env, 3)) {
+                *excp = EXCP_MON_TRAP;
+            }
             return 3;
         }
     }
@@ -383,7 +381,8 @@ void HELPER(wfi)(CPUARMState *env, uint32_t insn_len)
     return;
 #else
     CPUState *cs = env_cpu(env);
-    int target_el = check_wfx_trap(env, false);
+    uint32_t excp;
+    int target_el = check_wfx_trap(env, false, &excp);
 
     if (cpu_has_work(cs)) {
         /* Don't bother to go into our "low power state" if
@@ -399,7 +398,7 @@ void HELPER(wfi)(CPUARMState *env, uint32_t insn_len)
             env->regs[15] -= insn_len;
         }
 
-        raise_exception(env, EXCP_UDEF, syn_wfx(1, 0xe, 0, insn_len == 2),
+        raise_exception(env, excp, syn_wfx(1, 0xe, 0, insn_len == 2),
                         target_el);
     }
 
@@ -424,7 +423,8 @@ void HELPER(wfit)(CPUARMState *env, uint64_t timeout)
 #else
     ARMCPU *cpu = env_archcpu(env);
     CPUState *cs = env_cpu(env);
-    int target_el = check_wfx_trap(env, false);
+    uint32_t excp;
+    int target_el = check_wfx_trap(env, false, &excp);
     /* The WFIT should time out when CNTVCT_EL0 >= the specified value. */
     uint64_t cntval = gt_get_countervalue(env);
     uint64_t offset = gt_virt_cnt_offset(env);
@@ -441,8 +441,7 @@ void HELPER(wfit)(CPUARMState *env, uint64_t timeout)
 
     if (target_el) {
         env->pc -= 4;
-        raise_exception(env, EXCP_UDEF, syn_wfx(1, 0xe, 0, false),
-                        target_el);
+        raise_exception(env, excp, syn_wfx(1, 0xe, 0, false), target_el);
     }
 
     if (uadd64_overflow(timeout, offset, &nexttick)) {
-- 
2.39.5


