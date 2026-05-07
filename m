Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39422CD343F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 22:18:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL72M-0000sx-VS; Thu, 07 May 2026 18:17:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL72J-0000s2-Qf
 for qemu-devel@nongnu.org; Thu, 07 May 2026 18:17:39 -0400
Received: from mail-oa1-x36.google.com ([2001:4860:4864:20::36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL72H-0003F5-1H
 for qemu-devel@nongnu.org; Thu, 07 May 2026 18:17:39 -0400
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-4350cd5b97fso752300fac.0
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 15:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778192255; x=1778797055; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cfDp2cVCfYURQ+rFBATt97muosYYkvTYqLFUpW+zi2A=;
 b=NVfisssZBJNiQJdsAIgTxLHGxNEnjbJRISfdaF/eMCBoAEJg1iiklsrtLg/7ynKRw5
 uxkhoUow6uYnZIhnp+x6cAjXCjTb/HFUDhZUf6o1UPh0HJ0GahGzz92OrpNxsfGQsdbx
 b8wz+vveW7lH91SByKvMe8lJbYkrXOSYYZPceFGUQOQPhCA8yfsFvoZ5zTRhFUURo1qN
 8mArkwxjtiec2Dr/dDz0EkiWnahdAOLzXhstaAMUnaXnNbkWbtEraCriyBOb0pAEqLiT
 jj6qoohe85QGK1dAdFw4a1UskRyy7f35w3hrecZGbOGTbN8oThp8GDq+xfYp8qd8eplu
 gIGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778192255; x=1778797055;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=cfDp2cVCfYURQ+rFBATt97muosYYkvTYqLFUpW+zi2A=;
 b=so0mlHpmnZDqG+lz5HTiS8wJ0ZikjPm1nPnvr8NJ7R2UjchAZjiJJM6beIb+8EGrEh
 O5F0j5AxcMtbpwUUK2yq8DcWlyFxyPUu1Nv/N14CkfwFl1BATYxnJCwvKvUNONoAmebi
 3Nm8pHp8iZbyDSQ5TPLF1w2/wJU81lVlRqsLdqfpFUjnoOAJy7Hta1P/bajAFURZdazE
 uROuU9+kFtn5Igb+VFWEBLTZV9TzU07n+h1Y5/YlLYAukDmKrCedTABf6hM6vlpZhSOX
 YmosFHseNkw+B+BV8rHFzN9ItcjIG2M7YlcbajVDNlkpH2BqXavW8AEygamluTxFfFCn
 3a0g==
X-Gm-Message-State: AOJu0YyCW4zz/XVATiOp1MgF7KTymWzD9yTIvv2plU6uRTDSZuSoXa5J
 SC8VvCyeU4Wp4h22ilOoGtVQbi+KoYDMNMiH8HkiR1rPIrpZWILrOaWyuqDSwuXDg2JiKwxaT5f
 w3KKr
X-Gm-Gg: AeBDieswG+DIJmiMIP1A1AO+CyWdWAe9xV+xHF4a0fxoe1mS7cEmSAPBgdflRHH4Xyh
 8BSowAR9MViAniPOEzQjsv8CyQ0ltJEIyBMtOsn+62afcbNgfLWtfgiVYp0cARAg3Afv5oe03a+
 kVyR8VNRbehrgy9O9QxB+zctnx1uqe+A1Ee3auA059HE7e4Y0obL+Xkn8uKURALBFOJvsaih5Px
 m57UoFtDzHNq9DqWPga4whCb154O5dHRr2v9bOgF4J2mMyeRxEYiAALSAu4NBjrH4STA7VfovUC
 z4r/uwXXYVuTYeBZpoeisrbtBofxN54DR/vAi9fD+I1LITMacSZwCZbn0bvpskgzBioKlZdLcmD
 35fr8q4dtyNdoiaJq5Uaet1+KaxQdZF7B42gp8aD2WAw+bJUQ52jCri7l0/DT755vrIVCrDt+f7
 S76+e8j+PzWu7n96mr+b1vg6q3tWSYv0QQuokLaIqBaGHnjQ==
X-Received: by 2002:a05:6870:e243:b0:42c:f89:755f with SMTP id
 586e51a60fabf-434f613e1c5mr6878295fac.9.1778192255072; 
 Thu, 07 May 2026 15:17:35 -0700 (PDT)
Received: from stoup.attlocal.net ([2600:381:c938:6375:9641:bbb2:a93a:bb4c])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-435573e7254sm45037fac.14.2026.05.07.15.17.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 15:17:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 12/18] fpu: Use {get,set}_flush_to_zero everywhere
Date: Thu,  7 May 2026 17:17:11 -0500
Message-ID: <20260507221717.486023-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507221717.486023-1-richard.henderson@linaro.org>
References: <20260507221717.486023-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::36;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x36.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c             | 2 +-
 target/arm/tcg/vfp_helper.c | 6 +++---
 tests/fp/fp-bench.c         | 2 +-
 fpu/softfloat-parts.c.inc   | 4 ++--
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index b1c2b0e6e1..98cb0623ac 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -4907,7 +4907,7 @@ floatx80 roundAndPackFloatx80(FloatX80RoundPrec roundingPrecision, bool zSign,
             goto overflow;
         }
         if ( zExp <= 0 ) {
-            if (status->flush_to_zero) {
+            if (get_flush_to_zero(status)) {
                 float_raise(float_flag_output_denormal_flushed, status);
                 return packFloatx80(zSign, 0, 0);
             }
diff --git a/target/arm/tcg/vfp_helper.c b/target/arm/tcg/vfp_helper.c
index 5839e82449..495ce8a329 100644
--- a/target/arm/tcg/vfp_helper.c
+++ b/target/arm/tcg/vfp_helper.c
@@ -711,7 +711,7 @@ uint32_t HELPER(recpe_f16)(uint32_t input, float_status *fpst)
         } else {
             return float16_set_sign(float16_maxnorm, f16_sign);
         }
-    } else if (f16_exp >= 29 && fpst->flush_to_zero) {
+    } else if (f16_exp >= 29 && get_flush_to_zero(fpst)) {
         float_raise(float_flag_underflow, fpst);
         return float16_set_sign(float16_zero, float16_is_neg(f16));
     }
@@ -764,7 +764,7 @@ static float32 do_recpe_f32(float32 input, float_status *fpst, bool rpres)
         } else {
             return float32_set_sign(float32_maxnorm, f32_sign);
         }
-    } else if (f32_exp >= 253 && fpst->flush_to_zero) {
+    } else if (f32_exp >= 253 && get_flush_to_zero(fpst)) {
         float_raise(float_flag_underflow, fpst);
         return float32_set_sign(float32_zero, float32_is_neg(f32));
     }
@@ -823,7 +823,7 @@ float64 HELPER(recpe_f64)(float64 input, float_status *fpst)
         } else {
             return float64_set_sign(float64_maxnorm, f64_sign);
         }
-    } else if (f64_exp >= 2045 && fpst->flush_to_zero) {
+    } else if (f64_exp >= 2045 && get_flush_to_zero(fpst)) {
         float_raise(float_flag_underflow, fpst);
         return float64_set_sign(float64_zero, float64_is_neg(f64));
     }
diff --git a/tests/fp/fp-bench.c b/tests/fp/fp-bench.c
index 2b6f66817e..ccc561b578 100644
--- a/tests/fp/fp-bench.c
+++ b/tests/fp/fp-bench.c
@@ -675,7 +675,7 @@ static void parse_args(int argc, char *argv[])
             soft_status.flush_inputs_to_zero = 1;
             break;
         case 'Z':
-            soft_status.flush_to_zero = 1;
+            set_flush_to_zero(true, &soft_status);
             break;
         }
     }
diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index 72bbafcb13..ddef8cc089 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -421,7 +421,7 @@ static void partsN(uncanon_normal)(FloatPartsN *p, float_status *s,
             p->frac_lo &= ~round_mask;
         }
         fracN(shr)(p, frac_shift);
-    } else if (s->flush_to_zero &&
+    } else if (get_flush_to_zero(s) &&
                s->ftz_detection == float_ftz_before_rounding) {
         flags |= float_flag_output_denormal_flushed;
         p->cls = float_class_zero;
@@ -472,7 +472,7 @@ static void partsN(uncanon_normal)(FloatPartsN *p, float_status *s,
         fracN(shr)(p, frac_shift);
 
         if (is_tiny) {
-            if (s->flush_to_zero) {
+            if (get_flush_to_zero(s)) {
                 assert(s->ftz_detection == float_ftz_after_rounding);
                 flags |= float_flag_output_denormal_flushed;
                 p->cls = float_class_zero;
-- 
2.43.0


