Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C986EC48260
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Feb 2024 00:41:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rb8jp-00064g-6t; Fri, 16 Feb 2024 19:39:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rb8jn-00063x-Ld
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 19:39:27 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rb8jl-0008FM-E0
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 19:39:27 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1d953fa3286so11474115ad.2
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 16:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708130364; x=1708735164; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sc6Au+pExfgVbkEVt3xBcrgjk6DJCZWLxXzjjgNJTcI=;
 b=PsmPtOjwIOUa0GBrFYzxy0RmwnLHQaK2UN5QIV+4QaMnBXDFOaDouihhHYDvn7UOBz
 8plMNwvieI+/46Qlpa/Fe3Ag6drshE94ewgH1ofo9rCLiEQpb3N7j/2M7+xQr05711UA
 jSCSouLYdwviT2LJ+DdL7WLJnF8vwkb6C/+dhLWZYjIRpizrLJpmj/+jEgw6oCvKPpcq
 O4pNb1grhHkgknhyO/UEb9lqCCe6WX0/cTOrhssC4FdgR/biIXDg0YJo100NVY+0W3IY
 K+P5usF6ROlgUiEoLLUdUCEXbk2a5yX9++rvxwLYaQ3QVrB+LupMvIVBf8+9VQmj1uyM
 +alA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708130364; x=1708735164;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Sc6Au+pExfgVbkEVt3xBcrgjk6DJCZWLxXzjjgNJTcI=;
 b=bXUUKA4duaW/mJQU9j8kjX3JUy9zqTI/lwhAYX73CkiwvGOjHmXXA6su5e2ftDBoKf
 BIqvViCv69RD42ahSWBhAOGtdTXKhWMIdQ4+tS09o45jWN6aNBGH0cqUZseQzYPTXCS8
 gazNcdIln4dvdj8rUGOy3ZQ2vpMx+31fNUm9KXozD4kYlepyxhajZ9bwbWxa/V+4Hx2S
 VIXXNu6qi860Pli3RsFFijgfAGnhGPFI8VumP2voMTPrMlrpdMQDSkP5l3rJUTBS1v0c
 TZZvJ5GaqTEt3xT090itXjs74bBSqWfow31TcGABNhvlvAmNp7sLGupvH+kMf/rImVaU
 IqJg==
X-Gm-Message-State: AOJu0YwvGTOuQn6DBpbGqIr+rhrR8x2ltfd79h5eYGnJGu8arwuOC1gH
 ys89fkenr3U8LT8fMHaqIXKDoMJDXvnLRW5HTQz4hiiSbxRySRq+ZYr5u0NZyilrdV/AgQqSgXT
 U
X-Google-Smtp-Source: AGHT+IG1AmesixUhiBnFqyjHYCaE+eS5O+wbqGBgQr5+SruQfatd+CsAvt7bpmlhedY2ZU3+/lywsw==
X-Received: by 2002:a17:902:c944:b0:1db:c1a3:7d59 with SMTP id
 i4-20020a170902c94400b001dbc1a37d59mr1228054pla.9.1708130364123; 
 Fri, 16 Feb 2024 16:39:24 -0800 (PST)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 z6-20020a170902ee0600b001d90306bdcfsm419325plb.65.2024.02.16.16.39.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Feb 2024 16:39:23 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: amonakov@ispras.ru,
	mmromanov@ispras.ru
Subject: [PATCH v5 02/10] util/bufferiszero: Remove AVX512 variant
Date: Fri, 16 Feb 2024 14:39:10 -1000
Message-Id: <20240217003918.52229-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240217003918.52229-1-richard.henderson@linaro.org>
References: <20240217003918.52229-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


