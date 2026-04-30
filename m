Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 745FEFF887E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 00:06:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIEuS-00066x-Hb; Wed, 29 Apr 2026 20:05:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIEuQ-00064n-Ua
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:05:38 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIEuP-0001iQ-F5
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:05:38 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-82f9fdfc965so169855b3a.1
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 17:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777507536; x=1778112336; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R6nFkQ6KIlNZ8kekfBTy8MBT9tZYGdlcL2ADdOiZc9I=;
 b=Rk01/gs1I+fm598V/rVDHNyiGEo31l9QpTifyEpE2U6a4Kv40uKFb6KaFbwrNF7wbt
 B1wCHJVuWjuEthXaRwAOtVMLr4ExHTQJjHdG/axy3qAielvtZIBQqed3jxxn/t0c/7D9
 +m2tTMIxqi7WCqyWb1E9EcWM8bMqNJ/KPAuE7Lg2OAkuzwdOGPTXjWULQnfcsm6I+YHV
 IHTEIu3SNgnzBej9Qh5HPfE/RDZYL5iIhhcCvTnxt1gSd/eHaIxqDOaTYoAvTDWY2U/Q
 ODJVcYbakhyU7Gfk9cDaVm/e7DlbuSQ6DvVujW1LNuj9gi71Y4njNLG6WFJv2rHUei7S
 CdIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777507536; x=1778112336;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=R6nFkQ6KIlNZ8kekfBTy8MBT9tZYGdlcL2ADdOiZc9I=;
 b=IpKFt4MdWdbP4QbPb64/0OF5PJrqjZ+BWSWpyzVmWsSGpNnM4gqxky3fT7soctnmHX
 Y3Dy8G3gsv4UO8V2pXxWb0/opiBhmRJQYmy4FuBll19Yy7RPJbQlftjSC5QYv+eGzIlW
 xZLH8iUUDWtSTY4HaXKV7AQsqnYC89qg/l03pbCs55ncuzLHrTjU88k3NSphl5qPEkC6
 RNeZQCyT298lJzjBJxH+yLjdf65ntLm74QW+Z6CcGMFBlUiGLAflhEUm23FMApS1d5hA
 N6vCtg3PXulsFMKJqiJI9/AAFEYeEV+DdEUfeS68uRpeNjjz6e0ZXFoD+97jCvWtylC9
 gtWQ==
X-Gm-Message-State: AOJu0YzoL0aN4ctWM15XAaoOBt631KndMDEOc0OQT8P2NohLQJwrT5jk
 3c0P296xKxG6R5gGv/4JEuk8fQjQ7hgxFUY1OvupQgQUXDd40QmrfqEvCYSAyKKdVx1tH1Pn9Zf
 JUj9x2yI=
X-Gm-Gg: AeBDiesKk1L2eestAJLe/bCW4B29ZBQd5IyTEZNZSAQiP8qs6/n6udvv5AMsnv+Id1/
 Yf6W60gzj+kgXrV8eafTZv+cZ+2bn3+as0zniT+HRq82c2tokGxvDJU4Guxtd4V71ypBFslWUB7
 D271aU+8sxC2qdMgIIWKfKs+9oi1h3ZdYE4oI67GL8QlwnMBC7ettkW9KXqiD2as1cgbb8SPNSC
 2kkSIta5qD2YCent0JZDU+QnHEtkasQapPAPSG7U043OueJkNbKdoUUD+25MdzoPpbktHIzKgfo
 XhbJCTZIj4KTdUUezU1ociIc9y7ME0MkIAWa3PkJE9B65svtr4TpBZm8f1jSF/I+gxv3vPXZaI2
 V6pMNhc1nkbNjaVT9FFpd0ItH4kzuYwvPwFT/hl7IbVKmeLd+G5iaO+48kRYoIpE/UBlYsSh2xs
 0+kwefNwOzxwt3XSyI0hkZHnhpPifvGggB+tL4C4oIBAo/W0VPfAo=
X-Received: by 2002:a05:6a00:851:b0:82c:e09b:3f76 with SMTP id
 d2e1a72fcca58-834fe238900mr656975b3a.41.1777507535956; 
 Wed, 29 Apr 2026 17:05:35 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-834ed7ef7a8sm2928667b3a.47.2026.04.29.17.05.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 17:05:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH v2 03/40] fpu: Inline float16_pack_raw into callers
Date: Thu, 30 Apr 2026 10:04:46 +1000
Message-ID: <20260430000524.56046-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430000524.56046-1-richard.henderson@linaro.org>
References: <20260430000524.56046-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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
 fpu/softfloat.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 5269e5f977..8cfe7f8f4b 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -673,11 +673,6 @@ static uint64_t pack_raw64(const FloatParts64 *p, const FloatFmt *fmt)
     return ret;
 }
 
-static float16 QEMU_FLATTEN float16_pack_raw(const FloatParts64 *p)
-{
-    return make_float16(pack_raw64(p, &float16_params));
-}
-
 static bfloat16 QEMU_FLATTEN bfloat16_pack_raw(const FloatParts64 *p)
 {
     return pack_raw64(p, &bfloat16_params);
@@ -1480,7 +1475,7 @@ static float16 float16a_round_pack_canonical(FloatParts64 *p,
                                              const FloatFmt *params)
 {
     parts64_uncanon(p, s, params, false);
-    return float16_pack_raw(p);
+    return pack_raw64(p, &float16_params);
 }
 
 static float16 float16_round_pack_canonical(FloatParts64 *p,
@@ -2022,7 +2017,7 @@ float16_muladd_scalbn(float16 a, float16 b, float16 c,
     if ((flags & float_muladd_negate_result) && !is_nan(pr->cls)) {
         pr->sign ^= 1;
     }
-    return float16_pack_raw(pr);
+    return pack_raw64(pr, &float16_params);
 }
 
 float16 float16_muladd(float16 a, float16 b, float16 c,
@@ -4722,7 +4717,7 @@ float16 float16_default_nan(float_status *status)
 
     parts64_default_nan(&p, status);
     p.frac >>= float16_params.frac_shift;
-    return float16_pack_raw(&p);
+    return pack_raw64(&p, &float16_params);
 }
 
 float32 float32_default_nan(float_status *status)
@@ -4772,7 +4767,7 @@ float16 float16_silence_nan(float16 a, float_status *status)
     p.frac <<= float16_params.frac_shift;
     parts64_silence_nan(&p, status);
     p.frac >>= float16_params.frac_shift;
-    return float16_pack_raw(&p);
+    return pack_raw64(&p, &float16_params);
 }
 
 float32 float32_silence_nan(float32 a, float_status *status)
-- 
2.43.0


