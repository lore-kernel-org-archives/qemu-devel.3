Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECA1BC021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 18:09:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmzLV-0004yP-6q; Tue, 25 Feb 2025 13:07:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmzJI-0008OI-EX
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:05:38 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmzJE-0002EG-6q
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:05:35 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-439ac3216dcso35323035e9.1
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 10:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740506729; x=1741111529; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=G4xjZnl3BpPxOIB4pja6AX2uxbwVoiM4NI/V8RlY2sg=;
 b=UXM1eZDURFtxZN5+APj6xSZum8vmf/FA7qlt8a6Nm9gQgbgt39CwOKwFxOSSTHbjzE
 a1GdoFrlFVMmcntu1YjrwCFarQ81MexnljkyGLa8vpTtDGCdRWkgXENT/IGKNx3P5gd1
 96Buv4Ih4Hny3yvZj8De09Z8jG55g6yPBDSlBQm7Nd6EiN7KxIlSXyzPoHDiNJn37G9N
 f9Ee/GDDP0ybRc4PTpLqSQm27JQ5Ggpt+K34gmAVa0EGeHJpjQaRlWCNlGLJBTJ8xZlF
 QrM/k3PH5ywI2eGEbh08JYAtDjvH93expN7zLxVT8OcVJvg6Ggtz2erHDnWcoGPOKzVT
 icsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740506729; x=1741111529;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G4xjZnl3BpPxOIB4pja6AX2uxbwVoiM4NI/V8RlY2sg=;
 b=imHMQv3oDrcC8EUXw2qT3rVMVaPEjRlTd0ExQFf+azbRCP3UYPcN2Nna8Y3fKlGIzm
 UGWfGAVf+tHmGSdGuwOvddUmZA9KLtAB66aHqht3Zo0zXP5MoT9wHutd8O6/r1BwI5gI
 V+vh8lISDVM1c/EsgIcOMy7XHTsTaGTtq4REfXhX2uO//skibMwYi3TN3bIytBfHCB1/
 H2u4Vm4ctRnnHedkjOA9CvF78ipBM9/jT0Ayko/mVpIYeSeS8jhbzBQXAeENIupcAnuh
 fgjaG/RlTcs2xZgm4JiSWkJ5WgQ0R5eDJF1MiGdknRw9ltHktODJuNyUm61SW5ViRXWZ
 9AAw==
X-Gm-Message-State: AOJu0Yw0RxUdD8FHZH3/vo0SIUIOMH2H+aBF84ZOjRyEBfduJnR8Dcrz
 n28lko8jSyeBDIf+HquE6MSESEv8Clvh4IqYLPBcgfXHiHk0cCSN0NokEhinr5iQDj5MdgnmGAK
 9
X-Gm-Gg: ASbGnct38koHCEGPLnfCkbdXCf67ZNSW6WzDzNAARt/nyE4Eige7F/ujziNpz/32tye
 aQ+txyqE72hs2lHzcyZw1JB+GqFmvV/i1pDIqU+k0AeyjtTv0M4d33GQvd1AZJnD5hER1rrx9Y2
 IbJp6uewMo8pcaNhTfIAojG8D6v8TQsmRVAn4KLmILKPIaLLl/5g15W6HfVm3JT2z+JwbwdqFTA
 Z5nzi2xTcjw8/31Z7l1+9iCjBwjBKlRqSHJf//CVo4bZ234cPJEAKA4YKidKzdg2IlI3BpGitpC
 457L9etQHpgG4CVFab3k8p/X/34CygBQ
X-Google-Smtp-Source: AGHT+IFzpf81Og47LC7aK6z2LLPt9spb4oUIjRbLO61+QcS/xBmYdPzn2bO1GVywwFWzKKw1Qqk0rA==
X-Received: by 2002:a05:600c:4683:b0:439:8523:36cc with SMTP id
 5b1f17b1804b1-43ab07ab212mr54003605e9.11.1740506728517; 
 Tue, 25 Feb 2025 10:05:28 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ab156a136sm35147875e9.35.2025.02.25.10.05.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 10:05:27 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/43] fpu: Make targets specify whether floatx80 Inf can have
 Int bit clear
Date: Tue, 25 Feb 2025 18:04:39 +0000
Message-ID: <20250225180510.1318207-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250225180510.1318207-1-peter.maydell@linaro.org>
References: <20250225180510.1318207-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

In Intel terminology, a floatx80 Infinity with the explicit integer
bit clear is a "pseudo-infinity"; for x86 these are not valid
infinity values.  m68k is looser and does not care whether the
Integer bit is set or clear in an infinity.

Move this setting to runtime rather than using an ifdef in
floatx80_is_infinity().

Since this was the last use of the floatx80_infinity global constant,
we remove it and its definition here.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20250224111524.1101196-6-peter.maydell@linaro.org
Message-id: 20250217125055.160887-5-peter.maydell@linaro.org
---
 include/fpu/softfloat-types.h  |  5 +++++
 include/fpu/softfloat.h        | 18 +++++++++++-------
 target/m68k/cpu.c              |  4 +++-
 fpu/softfloat-specialize.c.inc | 10 ----------
 4 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/include/fpu/softfloat-types.h b/include/fpu/softfloat-types.h
index dd22ecdbe60..e1732beba4f 100644
--- a/include/fpu/softfloat-types.h
+++ b/include/fpu/softfloat-types.h
@@ -330,6 +330,11 @@ typedef enum __attribute__((__packed__)) {
 typedef enum __attribute__((__packed__)) {
     /* In the default Infinity value, is the Integer bit 0 ? */
     floatx80_default_inf_int_bit_is_zero = 1,
+    /*
+     * Are Pseudo-infinities (Inf with the Integer bit zero) valid?
+     * If so, floatx80_is_infinity() will return true for them.
+     */
+    floatx80_pseudo_inf_valid = 2,
 } FloatX80Behaviour;
 
 /*
diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index 3c83d703baf..07259c59303 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -960,7 +960,6 @@ float128 floatx80_to_float128(floatx80, float_status *status);
 /*----------------------------------------------------------------------------
 | The pattern for an extended double-precision inf.
 *----------------------------------------------------------------------------*/
-extern const floatx80 floatx80_infinity;
 floatx80 floatx80_default_inf(bool zSign, float_status *status);
 
 /*----------------------------------------------------------------------------
@@ -998,12 +997,17 @@ static inline floatx80 floatx80_chs(floatx80 a)
 
 static inline bool floatx80_is_infinity(floatx80 a, float_status *status)
 {
-#if defined(TARGET_M68K)
-    return (a.high & 0x7fff) == floatx80_infinity.high && !(a.low << 1);
-#else
-    return (a.high & 0x7fff) == floatx80_infinity.high &&
-                       a.low == floatx80_infinity.low;
-#endif
+    /*
+     * It's target-specific whether the Integer bit is permitted
+     * to be 0 in a valid Infinity value. (x86 says no, m68k says yes).
+     */
+    bool intbit = a.low >> 63;
+
+    if (!intbit &&
+        !(status->floatx80_behaviour & floatx80_pseudo_inf_valid)) {
+        return false;
+    }
+    return (a.high & 0x7fff) == 0x7fff && !(a.low << 1);
 }
 
 static inline bool floatx80_is_neg(floatx80 a)
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index df66e8ba22a..56b23de21fe 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -110,8 +110,10 @@ static void m68k_cpu_reset_hold(Object *obj, ResetType type)
     /*
      * m68k-specific floatx80 behaviour:
      *  * default Infinity values have a zero Integer bit
+     *  * input Infinities may have the Integer bit either 0 or 1
      */
-    set_floatx80_behaviour(floatx80_default_inf_int_bit_is_zero,
+    set_floatx80_behaviour(floatx80_default_inf_int_bit_is_zero |
+                           floatx80_pseudo_inf_valid,
                            &env->fp_status);
 
     nan = floatx80_default_nan(&env->fp_status);
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index 73789e97d77..8327f727861 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -237,16 +237,6 @@ floatx80 floatx80_default_inf(bool zSign, float_status *status)
     return packFloatx80(zSign, 0x7fff, z ? 0 : (1ULL << 63));
 }
 
-#define floatx80_infinity_high 0x7FFF
-#if defined(TARGET_M68K)
-#define floatx80_infinity_low  UINT64_C(0x0000000000000000)
-#else
-#define floatx80_infinity_low  UINT64_C(0x8000000000000000)
-#endif
-
-const floatx80 floatx80_infinity
-    = make_floatx80_init(floatx80_infinity_high, floatx80_infinity_low);
-
 /*----------------------------------------------------------------------------
 | Returns 1 if the half-precision floating-point value `a' is a quiet
 | NaN; otherwise returns 0.
-- 
2.43.0


