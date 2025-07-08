Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA9E8C83F09
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 21:20:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZFEu-0007rZ-Nj; Tue, 08 Jul 2025 16:48:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uZDr8-0007hK-JW
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:20:00 -0400
Received: from mail-qv1-xf30.google.com ([2607:f8b0:4864:20::f30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uZDr0-00089w-E5
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:19:49 -0400
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-702cbfe860cso44364426d6.1
 for <qemu-devel@nongnu.org>; Tue, 08 Jul 2025 12:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752002361; x=1752607161; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4llhfjCo4niQ3JvItczArHlabZV5Ziu1f63HFSylXpQ=;
 b=rVomrU7oxAKN/3/+V3yPsNL6FSG59MuHP8aPKc+Y1gkiDBz746FkT6UIVqLQULcMhY
 oLbItcS/D2jdDE8ESwBDk8WgMoOsth6muQbimhPVW7PFBvFC/cQpDHMYMAXOx3txDFOV
 Yk6RqSb9nMTOXVJXonhtvZvQGPRP3zyXlqUwQ7MLmy8TLMGqRpJVt9f0uheJGGuheusD
 lzKXdqNEZLJwM1yXWRRIi0W2bMrR8ux1YuBhG3oymdQVxPiC3mZmP7T6hx8AxR5pUwuD
 R7p2jALU1ojJ/nkb7oV/wCNkruutC8bjGMXE2SX9Dlls3tqSUgDuArDrazWWhEl7AikX
 BTrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752002361; x=1752607161;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4llhfjCo4niQ3JvItczArHlabZV5Ziu1f63HFSylXpQ=;
 b=q8+Iw3tDk6BmTxrUfDmWsl8qQjHjjcKHmraroE8NFtQ1OkHLuAf+NZ0gyAPWaTPO/d
 Ti/yJfo8Edo0UZArrdP7PRcD6MWAgk3gygTOF7T9ZFXKMx4Y/NsCngfkpNArm7vrN23n
 f4niifRvB3VKgsaDzQWkiOWGEuBFfgbkcsrVgfrYsHp1VU+R56vMVdDVAFqDAFCHyF2P
 Zo+R9ukeRJaKFmcB6Zt8RzXrGfCssklaqMlHPVki3l0nDmEBiu+ttA7xDfDo2f4heYaY
 Zbm8u2HQ1sOWaOih6+O4M0n6s5rQjlEnrcUIhnHFBeTEqZErA8GKWh7mjl7FXoFbCMKF
 Wbcw==
X-Gm-Message-State: AOJu0Yws5I3dy9KKhSxnQh5VLVvp9OWSKHIXi3wwGobSWOBzu4vbNUus
 6dfkTZnSu8ayvRBGSzlBn5DzarWfPyFekV+jxHqJ9RO40UwTbllolTsRXEoZVX2ATWo=
X-Gm-Gg: ASbGncvw8hQ3c/d4QKCDMX3vlw2sfq3BaIY9CVQ8n5rt+2TrWuGaH1fZ6AXiTRZ6E//
 +HszdvwgOSqDHfH2jY4pJu+Bs2s0M3On8eIkPzdmPB4+B846O2aKROmJeJc90m6yA0BQyO2t4WY
 t3FYgd24ieugoQ5SLoYyE2SOSX/dkJwJGwyavrtxTtk19/JEizN1QXsKHqWaWEYUfLtxCDqqN3h
 LtxPXhgBKYTZNPejjCF6Ohy08nHT22MnwTQSBfb/w5SWtIOb60vVL3mxz+3e13qQLpRb0fhYqN4
 lhBL7T1poOjZ64MZURiPug3Frr76Y/F+0rUy/wo+W8+5WnV8BOyBeqgR1jYfYkbABEQ=
X-Google-Smtp-Source: AGHT+IG3M5ZvJmu9Yg60Qcstv00Jikbk6t3DEz/Y1ZZ0G2PkCv3ffJ45GOUn9h966Qfy25wL/tko2g==
X-Received: by 2002:a05:6214:29cd:b0:6fd:5d38:b07d with SMTP id
 6a1803df08f44-7047db196f3mr61258076d6.41.1752002361177; 
 Tue, 08 Jul 2025 12:19:21 -0700 (PDT)
Received: from gromero0.. ([189.110.24.38]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-702d638846asm56289096d6.22.2025.07.08.12.19.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Jul 2025 12:19:20 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-arm@nongnu.org, richard.henderson@linaro.org, alex.bennee@linaro.org
Cc: qemu-devel@nongnu.org,
	gustavo.romero@linaro.org
Subject: [RFC PATCH-for-10.1 v3 4/5] target/arm: Add FEAT_TCR2
Date: Tue,  8 Jul 2025 19:17:03 +0000
Message-Id: <20250708191704.1068604-5-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250708191704.1068604-1-gustavo.romero@linaro.org>
References: <20250708191704.1068604-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f30;
 envelope-from=gustavo.romero@linaro.org; helo=mail-qv1-xf30.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add FEAT_TCR2, which introduces the TCR2_EL1 and TCR2_EL2 registers.
These registers are extensions of the TCR_ELx registers and provide
top-level control of the EL10 and EL20 translation regimes.

Since the bits in these registers depend on other CPU features, and only
FEAT_MEC is supported at the moment, the FEAT_TCR2 only implements the
AMEC bits for now.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 docs/system/arm/emulation.rst |  1 +
 target/arm/cpu-features.h     |  5 +++
 target/arm/cpu.h              |  2 ++
 target/arm/helper.c           | 60 +++++++++++++++++++++++++++++++++++
 target/arm/internals.h        | 19 +++++++++++
 target/arm/tcg/cpu64.c        |  1 +
 6 files changed, 88 insertions(+)

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
diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 44d6b655a9..3878aed589 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -486,6 +486,11 @@ static inline bool isar_feature_aa64_xs(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64ISAR1, XS) != 0;
 }
 
+static inline bool isar_feature_aa64_tcr2(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64MMFR3, TCRX) != 0;
+}
+
 /*
  * These are the values from APA/API/APA3.
  * In general these must be compared '>=', per the normal Arm ARM
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 32d30b7bb9..5c13f89b29 100644
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
@@ -1739,6 +1740,7 @@ static inline void xpsr_write(CPUARMState *env, uint32_t val, uint32_t mask)
 #define SCR_HXEN              (1ULL << 38)
 #define SCR_TRNDR             (1ULL << 40)
 #define SCR_ENTP2             (1ULL << 41)
+#define SCR_TCR2EN            (1ULL << 43)
 #define SCR_SCTLR2EN          (1ULL << 44)
 #define SCR_GPF               (1ULL << 48)
 #define SCR_MECEN             (1ULL << 49)
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 5707eea822..34e12bde90 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6154,6 +6154,8 @@ static void define_arm_vh_e2h_redirects_aliases(ARMCPU *cpu)
           "TTBR1_EL1", "TTBR1_EL2", "TTBR1_EL12" },
         { K(3, 0,  2, 0, 2), K(3, 4,  2, 0, 2), K(3, 5, 2, 0, 2),
           "TCR_EL1", "TCR_EL2", "TCR_EL12" },
+        { K(3, 0,  2, 0, 3), K(3, 4,  2, 0, 3), K(3, 5, 2, 0, 3),
+          "TCR2_EL1", "TCR2_EL2", "TCR2_EL12" },
         { K(3, 0,  4, 0, 0), K(3, 4,  4, 0, 0), K(3, 5, 4, 0, 0),
           "SPSR_EL1", "SPSR_EL2", "SPSR_EL12" },
         { K(3, 0,  4, 0, 1), K(3, 4,  4, 0, 1), K(3, 5, 4, 0, 1),
@@ -7890,6 +7892,60 @@ static const ARMCPRegInfo sctlr2_reginfo[] = {
       .fieldoffset = offsetof(CPUARMState, cp15.sctlr2_el[3]) },
 };
 
+static CPAccessResult tcr2_el2_access(CPUARMState *env, const ARMCPRegInfo *ri,
+                                      bool isread)
+{
+    if (arm_current_el(env) < 3 && !(env->cp15.scr_el3 & SCR_TCR2EN)) {
+        return CP_ACCESS_TRAP_EL3;
+    }
+    return CP_ACCESS_OK;
+};
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
+    /* This register does not control any feature yet. */
+}
+
+static void tcr2_el2_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                           uint64_t value)
+{
+    uint64_t valid_mask = 0;
+
+    if (cpu_isar_feature(aa64_mec, env_archcpu(env))) {
+        valid_mask |= TCR2_AMEC0 | TCR2_AMEC1;
+    }
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
@@ -9162,6 +9218,10 @@ void register_cp_regs_for_features(ARMCPU *cpu)
         define_arm_cp_regs(cpu, sctlr2_reginfo);
     }
 
+    if (cpu_isar_feature(aa64_tcr2, cpu)) {
+        define_arm_cp_regs(cpu, tcr2_reginfo);
+    }
+
     if (cpu_isar_feature(any_predinv, cpu)) {
         define_arm_cp_regs(cpu, predinv_reginfo);
     }
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 398e0b4a7d..4b3dde82c6 100644
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
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index bdd2fe7f5b..173528175a 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1247,6 +1247,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64MMFR2, E0PD, 1);     /* FEAT_E0PD */
     SET_IDREG(isar, ID_AA64MMFR2, t);
 
+    FIELD_DP64_IDREG(isar, ID_AA64MMFR3, TCRX, 1);       /* FEAT_TCR2 */
     FIELD_DP64_IDREG(isar, ID_AA64MMFR3, SCTLRX, 1);     /* FEAT_SCTLR2 */
     FIELD_DP64_IDREG(isar, ID_AA64MMFR3, SPEC_FPACC, 1); /* FEAT_FPACC_SPEC */
 
-- 
2.34.1


