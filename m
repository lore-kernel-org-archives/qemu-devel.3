Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87A0AE77188
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 20:18:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQBE8-00035Z-B4; Tue, 24 Dec 2024 15:10:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQBDd-0007My-64
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:09:29 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQBDb-000308-AN
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:09:28 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-21631789fcdso47000835ad.1
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 12:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735070966; x=1735675766; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dy+3YRybYCVi0eIJERcGpwApxyCnVCsmSJWB/vHW2XY=;
 b=NgTKV4knx93IpOboC1wfD3xgDIY27mRt9vFeqAfMatOPhyRjeMQ2WxOd4KbiWuRPV3
 YAO2dbCm9mXqQSAMXnrsKx8l+YPlUKLwHzp9yiLyJk1k84YNeZGQtXqaf+c53E6xzyO8
 cK+uEu+FMu7oDQT1t1zVxibuBNbT67RRhLrIxEUCFeY6tjdYo6J4oSK5yJyKc/26mTsI
 qE3u5wbT2u9hL3nvL6ZVJE0lJ8ckxuVBy6PTJI2qrXgOMAYKhET45V9Hx1SpfQZeVn7j
 e2R+BxdG+hF2bM3Ze3LdOMsFEZZ8naxBCtPvDtodS7FCgPNSiXDVzhvGHjX0btnSeSoZ
 m22Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735070966; x=1735675766;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dy+3YRybYCVi0eIJERcGpwApxyCnVCsmSJWB/vHW2XY=;
 b=oYQYdyeQEqqTerpNd8VGUwx296gTBhvccsOUKOZZyByc2Bgk6Q5VxJQVjJR1MXwt1j
 +sp+fYREQoWX9475pW/Swu/QE/G5sPZxgWm9ywHTxu0nTAqo21Y8DcHdlO9a4PdUrWhO
 Y5lZQ8Sa+9xdLBz6a4+YEb+HjvOs6pXH0QeVhPm1wuCXAtvG2Xk0Y6ZS/wrpw/+k3DrE
 Dr0n5yyirG6oO3K9Dv9V5lR9r55cTcsS1l0/vDDE3zr66PvCHVkaoc/Xu4R0x+OYHdPL
 nmeo6YXKPVTK+fWYf/NeOSwhyK6Afc7BMVziAALeKQtrJ+C31VQxQPZQC15C5ZGrj6rd
 4oxg==
X-Gm-Message-State: AOJu0YwqfzPrGThAGQTPj84MjH6tr0yMN6EW2lzAkDUK7tWxp7B0qrps
 cCmQzGz+Fv3eTjaZaRFtjOM1pa5BofZ9i+ml/sEHuhl5N+U62DZKSg4DzrEPh2amvxdttD6T/rM
 TLJU=
X-Gm-Gg: ASbGncu2jeb7OcvSdFl6BSJA3TQb01hg5ImrakFnXITe3BjE2A2IrOafapfkE7GB1W1
 2Kf+nQ/9eU2bdcanKgJwhUO044Pqp3WDHG2YJK2OfqjDOOw6ZVJrowzgsScfEBVx6tjmrs0TIuM
 jJDadhGBG3gmY8yvmrL+0o7EL3TRlHqfrnJ0/8qfhzbVgghBptjU9QhRqSzhtpPlY0ycqTwX+dk
 qnL1rLeXrFRpDKrYFUG/+CuzTxpEBaUX0CP6D5Ufiwt4qRumZTxDA1WcznDqLqJL1PWi375vvD1
 g4ZKjZBaEyXqs9VDKTbXjjmKEg==
X-Google-Smtp-Source: AGHT+IEw9hC0XBUPFtpYgT3ZANGWc/E/lW5OflDA+M4jKLCydW418qCwGvSuNjCKW3IPuSzGHws5Kw==
X-Received: by 2002:a05:6a21:3989:b0:1d9:a94:feec with SMTP id
 adf61e73a8af0-1e5e1e0460bmr29793862637.2.1735070965943; 
 Tue, 24 Dec 2024 12:09:25 -0800 (PST)
Received: from stoup.. (syn-156-019-246-023.biz.spectrum.com. [156.19.246.23])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8309acsm10033521b3a.45.2024.12.24.12.09.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Dec 2024 12:09:25 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PULL 66/72] target/hexagon: Remove internal_fmafx
Date: Tue, 24 Dec 2024 12:05:15 -0800
Message-ID: <20241224200521.310066-67-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241224200521.310066-1-richard.henderson@linaro.org>
References: <20241224200521.310066-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

The function is now unused.

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hexagon/fma_emu.h |   2 -
 target/hexagon/fma_emu.c | 171 ---------------------------------------
 2 files changed, 173 deletions(-)

diff --git a/target/hexagon/fma_emu.h b/target/hexagon/fma_emu.h
index ad5df5d038..fed054b609 100644
--- a/target/hexagon/fma_emu.h
+++ b/target/hexagon/fma_emu.h
@@ -30,8 +30,6 @@ static inline uint32_t float32_getexp_raw(float32 f32)
 }
 int32_t float32_getexp(float32 f32);
 float32 infinite_float32(uint8_t sign);
-float32 internal_fmafx(float32 a, float32 b, float32 c,
-                       int scale, float_status *fp_status);
 float64 internal_mpyhh(float64 a, float64 b,
                        unsigned long long int accumulated,
                        float_status *fp_status);
diff --git a/target/hexagon/fma_emu.c b/target/hexagon/fma_emu.c
index 35971b8b99..0c7c7f636c 100644
--- a/target/hexagon/fma_emu.c
+++ b/target/hexagon/fma_emu.c
@@ -90,21 +90,6 @@ int32_t float64_getexp(float64 f64)
     return -1;
 }
 
-static uint64_t float32_getmant(float32 f32)
-{
-    Float a = { .i = f32 };
-    if (float32_is_normal(f32)) {
-        return a.mant | 1ULL << 23;
-    }
-    if (float32_is_zero(f32)) {
-        return 0;
-    }
-    if (float32_is_denormal(f32)) {
-        return a.mant;
-    }
-    return ~0ULL;
-}
-
 int32_t float32_getexp(float32 f32)
 {
     Float a = { .i = f32 };
@@ -369,25 +354,6 @@ float32 infinite_float32(uint8_t sign)
 }
 
 /* Return a maximum finite value with the requested sign */
-static float32 maxfinite_float32(uint8_t sign)
-{
-    if (sign) {
-        return make_float32(SF_MINUS_MAXF);
-    } else {
-        return make_float32(SF_MAXF);
-    }
-}
-
-/* Return a zero value with requested sign */
-static float32 zero_float32(uint8_t sign)
-{
-    if (sign) {
-        return make_float32(0x80000000);
-    } else {
-        return float32_zero;
-    }
-}
-
 #define GEN_XF_ROUND(SUFFIX, MANTBITS, INF_EXP, INTERNAL_TYPE) \
 static SUFFIX accum_round_##SUFFIX(Accum a, float_status * fp_status) \
 { \
@@ -517,143 +483,6 @@ static SUFFIX accum_round_##SUFFIX(Accum a, float_status * fp_status) \
 }
 
 GEN_XF_ROUND(float64, DF_MANTBITS, DF_INF_EXP, Double)
-GEN_XF_ROUND(float32, SF_MANTBITS, SF_INF_EXP, Float)
-
-static bool is_inf_prod(float64 a, float64 b)
-{
-    return ((float64_is_infinity(a) && float64_is_infinity(b)) ||
-            (float64_is_infinity(a) && is_finite(b) && (!float64_is_zero(b))) ||
-            (float64_is_infinity(b) && is_finite(a) && (!float64_is_zero(a))));
-}
-
-static float64 special_fma(float64 a, float64 b, float64 c,
-                           float_status *fp_status)
-{
-    float64 ret = make_float64(0);
-
-    /*
-     * If A multiplied by B is an exact infinity and C is also an infinity
-     * but with the opposite sign, FMA returns NaN and raises invalid.
-     */
-    uint8_t a_sign = float64_is_neg(a);
-    uint8_t b_sign = float64_is_neg(b);
-    uint8_t c_sign = float64_is_neg(c);
-    if (is_inf_prod(a, b) && float64_is_infinity(c)) {
-        if ((a_sign ^ b_sign) != c_sign) {
-            ret = make_float64(DF_NAN);
-            float_raise(float_flag_invalid, fp_status);
-            return ret;
-        }
-    }
-    if ((float64_is_infinity(a) && float64_is_zero(b)) ||
-        (float64_is_zero(a) && float64_is_infinity(b))) {
-        ret = make_float64(DF_NAN);
-        float_raise(float_flag_invalid, fp_status);
-        return ret;
-    }
-    /*
-     * If none of the above checks are true and C is a NaN,
-     * a NaN shall be returned
-     * If A or B are NaN, a NAN shall be returned.
-     */
-    if (float64_is_any_nan(a) ||
-        float64_is_any_nan(b) ||
-        float64_is_any_nan(c)) {
-        if (float64_is_any_nan(a) && (fGETBIT(51, a) == 0)) {
-            float_raise(float_flag_invalid, fp_status);
-        }
-        if (float64_is_any_nan(b) && (fGETBIT(51, b) == 0)) {
-            float_raise(float_flag_invalid, fp_status);
-        }
-        if (float64_is_any_nan(c) && (fGETBIT(51, c) == 0)) {
-            float_raise(float_flag_invalid, fp_status);
-        }
-        ret = make_float64(DF_NAN);
-        return ret;
-    }
-    /*
-     * We have checked for adding opposite-signed infinities.
-     * Other infinities return infinity with the correct sign
-     */
-    if (float64_is_infinity(c)) {
-        ret = infinite_float64(c_sign);
-        return ret;
-    }
-    if (float64_is_infinity(a) || float64_is_infinity(b)) {
-        ret = infinite_float64(a_sign ^ b_sign);
-        return ret;
-    }
-    g_assert_not_reached();
-}
-
-static float32 special_fmaf(float32 a, float32 b, float32 c,
-                            float_status *fp_status)
-{
-    float64 aa, bb, cc;
-    aa = float32_to_float64(a, fp_status);
-    bb = float32_to_float64(b, fp_status);
-    cc = float32_to_float64(c, fp_status);
-    return float64_to_float32(special_fma(aa, bb, cc, fp_status), fp_status);
-}
-
-float32 internal_fmafx(float32 a, float32 b, float32 c, int scale,
-                       float_status *fp_status)
-{
-    Accum prod;
-    Accum acc;
-    Accum result;
-    accum_init(&prod);
-    accum_init(&acc);
-    accum_init(&result);
-
-    uint8_t a_sign = float32_is_neg(a);
-    uint8_t b_sign = float32_is_neg(b);
-    uint8_t c_sign = float32_is_neg(c);
-    if (float32_is_infinity(a) ||
-        float32_is_infinity(b) ||
-        float32_is_infinity(c)) {
-        return special_fmaf(a, b, c, fp_status);
-    }
-    if (float32_is_any_nan(a) ||
-        float32_is_any_nan(b) ||
-        float32_is_any_nan(c)) {
-        return special_fmaf(a, b, c, fp_status);
-    }
-    if ((scale == 0) && (float32_is_zero(a) || float32_is_zero(b))) {
-        float32 tmp = float32_mul(a, b, fp_status);
-        tmp = float32_add(tmp, c, fp_status);
-        return tmp;
-    }
-
-    /* (a * 2**b) * (c * 2**d) == a*c * 2**(b+d) */
-    prod.mant = int128_mul_6464(float32_getmant(a), float32_getmant(b));
-
-    /*
-     * Note: extracting the mantissa into an int is multiplying by
-     * 2**23, so adjust here
-     */
-    prod.exp = float32_getexp(a) + float32_getexp(b) - SF_BIAS - 23;
-    prod.sign = a_sign ^ b_sign;
-    if (float32_is_zero(a) || float32_is_zero(b)) {
-        prod.exp = -2 * WAY_BIG_EXP;
-    }
-    if ((scale > 0) && float32_is_denormal(c)) {
-        acc.mant = int128_mul_6464(0, 0);
-        acc.exp = -WAY_BIG_EXP;
-        acc.sign = c_sign;
-        acc.sticky = 1;
-        result = accum_add(prod, acc);
-    } else if (!float32_is_zero(c)) {
-        acc.mant = int128_mul_6464(float32_getmant(c), 1);
-        acc.exp = float32_getexp(c);
-        acc.sign = c_sign;
-        result = accum_add(prod, acc);
-    } else {
-        result = prod;
-    }
-    result.exp += scale;
-    return accum_round_float32(result, fp_status);
-}
 
 float64 internal_mpyhh(float64 a, float64 b,
                       unsigned long long int accumulated,
-- 
2.43.0


