Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF769FF887E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 22:25:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIDLT-0000Ak-Qc; Wed, 29 Apr 2026 18:25:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIDLR-00008u-JB
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:25:25 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIDLP-0004qF-UG
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:25:25 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-35dac556bb2so158791a91.1
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 15:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777501523; x=1778106323; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DSoFvrT/mzv0YVjtRcuYv2GRBUN8U8c5GJTtScdTrPI=;
 b=jopHgB5DjbUnmBFIepRHiH+E89dEHleVtEhIwgvXflV0L5eUvznnK7KnX040/UDvdF
 /qRBoie1AFiPrx2r/5g5j+j1bD3UdxiahU24t5X+T7Zj3W3lf0v+uMgKhwRsORmbUCZC
 9yIj5hZwwjp1kFwV3FretEgE5KAvmdJ7wU3qWn6KX/1OPGjGzpiRD1PgkU3HAWxoTnN+
 bfjeeGNLgrH7Bm9DUMoB675cL9W1auJTQoOcXVtjwUdKKL3TUCwtzUGnq5VrQ7XQY69t
 zRKswKDpWo7TEC7jNF8S6xG4lIBqkT3wlTeH7YjS7HQsugrDFQg6CzjV5DF4azwmyj9i
 w9tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777501523; x=1778106323;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DSoFvrT/mzv0YVjtRcuYv2GRBUN8U8c5GJTtScdTrPI=;
 b=VfHMJzgal4noubC0ravDLYk3ptT6MWpoEI4148hkFq6cai6jpDW4/xJaxzN6M+YOtC
 Ps1DMegnK2FJJHz5gWZoKqndhNLY8//PXcXwdAEjtL874YFFN45/OAmqJ8l/xxziHc5Y
 3/AnQY9Yw6E4TQ3UCjN78C9rpyNvXYGmxIOKZJ2k0efo6J1v1cKE7jDv9y8k3IBBKCBT
 chr8oO19nA7hsY/pvokvipsDrvzrVbK4YOJnh8U4BrsPuiwWn6KytUUXnelVcw3XpvRS
 bzrHky6IL+xqxXQGVU2IfzMNmWBSQbbsrC00f37Eh4XmH917vjtlXSU3kut+SicC41/E
 JgwQ==
X-Gm-Message-State: AOJu0YwaBmlzRdAk9zzYxafsMEnVHBPGllugSHc/2D9ZNXTjQvbHK9M6
 p1J79MoQ6KutW76uldmNdo3PKU5k5AQDMPKJ+waMZJ+UCsm2577QKLhl5gq4ludC1UTQFBHwAl8
 YESa+vjg=
X-Gm-Gg: AeBDiete8n37AK0S+PN5DnsaZa/RUM3Tr+bEZ1i6i5UQ//6Qo9f0AbjUSyXows/Rbe/
 r56Q3E68+N2v3CwtNy+LPFZa05sS/0KahRVMe69VhwZ4tyIKtpo9sA/s/wHvdvhUP8JFB0QxvWL
 gv5xp9X4pxNlRF6qwFaeyDOlG2AmkJ8Ke2v3Hk7BRkSTP0i7Z3r4zjRAldwUdWs7GFHAxrxKm5d
 0VwqiEKLIEgepKweheVPsxzqddHArgUkBwHv3OM3k8MlQx6NxbZwpZGG1/6KVaxhnFsch193Vtb
 XmWPTs39fSbnUE5vTqj5bEvz+eNkYiPG0Jf1Z5/8F0H7xKQa31eVI/39pfbVKnBukZpAkdces0X
 Fvl9iT5fez9K2g/zgEVVbOabGZ5nVON68n8R1wGsf7Os4WlHGfstshdFo+uWSw34FVb5cYxaAE5
 61NSpuQY3L6eJFXriMGeVmfRUBRpGjyAjYMLI22M+i
X-Received: by 2002:a17:90b:57e5:b0:35d:a5cb:95c1 with SMTP id
 98e67ed59e1d1-364c3149065mr155825a91.23.1777501522622; 
 Wed, 29 Apr 2026 15:25:22 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-364a2732502sm1888471a91.3.2026.04.29.15.25.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 15:25:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 12/48] fpu: Drop parts_mul
Date: Thu, 30 Apr 2026 08:24:09 +1000
Message-ID: <20260429222445.26301-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429222445.26301-1-richard.henderson@linaro.org>
References: <20260429222445.26301-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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

Use parts{64,128}_mul at each call site.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index dc5ce53105..8adc73c863 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -779,14 +779,6 @@ static float128 QEMU_FLATTEN float128_pack_raw(const FloatParts128 *p)
                   FloatParts128 *: parts128_##NAME, \
                   FloatParts256 *: parts256_##NAME)
 
-static FloatParts64 *parts64_mul(FloatParts64 *a, FloatParts64 *b,
-                                 float_status *s);
-static FloatParts128 *parts128_mul(FloatParts128 *a, FloatParts128 *b,
-                                   float_status *s);
-
-#define parts_mul(A, B, S) \
-    PARTS_GENERIC_64_128(mul, A)(A, B, S)
-
 static FloatParts64 *parts64_muladd_scalbn(FloatParts64 *a, FloatParts64 *b,
                                            FloatParts64 *c, int scale,
                                            int flags, float_status *s);
@@ -2149,7 +2141,7 @@ float16 QEMU_FLATTEN float16_mul(float16 a, float16 b, float_status *status)
 
     float16_unpack_canonical(&pa, a, status);
     float16_unpack_canonical(&pb, b, status);
-    pr = parts_mul(&pa, &pb, status);
+    pr = parts64_mul(&pa, &pb, status);
 
     return float16_round_pack_canonical(pr, status);
 }
@@ -2161,7 +2153,7 @@ soft_f32_mul(float32 a, float32 b, float_status *status)
 
     float32_unpack_canonical(&pa, a, status);
     float32_unpack_canonical(&pb, b, status);
-    pr = parts_mul(&pa, &pb, status);
+    pr = parts64_mul(&pa, &pb, status);
 
     return float32_round_pack_canonical(pr, status);
 }
@@ -2173,7 +2165,7 @@ soft_f64_mul(float64 a, float64 b, float_status *status)
 
     float64_unpack_canonical(&pa, a, status);
     float64_unpack_canonical(&pb, b, status);
-    pr = parts_mul(&pa, &pb, status);
+    pr = parts64_mul(&pa, &pb, status);
 
     return float64_round_pack_canonical(pr, status);
 }
@@ -2208,7 +2200,7 @@ float64 float64r32_mul(float64 a, float64 b, float_status *status)
 
     float64_unpack_canonical(&pa, a, status);
     float64_unpack_canonical(&pb, b, status);
-    pr = parts_mul(&pa, &pb, status);
+    pr = parts64_mul(&pa, &pb, status);
 
     return float64r32_round_pack_canonical(pr, status);
 }
@@ -2220,7 +2212,7 @@ bfloat16_mul(bfloat16 a, bfloat16 b, float_status *status)
 
     bfloat16_unpack_canonical(&pa, a, status);
     bfloat16_unpack_canonical(&pb, b, status);
-    pr = parts_mul(&pa, &pb, status);
+    pr = parts64_mul(&pa, &pb, status);
 
     return bfloat16_round_pack_canonical(pr, status);
 }
@@ -2232,7 +2224,7 @@ float128_mul(float128 a, float128 b, float_status *status)
 
     float128_unpack_canonical(&pa, a, status);
     float128_unpack_canonical(&pb, b, status);
-    pr = parts_mul(&pa, &pb, status);
+    pr = parts128_mul(&pa, &pb, status);
 
     return float128_round_pack_canonical(pr, status);
 }
@@ -2247,7 +2239,7 @@ floatx80_mul(floatx80 a, floatx80 b, float_status *status)
         return floatx80_default_nan(status);
     }
 
-    pr = parts_mul(&pa, &pb, status);
+    pr = parts128_mul(&pa, &pb, status);
     return floatx80_round_pack_canonical(pr, status);
 }
 
@@ -5443,7 +5435,7 @@ float32 float32_exp2(float32 a, float_status *status)
     float_raise(float_flag_inexact, status);
 
     float64_unpack_canonical(&tp, float64_ln2, status);
-    xp = *parts_mul(&xp, &tp, status);
+    xp = *parts64_mul(&xp, &tp, status);
     xnp = xp;
 
     float64_unpack_canonical(&rp, float64_one, status);
@@ -5451,7 +5443,7 @@ float32 float32_exp2(float32 a, float_status *status)
 
         float64_unpack_canonical(&tp, float32_exp2_coefficients[i], status);
         rp = *parts_muladd_scalbn(&tp, &xnp, &rp, 0, 0, status);
-        xnp = *parts_mul(&xnp, &xp, status);
+        xnp = *parts64_mul(&xnp, &xp, status);
     }
 
     return float32_round_pack_canonical(&rp, status);
-- 
2.43.0


