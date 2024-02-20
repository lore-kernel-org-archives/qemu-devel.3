Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12FC0C5475B
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 14:14:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcQsE-00027I-Ci; Tue, 20 Feb 2024 09:13:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1rcP5i-00006M-9S; Tue, 20 Feb 2024 07:19:18 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1rcP5b-0004ML-Ev; Tue, 20 Feb 2024 07:19:15 -0500
Received: from mail.maildlp.com (unknown [172.19.163.44])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TfJH52HHpz1FL8R;
 Tue, 20 Feb 2024 20:14:09 +0800 (CST)
Received: from kwepemi500008.china.huawei.com (unknown [7.221.188.139])
 by mail.maildlp.com (Postfix) with ESMTPS id 071F6140118;
 Tue, 20 Feb 2024 20:19:00 +0800 (CST)
Received: from huawei.com (10.67.174.55) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 20 Feb
 2024 20:18:59 +0800
To: <peter.maydell@linaro.org>, <eduardo@habkost.net>,
 <marcel.apfelbaum@gmail.com>, <philmd@linaro.org>, <wangyanan55@huawei.com>,
 <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: <ruanjinjie@huawei.com>
Subject: [RFC PATCH 1/3] target/arm: Implement FEAT_NMI to support
 Non-maskable Interrupt
Date: Tue, 20 Feb 2024 12:17:50 +0000
Message-ID: <20240220121752.490665-2-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240220121752.490665-1-ruanjinjie@huawei.com>
References: <20240220121752.490665-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.67.174.55]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500008.china.huawei.com (7.221.188.139)
Received-SPF: pass client-ip=45.249.212.191;
 envelope-from=ruanjinjie@huawei.com; helo=szxga05-in.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 20 Feb 2024 09:13:26 -0500
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
Reply-to:  Jinjie Ruan <ruanjinjie@huawei.com>
From:  Jinjie Ruan via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Enable Non-maskable Interrupt feature.

Enable HCRX register feature to support TALLINT read/write.

Add support for enable/disable NMI at qemu startup as below:

	qemu-system-aarch64 -cpu cortex-a53/a57/a72/a76,nmi=[on/off]

Add support for allint read/write as follow:

	mrs <xt>, ALLINT	// read allint
	msr ALLINT, <xt>	// write allint with imm
	msr ALLINT, #<imm>	// write allint with 1 or 0

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 target/arm/cpu-features.h      |  5 +++++
 target/arm/cpu.h               |  2 ++
 target/arm/cpu64.c             | 31 +++++++++++++++++++++++++++++++
 target/arm/helper.c            | 33 +++++++++++++++++++++++++++++++++
 target/arm/internals.h         |  1 +
 target/arm/tcg/a64.decode      |  1 +
 target/arm/tcg/cpu64.c         | 11 +++++++++++
 target/arm/tcg/helper-a64.c    | 25 +++++++++++++++++++++++++
 target/arm/tcg/helper-a64.h    |  1 +
 target/arm/tcg/translate-a64.c | 10 ++++++++++
 10 files changed, 120 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 7567854db6..2ad1179be7 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -681,6 +681,11 @@ static inline bool isar_feature_aa64_sme(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64pfr1, ID_AA64PFR1, SME) != 0;
 }
 
+static inline bool isar_feature_aa64_nmi(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64pfr1, ID_AA64PFR1, NMI) != 0;
+}
+
 static inline bool isar_feature_aa64_tgran4_lpa2(const ARMISARegisters *id)
 {
     return FIELD_SEX64(id->id_aa64mmfr0, ID_AA64MMFR0, TGRAN4) >= 1;
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 63f31e0d98..ea6e8d6501 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -261,6 +261,7 @@ typedef struct CPUArchState {
     uint32_t btype;  /* BTI branch type.  spsr[11:10].  */
     uint64_t daif; /* exception masks, in the bits they are in PSTATE */
     uint64_t svcr; /* PSTATE.{SM,ZA} in the bits they are in SVCR */
+    uint64_t allint; /* All IRQ or FIQ interrupt mask, in the bit in PSTATE */
 
     uint64_t elr_el[4]; /* AArch64 exception link regs  */
     uint64_t sp_el[4]; /* AArch64 banked stack pointers */
@@ -1543,6 +1544,7 @@ FIELD(VTCR, SL2, 33, 1)
 #define PSTATE_D (1U << 9)
 #define PSTATE_BTYPE (3U << 10)
 #define PSTATE_SSBS (1U << 12)
+#define PSTATE_ALLINT (1U << 13)
 #define PSTATE_IL (1U << 20)
 #define PSTATE_SS (1U << 21)
 #define PSTATE_PAN (1U << 22)
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 8e30a7993e..3a5a3fda1b 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -295,6 +295,22 @@ static void cpu_arm_set_sve(Object *obj, bool value, Error **errp)
     cpu->isar.id_aa64pfr0 = t;
 }
 
+static bool cpu_arm_get_nmi(Object *obj, Error **errp)
+{
+    ARMCPU *cpu = ARM_CPU(obj);
+    return cpu_isar_feature(aa64_nmi, cpu);
+}
+
+static void cpu_arm_set_nmi(Object *obj, bool value, Error **errp)
+{
+    ARMCPU *cpu = ARM_CPU(obj);
+    uint64_t t;
+
+    t = cpu->isar.id_aa64pfr1;
+    t = FIELD_DP64(t, ID_AA64PFR1, NMI, value);
+    cpu->isar.id_aa64pfr1 = t;
+}
+
 void arm_cpu_sme_finalize(ARMCPU *cpu, Error **errp)
 {
     uint32_t vq_map = cpu->sme_vq.map;
@@ -472,6 +488,11 @@ void aarch64_add_sme_properties(Object *obj)
 #endif
 }
 
+void aarch64_add_nmi_properties(Object *obj)
+{
+    object_property_add_bool(obj, "nmi", cpu_arm_get_nmi, cpu_arm_set_nmi);
+}
+
 void arm_cpu_pauth_finalize(ARMCPU *cpu, Error **errp)
 {
     ARMPauthFeature features = cpu_isar_feature(pauth_feature, cpu);
@@ -593,9 +614,14 @@ void arm_cpu_lpa2_finalize(ARMCPU *cpu, Error **errp)
 
 static void aarch64_a57_initfn(Object *obj)
 {
+    uint64_t t;
     ARMCPU *cpu = ARM_CPU(obj);
 
     cpu->dtb_compatible = "arm,cortex-a57";
+    t = cpu->isar.id_aa64mmfr1;
+    t = FIELD_DP64(t, ID_AA64MMFR1, HCX, 1);      /* FEAT_HCX */
+    cpu->isar.id_aa64mmfr1 = t;
+    aarch64_add_nmi_properties(obj);
     set_feature(&cpu->env, ARM_FEATURE_V8);
     set_feature(&cpu->env, ARM_FEATURE_NEON);
     set_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER);
@@ -650,9 +676,14 @@ static void aarch64_a57_initfn(Object *obj)
 
 static void aarch64_a53_initfn(Object *obj)
 {
+    uint64_t t;
     ARMCPU *cpu = ARM_CPU(obj);
 
     cpu->dtb_compatible = "arm,cortex-a53";
+    t = cpu->isar.id_aa64mmfr1;
+    t = FIELD_DP64(t, ID_AA64MMFR1, HCX, 1);      /* FEAT_HCX */
+    cpu->isar.id_aa64mmfr1 = t;
+    aarch64_add_nmi_properties(obj);
     set_feature(&cpu->env, ARM_FEATURE_V8);
     set_feature(&cpu->env, ARM_FEATURE_NEON);
     set_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER);
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 90c4fb72ce..1194e1e2db 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -4618,6 +4618,28 @@ static void aa64_daif_write(CPUARMState *env, const ARMCPRegInfo *ri,
     env->daif = value & PSTATE_DAIF;
 }
 
+static void aa64_allint_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                              uint64_t value)
+{
+    if (cpu_isar_feature(aa64_nmi, env_archcpu(env))) {
+        env->allint = value & PSTATE_ALLINT;
+    }
+}
+
+static CPAccessResult aa64_allint_access(CPUARMState *env,
+                                         const ARMCPRegInfo *ri, bool isread)
+{
+    if (arm_current_el(env) == 0) {
+        return CP_ACCESS_TRAP_UNCATEGORIZED;
+    }
+
+    if (arm_current_el(env) == 1 && arm_is_el2_enabled(env) &&
+        cpu_isar_feature(aa64_hcx, env_archcpu(env)) &&
+        (env->cp15.hcrx_el2 & HCRX_TALLINT))
+        return CP_ACCESS_TRAP_EL2;
+    return CP_ACCESS_OK;
+}
+
 static uint64_t aa64_pan_read(CPUARMState *env, const ARMCPRegInfo *ri)
 {
     return env->pstate & PSTATE_PAN;
@@ -5437,6 +5459,12 @@ static const ARMCPRegInfo v8_cp_reginfo[] = {
       .access = PL0_RW, .accessfn = aa64_daif_access,
       .fieldoffset = offsetof(CPUARMState, daif),
       .writefn = aa64_daif_write, .resetfn = arm_cp_reset_ignore },
+    { .name = "ALLINT", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 0, .opc2 = 0, .crn = 4, .crm = 3,
+      .type = ARM_CP_NO_RAW,
+      .access = PL1_RW, .accessfn = aa64_allint_access,
+      .fieldoffset = offsetof(CPUARMState, allint),
+      .writefn = aa64_allint_write, .resetfn = arm_cp_reset_ignore },
     { .name = "FPCR", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 3, .opc2 = 0, .crn = 4, .crm = 4,
       .access = PL0_RW, .type = ARM_CP_FPU | ARM_CP_SUPPRESS_TB_END,
@@ -6056,6 +6084,11 @@ static void hcrx_write(CPUARMState *env, const ARMCPRegInfo *ri,
         valid_mask |= HCRX_MSCEN | HCRX_MCE2;
     }
 
+    /* FEAT_NMI adds TALLINT */
+    if (cpu_isar_feature(aa64_nmi, env_archcpu(env))) {
+        valid_mask |= HCRX_TALLINT;
+    }
+
     /* Clear RES0 bits.  */
     env->cp15.hcrx_el2 = value & valid_mask;
 }
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 50bff44549..2b9f287c52 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1466,6 +1466,7 @@ void aarch64_max_tcg_initfn(Object *obj);
 void aarch64_add_pauth_properties(Object *obj);
 void aarch64_add_sve_properties(Object *obj);
 void aarch64_add_sme_properties(Object *obj);
+void aarch64_add_nmi_properties(Object *obj);
 #endif
 
 /* Read the CONTROL register as the MRS instruction would. */
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 8a20dce3c8..3588080024 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -207,6 +207,7 @@ MSR_i_DIT       1101 0101 0000 0 011 0100 .... 010 11111 @msr_i
 MSR_i_TCO       1101 0101 0000 0 011 0100 .... 100 11111 @msr_i
 MSR_i_DAIFSET   1101 0101 0000 0 011 0100 .... 110 11111 @msr_i
 MSR_i_DAIFCLEAR 1101 0101 0000 0 011 0100 .... 111 11111 @msr_i
+MSR_i_ALLINT    1101 0101 0000 0 001 0100 .... 000 11111 @msr_i
 MSR_i_SVCR      1101 0101 0000 0 011 0100 0 mask:2 imm:1 011 11111
 
 # MRS, MSR (register), SYS, SYSL. These are all essentially the
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 5fba2c0f04..e08eb0ce94 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -293,9 +293,14 @@ static void aarch64_a55_initfn(Object *obj)
 
 static void aarch64_a72_initfn(Object *obj)
 {
+    uint64_t t;
     ARMCPU *cpu = ARM_CPU(obj);
 
     cpu->dtb_compatible = "arm,cortex-a72";
+    t = cpu->isar.id_aa64mmfr1;
+    t = FIELD_DP64(t, ID_AA64MMFR1, HCX, 1);      /* FEAT_HCX */
+    cpu->isar.id_aa64mmfr1 = t;
+    aarch64_add_nmi_properties(obj);
     set_feature(&cpu->env, ARM_FEATURE_V8);
     set_feature(&cpu->env, ARM_FEATURE_NEON);
     set_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER);
@@ -348,9 +353,14 @@ static void aarch64_a72_initfn(Object *obj)
 
 static void aarch64_a76_initfn(Object *obj)
 {
+    uint64_t t;
     ARMCPU *cpu = ARM_CPU(obj);
 
     cpu->dtb_compatible = "arm,cortex-a76";
+    t = cpu->isar.id_aa64mmfr1;
+    t = FIELD_DP64(t, ID_AA64MMFR1, HCX, 1);      /* FEAT_HCX */
+    cpu->isar.id_aa64mmfr1 = t;
+    aarch64_add_nmi_properties(obj);
     set_feature(&cpu->env, ARM_FEATURE_V8);
     set_feature(&cpu->env, ARM_FEATURE_NEON);
     set_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER);
@@ -1175,6 +1185,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64PFR1, RAS_FRAC, 0);  /* FEAT_RASv1p1 + FEAT_DoubleFault */
     t = FIELD_DP64(t, ID_AA64PFR1, SME, 1);       /* FEAT_SME */
     t = FIELD_DP64(t, ID_AA64PFR1, CSV2_FRAC, 0); /* FEAT_CSV2_2 */
+    t = FIELD_DP64(t, ID_AA64PFR1, NMI, 0);       /* FEAT_NMI */
     cpu->isar.id_aa64pfr1 = t;
 
     t = cpu->isar.id_aa64mmfr0;
diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
index ebaa7f00df..9b2a7cd891 100644
--- a/target/arm/tcg/helper-a64.c
+++ b/target/arm/tcg/helper-a64.c
@@ -66,6 +66,31 @@ void HELPER(msr_i_spsel)(CPUARMState *env, uint32_t imm)
     update_spsel(env, imm);
 }
 
+static void allint_check(CPUARMState *env, uint32_t op,
+                       uint32_t imm, uintptr_t ra)
+{
+    /* ALLINT update to PSTATE.*/
+    if (arm_current_el(env) == 0) {
+        raise_exception_ra(env, EXCP_UDEF,
+                           syn_aa64_sysregtrap(0, extract32(op, 0, 3),
+                                               extract32(op, 3, 3), 4,
+                                               imm, 0x1f, 0),
+                           exception_target_el(env), ra);
+    }
+    /* todo */
+}
+
+void HELPER(msr_i_allint)(CPUARMState *env, uint32_t imm)
+{
+    allint_check(env, 0x8, imm, GETPC());
+    if (imm == 1) {
+        env->allint |= PSTATE_ALLINT;
+    } else {
+        env->allint &= ~PSTATE_ALLINT;
+    }
+    arm_rebuild_hflags(env);
+}
+
 static void daif_check(CPUARMState *env, uint32_t op,
                        uint32_t imm, uintptr_t ra)
 {
diff --git a/target/arm/tcg/helper-a64.h b/target/arm/tcg/helper-a64.h
index 575a5dab7d..3aec703d4a 100644
--- a/target/arm/tcg/helper-a64.h
+++ b/target/arm/tcg/helper-a64.h
@@ -22,6 +22,7 @@ DEF_HELPER_FLAGS_1(rbit64, TCG_CALL_NO_RWG_SE, i64, i64)
 DEF_HELPER_2(msr_i_spsel, void, env, i32)
 DEF_HELPER_2(msr_i_daifset, void, env, i32)
 DEF_HELPER_2(msr_i_daifclear, void, env, i32)
+DEF_HELPER_2(msr_i_allint, void, env, i32)
 DEF_HELPER_3(vfp_cmph_a64, i64, f16, f16, ptr)
 DEF_HELPER_3(vfp_cmpeh_a64, i64, f16, f16, ptr)
 DEF_HELPER_3(vfp_cmps_a64, i64, f32, f32, ptr)
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 340265beb0..f1800f7c71 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2036,6 +2036,16 @@ static bool trans_MSR_i_DAIFCLEAR(DisasContext *s, arg_i *a)
     return true;
 }
 
+static bool trans_MSR_i_ALLINT(DisasContext *s, arg_i *a)
+{
+    if (!dc_isar_feature(aa64_nmi, s) || s->current_el == 0) {
+        return false;
+    }
+    gen_helper_msr_i_allint(tcg_env, tcg_constant_i32(a->imm));
+    s->base.is_jmp = DISAS_TOO_MANY;
+    return true;
+}
+
 static bool trans_MSR_i_SVCR(DisasContext *s, arg_MSR_i_SVCR *a)
 {
     if (!dc_isar_feature(aa64_sme, s) || a->mask == 0) {
-- 
2.34.1


