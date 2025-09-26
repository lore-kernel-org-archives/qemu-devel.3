Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AE00CAC5B9
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 14:11:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v298S-0007FD-59; Fri, 26 Sep 2025 10:09:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v298I-0007AF-IW
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:09:10 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v2988-0005de-MW
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:09:10 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3f99ac9acc4so1874663f8f.3
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 07:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758895733; x=1759500533; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=R7sYGUIrEqXggeK17PbOJ3HwiSLwWiLs/Tkhv2YZqIw=;
 b=rA9vI3RhVA3YRLvmquks++A9TbA/nh6heMrqBpy/WN9juVRuj0/NWMYeRPY9OGZNIq
 VxcxcdJAEd0u8WAdQQ32g93q3R2zZFi9bCoT9vHj3UGSlTcPWBLgvI6WJ9i2CoSGBZoY
 3rX3UzA6euHUqdGofm9dcxLZyJTWVClgJ3IqqOJcgKWh//ljW/h1eejGWiQ3LVe9jO55
 QLbjaMlIUn0dZwRFuHIW4Fmg1hdSwwyHyVZ47nRuTevCM020PlLB20js7o1FYuTxg1Hp
 jbE/eilAnmQnhD4f9+0gjpzsGKfxIgZwDP4igT2yK0jPtX5lbWQCROw6sTzn8CG7bGG7
 eJbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758895733; x=1759500533;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R7sYGUIrEqXggeK17PbOJ3HwiSLwWiLs/Tkhv2YZqIw=;
 b=Jti/U9ad+5I9+Re29ogUYINSFtccwxuu/jRmvgAY7HE3biq+JSHvGltOqon/4Hd3tV
 tUjFsr+DmpTq84Qio/69ArjUCaN59XwC2aAQzrrgEmOzfvho8iWPrzAD/7sFAuEj78zW
 nyWW3kCRPON/SkEN/rtdh8oVNBeHfV1MFId3kXMkzmA5FqfcjLWAzJKEnDfAVh3LisE0
 ML+3FgNP07hdXDO9EPNzcffzXurz59nunXAhUzlW//E8WWLpx7kxTynmxYNiDXdUKaCl
 GvfObtFv2QHm65fC3+T28+QZWJRka9PNg6SxfdUml5VAlAeW9XoG1JuF+zkSubflA0/r
 q15A==
X-Gm-Message-State: AOJu0Yyug8DGKrGnGnStki2aV8lrZc1gJpm1imZX6OT7bg3yzz2zAt9w
 VxkEso/V4IhzBCqGXGVFrWswM0kxLFkMa6frn2vvUS0q8OXEjWCAH+/bt4pzOgS62QogCLBMJQ4
 yEjbU
X-Gm-Gg: ASbGncuc8B9F82AlsZw3CZwNE+HxGk7PJ/2l8D7OzkHaT/SNyuvgRMK/7kXv/VWFRQg
 4yQYNwRkb7JJ4dQv7c5U35aAuwxa6mNurCnq7JDj5tZR74OxxWN/y7WoOT9l5ow5mlwr7YOGJRW
 GqQ0uSPbJH+m+Ldk0hkXCbEwmiZV8dhKVQbPS3jHhD2oKnI6TISkbZSNLRDBbXacaW7Qc3TL1Bc
 BTkVzye2nmxem0KyL9Iue78+/1j9BLPR/mdiK+CUmKF/VO9obYuAqSsLHEHJPKJ/D6Zts0K1jkI
 BI9HbZtDiqVX2e0/hYP5SoVhoLewUV/XCCwbTFuUSE+PwZZIpYlbBLV5Y62ITlLM0CEryWoSXbk
 7wcaIMBPqyiR/1LYpuaY81Fjr7Ql1gkT4xrInFn8=
X-Google-Smtp-Source: AGHT+IGy+VsjYMDrsWEYSQwhGk6P1XCRWbz/RD3mjqAgM9xQBG8G1SH2j9oItAFHLguQvJf6KC2YIA==
X-Received: by 2002:a05:6000:220b:b0:3ec:df2b:14c8 with SMTP id
 ffacd0b85a97d-40e4458ce98mr7203647f8f.20.1758895732465; 
 Fri, 26 Sep 2025 07:08:52 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-410f2007372sm6338315f8f.16.2025.09.26.07.08.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 07:08:51 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/44] target/arm/hvf: Split out sysreg.c.inc
Date: Fri, 26 Sep 2025 15:08:05 +0100
Message-ID: <20250926140844.1493020-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250926140844.1493020-1-peter.maydell@linaro.org>
References: <20250926140844.1493020-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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

Move the list of supported sysregs to a reuseable file.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/hvf/hvf.c        | 147 ++----------------------------------
 target/arm/hvf/sysreg.c.inc | 146 +++++++++++++++++++++++++++++++++++
 2 files changed, 152 insertions(+), 141 deletions(-)
 create mode 100644 target/arm/hvf/sysreg.c.inc

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index b77db99079e..9f8e3083b4f 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -403,150 +403,15 @@ struct hvf_sreg_match {
     uint32_t cp_idx;
 };
 
+#define DEF_SYSREG(HVF_ID, crn, crm, op0, op1, op2) \
+    { HVF_ID, HVF_SYSREG(crn, crm, op0, op1, op2) },
+
 static struct hvf_sreg_match hvf_sreg_match[] = {
-    { HV_SYS_REG_DBGBVR0_EL1, HVF_SYSREG(0, 0, 2, 0, 4) },
-    { HV_SYS_REG_DBGBCR0_EL1, HVF_SYSREG(0, 0, 2, 0, 5) },
-    { HV_SYS_REG_DBGWVR0_EL1, HVF_SYSREG(0, 0, 2, 0, 6) },
-    { HV_SYS_REG_DBGWCR0_EL1, HVF_SYSREG(0, 0, 2, 0, 7) },
-
-    { HV_SYS_REG_DBGBVR1_EL1, HVF_SYSREG(0, 1, 2, 0, 4) },
-    { HV_SYS_REG_DBGBCR1_EL1, HVF_SYSREG(0, 1, 2, 0, 5) },
-    { HV_SYS_REG_DBGWVR1_EL1, HVF_SYSREG(0, 1, 2, 0, 6) },
-    { HV_SYS_REG_DBGWCR1_EL1, HVF_SYSREG(0, 1, 2, 0, 7) },
-
-    { HV_SYS_REG_DBGBVR2_EL1, HVF_SYSREG(0, 2, 2, 0, 4) },
-    { HV_SYS_REG_DBGBCR2_EL1, HVF_SYSREG(0, 2, 2, 0, 5) },
-    { HV_SYS_REG_DBGWVR2_EL1, HVF_SYSREG(0, 2, 2, 0, 6) },
-    { HV_SYS_REG_DBGWCR2_EL1, HVF_SYSREG(0, 2, 2, 0, 7) },
-
-    { HV_SYS_REG_DBGBVR3_EL1, HVF_SYSREG(0, 3, 2, 0, 4) },
-    { HV_SYS_REG_DBGBCR3_EL1, HVF_SYSREG(0, 3, 2, 0, 5) },
-    { HV_SYS_REG_DBGWVR3_EL1, HVF_SYSREG(0, 3, 2, 0, 6) },
-    { HV_SYS_REG_DBGWCR3_EL1, HVF_SYSREG(0, 3, 2, 0, 7) },
-
-    { HV_SYS_REG_DBGBVR4_EL1, HVF_SYSREG(0, 4, 2, 0, 4) },
-    { HV_SYS_REG_DBGBCR4_EL1, HVF_SYSREG(0, 4, 2, 0, 5) },
-    { HV_SYS_REG_DBGWVR4_EL1, HVF_SYSREG(0, 4, 2, 0, 6) },
-    { HV_SYS_REG_DBGWCR4_EL1, HVF_SYSREG(0, 4, 2, 0, 7) },
-
-    { HV_SYS_REG_DBGBVR5_EL1, HVF_SYSREG(0, 5, 2, 0, 4) },
-    { HV_SYS_REG_DBGBCR5_EL1, HVF_SYSREG(0, 5, 2, 0, 5) },
-    { HV_SYS_REG_DBGWVR5_EL1, HVF_SYSREG(0, 5, 2, 0, 6) },
-    { HV_SYS_REG_DBGWCR5_EL1, HVF_SYSREG(0, 5, 2, 0, 7) },
-
-    { HV_SYS_REG_DBGBVR6_EL1, HVF_SYSREG(0, 6, 2, 0, 4) },
-    { HV_SYS_REG_DBGBCR6_EL1, HVF_SYSREG(0, 6, 2, 0, 5) },
-    { HV_SYS_REG_DBGWVR6_EL1, HVF_SYSREG(0, 6, 2, 0, 6) },
-    { HV_SYS_REG_DBGWCR6_EL1, HVF_SYSREG(0, 6, 2, 0, 7) },
-
-    { HV_SYS_REG_DBGBVR7_EL1, HVF_SYSREG(0, 7, 2, 0, 4) },
-    { HV_SYS_REG_DBGBCR7_EL1, HVF_SYSREG(0, 7, 2, 0, 5) },
-    { HV_SYS_REG_DBGWVR7_EL1, HVF_SYSREG(0, 7, 2, 0, 6) },
-    { HV_SYS_REG_DBGWCR7_EL1, HVF_SYSREG(0, 7, 2, 0, 7) },
-
-    { HV_SYS_REG_DBGBVR8_EL1, HVF_SYSREG(0, 8, 2, 0, 4) },
-    { HV_SYS_REG_DBGBCR8_EL1, HVF_SYSREG(0, 8, 2, 0, 5) },
-    { HV_SYS_REG_DBGWVR8_EL1, HVF_SYSREG(0, 8, 2, 0, 6) },
-    { HV_SYS_REG_DBGWCR8_EL1, HVF_SYSREG(0, 8, 2, 0, 7) },
-
-    { HV_SYS_REG_DBGBVR9_EL1, HVF_SYSREG(0, 9, 2, 0, 4) },
-    { HV_SYS_REG_DBGBCR9_EL1, HVF_SYSREG(0, 9, 2, 0, 5) },
-    { HV_SYS_REG_DBGWVR9_EL1, HVF_SYSREG(0, 9, 2, 0, 6) },
-    { HV_SYS_REG_DBGWCR9_EL1, HVF_SYSREG(0, 9, 2, 0, 7) },
-
-    { HV_SYS_REG_DBGBVR10_EL1, HVF_SYSREG(0, 10, 2, 0, 4) },
-    { HV_SYS_REG_DBGBCR10_EL1, HVF_SYSREG(0, 10, 2, 0, 5) },
-    { HV_SYS_REG_DBGWVR10_EL1, HVF_SYSREG(0, 10, 2, 0, 6) },
-    { HV_SYS_REG_DBGWCR10_EL1, HVF_SYSREG(0, 10, 2, 0, 7) },
-
-    { HV_SYS_REG_DBGBVR11_EL1, HVF_SYSREG(0, 11, 2, 0, 4) },
-    { HV_SYS_REG_DBGBCR11_EL1, HVF_SYSREG(0, 11, 2, 0, 5) },
-    { HV_SYS_REG_DBGWVR11_EL1, HVF_SYSREG(0, 11, 2, 0, 6) },
-    { HV_SYS_REG_DBGWCR11_EL1, HVF_SYSREG(0, 11, 2, 0, 7) },
-
-    { HV_SYS_REG_DBGBVR12_EL1, HVF_SYSREG(0, 12, 2, 0, 4) },
-    { HV_SYS_REG_DBGBCR12_EL1, HVF_SYSREG(0, 12, 2, 0, 5) },
-    { HV_SYS_REG_DBGWVR12_EL1, HVF_SYSREG(0, 12, 2, 0, 6) },
-    { HV_SYS_REG_DBGWCR12_EL1, HVF_SYSREG(0, 12, 2, 0, 7) },
-
-    { HV_SYS_REG_DBGBVR13_EL1, HVF_SYSREG(0, 13, 2, 0, 4) },
-    { HV_SYS_REG_DBGBCR13_EL1, HVF_SYSREG(0, 13, 2, 0, 5) },
-    { HV_SYS_REG_DBGWVR13_EL1, HVF_SYSREG(0, 13, 2, 0, 6) },
-    { HV_SYS_REG_DBGWCR13_EL1, HVF_SYSREG(0, 13, 2, 0, 7) },
-
-    { HV_SYS_REG_DBGBVR14_EL1, HVF_SYSREG(0, 14, 2, 0, 4) },
-    { HV_SYS_REG_DBGBCR14_EL1, HVF_SYSREG(0, 14, 2, 0, 5) },
-    { HV_SYS_REG_DBGWVR14_EL1, HVF_SYSREG(0, 14, 2, 0, 6) },
-    { HV_SYS_REG_DBGWCR14_EL1, HVF_SYSREG(0, 14, 2, 0, 7) },
-
-    { HV_SYS_REG_DBGBVR15_EL1, HVF_SYSREG(0, 15, 2, 0, 4) },
-    { HV_SYS_REG_DBGBCR15_EL1, HVF_SYSREG(0, 15, 2, 0, 5) },
-    { HV_SYS_REG_DBGWVR15_EL1, HVF_SYSREG(0, 15, 2, 0, 6) },
-    { HV_SYS_REG_DBGWCR15_EL1, HVF_SYSREG(0, 15, 2, 0, 7) },
-
-#ifdef SYNC_NO_RAW_REGS
-    /*
-     * The registers below are manually synced on init because they are
-     * marked as NO_RAW. We still list them to make number space sync easier.
-     */
-    { HV_SYS_REG_MDCCINT_EL1, HVF_SYSREG(0, 2, 2, 0, 0) },
-    { HV_SYS_REG_MIDR_EL1, HVF_SYSREG(0, 0, 3, 0, 0) },
-    { HV_SYS_REG_MPIDR_EL1, HVF_SYSREG(0, 0, 3, 0, 5) },
-    { HV_SYS_REG_ID_AA64PFR0_EL1, HVF_SYSREG(0, 4, 3, 0, 0) },
-#endif
-    { HV_SYS_REG_ID_AA64PFR1_EL1, HVF_SYSREG(0, 4, 3, 0, 1) },
-    { HV_SYS_REG_ID_AA64DFR0_EL1, HVF_SYSREG(0, 5, 3, 0, 0) },
-    { HV_SYS_REG_ID_AA64DFR1_EL1, HVF_SYSREG(0, 5, 3, 0, 1) },
-    { HV_SYS_REG_ID_AA64ISAR0_EL1, HVF_SYSREG(0, 6, 3, 0, 0) },
-    { HV_SYS_REG_ID_AA64ISAR1_EL1, HVF_SYSREG(0, 6, 3, 0, 1) },
-#ifdef SYNC_NO_MMFR0
-    /* We keep the hardware MMFR0 around. HW limits are there anyway */
-    { HV_SYS_REG_ID_AA64MMFR0_EL1, HVF_SYSREG(0, 7, 3, 0, 0) },
-#endif
-    { HV_SYS_REG_ID_AA64MMFR1_EL1, HVF_SYSREG(0, 7, 3, 0, 1) },
-    { HV_SYS_REG_ID_AA64MMFR2_EL1, HVF_SYSREG(0, 7, 3, 0, 2) },
-    /* Add ID_AA64MMFR3_EL1 here when HVF supports it */
-
-    { HV_SYS_REG_MDSCR_EL1, HVF_SYSREG(0, 2, 2, 0, 2) },
-    { HV_SYS_REG_SCTLR_EL1, HVF_SYSREG(1, 0, 3, 0, 0) },
-    { HV_SYS_REG_CPACR_EL1, HVF_SYSREG(1, 0, 3, 0, 2) },
-    { HV_SYS_REG_TTBR0_EL1, HVF_SYSREG(2, 0, 3, 0, 0) },
-    { HV_SYS_REG_TTBR1_EL1, HVF_SYSREG(2, 0, 3, 0, 1) },
-    { HV_SYS_REG_TCR_EL1, HVF_SYSREG(2, 0, 3, 0, 2) },
-
-    { HV_SYS_REG_APIAKEYLO_EL1, HVF_SYSREG(2, 1, 3, 0, 0) },
-    { HV_SYS_REG_APIAKEYHI_EL1, HVF_SYSREG(2, 1, 3, 0, 1) },
-    { HV_SYS_REG_APIBKEYLO_EL1, HVF_SYSREG(2, 1, 3, 0, 2) },
-    { HV_SYS_REG_APIBKEYHI_EL1, HVF_SYSREG(2, 1, 3, 0, 3) },
-    { HV_SYS_REG_APDAKEYLO_EL1, HVF_SYSREG(2, 2, 3, 0, 0) },
-    { HV_SYS_REG_APDAKEYHI_EL1, HVF_SYSREG(2, 2, 3, 0, 1) },
-    { HV_SYS_REG_APDBKEYLO_EL1, HVF_SYSREG(2, 2, 3, 0, 2) },
-    { HV_SYS_REG_APDBKEYHI_EL1, HVF_SYSREG(2, 2, 3, 0, 3) },
-    { HV_SYS_REG_APGAKEYLO_EL1, HVF_SYSREG(2, 3, 3, 0, 0) },
-    { HV_SYS_REG_APGAKEYHI_EL1, HVF_SYSREG(2, 3, 3, 0, 1) },
-
-    { HV_SYS_REG_SPSR_EL1, HVF_SYSREG(4, 0, 3, 0, 0) },
-    { HV_SYS_REG_ELR_EL1, HVF_SYSREG(4, 0, 3, 0, 1) },
-    { HV_SYS_REG_SP_EL0, HVF_SYSREG(4, 1, 3, 0, 0) },
-    { HV_SYS_REG_AFSR0_EL1, HVF_SYSREG(5, 1, 3, 0, 0) },
-    { HV_SYS_REG_AFSR1_EL1, HVF_SYSREG(5, 1, 3, 0, 1) },
-    { HV_SYS_REG_ESR_EL1, HVF_SYSREG(5, 2, 3, 0, 0) },
-    { HV_SYS_REG_FAR_EL1, HVF_SYSREG(6, 0, 3, 0, 0) },
-    { HV_SYS_REG_PAR_EL1, HVF_SYSREG(7, 4, 3, 0, 0) },
-    { HV_SYS_REG_MAIR_EL1, HVF_SYSREG(10, 2, 3, 0, 0) },
-    { HV_SYS_REG_AMAIR_EL1, HVF_SYSREG(10, 3, 3, 0, 0) },
-    { HV_SYS_REG_VBAR_EL1, HVF_SYSREG(12, 0, 3, 0, 0) },
-    { HV_SYS_REG_CONTEXTIDR_EL1, HVF_SYSREG(13, 0, 3, 0, 1) },
-    { HV_SYS_REG_TPIDR_EL1, HVF_SYSREG(13, 0, 3, 0, 4) },
-    { HV_SYS_REG_CNTKCTL_EL1, HVF_SYSREG(14, 1, 3, 0, 0) },
-    { HV_SYS_REG_CSSELR_EL1, HVF_SYSREG(0, 0, 3, 2, 0) },
-    { HV_SYS_REG_TPIDR_EL0, HVF_SYSREG(13, 0, 3, 3, 2) },
-    { HV_SYS_REG_TPIDRRO_EL0, HVF_SYSREG(13, 0, 3, 3, 3) },
-    { HV_SYS_REG_CNTV_CTL_EL0, HVF_SYSREG(14, 3, 3, 3, 1) },
-    { HV_SYS_REG_CNTV_CVAL_EL0, HVF_SYSREG(14, 3, 3, 3, 2) },
-    { HV_SYS_REG_SP_EL1, HVF_SYSREG(4, 1, 3, 4, 0) },
+#include "sysreg.c.inc"
 };
 
+#undef DEF_SYSREG
+
 int hvf_get_registers(CPUState *cpu)
 {
     ARMCPU *arm_cpu = ARM_CPU(cpu);
diff --git a/target/arm/hvf/sysreg.c.inc b/target/arm/hvf/sysreg.c.inc
new file mode 100644
index 00000000000..222698f1d19
--- /dev/null
+++ b/target/arm/hvf/sysreg.c.inc
@@ -0,0 +1,146 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+DEF_SYSREG(HV_SYS_REG_DBGBVR0_EL1, 0, 0, 2, 0, 4)
+DEF_SYSREG(HV_SYS_REG_DBGBCR0_EL1, 0, 0, 2, 0, 5)
+DEF_SYSREG(HV_SYS_REG_DBGWVR0_EL1, 0, 0, 2, 0, 6)
+DEF_SYSREG(HV_SYS_REG_DBGWCR0_EL1, 0, 0, 2, 0, 7)
+
+DEF_SYSREG(HV_SYS_REG_DBGBVR1_EL1, 0, 1, 2, 0, 4)
+DEF_SYSREG(HV_SYS_REG_DBGBCR1_EL1, 0, 1, 2, 0, 5)
+DEF_SYSREG(HV_SYS_REG_DBGWVR1_EL1, 0, 1, 2, 0, 6)
+DEF_SYSREG(HV_SYS_REG_DBGWCR1_EL1, 0, 1, 2, 0, 7)
+
+DEF_SYSREG(HV_SYS_REG_DBGBVR2_EL1, 0, 2, 2, 0, 4)
+DEF_SYSREG(HV_SYS_REG_DBGBCR2_EL1, 0, 2, 2, 0, 5)
+DEF_SYSREG(HV_SYS_REG_DBGWVR2_EL1, 0, 2, 2, 0, 6)
+DEF_SYSREG(HV_SYS_REG_DBGWCR2_EL1, 0, 2, 2, 0, 7)
+
+DEF_SYSREG(HV_SYS_REG_DBGBVR3_EL1, 0, 3, 2, 0, 4)
+DEF_SYSREG(HV_SYS_REG_DBGBCR3_EL1, 0, 3, 2, 0, 5)
+DEF_SYSREG(HV_SYS_REG_DBGWVR3_EL1, 0, 3, 2, 0, 6)
+DEF_SYSREG(HV_SYS_REG_DBGWCR3_EL1, 0, 3, 2, 0, 7)
+
+DEF_SYSREG(HV_SYS_REG_DBGBVR4_EL1, 0, 4, 2, 0, 4)
+DEF_SYSREG(HV_SYS_REG_DBGBCR4_EL1, 0, 4, 2, 0, 5)
+DEF_SYSREG(HV_SYS_REG_DBGWVR4_EL1, 0, 4, 2, 0, 6)
+DEF_SYSREG(HV_SYS_REG_DBGWCR4_EL1, 0, 4, 2, 0, 7)
+
+DEF_SYSREG(HV_SYS_REG_DBGBVR5_EL1, 0, 5, 2, 0, 4)
+DEF_SYSREG(HV_SYS_REG_DBGBCR5_EL1, 0, 5, 2, 0, 5)
+DEF_SYSREG(HV_SYS_REG_DBGWVR5_EL1, 0, 5, 2, 0, 6)
+DEF_SYSREG(HV_SYS_REG_DBGWCR5_EL1, 0, 5, 2, 0, 7)
+
+DEF_SYSREG(HV_SYS_REG_DBGBVR6_EL1, 0, 6, 2, 0, 4)
+DEF_SYSREG(HV_SYS_REG_DBGBCR6_EL1, 0, 6, 2, 0, 5)
+DEF_SYSREG(HV_SYS_REG_DBGWVR6_EL1, 0, 6, 2, 0, 6)
+DEF_SYSREG(HV_SYS_REG_DBGWCR6_EL1, 0, 6, 2, 0, 7)
+
+DEF_SYSREG(HV_SYS_REG_DBGBVR7_EL1, 0, 7, 2, 0, 4)
+DEF_SYSREG(HV_SYS_REG_DBGBCR7_EL1, 0, 7, 2, 0, 5)
+DEF_SYSREG(HV_SYS_REG_DBGWVR7_EL1, 0, 7, 2, 0, 6)
+DEF_SYSREG(HV_SYS_REG_DBGWCR7_EL1, 0, 7, 2, 0, 7)
+
+DEF_SYSREG(HV_SYS_REG_DBGBVR8_EL1, 0, 8, 2, 0, 4)
+DEF_SYSREG(HV_SYS_REG_DBGBCR8_EL1, 0, 8, 2, 0, 5)
+DEF_SYSREG(HV_SYS_REG_DBGWVR8_EL1, 0, 8, 2, 0, 6)
+DEF_SYSREG(HV_SYS_REG_DBGWCR8_EL1, 0, 8, 2, 0, 7)
+
+DEF_SYSREG(HV_SYS_REG_DBGBVR9_EL1, 0, 9, 2, 0, 4)
+DEF_SYSREG(HV_SYS_REG_DBGBCR9_EL1, 0, 9, 2, 0, 5)
+DEF_SYSREG(HV_SYS_REG_DBGWVR9_EL1, 0, 9, 2, 0, 6)
+DEF_SYSREG(HV_SYS_REG_DBGWCR9_EL1, 0, 9, 2, 0, 7)
+
+DEF_SYSREG(HV_SYS_REG_DBGBVR10_EL1, 0, 10, 2, 0, 4)
+DEF_SYSREG(HV_SYS_REG_DBGBCR10_EL1, 0, 10, 2, 0, 5)
+DEF_SYSREG(HV_SYS_REG_DBGWVR10_EL1, 0, 10, 2, 0, 6)
+DEF_SYSREG(HV_SYS_REG_DBGWCR10_EL1, 0, 10, 2, 0, 7)
+
+DEF_SYSREG(HV_SYS_REG_DBGBVR11_EL1, 0, 11, 2, 0, 4)
+DEF_SYSREG(HV_SYS_REG_DBGBCR11_EL1, 0, 11, 2, 0, 5)
+DEF_SYSREG(HV_SYS_REG_DBGWVR11_EL1, 0, 11, 2, 0, 6)
+DEF_SYSREG(HV_SYS_REG_DBGWCR11_EL1, 0, 11, 2, 0, 7)
+
+DEF_SYSREG(HV_SYS_REG_DBGBVR12_EL1, 0, 12, 2, 0, 4)
+DEF_SYSREG(HV_SYS_REG_DBGBCR12_EL1, 0, 12, 2, 0, 5)
+DEF_SYSREG(HV_SYS_REG_DBGWVR12_EL1, 0, 12, 2, 0, 6)
+DEF_SYSREG(HV_SYS_REG_DBGWCR12_EL1, 0, 12, 2, 0, 7)
+
+DEF_SYSREG(HV_SYS_REG_DBGBVR13_EL1, 0, 13, 2, 0, 4)
+DEF_SYSREG(HV_SYS_REG_DBGBCR13_EL1, 0, 13, 2, 0, 5)
+DEF_SYSREG(HV_SYS_REG_DBGWVR13_EL1, 0, 13, 2, 0, 6)
+DEF_SYSREG(HV_SYS_REG_DBGWCR13_EL1, 0, 13, 2, 0, 7)
+
+DEF_SYSREG(HV_SYS_REG_DBGBVR14_EL1, 0, 14, 2, 0, 4)
+DEF_SYSREG(HV_SYS_REG_DBGBCR14_EL1, 0, 14, 2, 0, 5)
+DEF_SYSREG(HV_SYS_REG_DBGWVR14_EL1, 0, 14, 2, 0, 6)
+DEF_SYSREG(HV_SYS_REG_DBGWCR14_EL1, 0, 14, 2, 0, 7)
+
+DEF_SYSREG(HV_SYS_REG_DBGBVR15_EL1, 0, 15, 2, 0, 4)
+DEF_SYSREG(HV_SYS_REG_DBGBCR15_EL1, 0, 15, 2, 0, 5)
+DEF_SYSREG(HV_SYS_REG_DBGWVR15_EL1, 0, 15, 2, 0, 6)
+DEF_SYSREG(HV_SYS_REG_DBGWCR15_EL1, 0, 15, 2, 0, 7)
+
+#ifdef SYNC_NO_RAW_REGS
+/*
+ * The registers below are manually synced on init because they are
+ * marked as NO_RAW. We still list them to make number space sync easier.
+ */
+DEF_SYSREG(HV_SYS_REG_MDCCINT_EL1, 0, 2, 2, 0, 0)
+DEF_SYSREG(HV_SYS_REG_MIDR_EL1, 0, 0, 3, 0, 0)
+DEF_SYSREG(HV_SYS_REG_MPIDR_EL1, 0, 0, 3, 0, 5)
+DEF_SYSREG(HV_SYS_REG_ID_AA64PFR0_EL1, 0, 4, 3, 0, 0)
+#endif
+
+DEF_SYSREG(HV_SYS_REG_ID_AA64PFR1_EL1, 0, 4, 3, 0, 1)
+DEF_SYSREG(HV_SYS_REG_ID_AA64DFR0_EL1, 0, 5, 3, 0, 0)
+DEF_SYSREG(HV_SYS_REG_ID_AA64DFR1_EL1, 0, 5, 3, 0, 1)
+DEF_SYSREG(HV_SYS_REG_ID_AA64ISAR0_EL1, 0, 6, 3, 0, 0)
+DEF_SYSREG(HV_SYS_REG_ID_AA64ISAR1_EL1, 0, 6, 3, 0, 1)
+
+#ifdef SYNC_NO_MMFR0
+/* We keep the hardware MMFR0 around. HW limits are there anyway */
+DEF_SYSREG(HV_SYS_REG_ID_AA64MMFR0_EL1, 0, 7, 3, 0, 0)
+#endif
+
+DEF_SYSREG(HV_SYS_REG_ID_AA64MMFR1_EL1, 0, 7, 3, 0, 1)
+DEF_SYSREG(HV_SYS_REG_ID_AA64MMFR2_EL1, 0, 7, 3, 0, 2)
+/* Add ID_AA64MMFR3_EL1 here when HVF supports it */
+
+DEF_SYSREG(HV_SYS_REG_MDSCR_EL1, 0, 2, 2, 0, 2)
+DEF_SYSREG(HV_SYS_REG_SCTLR_EL1, 1, 0, 3, 0, 0)
+DEF_SYSREG(HV_SYS_REG_CPACR_EL1, 1, 0, 3, 0, 2)
+DEF_SYSREG(HV_SYS_REG_TTBR0_EL1, 2, 0, 3, 0, 0)
+DEF_SYSREG(HV_SYS_REG_TTBR1_EL1, 2, 0, 3, 0, 1)
+DEF_SYSREG(HV_SYS_REG_TCR_EL1, 2, 0, 3, 0, 2)
+
+DEF_SYSREG(HV_SYS_REG_APIAKEYLO_EL1, 2, 1, 3, 0, 0)
+DEF_SYSREG(HV_SYS_REG_APIAKEYHI_EL1, 2, 1, 3, 0, 1)
+DEF_SYSREG(HV_SYS_REG_APIBKEYLO_EL1, 2, 1, 3, 0, 2)
+DEF_SYSREG(HV_SYS_REG_APIBKEYHI_EL1, 2, 1, 3, 0, 3)
+DEF_SYSREG(HV_SYS_REG_APDAKEYLO_EL1, 2, 2, 3, 0, 0)
+DEF_SYSREG(HV_SYS_REG_APDAKEYHI_EL1, 2, 2, 3, 0, 1)
+DEF_SYSREG(HV_SYS_REG_APDBKEYLO_EL1, 2, 2, 3, 0, 2)
+DEF_SYSREG(HV_SYS_REG_APDBKEYHI_EL1, 2, 2, 3, 0, 3)
+DEF_SYSREG(HV_SYS_REG_APGAKEYLO_EL1, 2, 3, 3, 0, 0)
+DEF_SYSREG(HV_SYS_REG_APGAKEYHI_EL1, 2, 3, 3, 0, 1)
+
+DEF_SYSREG(HV_SYS_REG_SPSR_EL1, 4, 0, 3, 0, 0)
+DEF_SYSREG(HV_SYS_REG_ELR_EL1, 4, 0, 3, 0, 1)
+DEF_SYSREG(HV_SYS_REG_SP_EL0, 4, 1, 3, 0, 0)
+DEF_SYSREG(HV_SYS_REG_AFSR0_EL1, 5, 1, 3, 0, 0)
+DEF_SYSREG(HV_SYS_REG_AFSR1_EL1, 5, 1, 3, 0, 1)
+DEF_SYSREG(HV_SYS_REG_ESR_EL1, 5, 2, 3, 0, 0)
+DEF_SYSREG(HV_SYS_REG_FAR_EL1, 6, 0, 3, 0, 0)
+DEF_SYSREG(HV_SYS_REG_PAR_EL1, 7, 4, 3, 0, 0)
+DEF_SYSREG(HV_SYS_REG_MAIR_EL1, 10, 2, 3, 0, 0)
+DEF_SYSREG(HV_SYS_REG_AMAIR_EL1, 10, 3, 3, 0, 0)
+DEF_SYSREG(HV_SYS_REG_VBAR_EL1, 12, 0, 3, 0, 0)
+DEF_SYSREG(HV_SYS_REG_CONTEXTIDR_EL1, 13, 0, 3, 0, 1)
+DEF_SYSREG(HV_SYS_REG_TPIDR_EL1, 13, 0, 3, 0, 4)
+DEF_SYSREG(HV_SYS_REG_CNTKCTL_EL1, 14, 1, 3, 0, 0)
+DEF_SYSREG(HV_SYS_REG_CSSELR_EL1, 0, 0, 3, 2, 0)
+DEF_SYSREG(HV_SYS_REG_TPIDR_EL0, 13, 0, 3, 3, 2)
+DEF_SYSREG(HV_SYS_REG_TPIDRRO_EL0, 13, 0, 3, 3, 3)
+DEF_SYSREG(HV_SYS_REG_CNTV_CTL_EL0, 14, 3, 3, 3, 1)
+DEF_SYSREG(HV_SYS_REG_CNTV_CVAL_EL0, 14, 3, 3, 3, 2)
+DEF_SYSREG(HV_SYS_REG_SP_EL1, 4, 1, 3, 4, 0)
-- 
2.43.0


