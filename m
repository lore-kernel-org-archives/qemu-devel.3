Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B61DC83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 15:16:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXi8G-00029H-14; Fri, 04 Jul 2025 11:15:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uXi8A-00023J-Vu
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 11:15:15 -0400
Received: from mail-qv1-xf2b.google.com ([2607:f8b0:4864:20::f2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uXi88-0004db-Ml
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 11:15:14 -0400
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6fafb6899c2so12428176d6.0
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 08:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751642111; x=1752246911; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yr3RJolVtussDq6YKwTZ6SpmMIjNcR9PpcE47YPrlUU=;
 b=lFNsVHwlFrOEidahEno5kQ+3G8FsmSSnaVHHQo5HgfliLPsEnx5ksM9IZ0ZWNb432W
 Zap6lTbFZz/Dyv0TB5im3uxcEMP6Su6Zbj8nqraN3e4VkAX1NXnMKdPRuZPjuJQPOcbB
 JIG+sEt0KLQiwdXMZ+xA7gNbXBl2a7kWEI+LHd/NirRF1sIdVCu4Tdhlx2VI3+pDq8KW
 +KeCt3PmH7y6iCoaQqlwq+jka8aBamdb9KfbP1VuaxHE63gC+SnnYOicUU4ii34629hX
 cl4NqZ25doYH3kkQ8LTkDn4GWH19V9F2wtxG81LEhyerdM3azauc0ntNKMS5lpfPKDEH
 ct0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751642111; x=1752246911;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yr3RJolVtussDq6YKwTZ6SpmMIjNcR9PpcE47YPrlUU=;
 b=xFCGsTUUHtQXHgRgtxNBVWrOL8Exa6i4gSxiF+ICyfUqlEb3182Hwn+3xt7g3S/4ZG
 iT5dmkYa7mmTafkXslHZHYij0uHAWPMn1fyKWOxyRnLC34BKuyFN3YWuZNQM1hpGtVG2
 LkLwKMt1Ca7puxfEQOSv1cl8clhBeov/R/Q9lxEI5ZoHgzd/9viyBGMGiJ97Z16YH/S2
 4aRdGyhsAslAgA9DxD+eNRsg7u1FOeEVYDXova6NhquzdchRUc6CSoyjqXN1hpDw3gOG
 XX3WlJ5sWrMFvKwtB16Rk6z4vFafqD/0a9ur2trpY9UUvXBDRumV2TnX9kWIApP7AIUW
 0nOA==
X-Gm-Message-State: AOJu0YxTBkddBRfqDNm2SmcuyUgJKwDetJlMW8zORnx48MHqNuo7pNbo
 vN9MAtq0C56N1f4/xu6HyJTJDcII8ZyF0bIvrpyM51/oIaNnqQQjZvlKyaze2KvVgQg=
X-Gm-Gg: ASbGncukeq5NvrgVb7m2AdZi2NHEOPd3l5tidBE6Q/VHduK1Nn9X70+bGeK6DPLesrN
 APHL2BAwQR3YepWLQgHF5hDZdSXtI+RlAOYnA0m+FCXT8B4U0v/0fcgND/vjZKC+epQ+ozFkxOZ
 mDgVhYF6GQpRdVBuPmIITe6xFu7rDrhfvu6NggVHvT9bqhWILfK/yu1eJp44mt/Tq4z3M4uApNF
 6w21gnF09XPq/U6YVdg3HE9xZe13OxNIExneGguiVO0jKbaibIHp5yQC/DGzGJkP6y+TCtwaltL
 X5FIHmnQOLxLPKZ6xfuxp2jRzizp9dX2U8HaWBKtcdHy6RZc8wMoM6efEbNLw3XXHRA=
X-Google-Smtp-Source: AGHT+IGb0d6mLe5Le5q6CRhYLRQurVslXtDA4+cFMrWolUuID3mv/A624CRy2w+FhQB29VXYYKpF8g==
X-Received: by 2002:a05:6214:21e7:b0:702:c038:af78 with SMTP id
 6a1803df08f44-702c5695e64mr52295166d6.5.1751642110694; 
 Fri, 04 Jul 2025 08:15:10 -0700 (PDT)
Received: from gromero0.. ([189.110.24.38]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-702c4d6039fsm13658666d6.111.2025.07.04.08.15.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 08:15:10 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-arm@nongnu.org,
	alex.bennee@linaro.org
Cc: qemu-devel@nongnu.org,
	gustavo.romero@linaro.org
Subject: [WIP-for-10.1 v2 3/5] target/arm: Add FEAT_SCTLR2
Date: Fri,  4 Jul 2025 15:14:29 +0000
Message-Id: <20250704151431.1033520-4-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250704151431.1033520-1-gustavo.romero@linaro.org>
References: <20250704151431.1033520-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2b;
 envelope-from=gustavo.romero@linaro.org; helo=mail-qv1-xf2b.google.com
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

Add FEAT_SCTLR2, which introduces the SCTLR2_EL1, SCTLR2_EL2, and
SCTLR2_EL3 registers. These registers are extension of the SCTLR_ELx
ones.

Because the bits in these registers depend on other CPU features, and
only FEAT_MEC is supported at the moment, this commit only implements
the EMEC bits related to FEAT_MEC in CTLR2_EL2 and SCTLR2_EL3.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 docs/system/arm/emulation.rst |  1 +
 target/arm/cpu-features.h     |  5 ++++
 target/arm/cpu.h              | 15 +++++++++++
 target/arm/helper.c           | 51 +++++++++++++++++++++++++++++++++++
 target/arm/tcg/cpu64.c        |  1 +
 5 files changed, 73 insertions(+)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 78c2fd2113..5a82c602f2 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -121,6 +121,7 @@ the following architecture extensions:
 - FEAT_RPRES (Increased precision of FRECPE and FRSQRTE)
 - FEAT_S2FWB (Stage 2 forced Write-Back)
 - FEAT_SB (Speculation Barrier)
+- FEAT_SCTLR2 (Extension to SCTLR_ELx)
 - FEAT_SEL2 (Secure EL2)
 - FEAT_SHA1 (SHA1 instructions)
 - FEAT_SHA256 (SHA256 instructions)
diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 4452e7c21e..a42d1133c2 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -296,6 +296,11 @@ static inline bool isar_feature_aa32_ats1e1(const ARMISARegisters *id)
     return FIELD_EX32(id->id_mmfr3, ID_MMFR3, PAN) >= 2;
 }
 
+static inline bool isar_feature_aa64_sctlr2(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_mmfr3, ID_AA64MMFR3, SCTLRX) == 1;
+}
+
 static inline bool isar_feature_aa32_pmuv3p1(const ARMISARegisters *id)
 {
     /* 0xf means "non-standard IMPDEF PMU" */
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 9509217486..ac38306873 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -326,6 +326,7 @@ typedef struct CPUArchState {
             };
             uint64_t sctlr_el[4];
         };
+        uint64_t sctlr2_el[4]; /* Extension to System control register. */
         uint64_t vsctlr; /* Virtualization System control register. */
         uint64_t cpacr_el1; /* Architectural feature access control register */
         uint64_t cptr_el[4];  /* ARMv8 feature trap registers */
@@ -1401,6 +1402,19 @@ void pmu_init(ARMCPU *cpu);
 #define SCTLR_SPINTMASK (1ULL << 62) /* FEAT_NMI */
 #define SCTLR_TIDCP   (1ULL << 63) /* FEAT_TIDCP1 */
 
+#define SCTLR2_EMEC (1ULL << 1) /* FEAT_MEC */
+#define SCTLR2_NMEA (1ULL << 2) /* FEAT_DoubleFault2 */
+#define SCTLR2_ENADERR (1ULL << 3) /* FEAT_ADERR */
+#define SCTLR2_ENANERR (1ULL << 4) /* FEAT_ANERR */
+#define SCTLR2_EASE (1ULL << 5) /* FEAT_DoubleFault2 */
+#define SCTLR2_ENIDCP128 (1ULL << 6) /* FEAT_SYSREG128 */
+#define SCTLR2_ENPACM (1ULL << 7) /* FEAT_PAuth_LR */
+#define SCTLR2_ENPACM0 (1ULL << 8 /* FEAT_PAuth_LR */
+#define SCTLR2_CPTA (1ULL << 9) /* FEAT_CPA2 */
+#define SCTLR2_CPTA0 (1ULL << 10) /* FEAT_CPA2 */
+#define SCTLR2_CPTM (1ULL << 11) /* FEAT_CPA2 */
+#define SCTLR2_CPTM0 (1ULL << 12) /* FEAT_CAP2 */
+
 #define CPSR_M (0x1fU)
 #define CPSR_T (1U << 5)
 #define CPSR_F (1U << 6)
@@ -1692,6 +1706,7 @@ static inline void xpsr_write(CPUARMState *env, uint32_t val, uint32_t mask)
 #define SCR_HXEN              (1ULL << 38)
 #define SCR_TRNDR             (1ULL << 40)
 #define SCR_ENTP2             (1ULL << 41)
+#define SCR_SCTLR2EN          (1ULL << 42)
 #define SCR_GPF               (1ULL << 48)
 #define SCR_MECEN             (1ULL << 49)
 #define SCR_NSE               (1ULL << 62)
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 9f8a284261..413672174b 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7840,6 +7840,53 @@ static const ARMCPRegInfo actlr2_hactlr2_reginfo[] = {
       .resetvalue = 0 },
 };
 
+static CPAccessResult sctlr2_access(CPUARMState *env, const ARMCPRegInfo *ri,
+                                    bool isread)
+{
+    int el = arm_current_el(env);
+
+    if (!cpu_isar_feature(aa64_sctlr2, env_archcpu(env))) {
+        return CP_ACCESS_UNDEFINED;
+    }
+
+    if ((el < 3)  && !(env->cp15.scr_el3 & SCR_SCTLR2EN)) {
+        return CP_ACCESS_TRAP_EL3;
+    }
+    return CP_ACCESS_OK;
+};
+
+static void sctlr2_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                         uint64_t value)
+{
+    int el = arm_current_el(env);
+    uint64_t valid_mask = 0ULL;
+
+    if (el > 1 && cpu_isar_feature(aa64_mec, env_archcpu(env))) {
+        /* SCTLR2_EL1 does not implement the EMEC bit */
+        valid_mask |= SCTLR2_EMEC;
+    }
+    value &= valid_mask;
+    raw_write(env, ri, value);
+};
+
+static const ARMCPRegInfo sctlr2_reginfo[] = {
+    { .name = "SCTLR2_EL1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 0, .opc2 = 3, .crn = 1, .crm = 0,
+      .access = PL1_RW, .accessfn = sctlr2_access,
+      .writefn = sctlr2_write,
+      .fieldoffset = offsetof(CPUARMState, cp15.sctlr2_el[1]) },
+    { .name = "SCTLR2_EL2", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 4, .opc2 = 3, .crn = 1, .crm = 0,
+      .access = PL2_RW, .accessfn = sctlr2_access,
+      .writefn = sctlr2_write,
+      .fieldoffset = offsetof(CPUARMState, cp15.sctlr2_el[2]) },
+    { .name = "SCTLR2_EL3", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 6, .opc2 = 3, .crn = 1, .crm = 0,
+      .access = PL3_RW, .accessfn = sctlr2_access,
+      .writefn = sctlr2_write,
+      .fieldoffset = offsetof(CPUARMState, cp15.sctlr2_el[3]) },
+};
+
 void register_cp_regs_for_features(ARMCPU *cpu)
 {
     /* Register all the coprocessor registers based on feature bits */
@@ -9106,6 +9153,10 @@ void register_cp_regs_for_features(ARMCPU *cpu)
         define_arm_cp_regs(cpu, mec_reginfo);
     }
 
+    if (cpu_isar_feature(aa64_sctlr2, cpu)) {
+        define_arm_cp_regs(cpu, sctlr2_reginfo);
+    }
+
     if (cpu_isar_feature(any_predinv, cpu)) {
         define_arm_cp_regs(cpu, predinv_reginfo);
     }
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 5d8ed2794d..5f77d320ea 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1242,6 +1242,7 @@ void aarch64_max_tcg_initfn(Object *obj)
 
     t = cpu->isar.id_aa64mmfr3;
     t = FIELD_DP64(t, ID_AA64MMFR3, SPEC_FPACC, 1); /* FEAT_FPACC_SPEC */
+    t = FIELD_DP64(t, ID_AA64MMFR3, SCTLRX, 1);     /* FEAT_SCTLR2 */
     cpu->isar.id_aa64mmfr3 = t;
 
     t = cpu->isar.id_aa64zfr0;
-- 
2.34.1


