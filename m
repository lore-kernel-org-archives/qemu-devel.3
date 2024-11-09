Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17C36D5E36C
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Nov 2024 12:44:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9kU5-00062K-5G; Sat, 09 Nov 2024 07:22:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t9kRx-0003Ew-Jj; Sat, 09 Nov 2024 07:20:22 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t9kRu-0005oF-N9; Sat, 09 Nov 2024 07:20:21 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 06213A165E;
 Sat,  9 Nov 2024 15:08:10 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id BF932167FE4;
 Sat,  9 Nov 2024 15:09:04 +0300 (MSK)
Received: (nullmailer pid 3296289 invoked by uid 1000);
 Sat, 09 Nov 2024 12:09:01 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.1.2 52/58] Revert "target/arm: Fix usage of MMU indexes
 when EL3 is AArch32"
Date: Sat,  9 Nov 2024 15:08:53 +0300
Message-Id: <20241109120901.3295995-52-mjt@tls.msk.ru>
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

This reverts commit 4c2c0474693229c1f533239bb983495c5427784d.

This commit tried to fix a problem with our usage of MMU indexes when
EL3 is AArch32, using what it described as a "more complicated
approach" where we share the same MMU index values for Secure PL1&0
and NonSecure PL1&0. In theory this should work, but the change
didn't account for (at least) two things:

(1) The design change means we need to flush the TLBs at any point
where the CPU state flips from one to the other.  We already flush
the TLB when SCR.NS is changed, but we don't flush the TLB when we
take an exception from NS PL1&0 into Mon or when we return from Mon
to NS PL1&0, and the commit didn't add any code to do that.

(2) The ATS12NS* address translate instructions allow Mon code (which
is Secure) to do a stage 1+2 page table walk for NS.  I thought this
was OK because do_ats_write() does a page table walk which doesn't
use the TLBs, so because it can pass both the MMU index and also an
ARMSecuritySpace argument we can tell the table walk that we want NS
stage1+2, not S.  But that means that all the code within the ptw
that needs to find e.g.  the regime EL cannot do so only with an
mmu_idx -- all these functions like regime_sctlr(), regime_el(), etc
would need to pass both an mmu_idx and the security_space, so they
can tell whether this is a translation regime controlled by EL1 or
EL3 (and so whether to look at SCTLR.S or SCTLR.NS, etc).

In particular, because regime_el() wasn't updated to look at the
ARMSecuritySpace it would return 1 even when the CPU was in Monitor
mode (and the controlling EL is 3).  This meant that page table walks
in Monitor mode would look at the wrong SCTLR, TCR, etc and would
generally fault when they should not.

Rather than trying to make the complicated changes needed to rescue
the design of 4c2c04746932, we revert it in order to instead take the
route that that commit describes as "the most straightforward" fix,
where we add new MMU indexes EL30_0, EL30_3, EL30_3_PAN to correspond
to "Secure PL1&0 at PL0", "Secure PL1&0 at PL1", and "Secure PL1&0 at
PL1 with PAN".

This revert will re-expose the "spurious alignment faults in
Secure PL0" issue #2326; we'll fix it again in the next commit.

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Tested-by: Thomas Huth <thuth@redhat.com>
Message-id: 20241101142845.1712482-2-peter.maydell@linaro.org
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
(cherry picked from commit 056c5c90c171c4895b407af0cf3d198e1d44b40f)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 9a3fd59562..216774f5d3 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2784,7 +2784,8 @@ bool write_cpustate_to_list(ARMCPU *cpu, bool kvm_sync);
  *  + NonSecure PL1 & 0 stage 1
  *  + NonSecure PL1 & 0 stage 2
  *  + NonSecure PL2
- *  + Secure PL1 & 0
+ *  + Secure PL0
+ *  + Secure PL1
  * (reminder: for 32 bit EL3, Secure PL1 is *EL3*, not EL1.)
  *
  * For QEMU, an mmu_idx is not quite the same as a translation regime because:
@@ -2802,39 +2803,37 @@ bool write_cpustate_to_list(ARMCPU *cpu, bool kvm_sync);
  *     The only use of stage 2 translations is either as part of an s1+2
  *     lookup or when loading the descriptors during a stage 1 page table walk,
  *     and in both those cases we don't use the TLB.
- *  4. we want to be able to use the TLB for accesses done as part of a
+ *  4. we can also safely fold together the "32 bit EL3" and "64 bit EL3"
+ *     translation regimes, because they map reasonably well to each other
+ *     and they can't both be active at the same time.
+ *  5. we want to be able to use the TLB for accesses done as part of a
  *     stage1 page table walk, rather than having to walk the stage2 page
  *     table over and over.
- *  5. we need separate EL1/EL2 mmu_idx for handling the Privileged Access
+ *  6. we need separate EL1/EL2 mmu_idx for handling the Privileged Access
  *     Never (PAN) bit within PSTATE.
- *  6. we fold together most secure and non-secure regimes for A-profile,
+ *  7. we fold together most secure and non-secure regimes for A-profile,
  *     because there are no banked system registers for aarch64, so the
  *     process of switching between secure and non-secure is
  *     already heavyweight.
- *  7. we cannot fold together Stage 2 Secure and Stage 2 NonSecure,
+ *  8. we cannot fold together Stage 2 Secure and Stage 2 NonSecure,
  *     because both are in use simultaneously for Secure EL2.
  *
  * This gives us the following list of cases:
  *
- * EL0 EL1&0 stage 1+2 (or AArch32 PL0 PL1&0 stage 1+2)
- * EL1 EL1&0 stage 1+2 (or AArch32 PL1 PL1&0 stage 1+2)
- * EL1 EL1&0 stage 1+2 +PAN (or AArch32 PL1 PL1&0 stage 1+2 +PAN)
+ * EL0 EL1&0 stage 1+2 (aka NS PL0)
+ * EL1 EL1&0 stage 1+2 (aka NS PL1)
+ * EL1 EL1&0 stage 1+2 +PAN
  * EL0 EL2&0
  * EL2 EL2&0
  * EL2 EL2&0 +PAN
  * EL2 (aka NS PL2)
- * EL3 (not used when EL3 is AArch32)
+ * EL3 (aka S PL1)
  * Stage2 Secure
  * Stage2 NonSecure
  * plus one TLB per Physical address space: S, NS, Realm, Root
  *
  * for a total of 14 different mmu_idx.
  *
- * Note that when EL3 is AArch32, the usage is potentially confusing
- * because the MMU indexes are named for their AArch64 use, so code
- * using the ARMMMUIdx_E10_1 might be at EL3, not EL1. This is because
- * Secure PL1 is always at EL3.
- *
  * R profile CPUs have an MPU, but can use the same set of MMU indexes
  * as A profile. They only need to distinguish EL0 and EL1 (and
  * EL2 for cores like the Cortex-R52).
@@ -3127,10 +3126,6 @@ FIELD(TBFLAG_A32, NS, 10, 1)
  * This requires an SME trap from AArch32 mode when using NEON.
  */
 FIELD(TBFLAG_A32, SME_TRAP_NONSTREAMING, 11, 1)
-/*
- * Indicates whether we are in the Secure PL1&0 translation regime
- */
-FIELD(TBFLAG_A32, S_PL1_0, 12, 1)
 
 /*
  * Bit usage when in AArch32 state, for M-profile only.
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 0a582c1cd3..8fb4b474e8 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3700,7 +3700,7 @@ static uint64_t do_ats_write(CPUARMState *env, uint64_t value,
          */
         format64 = arm_s1_regime_using_lpae_format(env, mmu_idx);
 
-        if (arm_feature(env, ARM_FEATURE_EL2) && !arm_aa32_secure_pl1_0(env)) {
+        if (arm_feature(env, ARM_FEATURE_EL2)) {
             if (mmu_idx == ARMMMUIdx_E10_0 ||
                 mmu_idx == ARMMMUIdx_E10_1 ||
                 mmu_idx == ARMMMUIdx_E10_1_PAN) {
@@ -3774,11 +3774,13 @@ static void ats_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
     case 0:
         /* stage 1 current state PL1: ATS1CPR, ATS1CPW, ATS1CPRP, ATS1CPWP */
         switch (el) {
+        case 3:
+            mmu_idx = ARMMMUIdx_E3;
+            break;
         case 2:
             g_assert(ss != ARMSS_Secure);  /* ARMv8.4-SecEL2 is 64-bit only */
             /* fall through */
         case 1:
-        case 3:
             if (ri->crm == 9 && arm_pan_enabled(env)) {
                 mmu_idx = ARMMMUIdx_Stage1_E1_PAN;
             } else {
@@ -11859,11 +11861,8 @@ void arm_cpu_do_interrupt(CPUState *cs)
 
 uint64_t arm_sctlr(CPUARMState *env, int el)
 {
-    if (arm_aa32_secure_pl1_0(env)) {
-        /* In Secure PL1&0 SCTLR_S is always controlling */
-        el = 3;
-    } else if (el == 0) {
-        /* Only EL0 needs to be adjusted for EL1&0 or EL2&0. */
+    /* Only EL0 needs to be adjusted for EL1&0 or EL2&0. */
+    if (el == 0) {
         ARMMMUIdx mmu_idx = arm_mmu_idx_el(env, 0);
         el = mmu_idx == ARMMMUIdx_E20_0 ? 2 : 1;
     }
@@ -12523,12 +12522,8 @@ int fp_exception_el(CPUARMState *env, int cur_el)
     return 0;
 }
 
-/*
- * Return the exception level we're running at if this is our mmu_idx.
- * s_pl1_0 should be true if this is the AArch32 Secure PL1&0 translation
- * regime.
- */
-int arm_mmu_idx_to_el(ARMMMUIdx mmu_idx, bool s_pl1_0)
+/* Return the exception level we're running at if this is our mmu_idx */
+int arm_mmu_idx_to_el(ARMMMUIdx mmu_idx)
 {
     if (mmu_idx & ARM_MMU_IDX_M) {
         return mmu_idx & ARM_MMU_IDX_M_PRIV;
@@ -12540,7 +12535,7 @@ int arm_mmu_idx_to_el(ARMMMUIdx mmu_idx, bool s_pl1_0)
         return 0;
     case ARMMMUIdx_E10_1:
     case ARMMMUIdx_E10_1_PAN:
-        return s_pl1_0 ? 3 : 1;
+        return 1;
     case ARMMMUIdx_E2:
     case ARMMMUIdx_E20_2:
     case ARMMMUIdx_E20_2_PAN:
@@ -12578,15 +12573,6 @@ ARMMMUIdx arm_mmu_idx_el(CPUARMState *env, int el)
             idx = ARMMMUIdx_E10_0;
         }
         break;
-    case 3:
-        /*
-         * AArch64 EL3 has its own translation regime; AArch32 EL3
-         * uses the Secure PL1&0 translation regime.
-         */
-        if (arm_el_is_aa64(env, 3)) {
-            return ARMMMUIdx_E3;
-        }
-        /* fall through */
     case 1:
         if (arm_pan_enabled(env)) {
             idx = ARMMMUIdx_E10_1_PAN;
@@ -12606,6 +12592,8 @@ ARMMMUIdx arm_mmu_idx_el(CPUARMState *env, int el)
             idx = ARMMMUIdx_E2;
         }
         break;
+    case 3:
+        return ARMMMUIdx_E3;
     default:
         g_assert_not_reached();
     }
diff --git a/target/arm/internals.h b/target/arm/internals.h
index d4dc9ab731..1e9223715c 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -275,20 +275,6 @@ FIELD(CNTHCTL, CNTPMASK, 19, 1)
 #define M_FAKE_FSR_NSC_EXEC 0xf /* NS executing in S&NSC memory */
 #define M_FAKE_FSR_SFAULT 0xe /* SecureFault INVTRAN, INVEP or AUVIOL */
 
-/**
- * arm_aa32_secure_pl1_0(): Return true if in Secure PL1&0 regime
- *
- * Return true if the CPU is in the Secure PL1&0 translation regime.
- * This requires that EL3 exists and is AArch32 and we are currently
- * Secure. If this is the case then the ARMMMUIdx_E10* apply and
- * mean we are in EL3, not EL1.
- */
-static inline bool arm_aa32_secure_pl1_0(CPUARMState *env)
-{
-    return arm_feature(env, ARM_FEATURE_EL3) &&
-        !arm_el_is_aa64(env, 3) && arm_is_secure(env);
-}
-
 /**
  * raise_exception: Raise the specified exception.
  * Raise a guest exception with the specified value, syndrome register
@@ -822,12 +808,7 @@ static inline ARMMMUIdx core_to_aa64_mmu_idx(int mmu_idx)
     return mmu_idx | ARM_MMU_IDX_A;
 }
 
-/**
- * Return the exception level we're running at if our current MMU index
- * is @mmu_idx. @s_pl1_0 should be true if this is the AArch32
- * Secure PL1&0 translation regime.
- */
-int arm_mmu_idx_to_el(ARMMMUIdx mmu_idx, bool s_pl1_0);
+int arm_mmu_idx_to_el(ARMMMUIdx mmu_idx);
 
 /* Return the MMU index for a v7M CPU in the specified security state */
 ARMMMUIdx arm_v7m_mmu_idx_for_secstate(CPUARMState *env, bool secstate);
@@ -922,11 +903,11 @@ static inline uint32_t regime_el(CPUARMState *env, ARMMMUIdx mmu_idx)
         return 3;
     case ARMMMUIdx_E10_0:
     case ARMMMUIdx_Stage1_E0:
-    case ARMMMUIdx_E10_1:
-    case ARMMMUIdx_E10_1_PAN:
+        return arm_el_is_aa64(env, 3) || !arm_is_secure_below_el3(env) ? 1 : 3;
     case ARMMMUIdx_Stage1_E1:
     case ARMMMUIdx_Stage1_E1_PAN:
-        return arm_el_is_aa64(env, 3) || !arm_is_secure_below_el3(env) ? 1 : 3;
+    case ARMMMUIdx_E10_1:
+    case ARMMMUIdx_E10_1_PAN:
     case ARMMMUIdx_MPrivNegPri:
     case ARMMMUIdx_MUserNegPri:
     case ARMMMUIdx_MPriv:
diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 26e670290f..20ab736793 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -3576,11 +3576,7 @@ bool get_phys_addr(CPUARMState *env, vaddr address,
     case ARMMMUIdx_Stage1_E1:
     case ARMMMUIdx_Stage1_E1_PAN:
     case ARMMMUIdx_E2:
-        if (arm_aa32_secure_pl1_0(env)) {
-            ss = ARMSS_Secure;
-        } else {
-            ss = arm_security_space_below_el3(env);
-        }
+        ss = arm_security_space_below_el3(env);
         break;
     case ARMMMUIdx_Stage2:
         /*
diff --git a/target/arm/tcg/hflags.c b/target/arm/tcg/hflags.c
index bab7822ef6..f03977b4b0 100644
--- a/target/arm/tcg/hflags.c
+++ b/target/arm/tcg/hflags.c
@@ -198,10 +198,6 @@ static CPUARMTBFlags rebuild_hflags_a32(CPUARMState *env, int fp_el,
         DP_TBFLAG_A32(flags, SME_TRAP_NONSTREAMING, 1);
     }
 
-    if (arm_aa32_secure_pl1_0(env)) {
-        DP_TBFLAG_A32(flags, S_PL1_0, 1);
-    }
-
     return rebuild_hflags_common_32(env, fp_el, mmu_idx, flags);
 }
 
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 4684e7eb6e..bc2d64e883 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -11979,7 +11979,7 @@ static void aarch64_tr_init_disas_context(DisasContextBase *dcbase,
     dc->tbii = EX_TBFLAG_A64(tb_flags, TBII);
     dc->tbid = EX_TBFLAG_A64(tb_flags, TBID);
     dc->tcma = EX_TBFLAG_A64(tb_flags, TCMA);
-    dc->current_el = arm_mmu_idx_to_el(dc->mmu_idx, false);
+    dc->current_el = arm_mmu_idx_to_el(dc->mmu_idx);
 #if !defined(CONFIG_USER_ONLY)
     dc->user = (dc->current_el == 0);
 #endif
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index e2748ff2bb..c5bc691d92 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -7546,6 +7546,10 @@ static void arm_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
 
     core_mmu_idx = EX_TBFLAG_ANY(tb_flags, MMUIDX);
     dc->mmu_idx = core_to_arm_mmu_idx(env, core_mmu_idx);
+    dc->current_el = arm_mmu_idx_to_el(dc->mmu_idx);
+#if !defined(CONFIG_USER_ONLY)
+    dc->user = (dc->current_el == 0);
+#endif
     dc->fp_excp_el = EX_TBFLAG_ANY(tb_flags, FPEXC_EL);
     dc->align_mem = EX_TBFLAG_ANY(tb_flags, ALIGN_MEM);
     dc->pstate_il = EX_TBFLAG_ANY(tb_flags, PSTATE__IL);
@@ -7576,12 +7580,7 @@ static void arm_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
         }
         dc->sme_trap_nonstreaming =
             EX_TBFLAG_A32(tb_flags, SME_TRAP_NONSTREAMING);
-        dc->s_pl1_0 = EX_TBFLAG_A32(tb_flags, S_PL1_0);
     }
-    dc->current_el = arm_mmu_idx_to_el(dc->mmu_idx, dc->s_pl1_0);
-#if !defined(CONFIG_USER_ONLY)
-    dc->user = (dc->current_el == 0);
-#endif
     dc->lse2 = false; /* applies only to aarch64 */
     dc->cp_regs = cpu->cp_regs;
     dc->features = env->features;
diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 3f0e9ceaa3..01c217f4a4 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -165,8 +165,6 @@ typedef struct DisasContext {
     uint8_t gm_blocksize;
     /* True if the current insn_start has been updated. */
     bool insn_start_updated;
-    /* True if this is the AArch32 Secure PL1&0 translation regime */
-    bool s_pl1_0;
     /* Bottom two bits of XScale c15_cpar coprocessor access control reg */
     int c15_cpar;
     /* Offset from VNCR_EL2 when FEAT_NV2 redirects this reg to memory */
-- 
2.39.5


