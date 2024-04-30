Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB0CDC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 19:43:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1tNc-00074h-AQ; Tue, 30 Apr 2024 15:43:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1tNa-000748-Db
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 15:43:06 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1tNS-0006kF-H7
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 15:43:06 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6f2f6142d64so5787622b3a.2
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 12:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714506177; x=1715110977; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sc6Au+pExfgVbkEVt3xBcrgjk6DJCZWLxXzjjgNJTcI=;
 b=Vvy3pkQD0rOsLiPZ03NwS5xQlZXHbhUAYCehCdY+hl5eCD7sfyYJlO8aPngZYr1ThH
 oVN8CPXC9rAXbX2HQwDVqTR5GpB8vjBDOCBfQxPmMxdJd4/xWNGhaa/7mdWE2gDNWfuV
 meKh8xr2G8OkmdazYVbm8pOsmoM5CHaYlZGOmg5Lh9+XKy/PW9sMUSoR7ZcgpkGQ3m30
 MpXPTADjx+yp60XBf2hGMsrlQOhemEJG3Qnicy6Z+tPsRduQWFtNqT4vqgeMlhkhGZkQ
 B5pmfpeMxZfwx6waJsUx2ZUO3QAeb+xUVfOpr78NWi2S3tXpCtcdyf3e6YeaQ7nkgVs3
 bKEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714506177; x=1715110977;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Sc6Au+pExfgVbkEVt3xBcrgjk6DJCZWLxXzjjgNJTcI=;
 b=BXT28Xh4NvfQkL51eCSXqW5eib5seMk+DM+u/fsoVov8GYBtwuAZ3Jqs8RGLcbFGVc
 ivVha2VrlmCxZQNTsMoUKswWOxBYueOpmhhqiL8c6YtmtH0q8MOi0alJbyTxVd39n6WT
 qgXt45jto8104B8c4izBPUSmz1RmNo7dNzrvn+XS1+jx2XRubhjzzzXJxe82FVuHzWx2
 D+W0R/iVC+3AvOn2SP8skZ1sgpPzrIWIzto1oL98+CaQMZNvbCjexlqqc12BEJh6q9dY
 RPffHElYdVmO3wrFKybktU2J6qBKUC+Z2OCw81mC86OafpwL6Ku4kMlw8KG4wpxew4Oz
 YN9w==
X-Gm-Message-State: AOJu0YxLZ90zmo87hqxnUloaczETsx82iBvstAzkfUtasW4zIwJTeQDu
 6HHdL3oqgogoS4lR6rdOClzP67ZLHqgfL66fGbO6MNycD94yLrS5v9j7o70SSEBUU9ferFL/EUT
 h
X-Google-Smtp-Source: AGHT+IHWCq9P+SydQkJ9MSEOUWxRtfrnC9c7ZnIFzOuFWACJx/c3Qn9QFWeMfyqEe5rNBP27zdgYog==
X-Received: by 2002:a05:6a20:1fa5:b0:1a7:aa08:16de with SMTP id
 dm37-20020a056a201fa500b001a7aa0816demr697768pzb.40.1714506177058; 
 Tue, 30 Apr 2024 12:42:57 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d12-20020a63360c000000b005d880b41598sm20861523pga.94.2024.04.30.12.42.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 12:42:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, Alexander Monakov <amonakov@ispras.ru>,
 Mikhail Romanov <mmromanov@ispras.ru>
Subject: [PATCH v7 02/10] util/bufferiszero: Remove AVX512 variant
Date: Tue, 30 Apr 2024 12:42:45 -0700
Message-Id: <20240430194253.904768-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240430194253.904768-1-richard.henderson@linaro.org>
References: <20240430194253.904768-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

Thanks to early checks in the inline buffer_is_zero wrapper, the SIMD
routines are invoked much more rarely in normal use when most buffers
are non-zero. This makes use of AVX512 unprofitable, as it incurs extra
frequency and voltage transition periods during which the CPU operates
at reduced performance, as described in
https://travisdowns.github.io/blog/2020/01/17/avxfreq1.html

Signed-off-by: Mikhail Romanov <mmromanov@ispras.ru>
Signed-off-by: Alexander Monakov <amonakov@ispras.ru>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240206204809.9859-4-amonakov@ispras.ru>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 util/bufferiszero.c | 38 +++-----------------------------------
 1 file changed, 3 insertions(+), 35 deletions(-)

diff --git a/util/bufferiszero.c b/util/bufferiszero.c
index f5a3634f9a..641d5f9b9e 100644
--- a/util/bufferiszero.c
+++ b/util/bufferiszero.c
@@ -64,7 +64,7 @@ buffer_zero_int(const void *buf, size_t len)
     }
 }
 
-#if defined(CONFIG_AVX512F_OPT) || defined(CONFIG_AVX2_OPT) || defined(__SSE2__)
+#if defined(CONFIG_AVX2_OPT) || defined(__SSE2__)
 #include <immintrin.h>
 
 /* Note that each of these vectorized functions require len >= 64.  */
@@ -128,41 +128,12 @@ buffer_zero_avx2(const void *buf, size_t len)
 }
 #endif /* CONFIG_AVX2_OPT */
 
-#ifdef CONFIG_AVX512F_OPT
-static bool __attribute__((target("avx512f")))
-buffer_zero_avx512(const void *buf, size_t len)
-{
-    /* Begin with an unaligned head of 64 bytes.  */
-    __m512i t = _mm512_loadu_si512(buf);
-    __m512i *p = (__m512i *)(((uintptr_t)buf + 5 * 64) & -64);
-    __m512i *e = (__m512i *)(((uintptr_t)buf + len) & -64);
-
-    /* Loop over 64-byte aligned blocks of 256.  */
-    while (p <= e) {
-        __builtin_prefetch(p);
-        if (unlikely(_mm512_test_epi64_mask(t, t))) {
-            return false;
-        }
-        t = p[-4] | p[-3] | p[-2] | p[-1];
-        p += 4;
-    }
-
-    t |= _mm512_loadu_si512(buf + len - 4 * 64);
-    t |= _mm512_loadu_si512(buf + len - 3 * 64);
-    t |= _mm512_loadu_si512(buf + len - 2 * 64);
-    t |= _mm512_loadu_si512(buf + len - 1 * 64);
-
-    return !_mm512_test_epi64_mask(t, t);
-
-}
-#endif /* CONFIG_AVX512F_OPT */
-
 /*
  * Make sure that these variables are appropriately initialized when
  * SSE2 is enabled on the compiler command-line, but the compiler is
  * too old to support CONFIG_AVX2_OPT.
  */
-#if defined(CONFIG_AVX512F_OPT) || defined(CONFIG_AVX2_OPT)
+#if defined(CONFIG_AVX2_OPT)
 # define INIT_USED     0
 # define INIT_LENGTH   0
 # define INIT_ACCEL    buffer_zero_int
@@ -188,9 +159,6 @@ select_accel_cpuinfo(unsigned info)
         unsigned len;
         bool (*fn)(const void *, size_t);
     } all[] = {
-#ifdef CONFIG_AVX512F_OPT
-        { CPUINFO_AVX512F, 256, buffer_zero_avx512 },
-#endif
 #ifdef CONFIG_AVX2_OPT
         { CPUINFO_AVX2,    128, buffer_zero_avx2 },
 #endif
@@ -208,7 +176,7 @@ select_accel_cpuinfo(unsigned info)
     return 0;
 }
 
-#if defined(CONFIG_AVX512F_OPT) || defined(CONFIG_AVX2_OPT)
+#if defined(CONFIG_AVX2_OPT)
 static void __attribute__((constructor)) init_accel(void)
 {
     used_accel = select_accel_cpuinfo(cpuinfo_init());
-- 
2.34.1


