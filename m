Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDA1FC83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 17:08:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubMf5-0002LQ-2l; Mon, 14 Jul 2025 13:08:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ubLZr-00032R-3f
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 11:58:54 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ubLZm-0007nB-Ur
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 11:58:50 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-742c7a52e97so3593027b3a.3
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 08:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752508725; x=1753113525; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PCSpoB1LEqtEMtwqWIvxQ7Q29ouen2IWNZoglqt6nCw=;
 b=uairG6N/l1N/R3w/UC6pbaNJXovVHszmOq1TvSZXVnNFzYHeOSytNQLtHntt8Vtf17
 KPfh8vGrS3kp7WBlJFWO42kLlWBUIYBPHeDONba0qYzkmbw4B9L/Icu9JNzc6JTm/IK0
 489xmcW/MS0fXybwYoSmpu7BKVooM1bSmbwJYwEtfs6nNf7+8TDgUBlev3uHjd/1jIiX
 +HYceQWxEDCeqUTe3LhTqGyCbWhPMKZC7iFSMVQlz2cJ5QFfoQh1Pp/obEuAc40Fiv7H
 a7szlghrVkCGN/EGIvbAVbEA1JZFO6Oc/C6JQN4YCymHvIQ2l1Nr6rEjynCsTIwrzZY3
 XkqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752508725; x=1753113525;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PCSpoB1LEqtEMtwqWIvxQ7Q29ouen2IWNZoglqt6nCw=;
 b=ggRGGYgrdWtVZfcq93D3jwcC/GFEZPrx1z96s0pjCj1dozDpfd3Ne+BSytt5sVXESs
 DGy2HYKQQuemKgruLrwZ6eBja/JZX+Z+RkI3bZ+ZRGHCuaOdruyYdVxzXTRwfvmGS5De
 33C+G7ewNxH4Fy7nHcoSL41gZgVIsN0kXrK23S/JmWdxveETMW9h/eAXyUUctV9DBAPz
 pF6xIcoVsfIXK42WkP21Y6SVLFxTDVwLkRM6yG+RposihVeZbdNg3GN0T3ZuKCT2z4cw
 loh/qybocxS5gmjX1qO3/S82CGL/JqbaPqeIgzzz7UMR6HxVoVMuLQgoIVBON3YYw8Ku
 M8pA==
X-Gm-Message-State: AOJu0YxSPWyEWOnQEcXHYkrHapqmm1VrYo7CnhveHb4sXuQjlfhlK5Ie
 am6JORtSapgy3mMQwwsW+GYXI5ff3Z8y/EFh68Ocsg4chD3VgyJQ38gDf2E8MB+qPqXExCeJ4VH
 Y4PqqDc4=
X-Gm-Gg: ASbGncu7mMkQUifh+sg/6XWcI2JWuMB9s/zrc93uQmDczFm9FjVTTRocNmecW9GgMwV
 4CoTBfJ3XYWt/XFdx5l22dS8EuB5FOLcuDeK6Qq14Nktrqm+FNpPcFxWIIztcbwc8cvDG4UeXbu
 qPtWqVFAjUs+ONyF2ibvq6cE98uHtIJHtC6IiTDPNbx0WxobeZReiSZq1JEof5DPCEuGzyYzLWX
 U7RMFBP3cfPPRea3MJKG57W1qQggdCO1LVKk09pFfAeSczYy8Hgq7lOFyhgUjK7iCvUs9ZcMFNv
 wHLrGAvG9C0yogLjH8iRfC54tBNHv36h5iak8o4PSv9pQbzN8gHqFBaHap3hSftglfwlj8Lp6N7
 G15c62VEQv8jyvYfjOatwlAeZSLp54tf4ozKovz8Wwd6RvzhOOQ01
X-Google-Smtp-Source: AGHT+IF7VRsNTqB7TkHCAF+1b0z+RRBoIUZ/CEBPQwtRwBiSuB6boTTDb5BLYzy8ykekG+4sPpBGhw==
X-Received: by 2002:a05:6a00:807:b0:748:33f3:8da3 with SMTP id
 d2e1a72fcca58-74ee323a063mr19965117b3a.19.1752508725145; 
 Mon, 14 Jul 2025 08:58:45 -0700 (PDT)
Received: from stoup.. ([172.56.179.167]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74eb9f8f24dsm10265805b3a.156.2025.07.14.08.58.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 08:58:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, gustavo.romero@linaro.org, pierrick.bouvier@linaro.org
Subject: [PATCH v8 1/4] target/arm: Implement FEAT_SCTLR2 and enable with -cpu
 max
Date: Mon, 14 Jul 2025 09:58:32 -0600
Message-ID: <20250714155836.1514748-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250714155836.1514748-1-richard.henderson@linaro.org>
References: <20250714155836.1514748-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

Add FEAT_SCTLR2, which introduces the SCTLR2_EL1, SCTLR2_EL2, and
SCTLR2_EL3 registers. These registers are extensions of the SCTLR_ELx
ones.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250711140828.1714666-4-gustavo.romero@linaro.org>
[rth: Remove FEAT_MEC code; handle SCR and HCRX enable bits.]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu-features.h     |  5 ++
 target/arm/cpu.h              | 15 ++++++
 target/arm/internals.h        |  1 +
 target/arm/cpu.c              |  3 ++
 target/arm/helper.c           | 88 +++++++++++++++++++++++++++++++++--
 target/arm/tcg/cpu64.c        |  5 +-
 docs/system/arm/emulation.rst |  1 +
 7 files changed, 112 insertions(+), 6 deletions(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 5876162428..e372543bf3 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -904,6 +904,11 @@ static inline bool isar_feature_aa64_nv2(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64MMFR2, NV) >= 2;
 }
 
+static inline bool isar_feature_aa64_sctlr2(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64MMFR3, SCTLRX) != 0;
+}
+
 static inline bool isar_feature_aa64_pmuv3p1(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64DFR0, PMUVER) >= 4 &&
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index dc9b6dce4c..dda5f275fb 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -337,6 +337,7 @@ typedef struct CPUArchState {
             };
             uint64_t sctlr_el[4];
         };
+        uint64_t sctlr2_el[4]; /* Extension to System control register. */
         uint64_t vsctlr; /* Virtualization System control register. */
         uint64_t cpacr_el1; /* Architectural feature access control register */
         uint64_t cptr_el[4];  /* ARMv8 feature trap registers */
@@ -1420,6 +1421,19 @@ void pmu_init(ARMCPU *cpu);
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
@@ -1712,6 +1726,7 @@ static inline void xpsr_write(CPUARMState *env, uint32_t val, uint32_t mask)
 #define SCR_HXEN              (1ULL << 38)
 #define SCR_TRNDR             (1ULL << 40)
 #define SCR_ENTP2             (1ULL << 41)
+#define SCR_SCTLR2EN          (1ULL << 44)
 #define SCR_GPF               (1ULL << 48)
 #define SCR_NSE               (1ULL << 62)
 
diff --git a/target/arm/internals.h b/target/arm/internals.h
index c4765e4489..fcaad39371 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -232,6 +232,7 @@ FIELD(VTCR, SL2, 33, 1)
 #define HCRX_CMOW     (1ULL << 9)
 #define HCRX_MCE2     (1ULL << 10)
 #define HCRX_MSCEN    (1ULL << 11)
+#define HCRX_SCTLR2EN (1ULL << 15)
 
 #define HPFAR_NS      (1ULL << 63)
 
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 08c43f674a..2ee895fbc4 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -645,6 +645,9 @@ void arm_emulate_firmware_reset(CPUState *cpustate, int target_el)
             if (cpu_isar_feature(aa64_fgt, cpu)) {
                 env->cp15.scr_el3 |= SCR_FGTEN;
             }
+            if (cpu_isar_feature(aa64_sctlr2, cpu)) {
+                env->cp15.scr_el3 |= SCR_SCTLR2EN;
+            }
         }
 
         if (target_el == 2) {
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 0c1299ff84..d0cfef1dd6 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -741,6 +741,9 @@ static void scr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
         if (cpu_isar_feature(aa64_ecv, cpu)) {
             valid_mask |= SCR_ECVEN;
         }
+        if (cpu_isar_feature(aa64_sctlr2, cpu)) {
+            valid_mask |= SCR_SCTLR2EN;
+        }
     } else {
         valid_mask &= ~(SCR_RW | SCR_ST);
         if (cpu_isar_feature(aa32_ras, cpu)) {
@@ -3907,23 +3910,21 @@ static void hcrx_write(CPUARMState *env, const ARMCPRegInfo *ri,
     ARMCPU *cpu = env_archcpu(env);
     uint64_t valid_mask = 0;
 
-    /* FEAT_MOPS adds MSCEn and MCE2 */
     if (cpu_isar_feature(aa64_mops, cpu)) {
         valid_mask |= HCRX_MSCEN | HCRX_MCE2;
     }
-
-    /* FEAT_NMI adds TALLINT, VINMI and VFNMI */
     if (cpu_isar_feature(aa64_nmi, cpu)) {
         valid_mask |= HCRX_TALLINT | HCRX_VINMI | HCRX_VFNMI;
     }
-    /* FEAT_CMOW adds CMOW */
     if (cpu_isar_feature(aa64_cmow, cpu)) {
         valid_mask |= HCRX_CMOW;
     }
-    /* FEAT_XS adds FGTnXS, FnXS */
     if (cpu_isar_feature(aa64_xs, cpu)) {
         valid_mask |= HCRX_FGTNXS | HCRX_FNXS;
     }
+    if (cpu_isar_feature(aa64_sctlr2, cpu)) {
+        valid_mask |= HCRX_SCTLR2EN;
+    }
 
     /* Clear RES0 bits.  */
     env->cp15.hcrx_el2 = value & valid_mask;
@@ -4513,6 +4514,8 @@ static void define_arm_vh_e2h_redirects_aliases(ARMCPU *cpu)
     static const struct E2HAlias aliases[] = {
         { K(3, 0,  1, 0, 0), K(3, 4,  1, 0, 0), K(3, 5, 1, 0, 0),
           "SCTLR", "SCTLR_EL2", "SCTLR_EL12" },
+        { K(3, 0,  1, 0, 3), K(3, 4,  1, 0, 3), K(3, 5, 1, 0, 3),
+          "SCTLR2_EL1", "SCTLR2_EL2", "SCTLR2_EL12", isar_feature_aa64_sctlr2 },
         { K(3, 0,  1, 0, 2), K(3, 4,  1, 1, 2), K(3, 5, 1, 0, 2),
           "CPACR", "CPTR_EL2", "CPACR_EL12" },
         { K(3, 0,  2, 0, 0), K(3, 4,  2, 0, 0), K(3, 5, 2, 0, 0),
@@ -5994,6 +5997,77 @@ static const ARMCPRegInfo actlr2_hactlr2_reginfo[] = {
       .resetvalue = 0 },
 };
 
+static CPAccessResult sctlr2_el2_access(CPUARMState *env,
+                                        const ARMCPRegInfo *ri,
+                                        bool isread)
+{
+    if (arm_current_el(env) < 3
+        && arm_feature(env, ARM_FEATURE_EL3)
+        && !(env->cp15.scr_el3 & SCR_SCTLR2EN)) {
+        return CP_ACCESS_TRAP_EL3;
+    }
+    return CP_ACCESS_OK;
+}
+
+static CPAccessResult sctlr2_el1_access(CPUARMState *env,
+                                        const ARMCPRegInfo *ri,
+                                        bool isread)
+{
+    CPAccessResult ret = access_tvm_trvm(env, ri, isread);
+    if (ret != CP_ACCESS_OK) {
+        return ret;
+    }
+    if (arm_current_el(env) < 2 && !(arm_hcrx_el2_eff(env) & HCRX_SCTLR2EN)) {
+        return CP_ACCESS_TRAP_EL2;
+    }
+    return sctlr2_el2_access(env, ri, isread);
+}
+
+static void sctlr2_el1_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                             uint64_t value)
+{
+    uint64_t valid_mask = 0;
+
+    value &= valid_mask;
+    raw_write(env, ri, value);
+}
+
+static void sctlr2_el2_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                             uint64_t value)
+{
+    uint64_t valid_mask = 0;
+
+    value &= valid_mask;
+    raw_write(env, ri, value);
+}
+
+static void sctlr2_el3_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                             uint64_t value)
+{
+    uint64_t valid_mask = 0;
+
+    value &= valid_mask;
+    raw_write(env, ri, value);
+}
+
+static const ARMCPRegInfo sctlr2_reginfo[] = {
+    { .name = "SCTLR2_EL1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 0, .opc2 = 3, .crn = 1, .crm = 0,
+      .access = PL1_RW, .accessfn = sctlr2_el1_access,
+      .writefn = sctlr2_el1_write, .fgt = FGT_SCTLR_EL1,
+      .nv2_redirect_offset = 0x278 | NV2_REDIR_NV1,
+      .fieldoffset = offsetof(CPUARMState, cp15.sctlr2_el[1]) },
+    { .name = "SCTLR2_EL2", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 4, .opc2 = 3, .crn = 1, .crm = 0,
+      .access = PL2_RW, .accessfn = sctlr2_el2_access,
+      .writefn = sctlr2_el2_write,
+      .fieldoffset = offsetof(CPUARMState, cp15.sctlr2_el[2]) },
+    { .name = "SCTLR2_EL3", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 6, .opc2 = 3, .crn = 1, .crm = 0,
+      .access = PL3_RW, .writefn = sctlr2_el3_write,
+      .fieldoffset = offsetof(CPUARMState, cp15.sctlr2_el[3]) },
+};
+
 void register_cp_regs_for_features(ARMCPU *cpu)
 {
     /* Register all the coprocessor registers based on feature bits */
@@ -7223,6 +7297,10 @@ void register_cp_regs_for_features(ARMCPU *cpu)
         define_arm_cp_regs(cpu, nmi_reginfo);
     }
 
+    if (cpu_isar_feature(aa64_sctlr2, cpu)) {
+        define_arm_cp_regs(cpu, sctlr2_reginfo);
+    }
+
     if (cpu_isar_feature(any_predinv, cpu)) {
         define_arm_cp_regs(cpu, predinv_reginfo);
     }
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 35cddbafa4..f4efff03a5 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1247,7 +1247,10 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64MMFR2, E0PD, 1);     /* FEAT_E0PD */
     SET_IDREG(isar, ID_AA64MMFR2, t);
 
-    FIELD_DP64_IDREG(isar, ID_AA64MMFR3, SPEC_FPACC, 1); /* FEAT_FPACC_SPEC */
+    t = GET_IDREG(isar, ID_AA64MMFR3);
+    t = FIELD_DP64(t, ID_AA64MMFR3, SCTLRX, 1);     /* FEAT_SCTLR2 */
+    t = FIELD_DP64(t, ID_AA64MMFR3, SPEC_FPACC, 1); /* FEAT_FPACC_SPEC */
+    SET_IDREG(isar, ID_AA64MMFR3, t);
 
     t = GET_IDREG(isar, ID_AA64ZFR0);
     t = FIELD_DP64(t, ID_AA64ZFR0, SVEVER, 2);    /* FEAT_SVE2p1 */
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 890dc6fee2..66043b0747 100644
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
-- 
2.43.0


