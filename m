Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAFD9FF885C
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2026 13:42:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGzjF-0007A8-LY; Sun, 26 Apr 2026 09:40:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGzj9-00075C-EK
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:40:51 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGzj6-0008QF-Ar
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:40:51 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2ab232cc803so44637985ad.3
 for <qemu-devel@nongnu.org>; Sun, 26 Apr 2026 06:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777210845; x=1777815645; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8eMeYdKdLROxUfcpDykwRMbJ11IFu4aFIiW8kpwXCk4=;
 b=iWZtwmpTf19F+zDVR12wCHFQsgq1eytJLX5SU1A4+YBb/BCnSfsSEUas4BdCQE3I2z
 89HitZAc8VoJnw6hc0GKcqK0pWVNi7t4iZCxK7qqJNa4dj7TriFgLNUclB0k/e3Blj8b
 iSKd1Pq9govLN3PiVmgYurUBGDI8ClX0C5af5hPQ0nZJy1hda9A1iQHqyiVtCAnpCOU7
 0efLoBZhd0AP2ZAwg+pHqBM8ZpHRD0jcEp9s7Kbow0LwwQfn9hxKoD+SYwVKt8W8s5r/
 HsrOUEv9pYp5vd2/9lERffK+4pfcpj+SoI+npNL+Tariet+xrQLBqIhEk1gszNHYzOCE
 R56A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777210845; x=1777815645;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8eMeYdKdLROxUfcpDykwRMbJ11IFu4aFIiW8kpwXCk4=;
 b=QgqTRSXsACfXGLRR9pyTwmfYVBpbh/hz8yI2han+6U4+8amWlPOfbMWskhvyRCKw86
 ZZyy1amhlE/wd1DcoQpf3WBHQ4oNjnMW3IktGZjq/r8lW1cpgCQgCQK16NZWMqCfdbKj
 zRY3CM2Nmco6rQj+RqY5TctnhBNhtD5BJVIfVPwI87yySSQyJWhxaqJ/Rc4TFW6N/BIo
 ujtFNCLAw1gfeSTYPJvSb9IP/ExpH+dTZbsMFzJCFdgxjVJfzVzH4kARpolSbAThq8z8
 WqCV0AjfylvwaWiZJ1A5QSOIZ8I2qfsvnWprIiQRBEs5dRBHZHZQvuWzGhLIeIZzmF97
 DkgA==
X-Gm-Message-State: AOJu0YzajHHYeMUqzJvHbXQvUPjLLUpOGe4s1P/F8YS69mVKOzO3nRU6
 6agWUEjf1a8F4x1gHPXOatFn9Vd4JUvYv1bEOR1iUZgRkLESGV4OmOY+cw0H3V1pq48DLQ+g6GH
 BJ5DvxEo=
X-Gm-Gg: AeBDievjrmxiXR7J6TwU5NIr/s+Us0rsjoPeTKlrmBbuOazdH6r/3qrTYk1UnV5AhMQ
 rn4YTvw3r43OEa6PxWlrrQ6vy9g0bhicQfo4BvHj6+N1GLJrD2RWzbSotZVBTJSDJoXcHH0USZk
 NRPOHQDftW4TnSvJSofhEo3KUNIYEVszNL0MdSmqUTpI3Li3UyjkkSVMSTbj1FJQEVf178+qdO4
 NIGHvtHBPkcO97XKfnztzoZWpM2tW3HQhaUsqCk0soNrWxjA3H50Oc6CPSQwYRhTiczyEsw2UKa
 mnfYHO4C4uqtQhNAR/OdaZFB1hg3EQcsJ+JXc84g/pRUuA3xZJEnjMrofAc9jc5e+xF3G5nMLVC
 Aiupcr+Zpt7JqRDY2iQg4eEi+eAsCtFvydw/p11zqNVmTpq4+63RnIFuFmQQwOhdqrsiMn07fIg
 qBsqOucHB7GDsRYis0F4oSsCfBCL4Ft7vqJ+UbgoR8
X-Received: by 2002:a17:903:1988:b0:2b7:97b9:54fa with SMTP id
 d9443c01a7336-2b797b95512mr165293775ad.32.1777210845252; 
 Sun, 26 Apr 2026 06:40:45 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab30f29sm277940375ad.68.2026.04.26.06.40.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 06:40:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	qemu-s390x@nongnu.org
Subject: [PATCH 14/84] fpu: Drop parts_div
Date: Sun, 26 Apr 2026 23:38:51 +1000
Message-ID: <20260426134002.865628-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260426134002.865628-1-richard.henderson@linaro.org>
References: <20260426134002.865628-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

Use parts{64,128}_div at each call site.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index aa62fea47d..b885eae629 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -779,14 +779,6 @@ static float128 QEMU_FLATTEN float128_pack_raw(const FloatParts128 *p)
                   FloatParts128 *: parts128_##NAME, \
                   FloatParts256 *: parts256_##NAME)
 
-static FloatParts64 *parts64_div(FloatParts64 *a, FloatParts64 *b,
-                                 float_status *s);
-static FloatParts128 *parts128_div(FloatParts128 *a, FloatParts128 *b,
-                                   float_status *s);
-
-#define parts_div(A, B, S) \
-    PARTS_GENERIC_64_128(div, A)(A, B, S)
-
 static FloatParts64 *parts64_modrem(FloatParts64 *a, FloatParts64 *b,
                                     uint64_t *mod_quot, float_status *s);
 static FloatParts128 *parts128_modrem(FloatParts128 *a, FloatParts128 *b,
@@ -2505,7 +2497,7 @@ float16 float16_div(float16 a, float16 b, float_status *status)
 
     float16_unpack_canonical(&pa, a, status);
     float16_unpack_canonical(&pb, b, status);
-    pr = parts_div(&pa, &pb, status);
+    pr = parts64_div(&pa, &pb, status);
 
     return float16_round_pack_canonical(pr, status);
 }
@@ -2517,7 +2509,7 @@ soft_f32_div(float32 a, float32 b, float_status *status)
 
     float32_unpack_canonical(&pa, a, status);
     float32_unpack_canonical(&pb, b, status);
-    pr = parts_div(&pa, &pb, status);
+    pr = parts64_div(&pa, &pb, status);
 
     return float32_round_pack_canonical(pr, status);
 }
@@ -2529,7 +2521,7 @@ soft_f64_div(float64 a, float64 b, float_status *status)
 
     float64_unpack_canonical(&pa, a, status);
     float64_unpack_canonical(&pb, b, status);
-    pr = parts_div(&pa, &pb, status);
+    pr = parts64_div(&pa, &pb, status);
 
     return float64_round_pack_canonical(pr, status);
 }
@@ -2598,7 +2590,7 @@ float64 float64r32_div(float64 a, float64 b, float_status *status)
 
     float64_unpack_canonical(&pa, a, status);
     float64_unpack_canonical(&pb, b, status);
-    pr = parts_div(&pa, &pb, status);
+    pr = parts64_div(&pa, &pb, status);
 
     return float64r32_round_pack_canonical(pr, status);
 }
@@ -2610,7 +2602,7 @@ bfloat16_div(bfloat16 a, bfloat16 b, float_status *status)
 
     bfloat16_unpack_canonical(&pa, a, status);
     bfloat16_unpack_canonical(&pb, b, status);
-    pr = parts_div(&pa, &pb, status);
+    pr = parts64_div(&pa, &pb, status);
 
     return bfloat16_round_pack_canonical(pr, status);
 }
@@ -2622,7 +2614,7 @@ float128_div(float128 a, float128 b, float_status *status)
 
     float128_unpack_canonical(&pa, a, status);
     float128_unpack_canonical(&pb, b, status);
-    pr = parts_div(&pa, &pb, status);
+    pr = parts128_div(&pa, &pb, status);
 
     return float128_round_pack_canonical(pr, status);
 }
@@ -2636,7 +2628,7 @@ floatx80 floatx80_div(floatx80 a, floatx80 b, float_status *status)
         return floatx80_default_nan(status);
     }
 
-    pr = parts_div(&pa, &pb, status);
+    pr = parts128_div(&pa, &pb, status);
     return floatx80_round_pack_canonical(pr, status);
 }
 
@@ -5488,7 +5480,7 @@ static void parts_s390_divide_to_integer(FloatParts64 *a, FloatParts64 *b,
 
         /* Compute precise quotient */
         q_buf = *a;
-        q = parts_div(&q_buf, b, status);
+        q = parts64_div(&q_buf, b, status);
 
         /*
          * Check whether two closest integers can be precisely represented,
-- 
2.43.0


