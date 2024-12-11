Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 617E6E77180
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:21:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPSM-0000Zu-I5; Wed, 11 Dec 2024 11:20:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPSL-0000Yb-DN
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:20:57 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPSJ-0007mt-4o
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:20:57 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43540bdb448so13925305e9.2
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733934054; x=1734538854; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5/6kEX1gNzfQ+l4QKWLxGw2T4UU2uunALU33y3cz//o=;
 b=CrX+O6rwAy5yXlF9AIsv5HHgjV9lhHGCsgS2jRqg/M/rHSO7i8jVYbOTVZUWSvtfDF
 hQT5W10FftL2lmaHPKsj3vHg12L8DEFQh21xjToH6QHy1bvcza+NRePmUQqqkpFI+vkc
 hpoKMtUxR5mgBXbZ2OeKnIZ3nsMyhvI7GH6+HgF2cLaUyAtoZAGQex9K4T8pR2PQsbXb
 Dq/ASWoatV5e4qusgINldYJx24xapLkPTXw4W2qCyKNFrjNLLgPr4NUiU5txTKlSjzBF
 LgOm9iXaxqtNv1Rgn72UNR25W3P5fzrkEYfIWXEZHq+nwyxOT7mXieLecm1Jdy9QuTrb
 P8mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934054; x=1734538854;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5/6kEX1gNzfQ+l4QKWLxGw2T4UU2uunALU33y3cz//o=;
 b=iQHYcFluTZ7D9R5H3Ui+ZbuuStAxMvNW/hXH76X8BVIJVPX0F1eSnbQd7BoXHNFaFg
 gCfsjQ02MwtKL9720WrDzs/MMXpFH63t1g1juITskxQs18aB8iaPqS0WYiZr3YkmXz96
 Uair/3GaHtQfaGHiLiTD2mU0RRzAgkqcfzi/j086ZQVNDa45Nsuk0GHRo+d3uqqF1zcF
 ou/vdamPCTHfWwHvfo36YX8DCXk4pwpum2YgFO/RZ1zdm2RjDZ9JwaBbF3ZvPac876UY
 arRyQcUp9lyg/BeV2uBqpYPJphY0XAeIXOlvfDUzp0ikUJ7cF0M/oD0NcZ6PtC7/67pj
 ZEPA==
X-Gm-Message-State: AOJu0Yy17dc7u1m30gbyQ6guLPedx4kgrwBiVnJeAtLfOG6K87KidmnZ
 d7v5Wk3JYD5Ph3emWWYZaXv/MoPU+gc7n6tn3wQai8b28cD+DJeDz7dFhx64h5xcYH5bjeC4nrN
 8
X-Gm-Gg: ASbGncskZD0u5cSy53VDft8z4Ev8HGuoto1XexLDgUmRFcNquLf7A6uOTbO+Q4gKnEh
 wJ+3AkcfpwqoCubY9ZQRL+CaFrrqXYMNUWIqpU40I6iktCVT0XAqc+c9bA0g9ojKppE2S2mnIE1
 x9fjNA+taCOLvNshiqSv1QTDG31VT0CALTlH9PSFn6MyQ7N28ZXeVZlJnlQjVS1AS+rBYU+HrPY
 pHxQDfPEJxErXBWAdjV1B4E6VQc1qFilZh8xqtLuECQsJ1vjlMeZSmYMfjx
X-Google-Smtp-Source: AGHT+IET9rGDP9injVxIbSKRt7+C4pG/oxZP8NBRVm40qBj3z4X2FYVXQqgYvUQb0vkI+LYAx0Vv3w==
X-Received: by 2002:a05:600c:3552:b0:434:f131:1e6d with SMTP id
 5b1f17b1804b1-4361c360e94mr33908025e9.10.1733934053683; 
 Wed, 11 Dec 2024 08:20:53 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434f4dfdcdfsm121460595e9.39.2024.12.11.08.20.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:20:53 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 40/72] fpu: Allow runtime choice of default NaN value
Date: Wed, 11 Dec 2024 16:19:32 +0000
Message-Id: <20241211162004.2795499-41-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211162004.2795499-1-peter.maydell@linaro.org>
References: <20241211162004.2795499-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

Currently we hardcode the default NaN value in parts64_default_nan()
using a compile-time ifdef ladder. This is awkward for two cases:
 * for single-QEMU-binary we can't hard-code target-specifics like this
 * for Arm FEAT_AFP the default NaN value depends on FPCR.AH
   (specifically the sign bit is different)

Add a field to float_status to specify the default NaN value; fall
back to the old ifdef behaviour if these are not set.

The default NaN value is specified by setting a uint8_t to a
pattern corresponding to the sign and upper fraction parts of
the NaN; the lower bits of the fraction are set from bit 0 of
the pattern.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241202131347.498124-35-peter.maydell@linaro.org
---
 include/fpu/softfloat-helpers.h | 11 +++++++
 include/fpu/softfloat-types.h   | 10 ++++++
 fpu/softfloat-specialize.c.inc  | 55 ++++++++++++++++++++-------------
 3 files changed, 54 insertions(+), 22 deletions(-)

diff --git a/include/fpu/softfloat-helpers.h b/include/fpu/softfloat-helpers.h
index 10a6763532c..dceee23c823 100644
--- a/include/fpu/softfloat-helpers.h
+++ b/include/fpu/softfloat-helpers.h
@@ -93,6 +93,12 @@ static inline void set_float_infzeronan_rule(FloatInfZeroNaNRule rule,
     status->float_infzeronan_rule = rule;
 }
 
+static inline void set_float_default_nan_pattern(uint8_t dnan_pattern,
+                                                 float_status *status)
+{
+    status->default_nan_pattern = dnan_pattern;
+}
+
 static inline void set_flush_to_zero(bool val, float_status *status)
 {
     status->flush_to_zero = val;
@@ -154,6 +160,11 @@ static inline FloatInfZeroNaNRule get_float_infzeronan_rule(float_status *status
     return status->float_infzeronan_rule;
 }
 
+static inline uint8_t get_float_default_nan_pattern(float_status *status)
+{
+    return status->default_nan_pattern;
+}
+
 static inline bool get_flush_to_zero(float_status *status)
 {
     return status->flush_to_zero;
diff --git a/include/fpu/softfloat-types.h b/include/fpu/softfloat-types.h
index 84ba4ed20e6..79ca44dcc30 100644
--- a/include/fpu/softfloat-types.h
+++ b/include/fpu/softfloat-types.h
@@ -303,6 +303,16 @@ typedef struct float_status {
     /* should denormalised inputs go to zero and set the input_denormal flag? */
     bool flush_inputs_to_zero;
     bool default_nan_mode;
+    /*
+     * The pattern to use for the default NaN. Here the high bit specifies
+     * the default NaN's sign bit, and bits 6..0 specify the high bits of the
+     * fractional part. The low bits of the fractional part are copies of bit 0.
+     * The exponent of the default NaN is (as for any NaN) always all 1s.
+     * Note that a value of 0 here is not a valid NaN. The target must set
+     * this to the correct non-zero value, or we will assert when trying to
+     * create a default NaN.
+     */
+    uint8_t default_nan_pattern;
     /*
      * The flags below are not used on all specializations and may
      * constant fold away (see snan_bit_is_one()/no_signalling_nans() in
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index 9f913ce20ab..b1ec534983c 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -133,35 +133,46 @@ static void parts64_default_nan(FloatParts64 *p, float_status *status)
 {
     bool sign = 0;
     uint64_t frac;
+    uint8_t dnan_pattern = status->default_nan_pattern;
 
+    if (dnan_pattern == 0) {
 #if defined(TARGET_SPARC) || defined(TARGET_M68K)
-    /* !snan_bit_is_one, set all bits */
-    frac = (1ULL << DECOMPOSED_BINARY_POINT) - 1;
-#elif defined(TARGET_I386) || defined(TARGET_X86_64) \
+        /* Sign bit clear, all frac bits set */
+        dnan_pattern = 0b01111111;
+#elif defined(TARGET_I386) || defined(TARGET_X86_64)    \
     || defined(TARGET_MICROBLAZE)
-    /* !snan_bit_is_one, set sign and msb */
-    frac = 1ULL << (DECOMPOSED_BINARY_POINT - 1);
-    sign = 1;
+        /* Sign bit set, most significant frac bit set */
+        dnan_pattern = 0b11000000;
 #elif defined(TARGET_HPPA)
-    /* snan_bit_is_one, set msb-1.  */
-    frac = 1ULL << (DECOMPOSED_BINARY_POINT - 2);
+        /* Sign bit clear, msb-1 frac bit set */
+        dnan_pattern = 0b00100000;
 #elif defined(TARGET_HEXAGON)
-    sign = 1;
-    frac = ~0ULL;
+        /* Sign bit set, all frac bits set. */
+        dnan_pattern = 0b11111111;
 #else
-    /*
-     * This case is true for Alpha, ARM, MIPS, OpenRISC, PPC, RISC-V,
-     * S390, SH4, TriCore, and Xtensa.  Our other supported targets
-     * do not have floating-point.
-     */
-    if (snan_bit_is_one(status)) {
-        /* set all bits other than msb */
-        frac = (1ULL << (DECOMPOSED_BINARY_POINT - 1)) - 1;
-    } else {
-        /* set msb */
-        frac = 1ULL << (DECOMPOSED_BINARY_POINT - 1);
-    }
+        /*
+         * This case is true for Alpha, ARM, MIPS, OpenRISC, PPC, RISC-V,
+         * S390, SH4, TriCore, and Xtensa.  Our other supported targets
+         * do not have floating-point.
+         */
+        if (snan_bit_is_one(status)) {
+            /* sign bit clear, set all frac bits other than msb */
+            dnan_pattern = 0b00111111;
+        } else {
+            /* sign bit clear, set frac msb */
+            dnan_pattern = 0b01000000;
+        }
 #endif
+    }
+    assert(dnan_pattern != 0);
+
+    sign = dnan_pattern >> 7;
+    /*
+     * Place default_nan_pattern [6:0] into bits [62:56],
+     * and replecate bit [0] down into [55:0]
+     */
+    frac = deposit64(0, DECOMPOSED_BINARY_POINT - 7, 7, dnan_pattern);
+    frac = deposit64(frac, 0, DECOMPOSED_BINARY_POINT - 7, -(dnan_pattern & 1));
 
     *p = (FloatParts64) {
         .cls = float_class_qnan,
-- 
2.34.1


