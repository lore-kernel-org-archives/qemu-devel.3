Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA6EBCD5BAA
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 17:19:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPkZC-0001YY-Fa; Wed, 20 May 2026 13:18:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPkZA-0001Wr-TC
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:18:44 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPkZ4-0001z4-HG
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:18:44 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-3665b67ed66so3347411a91.1
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 10:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779297517; x=1779902317; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5yAk6F8ptTywGnvpoeV8kgP1093OZ9QNwCaIuesrM2U=;
 b=MGZdltYC+oxxL8yqa/07MQHdnXHoC9ujszESok4PxB/9zDW5FsfqOx+IqCIhPG6U90
 AejutDZzst4KYjvHuCYPuCKhLIWOePiJKHyOm4RfUsljJwVEQMCt+iPx9w3ygzKM+e1G
 moB9j2Ndr8vd3ePeX7/XO9H1rPxbvYm7W5aybyLVtVsuTP1wJ7N6dKvyF7jrZq4W5Jm/
 PoVSzKwEtbrNlryWRHDVTF/mfwo8onoe82XfA1s0Cp7nj+QlRsPN44s374O/FXdZcHuF
 rB6smwn8QPiCJELroPrQSgQQPxeyfGLgOhJh45XJ5vMTjGrJTbEyN+q/mLG4N7DwsE/Y
 W5/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779297517; x=1779902317;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5yAk6F8ptTywGnvpoeV8kgP1093OZ9QNwCaIuesrM2U=;
 b=C766N8Wzn0smZuu62R4w/qUqtYMp5vjx2pJp214CPmArotQdnFG6PD0RAXNcsOkdFB
 r/TAwKoYKQ1+2qWGpK6BLcRakMZ0xpRHB59sklIwr9sefFK8kojVlvHyjZ6QAZ+BnWVo
 znEEoef1AVdwy6aKQXpQU1VtdGGOv77OgaSnvMNvtgdtoZWJfVl3Z2unY7HST+Wi/LA5
 6BDGY5Pm+Mjnrqdmm4D7rLjzweC32goD3la/uQ2qE1LBzQy6Nbl0RURv+YLmpZYwpren
 KLHngpJ9REWnzBGXhveRaT4Re1sx0vp0v6kXJV7u6VH1dODlWX01kII9zGD56E0n+2Df
 +ZDg==
X-Gm-Message-State: AOJu0YyhWwRrXmekaRcGXuQNOIjavbgg+EyxWmXCynWR72UfR3DNZZFJ
 NB4Q4HrkRs8sJZC5SP6PUho6q1R04OoI2sE6I5YG3sj11Y/vBFwcQwgONooxSWQadGLB6K93Kmx
 dd5Spi3M=
X-Gm-Gg: Acq92OGbq3RBFCTCDTEkh7nFZm2UIEQNnw0DzxxjxVH18nKNLa74kOwOedtSyRO3a9B
 4QRroZVUx47cOCVRqVfSNlDrbdcXw2QGzG4nJC2mKxPRw1YY5Zmr/gKwiZlfKOdRtUXTrSHEBiO
 Vmnj+orhs7V1hqVaiMu/8gUjwHRpopklsIHk+/FX9ul9sTMFIE0vG2FG0eVzkEsZlScepOGQRVb
 9hvqfcUFH8ASY0i35yKbOBLA62xj+Ru1lPx4FmBRzvR7+qkB917OXeh6V/ozWRxIgacq2+4iTLq
 NJRkSRMGBqaS1QVCPxJ17RNtkJFlqnbgLM0z80XZCn0cGCrkVHjFDW4beLdGxTBit4qIQBIL/Mc
 zYwQXN+Z9idJ4UlwwrBFCsBNmfEU0BilF4URf0U9eyPCk/1KpuQ/Gk4io97nzVyCyvbwolOLMxT
 bTkvkZReS1F7y6hqbqzqUyo+4Qg6tm
X-Received: by 2002:a17:90b:2e49:b0:366:3517:1aa2 with SMTP id
 98e67ed59e1d1-36951791eefmr23632145a91.0.1779297516957; 
 Wed, 20 May 2026 10:18:36 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a3c83f226sm254416a91.0.2026.05.20.10.18.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 10:18:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 21/30] fpu: Use {get,set}_flush_to_zero everywhere
Date: Wed, 20 May 2026 10:18:11 -0700
Message-ID: <20260520171820.848839-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520171820.848839-1-richard.henderson@linaro.org>
References: <20260520171820.848839-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c             | 2 +-
 target/arm/tcg/vfp_helper.c | 6 +++---
 tests/fp/fp-bench.c         | 2 +-
 fpu/softfloat-parts.c.inc   | 4 ++--
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index c7c750f284..dcae5b3be2 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -4919,7 +4919,7 @@ floatx80 roundAndPackFloatx80(FloatX80RoundPrec roundingPrecision, bool zSign,
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
index 1c726cb86e..9e823a3ee9 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -411,7 +411,7 @@ static void partsN(uncanon_normal)(FloatPartsN *p, float_status *s,
             p->frac_lo &= ~round_mask;
         }
         fracN(shr)(p, frac_shift);
-    } else if (s->flush_to_zero &&
+    } else if (get_flush_to_zero(s) &&
                s->ftz_detection == float_ftz_before_rounding) {
         flags |= float_flag_output_denormal_flushed;
         p->cls = float_class_zero;
@@ -462,7 +462,7 @@ static void partsN(uncanon_normal)(FloatPartsN *p, float_status *s,
         fracN(shr)(p, frac_shift);
 
         if (is_tiny) {
-            if (s->flush_to_zero) {
+            if (get_flush_to_zero(s)) {
                 assert(s->ftz_detection == float_ftz_after_rounding);
                 flags |= float_flag_output_denormal_flushed;
                 p->cls = float_class_zero;
-- 
2.43.0


