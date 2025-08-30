Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC98CCA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 17:57:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNvv-0007jy-QG; Sat, 30 Aug 2025 11:56:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usEM2-0005wd-65
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:42:24 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usELz-00049i-3C
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:42:20 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-772301f8a4cso1455766b3a.3
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 22:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756532538; x=1757137338; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7lLK/x0vxeiUSIhLvYmhH4s0sefCFctg4R61gIveZjQ=;
 b=usWbNEDN7sR4PupVBbGyMGQChRWFG+j+V/LYRvsxcXg7QWnAruiU+IPbpd7CkkvPZo
 DHqa+4UR6OjRIoA9Q7BpyVym3TXcOlF0TxqGRcmbx2Jl83JzbhzlrJ358UyBKq/pJyG3
 GGD935WFN4MDUxtGB2bX9W2ZJBGMPUj45074uFPUe1MJlUJS0sZhnGECalbymWLvKfcv
 y8UEMvYYndL3tk6r7X9cj/4PAU/ZFBEIM772Z3nI7Fub7GxZXAamEPLe4eG4BQB2yZH4
 Ass8BNtPwhJrsW1xbiqhN8eaz0WloOvSqr66dZ6Va9FWRuaP1m/U1CwumJKibb2X1fzq
 4jaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756532538; x=1757137338;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7lLK/x0vxeiUSIhLvYmhH4s0sefCFctg4R61gIveZjQ=;
 b=ad6OAcWXRtFAbHQqveWVyXKGn7mJtUwRCbzAa05iv1PSpjEyQkEGVTqeq0GZh3+Elg
 GZApQ76tCyxXh1LMl0zfPkGoEz2nHmSjRJIvJ5QPMnihvQm1yM/V+cTpo5Q1q4wxTfMH
 hbuN6y+hsijzoghheAFzVpUNtR16tQw1NpMJFo5rLiaO5ZWtX2UG/ecq+rhTsbHDA0Hk
 axqGq4Y8u+4VJNOus/mcMeNmUsyyZ7Af0HB9J9IuGQBZb7epZJRrgieZlsUtaQxx+Qcc
 344M0u0wTQJL+Ty8G20M4KWR8WMfmoxgSipRLVL5O84tT6GZUhc4wGGHTbj368gtdzaD
 GKzQ==
X-Gm-Message-State: AOJu0YwqWFkFtAKZ0O7dWqVwqIaYxt1QIZcbOu6UsNXKUJmZJVMMb6v3
 q37RRNPCyqsnkYCbNoXNqjgN3HTon8SOMJPgE6+IZQad0zGJ6wLc1ARBSXifHwpF1lPnjhrrpy6
 lgv+gFR0=
X-Gm-Gg: ASbGncuZ0xJxrmAEsRT/FnAOvM5iI1oiWjFo3kX3+BotdvrM292aRgqe9aJEqRjJzRt
 DLDHgqWxylGP+Oh7C1/X7iYClwcTQu3c9HQ40WaT0u1s0uW8fdJu1TIaeG+P/EIiaYqx+4VCj20
 RyNVQ34DJIEp3tQIYVuZaDTFS4vFlr6FyTd+OCorLZzWKslpC59MuirItMog8YEhdn5iWjcMSfg
 xUpqHR2MTZRBImO4VJGtomFAriwSQGVUk18i477YEtqC4fai1uTe/W5nQ391x7vMUoeYm9CHTfN
 Vh5zKVcFTj1S0YrnUMXFz3414xcY+lvJ66YQhEoKomYqbFjXVMvI2+DOEAgNTVsmfBnwAaKFKVe
 Qi1vGGcNDqJjn1u/MnbKrEaFxr9l/yG4UMiAPkTOfIoTZCoxopax1d51TBCdsdPoC/dy1g44=
X-Google-Smtp-Source: AGHT+IEevAUjssUVVkmf6Y51EVPkXAKW1XoJ5/r8IcnPFYsTNmh/N0Qn/oN3qrysd91dej5Qn4bJiQ==
X-Received: by 2002:a05:6a20:72a4:b0:243:b144:adaa with SMTP id
 adf61e73a8af0-243d6f7ef01mr1757482637.54.1756532537651; 
 Fri, 29 Aug 2025 22:42:17 -0700 (PDT)
Received: from stoup.. (122-150-204-48.dyn.ip.vocus.au. [122.150.204.48])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b4d96829a66sm2435905a12.6.2025.08.29.22.42.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 22:42:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 15/84] target/arm: Implement PIR_ELx, PIRE0_ELx,
 S2PIR_EL2 registers
Date: Sat, 30 Aug 2025 15:40:19 +1000
Message-ID: <20250830054128.448363-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250830054128.448363-1-richard.henderson@linaro.org>
References: <20250830054128.448363-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpregs.h |  2 ++
 target/arm/cpu.h    |  4 +++
 target/arm/cpu.c    |  4 +++
 target/arm/helper.c | 70 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 80 insertions(+)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index 2a4826f5c4..9efe9238c1 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -776,6 +776,8 @@ typedef enum FGTBit {
     DO_BIT(HFGRTR, ERRIDR_EL1),
     DO_REV_BIT(HFGRTR, NSMPRI_EL1),
     DO_REV_BIT(HFGRTR, NTPIDR2_EL0),
+    DO_REV_BIT(HFGRTR, NPIRE0_EL1),
+    DO_REV_BIT(HFGRTR, NPIR_EL1),
 
     /* Trap bits in HDFGRTR_EL2 / HDFGWTR_EL2, starting from bit 0. */
     DO_BIT(HDFGRTR, DBGBCRN_EL1),
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index c15d79a106..9eeecd45a3 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -369,6 +369,9 @@ typedef struct CPUArchState {
         uint64_t tcr2_el[3];
         uint64_t vtcr_el2; /* Virtualization Translation Control.  */
         uint64_t vstcr_el2; /* Secure Virtualization Translation Control. */
+        uint64_t pir_el[4]; /* PIRE0_EL1, PIR_EL1, PIR_EL2, PIR_EL3 */
+        uint64_t pire0_el2;
+        uint64_t s2pir_el2;
         uint32_t c2_data; /* MPU data cacheable bits.  */
         uint32_t c2_insn; /* MPU instruction cacheable bits.  */
         union { /* MMU domain access control register
@@ -1729,6 +1732,7 @@ static inline void xpsr_write(CPUARMState *env, uint32_t val, uint32_t mask)
 #define SCR_ENTP2             (1ULL << 41)
 #define SCR_TCR2EN            (1ULL << 43)
 #define SCR_SCTLR2EN          (1ULL << 44)
+#define SCR_PIEN              (1ULL << 45)
 #define SCR_GPF               (1ULL << 48)
 #define SCR_NSE               (1ULL << 62)
 
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 27a4610da5..bf4bb04d95 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -650,6 +650,10 @@ void arm_emulate_firmware_reset(CPUState *cpustate, int target_el)
             if (cpu_isar_feature(aa64_sctlr2, cpu)) {
                 env->cp15.scr_el3 |= SCR_SCTLR2EN;
             }
+            if (cpu_isar_feature(aa64_s1pie, cpu) ||
+                cpu_isar_feature(aa64_s2pie, cpu)) {
+                env->cp15.scr_el3 |= SCR_PIEN;
+            }
         }
 
         if (target_el == 2) {
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 167362e32c..638d32fd80 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -747,6 +747,10 @@ static void scr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
         if (cpu_isar_feature(aa64_sctlr2, cpu)) {
             valid_mask |= SCR_SCTLR2EN;
         }
+        if (cpu_isar_feature(aa64_s1pie, cpu) ||
+            cpu_isar_feature(aa64_s2pie, cpu)) {
+            valid_mask |= SCR_PIEN;
+        }
     } else {
         valid_mask &= ~(SCR_RW | SCR_ST);
         if (cpu_isar_feature(aa32_ras, cpu)) {
@@ -4575,6 +4579,11 @@ static void define_arm_vh_e2h_redirects_aliases(ARMCPU *cpu)
           "SCXTNUM_EL1", "SCXTNUM_EL2", "SCXTNUM_EL12",
           isar_feature_aa64_scxtnum },
 
+        { K(3, 0, 10, 2, 3), K(3, 4, 10, 2, 3), K(3, 5, 10, 2, 3),
+          "PIR_EL1", "PIR_EL2", "PIR_EL12", isar_feature_aa64_s1pie },
+        { K(3, 0, 10, 2, 2), K(3, 4, 10, 2, 2), K(3, 5, 10, 2, 2),
+          "PIRE0_EL1", "PIRE0_EL2", "PIRE0_EL12", isar_feature_aa64_s1pie },
+
         /* TODO: ARMv8.2-SPE -- PMSCR_EL2 */
         /* TODO: ARMv8.4-Trace -- TRFCR_EL2 */
     };
@@ -6143,6 +6152,60 @@ static const ARMCPRegInfo tcr2_reginfo[] = {
       .fieldoffset = offsetof(CPUARMState, cp15.tcr2_el[2]) },
 };
 
+static CPAccessResult pien_access(CPUARMState *env, const ARMCPRegInfo *ri,
+                                  bool isread)
+{
+    if (arm_feature(env, ARM_FEATURE_EL3)
+        && !(env->cp15.scr_el3 & SCR_PIEN)
+        && arm_current_el(env) < 3) {
+        return CP_ACCESS_TRAP_EL3;
+    }
+    return CP_ACCESS_OK;
+}
+
+static CPAccessResult pien_el1_access(CPUARMState *env, const ARMCPRegInfo *ri,
+                                      bool isread)
+{
+    CPAccessResult ret = access_tvm_trvm(env, ri, isread);
+    if (ret == CP_ACCESS_OK) {
+        ret = pien_access(env, ri, isread);
+    }
+    return ret;
+}
+
+static const ARMCPRegInfo s1pie_reginfo[] = {
+    { .name = "PIR_EL1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 0, .opc2 = 3, .crn = 10, .crm = 2,
+      .access = PL1_RW, .accessfn = pien_el1_access,
+      .fgt = FGT_NPIR_EL1, .nv2_redirect_offset = 0x2a0 | NV2_REDIR_NV1,
+      .fieldoffset = offsetof(CPUARMState, cp15.pir_el[1]) },
+    { .name = "PIR_EL2", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 4, .opc2 = 3, .crn = 10, .crm = 2,
+      .access = PL2_RW, .accessfn = pien_access,
+      .fieldoffset = offsetof(CPUARMState, cp15.pir_el[2]) },
+    { .name = "PIR_EL3", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 6, .opc2 = 3, .crn = 10, .crm = 2,
+      .access = PL3_RW,
+      .fieldoffset = offsetof(CPUARMState, cp15.pir_el[3]) },
+    { .name = "PIRE0_EL1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 0, .opc2 = 2, .crn = 10, .crm = 2,
+      .access = PL1_RW, .accessfn = pien_el1_access,
+      .fgt = FGT_NPIRE0_EL1, .nv2_redirect_offset = 0x290 | NV2_REDIR_NV1,
+      .fieldoffset = offsetof(CPUARMState, cp15.pir_el[0]) },
+    { .name = "PIRE0_EL2", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 4, .opc2 = 2, .crn = 10, .crm = 2,
+      .access = PL2_RW, .accessfn = pien_access,
+      .fieldoffset = offsetof(CPUARMState, cp15.pire0_el2) },
+};
+
+static const ARMCPRegInfo s2pie_reginfo[] = {
+    { .name = "S2PIR_EL2", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 4, .opc2 = 5, .crn = 10, .crm = 2,
+      .access = PL2_RW, .accessfn = pien_access,
+      .nv2_redirect_offset = 0x2b0,
+      .fieldoffset = offsetof(CPUARMState, cp15.s2pir_el2) },
+};
+
 void register_cp_regs_for_features(ARMCPU *cpu)
 {
     /* Register all the coprocessor registers based on feature bits */
@@ -7380,6 +7443,13 @@ void register_cp_regs_for_features(ARMCPU *cpu)
         define_arm_cp_regs(cpu, tcr2_reginfo);
     }
 
+    if (cpu_isar_feature(aa64_s1pie, cpu)) {
+        define_arm_cp_regs(cpu, s1pie_reginfo);
+    }
+    if (cpu_isar_feature(aa64_s2pie, cpu)) {
+        define_arm_cp_regs(cpu, s2pie_reginfo);
+    }
+
     if (cpu_isar_feature(any_predinv, cpu)) {
         define_arm_cp_regs(cpu, predinv_reginfo);
     }
-- 
2.43.0


