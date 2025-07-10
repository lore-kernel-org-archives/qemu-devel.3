Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F185C83F17
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 17:03:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZufh-0005BQ-Hv; Thu, 10 Jul 2025 13:02:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uZuL6-0003fs-Al
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 12:41:40 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uZuL4-00018f-Ch
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 12:41:40 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-748feca4a61so847760b3a.3
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 09:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752165697; x=1752770497; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZeG1zg84q+9XSbqQeM5w+nO7GmXG52C215che07ehKE=;
 b=UHDq2+mhxMGmVDLplaPSgAy/kzKC8PQ0ZdozZ9zONOQ6xfTD8BCL0Y519GxVPd0YLL
 sBByxFFg66b3IG7l+wMIj+DW5wFbgtPRC2CMGH5oIBFhppLxSXSrufZNTHysqfd6luXN
 iHnqhORdVryID2Q3DPITv+ahphCyY5fvcFU2WvtGE9yYERZb4fx3uuC9KoTemM9UCQrh
 GX4mRQ+LqaxbUgb4lhA2PsFfPbluJ+rF0FxVIvdbswr2A6KfwXZy0PCbVDV//xqte+mA
 8zO+zxivm8lytb2Bbirr4qmK5xuKCwLbU+Ep08+rWxSrbA6kImvMIW88ZxCMg0B/vlqu
 cWcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752165697; x=1752770497;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZeG1zg84q+9XSbqQeM5w+nO7GmXG52C215che07ehKE=;
 b=Zz18QwQuobAId6K4qqhCw1AhEANHkfil/MwEDA0cgs2YvndBCBCpeqWolZt/m7PN+R
 34ad3UWnOaZt5A1JrOraEvHXU5HMcVo2CwmZ+rqZv2mhlR+8LO0L04RtB4EnQ9TiWIwS
 SV3A8OX6HdMV8+wmR5DavagTUJsi8IkMzlRYm+U4rRuFmqTMVVMSg24hofBSGxGQgz8h
 /mTkA5PqN8kSvtOR9WCGX42jKPgygYId+YzqvsqdpKscS4fGzvazhX9snkz11YyWajWE
 qirYsfCkHW+zSHUIxMAfLcv0FpTyJFmjHT4XCpNyHI2NHKZ1enXWW/mH097EihCd9LtY
 DPQA==
X-Gm-Message-State: AOJu0Yyp20VclHzAdiH0UEt3Cjko1EXvNiixnd/d79gS5oSf92kBfXcs
 7MQ70uzkCGZV1OP11b6fcPmWOBaxhBAyFAWnDDywX/eJNYtlEbdCGzG2FPagZeT3ghb6QLh/oQ0
 QuK+tLJM=
X-Gm-Gg: ASbGnctXRZkuvXGLOM139EWQEB5NNiqyqLM1SsXQtbvRKx22uKjnTCGIpfo3lFU6n5O
 oy7RQulZxJVk3DFa32LNy0qWmeyW9m9dqXGcsODbFijdF9p7LqMsIvLWwyIROkQVjpfJfzxT0He
 ZY7g2pa4fzAo5E3qp3lxYPmVsghNbxda25vqDA+MmGebdpJMi6iwm3lKpwDNznGZgP4+R0GpMA2
 ycImEve+maXZwGrnbqTivU2+8ql68yGmW0L5yDFVBQI/cdQmJEwxzNKvePx9MhF2yFGe3Qt0awI
 CEwvFFqdKaU7wQn8OAyVqHNatndAFUASFhoPDVgbo0cgBAqpyNNGXjQZ2I+cTMb9RgQf+NKTyGQ
 To69oPd0pE51/vbQrBycWrQ==
X-Google-Smtp-Source: AGHT+IH1oNED/ExH4aYYmqdEJ81dnY/8WeM810V+dPwsrLgD19oGNQPY1eW8IYzNULScAEVGwCmkKw==
X-Received: by 2002:aa7:8888:0:b0:74c:efae:ffae with SMTP id
 d2e1a72fcca58-74eb8e8adc5mr4570316b3a.5.1752165696861; 
 Thu, 10 Jul 2025 09:41:36 -0700 (PDT)
Received: from gromero0.. (189-47-46-41.dsl.telesp.net.br. [189.47.46.41])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74eb9f5c7f7sm2919119b3a.142.2025.07.10.09.41.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Jul 2025 09:41:36 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-arm@nongnu.org, richard.henderson@linaro.org, alex.bennee@linaro.org
Cc: qemu-devel@nongnu.org,
	gustavo.romero@linaro.org
Subject: [PATCH v5 2/6] target/arm: Add FEAT_MEC registers
Date: Thu, 10 Jul 2025 16:38:55 +0000
Message-Id: <20250710163858.1094780-3-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250710163858.1094780-1-gustavo.romero@linaro.org>
References: <20250710163858.1094780-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pf1-x431.google.com
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


