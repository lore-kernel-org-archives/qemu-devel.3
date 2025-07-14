Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B994C83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 17:08:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubMf9-0002bD-Fc; Mon, 14 Jul 2025 13:08:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ubLZr-00032U-7u
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 11:58:54 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ubLZp-0007nO-37
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 11:58:50 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-74b54cead6cso3054733b3a.1
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 08:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752508728; x=1753113528; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aPqXxRNnNWAbziuZoBkDR4oxusC2l92qyE2WQUEMyYI=;
 b=fBwP9Y3HFRwdLSRvY4I0S+pLaWNxAijGv5t8yTV0HGQR9tSsyebxTJb/SFCEkrJsws
 rUf0Dbn4XX7GS0gr6SudzdvsJv/oyNH1U5oncurDP6OryxGrf7yuoh02CYTfdL1IOuuK
 Dr5BzrLfxQLx9ZPaJBWqb7g5azcTZxVyWWhq97tgxEYLsW9NtcSlaQ2NCvUM0GkLTirE
 /6a4corpgOQzjputO2YxCJWurkvyTnA0PPTPgJT6Z3D9tVo2D4/Q5BUppQQL7pXkFgqf
 pxpcAijg03/kChxPVi6OdK78V11psd5wzcdxmw3fuSVRIrb7j5zCRkdqpKEB2W/5qb0q
 M0mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752508728; x=1753113528;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aPqXxRNnNWAbziuZoBkDR4oxusC2l92qyE2WQUEMyYI=;
 b=jCaVxgL/zJ8ATcYwD229L5bBoP0uPb5yQFvW+6j9dctpDhEDUv+tADuxuQkEp5dtqp
 Yd7A8LbPtqdHg92u+W7wuHjliRZTBzaM1Dr2jiHtLcRrWUa4G5WqdDJMq7txJfv5xsEY
 cQ2uJF4oo5eAqe4YKix+Ju5xxryytqPpprWBEJZy+S93HghfRCx/Skb0ZMPfSor9u+D0
 J5MgZL1d0yQ3GN7xM3x7iT5eoyN0E04aQDFhv6a4pv6mV1WccnhhcxrWuRUIn2AqaSiD
 hRpvOcPYbGrCY26xBQOVoEHi7sQ/Uj5J7anP0Fc8m4yJapzD6v2UJMqCtjGalloUUyqR
 06XQ==
X-Gm-Message-State: AOJu0YwzRz7SoezdRmRAAaCMnFn40opq0b4iGqYDwBfPYZOQL2QJdKtu
 CCwVvNletDpqp/JMfsTpOCP0I1Z5FvWL0dlrilm/bc1SOP/uutcr2VPD7XG5MI/4WE7IOrAivYf
 c1qIgJu4=
X-Gm-Gg: ASbGnctt9+z5X6ylJcGBVXPov8M7QPlfTAKV2na0RfrRgtsueY02Z4u4Hh+XWWPc8Dy
 Kvgag4Ljdrfe3nDzylczX8Og1FDYJal5U8mLZKQTMD0Km08D5UTkib6yTYP0ImDJQNAQjGfBXCG
 tKOD9DEiNhv3MI5dr2WYXjSBXcI0yNuunMST+8IDHgEXFCl+HimOYRZLidrsGE55kwm8ez2RryX
 sgS5SWhyqF0DZgaAnoRMrQ46vUvo4DFtYWyVEbS6TNBJDScKivYz3XoU5T9bQcrcrtTdbhnptlK
 KnqPI63P17HTXZ5zcZWSix6fxLwVhPDGUoaJvH2T8ShtGCrddTqBUC9MvxKbIpyha8WY+7lJ46r
 MiqUcSek0oet9vxyFqzkaKprB3Pr91HoWdn1yrL3pV5Vk4u9VC3Sc
X-Google-Smtp-Source: AGHT+IH35RFtL6/01kctCj62hqhId9u1Sp0NYbDXnVKIzr52Z/vm7gbCRVBDrvt9IHoDuuhqnV7/bA==
X-Received: by 2002:a05:6a00:2395:b0:742:8d52:62f1 with SMTP id
 d2e1a72fcca58-74ee109a1admr21673010b3a.8.1752508727436; 
 Mon, 14 Jul 2025 08:58:47 -0700 (PDT)
Received: from stoup.. ([172.56.179.167]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74eb9f8f24dsm10265805b3a.156.2025.07.14.08.58.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 08:58:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, gustavo.romero@linaro.org, pierrick.bouvier@linaro.org
Subject: [PATCH v8 2/4] target/arm: Implement FEAT_TCR2 and enable with -cpu
 max
Date: Mon, 14 Jul 2025 09:58:33 -0600
Message-ID: <20250714155836.1514748-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250714155836.1514748-1-richard.henderson@linaro.org>
References: <20250714155836.1514748-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Gustavo Romero <gustavo.romero@linaro.org>

Add FEAT_TCR2, which introduces the TCR2_EL1 and TCR2_EL2 registers.
These registers are extensions of the TCR_ELx registers and provide
top-level control of the EL10 and EL20 translation regimes.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Message-ID: <20250711140828.1714666-5-gustavo.romero@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
[rth: Remove FEAT_MEC code; handle SCR and HCRX enable bits.]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu-features.h     |  5 +++
 target/arm/cpu.h              |  2 ++
 target/arm/internals.h        | 19 ++++++++++
 target/arm/cpu.c              |  3 ++
 target/arm/helper.c           | 68 +++++++++++++++++++++++++++++++++++
 target/arm/tcg/cpu64.c        |  1 +
 docs/system/arm/emulation.rst |  1 +
 7 files changed, 99 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index e372543bf3..8ec8c3feb3 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -904,6 +904,11 @@ static inline bool isar_feature_aa64_nv2(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64MMFR2, NV) >= 2;
 }
 
+static inline bool isar_feature_aa64_tcr2(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64MMFR3, TCRX) != 0;
+}
+
 static inline bool isar_feature_aa64_sctlr2(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64MMFR3, SCTLRX) != 0;
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index dda5f275fb..0e247f50c7 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -366,6 +366,7 @@ typedef struct CPUArchState {
         uint64_t vsttbr_el2; /* Secure Virtualization Translation Table. */
         /* MMU translation table base control. */
         uint64_t tcr_el[4];
+        uint64_t tcr2_el[3];
         uint64_t vtcr_el2; /* Virtualization Translation Control.  */
         uint64_t vstcr_el2; /* Secure Virtualization Translation Control. */
         uint32_t c2_data; /* MPU data cacheable bits.  */
@@ -1726,6 +1727,7 @@ static inline void xpsr_write(CPUARMState *env, uint32_t val, uint32_t mask)
 #define SCR_HXEN              (1ULL << 38)
 #define SCR_TRNDR             (1ULL << 40)
 #define SCR_ENTP2             (1ULL << 41)
+#define SCR_TCR2EN            (1ULL << 43)
 #define SCR_SCTLR2EN          (1ULL << 44)
 #define SCR_GPF               (1ULL << 48)
 #define SCR_NSE               (1ULL << 62)
diff --git a/target/arm/internals.h b/target/arm/internals.h
index fcaad39371..b4cd03df69 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -201,6 +201,24 @@ FIELD(CPTR_EL3, TCPAC, 31, 1)
 #define TTBCR_SH1    (1U << 28)
 #define TTBCR_EAE    (1U << 31)
 
+#define TCR2_PNCH    (1ULL << 0)
+#define TCR2_PIE     (1ULL << 1)
+#define TCR2_E0POE   (1ULL << 2)
+#define TCR2_POE     (1ULL << 3)
+#define TCR2_AIE     (1ULL << 4)
+#define TCR2_D128    (1ULL << 5)
+#define TCR2_PTTWI   (1ULL << 10)
+#define TCR2_HAFT    (1ULL << 11)
+#define TCR2_AMEC0   (1ULL << 12)
+#define TCR2_AMEC1   (1ULL << 13)
+#define TCR2_DISCH0  (1ULL << 14)
+#define TCR2_DISCH1  (1ULL << 15)
+#define TCR2_A2      (1ULL << 16)
+#define TCR2_FNG0    (1ULL << 17)
+#define TCR2_FNG1    (1ULL << 18)
+#define TCR2_FNGNA0  (1ULL << 20)
+#define TCR2_FNGNA1  (1ULL << 21)
+
 FIELD(VTCR, T0SZ, 0, 6)
 FIELD(VTCR, SL0, 6, 2)
 FIELD(VTCR, IRGN0, 8, 2)
@@ -232,6 +250,7 @@ FIELD(VTCR, SL2, 33, 1)
 #define HCRX_CMOW     (1ULL << 9)
 #define HCRX_MCE2     (1ULL << 10)
 #define HCRX_MSCEN    (1ULL << 11)
+#define HCRX_TCR2EN   (1ULL << 14)
 #define HCRX_SCTLR2EN (1ULL << 15)
 
 #define HPFAR_NS      (1ULL << 63)
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 2ee895fbc4..e709ca74da 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -645,6 +645,9 @@ void arm_emulate_firmware_reset(CPUState *cpustate, int target_el)
             if (cpu_isar_feature(aa64_fgt, cpu)) {
                 env->cp15.scr_el3 |= SCR_FGTEN;
             }
+            if (cpu_isar_feature(aa64_tcr2, cpu)) {
+               env->cp15.scr_el3 |= SCR_TCR2EN;
+            }
             if (cpu_isar_feature(aa64_sctlr2, cpu)) {
                 env->cp15.scr_el3 |= SCR_SCTLR2EN;
             }
diff --git a/target/arm/helper.c b/target/arm/helper.c
index d0cfef1dd6..1e0e747146 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -741,6 +741,9 @@ static void scr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
         if (cpu_isar_feature(aa64_ecv, cpu)) {
             valid_mask |= SCR_ECVEN;
         }
+        if (cpu_isar_feature(aa64_tcr2, cpu)) {
+            valid_mask |= SCR_TCR2EN;
+        }
         if (cpu_isar_feature(aa64_sctlr2, cpu)) {
             valid_mask |= SCR_SCTLR2EN;
         }
@@ -3922,6 +3925,9 @@ static void hcrx_write(CPUARMState *env, const ARMCPRegInfo *ri,
     if (cpu_isar_feature(aa64_xs, cpu)) {
         valid_mask |= HCRX_FGTNXS | HCRX_FNXS;
     }
+    if (cpu_isar_feature(aa64_tcr2, cpu)) {
+        valid_mask |= HCRX_TCR2EN;
+    }
     if (cpu_isar_feature(aa64_sctlr2, cpu)) {
         valid_mask |= HCRX_SCTLR2EN;
     }
@@ -4524,6 +4530,8 @@ static void define_arm_vh_e2h_redirects_aliases(ARMCPU *cpu)
           "TTBR1_EL1", "TTBR1_EL2", "TTBR1_EL12" },
         { K(3, 0,  2, 0, 2), K(3, 4,  2, 0, 2), K(3, 5, 2, 0, 2),
           "TCR_EL1", "TCR_EL2", "TCR_EL12" },
+        { K(3, 0,  2, 0, 3), K(3, 4,  2, 0, 3), K(3, 5, 2, 0, 3),
+          "TCR2_EL1", "TCR2_EL2", "TCR2_EL12", isar_feature_aa64_tcr2 },
         { K(3, 0,  4, 0, 0), K(3, 4,  4, 0, 0), K(3, 5, 4, 0, 0),
           "SPSR_EL1", "SPSR_EL2", "SPSR_EL12" },
         { K(3, 0,  4, 0, 1), K(3, 4,  4, 0, 1), K(3, 5, 4, 0, 1),
@@ -6068,6 +6076,62 @@ static const ARMCPRegInfo sctlr2_reginfo[] = {
       .fieldoffset = offsetof(CPUARMState, cp15.sctlr2_el[3]) },
 };
 
+static CPAccessResult tcr2_el2_access(CPUARMState *env, const ARMCPRegInfo *ri,
+                                      bool isread)
+{
+    if (arm_current_el(env) < 3
+        && arm_feature(env, ARM_FEATURE_EL3)
+        && !(env->cp15.scr_el3 & SCR_TCR2EN)) {
+        return CP_ACCESS_TRAP_EL3;
+    }
+    return CP_ACCESS_OK;
+}
+
+static CPAccessResult tcr2_el1_access(CPUARMState *env, const ARMCPRegInfo *ri,
+                                      bool isread)
+{
+    CPAccessResult ret = access_tvm_trvm(env, ri, isread);
+    if (ret != CP_ACCESS_OK) {
+        return ret;
+    }
+    if (arm_current_el(env) < 2 && !(arm_hcrx_el2_eff(env) & HCRX_TCR2EN)) {
+        return CP_ACCESS_TRAP_EL2;
+    }
+    return tcr2_el2_access(env, ri, isread);
+}
+
+static void tcr2_el1_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                           uint64_t value)
+{
+    uint64_t valid_mask = 0;
+
+    value &= valid_mask;
+    raw_write(env, ri, value);
+}
+
+static void tcr2_el2_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                           uint64_t value)
+{
+    uint64_t valid_mask = 0;
+
+    value &= valid_mask;
+    raw_write(env, ri, value);
+}
+
+static const ARMCPRegInfo tcr2_reginfo[] = {
+    { .name = "TCR2_EL1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 0, .opc2 = 3, .crn = 2, .crm = 0,
+      .access = PL1_RW, .accessfn = tcr2_el1_access,
+      .writefn = tcr2_el1_write, .fgt = FGT_TCR_EL1,
+      .nv2_redirect_offset = 0x270 | NV2_REDIR_NV1,
+      .fieldoffset = offsetof(CPUARMState, cp15.tcr2_el[1]) },
+    { .name = "TCR2_EL2", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 4, .opc2 = 3, .crn = 2, .crm = 0,
+      .access = PL2_RW, .accessfn = tcr2_el2_access,
+      .writefn = tcr2_el2_write,
+      .fieldoffset = offsetof(CPUARMState, cp15.tcr2_el[2]) },
+};
+
 void register_cp_regs_for_features(ARMCPU *cpu)
 {
     /* Register all the coprocessor registers based on feature bits */
@@ -7301,6 +7365,10 @@ void register_cp_regs_for_features(ARMCPU *cpu)
         define_arm_cp_regs(cpu, sctlr2_reginfo);
     }
 
+    if (cpu_isar_feature(aa64_tcr2, cpu)) {
+        define_arm_cp_regs(cpu, tcr2_reginfo);
+    }
+
     if (cpu_isar_feature(any_predinv, cpu)) {
         define_arm_cp_regs(cpu, predinv_reginfo);
     }
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index f4efff03a5..4eb51420ef 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1248,6 +1248,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     SET_IDREG(isar, ID_AA64MMFR2, t);
 
     t = GET_IDREG(isar, ID_AA64MMFR3);
+    t = FIELD_DP64(t, ID_AA64MMFR3, TCRX, 1);       /* FEAT_TCR2 */
     t = FIELD_DP64(t, ID_AA64MMFR3, SCTLRX, 1);     /* FEAT_SCTLR2 */
     t = FIELD_DP64(t, ID_AA64MMFR3, SPEC_FPACC, 1); /* FEAT_FPACC_SPEC */
     SET_IDREG(isar, ID_AA64MMFR3, t);
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 66043b0747..1c597d8673 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -149,6 +149,7 @@ the following architecture extensions:
 - FEAT_SPECRES (Speculation restriction instructions)
 - FEAT_SSBS (Speculative Store Bypass Safe)
 - FEAT_SSBS2 (MRS and MSR instructions for SSBS version 2)
+- FEAT_TCR2 (Support for TCR2_ELx)
 - FEAT_TGran16K (Support for 16KB memory translation granule size at stage 1)
 - FEAT_TGran4K (Support for 4KB memory translation granule size at stage 1)
 - FEAT_TGran64K (Support for 64KB memory translation granule size at stage 1)
-- 
2.43.0


