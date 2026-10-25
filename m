Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C91606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 17:35:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xL26j-0005wl-Kz; Sun, 25 Oct 2026 13:34:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <contact@sayyadumar.com>)
 id 1xL260-00030q-Ce; Sun, 25 Oct 2026 13:33:26 -0400
Received: from www675.your-server.de ([85.10.213.182])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <contact@sayyadumar.com>)
 id 1xL25v-0007Qc-Pu; Sun, 25 Oct 2026 13:33:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sayyadumar.com; s=default2511; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=TYuHwRg+4jL+KNsbUCXdMpd73eoVlFn45myYNRKdzkM=; b=KUb45JHX5JJkb1jOE1VodoZqtT
 6Th70h3wDaiLfJJ2KGQQ0y7O9zqovBS5XSuLIdq5Zs6+4HeUeRxusIVMf0CCNErpZYdsv6fslAVLM
 hdparY/3+CCtAe9MYF4pxywd2Q7OY30c5fxNHajfzqovKP6MEI/P6Z7i//bOP80fj+B8zBmBRatI2
 RG/MzyBiPJYhhm+b0XfxqFsad4SqOkIHBsAZ1ETWfIJ5D5weg/fvkjL+4QGVdotl2Xc7ZQO9Ush2j
 6BJ2Yn8KXne/qhaiq3rFQWit4Duop6wSqnfySkMYHrn6r1NrzfM39bHdx2DjzIWGSj2D8ib4uWiBc
 YTpa4SYA==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
 by www675.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <contact@sayyadumar.com>)
 id 1xL1gG-00095U-19; Sun, 25 Oct 2026 18:06:48 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy01.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <contact@sayyadumar.com>)
 id 1xL1Vx-000OzG-0M; Sun, 25 Oct 2026 17:56:08 +0100
From: Sayyad Mahammad Umar <contact@sayyadumar.com>
Date: Sun, 25 Oct 2026 17:55:43 +0100
Subject: [PATCH v2 27/31] hw/misc: add Renesas RX ROM cache control registers
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261025-umar-rx-series-v2-27-9e846577cad0@sayyadumar.com>
References: <20261025-umar-rx-series-v2-0-9e846577cad0@sayyadumar.com>
In-Reply-To: <20261025-umar-rx-series-v2-0-9e846577cad0@sayyadumar.com>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>, 
 Alistair Francis <alistair@alistair23.me>, 
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowangio@gmail.com>, 
 qemu-arm@nongnu.org, Sayyad Mahammad Umar <contact@sayyadumar.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792947366; l=7873;
 i=contact@sayyadumar.com; s=qemu; h=from:subject:message-id;
 bh=s7HjZt2h0yqG6vvYB/EirWsPYdW33BijqFrqYOrl/O4=;
 b=faJoG3L1TYNfcLdC6Ukd/p6u9qagiQuEmiyS00WF9BDSCOozrNhzMf+CW2Ck6gApnFcfQqQjq
 vMxBR0JEzcWDDHAOr0X0+GpbelWC0R4+FKinzSIwyspDNZANmx1yWJg
X-Developer-Key: i=contact@sayyadumar.com; a=ed25519;
 pk=CsAjTLRCB7+pnzmj8902JER4gL8CTzNQFxlMZTl4wDk=
X-Virus-Scanned: Clear (ClamAV 1.4.6/28164/Sun Oct 25 07:24:12 2026)
Received-SPF: pass client-ip=85.10.213.182;
 envelope-from=contact@sayyadumar.com; helo=www675.your-server.de
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add the RX ROM cache control registers device.

Signed-off-by: Sayyad Mahammad Umar <contact@sayyadumar.com>
---
 MAINTAINERS                            |   2 +
 configs/devices/rx-softmmu/default.mak |   1 +
 hw/misc/Kconfig                        |   3 +
 hw/misc/meson.build                    |   1 +
 hw/misc/renesas_rx_romcache.c          | 139 +++++++++++++++++++++++++++++++++
 include/hw/misc/renesas_rx_romcache.h  |  30 +++++++
 6 files changed, 176 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index efeb40ee01..eb45c2446e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3087,6 +3087,7 @@ F: hw/dma/renesas_rx_dtc.c
 F: hw/gpio/renesas_rx_gpio.c
 F: hw/intc/rx_icu.c
 F: hw/misc/renesas_rx_*.c
+F: hw/misc/renesas_rx_romcache.c
 F: hw/rtc/renesas_rx_rtc.c
 F: hw/rx/
 F: hw/ssi/renesas_rspi.c
@@ -3097,6 +3098,7 @@ F: include/hw/dma/renesas_rx_dtc.h
 F: include/hw/gpio/renesas_rx_gpio.h
 F: include/hw/intc/rx_icu.h
 F: include/hw/misc/renesas_rx_*.h
+F: include/hw/misc/renesas_rx_romcache.h
 F: include/hw/rtc/renesas_rx_rtc.h
 F: include/hw/rx/
 F: include/hw/ssi/renesas_rspi.h
diff --git a/configs/devices/rx-softmmu/default.mak b/configs/devices/rx-softmmu/default.mak
index c8419d64cc..377b875cce 100644
--- a/configs/devices/rx-softmmu/default.mak
+++ b/configs/devices/rx-softmmu/default.mak
@@ -10,3 +10,4 @@ CONFIG_RENESAS_S12AD=y
 CONFIG_RENESAS_RSPI=y
 CONFIG_RENESAS_RX_RTC=y
 CONFIG_RENESAS_RX_CRC=y
+CONFIG_RENESAS_RX_ROMCACHE=y
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index b1c4fd7cba..e2b9a5cd94 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -270,3 +270,6 @@ source macio/Kconfig
 
 config RENESAS_RX_CRC
     bool
+
+config RENESAS_RX_ROMCACHE
+    bool
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 22f933a17e..20af70d6a7 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -182,3 +182,4 @@ system_ss.add(when: 'CONFIG_LASI', if_true: files('lasi.c'))
 
 system_ss.add(when: 'CONFIG_AXIADO_CLK', if_true: files('axiado_clk.c'))
 system_ss.add(when: 'CONFIG_RENESAS_RX_CRC', if_true: files('renesas_rx_crc.c'))
+system_ss.add(when: 'CONFIG_RENESAS_RX_ROMCACHE', if_true: files('renesas_rx_romcache.c'))
diff --git a/hw/misc/renesas_rx_romcache.c b/hw/misc/renesas_rx_romcache.c
new file mode 100644
index 0000000000..22797d569d
--- /dev/null
+++ b/hw/misc/renesas_rx_romcache.c
@@ -0,0 +1,139 @@
+/*
+ * Renesas RX ROM cache control registers
+ *
+ * Datasheet: RX65N Group, RX651 Group User's Manual: Hardware
+ *            (Rev.2.40 R01UH0590EJ0240)
+ *
+ * Copyright (c) 2026 Umar, Sayyad Mahammad
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * The ROM cache speeds up code flash reads and is architecturally invisible
+ * apart from these two registers. QEMU has no such cache, so there is nothing
+ * to model beyond them -- but they do have to exist, because start-up code
+ * routinely enables the cache and then spins until the enable reads back:
+ *
+ *     FLASH.ROMCE.WORD = 0x0001;
+ *     while (FLASH.ROMCE.WORD != 0x0001) {
+ *     }
+ *
+ * With no device here that loop never terminates, and the machine hangs
+ * before anything else in the firmware runs.
+ *
+ * ROMCE holds the enable bit and reads back what was written. ROMCIV starts
+ * an invalidation, which completes instantly here, so the bit reads back as
+ * zero the way it does on hardware once invalidation has finished.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "hw/misc/renesas_rx_romcache.h"
+#include "migration/vmstate.h"
+
+#define R_ROMCE     0x00    /* 16-bit ROM cache enable     */
+#define R_ROMCIV    0x04    /* 16-bit ROM cache invalidate */
+#define R_ROMWT     0x1c    /* 8-bit ROM wait-cycle setting */
+
+#define ROMCE_ROMCEN    0x0001
+
+static uint64_t romcache_read(void *opaque, hwaddr offset, unsigned size)
+{
+    RenesasRxRomCacheState *s = opaque;
+
+    switch (offset) {
+    case R_ROMCE:
+        return s->romce;
+    case R_ROMCIV:
+        /* Invalidation is instantaneous, so it always reads as complete. */
+        return 0;
+    case R_ROMWT:
+        return s->romwt;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "renesas-rx-romcache: read from unmapped offset 0x%"
+                      HWADDR_PRIx "\n", offset);
+        return 0;
+    }
+}
+
+static void romcache_write(void *opaque, hwaddr offset, uint64_t value,
+                           unsigned size)
+{
+    RenesasRxRomCacheState *s = opaque;
+
+    switch (offset) {
+    case R_ROMCE:
+        s->romce = value & ROMCE_ROMCEN;
+        break;
+    case R_ROMCIV:
+        /* Nothing to invalidate; the write is accepted and completes. */
+        break;
+    case R_ROMWT:
+        s->romwt = value & 0x3;
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "renesas-rx-romcache: write to unmapped offset 0x%"
+                      HWADDR_PRIx "\n", offset);
+        break;
+    }
+}
+
+static const MemoryRegionOps romcache_ops = {
+    .read = romcache_read,
+    .write = romcache_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl = { .min_access_size = 1, .max_access_size = 4 },
+    .valid = { .min_access_size = 1, .max_access_size = 4 },
+};
+
+static void romcache_reset(DeviceState *dev)
+{
+    RenesasRxRomCacheState *s = RENESAS_RX_ROMCACHE(dev);
+
+    s->romce = 0;
+    s->romwt = 0;
+}
+
+static void romcache_init(Object *obj)
+{
+    RenesasRxRomCacheState *s = RENESAS_RX_ROMCACHE(obj);
+
+    memory_region_init_io(&s->memory, obj, &romcache_ops, s,
+                          "renesas-rx-romcache", RX_ROMCACHE_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->memory);
+}
+
+static const VMStateDescription vmstate_romcache = {
+    .name = "renesas-rx-romcache",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT16(romce, RenesasRxRomCacheState),
+        VMSTATE_UINT8(romwt, RenesasRxRomCacheState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void romcache_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->vmsd = &vmstate_romcache;
+    device_class_set_legacy_reset(dc, romcache_reset);
+}
+
+static const TypeInfo romcache_info = {
+    .name          = TYPE_RENESAS_RX_ROMCACHE,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(RenesasRxRomCacheState),
+    .instance_init = romcache_init,
+    .class_init    = romcache_class_init,
+};
+
+static void romcache_register_types(void)
+{
+    type_register_static(&romcache_info);
+}
+
+type_init(romcache_register_types)
diff --git a/include/hw/misc/renesas_rx_romcache.h b/include/hw/misc/renesas_rx_romcache.h
new file mode 100644
index 0000000000..2c3ddeb4bb
--- /dev/null
+++ b/include/hw/misc/renesas_rx_romcache.h
@@ -0,0 +1,30 @@
+/*
+ * Renesas RX ROM cache control registers
+ *
+ * Copyright (c) 2026 Umar, Sayyad Mahammad
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_MISC_RENESAS_RX_ROMCACHE_H
+#define HW_MISC_RENESAS_RX_ROMCACHE_H
+
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_RENESAS_RX_ROMCACHE "renesas-rx-romcache"
+OBJECT_DECLARE_SIMPLE_TYPE(RenesasRxRomCacheState, RENESAS_RX_ROMCACHE)
+
+/* Also covers the adjacent system ROMWT register at +0x01c. */
+#define RX_ROMCACHE_SIZE    0x20
+
+struct RenesasRxRomCacheState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion memory;
+
+    uint16_t romce;     /* ROM cache enable */
+    uint8_t romwt;      /* ROM wait cycles */
+};
+
+#endif /* HW_MISC_RENESAS_RX_ROMCACHE_H */

-- 
2.53.0


