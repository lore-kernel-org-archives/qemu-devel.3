Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5B07C10F16
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 15:14:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2ubF-0005jm-Ij; Fri, 03 May 2024 11:13:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2ubB-0005iq-2B
 for qemu-devel@nongnu.org; Fri, 03 May 2024 11:13:21 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2ub9-000751-EJ
 for qemu-devel@nongnu.org; Fri, 03 May 2024 11:13:20 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1e83a2a4f2cso62324865ad.1
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 08:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714749197; x=1715353997; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r70v09Z1jYUdUmudZIEve8pIi40latYcxErAtIALfYA=;
 b=bCX45hanuh12xfSLrREoVERgPPhNpoxZMbUqFy1RjeusOE+hfgBys0ykkIeqOPuUNF
 sWv6bTo87iXZawMPoTM8ELlZgtmQ7QyWs/WEH1acmfvYj1yBg/wqv3DcbFQ9PUUx4MpY
 h1YvuvXbeXuq0IFOs6LU3To6WA7NNTVCbyvlsrB6d1IDRZFCQ79ZMaiBdNEeBvSVTCSq
 8xjIKHhUEzz6AqcsBHQ36pOiRGfZ4ZlPWzN2dymmq+u7xPrtXV6YEA7qsDxia6Cb9M3y
 HhUZIEYI+vHbsSF+3v/DvnIyLddGABUkve2rCgh9xn4CmIwgcRJdaByFMZmT88MuOUbl
 /P1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714749197; x=1715353997;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r70v09Z1jYUdUmudZIEve8pIi40latYcxErAtIALfYA=;
 b=WLv4AurvgYJNO7cQaM+PlcU8M0Dgef3gGAffSLvRCNw+C6uIVfPCaZQ8EL/uvROc3h
 5vlxU8fJSs1dmlaxSLrid3+LQoB3PuI0i65BCMecTpSHnwSfpUZzxzkJTPRHZnWvrVYv
 DpI0NOsMvRK/veo3RGvCqLeLVb/N80ThZnPib3RZrY8v4AZZ5xWrc/TFpc8DVjF9OH9F
 e/gVZMOQMLkPNTbusiGEBz3mMa0qR2gB7/s6lFRXaHTy6PHyANIMmqrIcaymAB0FhEhF
 asyuuTCFnu6wVTt29LtGnF5mgtd7Swdux0c2PvyqiohGZ3+UFPVMCbcZ2M8F2T2sNnDO
 oqFg==
X-Gm-Message-State: AOJu0Yxr15UuRBxq3PobhTsZ9iRj1r1YMbnz1gdrNsokYM06E+3joqw/
 mNV4N+dIBiMOGHX7RwzUGtxM0en04hsLXUHidyttbS2fpvUXSgt+woD1InmmhbC/2XGlNVmxznD
 t
X-Google-Smtp-Source: AGHT+IExqUZaPArOxYMq0yy0LKMYSdD905BB1iK6eKbvKItYIIqokf6ucQMJYh+SSJZjQbNfYhX+Sw==
X-Received: by 2002:a17:902:82c8:b0:1ea:b3ba:79f5 with SMTP id
 u8-20020a17090282c800b001eab3ba79f5mr2767694plz.60.1714749197283; 
 Fri, 03 May 2024 08:13:17 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 p10-20020a170902c70a00b001e81c778784sm3366611plp.67.2024.05.03.08.13.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 May 2024 08:13:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Monakov <amonakov@ispras.ru>,
 Mikhail Romanov <mmromanov@ispras.ru>
Subject: [PULL 01/10] util/bufferiszero: Remove SSE4.1 variant
Date: Fri,  3 May 2024 08:13:05 -0700
Message-Id: <20240503151314.336357-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240503151314.336357-1-richard.henderson@linaro.org>
References: <20240503151314.336357-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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


