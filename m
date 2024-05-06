Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8655FC25B10
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 01:06:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3mmE-0007cE-53; Sun, 05 May 2024 21:04:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s3mm6-0007a4-FY
 for qemu-devel@nongnu.org; Sun, 05 May 2024 21:04:15 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s3mm2-0002QG-0q
 for qemu-devel@nongnu.org; Sun, 05 May 2024 21:04:12 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6f43ee95078so1218043b3a.1
 for <qemu-devel@nongnu.org>; Sun, 05 May 2024 18:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714957448; x=1715562248; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aquqtgyprD8GqAQ4MMnB5w7emoyugrccNtEaKLtPj1U=;
 b=wszlZ9N5f9nAkeiDIQrkXkguej+p3AXZ5n6mjsujNRBzzmC7I7HVqIdAX05VwKgsX6
 yEd94VX9gJ8weyYPzLCjeChPhiGb6mbsynLSZF6ZNPooH5UYbtgItcpS8aVKf1Y0Gzjs
 I16ltYztmPOMid576faSn7a1Gr87+W0eCT9QiM9RqzbJF1sUhWjpulA6YIG37JyRkfB1
 f4RNVmyc2Xk5smcc3km1KqIcGUx3MJodAx/cUA8ps0zTByd4hHskciRVao0inP/1EDDm
 OPT3LTLBj/cAaHNn/zhsSuNuwfrII3FPVy5R0CguGXcqoLj51woDU/xcEr4iCGaqEaYM
 azOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714957448; x=1715562248;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aquqtgyprD8GqAQ4MMnB5w7emoyugrccNtEaKLtPj1U=;
 b=Je9uZWV/yhlGCY87owgUN8ZF5ERxxC3PpXUs21WaxUcWmg6tHMAdodkR4+Fq0VSzTN
 0Km9M6oizqEXn8sfQLSxGLnYbe6pmnzpGdn1yrtt2v4zrTikCtCIj7/iFF5IoUVXsr+Q
 JMkTGiBHUHNgjOiHkGXGKpKN/UBdEXy5Wg7cn5WdOdEODiapxpqSunKLANKxpCOKUC0e
 08FUKMFMmIsr9AnzUEk8OrLgyf2iZZ6VDiRERKM28znXKhVMojxfVYwLoIfi/n46MKWj
 TdThExn7wuVGf6zHafpxEAxsFrzNJOaGLomerYQqCKWjrx2YvU7+h6nQKEajeXSk4ho3
 Dibg==
X-Gm-Message-State: AOJu0YytPx/jL0WZPXtPo2zpGa+TbimUrY7y13AFf0kKn8f3Sp1y+rik
 WjhA5mqEonlb0hnxR1kRqzYmqzgq78a1jNCPE9EHLSVkHzzOmqJBl03XZxJfSy8icmmFB6X/tU4
 x
X-Google-Smtp-Source: AGHT+IFtGGapn4wZYMdydHAMLX5Q64Xp3G4AodmD4iKaAFFNlTldSN1MsmmUHS9X4Y1wfMBA0WowBw==
X-Received: by 2002:a05:6a21:6d81:b0:1a3:ae18:f1e4 with SMTP id
 wl1-20020a056a216d8100b001a3ae18f1e4mr9442880pzb.34.1714957448481; 
 Sun, 05 May 2024 18:04:08 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 pv7-20020a17090b3c8700b002a5f44353d2sm8958232pjb.7.2024.05.05.18.04.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 May 2024 18:04:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 03/57] target/arm: Convert Cryptographic AES to decodetree
Date: Sun,  5 May 2024 18:03:09 -0700
Message-Id: <20240506010403.6204-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240506010403.6204-1-richard.henderson@linaro.org>
References: <20240506010403.6204-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/a64.decode      | 21 +++++++--
 target/arm/tcg/translate-a64.c | 86 +++++++++++++++-------------------
 2 files changed, 54 insertions(+), 53 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 0e7656fd15..1de09903dc 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -19,11 +19,17 @@
 # This file is processed by scripts/decodetree.py
 #
 
-&r               rn
-&ri              rd imm
-&rri_sf          rd rn imm sf
-&i               imm
+%rd             0:5
 
+&r              rn
+&ri             rd imm
+&rri_sf         rd rn imm sf
+&i              imm
+&qrr_e          q rd rn esz
+&qrrr_e         q rd rn rm esz
+
+@rr_q1e0        ........ ........ ...... rn:5 rd:5      &qrr_e q=1 esz=0
+@r2r_q1e0       ........ ........ ...... rm:5 rd:5      &qrrr_e rn=%rd q=1 esz=0
 
 ### Data Processing - Immediate
 
@@ -590,3 +596,10 @@ CPYFE           00 011 0 01100 ..... .... 01 ..... ..... @cpy
 CPYP            00 011 1 01000 ..... .... 01 ..... ..... @cpy
 CPYM            00 011 1 01010 ..... .... 01 ..... ..... @cpy
 CPYE            00 011 1 01100 ..... .... 01 ..... ..... @cpy
+
+### Cryptographic AES
+
+AESE            01001110 00 10100 00100 10 ..... .....  @r2r_q1e0
+AESD            01001110 00 10100 00101 10 ..... .....  @r2r_q1e0
+AESMC           01001110 00 10100 00110 10 ..... .....  @rr_q1e0
+AESIMC          01001110 00 10100 00111 10 ..... .....  @rr_q1e0
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 283078d385..1ba6a30176 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -1314,6 +1314,34 @@ bool sme_enabled_check_with_svcr(DisasContext *s, unsigned req)
     return true;
 }
 
+/*
+ * Expanders for AdvSIMD translation functions.
+ */
+
+static bool do_gvec_op2_ool(DisasContext *s, arg_qrr_e *a, int data,
+                            gen_helper_gvec_2 *fn)
+{
+    if (!a->q && a->esz == MO_64) {
+        return false;
+    }
+    if (fp_access_check(s)) {
+        gen_gvec_op2_ool(s, a->q, a->rd, a->rn, data, fn);
+    }
+    return true;
+}
+
+static bool do_gvec_op3_ool(DisasContext *s, arg_qrrr_e *a, int data,
+                            gen_helper_gvec_3 *fn)
+{
+    if (!a->q && a->esz == MO_64) {
+        return false;
+    }
+    if (fp_access_check(s)) {
+        gen_gvec_op3_ool(s, a->q, a->rd, a->rn, a->rm, data, fn);
+    }
+    return true;
+}
+
 /*
  * This utility function is for doing register extension with an
  * optional shift. You will likely want to pass a temporary for the
@@ -4561,6 +4589,15 @@ static bool trans_EXTR(DisasContext *s, arg_extract *a)
     return true;
 }
 
+/*
+ * Cryptographic AES
+ */
+
+TRANS_FEAT(AESE, aa64_aes, do_gvec_op3_ool, a, 0, gen_helper_crypto_aese)
+TRANS_FEAT(AESD, aa64_aes, do_gvec_op3_ool, a, 0, gen_helper_crypto_aesd)
+TRANS_FEAT(AESMC, aa64_aes, do_gvec_op2_ool, a, 0, gen_helper_crypto_aesmc)
+TRANS_FEAT(AESIMC, aa64_aes, do_gvec_op2_ool, a, 0, gen_helper_crypto_aesimc)
+
 /* Shift a TCGv src by TCGv shift_amount, put result in dst.
  * Note that it is the caller's responsibility to ensure that the
  * shift amount is in range (ie 0..31 or 0..63) and provide the ARM
@@ -13454,54 +13491,6 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
     }
 }
 
-/* Crypto AES
- *  31             24 23  22 21       17 16    12 11 10 9    5 4    0
- * +-----------------+------+-----------+--------+-----+------+------+
- * | 0 1 0 0 1 1 1 0 | size | 1 0 1 0 0 | opcode | 1 0 |  Rn  |  Rd  |
- * +-----------------+------+-----------+--------+-----+------+------+
- */
-static void disas_crypto_aes(DisasContext *s, uint32_t insn)
-{
-    int size = extract32(insn, 22, 2);
-    int opcode = extract32(insn, 12, 5);
-    int rn = extract32(insn, 5, 5);
-    int rd = extract32(insn, 0, 5);
-    gen_helper_gvec_2 *genfn2 = NULL;
-    gen_helper_gvec_3 *genfn3 = NULL;
-
-    if (!dc_isar_feature(aa64_aes, s) || size != 0) {
-        unallocated_encoding(s);
-        return;
-    }
-
-    switch (opcode) {
-    case 0x4: /* AESE */
-        genfn3 = gen_helper_crypto_aese;
-        break;
-    case 0x6: /* AESMC */
-        genfn2 = gen_helper_crypto_aesmc;
-        break;
-    case 0x5: /* AESD */
-        genfn3 = gen_helper_crypto_aesd;
-        break;
-    case 0x7: /* AESIMC */
-        genfn2 = gen_helper_crypto_aesimc;
-        break;
-    default:
-        unallocated_encoding(s);
-        return;
-    }
-
-    if (!fp_access_check(s)) {
-        return;
-    }
-    if (genfn2) {
-        gen_gvec_op2_ool(s, true, rd, rn, 0, genfn2);
-    } else {
-        gen_gvec_op3_ool(s, true, rd, rd, rn, 0, genfn3);
-    }
-}
-
 /* Crypto three-reg SHA
  *  31             24 23  22  21 20  16  15 14    12 11 10 9    5 4    0
  * +-----------------+------+---+------+---+--------+-----+------+------+
@@ -13911,7 +13900,6 @@ static const AArch64DecodeTable data_proc_simd[] = {
     { 0x5e000400, 0xdfe08400, disas_simd_scalar_copy },
     { 0x5f000000, 0xdf000400, disas_simd_indexed }, /* scalar indexed */
     { 0x5f000400, 0xdf800400, disas_simd_scalar_shift_imm },
-    { 0x4e280800, 0xff3e0c00, disas_crypto_aes },
     { 0x5e000000, 0xff208c00, disas_crypto_three_reg_sha },
     { 0x5e280800, 0xff3e0c00, disas_crypto_two_reg_sha },
     { 0xce608000, 0xffe0b000, disas_crypto_three_reg_sha512 },
-- 
2.34.1


