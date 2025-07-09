Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 476FFC83F0A
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Jul 2025 18:07:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZZBk-0001OK-PJ; Wed, 09 Jul 2025 14:06:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uZZB7-00014J-G1
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 14:05:58 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uZZB3-00048w-Ly
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 14:05:55 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-311d5fdf1f0so256337a91.1
 for <qemu-devel@nongnu.org>; Wed, 09 Jul 2025 11:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752084352; x=1752689152; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AmhliCegNfZGHfr7J+p0jeoV/6BX3pT1C+80y0xkf40=;
 b=mxiVph+hddOuVTNrWlyFS6TsUvExzjKTCGR7ayj3Mh8oK8kZ6QXiT2R0MtgN2WyxOy
 JBuym9Udq5kDA7n6NE9kuQcnr65enHwFGiop+JBN+/P2IzS0WZTvekrmYU/ItwxnO2xK
 YB8pAGx4SAdr/BBUaHWWkGiRW7w/41IEwpB3SiPRe4OQ1ZIm1y2+9yy6h1kMxXc1EE4S
 XYQ0PvMQ0blorXr6e8bYFA3FuOT9pkk/PGopXV4lbA+daJZ8Xx+MYLgPsCmvJj0AAqgU
 ko7UBTOG/dJyiKuT+wkA4tZG7dUDrUlE6hmFSTOkKr5sPdLKSyJpVTLMSKChrcLI22g7
 VEbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752084352; x=1752689152;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AmhliCegNfZGHfr7J+p0jeoV/6BX3pT1C+80y0xkf40=;
 b=a+BgT5OuseojEygoBs63OYpY/VL2LhoRSSvnXZPPbe/i5mbbYb2fkd1B6dlbpTNe/Z
 7zSbtToTgShWu88X63CBSldqNZnHLhPdnOO0mr1N5PWM+of6tR2h+y8/+DEJf9Aku29E
 dl03biLNouDFlyfB2sG9ir4Sn/zyoDoCol+exUnrYHpSHUuJcPOgx9x4tYamhXnfNu2v
 P9oBmYSyKC+8cd3XelBxdjsAKEGgzgYCeV9GFUFJvbyyi41PAKrIAEB+ajr4RXxVIeeg
 H9tDxt65WGDkF2VEdu2XferI3jIMct16UVSQ81pTkmw+EhsQXN86ivng2blivKbjEqbV
 b+IQ==
X-Gm-Message-State: AOJu0Yy4sVl5h304gdtqaVqSdCAHVQR0jZyyy8PkTlTs2Mx9SDdOzdii
 e5AJnN+3hzAx4Q6PdT73YSEpis6vAVvP3UcuFjUJWBIx1k4yfye98irsUj3TqRjrWcQ=
X-Gm-Gg: ASbGncteVsuYDBYk01YtNOu0LQu3XFgW4/bgiy4t4UcwYim6FB1fHes/ACJAXknsrEL
 HfvIV3ZcykzXZni12UvIWcJv4FXxiaUCbR2fo8gMft+C1R71UTRx/AmCGku8rqLlGv00+TfxBtl
 o1Eypbusj26ETnMV/1SmTO8te4PCwh8pmxamaXTiMfW9hrnn2LJfmPPSOXidfvs/hWBXEO/URJ1
 0VgJoJaDRMxOrPYYK3Yt/jpv+Q4/GqFS0WW8Omqk7/SGa8YyOHNu3e4tuvQsZrfP3qCrIZ2PePk
 Rl6/5bUEnBQR9Ogcppu5w0/qeaPbcXK1NuEDTNwgtbe10hwunTFqTzyalrjt394eRFI=
X-Google-Smtp-Source: AGHT+IF7n01vAizxIJsxMkOuXsK/RAkq6fyKho4QvjqgAJ/s1145LjgDO/lRt5uRDi655Vw2ZiNILw==
X-Received: by 2002:a17:90a:d44f:b0:311:abba:53c9 with SMTP id
 98e67ed59e1d1-31c3c25555dmr1442755a91.7.1752084351968; 
 Wed, 09 Jul 2025 11:05:51 -0700 (PDT)
Received: from gromero0.. ([189.110.24.38]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23c84599f07sm153380175ad.218.2025.07.09.11.05.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Jul 2025 11:05:51 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-arm@nongnu.org, richard.henderson@linaro.org, alex.bennee@linaro.org
Cc: qemu-devel@nongnu.org,
	gustavo.romero@linaro.org
Subject: [PATCH v4 2/6] target/arm: Add FEAT_MEC registers
Date: Wed,  9 Jul 2025 18:03:22 +0000
Message-Id: <20250709180326.1079826-3-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250709180326.1079826-1-gustavo.romero@linaro.org>
References: <20250709180326.1079826-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pj1-x102b.google.com
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

Add all FEAT_MEC registers.

To work properly, FEAT_MEC also depends on FEAT_SCTLR2 and FEAT_TCR2,
which are not implemented in this commit. The bits in SCTLR2 and TCR2
control which translation regimes use MECIDs, and determine which MECID
is selected.

FEAT_MEC also requires two new cache management instructions, not
included in this commit, that will be implemented in subsequent commits.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 target/arm/cpu-features.h |  5 +++
 target/arm/cpu.h          | 11 ++++++
 target/arm/helper.c       | 70 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 86 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 5876162428..552d8757b7 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -594,6 +594,11 @@ static inline bool isar_feature_aa64_hbc(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64ISAR2, BC) != 0;
 }
 
+static inline bool isar_feature_aa64_mec(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64MMFR3, MEC) != 0;
+}
+
 static inline bool isar_feature_aa64_mops(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64ISAR2, MOPS);
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 0f64c7b163..a93eebe077 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -576,6 +576,15 @@ typedef struct CPUArchState {
 
         /* NV2 register */
         uint64_t vncr_el2;
+
+        /* MEC registers */
+        uint64_t mecid_p0_el2;
+        uint64_t mecid_a0_el2;
+        uint64_t mecid_p1_el2;
+        uint64_t mecid_a1_el2;
+        uint64_t mecid_rl_a_el3;
+        uint64_t vmecid_p_el2;
+        uint64_t vmecid_a_el2;
     } cp15;
 
     struct {
@@ -2424,6 +2433,8 @@ FIELD(MFAR, FPA, 12, 40)
 FIELD(MFAR, NSE, 62, 1)
 FIELD(MFAR, NS, 63, 1)
 
+#define MECID_WIDTH 16
+
 QEMU_BUILD_BUG_ON(ARRAY_SIZE(((ARMCPU *)0)->ccsidr) <= R_V7M_CSSELR_INDEX_MASK);
 
 /* If adding a feature bit which corresponds to a Linux ELF
diff --git a/target/arm/helper.c b/target/arm/helper.c
index b3f0d6f17a..984406c945 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6827,6 +6827,72 @@ static const ARMCPRegInfo nmi_reginfo[] = {
       .resetfn = arm_cp_reset_ignore },
 };
 
+static CPAccessResult mecid_access(CPUARMState *env,
+                                   const ARMCPRegInfo *ri, bool isread)
+{
+    int el = arm_current_el(env);
+
+    if (el == 2) {
+        if (arm_security_space(env) != ARMSS_Realm) {
+	    return CP_ACCESS_UNDEFINED;
+	}
+
+        if (!(env->cp15.scr_el3 & SCR_MECEN)) {
+            return CP_ACCESS_TRAP_EL3;
+        }
+    }
+
+    return CP_ACCESS_OK;
+}
+
+static void mecid_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                        uint64_t value)
+{
+    value = extract64(value, 0, MECID_WIDTH);
+    raw_write(env, ri, value);
+}
+
+static const ARMCPRegInfo mec_reginfo[] = {
+    { .name = "MECIDR_EL2", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 4, .opc2 = 7, .crn = 10, .crm = 8,
+      .access = PL2_R, .type = ARM_CP_CONST, .resetvalue = MECID_WIDTH - 1 },
+    { .name = "MECID_P0_EL2", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 4, .opc2 = 0, .crn = 10, .crm = 8,
+      .access = PL2_RW, .accessfn = mecid_access,
+      .writefn = mecid_write,
+      .fieldoffset = offsetof(CPUARMState, cp15.mecid_p0_el2) },
+    { .name = "MECID_A0_EL2", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 4, .opc2 = 1, .crn = 10, .crm = 8,
+      .access = PL2_RW, .accessfn = mecid_access,
+      .writefn = mecid_write,
+      .fieldoffset = offsetof(CPUARMState, cp15.mecid_a0_el2) },
+    { .name = "MECID_P1_EL2", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 4, .opc2 = 2, .crn = 10, .crm = 8,
+      .access = PL2_RW, .accessfn = mecid_access,
+      .writefn = mecid_write,
+      .fieldoffset = offsetof(CPUARMState, cp15.mecid_p1_el2) },
+    { .name = "MECID_A1_EL2", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 4, .opc2 = 3, .crn = 10, .crm = 8,
+      .access = PL2_RW, .accessfn = mecid_access,
+      .writefn = mecid_write,
+      .fieldoffset = offsetof(CPUARMState, cp15.mecid_a1_el2) },
+    { .name = "MECID_RL_A_EL3", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 6, .opc2 = 1, .crn = 10, .crm = 10,
+      .access = PL3_RW, .accessfn = mecid_access,
+      .writefn = mecid_write,
+      .fieldoffset = offsetof(CPUARMState, cp15.mecid_rl_a_el3) },
+    { .name = "VMECID_P_EL2", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 4, .opc2 = 0, .crn = 10, .crm = 9,
+      .access = PL2_RW, .accessfn = mecid_access,
+      .writefn = mecid_write,
+      .fieldoffset = offsetof(CPUARMState, cp15.vmecid_p_el2) },
+    { .name = "VMECID_A_EL2", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 4, .opc2 = 1, .crn = 10, .crm = 9,
+      .access = PL2_RW, .accessfn = mecid_access,
+      .writefn = mecid_write,
+      .fieldoffset = offsetof(CPUARMState, cp15.vmecid_a_el2) },
+};
+
 static void define_pmu_regs(ARMCPU *cpu)
 {
     /*
@@ -9014,6 +9080,10 @@ void register_cp_regs_for_features(ARMCPU *cpu)
         define_arm_cp_regs(cpu, nmi_reginfo);
     }
 
+    if (cpu_isar_feature(aa64_mec, cpu)) {
+        define_arm_cp_regs(cpu, mec_reginfo);
+    }
+
     if (cpu_isar_feature(any_predinv, cpu)) {
         define_arm_cp_regs(cpu, predinv_reginfo);
     }
-- 
2.34.1


