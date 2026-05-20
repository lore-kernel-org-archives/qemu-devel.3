Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78B08CD5BA4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 18:28:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPlZP-0007zx-2b; Wed, 20 May 2026 14:23:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPlYw-00079a-2O
 for qemu-devel@nongnu.org; Wed, 20 May 2026 14:22:35 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPlYs-0000ZB-MK
 for qemu-devel@nongnu.org; Wed, 20 May 2026 14:22:33 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-366139223e4so3011901a91.0
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 11:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779301349; x=1779906149; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ad95Qfvf39Y/pJtpBMnjf6EUI1HAMLBfD/Kn4uxVX0Y=;
 b=ld6p4l4qbp1N8Tk7RyplMFaQpqCLKKakBVcuhlYhk3lRzae5zfQMNq307DA7tfxQFn
 eIjpzU+puwQisnkaQkwHKZ66nLigy6VD4vVWh42jxf7Mz/rT1oPazcY88cL4xjajLCJy
 o2G7LTkmsyLNT2Is+Jg2pHDC2TEqprH2A//bH2pB63Lk8LxM2rjiohYZiE4zt0cIsyKQ
 esEoc4v2gHF20MmA5vcvaTvorfDRKFbw1Z+IAEiC/5Vw26VAIE5HQxumf2Hayi6CAJ6i
 A4IXfzHzdE6OZHkGmZlGZpOXBV+KLRZjNCywf7QnZ4cze3Bvg6YIga62sGG4YsFz1U2s
 N7Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779301349; x=1779906149;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ad95Qfvf39Y/pJtpBMnjf6EUI1HAMLBfD/Kn4uxVX0Y=;
 b=PeD3TZqxe/unrRrxMPMZLWozcJLJ04Iv+G0Yyjc8FYXT7LR4wdr7HQJBXsM3tNKYtm
 5HStG4WNMKuMsdDD3g6QtFrQGtTVGf7xQH9qzJ//dq7QjWmqmnXbv8PnKEKI6ya9y2hD
 9AL6pHzzKHF0moAfiLhJUIHa5TR/0QteNIUc7b+ZEGWX8CwFFS7vJlfMlurvb756f1ll
 oVL/HvX6y/NEwHMtDxTGek/gQkgVpEQc9X+4bsPrzP+dSvbOdVbGIqu01VmY65lbO8j5
 eaPM63KoPdBa9EkJSOM8hcqbruTAB378A6QjznMjnPyzt7sCkKe9cmQhw2Za0D3qq3kR
 0YPQ==
X-Gm-Message-State: AOJu0YwuY9ZZZX+6ACSN+1IZjyc8+JPBILaqXc1AC2eJ3ois40Zsd0nq
 6HeCx8dcSeKjik+/i2Si9Jy0KvIX8cMRJ8amU7CJCv2Ihp4uFmHbqcnBHIVSZTv6fHV9F60lcpy
 Dl8uaMvE=
X-Gm-Gg: Acq92OFcKMbhEIvMDtEgZzVBa98BOSwXfbYWb9a3mFs8UwuYRoSr34ApbLhHm749JWu
 xnyPkwzfRufkNJC6zBjpkxR4kaDviasfgyTdrMRyi1vRS8BdBFlG8dIjOtHqHGXjM/ZFOjg70/J
 SVLR4e6Hv+MXV9Ux+rYpeXIvL6JHuzC0TmTCiIOzaZr966ChHgZOJjkwf1Y5I+iG0nOGI5qwLtM
 8/1bcviSDvgr3h89h3DWvH8LhdqJ0U2QsJcYBRWUnbrAX8pESuhocJXsrUf66PSiiuziTFjvvci
 3f92OKyJk+t2ihz6zZMxVD9Jcv/YeN8FzSVeK4upW9LABtk48KvGE0aYWwRWLsOuaLB8bDdWqZn
 Qbou11WvY1cllenDemmKHBVJ7Lq5OZkyF9ma9mSEwwMrmTywKATkCP5b7mCs3X9brPOvrmfXdrQ
 5glJfqywFluFJpJ0MepX18MYAxa6/5
X-Received: by 2002:a17:90b:38ce:b0:368:d8a1:3bd4 with SMTP id
 98e67ed59e1d1-369519e2088mr23380462a91.3.1779301349038; 
 Wed, 20 May 2026 11:22:29 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a3d210b4esm274764a91.17.2026.05.20.11.22.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 11:22:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v6 21/64] target/arm: Split vector-type.h from cpu.h
Date: Wed, 20 May 2026 11:21:30 -0700
Message-ID: <20260520182213.872945-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520182213.872945-1-richard.henderson@linaro.org>
References: <20260520182213.872945-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

We want to be able to reference ARMVectorType etc from
common code, so move it out of cpu.h.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h         | 38 +---------------------------------
 target/arm/vector-type.h | 44 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+), 37 deletions(-)
 create mode 100644 target/arm/vector-type.h

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 9e637c1d80..9f5da3d863 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -35,6 +35,7 @@
 #include "target/arm/cpu-sysregs.h"
 #include "target/arm/mmuidx.h"
 #include "hw/intc/arm_gicv5_types.h"
+#include "target/arm/vector-type.h"
 
 #define EXCP_UDEF            1   /* undefined instruction */
 #define EXCP_SWI             2   /* software interrupt */
@@ -140,43 +141,6 @@ typedef struct ARMGenericTimer {
     uint64_t ctl; /* Timer Control register */
 } ARMGenericTimer;
 
-/* Define a maximum sized vector register.
- * For 32-bit, this is a 128-bit NEON/AdvSIMD register.
- * For 64-bit, this is a 2048-bit SVE register.
- *
- * Note that the mapping between S, D, and Q views of the register bank
- * differs between AArch64 and AArch32.
- * In AArch32:
- *  Qn = regs[n].d[1]:regs[n].d[0]
- *  Dn = regs[n / 2].d[n & 1]
- *  Sn = regs[n / 4].d[n % 4 / 2],
- *       bits 31..0 for even n, and bits 63..32 for odd n
- *       (and regs[16] to regs[31] are inaccessible)
- * In AArch64:
- *  Zn = regs[n].d[*]
- *  Qn = regs[n].d[1]:regs[n].d[0]
- *  Dn = regs[n].d[0]
- *  Sn = regs[n].d[0] bits 31..0
- *  Hn = regs[n].d[0] bits 15..0
- *
- * This corresponds to the architecturally defined mapping between
- * the two execution states, and means we do not need to explicitly
- * map these registers when changing states.
- *
- * Align the data for use with TCG host vector operations.
- */
-
-#define ARM_MAX_VQ    16
-
-typedef struct ARMVectorReg {
-    uint64_t d[2 * ARM_MAX_VQ] QEMU_ALIGNED(16);
-} ARMVectorReg;
-
-/* In AArch32 mode, predicate registers do not exist at all.  */
-typedef struct ARMPredicateReg {
-    uint64_t p[DIV_ROUND_UP(2 * ARM_MAX_VQ, 8)] QEMU_ALIGNED(16);
-} ARMPredicateReg;
-
 /* In AArch32 mode, PAC keys do not exist at all.  */
 typedef struct ARMPACKey {
     uint64_t lo, hi;
diff --git a/target/arm/vector-type.h b/target/arm/vector-type.h
new file mode 100644
index 0000000000..d94c0d986e
--- /dev/null
+++ b/target/arm/vector-type.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef TARGET_ARM_VECTOR_TYPE_H
+#define TARGET_ARM_VECTOR_TYPE_H
+
+/*
+ * Define a maximum sized vector register.
+ * For 32-bit, this is a 128-bit NEON/AdvSIMD register.
+ * For 64-bit, this is a 2048-bit SVE register.
+ *
+ * Note that the mapping between S, D, and Q views of the register bank
+ * differs between AArch64 and AArch32.
+ * In AArch32:
+ *  Qn = regs[n].d[1]:regs[n].d[0]
+ *  Dn = regs[n / 2].d[n & 1]
+ *  Sn = regs[n / 4].d[n % 4 / 2],
+ *       bits 31..0 for even n, and bits 63..32 for odd n
+ *       (and regs[16] to regs[31] are inaccessible)
+ * In AArch64:
+ *  Zn = regs[n].d[*]
+ *  Qn = regs[n].d[1]:regs[n].d[0]
+ *  Dn = regs[n].d[0]
+ *  Sn = regs[n].d[0] bits 31..0
+ *  Hn = regs[n].d[0] bits 15..0
+ *
+ * This corresponds to the architecturally defined mapping between
+ * the two execution states, and means we do not need to explicitly
+ * map these registers when changing states.
+ *
+ * Align the data for use with TCG host vector operations.
+ */
+
+#define ARM_MAX_VQ    16
+
+typedef struct ARMVectorReg {
+    uint64_t d[2 * ARM_MAX_VQ] QEMU_ALIGNED(16);
+} ARMVectorReg;
+
+/* In AArch32 mode, predicate registers do not exist at all.  */
+typedef struct ARMPredicateReg {
+    uint64_t p[DIV_ROUND_UP(2 * ARM_MAX_VQ, 8)] QEMU_ALIGNED(16);
+} ARMPredicateReg;
+
+#endif
-- 
2.43.0


