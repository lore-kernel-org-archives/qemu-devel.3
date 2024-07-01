Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8669CC3065A
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 16:08:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOJa9-0003mI-Lm; Mon, 01 Jul 2024 12:08:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sOJZ8-0000jC-7g
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 12:07:43 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sOJZ3-0005Qr-VH
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 12:07:41 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2ec58040f39so30723921fa.2
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 09:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719850056; x=1720454856; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TwkSgmO9Be8D3RYsOTNA1AgmrtjR1gadtiRZvQ/VZg0=;
 b=qrmw3GV1//fFxHmfilQzldEumLjVPRFrhsKGOPN0THPMNlqKr5ESLoYGd6epktCrZm
 8JKyP1yYKqQ3z/wdhZ2OE2xUe125EWDrXXvWdABDsH48PUSipdSMlUDpetIDaZ5t29Y2
 HuJYLzZlCcLc1WIX3H6qHXWx3JuvYBnMpNPtaJpAFIXmEM/BCxCaNILZKDwpzWWmBtfa
 eB1Pi8h7ZF1eiI77Kta1HcxipXfF3sSTeOgB6herxegOpntjINKVY6d9m67/+pzvNnHO
 TkkMzBiKUQHHEDodYwqFZEqdSh7d8m5SWrykuY7PUAXm6VJWMQFwAVSWqjRSnoejuyXt
 6H3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719850056; x=1720454856;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TwkSgmO9Be8D3RYsOTNA1AgmrtjR1gadtiRZvQ/VZg0=;
 b=F1siNz9FSQmpivNHZq6B3iHnMbo3AVW4fduMAXzDJXzQ1I5wIrYcwVrDkIQHOJyORZ
 ldd4llBKRifzkqjwfeVZwneUHQbO49vw1rDIKQ/YYinmbEdpTC3iQ9Ayg6rmzypBEAEU
 3nQ7Dc/NVst3zfdZmNAGhHe1GLNUZ24NRb/FxdyiUXL5sVNXU0lg6v+w5TOEKGs7iRCF
 LJmY/r+vKQ/dfrZN4w+VYIO/feFusBJF9JfFLrV0wk8nWHA+n+ATwQ8csQRSfstxcPJN
 3RmGzw93M6gclb4QWLHZllbUuMe9QogKR1WGn0zI8PkamVrtU8qatOu1Uhd/p9cL6D0+
 tmgg==
X-Gm-Message-State: AOJu0YyuIDeOdH7/UH5+7wsf8I/cjB2NsPrMlFy2tzrF3ntzWiGoA/Oi
 OyKsbnRBe5QyKJeeb9YVTJvGpob+OZ6BLCK2+YRr/DHu74MGv66FLA3Pt4hjf0xhgQoGY3UQdJa
 xpdg=
X-Google-Smtp-Source: AGHT+IHJ2Y94jzclhbv9iyvI1HhPNOa7gD35W/q83JQOEfQvQj7ZRZNkVjqr4RApwIGgKPjo7FAkyg==
X-Received: by 2002:a05:651c:485:b0:2ec:5061:d7eb with SMTP id
 38308e7fff4ca-2ee5e3910e6mr37448131fa.30.1719850055735; 
 Mon, 01 Jul 2024 09:07:35 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af557fesm161952135e9.11.2024.07.01.09.07.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jul 2024 09:07:35 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/29] target/arm: Convert SUDOT, USDOT to decodetree
Date: Mon,  1 Jul 2024 17:07:12 +0100
Message-Id: <20240701160729.1910763-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240701160729.1910763-1-peter.maydell@linaro.org>
References: <20240701160729.1910763-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x234.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240625183536.1672454-7-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode      |  3 +++
 target/arm/tcg/translate-a64.c | 35 ++++++++--------------------------
 2 files changed, 11 insertions(+), 27 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 7411d4ba979..8a0251f83cf 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -949,6 +949,7 @@ SQRDMLSH_v      0.10 1110 ..0 ..... 10001 1 ..... ..... @qrrr_e
 
 SDOT_v          0.00 1110 100 ..... 10010 1 ..... ..... @qrrr_s
 UDOT_v          0.10 1110 100 ..... 10010 1 ..... ..... @qrrr_s
+USDOT_v         0.00 1110 100 ..... 10011 1 ..... ..... @qrrr_s
 
 ### Advanced SIMD scalar x indexed element
 
@@ -1026,6 +1027,8 @@ SQRDMLSH_vi     0.10 1111 10 .. .... 1111 . 0 ..... .....   @qrrx_s
 
 SDOT_vi         0.00 1111 10 .. .... 1110 . 0 ..... .....   @qrrx_s
 UDOT_vi         0.10 1111 10 .. .... 1110 . 0 ..... .....   @qrrx_s
+SUDOT_vi        0.00 1111 00 .. .... 1111 . 0 ..... .....   @qrrx_s
+USDOT_vi        0.00 1111 10 .. .... 1111 . 0 ..... .....   @qrrx_s
 
 # Floating-point conditional select
 
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index f2e7d8d75c6..9a658ca8769 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -5603,6 +5603,7 @@ static bool do_dot_vector(DisasContext *s, arg_qrrr_e *a,
 
 TRANS_FEAT(SDOT_v, aa64_dp, do_dot_vector, a, gen_helper_gvec_sdot_b)
 TRANS_FEAT(UDOT_v, aa64_dp, do_dot_vector, a, gen_helper_gvec_udot_b)
+TRANS_FEAT(USDOT_v, aa64_i8mm, do_dot_vector, a, gen_helper_gvec_usdot_b)
 
 /*
  * Advanced SIMD scalar/vector x indexed element
@@ -5937,6 +5938,10 @@ static bool do_dot_vector_idx(DisasContext *s, arg_qrrx_e *a,
 
 TRANS_FEAT(SDOT_vi, aa64_dp, do_dot_vector_idx, a, gen_helper_gvec_sdot_idx_b)
 TRANS_FEAT(UDOT_vi, aa64_dp, do_dot_vector_idx, a, gen_helper_gvec_udot_idx_b)
+TRANS_FEAT(SUDOT_vi, aa64_i8mm, do_dot_vector_idx, a,
+           gen_helper_gvec_sudot_idx_b)
+TRANS_FEAT(USDOT_vi, aa64_i8mm, do_dot_vector_idx, a,
+           gen_helper_gvec_usdot_idx_b)
 
 /*
  * Advanced SIMD scalar pairwise
@@ -10914,13 +10919,6 @@ static void disas_simd_three_reg_same_extra(DisasContext *s, uint32_t insn)
     int rot;
 
     switch (u * 16 + opcode) {
-    case 0x03: /* USDOT */
-        if (size != MO_32) {
-            unallocated_encoding(s);
-            return;
-        }
-        feature = dc_isar_feature(aa64_i8mm, s);
-        break;
     case 0x04: /* SMMLA */
     case 0x14: /* UMMLA */
     case 0x05: /* USMMLA */
@@ -10964,6 +10962,7 @@ static void disas_simd_three_reg_same_extra(DisasContext *s, uint32_t insn)
         break;
     default:
     case 0x02: /* SDOT (vector) */
+    case 0x03: /* USDOT */
     case 0x10: /* SQRDMLAH (vector) */
     case 0x11: /* SQRDMLSH (vector) */
     case 0x12: /* UDOT (vector) */
@@ -10979,10 +10978,6 @@ static void disas_simd_three_reg_same_extra(DisasContext *s, uint32_t insn)
     }
 
     switch (opcode) {
-    case 0x3: /* USDOT */
-        gen_gvec_op4_ool(s, is_q, rd, rn, rm, rd, 0, gen_helper_gvec_usdot_b);
-        return;
-
     case 0x04: /* SMMLA, UMMLA */
         gen_gvec_op4_ool(s, 1, rd, rn, rm, rd, 0,
                          u ? gen_helper_gvec_ummla_b
@@ -12058,14 +12053,6 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
         break;
     case 0x0f:
         switch (size) {
-        case 0: /* SUDOT */
-        case 2: /* USDOT */
-            if (is_scalar || !dc_isar_feature(aa64_i8mm, s)) {
-                unallocated_encoding(s);
-                return;
-            }
-            size = MO_32;
-            break;
         case 1: /* BFDOT */
             if (is_scalar || !dc_isar_feature(aa64_bf16, s)) {
                 unallocated_encoding(s);
@@ -12082,6 +12069,8 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
             size = MO_16;
             break;
         default:
+        case 0: /* SUDOT */
+        case 2: /* USDOT */
             unallocated_encoding(s);
             return;
         }
@@ -12190,18 +12179,10 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
     switch (16 * u + opcode) {
     case 0x0f:
         switch (extract32(insn, 22, 2)) {
-        case 0: /* SUDOT */
-            gen_gvec_op4_ool(s, is_q, rd, rn, rm, rd, index,
-                             gen_helper_gvec_sudot_idx_b);
-            return;
         case 1: /* BFDOT */
             gen_gvec_op4_ool(s, is_q, rd, rn, rm, rd, index,
                              gen_helper_gvec_bfdot_idx);
             return;
-        case 2: /* USDOT */
-            gen_gvec_op4_ool(s, is_q, rd, rn, rm, rd, index,
-                             gen_helper_gvec_usdot_idx_b);
-            return;
         case 3: /* BFMLAL{B,T} */
             gen_gvec_op4_fpst(s, 1, rd, rn, rm, rd, 0, (index << 1) | is_q,
                               gen_helper_gvec_bfmlal_idx);
-- 
2.34.1


