Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8C29FB44AA
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 04:31:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wG8Bn-0005mK-EJ; Fri, 24 Apr 2026 00:30:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wG8Bl-0005jD-Id
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 00:30:49 -0400
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wG8Be-0002X3-In
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 00:30:49 -0400
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-479aa2dbea2so2684563b6e.0
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 21:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777005034; x=1777609834; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6OzjXNOF7e7PmI7VGG8IHz+TjPiZxP/MOw4JYvUhc3E=;
 b=nZVy2xroJiw8JJMeZRm3PE1+PyNkyXG2wtvPMLR1c32t39YPPsXujnMn5GJH2Z74+z
 g3546b1RWav0KPAA7YTw0zr153kBgF4l37OBOSTrkSCzjqvsomHpAfCmWTOhPKbPIvW7
 9vnd+mYpjWNgb2KfM/2mgqmUwXYVgr1pxLGfWavL1lIq3433i0veaCaQgkvXQSAPpzFm
 mzM0NE/Vtiy6BKoAQ1rKBQRh95kx4vODbdx6V9TKmdvnIE03ABTHaCCFFvu4nSkASzN7
 FHHQhcW0kYRc+gRobAt2WRo3BcynVFyygz92OJEy4veCVv9i503SScj9QHLgs0xHXgHO
 jheA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777005034; x=1777609834;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6OzjXNOF7e7PmI7VGG8IHz+TjPiZxP/MOw4JYvUhc3E=;
 b=MTD/kVZbvEVPFPs284syqhhnMxHZdv0VWUm1XLnMwZpRLyotCuzpiEII4CzTdYFmm/
 tfAP3H03KERe5/yCd415JN7nu2399fMOdHjYHkPMoxknYo2/ia97Eh3A3qCdMhk5VGfr
 uwh7kbIt3nZVZZ6Yc9N1NmHJqrVHm70MKOfS9QowUdCyYHsCzm3T2/xXvqCEgHjM9B1o
 WycPHoui4ILV67hQW5o+Ggdj41uvF6mZDYLpqRHBia4Sz0ttxLNLehcg9/g5MSGotF5k
 nyS8c74HlmGq9xZKZz8CX5j4HkCqXJNECYGkGyIg/h+G3fq4ziP4c3bnQC538jA55y9u
 6lDA==
X-Gm-Message-State: AOJu0YztiFBKL1MEmj4JHN5cetgQcMxVBxMsF43mH6WHaKziCxwuDHGz
 FnaHT+gShuwdePgOjEsbwiPAbcw6DS9AhPOlI/urhRirNn9rMqTccg3XlZw+FvLAF0jv062dRGe
 flXC+lxw=
X-Gm-Gg: AeBDietr6yQ46p1xrPHWFl4vZx2vn1E8B9RxgEb13/OZYxMsxFER5gRDqGxP4yaBEcW
 Yiclro782lxXdTOa3nT50iaSatkrkriZZPmnpIt2dusbbkavigIle2ucm9qxeCur31GNHUx0TF2
 EQWds/rMd/l+ErYj9lnanu//ZKc1Gr9PEGJY3OQwnR8Uecz06VIl9CLWzJxcMnARsLdpDe/+098
 B96rVLoHRBgQtNvbs2NobH7aFfQtrNOXnartd/IKq9gazw5X1Quw2fjF1NVR1S56b8iiJIMXFhg
 n03XyCHkJzRiv/RcjCyLfiaGPjmAroPJbB+dJCOEqCHlJsjVC4wug4YmwL0Zi1RQp6o81KhpzvW
 yEtqtpRSkwGEsDznXGSfmZMab0ua2AiWRUhbIAzsZQ9OV1lbPm3EgoOKo6KcfPlUw4svNmkIn1M
 A1+262XOTiVkrG+k9gz1VmpENcbuIOjWAwLih9+IfLlNq5bG4ZzXy4WVq76dhbQQ==
X-Received: by 2002:a05:6870:b48c:b0:41b:f7f5:e887 with SMTP id
 586e51a60fabf-42aded12d93mr17655365fac.24.1777005034071; 
 Thu, 23 Apr 2026 21:30:34 -0700 (PDT)
Received: from stoup.. ([172.58.183.19]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42b9ac54ec5sm18880864fac.13.2026.04.23.21.30.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 21:30:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 02/40] target/arm: Implement FEAT_FAMINMAX for AdvSIMD
Date: Fri, 24 Apr 2026 14:29:36 +1000
Message-ID: <20260424043014.46305-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260424043014.46305-1-richard.henderson@linaro.org>
References: <20260424043014.46305-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::231;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x231.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
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
 target/arm/cpu-features.h        |  5 +++++
 target/arm/tcg/helper-a64-defs.h |  7 +++++++
 target/arm/tcg/vec_internal.h    |  7 +++++++
 target/arm/tcg/translate-a64.c   | 14 +++++++++++++
 target/arm/tcg/vec_helper64.c    | 35 ++++++++++++++++++++++++++++++++
 target/arm/tcg/a64.decode        |  5 +++++
 6 files changed, 73 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index b165fe0b1a..7c96b26788 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1053,6 +1053,11 @@ static inline bool isar_feature_aa64_ats1a(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64ISAR2, ATS1A);
 }
 
+static inline bool isar_feature_aa64_faminmax(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64ISAR3, FAMINMAX) != 0;
+}
+
 static inline bool isar_feature_aa64_fp_simd(const ARMISARegisters *id)
 {
     /* We always set the AdvSIMD and FP fields identically.  */
diff --git a/target/arm/tcg/helper-a64-defs.h b/target/arm/tcg/helper-a64-defs.h
index b6008b5a3a..eb270cf58b 100644
--- a/target/arm/tcg/helper-a64-defs.h
+++ b/target/arm/tcg/helper-a64-defs.h
@@ -145,6 +145,13 @@ DEF_HELPER_FLAGS_5(gvec_fmulx_idx_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst,
 DEF_HELPER_FLAGS_5(gvec_fmulx_idx_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_fmulx_idx_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 
+DEF_HELPER_FLAGS_5(gvec_famax_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_famin_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_famax_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_famin_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_famax_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_famin_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_2(exception_return, void, env, i64)
 #endif
diff --git a/target/arm/tcg/vec_internal.h b/target/arm/tcg/vec_internal.h
index 4edd2b4fc1..5c3f51eed3 100644
--- a/target/arm/tcg/vec_internal.h
+++ b/target/arm/tcg/vec_internal.h
@@ -342,6 +342,13 @@ bfloat16 helper_sme2_ah_fmin_b16(bfloat16 a, bfloat16 b, float_status *fpst);
 float32 sve_f16_to_f32(float16 f, float_status *fpst);
 float16 sve_f32_to_f16(float32 f, float_status *fpst);
 
+float16 float16_famax(float16, float16, float_status *);
+float16 float16_famin(float16, float16, float_status *);
+float32 float32_famax(float32, float32, float_status *);
+float32 float32_famin(float32, float32, float_status *);
+float64 float64_famax(float64, float64, float_status *);
+float64 float64_famin(float64, float64, float_status *);
+
 /*
  * Decode helper functions for predicate as counter.
  */
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 5d261a5e32..9f375b05ca 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -6477,6 +6477,20 @@ static gen_helper_gvec_3_ptr * const f_vector_fminnmp[3] = {
 };
 TRANS(FMINNMP_v, do_fp3_vector, a, 0, f_vector_fminnmp)
 
+static gen_helper_gvec_3_ptr * const f_vector_famax[3] = {
+    gen_helper_gvec_famax_h,
+    gen_helper_gvec_famax_s,
+    gen_helper_gvec_famax_d,
+};
+TRANS_FEAT(FAMAX, aa64_faminmax, do_fp3_vector, a, 0, f_vector_famax)
+
+static gen_helper_gvec_3_ptr * const f_vector_famin[3] = {
+    gen_helper_gvec_famin_h,
+    gen_helper_gvec_famin_s,
+    gen_helper_gvec_famin_d,
+};
+TRANS_FEAT(FAMIN, aa64_faminmax, do_fp3_vector, a, 0, f_vector_famin)
+
 static bool do_fmlal(DisasContext *s, arg_qrrr_e *a, bool is_s, bool is_2)
 {
     if (fp_access_check(s)) {
diff --git a/target/arm/tcg/vec_helper64.c b/target/arm/tcg/vec_helper64.c
index 249a257177..b5ad67b5e0 100644
--- a/target/arm/tcg/vec_helper64.c
+++ b/target/arm/tcg/vec_helper64.c
@@ -140,3 +140,38 @@ void HELPER(simd_tblx)(void *vd, void *vm, CPUARMState *env, uint32_t desc)
     memcpy(vd, &result, 16);
     clear_tail(vd, oprsz, simd_maxsz(desc));
 }
+
+#define DO_FAMINMAX(NAME, TYPE, FN)                             \
+TYPE TYPE##_##NAME(TYPE a, TYPE b, float_status *s)             \
+{                                                               \
+    bool save_fz = get_flush_to_zero(s);                        \
+    bool save_fiz = get_flush_inputs_to_zero(s);                \
+    int new_flags, save_flags = get_float_exception_flags(s);   \
+                                                                \
+    set_flush_to_zero(0, s);                                    \
+    set_flush_inputs_to_zero(0, s);                             \
+    TYPE r = TYPE##_##FN(TYPE##_abs(a), TYPE##_abs(b), s);      \
+                                                                \
+    set_flush_to_zero(save_fz, s);                              \
+    set_flush_inputs_to_zero(save_fiz, s);                      \
+    new_flags = get_float_exception_flags(s);                   \
+    new_flags = (save_flags & float_flag_input_denormal_used)   \
+              | (new_flags & ~float_flag_input_denormal_used);  \
+    set_float_exception_flags(new_flags, s);                    \
+                                                                \
+    return r;                                                   \
+}
+
+DO_FAMINMAX(famax, float16, max)
+DO_FAMINMAX(famin, float16, min)
+DO_FAMINMAX(famax, float32, max)
+DO_FAMINMAX(famin, float32, min)
+DO_FAMINMAX(famax, float64, max)
+DO_FAMINMAX(famin, float64, min)
+
+DO_3OP(gvec_famax_h, float16_famax, float16)
+DO_3OP(gvec_famin_h, float16_famin, float16)
+DO_3OP(gvec_famax_s, float32_famax, float32)
+DO_3OP(gvec_famin_s, float32_famin, float32)
+DO_3OP(gvec_famax_d, float64_famax, float64)
+DO_3OP(gvec_famin_d, float64_famin, float64)
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 01b1b3e38b..666a293540 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1193,6 +1193,11 @@ RSUBHN          0.10 1110 ..1 ..... 01100 0 ..... ..... @qrrr_e
 PMULL_p8        0.00 1110 001 ..... 11100 0 ..... ..... @qrrr_b
 PMULL_p64       0.00 1110 111 ..... 11100 0 ..... ..... @qrrr_b
 
+FAMAX           0.00 1110 110 ..... 00011 1 ..... ..... @qrrr_h
+FAMAX           0.00 1110 1.1 ..... 11011 1 ..... ..... @qrrr_sd
+FAMIN           0.10 1110 110 ..... 00011 1 ..... ..... @qrrr_h
+FAMIN           0.10 1110 1.1 ..... 11011 1 ..... ..... @qrrr_sd
+
 ### Advanced SIMD scalar x indexed element
 
 FMUL_si         0101 1111 00 .. .... 1001 . 0 ..... .....   @rrx_h
-- 
2.43.0


