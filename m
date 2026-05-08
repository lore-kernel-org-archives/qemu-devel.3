Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60362CD3436
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 13:58:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLLiW-0007jv-Mq; Fri, 08 May 2026 09:58:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wLLiF-0007iO-7t
 for qemu-devel@nongnu.org; Fri, 08 May 2026 09:57:58 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wLLiC-0004tG-9S
 for qemu-devel@nongnu.org; Fri, 08 May 2026 09:57:54 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4891f625344so22159675e9.0
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 06:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778248670; x=1778853470; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=luzxF5ulO5IEiSDzvshLV2iJ5fNoTWHLIXdC+k0TlKk=;
 b=PN96BDvPj8U5sgo9cfzGBOp1P7JlkAcYUYp00O0ofNIYNjiJkkvTva+YnvaUELSsm7
 yL6Bp2jGWsgNXSa1GWrf2GQQqQsFQhYZpGWp1eNmik50c+HKKT+px3Rgtn34oPvoDMrY
 rz9GRdteIspOQxFnlUkiaLS8SooCOdEbt1lZOYVE6fGRPqcyekHRj0zvk7XHoyZ0IaH5
 pHcxhJgZrBtmlL7ULeqaI8NvPcAkEB/dpvf3QBR9MtNUQ/GNGpmaJ2Uz1L2cIJYWjFSA
 34Oyujx4vEhV7Cf5uyvhKh5pC1BSEUMXqmr2bnTwZDenOKXe0hJrcvtJmy4ZL4znlGDx
 NFVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778248670; x=1778853470;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=luzxF5ulO5IEiSDzvshLV2iJ5fNoTWHLIXdC+k0TlKk=;
 b=mfjUtBlPFmqaJx6LMpZ0HEJQreeI0wL29H4RVex0zuar6iGyFmlTEHxlViVIEaSLK2
 0Yzxe9bQhQCsC2mXvrTZjjtXaWfegMgld2DNPColwaiPtum/zGWh+RcbVR5e/LtAYaHH
 6OJxaF3aq80QkX8qCDaoLxzk7sdAAPi46Sljt4qm7n9HOiAGisGt6IHqQSzM+KyO5My7
 dOo5SR0eDc0sjrak+afHCXXhxCk5H3O8zIIAWcIu7erczNiNfHagAbWGMa15vUYDvFB1
 36UL0uvGGDOwdgOjD0MriGo+4swofZg63y5X9qI7d7wsfH2POubm5HoLyoUK7R9RlUPk
 FS1A==
X-Forwarded-Encrypted: i=1;
 AFNElJ8WE9fSsgTMQnnwMrp8ye0nkqIxY803e34fjrjzwJfNETC8AVxCAT4aeXUadyaPkmSyvxjYEdAPiW0V@nongnu.org
X-Gm-Message-State: AOJu0YxGm7n8D8D+98GN4Anx8RFrPbmWQE8ssq0PSSpQ0Vby9vkl6GOZ
 8mKuHzPCRgdNexGBxaqp9Kxp2DUCAAdNgKQZEAPZfY0B3Adx9AQIOSC737jm14u9waWHBJafdf8
 YhsFQqn0=
X-Gm-Gg: AeBDies5ifC3gVG0ShZKtqZx3uGfSbHFbtMSS5V7WEveIju6EOMvrTPBH6zFisgn+jv
 4eZI32JZdMjuQYjB+8MxLBTmUL0HsDA4E7Ateae+wnm7WdZSyCrVzaNA8O5pTJFinY7QAkoZgYr
 lffODii6DE6rNQC2kDwHWFkWDYcLmjPr1unh4Sh1BSQqsf3SgXWPS50JRK3FKFYpV63keElPOM0
 BVPg3fmUTww6Ualf/ru7PLeHefVlnrhZx8z4PS/6JKNIyaO76qkVbvK/TqsH3XlV/DQdTOkr4ZJ
 eCElY8+ndcGdcRJ3JoMSsMyCnFDGGpvoAJ7pdI5vCEPqkSo+t3kphyaTHk6EV5hfEgvVIrXyzVH
 nDzGeDqBoMP1i5nrtIqLGEsT1fw3O/IVZNTCZ+CyM5Ix8gu/mtdzl+qIknYUCw6ko5q/s/jmY73
 QrlrChgl/DGO31w8rfYfyxfbFJl7EH1+OCTOiQy4ZTOT9gibp875zPKTu4vlYAvM+JxQ==
X-Received: by 2002:a05:600c:444f:b0:489:32b:ac0b with SMTP id
 5b1f17b1804b1-48e5dfd6a6amr109186445e9.6.1778248670194; 
 Fri, 08 May 2026 06:57:50 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e68ec5c49sm45001005e9.11.2026.05.08.06.57.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 May 2026 06:57:49 -0700 (PDT)
Message-ID: <b7a67aab-3ccc-4d1d-956f-60e7e587d51d@linaro.org>
Date: Fri, 8 May 2026 15:57:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/18] fpu: Introduce FloatSNaNRule
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260507221717.486023-1-richard.henderson@linaro.org>
 <20260507221717.486023-5-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260507221717.486023-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 8/5/26 00:17, Richard Henderson wrote:
> Merge snan_bit_is_one and no_signaling_nans into one control.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/fpu/softfloat-helpers.h | 14 ++---
>   include/fpu/softfloat-types.h   | 25 ++++++---
>   target/mips/fpu_helper.h        |  3 +-
>   target/hppa/fpu_helper.c        |  2 +-
>   target/mips/msa.c               |  4 +-
>   target/sh4/cpu.c                |  2 +-
>   target/xtensa/cpu.c             |  3 +-
>   fpu/softfloat-specialize.c.inc  | 95 ++++++++++++---------------------
>   8 files changed, 66 insertions(+), 82 deletions(-)

To ease review, please split in 2 patches, first factoring
frac_msb_is_snan() out then this patch with FloatSNaNRule:

-- >8 --
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index 9ed968c79b1..9b6d1f10ad3 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -104,14 +104,18 @@ static inline bool snan_bit_is_one(float_status 
*status)
  | if the fraction represents a signalling NaN; otherwise false.
  *----------------------------------------------------------------------------*/

-static bool parts_is_snan_frac(uint64_t frac, float_status *status)
+static bool frac_msb_is_snan(bool frac_msb_is_one, float_status *status)
  {
      if (no_signaling_nans(status)) {
          return false;
-    } else {
-        bool msb = extract64(frac, DECOMPOSED_BINARY_POINT - 1, 1);
-        return msb == snan_bit_is_one(status);
      }
+    return frac_msb_is_one == snan_bit_is_one(status);
+}
+
+static bool parts_is_snan_frac(uint64_t frac, float_status *status)
+{
+    bool msb = extract64(frac, DECOMPOSED_BINARY_POINT - 1, 1);
+    return frac_msb_is_snan(msb, status);
  }

  /*----------------------------------------------------------------------------
@@ -232,11 +236,7 @@ floatx80 floatx80_default_inf(bool zSign, 
float_status *status)

  static bool float16_nan_is_snan(float16 a, float_status *status)
  {
-    if (no_signaling_nans(status)) {
-        return false;
-    }
-    bool frac_msb_is_one = (a >> 9) & 1;
-    return frac_msb_is_one == snan_bit_is_one(status);
+    return frac_msb_is_snan((a >> 9) & 1, status);
  }

  /*----------------------------------------------------------------------------
@@ -265,11 +265,7 @@ bool float16_is_signaling_nan(float16 a_, 
float_status *status)

  static bool bfloat16_nan_is_snan(bfloat16 a, float_status *status)
  {
-    if (no_signaling_nans(status)) {
-        return false;
-    }
-    bool frac_msb_is_one = (a >> 6) & 1;
-    return frac_msb_is_one == snan_bit_is_one(status);
+    return frac_msb_is_snan((a >> 6) & 1, status);
  }

  /*----------------------------------------------------------------------------
@@ -296,11 +292,7 @@ bool bfloat16_is_signaling_nan(bfloat16 a_, 
float_status *status)

  static bool float32_nan_is_snan(float32 a, float_status *status)
  {
-    if (no_signaling_nans(status)) {
-        return false;
-    }
-    bool frac_msb_is_one = (a >> 22) & 1;
-    return frac_msb_is_one == snan_bit_is_one(status);
+    return frac_msb_is_snan((a >> 22) & 1, status);
  }

  /*----------------------------------------------------------------------------
@@ -329,11 +321,7 @@ bool float32_is_signaling_nan(float32 a_, 
float_status *status)

  static bool float64_nan_is_snan(float64 a, float_status *status)
  {
-    if (no_signaling_nans(status)) {
-        return false;
-    }
-    bool frac_msb_is_one = (a >> 51) & 1;
-    return frac_msb_is_one == snan_bit_is_one(status);
+    return frac_msb_is_snan((a >> 51) & 1, status);
  }

  /*----------------------------------------------------------------------------
@@ -364,11 +352,7 @@ bool float64_is_signaling_nan(float64 a_, 
float_status *status)

  static bool floatx80_nan_is_snan(floatx80 a, float_status *status)
  {
-    if (no_signaling_nans(status)) {
-        return false;
-    }
-    bool frac_msb_is_one = (a.low >> 62) & 1;
-    return frac_msb_is_one == snan_bit_is_one(status);
+    return frac_msb_is_snan((a.low >> 62) & 1, status);
  }

  /*----------------------------------------------------------------------------
@@ -410,11 +394,7 @@ floatx80 floatx80_silence_nan(floatx80 a, 
float_status *status)

  static bool float128_nan_is_snan(float128 a, float_status *status)
  {
-    if (no_signaling_nans(status)) {
-        return false;
-    }
-    bool frac_msb_is_one = (a.high >> 47) & 1;
-    return frac_msb_is_one == snan_bit_is_one(status);
+    return frac_msb_is_snan((a.high >> 47) & 1, status);
  }

  /*----------------------------------------------------------------------------
---

This current patch then becomes:

-- >8 --
diff --git a/include/fpu/softfloat-helpers.h 
b/include/fpu/softfloat-helpers.h
index 745a49f07a1..95edd228425 100644
--- a/include/fpu/softfloat-helpers.h
+++ b/include/fpu/softfloat-helpers.h
@@ -127,14 +127,9 @@ static inline void set_default_nan_mode(bool val, 
float_status *status)
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
@@ -203,6 +198,11 @@ static inline bool get_default_nan_mode(const 
float_status *status)
      return status->default_nan_mode;
  }

+static inline FloatSNaNRule get_snan_rule(float_status *status)
+{
+    return status->float_snan_rule;
+}
+
  static inline FloatFTZDetection get_float_ftz_detection(const 
float_status *status)
  {
      return status->ftz_detection;
diff --git a/include/fpu/softfloat-types.h b/include/fpu/softfloat-types.h
index 5048faa76f4..b8ce8ff78ea 100644
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
+    float_snan_bit_is_zero = 0,
+    float_snan_bit_is_one = 1,
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
      /* should denormalised results go to zero and set 
output_denormal_flushed? */
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
index 08fb4093904..cf667c66379 100644
--- a/target/mips/fpu_helper.h
+++ b/target/mips/fpu_helper.h
@@ -35,7 +35,8 @@ static inline void restore_snan_bit_mode(CPUMIPSState 
*env)
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
index 2d272730f60..cdbebcfeb3a 100644
--- a/target/hppa/fpu_helper.c
+++ b/target/hppa/fpu_helper.c
@@ -66,7 +66,7 @@ void HELPER(loaded_fr0)(CPUHPPAState *env)
      set_float_infzeronan_rule(float_infzeronan_dnan_never, 
&env->fp_status);
      /* Default NaN: sign bit clear, msb-1 frac bit set */
      set_float_default_nan_pattern(0b00100000, &env->fp_status);
-    set_snan_bit_is_one(true, &env->fp_status);
+    set_snan_rule(float_snan_bit_is_one, &env->fp_status);
      /*
       * "PA-RISC 2.0 Architecture" says it is IMPDEF whether the flushing
       * enabled by FPSR.D happens before or after rounding. We pick 
"before"
diff --git a/target/mips/msa.c b/target/mips/msa.c
index 32c6acbcc56..53fbce10d3f 100644
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
index e2bde457618..0f40acea009 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -151,7 +151,7 @@ static void superh_cpu_reset_hold(Object *obj, 
ResetType type)
      set_flush_to_zero(1, &env->fp_status);
  #endif
      set_default_nan_mode(1, &env->fp_status);
-    set_snan_bit_is_one(true, &env->fp_status);
+    set_snan_rule(float_snan_bit_is_one, &env->fp_status);
      /* sign bit clear, set all frac bits other than msb */
      set_float_default_nan_pattern(0b00111111, &env->fp_status);
      /*
diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index eebf40559bc..05ad358177f 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -208,7 +208,8 @@ static void xtensa_cpu_reset_hold(Object *obj, 
ResetType type)
  #endif
      /* For inf * 0 + NaN, return the input NaN */
      set_float_infzeronan_rule(float_infzeronan_dnan_never, 
&env->fp_status);
-    set_no_signaling_nans(!dfpu, &env->fp_status);
+    set_snan_rule(dfpu ? float_snan_bit_is_zero : float_snan_never,
+                  &env->fp_status);
      /* Default NaN value: sign bit clear, set frac msb */
      set_float_default_nan_pattern(0b01000000, &env->fp_status);
      xtensa_use_first_nan(env, !dfpu);
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index 9b6d1f10ad3..9a94bfe26b6 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -79,37 +79,23 @@ this code that are retained.
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
  *----------------------------------------------------------------------------*/

-static bool frac_msb_is_snan(bool frac_msb_is_one, float_status *status)
+static bool frac_msb_is_snan(bool msb, float_status *status)
  {
-    if (no_signaling_nans(status)) {
+    FloatSNaNRule rule = get_snan_rule(status);
+
+    switch (rule) {
+    case float_snan_never:
          return false;
+    case float_snan_bit_is_one:
+    case float_snan_bit_is_zero:
+        return msb == rule;
      }
-    return frac_msb_is_one == snan_bit_is_one(status);
+    g_assert_not_reached();
  }

  static bool parts_is_snan_frac(uint64_t frac, float_status *status)
@@ -172,14 +158,19 @@ static void parts128_default_nan(FloatParts128 *p, 
float_status *status)

  static uint64_t parts_silence_nan_frac(uint64_t frac, float_status 
*status)
  {
-    g_assert(!no_signaling_nans(status));
+    FloatSNaNRule rule = get_snan_rule(status);

-    /* The only snan_bit_is_one target without default_nan_mode is HPPA. */
-    if (snan_bit_is_one(status)) {
+    switch (rule) {
+    case float_snan_bit_is_zero:
+        frac |= 1ULL << (DECOMPOSED_BINARY_POINT - 1);
+        break;
+    case float_snan_bit_is_one:
+        /* The only snan_bit_is_one target without default_nan_mode is 
HPPA. */
          frac &= ~(1ULL << (DECOMPOSED_BINARY_POINT - 1));
          frac |= 1ULL << (DECOMPOSED_BINARY_POINT - 2);
-    } else {
-        frac |= 1ULL << (DECOMPOSED_BINARY_POINT - 1);
+        break;
+    default:
+        g_assert_not_reached();
      }
      return frac;
  }
@@ -383,7 +374,7 @@ bool floatx80_is_signaling_nan(floatx80 a, 
float_status *status)
  floatx80 floatx80_silence_nan(floatx80 a, float_status *status)
  {
      /* None of the targets that have snan_bit_is_one use floatx80.  */
-    assert(!snan_bit_is_one(status));
+    assert(get_snan_rule(status) == float_snan_bit_is_zero);
      a.low |= UINT64_C(0xC000000000000000);
      return a;
  }
---

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


