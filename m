Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A140C61DD3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 13:24:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1ONQ-0001A1-EO; Tue, 01 Sep 2026 09:18:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1ONN-00019H-R9
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:18:09 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1ONL-0007Ea-KX
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:18:09 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-c20e70a0962so635842066b.2
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 06:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788268686; x=1788873486; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Byye1p6jZOlA8UVq6wuf/FUpGy8EScHzGLLCOwOeGSo=;
 b=zH/govqCYUeRDh+0AMzFRbi4PvzYs0CN5xM462bthY2s2nZqSdHzCxLMuUOSHnAMQ6
 j0qcBT0HFaQ2z6UM9PUwn3fD9DujYMB14VPtnZr589ZsUMltqDB8fbWx8CrWFJpOirJl
 j9OwcdeyEC53u4Tiwr2NwwrQstlq6ZvIS5GsNiI6yrK7heS431+/XrQLkq/KMJo0Yvgb
 l0KmibSWTvCSe2KcIOA0NFAyK/+AUVUsG3njVFuix4ywpZ/yWeWSgJQMg/cLd0nE0wJq
 jjzocm6nToX5FYbMCMk09O0680t5ro5F0zQPV4xXK2UIzNrYWkUHRnmmt20DbN504zZ1
 fg0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788268686; x=1788873486;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Byye1p6jZOlA8UVq6wuf/FUpGy8EScHzGLLCOwOeGSo=;
 b=jGWtGy9d8cpSXdbBDAIHcaDRgGmIiXR9jX4yw18nuQgNicKlGnDVuCH359k9ufff6h
 xiHtPwSaQBJ2WdsVFeqbnHl0enhXs2S13G6NtQ+veNMUuSJR9bq/u+uNPSqdPqLjbwJG
 E7dYCNc3e3qwCvmpOQqrTrkB8QpdGFB77h+7Ttz+NxGnO0zFPwvUqq/IAtV+1DeFIWXC
 7VLu5vmhw9CN4eTx9z6OmGL1NYxS98V9JzIGI4WEgxMjlLNKLfG8PGswrxhjZn33q7AF
 PzQ1eJwuqZvrxDHyWxQpWghLfHOHeBaxvIbOE7JefxeqbqreiuxFGlAFEVa/lfS91ZHy
 qGmA==
X-Gm-Message-State: AFuF++lOEwR67owPWysy2VQJtkeUcYCBNelwv23L9icftRMETrkP+VhF
 B5g2o0xpFGlWe/mygYq4arVHFQ0KyASxdKnswNERMKQ/B3HjPGTsJa92TKO7rgSwGbXvi7ST3dW
 IPRnSpAE=
X-Gm-Gg: AR+sD13xFJ978bHCt0h3cHVlweL0V7aEy5fJFJT2+lRbtuLjUPnVvsr81QZl/asXxTi
 VunthS/chCRUfmgLK8yT9tLdLp7xBLdbh0lphc6l7Ix10i6lMrmsagXYH/6ynsnohZ0v/rwZFCx
 IFZKjdlgj/Djh/79mLxiFlecbtwhGa4c2bcPTrer2sTJ1kO35BSBhCaXgP0eCXDBlhHGphcQzZg
 0SOyIXpO9I7U0txojJoEU+Yd4PYHETcxyXc2Y74rT3CN+Kg2wlGzK7QMQLQfBVanL4XgCn5TUfB
 c66TDN8kJT4EW4ZjyfcV6tA58DltZiYyU1hwiqrpiOA4Qe0YVB89oF5xest2LoAMUQ+/X5JtJBL
 9vd3DqpsVhRk1aL7UX1cSOsX2X8KzA5u66h4WHGEPfrHLaglfxg/hVShOSdEe2Fzql0W0RKPiib
 J8VTsFNCgnlSU9A1KSfj8Hcqyul3DWfpJSxeRLsGZ1MgrKo796xMGPhwjqE5Lb5g8WBknKH9H0l
 VLJUspekL4fVkcQJq+vdRp6z0X8w8n+NHkmj3DS83UunZbIaBWUs4YCQ/Azz8MLPnA6pg==
X-Received: by 2002:a17:906:f852:b0:c25:c7a9:7b8a with SMTP id
 a640c23a62f3a-c25c7a98a29mr93725866b.12.1788268686093; 
 Tue, 01 Sep 2026 06:18:06 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c255ee2853dsm617907466b.18.2026.09.01.06.18.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 06:18:05 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 32/58] target/arm: Set fgt in cpregs for FGWTE3
Date: Tue,  1 Sep 2026 14:17:06 +0100
Message-ID: <20260901131732.2263947-33-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901131732.2263947-1-peter.maydell@linaro.org>
References: <20260901131732.2263947-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x634.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260806172709.333300-6-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpregs-gcs.c |  5 +++--
 target/arm/helper.c     | 49 ++++++++++++++++++++++-------------------
 2 files changed, 29 insertions(+), 25 deletions(-)

diff --git a/target/arm/cpregs-gcs.c b/target/arm/cpregs-gcs.c
index e31827342d9..9c9ae9cd715 100644
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
index 1b24aca2937..c3f607e6d6b 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1056,7 +1056,8 @@ static const ARMCPRegInfo v7_cp_reginfo[] = {
       .resetvalue = 0 },
     { .name = "MAIR_EL3", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 6, .crn = 10, .crm = 2, .opc2 = 0,
-      .access = PL3_RW, .fieldoffset = offsetof(CPUARMState, cp15.mair_el[3]),
+      .access = PL3_RW, .fgt = FGT_MAIR_EL3,
+      .fieldoffset = offsetof(CPUARMState, cp15.mair_el[3]),
       .resetvalue = 0 },
     /*
      * For non-long-descriptor page tables these are PRRR and NMRR;
@@ -3728,7 +3729,7 @@ static const ARMCPRegInfo v8_cp_reginfo[] = {
       .type = ARM_CP_IO,
       .opc0 = 3, .opc1 = 6, .crn = 1, .crm = 3, .opc2 = 1,
       .resetvalue = 0,
-      .access = PL3_RW,
+      .access = PL3_RW, .fgt = FGT_MDCR_EL3,
       .writefn = mdcr_el3_write,
       .fieldoffset = offsetof(CPUARMState, cp15.mdcr_el3) },
     { .name = "SDCR", .type = ARM_CP_ALIAS | ARM_CP_IO,
@@ -4498,11 +4499,11 @@ static const ARMCPRegInfo el3_cp_reginfo[] = {
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
@@ -4524,7 +4525,7 @@ static const ARMCPRegInfo el3_cp_reginfo[] = {
       .fieldoffset = offsetof(CPUARMState, banked_spsr[BANK_MON]) },
     { .name = "VBAR_EL3", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 6, .crn = 12, .crm = 0, .opc2 = 0,
-      .access = PL3_RW, .writefn = vbar_write,
+      .access = PL3_RW, .fgt = FGT_VBAR_EL3, .writefn = vbar_write,
       .fieldoffset = offsetof(CPUARMState, cp15.vbar_el[3]),
       .resetvalue = 0 },
     { .name = "CPTR_EL3", .state = ARM_CP_STATE_AA64,
@@ -4533,20 +4534,20 @@ static const ARMCPRegInfo el3_cp_reginfo[] = {
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
@@ -5114,15 +5115,17 @@ static void gpcbw_write(CPUARMState *env, const ARMCPRegInfo *ri,
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
@@ -5232,7 +5235,7 @@ static const ARMCPRegInfo mec_reginfo[] = {
       .fieldoffset = offsetof(CPUARMState, cp15.mecid_a1_el2) },
     { .name = "MECID_RL_A_EL3", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 6, .opc2 = 1, .crn = 10, .crm = 10,
-      .access = PL3_RW, .accessfn = mecid_access,
+      .access = PL3_RW, .accessfn = mecid_access, .fgt = FGT_MECID_RL_A_EL3,
       .writefn = mecid_write,
       .fieldoffset = offsetof(CPUARMState, cp15.mecid_rl_a_el3) },
     { .name = "VMECID_P_EL2", .state = ARM_CP_STATE_AA64,
@@ -6182,7 +6185,7 @@ static const ARMCPRegInfo sctlr2_reginfo[] = {
       .fieldoffset = offsetof(CPUARMState, cp15.sctlr2_el[2]) },
     { .name = "SCTLR2_EL3", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 6, .opc2 = 3, .crn = 1, .crm = 0,
-      .access = PL3_RW, .writefn = sctlr2_el3_write,
+      .access = PL3_RW, .fgt = FGT_SCTLR2_EL3, .writefn = sctlr2_el3_write,
       .fieldoffset = offsetof(CPUARMState, cp15.sctlr2_el[3]) },
 };
 
@@ -6308,7 +6311,7 @@ static const ARMCPRegInfo s1pie_reginfo[] = {
       .fieldoffset = offsetof(CPUARMState, cp15.pir_el[2]) },
     { .name = "PIR_EL3", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 6, .opc2 = 3, .crn = 10, .crm = 2,
-      .access = PL3_RW,
+      .access = PL3_RW, .fgt = FGT_PIR_EL3,
       .fieldoffset = offsetof(CPUARMState, cp15.pir_el[3]) },
     { .name = "PIRE0_EL1", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 0, .opc2 = 2, .crn = 10, .crm = 2,
@@ -6366,7 +6369,7 @@ static const ARMCPRegInfo aie_reginfo[] = {
       .fieldoffset = offsetof(CPUARMState, cp15.mair2_el[2]) },
     { .name = "MAIR2_EL3", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 6, .crn = 10, .crm = 1, .opc2 = 1,
-      .access = PL3_RW,
+      .access = PL3_RW, .fgt = FGT_MAIR2_EL3,
       .fieldoffset = offsetof(CPUARMState, cp15.mair2_el[3]) },
 
     { .name = "AMAIR2_EL1", .state = ARM_CP_STATE_AA64,
@@ -6382,7 +6385,7 @@ static const ARMCPRegInfo aie_reginfo[] = {
       .type = ARM_CP_CONST, .resetvalue = 0 },
     { .name = "AMAIR2_EL3", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 6, .crn = 10, .crm = 3, .opc2 = 1,
-      .access = PL3_RW,
+      .access = PL3_RW, .fgt = FGT_AMAIR2_EL3,
       .type = ARM_CP_CONST, .resetvalue = 0 },
 };
 
@@ -7110,7 +7113,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .resetvalue = arm_feature(env, ARM_FEATURE_AARCH64) },
             { .name = "SCTLR_EL3", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 6, .crn = 1, .crm = 0, .opc2 = 0,
-              .access = PL3_RW,
+              .access = PL3_RW, .fgt = FGT_SCTLR_EL3,
               .raw_writefn = raw_write, .writefn = sctlr_write,
               .fieldoffset = offsetof(CPUARMState, cp15.sctlr_el[3]),
               .resetvalue = cpu->reset_sctlr },
@@ -7485,8 +7488,8 @@ void register_cp_regs_for_features(ARMCPU *cpu)
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


