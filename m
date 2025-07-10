Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2DBFC83F17
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 17:04:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZugj-0005c3-0D; Thu, 10 Jul 2025 13:04:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uZuLA-00040w-R0
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 12:41:44 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uZuL8-00019n-J9
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 12:41:44 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-74264d1832eso1704561b3a.0
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 09:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752165701; x=1752770501; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nVKucjOtP/Y4LoplarwkY4lSnfGgVt/kUo3oBzJMzZg=;
 b=J8zggZyCQlqzhf4C0i3i3SlI8i3BHuJwTZBxsZ/Q2GDc616ZdnnK2sol6SpW6VXSpf
 YTI96ZlUcpsV6OopMlqVqVZXYS2K56vNxvI5sGIiReI6/deDy//66bvlZ7SkwjPn33uY
 rT/G9FfDS4W34ZimJLNJ7p+Utd9CZQQt5mBHDfAkTtYc8kj3yMD74OKpY2KDyvnDHktS
 IQe9aqsHkjvxKUiYV6nMXdfR3KRtxniGxF+R/EN7/Dpb8KANfpCNryeu4YmZvU/KuaaY
 zT68Z4JAp0JiUbIy6RMUdy9jPOizs7FcAqHanB+Wr8Tgmx7KCNhRi1AfNp4DM0o3EgY6
 10Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752165701; x=1752770501;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nVKucjOtP/Y4LoplarwkY4lSnfGgVt/kUo3oBzJMzZg=;
 b=YaS0Px4ffMn5des8RGMlr5d9HC6Le6Hj5zZG5M3jO/LqxyWsCOScG3sKBHq7gBDpMH
 /bRgZDIA7MlHr+6z/k/PUXx8aMt6j1KKsAtxgOrO8tC6k1U1a9MPlVweikOVyYKNV5dM
 a00vmVz2DFTtmEqBHzT9twYhUnOxME1XNw2SjkE7WDs7d8SdtpVyAOPXGHDm7QAa/lUh
 4Tgp2bq0bAOxy0PRM6024CVzKC0GuTFD23/zotWejDeWbLSSqE0KjB33F+06wONa4UPu
 kSjXJ/Xj8kqeQwS5eCbvY035+rFshyDjK8zxHtbgprZiPDZlak3l3DUMV4Oiz2nGhD1F
 ZRZg==
X-Gm-Message-State: AOJu0YwNOBVrJXNLVXeKvcyTY3oo712HhNdibd+nH/bm0D7/Mf0uCu+7
 mfbAsD2q7OLBlxqXTkTfiKxaJhL5dChSLkrdPXGFP+yutXlm2IqyRSvBpV7ZUvhbZkcJlD3zr3r
 9DKMo1ig=
X-Gm-Gg: ASbGncvlGkU1omPZCWa+BB8US+/ILQ1NLkWKCvdk3wMww3FTSb65/8YYyO8P58G7h3a
 Wf0inZYda1uie8usidjAw/B8XrfO+tMYX2RUbgvHjKLSx3XGCoLkXAj7tEcxVLYj+AhsFORa1eQ
 taMjPRdRJCavljhxVMWdD5miIhh9HO/Aec2GX/uiljRdZjgpNkWMXtRbjVQxHdq0hLaazyuW+Bu
 C+IJ/iSCrHEx9ssZAMLKjn2xegUKbVTl6CYP/6mcV/AP3PMBUskVI1Za48z9EoBP+sq1KnsL7rc
 LHcVmpNVGPi4OtO9tCPNXdQFthm/nZHS+uSC3cymeqT3g8f/EeWXqQgw+nbSqOcNXP7bC9JBvBF
 fCgCcPsbYXmmbdD59u8gmVQ==
X-Google-Smtp-Source: AGHT+IED4jj5vBYcJnIeNZe/BONl5cj1Y76CJ+Acg5cy1Z0OBuxh4yfGhf/DRV8KCK19o25BRRf+Qg==
X-Received: by 2002:a05:6a20:a108:b0:225:c286:5907 with SMTP id
 adf61e73a8af0-2311d952742mr141432637.3.1752165701092; 
 Thu, 10 Jul 2025 09:41:41 -0700 (PDT)
Received: from gromero0.. (189-47-46-41.dsl.telesp.net.br. [189.47.46.41])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74eb9f5c7f7sm2919119b3a.142.2025.07.10.09.41.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Jul 2025 09:41:40 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-arm@nongnu.org, richard.henderson@linaro.org, alex.bennee@linaro.org
Cc: qemu-devel@nongnu.org,
	gustavo.romero@linaro.org
Subject: [PATCH v5 4/6] target/arm: Add FEAT_TCR2
Date: Thu, 10 Jul 2025 16:38:57 +0000
Message-Id: <20250710163858.1094780-5-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250710163858.1094780-1-gustavo.romero@linaro.org>
References: <20250710163858.1094780-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pf1-x42e.google.com
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
index a5fc2ca572..9579d93cec 100644
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
index 894e2a2997..9f900ee4f6 100644
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
index 963d3e064b..6f678aceeb 100644
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
index d18d0fb19a..8cb0709abe 100644
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
index 30505fb293..ae2046a7f6 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1248,6 +1248,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     SET_IDREG(isar, ID_AA64MMFR2, t);
 
     t = GET_IDREG(isar, ID_AA64MMFR3);
+    t = FIELD_DP64(t, ID_AA64MMFR3, TCRX, 1);       /* FEAT_TCR2 */
     t = FIELD_DP64(t, ID_AA64MMFR3, SCTLRX, 1);     /* FEAT_SCTLR2 */
     t = FIELD_DP64(t, ID_AA64MMFR3, SPEC_FPACC, 1); /* FEAT_FPACC_SPEC */
     SET_IDREG(isar, ID_AA64MMFR3, t);
-- 
2.34.1


