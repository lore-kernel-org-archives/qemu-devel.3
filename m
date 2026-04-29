Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6439CCFA13
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 22:28:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIDM0-0000xL-5u; Wed, 29 Apr 2026 18:26:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIDLy-0000tw-4c
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:25:58 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIDLw-0005Ag-G6
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:25:57 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-35e563b0ee7so162494a91.1
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 15:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777501555; x=1778106355; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xhNV1JSBOi39LblTgxFILqkjIcMCbg311nb9LeNaPVQ=;
 b=rVd/J3YNjK/zM1cXtkZcSWlWFi20oDJoqojF1obMUrvbTuj2Ro9Kg5iNSLdnAtjLPL
 fF6zkoHSZC5pJYoOUq6GQidCNlnpg3mn83cpoo8tV2mVOzYFTrrYcD8HYMp1fFmpylIT
 lUyIQiQT1teTcb6CO91r4cEMc72ELJ0OFumPlerhRMQ7p5qas3NKK5UnG+E9ujrfeIhg
 BTv+ZtYAPdBHoKQfZPo2KOmvkTFCThE7zg8BegB2WX9W3cjB6s5q59SK3k4CnhgtFZzd
 VH8W09EbwR5Ivvh6z1IGtP9sXUh2Nlk3X2qcN9446RiCVoTxPp8r25JD0tmLo8W9ZcWG
 71Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777501555; x=1778106355;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xhNV1JSBOi39LblTgxFILqkjIcMCbg311nb9LeNaPVQ=;
 b=U+Go5N0RgCHjTk24HpDbC3gsJ2tPSclr56xxoS88INf4+R+geXjAo0aKaaFhTpOMa8
 vLeyuGXi/DkohiXcwoA/S1R47xejR3+UHL6hnBVP7PxMVooN4uyqfqa6LtCKIBi1IjO1
 Vm5Fu96XdR//6ahLOO18F0dfbSsg0sZcEvfh4noEdzJ4y87Y00GxZjs7rfBJNMUVMza+
 TYFAiy0yh2qQ0OHahtWDy1Cv7vEJ8+Bx11Lii888PgkR4DY8zJt63y4jAo/MGcu4DTeI
 s9AfHAcwGikwn/oT28kW/RROhSwxEVy4WU63LKJwwJfuF5g6FeuQpa0aOepb/wvDU+0l
 /tyA==
X-Gm-Message-State: AOJu0YzhiyhlcUaHoeMZufsZRrw9qZRvze8bG3rQagfjzCIHNu4QfaMH
 Ssh80g6yH5GYKXuOfL9QhQ9AuID3Cs6Z8hjj3o70dWE3i+C6bY663g1UZ+1GD6MhAdUyme0frrg
 59oUBCY0=
X-Gm-Gg: AeBDieuIjKx4pFbHHiw2/asdhlQB0X4JcMs1nSMZrbXu1ZWnKjq8Qg8POneULlf6Pmc
 eLzICQnPUA3UBXw2UqO4oMYHsrS/x41l81ok2FHmnIcrvjUEWQr43t4nlkNQylyTtJnhnyMQxPp
 TberQW47lDpP1GdMi7ylZ1k5NhfOMr1xw87mp3+ri1lcvnrXLUzcl7KifoZjRhFvIMi634sMVix
 DjMZOa/fhnZbtaxgxNm5NvofKpPfyN0fxL1F0TLFMAMVoVM+fhjKAotZZsBel5nycsoMm1G48Ug
 px3C+DZh9qCUJqnznPW7sW9m9QeGCTEJpRYsw3J3Q98P8xqT3yN4vh7AtI1ENC2yxkSx3wUOUrI
 gUL/RnLgwB9nqCKXZdoxXsJ2mvk+vgJTOcZFzfjdB3OiyQjG/LFgKYGtrxUy+j+SHNJvUQIXOUi
 gAovMkK37t1fPh4968sunuQsyF2XScrrTlbNn09vSW
X-Received: by 2002:a17:90b:2f48:b0:35f:c1cc:fee0 with SMTP id
 98e67ed59e1d1-364c3409173mr115273a91.8.1777501555158; 
 Wed, 29 Apr 2026 15:25:55 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-364a2732502sm1888471a91.3.2026.04.29.15.25.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 15:25:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 25/48] fpu: Drop parts_compare
Date: Thu, 30 Apr 2026 08:24:22 +1000
Message-ID: <20260429222445.26301-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429222445.26301-1-richard.henderson@linaro.org>
References: <20260429222445.26301-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
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

Use parts{64,128}_compare at each call site.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 158d539376..3aebe4a058 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -779,14 +779,6 @@ static float128 QEMU_FLATTEN float128_pack_raw(const FloatParts128 *p)
                   FloatParts128 *: parts128_##NAME, \
                   FloatParts256 *: parts256_##NAME)
 
-static FloatRelation parts64_compare(FloatParts64 *a, FloatParts64 *b,
-                                     float_status *s, bool q);
-static FloatRelation parts128_compare(FloatParts128 *a, FloatParts128 *b,
-                                      float_status *s, bool q);
-
-#define parts_compare(A, B, S, Q) \
-    PARTS_GENERIC_64_128(compare, A)(A, B, S, Q)
-
 static void parts64_scalbn(FloatParts64 *a, int n, float_status *s);
 static void parts128_scalbn(FloatParts128 *a, int n, float_status *s);
 
@@ -4494,7 +4486,7 @@ float16_do_compare(float16 a, float16 b, float_status *s, bool is_quiet)
 
     float16_unpack_canonical(&pa, a, s);
     float16_unpack_canonical(&pb, b, s);
-    return parts_compare(&pa, &pb, s, is_quiet);
+    return parts64_compare(&pa, &pb, s, is_quiet);
 }
 
 FloatRelation float16_compare(float16 a, float16 b, float_status *s)
@@ -4514,7 +4506,7 @@ float32_do_compare(float32 a, float32 b, float_status *s, bool is_quiet)
 
     float32_unpack_canonical(&pa, a, s);
     float32_unpack_canonical(&pb, b, s);
-    return parts_compare(&pa, &pb, s, is_quiet);
+    return parts64_compare(&pa, &pb, s, is_quiet);
 }
 
 static FloatRelation QEMU_FLATTEN
@@ -4568,7 +4560,7 @@ float64_do_compare(float64 a, float64 b, float_status *s, bool is_quiet)
 
     float64_unpack_canonical(&pa, a, s);
     float64_unpack_canonical(&pb, b, s);
-    return parts_compare(&pa, &pb, s, is_quiet);
+    return parts64_compare(&pa, &pb, s, is_quiet);
 }
 
 static FloatRelation QEMU_FLATTEN
@@ -4622,7 +4614,7 @@ bfloat16_do_compare(bfloat16 a, bfloat16 b, float_status *s, bool is_quiet)
 
     bfloat16_unpack_canonical(&pa, a, s);
     bfloat16_unpack_canonical(&pb, b, s);
-    return parts_compare(&pa, &pb, s, is_quiet);
+    return parts64_compare(&pa, &pb, s, is_quiet);
 }
 
 FloatRelation bfloat16_compare(bfloat16 a, bfloat16 b, float_status *s)
@@ -4642,7 +4634,7 @@ float128_do_compare(float128 a, float128 b, float_status *s, bool is_quiet)
 
     float128_unpack_canonical(&pa, a, s);
     float128_unpack_canonical(&pb, b, s);
-    return parts_compare(&pa, &pb, s, is_quiet);
+    return parts128_compare(&pa, &pb, s, is_quiet);
 }
 
 FloatRelation float128_compare(float128 a, float128 b, float_status *s)
@@ -4664,7 +4656,7 @@ floatx80_do_compare(floatx80 a, floatx80 b, float_status *s, bool is_quiet)
         !floatx80_unpack_canonical(&pb, b, s)) {
         return float_relation_unordered;
     }
-    return parts_compare(&pa, &pb, s, is_quiet);
+    return parts128_compare(&pa, &pb, s, is_quiet);
 }
 
 FloatRelation floatx80_compare(floatx80 a, floatx80 b, float_status *s)
@@ -5518,7 +5510,7 @@ static void parts_s390_divide_to_integer(FloatParts64 *a, FloatParts64 *b,
                         saved_r_precise_sign = r_precise->sign;
                         r->sign = false;
                         r_precise->sign = false;
-                        if (parts_compare(r, r_precise, status, true) <
+                        if (parts64_compare(r, r_precise, status, true) <
                             float_relation_equal) {
                             *dxc = 0x8;
                         } else {
-- 
2.43.0


