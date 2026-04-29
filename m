Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FAADFF887E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 22:26:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIDLk-0000Nj-Lv; Wed, 29 Apr 2026 18:25:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIDLX-0000BQ-3P
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:25:33 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIDLV-0004sJ-7p
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:25:30 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-35fb7c1a455so71867a91.3
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 15:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777501528; x=1778106328; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KN4/YGxHVfwaOoI/7DFEuWGTPCBqoJHvWm0vlCiWTg8=;
 b=MriWG1a2VBX9lrwTdel/YnooHge4ClSu1Z/sRNjqRct9GZvmrr3+nOBvGxtGhoxlB2
 q0YTd4DX06L3hCDQVATYD7lV4KA0oELKWVwnB0GKSiAJaSjweWkI0+K3Wp/8CifgKHbD
 9W1ltcqM/b9FXpE6gqvETPZMLztkvwCc+HtUpPlMnr2gN9+rEfaHkLlNIOBFWXD5Fm8h
 5A9UkVum37GSMlhx9lzmdoeNlL8bkh36Y/PSaC/LkzRCbtzFO6ByJo5YFXx1Ux54TUXq
 Oy4m1eRGVgoLyPLOYKSrPrSVeQBz4v7xXe5+flkV2uEDK4tKQ0Gn1ADdJ4O5IyZqtxjK
 pBkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777501528; x=1778106328;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KN4/YGxHVfwaOoI/7DFEuWGTPCBqoJHvWm0vlCiWTg8=;
 b=V+2Zo5d/jyVIMQE23xx5YbT+ixSdgsVPK9l7yJ12AKtB/I9W3TFPrE888NX93lVlXf
 wW8UXEnE1HF5wJ2gS3I40Z1IDH6jOJNMOLT0zTYj5pywBMjF2v23VUICfU++2In0PeUV
 vwwPgtg9ZaXv298gBfdbt2YGFrhknajgjhmcrmLkBIzSRsdEuMtlBNVuN8URRIa5zAId
 KwzhO2IP8efF61I+5RW98+71H6TW3w5msnOKjaPW6VDoezcWGfuNFpXf6TNRMOrrFAWj
 XmgUY77lO6Lt/USTehgEnvgwx/gS70nqKssMAzrWzELTZfUYnj60zwLL0iDURe6uAuuf
 DY2g==
X-Gm-Message-State: AOJu0YylsEWeWjNYRS8Sf1wDy0FsLNUxiqvM/hE6y7SjaBNAEwzPOK7n
 bmGriLD18zyC6YydPdVOKZ7xE13v/fG+OOwOrRtPRRPTtS8dAOVxcWpu2vwDfAAIjjGFNft5ct3
 Y/m3/qCM=
X-Gm-Gg: AeBDiesXUod6okbgw1bXFEcH/ke88B3jmDyxTKA4unrTGByBiSQlW0GcHrtzucNx5tP
 SgkvhYv3m5SaMLn2pEoc76XvYfbW8c3hW4FcKBYdRyvGGDsveBIvpSf958+1BUi4lCYSeRP/ndG
 lonb5Fur1WFi7HAZ8RLkB0/cAueFF+ZfH+Ecpvsa/oBOUJTwoKEoCcn5u4aNvkjaaQHLkY+FEI2
 Mbi+jm5YcEgtsGJrkgOI8BfavR6QiH+6h5A9w3kfCJ7YavtobX3jDoh49Ir1+5LMB7mE/M5C2yp
 uofj+JYGivgzBlEbOC2k/x2JzhsmWTiNSEJO8DpOWX55N2abdWAG8DpEN9bYKpVcDMEYpaVhZMS
 s4UmoVe+YxyQuC4/NtEYYWaUi9bO5xEqIWaGGEK7QKZdKAlw0SoW8rhIyN70qksex0eHxP5Gpsa
 8pnfsLoawxQLlbfSjl/zGZemTlw6b264AnJKZ+eJYt
X-Received: by 2002:a17:90b:17c2:b0:35a:cf:64a6 with SMTP id
 98e67ed59e1d1-364c3174d7amr153944a91.23.1777501527656; 
 Wed, 29 Apr 2026 15:25:27 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-364a2732502sm1888471a91.3.2026.04.29.15.25.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 15:25:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 14/48] fpu: Drop parts_div
Date: Thu, 30 Apr 2026 08:24:11 +1000
Message-ID: <20260429222445.26301-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429222445.26301-1-richard.henderson@linaro.org>
References: <20260429222445.26301-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


