Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A635C3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 06:11:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTxrT-0005zC-3P; Wed, 17 Jul 2024 02:09:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sTxrJ-0005MB-U3
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 02:09:49 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sTxrF-00035C-Dy
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 02:09:48 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-70af22a9c19so4713206b3a.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 23:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721196581; x=1721801381; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=no6iOx3AILSOna1VQODcYvySktfS4g+9G5yzEozZ57o=;
 b=XRumrbug3lWATGWCu8ZDqk6qbZA1tKV4gjV71mHJFcB5AjKUBeQcCg29SW+4sB6HUV
 nKdZ2Wf7uv9yrtguSUT3NEHNd6j+CFXIBHCXV2H4WqBvXzE/U17zik+jPzPQDfFu5dY+
 g6ToqMJ5nGRr4UQGEPoZwbO6S0hlLcvwXbxLd5q4llQ9lRcOUVr9/UU6FQPAc1Sgefk8
 JoyVdP1o5/ZwyXwihGZxKhYBKGMGS4aBmtLslIlImHRuUXxoNIxRqJ6+ZqD/nUaDB7jA
 M5qh6wlmJ48fE0IeN4qyh1WYyXpjngUMOd0t3aBboHB9xLo+hI/e4TCjMpBqkIu7S3M6
 WpbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721196581; x=1721801381;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=no6iOx3AILSOna1VQODcYvySktfS4g+9G5yzEozZ57o=;
 b=dVMFnuomnR9o8vZRjct8snoaLfXi0Xc/DGtHCtpqpImBxvOI2M2t7VhJTQ/ri1/f6G
 y9OnmpO0Zb+rSoe/ppRdjyGJKlC0RZeoCOAOhTatSpwVSv4PS1xZVRXohg+Wc7e0UezH
 97CHuaDNCB2G/P2iW6qq+3BxfMtbLIR4lDJrRBVblKXtorYENJoIRWSpzyA1ElEdXUIq
 8lASb2FgHDdZHrukW9KKRDVwHhRyZGyI6KWZFamkJBqPUpSXHIkSMz+XUeiArL4Mc9+g
 AATZY9h71C3FLIBAZr20g6jVEVWjJwM2qA45a8wpj9q6IUA9mYJgZhIq6pd7L65LUCjm
 Jo0g==
X-Gm-Message-State: AOJu0YzAxu6R+rCT1kq5KKqoinJ6Xfl8KBI9ySWUXuOg+ig2AVhFIBfp
 h8+DZ51ReMNBhPBXlUm7ihn0oPx9tXNDV4/tvDgW1yP96bLrcrziTpQKi3LWaMug3R1BDWwCOW0
 dnFo=
X-Google-Smtp-Source: AGHT+IFWciE/FOxJGYMfSXhtLlJlsD/t2FSKilPLSqBf+lUJ9fu7vZEcFNY3A/KCi0tckemF/YaHyQ==
X-Received: by 2002:a05:6a00:2e97:b0:70a:ffbf:b27d with SMTP id
 d2e1a72fcca58-70ce505e403mr748701b3a.20.1721196580751; 
 Tue, 16 Jul 2024 23:09:40 -0700 (PDT)
Received: from stoup.. ([203.56.128.103]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b7ecd603bsm7330404b3a.219.2024.07.16.23.09.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 23:09:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 12/17] target/arm: Convert handle_vec_simd_shri to decodetree
Date: Wed, 17 Jul 2024 16:08:58 +1000
Message-ID: <20240717060903.205098-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240717060903.205098-1-richard.henderson@linaro.org>
References: <20240717060903.205098-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This includes SSHR, USHR, SSRA, USRA, SRSHR, URSHR, SRSRA, URSRA, SRI.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 109 +++++++++++++++------------------
 target/arm/tcg/a64.decode      |  27 +++++++-
 2 files changed, 74 insertions(+), 62 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index d0a3450d75..1e482477c5 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -68,6 +68,22 @@ static int scale_by_log2_tag_granule(DisasContext *s, int x)
     return x << LOG2_TAG_GRANULE;
 }
 
+/*
+ * For Advanced SIMD shift by immediate, extract esz from immh.
+ * The result must be validated by the translator: MO_8 <= x <= MO_64.
+ */
+static int esz_immh(DisasContext *s, int x)
+{
+    return 32 - clz32(x) - 1;
+}
+
+/* For Advanced SIMD shift by immediate, right shift count. */
+static int rcount_immhb(DisasContext *s, int x)
+{
+    int size = esz_immh(s, x >> 3);
+    return (16 << size) - x;
+}
+
 /*
  * Include the generated decoders.
  */
@@ -6918,6 +6934,35 @@ static bool trans_Vimm(DisasContext *s, arg_Vimm *a)
     return true;
 }
 
+/*
+ * Advanced SIMD Shift by Immediate
+ */
+
+static bool do_vec_shift_imm(DisasContext *s, arg_qrri_e *a, GVecGen2iFn *fn)
+{
+    /* Validate result of esz_immh, for invalid immh == 0. */
+    if (a->esz < 0) {
+        return false;
+    }
+    if (a->esz == MO_64 && !a->q) {
+        return false;
+    }
+    if (fp_access_check(s)) {
+        gen_gvec_fn2i(s, a->q, a->rd, a->rn, a->imm, fn, a->esz);
+    }
+    return true;
+}
+
+TRANS(SSHR_v, do_vec_shift_imm, a, gen_gvec_sshr)
+TRANS(USHR_v, do_vec_shift_imm, a, gen_gvec_ushr)
+TRANS(SSRA_v, do_vec_shift_imm, a, gen_gvec_ssra)
+TRANS(USRA_v, do_vec_shift_imm, a, gen_gvec_usra)
+TRANS(SRSHR_v, do_vec_shift_imm, a, gen_gvec_srshr)
+TRANS(URSHR_v, do_vec_shift_imm, a, gen_gvec_urshr)
+TRANS(SRSRA_v, do_vec_shift_imm, a, gen_gvec_srsra)
+TRANS(URSRA_v, do_vec_shift_imm, a, gen_gvec_ursra)
+TRANS(SRI_v, do_vec_shift_imm, a, gen_gvec_sri)
+
 /* Shift a TCGv src by TCGv shift_amount, put result in dst.
  * Note that it is the caller's responsibility to ensure that the
  * shift amount is in range (ie 0..31 or 0..63) and provide the ARM
@@ -10382,53 +10427,6 @@ static void disas_simd_scalar_two_reg_misc(DisasContext *s, uint32_t insn)
     }
 }
 
-/* SSHR[RA]/USHR[RA] - Vector shift right (optional rounding/accumulate) */
-static void handle_vec_simd_shri(DisasContext *s, bool is_q, bool is_u,
-                                 int immh, int immb, int opcode, int rn, int rd)
-{
-    int size = 32 - clz32(immh) - 1;
-    int immhb = immh << 3 | immb;
-    int shift = 2 * (8 << size) - immhb;
-    GVecGen2iFn *gvec_fn;
-
-    if (extract32(immh, 3, 1) && !is_q) {
-        unallocated_encoding(s);
-        return;
-    }
-    tcg_debug_assert(size <= 3);
-
-    if (!fp_access_check(s)) {
-        return;
-    }
-
-    switch (opcode) {
-    case 0x02: /* SSRA / USRA (accumulate) */
-        gvec_fn = is_u ? gen_gvec_usra : gen_gvec_ssra;
-        break;
-
-    case 0x08: /* SRI */
-        gvec_fn = gen_gvec_sri;
-        break;
-
-    case 0x00: /* SSHR / USHR */
-        gvec_fn = is_u ? gen_gvec_ushr : gen_gvec_sshr;
-        break;
-
-    case 0x04: /* SRSHR / URSHR (rounding) */
-        gvec_fn = is_u ? gen_gvec_urshr : gen_gvec_srshr;
-        break;
-
-    case 0x06: /* SRSRA / URSRA (accum + rounding) */
-        gvec_fn = is_u ? gen_gvec_ursra : gen_gvec_srsra;
-        break;
-
-    default:
-        g_assert_not_reached();
-    }
-
-    gen_gvec_fn2i(s, is_q, rd, rn, shift, gvec_fn, size);
-}
-
 /* SHL/SLI - Vector shift left */
 static void handle_vec_simd_shli(DisasContext *s, bool is_q, bool insert,
                                  int immh, int immb, int opcode, int rn, int rd)
@@ -10568,18 +10566,6 @@ static void disas_simd_shift_imm(DisasContext *s, uint32_t insn)
     }
 
     switch (opcode) {
-    case 0x08: /* SRI */
-        if (!is_u) {
-            unallocated_encoding(s);
-            return;
-        }
-        /* fall through */
-    case 0x00: /* SSHR / USHR */
-    case 0x02: /* SSRA / USRA (accumulate) */
-    case 0x04: /* SRSHR / URSHR (rounding) */
-    case 0x06: /* SRSRA / URSRA (accum + rounding) */
-        handle_vec_simd_shri(s, is_q, is_u, immh, immb, opcode, rn, rd);
-        break;
     case 0x0a: /* SHL / SLI */
         handle_vec_simd_shli(s, is_q, is_u, immh, immb, opcode, rn, rd);
         break;
@@ -10618,6 +10604,11 @@ static void disas_simd_shift_imm(DisasContext *s, uint32_t insn)
         handle_simd_shift_fpint_conv(s, false, is_q, is_u, immh, immb, rn, rd);
         return;
     default:
+    case 0x00: /* SSHR / USHR */
+    case 0x02: /* SSRA / USRA (accumulate) */
+    case 0x04: /* SRSHR / URSHR (rounding) */
+    case 0x06: /* SRSRA / URSRA (accum + rounding) */
+    case 0x08: /* SRI */
         unallocated_encoding(s);
         return;
     }
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index d4dfc5f772..c525f5fc35 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -34,6 +34,7 @@
 &rrx_e          rd rn rm idx esz
 &rrrr_e         rd rn rm ra esz
 &qrr_e          q rd rn esz
+&qrri_e         q rd rn imm esz
 &qrrr_e         q rd rn rm esz
 &qrrx_e         q rd rn rm idx esz
 &qrrrr_e        q rd rn rm ra esz
@@ -1185,11 +1186,31 @@ FMINV_s         0110 1110 10 11000 01111 10 ..... .....     @rr_q1e2
 
 FMOVI_s         0001 1110 .. 1 imm:8 100 00000 rd:5         esz=%esz_hsd
 
-# Advanced SIMD Modified Immediate
+# Advanced SIMD Modified Immediate / Shift by Immediate
 
 %abcdefgh       16:3 5:5
+%esz_immh       19:4 !function=esz_immh
+%rcount_immhb   16:7 !function=rcount_immhb
+
+@qrshifti       . q:1 .. ..... .... ... ..... . rn:5 rd:5   \
+                &qrri_e esz=%esz_immh imm=%rcount_immhb
 
 FMOVI_v_h       0 q:1 00 1111 00000 ... 1111 11 ..... rd:5  %abcdefgh
 
-# MOVI, MVNI, ORR, BIC, FMOV are all intermixed via cmode.
-Vimm            0 q:1 op:1 0 1111 00000 ... cmode:4 01 ..... rd:5 %abcdefgh
+{
+  # MOVI, MVNI, ORR, BIC, FMOV are all intermixed via cmode.
+  Vimm          0 q:1 op:1 0 1111 00000 ... cmode:4 01 ..... rd:5 %abcdefgh
+
+  # Shift by immediate requires immh==0, consumed by Vimm above.
+  [
+    SSHR_v      0.00 11110 .... ... 00000 1 ..... .....     @qrshifti
+    USHR_v      0.10 11110 .... ... 00000 1 ..... .....     @qrshifti
+    SSRA_v      0.00 11110 .... ... 00010 1 ..... .....     @qrshifti
+    USRA_v      0.10 11110 .... ... 00010 1 ..... .....     @qrshifti
+    SRSHR_v     0.00 11110 .... ... 00100 1 ..... .....     @qrshifti
+    URSHR_v     0.10 11110 .... ... 00100 1 ..... .....     @qrshifti
+    SRSRA_v     0.00 11110 .... ... 00110 1 ..... .....     @qrshifti
+    URSRA_v     0.10 11110 .... ... 00110 1 ..... .....     @qrshifti
+    SRI_v       0.10 11110 .... ... 01000 1 ..... .....     @qrshifti
+  ]
+}
-- 
2.43.0


