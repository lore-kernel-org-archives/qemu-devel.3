Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72292C30653
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 18:57:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMBBc-0002eu-Bn; Tue, 25 Jun 2024 14:46:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sMB50-000163-8B
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 14:39:56 -0400
Received: from [2607:f8b0:4864:20::631] (helo=mail-pl1-x631.google.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sMB3m-00066R-3h
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 14:39:34 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1fa78306796so5767215ad.3
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2024 11:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719340543; x=1719945343; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A9xMCiVEPs8xOyyzawG2CVQ8zg7ghsGamdUOThsHcoY=;
 b=BCLB2fx1HMZWEVHNoDUFIPjYoPi2gSqcm8GP342vMmKI0LOSVp6ZjWAfK8vdzahHFA
 RT3mfRWKrdOSvwToZebAPA41uCPDrgBt2VYr+65fp0EOVVI3Qav/DZX5DgztOCbs1oFE
 53fel413nnLZJfGV7XtRIwbJiZrO0DWsrBrpUjaqbqj88WiDKkOAir6K3sJOTPjStH/K
 xlciA1hVh3mCKGUZNqHAE/ZML7oe08QDxk/CMQVsjc64MqSq3g01R5jvYEcqV09h2JXC
 2ebZ7cEtlR4mfjTjU4/rVu7YoOfr3km5PdVz2YCiuxobVFQYVigB2CrbOjvTYn06tEau
 UPBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719340543; x=1719945343;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A9xMCiVEPs8xOyyzawG2CVQ8zg7ghsGamdUOThsHcoY=;
 b=DQ6K/TRYFLk3cBJ0BkmBux7WnOPCL/hjc5G68ik7t4R6aflZJMgDASL8tN7jQv4yjM
 GnfqdLOd6pn1K1My+T0c0rtBcuP2eLfVyGPiFBmG4in9YcmZ++ZlAzvBBehKn0qlRvc9
 jyq9XOeKhLQyyR0UIZ5rXxsvk7MKzwUjZ51/LmNxxkKY5RjZmKSSRWMjJhnxXjmQH3rm
 Zg41yDbqNnir5X3el8K5Os2q03leJGzK9KLw+1rwLTeJTEwhaRx+yjLD5ChUwi5oe/4Y
 w/zeJfy29sk8Cvjgsk9w29hcS6Eh4RF6FUBElpKruBuX3DCsir8vKNtuwvPJGH5mHMsn
 lhLQ==
X-Gm-Message-State: AOJu0Yx/4mgo6KTSr3k67Gs137DP01NYP3eBDmJFQGYXNO0OS5tThdYF
 37dRZ687Flh4RZholYap8hYuPuUnaYx5zMMPKW2FRWAlSlRLCbNUy+BIH3jUwBd45vf9EZZrtr4
 U
X-Google-Smtp-Source: AGHT+IFViv/QBBG8+NOpoDIIeKkAUHDNI3GZiOYVLj1uaphYFjvxjBUiTldCDLTK8JuzCno5FcMq0A==
X-Received: by 2002:a17:902:da86:b0:1f6:8235:dba7 with SMTP id
 d9443c01a7336-1fa1d6ad2d6mr102683915ad.69.1719340543290; 
 Tue, 25 Jun 2024 11:35:43 -0700 (PDT)
Received: from stoup.. (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f9eb3c6027sm84693235ad.133.2024.06.25.11.35.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jun 2024 11:35:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 06/13] target/arm: Convert SUDOT, USDOT to decodetree
Date: Tue, 25 Jun 2024 11:35:29 -0700
Message-Id: <20240625183536.1672454-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240625183536.1672454-1-richard.henderson@linaro.org>
References: <20240625183536.1672454-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 2607:f8b0:4864:20::631
 (deferred)
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, PDS_HP_HELO_NORDNS=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RDNS_NONE=0.793, T_SPF_HELO_TEMPERROR=0.01,
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
 target/arm/tcg/a64.decode      |  3 +++
 target/arm/tcg/translate-a64.c | 35 ++++++++--------------------------
 2 files changed, 11 insertions(+), 27 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 7411d4ba97..8a0251f83c 100644
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
index f2e7d8d75c..9a658ca876 100644
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


