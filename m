Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29E7FC10F16
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 15:15:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2ubJ-0005oV-QE; Fri, 03 May 2024 11:13:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2ubE-0005jy-SK
 for qemu-devel@nongnu.org; Fri, 03 May 2024 11:13:25 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2ubC-00075g-MJ
 for qemu-devel@nongnu.org; Fri, 03 May 2024 11:13:24 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1ecff927a45so16194385ad.0
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 08:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714749201; x=1715354001; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LJEBA8HhooZ+SwbOdLUPlZU44jMDHr0d5xq5JBRqrDA=;
 b=kZfl26y3IPmxVoO1Ncxr0aHwBQOOeb6uONzoBsXmQyL0vUVQYaEtOoeByjFoMxiDbn
 gRLglCAm3pwCMokW+5AaaDuOU6KNb5XXw+bDJotJ1VgF549tUGW+MB1cVIh/WP4GAfbp
 iau9eYrKI9mG81rA9c0I3cwu8frgXS7zXySkonTJaVVjiXjC3itjSQPW8hy2HrSNVZgQ
 rVcOLBtIhLre31yhLVGpJMZvwBp9ymJWQ9yMneGVv1dBwQ8rwxZBoZVHmFXywTaV/vqZ
 yMoSLSO8Lbi06Aa00A31znh8uz4n7JDt4MYBYEeZ1lRYl7gfR7h5BE3gRYd92KDYG7t5
 VGyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714749201; x=1715354001;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LJEBA8HhooZ+SwbOdLUPlZU44jMDHr0d5xq5JBRqrDA=;
 b=aAoCf6OKANhJens9Cut1geqTGOpGS4WHZNGw9lNUTaajmCdnf3BhRgR08SwLpaopp7
 OmuqdqKrWYCN8Q7XKD5YVZZ5XMd+7bp/Q5HrM36NIoXH9uocgKm1zd3UwQETYTYmrIX6
 xCodMERQAKBg7CelZq4xTciVOpKq/Afdptki3kWlLq7NfLuHd9i8U7CsjgUiT/EmClZq
 QVS1jePX1j3xxnie/BivOKLRga5AvCOSvFM734kHX9sB2rJL7r+86Z7kwq75rlLmlhpL
 X2UnPWmTv90TICpTT3QTiPnFp+aJ/Q4aWNuThNJiNjh3DWA9xv8flXOOJ861rtJbG3xo
 0H0Q==
X-Gm-Message-State: AOJu0Yz0zEoFLtPba+4/62uXwkYq3c7LDQEmUJqhfshlErWCh4q+Ljqc
 VU63+r2xRsfpbKHol+jQIK1GgleYub8N0jvep2zSYREQnk0pJuZtYhzI4qWRMJ31jLR60oUFJmb
 i
X-Google-Smtp-Source: AGHT+IHUnCm4fMMeToqqbDBurICURudEZ4sDDBzRfd9uMIVjWNcoxVArkvhKoCZ/dfQ5rvmW9Rc4Ew==
X-Received: by 2002:a17:902:d355:b0:1e4:c09:7f37 with SMTP id
 l21-20020a170902d35500b001e40c097f37mr2820033plk.54.1714749200975; 
 Fri, 03 May 2024 08:13:20 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 p10-20020a170902c70a00b001e81c778784sm3366611plp.67.2024.05.03.08.13.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 May 2024 08:13:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Monakov <amonakov@ispras.ru>,
 Mikhail Romanov <mmromanov@ispras.ru>
Subject: [PULL 05/10] util/bufferiszero: Optimize SSE2 and AVX2 variants
Date: Fri,  3 May 2024 08:13:09 -0700
Message-Id: <20240503151314.336357-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240503151314.336357-1-richard.henderson@linaro.org>
References: <20240503151314.336357-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

Increase unroll factor in SIMD loops from 4x to 8x in order to move
their bottlenecks from ALU port contention to load issue rate (two loads
per cycle on popular x86 implementations).

Avoid using out-of-bounds pointers in loop boundary conditions.

Follow SSE2 implementation strategy in the AVX2 variant. Avoid use of
PTEST, which is not profitable there (like in the removed SSE4 variant).

Signed-off-by: Alexander Monakov <amonakov@ispras.ru>
Signed-off-by: Mikhail Romanov <mmromanov@ispras.ru>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240206204809.9859-6-amonakov@ispras.ru>
---
 util/bufferiszero.c | 111 +++++++++++++++++++++++++++++---------------
 1 file changed, 73 insertions(+), 38 deletions(-)

diff --git a/util/bufferiszero.c b/util/bufferiszero.c
index 00118d649e..02df82b4ff 100644
--- a/util/bufferiszero.c
+++ b/util/bufferiszero.c
@@ -67,62 +67,97 @@ static bool buffer_is_zero_integer(const void *buf, size_t len)
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
+    /* Unaligned loads at head/tail.  */
+    __m128i v = *(__m128i_u *)(buf);
+    __m128i w = *(__m128i_u *)(buf + len - 16);
+    /* Align head/tail to 16-byte boundaries.  */
+    const __m128i *p = QEMU_ALIGN_PTR_DOWN(buf + 16, 16);
+    const __m128i *e = QEMU_ALIGN_PTR_DOWN(buf + len - 1, 16);
+    __m128i zero = { 0 };
 
-    /* Loop over 16-byte aligned blocks of 64.  */
-    while (likely(p <= e)) {
-        t = _mm_cmpeq_epi8(t, zero);
-        if (unlikely(_mm_movemask_epi8(t) != 0xFFFF)) {
+    /* Collect a partial block at tail end.  */
+    v |= e[-1]; w |= e[-2];
+    SSE_REASSOC_BARRIER(v, w);
+    v |= e[-3]; w |= e[-4];
+    SSE_REASSOC_BARRIER(v, w);
+    v |= e[-5]; w |= e[-6];
+    SSE_REASSOC_BARRIER(v, w);
+    v |= e[-7]; v |= w;
+
+    /*
+     * Loop over complete 128-byte blocks.
+     * With the head and tail removed, e - p >= 14, so the loop
+     * must iterate at least once.
+     */
+    do {
+        v = _mm_cmpeq_epi8(v, zero);
+        if (unlikely(_mm_movemask_epi8(v) != 0xFFFF)) {
             return false;
         }
-        t = p[-4] | p[-3] | p[-2] | p[-1];
-        p += 4;
-    }
+        v = p[0]; w = p[1];
+        SSE_REASSOC_BARRIER(v, w);
+        v |= p[2]; w |= p[3];
+        SSE_REASSOC_BARRIER(v, w);
+        v |= p[4]; w |= p[5];
+        SSE_REASSOC_BARRIER(v, w);
+        v |= p[6]; w |= p[7];
+        SSE_REASSOC_BARRIER(v, w);
+        v |= w;
+        p += 8;
+    } while (p < e - 7);
 
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
+    /* Unaligned loads at head/tail.  */
+    __m256i v = *(__m256i_u *)(buf);
+    __m256i w = *(__m256i_u *)(buf + len - 32);
+    /* Align head/tail to 32-byte boundaries.  */
+    const __m256i *p = QEMU_ALIGN_PTR_DOWN(buf + 32, 32);
+    const __m256i *e = QEMU_ALIGN_PTR_DOWN(buf + len - 1, 32);
+    __m256i zero = { 0 };
 
-    /* Loop over 32-byte aligned blocks of 128.  */
-    while (p <= e) {
-        if (unlikely(!_mm256_testz_si256(t, t))) {
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
 
-    /* Finish the last block of 128 unaligned.  */
-    t |= _mm256_loadu_si256(buf + len - 4 * 32);
-    t |= _mm256_loadu_si256(buf + len - 3 * 32);
-    t |= _mm256_loadu_si256(buf + len - 2 * 32);
-    t |= _mm256_loadu_si256(buf + len - 1 * 32);
-
-    return _mm256_testz_si256(t, t);
+    return _mm256_movemask_epi8(_mm256_cmpeq_epi8(v, zero)) == 0xFFFFFFFF;
 }
 #endif /* CONFIG_AVX2_OPT */
 
-- 
2.34.1


