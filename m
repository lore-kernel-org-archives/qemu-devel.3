Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F640F436BD
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 16:44:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDmIO-0003SA-Uy; Fri, 17 Apr 2026 12:43:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wDmI6-0003OP-LG
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 12:43:38 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wDmI4-0004tD-EV
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 12:43:38 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-43fe608cb92so529484f8f.2
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2026 09:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776444214; x=1777049014; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=liTcDcF3GIDEEzIN8ew1+DtNcgI89x7Dsh408ugPSo4=;
 b=Hr2HUZcxwZngdf2ghSBOHVI+OPF3EyO0j+b+I7GFvNfXvXc8bum5ACtth25+nxWWGK
 jOtD2r8gYIK2zi+hOmQmKTbpIA5Icx1zFLu4w1lXgooU/ySYuna9BNPlhED+kQy/ptHP
 GL3dZAagWcK1eBhWXVY1fn4N+QzGvqvE15Cfr4Ozb+KUk1F2peLuhmTs077M9fqLj+u7
 8zv8hlD0u1cKe2GIZlDHvLFT9M/Qp5ErI6cGKJEdQI4RuDZlihVgdSoR7mN/nIzBITxt
 rRFujLZbtMbODXLE/NabvTzAIgQheoTN6lJMq3ZSFBl58yj1Pcbdoumc5hkvRoORVtQP
 x2OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776444214; x=1777049014;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=liTcDcF3GIDEEzIN8ew1+DtNcgI89x7Dsh408ugPSo4=;
 b=NkFft7EoEfaaqxo+x+oMpd2h5PmrTRqHHplHVgy3djl7BOyo6m7RMgzElu91+fcu2T
 nCIUn32fhpozfPYFR5p/H/zBB5nBzSGnhFTHceV8N2dLFerXlb+VUF3exhfVHA28f81L
 O+YcjybJ8DvqMtK6Pep1NTGPjRiuNcG52oQU0zGXjqghpu7VhvwFSAPEJS0kM5WEs7QL
 N3G9DUZmKfcj02Q5wgoISi1qyL5+Ox9u6gdaKf8ae8waOeG9bj9FNI+g/tsq5wMvSDBp
 bGQqJj2F5SuhfGOpteOsp0KnAKx71949snAuejqhpkfD1gT6Mdgll2mLZb6yGBqAuMGl
 3Rog==
X-Gm-Message-State: AOJu0Yy0s60MV972S9p4i8TcP1oTD125EVQMnBAh02b1LrSaSyGolmAt
 CXBc09leBpJUQhdYIoz6j1GIa7Xj0ZAHP22E8+tZAmeSokCdV823TrfyVUtBF5bcpCY=
X-Gm-Gg: AeBDieuqMY/KEFhUUXbGaaPVdNDdj94BwK83iM7dRWwWRWQDhF99uVeN2dE7ykp4EE8
 0TY/YAThc3iyKm6dBWdon5QvkGWJGaNqL5fKXtVMd3Q99C0DB9O98n0WGabz7WprawUk5Bps89f
 q9xjO50l42WmcpJ4mBoVzg0Jj1dkk5ov2oeLtxSNLAihphb0gSpoBLbd2LlE6FkNFOGWbNHJWg+
 tIXRc+igRXsM0qU6xaRMpvakrkOvSQBwYaXrQBGhblqqMT7qzUfuxwr+RwgnGOk1HQTS5myarZv
 e2J8SaZZG5NeCrDQS7HCKibDtEl8vInHQtJwC5gGpDwxsT+6F6HeGnp2RTx38/q1pRgmZgutsDl
 XFYB3peW8teztiOCDW+dmtYUt3yON4wTS9W/cRL2y4baUzSpD8/hwQPN+KAS6rCUIpMyb2o6nWB
 wsnU0yoYsEEfJEuSbKWq/S+6qPBWsA+gHrBg==
X-Received: by 2002:a05:6000:2005:b0:43d:77a8:3ba7 with SMTP id
 ffacd0b85a97d-43fe3e12484mr5358574f8f.44.1776444214270; 
 Fri, 17 Apr 2026 09:43:34 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e3a7b4sm5579073f8f.22.2026.04.17.09.43.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 09:43:32 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 25F2C5FA53;
 Fri, 17 Apr 2026 17:43:29 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 7/7] tests/tcg: add basic test for aarch64 wf[ie][t] insns
Date: Fri, 17 Apr 2026 17:43:27 +0100
Message-ID: <20260417164328.1009132-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260417164328.1009132-1-alex.bennee@linaro.org>
References: <20260417164328.1009132-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42f.google.com
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

This is based on a generated test case which I've since refined and
cleaned up.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/aarch64/system/wfx.c            | 143 ++++++++++++++++++++++
 tests/tcg/aarch64/Makefile.softmmu-target |   8 ++
 tests/tcg/aarch64/system/boot.S           |  16 ++-
 3 files changed, 164 insertions(+), 3 deletions(-)
 create mode 100644 tests/tcg/aarch64/system/wfx.c

diff --git a/tests/tcg/aarch64/system/wfx.c b/tests/tcg/aarch64/system/wfx.c
new file mode 100644
index 00000000000..fa4c6761215
--- /dev/null
+++ b/tests/tcg/aarch64/system/wfx.c
@@ -0,0 +1,143 @@
+/*
+ * WFX Instructions Test (WFI, WFE, WFIT, WFET)
+ *
+ * Copyright (c) 2026 Linaro Ltd
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <stdint.h>
+#include <stdbool.h>
+#include <minilib.h>
+#include "sysregs.h"
+#include "gicv3.h"
+
+#define TIMEOUT 200000
+
+#define sev() asm volatile("sev" : : : "memory")
+#define sevl() asm volatile("sevl" : : : "memory")
+#define wfi() asm volatile("wfi" : : : "memory")
+#define wfe() asm volatile("wfe" : : : "memory")
+#define wfit(reg) asm volatile("wfit %0" : : "r" (reg) : "memory")
+#define wfet(reg) asm volatile("wfet %0" : : "r" (reg) : "memory")
+
+#define enable_irq()  asm volatile("msr daifclr, #2" : : : "memory")
+#define disable_irq() asm volatile("msr daifset, #2" : : : "memory")
+
+static bool check_elapsed(uint64_t start, uint64_t threshold, const char *test, bool more)
+{
+    uint64_t end = read_sysreg(cntvct_el0);
+    uint64_t elapsed = end - start;
+    if (more ? elapsed < threshold : elapsed > threshold) {
+        ml_printf("FAILED: %s %s (%ld ticks)\n", test,
+                  more ? "woke too early" : "slept despite SEV",
+                  elapsed);
+        return false;
+    }
+    ml_printf("PASSED (%ld ticks)\n", elapsed);
+    return true;
+}
+
+int main(void)
+{
+    uint64_t start, timeout;
+
+    gicv3_init();
+    gicv3_enable_irq(27); /* Virtual Timer PPI */
+
+    ml_printf("WFx[T] Tests\n");
+
+    /*
+     * 1. Test WFI with timer interrupt
+     *
+     * We don't have a full interrupt handler, but WFI should wake up
+     * when the interrupt is pending even if we have it masked at the CPU.
+     * PSTATE.I is set by boot code.
+     *
+     * We unmask interrupts here to ensure the CPU can take the minimal
+     * exception handler defined in boot.S.
+     */
+    ml_printf("Testing WFI...");
+
+    start = read_sysreg(cntvct_el0);
+    write_sysreg(TIMEOUT, cntv_tval_el0);
+    write_sysreg(1, cntv_ctl_el0); /* Enable timer, no mask */
+    isb();
+
+    enable_irq();
+    wfi();
+    disable_irq();
+
+    if (!check_elapsed(start, TIMEOUT, "WFI", true)) {
+        return 1;
+    }
+
+    /* Validate the timer fired and then disable for future tests */
+    if (!read_sysreg(cntv_ctl_el0) & 0x4) {
+        ml_printf("Time ISTATUS not set!\n");
+        return 1;
+    }
+    write_sysreg(0, cntv_ctl_el0);
+
+    /*
+     * 2. Test WFE and SEV[L]
+     *
+     * There are two SEV instructions, the normal one is a broadcast
+     * from any PE on the system, the other is local only.
+     * Functionally they have the same effect (setting the event
+     * register) and should be immediately consumed by the WFE.
+     *
+     * As we want to detect an early exit the sense of the timeout
+     * check is reversed.
+     */
+    ml_printf("Testing WFE/SEV...");
+    sev();
+    start = read_sysreg(cntvct_el0);
+    wfe();
+    if (!check_elapsed(start, TIMEOUT, "WFE", false)) {
+        return 1;
+    }
+
+    ml_printf("Testing WFE/SEVL...");
+    sevl();
+    start = read_sysreg(cntvct_el0);
+    wfe();
+    if (!check_elapsed(start, TIMEOUT, "WFE", false)) {
+        return 1;
+    }
+
+    /*
+     * 3. Test WFIT
+     *
+     * With the timer now disabled and no other IRQ sources firing the
+     * WFIT instruction should timeout. Although the architecture
+     * permits this being treated as a NOP we have enabled it.
+     */
+    ml_printf("Testing WFIT...");
+    start = read_sysreg(cntvct_el0);
+    timeout = start + TIMEOUT;
+    wfit(timeout);
+    if (!check_elapsed(start, TIMEOUT, "WFIT", true)) {
+        return 1;
+    }
+
+    /*
+     * 4. Test WFET
+     *
+     * Much like WFIT there are no IRQs to wake us up. However the
+     * event_register is a latch so we must first consume the event
+     * register with a normal WFE before we do the timeout version.
+       */
+    ml_printf("Testing WFET...");
+    sev();
+    wfe();
+    start = read_sysreg(cntvct_el0);
+    timeout = start + TIMEOUT;
+    wfet(timeout);
+    if (!check_elapsed(start, TIMEOUT, "WFET", true)) {
+        return 1;
+    }
+
+    ml_printf("ALL WFX TESTS PASSED\n");
+    return 0;
+}
diff --git a/tests/tcg/aarch64/Makefile.softmmu-target b/tests/tcg/aarch64/Makefile.softmmu-target
index 543d638e819..6a1e867fba0 100644
--- a/tests/tcg/aarch64/Makefile.softmmu-target
+++ b/tests/tcg/aarch64/Makefile.softmmu-target
@@ -108,6 +108,14 @@ endif
 
 gicv3.o: gicv3.c gicv3.h
 	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -c $< -o $@
+
+wfx: CFLAGS += -march=armv8.7-a
+wfx: LDFLAGS += gicv3.o
+wfx: gicv3.o
+
+QEMU_GICV3_MACHINE=-M virt,gic-version=3 -cpu max -display none
+run-wfx: QEMU_OPTS=$(QEMU_GICV3_MACHINE) $(QEMU_BASE_ARGS) -kernel
+
 ifneq ($(CROSS_CC_HAS_ARMV8_MTE),)
 QEMU_MTE_ENABLED_MACHINE=-M virt,mte=on -cpu max -display none
 QEMU_OPTS_WITH_MTE_ON = $(QEMU_MTE_ENABLED_MACHINE) $(QEMU_BASE_ARGS) -kernel
diff --git a/tests/tcg/aarch64/system/boot.S b/tests/tcg/aarch64/system/boot.S
index bee8d9372e7..ba9000a749d 100644
--- a/tests/tcg/aarch64/system/boot.S
+++ b/tests/tcg/aarch64/system/boot.S
@@ -35,7 +35,7 @@ vector_table:
 
 	/* Current EL with SPx.	 */
 	ventry	curr_spx_sync		/* Synchronous	*/
-	ventry	curr_spx_irq		/* IRQ/vIRQ  */
+	ventry	curr_spx_irq		/* Basic handler for IRQ/vIRQ */
 	ventry	curr_spx_fiq		/* FIQ/vFIQ  */
 	ventry	curr_spx_serror		/* SError/VSError  */
 
@@ -54,13 +54,12 @@ vector_table:
 	.text
 	.align 4
 
-	/* Common vector handling for now */
+	/* Apart from curr_spx_irq we error out with an unexpected exception */
 curr_sp0_sync:
 curr_sp0_irq:
 curr_sp0_fiq:
 curr_sp0_serror:
 curr_spx_sync:
-curr_spx_irq:
 curr_spx_fiq:
 curr_spx_serror:
 lower_a64_sync:
@@ -275,6 +274,17 @@ _exit:
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


