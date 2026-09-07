Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 448F9C79F9E
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 05:27:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3RqM-0004qm-MQ; Mon, 07 Sep 2026 01:24:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x3RqL-0004qG-Fc; Mon, 07 Sep 2026 01:24:33 -0400
Received: from smtp-out-2.univ-lille.fr ([194.254.129.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x3RqI-0007s8-5v; Mon, 07 Sep 2026 01:24:33 -0400
Received: from smtp01.univ-lille.fr (smtp01.univ-lille.fr [194.254.129.95])
 by smtp-out-2.univ-lille.fr (Postfix) with ESMTPS id 4hdb972W22z7vDZ;
 Mon,  7 Sep 2026 07:24:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=univ-lille.fr;
 s=dkim; t=1788758667;
 bh=q/xFF68O3Q4c38tlX+8R1kh/Z8QA3Fhr0Vv7twa5lww=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=aULRSZ2Fc48IVWrcR96eS8p+1JsuEVETTP5Kl7y7cGQAGf/Lmh1FjLsSFM/1oWJ1O
 iML9FozwNDUQvMh3z2RQ6/OspshMg3ddmejLVEKP/t8+SEVT4/88lyoIm5wP/4vhnL
 7jG0dq/jxZR/HtsZ74v9JnSQKA12RgRv7YOQm4756Ub52KqtdEEejJsdKlbeINhDA9
 wfOOAX+ZTRNu5woLGLsjgCVOUfUvemIb34PXpJ4u9aZk+McBmPUrTBVGJcwuwGTqYu
 TcWp56dfalamob1wh3tdygUjAmXN4MgoYW+pLB6qvshNAzlYA0gN67JZtBEk/t4hi3
 +k5fTIz03mFoA==
Received: from mac.home (lfbn-lil-1-243-101.w90-45.abo.wanadoo.fr
 [90.45.87.101]) (Authenticated sender: gilles.grimaud)
 by smtp01.univ-lille.fr (Postfix) with ESMTPSA id 4hdb9673sMz7xqd;
 Mon,  7 Sep 2026 07:24:26 +0200 (CEST)
From: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, peter.maydell@linaro.org,
 Gilles Grimaud <gilles.grimaud@univ-lille.fr>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 17/36] hw/misc: add RP2040 pad controls
Date: Mon,  7 Sep 2026 07:24:05 +0200
Message-ID: <20260907052426.24849-1-gilles.grimaud@univ-lille.fr>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260906194438.93046-1-gilles.grimaud@univ-lille.fr>
References: <20260906194438.93046-1-gilles.grimaud@univ-lille.fr>
MIME-Version: 1.0
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

Model the RP2040 PADS_BANK0 and PADS_QSPI register banks, including
documented reset values, writable masks and atomic aliases. Wire both
blocks into the SoC and add focused qtests for their reset and update
behavior.

Signed-off-by: gilles grimaud <gilles.grimaud@univ-lille.fr>
---
 hw/arm/rp2040.c                |  18 +-
 hw/misc/meson.build            |   1 +
 hw/misc/rp2040_pads.c          | 303 +++++++++++++++++++++++++++++++++
 include/hw/arm/rp2040.h        |   3 +
 include/hw/misc/rp2040_pads.h  |  42 +++++
 tests/qtest/meson.build        |   9 +-
 tests/qtest/rp2040-pads-test.c | 102 +++++++++++
 7 files changed, 472 insertions(+), 6 deletions(-)
 create mode 100644 hw/misc/rp2040_pads.c
 create mode 100644 include/hw/misc/rp2040_pads.h
 create mode 100644 tests/qtest/rp2040-pads-test.c

diff --git a/hw/arm/rp2040.c b/hw/arm/rp2040.c
index 140c73ae78..15a5cb0d3f 100644
--- a/hw/arm/rp2040.c
+++ b/hw/arm/rp2040.c
@@ -50,8 +50,6 @@ static const struct {
 } rp2040_unimplemented[] = {
     { "rp2040.iobank0",  0x40014000, 0x4000 },
     { "rp2040.ioqspi",   0x40018000, 0x4000 },
-    { "rp2040.padsbank0", 0x4001c000, 0x4000 },
-    { "rp2040.padsqspi", 0x40020000, 0x4000 },
     { "rp2040.busctrl",  0x40030000, 0x4000 },
     { "rp2040.uart0_aliases", 0x40035000, 0x3000 },
     { "rp2040.uart1_aliases", 0x40039000, 0x3000 },
@@ -132,6 +130,10 @@ static void rp2040_soc_init(Object *obj)
     }
 
     object_initialize_child(obj, "clocks", &s->clocks, TYPE_RP2040_CLOCKS);
+    object_initialize_child(obj, "pads-bank0", &s->pads_bank0,
+                            TYPE_RP2040_PADS_BANK0);
+    object_initialize_child(obj, "pads-qspi", &s->pads_qspi,
+                            TYPE_RP2040_PADS_QSPI);
 
     object_initialize_child(obj, "pll-sys", &s->pll_sys, TYPE_RP2040_PLL);
     qdev_prop_set_string(DEVICE(&s->pll_sys), "trace-name",
@@ -333,6 +335,18 @@ static void rp2040_soc_realize(DeviceState *dev, Error **errp)
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->vreg), 0, RP2040_VREG_BASE);
 
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->pads_bank0), errp)) {
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->pads_bank0), 0,
+                    RP2040_PADS_BANK0_BASE);
+
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->pads_qspi), errp)) {
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->pads_qspi), 0,
+                    RP2040_PADS_QSPI_BASE);
+
     qdev_connect_clock_in(DEVICE(&s->watchdog), "clk-ref",
                           qdev_get_clock_out(DEVICE(&s->clocks), "clk-ref"));
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->watchdog), errp)) {
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index e03f45d667..0c5f8f2b4a 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -99,6 +99,7 @@ system_ss.add(when: 'CONFIG_RASPI', if_true: files(
   'bcm2835_powermgt.c',
 ))
 system_ss.add(when: 'CONFIG_RP2040', if_true: files('rp2040_clocks.c'))
+system_ss.add(when: 'CONFIG_RP2040', if_true: files('rp2040_pads.c'))
 system_ss.add(when: 'CONFIG_RP2040', if_true: files('rp2040_pll.c'))
 system_ss.add(when: 'CONFIG_RP2040', if_true: files('rp2040_psm.c'))
 system_ss.add(when: 'CONFIG_RP2040', if_true: files('rp2040_resets.c'))
diff --git a/hw/misc/rp2040_pads.c b/hw/misc/rp2040_pads.c
new file mode 100644
index 0000000000..d2a02530a7
--- /dev/null
+++ b/hw/misc/rp2040_pads.c
@@ -0,0 +1,303 @@
+/*
+ * RP2040 pad control emulation
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/misc/rp2040_pads.h"
+#include "hw/misc/rp2040.h"
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
+            qemu_log_mask(LOG_UNIMP,
+                      "%s: unimplemented read at offset 0x%"
+                      HWADDR_PRIx "\n", __func__, addr & 0xfff);
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
+    hwaddr alias = addr & RP2040_ATOMIC_ALIAS_MASK;
+    hwaddr offset = addr & 0xfff;
+    unsigned index;
+    uint32_t value = value64;
+
+    switch (offset) {
+    case PADS_BANK0_VOLTAGE_SELECT:
+        s->voltage_select =
+            rp2040_atomic_update(s->voltage_select, value, alias) &
+            PADS_VOLTAGE_SELECT_MASK;
+        break;
+    case PADS_BANK0_SWCLK:
+        s->swclk = rp2040_atomic_update(s->swclk, value, alias) &
+                   PADS_PAD_MASK;
+        break;
+    case PADS_BANK0_SWD:
+        s->swd = rp2040_atomic_update(s->swd, value, alias) &
+                 PADS_PAD_MASK;
+        break;
+    default:
+        if (rp2040_pads_bank0_gpio_offset(offset, &index)) {
+            s->gpio[index] = rp2040_atomic_update(s->gpio[index], value,
+                                                     alias) & PADS_PAD_MASK;
+        } else {
+            qemu_log_mask(LOG_UNIMP,
+                      "%s: unimplemented write at offset 0x%"
+                      HWADDR_PRIx "\n", __func__, addr & 0xfff);
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
+            qemu_log_mask(LOG_UNIMP,
+                      "%s: unimplemented read at offset 0x%"
+                      HWADDR_PRIx "\n", __func__, addr & 0xfff);
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
+    hwaddr alias = addr & RP2040_ATOMIC_ALIAS_MASK;
+    hwaddr offset = addr & 0xfff;
+    unsigned index;
+    uint32_t value = value64;
+
+    switch (offset) {
+    case PADS_QSPI_VOLTAGE_SELECT:
+        s->voltage_select =
+            rp2040_atomic_update(s->voltage_select, value, alias) &
+            PADS_VOLTAGE_SELECT_MASK;
+        break;
+    default:
+        if (rp2040_pads_qspi_pad_offset(offset, &index)) {
+            s->pad[index] = rp2040_atomic_update(s->pad[index], value,
+                                                    alias) & PADS_PAD_MASK;
+        } else {
+            qemu_log_mask(LOG_UNIMP,
+                      "%s: unimplemented write at offset 0x%"
+                      HWADDR_PRIx "\n", __func__, addr & 0xfff);
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
diff --git a/include/hw/arm/rp2040.h b/include/hw/arm/rp2040.h
index c3c6419613..42eb3c8fca 100644
--- a/include/hw/arm/rp2040.h
+++ b/include/hw/arm/rp2040.h
@@ -14,6 +14,7 @@
 #include "hw/core/clock.h"
 #include "hw/core/sysbus.h"
 #include "hw/misc/rp2040_clocks.h"
+#include "hw/misc/rp2040_pads.h"
 #include "hw/misc/rp2040_pll.h"
 #include "hw/misc/rp2040_psm.h"
 #include "hw/misc/rp2040_resets.h"
@@ -47,6 +48,8 @@ struct RP2040State {
     ARMv7MState armv7m[RP2040_NUM_CORES];
     PL011State uart[2];
     RP2040ClocksState clocks;
+    RP2040PadsBank0State pads_bank0;
+    RP2040PadsQspiState pads_qspi;
     RP2040PllState pll_sys;
     RP2040PllState pll_usb;
     RP2040PsmState psm;
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
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 18120f17bf..26ed04bc51 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -264,10 +264,11 @@ qtests_arm = \
   (config_all_devices.has_key('CONFIG_MICROBIT') ? ['microbit-test'] : []) + \
   (config_all_devices.has_key('CONFIG_RP2040') ?
    ['rp2040-syscfg-test',
-    'rp2040-sysinfo-test',
-     'rp2040-clocks-test',
-     'rp2040-resets-test',
-     'rp2040-rosc-test',
+     'rp2040-sysinfo-test',
+    'rp2040-clocks-test',
+    'rp2040-pads-test',
+    'rp2040-resets-test',
+    'rp2040-rosc-test',
     'rp2040-tbman-test',
     'rp2040-vreg-test',
     'rp2040-watchdog-test'] : []) + \
diff --git a/tests/qtest/rp2040-pads-test.c b/tests/qtest/rp2040-pads-test.c
new file mode 100644
index 0000000000..f606e60dec
--- /dev/null
+++ b/tests/qtest/rp2040-pads-test.c
@@ -0,0 +1,102 @@
+/*
+ * QTest testcase for the RP2040 pad controls.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+#include "hw/misc/rp2040.h"
+
+#define PADS_BANK0_BASE       0x4001c000
+#define PADS_BANK0_VOLTAGE    0x00
+#define PADS_BANK0_GPIO0      0x04
+#define PADS_BANK0_GPIO29     0x78
+#define PADS_BANK0_SWCLK      0x7c
+#define PADS_BANK0_SWD        0x80
+
+#define PADS_QSPI_BASE        0x40020000
+#define PADS_QSPI_VOLTAGE     0x00
+#define PADS_QSPI_SCLK        0x04
+#define PADS_QSPI_SD0         0x08
+#define PADS_QSPI_SD3         0x14
+#define PADS_QSPI_SS          0x18
+
+static QTestState *rp2040_pads_start(void)
+{
+    return qtest_init("-machine raspi-pico");
+}
+
+static void test_bank0(void)
+{
+    QTestState *qts = rp2040_pads_start();
+
+    g_assert_cmphex(qtest_readl(qts, PADS_BANK0_BASE +
+                                PADS_BANK0_VOLTAGE), ==, 0);
+    g_assert_cmphex(qtest_readl(qts, PADS_BANK0_BASE + PADS_BANK0_GPIO0),
+                    ==, 0x56);
+    g_assert_cmphex(qtest_readl(qts, PADS_BANK0_BASE + PADS_BANK0_GPIO29),
+                    ==, 0x56);
+    g_assert_cmphex(qtest_readl(qts, PADS_BANK0_BASE + PADS_BANK0_SWCLK),
+                    ==, 0x5a);
+    g_assert_cmphex(qtest_readl(qts, PADS_BANK0_BASE + PADS_BANK0_SWD),
+                    ==, 0x5a);
+
+    qtest_writel(qts, PADS_BANK0_BASE + PADS_BANK0_VOLTAGE, 0xffffffff);
+    g_assert_cmphex(qtest_readl(qts, PADS_BANK0_BASE +
+                                PADS_BANK0_VOLTAGE), ==, 1);
+
+    qtest_writel(qts, PADS_BANK0_BASE + PADS_BANK0_GPIO0, 0x12);
+    qtest_writel(qts, PADS_BANK0_BASE + RP2040_ATOMIC_SET + PADS_BANK0_GPIO0,
+                 0x81);
+    g_assert_cmphex(qtest_readl(qts, PADS_BANK0_BASE + PADS_BANK0_GPIO0),
+                    ==, 0x93);
+    qtest_writel(qts, PADS_BANK0_BASE + RP2040_ATOMIC_CLR + PADS_BANK0_GPIO0,
+                 0x11);
+    g_assert_cmphex(qtest_readl(qts, PADS_BANK0_BASE + PADS_BANK0_GPIO0),
+                    ==, 0x82);
+    qtest_writel(qts, PADS_BANK0_BASE + RP2040_ATOMIC_XOR + PADS_BANK0_GPIO0,
+                 0x03);
+    g_assert_cmphex(qtest_readl(qts, PADS_BANK0_BASE + PADS_BANK0_GPIO0),
+                    ==, 0x81);
+
+    qtest_quit(qts);
+}
+
+static void test_qspi(void)
+{
+    QTestState *qts = rp2040_pads_start();
+
+    g_assert_cmphex(qtest_readl(qts, PADS_QSPI_BASE + PADS_QSPI_VOLTAGE),
+                    ==, 0);
+    g_assert_cmphex(qtest_readl(qts, PADS_QSPI_BASE + PADS_QSPI_SCLK),
+                    ==, 0x56);
+    g_assert_cmphex(qtest_readl(qts, PADS_QSPI_BASE + PADS_QSPI_SD0),
+                    ==, 0x52);
+    g_assert_cmphex(qtest_readl(qts, PADS_QSPI_BASE + PADS_QSPI_SD3),
+                    ==, 0x52);
+    g_assert_cmphex(qtest_readl(qts, PADS_QSPI_BASE + PADS_QSPI_SS),
+                    ==, 0x5a);
+
+    qtest_writel(qts, PADS_QSPI_BASE + PADS_QSPI_SS, 0xffffffff);
+    g_assert_cmphex(qtest_readl(qts, PADS_QSPI_BASE + PADS_QSPI_SS),
+                    ==, 0xff);
+    qtest_writel(qts, PADS_QSPI_BASE + RP2040_ATOMIC_CLR + PADS_QSPI_SS, 0x0f);
+    g_assert_cmphex(qtest_readl(qts, PADS_QSPI_BASE + PADS_QSPI_SS),
+                    ==, 0xf0);
+    qtest_writel(qts, PADS_QSPI_BASE + RP2040_ATOMIC_XOR + PADS_QSPI_SS, 0x33);
+    g_assert_cmphex(qtest_readl(qts, PADS_QSPI_BASE + PADS_QSPI_SS),
+                    ==, 0xc3);
+
+    qtest_quit(qts);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_func("/rp2040-pads/bank0", test_bank0);
+    qtest_add_func("/rp2040-pads/qspi", test_qspi);
+
+    return g_test_run();
+}
-- 
2.55.0


