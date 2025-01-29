Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 953D2C0218A
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 01:40:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcx33-0000wp-Ua; Tue, 28 Jan 2025 20:39:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcx32-0000vy-Pc
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 20:39:20 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcx31-0003aS-1H
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 20:39:20 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-21649a7bcdcso108637315ad.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 17:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738114758; x=1738719558; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7KtZe2UNW2JnaIqn7Gbdf27hapONa+RkHfHv+xxvuwc=;
 b=QlUU8y6rsnuPiMv4jX1yDoa957TEs53CzQlF6wGFy+ywCEXtTxhFT0rjEDLxYuaTAc
 FHORkE2HdA7dt+sZP0ieI1GZh/QaFBvfi1JoWl//BXG6/cneU/YYUKzbv0jlRgy+rzWq
 L56QESW831IIglV+QtXMF+2OtV9Q3LokxQ3WgeCVpyURaK/f0iF480fBUgdVQ+RQqPc4
 folmJfLHMmrp5KQCtYG2idC44kvZHvBt0wd17gI2z7Bv3QPEwEgSPWiR4hoDbmmWR4zW
 FtQ2CVgtLiLlk0muH6TgZTv1sbGIzocuAXHIuAhmSrnTyJfH3IvwHjFHK92ILLn1huV+
 /fFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738114758; x=1738719558;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7KtZe2UNW2JnaIqn7Gbdf27hapONa+RkHfHv+xxvuwc=;
 b=i671PIR/L5D1kgz+U+lf7ErAzWs5FVrfYc5R4zkAQpz/oM9ffkbtzomx9ENxqjNCBN
 fOWL3sPzF3FaySTC5278IpZ4gtXkW6omA+1KH59rwKDMtnxi/wCfYdadgkFhCvmWIOws
 b9jijolYix8BJ02rYVwvsT7Dg55RxxanNzswbhUJP2WcU6pDfAKx30ofwVHp91KMGtXG
 gIkdY4ZqXTjqKoeFEcq9MlV5+hw7OhmGUU6KJNvIIAnJg4SeX7+ro8LYv73uWg3xGIVW
 M1qgQH19RNF5hEOFsY2n2fXMRBocNPXWNetxsDEswoh2mrN76erzOkcn5O4am6Io5TDi
 rIjA==
X-Gm-Message-State: AOJu0Yw+1cqE7JAE91Mi9yDZXLX4nS2nU63Rmf+Zx85QDfCPh6c9Od7c
 Y4oZyrlJ4OKzDN+Ds0L6Yh9IhA56aXjhLvkw97apKJC1TL/CXG7gIpHP6yolB/BoVMagMqbOnUx
 N
X-Gm-Gg: ASbGncvPGIPMmdNUvTWPlH5ogd5n5hxtN1+T34DYKpkXuM2FGJvSfCm+bEV0h9Q2mht
 bBAi4Nlvp3Fv8VzpVYK6gWvts9KuWuPD6ynkG8LrreXifFGtN5JmCJstcuWQ5kX+aRRBg55pNaG
 0JxB8XcSarc3QHJuIofDxGNdXUjRjNoB9MoScHysYSf2n3X0fzBUP1MUUqvi0S92kubrSpYx9Bq
 tPGjWObEhQZ2bL2ta265RPHvXpCzjdzLPAQy4BAGWMO7R3rtySzHuOMUAy3rINkIcVVvw92dNYZ
 cRgavtZZEtv2UHmxGbh9PVJaji+c7KiS0kzOP9NPdofVbybhxg==
X-Google-Smtp-Source: AGHT+IEmJoAGJzr0veghaBQmrWxIY8frI9iDDUgE3Zqz+zaBMjGmW6BS7AQ0sMv775uGVgzsjpNIkA==
X-Received: by 2002:a17:903:190:b0:216:2abc:195c with SMTP id
 d9443c01a7336-21dd7c46ca9mr17937205ad.7.1738114757669; 
 Tue, 28 Jan 2025 17:39:17 -0800 (PST)
Received: from stoup.. (71-212-32-190.tukw.qwest.net. [71.212.32.190])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21da3ea4200sm89341745ad.88.2025.01.28.17.39.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2025 17:39:17 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v2 28/34] target/arm: Split gvec_fmla_idx_* for fmls and
 ah_fmls
Date: Tue, 28 Jan 2025 17:38:51 -0800
Message-ID: <20250129013857.135256-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250129013857.135256-1-richard.henderson@linaro.org>
References: <20250129013857.135256-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

Split negation cases out of gvec_fmla, creating 6 new helpers.
We no longer pass 'neg' as a bit in simd_data.

Handle FPCR.AH=0 via xor and FPCR.AH=1 via muladd flags.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.h            | 14 ++++++++++++++
 target/arm/tcg/translate-a64.c | 17 +++++++++++------
 target/arm/tcg/translate-sve.c | 31 +++++++++++++++++--------------
 target/arm/tcg/vec_helper.c    | 29 +++++++++++++++--------------
 4 files changed, 57 insertions(+), 34 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index dbad1f5d74..0907505839 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -821,6 +821,20 @@ DEF_HELPER_FLAGS_6(gvec_fmla_idx_s, TCG_CALL_NO_RWG,
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
index 9e751e737a..9b1675b041 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -6742,10 +6742,16 @@ TRANS(FMULX_vi, do_fp3_vector_idx, a, f_vector_idx_fmulx)
 
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
@@ -6756,8 +6762,7 @@ static bool do_fmla_vector_idx(DisasContext *s, arg_qrrx_e *a, bool neg)
 
     gen_gvec_op4_fpst(s, a->q, a->rd, a->rn, a->rm, a->rd,
                       esz == MO_16 ? FPST_A64_F16 : FPST_A64,
-                      (s->fpcr_ah << 5) | (a->idx << 1) | neg,
-                      fns[esz - 1]);
+                      a->idx, fns[esz - 1][neg ? 1 + s->fpcr_ah : 0]);
     return true;
 }
 
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 6e758fd1ca..dbe66d3b15 100644
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
-                              (s->fpcr_ah << 5) | (a->index << 1) | sub,
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
index 964000773a..728473e919 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -1724,34 +1724,35 @@ DO_FMUL_IDX(gvec_fmls_nf_idx_s, float32_sub, float32_mul, float32, H4)
 
 #undef DO_FMUL_IDX
 
-#define DO_FMLA_IDX(NAME, TYPE, H)                                         \
+#define DO_FMLA_IDX(NAME, TYPE, H, NEGX, NEGF)                             \
 void HELPER(NAME)(void *vd, void *vn, void *vm, void *va,                  \
                   float_status *stat, uint32_t desc)                       \
 {                                                                          \
     intptr_t i, j, oprsz = simd_oprsz(desc);                               \
     intptr_t segment = MIN(16, oprsz) / sizeof(TYPE);                      \
-    TYPE op1_neg = extract32(desc, SIMD_DATA_SHIFT, 1);                    \
-    intptr_t idx = extract32(desc, SIMD_DATA_SHIFT + 1, 3);                \
-    bool fpcr_ah = extract32(desc, SIMD_DATA_SHIFT + 5, 1);                \
+    intptr_t idx = simd_data(desc);                                        \
     TYPE *d = vd, *n = vn, *m = vm, *a = va;                               \
-    op1_neg <<= (8 * sizeof(TYPE) - 1);                                    \
     for (i = 0; i < oprsz / sizeof(TYPE); i += segment) {                  \
         TYPE mm = m[H(i + idx)];                                           \
         for (j = 0; j < segment; j++) {                                    \
-            TYPE nval = n[i + j];                                          \
-            if (!(fpcr_ah && TYPE ## _is_any_nan(nval))) {                 \
-                nval ^= op1_neg;                                           \
-            }                                                              \
-            d[i + j] = TYPE##_muladd(nval,                                 \
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
2.43.0


