Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7660D78321
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 13:45:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI6Vv-0004Ix-Hc; Mon, 02 Dec 2024 08:31:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI6Gk-0002bl-Vr
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:15:23 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI6GU-0003Mc-PP
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:15:12 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-434ab938e37so26679275e9.0
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 05:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733145275; x=1733750075; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wdqAdxMo/Zjt+7gjYfOwzXdT/5QjRbRXYw8xftE2ZL0=;
 b=sgmIvl9uV5v2tKz5CA5wywE2NnKdE0T801pKtAK8ld+4ZLRW/ri+1PSzNcYGyGG7zW
 lQNSq3uyIbx5/ewdpQ7lGeSvXbKjXVuW5Iq+bTwC3eygMGd1HJweXe93BQW8rA7wpB7U
 aa+cdrDjawOrUOU40mBhdFAgxDsbwIYQYlpf48MEGewogoaqUkORk5p1ajAHmofUSeoK
 MeguhGtyW+quw1VOnN60+aXyCOMOqQirj8BIir6M/GsP0Q5ykfMItyrhz/BpFhA65of2
 Ct/8LI4bCK5mrnAcfATO9pQyStHPFsU70S4IlYQ1YkTUOBfytuizwtRU9QSLfwJVst5j
 vwBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733145275; x=1733750075;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wdqAdxMo/Zjt+7gjYfOwzXdT/5QjRbRXYw8xftE2ZL0=;
 b=DWcUOQ7EaAJCJEWHnG9CIyWmTFsJ4CqVxxSYfwnBiUkfmbtK/jNJ5FDLpvoYrBXuX9
 24bR59BA/4Y2JHJMBYZmO2q1X77V/FjoOWHsH657hRHUq5rOIy073DOotJbSItSnHnQq
 y9llahmZGpY/o3KmSThXEtdfz8pIYhV6Lq9aMbOS6GQmVDenDgPU9DpxXT4t2GI7D2XB
 ItmqLF5Ek6TY+enaze/r9KhaL45BnstFm7FFXd8ONHciINEaxIKbK8h731D6fOgmBD3r
 nHAUqLLEHE8h+JKp0LSgih8lloKZer2Pk7Cw4nZqMwlhyGdieK2EtBMTQEqunblXdvk7
 NS5A==
X-Gm-Message-State: AOJu0YwgwK1dYUGFK8tX85OQZK8Kb0CXVxdnQ655jDfiipI2UfCfq7LD
 ROJbKzY8muzoKfG8fbwegY3u9zB6Eh8nUUbBBznLf2oIbIBxugsqcrnt+4N3eYFZEaycDwUbBsN
 Y
X-Gm-Gg: ASbGncvOjCDWnLvUo32WzZGYt+NqWYoc81ahqyM40B1Y0cs4i2rqofc9hWAzYldIj+j
 t53yHOq1Y3XUr97rl/ZwzuhBLfDV49+ZuWz0y1/LOhki6DkDQ5FhwSUlPHCxXFoWaFXLKlimKDk
 lfO/bISo+gbwzfOJENo95Ki00RSAxcEU1AIPEtt9m7W8mvj89osEb28xYt/9xqSjymXvhHgeGtq
 q4E7OgHY0OjbLgOi93H2G70QFau8ISIBbrlyVvT2VsYna20dJ4uTVk=
X-Google-Smtp-Source: AGHT+IHpLBkZrKDuWdn+SfRe1n4Bcn7GFrx0fDmm6XZ9hZ1GnazAJ/+blc2Smc6txIX9PHI2+r8AzQ==
X-Received: by 2002:a05:6000:2806:b0:385:ec89:2f07 with SMTP id
 ffacd0b85a97d-385ec8930bamr3048801f8f.32.1733145275036; 
 Mon, 02 Dec 2024 05:14:35 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385dea1e4ebsm10160157f8f.1.2024.12.02.05.14.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2024 05:14:34 -0800 (PST)
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
Subject: [PATCH v2 for-10.0 28/54] softfloat: Create floatx80 default NaN from
 parts64_default_nan
Date: Mon,  2 Dec 2024 13:13:21 +0000
Message-Id: <20241202131347.498124-29-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241202131347.498124-1-peter.maydell@linaro.org>
References: <20241202131347.498124-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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


