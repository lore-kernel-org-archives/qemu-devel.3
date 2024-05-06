Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B6D2C4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 01:07:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3mmX-0007px-1f; Sun, 05 May 2024 21:04:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s3mmL-0007ia-PD
 for qemu-devel@nongnu.org; Sun, 05 May 2024 21:04:29 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s3mm6-0002Qf-53
 for qemu-devel@nongnu.org; Sun, 05 May 2024 21:04:29 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1eb24e3a2d9so13839055ad.1
 for <qemu-devel@nongnu.org>; Sun, 05 May 2024 18:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714957450; x=1715562250; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ASrA7TqhkE0rAAXJqfu7t/qjiXelCpy+2ZhxPwsTqN8=;
 b=InfsP3RIQIH2uoi0O2BChQRH2FTC/KteVJeewrJzd5JqjumjCpix0waivoS+19WYPE
 Z8UGjIKPuM5ePnGc9KevF9RlT+gOElJ4ssjtfCrhRMCUCNYjG8brB6ECfda6qXx8JRWc
 8wMGRd0SQD391+l+2j4ltp7rD1wfn1HRpIX311zdSPtaMSSw3LXcjIEKrZhXpJmbv4RB
 rT62yAUThV/Ip5/eTA479wX2GAq9KcfGSr3g+RoJMvvJgh1YLJRLgIkbF+QXZMYde5X+
 P4gMPTOy2BN0VCgOgvf3EGYXR4P7Z2OAbaf7ieMDDplTs2trqeeZK6p61AH4DbK61X1m
 G6BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714957450; x=1715562250;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ASrA7TqhkE0rAAXJqfu7t/qjiXelCpy+2ZhxPwsTqN8=;
 b=QmFymMPAWu7+LPlrwDsE3juPJD2bDM3zrVOzACahUU6tKkIgNXQJ0nwHiF0LcJkRth
 khsCvCIUioEFeo+U/QaVTUC23kMEAIw2tBJYwawtvGetVHig4VuVe9XmoZSwN+JtVzQB
 fvdU5+vGQZquWM4ImrMJL/nTZQ/j7ymOSipBU6saFlSsEKzWIB0M5768BpIQ9rPIvm5Y
 PPjO2TvDqg1DaCQY+/rj1RyZSGk/XNG7nQ3X4RaedDqp9mmO/7AFH1QgmJR92mEuOjLk
 mpS41gH44B5YaPHve2R0/KrCvEkygH9jSFM17Lz2rqpmEUXcMkH0jolSzO69uBvicRin
 V/EA==
X-Gm-Message-State: AOJu0YwPJUzMp0axtd8DTyWa8MM1qD/CSAl8oPrvNaZw3QztVvRWf60O
 z9XQxatxjzt6+I4kfqVNrjdMQqIiOn/rO2qKTiXOAxXtGRC5kegHuWXF5t9pG0cFbfZmCVi+gW3
 B
X-Google-Smtp-Source: AGHT+IFVCB6d7PVs6C4TxNRm5WFLk4TolG9xmXGwsvsLfusbpRIhe6hlJA7mB7cVVsgU1Mjmktqaqw==
X-Received: by 2002:a17:90a:9406:b0:2b3:90ab:fb9 with SMTP id
 r6-20020a17090a940600b002b390ab0fb9mr7764482pjo.49.1714957450115; 
 Sun, 05 May 2024 18:04:10 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 pv7-20020a17090b3c8700b002a5f44353d2sm8958232pjb.7.2024.05.05.18.04.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 May 2024 18:04:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 05/57] target/arm: Convert Cryptographic 2-register SHA to
 decodetree
Date: Sun,  5 May 2024 18:03:11 -0700
Message-Id: <20240506010403.6204-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240506010403.6204-1-richard.henderson@linaro.org>
References: <20240506010403.6204-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/a64.decode      |  6 ++++
 target/arm/tcg/translate-a64.c | 54 +++-------------------------------
 2 files changed, 10 insertions(+), 50 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 7590659ee6..350afabc77 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -614,3 +614,9 @@ SHA1SU0         0101 1110 000 ..... 001100 ..... .....  @rrr_q1e0
 SHA256H         0101 1110 000 ..... 010000 ..... .....  @rrr_q1e0
 SHA256H2        0101 1110 000 ..... 010100 ..... .....  @rrr_q1e0
 SHA256SU1       0101 1110 000 ..... 011000 ..... .....  @rrr_q1e0
+
+### Cryptographic two-register SHA
+
+SHA1H           0101 1110 0010 1000 0000 10 ..... ..... @rr_q1e0
+SHA1SU1         0101 1110 0010 1000 0001 10 ..... ..... @rr_q1e0
+SHA256SU0       0101 1110 0010 1000 0010 10 ..... ..... @rr_q1e0
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index b31e70b5d3..89f733ef12 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -4607,6 +4607,10 @@ TRANS_FEAT(SHA256H, aa64_sha256, do_gvec_op3_ool, a, 0, gen_helper_crypto_sha256
 TRANS_FEAT(SHA256H2, aa64_sha256, do_gvec_op3_ool, a, 0, gen_helper_crypto_sha256h2)
 TRANS_FEAT(SHA256SU1, aa64_sha256, do_gvec_op3_ool, a, 0, gen_helper_crypto_sha256su1)
 
+TRANS_FEAT(SHA1H, aa64_sha1, do_gvec_op2_ool, a, 0, gen_helper_crypto_sha1h)
+TRANS_FEAT(SHA1SU1, aa64_sha1, do_gvec_op2_ool, a, 0, gen_helper_crypto_sha1su1)
+TRANS_FEAT(SHA256SU0, aa64_sha256, do_gvec_op2_ool, a, 0, gen_helper_crypto_sha256su0)
+
 /* Shift a TCGv src by TCGv shift_amount, put result in dst.
  * Note that it is the caller's responsibility to ensure that the
  * shift amount is in range (ie 0..31 or 0..63) and provide the ARM
@@ -13500,55 +13504,6 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
     }
 }
 
-/* Crypto two-reg SHA
- *  31             24 23  22 21       17 16    12 11 10 9    5 4    0
- * +-----------------+------+-----------+--------+-----+------+------+
- * | 0 1 0 1 1 1 1 0 | size | 1 0 1 0 0 | opcode | 1 0 |  Rn  |  Rd  |
- * +-----------------+------+-----------+--------+-----+------+------+
- */
-static void disas_crypto_two_reg_sha(DisasContext *s, uint32_t insn)
-{
-    int size = extract32(insn, 22, 2);
-    int opcode = extract32(insn, 12, 5);
-    int rn = extract32(insn, 5, 5);
-    int rd = extract32(insn, 0, 5);
-    gen_helper_gvec_2 *genfn;
-    bool feature;
-
-    if (size != 0) {
-        unallocated_encoding(s);
-        return;
-    }
-
-    switch (opcode) {
-    case 0: /* SHA1H */
-        feature = dc_isar_feature(aa64_sha1, s);
-        genfn = gen_helper_crypto_sha1h;
-        break;
-    case 1: /* SHA1SU1 */
-        feature = dc_isar_feature(aa64_sha1, s);
-        genfn = gen_helper_crypto_sha1su1;
-        break;
-    case 2: /* SHA256SU0 */
-        feature = dc_isar_feature(aa64_sha256, s);
-        genfn = gen_helper_crypto_sha256su0;
-        break;
-    default:
-        unallocated_encoding(s);
-        return;
-    }
-
-    if (!feature) {
-        unallocated_encoding(s);
-        return;
-    }
-
-    if (!fp_access_check(s)) {
-        return;
-    }
-    gen_gvec_op2_ool(s, true, rd, rn, 0, genfn);
-}
-
 /* Crypto three-reg SHA512
  *  31                   21 20  16 15  14  13 12  11  10  9    5 4    0
  * +-----------------------+------+---+---+-----+--------+------+------+
@@ -13843,7 +13798,6 @@ static const AArch64DecodeTable data_proc_simd[] = {
     { 0x5e000400, 0xdfe08400, disas_simd_scalar_copy },
     { 0x5f000000, 0xdf000400, disas_simd_indexed }, /* scalar indexed */
     { 0x5f000400, 0xdf800400, disas_simd_scalar_shift_imm },
-    { 0x5e280800, 0xff3e0c00, disas_crypto_two_reg_sha },
     { 0xce608000, 0xffe0b000, disas_crypto_three_reg_sha512 },
     { 0xcec08000, 0xfffff000, disas_crypto_two_reg_sha512 },
     { 0xce000000, 0xff808000, disas_crypto_four_reg },
-- 
2.34.1


