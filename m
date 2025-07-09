Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 906D1C83F0A
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Jul 2025 18:07:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZZBn-0001SJ-NY; Wed, 09 Jul 2025 14:06:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uZZB9-00015I-Hi
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 14:06:01 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uZZB5-00049P-QF
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 14:05:59 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-236377f00easo2929945ad.1
 for <qemu-devel@nongnu.org>; Wed, 09 Jul 2025 11:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752084354; x=1752689154; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NTe7bOal0YIiyl9TytWq98KqOfA68utBrp7VdHEme/0=;
 b=ZlrhnGN/LdgFOVSiKVA/9NzxTUYwz6bRIN8gqVODBakdtMFyQS1Up9JWSggljhpeMX
 iCad5PAF/xsl/VblthsIqA+3rQAXve7+7hZH6umcRiZU32xNqy54bxVGL95UaIfCT3vA
 pBIrmhKM8mtLykHQ0vt8hsBD3BXxZbNyX+bJuOVOurAssY2QBij+WnSn2avnmbjEvMdD
 PiZTsm+vsP3hR/x1VeU5YZMQ07yI9NX0NbcxU1fmYUMpHE7tUSc4PvG7EMf57LLyNycn
 kRNe2LXiaddBfRNXWP3vsP1lukV91HX8/wjj+hCWcNARk7SbYL6kwGIGM9IsDFnYda9Y
 s2sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752084354; x=1752689154;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NTe7bOal0YIiyl9TytWq98KqOfA68utBrp7VdHEme/0=;
 b=TfKUVrhvrWX+SPc5Sj5k7t4GLRIGXx5GElYEBeDICn0jcfqFI2oDSAtmaMjh0Xptjn
 tTWn20qSeQnhP2QoiXXZTIuvHfLFfWfRUUzZClfLnVeqcbtmo/XyhgVm5ED7OzsiJj9M
 dBtvEM2YkHz9np1WQNOkNOIWe9GhI45/RczugGvepy1wNec59HDI1Nj+OepfZ8jaH9+t
 dYipwPRoU8UMGPS/ePypdxYdKmf8ouFJCYQHe0D2J2d5yYNv1I7HneW3BapymdFHgXrY
 swb3vcboVlMY4mqnBEUnDY/sHbxfwJQpy5D50uBXjQmsNBHcL7GPvw6O/+FKHnrqcFQ4
 FBoQ==
X-Gm-Message-State: AOJu0YyiNBjTYScaKUs2tsSo6mo5pICywSPjHjjZoC+FvH7c/lND4Asj
 AReQc6kSotMYK3H03bnBJixw93tTDDBYnT9c0HAFk1PNWGlnC+cUps/DiefDAdlAU0QyOGFfNkw
 swi8FA3o=
X-Gm-Gg: ASbGncu8SqcKrjyCao2ViCpaK3Mh9evN7ozWVh+BsEe1yC3/AkNeEbib+UN7sDHXUKD
 qL3MuwzIzoar9xcJfo9rsNQrq6SVws+et6hT+7vYQGbCH8zXbdpInyzxlh8UWnip1CWoOwYZGou
 fV1eFX1ZeFlElpmw2rkM+lVZ/ubJkOo61BfyhMAx5MDZ0w5lBE87P3IF+ML5R3KVjVdyQ+GRQDi
 OCXb+WmICu8A1zgFhPDv/N/DW25L+oWMMGN6dDJZOevuDG6OwcZje1UAiIR2j7dsy/Y341v/BMB
 D2A7DhXC/Znz3W3IIXJtsa+57iBykySYwA/hqAHN7abR59l6QxzBnyCFXsQ7QcT2aZeAK8BA93k
 GLw==
X-Google-Smtp-Source: AGHT+IFbVyBfJl/JFY0xa5p9ZR+sqHY9nUq7tYxsw2SM6swX04ihe2LBmLZCn/w4UpDw4wi8LgtJXQ==
X-Received: by 2002:a17:903:4b43:b0:237:e3a0:9d63 with SMTP id
 d9443c01a7336-23de24f306amr14486455ad.43.1752084354134; 
 Wed, 09 Jul 2025 11:05:54 -0700 (PDT)
Received: from gromero0.. ([189.110.24.38]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23c84599f07sm153380175ad.218.2025.07.09.11.05.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Jul 2025 11:05:53 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-arm@nongnu.org, richard.henderson@linaro.org, alex.bennee@linaro.org
Cc: qemu-devel@nongnu.org,
	gustavo.romero@linaro.org
Subject: [PATCH v4 3/6] target/arm: Add FEAT_SCTLR2
Date: Wed,  9 Jul 2025 18:03:23 +0000
Message-Id: <20250709180326.1079826-4-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250709180326.1079826-1-gustavo.romero@linaro.org>
References: <20250709180326.1079826-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x636.google.com
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
SCTLR2_EL3 registers. These registers are extensions of the SCTLR_ELx
ones.

Because the bits in these registers depend on other CPU features, and
only FEAT_MEC is supported at the moment, this commit only implements
the EMEC bits in CTLR2_EL2 and SCTLR2_EL3.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 docs/system/arm/emulation.rst |  1 +
 target/arm/cpu-features.h     |  5 +++
 target/arm/cpu.h              | 15 +++++++
 target/arm/helper.c           | 78 +++++++++++++++++++++++++++++++++++
 target/arm/internals.h        |  1 +
 target/arm/tcg/cpu64.c        |  1 +
 6 files changed, 101 insertions(+)

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
diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 552d8757b7..44d6b655a9 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -416,6 +416,11 @@ static inline bool isar_feature_aa64_rdm(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64ISAR0, RDM) != 0;
 }
 
+static inline bool isar_feature_aa64_sctlr2(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64MMFR3, SCTLRX) != 0;
+}
+
 static inline bool isar_feature_aa64_sha3(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64ISAR0, SHA3) != 0;
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index a93eebe077..32d30b7bb9 100644
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
@@ -1433,6 +1434,19 @@ void pmu_init(ARMCPU *cpu);
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
@@ -1725,6 +1739,7 @@ static inline void xpsr_write(CPUARMState *env, uint32_t val, uint32_t mask)
 #define SCR_HXEN              (1ULL << 38)
 #define SCR_TRNDR             (1ULL << 40)
 #define SCR_ENTP2             (1ULL << 41)
+#define SCR_SCTLR2EN          (1ULL << 44)
 #define SCR_GPF               (1ULL << 48)
 #define SCR_MECEN             (1ULL << 49)
 #define SCR_NSE               (1ULL << 62)
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 984406c945..5707eea822 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6144,6 +6144,8 @@ static void define_arm_vh_e2h_redirects_aliases(ARMCPU *cpu)
     static const struct E2HAlias aliases[] = {
         { K(3, 0,  1, 0, 0), K(3, 4,  1, 0, 0), K(3, 5, 1, 0, 0),
           "SCTLR", "SCTLR_EL2", "SCTLR_EL12" },
+        { K(3, 0,  1, 0, 3), K(3, 4,  1, 0, 3), K(3, 5, 1, 0, 3),
+          "SCTLR2_EL1", "SCTLR2_EL2", "SCTLR2_EL12" },
         { K(3, 0,  1, 0, 2), K(3, 4,  1, 1, 2), K(3, 5, 1, 0, 2),
           "CPACR", "CPTR_EL2", "CPACR_EL12" },
         { K(3, 0,  2, 0, 0), K(3, 4,  2, 0, 0), K(3, 5, 2, 0, 0),
@@ -7816,6 +7818,78 @@ static const ARMCPRegInfo actlr2_hactlr2_reginfo[] = {
       .resetvalue = 0 },
 };
 
+static CPAccessResult sctlr2_el2_access(CPUARMState *env,
+                                        const ARMCPRegInfo *ri,
+                                        bool isread)
+{
+    if (arm_current_el(env) < 3 && !(env->cp15.scr_el3 & SCR_SCTLR2EN)) {
+        return CP_ACCESS_TRAP_EL3;
+    }
+    return CP_ACCESS_OK;
+};
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
+};
+
+static void sctlr2_el1_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                             uint64_t value)
+{
+    /* This register does not control any feature yet. */
+};
+
+static void sctlr2_el2_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                             uint64_t value)
+{
+    uint64_t valid_mask = 0;
+
+    if (cpu_isar_feature(aa64_mec, env_archcpu(env))) {
+        valid_mask |= SCTLR2_EMEC;
+    }
+    value &= valid_mask;
+    raw_write(env, ri, value);
+};
+
+static void sctlr2_el3_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                             uint64_t value)
+{
+    uint64_t valid_mask = 0;
+
+    if (cpu_isar_feature(aa64_mec, env_archcpu(env))) {
+        valid_mask |= SCTLR2_EMEC;
+    }
+    value &= valid_mask;
+    raw_write(env, ri, value);
+};
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
@@ -9084,6 +9158,10 @@ void register_cp_regs_for_features(ARMCPU *cpu)
         define_arm_cp_regs(cpu, mec_reginfo);
     }
 
+    if (cpu_isar_feature(aa64_sctlr2, cpu)) {
+        define_arm_cp_regs(cpu, sctlr2_reginfo);
+    }
+
     if (cpu_isar_feature(any_predinv, cpu)) {
         define_arm_cp_regs(cpu, predinv_reginfo);
     }
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 21a8d67edd..398e0b4a7d 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -232,6 +232,7 @@ FIELD(VTCR, SL2, 33, 1)
 #define HCRX_CMOW     (1ULL << 9)
 #define HCRX_MCE2     (1ULL << 10)
 #define HCRX_MSCEN    (1ULL << 11)
+#define HCRX_SCTLR2EN (1ULL << 15)
 
 #define HPFAR_NS      (1ULL << 63)
 
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index d0df50a2f3..bdd2fe7f5b 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1247,6 +1247,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64MMFR2, E0PD, 1);     /* FEAT_E0PD */
     SET_IDREG(isar, ID_AA64MMFR2, t);
 
+    FIELD_DP64_IDREG(isar, ID_AA64MMFR3, SCTLRX, 1);     /* FEAT_SCTLR2 */
     FIELD_DP64_IDREG(isar, ID_AA64MMFR3, SPEC_FPACC, 1); /* FEAT_FPACC_SPEC */
 
     t = GET_IDREG(isar, ID_AA64ZFR0);
-- 
2.34.1


