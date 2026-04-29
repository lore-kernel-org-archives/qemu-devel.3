Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 865EBFF8875
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 22:30:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIDPs-0007bX-OM; Wed, 29 Apr 2026 18:30:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIDPr-0007XJ-SI
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:29:59 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIDPq-00070e-8j
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:29:59 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-362e30526f8so87451a91.3
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 15:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777501797; x=1778106597; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s6tzMLeDV39/rK6I0d/m92UEPKLHUSC6SYfF3BneVk4=;
 b=XtRgfTuhxGvzMPNjzTuOMLqSsh2zla1UBRqNrl2/4tiwgpsJCWES2n09P88YPvfsuU
 5kun6RsJHURT0v6GqHzioKogV7h5jd/844m5lg/45G65m8b1iSbLPYn0yFYOtTyocnPn
 h/vAg23T0aRwUCDW37jlXPkezt2if284K756vNL3dE565vPvDvnJJjooO583oo6qppYf
 nQQDr4/gyx03xOnqLD4iODCR0SFw4EDXn6ySykW2QiHtQ2ZOXXSkdk0LGcFQ0iwgeP70
 CTF0vB9eH4Wloq67ieU2IjzTyXFDUo/L4v+4ndp4PfcB9/hNRJuOrXVktCFwzenRKvAb
 iTFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777501797; x=1778106597;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=s6tzMLeDV39/rK6I0d/m92UEPKLHUSC6SYfF3BneVk4=;
 b=q1r+577MqcyqXeMpl8hxn+RXGdEvPRDO7zP7D91rka2F/x82uvYvpw3NSSVUx12eFo
 kOcqyW9NLauSdDO/hoTOPbztly8Hb+h4/5y00Qv4FIYH/jUj9X+70yirMEr2HGkUjuxD
 B3Zu7xkJPm6VoKTILuST7jFNMDHXs1quBsqoLn3dNUU5tvGoc85vL9hcmpqewngFyrzN
 SJ4uaIZ6Sp0taQDdVVZCH6p8m6xdAtzJGu4VbEI6bAlGoTGDo0fuW9I7ARgOLHZ96XUA
 A7OQ9IwcOfEtbQzbS//Ylg7auV8mWIE5Qyoig6fkKks52CJ4TzwTJ4rE9sHFXH1gw4uz
 W/iQ==
X-Gm-Message-State: AOJu0YwUv0lphi2AiY9UstrMFde/C1rrBH2vazIa2me4aCnrXjsj77jH
 7vNP5O/aKe2fJR3xdqW8XdJqpc0YeV86FC+O0KDxkAzgTxN57wnih+F+YpQmQsyzsXSgR7n1PE5
 ca5d1sw4=
X-Gm-Gg: AeBDiesd41J+BKK6ues6v8Eq+WLOkEPi8zzr2aPgfwGv1aJLB/8JW1fQ5Z+cy6W/h78
 GxMzZUQVGwF0o9mu7Y2Rgv9JgrEZheEZQV6Ot7mcSu0asKXOwLVY83xu2Ek2SERL+6Zlj8TE0uZ
 qax0WuZFZCcQ2rJmtrGAgJMEFuoFz6o+/Aey5g5chP1vW5gh5DSru98BlfpgGTCmQSG18ZZeG27
 S8HVwYne+rracBiVo0G7N8IbhCdo2QI1Xg0uBnWTzoA0LuilzlNCTsyqeBUzGHRyKESDE8hXpuA
 HrUL1BKEnMKpPc6uKVbV0PUTHaDwPm9qspAc+36+E+wHjo2NtHYtBCKw/hXO2B7CeLv9P7OgqlG
 HhkxMIH7G59DrgmvUzbY7QBowJ/kQkXWm7EyjEM9nVkHIRVkYqjDlg6OqiLFyk5nqQOxwQvmkF5
 vHWrTEaMCVPybKHdzlTyUJMIF8ZBxXVNekm4lal9qsTg3kE2hkpN8=
X-Received: by 2002:a17:90a:d00f:b0:364:a6a4:596e with SMTP id
 98e67ed59e1d1-364c313c536mr155361a91.24.1777501796789; 
 Wed, 29 Apr 2026 15:29:56 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-364bdf54203sm630479a91.7.2026.04.29.15.29.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 15:29:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 48/48] fpu: Change parts_float_to_float_widen to
 parts64_to_parts128
Date: Thu, 30 Apr 2026 08:24:45 +1000
Message-ID: <20260429222445.26301-49-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429222445.26301-1-richard.henderson@linaro.org>
References: <20260429222445.26301-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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

Rename and return FloatParts128 structure.
Use switch instead of 2 ifs.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c | 39 +++++++++++++++++++++------------------
 1 file changed, 21 insertions(+), 18 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 99f0036d0d..5d58caf5ea 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -2590,20 +2590,27 @@ static FloatParts64 parts128_to_parts64(FloatParts128 *b, float_status *s)
     return r;
 }
 
-static void parts_float_to_float_widen(FloatParts128 *a, FloatParts64 *b,
-                                       float_status *s)
+static FloatParts128 parts64_to_parts128(FloatParts64 *b, float_status *s)
 {
-    a->cls = b->cls;
-    a->sign = b->sign;
-    a->exp = b->exp;
-    frac64_widen(a, b);
+    FloatParts128 r = {
+        .cls = b->cls,
+        .sign = b->sign,
+        .exp = b->exp,
+        .frac_hi = b->frac,
+    };
 
-    if (is_nan(a->cls)) {
-        parts128_return_nan(a, s);
-    }
-    if (a->cls == float_class_denormal) {
+    switch (r.cls) {
+    case float_class_qnan:
+    case float_class_snan:
+        parts128_return_nan(&r, s);
+        break;
+    case float_class_denormal:
         float_raise(float_flag_input_denormal_used, s);
+        break;
+    default:
+        break;
     }
+    return r;
 }
 
 float8_e4m3 float4_e2m1_to_float8_e4m3(float4_e2m1 a, float_status *s)
@@ -2791,18 +2798,16 @@ float64 float128_to_float64(float128 a, float_status *s)
 float128 float32_to_float128(float32 a, float_status *s)
 {
     FloatParts64 p64 = float32_unpack_canonical(a, s);
-    FloatParts128 p128;
+    FloatParts128 p128 = parts64_to_parts128(&p64, s);
 
-    parts_float_to_float_widen(&p128, &p64, s);
     return float128_round_pack_canonical(&p128, s);
 }
 
 float128 float64_to_float128(float64 a, float_status *s)
 {
     FloatParts64 p64 = float64_unpack_canonical(a, s);
-    FloatParts128 p128;
+    FloatParts128 p128 = parts64_to_parts128(&p64, s);
 
-    parts_float_to_float_widen(&p128, &p64, s);
     return float128_round_pack_canonical(&p128, s);
 }
 
@@ -2847,18 +2852,16 @@ float128 floatx80_to_float128(floatx80 a, float_status *s)
 floatx80 float32_to_floatx80(float32 a, float_status *s)
 {
     FloatParts64 p64 = float32_unpack_canonical(a, s);
-    FloatParts128 p128;
+    FloatParts128 p128 = parts64_to_parts128(&p64, s);
 
-    parts_float_to_float_widen(&p128, &p64, s);
     return floatx80_round_pack_canonical(&p128, s);
 }
 
 floatx80 float64_to_floatx80(float64 a, float_status *s)
 {
     FloatParts64 p64 = float64_unpack_canonical(a, s);
-    FloatParts128 p128;
+    FloatParts128 p128 = parts64_to_parts128(&p64, s);
 
-    parts_float_to_float_widen(&p128, &p64, s);
     return floatx80_round_pack_canonical(&p128, s);
 }
 
-- 
2.43.0


