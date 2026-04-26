Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 154E1FF885C
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2026 13:43:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGzjV-0007Wd-C2; Sun, 26 Apr 2026 09:41:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGzjT-0007Vu-Tn
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:41:11 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGzjS-00007Y-Cn
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:41:11 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2b23fcf90b2so89111435ad.3
 for <qemu-devel@nongnu.org>; Sun, 26 Apr 2026 06:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777210869; x=1777815669; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XzT/OaqiqzvC/zGQFWIpYrmJeDiwDoDU3OyHh9kylyQ=;
 b=RzvZuDVagZU2MjvpoGlOICP4WGxrs8JvqJ3YravGN4BZnM49nGDVgYtUpJ7XUs7BIz
 Q6xPhdJd1QAMuP/IrGaOG2SiP76dVzXBGVTXUlRKd6JgPHtDtB5d9AF+Y4rnkw/QEnHX
 vy7GRznI6pHYFY1tfC5wg7B4mHe7xUTxx1zFX2ydAID1Gg+D0vkpnOvJRuLEhxXHNFGv
 eqdUbs7CsNvf8YcfOJT+cSZ1oOc6IJzEdnPRtdxNDVGfAr5LhrlXczjmWjYgd+hQH2Ha
 njD8Ez7cExqs3OzTjBUu0/K5oCraZ22RGyjkAh2AGk9oi1a2NrIhT9nZjDLlRfjN6s0E
 bPbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777210869; x=1777815669;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XzT/OaqiqzvC/zGQFWIpYrmJeDiwDoDU3OyHh9kylyQ=;
 b=h3H3TtkkLTIfwg6hX9ErRo//Knp1XFGr0TYNuX6VW8aFAMBLmuB6/F8tsPb2xdNLC7
 KcujXaWQUnET7s6Csc2hq6DTmBWr18VPcP8BNqC/PURmhQywCuXi2t50zxb4P+alEs4d
 gN5kYNk36OSxxkc+AdA0xpPqC0ri4p1Okq6WfnuvDcsLbuHtCYkug9t9IW2LLo9yuZNP
 8cmSEgz8+WH13guD/1BmP0nCq3dPKDokRcDs5zNoWzxRuHKWnDfU4MZZFUPSJgfq7th9
 gwn8dOO3STSF+mvqLo1jyDCQNomxP660EPjgCUsqZHtVx9NBkfwAloQC9siGcBgWpe3u
 664g==
X-Gm-Message-State: AOJu0YzmkF4O7lo5EBN3UwPo93lGpp68U3FfwGBYM7tRg0idTyOZzM3u
 IzodIvFRx+/QAo3v1UUQg+Bn5jjboFecK6u9XH/6zTLmjtyy0clIhD714MK53M/r0fry+4Mn0A5
 sVebhk9Q=
X-Gm-Gg: AeBDieuYnul5Ppd5lZ+NdDmRxl+Jzew0fgjSUGtl8ryARDTJxHazbBJ+byVlRauE8dv
 BHLisXCCIJ7JgJOXePdw5Jsg5MZh35csF3tSRDQuH4wHHw/iSfiUhfQMfOa5U9Vx91jPYhMzFVW
 7l8Rdv0tHGFCCZSPmEZlbvCfLQaPus4nDCGZRhgRV5G06S/oSSjU7LmN9D/JlK73xFOMEVFxAZK
 qrPubxCIC3ie1NrlVxVrlO5lP4dhkO1MMsqp0QrGg0DidthyVGOaKsiEhYutRYhteFlo+MTJNOt
 dC/6UlzLCSFBlFPWFPJdZ6vcYtK2gvaS8+EOvNzLRSEBHSxd4SJJnTxpQgjSacaHZoIC2fOJ3d+
 /PGgb44y75TMa8b923Y/C0k/abIxWpRMOkh7i2b4KqXJA1vg2hHqlRFHDpS1Ar8CT2GmqzOmDRy
 trD2KYs5eQxghebiRdopZAD6i4rwHiiDTlvz1Qhwrs
X-Received: by 2002:a17:902:d652:b0:2b4:62bd:ee3 with SMTP id
 d9443c01a7336-2b5f9f5eac7mr314754395ad.33.1777210869069; 
 Sun, 26 Apr 2026 06:41:09 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab30f29sm277940375ad.68.2026.04.26.06.41.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 06:41:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	qemu-s390x@nongnu.org
Subject: [PATCH 23/84] fpu: Drop parts_uint_to_float
Date: Sun, 26 Apr 2026 23:39:00 +1000
Message-ID: <20260426134002.865628-24-richard.henderson@linaro.org>
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

Use parts{64,128}_uint_to_float at each call site.

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


