Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E9EEC4829C
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 20:50:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXSNT-0004un-Ny; Tue, 06 Feb 2024 15:49:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amonakov@ispras.ru>)
 id 1rXSNS-0004uE-MK
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 15:49:10 -0500
Received: from mail.ispras.ru ([83.149.199.84])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amonakov@ispras.ru>)
 id 1rXSNN-0001c5-73
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 15:49:10 -0500
Received: from localhost.intra.ispras.ru (unknown [10.10.3.121])
 by mail.ispras.ru (Postfix) with ESMTP id 07BD84076728;
 Tue,  6 Feb 2024 20:48:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 07BD84076728
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
 s=default; t=1707252521;
 bh=LKlsP9qffl5TmFXf/YIJKHAGRdE7XUamBGJVaa+posg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=k2pmwYm0+tmnjh2Wza3wmePZA+Yw2DRnQ3OVmU60RRqVfPe1nHjz8E+IuMw9cDZip
 iY5ZzwriTkhLQExaupI5D983L4TOcDx3UPyPr8Fo84YHYIkGORI7w6qwX9uONJstAf
 R7hVf2W8c8+MC8XJaPHbshXkv8svzsdp1Fjj/0DM=
From: Alexander Monakov <amonakov@ispras.ru>
To: qemu-devel@nongnu.org
Cc: Mikhail Romanov <mmromanov@ispras.ru>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexander Monakov <amonakov@ispras.ru>
Subject: [PATCH v3 3/6] util/bufferiszero: remove AVX512 variant
Date: Tue,  6 Feb 2024 23:48:06 +0300
Message-Id: <20240206204809.9859-4-amonakov@ispras.ru>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20240206204809.9859-1-amonakov@ispras.ru>
References: <20240206204809.9859-1-amonakov@ispras.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=83.149.199.84; envelope-from=amonakov@ispras.ru;
 helo=mail.ispras.ru
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Thanks to early checks in the inline buffer_is_zero wrapper, the SIMD
routines are invoked much more rarely in normal use when most buffers
are non-zero. This makes use of AVX512 unprofitable, as it incurs extra
frequency and voltage transition periods during which the CPU operates
at reduced performance, as described in
https://travisdowns.github.io/blog/2020/01/17/avxfreq1.html

Signed-off-by: Mikhail Romanov <mmromanov@ispras.ru>
Signed-off-by: Alexander Monakov <amonakov@ispras.ru>
---
 util/bufferiszero.c | 36 ++----------------------------------
 1 file changed, 2 insertions(+), 34 deletions(-)

diff --git a/util/bufferiszero.c b/util/bufferiszero.c
index 01050694a6..c037d11d04 100644
--- a/util/bufferiszero.c
+++ b/util/bufferiszero.c
@@ -64,7 +64,7 @@ buffer_is_zero_len_4_plus(const void *buf, size_t len)
     }
 }
 
-#if defined(CONFIG_AVX512F_OPT) || defined(CONFIG_AVX2_OPT) || defined(__SSE2__)
+#if defined(CONFIG_AVX2_OPT) || defined(__SSE2__)
 #include <immintrin.h>
 
 /* Note that each of these vectorized functions require len >= 64.  */
@@ -128,35 +128,6 @@ buffer_zero_avx2(const void *buf, size_t len)
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
 static unsigned __attribute__((noinline))
 select_accel_cpuinfo(unsigned info)
 {
@@ -165,9 +136,6 @@ select_accel_cpuinfo(unsigned info)
         unsigned bit;
         bool (*fn)(const void *, size_t);
     } all[] = {
-#ifdef CONFIG_AVX512F_OPT
-        { CPUINFO_AVX512F, buffer_zero_avx512 },
-#endif
 #ifdef CONFIG_AVX2_OPT
         { CPUINFO_AVX2,    buffer_zero_avx2 },
 #endif
@@ -191,7 +159,7 @@ static unsigned used_accel
     = 0;
 #endif
 
-#if defined(CONFIG_AVX512F_OPT) || defined(CONFIG_AVX2_OPT)
+#if defined(CONFIG_AVX2_OPT)
 static void __attribute__((constructor)) init_accel(void)
 {
     used_accel = select_accel_cpuinfo(cpuinfo_init());
-- 
2.32.0


