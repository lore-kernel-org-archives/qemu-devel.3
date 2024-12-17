Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F55BE7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 17:45:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNbcx-0003YP-TQ; Tue, 17 Dec 2024 12:45:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tNbco-0003Y4-1e
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 12:44:50 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tNbcj-0006Fd-S5
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 12:44:48 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-38633b5dbcfso6083441f8f.2
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 09:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734457484; x=1735062284; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=1JveWoa38lpPidsn3lttWBvUB/L1n4g++5LCy0LQz58=;
 b=OuMfEUw/UE6PtKzXwoX8wLL+WNyCZGGhXrNnNFhbeRqI1us5dTtsL4pcY/bgni5VrN
 ut9I3FTfXoCwHPiCJRGLeJRQmo74lb/bWXNozS96+VBTdF45ZmWeyhXJvDKxJV7AI/i0
 xjKKe3L6XsbT01AD3mpwmXCcrrKJO1om5xOW1TMhSmaP5iY6iV8u8dmnQb2gxpx6XPH2
 nLkKUX9JgA9WsNZYeKw1wDBlqP8kVmDjDxOPtsMJhSJ+XLS4Fa1O7TvqeuVpa3Y1lsc8
 zRnjY9IRI6NkYTVaWFyAyzRS0Kqyc5EYufuR/dyEEWB4og6jWXYAZwRvmiXWxEJvhQlT
 K59g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734457484; x=1735062284;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1JveWoa38lpPidsn3lttWBvUB/L1n4g++5LCy0LQz58=;
 b=dKFQz2bA1jfOnyAnsu45SUpVAkNy9DLpJb1edsq7ePbvI06sXT2yvRKh7CnpSmtPv1
 7dv6v1FRNU8WNK/Jd6UCurMGV6zXHfSqvLO0yKZgVChp7yRmVbk9ne/4uFv7E7QjypXh
 8bHLeBqLU/WG+5PVx4eNsExjEH9jO34gXfI0TrOXcTT7LKkCVoOs0omIomP8IC6PxHb+
 6MpYQMOTOlahpxjIXEoz2YcUU/k9r/UX5qtcXfgi1mkkiN8qpq+8oo67tkjJmYXZLDiF
 mxOQp7nxlPwcX2dadbdqBUOVhx3Y6lMr+65y5P9WYWsvRBQiBd7XRD7cxrwLVaUJH87e
 RFUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW62Saqhc+ljd+mBU7v8pa3+WXKg1vMvvyrJp7ZdN+rnZ2+lR+5e5bN1wzluBd9MV3OxWWIC4kQUYnn@nongnu.org
X-Gm-Message-State: AOJu0YztFQrt+Wq5npVyrqvZIcLh4qN3j9S3/RYDbdZhgOo3pf5z1bXn
 D7bmDb1RDiR+gHP30HFYY/AKjBNlLP0XVH4XPi5zbjAOGNSBosxBfD8WyQMUNSA=
X-Gm-Gg: ASbGnctxxYLPkAgmk6cC4XIYkyc7dloLUj73B0iDipYlS0H9n7aks03qCn5SAT2AmTE
 CpGQMCDEy84YAgNhnwYpYG4oLVu8t6An8dPjdBcxu/5VqsOE2KWXzKvik6SoSbAuPels4DYRJJV
 UJxExLzhadZpQQ6WCOaZu4Y/E+0kJOWCsS+f7lhwW49/wuNBwEhCgGuyIkqhQGx/y+FoL9MeO+t
 lZyxWDe1+tDHSMk25lBjl95uwCqkyEMeNCwpHfLJnj60OkyC7b3O3J0MJn1/H4=
X-Google-Smtp-Source: AGHT+IGMd7YEtZOillAlFDzshQBxgq9i8p4Bymp0GxxlaR/i7dc6EqIoKEXR4CCNzruGDDCPSTWpWQ==
X-Received: by 2002:a05:6000:1a86:b0:386:1ab5:f0e1 with SMTP id
 ffacd0b85a97d-38880ad794emr16319617f8f.14.1734457483844; 
 Tue, 17 Dec 2024 09:44:43 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4363606eee9sm125764525e9.24.2024.12.17.09.44.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2024 09:44:43 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH] target/arm: Move minor arithmetic helpers out of helper.c
Date: Tue, 17 Dec 2024 17:44:42 +0000
Message-Id: <20241217174442.3914177-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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

helper.c includes some small TCG helper functions used for mostly
arithmetic instructions.  These are TCG only and there's no need for
them to be in the large and unwieldy helper.c.  Move them out to
their own source file in the tcg/ subdirectory, together with the
op_addsub.h multiply-included template header that they use.

(Ironically, this means that helper.c no longer contains
any TCG helper function definitions at all.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
One last tiny cleanup for the end of the year...this is a pure
code movement, with no changes.

 target/arm/{ => tcg}/op_addsub.h |   0
 target/arm/helper.c              | 285 -----------------------------
 target/arm/tcg/arith_helper.c    | 296 +++++++++++++++++++++++++++++++
 target/arm/tcg/meson.build       |   1 +
 4 files changed, 297 insertions(+), 285 deletions(-)
 rename target/arm/{ => tcg}/op_addsub.h (100%)
 create mode 100644 target/arm/tcg/arith_helper.c

diff --git a/target/arm/op_addsub.h b/target/arm/tcg/op_addsub.h
similarity index 100%
rename from target/arm/op_addsub.h
rename to target/arm/tcg/op_addsub.h
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 910ae62c476..bf4d3a2f4d6 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -16,10 +16,8 @@
 #include "qemu/main-loop.h"
 #include "qemu/timer.h"
 #include "qemu/bitops.h"
-#include "qemu/crc32c.h"
 #include "qemu/qemu-print.h"
 #include "exec/exec-all.h"
-#include <zlib.h> /* for crc32 */
 #include "hw/irq.h"
 #include "sysemu/cpu-timers.h"
 #include "sysemu/kvm.h"
@@ -10954,289 +10952,6 @@ ARMVAParameters aa64_va_parameters(CPUARMState *env, uint64_t va,
     };
 }
 
-/*
- * Note that signed overflow is undefined in C.  The following routines are
- * careful to use unsigned types where modulo arithmetic is required.
- * Failure to do so _will_ break on newer gcc.
- */
-
-/* Signed saturating arithmetic.  */
-
-/* Perform 16-bit signed saturating addition.  */
-static inline uint16_t add16_sat(uint16_t a, uint16_t b)
-{
-    uint16_t res;
-
-    res = a + b;
-    if (((res ^ a) & 0x8000) && !((a ^ b) & 0x8000)) {
-        if (a & 0x8000) {
-            res = 0x8000;
-        } else {
-            res = 0x7fff;
-        }
-    }
-    return res;
-}
-
-/* Perform 8-bit signed saturating addition.  */
-static inline uint8_t add8_sat(uint8_t a, uint8_t b)
-{
-    uint8_t res;
-
-    res = a + b;
-    if (((res ^ a) & 0x80) && !((a ^ b) & 0x80)) {
-        if (a & 0x80) {
-            res = 0x80;
-        } else {
-            res = 0x7f;
-        }
-    }
-    return res;
-}
-
-/* Perform 16-bit signed saturating subtraction.  */
-static inline uint16_t sub16_sat(uint16_t a, uint16_t b)
-{
-    uint16_t res;
-
-    res = a - b;
-    if (((res ^ a) & 0x8000) && ((a ^ b) & 0x8000)) {
-        if (a & 0x8000) {
-            res = 0x8000;
-        } else {
-            res = 0x7fff;
-        }
-    }
-    return res;
-}
-
-/* Perform 8-bit signed saturating subtraction.  */
-static inline uint8_t sub8_sat(uint8_t a, uint8_t b)
-{
-    uint8_t res;
-
-    res = a - b;
-    if (((res ^ a) & 0x80) && ((a ^ b) & 0x80)) {
-        if (a & 0x80) {
-            res = 0x80;
-        } else {
-            res = 0x7f;
-        }
-    }
-    return res;
-}
-
-#define ADD16(a, b, n) RESULT(add16_sat(a, b), n, 16);
-#define SUB16(a, b, n) RESULT(sub16_sat(a, b), n, 16);
-#define ADD8(a, b, n)  RESULT(add8_sat(a, b), n, 8);
-#define SUB8(a, b, n)  RESULT(sub8_sat(a, b), n, 8);
-#define PFX q
-
-#include "op_addsub.h"
-
-/* Unsigned saturating arithmetic.  */
-static inline uint16_t add16_usat(uint16_t a, uint16_t b)
-{
-    uint16_t res;
-    res = a + b;
-    if (res < a) {
-        res = 0xffff;
-    }
-    return res;
-}
-
-static inline uint16_t sub16_usat(uint16_t a, uint16_t b)
-{
-    if (a > b) {
-        return a - b;
-    } else {
-        return 0;
-    }
-}
-
-static inline uint8_t add8_usat(uint8_t a, uint8_t b)
-{
-    uint8_t res;
-    res = a + b;
-    if (res < a) {
-        res = 0xff;
-    }
-    return res;
-}
-
-static inline uint8_t sub8_usat(uint8_t a, uint8_t b)
-{
-    if (a > b) {
-        return a - b;
-    } else {
-        return 0;
-    }
-}
-
-#define ADD16(a, b, n) RESULT(add16_usat(a, b), n, 16);
-#define SUB16(a, b, n) RESULT(sub16_usat(a, b), n, 16);
-#define ADD8(a, b, n)  RESULT(add8_usat(a, b), n, 8);
-#define SUB8(a, b, n)  RESULT(sub8_usat(a, b), n, 8);
-#define PFX uq
-
-#include "op_addsub.h"
-
-/* Signed modulo arithmetic.  */
-#define SARITH16(a, b, n, op) do { \
-    int32_t sum; \
-    sum = (int32_t)(int16_t)(a) op (int32_t)(int16_t)(b); \
-    RESULT(sum, n, 16); \
-    if (sum >= 0) \
-        ge |= 3 << (n * 2); \
-    } while (0)
-
-#define SARITH8(a, b, n, op) do { \
-    int32_t sum; \
-    sum = (int32_t)(int8_t)(a) op (int32_t)(int8_t)(b); \
-    RESULT(sum, n, 8); \
-    if (sum >= 0) \
-        ge |= 1 << n; \
-    } while (0)
-
-
-#define ADD16(a, b, n) SARITH16(a, b, n, +)
-#define SUB16(a, b, n) SARITH16(a, b, n, -)
-#define ADD8(a, b, n)  SARITH8(a, b, n, +)
-#define SUB8(a, b, n)  SARITH8(a, b, n, -)
-#define PFX s
-#define ARITH_GE
-
-#include "op_addsub.h"
-
-/* Unsigned modulo arithmetic.  */
-#define ADD16(a, b, n) do { \
-    uint32_t sum; \
-    sum = (uint32_t)(uint16_t)(a) + (uint32_t)(uint16_t)(b); \
-    RESULT(sum, n, 16); \
-    if ((sum >> 16) == 1) \
-        ge |= 3 << (n * 2); \
-    } while (0)
-
-#define ADD8(a, b, n) do { \
-    uint32_t sum; \
-    sum = (uint32_t)(uint8_t)(a) + (uint32_t)(uint8_t)(b); \
-    RESULT(sum, n, 8); \
-    if ((sum >> 8) == 1) \
-        ge |= 1 << n; \
-    } while (0)
-
-#define SUB16(a, b, n) do { \
-    uint32_t sum; \
-    sum = (uint32_t)(uint16_t)(a) - (uint32_t)(uint16_t)(b); \
-    RESULT(sum, n, 16); \
-    if ((sum >> 16) == 0) \
-        ge |= 3 << (n * 2); \
-    } while (0)
-
-#define SUB8(a, b, n) do { \
-    uint32_t sum; \
-    sum = (uint32_t)(uint8_t)(a) - (uint32_t)(uint8_t)(b); \
-    RESULT(sum, n, 8); \
-    if ((sum >> 8) == 0) \
-        ge |= 1 << n; \
-    } while (0)
-
-#define PFX u
-#define ARITH_GE
-
-#include "op_addsub.h"
-
-/* Halved signed arithmetic.  */
-#define ADD16(a, b, n) \
-  RESULT(((int32_t)(int16_t)(a) + (int32_t)(int16_t)(b)) >> 1, n, 16)
-#define SUB16(a, b, n) \
-  RESULT(((int32_t)(int16_t)(a) - (int32_t)(int16_t)(b)) >> 1, n, 16)
-#define ADD8(a, b, n) \
-  RESULT(((int32_t)(int8_t)(a) + (int32_t)(int8_t)(b)) >> 1, n, 8)
-#define SUB8(a, b, n) \
-  RESULT(((int32_t)(int8_t)(a) - (int32_t)(int8_t)(b)) >> 1, n, 8)
-#define PFX sh
-
-#include "op_addsub.h"
-
-/* Halved unsigned arithmetic.  */
-#define ADD16(a, b, n) \
-  RESULT(((uint32_t)(uint16_t)(a) + (uint32_t)(uint16_t)(b)) >> 1, n, 16)
-#define SUB16(a, b, n) \
-  RESULT(((uint32_t)(uint16_t)(a) - (uint32_t)(uint16_t)(b)) >> 1, n, 16)
-#define ADD8(a, b, n) \
-  RESULT(((uint32_t)(uint8_t)(a) + (uint32_t)(uint8_t)(b)) >> 1, n, 8)
-#define SUB8(a, b, n) \
-  RESULT(((uint32_t)(uint8_t)(a) - (uint32_t)(uint8_t)(b)) >> 1, n, 8)
-#define PFX uh
-
-#include "op_addsub.h"
-
-static inline uint8_t do_usad(uint8_t a, uint8_t b)
-{
-    if (a > b) {
-        return a - b;
-    } else {
-        return b - a;
-    }
-}
-
-/* Unsigned sum of absolute byte differences.  */
-uint32_t HELPER(usad8)(uint32_t a, uint32_t b)
-{
-    uint32_t sum;
-    sum = do_usad(a, b);
-    sum += do_usad(a >> 8, b >> 8);
-    sum += do_usad(a >> 16, b >> 16);
-    sum += do_usad(a >> 24, b >> 24);
-    return sum;
-}
-
-/* For ARMv6 SEL instruction.  */
-uint32_t HELPER(sel_flags)(uint32_t flags, uint32_t a, uint32_t b)
-{
-    uint32_t mask;
-
-    mask = 0;
-    if (flags & 1) {
-        mask |= 0xff;
-    }
-    if (flags & 2) {
-        mask |= 0xff00;
-    }
-    if (flags & 4) {
-        mask |= 0xff0000;
-    }
-    if (flags & 8) {
-        mask |= 0xff000000;
-    }
-    return (a & mask) | (b & ~mask);
-}
-
-/*
- * CRC helpers.
- * The upper bytes of val (above the number specified by 'bytes') must have
- * been zeroed out by the caller.
- */
-uint32_t HELPER(crc32)(uint32_t acc, uint32_t val, uint32_t bytes)
-{
-    uint8_t buf[4];
-
-    stl_le_p(buf, val);
-
-    /* zlib crc32 converts the accumulator and output to one's complement.  */
-    return crc32(acc ^ 0xffffffff, buf, bytes) ^ 0xffffffff;
-}
-
-uint32_t HELPER(crc32c)(uint32_t acc, uint32_t val, uint32_t bytes)
-{
-    uint8_t buf[4];
-
-    stl_le_p(buf, val);
-
-    /* Linux crc32c converts the output to one's complement.  */
-    return crc32c(acc, buf, bytes) ^ 0xffffffff;
-}
 
 /*
  * Return the exception level to which FP-disabled exceptions should
diff --git a/target/arm/tcg/arith_helper.c b/target/arm/tcg/arith_helper.c
new file mode 100644
index 00000000000..10819de7fd8
--- /dev/null
+++ b/target/arm/tcg/arith_helper.c
@@ -0,0 +1,296 @@
+/*
+ * ARM generic helpers for various arithmetical operations.
+ *
+ * This code is licensed under the GNU GPL v2 or later.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "exec/helper-proto.h"
+#include "qemu/crc32c.h"
+#include <zlib.h> /* for crc32 */
+
+/*
+ * Note that signed overflow is undefined in C.  The following routines are
+ * careful to use unsigned types where modulo arithmetic is required.
+ * Failure to do so _will_ break on newer gcc.
+ */
+
+/* Signed saturating arithmetic.  */
+
+/* Perform 16-bit signed saturating addition.  */
+static inline uint16_t add16_sat(uint16_t a, uint16_t b)
+{
+    uint16_t res;
+
+    res = a + b;
+    if (((res ^ a) & 0x8000) && !((a ^ b) & 0x8000)) {
+        if (a & 0x8000) {
+            res = 0x8000;
+        } else {
+            res = 0x7fff;
+        }
+    }
+    return res;
+}
+
+/* Perform 8-bit signed saturating addition.  */
+static inline uint8_t add8_sat(uint8_t a, uint8_t b)
+{
+    uint8_t res;
+
+    res = a + b;
+    if (((res ^ a) & 0x80) && !((a ^ b) & 0x80)) {
+        if (a & 0x80) {
+            res = 0x80;
+        } else {
+            res = 0x7f;
+        }
+    }
+    return res;
+}
+
+/* Perform 16-bit signed saturating subtraction.  */
+static inline uint16_t sub16_sat(uint16_t a, uint16_t b)
+{
+    uint16_t res;
+
+    res = a - b;
+    if (((res ^ a) & 0x8000) && ((a ^ b) & 0x8000)) {
+        if (a & 0x8000) {
+            res = 0x8000;
+        } else {
+            res = 0x7fff;
+        }
+    }
+    return res;
+}
+
+/* Perform 8-bit signed saturating subtraction.  */
+static inline uint8_t sub8_sat(uint8_t a, uint8_t b)
+{
+    uint8_t res;
+
+    res = a - b;
+    if (((res ^ a) & 0x80) && ((a ^ b) & 0x80)) {
+        if (a & 0x80) {
+            res = 0x80;
+        } else {
+            res = 0x7f;
+        }
+    }
+    return res;
+}
+
+#define ADD16(a, b, n) RESULT(add16_sat(a, b), n, 16);
+#define SUB16(a, b, n) RESULT(sub16_sat(a, b), n, 16);
+#define ADD8(a, b, n)  RESULT(add8_sat(a, b), n, 8);
+#define SUB8(a, b, n)  RESULT(sub8_sat(a, b), n, 8);
+#define PFX q
+
+#include "op_addsub.h"
+
+/* Unsigned saturating arithmetic.  */
+static inline uint16_t add16_usat(uint16_t a, uint16_t b)
+{
+    uint16_t res;
+    res = a + b;
+    if (res < a) {
+        res = 0xffff;
+    }
+    return res;
+}
+
+static inline uint16_t sub16_usat(uint16_t a, uint16_t b)
+{
+    if (a > b) {
+        return a - b;
+    } else {
+        return 0;
+    }
+}
+
+static inline uint8_t add8_usat(uint8_t a, uint8_t b)
+{
+    uint8_t res;
+    res = a + b;
+    if (res < a) {
+        res = 0xff;
+    }
+    return res;
+}
+
+static inline uint8_t sub8_usat(uint8_t a, uint8_t b)
+{
+    if (a > b) {
+        return a - b;
+    } else {
+        return 0;
+    }
+}
+
+#define ADD16(a, b, n) RESULT(add16_usat(a, b), n, 16);
+#define SUB16(a, b, n) RESULT(sub16_usat(a, b), n, 16);
+#define ADD8(a, b, n)  RESULT(add8_usat(a, b), n, 8);
+#define SUB8(a, b, n)  RESULT(sub8_usat(a, b), n, 8);
+#define PFX uq
+
+#include "op_addsub.h"
+
+/* Signed modulo arithmetic.  */
+#define SARITH16(a, b, n, op) do { \
+    int32_t sum; \
+    sum = (int32_t)(int16_t)(a) op (int32_t)(int16_t)(b); \
+    RESULT(sum, n, 16); \
+    if (sum >= 0) \
+        ge |= 3 << (n * 2); \
+    } while (0)
+
+#define SARITH8(a, b, n, op) do { \
+    int32_t sum; \
+    sum = (int32_t)(int8_t)(a) op (int32_t)(int8_t)(b); \
+    RESULT(sum, n, 8); \
+    if (sum >= 0) \
+        ge |= 1 << n; \
+    } while (0)
+
+
+#define ADD16(a, b, n) SARITH16(a, b, n, +)
+#define SUB16(a, b, n) SARITH16(a, b, n, -)
+#define ADD8(a, b, n)  SARITH8(a, b, n, +)
+#define SUB8(a, b, n)  SARITH8(a, b, n, -)
+#define PFX s
+#define ARITH_GE
+
+#include "op_addsub.h"
+
+/* Unsigned modulo arithmetic.  */
+#define ADD16(a, b, n) do { \
+    uint32_t sum; \
+    sum = (uint32_t)(uint16_t)(a) + (uint32_t)(uint16_t)(b); \
+    RESULT(sum, n, 16); \
+    if ((sum >> 16) == 1) \
+        ge |= 3 << (n * 2); \
+    } while (0)
+
+#define ADD8(a, b, n) do { \
+    uint32_t sum; \
+    sum = (uint32_t)(uint8_t)(a) + (uint32_t)(uint8_t)(b); \
+    RESULT(sum, n, 8); \
+    if ((sum >> 8) == 1) \
+        ge |= 1 << n; \
+    } while (0)
+
+#define SUB16(a, b, n) do { \
+    uint32_t sum; \
+    sum = (uint32_t)(uint16_t)(a) - (uint32_t)(uint16_t)(b); \
+    RESULT(sum, n, 16); \
+    if ((sum >> 16) == 0) \
+        ge |= 3 << (n * 2); \
+    } while (0)
+
+#define SUB8(a, b, n) do { \
+    uint32_t sum; \
+    sum = (uint32_t)(uint8_t)(a) - (uint32_t)(uint8_t)(b); \
+    RESULT(sum, n, 8); \
+    if ((sum >> 8) == 0) \
+        ge |= 1 << n; \
+    } while (0)
+
+#define PFX u
+#define ARITH_GE
+
+#include "op_addsub.h"
+
+/* Halved signed arithmetic.  */
+#define ADD16(a, b, n) \
+  RESULT(((int32_t)(int16_t)(a) + (int32_t)(int16_t)(b)) >> 1, n, 16)
+#define SUB16(a, b, n) \
+  RESULT(((int32_t)(int16_t)(a) - (int32_t)(int16_t)(b)) >> 1, n, 16)
+#define ADD8(a, b, n) \
+  RESULT(((int32_t)(int8_t)(a) + (int32_t)(int8_t)(b)) >> 1, n, 8)
+#define SUB8(a, b, n) \
+  RESULT(((int32_t)(int8_t)(a) - (int32_t)(int8_t)(b)) >> 1, n, 8)
+#define PFX sh
+
+#include "op_addsub.h"
+
+/* Halved unsigned arithmetic.  */
+#define ADD16(a, b, n) \
+  RESULT(((uint32_t)(uint16_t)(a) + (uint32_t)(uint16_t)(b)) >> 1, n, 16)
+#define SUB16(a, b, n) \
+  RESULT(((uint32_t)(uint16_t)(a) - (uint32_t)(uint16_t)(b)) >> 1, n, 16)
+#define ADD8(a, b, n) \
+  RESULT(((uint32_t)(uint8_t)(a) + (uint32_t)(uint8_t)(b)) >> 1, n, 8)
+#define SUB8(a, b, n) \
+  RESULT(((uint32_t)(uint8_t)(a) - (uint32_t)(uint8_t)(b)) >> 1, n, 8)
+#define PFX uh
+
+#include "op_addsub.h"
+
+static inline uint8_t do_usad(uint8_t a, uint8_t b)
+{
+    if (a > b) {
+        return a - b;
+    } else {
+        return b - a;
+    }
+}
+
+/* Unsigned sum of absolute byte differences.  */
+uint32_t HELPER(usad8)(uint32_t a, uint32_t b)
+{
+    uint32_t sum;
+    sum = do_usad(a, b);
+    sum += do_usad(a >> 8, b >> 8);
+    sum += do_usad(a >> 16, b >> 16);
+    sum += do_usad(a >> 24, b >> 24);
+    return sum;
+}
+
+/* For ARMv6 SEL instruction.  */
+uint32_t HELPER(sel_flags)(uint32_t flags, uint32_t a, uint32_t b)
+{
+    uint32_t mask;
+
+    mask = 0;
+    if (flags & 1) {
+        mask |= 0xff;
+    }
+    if (flags & 2) {
+        mask |= 0xff00;
+    }
+    if (flags & 4) {
+        mask |= 0xff0000;
+    }
+    if (flags & 8) {
+        mask |= 0xff000000;
+    }
+    return (a & mask) | (b & ~mask);
+}
+
+/*
+ * CRC helpers.
+ * The upper bytes of val (above the number specified by 'bytes') must have
+ * been zeroed out by the caller.
+ */
+uint32_t HELPER(crc32)(uint32_t acc, uint32_t val, uint32_t bytes)
+{
+    uint8_t buf[4];
+
+    stl_le_p(buf, val);
+
+    /* zlib crc32 converts the accumulator and output to one's complement.  */
+    return crc32(acc ^ 0xffffffff, buf, bytes) ^ 0xffffffff;
+}
+
+uint32_t HELPER(crc32c)(uint32_t acc, uint32_t val, uint32_t bytes)
+{
+    uint8_t buf[4];
+
+    stl_le_p(buf, val);
+
+    /* Linux crc32c converts the output to one's complement.  */
+    return crc32c(acc, buf, bytes) ^ 0xffffffff;
+}
diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index 09238989c5a..1f9077c372c 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -40,6 +40,7 @@ arm_ss.add(files(
   'tlb_helper.c',
   'vec_helper.c',
   'tlb-insns.c',
+  'arith_helper.c',
 ))
 
 arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
-- 
2.34.1


