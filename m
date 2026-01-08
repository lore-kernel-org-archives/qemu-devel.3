Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74A7BD148A0
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 05:33:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdibm-0005HU-Al; Thu, 08 Jan 2026 00:30:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vdibi-0005BX-1T
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 00:30:51 -0500
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vdibc-0005KL-4l
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 00:30:48 -0500
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-c2af7d09533so1778445a12.1
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 21:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767850242; x=1768455042; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZaPshFkOehiy4SfJsOubQBhblv7XOM5ZxOMG065s9PI=;
 b=AK4wYParDan5fctboxa21Pb+6xi/zfcROZMB0ztbSVuGR/t4fguQn4xr/4zALNp8KN
 NAqmiDnqU5mT/wIhrRo0OwfDUV4MKkcVO4krv8lQAVZiUViUMMAAKWUCfmJAisEuIHxJ
 MRj05/Dr114g6IdUjqDoki26uc7xJWiY+q2zKL+v7Q52APgVNns5qXZ2wN7NJFlVmWF7
 IygLy39aBkekdC0Patw/p17/JX4CbcDYRR+JOXgz4LnVtPZmeZ3bjnoSc0W05N9Zd7P6
 V5qg3RMHWHPAO6c74NBvs9MgXNtYALr6rKTupPIdfsFXzusf7RUsVzp+wRUuORr42iSV
 Gnvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767850242; x=1768455042;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ZaPshFkOehiy4SfJsOubQBhblv7XOM5ZxOMG065s9PI=;
 b=f5223X9g6Ao/Q8aBEe6KXR5ayR6gDkRQxRo91cnLyTCCqro4il+A46adjQffqZJ9a0
 /fM8rzlcZmKwTyEfLWpSj/81CC/4w20EiW0YMvi4fwmoivyVeRQptVqDEZd214Eo7q17
 8OAXxTfAStQKvDqfGS+9K1rDUM/y6OWJvt0d0EmG3Th4w85wFlYdffng4kKHWclnxKgx
 GCoQDPLDtgyfjk8JHuHpmhi0KZRfjblNz0G7M91/RLPF5trHj97K2TBdPFKguUprTGfe
 JDQOF09dwAHvjISyOoWGOSWCUaAQQ2OHWUW0Y99B2kcl5kGSXgqDKkugfiNCvpk57NlF
 8AIw==
X-Gm-Message-State: AOJu0YxW4v5Piai2byv0XFucqlHJr9B1Kj9SkmI4+7ddY0n4F5VzOxIz
 V07/QqM7vPbX2AOjK1TMM5TlvvX+TnEXwMr/bW8wJxyBaGeBD8OQEx0HPdMF4gvkSnAQgTqWETj
 2UgSdsDA=
X-Gm-Gg: AY/fxX6g/cHW5AplfLwt9UITawKj2YbJ+YbwMXLoMSwiuwltoe+MmQb962uHIct1bCR
 aN9sMIe5qppnr38gIjWKVWgJ2S2oK+Q0qP/Ksr0G2kZqVDi+xYWgePE0PZeoCQunomddrtNSqh2
 zqWFBWuIZgLc1InrYGPlOG0ulbceLfOSDnRFJOiDt5TRvOa8tAVz6DsV8zxKUgL7qzmdCt/tc3U
 skdxHxXyHOvkBmnxUX6hZ8ZxEaSUTR8yBW2PHiJXic83ph+yXy6oRk2Ju1P8LBfJf5Z7dwOXIPd
 1QvAfHLONq+7kt5hWi61j975bXcgYQzUtTzERuQPMzW5L8J6KE4Ty+B/nkl3C+L84gHDFsNC0M5
 Ue0DicFPA97F756klGby0A9c0Z2MPkzEM96lSkBQOVHYGScb3llPMG3HORFI8QYKDiahin2z7lU
 gykLxHKx0vzEo0+C5JJA==
X-Google-Smtp-Source: AGHT+IEFK2HdTgIgT1w+B75b27Ogw6cdE/ZCFsG23v0qpyQ5dE8okzwYDP3Bt0FPCYWdAdGZNzeRZQ==
X-Received: by 2002:a05:6a20:3956:b0:35d:cc9a:8bbb with SMTP id
 adf61e73a8af0-3898f992296mr4562445637.47.1767850241908; 
 Wed, 07 Jan 2026 21:30:41 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cc05cd9d9sm7036552a12.16.2026.01.07.21.30.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jan 2026 21:30:41 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 09/50] *: Remove ppc host support
Date: Thu,  8 Jan 2026 16:29:37 +1100
Message-ID: <20260108053018.626690-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108053018.626690-1-richard.henderson@linaro.org>
References: <20260108053018.626690-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
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

Move the files from host/include/ppc to host/include/ppc64,
replacing the stub headers that redirected to ppc.

Remove linux-user/include/host/ppc.
Remove common-user/host/ppc.
Remove cpu == ppc tests from meson.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 host/include/ppc/host/cpuinfo.h            |  30 ----
 host/include/ppc/host/crypto/aes-round.h   | 182 --------------------
 host/include/ppc64/host/cpuinfo.h          |  31 +++-
 host/include/ppc64/host/crypto/aes-round.h | 183 ++++++++++++++++++++-
 linux-user/include/host/ppc/host-signal.h  |  39 -----
 common-user/host/ppc/safe-syscall.inc.S    | 107 ------------
 meson.build                                |   4 +-
 7 files changed, 213 insertions(+), 363 deletions(-)
 delete mode 100644 host/include/ppc/host/cpuinfo.h
 delete mode 100644 host/include/ppc/host/crypto/aes-round.h
 delete mode 100644 linux-user/include/host/ppc/host-signal.h
 delete mode 100644 common-user/host/ppc/safe-syscall.inc.S

diff --git a/host/include/ppc/host/cpuinfo.h b/host/include/ppc/host/cpuinfo.h
deleted file mode 100644
index 38b8eabe2a..0000000000
--- a/host/include/ppc/host/cpuinfo.h
+++ /dev/null
@@ -1,30 +0,0 @@
-/*
- * SPDX-License-Identifier: GPL-2.0-or-later
- * Host specific cpu identification for ppc.
- */
-
-#ifndef HOST_CPUINFO_H
-#define HOST_CPUINFO_H
-
-/* Digested version of <cpuid.h> */
-
-#define CPUINFO_ALWAYS          (1u << 0)  /* so cpuinfo is nonzero */
-#define CPUINFO_V2_06           (1u << 1)
-#define CPUINFO_V2_07           (1u << 2)
-#define CPUINFO_V3_0            (1u << 3)
-#define CPUINFO_V3_1            (1u << 4)
-#define CPUINFO_ISEL            (1u << 5)
-#define CPUINFO_ALTIVEC         (1u << 6)
-#define CPUINFO_VSX             (1u << 7)
-#define CPUINFO_CRYPTO          (1u << 8)
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
diff --git a/host/include/ppc/host/crypto/aes-round.h b/host/include/ppc/host/crypto/aes-round.h
deleted file mode 100644
index 8062d2a537..0000000000
--- a/host/include/ppc/host/crypto/aes-round.h
+++ /dev/null
@@ -1,182 +0,0 @@
-/*
- * Power v2.07 specific aes acceleration.
- * SPDX-License-Identifier: GPL-2.0-or-later
- */
-
-#ifndef PPC_HOST_CRYPTO_AES_ROUND_H
-#define PPC_HOST_CRYPTO_AES_ROUND_H
-
-#ifdef __ALTIVEC__
-#include "host/cpuinfo.h"
-
-#ifdef __CRYPTO__
-# define HAVE_AES_ACCEL  true
-#else
-# define HAVE_AES_ACCEL  likely(cpuinfo & CPUINFO_CRYPTO)
-#endif
-#define ATTR_AES_ACCEL
-
-/*
- * While there is <altivec.h>, both gcc and clang "aid" with the
- * endianness issues in different ways. Just use inline asm instead.
- */
-
-/* Bytes in memory are host-endian; bytes in register are @be. */
-static inline AESStateVec aes_accel_ld(const AESState *p, bool be)
-{
-    AESStateVec r;
-
-    if (be) {
-        asm("lvx %0, 0, %1" : "=v"(r) : "r"(p), "m"(*p));
-    } else if (HOST_BIG_ENDIAN) {
-        AESStateVec rev = {
-            15, 14, 13, 12, 11, 10, 9, 8, 7,  6,  5,  4,  3,  2,  1,  0,
-        };
-        asm("lvx %0, 0, %1\n\t"
-            "vperm %0, %0, %0, %2"
-            : "=v"(r) : "r"(p), "v"(rev), "m"(*p));
-    } else {
-#ifdef __POWER9_VECTOR__
-        asm("lxvb16x %x0, 0, %1" : "=v"(r) : "r"(p), "m"(*p));
-#else
-        asm("lxvd2x %x0, 0, %1\n\t"
-            "xxpermdi %x0, %x0, %x0, 2"
-            : "=v"(r) : "r"(p), "m"(*p));
-#endif
-    }
-    return r;
-}
-
-static void aes_accel_st(AESState *p, AESStateVec r, bool be)
-{
-    if (be) {
-        asm("stvx %1, 0, %2" : "=m"(*p) : "v"(r), "r"(p));
-    } else if (HOST_BIG_ENDIAN) {
-        AESStateVec rev = {
-            15, 14, 13, 12, 11, 10, 9, 8, 7,  6,  5,  4,  3,  2,  1,  0,
-        };
-        asm("vperm %1, %1, %1, %2\n\t"
-            "stvx %1, 0, %3"
-            : "=m"(*p), "+v"(r) : "v"(rev), "r"(p));
-    } else {
-#ifdef __POWER9_VECTOR__
-        asm("stxvb16x %x1, 0, %2" : "=m"(*p) : "v"(r), "r"(p));
-#else
-        asm("xxpermdi %x1, %x1, %x1, 2\n\t"
-            "stxvd2x %x1, 0, %2"
-            : "=m"(*p), "+v"(r) : "r"(p));
-#endif
-    }
-}
-
-static inline AESStateVec aes_accel_vcipher(AESStateVec d, AESStateVec k)
-{
-    asm("vcipher %0, %0, %1" : "+v"(d) : "v"(k));
-    return d;
-}
-
-static inline AESStateVec aes_accel_vncipher(AESStateVec d, AESStateVec k)
-{
-    asm("vncipher %0, %0, %1" : "+v"(d) : "v"(k));
-    return d;
-}
-
-static inline AESStateVec aes_accel_vcipherlast(AESStateVec d, AESStateVec k)
-{
-    asm("vcipherlast %0, %0, %1" : "+v"(d) : "v"(k));
-    return d;
-}
-
-static inline AESStateVec aes_accel_vncipherlast(AESStateVec d, AESStateVec k)
-{
-    asm("vncipherlast %0, %0, %1" : "+v"(d) : "v"(k));
-    return d;
-}
-
-static inline void
-aesenc_MC_accel(AESState *ret, const AESState *st, bool be)
-{
-    AESStateVec t, z = { };
-
-    t = aes_accel_ld(st, be);
-    t = aes_accel_vncipherlast(t, z);
-    t = aes_accel_vcipher(t, z);
-    aes_accel_st(ret, t, be);
-}
-
-static inline void
-aesenc_SB_SR_AK_accel(AESState *ret, const AESState *st,
-                      const AESState *rk, bool be)
-{
-    AESStateVec t, k;
-
-    t = aes_accel_ld(st, be);
-    k = aes_accel_ld(rk, be);
-    t = aes_accel_vcipherlast(t, k);
-    aes_accel_st(ret, t, be);
-}
-
-static inline void
-aesenc_SB_SR_MC_AK_accel(AESState *ret, const AESState *st,
-                         const AESState *rk, bool be)
-{
-    AESStateVec t, k;
-
-    t = aes_accel_ld(st, be);
-    k = aes_accel_ld(rk, be);
-    t = aes_accel_vcipher(t, k);
-    aes_accel_st(ret, t, be);
-}
-
-static inline void
-aesdec_IMC_accel(AESState *ret, const AESState *st, bool be)
-{
-    AESStateVec t, z = { };
-
-    t = aes_accel_ld(st, be);
-    t = aes_accel_vcipherlast(t, z);
-    t = aes_accel_vncipher(t, z);
-    aes_accel_st(ret, t, be);
-}
-
-static inline void
-aesdec_ISB_ISR_AK_accel(AESState *ret, const AESState *st,
-                        const AESState *rk, bool be)
-{
-    AESStateVec t, k;
-
-    t = aes_accel_ld(st, be);
-    k = aes_accel_ld(rk, be);
-    t = aes_accel_vncipherlast(t, k);
-    aes_accel_st(ret, t, be);
-}
-
-static inline void
-aesdec_ISB_ISR_AK_IMC_accel(AESState *ret, const AESState *st,
-                            const AESState *rk, bool be)
-{
-    AESStateVec t, k;
-
-    t = aes_accel_ld(st, be);
-    k = aes_accel_ld(rk, be);
-    t = aes_accel_vncipher(t, k);
-    aes_accel_st(ret, t, be);
-}
-
-static inline void
-aesdec_ISB_ISR_IMC_AK_accel(AESState *ret, const AESState *st,
-                            const AESState *rk, bool be)
-{
-    AESStateVec t, k, z = { };
-
-    t = aes_accel_ld(st, be);
-    k = aes_accel_ld(rk, be);
-    t = aes_accel_vncipher(t, z);
-    aes_accel_st(ret, t ^ k, be);
-}
-#else
-/* Without ALTIVEC, we can't even write inline assembly. */
-#include "host/include/generic/host/crypto/aes-round.h"
-#endif
-
-#endif /* PPC_HOST_CRYPTO_AES_ROUND_H */
diff --git a/host/include/ppc64/host/cpuinfo.h b/host/include/ppc64/host/cpuinfo.h
index 2f036a0627..38b8eabe2a 100644
--- a/host/include/ppc64/host/cpuinfo.h
+++ b/host/include/ppc64/host/cpuinfo.h
@@ -1 +1,30 @@
-#include "host/include/ppc/host/cpuinfo.h"
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ * Host specific cpu identification for ppc.
+ */
+
+#ifndef HOST_CPUINFO_H
+#define HOST_CPUINFO_H
+
+/* Digested version of <cpuid.h> */
+
+#define CPUINFO_ALWAYS          (1u << 0)  /* so cpuinfo is nonzero */
+#define CPUINFO_V2_06           (1u << 1)
+#define CPUINFO_V2_07           (1u << 2)
+#define CPUINFO_V3_0            (1u << 3)
+#define CPUINFO_V3_1            (1u << 4)
+#define CPUINFO_ISEL            (1u << 5)
+#define CPUINFO_ALTIVEC         (1u << 6)
+#define CPUINFO_VSX             (1u << 7)
+#define CPUINFO_CRYPTO          (1u << 8)
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
diff --git a/host/include/ppc64/host/crypto/aes-round.h b/host/include/ppc64/host/crypto/aes-round.h
index 5eeba6dcb7..8062d2a537 100644
--- a/host/include/ppc64/host/crypto/aes-round.h
+++ b/host/include/ppc64/host/crypto/aes-round.h
@@ -1 +1,182 @@
-#include "host/include/ppc/host/crypto/aes-round.h"
+/*
+ * Power v2.07 specific aes acceleration.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef PPC_HOST_CRYPTO_AES_ROUND_H
+#define PPC_HOST_CRYPTO_AES_ROUND_H
+
+#ifdef __ALTIVEC__
+#include "host/cpuinfo.h"
+
+#ifdef __CRYPTO__
+# define HAVE_AES_ACCEL  true
+#else
+# define HAVE_AES_ACCEL  likely(cpuinfo & CPUINFO_CRYPTO)
+#endif
+#define ATTR_AES_ACCEL
+
+/*
+ * While there is <altivec.h>, both gcc and clang "aid" with the
+ * endianness issues in different ways. Just use inline asm instead.
+ */
+
+/* Bytes in memory are host-endian; bytes in register are @be. */
+static inline AESStateVec aes_accel_ld(const AESState *p, bool be)
+{
+    AESStateVec r;
+
+    if (be) {
+        asm("lvx %0, 0, %1" : "=v"(r) : "r"(p), "m"(*p));
+    } else if (HOST_BIG_ENDIAN) {
+        AESStateVec rev = {
+            15, 14, 13, 12, 11, 10, 9, 8, 7,  6,  5,  4,  3,  2,  1,  0,
+        };
+        asm("lvx %0, 0, %1\n\t"
+            "vperm %0, %0, %0, %2"
+            : "=v"(r) : "r"(p), "v"(rev), "m"(*p));
+    } else {
+#ifdef __POWER9_VECTOR__
+        asm("lxvb16x %x0, 0, %1" : "=v"(r) : "r"(p), "m"(*p));
+#else
+        asm("lxvd2x %x0, 0, %1\n\t"
+            "xxpermdi %x0, %x0, %x0, 2"
+            : "=v"(r) : "r"(p), "m"(*p));
+#endif
+    }
+    return r;
+}
+
+static void aes_accel_st(AESState *p, AESStateVec r, bool be)
+{
+    if (be) {
+        asm("stvx %1, 0, %2" : "=m"(*p) : "v"(r), "r"(p));
+    } else if (HOST_BIG_ENDIAN) {
+        AESStateVec rev = {
+            15, 14, 13, 12, 11, 10, 9, 8, 7,  6,  5,  4,  3,  2,  1,  0,
+        };
+        asm("vperm %1, %1, %1, %2\n\t"
+            "stvx %1, 0, %3"
+            : "=m"(*p), "+v"(r) : "v"(rev), "r"(p));
+    } else {
+#ifdef __POWER9_VECTOR__
+        asm("stxvb16x %x1, 0, %2" : "=m"(*p) : "v"(r), "r"(p));
+#else
+        asm("xxpermdi %x1, %x1, %x1, 2\n\t"
+            "stxvd2x %x1, 0, %2"
+            : "=m"(*p), "+v"(r) : "r"(p));
+#endif
+    }
+}
+
+static inline AESStateVec aes_accel_vcipher(AESStateVec d, AESStateVec k)
+{
+    asm("vcipher %0, %0, %1" : "+v"(d) : "v"(k));
+    return d;
+}
+
+static inline AESStateVec aes_accel_vncipher(AESStateVec d, AESStateVec k)
+{
+    asm("vncipher %0, %0, %1" : "+v"(d) : "v"(k));
+    return d;
+}
+
+static inline AESStateVec aes_accel_vcipherlast(AESStateVec d, AESStateVec k)
+{
+    asm("vcipherlast %0, %0, %1" : "+v"(d) : "v"(k));
+    return d;
+}
+
+static inline AESStateVec aes_accel_vncipherlast(AESStateVec d, AESStateVec k)
+{
+    asm("vncipherlast %0, %0, %1" : "+v"(d) : "v"(k));
+    return d;
+}
+
+static inline void
+aesenc_MC_accel(AESState *ret, const AESState *st, bool be)
+{
+    AESStateVec t, z = { };
+
+    t = aes_accel_ld(st, be);
+    t = aes_accel_vncipherlast(t, z);
+    t = aes_accel_vcipher(t, z);
+    aes_accel_st(ret, t, be);
+}
+
+static inline void
+aesenc_SB_SR_AK_accel(AESState *ret, const AESState *st,
+                      const AESState *rk, bool be)
+{
+    AESStateVec t, k;
+
+    t = aes_accel_ld(st, be);
+    k = aes_accel_ld(rk, be);
+    t = aes_accel_vcipherlast(t, k);
+    aes_accel_st(ret, t, be);
+}
+
+static inline void
+aesenc_SB_SR_MC_AK_accel(AESState *ret, const AESState *st,
+                         const AESState *rk, bool be)
+{
+    AESStateVec t, k;
+
+    t = aes_accel_ld(st, be);
+    k = aes_accel_ld(rk, be);
+    t = aes_accel_vcipher(t, k);
+    aes_accel_st(ret, t, be);
+}
+
+static inline void
+aesdec_IMC_accel(AESState *ret, const AESState *st, bool be)
+{
+    AESStateVec t, z = { };
+
+    t = aes_accel_ld(st, be);
+    t = aes_accel_vcipherlast(t, z);
+    t = aes_accel_vncipher(t, z);
+    aes_accel_st(ret, t, be);
+}
+
+static inline void
+aesdec_ISB_ISR_AK_accel(AESState *ret, const AESState *st,
+                        const AESState *rk, bool be)
+{
+    AESStateVec t, k;
+
+    t = aes_accel_ld(st, be);
+    k = aes_accel_ld(rk, be);
+    t = aes_accel_vncipherlast(t, k);
+    aes_accel_st(ret, t, be);
+}
+
+static inline void
+aesdec_ISB_ISR_AK_IMC_accel(AESState *ret, const AESState *st,
+                            const AESState *rk, bool be)
+{
+    AESStateVec t, k;
+
+    t = aes_accel_ld(st, be);
+    k = aes_accel_ld(rk, be);
+    t = aes_accel_vncipher(t, k);
+    aes_accel_st(ret, t, be);
+}
+
+static inline void
+aesdec_ISB_ISR_IMC_AK_accel(AESState *ret, const AESState *st,
+                            const AESState *rk, bool be)
+{
+    AESStateVec t, k, z = { };
+
+    t = aes_accel_ld(st, be);
+    k = aes_accel_ld(rk, be);
+    t = aes_accel_vncipher(t, z);
+    aes_accel_st(ret, t ^ k, be);
+}
+#else
+/* Without ALTIVEC, we can't even write inline assembly. */
+#include "host/include/generic/host/crypto/aes-round.h"
+#endif
+
+#endif /* PPC_HOST_CRYPTO_AES_ROUND_H */
diff --git a/linux-user/include/host/ppc/host-signal.h b/linux-user/include/host/ppc/host-signal.h
deleted file mode 100644
index de25c803f5..0000000000
--- a/linux-user/include/host/ppc/host-signal.h
+++ /dev/null
@@ -1,39 +0,0 @@
-/*
- * host-signal.h: signal info dependent on the host architecture
- *
- * Copyright (c) 2022 Linaro Ltd.
- *
- * This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
- * See the COPYING file in the top-level directory.
- */
-
-#ifndef PPC_HOST_SIGNAL_H
-#define PPC_HOST_SIGNAL_H
-
-#include <asm/ptrace.h>
-
-/* The third argument to a SA_SIGINFO handler is ucontext_t. */
-typedef ucontext_t host_sigcontext;
-
-static inline uintptr_t host_signal_pc(host_sigcontext *uc)
-{
-    return uc->uc_mcontext.regs->nip;
-}
-
-static inline void host_signal_set_pc(host_sigcontext *uc, uintptr_t pc)
-{
-    uc->uc_mcontext.regs->nip = pc;
-}
-
-static inline void *host_signal_mask(host_sigcontext *uc)
-{
-    return &uc->uc_sigmask;
-}
-
-static inline bool host_signal_write(siginfo_t *info, host_sigcontext *uc)
-{
-    return uc->uc_mcontext.regs->trap != 0x400
-        && (uc->uc_mcontext.regs->dsisr & 0x02000000);
-}
-
-#endif
diff --git a/common-user/host/ppc/safe-syscall.inc.S b/common-user/host/ppc/safe-syscall.inc.S
deleted file mode 100644
index 0851f6c0b8..0000000000
--- a/common-user/host/ppc/safe-syscall.inc.S
+++ /dev/null
@@ -1,107 +0,0 @@
-/*
- * safe-syscall.inc.S : host-specific assembly fragment
- * to handle signals occurring at the same time as system calls.
- * This is intended to be included by common-user/safe-syscall.S
- *
- * Copyright (C) 2022 Linaro, Ltd.
- *
- * This work is licensed under the terms of the GNU GPL, version 2 or later.
- * See the COPYING file in the top-level directory.
- */
-
-/*
- * Standardize on the _CALL_FOO symbols used by GCC:
- * Apple XCode does not define _CALL_DARWIN.
- * Clang defines _CALL_ELF (64-bit) but not _CALL_SYSV (32-bit).
- */
-#if !defined(_CALL_SYSV) && \
-    !defined(_CALL_DARWIN) && \
-    !defined(_CALL_AIX) && \
-    !defined(_CALL_ELF)
-# if defined(__APPLE__)
-#  define _CALL_DARWIN
-# elif defined(__ELF__) && TCG_TARGET_REG_BITS == 32
-#  define _CALL_SYSV
-# else
-#  error "Unknown ABI"
-# endif
-#endif 
-
-#ifndef _CALL_SYSV
-# error "Unsupported ABI"
-#endif
-
-
-        .global safe_syscall_base
-        .global safe_syscall_start
-        .global safe_syscall_end
-        .type   safe_syscall_base, @function
-
-        .text
-
-        /*
-         * This is the entry point for making a system call. The calling
-         * convention here is that of a C varargs function with the
-         * first argument an 'int *' to the signal_pending flag, the
-         * second one the system call number (as a 'long'), and all further
-         * arguments being syscall arguments (also 'long').
-         */
-safe_syscall_base:
-        .cfi_startproc
-        stwu    1, -8(1)
-        .cfi_def_cfa_offset 8
-        stw     30, 4(1)
-        .cfi_offset 30, -4
-
-        /*
-         * We enter with r3 == &signal_pending
-         *               r4 == syscall number
-         *               r5 ... r10 == syscall arguments
-         *               and return the result in r3
-         * and the syscall instruction needs
-         *               r0 == syscall number
-         *               r3 ... r8 == syscall arguments
-         *               and returns the result in r3
-         * Shuffle everything around appropriately.
-         */
-        mr      30, 3           /* signal_pending */
-        mr      0, 4            /* syscall number */
-        mr      3, 5            /* syscall arguments */
-        mr      4, 6
-        mr      5, 7
-        mr      6, 8
-        mr      7, 9
-        mr      8, 10
-
-        /*
-         * This next sequence of code works in conjunction with the
-         * rewind_if_safe_syscall_function(). If a signal is taken
-         * and the interrupted PC is anywhere between 'safe_syscall_start'
-         * and 'safe_syscall_end' then we rewind it to 'safe_syscall_start'.
-         * The code sequence must therefore be able to cope with this, and
-         * the syscall instruction must be the final one in the sequence.
-         */
-safe_syscall_start:
-        /* if signal_pending is non-zero, don't do the call */
-        lwz     12, 0(30)
-        cmpwi   0, 12, 0
-        bne-    2f
-        sc
-safe_syscall_end:
-        /* code path when we did execute the syscall */
-        lwz     30, 4(1)        /* restore r30 */
-        addi    1, 1, 8         /* restore stack */
-        .cfi_restore 30
-        .cfi_def_cfa_offset 0
-        bnslr+                  /* return on success */
-        b       safe_syscall_set_errno_tail
-
-        /* code path when we didn't execute the syscall */
-2:      lwz     30, 4(1)
-        addi    1, 1, 8
-        addi    3, 0, QEMU_ERESTARTSYS
-        b       safe_syscall_set_errno_tail
-
-        .cfi_endproc
-
-        .size   safe_syscall_base, .-safe_syscall_base
diff --git a/meson.build b/meson.build
index e5bdcf651d..f93447123b 100644
--- a/meson.build
+++ b/meson.build
@@ -50,7 +50,7 @@ qapi_trace_events = []
 
 bsd_oses = ['gnu/kfreebsd', 'freebsd', 'netbsd', 'openbsd', 'dragonfly', 'darwin']
 supported_oses = ['windows', 'freebsd', 'netbsd', 'openbsd', 'darwin', 'sunos', 'linux', 'emscripten']
-supported_cpus = ['ppc', 'ppc64', 's390x', 'riscv32', 'riscv64', 'x86_64',
+supported_cpus = ['ppc64', 's390x', 'riscv32', 'riscv64', 'x86_64',
   'aarch64', 'loongarch64', 'mips64', 'sparc64', 'wasm32']
 
 cpu = host_machine.cpu_family()
@@ -279,8 +279,6 @@ elif cpu == 'aarch64'
   kvm_targets = ['aarch64-softmmu']
 elif cpu == 's390x'
   kvm_targets = ['s390x-softmmu']
-elif cpu == 'ppc'
-  kvm_targets = ['ppc-softmmu']
 elif cpu == 'ppc64'
   kvm_targets = ['ppc-softmmu', 'ppc64-softmmu']
 elif cpu == 'mips64'
-- 
2.43.0


