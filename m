Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA483D690FD
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 10:49:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGc1F-0004GO-Dy; Thu, 28 Nov 2024 05:45:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tGbzj-00027W-9p
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 05:43:39 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tGbzb-0000a7-Or
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 05:43:33 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-434a14d6bf4so5938205e9.1
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2024 02:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732790605; x=1733395405; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BAfGDHXWne3fztjzcjDJwPhcKYYDiakCa5ET2Yl4WTw=;
 b=VrRPoMb/jO4y6fBlYQRPZPo81u/2lIz0K3phwQyQAiKSVeKiuihjj8/sO4st4B1FKP
 9GBUXd0pECVk+LWackB2YmgxQD5g58PdDqvUpU7cp2kzywGi8GGjV/SB+mugLxgsEphz
 WcZLLmfXsOGh0Cpj6izajD72EWMVa6g1h89zjCBHzJJKCUS47FmOcZ0lCYVnHzaYQ6Ws
 L3C0eEnwKgDtVjf19gAQhQCiIDAaT1ZqiddHPdKRcT1uiIA9GJnPutgMhn60wBFEHneC
 ndAXUY00T3LRsndF002YgDTaQroFu84e3Z+EsJ3aJmqwiklI1m58TT2Mt4821zgwn968
 0JdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732790605; x=1733395405;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BAfGDHXWne3fztjzcjDJwPhcKYYDiakCa5ET2Yl4WTw=;
 b=HzOSeSpIP9SFTZU44BNBnNxJer/lFItNrVpVJNg7IYe4VPWDDl2bH0aIQjvkhqoLkC
 j+DB0QSF9ytCB/RCeQ4llgAQH6Auyc1HvQB06PVcAUXkmFuB7LynaxD3ci4HtEhvpz/D
 oJet9w/TeOJrodF0x5vlZbUGQWdj0kSoasoMfFnMKQaFA2182GVthqy28von/M1jlvnf
 N9dnyqJG72WJ3FdAXp7IivCKwUOa1EyQo9MlG6lTuG8ouVr/5nQuWdJfqhqa37yH4tfl
 a0zwlTuUvqydQSQ68cmXdkzIOf+VacEsjdt5YjVMbjf7WAPWszfz9OgVg0tkZM40F1VD
 mrCg==
X-Gm-Message-State: AOJu0YzuSLiJTPRsLqYaHXHg2qA8ZSpVd20aSiQu4hq19RhIEiNJ1v/Z
 xjyeO8WHWcP5N1bkMlm6aKYVi7h++v58pYvOaG44esbJOoF/IIMuuR466egjzsD5DXRzcfpi/Xg
 M
X-Gm-Gg: ASbGncs/5m+YcSg4IUL365hdEJ16zIq3zraldKpdstxTJXEDd7FtLZBtvEJN9GF2kTu
 w9KHgixM7U/oenwxV+scKeUEi8kSVJzfdTVgpvWGd6eN+TZLbFMheufDaH1N8niMQUdUFrf/NjV
 x583UbZ7yq2S8Y13Zf6ZP1BSljg0NzUAxhpRfPl6p9Soy+6QdQIAQKoRgrsoB/IMOWEbxQSBdwO
 KoqofH8tmBKFUuTCquo6JLHz9qSSjmXpbrM8Jgmck+hGomK0rjsVmA=
X-Google-Smtp-Source: AGHT+IF9NBOcitC4nIP+QcER1/u30JABGG9B8fbDoXJRqPKqrPkYIpnhfRfjvnQEOI1z2Tf/I2u4sg==
X-Received: by 2002:a5d:6487:0:b0:382:5030:7b94 with SMTP id
 ffacd0b85a97d-385c6eb8f37mr4826560f8f.13.1732790605524; 
 Thu, 28 Nov 2024 02:43:25 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385ccd68958sm1292959f8f.67.2024.11.28.02.43.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 02:43:25 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH for-10.0 14/25] softfloat: Allow runtime choice of NaN
 propagation for muladd
Date: Thu, 28 Nov 2024 10:42:59 +0000
Message-Id: <20241128104310.3452934-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241128104310.3452934-1-peter.maydell@linaro.org>
References: <20241128104310.3452934-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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
result if both operands of a 3-operand fused multiply-add operation
are NaNs.  As a result different architectures have ended up with
different rules for propagating NaNs.

QEMU currently hardcodes the NaN propagation logic into the binary
because pickNaNMulAdd() has an ifdef ladder for different targets.
We want to make the propagation rule instead be selectable at
runtime, because:
 * this will let us have multiple targets in one QEMU binary
 * the Arm FEAT_AFP architectural feature includes letting
   the guest select a NaN propagation rule at runtime

In this commit we add an enum for the propagation rule, the field in
float_status, and the corresponding getters and setters.  We change
pickNaNMulAdd to honour this, but because all targets still leave
this field at its default 0 value, the fallback logic will pick the
rule type with the old ifdef ladder.

It's valid not to set a propagation rule if default_nan_mode is
enabled, because in that case there's no need to pick a NaN; all the
callers of pickNaNMulAdd() catch this case and skip calling it.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/fpu/softfloat-helpers.h |  11 +++
 include/fpu/softfloat-types.h   |  37 ++++++++
 fpu/softfloat-specialize.c.inc  | 160 +++++++++++++-------------------
 3 files changed, 112 insertions(+), 96 deletions(-)

diff --git a/include/fpu/softfloat-helpers.h b/include/fpu/softfloat-helpers.h
index 0bf44dc6087..cf06b4e16bf 100644
--- a/include/fpu/softfloat-helpers.h
+++ b/include/fpu/softfloat-helpers.h
@@ -81,6 +81,12 @@ static inline void set_float_2nan_prop_rule(Float2NaNPropRule rule,
     status->float_2nan_prop_rule = rule;
 }
 
+static inline void set_float_3nan_prop_rule(Float3NaNPropRule rule,
+                                            float_status *status)
+{
+    status->float_3nan_prop_rule = rule;
+}
+
 static inline void set_float_infzeronan_rule(FloatInfZeroNaNRule rule,
                                              float_status *status)
 {
@@ -143,6 +149,11 @@ static inline Float2NaNPropRule get_float_2nan_prop_rule(float_status *status)
     return status->float_2nan_prop_rule;
 }
 
+static inline Float3NaNPropRule get_float_3nan_prop_rule(float_status *status)
+{
+    return status->float_3nan_prop_rule;
+}
+
 static inline FloatInfZeroNaNRule get_float_infzeronan_rule(float_status *status)
 {
     return status->float_infzeronan_rule;
diff --git a/include/fpu/softfloat-types.h b/include/fpu/softfloat-types.h
index 27a1c96754d..79220f8c67f 100644
--- a/include/fpu/softfloat-types.h
+++ b/include/fpu/softfloat-types.h
@@ -207,6 +207,42 @@ typedef enum __attribute__((__packed__)) {
     float_2nan_prop_x87,
 } Float2NaNPropRule;
 
+/*
+ * 3-input NaN propagation rule, for fused multiply-add. Individual
+ * architectures have different rules for which input NaN is
+ * propagated to the output when there is more than one NaN on the
+ * input.
+ *
+ * If default_nan_mode is enabled then it is valid not to set a NaN
+ * propagation rule, because the softfloat code guarantees not to try
+ * to pick a NaN to propagate in default NaN mode.  When not in
+ * default-NaN mode, it is an error for the target not to set the rule
+ * in float_status if it uses a muladd, and we will assert if we need
+ * to handle an input NaN and no rule was selected.
+ *
+ * For QEMU, the multiply-add operation is A * B + C.
+ *
+ * NB: we don't list all 12 possibilities here or implement them
+ * in pickNaNMulAdd; if your architecture needs one of the missing
+ * combinations you should add it.
+ */
+typedef enum __attribute__((__packed__)) {
+    /* No propagation rule specified */
+    float_3nan_prop_none = 0,
+    /* Prefer SNaN over QNaN, then operand A over B over C */
+    float_3nan_prop_s_abc,
+    /* Prefer SNaN over QNaN, then operand C over A over B */
+    float_3nan_prop_s_cab,
+    /* Prefer SNaN over QNaN, then operand C over B over A */
+    float_3nan_prop_s_cba,
+    /* Prefer A over B over C regardless of SNaN vs QNaN */
+    float_3nan_prop_abc,
+    /* Prefer A over C over B regardless of SNaN vs QNaN */
+    float_3nan_prop_acb,
+    /* Prefer C over B over A regardless of SNaN vs QNaN */
+    float_3nan_prop_cba,
+} Float3NaNPropRule;
+
 /*
  * Rule for result of fused multiply-add 0 * Inf + NaN.
  * This must be a NaN, but implementations differ on whether this
@@ -241,6 +277,7 @@ typedef struct float_status {
     FloatRoundMode float_rounding_mode;
     FloatX80RoundPrec floatx80_rounding_precision;
     Float2NaNPropRule float_2nan_prop_rule;
+    Float3NaNPropRule float_3nan_prop_rule;
     FloatInfZeroNaNRule float_infzeronan_rule;
     bool tininess_before_rounding;
     /* should denormalised results go to zero and set the inexact flag? */
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index 3e4ec938b25..d7c0c90ea65 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -475,6 +475,7 @@ static int pickNaN(FloatClass a_cls, FloatClass b_cls,
 static int pickNaNMulAdd(FloatClass a_cls, FloatClass b_cls, FloatClass c_cls,
                          bool infzero, float_status *status)
 {
+    Float3NaNPropRule rule = status->float_3nan_prop_rule;
     /*
      * We guarantee not to require the target to tell us how to
      * pick a NaN if we're always returning the default NaN.
@@ -500,27 +501,44 @@ static int pickNaNMulAdd(FloatClass a_cls, FloatClass b_cls, FloatClass c_cls,
         }
     }
 
+    if (rule == float_3nan_prop_none) {
 #if defined(TARGET_ARM)
-
-    /* This looks different from the ARM ARM pseudocode, because the ARM ARM
-     * puts the operands to a fused mac operation (a*b)+c in the order c,a,b.
-     */
-    if (is_snan(c_cls)) {
-        return 2;
-    } else if (is_snan(a_cls)) {
-        return 0;
-    } else if (is_snan(b_cls)) {
-        return 1;
-    } else if (is_qnan(c_cls)) {
-        return 2;
-    } else if (is_qnan(a_cls)) {
-        return 0;
-    } else {
-        return 1;
-    }
+        /*
+         * This looks different from the ARM ARM pseudocode, because the ARM ARM
+         * puts the operands to a fused mac operation (a*b)+c in the order c,a,b
+         */
+        rule = float_3nan_prop_s_cab;
 #elif defined(TARGET_MIPS)
-    if (snan_bit_is_one(status)) {
-        /* Prefer sNaN over qNaN, in the a, b, c order. */
+        if (snan_bit_is_one(status)) {
+            rule = float_3nan_prop_s_abc;
+        } else {
+            rule = float_3nan_prop_s_cab;
+        }
+#elif defined(TARGET_LOONGARCH64)
+        rule = float_3nan_prop_s_cab;
+#elif defined(TARGET_PPC)
+        /*
+         * If fRA is a NaN return it; otherwise if fRB is a NaN return it;
+         * otherwise return fRC. Note that muladd on PPC is (fRA * fRC) + frB
+         */
+        rule = float_3nan_prop_acb;
+#elif defined(TARGET_S390X)
+        rule = float_3nan_prop_s_abc;
+#elif defined(TARGET_SPARC)
+        rule = float_3nan_prop_s_cba;
+#elif defined(TARGET_XTENSA)
+        if (status->use_first_nan) {
+            rule = float_3nan_prop_abc;
+        } else {
+            rule = float_3nan_prop_cba;
+        }
+#else
+        rule = float_3nan_prop_abc;
+#endif
+    }
+
+    switch (rule) {
+    case float_3nan_prop_s_abc:
         if (is_snan(a_cls)) {
             return 0;
         } else if (is_snan(b_cls)) {
@@ -534,8 +552,7 @@ static int pickNaNMulAdd(FloatClass a_cls, FloatClass b_cls, FloatClass c_cls,
         } else {
             return 2;
         }
-    } else {
-        /* Prefer sNaN over qNaN, in the c, a, b order. */
+    case float_3nan_prop_s_cab:
         if (is_snan(c_cls)) {
             return 2;
         } else if (is_snan(a_cls)) {
@@ -549,68 +566,21 @@ static int pickNaNMulAdd(FloatClass a_cls, FloatClass b_cls, FloatClass c_cls,
         } else {
             return 1;
         }
-    }
-#elif defined(TARGET_LOONGARCH64)
-    /* Prefer sNaN over qNaN, in the c, a, b order. */
-    if (is_snan(c_cls)) {
-        return 2;
-    } else if (is_snan(a_cls)) {
-        return 0;
-    } else if (is_snan(b_cls)) {
-        return 1;
-    } else if (is_qnan(c_cls)) {
-        return 2;
-    } else if (is_qnan(a_cls)) {
-        return 0;
-    } else {
-        return 1;
-    }
-#elif defined(TARGET_PPC)
-    /* If fRA is a NaN return it; otherwise if fRB is a NaN return it;
-     * otherwise return fRC. Note that muladd on PPC is (fRA * fRC) + frB
-     */
-    if (is_nan(a_cls)) {
-        return 0;
-    } else if (is_nan(c_cls)) {
-        return 2;
-    } else {
-        return 1;
-    }
-#elif defined(TARGET_S390X)
-    if (is_snan(a_cls)) {
-        return 0;
-    } else if (is_snan(b_cls)) {
-        return 1;
-    } else if (is_snan(c_cls)) {
-        return 2;
-    } else if (is_qnan(a_cls)) {
-        return 0;
-    } else if (is_qnan(b_cls)) {
-        return 1;
-    } else {
-        return 2;
-    }
-#elif defined(TARGET_SPARC)
-    /* Prefer SNaN over QNaN, order C, B, A. */
-    if (is_snan(c_cls)) {
-        return 2;
-    } else if (is_snan(b_cls)) {
-        return 1;
-    } else if (is_snan(a_cls)) {
-        return 0;
-    } else if (is_qnan(c_cls)) {
-        return 2;
-    } else if (is_qnan(b_cls)) {
-        return 1;
-    } else {
-        return 0;
-    }
-#elif defined(TARGET_XTENSA)
-    /*
-     * For Xtensa, the (inf,zero,nan) case sets InvalidOp and returns
-     * an input NaN if we have one (ie c).
-     */
-    if (status->use_first_nan) {
+    case float_3nan_prop_s_cba:
+        if (is_snan(c_cls)) {
+            return 2;
+        } else if (is_snan(b_cls)) {
+            return 1;
+        } else if (is_snan(a_cls)) {
+            return 0;
+        } else if (is_qnan(c_cls)) {
+            return 2;
+        } else if (is_qnan(b_cls)) {
+            return 1;
+        } else {
+            return 0;
+        }
+    case float_3nan_prop_abc:
         if (is_nan(a_cls)) {
             return 0;
         } else if (is_nan(b_cls)) {
@@ -618,7 +588,15 @@ static int pickNaNMulAdd(FloatClass a_cls, FloatClass b_cls, FloatClass c_cls,
         } else {
             return 2;
         }
-    } else {
+    case float_3nan_prop_acb:
+        if (is_nan(a_cls)) {
+            return 0;
+        } else if (is_nan(c_cls)) {
+            return 2;
+        } else {
+            return 1;
+        }
+    case float_3nan_prop_cba:
         if (is_nan(c_cls)) {
             return 2;
         } else if (is_nan(b_cls)) {
@@ -626,19 +604,9 @@ static int pickNaNMulAdd(FloatClass a_cls, FloatClass b_cls, FloatClass c_cls,
         } else {
             return 0;
         }
+    default:
+        g_assert_not_reached();
     }
-#else
-    /* A default implementation: prefer a to b to c.
-     * This is unlikely to actually match any real implementation.
-     */
-    if (is_nan(a_cls)) {
-        return 0;
-    } else if (is_nan(b_cls)) {
-        return 1;
-    } else {
-        return 2;
-    }
-#endif
 }
 
 /*----------------------------------------------------------------------------
-- 
2.34.1


