Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EBEDFF885C
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2026 13:50:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGznN-0005MZ-6F; Sun, 26 Apr 2026 09:45:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGznF-0005FO-TP
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:45:07 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGznE-00013l-EX
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:45:05 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2aae146b604so62458205ad.3
 for <qemu-devel@nongnu.org>; Sun, 26 Apr 2026 06:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777211103; x=1777815903; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EyggtB0YDpyXoFcXzmAjc9/sw1llDlReS0pMf+TeAR4=;
 b=tg/bVNhZrjJmS0nLvURwdp9HA5WiWV5t62NMcDtRTesotAyA19mjoxQBINLHTzhTLx
 r5x+2RRun5qfwDEKpWSlhhM4yD2XvZyA1X++zVv7qKxNYjS5RibZKBGG/YEJICZkYTNd
 +dUwmwHBKV6Op62K4ZmAAu1ITWX7D7JWz57haVVApAPq2kZP84jLO0mDqFpxtbK558p1
 GEfzdWsilACcRtKQFGSqtEopuCQHgIn6dvF1Me4KmHLHH+OuS+a68YfFwMBMRj23vm1V
 k8JmX6Zu5r1HZC5Hct3Yo4J9xF98hRakDWyHw4/UuwSYVo+pQIIAXJMwRXtc0pRy6lb2
 7vgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777211103; x=1777815903;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EyggtB0YDpyXoFcXzmAjc9/sw1llDlReS0pMf+TeAR4=;
 b=tYjDwX/tgd987cuUpmZdJTqMR/JzkQ2jBg5PJzEJZw+Vrif21BwkBkuidD2SgcL4Ew
 24EXtRu3TCDjSlKLA0gFEvDPXTA5kRPIh0KiufYDDKYJLvZR72lMELlUe1cN5K4ZksMB
 F5cELDeGS4i0ux7DOGnEqXerNY58qlMDWl/7uMBO+q0pUYsIbKbRbOALp26GEOZ94cIt
 rVFjhabCMQWM/NhrKcp71eIUXQ8zWJiqRw8WmvYNKipcDk6irO08VOx6VOSF6TUUnCR9
 RpYI5a3Jj1pRjUIjT1jiTBp+yXtnllQDoR2f5RWHCPQOJlhHFia9CCd4wwlUd21Eb0Xs
 VWYw==
X-Gm-Message-State: AOJu0YyQ99hpA90A+02auEdUdRpu0sKYNOTce/02PYKfwiqqy5IgNkDw
 U9zB1+eO6Vyei+nvDx/2f/5ruDpg4fSoNYWd8hVMEroEz/t5H5CboFY8mb3EcqVhASHSFDEu+ST
 UqNDN3cg=
X-Gm-Gg: AeBDievhaG8kbCRndEUYwh7/i27bJp/9GmJvHkW9Pwwb2xlL72UdQm1CSKr7RPewcDu
 UUADHdRveRuMAnb833RhtuuVfI1kvdJcl7GkeaNJt9L4QAZRoUp7gyLBYL98H4UH+CfgSKizyMb
 RVdUSB42qawJN0z1fQ/SPdZldNS2Hp4jI9K+SUYyzGyUKlb3Co1spJnZiBbPzKBDP7a7mxO3ZYL
 iM4oxDI4Ek8vkaVSi5YNVJdM0sklLlFYtBYvuVAZsMVJoQTLUy+fxYFa6Niho/pa1K2YpaLtfiV
 iP0TBgpzQcLut5yV34kSScVcspTLvfhvNvm7zaSIxdHS4gd0eUNdrGzp/zW/WnJGldjEDgZvsvz
 HErUfmgcdLkSNYGpzJ+jtcpHioGLn40diXIWDN+Ia9XLkAm/hbq9fqqydH3Ib7+DjFd9fudGKOf
 Cwnbg5EIH0EfSE83up4i23jlrRkiM5+Ftx/BRdAiPM
X-Received: by 2002:a17:903:1ac6:b0:2b2:5840:809c with SMTP id
 d9443c01a7336-2b5f9e77d75mr398042445ad.1.1777211103030; 
 Sun, 26 Apr 2026 06:45:03 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5faa34ea7sm280544085ad.34.2026.04.26.06.45.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 06:45:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	qemu-s390x@nongnu.org
Subject: [PATCH 42/84] fpu: Inline float64_unpack_raw into callers
Date: Sun, 26 Apr 2026 23:39:19 +1000
Message-ID: <20260426134002.865628-43-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260426134002.865628-1-richard.henderson@linaro.org>
References: <20260426134002.865628-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 5e33eab8d5..e1b92b38b6 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -646,11 +646,6 @@ static FloatParts64 unpack_raw64(const FloatFmt *fmt, uint64_t raw)
     };
 }
 
-static void QEMU_FLATTEN float64_unpack_raw(FloatParts64 *p, float64 f)
-{
-    *p = unpack_raw64(&float64_params, f);
-}
-
 static void QEMU_FLATTEN floatx80_unpack_raw(FloatParts128 *p, floatx80 f)
 {
     *p = (FloatParts128) {
@@ -1538,7 +1533,7 @@ static float32 float32_round_pack_canonical(FloatParts64 *p,
 static void float64_unpack_canonical(FloatParts64 *p, float64 f,
                                      float_status *s)
 {
-    float64_unpack_raw(p, f);
+    *p = unpack_raw64(&float64_params, f);
     parts64_canonicalize(p, s, &float64_params);
 }
 
@@ -4918,9 +4913,8 @@ float32 float32_silence_nan(float32 a, float_status *status)
 
 float64 float64_silence_nan(float64 a, float_status *status)
 {
-    FloatParts64 p;
+    FloatParts64 p = unpack_raw64(&float64_params, a);
 
-    float64_unpack_raw(&p, a);
     p.frac <<= float64_params.frac_shift;
     parts64_silence_nan(&p, status);
     p.frac >>= float64_params.frac_shift;
@@ -4990,9 +4984,8 @@ float32 float32_squash_input_denormal(float32 a, float_status *status)
 float64 float64_squash_input_denormal(float64 a, float_status *status)
 {
     if (status->flush_inputs_to_zero) {
-        FloatParts64 p;
+        FloatParts64 p = unpack_raw64(&float64_params, a);
 
-        float64_unpack_raw(&p, a);
         if (parts_squash_denormal(p, status)) {
             return float64_set_sign(float64_zero, p.sign);
         }
-- 
2.43.0


