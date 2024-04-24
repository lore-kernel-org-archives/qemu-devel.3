Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C876C19F4F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 22:58:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzlY9-0005NZ-NS; Wed, 24 Apr 2024 18:57:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzlY7-0005Ma-Kc
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 18:57:11 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzlY5-0001lh-J0
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 18:57:11 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6f28bb6d747so384014b3a.3
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 15:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713999428; x=1714604228; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r70v09Z1jYUdUmudZIEve8pIi40latYcxErAtIALfYA=;
 b=stAeXYE6HUEL8RLD/MH+HDjoeoEVjei5ie+KIYo7hz7GiytyMxfjHBmGsmHR/IHdmR
 Nx/FJ+u3ZBPPbAgls1UqJ9jjJ48PwLD/Wboseku0a5ZJ36EXT7V0hneUbykeVrvD5RX6
 Mqt1ZXDCjOEuXN0aLR8UaFphiNBIynuL8/dsOqka+cjbur7jOBVBgoF4zVe4lFDUpGfq
 yW4jV22bxOgroblHZyC7YeE53NVkQtq7NLJkXQV3QBegg5Yc6XVFqz9ybvAr2y05AgR2
 ohpbo+9j8q7k+ABeQgHeA83dFhn5pjOlMGEYTR9nDgkWzrfF4j825WBE5x5kGTp5QrKp
 CWew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713999428; x=1714604228;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r70v09Z1jYUdUmudZIEve8pIi40latYcxErAtIALfYA=;
 b=AdBtv3xgIqdZcSzgeeH/tLCEblIE3ARsPs5rmSZbij9+sFeIoRLfnM7UgGA60A1qCh
 SZLnb4ly0QAqHo0r1Mv1jhN71Z6C08e3xoAheTI7dUtVMKIWOc4THtDp3fQ8TToEnRpX
 vBeai8oa1TQJsQEUWMs9bIlNSS35X5Y3w+iyG2MVN7d5lI0wqAadFdkONp8PXxCCPSbx
 qb8Y7Q3WWI0uoPV1j4RKqiNTEuJYIikdaynkHX4r/M1jN6n43m3IvwEQe8SJBug5i0Ld
 PW0PrL5fh1Z5yM0xN/37mKSv+tUrAaxLO2ukSA2OYSO2+/rENd0TvDP1Zm1Aj+304BYL
 ajgQ==
X-Gm-Message-State: AOJu0YwGV1lpefwe8zr+beD93rEsK2OljKdMI8DK8QCOUAIdQq3n3+lE
 h+89OHe28SI2JymkGh/hf5fxDck55DHqKqYyEEQFlHS9/xhflqTgCJbQ7CJ/g6hZ7P8c7N08FLn
 h
X-Google-Smtp-Source: AGHT+IE305zkMtEn27kUoqeRYC6lANbTYo9246GaAwNaOpDOqaFkYtGAQtDBdiq9g2ITjtRBKtdBmA==
X-Received: by 2002:a05:6a00:893:b0:6ed:caf6:6e54 with SMTP id
 q19-20020a056a00089300b006edcaf66e54mr4665877pfj.28.1713999428081; 
 Wed, 24 Apr 2024 15:57:08 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 gu26-20020a056a004e5a00b006ed9760b815sm11947413pfb.211.2024.04.24.15.57.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 15:57:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Monakov <amonakov@ispras.ru>,
 Mikhail Romanov <mmromanov@ispras.ru>
Subject: [PATCH v6 01/10] util/bufferiszero: Remove SSE4.1 variant
Date: Wed, 24 Apr 2024 15:56:56 -0700
Message-Id: <20240424225705.929812-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424225705.929812-1-richard.henderson@linaro.org>
References: <20240424225705.929812-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Alexander Monakov <amonakov@ispras.ru>

The SSE4.1 variant is virtually identical to the SSE2 variant, except
for using 'PTEST+JNZ' in place of 'PCMPEQB+PMOVMSKB+CMP+JNE' for testing
if an SSE register is all zeroes. The PTEST instruction decodes to two
uops, so it can be handled only by the complex decoder, and since
CMP+JNE are macro-fused, both sequences decode to three uops. The uops
comprising the PTEST instruction dispatch to p0 and p5 on Intel CPUs, so
PCMPEQB+PMOVMSKB is comparatively more flexible from dispatch
standpoint.

Hence, the use of PTEST brings no benefit from throughput standpoint.
Its latency is not important, since it feeds only a conditional jump,
which terminates the dependency chain.

I never observed PTEST variants to be faster on real hardware.

Signed-off-by: Alexander Monakov <amonakov@ispras.ru>
Signed-off-by: Mikhail Romanov <mmromanov@ispras.ru>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240206204809.9859-2-amonakov@ispras.ru>
---
 util/bufferiszero.c | 29 -----------------------------
 1 file changed, 29 deletions(-)

diff --git a/util/bufferiszero.c b/util/bufferiszero.c
index 3e6a5dfd63..f5a3634f9a 100644
--- a/util/bufferiszero.c
+++ b/util/bufferiszero.c
@@ -100,34 +100,6 @@ buffer_zero_sse2(const void *buf, size_t len)
 }
 
 #ifdef CONFIG_AVX2_OPT
-static bool __attribute__((target("sse4")))
-buffer_zero_sse4(const void *buf, size_t len)
-{
-    __m128i t = _mm_loadu_si128(buf);
-    __m128i *p = (__m128i *)(((uintptr_t)buf + 5 * 16) & -16);
-    __m128i *e = (__m128i *)(((uintptr_t)buf + len) & -16);
-
-    /* Loop over 16-byte aligned blocks of 64.  */
-    while (likely(p <= e)) {
-        __builtin_prefetch(p);
-        if (unlikely(!_mm_testz_si128(t, t))) {
-            return false;
-        }
-        t = p[-4] | p[-3] | p[-2] | p[-1];
-        p += 4;
-    }
-
-    /* Finish the aligned tail.  */
-    t |= e[-3];
-    t |= e[-2];
-    t |= e[-1];
-
-    /* Finish the unaligned tail.  */
-    t |= _mm_loadu_si128(buf + len - 16);
-
-    return _mm_testz_si128(t, t);
-}
-
 static bool __attribute__((target("avx2")))
 buffer_zero_avx2(const void *buf, size_t len)
 {
@@ -221,7 +193,6 @@ select_accel_cpuinfo(unsigned info)
 #endif
 #ifdef CONFIG_AVX2_OPT
         { CPUINFO_AVX2,    128, buffer_zero_avx2 },
-        { CPUINFO_SSE4,     64, buffer_zero_sse4 },
 #endif
         { CPUINFO_SSE2,     64, buffer_zero_sse2 },
         { CPUINFO_ALWAYS,    0, buffer_zero_int },
-- 
2.34.1


