Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1F8BC0219B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 16:27:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tht6c-0008I4-7F; Tue, 11 Feb 2025 11:27:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht67-0006uF-Vz
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:27:00 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht66-0003Xu-51
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:26:55 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-439566c991dso4019505e9.3
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 08:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739291213; x=1739896013; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hiBHAdbEt4XuWsPzDU56l/AtywnjU22PdAypvJwncIU=;
 b=Vjy86jvF5uiYCQQy86+MKC0pTg+FhCM1//eXCer9T3sscqfGRbPMtGdW2oFWlRf8jq
 Dg0mfGQjn8W8tmAwrpGNwlxlm/BdT/SaEtHLIpwADxGVEuyQ/sv5plajHTQzbTTp9W7C
 10m5hQ/uFVndgTXCgVOz7exnR6R6Cy4dRlXJFU+mEyJG45QrtjpnG0nB9dOsQyxMiXUa
 WIlFF+ePTyqfOIw9oX8YOkb81uD3imVGBuEecXI/cj02qA1W3fp/4YOHSLGiF5KdXxsA
 0BAT0zg9dJtOUnhoHG2XpT7uHSaWaL6vprEXFAvY/LpLQLhn0MhsQERVSJu7C1iESVHD
 +XgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739291213; x=1739896013;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hiBHAdbEt4XuWsPzDU56l/AtywnjU22PdAypvJwncIU=;
 b=TxlPym1PWpRXFTvLLGpBR8+FRu4XCks0h+y4FctbF0fDQLYahOqrjikfAg9GQjaIME
 avCPL4Wd61/++huP8Ue81BnKaPK0G2wzGEcswqQ4f6UlDdZ3w2lFWLFESSdT3sTk2RKK
 5WMWWgMLW8dR3SqtRMAHlygUfv48ROWOn+9Jx0aiFmNli/BdxcL0iINiFgyRLXRhE/TH
 mhmdbbOk6NOBG9w81q/LW2x2iyt7lWDCmyw4RLW2FqXX6kLiidmjnx+dF2y94DCv9OdB
 G+8ZOJUOn3D034O9nsoxU89X7YnxAgtTGii6Qzi/E39648AwaDYR6RwaSL0LKBIjp3U3
 /Puw==
X-Gm-Message-State: AOJu0YzfsK5fp9wdKY2eY2ttzGiURF7EpgUDlet3LWDsBBUXP5UmLl1F
 wCz196EYpY0Tj7KzFcmgvG03xut5UdErVifKZiV7CkD70v7StNAMUv01ZJhhowz6WxGp3NBqy3l
 d
X-Gm-Gg: ASbGncsbS48YXcvV8FB8S+YYpY4DuXsZmkSRNqoUq3FJvMnc3U5kwLI9oLL95GbxP0j
 u4VFmcEfXEnEP5/E9IaTRYTH7mPqTWyDIfeiyktlcZlqZc9wWxMC0Tz+2kdwUgm5e/22XYbdB69
 YYn/btKkIIx/IyVWr8bKi+Rjo0da26hSLZz+uPDA6fv6vrFTWN2VpmbrA16PqwS1zElRQQYkWeE
 dJB2hWjRbYJSbN4Tq3xxeVhDQeQtg2Xy6JYakssgsXEZo23nnztOyT/CJpMYFV3ZUmpmpPFlaB8
 IR6bDFs3vqc/I9//YZlC
X-Google-Smtp-Source: AGHT+IGRm+tjOH4yo6XPazpVn9pOEHJhbY8dvEuyKnlKbOnzK/xnoEQD3OgjfqTT0xKEsW2JNe3sKw==
X-Received: by 2002:a05:600c:5101:b0:439:4b3c:3b1b with SMTP id
 5b1f17b1804b1-4394b3c3c6amr53743105e9.27.1739291212589; 
 Tue, 11 Feb 2025 08:26:52 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4393f202721sm82660455e9.21.2025.02.11.08.26.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 08:26:51 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 53/68] target/arm: Implement increased precision FRECPE
Date: Tue, 11 Feb 2025 16:25:39 +0000
Message-Id: <20250211162554.4135349-54-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250211162554.4135349-1-peter.maydell@linaro.org>
References: <20250211162554.4135349-1-peter.maydell@linaro.org>
MIME-Version: 1.0
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
index b97417e5a1a..2df97e128f2 100644
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


