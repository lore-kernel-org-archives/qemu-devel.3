Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ECD7C0218A
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2025 16:48:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1teGZ1-0008Cg-K8; Sat, 01 Feb 2025 11:41:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1teGYb-0007Bm-Jf
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 11:41:21 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1teGYY-0001Ic-UI
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 11:41:21 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43618283dedso30904715e9.3
 for <qemu-devel@nongnu.org>; Sat, 01 Feb 2025 08:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738428077; x=1739032877; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oWHlihOIdQ6CYG5rSBr2TwbytpUFZOd7E5qydFIL3W0=;
 b=LPmic01cwD2N6rdixpwK043BVvnx7E5U/sEJuFF47dll29HH4liPg5ycxLXzU3/2SX
 o0oC2WDUIbB9ioKHteKfYZuyN4//d/P5/tvyTh7qaJtGgV+GfPLviP9ri1QsbFQv5Kef
 AOrD1EdSzjXWfbYiYreZElN9Y+xLlJNBzhqTiRoNAXWbB92fR7LKiu+YjqCe4O/LcQrY
 kEzr8n2+KF306YCdx+ry0jNSsrWEAAeqI39MNJtYD3UhsqTMghyeCkd1dg91mL/y/qAo
 bZhdGuTsdtkYAJ4g+yWOlgu+wgnX+hJA/ShusYkPewSN5lse/eu7pe5Bqqli5jOKB/pR
 Vh+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738428077; x=1739032877;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oWHlihOIdQ6CYG5rSBr2TwbytpUFZOd7E5qydFIL3W0=;
 b=rmrd8G+vOLQ072bMwT/iNEjbbxRtgbkBSH+Z8DwTCB6Na+bontxOVJ6gEztv2goVAs
 DA/qyqT+dJaaY1OBxiyRGl8SrDDh4eXQ/9kK/FFWa6mY5DTEnbaKUOR7Ge06qE5RfCoC
 vKSjvXeEFGd4aU4qwz3IjuqLUbQpwFmqYvjH0lib5EnpTEofV05ez8uM4/mHyRZl1ypf
 P8WcDZAyY+bFscWvvARbPIJOXAYWLP5WUaDta1FFpqd2aNZ9IXdkAgH4c37mpncxgC5J
 3MqEj8zv+GDltrW+lMl0Q1G22CKuC9wozHhbxGJEqrwJkxYY+aTUOpWNqk5AuaY+2dMi
 L13A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWinD9tq+j+T1zCk+HLbqfb8IsjF5rPOgNisAnGvKg6QxluIkreCzFooxXVRcHcQAoIfwWajX1pwZds@nongnu.org
X-Gm-Message-State: AOJu0Yykc1s0FQroCKgcopq48eAQuAz7C/HcxAwXs6ABOGPdLWMw3oyu
 wqhyyrGP430r6KlA//2OacEnoG7MqvFni8XemIjNEQPf6IS9XUcQIzNFjr7txB8om1UgoxS+iJO
 f
X-Gm-Gg: ASbGncuBjhOvlLVARa0m5MX/vIWzFkNJAviS1bGgLNfLxSNTvXNdeeBkRMgYHbScAYb
 sAR7WVGnM6k7DGuFDstXZzA3FHSB5tnrwCduHvR1p6yP9DPIwYt/i+twVw24whzWshDpfJTWXxK
 2YeLttVQrBUg8Gmi0QLrxFhQK6IoCHH9MkF7nGfqxSar/TznvMvhHDTWDJuB9NFzoq5HlzI6syu
 WJ1ngbor9QfsM+eb0V28jV6Hq0tfj/FPDcGigqo5oJUpgwCmX0A1RPLm1c9OowfV9Kj6X9C3vcP
 8mbJb7TJnl2P5zCgHi/6
X-Google-Smtp-Source: AGHT+IH6Rynzqr7Vi0FaDjOyWTjEz/nFtdWj7QbnISjHvyml/ojYf+PP+og7RPagVyxtkrhdeH/oOA==
X-Received: by 2002:a05:600c:3b0e:b0:435:d22:9c9e with SMTP id
 5b1f17b1804b1-438dc40d6ddmr123462595e9.19.1738428077373; 
 Sat, 01 Feb 2025 08:41:17 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc81d74sm127401525e9.37.2025.02.01.08.41.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Feb 2025 08:41:16 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 48/69] target/arm: Handle FPCR.AH in SVE FCMLA
Date: Sat,  1 Feb 2025 16:39:51 +0000
Message-Id: <20250201164012.1660228-49-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250201164012.1660228-1-peter.maydell@linaro.org>
References: <20250201164012.1660228-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The negation step in SVE FCMLA mustn't negate a NaN when FPCR.AH is
set.  Use the same approach as we did for A64 FCMLA of passing in
FPCR.AH and using it to select whether to negate by XOR or by the
muladd negate_product flag.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250129013857.135256-28-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/sve_helper.c    | 69 +++++++++++++++++++++-------------
 target/arm/tcg/translate-sve.c |  2 +-
 2 files changed, 43 insertions(+), 28 deletions(-)

diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index c12b2600bd7..c206ca65ceb 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -5347,13 +5347,18 @@ void HELPER(sve_fcmla_zpzzz_h)(void *vd, void *vn, void *vm, void *va,
                                void *vg, float_status *status, uint32_t desc)
 {
     intptr_t j, i = simd_oprsz(desc);
-    unsigned rot = simd_data(desc);
-    bool flip = rot & 1;
-    float16 neg_imag, neg_real;
+    bool flip = extract32(desc, SIMD_DATA_SHIFT, 1);
+    uint32_t fpcr_ah = extract32(desc, SIMD_DATA_SHIFT + 2, 1);
+    uint32_t negf_imag = extract32(desc, SIMD_DATA_SHIFT + 1, 1);
+    uint32_t negf_real = flip ^ negf_imag;
+    float16 negx_imag, negx_real;
     uint64_t *g = vg;
 
-    neg_imag = float16_set_sign(0, (rot & 2) != 0);
-    neg_real = float16_set_sign(0, rot == 1 || rot == 2);
+    /* With AH=0, use negx; with AH=1 use negf. */
+    negx_real = (negf_real & ~fpcr_ah) << 15;
+    negx_imag = (negf_imag & ~fpcr_ah) << 15;
+    negf_real = (negf_real & fpcr_ah ? float_muladd_negate_product : 0);
+    negf_imag = (negf_imag & fpcr_ah ? float_muladd_negate_product : 0);
 
     do {
         uint64_t pg = g[(i - 1) >> 6];
@@ -5370,18 +5375,18 @@ void HELPER(sve_fcmla_zpzzz_h)(void *vd, void *vn, void *vm, void *va,
             mi = *(float16 *)(vm + H1_2(j));
 
             e2 = (flip ? ni : nr);
-            e1 = (flip ? mi : mr) ^ neg_real;
+            e1 = (flip ? mi : mr) ^ negx_real;
             e4 = e2;
-            e3 = (flip ? mr : mi) ^ neg_imag;
+            e3 = (flip ? mr : mi) ^ negx_imag;
 
             if (likely((pg >> (i & 63)) & 1)) {
                 d = *(float16 *)(va + H1_2(i));
-                d = float16_muladd(e2, e1, d, 0, status);
+                d = float16_muladd(e2, e1, d, negf_real, status);
                 *(float16 *)(vd + H1_2(i)) = d;
             }
             if (likely((pg >> (j & 63)) & 1)) {
                 d = *(float16 *)(va + H1_2(j));
-                d = float16_muladd(e4, e3, d, 0, status);
+                d = float16_muladd(e4, e3, d, negf_imag, status);
                 *(float16 *)(vd + H1_2(j)) = d;
             }
         } while (i & 63);
@@ -5392,13 +5397,18 @@ void HELPER(sve_fcmla_zpzzz_s)(void *vd, void *vn, void *vm, void *va,
                                void *vg, float_status *status, uint32_t desc)
 {
     intptr_t j, i = simd_oprsz(desc);
-    unsigned rot = simd_data(desc);
-    bool flip = rot & 1;
-    float32 neg_imag, neg_real;
+    bool flip = extract32(desc, SIMD_DATA_SHIFT, 1);
+    uint32_t fpcr_ah = extract32(desc, SIMD_DATA_SHIFT + 2, 1);
+    uint32_t negf_imag = extract32(desc, SIMD_DATA_SHIFT + 1, 1);
+    uint32_t negf_real = flip ^ negf_imag;
+    float32 negx_imag, negx_real;
     uint64_t *g = vg;
 
-    neg_imag = float32_set_sign(0, (rot & 2) != 0);
-    neg_real = float32_set_sign(0, rot == 1 || rot == 2);
+    /* With AH=0, use negx; with AH=1 use negf. */
+    negx_real = (negf_real & ~fpcr_ah) << 31;
+    negx_imag = (negf_imag & ~fpcr_ah) << 31;
+    negf_real = (negf_real & fpcr_ah ? float_muladd_negate_product : 0);
+    negf_imag = (negf_imag & fpcr_ah ? float_muladd_negate_product : 0);
 
     do {
         uint64_t pg = g[(i - 1) >> 6];
@@ -5415,18 +5425,18 @@ void HELPER(sve_fcmla_zpzzz_s)(void *vd, void *vn, void *vm, void *va,
             mi = *(float32 *)(vm + H1_2(j));
 
             e2 = (flip ? ni : nr);
-            e1 = (flip ? mi : mr) ^ neg_real;
+            e1 = (flip ? mi : mr) ^ negx_real;
             e4 = e2;
-            e3 = (flip ? mr : mi) ^ neg_imag;
+            e3 = (flip ? mr : mi) ^ negx_imag;
 
             if (likely((pg >> (i & 63)) & 1)) {
                 d = *(float32 *)(va + H1_2(i));
-                d = float32_muladd(e2, e1, d, 0, status);
+                d = float32_muladd(e2, e1, d, negf_real, status);
                 *(float32 *)(vd + H1_2(i)) = d;
             }
             if (likely((pg >> (j & 63)) & 1)) {
                 d = *(float32 *)(va + H1_2(j));
-                d = float32_muladd(e4, e3, d, 0, status);
+                d = float32_muladd(e4, e3, d, negf_imag, status);
                 *(float32 *)(vd + H1_2(j)) = d;
             }
         } while (i & 63);
@@ -5437,13 +5447,18 @@ void HELPER(sve_fcmla_zpzzz_d)(void *vd, void *vn, void *vm, void *va,
                                void *vg, float_status *status, uint32_t desc)
 {
     intptr_t j, i = simd_oprsz(desc);
-    unsigned rot = simd_data(desc);
-    bool flip = rot & 1;
-    float64 neg_imag, neg_real;
+    bool flip = extract32(desc, SIMD_DATA_SHIFT, 1);
+    uint32_t fpcr_ah = extract32(desc, SIMD_DATA_SHIFT + 2, 1);
+    uint32_t negf_imag = extract32(desc, SIMD_DATA_SHIFT + 1, 1);
+    uint32_t negf_real = flip ^ negf_imag;
+    float64 negx_imag, negx_real;
     uint64_t *g = vg;
 
-    neg_imag = float64_set_sign(0, (rot & 2) != 0);
-    neg_real = float64_set_sign(0, rot == 1 || rot == 2);
+    /* With AH=0, use negx; with AH=1 use negf. */
+    negx_real = (uint64_t)(negf_real & ~fpcr_ah) << 63;
+    negx_imag = (uint64_t)(negf_imag & ~fpcr_ah) << 63;
+    negf_real = (negf_real & fpcr_ah ? float_muladd_negate_product : 0);
+    negf_imag = (negf_imag & fpcr_ah ? float_muladd_negate_product : 0);
 
     do {
         uint64_t pg = g[(i - 1) >> 6];
@@ -5460,18 +5475,18 @@ void HELPER(sve_fcmla_zpzzz_d)(void *vd, void *vn, void *vm, void *va,
             mi = *(float64 *)(vm + H1_2(j));
 
             e2 = (flip ? ni : nr);
-            e1 = (flip ? mi : mr) ^ neg_real;
+            e1 = (flip ? mi : mr) ^ negx_real;
             e4 = e2;
-            e3 = (flip ? mr : mi) ^ neg_imag;
+            e3 = (flip ? mr : mi) ^ negx_imag;
 
             if (likely((pg >> (i & 63)) & 1)) {
                 d = *(float64 *)(va + H1_2(i));
-                d = float64_muladd(e2, e1, d, 0, status);
+                d = float64_muladd(e2, e1, d, negf_real, status);
                 *(float64 *)(vd + H1_2(i)) = d;
             }
             if (likely((pg >> (j & 63)) & 1)) {
                 d = *(float64 *)(va + H1_2(j));
-                d = float64_muladd(e4, e3, d, 0, status);
+                d = float64_muladd(e4, e3, d, negf_imag, status);
                 *(float64 *)(vd + H1_2(j)) = d;
             }
         } while (i & 63);
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 410087c3fbd..6af94fedd0a 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -3955,7 +3955,7 @@ static gen_helper_gvec_5_ptr * const fcmla_fns[4] = {
     gen_helper_sve_fcmla_zpzzz_s, gen_helper_sve_fcmla_zpzzz_d,
 };
 TRANS_FEAT(FCMLA_zpzzz, aa64_sve, gen_gvec_fpst_zzzzp, fcmla_fns[a->esz],
-           a->rd, a->rn, a->rm, a->ra, a->pg, a->rot,
+           a->rd, a->rn, a->rm, a->ra, a->pg, a->rot | (s->fpcr_ah << 2),
            a->esz == MO_16 ? FPST_A64_F16 : FPST_A64)
 
 static gen_helper_gvec_4_ptr * const fcmla_idx_fns[4] = {
-- 
2.34.1


