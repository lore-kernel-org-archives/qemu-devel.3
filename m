Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EBD5F436BD
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 16:44:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDmIX-0003UL-T2; Fri, 17 Apr 2026 12:44:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wDmI6-0003OR-Ms
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 12:43:38 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wDmI4-0004tS-P7
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 12:43:38 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-43d73422431so669523f8f.2
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2026 09:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776444215; x=1777049015; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jegsx2j0KNykYcl6zcYZCE4ioLA7NDTkcLRBUWft0eM=;
 b=YnTkU+ywaq+Oma4fuB7LB5HL5Z66ujXPuieQU0ZN7a82dK+K3IkIhUaNZ2w1RbV37d
 jWC8NYKo2lxdL+LF90DTNVdNjV4NZPrGyvxTA7feMD9Kq1fj4S1eVLvNxLmG+fUycn5+
 +2XD/Jr79GuOde4GAvIqTReSJzLY6FSTRAjbG+gD9KugLm15LtMHRlbXs9Db7lh0+bOE
 cCnbj5tdy+Ev+bFHSXHfnb3COLARevy1iQG8e49aSFgMgp7NO4G3cWRJJSh7gflFq+8F
 XboGf3mNCPT76H27DJQDLJhEpCCkhQgCTMpqywY3BCQcABOFK717xakLwIliifTjJpkr
 cnvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776444215; x=1777049015;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Jegsx2j0KNykYcl6zcYZCE4ioLA7NDTkcLRBUWft0eM=;
 b=V5Oh0meVIxDCrbvcoSVupV/fyBQ9Qqu58kCIVAZ+ucyuG5yRaXJwlVcMmmJxO9O52I
 XJufJoCZ8rU1KORrrKPENtXBn5BCy4KhAklFP32DWU5cUZbiORIdYMuNFr3k4w9yyhuT
 NZeK8lEtVobdN61TIZ/BN8vgWyYFmyW6gi7Ij6xhFIIlarMApQh+ImoRvrBDejRsiKse
 kEncBBWkGPWuHTS+xqXHixWtB5k6UZF50M/Ac/GA7U2TNFUWcnXuAJZujj/eetgL51nE
 ApGH0qzpcZlSYzMYJX6yXdaGpL7pUs7I/+PY2VS4wmzO6/39VEwmIbNlCRGBz5Tl/X4/
 9F0w==
X-Gm-Message-State: AOJu0Ywu6ui4nYp6r6420o8dgMlEdbjii6fyQxred+ITktT9J42jEd+q
 A/mKPhLLW9gKforxcfI8t7l7B82qMauIXccq8OUigX91mTbK/pbnD8OAMA0YKgRfo4k=
X-Gm-Gg: AeBDiesLeaDtAj/bpQK0lxOjQoAiedT6ik47i1r/cpe2h9t3FPNzo3WnbRlygmchrZe
 cbrkFFo6rI8pP+moyRyrdUv22dq+NVC+NkwzmVnuRRL8q+XH9q1br2nsMv6VgoYBglelXA5Vl88
 eQmOVQ1p05LwWPSB9qQ2wCVcPreYVXiH0iJChj1bZcPgUJGM5au68zt/XnajRHURg2lGzo9tvHT
 iuti0WSK9fVtDHUiE+QAO8YZoVnlWu+YFwXXXaiGRI2uXeQsxRCVsVHB8/GCh9uZsVa+LhdTyhk
 /n8Sj/vXwF5l7CM8a5cFKUEqm6MP0CY0PZfcsx/4LCXrVqhTt/lQJZYJ44QSz6j/mU+Afsih576
 4W9fLbGpWkfXc+ghMwiDS86K+/JODKGyCDOujJN7MCjtpQTM0HJz4ZmgtkRSFJQH4+4f0wiLney
 KBx0URhmGNr+f4bpAPr7cvCg8pwl1n3Cm2GA==
X-Received: by 2002:a05:6000:1868:b0:43d:7a97:78af with SMTP id
 ffacd0b85a97d-43fe3e24bd3mr5618940f8f.42.1776444215022; 
 Fri, 17 Apr 2026 09:43:35 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4cb1249sm5031092f8f.5.2026.04.17.09.43.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 09:43:32 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0BA665FA43;
 Fri, 17 Apr 2026 17:43:29 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 6/7] tests/tcg: create a mini-gic3 library
Date: Fri, 17 Apr 2026 17:43:26 +0100
Message-ID: <20260417164328.1009132-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260417164328.1009132-1-alex.bennee@linaro.org>
References: <20260417164328.1009132-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42d.google.com
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
 tests/tcg/aarch64/system/lib/gicv3.h      | 60 +++++++++++++++++++
 tests/tcg/aarch64/system/lib/gicv3.c      | 70 +++++++++++++++++++++++
 tests/tcg/aarch64/Makefile.softmmu-target |  2 +
 3 files changed, 132 insertions(+)
 create mode 100644 tests/tcg/aarch64/system/lib/gicv3.h
 create mode 100644 tests/tcg/aarch64/system/lib/gicv3.c

diff --git a/tests/tcg/aarch64/system/lib/gicv3.h b/tests/tcg/aarch64/system/lib/gicv3.h
new file mode 100644
index 00000000000..05c4c2f538b
--- /dev/null
+++ b/tests/tcg/aarch64/system/lib/gicv3.h
@@ -0,0 +1,60 @@
+/*
+ * GICv3 Helper Library
+ *
+ * Copyright (c) 2026 Linaro Ltd
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef GICV3_H
+#define GICV3_H
+
+/*
+ * This duplicates just the bits of hw/intc/gicv3_internal.h we
+ * need for basic functionality.
+ */
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
+
+#define GICR_IGROUPR0   (GICR_SGI_OFFSET + 0x0080)
+#define GICR_ISENABLER0 (GICR_SGI_OFFSET + 0x0100)
+#define GICR_IPRIORITYR (GICR_SGI_OFFSET + 0x0400)
+
+/* GICD_CTLR fields */
+#define GICD_CTLR_ENA_GRP0   (1U << 0)
+#define GICD_CTLR_ENA_GRP1NS (1U << 1)
+#define GICD_CTLR_ARE_NS     (1U << 5)
+
+/* GICR_WAKER bits */
+#define GICR_WAKER_ProcessorSleep (1U << 1)
+#define GICR_WAKER_ChildrenAsleep (1U << 2)
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
index 00000000000..9cfd033a8ec
--- /dev/null
+++ b/tests/tcg/aarch64/system/lib/gicv3.c
@@ -0,0 +1,70 @@
+/*
+ * GICv3 Helper Library Implementation
+ *
+ * Copyright (c) 2026 Linaro Ltd
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <stdint.h>
+#include "sysregs.h"
+#include "gicv3.h"
+
+static inline void write_reg(uintptr_t addr, uint32_t val)
+{
+    *(volatile uint32_t *) addr = val;
+}
+
+static inline uint32_t read_reg(uintptr_t addr)
+{
+    return *(volatile uint32_t *) addr;
+}
+
+void gicv3_init(void)
+{
+    uint32_t val;
+
+    /* 1. Enable Distributor ARE and Group 1 NS */
+    val = read_reg(GICD_CTLR);
+    val |= GICD_CTLR_ARE_NS | GICD_CTLR_ENA_GRP1NS;
+    write_reg(GICD_CTLR, val);
+
+    /* 2. Wake up Redistributor 0 and clear ProcessorSleep */
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
+    write_sysreg(0xff, ICC_PMR_EL1);
+    /* Enable Group 1 Non-Secure interrupts */
+    write_sysreg(1, ICC_IGRPEN1_EL1);
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
+        addr = GICR_BASE + GICR_IPRIORITYR + irq;
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
index 5770ae1fb0c..543d638e819 100644
--- a/tests/tcg/aarch64/Makefile.softmmu-target
+++ b/tests/tcg/aarch64/Makefile.softmmu-target
@@ -106,6 +106,8 @@ run-pauth-3:
 	$(call skip-test, "RUN of pauth-3", "not built")
 endif
 
+gicv3.o: gicv3.c gicv3.h
+	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -c $< -o $@
 ifneq ($(CROSS_CC_HAS_ARMV8_MTE),)
 QEMU_MTE_ENABLED_MACHINE=-M virt,mte=on -cpu max -display none
 QEMU_OPTS_WITH_MTE_ON = $(QEMU_MTE_ENABLED_MACHINE) $(QEMU_BASE_ARGS) -kernel
-- 
2.47.3


