Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE9BFC25B7A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 23:24:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAeER-0006d4-Hs; Fri, 24 May 2024 19:21:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAeEG-0006Tu-MV
 for qemu-devel@nongnu.org; Fri, 24 May 2024 19:21:41 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAeEA-0005kz-NP
 for qemu-devel@nongnu.org; Fri, 24 May 2024 19:21:38 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1f44b5ba445so12728405ad.3
 for <qemu-devel@nongnu.org>; Fri, 24 May 2024 16:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716592893; x=1717197693; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=61o670b1akWNSRNj2BaQ0Tclv08NTSzlJ/p48xm+wOs=;
 b=pJ4TOQpccjxPrDMmBmBjhzCL4kN/OAZNLJFnVSTuQ6/jLaj9+4vLoZHEnEOiRR4F6S
 RuVWk1VQOUGKcHWrwscMkQ3TXM82nigGYDJf5ujTMEDlE6dYmev7M6Kpgin4nR+a+VOB
 71NCrIzi+atvLRMEkRQXWI+3CoejQO0bKUcORIfDgAy4LYidTeydBOeW/YqHDd8El0uj
 bGcONiPSF+wjSUGLolFPP0Hzx4qmwGmUaHw1xyQJW4xB/q2/KJ1ewMBhRM0BgmzH16+D
 lbuUcAlkKR/H09t1zWw3hpG1M5H22tvTpfuzNkm9Araz7OapcFb5ALkacmqgV7/zajsI
 CacQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716592893; x=1717197693;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=61o670b1akWNSRNj2BaQ0Tclv08NTSzlJ/p48xm+wOs=;
 b=BsIm2WJmDPXPaEHvPx5RBZGrewQbQX0qgle/d0uwOUo5y49d+AsT1RERv3jaAqxKcf
 +mNs9JjbbEE4KYHyTXZlGVVocN8iClioLZOMKIxxqT19IN+allpX5aYfojU5YF2vUcxd
 zkArPZ7Z0H9c7nihEefmkGp0A3Juxoa9fPWzRNHxJifrqtn2d3ypYk/dm0GYkcwalNSb
 ysnM9uNXeXVtBRzhJYbSSTek5ht8unz5QPL4KAYHqdnumJndsHxbdGTTArN144l9t87m
 h4aFyl7L4f8ssxwbuTYNeEw1Us7XBa6vjCIboGHzYZs1RO6hdoEab/B84M9CzOliwhQF
 3M2w==
X-Gm-Message-State: AOJu0YwWpM/vi/tNFY+vnY6ip/jMmSdFcbY+dlO+jydgdI2AP43V8eXw
 cH8FEKk1hrj9A6rJNqWSCHXb/KivnCzwVVSF/3qCqHQKV2/j0WsC98C747xrqdTcxoATnBrDuC4
 /
X-Google-Smtp-Source: AGHT+IG2YC4j6Ij0v24DQS2RIYaKAKDaTKupbKT2bXvuilldz+fIbtTfawdGLGcP1QL6QeqYS4v5sA==
X-Received: by 2002:a17:903:228e:b0:1e4:6519:816d with SMTP id
 d9443c01a7336-1f4497df620mr37603525ad.48.1716592893380; 
 Fri, 24 May 2024 16:21:33 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f44c759ceesm19178305ad.10.2024.05.24.16.21.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 May 2024 16:21:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 12/67] target/arm: Convert Cryptographic 3-register SHA512
 to decodetree
Date: Fri, 24 May 2024 16:20:26 -0700
Message-Id: <20240524232121.284515-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240524232121.284515-1-richard.henderson@linaro.org>
References: <20240524232121.284515-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/a64.decode      | 11 ++++
 target/arm/tcg/translate-a64.c | 97 ++++++++--------------------------
 2 files changed, 32 insertions(+), 76 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 350afabc77..c342c27608 100644
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
index 1d20bf0c35..77b24cd52e 100644
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
@@ -13510,80 +13530,6 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
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
@@ -13804,7 +13750,6 @@ static const AArch64DecodeTable data_proc_simd[] = {
     { 0x5e000400, 0xdfe08400, disas_simd_scalar_copy },
     { 0x5f000000, 0xdf000400, disas_simd_indexed }, /* scalar indexed */
     { 0x5f000400, 0xdf800400, disas_simd_scalar_shift_imm },
-    { 0xce608000, 0xffe0b000, disas_crypto_three_reg_sha512 },
     { 0xcec08000, 0xfffff000, disas_crypto_two_reg_sha512 },
     { 0xce000000, 0xff808000, disas_crypto_four_reg },
     { 0xce800000, 0xffe00000, disas_crypto_xar },
-- 
2.34.1


