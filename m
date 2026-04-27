Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E337FF886A
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 13:01:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHLaS-0004qX-R2; Mon, 27 Apr 2026 09:01:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wHLa6-0004Wi-GA
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 09:00:59 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wHLa3-0002br-Hq
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 09:00:57 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-48a563e4ef7so68932205e9.0
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 06:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777294852; x=1777899652; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=e+5B0T5BZcM8PN6hrBB/cl4KNtkNonj2W3WbwM9F740=;
 b=EKPuq+FjqxEY6hBCZUHjRtiHykxRH9xqUKLWByTKK29fH4jcnvsAETysd8NERqAEju
 NEwvNeinMHFUpYUznNP98/Hu50lhaWGTQuugr0dDdXHFJQME+vsi0DJsE1gLRLoVsI+B
 QZZ+51btI/ix7uxN8V9JTiV6/6uTxr2Jhns45LBfxsWwVa6W/jfeG2Faf0HaNRkfc7kU
 ZsY87bRrH6JBBiXI4nzG29uxY8HCd3MtNPrwk7uf0SbpMTdlbNTC5tvh9LN3IWP5pec2
 RIn+Qu+RmVVCP5wZ+w5cpNE2YzzXNF638hHiW6xVekgR2ez36wQjPaLYhYON6IoG/VN4
 oH/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777294852; x=1777899652;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e+5B0T5BZcM8PN6hrBB/cl4KNtkNonj2W3WbwM9F740=;
 b=U2+ZQGVtOAIB0ZFQn1NwkC2B68v+LpXdP+etHh0PX8xSmHF79wRwskOamNaWZExilM
 +wSE3BkNvaj83yixE0M7WnaQ84FKRraChxmPj0u/sipctz2Q5OM9f3M/W/iWQmJEyuJA
 A9RWTSRe0mm2yZFMPNerM9qWrqlhovEk3Nkk73xGhpGR17tram5/X1bugertj1tDNPDp
 BgTm1HyQFqXby7UjhR9FWXw4yZuWichhaWWRrsPMI9axNLXLaFDODTTkl6654+xK2+6F
 EmwMydf0bSgcWqUwPu8TMFyiTcZbjgmyRtu7uRgd9/5nO/4WUte1ddF8gQZMd72F1m5n
 yifA==
X-Gm-Message-State: AOJu0Yy5Feond/J+JHqgiU3a55GaKPyADNkgATeDlIXNplCTRf9MYMPn
 pz/hS4gt7vwGcCUG6aokAXOR6o8QpIuh2HSPYzKKhMH+vU60DMohRGVzmuEDQNMK1zY=
X-Gm-Gg: AeBDieusDY1DAfdNFrX9DPjiS9hWAOHPjDHyWz20Hr9PgmP2cbjZ/6L8gMtPk2Uinng
 sCSn4BgiJU54oTicFhwmwpcxMh1p/Lf6g8Ewqlvtmrfjus3J0UaYRPo5lo48mcnUVMXxnjq6BUj
 WkHpUW9+M7XXsMRF04/97MRp2XSSCVm1KecuITq0lcUDPwNyUWiK2GUpFpR//Pg1Y/HFAOCAfWc
 ryTAY9tOOUN3bOinBnSN0CH4vDvrz0fLXfZi0D4YkvJiAjxpeU7AO/J0hjtWWWX1J1bdhdtX9av
 lhkBQUzoxe5sNHEsTxkEtkqzDrttAfYK7gpHasuqCajUyeIXzHbgK9ZbDAxONu3GxbBhN0p2k/5
 j7QMmyGKszpKVFIWHYoyy3djHxOQtx/TLKBFfn5FIcL137wnGWpym1FPAKwjhn+O+X7kPWLHRVU
 YsBnEYvfQVUcwxlivqjjcMT8beHhxjyTPz7g==
X-Received: by 2002:a05:600d:8451:b0:48a:599a:36fe with SMTP id
 5b1f17b1804b1-48a599a4413mr263744425e9.24.1777294851986; 
 Mon, 27 Apr 2026 06:00:51 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ffc558f2sm622865905e9.1.2026.04.27.06.00.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 06:00:51 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 06B075F877;
 Mon, 27 Apr 2026 14:00:50 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Andrew Jones <andrew.jones@linux.dev>,
 Alexandru Elisei <alexandru.elisei@arm.com>,
 Eric Auger <eric.auger@redhat.com>, kvmarm@lists.linux.dev (open list:ARM),
 kvm@vger.kernel.org (open list:Default mailing list)
Subject: [kvm-unit-tests PATCH] arm: add wfx test case
Date: Mon, 27 Apr 2026 14:00:45 +0100
Message-ID: <20260427130045.3669851-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
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
 arm/Makefile.arm64        |   1 +
 lib/arm64/asm/processor.h |   7 ++
 lib/arm64/asm/sysreg.h    |   3 +
 arm/wfx.c                 | 137 ++++++++++++++++++++++++++++++++++++++
 arm/unittests.cfg         |   5 ++
 5 files changed, 153 insertions(+)
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
index 00000000..912e50e6
--- /dev/null
+++ b/arm/wfx.c
@@ -0,0 +1,137 @@
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
+#define TIMEOUT 200000
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
+static void timer_handler(struct pt_regs *regs)
+{
+	/* Disable timer to stop IRQ from re-firing */
+	write_sysreg(0, cntv_ctl_el0);
+}
+
+static bool check_elapsed(uint64_t start, uint64_t threshold, const char *test, bool more)
+{
+	uint64_t end = read_sysreg(cntvct_el0);
+	uint64_t elapsed = end - start;
+	bool pass = more ? elapsed >= threshold : elapsed <= threshold;
+
+	report(pass, "%s (%ld ticks)", test, elapsed);
+
+	if (!pass) {
+		report_info("%s %s", test, more ? "woke too early" : "slept despite SEV");
+	}
+	return pass;
+}
+
+static void test_wfi(void)
+{
+	uint64_t start;
+
+	report_info("Testing WFI...");
+
+	start = read_sysreg(cntvct_el0);
+	write_sysreg(TIMEOUT, cntv_tval_el0);
+	write_sysreg(1, cntv_ctl_el0); /* Enable timer, no mask */
+	isb();
+
+	local_irq_enable();
+	wfi();
+	local_irq_disable();
+
+	check_elapsed(start, TIMEOUT, "WFI", true);
+}
+
+static void test_wfe(void)
+{
+	uint64_t start;
+
+	report_info("Testing WFE/SEV...");
+	sev();
+	start = read_sysreg(cntvct_el0);
+	wfe();
+	check_elapsed(start, TIMEOUT, "WFE/SEV", false);
+
+	report_info("Testing WFE/SEVL...");
+	sevl();
+	start = read_sysreg(cntvct_el0);
+	wfe();
+	check_elapsed(start, TIMEOUT, "WFE/SEVL", false);
+}
+
+static void test_wfit(void)
+{
+	uint64_t start, timeout;
+
+	report_info("Testing WFIT...");
+	start = read_sysreg(cntvct_el0);
+	timeout = start + TIMEOUT;
+	wfit(timeout);
+	check_elapsed(start, TIMEOUT, "WFIT", true);
+}
+
+static void test_wfet(void)
+{
+	uint64_t start, timeout;
+
+	report_info("Testing WFET...");
+	/* Ensure no pending events */
+	sev();
+	wfe();
+
+	start = read_sysreg(cntvct_el0);
+	timeout = start + TIMEOUT;
+	wfet(timeout);
+	check_elapsed(start, TIMEOUT, "WFET", true);
+}
+
+int main(void)
+{
+
+	if (gic_init() < 0) {
+		report_abort("GIC init failed");
+		return 1;
+	}
+
+	/* Install timer handler for WFI wake-up */
+	install_irq_handler(EL1H_IRQ, timer_handler);
+	gic_enable_defaults();
+
+	/* Enable Virtual Timer PPI */
+	gic_irq_set_clr_enable(27, true);
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
index 12fc4468..7adf96f2 100644
--- a/arm/unittests.cfg
+++ b/arm/unittests.cfg
@@ -339,3 +339,8 @@ groups = mte
 test_args = asymm
 qemu_params = -machine mte=on
 arch = arm64
+
+[wfx]
+file = wfx.flat
+groups = wfx
+arch = arm64
-- 
2.47.3


