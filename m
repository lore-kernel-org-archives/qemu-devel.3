Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42D1ED78320
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 13:34:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI6UY-0001Os-34; Mon, 02 Dec 2024 08:29:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI6Gv-0002jQ-SQ
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:15:30 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI6GY-0003Ok-Fj
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:15:27 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-385eed29d17so794146f8f.0
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 05:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733145281; x=1733750081; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yKV708lbVufub1eS0i2nRrYGl0qdKJsRNu5HvpEXaMM=;
 b=limuPtMsqKdefUjQNTmRKUjAfc4lUDIGStfKIJHTgerxmEhPGku+ZFJKbNcPhIbX73
 xN6/un/uRBj/4EN1xsQm6mZ/UYqZTW9IBIcxOGhRvyLaS2d9It2B+StnIBR+6he8Ew5J
 aeMPCkd+HkFP8XXsT4hh0i5CxSYHOuSLa58k2AEV8nWWlvdzJXIZDl/+zM56ahDdRerk
 ZXzDZAla1dLK7l4YEYOWy/InULIuXhmAzR4FNbmgSHW04saYOH6rP3mvqNzW9G/bOoYW
 9JGsFv6lxHdFmy+TIh+5LyKZgTOj3Luq451N2kr9M8lORPeF9w4D4yxXoDXVhL4aiUml
 zorg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733145281; x=1733750081;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yKV708lbVufub1eS0i2nRrYGl0qdKJsRNu5HvpEXaMM=;
 b=AlT72e2kbkbCXISUxBJa4lveJfxfVlVcce+SmHwavJNDOYU/+oma5o2n+SsOJoOsWc
 A7CKINh7H/2rr9tdAwB7LFOHXlRCnD9Hhw8BpczBPh/+V4VaxmeSJLRgaah/Sbz0g2+U
 CU1Px2eiNrEJzhExyAGutf2v6TpJ7+LSUE4a3ncBak6WBSMklewQJTEGM6bciJuDFMZO
 EeVzyy3i1/VJJpDSDYiCpSIQGMsB/p4ce6vDtbUuoT6H25qtRLVp8xuCVV8H2hZlZKdc
 wn5guZPxOjx2Kos9rtk2NVTekTTdI+N8U/XzhfSdljL3gMHAvUwubmEA6zLIlyKkAriH
 z85g==
X-Gm-Message-State: AOJu0YywJi1f6ZUYvZFL8sj2QRMufUusFm/huClgVt8wjzibGFVzoD7T
 GofiF82jSRQtnCWZC+B+k+R3lDXTuPrlQ6LkscQMmRbDLa9fUt/gNwQicwTAiMotcQsrwlQbwkB
 I
X-Gm-Gg: ASbGncs/7csB+xz7prkPR4l+vZuxvyR9hcKovkJFNEfZpoM1XTZVarBUrxEF70VfPaw
 5YNHOU8TYCuWnrNm+RcTPj3YFX58vYmR3d79pvx+g5LuyNRXcwTdIYbTnCxmTCnsTD/aktqDsi0
 Jt/WgxJpj9LIHBplZrE90s50hOcNA2KWsbr8XJhQsL4y7tYXww73jWJLcyXKclUsEOBdadGYjXe
 FjUu6BcV6IYbVldTeFtJGUE2DKZ2TkgivSSES4I436oNdidg9Z3Gbw=
X-Google-Smtp-Source: AGHT+IFELuFkVQJehEVSKgoZXY73udDUueU5hfLBaI5Ys4CGnWxhP2s0m/NuLhCYSvhKN/52NWLe5A==
X-Received: by 2002:a05:6000:42ca:b0:385:f0dc:c9fd with SMTP id
 ffacd0b85a97d-385f0dccb93mr2451898f8f.27.1733145280733; 
 Mon, 02 Dec 2024 05:14:40 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385dea1e4ebsm10160157f8f.1.2024.12.02.05.14.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2024 05:14:40 -0800 (PST)
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
Subject: [PATCH v2 for-10.0 34/54] fpu: Allow runtime choice of default NaN
 value
Date: Mon,  2 Dec 2024 13:13:27 +0000
Message-Id: <20241202131347.498124-35-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241202131347.498124-1-peter.maydell@linaro.org>
References: <20241202131347.498124-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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


