Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D977C83F20
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 21:11:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZyXx-0000Ym-9e; Thu, 10 Jul 2025 17:11:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uZyXn-0000V8-8x
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 17:11:03 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uZyXl-0006cv-DX
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 17:11:02 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-23c703c471dso22728005ad.0
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 14:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752181858; x=1752786658; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZeG1zg84q+9XSbqQeM5w+nO7GmXG52C215che07ehKE=;
 b=j5hAFWaGvTGW+M+VQK9xU3YM752/iQtfWExSyz8WZhQNiU7rlxPB6Vsdrp5fnlarrA
 UYbSD3ZmahFqHLQKghhANjO8x/zRsD1Kw06BsYclsJrTrMei9ktqy5NgMDbcNo+skt1D
 Vlh6F6kstx4AmBAj2lmC2KCR3pJo6iBI/L0PbCNcOtGdRo+2mr1F+FNXP+v4n0n6/7sz
 v6lKb05V6bi52em/tTQP4+fAfVfJ+QxKxzVyCKjBGXxaRhovix9w2xYoi96KpaeAzfg/
 KROFogC/C0e5hFVJL/PpzVYoXREuXfmZFnGGusCWTZRpPzat/oiJecFraQ+0SnM1eSgH
 Q29Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752181858; x=1752786658;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZeG1zg84q+9XSbqQeM5w+nO7GmXG52C215che07ehKE=;
 b=obCbVP5B9BAHnzGWv2xPMmwWjveq9Q0ROrAIQA7fcSAqTvsIDa+wvkmy2Q3K+NMBr9
 8vjlZD/G+PDT1Ypz4e9bi8vjveqFxoMoC/Bi2fIWUNaezO4ztQDf9gnCkuRIOcEKUZfm
 7oyNA9my+NmLnUgFktPCQY3b6onMgDml/CbsN83hbIbbVsNbMNrvmqVe4WUCInGKWPJK
 YB1NhmUHecJK6Nt1ssMBlsdHoq0MnkcPVQEriJyPlyIpQrG34lTiMqk1TtnT8wlRG6Dw
 2QpoCaX801i6R7tgiFcQ/72lr+JBiSYPsWDVkOQdLm12a2XZQzZySR/517pl06vG7HSe
 zEHw==
X-Gm-Message-State: AOJu0YyO4QyxpKnrjh2wW3rDbtZxfCsugGCndSpue6GvoKTujDVVYX+I
 Ziy1sSIlc+4YjOa2HyWbPbw7kHB5pbacD0jRssTVRj7KCvjGez3KwpBxIsPrMsMVmxo=
X-Gm-Gg: ASbGncsfDYVLczQYa10xhuDUYRZB3FJpaKPVzYULh+lGml4wRIJxbg8P/VsluQIcgOj
 ntnfOUCgFeC57xPuAYvLPwUIwYOIRxf5mIPc562aUjeglFmG25UfYwz8bs5gdyB96tmBA6FEyLA
 /DzVO6zO3aNff2372LyghUwgw9ABCIz+XW2HI8SbTGpfCZZWZpi0WhrBaOys4eecolm6dv96kLT
 lIbt2aRi90YnqSABeVJBQ2YpIVv1K00wccjpJzwAcVorU9wvLT+VJA1bIMpJICzHTcWaR9rEjDO
 cUbyoKCW+dzSGu2ZQLM41XFn6FlobTBTmP+WxdhEpz3/4CStZRl20QELTQxaETOaCIu+0MZ29E2
 iKD2oi0JLnrxSk0hWO0vJtqjN5F2Ze8V/qcebS0++Viy+ggAHaGDREcpsdA==
X-Google-Smtp-Source: AGHT+IHZPLvo4k+N814GjSOGCWpo1AVI9ZAJwFUiNIQSwpe87BErQP+rVGZ8p4nw+0wDHTh8P+VLSQ==
X-Received: by 2002:a17:902:e745:b0:235:e1d6:2ac0 with SMTP id
 d9443c01a7336-23de300830fmr68992725ad.24.1752181857392; 
 Thu, 10 Jul 2025 14:10:57 -0700 (PDT)
Received: from gromero0.. (189-47-46-41.dsl.telesp.net.br. [189.47.46.41])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23de434d6b0sm30447775ad.203.2025.07.10.14.10.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Jul 2025 14:10:56 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-arm@nongnu.org, richard.henderson@linaro.org, alex.bennee@linaro.org
Cc: qemu-devel@nongnu.org,
	gustavo.romero@linaro.org
Subject: [PATCH v6 2/6] target/arm: Add FEAT_MEC registers
Date: Thu, 10 Jul 2025 21:09:37 +0000
Message-Id: <20250710210941.1098088-3-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250710210941.1098088-1-gustavo.romero@linaro.org>
References: <20250710210941.1098088-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
is selected and will be implemented in subsequent commits.

FEAT_MEC also requires two new cache management instructions, not
included in this commit, that will be implemented in a subsequent commit.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu-features.h |  5 +++
 target/arm/cpu.h          |  9 +++++
 target/arm/helper.c       | 70 +++++++++++++++++++++++++++++++++++++++
 target/arm/internals.h    |  3 ++
 4 files changed, 87 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 5876162428..72b6fd9b27 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -904,6 +904,11 @@ static inline bool isar_feature_aa64_nv2(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64MMFR2, NV) >= 2;
 }
 
+static inline bool isar_feature_aa64_mec(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64MMFR3, MEC) != 0;
+}
+
 static inline bool isar_feature_aa64_pmuv3p1(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64DFR0, PMUVER) >= 4 &&
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 0f64c7b163..40ca093331 100644
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
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 21a8d67edd..77ba2a2273 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1982,4 +1982,7 @@ void vfp_clear_float_status_exc_flags(CPUARMState *env);
  */
 void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val, uint32_t mask);
 
+/* Used in FEAT_MEC to set the MECIDWidthm1 field in the MECIDR_EL2 register. */
+#define MECID_WIDTH 16
+
 #endif
-- 
2.34.1


