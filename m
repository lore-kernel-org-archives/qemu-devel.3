Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C6B0D5E368
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Nov 2024 12:33:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9kTj-0005W3-5I; Sat, 09 Nov 2024 07:22:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t9kSM-0003vJ-Qy; Sat, 09 Nov 2024 07:20:48 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t9kSI-0005os-U3; Sat, 09 Nov 2024 07:20:45 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 16B2FA165F;
 Sat,  9 Nov 2024 15:08:10 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id D0355167FE5;
 Sat,  9 Nov 2024 15:09:04 +0300 (MSK)
Received: (nullmailer pid 3296292 invoked by uid 1000);
 Sat, 09 Nov 2024 12:09:01 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.1.2 53/58] target/arm: Add new MMU indexes for AArch32
 Secure PL1&0
Date: Sat,  9 Nov 2024 15:08:54 +0300
Message-Id: <20241109120901.3295995-53-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.1.2-20241109150812@cover.tls.msk.ru>
References: <qemu-stable-9.1.2-20241109150812@cover.tls.msk.ru>
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

Our current usage of MMU indexes when EL3 is AArch32 is confused.
Architecturally, when EL3 is AArch32, all Secure code runs under the
Secure PL1&0 translation regime:
 * code at EL3, which might be Mon, or SVC, or any of the
   other privileged modes (PL1)
 * code at EL0 (Secure PL0)

This is different from when EL3 is AArch64, in which case EL3 is its
own translation regime, and EL1 and EL0 (whether AArch32 or AArch64)
have their own regime.

We claimed to be mapping Secure PL1 to our ARMMMUIdx_EL3, but didn't
do anything special about Secure PL0, which meant it used the same
ARMMMUIdx_EL10_0 that NonSecure PL0 does.  This resulted in a bug
where arm_sctlr() incorrectly picked the NonSecure SCTLR as the
controlling register when in Secure PL0, which meant we were
spuriously generating alignment faults because we were looking at the
wrong SCTLR control bits.

The use of ARMMMUIdx_EL3 for Secure PL1 also resulted in the bug that
we wouldn't honour the PAN bit for Secure PL1, because there's no
equivalent _PAN mmu index for it.

Fix this by adding two new MMU indexes:
 * ARMMMUIdx_E30_0 is for Secure PL0
 * ARMMMUIdx_E30_3_PAN is for Secure PL1 when PAN is enabled
The existing ARMMMUIdx_E3 is used to mean "Secure PL1 without PAN"
(and would be named ARMMMUIdx_E30_3 in an AArch32-centric scheme).

These extra two indexes bring us up to the maximum of 16 that the
core code can currently support.

This commit:
 * adds the new MMU index handling to the various places
   where we deal in MMU index values
 * adds assertions that we aren't AArch32 EL3 in a couple of
   places that currently use the E10 indexes, to document why
   they don't also need to handle the E30 indexes
 * documents in a comment why regime_has_2_ranges() doesn't need
   updating

Notes for backporting: this commit depends on the preceding revert of
4c2c04746932; that revert and this commit should probably be
backported to everywhere that we originally backported 4c2c04746932.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2326
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2588
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Tested-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241101142845.1712482-3-peter.maydell@linaro.org
(cherry picked from commit efbe180ad2ed75d4cc64dfc6fb46a015eef713d1)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 216774f5d3..28fac238a5 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2784,8 +2784,7 @@ bool write_cpustate_to_list(ARMCPU *cpu, bool kvm_sync);
  *  + NonSecure PL1 & 0 stage 1
  *  + NonSecure PL1 & 0 stage 2
  *  + NonSecure PL2
- *  + Secure PL0
- *  + Secure PL1
+ *  + Secure PL1 & 0
  * (reminder: for 32 bit EL3, Secure PL1 is *EL3*, not EL1.)
  *
  * For QEMU, an mmu_idx is not quite the same as a translation regime because:
@@ -2820,19 +2819,21 @@ bool write_cpustate_to_list(ARMCPU *cpu, bool kvm_sync);
  *
  * This gives us the following list of cases:
  *
- * EL0 EL1&0 stage 1+2 (aka NS PL0)
- * EL1 EL1&0 stage 1+2 (aka NS PL1)
- * EL1 EL1&0 stage 1+2 +PAN
+ * EL0 EL1&0 stage 1+2 (aka NS PL0 PL1&0 stage 1+2)
+ * EL1 EL1&0 stage 1+2 (aka NS PL1 PL1&0 stage 1+2)
+ * EL1 EL1&0 stage 1+2 +PAN (aka NS PL1 P1&0 stage 1+2 +PAN)
  * EL0 EL2&0
  * EL2 EL2&0
  * EL2 EL2&0 +PAN
  * EL2 (aka NS PL2)
- * EL3 (aka S PL1)
+ * EL3 (aka AArch32 S PL1 PL1&0)
+ * AArch32 S PL0 PL1&0 (we call this EL30_0)
+ * AArch32 S PL1 PL1&0 +PAN (we call this EL30_3_PAN)
  * Stage2 Secure
  * Stage2 NonSecure
  * plus one TLB per Physical address space: S, NS, Realm, Root
  *
- * for a total of 14 different mmu_idx.
+ * for a total of 16 different mmu_idx.
  *
  * R profile CPUs have an MPU, but can use the same set of MMU indexes
  * as A profile. They only need to distinguish EL0 and EL1 (and
@@ -2896,6 +2897,8 @@ typedef enum ARMMMUIdx {
     ARMMMUIdx_E20_2_PAN = 5 | ARM_MMU_IDX_A,
     ARMMMUIdx_E2        = 6 | ARM_MMU_IDX_A,
     ARMMMUIdx_E3        = 7 | ARM_MMU_IDX_A,
+    ARMMMUIdx_E30_0     = 8 | ARM_MMU_IDX_A,
+    ARMMMUIdx_E30_3_PAN = 9 | ARM_MMU_IDX_A,
 
     /*
      * Used for second stage of an S12 page table walk, or for descriptor
@@ -2903,14 +2906,14 @@ typedef enum ARMMMUIdx {
      * are in use simultaneously for SecureEL2: the security state for
      * the S2 ptw is selected by the NS bit from the S1 ptw.
      */
-    ARMMMUIdx_Stage2_S  = 8 | ARM_MMU_IDX_A,
-    ARMMMUIdx_Stage2    = 9 | ARM_MMU_IDX_A,
+    ARMMMUIdx_Stage2_S  = 10 | ARM_MMU_IDX_A,
+    ARMMMUIdx_Stage2    = 11 | ARM_MMU_IDX_A,
 
     /* TLBs with 1-1 mapping to the physical address spaces. */
-    ARMMMUIdx_Phys_S     = 10 | ARM_MMU_IDX_A,
-    ARMMMUIdx_Phys_NS    = 11 | ARM_MMU_IDX_A,
-    ARMMMUIdx_Phys_Root  = 12 | ARM_MMU_IDX_A,
-    ARMMMUIdx_Phys_Realm = 13 | ARM_MMU_IDX_A,
+    ARMMMUIdx_Phys_S     = 12 | ARM_MMU_IDX_A,
+    ARMMMUIdx_Phys_NS    = 13 | ARM_MMU_IDX_A,
+    ARMMMUIdx_Phys_Root  = 14 | ARM_MMU_IDX_A,
+    ARMMMUIdx_Phys_Realm = 15 | ARM_MMU_IDX_A,
 
     /*
      * These are not allocated TLBs and are used only for AT system
@@ -2949,6 +2952,8 @@ typedef enum ARMMMUIdxBit {
     TO_CORE_BIT(E20_2),
     TO_CORE_BIT(E20_2_PAN),
     TO_CORE_BIT(E3),
+    TO_CORE_BIT(E30_0),
+    TO_CORE_BIT(E30_3_PAN),
     TO_CORE_BIT(Stage2),
     TO_CORE_BIT(Stage2_S),
 
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 8fb4b474e8..2b6d0bff8c 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -444,6 +444,9 @@ static int alle1_tlbmask(CPUARMState *env)
      * Note that the 'ALL' scope must invalidate both stage 1 and
      * stage 2 translations, whereas most other scopes only invalidate
      * stage 1 translations.
+     *
+     * For AArch32 this is only used for TLBIALLNSNH and VTTBR
+     * writes, so only needs to apply to NS PL1&0, not S PL1&0.
      */
     return (ARMMMUIdxBit_E10_1 |
             ARMMMUIdxBit_E10_1_PAN |
@@ -3775,7 +3778,11 @@ static void ats_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
         /* stage 1 current state PL1: ATS1CPR, ATS1CPW, ATS1CPRP, ATS1CPWP */
         switch (el) {
         case 3:
-            mmu_idx = ARMMMUIdx_E3;
+            if (ri->crm == 9 && arm_pan_enabled(env)) {
+                mmu_idx = ARMMMUIdx_E30_3_PAN;
+            } else {
+                mmu_idx = ARMMMUIdx_E3;
+            }
             break;
         case 2:
             g_assert(ss != ARMSS_Secure);  /* ARMv8.4-SecEL2 is 64-bit only */
@@ -3795,7 +3802,7 @@ static void ats_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
         /* stage 1 current state PL0: ATS1CUR, ATS1CUW */
         switch (el) {
         case 3:
-            mmu_idx = ARMMMUIdx_E10_0;
+            mmu_idx = ARMMMUIdx_E30_0;
             break;
         case 2:
             g_assert(ss != ARMSS_Secure);  /* ARMv8.4-SecEL2 is 64-bit only */
@@ -4905,11 +4912,14 @@ static int vae1_tlbmask(CPUARMState *env)
     uint64_t hcr = arm_hcr_el2_eff(env);
     uint16_t mask;
 
+    assert(arm_feature(env, ARM_FEATURE_AARCH64));
+
     if ((hcr & (HCR_E2H | HCR_TGE)) == (HCR_E2H | HCR_TGE)) {
         mask = ARMMMUIdxBit_E20_2 |
                ARMMMUIdxBit_E20_2_PAN |
                ARMMMUIdxBit_E20_0;
     } else {
+        /* This is AArch64 only, so we don't need to touch the EL30_x TLBs */
         mask = ARMMMUIdxBit_E10_1 |
                ARMMMUIdxBit_E10_1_PAN |
                ARMMMUIdxBit_E10_0;
@@ -4948,6 +4958,8 @@ static int vae1_tlbbits(CPUARMState *env, uint64_t addr)
     uint64_t hcr = arm_hcr_el2_eff(env);
     ARMMMUIdx mmu_idx;
 
+    assert(arm_feature(env, ARM_FEATURE_AARCH64));
+
     /* Only the regime of the mmu_idx below is significant. */
     if ((hcr & (HCR_E2H | HCR_TGE)) == (HCR_E2H | HCR_TGE)) {
         mmu_idx = ARMMMUIdx_E20_0;
@@ -11861,10 +11873,20 @@ void arm_cpu_do_interrupt(CPUState *cs)
 
 uint64_t arm_sctlr(CPUARMState *env, int el)
 {
-    /* Only EL0 needs to be adjusted for EL1&0 or EL2&0. */
+    /* Only EL0 needs to be adjusted for EL1&0 or EL2&0 or EL3&0 */
     if (el == 0) {
         ARMMMUIdx mmu_idx = arm_mmu_idx_el(env, 0);
-        el = mmu_idx == ARMMMUIdx_E20_0 ? 2 : 1;
+        switch (mmu_idx) {
+        case ARMMMUIdx_E20_0:
+            el = 2;
+            break;
+        case ARMMMUIdx_E30_0:
+            el = 3;
+            break;
+        default:
+            el = 1;
+            break;
+        }
     }
     return env->cp15.sctlr_el[el];
 }
@@ -12532,6 +12554,7 @@ int arm_mmu_idx_to_el(ARMMMUIdx mmu_idx)
     switch (mmu_idx) {
     case ARMMMUIdx_E10_0:
     case ARMMMUIdx_E20_0:
+    case ARMMMUIdx_E30_0:
         return 0;
     case ARMMMUIdx_E10_1:
     case ARMMMUIdx_E10_1_PAN:
@@ -12541,6 +12564,7 @@ int arm_mmu_idx_to_el(ARMMMUIdx mmu_idx)
     case ARMMMUIdx_E20_2_PAN:
         return 2;
     case ARMMMUIdx_E3:
+    case ARMMMUIdx_E30_3_PAN:
         return 3;
     default:
         g_assert_not_reached();
@@ -12569,6 +12593,9 @@ ARMMMUIdx arm_mmu_idx_el(CPUARMState *env, int el)
         hcr = arm_hcr_el2_eff(env);
         if ((hcr & (HCR_E2H | HCR_TGE)) == (HCR_E2H | HCR_TGE)) {
             idx = ARMMMUIdx_E20_0;
+        } else if (arm_is_secure_below_el3(env) &&
+                   !arm_el_is_aa64(env, 3)) {
+            idx = ARMMMUIdx_E30_0;
         } else {
             idx = ARMMMUIdx_E10_0;
         }
@@ -12593,6 +12620,9 @@ ARMMMUIdx arm_mmu_idx_el(CPUARMState *env, int el)
         }
         break;
     case 3:
+        if (!arm_el_is_aa64(env, 3) && arm_pan_enabled(env)) {
+            return ARMMMUIdx_E30_3_PAN;
+        }
         return ARMMMUIdx_E3;
     default:
         g_assert_not_reached();
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 1e9223715c..56d33f4c40 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -852,7 +852,16 @@ static inline void arm_call_el_change_hook(ARMCPU *cpu)
     }
 }
 
-/* Return true if this address translation regime has two ranges.  */
+/*
+ * Return true if this address translation regime has two ranges.
+ * Note that this will not return the correct answer for AArch32
+ * Secure PL1&0 (i.e. mmu indexes E3, E30_0, E30_3_PAN), but it is
+ * never called from a context where EL3 can be AArch32. (The
+ * correct return value for ARMMMUIdx_E3 would be different for
+ * that case, so we can't just make the function return the
+ * correct value anyway; we would need an extra "bool e3_is_aarch32"
+ * argument which all the current callsites would pass as 'false'.)
+ */
 static inline bool regime_has_2_ranges(ARMMMUIdx mmu_idx)
 {
     switch (mmu_idx) {
@@ -877,6 +886,7 @@ static inline bool regime_is_pan(CPUARMState *env, ARMMMUIdx mmu_idx)
     case ARMMMUIdx_Stage1_E1_PAN:
     case ARMMMUIdx_E10_1_PAN:
     case ARMMMUIdx_E20_2_PAN:
+    case ARMMMUIdx_E30_3_PAN:
         return true;
     default:
         return false;
@@ -900,10 +910,11 @@ static inline uint32_t regime_el(CPUARMState *env, ARMMMUIdx mmu_idx)
     case ARMMMUIdx_E2:
         return 2;
     case ARMMMUIdx_E3:
+    case ARMMMUIdx_E30_0:
+    case ARMMMUIdx_E30_3_PAN:
         return 3;
     case ARMMMUIdx_E10_0:
     case ARMMMUIdx_Stage1_E0:
-        return arm_el_is_aa64(env, 3) || !arm_is_secure_below_el3(env) ? 1 : 3;
     case ARMMMUIdx_Stage1_E1:
     case ARMMMUIdx_Stage1_E1_PAN:
     case ARMMMUIdx_E10_1:
@@ -927,6 +938,7 @@ static inline bool regime_is_user(CPUARMState *env, ARMMMUIdx mmu_idx)
     switch (mmu_idx) {
     case ARMMMUIdx_E10_0:
     case ARMMMUIdx_E20_0:
+    case ARMMMUIdx_E30_0:
     case ARMMMUIdx_Stage1_E0:
     case ARMMMUIdx_MUser:
     case ARMMMUIdx_MSUser:
diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 20ab736793..65d7b07bc5 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -265,6 +265,8 @@ static bool regime_translation_disabled(CPUARMState *env, ARMMMUIdx mmu_idx,
     case ARMMMUIdx_E20_2_PAN:
     case ARMMMUIdx_E2:
     case ARMMMUIdx_E3:
+    case ARMMMUIdx_E30_0:
+    case ARMMMUIdx_E30_3_PAN:
         break;
 
     case ARMMMUIdx_Phys_S:
@@ -3604,6 +3606,8 @@ bool get_phys_addr(CPUARMState *env, vaddr address,
         ss = ARMSS_Secure;
         break;
     case ARMMMUIdx_E3:
+    case ARMMMUIdx_E30_0:
+    case ARMMMUIdx_E30_3_PAN:
         if (arm_feature(env, ARM_FEATURE_AARCH64) &&
             cpu_isar_feature(aa64_rme, env_archcpu(env))) {
             ss = ARMSS_Root;
diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index c083e5cfb8..1ecb465988 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -912,7 +912,19 @@ void HELPER(tidcp_el0)(CPUARMState *env, uint32_t syndrome)
 {
     /* See arm_sctlr(), but we also need the sctlr el. */
     ARMMMUIdx mmu_idx = arm_mmu_idx_el(env, 0);
-    int target_el = mmu_idx == ARMMMUIdx_E20_0 ? 2 : 1;
+    int target_el;
+
+    switch (mmu_idx) {
+    case ARMMMUIdx_E20_0:
+        target_el = 2;
+        break;
+    case ARMMMUIdx_E30_0:
+        target_el = 3;
+        break;
+    default:
+        target_el = 1;
+        break;
+    }
 
     /*
      * The bit is not valid unless the target el is aa64, but since the
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index c5bc691d92..9ee761fc64 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -228,6 +228,9 @@ static inline int get_a32_user_mem_index(DisasContext *s)
      */
     switch (s->mmu_idx) {
     case ARMMMUIdx_E3:
+    case ARMMMUIdx_E30_0:
+    case ARMMMUIdx_E30_3_PAN:
+        return arm_to_core_mmu_idx(ARMMMUIdx_E30_0);
     case ARMMMUIdx_E2:        /* this one is UNPREDICTABLE */
     case ARMMMUIdx_E10_0:
     case ARMMMUIdx_E10_1:
-- 
2.39.5


