Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E1E6CD6E56
	for <qemu-devel@archiver.kernel.org>; Sat, 30 May 2026 23:21:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTSrV-0000MI-76; Sat, 30 May 2026 19:13:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wTSrT-0000JQ-87
 for qemu-devel@nongnu.org; Sat, 30 May 2026 19:12:59 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wTSrR-0007Zp-7e
 for qemu-devel@nongnu.org; Sat, 30 May 2026 19:12:58 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-c85825bbc4fso734258a12.2
 for <qemu-devel@nongnu.org>; Sat, 30 May 2026 16:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780182776; x=1780787576; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+2psiSSYARAcxsnZrwAZHdMF4Y31rQj+nBCOiIH6imc=;
 b=i9p1DZPDsUpVQCaeVTYeCfENaMNwlt1Ov9KixAoaKdIjG5HT6mI0etYZrJDqcLeTmU
 Vt1a+9AtM0lVTxjzCZqS9R0a0/Ntw2c/3DbQ+ndMJhzaPuvkgaOk9vK4v6XaQBzvR58V
 F0cE9n1GIZ0c7BcszzVuix0oFKX7qR5Kr9/8/dp7WqhziuBPFCizBZ9TXMH5/VllXhdz
 iY3m4aLPXFevq54nhdKlBmF/xwQYYEg0UrweoPTlIS5XTsUudS/cp3QcZRE1fpk8Ciz4
 T5cp2ZF1pSsrvcdYB8ZyF5tqFGzAlFzGtFNA0yLmo7UW7EkmyA12vGXIFo4IFCNFpsi5
 P4LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780182776; x=1780787576;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+2psiSSYARAcxsnZrwAZHdMF4Y31rQj+nBCOiIH6imc=;
 b=VpDOg6CMCm4htvboFriYEmNm5g4DaetRBigDoPv1ijSDU0QVfWmrkPmxptufV1Ypic
 TW12BHHjdbDzbIatrwB6KiwFu2/xBIfFyVNTX4t2USv53ep2BNY649d0fFdPVDBpC9Lb
 PO9oqvSha5YHlUWW18exbiiJ8WGxq5KDEV4Q3+2DCyiw8KL5CbmH3uiSwDGpJtWjOYdj
 VzIxnLdrdwPd0m+KTxO/V61vv2RCQaoJRyMFhHPY56G9ZIUeG+aFVDZMII9b2Y8EN3h2
 UhexUfMIpH0ax1xcYwd1396ymS9FDIeNuMpr0t9lfpdBccnp/YyCe0Jg+j0J2lHcPjSV
 WsKQ==
X-Gm-Message-State: AOJu0YxpZJjI9gVb42G/W5V1Fl8jd1freZCMcc641dT+uEwdaM28GWQ3
 3C/oODMxTGkiRJCa6UmtYkH/1YaTjWqbO0fuMkNvzVlvmnD+/2+zsqa/x/MgmEYOlcVCwzccByK
 LEqkC994=
X-Gm-Gg: Acq92OELYhUkX6hxwInpUzbxxauPBilbrmHHPPwY9VXJFvgw8iD4dryuG6Gs1PyG1iq
 ufOuVtgpUhXOOhiDJ4ANKVfE7BBxSFY4NkS6UClZX12tfblAgCwtvu+dC7yM9dX0WWP0yrNWL7N
 96pFe/kYxOWuXiPB1Gw24xRSD3loPabgG+wtsINYLh55wfAR3jIFxxvecT6e4NQ6vskesp1TVyY
 XjbZ/3Yj0N+CPQY7hucppQNAGwirOGEmLOr2pYoherZguef/KtG5JZIkUSEpENZHDqCppn+Ms/s
 GBzNfUwf78cv7fCwljJDA7witxK+xX9mKN/7nq3uHOyc9DUIT2DiuVXISsMYI/e8coK8VP6kI2H
 2cH7sHDebKp/JptNRs1L7jWke709nVa5FKxEXjGNJNbGgV2/INU8epq+oat1Rc/KgLv+59J9aPM
 spuXFnRQKxHJ760Tpz9jelxoF3slk1sl6kKlBAtJY=
X-Received: by 2002:a05:6a20:6f0e:b0:39f:a42:9247 with SMTP id
 adf61e73a8af0-3b4281db00bmr5413840637.37.1780182775571; 
 Sat, 30 May 2026 16:12:55 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c857729d3d1sm5634356a12.21.2026.05.30.16.12.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 May 2026 16:12:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v8 25/41] target/arm: Implement FMLALB, FMLALT for AdvSIMD
Date: Sat, 30 May 2026 16:12:13 -0700
Message-ID: <20260530231229.400441-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260530231229.400441-1-richard.henderson@linaro.org>
References: <20260530231229.400441-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
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
 target/arm/tcg/fp8_helper.c      | 105 +++++++++++++++++++++++++++++++
 target/arm/tcg/translate-a64.c   |  16 +++++
 target/arm/tcg/a64.decode        |   8 +++
 5 files changed, 137 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index b3ff825488..418abf33ab 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1600,6 +1600,11 @@ static inline bool isar_feature_aa64_f8cvt(const ARMISARegisters *id)
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
index a39dc6f859..316e151817 100644
--- a/target/arm/tcg/fp8_helper.c
+++ b/target/arm/tcg/fp8_helper.c
@@ -568,3 +568,108 @@ void HELPER(sme2_fcvtn_bs)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
 
     fp8_cvt_finish(env, &ctx);
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
+    /*
+     * FP8 multiplies don't update FPSR.{IDC,IOC,IXC,UFC}.
+     * Since this is multiply-add, DZC does not apply and only OFC remains.
+     */
+    return ret;
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
+    clear_tail(vd, oprsz, simd_maxsz(desc));
+}
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index d6466de03f..4abf75531f 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -7467,6 +7467,22 @@ TRANS_FEAT(FMLSL_vi, aa64_fhm, do_fmlal_idx, a, true, false)
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
index 2d06f14e1d..715d5f05d8 100644
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
@@ -1215,6 +1217,9 @@ FSCALE          0.10 1110 1.1 ..... 11111 1 ..... ..... @qrrr_sd
 FCVTN_bh        0.00 1110 010 ..... 11110 1 ..... ..... @qrrr_h
 FCVTN_bs        0.00 1110 000 ..... 11110 1 ..... ..... @qrrr_h
 
+FMLAL_hb_v      0 idxn:1 00 1110 110 rm:5 11111 1 rn:5 rd:5 \
+                &rxx idxm=0
+
 ### Advanced SIMD scalar x indexed element
 
 FMUL_si         0101 1111 00 .. .... 1001 . 0 ..... .....   @rrx_h
@@ -1333,6 +1338,9 @@ SQDMLAL_vi      0.00 1111 10 . ..... 0011 . 0 ..... .....   @qrrx_s
 SQDMLSL_vi      0.00 1111 01 .. .... 0111 . 0 ..... .....   @qrrx_h
 SQDMLSL_vi      0.00 1111 10 . ..... 0111 . 0 ..... .....   @qrrx_s
 
+FMLAL_hb_vi     0 idxn:1 00 1111 11 ... rm:3 0000 . 0 rn:5 rd:5 \
+                &rxx idxm=%hlm4
+
 # Floating-point conditional select
 
 FCSEL           0001 1110 .. 1 rm:5 cond:4 11 rn:5 rd:5     esz=%esz_hsd
-- 
2.43.0


