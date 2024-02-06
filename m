Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C9A7C48297
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 20:50:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXSNV-0004vM-ET; Tue, 06 Feb 2024 15:49:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amonakov@ispras.ru>)
 id 1rXSNR-0004u0-L3
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 15:49:09 -0500
Received: from mail.ispras.ru ([83.149.199.84])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amonakov@ispras.ru>)
 id 1rXSNN-0001c3-74
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 15:49:09 -0500
Received: from localhost.intra.ispras.ru (unknown [10.10.3.121])
 by mail.ispras.ru (Postfix) with ESMTP id D94814076726;
 Tue,  6 Feb 2024 20:48:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru D94814076726
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
 s=default; t=1707252520;
 bh=lvGdZxGcWkyt/xJMjaL220N3POd116VkHqr/H8FApyo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=CFxt+9JMV5VG8TTQsNKO9q8Hs/8UGY0qvcNFGocHwrrUl/+ck/ElnTy6LQ6E/0G5Z
 cql5QDOaW5n/sRXz5lGjh2gfdIMFkrVI2hye83Va6RwfTxRPW6MtResXved2jGTDPo
 kRKimRE0siFj0CuErnUNvr/l3vey6NCAvk/FPGLQ=
From: Alexander Monakov <amonakov@ispras.ru>
To: qemu-devel@nongnu.org
Cc: Mikhail Romanov <mmromanov@ispras.ru>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexander Monakov <amonakov@ispras.ru>
Subject: [PATCH v3 2/6] util/bufferiszero: introduce an inline wrapper
Date: Tue,  6 Feb 2024 23:48:05 +0300
Message-Id: <20240206204809.9859-3-amonakov@ispras.ru>
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

Make buffer_is_zero a 'static inline' function that tests up to three
bytes from the buffer before handing off to an unrolled loop. This
eliminates call overhead for most non-zero buffers, and allows to
optimize out length checks when it is known at compile time (which is
often the case in Qemu).

Signed-off-by: Alexander Monakov <amonakov@ispras.ru>
Signed-off-by: Mikhail Romanov <mmromanov@ispras.ru>
---
 include/qemu/cutils.h | 28 +++++++++++++++-
 util/bufferiszero.c   | 76 ++++++++++++-------------------------------
 2 files changed, 47 insertions(+), 57 deletions(-)

diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h
index 92c927a6a3..62b153e603 100644
--- a/include/qemu/cutils.h
+++ b/include/qemu/cutils.h
@@ -187,9 +187,35 @@ char *freq_to_str(uint64_t freq_hz);
 /* used to print char* safely */
 #define STR_OR_NULL(str) ((str) ? (str) : "null")
 
-bool buffer_is_zero(const void *buf, size_t len);
+bool buffer_is_zero_len_4_plus(const void *, size_t);
+extern bool (*buffer_is_zero_len_256_plus)(const void *, size_t);
 bool test_buffer_is_zero_next_accel(void);
 
+/*
+ * Check if a buffer is all zeroes.
+ */
+static inline bool buffer_is_zero(const void *vbuf, size_t len)
+{
+    const char *buf = vbuf;
+
+    if (len == 0) {
+        return true;
+    }
+    if (buf[0] || buf[len - 1] || buf[len / 2]) {
+        return false;
+    }
+    /* All bytes are covered for any len <= 3.  */
+    if (len <= 3) {
+        return true;
+    }
+
+    if (len >= 256) {
+        return buffer_is_zero_len_256_plus(vbuf, len);
+    } else {
+        return buffer_is_zero_len_4_plus(vbuf, len);
+    }
+}
+
 /*
  * Implementation of ULEB128 (http://en.wikipedia.org/wiki/LEB128)
  * Input is limited to 14-bit numbers
diff --git a/util/bufferiszero.c b/util/bufferiszero.c
index f5a3634f9a..01050694a6 100644
--- a/util/bufferiszero.c
+++ b/util/bufferiszero.c
@@ -26,8 +26,8 @@
 #include "qemu/bswap.h"
 #include "host/cpuinfo.h"
 
-static bool
-buffer_zero_int(const void *buf, size_t len)
+bool
+buffer_is_zero_len_4_plus(const void *buf, size_t len)
 {
     if (unlikely(len < 8)) {
         /* For a very small buffer, simply accumulate all the bytes.  */
@@ -157,57 +157,40 @@ buffer_zero_avx512(const void *buf, size_t len)
 }
 #endif /* CONFIG_AVX512F_OPT */
 
-/*
- * Make sure that these variables are appropriately initialized when
- * SSE2 is enabled on the compiler command-line, but the compiler is
- * too old to support CONFIG_AVX2_OPT.
- */
-#if defined(CONFIG_AVX512F_OPT) || defined(CONFIG_AVX2_OPT)
-# define INIT_USED     0
-# define INIT_LENGTH   0
-# define INIT_ACCEL    buffer_zero_int
-#else
-# ifndef __SSE2__
-#  error "ISA selection confusion"
-# endif
-# define INIT_USED     CPUINFO_SSE2
-# define INIT_LENGTH   64
-# define INIT_ACCEL    buffer_zero_sse2
-#endif
-
-static unsigned used_accel = INIT_USED;
-static unsigned length_to_accel = INIT_LENGTH;
-static bool (*buffer_accel)(const void *, size_t) = INIT_ACCEL;
-
 static unsigned __attribute__((noinline))
 select_accel_cpuinfo(unsigned info)
 {
     /* Array is sorted in order of algorithm preference. */
     static const struct {
         unsigned bit;
-        unsigned len;
         bool (*fn)(const void *, size_t);
     } all[] = {
 #ifdef CONFIG_AVX512F_OPT
-        { CPUINFO_AVX512F, 256, buffer_zero_avx512 },
+        { CPUINFO_AVX512F, buffer_zero_avx512 },
 #endif
 #ifdef CONFIG_AVX2_OPT
-        { CPUINFO_AVX2,    128, buffer_zero_avx2 },
+        { CPUINFO_AVX2,    buffer_zero_avx2 },
 #endif
-        { CPUINFO_SSE2,     64, buffer_zero_sse2 },
-        { CPUINFO_ALWAYS,    0, buffer_zero_int },
+        { CPUINFO_SSE2,    buffer_zero_sse2 },
+        { CPUINFO_ALWAYS,  buffer_is_zero_len_4_plus },
     };
 
     for (unsigned i = 0; i < ARRAY_SIZE(all); ++i) {
         if (info & all[i].bit) {
-            length_to_accel = all[i].len;
-            buffer_accel = all[i].fn;
+            buffer_is_zero_len_256_plus = all[i].fn;
             return all[i].bit;
         }
     }
     return 0;
 }
 
+static unsigned used_accel
+#if defined(__SSE2__)
+    = CPUINFO_SSE2;
+#else
+    = 0;
+#endif
+
 #if defined(CONFIG_AVX512F_OPT) || defined(CONFIG_AVX2_OPT)
 static void __attribute__((constructor)) init_accel(void)
 {
@@ -227,35 +210,16 @@ bool test_buffer_is_zero_next_accel(void)
     return used;
 }
 
-static bool select_accel_fn(const void *buf, size_t len)
-{
-    if (likely(len >= length_to_accel)) {
-        return buffer_accel(buf, len);
-    }
-    return buffer_zero_int(buf, len);
-}
-
 #else
-#define select_accel_fn  buffer_zero_int
 bool test_buffer_is_zero_next_accel(void)
 {
     return false;
 }
 #endif
 
-/*
- * Checks if a buffer is all zeroes
- */
-bool buffer_is_zero(const void *buf, size_t len)
-{
-    if (unlikely(len == 0)) {
-        return true;
-    }
-
-    /* Fetch the beginning of the buffer while we select the accelerator.  */
-    __builtin_prefetch(buf);
-
-    /* Use an optimized zero check if possible.  Note that this also
-       includes a check for an unrolled loop over 64-bit integers.  */
-    return select_accel_fn(buf, len);
-}
+bool (*buffer_is_zero_len_256_plus)(const void *, size_t)
+#if defined(__SSE2__)
+    = buffer_zero_sse2;
+#else
+    = buffer_is_zero_len_4_plus;
+#endif
-- 
2.32.0


