Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78BAFE95374
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 10:37:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnaBm-0001ks-8p; Wed, 04 Feb 2026 05:32:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vnaBh-0001aw-0d
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 05:32:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vnaBa-00045v-Op
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 05:32:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770201158;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yJFfhx1yxnbOJdrUjWgaDSrpidesWJDQQThgvrEVOp8=;
 b=dvEbub2aOfO03RiJHARQXK1v3lwtPnd29ZoW2WvKtpCnesCmxJG84x7CG5i7Fjq3bG3Iuo
 ZJgZqWAYr3F/XvcwP4+fBCicZq/4CVBMlAbCKqVaxeftO7KAx/f0TrG3NirdptKhaBFui+
 mjiQ3Hrf5h3422QH6UaxaTz7OC6bKOo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-372-nESxsoh6PvKL-w_kGp52kA-1; Wed,
 04 Feb 2026 05:32:36 -0500
X-MC-Unique: nESxsoh6PvKL-w_kGp52kA-1
X-Mimecast-MFC-AGG-ID: nESxsoh6PvKL-w_kGp52kA_1770201155
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 56458180025A; Wed,  4 Feb 2026 10:32:35 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.44])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 85094180035A; Wed,  4 Feb 2026 10:32:33 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Kane Chen <kane_chen@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 26/45] hw/misc: Add basic Aspeed PWM model
Date: Wed,  4 Feb 2026 11:31:17 +0100
Message-ID: <20260204103136.1795455-27-clg@redhat.com>
In-Reply-To: <20260204103136.1795455-1-clg@redhat.com>
References: <20260204103136.1795455-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Kane Chen <kane_chen@aspeedtech.com>

Add an initial PWM model for Aspeed SoCs, including device state,
register definitions, and basic initialization as a sysbus device.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
Link: https://lore.kernel.org/qemu-devel/20260204082113.3955407-4-kane_chen@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/arm/aspeed_soc.h  |   3 +-
 include/hw/misc/aspeed_pwm.h |  30 +++++++++
 hw/misc/aspeed_pwm.c         | 120 +++++++++++++++++++++++++++++++++++
 hw/misc/meson.build          |   1 +
 hw/misc/trace-events         |   4 ++
 5 files changed, 157 insertions(+), 1 deletion(-)
 create mode 100644 include/hw/misc/aspeed_pwm.h
 create mode 100644 hw/misc/aspeed_pwm.c

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index bca10c387b08..7b08cca908b3 100644
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
@@ -88,6 +89,7 @@ struct AspeedSoCState {
     MemoryRegion secsram;
     UnimplementedDeviceState sbc_unimplemented;
     AspeedSDMCState sdmc;
+    AspeedPWMState pwm;
     AspeedWDTState wdt[ASPEED_WDTS_NUM];
     FTGMAC100State ftgmac100[ASPEED_MACS_NUM];
     AspeedMiiState mii[ASPEED_MACS_NUM];
@@ -108,7 +110,6 @@ struct AspeedSoCState {
     UnimplementedDeviceState video;
     UnimplementedDeviceState emmc_boot_controller;
     UnimplementedDeviceState dpmcu;
-    UnimplementedDeviceState pwm;
     UnimplementedDeviceState espi;
     UnimplementedDeviceState udc;
     UnimplementedDeviceState ltpi;
diff --git a/include/hw/misc/aspeed_pwm.h b/include/hw/misc/aspeed_pwm.h
new file mode 100644
index 000000000000..f4104ada2224
--- /dev/null
+++ b/include/hw/misc/aspeed_pwm.h
@@ -0,0 +1,30 @@
+/*
+ * ASPEED PWM Controller
+ *
+ * Copyright (C) 2017-2021 IBM Corp.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef ASPEED_PWM_H
+#define ASPEED_PWM_H
+
+#include "hw/core/sysbus.h"
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
index 000000000000..ee3d5884be22
--- /dev/null
+++ b/hw/misc/aspeed_pwm.c
@@ -0,0 +1,120 @@
+/*
+ * ASPEED PWM Controller
+ *
+ * Copyright (C) 2017-2021 IBM Corp.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
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
index f7f1b0da75c5..d304a984984a 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -138,6 +138,7 @@ system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
   'aspeed_i3c.c',
   'aspeed_lpc.c',
   'aspeed_ltpi.c',
+  'aspeed_pwm.c',
   'aspeed_scu.c',
   'aspeed_sbc.c',
   'aspeed_sdmc.c',
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index 4cee8a2b4541..d6af2fcf8527 100644
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
2.52.0


