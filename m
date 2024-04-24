Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DC95C19F4E
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 22:58:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzlYA-0005Nz-PH; Wed, 24 Apr 2024 18:57:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzlY8-0005N7-SG
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 18:57:12 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzlY6-0001lm-OJ
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 18:57:12 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6ee12766586so385432b3a.0
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 15:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713999429; x=1714604229; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sc6Au+pExfgVbkEVt3xBcrgjk6DJCZWLxXzjjgNJTcI=;
 b=EkzqbIs1QpxUNxSBX+DIvfTyj+AW5b4wyB5AC9aCD+AGm5Vq7uFtpaY8ymDmZPISxH
 n//9vISUaPvSMyOpYXqkbHRDun4+7yi9DYLRGFGVtWABhmxDaJkY1wuwF1LXt5HgJfGu
 eDRUnLIOR45pohQwwSYrXozAMmuONGbRGllZWpQWYOaoq765AqeXm1S9OzRT4VDXi3GR
 M6rG/o1xxE6n8gGyLSY40O+MEbTg4LHHfOxQsyda7y0pzPGEU+auVrcB1uw5DzDOqYum
 nhAFXrqbcYGeslDTwJssCbc23VLel/ekXN8Di440eAhAykxfsdUk7FE3Z1bjA/ptrKkp
 edHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713999429; x=1714604229;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Sc6Au+pExfgVbkEVt3xBcrgjk6DJCZWLxXzjjgNJTcI=;
 b=rcWd4j2FbHdGj7UdoqgxkRwoyFzqk5YeppuhnmFQxC0lo5r8kOtEVDHgjQcYT6QLgz
 1RRuD7NK/q8mHZ1u1LwuAWU9wVp2AfdiX2DZ+WRtoiiL+xK+yhjcsAPVrwE2/nXDxjo4
 HoOhknOTdfZw8IWmS7e29yimDH8fkr+HjcTF/DtkFjEyi4ke9/IQ+6ngfOpJioRxYEQk
 sVGgDmLPZSaFPyK4xaYaBidncijrOouSwV9CieVDelBGjYUk20Qc1nvNLG5Kqe0cV4qr
 HO+rb5Z09PgrZ7AmRTvz9eJQZ9aRhR5g45Zi4CnP4pdK79fuUXwpIeUAmSTh4mND0GCS
 YHUg==
X-Gm-Message-State: AOJu0YzYUji6IUNVfk6Iu71wvdfLmh2jP+SkzqOspMYuCFvf05jGiru5
 iseVSKKUpfB0VpwAHFPmueOcKD3ohP7CoefKzHfyfRBkd6LtaXkXDQIhpzoNNC2ZCssxTrZI3lN
 u
X-Google-Smtp-Source: AGHT+IFLBzYIDC1Hh+Yfw7GnuEfavofisMs3ySrEbM8/J8fY4dJnY990TOpYLTLIsaSWcwW+GjlULA==
X-Received: by 2002:a05:6a00:992:b0:6ea:f3fb:26fe with SMTP id
 u18-20020a056a00099200b006eaf3fb26femr1698891pfg.12.1713999429116; 
 Wed, 24 Apr 2024 15:57:09 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 gu26-20020a056a004e5a00b006ed9760b815sm11947413pfb.211.2024.04.24.15.57.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 15:57:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Monakov <amonakov@ispras.ru>,
 Mikhail Romanov <mmromanov@ispras.ru>
Subject: [PATCH v6 02/10] util/bufferiszero: Remove AVX512 variant
Date: Wed, 24 Apr 2024 15:56:57 -0700
Message-Id: <20240424225705.929812-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424225705.929812-1-richard.henderson@linaro.org>
References: <20240424225705.929812-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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


