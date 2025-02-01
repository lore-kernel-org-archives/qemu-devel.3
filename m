Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F2D3C0218A
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2025 16:46:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1teGZA-0000Ty-CI; Sat, 01 Feb 2025 11:41:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1teGYh-0007Qa-Sk
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 11:41:31 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1teGYg-0001KZ-7m
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 11:41:27 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-385ddcfc97bso2352724f8f.1
 for <qemu-devel@nongnu.org>; Sat, 01 Feb 2025 08:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738428084; x=1739032884; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=d1SJp6I7AlCA4kZTsBOFcEAV+TEu2VlXrIhZIYrHFxk=;
 b=qSYPHnlxABzIaiBkrvhhQnSEusVIS7o0sZFrtTPSWzo62dsu9tq/hXlQiA2cisrcYU
 vDmDO9I0D2vEdu3rlOmvX271AK4y+K12GaWoKvOK96fOzoyEDgMHlpwh6qHhUNqEbIbm
 iMGlXXHIOQgHIiPba+Mopkz1kVW+5gCEzw9l2A4YEp43x+V/WymPsDUlgBMTo3aHsXv4
 1W5bmA/jqscuZrHmkVXkH71mXXu9UPKIDkBhhLlyHCH6bb/zjsEXmaP/oHGu/GuEBOji
 LRMGOfosswteQec861Uhta6zb1I69E3KYUDfRYxdfY9oHmGBYYB8ioH6xhKz7GGRHdeu
 RKIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738428084; x=1739032884;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d1SJp6I7AlCA4kZTsBOFcEAV+TEu2VlXrIhZIYrHFxk=;
 b=HZdl1R62pF+VfFKaGOkLWCxfjmEorYpJkrk24Ddz0TZeFzIt1YXfoRV9nbBFOgdNN9
 Kuw0utp1vCGFGLn0wBWyL1L1HkXiCouFLBs+8fxdU/m3CR0191MDBifm+WIUc250hxMN
 tnrhMh0bCOS7Ajgtr3nCQ6iNsd6jwKOuDMmzWhKOFBHAabGbdCS48RPwbc3m93I/holl
 9MT9LkSDMgSqawpVWT5XZbdaoe2olJwmwMXhZHtfhW52PVAmYR95C6gUhM+EVM6w+9pr
 nWMVCYJvhf92f9eXJ10IdTZxO3fO20xfOFs7svfDqUgxUh0duOwGF2KttsiVEhoG1Ove
 5rjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcoHN2USOX5+w8viQAlsQf9SQAxaHVCJiUSiV2V2oGgW4P4hse1rssQfY5t+bPSZmGXHC8EWcv/5NB@nongnu.org
X-Gm-Message-State: AOJu0YxfLFa95JkhrS9Y74F2lC3rJf09f5afjfTV5QNBT4/0H4LpCquo
 gqaGf/uSL/U6ZhcQiV78CzzznuNkuFu+gguNDmNsOjPT7QRaFsvM7eAqAIk01C0=
X-Gm-Gg: ASbGncvMibNe48F43Bl3+K0U1AGzpqWXF5seFhGUnKEUGT2aJNZhTPz0YMsvORWEtRg
 SnWz6rPrViWNZ7wp53t0KEe61nz7bQw1wgkG4EeeCRGH2b/S08oO5InIBb1nfZk7F1j2lbI9wPN
 q28Z+L1h3N80wCOorf66IReJzQ+j4bEw8X8X0gkqfVjroJUza71Lwc2b56dkgRGOWvp8TB7JyyA
 5DKYf7aru6RAFzrozder5Tn2b2KFaOmrKQh8XXHw33S82x+XbUt+2NwNOBNXHqfrvPo5zYHBW9g
 NJCuuh1fS4Mz//bnKdfy
X-Google-Smtp-Source: AGHT+IEL3g9fCPW/5yXXgQ6NaZQUhxXeNpc11useA/vaj2W+3+Kid3s1OGDWjyXmchccODNzwcDlKQ==
X-Received: by 2002:a05:6000:154e:b0:38a:88bc:d57d with SMTP id
 ffacd0b85a97d-38c5192f555mr11836404f8f.2.1738428083734; 
 Sat, 01 Feb 2025 08:41:23 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc81d74sm127401525e9.37.2025.02.01.08.41.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Feb 2025 08:41:23 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 54/69] target/arm: Implement increased precision FRECPE
Date: Sat,  1 Feb 2025 16:39:57 +0000
Message-Id: <20250201164012.1660228-55-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250201164012.1660228-1-peter.maydell@linaro.org>
References: <20250201164012.1660228-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
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

Implement the increased precision variation of FRECPE.  In the
pseudocode this corresponds to the handling of the
"increasedprecision" boolean in the FPRecipEstimate() and
RecipEstimate() functions.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/vfp_helper.c | 54 +++++++++++++++++++++++++++++++++++------
 1 file changed, 46 insertions(+), 8 deletions(-)

diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index 25c3796c832..d88a0aba6a3 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -733,6 +733,33 @@ static int recip_estimate(int input)
     return r;
 }
 
+/*
+ * Increased precision version:
+ * input is a 13 bit fixed point number
+ * input range 2048 .. 4095 for a number from 0.5 <= x < 1.0.
+ * result range 4096 .. 8191 for a number from 1.0 to 2.0
+ */
+static int recip_estimate_incprec(int input)
+{
+    int a, b, r;
+    assert(2048 <= input && input < 4096);
+    a = (input * 2) + 1;
+    /*
+     * The pseudocode expresses this as an operation on infinite
+     * precision reals where it calculates 2^25 / a and then looks
+     * at the error between that and the rounded-down-to-integer
+     * value to see if it should instead round up. We instead
+     * follow the same approach as the pseudocode for the 8-bit
+     * precision version, and calculate (2 * (2^25 / a)) as an
+     * integer so we can do the "add one and halve" to round it.
+     * So the 1 << 26 here is correct.
+     */
+    b = (1 << 26) / a;
+    r = (b + 1) >> 1;
+    assert(4096 <= r && r < 8192);
+    return r;
+}
+
 /*
  * Common wrapper to call recip_estimate
  *
@@ -742,7 +769,8 @@ static int recip_estimate(int input)
  * callee.
  */
 
-static uint64_t call_recip_estimate(int *exp, int exp_off, uint64_t frac)
+static uint64_t call_recip_estimate(int *exp, int exp_off, uint64_t frac,
+                                    bool increasedprecision)
 {
     uint32_t scaled, estimate;
     uint64_t result_frac;
@@ -758,12 +786,22 @@ static uint64_t call_recip_estimate(int *exp, int exp_off, uint64_t frac)
         }
     }
 
-    /* scaled = UInt('1':fraction<51:44>) */
-    scaled = deposit32(1 << 8, 0, 8, extract64(frac, 44, 8));
-    estimate = recip_estimate(scaled);
+    if (increasedprecision) {
+        /* scaled = UInt('1':fraction<51:41>) */
+        scaled = deposit32(1 << 11, 0, 11, extract64(frac, 41, 11));
+        estimate = recip_estimate_incprec(scaled);
+    } else {
+        /* scaled = UInt('1':fraction<51:44>) */
+        scaled = deposit32(1 << 8, 0, 8, extract64(frac, 44, 8));
+        estimate = recip_estimate(scaled);
+    }
 
     result_exp = exp_off - *exp;
-    result_frac = deposit64(0, 44, 8, estimate);
+    if (increasedprecision) {
+        result_frac = deposit64(0, 40, 12, estimate);
+    } else {
+        result_frac = deposit64(0, 44, 8, estimate);
+    }
     if (result_exp == 0) {
         result_frac = deposit64(result_frac >> 1, 51, 1, 1);
     } else if (result_exp == -1) {
@@ -832,7 +870,7 @@ uint32_t HELPER(recpe_f16)(uint32_t input, float_status *fpst)
     }
 
     f64_frac = call_recip_estimate(&f16_exp, 29,
-                                   ((uint64_t) f16_frac) << (52 - 10));
+                                   ((uint64_t) f16_frac) << (52 - 10), false);
 
     /* result = sign : result_exp<4:0> : fraction<51:42> */
     f16_val = deposit32(0, 15, 1, f16_sign);
@@ -885,7 +923,7 @@ static float32 do_recpe_f32(float32 input, float_status *fpst, bool rpres)
     }
 
     f64_frac = call_recip_estimate(&f32_exp, 253,
-                                   ((uint64_t) f32_frac) << (52 - 23));
+                                   ((uint64_t) f32_frac) << (52 - 23), rpres);
 
     /* result = sign : result_exp<7:0> : fraction<51:29> */
     f32_val = deposit32(0, 31, 1, f32_sign);
@@ -943,7 +981,7 @@ float64 HELPER(recpe_f64)(float64 input, float_status *fpst)
         return float64_set_sign(float64_zero, float64_is_neg(f64));
     }
 
-    f64_frac = call_recip_estimate(&f64_exp, 2045, f64_frac);
+    f64_frac = call_recip_estimate(&f64_exp, 2045, f64_frac, false);
 
     /* result = sign : result_exp<10:0> : fraction<51:0>; */
     f64_val = deposit64(0, 63, 1, f64_sign);
-- 
2.34.1


