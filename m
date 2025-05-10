Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECEDDC3ABBE
	for <qemu-devel@archiver.kernel.org>; Sat, 10 May 2025 06:58:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDe8K-0001k2-In; Sat, 10 May 2025 02:56:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcksn@duck.com>) id 1uDbhl-0006Ca-GQ
 for qemu-devel@nongnu.org; Sat, 10 May 2025 00:20:53 -0400
Received: from smtpa-outbound2.duck.com ([20.13.235.192])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcksn@duck.com>) id 1uDbhh-0004nM-Rc
 for qemu-devel@nongnu.org; Sat, 10 May 2025 00:20:53 -0400
Subject: [PATCH 2/6] MAX78000: ICC Implementation
References: <20250510042043.2056265-1-jcksn@duck.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: /
X-Rspamd-Report: R_MISSING_CHARSET(0.5) DMARC_POLICY_ALLOW(-0.5)
 R_DKIM_ALLOW(-0.2) MIME_GOOD(-0.1) R_SPF_ALLOW(-0.2) MID_RHS_MATCH_TO(1)
X-Rspamd-Score: 0.5
X-Rspamd-Action: no action
To: qemu-devel@nongnu.org
Cc: alistair@alistair.me
Received: by smtp-inbound1.duck.com; Sat, 10 May 2025 00:20:48 -0400
Message-ID: <6804E8E6-60B9-40EB-B745-A581491C5DA9.1@smtp-inbound1.duck.com>
Date: Sat, 10 May 2025 00:20:48 -0400
From: jcksn@duck.com
Feedback-ID: :isSendReply:isDirect:duckcom
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duck.com;
 h=Feedback-ID: From: Date: Message-ID: Cc: To: Content-Transfer-Encoding:
 MIME-Version: References: Subject; q=dns/txt; s=postal-KpyQVw;
 t=1746850849; bh=T3CNylW9YmvmJiLYWAVXlKnZJAcSFZS1zhzw05Cs904=;
 b=stqZivlIsDdApGD4OJ8tJkULN0Ks3Lnd5qvukdr3EKqXxgEYk3aCXkEPUA4OxAYsjiAUgiHDI
 C+HGHz0eQfcelPwTtooGrqBtuDLKzs6X6Q2DgNBjyLiO9odr0njd3LfcFoBQDgdx3RzvtAz2ECp
 plhkpZPvmTfudALRezo884A=
Received-SPF: pass client-ip=20.13.235.192; envelope-from=jcksn@duck.com;
 helo=smtpa-outbound2.duck.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 10 May 2025 02:56:27 -0400
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This patch implements the Instruction Cache Controller for the MAX78000 SOC

Signed-off-by: Jackson Donaldson <jcksn@duck.com>
---
 hw/arm/Kconfig                 |  1 +
 hw/arm/max78000_soc.c          | 20 ++++++--
 hw/misc/Kconfig                |  3 ++
 hw/misc/max78000_icc.c         | 89 ++++++++++++++++++++++++++++++++++
 hw/misc/meson.build            |  1 +
 include/hw/arm/max78000_soc.h  |  6 +++
 include/hw/misc/max78000_icc.h | 34 +++++++++++++
 7 files changed, 150 insertions(+), 4 deletions(-)
 create mode 100644 hw/misc/max78000_icc.c
 create mode 100644 include/hw/misc/max78000_icc.h

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 1c365d1115..3f23af3244 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -367,6 +367,7 @@ config ALLWINNER_R40
 config MAX78000_SOC
     bool
     select ARM_V7M
+    select MAX78000_ICC
 
 config RASPI
     bool
diff --git a/hw/arm/max78000_soc.c b/hw/arm/max78000_soc.c
index 64578438bd..4d598bddd4 100644
--- a/hw/arm/max78000_soc.c
+++ b/hw/arm/max78000_soc.c
@@ -16,12 +16,19 @@
 #include "hw/qdev-clock.h"
 #include "hw/misc/unimp.h"
 
+static const uint32_t max78000_icc_addr[] = {0x4002a000, 0x4002a800};
+
 static void max78000_soc_initfn(Object *obj)
 {
     MAX78000State *s = MAX78000_SOC(obj);
+    int i;
 
     object_initialize_child(obj, "armv7m", &s->armv7m, TYPE_ARMV7M);
 
+    for (i = 0; i < MAX78000_NUM_ICC; i++) {
+        object_initialize_child(obj, "icc[*]", &s->icc[i], TYPE_MAX78000_ICC);
+    }
+
     s->sysclk = qdev_init_clock_in(DEVICE(s), "sysclk", NULL, NULL, 0);
     s->refclk = qdev_init_clock_in(DEVICE(s), "refclk", NULL, NULL, 0);
 }
@@ -30,8 +37,9 @@ static void max78000_soc_realize(DeviceState *dev_soc, Error **errp)
 {
     MAX78000State *s = MAX78000_SOC(dev_soc);
     MemoryRegion *system_memory = get_system_memory();
-    DeviceState *armv7m;
+    DeviceState *dev, *armv7m;
     Error *err = NULL;
+    int i;
 
     /*
      * We use s->refclk internally and only define it with qdev_init_clock_in()
@@ -87,6 +95,13 @@ static void max78000_soc_realize(DeviceState *dev_soc, Error **errp)
         return;
     }
 
+    for (i = 0; i < MAX78000_NUM_ICC; i++) {
+        dev = DEVICE(&(s->icc[i]));
+        sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), errp);
+        sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, max78000_icc_addr[i]);
+    }
+
+
     create_unimplemented_device("globalControl",    0x40000000, 0x400);
     create_unimplemented_device("systemInterface",  0x40000400, 0x400);
     create_unimplemented_device("functionControl",  0x40000800, 0x3400);
@@ -120,9 +135,6 @@ static void max78000_soc_realize(DeviceState *dev_soc, Error **errp)
     create_unimplemented_device("standardDMA",      0x40028000, 0x1000);
     create_unimplemented_device("flashController0", 0x40029000, 0x400);
 
-    create_unimplemented_device("icc0",             0x4002a000, 0x800);
-    create_unimplemented_device("icc1",             0x4002a800, 0x800);
-
     create_unimplemented_device("adc",              0x40034000, 0x1000);
     create_unimplemented_device("pulseTrainEngine", 0x4003c000, 0xa0);
     create_unimplemented_device("oneWireMaster",    0x4003d000, 0x1000);
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index ec0fa5aa9f..781bcf74cc 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -47,6 +47,9 @@ config A9SCU
 config ARM11SCU
     bool
 
+config MAX78000_ICC
+    bool
+
 config MOS6522
     bool
 
diff --git a/hw/misc/max78000_icc.c b/hw/misc/max78000_icc.c
new file mode 100644
index 0000000000..3eacf6bd1b
--- /dev/null
+++ b/hw/misc/max78000_icc.c
@@ -0,0 +1,89 @@
+/*
+ * MAX78000 Instruction Cache
+ *
+ * Copyright (c) 2025 Jackson Donaldson <jcksn@duck.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "trace.h"
+#include "hw/irq.h"
+#include "migration/vmstate.h"
+#include "hw/misc/max78000_icc.h"
+
+
+static uint64_t max78000_icc_read(void *opaque, hwaddr addr,
+                                    unsigned int size)
+{
+    Max78000IccState *s = opaque;
+    switch (addr) {
+        case ICC_INFO:{
+            return s->info;
+        }
+        case ICC_SZ:{
+            return s->sz;
+        }
+        case ICC_CTRL:{
+            return s->ctrl;
+        }
+        case ICC_INVALIDATE:{
+            return s->invalidate;
+        }
+        default:{
+            return 0;
+        }
+    }
+}
+
+static void max78000_icc_write(void *opaque, hwaddr addr,
+                    uint64_t val64, unsigned int size)
+{
+    Max78000IccState *s = opaque;
+
+    switch (addr) {
+        case ICC_CTRL:{
+        s->ctrl = 0x10000 + (val64 & 1);
+        break;
+        }
+        case ICC_INVALIDATE:{
+        s->ctrl = s->ctrl | 0x80;
+        }
+    }
+}
+
+static const MemoryRegionOps stm32f4xx_exti_ops = {
+    .read = max78000_icc_read,
+    .write = max78000_icc_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+};
+
+static void max78000_icc_init(Object *obj)
+{
+    Max78000IccState *s = MAX78000_ICC(obj);
+    s->info = 0;
+    s->sz = 0x10000010;
+    s->ctrl = 0x10000;
+    s->invalidate = 0;
+
+
+    memory_region_init_io(&s->mmio, obj, &stm32f4xx_exti_ops, s,
+                        TYPE_MAX78000_ICC, 0x800);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
+
+}
+
+static const TypeInfo max78000_icc_info = {
+    .name          = TYPE_MAX78000_ICC,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(Max78000IccState),
+    .instance_init = max78000_icc_init,
+};
+
+static void max78000_icc_register_types(void)
+{
+    type_register_static(&max78000_icc_info);
+}
+
+type_init(max78000_icc_register_types)
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 6d47de482c..a21a994ff8 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -70,6 +70,7 @@ system_ss.add(when: 'CONFIG_IMX', if_true: files(
   'imx_ccm.c',
   'imx_rngc.c',
 ))
+system_ss.add(when: 'CONFIG_MAX78000_ICC', if_true: files('max78000_icc.c'))
 system_ss.add(when: 'CONFIG_NPCM7XX', if_true: files(
   'npcm_clk.c',
   'npcm_gcr.c',
diff --git a/include/hw/arm/max78000_soc.h b/include/hw/arm/max78000_soc.h
index 0e6def295d..207a4da68a 100644
--- a/include/hw/arm/max78000_soc.h
+++ b/include/hw/arm/max78000_soc.h
@@ -11,6 +11,7 @@
 
 #include "hw/or-irq.h"
 #include "hw/arm/armv7m.h"
+#include "hw/misc/max78000_icc.h"
 #include "qom/object.h"
 
 #define TYPE_MAX78000_SOC "max78000-soc"
@@ -21,6 +22,9 @@ OBJECT_DECLARE_SIMPLE_TYPE(MAX78000State, MAX78000_SOC)
 #define SRAM_BASE_ADDRESS 0x20000000
 #define SRAM_SIZE (128 * 1024)
 
+/* The MAX78k has 2 instruction caches; only icc0 matters, icc1 is for RISC */
+#define MAX78000_NUM_ICC 2
+
 struct MAX78000State {
     SysBusDevice parent_obj;
 
@@ -29,6 +33,8 @@ struct MAX78000State {
     MemoryRegion sram;
     MemoryRegion flash;
 
+    Max78000IccState icc[MAX78000_NUM_ICC];
+
     Clock *sysclk;
     Clock *refclk;
 };
diff --git a/include/hw/misc/max78000_icc.h b/include/hw/misc/max78000_icc.h
new file mode 100644
index 0000000000..fe9228e25d
--- /dev/null
+++ b/include/hw/misc/max78000_icc.h
@@ -0,0 +1,34 @@
+/*
+ * MAX78000 Instruction Cache
+ *
+ * Copyright (c) 2025 Jackson Donaldson <jcksn@duck.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_MAX78000_ICC_H
+#define HW_MAX78000_ICC_H
+
+#include "hw/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_MAX78000_ICC "max78000-icc"
+OBJECT_DECLARE_SIMPLE_TYPE(Max78000IccState, MAX78000_ICC)
+
+#define ICC_INFO       0x0
+#define ICC_SZ         0x4
+#define ICC_CTRL       0x100
+#define ICC_INVALIDATE 0x700
+
+struct Max78000IccState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion mmio;
+
+    uint32_t info;
+    uint32_t sz;
+    uint32_t ctrl;
+    uint32_t invalidate;
+};
+
+#endif
-- 
2.34.1


