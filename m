Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C6CFCD4851
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2026 00:36:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOPPf-00080m-Vl; Sat, 16 May 2026 20:31:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOPOp-0007FS-47
 for qemu-devel@nongnu.org; Sat, 16 May 2026 20:30:36 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOPOk-000524-DB
 for qemu-devel@nongnu.org; Sat, 16 May 2026 20:30:30 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-8383fb7143aso435438b3a.3
 for <qemu-devel@nongnu.org>; Sat, 16 May 2026 17:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778977821; x=1779582621; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mGCvxGAP+SJVq2oNHJQ8ObdWRbCOzKV7LFFW7Nyer9U=;
 b=xrMjDetp/OyPYkJwl0iin6c4njiuNGR5ZM4/FKXpF7Er9BUyFiLsLkfNYNEgT0p/iO
 X57gfCdof4uU12N/w1eruUr4ckVaLel46eK+L9MmfEl0BZjeboy3RSfl9K0hLFPIZdIu
 LXicPDUfcmlymlyAGLA7fvxW7rZ7s/S90/9bLXzP1quZ/qaxCYVsebUFbkO8RxRiv1+J
 yNvuvvgxo9EYEi8EBzwXJg+izQI1whUQ9KSNw1v5mEUn78l8r5sCeIJ4MrBBSn+JcXsz
 xVAfkzra0oH7mrq2foO4zxYfbMTbJbyQVp+R/QUFppb6vFt0fmE2SPtJaikmfha/iphA
 A3dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778977821; x=1779582621;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mGCvxGAP+SJVq2oNHJQ8ObdWRbCOzKV7LFFW7Nyer9U=;
 b=Dp2qO7NLZrpsXIcZiPTWP3RmcJECUA28bLMGzyeLh4dhJSU0KrQ6sT6Gl38yP286Xv
 XgbPB9iXcaHjWsFfck7rll8SyEcqRaRdCWwFEooUfQj7cWv/lC3yQWrpNeeAxc5WJCYw
 ciM56SU0jbSeoB25+XzMQ2l3+lW1gS6ODHfAUZg03iGAgH0BmaZZWnU3/R6jswNkljmB
 Q2pz1q9r/EqLCqe2V8lq95DayS3vfMfvFsGoriBMiQXJCUOxYxUv2lpYVbRVl0y4rnsz
 oFkyIWxMUTk/PyACzHcgr5uPLaN6RXQqoPPFefJ4ONSqeSC9XksKrtTQMUrZJDFCwT55
 qJIg==
X-Gm-Message-State: AOJu0YzIkdL9oEFTK0nPw8WznkcG1g0yaNWVGr+zrSmP5JAtSvDGoCLH
 NosLWIPrBYD9tc5Yhtz/Oe6HvE2zM9D6lGRCDVXdGw3avc5l+iulz3dNUHlTP4WJsMBnAyXtxB3
 cz5sz
X-Gm-Gg: Acq92OHTlmWvWF76sEcXWJq9+TMR0bXpX3I9/9cQT/tXeddBXwgIKL5OTnuEQUhCBzp
 b6Rtot9OPg/ez+5L3ieyEK4Zke7neKnZzN9p6TXnD89v/8BnGqwbAGj+sYvqseozuyRccKcw77L
 cGOIiQHCYBhToUqxJMYuZOO9Zo65by8HhLXTOThavUxL9A8N8qxulJfWFksVxmECLtlQocvnsxY
 +P6uJYL7a/kbiixe/n+6ZQErvCJvJ5hl88RbB+DvT1fV35J3XByt0yXCFFdGDBgFvWIwCSOzAOr
 6NXJWV7MNtJNcUA4AQfpLtxqXHTeEJ6nLcMV86KqVvxDpGx6FZTLcfwSK7yO12TiWP5UyBuACXy
 /tbNry7jPxqJQAxXrYS0Wx7YBS4m0LFzIwtI6zf/TB1iCxzUW8e1YkHgS4JtzXEiBExIl6ngLak
 CGDlHpK0Qm1vKgxR/UbBEeMTauNxj4
X-Received: by 2002:a05:6a00:ab0d:b0:839:e27c:6cce with SMTP id
 d2e1a72fcca58-83f33d97d9amr9329893b3a.37.1778977819186; 
 Sat, 16 May 2026 17:30:19 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83f19663cfdsm12272745b3a.9.2026.05.16.17.30.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 May 2026 17:30:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v5 17/63] target/arm: Implement ID_AA64FPFR0
Date: Sat, 16 May 2026 17:29:16 -0700
Message-ID: <20260517003002.321430-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260517003002.321430-1-richard.henderson@linaro.org>
References: <20260517003002.321430-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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
index e13c1c1331..1bb77d78da 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -410,6 +410,15 @@ FIELD(ID_AA64SMFR0, I16I64, 52, 4)
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
index 3d6e7f1ccc..34487eeaa3 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6477,11 +6477,11 @@ void register_cp_regs_for_features(ARMCPU *cpu)
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
@@ -6712,6 +6712,15 @@ void register_cp_regs_for_features(ARMCPU *cpu)
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


