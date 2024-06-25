Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A80FDC2BBCA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 18:53:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMB7J-0001YM-1O; Tue, 25 Jun 2024 14:42:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sMB44-0000wr-Tv
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 14:38:57 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sMB2q-00066c-UT
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 14:38:39 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1fa2ea1c443so23091735ad.0
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2024 11:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719340544; x=1719945344; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wsKF91GwX4/Knu6MbETuxw4jFllUHVVW6ayUlN0J0DQ=;
 b=xNOYjSaDJrUVpHygzM01J8Z6foF5lHqzbog8hYIbqd0s6EQyiPVSTdV7d9N0rLretU
 FepHmDElB2ywoS+xLmgweZUBXTOhMLGBsnQikrX1Hq+pHvpc7BJccCzftf0quVXcwcVV
 2X/KIyNQI5Bn1Ou6dV7J64oqeu3QL4t7gnBqZncuL4XKpaZ4p2e0sNcWBllU5Q9crN4l
 U183x+0Yeg/xelMu8awtA5OOfpyuBKdorhIfYW75EuJdhuKFRGiZEZXzv6ect0Mcri/8
 0Jdy5VrAtOOMCTLvceU59Bqca9pRrrJKc2NRjcyVXn8RrVvu8TfBEvyOgeW7QV6cr9eT
 hAbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719340544; x=1719945344;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wsKF91GwX4/Knu6MbETuxw4jFllUHVVW6ayUlN0J0DQ=;
 b=IO7JnGTvx3F/Gh3fzYnah1aql8HuMO9py7ijsAxf8Kwetr1TFmH9nRDArYgn/7+96W
 IJjuZXtCjXby5uIseojT9ai6DJwHZ37C2nTQBd6YVUl5/96UfcDIbSkenOQDPhfulogc
 eheTwq6vS4mAaNTicveGbAp7jBUo9l8bwUYwbeEWRg3XGnpL/flD2y3yCVMOco3ySbLy
 zIU9llmPSbMmRuVbwbPRTRSWkXP4tEkQDRYEEfy3PXajTHITfJhTbs+NB+HFzDCJcimB
 SzGx/KBS0WIO7OAoyfkE4SV4rNGbuUfpxLL2dZJIDyefMFbdn+H3HsmSiP4/vc9zPeNg
 PLoA==
X-Gm-Message-State: AOJu0Yx+j/O/aV341kQapkn3bmfpPTPKX7M2QWuYrc4cDwRzq/ekqXdw
 iDARGaffmoIJnBQC6NcnOlxAHnivLBYYUSKXtP2lIsGV5GX8J+ir+559bE1xfRS8DGeQGbTwB37
 c
X-Google-Smtp-Source: AGHT+IHSHVekOq6k8kQ1LaTC/I9rHDeQ584jfWTN7v/3VgrbaE7Dc00zlxeBTe7yS4aO3PRRiEoOoA==
X-Received: by 2002:a17:903:244a:b0:1f9:a602:5e39 with SMTP id
 d9443c01a7336-1fa238e4665mr108256365ad.11.1719340544327; 
 Tue, 25 Jun 2024 11:35:44 -0700 (PDT)
Received: from stoup.. (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f9eb3c6027sm84693235ad.133.2024.06.25.11.35.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jun 2024 11:35:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 07/13] target/arm: Convert BFDOT to decodetree
Date: Tue, 25 Jun 2024 11:35:30 -0700
Message-Id: <20240625183536.1672454-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240625183536.1672454-1-richard.henderson@linaro.org>
References: <20240625183536.1672454-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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
 target/arm/tcg/a64.decode      |  2 ++
 target/arm/tcg/translate-a64.c | 20 +++++---------------
 2 files changed, 7 insertions(+), 15 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 8a0251f83c..6819fd2587 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -950,6 +950,7 @@ SQRDMLSH_v      0.10 1110 ..0 ..... 10001 1 ..... ..... @qrrr_e
 SDOT_v          0.00 1110 100 ..... 10010 1 ..... ..... @qrrr_s
 UDOT_v          0.10 1110 100 ..... 10010 1 ..... ..... @qrrr_s
 USDOT_v         0.00 1110 100 ..... 10011 1 ..... ..... @qrrr_s
+BFDOT_v         0.10 1110 010 ..... 11111 1 ..... ..... @qrrr_s
 
 ### Advanced SIMD scalar x indexed element
 
@@ -1029,6 +1030,7 @@ SDOT_vi         0.00 1111 10 .. .... 1110 . 0 ..... .....   @qrrx_s
 UDOT_vi         0.10 1111 10 .. .... 1110 . 0 ..... .....   @qrrx_s
 SUDOT_vi        0.00 1111 00 .. .... 1111 . 0 ..... .....   @qrrx_s
 USDOT_vi        0.00 1111 10 .. .... 1111 . 0 ..... .....   @qrrx_s
+BFDOT_vi        0.00 1111 01 .. .... 1111 . 0 ..... .....   @qrrx_s
 
 # Floating-point conditional select
 
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 9a658ca876..0f44cd5aee 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -5604,6 +5604,7 @@ static bool do_dot_vector(DisasContext *s, arg_qrrr_e *a,
 TRANS_FEAT(SDOT_v, aa64_dp, do_dot_vector, a, gen_helper_gvec_sdot_b)
 TRANS_FEAT(UDOT_v, aa64_dp, do_dot_vector, a, gen_helper_gvec_udot_b)
 TRANS_FEAT(USDOT_v, aa64_i8mm, do_dot_vector, a, gen_helper_gvec_usdot_b)
+TRANS_FEAT(BFDOT_v, aa64_bf16, do_dot_vector, a, gen_helper_gvec_bfdot)
 
 /*
  * Advanced SIMD scalar/vector x indexed element
@@ -5942,6 +5943,8 @@ TRANS_FEAT(SUDOT_vi, aa64_i8mm, do_dot_vector_idx, a,
            gen_helper_gvec_sudot_idx_b)
 TRANS_FEAT(USDOT_vi, aa64_i8mm, do_dot_vector_idx, a,
            gen_helper_gvec_usdot_idx_b)
+TRANS_FEAT(BFDOT_vi, aa64_bf16, do_dot_vector_idx, a,
+           gen_helper_gvec_bfdot_idx)
 
 /*
  * Advanced SIMD scalar pairwise
@@ -10951,11 +10954,11 @@ static void disas_simd_three_reg_same_extra(DisasContext *s, uint32_t insn)
         break;
     case 0x1f:
         switch (size) {
-        case 1: /* BFDOT */
         case 3: /* BFMLAL{B,T} */
             feature = dc_isar_feature(aa64_bf16, s);
             break;
         default:
+        case 1: /* BFDOT */
             unallocated_encoding(s);
             return;
         }
@@ -11036,9 +11039,6 @@ static void disas_simd_three_reg_same_extra(DisasContext *s, uint32_t insn)
         return;
     case 0xf:
         switch (size) {
-        case 1: /* BFDOT */
-            gen_gvec_op4_ool(s, is_q, rd, rn, rm, rd, 0, gen_helper_gvec_bfdot);
-            break;
         case 3: /* BFMLAL{B,T} */
             gen_gvec_op4_fpst(s, 1, rd, rn, rm, rd, false, is_q,
                               gen_helper_gvec_bfmlal);
@@ -12053,13 +12053,6 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
         break;
     case 0x0f:
         switch (size) {
-        case 1: /* BFDOT */
-            if (is_scalar || !dc_isar_feature(aa64_bf16, s)) {
-                unallocated_encoding(s);
-                return;
-            }
-            size = MO_32;
-            break;
         case 3: /* BFMLAL{B,T} */
             if (is_scalar || !dc_isar_feature(aa64_bf16, s)) {
                 unallocated_encoding(s);
@@ -12070,6 +12063,7 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
             break;
         default:
         case 0: /* SUDOT */
+        case 1: /* BFDOT */
         case 2: /* USDOT */
             unallocated_encoding(s);
             return;
@@ -12179,10 +12173,6 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
     switch (16 * u + opcode) {
     case 0x0f:
         switch (extract32(insn, 22, 2)) {
-        case 1: /* BFDOT */
-            gen_gvec_op4_ool(s, is_q, rd, rn, rm, rd, index,
-                             gen_helper_gvec_bfdot_idx);
-            return;
         case 3: /* BFMLAL{B,T} */
             gen_gvec_op4_fpst(s, 1, rd, rn, rm, rd, 0, (index << 1) | is_q,
                               gen_helper_gvec_bfmlal_idx);
-- 
2.34.1


