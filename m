Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88707C27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 12:09:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD0zr-0004SP-V8; Fri, 31 May 2024 08:04:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sD0zd-0004Lf-Hn
 for qemu-devel@nongnu.org; Fri, 31 May 2024 08:04:21 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sD0zX-0003Ql-LK
 for qemu-devel@nongnu.org; Fri, 31 May 2024 08:04:20 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-42108856c33so12121275e9.1
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 05:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717157054; x=1717761854; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ylbCB9KmO7w37nJW3vMBltpZWyBOfZFJtyQ70Z4BvAg=;
 b=Jl+056sVdN0ncA28bIlF3MfuNTuzd5ycfXSeG3GgNm1UqMRfB5bU8j3smIFP/qOIod
 gx68/DW21sMXQ6wPJg16jLjUw4TEdkXU3O/wd4Gj1RCyOI8FBmM8BO7A2CvXHzy1DTeL
 Oyh4Cu8OA0EWfd2KeMcXd4gN4Suw1qz1ePcwC8nO00xHPau7RCCBwGCtWj7zhJnsby4i
 ecHitlxRIE1VCgryPU5CQLCImFdicg0cI59/wQ3ssQ3uFqtQuc9ZrHnKCJ4fbra4F5mI
 MX8WDDwtQD20x4A/OPsICl4os6S4seSVcbjcPFie4/9+mDjxqMFENfXE4K8a3NzS0Dg1
 LJ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717157054; x=1717761854;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ylbCB9KmO7w37nJW3vMBltpZWyBOfZFJtyQ70Z4BvAg=;
 b=Hl2PGKmiBrqcCamc8RNqQ/NU7l/uoNB9qQV5T1N42z9dK5tezfifZD308niHTEbNn4
 NCeoeauCiFvNCU4oaHonMSXLfM/90HmbIzXsi1sJ0Ou0zRHTgsjAPmjYnk4a8M4DaNa+
 b3zIiD36b86kfHUjT+6SX4pEzh1Uc1UjRfgnJ4aMcOOM5kKCGbXkOHOuG+AEnRkY+ofp
 mQXfJf0PxUIa0si2Gix8CUChz1tU3Q+oFf1AVbHjKi3TOx1g9dMJQXVHdSHTMJXqzZmB
 95bzwIvnfEXt3dbydWsi9Y5+GdRPwOt3EYQzzogRuTG1OpuR3cQYeD7POHndLxVjj3Rv
 3Yrg==
X-Gm-Message-State: AOJu0Ywxxw6D5JRys/I/vushtNtowQBzAYhOMxwq5DOyIpU/4CVxnffv
 xK7uOPKG1rwzlteskkuQbaVlioBhnvh6nwrcbJ9/5IaVS1D2VWBdkT1fn75iwMECXAIOfYYk2Y4
 a
X-Google-Smtp-Source: AGHT+IETFinL/zvcgF8hDW7kryhbv2qSSY3fzSKKgHwThFB1jbQ/K9/AgZJiR5detzsQJgbpF2FpVQ==
X-Received: by 2002:a05:600c:4f4d:b0:418:9d4a:1ba5 with SMTP id
 5b1f17b1804b1-421280dfabbmr40830125e9.6.1717157054061; 
 Fri, 31 May 2024 05:04:14 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42129de0cf9sm37027685e9.13.2024.05.31.05.04.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 May 2024 05:04:13 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/43] target/arm: Convert SSHL, USHL to decodetree
Date: Fri, 31 May 2024 13:03:32 +0100
Message-Id: <20240531120401.394550-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531120401.394550-1-peter.maydell@linaro.org>
References: <20240531120401.394550-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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
Message-id: 20240528203044.612851-10-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode      |  7 ++++++
 target/arm/tcg/translate-a64.c | 40 +++++++++++++++++++++-------------
 2 files changed, 32 insertions(+), 15 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 7c350ba833f..ea897d6732c 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -42,6 +42,7 @@
 @rr_sd          ........ ... ..... ...... rn:5 rd:5     &rr_e esz=%esz_sd
 
 @rrr_h          ........ ... rm:5 ...... rn:5 rd:5      &rrr_e esz=1
+@rrr_d          ........ ... rm:5 ...... rn:5 rd:5      &rrr_e esz=3
 @rrr_sd         ........ ... rm:5 ...... rn:5 rd:5      &rrr_e esz=%esz_sd
 @rrr_hsd        ........ ... rm:5 ...... rn:5 rd:5      &rrr_e esz=%esz_hsd
 @rrr_e          ........ esz:2 . rm:5 ...... rn:5 rd:5  &rrr_e
@@ -755,6 +756,9 @@ UQSUB_s         0111 1110 ..1 ..... 00101 1 ..... ..... @rrr_e
 SUQADD_s        0101 1110 ..1 00000 00111 0 ..... ..... @r2r_e
 USQADD_s        0111 1110 ..1 00000 00111 0 ..... ..... @r2r_e
 
+SSHL_s          0101 1110 111 ..... 01000 1 ..... ..... @rrr_d
+USHL_s          0111 1110 111 ..... 01000 1 ..... ..... @rrr_d
+
 ### Advanced SIMD scalar pairwise
 
 FADDP_s         0101 1110 0011 0000 1101 10 ..... ..... @rr_h
@@ -876,6 +880,9 @@ UQSUB_v         0.10 1110 ..1 ..... 00101 1 ..... ..... @qrrr_e
 SUQADD_v        0.00 1110 ..1 00000 00111 0 ..... ..... @qr2r_e
 USQADD_v        0.10 1110 ..1 00000 00111 0 ..... ..... @qr2r_e
 
+SSHL_v          0.00 1110 ..1 ..... 01000 1 ..... ..... @qrrr_e
+USHL_v          0.10 1110 ..1 ..... 01000 1 ..... ..... @qrrr_e
+
 ### Advanced SIMD scalar x indexed element
 
 FMUL_si         0101 1111 00 .. .... 1001 . 0 ..... .....   @rrx_h
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index c0637bda0fc..7c7a22985bd 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -5099,6 +5099,24 @@ TRANS(UQSUB_s, do_satacc_s, a, 0, 0, gen_uqsub_bhs, gen_uqsub_d)
 TRANS(SUQADD_s, do_satacc_s, a, MO_SIGN, 0, gen_suqadd_bhs, gen_suqadd_d)
 TRANS(USQADD_s, do_satacc_s, a, 0, MO_SIGN, gen_usqadd_bhs, gen_usqadd_d)
 
+static bool do_int3_scalar_d(DisasContext *s, arg_rrr_e *a,
+                             void (*fn)(TCGv_i64, TCGv_i64, TCGv_i64))
+{
+    if (fp_access_check(s)) {
+        TCGv_i64 t0 = tcg_temp_new_i64();
+        TCGv_i64 t1 = tcg_temp_new_i64();
+
+        read_vec_element(s, t0, a->rn, 0, MO_64);
+        read_vec_element(s, t1, a->rm, 0, MO_64);
+        fn(t0, t0, t1);
+        write_fp_dreg(s, a->rd, t0);
+    }
+    return true;
+}
+
+TRANS(SSHL_s, do_int3_scalar_d, a, gen_sshl_i64)
+TRANS(USHL_s, do_int3_scalar_d, a, gen_ushl_i64)
+
 static bool do_fp3_vector(DisasContext *s, arg_qrrr_e *a,
                           gen_helper_gvec_3_ptr * const fns[3])
 {
@@ -5344,6 +5362,10 @@ TRANS(UQSUB_v, do_gvec_fn3, a, gen_gvec_uqsub_qc)
 TRANS(SUQADD_v, do_gvec_fn3, a, gen_gvec_suqadd_qc)
 TRANS(USQADD_v, do_gvec_fn3, a, gen_gvec_usqadd_qc)
 
+TRANS(SSHL_v, do_gvec_fn3, a, gen_gvec_sshl)
+TRANS(USHL_v, do_gvec_fn3, a, gen_gvec_ushl)
+
+
 /*
  * Advanced SIMD scalar/vector x indexed element
  */
@@ -9355,13 +9377,6 @@ static void handle_3same_64(DisasContext *s, int opcode, bool u,
         }
         gen_cmtst_i64(tcg_rd, tcg_rn, tcg_rm);
         break;
-    case 0x8: /* SSHL, USHL */
-        if (u) {
-            gen_ushl_i64(tcg_rd, tcg_rn, tcg_rm);
-        } else {
-            gen_sshl_i64(tcg_rd, tcg_rn, tcg_rm);
-        }
-        break;
     case 0x9: /* SQSHL, UQSHL */
         if (u) {
             gen_helper_neon_qshl_u64(tcg_rd, tcg_env, tcg_rn, tcg_rm);
@@ -9393,6 +9408,7 @@ static void handle_3same_64(DisasContext *s, int opcode, bool u,
     default:
     case 0x1: /* SQADD / UQADD */
     case 0x5: /* SQSUB / UQSUB */
+    case 0x8: /* SSHL, USHL */
         g_assert_not_reached();
     }
 }
@@ -9417,7 +9433,6 @@ static void disas_simd_scalar_three_reg_same(DisasContext *s, uint32_t insn)
     case 0x9: /* SQSHL, UQSHL */
     case 0xb: /* SQRSHL, UQRSHL */
         break;
-    case 0x8: /* SSHL, USHL */
     case 0xa: /* SRSHL, URSHL */
     case 0x6: /* CMGT, CMHI */
     case 0x7: /* CMGE, CMHS */
@@ -9437,6 +9452,7 @@ static void disas_simd_scalar_three_reg_same(DisasContext *s, uint32_t insn)
     default:
     case 0x1: /* SQADD, UQADD */
     case 0x5: /* SQSUB, UQSUB */
+    case 0x8: /* SSHL, USHL */
         unallocated_encoding(s);
         return;
     }
@@ -10912,6 +10928,7 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
 
     case 0x01: /* SQADD, UQADD */
     case 0x05: /* SQSUB, UQSUB */
+    case 0x08: /* SSHL, USHL */
         unallocated_encoding(s);
         return;
     }
@@ -10921,13 +10938,6 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
     }
 
     switch (opcode) {
-    case 0x08: /* SSHL, USHL */
-        if (u) {
-            gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_ushl, size);
-        } else {
-            gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_sshl, size);
-        }
-        return;
     case 0x0c: /* SMAX, UMAX */
         if (u) {
             gen_gvec_fn3(s, is_q, rd, rn, rm, tcg_gen_gvec_umax, size);
-- 
2.34.1


