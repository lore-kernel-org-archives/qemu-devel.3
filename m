Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A9E2C87FC9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:39:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLjY-0004n5-01; Sat, 02 Aug 2025 19:33:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLh3-0007MD-4Y
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:31:13 -0400
Received: from mail-oa1-x2c.google.com ([2001:4860:4864:20::2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLh1-0004zV-1g
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:31:12 -0400
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-306b7eb492aso2041038fac.0
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754177470; x=1754782270; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L0ihX/6NjLJeiAV+rHpWXFChl+HIpT5VNQEwKbT4BfA=;
 b=GeITLfHgNtSvtnjhGrxgntU2YsGBWEoW/ivuZ0qPAMAplvw3Q6iryCbirqyQg1Y4Rl
 VJoFIu/MHXOLLNe1xRkifg0+zRy2/3DuFPRhK1nJBPc8QlC9E59LAP7jcpDmLEbE/gm0
 W02bColussaIJQd9DFL/uCu6KoyPpefmGuisdqyWsU0JA0tCcY80uLlHIaysc2mI4dSo
 iIg0JkhwomxNcCCRdSWIVEF8n3Gs6YDvc1Ee5ivZzYBFURCq5XB3/2b95V5VoZWIBkFl
 b8Up4+7ApVvhhQJ80SYOgr/zy7diTq5tWgcFZKZTJA7rpeyF4mc6o1+f+ylm8/ufjt1o
 mRKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754177470; x=1754782270;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L0ihX/6NjLJeiAV+rHpWXFChl+HIpT5VNQEwKbT4BfA=;
 b=LE7EHCXWvV4gXTKknniSdOO70SwS7WxOFfITSsf3hYJDYpfLnkI8qjZNoJqai0haxB
 j7nOEJvQ30uWUVA91qnUAaI4JIhVTku/nw3zBIgOiNFZ4QFGeyRl9TjI9wuMitkoXway
 NI4fzqQTC/LoIaYMXB3bc5ca9Mnz9bbC/EuH8VK4Lx2RaLNcnXup9nAKPowp/sfi7iIo
 StW5sI0pQ3aV5dmzG1UsMYkUq0+juzQNpgwP+EdAB1fXC0Mho4+/zUFpfNUVTi3K3o9O
 RwR2wwfA2Rc93MlDOElnSJgrOw9BdzhojhkhT1Poni6RmduF1ZfC3IbPNQ2Kj3Jn4F6n
 LAng==
X-Gm-Message-State: AOJu0Yx1Vq1A45Cgov8G+94J2a2WaLoR6BZbcKo7ONbZysyltFFnURu/
 jXcPNoTN64PVoJoHSyu9XEXe839I+L6BrR7OiG7j4Nul0ycnH17JCLiOlCo1NGHSknPjwZ0GPdU
 h6iNHYxU=
X-Gm-Gg: ASbGncvhhgYfS36f0gLKAJZJEaAKl1CTr9ZlW705Tc4v7dLxWOrMes2QccWRY8L7ZvE
 p2hBy8D9GS6b+GjMr0IDykbBAcYtgbof0J+VBI2cphocWjKfDSh27KbHzlS2t2BG1/01O9Bqfuq
 fIHqsUZUELSibhu5px9LDrPlwnAcjDgNK3qjlroi9GzVuRLsSDke8QGRzEaNZPXjiNrRnQ9b922
 gK6RjzR33XzeFc2SeSuaFFUDBdoENlAABaSScoTB/OinCZa9vkDYH1rCDHZ0xRfy89ya9yjscrl
 FicNae7GA5aVUHTRpwfIb+XVc2hkxwMyyL7M5RnRQggFsT1p6GujDITIxOwJcBWGuvmZCClnZiV
 1UNsWgw90Oq/0R7nrLZNBoIxhKWETSeNO+kMBhLf2mzOURfcODHhl
X-Google-Smtp-Source: AGHT+IGr162rRzZrx4qHcdlEVYIJ2UOpilOLsjoYgRy8s/XY3ZfHlQJWAl6RdiRg1CASgGUxKm4RNw==
X-Received: by 2002:a05:6870:b40d:b0:2d5:2dfd:e11c with SMTP id
 586e51a60fabf-30b668dc0fdmr2764954fac.7.1754177469916; 
 Sat, 02 Aug 2025 16:31:09 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-30b8e3c9b32sm71031fac.24.2025.08.02.16.31.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:31:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 15/85] target/arm: Implement PIR_ELx, PIRE0_ELx,
 S2PIR_EL2 registers
Date: Sun,  3 Aug 2025 09:28:43 +1000
Message-ID: <20250802232953.413294-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802232953.413294-1-richard.henderson@linaro.org>
References: <20250802232953.413294-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2c.google.com
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
index defe2852f2..fb87fcc3e6 100644
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
@@ -1738,6 +1741,7 @@ static inline void xpsr_write(CPUARMState *env, uint32_t val, uint32_t mask)
 #define SCR_ENTP2             (1ULL << 41)
 #define SCR_TCR2EN            (1ULL << 43)
 #define SCR_SCTLR2EN          (1ULL << 44)
+#define SCR_PIEN              (1ULL << 45)
 #define SCR_GPF               (1ULL << 48)
 #define SCR_MECEN             (1ULL << 49)
 #define SCR_NSE               (1ULL << 62)
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index f0545a276e..b472992b4a 100644
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
             if (cpu_isar_feature(aa64_mec, cpu)) {
                 env->cp15.scr_el3 |= SCR_MECEN;
             }
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 61ba9ba5b2..6353b2dea1 100644
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
         if (cpu_isar_feature(aa64_mec, cpu)) {
             valid_mask |= SCR_MECEN;
         }
@@ -4578,6 +4582,11 @@ static void define_arm_vh_e2h_redirects_aliases(ARMCPU *cpu)
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
@@ -6242,6 +6251,60 @@ static const ARMCPRegInfo tcr2_reginfo[] = {
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
@@ -7479,6 +7542,13 @@ void register_cp_regs_for_features(ARMCPU *cpu)
         define_arm_cp_regs(cpu, tcr2_reginfo);
     }
 
+    if (cpu_isar_feature(aa64_s1pie, cpu)) {
+        define_arm_cp_regs(cpu, s1pie_reginfo);
+    }
+    if (cpu_isar_feature(aa64_s2pie, cpu)) {
+        define_arm_cp_regs(cpu, s2pie_reginfo);
+    }
+
     if (cpu_isar_feature(aa64_mec, cpu)) {
         define_arm_cp_regs(cpu, mec_reginfo);
         if (cpu_isar_feature(aa64_mte, cpu)) {
-- 
2.43.0


