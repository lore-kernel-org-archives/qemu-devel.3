Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CBDAC3ABCB
	for <qemu-devel@archiver.kernel.org>; Sat, 10 May 2025 06:57:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDe8U-0001mJ-8S; Sat, 10 May 2025 02:56:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcksn@duck.com>) id 1uDbho-0006DQ-3t
 for qemu-devel@nongnu.org; Sat, 10 May 2025 00:20:57 -0400
Received: from smtpa-outbound7.duck.com ([20.13.235.196])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcksn@duck.com>) id 1uDbhl-0004nj-NG
 for qemu-devel@nongnu.org; Sat, 10 May 2025 00:20:55 -0400
Subject: [PATCH 6/6] MAX78000 AES implementation
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
Received: by smtp-inbound1.duck.com; Sat, 10 May 2025 00:20:52 -0400
Message-ID: <023F1975-5689-41BB-97C0-7D5E2D046154.1@smtp-inbound1.duck.com>
Date: Sat, 10 May 2025 00:20:52 -0400
From: jcksn@duck.com
Feedback-ID: :isSendReply:isDirect:duckcom
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duck.com;
 h=Feedback-ID: From: Date: Message-ID: Cc: To: Content-Transfer-Encoding:
 MIME-Version: References: Subject; q=dns/txt; s=postal-KpyQVw;
 t=1746850852; bh=WpWd3WRFSz8Nf1ghZtKMZ8SGpOZi68Cgw9G0zMSdBZQ=;
 b=nOj6FZ6f33U4sZbI/sYBELRZ4vf8J7O0haJjN1nAM1WzHzx28sRv/0HZWnTsVr79c5+BUUPE9
 aACJOfh3XpWAy+h2w6FLIOaiPdk6BaAfi5iw8Dlaa0DiHLrzTy4PU2hYAANLTVzafW9L1PPukMG
 Rt9QLt0tkD6mM241RGJKTLc=
Received-SPF: pass client-ip=20.13.235.196; envelope-from=jcksn@duck.com;
 helo=smtpa-outbound7.duck.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 10 May 2025 02:56:35 -0400
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

This commit implements AES encryption/decryption functionality
for the MAX78000 SOC

Signed-off-by: Jackson Donaldson <jcksn@duck.com>
---
 hw/arm/Kconfig                 |   1 +
 hw/arm/max78000_soc.c          |  12 +-
 hw/misc/Kconfig                |   3 +
 hw/misc/max78000_aes.c         | 215 +++++++++++++++++++++++++++++++++
 hw/misc/max78000_gcr.c         |   9 +-
 hw/misc/meson.build            |   1 +
 include/hw/arm/max78000_soc.h  |   2 +
 include/hw/misc/max78000_aes.h |  68 +++++++++++
 include/hw/misc/max78000_gcr.h |  19 +++
 9 files changed, 326 insertions(+), 4 deletions(-)
 create mode 100644 hw/misc/max78000_aes.c
 create mode 100644 include/hw/misc/max78000_aes.h

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index c13ddc980a..5d38aa0dc3 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -371,6 +371,7 @@ config MAX78000_SOC
     select MAX78000_UART
     select MAX78000_GCR
     select MAX78000_TRNG
+    select MAX78000_AES
 
 config RASPI
     bool
diff --git a/hw/arm/max78000_soc.c b/hw/arm/max78000_soc.c
index 6809d4e249..4b9682afce 100644
--- a/hw/arm/max78000_soc.c
+++ b/hw/arm/max78000_soc.c
@@ -41,6 +41,8 @@ static void max78000_soc_initfn(Object *obj)
 
     object_initialize_child(obj, "trng", &s->trng, TYPE_MAX78000_TRNG);
 
+    object_initialize_child(obj, "aes", &s->aes, TYPE_MAX78000_AES);
+
     s->sysclk = qdev_init_clock_in(DEVICE(s), "sysclk", NULL, NULL, 0);
     s->refclk = qdev_init_clock_in(DEVICE(s), "refclk", NULL, NULL, 0);
 }
@@ -138,6 +140,13 @@ static void max78000_soc_realize(DeviceState *dev_soc, Error **errp)
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, qdev_get_gpio_in(armv7m, 4));
     dev->id = g_strdup("trng");
 
+    dev = DEVICE(&s->aes);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), errp);
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0x40007400);
+    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, qdev_get_gpio_in(armv7m, 5));
+    dev->id = g_strdup("aes");
+
+
     create_unimplemented_device("systemInterface",  0x40000400, 0x400);
     create_unimplemented_device("functionControl",  0x40000800, 0x3400);
     create_unimplemented_device("watchdogTimer0",   0x40003000, 0x400);
@@ -149,9 +158,6 @@ static void max78000_soc_realize(DeviceState *dev_soc, Error **errp)
     create_unimplemented_device("powerSequencer",   0x40006800, 0x400);
     create_unimplemented_device("miscControl",      0x40006c00, 0x800);
 
-    create_unimplemented_device("aes",              0x40007400, 0x400);
-    create_unimplemented_device("aesKey",           0x40007800, 0x800);
-
     create_unimplemented_device("gpio0",            0x40008000, 0x1000);
     create_unimplemented_device("gpio1",            0x40009000, 0x1000);
 
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index dd6a6e54da..c27285b47a 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -47,6 +47,9 @@ config A9SCU
 config ARM11SCU
     bool
 
+config MAX78000_AES
+    bool
+
 config MAX78000_GCR
     bool
 
diff --git a/hw/misc/max78000_aes.c b/hw/misc/max78000_aes.c
new file mode 100644
index 0000000000..9de230fb07
--- /dev/null
+++ b/hw/misc/max78000_aes.c
@@ -0,0 +1,215 @@
+/*
+ * MAX78000 AES
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
+#include "hw/misc/max78000_aes.h"
+#include "crypto/aes.h"
+
+static void max78000_aes_set_status(Max78000AesState *s)
+{
+    s->status = 0;
+    if (s->result_index >= 16) {
+        s->status |= OUTPUT_FULL;
+    }
+    if (s->result_index == 0) {
+        s->status |= OUTPUT_EMPTY;
+    }
+    if (s->data_index >= 16) {
+        s->status |= INPUT_FULL;
+    }
+    if (s->data_index == 0) {
+        s->status |= INPUT_EMPTY;
+    }
+}
+
+static uint64_t max78000_aes_read(void *opaque, hwaddr addr,
+                                    unsigned int size)
+{
+    Max78000AesState *s = opaque;
+    switch (addr) {
+        case CTRL:{
+            return s->ctrl;
+        }
+        case STATUS:{
+            return s->status;
+        }
+        case INTFL:{
+            return s->intfl;
+        }
+        case INTEN:{
+            return s->inten;
+        }
+        case FIFO:{
+            if (s->result_index >= 4) {
+                s->intfl &= ~DONE;
+                s->result_index -= 4;
+                max78000_aes_set_status(s);
+                return (s->result[s->result_index] << 24) +
+                    (s->result[s->result_index + 1] << 16) +
+                    (s->result[s->result_index + 2] << 8) +
+                    s->result[s->result_index + 3];
+            } else{
+                return 0;
+            }
+        }
+        default:{
+            qemu_log_mask(LOG_GUEST_ERROR, "[%s]%s: Bad register at offset 0x%"
+                HWADDR_PRIx "\n", TYPE_MAX78000_AES, __func__, addr);
+            break;
+        }
+    }
+    return 0;
+}
+
+static void max78000_aes_do_crypto(Max78000AesState *s)
+{
+    int keylen = 256;
+    uint8_t *keydata = s->key;
+    if ((s->ctrl & KEY_SIZE) == 0) {
+        keylen = 128;
+        keydata += 16;
+    } else if ((s->ctrl & KEY_SIZE) == 1 << 6) {
+        keylen = 192;
+        keydata += 8;
+    }
+
+    AES_KEY key;
+    if ((s->ctrl & TYPE) == 0) {
+        AES_set_encrypt_key(keydata, keylen, &key);
+        AES_set_decrypt_key(keydata, keylen, &s->internal_key);
+        AES_encrypt(s->data, s->result, &key);
+        s->result_index = 16;
+    } else if ((s->ctrl & TYPE) == 1 << 8) {
+        AES_set_decrypt_key(keydata, keylen, &key);
+        AES_set_decrypt_key(keydata, keylen, &s->internal_key);
+        AES_decrypt(s->data, s->result, &key);
+        s->result_index = 16;
+    } else{
+        AES_decrypt(s->data, s->result, &s->internal_key);
+        s->result_index = 16;
+    }
+    s->intfl |= DONE;
+}
+
+static void max78000_aes_write(void *opaque, hwaddr addr,
+                    uint64_t val64, unsigned int size)
+{
+    Max78000AesState *s = opaque;
+    uint32_t val = val64;
+    int i;
+    switch (addr) {
+        case CTRL:{
+            if (val & OUTPUT_FLUSH) {
+                s->result_index = 0;
+                val &= ~OUTPUT_FLUSH;
+            }
+            if (val & INPUT_FLUSH) {
+                s->data_index = 0;
+                val &= ~INPUT_FLUSH;
+            }
+            if (val & START) {
+                max78000_aes_do_crypto(s);
+            }
+
+            /* Hardware appears to stay enabled even if 0 written */
+            s->ctrl = val | (s->ctrl & AES_EN);
+            break;
+        }
+
+        case FIFO:{
+            for (i = 0; i < 4; i++) {
+                s->data[(12 - s->data_index) + i] =
+                            (val >> ((3 - i) * 8)) & 0xff;
+            }
+            s->data_index += 4;
+            if (s->data_index >= 16) {
+                s->data_index = 0;
+                max78000_aes_do_crypto(s);
+            }
+            break;
+        }
+        case KEY_BASE ... KEY_END - 4:{
+            for (i = 0; i < 4; i++) {
+                s->key[(KEY_END - KEY_BASE - 4) - (addr - KEY_BASE) + i] =
+                            (val >> ((3 - i) * 8)) & 0xff;
+            }
+            break;
+        }
+
+        default:{
+            qemu_log_mask(LOG_GUEST_ERROR, "[%s]%s: Bad register at offset 0x%"
+                HWADDR_PRIx "\n", TYPE_MAX78000_AES, __func__, addr);
+            break;
+        }
+
+    }
+    max78000_aes_set_status(s);
+}
+
+static void max78000_aes_reset_hold(Object *obj, ResetType type)
+{
+    Max78000AesState *s = MAX78000_AES(obj);
+    s->ctrl = 0;
+    s->status = 0;
+    s->intfl = 0;
+    s->inten = 0;
+
+    s->data_index = 0;
+    s->result_index = 0;
+
+    memset(s->data, 0, sizeof(s->data));
+    memset(s->key, 0, sizeof(s->key));
+    memset(s->result, 0, sizeof(s->result));
+    memset(&s->internal_key, 0, sizeof(s->internal_key));
+
+
+}
+
+static const MemoryRegionOps max78000_aes_ops = {
+    .read = max78000_aes_read,
+    .write = max78000_aes_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+};
+
+static void max78000_aes_init(Object *obj)
+{
+    Max78000AesState *s = MAX78000_AES(obj);
+    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq);
+
+    memory_region_init_io(&s->mmio, obj, &max78000_aes_ops, s,
+                        TYPE_MAX78000_AES, 0xc00);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
+
+}
+
+static void max78000_aes_class_init(ObjectClass *klass, const void *data)
+{
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    rc->phases.hold = max78000_aes_reset_hold;
+
+}
+
+static const TypeInfo max78000_aes_info = {
+    .name          = TYPE_MAX78000_AES,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(Max78000AesState),
+    .instance_init = max78000_aes_init,
+    .class_init    = max78000_aes_class_init,
+};
+
+static void max78000_aes_register_types(void)
+{
+    type_register_static(&max78000_aes_info);
+}
+
+type_init(max78000_aes_register_types)
diff --git a/hw/misc/max78000_gcr.c b/hw/misc/max78000_gcr.c
index a469d7a489..c8e2279b00 100644
--- a/hw/misc/max78000_gcr.c
+++ b/hw/misc/max78000_gcr.c
@@ -142,6 +142,8 @@ static void max78000_gcr_write(void *opaque, hwaddr addr,
                       RTC_RESET | I2C0_RESET | SPI1_RESET |
                       TMR3_RESET | TMR2_RESET | TMR1_RESET |
                       TMR0_RESET | WDT0_RESET | DMA_RESET;
+
+                max78000_gcr_reset_device("aes");
             }
             if (val & SOFT_RESET) {
                 /* Soft reset also resets GPIO */
@@ -151,6 +153,7 @@ static void max78000_gcr_write(void *opaque, hwaddr addr,
                       TMR3_RESET | TMR2_RESET | TMR1_RESET |
                       TMR0_RESET | GPIO1_RESET | GPIO0_RESET |
                       DMA_RESET;
+                max78000_gcr_reset_device("aes");
             }
             if (val & UART2_RESET) {
                 max78000_gcr_reset_device("uart2");
@@ -164,6 +167,7 @@ static void max78000_gcr_write(void *opaque, hwaddr addr,
             if (val & TRNG_RESET) {
                 max78000_gcr_reset_device("trng");
             }
+
             /* TODO: As other devices are implemented, add them here */
             break;
         }
@@ -208,7 +212,10 @@ static void max78000_gcr_write(void *opaque, hwaddr addr,
         }
         case RST1:{
             /* TODO: As other devices are implemented, add them here */
-            s->rst1 = val;
+            if (val & AES_RESET) {
+                max78000_gcr_reset_device("aes");
+            }
+
             break;
         }
         case PCKDIS1:{
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index c7c57d924b..b1d8d8e5d2 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -70,6 +70,7 @@ system_ss.add(when: 'CONFIG_IMX', if_true: files(
   'imx_ccm.c',
   'imx_rngc.c',
 ))
+system_ss.add(when: 'CONFIG_MAX78000_AES', if_true: files('max78000_aes.c'))
 system_ss.add(when: 'CONFIG_MAX78000_GCR', if_true: files('max78000_gcr.c'))
 system_ss.add(when: 'CONFIG_MAX78000_ICC', if_true: files('max78000_icc.c'))
 system_ss.add(when: 'CONFIG_MAX78000_TRNG', if_true: files('max78000_trng.c'))
diff --git a/include/hw/arm/max78000_soc.h b/include/hw/arm/max78000_soc.h
index 936825399c..69284abf9f 100644
--- a/include/hw/arm/max78000_soc.h
+++ b/include/hw/arm/max78000_soc.h
@@ -11,6 +11,7 @@
 
 #include "hw/or-irq.h"
 #include "hw/arm/armv7m.h"
+#include "hw/misc/max78000_aes.h"
 #include "hw/misc/max78000_gcr.h"
 #include "hw/misc/max78000_icc.h"
 #include "hw/char/max78000_uart.h"
@@ -41,6 +42,7 @@ struct MAX78000State {
     Max78000IccState icc[MAX78000_NUM_ICC];
     Max78000UartState uart[MAX78000_NUM_UART];
     Max78000TrngState trng;
+    Max78000AesState aes;
 
     Clock *sysclk;
     Clock *refclk;
diff --git a/include/hw/misc/max78000_aes.h b/include/hw/misc/max78000_aes.h
new file mode 100644
index 0000000000..407c45ef61
--- /dev/null
+++ b/include/hw/misc/max78000_aes.h
@@ -0,0 +1,68 @@
+/*
+ * MAX78000 AES
+ *
+ * Copyright (c) 2025 Jackson Donaldson <jcksn@duck.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef HW_MAX78000_AES_H
+#define HW_MAX78000_AES_H
+
+#include "hw/sysbus.h"
+#include "crypto/aes.h"
+#include "qom/object.h"
+
+#define TYPE_MAX78000_AES "max78000-aes"
+OBJECT_DECLARE_SIMPLE_TYPE(Max78000AesState, MAX78000_AES)
+
+#define CTRL 0
+#define STATUS 4
+#define INTFL 8
+#define INTEN 0xc
+#define FIFO 0x10
+
+#define KEY_BASE 0x400
+#define KEY_END 0x420
+
+/* CTRL */
+#define TYPE (1 << 9 | 1 << 8)
+#define KEY_SIZE (1 << 7 | 1 << 6)
+#define OUTPUT_FLUSH (1 << 5)
+#define INPUT_FLUSH (1 << 4)
+#define START (1 << 3)
+
+#define AES_EN (1 << 0)
+
+/* STATUS */
+#define OUTPUT_FULL (1 << 4)
+#define OUTPUT_EMPTY (1 << 3)
+#define INPUT_FULL (1 << 2)
+#define INPUT_EMPTY (1 << 1)
+#define BUSY (1 << 0)
+
+/* INTFL*/
+#define DONE (1 << 0)
+
+struct Max78000AesState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion mmio;
+
+    uint32_t ctrl;
+    uint32_t status;
+    uint32_t intfl;
+    uint32_t inten;
+    uint32_t data_index;
+    uint8_t data[16];
+
+    uint8_t key[32];
+    AES_KEY internal_key;
+
+    uint32_t result_index;
+    uint8_t result[16];
+
+
+    qemu_irq irq;
+};
+
+#endif
diff --git a/include/hw/misc/max78000_gcr.h b/include/hw/misc/max78000_gcr.h
index 128f9b8a99..b6abaa25bc 100644
--- a/include/hw/misc/max78000_gcr.h
+++ b/include/hw/misc/max78000_gcr.h
@@ -88,6 +88,25 @@ OBJECT_DECLARE_SIMPLE_TYPE(Max78000GcrState, MAX78000_GCR)
 #define I2C1_RESET (1 << 0)
 
 
+/* RST1 */
+#define CPU1_RESET (1 << 31)
+
+#define SIMO_RESET (1 << 25)
+#define DVS_RESET (1 << 24)
+
+#define I2C2_RESET (1 << 20)
+#define I2S_RESET (1 << 19)
+
+#define SMPHR_RESET (1 << 16)
+
+#define SPI0_RESET (1 << 11)
+#define AES_RESET (1 << 10)
+#define CRC_RESET (1 << 9)
+
+#define PT_RESET (1 << 1)
+#define I2C1_RESET (1 << 0)
+
+
 #define SYSRAM0_START 0x20000000
 #define SYSRAM1_START 0x20008000
 #define SYSRAM2_START 0x20010000
-- 
2.34.1


