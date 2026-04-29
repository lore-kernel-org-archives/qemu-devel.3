Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68554FF887E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 22:25:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIDLF-00005c-Cb; Wed, 29 Apr 2026 18:25:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIDL9-0008UE-Vl
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:25:09 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIDL7-0004Wh-O5
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:25:07 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-c70e27e2b74so72401a12.0
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 15:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777501504; x=1778106304; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0acHNdlazZi1YgqZAKptjl7ZLjGgHX6fO28DrX2hh38=;
 b=fe610JocJGvKzzEgazYLZSKCNiVrkqAOID7+uRUWZQ9L+U4xOppUBPWH4aI8x5O+P2
 LWJyKLkvZ7q7amra9do0y4elKthMIL51Bgp8sI2Tm4IEOevhGKeOaMxHYLAr1gVsjTIt
 FWOpffZBAE2uu8DAjRiaR7YMcNb494sIjJypxaxecKgqddwUdLWEXWIiPbj8rqfTtKyd
 ULudYQ/+IOqwnO3pBNWIbMi0ekVp4CMGtnkFq4yGCE3vvIpabRHJFdxHWj6Dlp5K2c2h
 9T7Mo6Bl4OiCUlNaDrYkngluuM/FJkZDCmUBIWsjc9mbqmMvq/sOiO2nU3cpxW4G7UyS
 T9Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777501504; x=1778106304;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0acHNdlazZi1YgqZAKptjl7ZLjGgHX6fO28DrX2hh38=;
 b=WXESGcvZ9K8sCFLpwPpzDUbVQH/ESWFxbb/PObWtHqILHYV/k9hAf+KiAznys0MhtH
 LhVantUBwcnetIrN/BeICwNurzQ5ghn+4e0+wBqLsLF7KGdUl3WgpdY+r9mYpQyVcS9r
 QU/eA2V54JtW2qbRf3JM1Q/ZRqx4ZQoXitY1/b/e9PqzkqH9i/tZICVCMBFziZOAkppm
 ++AqW7RwsAiRfUUo+WdQ/SzQG8tdnQt9peRK8tRa//+AiI2C3i0rob5uO+rdxfbhrAGM
 TcgzQ4BazKiwWoNSBfObKljNpJ7DFbbDfKVdEbXneZpKE/ULc2AQwltI1RhIFfAf7Ebs
 JlBA==
X-Gm-Message-State: AOJu0YxlKmQH/AMWqp7OCpmK+Qrr/KpL1p8iKkTbOS1RzUyyX/sIt1DW
 YPdFlnZL9Xcgl6KN3XyrzvpuaRlRE4CKBUAjlvqt9t0en3rYe3jVspugT2kDFGd8/+6EhXSngUn
 nlqjadu0=
X-Gm-Gg: AeBDiesobCNSJtdkGypp0LpY49K6MvyEs+fROa0zcm9XwONnCeacNJI8JY7G3gv5KYM
 z4HbAimvmZK7ZpBQ678HoF0pC9s+0xT7+0dsuE+jv5M5MjyHfbXA2YACR4aCBoQa9q6ZXi3qCvB
 SoDCP2AJ9e5FPOZ1fxB7CNclIt0D+1VjZmAz3Eh4wKoVbcriBFiV82HXqcdV6Fr/z0rnvrNPK2M
 6cUV3VSqF/bCEZaB/o9R9hf/TEO0TVhXyDdm6BUoB2xR7h21FVkAiZW/KACw6OlAsKVNuso6kLN
 cqYtR/HNHWRtah88AkJH02wK+LtYPKRkM00ykWl4XVoymZiTGVhuWU9q594RNbnqjeBlPFarhic
 QD9pzn/9i9FLlA3vzRwheuuMzDK8XlOBhk4yRKkoRGZFSAGwp7vNTUAtpk4cDPO3p/VY3DeZPhK
 yNVZuttYofu4pKwsKE4ob9vF8O5nODBg9VStmpSz00
X-Received: by 2002:a17:90b:264b:b0:35f:bbc0:e570 with SMTP id
 98e67ed59e1d1-364c2de2c5bmr228083a91.0.1777501503961; 
 Wed, 29 Apr 2026 15:25:03 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-364a2732502sm1888471a91.3.2026.04.29.15.25.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 15:25:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 05/48] fpu: Drop parts_silence_nan
Date: Thu, 30 Apr 2026 08:24:02 +1000
Message-ID: <20260429222445.26301-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429222445.26301-1-richard.henderson@linaro.org>
References: <20260429222445.26301-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
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

Use parts{64,128}_silence_nan at each call site.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c           | 12 +++++-------
 fpu/softfloat-parts.c.inc |  6 +++---
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 76c1d4e38a..571b5f09f3 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -779,8 +779,6 @@ static float128 QEMU_FLATTEN float128_pack_raw(const FloatParts128 *p)
                   FloatParts128 *: parts128_##NAME, \
                   FloatParts256 *: parts256_##NAME)
 
-#define parts_silence_nan(P, S)    PARTS_GENERIC_64_128(silence_nan, P)(P, S)
-
 static void parts64_return_nan(FloatParts64 *a, float_status *s);
 static void parts128_return_nan(FloatParts128 *a, float_status *s);
 
@@ -5034,7 +5032,7 @@ float16 float16_silence_nan(float16 a, float_status *status)
 
     float16_unpack_raw(&p, a);
     p.frac <<= float16_params.frac_shift;
-    parts_silence_nan(&p, status);
+    parts64_silence_nan(&p, status);
     p.frac >>= float16_params.frac_shift;
     return float16_pack_raw(&p);
 }
@@ -5045,7 +5043,7 @@ float32 float32_silence_nan(float32 a, float_status *status)
 
     float32_unpack_raw(&p, a);
     p.frac <<= float32_params.frac_shift;
-    parts_silence_nan(&p, status);
+    parts64_silence_nan(&p, status);
     p.frac >>= float32_params.frac_shift;
     return float32_pack_raw(&p);
 }
@@ -5056,7 +5054,7 @@ float64 float64_silence_nan(float64 a, float_status *status)
 
     float64_unpack_raw(&p, a);
     p.frac <<= float64_params.frac_shift;
-    parts_silence_nan(&p, status);
+    parts64_silence_nan(&p, status);
     p.frac >>= float64_params.frac_shift;
     return float64_pack_raw(&p);
 }
@@ -5067,7 +5065,7 @@ bfloat16 bfloat16_silence_nan(bfloat16 a, float_status *status)
 
     bfloat16_unpack_raw(&p, a);
     p.frac <<= bfloat16_params.frac_shift;
-    parts_silence_nan(&p, status);
+    parts64_silence_nan(&p, status);
     p.frac >>= bfloat16_params.frac_shift;
     return bfloat16_pack_raw(&p);
 }
@@ -5078,7 +5076,7 @@ float128 float128_silence_nan(float128 a, float_status *status)
 
     float128_unpack_raw(&p, a);
     frac_shl(&p, float128_params.frac_shift);
-    parts_silence_nan(&p, status);
+    parts128_silence_nan(&p, status);
     frac_shr(&p, float128_params.frac_shift);
     return float128_pack_raw(&p);
 }
diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index 37ce731101..0d4a63fbff 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -23,7 +23,7 @@ static void partsN(return_nan)(FloatPartsN *a, float_status *s)
         if (s->default_nan_mode) {
             partsN(default_nan)(a, s);
         } else {
-            parts_silence_nan(a, s);
+            partsN(silence_nan)(a, s);
         }
         break;
     case float_class_qnan:
@@ -109,7 +109,7 @@ static FloatPartsN *partsN(pick_nan)(FloatPartsN *a, FloatPartsN *b,
     }
 
     if (is_snan(ret->cls)) {
-        parts_silence_nan(ret, s);
+        partsN(silence_nan)(ret, s);
     }
     return ret;
 }
@@ -179,7 +179,7 @@ static FloatPartsN *partsN(pick_nan_muladd)(FloatPartsN *a, FloatPartsN *b,
     }
 
     if (is_snan(ret->cls)) {
-        parts_silence_nan(ret, s);
+        partsN(silence_nan)(ret, s);
     }
     return ret;
 
-- 
2.43.0


