Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5714FF887E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 22:26:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIDLw-0000qD-KB; Wed, 29 Apr 2026 18:25:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIDLv-0000of-Ht
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:25:55 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIDLt-00058C-Vk
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:25:55 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-35fc258aaa4so129287a91.2
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 15:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777501553; x=1778106353; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ia17UGYfL048eafy6/vvv8OZvpSWuBxXDVhOjIuZ0UU=;
 b=bRY0BBuWLlnTX4hdmE96UZ1PTDVTKPrtmKc3rXF6nWCyE/3ldbdGgdZABCPb3ZthLn
 OGvFb2vcThoVUjlJTm6ApsSkZb/9ZD4FhXVX0YgbgeTiD3Sga6SlJ1HcwLuqENQPdD/4
 YNtenPJmP6IfGG/0oPnIUcLUM5Qp06dydk0CNuZAoLmGe380TvqpACbAbJvX5zap/6A2
 mDEepJMg73LG+jfMtdp5iLcZVson2HQzTb3I55KgqJWrOUXnUDPbqRvqzLsR2K0mbuMT
 NWGJD7XduUizVT4uFEby/dcn1zDFzIC899lZStHzNXegCiE5aY0OKqLFrKi2yF5f0OjR
 mo7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777501553; x=1778106353;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ia17UGYfL048eafy6/vvv8OZvpSWuBxXDVhOjIuZ0UU=;
 b=VodWjsw8YTfJJi+0+nSC2l/7Y05zE9xHpLcjUOMV45RL921Fc8We6hTcQe6kNFaj2F
 SanQ6Gpgvw1i9+bVvVkpIVTJNhnRIknvZkMoBeYCoRe3Jh4xuYbeCxfhmM7mXnzXK0aN
 YARnh+FBjocTy4Y5wElDE3FSGMUQvueo8mt2RN415QzR3alUzxD2g8YV3eZ9GCZZ9tFb
 Z4tLxcwCYxKO7tHfFuAORYInNXppP3M7BFKo1f8AHMkGZUyU+VysEd7caIiLEcsajNJA
 7AQ6liFRVQFo8AGpwWMkAeDWodNwHBksNR1kJwH5uvMLJSfMI8T4TNWItpC6KEBlMXsj
 BDyw==
X-Gm-Message-State: AOJu0Ywq+NAUa0S+RnKVSk/GAYz9v+jg4cR+cvCNL6TXVwUhMMw529Fd
 3tCMtDQ7md8NiatdwQpCBFzzbb/DaAoSPXJPKStF7sol1/etehHfSPv0zVcTcobgJhDZ3/18+uW
 Lkr11MH8=
X-Gm-Gg: AeBDieum8cWQhbKq86bD021ryGvCjyJCpMrhENZdrvErsB50A2AwoM27Z0dqnrxD2q1
 FeuEz1BLkvp4eyBjOgrkak145Fbdn00UyafdGG2zrDQQKVrEYjrvVw0PbSfwuNyRT/up/+mfsBB
 e1wA3MGX8JRd2lIdjS6OiBlEW42W1J30BihkxLhZG0SCv0ZAUWP1ea2ElSujOFylKf6jq5peswB
 M7Vgz1bMJaFQ//P2qoBsoNEnPUrzLnebxM66o8QVrIDT66phjkb8/tWcrmZdTGS66F8AT8mvD9z
 BY0MB3Wh5Ya6x/ci/Xg/cDPCVHju4pNwv7gVRmH2a+W/SHUV3TdUMpPgomal4CYI1VKrZ+knUca
 3nCHTd4VOs78XmUfrJ7Lpquviu6d4od/Vx3PViSW6OsbGdM5sSbIzZRObOzqZ3cBFiygdXpHfd8
 ZIlJsOKGq7RBteQaBEW3XjnAFKmp7g/iAM5tqcJvEZLhWZnzS5CZ0=
X-Received: by 2002:a17:90b:2d04:b0:364:7a37:4066 with SMTP id
 98e67ed59e1d1-364c30f0b62mr161769a91.14.1777501552599; 
 Wed, 29 Apr 2026 15:25:52 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-364a2732502sm1888471a91.3.2026.04.29.15.25.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 15:25:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 24/48] fpu: Drop parts_minmax
Date: Thu, 30 Apr 2026 08:24:21 +1000
Message-ID: <20260429222445.26301-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429222445.26301-1-richard.henderson@linaro.org>
References: <20260429222445.26301-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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

Use parts{64,128}_minmax at each call site.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 8d5f3c48e7..158d539376 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -779,14 +779,6 @@ static float128 QEMU_FLATTEN float128_pack_raw(const FloatParts128 *p)
                   FloatParts128 *: parts128_##NAME, \
                   FloatParts256 *: parts256_##NAME)
 
-static FloatParts64 *parts64_minmax(FloatParts64 *a, FloatParts64 *b,
-                                    float_status *s, int flags);
-static FloatParts128 *parts128_minmax(FloatParts128 *a, FloatParts128 *b,
-                                      float_status *s, int flags);
-
-#define parts_minmax(A, B, S, F) \
-    PARTS_GENERIC_64_128(minmax, A)(A, B, S, F)
-
 static FloatRelation parts64_compare(FloatParts64 *a, FloatParts64 *b,
                                      float_status *s, bool q);
 static FloatRelation parts128_compare(FloatParts128 *a, FloatParts128 *b,
@@ -4417,7 +4409,7 @@ static float16 float16_minmax(float16 a, float16 b, float_status *s, int flags)
 
     float16_unpack_canonical(&pa, a, s);
     float16_unpack_canonical(&pb, b, s);
-    pr = parts_minmax(&pa, &pb, s, flags);
+    pr = parts64_minmax(&pa, &pb, s, flags);
 
     return float16_round_pack_canonical(pr, s);
 }
@@ -4429,7 +4421,7 @@ static bfloat16 bfloat16_minmax(bfloat16 a, bfloat16 b,
 
     bfloat16_unpack_canonical(&pa, a, s);
     bfloat16_unpack_canonical(&pb, b, s);
-    pr = parts_minmax(&pa, &pb, s, flags);
+    pr = parts64_minmax(&pa, &pb, s, flags);
 
     return bfloat16_round_pack_canonical(pr, s);
 }
@@ -4440,7 +4432,7 @@ static float32 float32_minmax(float32 a, float32 b, float_status *s, int flags)
 
     float32_unpack_canonical(&pa, a, s);
     float32_unpack_canonical(&pb, b, s);
-    pr = parts_minmax(&pa, &pb, s, flags);
+    pr = parts64_minmax(&pa, &pb, s, flags);
 
     return float32_round_pack_canonical(pr, s);
 }
@@ -4451,7 +4443,7 @@ static float64 float64_minmax(float64 a, float64 b, float_status *s, int flags)
 
     float64_unpack_canonical(&pa, a, s);
     float64_unpack_canonical(&pb, b, s);
-    pr = parts_minmax(&pa, &pb, s, flags);
+    pr = parts64_minmax(&pa, &pb, s, flags);
 
     return float64_round_pack_canonical(pr, s);
 }
@@ -4463,7 +4455,7 @@ static float128 float128_minmax(float128 a, float128 b,
 
     float128_unpack_canonical(&pa, a, s);
     float128_unpack_canonical(&pb, b, s);
-    pr = parts_minmax(&pa, &pb, s, flags);
+    pr = parts128_minmax(&pa, &pb, s, flags);
 
     return float128_round_pack_canonical(pr, s);
 }
-- 
2.43.0


