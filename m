Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC218CD4F5E
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 11:09:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ1Gt-0007nq-AV; Thu, 21 May 2026 07:08:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <antonb@tenstorrent.com>)
 id 1wQ1Gr-0007n3-Kv
 for qemu-devel@nongnu.org; Thu, 21 May 2026 07:08:57 -0400
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <antonb@tenstorrent.com>)
 id 1wQ1Gp-0005jw-MY
 for qemu-devel@nongnu.org; Thu, 21 May 2026 07:08:57 -0400
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-43b4dad80a5so24084fac.2
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 04:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1779361734; x=1779966534; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7Fu5z+Stn9b2D3BHWmnLBFZN7eYSnhTDJSREERzmNio=;
 b=Kwt2awHWcLLu3r9Ji7tlUfQlIZ0YpECPzEr6gNbkVDFiQvPnO77J6xxI9iWMWZWHaq
 E47bEYNtKZJykkAaqIAARgcmF5xlbFbJo+zDSJwodJN+1PXzH4GNP4n+FTiKPhCqrwq7
 eeHP9Zkq7ft8OKmDPOUMYFhuQoExGgHecJ31gwyz1VvR5D6dP/zP6wJ8fBW640rKaW8o
 b/PKTGDYsNlWC2Gd7gn3YS14suptp4pBzgPYz/7d3SkUQwiHrYX2SpDbA767AiJwUpXz
 0NCjH5sCe0GvRgnbkGlCQAvK1MGOHkWEqAy3CcRpb45HrLGPO7kDm5VVGCmnMqLhKeo5
 +eNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779361734; x=1779966534;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7Fu5z+Stn9b2D3BHWmnLBFZN7eYSnhTDJSREERzmNio=;
 b=Tw7ikWbDplR6HGfios4Pkq6AG/gsp5NZD6dDhY9NOjQLMIW3DvepaBYLPKajy7C3eM
 MjVLFSMr6BjZKvmB5MM+dh96yxouKZEQxE3RBj6wl2b4Od+kYQhjuPh3LZrJ4FA1tMcb
 WwRr+KuPhN+b3/zi2nIpb4XWM7kx4Qcj5ktUKEsikdYY2fcvr0UlWa7RY2cd8B9YEBw6
 CWIeUFlDdd6339o9sS6utBgmCTNMWUWYpAZ+/DgUfZL1atbeEYNo873s8Jn/ERHdAt/e
 ft+KSRPa93cRq0aNyBP0MrYmZCfV2u5YKLM9N5i2kFXNDufMJ1MrPsyTYAiBx5QlSl78
 vm/Q==
X-Gm-Message-State: AOJu0YyjVRhMHNjoYKdtoSJOK5FRAU6y6HMrTtp+QP1IAXku5YyzXN/T
 GbyAefOUjO1hoPa2HgAZuwNNq0FLJH9TwlTkcMusiq5f+0eHLmmjxLKOH2WaoNCyZcl01QjBY9/
 yRH7tT+c=
X-Gm-Gg: Acq92OEtS5K7p/UnrzzS49PZLKgBiLv4AVQ2ewMJVK6fpmHb91fBZaURwWE+6uaoVc3
 277ZxhoYpkX5nnkbg5oQRlRjEtnP8WT9uL6KX5sgiCCcTQbVLRp+JI8Y+4cgzOjMc/yRipm+OUi
 4r9lLFR1NkDURNFFTLCNsQJgznwByEM3rBdg3F2ntDJllmF5G2CSq6Mdhh9InL8/saAS8ZUwxCt
 scp229IEtUGe8V/GDSbFloe5Rq51e+x7C8wxxDAvtjjnfTd9vLt5KYRw3+FRplTj31xyub8iwEj
 eNWK75VmIGQmPEFhrQr9OxevN+QZx2O7Sg8UZBx5K1PjGojY6SqxUa7KGYkbD+SjVAVI6GAoQE/
 8rM7GfgABEiuIWidaa5DAhtc22cNj1R6j17aAvrYFRG4bGB6yqr/IDXdwUcLsxFCJ+zyVtmrEq3
 15KhEWQ2DQzBYtoS/lF5zT0Q42xCPvAb7DDmC3UU60C4R4BgYu3LwJ5au3SA==
X-Received: by 2002:a05:6870:dc4a:b0:430:3591:26c4 with SMTP id
 586e51a60fabf-43b2e777bf9mr1479519fac.7.1779361733836; 
 Thu, 21 May 2026 04:08:53 -0700 (PDT)
Received: from ausc-rvsw-c-01-anton.tail89d63.ts.net ([38.104.49.66])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43b4543972csm330346fac.14.2026.05.21.04.08.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 04:08:53 -0700 (PDT)
From: Anton Blanchard <antonb@tenstorrent.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: alistair.francis@wdc.com, philmd@linaro.org, chao.liu.zevorn@gmail.com,
 Anton Blanchard <antonb@tenstorrent.com>
Subject: [PATCH v2] target/riscv: Use float_raise
Date: Thu, 21 May 2026 11:08:24 +0000
Message-Id: <20260521110824.1091323-1-antonb@tenstorrent.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2a;
 envelope-from=antonb@tenstorrent.com; helo=mail-oa1-x2a.google.com
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

---
 target/riscv/vector_helper.c | 35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index c4e150635e..d1be0682fe 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -4084,7 +4084,7 @@ static bfloat16 frsqrt7_h_bf16(bfloat16 f, float_status *s)
         (bfloat16_is_infinity(f) && sign) ||
         (bfloat16_is_normal(f) && sign) ||
         (bfloat16_is_zero_or_denormal(f) && !bfloat16_is_zero(f) && sign)) {
-        s->float_exception_flags |= float_flag_invalid;
+        float_raise(float_flag_invalid, s);
         return bfloat16_default_nan(s);
     }
 
@@ -4095,7 +4095,7 @@ static bfloat16 frsqrt7_h_bf16(bfloat16 f, float_status *s)
 
     /* frsqrt7(+-0) = +-inf */
     if (bfloat16_is_zero(f)) {
-        s->float_exception_flags |= float_flag_divbyzero;
+        float_raise(float_flag_divbyzero, s);
         return bfloat16_set_sign(bfloat16_infinity, sign);
     }
 
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
@@ -4338,13 +4337,13 @@ static bfloat16 frec7_h_bf16(bfloat16 f, float_status *s)
 
     /* frec7(+-0) = +-inf */
     if (bfloat16_is_zero(f)) {
-        s->float_exception_flags |= float_flag_divbyzero;
+        float_raise(float_flag_divbyzero, s);
         return bfloat16_set_sign(bfloat16_infinity, sign);
     }
 
     /* frec7(sNaN) = canonical NaN */
     if (bfloat16_is_signaling_nan(f, s)) {
-        s->float_exception_flags |= float_flag_invalid;
+        float_raise(float_flag_invalid, s);
         return bfloat16_default_nan(s);
     }
 
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


