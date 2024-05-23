Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DB55C25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 15:40:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAATj-00087a-EL; Thu, 23 May 2024 11:35:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sAATc-0007ze-Qj
 for qemu-devel@nongnu.org; Thu, 23 May 2024 11:35:35 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sAATW-0002Ti-MZ
 for qemu-devel@nongnu.org; Thu, 23 May 2024 11:35:32 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-354df3ee1a9so1844408f8f.1
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 08:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716478513; x=1717083313; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jQiVfpIf0QQorEyEOzcJDMCqA/LHIFV6sEIv+vcXTc8=;
 b=WDiROg2i+fg2VeIhAfLx0AIz7/pD5RzFxqQO6KkrjX5o+GIvodqIUO7iIrL58u/PSD
 riBI1Uj1MKobV/LGj4t2idHnH19Izzrfo9fRNf8lqiieALsbekmE5HCEoWRqiVhRRjYu
 JpARvHTwTsGAAcYrjiEb+9nwKRJO5ZwCW7Av73f6fwjCbHHPRCSwfN+Cyx1JpIgZNiK7
 hrgMJfJEGSyqZnRqhp/U37QIIfgqJcuXmcEkwCy0Es4iHxpD/tYyoVvmbcJhzQ4QSt9k
 YMonFeUxXBfO0noabXldEKVaMDWuueWKYAmMQv3gsPRKHFX6soReWljreuPauM96jQBD
 kL+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716478513; x=1717083313;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jQiVfpIf0QQorEyEOzcJDMCqA/LHIFV6sEIv+vcXTc8=;
 b=p7dQCY7SdoT92lrOKjd2Y5Is1vBJ3mTEsZQ/9aIqhaAD1qQVYFChO9i9wtcJTUPHxt
 tBJY+Or1r9LFsL3LR0ONCj1D3U9gezNe8MSiCjmgymRZKrrJ5X9wL9qVAGGnWZIMUfm3
 +AxYbHtiSzEAxzknCc5gipLh5A9dcAUiUmsjrQQFXpAmetKKf8KCn2HMnXgzLk8gcyQs
 8Qc/PenrP5SC+dKhPS8ruxURNhJGknY7zZ/4LzRuC2Y5uSMR71h4AHpaczdwsVBztfj3
 gkS9ZzXPLJyN2vxFsmv2cYpbYN8NxXf46/jd0JlOVTET3a+0ksEdiOMq8/xgidHwV3X5
 fr/Q==
X-Gm-Message-State: AOJu0Yw4cge64bltxq+57oycoygZyszm4OhSOTqFsDXlomogV3TczFwv
 II1ZFB4cv7PxX4JGjwHYcrdv342NfRghVFWGS0lKothxJqwxbCKrH59Gwu50L9YE20Z67et/fwm
 Z
X-Google-Smtp-Source: AGHT+IFtAxtSHniaOG+oAkO5+DO7QYjix+P1Na0JnCm3AGWKMaBWKG8E5WrAeD2I7FWKTcW+Jb0b/Q==
X-Received: by 2002:a5d:43c7:0:b0:354:f802:f3a6 with SMTP id
 ffacd0b85a97d-354f802f639mr2033458f8f.9.1716478513204; 
 Thu, 23 May 2024 08:35:13 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-354df9b51f7sm3888255f8f.59.2024.05.23.08.35.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 08:35:13 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/37] target/arm: Convert Cryptographic 3-register SHA to
 decodetree
Date: Thu, 23 May 2024 16:34:40 +0100
Message-Id: <20240523153505.2900433-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240523153505.2900433-1-peter.maydell@linaro.org>
References: <20240523153505.2900433-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240506010403.6204-5-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode      | 11 +++++
 target/arm/tcg/translate-a64.c | 78 +++++-----------------------------
 2 files changed, 21 insertions(+), 68 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 1de09903dc4..7590659ee68 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -30,6 +30,7 @@
 
 @rr_q1e0        ........ ........ ...... rn:5 rd:5      &qrr_e q=1 esz=0
 @r2r_q1e0       ........ ........ ...... rm:5 rd:5      &qrrr_e rn=%rd q=1 esz=0
+@rrr_q1e0       ........ ... rm:5 ...... rn:5 rd:5      &qrrr_e q=1 esz=0
 
 ### Data Processing - Immediate
 
@@ -603,3 +604,13 @@ AESE            01001110 00 10100 00100 10 ..... .....  @r2r_q1e0
 AESD            01001110 00 10100 00101 10 ..... .....  @r2r_q1e0
 AESMC           01001110 00 10100 00110 10 ..... .....  @rr_q1e0
 AESIMC          01001110 00 10100 00111 10 ..... .....  @rr_q1e0
+
+### Cryptographic three-register SHA
+
+SHA1C           0101 1110 000 ..... 000000 ..... .....  @rrr_q1e0
+SHA1P           0101 1110 000 ..... 000100 ..... .....  @rrr_q1e0
+SHA1M           0101 1110 000 ..... 001000 ..... .....  @rrr_q1e0
+SHA1SU0         0101 1110 000 ..... 001100 ..... .....  @rrr_q1e0
+SHA256H         0101 1110 000 ..... 010000 ..... .....  @rrr_q1e0
+SHA256H2        0101 1110 000 ..... 010100 ..... .....  @rrr_q1e0
+SHA256SU1       0101 1110 000 ..... 011000 ..... .....  @rrr_q1e0
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 57a333fe6fc..9b941451036 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -4589,7 +4589,7 @@ static bool trans_EXTR(DisasContext *s, arg_extract *a)
 }
 
 /*
- * Cryptographic AES
+ * Cryptographic AES, SHA
  */
 
 TRANS_FEAT(AESE, aa64_aes, do_gvec_op3_ool, a, 0, gen_helper_crypto_aese)
@@ -4597,6 +4597,15 @@ TRANS_FEAT(AESD, aa64_aes, do_gvec_op3_ool, a, 0, gen_helper_crypto_aesd)
 TRANS_FEAT(AESMC, aa64_aes, do_gvec_op2_ool, a, 0, gen_helper_crypto_aesmc)
 TRANS_FEAT(AESIMC, aa64_aes, do_gvec_op2_ool, a, 0, gen_helper_crypto_aesimc)
 
+TRANS_FEAT(SHA1C, aa64_sha1, do_gvec_op3_ool, a, 0, gen_helper_crypto_sha1c)
+TRANS_FEAT(SHA1P, aa64_sha1, do_gvec_op3_ool, a, 0, gen_helper_crypto_sha1p)
+TRANS_FEAT(SHA1M, aa64_sha1, do_gvec_op3_ool, a, 0, gen_helper_crypto_sha1m)
+TRANS_FEAT(SHA1SU0, aa64_sha1, do_gvec_op3_ool, a, 0, gen_helper_crypto_sha1su0)
+
+TRANS_FEAT(SHA256H, aa64_sha256, do_gvec_op3_ool, a, 0, gen_helper_crypto_sha256h)
+TRANS_FEAT(SHA256H2, aa64_sha256, do_gvec_op3_ool, a, 0, gen_helper_crypto_sha256h2)
+TRANS_FEAT(SHA256SU1, aa64_sha256, do_gvec_op3_ool, a, 0, gen_helper_crypto_sha256su1)
+
 /* Shift a TCGv src by TCGv shift_amount, put result in dst.
  * Note that it is the caller's responsibility to ensure that the
  * shift amount is in range (ie 0..31 or 0..63) and provide the ARM
@@ -13490,72 +13499,6 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
     }
 }
 
-/* Crypto three-reg SHA
- *  31             24 23  22  21 20  16  15 14    12 11 10 9    5 4    0
- * +-----------------+------+---+------+---+--------+-----+------+------+
- * | 0 1 0 1 1 1 1 0 | size | 0 |  Rm  | 0 | opcode | 0 0 |  Rn  |  Rd  |
- * +-----------------+------+---+------+---+--------+-----+------+------+
- */
-static void disas_crypto_three_reg_sha(DisasContext *s, uint32_t insn)
-{
-    int size = extract32(insn, 22, 2);
-    int opcode = extract32(insn, 12, 3);
-    int rm = extract32(insn, 16, 5);
-    int rn = extract32(insn, 5, 5);
-    int rd = extract32(insn, 0, 5);
-    gen_helper_gvec_3 *genfn;
-    bool feature;
-
-    if (size != 0) {
-        unallocated_encoding(s);
-        return;
-    }
-
-    switch (opcode) {
-    case 0: /* SHA1C */
-        genfn = gen_helper_crypto_sha1c;
-        feature = dc_isar_feature(aa64_sha1, s);
-        break;
-    case 1: /* SHA1P */
-        genfn = gen_helper_crypto_sha1p;
-        feature = dc_isar_feature(aa64_sha1, s);
-        break;
-    case 2: /* SHA1M */
-        genfn = gen_helper_crypto_sha1m;
-        feature = dc_isar_feature(aa64_sha1, s);
-        break;
-    case 3: /* SHA1SU0 */
-        genfn = gen_helper_crypto_sha1su0;
-        feature = dc_isar_feature(aa64_sha1, s);
-        break;
-    case 4: /* SHA256H */
-        genfn = gen_helper_crypto_sha256h;
-        feature = dc_isar_feature(aa64_sha256, s);
-        break;
-    case 5: /* SHA256H2 */
-        genfn = gen_helper_crypto_sha256h2;
-        feature = dc_isar_feature(aa64_sha256, s);
-        break;
-    case 6: /* SHA256SU1 */
-        genfn = gen_helper_crypto_sha256su1;
-        feature = dc_isar_feature(aa64_sha256, s);
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
-    gen_gvec_op3_ool(s, true, rd, rn, rm, 0, genfn);
-}
-
 /* Crypto two-reg SHA
  *  31             24 23  22 21       17 16    12 11 10 9    5 4    0
  * +-----------------+------+-----------+--------+-----+------+------+
@@ -13899,7 +13842,6 @@ static const AArch64DecodeTable data_proc_simd[] = {
     { 0x5e000400, 0xdfe08400, disas_simd_scalar_copy },
     { 0x5f000000, 0xdf000400, disas_simd_indexed }, /* scalar indexed */
     { 0x5f000400, 0xdf800400, disas_simd_scalar_shift_imm },
-    { 0x5e000000, 0xff208c00, disas_crypto_three_reg_sha },
     { 0x5e280800, 0xff3e0c00, disas_crypto_two_reg_sha },
     { 0xce608000, 0xffe0b000, disas_crypto_three_reg_sha512 },
     { 0xcec08000, 0xfffff000, disas_crypto_two_reg_sha512 },
-- 
2.34.1


