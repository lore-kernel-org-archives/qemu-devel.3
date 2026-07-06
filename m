Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24FE5C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 10:40:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wggiw-0007qr-E9; Mon, 06 Jul 2026 06:38:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wggiq-0007WM-OT
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 06:38:45 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wggip-0003Xz-0u
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 06:38:44 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-493c00f74baso17404915e9.0
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 03:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783334321; x=1783939121; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=F4FecMS9cYuiefvro8EfTSYY+87Ud/V+uwe0L9x0kOw=;
 b=fkp809Yre4Fm2Afg9AHT+6zOM5NPGVAqxu0xPfzX971AD00WJzSAZtsmraWw8brTUi
 8QiHVKedZlZivhbBRyyXkwKLNjcQFjSRjqEE9FbpdumTOTe2JGzgAg0e7c0qnMKPiS/x
 BCL5cdMbltWUNFTXq/AYugDR/wbrWLUeMXY8YkLoj+GNGqF0DL0Co2G7qoYrQy6TiM6n
 Vxvdf/dkaiJTSyPPTB5zVloZ+kPUXVCJ0WGHcOpl9wzIla2PuVnnLWNwiVfVQxtT0B+B
 txRMhQm4sOpt/S/n2gQMl/NPlEbo/3eggaEX8jEsZr59YpRSAHTqJnjNE0cVkUiQVwXm
 eENA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783334321; x=1783939121;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=F4FecMS9cYuiefvro8EfTSYY+87Ud/V+uwe0L9x0kOw=;
 b=AGu28gLvQxuM2Qj2noUnAng/ENNfmJx4xndqxWjO86W5LJ7CuvSEMYFdGN5Beqv7Jy
 Fb+KRw8JpCW4kXcWX4K2dEi3jDcu5iEZYtY5dZ1esFT0EXt9NS2INwLFEjooZMSM1H3H
 PLFlnK2wPFuWeTHDkLma4QZh3U+34PJHE9D1eeFlz3bjwXp307LOghogKgMZxZyb0KEh
 dR+AIGSR1p1Fen7L70Tqps/ecrWtcBSzbO4F6J4aPEljiCUGP3IdLM9fXVympoAOyaxE
 ynYtrSVO2gKuDaiU8RZMaE+rd4bJXiIFP7Iy5HgsITJyhSYEOj7vM/GgBjNNFTBg3UqL
 qW2A==
X-Gm-Message-State: AOJu0Yzfb3rFyVIr1ZJTgiYeYzBNwlDX2/H9RQPRtuOa6N8t6JLDbcQD
 jeO1EkaOHgug33GAVZbyhV5MEHtaumlq2mojfufc3G8NCFesFIr/VUuI28hJdq6ZJxg0nqLcwBV
 gyCNDfIJ9Ig==
X-Gm-Gg: AfdE7ckwNT6LSPorXSBrCfgNcdA7xySfp3alO127vyYZwMOtuRVmP0U5ZETGoLmjhlW
 x30mGm2YG98Rn9Fq6L70buXXsJxrieTuqH55jyYsgpclcQMpKs8+i2/P5UIfSR0klmYVQ/rcLCG
 pGRPVM7RC4RXiA/oo/u7WklUXLSlr4FYIvRx1uIBgPDCjwDU23p/D6bjfLa+qK3X2t/xMMgz1H0
 8/0XK9yBcdoDxtyBH3y/gq4OLbETa9hbZWlSqwI39rZTwQ9bnw/jufYo6JZHdBoEuD4kC9FlxXR
 KfT/ew1UfVhfW3fMWl8BRxbuuWgECg/zVPZ7Bgd48YNpNfZYSiTKufgu9bmKsjsLSWUWLepzqTH
 mU9TL7fgBmfu+NEQCGs/rV3v3ecSqs0KP4Op1kmcgLKp+zcSgsvFJKsiQ/+6yDj2Io9CWguGDEM
 52Fv2wZJQL4jmem5jPU7pFLvOzKQ4Dy0UKSnCMS40J3NGU0GjnD0HXQvbA1kgqTmXamm9wtj0/4
 o9GnKeXL0CV26kGIgmKJQ==
X-Received: by 2002:a05:600c:800f:b0:493:d078:796 with SMTP id
 5b1f17b1804b1-493d11dea05mr105303715e9.17.1783334321615; 
 Mon, 06 Jul 2026 03:38:41 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c63b6f1bsm329501805e9.10.2026.07.06.03.38.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 03:38:40 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 45/49] target/arm: Enable FEAT_SME_MOP4 for -cpu max
Date: Mon,  6 Jul 2026 11:37:48 +0100
Message-ID: <20260706103752.320511-46-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260706103752.320511-1-peter.maydell@linaro.org>
References: <20260706103752.320511-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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
Message-id: 20260702204314.79224-16-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/emulation.rst | 1 +
 linux-user/aarch64/elfload.c  | 1 +
 target/arm/tcg/cpu64.c        | 1 +
 3 files changed, 3 insertions(+)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 2864e25294..4f413d69ef 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -175,6 +175,7 @@ the following architecture extensions:
 - FEAT_SME_F8F32 (SME2 ZA-targeting FP8 multiply-accumulate, dot product, and outer product to single-precision instructions)
 - FEAT_SME_I16I64 (16-bit to 64-bit integer widening outer product instructions)
 - FEAT_SME_LUTv2 (Lookup table instructions with 4-bit indices and 8-bit elements)
+- FEAT_SME_MOP4 (Quarter-tile outer product instructions)
 - FEAT_SSVE_AES (Streaming SVE Mode Advanced Encryption Standard and 128-bit polynomial multiply long instructions)
 - FEAT_SSVE_FEXPA (Streaming FEXPA instruction)
 - FEAT_SSVE_FP8DOT2 (SVE2 FP8 2-way dot product to half-precision instructions in Streaming SVE mode)
diff --git a/linux-user/aarch64/elfload.c b/linux-user/aarch64/elfload.c
index 850bfb8666..64e25a04e3 100644
--- a/linux-user/aarch64/elfload.c
+++ b/linux-user/aarch64/elfload.c
@@ -176,6 +176,7 @@ abi_ulong get_elf_hwcap(CPUState *cs)
     GET_FEATURE_ID(aa64_ssve_aes, ARM_HWCAP_A64_SME_AES);
     GET_FEATURE_ID(aa64_ssve_fexpa, ARM_HWCAP_A64_SME_SFEXPA);
     GET_FEATURE_ID(aa64_fprcvt, ARM_HWCAP_A64_FPRCVT);
+    GET_FEATURE_ID(aa64_sme_mop4, ARM_HWCAP_A64_SME_SMOP4);
 
     return hwcaps;
 }
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index e0d701a85c..8a3ebf6321 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1385,6 +1385,7 @@ void aarch64_max_tcg_initfn(Object *obj)
 
     t = GET_IDREG(isar, ID_AA64SMFR0);
     t = FIELD_DP64(t, ID_AA64SMFR0, SFEXPA, 1);   /* FEAT_SSVE_FEXPA */
+    t = FIELD_DP64(t, ID_AA64SMFR0, SMOP4, 1);    /* FEAT_SME_MOP4 */
     t = FIELD_DP64(t, ID_AA64SMFR0, AES, 1);      /* FEAT_SSVE_AES */
     t = FIELD_DP64(t, ID_AA64SMFR0, SF8DP2, 1);   /* FEAT_SSVE_FP8DOT2 */
     t = FIELD_DP64(t, ID_AA64SMFR0, SF8DP4, 1);   /* FEAT_SSVE_FP8DOT4 */
-- 
2.43.0


