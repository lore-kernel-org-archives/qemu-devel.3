Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4B91C25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 15:38:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAATn-0008KR-I4; Thu, 23 May 2024 11:35:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sAATi-00086x-MY
 for qemu-devel@nongnu.org; Thu, 23 May 2024 11:35:38 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sAATZ-0002U5-Ke
 for qemu-devel@nongnu.org; Thu, 23 May 2024 11:35:38 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2e27277d2c1so104452921fa.2
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 08:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716478514; x=1717083314; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pVUSnQhr/3Dq4fHlvrdaXEoKsPCKh1TB7p+Ph6EbJEE=;
 b=jDYa6aZUCU1qat26GVyfEwrdE0neqqHmEXwSzLtpGvpE++vi8TzXY+HmdLjwW0pXo9
 lFTl3f+wLLSGe3gWBoNlv8OrU+Z9F/NNHLsq7snTteEPFilVu6rnFiWpsLgQTSiKqaCx
 wqhYTiqokduYNLCsc0O3LoC8833omwX5IoiHmmkbj+AM3Z0FDN88mhF0adOuD9olw1rH
 PAtF3qaUSjkbq2SZco0SelbbRPh3KY5b9iUSfdkiTtRk63IwvLQJq8xpqWj7eMMPDduc
 PpUWQKPlXvFfuTt0/cnJRUsDdqEVFeuFZ6pgsX8e/ViSCZ+FjHBCOb515GprLunkUgQr
 wENQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716478514; x=1717083314;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pVUSnQhr/3Dq4fHlvrdaXEoKsPCKh1TB7p+Ph6EbJEE=;
 b=JFmYMVyP5hlDhOuAkcmAIBHaI4ap+rZaigQdI1d8S5cCSuzCSCFnnevJPlmVnRXUaj
 LaUlm51svDamhIbO6zgQvYRD+h4JRBw3oqjKZX1VlDbvPkZx3k1O1rnAH7euCaVlPc7L
 6+dB5P0KW2+fZZrIZnj7RTc7M8zmY+re2T80kp8jUNUsVTQaGx347Wqn071vszRIWjPx
 QHCDJ20miSAY1c59lsdXhZcriRd+GyPrcI5882vO8SstkpbAyeHKL8NjJvU4XKav/jJg
 DW5BSuOKVEMKtUgL3iw+xHhUxAQwAzNQXYw4c3u1Se1IGJSEqP4ssjTkQ3OJ3XPeJjuc
 XqKw==
X-Gm-Message-State: AOJu0Yz4bG35v7so9AbSBaQoH8fLMY7nm0UXKB70mxuCDMRknRYrMDRy
 Z3csNE1jY0517MKVj9RFZNayAvYG3GBAfOzFtxrBgkIf/G8E8rkV9p7fQ6vWelEBRdfMH/ZGAV4
 P
X-Google-Smtp-Source: AGHT+IGideXjwujwisBJGhl3Z0m4IeUgb952KRCxPAd1ues/EjAKg/pE22Sd/LdyzixmQGZJeTk/gA==
X-Received: by 2002:a05:651c:604:b0:2d4:3e82:117e with SMTP id
 38308e7fff4ca-2e9495afe3amr30673821fa.32.1716478514295; 
 Thu, 23 May 2024 08:35:14 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-354df9b51f7sm3888255f8f.59.2024.05.23.08.35.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 08:35:14 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/37] target/arm: Convert Cryptographic 3-register SHA512 to
 decodetree
Date: Thu, 23 May 2024 16:34:42 +0100
Message-Id: <20240523153505.2900433-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240523153505.2900433-1-peter.maydell@linaro.org>
References: <20240523153505.2900433-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x236.google.com
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
Message-id: 20240506010403.6204-7-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode      | 11 ++++
 target/arm/tcg/translate-a64.c | 97 ++++++++--------------------------
 2 files changed, 32 insertions(+), 76 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 350afabc779..c342c276089 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -31,6 +31,7 @@
 @rr_q1e0        ........ ........ ...... rn:5 rd:5      &qrr_e q=1 esz=0
 @r2r_q1e0       ........ ........ ...... rm:5 rd:5      &qrrr_e rn=%rd q=1 esz=0
 @rrr_q1e0       ........ ... rm:5 ...... rn:5 rd:5      &qrrr_e q=1 esz=0
+@rrr_q1e3       ........ ... rm:5 ...... rn:5 rd:5      &qrrr_e q=1 esz=3
 
 ### Data Processing - Immediate
 
@@ -620,3 +621,13 @@ SHA256SU1       0101 1110 000 ..... 011000 ..... .....  @rrr_q1e0
 SHA1H           0101 1110 0010 1000 0000 10 ..... ..... @rr_q1e0
 SHA1SU1         0101 1110 0010 1000 0001 10 ..... ..... @rr_q1e0
 SHA256SU0       0101 1110 0010 1000 0010 10 ..... ..... @rr_q1e0
+
+### Cryptographic three-register SHA512
+
+SHA512H         1100 1110 011 ..... 100000 ..... .....  @rrr_q1e0
+SHA512H2        1100 1110 011 ..... 100001 ..... .....  @rrr_q1e0
+SHA512SU1       1100 1110 011 ..... 100010 ..... .....  @rrr_q1e0
+RAX1            1100 1110 011 ..... 100011 ..... .....  @rrr_q1e3
+SM3PARTW1       1100 1110 011 ..... 110000 ..... .....  @rrr_q1e0
+SM3PARTW2       1100 1110 011 ..... 110001 ..... .....  @rrr_q1e0
+SM4EKEY         1100 1110 011 ..... 110010 ..... .....  @rrr_q1e0
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 11a25158f62..3592db19379 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -1341,6 +1341,17 @@ static bool do_gvec_op3_ool(DisasContext *s, arg_qrrr_e *a, int data,
     return true;
 }
 
+static bool do_gvec_fn3(DisasContext *s, arg_qrrr_e *a, GVecGen3Fn *fn)
+{
+    if (!a->q && a->esz == MO_64) {
+        return false;
+    }
+    if (fp_access_check(s)) {
+        gen_gvec_fn3(s, a->q, a->rd, a->rn, a->rm, fn, a->esz);
+    }
+    return true;
+}
+
 /*
  * This utility function is for doing register extension with an
  * optional shift. You will likely want to pass a temporary for the
@@ -4589,7 +4600,7 @@ static bool trans_EXTR(DisasContext *s, arg_extract *a)
 }
 
 /*
- * Cryptographic AES, SHA
+ * Cryptographic AES, SHA, SHA512
  */
 
 TRANS_FEAT(AESE, aa64_aes, do_gvec_op3_ool, a, 0, gen_helper_crypto_aese)
@@ -4610,6 +4621,15 @@ TRANS_FEAT(SHA1H, aa64_sha1, do_gvec_op2_ool, a, 0, gen_helper_crypto_sha1h)
 TRANS_FEAT(SHA1SU1, aa64_sha1, do_gvec_op2_ool, a, 0, gen_helper_crypto_sha1su1)
 TRANS_FEAT(SHA256SU0, aa64_sha256, do_gvec_op2_ool, a, 0, gen_helper_crypto_sha256su0)
 
+TRANS_FEAT(SHA512H, aa64_sha512, do_gvec_op3_ool, a, 0, gen_helper_crypto_sha512h)
+TRANS_FEAT(SHA512H2, aa64_sha512, do_gvec_op3_ool, a, 0, gen_helper_crypto_sha512h2)
+TRANS_FEAT(SHA512SU1, aa64_sha512, do_gvec_op3_ool, a, 0, gen_helper_crypto_sha512su1)
+TRANS_FEAT(RAX1, aa64_sha3, do_gvec_fn3, a, gen_gvec_rax1)
+TRANS_FEAT(SM3PARTW1, aa64_sm3, do_gvec_op3_ool, a, 0, gen_helper_crypto_sm3partw1)
+TRANS_FEAT(SM3PARTW2, aa64_sm3, do_gvec_op3_ool, a, 0, gen_helper_crypto_sm3partw2)
+TRANS_FEAT(SM4EKEY, aa64_sm4, do_gvec_op3_ool, a, 0, gen_helper_crypto_sm4ekey)
+
+
 /* Shift a TCGv src by TCGv shift_amount, put result in dst.
  * Note that it is the caller's responsibility to ensure that the
  * shift amount is in range (ie 0..31 or 0..63) and provide the ARM
@@ -13503,80 +13523,6 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
     }
 }
 
-/* Crypto three-reg SHA512
- *  31                   21 20  16 15  14  13 12  11  10  9    5 4    0
- * +-----------------------+------+---+---+-----+--------+------+------+
- * | 1 1 0 0 1 1 1 0 0 1 1 |  Rm  | 1 | O | 0 0 | opcode |  Rn  |  Rd  |
- * +-----------------------+------+---+---+-----+--------+------+------+
- */
-static void disas_crypto_three_reg_sha512(DisasContext *s, uint32_t insn)
-{
-    int opcode = extract32(insn, 10, 2);
-    int o =  extract32(insn, 14, 1);
-    int rm = extract32(insn, 16, 5);
-    int rn = extract32(insn, 5, 5);
-    int rd = extract32(insn, 0, 5);
-    bool feature;
-    gen_helper_gvec_3 *oolfn = NULL;
-    GVecGen3Fn *gvecfn = NULL;
-
-    if (o == 0) {
-        switch (opcode) {
-        case 0: /* SHA512H */
-            feature = dc_isar_feature(aa64_sha512, s);
-            oolfn = gen_helper_crypto_sha512h;
-            break;
-        case 1: /* SHA512H2 */
-            feature = dc_isar_feature(aa64_sha512, s);
-            oolfn = gen_helper_crypto_sha512h2;
-            break;
-        case 2: /* SHA512SU1 */
-            feature = dc_isar_feature(aa64_sha512, s);
-            oolfn = gen_helper_crypto_sha512su1;
-            break;
-        case 3: /* RAX1 */
-            feature = dc_isar_feature(aa64_sha3, s);
-            gvecfn = gen_gvec_rax1;
-            break;
-        default:
-            g_assert_not_reached();
-        }
-    } else {
-        switch (opcode) {
-        case 0: /* SM3PARTW1 */
-            feature = dc_isar_feature(aa64_sm3, s);
-            oolfn = gen_helper_crypto_sm3partw1;
-            break;
-        case 1: /* SM3PARTW2 */
-            feature = dc_isar_feature(aa64_sm3, s);
-            oolfn = gen_helper_crypto_sm3partw2;
-            break;
-        case 2: /* SM4EKEY */
-            feature = dc_isar_feature(aa64_sm4, s);
-            oolfn = gen_helper_crypto_sm4ekey;
-            break;
-        default:
-            unallocated_encoding(s);
-            return;
-        }
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
-
-    if (oolfn) {
-        gen_gvec_op3_ool(s, true, rd, rn, rm, 0, oolfn);
-    } else {
-        gen_gvec_fn3(s, true, rd, rn, rm, gvecfn, MO_64);
-    }
-}
-
 /* Crypto two-reg SHA512
  *  31                                     12  11  10  9    5 4    0
  * +-----------------------------------------+--------+------+------+
@@ -13797,7 +13743,6 @@ static const AArch64DecodeTable data_proc_simd[] = {
     { 0x5e000400, 0xdfe08400, disas_simd_scalar_copy },
     { 0x5f000000, 0xdf000400, disas_simd_indexed }, /* scalar indexed */
     { 0x5f000400, 0xdf800400, disas_simd_scalar_shift_imm },
-    { 0xce608000, 0xffe0b000, disas_crypto_three_reg_sha512 },
     { 0xcec08000, 0xfffff000, disas_crypto_two_reg_sha512 },
     { 0xce000000, 0xff808000, disas_crypto_four_reg },
     { 0xce800000, 0xffe00000, disas_crypto_xar },
-- 
2.34.1


