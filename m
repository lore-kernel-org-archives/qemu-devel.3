Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DEEBFF887E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 22:27:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIDLj-0000Mu-0l; Wed, 29 Apr 2026 18:25:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIDLb-0000Fp-V6
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:25:37 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIDLa-0004tH-5i
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:25:35 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-3614826eca4so214705a91.1
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 15:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777501533; x=1778106333; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=31hLbn8oYXSK9jtgcJgE4cjWwvKE/+HfIVZoQKVefGU=;
 b=w73VUVb1qvqJfbYpl2yHW5sudG8qPRgqnVLnuHZbgAEargMpvFo1nxasJS9HGC5KmT
 NO7Iv0yvM70cffZH2NZsFRArP8pni468ejgt/m0CyQSCY7RbU8ak6BNpd10jCUTYKEOo
 xWoeRDxsPp5Gj8LdyafzUDQ2PcQP73GsZ0suCBKjcp7PFA4ZtRL5RE598C0t2ACs79xG
 0rOKAiwGc22mjf499KEVkGaI7gmuSNKG4E46+qhCtCHIVA1fLY/0JJZhipNoYgRi4Q1+
 AQBWLI+NIqLykgyNatL1dOWmdOp+upaXtT7RxHCwmT9uchduUrYQdEfcMLtMlBAF1ksY
 2S4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777501533; x=1778106333;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=31hLbn8oYXSK9jtgcJgE4cjWwvKE/+HfIVZoQKVefGU=;
 b=e9+nCYoww8LmwQTgTEaM4RWAFaM6xLuofjPo+wQVH35Ysl//6iFn0ZFnJfhHxX7x5k
 bMhbpM/m6QEk5P20u4ueAIblzEfNKFUDZXUbL1oy0iC3UVDTtYQ2Lq4Mr6kp4V29gtp5
 g5W3j4iCH47rLz7EhylXWDNFCKqO03UVzCFJd3crokfWLRc17DMdCtJXRdCSd3qPGFTX
 zpV4JSdPY9dSPsMn+GSC55jdQwOuyBwBDCiElNo26V3hJLDIjqcobclfqU149SZuuBI1
 BG1uMOl8nRJ3NV1d9Mw9U86IQQLxMUCH7DwPsPJc/zhAPumRzSS7lGrwKutFS2ZdPV+L
 1Nug==
X-Gm-Message-State: AOJu0YwGtwdsDu4MzgC+qXTaETuFU+4CIunDySiz+WbIksMBrakSpq2h
 W0xYABSBWMzTjf3TCfLncqbfLfNkLQQyVHhezHguMDaEh42IPq7mspXUT9FbmTUjB4G+phcOjMb
 wM2+j1gQ=
X-Gm-Gg: AeBDietUPlKupjHGuoqsyb0N4ZV7fWb198/VdMq4LDNCKbb3xKguuSlR3y/Pm45bs8X
 zNbzn/NFKCl8bgSNQp2DHEWKXjxGGzEA9gUgeKML1EuZNONKvgZqUYfvXG4POAaIYtOWzqjzLZC
 irTk8pGQXVnCdov4gnjz1uFaczEgeQMllGDnxtgrap+FZIK3oWXSEHjG/0oEO4q3jp6F+oAWws6
 IEar0LATIB8+aLGWGSdlygVwNC9WE4A2HAon9ly84e5Ysh6n6NDKxMp+YiMZcHb/6TlXnqB9fBX
 6akqnjqqe+jd1huEd96QjGNM5xpdrEvXbYkoEYAspBcgcqeCa0jHuqse0Gm9E3i+wRjQv9SCC0O
 bnpnRz0lrZOikyHNuN1g9wFWMr/jm01iGV8GKFsNE3OTR/5Jvde4YCNPpHfJgw9UZd3GgqiO06Y
 mHvpo5Y6jcBhQxkfXjTzwwYKXxtUp8HpBb/7pA1tqb
X-Received: by 2002:a17:90b:52cf:b0:35f:ccf6:69a5 with SMTP id
 98e67ed59e1d1-364c31a6b14mr168341a91.20.1777501532584; 
 Wed, 29 Apr 2026 15:25:32 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-364a2732502sm1888471a91.3.2026.04.29.15.25.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 15:25:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 16/48] fpu: Drop parts_sqrt
Date: Thu, 30 Apr 2026 08:24:13 +1000
Message-ID: <20260429222445.26301-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429222445.26301-1-richard.henderson@linaro.org>
References: <20260429222445.26301-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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

Use parts{64,128}_sqrt at each call site.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 91d8e48ce4..0a6bc6d580 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -779,12 +779,6 @@ static float128 QEMU_FLATTEN float128_pack_raw(const FloatParts128 *p)
                   FloatParts128 *: parts128_##NAME, \
                   FloatParts256 *: parts256_##NAME)
 
-static void parts64_sqrt(FloatParts64 *a, float_status *s, const FloatFmt *f);
-static void parts128_sqrt(FloatParts128 *a, float_status *s, const FloatFmt *f);
-
-#define parts_sqrt(A, S, F) \
-    PARTS_GENERIC_64_128(sqrt, A)(A, S, F)
-
 static bool parts64_round_to_int_normal(FloatParts64 *a, FloatRoundMode rm,
                                         int scale, int frac_size);
 static bool parts128_round_to_int_normal(FloatParts128 *a, FloatRoundMode r,
@@ -4757,7 +4751,7 @@ float16 QEMU_FLATTEN float16_sqrt(float16 a, float_status *status)
     FloatParts64 p;
 
     float16_unpack_canonical(&p, a, status);
-    parts_sqrt(&p, status, &float16_params);
+    parts64_sqrt(&p, status, &float16_params);
     return float16_round_pack_canonical(&p, status);
 }
 
@@ -4767,7 +4761,7 @@ soft_f32_sqrt(float32 a, float_status *status)
     FloatParts64 p;
 
     float32_unpack_canonical(&p, a, status);
-    parts_sqrt(&p, status, &float32_params);
+    parts64_sqrt(&p, status, &float32_params);
     return float32_round_pack_canonical(&p, status);
 }
 
@@ -4777,7 +4771,7 @@ soft_f64_sqrt(float64 a, float_status *status)
     FloatParts64 p;
 
     float64_unpack_canonical(&p, a, status);
-    parts_sqrt(&p, status, &float64_params);
+    parts64_sqrt(&p, status, &float64_params);
     return float64_round_pack_canonical(&p, status);
 }
 
@@ -4840,7 +4834,7 @@ float64 float64r32_sqrt(float64 a, float_status *status)
     FloatParts64 p;
 
     float64_unpack_canonical(&p, a, status);
-    parts_sqrt(&p, status, &float64_params);
+    parts64_sqrt(&p, status, &float64_params);
     return float64r32_round_pack_canonical(&p, status);
 }
 
@@ -4849,7 +4843,7 @@ bfloat16 QEMU_FLATTEN bfloat16_sqrt(bfloat16 a, float_status *status)
     FloatParts64 p;
 
     bfloat16_unpack_canonical(&p, a, status);
-    parts_sqrt(&p, status, &bfloat16_params);
+    parts64_sqrt(&p, status, &bfloat16_params);
     return bfloat16_round_pack_canonical(&p, status);
 }
 
@@ -4858,7 +4852,7 @@ float128 QEMU_FLATTEN float128_sqrt(float128 a, float_status *status)
     FloatParts128 p;
 
     float128_unpack_canonical(&p, a, status);
-    parts_sqrt(&p, status, &float128_params);
+    parts128_sqrt(&p, status, &float128_params);
     return float128_round_pack_canonical(&p, status);
 }
 
@@ -4869,7 +4863,7 @@ floatx80 floatx80_sqrt(floatx80 a, float_status *s)
     if (!floatx80_unpack_canonical(&p, a, s)) {
         return floatx80_default_nan(s);
     }
-    parts_sqrt(&p, s, &floatx80_params[s->floatx80_rounding_precision]);
+    parts128_sqrt(&p, s, &floatx80_params[s->floatx80_rounding_precision]);
     return floatx80_round_pack_canonical(&p, s);
 }
 
-- 
2.43.0


