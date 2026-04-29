Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45C37FF887E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 22:30:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIDPr-0007Ta-8Y; Wed, 29 Apr 2026 18:29:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIDPp-0007HP-JI
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:29:57 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIDPn-00070M-W4
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:29:57 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-36146ae9dd4so180717a91.3
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 15:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777501794; x=1778106594; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EOYX+NP5RHEsrA3crlpA7RJBv8PoGP3LgxhB7baMhkM=;
 b=M2l7GCNU2XEDURprpeQHccJM5SSrYXE3NtmuUooTPefa0RGxmySHlz3/IMF6JkjRPg
 dyYqQ7715k6Ou/erD/cX3lwhGGHCrKGY81cBvlGPfELKXQNDervESBKRKaqCGVTQjawE
 ZnIiWrs/nkNjn7cg6+aEodEom5hWS6JXWIUEctRda52APbDCXJaG6nmznBjYyORAXaq0
 HPKcOstBPUkTMaspmdr8bIhEAGBOg8di/iP89yNaolywAjmERVqE3hCi0jY1F8wl+OBf
 V2kVxV8QTxeNehNW4JO33TAup3qGmm79VnN3IOG3X/aeCSd+xm6KUyp8dFWhnNQ2poUp
 KNMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777501794; x=1778106594;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EOYX+NP5RHEsrA3crlpA7RJBv8PoGP3LgxhB7baMhkM=;
 b=HS8+FNLgMgyjDssCAn+wRO8HAWcU/b6fUziv/yFCa5sJc1IEV08pjd0l+Y1mqYIA1f
 uIObg5biFj2AvYXdIiAm6yLI/2KE6cVGOcLS5ACUoqS8kxehJxdpSMuoAyOy92Rw915k
 vVt1QC/OSHNpW/1zGuTHL3FW1tyW6E6vOQneDmiRNl8DREuvTMrvTjaghphiivcBY7XC
 l2fXo3HkGSCSEnbk7HhP2Inc2yLzn7kSX/zeJkwE54WG7cyV6TQY5wAM2t2AOdeU1kr3
 TmYwU4dV6I1UNXHokXHspQ1a0DJhpEmaFce3cUWOjDyGpj1onNLXDalh765WDEdFMCqS
 VWWA==
X-Gm-Message-State: AOJu0Yztf1E669nOFdc3mBX/CW3FCt3ARJNrh+sWpb8ZJYVnnbQ0a40N
 EmsgkSqcysz/IM4zcURfdwQWGU6LdeWfJ0y3tVMaoJwaH0ZA0aKnvhQe/X6fil3dfxsXXm7iVlh
 rE6nR88M=
X-Gm-Gg: AeBDievL07hpqRbIcsd7oDeTOwa5ZUem1E/2CqYSfz6Lr0Lqgmn9OObXfjWcqiCh4BS
 g4IDPErCvia8eJwSjR2PomwLx9ETX3tR+GB1Z3QfN5Qh0iDI58rxOtIaTW6UIPbR94HSM3OzcN+
 pL0lzIsJgyHcuFSof9Ee2XqAiSTai6uoRXhqBIRUa/OmxOiFDZheC7BSAgTXt7u5AZgT8v99wIv
 g+5qtUCWBLmnCZs9vegYX+5oERNNYIppux4EE9J2Slf+1+ngvqhvghW3qvHpwsYQmxifDccX0KK
 AY/bH9CcBn6Z9GViLjwUEYYj4tiIsV3mBmBwGmfwpTtIa+CwJwXZz8YnTB9tLndDxBjOGRBl8Lp
 oDMTHtUhdLOeFMKlpzsY7KM7ZenWeFTRx/15QEdSKj8LUgcQoG90SpD3yuL6SnWHxyUZ69hXfpZ
 xAFV/RZKunOGiDUVrPbzt//XTwo7p2CDAp1Awfinnp
X-Received: by 2002:a17:90b:3909:b0:364:7464:12a3 with SMTP id
 98e67ed59e1d1-364c2f40d6dmr245460a91.10.1777501794336; 
 Wed, 29 Apr 2026 15:29:54 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-364bdf54203sm630479a91.7.2026.04.29.15.29.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 15:29:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 47/48] fpu: Change parts_float_to_float_narrow to
 parts128_to_parts64
Date: Thu, 30 Apr 2026 08:24:44 +1000
Message-ID: <20260429222445.26301-48-richard.henderson@linaro.org>
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

Rename and return FloatParts64 structure.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 77585fa11f..99f0036d0d 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -2563,29 +2563,31 @@ static void parts128_float_to_float(FloatParts128 *a, float_status *s)
     }
 }
 
-static void parts_float_to_float_narrow(FloatParts64 *a, FloatParts128 *b,
-                                        float_status *s)
+static FloatParts64 parts128_to_parts64(FloatParts128 *b, float_status *s)
 {
-    a->cls = b->cls;
-    a->sign = b->sign;
-    a->exp = b->exp;
+    FloatParts64 r = {
+        .cls = b->cls,
+        .sign = b->sign,
+        .exp = b->exp,
+    };
 
-    switch (a->cls) {
+    switch (r.cls) {
     case float_class_denormal:
         float_raise(float_flag_input_denormal_used, s);
         /* fall through */
     case float_class_normal:
-        frac64_truncjam(a, b);
+        frac64_truncjam(&r, b);
         break;
     case float_class_snan:
     case float_class_qnan:
         /* Discard the low bits of the NaN. */
-        a->frac = b->frac_hi;
-        parts64_return_nan(a, s);
+        r.frac = b->frac_hi;
+        parts64_return_nan(&r, s);
         break;
     default:
         break;
     }
+    return r;
 }
 
 static void parts_float_to_float_widen(FloatParts128 *a, FloatParts64 *b,
@@ -2773,18 +2775,16 @@ bfloat16 float64_to_bfloat16(float64 a, float_status *s)
 float32 float128_to_float32(float128 a, float_status *s)
 {
     FloatParts128 p128 = float128_unpack_canonical(a, s);
-    FloatParts64 p64;
+    FloatParts64 p64 = parts128_to_parts64(&p128, s);
 
-    parts_float_to_float_narrow(&p64, &p128, s);
     return float32_round_pack_canonical(&p64, s);
 }
 
 float64 float128_to_float64(float128 a, float_status *s)
 {
     FloatParts128 p128 = float128_unpack_canonical(a, s);
-    FloatParts64 p64;
+    FloatParts64 p64 = parts128_to_parts64(&p128, s);
 
-    parts_float_to_float_narrow(&p64, &p128, s);
     return float64_round_pack_canonical(&p64, s);
 }
 
@@ -2812,7 +2812,7 @@ float32 floatx80_to_float32(floatx80 a, float_status *s)
     FloatParts128 p128;
 
     if (floatx80_unpack_canonical(&p128, a, s)) {
-        parts_float_to_float_narrow(&p64, &p128, s);
+        p64 = parts128_to_parts64(&p128, s);
     } else {
         parts64_default_nan(&p64, s);
     }
@@ -2825,7 +2825,7 @@ float64 floatx80_to_float64(floatx80 a, float_status *s)
     FloatParts128 p128;
 
     if (floatx80_unpack_canonical(&p128, a, s)) {
-        parts_float_to_float_narrow(&p64, &p128, s);
+        p64 = parts128_to_parts64(&p128, s);
     } else {
         parts64_default_nan(&p64, s);
     }
-- 
2.43.0


