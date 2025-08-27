Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A618CA0FF0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 01:14:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ur4h4-0008Ab-H2; Tue, 26 Aug 2025 21:11:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ur4gy-00083q-Mj
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 21:11:12 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ur4gq-0008Rg-67
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 21:11:12 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-76e39ec6f30so6055456b3a.2
 for <qemu-devel@nongnu.org>; Tue, 26 Aug 2025 18:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756257060; x=1756861860; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iynj+Uav7fMWQjykeRPxAArVg2FAhKp3cqYsYXzAABg=;
 b=zf1etsIe/r/fOeqZsAEVNiL6tXFOK//ZMIrA/XCVxRsPCwlRHaob/kFG4KCDVREMsZ
 47Jocpytor8TOhoZzhqM/r3NNQMGIkiAPGtxGnny43gi+6oxfthbSQJUcSssc3/npVCs
 FfU4BL1N5VXczJPC+qxQoGs4WVCcX6Yp6eKuNvochntxFK8ZoWv6wISsEV3i+LBzy48E
 rbxtpVFR7XnG7itInQA+IQF+kzdJpnNz6PlMU7kYYe7tcY9DG4/nHjgVc92AwFM1ZN9z
 Xi4noXEPdMSEWgqRrKtcNOOpwFwWxZWFL9UUi4Q5ySoNS9ZvQUOi6xP9QdteSga8ADgw
 S+Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756257060; x=1756861860;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iynj+Uav7fMWQjykeRPxAArVg2FAhKp3cqYsYXzAABg=;
 b=vWyRv4Bz6kgUvRq0q8Vvcv9JKJGtanhDfuZBMzol17AZWzRnhVTpqWhHQUbJ4DdhgU
 Vlzn4C1ZLCZHG4+BUcD53QnwFthdGE3IfE5suU1YaaVNHJXw6IZdvG7O1xNS1VpLH9TS
 udrNmE9q7AAg+p8dliEbRZK3ESerpp2sNeOxqFk8LIsz/xdN0ueR1WBtW3j5kH/EJk12
 Vz2NxFbEe6KeBZmKGB8FgSsFXxPkdI0r0XPYrL8tThfLJW0UOB0TqEAkKRkJERLJjShV
 +qA/60K8gggOGEq9cWU+z2mBTsXbAZ9/IulK3ciPaPGpQ0QTlAqAV198ecye1YesJGmE
 Aafw==
X-Gm-Message-State: AOJu0YwTxb40ekdmZ9tIC3mTyUZZOlLjzXjNE7N8s69Le6vmCceY/Ipi
 W6+jRTtDqOOfmPG4HL4vufZmLe4Jrdk00LDFDon25PYuY+JIyhZye08Ovxrupi0yhX95F5u9D2t
 udZ4/f+k=
X-Gm-Gg: ASbGncv/qwIJZvIFjpgwtps4E1S82bMU917XSyKLqj4yn3TQnkbknykzWe0QT6bFVeW
 AHXygixzI7ak5OWff137BH7dAe7bLhys0kubzOe1d5UQus/XGwbIrpqspps+T04DgBlDLcQZIZ3
 kp9jDyICU7/w7j8kZynhhbYQadWXfe9LPRAiqt0UxtCE7jFQ9S/yN9ro036xlOsFw0XYJv6wjea
 pLp6ww3YP9Up7ll5X6yUDKl6fkx7S7LuCjj4I0npfRWo+qOet6MBBjvjlKR0ZHOoMMmHThSkQnv
 CY0boxCW6uljgBr6b/abFecvZEV0ZH0O6FXOcreLKfNMg/YdKPwQoOwl0r8qmf91ER10rOvSktv
 /kclFMWgzWK5JJubuxrcWrkbFo6v1g/cHOS6ohSR1RXYKFpQ=
X-Google-Smtp-Source: AGHT+IEket35jXYecjKbZT6SOfXkMK9otGNEk1hIMZE2kxadVXB/G3/wU+dMGThAZ/hxFoq+6YU9lA==
X-Received: by 2002:a05:6a00:1896:b0:771:e7e0:5fa1 with SMTP id
 d2e1a72fcca58-771e7e065demr8649967b3a.26.1756257060272; 
 Tue, 26 Aug 2025 18:11:00 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-771f2b2d2bfsm4348408b3a.93.2025.08.26.18.10.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 18:10:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 36/61] target/arm: Remove define_arm_vh_e2h_redirects_aliases
Date: Wed, 27 Aug 2025 11:04:27 +1000
Message-ID: <20250827010453.4059782-41-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250827010453.4059782-1-richard.henderson@linaro.org>
References: <20250827010453.4059782-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Populate vhe_redir_to_{el2,el01} on each ARMCPRegInfo.
Clear the fields within add_cpreg_to_hashtable_aa32.
Create the FOO_EL12 cpreg within add_cpreg_to_hashtable_aa64;
add ARM_CP_NO_RAW.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpregs.h |   6 +-
 target/arm/helper.c | 241 ++++++++++++++++++--------------------------
 2 files changed, 103 insertions(+), 144 deletions(-)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index f5d6a1c386..9818be4429 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -918,8 +918,10 @@ struct ARMCPRegInfo {
     uint32_t vhe_redir_to_el2;
 
     /*
-     * With VHE, with E2H, at EL2+, access to this EL02/EL12 reg
-     * redirects to the EL0/EL1 reg with the specified key.
+     * For VHE.  Before registration, this field holds the key for an
+     * EL02/EL12 reg to be created to point back to this EL0/EL1 reg.
+     * After registration, this field is set only on the EL02/EL12 reg
+     * and points back to the EL02/EL12 reg for redirection with E2H.
      */
     uint32_t vhe_redir_to_el01;
 
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 255ca6fdcb..64a987d143 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -454,6 +454,8 @@ static const ARMCPRegInfo cp_reginfo[] = {
       .access = PL1_RW, .accessfn = access_tvm_trvm,
       .fgt = FGT_CONTEXTIDR_EL1,
       .nv2_redirect_offset = 0x108 | NV2_REDIR_NV1,
+      .vhe_redir_to_el2 = ENCODE_AA64_CP_REG(3, 4, 13, 0, 1),
+      .vhe_redir_to_el01 = ENCODE_AA64_CP_REG(3, 5, 13, 0, 1),
       .secure = ARM_CP_SECSTATE_NS,
       .fieldoffset = offsetof(CPUARMState, cp15.contextidr_el[1]),
       .resetvalue = 0, .writefn = contextidr_write, .raw_writefn = raw_write, },
@@ -674,6 +676,8 @@ static const ARMCPRegInfo v6_cp_reginfo[] = {
     { .name = "CPACR_EL1", .state = ARM_CP_STATE_BOTH, .opc0 = 3,
       .crn = 1, .crm = 0, .opc1 = 0, .opc2 = 2, .accessfn = cpacr_access,
       .fgt = FGT_CPACR_EL1,
+      .vhe_redir_to_el2 = ENCODE_AA64_CP_REG(3, 4, 1, 1, 2),
+      .vhe_redir_to_el01 = ENCODE_AA64_CP_REG(3, 5, 1, 0, 2),
       .nv2_redirect_offset = 0x100 | NV2_REDIR_NV1,
       .access = PL1_RW, .fieldoffset = offsetof(CPUARMState, cp15.cpacr_el1),
       .resetfn = cpacr_reset, .writefn = cpacr_write, .readfn = cpacr_read },
@@ -950,12 +954,16 @@ static const ARMCPRegInfo v7_cp_reginfo[] = {
       .access = PL1_RW, .accessfn = access_tvm_trvm,
       .fgt = FGT_AFSR0_EL1,
       .nv2_redirect_offset = 0x128 | NV2_REDIR_NV1,
+      .vhe_redir_to_el2 = ENCODE_AA64_CP_REG(3, 4, 5, 1, 0),
+      .vhe_redir_to_el01 = ENCODE_AA64_CP_REG(3, 5, 5, 1, 0),
       .type = ARM_CP_CONST, .resetvalue = 0 },
     { .name = "AFSR1_EL1", .state = ARM_CP_STATE_BOTH,
       .opc0 = 3, .opc1 = 0, .crn = 5, .crm = 1, .opc2 = 1,
       .access = PL1_RW, .accessfn = access_tvm_trvm,
       .fgt = FGT_AFSR1_EL1,
       .nv2_redirect_offset = 0x130 | NV2_REDIR_NV1,
+      .vhe_redir_to_el2 = ENCODE_AA64_CP_REG(3, 4, 5, 1, 1),
+      .vhe_redir_to_el01 = ENCODE_AA64_CP_REG(3, 5, 5, 1, 1),
       .type = ARM_CP_CONST, .resetvalue = 0 },
     /*
      * MAIR can just read-as-written because we don't implement caches
@@ -966,6 +974,8 @@ static const ARMCPRegInfo v7_cp_reginfo[] = {
       .access = PL1_RW, .accessfn = access_tvm_trvm,
       .fgt = FGT_MAIR_EL1,
       .nv2_redirect_offset = 0x140 | NV2_REDIR_NV1,
+      .vhe_redir_to_el2 = ENCODE_AA64_CP_REG(3, 4, 10, 2, 0),
+      .vhe_redir_to_el01 = ENCODE_AA64_CP_REG(3, 5, 10, 2, 0),
       .fieldoffset = offsetof(CPUARMState, cp15.mair_el[1]),
       .resetvalue = 0 },
     { .name = "MAIR_EL3", .state = ARM_CP_STATE_AA64,
@@ -2015,6 +2025,8 @@ static const ARMCPRegInfo generic_timer_cp_reginfo[] = {
     { .name = "CNTKCTL_EL1", .state = ARM_CP_STATE_BOTH,
       .opc0 = 3, .opc1 = 0, .crn = 14, .crm = 1, .opc2 = 0,
       .access = PL1_RW,
+      .vhe_redir_to_el2 = ENCODE_AA64_CP_REG(3, 4, 14, 1, 0),
+      .vhe_redir_to_el01 = ENCODE_AA64_CP_REG(3, 5, 14, 1, 0),
       .fieldoffset = offsetof(CPUARMState, cp15.c14_cntkctl),
       .resetvalue = 0,
     },
@@ -2805,6 +2817,8 @@ static const ARMCPRegInfo vmsa_pmsa_cp_reginfo[] = {
       .access = PL1_RW, .accessfn = access_tvm_trvm,
       .fgt = FGT_FAR_EL1,
       .nv2_redirect_offset = 0x220 | NV2_REDIR_NV1,
+      .vhe_redir_to_el2 = ENCODE_AA64_CP_REG(3, 4, 6, 0, 0),
+      .vhe_redir_to_el01 = ENCODE_AA64_CP_REG(3, 5, 6, 0, 0),
       .fieldoffset = offsetof(CPUARMState, cp15.far_el[1]),
       .resetvalue = 0, },
 };
@@ -2815,12 +2829,16 @@ static const ARMCPRegInfo vmsa_cp_reginfo[] = {
       .access = PL1_RW, .accessfn = access_tvm_trvm,
       .fgt = FGT_ESR_EL1,
       .nv2_redirect_offset = 0x138 | NV2_REDIR_NV1,
+      .vhe_redir_to_el2 = ENCODE_AA64_CP_REG(3, 4, 5, 2, 0),
+      .vhe_redir_to_el01 = ENCODE_AA64_CP_REG(3, 5, 5, 2, 0),
       .fieldoffset = offsetof(CPUARMState, cp15.esr_el[1]), .resetvalue = 0, },
     { .name = "TTBR0_EL1", .state = ARM_CP_STATE_BOTH,
       .opc0 = 3, .opc1 = 0, .crn = 2, .crm = 0, .opc2 = 0,
       .access = PL1_RW, .accessfn = access_tvm_trvm,
       .fgt = FGT_TTBR0_EL1,
       .nv2_redirect_offset = 0x200 | NV2_REDIR_NV1,
+      .vhe_redir_to_el2 = ENCODE_AA64_CP_REG(3, 4, 2, 0, 0),
+      .vhe_redir_to_el01 = ENCODE_AA64_CP_REG(3, 5, 2, 0, 0),
       .writefn = vmsa_ttbr_write, .resetvalue = 0, .raw_writefn = raw_write,
       .bank_fieldoffsets = { offsetof(CPUARMState, cp15.ttbr0_s),
                              offsetof(CPUARMState, cp15.ttbr0_ns) } },
@@ -2829,6 +2847,8 @@ static const ARMCPRegInfo vmsa_cp_reginfo[] = {
       .access = PL1_RW, .accessfn = access_tvm_trvm,
       .fgt = FGT_TTBR1_EL1,
       .nv2_redirect_offset = 0x210 | NV2_REDIR_NV1,
+      .vhe_redir_to_el2 = ENCODE_AA64_CP_REG(3, 4, 2, 0, 1),
+      .vhe_redir_to_el01 = ENCODE_AA64_CP_REG(3, 5, 2, 0, 1),
       .writefn = vmsa_ttbr_write, .resetvalue = 0, .raw_writefn = raw_write,
       .bank_fieldoffsets = { offsetof(CPUARMState, cp15.ttbr1_s),
                              offsetof(CPUARMState, cp15.ttbr1_ns) } },
@@ -2837,6 +2857,8 @@ static const ARMCPRegInfo vmsa_cp_reginfo[] = {
       .access = PL1_RW, .accessfn = access_tvm_trvm,
       .fgt = FGT_TCR_EL1,
       .nv2_redirect_offset = 0x120 | NV2_REDIR_NV1,
+      .vhe_redir_to_el2 = ENCODE_AA64_CP_REG(3, 4, 2, 0, 2),
+      .vhe_redir_to_el01 = ENCODE_AA64_CP_REG(3, 5, 2, 0, 2),
       .writefn = vmsa_tcr_el12_write,
       .raw_writefn = raw_write,
       .resetvalue = 0,
@@ -3077,6 +3099,8 @@ static const ARMCPRegInfo lpae_cp_reginfo[] = {
       .access = PL1_RW, .accessfn = access_tvm_trvm,
       .fgt = FGT_AMAIR_EL1,
       .nv2_redirect_offset = 0x148 | NV2_REDIR_NV1,
+      .vhe_redir_to_el2 = ENCODE_AA64_CP_REG(3, 4, 10, 3, 0),
+      .vhe_redir_to_el01 = ENCODE_AA64_CP_REG(3, 5, 10, 3, 0),
       .type = ARM_CP_CONST, .resetvalue = 0 },
     /* AMAIR1 is mapped to AMAIR_EL1[63:32] */
     { .name = "AMAIR1", .cp = 15, .crn = 10, .crm = 3, .opc1 = 0, .opc2 = 1,
@@ -3602,12 +3626,16 @@ static const ARMCPRegInfo v8_cp_reginfo[] = {
       .opc0 = 3, .opc1 = 0, .crn = 4, .crm = 0, .opc2 = 1,
       .access = PL1_RW, .accessfn = access_nv1,
       .nv2_redirect_offset = 0x230 | NV2_REDIR_NV1,
+      .vhe_redir_to_el2 = ENCODE_AA64_CP_REG(3, 4, 4, 0, 1),
+      .vhe_redir_to_el01 = ENCODE_AA64_CP_REG(3, 5, 4, 0, 1),
       .fieldoffset = offsetof(CPUARMState, elr_el[1]) },
     { .name = "SPSR_EL1", .state = ARM_CP_STATE_AA64,
       .type = ARM_CP_ALIAS,
       .opc0 = 3, .opc1 = 0, .crn = 4, .crm = 0, .opc2 = 0,
       .access = PL1_RW, .accessfn = access_nv1,
       .nv2_redirect_offset = 0x160 | NV2_REDIR_NV1,
+      .vhe_redir_to_el2 = ENCODE_AA64_CP_REG(3, 4, 4, 0, 0),
+      .vhe_redir_to_el01 = ENCODE_AA64_CP_REG(3, 5, 4, 0, 0),
       .fieldoffset = offsetof(CPUARMState, banked_spsr[BANK_SVC]) },
     /*
      * We rely on the access checks not allowing the guest to write to the
@@ -4440,138 +4468,6 @@ static CPAccessResult access_el1nvvct(CPUARMState *env, const ARMCPRegInfo *ri,
     }
     return e2h_access(env, ri, isread);
 }
-
-static void define_arm_vh_e2h_redirects_aliases(ARMCPU *cpu)
-{
-    struct E2HAlias {
-        uint32_t src_key, dst_key, new_key;
-        const char *src_name, *dst_name, *new_name;
-        bool (*feature)(const ARMISARegisters *id);
-    };
-
-#define K(op0, op1, crn, crm, op2) \
-    ENCODE_AA64_CP_REG(op0, op1, crn, crm, op2)
-
-    static const struct E2HAlias aliases[] = {
-        { K(3, 0,  1, 0, 0), K(3, 4,  1, 0, 0), K(3, 5, 1, 0, 0),
-          "SCTLR_EL1", "SCTLR_EL2", "SCTLR_EL12" },
-        { K(3, 0,  1, 0, 2), K(3, 4,  1, 1, 2), K(3, 5, 1, 0, 2),
-          "CPACR_EL1", "CPTR_EL2", "CPACR_EL12" },
-        { K(3, 0,  2, 0, 0), K(3, 4,  2, 0, 0), K(3, 5, 2, 0, 0),
-          "TTBR0_EL1", "TTBR0_EL2", "TTBR0_EL12" },
-        { K(3, 0,  2, 0, 1), K(3, 4,  2, 0, 1), K(3, 5, 2, 0, 1),
-          "TTBR1_EL1", "TTBR1_EL2", "TTBR1_EL12" },
-        { K(3, 0,  2, 0, 2), K(3, 4,  2, 0, 2), K(3, 5, 2, 0, 2),
-          "TCR_EL1", "TCR_EL2", "TCR_EL12" },
-        { K(3, 0,  4, 0, 0), K(3, 4,  4, 0, 0), K(3, 5, 4, 0, 0),
-          "SPSR_EL1", "SPSR_EL2", "SPSR_EL12" },
-        { K(3, 0,  4, 0, 1), K(3, 4,  4, 0, 1), K(3, 5, 4, 0, 1),
-          "ELR_EL1", "ELR_EL2", "ELR_EL12" },
-        { K(3, 0,  5, 1, 0), K(3, 4,  5, 1, 0), K(3, 5, 5, 1, 0),
-          "AFSR0_EL1", "AFSR0_EL2", "AFSR0_EL12" },
-        { K(3, 0,  5, 1, 1), K(3, 4,  5, 1, 1), K(3, 5, 5, 1, 1),
-          "AFSR1_EL1", "AFSR1_EL2", "AFSR1_EL12" },
-        { K(3, 0,  5, 2, 0), K(3, 4,  5, 2, 0), K(3, 5, 5, 2, 0),
-          "ESR_EL1", "ESR_EL2", "ESR_EL12" },
-        { K(3, 0,  6, 0, 0), K(3, 4,  6, 0, 0), K(3, 5, 6, 0, 0),
-          "FAR_EL1", "FAR_EL2", "FAR_EL12" },
-        { K(3, 0, 10, 2, 0), K(3, 4, 10, 2, 0), K(3, 5, 10, 2, 0),
-          "MAIR_EL1", "MAIR_EL2", "MAIR_EL12" },
-        { K(3, 0, 10, 3, 0), K(3, 4, 10, 3, 0), K(3, 5, 10, 3, 0),
-          "AMAIR_EL1", "AMAIR_EL2", "AMAIR_EL12" },
-        { K(3, 0, 12, 0, 0), K(3, 4, 12, 0, 0), K(3, 5, 12, 0, 0),
-          "VBAR_EL1", "VBAR_EL2", "VBAR_EL12" },
-        { K(3, 0, 13, 0, 1), K(3, 4, 13, 0, 1), K(3, 5, 13, 0, 1),
-          "CONTEXTIDR_EL1", "CONTEXTIDR_EL2", "CONTEXTIDR_EL12" },
-        { K(3, 0, 14, 1, 0), K(3, 4, 14, 1, 0), K(3, 5, 14, 1, 0),
-          "CNTKCTL_EL1", "CNTHCTL_EL2", "CNTKCTL_EL12" },
-
-        /*
-         * Note that redirection of ZCR is mentioned in the description
-         * of ZCR_EL2, and aliasing in the description of ZCR_EL1, but
-         * not in the summary table.
-         */
-        { K(3, 0,  1, 2, 0), K(3, 4,  1, 2, 0), K(3, 5, 1, 2, 0),
-          "ZCR_EL1", "ZCR_EL2", "ZCR_EL12", isar_feature_aa64_sve },
-        { K(3, 0,  1, 2, 6), K(3, 4,  1, 2, 6), K(3, 5, 1, 2, 6),
-          "SMCR_EL1", "SMCR_EL2", "SMCR_EL12", isar_feature_aa64_sme },
-
-        { K(3, 0,  5, 6, 0), K(3, 4,  5, 6, 0), K(3, 5, 5, 6, 0),
-          "TFSR_EL1", "TFSR_EL2", "TFSR_EL12", isar_feature_aa64_mte },
-
-        { K(3, 0, 13, 0, 7), K(3, 4, 13, 0, 7), K(3, 5, 13, 0, 7),
-          "SCXTNUM_EL1", "SCXTNUM_EL2", "SCXTNUM_EL12",
-          isar_feature_aa64_scxtnum },
-
-        /* TODO: ARMv8.2-SPE -- PMSCR_EL2 */
-        /* TODO: ARMv8.4-Trace -- TRFCR_EL2 */
-    };
-#undef K
-
-    size_t i;
-
-    for (i = 0; i < ARRAY_SIZE(aliases); i++) {
-        const struct E2HAlias *a = &aliases[i];
-        ARMCPRegInfo *src_reg, *dst_reg, *new_reg;
-        bool ok;
-
-        if (a->feature && !a->feature(&cpu->isar)) {
-            continue;
-        }
-
-        src_reg = g_hash_table_lookup(cpu->cp_regs,
-                                      (gpointer)(uintptr_t)a->src_key);
-        dst_reg = g_hash_table_lookup(cpu->cp_regs,
-                                      (gpointer)(uintptr_t)a->dst_key);
-        g_assert(src_reg != NULL);
-        g_assert(dst_reg != NULL);
-
-        /* Cross-compare names to detect typos in the keys.  */
-        g_assert(strcmp(src_reg->name, a->src_name) == 0);
-        g_assert(strcmp(dst_reg->name, a->dst_name) == 0);
-
-        /* Create alias before redirection so we dup the right data. */
-        new_reg = g_memdup(src_reg, sizeof(ARMCPRegInfo));
-
-        new_reg->name = a->new_name;
-        new_reg->type |= ARM_CP_ALIAS;
-        /* Remove PL1/PL0 access, leaving PL2/PL3 R/W in place.  */
-        new_reg->access &= PL2_RW | PL3_RW;
-        /* The new_reg op fields are as per new_key, not the target reg */
-        new_reg->crn = (a->new_key & CP_REG_ARM64_SYSREG_CRN_MASK)
-            >> CP_REG_ARM64_SYSREG_CRN_SHIFT;
-        new_reg->crm = (a->new_key & CP_REG_ARM64_SYSREG_CRM_MASK)
-            >> CP_REG_ARM64_SYSREG_CRM_SHIFT;
-        new_reg->opc0 = (a->new_key & CP_REG_ARM64_SYSREG_OP0_MASK)
-            >> CP_REG_ARM64_SYSREG_OP0_SHIFT;
-        new_reg->opc1 = (a->new_key & CP_REG_ARM64_SYSREG_OP1_MASK)
-            >> CP_REG_ARM64_SYSREG_OP1_SHIFT;
-        new_reg->opc2 = (a->new_key & CP_REG_ARM64_SYSREG_OP2_MASK)
-            >> CP_REG_ARM64_SYSREG_OP2_SHIFT;
-        new_reg->vhe_redir_to_el01 = a->src_key;
-        new_reg->readfn = NULL;
-        new_reg->writefn = NULL;
-        new_reg->accessfn = NULL;
-        new_reg->fieldoffset = 0;
-
-        /*
-         * If the _EL1 register is redirected to memory by FEAT_NV2,
-         * then it shares the offset with the _EL12 register,
-         * and which one is redirected depends on HCR_EL2.NV1.
-         */
-        if (new_reg->nv2_redirect_offset) {
-            assert(new_reg->nv2_redirect_offset & NV2_REDIR_NV1);
-            new_reg->nv2_redirect_offset &= ~NV2_REDIR_NV1;
-            new_reg->nv2_redirect_offset |= NV2_REDIR_NO_NV1;
-        }
-
-        ok = g_hash_table_insert(cpu->cp_regs,
-                                 (gpointer)(uintptr_t)a->new_key, new_reg);
-        g_assert(ok);
-
-        src_reg->vhe_redir_to_el2 = a->dst_key;
-    }
-}
 #endif
 
 static CPAccessResult ctr_el0_access(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -4864,6 +4760,8 @@ static const ARMCPRegInfo zcr_reginfo[] = {
     { .name = "ZCR_EL1", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 0, .crn = 1, .crm = 2, .opc2 = 0,
       .nv2_redirect_offset = 0x1e0 | NV2_REDIR_NV1,
+      .vhe_redir_to_el2 = ENCODE_AA64_CP_REG(3, 4, 1, 2, 0),
+      .vhe_redir_to_el01 = ENCODE_AA64_CP_REG(3, 5, 1, 2, 0),
       .access = PL1_RW, .type = ARM_CP_SVE,
       .fieldoffset = offsetof(CPUARMState, vfp.zcr_el[1]),
       .writefn = zcr_write, .raw_writefn = raw_write },
@@ -5009,6 +4907,8 @@ static const ARMCPRegInfo sme_reginfo[] = {
     { .name = "SMCR_EL1", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 0, .crn = 1, .crm = 2, .opc2 = 6,
       .nv2_redirect_offset = 0x1f0 | NV2_REDIR_NV1,
+      .vhe_redir_to_el2 = ENCODE_AA64_CP_REG(3, 4, 1, 2, 6),
+      .vhe_redir_to_el01 = ENCODE_AA64_CP_REG(3, 5, 1, 2, 6),
       .access = PL1_RW, .type = ARM_CP_SME,
       .fieldoffset = offsetof(CPUARMState, vfp.smcr_el[1]),
       .writefn = smcr_write, .raw_writefn = raw_write },
@@ -5454,6 +5354,8 @@ static const ARMCPRegInfo mte_reginfo[] = {
       .opc0 = 3, .opc1 = 0, .crn = 5, .crm = 6, .opc2 = 0,
       .access = PL1_RW, .accessfn = access_tfsr_el1,
       .nv2_redirect_offset = 0x190 | NV2_REDIR_NV1,
+      .vhe_redir_to_el2 = ENCODE_AA64_CP_REG(3, 4, 5, 6, 0),
+      .vhe_redir_to_el01 = ENCODE_AA64_CP_REG(3, 5, 5, 6, 0),
       .fieldoffset = offsetof(CPUARMState, cp15.tfsr_el[1]) },
     { .name = "TFSR_EL2", .state = ARM_CP_STATE_AA64,
       .type = ARM_CP_NV2_REDIRECT,
@@ -5629,6 +5531,8 @@ static const ARMCPRegInfo scxtnum_reginfo[] = {
       .access = PL1_RW, .accessfn = access_scxtnum_el1,
       .fgt = FGT_SCXTNUM_EL1,
       .nv2_redirect_offset = 0x188 | NV2_REDIR_NV1,
+      .vhe_redir_to_el2 = ENCODE_AA64_CP_REG(3, 4, 13, 0, 7),
+      .vhe_redir_to_el01 = ENCODE_AA64_CP_REG(3, 5, 13, 0, 7),
       .fieldoffset = offsetof(CPUARMState, scxtnum_el[1]) },
     { .name = "SCXTNUM_EL2", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 4, .crn = 13, .crm = 0, .opc2 = 7,
@@ -7005,6 +6909,8 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .accessfn = access_nv1,
               .fgt = FGT_VBAR_EL1,
               .nv2_redirect_offset = 0x250 | NV2_REDIR_NV1,
+              .vhe_redir_to_el2 = ENCODE_AA64_CP_REG(3, 4, 12, 0, 0),
+              .vhe_redir_to_el01 = ENCODE_AA64_CP_REG(3, 5, 12, 0, 0),
               .bank_fieldoffsets = { offsetof(CPUARMState, cp15.vbar_s),
                                      offsetof(CPUARMState, cp15.vbar_ns) },
               .resetvalue = 0 },
@@ -7019,6 +6925,8 @@ void register_cp_regs_for_features(ARMCPU *cpu)
             .opc0 = 3, .opc1 = 0, .crn = 1, .crm = 0, .opc2 = 0,
             .access = PL1_RW, .accessfn = access_tvm_trvm,
             .fgt = FGT_SCTLR_EL1,
+            .vhe_redir_to_el2 = ENCODE_AA64_CP_REG(3, 4, 1, 0, 0),
+            .vhe_redir_to_el01 = ENCODE_AA64_CP_REG(3, 5, 1, 0, 0),
             .nv2_redirect_offset = 0x110 | NV2_REDIR_NV1,
             .bank_fieldoffsets = { offsetof(CPUARMState, cp15.sctlr_s),
                                    offsetof(CPUARMState, cp15.sctlr_ns) },
@@ -7153,16 +7061,6 @@ void register_cp_regs_for_features(ARMCPU *cpu)
     }
 
     define_pm_cpregs(cpu);
-
-#ifndef CONFIG_USER_ONLY
-    /*
-     * Register redirections and aliases must be done last,
-     * after the registers from the other extensions have been defined.
-     */
-    if (arm_feature(env, ARM_FEATURE_EL2) && cpu_isar_feature(aa64_vh, cpu)) {
-        define_arm_vh_e2h_redirects_aliases(cpu);
-    }
-#endif
 }
 
 /*
@@ -7295,6 +7193,8 @@ static void add_cpreg_to_hashtable_aa32(ARMCPU *cpu, ARMCPRegInfo *r)
                                  r->crm, r->opc1, r->opc2);
 
     assert(!(r->type & ARM_CP_ADD_TLBI_NXS)); /* aa64 only */
+    r->vhe_redir_to_el2 = 0;
+    r->vhe_redir_to_el01 = 0;
 
     switch (r->secure) {
     case ARM_CP_SECSTATE_NS:
@@ -7348,6 +7248,63 @@ static void add_cpreg_to_hashtable_aa64(ARMCPU *cpu, ARMCPRegInfo *r)
                                ARM_CP_SECSTATE_NS, nxs_key);
     }
 
+    if (!r->vhe_redir_to_el01) {
+        assert(!r->vhe_redir_to_el2);
+    } else if (!arm_feature(&cpu->env, ARM_FEATURE_EL2) ||
+               !cpu_isar_feature(aa64_vh, cpu)) {
+        r->vhe_redir_to_el2 = 0;
+        r->vhe_redir_to_el01 = 0;
+    } else {
+        /* Create the FOO_EL12 alias. */
+        ARMCPRegInfo *r2 = alloc_cpreg(r, "2");
+        uint32_t key2 = r->vhe_redir_to_el01;
+
+        /*
+         * Clear EL1 redirection on the FOO_EL1 reg;
+         * Clear EL2 redirection on the FOO_EL12 reg;
+         * Install redirection from FOO_EL12 back to FOO_EL1.
+         */
+        r->vhe_redir_to_el01 = 0;
+        r2->vhe_redir_to_el2 = 0;
+        r2->vhe_redir_to_el01 = key;
+
+        r2->type |= ARM_CP_ALIAS | ARM_CP_NO_RAW;
+        /* Remove PL1/PL0 access, leaving PL2/PL3 R/W in place.  */
+        r2->access &= PL2_RW | PL3_RW;
+        /* The new_reg op fields are as per new_key, not the target reg */
+        r2->crn = (key2 & CP_REG_ARM64_SYSREG_CRN_MASK)
+            >> CP_REG_ARM64_SYSREG_CRN_SHIFT;
+        r2->crm = (key2 & CP_REG_ARM64_SYSREG_CRM_MASK)
+            >> CP_REG_ARM64_SYSREG_CRM_SHIFT;
+        r2->opc0 = (key2 & CP_REG_ARM64_SYSREG_OP0_MASK)
+            >> CP_REG_ARM64_SYSREG_OP0_SHIFT;
+        r2->opc1 = (key2 & CP_REG_ARM64_SYSREG_OP1_MASK)
+            >> CP_REG_ARM64_SYSREG_OP1_SHIFT;
+        r2->opc2 = (key2 & CP_REG_ARM64_SYSREG_OP2_MASK)
+            >> CP_REG_ARM64_SYSREG_OP2_SHIFT;
+
+        /* Non-redirected access to this register will abort. */
+        r2->readfn = NULL;
+        r2->writefn = NULL;
+        r2->raw_readfn = NULL;
+        r2->raw_writefn = NULL;
+        r2->accessfn = NULL;
+        r2->fieldoffset = 0;
+
+        /*
+         * If the _EL1 register is redirected to memory by FEAT_NV2,
+         * then it shares the offset with the _EL12 register,
+         * and which one is redirected depends on HCR_EL2.NV1.
+         */
+        if (r2->nv2_redirect_offset) {
+            assert(r2->nv2_redirect_offset & NV2_REDIR_NV1);
+            r2->nv2_redirect_offset &= ~NV2_REDIR_NV1;
+            r2->nv2_redirect_offset |= NV2_REDIR_NO_NV1;
+        }
+        add_cpreg_to_hashtable(cpu, r2, ARM_CP_STATE_AA64,
+                               ARM_CP_SECSTATE_NS, key2);
+    }
+
     add_cpreg_to_hashtable(cpu, r, ARM_CP_STATE_AA64,
                            ARM_CP_SECSTATE_NS, key);
 }
-- 
2.43.0


