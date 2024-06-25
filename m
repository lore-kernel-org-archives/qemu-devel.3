Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F4DFC2BBCA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 05:10:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLyPr-00018Q-PH; Tue, 25 Jun 2024 01:08:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sLyPo-00014Z-Ck
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 01:08:24 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sLyPl-0001XB-TW
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 01:08:23 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-70683d96d0eso1208578b3a.0
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 22:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719292098; x=1719896898; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hRclqwFkw5aAwjIhmFzcLIsVslOSKqJp4jOj2/LLcbw=;
 b=i6Zgqa/IHZkshSIe7idj5sIf25UdA+I/UdQl74aYKW0NlVempPewID9Cxx6Tg+U/JW
 NPSdc7WEXzZEDhN/s5fQXB/pC6Zz+0IPKRmd0Az1it7CM+vhzXDr/U9HfWghsziwcCI3
 wiQkPZkyao/Ju4KuMLVIGN0zdwuUE8HnrzzXV+IV9dwbUlS6HuoEJBnsMd9K7ErOnQzI
 aAWdwt/xiYE8Vn18edn7RFYnCiM7402QWBjvebxbKqPxSWDKO7Lb9yCztoMNfZvutjar
 nqsQs/A85ImFanWLnxcMj1FMYBMmhA1juV0xtFxChrl28VGsgkCaazE3NheFzakum3/T
 RZlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719292098; x=1719896898;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hRclqwFkw5aAwjIhmFzcLIsVslOSKqJp4jOj2/LLcbw=;
 b=Q6L8VeViVflTXBVZ2Ee2764t4mM4JCeRcZHKKWA2KKvAdU6qBBVSF4UZHLL3szxGmk
 BodKR7voDB8MtokY05QepoJYpLfYn0pBhyrGNjKOVRu9Qx1MVqbeZ/V/h3iVMaltwM2g
 wzqzqz1oKSc4fa9Fl0CSblg4zWnuio77joSMDMEtYvgB0Mz6NEN+SYGUsbByowuMJaZy
 9c/RcBSXhVncChs/bEQ/Bxdi/AItBk3aXAzZow1XC0MoACpILTIckv6ow2sj15H2M3z5
 UrNFYqZcYR3vGAtmBGQDzPumk9wI77Ccl/8WEas38aGnjDxSlZwqkpjqnZY6i5h1vF+R
 qoAw==
X-Gm-Message-State: AOJu0YzCZRZRt1U/pTj1Rvlz5GEkv0ghAP5pwrLNIBr9n096AKuyzE6r
 RmaeLiefMWtZ1bxAehQr1JBN8IxuiOpaD+tzuPF1rU/pdFuO43D1ss9QUcKZQZFGEU7TNRu/ey2
 d
X-Google-Smtp-Source: AGHT+IHVL/81Iuy/xWhX78SJxmrxEC2v/Gl0ZcwnJNCVBGClCP0fGIb1eSjYTWpC7ZV+bkChquR5yQ==
X-Received: by 2002:a05:6a20:2105:b0:1bc:feb5:887d with SMTP id
 adf61e73a8af0-1bcfeb58bb8mr4689720637.25.1719292098253; 
 Mon, 24 Jun 2024 22:08:18 -0700 (PDT)
Received: from stoup.. (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f9ebbc72e9sm70843865ad.296.2024.06.24.22.08.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jun 2024 22:08:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 06/13] target/arm: Convert SUDOT, USDOT to decodetree
Date: Mon, 24 Jun 2024 22:08:03 -0700
Message-Id: <20240625050810.1475643-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240625050810.1475643-1-richard.henderson@linaro.org>
References: <20240625050810.1475643-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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


