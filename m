Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD704606A31D
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 17:30:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xL22K-00089M-K5; Sun, 25 Oct 2026 13:29:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <contact@sayyadumar.com>)
 id 1xL22D-000895-Gj; Sun, 25 Oct 2026 13:29:29 -0400
Received: from www675.your-server.de ([85.10.213.182])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <contact@sayyadumar.com>)
 id 1xL228-0006yg-Fu; Sun, 25 Oct 2026 13:29:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sayyadumar.com; s=default2511; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=psorZ0fczItdvbm4hQCWeKsN+eWkg6TrqS1q/XQuGSc=; b=EKj6wO5KIuSFHK3g1Uvh1Hjue4
 z+eMXGQa9LxsMr7CQv88Ju3Rct9qpw2U5tTz2cPtuDQ5gcB93BHY4g7S1m9+ktMG+eSqPj61zs66c
 OTVsgvPqTECz4rQen2YFz3xR7MvJWOysPb4hf14Zw3Ik+B3RNSYfsMbhJMO0IPHEI7n6+FYbrv08P
 o8E/Hu33Rptd7mUKi0yV8MT+hXplZYO6KUPtQD7vhvKx427e7u26bJnMHt50DiMtQ822/TMSWYJb3
 9PvJ8JAIHRbkJjFDBRVImzMXiwbYvwAYE7pJTIrMjwK1LpVZpYcz6P/T0j49wjUVNvX1JjeTJiH4Z
 e4aZNhqg==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
 by www675.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <contact@sayyadumar.com>)
 id 1xL1gI-00095w-2C; Sun, 25 Oct 2026 18:06:50 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy01.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <contact@sayyadumar.com>)
 id 1xL1Vx-000OzG-1I; Sun, 25 Oct 2026 17:56:08 +0100
From: Sayyad Mahammad Umar <contact@sayyadumar.com>
Date: Sun, 25 Oct 2026 17:55:47 +0100
Subject: [PATCH v2 31/31] hw/watchdog: add Renesas RX WDT and IWDT
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261025-umar-rx-series-v2-31-9e846577cad0@sayyadumar.com>
References: <20261025-umar-rx-series-v2-0-9e846577cad0@sayyadumar.com>
In-Reply-To: <20261025-umar-rx-series-v2-0-9e846577cad0@sayyadumar.com>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>, 
 Alistair Francis <alistair@alistair23.me>, 
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowangio@gmail.com>, 
 qemu-arm@nongnu.org, Sayyad Mahammad Umar <contact@sayyadumar.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792947366; l=9942;
 i=contact@sayyadumar.com; s=qemu; h=from:subject:message-id;
 bh=qLjvgz1PVe//+Eb2E+VJkCXV7yqqdxjHbqKvczCOre8=;
 b=exCCuQs2BzAqCu49t2WiktZV44vkITWxmsyjKxqUMjEwgnZq7d7Oohj3U+p5tk9mszvow1tNg
 ljV26PGjNceCnhXr6E2DmNwj7hxOcUKZWDApZNrR+BNdlq7wlo+OEmA
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

Add the RX watchdog timers, sections 28 (WDT) and 29 (IWDT) of the
RX65N hardware manual.

Signed-off-by: Sayyad Mahammad Umar <contact@sayyadumar.com>
---
 MAINTAINERS                            |   2 +
 configs/devices/rx-softmmu/default.mak |   1 +
 hw/watchdog/Kconfig                    |   3 +
 hw/watchdog/meson.build                |   1 +
 hw/watchdog/renesas_rx_wdt.c           | 193 +++++++++++++++++++++++++++++++++
 include/hw/watchdog/renesas_rx_wdt.h   |  48 ++++++++
 6 files changed, 248 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index db2f373b2f..b27a944757 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3095,6 +3095,7 @@ F: hw/rtc/renesas_rx_rtc.c
 F: hw/rx/
 F: hw/ssi/renesas_rspi.c
 F: hw/timer/renesas_mtu3.c
+F: hw/watchdog/renesas_rx_wdt.c
 F: include/hw/adc/renesas_s12ad.h
 F: include/hw/dma/renesas_rx_*.h
 F: include/hw/dma/renesas_rx_dtc.h
@@ -3109,6 +3110,7 @@ F: include/hw/rtc/renesas_rx_rtc.h
 F: include/hw/rx/
 F: include/hw/ssi/renesas_rspi.h
 F: include/hw/timer/renesas_mtu3.h
+F: include/hw/watchdog/renesas_rx_wdt.h
 
 CAN bus subsystem and hardware
 M: Pavel Pisa <pisa@cmp.felk.cvut.cz>
diff --git a/configs/devices/rx-softmmu/default.mak b/configs/devices/rx-softmmu/default.mak
index 530db7fae1..5709cdd570 100644
--- a/configs/devices/rx-softmmu/default.mak
+++ b/configs/devices/rx-softmmu/default.mak
@@ -14,3 +14,4 @@ CONFIG_RENESAS_RX_ROMCACHE=y
 CONFIG_RENESAS_RX_FCU=y
 CONFIG_RX65N_SYSCLK=y
 CONFIG_RENESAS_ETHERC=y
+CONFIG_RENESAS_RX_WDT=y
diff --git a/hw/watchdog/Kconfig b/hw/watchdog/Kconfig
index 55f77c5c84..806f081f49 100644
--- a/hw/watchdog/Kconfig
+++ b/hw/watchdog/Kconfig
@@ -28,3 +28,6 @@ config WDT_SBSA
 config ALLWINNER_WDT
     bool
     select PTIMER
+
+config RENESAS_RX_WDT
+    bool
diff --git a/hw/watchdog/meson.build b/hw/watchdog/meson.build
index 5edae65a36..a3e2cc0f2a 100644
--- a/hw/watchdog/meson.build
+++ b/hw/watchdog/meson.build
@@ -9,3 +9,4 @@ system_ss.add(when: 'CONFIG_WDT_IMX2', if_true: files('wdt_imx2.c'))
 system_ss.add(when: 'CONFIG_K230_WDT', if_true: files('k230_wdt.c'))
 system_ss.add(when: 'CONFIG_WDT_SBSA', if_true: files('sbsa_gwdt.c'))
 specific_ss.add(when: 'CONFIG_PSERIES', if_true: files('spapr_watchdog.c'))
+system_ss.add(when: 'CONFIG_RENESAS_RX_WDT', if_true: files('renesas_rx_wdt.c'))
diff --git a/hw/watchdog/renesas_rx_wdt.c b/hw/watchdog/renesas_rx_wdt.c
new file mode 100644
index 0000000000..f95374b139
--- /dev/null
+++ b/hw/watchdog/renesas_rx_wdt.c
@@ -0,0 +1,193 @@
+/*
+ * Renesas RX Watchdog Timers (WDT and IWDT)
+ *
+ * Datasheet: RX65N Group, RX651 Group User's Manual: Hardware
+ *            (Rev.1.00 R01UH0590EJ0100), sections 28 (WDT) and 29 (IWDT)
+ *
+ * Copyright (c) 2026 Umar, Sayyad Mahammad
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ *
+ * The watchdogs accept their refresh sequences (write 0x00 then 0xFF to the
+ * refresh register) and present a ready, non-underflowed status. QEMU models no
+ * real timeout, so a missed refresh never resets the guest; this keeps firmware
+ * that arms the watchdog during init running normally.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "hw/watchdog/renesas_rx_wdt.h"
+#include "migration/vmstate.h"
+
+/* WDT register offsets from 0x00088020. */
+#define R_WDTRR     0x00    /* 8-bit  refresh        */
+#define R_WDTCR     0x02    /* 16-bit control        */
+#define R_WDTSR     0x04    /* 16-bit status         */
+#define R_WDTRCR    0x06    /* 8-bit  reset control  */
+
+/* IWDT register offsets (block at 0x00088030, i.e. +0x10). */
+#define R_IWDTRR    0x10    /* 8-bit  refresh        */
+#define R_IWDTCR    0x12    /* 16-bit control        */
+#define R_IWDTSR    0x14    /* 16-bit status         */
+#define R_IWDTRCR   0x16    /* 8-bit  reset control  */
+#define R_IWDTCSTPR 0x18    /* 8-bit  count-stop     */
+
+/* The counter value lives in the status register's low 14 bits. */
+#define WDT_COUNT_RELOAD    0x3fff
+
+static void wdt_refresh(uint8_t *phase, uint16_t *sr, uint64_t value)
+{
+    /* A 0x00 followed by 0xFF reloads the down-counter to its top value. */
+    if (*phase == 0 && value == 0x00) {
+        *phase = 1;
+    } else if (*phase == 1 && value == 0xff) {
+        *phase = 0;
+        *sr = (*sr & ~WDT_COUNT_RELOAD) | WDT_COUNT_RELOAD;
+    } else {
+        *phase = 0;
+    }
+}
+
+static uint64_t wdt_read(void *opaque, hwaddr offset, unsigned size)
+{
+    RenesasRxWdtState *s = opaque;
+
+    switch (offset) {
+    case R_WDTRR:
+        return 0xff;
+    case R_WDTCR:
+        return s->wdtcr;
+    case R_WDTSR:
+        return s->wdtsr;
+    case R_WDTRCR:
+        return s->wdtrcr;
+    case R_IWDTRR:
+        return 0xff;
+    case R_IWDTCR:
+        return s->iwdtcr;
+    case R_IWDTSR:
+        return s->iwdtsr;
+    case R_IWDTRCR:
+        return s->iwdtrcr;
+    case R_IWDTCSTPR:
+        return s->iwdtcstpr;
+    default:
+        qemu_log_mask(LOG_UNIMP, "renesas-rx-wdt: read unimplemented 0x%"
+                      HWADDR_PRIx "\n", offset);
+        return 0;
+    }
+}
+
+static void wdt_write(void *opaque, hwaddr offset, uint64_t value,
+                      unsigned size)
+{
+    RenesasRxWdtState *s = opaque;
+
+    switch (offset) {
+    case R_WDTRR:
+        wdt_refresh(&s->wdt_rr_phase, &s->wdtsr, value);
+        break;
+    case R_WDTCR:
+        s->wdtcr = value;
+        break;
+    case R_WDTSR:
+        s->wdtsr = value;
+        break;
+    case R_WDTRCR:
+        s->wdtrcr = value;
+        break;
+    case R_IWDTRR:
+        wdt_refresh(&s->iwdt_rr_phase, &s->iwdtsr, value);
+        break;
+    case R_IWDTCR:
+        s->iwdtcr = value;
+        break;
+    case R_IWDTSR:
+        s->iwdtsr = value;
+        break;
+    case R_IWDTRCR:
+        s->iwdtrcr = value;
+        break;
+    case R_IWDTCSTPR:
+        s->iwdtcstpr = value;
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "renesas-rx-wdt: write unimplemented 0x%"
+                      HWADDR_PRIx "\n", offset);
+        break;
+    }
+}
+
+static const MemoryRegionOps wdt_ops = {
+    .read = wdt_read,
+    .write = wdt_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl = { .min_access_size = 1, .max_access_size = 2 },
+    .valid = { .min_access_size = 1, .max_access_size = 2 },
+};
+
+static void rx_wdt_reset(DeviceState *dev)
+{
+    RenesasRxWdtState *s = RENESAS_RX_WDT(dev);
+
+    s->wdtcr = 0x33f3;
+    s->wdtsr = 0;
+    s->wdtrcr = 0x80;
+    s->wdt_rr_phase = 0;
+    s->iwdtcr = 0;
+    s->iwdtsr = 0;
+    s->iwdtrcr = 0x80;
+    s->iwdtcstpr = 0;
+    s->iwdt_rr_phase = 0;
+}
+
+static void rx_wdt_init(Object *obj)
+{
+    RenesasRxWdtState *s = RENESAS_RX_WDT(obj);
+
+    memory_region_init_io(&s->mr, obj, &wdt_ops, s,
+                          "renesas-rx-wdt", RX_WDT_REGS_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mr);
+}
+
+static const VMStateDescription vmstate_rx_wdt = {
+    .name = "renesas-rx-wdt",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT16(wdtcr, RenesasRxWdtState),
+        VMSTATE_UINT16(wdtsr, RenesasRxWdtState),
+        VMSTATE_UINT8(wdtrcr, RenesasRxWdtState),
+        VMSTATE_UINT8(wdt_rr_phase, RenesasRxWdtState),
+        VMSTATE_UINT16(iwdtcr, RenesasRxWdtState),
+        VMSTATE_UINT16(iwdtsr, RenesasRxWdtState),
+        VMSTATE_UINT8(iwdtrcr, RenesasRxWdtState),
+        VMSTATE_UINT8(iwdtcstpr, RenesasRxWdtState),
+        VMSTATE_UINT8(iwdt_rr_phase, RenesasRxWdtState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void rx_wdt_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->vmsd = &vmstate_rx_wdt;
+    device_class_set_legacy_reset(dc, rx_wdt_reset);
+}
+
+static const TypeInfo rx_wdt_info = {
+    .name = TYPE_RENESAS_RX_WDT,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(RenesasRxWdtState),
+    .instance_init = rx_wdt_init,
+    .class_init = rx_wdt_class_init,
+};
+
+static void rx_wdt_register_types(void)
+{
+    type_register_static(&rx_wdt_info);
+}
+
+type_init(rx_wdt_register_types)
diff --git a/include/hw/watchdog/renesas_rx_wdt.h b/include/hw/watchdog/renesas_rx_wdt.h
new file mode 100644
index 0000000000..d232f13582
--- /dev/null
+++ b/include/hw/watchdog/renesas_rx_wdt.h
@@ -0,0 +1,48 @@
+/*
+ * Renesas RX Watchdog Timers (WDT and IWDT)
+ *
+ * Datasheet: RX65N Group, RX651 Group User's Manual: Hardware
+ *            (Rev.1.00 R01UH0590EJ0100), sections 28 (WDT) and 29 (IWDT)
+ *
+ * Copyright (c) 2026 Umar, Sayyad Mahammad
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ */
+
+#ifndef HW_WATCHDOG_RENESAS_RX_WDT_H
+#define HW_WATCHDOG_RENESAS_RX_WDT_H
+
+#include "hw/core/boards.h"
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_RENESAS_RX_WDT "renesas-rx-wdt"
+typedef struct RenesasRxWdtState RenesasRxWdtState;
+DECLARE_INSTANCE_CHECKER(RenesasRxWdtState, RENESAS_RX_WDT, TYPE_RENESAS_RX_WDT)
+
+/* One block covering both WDT (0x88020) and IWDT (0x88030). */
+#define RX_WDT_REGS_SIZE    0x20
+
+struct RenesasRxWdtState {
+    /*< private >*/
+    SysBusDevice parent_obj;
+    /*< public >*/
+
+    MemoryRegion mr;
+
+    /* WDT registers. */
+    uint16_t wdtcr;
+    uint16_t wdtsr;
+    uint8_t  wdtrcr;
+    uint8_t  wdt_rr_phase;  /* tracks the 0x00 -> 0xFF refresh sequence */
+
+    /* IWDT registers. */
+    uint16_t iwdtcr;
+    uint16_t iwdtsr;
+    uint8_t  iwdtrcr;
+    uint8_t  iwdtcstpr;
+    uint8_t  iwdt_rr_phase;
+};
+
+#endif /* HW_WATCHDOG_RENESAS_RX_WDT_H */

-- 
2.53.0


