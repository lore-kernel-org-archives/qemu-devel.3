Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06F22CAC5B9
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 14:23:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v29AO-0001SD-Qo; Fri, 26 Sep 2025 10:11:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v299N-00007y-GG
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:10:20 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v298c-0005m4-4E
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:10:16 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3e8ef75b146so1757917f8f.0
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 07:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758895764; x=1759500564; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jGZqo/oHbKt90JuIzxEZweFztG11U/1sjg23QRqBhSY=;
 b=XXvq1p4zgUF9qAaMHV+y4d0ssK/TaIdZJmiJUf/QFN8BUI40ELcDCG7i25xiwYvEAD
 E/WdDH+lkbZwiZxSHoUrf+i5vMLIQWx5Q7JwXpFrANEyh7mxzDWUeX1NxUa45zFbJ1gn
 7mUbYA3LjLIwyiaInXRdirPsIs+suVsk3SaaCah96ZIRdkzenE8xVh63AZXDKJ/o2CoM
 ZT3HGMRZi+c76JHfeXEwgZeK8qMzQNyV8QO8E3msrVpEat5MO/mrLcvcloivHiX4wEho
 NWDP7oyvI8glWVcKvSf1KzGZ7YGVl6Du2gs3w66W6qNMEXCIgwy2AycCTv3Qii7LAeLn
 CCFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758895764; x=1759500564;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jGZqo/oHbKt90JuIzxEZweFztG11U/1sjg23QRqBhSY=;
 b=ZW7EMBnHRNldJIH2bx2coTo3dbIc2eCoVnUVOJt9nkDWtjkVRkRtBUY+pfyrkzBLiE
 TA2M9QDTgZp7Xz6ipkyvlkmxEQ6y6L/Ef/EY9EfT2C84559PG003H4+Sbsi8mc1oWkDk
 7fG7d6mGZxIrrOcBMyZZVfs7C3UKPYOo28ocz5kv6o1Xsle3riHkMNV///AAiurDE6BJ
 C3i9PcwoC7OTLF+rQXeL+Hz/vB6Av/luI6TXDaxlMC1BH6XG5Azig8f2jqYKS3iqsxqo
 NNKnftHOScQvECG72V4K+OgRwTzFgb81ulNRyzIu1Alx4mk1KFdPEhTdKm7yAlwvUDmx
 qWxQ==
X-Gm-Message-State: AOJu0YwaT9qDn6UN1Zi+DXq4dgwFt9cb+6YTQ4rRKW36NlNK+406aroT
 7+1YMsb0k6iTpUdWIkIRFrOEZGLFehLiXusEyhjBcsbfCNtCI1wfL728wYnaZhi7PH/CZHmRyMt
 e3Xo4
X-Gm-Gg: ASbGncu8RI3wsX18cF2QHE8g5t5/G8Y+LSdniQI0CotLg4GZqH57gzyWHZngfwb0adj
 m3tMbLnFWcU/JRqkoz5oPYUBaKJsOPvB6FCTk3moYa49ajXjqH2RGPNxKC1sqGozw/xkzAJ1jPH
 tFE8khR69Dk2dBfiYjIbdi5kFW4kycA8hzyIF+akLgFHz9WPtcXsULFXB82XLlHMhEbfeLEXD4V
 P1vgcHns/NgUVFwZ8d9OQcJFHiZCRCNcqzCMBm/yz30hWf4Q+DyF4zdbVAxVgRXT8ZBiEiq2UlZ
 9wXXfjRx4wSMY6410uFlCQmNXrf1MfBGlCg+9YTzENZPZ8uB+CdvxnppsaONrXz8y/lRKiPEyU3
 WkMArvhyZ+xBXFkPmr/sRtPW+Zuh/81JmypfWvKo=
X-Google-Smtp-Source: AGHT+IGp097LdKpZDl0SBQ7Lvp6HwZnNYbwsw92oQ/7oweY4CJLTkpM2qDYejzoUEG+4NGzuseJoBg==
X-Received: by 2002:a05:6000:2507:b0:3ee:1118:df81 with SMTP id
 ffacd0b85a97d-40e4623732amr7362527f8f.13.1758895763788; 
 Fri, 26 Sep 2025 07:09:23 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-410f2007372sm6338315f8f.16.2025.09.26.07.09.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 07:09:23 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 37/44] target/arm: Rename some cpreg to their aarch64 names
Date: Fri, 26 Sep 2025 15:08:37 +0100
Message-ID: <20250926140844.1493020-38-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250926140844.1493020-1-peter.maydell@linaro.org>
References: <20250926140844.1493020-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

From: Richard Henderson <richard.henderson@linaro.org>

Rename those registers which will have FOO_EL12 aliases.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 3840ca62a69..12835977bd8 100644
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
@@ -3048,8 +3048,8 @@ static uint64_t mpidr_read(CPUARMState *env, const ARMCPRegInfo *ri)
 }
 
 static const ARMCPRegInfo lpae_cp_reginfo[] = {
-    /* NOP AMAIR0/1 */
-    { .name = "AMAIR0", .state = ARM_CP_STATE_BOTH,
+    /* AMAIR0 is mapped to AMAIR_EL1[31:0] */
+    { .name = "AMAIR_EL1", .state = ARM_CP_STATE_BOTH,
       .opc0 = 3, .crn = 10, .crm = 3, .opc1 = 0, .opc2 = 0,
       .access = PL1_RW, .accessfn = access_tvm_trvm,
       .fgt = FGT_AMAIR_EL1,
@@ -4430,11 +4430,11 @@ static void define_arm_vh_e2h_redirects_aliases(ARMCPU *cpu)
 
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
@@ -4458,13 +4458,13 @@ static void define_arm_vh_e2h_redirects_aliases(ARMCPU *cpu)
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
 
         { K(3, 0,  1, 2, 0), K(3, 4,  1, 2, 0), K(3, 5, 1, 2, 0),
           "ZCR_EL1", "ZCR_EL2", "ZCR_EL12", isar_feature_aa64_sve },
@@ -7098,7 +7098,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
 
     if (arm_feature(env, ARM_FEATURE_VBAR)) {
         static const ARMCPRegInfo vbar_cp_reginfo[] = {
-            { .name = "VBAR", .state = ARM_CP_STATE_BOTH,
+            { .name = "VBAR_EL1", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .crn = 12, .crm = 0, .opc1 = 0, .opc2 = 0,
               .access = PL1_RW, .writefn = vbar_write,
               .accessfn = access_nv1,
@@ -7114,7 +7114,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
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


