Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B8EBC3ABCB
	for <qemu-devel@archiver.kernel.org>; Sat, 10 May 2025 06:57:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDe8P-0001l4-Dn; Sat, 10 May 2025 02:56:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcksn@duck.com>) id 1uDbhn-0006D7-5z
 for qemu-devel@nongnu.org; Sat, 10 May 2025 00:20:55 -0400
Received: from smtpa-outbound3.duck.com ([20.13.235.199])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcksn@duck.com>) id 1uDbhk-0004nW-R7
 for qemu-devel@nongnu.org; Sat, 10 May 2025 00:20:54 -0400
Subject: [PATCH 5/6] MAX78000 TRNG Implementation
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
Received: by smtp-inbound1.duck.com; Sat, 10 May 2025 00:20:51 -0400
Message-ID: <D705B9CD-82EC-42AF-A370-21038E35BDC1.1@smtp-inbound1.duck.com>
Date: Sat, 10 May 2025 00:20:51 -0400
From: jcksn@duck.com
Feedback-ID: :isSendReply:isDirect:duckcom
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duck.com;
 h=Feedback-ID: From: Date: Message-ID: Cc: To: Content-Transfer-Encoding:
 MIME-Version: References: Subject; q=dns/txt; s=postal-KpyQVw;
 t=1746850851; bh=icE/aziDt0qTUNqGrR0Gps4lrgomszqCnDvAKVlwvtE=;
 b=rssmRWLzjX2nECdEN18Byx9pAchWAfcZhMpFJWuZZekFjyXVKuHqdSYGosUserqdmncYavGMG
 7MwnKdBkS+MW3Sw028sA087Ym6mFOyHItH3WUJH15hO1Bemt49cBlJq9/zFw6dnW0pb2eMvFx3L
 scd7h6ITUvYn4fsh1/eVmUg=
Received-SPF: pass client-ip=20.13.235.199; envelope-from=jcksn@duck.com;
 helo=smtpa-outbound3.duck.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 10 May 2025 02:56:32 -0400
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

This patch implements the True Random Number Generator for the MAX78000 SOC

Signed-off-by: Jackson Donaldson <jcksn@duck.com>
---
 hw/arm/Kconfig                  |   1 +
 hw/arm/max78000_soc.c           |   9 ++-
 hw/misc/Kconfig                 |   3 +
 hw/misc/max78000_gcr.c          |   3 +
 hw/misc/max78000_trng.c         | 115 ++++++++++++++++++++++++++++++++
 hw/misc/meson.build             |   1 +
 include/hw/arm/max78000_soc.h   |   2 +
 include/hw/misc/max78000_trng.h |  35 ++++++++++
 8 files changed, 168 insertions(+), 1 deletion(-)
 create mode 100644 hw/misc/max78000_trng.c
 create mode 100644 include/hw/misc/max78000_trng.h

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 211b201629..c13ddc980a 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -370,6 +370,7 @@ config MAX78000_SOC
     select MAX78000_ICC
     select MAX78000_UART
     select MAX78000_GCR
+    select MAX78000_TRNG
 
 config RASPI
     bool
diff --git a/hw/arm/max78000_soc.c b/hw/arm/max78000_soc.c
index 7a012c6ef7..6809d4e249 100644
--- a/hw/arm/max78000_soc.c
+++ b/hw/arm/max78000_soc.c
@@ -39,6 +39,8 @@ static void max78000_soc_initfn(Object *obj)
         object_initialize_child(obj, "uart[*]", &s->uart[i], TYPE_MAX78000_UART);
     }
 
+    object_initialize_child(obj, "trng", &s->trng, TYPE_MAX78000_TRNG);
+
     s->sysclk = qdev_init_clock_in(DEVICE(s), "sysclk", NULL, NULL, 0);
     s->refclk = qdev_init_clock_in(DEVICE(s), "refclk", NULL, NULL, 0);
 }
@@ -130,6 +132,11 @@ static void max78000_soc_realize(DeviceState *dev_soc, Error **errp)
                                                        max78000_uart_irq[i]));
     }
 
+    dev = DEVICE(&s->trng);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), errp);
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0x4004d000);
+    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, qdev_get_gpio_in(armv7m, 4));
+    dev->id = g_strdup("trng");
 
     create_unimplemented_device("systemInterface",  0x40000400, 0x400);
     create_unimplemented_device("functionControl",  0x40000800, 0x3400);
@@ -169,7 +176,7 @@ static void max78000_soc_realize(DeviceState *dev_soc, Error **errp)
     create_unimplemented_device("semaphore",        0x4003e000, 0x1000);
 
     create_unimplemented_device("spi1",             0x40046000, 0x2000);
-    create_unimplemented_device("trng",             0x4004d000, 0x1000);
+
     create_unimplemented_device("i2s",              0x40060000, 0x1000);
     create_unimplemented_device("lowPowerControl",  0x40080000, 0x400);
     create_unimplemented_device("gpio2",            0x40080400, 0x200);
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index fde2266b8f..dd6a6e54da 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -53,6 +53,9 @@ config MAX78000_GCR
 config MAX78000_ICC
     bool
 
+config MAX78000_TRNG
+    bool
+
 config MOS6522
     bool
 
diff --git a/hw/misc/max78000_gcr.c b/hw/misc/max78000_gcr.c
index 657b7fc490..a469d7a489 100644
--- a/hw/misc/max78000_gcr.c
+++ b/hw/misc/max78000_gcr.c
@@ -161,6 +161,9 @@ static void max78000_gcr_write(void *opaque, hwaddr addr,
             if (val & UART0_RESET) {
                 max78000_gcr_reset_device("uart0");
             }
+            if (val & TRNG_RESET) {
+                max78000_gcr_reset_device("trng");
+            }
             /* TODO: As other devices are implemented, add them here */
             break;
         }
diff --git a/hw/misc/max78000_trng.c b/hw/misc/max78000_trng.c
new file mode 100644
index 0000000000..bdfaa75bd4
--- /dev/null
+++ b/hw/misc/max78000_trng.c
@@ -0,0 +1,115 @@
+/*
+ * MAX78000 True Random Number Generator
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
+#include "hw/misc/max78000_trng.h"
+#include "crypto/random.h"
+
+static uint64_t max78000_trng_read(void *opaque, hwaddr addr,
+                                    unsigned int size)
+{
+    uint8_t buf[4];
+    Error *errp = NULL;
+
+    Max78000TrngState *s = opaque;
+    switch (addr) {
+        case CTRL:{
+            return s->ctrl;
+        }
+        case STATUS:{
+            return 1;
+        }
+        case DATA:{
+            qcrypto_random_bytes(buf, 4, &errp);
+            return *(uint32_t *)buf;
+        }
+        default:{
+            qemu_log_mask(LOG_GUEST_ERROR, "[%s]%s: Bad register at offset 0x%"
+                HWADDR_PRIx "\n", TYPE_MAX78000_TRNG, __func__, addr);
+            break;
+        }
+    }
+    return 0;
+}
+
+static void max78000_trng_write(void *opaque, hwaddr addr,
+                    uint64_t val64, unsigned int size)
+{
+    Max78000TrngState *s = opaque;
+    uint32_t val = val64;
+    switch (addr) {
+        case CTRL:{
+            /* TODO: implement AES keygen */
+            s->ctrl = val;
+            if (val & RND_IE) {
+                qemu_set_irq(s->irq, 1);
+            } else{
+                qemu_set_irq(s->irq, 0);
+            }
+            break;
+        }
+        default:{
+            qemu_log_mask(LOG_GUEST_ERROR, "[%s]%s: Bad register at offset 0x%"
+                HWADDR_PRIx "\n", TYPE_MAX78000_TRNG, __func__, addr);
+            break;
+        }
+
+    }
+}
+
+static void max78000_trng_reset_hold(Object *obj, ResetType type)
+{
+    Max78000TrngState *s = MAX78000_TRNG(obj);
+    s->ctrl = 0;
+    s->status = 0;
+    s->data = 0;
+}
+
+static const MemoryRegionOps max78000_trng_ops = {
+    .read = max78000_trng_read,
+    .write = max78000_trng_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+};
+
+static void max78000_trng_init(Object *obj)
+{
+    Max78000TrngState *s = MAX78000_TRNG(obj);
+    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq);
+
+    memory_region_init_io(&s->mmio, obj, &max78000_trng_ops, s,
+                        TYPE_MAX78000_TRNG, 0x1000);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
+
+}
+
+static void max78000_trng_class_init(ObjectClass *klass, const void *data)
+{
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    rc->phases.hold = max78000_trng_reset_hold;
+
+}
+
+static const TypeInfo max78000_trng_info = {
+    .name          = TYPE_MAX78000_TRNG,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(Max78000TrngState),
+    .instance_init = max78000_trng_init,
+    .class_init    = max78000_trng_class_init,
+};
+
+static void max78000_trng_register_types(void)
+{
+    type_register_static(&max78000_trng_info);
+}
+
+type_init(max78000_trng_register_types)
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 283d06dad4..c7c57d924b 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -72,6 +72,7 @@ system_ss.add(when: 'CONFIG_IMX', if_true: files(
 ))
 system_ss.add(when: 'CONFIG_MAX78000_GCR', if_true: files('max78000_gcr.c'))
 system_ss.add(when: 'CONFIG_MAX78000_ICC', if_true: files('max78000_icc.c'))
+system_ss.add(when: 'CONFIG_MAX78000_TRNG', if_true: files('max78000_trng.c'))
 system_ss.add(when: 'CONFIG_NPCM7XX', if_true: files(
   'npcm_clk.c',
   'npcm_gcr.c',
diff --git a/include/hw/arm/max78000_soc.h b/include/hw/arm/max78000_soc.h
index 8b9e3052cd..936825399c 100644
--- a/include/hw/arm/max78000_soc.h
+++ b/include/hw/arm/max78000_soc.h
@@ -14,6 +14,7 @@
 #include "hw/misc/max78000_gcr.h"
 #include "hw/misc/max78000_icc.h"
 #include "hw/char/max78000_uart.h"
+#include "hw/misc/max78000_trng.h"
 #include "qom/object.h"
 
 #define TYPE_MAX78000_SOC "max78000-soc"
@@ -39,6 +40,7 @@ struct MAX78000State {
     Max78000GcrState gcr;
     Max78000IccState icc[MAX78000_NUM_ICC];
     Max78000UartState uart[MAX78000_NUM_UART];
+    Max78000TrngState trng;
 
     Clock *sysclk;
     Clock *refclk;
diff --git a/include/hw/misc/max78000_trng.h b/include/hw/misc/max78000_trng.h
new file mode 100644
index 0000000000..c5a8129b6a
--- /dev/null
+++ b/include/hw/misc/max78000_trng.h
@@ -0,0 +1,35 @@
+/*
+ * MAX78000 True Random Number Generator
+ *
+ * Copyright (c) 2025 Jackson Donaldson <jcksn@duck.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef HW_MAX78000_TRNG_H
+#define HW_MAX78000_TRNG_H
+
+#include "hw/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_MAX78000_TRNG "max78000-trng"
+OBJECT_DECLARE_SIMPLE_TYPE(Max78000TrngState, MAX78000_TRNG)
+
+#define CTRL 0
+#define STATUS 4
+#define DATA 8
+
+#define RND_IE (1 << 1)
+
+struct Max78000TrngState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion mmio;
+
+    uint32_t ctrl;
+    uint32_t status;
+    uint32_t data;
+
+    qemu_irq irq;
+};
+
+#endif
-- 
2.34.1


