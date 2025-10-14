Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2128ACCD18E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 20:10:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8lJr-0002Wr-NV; Tue, 14 Oct 2025 16:08:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v8lJh-0002Lw-V4
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 16:08:18 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v8lJ6-0005NC-56
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 16:08:17 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-b679450ecb6so3095668a12.2
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 13:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760472455; x=1761077255; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mh7tKPNYiN4cooHxCigQNoTwS4lt9qEJ7oaEecPqatQ=;
 b=t5O7DFep4QQnMh2lePh+PiyDaJGYmmWmC7hN3bE8bzjJypa4Rte3D10qAhHA0ih8Xx
 PSkVV+3IVKZj2z+Muhn+I9DBAbtSg4hC2QHBu4aW99DVMQioV8MrptaPoAh27spENdyK
 g/X5o5l7s+oN18yclW0pHsym5TdKVpDd2o2xNPGhB0Ibe340Yg/aWg4pUjliVtEGP8Me
 13MHgJtOAjOBUjwsHTazgA+CpfMeWo0rqew1iPLd6zlLCcMMWJDBlY+zAhth6ZsyF2Eb
 1xD+RPFyOOpc3TxrlKq0B+W2SmmHvo3kuNPuNpHSW2CEgkK6yqF5iUppmn7Ih9fAU5cH
 QSjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760472455; x=1761077255;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mh7tKPNYiN4cooHxCigQNoTwS4lt9qEJ7oaEecPqatQ=;
 b=AEc7/38ln+xlc468KMi9SuToHDg89PQbJISIwonU17wHOL7GaEsaKiDyWbdDLKVCBQ
 z56AYjR0YtoMmYOxZQt/ywMUgz0tKm03tux4kQlb5zD24sYbKqox7RBELOWvvTIuvVdo
 X8M6FnHZE65HmITRuLTvXYdRgd76uJkKITLuYJZFr3jxkUPidofOsrN8yJnPuPkK9xsQ
 6NX15n37jBA2Si9qoz4s8IcigPmP1K+YtwM2Rc2QdS5AcnsqkzX3ouSBPpRcRTZ8JKfg
 xLQ2/0lGBMkofuX+0emMHiXDXG4urwLp7gOyH4W9+ajjqBI4SYzIsbYmDC7o0WJD6Xya
 u/iA==
X-Gm-Message-State: AOJu0YxC1xMQIHIrugSt4wkZk4ZlEOHIvbljKK9XUXstr7Q/dBawWiJs
 iaYJP8AsuVjuoIGxALlfo1ptQuR/p+7m7f1/83dGYRvoEIV+bRNbbj+hiDMmPdmOg4wBT0ulWw9
 dN/K0lzw=
X-Gm-Gg: ASbGncuTjt83NfjgWgA/tFqqRoJyi4xUGfUSA2cjmJOwXo+5incuHN61d4NsNMwnPDz
 0gc+dFx+ASHi/0x+1q85y/rDEUS/q3q+wwDBegwG/L/IPHMKPGYAFk8SwMEoFMzk0XDHGPN6jkx
 rmoe0uSwjP8MFJS+LSmMIUe1Hu73Dey13HMGK1WK6LeFFnbkeZ4J7NF2aIP1qng2QJ1JXiZ5Mub
 lQmFPL8uh55eID7b/mxg2Hsy7jRWFYVDuN9XQi9OaFbb5RDkpjYmw0+EFvzOtkeN5zwuhXksQQ4
 dG9LolVUnegfRvRHzhFUyMC+PxTCkd0HCGOSP0Gurh8ZZ6GKp7tij9CGC1y7/PtzjJOoADwMaZL
 C2L6E0IqglQXKW1fDdLN4JaAye6Mf5vmW9zvx/iZzz03SazuxKd4=
X-Google-Smtp-Source: AGHT+IGDOrngbotiiIJW1I5eSvolOSsSx1IQiZmWn5hC1IOu90ppsRavA46sX6fBulYV3FtKqtv+fQ==
X-Received: by 2002:a17:903:4b2f:b0:267:a5df:9b07 with SMTP id
 d9443c01a7336-2902721332amr329100625ad.12.1760472454911; 
 Tue, 14 Oct 2025 13:07:34 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29034f93ea2sm172100975ad.126.2025.10.14.13.07.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 13:07:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 22/37] target/arm: Consolidate definitions of TTBR[01]
Date: Tue, 14 Oct 2025 13:07:03 -0700
Message-ID: <20251014200718.422022-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251014200718.422022-1-richard.henderson@linaro.org>
References: <20251014200718.422022-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
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

Create a function define_ttbr_register which handles the 3
distinct cases for TTBR[01] registers.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 165 +++++++++++++++++++++++++++++++-------------
 1 file changed, 116 insertions(+), 49 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index f9a2a7d62d..550ba77c5c 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3011,26 +3011,6 @@ static const ARMCPRegInfo vmsa_cp_reginfo[] = {
       .vhe_redir_to_el2 = ENCODE_AA64_CP_REG(3, 4, 5, 2, 0),
       .vhe_redir_to_el01 = ENCODE_AA64_CP_REG(3, 5, 5, 2, 0),
       .fieldoffset = offsetof(CPUARMState, cp15.esr_el[1]), .resetvalue = 0, },
-    { .name = "TTBR0_EL1", .state = ARM_CP_STATE_BOTH,
-      .opc0 = 3, .opc1 = 0, .crn = 2, .crm = 0, .opc2 = 0,
-      .access = PL1_RW, .accessfn = access_tvm_trvm,
-      .fgt = FGT_TTBR0_EL1,
-      .nv2_redirect_offset = 0x200 | NV2_REDIR_NV1,
-      .vhe_redir_to_el2 = ENCODE_AA64_CP_REG(3, 4, 2, 0, 0),
-      .vhe_redir_to_el01 = ENCODE_AA64_CP_REG(3, 5, 2, 0, 0),
-      .writefn = vmsa_ttbr_write, .resetvalue = 0, .raw_writefn = raw_write,
-      .bank_fieldoffsets = { offsetof(CPUARMState, cp15.ttbr0_s),
-                             offsetof(CPUARMState, cp15.ttbr0_ns) } },
-    { .name = "TTBR1_EL1", .state = ARM_CP_STATE_BOTH,
-      .opc0 = 3, .opc1 = 0, .crn = 2, .crm = 0, .opc2 = 1,
-      .access = PL1_RW, .accessfn = access_tvm_trvm,
-      .fgt = FGT_TTBR1_EL1,
-      .nv2_redirect_offset = 0x210 | NV2_REDIR_NV1,
-      .vhe_redir_to_el2 = ENCODE_AA64_CP_REG(3, 4, 2, 0, 1),
-      .vhe_redir_to_el01 = ENCODE_AA64_CP_REG(3, 5, 2, 0, 1),
-      .writefn = vmsa_ttbr_write, .resetvalue = 0, .raw_writefn = raw_write,
-      .bank_fieldoffsets = { offsetof(CPUARMState, cp15.ttbr1_s),
-                             offsetof(CPUARMState, cp15.ttbr1_ns) } },
     { .name = "TCR_EL1", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .crn = 2, .crm = 0, .opc1 = 0, .opc2 = 2,
       .access = PL1_RW, .accessfn = access_tvm_trvm,
@@ -3256,23 +3236,6 @@ static const ARMCPRegInfo lpae_cp_reginfo[] = {
     { .name = "AMAIR1", .cp = 15, .crn = 10, .crm = 3, .opc1 = 0, .opc2 = 1,
       .access = PL1_RW, .accessfn = access_tvm_trvm,
       .type = ARM_CP_CONST, .resetvalue = 0 },
-
-    /*
-     * The primary definitions of TTBR[01]_EL1 are in vmsa_cp_reginfo[].
-     * Here we need only provide the 64-bit views for AArch32.
-     */
-    { .name = "TTBR0", .cp = 15, .crm = 2, .opc1 = 0,
-      .access = PL1_RW, .accessfn = access_tvm_trvm,
-      .type = ARM_CP_64BIT | ARM_CP_ALIAS,
-      .bank_fieldoffsets = { offsetof(CPUARMState, cp15.ttbr0_s),
-                             offsetof(CPUARMState, cp15.ttbr0_ns) },
-      .writefn = vmsa_ttbr_write, .raw_writefn = raw_write },
-    { .name = "TTBR1", .cp = 15, .crm = 2, .opc1 = 1,
-      .access = PL1_RW, .accessfn = access_tvm_trvm,
-      .type = ARM_CP_64BIT | ARM_CP_ALIAS,
-      .bank_fieldoffsets = { offsetof(CPUARMState, cp15.ttbr1_s),
-                             offsetof(CPUARMState, cp15.ttbr1_ns) },
-      .writefn = vmsa_ttbr_write, .raw_writefn = raw_write },
 };
 
 static void define_par_register(ARMCPU *cpu)
@@ -3342,6 +3305,121 @@ static void define_par_register(ARMCPU *cpu)
     define_arm_cp_regs(cpu, par64_reginfo);
 }
 
+static void define_ttbr_registers(ARMCPU *cpu)
+{
+    /*
+     * For v8:
+     * The aarch64 regs are primary, since they might be 128-bit.
+     * The aarch32 64-bit non-secure regs are secondary to aa64 el1.
+     * The aarch32 64-bit httbr is secondary to aa64 el2.
+     * The aarch32 64-bit secure ttbr0 is secondary to aa64 el3.
+     * The aarch32 64-bit secure ttbr1 is primary.
+     *
+     * For v7:
+     * The aarch32 64-bit s+ns regs are primary.
+     *
+     * The aarch32 32-bit regs are secondary to one of the above,
+     * and we also don't expose them to gdb.
+     */
+    static const ARMCPRegInfo ttbrv8_reginfo[] = {
+        { .name = "TTBR0_EL1", .state = ARM_CP_STATE_AA64,
+          .opc0 = 3, .opc1 = 0, .crn = 2, .crm = 0, .opc2 = 0,
+          .access = PL1_RW, .accessfn = access_tvm_trvm,
+          .fgt = FGT_TTBR0_EL1,
+          .nv2_redirect_offset = 0x200 | NV2_REDIR_NV1,
+          .vhe_redir_to_el2 = ENCODE_AA64_CP_REG(3, 4, 2, 0, 0),
+          .vhe_redir_to_el01 = ENCODE_AA64_CP_REG(3, 5, 2, 0, 0),
+          .writefn = vmsa_ttbr_write, .raw_writefn = raw_write,
+          .fieldoffset = offsetof(CPUARMState, cp15.ttbr0_el[1]) },
+        { .name = "TTBR1_EL1", .state = ARM_CP_STATE_AA64,
+          .opc0 = 3, .opc1 = 0, .crn = 2, .crm = 0, .opc2 = 1,
+          .access = PL1_RW, .accessfn = access_tvm_trvm,
+          .fgt = FGT_TTBR1_EL1,
+          .nv2_redirect_offset = 0x210 | NV2_REDIR_NV1,
+          .vhe_redir_to_el2 = ENCODE_AA64_CP_REG(3, 4, 2, 0, 1),
+          .vhe_redir_to_el01 = ENCODE_AA64_CP_REG(3, 5, 2, 0, 1),
+          .writefn = vmsa_ttbr_write, .raw_writefn = raw_write,
+          .fieldoffset = offsetof(CPUARMState, cp15.ttbr1_el[1]) },
+        { .name = "TTBR0_EL2", .state = ARM_CP_STATE_AA64,
+          .opc0 = 3, .opc1 = 4, .crn = 2, .crm = 0, .opc2 = 0,
+          .access = PL2_RW, .resetvalue = 0,
+          .writefn = vmsa_tcr_ttbr_el2_write, .raw_writefn = raw_write,
+          .fieldoffset = offsetof(CPUARMState, cp15.ttbr0_el[2]) },
+        { .name = "TTBR0_EL3", .state = ARM_CP_STATE_AA64,
+          .opc0 = 3, .opc1 = 6, .crn = 2, .crm = 0, .opc2 = 0,
+          .access = PL3_RW, .resetvalue = 0,
+          .fieldoffset = offsetof(CPUARMState, cp15.ttbr0_el[3]) },
+    };
+
+    static ARMCPRegInfo ttbr64_reginfo[] = {
+        [0 ... 3] = {
+            .cp = 15, .crm = 2, .type = ARM_CP_64BIT,
+            .access = PL1_RW, .accessfn = access_tvm_trvm,
+            .writefn = vmsa_ttbr_write, .raw_writefn = raw_write
+        },
+        [0 ... 1].opc1 = 0,
+        [0].name = "TTBR0",
+        [0].secure = ARM_CP_SECSTATE_NS,
+        [0].fieldoffset = offsetof(CPUARMState, cp15.ttbr0_ns),
+        [1].name = "TTBR0_S",
+        [1].secure = ARM_CP_SECSTATE_S,
+        [1].fieldoffset = offsetof(CPUARMState, cp15.ttbr0_s),
+
+        [2 ... 3].opc1 = 1,
+        [2].name = "TTBR1",
+        [2].secure = ARM_CP_SECSTATE_NS,
+        [2].fieldoffset = offsetof(CPUARMState, cp15.ttbr1_ns),
+        [3].name = "TTBR1_S",
+        [3].secure = ARM_CP_SECSTATE_S,
+        [3].fieldoffset = offsetof(CPUARMState, cp15.ttbr1_s),
+
+        [4] = {
+            .name = "HTTBR", .cp = 15, .crm = 2, .opc1 = 4,
+            .access = PL2_RW, .type = ARM_CP_64BIT,
+            .fieldoffset = offsetof(CPUARMState, cp15.ttbr0_el[2])
+        },
+    };
+
+    static ARMCPRegInfo ttbr32_reginfo[] = {
+        { .name = "TTBR0", .cp = 15, .opc1 = 0, .crn = 2, .crm = 0, .opc2 = 0,
+          .access = PL1_RW, .accessfn = access_tvm_trvm,
+          .writefn = vmsa_ttbr_write, .raw_writefn = raw_write,
+          .bank_fieldoffsets = { offsetof(CPUARMState, cp15.ttbr0_s),
+                                 offsetof(CPUARMState, cp15.ttbr0_ns) } },
+        { .name = "TTBR1", .cp = 15, .opc1 = 0, .crn = 2, .crm = 0, .opc2 = 1,
+          .access = PL1_RW, .accessfn = access_tvm_trvm,
+          .writefn = vmsa_ttbr_write, .raw_writefn = raw_write,
+          .bank_fieldoffsets = { offsetof(CPUARMState, cp15.ttbr1_s),
+                                 offsetof(CPUARMState, cp15.ttbr1_ns) } },
+    };
+
+    CPUARMState *env = &cpu->env;
+
+    /* With only VMSA, define a 32-bit reg that filters bits from write. */
+    if (!arm_feature(env, ARM_FEATURE_LPAE)) {
+        define_arm_cp_regs(cpu, ttbr32_reginfo);
+        return;
+    }
+
+    /* With LPAE, the 32-bit regs are aliases of 64-bit regs. */
+    for (int i = 0; i < ARRAY_SIZE(ttbr32_reginfo); ++i) {
+        ttbr32_reginfo[i].type = ARM_CP_ALIAS | ARM_CP_NO_GDB;
+    }
+    define_arm_cp_regs(cpu, ttbr32_reginfo);
+
+    if (arm_feature(env, ARM_FEATURE_V8)) {
+        define_arm_cp_regs(cpu, ttbrv8_reginfo);
+
+        ttbr64_reginfo[0].type |= ARM_CP_ALIAS;
+        ttbr64_reginfo[1].type |= ARM_CP_ALIAS;
+        ttbr64_reginfo[2].type |= ARM_CP_ALIAS;
+        /* Index 3, TTBR1_S, is not an alias. */
+        ttbr64_reginfo[4].type |= ARM_CP_ALIAS;
+    }
+
+    define_arm_cp_regs(cpu, ttbr64_reginfo);
+}
+
 static uint64_t aa64_fpcr_read(CPUARMState *env, const ARMCPRegInfo *ri)
 {
     return vfp_get_fpcr(env);
@@ -4468,14 +4546,6 @@ static const ARMCPRegInfo el2_cp_reginfo[] = {
       .access = PL2_RW, .resetvalue = 0,
       .nv2_redirect_offset = 0x90,
       .fieldoffset = offsetof(CPUARMState, cp15.tpidr_el[2]) },
-    { .name = "TTBR0_EL2", .state = ARM_CP_STATE_AA64,
-      .opc0 = 3, .opc1 = 4, .crn = 2, .crm = 0, .opc2 = 0,
-      .access = PL2_RW, .resetvalue = 0,
-      .writefn = vmsa_tcr_ttbr_el2_write, .raw_writefn = raw_write,
-      .fieldoffset = offsetof(CPUARMState, cp15.ttbr0_el[2]) },
-    { .name = "HTTBR", .cp = 15, .opc1 = 4, .crm = 2,
-      .access = PL2_RW, .type = ARM_CP_64BIT | ARM_CP_ALIAS,
-      .fieldoffset = offsetof(CPUARMState, cp15.ttbr0_el[2]) },
 #ifndef CONFIG_USER_ONLY
     { .name = "CNTHCTL_EL2", .state = ARM_CP_STATE_BOTH,
       .opc0 = 3, .opc1 = 4, .crn = 14, .crm = 1, .opc2 = 0,
@@ -4660,10 +4730,6 @@ static const ARMCPRegInfo el3_cp_reginfo[] = {
       .access = PL1_RW, .accessfn = access_trap_aa32s_el1,
       .writefn = vbar_write, .resetvalue = 0,
       .fieldoffset = offsetof(CPUARMState, cp15.mvbar) },
-    { .name = "TTBR0_EL3", .state = ARM_CP_STATE_AA64,
-      .opc0 = 3, .opc1 = 6, .crn = 2, .crm = 0, .opc2 = 0,
-      .access = PL3_RW, .resetvalue = 0,
-      .fieldoffset = offsetof(CPUARMState, cp15.ttbr0_el[3]) },
     { .name = "TCR_EL3", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 6, .crn = 2, .crm = 0, .opc2 = 2,
       .access = PL3_RW,
@@ -7174,6 +7240,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
     } else {
         define_arm_cp_regs(cpu, vmsa_pmsa_cp_reginfo);
         define_arm_cp_regs(cpu, vmsa_cp_reginfo);
+        define_ttbr_registers(cpu);
         /* TTCBR2 is introduced with ARMv8.2-AA32HPD.  */
         if (cpu_isar_feature(aa32_hpd, cpu)) {
             define_one_arm_cp_reg(cpu, &ttbcr2_reginfo);
-- 
2.43.0


