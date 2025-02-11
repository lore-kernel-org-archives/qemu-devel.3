Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95950C0219B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 16:26:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tht5Y-0006TR-9q; Tue, 11 Feb 2025 11:26:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht5K-0006OL-FD
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:26:06 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht5H-00032X-Pm
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:26:06 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-38ddc36b81dso1783586f8f.1
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 08:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739291162; x=1739895962; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=s0T8vNPBZtQsNtjhGpf1pt834TCeXjyPp/EBaF7Uk/E=;
 b=RcRzGvl7eDKnOFGyaNqmWLOtrmnnJbTml9JrccM0CtFL8uFzG9NOvm5D+Sqx1RUhBJ
 tfSa6uzheH0kketg2ie41rVBtNQq0GnCpWB2TfqYPfX1jT/r6Cz8IvIpu9r0VeFp8U4y
 GXuZBn/g+cZwd4ufiTXVslhIVthkp/T5GTeO2UH/wegB8+5WCG8nLtQcJ+CdZtSr7jMm
 HM/jGDI+lEwzeV4o72YrLAgdOyUNDn3zZBI10YG4YiA5uEqYeuKdIsxO6GgoN84UMYaf
 uSUIbtSLWfOAT5KatPvJi3jlPZsRtcB8a7Y6fSmT5OemFEjmud+5PJkFlu7KRyzQPgei
 +DgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739291162; x=1739895962;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s0T8vNPBZtQsNtjhGpf1pt834TCeXjyPp/EBaF7Uk/E=;
 b=au/igE6BRzbq5SUdcqafoQ1r+vd11NTYMMSjgkKKSoOav+w24ZBk6ZK+Ypljxukc2F
 afttGhZoMT+wLuARQnY8cbpqam+hG/Ds5PZj8uJjY7btprmvh6GHu+WcxMoRjs8RBo4m
 4IZtFPZotSylrQerp3qSCL150ArPikVpnH1HNtc71M/YpK0cVs2rzzSRMsgpfUJSRbZi
 MNyfvIrzBgDz/Mf2uGvsctvDI52dqk7vxWlZI2wKNEoLcMAKx+8ZwPznmdZLRYykMOWj
 VRSsMsGPyg1YvPDrCnnvKhjYhsgqVpkdU9eL/5l5fBXwvrlHwIauNYwtXrjhwDC0APB/
 YcQA==
X-Gm-Message-State: AOJu0YxrpKHMXsmuqHEED7tPtmcGZmDV2rAVHyO4T0H41hOlJexqc+rH
 tOXS3hmf0fDDIN1hV7/9qjyXo7ZNcPLcvcor5wz2y9IK8zd988itPMkmfxwD08ZaWpRvsjY7TG7
 B
X-Gm-Gg: ASbGncsLUUYAACpb/2N+b8CR4mF3WJI7L1BjWh6atA/AyD16B4GaA0+d890EqzU/6rl
 sXb5XRdIQoXopmxBs5V8SCOde0+4Cvzeu1uG/GQN0lElJkpRtpu59kr1WwHcgYEbd0HLQJmeFDb
 8JppL4uHocpmVuuVvIf6e9pLh5HRStI7MC8+tSvnPQcc9P/xaw+jlrMGSIgpvEVzBdQlJRoXmcL
 tXyTFvMFzg7Ycxjj77jL13ui1aca1d1YlP+3UEF/wl5DcgWDiLpAus1LjydxPs8xk4niCHpdix+
 0WU09QQy2/O+k/2E8Wjm
X-Google-Smtp-Source: AGHT+IELitMZHbsOUeTVmRSbiBQPcPoWQoTGfNIECggg1ssHyghEiBnEBjWvAPJBy1BvEVXk/RY5ag==
X-Received: by 2002:a05:6000:156a:b0:38d:afc8:954e with SMTP id
 ffacd0b85a97d-38de439d775mr4023386f8f.11.1739291161738; 
 Tue, 11 Feb 2025 08:26:01 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4393f202721sm82660455e9.21.2025.02.11.08.26.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 08:26:01 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/68] fpu: allow flushing of output denormals to be after
 rounding
Date: Tue, 11 Feb 2025 16:24:50 +0000
Message-Id: <20250211162554.4135349-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250211162554.4135349-1-peter.maydell@linaro.org>
References: <20250211162554.4135349-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
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

Currently we handle flushing of output denormals in uncanon_normal
always before we deal with rounding.  This works for architectures
that detect tininess before rounding, but is usually not the right
place when the architecture detects tininess after rounding.  For
example, for x86 the SDM states that the MXCSR FTZ control bit causes
outputs to be flushed to zero "when it detects a floating-point
underflow condition".  This means that we mustn't flush to zero if
the input is such that after rounding it is no longer tiny.

At least one of our guest architectures does underflow detection
after rounding but flushing of denormals before rounding (MIPS MSA);
this means we need to have a config knob for this that is separate
from our existing tininess_before_rounding setting.

Add an ftz_detection flag.  For consistency with
tininess_before_rounding, we make it default to "detect ftz after
rounding"; this means that we need to explicitly set the flag to
"detect ftz before rounding" on every existing architecture that sets
flush_to_zero, so that this commit has no behaviour change.
(This means more code change here but for the long term a less
confusing API.)

For several architectures the current behaviour is either
definitely or possibly wrong; annotate those with TODO comments.
These architectures are definitely wrong (and should detect
ftz after rounding):
 * x86
 * Alpha

For these architectures the spec is unclear:
 * MIPS (for non-MSA)
 * RX
 * SH4

PA-RISC makes ftz detection IMPDEF, but we aren't setting the
"tininess before rounding" setting that we ought to.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/fpu/softfloat-helpers.h | 11 +++++++++++
 include/fpu/softfloat-types.h   | 18 ++++++++++++++++++
 target/mips/fpu_helper.h        |  6 ++++++
 target/alpha/cpu.c              |  7 +++++++
 target/arm/cpu.c                |  1 +
 target/hppa/fpu_helper.c        | 11 +++++++++++
 target/i386/tcg/fpu_helper.c    |  8 ++++++++
 target/mips/msa.c               |  9 +++++++++
 target/ppc/cpu_init.c           |  3 +++
 target/rx/cpu.c                 |  8 ++++++++
 target/sh4/cpu.c                |  8 ++++++++
 target/tricore/helper.c         |  1 +
 tests/fp/fp-bench.c             |  1 +
 fpu/softfloat-parts.c.inc       | 21 +++++++++++++++------
 14 files changed, 107 insertions(+), 6 deletions(-)

diff --git a/include/fpu/softfloat-helpers.h b/include/fpu/softfloat-helpers.h
index 4cb30a48220..8983c2748ec 100644
--- a/include/fpu/softfloat-helpers.h
+++ b/include/fpu/softfloat-helpers.h
@@ -109,6 +109,12 @@ static inline void set_flush_inputs_to_zero(bool val, float_status *status)
     status->flush_inputs_to_zero = val;
 }
 
+static inline void set_float_ftz_detection(FloatFTZDetection d,
+                                           float_status *status)
+{
+    status->ftz_detection = d;
+}
+
 static inline void set_default_nan_mode(bool val, float_status *status)
 {
     status->default_nan_mode = val;
@@ -183,4 +189,9 @@ static inline bool get_default_nan_mode(const float_status *status)
     return status->default_nan_mode;
 }
 
+static inline FloatFTZDetection get_float_ftz_detection(const float_status *status)
+{
+    return status->ftz_detection;
+}
+
 #endif /* SOFTFLOAT_HELPERS_H */
diff --git a/include/fpu/softfloat-types.h b/include/fpu/softfloat-types.h
index bba1c397bb7..53d5eb85210 100644
--- a/include/fpu/softfloat-types.h
+++ b/include/fpu/softfloat-types.h
@@ -304,6 +304,22 @@ typedef enum __attribute__((__packed__)) {
     float_infzeronan_suppress_invalid = (1 << 7),
 } FloatInfZeroNaNRule;
 
+/*
+ * When flush_to_zero is set, should we detect denormal results to
+ * be flushed before or after rounding? For most architectures this
+ * should be set to match the tininess_before_rounding setting,
+ * but a few architectures, e.g. MIPS MSA, detect FTZ before
+ * rounding but tininess after rounding.
+ *
+ * This enum is arranged so that the default if the target doesn't
+ * configure it matches the default for tininess_before_rounding
+ * (i.e. "after rounding").
+ */
+typedef enum __attribute__((__packed__)) {
+    float_ftz_after_rounding = 0,
+    float_ftz_before_rounding = 1,
+} FloatFTZDetection;
+
 /*
  * Floating Point Status. Individual architectures may maintain
  * several versions of float_status for different functions. The
@@ -321,6 +337,8 @@ typedef struct float_status {
     bool tininess_before_rounding;
     /* should denormalised results go to zero and set output_denormal_flushed? */
     bool flush_to_zero;
+    /* do we detect and flush denormal results before or after rounding? */
+    FloatFTZDetection ftz_detection;
     /* should denormalised inputs go to zero and set input_denormal_flushed? */
     bool flush_inputs_to_zero;
     bool default_nan_mode;
diff --git a/target/mips/fpu_helper.h b/target/mips/fpu_helper.h
index 6ad1e466cfd..08fb4093904 100644
--- a/target/mips/fpu_helper.h
+++ b/target/mips/fpu_helper.h
@@ -84,6 +84,12 @@ static inline void fp_reset(CPUMIPSState *env)
      */
     set_float_2nan_prop_rule(float_2nan_prop_s_ab,
                              &env->active_fpu.fp_status);
+    /*
+     * TODO: the spec does't say clearly whether FTZ happens before
+     * or after rounding for normal FPU operations.
+     */
+    set_float_ftz_detection(float_ftz_before_rounding,
+                            &env->active_fpu.fp_status);
 }
 
 /* MSA */
diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index e1b898e5755..f5dd7449876 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -202,6 +202,13 @@ static void alpha_cpu_initfn(Object *obj)
     set_float_2nan_prop_rule(float_2nan_prop_x87, &env->fp_status);
     /* Default NaN: sign bit clear, msb frac bit set */
     set_float_default_nan_pattern(0b01000000, &env->fp_status);
+    /*
+     * TODO: this is incorrect. The Alpha Architecture Handbook version 4
+     * section 4.7.7.11 says that we flush to zero for underflow cases, so
+     * this should be float_ftz_after_rounding to match the
+     * tininess_after_rounding (which is specified in section 4.7.5).
+     */
+    set_float_ftz_detection(float_ftz_before_rounding, &env->fp_status);
 #if defined(CONFIG_USER_ONLY)
     env->flags = ENV_FLAG_PS_USER | ENV_FLAG_FEN;
     cpu_alpha_store_fpcr(env, (uint64_t)(FPCR_INVD | FPCR_DZED | FPCR_OVFD
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 32dc7c1e692..80377443008 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -185,6 +185,7 @@ void arm_register_el_change_hook(ARMCPU *cpu, ARMELChangeHookFn *hook,
 static void arm_set_default_fp_behaviours(float_status *s)
 {
     set_float_detect_tininess(float_tininess_before_rounding, s);
+    set_float_ftz_detection(float_ftz_before_rounding, s);
     set_float_2nan_prop_rule(float_2nan_prop_s_ab, s);
     set_float_3nan_prop_rule(float_3nan_prop_s_cab, s);
     set_float_infzeronan_rule(float_infzeronan_dnan_if_qnan, s);
diff --git a/target/hppa/fpu_helper.c b/target/hppa/fpu_helper.c
index 239c027ec52..8ff4b448049 100644
--- a/target/hppa/fpu_helper.c
+++ b/target/hppa/fpu_helper.c
@@ -67,6 +67,17 @@ void HELPER(loaded_fr0)(CPUHPPAState *env)
     set_float_infzeronan_rule(float_infzeronan_dnan_never, &env->fp_status);
     /* Default NaN: sign bit clear, msb-1 frac bit set */
     set_float_default_nan_pattern(0b00100000, &env->fp_status);
+    /*
+     * "PA-RISC 2.0 Architecture" says it is IMPDEF whether the flushing
+     * enabled by FPSR.D happens before or after rounding. We pick "before"
+     * for consistency with tininess detection.
+     */
+    set_float_ftz_detection(float_ftz_before_rounding, &env->fp_status);
+    /*
+     * TODO: "PA-RISC 2.0 Architecture" chapter 10 says that we should
+     * detect tininess before rounding, but we don't set that here so we
+     * get the default tininess after rounding.
+     */
 }
 
 void cpu_hppa_loaded_fr0(CPUHPPAState *env)
diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index de6d0b252ec..f112c6c6737 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -188,6 +188,14 @@ void cpu_init_fp_statuses(CPUX86State *env)
     set_float_default_nan_pattern(0b11000000, &env->fp_status);
     set_float_default_nan_pattern(0b11000000, &env->mmx_status);
     set_float_default_nan_pattern(0b11000000, &env->sse_status);
+    /*
+     * TODO: x86 does flush-to-zero detection after rounding (the SDM
+     * section 10.2.3.3 on the FTZ bit of MXCSR says that we flush
+     * when we detect underflow, which x86 does after rounding).
+     */
+    set_float_ftz_detection(float_ftz_before_rounding, &env->fp_status);
+    set_float_ftz_detection(float_ftz_before_rounding, &env->mmx_status);
+    set_float_ftz_detection(float_ftz_before_rounding, &env->sse_status);
 }
 
 static inline uint8_t save_exception_flags(CPUX86State *env)
diff --git a/target/mips/msa.c b/target/mips/msa.c
index fc77bfc7b9a..32c6acbcc56 100644
--- a/target/mips/msa.c
+++ b/target/mips/msa.c
@@ -48,6 +48,15 @@ void msa_reset(CPUMIPSState *env)
     /* tininess detected after rounding.*/
     set_float_detect_tininess(float_tininess_after_rounding,
                               &env->active_tc.msa_fp_status);
+    /*
+     * MSACSR.FS detects tiny results to flush to zero before rounding
+     * (per "MIPS Architecture for Programmers Volume IV-j: The MIPS64 SIMD
+     * Architecture Module, Revision 1.1" section 3.5.4), even though it
+     * detects tininess after rounding for underflow purposes (section 3.4.2
+     * table 3.3).
+     */
+    set_float_ftz_detection(float_ftz_before_rounding,
+                            &env->active_tc.msa_fp_status);
 
     /*
      * According to MIPS specifications, if one of the two operands is
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 8e49051254b..062a6e85fba 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7262,6 +7262,9 @@ static void ppc_cpu_reset_hold(Object *obj, ResetType type)
     /* tininess for underflow is detected before rounding */
     set_float_detect_tininess(float_tininess_before_rounding,
                               &env->fp_status);
+    /* Similarly for flush-to-zero */
+    set_float_ftz_detection(float_ftz_before_rounding, &env->fp_status);
+
     /*
      * PowerPC propagation rules:
      *  1. A if it sNaN or qNaN
diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index 8c50c7a1bc8..37a6fdd569b 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -103,6 +103,14 @@ static void rx_cpu_reset_hold(Object *obj, ResetType type)
     set_float_2nan_prop_rule(float_2nan_prop_x87, &env->fp_status);
     /* Default NaN value: sign bit clear, set frac msb */
     set_float_default_nan_pattern(0b01000000, &env->fp_status);
+    /*
+     * TODO: "RX Family RXv1 Instruction Set Architecture" is not 100% clear
+     * on whether flush-to-zero should happen before or after rounding, but
+     * section 1.3.2 says that it happens when underflow is detected, and
+     * implies that underflow is detected after rounding. So this may not
+     * be the correct setting.
+     */
+    set_float_ftz_detection(float_ftz_before_rounding, &env->fp_status);
 }
 
 static ObjectClass *rx_cpu_class_by_name(const char *cpu_model)
diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index 24a22724c61..4ac693d99bd 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -130,6 +130,14 @@ static void superh_cpu_reset_hold(Object *obj, ResetType type)
     set_default_nan_mode(1, &env->fp_status);
     /* sign bit clear, set all frac bits other than msb */
     set_float_default_nan_pattern(0b00111111, &env->fp_status);
+    /*
+     * TODO: "SH-4 CPU Core Architecture ADCS 7182230F" doesn't say whether
+     * it detects tininess before or after rounding. Section 6.4 is clear
+     * that flush-to-zero happens when the result underflows, though, so
+     * either this should be "detect ftz after rounding" or else we should
+     * be setting "detect tininess before rounding".
+     */
+    set_float_ftz_detection(float_ftz_before_rounding, &env->fp_status);
 }
 
 static void superh_cpu_disas_set_info(CPUState *cpu, disassemble_info *info)
diff --git a/target/tricore/helper.c b/target/tricore/helper.c
index e8b0ec51611..9898752eb00 100644
--- a/target/tricore/helper.c
+++ b/target/tricore/helper.c
@@ -116,6 +116,7 @@ void fpu_set_state(CPUTriCoreState *env)
     set_flush_inputs_to_zero(1, &env->fp_status);
     set_flush_to_zero(1, &env->fp_status);
     set_float_detect_tininess(float_tininess_before_rounding, &env->fp_status);
+    set_float_ftz_detection(float_ftz_before_rounding, &env->fp_status);
     set_default_nan_mode(1, &env->fp_status);
     /* Default NaN pattern: sign bit clear, frac msb set */
     set_float_default_nan_pattern(0b01000000, &env->fp_status);
diff --git a/tests/fp/fp-bench.c b/tests/fp/fp-bench.c
index eacb39b99cb..d90f542ea25 100644
--- a/tests/fp/fp-bench.c
+++ b/tests/fp/fp-bench.c
@@ -496,6 +496,7 @@ static void run_bench(void)
     set_float_3nan_prop_rule(float_3nan_prop_s_cab, &soft_status);
     set_float_infzeronan_rule(float_infzeronan_dnan_if_qnan, &soft_status);
     set_float_default_nan_pattern(0b01000000, &soft_status);
+    set_float_ftz_detection(float_ftz_before_rounding, &soft_status);
 
     f = bench_funcs[operation][precision];
     g_assert(f);
diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index 0122b35008a..1d09f066c5d 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -334,7 +334,8 @@ static void partsN(uncanon_normal)(FloatPartsN *p, float_status *s,
             p->frac_lo &= ~round_mask;
         }
         frac_shr(p, frac_shift);
-    } else if (s->flush_to_zero) {
+    } else if (s->flush_to_zero &&
+               s->ftz_detection == float_ftz_before_rounding) {
         flags |= float_flag_output_denormal_flushed;
         p->cls = float_class_zero;
         exp = 0;
@@ -381,11 +382,19 @@ static void partsN(uncanon_normal)(FloatPartsN *p, float_status *s,
         exp = (p->frac_hi & DECOMPOSED_IMPLICIT_BIT) && !fmt->m68k_denormal;
         frac_shr(p, frac_shift);
 
-        if (is_tiny && (flags & float_flag_inexact)) {
-            flags |= float_flag_underflow;
-        }
-        if (exp == 0 && frac_eqz(p)) {
-            p->cls = float_class_zero;
+        if (is_tiny) {
+            if (s->flush_to_zero) {
+                assert(s->ftz_detection == float_ftz_after_rounding);
+                flags |= float_flag_output_denormal_flushed;
+                p->cls = float_class_zero;
+                exp = 0;
+                frac_clear(p);
+            } else if (flags & float_flag_inexact) {
+                flags |= float_flag_underflow;
+            }
+            if (exp == 0 && frac_eqz(p)) {
+                p->cls = float_class_zero;
+            }
         }
     }
     p->exp = exp;
-- 
2.34.1


