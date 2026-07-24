Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 488FDC531D0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 03:07:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wn6F1-0003m5-HN; Thu, 23 Jul 2026 23:06:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wn6Ez-0003kF-9L
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 23:06:25 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wn6Ex-00085D-8Y
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 23:06:25 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-38e041ea211so1261457a91.0
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 20:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784862382; x=1785467182; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JktWC9PHvkyHRlqqwYXOZSgV5TBFp+zjtAV0XCHB3oU=;
 b=KePERrQX/0BOgkR5ZrOtrSI6qC3fERV2XzQQo3Hn3GEnksEvKybSB+5m2brA4urD/H
 8qCZyvQHQR8pgclii6+CI+Ve5vJhbjuhWt6BXU2hruhiFbxbQuJ99ZP5bSMqp3biaTA/
 cv7jGaH0AZH4rcE2oXW+z5TBA2RSqXSKkIB2P8BGMQhR2Hk1ehFS9kEjRP2UamnWvrH4
 VawnW4JFTQRGwYR0BzmFoIHqEft5wiDmVziTMa/pGsitF8MfVa/qWNRzFtO+YKtipJ1d
 4OAxhfuh3+7aDTKMRfKKOAuGDqn/oisxKRJWTALR+auxv8MtbkGw+Vjrguzs0rpqwjX4
 RPog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784862382; x=1785467182;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=JktWC9PHvkyHRlqqwYXOZSgV5TBFp+zjtAV0XCHB3oU=;
 b=E+Qov3lFz5YIXCA8tgWNWiSHMDcHaMv4W1zPEzD1Ye4zYxnC4yyk70YaINEgfLB4rj
 KTZ+tPhHDJyKCR897vEez/reH7535TpJRg+WO8+HYcNALMufqhvv5T/0vXJO5vcsH1ya
 PuEjtf1OuR61wX3uEq95nEXr9y3NJznitRSLrhxKjDwxsxCT9WpRjqUCihR63chW95LA
 PlKXsSMJcrEBNpGIhwELpJF+qDmFBG0GhbiSAWeHeLl/LAl/UKw1wx0vfdHyeWd9UE7E
 Uxx6mJ6WJpv1HK/THEKtDnA8fWkEYXldfRdxoQobLnVp+Swec0TxetoARRoNXIp+kKPr
 ev8A==
X-Gm-Message-State: AOJu0Yz5HLJk7V2HF+xvpFjI4yRjWq4dLyDwyELyIl1YhkAqSn8NPkiL
 kDQm9zOgSY1sjHWnKXaN4X1qJ76EWuS04JlK1xbmWh1CAzc1AxMTibFND183t/RdTBBvU90esk0
 xSQoO
X-Gm-Gg: AR+sD12MPP1BVWK6ufDtafXigQ5YDnzxL91mnBggCEUfmp4cxmIISYsiwpkDZkprq5U
 3wQYpHcfYVgWSMtS56b7nCU3eRAbUjsA5OhRHdsXgOZNoMGLIBaSbvcq/yndWT9Z6rMYPdjfF5A
 2CsRrAKJEQ7B25gUCDAtLW7h2q1R8MImJ5O40XrFpEMmumam+GnMk7iiSU4rVmm0ZXbl2/ZjQb+
 naHgKaU5zRp+RaB4Yu35NuUc9dDTmgKs/mBu8l1VhsTSiWD0h5XW2JwZCky7Oa6ypwR1NjG07yt
 M+yKupALMLws2pFLnaW08wrgk+xkErnd0vofEUon6Wscoq+siBqAuDFpI5YlDYMy1P/jDVyajKq
 53IAaqR1VQcIRdLKLJhdAilA2aHvB/eztHKmwugC24/xvHSD0S2RIr0SfBq1UJlivyQLQaqOMBQ
 1yGoWp6nmlmVj9v/opFlj8yWdxaLtvlvn1jw==
X-Received: by 2002:a17:90b:3e85:b0:381:50ab:1594 with SMTP id
 98e67ed59e1d1-38ec6a489d1mr5541811a91.27.1784862381760; 
 Thu, 23 Jul 2026 20:06:21 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38f03ad0e0csm750777a91.7.2026.07.23.20.06.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 20:06:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 5/6] target/arm: Set fgt in cpregs for FGWTE3
Date: Thu, 23 Jul 2026 20:06:15 -0700
Message-ID: <20260724030616.76180-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260724030616.76180-1-richard.henderson@linaro.org>
References: <20260724030616.76180-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpregs-gcs.c |  5 +++--
 target/arm/helper.c     | 47 ++++++++++++++++++++++-------------------
 2 files changed, 28 insertions(+), 24 deletions(-)

diff --git a/target/arm/cpregs-gcs.c b/target/arm/cpregs-gcs.c
index e31827342d..9c9ae9cd71 100644
--- a/target/arm/cpregs-gcs.c
+++ b/target/arm/cpregs-gcs.c
@@ -97,7 +97,7 @@ static const ARMCPRegInfo gcs_reginfo[] = {
       .fieldoffset = offsetof(CPUARMState, cp15.gcscr_el[2]) },
     { .name = "GCSCR_EL3", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 6, .crn = 2, .crm = 5, .opc2 = 0,
-      .access = PL3_RW,
+      .access = PL3_RW, .fgt = FGT_GCSCR_EL3,
       .fieldoffset = offsetof(CPUARMState, cp15.gcscr_el[3]) },
 
     { .name = "GCSPR_EL0", .state = ARM_CP_STATE_AA64,
@@ -119,7 +119,8 @@ static const ARMCPRegInfo gcs_reginfo[] = {
       .fieldoffset = offsetof(CPUARMState, cp15.gcspr_el[2]) },
     { .name = "GCSPR_EL3", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 6, .crn = 2, .crm = 5, .opc2 = 1,
-      .access = PL3_RW, .writefn = gcspr_write,
+      .access = PL3_RW, .fgt = FGT_GCSPR_EL3,
+      .writefn = gcspr_write,
       .fieldoffset = offsetof(CPUARMState, cp15.gcspr_el[2]) },
 
     { .name = "GCSPUSHM", .state = ARM_CP_STATE_AA64,
diff --git a/target/arm/helper.c b/target/arm/helper.c
index d410a9a1ec..13c935ae6c 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1013,7 +1013,8 @@ static const ARMCPRegInfo v7_cp_reginfo[] = {
       .resetvalue = 0 },
     { .name = "MAIR_EL3", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 6, .crn = 10, .crm = 2, .opc2 = 0,
-      .access = PL3_RW, .fieldoffset = offsetof(CPUARMState, cp15.mair_el[3]),
+      .access = PL3_RW, .fgt = FGT_MAIR_EL3,
+      .fieldoffset = offsetof(CPUARMState, cp15.mair_el[3]),
       .resetvalue = 0 },
     /*
      * For non-long-descriptor page tables these are PRRR and NMRR;
@@ -3685,7 +3686,7 @@ static const ARMCPRegInfo v8_cp_reginfo[] = {
       .type = ARM_CP_IO,
       .opc0 = 3, .opc1 = 6, .crn = 1, .crm = 3, .opc2 = 1,
       .resetvalue = 0,
-      .access = PL3_RW,
+      .access = PL3_RW, .fgt = FGT_MDCR_EL3,
       .writefn = mdcr_el3_write,
       .fieldoffset = offsetof(CPUARMState, cp15.mdcr_el3) },
     { .name = "SDCR", .type = ARM_CP_ALIAS | ARM_CP_IO,
@@ -4435,11 +4436,11 @@ static const ARMCPRegInfo el3_cp_reginfo[] = {
       .fieldoffset = offsetof(CPUARMState, cp15.mvbar) },
     { .name = "TTBR0_EL3", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 6, .crn = 2, .crm = 0, .opc2 = 0,
-      .access = PL3_RW, .resetvalue = 0,
+      .access = PL3_RW, .fgt = FGT_TTBR0_EL3,
       .fieldoffset = offsetof(CPUARMState, cp15.ttbr0_el[3]) },
     { .name = "TCR_EL3", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 6, .crn = 2, .crm = 0, .opc2 = 2,
-      .access = PL3_RW,
+      .access = PL3_RW, .fgt = FGT_TCR_EL3,
       /* no .writefn needed as this can't cause an ASID change */
       .resetvalue = 0,
       .fieldoffset = offsetof(CPUARMState, cp15.tcr_el[3]) },
@@ -4461,7 +4462,7 @@ static const ARMCPRegInfo el3_cp_reginfo[] = {
       .fieldoffset = offsetof(CPUARMState, banked_spsr[BANK_MON]) },
     { .name = "VBAR_EL3", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 6, .crn = 12, .crm = 0, .opc2 = 0,
-      .access = PL3_RW, .writefn = vbar_write,
+      .access = PL3_RW, .fgt = FGT_VBAR_EL3, .writefn = vbar_write,
       .fieldoffset = offsetof(CPUARMState, cp15.vbar_el[3]),
       .resetvalue = 0 },
     { .name = "CPTR_EL3", .state = ARM_CP_STATE_AA64,
@@ -4470,20 +4471,20 @@ static const ARMCPRegInfo el3_cp_reginfo[] = {
       .fieldoffset = offsetof(CPUARMState, cp15.cptr_el[3]) },
     { .name = "TPIDR_EL3", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 6, .crn = 13, .crm = 0, .opc2 = 2,
-      .access = PL3_RW, .resetvalue = 0,
+      .access = PL3_RW, .fgt = FGT_TPIDR_EL3,
       .fieldoffset = offsetof(CPUARMState, cp15.tpidr_el[3]) },
     { .name = "AMAIR_EL3", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 6, .crn = 10, .crm = 3, .opc2 = 0,
-      .access = PL3_RW, .type = ARM_CP_CONST,
-      .resetvalue = 0 },
+      .access = PL3_RW, .fgt = FGT_AMAIR_EL3,
+      .type = ARM_CP_CONST, .resetvalue = 0 },
     { .name = "AFSR0_EL3", .state = ARM_CP_STATE_BOTH,
       .opc0 = 3, .opc1 = 6, .crn = 5, .crm = 1, .opc2 = 0,
-      .access = PL3_RW, .type = ARM_CP_CONST,
-      .resetvalue = 0 },
+      .access = PL3_RW, .fgt = FGT_AFSR0_EL3,
+      .type = ARM_CP_CONST, .resetvalue = 0 },
     { .name = "AFSR1_EL3", .state = ARM_CP_STATE_BOTH,
       .opc0 = 3, .opc1 = 6, .crn = 5, .crm = 1, .opc2 = 1,
-      .access = PL3_RW, .type = ARM_CP_CONST,
-      .resetvalue = 0 },
+      .access = PL3_RW, .fgt = FGT_AFSR1_EL3,
+      .type = ARM_CP_CONST, .resetvalue = 0 },
 };
 
 #ifndef CONFIG_USER_ONLY
@@ -5051,15 +5052,17 @@ static void gpcbw_write(CPUARMState *env, const ARMCPRegInfo *ri,
 static const ARMCPRegInfo rme_reginfo[] = {
     { .name = "GPCCR_EL3", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 6, .crn = 2, .crm = 1, .opc2 = 6,
-      .access = PL3_RW, .writefn = gpccr_write, .resetfn = gpccr_reset,
+      .access = PL3_RW, .fgt = FGT_GPCCR_EL3,
+      .writefn = gpccr_write, .resetfn = gpccr_reset,
       .fieldoffset = offsetof(CPUARMState, cp15.gpccr_el3) },
     { .name = "GPCBW_EL3", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 6, .crn = 2, .crm = 1, .opc2 = 5,
-      .access = PL3_RW, .writefn = gpcbw_write,
+      .access = PL3_RW, .fgt = FGT_GPCBW_EL3, .writefn = gpcbw_write,
       .fieldoffset = offsetof(CPUARMState, cp15.gpcbw_el3) },
     { .name = "GPTBR_EL3", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 6, .crn = 2, .crm = 1, .opc2 = 4,
-      .access = PL3_RW, .fieldoffset = offsetof(CPUARMState, cp15.gptbr_el3) },
+      .access = PL3_RW, .fgt = FGT_GPTBR_EL3,
+      .fieldoffset = offsetof(CPUARMState, cp15.gptbr_el3) },
     { .name = "MFAR_EL3", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 6, .crn = 6, .crm = 0, .opc2 = 5,
       .access = PL3_RW, .fieldoffset = offsetof(CPUARMState, cp15.mfar_el3) },
@@ -6119,7 +6122,7 @@ static const ARMCPRegInfo sctlr2_reginfo[] = {
       .fieldoffset = offsetof(CPUARMState, cp15.sctlr2_el[2]) },
     { .name = "SCTLR2_EL3", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 6, .opc2 = 3, .crn = 1, .crm = 0,
-      .access = PL3_RW, .writefn = sctlr2_el3_write,
+      .access = PL3_RW, .fgt = FGT_SCTLR2_EL3, .writefn = sctlr2_el3_write,
       .fieldoffset = offsetof(CPUARMState, cp15.sctlr2_el[3]) },
 };
 
@@ -6245,7 +6248,7 @@ static const ARMCPRegInfo s1pie_reginfo[] = {
       .fieldoffset = offsetof(CPUARMState, cp15.pir_el[2]) },
     { .name = "PIR_EL3", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 6, .opc2 = 3, .crn = 10, .crm = 2,
-      .access = PL3_RW,
+      .access = PL3_RW, .fgt = FGT_PIR_EL3,
       .fieldoffset = offsetof(CPUARMState, cp15.pir_el[3]) },
     { .name = "PIRE0_EL1", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 0, .opc2 = 2, .crn = 10, .crm = 2,
@@ -6303,7 +6306,7 @@ static const ARMCPRegInfo aie_reginfo[] = {
       .fieldoffset = offsetof(CPUARMState, cp15.mair2_el[2]) },
     { .name = "MAIR2_EL3", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 6, .crn = 10, .crm = 1, .opc2 = 1,
-      .access = PL3_RW,
+      .access = PL3_RW, .fgt = FGT_MAIR2_EL3,
       .fieldoffset = offsetof(CPUARMState, cp15.mair2_el[3]) },
 
     { .name = "AMAIR2_EL1", .state = ARM_CP_STATE_AA64,
@@ -6319,7 +6322,7 @@ static const ARMCPRegInfo aie_reginfo[] = {
       .type = ARM_CP_CONST, .resetvalue = 0 },
     { .name = "AMAIR2_EL3", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 6, .crn = 10, .crm = 3, .opc2 = 1,
-      .access = PL3_RW,
+      .access = PL3_RW, .fgt = FGT_AMAIR2_EL3,
       .type = ARM_CP_CONST, .resetvalue = 0 },
 };
 
@@ -7046,7 +7049,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .resetvalue = arm_feature(env, ARM_FEATURE_AARCH64) },
             { .name = "SCTLR_EL3", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 6, .crn = 1, .crm = 0, .opc2 = 0,
-              .access = PL3_RW,
+              .access = PL3_RW, .fgt = FGT_SCTLR_EL3,
               .raw_writefn = raw_write, .writefn = sctlr_write,
               .fieldoffset = offsetof(CPUARMState, cp15.sctlr_el[3]),
               .resetvalue = cpu->reset_sctlr },
@@ -7421,8 +7424,8 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .resetvalue = 0 },
             { .name = "ACTLR_EL3", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 6, .crn = 1, .crm = 0, .opc2 = 1,
-              .access = PL3_RW, .type = ARM_CP_CONST,
-              .resetvalue = 0 },
+              .access = PL3_RW, .fgt = FGT_ACTLR_EL3,
+              .type = ARM_CP_CONST, .resetvalue = 0 },
         };
         define_arm_cp_regs(cpu, auxcr_reginfo);
         if (cpu_isar_feature(aa32_ac2, cpu)) {
-- 
2.43.0


