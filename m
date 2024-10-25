Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 539B0D0C614
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 14:13:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4L3n-0003y8-9M; Fri, 25 Oct 2024 10:13:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t4L3m-0003xX-Ik
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 10:13:02 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t4L3j-0007la-78
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 10:13:02 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-539f84907caso2337218e87.3
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 07:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729865577; x=1730470377; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=noOStqS92L5He4WhIYZl74MdTVJ5AKWtfARpcTTpidc=;
 b=jIhxsrh0Q9fiBWSZU64t9sphn+NM7dy+v/xo5GSp1NNHDnTMBF3106VMe9ZsHwYYKa
 M4dfbMjksRz8kLSaQsPxtJ1EV/wp64XX97FeMOFis7LrEj5ZADG38L1lc2r0D/gpNs+K
 cR7jlbEzPvHmsycHZ5NRqbxTku+79j3jYj5y2LheOJXX3aRh6HGNHcj+5XB4zvSaEGPY
 LyEvYltrUo6s7Y/DNXeXVDw1OqL2qJpZs7B3AL8LoZm+SeRyxPtOGs5yIWoTnQ02FJEI
 s7fChd4DGHMmYsZPWkZ0tJeO1uu7b+/qdRv40hyN5au2Ln/2EuqWq8CfPgmUddyHh5WD
 Inqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729865577; x=1730470377;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=noOStqS92L5He4WhIYZl74MdTVJ5AKWtfARpcTTpidc=;
 b=Q0K5OmIsM89efTeTqsACGa0agMZAGFaDinjY5Pb/P/FV3W/0oGq3Fx+wZPis1ply4k
 brA99RUQTICtcJHpHgE3e99HHxzxQ5rHTp6XqWeRvl+ItanVNAZegeqBG29KJpfi2SCG
 GhcEI4RrQcMARPNHIIaf7P1cu0xz3xrK4JECPqx5kljAFPbfZL66beovyzkLakaIpwtK
 maqersNFVubUE85r5d1qYKkUV91ve60NFpUrIgoHGL9ckVg1Ckh334or7uLX3mTM6Z9e
 dK6P1BORWLQpGE6/MVQWOD5Gu82o9yl6ymRdlf6rvWi+RNPQLCIc0yzejSx2esaqXqB+
 BEZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyiUHWNTRPGJRpL9XhwV/Id5dLjOPibgmJbkpKfuqce2wwtAQbjfwGXwZiwBAz0lMOjxXS9cJnW3/a@nongnu.org
X-Gm-Message-State: AOJu0Yw5UtFlCJarIuY09LD+1gzTAR2hu5uQm9XToCG3cjA8HCQ0cvLs
 /fGriq3K3Fp66ajHnNNfPDCXt8YZhsk99P1TrMz+qUFYH1czvOI+s0t82bi4ob8=
X-Google-Smtp-Source: AGHT+IEeTDoH+lv09QPl3M7voGp1ePYFrgCHuZNvYkKI6PkEGUSkS+m2xyZ4/tfaTm+qUHXOaX/VXQ==
X-Received: by 2002:a05:6512:1048:b0:53b:1f90:576f with SMTP id
 2adb3069b0e04-53b23dfcfb6mr3139601e87.22.1729865577170; 
 Fri, 25 Oct 2024 07:12:57 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4318b57b051sm50104535e9.42.2024.10.25.07.12.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2024 07:12:56 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Eduardo Habkost <eduardo@habkost.net>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org
Subject: [PATCH 01/21] softfloat: Allow 2-operand NaN propagation rule to be
 set at runtime
Date: Fri, 25 Oct 2024 15:12:34 +0100
Message-Id: <20241025141254.2141506-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241025141254.2141506-1-peter.maydell@linaro.org>
References: <20241025141254.2141506-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x129.google.com
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

IEEE 758 does not define a fixed rule for which NaN to pick as the
result if both operands of a 2-operand operation are NaNs.  As a
result different architectures have ended up with different rules for
propagating NaNs.

QEMU currently hardcodes the NaN propagation logic into the binary
because pickNaN() has an ifdef ladder for different targets.  We want
to make the propagation rule instead be selectable at runtime,
because:
 * this will let us have multiple targets in one QEMU binary
 * the Arm FEAT_AFP architectural feature includes letting
   the guest select a NaN propagation rule at runtime
 * x86 specifies different propagation rules for x87 FPU ops
   and for SSE ops, and specifying the rule in the float_status
   would let us emulate this, instead of wrongly using the
   x87 rules everywhere

In this commit we add an enum for the propagation rule, the field in
float_status, and the corresponding getters and setters.  We change
pickNaN to honour this, but because all targets still leave this
field at its default 0 value, the fallback logic will pick the rule
type with the old ifdef ladder.

It's valid not to set a propagation rule if default_nan_mode is
enabled, because in that case there's no need to pick a NaN; all the
callers of pickNaN() catch this case and skip calling it.  So we can
already assert that we don't get into the "no rule defined" codepath
for our four targets which always set default_nan_mode: Hexagon,
RiscV, SH4 and Tricore, and for the one target which does not have FP
at all: avr.  These targets will not need to be updated to call
set_float_2nan_prop_rule().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Reindent means a couple of slightly long lines in comments,
but those will move again in a later patch, so seemed clearer to
not re-wrap the comment and then re-rewrap it later.
---
 include/fpu/softfloat-helpers.h |  11 ++
 include/fpu/softfloat-types.h   |  42 ++++++
 fpu/softfloat-specialize.c.inc  | 229 ++++++++++++++++++--------------
 3 files changed, 185 insertions(+), 97 deletions(-)

diff --git a/include/fpu/softfloat-helpers.h b/include/fpu/softfloat-helpers.h
index 94cbe073ec5..453188de70b 100644
--- a/include/fpu/softfloat-helpers.h
+++ b/include/fpu/softfloat-helpers.h
@@ -75,6 +75,12 @@ static inline void set_floatx80_rounding_precision(FloatX80RoundPrec val,
     status->floatx80_rounding_precision = val;
 }
 
+static inline void set_float_2nan_prop_rule(Float2NaNPropRule rule,
+                                            float_status *status)
+{
+    status->float_2nan_prop_rule = rule;
+}
+
 static inline void set_flush_to_zero(bool val, float_status *status)
 {
     status->flush_to_zero = val;
@@ -126,6 +132,11 @@ get_floatx80_rounding_precision(float_status *status)
     return status->floatx80_rounding_precision;
 }
 
+static inline Float2NaNPropRule get_float_2nan_prop_rule(float_status *status)
+{
+    return status->float_2nan_prop_rule;
+}
+
 static inline bool get_flush_to_zero(float_status *status)
 {
     return status->flush_to_zero;
diff --git a/include/fpu/softfloat-types.h b/include/fpu/softfloat-types.h
index 0884ec4ef7a..5cd5a0d0ae1 100644
--- a/include/fpu/softfloat-types.h
+++ b/include/fpu/softfloat-types.h
@@ -170,6 +170,47 @@ typedef enum __attribute__((__packed__)) {
     floatx80_precision_s,
 } FloatX80RoundPrec;
 
+/*
+ * 2-input NaN propagation rule. Individual architectures have
+ * different rules for which input NaN is propagated to the output
+ * when there is more than one NaN on the input.
+ *
+ * If default_nan_mode is enabled then it is valid not to set a
+ * NaN propagation rule, because the softfloat code guarantees
+ * not to try to pick a NaN to propagate in default NaN mode.
+ *
+ * For transition, currently the 'none' rule will cause us to
+ * fall back to picking the propagation rule based on the existing
+ * ifdef ladder. When all targets are converted it will be an error
+ * not to set the rule in float_status unless in default_nan_mode,
+ * and we will assert if we need to handle an input NaN and no
+ * rule was selected.
+ */
+typedef enum __attribute__((__packed__)) {
+    /* No propagation rule specified */
+    float_2nan_prop_none = 0,
+    /* Prefer SNaN over QNaN, then operand A over B */
+    float_2nan_prop_s_ab,
+    /* Prefer SNaN over QNaN, then operand B over A */
+    float_2nan_prop_s_ba,
+    /* Prefer A over B regardless of SNaN vs QNaN */
+    float_2nan_prop_ab,
+    /* Prefer B over A regardless of SNaN vs QNaN */
+    float_2nan_prop_ba,
+    /*
+     * This implements x87 NaN propagation rules:
+     * SNaN + QNaN => return the QNaN
+     * two SNaNs => return the one with the larger significand, silenced
+     * two QNaNs => return the one with the larger significand
+     * SNaN and a non-NaN => return the SNaN, silenced
+     * QNaN and a non-NaN => return the QNaN
+     *
+     * If we get down to comparing significands and they are the same,
+     * return the NaN with the positive sign bit (if any).
+     */
+    float_2nan_prop_x87,
+} Float2NaNPropRule;
+
 /*
  * Floating Point Status. Individual architectures may maintain
  * several versions of float_status for different functions. The
@@ -181,6 +222,7 @@ typedef struct float_status {
     uint16_t float_exception_flags;
     FloatRoundMode float_rounding_mode;
     FloatX80RoundPrec floatx80_rounding_precision;
+    Float2NaNPropRule float_2nan_prop_rule;
     bool tininess_before_rounding;
     /* should denormalised results go to zero and set the inexact flag? */
     bool flush_to_zero;
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index 4e279b9bc40..fae6794a152 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -390,118 +390,153 @@ bool float32_is_signaling_nan(float32 a_, float_status *status)
 static int pickNaN(FloatClass a_cls, FloatClass b_cls,
                    bool aIsLargerSignificand, float_status *status)
 {
-#if defined(TARGET_ARM) || defined(TARGET_MIPS) || defined(TARGET_HPPA) || \
-    defined(TARGET_LOONGARCH64) || defined(TARGET_S390X)
-    /* ARM mandated NaN propagation rules (see FPProcessNaNs()), take
-     * the first of:
-     *  1. A if it is signaling
-     *  2. B if it is signaling
-     *  3. A (quiet)
-     *  4. B (quiet)
-     * A signaling NaN is always quietened before returning it.
-     */
-    /* According to MIPS specifications, if one of the two operands is
-     * a sNaN, a new qNaN has to be generated. This is done in
-     * floatXX_silence_nan(). For qNaN inputs the specifications
-     * says: "When possible, this QNaN result is one of the operand QNaN
-     * values." In practice it seems that most implementations choose
-     * the first operand if both operands are qNaN. In short this gives
-     * the following rules:
-     *  1. A if it is signaling
-     *  2. B if it is signaling
-     *  3. A (quiet)
-     *  4. B (quiet)
-     * A signaling NaN is always silenced before returning it.
-     */
-    if (is_snan(a_cls)) {
-        return 0;
-    } else if (is_snan(b_cls)) {
-        return 1;
-    } else if (is_qnan(a_cls)) {
-        return 0;
-    } else {
-        return 1;
-    }
-#elif defined(TARGET_PPC) || defined(TARGET_M68K)
-    /* PowerPC propagation rules:
-     *  1. A if it sNaN or qNaN
-     *  2. B if it sNaN or qNaN
-     * A signaling NaN is always silenced before returning it.
-     */
-    /* M68000 FAMILY PROGRAMMER'S REFERENCE MANUAL
-     * 3.4 FLOATING-POINT INSTRUCTION DETAILS
-     * If either operand, but not both operands, of an operation is a
-     * nonsignaling NaN, then that NaN is returned as the result. If both
-     * operands are nonsignaling NaNs, then the destination operand
-     * nonsignaling NaN is returned as the result.
-     * If either operand to an operation is a signaling NaN (SNaN), then the
-     * SNaN bit is set in the FPSR EXC byte. If the SNaN exception enable bit
-     * is set in the FPCR ENABLE byte, then the exception is taken and the
-     * destination is not modified. If the SNaN exception enable bit is not
-     * set, setting the SNaN bit in the operand to a one converts the SNaN to
-     * a nonsignaling NaN. The operation then continues as described in the
-     * preceding paragraph for nonsignaling NaNs.
-     */
-    if (is_nan(a_cls)) {
-        return 0;
-    } else {
-        return 1;
-    }
-#elif defined(TARGET_SPARC)
-    /* Prefer SNaN over QNaN, order B then A. */
-    if (is_snan(b_cls)) {
-        return 1;
-    } else if (is_snan(a_cls)) {
-        return 0;
-    } else if (is_qnan(b_cls)) {
-        return 1;
-    } else {
-        return 0;
-    }
-#elif defined(TARGET_XTENSA)
+    Float2NaNPropRule rule = status->float_2nan_prop_rule;
+
     /*
-     * Xtensa has two NaN propagation modes.
-     * Which one is active is controlled by float_status::use_first_nan.
+     * We guarantee not to require the target to tell us how to
+     * pick a NaN if we're always returning the default NaN.
      */
-    if (status->use_first_nan) {
+    assert(!status->default_nan_mode);
+
+    if (rule == float_2nan_prop_none) {
+        /* target didn't set the rule: fall back to old ifdef choices */
+#if defined(TARGET_AVR) || defined(TARGET_HEXAGON) \
+    || defined(TARGET_RISCV) || defined(TARGET_SH4) \
+    || defined(TARGET_TRICORE)
+        g_assert_not_reached();
+#elif defined(TARGET_ARM) || defined(TARGET_MIPS) || defined(TARGET_HPPA) || \
+    defined(TARGET_LOONGARCH64) || defined(TARGET_S390X)
+        /*
+         * ARM mandated NaN propagation rules (see FPProcessNaNs()), take
+         * the first of:
+         *  1. A if it is signaling
+         *  2. B if it is signaling
+         *  3. A (quiet)
+         *  4. B (quiet)
+         * A signaling NaN is always quietened before returning it.
+         */
+        /*
+         * According to MIPS specifications, if one of the two operands is
+         * a sNaN, a new qNaN has to be generated. This is done in
+         * floatXX_silence_nan(). For qNaN inputs the specifications
+         * says: "When possible, this QNaN result is one of the operand QNaN
+         * values." In practice it seems that most implementations choose
+         * the first operand if both operands are qNaN. In short this gives
+         * the following rules:
+         *  1. A if it is signaling
+         *  2. B if it is signaling
+         *  3. A (quiet)
+         *  4. B (quiet)
+         * A signaling NaN is always silenced before returning it.
+         */
+        rule = float_2nan_prop_s_ab;
+#elif defined(TARGET_PPC) || defined(TARGET_M68K)
+        /*
+         * PowerPC propagation rules:
+         *  1. A if it sNaN or qNaN
+         *  2. B if it sNaN or qNaN
+         * A signaling NaN is always silenced before returning it.
+         */
+        /*
+         * M68000 FAMILY PROGRAMMER'S REFERENCE MANUAL
+         * 3.4 FLOATING-POINT INSTRUCTION DETAILS
+         * If either operand, but not both operands, of an operation is a
+         * nonsignaling NaN, then that NaN is returned as the result. If both
+         * operands are nonsignaling NaNs, then the destination operand
+         * nonsignaling NaN is returned as the result.
+         * If either operand to an operation is a signaling NaN (SNaN), then the
+         * SNaN bit is set in the FPSR EXC byte. If the SNaN exception enable bit
+         * is set in the FPCR ENABLE byte, then the exception is taken and the
+         * destination is not modified. If the SNaN exception enable bit is not
+         * set, setting the SNaN bit in the operand to a one converts the SNaN to
+         * a nonsignaling NaN. The operation then continues as described in the
+         * preceding paragraph for nonsignaling NaNs.
+         */
+        rule = float_2nan_prop_ab;
+#elif defined(TARGET_SPARC)
+        /* Prefer SNaN over QNaN, order B then A. */
+        rule = float_2nan_prop_s_ba;
+#elif defined(TARGET_XTENSA)
+        /*
+         * Xtensa has two NaN propagation modes.
+         * Which one is active is controlled by float_status::use_first_nan.
+         */
+        if (status->use_first_nan) {
+            rule = float_2nan_prop_ab;
+        } else {
+            rule = float_2nan_prop_ba;
+        }
+#else
+        rule = float_2nan_prop_x87;
+#endif
+    }
+
+    switch (rule) {
+    case float_2nan_prop_s_ab:
+        if (is_snan(a_cls)) {
+            return 0;
+        } else if (is_snan(b_cls)) {
+            return 1;
+        } else if (is_qnan(a_cls)) {
+            return 0;
+        } else {
+            return 1;
+        }
+        break;
+    case float_2nan_prop_s_ba:
+        if (is_snan(b_cls)) {
+            return 1;
+        } else if (is_snan(a_cls)) {
+            return 0;
+        } else if (is_qnan(b_cls)) {
+            return 1;
+        } else {
+            return 0;
+        }
+        break;
+    case float_2nan_prop_ab:
         if (is_nan(a_cls)) {
             return 0;
         } else {
             return 1;
         }
-    } else {
+        break;
+    case float_2nan_prop_ba:
         if (is_nan(b_cls)) {
             return 1;
         } else {
             return 0;
         }
-    }
-#else
-    /* This implements x87 NaN propagation rules:
-     * SNaN + QNaN => return the QNaN
-     * two SNaNs => return the one with the larger significand, silenced
-     * two QNaNs => return the one with the larger significand
-     * SNaN and a non-NaN => return the SNaN, silenced
-     * QNaN and a non-NaN => return the QNaN
-     *
-     * If we get down to comparing significands and they are the same,
-     * return the NaN with the positive sign bit (if any).
-     */
-    if (is_snan(a_cls)) {
-        if (is_snan(b_cls)) {
-            return aIsLargerSignificand ? 0 : 1;
-        }
-        return is_qnan(b_cls) ? 1 : 0;
-    } else if (is_qnan(a_cls)) {
-        if (is_snan(b_cls) || !is_qnan(b_cls)) {
-            return 0;
+        break;
+    case float_2nan_prop_x87:
+        /*
+         * This implements x87 NaN propagation rules:
+         * SNaN + QNaN => return the QNaN
+         * two SNaNs => return the one with the larger significand, silenced
+         * two QNaNs => return the one with the larger significand
+         * SNaN and a non-NaN => return the SNaN, silenced
+         * QNaN and a non-NaN => return the QNaN
+         *
+         * If we get down to comparing significands and they are the same,
+         * return the NaN with the positive sign bit (if any).
+         */
+        if (is_snan(a_cls)) {
+            if (is_snan(b_cls)) {
+                return aIsLargerSignificand ? 0 : 1;
+            }
+            return is_qnan(b_cls) ? 1 : 0;
+        } else if (is_qnan(a_cls)) {
+            if (is_snan(b_cls) || !is_qnan(b_cls)) {
+                return 0;
+            } else {
+                return aIsLargerSignificand ? 0 : 1;
+            }
         } else {
-            return aIsLargerSignificand ? 0 : 1;
+            return 1;
         }
-    } else {
-        return 1;
+    default:
+        g_assert_not_reached();
     }
-#endif
 }
 
 /*----------------------------------------------------------------------------
-- 
2.34.1


