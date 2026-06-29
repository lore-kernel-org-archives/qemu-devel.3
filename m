Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F134FC43327
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 12:12:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weAgI-0007MT-P6; Mon, 29 Jun 2026 08:01:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weAg8-00075f-5n
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:01:32 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weAg6-0007g1-D3
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:01:31 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-697564cb69eso5833940a12.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 05:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782734489; x=1783339289; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=v0F9a2elBw83i7s8YssOand3Ct/47+kKbyCYZAbT7fM=;
 b=Tyf72Ky8fNLnc9OOrxT6Grzvy8CrWcCCu5g/x+jm3qNsdEJVaO/kVuuB6g/BOp9ZLY
 2uIIAUQOCBUrUoBl4YDpsNfHqJ6280O0KHA/AmOw/4+MQToJAy3puiHXCqielMHev9cW
 GB2CHabOtmKgnIg7utpMBOeVdK9VDOxzu2yzHC7uXcFfVB4Pi6it9q1OrwRhAndDvkGQ
 6x0u10dNgUA3y+bwAjVkI2qjwv5swu9kyZNVwkyLrTFoYfxMU73aCtxRWqyEVPHlZXCg
 PvL1UHwpWu3oghf8e4qlMgBSeun1iEUx1/sbtRrMl9HQi00IoApy4TeA2993+itvW/LV
 1STg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782734489; x=1783339289;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=v0F9a2elBw83i7s8YssOand3Ct/47+kKbyCYZAbT7fM=;
 b=T9zL3tWPSqAKGkOYoaPG3UWJTKlfVTTocc+1GjSkMtgBkwlDi9zx2SNWpa88otpbzz
 Dd39s32/ASeMLpqqmson1rjp5HlCSzMxUSNG4EUofkkF9ukx3UNpX15+UmuA9l9hobyt
 2Kz5IpusefEAhkM+0Jd5S/3UXDk3yT2CSuqEOmCp90xKYrtZxvt0pjC4/df/LikMDEFJ
 5ieJ7cw1RntIKhCndgmOu0X3R4LzTrVM6zYgfJRCCID/xm54Cze5ymjo8t/9Y6lvbD7T
 evVzp8lSvBPUvOxqqWMl9BfbXlC5yTrrqRAmLwFy7Pqghv3IQmnlOxSd/p69tApbPrMJ
 T+Pw==
X-Gm-Message-State: AOJu0YwfkLwat+o9VKzhIsuYgZ6z21GZI5oqAVjsKH3QUD0r2nPNypRa
 eypCUcEONKBLzXY6h0eRL0+gc17LbOjmlSvc30FoTQXIwclBOyPShvZkUfBzw2bOv4QmCZEoopf
 wbY3l
X-Gm-Gg: AfdE7cmcKIt6OVBLdvul+GVb9jAL9vjwq2qhH6mrBfILKPAhG152D4T3aymCo/aq4jQ
 T8lnImLqbo/nYUURFA5DhW+S4yipQ02HPFGl/wzz8lwLCwpvEih9V81OL24imLRmMoAxGzmirqy
 PkS0TTth2TtayH8XrA8Fskm5JkJBCTwMrLPXJOmM/cuIALhDdB+ihFXXImlFnKZVrk7IJc3+hxx
 NFkNZiEYPJMee6R8LunVMR+LHnLV4eqeqOuo9BfTHBlhP979s0xnbeLsHeSq0Wi68RetFCsn/fE
 WXp4GmRmVWvEwDT5c3dnK9NawUZ7oTsL9uSN/u144x5ZrFAKVOzR9kGFPBSKj3GkUbPwOaMjW2n
 lOsbwc4dkHqbxf8z4V5+EpE1EPE70Ek74fl0iDaBpxdG8RKWJuXO4Hi9aalHeSkYCVOZAce4VDD
 3fadDx5M0wwtcvhC0hTicVFBDaw6g4GQwD7J2sG8BysTXw3qO5O2YZ18bWSiO2q8m1LdBS48azS
 eCxFyEHyT9iJexYAqoXCA==
X-Received: by 2002:a17:907:c50a:b0:c12:6863:fb61 with SMTP id
 a640c23a62f3a-c126864079emr160454766b.39.1782734488714; 
 Mon, 29 Jun 2026 05:01:28 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-473dddcb295sm8753061f8f.35.2026.06.29.05.01.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 05:01:28 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 53/54] target/arm: Enable FEAT_SME_F8F16 for -cpu max
Date: Mon, 29 Jun 2026 13:00:31 +0100
Message-ID: <20260629120032.1645265-54-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629120032.1645265-1-peter.maydell@linaro.org>
References: <20260629120032.1645265-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260625015159.719300-11-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/emulation.rst | 1 +
 linux-user/aarch64/elfload.c  | 1 +
 target/arm/tcg/cpu64.c        | 1 +
 3 files changed, 3 insertions(+)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 6b02bd829a..191d1a8c93 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -170,6 +170,7 @@ the following architecture extensions:
 - FEAT_SME_FA64 (Full A64 instruction set in Streaming SVE mode)
 - FEAT_SME_F16F16 (Non-widening half-precision FP16 arithmetic for SME2)
 - FEAT_SME_F64F64 (Double-precision floating-point outer product instructions)
+- FEAT_SME_F8F16 (SME2 ZA-targeting FP8 multiply-accumulate, dot product, and outer product to half-precision instructions)
 - FEAT_SME_F8F32 (SME2 ZA-targeting FP8 multiply-accumulate, dot product, and outer product to single-precision instructions)
 - FEAT_SME_I16I64 (16-bit to 64-bit integer widening outer product instructions)
 - FEAT_SME_LUTv2 (Lookup table instructions with 4-bit indices and 8-bit elements)
diff --git a/linux-user/aarch64/elfload.c b/linux-user/aarch64/elfload.c
index 20b9838520..42aeb29306 100644
--- a/linux-user/aarch64/elfload.c
+++ b/linux-user/aarch64/elfload.c
@@ -236,6 +236,7 @@ abi_ulong get_elf_hwcap2(CPUState *cs)
     GET_FEATURE_ID(aa64_ssve_f8dp4, ARM_HWCAP2_A64_SME_SF8DP4);
     GET_FEATURE_ID(aa64_ssve_f8dp2, ARM_HWCAP2_A64_SME_SF8DP2);
     GET_FEATURE_ID(aa64_sme_f8f32, ARM_HWCAP2_A64_SME_F8F32);
+    GET_FEATURE_ID(aa64_sme_f8f16, ARM_HWCAP2_A64_SME_F8F16);
 
     return hwcaps;
 }
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index a5734446dd..ae3952a1ed 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1393,6 +1393,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64SMFR0, F16F32, 1);   /* FEAT_SME */
     t = FIELD_DP64(t, ID_AA64SMFR0, I8I32, 0xf);  /* FEAT_SME */
     t = FIELD_DP64(t, ID_AA64SMFR0, F8F32, 1);    /* FEAT_SME_F8F32 */
+    t = FIELD_DP64(t, ID_AA64SMFR0, F8F16, 1);    /* FEAT_SME_F8F16 */
     t = FIELD_DP64(t, ID_AA64SMFR0, F16F16, 1);   /* FEAT_SME_F16F16 */
     t = FIELD_DP64(t, ID_AA64SMFR0, B16B16, 1);   /* FEAT_SME_B16B16 */
     t = FIELD_DP64(t, ID_AA64SMFR0, I16I32, 5);   /* FEAT_SME2 */
-- 
2.43.0


