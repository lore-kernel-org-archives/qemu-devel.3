Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A63EBD148A1
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 05:38:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdibm-0005Ho-VG; Thu, 08 Jan 2026 00:30:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vdibc-00057R-CA
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 00:30:46 -0500
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vdibW-0005JG-IQ
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 00:30:42 -0500
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-ba599137cf8so595881a12.0
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 21:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767850237; x=1768455037; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sio0sPTwm8SZWW8xUuOuvoZjmMp3BooKmkrPUh029to=;
 b=WsfF2b/LwhSYuO2xtXbnesSS1oLdnvTUn9cU2Kuo5NZZOgAn7YQ+l2Ilt7g44ZTzff
 wlRdf2tPLpAPCp/PHaHucpDTD48DM6/qUQk1dxMEiF+p6Ad4dXD+0W6SKfgJFd4aysMt
 w+zkNp3u72mcDxq5qi7H2T/JuEa4FUILdao95kJ3BSHm/RpzQQO0Kw9ZLRspX+PqA/jC
 9me1gKJ+lSriMcWbPKX+oUEl0/E3TdFIv7OhQSjJiPdEqqezJWmn2XS7l0+C0fCoqVqZ
 a15uQJuuP4ARrXtnMGrOfj7ZjBzOqvt0Mt/m1nrZmvJp7q6pL8d9n0J/4NlHm7lh2nIQ
 D5Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767850237; x=1768455037;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=sio0sPTwm8SZWW8xUuOuvoZjmMp3BooKmkrPUh029to=;
 b=McvdJ8Ku00cXjtUcsItLJuNzZTsrPLPje7EKMbYEqdtuerMQ68FnoxyrQihGs4IfZ2
 6NG73JRqowsrfJwMNV1ZzuXdGGpDCWM65okhLOTnAzqDUYVsEN9AT5AW2lcNNsZVMBoD
 5/+cdAE3lvPo8K2JgzuJsqHV3nwzC9+YT1BkatsDzM8L8Gu1F7hUpziktRFewx0YWH23
 3bNOSUPjK/aaPNrcE6hRgp2Pl8uZA9HyMUAhmLLQ3S7oHT16PHZ/NurMekdtAyWWCqzN
 nUBUIb6UXyeDdW0SeEE8caKVmln6YuJ13FS5LxsFmkmp0rGn0EmCp72hr4AdpOPj2Lpk
 jv2Q==
X-Gm-Message-State: AOJu0YwWoDN9pqMlQ7B/4oO+MfArfTDXSrUPvTdbAVJFEnEVMu/yyYfF
 oe1fnpC7v5RWmDRk+SFNet/R2uO3aD6hN/wkpQWRioBEp0oI0dA2LXEdVIfnKg7/lX5gOY/MzRc
 ahwPiFXo=
X-Gm-Gg: AY/fxX6N6oSiBbt1uTGEtd2eGSXj3WCL9r+tTaToNTrVEc+Z68R42kU8J73LaxTp3sa
 1ZEbuS7vV1nNNDxFh1ASQs4yFjdFpPlgek8Jb/wnLibT3fXSshbtMjH8ydeVqC2+9ZWrCKt9j+6
 N69WaaZHG2EgXH888/2WVBzhPMbsFbb2g2LZKmJvrl5DsyuFwhiNhGw+iedsRI9nw8hygRp1Hsz
 fYsMQk+f46PZI62k23dCFWsQY9rsCLcpJGkDO/HBncLXNO90NAc31+HWOpRcZcePVljM6F71Zhr
 8O9aPLSld3D5QLm9wLGuiRKLHW6H6JnNJnP0wZcqPqxUvNYrgx9HyV6Bs7qXi9YVCTDztMSbbpc
 4zKQXZstKxte8Ur+lzEMrN9c0W+awNrFBJqMcoq1sC8zbH8ol2244Lwd9iATbmJBRDzbNKHvNbQ
 o7qBdSk1DXfhtJ1NaIOItjH4uGvB+x
X-Google-Smtp-Source: AGHT+IHWGk3Gzm3xrX8VtV8aIZnjZvnw97HzGyt4QgIyEw5TPH3kdDT8UWmp9amdKODzxDT62drV3A==
X-Received: by 2002:a05:6a21:62ca:b0:37d:e26a:bff2 with SMTP id
 adf61e73a8af0-38982b1ffbbmr8406301637.20.1767850236466; 
 Wed, 07 Jan 2026 21:30:36 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cc05cd9d9sm7036552a12.16.2026.01.07.21.30.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jan 2026 21:30:36 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 06/50] *: Remove i386 host support
Date: Thu,  8 Jan 2026 16:29:34 +1100
Message-ID: <20260108053018.626690-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108053018.626690-1-richard.henderson@linaro.org>
References: <20260108053018.626690-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
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

Move the files from host/include/i386 to host/include/x86_64,
replacing the stub headers that redirected to i386.

Remove linux-user/include/host/i386.
Remove common-user/host/i386.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 host/include/i386/host/cpuinfo.h            |  41 ------
 host/include/i386/host/crypto/aes-round.h   | 152 -------------------
 host/include/i386/host/crypto/clmul.h       |  29 ----
 host/include/x86_64/host/cpuinfo.h          |  42 +++++-
 host/include/x86_64/host/crypto/aes-round.h | 153 +++++++++++++++++++-
 host/include/x86_64/host/crypto/clmul.h     |  30 +++-
 linux-user/include/host/i386/host-signal.h  |  38 -----
 common-user/host/i386/safe-syscall.inc.S    | 127 ----------------
 host/include/i386/host/bufferiszero.c.inc   | 125 ----------------
 host/include/x86_64/host/bufferiszero.c.inc | 126 +++++++++++++++-
 10 files changed, 347 insertions(+), 516 deletions(-)
 delete mode 100644 host/include/i386/host/cpuinfo.h
 delete mode 100644 host/include/i386/host/crypto/aes-round.h
 delete mode 100644 host/include/i386/host/crypto/clmul.h
 delete mode 100644 linux-user/include/host/i386/host-signal.h
 delete mode 100644 common-user/host/i386/safe-syscall.inc.S
 delete mode 100644 host/include/i386/host/bufferiszero.c.inc

diff --git a/host/include/i386/host/cpuinfo.h b/host/include/i386/host/cpuinfo.h
deleted file mode 100644
index 93d029d499..0000000000
--- a/host/include/i386/host/cpuinfo.h
+++ /dev/null
@@ -1,41 +0,0 @@
-/*
- * SPDX-License-Identifier: GPL-2.0-or-later
- * Host specific cpu identification for x86.
- */
-
-#ifndef HOST_CPUINFO_H
-#define HOST_CPUINFO_H
-
-/* Digested version of <cpuid.h> */
-
-#define CPUINFO_ALWAYS          (1u << 0)  /* so cpuinfo is nonzero */
-#define CPUINFO_OSXSAVE         (1u << 1)
-#define CPUINFO_MOVBE           (1u << 2)
-#define CPUINFO_LZCNT           (1u << 3)
-#define CPUINFO_POPCNT          (1u << 4)
-#define CPUINFO_BMI1            (1u << 5)
-#define CPUINFO_BMI2            (1u << 6)
-#define CPUINFO_SSE2            (1u << 7)
-#define CPUINFO_AVX1            (1u << 9)
-#define CPUINFO_AVX2            (1u << 10)
-#define CPUINFO_AVX512F         (1u << 11)
-#define CPUINFO_AVX512VL        (1u << 12)
-#define CPUINFO_AVX512BW        (1u << 13)
-#define CPUINFO_AVX512DQ        (1u << 14)
-#define CPUINFO_AVX512VBMI2     (1u << 15)
-#define CPUINFO_ATOMIC_VMOVDQA  (1u << 16)
-#define CPUINFO_ATOMIC_VMOVDQU  (1u << 17)
-#define CPUINFO_AES             (1u << 18)
-#define CPUINFO_PCLMUL          (1u << 19)
-#define CPUINFO_GFNI            (1u << 20)
-
-/* Initialized with a constructor. */
-extern unsigned cpuinfo;
-
-/*
- * We cannot rely on constructor ordering, so other constructors must
- * use the function interface rather than the variable above.
- */
-unsigned cpuinfo_init(void);
-
-#endif /* HOST_CPUINFO_H */
diff --git a/host/include/i386/host/crypto/aes-round.h b/host/include/i386/host/crypto/aes-round.h
deleted file mode 100644
index 59a64130f7..0000000000
--- a/host/include/i386/host/crypto/aes-round.h
+++ /dev/null
@@ -1,152 +0,0 @@
-/*
- * x86 specific aes acceleration.
- * SPDX-License-Identifier: GPL-2.0-or-later
- */
-
-#ifndef X86_HOST_CRYPTO_AES_ROUND_H
-#define X86_HOST_CRYPTO_AES_ROUND_H
-
-#include "host/cpuinfo.h"
-#include <immintrin.h>
-
-#if defined(__AES__) && defined(__SSSE3__)
-# define HAVE_AES_ACCEL  true
-# define ATTR_AES_ACCEL
-#else
-# define HAVE_AES_ACCEL  likely(cpuinfo & CPUINFO_AES)
-# define ATTR_AES_ACCEL  __attribute__((target("aes,ssse3")))
-#endif
-
-static inline __m128i ATTR_AES_ACCEL
-aes_accel_bswap(__m128i x)
-{
-    return _mm_shuffle_epi8(x, _mm_set_epi8(0, 1, 2, 3, 4, 5, 6, 7, 8,
-                                            9, 10, 11, 12, 13, 14, 15));
-}
-
-static inline void ATTR_AES_ACCEL
-aesenc_MC_accel(AESState *ret, const AESState *st, bool be)
-{
-    __m128i t = (__m128i)st->v;
-    __m128i z = _mm_setzero_si128();
-
-    if (be) {
-        t = aes_accel_bswap(t);
-        t = _mm_aesdeclast_si128(t, z);
-        t = _mm_aesenc_si128(t, z);
-        t = aes_accel_bswap(t);
-    } else {
-        t = _mm_aesdeclast_si128(t, z);
-        t = _mm_aesenc_si128(t, z);
-    }
-    ret->v = (AESStateVec)t;
-}
-
-static inline void ATTR_AES_ACCEL
-aesenc_SB_SR_AK_accel(AESState *ret, const AESState *st,
-                      const AESState *rk, bool be)
-{
-    __m128i t = (__m128i)st->v;
-    __m128i k = (__m128i)rk->v;
-
-    if (be) {
-        t = aes_accel_bswap(t);
-        k = aes_accel_bswap(k);
-        t = _mm_aesenclast_si128(t, k);
-        t = aes_accel_bswap(t);
-    } else {
-        t = _mm_aesenclast_si128(t, k);
-    }
-    ret->v = (AESStateVec)t;
-}
-
-static inline void ATTR_AES_ACCEL
-aesenc_SB_SR_MC_AK_accel(AESState *ret, const AESState *st,
-                         const AESState *rk, bool be)
-{
-    __m128i t = (__m128i)st->v;
-    __m128i k = (__m128i)rk->v;
-
-    if (be) {
-        t = aes_accel_bswap(t);
-        k = aes_accel_bswap(k);
-        t = _mm_aesenc_si128(t, k);
-        t = aes_accel_bswap(t);
-    } else {
-        t = _mm_aesenc_si128(t, k);
-    }
-    ret->v = (AESStateVec)t;
-}
-
-static inline void ATTR_AES_ACCEL
-aesdec_IMC_accel(AESState *ret, const AESState *st, bool be)
-{
-    __m128i t = (__m128i)st->v;
-
-    if (be) {
-        t = aes_accel_bswap(t);
-        t = _mm_aesimc_si128(t);
-        t = aes_accel_bswap(t);
-    } else {
-        t = _mm_aesimc_si128(t);
-    }
-    ret->v = (AESStateVec)t;
-}
-
-static inline void ATTR_AES_ACCEL
-aesdec_ISB_ISR_AK_accel(AESState *ret, const AESState *st,
-                        const AESState *rk, bool be)
-{
-    __m128i t = (__m128i)st->v;
-    __m128i k = (__m128i)rk->v;
-
-    if (be) {
-        t = aes_accel_bswap(t);
-        k = aes_accel_bswap(k);
-        t = _mm_aesdeclast_si128(t, k);
-        t = aes_accel_bswap(t);
-    } else {
-        t = _mm_aesdeclast_si128(t, k);
-    }
-    ret->v = (AESStateVec)t;
-}
-
-static inline void ATTR_AES_ACCEL
-aesdec_ISB_ISR_AK_IMC_accel(AESState *ret, const AESState *st,
-                            const AESState *rk, bool be)
-{
-    __m128i t = (__m128i)st->v;
-    __m128i k = (__m128i)rk->v;
-
-    if (be) {
-        t = aes_accel_bswap(t);
-        k = aes_accel_bswap(k);
-        t = _mm_aesdeclast_si128(t, k);
-        t = _mm_aesimc_si128(t);
-        t = aes_accel_bswap(t);
-    } else {
-        t = _mm_aesdeclast_si128(t, k);
-        t = _mm_aesimc_si128(t);
-    }
-    ret->v = (AESStateVec)t;
-}
-
-static inline void ATTR_AES_ACCEL
-aesdec_ISB_ISR_IMC_AK_accel(AESState *ret, const AESState *st,
-                            const AESState *rk, bool be)
-{
-    __m128i t = (__m128i)st->v;
-    __m128i k = (__m128i)rk->v;
-
-    if (be) {
-        t = aes_accel_bswap(t);
-        k = aes_accel_bswap(k);
-        t = _mm_aesdec_si128(t, k);
-        t = aes_accel_bswap(t);
-    } else {
-        t = _mm_aesdec_si128(t, k);
-    }
-    ret->v = (AESStateVec)t;
-}
-
-#endif /* X86_HOST_CRYPTO_AES_ROUND_H */
diff --git a/host/include/i386/host/crypto/clmul.h b/host/include/i386/host/crypto/clmul.h
deleted file mode 100644
index dc3c814797..0000000000
--- a/host/include/i386/host/crypto/clmul.h
+++ /dev/null
@@ -1,29 +0,0 @@
-/*
- * x86 specific clmul acceleration.
- * SPDX-License-Identifier: GPL-2.0-or-later
- */
-
-#ifndef X86_HOST_CRYPTO_CLMUL_H
-#define X86_HOST_CRYPTO_CLMUL_H
-
-#include "host/cpuinfo.h"
-#include <immintrin.h>
-
-#if defined(__PCLMUL__)
-# define HAVE_CLMUL_ACCEL  true
-# define ATTR_CLMUL_ACCEL
-#else
-# define HAVE_CLMUL_ACCEL  likely(cpuinfo & CPUINFO_PCLMUL)
-# define ATTR_CLMUL_ACCEL  __attribute__((target("pclmul")))
-#endif
-
-static inline Int128 ATTR_CLMUL_ACCEL
-clmul_64_accel(uint64_t n, uint64_t m)
-{
-    union { __m128i v; Int128 s; } u;
-
-    u.v = _mm_clmulepi64_si128(_mm_set_epi64x(0, n), _mm_set_epi64x(0, m), 0);
-    return u.s;
-}
-
-#endif /* X86_HOST_CRYPTO_CLMUL_H */
diff --git a/host/include/x86_64/host/cpuinfo.h b/host/include/x86_64/host/cpuinfo.h
index 67debab9a0..93d029d499 100644
--- a/host/include/x86_64/host/cpuinfo.h
+++ b/host/include/x86_64/host/cpuinfo.h
@@ -1 +1,41 @@
-#include "host/include/i386/host/cpuinfo.h"
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ * Host specific cpu identification for x86.
+ */
+
+#ifndef HOST_CPUINFO_H
+#define HOST_CPUINFO_H
+
+/* Digested version of <cpuid.h> */
+
+#define CPUINFO_ALWAYS          (1u << 0)  /* so cpuinfo is nonzero */
+#define CPUINFO_OSXSAVE         (1u << 1)
+#define CPUINFO_MOVBE           (1u << 2)
+#define CPUINFO_LZCNT           (1u << 3)
+#define CPUINFO_POPCNT          (1u << 4)
+#define CPUINFO_BMI1            (1u << 5)
+#define CPUINFO_BMI2            (1u << 6)
+#define CPUINFO_SSE2            (1u << 7)
+#define CPUINFO_AVX1            (1u << 9)
+#define CPUINFO_AVX2            (1u << 10)
+#define CPUINFO_AVX512F         (1u << 11)
+#define CPUINFO_AVX512VL        (1u << 12)
+#define CPUINFO_AVX512BW        (1u << 13)
+#define CPUINFO_AVX512DQ        (1u << 14)
+#define CPUINFO_AVX512VBMI2     (1u << 15)
+#define CPUINFO_ATOMIC_VMOVDQA  (1u << 16)
+#define CPUINFO_ATOMIC_VMOVDQU  (1u << 17)
+#define CPUINFO_AES             (1u << 18)
+#define CPUINFO_PCLMUL          (1u << 19)
+#define CPUINFO_GFNI            (1u << 20)
+
+/* Initialized with a constructor. */
+extern unsigned cpuinfo;
+
+/*
+ * We cannot rely on constructor ordering, so other constructors must
+ * use the function interface rather than the variable above.
+ */
+unsigned cpuinfo_init(void);
+
+#endif /* HOST_CPUINFO_H */
diff --git a/host/include/x86_64/host/crypto/aes-round.h b/host/include/x86_64/host/crypto/aes-round.h
index 2773cc9f10..59a64130f7 100644
--- a/host/include/x86_64/host/crypto/aes-round.h
+++ b/host/include/x86_64/host/crypto/aes-round.h
@@ -1 +1,152 @@
-#include "host/include/i386/host/crypto/aes-round.h"
+/*
+ * x86 specific aes acceleration.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef X86_HOST_CRYPTO_AES_ROUND_H
+#define X86_HOST_CRYPTO_AES_ROUND_H
+
+#include "host/cpuinfo.h"
+#include <immintrin.h>
+
+#if defined(__AES__) && defined(__SSSE3__)
+# define HAVE_AES_ACCEL  true
+# define ATTR_AES_ACCEL
+#else
+# define HAVE_AES_ACCEL  likely(cpuinfo & CPUINFO_AES)
+# define ATTR_AES_ACCEL  __attribute__((target("aes,ssse3")))
+#endif
+
+static inline __m128i ATTR_AES_ACCEL
+aes_accel_bswap(__m128i x)
+{
+    return _mm_shuffle_epi8(x, _mm_set_epi8(0, 1, 2, 3, 4, 5, 6, 7, 8,
+                                            9, 10, 11, 12, 13, 14, 15));
+}
+
+static inline void ATTR_AES_ACCEL
+aesenc_MC_accel(AESState *ret, const AESState *st, bool be)
+{
+    __m128i t = (__m128i)st->v;
+    __m128i z = _mm_setzero_si128();
+
+    if (be) {
+        t = aes_accel_bswap(t);
+        t = _mm_aesdeclast_si128(t, z);
+        t = _mm_aesenc_si128(t, z);
+        t = aes_accel_bswap(t);
+    } else {
+        t = _mm_aesdeclast_si128(t, z);
+        t = _mm_aesenc_si128(t, z);
+    }
+    ret->v = (AESStateVec)t;
+}
+
+static inline void ATTR_AES_ACCEL
+aesenc_SB_SR_AK_accel(AESState *ret, const AESState *st,
+                      const AESState *rk, bool be)
+{
+    __m128i t = (__m128i)st->v;
+    __m128i k = (__m128i)rk->v;
+
+    if (be) {
+        t = aes_accel_bswap(t);
+        k = aes_accel_bswap(k);
+        t = _mm_aesenclast_si128(t, k);
+        t = aes_accel_bswap(t);
+    } else {
+        t = _mm_aesenclast_si128(t, k);
+    }
+    ret->v = (AESStateVec)t;
+}
+
+static inline void ATTR_AES_ACCEL
+aesenc_SB_SR_MC_AK_accel(AESState *ret, const AESState *st,
+                         const AESState *rk, bool be)
+{
+    __m128i t = (__m128i)st->v;
+    __m128i k = (__m128i)rk->v;
+
+    if (be) {
+        t = aes_accel_bswap(t);
+        k = aes_accel_bswap(k);
+        t = _mm_aesenc_si128(t, k);
+        t = aes_accel_bswap(t);
+    } else {
+        t = _mm_aesenc_si128(t, k);
+    }
+    ret->v = (AESStateVec)t;
+}
+
+static inline void ATTR_AES_ACCEL
+aesdec_IMC_accel(AESState *ret, const AESState *st, bool be)
+{
+    __m128i t = (__m128i)st->v;
+
+    if (be) {
+        t = aes_accel_bswap(t);
+        t = _mm_aesimc_si128(t);
+        t = aes_accel_bswap(t);
+    } else {
+        t = _mm_aesimc_si128(t);
+    }
+    ret->v = (AESStateVec)t;
+}
+
+static inline void ATTR_AES_ACCEL
+aesdec_ISB_ISR_AK_accel(AESState *ret, const AESState *st,
+                        const AESState *rk, bool be)
+{
+    __m128i t = (__m128i)st->v;
+    __m128i k = (__m128i)rk->v;
+
+    if (be) {
+        t = aes_accel_bswap(t);
+        k = aes_accel_bswap(k);
+        t = _mm_aesdeclast_si128(t, k);
+        t = aes_accel_bswap(t);
+    } else {
+        t = _mm_aesdeclast_si128(t, k);
+    }
+    ret->v = (AESStateVec)t;
+}
+
+static inline void ATTR_AES_ACCEL
+aesdec_ISB_ISR_AK_IMC_accel(AESState *ret, const AESState *st,
+                            const AESState *rk, bool be)
+{
+    __m128i t = (__m128i)st->v;
+    __m128i k = (__m128i)rk->v;
+
+    if (be) {
+        t = aes_accel_bswap(t);
+        k = aes_accel_bswap(k);
+        t = _mm_aesdeclast_si128(t, k);
+        t = _mm_aesimc_si128(t);
+        t = aes_accel_bswap(t);
+    } else {
+        t = _mm_aesdeclast_si128(t, k);
+        t = _mm_aesimc_si128(t);
+    }
+    ret->v = (AESStateVec)t;
+}
+
+static inline void ATTR_AES_ACCEL
+aesdec_ISB_ISR_IMC_AK_accel(AESState *ret, const AESState *st,
+                            const AESState *rk, bool be)
+{
+    __m128i t = (__m128i)st->v;
+    __m128i k = (__m128i)rk->v;
+
+    if (be) {
+        t = aes_accel_bswap(t);
+        k = aes_accel_bswap(k);
+        t = _mm_aesdec_si128(t, k);
+        t = aes_accel_bswap(t);
+    } else {
+        t = _mm_aesdec_si128(t, k);
+    }
+    ret->v = (AESStateVec)t;
+}
+
+#endif /* X86_HOST_CRYPTO_AES_ROUND_H */
diff --git a/host/include/x86_64/host/crypto/clmul.h b/host/include/x86_64/host/crypto/clmul.h
index f25eced416..dc3c814797 100644
--- a/host/include/x86_64/host/crypto/clmul.h
+++ b/host/include/x86_64/host/crypto/clmul.h
@@ -1 +1,29 @@
-#include "host/include/i386/host/crypto/clmul.h"
+/*
+ * x86 specific clmul acceleration.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef X86_HOST_CRYPTO_CLMUL_H
+#define X86_HOST_CRYPTO_CLMUL_H
+
+#include "host/cpuinfo.h"
+#include <immintrin.h>
+
+#if defined(__PCLMUL__)
+# define HAVE_CLMUL_ACCEL  true
+# define ATTR_CLMUL_ACCEL
+#else
+# define HAVE_CLMUL_ACCEL  likely(cpuinfo & CPUINFO_PCLMUL)
+# define ATTR_CLMUL_ACCEL  __attribute__((target("pclmul")))
+#endif
+
+static inline Int128 ATTR_CLMUL_ACCEL
+clmul_64_accel(uint64_t n, uint64_t m)
+{
+    union { __m128i v; Int128 s; } u;
+
+    u.v = _mm_clmulepi64_si128(_mm_set_epi64x(0, n), _mm_set_epi64x(0, m), 0);
+    return u.s;
+}
+
+#endif /* X86_HOST_CRYPTO_CLMUL_H */
diff --git a/linux-user/include/host/i386/host-signal.h b/linux-user/include/host/i386/host-signal.h
deleted file mode 100644
index e2b64f077f..0000000000
--- a/linux-user/include/host/i386/host-signal.h
+++ /dev/null
@@ -1,38 +0,0 @@
-/*
- * host-signal.h: signal info dependent on the host architecture
- *
- * Copyright (c) 2003-2005 Fabrice Bellard
- * Copyright (c) 2021 Linaro Limited
- *
- * This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
- * See the COPYING file in the top-level directory.
- */
-
-#ifndef I386_HOST_SIGNAL_H
-#define I386_HOST_SIGNAL_H
-
-/* The third argument to a SA_SIGINFO handler is ucontext_t. */
-typedef ucontext_t host_sigcontext;
-
-static inline uintptr_t host_signal_pc(host_sigcontext *uc)
-{
-    return uc->uc_mcontext.gregs[REG_EIP];
-}
-
-static inline void host_signal_set_pc(host_sigcontext *uc, uintptr_t pc)
-{
-    uc->uc_mcontext.gregs[REG_EIP] = pc;
-}
-
-static inline void *host_signal_mask(host_sigcontext *uc)
-{
-    return &uc->uc_sigmask;
-}
-
-static inline bool host_signal_write(siginfo_t *info, host_sigcontext *uc)
-{
-    return uc->uc_mcontext.gregs[REG_TRAPNO] == 0xe
-        && (uc->uc_mcontext.gregs[REG_ERR] & 0x2);
-}
-
-#endif
diff --git a/common-user/host/i386/safe-syscall.inc.S b/common-user/host/i386/safe-syscall.inc.S
deleted file mode 100644
index db2ed09839..0000000000
--- a/common-user/host/i386/safe-syscall.inc.S
+++ /dev/null
@@ -1,127 +0,0 @@
-/*
- * safe-syscall.inc.S : host-specific assembly fragment
- * to handle signals occurring at the same time as system calls.
- * This is intended to be included by common-user/safe-syscall.S
- *
- * Written by Richard Henderson <rth@twiddle.net>
- * Copyright (C) 2016 Red Hat, Inc.
- *
- * This work is licensed under the terms of the GNU GPL, version 2 or later.
- * See the COPYING file in the top-level directory.
- */
-
-        .global safe_syscall_base
-        .global safe_syscall_start
-        .global safe_syscall_end
-        .type   safe_syscall_base, @function
-
-        /* This is the entry point for making a system call. The calling
-         * convention here is that of a C varargs function with the
-         * first argument an 'int *' to the signal_pending flag, the
-         * second one the system call number (as a 'long'), and all further
-         * arguments being syscall arguments (also 'long').
-         */
-safe_syscall_base:
-        .cfi_startproc
-        push    %ebp
-        .cfi_adjust_cfa_offset 4
-        .cfi_rel_offset ebp, 0
-        push    %esi
-        .cfi_adjust_cfa_offset 4
-        .cfi_rel_offset esi, 0
-        push    %edi
-        .cfi_adjust_cfa_offset 4
-        .cfi_rel_offset edi, 0
-        push    %ebx
-        .cfi_adjust_cfa_offset 4
-        .cfi_rel_offset ebx, 0
-
-        /* The syscall calling convention isn't the same as the C one:
-         * we enter with 0(%esp) == return address
-         *               4(%esp) == &signal_pending
-         *               8(%esp) == syscall number
-         *               12(%esp) ... 32(%esp) == syscall arguments
-         *               and return the result in eax
-         * and the syscall instruction needs
-         *               eax == syscall number
-         *               ebx, ecx, edx, esi, edi, ebp == syscall arguments
-         *               and returns the result in eax
-         * Shuffle everything around appropriately.
-         * Note the 16 bytes that we pushed to save registers.
-         */
-        mov     12+16(%esp), %ebx       /* the syscall arguments */
-        mov     16+16(%esp), %ecx
-        mov     20+16(%esp), %edx
-        mov     24+16(%esp), %esi
-        mov     28+16(%esp), %edi
-        mov     32+16(%esp), %ebp
-
-        /* This next sequence of code works in conjunction with the
-         * rewind_if_safe_syscall_function(). If a signal is taken
-         * and the interrupted PC is anywhere between 'safe_syscall_start'
-         * and 'safe_syscall_end' then we rewind it to 'safe_syscall_start'.
-         * The code sequence must therefore be able to cope with this, and
-         * the syscall instruction must be the final one in the sequence.
-         */
-safe_syscall_start:
-        /* if signal_pending is non-zero, don't do the call */
-        mov     4+16(%esp), %eax        /* signal_pending */
-        cmpl    $0, (%eax)
-        jnz     2f
-        mov     8+16(%esp), %eax        /* syscall number */
-        int     $0x80
-safe_syscall_end:
-
-        /* code path for having successfully executed the syscall */
-#if defined(__linux__)
-        /* Linux kernel returns (small) negative errno. */
-        cmp     $-4095, %eax
-        jae     0f
-#elif defined(__FreeBSD__)
-        /* FreeBSD kernel returns positive errno and C bit set. */
-        jc      1f
-#else
-#error "unsupported os"
-#endif
-        pop     %ebx
-        .cfi_remember_state
-        .cfi_adjust_cfa_offset -4
-        .cfi_restore ebx
-        pop     %edi
-        .cfi_adjust_cfa_offset -4
-        .cfi_restore edi
-        pop     %esi
-        .cfi_adjust_cfa_offset -4
-        .cfi_restore esi
-        pop     %ebp
-        .cfi_adjust_cfa_offset -4
-        .cfi_restore ebp
-        ret
-        .cfi_restore_state
-
-#if defined(__linux__)
-0:      neg     %eax
-        jmp     1f
-#endif
-
-        /* code path when we didn't execute the syscall */
-2:      mov     $QEMU_ERESTARTSYS, %eax
-
-        /* code path setting errno */
-1:      pop     %ebx
-        .cfi_adjust_cfa_offset -4
-        .cfi_restore ebx
-        pop     %edi
-        .cfi_adjust_cfa_offset -4
-        .cfi_restore edi
-        pop     %esi
-        .cfi_adjust_cfa_offset -4
-        .cfi_restore esi
-        pop     %ebp
-        .cfi_adjust_cfa_offset -4
-        .cfi_restore ebp
-        mov     %eax, 4(%esp)
-        jmp     safe_syscall_set_errno_tail
-
-        .cfi_endproc
-        .size   safe_syscall_base, .-safe_syscall_base
diff --git a/host/include/i386/host/bufferiszero.c.inc b/host/include/i386/host/bufferiszero.c.inc
deleted file mode 100644
index 74ae98580f..0000000000
--- a/host/include/i386/host/bufferiszero.c.inc
+++ /dev/null
@@ -1,125 +0,0 @@
-/*
- * SPDX-License-Identifier: GPL-2.0-or-later
- * buffer_is_zero acceleration, x86 version.
- */
-
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
-    unsigned info = cpuinfo_init();
-
-#ifdef CONFIG_AVX2_OPT
-    if (info & CPUINFO_AVX2) {
-        return 2;
-    }
-#endif
-    return info & CPUINFO_SSE2 ? 1 : 0;
-}
-
-#else
-# include "host/include/generic/host/bufferiszero.c.inc"
-#endif
diff --git a/host/include/x86_64/host/bufferiszero.c.inc b/host/include/x86_64/host/bufferiszero.c.inc
index 1d3f1fd6f5..74ae98580f 100644
--- a/host/include/x86_64/host/bufferiszero.c.inc
+++ b/host/include/x86_64/host/bufferiszero.c.inc
@@ -1 +1,125 @@
-#include "host/include/i386/host/bufferiszero.c.inc"
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
+    unsigned info = cpuinfo_init();
+
+#ifdef CONFIG_AVX2_OPT
+    if (info & CPUINFO_AVX2) {
+        return 2;
+    }
+#endif
+    return info & CPUINFO_SSE2 ? 1 : 0;
+}
+
+#else
+# include "host/include/generic/host/bufferiszero.c.inc"
+#endif
-- 
2.43.0


