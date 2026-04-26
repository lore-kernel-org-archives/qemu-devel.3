Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99F29FF885D
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2026 13:48:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGzjG-0007CG-Sh; Sun, 26 Apr 2026 09:40:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGzjC-00076X-7e
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:40:54 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGzj9-0008RG-Hv
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:40:53 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2b2503753efso97383435ad.0
 for <qemu-devel@nongnu.org>; Sun, 26 Apr 2026 06:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777210850; x=1777815650; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q2IzZbTZBi1/HYn+Kd6HNy8yKoIRF/IKgPHtP/RDOts=;
 b=iFxjp62aSy8WrjbqR6WdVEaatpL0fR3hY6zRff8fWrYnmca7BjZaHmIt+ctY3EmISq
 t/KsgfVDTXw2tqervA4dJoBSAgn4j0du0Hsj3gmrhvtOBk/CFFSn0B9VHFeIgVaMLMXY
 r8XA1EOcJPIRMO+Iahu5MlETqcocU76HVwPR6wb+8PbUhJDrds2NOa/sDDlqcCqbfI9/
 Wq6QnignvH7TXx56M9SpfHdkxS2Ocs3kSwhanPSrL6F+tukwTGYk0bP1k4K94RbZwCW5
 VBhHy0QmNi/B+gBOWD23e9baRy3OUGjAPNaoEk09ITItqdHPImdyJoz+Jb0O8WoPdsVg
 tK8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777210850; x=1777815650;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Q2IzZbTZBi1/HYn+Kd6HNy8yKoIRF/IKgPHtP/RDOts=;
 b=QpRuLckMuz3qgFsZt5ksXOhZ2uK3812S8F2dx2ae3PJHunKdwg3k3Laf3NnTlfm/O9
 JB78fKdCEbdOwjVzPkyrEHOck7I5JBzsqBWIZvOd4/kNbS8T1MAoKmBOWNLHvNQaK1YM
 z8k1gVnBgdmGyIj3cmBMUH7/10M/w2eD83zljG6nlUv7z9xlPix7LtkS8nWUdV4FFJrL
 DjuQJV4TsXC/Bge033gfMnLpMt/Wn1tDCGI/rU3YJzq6JAVgeqNYV39RuxttpxwHwoiv
 ETnn7uPUleYapqhjJMJBslWw9G40TSM6CHWokXItmJ/BtAxreXko54R8QOruTG2ypmQn
 wy9w==
X-Gm-Message-State: AOJu0YwXjUkaMs8oUift3eNRURy+kVWord9LqXSjVef6lzqzN3nAMj1h
 O8lmmoia5SlSKFJoeuPKEoFTmyv2OpJlGxUYLbVe509/KZDKzqVpiWJMpGac1kx0aFdEulXkrIS
 67kclKis=
X-Gm-Gg: AeBDietAWH8n6QBhVyxm0lW3HIp0+7/q0qna4aTUjz/Bujf6bmQuTL0VfZpWXTOyV8a
 Bex15ttUrGh2iuc0KAUtNlwcZ8swo+7c6pENiXq4jkwKLChPDvhadXHuSPtd5FyeT4kI4UVOOdW
 T4dv+RfswHP2q8YZ9EuR4Uw/Jmg1xX+SY23WAx/EBRJiBOCNKQMID/4ZpdJhEQQgqDl4ocUrPQ6
 zbJmQmKtvDOEi6GqgVDnS8vG1HL7Jx0pdAkwlJ8AKEOuYNip+CbBlxIhYOg/sFM/cTY4EAOjhz2
 uLie4bLmWDqdqkFMOZ2PO6M2pj80yKitzvKEKag3s8J8QhNZKt+TM4Lu0hpzupKMOjDV7GTAWX2
 y2qnuM9fGBek0wPEq2fiknxs4JBsl0czJTajaN0eRQWDtMoNlEO3H/rUFJMoQqmrdJ8/yZTyeuG
 G5/8FHEXN9OFlXfetHJsje001CAC9GNuWwuuyb2fgkIpPk4CNaxu4=
X-Received: by 2002:a17:903:1b45:b0:2b2:4d36:7aa with SMTP id
 d9443c01a7336-2b5f9fb36ccmr431356495ad.35.1777210850140; 
 Sun, 26 Apr 2026 06:40:50 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab30f29sm277940375ad.68.2026.04.26.06.40.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 06:40:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	qemu-s390x@nongnu.org
Subject: [PATCH 16/84] fpu: Drop parts_sqrt
Date: Sun, 26 Apr 2026 23:38:53 +1000
Message-ID: <20260426134002.865628-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260426134002.865628-1-richard.henderson@linaro.org>
References: <20260426134002.865628-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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


