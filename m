Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3293AE7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:26:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPSD-0000Mo-1i; Wed, 11 Dec 2024 11:20:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPSC-0000M2-AU
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:20:48 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPSA-0007kp-Lb
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:20:48 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-434ab114753so46291045e9.0
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733934045; x=1734538845; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gHqtgcXwaXzVvVdsrCBhcuw/gjNtZbZ0W54PPbBKVlI=;
 b=wR9HS04S8ZIam90w+foN226+sn5clRA45Z4F/yJDhk2+LXe1CCXyzuELjOS/rcl59S
 hIiG7/PS1jetZSmJXW5ZSaeCHvgZdBv/Xe6sZKLYwWyqhuHqbmD+hqYHjviknwlu9qul
 6gIdYuEgsX86XBoSh7JyV8cNAt02xEdBW2EbDdtd1pM1SiKEmamwXqEjJhhRFIvOXzi3
 FCtYkZwH2sNzdzVkSw6qv1lXAdgER+yFWP5ibNoAjGFZcWNi/obhqp+XtyyeiyCrJM2d
 Lbx+9NqC1eu/cRehLXDvpAkOFWTXdS+cemYuQJmIXNypqZBNtLW3B6bYIRtwOIPiV9nU
 Xr8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934045; x=1734538845;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gHqtgcXwaXzVvVdsrCBhcuw/gjNtZbZ0W54PPbBKVlI=;
 b=VF7L864i4+ssR6IxmXtOMe93iI/Nf4ntfEgUK9kUtnfQ75IAk4PFYtAfFq+je5NCKE
 GDqsi/ZXnFWms9SUpRrLBxdJcmAcEAs7KM7wwDC0hPKCj8qttUoAhRuwype8yp3XB1z3
 F0Wuf6VAg1U0B2kQpmMFa/n/XQWveTSKdG5JOWkVOub1uHg1aUHH/1fmcJUU5pxHCk9V
 dNOUU+L9CeEb5lgYPWzXov0xhC9s8COotOy6Q3tamprrpXkXyJAVshwUoOePqkUgLtot
 hSH8QIp3YVACUmvFAlNWA2DRlksJioVjtGMKnx59ISWwY/boU8UDPWA+rX2zk4xV6/KX
 wCIA==
X-Gm-Message-State: AOJu0YyfwgzMJ5CuRtLKzhkVjSsPvqaqfxlNB/QPD8RmP/s1VJGisa2o
 5QwwnMweoMem6uTXQVDuMprT6umAKS7ZXIyIRm7vfA2Uh8sp3lFerDvOp3K/3VEWD9nnxrew1D7
 v
X-Gm-Gg: ASbGncvSFHY92PYujctOsiIN+2K+Rw9h7IjwjT0OVncyK1EAZhTqGP9dX7lDm6kdwdG
 6CF+HmSrm5v+leUC+IMvdIU8Wt3Tv+77CUiS94b25EjjWXXLxrQaHeD+S5wyFr8YyJC5qgl+JiK
 g28pO48Rwcc827HX1cKn+ym+vL9Wl/obgDNrRD4iABGtQQY3jy2YRRogB0ZzhqJ/+EMnz1moVe4
 Knd8a79yGb0NXmhYiUwwxBkA0CWvFLIdugOmxRSL59VmGXMiPM3+uNHHO56
X-Google-Smtp-Source: AGHT+IHtrwz2LUY9f7DYGq8SMxTQSn7blz5yzVFyX+oxfkbj/mfPGZrx84ALjbjaEwXQFvanRezRLg==
X-Received: by 2002:a05:600c:3b9c:b0:436:1af4:5e07 with SMTP id
 5b1f17b1804b1-4361c3444a2mr27137875e9.1.1733934045309; 
 Wed, 11 Dec 2024 08:20:45 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434f4dfdcdfsm121460595e9.39.2024.12.11.08.20.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:20:44 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 33/72] softfloat: Create floatx80 default NaN from
 parts64_default_nan
Date: Wed, 11 Dec 2024 16:19:25 +0000
Message-Id: <20241211162004.2795499-34-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211162004.2795499-1-peter.maydell@linaro.org>
References: <20241211162004.2795499-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

We create our 128-bit default NaN by calling parts64_default_nan()
and then adjusting the result.  We can do the same trick for creating
the floatx80 default NaN, which lets us drop a target ifdef.

floatx80 is used only by:
 i386
 m68k
 arm nwfpe old floating-point emulation emulation support
    (which is essentially dead, especially the parts involving floatx80)
 PPC (only in the xsrqpxp instruction, which just rounds an input
    value by converting to floatx80 and back, so will never generate
    the default NaN)

The floatx80 default NaN as currently implemented is:
 m68k: sign = 0, exp = 1...1, int = 1, frac = 1....1
 i386: sign = 1, exp = 1...1, int = 1, frac = 10...0

These are the same as the parts64_default_nan for these architectures.

This is technically a possible behaviour change for arm linux-user
nwfpe emulation emulation, because the default NaN will now have the
sign bit clear.  But we were already generating a different floatx80
default NaN from the real kernel emulation we are supposedly
following, which appears to use an all-bits-1 value:
 https://elixir.bootlin.com/linux/v6.12/source/arch/arm/nwfpe/softfloat-specialize#L267

This won't affect the only "real" use of the nwfpe emulation, which
is ancient binaries that used it as part of the old floating point
calling convention; that only uses loads and stores of 32 and 64 bit
floats, not any of the floatx80 behaviour the original hardware had.
We also get the nwfpe float64 default NaN value wrong:
 https://elixir.bootlin.com/linux/v6.12/source/arch/arm/nwfpe/softfloat-specialize#L166
so if we ever cared about this obscure corner the right fix would be
to correct that so nwfpe used its own default-NaN setting rather
than the Arm VFP one.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241202131347.498124-29-peter.maydell@linaro.org
---
 fpu/softfloat-specialize.c.inc | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index 5fbc953e71e..9f913ce20ab 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -227,17 +227,17 @@ static void parts128_silence_nan(FloatParts128 *p, float_status *status)
 floatx80 floatx80_default_nan(float_status *status)
 {
     floatx80 r;
+    /*
+     * Extrapolate from the choices made by parts64_default_nan to fill
+     * in the floatx80 format. We assume that floatx80's explicit
+     * integer bit is always set (this is true for i386 and m68k,
+     * which are the only real users of this format).
+     */
+    FloatParts64 p64;
+    parts64_default_nan(&p64, status);
 
-    /* None of the targets that have snan_bit_is_one use floatx80.  */
-    assert(!snan_bit_is_one(status));
-#if defined(TARGET_M68K)
-    r.low = UINT64_C(0xFFFFFFFFFFFFFFFF);
-    r.high = 0x7FFF;
-#else
-    /* X86 */
-    r.low = UINT64_C(0xC000000000000000);
-    r.high = 0xFFFF;
-#endif
+    r.high = 0x7FFF | (p64.sign << 15);
+    r.low = (1ULL << DECOMPOSED_BINARY_POINT) | p64.frac;
     return r;
 }
 
-- 
2.34.1


