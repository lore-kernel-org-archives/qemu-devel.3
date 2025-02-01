Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED017C0218A
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2025 16:49:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1teGY0-00067l-6x; Sat, 01 Feb 2025 11:40:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1teGXm-00061B-GF
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 11:40:31 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1teGXk-00014J-DU
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 11:40:29 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-436a39e4891so20931425e9.1
 for <qemu-devel@nongnu.org>; Sat, 01 Feb 2025 08:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738428026; x=1739032826; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DNAe46UE3NF5ax4snCeOimPzEnqWEVPV2g/5r06GYCc=;
 b=aSNYtVybUENhNgHN8tQsVgBYyIn7pMKc47z3ffSgiF8Dn3L8OyNWGrOBOaPZkzVqzb
 EXPiFbo4gpCvoOgg50Hs+NgOLPHQr7qbH/NIxR6BAvD+mo0jLl8i+0cXPZARhq+3eoe0
 uNZOR5vMiL3hcwUVAoiQkiQIoMJSDNYJortBJYmxtWIAok5UtG0Y7GSH8pD9YqvhiLsY
 OTQMzQibdsA+71dhlk+0Gkuz/xzAKyjX5vzb8M9jxdtlQHasTNX4qPVbn2jWs3GmbTY4
 +1PBX+grcvRFDqOyB7L+sZHPe7fvtaZuxw5xmQlYbUeHItUD8eXR4JM4+a8FfRqax4yJ
 hJ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738428026; x=1739032826;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DNAe46UE3NF5ax4snCeOimPzEnqWEVPV2g/5r06GYCc=;
 b=F6XqNcLnOKnZsaEZB+0K78kW3kgphIFLC4prGMof0xMfhUDYs91IM5//nDtgcXmApp
 NozZbckGi3ogoihf0LhYEBBDoUDreBXyhH6FBE4gFDaa43iGj9f7BGGA1ko+jwehNFAa
 juOIZxVUvTJ9zxly4NSs23haQHsMZT6O/vs36xaW/yGzvrsA5Mn9VLMFgPx2Zez6/W7S
 DyAz2/rIfUnTpF+gljG1LIq5ar1WvCJ5hFQgP2P9BeANh9mPXG873KLZD3jOezp8ZA/d
 b6Bp0rcGA0+QF2n1bseH7Yj2x6QwmU3WxJ9cpADxloapLNQf4QZbdi2YFUY+TS1EM7eH
 5Y8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVF50zDPnlsYg9AQK5++59Fw3HNi2n32mwJxlxFHkxLj8EhZzEbiZbXpinkUnzfRRGSajIflSSOY95P@nongnu.org
X-Gm-Message-State: AOJu0YzwWNyQjIs21slf7by2s2KR7zFZSwMFnJIPM5uQPjjS+VIyni3H
 dBz8iK8fiSZbTZYE8r1XBvuXrPKwmqX2dXHhaNYP1wOm2jNloSzdZ+dlk+IjmA8=
X-Gm-Gg: ASbGncvZrX8IauDflKafbFnmv9XCx+XTFTKj36Vn28aTjMi1JG1uvlWrV34mN4W1OGe
 NPZGLRLZxQ2zz1iAcFRDDKXq24UIKbILbafNsKt2/5pjlqvvQ8HlgyHYMVeMqhc29XA/0OqFEao
 fGdwfR6vlnjA03NSdEY5hVDQve1HY2mdIatxNbTosvUBfladCuIBzoBwwB0rpr+dpyR/XZO+iCr
 Pp1QJuzPD83Of1QyQsf0aTU5bnJlyZNeG+BLsF4R6N6wtZ6mL5VGjRnWPkgps+y3ivCVwxBcH7K
 JlILhvmeUFlXDSsiLnbu
X-Google-Smtp-Source: AGHT+IEHvhjQ3lVPbl3nnpeRu+N3OEZ6y0KJEejq7IEEomFlS1pMtan1P7rbqdYXVtpaGnK8468xvA==
X-Received: by 2002:a05:600c:4713:b0:436:488f:4f3 with SMTP id
 5b1f17b1804b1-438dc3cbfc9mr140239515e9.17.1738428026432; 
 Sat, 01 Feb 2025 08:40:26 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc81d74sm127401525e9.37.2025.02.01.08.40.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Feb 2025 08:40:25 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 08/69] target/arm: Adjust FP behaviour for FPCR.AH = 1
Date: Sat,  1 Feb 2025 16:39:11 +0000
Message-Id: <20250201164012.1660228-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250201164012.1660228-1-peter.maydell@linaro.org>
References: <20250201164012.1660228-1-peter.maydell@linaro.org>
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

When FPCR.AH is set, various behaviours of AArch64 floating point
operations which are controlled by softfloat config settings change:
 * tininess and ftz detection before/after rounding
 * NaN propagation order
 * result of 0 * Inf + NaN
 * default NaN value

When the guest changes the value of the AH bit, switch these config
settings on the fp_status_a64 and fp_status_f16_a64 float_status
fields.

This requires us to make the arm_set_default_fp_behaviours() function
global, since we now need to call it from cpu.c and vfp_helper.c; we
move it to vfp_helper.c so it can be next to the new
arm_set_ah_fp_behaviours().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h  |  4 +++
 target/arm/cpu.c        | 23 -----------------
 target/arm/vfp_helper.c | 56 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 60 insertions(+), 23 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 863a84edf81..98073acc276 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1828,4 +1828,8 @@ uint64_t gt_virt_cnt_offset(CPUARMState *env);
  * all EL1" scope; this covers stage 1 and stage 2.
  */
 int alle1_tlbmask(CPUARMState *env);
+
+/* Set the float_status behaviour to match the Arm defaults */
+void arm_set_default_fp_behaviours(float_status *s);
+
 #endif
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 9ea2080e519..1ba22c4c7aa 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -169,29 +169,6 @@ void arm_register_el_change_hook(ARMCPU *cpu, ARMELChangeHookFn *hook,
     QLIST_INSERT_HEAD(&cpu->el_change_hooks, entry, node);
 }
 
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
-static void arm_set_default_fp_behaviours(float_status *s)
-{
-    set_float_detect_tininess(float_tininess_before_rounding, s);
-    set_float_ftz_detection(float_ftz_before_rounding, s);
-    set_float_2nan_prop_rule(float_2nan_prop_s_ab, s);
-    set_float_3nan_prop_rule(float_3nan_prop_s_cab, s);
-    set_float_infzeronan_rule(float_infzeronan_dnan_if_qnan, s);
-    set_float_default_nan_pattern(0b01000000, s);
-}
-
 static void cp_reg_reset(gpointer key, gpointer value, gpointer opaque)
 {
     /* Reset a single ARMCPRegInfo register */
diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index 30c170ecee5..62005e19524 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -31,6 +31,50 @@
    Single precision routines have a "s" suffix, double precision a
    "d" suffix.  */
 
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
+static void arm_set_ah_fp_behaviours(float_status *s)
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
 #ifdef CONFIG_TCG
 
 /* Convert host exception flags to vfp form.  */
@@ -173,6 +217,18 @@ static void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val, uint32_t mask)
         set_default_nan_mode(dnan_enabled, &env->vfp.fp_status_f16_a32);
         set_default_nan_mode(dnan_enabled, &env->vfp.fp_status_f16_a64);
     }
+    if (changed & FPCR_AH) {
+        bool ah_enabled = val & FPCR_AH;
+
+        if (ah_enabled) {
+            /* Change behaviours for A64 FP operations */
+            arm_set_ah_fp_behaviours(&env->vfp.fp_status_a64);
+            arm_set_ah_fp_behaviours(&env->vfp.fp_status_f16_a64);
+        } else {
+            arm_set_default_fp_behaviours(&env->vfp.fp_status_a64);
+            arm_set_default_fp_behaviours(&env->vfp.fp_status_f16_a64);
+        }
+    }
     /*
      * If any bits changed that we look at in vfp_get_fpsr_from_host(),
      * we must sync the float_status flags into vfp.fpsr now (under the
-- 
2.34.1


