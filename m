Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36571C67861
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 17:55:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtt8N-00027K-0O; Mon, 08 Apr 2024 13:50:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rtt8M-00027B-BU
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 13:50:18 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rtt8J-0003k4-EJ
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 13:50:18 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-5e4613f2b56so3665145a12.1
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 10:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712598614; x=1713203414; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r70v09Z1jYUdUmudZIEve8pIi40latYcxErAtIALfYA=;
 b=wrA720sPrA8Nm+OQoSIqkjj9BW8Hgk8o3vq4sjrYWHqth0Ucp7DXEL/6QaDY4x2x00
 Qzj68v95fcVY3h/Fz9bs16FogQlmb7lGIzMNe/T53qjc5I8NW8ETnfp+TtIb6RVbbCo9
 GOwVjOJTht3gtMwUgCImHCRxpQhmN8/nk7rzBSgV619Wcg9+CFlVsfgklgwwfr7U01OY
 x+tYqK21NkwSmh3SaEsai6O5lqEDOWnradH/W6XdDz1yonnE1jNGPp2FJJbjNDDaJ2dl
 RtcoxZVyFaLytocQ4xguXj8MKg/lBzGxE6RYS7JNIzqZhvwsiJkszfj8QfmHGso6QURP
 RQ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712598614; x=1713203414;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r70v09Z1jYUdUmudZIEve8pIi40latYcxErAtIALfYA=;
 b=OxAEHIKoYt9/9am5W6Dqe654NM00q1DETauFvuRgS3t3riCIlIoTqXU3BgsFkmjLMK
 9XppxTs+RqB0K01DHj/CdjfL3Daty+nYx3u+dY/eiInoQAF5QTbAhK+g2L8rhzbsJsmh
 RnGqo1fB69BUqu8PiCpmJNtVR4FeWeuete4/Zu3S/p1cfq0BNhP3xsC/GhMwxutBYVj6
 mIScrPphb2RFp+rSrievR+bEE5YFeGS1VhMJeOH1/kGF8Cm1D6tCFUZVtghiU/pTOmXy
 Mp+fcELwqEH4nWFomHXGiwRumQf+sol/HpbwJgWh5eb9SyfoCybL/gM2gv+jMQzwdPf8
 dYhw==
X-Gm-Message-State: AOJu0Yy/Fpk2Y7BReynK29dq7k3CHnHX/WMS3phrhNvI0J3y14UemJSb
 z7+yqjJCQoRyB65+Kt6rxTXkOvwat5kWKIM3LsmHk9n7RhMk7C1NOV56IWLFZnYKu5YBACn1Kug
 F
X-Google-Smtp-Source: AGHT+IE80lerOFer8W/g3BtOG55khwBtNttI6YF0ABRTth2WipfaIEoACLdRRtcktw5n+RSlePjXbQ==
X-Received: by 2002:a17:90b:1bcc:b0:2a0:2fb3:c1ff with SMTP id
 oa12-20020a17090b1bcc00b002a02fb3c1ffmr7520545pjb.15.1712598613747; 
 Mon, 08 Apr 2024 10:50:13 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 ga15-20020a17090b038f00b0029c3bac0aa8sm8658432pjb.4.2024.04.08.10.50.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 10:50:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Monakov <amonakov@ispras.ru>,
 Mikhail Romanov <mmromanov@ispras.ru>
Subject: [PULL 28/35] util/bufferiszero: Remove SSE4.1 variant
Date: Mon,  8 Apr 2024 07:49:22 -1000
Message-Id: <20240408174929.862917-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240408174929.862917-1-richard.henderson@linaro.org>
References: <20240408174929.862917-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
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


