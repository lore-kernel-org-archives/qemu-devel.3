Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C757AC48297
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 20:49:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXSNE-0004t8-TM; Tue, 06 Feb 2024 15:48:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amonakov@ispras.ru>)
 id 1rXSND-0004sn-EM
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 15:48:55 -0500
Received: from mail.ispras.ru ([83.149.199.84])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amonakov@ispras.ru>)
 id 1rXSNB-0001eU-Or
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 15:48:55 -0500
Received: from localhost.intra.ispras.ru (unknown [10.10.3.121])
 by mail.ispras.ru (Postfix) with ESMTP id 50E36407672A;
 Tue,  6 Feb 2024 20:48:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 50E36407672A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
 s=default; t=1707252521;
 bh=ETvOydZy8vnkWXRDCKf0mg+cgfZMi9kB2kJ9DVxrF2k=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=igCv2iXCaIWP1l3kVX7mQv/WCTK0G0E9xbMdyaElMjupXKXbcHm4rhqJbvQFmVHRI
 RTLRjm2voPlqX9L3rRyCkG1/ii8iDf9WLjaNpSV3cPYIri+wYm8wPGTxFEsLkcMOs/
 Vc5zsOeRh3Df5nX1pW4lv3yR2+FAzgYNHIIR/PtY=
From: Alexander Monakov <amonakov@ispras.ru>
To: qemu-devel@nongnu.org
Cc: Mikhail Romanov <mmromanov@ispras.ru>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexander Monakov <amonakov@ispras.ru>
Subject: [PATCH v3 5/6] util/bufferiszero: optimize SSE2 and AVX2 variants
Date: Tue,  6 Feb 2024 23:48:08 +0300
Message-Id: <20240206204809.9859-6-amonakov@ispras.ru>
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

Increase unroll factor in SIMD loops from 4x to 8x in order to move
their bottlenecks from ALU port contention to load issue rate (two loads
per cycle on popular x86 implementations).

Avoid using out-of-bounds pointers in loop boundary conditions.

Follow SSE2 implementation strategy in the AVX2 variant. Avoid use of
PTEST, which is not profitable there (like in the removed SSE4 variant).

Signed-off-by: Alexander Monakov <amonakov@ispras.ru>
Signed-off-by: Mikhail Romanov <mmromanov@ispras.ru>
---
 util/bufferiszero.c | 108 ++++++++++++++++++++++++++++----------------
 1 file changed, 69 insertions(+), 39 deletions(-)

diff --git a/util/bufferiszero.c b/util/bufferiszero.c
index cb3eb2543f..d752edd8cc 100644
--- a/util/bufferiszero.c
+++ b/util/bufferiszero.c
@@ -66,62 +66,92 @@ buffer_is_zero_len_4_plus(const void *buf, size_t len)
 #if defined(CONFIG_AVX2_OPT) || defined(__SSE2__)
 #include <immintrin.h>
 
-/* Note that each of these vectorized functions require len >= 64.  */
+/* Helper for preventing the compiler from reassociating
+   chains of binary vector operations.  */
+#define SSE_REASSOC_BARRIER(vec0, vec1) asm("" : "+x"(vec0), "+x"(vec1))
+
+/* Note that these vectorized functions may assume len >= 256.  */
 
 static bool __attribute__((target("sse2")))
 buffer_zero_sse2(const void *buf, size_t len)
 {
-    __m128i t = _mm_loadu_si128(buf);
-    __m128i *p = (__m128i *)(((uintptr_t)buf + 5 * 16) & -16);
-    __m128i *e = (__m128i *)(((uintptr_t)buf + len) & -16);
-    __m128i zero = _mm_setzero_si128();
-
-    /* Loop over 16-byte aligned blocks of 64.  */
-    while (likely(p <= e)) {
-        t = _mm_cmpeq_epi8(t, zero);
-        if (unlikely(_mm_movemask_epi8(t) != 0xFFFF)) {
+    /* Unaligned loads at head/tail.  */
+    __m128i v = *(__m128i_u *)(buf);
+    __m128i w = *(__m128i_u *)(buf + len - 16);
+    /* Align head/tail to 16-byte boundaries.  */
+    __m128i *p = (void *)(((uintptr_t)buf + 16) & -16);
+    __m128i *e = (void *)(((uintptr_t)buf + len - 1) & -16);
+    __m128i zero = { 0 };
+
+    /* Collect a partial block at tail end.  */
+    v |= e[-1]; w |= e[-2];
+    SSE_REASSOC_BARRIER(v, w);
+    v |= e[-3]; w |= e[-4];
+    SSE_REASSOC_BARRIER(v, w);
+    v |= e[-5]; w |= e[-6];
+    SSE_REASSOC_BARRIER(v, w);
+    v |= e[-7]; v |= w;
+
+    /* Loop over complete 128-byte blocks.  */
+    for (; p < e - 7; p += 8) {
+        v = _mm_cmpeq_epi8(v, zero);
+        if (unlikely(_mm_movemask_epi8(v) != 0xFFFF)) {
             return false;
         }
-        t = p[-4] | p[-3] | p[-2] | p[-1];
-        p += 4;
+        v = p[0]; w = p[1];
+        SSE_REASSOC_BARRIER(v, w);
+        v |= p[2]; w |= p[3];
+        SSE_REASSOC_BARRIER(v, w);
+        v |= p[4]; w |= p[5];
+        SSE_REASSOC_BARRIER(v, w);
+        v |= p[6]; w |= p[7];
+        SSE_REASSOC_BARRIER(v, w);
+        v |= w;
     }
 
-    /* Finish the aligned tail.  */
-    t |= e[-3];
-    t |= e[-2];
-    t |= e[-1];
-
-    /* Finish the unaligned tail.  */
-    t |= _mm_loadu_si128(buf + len - 16);
-
-    return _mm_movemask_epi8(_mm_cmpeq_epi8(t, zero)) == 0xFFFF;
+    return _mm_movemask_epi8(_mm_cmpeq_epi8(v, zero)) == 0xFFFF;
 }
 
 #ifdef CONFIG_AVX2_OPT
 static bool __attribute__((target("avx2")))
 buffer_zero_avx2(const void *buf, size_t len)
 {
-    /* Begin with an unaligned head of 32 bytes.  */
-    __m256i t = _mm256_loadu_si256(buf);
-    __m256i *p = (__m256i *)(((uintptr_t)buf + 5 * 32) & -32);
-    __m256i *e = (__m256i *)(((uintptr_t)buf + len) & -32);
-
-    /* Loop over 32-byte aligned blocks of 128.  */
-    while (p <= e) {
-        if (unlikely(!_mm256_testz_si256(t, t))) {
+    /* Unaligned loads at head/tail.  */
+    __m256i v = *(__m256i_u *)(buf);
+    __m256i w = *(__m256i_u *)(buf + len - 32);
+    /* Align head/tail to 32-byte boundaries.  */
+    __m256i *p = (void *)(((uintptr_t)buf + 32) & -32);
+    __m256i *e = (void *)(((uintptr_t)buf + len - 1) & -32);
+    __m256i zero = { 0 };
+
+    /* Collect a partial block at tail end.  */
+    v |= e[-1]; w |= e[-2];
+    SSE_REASSOC_BARRIER(v, w);
+    v |= e[-3]; w |= e[-4];
+    SSE_REASSOC_BARRIER(v, w);
+    v |= e[-5]; w |= e[-6];
+    SSE_REASSOC_BARRIER(v, w);
+    v |= e[-7]; v |= w;
+
+    /* Loop over complete 256-byte blocks.  */
+    for (; p < e - 7; p += 8) {
+        /* PTEST is not profitable here.  */
+        v = _mm256_cmpeq_epi8(v, zero);
+        if (unlikely(_mm256_movemask_epi8(v) != 0xFFFFFFFF)) {
             return false;
         }
-        t = p[-4] | p[-3] | p[-2] | p[-1];
-        p += 4;
-    } ;
-
-    /* Finish the last block of 128 unaligned.  */
-    t |= _mm256_loadu_si256(buf + len - 4 * 32);
-    t |= _mm256_loadu_si256(buf + len - 3 * 32);
-    t |= _mm256_loadu_si256(buf + len - 2 * 32);
-    t |= _mm256_loadu_si256(buf + len - 1 * 32);
+        v = p[0]; w = p[1];
+        SSE_REASSOC_BARRIER(v, w);
+        v |= p[2]; w |= p[3];
+        SSE_REASSOC_BARRIER(v, w);
+        v |= p[4]; w |= p[5];
+        SSE_REASSOC_BARRIER(v, w);
+        v |= p[6]; w |= p[7];
+        SSE_REASSOC_BARRIER(v, w);
+        v |= w;
+    }
 
-    return _mm256_testz_si256(t, t);
+    return _mm256_movemask_epi8(_mm256_cmpeq_epi8(v, zero)) == 0xFFFFFFFF;
 }
 #endif /* CONFIG_AVX2_OPT */
 
-- 
2.32.0


