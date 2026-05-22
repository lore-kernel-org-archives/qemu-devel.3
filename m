Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0240ACD5BB8
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 22:06:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQXym-0000Es-Lg; Fri, 22 May 2026 18:04:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQXxv-0007lA-6i
 for qemu-devel@nongnu.org; Fri, 22 May 2026 18:03:37 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQXxs-0008Jk-L9
 for qemu-devel@nongnu.org; Fri, 22 May 2026 18:03:34 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-3684a6f3b0bso3933819a91.1
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 15:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779487410; x=1780092210; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5ZgO8gjp8txrPFhSZcF1i35Zr8JFj4IafZd1otTkFRY=;
 b=e9xPzY89HrtMWCUmrgRkkSW+tiM5IDuszxaiZbImHTqnHv3GKQPxg+E4xDavppwIIV
 MhxHk21KwXAPwZSa7XwLdtiiTgoMI6GrY3D1jHra2p/rUDUA5IegNhk9yLHKeI4jvwWf
 HoStyUZgdhtHFrghDGyqAfwb9srAo4VyzZEfWVkAPxtgRNVNvHb0HuUYbxl+R04w2KKT
 JTsqdx3uuetKUFBTc3wYJOM2uMuqz7fg6kC3UwtXCGBwcJIFZ3EQY8IlLDeVnU8yLWIR
 p/Aj5NPodUWGMQaEuCDdms4bRhb5/HGplRX8kyNFf52lQwmXqd5QIIizKRo+6Lf9OfIT
 F8Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779487410; x=1780092210;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5ZgO8gjp8txrPFhSZcF1i35Zr8JFj4IafZd1otTkFRY=;
 b=nz66jJVkDnLpy6zrkcissNux2eMpg3x8Cl8uuHccKwAAnHdzC30/0NAZ40uUhMOsDl
 j3uniV9SxhdVLybRx4wv6ADjgG9ex5Bw1mH/CRHd+k5uHGJLcMnjWSzRrRf6DdM1Tsk0
 J16YG55fGOg7L3YPr8/MXhsePRTeAakC80ljxIitolU2bC9p/JJBMkVAUyucSxVIDg4C
 KXtpafFI5DxgDejRSX6CF6xGMbVQwIR6XWSYoEuWPnmojaOLLCwUzI5ljv2XOXvNArQR
 ALQL1eeonT9RWfoZvOBwS4bDEQ1xmXu0Q5XyiSKqcD+Jh2OyqdeP74+yadnlkjGunlsG
 AazQ==
X-Gm-Message-State: AOJu0YyDEN340Z2+48lP9ONJo/DCd8ExUIuS8Ld6VhYEOF9CzA2jhIaJ
 xuutnlgNNB5/9OxwlwYurcy6EQRXCu4WK8GK0P52XvufAVfUHv6ogHFYuO5vCL86VwRIGDFIS4v
 VjeA2
X-Gm-Gg: Acq92OGsZqKwodnqEdvENRp+/dNQRhsQhzPfgftnJAOty3fXQErZdSaIthavLzoe+wM
 XPJoKCJKGNAX6XPvcOskiEtlAsfLaHNUYUoAAYm34kIWutpg7detd36M2wwfV59SSWEyYnVjG+n
 Z5dsS2EolCPIfESgR8sgobXuzgqATxK1J8YLxYIaiLSOAW0M5qwh7U6Ng9uwCWqI0XuKjmDEOZK
 k5rrWZ8yX7dmnaiPsKOUqM2NicM/paC4aLDwxXjWx0U0nXIJIFDpY+N2Z8XQxZ4n0WNG6hYl2ev
 5P/6Kluj76ULLds75OueToHMOu3PJtyJMhgCDBZ85sv8bV/WI/xsA3BMIhxf9GcFDdcScalM6qf
 +zRi55wyFcK/ctopMuGBkrvG1Am2nl4phLrLcortp21i7lcHPsFI0RN2AZWntBrrI6EaCqfGorg
 4OMcy1TcfkBUl7zqZwPNgYW0+YJJUU
X-Received: by 2002:a17:90a:e70d:b0:369:3c3d:f899 with SMTP id
 98e67ed59e1d1-36a6ba28e3bmr3811530a91.2.1779487409653; 
 Fri, 22 May 2026 15:03:29 -0700 (PDT)
Received: from stoup.. ([50.78.183.177]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a6772f486sm1726789a91.2.2026.05.22.15.03.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 15:03:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v7 22/64] target/arm: Split vector-type.h from cpu.h
Date: Fri, 22 May 2026 15:02:24 -0700
Message-ID: <20260522220306.235200-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260522220306.235200-1-richard.henderson@linaro.org>
References: <20260522220306.235200-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
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
index 2a93de4132..85552b573c 100644
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


