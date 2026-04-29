Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08488FF8875
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 22:26:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIDLv-0000n4-4k; Wed, 29 Apr 2026 18:25:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIDLt-0000lQ-Gv
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:25:53 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIDLr-00057W-H4
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:25:53 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-362e30526f8so86592a91.3
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 15:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777501550; x=1778106350; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ac5q/tTacElPucdQ/j5OD9vX31OKYPKzNeO8QvRD8MI=;
 b=qhkTK6BmtLH8GH8fR6zGVSLTUPAm66ErKYlgkYUJBGkLjaIguzLZenbWS45mc6A+kj
 1EMbvU/upERW5/K/yj30qkuE+ta4L6dGLVobqYefBLPDbSHV4eWstqVgfZhhkqykNgJn
 7Cgb2+hNcOF9nV959TPmp2nWIjgL3tq+LM+2nMyAS7Plc6jK6Ogy9o30ZGaIIc3f6C5K
 9S+AGlrun4dJZi7T0fpuzQghcXJkcc0yPR4G8W2ehvv5iwJkVvlbM/Ikt4EwmyKrgrTF
 unf49puToOtGbGJf5ftAPJyZgu5IY3khxfLOurVjD6h7/OJIkIe69IUyjSqWavnKUEyY
 /ATA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777501550; x=1778106350;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ac5q/tTacElPucdQ/j5OD9vX31OKYPKzNeO8QvRD8MI=;
 b=Ps8GUYtZvZ+N6Emcf1TeYVfXJMIx4REV2PAOH2qDvj6sh3pJG5iVPKSBR2ZaWg8lQd
 y8em2omfsZ44vyUcso4j+dvIi5dM+irS/r1rfihDYOpMxk98pM33NOGX+nDxFKMUFClk
 /VDCMc2hSnJK1+NtAaUjiy0d2COpdxxd9rR9CbUrMB3WlZCpFEF75T5nuXttqU3dMYM8
 a3GPR3OYuq+CXv0UrgSdVbP+Pcev/YUqpUpUP27cmq+UzYvG2qf4HAYlKUuNdySfjYNw
 xJIwZLzHzSqAas+1KjgBtN2LF6FS3esGR0CyeA+S48V/KPasxLp3vwdgbZF17ouWEOpI
 5XLQ==
X-Gm-Message-State: AOJu0YwTXFENZhnS66YynHOT9/GVzu6Hz31EQtvaA10zl0T0iU8W4EYK
 GUUkB2+l4o2i7OQE/GPpOsI/LLdBhzHVPBigc5AmqYtGtpETmwUyFAW+gRmM6LSwKdFR0pDfOlT
 ppNtHuEE=
X-Gm-Gg: AeBDievWAikSiWC9sUN7aArT8yybKCihU0nKVr/evZ7WSYHswdSB5Ka6nW8Zyny/TCv
 7nmdnwzf+Ur9MmRrL29te7kniO37BbtveddUL9qVJWpwcGbSFpf3EjS55Dp+j/bn/TBLyfRiYMa
 Kz4zIt3tytox7KiIW8J40BE/aFnpbFGpSShhairBerlbYbedvisQ5/0q2Th6U85ypzUsDd8rjzm
 DSCZ0NQGcKhkJx0dxWpImKFVeX7EignZRik/ycoo1DztAkVOcDsbaEbhJwV7I8YzqOHsma6Cs8V
 LAYa6mbMj5QRV+ZXES3ZTdTJ3KRS8BpMfSaLHT6gM0xXT0keNWtPSh8Q/SY+q80eJeEp4ZcBeFa
 mbK52pwyajlnaV+fq0LEawEjvHzMvDuFJBBMTzQyXPaXASRtoF/K2BCEkeA1YUjFK01fi5q84t2
 f6rNpKOjZNN+AL2vjrCWo43pHzhh9CUGfyEHiXbUWO
X-Received: by 2002:a17:90b:5830:b0:35f:be11:b3e0 with SMTP id
 98e67ed59e1d1-364c2f20cd7mr192496a91.2.1777501550115; 
 Wed, 29 Apr 2026 15:25:50 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-364a2732502sm1888471a91.3.2026.04.29.15.25.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 15:25:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 23/48] fpu: Drop parts_uint_to_float
Date: Thu, 30 Apr 2026 08:24:20 +1000
Message-ID: <20260429222445.26301-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429222445.26301-1-richard.henderson@linaro.org>
References: <20260429222445.26301-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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

Use parts{64,128}_uint_to_float at each call site.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index bbfdf1a076..8d5f3c48e7 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -779,14 +779,6 @@ static float128 QEMU_FLATTEN float128_pack_raw(const FloatParts128 *p)
                   FloatParts128 *: parts128_##NAME, \
                   FloatParts256 *: parts256_##NAME)
 
-static void parts64_uint_to_float(FloatParts64 *p, uint64_t a,
-                                  int scale, float_status *s);
-static void parts128_uint_to_float(FloatParts128 *p, uint64_t a,
-                                   int scale, float_status *s);
-
-#define parts_uint_to_float(P, I, Z, S) \
-    PARTS_GENERIC_64_128(uint_to_float, P)(P, I, Z, S)
-
 static FloatParts64 *parts64_minmax(FloatParts64 *a, FloatParts64 *b,
                                     float_status *s, int flags);
 static FloatParts128 *parts128_minmax(FloatParts128 *a, FloatParts128 *b,
@@ -4225,7 +4217,7 @@ float16 uint64_to_float16_scalbn(uint64_t a, int scale, float_status *status)
 {
     FloatParts64 p;
 
-    parts_uint_to_float(&p, a, scale, status);
+    parts64_uint_to_float(&p, a, scale, status);
     return float16_round_pack_canonical(&p, status);
 }
 
@@ -4270,7 +4262,7 @@ float32 uint64_to_float32_scalbn(uint64_t a, int scale, float_status *status)
         return ur.s;
     }
 
-    parts_uint_to_float(&p, a, scale, status);
+    parts64_uint_to_float(&p, a, scale, status);
     return float32_round_pack_canonical(&p, status);
 }
 
@@ -4310,7 +4302,7 @@ float64 uint64_to_float64_scalbn(uint64_t a, int scale, float_status *status)
         return ur.s;
     }
 
-    parts_uint_to_float(&p, a, scale, status);
+    parts64_uint_to_float(&p, a, scale, status);
     return float64_round_pack_canonical(&p, status);
 }
 
@@ -4343,7 +4335,7 @@ bfloat16 uint64_to_bfloat16_scalbn(uint64_t a, int scale, float_status *status)
 {
     FloatParts64 p;
 
-    parts_uint_to_float(&p, a, scale, status);
+    parts64_uint_to_float(&p, a, scale, status);
     return bfloat16_round_pack_canonical(&p, status);
 }
 
@@ -4386,7 +4378,7 @@ float128 uint64_to_float128(uint64_t a, float_status *status)
 {
     FloatParts128 p;
 
-    parts_uint_to_float(&p, a, 0, status);
+    parts128_uint_to_float(&p, a, 0, status);
     return float128_round_pack_canonical(&p, status);
 }
 
-- 
2.43.0


