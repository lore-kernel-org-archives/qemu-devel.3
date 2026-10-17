Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAEE3CCF2CF
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 19:05:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xI9Zu-0008Gr-3R; Sat, 17 Oct 2026 14:56:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xI9Zc-0008BO-Oe; Sat, 17 Oct 2026 14:56:11 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xI9Za-0003b4-Mc; Sat, 17 Oct 2026 14:56:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1792263356; bh=Rea77sm9LOjvCrivzmGKTdp3U3FCwPWR+lZbQtLTwU4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Fd8kQiy3+d/7xsrmQA34CejLSLePpElpdsh1MhYvLw5atLaY8rr+LFx1IMsjbXOG3
 jGuBB5cwDwY1kjvHPF/Sl5ydRRqpnfOHDV3YAr+PlKlxWO3L9eEJpQX+forffFj6A1
 GkCh6clHq+HOc1u9eO3gPismhakFEax48MHXaB2OmkWFqlQE8kGCtJQq9tSKQBDceO
 bLW87v/O7ktk0Z/dCCtdnX7Wnsskf1//x2omdIq0LlSkF1bTlkkz+TBgHGmyN+iO4F
 IJQyioBnng/3bcy9i1o4Py+bGZ4UvVr3OxdGRKV7dt3Xq9IetvB8Um6+hWqkE0ce0+
 Zv/JMOqtMWjuA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 921B01DE6A3;
 Sat, 17 Oct 2026 21:55:56 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id C5F4944336E;
 Sat, 17 Oct 2026 21:55:55 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Fuad Tabba <fuad.tabba@linux.dev>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.15 03/63] target/arm: Fix WFxT timeouts when the offset
 puts the count ahead
Date: Sat, 17 Oct 2026 21:54:19 +0300
Message-ID: <20261017185528.722197-3-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.15-20261017215444@cover.tls.msk.ru>
References: <qemu-stable-10.0.15-20261017215444@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Fuad Tabba <fuad.tabba@linux.dev>

The WFIT and WFET helpers arm the wakeup timer at count == timeout +
offset, treating an overflow of that sum as "beyond the counter's
wrap" and arming at INT64_MAX. As in gt_recalc_timer(), that reading
is valid only when offset <= count: with a CNTVOFF_EL2 that puts the
virtual count ahead of the physical count, the sum overflows for
every timeout still in the future and the wrapped value was the
correct wakeup. The CPU then waits until an interrupt or event
instead of waking at its timeout. A Linux guest uses WFIT and WFET in
__delay() when FEAT_WFxT is present, which -cpu max advertises.

Arm cntval + (timeout - cntvct) instead, so only a physical count past
2^64 is "never", and add a tcg system test that issues WFIT and WFET
with such an offset, with a timer interrupt 1s out so a broken WFxT
still returns: before this change both wake at the interrupt, after
it at their timeout.

Fixes: a96edb687e76 ("target/arm: Implement FEAT WFxT and enable for '-cpu max'")
Fixes: da9b86c35fa8 ("target/arm: implement WFET")
Cc: qemu-stable@nongnu.org
Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
Message-id: 20260921074451.3158645-3-fuad.tabba@linux.dev
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 998b6db69e3ec58fd52ddc7a06ece6cf286f3c77)
(Mjt: back-port the test across v11.1.0-1104-g602f9163b359
 "tests/tcg/aarch64: system tests" make->meson tests conversion)
(Mjt: pick up only half of the change, since 10.0.x does not have
 da9b86c35fa8 "target/arm: implement WFET")
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index 4e87b37a64..2f2a0d56b1 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -450,7 +450,8 @@ void HELPER(wfit)(CPUARMState *env, uint64_t timeout)
         raise_exception(env, excp, syn_wfx(1, 0xe, 2, false), target_el);
     }
 
-    if (uadd64_overflow(timeout, offset, &nexttick)) {
+    /* Physical count at the timeout. Only an overflow of it is "never". */
+    if (uadd64_overflow(cntval, timeout - cntvct, &nexttick)) {
         nexttick = UINT64_MAX;
     }
     if (nexttick > INT64_MAX / gt_cntfrq_period_ns(cpu)) {
diff --git a/tests/tcg/aarch64/Makefile.softmmu-target b/tests/tcg/aarch64/Makefile.softmmu-target
index 9c52475b7a..46713d49b9 100644
--- a/tests/tcg/aarch64/Makefile.softmmu-target
+++ b/tests/tcg/aarch64/Makefile.softmmu-target
@@ -70,6 +70,8 @@ run-plugin-semiconsole-with-%: semiconsole
 QEMU_EL2_MACHINE=-machine virt,virtualization=on,gic-version=2 -cpu cortex-a57 -smp 4
 run-vtimer: QEMU_OPTS=$(QEMU_EL2_MACHINE) $(QEMU_BASE_ARGS) -kernel
 
+run-wfxt: QEMU_OPTS=-M virt,virtualization=on,gic-version=2 -cpu max -smp 1 -semihosting-config enable=on,arg=2 -kernel
+
 # Simple Record/Replay Test
 .PHONY: memory-record
 run-memory-record: memory-record memory
diff --git a/tests/tcg/aarch64/system/wfxt.c b/tests/tcg/aarch64/system/wfxt.c
new file mode 100644
index 0000000000..be35833a33
--- /dev/null
+++ b/tests/tcg/aarch64/system/wfxt.c
@@ -0,0 +1,122 @@
+/*
+ * WFIT/WFET timeout test
+ *
+ * Copyright (c) 2026 Google LLC
+ * Author: Fuad Tabba <fuad.tabba@linux.dev>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <stdint.h>
+#include <minilib.h>
+
+/* from Linux's include/linux/stringify.h */
+#define __stringify_1(x...) #x
+#define __stringify(x...)   __stringify_1(x)
+
+#define read_sysreg(r) ({                                           \
+            uint64_t __val;                                         \
+            asm volatile("mrs %0, " __stringify(r) : "=r" (__val)); \
+            __val;                                                  \
+})
+
+#define write_sysreg(r, v) do {                     \
+        uint64_t __val = (uint64_t)(v);             \
+        asm volatile("msr " __stringify(r) ", %x0"  \
+                 : : "rZ" (__val));                 \
+} while (0)
+
+/* .inst forms of WFIT x0 and WFET x0, for assemblers without FEAT_WFxT */
+static inline void wfit(uint64_t timeout)
+{
+    register uint64_t x0 asm("x0") = timeout;
+
+    asm volatile(".inst 0xd5031020" : : "r" (x0) : "memory");
+}
+
+#if 0 /* 10.0.x does not support wfet */
+static inline void wfet(uint64_t timeout)
+{
+    register uint64_t x0 asm("x0") = timeout;
+
+    asm volatile(".inst 0xd5031000" : : "r" (x0) : "memory");
+}
+#endif
+
+/* virt machine, GICv2 */
+#define GICD_BASE 0x08000000UL
+#define GICC_BASE 0x08010000UL
+#define GICD_CTLR 0x000
+#define GICD_ISENABLER0 0x100
+#define GICC_CTLR 0x000
+#define GICC_PMR 0x004
+#define VTIMER_PPI 27
+
+static inline void mmio_write32(uintptr_t addr, uint32_t val)
+{
+    /* GIC registers: MMIO, MMU off at EL2 */
+    *(volatile uint32_t *)addr = val;
+}
+
+static int test_one(const char *name, void (*wait)(uint64_t), uint64_t freq)
+{
+    uint64_t now, timeout, elapsed;
+    int early = 0;
+
+    /*
+     * The virtual timer interrupt, 1s out, wakes the CPU even with
+     * interrupts masked. The timeout, 10ms out, must be what wakes it.
+     */
+    now = read_sysreg(cntvct_el0);
+    write_sysreg(cntv_cval_el0, now + freq);
+    write_sysreg(cntv_ctl_el0, 1);
+    timeout = now + freq / 100;
+
+    do {
+        wait(timeout);
+        early++;
+    } while (read_sysreg(cntvct_el0) < timeout && early < 1000);
+
+    elapsed = read_sysreg(cntvct_el0) - now;
+    write_sysreg(cntv_ctl_el0, 0);
+
+    ml_printf("%s: woke after %ld ticks (%d wakes)\n", name, elapsed, early);
+    if (early >= 1000) {
+        ml_printf("FAIL: %s kept waking before its timeout\n", name);
+        return 1;
+    }
+    if (elapsed > freq / 2) {
+        ml_printf("FAIL: %s woke on the timer interrupt, not its timeout\n",
+                  name);
+        return 1;
+    }
+    return 0;
+}
+
+int main(void)
+{
+    uint64_t freq;
+    int ret;
+
+    ml_printf("WFxT Test\n");
+
+    mmio_write32(GICD_BASE + GICD_ISENABLER0, 1u << VTIMER_PPI);
+    mmio_write32(GICD_BASE + GICD_CTLR, 1);
+    mmio_write32(GICC_BASE + GICC_PMR, 0xff);
+    mmio_write32(GICC_BASE + GICC_CTLR, 1);
+
+    /* Put the virtual count ahead of the physical count */
+    write_sysreg(cntvoff_el2, -(1ULL << 60));
+    asm volatile("isb");
+    freq = read_sysreg(cntfrq_el0);
+
+    ml_printf("cntvoff_el2=%lx cntfrq_el0=%ld\n",
+              read_sysreg(cntvoff_el2), freq);
+
+    ret = test_one("wfit", wfit, freq);
+#if 0 /* 10.0.x does not support wfet */
+    ret |= test_one("wfet", wfet, freq);
+#endif
+
+    return ret;
+}
-- 
2.47.3


