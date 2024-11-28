Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67438D69113
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 14:55:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGfv5-0005Cz-B6; Thu, 28 Nov 2024 09:55:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tGfv3-0005CO-Qq
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 09:55:01 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tGfv1-0000jX-Rs
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 09:55:01 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-434a1639637so8560405e9.1
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2024 06:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732805697; x=1733410497; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=a40+KtZeRX6nQJhVRf67lS+vXZCfutf07XMJGlBLZmI=;
 b=R/fZZIRrV1dlXYo/4b4PS0iATMV5Jvnpbx4OeArDZSlj/XJKPw8GF9MUVw5zCx5Y/J
 gZmPjdPecLr5vOh0NqB3yFoDvZGFnn/SwT+TogDI0XQI+5cenl3o/AQsWuJTn8+pHcYD
 y+x514NOuFO979HEkV4U+KufgaP0KuaMpfMUDWiL/nc2OmA7jmo0LMzXCzacm73GhEd5
 pSs6aujhL51o4xHY1IkmHbROLpHIXShBXubl0uyx8jM1lzRLrf1cVCuFGGOH0SqQfLrH
 mtfkPuAporx33VKO10MiHGtbDcn1vUAGk4z3u9AhrwtGejeGXoxctpfHrbgb9ATQd/yH
 NjDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732805697; x=1733410497;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=a40+KtZeRX6nQJhVRf67lS+vXZCfutf07XMJGlBLZmI=;
 b=s1T2GJ+BowO9UBBTDLKrmWix7ugOlBc7SoN7k+2x4fSocsEtghVC5uF+3w5gp9qEqn
 gDLthuJ4ppr6Li/lbQqiM8Sv/YElnpUx0rOf2mONheD8JhFSe7mzHwPlENqyy7i8Lxah
 YR+a14McfbyT0PeWK7WEkEUbTrFKXVH2HCSEaK7jbitB2GjYlSvZXVhlVVpD9RN/HJV8
 91hJ0bjdzG4aTWYM1HdgRo20mOfZTCKQSuId0khF/5W9FVM0c2n8+OqUtw3jhcf08nyx
 bY510Jj2RQi+7Mk943Q3+VSd+r0/s2v2r5vtXLLDe2ThomF35aBKJ7ccjNxEw0QmBFka
 Es3g==
X-Gm-Message-State: AOJu0YzaRbNX3KQzAIbg8rFxEsSpYMr1ZLUvrP+BId3lTzLYKT9dKmTz
 lnSCPRp0O+ZnFq9RU2nwwmYC3Ru++F0SjeiLf7m57yPIeV43yR0Em2pApkXw2tITQA6k99KDsxn
 O
X-Gm-Gg: ASbGncsDebLDqVGXL0bunKPi44Q51CuUyIsxJGhzGhwKfoBitoTls/nrZgH5Ln48XlT
 GbqXBUVsbhdH5dpi4i5UkFsuqNMDXtN/Qf63A4zSiRTWbI3hKBUx6OdLdkc+BUl+4jWL8zf/7Ea
 5KxT2oLCn/5HzPVkGUMTc42WklImssuLRt66LNvq0/MYISoUvoyQFwRCVIcBuYyPRKVTTJv3n+C
 uZd7nGWyIMmpjY/LuLhnpTDW3NaJp96U/soZ8DUtYC3MX5I/HLHreY=
X-Google-Smtp-Source: AGHT+IHRumBZyUOpN3TCIP2K1FOnNLF8qqXBuDNiv4coDiphC5aHKbe1UDfEZeEg/AXMR39Ua1rk0g==
X-Received: by 2002:a05:600c:35c6:b0:42c:b45d:4a7b with SMTP id
 5b1f17b1804b1-434a9de3d1cmr62092965e9.25.1732805697511; 
 Thu, 28 Nov 2024 06:54:57 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434aa7d25d1sm56193595e9.31.2024.11.28.06.54.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 06:54:57 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [RFC PATCH] softfloat: Allow runtime choice of default NaN value
Date: Thu, 28 Nov 2024 14:54:55 +0000
Message-Id: <20241128145455.3742294-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

This is an RFC to ask for opinions on whether this is the right
way to let the target set its default NaN. I can't decide whether
I think encoding it into a uint8_t like that is clever, or merely
too clever :-)

The other options would be e.g. separate
  bool default_nan_sign;
  uint8_t default_nan_frac;
or an enum for the frac possibilities ("default_nan_frac_01__1",
"default_nan_frac_010__0", etc ???). The ones we currently need are:

 frac 1....1    sign 0 (m68k, sparc), sign 1 (hexagon)
  (with sign 0 for m68k, sparc; sign 1 for hexagon)
 frac 10...0
  (with sign 0 for many targets, sign 1 for i386, microblaze)
 frac 01...1
  (always with sign 0; sh4, some MIPS configs)
 frac 010..0
  (always with sign 0; hppa)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/fpu/softfloat-types.h  | 10 ++++++
 fpu/softfloat-specialize.c.inc | 61 ++++++++++++++++++++++------------
 2 files changed, 49 insertions(+), 22 deletions(-)

diff --git a/include/fpu/softfloat-types.h b/include/fpu/softfloat-types.h
index 6e237fb697d..0a0508fe2d8 100644
--- a/include/fpu/softfloat-types.h
+++ b/include/fpu/softfloat-types.h
@@ -285,6 +285,16 @@ typedef struct float_status {
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
index 353b524d2de..90b6c18a733 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -133,35 +133,52 @@ static void parts64_default_nan(FloatParts64 *p, float_status *status)
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
+        /*
+         * Sign bit set, all frac bits set. This is an odd special case,
+         * where our value doesn't match up with the snan_bit_is_one setting.
+         * This is because for Hexagon the returned value is always -1,
+         * not a real NaN value.
+         */
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
+
+    sign = status->default_nan_pattern >> 7;
+    /*
+     * Place default_nan_pattern [6:0] into bits [62:56],
+     * and replicate bit [0] down into [55:0]
+     */
+    frac = deposit64(0, DECOMPOSED_BINARY_POINT - 7, 7,
+                     status->default_nan_pattern);
+    frac = deposit64(frac, 0, DECOMPOSED_BINARY_POINT - 7,
+                     -(status->default_nan_pattern & 1));
 
     *p = (FloatParts64) {
         .cls = float_class_qnan,
-- 
2.34.1


