Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D9EEFF885D
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2026 13:55:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGzja-0007Zd-2u; Sun, 26 Apr 2026 09:41:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGzjZ-0007Z1-7D
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:41:17 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGzjX-0000Ak-Jl
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:41:16 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2b7d3ecc10dso14931645ad.2
 for <qemu-devel@nongnu.org>; Sun, 26 Apr 2026 06:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777210874; x=1777815674; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=APzXi2KVCIYa0t0D3NstU7yyhE+V3SOxwz+wKn9uFgg=;
 b=gyZzasYr5CTjm8ic4RLLBzQ40p3AmsG6AL1pB2yJpghKArI8ds5n9oAuwcH44YJauh
 mOb0h41DgYfKrM6VPudxGTJfNwAoGApsfJPOO2GxzkpHEf0RKUxCC2+vxW3HJsDHsPar
 51/whs4VKQGLRwx/2DnoXDaAMaX+xvmAWg1GpFyDvVHCeYerPHnEDl0h/LJ8VSOg2Gq0
 +6q2+sOJec7W1OrxoyEa7R0gcW5dip5yrV1t1ikOOi9+Y0UmY4Gvg4OAykomB82LZP/Z
 rQ6CWUHTFK+9sT0btbqudJeE0Fl58rlUCQ6CKST32Tk5w7tJTfQmzdHzSdtIzLLuY7Wy
 I7pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777210874; x=1777815674;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=APzXi2KVCIYa0t0D3NstU7yyhE+V3SOxwz+wKn9uFgg=;
 b=OuEDZiIp9i/KtBbJtieLOwnaOmhUaftk18cTbIMnTDd8sAxE+fkl1t5d/kpLlJipTP
 qT0dv/WPLFhIJeBCwA7Uyv4QGlAaed7AQFZFHYitBcQjq0keNNkNgtzdGjhE1s6FCm3o
 DDsAiFkW76yY/vyNKAgML2Tsvhn26XS+z9KoqleZeeb69a4vYrqswVjXXLEcbZmy/1C+
 lLt3wTDNACEknzTg0IjeR6XiWMS3lfScSwv2iiDNkque00uaNfLRybhbdAzrj01/Vy4u
 Y6YCcyVR5g+hxPQhlswT/tpWyGTlmxkJrG6+53YnZQncIoEPovWn3hQn5PateqHDBrV7
 n1YA==
X-Gm-Message-State: AOJu0Yw5crlBcWOsXQ1c6TDypuKhPDi/VAeaIJc/QXaj+fbOcdBSUThZ
 Cw0VnooFIBNCP4xC2B3TTxVUuUUnEd0/Ryl3jrpghkWfEh1vPIi94aWBgyuUEurwk1LUaIF8LHw
 csSuYWI0=
X-Gm-Gg: AeBDietketqKbuSXlmuXLDt4h44/QBhg4mhFIFvjfXKKA69BZS9oH3GuzV5A5Nvjnj8
 Y1NLIRHAz790JBQbHumseIQ4Is9fURKyt8aMei4j6OZ4EMUinZwmX0H6+IQqbqdmqBU7SYK9xmK
 CCuEzNrIj6RSocdfAAg6ZsSV92qMFaxoiz3zPFncECNn7fOAqc8Oz5LpqxMhFh9SdJpF7vUH+o/
 1b6W8+f/EKbqDLqPsjWIpHNvRmPPiAUuztXhD3l4BZxb3y4rOTLo5iTCmhKGR8bPK9xYwqYBYz9
 F6P2rb3gBsQucVnDfgjUVAI50M9UlmCjnRhhg+VF8wvtKYBxiGECjLpOIHNjMAeNv5MMFd9MuG9
 NGJzu3hWsSTgYMWs0SRJh5sEAlREOMHyktdwrAH6PrSFnFWYgrkEfQBzpaOGsszGMBF/4iD3+qH
 aCakzMaHZAdOXY7lSVkAkC0yb9XrAFAH1nf+9ooLyy
X-Received: by 2002:a17:903:2283:b0:2b0:54dc:63e with SMTP id
 d9443c01a7336-2b5f9fadcd4mr427273585ad.33.1777210874209; 
 Sun, 26 Apr 2026 06:41:14 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab30f29sm277940375ad.68.2026.04.26.06.41.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 06:41:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	qemu-s390x@nongnu.org
Subject: [PATCH 25/84] fpu: Drop parts_compare
Date: Sun, 26 Apr 2026 23:39:02 +1000
Message-ID: <20260426134002.865628-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260426134002.865628-1-richard.henderson@linaro.org>
References: <20260426134002.865628-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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


