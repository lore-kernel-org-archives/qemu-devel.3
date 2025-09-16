Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CA6ECAC598
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 14:25:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyWac-0005zY-PS; Tue, 16 Sep 2025 10:23:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uyWaW-0005uC-L9
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 10:23:20 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uyWaP-0008Og-GH
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 10:23:19 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-b54b3cafdcaso2724085a12.0
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 07:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758032588; x=1758637388; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ssqw9JSyA9Os3mkiUL2PAFRSciY/JuSbUEvZwlSWe9U=;
 b=dldX1MLe2ufOcP8WXKfuVaAfcQRRwvOpGfmFEwLokCWRpOqPg1yWJTaVB9Z1s35/Ok
 XuERLnYln41psek6rZDLfjUApM5ceJyKC0oP024gyrhEFlRDxDBUh08AgUuL+brabU1h
 0oAZCWjFgKLRRi341cEEIPqLBaHEiREpVjXy3cM1FGGpQ9yQ6EdXYD/V8yY93PBwvuRI
 hM78N2xiQCDsb429HjFxFZuJ8wurREiTis4fGfA6CigvBs7HXy0hMTUdh+uV6YNmFqxn
 QKMZeW8nexqOf0GSnTuujCJ1HdHQj3vt+LoV8X/+egSrL2p2SfVFUje+YlOPqmsReD7G
 MR6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758032588; x=1758637388;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ssqw9JSyA9Os3mkiUL2PAFRSciY/JuSbUEvZwlSWe9U=;
 b=B5NSzpEtAHrp9uFAa5Pr8ARZ3Jincd1DaUY+uezV5uPlxe84aRChb4JhJHuLP3kWd+
 NJucBRrONmjaawyKTVrMuY02kyXuySKFPSh7RXizIJKf9vZjdETbio9/POTBqMRNloIm
 O3QfGfOPCzJti1ZuD37TDQJitFPawOjchXCsFqQpqBb6VsXUq8RCVfLsfQRpFI+noWQ5
 vsf7fPJ5gnaYSlXoeOlinq+BQOecP9wkWVkrCzQjlmLHbTUu6S8RG6DKBC6l1brCfhrs
 8ywKJ4bkLcGK2OT5COnQeXSBOP5Hz/fTj+DLhpxhgl7lGZhnGiogxNu0ukHJduBOy7c9
 LNpw==
X-Gm-Message-State: AOJu0Yzxv5eDrbAujzqycrweMf9ALVL/LiSEfNC6X50TCBOQoBby34V/
 e3O634vkdfmCb3zBg296Tt/Bk285zBWO2oAMA/bl4edBMcuyH0jdsVydtQ76BYUZzVlCmNKfk85
 QEZcE
X-Gm-Gg: ASbGncs8unttQt3wYlU31BB2lzPFbT7tw2MzGcazVFu70abRYAxMjMzRdJlRjiRDmzY
 hKjAn/z4IHK6c79ZEbEB8ASWpbTAaFW8XLEPM6HLihJjKKkGHCvrBSzCtd+2jreNiX2DWufy709
 GY9LDyjTq2pkWkIUsr9r9DLf2qnW2A5EGWnwBqmVP2LsMtnXyDXmWSMv9d8hKQqZWjjWiCMTHY7
 2YIBfGZflXQEvNiRVmieSQCVH2HdG2+VB1ELJNH6Y5c9d2l1+qe9EufkIgXHmwanXwmtuDTDAnk
 LiCuQe0kMvbZubqfkGyxyOzNmUoRnIn3NS/ICLDstzjRa+cN0oG1tSq7Wz3rSgqV9W+ybV66u8Q
 7iOM5Z75wnw4pPVjEsG/mkhy37mjd3yUrPLgY9RU=
X-Google-Smtp-Source: AGHT+IFUh08MekGrGxfGO14Tb+bgO7mr2vx2eeT/+cc4MliUhQJVTfYpcMysvkAtOT9+ypVxw2DPyw==
X-Received: by 2002:a17:902:e54e:b0:261:1521:17a8 with SMTP id
 d9443c01a7336-26115211986mr160460175ad.16.1758032587841; 
 Tue, 16 Sep 2025 07:23:07 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2651d2df15esm73459905ad.45.2025.09.16.07.23.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 07:23:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v2 35/36] target/arm: Rename some cpreg to their aarch64 names
Date: Tue, 16 Sep 2025 07:22:36 -0700
Message-ID: <20250916142238.664316-36-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916142238.664316-1-richard.henderson@linaro.org>
References: <20250916142238.664316-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
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

Rename those registers which will have FOO_EL12 aliases.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 8074c50241..4172fcaa21 100644
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
@@ -2018,7 +2018,7 @@ static const ARMCPRegInfo generic_timer_cp_reginfo[] = {
       .resetfn = arm_gt_cntfrq_reset,
     },
     /* overall control: mostly access permissions */
-    { .name = "CNTKCTL", .state = ARM_CP_STATE_BOTH,
+    { .name = "CNTKCTL_EL1", .state = ARM_CP_STATE_BOTH,
       .opc0 = 3, .opc1 = 0, .crn = 14, .crm = 1, .opc2 = 0,
       .access = PL1_RW,
       .fieldoffset = offsetof(CPUARMState, cp15.c14_cntkctl),
@@ -3077,8 +3077,8 @@ static uint64_t mpidr_read(CPUARMState *env, const ARMCPRegInfo *ri)
 }
 
 static const ARMCPRegInfo lpae_cp_reginfo[] = {
-    /* NOP AMAIR0/1 */
-    { .name = "AMAIR0", .state = ARM_CP_STATE_BOTH,
+    /* AMAIR0 is mapped to AMAIR_EL1[31:0] */
+    { .name = "AMAIR_EL1", .state = ARM_CP_STATE_BOTH,
       .opc0 = 3, .crn = 10, .crm = 3, .opc1 = 0, .opc2 = 0,
       .access = PL1_RW, .accessfn = access_tvm_trvm,
       .fgt = FGT_AMAIR_EL1,
@@ -4469,11 +4469,11 @@ static void define_arm_vh_e2h_redirects_aliases(ARMCPU *cpu)
 
     static const struct E2HAlias aliases[] = {
         { K(3, 0,  1, 0, 0), K(3, 4,  1, 0, 0), K(3, 5, 1, 0, 0),
-          "SCTLR", "SCTLR_EL2", "SCTLR_EL12" },
+          "SCTLR_EL1", "SCTLR_EL2", "SCTLR_EL12" },
         { K(3, 0,  1, 0, 3), K(3, 4,  1, 0, 3), K(3, 5, 1, 0, 3),
           "SCTLR2_EL1", "SCTLR2_EL2", "SCTLR2_EL12", isar_feature_aa64_sctlr2 },
         { K(3, 0,  1, 0, 2), K(3, 4,  1, 1, 2), K(3, 5, 1, 0, 2),
-          "CPACR", "CPTR_EL2", "CPACR_EL12" },
+          "CPACR_EL1", "CPTR_EL2", "CPACR_EL12" },
         { K(3, 0,  2, 0, 0), K(3, 4,  2, 0, 0), K(3, 5, 2, 0, 0),
           "TTBR0_EL1", "TTBR0_EL2", "TTBR0_EL12" },
         { K(3, 0,  2, 0, 1), K(3, 4,  2, 0, 1), K(3, 5, 2, 0, 1),
@@ -4497,13 +4497,13 @@ static void define_arm_vh_e2h_redirects_aliases(ARMCPU *cpu)
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
@@ -7145,7 +7145,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
 
     if (arm_feature(env, ARM_FEATURE_VBAR)) {
         static const ARMCPRegInfo vbar_cp_reginfo[] = {
-            { .name = "VBAR", .state = ARM_CP_STATE_BOTH,
+            { .name = "VBAR_EL1", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .crn = 12, .crm = 0, .opc1 = 0, .opc2 = 0,
               .access = PL1_RW, .writefn = vbar_write,
               .accessfn = access_nv1,
@@ -7161,7 +7161,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
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


