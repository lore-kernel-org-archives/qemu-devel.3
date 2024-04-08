Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE26DCD129C
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 17:51:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtt8s-0002L1-TG; Mon, 08 Apr 2024 13:50:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rtt8W-0002BA-LH
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 13:50:29 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rtt8O-0003n3-VM
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 13:50:26 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6ed20fb620fso1344353b3a.2
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 10:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712598619; x=1713203419; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LJEBA8HhooZ+SwbOdLUPlZU44jMDHr0d5xq5JBRqrDA=;
 b=D5BEFsYhZVoqSwPzk4RQBc74N8t8sfBqK0tlTVxH8gX2zcKDtVivnwz6//aCVOJ17x
 UcDw9NgAO4V2bA6wsTGTZ1v3rPk83+ixLJtcMyJCxXoZ5ZDaI2pputcpYXpqMDBRBLu/
 rXNDAMap0UVhAItn30jrcMAV9+EarD/LrxTwvybjbuaf2biXgknSn40+ZTZUSuwB21Ha
 d1UX13roJX6n4O18REipN5OkL0gh8BJSSnZDVKYTjgeIVDQOWjmX54e6SnZMGkapWTTu
 y4XSSdOpZfhKmTNMbulg/4SQ5ubZvred4S+pwpBlMb5zrvVhoTMfUmP2JFG25t0eq0zT
 5/Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712598619; x=1713203419;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LJEBA8HhooZ+SwbOdLUPlZU44jMDHr0d5xq5JBRqrDA=;
 b=XutXQu7bxQBCsYmxkTzihjTqw+aacfwm6UczJtr+czZoAkq5Qq8LggmflkV3x/1TGP
 w/ljq/pJJhwz12Tcr2zIRHuqyiTry2mC3w1CCHGdMpJ++L2KRVhueP0TKubr8tFde0uF
 EM1oWBUw4wHelBv/KjeXZEtpnoNi+lWSi7ypBvz/c7TDPpb5nsfPrDsU3Wsvgyah1UVf
 y/3MD5SxKtEl7ZhAT/wK6gUQHCsxxDwjSsW47PghO5UuFP7cKDWDkx34fn0WXco9rd/L
 UvLRQeTUUuozqg3GsHaOXcJJOCWxLwE8xTVd2bjjBsvpvI2k3nShq1uMbGNRmiRl8tnl
 q7Yw==
X-Gm-Message-State: AOJu0YxjlXW97Fnhr2++mX6HFH5McoIX9UzvP/EyEmwz930bY9FjbJ+W
 6Tczt4TMk1Hhgo0hnp8nU6I6nNubx78Poe+X2SuvHBH2WLHCrUPx3+Hklhl5QRXXLOiW+s+6/zl
 /
X-Google-Smtp-Source: AGHT+IHIZCF7bNhOUkoC7AmoaISHmS0IavuFJUM1z2ldg8dnqsSPqoRb3EhqAB2y/ZPpvXrFMBz4EA==
X-Received: by 2002:a05:6a21:3a48:b0:1a7:377:b86d with SMTP id
 zu8-20020a056a213a4800b001a70377b86dmr8901991pzb.12.1712598619569; 
 Mon, 08 Apr 2024 10:50:19 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 ga15-20020a17090b038f00b0029c3bac0aa8sm8658432pjb.4.2024.04.08.10.50.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 10:50:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Monakov <amonakov@ispras.ru>,
 Mikhail Romanov <mmromanov@ispras.ru>
Subject: [PULL 32/35] util/bufferiszero: Optimize SSE2 and AVX2 variants
Date: Mon,  8 Apr 2024 07:49:26 -1000
Message-Id: <20240408174929.862917-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240408174929.862917-1-richard.henderson@linaro.org>
References: <20240408174929.862917-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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


