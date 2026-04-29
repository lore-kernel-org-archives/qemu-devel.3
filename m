Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A72BCCFA13
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 22:26:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIDLl-0000Nl-3g; Wed, 29 Apr 2026 18:25:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIDLh-0000Hl-3C
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:25:41 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIDLf-0004wx-Gt
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:25:40 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-3614826eca4so214746a91.1
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 15:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777501537; x=1778106337; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GLyWu8yU2Agae63TYqLRCthKC3+/ThbReajEkqa3gwY=;
 b=oxxzDKz4OJJ/dSk6o2P0WMAgCesiluNWAuBQEFHuW5tX8Wb0STalDHIpXqIGXK14zG
 Ja9vkdCjnafVAbf8dLPQvaFXgAl36BxDS5Z5aQ7Yes/zfnubHDh+ZP5dOgd/3bnrrja5
 bfvH4opNqv0P0sE5sjpAzq+zVM7gp0ycgXs4AQSYvjQ4Dtx+6ykSyviGCwZfP2oBbTEN
 5/2EXSQ2sKfv/cEFMG2wifY+XrhJuvpblDxJHCYkuqJWaPaDXnmFAvpiPtUMYQ539wc5
 um5DdrkW9y4KKxWhyXVWa+wC1yeZhV7Ll+YSORZoGHNXRmG4+dWydjpjQa+Jht6BoITS
 bMRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777501537; x=1778106337;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GLyWu8yU2Agae63TYqLRCthKC3+/ThbReajEkqa3gwY=;
 b=Y3JBI2pj52Jh1hM9IblUWQ2BtUKj6L+rq5BvU/6//JNIi6v213BmaW/Pt5QDMBxlov
 f3THzs9r52c1Z9LZB0IVyRcqU3ETWCDbKxalNvnQp7jOf/RuPB7ZVAJS+7PJrvzQU701
 KuC9ZXBkgYSq0Rewl9SRxbYsitKdob/T/IsxHAYzr7yx7lC5aXwmANx/7upbCcF2uD40
 qlkzmRapNbOMAwZjt98W0YlvY50mrjACsDQj+82EnZ8uMUXtTWhhUBbnkk9iHeUIez+t
 GN9BUQ6MYTYom37fGUrVV+WZWSJjG89kq9fajiYbq7xXaMtfgtJJwsrg4QrEvPdGcGSo
 EuCw==
X-Gm-Message-State: AOJu0YzUgeasdNb0D/HnSEzwjhiKVQnwxdKL4MWTnpLE7aALSK8rm7+S
 3FMiJKYKh658T+buSctq3khFy+SVQKtMXa7mBp8cePCLViP+Hx5hHMUwqaAHeUz9s3SqbyYeuz6
 hpDfyQKY=
X-Gm-Gg: AeBDieuYBuIwmIn31tKKToAxTTdESvgV5/+hCBoUa0fqigIy3jtzLAfVH6FR8cpjr+J
 3Nw2sE0LEPmjHPXwugFS/ghtEvdUklSi5GQClahivpRz3lYFjPxfmL6ZPEfcJ/9q5WtHqp9Jlef
 uAMzf57OTJY/8mDffa0kaC6PH+5rg8grosm9UAm1xJ73f9jQQAwXGKW/zPU5w2Id/rO2MC1ZwXu
 QVcRXzG/aSRVqx/AUDoCUgRDN33FCmzxJVA2ibP4dcP8BiMzQ012AkRz+OKRbBX8QziY58jH4lm
 yCuWZ5+Y2RemI9zDqmJqWixWknpdQhoKzjgFInxiZdsUEjzbHxjKvYXKGOBZOoofxjZ/+dzEz0Y
 v15q7B48S5TyZFWU9vOMLlqCTq/6HKLQObMKOYx/FBusF1yPU7fEsTOqhecYAA72Iv/2VzAstbJ
 C8P4SprDyWaDiirrrcXvIjQA+G806FfMepUH1ZxGHBy2/siBAgKPM=
X-Received: by 2002:a17:90b:1a87:b0:35f:bae8:3531 with SMTP id
 98e67ed59e1d1-364c340d4d9mr149417a91.25.1777501537437; 
 Wed, 29 Apr 2026 15:25:37 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-364a2732502sm1888471a91.3.2026.04.29.15.25.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 15:25:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 18/48] fpu: Drop parts_round_to_int
Date: Thu, 30 Apr 2026 08:24:15 +1000
Message-ID: <20260429222445.26301-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429222445.26301-1-richard.henderson@linaro.org>
References: <20260429222445.26301-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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

Use parts{64,128}_round_to_int at each call site.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 1f03fcf687..e2341871bd 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -779,16 +779,6 @@ static float128 QEMU_FLATTEN float128_pack_raw(const FloatParts128 *p)
                   FloatParts128 *: parts128_##NAME, \
                   FloatParts256 *: parts256_##NAME)
 
-static void parts64_round_to_int(FloatParts64 *a, FloatRoundMode rm,
-                                 int scale, float_status *s,
-                                 const FloatFmt *fmt);
-static void parts128_round_to_int(FloatParts128 *a, FloatRoundMode r,
-                                  int scale, float_status *s,
-                                  const FloatFmt *fmt);
-
-#define parts_round_to_int(A, R, C, S, F) \
-    PARTS_GENERIC_64_128(round_to_int, A)(A, R, C, S, F)
-
 static int64_t parts64_float_to_sint(FloatParts64 *p, FloatRoundMode rmode,
                                      int scale, int64_t min, int64_t max,
                                      float_status *s);
@@ -3128,7 +3118,7 @@ float16 float16_round_to_int(float16 a, float_status *s)
     FloatParts64 p;
 
     float16_unpack_canonical(&p, a, s);
-    parts_round_to_int(&p, s->float_rounding_mode, 0, s, &float16_params);
+    parts64_round_to_int(&p, s->float_rounding_mode, 0, s, &float16_params);
     return float16_round_pack_canonical(&p, s);
 }
 
@@ -3137,7 +3127,7 @@ float32 float32_round_to_int(float32 a, float_status *s)
     FloatParts64 p;
 
     float32_unpack_canonical(&p, a, s);
-    parts_round_to_int(&p, s->float_rounding_mode, 0, s, &float32_params);
+    parts64_round_to_int(&p, s->float_rounding_mode, 0, s, &float32_params);
     return float32_round_pack_canonical(&p, s);
 }
 
@@ -3146,7 +3136,7 @@ float64 float64_round_to_int(float64 a, float_status *s)
     FloatParts64 p;
 
     float64_unpack_canonical(&p, a, s);
-    parts_round_to_int(&p, s->float_rounding_mode, 0, s, &float64_params);
+    parts64_round_to_int(&p, s->float_rounding_mode, 0, s, &float64_params);
     return float64_round_pack_canonical(&p, s);
 }
 
@@ -3155,7 +3145,7 @@ bfloat16 bfloat16_round_to_int(bfloat16 a, float_status *s)
     FloatParts64 p;
 
     bfloat16_unpack_canonical(&p, a, s);
-    parts_round_to_int(&p, s->float_rounding_mode, 0, s, &bfloat16_params);
+    parts64_round_to_int(&p, s->float_rounding_mode, 0, s, &bfloat16_params);
     return bfloat16_round_pack_canonical(&p, s);
 }
 
@@ -3164,7 +3154,7 @@ float128 float128_round_to_int(float128 a, float_status *s)
     FloatParts128 p;
 
     float128_unpack_canonical(&p, a, s);
-    parts_round_to_int(&p, s->float_rounding_mode, 0, s, &float128_params);
+    parts128_round_to_int(&p, s->float_rounding_mode, 0, s, &float128_params);
     return float128_round_pack_canonical(&p, s);
 }
 
@@ -3176,7 +3166,7 @@ floatx80 floatx80_round_to_int(floatx80 a, float_status *status)
         return floatx80_default_nan(status);
     }
 
-    parts_round_to_int(&p, status->float_rounding_mode, 0, status,
+    parts128_round_to_int(&p, status->float_rounding_mode, 0, status,
                        &floatx80_params[status->floatx80_rounding_precision]);
     return floatx80_round_pack_canonical(&p, status);
 }
-- 
2.43.0


