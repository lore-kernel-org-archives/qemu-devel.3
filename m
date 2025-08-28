Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9983CA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 11:36:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urau1-0003IP-Dh; Thu, 28 Aug 2025 07:34:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uratu-0003EG-1L
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 07:34:43 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uratr-0005dE-MV
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 07:34:41 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3c68ac7e18aso530932f8f.2
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 04:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756380878; x=1756985678; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=n8ApJz7RXENElQplzIs6M0aQR9sbG/YlsiM6m/0WkJo=;
 b=LnS3hImseAeeWbebIeo8Ya+eXsCxnCAw2LHHowXp12G+l1NLazr9obT2XILHcfXSO9
 r90Hn7nSLLxGsStlOr2zt/63fX8N9+HAL3w0M8qCCLMdbr78OVGEl1F0uQyfMmUmSwfZ
 JUikKbuubqkEqtWBOqmeMciUuO8XLk1P8WDrKQoxDbCtlXav3UFtcmiQbm4Kiqm6jgBt
 p20Y5uvddKXPqTh9FzJi8VC1QjMdYUGYSdtMscm8siIH8gTUL2s23lwGJaYfDaQ0VsQp
 EI+38PstFg0Og1cVneil8rSslFIDnBSycpQcbZB1RBCILY1w6DH1XN3gsjJa5H4iviHn
 ZtCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756380878; x=1756985678;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n8ApJz7RXENElQplzIs6M0aQR9sbG/YlsiM6m/0WkJo=;
 b=e3+2DVapr0NUcfq8ztYPdiiWSQ4pEhD28FRnoCcIYYtcCac9FplNojlXsSJPwV64R/
 OeO8SXz3RrUoS/HBKLg1leNZUyoCqibtAPuNQhVlXLr02eWKxiH1ONKrqyIP1GVJA/OO
 aLyoRDMDKUryRMTCy5GxyTXf8UDWPtSGwBqxaR1qQKIt/hTXZ208aIL2IpZu0wn8d29n
 11Kl0QnhJUBgN9hImlQix0T+OYVHgYgAPy3pouYuFfDPW2B1MFG0tEikPzdOSyp5iXtk
 Slyb/x51pXrglOKamWt91f8qVLRpMAyed+CbmqHe3bH50aVIfLNp87M50SERVWVsG5J8
 dAEA==
X-Gm-Message-State: AOJu0Yz9V0bT58cUSEdlYL3XCgyEwUSeB6Dp/QTsJz0WHSKPcnwhDoUY
 izOHcciIH2XLdhuRl9rWIj16UmJiLyMB48W1c6aB2O/DKL4VQf87smeeiZ8umSUFrhW66W51kRi
 Uw3oV
X-Gm-Gg: ASbGnctthEDiI52a+uatZo18463gtU6PcaqmzqzA50hwi/AcmN61nqJeVl72Hiwd34A
 OpS2oE4BeUhMkiJxIFqlp8qJv44/K2WU9JtbV0bIELhFCnEAZvPwnmWHs9xqzT6IDbFVqtLtIEO
 FD8CkiOTnL9htWJuEiuQa1+CPj9nzCT7IZIZe0pKvPDyXp0q6XOSoiwRYY7HDkf6w0lPubnB9QN
 mf7rrPW392PWW3kXKOh5TdrgTB2dfrXu9O4WLsSZllWDLREpJTitnJrgguA709aoWbbP3/Lkrf3
 8EULULfuMapm4WcSwN5yVszD2+U2lxQTZNNoaWSYvxUs88SPjet9hVU5oO/d9+2v+YxsaBK3m+m
 26me9zr4b/cO83HhDyh0InzQJk14d5W9zTwrwIIs=
X-Google-Smtp-Source: AGHT+IEOz2p7rnKKTgIHjEvc3sga9Wg98UY8v4VDDUiHfF3vep+6TPdHf9CjifvbpmQ4b0v+Rg6BAQ==
X-Received: by 2002:a05:6000:310e:b0:3cd:16b0:dbad with SMTP id
 ffacd0b85a97d-3cd16b0de9emr3866444f8f.15.1756380877736; 
 Thu, 28 Aug 2025 04:34:37 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b79799c33sm28691015e9.5.2025.08.28.04.34.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 04:34:36 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/32] target/arm: Implement FEAT_SCTLR2 and enable with -cpu
 max
Date: Thu, 28 Aug 2025 12:34:01 +0100
Message-ID: <20250828113430.3214314-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828113430.3214314-1-peter.maydell@linaro.org>
References: <20250828113430.3214314-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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

From: Gustavo Romero <gustavo.romero@linaro.org>

Add FEAT_SCTLR2, which introduces the SCTLR2_EL1, SCTLR2_EL2, and
SCTLR2_EL3 registers. These registers are extensions of the SCTLR_ELx
ones.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250727074202.83141-4-richard.henderson@linaro.org
Message-ID: <20250711140828.1714666-4-gustavo.romero@linaro.org>
[rth: Remove FEAT_MEC code; handle SCR and HCRX enable bits.]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/emulation.rst |  1 +
 target/arm/cpu-features.h     |  5 ++
 target/arm/cpu.h              | 15 ++++++
 target/arm/internals.h        |  1 +
 target/arm/cpu.c              |  3 ++
 target/arm/helper.c           | 97 ++++++++++++++++++++++++++++++++---
 target/arm/tcg/cpu64.c        |  5 +-
 7 files changed, 119 insertions(+), 8 deletions(-)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 890dc6fee21..66043b0747a 100644
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
index 5876162428a..e372543bf35 100644
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
index dc9b6dce4c9..08a29802e13 100644
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
+#define SCTLR2_ENPACM0 (1ULL << 8) /* FEAT_PAuth_LR */
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
index 3f86b070447..fb722362551 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -230,6 +230,7 @@ FIELD(VSTCR, SA, 30, 1)
 #define HCRX_CMOW     (1ULL << 9)
 #define HCRX_MCE2     (1ULL << 10)
 #define HCRX_MSCEN    (1ULL << 11)
+#define HCRX_SCTLR2EN (1ULL << 15)
 
 #define HPFAR_NS      (1ULL << 63)
 
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index e2b2337399c..2ab04cb5f7c 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -644,6 +644,9 @@ void arm_emulate_firmware_reset(CPUState *cpustate, int target_el)
             if (cpu_isar_feature(aa64_fgt, cpu)) {
                 env->cp15.scr_el3 |= SCR_FGTEN;
             }
+            if (cpu_isar_feature(aa64_sctlr2, cpu)) {
+                env->cp15.scr_el3 |= SCR_SCTLR2EN;
+            }
         }
 
         if (target_el == 2) {
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 0c1299ff841..11ddeabb132 100644
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
@@ -3981,11 +3982,16 @@ uint64_t arm_hcrx_el2_eff(CPUARMState *env)
      * This may need to be revisited for future bits.
      */
     if (!arm_is_el2_enabled(env)) {
+        ARMCPU *cpu = env_archcpu(env);
         uint64_t hcrx = 0;
-        if (cpu_isar_feature(aa64_mops, env_archcpu(env))) {
-            /* MSCEn behaves as 1 if EL2 is not enabled */
+
+        /* Bits which whose effective value is 1 if el2 not enabled. */
+        if (cpu_isar_feature(aa64_mops, cpu)) {
             hcrx |= HCRX_MSCEN;
         }
+        if (cpu_isar_feature(aa64_sctlr2, cpu)) {
+            hcrx |= HCRX_SCTLR2EN;
+        }
         return hcrx;
     }
     if (arm_feature(env, ARM_FEATURE_EL3) && !(env->cp15.scr_el3 & SCR_HXEN)) {
@@ -4513,6 +4519,8 @@ static void define_arm_vh_e2h_redirects_aliases(ARMCPU *cpu)
     static const struct E2HAlias aliases[] = {
         { K(3, 0,  1, 0, 0), K(3, 4,  1, 0, 0), K(3, 5, 1, 0, 0),
           "SCTLR", "SCTLR_EL2", "SCTLR_EL12" },
+        { K(3, 0,  1, 0, 3), K(3, 4,  1, 0, 3), K(3, 5, 1, 0, 3),
+          "SCTLR2_EL1", "SCTLR2_EL2", "SCTLR2_EL12", isar_feature_aa64_sctlr2 },
         { K(3, 0,  1, 0, 2), K(3, 4,  1, 1, 2), K(3, 5, 1, 0, 2),
           "CPACR", "CPTR_EL2", "CPACR_EL12" },
         { K(3, 0,  2, 0, 0), K(3, 4,  2, 0, 0), K(3, 5, 2, 0, 0),
@@ -5994,6 +6002,77 @@ static const ARMCPRegInfo actlr2_hactlr2_reginfo[] = {
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
@@ -7223,6 +7302,10 @@ void register_cp_regs_for_features(ARMCPU *cpu)
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
index 35cddbafa4c..f4efff03a59 100644
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
-- 
2.43.0


