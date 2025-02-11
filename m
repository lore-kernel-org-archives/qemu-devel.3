Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AEA2C021A4
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 16:29:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tht7P-000232-Gb; Tue, 11 Feb 2025 11:28:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht5w-0006iv-05
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:26:45 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht5s-0003Jq-T2
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:26:43 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43957634473so1664955e9.0
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 08:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739291198; x=1739895998; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OGHA0fXAvxOXELNfX5hCnXpfwIVchIakZd34FrCzJrI=;
 b=hrdyHq486njHtBTDhnYMU1hf/2fKTw/Ai7fBCvXWqGuG6kledBNxOCvERshQPGgbsf
 BA1WF1f0xM6FGe8aXQZGWmudZqrSc1d+/Nr/wp0M+oYtkxeehNIMB5vZFy7u0a0wwab+
 GJ6qBS8UURP7zU7YcdVCg0PIPCq58rf1QOmhAiwvIUKPvIsSMFgGANPiLdXygPfYrtxQ
 ftnLWwos2ZBAyixzvvj5cSlsSLBrl07hJnDDUOmtIMeZEJtorhg33TgmzIfpTB1hI5uR
 C+ChwGuOneSve2tr2U01lalpe/hmdgzoZxuMrLdm5mKiBt3OfAcf6Y7EBRQ4rweJ2ffV
 pKxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739291198; x=1739895998;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OGHA0fXAvxOXELNfX5hCnXpfwIVchIakZd34FrCzJrI=;
 b=TB5Bi5wjd2y0XDok93Sue3kJ9HuPldkA0kid6UHbPLUI4zTogz/nK2mG4qkkvOB35c
 2fVFC62v4xMv+DRDWFDMyD/hxV635T74BUt7bKntQPl9i2hqX06Lb5rY0BwGxeanq1dM
 gbzBJdZ/PrnYt/msLhlebYDd/nHct9YGX0qgBh1vRZRDBnVvopdfFA/KURPRyXxOFjXP
 i3ZDWMBgEVZLrmy/GcyQApfbrIIDAmPFIFWf7Xr0ZLmB+0q7bZrfIxWEbXlTkI1FQmAf
 wWFoSVV7a9dbHOY3Ywk2svSXfjrNtmRTZFgaKE4o0X3/GU3vairNFShc2TXt3MEyj/E1
 5WKA==
X-Gm-Message-State: AOJu0YwX0EbmadW6kT/KL7x7Qa2i/4mlC00LEcl7zG380GLeBmy79xhj
 1BwgBVahT7Y5inP9acweH6oEAILXSRT10jhWEHcvZffE2/eSF9DgxKmeUJCvKtEuXTSecszzJMn
 t
X-Gm-Gg: ASbGncswyp4d4NOeI2IEdmcBRHQytq3oG7ImaDGBRHuxoonQ1ZDTzA4XBYYYkkprNf+
 Idn6c2G1L2hZVVPXsYTf5OtYciLCDcH/o80JikN+8WChmV9nXKPcpxNYdxPW3EPI+FzmUrD71Y+
 xLxQBu01zac6fR7YHSg6qdazqwifUdgWBV+Y1P5XUfO7Dk2zD+y0Kbh65xKsPmqaDoH9ZETEeDj
 0Z5Tg98yysT80WIUf0liv8DWTVwE+cJFIk6hOTC+UU6D3Oj1F43jpZoXpLlmyPESxlO96H1mATg
 s69qX1eEWD3DdoXVQm5r
X-Google-Smtp-Source: AGHT+IHlWC4tZDGxIR9rw7t+FSFxqBnMawjGtbw2oliP6/M94bt10aDtvNcXBIOQMHzSIeQRRMDIHg==
X-Received: by 2002:a05:600c:34c2:b0:439:4a9d:aeaf with SMTP id
 5b1f17b1804b1-4394a9db1ebmr47015335e9.25.1739291198136; 
 Tue, 11 Feb 2025 08:26:38 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4393f202721sm82660455e9.21.2025.02.11.08.26.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 08:26:37 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 40/68] target/arm: Handle FPCR.AH in negation step in FMLS
 (indexed)
Date: Tue, 11 Feb 2025 16:25:26 +0000
Message-Id: <20250211162554.4135349-41-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250211162554.4135349-1-peter.maydell@linaro.org>
References: <20250211162554.4135349-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

Handle the FPCR.AH "don't negate the sign of a NaN" semantics in FMLS
(indexed). We do this by creating 6 new helpers, which allow us to
do the negation either by XOR (for AH=0) or by muladd flags
(for AH=1).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
[PMM: Mostly from RTH's patch; error in index order into fns[][]
 fixed]
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.h            | 14 ++++++++++++++
 target/arm/tcg/translate-a64.c | 17 +++++++++++------
 target/arm/tcg/translate-sve.c | 31 +++++++++++++++++--------------
 target/arm/tcg/vec_helper.c    | 24 +++++++++++++++---------
 4 files changed, 57 insertions(+), 29 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 43505d5fedc..be47edff896 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -813,6 +813,20 @@ DEF_HELPER_FLAGS_6(gvec_fmla_idx_s, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_6(gvec_fmla_idx_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, fpst, i32)
 
+DEF_HELPER_FLAGS_6(gvec_fmls_idx_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_6(gvec_fmls_idx_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_6(gvec_fmls_idx_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
+
+DEF_HELPER_FLAGS_6(gvec_ah_fmls_idx_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_6(gvec_ah_fmls_idx_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_6(gvec_ah_fmls_idx_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
+
 DEF_HELPER_FLAGS_5(gvec_uqadd_b, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(gvec_uqadd_h, TCG_CALL_NO_RWG,
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 50c207c9a12..dc35e5d896e 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -6726,10 +6726,16 @@ TRANS(FMULX_vi, do_fp3_vector_idx, a, f_vector_idx_fmulx)
 
 static bool do_fmla_vector_idx(DisasContext *s, arg_qrrx_e *a, bool neg)
 {
-    static gen_helper_gvec_4_ptr * const fns[3] = {
-        gen_helper_gvec_fmla_idx_h,
-        gen_helper_gvec_fmla_idx_s,
-        gen_helper_gvec_fmla_idx_d,
+    static gen_helper_gvec_4_ptr * const fns[3][3] = {
+        { gen_helper_gvec_fmla_idx_h,
+          gen_helper_gvec_fmla_idx_s,
+          gen_helper_gvec_fmla_idx_d },
+        { gen_helper_gvec_fmls_idx_h,
+          gen_helper_gvec_fmls_idx_s,
+          gen_helper_gvec_fmls_idx_d },
+        { gen_helper_gvec_ah_fmls_idx_h,
+          gen_helper_gvec_ah_fmls_idx_s,
+          gen_helper_gvec_ah_fmls_idx_d },
     };
     MemOp esz = a->esz;
     int check = fp_access_check_vector_hsd(s, a->q, esz);
@@ -6740,8 +6746,7 @@ static bool do_fmla_vector_idx(DisasContext *s, arg_qrrx_e *a, bool neg)
 
     gen_gvec_op4_fpst(s, a->q, a->rd, a->rn, a->rm, a->rd,
                       esz == MO_16 ? FPST_A64_F16 : FPST_A64,
-                      (a->idx << 1) | neg,
-                      fns[esz - 1]);
+                      a->idx, fns[neg ? 1 + s->fpcr_ah : 0][esz - 1]);
     return true;
 }
 
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 50f16d5affa..e81e996c56e 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -3524,21 +3524,24 @@ DO_SVE2_RRXR_ROT(CDOT_zzxw_d, gen_helper_sve2_cdot_idx_d)
  *** SVE Floating Point Multiply-Add Indexed Group
  */
 
-static bool do_FMLA_zzxz(DisasContext *s, arg_rrxr_esz *a, bool sub)
-{
-    static gen_helper_gvec_4_ptr * const fns[4] = {
-        NULL,
-        gen_helper_gvec_fmla_idx_h,
-        gen_helper_gvec_fmla_idx_s,
-        gen_helper_gvec_fmla_idx_d,
-    };
-    return gen_gvec_fpst_zzzz(s, fns[a->esz], a->rd, a->rn, a->rm, a->ra,
-                              (a->index << 1) | sub,
-                              a->esz == MO_16 ? FPST_A64_F16 : FPST_A64);
-}
+static gen_helper_gvec_4_ptr * const fmla_idx_fns[4] = {
+    NULL,                       gen_helper_gvec_fmla_idx_h,
+    gen_helper_gvec_fmla_idx_s, gen_helper_gvec_fmla_idx_d
+};
+TRANS_FEAT(FMLA_zzxz, aa64_sve, gen_gvec_fpst_zzzz,
+           fmla_idx_fns[a->esz], a->rd, a->rn, a->rm, a->ra, a->index,
+           a->esz == MO_16 ? FPST_A64_F16 : FPST_A64)
 
-TRANS_FEAT(FMLA_zzxz, aa64_sve, do_FMLA_zzxz, a, false)
-TRANS_FEAT(FMLS_zzxz, aa64_sve, do_FMLA_zzxz, a, true)
+static gen_helper_gvec_4_ptr * const fmls_idx_fns[4][2] = {
+    { NULL, NULL },
+    { gen_helper_gvec_fmls_idx_h, gen_helper_gvec_ah_fmls_idx_h },
+    { gen_helper_gvec_fmls_idx_s, gen_helper_gvec_ah_fmls_idx_s },
+    { gen_helper_gvec_fmls_idx_d, gen_helper_gvec_ah_fmls_idx_d },
+};
+TRANS_FEAT(FMLS_zzxz, aa64_sve, gen_gvec_fpst_zzzz,
+           fmls_idx_fns[a->esz][s->fpcr_ah],
+           a->rd, a->rn, a->rm, a->ra, a->index,
+           a->esz == MO_16 ? FPST_A64_F16 : FPST_A64)
 
 /*
  *** SVE Floating Point Multiply Indexed Group
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index e4c519f9e33..ae3cb50fa24 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -1680,29 +1680,35 @@ DO_FMUL_IDX(gvec_fmls_nf_idx_s, float32_sub, float32_mul, float32, H4)
 
 #undef DO_FMUL_IDX
 
-#define DO_FMLA_IDX(NAME, TYPE, H)                                         \
+#define DO_FMLA_IDX(NAME, TYPE, H, NEGX, NEGF)                             \
 void HELPER(NAME)(void *vd, void *vn, void *vm, void *va,                  \
                   float_status *stat, uint32_t desc)                       \
 {                                                                          \
     intptr_t i, j, oprsz = simd_oprsz(desc);                               \
     intptr_t segment = MIN(16, oprsz) / sizeof(TYPE);                      \
-    TYPE op1_neg = extract32(desc, SIMD_DATA_SHIFT, 1);                    \
-    intptr_t idx = desc >> (SIMD_DATA_SHIFT + 1);                          \
+    intptr_t idx = simd_data(desc);                                        \
     TYPE *d = vd, *n = vn, *m = vm, *a = va;                               \
-    op1_neg <<= (8 * sizeof(TYPE) - 1);                                    \
     for (i = 0; i < oprsz / sizeof(TYPE); i += segment) {                  \
         TYPE mm = m[H(i + idx)];                                           \
         for (j = 0; j < segment; j++) {                                    \
-            d[i + j] = TYPE##_muladd(n[i + j] ^ op1_neg,                   \
-                                     mm, a[i + j], 0, stat);               \
+            d[i + j] = TYPE##_muladd(n[i + j] ^ NEGX, mm,                  \
+                                     a[i + j], NEGF, stat);                \
         }                                                                  \
     }                                                                      \
     clear_tail(d, oprsz, simd_maxsz(desc));                                \
 }
 
-DO_FMLA_IDX(gvec_fmla_idx_h, float16, H2)
-DO_FMLA_IDX(gvec_fmla_idx_s, float32, H4)
-DO_FMLA_IDX(gvec_fmla_idx_d, float64, H8)
+DO_FMLA_IDX(gvec_fmla_idx_h, float16, H2, 0, 0)
+DO_FMLA_IDX(gvec_fmla_idx_s, float32, H4, 0, 0)
+DO_FMLA_IDX(gvec_fmla_idx_d, float64, H8, 0, 0)
+
+DO_FMLA_IDX(gvec_fmls_idx_h, float16, H2, INT16_MIN, 0)
+DO_FMLA_IDX(gvec_fmls_idx_s, float32, H4, INT32_MIN, 0)
+DO_FMLA_IDX(gvec_fmls_idx_d, float64, H8, INT64_MIN, 0)
+
+DO_FMLA_IDX(gvec_ah_fmls_idx_h, float16, H2, 0, float_muladd_negate_product)
+DO_FMLA_IDX(gvec_ah_fmls_idx_s, float32, H4, 0, float_muladd_negate_product)
+DO_FMLA_IDX(gvec_ah_fmls_idx_d, float64, H8, 0, float_muladd_negate_product)
 
 #undef DO_FMLA_IDX
 
-- 
2.34.1


