Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64E6BCD98DE
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 04:09:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wa42Q-0000yP-4e; Thu, 18 Jun 2026 00:07:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wa42N-0000u0-4h
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 00:07:31 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wa42L-00046U-7x
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 00:07:30 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-36d98c9b596so209500a91.3
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 21:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781755646; x=1782360446; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WlMPIxsa5BxEqoKtTsWOidd9gQ57GiiLIsARiGDhvZk=;
 b=oXROiLEIleFco6weVp8Q5rfSf/MJi55MBH6llZAzzo0qMPj+wRSt+LFui0GoATl+yo
 +E3veIzDRzgU/5O15ukoRrx2uHYPFG0qXtAWx5Z2Si5+h+ZpwjVxDwYql8vb2IHwFL90
 gzRJWCBSmE4Mfk9b00NYL37jRirUmy1T0rclNk+hA0nXNKb7Zv4t8hlXWTTAYVgu78c5
 t4wzX9TmiFojBU184kV0ZPwmQE1Tj4faY2xHfKhqLkwqZfjj9XyI9u6E0bWzTrbl2S/8
 9UXabMvQ4VclowWE5maFZyCua38XxjZEe+xGqlt0usyOAf2dYoqulvVp2Rxq/G2eUmll
 lVqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781755646; x=1782360446;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WlMPIxsa5BxEqoKtTsWOidd9gQ57GiiLIsARiGDhvZk=;
 b=iW/VUrsNxRnsiWRPBpxkvvbNj0NQa0gngIuEUYBkpUBXoR7OTJc4PWARDGd0IDDZ/0
 5cT4a9MAjOMgHdHLa6ltJZqUk7OG0fe/ilYFsoGEIKE/86U2eN8wtBQuksW+wDHXFnM1
 Ic7gED0prJfBrbcSDoZj+7LsZZgDeLsu2KklEdeAwJNiC4s+sgaTgXHTkc5v/lrt977C
 yd5rLfFXQbYPQqa7VckxLloFzlrz0gZ1/sAikGklsjcV/E+CPLxz5i7fgn8THum2HDx/
 aAgk6cBBdIyxpJm/ESX1ZebywgeZJjpNEUWv50Q3h/Vu6u6giombeDvYR1T2Kin18iSh
 bxgw==
X-Gm-Message-State: AOJu0YyBnq9wzP4sFNLk/LpsKdLCx0pIWlLSqQ0/tQwODrizlIT0vlmb
 /Mgj2tYp44zzLwD9SEVxCiBBNgxhMj4j+MqDgeoHip4aIE9NMxY8EqAXIx3srXMTkLw2dDhFH6k
 UhCsR
X-Gm-Gg: AfdE7clcPrUDQkAl+VrQvuR/jWeFIfBZx/69SOzMscpXneYClNJoGOpvVAVQ+0yCPkr
 XJH6j/qPnHl6+7kOhMpaIFVNwgSD1PwBgHx7UHOeZJCpFbDNjCBFt89OLIjfSRkYt05y7xGfAQp
 hRl0R1GFemFURjqSjpYi7dJWAmtXst+UnGz0Npolt8CZQh5CcMjwu11lTvJMQCySLdJedqsWSsB
 mfRJ8LrC4JYxHZa/gnNFKrBzJen4EX4aO4Rw+Ydocv8iWSR8Xbnl9tpJidYBgslI7ftFRgOnOQs
 dkSNDNcKxAePx1KRzh53SDkYahcMWvyxaG7Y9nRfy84NCEMUJt9Gk50m/u0nNe1nwAiYQLg3K0J
 66eYztiopjUYRXmfmAp1vmnbZkXLuZBMuvYWQSP9a9yU47NV16duHy94As2D3SZ3JBt0K2ezuWY
 XLXtMMHSwfJODTnoP7AyXGFRWwt493k2Xwk50zOlC77ji3knUfzw58HIXHHBMr
X-Received: by 2002:a17:90b:558c:b0:36d:81b3:61a1 with SMTP id
 98e67ed59e1d1-37c930d223cmr6659227a91.7.1781755646181; 
 Wed, 17 Jun 2026 21:07:26 -0700 (PDT)
Received: from stoup.. (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-37c5222e042sm8830476a91.16.2026.06.17.21.07.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 21:07:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 7/8] target/arm: Implement FEAT_SSVE_AES
Date: Wed, 17 Jun 2026 21:07:17 -0700
Message-ID: <20260618040718.572950-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260618040718.572950-1-richard.henderson@linaro.org>
References: <20260618040718.572950-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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

Enable FEAT_SVE_AES instructions in streaming mode.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu-features.h      |  5 +++++
 linux-user/aarch64/elfload.c   |  1 +
 target/arm/tcg/cpu64.c         |  1 +
 target/arm/tcg/translate-sve.c | 20 +++++++++++---------
 docs/system/arm/emulation.rst  |  1 +
 5 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index af843b32d3..c07bcb0a73 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1575,6 +1575,11 @@ static inline bool isar_feature_aa64_sve_b16b16(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64ZFR0, B16B16);
 }
 
+static inline bool isar_feature_aa64_ssve_aes(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64SMFR0, AES);
+}
+
 static inline bool isar_feature_aa64_ssve_f8fma(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64SMFR0, SF8FMA);
diff --git a/linux-user/aarch64/elfload.c b/linux-user/aarch64/elfload.c
index 3479e61a12..0f96bbe70b 100644
--- a/linux-user/aarch64/elfload.c
+++ b/linux-user/aarch64/elfload.c
@@ -173,6 +173,7 @@ abi_ulong get_elf_hwcap(CPUState *cs)
     GET_FEATURE_ID(aa64_cmpbr, ARM_HWCAP_A64_CMPBR);
     GET_FEATURE_ID(aa64_f8mm8, ARM_HWCAP_A64_F8MM8);
     GET_FEATURE_ID(aa64_f8mm4, ARM_HWCAP_A64_F8MM4);
+    GET_FEATURE_ID(aa64_ssve_aes, ARM_HWCAP_A64_SME_AES);
 
     return hwcaps;
 }
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index f7a920a202..e4a8d7a2f6 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1383,6 +1383,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     SET_IDREG(isar, ID_AA64DFR0, t);
 
     t = GET_IDREG(isar, ID_AA64SMFR0);
+    t = FIELD_DP64(t, ID_AA64SMFR0, AES, 1);      /* FEAT_SSVE_AES */
     t = FIELD_DP64(t, ID_AA64SMFR0, SF8DP2, 1);   /* FEAT_SSVE_FP8DOT2 */
     t = FIELD_DP64(t, ID_AA64SMFR0, SF8DP4, 1);   /* FEAT_SSVE_FP8DOT4 */
     t = FIELD_DP64(t, ID_AA64SMFR0, SF8FMA, 1);   /* FEAT_SSVE_FP8FMA */
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 9f0f0e0e12..79e8e16b24 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -7169,7 +7169,7 @@ static bool do_trans_pmull(DisasContext *s, arg_rrr_esz *a, bool sel)
         if (!dc_isar_feature(aa64_sve2_pmull128, s)) {
             return false;
         }
-        s->is_nonstreaming = true;
+        s->is_nonstreaming = !dc_isar_feature(aa64_ssve_aes, s);
     }
     return gen_gvec_ool_arg_zzz(s, fns[a->esz], a, sel);
 }
@@ -8174,15 +8174,17 @@ TRANS_FEAT(SDOT_zzzz_2s, aa64_sme2_or_sve2p1, gen_gvec_ool_arg_zzzz,
 TRANS_FEAT(UDOT_zzzz_2s, aa64_sme2_or_sve2p1, gen_gvec_ool_arg_zzzz,
            gen_helper_gvec_udot_2h, a, 0)
 
-TRANS_FEAT_NONSTREAMING(AESMC, aa64_sve_aes, gen_gvec_ool_zz,
-                        gen_helper_crypto_aesmc, a->rd, a->rd, 0)
-TRANS_FEAT_NONSTREAMING(AESIMC, aa64_sve_aes, gen_gvec_ool_zz,
-                        gen_helper_crypto_aesimc, a->rd, a->rd, 0)
+TRANS_FEAT_STREAMING_IF(AESMC, aa64_sve_aes, aa64_ssve_aes,
+                        gen_gvec_ool_zz, gen_helper_crypto_aesmc,
+                        a->rd, a->rd, 0)
+TRANS_FEAT_STREAMING_IF(AESIMC, aa64_sve_aes, aa64_ssve_aes,
+                        gen_gvec_ool_zz, gen_helper_crypto_aesimc,
+                        a->rd, a->rd, 0)
 
-TRANS_FEAT_NONSTREAMING(AESE, aa64_sve_aes, gen_gvec_ool_arg_zzz,
-                        gen_helper_crypto_aese, a, 0)
-TRANS_FEAT_NONSTREAMING(AESD, aa64_sve_aes, gen_gvec_ool_arg_zzz,
-                        gen_helper_crypto_aesd, a, 0)
+TRANS_FEAT_STREAMING_IF(AESE, aa64_sve_aes, aa64_ssve_aes,
+                        gen_gvec_ool_arg_zzz, gen_helper_crypto_aese, a, 0)
+TRANS_FEAT_STREAMING_IF(AESD, aa64_sve_aes, aa64_ssve_aes,
+                        gen_gvec_ool_arg_zzz, gen_helper_crypto_aesd, a, 0)
 
 TRANS_FEAT_NONSTREAMING(SM4E, aa64_sve2_sm4, gen_gvec_ool_arg_zzz,
                         gen_helper_crypto_sm4e, a, 0)
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index a8072ddb67..0b4623139a 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -171,6 +171,7 @@ the following architecture extensions:
 - FEAT_SME_F64F64 (Double-precision floating-point outer product instructions)
 - FEAT_SME_I16I64 (16-bit to 64-bit integer widening outer product instructions)
 - FEAT_SME_LUTv2 (Lookup table instructions with 4-bit indices and 8-bit elements)
+- FEAT_SSVE_AES (Streaming SVE Mode Advanced Encryption Standard and 128-bit polynomial multiply long instructions)
 - FEAT_SSVE_FP8DOT2 (SVE2 FP8 2-way dot product to half-precision instructions in Streaming SVE mode)
 - FEAT_SSVE_FP8DOT4 (SVE2 FP8 4-way dot product to single-precision instructions in Streaming SVE mode)
 - FEAT_SSVE_FP8FMA (SVE2 FP8 multiply-accumulate to half-precision and single-precision instructions in Streaming SVE mode)
-- 
2.43.0


