Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2A42C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 16:10:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOJZU-0001Oh-Ba; Mon, 01 Jul 2024 12:08:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sOJZ8-0000jD-Nb
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 12:07:43 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sOJZ5-0005RH-Rv
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 12:07:42 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-52cd8897c73so3687807e87.2
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 09:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719850057; x=1720454857; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gRmQl+sZaZDBm/N4F1+THBUYvhq2tRdWf0ndyFtrCmE=;
 b=rw5bIHNW4v6r2AjVtkbXCHYcJ44Ize4rcZF/WvobOi6qv30R2fLjLQ9UzYGgyi2rEr
 B9tYGpsL5KgAlW7V+Fq/alXIVfJY/MSehBq6Qu6VvI7anHZDltYPXWjMTWxCSi0Dsw0J
 3wzC76X9ZDDxlzcwCuI0qA7lMZYUvdm75GlLGa10KxwMjAm6u4vlq9/JDsY4SrdPa4ay
 c2fvj5ovNh4xZpZOmY6qwQIAD6gP4nUwYaMwhNTFnZivA1kJjmm22Bj7DflW4dJtzZcn
 gCmV1RzG+JUEwDi9jIYOvkP5xuJe8tEkTKMWwh2YqGBXWulNpuFmpHNi0wi0GONGsaY1
 VhQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719850057; x=1720454857;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gRmQl+sZaZDBm/N4F1+THBUYvhq2tRdWf0ndyFtrCmE=;
 b=MeaIffw1SmiNSu0zUeiZT8c7V+MC/AG77V+9Sllw3sSoxWjmwzoFqDob85/3HIaOdW
 bEuu5ym9SCjDHoorGXP8nEAFe1ckD9KZZoysXPusZeCtik9MBbxE/nEHkFWZZheY6hVI
 +Nelik17L2Y8obg36QGLpW//m0b6kONfIDfJLI+CZ6S9xfHNJ1OdbqNrlFf2OQX1Bhdt
 Flo2HKaov127DMeBYzp3Vxo8BNVv1sZbgKqeLxpzfS/coz7VG69rK4TzO1klKN5mREqE
 /LFyvhohr3nV90A7YRdESws5V6y+kV5dymIJOoEa7NZ0SJLWlUuERt1RXdzqE1Tx4hXd
 7xxg==
X-Gm-Message-State: AOJu0Yz2Y+v8VgfcV5hKBzdivz9g+fBl0JPVbDHQ8JmbFwPorS4LwSFE
 WWv6ncgbxfoosyKb8ue9NYRuGhUQEZVxpAh+laq5pEwsg3YV8ajWyv00lobQksZtoV2P5Whtbe3
 jYNw=
X-Google-Smtp-Source: AGHT+IGeBePhyCYI7hZC8RPKuh+a85bLV6VW3orG2dbYiFosG7vdDqRzKE8HD0l9jPm+nlURjASFzw==
X-Received: by 2002:a05:6512:6c7:b0:52b:79d6:5c28 with SMTP id
 2adb3069b0e04-52e826f75f3mr3841176e87.52.1719850056893; 
 Mon, 01 Jul 2024 09:07:36 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af557fesm161952135e9.11.2024.07.01.09.07.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jul 2024 09:07:36 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/29] target/arm: Convert BFMLALB, BFMLALT to decodetree
Date: Mon,  1 Jul 2024 17:07:14 +0100
Message-Id: <20240701160729.1910763-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240701160729.1910763-1-peter.maydell@linaro.org>
References: <20240701160729.1910763-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12d.google.com
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
Message-id: 20240625183536.1672454-9-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode      |  2 +
 target/arm/tcg/translate-a64.c | 77 +++++++++++++---------------------
 2 files changed, 31 insertions(+), 48 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 6819fd25873..15344a73de4 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -951,6 +951,7 @@ SDOT_v          0.00 1110 100 ..... 10010 1 ..... ..... @qrrr_s
 UDOT_v          0.10 1110 100 ..... 10010 1 ..... ..... @qrrr_s
 USDOT_v         0.00 1110 100 ..... 10011 1 ..... ..... @qrrr_s
 BFDOT_v         0.10 1110 010 ..... 11111 1 ..... ..... @qrrr_s
+BFMLAL_v        0.10 1110 110 ..... 11111 1 ..... ..... @qrrr_h
 
 ### Advanced SIMD scalar x indexed element
 
@@ -1031,6 +1032,7 @@ UDOT_vi         0.10 1111 10 .. .... 1110 . 0 ..... .....   @qrrx_s
 SUDOT_vi        0.00 1111 00 .. .... 1111 . 0 ..... .....   @qrrx_s
 USDOT_vi        0.00 1111 10 .. .... 1111 . 0 ..... .....   @qrrx_s
 BFDOT_vi        0.00 1111 01 .. .... 1111 . 0 ..... .....   @qrrx_s
+BFMLAL_vi       0.00 1111 11 .. .... 1111 . 0 ..... .....   @qrrx_h
 
 # Floating-point conditional select
 
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 0f44cd5aee5..95be862dde4 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -5606,6 +5606,19 @@ TRANS_FEAT(UDOT_v, aa64_dp, do_dot_vector, a, gen_helper_gvec_udot_b)
 TRANS_FEAT(USDOT_v, aa64_i8mm, do_dot_vector, a, gen_helper_gvec_usdot_b)
 TRANS_FEAT(BFDOT_v, aa64_bf16, do_dot_vector, a, gen_helper_gvec_bfdot)
 
+static bool trans_BFMLAL_v(DisasContext *s, arg_qrrr_e *a)
+{
+    if (!dc_isar_feature(aa64_bf16, s)) {
+        return false;
+    }
+    if (fp_access_check(s)) {
+        /* Q bit selects BFMLALB vs BFMLALT. */
+        gen_gvec_op4_fpst(s, true, a->rd, a->rn, a->rm, a->rd, false, a->q,
+                          gen_helper_gvec_bfmlal);
+    }
+    return true;
+}
+
 /*
  * Advanced SIMD scalar/vector x indexed element
  */
@@ -5946,6 +5959,20 @@ TRANS_FEAT(USDOT_vi, aa64_i8mm, do_dot_vector_idx, a,
 TRANS_FEAT(BFDOT_vi, aa64_bf16, do_dot_vector_idx, a,
            gen_helper_gvec_bfdot_idx)
 
+static bool trans_BFMLAL_vi(DisasContext *s, arg_qrrx_e *a)
+{
+    if (!dc_isar_feature(aa64_bf16, s)) {
+        return false;
+    }
+    if (fp_access_check(s)) {
+        /* Q bit selects BFMLALB vs BFMLALT. */
+        gen_gvec_op4_fpst(s, true, a->rd, a->rn, a->rm, a->rd, 0,
+                          (a->idx << 1) | a->q,
+                          gen_helper_gvec_bfmlal_idx);
+    }
+    return true;
+}
+
 /*
  * Advanced SIMD scalar pairwise
  */
@@ -10952,23 +10979,13 @@ static void disas_simd_three_reg_same_extra(DisasContext *s, uint32_t insn)
         }
         feature = dc_isar_feature(aa64_bf16, s);
         break;
-    case 0x1f:
-        switch (size) {
-        case 3: /* BFMLAL{B,T} */
-            feature = dc_isar_feature(aa64_bf16, s);
-            break;
-        default:
-        case 1: /* BFDOT */
-            unallocated_encoding(s);
-            return;
-        }
-        break;
     default:
     case 0x02: /* SDOT (vector) */
     case 0x03: /* USDOT */
     case 0x10: /* SQRDMLAH (vector) */
     case 0x11: /* SQRDMLSH (vector) */
     case 0x12: /* UDOT (vector) */
+    case 0x1f: /* BFDOT / BFMLAL */
         unallocated_encoding(s);
         return;
     }
@@ -11037,17 +11054,6 @@ static void disas_simd_three_reg_same_extra(DisasContext *s, uint32_t insn)
     case 0xd: /* BFMMLA */
         gen_gvec_op4_ool(s, is_q, rd, rn, rm, rd, 0, gen_helper_gvec_bfmmla);
         return;
-    case 0xf:
-        switch (size) {
-        case 3: /* BFMLAL{B,T} */
-            gen_gvec_op4_fpst(s, 1, rd, rn, rm, rd, false, is_q,
-                              gen_helper_gvec_bfmlal);
-            break;
-        default:
-            g_assert_not_reached();
-        }
-        return;
-
     default:
         g_assert_not_reached();
     }
@@ -12051,24 +12057,6 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
     case 0x0b: /* SQDMULL, SQDMULL2 */
         is_long = true;
         break;
-    case 0x0f:
-        switch (size) {
-        case 3: /* BFMLAL{B,T} */
-            if (is_scalar || !dc_isar_feature(aa64_bf16, s)) {
-                unallocated_encoding(s);
-                return;
-            }
-            /* can't set is_fp without other incorrect size checks */
-            size = MO_16;
-            break;
-        default:
-        case 0: /* SUDOT */
-        case 1: /* BFDOT */
-        case 2: /* USDOT */
-            unallocated_encoding(s);
-            return;
-        }
-        break;
     case 0x11: /* FCMLA #0 */
     case 0x13: /* FCMLA #90 */
     case 0x15: /* FCMLA #180 */
@@ -12089,6 +12077,7 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
     case 0x0c: /* SQDMULH */
     case 0x0d: /* SQRDMULH */
     case 0x0e: /* SDOT */
+    case 0x0f: /* SUDOT / BFDOT / USDOT / BFMLAL */
     case 0x10: /* MLA */
     case 0x14: /* MLS */
     case 0x18: /* FMLAL2 */
@@ -12171,14 +12160,6 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
     }
 
     switch (16 * u + opcode) {
-    case 0x0f:
-        switch (extract32(insn, 22, 2)) {
-        case 3: /* BFMLAL{B,T} */
-            gen_gvec_op4_fpst(s, 1, rd, rn, rm, rd, 0, (index << 1) | is_q,
-                              gen_helper_gvec_bfmlal_idx);
-            return;
-        }
-        g_assert_not_reached();
     case 0x11: /* FCMLA #0 */
     case 0x13: /* FCMLA #90 */
     case 0x15: /* FCMLA #180 */
-- 
2.34.1


