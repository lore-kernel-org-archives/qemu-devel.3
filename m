Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CC1ACD5BB0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 18:31:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQUbA-0005Dp-U9; Fri, 22 May 2026 14:27:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQUb7-000533-TV
 for qemu-devel@nongnu.org; Fri, 22 May 2026 14:27:49 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQUb5-0005Se-Vn
 for qemu-devel@nongnu.org; Fri, 22 May 2026 14:27:49 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2ba21d32776so56581775ad.2
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 11:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779474466; x=1780079266; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5yAk6F8ptTywGnvpoeV8kgP1093OZ9QNwCaIuesrM2U=;
 b=TrPLzlLomT5NW8is6JAel3pNUjyZIYXwOPjkqeNWKKR2JocsyYDFOERVoSy4emBKjB
 rqM7sVai2i9Bgwn4b9Q7GY0amojhsbUbffX7AUA3znSgnTvqGcuR49LW66hq2nFlUH61
 TOVw+DxLRvie7cOncMnxxQ/eAevfnIO2e9w5FDUIdi0De7/SaY9azzje2mFJOhPOGISZ
 Sr5H2R1Rhf4g5ws3WRjnxhT7e2ewQ2FgzU8ymf8FBwMaVbgap4S49mvaK7/jgX7VdrFI
 qUa8qJbRjnbH0LVTiRHhHhZWNCF6cb6RdrTi5EWUxRfDghzp0etyGygZR4pH4W14ms3Y
 CyNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779474466; x=1780079266;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5yAk6F8ptTywGnvpoeV8kgP1093OZ9QNwCaIuesrM2U=;
 b=D9PlqPH1k/I09cNmCKHMg3o9dyqMuv3wJXBJz/cV9wpXZ6/NZXPCKnvlXbJiOSt5mF
 +yeNFUTyDAnKOzjiSZPjuz2x3dEHzY1bVP/chxYAg2CtRUewtrRywpnPDIkFSyUckctK
 7ietqd8edJdiGF9l8FLzn6svxo/BolRCBCKDsxX5e+nTfp8hKE1/vfZUg+2hKHUHUwt2
 aU4G4eLvD0A2Lg40PuCZlVnsUL1GEbtSTA1dVeKOGmhgWv68M6CHkAGFGzgtP4L2d4CB
 arxohvN8PtdzUs0ztdDstvAyzwXyRpUp85P0D8ARdNXh/RrtZ5ddVjSmyd7b9351OTMp
 RDiQ==
X-Gm-Message-State: AOJu0Yw4VzxPvQOdVgXze2woqV20Zdtd8uZqccN1cwCXxHNkhf1bxEHa
 xYLCCx+ysYxUyjjT8vhu9xaTBYUcSNUtDemU7Zpn2Vn2d5Ex2CgMVNxENRzyqgS/ZC/6ou4GlYN
 Pb79J
X-Gm-Gg: Acq92OGkQpLrLSZnAv9aTBb3cP8XpSJVNNfjMpiT1vnxOqWUw+NyGmO2p+NCcBUi1vr
 aPSWbWWmkcK/kWXlMN2xazfaXbRgpkh+TbCj7S0Ry/58RPPy4iza3cE7zF3v36nkzA3FZMsLOfA
 STlYvMGfHKUByI5T8Sdci7ubH5YoLl5h+0tk0rVweiQLSm2XYy6Dd9tV69dxTDPtcsI/Cq4auVw
 LBgYgmMQ49lWTLlMied9ad/1INZDk23JjNw9pM6KrVX8H7WCU9VpGazoxAaFWRJuccFzvFSOmk1
 ozSs98DAX37Bk6bYgKuzI24gWCbLNQWZATZPS1NXMf+xmKXR16genB6al7KXeD7lG5wCckKxysD
 7pw6FnRpY+Y+oYyMW1sgnFCHLp4CtlRNHIhcShD9UHd2W5wpkoNho3dXns9Qc/2Y71m0XNYVxQm
 6EiaonJr1UokI4vhcISEeMVk6xjE+q
X-Received: by 2002:a17:903:2350:b0:2bd:eeb6:ff29 with SMTP id
 d9443c01a7336-2beb0356a13mr52570595ad.12.1779474466359; 
 Fri, 22 May 2026 11:27:46 -0700 (PDT)
Received: from stoup.. ([50.78.183.177]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb5900b8bsm21824735ad.76.2026.05.22.11.27.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 11:27:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 21/30] fpu: Use {get,set}_flush_to_zero everywhere
Date: Fri, 22 May 2026 11:26:49 -0700
Message-ID: <20260522182658.184604-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260522182658.184604-1-richard.henderson@linaro.org>
References: <20260522182658.184604-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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


