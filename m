Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F940C0218A
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2025 16:49:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1teGYW-0006wZ-AR; Sat, 01 Feb 2025 11:41:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1teGYS-0006n4-A8
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 11:41:12 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1teGYP-0001Ft-MT
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 11:41:12 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43618283dedso30903815e9.3
 for <qemu-devel@nongnu.org>; Sat, 01 Feb 2025 08:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738428068; x=1739032868; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1nN6JvuOQo0bgnOPdwIUKuvL3KJLQN2tys8Inm7uigQ=;
 b=uNn5Hi5t8TRiZAPt95O9HYaozOk26XAJ4CoH0+JIZUbmfyu7rfemUwOTEM1stSTlfu
 z+KkZ8HTLFeuow5iZLT5Xye33CkkJDewdeDT86lK/5mtCl+folx0wQ9GVHXx8U6bXiiY
 B+1zT2z1NMncJyf5McGLpTkkA6/mKXXHanB+qp/XpKXEx995lzHQvBnH+hyYhzU1ur73
 VIPQ8FRV0yX2IRJ9s+K7sY8bYQ4yiNB08KGJau0eis9bNsg24tqwOjRRh8XA4xZrXRXy
 InZsLdpwWg6qpiBOanozD+aY0QIGitmTfuc0YmBf/Fo7Hc+DCkciCOYoVmMWjP9cMogs
 GwDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738428068; x=1739032868;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1nN6JvuOQo0bgnOPdwIUKuvL3KJLQN2tys8Inm7uigQ=;
 b=b9FKNCmEJSovRogWlaNyHBMao9eA1DWrBjqbH9MeBb4Zs4mfuKYYiLtZfSISYImOoa
 n2hRRsxePuaiRj5UX4zKox8hAVkKzH7t3ypyafmB/n22Ra9jTVmeSIfFawKV98td3FnN
 LQr93a51cEkiEapGBMY+oii/luRT1KtQHzndnPaqIxqEH0zeuJ16KebuCLLx0DCsN4Z5
 Hj8L4p2MxNh3VT5hmQfIs39jVMveMga2kAvBdRJIsmxdJqr2q1jzAPnd92vk0pwVXe5j
 hx/OfBejqGT/UI55HNtAU65wzFKO9K11uhTojhTyCw7EmOMT3mvjybPv6C3XLcpzjHPD
 owCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYGCRnORVrNIiPE4UknvYCiu41WT8IGSOEG6GBCdboEvsDd6d7O9pWM34c8IsUvln07SV79ePctx5t@nongnu.org
X-Gm-Message-State: AOJu0Yx5ebHhYDujWapxYJbX4NEo73+jbpKOC5juYE2SHeUJTpBEoX37
 L9MMGnko6HnZ1RN4SAJ4vevSUyjkLi/JRD3zGEQiOUM8LBSn4wp28jHt/kV3x8w=
X-Gm-Gg: ASbGncs5hSOjEcv4QAvwYCxQLOF/xvYOON2h8q/IYyEQnCg8Rd0/uYwAnxn+HqEaWp3
 mp4gigDWUJQXu45ebN5trojd4DRMKoIEecxHycWdmVJ2S0aGxWxJt1EyxXTU5WTsm+r95OeDvAZ
 tig0XTzjUtQVYcIFcxqIDqVTOggcCDIZhglPKpo4zlR0mYRtVR0qBEe738OX/pjxzHSHUsYbo4y
 AaPWHISuXkLAmpfMh7z7vWV9cQvc3r/3EyC/9OstPFJqdC51Rua9Bz76rCeQAVEFSdHHnUOPL4a
 mpRD02EFj4OzmlNqwpEU
X-Google-Smtp-Source: AGHT+IFY1WQmF+OPsnZb4G8GKU3k8YHIEoK6p/qdI9eaIwmyo3f6KZ0H8esYP8fWihzt7KOMvY6Npw==
X-Received: by 2002:a05:600c:19d2:b0:435:330d:de86 with SMTP id
 5b1f17b1804b1-438dc34b37bmr152235035e9.0.1738428068245; 
 Sat, 01 Feb 2025 08:41:08 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc81d74sm127401525e9.37.2025.02.01.08.41.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Feb 2025 08:41:07 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 41/69] target/arm: Handle FPCR.AH in negation step in FMLS
 (indexed)
Date: Sat,  1 Feb 2025 16:39:44 +0000
Message-Id: <20250201164012.1660228-42-peter.maydell@linaro.org>
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
index 03b629e0ba0..2509a29528e 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -6737,10 +6737,16 @@ TRANS(FMULX_vi, do_fp3_vector_idx, a, f_vector_idx_fmulx)
 
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
@@ -6751,8 +6757,7 @@ static bool do_fmla_vector_idx(DisasContext *s, arg_qrrx_e *a, bool neg)
 
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


