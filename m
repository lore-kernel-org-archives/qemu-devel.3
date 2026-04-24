Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEBB8FB44A4
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 04:34:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wG8Cr-0000Az-Ep; Fri, 24 Apr 2026 00:31:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wG8CQ-00076M-FF
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 00:31:36 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wG8CO-0002qI-0H
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 00:31:29 -0400
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7dbca22dbfeso3257300a34.1
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 21:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777005087; x=1777609887; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZMD0VgSvOctoffSNQ7zz1Fm9S+qkzJ2gc0NItSVQ7FU=;
 b=NLHHiaZgZVkm5d+r877KncwaI0kxf9LGxRpdmpIGnC9ym3XLeo6oWyJlESvny9m5Hh
 9I+QB82Tq0QldNz/9JceRzz2UFUaauXH291MaXB/CR9Lic3AfdoejCmCjcqgWW35hKnL
 lCIy3R9CCthnpL1WisBmSA9ZS/9wXF5vmNTCJsrivg3gj9Atm51F9qH8WQ60dmrp13bc
 /+4qs40915XcjYbc6zTCN1TbdpEz5/myzAJUMNniTNm79G7aerrnkAili7u6lEyDkQ+h
 2bVnF0unMMU9la1akFzzFdrgurD4gQjj13AdQDkzNCNbS7FNBAQ7eBenuBLHfQ+m1Ga+
 XjqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777005087; x=1777609887;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZMD0VgSvOctoffSNQ7zz1Fm9S+qkzJ2gc0NItSVQ7FU=;
 b=AD5JUPKqVrM7TwEq4CskxlZpcoohJz82fFzG82ngYID183Pt/3ZMlDC2CARZjzPC2G
 7ZphoyIP7ly4+8hCWIjJiS2kxBzYXWKKBJDw2fJSW6guL3MdwRfQKkAtv+iKpJYOhxq+
 GPlj58U1lTIsJ47CZNcWfrx6BkilUSz7hzCeQ74HKCH8YH7jBFGWELGccfzG1rFuObls
 Z9ugSXrKmMCjEwy8FzZTQD3y0kjzUln5He+ierNbgeV02+zg5o4Ci0phl4itUbp9I6hr
 TytHfQaEvA2ndJ2E7wJ+3f16Omw7jhRMyg6aN9eVUTUAoG7nTnrzlz0RSNzpeFX98382
 W5Zg==
X-Gm-Message-State: AOJu0YxIADJXWrYPLY3ObFWANZN0LvypIgMM/fqi584nLRJAm3rbgk1x
 bFMDXuCydpuCwnDhorZe6bLv9lv9ix94Vgz5MRzSBwMtaUPju0oZ8cCEy3e1DcfXNPzQ/TbIA2K
 CvVd3/Xg=
X-Gm-Gg: AeBDieuutm8mcd3Xlckid/nBCygV/7bLIld5P+yjPdSbBsQtLItu/4Ge9YNWXwQl8b5
 /Jori+lWH2YszjGv8Aik+xPrFZEI+riHhrm8UWc8CmgXUXrQR7RArRdI6vyc6Tpf6+lQhh+9Qex
 I/dXJwmMKuc9nKUH4x0223y4nCqaFjS1dgzKyL1n1rJC6qYyMiS+332fVMtOkL5UQHxVRPRc7P2
 /4mdud3cvsAB1aDD/PZD3ydLp/2/9Gj59T7NraR+uVD1mdZoqdSS08PVCYa++CwflDyCSw9l3Yh
 /h27s+Mp5J/V5Ju7fWQUqzYN7U6mniUksJIMAJrrWM0ajrArecrOBesXiSRrD3jxlsVJgmrpdRd
 dbC5qQm22XzNsF7HU3a3zxSf+a1F/0FUvQ6Jin6rJjp/kH6pLmu+hnfaec0HCIaJ77pK03CU8P1
 ONc+Ja6NeIgd9T8771dN9AKPAAcANdtdjGbWpxxJo2zJAtACyaW2aZih0DOhtQXQ==
X-Received: by 2002:a05:6820:2002:b0:694:9175:9d47 with SMTP id
 006d021491bc7-6949175acafmr10033325eaf.18.1777005086461; 
 Thu, 23 Apr 2026 21:31:26 -0700 (PDT)
Received: from stoup.. ([172.58.183.19]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42b9ac54ec5sm18880864fac.13.2026.04.23.21.31.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 21:31:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 15/40] target/arm: Implement ID_AA64FPFR0
Date: Fri, 24 Apr 2026 14:29:49 +1000
Message-ID: <20260424043014.46305-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260424043014.46305-1-richard.henderson@linaro.org>
References: <20260424043014.46305-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32f;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32f.google.com
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
 target/arm/cpu-features.h    |  9 +++++++++
 target/arm/helper.c          | 13 +++++++++++--
 target/arm/cpu-sysregs.h.inc |  1 +
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index ddef6fbeb0..df070afdbf 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -401,6 +401,15 @@ FIELD(ID_AA64SMFR0, I16I64, 52, 4)
 FIELD(ID_AA64SMFR0, SMEVER, 56, 4)
 FIELD(ID_AA64SMFR0, FA64, 63, 1)
 
+FIELD(ID_AA64FPFR0, F8E5M2, 0, 1)
+FIELD(ID_AA64FPFR0, F8E4M3, 1, 1)
+FIELD(ID_AA64FPFR0, F8MM4, 26, 1)
+FIELD(ID_AA64FPFR0, F8MM8, 27, 1)
+FIELD(ID_AA64FPFR0, F8DP2, 28, 1)
+FIELD(ID_AA64FPFR0, F8DP4, 29, 1)
+FIELD(ID_AA64FPFR0, F8FMA, 30, 1)
+FIELD(ID_AA64FPFR0, F8CVT, 31, 1)
+
 FIELD(ID_DFR0, COPDBG, 0, 4)
 FIELD(ID_DFR0, COPSDBG, 4, 4)
 FIELD(ID_DFR0, MMAPDBG, 8, 4)
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 6ebd121050..f0f00c6eff 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6510,11 +6510,11 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_tid3,
               .resetvalue = 0 },
-            { .name = "ID_AA64PFR7_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
+            { .name = "ID_AA64FPFR0_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 4, .opc2 = 7,
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_tid3,
-              .resetvalue = 0 },
+              .resetvalue = GET_IDREG(isar, ID_AA64FPFR0) },
             { .name = "ID_AA64DFR0_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 5, .opc2 = 0,
               .access = PL1_R, .type = ARM_CP_CONST,
@@ -6745,6 +6745,15 @@ void register_cp_regs_for_features(ARMCPU *cpu)
                                R_ID_AA64SMFR0_I16I64_MASK |
                                R_ID_AA64SMFR0_SMEVER_MASK |
                                R_ID_AA64SMFR0_FA64_MASK },
+            { .name = "ID_AA64FPFR0_EL1",
+              .exported_bits = R_ID_AA64FPFR0_F8E5M2_MASK |
+                               R_ID_AA64FPFR0_F8E4M3_MASK |
+                               R_ID_AA64FPFR0_F8MM4_MASK |
+                               R_ID_AA64FPFR0_F8MM8_MASK |
+                               R_ID_AA64FPFR0_F8DP2_MASK |
+                               R_ID_AA64FPFR0_F8DP4_MASK |
+                               R_ID_AA64FPFR0_F8FMA_MASK |
+                               R_ID_AA64FPFR0_F8CVT_MASK },
             { .name = "ID_AA64MMFR0_EL1",
               .exported_bits = R_ID_AA64MMFR0_ECV_MASK,
               .fixed_bits = (0xfu << R_ID_AA64MMFR0_TGRAN64_SHIFT) |
diff --git a/target/arm/cpu-sysregs.h.inc b/target/arm/cpu-sysregs.h.inc
index b99579f773..6e8b335b8f 100644
--- a/target/arm/cpu-sysregs.h.inc
+++ b/target/arm/cpu-sysregs.h.inc
@@ -3,6 +3,7 @@ DEF(ID_AA64PFR0_EL1, 3, 0, 0, 4, 0)
 DEF(ID_AA64PFR1_EL1, 3, 0, 0, 4, 1)
 DEF(ID_AA64PFR2_EL1, 3, 0, 0, 4, 2)
 DEF(ID_AA64SMFR0_EL1, 3, 0, 0, 4, 5)
+DEF(ID_AA64FPFR0_EL1, 3, 0, 0, 4, 7)
 DEF(ID_AA64DFR0_EL1, 3, 0, 0, 5, 0)
 DEF(ID_AA64DFR1_EL1, 3, 0, 0, 5, 1)
 DEF(ID_AA64AFR0_EL1, 3, 0, 0, 5, 4)
-- 
2.43.0


