Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45177C8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:54:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXhWk-00086N-Qr; Fri, 04 Jul 2025 10:36:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhPE-0002W4-Q6
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:28:52 -0400
Received: from mail-oa1-x2b.google.com ([2001:4860:4864:20::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhPC-0001OX-EL
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:28:48 -0400
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-2f75f1c7206so365358fac.0
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 07:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751639324; x=1752244124; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TLwhOZ7GimxFfUs0k+KKvvoGB8pRA1gs/A/RB7/ShdI=;
 b=T5gCEKXYvRqUvH9gypYgTTnk8a4I9h7/mwsiZdBppZBRSW4txSJhDTkw3rlFiTImsI
 3eojSHrXyRSngqH0udUCqUJLbEpTVCkU2txu7a5NJV7Ne6v2J0dDsmOxTv/BuMlhoukQ
 76hX9X6TKPNq9hUXDlghjuz0MAWKGVdSgxKRlNPZr0LOBuuspdgXLyKGbxmcLeRiivw4
 1CxcBkCzmvsG0dEqTyEOVvDagPK5ManzOX4GriZHgxePRSESnVq0bKHCnw89QjFQhja9
 XLW1KAH9HvUd921yB2oJHcX0hge8ip3K3GgF2P7GD7XUsPmO5K70FTnm51C9ht1ExPuv
 K/Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751639324; x=1752244124;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TLwhOZ7GimxFfUs0k+KKvvoGB8pRA1gs/A/RB7/ShdI=;
 b=ZwVVBCM7m9+VuDh4t4qddiFAmr4Pj6yOBTIk5inSQezeuw4m5/rtZ1PLxAE9cmgqR5
 zd/I5Y4AMlh/LBGjzHsQ27LTeLylMw1cd1WEFwpEvsOHxC+K9bbWg08YrdrT3mSCGge+
 WelvH1LqhjkzOklXXlVb235vyQPKEs7A9soB7QRIpH3INaWU+0AR1/jdCfQU4gmca5hy
 NQgEuTz2scd0zEoo7JEv6j8p1ST0F4ZSQ8CNkb0WV2o0IIQqtHBpk1t1VHaDHQfUN1uv
 1kCBrQksnlGXhbN6QdVZBJYmbBFUUQPdzOUNF/dqRZ7zB7xY3dje6qTTK1QjbtZaE88Y
 L/pA==
X-Gm-Message-State: AOJu0YxhHwC1atvZyoZUnMLFdw/5i/m/zVwTzAxNa6scWp4DHVO4H3Ao
 cZUkegejXscDOOWZQxd1WpnjhSyOdYDBX5JXlPuW89Noq0Or3rug2yGIWg1y5rP6X/OqdKePfGh
 38LerMwo=
X-Gm-Gg: ASbGncuqqEjWmRK1pyl01AYVW6LRdB8/4cVQKNyoWOqjmFrG3XuoRPYGW36twaGvD2M
 MY3fVoY49PFy0kTvAmRXWgDr20jVrdbtTIEhrprUZgCPVV4SW5704MqhH2EG5tJE7SayLC7mCu4
 3iNhjHku4YTKCmZzZJeTIhvtTgmJeP9E6edQUSas9F864i4U6+GVtydu1aAOim6M6ZvSOcoyq8D
 NW4HIId6W1UrLi0XtjtwkN3uW7Dd2r4hItPWmp6lFlmUrmES/8JG0iI+3nxl48a9WKw1VzZB5ct
 DtFK866WgcbDQLJrvMh7g2nIcky2w6L39MbAS9rzkEf/ve2tZb/uS4NPn6rkihzd6a55UJ5UUfN
 0UZHOSuBb4CA7CN+vtsUvPn3o6auPB5e/+vXTjAM1e/xCqMU91MPSevAwTso=
X-Google-Smtp-Source: AGHT+IG4NZ7t641YEeBxwgOqfGibau63802wNBXQm0M7uzy4fxT2IoSY+ozYzfyB4iczGoimNu6PFw==
X-Received: by 2002:a05:6870:8dc8:b0:2e8:ff0e:17d3 with SMTP id
 586e51a60fabf-2f796d34599mr1654807fac.21.1751639324206; 
 Fri, 04 Jul 2025 07:28:44 -0700 (PDT)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2f78ff55633sm531448fac.20.2025.07.04.07.28.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 07:28:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v4 085/108] target/arm: Implement FADDQV, F{MIN,
 MAX}{NM}QV for SVE2p1
Date: Fri,  4 Jul 2025 08:20:48 -0600
Message-ID: <20250704142112.1018902-86-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704142112.1018902-1-richard.henderson@linaro.org>
References: <20250704142112.1018902-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2b.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-sve.h    | 49 ++++++++++++++++++++++++
 target/arm/tcg/sve_helper.c    | 70 +++++++++++++++++++++-------------
 target/arm/tcg/translate-sve.c | 48 +++++++++++++++++++++++
 target/arm/tcg/sve.decode      |  8 ++++
 4 files changed, 148 insertions(+), 27 deletions(-)

diff --git a/target/arm/tcg/helper-sve.h b/target/arm/tcg/helper-sve.h
index 9758613b2d..906da384dc 100644
--- a/target/arm/tcg/helper-sve.h
+++ b/target/arm/tcg/helper-sve.h
@@ -1077,6 +1077,55 @@ DEF_HELPER_FLAGS_4(sve_ah_fminv_s, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_4(sve_ah_fminv_d, TCG_CALL_NO_RWG,
                    i64, ptr, ptr, fpst, i32)
 
+DEF_HELPER_FLAGS_5(sve2p1_faddqv_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(sve2p1_faddqv_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(sve2p1_faddqv_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, fpst, i32)
+
+DEF_HELPER_FLAGS_5(sve2p1_fmaxnmqv_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(sve2p1_fmaxnmqv_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(sve2p1_fmaxnmqv_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, fpst, i32)
+
+DEF_HELPER_FLAGS_5(sve2p1_fminnmqv_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(sve2p1_fminnmqv_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(sve2p1_fminnmqv_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, fpst, i32)
+
+DEF_HELPER_FLAGS_5(sve2p1_fmaxqv_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(sve2p1_fmaxqv_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(sve2p1_fmaxqv_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, fpst, i32)
+
+DEF_HELPER_FLAGS_5(sve2p1_fminqv_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(sve2p1_fminqv_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(sve2p1_fminqv_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, fpst, i32)
+
+DEF_HELPER_FLAGS_5(sve2p1_ah_fmaxqv_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(sve2p1_ah_fmaxqv_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(sve2p1_ah_fmaxqv_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, fpst, i32)
+
+DEF_HELPER_FLAGS_5(sve2p1_ah_fminqv_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(sve2p1_ah_fminqv_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(sve2p1_ah_fminqv_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, fpst, i32)
+
 DEF_HELPER_FLAGS_5(sve_fadda_h, TCG_CALL_NO_RWG,
                    i64, i64, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(sve_fadda_s, TCG_CALL_NO_RWG,
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index f47e719fbe..6512df54e6 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -4361,19 +4361,20 @@ uint32_t HELPER(sve_whilecg)(void *vd, uint32_t count, uint32_t pred_desc)
  * The recursion is bounded to depth 7 (128 fp16 elements), so there's
  * little to gain with a more complex non-recursive form.
  */
-#define DO_REDUCE(NAME, TYPE, H, FUNC, IDENT)                         \
-static TYPE NAME##_reduce(TYPE *data, float_status *status, uintptr_t n) \
+#define DO_REDUCE(NAME, SUF, TYPE, H, FUNC, IDENT)                      \
+static TYPE FUNC##_reduce(TYPE *data, float_status *status, uintptr_t n) \
 {                                                                     \
     if (n == 1) {                                                     \
         return *data;                                                 \
     } else {                                                          \
         uintptr_t half = n / 2;                                       \
-        TYPE lo = NAME##_reduce(data, status, half);                  \
-        TYPE hi = NAME##_reduce(data + half, status, half);           \
+        TYPE lo = FUNC##_reduce(data, status, half);                  \
+        TYPE hi = FUNC##_reduce(data + half, status, half);           \
         return FUNC(lo, hi, status);                                  \
     }                                                                 \
 }                                                                     \
-uint64_t HELPER(NAME)(void *vn, void *vg, float_status *s, uint32_t desc) \
+uint64_t helper_sve_##NAME##v_##SUF(void *vn, void *vg,               \
+                                    float_status *s, uint32_t desc)   \
 {                                                                     \
     uintptr_t i, oprsz = simd_oprsz(desc), maxsz = simd_data(desc);   \
     TYPE data[sizeof(ARMVectorReg) / sizeof(TYPE)];                   \
@@ -4388,39 +4389,54 @@ uint64_t HELPER(NAME)(void *vn, void *vg, float_status *s, uint32_t desc) \
     for (; i < maxsz; i += sizeof(TYPE)) {                            \
         *(TYPE *)((void *)data + i) = IDENT;                          \
     }                                                                 \
-    return NAME##_reduce(data, s, maxsz / sizeof(TYPE));              \
+    return FUNC##_reduce(data, s, maxsz / sizeof(TYPE));              \
+}                                                                     \
+void helper_sve2p1_##NAME##qv_##SUF(void *vd, void *vn, void *vg,     \
+                                    float_status *status, uint32_t desc) \
+{                                                                     \
+    unsigned oprsz = simd_oprsz(desc), segments = oprsz / 16;         \
+    for (unsigned e = 0; e < 16; e += sizeof(TYPE)) {                 \
+        TYPE data[ARM_MAX_VQ];                                        \
+        for (unsigned s = 0; s < segments; s++) {                     \
+            uint16_t pg = *(uint16_t *)(vg + H1_2(s * 2));            \
+            TYPE nn = *(TYPE *)(vn + H(s * 16 + H(e)));               \
+            data[s] = (pg >> e) & 1 ? nn : IDENT;                     \
+        }                                                             \
+        *(TYPE *)(vd + H(e)) = FUNC##_reduce(data, status, segments); \
+    }                                                                 \
+    clear_tail(vd, 16, simd_maxsz(desc));                             \
 }
 
-DO_REDUCE(sve_faddv_h, float16, H1_2, float16_add, float16_zero)
-DO_REDUCE(sve_faddv_s, float32, H1_4, float32_add, float32_zero)
-DO_REDUCE(sve_faddv_d, float64, H1_8, float64_add, float64_zero)
+DO_REDUCE(fadd,h, float16, H1_2, float16_add, float16_zero)
+DO_REDUCE(fadd,s, float32, H1_4, float32_add, float32_zero)
+DO_REDUCE(fadd,d, float64, H1_8, float64_add, float64_zero)
 
 /* Identity is floatN_default_nan, without the function call.  */
-DO_REDUCE(sve_fminnmv_h, float16, H1_2, float16_minnum, 0x7E00)
-DO_REDUCE(sve_fminnmv_s, float32, H1_4, float32_minnum, 0x7FC00000)
-DO_REDUCE(sve_fminnmv_d, float64, H1_8, float64_minnum, 0x7FF8000000000000ULL)
+DO_REDUCE(fminnm,h, float16, H1_2, float16_minnum, 0x7E00)
+DO_REDUCE(fminnm,s, float32, H1_4, float32_minnum, 0x7FC00000)
+DO_REDUCE(fminnm,d, float64, H1_8, float64_minnum, 0x7FF8000000000000ULL)
 
-DO_REDUCE(sve_fmaxnmv_h, float16, H1_2, float16_maxnum, 0x7E00)
-DO_REDUCE(sve_fmaxnmv_s, float32, H1_4, float32_maxnum, 0x7FC00000)
-DO_REDUCE(sve_fmaxnmv_d, float64, H1_8, float64_maxnum, 0x7FF8000000000000ULL)
+DO_REDUCE(fmaxnm,h, float16, H1_2, float16_maxnum, 0x7E00)
+DO_REDUCE(fmaxnm,s, float32, H1_4, float32_maxnum, 0x7FC00000)
+DO_REDUCE(fmaxnm,d, float64, H1_8, float64_maxnum, 0x7FF8000000000000ULL)
 
-DO_REDUCE(sve_fminv_h, float16, H1_2, float16_min, float16_infinity)
-DO_REDUCE(sve_fminv_s, float32, H1_4, float32_min, float32_infinity)
-DO_REDUCE(sve_fminv_d, float64, H1_8, float64_min, float64_infinity)
+DO_REDUCE(fmin,h, float16, H1_2, float16_min, float16_infinity)
+DO_REDUCE(fmin,s, float32, H1_4, float32_min, float32_infinity)
+DO_REDUCE(fmin,d, float64, H1_8, float64_min, float64_infinity)
 
-DO_REDUCE(sve_fmaxv_h, float16, H1_2, float16_max, float16_chs(float16_infinity))
-DO_REDUCE(sve_fmaxv_s, float32, H1_4, float32_max, float32_chs(float32_infinity))
-DO_REDUCE(sve_fmaxv_d, float64, H1_8, float64_max, float64_chs(float64_infinity))
+DO_REDUCE(fmax,h, float16, H1_2, float16_max, float16_chs(float16_infinity))
+DO_REDUCE(fmax,s, float32, H1_4, float32_max, float32_chs(float32_infinity))
+DO_REDUCE(fmax,d, float64, H1_8, float64_max, float64_chs(float64_infinity))
 
-DO_REDUCE(sve_ah_fminv_h, float16, H1_2, helper_vfp_ah_minh, float16_infinity)
-DO_REDUCE(sve_ah_fminv_s, float32, H1_4, helper_vfp_ah_mins, float32_infinity)
-DO_REDUCE(sve_ah_fminv_d, float64, H1_8, helper_vfp_ah_mind, float64_infinity)
+DO_REDUCE(ah_fmin,h, float16, H1_2, helper_vfp_ah_minh, float16_infinity)
+DO_REDUCE(ah_fmin,s, float32, H1_4, helper_vfp_ah_mins, float32_infinity)
+DO_REDUCE(ah_fmin,d, float64, H1_8, helper_vfp_ah_mind, float64_infinity)
 
-DO_REDUCE(sve_ah_fmaxv_h, float16, H1_2, helper_vfp_ah_maxh,
+DO_REDUCE(ah_fmax,h, float16, H1_2, helper_vfp_ah_maxh,
           float16_chs(float16_infinity))
-DO_REDUCE(sve_ah_fmaxv_s, float32, H1_4, helper_vfp_ah_maxs,
+DO_REDUCE(ah_fmax,s, float32, H1_4, helper_vfp_ah_maxs,
           float32_chs(float32_infinity))
-DO_REDUCE(sve_ah_fmaxv_d, float64, H1_8, helper_vfp_ah_maxd,
+DO_REDUCE(ah_fmax,d, float64, H1_8, helper_vfp_ah_maxd,
           float64_chs(float64_infinity))
 
 #undef DO_REDUCE
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 2114b2ecca..05c0fc948a 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -3743,6 +3743,54 @@ DO_VPZ_AH(FMAXV, fmaxv)
 
 #undef DO_VPZ
 
+static gen_helper_gvec_3_ptr * const faddqv_fns[4] = {
+    NULL,                       gen_helper_sve2p1_faddqv_h,
+    gen_helper_sve2p1_faddqv_s, gen_helper_sve2p1_faddqv_d,
+};
+TRANS_FEAT(FADDQV, aa64_sme2p1_or_sve2p1, gen_gvec_fpst_arg_zpz,
+           faddqv_fns[a->esz], a, 0,
+           a->esz == MO_16 ? FPST_A64_F16 : FPST_A64)
+
+static gen_helper_gvec_3_ptr * const fmaxnmqv_fns[4] = {
+    NULL,                         gen_helper_sve2p1_fmaxnmqv_h,
+    gen_helper_sve2p1_fmaxnmqv_s, gen_helper_sve2p1_fmaxnmqv_d,
+};
+TRANS_FEAT(FMAXNMQV, aa64_sme2p1_or_sve2p1, gen_gvec_fpst_arg_zpz,
+           fmaxnmqv_fns[a->esz], a, 0,
+           a->esz == MO_16 ? FPST_A64_F16 : FPST_A64)
+
+static gen_helper_gvec_3_ptr * const fminnmqv_fns[4] = {
+    NULL,                         gen_helper_sve2p1_fminnmqv_h,
+    gen_helper_sve2p1_fminnmqv_s, gen_helper_sve2p1_fminnmqv_d,
+};
+TRANS_FEAT(FMINNMQV, aa64_sme2p1_or_sve2p1, gen_gvec_fpst_arg_zpz,
+           fminnmqv_fns[a->esz], a, 0,
+           a->esz == MO_16 ? FPST_A64_F16 : FPST_A64)
+
+static gen_helper_gvec_3_ptr * const fmaxqv_fns[4] = {
+    NULL,                       gen_helper_sve2p1_fmaxqv_h,
+    gen_helper_sve2p1_fmaxqv_s, gen_helper_sve2p1_fmaxqv_d,
+};
+static gen_helper_gvec_3_ptr * const fmaxqv_ah_fns[4] = {
+    NULL,                          gen_helper_sve2p1_ah_fmaxqv_h,
+    gen_helper_sve2p1_ah_fmaxqv_s, gen_helper_sve2p1_ah_fmaxqv_d,
+};
+TRANS_FEAT(FMAXQV, aa64_sme2p1_or_sve2p1, gen_gvec_fpst_arg_zpz,
+           (s->fpcr_ah ? fmaxqv_fns : fmaxqv_ah_fns)[a->esz], a, 0,
+           a->esz == MO_16 ? FPST_A64_F16 : FPST_A64)
+
+static gen_helper_gvec_3_ptr * const fminqv_fns[4] = {
+    NULL,                       gen_helper_sve2p1_fminqv_h,
+    gen_helper_sve2p1_fminqv_s, gen_helper_sve2p1_fminqv_d,
+};
+static gen_helper_gvec_3_ptr * const fminqv_ah_fns[4] = {
+    NULL,                          gen_helper_sve2p1_ah_fminqv_h,
+    gen_helper_sve2p1_ah_fminqv_s, gen_helper_sve2p1_ah_fminqv_d,
+};
+TRANS_FEAT(FMINQV, aa64_sme2p1_or_sve2p1, gen_gvec_fpst_arg_zpz,
+           (s->fpcr_ah ? fminqv_fns : fminqv_ah_fns)[a->esz], a, 0,
+           a->esz == MO_16 ? FPST_A64_F16 : FPST_A64)
+
 /*
  *** SVE Floating Point Unary Operations - Unpredicated Group
  */
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index ff740f7b40..10cac2de22 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -1036,6 +1036,14 @@ FMINNMV         01100101 .. 000 101 001 ... ..... .....         @rd_pg_rn
 FMAXV           01100101 .. 000 110 001 ... ..... .....         @rd_pg_rn
 FMINV           01100101 .. 000 111 001 ... ..... .....         @rd_pg_rn
 
+### SVE FP recursive reduction (quadwords)
+
+FADDQV          01100100 .. 010 000 101 ... ..... .....         @rd_pg_rn
+FMAXNMQV        01100100 .. 010 100 101 ... ..... .....         @rd_pg_rn
+FMINNMQV        01100100 .. 010 101 101 ... ..... .....         @rd_pg_rn
+FMAXQV          01100100 .. 010 110 101 ... ..... .....         @rd_pg_rn
+FMINQV          01100100 .. 010 111 101 ... ..... .....         @rd_pg_rn
+
 ## SVE Floating Point Unary Operations - Unpredicated Group
 
 FRECPE          01100101 .. 001 110 001100 ..... .....          @rd_rn
-- 
2.43.0


