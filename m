Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C915E9B25A
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 12:12:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vurFe-0005fg-U1; Tue, 24 Feb 2026 07:10:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vurFJ-0005aP-9Z
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 07:10:34 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vurFB-0005sj-J3
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 07:10:32 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-65c0e2cbde1so9373345a12.0
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 04:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771935020; x=1772539820; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ptd0y3gAC5QENHI0CgxkdBmiUWNBddi1bewDX6MYILQ=;
 b=UrGSJbIOouzrV3bwBF+Wp9d3/BAh8wZ5ytGjUX8uN0qsfsEKjEffug/3wUyHsKv7iw
 DHiOrKNVSLxQ84rCROdfDVSfVAk/SpAc0UAsDTjS4UjIc2JrlJFEHkzvwu1GKmV4ob3i
 fAuVYtP4X16IhkukB6+t7U4S9fuslDq8lWitOSfZ3PckPDUpBc35h25PYW8cmN6Cchgb
 0FgT54Mk99bRt2lDdba++hSin4piE1q32mCwHjIEEPStFFlXWAfWU2gA0XkxpCBIBfam
 ADuiOPIZG4SX85jzlxRQZ2ec+GwOmWgcVuYTcPfvcTsbHCFb5Vce0Ut1bY9tXtijzV/h
 0EbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771935020; x=1772539820;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ptd0y3gAC5QENHI0CgxkdBmiUWNBddi1bewDX6MYILQ=;
 b=cE0bWa7t/apWfXrEnVMwh8sR0+VNDZzidMxGDmBorGElONuM/F/XT2i1V0cwWaPldB
 zToAFJuO4sM4NY0QiFExk3iIWgWJFScIWZdRsLNg9H4g1ohW0UmzkZwlnhr4H1CQEUDo
 WPxoBsdlVM99HVBugmEuMFBxV6ijdGlIaKbZqCKCtZ3RV12i527JvAVgnw7juhc3wz9g
 4hCo9qLiVJjego9Z/E4fs5k3kR9Bpyiv5ueitrLHzX+F2hXvUQKR35qFOciUQyt7TucW
 ikXz6F/kNgyqqL3jTeSeepyW8/tB7cO1CAbGsXNZoiafmdKrQDVUzuUR64P20/bO5AAE
 6agQ==
X-Gm-Message-State: AOJu0YzF298A0rRaYgCXwA1m6c2PIVLpoXn2m4+ZsmqP5itvMGQU7rXT
 ADxDQO1OI7OaZAPkxWhRmlx8u5Wuzcq/KhGRfxMDe3HH2acKLlfgF4a97BcDmFDi3ig=
X-Gm-Gg: ATEYQzzdMiPRhYHI4l3Pb40pFK919FT1JPRlFEwlzB3jWOxT1MdbXgILZZ/KgTvJN8O
 AMW5tKjtp/+ZlKrWNhUJssX3iu5ZboTL2kzcevsiy0//MKxPTr2BzD2XtgVnOS6FcB6FTS89PtI
 MT6gsAbU7ud9j8+6JxLw+bm3UkUgmL63jyrv4nDal52cMBe+TF+QJJZZ2TSfYPKvjR8j+Wun3Xt
 TWXJw6tjU441Ty4FRjGtE+mBjLjXjh+nEi/cBoLxafmbtCKG+KGYEVqcPxmdcc63AGhVp3MscR9
 oFuW9jRwlG1lJlChsrtZYUm8jzSpZrFqWWUHnwYFXVhFGYMaF02YlNehWiAv2ocP5lk6tcgGXF8
 8tL2LXCK2hOkE1ioZC3yeEp1hrYt0XQaEx2D66GZGwAvCBT5teH94IM29bgy49pYFKHK4JTJxwg
 peTJDA/4v64eBErCE85MykNe0=
X-Received: by 2002:a17:907:1b1c:b0:b8e:d260:cb20 with SMTP id
 a640c23a62f3a-b9081a09c97mr790538666b.18.1771935019481; 
 Tue, 24 Feb 2026 04:10:19 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b90ba93bcfesm111868466b.60.2026.02.24.04.10.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 04:10:18 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 415065F8D7;
 Tue, 24 Feb 2026 12:10:15 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 7/8] tests/tcg/aarch64: fixes for WFX instructions system test
Date: Tue, 24 Feb 2026 12:10:13 +0000
Message-ID: <20260224121014.279248-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260224121014.279248-1-alex.bennee@linaro.org>
References: <20260224121014.279248-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This required some iteration with the model to add bits it missed in
the initial implementation. I ended up debugging and then prompting
for the missing bits:

  - a basic gicv3 implementation
  - a couple of rounds of tweaking the config
  - mapping the GIC via page tables
  - fixing the compilation of the support library
  - extending the elapsed time check for WFE
  - light re-ordering of Makefile, setting correct machine opts

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/aarch64/system/lib/gicv3.h      | 56 +++++++++++++++++
 tests/tcg/aarch64/system/lib/gicv3.c      | 77 +++++++++++++++++++++++
 tests/tcg/aarch64/system/wfx.c            | 17 ++++-
 tests/tcg/aarch64/Makefile.softmmu-target | 13 +++-
 tests/tcg/aarch64/system/boot.S           | 55 ++++++++++------
 5 files changed, 196 insertions(+), 22 deletions(-)
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
diff --git a/tests/tcg/aarch64/system/wfx.c b/tests/tcg/aarch64/system/wfx.c
index 59436c381fd..567d9e59c70 100644
--- a/tests/tcg/aarch64/system/wfx.c
+++ b/tests/tcg/aarch64/system/wfx.c
@@ -8,6 +8,7 @@
 
 #include <stdint.h>
 #include <minilib.h>
+#include "gicv3.h"
 
 #define __stringify_1(x...) #x
 #define __stringify(x...)   __stringify_1(x)
@@ -31,6 +32,9 @@
 #define wfit(reg) asm volatile("wfit %0" : : "r" (reg) : "memory")
 #define wfet(reg) asm volatile("wfet %0" : : "r" (reg) : "memory")
 
+#define enable_irq()  asm volatile("msr daifclr, #2" : : : "memory")
+#define disable_irq() asm volatile("msr daifset, #2" : : : "memory")
+
 static void wait_ticks(uint64_t ticks)
 {
     uint64_t start = read_sysreg(cntvct_el0);
@@ -44,6 +48,9 @@ int main(void)
     uint64_t start, end, elapsed;
     uint64_t timeout;
 
+    gicv3_init();
+    gicv3_enable_irq(27); /* Virtual Timer PPI */
+
     ml_printf("WFX Test\n");
 
     /* 1. Test WFI with timer interrupt */
@@ -58,8 +65,13 @@ int main(void)
      * We don't have a full interrupt handler, but WFI should wake up
      * when the interrupt is pending even if we have it masked at the CPU.
      * PSTATE.I is set by boot code.
+     *
+     * We unmask interrupts here to ensure the CPU can take the minimal
+     * exception handler defined in boot.S.
      */
+    enable_irq();
     wfi();
+    disable_irq();
     end = read_sysreg(cntvct_el0);
     elapsed = end - start;
     if (elapsed < 100000) {
@@ -76,11 +88,12 @@ int main(void)
     wfe(); /* Should return immediately */
     end = read_sysreg(cntvct_el0);
     elapsed = end - start;
-    if (elapsed > 1000) { /* Should be very fast */
+    /* while this should be fast there is some overhead from TCG */
+    if (elapsed > 20000) {
         ml_printf("FAILED: WFE slept despite SEV (%ld ticks)\n", elapsed);
         return 1;
     }
-    ml_printf("PASSED\n");
+    ml_printf("PASSED (%ld ticks)\n", elapsed);
 
     /* 3. Test WFIT */
     ml_printf("Testing WFIT...");
diff --git a/tests/tcg/aarch64/Makefile.softmmu-target b/tests/tcg/aarch64/Makefile.softmmu-target
index 84342c52cd7..9a5b95de621 100644
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
@@ -102,7 +103,15 @@ run-pauth-3:
 	$(call skip-test, "RUN of pauth-3", "not built")
 endif
 
+gicv3.o: gicv3.c gicv3.h
+	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -c $< -o $@
+
 wfx: CFLAGS += -march=armv8.7-a
+wfx: LDFLAGS += gicv3.o
+wfx: gicv3.o
+
+QEMU_GICV3_MACHINE=-M virt,gic-version=3 -cpu max -display none
+run-wfx: QEMU_OPTS=$(QEMU_GICV3_MACHINE) $(QEMU_BASE_ARGS) -kernel
 
 ifneq ($(CROSS_CC_HAS_ARMV8_MTE),)
 QEMU_MTE_ENABLED_MACHINE=-M virt,mte=on -cpu max -display none
diff --git a/tests/tcg/aarch64/system/boot.S b/tests/tcg/aarch64/system/boot.S
index 8bfa4e4efc7..6a71fc0da5a 100644
--- a/tests/tcg/aarch64/system/boot.S
+++ b/tests/tcg/aarch64/system/boot.S
@@ -60,7 +60,6 @@ curr_sp0_irq:
 curr_sp0_fiq:
 curr_sp0_serror:
 curr_spx_sync:
-curr_spx_irq:
 curr_spx_fiq:
 curr_spx_serror:
 lower_a64_sync:
@@ -248,29 +247,34 @@ at_testel:
 	msr	ttbr0_el1, x0
 
 	/*
-	 * Setup a flat address mapping page-tables. Stage one simply
-	 * maps RAM to the first Gb. The stage2 tables have two 2mb
-	 * translation block entries covering a series of adjacent
-	 * 4k pages.
+	 * Setup a flat address mapping page-tables.
+	 *
+	 * ttb (Level 1):
+	 *   - Entry 0 [0 - 1GB]: 1GB Device block (for GIC and other H/W)
+	 *   - Entry 1 [1GB - 2GB]: Table entry pointing to ttb_stage2 (for RAM)
 	 */
 
-	/* Stage 1 entry: indexed by IA[38:30] */
-	adr	x1, .				/* phys address */
-	bic	x1, x1, #(1 << 30) - 1		/* 1GB alignment*/
-	add	x2, x0, x1, lsr #(30 - 3)	/* offset in l1 page table */
+	/* Entry 0: 1GB Device block mapping at 0x0 */
+	ldr	x1, =0x401 | (1 << 2)		/* AF=1, block, AttrIndx=Attr1 (Device) */
+	str	x1, [x0]
 
-	/* point to stage 2 table [47:12] */
-	adrp	x0, ttb_stage2
-	orr 	x1, x0, #3 			/* ptr to stage 2 */
-	str	x1, [x2]
+	/* Entry 1: Table entry pointing to ttb_stage2 */
+	adrp	x1, ttb_stage2
+	orr 	x1, x1, #3 			/* ptr to table (type=3) */
+	str	x1, [x0, #8]
 
-	/* Stage 2 entries: indexed by IA[29:21] */
+	/* Stage 2 entries: indexed by IA[29:21] (within 1GB-2GB range) */
+	adrp	x0, ttb_stage2
+	add	x0, x0, :lo12:ttb_stage2
 	ldr	x5, =(((1 << 9) - 1) << 21)
 
 	/* First block: .text/RO/execute enabled */
 	adr	x1, .				/* phys address */
 	bic	x1, x1, #(1 << 21) - 1		/* 2mb block alignment	*/
-	and	x4, x1, x5			/* IA[29:21] */
+	/* Note: we assume RAM is in the 1GB-2GB range, so IA[30] is 1 */
+	mov	x4, x1
+	bic	x4, x4, #(1 << 30)		/* remove 1GB offset for L2 index */
+	and	x4, x4, x5			/* IA[29:21] */
 	add	x2, x0, x4, lsr #(21 - 3)	/* offset in l2 page table */
 	ldr	x3, =0x401			/* attr(AF, block) */
 	orr	x1, x1, x3
@@ -280,7 +284,9 @@ at_testel:
 	adrp	x1, .data
 	add	x1, x1, :lo12:.data
 	bic	x1, x1, #(1 << 21) - 1		/* 2mb block alignment */
-	and	x4, x1, x5			/* IA[29:21] */
+	mov	x4, x1
+	bic	x4, x4, #(1 << 30)		/* remove 1GB offset for L2 index */
+	and	x4, x4, x5			/* IA[29:21] */
 	add	x2, x0, x4, lsr #(21 - 3)	/* offset in l2 page table */
 	ldr	x3, =(3 << 53) | 0x401		/* attr(AF, NX, block) */
 	orr	x1, x1, x3
@@ -290,7 +296,9 @@ at_testel:
 	adrp	x1, mte_page
 	add	x1, x1, :lo12:mte_page
 	bic	x1, x1, #(1 << 21) - 1
-	and 	x4, x1, x5
+	mov	x4, x1
+	bic	x4, x4, #(1 << 30)		/* remove 1GB offset for L2 index */
+	and 	x4, x4, x5
 	add	x2, x0, x4, lsr #(21 - 3)
 	/* attr(AF, NX, block, AttrIndx=Attr1) */
 	ldr	x3, =(3 << 53) | 0x401 | (1 << 2)
@@ -317,7 +325,7 @@ at_testel:
 	ldr	x0, = (2 << 32) | 25 | (3 << 10) | (3 << 8)
 	msr	tcr_el1, x0
 
-	mov	x0, #0xee			/* Inner/outer cacheable WB */
+	ldr	x0, =0x04ee			/* Attr1: Device-nGnRE, Attr0: Normal WB */
 	msr	mair_el1, x0
 	isb
 
@@ -370,6 +378,17 @@ _exit:
 	semihosting_call
 	/* never returns */
 
+	/*
+	 * IRQ handler
+	 */
+	.global curr_spx_irq
+curr_spx_irq:
+	/* Minimal IRQ handler: just mask the timer and return */
+	mrs	x0, cntv_ctl_el0
+	orr	x0, x0, #2		/* IMASK=1 */
+	msr	cntv_ctl_el0, x0
+	eret
+
 	/*
 	 * Helper Functions
 	*/
-- 
2.47.3


