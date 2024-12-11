Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7960E7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:27:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPRn-00009u-SD; Wed, 11 Dec 2024 11:20:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPRl-00009C-Nb
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:20:22 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPRj-0007dP-Kw
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:20:21 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-434a7ee3d60so5197435e9.1
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733934018; x=1734538818; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+CHwXU6NrYplvrjpWt53iqb0JmQm6zXDsQafUaRrA+g=;
 b=IV6zNZ0lhiz9awDnfIJ+2JXfIrx9AdPPWpZhBlqDNEb8nSzNURW6v5t5tGWMPSOyTk
 m/q04l1DMdPlkCesN/8dPlxSf6yzMW6LMtnNLXFRF9KOLJa3Jl79sbtW3z4AVn1L8Jdc
 z87uNiWzLyiYfKePm9L5ANnPeRBX6G/M6gReCu/dZWOGOnSE7yXQVRPOMlf8hHzVmz/6
 cOQRYdumJ8o398gUACWLkZ8FIVprTfXNyNxaSG6h0zEnwC4A8Tts2uNujA7tLYrvS0yL
 VGSQwk1ivEgGB297bh+rZnqLeqqDiYU1Hse8zuE0xgcOC2yEr6AggqN2zgbuqY3ZGWKX
 yx+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934018; x=1734538818;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+CHwXU6NrYplvrjpWt53iqb0JmQm6zXDsQafUaRrA+g=;
 b=F9PJ39xrSsj+fAFRMbrDS0o8ld8VlyyqRGB2S6eiKI465EzQ2uu8KaerrC0vmtKfqk
 Ac8Dwcuc9F1q2VZk3uDrVI7Bx+Gtd29HigkCP0i9sS0u9isIa098CjIE8QNhqNv64Cp0
 86KuNT5dWmbU7jiKHvTLWFd7T9Wk7efkl3pfH/8sLiXfhpNLurJCrZDAdNGUSRMwT/G3
 0i8ZPDEGiLAPCeFDQBi6VpGbzcl+QxjSMURm7CMbeeXFwcppbMX7FygB8J53HcrpMvzs
 pseDmRgbLc4MXBc9OVA6LLI+18WpvAOaH8kW3HzMNq+8/HZxfamW9bRpzkyRHK/GKJxx
 cy4Q==
X-Gm-Message-State: AOJu0YyfT2mwW/05jaUw87Z+x4Gv7hDaw5C2nPWiGstP6zwz5vmNe0eo
 dyksmZQLKPcTs929sdpS19F7FE7+8JD4skSPtEFDxAevw4Itg94KK6/9XaJCef0yJbt41eCVhtX
 5
X-Gm-Gg: ASbGncvA6t+T+bLoSIxabbkRgz+01i2OiwkQ+P1iga3i7y0yry6CsHjCXyMBhBDqtzn
 S+ZDMf1qnkl1l1I2hmwtkj/EZRVA8Amnj8ZnYbas17SkHNdqecFfylw8jd0rplakT2XY53hLgfO
 TkDA6IWT9E15YS0QnKBG1S5cek+o0CEmcY+88b6rof31mF282LSraaZYwAf62tm3hqdC9hCxbYM
 MISiueBCQ2+etWckOcROrlMsnfs24yzGGpWedXphSozDqGdP7Cl9Q7aplAy
X-Google-Smtp-Source: AGHT+IHC3XcTcgtfs8M94BJQ+8EbFDz/35weS/nTYvquBq8P8LnbNV0DuPniGEsWug5OpB4+YFeLiw==
X-Received: by 2002:a05:600c:5904:b0:436:1b77:b5aa with SMTP id
 5b1f17b1804b1-4361c5b184dmr25400445e9.8.1733934018016; 
 Wed, 11 Dec 2024 08:20:18 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434f4dfdcdfsm121460595e9.39.2024.12.11.08.20.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:20:17 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/72] softfloat: Allow runtime choice of inf * 0 + NaN result
Date: Wed, 11 Dec 2024 16:19:00 +0000
Message-Id: <20241211162004.2795499-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211162004.2795499-1-peter.maydell@linaro.org>
References: <20241211162004.2795499-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

IEEE 758 does not define a fixed rule for what NaN to return in
the case of a fused multiply-add of inf * 0 + NaN. Different
architectures thus do different things:
 * some return the default NaN
 * some return the input NaN
 * Arm returns the default NaN if the input NaN is quiet,
   and the input NaN if it is signalling

We want to make this logic be runtime selected rather than
hardcoded into the binary, because:
 * this will let us have multiple targets in one QEMU binary
 * the Arm FEAT_AFP architectural feature includes letting
   the guest select a NaN propagation rule at runtime

In this commit we add an enum for the propagation rule, the field in
float_status, and the corresponding getters and setters.  We change
pickNaNMulAdd to honour this, but because all targets still leave
this field at its default 0 value, the fallback logic will pick the
rule type with the old ifdef ladder.

Note that four architectures both use the muladd softfloat functions
and did not have a branch of the ifdef ladder to specify their
behaviour (and so were ending up with the "default" case, probably
wrongly): i386, HPPA, SH4 and Tricore.  SH4 and Tricore both set
default_nan_mode, and so will never get into pickNaNMulAdd().  For
HPPA and i386 we retain the same behaviour as the old default-case,
which is to not ever return the default NaN.  This might not be
correct but it is not a behaviour change.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241202131347.498124-4-peter.maydell@linaro.org
---
 include/fpu/softfloat-helpers.h | 11 ++++
 include/fpu/softfloat-types.h   | 23 +++++++++
 fpu/softfloat-specialize.c.inc  | 91 ++++++++++++++++++++++-----------
 3 files changed, 95 insertions(+), 30 deletions(-)

diff --git a/include/fpu/softfloat-helpers.h b/include/fpu/softfloat-helpers.h
index 453188de70b..0bf44dc6087 100644
--- a/include/fpu/softfloat-helpers.h
+++ b/include/fpu/softfloat-helpers.h
@@ -81,6 +81,12 @@ static inline void set_float_2nan_prop_rule(Float2NaNPropRule rule,
     status->float_2nan_prop_rule = rule;
 }
 
+static inline void set_float_infzeronan_rule(FloatInfZeroNaNRule rule,
+                                             float_status *status)
+{
+    status->float_infzeronan_rule = rule;
+}
+
 static inline void set_flush_to_zero(bool val, float_status *status)
 {
     status->flush_to_zero = val;
@@ -137,6 +143,11 @@ static inline Float2NaNPropRule get_float_2nan_prop_rule(float_status *status)
     return status->float_2nan_prop_rule;
 }
 
+static inline FloatInfZeroNaNRule get_float_infzeronan_rule(float_status *status)
+{
+    return status->float_infzeronan_rule;
+}
+
 static inline bool get_flush_to_zero(float_status *status)
 {
     return status->flush_to_zero;
diff --git a/include/fpu/softfloat-types.h b/include/fpu/softfloat-types.h
index 8f39691dfd0..47bb22c4e25 100644
--- a/include/fpu/softfloat-types.h
+++ b/include/fpu/softfloat-types.h
@@ -207,6 +207,28 @@ typedef enum __attribute__((__packed__)) {
     float_2nan_prop_x87,
 } Float2NaNPropRule;
 
+/*
+ * Rule for result of fused multiply-add 0 * Inf + NaN.
+ * This must be a NaN, but implementations differ on whether this
+ * is the input NaN or the default NaN.
+ *
+ * You don't need to set this if default_nan_mode is enabled.
+ * When not in default-NaN mode, it is an error for the target
+ * not to set the rule in float_status if it uses muladd, and we
+ * will assert if we need to handle an input NaN and no rule was
+ * selected.
+ */
+typedef enum __attribute__((__packed__)) {
+    /* No propagation rule specified */
+    float_infzeronan_none = 0,
+    /* Result is never the default NaN (so always the input NaN) */
+    float_infzeronan_dnan_never,
+    /* Result is always the default NaN */
+    float_infzeronan_dnan_always,
+    /* Result is the default NaN if the input NaN is quiet */
+    float_infzeronan_dnan_if_qnan,
+} FloatInfZeroNaNRule;
+
 /*
  * Floating Point Status. Individual architectures may maintain
  * several versions of float_status for different functions. The
@@ -219,6 +241,7 @@ typedef struct float_status {
     FloatRoundMode float_rounding_mode;
     FloatX80RoundPrec floatx80_rounding_precision;
     Float2NaNPropRule float_2nan_prop_rule;
+    FloatInfZeroNaNRule float_infzeronan_rule;
     bool tininess_before_rounding;
     /* should denormalised results go to zero and set the inexact flag? */
     bool flush_to_zero;
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index 81a67eb67b5..f5b422e07b5 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -475,6 +475,8 @@ static int pickNaN(FloatClass a_cls, FloatClass b_cls,
 static int pickNaNMulAdd(FloatClass a_cls, FloatClass b_cls, FloatClass c_cls,
                          bool infzero, float_status *status)
 {
+    FloatInfZeroNaNRule rule = status->float_infzeronan_rule;
+
     /*
      * We guarantee not to require the target to tell us how to
      * pick a NaN if we're always returning the default NaN.
@@ -482,14 +484,68 @@ static int pickNaNMulAdd(FloatClass a_cls, FloatClass b_cls, FloatClass c_cls,
      * specify.
      */
     assert(!status->default_nan_mode);
+
+    if (rule == float_infzeronan_none) {
+        /*
+         * Temporarily fall back to ifdef ladder
+         */
 #if defined(TARGET_ARM)
-    /* For ARM, the (inf,zero,qnan) case sets InvalidOp and returns
-     * the default NaN
-     */
-    if (infzero && is_qnan(c_cls)) {
-        return 3;
+        /*
+         * For ARM, the (inf,zero,qnan) case returns the default NaN,
+         * but (inf,zero,snan) returns the input NaN.
+         */
+        rule = float_infzeronan_dnan_if_qnan;
+#elif defined(TARGET_MIPS)
+        if (snan_bit_is_one(status)) {
+            /*
+             * For MIPS systems that conform to IEEE754-1985, the (inf,zero,nan)
+             * case sets InvalidOp and returns the default NaN
+             */
+            rule = float_infzeronan_dnan_always;
+        } else {
+            /*
+             * For MIPS systems that conform to IEEE754-2008, the (inf,zero,nan)
+             * case sets InvalidOp and returns the input value 'c'
+             */
+            rule = float_infzeronan_dnan_never;
+        }
+#elif defined(TARGET_PPC) || defined(TARGET_SPARC) || \
+    defined(TARGET_XTENSA) || defined(TARGET_HPPA) || \
+    defined(TARGET_I386) || defined(TARGET_LOONGARCH)
+        /*
+         * For LoongArch systems that conform to IEEE754-2008, the (inf,zero,nan)
+         * case sets InvalidOp and returns the input value 'c'
+         */
+        /*
+         * For PPC, the (inf,zero,qnan) case sets InvalidOp, but we prefer
+         * to return an input NaN if we have one (ie c) rather than generating
+         * a default NaN
+         */
+        rule = float_infzeronan_dnan_never;
+#elif defined(TARGET_S390X)
+        rule = float_infzeronan_dnan_always;
+#endif
     }
 
+    if (infzero) {
+        /*
+         * Inf * 0 + NaN -- some implementations return the default NaN here,
+         * and some return the input NaN.
+         */
+        switch (rule) {
+        case float_infzeronan_dnan_never:
+            return 2;
+        case float_infzeronan_dnan_always:
+            return 3;
+        case float_infzeronan_dnan_if_qnan:
+            return is_qnan(c_cls) ? 3 : 2;
+        default:
+            g_assert_not_reached();
+        }
+    }
+
+#if defined(TARGET_ARM)
+
     /* This looks different from the ARM ARM pseudocode, because the ARM ARM
      * puts the operands to a fused mac operation (a*b)+c in the order c,a,b.
      */
@@ -508,13 +564,6 @@ static int pickNaNMulAdd(FloatClass a_cls, FloatClass b_cls, FloatClass c_cls,
     }
 #elif defined(TARGET_MIPS)
     if (snan_bit_is_one(status)) {
-        /*
-         * For MIPS systems that conform to IEEE754-1985, the (inf,zero,nan)
-         * case sets InvalidOp and returns the default NaN
-         */
-        if (infzero) {
-            return 3;
-        }
         /* Prefer sNaN over qNaN, in the a, b, c order. */
         if (is_snan(a_cls)) {
             return 0;
@@ -530,10 +579,6 @@ static int pickNaNMulAdd(FloatClass a_cls, FloatClass b_cls, FloatClass c_cls,
             return 2;
         }
     } else {
-        /*
-         * For MIPS systems that conform to IEEE754-2008, the (inf,zero,nan)
-         * case sets InvalidOp and returns the input value 'c'
-         */
         /* Prefer sNaN over qNaN, in the c, a, b order. */
         if (is_snan(c_cls)) {
             return 2;
@@ -550,11 +595,6 @@ static int pickNaNMulAdd(FloatClass a_cls, FloatClass b_cls, FloatClass c_cls,
         }
     }
 #elif defined(TARGET_LOONGARCH64)
-    /*
-     * For LoongArch systems that conform to IEEE754-2008, the (inf,zero,nan)
-     * case sets InvalidOp and returns the input value 'c'
-     */
-
     /* Prefer sNaN over qNaN, in the c, a, b order. */
     if (is_snan(c_cls)) {
         return 2;
@@ -570,11 +610,6 @@ static int pickNaNMulAdd(FloatClass a_cls, FloatClass b_cls, FloatClass c_cls,
         return 1;
     }
 #elif defined(TARGET_PPC)
-    /* For PPC, the (inf,zero,qnan) case sets InvalidOp, but we prefer
-     * to return an input NaN if we have one (ie c) rather than generating
-     * a default NaN
-     */
-
     /* If fRA is a NaN return it; otherwise if fRB is a NaN return it;
      * otherwise return fRC. Note that muladd on PPC is (fRA * fRC) + frB
      */
@@ -586,10 +621,6 @@ static int pickNaNMulAdd(FloatClass a_cls, FloatClass b_cls, FloatClass c_cls,
         return 1;
     }
 #elif defined(TARGET_S390X)
-    if (infzero) {
-        return 3;
-    }
-
     if (is_snan(a_cls)) {
         return 0;
     } else if (is_snan(b_cls)) {
-- 
2.34.1


