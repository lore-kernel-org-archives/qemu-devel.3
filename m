Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DF91CD37A7
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 23:50:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL8S4-0007fG-T1; Thu, 07 May 2026 19:48:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL8Rq-0007DY-Eb
 for qemu-devel@nongnu.org; Thu, 07 May 2026 19:48:12 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL8Rm-000275-1d
 for qemu-devel@nongnu.org; Thu, 07 May 2026 19:48:04 -0400
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7de4e6c5a30so1480930a34.0
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 16:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778197679; x=1778802479; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qa3JUTgJ+zTJ/z0yT/ZA3kz1XHXqDnx6MW9r9Nwgmk8=;
 b=S0BJ/wd2U9lY4urxYzcH5KFmLc18hRYbT7ZizwC+7L7hc0HlUEKbouqHMz1de1sHUP
 G35DisQEUQwMi3LwtAW2AwLmXyJm6t3u52D9S8PkJfzH92PYgjSt1fSuHgrqn2kpEsCD
 G3Vtic47jwNzWe2tbCJ7egoDv0cGJwNTGi9hIXVY7GojObjMxn34oz+H7PPeWY0PEQXz
 +i92+Lj6ACmcuawYS6u50E7AsjsHSJuHIj69g78FjjyUsnfcbNz0shiy/JMhWYV1mGPC
 ksljcPzpSApCFlNoFNGZPTD92jk0SBv8COqF1wDp8ouub5rI+amO/PVcUTMLKBKt+pLP
 Fk6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778197679; x=1778802479;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qa3JUTgJ+zTJ/z0yT/ZA3kz1XHXqDnx6MW9r9Nwgmk8=;
 b=ahQ+4OU3AIBtjFqq5yxJ7ZnSaU0EOo2zKObkye1I/xdaf+KWaZ+TlodfnPe+8gjpMt
 oAORnPKx3hgGj7y2xQSO8oQA0znDo4gZ848hbuMbCxYOqylj5wtkZDv5x2EfrOJVYmxq
 js+EKK+xW0XBOTt7LignUUBThzIqIGwAlgHg/klwBik8SjDyIP0yeQa4MX2G0m8NBOH/
 v0NEs80uUMaq5ZpDQ7katYzSd5CF7+mZiom5FfF8myoQ1JV8Fk9nnlSw2vHc497yg/jJ
 pG3U+/7HKhe4qnnaW81KFGtNHy5s3TRdUitbze/iDAMoGHHkIw/zMrP7VL/J3wGa+Ibw
 b06w==
X-Gm-Message-State: AOJu0YzPU8xGzm9i+7IYQwVRJGEA1Fd0lRHaAkdPx+/kAyuIxIgFvgde
 Io17TMCqUdsRpS3bukRTQSDZnqns924K6GAVeobGeQAAP91D9wbggSD55Enazdw6zgi9UeV2zt8
 9C3wa
X-Gm-Gg: AeBDieteNCzeRs3+NkIB54OTi7jgvD/xAu3I4UfXxlg8Lz+Ohlzpw9oSYFEtq8D5Uir
 jbWaZ92ItXKM9wHeo/Vqt9cNe5fa9jTO71rCLgp5QMG24DOY7C45vYHtq1Hdg+eGfB531V7ktxS
 VPyEjsMN7NCBbVfJKR5HOfKHdAD4/XDWBnhyAfLDQnneXoEP+pySv+3pGAyS4ChaFHgkXIMk/Lj
 0jYRDR1NfBpyrrs1yZP+ugXt4N1wF35zibRUja6zSIfA2lsXolBIoSTdZrCzN+IHPAdJWIjrvG6
 /s4EXSh2C7tx6gpbZEZ+3Lg+HEMb0umFTSKtRQveGZyRQKkWP2VwLI8WU0O3b+WANZiJ6/HjyUX
 2UswtZ4ov9M73upbU+nnYlS8a/VRolNxrk28t9UIalQKOVOaKWYw6PXNL15/csj0n/ue3+8RGz7
 kqovqR61DaXnFzluuD6JVqkopmG/6/VovHJb1PmXRPzbuelg==
X-Received: by 2002:a05:6820:f007:b0:696:2430:3277 with SMTP id
 006d021491bc7-69998d0d93emr5506742eaf.29.1778197678947; 
 Thu, 07 May 2026 16:47:58 -0700 (PDT)
Received: from stoup.attlocal.net ([2600:381:c938:6375:9641:bbb2:a93a:bb4c])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4355736f517sm242730fac.12.2026.05.07.16.47.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 16:47:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v4 44/60] target/arm: Implement FMLALB, FMLALT for AdvSIMD
Date: Thu,  7 May 2026 18:43:57 -0500
Message-ID: <20260507234413.643512-45-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507234413.643512-1-richard.henderson@linaro.org>
References: <20260507234413.643512-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32c.google.com
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
 target/arm/cpu-features.h        |   5 ++
 target/arm/tcg/helper-fp8-defs.h |   3 +
 target/arm/tcg/fp8_helper.c      | 119 +++++++++++++++++++++++++++++--
 target/arm/tcg/translate-a64.c   |  16 +++++
 target/arm/tcg/a64.decode        |   8 +++
 5 files changed, 147 insertions(+), 4 deletions(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 1963392730..dcbd839d2d 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1584,6 +1584,11 @@ static inline bool isar_feature_aa64_f8cvt(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64FPFR0, F8CVT);
 }
 
+static inline bool isar_feature_aa64_f8fma(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64FPFR0, F8FMA);
+}
+
 /*
  * Combinations of feature tests, for ease of use with TRANS_FEAT.
  */
diff --git a/target/arm/tcg/helper-fp8-defs.h b/target/arm/tcg/helper-fp8-defs.h
index 36ae977431..7aa8366d94 100644
--- a/target/arm/tcg/helper-fp8-defs.h
+++ b/target/arm/tcg/helper-fp8-defs.h
@@ -23,3 +23,6 @@ DEF_HELPER_FLAGS_4(sve2_fcvtnb_bs, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_4(sve2_fcvtnt_bs, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_4(sme2_fcvt_bs, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_4(sme2_fcvtn_bs, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+
+DEF_HELPER_FLAGS_5(gvec_fmla_hb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_5(gvec_fmla_idx_hb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
diff --git a/target/arm/tcg/fp8_helper.c b/target/arm/tcg/fp8_helper.c
index d7c1ff97b7..6d9f8a6135 100644
--- a/target/arm/tcg/fp8_helper.c
+++ b/target/arm/tcg/fp8_helper.c
@@ -55,12 +55,15 @@ static FP8Context fp8_start(CPUARMState *env, uint32_t desc,
     return ret;
 }
 
+static void fp8_finish_fpst(float_status *orig, float_status *tmp)
+{
+    int e = get_float_exception_flags(tmp);
+    float_raise(e & ~float_flag_input_denormal_used, orig);
+}
+
 static void fp8_finish(CPUARMState *env, FP8Context *c)
 {
-    int new_flags = get_float_exception_flags(&c->stat);
-
-    new_flags &= ~float_flag_input_denormal_used;
-    float_raise(new_flags, &env->vfp.fp_status[c->fpst]);
+    fp8_finish_fpst(&env->vfp.fp_status[c->fpst], &c->stat);
 }
 
 static FP8Context fp8_src_start(CPUARMState *env, uint32_t desc, int scale_mask)
@@ -563,3 +566,111 @@ void HELPER(sme2_fcvtn_bs)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
 
     fp8_finish(env, &ctx);
 }
+
+typedef struct FP8MulContext {
+    float_status stat;
+    fp8_input_fn *fmt1;
+    fp8_input_fn *fmt2;
+    int scale;
+} FP8MulContext;
+
+static FP8MulContext fp8_mul_start(CPUARMState *env, int scale_mask)
+{
+    uint64_t fpmr = env->vfp.fpmr;
+
+    FP8MulContext ret = {
+        .stat = env->vfp.fp_status[FPST_A64],
+        .fmt1 = fp8_input_fmt[FIELD_EX64(fpmr, FPMR, F8S1)],
+        .fmt2 = fp8_input_fmt[FIELD_EX64(fpmr, FPMR, F8S2)],
+        .scale = -(FIELD_EX64(fpmr, FPMR, LSCALE) & scale_mask),
+    };
+
+    set_flush_to_zero(0, &ret.stat);
+    set_flush_inputs_to_zero(0, &ret.stat);
+    set_default_nan_mode(true, &ret.stat);
+    set_float_rounding_mode(FIELD_EX64(fpmr, FPMR, OSM)
+                            ? float_round_nearest_even_max
+                            : float_round_nearest_even, &ret.stat);
+
+    return ret;
+}
+
+static void fp8_mul_finish(CPUARMState *env, FP8MulContext *c)
+{
+    fp8_finish_fpst(&env->vfp.fp_status[FPST_A64], &c->stat);
+}
+
+static FloatParts64 f8dot(uint64_t a, uint64_t b, int n, FP8MulContext *ctx)
+{
+    /*
+     * Because of default_nan_mode, NaNs need no special handling.
+     * We'll simply get the default NaN out at the end of the sequence.
+     */
+    FloatParts64 p0 = ctx->fmt1(a & 0xff, &ctx->stat);
+    FloatParts64 p1 = ctx->fmt2(b & 0xff, &ctx->stat);
+    FloatParts64 pr = parts64_mul(&p0, &p1, &ctx->stat);
+
+    for (int i = 1; i < n; ++i) {
+        p0 = ctx->fmt1(extract64(a, i * 8, 8), &ctx->stat);
+        p1 = ctx->fmt2(extract64(b, i * 8, 8), &ctx->stat);
+        pr = parts64_muladd(&p0, &p1, &pr, 0, &ctx->stat);
+    }
+    return parts64_scalbn(&pr, ctx->scale, &ctx->stat);
+}
+
+static float16 f8dotadd_h(uint64_t a, uint64_t b, int n, float16 c,
+                          FP8MulContext *ctx)
+{
+    FloatParts64 p0 = f8dot(a, b, n, ctx);
+    FloatParts64 p1 = float16_unpack_canonical(c, &ctx->stat);
+
+    p0 = parts64_addsub(&p0, &p1, &ctx->stat, false);
+    return float16_round_pack_canonical(&p0, &ctx->stat);
+}
+
+void HELPER(gvec_fmla_hb)(void *vd, void *vn, void *vm,
+                          CPUARMState *env, uint32_t desc)
+{
+    FP8MulContext ctx = fp8_mul_start(env, 0xf);
+    bool high = extract32(desc, SIMD_DATA_SHIFT, 1);
+    size_t oprsz = simd_oprsz(desc);
+    size_t nelem = oprsz / 2;
+    uint8_t *n = vn;
+    uint8_t *m = vm;
+    float16 *d = vd;
+
+    for (size_t i = 0; i < nelem; i++) {
+        uint8_t e0 = n[H1(2 * i + high)];
+        uint8_t e1 = m[H1(2 * i + high)];
+
+        d[H2(i)] = f8dotadd_h(e0, e1, 1, d[H2(i)], &ctx);
+    }
+
+    fp8_mul_finish(env, &ctx);
+    clear_tail(vd, oprsz, simd_maxsz(desc));
+}
+
+void HELPER(gvec_fmla_idx_hb)(void *vd, void *vn, void *vm,
+                              CPUARMState *env, uint32_t desc)
+{
+    FP8MulContext ctx = fp8_mul_start(env, 0xf);
+    bool idx_n = extract32(desc, SIMD_DATA_SHIFT, 1);
+    size_t idx_m = extract32(desc, SIMD_DATA_SHIFT + 2, 4);
+    size_t oprsz = simd_oprsz(desc);
+    size_t nelem = oprsz / 2;
+    uint8_t *n = vn;
+    uint8_t *m = vm;
+    float16 *d = vd;
+    size_t i = 0;
+
+    do {
+        uint8_t e1 = m[2 * i + H1(idx_m)];
+        do {
+            uint8_t e0 = n[H1(2 * i + idx_n)];
+            d[H2(i)] = f8dotadd_h(e0, e1, 1, d[H2(i)], &ctx);
+        } while (++i % 8 != 0);
+    } while (i < nelem);
+
+    fp8_mul_finish(env, &ctx);
+    clear_tail(vd, oprsz, simd_maxsz(desc));
+}
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index ee71c63116..1c1d4ad2f7 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -7384,6 +7384,22 @@ TRANS_FEAT(FMLSL_vi, aa64_fhm, do_fmlal_idx, a, true, false)
 TRANS_FEAT(FMLAL2_vi, aa64_fhm, do_fmlal_idx, a, false, true)
 TRANS_FEAT(FMLSL2_vi, aa64_fhm, do_fmlal_idx, a, true, true)
 
+static bool do_fmla_fp8(DisasContext *s, arg_rxx *a,
+                        gen_helper_gvec_3_ptr *fn)
+{
+    if (fpmr_access_check(s) && fp_access_check(s)) {
+        tcg_gen_gvec_3_ptr(vec_full_reg_offset(s, a->rd),
+                           vec_full_reg_offset(s, a->rn),
+                           vec_full_reg_offset(s, a->rm),
+                           tcg_env, 16, vec_full_reg_size(s),
+                           a->idxn | (a->idxm << 2), fn);
+    }
+    return true;
+}
+
+TRANS_FEAT(FMLAL_hb_v, aa64_f8fma, do_fmla_fp8, a, gen_helper_gvec_fmla_hb)
+TRANS_FEAT(FMLAL_hb_vi, aa64_f8fma, do_fmla_fp8, a, gen_helper_gvec_fmla_idx_hb)
+
 static bool do_int3_vector_idx(DisasContext *s, arg_qrrx_e *a,
                                gen_helper_gvec_3 * const fns[2])
 {
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 6aea3ce89f..b89e83ce76 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -25,6 +25,7 @@
 %esz_hsd        22:2 !function=xor_2
 %hl             11:1 21:1
 %hlm            11:1 20:2
+%hlm4           11:1 19:3
 
 &r              rn
 &rrr            rd rn rm
@@ -38,6 +39,7 @@
 &rri_e          rd rn imm esz
 &rrr_e          rd rn rm esz
 &rrx_e          rd rn rm idx esz
+&rxx            rd rn rm idxn idxm
 &rrrr_e         rd rn rm ra esz
 &qrr_e          q rd rn esz
 &qrri_e         q rd rn imm esz
@@ -1204,6 +1206,9 @@ FSCALE          0.10 1110 1.1 ..... 11111 1 ..... ..... @qrrr_sd
 FCVTN_bh        0.00 1110 010 ..... 11110 1 ..... ..... @qrrr_h
 FCVTN_bs        0.00 1110 000 ..... 11110 1 ..... ..... @qrrr_h
 
+FMLAL_hb_v      0 idxn:1 00 1110 110 rm:5 11111 1 rn:5 rd:5 \
+                &rxx idxm=0
+
 ### Advanced SIMD scalar x indexed element
 
 FMUL_si         0101 1111 00 .. .... 1001 . 0 ..... .....   @rrx_h
@@ -1322,6 +1327,9 @@ SQDMLAL_vi      0.00 1111 10 . ..... 0011 . 0 ..... .....   @qrrx_s
 SQDMLSL_vi      0.00 1111 01 .. .... 0111 . 0 ..... .....   @qrrx_h
 SQDMLSL_vi      0.00 1111 10 . ..... 0111 . 0 ..... .....   @qrrx_s
 
+FMLAL_hb_vi     0 idxn:1 00 1111 11 ... rm:3 0000 . 0 rn:5 rd:5 \
+                &rxx idxm=%hlm4
+
 # Floating-point conditional select
 
 FCSEL           0001 1110 .. 1 rm:5 cond:4 11 rn:5 rd:5     esz=%esz_hsd
-- 
2.43.0


