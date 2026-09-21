Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F03EC982ED
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 12:28:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8d8D-0003oK-Sg; Mon, 21 Sep 2026 08:28:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fuad.tabba@linux.dev>)
 id 1x8Yi0-0006dJ-TQ
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 03:45:04 -0400
Received: from out-144.mta0.migadu.com ([2001:41d0:1004:224b::90]
 helo=mta0.migadu.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fuad.tabba@linux.dev>)
 id 1x8Yhy-000673-DI
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 03:45:04 -0400
X-Envelope-To: qemu-devel@nongnu.org
DKIM-Signature: a=rsa-sha256; bh=DkCA3LQk6XsB5+Wn3PTg4D9l6WDGjBmZQIzEuLBxvDE=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789976700; v=1; x=1790581500;
 b=Z/zb/q2SIH8yzPf6Vk0RCrqeXo/3xZi0pM07vFPjRURV3NVzi7qyOiGX5kv+pGpyPidDA/Va
 yDTD15w0CgIT9yK82s/Gn8QUiKKUGRNgnq+nvg8U5FRKmZXp8mbpZ+cOURCEKPfV95NcUOi8vO7
 5idBHM6eDaGpDTKcaWQe1G1c=
X-Envelope-To: qemu-devel@nongnu.org
Received: by smtp.migadu.com with ESMTPS id 48b83ec94cbf3cef;
 Mon, 21 Sep 2026 07:45:00 +0000
X-Mizu-Trace-ID: 48b83ec94cbf3cef
X-Migadu-Flow: FLOW_OUT
From: Fuad Tabba <fuad.tabba@linux.dev>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Will Deacon <will@kernel.org>, Fuad Tabba <tabba@google.com>
Subject: [PATCH 2/2] target/arm: Fix WFxT timeouts when the offset puts the
 count ahead
Date: Mon, 21 Sep 2026 08:44:51 +0100
Message-Id: <20260921074451.3158645-3-fuad.tabba@linux.dev>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260921074451.3158645-1-fuad.tabba@linux.dev>
References: <20260921074451.3158645-1-fuad.tabba@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:41d0:1004:224b::90;
 envelope-from=fuad.tabba@linux.dev; helo=mta0.migadu.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 21 Sep 2026 08:27:51 -0400
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
---
 target/arm/tcg/op_helper.c           |   6 +-
 tests/tcg/aarch64/system/meson.build |   7 ++
 tests/tcg/aarch64/system/wfxt.c      | 118 +++++++++++++++++++++++++++
 3 files changed, 129 insertions(+), 2 deletions(-)
 create mode 100644 tests/tcg/aarch64/system/wfxt.c

diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index c2b09176cb..562f11f390 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -448,7 +448,8 @@ void HELPER(wfit)(CPUARMState *env, uint32_t rd)
         raise_exception(env, excp, syn_wfx(1, 0xe, rd, true, WFIT, false), target_el);
     }
 
-    if (uadd64_overflow(timeout, offset, &nexttick)) {
+    /* Physical count at the timeout. Only an overflow of it is "never". */
+    if (uadd64_overflow(cntval, timeout - cntvct, &nexttick)) {
         nexttick = UINT64_MAX;
     }
     if (nexttick > INT64_MAX / gt_cntfrq_period_ns(cpu)) {
@@ -705,7 +706,8 @@ void HELPER(wfet)(CPUARMState *env, uint32_t rd)
      * The WFET should time out when CNTVCT_EL0 >= the specified value.
      */
     cpu = env_archcpu(env);
-    if (uadd64_overflow(timeout, offset, &nexttick)) {
+    /* Physical count at the timeout. Only an overflow of it is "never". */
+    if (uadd64_overflow(cntval, timeout - cntvct, &nexttick)) {
         nexttick = UINT64_MAX;
     }
     if (nexttick > INT64_MAX / gt_cntfrq_period_ns(cpu)) {
diff --git a/tests/tcg/aarch64/system/meson.build b/tests/tcg/aarch64/system/meson.build
index 94e16ba330..5d96a9c25a 100644
--- a/tests/tcg/aarch64/system/meson.build
+++ b/tests/tcg/aarch64/system/meson.build
@@ -72,6 +72,13 @@ tests += {
                   '-semihosting-config', 'enable=on,arg=2',
                   qemu_base_args]
   },
+  'wfxt.c': {
+    'cflags': cflags,
+    'qemu_args': ['-M', 'virt,virtualization=on,gic-version=2',
+                  '-cpu', 'max', '-smp', '1',
+                  '-semihosting-config', 'enable=on,arg=2',
+                  qemu_base_args]
+  },
 }
 
 tests += {
diff --git a/tests/tcg/aarch64/system/wfxt.c b/tests/tcg/aarch64/system/wfxt.c
new file mode 100644
index 0000000000..9d50590a68
--- /dev/null
+++ b/tests/tcg/aarch64/system/wfxt.c
@@ -0,0 +1,118 @@
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
+static inline void wfet(uint64_t timeout)
+{
+    register uint64_t x0 asm("x0") = timeout;
+
+    asm volatile(".inst 0xd5031000" : : "r" (x0) : "memory");
+}
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
+    ret |= test_one("wfet", wfet, freq);
+
+    return ret;
+}
-- 
2.39.5


