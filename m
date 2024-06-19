Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CD7FC27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 21:05:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sK2Pl-0002OQ-Gl; Wed, 19 Jun 2024 17:00:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sK2Pg-0002KX-Hr
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 17:00:16 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sK2Pd-0000fT-Ot
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 17:00:16 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-70435f4c330so245555b3a.1
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2024 14:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718830812; x=1719435612; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=we/cC6SV/OHCnqxYCDPX0iolNzRY4+fOCUveM9lfOU8=;
 b=LYfqdkGaNxRRVIbbGt+GRnjIa4rdLRV3vzXnlwLi7Tp6ZI7CpS6sMSCQ0HG8+EQhBG
 UlCRwsJUujFxOVF0wwbxWkzNBl+Mf3sAUYbI9GsU5x80Tstic2oxuXlZqKF3Ysf2l+SD
 mtPFsk8Y7H+LwWfLchHg3xQT3bpYNtGwUjfUdeTIKBCn6zpxdeWmV2/lp4RbH4Nu+cPW
 sr2yL8So+b5VD8uuI8/FyQJ7wiaqqrS//wu1BBka+WmKSrZG8tlo99pv7/x4OspGvQ12
 1nq0m7dvqy7RJOMleljMTaw6un10kNLkCzbKEFQLZv8Od2547Hl3oXmbRtzk8gO7LgNJ
 +yjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718830812; x=1719435612;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=we/cC6SV/OHCnqxYCDPX0iolNzRY4+fOCUveM9lfOU8=;
 b=ucEcjMb0JzNAljED7/YD+Q75McecbSexIBKBvJzHmBn0+6qpBuo9nMRrYKlF8DICio
 YWKVdviG2ibW7c4JXBQKnSFcKJwKCEOB5cCckg9YuKt10gKgF1MhBvA+/zIYUN021Gu2
 sgRCKCh8DW3CdM5o002lHNxM7/wV71FXXfTeQAYanUwC4Xl0HVhTDebSpsba9ZXoLt8V
 VqkTfAFumekP2BW3kMf/TWRjr6qd6IQQ5FISjS0ki7cJQjsM+LrIW48XXICvYSWJe8v7
 8P5UJESQkyYyuHO1Jqp2BJ/E+IapJM/1PKO6MjPPThtfJxA9S65otGGwfmmE7Vqihe9s
 GcyA==
X-Gm-Message-State: AOJu0YwkE/YS6bj/YwVDPfSMq7pJpZMiPy7aewVRKzU+9NqZh8BdBeW2
 3wGC6mO/cOSNs7d4sz65TAXS6/68fu9MKpK5NNYh0aN2WZ6SqCeCK4dfeFL1NRtf7ashKTaBWSx
 A
X-Google-Smtp-Source: AGHT+IHaQW3UDNN5uTur8stLkh/dQxe1faaiSDv/yWF9+Lg4EbJTQ5u88mUBCV4W6baAN9vdxpM/QA==
X-Received: by 2002:a05:6a20:78a4:b0:1b8:a341:e590 with SMTP id
 adf61e73a8af0-1bcbb665a8amr3160078637.58.1718830811578; 
 Wed, 19 Jun 2024 14:00:11 -0700 (PDT)
Received: from stoup.. ([71.212.132.216]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f98f8f8c42sm39183765ad.162.2024.06.19.14.00.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jun 2024 14:00:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 19/24] util/bufferiszero: Split out host include files
Date: Wed, 19 Jun 2024 13:59:47 -0700
Message-Id: <20240619205952.235946-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240619205952.235946-1-richard.henderson@linaro.org>
References: <20240619205952.235946-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

Split out host/bufferiszero.h.inc for x86, aarch64 and generic
in order to avoid an overlong ifdef ladder.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 util/bufferiszero.c                          | 191 +------------------
 host/include/aarch64/host/bufferiszero.c.inc |  76 ++++++++
 host/include/generic/host/bufferiszero.c.inc |  10 +
 host/include/i386/host/bufferiszero.c.inc    | 124 ++++++++++++
 host/include/x86_64/host/bufferiszero.c.inc  |   1 +
 5 files changed, 212 insertions(+), 190 deletions(-)
 create mode 100644 host/include/aarch64/host/bufferiszero.c.inc
 create mode 100644 host/include/generic/host/bufferiszero.c.inc
 create mode 100644 host/include/i386/host/bufferiszero.c.inc
 create mode 100644 host/include/x86_64/host/bufferiszero.c.inc

diff --git a/util/bufferiszero.c b/util/bufferiszero.c
index 11c080e02c..522146dab9 100644
--- a/util/bufferiszero.c
+++ b/util/bufferiszero.c
@@ -81,196 +81,7 @@ static bool buffer_is_zero_int_ge256(const void *buf, size_t len)
     return t == 0;
 }
 
-#if defined(CONFIG_AVX2_OPT) || defined(__SSE2__)
-#include <immintrin.h>
-
-/* Helper for preventing the compiler from reassociating
-   chains of binary vector operations.  */
-#define SSE_REASSOC_BARRIER(vec0, vec1) asm("" : "+x"(vec0), "+x"(vec1))
-
-/* Note that these vectorized functions may assume len >= 256.  */
-
-static bool __attribute__((target("sse2")))
-buffer_zero_sse2(const void *buf, size_t len)
-{
-    /* Unaligned loads at head/tail.  */
-    __m128i v = *(__m128i_u *)(buf);
-    __m128i w = *(__m128i_u *)(buf + len - 16);
-    /* Align head/tail to 16-byte boundaries.  */
-    const __m128i *p = QEMU_ALIGN_PTR_DOWN(buf + 16, 16);
-    const __m128i *e = QEMU_ALIGN_PTR_DOWN(buf + len - 1, 16);
-    __m128i zero = { 0 };
-
-    /* Collect a partial block at tail end.  */
-    v |= e[-1]; w |= e[-2];
-    SSE_REASSOC_BARRIER(v, w);
-    v |= e[-3]; w |= e[-4];
-    SSE_REASSOC_BARRIER(v, w);
-    v |= e[-5]; w |= e[-6];
-    SSE_REASSOC_BARRIER(v, w);
-    v |= e[-7]; v |= w;
-
-    /*
-     * Loop over complete 128-byte blocks.
-     * With the head and tail removed, e - p >= 14, so the loop
-     * must iterate at least once.
-     */
-    do {
-        v = _mm_cmpeq_epi8(v, zero);
-        if (unlikely(_mm_movemask_epi8(v) != 0xFFFF)) {
-            return false;
-        }
-        v = p[0]; w = p[1];
-        SSE_REASSOC_BARRIER(v, w);
-        v |= p[2]; w |= p[3];
-        SSE_REASSOC_BARRIER(v, w);
-        v |= p[4]; w |= p[5];
-        SSE_REASSOC_BARRIER(v, w);
-        v |= p[6]; w |= p[7];
-        SSE_REASSOC_BARRIER(v, w);
-        v |= w;
-        p += 8;
-    } while (p < e - 7);
-
-    return _mm_movemask_epi8(_mm_cmpeq_epi8(v, zero)) == 0xFFFF;
-}
-
-#ifdef CONFIG_AVX2_OPT
-static bool __attribute__((target("avx2")))
-buffer_zero_avx2(const void *buf, size_t len)
-{
-    /* Unaligned loads at head/tail.  */
-    __m256i v = *(__m256i_u *)(buf);
-    __m256i w = *(__m256i_u *)(buf + len - 32);
-    /* Align head/tail to 32-byte boundaries.  */
-    const __m256i *p = QEMU_ALIGN_PTR_DOWN(buf + 32, 32);
-    const __m256i *e = QEMU_ALIGN_PTR_DOWN(buf + len - 1, 32);
-    __m256i zero = { 0 };
-
-    /* Collect a partial block at tail end.  */
-    v |= e[-1]; w |= e[-2];
-    SSE_REASSOC_BARRIER(v, w);
-    v |= e[-3]; w |= e[-4];
-    SSE_REASSOC_BARRIER(v, w);
-    v |= e[-5]; w |= e[-6];
-    SSE_REASSOC_BARRIER(v, w);
-    v |= e[-7]; v |= w;
-
-    /* Loop over complete 256-byte blocks.  */
-    for (; p < e - 7; p += 8) {
-        /* PTEST is not profitable here.  */
-        v = _mm256_cmpeq_epi8(v, zero);
-        if (unlikely(_mm256_movemask_epi8(v) != 0xFFFFFFFF)) {
-            return false;
-        }
-        v = p[0]; w = p[1];
-        SSE_REASSOC_BARRIER(v, w);
-        v |= p[2]; w |= p[3];
-        SSE_REASSOC_BARRIER(v, w);
-        v |= p[4]; w |= p[5];
-        SSE_REASSOC_BARRIER(v, w);
-        v |= p[6]; w |= p[7];
-        SSE_REASSOC_BARRIER(v, w);
-        v |= w;
-    }
-
-    return _mm256_movemask_epi8(_mm256_cmpeq_epi8(v, zero)) == 0xFFFFFFFF;
-}
-#endif /* CONFIG_AVX2_OPT */
-
-static biz_accel_fn const accel_table[] = {
-    buffer_is_zero_int_ge256,
-    buffer_zero_sse2,
-#ifdef CONFIG_AVX2_OPT
-    buffer_zero_avx2,
-#endif
-};
-
-static unsigned best_accel(void)
-{
-#ifdef CONFIG_AVX2_OPT
-    unsigned info = cpuinfo_init();
-
-    if (info & CPUINFO_AVX2) {
-        return 2;
-    }
-#endif
-    return 1;
-}
-
-#elif defined(__aarch64__) && defined(__ARM_NEON)
-#include <arm_neon.h>
-
-/*
- * Helper for preventing the compiler from reassociating
- * chains of binary vector operations.
- */
-#define REASSOC_BARRIER(vec0, vec1) asm("" : "+w"(vec0), "+w"(vec1))
-
-static bool buffer_is_zero_simd(const void *buf, size_t len)
-{
-    uint32x4_t t0, t1, t2, t3;
-
-    /* Align head/tail to 16-byte boundaries.  */
-    const uint32x4_t *p = QEMU_ALIGN_PTR_DOWN(buf + 16, 16);
-    const uint32x4_t *e = QEMU_ALIGN_PTR_DOWN(buf + len - 1, 16);
-
-    /* Unaligned loads at head/tail.  */
-    t0 = vld1q_u32(buf) | vld1q_u32(buf + len - 16);
-
-    /* Collect a partial block at tail end.  */
-    t1 = e[-7] | e[-6];
-    t2 = e[-5] | e[-4];
-    t3 = e[-3] | e[-2];
-    t0 |= e[-1];
-    REASSOC_BARRIER(t0, t1);
-    REASSOC_BARRIER(t2, t3);
-    t0 |= t1;
-    t2 |= t3;
-    REASSOC_BARRIER(t0, t2);
-    t0 |= t2;
-
-    /*
-     * Loop over complete 128-byte blocks.
-     * With the head and tail removed, e - p >= 14, so the loop
-     * must iterate at least once.
-     */
-    do {
-        /*
-         * Reduce via UMAXV.  Whatever the actual result,
-         * it will only be zero if all input bytes are zero.
-         */
-        if (unlikely(vmaxvq_u32(t0) != 0)) {
-            return false;
-        }
-
-        t0 = p[0] | p[1];
-        t1 = p[2] | p[3];
-        t2 = p[4] | p[5];
-        t3 = p[6] | p[7];
-        REASSOC_BARRIER(t0, t1);
-        REASSOC_BARRIER(t2, t3);
-        t0 |= t1;
-        t2 |= t3;
-        REASSOC_BARRIER(t0, t2);
-        t0 |= t2;
-        p += 8;
-    } while (p < e - 7);
-
-    return vmaxvq_u32(t0) == 0;
-}
-
-#define best_accel() 1
-static biz_accel_fn const accel_table[] = {
-    buffer_is_zero_int_ge256,
-    buffer_is_zero_simd,
-};
-#else
-#define best_accel() 0
-static biz_accel_fn const accel_table[1] = {
-    buffer_is_zero_int_ge256
-};
-#endif
+#include "host/bufferiszero.c.inc"
 
 static biz_accel_fn buffer_is_zero_accel;
 static unsigned accel_index;
diff --git a/host/include/aarch64/host/bufferiszero.c.inc b/host/include/aarch64/host/bufferiszero.c.inc
new file mode 100644
index 0000000000..947ee7ca1f
--- /dev/null
+++ b/host/include/aarch64/host/bufferiszero.c.inc
@@ -0,0 +1,76 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ * buffer_is_zero acceleration, aarch64 version.
+ */
+
+#ifdef __ARM_NEON
+#include <arm_neon.h>
+
+/*
+ * Helper for preventing the compiler from reassociating
+ * chains of binary vector operations.
+ */
+#define REASSOC_BARRIER(vec0, vec1) asm("" : "+w"(vec0), "+w"(vec1))
+
+static bool buffer_is_zero_simd(const void *buf, size_t len)
+{
+    uint32x4_t t0, t1, t2, t3;
+
+    /* Align head/tail to 16-byte boundaries.  */
+    const uint32x4_t *p = QEMU_ALIGN_PTR_DOWN(buf + 16, 16);
+    const uint32x4_t *e = QEMU_ALIGN_PTR_DOWN(buf + len - 1, 16);
+
+    /* Unaligned loads at head/tail.  */
+    t0 = vld1q_u32(buf) | vld1q_u32(buf + len - 16);
+
+    /* Collect a partial block at tail end.  */
+    t1 = e[-7] | e[-6];
+    t2 = e[-5] | e[-4];
+    t3 = e[-3] | e[-2];
+    t0 |= e[-1];
+    REASSOC_BARRIER(t0, t1);
+    REASSOC_BARRIER(t2, t3);
+    t0 |= t1;
+    t2 |= t3;
+    REASSOC_BARRIER(t0, t2);
+    t0 |= t2;
+
+    /*
+     * Loop over complete 128-byte blocks.
+     * With the head and tail removed, e - p >= 14, so the loop
+     * must iterate at least once.
+     */
+    do {
+        /*
+         * Reduce via UMAXV.  Whatever the actual result,
+         * it will only be zero if all input bytes are zero.
+         */
+        if (unlikely(vmaxvq_u32(t0) != 0)) {
+            return false;
+        }
+
+        t0 = p[0] | p[1];
+        t1 = p[2] | p[3];
+        t2 = p[4] | p[5];
+        t3 = p[6] | p[7];
+        REASSOC_BARRIER(t0, t1);
+        REASSOC_BARRIER(t2, t3);
+        t0 |= t1;
+        t2 |= t3;
+        REASSOC_BARRIER(t0, t2);
+        t0 |= t2;
+        p += 8;
+    } while (p < e - 7);
+
+    return vmaxvq_u32(t0) == 0;
+}
+
+static biz_accel_fn const accel_table[] = {
+    buffer_is_zero_int_ge256,
+    buffer_is_zero_simd,
+};
+
+#define best_accel() 1
+#else
+# include "host/include/generic/host/bufferiszero.c.inc"
+#endif
diff --git a/host/include/generic/host/bufferiszero.c.inc b/host/include/generic/host/bufferiszero.c.inc
new file mode 100644
index 0000000000..ea0875c24a
--- /dev/null
+++ b/host/include/generic/host/bufferiszero.c.inc
@@ -0,0 +1,10 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ * buffer_is_zero acceleration, generic version.
+ */
+
+static biz_accel_fn const accel_table[1] = {
+    buffer_is_zero_int_ge256
+};
+
+#define best_accel() 0
diff --git a/host/include/i386/host/bufferiszero.c.inc b/host/include/i386/host/bufferiszero.c.inc
new file mode 100644
index 0000000000..3b9605d806
--- /dev/null
+++ b/host/include/i386/host/bufferiszero.c.inc
@@ -0,0 +1,124 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ * buffer_is_zero acceleration, x86 version.
+ */
+
+#if defined(CONFIG_AVX2_OPT) || defined(__SSE2__)
+#include <immintrin.h>
+
+/* Helper for preventing the compiler from reassociating
+   chains of binary vector operations.  */
+#define SSE_REASSOC_BARRIER(vec0, vec1) asm("" : "+x"(vec0), "+x"(vec1))
+
+/* Note that these vectorized functions may assume len >= 256.  */
+
+static bool __attribute__((target("sse2")))
+buffer_zero_sse2(const void *buf, size_t len)
+{
+    /* Unaligned loads at head/tail.  */
+    __m128i v = *(__m128i_u *)(buf);
+    __m128i w = *(__m128i_u *)(buf + len - 16);
+    /* Align head/tail to 16-byte boundaries.  */
+    const __m128i *p = QEMU_ALIGN_PTR_DOWN(buf + 16, 16);
+    const __m128i *e = QEMU_ALIGN_PTR_DOWN(buf + len - 1, 16);
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
+    /*
+     * Loop over complete 128-byte blocks.
+     * With the head and tail removed, e - p >= 14, so the loop
+     * must iterate at least once.
+     */
+    do {
+        v = _mm_cmpeq_epi8(v, zero);
+        if (unlikely(_mm_movemask_epi8(v) != 0xFFFF)) {
+            return false;
+        }
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
+
+    return _mm_movemask_epi8(_mm_cmpeq_epi8(v, zero)) == 0xFFFF;
+}
+
+#ifdef CONFIG_AVX2_OPT
+static bool __attribute__((target("avx2")))
+buffer_zero_avx2(const void *buf, size_t len)
+{
+    /* Unaligned loads at head/tail.  */
+    __m256i v = *(__m256i_u *)(buf);
+    __m256i w = *(__m256i_u *)(buf + len - 32);
+    /* Align head/tail to 32-byte boundaries.  */
+    const __m256i *p = QEMU_ALIGN_PTR_DOWN(buf + 32, 32);
+    const __m256i *e = QEMU_ALIGN_PTR_DOWN(buf + len - 1, 32);
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
+            return false;
+        }
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
+
+    return _mm256_movemask_epi8(_mm256_cmpeq_epi8(v, zero)) == 0xFFFFFFFF;
+}
+#endif /* CONFIG_AVX2_OPT */
+
+static biz_accel_fn const accel_table[] = {
+    buffer_is_zero_int_ge256,
+    buffer_zero_sse2,
+#ifdef CONFIG_AVX2_OPT
+    buffer_zero_avx2,
+#endif
+};
+
+static unsigned best_accel(void)
+{
+#ifdef CONFIG_AVX2_OPT
+    unsigned info = cpuinfo_init();
+    if (info & CPUINFO_AVX2) {
+        return 2;
+    }
+#endif
+    return 1;
+}
+
+#else
+# include "host/include/generic/host/bufferiszero.c.inc"
+#endif
diff --git a/host/include/x86_64/host/bufferiszero.c.inc b/host/include/x86_64/host/bufferiszero.c.inc
new file mode 100644
index 0000000000..1d3f1fd6f5
--- /dev/null
+++ b/host/include/x86_64/host/bufferiszero.c.inc
@@ -0,0 +1 @@
+#include "host/include/i386/host/bufferiszero.c.inc"
-- 
2.34.1


