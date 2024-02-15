Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 325C4C48BEF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 08:16:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raWu9-0007iw-U3; Thu, 15 Feb 2024 03:15:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1raWtX-00076g-9n
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 03:14:59 -0500
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1raWtV-0001Ne-CU
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 03:14:59 -0500
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-53fbf2c42bfso488195a12.3
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 00:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707984896; x=1708589696; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dXCRLUcCrBeHTOJN8WRLVbCeiDdcG1rvhb6HzJR+Pi4=;
 b=fN/YWgu4I2uogIlX4DZDGhuCci0c2r3g076Fp/U8f/yy+1HZnu0S6G7JQ7ZxtkY64v
 ZGsCpbjyRpFrRW8qH50UatrUfjcVGZvyl0iQgb3uYlfTy9KQ2TuwX5W97NhguO9DT31I
 6aI3nm//CMxpOkHH69OWK7CvlziPMOliTX/R7RXaa46K65NofHJzjN5BCAMDIKdaIqVh
 jPuJn7ALwi2rS5rPdmVvhUjay1tSCZtKPY4Gekg04Rz+c9W1maGWiKXSYObyai5aL7Lw
 HzMa2Km3rAQhMFsVluMeNCSxi4xFpJYcKh0NpgNt/EjXuCYCXbZbxlWB12kBcvyu0lKl
 tf4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707984896; x=1708589696;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dXCRLUcCrBeHTOJN8WRLVbCeiDdcG1rvhb6HzJR+Pi4=;
 b=czfzXTCvINMkJ1BJc7gjJD6g3IyPxrjYcpyjdjN4klvhMcq/DMJyoUqeYXrbLFJjbT
 7TrjikHw7cmjeS66OSHOq7mr40lC+a0Q9CK6IOiXqM7EEflzs4ZDktQXdnEVPN11HQjk
 gpEynIVeOYcZsVHn/KRAz5sZ05seFWLz2FoqG8SzPSuSYSCW+1B0fkZssF4tZwXtUM+N
 MdaufpL2bfHQ3oO36r+7tTf5gEWrBYHhuszEx2ZSqKYAfi7alGi14+1WZ22DJcoVVgGW
 nNck4zWIgMI7UWtj2meU2DVgEcc9DSRym09U9Awdvt3S3Yj1Qnf5htVx4dVk1u8dCyRW
 0LQw==
X-Gm-Message-State: AOJu0Yygc7TxkqkDgufih2J1Us3sUqSvvcRY7KpdR7S0VNXI/31pli+M
 1jLkTbrdfu0s7CqOXsAJlowgnoeutTi9c7QzuQBOjIKEhIKBHJ/OWEPludIAjHhKNcy5X4jlVdZ
 h
X-Google-Smtp-Source: AGHT+IEImE1fKquE4e4E5yoRFqJy0JY89vxxKXq4FSlmWjSTHoqavMo25BrqPV3uC2I3liaFg1htRg==
X-Received: by 2002:a05:6a20:a195:b0:19e:425e:ec56 with SMTP id
 r21-20020a056a20a19500b0019e425eec56mr980332pzk.24.1707984895996; 
 Thu, 15 Feb 2024 00:14:55 -0800 (PST)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 qc14-20020a17090b288e00b0029900404e11sm807755pjb.27.2024.02.15.00.14.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Feb 2024 00:14:55 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: amonakov@ispras.ru,
	mmromanov@ispras.ru
Subject: [PATCH v4 03/10] util/bufferiszero: Reorganize for early test for
 acceleration
Date: Wed, 14 Feb 2024 22:14:42 -1000
Message-Id: <20240215081449.848220-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240215081449.848220-1-richard.henderson@linaro.org>
References: <20240215081449.848220-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52d.google.com
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
[rth: Use __builtin_constant_p and perform the sample out-of-line.]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/cutils.h | 15 +++++++-
 util/bufferiszero.c   | 89 ++++++++++++++++++-------------------------
 2 files changed, 51 insertions(+), 53 deletions(-)

diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h
index 92c927a6a3..36f8cfa0e9 100644
--- a/include/qemu/cutils.h
+++ b/include/qemu/cutils.h
@@ -187,9 +187,22 @@ char *freq_to_str(uint64_t freq_hz);
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
 
+#ifdef __OPTIMIZE__
+#define buffer_is_zero(B, L) \
+    (__builtin_constant_p(L) && (size_t)(L) >= 256 \
+     ? buffer_is_zero_ge256(B, L) : buffer_is_zero_ool(B, L))
+#else
+#define buffer_is_zero  buffer_is_zero_ool
+#endif
+
 /*
  * Implementation of ULEB128 (http://en.wikipedia.org/wiki/LEB128)
  * Input is limited to 14-bit numbers
diff --git a/util/bufferiszero.c b/util/bufferiszero.c
index 641d5f9b9e..38527f2467 100644
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
@@ -194,36 +173,42 @@ bool test_buffer_is_zero_next_accel(void)
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
+static inline bool buffer_is_zero_sample3(const char *buf, size_t len)
+{
+    return (buf[0] | buf[len - 1] | buf[len / 2]) == 0;
+}
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
+    return buffer_is_zero_sample3(buf, len) && buffer_is_zero_accel(buf, len);
 }
-- 
2.34.1


