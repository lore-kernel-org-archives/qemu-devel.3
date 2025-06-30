Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44121C7EE2A
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 04:34:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uW6Cn-0004YV-Dq; Mon, 30 Jun 2025 00:33:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uW6Cg-0004W0-Tm
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 00:33:14 -0400
Received: from mail-qt1-x82c.google.com ([2607:f8b0:4864:20::82c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uW6Cc-00055E-DK
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 00:33:12 -0400
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-4a58e0b26c4so31942591cf.3
 for <qemu-devel@nongnu.org>; Sun, 29 Jun 2025 21:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751257986; x=1751862786; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ac/L14+pskdVO/8psuhLq/nvDUBkV5afYQiukb3LTRs=;
 b=FfiD34Gw6lw4uNyWO5QnOkPBN6q2IpoYbBUmqNAUKQbhHEFQXPyBAagqlWRKbCsLc3
 kC3YXjcFw40BXdwF2BA7soe0Ni9j51F1JKj5aFECC++AqVQAooWDq7ueINhUwWozBgLt
 +xSfxexHNoEf0O6uzv/9veOrsxpJSVI/aTusbJxIyqTxkou8G/kwWThXLIIkdSsu8jFG
 g7O/3iabINnkCf5IbYQJ8bhgXt+Tnx3dSDWeOK/lhQfMdMMPKPVTx6DZDtTyi9cU2oGc
 RUcMsM+3+ko5keF0QkLud/k5NlYYqBrH/A9QeHvJ5Up2pEVljJq1muZNybQN5g7WLv9U
 g/bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751257986; x=1751862786;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ac/L14+pskdVO/8psuhLq/nvDUBkV5afYQiukb3LTRs=;
 b=VzHHImfgs4yrwNLT9Qp9Vz7fW/tn2RxkyupfKt1xpQw8xi6HEtXBeVhHSXLY1aRaCG
 nYs+zh8zk8s4+2bljMTV82YviUt/rdEnuwtVGpn7S49MEdnvnBE6cCcwNYThkoxKv7Xf
 CAdgxrsQ410/j3dJK58L9qQFI9BO2pc4DB6qeYlc/TwiWKzATgSRKOuWNCDbhHWrehDd
 BJ0Rk0kTGnqm98nwcRNU0927dT+G50X76AeLS+U7VwNZfNEDWDtFUME8KtCw32sCQgmg
 k1BqRhaQ+AcfuwFazKytIvsrCe6r/biLqPfJyApiD6L6/iN3uNPeH/3hK4KmxsYa18Vo
 VvoA==
X-Gm-Message-State: AOJu0Yw8IeTONPQ42ZGUEreopAb7ysPkdLAt3Qrbz1yBJg/o+6/Fr+on
 FuLhaHW/Rv9UkFov018i+qDIYTE1CsR8bQOnVPyBrR9CIE5MbK89As6uRf3zJGv5W9k=
X-Gm-Gg: ASbGncsZZGIcKB5Ebm6IfmZ/M9sQo+UMvx9khgyS29ItYvjEiMAgXMROB3mwil2bbwk
 SQGVlk27kSNwPk03+eWAJadzrPE8ZT8ElLsD720WRqbIg+5HXiVk66PHUVzWmT2b3+spqoXlBKW
 cSA7qYtONeRJHha3/nTPZpUVyA96LurWm4hYDp/yRpTQvzIkN4IXSV4MHWUJKmroF0+Tp5g02ok
 LnDiEC0hX9Nui3y3pL1YzP+o2iAMXTkhamPssuC0C4IZjQoXAbygAjk5ERxisPZSHyJNjsUKQ8O
 oBNmVhjJw4lUgY6Da75O3XkdfPzpi9oZQHdg26QvAIbiiBqmsRwmLK27PDo+Wa8UadM=
X-Google-Smtp-Source: AGHT+IG0+6eUU7nIhJ/CuImTG1xLG3cPeCWy7xmdAbw1mWBudBCO1TE469WoXtur1MoIfdNnEd9hyA==
X-Received: by 2002:a05:622a:2c43:b0:4a7:234e:6c00 with SMTP id
 d75a77b69052e-4a7fd683b3dmr139092151cf.2.1751257985650; 
 Sun, 29 Jun 2025 21:33:05 -0700 (PDT)
Received: from gromero0.. ([186.215.58.88]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a7fc13971fsm53470171cf.20.2025.06.29.21.33.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Jun 2025 21:33:04 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org, gustavo.romero@linaro.org
Subject: [PATCH 3/3] target/arm: Add FEAT_MEC registers
Date: Mon, 30 Jun 2025 04:32:37 +0000
Message-Id: <20250630043237.996788-4-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250630043237.996788-1-gustavo.romero@linaro.org>
References: <20250630043237.996788-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::82c;
 envelope-from=gustavo.romero@linaro.org; helo=mail-qt1-x82c.google.com
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

Add FEAT_MEC registers to the arm max cpu.

To work properly, FEAT_MEC also depends on FEAT_SCTLR2 and FEAT_TCR2, which are
not implemented in this commit. The bits in SCTLR2 and TCR2 control which
translation regimes use MECIDs, and determine which MECID is selected.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 target/arm/cpu.h    | 14 +++++++
 target/arm/helper.c | 98 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 112 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 8ce30ca857..9509217486 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -565,6 +565,16 @@ typedef struct CPUArchState {
 
         /* NV2 register */
         uint64_t vncr_el2;
+
+        /* MEC registers */
+        uint64_t mecidr_el2;
+        uint64_t mecid_p0_el2;
+        uint64_t mecid_a0_el2;
+        uint64_t mecid_p1_el2;
+        uint64_t mecid_a1_el2;
+        uint64_t mecid_rl_a_el3;
+        uint64_t vmecid_p_el2;
+        uint64_t vmecid_a_el2;
     } cp15;
 
     struct {
@@ -2389,6 +2399,10 @@ FIELD(MFAR, FPA, 12, 40)
 FIELD(MFAR, NSE, 62, 1)
 FIELD(MFAR, NS, 63, 1)
 
+FIELD(MECIDR, MECIDW, 0, 4)
+FIELD(MECID, MECID, 0, 16)
+FIELD(VMECID, MECID, 0, 16)
+
 QEMU_BUILD_BUG_ON(ARRAY_SIZE(((ARMCPU *)0)->ccsidr) <= R_V7M_CSSELR_INDEX_MASK);
 
 /* If adding a feature bit which corresponds to a Linux ELF
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 889d308807..9f8a284261 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6823,6 +6823,100 @@ static const ARMCPRegInfo nmi_reginfo[] = {
       .resetfn = arm_cp_reset_ignore },
 };
 
+static void mecidr_reset(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    /* MECIDWidthm1 = 15, i.e. 16 bits is the width of a MECID. */
+    env->cp15.mecidr_el2 = FIELD_DP64(0, MECIDR, MECIDW, 15);
+}
+
+static uint64_t mecidr_read(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    uint64_t valid_mask;
+
+    if (!arm_is_el2_enabled(env)) {
+        /* All bits are RES0. */
+        return 0ULL;
+    }
+
+    valid_mask = R_MECIDR_MECIDW_MASK;
+    return env->cp15.mecidr_el2 & valid_mask;
+}
+
+static CPAccessResult mecid_access(CPUARMState *env,
+                                   const ARMCPRegInfo *ri, bool isread)
+{
+    int el;
+
+    el = arm_current_el(env);
+    if (el == 2 && !(env->cp15.scr_el3 & SCR_MECEN)) {
+        return CP_ACCESS_TRAP_EL3;
+    }
+
+    return CP_ACCESS_OK;
+}
+
+static void mecid_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                        uint64_t value)
+{
+    uint64_t valid_mask;
+
+    valid_mask = R_MECID_MECID_MASK;
+    value &= valid_mask;
+    raw_write(env, ri, value);
+}
+
+static uint64_t mecid_read(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    uint64_t valid_mask;
+
+    valid_mask = R_MECID_MECID_MASK;
+    return raw_read(env, ri) & valid_mask;
+}
+
+static const ARMCPRegInfo mec_reginfo[] = {
+    { .name = "MECIDR_EL2", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 4, .opc2 = 7, .crn = 10, .crm = 8,
+      .resetfn = mecidr_reset,
+      .access = PL2_RW, .accessfn = mecid_access, .readfn = mecidr_read,
+      .writefn = arm_cp_write_ignore,
+      .fieldoffset = offsetof(CPUARMState, cp15.mecidr_el2) },
+    { .name = "MECID_P0_EL2", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 4, .opc2 = 0, .crn = 10, .crm = 8,
+      .access = PL2_RW, .accessfn = mecid_access,
+      .readfn = mecid_read, .writefn = mecid_write,
+      .fieldoffset = offsetof(CPUARMState, cp15.mecid_p0_el2) },
+    { .name = "MECID_A0_EL2", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 4, .opc2 = 1, .crn = 10, .crm = 8,
+      .access = PL2_RW, .accessfn = mecid_access,
+      .readfn = mecid_read, .writefn = mecid_write,
+      .fieldoffset = offsetof(CPUARMState, cp15.mecid_a0_el2) },
+    { .name = "MECID_P1_EL2", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 4, .opc2 = 2, .crn = 10, .crm = 8,
+      .access = PL2_RW, .accessfn = mecid_access,
+      .readfn = mecid_read, .writefn = mecid_write,
+      .fieldoffset = offsetof(CPUARMState, cp15.mecid_p1_el2) },
+    { .name = "MECID_A1_EL2", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 4, .opc2 = 3, .crn = 10, .crm = 8,
+      .access = PL2_RW, .accessfn = mecid_access,
+      .readfn = mecid_read, .writefn = mecid_write,
+      .fieldoffset = offsetof(CPUARMState, cp15.mecid_a1_el2) },
+    { .name = "MECID_RL_A_EL3", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 6, .opc2 = 1, .crn = 10, .crm = 10,
+      .access = PL2_RW, .accessfn = mecid_access,
+      .readfn = mecid_read, .writefn = mecid_write,
+      .fieldoffset = offsetof(CPUARMState, cp15.mecid_rl_a_el3) },
+    { .name = "VMECID_P_EL2", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 4, .opc2 = 0, .crn = 10, .crm = 9,
+      .access = PL2_RW, .accessfn = mecid_access,
+      .readfn = mecid_read, .writefn = mecid_write,
+      .fieldoffset = offsetof(CPUARMState, cp15.vmecid_p_el2) },
+    { .name = "VMECID_A_EL2", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 4, .opc2 = 1, .crn = 10, .crm = 9,
+      .access = PL2_RW, .accessfn = mecid_access,
+      .readfn = mecid_read, .writefn = mecid_write,
+      .fieldoffset = offsetof(CPUARMState, cp15.vmecid_a_el2) },
+};
+
 static void define_pmu_regs(ARMCPU *cpu)
 {
     /*
@@ -9008,6 +9102,10 @@ void register_cp_regs_for_features(ARMCPU *cpu)
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


