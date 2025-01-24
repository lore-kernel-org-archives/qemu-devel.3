Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FAA8C02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 16:41:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbMgm-0006ux-5i; Fri, 24 Jan 2025 11:37:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMZY-00064L-72
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:30:28 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMZR-00062p-MM
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:30:19 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4362f61757fso23853085e9.2
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 08:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737736210; x=1738341010; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vF2AaEc13GOjZXFd5xHueWajog0n73mmADepNcW83nk=;
 b=Kd/CAOUykEVGtdJaSe1sWeB6K97BzSroTIJ5rO8c086VeOWrLdog8+2hZUWtbqX779
 UeCnOYc5Qs/D5yvsCuobiDRiX3yCWIk8hEtXjzXax59QbytobZ2LzsPZpRAVZ2M40zOt
 Spi8b5T27EsQX7qFpj2azPr68btVz8ujfwE2DQmiGVsEnt5dmKpdRmajalfmiqqhwsPN
 CysJDHV80A2g7nfNoNOcEJ69sLcH88+IR8XW/EyYK/LKHmyLryCmb5sU5YlZLSUN6wtu
 F7K71TaT94GMnl27/od/2A7mo5ydUCXdu14n9vySN40XmnDbTqARGsJKfKsdylQ80O0A
 Lm/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737736210; x=1738341010;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vF2AaEc13GOjZXFd5xHueWajog0n73mmADepNcW83nk=;
 b=cGvuMo5TCXy0iK7MpomUnlu9J46+GnrB2abjlWjlc9gHCnq2C00zkq+KEZwZiEZJSx
 bHYZfrw5IjqiMsYs/CDcwVO1qqMVREWZw3sTa9e1YCHNw9rCM2h+NuM5LqZwb8EJ9JuY
 9Q7K9k6+Z95FnqfL6qYVZ4+3MGBY0saciqx4oASdVMkhmSVKI1pX7HCvAW/PBVv0fKLP
 YycJgntR+Av+57D1OwL++EN6COmSkBvFkjkQvrfk2eXTWqe/Yet7UJlbMyNLKpNQr1ri
 rYv9OOTzWdpLFbJBPgpRYZkgQLpQaknENAaQ5LL5PS8tcLsOkFyL8oGUspIxuT8tTCMm
 UAZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXW+i/wU+aFolZ3pdV+pfzvIP95JBJ2H60XPkgoIAVhSAKBDrI0HdjHUJq35fBqlKdr1vNhegtRnWGk@nongnu.org
X-Gm-Message-State: AOJu0YwzQNJc77hy6uVSiEJduPK9Dp9Dm7OEypYRo0pDUa10wCWa0oS8
 mh5j6QBDlzGSf91DVqoaUPI+3MWwEc4Ag01xc+SXdbsaRjwjNIxkn8XY1nqKul7VGsgQeYJQQbV
 B
X-Gm-Gg: ASbGncvM7Z0Xld70FRZvnfn7HI3XF1dvFQVHJmaZKqWcx50E4OS8lkhArUfXWYpkG7k
 y8UxJ3iGhXwYr5bSkz17utwjiVnftsHNGPylTZY5F+tR4LOHnxJVljh2yf4oyX9bULN3m91GLST
 OEnPUoysnWmE8xTnrnq3HMSNmd4yGl9vIbgwUrneBEm6NOrAJdohD4QHjitzB6LctWM5zTp9VCP
 8WoXSJZ8Xjj6JDIDGDhH8kCXQF/69cBbNnAJxZpQY5OViMH2W/1zNqZdpDd/Xc/ggHEuG7yVmDP
 qTXThv3hNKY=
X-Google-Smtp-Source: AGHT+IEX1UTMHShC8q9HsaQL+0EzsQfDtCrsJ20olujPskLogmrt4CtHHrBmwdlkV1tsEfcxaighgw==
X-Received: by 2002:adf:e404:0:b0:38b:f074:214c with SMTP id
 ffacd0b85a97d-38bf5674039mr18896227f8f.30.1737736208512; 
 Fri, 24 Jan 2025 08:30:08 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd47eecasm31683025e9.6.2025.01.24.08.30.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 08:30:07 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 71/76] target/arm: Implement increased precision FRSQRTE
Date: Fri, 24 Jan 2025 16:28:31 +0000
Message-Id: <20250124162836.2332150-72-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250124162836.2332150-1-peter.maydell@linaro.org>
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Implement the increased precision variation of FRSQRTE.  In the
pseudocode this corresponds to the handling of the
"increasedprecision" boolean in the FPRSqrtEstimate() and
RecipSqrtEstimate() functions.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/vfp_helper.c | 77 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 64 insertions(+), 13 deletions(-)

diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index 79e58c5bb2a..e63455c4bb9 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -1013,8 +1013,36 @@ static int do_recip_sqrt_estimate(int a)
     return estimate;
 }
 
+static int do_recip_sqrt_estimate_incprec(int a)
+{
+    /*
+     * The Arm ARM describes the 12-bit precision version of RecipSqrtEstimate
+     * in terms of an infinite-precision floating point calculation of a
+     * square root. We implement this using the same kind of pure integer
+     * algorithm as the 8-bit mantissa, to get the same bit-for-bit result.
+     */
+    int64_t b, estimate;
 
-static uint64_t recip_sqrt_estimate(int *exp , int exp_off, uint64_t frac)
+    assert(1024 <= a && a < 4096);
+    if (a < 2048) {
+        a = a * 2 + 1;
+    } else {
+        a = (a >> 1) << 1;
+        a = (a + 1) * 2;
+    }
+    b = 8192;
+    while (a * (b + 1) * (b + 1) < (1ULL << 39)) {
+        b += 1;
+    }
+    estimate = (b + 1) / 2;
+
+    assert(4096 <= estimate && estimate < 8192);
+
+    return estimate;
+}
+
+static uint64_t recip_sqrt_estimate(int *exp , int exp_off, uint64_t frac,
+                                    bool increasedprecision)
 {
     int estimate;
     uint32_t scaled;
@@ -1027,17 +1055,32 @@ static uint64_t recip_sqrt_estimate(int *exp , int exp_off, uint64_t frac)
         frac = extract64(frac, 0, 51) << 1;
     }
 
-    if (*exp & 1) {
-        /* scaled = UInt('01':fraction<51:45>) */
-        scaled = deposit32(1 << 7, 0, 7, extract64(frac, 45, 7));
+    if (increasedprecision) {
+        if (*exp & 1) {
+            /* scaled = UInt('01':fraction<51:42>) */
+            scaled = deposit32(1 << 10, 0, 10, extract64(frac, 42, 10));
+        } else {
+            /* scaled = UInt('1':fraction<51:41>) */
+            scaled = deposit32(1 << 11, 0, 11, extract64(frac, 41, 11));
+        }
+        estimate = do_recip_sqrt_estimate_incprec(scaled);
     } else {
-        /* scaled = UInt('1':fraction<51:44>) */
-        scaled = deposit32(1 << 8, 0, 8, extract64(frac, 44, 8));
+        if (*exp & 1) {
+            /* scaled = UInt('01':fraction<51:45>) */
+            scaled = deposit32(1 << 7, 0, 7, extract64(frac, 45, 7));
+        } else {
+            /* scaled = UInt('1':fraction<51:44>) */
+            scaled = deposit32(1 << 8, 0, 8, extract64(frac, 44, 8));
+        }
+        estimate = do_recip_sqrt_estimate(scaled);
     }
-    estimate = do_recip_sqrt_estimate(scaled);
 
     *exp = (exp_off - *exp) / 2;
-    return extract64(estimate, 0, 8) << 44;
+    if (increasedprecision) {
+        return extract64(estimate, 0, 12) << 40;
+    } else {
+        return extract64(estimate, 0, 8) << 44;
+    }
 }
 
 uint32_t HELPER(rsqrte_f16)(uint32_t input, float_status *s)
@@ -1076,7 +1119,7 @@ uint32_t HELPER(rsqrte_f16)(uint32_t input, float_status *s)
 
     f64_frac = ((uint64_t) f16_frac) << (52 - 10);
 
-    f64_frac = recip_sqrt_estimate(&f16_exp, 44, f64_frac);
+    f64_frac = recip_sqrt_estimate(&f16_exp, 44, f64_frac, false);
 
     /* result = sign : result_exp<4:0> : estimate<7:0> : Zeros(2) */
     val = deposit32(0, 15, 1, f16_sign);
@@ -1125,12 +1168,20 @@ static float32 do_rsqrte_f32(float32 input, float_status *s, bool rpres)
 
     f64_frac = ((uint64_t) f32_frac) << 29;
 
-    f64_frac = recip_sqrt_estimate(&f32_exp, 380, f64_frac);
+    f64_frac = recip_sqrt_estimate(&f32_exp, 380, f64_frac, rpres);
 
-    /* result = sign : result_exp<4:0> : estimate<7:0> : Zeros(15) */
+    /*
+     * result = sign : result_exp<7:0> : estimate<7:0> : Zeros(15)
+     * or for increased precision
+     * result = sign : result_exp<7:0> : estimate<11:0> : Zeros(11)
+     */
     val = deposit32(0, 31, 1, f32_sign);
     val = deposit32(val, 23, 8, f32_exp);
-    val = deposit32(val, 15, 8, extract64(f64_frac, 52 - 8, 8));
+    if (rpres) {
+        val = deposit32(val, 11, 12, extract64(f64_frac, 52 - 12, 12));
+    } else {
+        val = deposit32(val, 15, 8, extract64(f64_frac, 52 - 8, 8));
+    }
     return make_float32(val);
 }
 
@@ -1174,7 +1225,7 @@ float64 HELPER(rsqrte_f64)(float64 input, float_status *s)
         return float64_zero;
     }
 
-    f64_frac = recip_sqrt_estimate(&f64_exp, 3068, f64_frac);
+    f64_frac = recip_sqrt_estimate(&f64_exp, 3068, f64_frac, false);
 
     /* result = sign : result_exp<4:0> : estimate<7:0> : Zeros(44) */
     val = deposit64(0, 61, 1, f64_sign);
-- 
2.34.1


