Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A507D1098783
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 13:06:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3ZYk-00038b-Lf; Fri, 20 Mar 2026 09:06:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w3ZYa-0002za-Ea
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 09:06:28 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w3ZYX-00065X-Rz
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 09:06:28 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-666f646f5cfso4730392a12.1
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 06:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774011983; x=1774616783; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cAlPlaT/8Hy9mK47F+22fBNn4gCuZDEOegCdhpCflck=;
 b=X/1hJ3JY04EIZtG1oUJQtDZRQ2vQIlyL+eb6hKgrU9Gv0yYeqDtFU2wLB55e/S96Ej
 jelPO5EduyIw+XnNsbaPIjhc1nwKgNFkep7uXeFy4CJWBdQAHamA3G3m7GsmnvCdZfk7
 NdzcnzKrZHZqM1Zba2tldxWHHCNZYGh+tQca2OUnl++DeS4cVKBwAOLIorcXJFhPO2LG
 DrWxAM3vaOehgoAt5+6tJ3KXJMKohk7JEOYlLyJ8xrvxuf3Z9nK3scM7TBIV0Jsytn8h
 wCUTcy+fPdII4aLrgPlflNQXIBf5vkfUfPOD+4CLgRfOJJ/vr4MBUuqorJNvA8AQub6v
 E6nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774011983; x=1774616783;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cAlPlaT/8Hy9mK47F+22fBNn4gCuZDEOegCdhpCflck=;
 b=QpIF6f3sETRzHaBbrdUux6rXPKoUGL6xRPV/aHI8RuWPAhwsnSZe0MFd/CsXYKiepu
 cfshgUKTeDtfgGtoSnLpslnrmvM3DHChybJ3+wkihZeIJhu8RyWehW2g/lhE6f32xCo4
 shN9ZyM+pDOg/WHRZOoBuupjzju/mZWQNWi/PaW4Thw2TsMarm9204q5WfcbcpCeOUZp
 61Vm+iopQWMlQ2kM0XqRLdBr6wOoLNySTO1ki20EwyC8N0xvw43dgJ4cnvd/OCSzvtDf
 0ZKFVDn7XBNZ2BeogXTJoKTISduVqOQpQSjswLnnFM90APyCQ37/7YiUXdxLdiBGkYee
 vVHA==
X-Gm-Message-State: AOJu0YxrCUBbdVlJhorN4lekfVdPEHqBtYMcF6dLcX3sGIicPZ7wmnq/
 Ri9epDWNQQKu8vAsrD3ZZWzRQbGO0c34sAtSW7DIxqVh8yZPs4vBNrdgceNue8o5JB0=
X-Gm-Gg: ATEYQzwXUukoBGDJeM2VfnSwO0/tS3ca/TIfSdNoaKeof3+G18gRAF5Ieve67HskhMn
 BKoKDoaWAaKBTssYffly4ZMR8RtBj6hlUTWuOCEtqpjjdC2oDQDworKS9+AKknlIJ8DJDHIHyi0
 xEG8T5e6lNPsaRvBufVBQFaQ8xCjkfUXrA5IA58skAwwqyfj1mELNIMyiglRjB2Iny8EZc4Tsqx
 xrHWoDRcGWqLsBQHngseZegtJiAkiGIgJDiH6OLNcHJn6Kk3TAcLRE3xXBWJGpiWN1MQSNQLwKC
 Zo0FlHESMg4xrD8mKiOS3hhixkE13HbikVPJDiyH4XU2hJEBeOD9LvYq37ToIqPWoav+AHQPrQ1
 eaToNkyHrG61g42JYkgr+B0mylZiB/4nqnalhTN0tv8ioJLXFZ+GgUB9d8ih1uvckhfG41RY3gz
 7k31Q8ENLKiP5MlFYHT9BASw4=
X-Received: by 2002:a17:906:f2d4:b0:b8f:c684:db37 with SMTP id
 a640c23a62f3a-b982f39b0a4mr163030866b.9.1774011981969; 
 Fri, 20 Mar 2026 06:06:21 -0700 (PDT)
Received: from draig.lan ([185.124.0.237]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b983365f607sm154760966b.50.2026.03.20.06.06.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 06:06:17 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B8E605FAF9;
 Fri, 20 Mar 2026 13:06:10 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC PATCH 34/35] tests/tcg: create a mini-gic3 library
Date: Fri, 20 Mar 2026 13:06:05 +0000
Message-ID: <20260320130607.2071996-35-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260320130607.2071996-1-alex.bennee@linaro.org>
References: <20260320130607.2071996-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52e.google.com
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

Just enough GIC to trigger timer interrupts.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/aarch64/system/lib/gicv3.h      | 56 +++++++++++++++++
 tests/tcg/aarch64/system/lib/gicv3.c      | 77 +++++++++++++++++++++++
 tests/tcg/aarch64/Makefile.softmmu-target |  7 ++-
 3 files changed, 138 insertions(+), 2 deletions(-)
 create mode 100644 tests/tcg/aarch64/system/lib/gicv3.h
 create mode 100644 tests/tcg/aarch64/system/lib/gicv3.c

diff --git a/tests/tcg/aarch64/system/lib/gicv3.h b/tests/tcg/aarch64/system/lib/gicv3.h
new file mode 100644
index 00000000000..9a1268937c6
--- /dev/null
+++ b/tests/tcg/aarch64/system/lib/gicv3.h
@@ -0,0 +1,56 @@
+/*
+ * GICv3 Helper Library
+ *
+ * Copyright (c) 2024 Linaro Ltd
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef GICV3_H
+#define GICV3_H
+
+#include <stdint.h>
+
+/* Virt machine GICv3 base addresses */
+#define GICD_BASE       0x08000000  /* c.f. VIRT_GIC_DIST */
+#define GICR_BASE       0x080a0000  /* c.f. VIRT_GIC_REDIST */
+
+/* Distributor registers */
+#define GICD_CTLR       (GICD_BASE + 0x0000)
+#define GICD_TYPER      (GICD_BASE + 0x0004)
+#define GICD_IIDR       (GICD_BASE + 0x0008)
+
+/* Redistributor registers (per-CPU) */
+#define GICR_SGI_OFFSET 0x00010000
+
+#define GICR_CTLR       0x0000
+#define GICR_WAKER      0x0014
+#define GICR_IGROUPR0   (GICR_SGI_OFFSET + 0x0080)
+#define GICR_ISENABLER0 (GICR_SGI_OFFSET + 0x0100)
+#define GICR_IPRIORITYR0 (GICR_SGI_OFFSET + 0x0400)
+
+/* GICD_CTLR bits */
+#define GICD_CTLR_ARE_NS (1U << 4)
+#define GICD_CTLR_ENA_G1NS (1U << 1)
+#define GICD_CTLR_ENA_G0 (1U << 0)
+
+/* GICR_WAKER bits */
+#define GICR_WAKER_ChildrenAsleep (1U << 2)
+#define GICR_WAKER_ProcessorSleep (1U << 1)
+
+/**
+ * gicv3_init:
+ *
+ * Initialize GICv3 distributor and the redistributor for the current CPU.
+ */
+void gicv3_init(void);
+
+/**
+ * gicv3_enable_irq:
+ * @irq: The IRQ number to enable
+ *
+ * Enable the specified IRQ (SPI or PPI).
+ */
+void gicv3_enable_irq(unsigned int irq);
+
+#endif /* GICV3_H */
diff --git a/tests/tcg/aarch64/system/lib/gicv3.c b/tests/tcg/aarch64/system/lib/gicv3.c
new file mode 100644
index 00000000000..a09a0e430e6
--- /dev/null
+++ b/tests/tcg/aarch64/system/lib/gicv3.c
@@ -0,0 +1,77 @@
+/*
+ * GICv3 Helper Library Implementation
+ *
+ * Copyright (c) 2024 Linaro Ltd
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "gicv3.h"
+
+#define write_sysreg(r, v) do {                     \
+        uint64_t __val = (uint64_t)(v);             \
+        asm volatile("msr " #r ", %x0"              \
+                 : : "rZ" (__val));                 \
+} while (0)
+
+#define isb() asm volatile("isb" : : : "memory")
+
+static inline void write_reg(uintptr_t addr, uint32_t val)
+{
+    *(volatile uint32_t *)addr = val;
+}
+
+static inline uint32_t read_reg(uintptr_t addr)
+{
+    return *(volatile uint32_t *)addr;
+}
+
+void gicv3_init(void)
+{
+    uint32_t val;
+
+    /* 1. Enable Distributor ARE and Group 1 NS */
+    val = read_reg(GICD_CTLR);
+    val |= GICD_CTLR_ARE_NS | GICD_CTLR_ENA_G1NS;
+    write_reg(GICD_CTLR, val);
+
+    /* 2. Wake up Redistributor 0 */
+    /* Clear ProcessorSleep */
+    val = read_reg(GICR_BASE + GICR_WAKER);
+    val &= ~GICR_WAKER_ProcessorSleep;
+    write_reg(GICR_BASE + GICR_WAKER, val);
+
+    /* Wait for ChildrenAsleep to be cleared */
+    while (read_reg(GICR_BASE + GICR_WAKER) & GICR_WAKER_ChildrenAsleep) {
+        /* spin */
+    }
+
+    /* 3. Enable CPU interface */
+    /* Set Priority Mask to allow all interrupts */
+    write_sysreg(ICC_PMR_EL1, 0xff);
+    /* Enable Group 1 Non-Secure interrupts */
+    write_sysreg(ICC_IGRPEN1_EL1, 1);
+    isb();
+}
+
+void gicv3_enable_irq(unsigned int irq)
+{
+    if (irq < 32) {
+        /* PPI: use GICR_ISENABLER0 */
+        uintptr_t addr;
+
+        /* Set Group 1 */
+        addr = GICR_BASE + GICR_IGROUPR0;
+        write_reg(addr, read_reg(addr) | (1U << irq));
+
+        /* Set priority (0xa0) */
+        addr = GICR_BASE + GICR_IPRIORITYR0 + irq;
+        *(volatile uint8_t *)addr = 0xa0;
+
+        /* Enable it */
+        addr = GICR_BASE + GICR_ISENABLER0;
+        write_reg(addr, 1U << irq);
+    } else {
+        /* SPI: not implemented yet */
+    }
+}
diff --git a/tests/tcg/aarch64/Makefile.softmmu-target b/tests/tcg/aarch64/Makefile.softmmu-target
index f7a7d2b800f..c0939a0eeca 100644
--- a/tests/tcg/aarch64/Makefile.softmmu-target
+++ b/tests/tcg/aarch64/Makefile.softmmu-target
@@ -4,8 +4,9 @@
 
 AARCH64_SRC=$(SRC_PATH)/tests/tcg/aarch64
 AARCH64_SYSTEM_SRC=$(AARCH64_SRC)/system
+AARCH64_SYSTEM_LIB_SRC=$(AARCH64_SYSTEM_SRC)/lib
 
-VPATH+=$(AARCH64_SYSTEM_SRC)
+VPATH+=$(AARCH64_SYSTEM_SRC) $(AARCH64_SYSTEM_LIB_SRC)
 
 # These objects provide the basic boot code and helper functions for all tests
 CRT_OBJS=boot.o
@@ -24,7 +25,7 @@ LINK_SCRIPT=$(AARCH64_SYSTEM_SRC)/kernel.ld
 LDFLAGS=-Wl,-T$(LINK_SCRIPT)
 TESTS+=$(AARCH64_TESTS) $(MULTIARCH_TESTS)
 EXTRA_RUNS+=$(MULTIARCH_RUNS)
-CFLAGS+=-nostdlib -ggdb -O0 $(MINILIB_INC)
+CFLAGS+=-nostdlib -ggdb -O0 $(MINILIB_INC) -I$(AARCH64_SYSTEM_LIB_SRC)
 LDFLAGS+=-static -nostdlib $(CRT_OBJS) $(MINILIB_OBJS) -lgcc
 
 config-cc.mak: Makefile
@@ -102,6 +103,8 @@ run-pauth-3:
 	$(call skip-test, "RUN of pauth-3", "not built")
 endif
 
+gicv3.o: gicv3.c gicv3.h
+	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -c $< -o $@
 ifneq ($(CROSS_CC_HAS_ARMV8_MTE),)
 QEMU_MTE_ENABLED_MACHINE=-M virt,mte=on -cpu max -display none
 QEMU_OPTS_WITH_MTE_ON = $(QEMU_MTE_ENABLED_MACHINE) $(QEMU_BASE_ARGS) -kernel
-- 
2.47.3


