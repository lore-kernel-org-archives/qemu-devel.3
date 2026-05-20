Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AF30CD4F3D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 17:26:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPkZ6-0001Q7-4X; Wed, 20 May 2026 13:18:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPkZ3-0001Ol-9t
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:18:38 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPkYz-0001wD-Ux
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:18:36 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-366139223e4so2967343a91.0
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 10:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779297512; x=1779902312; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cF7LgAgCa0OgQz/V+tfN/kuTyTf193rYcF24jrbF7ms=;
 b=m4YU7yhyHq0pKidsR4Scn1fcOjIitjq18kjpeLw3Pt4mu174kvvyamd/VQqtm+VLm1
 nOwUM6AoxGeKsG8D29WMHmK40TJCnD2+0haf8nQ5519Tsrg2bOuLmdBgy3JXZ8fwFU1H
 0i2IbtuVFTTe6ZQuCdIVDhyKoeZl+eOtxF6lrml1Pu7q8EHg/e2o02g09sm26qbs8a0K
 LMRJPOcWLUfw2lI09PLeh1YANO23oq77ZI3S2FiZBMU5hzhC0WF48FRuJpSIuJoSAs5n
 FJVJaSH/uTOkw9Q08Os+BIIU7oKhFVQIJrEFr6PbTCHntipzK1HvcxldVAdgrumUQKiK
 kJ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779297512; x=1779902312;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cF7LgAgCa0OgQz/V+tfN/kuTyTf193rYcF24jrbF7ms=;
 b=I4SfhIMTje9dSnk90ddb+3Z33VvcP+3wRQcQ/Mov6+cw5c8EwWrNd9NEANa4Lfiqi2
 INQuGrY55LKBdcScg5qYdIfjyi4svNe8Gj9g5EG+5sNTpst7LG1L491fosL2y7kKUk+x
 OAHlWhCE5U43o8TvwTfpBWdMMiOuJd2A9PnKFo5gHycgA1M58tTBdm93bYXP793RMkvK
 xX3qgIX+W9Bw6ZiskfqRUebm8McX+GpteITGYYMNwi1imdbkGlFvlXIt9CUcK40YHGqt
 O1tkbeIaBHVAlHLsI2Azqgy31ZIGW+yeHdDzHkYWqaP89ZJjpW6LuugLy5mXtLuV2FsP
 onww==
X-Gm-Message-State: AOJu0Yz1Y0KK1JD8RpZtSTUH/BgvNWMF+dcM2MQpAn5d18OEfH/ZzVNC
 Ch5cnxCUPuqqYvEHNS/rhE7YZgnd8VLh2ycS3+LsGhEXfTpZ2Z912vs/YngMaCmGlW0WE0rbJ9Q
 HIkwzYjs=
X-Gm-Gg: Acq92OGWn0NemmOlWNCmNZS5fkre6sUO+mqSeTek8SuKeQvIbzKk2kp8lI3kJHs3uVY
 I0sW1/kV54IfBnfAhU55gzToT1kuBE7cWpX40Kq4qxozxLQbuH3OFuqi1StsUOPiO/he9KTSQeJ
 m+EnpVCYqrkDYI6HlKOExXpTIqiuHfKx3EnJ5ICoqASgn8H/mTI8PVvqU+LjkXZ8uQk5tLumesS
 tyb5YuMctnxNsfm1U5h2EiOj84xUxPXGCB10gXe8Au0pnc/jkRU1ePBlCc8sP/YSjF3mTiQnizU
 5mQsPg8NqNtm4y9FOA6RyAFu7bbtxSUAuK+I+u4CJBqwEyWvOAvOUwIEQIO4534z4/YwlRV0l8f
 /7OTC1N1snvUxQ6TxA4jvE5U4U1+H65sYtztR7VO6X2csKVzm1tq/iW6XvCPtCVnNKV0JvKhBhi
 wWfEp5WsKoZk02w/TySt0aFAZs8yri
X-Received: by 2002:a17:90b:57ee:b0:368:147b:536a with SMTP id
 98e67ed59e1d1-36951b97c8cmr26363833a91.14.1779297511478; 
 Wed, 20 May 2026 10:18:31 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a3c83f226sm254416a91.0.2026.05.20.10.18.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 10:18:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 13/30] fpu: Introduce FloatSNaNRule
Date: Wed, 20 May 2026 10:18:03 -0700
Message-ID: <20260520171820.848839-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520171820.848839-1-richard.henderson@linaro.org>
References: <20260520171820.848839-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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

Merge snan_bit_is_one and no_signaling_nans into one control.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/fpu/softfloat-helpers.h | 14 +++++-----
 include/fpu/softfloat-types.h   | 25 ++++++++++++-----
 target/mips/fpu_helper.h        |  3 ++-
 target/hppa/fpu_helper.c        |  2 +-
 target/mips/msa.c               |  4 +--
 target/sh4/cpu.c                |  2 +-
 target/xtensa/cpu.c             |  3 ++-
 fpu/softfloat-specialize.c.inc  | 48 +++++++++++++--------------------
 8 files changed, 51 insertions(+), 50 deletions(-)

diff --git a/include/fpu/softfloat-helpers.h b/include/fpu/softfloat-helpers.h
index 745a49f07a..95edd22842 100644
--- a/include/fpu/softfloat-helpers.h
+++ b/include/fpu/softfloat-helpers.h
@@ -127,14 +127,9 @@ static inline void set_default_nan_mode(bool val, float_status *status)
     status->default_nan_mode = val;
 }
 
-static inline void set_snan_bit_is_one(bool val, float_status *status)
+static inline void set_snan_rule(FloatSNaNRule val, float_status *status)
 {
-    status->snan_bit_is_one = val;
-}
-
-static inline void set_no_signaling_nans(bool val, float_status *status)
-{
-    status->no_signaling_nans = val;
+    status->float_snan_rule = val;
 }
 
 static inline bool get_float_detect_tininess(const float_status *status)
@@ -203,6 +198,11 @@ static inline bool get_default_nan_mode(const float_status *status)
     return status->default_nan_mode;
 }
 
+static inline FloatSNaNRule get_snan_rule(float_status *status)
+{
+    return status->float_snan_rule;
+}
+
 static inline FloatFTZDetection get_float_ftz_detection(const float_status *status)
 {
     return status->ftz_detection;
diff --git a/include/fpu/softfloat-types.h b/include/fpu/softfloat-types.h
index 5048faa76f..cf7093fa86 100644
--- a/include/fpu/softfloat-types.h
+++ b/include/fpu/softfloat-types.h
@@ -192,6 +192,23 @@ typedef enum __attribute__((__packed__)) {
     floatx80_precision_s,
 } FloatX80RoundPrec;
 
+/*
+ * Define how the architecture discriminates signaling NaNs.
+ * This done with the most significant bit of the fraction.
+ *
+ * In IEEE 754-1985 this was implementation defined, but in IEEE 754-2008
+ * the msb must be 0.  But setting the msb to 1 got baked into HPPA, SH4,
+ * and pre-2008 MIPS.
+ *
+ * Further, some architectures (or modes of architectures) do not detect
+ * signaling NaNs at all.
+ */
+typedef enum __attribute__((__packed__)) {
+    float_snan_bit_is_zero,
+    float_snan_bit_is_one,
+    float_snan_never,
+} FloatSNaNRule;
+
 /*
  * 2-input NaN propagation rule. Individual architectures have
  * different rules for which input NaN is propagated to the output
@@ -394,6 +411,7 @@ typedef struct float_status {
     Float2NaNPropRule float_2nan_prop_rule;
     Float3NaNPropRule float_3nan_prop_rule;
     FloatInfZeroNaNRule float_infzeronan_rule;
+    FloatSNaNRule float_snan_rule;
     bool tininess_before_rounding;
     /* should denormalised results go to zero and set output_denormal_flushed? */
     bool flush_to_zero;
@@ -412,13 +430,6 @@ typedef struct float_status {
      * create a default NaN.
      */
     uint8_t default_nan_pattern;
-    /*
-     * The flags below are not used on all specializations and may
-     * constant fold away (see snan_bit_is_one()/no_signalling_nans() in
-     * softfloat-specialize.inc.c)
-     */
-    bool snan_bit_is_one;
-    bool no_signaling_nans;
     /* should overflowed results subtract re_bias to its exponent? */
     bool rebias_overflow;
     /* should underflowed results add re_bias to its exponent? */
diff --git a/target/mips/fpu_helper.h b/target/mips/fpu_helper.h
index 08fb409390..cf667c6637 100644
--- a/target/mips/fpu_helper.h
+++ b/target/mips/fpu_helper.h
@@ -35,7 +35,8 @@ static inline void restore_snan_bit_mode(CPUMIPSState *env)
      * With nan2008, SNaNs are silenced in the usual way.
      * Before that, SNaNs are not silenced; default nans are produced.
      */
-    set_snan_bit_is_one(!nan2008, &env->active_fpu.fp_status);
+    set_snan_rule(nan2008 ? float_snan_bit_is_zero : float_snan_bit_is_one,
+                  &env->active_fpu.fp_status);
     set_default_nan_mode(!nan2008, &env->active_fpu.fp_status);
     /*
      * For MIPS systems that conform to IEEE754-1985, the (inf,zero,nan)
diff --git a/target/hppa/fpu_helper.c b/target/hppa/fpu_helper.c
index 2d272730f6..cdbebcfeb3 100644
--- a/target/hppa/fpu_helper.c
+++ b/target/hppa/fpu_helper.c
@@ -66,7 +66,7 @@ void HELPER(loaded_fr0)(CPUHPPAState *env)
     set_float_infzeronan_rule(float_infzeronan_dnan_never, &env->fp_status);
     /* Default NaN: sign bit clear, msb-1 frac bit set */
     set_float_default_nan_pattern(0b00100000, &env->fp_status);
-    set_snan_bit_is_one(true, &env->fp_status);
+    set_snan_rule(float_snan_bit_is_one, &env->fp_status);
     /*
      * "PA-RISC 2.0 Architecture" says it is IMPDEF whether the flushing
      * enabled by FPSR.D happens before or after rounding. We pick "before"
diff --git a/target/mips/msa.c b/target/mips/msa.c
index 32c6acbcc5..53fbce10d3 100644
--- a/target/mips/msa.c
+++ b/target/mips/msa.c
@@ -84,8 +84,8 @@ void msa_reset(CPUMIPSState *env)
     /* clear float_status nan mode */
     set_default_nan_mode(0, &env->active_tc.msa_fp_status);
 
-    /* set proper signanling bit meaning ("1" means "quiet") */
-    set_snan_bit_is_one(0, &env->active_tc.msa_fp_status);
+    /* set proper signanling bit meaning */
+    set_snan_rule(float_snan_bit_is_zero, &env->active_tc.msa_fp_status);
 
     /* Inf * 0 + NaN returns the input NaN */
     set_float_infzeronan_rule(float_infzeronan_dnan_never,
diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index 40d5fde76d..763424695c 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -151,7 +151,7 @@ static void superh_cpu_reset_hold(Object *obj, ResetType type)
     set_flush_to_zero(1, &env->fp_status);
 #endif
     set_default_nan_mode(1, &env->fp_status);
-    set_snan_bit_is_one(true, &env->fp_status);
+    set_snan_rule(float_snan_bit_is_one, &env->fp_status);
     /* sign bit clear, set all frac bits other than msb */
     set_float_default_nan_pattern(0b00111111, &env->fp_status);
     /*
diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index d6d42319e5..2015a4e3d0 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -209,7 +209,8 @@ static void xtensa_cpu_reset_hold(Object *obj, ResetType type)
 #endif
     /* For inf * 0 + NaN, return the input NaN */
     set_float_infzeronan_rule(float_infzeronan_dnan_never, &env->fp_status);
-    set_no_signaling_nans(!dfpu, &env->fp_status);
+    set_snan_rule(dfpu ? float_snan_bit_is_zero : float_snan_never,
+                  &env->fp_status);
     /* Default NaN value: sign bit clear, set frac msb */
     set_float_default_nan_pattern(0b01000000, &env->fp_status);
     xtensa_use_first_nan(env, !dfpu);
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index e2e3ec0e81..0b527302a5 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -79,26 +79,6 @@ this code that are retained.
  * version 2 or later. See the COPYING file in the top-level directory.
  */
 
-/*
- * Define whether architecture deviates from IEEE in not supporting
- * signaling NaNs (so all NaNs are treated as quiet).
- */
-static inline bool no_signaling_nans(float_status *status)
-{
-    return status->no_signaling_nans;
-}
-
-/* Define how the architecture discriminates signaling NaNs.
- * This done with the most significant bit of the fraction.
- * In IEEE 754-1985 this was implementation defined, but in IEEE 754-2008
- * the msb must be zero.  MIPS is (so far) unique in supporting both the
- * 2008 revision and backward compatibility with their original choice.
- */
-static inline bool snan_bit_is_one(float_status *status)
-{
-    return status->snan_bit_is_one;
-}
-
 /*----------------------------------------------------------------------------
 | For the deconstructed floating-point with fraction FRAC, return true
 | if the fraction represents a signalling NaN; otherwise false.
@@ -106,11 +86,15 @@ static inline bool snan_bit_is_one(float_status *status)
 
 static bool frac_msb_is_snan(bool msb, float_status *status)
 {
-    if (no_signaling_nans(status)) {
+    switch (get_snan_rule(status)) {
+    case float_snan_never:
         return false;
-    } else {
-        return msb == snan_bit_is_one(status);
+    case float_snan_bit_is_one:
+        return msb;
+    case float_snan_bit_is_zero:
+        return !msb;
     }
+    g_assert_not_reached();
 }
 
 static bool parts_is_snan_frac(uint64_t frac, float_status *status)
@@ -172,14 +156,18 @@ FloatParts128 parts128_default_nan(float_status *status)
 
 static uint64_t parts_silence_nan_frac(uint64_t frac, float_status *status)
 {
-    g_assert(!no_signaling_nans(status));
-
-    /* The only snan_bit_is_one target without default_nan_mode is HPPA. */
-    if (snan_bit_is_one(status)) {
+    switch (get_snan_rule(status)) {
+    case float_snan_bit_is_zero:
+        frac |= 1ULL << (DECOMPOSED_BINARY_POINT - 1);
+        break;
+    case float_snan_bit_is_one:
+        /* The only snan_bit_is_one target without default_nan_mode is HPPA. */
         frac &= ~(1ULL << (DECOMPOSED_BINARY_POINT - 1));
         frac |= 1ULL << (DECOMPOSED_BINARY_POINT - 2);
-    } else {
-        frac |= 1ULL << (DECOMPOSED_BINARY_POINT - 1);
+        break;
+    case float_snan_never:
+    default:
+        g_assert_not_reached();
     }
     return frac;
 }
@@ -390,7 +378,7 @@ bool floatx80_is_signaling_nan(floatx80 a, float_status *status)
 floatx80 floatx80_silence_nan(floatx80 a, float_status *status)
 {
     /* None of the targets that have snan_bit_is_one use floatx80.  */
-    assert(!snan_bit_is_one(status));
+    assert(get_snan_rule(status) == float_snan_bit_is_zero);
     a.low |= UINT64_C(0xC000000000000000);
     return a;
 }
-- 
2.43.0


