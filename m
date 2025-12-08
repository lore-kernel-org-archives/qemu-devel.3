Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E492DD3B7DD
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Dec 2025 07:49:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSVvX-0006nf-9h; Mon, 08 Dec 2025 02:44:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vSVvV-0006n5-RI; Mon, 08 Dec 2025 02:44:57 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vSVvU-0008LH-5p; Mon, 08 Dec 2025 02:44:57 -0500
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 8 Dec
 2025 15:44:38 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 8 Dec 2025 15:44:38 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: <troy_lee@aspeedtech.com>, Kane-Chen-AS <kane_chen@aspeedtech.com>
Subject: [PATCH v3 03/18] hw/misc: Add basic Aspeed PWM model
Date: Mon, 8 Dec 2025 15:44:15 +0800
Message-ID: <20251208074436.1871180-4-kane_chen@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251208074436.1871180-1-kane_chen@aspeedtech.com>
References: <20251208074436.1871180-1-kane_chen@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=kane_chen@aspeedtech.com; helo=TWMBX01.aspeed.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_FAIL=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Kane Chen <kane_chen@aspeedtech.com>
From:  Kane Chen via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Kane-Chen-AS <kane_chen@aspeedtech.com>

Add an initial PWM model for Aspeed SoCs, including device state,
register definitions, and basic initialization as a sysbus device.

Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
---
 include/hw/arm/aspeed_soc.h  |   3 +-
 include/hw/misc/aspeed_pwm.h |  31 +++++++++
 hw/misc/aspeed_pwm.c         | 121 +++++++++++++++++++++++++++++++++++
 hw/misc/meson.build          |   1 +
 hw/misc/trace-events         |   4 ++
 5 files changed, 159 insertions(+), 1 deletion(-)
 create mode 100644 include/hw/misc/aspeed_pwm.h
 create mode 100644 hw/misc/aspeed_pwm.c

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index bca10c387b..5b0680f319 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -28,6 +28,7 @@
 #include "hw/misc/aspeed_hace.h"
 #include "hw/misc/aspeed_sbc.h"
 #include "hw/misc/aspeed_sli.h"
+#include "hw/misc/aspeed_pwm.h"
 #include "hw/watchdog/wdt_aspeed.h"
 #include "hw/net/ftgmac100.h"
 #include "target/arm/cpu.h"
@@ -108,7 +109,7 @@ struct AspeedSoCState {
     UnimplementedDeviceState video;
     UnimplementedDeviceState emmc_boot_controller;
     UnimplementedDeviceState dpmcu;
-    UnimplementedDeviceState pwm;
+    AspeedPWMState pwm;
     UnimplementedDeviceState espi;
     UnimplementedDeviceState udc;
     UnimplementedDeviceState ltpi;
diff --git a/include/hw/misc/aspeed_pwm.h b/include/hw/misc/aspeed_pwm.h
new file mode 100644
index 0000000000..13dc3ea45b
--- /dev/null
+++ b/include/hw/misc/aspeed_pwm.h
@@ -0,0 +1,31 @@
+/*
+ * ASPEED PWM Controller
+ *
+ * Copyright (C) 2017-2021 IBM Corp.
+ *
+ * This code is licensed under the GPL version 2 or later.  See
+ * the COPYING file in the top-level directory.
+ */
+
+#ifndef ASPEED_PWM_H
+#define ASPEED_PWM_H
+
+#include "hw/sysbus.h"
+
+#define TYPE_ASPEED_PWM "aspeed.pwm"
+#define ASPEED_PWM(obj) OBJECT_CHECK(AspeedPWMState, (obj), TYPE_ASPEED_PWM)
+
+#define ASPEED_PWM_NR_REGS (0x10C >> 2)
+
+typedef struct AspeedPWMState {
+    /* <private> */
+    SysBusDevice parent;
+
+    /*< public >*/
+    MemoryRegion iomem;
+    qemu_irq irq;
+
+    uint32_t regs[ASPEED_PWM_NR_REGS];
+} AspeedPWMState;
+
+#endif /* _ASPEED_PWM_H_ */
diff --git a/hw/misc/aspeed_pwm.c b/hw/misc/aspeed_pwm.c
new file mode 100644
index 0000000000..de209274af
--- /dev/null
+++ b/hw/misc/aspeed_pwm.c
@@ -0,0 +1,121 @@
+/*
+ * ASPEED PWM Controller
+ *
+ * Copyright (C) 2017-2021 IBM Corp.
+ *
+ * This code is licensed under the GPL version 2 or later.  See
+ * the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qemu/error-report.h"
+#include "hw/misc/aspeed_pwm.h"
+#include "qapi/error.h"
+#include "migration/vmstate.h"
+
+#include "trace.h"
+
+static uint64_t aspeed_pwm_read(void *opaque, hwaddr addr,
+                                     unsigned int size)
+{
+    AspeedPWMState *s = ASPEED_PWM(opaque);
+    uint64_t val = 0;
+
+    addr >>= 2;
+
+    if (addr >= ASPEED_PWM_NR_REGS) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Out-of-bounds read at offset 0x%" HWADDR_PRIx "\n",
+                      __func__, addr << 2);
+    } else {
+        val = s->regs[addr];
+    }
+
+    trace_aspeed_pwm_read(addr << 2, val);
+
+    return val;
+}
+
+static void aspeed_pwm_write(void *opaque, hwaddr addr, uint64_t data,
+                              unsigned int size)
+{
+    AspeedPWMState *s = ASPEED_PWM(opaque);
+
+    trace_aspeed_pwm_write(addr, data);
+
+    addr >>= 2;
+
+    if (addr >= ASPEED_PWM_NR_REGS) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Out-of-bounds write at offset 0x%" HWADDR_PRIx "\n",
+                      __func__, addr << 2);
+        return;
+    }
+
+    s->regs[addr] = data;
+}
+
+static const MemoryRegionOps aspeed_pwm_ops = {
+    .read = aspeed_pwm_read,
+    .write = aspeed_pwm_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 4,
+    },
+};
+
+static void aspeed_pwm_reset(DeviceState *dev)
+{
+    struct AspeedPWMState *s = ASPEED_PWM(dev);
+
+    memset(s->regs, 0, sizeof(s->regs));
+}
+
+static void aspeed_pwm_realize(DeviceState *dev, Error **errp)
+{
+    AspeedPWMState *s = ASPEED_PWM(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+
+    sysbus_init_irq(sbd, &s->irq);
+
+    memory_region_init_io(&s->iomem, OBJECT(s), &aspeed_pwm_ops, s,
+            TYPE_ASPEED_PWM, 0x1000);
+
+    sysbus_init_mmio(sbd, &s->iomem);
+}
+
+static const VMStateDescription vmstate_aspeed_pwm = {
+    .name = TYPE_ASPEED_PWM,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(regs, AspeedPWMState, ASPEED_PWM_NR_REGS),
+        VMSTATE_END_OF_LIST(),
+    }
+};
+
+static void aspeed_pwm_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = aspeed_pwm_realize;
+    device_class_set_legacy_reset(dc, aspeed_pwm_reset);
+    dc->desc = "Aspeed PWM Controller";
+    dc->vmsd = &vmstate_aspeed_pwm;
+}
+
+static const TypeInfo aspeed_pwm_info = {
+    .name = TYPE_ASPEED_PWM,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(AspeedPWMState),
+    .class_init = aspeed_pwm_class_init,
+};
+
+static void aspeed_pwm_register_types(void)
+{
+    type_register_static(&aspeed_pwm_info);
+}
+
+type_init(aspeed_pwm_register_types);
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 45b16e7797..7afe1d0009 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -137,6 +137,7 @@ system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
   'aspeed_i3c.c',
   'aspeed_lpc.c',
   'aspeed_ltpi.c',
+  'aspeed_pwm.c',
   'aspeed_scu.c',
   'aspeed_sbc.c',
   'aspeed_sdmc.c',
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index eeb9243898..f7870babba 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -299,6 +299,10 @@ aspeed_i3c_write(uint64_t offset, uint64_t data) "I3C write: offset 0x%" PRIx64
 aspeed_i3c_device_read(uint32_t deviceid, uint64_t offset, uint64_t data) "I3C Dev[%u] read: offset 0x%" PRIx64 " data 0x%" PRIx64
 aspeed_i3c_device_write(uint32_t deviceid, uint64_t offset, uint64_t data) "I3C Dev[%u] write: offset 0x%" PRIx64 " data 0x%" PRIx64
 
+# aspeed_pwm.c
+aspeed_pwm_read(uint64_t offset, uint64_t data) "read: offset 0x%" PRIx64 " data 0x%" PRIx64
+aspeed_pwm_write(uint64_t offset, uint64_t data) "write: offset 0x%" PRIx64 " data 0x%" PRIx64
+
 # aspeed_sdmc.c
 aspeed_sdmc_write(uint64_t reg, uint64_t data) "reg @0x%" PRIx64 " data: 0x%" PRIx64
 aspeed_sdmc_read(uint64_t reg, uint64_t data) "reg @0x%" PRIx64 " data: 0x%" PRIx64
-- 
2.43.0


