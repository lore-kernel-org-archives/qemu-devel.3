Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD22FFF885D
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2026 13:43:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGzjF-00079L-6V; Sun, 26 Apr 2026 09:40:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGzj1-00072I-QD
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:40:45 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGziz-0008OM-Qg
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:40:43 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-362e50b4641so1619094a91.0
 for <qemu-devel@nongnu.org>; Sun, 26 Apr 2026 06:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777210840; x=1777815640; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O1deF2a9CTcLPY51+HToPZPvFKlSh0LTVXG903qSvbY=;
 b=ThKRN8Y01bLQ6a+V0VLvmiC/zVbpOVOZ0G0cefIE7oeumXYz34wiTkCcce6IRLlcbB
 PkSma2WBf9Qwj2uPkRZ3t4BOsddzCwcTfMcSVl5SxUiHwJxcII22HP5O9bcA8F+9KgD0
 +9N/vzwhOu6zYz0+zyuQNr7x/j6qOr0gNA/8bvLBS3RSS3o/boVcVUbKTqMWNk+gwrMg
 Yue6EGouJCutnqRyeKt/Tpn5I/E3MVSyfeufc6vLQ3JIVNC/6/nTwZF202xkdJxo68z9
 Cf2Nxg/ctrHV5To50iBNV5HrzekJybzHwtjWTgFJ6TlOTQKp3ImEfN6x/ihndnwh1HFp
 TCZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777210840; x=1777815640;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=O1deF2a9CTcLPY51+HToPZPvFKlSh0LTVXG903qSvbY=;
 b=O6oLWtBkyYz5IYREwDybHFf+AcwgZb6lk2YHdbhHiVN+fktqcKJagLWbUNDnErc4M9
 5uZTzekwcRSv+8aypqm+ySduLvuPpEHD5cH5uM6yakRY3T94RJRjv+SDdTqHDyqxWHPM
 92CLVznsI951JXNdF+W3vEbzk4KVTqdgaNVW8tuXIUZaS1jxhQDXSRcN+i5DNV5pVNQU
 K/dSrSJJfu8SOn3AsCJL818bgBRyPsV+xMLjvRv5ZzGxHWgXcB33YzksX65YUsSLdPAf
 i0+yXyAUWufIQmrUZ6HBrU8+/sTPuOhvn7xHp/rAVhKUMe8HfIR61ABSlSf+cNB3txh+
 BrUw==
X-Gm-Message-State: AOJu0Yz717YO/OE5YWx8QFNaF25iz6OCD0UgZVk/DAuw/H74I3gvyVjy
 0hM0ihngy/nLSseASMIWer2M7vmtfHWUBMCwZnSI6DYXLNAyRrqU5W0UiU4hwf+N54Z74oyNnK9
 /QuFpyL0=
X-Gm-Gg: AeBDiesy+GhYQR+OsNDjy9TYt/6ZH6gwG57bjtZ5SiC/gY3SUqHXPRmKgR8b3zg4lGm
 YZLtBsmyoyg/GfUlThiN4XuAm34y56fkkndrydgmhizROerIWzm5EKJRxhnt/gv7plNArk2luHY
 /yKgHe6v9QIxcmRMkCZHD8tZS1hbWGTBG4yIGwF2sTFC7cd2oSA7D6gxxrWyhoX7CxQldHlHRt6
 wDv/u9+Pupv8OiuyihNEbXoRA4iet/CaD8Iq27N0DfksIZfARztLU7mkg3/gjVNIstmq9cmopOi
 WakOccARZOSCnxSNn6rr2fJAQt9F7hqGIto0WK7ckiQQ6v1D3xUtdkXM13xABMx9kk5yWlJngiA
 VRmo/YLnbhVeUISeV2pKAPIo/aC6GCL6UeWsNzRKwK12amKqcN8f09r4jtDNqX/bASKxOMoez/p
 Bb/tA8lbNkZzLTPjAzT3UjyG/g/lZSi3P7wcPaebAC
X-Received: by 2002:a17:902:cf08:b0:2ab:230d:2d96 with SMTP id
 d9443c01a7336-2b5f9eaf621mr421690415ad.11.1777210840181; 
 Sun, 26 Apr 2026 06:40:40 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab30f29sm277940375ad.68.2026.04.26.06.40.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 06:40:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	qemu-s390x@nongnu.org
Subject: [PATCH 12/84] fpu: Drop parts_mul
Date: Sun, 26 Apr 2026 23:38:49 +1000
Message-ID: <20260426134002.865628-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260426134002.865628-1-richard.henderson@linaro.org>
References: <20260426134002.865628-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


