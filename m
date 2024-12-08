Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CD30E77181
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Dec 2024 22:50:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKQ5S-0007Dp-Sx; Sun, 08 Dec 2024 17:49:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tKQ5L-0007Cg-Iv
 for qemu-devel@nongnu.org; Sun, 08 Dec 2024 17:49:07 -0500
Received: from mail-oo1-xc2f.google.com ([2607:f8b0:4864:20::c2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tKQ5K-0006GC-3y
 for qemu-devel@nongnu.org; Sun, 08 Dec 2024 17:49:07 -0500
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-5f22ea6d874so1790145eaf.1
 for <qemu-devel@nongnu.org>; Sun, 08 Dec 2024 14:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733698145; x=1734302945; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z5ajRnZi43a4zINRic96225Rmi62CthD3E3UTNaO55s=;
 b=A7DGoGTM7nxRAvX7/wWBYYpf+TJIfiqGu8GyVJQFM8DBuvCNrp3o4h2OexyUWRnjMm
 el1c3pdztSzIaLyVWJr9wbfg7Ax58Hcjgd8od1M8TuBPPc0F6isq52RHjMVsN+YYkh0t
 1kff6Q2cCkmAoeN7dtwdwcybkkFGWb6EOkCY8Hzu13hgkjMB68LcVPnljoXADaRdkQyD
 5o7JCefMctNbRP73ihcXDmAz1zjH3xtmElnY/fI1Jf2icA58eg9pQyeXakBhLcrao4rV
 DBBjlNKsD5Iz3+Ta+c5D8lAe8TGZ4m8TRkh0WCR9S/DJGOxuHjHwgZRUgLalj2XYhd9O
 XIGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733698145; x=1734302945;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z5ajRnZi43a4zINRic96225Rmi62CthD3E3UTNaO55s=;
 b=ftFwynFszha9UrXy6c3EbFaSgtuHmzMqZDuUEqXdeXh1CFCbdQW81yUOA57OeJpiXl
 UqCcynuW5b0fLyfALFMPgrpks//BwvXj7EorTkJJgJcvxAzp0hkqToIngBYJ6MRVM0mw
 XCGaLhjp+Mu8Uwsb6u/pcT5qDsDNn3nXma2sV2oevri+msOdvqi3q3n0/Z1blr9Jla2d
 gqqHpQIzhDi0UA71BOCY2RmgiPcDQuCJ2tEYJ630wnoYqpEjs+2dBjRGCSQGOsWjZtvF
 oSUur87X7gRJNYE+W/fYv7GAYiU6vU8XTHFzEYSiZ44PasCD42+jKDKRM0/QU2bwmKkR
 KDPA==
X-Gm-Message-State: AOJu0YwLcnUbYfrTh97r11c/0GWEqZQbz8tTytqDO+CP+yqflAk6egrc
 oHwk0mDHjM5SjGv3lwZe5DvcOopCl1NuoGXvAieFbaG34R43Rw8zm25LTjw+8NcrORqxlU0sWlW
 sK8gfOA==
X-Gm-Gg: ASbGncuiZDjukfoi52HzZMrunE/fHuBa6nezgDNcng3IGV1rlNcUnz/zP7Hhroh8gXj
 aPAAFqWPoN8QwMFDvM35Pach+pqPOAylqxqyrdO2oqcnEkomofNFYAVgXFt5y/+SNj8FTBpA8ke
 ktAfxn0kyfDfu8wdFV8E1gjnhFS5EW6z7hmFuvs0yKMfZxkITVMLuvP5mqRRwOiSM6VDoi8M7Ru
 k5EGjyzncoitlEuj/KxX8I6wRRwTugG/zTcv6uvqWp3xTukXMOLa64arCyzm4LvpOp8/aA9QWsT
 ePbRhEI97nXY/R/JlnEhKN3gUv5NQoUpZzRd
X-Google-Smtp-Source: AGHT+IEJUal97o/kNIVY4RIdeHDF261vJEu2lfkIE5srkBUdGdzX61eIJ3sUN38k2EvkyU6nV8Y9xQ==
X-Received: by 2002:a05:6820:1998:b0:5f2:af90:e90 with SMTP id
 006d021491bc7-5f2af901244mr2595035eaf.3.1733698145043; 
 Sun, 08 Dec 2024 14:49:05 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71dc497ee8fsm1925198a34.39.2024.12.08.14.49.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Dec 2024 14:49:04 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: bcain@oss.qualcomm.com, peter.maydell@linaro.org,
 mark.cave-ayland@ilande.co.uk
Subject: [PATCH 15/17] target/hexagon: Remove Double
Date: Sun,  8 Dec 2024 16:48:42 -0600
Message-ID: <20241208224844.570491-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241208224844.570491-1-richard.henderson@linaro.org>
References: <20241208224844.570491-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2f.google.com
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

This structure, with bitfields, is incorrect for big-endian.
Use extract64 and deposit64 instead.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hexagon/fma_emu.c | 46 ++++++++++++++--------------------------
 1 file changed, 16 insertions(+), 30 deletions(-)

diff --git a/target/hexagon/fma_emu.c b/target/hexagon/fma_emu.c
index c359eecffd..343c40a686 100644
--- a/target/hexagon/fma_emu.c
+++ b/target/hexagon/fma_emu.c
@@ -43,39 +43,29 @@
 
 #define WAY_BIG_EXP 4096
 
-typedef union {
-    double f;
-    uint64_t i;
-    struct {
-        uint64_t mant:52;
-        uint64_t exp:11;
-        uint64_t sign:1;
-    };
-} Double;
-
 static uint64_t float64_getmant(float64 f64)
 {
-    Double a = { .i = f64 };
+    uint64_t mant = extract64(f64, 0, 52);
     if (float64_is_normal(f64)) {
-        return a.mant | 1ULL << 52;
+        return mant | 1ULL << 52;
     }
     if (float64_is_zero(f64)) {
         return 0;
     }
     if (float64_is_denormal(f64)) {
-        return a.mant;
+        return mant;
     }
     return ~0ULL;
 }
 
 int32_t float64_getexp(float64 f64)
 {
-    Double a = { .i = f64 };
+    int exp = extract64(f64, 52, 11);
     if (float64_is_normal(f64)) {
-        return a.exp;
+        return exp;
     }
     if (float64_is_denormal(f64)) {
-        return a.exp + 1;
+        return exp + 1;
     }
     return -1;
 }
@@ -346,6 +336,8 @@ float32 infinite_float32(uint8_t sign)
 /* Return a maximum finite value with the requested sign */
 static float64 accum_round_float64(Accum a, float_status * fp_status)
 {
+    uint64_t ret;
+
     if ((int128_gethi(a.mant) == 0) && (int128_getlo(a.mant) == 0)
         && ((a.guard | a.round | a.sticky) == 0)) {
         /* result zero */
@@ -453,22 +445,16 @@ static float64 accum_round_float64(Accum a, float_status * fp_status)
         }
     }
     /* Underflow? */
-    if (int128_getlo(a.mant) & (1ULL << DF_MANTBITS)) {
+    ret = int128_getlo(a.mant);
+    if (ret & (1ULL << DF_MANTBITS)) {
         /* Leading one means: No, we're normal. So, we should be done... */
-        Double ret;
-        ret.i = 0;
-        ret.sign = a.sign;
-        ret.exp = a.exp;
-        ret.mant = int128_getlo(a.mant);
-        return ret.i;
+        ret = deposit64(ret, 52, 11, a.exp);
+    } else {
+        assert(a.exp == 1);
+        ret = deposit64(ret, 52, 11, 0);
     }
-    assert(a.exp == 1);
-    Double ret;
-    ret.i = 0;
-    ret.sign = a.sign;
-    ret.exp = 0;
-    ret.mant = int128_getlo(a.mant);
-    return ret.i;
+    ret = deposit64(ret, 63, 1, a.sign);
+    return ret;
 }
 
 float64 internal_mpyhh(float64 a, float64 b,
-- 
2.43.0


