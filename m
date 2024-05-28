Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63705C25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 14:13:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBxUt-0001ds-Bq; Tue, 28 May 2024 10:08:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBxUs-0001cf-8m
 for qemu-devel@nongnu.org; Tue, 28 May 2024 10:08:14 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBxUo-00074a-3z
 for qemu-devel@nongnu.org; Tue, 28 May 2024 10:08:13 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-421087b6f3fso6866285e9.1
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 07:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716905288; x=1717510088; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7BpILccreJv3wPcv9huqs/UAol5xV2assISwJtuW028=;
 b=IBIsfOCaxabwhP53mrIqLIwBTcuasN31Aq7McSggh45QFBeVjPgGRV16JUbW849MH3
 AyKPegqjOjPJTOF6QdTbE6T6JSAzavSqZTsCK5/sEfDDcCXC/JEe7oM1968nq8nEX+od
 Q5bPXwIZW4ps6TuxIXKrpdjiuEyZycCgNvFtuAXzMaZTeDzYOmXYs7Mizo4HoWczLBZ/
 5ds0Q1BgKxEdSvL5FER8WVhYu7ZsFkZeNrtQUCYDme5HE3YtYhs/9iPXK/pTlDhQiDw2
 crEGA7DMccsX0COtapLdnVBfkeoXVnse0EdKv/M3sVgfpWmFluQkMhaWBS8Q3q8xVtUQ
 Ta4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716905288; x=1717510088;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7BpILccreJv3wPcv9huqs/UAol5xV2assISwJtuW028=;
 b=UwkPYrguDtt4Un0OOeJ2pXlWuRpM/RlqkhdMHd8jY1zBRtvkwRP+erHDpGTeDZvmOU
 DGNRL+9K7zrK2BaBQ3z+DHaSA5QRFsiKKQdS81tCQXM3zejEFO0YuhzQvUCmL/knG18b
 4QrXMUYlZ/hw6sO1PrFZ0KGIgvvYngGck/NJ5/Oe+7t7YPDiR1fz0+fl0boOMEJsj1xj
 laqim75RiG8vC3RJKE6/ylCHtkfV0qS5HDxKxG1z2/w0uFF41OAVbDo1asWazJGO+6Ik
 OpSru3v96p6kkTDk5qn2ji1NTebJ3Ga7kD4MbRJPbf69QyPT0c+K9jFsAtJ0stt8wwVe
 vTkg==
X-Gm-Message-State: AOJu0YwCHB/ZXfQPN97JrfNsOQF+85y5o1kHNbZ5tr8ps+13YWO+bRf1
 gQTwkotSFQIot3OXXljjAiUkinsIwc+7/7MurDgUBHZ78pHoIYFnWFTrHnYD9rk3XnMQ6iHhinE
 Y
X-Google-Smtp-Source: AGHT+IHSR8EFgeDmWdodHHdWlEXVugRpnzeehSqScFuKNwrd6MOOlICjO+iIMViZaVdx30CHcpK43g==
X-Received: by 2002:adf:fcce:0:b0:34b:81b3:2c62 with SMTP id
 ffacd0b85a97d-3552219d1e6mr8183411f8f.35.1716905288645; 
 Tue, 28 May 2024 07:08:08 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3564afc3577sm11361473f8f.102.2024.05.28.07.08.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 07:08:08 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 22/42] target/arm: Convert XAR to decodetree
Date: Tue, 28 May 2024 15:07:33 +0100
Message-Id: <20240528140753.3620597-23-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240528140753.3620597-1-peter.maydell@linaro.org>
References: <20240528140753.3620597-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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
Message-id: 20240524232121.284515-17-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode      |  4 ++++
 target/arm/tcg/translate-a64.c | 43 +++++++++++-----------------------
 2 files changed, 18 insertions(+), 29 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 1292312a7f9..7f354af25d3 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -654,3 +654,7 @@ SM3TT1A         11001110 010 ..... 10 .. 00 ..... ..... @crypto3i
 SM3TT1B         11001110 010 ..... 10 .. 01 ..... ..... @crypto3i
 SM3TT2A         11001110 010 ..... 10 .. 10 ..... ..... @crypto3i
 SM3TT2B         11001110 010 ..... 10 .. 11 ..... ..... @crypto3i
+
+### Cryptographic XAR
+
+XAR             1100 1110 100 rm:5 imm:6 rn:5 rd:5
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index cf3a7dfa99f..75f1e6a7b90 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -4688,6 +4688,20 @@ TRANS_FEAT(SM3TT1B, aa64_sm3, do_crypto3i, a, gen_helper_crypto_sm3tt1b)
 TRANS_FEAT(SM3TT2A, aa64_sm3, do_crypto3i, a, gen_helper_crypto_sm3tt2a)
 TRANS_FEAT(SM3TT2B, aa64_sm3, do_crypto3i, a, gen_helper_crypto_sm3tt2b)
 
+static bool trans_XAR(DisasContext *s, arg_XAR *a)
+{
+    if (!dc_isar_feature(aa64_sha3, s)) {
+        return false;
+    }
+    if (fp_access_check(s)) {
+        gen_gvec_xar(MO_64, vec_full_reg_offset(s, a->rd),
+                     vec_full_reg_offset(s, a->rn),
+                     vec_full_reg_offset(s, a->rm), a->imm, 16,
+                     vec_full_reg_size(s));
+    }
+    return true;
+}
+
 /* Shift a TCGv src by TCGv shift_amount, put result in dst.
  * Note that it is the caller's responsibility to ensure that the
  * shift amount is in range (ie 0..31 or 0..63) and provide the ARM
@@ -13588,34 +13602,6 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
     }
 }
 
-/* Crypto XAR
- *  31                   21 20  16 15    10 9    5 4    0
- * +-----------------------+------+--------+------+------+
- * | 1 1 0 0 1 1 1 0 1 0 0 |  Rm  |  imm6  |  Rn  |  Rd  |
- * +-----------------------+------+--------+------+------+
- */
-static void disas_crypto_xar(DisasContext *s, uint32_t insn)
-{
-    int rm = extract32(insn, 16, 5);
-    int imm6 = extract32(insn, 10, 6);
-    int rn = extract32(insn, 5, 5);
-    int rd = extract32(insn, 0, 5);
-
-    if (!dc_isar_feature(aa64_sha3, s)) {
-        unallocated_encoding(s);
-        return;
-    }
-
-    if (!fp_access_check(s)) {
-        return;
-    }
-
-    gen_gvec_xar(MO_64, vec_full_reg_offset(s, rd),
-                 vec_full_reg_offset(s, rn),
-                 vec_full_reg_offset(s, rm), imm6, 16,
-                 vec_full_reg_size(s));
-}
-
 /* C3.6 Data processing - SIMD, inc Crypto
  *
  * As the decode gets a little complex we are using a table based
@@ -13644,7 +13630,6 @@ static const AArch64DecodeTable data_proc_simd[] = {
     { 0x5e000400, 0xdfe08400, disas_simd_scalar_copy },
     { 0x5f000000, 0xdf000400, disas_simd_indexed }, /* scalar indexed */
     { 0x5f000400, 0xdf800400, disas_simd_scalar_shift_imm },
-    { 0xce800000, 0xffe00000, disas_crypto_xar },
     { 0x0e400400, 0x9f60c400, disas_simd_three_reg_same_fp16 },
     { 0x0e780800, 0x8f7e0c00, disas_simd_two_reg_misc_fp16 },
     { 0x5e400400, 0xdf60c400, disas_simd_scalar_three_reg_same_fp16 },
-- 
2.34.1


