Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C0E1CD6E55
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 03:33:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUcIV-0007E9-5W; Tue, 02 Jun 2026 23:29:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wUcIC-0006lH-5W
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 23:29:20 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wUcI9-0003iu-Aq
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 23:29:19 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-8423f626a65so1313881b3a.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2026 20:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780457356; x=1781062156; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uBm5qOgpGyxlvax8B3WVuYZhhYjwNRk7YVA60wElJQg=;
 b=kWd5q7kH9SteG+rqw/DNLg4mFXZGgjnIwWvjtEabCU27tQpiq27o7czEAiCP0ce42v
 NXxP/Kzswm8fAaAlpYA9Omw6yKCCNr9H71nm4n6gj629EuXBzMOkqre/gXWgvMWSM2w8
 iwKuevY62jg75+nOwzh0xXFm3cm3+dGeipn7QEc894DYACAdSxXAjeV5lT1u6VSaG3BZ
 0Pye3o6NoKp60/oiESzNLXwHhdnmJtIhMZM+J8OYkDSc4iP+6EpWXxz5hBq8pKgpsz06
 NX+BihfDx2EUhW1cmz/7NrQOjuSnh3ZwhYXts7lcW8jSycYM+qTaRoDT+/NFvAd8q/ZJ
 19lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780457356; x=1781062156;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uBm5qOgpGyxlvax8B3WVuYZhhYjwNRk7YVA60wElJQg=;
 b=exVhwrXLk8QWwNuFkMiYeabk9nqTbwRjNMjwi+wMNCWoGV46eSfsmZXJ7g7ChLrWje
 11i0E1vPdCR5Tzol84jYS7xUzOoFPca6cH0Vlg2jezSslYF/CVWabFS9KQNq1FzlG2CB
 bF1Inh24XBYxsMhnz/tEiHHA5nktH5JLPchuhJXP1hGG92TFoxMrH+uKF+qOIc5KV5dZ
 XT8vg1+1ikurl5/fPOzN/+jUwSF8bi048F1IS3MBwYIj/50Y8uluGL7gshVLZXCmv7P4
 5fQrCBGjXffcqKqfe6Ey928309pj87BfnpaPrwXWB5DTRkHL/ptKudkxGzlMC2vc8374
 Qk0w==
X-Gm-Message-State: AOJu0Yxnzlyzohd5moyCWO6nV1va+2nxS9cigizclZf7Fu2QV3n3F6df
 apUNtdU81tX5uqjSlOlZVnj8IAL0iX/ysFUxs6dpB3OJ2dJ2VyhXgbxrZbu6JIyr3c2qsg35Sqc
 PrFtVPDw=
X-Gm-Gg: Acq92OG9FeWMZ4PSLwsvB1KRuIZq743U2j2AEFux/r8JoSGfACqkav9SQh9bfmk1iuJ
 Gj7kkw6DiII3RhrjMn9gPb554EuWDV51bxb3/ozbd562Gwa3WAQ5hqZZhRznpzzzQAf2tF1j4Jr
 d/JfkVlmXJNyNEgT1pkOmOEPZJ5qum2orMnWSqKK21vPz8Zjh0dDkCNEpSmTAQYFrRD8sy9bVnh
 9LRuoRBt8M07fXZpbeuxam5BujSQ0gshSrgQBLIt60dGlOoRJrAbDN6KQ1Rff1h9vpZoDcTxkvJ
 LgbhRV+fFr6hPj7sdqmDObKvSdDuA8FS6mtVQzJoLlND3xA+Mp9aA3kIbxrtSYjxgjmKoAMAkbC
 8miw7pdPRRFvZJq1AtY6/+S4pmPDJ+Pn5k2N59+ectHapFpL+2zmidPQp/Qzytmbb8ZxqpyDL4m
 VRSnuedyP+RUbWh1VZ+1q8lkIKWVHWlYI/P56XTMeXaQD3/WeOvA==
X-Received: by 2002:a05:6a00:bb01:b0:842:4612:55f4 with SMTP id
 d2e1a72fcca58-84284f79688mr1519389b3a.31.1780457355872; 
 Tue, 02 Jun 2026 20:29:15 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8428222263dsm1477831b3a.2.2026.06.02.20.29.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 20:29:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v9 28/45] target/arm: Enable FEAT_SME_LUTv2 for -cpu max
Date: Tue,  2 Jun 2026 20:28:37 -0700
Message-ID: <20260603032855.106930-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260603032855.106930-1-richard.henderson@linaro.org>
References: <20260603032855.106930-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/aarch64/elfload.c  | 1 +
 target/arm/tcg/cpu64.c        | 1 +
 docs/system/arm/emulation.rst | 1 +
 3 files changed, 3 insertions(+)

diff --git a/linux-user/aarch64/elfload.c b/linux-user/aarch64/elfload.c
index 1c0c404b7c..06c14e82ea 100644
--- a/linux-user/aarch64/elfload.c
+++ b/linux-user/aarch64/elfload.c
@@ -222,6 +222,7 @@ abi_ulong get_elf_hwcap2(CPUState *cs)
     GET_FEATURE_ID(aa64_faminmax, ARM_HWCAP2_A64_FAMINMAX);
     GET_FEATURE_ID(aa64_fpmr, ARM_HWCAP2_A64_FPMR);
     GET_FEATURE_ID(aa64_lut, ARM_HWCAP2_A64_LUT);
+    GET_FEATURE_ID(aa64_sme2p1_lutv2, ARM_HWCAP2_A64_SME_LUTV2);
     GET_FEATURE_ID(aa64_f8cvt, ARM_HWCAP2_A64_F8CVT |
                                ARM_HWCAP2_A64_F8E4M3 |
                                ARM_HWCAP2_A64_F8E5M2);
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index b48dd01a2c..e466ab5b8a 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1389,6 +1389,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64SMFR0, F64F64, 1);   /* FEAT_SME_F64F64 */
     t = FIELD_DP64(t, ID_AA64SMFR0, I16I64, 0xf); /* FEAT_SME_I16I64 */
     t = FIELD_DP64(t, ID_AA64SMFR0, SMEVER, 2);   /* FEAT_SME2p1 */
+    t = FIELD_DP64(t, ID_AA64SMFR0, LUTv2, 1);    /* FEAT_SME_LUTv2 */
     t = FIELD_DP64(t, ID_AA64SMFR0, FA64, 1);     /* FEAT_SME_FA64 */
     SET_IDREG(isar, ID_AA64SMFR0, t);
 
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 470f7d891e..41fa9bfca3 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -160,6 +160,7 @@ the following architecture extensions:
 - FEAT_SME_F16F16 (Non-widening half-precision FP16 arithmetic for SME2)
 - FEAT_SME_F64F64 (Double-precision floating-point outer product instructions)
 - FEAT_SME_I16I64 (16-bit to 64-bit integer widening outer product instructions)
+- FEAT_SME_LUTv2 (Lookup table instructions with 4-bit indices and 8-bit elements)
 - FEAT_SVE (Scalable Vector Extension)
 - FEAT_SVE_AES (Scalable Vector AES instructions)
 - FEAT_SVE_B16B16 (Non-widening BFloat16 arithmetic for SVE2)
-- 
2.43.0


