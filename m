Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3044ECD4851
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2026 00:26:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOPKZ-0001dw-Pw; Sat, 16 May 2026 20:26:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOPKQ-0001cs-0H
 for qemu-devel@nongnu.org; Sat, 16 May 2026 20:25:59 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOPKN-0002PN-HK
 for qemu-devel@nongnu.org; Sat, 16 May 2026 20:25:57 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-83ef1d17904so1076614b3a.1
 for <qemu-devel@nongnu.org>; Sat, 16 May 2026 17:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778977554; x=1779582354; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u/kDXd23+ycS383PGeIrgHSsrr0fsby8WIj0IEq0o18=;
 b=kQS1qauJfcvxX+qDxYTgJzs/gW9ei6hQx/XZfYCxZwOxEWljxTCKOptnGB1hj5lHca
 FQLQStVBrD4x/Vj/+nd4uUJQ5trShphhB3axntQSylVSb/Y/shk9Ubu6U2xSUgPd0Fo6
 hv/S6pzhIIo6p6zsUotplVYddODJND/sqThKiZDSSvAMRp+XnYcR7Td9nsu0WURwqhAt
 rRbmGpJe3PXF2clQMV+Shd03VkLHCD2jimogbATabELVh7XVDlxlmZ5/KBboKnVF7IOI
 kMbY2rG0n+JqzGbuqn61djAWv7TdZ9a7qVIkqcf85uYVsrB8z6oMjqAgKvF4NAGjspxx
 sM6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778977554; x=1779582354;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=u/kDXd23+ycS383PGeIrgHSsrr0fsby8WIj0IEq0o18=;
 b=It8b5BXj/u+fAY/lkAqXtkgp+73g9YiSOqnu1DlyNpaazvzRjBXWKsPkUVxEiv7mhQ
 I6IlASBoyXwGebHo2ZdxbOFp/FH9/70d33J2KOypwm/dbhQr4YWvngeNvnUEvOehGZ91
 U8UUbJrmU0BBgzyRSIzATTDjM5mkgLwsGLwwtbuPV9ZsAIRZGsOmF62O7g1Oqm7MOHva
 A6DDC4FHLmrSG8JvTYqtflsQAzuB5VsVBsR01oG7lDfPOEKaR7tscgRhkqtp/gLt7jmE
 /GXiqgn3BqKPDil7r4Rp7g6as3q4J/q4nHmKxLmJJqfDh4/M4MEZoArekHYnpbSadNwm
 UY5w==
X-Gm-Message-State: AOJu0Yw2MdLbaP9mb/f20rQL1N4HgmjWRVtZ1DCFucgUDrK38cKhDIRA
 jJYGZgUQoaKq6+rYb16KzkLl3TOQU1XSYFbhNJi15FZHH/4QBQXKuCpqBkpiEYw26jBuAl6PUuB
 7OA2b
X-Gm-Gg: Acq92OFewfYzqkaZiFyLAvXGd/9WGNTrtt7Wj7QEA7ldhEumDx6OjgTn+AYQgcW1Ese
 D7DlsW/FNAkXJIZHJxmt8PA+NAY816PeOFEQSkcA/8rykzJ08b3FfuIJPYyx/zPtZuOh56Mr9VX
 Ex5lAly54gl93LD6EIy37lt5+TVwOMoEz7NuP4obns3Yh/ggm4t2SIpXDrXRbSsB1aqIOz4WF7l
 xbw66srhOSXBaoVGUlSsSgvFLxc+HBOfjgLi7BQqCCi8F1f34SZn9F6Z1YzXDxnE5dmZGt/O1dg
 YTTLnqXm8vKcc3muaxw9WGCsSA91XbfhmOOolp/tvAf2uwJ0EUEWd+RyRny1EzfAt6CUKa71wt9
 vybRx++4kAb3v2EwzAopaS5YjicH/kkCxd4HzVJGafD1USBTLr8bjMIOi4ndydhn0HPXVyDDw93
 7OsiusDT6w6tK2cgnqb92pF0D6vp42Sm7i8DTPtG4=
X-Received: by 2002:a05:6a00:3689:b0:837:7e7d:3c8 with SMTP id
 d2e1a72fcca58-83f33df5086mr10201662b3a.39.1778977553674; 
 Sat, 16 May 2026 17:25:53 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83f19c5be71sm9670317b3a.39.2026.05.16.17.25.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 May 2026 17:25:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 01/12] fpu: Return struct from parts{64,128}_scalbn
Date: Sat, 16 May 2026 17:25:38 -0700
Message-ID: <20260517002550.321291-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260517002550.321291-1-richard.henderson@linaro.org>
References: <20260517002550.321291-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

At the same time, export.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/fpu/softfloat-parts.h |  3 +++
 fpu/softfloat.c               | 18 +++++++++---------
 fpu/softfloat-parts.c.inc     | 14 ++++++++------
 3 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/include/fpu/softfloat-parts.h b/include/fpu/softfloat-parts.h
index 9504d0daa0..46618d217e 100644
--- a/include/fpu/softfloat-parts.h
+++ b/include/fpu/softfloat-parts.h
@@ -214,4 +214,7 @@ FloatParts128 parts128_round_to_int(const FloatParts128 *a,
 FloatParts64 parts64_round_to_fmt(const FloatParts64 *p, float_status *s,
                                   const FloatFmt *fmt);
 
+FloatParts64 parts64_scalbn(const FloatParts64 *a, int n, float_status *s);
+FloatParts128 parts128_scalbn(const FloatParts128 *a, int n, float_status *s);
+
 #endif
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 90ebd83f69..7fc6df461e 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -1910,7 +1910,7 @@ float16 float16_muladd_scalbn(float16 a, float16 b, float16 c,
 
     /* Before rounding, scale. */
     if (scale) {
-        parts64_scalbn(pr, scale, status);
+        *pr = parts64_scalbn(pr, scale, status);
     }
     parts64_uncanon(pr, status, &float16_params, false);
     /* After rounding, apply negate result, especially for -0.0. */
@@ -1937,7 +1937,7 @@ float32_muladd_scalbn(float32 a, float32 b, float32 c,
 
     /* Before rounding, scale. */
     if (scale) {
-        parts64_scalbn(pr, scale, status);
+        *pr = parts64_scalbn(pr, scale, status);
     }
     parts64_uncanon(pr, status, &float32_params, false);
     /* After rounding, apply negate result, especially for -0.0. */
@@ -1958,7 +1958,7 @@ float64_muladd_scalbn(float64 a, float64 b, float64 c,
 
     /* Before rounding, scale. */
     if (scale) {
-        parts64_scalbn(pr, scale, status);
+        *pr = parts64_scalbn(pr, scale, status);
     }
     parts64_uncanon(pr, status, &float64_params, false);
     /* After rounding, apply negate result, especially for -0.0. */
@@ -4312,7 +4312,7 @@ float16 float16_scalbn(float16 a, int n, float_status *status)
 {
     FloatParts64 p = float16_unpack_canonical(a, status);
 
-    parts64_scalbn(&p, n, status);
+    p = parts64_scalbn(&p, n, status);
     return float16_round_pack_canonical(&p, status);
 }
 
@@ -4320,7 +4320,7 @@ float32 float32_scalbn(float32 a, int n, float_status *status)
 {
     FloatParts64 p = float32_unpack_canonical(a, status);
 
-    parts64_scalbn(&p, n, status);
+    p = parts64_scalbn(&p, n, status);
     return float32_round_pack_canonical(&p, status);
 }
 
@@ -4328,7 +4328,7 @@ float64 float64_scalbn(float64 a, int n, float_status *status)
 {
     FloatParts64 p = float64_unpack_canonical(a, status);
 
-    parts64_scalbn(&p, n, status);
+    p = parts64_scalbn(&p, n, status);
     return float64_round_pack_canonical(&p, status);
 }
 
@@ -4336,7 +4336,7 @@ bfloat16 bfloat16_scalbn(bfloat16 a, int n, float_status *status)
 {
     FloatParts64 p = bfloat16_unpack_canonical(a, status);
 
-    parts64_scalbn(&p, n, status);
+    p = parts64_scalbn(&p, n, status);
     return bfloat16_round_pack_canonical(&p, status);
 }
 
@@ -4344,7 +4344,7 @@ float128 float128_scalbn(float128 a, int n, float_status *status)
 {
     FloatParts128 p = float128_unpack_canonical(a, status);
 
-    parts128_scalbn(&p, n, status);
+    p = parts128_scalbn(&p, n, status);
     return float128_round_pack_canonical(&p, status);
 }
 
@@ -4355,7 +4355,7 @@ floatx80 floatx80_scalbn(floatx80 a, int n, float_status *status)
     if (!floatx80_unpack_canonical(&p, a, status)) {
         return floatx80_default_nan(status);
     }
-    parts128_scalbn(&p, n, status);
+    p = parts128_scalbn(&p, n, status);
     return floatx80_round_pack_canonical(&p, status);
 }
 
diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index 2114797aca..3a9c2748cd 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -1633,22 +1633,24 @@ FloatRelation partsN(compare)(const FloatPartsN *a, const FloatPartsN *b,
 /*
  * Multiply A by 2 raised to the power N.
  */
-static void partsN(scalbn)(FloatPartsN *a, int n, float_status *s)
+FloatPartsN partsN(scalbn)(const FloatPartsN *a, int n, float_status *s)
 {
     switch (a->cls) {
     case float_class_snan:
     case float_class_qnan:
-        *a = partsN(return_nan)(a, s);
-        break;
+        return partsN(return_nan)(a, s);
     case float_class_zero:
     case float_class_inf:
-        break;
+        return *a;
     case float_class_denormal:
         float_raise(float_flag_input_denormal_used, s);
         /* fall through */
     case float_class_normal:
-        a->exp += MIN(MAX(n, -0x10000), 0x10000);
-        break;
+        {
+            FloatPartsN r = *a;
+            r.exp += MIN(MAX(n, -0x10000), 0x10000);
+            return r;
+        }
     default:
         g_assert_not_reached();
     }
-- 
2.43.0


