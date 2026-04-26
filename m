Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB093FF8864
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2026 13:51:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGzkd-00010a-Sp; Sun, 26 Apr 2026 09:42:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGzkA-0000LB-9S
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:41:56 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGzk7-0000Om-RG
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:41:54 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2b23fcf90b2so89113735ad.3
 for <qemu-devel@nongnu.org>; Sun, 26 Apr 2026 06:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777210910; x=1777815710; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZnjcB1gBfeizDNAfTlBZ6J0qkaFcfzSBWKWwURL1leo=;
 b=Sn6X45fdavGrS8+K0nmPRXsb/mNKnQ/zvdZGJ6ATLou3EJyMaBcFoyVJNCRKvCz8sB
 Ov2YIVJGlqW47CGd9V37pi2oxmPD+KJnkOTcaiLJWCmhnnn/x5GK+w8R0pnEeqZskpX0
 M5lIbQKraY76TTLEiW+fP9mzYYg6RLsj8fBlR7LbBb77ppgYUe70MFHSIdWM4oSyePvI
 YKUQ/DIsKYEDWh8UjECE12qpGUOIf9na03nfYk3/ZMVpk5K+31uAnFOatM/qwcRg2e4f
 2uPUH+cJFLmCfWIKS/P9EZ4lq7356BiC6Cly6SlxqRYD0jzKJxxBEBNuLSVFKKriTgmW
 +lCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777210910; x=1777815710;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZnjcB1gBfeizDNAfTlBZ6J0qkaFcfzSBWKWwURL1leo=;
 b=mxyZhIrFPQ/0xaPYvtQafIX+8jeGD22AbYzlSfeB6dlaOAi0D6MahScmX3MaUvmwgf
 iA7Sr0wZFpviZQrt0rtn2Ysro+SYEwiFt9iMhMNCEp0tSsL6B5OuKMQChi+J+rQbFuLy
 VA3k5ih4D9BW3nObltd7K98IM2DbSRb43lgd0Ny9gkmRhb4zljuQrBzhcm9xtZschFjH
 311qRsVsXhI7Bm/D9N4+Hst1HW7kQDSpRxJVw4A5yr4Kaeq+0w5UJ/QY9p1JgKz1+IFi
 9cE6b6PGmTByWQU1JVy9IkOfyFEUQbhlx9S38bPMW9amu/3UnhxUTQmPPv6KZB5nCnYm
 7c6A==
X-Gm-Message-State: AOJu0YzhPMqp2XymH4xIZKYnwCJ0aqSBuMQ3co6CZ7hYOAPOpt8JUNct
 Yzxk2HmeUXOPk4IAYBrHrFz4ZHI8orgUxpiRTY3qIhxe3dbj7CjTBqypBOF9tF6Z50aZp5rxziK
 wEe0Oo9E=
X-Gm-Gg: AeBDievgtBPV+/ze6CsCJ84PDsotxBv+fWzADfb1V+tfCt7OvU1h9XWdpFSYYdS+Q2U
 qhAqToBkOLrjgox7kh/4/x6c128AeIVSeX8ui4D5p2T7wjH9X+8qXmhcUZft62K1ikw8QbuacRp
 Gh3DBwIe8bMtA7P0VJ7Q6hePJrbdheQIsHV+p/NrcBqIg+xeyTtcvYVqGB7PrTSsFvq3wIEJwPT
 4xwEIlzxvIT83AEs+3cDd4giHEbds4hf1kMLSH1QcjIofHW+s2YolWHN1Fn9p8g17uKC63s+n/x
 8CB2bqg77qxmdeOn9sSye7D8di0wdowqxxoGPceNVEdELlQ3dQLx1jjVfPYAbRMdRF6KOq1KiD/
 Bz+PD5FNgMqIKOHr9RQShurpRmQ26b9HNZgPPKDWfs11imiUeMtapZ5F1PGC/qvWYSb8LLcgsbz
 HMm46PfnFS09VxXZ8HhJeS2KlFQ5/pyCBlO29Wffm7
X-Received: by 2002:a17:903:2acb:b0:2b4:6398:6aa2 with SMTP id
 d9443c01a7336-2b5f9f3a802mr451228705ad.27.1777210910481; 
 Sun, 26 Apr 2026 06:41:50 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab30f29sm277940375ad.68.2026.04.26.06.41.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 06:41:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	qemu-s390x@nongnu.org
Subject: [PATCH 39/84] fpu: Inline bfloat16_unpack_raw into callers
Date: Sun, 26 Apr 2026 23:39:16 +1000
Message-ID: <20260426134002.865628-40-richard.henderson@linaro.org>
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


