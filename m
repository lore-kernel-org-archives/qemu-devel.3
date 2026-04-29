Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67A40FF887E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 22:28:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIDMY-0004YH-II; Wed, 29 Apr 2026 18:26:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIDMX-0004Pj-7g
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:26:33 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIDMV-0005M8-MD
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:26:32 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-35f9ab079bdso151416a91.2
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 15:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777501590; x=1778106390; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ic5R2ez4UqOiDOUr1K1unDFT8fxnIMY+Ht6D+IglkAg=;
 b=jz/XAYXYZy8+ixhV2bfvkGKN9H92/HHYaLCBcScaA9kuFGX+A/aeyfd5Y2RPHiAgQA
 y/K//Q1T7Ad2yJhaJeKbjAFX+AGM+XT9WtPXK0zLZHZLrvLi3/E6jCNx4IkrYjrmkeSr
 cV/7j9HmL6/RiXuM5vgxnTVgYToEXCjJz6WKKL2o9wFNLHh02lEES/LurdJaKyqtrgSQ
 XZ0x/AELXMy3EDc5ZBtGb/jGdeT9bRsIxPVhzxIvVf/Sd99UsgDtVWpuC07TPuYnfXRS
 6p9txJSfwtg0GgmSKqpTkJD9F1sJEcWP2Y8yvYC5rlcTT97aTq/kqbVH08sgM2GWpXJc
 QLYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777501590; x=1778106390;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ic5R2ez4UqOiDOUr1K1unDFT8fxnIMY+Ht6D+IglkAg=;
 b=mJbLqLKpWh9Txk7EpL1Mx7Pta1f++31cCEQ4TwsNWruWXl/9x0eOx+BjYdyOehVhGM
 DJQq5wKCaBgbV/ekRGiaQet3slJ1C4IwZG2E4WeWTPsibTdw+zcUI7RsuBdMJye4O27x
 hR3OxOYXqmpl2lrSaVQA8PCo49WQGd4oumWO9JOKtukMwHEFnWUZoGbJJ2Ed71jPJ08N
 KtmfBd4Q/B5/oF/efjo7+AWppmNIb9VYajeUTmVynXVUktOSWk54wfArLBSJgqy8mQyL
 OifsFed06JRAUWtLhlkRVRy7bce02Q6st6YwE7HXgRJuX3sZPXjUYqyDcr+YGbMDVt8F
 SMpw==
X-Gm-Message-State: AOJu0YwJH5TTcpWkzNsgWy5D53W4u0SaG6H4QiGpn7PQMvdEOqsA4wGo
 6TIT+aB1nWFDABU0UvDQBLSoB+OifmzlmHv04OLspeJsiCX4wN+55Mkz8R1ShBwxejuiXu2Inwv
 m+oP2OjU=
X-Gm-Gg: AeBDiesx3YRq+a0Ys1r5GQ9dy/u5bcqE751sE6/zIhOi19F7MDUfpiWcgXl+Nu2VEsS
 Sm4AYNXByhv4f2t9DyADI+73CjMayRA/klQ2dMEjXextipAFgaOApmrGRQwbpre/r+Gbt3XVT2X
 BMuw+Wz+nDkeN4PuJ7mnYFu/JDBGnQXycN/UFpdCYXbjmx08KWyaZ4z3jjFiq9DwImGTSpINsH2
 AA7gAZPfDnIH1hiuRGpeJEnHn4bpS5edgcSRpC0F3G7RV726PkTgtoPIz108cUfFC50Yuvg1jvE
 7dMdDZGbO2++5SIFoziORY2skXzJqOj9XEmfDPnT57pCxn2Jc8DCvZ1MIpgSUO2kCnIKb/qXQyk
 2I4mHop3tseLH77PuY76UBPsT6aql2zdyVjyvOY9IYdBSCsi0nEsDLhMmTcsQSq2CIMELIcVF0k
 iwKSjzlTARNybKfMT1C3QgJ29tHulzVA7h8SJL1s1U
X-Received: by 2002:a17:90b:2f03:b0:362:bb93:f25e with SMTP id
 98e67ed59e1d1-364c312f38amr149536a91.23.1777501590264; 
 Wed, 29 Apr 2026 15:26:30 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-364a2732502sm1888471a91.3.2026.04.29.15.26.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 15:26:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 39/48] fpu: Inline bfloat16_unpack_raw into callers
Date: Thu, 30 Apr 2026 08:24:36 +1000
Message-ID: <20260429222445.26301-40-richard.henderson@linaro.org>
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 3612d2fceb..566154a729 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -646,11 +646,6 @@ static FloatParts64 unpack_raw64(const FloatFmt *fmt, uint64_t raw)
     };
 }
 
-static void QEMU_FLATTEN bfloat16_unpack_raw(FloatParts64 *p, bfloat16 f)
-{
-    *p = unpack_raw64(&bfloat16_params, f);
-}
-
 static void QEMU_FLATTEN float32_unpack_raw(FloatParts64 *p, float32 f)
 {
     *p = unpack_raw64(&float32_params, f);
@@ -1490,7 +1485,7 @@ static FloatParts64 float16_unpack_canonical(float16 f, float_status *s)
 static void bfloat16_unpack_canonical(FloatParts64 *p, bfloat16 f,
                                       float_status *s)
 {
-    bfloat16_unpack_raw(p, f);
+    *p = unpack_raw64(&bfloat16_params, f);
     parts64_canonicalize(p, s, &bfloat16_params);
 }
 
@@ -4974,9 +4969,8 @@ float64 float64_silence_nan(float64 a, float_status *status)
 
 bfloat16 bfloat16_silence_nan(bfloat16 a, float_status *status)
 {
-    FloatParts64 p;
+    FloatParts64 p = unpack_raw64(&bfloat16_params, a);
 
-    bfloat16_unpack_raw(&p, a);
     p.frac <<= bfloat16_params.frac_shift;
     parts64_silence_nan(&p, status);
     p.frac >>= bfloat16_params.frac_shift;
@@ -5050,9 +5044,8 @@ float64 float64_squash_input_denormal(float64 a, float_status *status)
 bfloat16 bfloat16_squash_input_denormal(bfloat16 a, float_status *status)
 {
     if (status->flush_inputs_to_zero) {
-        FloatParts64 p;
+        FloatParts64 p = unpack_raw64(&bfloat16_params, a);
 
-        bfloat16_unpack_raw(&p, a);
         if (parts_squash_denormal(p, status)) {
             return bfloat16_set_sign(bfloat16_zero, p.sign);
         }
-- 
2.43.0


