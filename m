Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21926CD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 11:19:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSCHc-0007RA-PE; Wed, 27 May 2026 07:18:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wSCHY-0007Qx-EL
 for qemu-devel@nongnu.org; Wed, 27 May 2026 07:18:42 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wSCHW-0000vC-Bj
 for qemu-devel@nongnu.org; Wed, 27 May 2026 07:18:40 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-44e5624c053so6919402f8f.2
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 04:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779880716; x=1780485516; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0QGieyo5gKzeqh6AipqQcO1qteBU8LLbZeI6OWN5t84=;
 b=zc1hjmvmhZPX/Hz3c9QdUl9I27GYTkuI9lSTt03eCIB2uT+E+nJTorVJKgJdNiLQWD
 BAuJ4ObHkuX0NOpeK0A0cQA6yJCn1JEcF48erB0tEKBaIbeaK8/0cRo1+6phCeHuEq/l
 fCtxHxDRuedQfs4LIVdJ1cLa5UqcgHxxTAWmglkKglK73H4IcziFnWoHJcEHHkt/vCwl
 B8hlsBslknldrVg60SYxiLWAV5uijwnZe6zO+LYTisQleOxH7RvKQtpuInJdpuCBtMTs
 wXnXKk29hD6IEhQhCQNZWqvyBRk160XeAy95n8mp2IKNBu+wQZF71+puO+XStp7KY3yr
 8C8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779880716; x=1780485516;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0QGieyo5gKzeqh6AipqQcO1qteBU8LLbZeI6OWN5t84=;
 b=AKGsVwRHf8zKsXXT2W3jBudboh7MvyK4qJn+cliZfDL5L/B8GVy8I4k6TFNNORhc1I
 zElxSCrfADTCk2JtFpnx6Ib6jYqm2Skhf5/tbP1ZSnx1rK7PEIKiHpYsWFUv+dR51nYS
 R24pMU61cvciDDIVquU1JZc9ymaVinedh7iNmUQY60hSiC+Tk2IY418R7plF+003FW87
 pedv6zEuSAf2Gw6aDFdVOPwodbTeoG+4jv3CrNgc7j9sF56PeLXQv8agAbcJtd98Ts7r
 0HhHLWMPJYQClH4+i4WF/VKyJbwnwUGVfbxYEJS00PpXnnRVuBVIKAu7RN2F8nuJ8lSW
 ayCw==
X-Gm-Message-State: AOJu0Yw3x6eYzso7s29GlBQRNoCwVQg7z0CQnBnd5aSr2BM90XEjQbC3
 mhtkXNQ7YDewrVFHOjQ0uK6aFHk58p4BQlrP9JW5lUIbgbaB3HFYCv2ZQ5c7A74LbxE=
X-Gm-Gg: Acq92OEwem+y5VxDbF/DT2LeWDkwLhLp9wJjybhAw9IB6qJhzieQLzJD9mHQ6l8Rauv
 X6EnPIPB2MzhW2MGOn4zC2ZCMK0He4jvxu0wj5fA1IHFZPfNS8VPewFgsaSiYYpvQLAZAOjPw47
 x92zZLZiggj/YedI1XiDd7JMshfqyU3Urm71Dy7+O/tws2W2+O3GXEJYWZFksAc56U4QiJyFRVV
 r2KqR1dNXRJ208od7EMPuquKDScofHUf7E4OlN0ul2bHpQjAn/yBxGUpkAGXxxCr6RmNQU9vQ7g
 GhAhdiThdpQdbaEH6IwR5LY9B/V6/8qOLcI/8ldx2WhaTkw+TefzdxbPba17AMQfJ+oPRX5kg1Y
 iYk0BJ4GEFjJ05hfuPg0bPAjELycEio5dNVrxMpylRXanXzbxYbF1W7yfOxWzo1yb7hZArYFuhj
 uQ0WvGZdvMK/9m37GmIqlC2D1ZN5GObaOr1Q==
X-Received: by 2002:a05:6000:4606:b0:44a:b0a3:7c1a with SMTP id
 ffacd0b85a97d-45eb36b0126mr40044368f8f.24.1779880716257; 
 Wed, 27 May 2026 04:18:36 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45edb5b28absm5398550f8f.27.2026.05.27.04.18.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 04:18:35 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9ECBF5F7F0;
 Wed, 27 May 2026 12:18:34 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Andrew Jones <andrew.jones@linux.dev>,
 Alexandru Elisei <alexandru.elisei@arm.com>,
 Eric Auger <eric.auger@redhat.com>, kvmarm@lists.linux.dev (open list:ARM),
 kvm@vger.kernel.org (open list:Default mailing list)
Subject: [kvm-unit-tests PATCH v2] arm: add wfx test case
Date: Wed, 27 May 2026 12:18:21 +0100
Message-ID: <20260527111822.1563679-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x436.google.com
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

This is based on a similar test case I wrote for QEMU's tcg tests although
obviously able to take advantage of kvm-unit-tests additional plumbing for
dealing with the GIC and IRQs.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - drop TIMEOUT in favour of computed 10ms timeout
  - add comments for each test
  - use sevl for local clearing
  - set gic irc depending on CurrentEL
  - EOI the GIC
  - display elapsed ns (no float to do ms ;-)
  - fix some style issues
  - make test TCG only
---
 arm/Makefile.arm64        |   1 +
 lib/arm64/asm/processor.h |   7 ++
 lib/arm64/asm/sysreg.h    |   3 +
 arm/wfx.c                 | 187 ++++++++++++++++++++++++++++++++++++++
 arm/unittests.cfg         |   7 ++
 5 files changed, 205 insertions(+)
 create mode 100644 arm/wfx.c

diff --git a/arm/Makefile.arm64 b/arm/Makefile.arm64
index a40c830d..52b3f35d 100644
--- a/arm/Makefile.arm64
+++ b/arm/Makefile.arm64
@@ -64,6 +64,7 @@ tests += $(TEST_DIR)/cache.$(exe)
 tests += $(TEST_DIR)/debug.$(exe)
 tests += $(TEST_DIR)/fpu.$(exe)
 tests += $(TEST_DIR)/mte.$(exe)
+tests += $(TEST_DIR)/wfx.$(exe)
 
 include $(SRCDIR)/$(TEST_DIR)/Makefile.common
 
diff --git a/lib/arm64/asm/processor.h b/lib/arm64/asm/processor.h
index 32ddc1b3..2104036d 100644
--- a/lib/arm64/asm/processor.h
+++ b/lib/arm64/asm/processor.h
@@ -173,5 +173,12 @@ static inline bool system_supports_rndr(void)
 	return ((id_aa64isar0_el1 >> ID_AA64ISAR0_EL1_RNDR_SHIFT) & 0xf) != 0;
 }
 
+static inline bool system_supports_wfxt(void)
+{
+	u64 id_aa64isar2_el1 = read_sysreg_s(ID_AA64ISAR2_EL1);
+
+	return ((id_aa64isar2_el1 >> ID_AA64ISAR2_EL1_WFxT_SHIFT) & 0xf) != 0;
+}
+
 #endif /* !__ASSEMBLER__ */
 #endif /* _ASMARM64_PROCESSOR_H_ */
diff --git a/lib/arm64/asm/sysreg.h b/lib/arm64/asm/sysreg.h
index f2d05018..cb96a649 100644
--- a/lib/arm64/asm/sysreg.h
+++ b/lib/arm64/asm/sysreg.h
@@ -77,6 +77,9 @@ asm(
 #define ID_AA64ISAR0_EL1_RNDR_SHIFT	60
 #define ID_AA64PFR1_EL1_MTE_SHIFT	8
 
+#define ID_AA64ISAR2_EL1		sys_reg(3, 0, 0, 6, 2)
+#define ID_AA64ISAR2_EL1_WFxT_SHIFT	0
+
 #define ID_AA64MMFR0_EL1_FGT_SHIFT	56
 #define ID_AA64MMFR0_EL1_FGT_FGT2	0x2
 
diff --git a/arm/wfx.c b/arm/wfx.c
new file mode 100644
index 00000000..0825c5cb
--- /dev/null
+++ b/arm/wfx.c
@@ -0,0 +1,187 @@
+/*
+ * WFX Instructions Test (WFI, WFE, WFIT, WFET)
+ *
+ * Copyright (c) 2026 Linaro Ltd
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <libcflat.h>
+#include <asm/processor.h>
+#include <asm/gic.h>
+#include <asm/timer.h>
+#include <asm/io.h>
+
+#define sev() asm volatile("sev" : : : "memory")
+#define sevl() asm volatile("sevl" : : : "memory")
+#define wfi() asm volatile("wfi" : : : "memory")
+#define wfe() asm volatile("wfe" : : : "memory")
+
+#define wfit(reg) \
+	asm volatile(".arch armv8.7-a\n\twfit %0" : : "r" (reg) : "memory")
+#define wfet(reg) \
+	asm volatile(".arch armv8.7-a\n\twfet %0" : : "r" (reg) : "memory")
+
+uint64_t time_hz;
+uint64_t time_10ms;
+
+static void timer_handler(struct pt_regs *regs)
+{
+	u32 irqstat = gic_read_iar();
+	u32 irqnr = gic_iar_irqnr(irqstat);
+
+	/* Disable timer to stop IRQ from re-firing */
+	if (irqnr == TIMER_VTIMER_IRQ || irqnr == TIMER_HVTIMER_IRQ) {
+		write_sysreg(0, cntv_ctl_el0);
+		isb();
+	} else {
+		if (irqnr != GICC_INT_SPURIOUS)
+			gic_write_eoir(irqstat);
+		report_info("Unexpected interrupt: %d\n", irqnr);
+		return;
+	}
+
+	/* Also acknowledge EOI for the GIC */
+	gic_write_eoir(irqstat);
+}
+
+static bool check_elapsed(uint64_t start, uint64_t threshold, const char *test, bool more)
+{
+	uint64_t end = read_sysreg(cntvct_el0);
+	uint64_t elapsed = end - start;
+	bool pass = more ? elapsed >= threshold : elapsed <= threshold;
+
+	report(pass, "%s (%ld ticks / %ld ns)",
+	       test, elapsed, elapsed / (time_hz / 1000000));
+
+	if (!pass)
+		report_info("%s %s", test, more ? "woke too early" : "slept despite SEV");
+
+	return pass;
+}
+
+/*
+ * Test WFI with timer interrupt
+ *
+ * WFI should wake up when the interrupt is pending. We unmask
+ * interrupts here so they are taken and then check WFI actually
+ * did sleep rather than return straight away.
+ */
+static void test_wfi(void)
+{
+	uint64_t start;
+
+	report_info("Testing WFI...");
+
+	start = read_sysreg(cntvct_el0);
+	write_sysreg(time_10ms, cntv_tval_el0);
+	write_sysreg(1, cntv_ctl_el0); /* Enable timer, no mask */
+	isb();
+
+	local_irq_enable();
+	wfi();
+	local_irq_disable();
+
+	check_elapsed(start, time_10ms, "WFI", true);
+}
+
+/*
+ * Test WFE and SEV[L]
+ *
+ * There are two SEV instructions, the normal one is a broadcast
+ * from any PE on the system, the other is local only.
+ * Functionally they have the same effect (setting the event
+ * register) and should be immediately consumed by the WFE.
+ *
+ * As we want to detect an early exit the sense of the timeout
+ * check is reversed.
+ */
+static void test_wfe(void)
+{
+	uint64_t start;
+
+	report_info("Testing WFE/SEV...");
+	sev();
+	start = read_sysreg(cntvct_el0);
+	wfe();
+	check_elapsed(start, time_10ms, "WFE/SEV", false);
+
+	report_info("Testing WFE/SEVL...");
+	sevl();
+	start = read_sysreg(cntvct_el0);
+	wfe();
+	check_elapsed(start, time_10ms, "WFE/SEVL", false);
+}
+
+/*
+ * Test WFIT
+ *
+ * With the timer disabled and no other IRQ sources firing the
+ * WFIT instruction should timeout.
+ */
+static void test_wfit(void)
+{
+	uint64_t start, timeout;
+
+	report_info("Testing WFIT...");
+	start = read_sysreg(cntvct_el0);
+	timeout = start + time_10ms;
+	wfit(timeout);
+	check_elapsed(start, time_10ms, "WFIT", true);
+}
+
+/*
+ * Test WFET
+ *
+ * Much like WFIT there are no IRQs to wake us up. However the
+ * event_register is a latch so we must first consume the event
+ * register with a normal WFE before we do the timeout version.
+ */
+static void test_wfet(void)
+{
+	uint64_t start, timeout;
+
+	report_info("Testing WFET...");
+	/* Ensure no pending events */
+	sevl();
+	wfe();
+
+	start = read_sysreg(cntvct_el0);
+	timeout = start + time_10ms;
+	wfet(timeout);
+	check_elapsed(start, time_10ms, "WFET", true);
+}
+
+int main(void)
+{
+	uint32_t irq = current_level() == CurrentEL_EL1 ? TIMER_VTIMER_IRQ : TIMER_HVTIMER_IRQ;
+
+	if (gic_init() < 0) {
+		report_abort("GIC init failed");
+		return 1;
+	}
+
+	/* Install timer handler for WFI wake-up */
+	install_irq_handler(EL1H_IRQ, timer_handler);
+	gic_enable_defaults();
+	time_hz = read_sysreg(cntfrq_el0);
+	time_10ms = time_hz / 100;
+
+	/* Enable Virtual Timer PPI */
+	gic_irq_set_clr_enable(irq, true);
+
+	report_prefix_push("WFx");
+	test_wfi();
+	test_wfe();
+	report_prefix_pop();
+
+	if (system_supports_wfxt()) {
+		report_prefix_push("WFxT");
+		test_wfit();
+		test_wfet();
+	} else {
+		report_skip("WFxT instructions not supported");
+	}
+
+	return report_summary();
+}
diff --git a/arm/unittests.cfg b/arm/unittests.cfg
index 12fc4468..ae8b5534 100644
--- a/arm/unittests.cfg
+++ b/arm/unittests.cfg
@@ -339,3 +339,10 @@ groups = mte
 test_args = asymm
 qemu_params = -machine mte=on
 arch = arm64
+
+[wfx]
+file = wfx.flat
+groups = wfx
+arch = arm64
+# This test exercise CPU emulation so limit to TCG to avoid confusion
+accel = tcg
-- 
2.47.3


