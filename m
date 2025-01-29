Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FADCC0218A
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 01:41:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcx35-0000xn-M9; Tue, 28 Jan 2025 20:39:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcx32-0000vb-Au
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 20:39:20 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcx30-0003aB-Ak
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 20:39:20 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2161eb95317so112870075ad.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 17:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738114757; x=1738719557; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E6s6Bttm348mWSm0/c7QCs4W+Lrir+/6j+pGa2tJr0M=;
 b=f5n/lwBWsHEuOCSvWcXywNFu9sswv+ZeRZrhQqZuTodhyWLKXKo2nrdP5kNT4fhAo+
 vEyTi1MNiLDchYn5nNz6sbi16xOB8MyM1a9Lj8GYtxfz471Y8/OgXG36i8QpQ6W9Qf4r
 35psvt3dw+rvknFgK7YWjPYSQxwD85VVDzqIUKWEzHKaiDHXJakh4LZbFS1cwHZwv2ru
 anec7SHIDT2WcqrlJL0cjeOJOu/SIgRhqRgP5j8603GOTCSil29r0HB8uWksMgbLdaqX
 1pzV/0Umi8FbDumY0i5NB+CFm+rqCRw2wjacAXn14iS+Iby+d/vVqZKp3oB6eeT6zwrf
 5xbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738114757; x=1738719557;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E6s6Bttm348mWSm0/c7QCs4W+Lrir+/6j+pGa2tJr0M=;
 b=bQQomeSZfCRAHJPGAF7IFwHJmA/u/ugAYioPoJsgna9WRJtY9qvSij5oVywT67vZ1Z
 SAyQn+5htvqZfYp8qpJaaWIHiD2iNZKZini+nu32q9wgoO0pzRGfm26RpMyvNzf5qdrg
 R5pKjH9iNhA5RILioKhvPky6sRLRNr1ZzY3YPNyyt5TH8zUfiLNay/h7EhJFTpERTGYW
 wGi8EFGe8Lp1j7A48/Ifnp4hl3G8tGKo3t/WIxnYjRpN+KhuCAKu4La1bjzWHIjdZHvi
 t098HeqXOKP429tJpRtD8ORLVmEu2S2JhprnuD5RIPXJbZeNUDi55ykV3ZWdAz9a/52q
 NvdA==
X-Gm-Message-State: AOJu0Yxefwi+Mjp3T7x2ZO1DxhuT1Vk5qX3OertM1GY5k4OxzPNMVI9D
 biqY11P3OnvEfjNjkzUCgcEj0kE1uE2BnB3P0kp5JmgRsQci0Z7CaZG4s8IRej6cGvqn0KI8rje
 1
X-Gm-Gg: ASbGncvHfP0kcWkvXk+MeIHNuM0hZPs4xO25hZgzi0y6+IKuj7JE2XJkdBsiKl8xpCm
 wGo/Lqxbe7Xe3O13BIvrienDuYEoaqZ48z3t0iicmnL98p+Z+I+jCeF7RhhCx+hu7U5pB8xOyng
 N/TarQd8RSlKPioGqrVNDZWQtBRvILtGNk3KfL36DrVNIGzU//CL2Yan0zcGGsqu1e3YUBv7tPC
 cFgDtmBdG2kuTLbKtu8IJuasRxHx76WCpwITJT7pJI4OokX4O0d4ViR7KqZSUyhQ5B+WH4ZgwFg
 /4eyDIIkf68W4uL3TaQXSGZzKNs/lgrc4WTNDqf4qAsxQdhlaA==
X-Google-Smtp-Source: AGHT+IHC4EtXbszrWBwl9ZuDSleFXh1e7pPrFCvmu1cUleOJ3l4u4D7AO5ovwARcI1+LSaHM6bnt2A==
X-Received: by 2002:a17:902:ce04:b0:215:a3e4:d251 with SMTP id
 d9443c01a7336-21dd7c55d7dmr18224415ad.6.1738114757031; 
 Tue, 28 Jan 2025 17:39:17 -0800 (PST)
Received: from stoup.. (71-212-32-190.tukw.qwest.net. [71.212.32.190])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21da3ea4200sm89341745ad.88.2025.01.28.17.39.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2025 17:39:16 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v2 27/34] target/arm: Handle FPCR.AH in sve_fcmla_zpzzz_*
Date: Tue, 28 Jan 2025 17:38:50 -0800
Message-ID: <20250129013857.135256-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250129013857.135256-1-richard.henderson@linaro.org>
References: <20250129013857.135256-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/sve_helper.c    | 69 +++++++++++++++++++++-------------
 target/arm/tcg/translate-sve.c |  2 +-
 2 files changed, 43 insertions(+), 28 deletions(-)

diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index c12b2600bd..c206ca65ce 100644
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
index cb6bb27622..6e758fd1ca 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -3964,7 +3964,7 @@ static gen_helper_gvec_5_ptr * const fcmla_fns[4] = {
     gen_helper_sve_fcmla_zpzzz_s, gen_helper_sve_fcmla_zpzzz_d,
 };
 TRANS_FEAT(FCMLA_zpzzz, aa64_sve, gen_gvec_fpst_zzzzp, fcmla_fns[a->esz],
-           a->rd, a->rn, a->rm, a->ra, a->pg, a->rot,
+           a->rd, a->rn, a->rm, a->ra, a->pg, a->rot | (s->fpcr_ah << 2),
            a->esz == MO_16 ? FPST_A64_F16 : FPST_A64)
 
 static gen_helper_gvec_4_ptr * const fcmla_idx_fns[4] = {
-- 
2.43.0


