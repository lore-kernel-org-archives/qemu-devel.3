Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 674EDD78322
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 13:40:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI6WE-0005SO-2E; Mon, 02 Dec 2024 08:31:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI6Gl-0002cB-4k
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:15:23 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI6GW-0003EO-Tw
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:15:18 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-434aa472617so35656365e9.3
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 05:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733145255; x=1733750055; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z7XmwuWfuj/+3cn8NxGnH6Ft8d9tN3X6vv1sP/vbV6k=;
 b=gc7cwTmxwENJwy96Pv4kUeuVIH8eyjuz1DMfFItx78n8TuyS7GfCkbidWwUPkNqqw8
 zIHDoNmURIDgGGB8tTVU33hQFcmk1RijfiLNT0rUZKv7xqsoUWps8KHpic1W4RjWwME+
 283kYazrUjIO0Xr0Chwf9pjjQLKUROhJNMDaIGEHYNl/Q4M4RM0FsS5d+AUuspbs3h/l
 j+5DbqaG3hPbG3XefZ0pKKHkbVKmfL18WlZlN2AihQODAyKPjIMBb0lAxl1qPNateDBV
 WF0/4JAQaMCWVY2tmMbrFXRFd+EzTILb3oMoD57eDiz1LR0LcJtbpAihRYhiGIz4oy/q
 QgUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733145255; x=1733750055;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z7XmwuWfuj/+3cn8NxGnH6Ft8d9tN3X6vv1sP/vbV6k=;
 b=ZMS5eOCS1WqQKcTmiPv95VyWbmjOHYpSJ642BLknednZOu1LbONTEhsb8QdHy9gUlV
 ifKehwu2vFWo3g5Pce4+lXcfGylmux1IkFk5qjgsLWc9ssYgz/NRgVgvfnuwMz3wgOAC
 n4ufyIGgFg6uO1S4mmHWbanMDUUUotRHlbNDbEICLrOiV0S8Y5Q0lWXwCUqDwBA+SBob
 DKqlweluZVeBoc2gD5Xs7VfmTbG1b3YZvDA3yyuXPBQwjf4st8tjhKrtwORHABU7juiD
 ffMee8SoLbd5N+BFrizfsd63jiYZmgsgExkxMMt0hVC76JUfOnXnfWZ1tW1J8ncD94kg
 ZIaA==
X-Gm-Message-State: AOJu0Yyxeb96s7o409B+MYHJMjdmU3/2JL48wkZ3FlZn7uNLdquu3XKk
 2AZreWUDsgCAD11c5M11jbCj4xuzFRRZ9fxniD4LFiqFmlwUHgT0ZL0BRiZRry5pL3DnWHzvNVw
 a
X-Gm-Gg: ASbGncvWBtbomv7gI9obMn+BY9wq+56o53Qo4nOa82oZ8JNVImRQGNAD8LGY1yY4uSy
 paJsgi6gz9F1WOdM+Pq/BlMvJhNcW/FE+m9Afz5gIeFpSrXCUGCBaIzXVyTetxDecy10gTXRusF
 kMBkFpE5305jowxt127pOk0gezz4i00n1IS8VapF8bP6/3LtkCX417B7TmtXvJhx3m2pC8g3PkI
 18RmhaDx8yUR/RjcJQJyO8EFhUydS4Wee0g3zbnvGv/WukkrHehLlo=
X-Google-Smtp-Source: AGHT+IHuCgYLAC+G8pAY6KaNZRqdT6XuEHXiSzxTCFZDbws5goSdNGlJHHv/ugbET65/ZZ6ADDjoPA==
X-Received: by 2002:a05:6000:210f:b0:385:ee59:44eb with SMTP id
 ffacd0b85a97d-385ee5946d0mr4043467f8f.33.1733145254552; 
 Mon, 02 Dec 2024 05:14:14 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385dea1e4ebsm10160157f8f.1.2024.12.02.05.14.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2024 05:14:14 -0800 (PST)
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
Subject: [PATCH v2 for-10.0 15/54] softfloat: Allow runtime choice of NaN
 propagation for muladd
Date: Mon,  2 Dec 2024 13:13:08 +0000
Message-Id: <20241202131347.498124-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241202131347.498124-1-peter.maydell@linaro.org>
References: <20241202131347.498124-1-peter.maydell@linaro.org>
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
 include/fpu/softfloat-types.h   |  55 +++++++++++
 fpu/softfloat-specialize.c.inc  | 167 ++++++++------------------------
 3 files changed, 107 insertions(+), 126 deletions(-)

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
index 47bb22c4e25..d9f0797edaf 100644
--- a/include/fpu/softfloat-types.h
+++ b/include/fpu/softfloat-types.h
@@ -80,6 +80,8 @@ this code that are retained.
 #ifndef SOFTFLOAT_TYPES_H
 #define SOFTFLOAT_TYPES_H
 
+#include "hw/registerfields.h"
+
 /*
  * Software IEC/IEEE floating-point types.
  */
@@ -207,6 +209,58 @@ typedef enum __attribute__((__packed__)) {
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
+ * The naming scheme for Float3NaNPropRule values is:
+ *  float_3nan_prop_s_abc:
+ *    = "Prefer SNaN over QNaN, then operand A over B over C"
+ *  float_3nan_prop_abc:
+ *    = "Prefer A over B over C regardless of SNaN vs QNAN"
+ *
+ * For QEMU, the multiply-add operation is A * B + C.
+ */
+
+/*
+ * We set the Float3NaNPropRule enum values up so we can select the
+ * right value in pickNaNMulAdd in a data driven way.
+ */
+FIELD(3NAN, 1ST, 0, 2)   /* which operand is most preferred ? */
+FIELD(3NAN, 2ND, 2, 2)   /* which operand is next most preferred ? */
+FIELD(3NAN, 3RD, 4, 2)   /* which operand is least preferred ? */
+FIELD(3NAN, SNAN, 6, 1)  /* do we prefer SNaN over QNaN ? */
+
+#define PROPRULE(X, Y, Z) \
+    ((X << R_3NAN_1ST_SHIFT) | (Y << R_3NAN_2ND_SHIFT) | (Z << R_3NAN_3RD_SHIFT))
+
+typedef enum __attribute__((__packed__)) {
+    float_3nan_prop_none = 0,     /* No propagation rule specified */
+    float_3nan_prop_abc = PROPRULE(0, 1, 2),
+    float_3nan_prop_acb = PROPRULE(0, 2, 1),
+    float_3nan_prop_bac = PROPRULE(1, 0, 2),
+    float_3nan_prop_bca = PROPRULE(1, 2, 0),
+    float_3nan_prop_cab = PROPRULE(2, 0, 1),
+    float_3nan_prop_cba = PROPRULE(2, 1, 0),
+    float_3nan_prop_s_abc = float_3nan_prop_abc | R_3NAN_SNAN_MASK,
+    float_3nan_prop_s_acb = float_3nan_prop_acb | R_3NAN_SNAN_MASK,
+    float_3nan_prop_s_bac = float_3nan_prop_bac | R_3NAN_SNAN_MASK,
+    float_3nan_prop_s_bca = float_3nan_prop_bca | R_3NAN_SNAN_MASK,
+    float_3nan_prop_s_cab = float_3nan_prop_cab | R_3NAN_SNAN_MASK,
+    float_3nan_prop_s_cba = float_3nan_prop_cba | R_3NAN_SNAN_MASK,
+} Float3NaNPropRule;
+
+#undef PROPRULE
+
 /*
  * Rule for result of fused multiply-add 0 * Inf + NaN.
  * This must be a NaN, but implementations differ on whether this
@@ -241,6 +295,7 @@ typedef struct float_status {
     FloatRoundMode float_rounding_mode;
     FloatX80RoundPrec floatx80_rounding_precision;
     Float2NaNPropRule float_2nan_prop_rule;
+    Float3NaNPropRule float_3nan_prop_rule;
     FloatInfZeroNaNRule float_infzeronan_rule;
     bool tininess_before_rounding;
     /* should denormalised results go to zero and set the inexact flag? */
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index a769c71f545..b4f3f0efa82 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -475,6 +475,10 @@ static int pickNaN(FloatClass a_cls, FloatClass b_cls,
 static int pickNaNMulAdd(FloatClass a_cls, FloatClass b_cls, FloatClass c_cls,
                          bool infzero, bool have_snan, float_status *status)
 {
+    FloatClass cls[3] = { a_cls, b_cls, c_cls };
+    Float3NaNPropRule rule = status->float_3nan_prop_rule;
+    int which;
+
     /*
      * We guarantee not to require the target to tell us how to
      * pick a NaN if we're always returning the default NaN.
@@ -500,145 +504,56 @@ static int pickNaNMulAdd(FloatClass a_cls, FloatClass b_cls, FloatClass c_cls,
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
-        if (is_snan(a_cls)) {
-            return 0;
-        } else if (is_snan(b_cls)) {
-            return 1;
-        } else if (is_snan(c_cls)) {
-            return 2;
-        } else if (is_qnan(a_cls)) {
-            return 0;
-        } else if (is_qnan(b_cls)) {
-            return 1;
+        if (snan_bit_is_one(status)) {
+            rule = float_3nan_prop_s_abc;
         } else {
-            return 2;
+            rule = float_3nan_prop_s_cab;
         }
-    } else {
-        /* Prefer sNaN over qNaN, in the c, a, b order. */
-        if (is_snan(c_cls)) {
-            return 2;
-        } else if (is_snan(a_cls)) {
-            return 0;
-        } else if (is_snan(b_cls)) {
-            return 1;
-        } else if (is_qnan(c_cls)) {
-            return 2;
-        } else if (is_qnan(a_cls)) {
-            return 0;
-        } else {
-            return 1;
-        }
-    }
 #elif defined(TARGET_LOONGARCH64)
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
+        rule = float_3nan_prop_s_cab;
 #elif defined(TARGET_PPC)
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
+        /*
+         * If fRA is a NaN return it; otherwise if fRB is a NaN return it;
+         * otherwise return fRC. Note that muladd on PPC is (fRA * fRC) + frB
+         */
+        rule = float_3nan_prop_acb;
 #elif defined(TARGET_S390X)
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
+        rule = float_3nan_prop_s_abc;
 #elif defined(TARGET_SPARC)
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
+        rule = float_3nan_prop_s_cba;
 #elif defined(TARGET_XTENSA)
-    /*
-     * For Xtensa, the (inf,zero,nan) case sets InvalidOp and returns
-     * an input NaN if we have one (ie c).
-     */
-    if (status->use_first_nan) {
-        if (is_nan(a_cls)) {
-            return 0;
-        } else if (is_nan(b_cls)) {
-            return 1;
+        if (status->use_first_nan) {
+            rule = float_3nan_prop_abc;
         } else {
-            return 2;
+            rule = float_3nan_prop_cba;
         }
-    } else {
-        if (is_nan(c_cls)) {
-            return 2;
-        } else if (is_nan(b_cls)) {
-            return 1;
-        } else {
-            return 0;
-        }
-    }
 #else
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
+        rule = float_3nan_prop_abc;
 #endif
+    }
+
+    assert(rule != float_3nan_prop_none);
+    if (have_snan && (rule & R_3NAN_SNAN_MASK)) {
+        /* We have at least one SNaN input and should prefer it */
+        do {
+            which = rule & R_3NAN_1ST_MASK;
+            rule >>= R_3NAN_1ST_LENGTH;
+        } while (!is_snan(cls[which]));
+    } else {
+        do {
+            which = rule & R_3NAN_1ST_MASK;
+            rule >>= R_3NAN_1ST_LENGTH;
+        } while (!is_nan(cls[which]));
+    }
+    return which;
 }
 
 /*----------------------------------------------------------------------------
-- 
2.34.1


