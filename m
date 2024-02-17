Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A375C48BF6
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Feb 2024 00:40:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rb8jq-00065p-Th; Fri, 16 Feb 2024 19:39:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rb8jo-00064f-U9
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 19:39:29 -0500
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rb8jm-0008Fc-Rv
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 19:39:28 -0500
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2994fb5ad60so266805a91.0
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 16:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708130365; x=1708735165; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Aco89HGhDUqxtzZSl7gQEXCIzX7CLhr3rgmAxnnD0GI=;
 b=AcvJhLPConnLxxcYzgup4DvQtc/+R86rkd1bEApJFp9mAQ4hK/JQBexKd2x3CKM6tk
 R9ubGZLzJbpkiEoxbQCaVSBbvaa4vB8DmjRtbvTvATBR7T6Y+1wCFNmI4/8PFOTeNJ/z
 OhXJmanESzNH86emns6WglE1cwRNgdZvjfhblH8Wc4zWNMa8L8ki2NUsO2++TQG4M/KC
 YPXeccpZ4k7Oknb22w923AT9bu9l1ghN4iTlPn4W+HmCZGJM3wWnXA/L4PUH7ptyxLl3
 bCYsvs2CP3/8TigjzOZHm3kOeMUPfXPUMFHgOkGvbSLuN3pEjru3STZ2kAvCVP3xlQK0
 hdgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708130365; x=1708735165;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Aco89HGhDUqxtzZSl7gQEXCIzX7CLhr3rgmAxnnD0GI=;
 b=XDNzbrK8byzNh3KxPsw4TbM8yPFGWKhbWM/QKdybRMgiQ77tSadgkAm5cRL5a8XWvq
 1FeFzRyR41/7Tq2m30BIvFUkMXAvZKnymYn7ujHgI93SKzwsjpfW4rGVlsbA268VdQEV
 1+zx6HgKtuewSuvqPMVcXpZXyfJaScogLRm+rlbacuexODPenYGn4QWFl+QGhXAKPIiE
 HKr8YegneiWjOCupwS/IFIcEoHzb6Kac8XKtoyGR2c0OGJRJ+ut783gAt60LE3Gc4vQ7
 SGZEuenxq1gvVh15UaECDqJc8FGdawUHV2unK8OPhKc6tKHanboe9qV1pRKyPZrdPgsR
 G3QQ==
X-Gm-Message-State: AOJu0YyVaokqyxlKI5DNz/vCrOCBJKWxk0ukhFrL4P6ZBuTJvXNPbPlS
 4trFU1QhOD19xNbqbijtCpfdPvWaxHEunwpTs7Sy5IRo0GHrGgzuWW4IlRL0qcb1TWJBUv9iEHf
 7
X-Google-Smtp-Source: AGHT+IF4tUFBKF/bw9sfpD/3qTiq7+xU9zNRGLIKjDLB+1qIIH9q/kDKBvDNp7uKPfchF0ka2aBxjw==
X-Received: by 2002:a17:90b:617:b0:298:b733:d9ad with SMTP id
 gb23-20020a17090b061700b00298b733d9admr13596577pjb.17.1708130365440; 
 Fri, 16 Feb 2024 16:39:25 -0800 (PST)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 z6-20020a170902ee0600b001d90306bdcfsm419325plb.65.2024.02.16.16.39.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Feb 2024 16:39:25 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: amonakov@ispras.ru,
	mmromanov@ispras.ru
Subject: [PATCH v5 03/10] util/bufferiszero: Reorganize for early test for
 acceleration
Date: Fri, 16 Feb 2024 14:39:11 -1000
Message-Id: <20240217003918.52229-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240217003918.52229-1-richard.henderson@linaro.org>
References: <20240217003918.52229-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
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

Test for length >= 256 inline, where is is often a constant.
Before calling into the accelerated routine, sample three bytes
from the buffer, which handles most non-zero buffers.

Signed-off-by: Alexander Monakov <amonakov@ispras.ru>
Signed-off-by: Mikhail Romanov <mmromanov@ispras.ru>
Message-Id: <20240206204809.9859-3-amonakov@ispras.ru>
[rth: Use __builtin_constant_p; move the indirect call out of line.]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/cutils.h | 32 ++++++++++++++++-
 util/bufferiszero.c   | 84 +++++++++++++++++--------------------------
 2 files changed, 63 insertions(+), 53 deletions(-)

diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h
index 92c927a6a3..741dade7cf 100644
--- a/include/qemu/cutils.h
+++ b/include/qemu/cutils.h
@@ -187,9 +187,39 @@ char *freq_to_str(uint64_t freq_hz);
 /* used to print char* safely */
 #define STR_OR_NULL(str) ((str) ? (str) : "null")
 
-bool buffer_is_zero(const void *buf, size_t len);
+/*
+ * Check if a buffer is all zeroes.
+ */
+
+bool buffer_is_zero_ool(const void *vbuf, size_t len);
+bool buffer_is_zero_ge256(const void *vbuf, size_t len);
 bool test_buffer_is_zero_next_accel(void);
 
+static inline bool buffer_is_zero_sample3(const char *buf, size_t len)
+{
+    /*
+     * For any reasonably sized buffer, these three samples come from
+     * three different cachelines.  In qemu-img usage, we find that
+     * each byte eliminates more than half of all buffer testing.
+     * It is therefore critical to performance that the byte tests
+     * short-circuit, so that we do not pull in additional cache lines.
+     * Do not "optimize" this to !(a | b | c).
+     */
+    return !buf[0] && !buf[len - 1] && !buf[len / 2];
+}
+
+#ifdef __OPTIMIZE__
+static inline bool buffer_is_zero(const void *buf, size_t len)
+{
+    return (__builtin_constant_p(len) && len >= 256
+            ? buffer_is_zero_sample3(buf, len) &&
+              buffer_is_zero_ge256(buf, len)
+            : buffer_is_zero_ool(buf, len));
+}
+#else
+#define buffer_is_zero  buffer_is_zero_ool
+#endif
+
 /*
  * Implementation of ULEB128 (http://en.wikipedia.org/wiki/LEB128)
  * Input is limited to 14-bit numbers
diff --git a/util/bufferiszero.c b/util/bufferiszero.c
index 641d5f9b9e..972f394cbd 100644
--- a/util/bufferiszero.c
+++ b/util/bufferiszero.c
@@ -26,8 +26,9 @@
 #include "qemu/bswap.h"
 #include "host/cpuinfo.h"
 
-static bool
-buffer_zero_int(const void *buf, size_t len)
+static bool (*buffer_is_zero_accel)(const void *, size_t);
+
+static bool buffer_is_zero_integer(const void *buf, size_t len)
 {
     if (unlikely(len < 8)) {
         /* For a very small buffer, simply accumulate all the bytes.  */
@@ -128,60 +129,38 @@ buffer_zero_avx2(const void *buf, size_t len)
 }
 #endif /* CONFIG_AVX2_OPT */
 
-/*
- * Make sure that these variables are appropriately initialized when
- * SSE2 is enabled on the compiler command-line, but the compiler is
- * too old to support CONFIG_AVX2_OPT.
- */
-#if defined(CONFIG_AVX2_OPT)
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
 #ifdef CONFIG_AVX2_OPT
-        { CPUINFO_AVX2,    128, buffer_zero_avx2 },
+        { CPUINFO_AVX2,    buffer_zero_avx2 },
 #endif
-        { CPUINFO_SSE2,     64, buffer_zero_sse2 },
-        { CPUINFO_ALWAYS,    0, buffer_zero_int },
+        { CPUINFO_SSE2,    buffer_zero_sse2 },
+        { CPUINFO_ALWAYS,  buffer_is_zero_integer },
     };
 
     for (unsigned i = 0; i < ARRAY_SIZE(all); ++i) {
         if (info & all[i].bit) {
-            length_to_accel = all[i].len;
-            buffer_accel = all[i].fn;
+            buffer_is_zero_accel = all[i].fn;
             return all[i].bit;
         }
     }
     return 0;
 }
 
-#if defined(CONFIG_AVX2_OPT)
+static unsigned used_accel;
+
 static void __attribute__((constructor)) init_accel(void)
 {
     used_accel = select_accel_cpuinfo(cpuinfo_init());
 }
-#endif /* CONFIG_AVX2_OPT */
+
+#define INIT_ACCEL NULL
 
 bool test_buffer_is_zero_next_accel(void)
 {
@@ -194,36 +173,37 @@ bool test_buffer_is_zero_next_accel(void)
     used_accel |= used;
     return used;
 }
-
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
+
+#define INIT_ACCEL buffer_is_zero_integer
 #endif
 
-/*
- * Checks if a buffer is all zeroes
- */
-bool buffer_is_zero(const void *buf, size_t len)
+static bool (*buffer_is_zero_accel)(const void *, size_t) = INIT_ACCEL;
+
+bool buffer_is_zero_ool(const void *buf, size_t len)
 {
     if (unlikely(len == 0)) {
         return true;
     }
+    if (!buffer_is_zero_sample3(buf, len)) {
+        return false;
+    }
+    /* All bytes are covered for any len <= 3.  */
+    if (unlikely(len <= 3)) {
+        return true;
+    }
 
-    /* Fetch the beginning of the buffer while we select the accelerator.  */
-    __builtin_prefetch(buf);
-
-    /* Use an optimized zero check if possible.  Note that this also
-       includes a check for an unrolled loop over 64-bit integers.  */
-    return select_accel_fn(buf, len);
+    if (likely(len >= 256)) {
+        return buffer_is_zero_accel(buf, len);
+    }
+    return buffer_is_zero_integer(buf, len);
+}
+
+bool buffer_is_zero_ge256(const void *buf, size_t len)
+{
+    return buffer_is_zero_accel(buf, len);
 }
-- 
2.34.1


