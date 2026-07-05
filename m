Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66FF2C43602
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 22:30:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgVJx-0006mk-Iy; Sun, 05 Jul 2026 18:28:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1wgUvz-0002AZ-JD; Sun, 05 Jul 2026 18:03:31 -0400
Received: from smtp-out-2.univ-lille.fr ([194.254.129.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1wgUvt-0001fG-Rt; Sun, 05 Jul 2026 18:03:31 -0400
Received: from smtp02.univ-lille.fr (smtp02.univ-lille.fr [194.254.129.96])
 by smtp-out-2.univ-lille.fr (Postfix) with ESMTPS id 4gthMF74vQz85XT;
 Mon,  6 Jul 2026 00:03:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=univ-lille.fr;
 s=dkim; t=1783289002;
 bh=cRESgzp/SZTyo+3gbVtIVtdguX4/QAKAUfTh8NG2E7c=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=SEbEMEWhPLFfq2HppafCscUKzWgV1ois/9SYWu+o62FD7YVSGC8K0ed++230r/sjR
 oqCsOxqQhvmEbqhfklo1N9hGMTwKKudieyJYNIWBONbtqamnvu6ba1xdoQhf386odz
 5VeUa3inmiNXzNY1Q51BL067UWuqy3XcSCHtg1QGOoM7JzYRL7HULhJGrp3l3slV8Q
 zrE6EDWfnzU7KGsUGXKDXChoxPMSEi+cKs65zXkfqjmzkZBaCydvGmHCoMuTFIQ+vz
 HaGNqHZU+bZhrC//6HgzjQcPTUUNkR/ymvnayqKEzw5y6zNrOyrDaeSCA4KdkpVKOh
 4lPVxchzudF0w==
Received: from mac.home (lfbn-lil-1-243-101.w90-45.abo.wanadoo.fr
 [90.45.87.101]) (Authenticated sender: gilles.grimaud)
 by smtp02.univ-lille.fr (Postfix) with ESMTPSA id 4gthMF5cY2z6tBv;
 Mon,  6 Jul 2026 00:03:21 +0200 (CEST)
From: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Gilles Grimaud <gilles.grimaud@univ-lille.fr>
Subject: [PATCH RFC v1 1/9] hw/misc: add RP2040 peripheral models
Date: Mon,  6 Jul 2026 00:03:12 +0200
Message-ID: <20260705220320.90395-2-gilles.grimaud@univ-lille.fr>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260705220320.90395-1-gilles.grimaud@univ-lille.fr>
References: <20260705220320.90395-1-gilles.grimaud@univ-lille.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=194.254.129.106;
 envelope-from=gilles.grimaud@univ-lille.fr; helo=smtp-out-2.univ-lille.fr
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 05 Jul 2026 18:28:16 -0400
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

Add shallow RP2040 models for clocks, resets, watchdog, SIO, GPIO bank/pads, ROSC, PLL, timer, syscfg/sysinfo, TBMAN, PSM, VREG and related helpers.

These devices provide enough behaviour for the Raspberry Pi Pico machine, SDK examples and the RP2040 mask ROM path to make forward progress while keeping unsupported register behaviour explicit.

This continues the RP2040/Pico enablement started by Alex Bennée's 2022 RFC series, adapted to current QEMU APIs.

Signed-off-by: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
---
 hw/misc/Kconfig                   |  54 ++
 hw/misc/meson.build               |  18 +
 hw/misc/rp2040_busctrl.c          | 208 +++++++
 hw/misc/rp2040_clocks.c           | 480 ++++++++++++++++
 hw/misc/rp2040_iobank0.c          | 353 ++++++++++++
 hw/misc/rp2040_ioqspi.c           | 294 ++++++++++
 hw/misc/rp2040_nyi.c              |  47 ++
 hw/misc/rp2040_pads.c             | 323 +++++++++++
 hw/misc/rp2040_pll.c              | 234 ++++++++
 hw/misc/rp2040_psm.c              | 198 +++++++
 hw/misc/rp2040_resets.c           | 152 +++++
 hw/misc/rp2040_rosc.c             | 430 ++++++++++++++
 hw/misc/rp2040_sio.c              | 905 ++++++++++++++++++++++++++++++
 hw/misc/rp2040_syscfg.c           | 246 ++++++++
 hw/misc/rp2040_sysinfo.c          | 111 ++++
 hw/misc/rp2040_tbman.c            |  94 ++++
 hw/misc/rp2040_timer.c            | 372 ++++++++++++
 hw/misc/rp2040_vreg.c             | 179 ++++++
 hw/misc/rp2040_watchdog.c         | 361 ++++++++++++
 hw/misc/rp2040_xosc.c             | 237 ++++++++
 hw/misc/unimp.c                   |  13 +-
 include/hw/misc/rp2040_busctrl.h  |  29 +
 include/hw/misc/rp2040_clocks.h   |  36 ++
 include/hw/misc/rp2040_iobank0.h  |  45 ++
 include/hw/misc/rp2040_ioqspi.h   |  36 ++
 include/hw/misc/rp2040_nyi.h      |  19 +
 include/hw/misc/rp2040_pads.h     |  42 ++
 include/hw/misc/rp2040_pll.h      |  37 ++
 include/hw/misc/rp2040_psm.h      |  40 ++
 include/hw/misc/rp2040_resets.h   |  28 +
 include/hw/misc/rp2040_rosc.h     |  42 ++
 include/hw/misc/rp2040_sio.h      |  57 ++
 include/hw/misc/rp2040_syscfg.h   |  42 ++
 include/hw/misc/rp2040_sysinfo.h  |  25 +
 include/hw/misc/rp2040_tbman.h    |  25 +
 include/hw/misc/rp2040_timer.h    |  39 ++
 include/hw/misc/rp2040_vreg.h     |  28 +
 include/hw/misc/rp2040_watchdog.h |  35 ++
 include/hw/misc/rp2040_xosc.h     |  33 ++
 include/hw/misc/unimp.h           |   2 +
 40 files changed, 5945 insertions(+), 4 deletions(-)
 create mode 100644 hw/misc/rp2040_busctrl.c
 create mode 100644 hw/misc/rp2040_clocks.c
 create mode 100644 hw/misc/rp2040_iobank0.c
 create mode 100644 hw/misc/rp2040_ioqspi.c
 create mode 100644 hw/misc/rp2040_nyi.c
 create mode 100644 hw/misc/rp2040_pads.c
 create mode 100644 hw/misc/rp2040_pll.c
 create mode 100644 hw/misc/rp2040_psm.c
 create mode 100644 hw/misc/rp2040_resets.c
 create mode 100644 hw/misc/rp2040_rosc.c
 create mode 100644 hw/misc/rp2040_sio.c
 create mode 100644 hw/misc/rp2040_syscfg.c
 create mode 100644 hw/misc/rp2040_sysinfo.c
 create mode 100644 hw/misc/rp2040_tbman.c
 create mode 100644 hw/misc/rp2040_timer.c
 create mode 100644 hw/misc/rp2040_vreg.c
 create mode 100644 hw/misc/rp2040_watchdog.c
 create mode 100644 hw/misc/rp2040_xosc.c
 create mode 100644 include/hw/misc/rp2040_busctrl.h
 create mode 100644 include/hw/misc/rp2040_clocks.h
 create mode 100644 include/hw/misc/rp2040_iobank0.h
 create mode 100644 include/hw/misc/rp2040_ioqspi.h
 create mode 100644 include/hw/misc/rp2040_nyi.h
 create mode 100644 include/hw/misc/rp2040_pads.h
 create mode 100644 include/hw/misc/rp2040_pll.h
 create mode 100644 include/hw/misc/rp2040_psm.h
 create mode 100644 include/hw/misc/rp2040_resets.h
 create mode 100644 include/hw/misc/rp2040_rosc.h
 create mode 100644 include/hw/misc/rp2040_sio.h
 create mode 100644 include/hw/misc/rp2040_syscfg.h
 create mode 100644 include/hw/misc/rp2040_sysinfo.h
 create mode 100644 include/hw/misc/rp2040_tbman.h
 create mode 100644 include/hw/misc/rp2040_timer.h
 create mode 100644 include/hw/misc/rp2040_vreg.h
 create mode 100644 include/hw/misc/rp2040_watchdog.h
 create mode 100644 include/hw/misc/rp2040_xosc.h

diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 1543ee6653..1480a6d60d 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -101,6 +101,60 @@ config FSL_IMX8MP_ANALOG
 config FSL_IMX8MP_CCM
     bool
 
+config RP2040_BUSCTRL
+    bool
+
+config RP2040_CLOCKS
+    bool
+
+config RP2040_IOBANK0
+    bool
+
+config RP2040_IOQSPI
+    bool
+
+config RP2040_NYI
+    bool
+
+config RP2040_PADS
+    bool
+
+config RP2040_PLL
+    bool
+
+config RP2040_PSM
+    bool
+
+config RP2040_RESETS
+    bool
+
+config RP2040_ROSC
+    bool
+
+config RP2040_SIO
+    bool
+
+config RP2040_SYSCFG
+    bool
+
+config RP2040_SYSINFO
+    bool
+
+config RP2040_TBMAN
+    bool
+
+config RP2040_TIMER
+    bool
+
+config RP2040_VREG
+    bool
+
+config RP2040_WATCHDOG
+    bool
+
+config RP2040_XOSC
+    bool
+
 config STM32_RCC
     bool
 
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 23265f6035..d89305ae14 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -95,6 +95,24 @@ system_ss.add(when: 'CONFIG_RASPI', if_true: files(
   'bcm2835_cprman.c',
   'bcm2835_powermgt.c',
 ))
+system_ss.add(when: 'CONFIG_RP2040_BUSCTRL', if_true: files('rp2040_busctrl.c'))
+system_ss.add(when: 'CONFIG_RP2040_CLOCKS', if_true: files('rp2040_clocks.c'))
+system_ss.add(when: 'CONFIG_RP2040_IOBANK0', if_true: files('rp2040_iobank0.c'))
+system_ss.add(when: 'CONFIG_RP2040_IOQSPI', if_true: files('rp2040_ioqspi.c'))
+system_ss.add(when: 'CONFIG_RP2040_NYI', if_true: files('rp2040_nyi.c'))
+system_ss.add(when: 'CONFIG_RP2040_PADS', if_true: files('rp2040_pads.c'))
+system_ss.add(when: 'CONFIG_RP2040_PLL', if_true: files('rp2040_pll.c'))
+system_ss.add(when: 'CONFIG_RP2040_PSM', if_true: files('rp2040_psm.c'))
+system_ss.add(when: 'CONFIG_RP2040_RESETS', if_true: files('rp2040_resets.c'))
+system_ss.add(when: 'CONFIG_RP2040_ROSC', if_true: files('rp2040_rosc.c'))
+system_ss.add(when: 'CONFIG_RP2040_SIO', if_true: files('rp2040_sio.c'))
+system_ss.add(when: 'CONFIG_RP2040_SYSCFG', if_true: files('rp2040_syscfg.c'))
+system_ss.add(when: 'CONFIG_RP2040_SYSINFO', if_true: files('rp2040_sysinfo.c'))
+system_ss.add(when: 'CONFIG_RP2040_TBMAN', if_true: files('rp2040_tbman.c'))
+system_ss.add(when: 'CONFIG_RP2040_TIMER', if_true: files('rp2040_timer.c'))
+system_ss.add(when: 'CONFIG_RP2040_VREG', if_true: files('rp2040_vreg.c'))
+system_ss.add(when: 'CONFIG_RP2040_WATCHDOG', if_true: files('rp2040_watchdog.c'))
+system_ss.add(when: 'CONFIG_RP2040_XOSC', if_true: files('rp2040_xosc.c'))
 system_ss.add(when: 'CONFIG_SLAVIO', if_true: files('slavio_misc.c'))
 system_ss.add(when: 'CONFIG_ZYNQ', if_true: files('zynq_slcr.c'))
 system_ss.add(when: 'CONFIG_XLNX_ZYNQ_DDRC', if_true: files('xlnx-zynq-ddrc.c'))
diff --git a/hw/misc/rp2040_busctrl.c b/hw/misc/rp2040_busctrl.c
new file mode 100644
index 0000000000..505047609c
--- /dev/null
+++ b/hw/misc/rp2040_busctrl.c
@@ -0,0 +1,208 @@
+/*
+ * RP2040 bus fabric control emulation
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/misc/rp2040_busctrl.h"
+#include "hw/misc/rp2040_nyi.h"
+#include "migration/vmstate.h"
+#include "qemu/bitops.h"
+#include "qemu/module.h"
+
+#define BUSCTRL_PRIORITY        0x00
+#define BUSCTRL_PRIORITY_ACK    0x04
+#define BUSCTRL_PERFCTR_BASE    0x08
+#define BUSCTRL_PERFSEL_BASE    0x0c
+#define BUSCTRL_PERF_STRIDE     0x08
+#define BUSCTRL_NUM_COUNTERS    4
+
+#define BUSCTRL_PRIORITY_MASK   0x00001111
+#define BUSCTRL_PRIORITY_ACKED  BIT(0)
+#define BUSCTRL_PERFCTR_MASK    0x00ffffff
+#define BUSCTRL_PERFSEL_RESET   0x1f
+#define BUSCTRL_PERFSEL_MASK    0x1f
+
+#define ATOMIC_ALIAS_MASK       0x3000
+#define ATOMIC_XOR              0x1000
+#define ATOMIC_SET              0x2000
+#define ATOMIC_CLR              0x3000
+
+static uint32_t rp2040_busctrl_apply_alias(uint32_t old, uint32_t value,
+                                           hwaddr alias)
+{
+    switch (alias) {
+    case ATOMIC_XOR:
+        return old ^ value;
+    case ATOMIC_SET:
+        return old | value;
+    case ATOMIC_CLR:
+        return old & ~value;
+    default:
+        return value;
+    }
+}
+
+static uint32_t rp2040_busctrl_read_counter(RP2040BusCtrlState *s,
+                                            unsigned index)
+{
+    if (s->perfsel[index] != BUSCTRL_PERFSEL_RESET &&
+        s->perfctr[index] != BUSCTRL_PERFCTR_MASK) {
+        s->perfctr[index]++;
+    }
+
+    return s->perfctr[index];
+}
+
+static uint64_t rp2040_busctrl_read(void *opaque, hwaddr addr, unsigned size)
+{
+    RP2040BusCtrlState *s = opaque;
+    hwaddr offset = addr & 0xfff;
+    unsigned index;
+    uint64_t value;
+
+    if (offset >= BUSCTRL_PERFCTR_BASE &&
+        offset < BUSCTRL_PERFCTR_BASE + BUSCTRL_NUM_COUNTERS *
+        BUSCTRL_PERF_STRIDE &&
+        (offset - BUSCTRL_PERFCTR_BASE) % BUSCTRL_PERF_STRIDE == 0) {
+        index = (offset - BUSCTRL_PERFCTR_BASE) / BUSCTRL_PERF_STRIDE;
+        return rp2040_busctrl_read_counter(s, index);
+    }
+
+    if (offset >= BUSCTRL_PERFSEL_BASE &&
+        offset < BUSCTRL_PERFSEL_BASE + BUSCTRL_NUM_COUNTERS *
+        BUSCTRL_PERF_STRIDE &&
+        (offset - BUSCTRL_PERFSEL_BASE) % BUSCTRL_PERF_STRIDE == 0) {
+        index = (offset - BUSCTRL_PERFSEL_BASE) / BUSCTRL_PERF_STRIDE;
+        return s->perfsel[index];
+    }
+
+    switch (offset) {
+    case BUSCTRL_PRIORITY:
+        value = s->priority;
+        break;
+    case BUSCTRL_PRIORITY_ACK:
+        value = BUSCTRL_PRIORITY_ACKED;
+        break;
+    default:
+        value = 0;
+        rp2040_log_unimplemented_read("busctrl", size,
+                                      RP2040_BUSCTRL_BASE + addr, offset,
+                                      value);
+        break;
+    }
+
+    return value;
+}
+
+static void rp2040_busctrl_write(void *opaque, hwaddr addr,
+                                 uint64_t value64, unsigned size)
+{
+    RP2040BusCtrlState *s = opaque;
+    hwaddr alias = addr & ATOMIC_ALIAS_MASK;
+    hwaddr offset = addr & 0xfff;
+    unsigned index;
+    uint32_t value = value64;
+
+    if (offset >= BUSCTRL_PERFCTR_BASE &&
+        offset < BUSCTRL_PERFCTR_BASE + BUSCTRL_NUM_COUNTERS *
+        BUSCTRL_PERF_STRIDE &&
+        (offset - BUSCTRL_PERFCTR_BASE) % BUSCTRL_PERF_STRIDE == 0) {
+        index = (offset - BUSCTRL_PERFCTR_BASE) / BUSCTRL_PERF_STRIDE;
+        s->perfctr[index] =
+            rp2040_busctrl_apply_alias(s->perfctr[index], value, alias) &
+            BUSCTRL_PERFCTR_MASK;
+        return;
+    }
+
+    if (offset >= BUSCTRL_PERFSEL_BASE &&
+        offset < BUSCTRL_PERFSEL_BASE + BUSCTRL_NUM_COUNTERS *
+        BUSCTRL_PERF_STRIDE &&
+        (offset - BUSCTRL_PERFSEL_BASE) % BUSCTRL_PERF_STRIDE == 0) {
+        index = (offset - BUSCTRL_PERFSEL_BASE) / BUSCTRL_PERF_STRIDE;
+        s->perfsel[index] =
+            rp2040_busctrl_apply_alias(s->perfsel[index], value, alias) &
+            BUSCTRL_PERFSEL_MASK;
+        return;
+    }
+
+    switch (offset) {
+    case BUSCTRL_PRIORITY:
+        s->priority = rp2040_busctrl_apply_alias(s->priority, value, alias) &
+                      BUSCTRL_PRIORITY_MASK;
+        break;
+    case BUSCTRL_PRIORITY_ACK:
+        break;
+    default:
+        rp2040_log_unimplemented_write("busctrl", size,
+                                       RP2040_BUSCTRL_BASE + addr, offset,
+                                       value64);
+        break;
+    }
+}
+
+static const MemoryRegionOps rp2040_busctrl_ops = {
+    .read = rp2040_busctrl_read,
+    .write = rp2040_busctrl_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+static void rp2040_busctrl_reset(DeviceState *dev)
+{
+    RP2040BusCtrlState *s = RP2040_BUSCTRL(dev);
+    int i;
+
+    s->priority = 0;
+    for (i = 0; i < BUSCTRL_NUM_COUNTERS; i++) {
+        s->perfctr[i] = 0;
+        s->perfsel[i] = BUSCTRL_PERFSEL_RESET;
+    }
+}
+
+static void rp2040_busctrl_init(Object *obj)
+{
+    RP2040BusCtrlState *s = RP2040_BUSCTRL(obj);
+
+    memory_region_init_io(&s->iomem, obj, &rp2040_busctrl_ops, s,
+                          "rp2040.busctrl", RP2040_BUSCTRL_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->iomem);
+}
+
+static const VMStateDescription rp2040_busctrl_vmstate = {
+    .name = TYPE_RP2040_BUSCTRL,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32(priority, RP2040BusCtrlState),
+        VMSTATE_UINT32_ARRAY(perfctr, RP2040BusCtrlState, 4),
+        VMSTATE_UINT32_ARRAY(perfsel, RP2040BusCtrlState, 4),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void rp2040_busctrl_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    device_class_set_legacy_reset(dc, rp2040_busctrl_reset);
+    dc->vmsd = &rp2040_busctrl_vmstate;
+}
+
+static const TypeInfo rp2040_busctrl_info = {
+    .name          = TYPE_RP2040_BUSCTRL,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(RP2040BusCtrlState),
+    .instance_init = rp2040_busctrl_init,
+    .class_init    = rp2040_busctrl_class_init,
+};
+
+static void rp2040_busctrl_register_types(void)
+{
+    type_register_static(&rp2040_busctrl_info);
+}
+type_init(rp2040_busctrl_register_types)
diff --git a/hw/misc/rp2040_clocks.c b/hw/misc/rp2040_clocks.c
new file mode 100644
index 0000000000..8a59009c40
--- /dev/null
+++ b/hw/misc/rp2040_clocks.c
@@ -0,0 +1,480 @@
+/*
+ * RP2040 clocks emulation
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/core/qdev-clock.h"
+#include "hw/misc/rp2040_clocks.h"
+#include "hw/misc/rp2040_nyi.h"
+#include "migration/vmstate.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+
+#define ROSC_HZ     6000000
+#define XOSC_HZ     12000000
+
+#define CLK_GPOUT0_CTRL      0x00
+#define CLK_REF_CTRL         0x30
+#define CLK_REF_DIV          0x34
+#define CLK_REF_SELECTED     0x38
+#define CLK_SYS_CTRL         0x3c
+#define CLK_SYS_DIV          0x40
+#define CLK_SYS_SELECTED     0x44
+#define CLK_PERI_CTRL        0x48
+#define CLK_PERI_DIV         0x4c
+#define CLK_PERI_SELECTED    0x50
+#define CLK_USB_CTRL         0x54
+#define CLK_USB_DIV          0x58
+#define CLK_USB_SELECTED     0x5c
+#define CLK_ADC_CTRL         0x60
+#define CLK_ADC_DIV          0x64
+#define CLK_ADC_SELECTED     0x68
+#define CLK_RTC_CTRL         0x6c
+#define CLK_RTC_DIV          0x70
+#define CLK_RTC_SELECTED     0x74
+#define FC0_REF_KHZ          0x80
+#define FC0_MIN_KHZ          0x84
+#define FC0_MAX_KHZ          0x88
+#define FC0_DELAY            0x8c
+#define FC0_INTERVAL         0x90
+#define FC0_SRC              0x94
+#define FC0_STATUS           0x98
+#define FC0_RESULT           0x9c
+#define WAKE_EN0             0xa0
+#define WAKE_EN1             0xa4
+#define SLEEP_EN0            0xa8
+#define SLEEP_EN1            0xac
+#define ENABLED0             0xb0
+#define ENABLED1             0xb4
+#define INTR                 0xb8
+
+#define CTRL_ENABLE          BIT(11)
+
+#define ATOMIC_ALIAS_MASK    0x3000
+#define ATOMIC_XOR           0x1000
+#define ATOMIC_SET           0x2000
+#define ATOMIC_CLR           0x3000
+
+static void rp2040_clocks_update(RP2040ClocksState *s);
+
+static uint32_t rp2040_clocks_div(uint32_t reg)
+{
+    uint32_t div = reg >> 8;
+
+    return div == 0 ? 1u << 16 : div;
+}
+
+static unsigned rp2040_clocks_hz(Clock *clk)
+{
+    return MIN(clock_get_hz(clk), UINT_MAX);
+}
+
+static unsigned rp2040_clocks_sys_aux_freq(RP2040ClocksState *s,
+                                           uint32_t auxsrc)
+{
+    switch (auxsrc & 0x7) {
+    case 0x0:
+        return rp2040_clocks_hz(s->pll_sys);
+    case 0x1:
+        return rp2040_clocks_hz(s->pll_usb);
+    case 0x2:
+        return ROSC_HZ;
+    case 0x3:
+        return XOSC_HZ;
+    default:
+        return 0;
+    }
+}
+
+static unsigned rp2040_clocks_ref_aux_freq(RP2040ClocksState *s,
+                                           uint32_t auxsrc)
+{
+    switch (auxsrc & 0x3) {
+    case 0x0:
+        return rp2040_clocks_hz(s->pll_usb);
+    case 0x1:
+        return ROSC_HZ;
+    case 0x2:
+        return XOSC_HZ;
+    default:
+        return 0;
+    }
+}
+
+static unsigned rp2040_clocks_peri_aux_freq(RP2040ClocksState *s,
+                                            uint32_t auxsrc)
+{
+    switch (auxsrc & 0x7) {
+    case 0x0:
+        return rp2040_clocks_hz(s->clk_sys);
+    case 0x1:
+        return rp2040_clocks_hz(s->pll_sys);
+    case 0x2:
+        return rp2040_clocks_hz(s->pll_usb);
+    case 0x3:
+        return ROSC_HZ;
+    case 0x4:
+        return XOSC_HZ;
+    default:
+        return 0;
+    }
+}
+
+static unsigned rp2040_clocks_usb_adc_rtc_aux_freq(RP2040ClocksState *s,
+                                                   uint32_t auxsrc)
+{
+    switch (auxsrc & 0x7) {
+    case 0x0:
+        return rp2040_clocks_hz(s->pll_usb);
+    case 0x1:
+        return rp2040_clocks_hz(s->pll_sys);
+    case 0x2:
+        return ROSC_HZ;
+    case 0x3:
+        return XOSC_HZ;
+    default:
+        return 0;
+    }
+}
+
+static unsigned rp2040_clocks_ctrl_auxsrc(uint32_t ctrl)
+{
+    return extract32(ctrl, 5, 4);
+}
+
+static unsigned rp2040_clocks_ref_freq(RP2040ClocksState *s)
+{
+    uint32_t ctrl = s->regs[CLK_REF_CTRL / 4];
+    uint32_t src = extract32(ctrl, 0, 2);
+    unsigned freq;
+
+    switch (src) {
+    case 0:
+        freq = ROSC_HZ;
+        break;
+    case 1:
+        freq = rp2040_clocks_ref_aux_freq(s,
+                                          rp2040_clocks_ctrl_auxsrc(ctrl));
+        break;
+    case 2:
+        freq = XOSC_HZ;
+        break;
+    default:
+        freq = 0;
+        break;
+    }
+
+    return freq / rp2040_clocks_div(s->regs[CLK_REF_DIV / 4]);
+}
+
+static unsigned rp2040_clocks_sys_freq(RP2040ClocksState *s)
+{
+    uint32_t ctrl = s->regs[CLK_SYS_CTRL / 4];
+    uint32_t src = extract32(ctrl, 0, 1);
+    unsigned freq;
+
+    if (src) {
+        freq = rp2040_clocks_sys_aux_freq(s,
+                                          rp2040_clocks_ctrl_auxsrc(ctrl));
+    } else {
+        freq = rp2040_clocks_ref_freq(s);
+    }
+
+    return freq / rp2040_clocks_div(s->regs[CLK_SYS_DIV / 4]);
+}
+
+static unsigned rp2040_clocks_peri_freq(RP2040ClocksState *s)
+{
+    uint32_t ctrl = s->regs[CLK_PERI_CTRL / 4];
+
+    if (!(ctrl & CTRL_ENABLE)) {
+        return 0;
+    }
+
+    return rp2040_clocks_peri_aux_freq(s, rp2040_clocks_ctrl_auxsrc(ctrl)) /
+           rp2040_clocks_div(s->regs[CLK_PERI_DIV / 4]);
+}
+
+static unsigned rp2040_clocks_usb_adc_rtc_freq(RP2040ClocksState *s,
+                                               uint32_t ctrl_off,
+                                               uint32_t div_off)
+{
+    uint32_t ctrl = s->regs[ctrl_off / 4];
+
+    if (!(ctrl & CTRL_ENABLE)) {
+        return 0;
+    }
+
+    return rp2040_clocks_usb_adc_rtc_aux_freq(s,
+                                              rp2040_clocks_ctrl_auxsrc(ctrl)) /
+           rp2040_clocks_div(s->regs[div_off / 4]);
+}
+
+static void rp2040_clocks_update(RP2040ClocksState *s)
+{
+    unsigned ref_hz = rp2040_clocks_ref_freq(s);
+    unsigned sys_hz = rp2040_clocks_sys_freq(s);
+
+    clock_update_hz(s->clk_ref, ref_hz);
+    clock_update_hz(s->clk_sys, sys_hz);
+    clock_update_hz(s->clk_peri, rp2040_clocks_peri_freq(s));
+    clock_update_hz(s->clk_usb,
+                    rp2040_clocks_usb_adc_rtc_freq(s, CLK_USB_CTRL,
+                                                   CLK_USB_DIV));
+    clock_update_hz(s->clk_adc,
+                    rp2040_clocks_usb_adc_rtc_freq(s, CLK_ADC_CTRL,
+                                                   CLK_ADC_DIV));
+    clock_update_hz(s->clk_rtc,
+                    rp2040_clocks_usb_adc_rtc_freq(s, CLK_RTC_CTRL,
+                                                   CLK_RTC_DIV));
+}
+
+static uint32_t rp2040_clocks_selected(RP2040ClocksState *s, hwaddr offset)
+{
+    switch (offset) {
+    case CLK_REF_SELECTED:
+        return 1u << extract32(s->regs[CLK_REF_CTRL / 4], 0, 2);
+    case CLK_SYS_SELECTED:
+        return 1u << extract32(s->regs[CLK_SYS_CTRL / 4], 0, 1);
+    case CLK_PERI_SELECTED:
+    case CLK_USB_SELECTED:
+    case CLK_ADC_SELECTED:
+    case CLK_RTC_SELECTED:
+        return 1;
+    default:
+        return 0;
+    }
+}
+
+static uint32_t rp2040_clocks_fc0_result(RP2040ClocksState *s)
+{
+    unsigned khz;
+
+    switch (s->regs[FC0_SRC / 4] & 0xff) {
+    case 0x01:
+        khz = rp2040_clocks_hz(s->pll_sys) / 1000;
+        break;
+    case 0x02:
+        khz = rp2040_clocks_hz(s->pll_usb) / 1000;
+        break;
+    case 0x03:
+    case 0x04:
+        khz = ROSC_HZ / 1000;
+        break;
+    case 0x05:
+        khz = XOSC_HZ / 1000;
+        break;
+    case 0x08:
+        khz = rp2040_clocks_ref_freq(s) / 1000;
+        break;
+    case 0x09:
+        khz = rp2040_clocks_sys_freq(s) / 1000;
+        break;
+    case 0x0a:
+        khz = clock_get_hz(s->clk_peri) / 1000;
+        break;
+    case 0x0b:
+        khz = clock_get_hz(s->clk_usb) / 1000;
+        break;
+    case 0x0c:
+        khz = clock_get_hz(s->clk_adc) / 1000;
+        break;
+    case 0x0d:
+        khz = clock_get_hz(s->clk_rtc) / 1000;
+        break;
+    default:
+        khz = 0;
+        break;
+    }
+
+    return khz << 5;
+}
+
+static bool rp2040_clocks_is_selected(hwaddr offset)
+{
+    return offset == CLK_REF_SELECTED ||
+           offset == CLK_SYS_SELECTED ||
+           offset == CLK_PERI_SELECTED ||
+           offset == CLK_USB_SELECTED ||
+           offset == CLK_ADC_SELECTED ||
+           offset == CLK_RTC_SELECTED;
+}
+
+static uint64_t rp2040_clocks_read(void *opaque, hwaddr addr, unsigned size)
+{
+    RP2040ClocksState *s = opaque;
+    hwaddr offset = addr & 0xfff;
+    uint64_t value;
+
+    if (offset >= sizeof(s->regs)) {
+        value = 0;
+        rp2040_log_unimplemented_read("clocks", size,
+                                      RP2040_CLOCKS_BASE + addr, offset,
+                                      value);
+    } else if (rp2040_clocks_is_selected(offset)) {
+        value = rp2040_clocks_selected(s, offset);
+    } else {
+        switch (offset) {
+        case FC0_STATUS:
+            value = BIT(4);
+            break;
+        case FC0_RESULT:
+            value = rp2040_clocks_fc0_result(s);
+            break;
+        case ENABLED0:
+        case ENABLED1:
+            value = s->regs[(offset - 0x10) / 4];
+            break;
+        default:
+            value = s->regs[offset / 4];
+            break;
+        }
+    }
+
+    return value;
+}
+
+static void rp2040_clocks_write(void *opaque, hwaddr addr,
+                                uint64_t value, unsigned size)
+{
+    RP2040ClocksState *s = opaque;
+    hwaddr alias = addr & ATOMIC_ALIAS_MASK;
+    hwaddr offset = addr & 0xfff;
+    uint32_t old;
+    uint32_t newval = value;
+
+    if (offset < sizeof(s->regs) && !rp2040_clocks_is_selected(offset)) {
+        old = s->regs[offset / 4];
+        switch (alias) {
+        case ATOMIC_XOR:
+            newval = old ^ value;
+            break;
+        case ATOMIC_SET:
+            newval = old | value;
+            break;
+        case ATOMIC_CLR:
+            newval = old & ~value;
+            break;
+        default:
+            break;
+        }
+
+        switch (offset) {
+        case ENABLED0:
+        case ENABLED1:
+        case FC0_STATUS:
+        case FC0_RESULT:
+        case INTR:
+            break;
+        default:
+            s->regs[offset / 4] = newval;
+            rp2040_clocks_update(s);
+            break;
+        }
+    } else if (offset >= sizeof(s->regs)) {
+        rp2040_log_unimplemented_write("clocks", size,
+                                       RP2040_CLOCKS_BASE + addr, offset,
+                                       value);
+    }
+}
+
+static void rp2040_clocks_input_update(void *opaque, ClockEvent event)
+{
+    rp2040_clocks_update(opaque);
+}
+
+static const MemoryRegionOps rp2040_clocks_ops = {
+    .read = rp2040_clocks_read,
+    .write = rp2040_clocks_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+static void rp2040_clocks_reset(DeviceState *dev)
+{
+    RP2040ClocksState *s = RP2040_CLOCKS(dev);
+
+    memset(s->regs, 0, sizeof(s->regs));
+
+    s->regs[CLK_REF_DIV / 4] = 0x00000100;
+    s->regs[CLK_SYS_DIV / 4] = 0x00000100;
+    s->regs[CLK_PERI_CTRL / 4] = CTRL_ENABLE;
+    s->regs[CLK_PERI_DIV / 4] = 0x00000100;
+    s->regs[CLK_USB_CTRL / 4] = CTRL_ENABLE | (0x3 << 5);
+    s->regs[CLK_USB_DIV / 4] = 0x00000100;
+    s->regs[CLK_ADC_CTRL / 4] = CTRL_ENABLE | (0x3 << 5);
+    s->regs[CLK_ADC_DIV / 4] = 0x00000100;
+    s->regs[CLK_RTC_CTRL / 4] = CTRL_ENABLE | (0xa << 5);
+    s->regs[CLK_RTC_DIV / 4] = 0x00000100;
+    s->regs[FC0_REF_KHZ / 4] = XOSC_HZ / 1000;
+    s->regs[WAKE_EN0 / 4] = 0xffffffff;
+    s->regs[WAKE_EN1 / 4] = 0xffffffff;
+    s->regs[SLEEP_EN0 / 4] = 0xffffffff;
+    s->regs[SLEEP_EN1 / 4] = 0xffffffff;
+
+    rp2040_clocks_update(s);
+}
+
+static void rp2040_clocks_init(Object *obj)
+{
+    RP2040ClocksState *s = RP2040_CLOCKS(obj);
+    DeviceState *dev = DEVICE(obj);
+
+    s->clk_ref = qdev_init_clock_out(dev, "clk-ref");
+    s->clk_sys = qdev_init_clock_out(dev, "clk-sys");
+    s->clk_peri = qdev_init_clock_out(dev, "clk-peri");
+    s->clk_usb = qdev_init_clock_out(dev, "clk-usb");
+    s->clk_adc = qdev_init_clock_out(dev, "clk-adc");
+    s->clk_rtc = qdev_init_clock_out(dev, "clk-rtc");
+    s->pll_sys = qdev_init_clock_in(dev, "pll-sys",
+                                    rp2040_clocks_input_update, s, 0);
+    s->pll_usb = qdev_init_clock_in(dev, "pll-usb",
+                                    rp2040_clocks_input_update, s, 0);
+
+    memory_region_init_io(&s->iomem, obj, &rp2040_clocks_ops, s,
+                          "rp2040.clocks", RP2040_CLOCKS_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->iomem);
+}
+
+static const VMStateDescription rp2040_clocks_vmstate = {
+    .name = TYPE_RP2040_CLOCKS,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(regs, RP2040ClocksState, 0x100 / 4),
+        VMSTATE_CLOCK(clk_ref, RP2040ClocksState),
+        VMSTATE_CLOCK(clk_sys, RP2040ClocksState),
+        VMSTATE_CLOCK(clk_peri, RP2040ClocksState),
+        VMSTATE_CLOCK(clk_usb, RP2040ClocksState),
+        VMSTATE_CLOCK(clk_adc, RP2040ClocksState),
+        VMSTATE_CLOCK(clk_rtc, RP2040ClocksState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void rp2040_clocks_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    device_class_set_legacy_reset(dc, rp2040_clocks_reset);
+    dc->vmsd = &rp2040_clocks_vmstate;
+}
+
+static const TypeInfo rp2040_clocks_info = {
+    .name          = TYPE_RP2040_CLOCKS,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(RP2040ClocksState),
+    .instance_init = rp2040_clocks_init,
+    .class_init    = rp2040_clocks_class_init,
+};
+
+static void rp2040_clocks_register_types(void)
+{
+    type_register_static(&rp2040_clocks_info);
+}
+type_init(rp2040_clocks_register_types)
diff --git a/hw/misc/rp2040_iobank0.c b/hw/misc/rp2040_iobank0.c
new file mode 100644
index 0000000000..60462298da
--- /dev/null
+++ b/hw/misc/rp2040_iobank0.c
@@ -0,0 +1,353 @@
+/*
+ * RP2040 GPIO IO bank emulation
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/misc/rp2040_iobank0.h"
+#include "hw/misc/rp2040_nyi.h"
+#include "hw/core/irq.h"
+#include "migration/vmstate.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+
+#define IOBANK0_GPIO_STRIDE         0x8
+#define IOBANK0_GPIO_STATUS         0x0
+#define IOBANK0_GPIO_CTRL           0x4
+
+#define IOBANK0_INTR                0x0f0
+#define IOBANK0_PROC0_INTE          0x100
+#define IOBANK0_PROC0_INTF          0x110
+#define IOBANK0_PROC0_INTS          0x120
+#define IOBANK0_PROC1_INTE          0x130
+#define IOBANK0_PROC1_INTF          0x140
+#define IOBANK0_PROC1_INTS          0x150
+#define IOBANK0_DORMANT_INTE        0x160
+#define IOBANK0_DORMANT_INTF        0x170
+#define IOBANK0_DORMANT_INTS        0x180
+
+#define IOBANK0_CTRL_RESET          0x1f
+#define IOBANK0_CTRL_RW_MASK        0x33333f
+#define IOBANK0_CTRL_FUNCSEL_MASK   0x1f
+#define IOBANK0_FUNCSEL_UART        2
+#define IOBANK0_INTR_EDGE_MASK      0xcccccccc
+#define IOBANK0_INTR_LAST_EDGE_MASK 0x00cccccc
+#define IOBANK0_IRQ_MASK            0xffffffff
+#define IOBANK0_IRQ_LAST_MASK       0x00ffffff
+
+#define ATOMIC_ALIAS_MASK           0x3000
+#define ATOMIC_XOR                  0x1000
+#define ATOMIC_SET                  0x2000
+#define ATOMIC_CLR                  0x3000
+
+static uint32_t rp2040_iobank0_apply_alias(uint32_t old, uint32_t value,
+                                           hwaddr alias)
+{
+    switch (alias) {
+    case ATOMIC_XOR:
+        return old ^ value;
+    case ATOMIC_SET:
+        return old | value;
+    case ATOMIC_CLR:
+        return old & ~value;
+    default:
+        return value;
+    }
+}
+
+static bool rp2040_iobank0_gpio_offset(hwaddr offset, unsigned *gpio,
+                                       unsigned *reg)
+{
+    if (offset >= RP2040_IOBANK0_NUM_GPIOS * IOBANK0_GPIO_STRIDE) {
+        return false;
+    }
+
+    *gpio = offset / IOBANK0_GPIO_STRIDE;
+    *reg = offset & (IOBANK0_GPIO_STRIDE - 1);
+    return *reg == IOBANK0_GPIO_STATUS || *reg == IOBANK0_GPIO_CTRL;
+}
+
+static bool rp2040_iobank0_bank_offset(hwaddr offset, hwaddr base,
+                                       unsigned *bank)
+{
+    if (offset < base || offset >= base + RP2040_IOBANK0_IRQ_BANKS * 4 ||
+        (offset & 0x3)) {
+        return false;
+    }
+
+    *bank = (offset - base) / 4;
+    return true;
+}
+
+static uint32_t rp2040_iobank0_irq_mask(unsigned bank)
+{
+    return bank == 3 ? IOBANK0_IRQ_LAST_MASK : IOBANK0_IRQ_MASK;
+}
+
+static uint32_t rp2040_iobank0_intr_edge_mask(unsigned bank)
+{
+    return bank == 3 ? IOBANK0_INTR_LAST_EDGE_MASK : IOBANK0_INTR_EDGE_MASK;
+}
+
+static uint32_t rp2040_iobank0_ints(uint32_t intr, uint32_t inte,
+                                    uint32_t intf)
+{
+    return (intr & inte) | intf;
+}
+
+static bool rp2040_iobank0_gpio_is_uart(RP2040IoBank0State *s, unsigned gpio)
+{
+    return (s->ctrl[gpio] & IOBANK0_CTRL_FUNCSEL_MASK) == IOBANK0_FUNCSEL_UART;
+}
+
+bool rp2040_iobank0_uart0_tx_enabled(RP2040IoBank0State *s)
+{
+    return rp2040_iobank0_gpio_is_uart(s, 0);
+}
+
+bool rp2040_iobank0_uart0_rx_enabled(RP2040IoBank0State *s)
+{
+    return rp2040_iobank0_gpio_is_uart(s, 1);
+}
+
+bool rp2040_iobank0_uart1_tx_enabled(RP2040IoBank0State *s)
+{
+    return rp2040_iobank0_gpio_is_uart(s, 4);
+}
+
+bool rp2040_iobank0_uart1_rx_enabled(RP2040IoBank0State *s)
+{
+    return rp2040_iobank0_gpio_is_uart(s, 5);
+}
+
+static void rp2040_iobank0_update_uart_pins(RP2040IoBank0State *s)
+{
+    qemu_set_irq(s->uart0_pin[0], rp2040_iobank0_uart0_tx_enabled(s));
+    qemu_set_irq(s->uart0_pin[1], rp2040_iobank0_uart0_rx_enabled(s));
+    qemu_set_irq(s->uart1_pin[0], rp2040_iobank0_uart1_tx_enabled(s));
+    qemu_set_irq(s->uart1_pin[1], rp2040_iobank0_uart1_rx_enabled(s));
+}
+
+static void rp2040_iobank0_update_irq(RP2040IoBank0State *s)
+{
+    bool proc0_level = false;
+    bool proc1_level = false;
+    int i;
+
+    for (i = 0; i < RP2040_IOBANK0_IRQ_BANKS; i++) {
+        proc0_level |= rp2040_iobank0_ints(s->intr[i], s->proc0_inte[i],
+                                           s->proc0_intf[i]) != 0;
+        proc1_level |= rp2040_iobank0_ints(s->intr[i], s->proc1_inte[i],
+                                           s->proc1_intf[i]) != 0;
+    }
+
+    qemu_set_irq(s->proc0_irq, proc0_level);
+    qemu_set_irq(s->proc1_irq, proc1_level);
+}
+
+static uint64_t rp2040_iobank0_read(void *opaque, hwaddr addr, unsigned size)
+{
+    RP2040IoBank0State *s = opaque;
+    hwaddr offset = addr & 0xfff;
+    unsigned gpio;
+    unsigned reg;
+    unsigned bank;
+    uint64_t value;
+
+    if (rp2040_iobank0_gpio_offset(offset, &gpio, &reg)) {
+        value = reg == IOBANK0_GPIO_STATUS ? 0 : s->ctrl[gpio];
+    } else if (rp2040_iobank0_bank_offset(offset, IOBANK0_INTR, &bank)) {
+        value = s->intr[bank];
+    } else if (rp2040_iobank0_bank_offset(offset, IOBANK0_PROC0_INTE, &bank)) {
+        value = s->proc0_inte[bank];
+    } else if (rp2040_iobank0_bank_offset(offset, IOBANK0_PROC0_INTF, &bank)) {
+        value = s->proc0_intf[bank];
+    } else if (rp2040_iobank0_bank_offset(offset, IOBANK0_PROC0_INTS, &bank)) {
+        value = rp2040_iobank0_ints(s->intr[bank], s->proc0_inte[bank],
+                                    s->proc0_intf[bank]);
+    } else if (rp2040_iobank0_bank_offset(offset, IOBANK0_PROC1_INTE, &bank)) {
+        value = s->proc1_inte[bank];
+    } else if (rp2040_iobank0_bank_offset(offset, IOBANK0_PROC1_INTF, &bank)) {
+        value = s->proc1_intf[bank];
+    } else if (rp2040_iobank0_bank_offset(offset, IOBANK0_PROC1_INTS, &bank)) {
+        value = rp2040_iobank0_ints(s->intr[bank], s->proc1_inte[bank],
+                                    s->proc1_intf[bank]);
+    } else if (rp2040_iobank0_bank_offset(offset, IOBANK0_DORMANT_INTE,
+                                          &bank)) {
+        value = s->dormant_wake_inte[bank];
+    } else if (rp2040_iobank0_bank_offset(offset, IOBANK0_DORMANT_INTF,
+                                          &bank)) {
+        value = s->dormant_wake_intf[bank];
+    } else if (rp2040_iobank0_bank_offset(offset, IOBANK0_DORMANT_INTS,
+                                          &bank)) {
+        value = rp2040_iobank0_ints(s->intr[bank],
+                                    s->dormant_wake_inte[bank],
+                                    s->dormant_wake_intf[bank]);
+    } else {
+        value = 0;
+        rp2040_log_unimplemented_read("iobank0", size,
+                                      RP2040_IOBANK0_BASE + addr, offset,
+                                      value);
+    }
+
+    return value;
+}
+
+static void rp2040_iobank0_write_irq_reg(uint32_t *reg, uint64_t value64,
+                                         hwaddr alias, unsigned bank)
+{
+    *reg = rp2040_iobank0_apply_alias(*reg, value64, alias) &
+           rp2040_iobank0_irq_mask(bank);
+}
+
+static void rp2040_iobank0_write(void *opaque, hwaddr addr, uint64_t value64,
+                                 unsigned size)
+{
+    RP2040IoBank0State *s = opaque;
+    hwaddr alias = addr & ATOMIC_ALIAS_MASK;
+    hwaddr offset = addr & 0xfff;
+    unsigned gpio;
+    unsigned reg;
+    unsigned bank;
+    uint32_t value = value64;
+
+    if (rp2040_iobank0_gpio_offset(offset, &gpio, &reg)) {
+        if (reg == IOBANK0_GPIO_CTRL) {
+            s->ctrl[gpio] =
+                rp2040_iobank0_apply_alias(s->ctrl[gpio], value, alias) &
+                IOBANK0_CTRL_RW_MASK;
+            if (gpio <= 1 || gpio == 4 || gpio == 5) {
+                rp2040_iobank0_update_uart_pins(s);
+            }
+        }
+    } else if (rp2040_iobank0_bank_offset(offset, IOBANK0_INTR, &bank)) {
+        s->intr[bank] &= ~(value & rp2040_iobank0_intr_edge_mask(bank));
+        rp2040_iobank0_update_irq(s);
+    } else if (rp2040_iobank0_bank_offset(offset, IOBANK0_PROC0_INTE, &bank)) {
+        rp2040_iobank0_write_irq_reg(&s->proc0_inte[bank], value, alias,
+                                     bank);
+        rp2040_iobank0_update_irq(s);
+    } else if (rp2040_iobank0_bank_offset(offset, IOBANK0_PROC0_INTF, &bank)) {
+        rp2040_iobank0_write_irq_reg(&s->proc0_intf[bank], value, alias,
+                                     bank);
+        rp2040_iobank0_update_irq(s);
+    } else if (rp2040_iobank0_bank_offset(offset, IOBANK0_PROC1_INTE, &bank)) {
+        rp2040_iobank0_write_irq_reg(&s->proc1_inte[bank], value, alias,
+                                     bank);
+        rp2040_iobank0_update_irq(s);
+    } else if (rp2040_iobank0_bank_offset(offset, IOBANK0_PROC1_INTF, &bank)) {
+        rp2040_iobank0_write_irq_reg(&s->proc1_intf[bank], value, alias,
+                                     bank);
+        rp2040_iobank0_update_irq(s);
+    } else if (rp2040_iobank0_bank_offset(offset, IOBANK0_DORMANT_INTE,
+                                          &bank)) {
+        rp2040_iobank0_write_irq_reg(&s->dormant_wake_inte[bank], value,
+                                     alias, bank);
+    } else if (rp2040_iobank0_bank_offset(offset, IOBANK0_DORMANT_INTF,
+                                          &bank)) {
+        rp2040_iobank0_write_irq_reg(&s->dormant_wake_intf[bank], value,
+                                     alias, bank);
+    } else if (!rp2040_iobank0_bank_offset(offset, IOBANK0_PROC0_INTS,
+                                           &bank) &&
+               !rp2040_iobank0_bank_offset(offset, IOBANK0_PROC1_INTS,
+                                           &bank) &&
+               !rp2040_iobank0_bank_offset(offset, IOBANK0_DORMANT_INTS,
+                                           &bank)) {
+        rp2040_log_unimplemented_write("iobank0", size,
+                                       RP2040_IOBANK0_BASE + addr, offset,
+                                       value64);
+    }
+}
+
+static const MemoryRegionOps rp2040_iobank0_ops = {
+    .read = rp2040_iobank0_read,
+    .write = rp2040_iobank0_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+static void rp2040_iobank0_reset(DeviceState *dev)
+{
+    RP2040IoBank0State *s = RP2040_IOBANK0(dev);
+    int i;
+
+    for (i = 0; i < ARRAY_SIZE(s->ctrl); i++) {
+        s->ctrl[i] = IOBANK0_CTRL_RESET;
+    }
+
+    memset(s->intr, 0, sizeof(s->intr));
+    memset(s->proc0_inte, 0, sizeof(s->proc0_inte));
+    memset(s->proc0_intf, 0, sizeof(s->proc0_intf));
+    memset(s->proc1_inte, 0, sizeof(s->proc1_inte));
+    memset(s->proc1_intf, 0, sizeof(s->proc1_intf));
+    memset(s->dormant_wake_inte, 0, sizeof(s->dormant_wake_inte));
+    memset(s->dormant_wake_intf, 0, sizeof(s->dormant_wake_intf));
+    rp2040_iobank0_update_irq(s);
+    rp2040_iobank0_update_uart_pins(s);
+}
+
+static void rp2040_iobank0_init(Object *obj)
+{
+    RP2040IoBank0State *s = RP2040_IOBANK0(obj);
+
+    memory_region_init_io(&s->iomem, obj, &rp2040_iobank0_ops, s,
+                          "rp2040.iobank0", RP2040_IOBANK0_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->iomem);
+    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->proc0_irq);
+    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->proc1_irq);
+    qdev_init_gpio_out_named(DEVICE(obj), s->uart0_pin, "uart0-pin",
+                             ARRAY_SIZE(s->uart0_pin));
+    qdev_init_gpio_out_named(DEVICE(obj), s->uart1_pin, "uart1-pin",
+                             ARRAY_SIZE(s->uart1_pin));
+}
+
+static const VMStateDescription rp2040_iobank0_vmstate = {
+    .name = TYPE_RP2040_IOBANK0,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(ctrl, RP2040IoBank0State,
+                             RP2040_IOBANK0_NUM_GPIOS),
+        VMSTATE_UINT32_ARRAY(intr, RP2040IoBank0State,
+                             RP2040_IOBANK0_IRQ_BANKS),
+        VMSTATE_UINT32_ARRAY(proc0_inte, RP2040IoBank0State,
+                             RP2040_IOBANK0_IRQ_BANKS),
+        VMSTATE_UINT32_ARRAY(proc0_intf, RP2040IoBank0State,
+                             RP2040_IOBANK0_IRQ_BANKS),
+        VMSTATE_UINT32_ARRAY(proc1_inte, RP2040IoBank0State,
+                             RP2040_IOBANK0_IRQ_BANKS),
+        VMSTATE_UINT32_ARRAY(proc1_intf, RP2040IoBank0State,
+                             RP2040_IOBANK0_IRQ_BANKS),
+        VMSTATE_UINT32_ARRAY(dormant_wake_inte, RP2040IoBank0State,
+                             RP2040_IOBANK0_IRQ_BANKS),
+        VMSTATE_UINT32_ARRAY(dormant_wake_intf, RP2040IoBank0State,
+                             RP2040_IOBANK0_IRQ_BANKS),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void rp2040_iobank0_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    device_class_set_legacy_reset(dc, rp2040_iobank0_reset);
+    dc->vmsd = &rp2040_iobank0_vmstate;
+}
+
+static const TypeInfo rp2040_iobank0_info = {
+    .name          = TYPE_RP2040_IOBANK0,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(RP2040IoBank0State),
+    .instance_init = rp2040_iobank0_init,
+    .class_init    = rp2040_iobank0_class_init,
+};
+
+static void rp2040_iobank0_register_types(void)
+{
+    type_register_static(&rp2040_iobank0_info);
+}
+type_init(rp2040_iobank0_register_types)
diff --git a/hw/misc/rp2040_ioqspi.c b/hw/misc/rp2040_ioqspi.c
new file mode 100644
index 0000000000..8356b7aea0
--- /dev/null
+++ b/hw/misc/rp2040_ioqspi.c
@@ -0,0 +1,294 @@
+/*
+ * RP2040 QSPI IO bank emulation
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/misc/rp2040_nyi.h"
+#include "hw/misc/rp2040_ioqspi.h"
+#include "hw/ssi/rp2040_xip.h"
+#include "migration/vmstate.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+
+#define IOQSPI_INTR             0x30
+#define IOQSPI_PROC0_INTE       0x34
+#define IOQSPI_PROC0_INTF       0x38
+#define IOQSPI_PROC0_INTS       0x3c
+#define IOQSPI_PROC1_INTE       0x40
+#define IOQSPI_PROC1_INTF       0x44
+#define IOQSPI_PROC1_INTS       0x48
+#define IOQSPI_DORMANT_INTE     0x4c
+#define IOQSPI_DORMANT_INTF     0x50
+#define IOQSPI_DORMANT_INTS     0x54
+
+#define IOQSPI_CTRL_RESET       0x1f
+#define IOQSPI_CTRL_RW_MASK     0x33333f
+#define IOQSPI_CTRL_OUTOVER_MASK 0x300
+#define IOQSPI_CTRL_OUTOVER_LOW  0x200
+#define IOQSPI_CTRL_OUTOVER_HIGH 0x300
+#define IOQSPI_SS_INDEX          1
+#define IOQSPI_INTR_EDGE_MASK   0x00cccccc
+#define IOQSPI_IRQ_MASK         0x00ffffff
+
+#define ATOMIC_ALIAS_MASK       0x3000
+#define ATOMIC_XOR              0x1000
+#define ATOMIC_SET              0x2000
+#define ATOMIC_CLR              0x3000
+
+static uint32_t rp2040_ioqspi_apply_alias(uint32_t old, uint32_t value,
+                                          hwaddr alias)
+{
+    switch (alias) {
+    case ATOMIC_XOR:
+        return old ^ value;
+    case ATOMIC_SET:
+        return old | value;
+    case ATOMIC_CLR:
+        return old & ~value;
+    default:
+        return value;
+    }
+}
+
+static bool rp2040_ioqspi_ctrl_offset(hwaddr offset, unsigned *index)
+{
+    if (offset > 0x2c || (offset & 0x7) != 0x4) {
+        return false;
+    }
+
+    *index = offset / 8;
+    return *index < ARRAY_SIZE(((RP2040IoQspiState *)0)->ctrl);
+}
+
+static bool rp2040_ioqspi_status_offset(hwaddr offset)
+{
+    return offset <= 0x28 && (offset & 0x7) == 0;
+}
+
+static uint32_t rp2040_ioqspi_ints(uint32_t intr, uint32_t inte,
+                                   uint32_t intf)
+{
+    return (intr & inte) | intf;
+}
+
+static void rp2040_ioqspi_update_ss(RP2040IoQspiState *s)
+{
+    uint32_t outover;
+
+    if (!s->xip) {
+        return;
+    }
+
+    outover = s->ctrl[IOQSPI_SS_INDEX] & IOQSPI_CTRL_OUTOVER_MASK;
+    if (outover == IOQSPI_CTRL_OUTOVER_LOW) {
+        rp2040_xip_qspi_cs(s->xip, false);
+    } else if (outover == IOQSPI_CTRL_OUTOVER_HIGH) {
+        rp2040_xip_qspi_cs(s->xip, true);
+    }
+}
+
+static uint64_t rp2040_ioqspi_read(void *opaque, hwaddr addr, unsigned size)
+{
+    RP2040IoQspiState *s = opaque;
+    hwaddr offset = addr & 0xfff;
+    unsigned index;
+    uint64_t value;
+
+    if (rp2040_ioqspi_status_offset(offset)) {
+        value = 0;
+    } else if (rp2040_ioqspi_ctrl_offset(offset, &index)) {
+        value = s->ctrl[index];
+    } else {
+        switch (offset) {
+        case IOQSPI_INTR:
+            value = s->intr;
+            break;
+        case IOQSPI_PROC0_INTE:
+            value = s->proc0_inte;
+            break;
+        case IOQSPI_PROC0_INTF:
+            value = s->proc0_intf;
+            break;
+        case IOQSPI_PROC0_INTS:
+            value = rp2040_ioqspi_ints(s->intr, s->proc0_inte,
+                                       s->proc0_intf);
+            break;
+        case IOQSPI_PROC1_INTE:
+            value = s->proc1_inte;
+            break;
+        case IOQSPI_PROC1_INTF:
+            value = s->proc1_intf;
+            break;
+        case IOQSPI_PROC1_INTS:
+            value = rp2040_ioqspi_ints(s->intr, s->proc1_inte,
+                                       s->proc1_intf);
+            break;
+        case IOQSPI_DORMANT_INTE:
+            value = s->dormant_wake_inte;
+            break;
+        case IOQSPI_DORMANT_INTF:
+            value = s->dormant_wake_intf;
+            break;
+        case IOQSPI_DORMANT_INTS:
+            value = rp2040_ioqspi_ints(s->intr, s->dormant_wake_inte,
+                                       s->dormant_wake_intf);
+            break;
+        default:
+            value = 0;
+            rp2040_log_unimplemented_read("ioqspi", size,
+                                          RP2040_IOQSPI_BASE + addr, offset,
+                                          value);
+            break;
+        }
+    }
+
+    return value;
+}
+
+static void rp2040_ioqspi_write(void *opaque, hwaddr addr,
+                                uint64_t value64, unsigned size)
+{
+    RP2040IoQspiState *s = opaque;
+    hwaddr alias = addr & ATOMIC_ALIAS_MASK;
+    hwaddr offset = addr & 0xfff;
+    unsigned index;
+    uint32_t value = value64;
+
+    if (rp2040_ioqspi_ctrl_offset(offset, &index)) {
+        s->ctrl[index] =
+            rp2040_ioqspi_apply_alias(s->ctrl[index], value, alias) &
+            IOQSPI_CTRL_RW_MASK;
+        if (index == IOQSPI_SS_INDEX) {
+            rp2040_ioqspi_update_ss(s);
+        }
+    } else {
+        switch (offset) {
+        case IOQSPI_INTR:
+            s->intr &= ~(value & IOQSPI_INTR_EDGE_MASK);
+            break;
+        case IOQSPI_PROC0_INTE:
+            s->proc0_inte =
+                rp2040_ioqspi_apply_alias(s->proc0_inte, value, alias) &
+                IOQSPI_IRQ_MASK;
+            break;
+        case IOQSPI_PROC0_INTF:
+            s->proc0_intf =
+                rp2040_ioqspi_apply_alias(s->proc0_intf, value, alias) &
+                IOQSPI_IRQ_MASK;
+            break;
+        case IOQSPI_PROC1_INTE:
+            s->proc1_inte =
+                rp2040_ioqspi_apply_alias(s->proc1_inte, value, alias) &
+                IOQSPI_IRQ_MASK;
+            break;
+        case IOQSPI_PROC1_INTF:
+            s->proc1_intf =
+                rp2040_ioqspi_apply_alias(s->proc1_intf, value, alias) &
+                IOQSPI_IRQ_MASK;
+            break;
+        case IOQSPI_DORMANT_INTE:
+            s->dormant_wake_inte =
+                rp2040_ioqspi_apply_alias(s->dormant_wake_inte, value,
+                                          alias) &
+                IOQSPI_IRQ_MASK;
+            break;
+        case IOQSPI_DORMANT_INTF:
+            s->dormant_wake_intf =
+                rp2040_ioqspi_apply_alias(s->dormant_wake_intf, value,
+                                          alias) &
+                IOQSPI_IRQ_MASK;
+            break;
+        default:
+            if (!rp2040_ioqspi_status_offset(offset)) {
+                rp2040_log_unimplemented_write("ioqspi", size,
+                                               RP2040_IOQSPI_BASE + addr,
+                                               offset, value64);
+            }
+            break;
+        }
+    }
+}
+
+static const Property rp2040_ioqspi_properties[] = {
+    DEFINE_PROP_LINK("xip", RP2040IoQspiState, xip, TYPE_RP2040_XIP,
+                     RP2040XipState *),
+};
+
+static const MemoryRegionOps rp2040_ioqspi_ops = {
+    .read = rp2040_ioqspi_read,
+    .write = rp2040_ioqspi_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+static void rp2040_ioqspi_reset(DeviceState *dev)
+{
+    RP2040IoQspiState *s = RP2040_IOQSPI(dev);
+    int i;
+
+    for (i = 0; i < ARRAY_SIZE(s->ctrl); i++) {
+        s->ctrl[i] = IOQSPI_CTRL_RESET;
+    }
+    s->intr = 0;
+    s->proc0_inte = 0;
+    s->proc0_intf = 0;
+    s->proc1_inte = 0;
+    s->proc1_intf = 0;
+    s->dormant_wake_inte = 0;
+    s->dormant_wake_intf = 0;
+}
+
+static void rp2040_ioqspi_init(Object *obj)
+{
+    RP2040IoQspiState *s = RP2040_IOQSPI(obj);
+
+    memory_region_init_io(&s->iomem, obj, &rp2040_ioqspi_ops, s,
+                          "rp2040.ioqspi", RP2040_IOQSPI_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->iomem);
+}
+
+static const VMStateDescription rp2040_ioqspi_vmstate = {
+    .name = TYPE_RP2040_IOQSPI,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(ctrl, RP2040IoQspiState, 6),
+        VMSTATE_UINT32(intr, RP2040IoQspiState),
+        VMSTATE_UINT32(proc0_inte, RP2040IoQspiState),
+        VMSTATE_UINT32(proc0_intf, RP2040IoQspiState),
+        VMSTATE_UINT32(proc1_inte, RP2040IoQspiState),
+        VMSTATE_UINT32(proc1_intf, RP2040IoQspiState),
+        VMSTATE_UINT32(dormant_wake_inte, RP2040IoQspiState),
+        VMSTATE_UINT32(dormant_wake_intf, RP2040IoQspiState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void rp2040_ioqspi_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    device_class_set_legacy_reset(dc, rp2040_ioqspi_reset);
+    device_class_set_props(dc, rp2040_ioqspi_properties);
+    dc->vmsd = &rp2040_ioqspi_vmstate;
+}
+
+static const TypeInfo rp2040_ioqspi_info = {
+    .name          = TYPE_RP2040_IOQSPI,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(RP2040IoQspiState),
+    .instance_init = rp2040_ioqspi_init,
+    .class_init    = rp2040_ioqspi_class_init,
+};
+
+static void rp2040_ioqspi_register_types(void)
+{
+    type_register_static(&rp2040_ioqspi_info);
+}
+type_init(rp2040_ioqspi_register_types)
diff --git a/hw/misc/rp2040_nyi.c b/hw/misc/rp2040_nyi.c
new file mode 100644
index 0000000000..7e9e4c09a1
--- /dev/null
+++ b/hw/misc/rp2040_nyi.c
@@ -0,0 +1,47 @@
+/*
+ * RP2040 "not yet implemented" diagnostics
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/misc/rp2040_nyi.h"
+#include "qemu/log.h"
+
+void rp2040_log_nyi(const char *component, const char *feature,
+                    const char *detail)
+{
+    if (g_str_has_prefix(component, "rp2040.")) {
+        component += strlen("rp2040.");
+    }
+
+    qemu_log_mask(LOG_UNIMP, "Not yet implemented: rp2040.%s: %s%s%s\n",
+                  component, feature, detail ? ": " : "",
+                  detail ? detail : "");
+}
+
+void rp2040_log_unimplemented_read(const char *component, unsigned size,
+                                   uint64_t addr, uint64_t offset,
+                                   uint64_t value)
+{
+    char detail[128];
+
+    snprintf(detail, sizeof(detail),
+             "size %u, addr 0x%08" PRIx64 ", offset 0x%04" PRIx64
+             " -> 0x%0*" PRIx64,
+             size, addr, offset, size << 1, value);
+    rp2040_log_nyi(component, "unimplemented read", detail);
+}
+
+void rp2040_log_unimplemented_write(const char *component, unsigned size,
+                                    uint64_t addr, uint64_t offset,
+                                    uint64_t value)
+{
+    char detail[128];
+
+    snprintf(detail, sizeof(detail),
+             "size %u, addr 0x%08" PRIx64 ", offset 0x%04" PRIx64
+             ", value 0x%0*" PRIx64,
+             size, addr, offset, size << 1, value);
+    rp2040_log_nyi(component, "unimplemented write", detail);
+}
diff --git a/hw/misc/rp2040_pads.c b/hw/misc/rp2040_pads.c
new file mode 100644
index 0000000000..e18dc0fa90
--- /dev/null
+++ b/hw/misc/rp2040_pads.c
@@ -0,0 +1,323 @@
+/*
+ * RP2040 pad control emulation
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/misc/rp2040_nyi.h"
+#include "hw/misc/rp2040_pads.h"
+#include "migration/vmstate.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+
+#define PADS_BANK0_VOLTAGE_SELECT 0x00
+#define PADS_BANK0_GPIO0          0x04
+#define PADS_BANK0_GPIO29         0x78
+#define PADS_BANK0_SWCLK          0x7c
+#define PADS_BANK0_SWD            0x80
+
+#define PADS_QSPI_VOLTAGE_SELECT 0x00
+#define PADS_QSPI_SCLK           0x04
+#define PADS_QSPI_SS             0x18
+
+#define PADS_VOLTAGE_SELECT_MASK BIT(0)
+#define PADS_PAD_MASK            0xff
+#define PADS_BANK0_GPIO_RESET     0x56
+#define PADS_BANK0_SWD_RESET      0x5a
+#define PADS_QSPI_SCLK_RESET     0x56
+#define PADS_QSPI_SD_RESET       0x52
+#define PADS_QSPI_SS_RESET       0x5a
+
+#define ATOMIC_ALIAS_MASK        0x3000
+#define ATOMIC_XOR               0x1000
+#define ATOMIC_SET               0x2000
+#define ATOMIC_CLR               0x3000
+
+static uint32_t rp2040_pads_apply_alias(uint32_t old, uint32_t value,
+                                        hwaddr alias)
+{
+    switch (alias) {
+    case ATOMIC_XOR:
+        return old ^ value;
+    case ATOMIC_SET:
+        return old | value;
+    case ATOMIC_CLR:
+        return old & ~value;
+    default:
+        return value;
+    }
+}
+
+static bool rp2040_pads_bank0_gpio_offset(hwaddr offset, unsigned *index)
+{
+    if (offset < PADS_BANK0_GPIO0 || offset > PADS_BANK0_GPIO29 ||
+        (offset & 0x3)) {
+        return false;
+    }
+
+    *index = (offset - PADS_BANK0_GPIO0) / sizeof(uint32_t);
+    return *index < ARRAY_SIZE(((RP2040PadsBank0State *)0)->gpio);
+}
+
+static bool rp2040_pads_qspi_pad_offset(hwaddr offset, unsigned *index)
+{
+    if (offset < PADS_QSPI_SCLK || offset > PADS_QSPI_SS ||
+        (offset & 0x3)) {
+        return false;
+    }
+
+    *index = (offset - PADS_QSPI_SCLK) / sizeof(uint32_t);
+    return *index < ARRAY_SIZE(((RP2040PadsQspiState *)0)->pad);
+}
+
+static uint64_t rp2040_pads_bank0_read(void *opaque, hwaddr addr,
+                                       unsigned size)
+{
+    RP2040PadsBank0State *s = opaque;
+    hwaddr offset = addr & 0xfff;
+    unsigned index;
+    uint64_t value;
+
+    switch (offset) {
+    case PADS_BANK0_VOLTAGE_SELECT:
+        value = s->voltage_select;
+        break;
+    case PADS_BANK0_SWCLK:
+        value = s->swclk;
+        break;
+    case PADS_BANK0_SWD:
+        value = s->swd;
+        break;
+    default:
+        if (rp2040_pads_bank0_gpio_offset(offset, &index)) {
+            value = s->gpio[index];
+        } else {
+            value = 0;
+            rp2040_log_unimplemented_read("padsbank0", size,
+                                          RP2040_PADS_BANK0_BASE + addr,
+                                          offset, value);
+        }
+        break;
+    }
+
+    return value;
+}
+
+static void rp2040_pads_bank0_write(void *opaque, hwaddr addr,
+                                    uint64_t value64, unsigned size)
+{
+    RP2040PadsBank0State *s = opaque;
+    hwaddr alias = addr & ATOMIC_ALIAS_MASK;
+    hwaddr offset = addr & 0xfff;
+    unsigned index;
+    uint32_t value = value64;
+
+    switch (offset) {
+    case PADS_BANK0_VOLTAGE_SELECT:
+        s->voltage_select =
+            rp2040_pads_apply_alias(s->voltage_select, value, alias) &
+            PADS_VOLTAGE_SELECT_MASK;
+        break;
+    case PADS_BANK0_SWCLK:
+        s->swclk = rp2040_pads_apply_alias(s->swclk, value, alias) &
+                   PADS_PAD_MASK;
+        break;
+    case PADS_BANK0_SWD:
+        s->swd = rp2040_pads_apply_alias(s->swd, value, alias) &
+                 PADS_PAD_MASK;
+        break;
+    default:
+        if (rp2040_pads_bank0_gpio_offset(offset, &index)) {
+            s->gpio[index] = rp2040_pads_apply_alias(s->gpio[index], value,
+                                                     alias) & PADS_PAD_MASK;
+        } else {
+            rp2040_log_unimplemented_write("padsbank0", size,
+                                           RP2040_PADS_BANK0_BASE + addr,
+                                           offset, value64);
+        }
+        break;
+    }
+}
+
+static uint64_t rp2040_pads_qspi_read(void *opaque, hwaddr addr,
+                                      unsigned size)
+{
+    RP2040PadsQspiState *s = opaque;
+    hwaddr offset = addr & 0xfff;
+    unsigned index;
+    uint64_t value;
+
+    switch (offset) {
+    case PADS_QSPI_VOLTAGE_SELECT:
+        value = s->voltage_select;
+        break;
+    default:
+        if (rp2040_pads_qspi_pad_offset(offset, &index)) {
+            value = s->pad[index];
+        } else {
+            value = 0;
+            rp2040_log_unimplemented_read("padsqspi", size,
+                                          RP2040_PADS_QSPI_BASE + addr,
+                                          offset, value);
+        }
+        break;
+    }
+
+    return value;
+}
+
+static void rp2040_pads_qspi_write(void *opaque, hwaddr addr,
+                                   uint64_t value64, unsigned size)
+{
+    RP2040PadsQspiState *s = opaque;
+    hwaddr alias = addr & ATOMIC_ALIAS_MASK;
+    hwaddr offset = addr & 0xfff;
+    unsigned index;
+    uint32_t value = value64;
+
+    switch (offset) {
+    case PADS_QSPI_VOLTAGE_SELECT:
+        s->voltage_select =
+            rp2040_pads_apply_alias(s->voltage_select, value, alias) &
+            PADS_VOLTAGE_SELECT_MASK;
+        break;
+    default:
+        if (rp2040_pads_qspi_pad_offset(offset, &index)) {
+            s->pad[index] = rp2040_pads_apply_alias(s->pad[index], value,
+                                                    alias) & PADS_PAD_MASK;
+        } else {
+            rp2040_log_unimplemented_write("padsqspi", size,
+                                           RP2040_PADS_QSPI_BASE + addr,
+                                           offset, value64);
+        }
+        break;
+    }
+}
+
+static const MemoryRegionOps rp2040_pads_bank0_ops = {
+    .read = rp2040_pads_bank0_read,
+    .write = rp2040_pads_bank0_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+static const MemoryRegionOps rp2040_pads_qspi_ops = {
+    .read = rp2040_pads_qspi_read,
+    .write = rp2040_pads_qspi_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+static void rp2040_pads_bank0_reset(DeviceState *dev)
+{
+    RP2040PadsBank0State *s = RP2040_PADS_BANK0(dev);
+    unsigned i;
+
+    s->voltage_select = 0;
+    for (i = 0; i < ARRAY_SIZE(s->gpio); i++) {
+        s->gpio[i] = PADS_BANK0_GPIO_RESET;
+    }
+    s->swclk = PADS_BANK0_SWD_RESET;
+    s->swd = PADS_BANK0_SWD_RESET;
+}
+
+static void rp2040_pads_qspi_reset(DeviceState *dev)
+{
+    RP2040PadsQspiState *s = RP2040_PADS_QSPI(dev);
+
+    s->voltage_select = 0;
+    s->pad[0] = PADS_QSPI_SCLK_RESET;
+    s->pad[1] = PADS_QSPI_SD_RESET;
+    s->pad[2] = PADS_QSPI_SD_RESET;
+    s->pad[3] = PADS_QSPI_SD_RESET;
+    s->pad[4] = PADS_QSPI_SD_RESET;
+    s->pad[5] = PADS_QSPI_SS_RESET;
+}
+
+static void rp2040_pads_bank0_init(Object *obj)
+{
+    RP2040PadsBank0State *s = RP2040_PADS_BANK0(obj);
+
+    memory_region_init_io(&s->iomem, obj, &rp2040_pads_bank0_ops, s,
+                          "rp2040.padsbank0", RP2040_PADS_BANK0_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->iomem);
+}
+
+static void rp2040_pads_qspi_init(Object *obj)
+{
+    RP2040PadsQspiState *s = RP2040_PADS_QSPI(obj);
+
+    memory_region_init_io(&s->iomem, obj, &rp2040_pads_qspi_ops, s,
+                          "rp2040.padsqspi", RP2040_PADS_QSPI_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->iomem);
+}
+
+static const VMStateDescription rp2040_pads_bank0_vmstate = {
+    .name = TYPE_RP2040_PADS_BANK0,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32(voltage_select, RP2040PadsBank0State),
+        VMSTATE_UINT32_ARRAY(gpio, RP2040PadsBank0State, 30),
+        VMSTATE_UINT32(swclk, RP2040PadsBank0State),
+        VMSTATE_UINT32(swd, RP2040PadsBank0State),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const VMStateDescription rp2040_pads_qspi_vmstate = {
+    .name = TYPE_RP2040_PADS_QSPI,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32(voltage_select, RP2040PadsQspiState),
+        VMSTATE_UINT32_ARRAY(pad, RP2040PadsQspiState, 6),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void rp2040_pads_bank0_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    device_class_set_legacy_reset(dc, rp2040_pads_bank0_reset);
+    dc->vmsd = &rp2040_pads_bank0_vmstate;
+}
+
+static void rp2040_pads_qspi_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    device_class_set_legacy_reset(dc, rp2040_pads_qspi_reset);
+    dc->vmsd = &rp2040_pads_qspi_vmstate;
+}
+
+static const TypeInfo rp2040_pads_bank0_info = {
+    .name          = TYPE_RP2040_PADS_BANK0,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(RP2040PadsBank0State),
+    .instance_init = rp2040_pads_bank0_init,
+    .class_init    = rp2040_pads_bank0_class_init,
+};
+
+static const TypeInfo rp2040_pads_qspi_info = {
+    .name          = TYPE_RP2040_PADS_QSPI,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(RP2040PadsQspiState),
+    .instance_init = rp2040_pads_qspi_init,
+    .class_init    = rp2040_pads_qspi_class_init,
+};
+
+static void rp2040_pads_register_types(void)
+{
+    type_register_static(&rp2040_pads_bank0_info);
+    type_register_static(&rp2040_pads_qspi_info);
+}
+type_init(rp2040_pads_register_types)
diff --git a/hw/misc/rp2040_pll.c b/hw/misc/rp2040_pll.c
new file mode 100644
index 0000000000..6fe2be6608
--- /dev/null
+++ b/hw/misc/rp2040_pll.c
@@ -0,0 +1,234 @@
+/*
+ * RP2040 PLL emulation
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/core/qdev-clock.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/misc/rp2040_nyi.h"
+#include "hw/misc/rp2040_pll.h"
+#include "migration/vmstate.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+
+#define XOSC_HZ             12000000
+
+#define PLL_CS              0x00
+#define PLL_PWR             0x04
+#define PLL_FBDIV_INT       0x08
+#define PLL_PRIM            0x0c
+
+#define PLL_CS_LOCK         BIT(31)
+#define PLL_CS_BYPASS       BIT(8)
+#define PLL_CS_REFDIV_MASK  0x3f
+
+#define PLL_PWR_VCOPD       BIT(5)
+#define PLL_PWR_POSTDIVPD   BIT(3)
+#define PLL_PWR_DSMPD       BIT(2)
+#define PLL_PWR_PD          BIT(0)
+#define PLL_PWR_MASK        (PLL_PWR_VCOPD | PLL_PWR_POSTDIVPD | \
+                             PLL_PWR_DSMPD | PLL_PWR_PD)
+
+#define PLL_FBDIV_MASK      0x00000fff
+#define PLL_PRIM_MASK       0x00077000
+
+#define ATOMIC_ALIAS_MASK   0x3000
+#define ATOMIC_XOR          0x1000
+#define ATOMIC_SET          0x2000
+#define ATOMIC_CLR          0x3000
+
+static uint32_t rp2040_pll_apply_alias(uint32_t old, uint32_t value,
+                                       hwaddr alias)
+{
+    switch (alias) {
+    case ATOMIC_XOR:
+        return old ^ value;
+    case ATOMIC_SET:
+        return old | value;
+    case ATOMIC_CLR:
+        return old & ~value;
+    default:
+        return value;
+    }
+}
+
+static bool rp2040_pll_locked(RP2040PllState *s)
+{
+    return !(s->pwr & (PLL_PWR_PD | PLL_PWR_VCOPD));
+}
+
+static unsigned rp2040_pll_output_hz(RP2040PllState *s)
+{
+    uint32_t refdiv = s->cs & PLL_CS_REFDIV_MASK;
+    uint32_t fbdiv = s->fbdiv_int & PLL_FBDIV_MASK;
+    uint32_t postdiv1 = extract32(s->prim, 16, 3);
+    uint32_t postdiv2 = extract32(s->prim, 12, 3);
+    uint64_t hz;
+
+    if (!rp2040_pll_locked(s) || (s->pwr & PLL_PWR_POSTDIVPD)) {
+        return 0;
+    }
+
+    refdiv = refdiv ? refdiv : 1;
+    if (s->cs & PLL_CS_BYPASS) {
+        return XOSC_HZ / refdiv;
+    }
+
+    if (!fbdiv || !postdiv1 || !postdiv2) {
+        return s->fallback_hz;
+    }
+
+    hz = XOSC_HZ;
+    hz = hz * fbdiv / refdiv / postdiv1 / postdiv2;
+    return hz;
+}
+
+static void rp2040_pll_update_clock(RP2040PllState *s)
+{
+    clock_update_hz(s->clk, rp2040_pll_output_hz(s));
+}
+
+static uint64_t rp2040_pll_read(void *opaque, hwaddr addr, unsigned size)
+{
+    RP2040PllState *s = opaque;
+    hwaddr offset = addr & 0xfff;
+    const char *name = s->trace_name ? s->trace_name : "rp2040.pll";
+    uint64_t value;
+
+    switch (offset) {
+    case PLL_CS:
+        value = s->cs & ~PLL_CS_LOCK;
+        if (rp2040_pll_locked(s)) {
+            value |= PLL_CS_LOCK;
+        }
+        break;
+    case PLL_PWR:
+        value = s->pwr;
+        break;
+    case PLL_FBDIV_INT:
+        value = s->fbdiv_int;
+        break;
+    case PLL_PRIM:
+        value = s->prim;
+        break;
+    default:
+        value = 0;
+        rp2040_log_unimplemented_read(name, size, s->base + addr, offset,
+                                      value);
+        break;
+    }
+
+    return value;
+}
+
+static void rp2040_pll_write(void *opaque, hwaddr addr,
+                             uint64_t value64, unsigned size)
+{
+    RP2040PllState *s = opaque;
+    hwaddr alias = addr & ATOMIC_ALIAS_MASK;
+    hwaddr offset = addr & 0xfff;
+    const char *name = s->trace_name ? s->trace_name : "rp2040.pll";
+    uint32_t value = value64;
+
+    switch (offset) {
+    case PLL_CS:
+        s->cs = rp2040_pll_apply_alias(s->cs, value, alias) &
+                (PLL_CS_BYPASS | PLL_CS_REFDIV_MASK);
+        break;
+    case PLL_PWR:
+        s->pwr = rp2040_pll_apply_alias(s->pwr, value, alias) & PLL_PWR_MASK;
+        break;
+    case PLL_FBDIV_INT:
+        s->fbdiv_int = rp2040_pll_apply_alias(s->fbdiv_int, value, alias) &
+                       PLL_FBDIV_MASK;
+        break;
+    case PLL_PRIM:
+        s->prim = rp2040_pll_apply_alias(s->prim, value, alias) &
+                  PLL_PRIM_MASK;
+        break;
+    default:
+        rp2040_log_unimplemented_write(name, size, s->base + addr, offset,
+                                       value64);
+        break;
+    }
+
+    rp2040_pll_update_clock(s);
+}
+
+static const MemoryRegionOps rp2040_pll_ops = {
+    .read = rp2040_pll_read,
+    .write = rp2040_pll_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+static void rp2040_pll_reset(DeviceState *dev)
+{
+    RP2040PllState *s = RP2040_PLL(dev);
+
+    s->cs = 1;
+    s->pwr = PLL_PWR_MASK;
+    s->fbdiv_int = 0;
+    s->prim = (7 << 16) | (7 << 12);
+
+    rp2040_pll_update_clock(s);
+}
+
+static void rp2040_pll_init(Object *obj)
+{
+    RP2040PllState *s = RP2040_PLL(obj);
+    DeviceState *dev = DEVICE(obj);
+
+    s->clk = qdev_init_clock_out(dev, "clk");
+    memory_region_init_io(&s->iomem, obj, &rp2040_pll_ops, s,
+                          "rp2040.pll", RP2040_PLL_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->iomem);
+}
+
+static const VMStateDescription rp2040_pll_vmstate = {
+    .name = TYPE_RP2040_PLL,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32(cs, RP2040PllState),
+        VMSTATE_UINT32(pwr, RP2040PllState),
+        VMSTATE_UINT32(fbdiv_int, RP2040PllState),
+        VMSTATE_UINT32(prim, RP2040PllState),
+        VMSTATE_CLOCK(clk, RP2040PllState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const Property rp2040_pll_properties[] = {
+    DEFINE_PROP_STRING("trace-name", RP2040PllState, trace_name),
+    DEFINE_PROP_UINT32("base", RP2040PllState, base, 0),
+    DEFINE_PROP_UINT32("fallback-hz", RP2040PllState, fallback_hz, 0),
+};
+
+static void rp2040_pll_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    device_class_set_legacy_reset(dc, rp2040_pll_reset);
+    device_class_set_props(dc, rp2040_pll_properties);
+    dc->vmsd = &rp2040_pll_vmstate;
+}
+
+static const TypeInfo rp2040_pll_info = {
+    .name          = TYPE_RP2040_PLL,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(RP2040PllState),
+    .instance_init = rp2040_pll_init,
+    .class_init    = rp2040_pll_class_init,
+};
+
+static void rp2040_pll_register_types(void)
+{
+    type_register_static(&rp2040_pll_info);
+}
+type_init(rp2040_pll_register_types)
diff --git a/hw/misc/rp2040_psm.c b/hw/misc/rp2040_psm.c
new file mode 100644
index 0000000000..90b0264d81
--- /dev/null
+++ b/hw/misc/rp2040_psm.c
@@ -0,0 +1,198 @@
+/*
+ * RP2040 power-on state machine emulation
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/misc/rp2040_nyi.h"
+#include "hw/misc/rp2040_psm.h"
+#include "migration/vmstate.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+
+#define PSM_FRCE_ON   0x00
+#define PSM_FRCE_OFF  0x04
+#define PSM_WDSEL     0x08
+#define PSM_DONE      0x0c
+
+#define ATOMIC_ALIAS_MASK 0x3000
+#define ATOMIC_XOR        0x1000
+#define ATOMIC_SET        0x2000
+#define ATOMIC_CLR        0x3000
+
+static uint32_t rp2040_psm_apply_alias(uint32_t old, uint32_t value,
+                                       hwaddr alias)
+{
+    switch (alias) {
+    case ATOMIC_XOR:
+        return old ^ value;
+    case ATOMIC_SET:
+        return old | value;
+    case ATOMIC_CLR:
+        return old & ~value;
+    default:
+        return value;
+    }
+}
+
+static void rp2040_psm_update(RP2040PsmState *s)
+{
+    if (s->update) {
+        s->update(s->update_opaque);
+    }
+}
+
+void rp2040_psm_set_update_callback(RP2040PsmState *s,
+                                    RP2040PsmUpdateFn update,
+                                    void *opaque)
+{
+    s->update = update;
+    s->update_opaque = opaque;
+}
+
+uint32_t rp2040_psm_get_frce_off(RP2040PsmState *s)
+{
+    return s->frce_off;
+}
+
+static uint32_t rp2040_psm_done(RP2040PsmState *s)
+{
+    return RP2040_PSM_VALID_MASK & ~s->frce_off;
+}
+
+static uint64_t rp2040_psm_read(void *opaque, hwaddr addr, unsigned size)
+{
+    RP2040PsmState *s = opaque;
+    hwaddr offset = addr & 0xfff;
+    uint64_t value;
+
+    switch (offset) {
+    case PSM_FRCE_ON:
+        value = s->frce_on;
+        break;
+    case PSM_FRCE_OFF:
+        value = s->frce_off;
+        break;
+    case PSM_WDSEL:
+        value = s->wdsel;
+        break;
+    case PSM_DONE:
+        value = rp2040_psm_done(s);
+        break;
+    default:
+        value = 0;
+        rp2040_log_unimplemented_read("psm", size,
+                                      RP2040_PSM_BASE + addr, offset, value);
+        break;
+    }
+
+    return value;
+}
+
+static void rp2040_psm_write(void *opaque, hwaddr addr,
+                             uint64_t value64, unsigned size)
+{
+    RP2040PsmState *s = opaque;
+    hwaddr alias = addr & ATOMIC_ALIAS_MASK;
+    hwaddr offset = addr & 0xfff;
+    uint32_t value = value64;
+    uint32_t old_frce_off = s->frce_off;
+
+    switch (offset) {
+    case PSM_FRCE_ON:
+        s->frce_on = rp2040_psm_apply_alias(s->frce_on, value, alias) &
+                     RP2040_PSM_VALID_MASK;
+        break;
+    case PSM_FRCE_OFF:
+        s->frce_off = rp2040_psm_apply_alias(s->frce_off, value, alias) &
+                      RP2040_PSM_VALID_MASK;
+        if (s->frce_off != old_frce_off) {
+            rp2040_psm_update(s);
+        }
+        break;
+    case PSM_WDSEL:
+        s->wdsel = rp2040_psm_apply_alias(s->wdsel, value, alias) &
+                   RP2040_PSM_VALID_MASK;
+        break;
+    case PSM_DONE:
+        break;
+    default:
+        rp2040_log_unimplemented_write("psm", size,
+                                       RP2040_PSM_BASE + addr, offset,
+                                       value64);
+        break;
+    }
+}
+
+static const MemoryRegionOps rp2040_psm_ops = {
+    .read = rp2040_psm_read,
+    .write = rp2040_psm_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+static void rp2040_psm_reset(DeviceState *dev)
+{
+    RP2040PsmState *s = RP2040_PSM(dev);
+
+    s->frce_on = 0;
+    s->frce_off = 0;
+    s->wdsel = 0;
+    rp2040_psm_update(s);
+}
+
+static int rp2040_psm_post_load(void *opaque, int version_id)
+{
+    RP2040PsmState *s = opaque;
+
+    rp2040_psm_update(s);
+    return 0;
+}
+
+static void rp2040_psm_init(Object *obj)
+{
+    RP2040PsmState *s = RP2040_PSM(obj);
+
+    memory_region_init_io(&s->iomem, obj, &rp2040_psm_ops, s,
+                          "rp2040.psm", RP2040_PSM_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->iomem);
+}
+
+static const VMStateDescription rp2040_psm_vmstate = {
+    .name = TYPE_RP2040_PSM,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .post_load = rp2040_psm_post_load,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32(frce_on, RP2040PsmState),
+        VMSTATE_UINT32(frce_off, RP2040PsmState),
+        VMSTATE_UINT32(wdsel, RP2040PsmState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void rp2040_psm_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    device_class_set_legacy_reset(dc, rp2040_psm_reset);
+    dc->vmsd = &rp2040_psm_vmstate;
+}
+
+static const TypeInfo rp2040_psm_info = {
+    .name          = TYPE_RP2040_PSM,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(RP2040PsmState),
+    .instance_init = rp2040_psm_init,
+    .class_init    = rp2040_psm_class_init,
+};
+
+static void rp2040_psm_register_types(void)
+{
+    type_register_static(&rp2040_psm_info);
+}
+type_init(rp2040_psm_register_types)
diff --git a/hw/misc/rp2040_resets.c b/hw/misc/rp2040_resets.c
new file mode 100644
index 0000000000..227ecf64fd
--- /dev/null
+++ b/hw/misc/rp2040_resets.c
@@ -0,0 +1,152 @@
+/*
+ * RP2040 reset controller emulation
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/misc/rp2040_nyi.h"
+#include "hw/misc/rp2040_resets.h"
+#include "migration/vmstate.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+
+#define RESETS_RESET       0x00
+#define RESETS_WDSEL       0x04
+#define RESETS_RESET_DONE  0x08
+
+#define RESETS_VALID_MASK  0x01ffffff
+
+#define ATOMIC_ALIAS_MASK  0x3000
+#define ATOMIC_XOR         0x1000
+#define ATOMIC_SET         0x2000
+#define ATOMIC_CLR         0x3000
+
+static uint32_t rp2040_resets_apply_alias(uint32_t old, uint32_t value,
+                                          hwaddr alias)
+{
+    switch (alias) {
+    case ATOMIC_XOR:
+        return old ^ value;
+    case ATOMIC_SET:
+        return old | value;
+    case ATOMIC_CLR:
+        return old & ~value;
+    default:
+        return value;
+    }
+}
+
+static uint64_t rp2040_resets_read(void *opaque, hwaddr addr, unsigned size)
+{
+    RP2040ResetsState *s = opaque;
+    hwaddr offset = addr & 0xfff;
+    uint64_t value;
+
+    switch (offset) {
+    case RESETS_RESET:
+        value = s->reset;
+        break;
+    case RESETS_WDSEL:
+        value = s->wdsel;
+        break;
+    case RESETS_RESET_DONE:
+        value = (~s->reset) & RESETS_VALID_MASK;
+        break;
+    default:
+        value = 0;
+        rp2040_log_unimplemented_read("resets", size,
+                                      RP2040_RESETS_BASE + addr, offset,
+                                      value);
+        break;
+    }
+
+    return value;
+}
+
+static void rp2040_resets_write(void *opaque, hwaddr addr,
+                                uint64_t value64, unsigned size)
+{
+    RP2040ResetsState *s = opaque;
+    hwaddr alias = addr & ATOMIC_ALIAS_MASK;
+    hwaddr offset = addr & 0xfff;
+    uint32_t value = value64;
+
+    switch (offset) {
+    case RESETS_RESET:
+        s->reset = rp2040_resets_apply_alias(s->reset, value, alias) &
+                   RESETS_VALID_MASK;
+        break;
+    case RESETS_WDSEL:
+        s->wdsel = rp2040_resets_apply_alias(s->wdsel, value, alias) &
+                   RESETS_VALID_MASK;
+        break;
+    case RESETS_RESET_DONE:
+        break;
+    default:
+        rp2040_log_unimplemented_write("resets", size,
+                                       RP2040_RESETS_BASE + addr, offset,
+                                       value64);
+        break;
+    }
+}
+
+static const MemoryRegionOps rp2040_resets_ops = {
+    .read = rp2040_resets_read,
+    .write = rp2040_resets_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+static void rp2040_resets_reset(DeviceState *dev)
+{
+    RP2040ResetsState *s = RP2040_RESETS(dev);
+
+    s->reset = RESETS_VALID_MASK;
+    s->wdsel = 0;
+}
+
+static void rp2040_resets_init(Object *obj)
+{
+    RP2040ResetsState *s = RP2040_RESETS(obj);
+
+    memory_region_init_io(&s->iomem, obj, &rp2040_resets_ops, s,
+                          "rp2040.resets", RP2040_RESETS_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->iomem);
+}
+
+static const VMStateDescription rp2040_resets_vmstate = {
+    .name = TYPE_RP2040_RESETS,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32(reset, RP2040ResetsState),
+        VMSTATE_UINT32(wdsel, RP2040ResetsState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void rp2040_resets_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    device_class_set_legacy_reset(dc, rp2040_resets_reset);
+    dc->vmsd = &rp2040_resets_vmstate;
+}
+
+static const TypeInfo rp2040_resets_info = {
+    .name          = TYPE_RP2040_RESETS,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(RP2040ResetsState),
+    .instance_init = rp2040_resets_init,
+    .class_init    = rp2040_resets_class_init,
+};
+
+static void rp2040_resets_register_types(void)
+{
+    type_register_static(&rp2040_resets_info);
+}
+type_init(rp2040_resets_register_types)
diff --git a/hw/misc/rp2040_rosc.c b/hw/misc/rp2040_rosc.c
new file mode 100644
index 0000000000..dcb340ec57
--- /dev/null
+++ b/hw/misc/rp2040_rosc.c
@@ -0,0 +1,430 @@
+/*
+ * RP2040 ring oscillator emulation
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/core/qdev-clock.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/misc/rp2040_nyi.h"
+#include "hw/misc/rp2040_rosc.h"
+#include "migration/vmstate.h"
+#include "qemu/guest-random.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "qemu/timer.h"
+
+#define ROSC_NOMINAL_HZ        6500000
+
+#define ROSC_CTRL              0x00
+#define ROSC_FREQA             0x04
+#define ROSC_FREQB             0x08
+#define ROSC_DORMANT           0x0c
+#define ROSC_DIV               0x10
+#define ROSC_PHASE             0x14
+#define ROSC_STATUS            0x18
+#define ROSC_RANDOMBIT         0x1c
+#define ROSC_COUNT             0x20
+
+#define ROSC_ENABLE_DISABLE    0xd1e
+#define ROSC_ENABLE_ENABLE     0xfab
+#define ROSC_FREQ_RANGE_LOW    0xfa4
+#define ROSC_FREQ_RANGE_MEDIUM 0xfa5
+#define ROSC_FREQ_RANGE_HIGH   0xfa7
+#define ROSC_FREQ_RANGE_TOOHIGH 0xfa6
+#define ROSC_DORMANT_VALUE     0x636f6d61
+#define ROSC_WAKE_VALUE        0x77616b65
+#define ROSC_FREQ_PASSWD       0x9696
+#define ROSC_DIV_PASS          0xaa0
+#define ROSC_PHASE_PASSWD      0xaa
+
+#define ROSC_STATUS_STABLE     BIT(31)
+#define ROSC_STATUS_BADWRITE   BIT(24)
+#define ROSC_STATUS_DIV_RUNNING BIT(16)
+#define ROSC_STATUS_ENABLED    BIT(12)
+
+#define ATOMIC_ALIAS_MASK      0x3000
+#define ATOMIC_XOR             0x1000
+#define ATOMIC_SET             0x2000
+#define ATOMIC_CLR             0x3000
+
+static uint32_t rp2040_rosc_apply_alias(uint32_t old, uint32_t value,
+                                        hwaddr alias)
+{
+    switch (alias) {
+    case ATOMIC_XOR:
+        return old ^ value;
+    case ATOMIC_SET:
+        return old | value;
+    case ATOMIC_CLR:
+        return old & ~value;
+    default:
+        return value;
+    }
+}
+
+static bool rp2040_rosc_valid_range(uint32_t range)
+{
+    return range == ROSC_FREQ_RANGE_LOW || range == ROSC_FREQ_RANGE_MEDIUM ||
+           range == ROSC_FREQ_RANGE_HIGH || range == ROSC_FREQ_RANGE_TOOHIGH;
+}
+
+static bool rp2040_rosc_enabled(RP2040RoscState *s)
+{
+    return extract32(s->ctrl, 12, 12) != ROSC_ENABLE_DISABLE;
+}
+
+static bool rp2040_rosc_running(RP2040RoscState *s)
+{
+    return rp2040_rosc_enabled(s) && s->dormant == ROSC_WAKE_VALUE;
+}
+
+static uint32_t rp2040_rosc_divisor(RP2040RoscState *s)
+{
+    uint32_t encoded = s->div & 0xfff;
+    uint32_t div;
+
+    if (encoded < ROSC_DIV_PASS) {
+        return 31;
+    }
+
+    div = encoded - ROSC_DIV_PASS;
+    if (div == 0) {
+        return 32;
+    }
+    if (div > 31) {
+        return 31;
+    }
+    return div;
+}
+
+static uint32_t rp2040_rosc_hz(RP2040RoscState *s)
+{
+    if (!rp2040_rosc_running(s)) {
+        return 0;
+    }
+
+    return ROSC_NOMINAL_HZ / rp2040_rosc_divisor(s);
+}
+
+static void rp2040_rosc_update_clock(RP2040RoscState *s)
+{
+    clock_update_hz(s->clk, rp2040_rosc_hz(s));
+}
+
+static uint32_t rp2040_rosc_count_read(RP2040RoscState *s)
+{
+    uint64_t elapsed_ns;
+    uint64_t elapsed_ticks;
+
+    if (!s->count || !rp2040_rosc_running(s)) {
+        return s->count;
+    }
+
+    elapsed_ns = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) - s->count_start_ns;
+    elapsed_ticks = elapsed_ns * ROSC_NOMINAL_HZ / NANOSECONDS_PER_SECOND;
+    if (elapsed_ticks >= s->count) {
+        s->count = 0;
+    } else {
+        s->count -= elapsed_ticks;
+        s->count_start_ns = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    }
+
+    return s->count;
+}
+
+static uint32_t rp2040_rosc_status(RP2040RoscState *s)
+{
+    uint32_t value = 0;
+
+    if (rp2040_rosc_enabled(s)) {
+        value |= ROSC_STATUS_ENABLED;
+        if (s->dormant == ROSC_WAKE_VALUE) {
+            value |= ROSC_STATUS_STABLE | ROSC_STATUS_DIV_RUNNING;
+        }
+    }
+    if (s->badwrite) {
+        value |= ROSC_STATUS_BADWRITE;
+    }
+
+    return value;
+}
+
+static uint32_t rp2040_rosc_random_bit(RP2040RoscState *s)
+{
+    uint64_t x;
+    uint32_t bit;
+
+    if (!rp2040_rosc_running(s)) {
+        return 0;
+    }
+
+    if (!s->random_seed_set) {
+        if (!s->random_pool_bits) {
+            qemu_guest_getrandom_nofail(&s->random_pool,
+                                        sizeof(s->random_pool));
+            s->random_pool_bits = 64;
+        }
+
+        bit = s->random_pool & 1;
+        s->random_pool >>= 1;
+        s->random_pool_bits--;
+        return bit;
+    }
+
+    x = s->random_prng_state;
+    x ^= x >> 12;
+    x ^= x << 25;
+    x ^= x >> 27;
+    s->random_prng_state = x;
+    return (x * 0x2545f4914f6cdd1dull) >> 63;
+}
+
+static uint64_t rp2040_rosc_read(void *opaque, hwaddr addr, unsigned size)
+{
+    RP2040RoscState *s = opaque;
+    hwaddr offset = addr & 0xfff;
+    uint64_t value;
+
+    switch (offset) {
+    case ROSC_CTRL:
+        value = s->ctrl;
+        break;
+    case ROSC_FREQA:
+        value = s->freqa;
+        break;
+    case ROSC_FREQB:
+        value = s->freqb;
+        break;
+    case ROSC_DORMANT:
+        value = s->dormant;
+        break;
+    case ROSC_DIV:
+        value = s->div;
+        break;
+    case ROSC_PHASE:
+        value = s->phase;
+        break;
+    case ROSC_STATUS:
+        value = rp2040_rosc_status(s);
+        break;
+    case ROSC_RANDOMBIT:
+        value = rp2040_rosc_random_bit(s);
+        break;
+    case ROSC_COUNT:
+        value = rp2040_rosc_count_read(s);
+        break;
+    default:
+        value = 0;
+        rp2040_log_unimplemented_read("rosc", size,
+                                      RP2040_ROSC_BASE + addr, offset,
+                                      value);
+        break;
+    }
+
+    return value;
+}
+
+static void rp2040_rosc_write_ctrl(RP2040RoscState *s, uint32_t value)
+{
+    uint32_t enable = extract32(value, 12, 12);
+    uint32_t range = extract32(value, 0, 12);
+
+    if (enable != ROSC_ENABLE_DISABLE && enable != ROSC_ENABLE_ENABLE) {
+        s->badwrite = true;
+        value = deposit32(value, 12, 12, ROSC_ENABLE_ENABLE);
+    }
+    if (!rp2040_rosc_valid_range(range)) {
+        s->badwrite = true;
+        value = deposit32(value, 0, 12, ROSC_FREQ_RANGE_LOW);
+    }
+
+    s->ctrl = value & 0x00ffffff;
+    rp2040_rosc_update_clock(s);
+}
+
+static void rp2040_rosc_write_freq(RP2040RoscState *s, uint32_t *reg,
+                                   uint32_t value)
+{
+    if (extract32(value, 16, 16) != ROSC_FREQ_PASSWD) {
+        s->badwrite = true;
+        *reg = 0;
+        return;
+    }
+
+    *reg = value & 0x96967777;
+}
+
+static void rp2040_rosc_write_div(RP2040RoscState *s, uint32_t value)
+{
+    if ((value & 0xfff) < ROSC_DIV_PASS) {
+        s->badwrite = true;
+        value = ROSC_DIV_PASS + 31;
+    }
+
+    s->div = value & 0xfff;
+    rp2040_rosc_update_clock(s);
+}
+
+static void rp2040_rosc_write_phase(RP2040RoscState *s, uint32_t value)
+{
+    if (extract32(value, 4, 8) != ROSC_PHASE_PASSWD) {
+        s->badwrite = true;
+        value = 0;
+    }
+
+    s->phase = value & 0x00000fff;
+}
+
+static void rp2040_rosc_write(void *opaque, hwaddr addr,
+                              uint64_t value64, unsigned size)
+{
+    RP2040RoscState *s = opaque;
+    hwaddr alias = addr & ATOMIC_ALIAS_MASK;
+    hwaddr offset = addr & 0xfff;
+    uint32_t value = value64;
+
+    switch (offset) {
+    case ROSC_CTRL:
+        rp2040_rosc_write_ctrl(s, rp2040_rosc_apply_alias(s->ctrl, value,
+                                                          alias));
+        break;
+    case ROSC_FREQA:
+        rp2040_rosc_write_freq(s, &s->freqa,
+                               rp2040_rosc_apply_alias(s->freqa, value,
+                                                       alias));
+        break;
+    case ROSC_FREQB:
+        rp2040_rosc_write_freq(s, &s->freqb,
+                               rp2040_rosc_apply_alias(s->freqb, value,
+                                                       alias));
+        break;
+    case ROSC_DORMANT:
+        s->dormant = value == ROSC_DORMANT_VALUE ? value : ROSC_WAKE_VALUE;
+        if (value != ROSC_DORMANT_VALUE && value != ROSC_WAKE_VALUE) {
+            s->badwrite = true;
+        }
+        rp2040_rosc_update_clock(s);
+        break;
+    case ROSC_DIV:
+        rp2040_rosc_write_div(s, rp2040_rosc_apply_alias(s->div, value,
+                                                         alias));
+        break;
+    case ROSC_PHASE:
+        rp2040_rosc_write_phase(s, rp2040_rosc_apply_alias(s->phase, value,
+                                                           alias));
+        break;
+    case ROSC_STATUS:
+        if (value & ROSC_STATUS_BADWRITE) {
+            s->badwrite = false;
+        }
+        break;
+    case ROSC_COUNT:
+        s->count = value & 0xff;
+        s->count_start_ns = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+        break;
+    default:
+        rp2040_log_unimplemented_write("rosc", size,
+                                       RP2040_ROSC_BASE + addr, offset,
+                                       value64);
+        break;
+    }
+}
+
+static const MemoryRegionOps rp2040_rosc_ops = {
+    .read = rp2040_rosc_read,
+    .write = rp2040_rosc_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+static void rp2040_rosc_reset(DeviceState *dev)
+{
+    RP2040RoscState *s = RP2040_ROSC(dev);
+
+    s->ctrl = (ROSC_ENABLE_ENABLE << 12) | ROSC_FREQ_RANGE_LOW;
+    s->freqa = 0;
+    s->freqb = 0;
+    s->dormant = ROSC_WAKE_VALUE;
+    s->div = ROSC_DIV_PASS + 16;
+    s->phase = 0x00000aa8;
+    s->count = 0;
+    s->count_start_ns = 0;
+    s->random_pool = 0;
+    s->random_pool_bits = 0;
+    s->random_prng_state = s->random_seed;
+    if (!s->random_prng_state) {
+        s->random_prng_state = 0x9e3779b97f4a7c15ull;
+    }
+    s->badwrite = false;
+
+    rp2040_rosc_update_clock(s);
+}
+
+static void rp2040_rosc_init(Object *obj)
+{
+    RP2040RoscState *s = RP2040_ROSC(obj);
+    DeviceState *dev = DEVICE(obj);
+
+    s->clk = qdev_init_clock_out(dev, "clk");
+    memory_region_init_io(&s->iomem, obj, &rp2040_rosc_ops, s,
+                          "rp2040.rosc", RP2040_ROSC_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->iomem);
+}
+
+static const VMStateDescription rp2040_rosc_vmstate = {
+    .name = TYPE_RP2040_ROSC,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32(ctrl, RP2040RoscState),
+        VMSTATE_UINT32(freqa, RP2040RoscState),
+        VMSTATE_UINT32(freqb, RP2040RoscState),
+        VMSTATE_UINT32(dormant, RP2040RoscState),
+        VMSTATE_UINT32(div, RP2040RoscState),
+        VMSTATE_UINT32(phase, RP2040RoscState),
+        VMSTATE_UINT32(count, RP2040RoscState),
+        VMSTATE_INT64(count_start_ns, RP2040RoscState),
+        VMSTATE_UINT64(random_pool, RP2040RoscState),
+        VMSTATE_UINT64(random_prng_state, RP2040RoscState),
+        VMSTATE_UINT64(random_seed, RP2040RoscState),
+        VMSTATE_UINT8(random_pool_bits, RP2040RoscState),
+        VMSTATE_BOOL(random_seed_set, RP2040RoscState),
+        VMSTATE_BOOL(badwrite, RP2040RoscState),
+        VMSTATE_CLOCK(clk, RP2040RoscState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const Property rp2040_rosc_properties[] = {
+    DEFINE_PROP_UINT64("random-seed", RP2040RoscState, random_seed, 0),
+    DEFINE_PROP_BOOL("random-seed-set", RP2040RoscState, random_seed_set,
+                     false),
+};
+
+static void rp2040_rosc_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    device_class_set_legacy_reset(dc, rp2040_rosc_reset);
+    dc->vmsd = &rp2040_rosc_vmstate;
+    device_class_set_props(dc, rp2040_rosc_properties);
+}
+
+static const TypeInfo rp2040_rosc_info = {
+    .name          = TYPE_RP2040_ROSC,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(RP2040RoscState),
+    .instance_init = rp2040_rosc_init,
+    .class_init    = rp2040_rosc_class_init,
+};
+
+static void rp2040_rosc_register_types(void)
+{
+    type_register_static(&rp2040_rosc_info);
+}
+type_init(rp2040_rosc_register_types)
diff --git a/hw/misc/rp2040_sio.c b/hw/misc/rp2040_sio.c
new file mode 100644
index 0000000000..1a04c426a7
--- /dev/null
+++ b/hw/misc/rp2040_sio.c
@@ -0,0 +1,905 @@
+/*
+ * RP2040 single-cycle IO block emulation
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/misc/rp2040_nyi.h"
+#include "hw/misc/rp2040_sio.h"
+#include "hw/core/cpu.h"
+#include "hw/core/qdev-properties.h"
+#include "migration/vmstate.h"
+#include "qemu/bitops.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+
+#define SIO_CPUID               0x000
+#define SIO_GPIO_IN             0x004
+#define SIO_GPIO_HI_IN          0x008
+#define SIO_GPIO_OUT            0x010
+#define SIO_GPIO_OUT_SET        0x014
+#define SIO_GPIO_OUT_CLR        0x018
+#define SIO_GPIO_OUT_XOR        0x01c
+#define SIO_GPIO_OE             0x020
+#define SIO_GPIO_OE_SET         0x024
+#define SIO_GPIO_OE_CLR         0x028
+#define SIO_GPIO_OE_XOR         0x02c
+#define SIO_GPIO_HI_OUT         0x030
+#define SIO_GPIO_HI_OUT_SET     0x034
+#define SIO_GPIO_HI_OUT_CLR     0x038
+#define SIO_GPIO_HI_OUT_XOR     0x03c
+#define SIO_GPIO_HI_OE          0x040
+#define SIO_GPIO_HI_OE_SET      0x044
+#define SIO_GPIO_HI_OE_CLR      0x048
+#define SIO_GPIO_HI_OE_XOR      0x04c
+#define SIO_FIFO_ST             0x050
+#define SIO_FIFO_WR             0x054
+#define SIO_FIFO_RD             0x058
+#define SIO_SPINLOCK_ST         0x05c
+#define SIO_DIV_UDIVIDEND       0x060
+#define SIO_DIV_UDIVISOR        0x064
+#define SIO_DIV_SDIVIDEND       0x068
+#define SIO_DIV_SDIVISOR        0x06c
+#define SIO_DIV_QUOTIENT        0x070
+#define SIO_DIV_REMAINDER       0x074
+#define SIO_DIV_CSR             0x078
+#define SIO_INTERP0_BASE        0x080
+#define SIO_INTERP1_BASE        0x0c0
+#define SIO_INTERP_BLOCK_SIZE   0x040
+#define SIO_INTERP_ACCUM0       0x00
+#define SIO_INTERP_ACCUM1       0x04
+#define SIO_INTERP_BASE0        0x08
+#define SIO_INTERP_BASE1        0x0c
+#define SIO_INTERP_BASE2        0x10
+#define SIO_INTERP_POP_LANE0    0x14
+#define SIO_INTERP_POP_LANE1    0x18
+#define SIO_INTERP_POP_FULL     0x1c
+#define SIO_INTERP_PEEK_LANE0   0x20
+#define SIO_INTERP_PEEK_LANE1   0x24
+#define SIO_INTERP_PEEK_FULL    0x28
+#define SIO_INTERP_CTRL_LANE0   0x2c
+#define SIO_INTERP_CTRL_LANE1   0x30
+#define SIO_INTERP_ACCUM0_ADD   0x34
+#define SIO_INTERP_ACCUM1_ADD   0x38
+#define SIO_INTERP_BASE_1AND0   0x3c
+#define SIO_SPINLOCK_BASE       0x100
+#define SIO_SPINLOCK_LAST       0x17c
+
+#define SIO_GPIO_MASK           0x3fffffff
+#define SIO_GPIO_HI_MASK        0x3f
+#define SIO_FIFO_ST_VLD         BIT(0)
+#define SIO_FIFO_ST_RDY         BIT(1)
+#define SIO_FIFO_ST_WC_MASK     (BIT(3) | BIT(2))
+#define SIO_DIV_CSR_READY       BIT(0)
+#define SIO_DIV_CSR_DIRTY       BIT(1)
+#define SIO_INTERP_CTRL_FORCE_MSB_SHIFT 19
+#define SIO_INTERP_CTRL_ADD_RAW         BIT(18)
+#define SIO_INTERP_CTRL_CROSS_RESULT    BIT(17)
+#define SIO_INTERP_CTRL_CROSS_INPUT     BIT(16)
+#define SIO_INTERP_CTRL_SIGNED          BIT(15)
+#define SIO_INTERP_CTRL_MASK_MSB_SHIFT  10
+#define SIO_INTERP_CTRL_MASK_LSB_SHIFT  5
+#define SIO_INTERP_CTRL_SHIFT_MASK      0x1f
+#define SIO_INTERP_CTRL_LSB_MASK        (0x1f << 5)
+#define SIO_INTERP_CTRL_MSB_MASK        (0x1f << 10)
+#define SIO_INTERP0_CTRL_BLEND          BIT(21)
+#define SIO_INTERP1_CTRL_CLAMP          BIT(22)
+#define SIO_INTERP_CTRL_OVERF           BIT(25)
+#define SIO_INTERP_CTRL_OVERF1          BIT(24)
+#define SIO_INTERP_CTRL_OVERF0          BIT(23)
+#define SIO_INTERP_CTRL_OVERF_MASK      (SIO_INTERP_CTRL_OVERF | \
+                                         SIO_INTERP_CTRL_OVERF1 | \
+                                         SIO_INTERP_CTRL_OVERF0)
+
+typedef struct RP2040SioInterpResult {
+    uint32_t raw[RP2040_SIO_INTERP_NUM_LANES];
+    uint32_t lane[RP2040_SIO_INTERP_NUM_LANES];
+    uint32_t full;
+} RP2040SioInterpResult;
+
+static unsigned rp2040_sio_current_core(void)
+{
+    /*
+     * current_cpu is QEMU's thread-local pointer to the currently executing
+     * guest vCPU, not a host CPU identifier.
+     */
+    if (current_cpu && current_cpu->cpu_index == 1) {
+        return 1;
+    }
+
+    return 0;
+}
+
+static void rp2040_sio_update_fifo_irq(RP2040SioState *s)
+{
+    int i;
+
+    for (i = 0; i < RP2040_SIO_NUM_CORES; i++) {
+        qemu_set_irq(s->fifo_irq[i], s->fifo_level[i] != 0);
+    }
+}
+
+static uint32_t rp2040_sio_fifo_status(RP2040SioState *s, unsigned core)
+{
+    unsigned peer = core ^ 1;
+    uint32_t value = s->fifo_sticky[core] & SIO_FIFO_ST_WC_MASK;
+
+    if (s->fifo_level[core] != 0) {
+        value |= SIO_FIFO_ST_VLD;
+    }
+    if (s->fifo_level[peer] < RP2040_SIO_FIFO_DEPTH) {
+        value |= SIO_FIFO_ST_RDY;
+    }
+
+    return value;
+}
+
+static void rp2040_sio_fifo_push(RP2040SioState *s, unsigned core,
+                                 uint32_t value)
+{
+    unsigned peer = core ^ 1;
+
+    if (s->fifo_level[peer] == RP2040_SIO_FIFO_DEPTH) {
+        s->fifo_sticky[core] |= BIT(2);
+        return;
+    }
+
+    s->fifo[peer][s->fifo_wptr[peer]] = value;
+    s->fifo_wptr[peer] = (s->fifo_wptr[peer] + 1) % RP2040_SIO_FIFO_DEPTH;
+    s->fifo_level[peer]++;
+    rp2040_sio_update_fifo_irq(s);
+}
+
+static uint32_t rp2040_sio_fifo_pop(RP2040SioState *s, unsigned core)
+{
+    uint32_t value;
+
+    if (s->fifo_level[core] == 0) {
+        s->fifo_sticky[core] |= BIT(3);
+        return 0;
+    }
+
+    value = s->fifo[core][s->fifo_rptr[core]];
+    s->fifo_rptr[core] = (s->fifo_rptr[core] + 1) % RP2040_SIO_FIFO_DEPTH;
+    s->fifo_level[core]--;
+    rp2040_sio_update_fifo_irq(s);
+
+    return value;
+}
+
+static bool rp2040_sio_spinlock_offset(hwaddr offset, unsigned *index)
+{
+    if (offset < SIO_SPINLOCK_BASE || offset > SIO_SPINLOCK_LAST ||
+        (offset & 0x3)) {
+        return false;
+    }
+
+    *index = (offset - SIO_SPINLOCK_BASE) / sizeof(uint32_t);
+    return *index < 32;
+}
+
+static int32_t rp2040_sio_sign32(uint32_t value)
+{
+    int32_t signed_value = (int32_t)value;
+
+    if (signed_value > 0) {
+        return 1;
+    }
+    if (signed_value < 0) {
+        return -1;
+    }
+    return 0;
+}
+
+static void rp2040_sio_divide(RP2040SioState *s, unsigned core,
+                              bool is_signed)
+{
+    uint32_t dividend = s->div_dividend[core];
+    uint32_t divisor = s->div_divisor[core];
+    uint32_t quotient;
+    uint32_t remainder;
+
+    if (is_signed) {
+        int32_t signed_dividend = (int32_t)dividend;
+        int32_t signed_divisor = (int32_t)divisor;
+
+        if (signed_divisor == 0) {
+            quotient = -rp2040_sio_sign32(dividend);
+            remainder = dividend;
+        } else if (signed_dividend == INT32_MIN && signed_divisor == -1) {
+            quotient = dividend;
+            remainder = 0;
+        } else {
+            quotient = signed_dividend / signed_divisor;
+            remainder = signed_dividend % signed_divisor;
+        }
+    } else if (divisor == 0) {
+        quotient = UINT32_MAX;
+        remainder = dividend;
+    } else {
+        quotient = dividend / divisor;
+        remainder = dividend % divisor;
+    }
+
+    s->div_quotient[core] = quotient;
+    s->div_remainder[core] = remainder;
+    s->div_dirty[core] = true;
+}
+
+static uint32_t rp2040_sio_div_csr(RP2040SioState *s, unsigned core)
+{
+    return SIO_DIV_CSR_READY |
+           (s->div_dirty[core] ? SIO_DIV_CSR_DIRTY : 0);
+}
+
+static unsigned rp2040_sio_interp_index(unsigned interp, unsigned lane)
+{
+    return interp * RP2040_SIO_INTERP_NUM_LANES + lane;
+}
+
+static unsigned rp2040_sio_interp_base_index(unsigned interp, unsigned base)
+{
+    return interp * RP2040_SIO_INTERP_NUM_BASES + base;
+}
+
+static uint32_t rp2040_sio_interp_ctrl_mask(unsigned interp, unsigned lane)
+{
+    uint32_t mask = SIO_INTERP_CTRL_SHIFT_MASK |
+                    SIO_INTERP_CTRL_LSB_MASK |
+                    SIO_INTERP_CTRL_MSB_MASK |
+                    SIO_INTERP_CTRL_SIGNED |
+                    SIO_INTERP_CTRL_CROSS_INPUT |
+                    SIO_INTERP_CTRL_CROSS_RESULT |
+                    SIO_INTERP_CTRL_ADD_RAW |
+                    (0x3 << SIO_INTERP_CTRL_FORCE_MSB_SHIFT);
+
+    if (interp == 0 && lane == 0) {
+        mask |= SIO_INTERP0_CTRL_BLEND;
+    } else if (interp == 1 && lane == 0) {
+        mask |= SIO_INTERP1_CTRL_CLAMP;
+    }
+
+    return mask;
+}
+
+static bool rp2040_sio_interp_offset(hwaddr addr, unsigned *interp,
+                                     hwaddr *reg)
+{
+    if (addr >= SIO_INTERP0_BASE &&
+        addr < SIO_INTERP0_BASE + SIO_INTERP_BLOCK_SIZE) {
+        *interp = 0;
+        *reg = addr - SIO_INTERP0_BASE;
+        return true;
+    }
+
+    if (addr >= SIO_INTERP1_BASE &&
+        addr < SIO_INTERP1_BASE + SIO_INTERP_BLOCK_SIZE) {
+        *interp = 1;
+        *reg = addr - SIO_INTERP1_BASE;
+        return true;
+    }
+
+    return false;
+}
+
+static uint32_t rp2040_sio_interp_mask(unsigned lsb, unsigned msb)
+{
+    if (msb < lsb) {
+        return 0;
+    }
+
+    if (msb == 31) {
+        return UINT32_MAX << lsb;
+    }
+
+    return (BIT(msb + 1) - 1) & ~(BIT(lsb) - 1);
+}
+
+static uint32_t rp2040_sio_interp_sign_extend(uint32_t value, unsigned msb)
+{
+    if (msb == 31 || !(value & BIT(msb))) {
+        return value;
+    }
+
+    return value | (UINT32_MAX << (msb + 1));
+}
+
+static uint32_t rp2040_sio_interp_raw(RP2040SioState *s, unsigned core,
+                                      unsigned interp, unsigned lane)
+{
+    uint32_t ctrl = s->interp_ctrl[core]
+                                  [rp2040_sio_interp_index(interp, lane)];
+    uint32_t input;
+    uint32_t shifted;
+    uint32_t value;
+    unsigned shift = ctrl & SIO_INTERP_CTRL_SHIFT_MASK;
+    unsigned lsb = (ctrl & SIO_INTERP_CTRL_LSB_MASK) >>
+                   SIO_INTERP_CTRL_MASK_LSB_SHIFT;
+    unsigned msb = (ctrl & SIO_INTERP_CTRL_MSB_MASK) >>
+                   SIO_INTERP_CTRL_MASK_MSB_SHIFT;
+
+    input = s->interp_accum[core][rp2040_sio_interp_index(
+                                  interp,
+                                  (ctrl & SIO_INTERP_CTRL_CROSS_INPUT) ?
+                                  (lane ^ 1) : lane)];
+    if (ctrl & SIO_INTERP_CTRL_ADD_RAW) {
+        return input;
+    }
+
+    shifted = input >> shift;
+    value = shifted & rp2040_sio_interp_mask(lsb, msb);
+    if (ctrl & SIO_INTERP_CTRL_SIGNED) {
+        value = rp2040_sio_interp_sign_extend(value, msb);
+    }
+
+    return value;
+}
+
+static uint32_t rp2040_sio_interp_force_msb(RP2040SioState *s, unsigned core,
+                                            unsigned interp, unsigned lane,
+                                            uint32_t value)
+{
+    uint32_t ctrl = s->interp_ctrl[core]
+                                  [rp2040_sio_interp_index(interp, lane)];
+    uint32_t force = (ctrl >> SIO_INTERP_CTRL_FORCE_MSB_SHIFT) & 0x3;
+
+    return value | (force << 28);
+}
+
+static uint32_t rp2040_sio_interp_blend_result(RP2040SioState *s,
+                                               unsigned core, uint32_t alpha)
+{
+    uint32_t ctrl1 = s->interp_ctrl[core][rp2040_sio_interp_index(0, 1)];
+    uint32_t base0 = s->interp_base[core][rp2040_sio_interp_base_index(0, 0)];
+    uint32_t base1 = s->interp_base[core][rp2040_sio_interp_base_index(0, 1)];
+    int64_t start;
+    int64_t end;
+
+    if (ctrl1 & SIO_INTERP_CTRL_SIGNED) {
+        start = (int16_t)base0;
+        end = (int16_t)base1;
+    } else {
+        start = (uint16_t)base0;
+        end = (uint16_t)base1;
+    }
+
+    return start + (((end - start) * (alpha & 0xff)) >> 8);
+}
+
+static void rp2040_sio_interp_compute(RP2040SioState *s, unsigned core,
+                                      unsigned interp,
+                                      RP2040SioInterpResult *result)
+{
+    bool blend = interp == 0 &&
+                 (s->interp_ctrl[core][rp2040_sio_interp_index(0, 0)] &
+                  SIO_INTERP0_CTRL_BLEND);
+    bool clamp = interp == 1 &&
+                 (s->interp_ctrl[core][rp2040_sio_interp_index(1, 0)] &
+                  SIO_INTERP1_CTRL_CLAMP);
+    uint32_t base0 = s->interp_base[core]
+                                   [rp2040_sio_interp_base_index(interp, 0)];
+    uint32_t base1 = s->interp_base[core]
+                                   [rp2040_sio_interp_base_index(interp, 1)];
+    uint32_t base2 = s->interp_base[core]
+                                   [rp2040_sio_interp_base_index(interp, 2)];
+
+    result->raw[0] = rp2040_sio_interp_raw(s, core, interp, 0);
+    result->raw[1] = rp2040_sio_interp_raw(s, core, interp, 1);
+    result->lane[0] = base0 + result->raw[0];
+    result->lane[1] = base1 + result->raw[1];
+    result->full = base2 + result->raw[0] + result->raw[1];
+
+    if (blend) {
+        uint32_t alpha = result->raw[1] & 0xff;
+
+        result->lane[0] = alpha;
+        result->lane[1] = rp2040_sio_interp_blend_result(s, core, alpha);
+        result->full = base2 + result->raw[0];
+    } else if (clamp) {
+        uint32_t ctrl0 = s->interp_ctrl[core][rp2040_sio_interp_index(1, 0)];
+
+        if (ctrl0 & SIO_INTERP_CTRL_SIGNED) {
+            int32_t value = result->raw[0];
+            int32_t lower = base0;
+            int32_t upper = base1;
+
+            result->lane[0] = value < lower ? lower :
+                              value > upper ? upper : value;
+        } else {
+            result->lane[0] = result->raw[0] < base0 ? base0 :
+                              result->raw[0] > base1 ? base1 :
+                              result->raw[0];
+        }
+    }
+}
+
+static uint32_t rp2040_sio_interp_pop(RP2040SioState *s, unsigned core,
+                                      unsigned interp, unsigned lane)
+{
+    RP2040SioInterpResult result;
+    uint32_t ctrl0 = s->interp_ctrl[core]
+                                   [rp2040_sio_interp_index(interp, 0)];
+    uint32_t ctrl1 = s->interp_ctrl[core]
+                                   [rp2040_sio_interp_index(interp, 1)];
+    uint32_t next0;
+    uint32_t next1;
+
+    rp2040_sio_interp_compute(s, core, interp, &result);
+    next0 = (ctrl0 & SIO_INTERP_CTRL_CROSS_RESULT) ?
+            result.lane[1] : result.lane[0];
+    next1 = (ctrl1 & SIO_INTERP_CTRL_CROSS_RESULT) ?
+            result.lane[0] : result.lane[1];
+
+    s->interp_accum[core][rp2040_sio_interp_index(interp, 0)] = next0;
+    s->interp_accum[core][rp2040_sio_interp_index(interp, 1)] = next1;
+
+    return lane < 2 ? rp2040_sio_interp_force_msb(s, core, interp, lane,
+                                                  result.lane[lane]) :
+                      result.full;
+}
+
+static uint32_t rp2040_sio_interp_overf(RP2040SioState *s, unsigned core,
+                                        unsigned interp, unsigned lane)
+{
+    uint32_t ctrl = s->interp_ctrl[core]
+                                  [rp2040_sio_interp_index(interp, lane)];
+    unsigned shift = ctrl & SIO_INTERP_CTRL_SHIFT_MASK;
+    unsigned lsb = (ctrl & SIO_INTERP_CTRL_LSB_MASK) >>
+                   SIO_INTERP_CTRL_MASK_LSB_SHIFT;
+    unsigned msb = (ctrl & SIO_INTERP_CTRL_MSB_MASK) >>
+                   SIO_INTERP_CTRL_MASK_MSB_SHIFT;
+    uint32_t input = s->interp_accum[core][rp2040_sio_interp_index(
+                                           interp,
+                                           (ctrl &
+                                            SIO_INTERP_CTRL_CROSS_INPUT) ?
+                                           (lane ^ 1) : lane)];
+    uint32_t shifted = input >> shift;
+
+    return (shifted & ~rp2040_sio_interp_mask(lsb, msb)) != 0;
+}
+
+static uint32_t rp2040_sio_interp_ctrl_read(RP2040SioState *s, unsigned core,
+                                            unsigned interp, unsigned lane)
+{
+    uint32_t ctrl = s->interp_ctrl[core]
+                                  [rp2040_sio_interp_index(interp, lane)];
+    bool overf0 = rp2040_sio_interp_overf(s, core, interp, 0);
+    bool overf1 = rp2040_sio_interp_overf(s, core, interp, 1);
+
+    ctrl &= ~SIO_INTERP_CTRL_OVERF_MASK;
+    if (overf0) {
+        ctrl |= SIO_INTERP_CTRL_OVERF0;
+    }
+    if (overf1) {
+        ctrl |= SIO_INTERP_CTRL_OVERF1;
+    }
+    if (overf0 || overf1) {
+        ctrl |= SIO_INTERP_CTRL_OVERF;
+    }
+
+    return ctrl;
+}
+
+static uint32_t rp2040_sio_interp_read(RP2040SioState *s, unsigned core,
+                                       unsigned interp, hwaddr reg)
+{
+    RP2040SioInterpResult result;
+
+    switch (reg) {
+    case SIO_INTERP_ACCUM0:
+    case SIO_INTERP_ACCUM1:
+        return s->interp_accum[core][rp2040_sio_interp_index(
+                                     interp, reg == SIO_INTERP_ACCUM1)];
+    case SIO_INTERP_BASE0:
+    case SIO_INTERP_BASE1:
+    case SIO_INTERP_BASE2:
+        return s->interp_base[core][rp2040_sio_interp_base_index(
+                                  interp, (reg - SIO_INTERP_BASE0) /
+                                          sizeof(uint32_t))];
+    case SIO_INTERP_POP_LANE0:
+        return rp2040_sio_interp_pop(s, core, interp, 0);
+    case SIO_INTERP_POP_LANE1:
+        return rp2040_sio_interp_pop(s, core, interp, 1);
+    case SIO_INTERP_POP_FULL:
+        return rp2040_sio_interp_pop(s, core, interp, 2);
+    case SIO_INTERP_PEEK_LANE0:
+    case SIO_INTERP_PEEK_LANE1:
+    case SIO_INTERP_PEEK_FULL:
+        rp2040_sio_interp_compute(s, core, interp, &result);
+        if (reg == SIO_INTERP_PEEK_LANE0) {
+            return rp2040_sio_interp_force_msb(s, core, interp, 0,
+                                               result.lane[0]);
+        }
+        if (reg == SIO_INTERP_PEEK_LANE1) {
+            return rp2040_sio_interp_force_msb(s, core, interp, 1,
+                                               result.lane[1]);
+        }
+        return result.full;
+    case SIO_INTERP_CTRL_LANE0:
+    case SIO_INTERP_CTRL_LANE1:
+        return rp2040_sio_interp_ctrl_read(s, core, interp,
+                                           reg == SIO_INTERP_CTRL_LANE1);
+    case SIO_INTERP_ACCUM0_ADD:
+    case SIO_INTERP_ACCUM1_ADD:
+        return rp2040_sio_interp_raw(s, core, interp,
+                                     reg == SIO_INTERP_ACCUM1_ADD);
+    case SIO_INTERP_BASE_1AND0:
+        return 0;
+    default:
+        return 0;
+    }
+}
+
+static void rp2040_sio_interp_write(RP2040SioState *s, unsigned core,
+                                    unsigned interp, hwaddr reg,
+                                    uint32_t value)
+{
+    unsigned lane;
+    unsigned base;
+    bool base01_signed;
+
+    switch (reg) {
+    case SIO_INTERP_ACCUM0:
+    case SIO_INTERP_ACCUM1:
+        lane = reg == SIO_INTERP_ACCUM1;
+        s->interp_accum[core][rp2040_sio_interp_index(interp, lane)] = value;
+        break;
+    case SIO_INTERP_BASE0:
+    case SIO_INTERP_BASE1:
+    case SIO_INTERP_BASE2:
+        base = (reg - SIO_INTERP_BASE0) / sizeof(uint32_t);
+        s->interp_base[core][rp2040_sio_interp_base_index(interp, base)] =
+            value;
+        break;
+    case SIO_INTERP_CTRL_LANE0:
+    case SIO_INTERP_CTRL_LANE1:
+        lane = reg == SIO_INTERP_CTRL_LANE1;
+        s->interp_ctrl[core][rp2040_sio_interp_index(interp, lane)] =
+            value & rp2040_sio_interp_ctrl_mask(interp, lane);
+        break;
+    case SIO_INTERP_ACCUM0_ADD:
+    case SIO_INTERP_ACCUM1_ADD:
+        lane = reg == SIO_INTERP_ACCUM1_ADD;
+        s->interp_accum[core][rp2040_sio_interp_index(interp, lane)] +=
+            value & 0x00ffffff;
+        break;
+    case SIO_INTERP_BASE_1AND0:
+        base01_signed = interp == 0 &&
+                        (s->interp_ctrl[core]
+                                       [rp2040_sio_interp_index(0, 0)] &
+                         SIO_INTERP0_CTRL_BLEND) ?
+                        (s->interp_ctrl[core]
+                                       [rp2040_sio_interp_index(0, 1)] &
+                         SIO_INTERP_CTRL_SIGNED) : false;
+
+        for (base = 0; base < 2; base++) {
+            uint16_t half = value >> (base * 16);
+            bool sign = base01_signed ||
+                        (s->interp_ctrl[core]
+                                       [rp2040_sio_interp_index(interp,
+                                                                base)] &
+                         SIO_INTERP_CTRL_SIGNED);
+
+            s->interp_base[core][rp2040_sio_interp_base_index(interp, base)] =
+                sign ? (uint32_t)(int16_t)half : half;
+        }
+        break;
+    default:
+        break;
+    }
+}
+
+static uint64_t rp2040_sio_read(void *opaque, hwaddr addr, unsigned size)
+{
+    RP2040SioState *s = opaque;
+    unsigned core = rp2040_sio_current_core();
+    unsigned interp;
+    unsigned index;
+    unsigned shift = (addr & 3) * 8;
+    hwaddr interp_reg;
+    hwaddr reg = addr & ~3ULL;
+    uint64_t value;
+
+    if (rp2040_sio_interp_offset(reg, &interp, &interp_reg)) {
+        value = rp2040_sio_interp_read(s, core, interp, interp_reg);
+        return extract64(value, shift, size * 8);
+    }
+
+    switch (reg) {
+    case SIO_CPUID:
+        value = core;
+        break;
+    case SIO_GPIO_IN:
+        value = s->gpio_in;
+        break;
+    case SIO_GPIO_HI_IN:
+        value = s->gpio_hi_in;
+        break;
+    case SIO_GPIO_OUT:
+        value = s->gpio_out;
+        break;
+    case SIO_GPIO_OE:
+        value = s->gpio_oe;
+        break;
+    case SIO_GPIO_HI_OUT:
+        value = s->gpio_hi_out;
+        break;
+    case SIO_GPIO_HI_OE:
+        value = s->gpio_hi_oe;
+        break;
+    case SIO_FIFO_ST:
+        value = rp2040_sio_fifo_status(s, core);
+        break;
+    case SIO_FIFO_RD:
+        value = rp2040_sio_fifo_pop(s, core);
+        break;
+    case SIO_SPINLOCK_ST:
+        value = s->spinlock_st;
+        break;
+    case SIO_DIV_UDIVIDEND:
+    case SIO_DIV_SDIVIDEND:
+        value = s->div_dividend[core];
+        break;
+    case SIO_DIV_UDIVISOR:
+    case SIO_DIV_SDIVISOR:
+        value = s->div_divisor[core];
+        break;
+    case SIO_DIV_QUOTIENT:
+        value = s->div_quotient[core];
+        s->div_dirty[core] = false;
+        break;
+    case SIO_DIV_REMAINDER:
+        value = s->div_remainder[core];
+        break;
+    case SIO_DIV_CSR:
+        value = rp2040_sio_div_csr(s, core);
+        break;
+    default:
+        if (rp2040_sio_spinlock_offset(reg, &index)) {
+            value = (s->spinlock_st & BIT(index)) ? 0 : BIT(index);
+            s->spinlock_st |= BIT(index);
+        } else {
+            value = 0;
+            rp2040_log_unimplemented_read("sio", size,
+                                          RP2040_SIO_BASE + addr, addr,
+                                          value);
+        }
+        break;
+    }
+
+    return extract64(value, shift, size * 8);
+}
+
+static void rp2040_sio_write(void *opaque, hwaddr addr,
+                             uint64_t value64, unsigned size)
+{
+    RP2040SioState *s = opaque;
+    unsigned core = rp2040_sio_current_core();
+    unsigned interp;
+    unsigned index;
+    unsigned shift = (addr & 3) * 8;
+    hwaddr interp_reg;
+    hwaddr reg = addr & ~3ULL;
+    uint32_t value = (uint32_t)value64 << shift;
+
+    if (rp2040_sio_interp_offset(reg, &interp, &interp_reg)) {
+        rp2040_sio_interp_write(s, core, interp, interp_reg, value);
+        return;
+    }
+
+    switch (reg) {
+    case SIO_GPIO_OUT:
+        s->gpio_out = value & SIO_GPIO_MASK;
+        break;
+    case SIO_GPIO_OUT_SET:
+        s->gpio_out |= value & SIO_GPIO_MASK;
+        break;
+    case SIO_GPIO_OUT_CLR:
+        s->gpio_out &= ~(value & SIO_GPIO_MASK);
+        break;
+    case SIO_GPIO_OUT_XOR:
+        s->gpio_out ^= value & SIO_GPIO_MASK;
+        break;
+    case SIO_GPIO_OE:
+        s->gpio_oe = value & SIO_GPIO_MASK;
+        break;
+    case SIO_GPIO_OE_SET:
+        s->gpio_oe |= value & SIO_GPIO_MASK;
+        break;
+    case SIO_GPIO_OE_CLR:
+        s->gpio_oe &= ~(value & SIO_GPIO_MASK);
+        break;
+    case SIO_GPIO_OE_XOR:
+        s->gpio_oe ^= value & SIO_GPIO_MASK;
+        break;
+    case SIO_GPIO_HI_OUT:
+        s->gpio_hi_out = value & SIO_GPIO_HI_MASK;
+        break;
+    case SIO_GPIO_HI_OUT_SET:
+        s->gpio_hi_out |= value & SIO_GPIO_HI_MASK;
+        break;
+    case SIO_GPIO_HI_OUT_CLR:
+        s->gpio_hi_out &= ~(value & SIO_GPIO_HI_MASK);
+        break;
+    case SIO_GPIO_HI_OUT_XOR:
+        s->gpio_hi_out ^= value & SIO_GPIO_HI_MASK;
+        break;
+    case SIO_GPIO_HI_OE:
+        s->gpio_hi_oe = value & SIO_GPIO_HI_MASK;
+        break;
+    case SIO_GPIO_HI_OE_SET:
+        s->gpio_hi_oe |= value & SIO_GPIO_HI_MASK;
+        break;
+    case SIO_GPIO_HI_OE_CLR:
+        s->gpio_hi_oe &= ~(value & SIO_GPIO_HI_MASK);
+        break;
+    case SIO_GPIO_HI_OE_XOR:
+        s->gpio_hi_oe ^= value & SIO_GPIO_HI_MASK;
+        break;
+    case SIO_FIFO_ST:
+        s->fifo_sticky[core] &= ~(value & SIO_FIFO_ST_WC_MASK);
+        break;
+    case SIO_FIFO_WR:
+        rp2040_sio_fifo_push(s, core, value);
+        break;
+    case SIO_DIV_UDIVIDEND:
+        s->div_dividend[core] = value;
+        rp2040_sio_divide(s, core, false);
+        break;
+    case SIO_DIV_UDIVISOR:
+        s->div_divisor[core] = value;
+        rp2040_sio_divide(s, core, false);
+        break;
+    case SIO_DIV_SDIVIDEND:
+        s->div_dividend[core] = value;
+        rp2040_sio_divide(s, core, true);
+        break;
+    case SIO_DIV_SDIVISOR:
+        s->div_divisor[core] = value;
+        rp2040_sio_divide(s, core, true);
+        break;
+    case SIO_DIV_QUOTIENT:
+        s->div_quotient[core] = value;
+        s->div_dirty[core] = true;
+        break;
+    case SIO_DIV_REMAINDER:
+        s->div_remainder[core] = value;
+        s->div_dirty[core] = true;
+        break;
+    default:
+        if (rp2040_sio_spinlock_offset(reg, &index)) {
+            s->spinlock_st &= ~BIT(index);
+        } else {
+            rp2040_log_unimplemented_write("sio", size,
+                                           RP2040_SIO_BASE + addr, addr,
+                                           value64);
+        }
+        break;
+    }
+}
+
+static const MemoryRegionOps rp2040_sio_ops = {
+    .read = rp2040_sio_read,
+    .write = rp2040_sio_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 4,
+        .unaligned = false,
+    },
+};
+
+static void rp2040_sio_reset(DeviceState *dev)
+{
+    RP2040SioState *s = RP2040_SIO(dev);
+
+    s->gpio_in &= SIO_GPIO_MASK;
+    s->gpio_hi_in &= SIO_GPIO_HI_MASK;
+    s->gpio_out = 0;
+    s->gpio_oe = 0;
+    s->gpio_hi_out = 0;
+    s->gpio_hi_oe = 0;
+    memset(s->fifo, 0, sizeof(s->fifo));
+    memset(s->fifo_rptr, 0, sizeof(s->fifo_rptr));
+    memset(s->fifo_wptr, 0, sizeof(s->fifo_wptr));
+    memset(s->fifo_level, 0, sizeof(s->fifo_level));
+    memset(s->fifo_sticky, 0, sizeof(s->fifo_sticky));
+    memset(s->div_dividend, 0, sizeof(s->div_dividend));
+    memset(s->div_divisor, 0, sizeof(s->div_divisor));
+    memset(s->div_quotient, 0, sizeof(s->div_quotient));
+    memset(s->div_remainder, 0, sizeof(s->div_remainder));
+    memset(s->div_dirty, 0, sizeof(s->div_dirty));
+    memset(s->interp_accum, 0, sizeof(s->interp_accum));
+    memset(s->interp_base, 0, sizeof(s->interp_base));
+    memset(s->interp_ctrl, 0, sizeof(s->interp_ctrl));
+    s->spinlock_st = 0;
+    rp2040_sio_update_fifo_irq(s);
+}
+
+static void rp2040_sio_init(Object *obj)
+{
+    RP2040SioState *s = RP2040_SIO(obj);
+
+    memory_region_init_io(&s->iomem, obj, &rp2040_sio_ops, s,
+                          TYPE_RP2040_SIO, 0x1000);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->iomem);
+    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->fifo_irq[0]);
+    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->fifo_irq[1]);
+}
+
+static const VMStateDescription vmstate_rp2040_sio = {
+    .name = TYPE_RP2040_SIO,
+    .version_id = 3,
+    .minimum_version_id = 2,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32(gpio_out, RP2040SioState),
+        VMSTATE_UINT32(gpio_in, RP2040SioState),
+        VMSTATE_UINT32(gpio_hi_in, RP2040SioState),
+        VMSTATE_UINT32(gpio_oe, RP2040SioState),
+        VMSTATE_UINT32(gpio_hi_out, RP2040SioState),
+        VMSTATE_UINT32(gpio_hi_oe, RP2040SioState),
+        VMSTATE_UINT32_2DARRAY(fifo, RP2040SioState, RP2040_SIO_NUM_CORES,
+                               RP2040_SIO_FIFO_DEPTH),
+        VMSTATE_UINT8_ARRAY(fifo_rptr, RP2040SioState,
+                            RP2040_SIO_NUM_CORES),
+        VMSTATE_UINT8_ARRAY(fifo_wptr, RP2040SioState,
+                            RP2040_SIO_NUM_CORES),
+        VMSTATE_UINT8_ARRAY(fifo_level, RP2040SioState,
+                            RP2040_SIO_NUM_CORES),
+        VMSTATE_UINT32_ARRAY(fifo_sticky, RP2040SioState,
+                             RP2040_SIO_NUM_CORES),
+        VMSTATE_UINT32_ARRAY(div_dividend, RP2040SioState,
+                             RP2040_SIO_NUM_CORES),
+        VMSTATE_UINT32_ARRAY(div_divisor, RP2040SioState,
+                             RP2040_SIO_NUM_CORES),
+        VMSTATE_UINT32_ARRAY(div_quotient, RP2040SioState,
+                             RP2040_SIO_NUM_CORES),
+        VMSTATE_UINT32_ARRAY(div_remainder, RP2040SioState,
+                             RP2040_SIO_NUM_CORES),
+        VMSTATE_BOOL_ARRAY(div_dirty, RP2040SioState,
+                           RP2040_SIO_NUM_CORES),
+        VMSTATE_UINT32_2DARRAY_V(interp_accum, RP2040SioState,
+                                 RP2040_SIO_NUM_CORES,
+                                 RP2040_SIO_NUM_INTERPS *
+                                 RP2040_SIO_INTERP_NUM_LANES, 3),
+        VMSTATE_UINT32_2DARRAY_V(interp_base, RP2040SioState,
+                                 RP2040_SIO_NUM_CORES,
+                                 RP2040_SIO_NUM_INTERPS *
+                                 RP2040_SIO_INTERP_NUM_BASES, 3),
+        VMSTATE_UINT32_2DARRAY_V(interp_ctrl, RP2040SioState,
+                                 RP2040_SIO_NUM_CORES,
+                                 RP2040_SIO_NUM_INTERPS *
+                                 RP2040_SIO_INTERP_NUM_LANES, 3),
+        VMSTATE_UINT32(spinlock_st, RP2040SioState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const Property rp2040_sio_properties[] = {
+    DEFINE_PROP_UINT32("gpio-in", RP2040SioState, gpio_in, 0),
+    DEFINE_PROP_UINT32("gpio-hi-in", RP2040SioState, gpio_hi_in, 0),
+};
+
+static void rp2040_sio_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    device_class_set_legacy_reset(dc, rp2040_sio_reset);
+    device_class_set_props(dc, rp2040_sio_properties);
+    dc->vmsd = &vmstate_rp2040_sio;
+}
+
+static const TypeInfo rp2040_sio_info = {
+    .name = TYPE_RP2040_SIO,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(RP2040SioState),
+    .instance_init = rp2040_sio_init,
+    .class_init = rp2040_sio_class_init,
+};
+
+static void rp2040_sio_register_types(void)
+{
+    type_register_static(&rp2040_sio_info);
+}
+type_init(rp2040_sio_register_types)
diff --git a/hw/misc/rp2040_syscfg.c b/hw/misc/rp2040_syscfg.c
new file mode 100644
index 0000000000..0e0dd712c6
--- /dev/null
+++ b/hw/misc/rp2040_syscfg.c
@@ -0,0 +1,246 @@
+/*
+ * RP2040 syscfg emulation
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/misc/rp2040_nyi.h"
+#include "hw/misc/rp2040_syscfg.h"
+#include "migration/vmstate.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+
+#define SYSCFG_PROC0_NMI_MASK          0x00
+#define SYSCFG_PROC1_NMI_MASK          0x04
+#define SYSCFG_PROC_CONFIG             0x08
+#define SYSCFG_PROC_IN_SYNC_BYPASS     0x0c
+#define SYSCFG_PROC_IN_SYNC_BYPASS_HI  0x10
+#define SYSCFG_DBGFORCE                0x14
+#define SYSCFG_MEMPOWERDOWN            0x18
+
+#define PROC_CONFIG_RW_MASK            0xff000000
+#define PROC_CONFIG_RESET              0x10000000
+#define PROC_IN_SYNC_BYPASS_MASK       0x3fffffff
+#define PROC_IN_SYNC_BYPASS_HI_MASK    0x0000003f
+#define DBGFORCE_RW_MASK               0x000000ee
+#define DBGFORCE_RESET                 0x00000066
+#define MEMPOWERDOWN_MASK              0x000000ff
+
+#define ATOMIC_ALIAS_MASK              0x3000
+#define ATOMIC_XOR                     0x1000
+#define ATOMIC_SET                     0x2000
+#define ATOMIC_CLR                     0x3000
+
+static uint32_t rp2040_syscfg_apply_alias(uint32_t old, uint32_t value,
+                                          hwaddr alias)
+{
+    switch (alias) {
+    case ATOMIC_XOR:
+        return old ^ value;
+    case ATOMIC_SET:
+        return old | value;
+    case ATOMIC_CLR:
+        return old & ~value;
+    default:
+        return value;
+    }
+}
+
+static void rp2040_syscfg_update(RP2040SysCfgState *s)
+{
+    if (s->update) {
+        s->update(s->update_opaque);
+    }
+}
+
+void rp2040_syscfg_set_update_callback(RP2040SysCfgState *s,
+                                       RP2040SysCfgUpdateFn update,
+                                       void *opaque)
+{
+    s->update = update;
+    s->update_opaque = opaque;
+}
+
+uint32_t rp2040_syscfg_get_proc0_nmi_mask(RP2040SysCfgState *s)
+{
+    return s->proc0_nmi_mask;
+}
+
+uint32_t rp2040_syscfg_get_mempowerdown(RP2040SysCfgState *s)
+{
+    return s->mempowerdown;
+}
+
+static uint64_t rp2040_syscfg_read(void *opaque, hwaddr addr, unsigned size)
+{
+    RP2040SysCfgState *s = opaque;
+    hwaddr offset = addr & 0xfff;
+    uint64_t value;
+
+    switch (offset) {
+    case SYSCFG_PROC0_NMI_MASK:
+        value = s->proc0_nmi_mask;
+        break;
+    case SYSCFG_PROC1_NMI_MASK:
+        value = s->proc1_nmi_mask;
+        break;
+    case SYSCFG_PROC_CONFIG:
+        value = s->proc_config;
+        break;
+    case SYSCFG_PROC_IN_SYNC_BYPASS:
+        value = s->proc_in_sync_bypass;
+        break;
+    case SYSCFG_PROC_IN_SYNC_BYPASS_HI:
+        value = s->proc_in_sync_bypass_hi;
+        break;
+    case SYSCFG_DBGFORCE:
+        value = s->dbgforce;
+        break;
+    case SYSCFG_MEMPOWERDOWN:
+        value = s->mempowerdown;
+        break;
+    default:
+        value = 0;
+        rp2040_log_unimplemented_read("syscfg", size,
+                                      RP2040_SYSCFG_BASE + addr, offset,
+                                      value);
+        break;
+    }
+
+    return value;
+}
+
+static void rp2040_syscfg_write(void *opaque, hwaddr addr,
+                                uint64_t value64, unsigned size)
+{
+    RP2040SysCfgState *s = opaque;
+    hwaddr alias = addr & ATOMIC_ALIAS_MASK;
+    hwaddr offset = addr & 0xfff;
+    uint32_t value = value64;
+
+    switch (offset) {
+    case SYSCFG_PROC0_NMI_MASK:
+        s->proc0_nmi_mask =
+            rp2040_syscfg_apply_alias(s->proc0_nmi_mask, value, alias);
+        rp2040_syscfg_update(s);
+        break;
+    case SYSCFG_PROC1_NMI_MASK:
+        s->proc1_nmi_mask =
+            rp2040_syscfg_apply_alias(s->proc1_nmi_mask, value, alias);
+        rp2040_syscfg_update(s);
+        break;
+    case SYSCFG_PROC_CONFIG:
+        s->proc_config =
+            rp2040_syscfg_apply_alias(s->proc_config, value, alias) &
+            PROC_CONFIG_RW_MASK;
+        break;
+    case SYSCFG_PROC_IN_SYNC_BYPASS:
+        s->proc_in_sync_bypass =
+            rp2040_syscfg_apply_alias(s->proc_in_sync_bypass, value, alias) &
+            PROC_IN_SYNC_BYPASS_MASK;
+        break;
+    case SYSCFG_PROC_IN_SYNC_BYPASS_HI:
+        s->proc_in_sync_bypass_hi =
+            rp2040_syscfg_apply_alias(s->proc_in_sync_bypass_hi, value,
+                                      alias) &
+            PROC_IN_SYNC_BYPASS_HI_MASK;
+        break;
+    case SYSCFG_DBGFORCE:
+        s->dbgforce =
+            rp2040_syscfg_apply_alias(s->dbgforce, value, alias) &
+            DBGFORCE_RW_MASK;
+        break;
+    case SYSCFG_MEMPOWERDOWN:
+        s->mempowerdown =
+            rp2040_syscfg_apply_alias(s->mempowerdown, value, alias) &
+            MEMPOWERDOWN_MASK;
+        rp2040_syscfg_update(s);
+        break;
+    default:
+        rp2040_log_unimplemented_write("syscfg", size,
+                                       RP2040_SYSCFG_BASE + addr, offset,
+                                       value64);
+        break;
+    }
+}
+
+static const MemoryRegionOps rp2040_syscfg_ops = {
+    .read = rp2040_syscfg_read,
+    .write = rp2040_syscfg_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+static void rp2040_syscfg_reset(DeviceState *dev)
+{
+    RP2040SysCfgState *s = RP2040_SYSCFG(dev);
+
+    s->proc0_nmi_mask = 0;
+    s->proc1_nmi_mask = 0;
+    s->proc_config = PROC_CONFIG_RESET;
+    s->proc_in_sync_bypass = 0;
+    s->proc_in_sync_bypass_hi = 0;
+    s->dbgforce = DBGFORCE_RESET;
+    s->mempowerdown = 0;
+    rp2040_syscfg_update(s);
+}
+
+static int rp2040_syscfg_post_load(void *opaque, int version_id)
+{
+    RP2040SysCfgState *s = opaque;
+
+    rp2040_syscfg_update(s);
+    return 0;
+}
+
+static void rp2040_syscfg_init(Object *obj)
+{
+    RP2040SysCfgState *s = RP2040_SYSCFG(obj);
+
+    memory_region_init_io(&s->iomem, obj, &rp2040_syscfg_ops, s,
+                          "rp2040.syscfg", RP2040_SYSCFG_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->iomem);
+}
+
+static const VMStateDescription rp2040_syscfg_vmstate = {
+    .name = TYPE_RP2040_SYSCFG,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .post_load = rp2040_syscfg_post_load,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32(proc0_nmi_mask, RP2040SysCfgState),
+        VMSTATE_UINT32(proc1_nmi_mask, RP2040SysCfgState),
+        VMSTATE_UINT32(proc_config, RP2040SysCfgState),
+        VMSTATE_UINT32(proc_in_sync_bypass, RP2040SysCfgState),
+        VMSTATE_UINT32(proc_in_sync_bypass_hi, RP2040SysCfgState),
+        VMSTATE_UINT32(dbgforce, RP2040SysCfgState),
+        VMSTATE_UINT32(mempowerdown, RP2040SysCfgState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void rp2040_syscfg_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    device_class_set_legacy_reset(dc, rp2040_syscfg_reset);
+    dc->vmsd = &rp2040_syscfg_vmstate;
+}
+
+static const TypeInfo rp2040_syscfg_info = {
+    .name          = TYPE_RP2040_SYSCFG,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(RP2040SysCfgState),
+    .instance_init = rp2040_syscfg_init,
+    .class_init    = rp2040_syscfg_class_init,
+};
+
+static void rp2040_syscfg_register_types(void)
+{
+    type_register_static(&rp2040_syscfg_info);
+}
+type_init(rp2040_syscfg_register_types)
diff --git a/hw/misc/rp2040_sysinfo.c b/hw/misc/rp2040_sysinfo.c
new file mode 100644
index 0000000000..36268a1b22
--- /dev/null
+++ b/hw/misc/rp2040_sysinfo.c
@@ -0,0 +1,111 @@
+/*
+ * RP2040 sysinfo emulation
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/misc/rp2040_nyi.h"
+#include "hw/misc/rp2040_sysinfo.h"
+#include "migration/vmstate.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+
+#define SYSINFO_CHIP_ID        0x00
+#define SYSINFO_PLATFORM       0x04
+#define SYSINFO_GITREF_RP2040  0x40
+
+#define SYSINFO_PLATFORM_ASIC  BIT(1)
+
+/*
+ * The datasheet documents this as the chip source git hash, but does not
+ * require software-visible semantics beyond a stable chip-version value.
+ */
+#define SYSINFO_GITREF_QEMU    0x00000000
+
+static uint64_t rp2040_sysinfo_read(void *opaque, hwaddr addr, unsigned size)
+{
+    hwaddr offset = addr & 0xfff;
+    uint64_t value;
+
+    switch (offset) {
+    case SYSINFO_CHIP_ID:
+        value = 0;
+        break;
+    case SYSINFO_PLATFORM:
+        value = SYSINFO_PLATFORM_ASIC;
+        break;
+    case SYSINFO_GITREF_RP2040:
+        value = SYSINFO_GITREF_QEMU;
+        break;
+    default:
+        value = 0;
+        rp2040_log_unimplemented_read("sysinfo", size,
+                                      RP2040_SYSINFO_BASE + addr, offset,
+                                      value);
+        break;
+    }
+
+    return value;
+}
+
+static void rp2040_sysinfo_write(void *opaque, hwaddr addr,
+                                 uint64_t value, unsigned size)
+{
+    hwaddr offset = addr & 0xfff;
+
+    qemu_log_mask(LOG_GUEST_ERROR, "rp2040.sysinfo: write to read-only "
+                  "register (size %d, addr 0x%08" HWADDR_PRIx
+                  ", offset 0x%04" HWADDR_PRIx
+                  ", value 0x%0*" PRIx64 ")\n",
+                  size, RP2040_SYSINFO_BASE + addr, offset, size << 1, value);
+}
+
+static const MemoryRegionOps rp2040_sysinfo_ops = {
+    .read = rp2040_sysinfo_read,
+    .write = rp2040_sysinfo_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+static void rp2040_sysinfo_init(Object *obj)
+{
+    RP2040SysInfoState *s = RP2040_SYSINFO(obj);
+
+    memory_region_init_io(&s->iomem, obj, &rp2040_sysinfo_ops, s,
+                          "rp2040.sysinfo", RP2040_SYSINFO_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->iomem);
+}
+
+static const VMStateDescription rp2040_sysinfo_vmstate = {
+    .name = TYPE_RP2040_SYSINFO,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void rp2040_sysinfo_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->vmsd = &rp2040_sysinfo_vmstate;
+}
+
+static const TypeInfo rp2040_sysinfo_info = {
+    .name          = TYPE_RP2040_SYSINFO,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(RP2040SysInfoState),
+    .instance_init = rp2040_sysinfo_init,
+    .class_init    = rp2040_sysinfo_class_init,
+};
+
+static void rp2040_sysinfo_register_types(void)
+{
+    type_register_static(&rp2040_sysinfo_info);
+}
+type_init(rp2040_sysinfo_register_types)
diff --git a/hw/misc/rp2040_tbman.c b/hw/misc/rp2040_tbman.c
new file mode 100644
index 0000000000..72460e9c95
--- /dev/null
+++ b/hw/misc/rp2040_tbman.c
@@ -0,0 +1,94 @@
+/*
+ * RP2040 testbench manager emulation
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/misc/rp2040_nyi.h"
+#include "hw/misc/rp2040_tbman.h"
+#include "migration/vmstate.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+
+#define TBMAN_PLATFORM      0x00
+
+#define TBMAN_PLATFORM_ASIC BIT(0)
+
+static uint64_t rp2040_tbman_read(void *opaque, hwaddr addr, unsigned size)
+{
+    hwaddr offset = addr & 0xfff;
+    uint64_t value;
+
+    switch (offset) {
+    case TBMAN_PLATFORM:
+        value = TBMAN_PLATFORM_ASIC;
+        break;
+    default:
+        value = 0;
+        rp2040_log_unimplemented_read("tbman", size,
+                                      RP2040_TBMAN_BASE + addr, offset,
+                                      value);
+        break;
+    }
+
+    return value;
+}
+
+static void rp2040_tbman_write(void *opaque, hwaddr addr,
+                               uint64_t value64, unsigned size)
+{
+    hwaddr offset = addr & 0xfff;
+
+    rp2040_log_unimplemented_write("tbman", size, RP2040_TBMAN_BASE + addr,
+                                   offset, value64);
+}
+
+static const MemoryRegionOps rp2040_tbman_ops = {
+    .read = rp2040_tbman_read,
+    .write = rp2040_tbman_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+static void rp2040_tbman_init(Object *obj)
+{
+    RP2040TbmanState *s = RP2040_TBMAN(obj);
+
+    memory_region_init_io(&s->iomem, obj, &rp2040_tbman_ops, s,
+                          "rp2040.tbman", RP2040_TBMAN_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->iomem);
+}
+
+static const VMStateDescription rp2040_tbman_vmstate = {
+    .name = TYPE_RP2040_TBMAN,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void rp2040_tbman_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->vmsd = &rp2040_tbman_vmstate;
+}
+
+static const TypeInfo rp2040_tbman_info = {
+    .name          = TYPE_RP2040_TBMAN,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(RP2040TbmanState),
+    .instance_init = rp2040_tbman_init,
+    .class_init    = rp2040_tbman_class_init,
+};
+
+static void rp2040_tbman_register_types(void)
+{
+    type_register_static(&rp2040_tbman_info);
+}
+type_init(rp2040_tbman_register_types)
diff --git a/hw/misc/rp2040_timer.c b/hw/misc/rp2040_timer.c
new file mode 100644
index 0000000000..01d2d70793
--- /dev/null
+++ b/hw/misc/rp2040_timer.c
@@ -0,0 +1,372 @@
+/*
+ * RP2040 timer emulation
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/core/irq.h"
+#include "hw/misc/rp2040_nyi.h"
+#include "hw/misc/rp2040_timer.h"
+#include "migration/vmstate.h"
+#include "qemu/bitops.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "qemu/timer.h"
+
+#define TIMER_TIMEHW       0x00
+#define TIMER_TIMELW       0x04
+#define TIMER_TIMEHR       0x08
+#define TIMER_TIMELR       0x0c
+#define TIMER_ALARM0       0x10
+#define TIMER_ALARM3       0x1c
+#define TIMER_ARMED        0x20
+#define TIMER_TIMERAWH     0x24
+#define TIMER_TIMERAWL     0x28
+#define TIMER_DBGPAUSE     0x2c
+#define TIMER_PAUSE        0x30
+#define TIMER_INTR         0x34
+#define TIMER_INTE         0x38
+#define TIMER_INTF         0x3c
+#define TIMER_INTS         0x40
+
+#define TIMER_ALARM_MASK   0x0f
+#define TIMER_DBGPAUSE_MASK (BIT(2) | BIT(1))
+#define TIMER_PAUSE_MASK   BIT(0)
+
+#define ATOMIC_ALIAS_MASK  0x3000
+#define ATOMIC_XOR         0x1000
+#define ATOMIC_SET         0x2000
+#define ATOMIC_CLR         0x3000
+
+static uint32_t rp2040_timer_apply_alias(uint32_t old, uint32_t value,
+                                         hwaddr alias)
+{
+    switch (alias) {
+    case ATOMIC_XOR:
+        return old ^ value;
+    case ATOMIC_SET:
+        return old | value;
+    case ATOMIC_CLR:
+        return old & ~value;
+    default:
+        return value;
+    }
+}
+
+static uint64_t rp2040_timer_now_us(RP2040TimerState *s)
+{
+    if (s->pause & TIMER_PAUSE_MASK) {
+        return s->paused_time_us;
+    }
+
+    return qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) / 1000 + s->time_offset_us;
+}
+
+static uint32_t rp2040_timer_ints(RP2040TimerState *s)
+{
+    uint32_t ints = (s->intr & s->inte) | s->intf;
+
+    return ints & TIMER_ALARM_MASK;
+}
+
+static void rp2040_timer_update_irq(RP2040TimerState *s)
+{
+    uint32_t ints = rp2040_timer_ints(s);
+    int i;
+
+    for (i = 0; i < RP2040_TIMER_NUM_ALARMS; i++) {
+        qemu_set_irq(s->irq[i], !!(ints & BIT(i)));
+    }
+}
+
+static void rp2040_timer_update_alarm(RP2040TimerState *s, unsigned alarm)
+{
+    uint64_t now_us;
+    uint32_t delta;
+
+    if (!(s->armed & BIT(alarm)) || (s->pause & TIMER_PAUSE_MASK)) {
+        timer_del(s->alarm_timer[alarm]);
+        return;
+    }
+
+    now_us = rp2040_timer_now_us(s);
+    delta = s->alarm[alarm] - (uint32_t)now_us;
+    if (delta == 0 || delta > INT32_MAX) {
+        timer_del(s->alarm_timer[alarm]);
+        s->armed &= ~BIT(alarm);
+        s->intr |= BIT(alarm);
+        rp2040_timer_update_irq(s);
+    } else {
+        timer_mod(s->alarm_timer[alarm],
+                  qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
+                  (int64_t)delta * 1000);
+    }
+}
+
+static void rp2040_timer_update_alarms(RP2040TimerState *s)
+{
+    int i;
+
+    for (i = 0; i < RP2040_TIMER_NUM_ALARMS; i++) {
+        rp2040_timer_update_alarm(s, i);
+    }
+}
+
+static bool rp2040_timer_alarm_offset(hwaddr offset, unsigned *alarm)
+{
+    if (offset < TIMER_ALARM0 || offset > TIMER_ALARM3 || (offset & 0x3)) {
+        return false;
+    }
+
+    *alarm = (offset - TIMER_ALARM0) / sizeof(uint32_t);
+    return true;
+}
+
+static uint64_t rp2040_timer_read(void *opaque, hwaddr addr, unsigned size)
+{
+    RP2040TimerState *s = opaque;
+    hwaddr offset = addr & 0xfff;
+    uint64_t now_us = rp2040_timer_now_us(s);
+    unsigned alarm;
+    uint64_t value;
+
+    switch (offset) {
+    case TIMER_TIMEHR:
+    case TIMER_TIMERAWH:
+        value = now_us >> 32;
+        break;
+    case TIMER_TIMELR:
+    case TIMER_TIMERAWL:
+        value = (uint32_t)now_us;
+        break;
+    case TIMER_ARMED:
+        value = s->armed;
+        break;
+    case TIMER_DBGPAUSE:
+        value = s->dbgpause;
+        break;
+    case TIMER_PAUSE:
+        value = s->pause;
+        break;
+    case TIMER_INTR:
+        value = s->intr;
+        break;
+    case TIMER_INTE:
+        value = s->inte;
+        break;
+    case TIMER_INTF:
+        value = s->intf;
+        break;
+    case TIMER_INTS:
+        value = rp2040_timer_ints(s);
+        break;
+    default:
+        if (rp2040_timer_alarm_offset(offset, &alarm)) {
+            value = s->alarm[alarm];
+        } else {
+            value = 0;
+            rp2040_log_unimplemented_read("timer", size,
+                                          RP2040_TIMER_BASE + addr, offset,
+                                          value);
+        }
+        break;
+    }
+
+    return value;
+}
+
+static void rp2040_timer_set_time(RP2040TimerState *s, uint64_t value)
+{
+    if (s->pause & TIMER_PAUSE_MASK) {
+        s->paused_time_us = value;
+    } else {
+        s->time_offset_us = value -
+                            qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) / 1000;
+    }
+    rp2040_timer_update_alarms(s);
+}
+
+static void rp2040_timer_write(void *opaque, hwaddr addr,
+                               uint64_t value64, unsigned size)
+{
+    RP2040TimerState *s = opaque;
+    hwaddr alias = addr & ATOMIC_ALIAS_MASK;
+    hwaddr offset = addr & 0xfff;
+    uint32_t value = value64;
+    uint32_t old;
+    uint64_t now_us;
+    unsigned alarm;
+
+    switch (offset) {
+    case TIMER_TIMEHW:
+        now_us = rp2040_timer_now_us(s);
+        rp2040_timer_set_time(s, ((uint64_t)value << 32) |
+                              (uint32_t)now_us);
+        break;
+    case TIMER_TIMELW:
+        now_us = rp2040_timer_now_us(s);
+        rp2040_timer_set_time(s, (now_us & UINT64_C(0xffffffff00000000)) |
+                              value);
+        break;
+    case TIMER_ARMED:
+        s->armed &= ~(value & TIMER_ALARM_MASK);
+        rp2040_timer_update_alarms(s);
+        break;
+    case TIMER_DBGPAUSE:
+        s->dbgpause = rp2040_timer_apply_alias(s->dbgpause, value, alias) &
+                      TIMER_DBGPAUSE_MASK;
+        break;
+    case TIMER_PAUSE:
+        old = s->pause;
+        now_us = rp2040_timer_now_us(s);
+        s->pause = rp2040_timer_apply_alias(s->pause, value, alias) &
+                   TIMER_PAUSE_MASK;
+        if (!(old & TIMER_PAUSE_MASK) && (s->pause & TIMER_PAUSE_MASK)) {
+            s->paused_time_us = now_us;
+        } else if ((old & TIMER_PAUSE_MASK) &&
+                   !(s->pause & TIMER_PAUSE_MASK)) {
+            s->time_offset_us = s->paused_time_us -
+                                qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) / 1000;
+            rp2040_timer_update_alarms(s);
+        }
+        break;
+    case TIMER_INTR:
+        s->intr &= ~(value & TIMER_ALARM_MASK);
+        rp2040_timer_update_irq(s);
+        break;
+    case TIMER_INTE:
+        s->inte = rp2040_timer_apply_alias(s->inte, value, alias) &
+                  TIMER_ALARM_MASK;
+        rp2040_timer_update_irq(s);
+        break;
+    case TIMER_INTF:
+        s->intf = rp2040_timer_apply_alias(s->intf, value, alias) &
+                  TIMER_ALARM_MASK;
+        rp2040_timer_update_irq(s);
+        break;
+    default:
+        if (rp2040_timer_alarm_offset(offset, &alarm)) {
+            s->alarm[alarm] = value;
+            s->armed |= BIT(alarm);
+            rp2040_timer_update_alarm(s, alarm);
+        } else {
+            rp2040_log_unimplemented_write("timer", size,
+                                           RP2040_TIMER_BASE + addr, offset,
+                                           value64);
+        }
+        break;
+    }
+}
+
+static const MemoryRegionOps rp2040_timer_ops = {
+    .read = rp2040_timer_read,
+    .write = rp2040_timer_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+static void rp2040_timer_alarm_tick(void *opaque)
+{
+    uintptr_t packed = (uintptr_t)opaque;
+    RP2040TimerState *s = (RP2040TimerState *)(packed & ~(uintptr_t)0x3);
+    unsigned alarm = packed & 0x3;
+
+    s->armed &= ~BIT(alarm);
+    s->intr |= BIT(alarm);
+    rp2040_timer_update_irq(s);
+}
+
+static void rp2040_timer_reset(DeviceState *dev)
+{
+    RP2040TimerState *s = RP2040_TIMER(dev);
+    int i;
+
+    s->time_offset_us = -qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) / 1000;
+    s->paused_time_us = 0;
+    memset(s->alarm, 0, sizeof(s->alarm));
+    s->armed = 0;
+    s->dbgpause = TIMER_DBGPAUSE_MASK;
+    s->pause = 0;
+    s->intr = 0;
+    s->inte = 0;
+    s->intf = 0;
+
+    for (i = 0; i < RP2040_TIMER_NUM_ALARMS; i++) {
+        timer_del(s->alarm_timer[i]);
+        qemu_set_irq(s->irq[i], 0);
+    }
+}
+
+static void rp2040_timer_init(Object *obj)
+{
+    RP2040TimerState *s = RP2040_TIMER(obj);
+
+    memory_region_init_io(&s->iomem, obj, &rp2040_timer_ops, s,
+                          "rp2040.timer", RP2040_TIMER_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->iomem);
+    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq[0]);
+    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq[1]);
+    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq[2]);
+    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq[3]);
+}
+
+static void rp2040_timer_realize(DeviceState *dev, Error **errp)
+{
+    RP2040TimerState *s = RP2040_TIMER(dev);
+    int i;
+
+    for (i = 0; i < RP2040_TIMER_NUM_ALARMS; i++) {
+        s->alarm_timer[i] =
+            timer_new_ns(QEMU_CLOCK_VIRTUAL, rp2040_timer_alarm_tick,
+                         (void *)((uintptr_t)s | i));
+    }
+}
+
+static const VMStateDescription rp2040_timer_vmstate = {
+    .name = TYPE_RP2040_TIMER,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_TIMER_PTR_ARRAY(alarm_timer, RP2040TimerState,
+                                RP2040_TIMER_NUM_ALARMS),
+        VMSTATE_INT64(time_offset_us, RP2040TimerState),
+        VMSTATE_UINT64(paused_time_us, RP2040TimerState),
+        VMSTATE_UINT32_ARRAY(alarm, RP2040TimerState,
+                             RP2040_TIMER_NUM_ALARMS),
+        VMSTATE_UINT32(armed, RP2040TimerState),
+        VMSTATE_UINT32(dbgpause, RP2040TimerState),
+        VMSTATE_UINT32(pause, RP2040TimerState),
+        VMSTATE_UINT32(intr, RP2040TimerState),
+        VMSTATE_UINT32(inte, RP2040TimerState),
+        VMSTATE_UINT32(intf, RP2040TimerState),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static void rp2040_timer_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = rp2040_timer_realize;
+    device_class_set_legacy_reset(dc, rp2040_timer_reset);
+    dc->vmsd = &rp2040_timer_vmstate;
+}
+
+static const TypeInfo rp2040_timer_info = {
+    .name          = TYPE_RP2040_TIMER,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(RP2040TimerState),
+    .instance_init = rp2040_timer_init,
+    .class_init    = rp2040_timer_class_init,
+};
+
+static void rp2040_timer_register_types(void)
+{
+    type_register_static(&rp2040_timer_info);
+}
+
+type_init(rp2040_timer_register_types)
diff --git a/hw/misc/rp2040_vreg.c b/hw/misc/rp2040_vreg.c
new file mode 100644
index 0000000000..812a64fce4
--- /dev/null
+++ b/hw/misc/rp2040_vreg.c
@@ -0,0 +1,179 @@
+/*
+ * RP2040 voltage regulator and chip reset emulation
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/misc/rp2040_nyi.h"
+#include "hw/misc/rp2040_vreg.h"
+#include "migration/vmstate.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+
+#define VREG_VREG          0x00
+#define VREG_BOD           0x04
+#define VREG_CHIP_RESET    0x08
+
+#define VREG_ROK           BIT(12)
+#define VREG_VSEL_MASK     0x000000f0
+#define VREG_HIZ           BIT(1)
+#define VREG_EN            BIT(0)
+#define VREG_RW_MASK       (VREG_VSEL_MASK | VREG_HIZ | VREG_EN)
+#define VREG_RESET         0x000000b1
+
+#define BOD_VSEL_MASK      0x000000f0
+#define BOD_EN             BIT(0)
+#define BOD_RW_MASK        (BOD_VSEL_MASK | BOD_EN)
+#define BOD_RESET          0x00000091
+
+#define CHIP_RESET_RW_MASK 0x01000000
+
+#define ATOMIC_ALIAS_MASK  0x3000
+#define ATOMIC_XOR         0x1000
+#define ATOMIC_SET         0x2000
+#define ATOMIC_CLR         0x3000
+
+static uint32_t rp2040_vreg_apply_alias(uint32_t old, uint32_t value,
+                                        hwaddr alias)
+{
+    switch (alias) {
+    case ATOMIC_XOR:
+        return old ^ value;
+    case ATOMIC_SET:
+        return old | value;
+    case ATOMIC_CLR:
+        return old & ~value;
+    default:
+        return value;
+    }
+}
+
+static uint32_t rp2040_vreg_read_vreg(RP2040VregState *s)
+{
+    uint32_t value = s->vreg;
+
+    if ((value & VREG_EN) && !(value & VREG_HIZ)) {
+        value |= VREG_ROK;
+    }
+
+    return value;
+}
+
+static uint64_t rp2040_vreg_read(void *opaque, hwaddr addr, unsigned size)
+{
+    RP2040VregState *s = opaque;
+    hwaddr offset = addr & 0xfff;
+    uint64_t value;
+
+    switch (offset) {
+    case VREG_VREG:
+        value = rp2040_vreg_read_vreg(s);
+        break;
+    case VREG_BOD:
+        value = s->bod;
+        break;
+    case VREG_CHIP_RESET:
+        value = s->chip_reset;
+        break;
+    default:
+        value = 0;
+        rp2040_log_unimplemented_read("vreg_and_chip_reset", size,
+                                      RP2040_VREG_BASE + addr, offset,
+                                      value);
+        break;
+    }
+
+    return value;
+}
+
+static void rp2040_vreg_write(void *opaque, hwaddr addr,
+                              uint64_t value64, unsigned size)
+{
+    RP2040VregState *s = opaque;
+    hwaddr alias = addr & ATOMIC_ALIAS_MASK;
+    hwaddr offset = addr & 0xfff;
+    uint32_t value = value64;
+
+    switch (offset) {
+    case VREG_VREG:
+        s->vreg = rp2040_vreg_apply_alias(s->vreg, value, alias) &
+                  VREG_RW_MASK;
+        break;
+    case VREG_BOD:
+        s->bod = rp2040_vreg_apply_alias(s->bod, value, alias) & BOD_RW_MASK;
+        break;
+    case VREG_CHIP_RESET:
+        s->chip_reset =
+            rp2040_vreg_apply_alias(s->chip_reset, value, alias) &
+            CHIP_RESET_RW_MASK;
+        break;
+    default:
+        rp2040_log_unimplemented_write("vreg_and_chip_reset", size,
+                                       RP2040_VREG_BASE + addr, offset,
+                                       value64);
+        break;
+    }
+}
+
+static const MemoryRegionOps rp2040_vreg_ops = {
+    .read = rp2040_vreg_read,
+    .write = rp2040_vreg_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+static void rp2040_vreg_reset(DeviceState *dev)
+{
+    RP2040VregState *s = RP2040_VREG(dev);
+
+    s->vreg = VREG_RESET;
+    s->bod = BOD_RESET;
+    s->chip_reset = 0;
+}
+
+static void rp2040_vreg_init(Object *obj)
+{
+    RP2040VregState *s = RP2040_VREG(obj);
+
+    memory_region_init_io(&s->iomem, obj, &rp2040_vreg_ops, s,
+                          "rp2040.vreg_and_chip_reset", RP2040_VREG_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->iomem);
+}
+
+static const VMStateDescription rp2040_vreg_vmstate = {
+    .name = TYPE_RP2040_VREG,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32(vreg, RP2040VregState),
+        VMSTATE_UINT32(bod, RP2040VregState),
+        VMSTATE_UINT32(chip_reset, RP2040VregState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void rp2040_vreg_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    device_class_set_legacy_reset(dc, rp2040_vreg_reset);
+    dc->vmsd = &rp2040_vreg_vmstate;
+}
+
+static const TypeInfo rp2040_vreg_info = {
+    .name          = TYPE_RP2040_VREG,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(RP2040VregState),
+    .instance_init = rp2040_vreg_init,
+    .class_init    = rp2040_vreg_class_init,
+};
+
+static void rp2040_vreg_register_types(void)
+{
+    type_register_static(&rp2040_vreg_info);
+}
+type_init(rp2040_vreg_register_types)
diff --git a/hw/misc/rp2040_watchdog.c b/hw/misc/rp2040_watchdog.c
new file mode 100644
index 0000000000..eb767304b2
--- /dev/null
+++ b/hw/misc/rp2040_watchdog.c
@@ -0,0 +1,361 @@
+/*
+ * RP2040 watchdog emulation
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/core/qdev-clock.h"
+#include "hw/misc/rp2040_nyi.h"
+#include "hw/misc/rp2040_watchdog.h"
+#include "migration/vmstate.h"
+#include "qapi/error.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "qemu/timer.h"
+#include "system/watchdog.h"
+
+#define WATCHDOG_CTRL       0x00
+#define WATCHDOG_LOAD       0x04
+#define WATCHDOG_REASON     0x08
+#define WATCHDOG_SCRATCH0   0x0c
+#define WATCHDOG_SCRATCH7   0x28
+#define WATCHDOG_TICK       0x2c
+
+#define WATCHDOG_CTRL_TRIGGER   BIT(31)
+#define WATCHDOG_CTRL_ENABLE    BIT(30)
+#define WATCHDOG_CTRL_PAUSE_DBG1 BIT(26)
+#define WATCHDOG_CTRL_PAUSE_DBG0 BIT(25)
+#define WATCHDOG_CTRL_PAUSE_JTAG BIT(24)
+#define WATCHDOG_CTRL_PAUSE_MASK \
+    (WATCHDOG_CTRL_PAUSE_DBG1 | WATCHDOG_CTRL_PAUSE_DBG0 | \
+     WATCHDOG_CTRL_PAUSE_JTAG)
+#define WATCHDOG_CTRL_TIME_MASK 0x00ffffff
+#define WATCHDOG_CTRL_RW_MASK \
+    (WATCHDOG_CTRL_ENABLE | WATCHDOG_CTRL_PAUSE_MASK)
+
+#define WATCHDOG_LOAD_MASK  0x00ffffff
+#define WATCHDOG_REASON_FORCE   BIT(1)
+#define WATCHDOG_REASON_TIMER   BIT(0)
+
+#define WATCHDOG_TICK_ENABLE    BIT(9)
+#define WATCHDOG_TICK_RUNNING   BIT(10)
+#define WATCHDOG_TICK_CYCLES_MASK 0x000001ff
+#define WATCHDOG_TICK_RW_MASK \
+    (WATCHDOG_TICK_ENABLE | WATCHDOG_TICK_CYCLES_MASK)
+#define WATCHDOG_TICK_COUNT_SHIFT 11
+
+#define ATOMIC_ALIAS_MASK   0x3000
+#define ATOMIC_XOR          0x1000
+#define ATOMIC_SET          0x2000
+#define ATOMIC_CLR          0x3000
+
+static uint32_t rp2040_watchdog_apply_alias(uint32_t old, uint32_t value,
+                                            hwaddr alias)
+{
+    switch (alias) {
+    case ATOMIC_XOR:
+        return old ^ value;
+    case ATOMIC_SET:
+        return old | value;
+    case ATOMIC_CLR:
+        return old & ~value;
+    default:
+        return value;
+    }
+}
+
+static uint32_t rp2040_watchdog_expand_write(uint32_t value, unsigned size)
+{
+    switch (size) {
+    case 1:
+        return value * 0x01010101u;
+    case 2:
+        return (value & 0xffffu) * 0x00010001u;
+    default:
+        return value;
+    }
+}
+
+static bool rp2040_watchdog_scratch_offset(hwaddr offset, unsigned *index)
+{
+    if (offset < WATCHDOG_SCRATCH0 || offset > WATCHDOG_SCRATCH7) {
+        return false;
+    }
+
+    *index = (offset - WATCHDOG_SCRATCH0) / sizeof(uint32_t);
+    return true;
+}
+
+static bool rp2040_watchdog_tick_running(RP2040WatchdogState *s)
+{
+    return (s->tick & WATCHDOG_TICK_ENABLE) &&
+           (s->tick & WATCHDOG_TICK_CYCLES_MASK) &&
+           clock_get_hz(s->clk_ref);
+}
+
+static uint32_t rp2040_watchdog_tick_freq_hz(RP2040WatchdogState *s)
+{
+    uint64_t clk_ref_hz = clock_get_hz(s->clk_ref);
+    uint32_t cycles = s->tick & WATCHDOG_TICK_CYCLES_MASK;
+
+    if (!cycles || !clk_ref_hz || !(s->tick & WATCHDOG_TICK_ENABLE)) {
+        return 0;
+    }
+
+    return MIN(UINT32_MAX, (uint32_t)(clk_ref_hz / cycles));
+}
+
+static uint32_t rp2040_watchdog_tick_read(RP2040WatchdogState *s)
+{
+    uint32_t value = s->tick & WATCHDOG_TICK_RW_MASK;
+
+    if (rp2040_watchdog_tick_running(s)) {
+        /*
+         * The precise divider phase is not observable by current firmware
+         * tests. Report a stable running state and a valid non-zero count.
+         */
+        value |= WATCHDOG_TICK_RUNNING;
+        value |= (s->tick & WATCHDOG_TICK_CYCLES_MASK) <<
+                 WATCHDOG_TICK_COUNT_SHIFT;
+    }
+
+    return value;
+}
+
+static void rp2040_watchdog_update(RP2040WatchdogState *s)
+{
+    uint32_t tick_hz = rp2040_watchdog_tick_freq_hz(s);
+    uint64_t watchdog_hz = (uint64_t)tick_hz * 2;
+
+    ptimer_transaction_begin(s->timer);
+    if (!tick_hz) {
+        ptimer_stop(s->timer);
+    } else {
+        /*
+         * RP2040-E1: the watchdog counter decrements twice per watchdog
+         * tick, so a LOAD of N expires after N / 2 generated ticks.
+         */
+        ptimer_set_freq(s->timer, MIN(watchdog_hz, (uint64_t)UINT32_MAX));
+        if (s->ctrl & WATCHDOG_CTRL_ENABLE) {
+            ptimer_run(s->timer, 1);
+        } else {
+            ptimer_stop(s->timer);
+        }
+    }
+    ptimer_transaction_commit(s->timer);
+}
+
+static uint32_t rp2040_watchdog_ctrl_read(RP2040WatchdogState *s)
+{
+    uint32_t time = MIN(ptimer_get_count(s->timer), WATCHDOG_CTRL_TIME_MASK);
+
+    return (s->ctrl & WATCHDOG_CTRL_RW_MASK) | time;
+}
+
+static void rp2040_watchdog_reset_request(RP2040WatchdogState *s,
+                                          uint32_t reason,
+                                          bool in_ptimer_transaction)
+{
+    s->reason = reason;
+    if (!in_ptimer_transaction) {
+        ptimer_transaction_begin(s->timer);
+    }
+    ptimer_stop(s->timer);
+    if (!in_ptimer_transaction) {
+        ptimer_transaction_commit(s->timer);
+    }
+    watchdog_perform_action();
+}
+
+static uint64_t rp2040_watchdog_read(void *opaque, hwaddr addr, unsigned size)
+{
+    RP2040WatchdogState *s = opaque;
+    hwaddr offset = addr & 0xfff;
+    hwaddr word_offset = offset & ~3ULL;
+    unsigned scratch;
+    uint64_t value;
+
+    switch (word_offset) {
+    case WATCHDOG_CTRL:
+        value = rp2040_watchdog_ctrl_read(s);
+        break;
+    case WATCHDOG_LOAD:
+        value = 0;
+        break;
+    case WATCHDOG_REASON:
+        value = s->reason;
+        break;
+    case WATCHDOG_TICK:
+        value = rp2040_watchdog_tick_read(s);
+        break;
+    default:
+        if (rp2040_watchdog_scratch_offset(word_offset, &scratch)) {
+            value = s->scratch[scratch];
+        } else {
+            value = 0;
+            rp2040_log_unimplemented_read("watchdog", size,
+                                          RP2040_WATCHDOG_BASE + addr,
+                                          offset, value);
+        }
+        break;
+    }
+
+    return extract64(value, (offset & 3) * 8, size * 8);
+}
+
+static void rp2040_watchdog_write(void *opaque, hwaddr addr,
+                                  uint64_t value64, unsigned size)
+{
+    RP2040WatchdogState *s = opaque;
+    hwaddr alias = addr & ATOMIC_ALIAS_MASK;
+    hwaddr offset = addr & 0xfff;
+    hwaddr word_offset = offset & ~3ULL;
+    unsigned scratch;
+    uint32_t value = rp2040_watchdog_expand_write(value64, size);
+
+    switch (word_offset) {
+    case WATCHDOG_CTRL: {
+        uint32_t old = rp2040_watchdog_ctrl_read(s);
+        uint32_t newval = rp2040_watchdog_apply_alias(old, value, alias);
+
+        s->ctrl = newval & WATCHDOG_CTRL_RW_MASK;
+        rp2040_watchdog_update(s);
+        if (newval & WATCHDOG_CTRL_TRIGGER) {
+            rp2040_watchdog_reset_request(s, WATCHDOG_REASON_FORCE, false);
+        }
+        break;
+    }
+    case WATCHDOG_LOAD:
+        s->load = rp2040_watchdog_apply_alias(s->load, value, alias) &
+                  WATCHDOG_LOAD_MASK;
+        ptimer_transaction_begin(s->timer);
+        ptimer_set_limit(s->timer, s->load, 1);
+        ptimer_transaction_commit(s->timer);
+        rp2040_watchdog_update(s);
+        break;
+    case WATCHDOG_REASON:
+        break;
+    case WATCHDOG_TICK:
+        s->tick = rp2040_watchdog_apply_alias(s->tick, value, alias) &
+                  WATCHDOG_TICK_RW_MASK;
+        rp2040_watchdog_update(s);
+        break;
+    default:
+        if (rp2040_watchdog_scratch_offset(word_offset, &scratch)) {
+            s->scratch[scratch] =
+                rp2040_watchdog_apply_alias(s->scratch[scratch], value,
+                                            alias);
+        } else {
+            rp2040_log_unimplemented_write("watchdog", size,
+                                           RP2040_WATCHDOG_BASE + addr,
+                                           offset, value64);
+        }
+        break;
+    }
+}
+
+static const MemoryRegionOps rp2040_watchdog_ops = {
+    .read = rp2040_watchdog_read,
+    .write = rp2040_watchdog_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 4,
+        .unaligned = false,
+    },
+};
+
+static void rp2040_watchdog_reset(DeviceState *dev)
+{
+    RP2040WatchdogState *s = RP2040_WATCHDOG(dev);
+
+    s->ctrl = WATCHDOG_CTRL_PAUSE_MASK;
+    s->load = 0;
+    s->tick = WATCHDOG_TICK_ENABLE;
+
+    ptimer_transaction_begin(s->timer);
+    ptimer_stop(s->timer);
+    ptimer_set_limit(s->timer, 0, 1);
+    ptimer_transaction_commit(s->timer);
+}
+
+static void rp2040_watchdog_clk_ref_update(void *opaque, ClockEvent event)
+{
+    rp2040_watchdog_update(opaque);
+}
+
+static void rp2040_watchdog_tick(void *opaque)
+{
+    RP2040WatchdogState *s = RP2040_WATCHDOG(opaque);
+
+    rp2040_watchdog_reset_request(s, WATCHDOG_REASON_TIMER, true);
+}
+
+static void rp2040_watchdog_init(Object *obj)
+{
+    RP2040WatchdogState *s = RP2040_WATCHDOG(obj);
+    DeviceState *dev = DEVICE(obj);
+
+    s->clk_ref = qdev_init_clock_in(dev, "clk-ref",
+                                    rp2040_watchdog_clk_ref_update, s,
+                                    ClockUpdate);
+    memory_region_init_io(&s->iomem, obj, &rp2040_watchdog_ops, s,
+                          "rp2040.watchdog", RP2040_WATCHDOG_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->iomem);
+}
+
+static void rp2040_watchdog_realize(DeviceState *dev, Error **errp)
+{
+    RP2040WatchdogState *s = RP2040_WATCHDOG(dev);
+
+    if (!clock_has_source(s->clk_ref)) {
+        error_setg(errp, "RP2040 watchdog: clk-ref clock must be connected");
+        return;
+    }
+
+    s->timer = ptimer_init(rp2040_watchdog_tick, s,
+                           PTIMER_POLICY_WRAP_AFTER_ONE_PERIOD |
+                           PTIMER_POLICY_TRIGGER_ONLY_ON_DECREMENT |
+                           PTIMER_POLICY_NO_IMMEDIATE_RELOAD |
+                           PTIMER_POLICY_NO_COUNTER_ROUND_DOWN);
+}
+
+static const VMStateDescription rp2040_watchdog_vmstate = {
+    .name = TYPE_RP2040_WATCHDOG,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_CLOCK(clk_ref, RP2040WatchdogState),
+        VMSTATE_PTIMER(timer, RP2040WatchdogState),
+        VMSTATE_UINT32(ctrl, RP2040WatchdogState),
+        VMSTATE_UINT32(load, RP2040WatchdogState),
+        VMSTATE_UINT32(reason, RP2040WatchdogState),
+        VMSTATE_UINT32_ARRAY(scratch, RP2040WatchdogState, 8),
+        VMSTATE_UINT32(tick, RP2040WatchdogState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void rp2040_watchdog_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = rp2040_watchdog_realize;
+    device_class_set_legacy_reset(dc, rp2040_watchdog_reset);
+    dc->vmsd = &rp2040_watchdog_vmstate;
+}
+
+static const TypeInfo rp2040_watchdog_info = {
+    .name          = TYPE_RP2040_WATCHDOG,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(RP2040WatchdogState),
+    .instance_init = rp2040_watchdog_init,
+    .class_init    = rp2040_watchdog_class_init,
+};
+
+static void rp2040_watchdog_register_types(void)
+{
+    type_register_static(&rp2040_watchdog_info);
+}
+type_init(rp2040_watchdog_register_types)
diff --git a/hw/misc/rp2040_xosc.c b/hw/misc/rp2040_xosc.c
new file mode 100644
index 0000000000..a8340ca0c9
--- /dev/null
+++ b/hw/misc/rp2040_xosc.c
@@ -0,0 +1,237 @@
+/*
+ * RP2040 crystal oscillator emulation
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/core/qdev-clock.h"
+#include "hw/misc/rp2040_nyi.h"
+#include "hw/misc/rp2040_xosc.h"
+#include "migration/vmstate.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+
+#define XOSC_HZ             12000000
+
+#define XOSC_CTRL           0x00
+#define XOSC_STATUS         0x04
+#define XOSC_DORMANT        0x08
+#define XOSC_STARTUP        0x0c
+#define XOSC_COUNT          0x1c
+
+#define XOSC_ENABLE_DISABLE 0xd1e
+#define XOSC_ENABLE_ENABLE  0xfab
+#define XOSC_FREQ_1_15MHZ   0xaa0
+#define XOSC_DORMANT_VALUE  0x636f6d61
+#define XOSC_WAKE_VALUE     0x77616b65
+
+#define XOSC_STATUS_STABLE  BIT(31)
+#define XOSC_STATUS_BADWRITE BIT(24)
+#define XOSC_STATUS_ENABLED BIT(12)
+
+#define ATOMIC_ALIAS_MASK    0x3000
+#define ATOMIC_XOR           0x1000
+#define ATOMIC_SET           0x2000
+#define ATOMIC_CLR           0x3000
+
+static bool rp2040_xosc_enabled(RP2040XoscState *s)
+{
+    return extract32(s->ctrl, 12, 12) != XOSC_ENABLE_DISABLE;
+}
+
+static void rp2040_xosc_update_clock(RP2040XoscState *s)
+{
+    clock_update_hz(s->clk, rp2040_xosc_enabled(s) ? XOSC_HZ : 0);
+}
+
+static uint32_t rp2040_xosc_status(RP2040XoscState *s)
+{
+    uint32_t value = 0;
+
+    if (rp2040_xosc_enabled(s)) {
+        value |= XOSC_STATUS_ENABLED;
+        if (s->dormant == XOSC_WAKE_VALUE) {
+            value |= XOSC_STATUS_STABLE;
+        }
+    }
+    if (s->badwrite) {
+        value |= XOSC_STATUS_BADWRITE;
+    }
+
+    return value;
+}
+
+static uint64_t rp2040_xosc_read(void *opaque, hwaddr addr, unsigned size)
+{
+    RP2040XoscState *s = opaque;
+    hwaddr offset = addr & 0xfff;
+    uint64_t value;
+
+    switch (offset) {
+    case XOSC_CTRL:
+        value = s->ctrl;
+        break;
+    case XOSC_STATUS:
+        value = rp2040_xosc_status(s);
+        break;
+    case XOSC_DORMANT:
+        value = s->dormant;
+        break;
+    case XOSC_STARTUP:
+        value = s->startup;
+        break;
+    case XOSC_COUNT:
+        value = 0;
+        break;
+    default:
+        value = 0;
+        rp2040_log_unimplemented_read("xosc", size,
+                                      RP2040_XOSC_BASE + addr, offset,
+                                      value);
+        break;
+    }
+
+    return value;
+}
+
+static uint32_t rp2040_xosc_apply_alias(uint32_t old, uint32_t value,
+                                        hwaddr alias)
+{
+    switch (alias) {
+    case ATOMIC_XOR:
+        return old ^ value;
+    case ATOMIC_SET:
+        return old | value;
+    case ATOMIC_CLR:
+        return old & ~value;
+    default:
+        return value;
+    }
+}
+
+static void rp2040_xosc_write_ctrl(RP2040XoscState *s, uint32_t value)
+{
+    uint32_t enable = extract32(value, 12, 12);
+    uint32_t freq_range = extract32(value, 0, 12);
+
+    if (freq_range != XOSC_FREQ_1_15MHZ ||
+        (enable != XOSC_ENABLE_DISABLE && enable != XOSC_ENABLE_ENABLE)) {
+        s->badwrite = true;
+    }
+
+    if (enable != XOSC_ENABLE_DISABLE && enable != XOSC_ENABLE_ENABLE) {
+        value = deposit32(value, 12, 12, XOSC_ENABLE_ENABLE);
+    }
+    value = deposit32(value, 0, 12, XOSC_FREQ_1_15MHZ);
+
+    s->ctrl = value;
+    rp2040_xosc_update_clock(s);
+}
+
+static void rp2040_xosc_write(void *opaque, hwaddr addr,
+                              uint64_t value64, unsigned size)
+{
+    RP2040XoscState *s = opaque;
+    hwaddr alias = addr & ATOMIC_ALIAS_MASK;
+    hwaddr offset = addr & 0xfff;
+    uint32_t value = value64;
+
+    switch (offset) {
+    case XOSC_CTRL:
+        rp2040_xosc_write_ctrl(s, rp2040_xosc_apply_alias(s->ctrl, value,
+                                                          alias));
+        break;
+    case XOSC_STATUS:
+        if (value & XOSC_STATUS_BADWRITE) {
+            s->badwrite = false;
+        }
+        break;
+    case XOSC_DORMANT:
+        s->dormant = value == XOSC_DORMANT_VALUE ? value : XOSC_WAKE_VALUE;
+        rp2040_xosc_update_clock(s);
+        break;
+    case XOSC_STARTUP:
+        s->startup = value & 0x00103fff;
+        break;
+    case XOSC_COUNT:
+        s->count = 0;
+        break;
+    default:
+        rp2040_log_unimplemented_write("xosc", size,
+                                       RP2040_XOSC_BASE + addr, offset,
+                                       value64);
+        break;
+    }
+}
+
+static const MemoryRegionOps rp2040_xosc_ops = {
+    .read = rp2040_xosc_read,
+    .write = rp2040_xosc_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+static void rp2040_xosc_reset(DeviceState *dev)
+{
+    RP2040XoscState *s = RP2040_XOSC(dev);
+
+    s->ctrl = (XOSC_ENABLE_DISABLE << 12) | XOSC_FREQ_1_15MHZ;
+    s->dormant = XOSC_WAKE_VALUE;
+    s->startup = 0x000000c4;
+    s->count = 0;
+    s->badwrite = false;
+
+    rp2040_xosc_update_clock(s);
+}
+
+static void rp2040_xosc_init(Object *obj)
+{
+    RP2040XoscState *s = RP2040_XOSC(obj);
+    DeviceState *dev = DEVICE(obj);
+
+    s->clk = qdev_init_clock_out(dev, "clk");
+    memory_region_init_io(&s->iomem, obj, &rp2040_xosc_ops, s,
+                          "rp2040.xosc", RP2040_XOSC_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->iomem);
+}
+
+static const VMStateDescription rp2040_xosc_vmstate = {
+    .name = TYPE_RP2040_XOSC,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32(ctrl, RP2040XoscState),
+        VMSTATE_UINT32(dormant, RP2040XoscState),
+        VMSTATE_UINT32(startup, RP2040XoscState),
+        VMSTATE_UINT32(count, RP2040XoscState),
+        VMSTATE_BOOL(badwrite, RP2040XoscState),
+        VMSTATE_CLOCK(clk, RP2040XoscState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void rp2040_xosc_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    device_class_set_legacy_reset(dc, rp2040_xosc_reset);
+    dc->vmsd = &rp2040_xosc_vmstate;
+}
+
+static const TypeInfo rp2040_xosc_info = {
+    .name          = TYPE_RP2040_XOSC,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(RP2040XoscState),
+    .instance_init = rp2040_xosc_init,
+    .class_init    = rp2040_xosc_class_init,
+};
+
+static void rp2040_xosc_register_types(void)
+{
+    type_register_static(&rp2040_xosc_info);
+}
+type_init(rp2040_xosc_register_types)
diff --git a/hw/misc/unimp.c b/hw/misc/unimp.c
index 521b84bf20..91ef789640 100644
--- a/hw/misc/unimp.c
+++ b/hw/misc/unimp.c
@@ -23,8 +23,10 @@ static uint64_t unimp_read(void *opaque, hwaddr offset, unsigned size)
     UnimplementedDeviceState *s = UNIMPLEMENTED_DEVICE(opaque);
 
     qemu_log_mask(LOG_UNIMP, "%s: unimplemented device read  "
-                  "(size %d, offset 0x%0*" HWADDR_PRIx ")\n",
-                  s->name, size, s->offset_fmt_width, offset);
+                  "(size %d, addr 0x%08" PRIx64
+                  ", offset 0x%0*" HWADDR_PRIx ")\n",
+                  s->name, size, s->base + offset,
+                  s->offset_fmt_width, offset);
     return 0;
 }
 
@@ -34,9 +36,11 @@ static void unimp_write(void *opaque, hwaddr offset,
     UnimplementedDeviceState *s = UNIMPLEMENTED_DEVICE(opaque);
 
     qemu_log_mask(LOG_UNIMP, "%s: unimplemented device write "
-                  "(size %d, offset 0x%0*" HWADDR_PRIx
+                  "(size %d, addr 0x%08" PRIx64
+                  ", offset 0x%0*" HWADDR_PRIx
                   ", value 0x%0*" PRIx64 ")\n",
-                  s->name, size, s->offset_fmt_width, offset, size << 1, value);
+                  s->name, size, s->base + offset,
+                  s->offset_fmt_width, offset, size << 1, value);
 }
 
 static const MemoryRegionOps unimp_ops = {
@@ -71,6 +75,7 @@ static void unimp_realize(DeviceState *dev, Error **errp)
 }
 
 static const Property unimp_properties[] = {
+    DEFINE_PROP_UINT64("base", UnimplementedDeviceState, base, 0),
     DEFINE_PROP_UINT64("size", UnimplementedDeviceState, size, 0),
     DEFINE_PROP_STRING("name", UnimplementedDeviceState, name),
 };
diff --git a/include/hw/misc/rp2040_busctrl.h b/include/hw/misc/rp2040_busctrl.h
new file mode 100644
index 0000000000..5c4a6d6d2b
--- /dev/null
+++ b/include/hw/misc/rp2040_busctrl.h
@@ -0,0 +1,29 @@
+/*
+ * RP2040 bus fabric control emulation
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_MISC_RP2040_BUSCTRL_H
+#define HW_MISC_RP2040_BUSCTRL_H
+
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_RP2040_BUSCTRL "rp2040-busctrl"
+OBJECT_DECLARE_SIMPLE_TYPE(RP2040BusCtrlState, RP2040_BUSCTRL)
+
+#define RP2040_BUSCTRL_BASE 0x40030000
+#define RP2040_BUSCTRL_SIZE 0x4000
+
+struct RP2040BusCtrlState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion iomem;
+
+    uint32_t priority;
+    uint32_t perfctr[4];
+    uint32_t perfsel[4];
+};
+
+#endif
diff --git a/include/hw/misc/rp2040_clocks.h b/include/hw/misc/rp2040_clocks.h
new file mode 100644
index 0000000000..ebbb14e3fa
--- /dev/null
+++ b/include/hw/misc/rp2040_clocks.h
@@ -0,0 +1,36 @@
+/*
+ * RP2040 clocks emulation
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_MISC_RP2040_CLOCKS_H
+#define HW_MISC_RP2040_CLOCKS_H
+
+#include "hw/core/clock.h"
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_RP2040_CLOCKS "rp2040-clocks"
+OBJECT_DECLARE_SIMPLE_TYPE(RP2040ClocksState, RP2040_CLOCKS)
+
+#define RP2040_CLOCKS_BASE 0x40008000
+#define RP2040_CLOCKS_SIZE 0x4000
+
+struct RP2040ClocksState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion iomem;
+    Clock *clk_ref;
+    Clock *clk_sys;
+    Clock *clk_peri;
+    Clock *clk_usb;
+    Clock *clk_adc;
+    Clock *clk_rtc;
+    Clock *pll_sys;
+    Clock *pll_usb;
+
+    uint32_t regs[0x100 / 4];
+};
+
+#endif
diff --git a/include/hw/misc/rp2040_iobank0.h b/include/hw/misc/rp2040_iobank0.h
new file mode 100644
index 0000000000..93f5b4b2f4
--- /dev/null
+++ b/include/hw/misc/rp2040_iobank0.h
@@ -0,0 +1,45 @@
+/*
+ * RP2040 GPIO IO bank emulation
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_MISC_RP2040_IOBANK0_H
+#define HW_MISC_RP2040_IOBANK0_H
+
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_RP2040_IOBANK0 "rp2040-iobank0"
+OBJECT_DECLARE_SIMPLE_TYPE(RP2040IoBank0State, RP2040_IOBANK0)
+
+#define RP2040_IOBANK0_BASE 0x40014000
+#define RP2040_IOBANK0_SIZE 0x4000
+#define RP2040_IOBANK0_NUM_GPIOS 30
+#define RP2040_IOBANK0_IRQ_BANKS 4
+
+struct RP2040IoBank0State {
+    SysBusDevice parent_obj;
+
+    MemoryRegion iomem;
+    qemu_irq proc0_irq;
+    qemu_irq proc1_irq;
+    qemu_irq uart0_pin[2];
+    qemu_irq uart1_pin[2];
+
+    uint32_t ctrl[RP2040_IOBANK0_NUM_GPIOS];
+    uint32_t intr[RP2040_IOBANK0_IRQ_BANKS];
+    uint32_t proc0_inte[RP2040_IOBANK0_IRQ_BANKS];
+    uint32_t proc0_intf[RP2040_IOBANK0_IRQ_BANKS];
+    uint32_t proc1_inte[RP2040_IOBANK0_IRQ_BANKS];
+    uint32_t proc1_intf[RP2040_IOBANK0_IRQ_BANKS];
+    uint32_t dormant_wake_inte[RP2040_IOBANK0_IRQ_BANKS];
+    uint32_t dormant_wake_intf[RP2040_IOBANK0_IRQ_BANKS];
+};
+
+bool rp2040_iobank0_uart0_tx_enabled(RP2040IoBank0State *s);
+bool rp2040_iobank0_uart0_rx_enabled(RP2040IoBank0State *s);
+bool rp2040_iobank0_uart1_tx_enabled(RP2040IoBank0State *s);
+bool rp2040_iobank0_uart1_rx_enabled(RP2040IoBank0State *s);
+
+#endif
diff --git a/include/hw/misc/rp2040_ioqspi.h b/include/hw/misc/rp2040_ioqspi.h
new file mode 100644
index 0000000000..eae63588e6
--- /dev/null
+++ b/include/hw/misc/rp2040_ioqspi.h
@@ -0,0 +1,36 @@
+/*
+ * RP2040 QSPI IO bank emulation
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_MISC_RP2040_IOQSPI_H
+#define HW_MISC_RP2040_IOQSPI_H
+
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_RP2040_IOQSPI "rp2040-ioqspi"
+OBJECT_DECLARE_SIMPLE_TYPE(RP2040IoQspiState, RP2040_IOQSPI)
+
+typedef struct RP2040XipState RP2040XipState;
+
+#define RP2040_IOQSPI_BASE 0x40018000
+#define RP2040_IOQSPI_SIZE 0x4000
+
+struct RP2040IoQspiState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion iomem;
+    uint32_t ctrl[6];
+    uint32_t intr;
+    uint32_t proc0_inte;
+    uint32_t proc0_intf;
+    uint32_t proc1_inte;
+    uint32_t proc1_intf;
+    uint32_t dormant_wake_inte;
+    uint32_t dormant_wake_intf;
+    RP2040XipState *xip;
+};
+
+#endif
diff --git a/include/hw/misc/rp2040_nyi.h b/include/hw/misc/rp2040_nyi.h
new file mode 100644
index 0000000000..c23805973b
--- /dev/null
+++ b/include/hw/misc/rp2040_nyi.h
@@ -0,0 +1,19 @@
+/*
+ * RP2040 "not yet implemented" diagnostics
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_MISC_RP2040_NYI_H
+#define HW_MISC_RP2040_NYI_H
+
+void rp2040_log_nyi(const char *component, const char *feature,
+                    const char *detail);
+void rp2040_log_unimplemented_read(const char *component, unsigned size,
+                                   uint64_t addr, uint64_t offset,
+                                   uint64_t value);
+void rp2040_log_unimplemented_write(const char *component, unsigned size,
+                                    uint64_t addr, uint64_t offset,
+                                    uint64_t value);
+
+#endif
diff --git a/include/hw/misc/rp2040_pads.h b/include/hw/misc/rp2040_pads.h
new file mode 100644
index 0000000000..3fc6cd54bb
--- /dev/null
+++ b/include/hw/misc/rp2040_pads.h
@@ -0,0 +1,42 @@
+/*
+ * RP2040 pad control emulation
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_MISC_RP2040_PADS_H
+#define HW_MISC_RP2040_PADS_H
+
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_RP2040_PADS_QSPI "rp2040-pads-qspi"
+OBJECT_DECLARE_SIMPLE_TYPE(RP2040PadsQspiState, RP2040_PADS_QSPI)
+
+#define TYPE_RP2040_PADS_BANK0 "rp2040-pads-bank0"
+OBJECT_DECLARE_SIMPLE_TYPE(RP2040PadsBank0State, RP2040_PADS_BANK0)
+
+#define RP2040_PADS_BANK0_BASE 0x4001c000
+#define RP2040_PADS_BANK0_SIZE 0x4000
+#define RP2040_PADS_QSPI_BASE 0x40020000
+#define RP2040_PADS_QSPI_SIZE 0x4000
+
+struct RP2040PadsBank0State {
+    SysBusDevice parent_obj;
+
+    MemoryRegion iomem;
+    uint32_t voltage_select;
+    uint32_t gpio[30];
+    uint32_t swclk;
+    uint32_t swd;
+};
+
+struct RP2040PadsQspiState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion iomem;
+    uint32_t voltage_select;
+    uint32_t pad[6];
+};
+
+#endif
diff --git a/include/hw/misc/rp2040_pll.h b/include/hw/misc/rp2040_pll.h
new file mode 100644
index 0000000000..ad188aa46e
--- /dev/null
+++ b/include/hw/misc/rp2040_pll.h
@@ -0,0 +1,37 @@
+/*
+ * RP2040 PLL emulation
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_MISC_RP2040_PLL_H
+#define HW_MISC_RP2040_PLL_H
+
+#include "hw/core/clock.h"
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_RP2040_PLL "rp2040-pll"
+OBJECT_DECLARE_SIMPLE_TYPE(RP2040PllState, RP2040_PLL)
+
+#define RP2040_PLL_SYS_BASE 0x40028000
+#define RP2040_PLL_USB_BASE 0x4002c000
+#define RP2040_PLL_SIZE     0x4000
+
+struct RP2040PllState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion iomem;
+    Clock *clk;
+
+    char *trace_name;
+    uint32_t base;
+    uint32_t fallback_hz;
+
+    uint32_t cs;
+    uint32_t pwr;
+    uint32_t fbdiv_int;
+    uint32_t prim;
+};
+
+#endif
diff --git a/include/hw/misc/rp2040_psm.h b/include/hw/misc/rp2040_psm.h
new file mode 100644
index 0000000000..8b68fb2ed8
--- /dev/null
+++ b/include/hw/misc/rp2040_psm.h
@@ -0,0 +1,40 @@
+/*
+ * RP2040 power-on state machine emulation
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_MISC_RP2040_PSM_H
+#define HW_MISC_RP2040_PSM_H
+
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_RP2040_PSM "rp2040-psm"
+OBJECT_DECLARE_SIMPLE_TYPE(RP2040PsmState, RP2040_PSM)
+
+#define RP2040_PSM_BASE       0x40010000
+#define RP2040_PSM_SIZE       0x4000
+#define RP2040_PSM_VALID_MASK 0x0001ffff
+#define RP2040_PSM_PROC1      (1u << 16)
+
+typedef void (*RP2040PsmUpdateFn)(void *opaque);
+
+struct RP2040PsmState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion iomem;
+    uint32_t frce_on;
+    uint32_t frce_off;
+    uint32_t wdsel;
+
+    RP2040PsmUpdateFn update;
+    void *update_opaque;
+};
+
+void rp2040_psm_set_update_callback(RP2040PsmState *s,
+                                    RP2040PsmUpdateFn update,
+                                    void *opaque);
+uint32_t rp2040_psm_get_frce_off(RP2040PsmState *s);
+
+#endif
diff --git a/include/hw/misc/rp2040_resets.h b/include/hw/misc/rp2040_resets.h
new file mode 100644
index 0000000000..ba87d8d7c1
--- /dev/null
+++ b/include/hw/misc/rp2040_resets.h
@@ -0,0 +1,28 @@
+/*
+ * RP2040 reset controller emulation
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_MISC_RP2040_RESETS_H
+#define HW_MISC_RP2040_RESETS_H
+
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_RP2040_RESETS "rp2040-resets"
+OBJECT_DECLARE_SIMPLE_TYPE(RP2040ResetsState, RP2040_RESETS)
+
+#define RP2040_RESETS_BASE 0x4000c000
+#define RP2040_RESETS_SIZE 0x4000
+
+struct RP2040ResetsState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion iomem;
+
+    uint32_t reset;
+    uint32_t wdsel;
+};
+
+#endif
diff --git a/include/hw/misc/rp2040_rosc.h b/include/hw/misc/rp2040_rosc.h
new file mode 100644
index 0000000000..6377704e22
--- /dev/null
+++ b/include/hw/misc/rp2040_rosc.h
@@ -0,0 +1,42 @@
+/*
+ * RP2040 ring oscillator emulation
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_MISC_RP2040_ROSC_H
+#define HW_MISC_RP2040_ROSC_H
+
+#include "hw/core/clock.h"
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_RP2040_ROSC "rp2040-rosc"
+OBJECT_DECLARE_SIMPLE_TYPE(RP2040RoscState, RP2040_ROSC)
+
+#define RP2040_ROSC_BASE 0x40060000
+#define RP2040_ROSC_SIZE 0x4000
+
+struct RP2040RoscState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion iomem;
+    Clock *clk;
+
+    uint32_t ctrl;
+    uint32_t freqa;
+    uint32_t freqb;
+    uint32_t dormant;
+    uint32_t div;
+    uint32_t phase;
+    uint32_t count;
+    int64_t count_start_ns;
+    uint64_t random_pool;
+    uint64_t random_prng_state;
+    uint64_t random_seed;
+    uint8_t random_pool_bits;
+    bool random_seed_set;
+    bool badwrite;
+};
+
+#endif
diff --git a/include/hw/misc/rp2040_sio.h b/include/hw/misc/rp2040_sio.h
new file mode 100644
index 0000000000..e2a79a8a34
--- /dev/null
+++ b/include/hw/misc/rp2040_sio.h
@@ -0,0 +1,57 @@
+/*
+ * RP2040 single-cycle IO block emulation
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_MISC_RP2040_SIO_H
+#define HW_MISC_RP2040_SIO_H
+
+#include "hw/core/irq.h"
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_RP2040_SIO "rp2040-sio"
+OBJECT_DECLARE_SIMPLE_TYPE(RP2040SioState, RP2040_SIO)
+
+#define RP2040_SIO_BASE 0xd0000000
+#define RP2040_SIO_NUM_CORES 2
+#define RP2040_SIO_FIFO_DEPTH 8
+#define RP2040_SIO_NUM_INTERPS 2
+#define RP2040_SIO_INTERP_NUM_LANES 2
+#define RP2040_SIO_INTERP_NUM_BASES 3
+
+struct RP2040SioState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion iomem;
+    qemu_irq fifo_irq[RP2040_SIO_NUM_CORES];
+    uint32_t gpio_in;
+    uint32_t gpio_hi_in;
+    uint32_t gpio_out;
+    uint32_t gpio_oe;
+    uint32_t gpio_hi_out;
+    uint32_t gpio_hi_oe;
+    uint32_t fifo[RP2040_SIO_NUM_CORES][RP2040_SIO_FIFO_DEPTH];
+    uint8_t fifo_rptr[RP2040_SIO_NUM_CORES];
+    uint8_t fifo_wptr[RP2040_SIO_NUM_CORES];
+    uint8_t fifo_level[RP2040_SIO_NUM_CORES];
+    uint32_t fifo_sticky[RP2040_SIO_NUM_CORES];
+    uint32_t div_dividend[RP2040_SIO_NUM_CORES];
+    uint32_t div_divisor[RP2040_SIO_NUM_CORES];
+    uint32_t div_quotient[RP2040_SIO_NUM_CORES];
+    uint32_t div_remainder[RP2040_SIO_NUM_CORES];
+    bool div_dirty[RP2040_SIO_NUM_CORES];
+    uint32_t interp_accum[RP2040_SIO_NUM_CORES]
+                          [RP2040_SIO_NUM_INTERPS *
+                           RP2040_SIO_INTERP_NUM_LANES];
+    uint32_t interp_base[RP2040_SIO_NUM_CORES]
+                         [RP2040_SIO_NUM_INTERPS *
+                          RP2040_SIO_INTERP_NUM_BASES];
+    uint32_t interp_ctrl[RP2040_SIO_NUM_CORES]
+                         [RP2040_SIO_NUM_INTERPS *
+                          RP2040_SIO_INTERP_NUM_LANES];
+    uint32_t spinlock_st;
+};
+
+#endif
diff --git a/include/hw/misc/rp2040_syscfg.h b/include/hw/misc/rp2040_syscfg.h
new file mode 100644
index 0000000000..c31799ae7a
--- /dev/null
+++ b/include/hw/misc/rp2040_syscfg.h
@@ -0,0 +1,42 @@
+/*
+ * RP2040 syscfg emulation
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_MISC_RP2040_SYSCFG_H
+#define HW_MISC_RP2040_SYSCFG_H
+
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_RP2040_SYSCFG "rp2040-syscfg"
+OBJECT_DECLARE_SIMPLE_TYPE(RP2040SysCfgState, RP2040_SYSCFG)
+
+#define RP2040_SYSCFG_BASE 0x40004000
+#define RP2040_SYSCFG_SIZE 0x4000
+
+typedef void (*RP2040SysCfgUpdateFn)(void *opaque);
+
+struct RP2040SysCfgState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion iomem;
+    RP2040SysCfgUpdateFn update;
+    void *update_opaque;
+    uint32_t proc0_nmi_mask;
+    uint32_t proc1_nmi_mask;
+    uint32_t proc_config;
+    uint32_t proc_in_sync_bypass;
+    uint32_t proc_in_sync_bypass_hi;
+    uint32_t dbgforce;
+    uint32_t mempowerdown;
+};
+
+void rp2040_syscfg_set_update_callback(RP2040SysCfgState *s,
+                                       RP2040SysCfgUpdateFn update,
+                                       void *opaque);
+uint32_t rp2040_syscfg_get_proc0_nmi_mask(RP2040SysCfgState *s);
+uint32_t rp2040_syscfg_get_mempowerdown(RP2040SysCfgState *s);
+
+#endif
diff --git a/include/hw/misc/rp2040_sysinfo.h b/include/hw/misc/rp2040_sysinfo.h
new file mode 100644
index 0000000000..d521659488
--- /dev/null
+++ b/include/hw/misc/rp2040_sysinfo.h
@@ -0,0 +1,25 @@
+/*
+ * RP2040 sysinfo emulation
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_MISC_RP2040_SYSINFO_H
+#define HW_MISC_RP2040_SYSINFO_H
+
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_RP2040_SYSINFO "rp2040-sysinfo"
+OBJECT_DECLARE_SIMPLE_TYPE(RP2040SysInfoState, RP2040_SYSINFO)
+
+#define RP2040_SYSINFO_BASE 0x40000000
+#define RP2040_SYSINFO_SIZE 0x4000
+
+struct RP2040SysInfoState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion iomem;
+};
+
+#endif
diff --git a/include/hw/misc/rp2040_tbman.h b/include/hw/misc/rp2040_tbman.h
new file mode 100644
index 0000000000..50b55039ce
--- /dev/null
+++ b/include/hw/misc/rp2040_tbman.h
@@ -0,0 +1,25 @@
+/*
+ * RP2040 testbench manager emulation
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_MISC_RP2040_TBMAN_H
+#define HW_MISC_RP2040_TBMAN_H
+
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_RP2040_TBMAN "rp2040-tbman"
+OBJECT_DECLARE_SIMPLE_TYPE(RP2040TbmanState, RP2040_TBMAN)
+
+#define RP2040_TBMAN_BASE 0x4006c000
+#define RP2040_TBMAN_SIZE 0x4000
+
+struct RP2040TbmanState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion iomem;
+};
+
+#endif
diff --git a/include/hw/misc/rp2040_timer.h b/include/hw/misc/rp2040_timer.h
new file mode 100644
index 0000000000..b14bf75d53
--- /dev/null
+++ b/include/hw/misc/rp2040_timer.h
@@ -0,0 +1,39 @@
+/*
+ * RP2040 timer emulation
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_MISC_RP2040_TIMER_H
+#define HW_MISC_RP2040_TIMER_H
+
+#include "hw/core/sysbus.h"
+#include "qemu/timer.h"
+#include "qom/object.h"
+
+#define TYPE_RP2040_TIMER "rp2040-timer"
+OBJECT_DECLARE_SIMPLE_TYPE(RP2040TimerState, RP2040_TIMER)
+
+#define RP2040_TIMER_BASE 0x40054000
+#define RP2040_TIMER_SIZE 0x4000
+#define RP2040_TIMER_NUM_ALARMS 4
+
+struct RP2040TimerState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion iomem;
+    qemu_irq irq[RP2040_TIMER_NUM_ALARMS];
+    QEMUTimer *alarm_timer[RP2040_TIMER_NUM_ALARMS];
+
+    int64_t time_offset_us;
+    uint64_t paused_time_us;
+    uint32_t alarm[RP2040_TIMER_NUM_ALARMS];
+    uint32_t armed;
+    uint32_t dbgpause;
+    uint32_t pause;
+    uint32_t intr;
+    uint32_t inte;
+    uint32_t intf;
+};
+
+#endif
diff --git a/include/hw/misc/rp2040_vreg.h b/include/hw/misc/rp2040_vreg.h
new file mode 100644
index 0000000000..9f1723b7d5
--- /dev/null
+++ b/include/hw/misc/rp2040_vreg.h
@@ -0,0 +1,28 @@
+/*
+ * RP2040 voltage regulator and chip reset emulation
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_MISC_RP2040_VREG_H
+#define HW_MISC_RP2040_VREG_H
+
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_RP2040_VREG "rp2040-vreg"
+OBJECT_DECLARE_SIMPLE_TYPE(RP2040VregState, RP2040_VREG)
+
+#define RP2040_VREG_BASE 0x40064000
+#define RP2040_VREG_SIZE 0x4000
+
+struct RP2040VregState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion iomem;
+    uint32_t vreg;
+    uint32_t bod;
+    uint32_t chip_reset;
+};
+
+#endif
diff --git a/include/hw/misc/rp2040_watchdog.h b/include/hw/misc/rp2040_watchdog.h
new file mode 100644
index 0000000000..2da12c9441
--- /dev/null
+++ b/include/hw/misc/rp2040_watchdog.h
@@ -0,0 +1,35 @@
+/*
+ * RP2040 watchdog emulation
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_MISC_RP2040_WATCHDOG_H
+#define HW_MISC_RP2040_WATCHDOG_H
+
+#include "hw/core/clock.h"
+#include "hw/core/ptimer.h"
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_RP2040_WATCHDOG "rp2040-watchdog"
+OBJECT_DECLARE_SIMPLE_TYPE(RP2040WatchdogState, RP2040_WATCHDOG)
+
+#define RP2040_WATCHDOG_BASE 0x40058000
+#define RP2040_WATCHDOG_SIZE 0x4000
+
+struct RP2040WatchdogState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion iomem;
+    Clock *clk_ref;
+    ptimer_state *timer;
+
+    uint32_t ctrl;
+    uint32_t load;
+    uint32_t reason;
+    uint32_t scratch[8];
+    uint32_t tick;
+};
+
+#endif
diff --git a/include/hw/misc/rp2040_xosc.h b/include/hw/misc/rp2040_xosc.h
new file mode 100644
index 0000000000..7b9ef62d22
--- /dev/null
+++ b/include/hw/misc/rp2040_xosc.h
@@ -0,0 +1,33 @@
+/*
+ * RP2040 crystal oscillator emulation
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_MISC_RP2040_XOSC_H
+#define HW_MISC_RP2040_XOSC_H
+
+#include "hw/core/clock.h"
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_RP2040_XOSC "rp2040-xosc"
+OBJECT_DECLARE_SIMPLE_TYPE(RP2040XoscState, RP2040_XOSC)
+
+#define RP2040_XOSC_BASE 0x40024000
+#define RP2040_XOSC_SIZE 0x4000
+
+struct RP2040XoscState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion iomem;
+    Clock *clk;
+
+    uint32_t ctrl;
+    uint32_t dormant;
+    uint32_t startup;
+    uint32_t count;
+    bool badwrite;
+};
+
+#endif
diff --git a/include/hw/misc/unimp.h b/include/hw/misc/unimp.h
index 77a5077511..d06ca425ec 100644
--- a/include/hw/misc/unimp.h
+++ b/include/hw/misc/unimp.h
@@ -22,6 +22,7 @@ struct UnimplementedDeviceState {
     MemoryRegion iomem;
     unsigned offset_fmt_width;
     char *name;
+    uint64_t base;
     uint64_t size;
 };
 
@@ -45,6 +46,7 @@ static inline void create_unimplemented_device(const char *name,
     DeviceState *dev = qdev_new(TYPE_UNIMPLEMENTED_DEVICE);
 
     qdev_prop_set_string(dev, "name", name);
+    qdev_prop_set_uint64(dev, "base", base);
     qdev_prop_set_uint64(dev, "size", size);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
-- 
2.53.0


