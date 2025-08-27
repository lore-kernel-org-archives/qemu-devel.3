Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 852EECA0FF0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 01:09:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ur4eD-0001n7-Va; Tue, 26 Aug 2025 21:08:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ur4e0-0001Kl-Bv
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 21:08:08 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ur4dp-0007fD-2F
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 21:08:08 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-76e434a0118so7243993b3a.0
 for <qemu-devel@nongnu.org>; Tue, 26 Aug 2025 18:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756256873; x=1756861673; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TowZvxXtxZjJfk7AhSGFsKVBwgHa31A30qkqkUEgZQ8=;
 b=JBm2cOHmWENJ91eaIIn/sTSVOKdmi1TBCMlLNQQ5BPuhkE/yA/7ZlPpFQRo0uJBAEN
 /X7ncF1xnBaDa1kmLexNed9Wqv2r+QNeHKZdKp1p8nxYRjGMkpXzH3wRkRSgl2P4p/ve
 LSlCgwwC6jz/Xu9Mw0fzI+6FA69wtlIZ2fpIxUIFBQFdWADm0mgLw8knoWDbse1hg2bb
 O9sczum4vkmsGNUjdttivWqFiDFhNGcCv4O8XMGwBw1RPaLaeVLfg3Hs/wu/K+ef21ld
 hWJC3a7yZlDeYUFk6YlpsFDzxGV7lt9wl+w3AkJyv6sIei5dLNqEZADzfniAgqjdGbpW
 DMYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756256873; x=1756861673;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TowZvxXtxZjJfk7AhSGFsKVBwgHa31A30qkqkUEgZQ8=;
 b=BNUX4OCnSVYxWNtJ2CBKffjXpuY+bRydVoDBl4fVz7QmSwrnutOYABq+TJSGecaM2L
 KlOlV+QaPPOds5VJzNVN5tdkpFpVMdeLEokqiGhuoO6KyeglXOlrHOO/SUPJ95ixEkYh
 2LGNB+K4juKmisUiNUS50fJFzyJRqeALayhYjVy6EiAaKWQinqT/lZgqv7JQ1x+9Pe5m
 hsVEuvKvvp3kVhznbwSdiQgDPBQrjCYcIlqQJrUiY7ACQMdzswTglLlLVPxM3NdflEvM
 pf+0U5pBz0b7OYqFvQ/EU0V9UCF8bXYAOObPZKnfhDVR/cXxZEI6ueCgfubmR8T7/nPf
 2ciw==
X-Gm-Message-State: AOJu0YwO0X0YF7uSTl/ZUHMpCqiNCaxbXr5zBrTK8nEhaeA09LIVIEwR
 AlLdLKG7SGHxj6u7xfd6AtVwhjCiradqLLgx7B9kS6/MLoTeLkIyz3xekRwaKY/Zlzv0eKGRkEg
 YNeBibcc=
X-Gm-Gg: ASbGnctHhQiSrn0PA13ur0sOoujj/Wuuilg7/jtvEzJ61Jyxa77kOh1HXrXS8hUz7m1
 +Mhzw4kHeDkwGQl1H/06bwfEMhmBxD2fNHkDLV4HISg3wPCnv3DRXtMoG8e8aLkupo4cCPTO/C4
 +aRlqCQkgwbCJzm0o635d11yH4eGeG7AIi2XmSfbgCRHOxLYSUjmlMxeGfw94i8CoQV4uig8Xg6
 f79s2+wDb8HsqkuqluqYyyCVtr6ujA9ZU0F90Twjt8F+TdSMnYmtR05G38M1gHVza91oLSDRxGB
 nfn9W+yYaASwGqPnLQX2J+bftPv1c/W40LW70ART0s/l3V25IwIzbzLoVDrV0zHKSe1+cnfrvYH
 YY95Gpdw/sxFIeNf77EzptMgywA==
X-Google-Smtp-Source: AGHT+IGMgFyfhOib6TDUyBOZ2rkB0c2/uXZeqm5CZ/CYsjEDdCe68Ib4dztMCGzn1gAVWBrkdRBlOw==
X-Received: by 2002:a05:6a00:a94:b0:749:bb6:3a8e with SMTP id
 d2e1a72fcca58-7702f9df069mr20288205b3a.1.1756256873079; 
 Tue, 26 Aug 2025 18:07:53 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7720274534esm1419241b3a.47.2025.08.26.18.07.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 18:07:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 35/61] target/arm: Rename some cpreg to their aarch64 names
Date: Wed, 27 Aug 2025 11:04:26 +1000
Message-ID: <20250827010453.4059782-40-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250827010453.4059782-1-richard.henderson@linaro.org>
References: <20250827010453.4059782-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

Rename those registers which will have FOO_EL12 aliases.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index a19406e136..255ca6fdcb 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -671,7 +671,7 @@ static const ARMCPRegInfo v6_cp_reginfo[] = {
      */
     { .name = "WFAR", .cp = 15, .crn = 6, .crm = 0, .opc1 = 0, .opc2 = 1,
       .access = PL1_RW, .type = ARM_CP_CONST, .resetvalue = 0, },
-    { .name = "CPACR", .state = ARM_CP_STATE_BOTH, .opc0 = 3,
+    { .name = "CPACR_EL1", .state = ARM_CP_STATE_BOTH, .opc0 = 3,
       .crn = 1, .crm = 0, .opc1 = 0, .opc2 = 2, .accessfn = cpacr_access,
       .fgt = FGT_CPACR_EL1,
       .nv2_redirect_offset = 0x100 | NV2_REDIR_NV1,
@@ -2012,7 +2012,7 @@ static const ARMCPRegInfo generic_timer_cp_reginfo[] = {
       .resetfn = arm_gt_cntfrq_reset,
     },
     /* overall control: mostly access permissions */
-    { .name = "CNTKCTL", .state = ARM_CP_STATE_BOTH,
+    { .name = "CNTKCTL_EL1", .state = ARM_CP_STATE_BOTH,
       .opc0 = 3, .opc1 = 0, .crn = 14, .crm = 1, .opc2 = 0,
       .access = PL1_RW,
       .fieldoffset = offsetof(CPUARMState, cp15.c14_cntkctl),
@@ -3071,8 +3071,8 @@ static uint64_t mpidr_read(CPUARMState *env, const ARMCPRegInfo *ri)
 }
 
 static const ARMCPRegInfo lpae_cp_reginfo[] = {
-    /* NOP AMAIR0/1 */
-    { .name = "AMAIR0", .state = ARM_CP_STATE_BOTH,
+    /* AMAIR0 is mapped to AMAIR_EL1[31:0] */
+    { .name = "AMAIR_EL1", .state = ARM_CP_STATE_BOTH,
       .opc0 = 3, .crn = 10, .crm = 3, .opc1 = 0, .opc2 = 0,
       .access = PL1_RW, .accessfn = access_tvm_trvm,
       .fgt = FGT_AMAIR_EL1,
@@ -4454,9 +4454,9 @@ static void define_arm_vh_e2h_redirects_aliases(ARMCPU *cpu)
 
     static const struct E2HAlias aliases[] = {
         { K(3, 0,  1, 0, 0), K(3, 4,  1, 0, 0), K(3, 5, 1, 0, 0),
-          "SCTLR", "SCTLR_EL2", "SCTLR_EL12" },
+          "SCTLR_EL1", "SCTLR_EL2", "SCTLR_EL12" },
         { K(3, 0,  1, 0, 2), K(3, 4,  1, 1, 2), K(3, 5, 1, 0, 2),
-          "CPACR", "CPTR_EL2", "CPACR_EL12" },
+          "CPACR_EL1", "CPTR_EL2", "CPACR_EL12" },
         { K(3, 0,  2, 0, 0), K(3, 4,  2, 0, 0), K(3, 5, 2, 0, 0),
           "TTBR0_EL1", "TTBR0_EL2", "TTBR0_EL12" },
         { K(3, 0,  2, 0, 1), K(3, 4,  2, 0, 1), K(3, 5, 2, 0, 1),
@@ -4478,13 +4478,13 @@ static void define_arm_vh_e2h_redirects_aliases(ARMCPU *cpu)
         { K(3, 0, 10, 2, 0), K(3, 4, 10, 2, 0), K(3, 5, 10, 2, 0),
           "MAIR_EL1", "MAIR_EL2", "MAIR_EL12" },
         { K(3, 0, 10, 3, 0), K(3, 4, 10, 3, 0), K(3, 5, 10, 3, 0),
-          "AMAIR0", "AMAIR_EL2", "AMAIR_EL12" },
+          "AMAIR_EL1", "AMAIR_EL2", "AMAIR_EL12" },
         { K(3, 0, 12, 0, 0), K(3, 4, 12, 0, 0), K(3, 5, 12, 0, 0),
-          "VBAR", "VBAR_EL2", "VBAR_EL12" },
+          "VBAR_EL1", "VBAR_EL2", "VBAR_EL12" },
         { K(3, 0, 13, 0, 1), K(3, 4, 13, 0, 1), K(3, 5, 13, 0, 1),
           "CONTEXTIDR_EL1", "CONTEXTIDR_EL2", "CONTEXTIDR_EL12" },
         { K(3, 0, 14, 1, 0), K(3, 4, 14, 1, 0), K(3, 5, 14, 1, 0),
-          "CNTKCTL", "CNTHCTL_EL2", "CNTKCTL_EL12" },
+          "CNTKCTL_EL1", "CNTHCTL_EL2", "CNTKCTL_EL12" },
 
         /*
          * Note that redirection of ZCR is mentioned in the description
@@ -6999,7 +6999,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
 
     if (arm_feature(env, ARM_FEATURE_VBAR)) {
         static const ARMCPRegInfo vbar_cp_reginfo[] = {
-            { .name = "VBAR", .state = ARM_CP_STATE_BOTH,
+            { .name = "VBAR_EL1", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .crn = 12, .crm = 0, .opc1 = 0, .opc2 = 0,
               .access = PL1_RW, .writefn = vbar_write,
               .accessfn = access_nv1,
@@ -7015,7 +7015,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
     /* Generic registers whose values depend on the implementation */
     {
         ARMCPRegInfo sctlr = {
-            .name = "SCTLR", .state = ARM_CP_STATE_BOTH,
+            .name = "SCTLR_EL1", .state = ARM_CP_STATE_BOTH,
             .opc0 = 3, .opc1 = 0, .crn = 1, .crm = 0, .opc2 = 0,
             .access = PL1_RW, .accessfn = access_tvm_trvm,
             .fgt = FGT_SCTLR_EL1,
-- 
2.43.0


