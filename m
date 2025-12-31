Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68733EE645E
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Dec 2025 17:11:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vazhH-0002bE-Bk; Wed, 31 Dec 2025 12:09:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vazhB-0002Xc-An
 for qemu-devel@nongnu.org; Wed, 31 Dec 2025 12:09:14 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vazh5-0000ZK-Eq
 for qemu-devel@nongnu.org; Wed, 31 Dec 2025 12:09:12 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-42fb5810d39so6879226f8f.2
 for <qemu-devel@nongnu.org>; Wed, 31 Dec 2025 09:09:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767200943; x=1767805743; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=faxhufLw/EIG5Ph8lvEbPCvkCLmmsEhf639jzh+lM9I=;
 b=AUUDt5Z4pBP/n90KjE/vcSF7QMQtfRzV/NGMquWcrIIFXRB/IUePdMugA0ssOsOCJI
 duwmInoSvk4V/QP1l5mIqpvt4sqzzlXa6LYDiG4kwoDjDWCMEdmMFsXlSSxHPrgd0TqR
 QVskrLJuXSV3JqIX0LYkku1q8IC+cdJmAvwxlX5SJtPxjvY1XiDciGxE/xSGCaRr20fw
 ATSMGZKXNyzAKHpzfEfskZEOKAMF6PIPPxhiiHDMRTrgoVANY7EQxzlg23HXpCw4rfZG
 a3OH9EltI2xG4z9GNZ/9hNgYTi7VJjJxSWeMOOBtzQu8aejfFg4uZKvzLC0BfDCdp+ZR
 bN0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767200943; x=1767805743;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=faxhufLw/EIG5Ph8lvEbPCvkCLmmsEhf639jzh+lM9I=;
 b=re9L2WHJm0aJH2fg6aJYizeBt3OUGADczWsGRAqpiIbUkr4NsommtWIK73jOVv2x/2
 XaDqAGHe5V2p9dwjitrluLMpSD8hXunBi96SQw7CcWBhHYsweR24jnaR4kO9257fqEAw
 O47tOA1/5col2oN0cgRJKJpIdngaIGb//bIa02oWWG7bKWAAwBYge6fcNWnjzeHQNKdZ
 0fkdaYzPapWKplqiDt9dc5OUQm3PFPhWhtViEkeVooWOezLihNNhWR7v79yzLpXWmT82
 ghFDTFQc0bLiG79DXKHuByYIRE/PFgY0iXzFv92sRJ0BOy8O4ddgiGT+6hi1iETFqnKH
 ajWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+z0Z3u2uqlSxwHZHaqTEP5xZHuFxWx7LyoYBST1D6uqNyEcZCWnI2cJDGBEnD+RAX5F/SqqV1qEoa@nongnu.org
X-Gm-Message-State: AOJu0YxWoKUZh95Q6yA+3eZsyQdg25RSxSsyiCMgrZLvCRkS52c6EfeS
 +JKFMo3kT7xTe8YWGZYr6rSAE8WT9PJqyiZxAPTq2rFvgo6cP6nq7pU8dp4ttfQHDaM=
X-Gm-Gg: AY/fxX6+Kw8iot/OqbbMU/zyg9CwahGLlYQ0zOklWn1aF5t96j4iRHG+TD33dv2uxEz
 Al7lPRgvCeNWbJ2VfANjCs9PYEpWY7vD5QfcW7SP5JRhUmimmCq5c0Y/4XPqvNqRHt8ah+W8Ldn
 FwjhiqZeKK5mAhBrRR782NQfHNzGeoxjW0D/UAPH9s4KiQXsw6HboiKpHdT8z0CeGzKiDDbZUS2
 RMXFaa/p4N8dGbRRyZY2PxDeKOEGY4I9CM4FeikKNEtrDlhmcBCKWQr7IbPNgxmMRHaPMG4tk9/
 ZsNTS8I6D9hkGZPJ0qVnxEI7LN48dd7bJL5uENy+2AFIks24SFCaQ2g7JXT3TtEXFS0cievpZ9A
 X1Py76FlyD7i4vZOEVL02KNeeNaZO5l6CooGeqtml9XrVq0E0oNpC2THfzBM50B32IQaTMr13u5
 xIwVMBDeOGOyQzfM9bGhXZRBfliORgf7xNuqxJHTDi4kxRWa/jmc5NlW4Bp7ni6Ju9IfC6p6uYh
 PLWFeZJzwB04wnJa1N12wNGEbcUFmqG6QAKzM+KzvBmGg==
X-Google-Smtp-Source: AGHT+IGVSVrvMOLQ+ITS353Z2MIs7pQPiWP+RahxI1tDpsL409+UZGMkoGrghgVPbRnsvsRqZGcAsA==
X-Received: by 2002:a5d:5392:0:b0:42f:edb6:3642 with SMTP id
 ffacd0b85a97d-4324e704c03mr37383761f8f.60.1767200942921; 
 Wed, 31 Dec 2025 09:09:02 -0800 (PST)
Received: from mnementh.archaic.org.uk
 (f.7.f.1.7.5.e.f.f.f.c.5.d.8.2.4.0.0.0.0.0.d.1.0.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:1d0:0:428d:5cff:fe57:1f7f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eaa64cesm75208990f8f.35.2025.12.31.09.09.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Dec 2025 09:09:02 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
Subject: [PATCH 3/4] target/arm: Correctly trap HCR.TID1 registers in v7A
Date: Wed, 31 Dec 2025 17:08:57 +0000
Message-ID: <20251231170858.254594-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251231170858.254594-1-peter.maydell@linaro.org>
References: <20251231170858.254594-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
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

In v7A HCR.TID1 is defined to trap for TCMTR, TLBTR, REVIDR and AIDR.
We incorrectly use an accessfn for REVIDR and AIDR that only traps on
v8A cores.  Fix this by collapsing access_aa64_tid1() and
access_aa32_tid1() together and never doing a check for v8 vs v7.

The accessfn is also used for SMIDR_EL1, which is fine as this
register is AArch64 only.

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index c4f73eb3f3..0896e90965 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -924,8 +924,8 @@ static uint64_t isr_read(CPUARMState *env, const ARMCPRegInfo *ri)
     return ret;
 }
 
-static CPAccessResult access_aa64_tid1(CPUARMState *env, const ARMCPRegInfo *ri,
-                                       bool isread)
+static CPAccessResult access_tid1(CPUARMState *env, const ARMCPRegInfo *ri,
+                                  bool isread)
 {
     if (arm_current_el(env) == 1 && (arm_hcr_el2_eff(env) & HCR_TID1)) {
         return CP_ACCESS_TRAP_EL2;
@@ -934,16 +934,6 @@ static CPAccessResult access_aa64_tid1(CPUARMState *env, const ARMCPRegInfo *ri,
     return CP_ACCESS_OK;
 }
 
-static CPAccessResult access_aa32_tid1(CPUARMState *env, const ARMCPRegInfo *ri,
-                                       bool isread)
-{
-    if (arm_feature(env, ARM_FEATURE_V8)) {
-        return access_aa64_tid1(env, ri, isread);
-    }
-
-    return CP_ACCESS_OK;
-}
-
 static const ARMCPRegInfo v7_cp_reginfo[] = {
     /* the old v6 WFI, UNPREDICTABLE in v7 but we choose to NOP */
     { .name = "NOP", .cp = 15, .crn = 7, .crm = 0, .opc1 = 0, .opc2 = 4,
@@ -969,7 +959,7 @@ static const ARMCPRegInfo v7_cp_reginfo[] = {
     { .name = "AIDR", .state = ARM_CP_STATE_BOTH,
       .opc0 = 3, .opc1 = 1, .crn = 0, .crm = 0, .opc2 = 7,
       .access = PL1_R, .type = ARM_CP_CONST,
-      .accessfn = access_aa64_tid1,
+      .accessfn = access_tid1,
       .fgt = FGT_AIDR_EL1,
       .resetvalue = 0 },
     /*
@@ -4997,7 +4987,7 @@ static const ARMCPRegInfo sme_reginfo[] = {
       .writefn = smcr_write, .raw_writefn = raw_write },
     { .name = "SMIDR_EL1", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 1, .crn = 0, .crm = 0, .opc2 = 6,
-      .access = PL1_R, .accessfn = access_aa64_tid1,
+      .access = PL1_R, .accessfn = access_tid1,
       /*
        * IMPLEMENTOR = 0 (software)
        * REVISION    = 0 (implementation defined)
@@ -7094,7 +7084,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
             { .name = "REVIDR_EL1", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 0, .opc2 = 6,
               .access = PL1_R,
-              .accessfn = access_aa64_tid1,
+              .accessfn = access_tid1,
               .fgt = FGT_REVIDR_EL1,
               .type = ARM_CP_CONST, .resetvalue = cpu->revidr },
         };
@@ -7118,7 +7108,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
             { .name = "TCMTR",
               .cp = 15, .crn = 0, .crm = 0, .opc1 = 0, .opc2 = 2,
               .access = PL1_R,
-              .accessfn = access_aa32_tid1,
+              .accessfn = access_tid1,
               .type = ARM_CP_CONST, .resetvalue = 0 },
         };
         /* TLBTR is specific to VMSA */
@@ -7126,7 +7116,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .name = "TLBTR",
               .cp = 15, .crn = 0, .crm = 0, .opc1 = 0, .opc2 = 3,
               .access = PL1_R,
-              .accessfn = access_aa32_tid1,
+              .accessfn = access_tid1,
               .type = ARM_CP_CONST, .resetvalue = 0,
         };
         /* MPUIR is specific to PMSA V6+ */
-- 
2.47.3


