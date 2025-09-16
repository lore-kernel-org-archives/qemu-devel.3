Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 909D5CAC59B
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 14:32:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyWbW-0006ju-8t; Tue, 16 Sep 2025 10:24:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uyWae-000622-3M
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 10:23:28 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uyWaT-0008PJ-TL
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 10:23:27 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2445806df50so44612515ad.1
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 07:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758032589; x=1758637389; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BKTqTO3iuxrFyz5QIzUUNVelH/TKgQ++V0kgAuslvF0=;
 b=vyGzMe+f3WgT+aeu75cFbAEwIXl+QQPGe64ZvqVblBT8pUAZcv/hs11IqngncpuJRt
 yfU05E/FvxBGDl4THiQLtTeSNKPXlsLPBcmWScq0H7Air31a0sCej/DImlEwXpL8iXOU
 QmqK8SRrtu7EvLhm8vXfBPxMwUwVLkC/eYskZzvBkNvtzOYqxlZ45EZGCkl+zZiX7TDi
 R/8Inm+aGXDyE8tWi3w+L6CpzCp0aRQg2RGrMD6UQUrvub8L3s4JMMyGuqYbdsVO0F3P
 x0KIBdIGdzLQfM9Jo1K8k0m/utU3zutBZTcPi8YkLhgJTi2XglRifU29Eju1xd4C5ok5
 7aHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758032589; x=1758637389;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BKTqTO3iuxrFyz5QIzUUNVelH/TKgQ++V0kgAuslvF0=;
 b=mIyYyPce8shpjn5M/tWAuQ9OGy+eyan109DbmS8TaxjSd5q6ZYfkF+NwG1zRW7U9gN
 0mwVd6REbdJ4BI8jJcveceG0shx5OlIJtXUKkeNKlqeYbjCTA0woxuHT2EuSDEz1ceFh
 LgCyexWVfjD4+9lf3BY6f8BWIH+oN3C53s5ewpFBszn43TyH1VVbdtyPaYoFmBecOO3s
 /ScRQ6q+1shnrPVQIRc9lb7Gf9BfBWBikAZOawjG1IDWsl2/tlvTX0t757lIYMjlABbH
 65Ni6oTV9abdKQEuuLE7IDC24VcEyjpvORJqWboHVOsdqk4TU3hJN9d2LEkNTlVdJSrW
 8JWw==
X-Gm-Message-State: AOJu0Ywy3w/RNPys8xdPqzsdkTvFj3ab2U9lPnUpbpaFzamR2ib+AINO
 ZqgAJqTmwp1Bp/7EVTS0TmhN053Mrvo493++xHtxUDhIzNKbaUYW0GscAl6F4fwqjeMzp7YRy3E
 q303K
X-Gm-Gg: ASbGnculy58BLK9VeZkBnoGLV+SyXpbjEk6sSS06KdMaXmaUCakXwhcpTdM9/K+eTbg
 TJOf+sT3HotmGPzARssDhcSUHMV1HCpJPqktLMjRK6tqyAkJNBdLvKJ7U/Zpk+jIVi3BtZF/DuP
 3LgMClrsGDC/NQgnzVCsPJIGAJKYJNzQtW+AeTssUta/8/FRGFuZcP+2Q4DU57dLaVAuVzN03sx
 85fKSUOplUEZTC0pjtXTT+E3SMlokV2Hx4N5qKhwKVsEsQL+ZyZsoFYNiBV3PWuJKh4iAM1VWkx
 lskqtGbuv5k+MHJtEEgxg3/H//Bxg0fR6ZvMhuNEup+nbULK/y6kqW+uA1zC5hNHAFK0w/IlwXM
 NOplokD6KVnF16+C6QtELvCm80YYH
X-Google-Smtp-Source: AGHT+IHa8mh3TqBQSxHbnh2Hq1ZgbXRBrQBYxsXJVzXNva/aH0NAJxP8XBq75QgVO5/XwK4+DmeiHQ==
X-Received: by 2002:a17:903:2444:b0:266:e8c3:4731 with SMTP id
 d9443c01a7336-266e8c35152mr97433395ad.23.1758032588555; 
 Tue, 16 Sep 2025 07:23:08 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2651d2df15esm73459905ad.45.2025.09.16.07.23.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 07:23:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v2 36/36] target/arm: Remove
 define_arm_vh_e2h_redirects_aliases
Date: Tue, 16 Sep 2025 07:22:37 -0700
Message-ID: <20250916142238.664316-37-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916142238.664316-1-richard.henderson@linaro.org>
References: <20250916142238.664316-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

Populate vhe_redir_to_{el2,el01} on each ARMCPRegInfo.
Clear the fields within add_cpreg_to_hashtable_aa32.
Create the FOO_EL12 cpreg within add_cpreg_to_hashtable_aa64;
add ARM_CP_NO_RAW.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpregs.h |   6 +-
 target/arm/helper.c | 249 ++++++++++++++++++--------------------------
 2 files changed, 107 insertions(+), 148 deletions(-)

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
index 4172fcaa21..5353d6a5f0 100644
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
@@ -956,12 +960,16 @@ static const ARMCPRegInfo v7_cp_reginfo[] = {
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
@@ -972,6 +980,8 @@ static const ARMCPRegInfo v7_cp_reginfo[] = {
       .access = PL1_RW, .accessfn = access_tvm_trvm,
       .fgt = FGT_MAIR_EL1,
       .nv2_redirect_offset = 0x140 | NV2_REDIR_NV1,
+      .vhe_redir_to_el2 = ENCODE_AA64_CP_REG(3, 4, 10, 2, 0),
+      .vhe_redir_to_el01 = ENCODE_AA64_CP_REG(3, 5, 10, 2, 0),
       .fieldoffset = offsetof(CPUARMState, cp15.mair_el[1]),
       .resetvalue = 0 },
     { .name = "MAIR_EL3", .state = ARM_CP_STATE_AA64,
@@ -2021,6 +2031,8 @@ static const ARMCPRegInfo generic_timer_cp_reginfo[] = {
     { .name = "CNTKCTL_EL1", .state = ARM_CP_STATE_BOTH,
       .opc0 = 3, .opc1 = 0, .crn = 14, .crm = 1, .opc2 = 0,
       .access = PL1_RW,
+      .vhe_redir_to_el2 = ENCODE_AA64_CP_REG(3, 4, 14, 1, 0),
+      .vhe_redir_to_el01 = ENCODE_AA64_CP_REG(3, 5, 14, 1, 0),
       .fieldoffset = offsetof(CPUARMState, cp15.c14_cntkctl),
       .resetvalue = 0,
     },
@@ -2811,6 +2823,8 @@ static const ARMCPRegInfo vmsa_pmsa_cp_reginfo[] = {
       .access = PL1_RW, .accessfn = access_tvm_trvm,
       .fgt = FGT_FAR_EL1,
       .nv2_redirect_offset = 0x220 | NV2_REDIR_NV1,
+      .vhe_redir_to_el2 = ENCODE_AA64_CP_REG(3, 4, 6, 0, 0),
+      .vhe_redir_to_el01 = ENCODE_AA64_CP_REG(3, 5, 6, 0, 0),
       .fieldoffset = offsetof(CPUARMState, cp15.far_el[1]),
       .resetvalue = 0, },
 };
@@ -2821,12 +2835,16 @@ static const ARMCPRegInfo vmsa_cp_reginfo[] = {
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
@@ -2835,6 +2853,8 @@ static const ARMCPRegInfo vmsa_cp_reginfo[] = {
       .access = PL1_RW, .accessfn = access_tvm_trvm,
       .fgt = FGT_TTBR1_EL1,
       .nv2_redirect_offset = 0x210 | NV2_REDIR_NV1,
+      .vhe_redir_to_el2 = ENCODE_AA64_CP_REG(3, 4, 2, 0, 1),
+      .vhe_redir_to_el01 = ENCODE_AA64_CP_REG(3, 5, 2, 0, 1),
       .writefn = vmsa_ttbr_write, .resetvalue = 0, .raw_writefn = raw_write,
       .bank_fieldoffsets = { offsetof(CPUARMState, cp15.ttbr1_s),
                              offsetof(CPUARMState, cp15.ttbr1_ns) } },
@@ -2843,6 +2863,8 @@ static const ARMCPRegInfo vmsa_cp_reginfo[] = {
       .access = PL1_RW, .accessfn = access_tvm_trvm,
       .fgt = FGT_TCR_EL1,
       .nv2_redirect_offset = 0x120 | NV2_REDIR_NV1,
+      .vhe_redir_to_el2 = ENCODE_AA64_CP_REG(3, 4, 2, 0, 2),
+      .vhe_redir_to_el01 = ENCODE_AA64_CP_REG(3, 5, 2, 0, 2),
       .writefn = vmsa_tcr_el12_write,
       .raw_writefn = raw_write,
       .resetvalue = 0,
@@ -3083,6 +3105,8 @@ static const ARMCPRegInfo lpae_cp_reginfo[] = {
       .access = PL1_RW, .accessfn = access_tvm_trvm,
       .fgt = FGT_AMAIR_EL1,
       .nv2_redirect_offset = 0x148 | NV2_REDIR_NV1,
+      .vhe_redir_to_el2 = ENCODE_AA64_CP_REG(3, 4, 10, 3, 0),
+      .vhe_redir_to_el01 = ENCODE_AA64_CP_REG(3, 5, 10, 3, 0),
       .type = ARM_CP_CONST, .resetvalue = 0 },
     /* AMAIR1 is mapped to AMAIR_EL1[63:32] */
     { .name = "AMAIR1", .cp = 15, .crn = 10, .crm = 3, .opc1 = 0, .opc2 = 1,
@@ -3608,12 +3632,16 @@ static const ARMCPRegInfo v8_cp_reginfo[] = {
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
@@ -4455,142 +4483,6 @@ static CPAccessResult access_el1nvvct(CPUARMState *env, const ARMCPRegInfo *ri,
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
-        { K(3, 0,  1, 0, 3), K(3, 4,  1, 0, 3), K(3, 5, 1, 0, 3),
-          "SCTLR2_EL1", "SCTLR2_EL2", "SCTLR2_EL12", isar_feature_aa64_sctlr2 },
-        { K(3, 0,  1, 0, 2), K(3, 4,  1, 1, 2), K(3, 5, 1, 0, 2),
-          "CPACR_EL1", "CPTR_EL2", "CPACR_EL12" },
-        { K(3, 0,  2, 0, 0), K(3, 4,  2, 0, 0), K(3, 5, 2, 0, 0),
-          "TTBR0_EL1", "TTBR0_EL2", "TTBR0_EL12" },
-        { K(3, 0,  2, 0, 1), K(3, 4,  2, 0, 1), K(3, 5, 2, 0, 1),
-          "TTBR1_EL1", "TTBR1_EL2", "TTBR1_EL12" },
-        { K(3, 0,  2, 0, 2), K(3, 4,  2, 0, 2), K(3, 5, 2, 0, 2),
-          "TCR_EL1", "TCR_EL2", "TCR_EL12" },
-        { K(3, 0,  2, 0, 3), K(3, 4,  2, 0, 3), K(3, 5, 2, 0, 3),
-          "TCR2_EL1", "TCR2_EL2", "TCR2_EL12", isar_feature_aa64_tcr2 },
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
@@ -4883,6 +4775,8 @@ static const ARMCPRegInfo zcr_reginfo[] = {
     { .name = "ZCR_EL1", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 0, .crn = 1, .crm = 2, .opc2 = 0,
       .nv2_redirect_offset = 0x1e0 | NV2_REDIR_NV1,
+      .vhe_redir_to_el2 = ENCODE_AA64_CP_REG(3, 4, 1, 2, 0),
+      .vhe_redir_to_el01 = ENCODE_AA64_CP_REG(3, 5, 1, 2, 0),
       .access = PL1_RW, .type = ARM_CP_SVE,
       .fieldoffset = offsetof(CPUARMState, vfp.zcr_el[1]),
       .writefn = zcr_write, .raw_writefn = raw_write },
@@ -5028,6 +4922,8 @@ static const ARMCPRegInfo sme_reginfo[] = {
     { .name = "SMCR_EL1", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 0, .crn = 1, .crm = 2, .opc2 = 6,
       .nv2_redirect_offset = 0x1f0 | NV2_REDIR_NV1,
+      .vhe_redir_to_el2 = ENCODE_AA64_CP_REG(3, 4, 1, 2, 6),
+      .vhe_redir_to_el01 = ENCODE_AA64_CP_REG(3, 5, 1, 2, 6),
       .access = PL1_RW, .type = ARM_CP_SME,
       .fieldoffset = offsetof(CPUARMState, vfp.smcr_el[1]),
       .writefn = smcr_write, .raw_writefn = raw_write },
@@ -5473,6 +5369,8 @@ static const ARMCPRegInfo mte_reginfo[] = {
       .opc0 = 3, .opc1 = 0, .crn = 5, .crm = 6, .opc2 = 0,
       .access = PL1_RW, .accessfn = access_tfsr_el1,
       .nv2_redirect_offset = 0x190 | NV2_REDIR_NV1,
+      .vhe_redir_to_el2 = ENCODE_AA64_CP_REG(3, 4, 5, 6, 0),
+      .vhe_redir_to_el01 = ENCODE_AA64_CP_REG(3, 5, 5, 6, 0),
       .fieldoffset = offsetof(CPUARMState, cp15.tfsr_el[1]) },
     { .name = "TFSR_EL2", .state = ARM_CP_STATE_AA64,
       .type = ARM_CP_NV2_REDIRECT,
@@ -5648,6 +5546,8 @@ static const ARMCPRegInfo scxtnum_reginfo[] = {
       .access = PL1_RW, .accessfn = access_scxtnum_el1,
       .fgt = FGT_SCXTNUM_EL1,
       .nv2_redirect_offset = 0x188 | NV2_REDIR_NV1,
+      .vhe_redir_to_el2 = ENCODE_AA64_CP_REG(3, 4, 13, 0, 7),
+      .vhe_redir_to_el01 = ENCODE_AA64_CP_REG(3, 5, 13, 0, 7),
       .fieldoffset = offsetof(CPUARMState, scxtnum_el[1]) },
     { .name = "SCXTNUM_EL2", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 4, .crn = 13, .crm = 0, .opc2 = 7,
@@ -5992,6 +5892,8 @@ static const ARMCPRegInfo sctlr2_reginfo[] = {
       .opc0 = 3, .opc1 = 0, .opc2 = 3, .crn = 1, .crm = 0,
       .access = PL1_RW, .accessfn = sctlr2_el1_access,
       .writefn = sctlr2_el1_write, .fgt = FGT_SCTLR_EL1,
+      .vhe_redir_to_el2 = ENCODE_AA64_CP_REG(3, 4, 1, 0, 3),
+      .vhe_redir_to_el01 = ENCODE_AA64_CP_REG(3, 5, 1, 0, 3),
       .nv2_redirect_offset = 0x278 | NV2_REDIR_NV1,
       .fieldoffset = offsetof(CPUARMState, cp15.sctlr2_el[1]) },
     { .name = "SCTLR2_EL2", .state = ARM_CP_STATE_AA64,
@@ -6052,6 +5954,8 @@ static const ARMCPRegInfo tcr2_reginfo[] = {
       .opc0 = 3, .opc1 = 0, .opc2 = 3, .crn = 2, .crm = 0,
       .access = PL1_RW, .accessfn = tcr2_el1_access,
       .writefn = tcr2_el1_write, .fgt = FGT_TCR_EL1,
+      .vhe_redir_to_el2 = ENCODE_AA64_CP_REG(3, 4, 2, 0, 3),
+      .vhe_redir_to_el01 = ENCODE_AA64_CP_REG(3, 5, 2, 0, 3),
       .nv2_redirect_offset = 0x270 | NV2_REDIR_NV1,
       .fieldoffset = offsetof(CPUARMState, cp15.tcr2_el[1]) },
     { .name = "TCR2_EL2", .state = ARM_CP_STATE_AA64,
@@ -7151,6 +7055,8 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .accessfn = access_nv1,
               .fgt = FGT_VBAR_EL1,
               .nv2_redirect_offset = 0x250 | NV2_REDIR_NV1,
+              .vhe_redir_to_el2 = ENCODE_AA64_CP_REG(3, 4, 12, 0, 0),
+              .vhe_redir_to_el01 = ENCODE_AA64_CP_REG(3, 5, 12, 0, 0),
               .bank_fieldoffsets = { offsetof(CPUARMState, cp15.vbar_s),
                                      offsetof(CPUARMState, cp15.vbar_ns) },
               .resetvalue = 0 },
@@ -7165,6 +7071,8 @@ void register_cp_regs_for_features(ARMCPU *cpu)
             .opc0 = 3, .opc1 = 0, .crn = 1, .crm = 0, .opc2 = 0,
             .access = PL1_RW, .accessfn = access_tvm_trvm,
             .fgt = FGT_SCTLR_EL1,
+            .vhe_redir_to_el2 = ENCODE_AA64_CP_REG(3, 4, 1, 0, 0),
+            .vhe_redir_to_el01 = ENCODE_AA64_CP_REG(3, 5, 1, 0, 0),
             .nv2_redirect_offset = 0x110 | NV2_REDIR_NV1,
             .bank_fieldoffsets = { offsetof(CPUARMState, cp15.sctlr_s),
                                    offsetof(CPUARMState, cp15.sctlr_ns) },
@@ -7307,16 +7215,6 @@ void register_cp_regs_for_features(ARMCPU *cpu)
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
@@ -7449,6 +7347,8 @@ static void add_cpreg_to_hashtable_aa32(ARMCPU *cpu, ARMCPRegInfo *r)
                                  r->crm, r->opc1, r->opc2);
 
     assert(!(r->type & ARM_CP_ADD_TLBI_NXS)); /* aa64 only */
+    r->vhe_redir_to_el2 = 0;
+    r->vhe_redir_to_el01 = 0;
 
     switch (r->secure) {
     case ARM_CP_SECSTATE_NS:
@@ -7502,6 +7402,63 @@ static void add_cpreg_to_hashtable_aa64(ARMCPU *cpu, ARMCPRegInfo *r)
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


