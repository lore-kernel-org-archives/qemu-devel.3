Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03497FF885C
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2026 13:46:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGzjT-0007VW-HT; Sun, 26 Apr 2026 09:41:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGzjR-0007UF-Mv
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:41:09 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGzjQ-00005G-7C
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:41:09 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2b25cf1b5f0so51270855ad.3
 for <qemu-devel@nongnu.org>; Sun, 26 Apr 2026 06:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777210867; x=1777815667; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zENj2HL3D0APPnrwzC9d7FulsD17Lin4fmHz2/94vtM=;
 b=s1T/Tb4kv9PLHjl//NXkmOhGCR1IP89qI3PzeHqADbSmBY4qGOAdBkKGfwkRtdeFTb
 gglvEkxRfzviLzdoLgg1w7gMEGmMMzaArl8mI3USmAisN6BwTZHUjkw5jrxeTTEp8c2e
 8sorzjTyRKSTFhQo8OEZB7PAwn5IeAfyE/j0YnWWMy8OKX1iSz5V7ba7dW9qmhdLIUwW
 /K6VPQU2/DCRjJqEdFFaiEp7MWXG3AIkPnMDf+wSbnKCI6oRJVIADN1tNMis/W/wazev
 tbKpAx8g3MXdZkQEE1YYtln0zUWkxSiy2MExDXieV9QMaqrC5q+71Ru/XGnkrcnF6UbY
 r4tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777210867; x=1777815667;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zENj2HL3D0APPnrwzC9d7FulsD17Lin4fmHz2/94vtM=;
 b=Ej9P6YmkE+zy/Xyp7z1uadweZ5KY1iOHjFR0nH6cVGGoL04nQIPyfjUjmAWT62yCJ1
 U9acRQWOOqSEOq0qIdIjeH5zX9PzaZFc11Ij3lRnK2N6WIIGIHLQXExdwVz9m9AulBmN
 2E2C695SorUw+wh+S3jJKdchxxN/z7nluGlIcoPACfBsWtdpk9VLJ2PYvWzHpaGcVxR5
 yosnJ7RvFPiLuNmBTfZSX9X/HddMvqBcyMdJvpdEub8gM5HbSth6l/S5F93pGfH33ufJ
 JuFCVr6hjVBpzeojOBI0XOvJ3kH/F3bhSq0yow+hcUyJJN1cYtYjJ0FzFEBBHRuKGK3x
 4r8A==
X-Gm-Message-State: AOJu0YwR1XZ73YHHhtZ8oBXl/p7WkidQRaFIy0SZy9PzmEfeRqj8FUbf
 Xkem90nQLHAe5Da9mXG4jIujxZW0uFsVnmYQyamPAmuqez7/IF4qW2Zjgxxu4GRgDIbrYNlCjAR
 6GqJ/YeI=
X-Gm-Gg: AeBDiesOmSYBHMAuZYbJmlD48OAIaDWQ0B+6ooME1/XhuA+xm48/wAMohCp0kpKnNGm
 qw3dM275aSNRipTpm9/CNMhNQuuzAhEV96hBCIrCO7ClINZI+c97wUFoSFwANkc2vQeZV6dN26o
 MK1z8NpK37772I5kK95zgvSBft+ch3r7k/H+8SdqnwiIzXyS+XzjZnDSl9vnYXytB32QHRLK/Z8
 l6cfA5IHLlCrtdKhlcVvW/t/VBmOAsQiYysP7gBGEX2n+ksYwLYGrzCSnWBShcc6nqPihr+sqsC
 ktu7+95gjxG78CQINJWVk36HCCRHUaabd7DoWWpXVfWz25W8znx/pqeI0jqZctYg4lROU05elJm
 1zL5FNiq1Z/oAsBMyEfLqQ4AHWhmTp245mmhO5U26nxKo4swUu+xH2rXDNTssy67OtrRz90zK+p
 ZKKxTuAdKKOhHhJLTLHJu6WkmShoolWoDR/fCUfvbB
X-Received: by 2002:a17:902:d393:b0:2ad:d0ff:2ed4 with SMTP id
 d9443c01a7336-2b5f9e5da5fmr263578875ad.6.1777210866640; 
 Sun, 26 Apr 2026 06:41:06 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab30f29sm277940375ad.68.2026.04.26.06.41.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 06:41:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	qemu-s390x@nongnu.org
Subject: [PATCH 22/84] fpu: Drop parts_sint_to_float
Date: Sun, 26 Apr 2026 23:38:59 +1000
Message-ID: <20260426134002.865628-23-richard.henderson@linaro.org>
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

Use parts{64,128}_sint_to_float at each call site.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c           | 18 +++++-------------
 fpu/softfloat-parts.c.inc |  2 +-
 2 files changed, 6 insertions(+), 14 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 0b2638c34b..bbfdf1a076 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -779,14 +779,6 @@ static float128 QEMU_FLATTEN float128_pack_raw(const FloatParts128 *p)
                   FloatParts128 *: parts128_##NAME, \
                   FloatParts256 *: parts256_##NAME)
 
-static void parts64_sint_to_float(FloatParts64 *p, int64_t a,
-                                  int scale, float_status *s);
-static void parts128_sint_to_float(FloatParts128 *p, int64_t a,
-                                   int scale, float_status *s);
-
-#define parts_sint_to_float(P, I, Z, S) \
-    PARTS_GENERIC_64_128(sint_to_float, P)(P, I, Z, S)
-
 static void parts64_uint_to_float(FloatParts64 *p, uint64_t a,
                                   int scale, float_status *s);
 static void parts128_uint_to_float(FloatParts128 *p, uint64_t a,
@@ -4013,7 +4005,7 @@ float16 int64_to_float16_scalbn(int64_t a, int scale, float_status *status)
 {
     FloatParts64 p;
 
-    parts_sint_to_float(&p, a, scale, status);
+    parts64_sint_to_float(&p, a, scale, status);
     return float16_round_pack_canonical(&p, status);
 }
 
@@ -4098,7 +4090,7 @@ float64 int64_to_float64_scalbn(int64_t a, int scale, float_status *status)
         return ur.s;
     }
 
-    parts_sint_to_float(&p, a, scale, status);
+    parts64_sint_to_float(&p, a, scale, status);
     return float64_round_pack_canonical(&p, status);
 }
 
@@ -4131,7 +4123,7 @@ bfloat16 int64_to_bfloat16_scalbn(int64_t a, int scale, float_status *status)
 {
     FloatParts64 p;
 
-    parts_sint_to_float(&p, a, scale, status);
+    parts64_sint_to_float(&p, a, scale, status);
     return bfloat16_round_pack_canonical(&p, status);
 }
 
@@ -4203,7 +4195,7 @@ float128 int64_to_float128(int64_t a, float_status *status)
 {
     FloatParts128 p;
 
-    parts_sint_to_float(&p, a, 0, status);
+    parts128_sint_to_float(&p, a, 0, status);
     return float128_round_pack_canonical(&p, status);
 }
 
@@ -4216,7 +4208,7 @@ floatx80 int64_to_floatx80(int64_t a, float_status *status)
 {
     FloatParts128 p;
 
-    parts_sint_to_float(&p, a, 0, status);
+    parts128_sint_to_float(&p, a, 0, status);
     return floatx80_round_pack_canonical(&p, status);
 }
 
diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index d8eb9f5b78..8405cf29cd 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -1779,7 +1779,7 @@ static void partsN(log2)(FloatPartsN *a, float_status *s, const FloatFmt *fmt)
     r |= (a1 || a0 & ~DECOMPOSED_IMPLICIT_BIT);
 
  exact:
-    parts_sint_to_float(a, a_exp, 0, s);
+    partsN(sint_to_float)(a, a_exp, 0, s);
     if (r == 0) {
         return;
     }
-- 
2.43.0


