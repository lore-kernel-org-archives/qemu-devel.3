Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D425C021BB
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 18:09:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmzMJ-0008I1-5G; Tue, 25 Feb 2025 13:08:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmzJj-0000JY-VF
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:06:12 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmzJZ-0002Hi-54
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:05:59 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4399d14334aso52069415e9.0
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 10:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740506740; x=1741111540; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qVWx2WfVd+sFc/6ql2bNA16ZL91r1jlfj1e4zQYrYRE=;
 b=idjpnyy4jlohSMtGfvHP89L8d7TZWAugeX7H1zw4I74yKC37LIcNXwd1AI+nHU6cPV
 snyiVA4UAN5wwbGI1/ilwI358vtRO2yNVRCOnq+w2lneFfoUC83t6pJGVf/IY9LqNzKs
 CtBGtx1fGinCnY4rLTyopDYEQN+OzMn3aFyJJSHb9smjCyjzP7lhNir5P4iywH+gMZqh
 n1FaNuOT5nGNWKw5ra7P9OtJCubj25Zkmok1XR3Ak9XDjf5iZhEpdTEkEaw4FyTc6DZW
 eLtYD4NxEecy6+maO4Mu3ThDCMoNbqE14coEabD9I296/64/Axt80oSt9qUCF+mbBy0m
 iIlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740506740; x=1741111540;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qVWx2WfVd+sFc/6ql2bNA16ZL91r1jlfj1e4zQYrYRE=;
 b=Jzz1z9wdfg70BPUpBq+2TRvpGmXcc0tyFIM1NYSE4o4iP7xqvyJTcsbqoO9f5bsg64
 85Wmr6x94JfP7Efuangu98BUKfshtdWJ/QfTT+zuIsql3USbbnm9TxqiMi2tZJNlo/kr
 Emgz2jFHg0Kr6hw3PZFG2xANcmS8jRM6oTQxIwzG/aeCpv+1BGWu1W00hAkCubnMbK4d
 oG8xMOuH8Q+9f6e14mVcLBX0DhOmOgms3BLqyUCg0xamPKziwzjaCTYgFotqPGsXBlXZ
 ngqtEekSJmMhuh3T2xkfBoBlnbt7vZvYxBf/8+vfDRehv8QcVkddRhlx+jdE3QQviqTx
 SJcA==
X-Gm-Message-State: AOJu0Yyb26VXlMGqE/EC6111/L9QKdrqJ9RfBxsS9oXn4hFB6JdZx1m9
 ZmRNp0HmpfpjVY4jw8eTo6gRmD4qSX0Y13/FIPpvjBUDE/DfRQFvSf3m26lHFn8QvdLmSmgMVpO
 3
X-Gm-Gg: ASbGncsZhyIC4M7qmX63X5Ka6TGbZGpDLy8rcf1RWoA3X+NzJOkhDrCAEkt6uFW6ytn
 IVW85D8WmPNwb+KFymeEKYZ4yX438Zw4xOf9PVWIBiTBBqAAK33Hi2X9m3cHY86yNLiQV5YCc8h
 TKudmkILGBJBZZmgOYWWfpC4enFhGrCc/PY82s4U3pHVz1100SZeZPlS7SzOBVD8UoP6l8GNAHI
 oz0RwXZ615YYtafHZFrlt6WBjKxoyf+tDmjbUlKMVBxisAqVjQ1/isMYcfVdBjKTPhbAJaTutLx
 ZpWSPbsEehLDiG2n3a+NhzxEu1CUZBng
X-Google-Smtp-Source: AGHT+IEKn7B5l79hSegwYQqdcVtuZfkr6FZgF97uB25ZcIXm5rdjPClo4FMuRVEMjMprOuJ/yD48PQ==
X-Received: by 2002:a05:600c:3548:b0:439:8a44:1e68 with SMTP id
 5b1f17b1804b1-43ab9046de3mr4125195e9.28.1740506740096; 
 Tue, 25 Feb 2025 10:05:40 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ab156a136sm35147875e9.35.2025.02.25.10.05.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 10:05:38 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 23/43] target/arm: Move softfloat specific FPCR/FPSR handling
 to tcg/
Date: Tue, 25 Feb 2025 18:04:49 +0000
Message-ID: <20250225180510.1318207-24-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250225180510.1318207-1-peter.maydell@linaro.org>
References: <20250225180510.1318207-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

The softfloat (i.e. TCG) specific handling for the FPCR
and FPSR is abstracted behind five functions:
 arm_set_default_fp_behaviours
 arm_set_ah_fp_behaviours
 vfp_get_fpsr_from_host
 vfp_clear_float_status_exc_flags
 vfp_set_fpsr_to_host

Currently we rely on the first two calling softfloat functions that
work even in a KVM-only compile because they're defined as inline in
the softfloat header file, and we provide stub versions of the last
three in arm/vfp_helper.c if CONFIG_TCG isn't defined.

Move the softfloat-specific versions of these functions to
tcg/vfp_helper.c, and provide the non-TCG stub versions in
tcg-stubs.c.

This lets us drop the softfloat header include and the last
set of CONFIG_TCG ifdefs from arm/vfp_helper.c.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250221190957.811948-4-peter.maydell@linaro.org
---
 target/arm/internals.h      |   9 ++
 target/arm/tcg-stubs.c      |  22 ++++
 target/arm/tcg/vfp_helper.c | 228 +++++++++++++++++++++++++++++++++
 target/arm/vfp_helper.c     | 248 ------------------------------------
 4 files changed, 259 insertions(+), 248 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index b3187341456..a6ff228f9fd 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1833,5 +1833,14 @@ int alle1_tlbmask(CPUARMState *env);
 void arm_set_default_fp_behaviours(float_status *s);
 /* Set the float_status behaviour to match Arm FPCR.AH=1 behaviour */
 void arm_set_ah_fp_behaviours(float_status *s);
+/* Read the float_status info and return the appropriate FPSR value */
+uint32_t vfp_get_fpsr_from_host(CPUARMState *env);
+/* Clear the exception status flags from all float_status fields */
+void vfp_clear_float_status_exc_flags(CPUARMState *env);
+/*
+ * Update float_status fields to handle the bits of the FPCR
+ * specified by mask changing to the values in val.
+ */
+void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val, uint32_t mask);
 
 #endif
diff --git a/target/arm/tcg-stubs.c b/target/arm/tcg-stubs.c
index f3f45d54f28..93a15cad610 100644
--- a/target/arm/tcg-stubs.c
+++ b/target/arm/tcg-stubs.c
@@ -30,3 +30,25 @@ void assert_hflags_rebuild_correctly(CPUARMState *env)
 void define_tlb_insn_regs(ARMCPU *cpu)
 {
 }
+
+/* With KVM, we never use float_status, so these can be no-ops */
+void arm_set_default_fp_behaviours(float_status *s)
+{
+}
+
+void arm_set_ah_fp_behaviours(float_status *s)
+{
+}
+
+uint32_t vfp_get_fpsr_from_host(CPUARMState *env)
+{
+    return 0;
+}
+
+void vfp_clear_float_status_exc_flags(CPUARMState *env)
+{
+}
+
+void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val, uint32_t mask)
+{
+}
diff --git a/target/arm/tcg/vfp_helper.c b/target/arm/tcg/vfp_helper.c
index cd6e0d0edab..b32e2f4e27c 100644
--- a/target/arm/tcg/vfp_helper.c
+++ b/target/arm/tcg/vfp_helper.c
@@ -25,6 +25,234 @@
 #include "fpu/softfloat.h"
 #include "qemu/log.h"
 
+/*
+ * Set the float_status behaviour to match the Arm defaults:
+ *  * tininess-before-rounding
+ *  * 2-input NaN propagation prefers SNaN over QNaN, and then
+ *    operand A over operand B (see FPProcessNaNs() pseudocode)
+ *  * 3-input NaN propagation prefers SNaN over QNaN, and then
+ *    operand C over A over B (see FPProcessNaNs3() pseudocode,
+ *    but note that for QEMU muladd is a * b + c, whereas for
+ *    the pseudocode function the arguments are in the order c, a, b.
+ *  * 0 * Inf + NaN returns the default NaN if the input NaN is quiet,
+ *    and the input NaN if it is signalling
+ *  * Default NaN has sign bit clear, msb frac bit set
+ */
+void arm_set_default_fp_behaviours(float_status *s)
+{
+    set_float_detect_tininess(float_tininess_before_rounding, s);
+    set_float_ftz_detection(float_ftz_before_rounding, s);
+    set_float_2nan_prop_rule(float_2nan_prop_s_ab, s);
+    set_float_3nan_prop_rule(float_3nan_prop_s_cab, s);
+    set_float_infzeronan_rule(float_infzeronan_dnan_if_qnan, s);
+    set_float_default_nan_pattern(0b01000000, s);
+}
+
+/*
+ * Set the float_status behaviour to match the FEAT_AFP
+ * FPCR.AH=1 requirements:
+ *  * tininess-after-rounding
+ *  * 2-input NaN propagation prefers the first NaN
+ *  * 3-input NaN propagation prefers a over b over c
+ *  * 0 * Inf + NaN always returns the input NaN and doesn't
+ *    set Invalid for a QNaN
+ *  * default NaN has sign bit set, msb frac bit set
+ */
+void arm_set_ah_fp_behaviours(float_status *s)
+{
+    set_float_detect_tininess(float_tininess_after_rounding, s);
+    set_float_ftz_detection(float_ftz_after_rounding, s);
+    set_float_2nan_prop_rule(float_2nan_prop_ab, s);
+    set_float_3nan_prop_rule(float_3nan_prop_abc, s);
+    set_float_infzeronan_rule(float_infzeronan_dnan_never |
+                              float_infzeronan_suppress_invalid, s);
+    set_float_default_nan_pattern(0b11000000, s);
+}
+
+/* Convert host exception flags to vfp form.  */
+static inline uint32_t vfp_exceptbits_from_host(int host_bits, bool ah)
+{
+    uint32_t target_bits = 0;
+
+    if (host_bits & float_flag_invalid) {
+        target_bits |= FPSR_IOC;
+    }
+    if (host_bits & float_flag_divbyzero) {
+        target_bits |= FPSR_DZC;
+    }
+    if (host_bits & float_flag_overflow) {
+        target_bits |= FPSR_OFC;
+    }
+    if (host_bits & (float_flag_underflow | float_flag_output_denormal_flushed)) {
+        target_bits |= FPSR_UFC;
+    }
+    if (host_bits & float_flag_inexact) {
+        target_bits |= FPSR_IXC;
+    }
+    if (host_bits & float_flag_input_denormal_flushed) {
+        target_bits |= FPSR_IDC;
+    }
+    /*
+     * With FPCR.AH, IDC is set when an input denormal is used,
+     * and flushing an output denormal to zero sets both IXC and UFC.
+     */
+    if (ah && (host_bits & float_flag_input_denormal_used)) {
+        target_bits |= FPSR_IDC;
+    }
+    if (ah && (host_bits & float_flag_output_denormal_flushed)) {
+        target_bits |= FPSR_IXC;
+    }
+    return target_bits;
+}
+
+uint32_t vfp_get_fpsr_from_host(CPUARMState *env)
+{
+    uint32_t a32_flags = 0, a64_flags = 0;
+
+    a32_flags |= get_float_exception_flags(&env->vfp.fp_status[FPST_A32]);
+    a32_flags |= get_float_exception_flags(&env->vfp.fp_status[FPST_STD]);
+    /* FZ16 does not generate an input denormal exception.  */
+    a32_flags |= (get_float_exception_flags(&env->vfp.fp_status[FPST_A32_F16])
+          & ~float_flag_input_denormal_flushed);
+    a32_flags |= (get_float_exception_flags(&env->vfp.fp_status[FPST_STD_F16])
+          & ~float_flag_input_denormal_flushed);
+
+    a64_flags |= get_float_exception_flags(&env->vfp.fp_status[FPST_A64]);
+    a64_flags |= (get_float_exception_flags(&env->vfp.fp_status[FPST_A64_F16])
+          & ~(float_flag_input_denormal_flushed | float_flag_input_denormal_used));
+    /*
+     * We do not merge in flags from FPST_AH or FPST_AH_F16, because
+     * they are used for insns that must not set the cumulative exception bits.
+     */
+
+    /*
+     * Flushing an input denormal *only* because FPCR.FIZ == 1 does
+     * not set FPSR.IDC; if FPCR.FZ is also set then this takes
+     * precedence and IDC is set (see the FPUnpackBase pseudocode).
+     * So squash it unless (FPCR.AH == 0 && FPCR.FZ == 1).
+     * We only do this for the a64 flags because FIZ has no effect
+     * on AArch32 even if it is set.
+     */
+    if ((env->vfp.fpcr & (FPCR_FZ | FPCR_AH)) != FPCR_FZ) {
+        a64_flags &= ~float_flag_input_denormal_flushed;
+    }
+    return vfp_exceptbits_from_host(a64_flags, env->vfp.fpcr & FPCR_AH) |
+        vfp_exceptbits_from_host(a32_flags, false);
+}
+
+void vfp_clear_float_status_exc_flags(CPUARMState *env)
+{
+    /*
+     * Clear out all the exception-flag information in the float_status
+     * values. The caller should have arranged for env->vfp.fpsr to
+     * be the architecturally up-to-date exception flag information first.
+     */
+    set_float_exception_flags(0, &env->vfp.fp_status[FPST_A32]);
+    set_float_exception_flags(0, &env->vfp.fp_status[FPST_A64]);
+    set_float_exception_flags(0, &env->vfp.fp_status[FPST_A32_F16]);
+    set_float_exception_flags(0, &env->vfp.fp_status[FPST_A64_F16]);
+    set_float_exception_flags(0, &env->vfp.fp_status[FPST_STD]);
+    set_float_exception_flags(0, &env->vfp.fp_status[FPST_STD_F16]);
+    set_float_exception_flags(0, &env->vfp.fp_status[FPST_AH]);
+    set_float_exception_flags(0, &env->vfp.fp_status[FPST_AH_F16]);
+}
+
+static void vfp_sync_and_clear_float_status_exc_flags(CPUARMState *env)
+{
+    /*
+     * Synchronize any pending exception-flag information in the
+     * float_status values into env->vfp.fpsr, and then clear out
+     * the float_status data.
+     */
+    env->vfp.fpsr |= vfp_get_fpsr_from_host(env);
+    vfp_clear_float_status_exc_flags(env);
+}
+
+void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val, uint32_t mask)
+{
+    uint64_t changed = env->vfp.fpcr;
+
+    changed ^= val;
+    changed &= mask;
+    if (changed & (3 << 22)) {
+        int i = (val >> 22) & 3;
+        switch (i) {
+        case FPROUNDING_TIEEVEN:
+            i = float_round_nearest_even;
+            break;
+        case FPROUNDING_POSINF:
+            i = float_round_up;
+            break;
+        case FPROUNDING_NEGINF:
+            i = float_round_down;
+            break;
+        case FPROUNDING_ZERO:
+            i = float_round_to_zero;
+            break;
+        }
+        set_float_rounding_mode(i, &env->vfp.fp_status[FPST_A32]);
+        set_float_rounding_mode(i, &env->vfp.fp_status[FPST_A64]);
+        set_float_rounding_mode(i, &env->vfp.fp_status[FPST_A32_F16]);
+        set_float_rounding_mode(i, &env->vfp.fp_status[FPST_A64_F16]);
+    }
+    if (changed & FPCR_FZ16) {
+        bool ftz_enabled = val & FPCR_FZ16;
+        set_flush_to_zero(ftz_enabled, &env->vfp.fp_status[FPST_A32_F16]);
+        set_flush_to_zero(ftz_enabled, &env->vfp.fp_status[FPST_A64_F16]);
+        set_flush_to_zero(ftz_enabled, &env->vfp.fp_status[FPST_STD_F16]);
+        set_flush_to_zero(ftz_enabled, &env->vfp.fp_status[FPST_AH_F16]);
+        set_flush_inputs_to_zero(ftz_enabled, &env->vfp.fp_status[FPST_A32_F16]);
+        set_flush_inputs_to_zero(ftz_enabled, &env->vfp.fp_status[FPST_A64_F16]);
+        set_flush_inputs_to_zero(ftz_enabled, &env->vfp.fp_status[FPST_STD_F16]);
+        set_flush_inputs_to_zero(ftz_enabled, &env->vfp.fp_status[FPST_AH_F16]);
+    }
+    if (changed & FPCR_FZ) {
+        bool ftz_enabled = val & FPCR_FZ;
+        set_flush_to_zero(ftz_enabled, &env->vfp.fp_status[FPST_A32]);
+        set_flush_to_zero(ftz_enabled, &env->vfp.fp_status[FPST_A64]);
+        /* FIZ is A64 only so FZ always makes A32 code flush inputs to zero */
+        set_flush_inputs_to_zero(ftz_enabled, &env->vfp.fp_status[FPST_A32]);
+    }
+    if (changed & (FPCR_FZ | FPCR_AH | FPCR_FIZ)) {
+        /*
+         * A64: Flush denormalized inputs to zero if FPCR.FIZ = 1, or
+         * both FPCR.AH = 0 and FPCR.FZ = 1.
+         */
+        bool fitz_enabled = (val & FPCR_FIZ) ||
+            (val & (FPCR_FZ | FPCR_AH)) == FPCR_FZ;
+        set_flush_inputs_to_zero(fitz_enabled, &env->vfp.fp_status[FPST_A64]);
+    }
+    if (changed & FPCR_DN) {
+        bool dnan_enabled = val & FPCR_DN;
+        set_default_nan_mode(dnan_enabled, &env->vfp.fp_status[FPST_A32]);
+        set_default_nan_mode(dnan_enabled, &env->vfp.fp_status[FPST_A64]);
+        set_default_nan_mode(dnan_enabled, &env->vfp.fp_status[FPST_A32_F16]);
+        set_default_nan_mode(dnan_enabled, &env->vfp.fp_status[FPST_A64_F16]);
+        set_default_nan_mode(dnan_enabled, &env->vfp.fp_status[FPST_AH]);
+        set_default_nan_mode(dnan_enabled, &env->vfp.fp_status[FPST_AH_F16]);
+    }
+    if (changed & FPCR_AH) {
+        bool ah_enabled = val & FPCR_AH;
+
+        if (ah_enabled) {
+            /* Change behaviours for A64 FP operations */
+            arm_set_ah_fp_behaviours(&env->vfp.fp_status[FPST_A64]);
+            arm_set_ah_fp_behaviours(&env->vfp.fp_status[FPST_A64_F16]);
+        } else {
+            arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_A64]);
+            arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_A64_F16]);
+        }
+    }
+    /*
+     * If any bits changed that we look at in vfp_get_fpsr_from_host(),
+     * we must sync the float_status flags into vfp.fpsr now (under the
+     * old regime) before we update vfp.fpcr.
+     */
+    if (changed & (FPCR_FZ | FPCR_AH | FPCR_FIZ)) {
+        vfp_sync_and_clear_float_status_exc_flags(env);
+    }
+}
+
 /*
  * VFP support.  We follow the convention used for VFP instructions:
  * Single precision routines have a "s" suffix, double precision a
diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index 0919acb7b89..cc0f055ef0d 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -21,254 +21,6 @@
 #include "cpu.h"
 #include "internals.h"
 #include "cpu-features.h"
-#include "fpu/softfloat.h"
-
-/*
- * Set the float_status behaviour to match the Arm defaults:
- *  * tininess-before-rounding
- *  * 2-input NaN propagation prefers SNaN over QNaN, and then
- *    operand A over operand B (see FPProcessNaNs() pseudocode)
- *  * 3-input NaN propagation prefers SNaN over QNaN, and then
- *    operand C over A over B (see FPProcessNaNs3() pseudocode,
- *    but note that for QEMU muladd is a * b + c, whereas for
- *    the pseudocode function the arguments are in the order c, a, b.
- *  * 0 * Inf + NaN returns the default NaN if the input NaN is quiet,
- *    and the input NaN if it is signalling
- *  * Default NaN has sign bit clear, msb frac bit set
- */
-void arm_set_default_fp_behaviours(float_status *s)
-{
-    set_float_detect_tininess(float_tininess_before_rounding, s);
-    set_float_ftz_detection(float_ftz_before_rounding, s);
-    set_float_2nan_prop_rule(float_2nan_prop_s_ab, s);
-    set_float_3nan_prop_rule(float_3nan_prop_s_cab, s);
-    set_float_infzeronan_rule(float_infzeronan_dnan_if_qnan, s);
-    set_float_default_nan_pattern(0b01000000, s);
-}
-
-/*
- * Set the float_status behaviour to match the FEAT_AFP
- * FPCR.AH=1 requirements:
- *  * tininess-after-rounding
- *  * 2-input NaN propagation prefers the first NaN
- *  * 3-input NaN propagation prefers a over b over c
- *  * 0 * Inf + NaN always returns the input NaN and doesn't
- *    set Invalid for a QNaN
- *  * default NaN has sign bit set, msb frac bit set
- */
-void arm_set_ah_fp_behaviours(float_status *s)
-{
-    set_float_detect_tininess(float_tininess_after_rounding, s);
-    set_float_ftz_detection(float_ftz_after_rounding, s);
-    set_float_2nan_prop_rule(float_2nan_prop_ab, s);
-    set_float_3nan_prop_rule(float_3nan_prop_abc, s);
-    set_float_infzeronan_rule(float_infzeronan_dnan_never |
-                              float_infzeronan_suppress_invalid, s);
-    set_float_default_nan_pattern(0b11000000, s);
-}
-
-#ifdef CONFIG_TCG
-
-/* Convert host exception flags to vfp form.  */
-static inline uint32_t vfp_exceptbits_from_host(int host_bits, bool ah)
-{
-    uint32_t target_bits = 0;
-
-    if (host_bits & float_flag_invalid) {
-        target_bits |= FPSR_IOC;
-    }
-    if (host_bits & float_flag_divbyzero) {
-        target_bits |= FPSR_DZC;
-    }
-    if (host_bits & float_flag_overflow) {
-        target_bits |= FPSR_OFC;
-    }
-    if (host_bits & (float_flag_underflow | float_flag_output_denormal_flushed)) {
-        target_bits |= FPSR_UFC;
-    }
-    if (host_bits & float_flag_inexact) {
-        target_bits |= FPSR_IXC;
-    }
-    if (host_bits & float_flag_input_denormal_flushed) {
-        target_bits |= FPSR_IDC;
-    }
-    /*
-     * With FPCR.AH, IDC is set when an input denormal is used,
-     * and flushing an output denormal to zero sets both IXC and UFC.
-     */
-    if (ah && (host_bits & float_flag_input_denormal_used)) {
-        target_bits |= FPSR_IDC;
-    }
-    if (ah && (host_bits & float_flag_output_denormal_flushed)) {
-        target_bits |= FPSR_IXC;
-    }
-    return target_bits;
-}
-
-static uint32_t vfp_get_fpsr_from_host(CPUARMState *env)
-{
-    uint32_t a32_flags = 0, a64_flags = 0;
-
-    a32_flags |= get_float_exception_flags(&env->vfp.fp_status[FPST_A32]);
-    a32_flags |= get_float_exception_flags(&env->vfp.fp_status[FPST_STD]);
-    /* FZ16 does not generate an input denormal exception.  */
-    a32_flags |= (get_float_exception_flags(&env->vfp.fp_status[FPST_A32_F16])
-          & ~float_flag_input_denormal_flushed);
-    a32_flags |= (get_float_exception_flags(&env->vfp.fp_status[FPST_STD_F16])
-          & ~float_flag_input_denormal_flushed);
-
-    a64_flags |= get_float_exception_flags(&env->vfp.fp_status[FPST_A64]);
-    a64_flags |= (get_float_exception_flags(&env->vfp.fp_status[FPST_A64_F16])
-          & ~(float_flag_input_denormal_flushed | float_flag_input_denormal_used));
-    /*
-     * We do not merge in flags from FPST_AH or FPST_AH_F16, because
-     * they are used for insns that must not set the cumulative exception bits.
-     */
-
-    /*
-     * Flushing an input denormal *only* because FPCR.FIZ == 1 does
-     * not set FPSR.IDC; if FPCR.FZ is also set then this takes
-     * precedence and IDC is set (see the FPUnpackBase pseudocode).
-     * So squash it unless (FPCR.AH == 0 && FPCR.FZ == 1).
-     * We only do this for the a64 flags because FIZ has no effect
-     * on AArch32 even if it is set.
-     */
-    if ((env->vfp.fpcr & (FPCR_FZ | FPCR_AH)) != FPCR_FZ) {
-        a64_flags &= ~float_flag_input_denormal_flushed;
-    }
-    return vfp_exceptbits_from_host(a64_flags, env->vfp.fpcr & FPCR_AH) |
-        vfp_exceptbits_from_host(a32_flags, false);
-}
-
-static void vfp_clear_float_status_exc_flags(CPUARMState *env)
-{
-    /*
-     * Clear out all the exception-flag information in the float_status
-     * values. The caller should have arranged for env->vfp.fpsr to
-     * be the architecturally up-to-date exception flag information first.
-     */
-    set_float_exception_flags(0, &env->vfp.fp_status[FPST_A32]);
-    set_float_exception_flags(0, &env->vfp.fp_status[FPST_A64]);
-    set_float_exception_flags(0, &env->vfp.fp_status[FPST_A32_F16]);
-    set_float_exception_flags(0, &env->vfp.fp_status[FPST_A64_F16]);
-    set_float_exception_flags(0, &env->vfp.fp_status[FPST_STD]);
-    set_float_exception_flags(0, &env->vfp.fp_status[FPST_STD_F16]);
-    set_float_exception_flags(0, &env->vfp.fp_status[FPST_AH]);
-    set_float_exception_flags(0, &env->vfp.fp_status[FPST_AH_F16]);
-}
-
-static void vfp_sync_and_clear_float_status_exc_flags(CPUARMState *env)
-{
-    /*
-     * Synchronize any pending exception-flag information in the
-     * float_status values into env->vfp.fpsr, and then clear out
-     * the float_status data.
-     */
-    env->vfp.fpsr |= vfp_get_fpsr_from_host(env);
-    vfp_clear_float_status_exc_flags(env);
-}
-
-static void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val, uint32_t mask)
-{
-    uint64_t changed = env->vfp.fpcr;
-
-    changed ^= val;
-    changed &= mask;
-    if (changed & (3 << 22)) {
-        int i = (val >> 22) & 3;
-        switch (i) {
-        case FPROUNDING_TIEEVEN:
-            i = float_round_nearest_even;
-            break;
-        case FPROUNDING_POSINF:
-            i = float_round_up;
-            break;
-        case FPROUNDING_NEGINF:
-            i = float_round_down;
-            break;
-        case FPROUNDING_ZERO:
-            i = float_round_to_zero;
-            break;
-        }
-        set_float_rounding_mode(i, &env->vfp.fp_status[FPST_A32]);
-        set_float_rounding_mode(i, &env->vfp.fp_status[FPST_A64]);
-        set_float_rounding_mode(i, &env->vfp.fp_status[FPST_A32_F16]);
-        set_float_rounding_mode(i, &env->vfp.fp_status[FPST_A64_F16]);
-    }
-    if (changed & FPCR_FZ16) {
-        bool ftz_enabled = val & FPCR_FZ16;
-        set_flush_to_zero(ftz_enabled, &env->vfp.fp_status[FPST_A32_F16]);
-        set_flush_to_zero(ftz_enabled, &env->vfp.fp_status[FPST_A64_F16]);
-        set_flush_to_zero(ftz_enabled, &env->vfp.fp_status[FPST_STD_F16]);
-        set_flush_to_zero(ftz_enabled, &env->vfp.fp_status[FPST_AH_F16]);
-        set_flush_inputs_to_zero(ftz_enabled, &env->vfp.fp_status[FPST_A32_F16]);
-        set_flush_inputs_to_zero(ftz_enabled, &env->vfp.fp_status[FPST_A64_F16]);
-        set_flush_inputs_to_zero(ftz_enabled, &env->vfp.fp_status[FPST_STD_F16]);
-        set_flush_inputs_to_zero(ftz_enabled, &env->vfp.fp_status[FPST_AH_F16]);
-    }
-    if (changed & FPCR_FZ) {
-        bool ftz_enabled = val & FPCR_FZ;
-        set_flush_to_zero(ftz_enabled, &env->vfp.fp_status[FPST_A32]);
-        set_flush_to_zero(ftz_enabled, &env->vfp.fp_status[FPST_A64]);
-        /* FIZ is A64 only so FZ always makes A32 code flush inputs to zero */
-        set_flush_inputs_to_zero(ftz_enabled, &env->vfp.fp_status[FPST_A32]);
-    }
-    if (changed & (FPCR_FZ | FPCR_AH | FPCR_FIZ)) {
-        /*
-         * A64: Flush denormalized inputs to zero if FPCR.FIZ = 1, or
-         * both FPCR.AH = 0 and FPCR.FZ = 1.
-         */
-        bool fitz_enabled = (val & FPCR_FIZ) ||
-            (val & (FPCR_FZ | FPCR_AH)) == FPCR_FZ;
-        set_flush_inputs_to_zero(fitz_enabled, &env->vfp.fp_status[FPST_A64]);
-    }
-    if (changed & FPCR_DN) {
-        bool dnan_enabled = val & FPCR_DN;
-        set_default_nan_mode(dnan_enabled, &env->vfp.fp_status[FPST_A32]);
-        set_default_nan_mode(dnan_enabled, &env->vfp.fp_status[FPST_A64]);
-        set_default_nan_mode(dnan_enabled, &env->vfp.fp_status[FPST_A32_F16]);
-        set_default_nan_mode(dnan_enabled, &env->vfp.fp_status[FPST_A64_F16]);
-        set_default_nan_mode(dnan_enabled, &env->vfp.fp_status[FPST_AH]);
-        set_default_nan_mode(dnan_enabled, &env->vfp.fp_status[FPST_AH_F16]);
-    }
-    if (changed & FPCR_AH) {
-        bool ah_enabled = val & FPCR_AH;
-
-        if (ah_enabled) {
-            /* Change behaviours for A64 FP operations */
-            arm_set_ah_fp_behaviours(&env->vfp.fp_status[FPST_A64]);
-            arm_set_ah_fp_behaviours(&env->vfp.fp_status[FPST_A64_F16]);
-        } else {
-            arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_A64]);
-            arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_A64_F16]);
-        }
-    }
-    /*
-     * If any bits changed that we look at in vfp_get_fpsr_from_host(),
-     * we must sync the float_status flags into vfp.fpsr now (under the
-     * old regime) before we update vfp.fpcr.
-     */
-    if (changed & (FPCR_FZ | FPCR_AH | FPCR_FIZ)) {
-        vfp_sync_and_clear_float_status_exc_flags(env);
-    }
-}
-
-#else
-
-static uint32_t vfp_get_fpsr_from_host(CPUARMState *env)
-{
-    return 0;
-}
-
-static void vfp_clear_float_status_exc_flags(CPUARMState *env)
-{
-}
-
-static void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val, uint32_t mask)
-{
-}
-
-#endif
 
 uint32_t vfp_get_fpcr(CPUARMState *env)
 {
-- 
2.43.0


