Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FF6BFF887E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 00:27:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIFE3-0007S3-Gt; Wed, 29 Apr 2026 20:25:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIFDm-0006UI-AO
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:25:40 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIFDg-0007UZ-Gc
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:25:35 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-c70f91776fcso111892a12.0
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 17:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777508730; x=1778113530; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wwuj7RFO6iW2sbU/01+pk0zCNXLlJYMOmYM21ng3kh4=;
 b=tfJ9SpDLZeWbs7Cl9fnKGWxyJ92K+gkbsDm2O+1pgDviWgtXTuhER9NxZtqABmQfUq
 1RL5ejYAkt6PWiRIjrTJAus7GC6ucqvDsHYZsIcfcHu7ymq8efpgRPT9n1MG849x36lz
 pv80o+ILITZA7/xfY7SnTw7a/0ZgZg0UEynAYlRHlezSQwplEAZyBZbjZXf0yLmueGAy
 iWE+b34NRoUyhYTm5mVfCfGdOxEUjZZ5QBzktc00lq8Vn/LGsYWgNM8kQjBWjmlml5qv
 wQtwtv0vuCNskaqRkMQmZ2FzDWTkjh3Vjc28e4ULkhYux/nLUOSwDNemudkCM8At4Ecw
 k3GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777508730; x=1778113530;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wwuj7RFO6iW2sbU/01+pk0zCNXLlJYMOmYM21ng3kh4=;
 b=siqnASLo3tdEL7wFHKgZqyvtIOb3j/qoFT6FeETgkZjP+cZOrgUipokRJdbdiByijH
 LefPCJKSk0Eo+KkHWxc/MQkcFYzi7m7Ic/ceCqEKEMJU9TcBg43P6wS5e1mJwSNYAbrC
 WEQVfB/vm2HPiNh0c6UBcXUKpBnWG5EueKcr6qCsXSzgJunckUFXo6RS6xOCYa1v55jR
 8SVwwSgZHtFX+rAqeNQDI21j2tG7154V2SZPfRpTOtZDdrDaL/N3RA5oP0WhnNZr7Mgv
 irIqBbi7jOYwK41iA93BQQkOI/0ujWMFQrtuatsSG5xEEPJvHK3QtIpfpkj+x/dluqQo
 6tEQ==
X-Gm-Message-State: AOJu0Yxf+5C2UIta50yWbaBTEQadYl6JCrpHs/Jp1h5sXt6Vo9WxnDz8
 /kZFACkdB1PBkHfxozxkA/2EnToJV1IDfLszhtbUzGtEkBQ+0hUTAszzIWdKBXXNy9Ob9JBShEt
 ZAH8kicc=
X-Gm-Gg: AeBDietIfnLdpyWJWLuNFZfDhu4sOjJ1EG2oN8cLQ8KudUAwmsI5NGIq7ZmxJ4UBmon
 8k/iBbc58wUD4cZem1O0xou0jUMLQ2dD8KxKu2lymsW7O2Z+61AuvKR82CwgGL2KL1y+rY969Lw
 jr5gZ4PPcCnKHgefOJZIjf13co/4b7Cvm7UX+hkgiKaSgRpTOINcTSAhIQohXN6AI8euOneDgYd
 d9tJNea9lbyypAttyTnwoxzJxgClIpEVkG8ZBjS/qFDrFVGUXbuR8yDfrmS+xkr5MAblX1MKsyF
 rEPgVnC/k6N/9YWVwiyuhLql63Zzb0OD4fc9C1DKLmLw4ejwktN4TtehDJQe3UTnCnHuT7iCrpy
 X3LFeVdmqfva6Jk8VMT+Q0uQ6tQMmCjuSt/Xv01TCGl0R0ZGlfZ0TIq/vNI3Kq6qbNe0Htpz54V
 9lGp7SKbbTSyrLzITLms1QTwvBxmi/ZZjocQ9sIuKn
X-Received: by 2002:a05:6a20:3d85:b0:3a2:d79c:415d with SMTP id
 adf61e73a8af0-3a3cf7c1c29mr719354637.30.1777508729658; 
 Wed, 29 Apr 2026 17:25:29 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c7fd64f21b4sm3204112a12.21.2026.04.29.17.25.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 17:25:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v3 43/47] target/arm: Implement FMLALB, FMLALT for AdvSIMD
Date: Thu, 30 Apr 2026 10:20:42 +1000
Message-ID: <20260430002046.59739-44-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430002046.59739-1-richard.henderson@linaro.org>
References: <20260430002046.59739-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
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
 target/arm/cpu-features.h        |   5 ++
 target/arm/tcg/helper-fp8-defs.h |   3 +
 target/arm/tcg/fp8_helper.c      | 105 +++++++++++++++++++++++++++++++
 target/arm/tcg/translate-a64.c   |  16 +++++
 target/arm/tcg/a64.decode        |   8 +++
 5 files changed, 137 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 535c1e4792..db31ac6b6b 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1576,6 +1576,11 @@ static inline bool isar_feature_aa64_f8cvt(const ARMISARegisters *id)
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
index f0f03298d1..4825316b3b 100644
--- a/target/arm/tcg/fp8_helper.c
+++ b/target/arm/tcg/fp8_helper.c
@@ -848,3 +848,108 @@ void HELPER(sme2_fcvtn_bs)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
 
     fp8_finish(env, &ctx);
 }
+
+static FloatParts64 unpack_fp8(uint8_t x, FPMRType type, float_status *s)
+{
+    switch (type) {
+    case OFP8_E5M2:
+        return float8_e5m2_unpack_canonical(x, s);
+    case OFP8_E4M3:
+        return float8_e4m3_unpack_canonical(x, s);
+    default:
+        return parts64_default_nan(s);
+    }
+}
+
+static void f8muladd(FloatParts64 *a, const FloatParts64 *b,
+                     const FloatParts64 *c, int scale, float_status *s)
+{
+    /*
+     * Because of default_nan_mode, NaNs need no special handling.
+     * We'll simply get the default NaN out at the end of the sequence.
+     */
+    *a = parts64_mul(a, b, s);
+    *a = parts64_scalbn(a, scale, s);
+    *a = parts64_addsub(a, c, s, false);
+}
+
+void HELPER(gvec_fmla_hb)(void *vd, void *vn, void *vm,
+                          CPUARMState *env, uint32_t desc)
+{
+    float_status stat = env->vfp.fp_status[FPST_A64];
+    bool high = extract32(desc, SIMD_DATA_SHIFT, 1);
+    size_t oprsz = simd_oprsz(desc);
+    size_t nelem = oprsz / 2;
+    uint8_t *n = vn;
+    uint8_t *m = vm;
+    float16 *d = vd;
+
+    uint64_t fpmr = env->vfp.fpmr;
+    FPMRType fmt_n = FIELD_EX64(fpmr, FPMR, F8S1);
+    FPMRType fmt_m = FIELD_EX64(fpmr, FPMR, F8S2);
+    int scale = -((fpmr >> R_FPMR_LSCALE_SHIFT) & 0xf);
+
+    set_flush_to_zero(0, &stat);
+    set_flush_inputs_to_zero(0, &stat);
+    set_default_nan_mode(true, &stat);
+    set_float_rounding_mode(FIELD_EX64(fpmr, FPMR, OSM)
+                            ? float_round_nearest_even_max
+                            : float_round_nearest_even, &stat);
+
+    for (size_t i = 0; i < nelem; i++) {
+        FloatParts64 p0 = unpack_fp8(n[H1(2 * i + high)], fmt_n, &stat);
+        FloatParts64 p1 = unpack_fp8(m[H1(2 * i + high)], fmt_m, &stat);
+        FloatParts64 p2 = float16_unpack_canonical(d[H2(i)], &stat);
+
+        f8muladd(&p0, &p1, &p2, scale, &stat);
+        d[H2(i)] = float16_round_pack_canonical(&p0, &stat);
+    }
+
+    float_raise(get_float_exception_flags(&stat)
+                & ~float_flag_input_denormal_used,
+                &env->vfp.fp_status[FPST_A64]);
+    clear_tail(vd, oprsz, simd_maxsz(desc));
+}
+
+void HELPER(gvec_fmla_idx_hb)(void *vd, void *vn, void *vm,
+                              CPUARMState *env, uint32_t desc)
+{
+    float_status stat = env->vfp.fp_status[FPST_A64];
+    bool idx_n = extract32(desc, SIMD_DATA_SHIFT, 1);
+    size_t idx_m = extract32(desc, SIMD_DATA_SHIFT + 2, 4);
+    size_t oprsz = simd_oprsz(desc);
+    size_t nelem = oprsz / 2;
+    uint8_t *n = vn;
+    uint8_t *m = vm;
+    float16 *d = vd;
+
+    uint64_t fpmr = env->vfp.fpmr;
+    FPMRType fmt_n = FIELD_EX64(fpmr, FPMR, F8S1);
+    FPMRType fmt_m = FIELD_EX64(fpmr, FPMR, F8S2);
+    int scale = -((fpmr >> R_FPMR_LSCALE_SHIFT) & 0xf);
+
+    set_flush_to_zero(0, &stat);
+    set_flush_inputs_to_zero(0, &stat);
+    set_default_nan_mode(true, &stat);
+    set_float_rounding_mode(FIELD_EX64(fpmr, FPMR, OSM)
+                            ? float_round_nearest_even_max
+                            : float_round_nearest_even, &stat);
+
+    for (size_t seg = 0; seg < nelem; seg += 8) {
+        FloatParts64 p1 = unpack_fp8(m[H1(2 * seg + idx_m)], fmt_m, &stat);
+
+        for (size_t j = 0; j < 8; j++) {
+            size_t i = seg + j;
+            FloatParts64 p0 = unpack_fp8(n[H1(2 * i + idx_n)], fmt_n, &stat);
+            FloatParts64 p2 = float16_unpack_canonical(d[H2(i)], &stat);
+
+            f8muladd(&p0, &p1, &p2, scale, &stat);
+            d[H2(i)] = float16_round_pack_canonical(&p0, &stat);
+        }
+    }
+
+    float_raise(get_float_exception_flags(&stat)
+                & ~float_flag_input_denormal_used,
+                &env->vfp.fp_status[FPST_A64]);
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


