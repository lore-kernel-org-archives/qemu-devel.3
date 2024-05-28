Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E336C27C44
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 14:12:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBxUq-0001ba-Dt; Tue, 28 May 2024 10:08:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBxUo-0001b0-H0
 for qemu-devel@nongnu.org; Tue, 28 May 2024 10:08:10 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBxUl-000743-PR
 for qemu-devel@nongnu.org; Tue, 28 May 2024 10:08:10 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-354faf5f1b4so666916f8f.1
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 07:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716905286; x=1717510086; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VPzY7vRQK/tFc1bvvOxU2Y3WTOQVdjIhkOjnl3uekmc=;
 b=LxRJ6/tzWmIDtSrD1vv0klFkgFJot0fSlUuI+QtfYrtMcMzqmVX2gCyhwPzBP26+6H
 whIPVItCMgl1VdmXOPKei9B1M26FlLuhBoxpw6oGfZ1gCYLZgO43UkcZXJ1YUOny1VAi
 SYlpDH+DR5qDUHK7VPIZHYFhQ6lj5vysWrFE05uM5RqcnrTtxxujio/sOXo7xKFWuO8n
 oQO1JQTWrLK0zPxG2/48cG20IU+Fsx7BTba31f/KrQ3BP3oqGfs0HHtbDrWn3DZSIF0k
 7MTIfyeox4Ube5vgUlBpksW02VvD5xq3vUcYfafVD17TttsnZE8meDWRTyHpvIHzzb76
 W1Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716905286; x=1717510086;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VPzY7vRQK/tFc1bvvOxU2Y3WTOQVdjIhkOjnl3uekmc=;
 b=SBJFqr9snTVeq4f5UFmRR1RPkG/E0zkBWn8kBruk78ncggzM4/oWAgc8M3FHs/GKa8
 zcqtIQBXcOvIjZPz2cqEHdJcz4JJBadYLUY02hYFlrrlxU8ciDT9VwKA8UHA8rhINvw3
 T/yCQWA1K1ByXp8RH1ms/+ES1Mdi79z+qhKDX6VoCgg5DhCFoDDTcEkjSJ1ULy09BVax
 quB9Foajjj4IyMAUnGNqwp6zimyfDG6uvvcHirQqEjpZeXashvZFox0EvcXWYfZWoY+s
 iYDTVMEmxCMhfk+LZGEu5GFTIC0aibB8AHt/C6GdLCziSnNeCWjat7xsj0yagIaCimW6
 ohQA==
X-Gm-Message-State: AOJu0YwxUJKYXNvlPrJVUu2xx63vUaNeMjZBk6WdVFDpfa4644y5FlJv
 RR5E94/eTwM2IGODVCym1U073yjhcmfDMNhzQ298KYyGX0oFHxHdMwjrj4rhzyUUSAqmb02mTJ5
 o
X-Google-Smtp-Source: AGHT+IGV620PzFit4YJxj5L/91FaX9k+Vr3YM5Y99JipUs8nbJBwMKkeVVfAbNMbnG0xrMZb7uRozQ==
X-Received: by 2002:a5d:62cc:0:b0:354:d098:8d67 with SMTP id
 ffacd0b85a97d-3552fe179a1mr10570355f8f.57.1716905286211; 
 Tue, 28 May 2024 07:08:06 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3564afc3577sm11361473f8f.102.2024.05.28.07.08.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 07:08:05 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/42] target/arm: Convert Cryptographic 3-register SHA512 to
 decodetree
Date: Tue, 28 May 2024 15:07:29 +0100
Message-Id: <20240528140753.3620597-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240528140753.3620597-1-peter.maydell@linaro.org>
References: <20240528140753.3620597-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240524232121.284515-13-richard.henderson@linaro.org
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
index 1d20bf0c35b..77b24cd52ed 100644
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


