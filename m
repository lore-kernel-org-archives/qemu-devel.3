Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3EA5CAC5BB
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Oct 2025 00:12:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5Yot-0000Fn-19; Sun, 05 Oct 2025 20:11:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1v5Yoc-0000Cs-KU
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 20:11:03 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1v5YoY-0004EP-B2
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 20:10:57 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2698e4795ebso41391165ad.0
 for <qemu-devel@nongnu.org>; Sun, 05 Oct 2025 17:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759709453; x=1760314253; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EVN+YmNfQibnEdc6QDAq+Bm5hOFHwnqw16eCPdTiIqo=;
 b=a2+d+17+vaP1ZSAyh+6e8Wu9p++Luboo9YkLUayeZtkGEoC9beA5g0fDrMb4FUD1Q4
 xKIWnFe/lZTqB99/Z6QvtHZNOYKQn6Dx9YFbxuP4cy06gAJObCUOXF/KjnNFyPGp+uuV
 e/MapSQEDiih0N9TFUROmv+rNT998SeDxfOPdQVc0U8Fw9weN2fpD5p/1I9eUDtjHmDV
 WdqL4NX3FEJYleox/eBwcrBSOzTan2LOGSP+jyERT4SYNjWOzoIXMIMBIq4wut7VHJOX
 W6Y49mxktd5mbH/dwaj1cp33sTAEUqq6aFIVsSffEeL51lHskN5s3U9HbvPvJreHokWW
 uSaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759709453; x=1760314253;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EVN+YmNfQibnEdc6QDAq+Bm5hOFHwnqw16eCPdTiIqo=;
 b=IqL/Nu9Cw9PmO7sdgAEJaJWb2AGcYjNDsuOkHNDDyX5lmyTtKEXgjsT3cRtdvue7FX
 fzDEkat971rI8AHatN+kUXnVhypJrByakenTZcrqZnypg7uWIhPibDiFAgJzqhsjPD3G
 p+CC2Fx+3DDoWYM18UP/07lh0Hacf3nTQAp1z6ASf6x5TeVcvAi341SOl4acKetLZs7d
 5Tmnt2MMIz1dj7JnjbE7Qo9K9nD1V6WjaU+KWPCIEozaGdr85vbDS+dEGhsZl4GR89km
 7t8vutvckp17oaqAD+s+fjWVfzQpHE/tjohkQysj6RnHO5R4wNYJsW5PLbskbMXlfgRs
 1STw==
X-Gm-Message-State: AOJu0YyJVqYsE9oqsROpaAIzDekxlVaRoBJT1NmBuVCExjphqfr4/Gbz
 q9LESxhPfAvlVy7AZOmENNM0nH+dnt5j1s6xebT47Iaoa1MCrY+KoSvuocjKQ3e3wriR6F4eAcs
 P4O8D
X-Gm-Gg: ASbGnct+fhe5WFe7lZY1+dV3NJHQMSDrs2WY8F3M6QnJtSOALiHd5wkGS3O8/QxAHG6
 dj0M07Fkmp57tabi+CJqmBBJ1aiTVn2i7JALNdm0H99IOEOdkrhiWeWrApbWOWruUVUQ/MOVm3z
 gl6o9fNLLtBrMcJ8GNJgP9zi3oJc/BE/CFoFvZm0C58i/5dKgvoHo/QLoDx4tJt3Een9hgB/47N
 EVePyLKdJ9UwAeFGqDiQ1ltF54sPcXHhsG40z5j1xLqvdWR25hYGGVDvspvLme5A2uUoymNnSsq
 qBUreLBxnM7sACBzTgCnzEbDb00/KCHuLmnhe8+6wsmI7xr9BuYo6cGp8DYeMBUIKRE5UegKc6M
 4tLrNY4dMx0KEVke0xnrjRLmc7h/Z55aws3t7IDSXTSn581l9c/7z4TwUAYSAx3lRtLE=
X-Google-Smtp-Source: AGHT+IGeEEl3TCsZdatHpH3OSHlnNhLIIBFeYyLkcKJvD+1ZWJetGFCkYmIN4kcHk8MuzU+tTE5uFQ==
X-Received: by 2002:a17:903:198b:b0:269:a4ed:13c9 with SMTP id
 d9443c01a7336-28e9a693f79mr97822355ad.30.1759709452742; 
 Sun, 05 Oct 2025 17:10:52 -0700 (PDT)
Received: from gromero0.. ([186.215.59.111]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-339c4a48584sm8804881a91.23.2025.10.05.17.10.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Oct 2025 17:10:52 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: alex.bennee@linaro.org,
	gustavo.romero@linaro.org
Subject: [PATCH v10 2/3] target/arm: Implement FEAT_MEC registers
Date: Mon,  6 Oct 2025 00:10:17 +0000
Message-Id: <20251006001018.219756-3-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251006001018.219756-1-gustavo.romero@linaro.org>
References: <20251006001018.219756-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x62d.google.com
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

Add all FEAT_MEC registers.  Enable access to the registers via the
SCTLR2 and TCR2 control bits.  Add the two new cache management
instructions, which are nops in QEMU because we do not model caches.

Message-ID: <20250711140828.1714666-3-gustavo.romero@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
[rth: Squash 3 patches to add all registers at once.]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 target/arm/cpu-features.h |   5 ++
 target/arm/cpu.c          |   3 ++
 target/arm/cpu.h          |  10 ++++
 target/arm/helper.c       | 109 ++++++++++++++++++++++++++++++++++++++
 target/arm/internals.h    |   3 ++
 5 files changed, 130 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 602f6a88e5..206c807530 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1344,6 +1344,11 @@ static inline bool isar_feature_aa64_sctlr2(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64MMFR3, SCTLRX) != 0;
 }
 
+static inline bool isar_feature_aa64_mec(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64MMFR3, MEC) != 0;
+}
+
 static inline bool isar_feature_aa64_pmuv3p1(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64DFR0, PMUVER) >= 4 &&
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 30e29fd315..baab2ff9b6 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -641,6 +641,9 @@ void arm_emulate_firmware_reset(CPUState *cpustate, int target_el)
             if (cpu_isar_feature(aa64_sctlr2, cpu)) {
                 env->cp15.scr_el3 |= SCR_SCTLR2EN;
             }
+            if (cpu_isar_feature(aa64_mec, cpu)) {
+                env->cp15.scr_el3 |= SCR_MECEN;
+            }
         }
 
         if (target_el == 2) {
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 2b9585dc80..6b9613a5d3 100644
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
@@ -1721,6 +1730,7 @@ static inline void xpsr_write(CPUARMState *env, uint32_t val, uint32_t mask)
 #define SCR_TCR2EN            (1ULL << 43)
 #define SCR_SCTLR2EN          (1ULL << 44)
 #define SCR_GPF               (1ULL << 48)
+#define SCR_MECEN             (1ULL << 49)
 #define SCR_NSE               (1ULL << 62)
 
 /* Return the current FPSCR value.  */
diff --git a/target/arm/helper.c b/target/arm/helper.c
index aa730addf2..c2c450617d 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -770,6 +770,9 @@ static void scr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
         if (cpu_isar_feature(aa64_sctlr2, cpu)) {
             valid_mask |= SCR_SCTLR2EN;
         }
+        if (cpu_isar_feature(aa64_mec, cpu)) {
+            valid_mask |= SCR_MECEN;
+        }
     } else {
         valid_mask &= ~(SCR_RW | SCR_ST);
         if (cpu_isar_feature(aa32_ras, cpu)) {
@@ -4994,6 +4997,96 @@ static const ARMCPRegInfo nmi_reginfo[] = {
       .resetfn = arm_cp_reset_ignore },
 };
 
+static CPAccessResult mecid_access(CPUARMState *env,
+                                   const ARMCPRegInfo *ri, bool isread)
+{
+    int el = arm_current_el(env);
+
+    if (el == 2) {
+        if (arm_security_space(env) != ARMSS_Realm) {
+            return CP_ACCESS_UNDEFINED;
+        }
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
+static CPAccessResult cipae_access(CPUARMState *env, const ARMCPRegInfo *ri,
+                                   bool isread)
+{
+    switch (arm_security_space(env)) {
+    case ARMSS_Root:  /* EL3 */
+    case ARMSS_Realm: /* Realm EL2 */
+        return CP_ACCESS_OK;
+    default:
+        return CP_ACCESS_UNDEFINED;
+    }
+}
+
+static const ARMCPRegInfo mec_reginfo[] = {
+    { .name = "MECIDR_EL2", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 4, .opc2 = 7, .crn = 10, .crm = 8,
+      .access = PL2_R, .type = ARM_CP_CONST | ARM_CP_NV_NO_TRAP,
+      .resetvalue = MECID_WIDTH - 1 },
+    { .name = "MECID_P0_EL2", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 4, .opc2 = 0, .crn = 10, .crm = 8,
+      .access = PL2_RW, .type = ARM_CP_NV_NO_TRAP,
+      .accessfn = mecid_access, .writefn = mecid_write,
+      .fieldoffset = offsetof(CPUARMState, cp15.mecid_p0_el2) },
+    { .name = "MECID_A0_EL2", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 4, .opc2 = 1, .crn = 10, .crm = 8,
+      .access = PL2_RW, .type = ARM_CP_NV_NO_TRAP,
+      .accessfn = mecid_access, .writefn = mecid_write,
+      .fieldoffset = offsetof(CPUARMState, cp15.mecid_a0_el2) },
+    { .name = "MECID_P1_EL2", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 4, .opc2 = 2, .crn = 10, .crm = 8,
+      .access = PL2_RW, .type = ARM_CP_NV_NO_TRAP,
+      .accessfn = mecid_access, .writefn = mecid_write,
+      .fieldoffset = offsetof(CPUARMState, cp15.mecid_p1_el2) },
+    { .name = "MECID_A1_EL2", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 4, .opc2 = 3, .crn = 10, .crm = 8,
+      .access = PL2_RW, .type = ARM_CP_NV_NO_TRAP,
+      .accessfn = mecid_access, .writefn = mecid_write,
+      .fieldoffset = offsetof(CPUARMState, cp15.mecid_a1_el2) },
+    { .name = "MECID_RL_A_EL3", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 6, .opc2 = 1, .crn = 10, .crm = 10,
+      .access = PL3_RW, .accessfn = mecid_access,
+      .writefn = mecid_write,
+      .fieldoffset = offsetof(CPUARMState, cp15.mecid_rl_a_el3) },
+    { .name = "VMECID_P_EL2", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 4, .opc2 = 0, .crn = 10, .crm = 9,
+      .access = PL2_RW, .type = ARM_CP_NV_NO_TRAP,
+      .accessfn = mecid_access, .writefn = mecid_write,
+      .fieldoffset = offsetof(CPUARMState, cp15.vmecid_p_el2) },
+    { .name = "VMECID_A_EL2", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 4, .opc2 = 1, .crn = 10, .crm = 9,
+      .access = PL2_RW, .type = ARM_CP_NV_NO_TRAP,
+      .accessfn = mecid_access, .writefn = mecid_write,
+      .fieldoffset = offsetof(CPUARMState, cp15.vmecid_a_el2) },
+    { .name = "DC_CIPAE", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 4, .crn = 7, .crm = 14, .opc2 = 0,
+      .access = PL2_W, .type = ARM_CP_NOP | ARM_CP_NV_NO_TRAP,
+      .accessfn = cipae_access },
+};
+
+static const ARMCPRegInfo mec_mte_reginfo[] = {
+    { .name = "DC_CIGDPAE", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 4, .crn = 7, .crm = 14, .opc2 = 7,
+      .access = PL2_W, .type = ARM_CP_NOP | ARM_CP_NV_NO_TRAP,
+      .accessfn = cipae_access },
+};
+
 #ifndef CONFIG_USER_ONLY
 /*
  * We don't know until after realize whether there's a GICv3
@@ -5836,6 +5929,9 @@ static void sctlr2_el2_write(CPUARMState *env, const ARMCPRegInfo *ri,
 {
     uint64_t valid_mask = 0;
 
+    if (cpu_isar_feature(aa64_mec, env_archcpu(env))) {
+        valid_mask |= SCTLR2_EMEC;
+    }
     value &= valid_mask;
     raw_write(env, ri, value);
 }
@@ -5845,6 +5941,9 @@ static void sctlr2_el3_write(CPUARMState *env, const ARMCPRegInfo *ri,
 {
     uint64_t valid_mask = 0;
 
+    if (cpu_isar_feature(aa64_mec, env_archcpu(env))) {
+        valid_mask |= SCTLR2_EMEC;
+    }
     value &= valid_mask;
     raw_write(env, ri, value);
 }
@@ -5907,6 +6006,9 @@ static void tcr2_el2_write(CPUARMState *env, const ARMCPRegInfo *ri,
 {
     uint64_t valid_mask = 0;
 
+    if (cpu_isar_feature(aa64_mec, env_archcpu(env))) {
+        valid_mask |= TCR2_AMEC0 | TCR2_AMEC1;
+    }
     value &= valid_mask;
     raw_write(env, ri, value);
 }
@@ -7159,6 +7261,13 @@ void register_cp_regs_for_features(ARMCPU *cpu)
         define_arm_cp_regs(cpu, tcr2_reginfo);
     }
 
+    if (cpu_isar_feature(aa64_mec, cpu)) {
+        define_arm_cp_regs(cpu, mec_reginfo);
+        if (cpu_isar_feature(aa64_mte, cpu)) {
+            define_arm_cp_regs(cpu, mec_mte_reginfo);
+        }
+    }
+
     if (cpu_isar_feature(any_predinv, cpu)) {
         define_arm_cp_regs(cpu, predinv_reginfo);
     }
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 1d958dbf68..6bd9f8310c 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -2007,4 +2007,7 @@ bool arm_pan_enabled(CPUARMState *env);
 /* Compare uint64_t for qsort and bsearch. */
 int compare_u64(const void *a, const void *b);
 
+/* Used in FEAT_MEC to set the MECIDWidthm1 field in the MECIDR_EL2 register. */
+#define MECID_WIDTH 16
+
 #endif
-- 
2.34.1


