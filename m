Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 247C3CD343F
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 07:41:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPy1F-0001vo-IT; Thu, 21 May 2026 03:40:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <antonb@tenstorrent.com>)
 id 1wPy1D-0001tz-Lu
 for qemu-devel@nongnu.org; Thu, 21 May 2026 03:40:35 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <antonb@tenstorrent.com>)
 id 1wPy1B-0006tS-N0
 for qemu-devel@nongnu.org; Thu, 21 May 2026 03:40:35 -0400
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7e582b3bcaaso4880178a34.3
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 00:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1779349231; x=1779954031; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JIndSBtKcf7EyF7TbFurJp+EB72gDaVv5fTRX1DJ+4I=;
 b=arjRVIy+Ls8YZuHl7//FIi471akAjBjSnkudbWHENerpa7rFoCCug7ktv6gNy8FNK8
 JW+inTJNG20nx7KiDeJD7NJdlskdgKXLcMK6Zk73IW5JSe/QA5JXlsy/8+6Cj8F0s1VK
 EHxi0wEJs9RiM5O3uT1DZXItnz97mDimirKdbIAKYhaX+S7vjhI99wQGv3NCfEqghosW
 v7AnwsWPSpJuS9defIzYLJZjNZYreL/L8lMBe3CH8Trbqx4tl9SBXrJYfIlbxpjYYhdW
 BrzUObo7IvtmNxCafHDH2H5sSmXoyoefcPIEAXoh6UpZtZDNiTTdt6tC+ryKBppSYrJD
 8edQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779349231; x=1779954031;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JIndSBtKcf7EyF7TbFurJp+EB72gDaVv5fTRX1DJ+4I=;
 b=UxjgfygtK5bNyB0CIC5psQE1wJP/akjKNtTHU7ZtcA2o1U7SxbUZDvllG/E1i+mwgW
 EXFIkIJ5HwEKMVK5LIrU7y38/QaNR+8DCq9PAF+4o+sLctD6K57RoP7S/MRqxR62rMLU
 50B0dsueEn/fv5rAT2juwOiarAPhQ0c6Iw6Ib2fRCTA0Joai1atNsqlANu/yZBaJOFTe
 K52LCzXm8e5IHJ1ePUT4zS58NNYwttsqNGTOszXOsI694LEjnrewB/sQQGqIX9Opqpul
 3AFlAWUoenhrQuC0HNz/nhYjfGvFYFR7A0lkw0AtFSBAgKGvHWuU8bDApnqejlnA3F9W
 hUqQ==
X-Gm-Message-State: AOJu0Yw4T0M1eqb599wB/AxNy8Rk/pfkoECxCinDkXeJKFlN4mR3iOFJ
 jyse3sMJwVRiCXTf77CFpXs0jVqAc/xTxBWXcl58gByU90f10yhZpTdXyRYwQL8jEPlAqwfEO5T
 wxTLiWdE=
X-Gm-Gg: Acq92OFRAG8zfLZcUdSqCbfCewvs+r5mBl/QE8OWNedY+1+bP5OZ7H1uLq2YirEORz2
 Qqs+3iOHy69B33dw4Jg9jEus5DamjOVQYPIXnub9hN6ErKlWumaS6DRSjSyINgV3DuzaSOd/Vpx
 qD/vL1Qc+uStz+66mI63sPiKwloezq60ra7TENthIpUp3fsGW3so87aqNCeeJSOrafbs3GWTAip
 sKh+p1HSD3yAv4D3TuMTLJJuZMaysJrnko5/GIIX9q7r2c1ahLrRoW/JhfEPWQALfSnd9wBgEXm
 dQhzANStS0aMx3NJ79APDFmq1ne+qWEPfjPu2X+oq8JZont/29ceMJV9MTCGDVAoY6Boq08DmI+
 cTS495xFWRmlKWojQ8z7vxUhNp0PUJN7W9EEQBjC7eKlwhZPDc/t6oHsZlLnn5vOrJpkI1b2uGB
 VoQEVAaZSZU8DN1rB7tNKbi3+av5KtvmnDPcEZDxOtFI/f85CQgDatjSdqWg==
X-Received: by 2002:a05:6830:a91:b0:7dc:e08d:d9ec with SMTP id
 46e09a7af769-7e5ec43b7b4mr757223a34.15.1779349231476; 
 Thu, 21 May 2026 00:40:31 -0700 (PDT)
Received: from ausc-rvsw-c-01-anton.tail89d63.ts.net ([38.104.49.66])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55bc13a0asm15149103a34.21.2026.05.21.00.40.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 00:40:30 -0700 (PDT)
From: Anton Blanchard <antonb@tenstorrent.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: alistair.francis@wdc.com,
	Anton Blanchard <antonb@tenstorrent.com>
Subject: [PATCH] target/riscv: Use float_raise
Date: Thu, 21 May 2026 07:40:16 +0000
Message-Id: <20260521074016.1065645-1-antonb@tenstorrent.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=antonb@tenstorrent.com; helo=mail-ot1-x32b.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Use float_raise instead of open coding it.

Signed-off-by: Anton Blanchard <antonb@tenstorrent.com>
---
 target/riscv/vector_helper.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index c4e150635e..72ea431746 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -4124,7 +4124,7 @@ static float16 frsqrt7_h(float16 f, float_status *s)
         (float16_is_infinity(f) && sign) ||
         (float16_is_normal(f) && sign) ||
         (float16_is_zero_or_denormal(f) && !float16_is_zero(f) && sign)) {
-        s->float_exception_flags |= float_flag_invalid;
+        float_raise(float_flag_invalid, s);
         return float16_default_nan(s);
     }
 
@@ -4135,7 +4135,7 @@ static float16 frsqrt7_h(float16 f, float_status *s)
 
     /* frsqrt7(+-0) = +-inf */
     if (float16_is_zero(f)) {
-        s->float_exception_flags |= float_flag_divbyzero;
+        float_raise(float_flag_divbyzero, s);
         return float16_set_sign(float16_infinity, sign);
     }
 
@@ -4164,7 +4164,7 @@ static float32 frsqrt7_s(float32 f, float_status *s)
         (float32_is_infinity(f) && sign) ||
         (float32_is_normal(f) && sign) ||
         (float32_is_zero_or_denormal(f) && !float32_is_zero(f) && sign)) {
-        s->float_exception_flags |= float_flag_invalid;
+        float_raise(float_flag_invalid, s);
         return float32_default_nan(s);
     }
 
@@ -4175,7 +4175,7 @@ static float32 frsqrt7_s(float32 f, float_status *s)
 
     /* frsqrt7(+-0) = +-inf */
     if (float32_is_zero(f)) {
-        s->float_exception_flags |= float_flag_divbyzero;
+        float_raise(float_flag_divbyzero, s);
         return float32_set_sign(float32_infinity, sign);
     }
 
@@ -4204,7 +4204,7 @@ static float64 frsqrt7_d(float64 f, float_status *s)
         (float64_is_infinity(f) && sign) ||
         (float64_is_normal(f) && sign) ||
         (float64_is_zero_or_denormal(f) && !float64_is_zero(f) && sign)) {
-        s->float_exception_flags |= float_flag_invalid;
+        float_raise(float_flag_invalid, s);
         return float64_default_nan(s);
     }
 
@@ -4215,7 +4215,7 @@ static float64 frsqrt7_d(float64 f, float_status *s)
 
     /* frsqrt7(+-0) = +-inf */
     if (float64_is_zero(f)) {
-        s->float_exception_flags |= float_flag_divbyzero;
+        float_raise(float_flag_divbyzero, s);
         return float64_set_sign(float64_infinity, sign);
     }
 
@@ -4285,8 +4285,7 @@ static uint64_t frec7(uint64_t f, int exp_size, int frac_size,
              * Overflow to inf or max value of same sign,
              * depending on sign and rounding mode.
              */
-            s->float_exception_flags |= (float_flag_inexact |
-                                         float_flag_overflow);
+            float_raise(float_flag_inexact | float_flag_overflow, s);
 
             if ((s->float_rounding_mode == float_round_to_zero) ||
                 ((s->float_rounding_mode == float_round_down) && !sign) ||
@@ -4370,13 +4369,13 @@ static float16 frec7_h(float16 f, float_status *s)
 
     /* frec7(+-0) = +-inf */
     if (float16_is_zero(f)) {
-        s->float_exception_flags |= float_flag_divbyzero;
+        float_raise(float_flag_divbyzero, s);
         return float16_set_sign(float16_infinity, sign);
     }
 
     /* frec7(sNaN) = canonical NaN */
     if (float16_is_signaling_nan(f, s)) {
-        s->float_exception_flags |= float_flag_invalid;
+        float_raise(float_flag_invalid, s);
         return float16_default_nan(s);
     }
 
@@ -4402,13 +4401,13 @@ static float32 frec7_s(float32 f, float_status *s)
 
     /* frec7(+-0) = +-inf */
     if (float32_is_zero(f)) {
-        s->float_exception_flags |= float_flag_divbyzero;
+        float_raise(float_flag_divbyzero, s);
         return float32_set_sign(float32_infinity, sign);
     }
 
     /* frec7(sNaN) = canonical NaN */
     if (float32_is_signaling_nan(f, s)) {
-        s->float_exception_flags |= float_flag_invalid;
+        float_raise(float_flag_invalid, s);
         return float32_default_nan(s);
     }
 
@@ -4434,13 +4433,13 @@ static float64 frec7_d(float64 f, float_status *s)
 
     /* frec7(+-0) = +-inf */
     if (float64_is_zero(f)) {
-        s->float_exception_flags |= float_flag_divbyzero;
+        float_raise(float_flag_divbyzero, s);
         return float64_set_sign(float64_infinity, sign);
     }
 
     /* frec7(sNaN) = canonical NaN */
     if (float64_is_signaling_nan(f, s)) {
-        s->float_exception_flags |= float_flag_invalid;
+        float_raise(float_flag_invalid, s);
         return float64_default_nan(s);
     }
 
-- 
2.34.1


