Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E44F606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 17:35:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xL26R-0004Ar-7q; Sun, 25 Oct 2026 13:33:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <contact@sayyadumar.com>)
 id 1xL256-0002Ga-3z; Sun, 25 Oct 2026 13:32:33 -0400
Received: from www675.your-server.de ([85.10.213.182])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <contact@sayyadumar.com>)
 id 1xL253-0007Na-Ls; Sun, 25 Oct 2026 13:32:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sayyadumar.com; s=default2511; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=lbzJF1O3YQcacJJEF1mYlL8VRz0jmpheZ+u8N/OQgqc=; b=pqo+pYsCXsyclYs4VvGg5+Igt2
 y47uxHglz80v6kZoHDEd3EZfeZmDRbHkIizxBjF+S4AZKK3RfO8n8cP5EB8WkN/xR7Vie+KiRg7Hl
 0qgpQf+4lSThDTZ09hDc3fsiIuGJSpcdI6rwdh+xuI2UeUBmwH0W85t0mI56/9zC2XdhmprdgKutQ
 by7dUGol0xd3krZxaCUhWo1vlQX3o4s3w6yBqDK+mECjm6T7Cuxg5KBooEdexipk95cXgPbU3owA5
 rwvuBbEBR54Zw/TBHiX0eXDLCVBBnK+BenxSGwqzXywoeajxQ5DPH5UXdOshqK+hx/L+GBvQLcm9W
 8C7WNqAA==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
 by www675.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <contact@sayyadumar.com>)
 id 1xL1gW-0009Bq-0x; Sun, 25 Oct 2026 18:07:04 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy01.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <contact@sayyadumar.com>)
 id 1xL1Vw-000OzG-2x; Sun, 25 Oct 2026 17:56:08 +0100
From: Sayyad Mahammad Umar <contact@sayyadumar.com>
Date: Sun, 25 Oct 2026 17:55:41 +0100
Subject: [PATCH v2 25/31] hw/rtc: add Renesas RX RTC
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261025-umar-rx-series-v2-25-9e846577cad0@sayyadumar.com>
References: <20261025-umar-rx-series-v2-0-9e846577cad0@sayyadumar.com>
In-Reply-To: <20261025-umar-rx-series-v2-0-9e846577cad0@sayyadumar.com>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>, 
 Alistair Francis <alistair@alistair23.me>, 
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowangio@gmail.com>, 
 qemu-arm@nongnu.org, Sayyad Mahammad Umar <contact@sayyadumar.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792947366; l=13568;
 i=contact@sayyadumar.com; s=qemu; h=from:subject:message-id;
 bh=MPVMNbV464XJ/wqcmUFINttLcnLcrJGzEtEvthVjwbI=;
 b=8OnN8pugUvEb8Dx2xHKYl/SUkI4V0L1ZIYeFxfvFYsfKBD50S2RkblnR38ndjuteeAIUxGX0Y
 daYAVOKzV4SDI1dqby7byDr8Hz0pFgLxQK+uNUeotODyuDyCDYspR5w
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

Add the RX realtime clock, section 26 (RTC) of the RX65N hardware
manual.

Signed-off-by: Sayyad Mahammad Umar <contact@sayyadumar.com>
---
 MAINTAINERS                            |   2 +
 configs/devices/rx-softmmu/default.mak |   1 +
 hw/rtc/Kconfig                         |   3 +
 hw/rtc/meson.build                     |   1 +
 hw/rtc/renesas_rx_rtc.c                | 330 +++++++++++++++++++++++++++++++++
 include/hw/rtc/renesas_rx_rtc.h        |  52 ++++++
 6 files changed, 389 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index bd2de8abd5..b8bbb0e749 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3086,6 +3086,7 @@ F: hw/dma/renesas_rx_*.c
 F: hw/dma/renesas_rx_dtc.c
 F: hw/gpio/renesas_rx_gpio.c
 F: hw/intc/rx_icu.c
+F: hw/rtc/renesas_rx_rtc.c
 F: hw/rx/
 F: hw/ssi/renesas_rspi.c
 F: hw/timer/renesas_mtu3.c
@@ -3094,6 +3095,7 @@ F: include/hw/dma/renesas_rx_*.h
 F: include/hw/dma/renesas_rx_dtc.h
 F: include/hw/gpio/renesas_rx_gpio.h
 F: include/hw/intc/rx_icu.h
+F: include/hw/rtc/renesas_rx_rtc.h
 F: include/hw/rx/
 F: include/hw/ssi/renesas_rspi.h
 F: include/hw/timer/renesas_mtu3.h
diff --git a/configs/devices/rx-softmmu/default.mak b/configs/devices/rx-softmmu/default.mak
index 269b035b9d..cbc4641143 100644
--- a/configs/devices/rx-softmmu/default.mak
+++ b/configs/devices/rx-softmmu/default.mak
@@ -8,3 +8,4 @@ CONFIG_RENESAS_RX_DMAC=y
 CONFIG_RENESAS_RX_DTC=y
 CONFIG_RENESAS_S12AD=y
 CONFIG_RENESAS_RSPI=y
+CONFIG_RENESAS_RX_RTC=y
diff --git a/hw/rtc/Kconfig b/hw/rtc/Kconfig
index 315b0e4ecc..0d732417aa 100644
--- a/hw/rtc/Kconfig
+++ b/hw/rtc/Kconfig
@@ -31,3 +31,6 @@ config RS5C372_RTC
     bool
     depends on I2C
     default y if I2C_DEVICES
+
+config RENESAS_RX_RTC
+    bool
diff --git a/hw/rtc/meson.build b/hw/rtc/meson.build
index 6c87864dc0..10b0bb7f78 100644
--- a/hw/rtc/meson.build
+++ b/hw/rtc/meson.build
@@ -14,3 +14,4 @@ system_ss.add(when: 'CONFIG_LS7A_RTC', if_true: files('ls7a_rtc.c'))
 system_ss.add(when: 'CONFIG_ALLWINNER_H3', if_true: files('allwinner-rtc.c'))
 system_ss.add(when: 'CONFIG_MC146818RTC', if_true: files('mc146818rtc.c'))
 system_ss.add(when: 'CONFIG_RS5C372_RTC', if_true: files('rs5c372.c'))
+system_ss.add(when: 'CONFIG_RENESAS_RX_RTC', if_true: files('renesas_rx_rtc.c'))
diff --git a/hw/rtc/renesas_rx_rtc.c b/hw/rtc/renesas_rx_rtc.c
new file mode 100644
index 0000000000..69cfa19d81
--- /dev/null
+++ b/hw/rtc/renesas_rx_rtc.c
@@ -0,0 +1,330 @@
+/*
+ * Renesas RX Realtime Clock (RTC)
+ *
+ * Datasheet: RX65N Group, RX651 Group User's Manual: Hardware
+ *            (Rev.1.00 R01UH0590EJ0100), section 26 (RTC)
+ *
+ * Copyright (c) 2026 Umar, Sayyad Mahammad
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ *
+ * Calendar-count-mode model. The time/date registers are BCD-encoded and the
+ * counter advances once per second (driven by a host timer) while RCR2.START is
+ * set. Seeded from host wall-clock time at reset. Periodic/alarm/carry
+ * interrupts are not generated.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qemu/timer.h"
+#include "qemu/bcd.h"
+#include "hw/rtc/renesas_rx_rtc.h"
+#include "migration/vmstate.h"
+#include "system/rtc.h"
+#include "system/system.h"
+
+/* Register offsets from the RTC base (0x0008C400), calendar count mode. */
+#define R_R64CNT    0x00    /* 8-bit  64 Hz counter (read-only)  */
+#define R_RSECCNT   0x02    /* 8-bit  seconds  (BCD)             */
+#define R_RMINCNT   0x04    /* 8-bit  minutes  (BCD)             */
+#define R_RHRCNT    0x06    /* 8-bit  hours    (BCD)             */
+#define R_RWKCNT    0x08    /* 8-bit  day of week                */
+#define R_RDAYCNT   0x0A    /* 8-bit  day      (BCD)             */
+#define R_RMONCNT   0x0C    /* 8-bit  month    (BCD)             */
+#define R_RYRCNT    0x0E    /* 16-bit year     (BCD)             */
+#define R_RSECAR    0x10
+#define R_RMINAR    0x12
+#define R_RHRAR     0x14
+#define R_RWKAR     0x16
+#define R_RDAYAR    0x18
+#define R_RMONAR    0x1A
+#define R_RYRAR     0x1C
+#define R_RCR1      0x22    /* 8-bit  control 1                  */
+#define R_RCR2      0x24    /* 8-bit  control 2                  */
+#define R_RCR3      0x26    /* 8-bit  control 3                  */
+#define R_RCR4      0x28    /* 8-bit  control 4                  */
+
+#define RCR2_START  (1u << 0)
+#define RCR2_RESET  (1u << 1)
+
+static int days_in_month(int mon, int year)
+{
+    static const int d[] = { 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 };
+    if (mon == 2 && ((year % 4 == 0 && year % 100 != 0) || year % 400 == 0)) {
+        return 29;
+    }
+    return d[(mon - 1) % 12];
+}
+
+static void rtc_seed_from_host(RenesasRxRtcState *s)
+{
+    struct tm now;
+
+    qemu_get_timedate(&now, 0);
+    s->sec = now.tm_sec;
+    s->min = now.tm_min;
+    s->hour = now.tm_hour;
+    s->wday = now.tm_wday;
+    s->mday = now.tm_mday;
+    s->mon = now.tm_mon + 1;
+    s->year = now.tm_year + 1900;
+}
+
+static void rtc_advance_second(RenesasRxRtcState *s)
+{
+    if (++s->sec < 60) {
+        return;
+    }
+    s->sec = 0;
+    if (++s->min < 60) {
+        return;
+    }
+    s->min = 0;
+    if (++s->hour < 24) {
+        return;
+    }
+    s->hour = 0;
+    s->wday = (s->wday + 1) % 7;
+    if (++s->mday <= days_in_month(s->mon, s->year)) {
+        return;
+    }
+    s->mday = 1;
+    if (++s->mon <= 12) {
+        return;
+    }
+    s->mon = 1;
+    s->year++;
+}
+
+static void rtc_timer_tick(void *opaque)
+{
+    RenesasRxRtcState *s = opaque;
+
+    if (!(s->rcr2 & RCR2_START)) {
+        return;
+    }
+    rtc_advance_second(s);
+    timer_mod(s->timer,
+              qemu_clock_get_ms(rtc_clock) + 1000);
+}
+
+static void rtc_arm_timer(RenesasRxRtcState *s)
+{
+    if (s->rcr2 & RCR2_START) {
+        timer_mod(s->timer, qemu_clock_get_ms(rtc_clock) + 1000);
+    } else {
+        timer_del(s->timer);
+    }
+}
+
+static uint64_t rtc_read(void *opaque, hwaddr offset, unsigned size)
+{
+    RenesasRxRtcState *s = opaque;
+
+    switch (offset) {
+    case R_R64CNT:
+        return 0;
+    case R_RSECCNT:
+        return to_bcd(s->sec);
+    case R_RMINCNT:
+        return to_bcd(s->min);
+    case R_RHRCNT:
+        return to_bcd(s->hour);
+    case R_RWKCNT:
+        return s->wday;
+    case R_RDAYCNT:
+        return to_bcd(s->mday);
+    case R_RMONCNT:
+        return to_bcd(s->mon);
+    case R_RYRCNT:
+        return to_bcd(s->year % 100) | (to_bcd(s->year / 100) << 8);
+    case R_RSECAR:
+        return s->secar;
+    case R_RMINAR:
+        return s->minar;
+    case R_RHRAR:
+        return s->hrar;
+    case R_RWKAR:
+        return s->wkar;
+    case R_RDAYAR:
+        return s->dayar;
+    case R_RMONAR:
+        return s->monar;
+    case R_RYRAR:
+        return s->yrar;
+    case R_RCR1:
+        return s->rcr1;
+    case R_RCR2:
+        return s->rcr2;
+    case R_RCR3:
+        return s->rcr3;
+    case R_RCR4:
+        return s->rcr4;
+    default:
+        qemu_log_mask(LOG_UNIMP, "renesas-rx-rtc: read unimplemented 0x%"
+                      HWADDR_PRIx "\n", offset);
+        return 0;
+    }
+}
+
+static void rtc_write(void *opaque, hwaddr offset, uint64_t value,
+                      unsigned size)
+{
+    RenesasRxRtcState *s = opaque;
+
+    switch (offset) {
+    case R_RSECCNT:
+        s->sec = from_bcd(value & 0x7f);
+        break;
+    case R_RMINCNT:
+        s->min = from_bcd(value & 0x7f);
+        break;
+    case R_RHRCNT:
+        s->hour = from_bcd(value & 0x3f);
+        break;
+    case R_RWKCNT:
+        s->wday = value & 7;
+        break;
+    case R_RDAYCNT:
+        s->mday = from_bcd(value & 0x3f);
+        break;
+    case R_RMONCNT:
+        s->mon = from_bcd(value & 0x1f);
+        break;
+    case R_RYRCNT:
+        s->year = 2000 + from_bcd(value & 0xff);
+        break;
+    case R_RSECAR:
+        s->secar = value;
+        break;
+    case R_RMINAR:
+        s->minar = value;
+        break;
+    case R_RHRAR:
+        s->hrar = value;
+        break;
+    case R_RWKAR:
+        s->wkar = value;
+        break;
+    case R_RDAYAR:
+        s->dayar = value;
+        break;
+    case R_RMONAR:
+        s->monar = value;
+        break;
+    case R_RYRAR:
+        s->yrar = value;
+        break;
+    case R_RCR1:
+        s->rcr1 = value;
+        break;
+    case R_RCR2:
+        if (value & RCR2_RESET) {
+            s->sec = s->min = s->hour = 0;
+        }
+        s->rcr2 = value & ~RCR2_RESET;
+        rtc_arm_timer(s);
+        break;
+    case R_RCR3:
+        s->rcr3 = value;
+        break;
+    case R_RCR4:
+        s->rcr4 = value;
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "renesas-rx-rtc: write unimplemented 0x%"
+                      HWADDR_PRIx "\n", offset);
+        break;
+    }
+}
+
+static const MemoryRegionOps rtc_ops = {
+    .read = rtc_read,
+    .write = rtc_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl = { .min_access_size = 1, .max_access_size = 2 },
+    .valid = { .min_access_size = 1, .max_access_size = 2 },
+};
+
+static void rx_rtc_reset(DeviceState *dev)
+{
+    RenesasRxRtcState *s = RENESAS_RX_RTC(dev);
+
+    rtc_seed_from_host(s);
+    s->secar = s->minar = s->hrar = s->wkar = s->dayar = s->monar = 0;
+    s->yrar = 0;
+    s->rcr1 = 0;
+    s->rcr2 = 0;
+    s->rcr3 = 0;
+    s->rcr4 = 0;
+    timer_del(s->timer);
+}
+
+static void rx_rtc_realize(DeviceState *dev, Error **errp)
+{
+    RenesasRxRtcState *s = RENESAS_RX_RTC(dev);
+
+    s->timer = timer_new_ms(rtc_clock, rtc_timer_tick, s);
+}
+
+static void rx_rtc_init(Object *obj)
+{
+    RenesasRxRtcState *s = RENESAS_RX_RTC(obj);
+
+    memory_region_init_io(&s->mr, obj, &rtc_ops, s,
+                          "renesas-rx-rtc", RX_RTC_REGS_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mr);
+}
+
+static const VMStateDescription vmstate_rx_rtc = {
+    .name = "renesas-rx-rtc",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_INT32(sec, RenesasRxRtcState),
+        VMSTATE_INT32(min, RenesasRxRtcState),
+        VMSTATE_INT32(hour, RenesasRxRtcState),
+        VMSTATE_INT32(wday, RenesasRxRtcState),
+        VMSTATE_INT32(mday, RenesasRxRtcState),
+        VMSTATE_INT32(mon, RenesasRxRtcState),
+        VMSTATE_INT32(year, RenesasRxRtcState),
+        VMSTATE_UINT8(secar, RenesasRxRtcState),
+        VMSTATE_UINT8(minar, RenesasRxRtcState),
+        VMSTATE_UINT8(hrar, RenesasRxRtcState),
+        VMSTATE_UINT8(wkar, RenesasRxRtcState),
+        VMSTATE_UINT8(dayar, RenesasRxRtcState),
+        VMSTATE_UINT8(monar, RenesasRxRtcState),
+        VMSTATE_UINT16(yrar, RenesasRxRtcState),
+        VMSTATE_UINT8(rcr1, RenesasRxRtcState),
+        VMSTATE_UINT8(rcr2, RenesasRxRtcState),
+        VMSTATE_UINT8(rcr3, RenesasRxRtcState),
+        VMSTATE_UINT8(rcr4, RenesasRxRtcState),
+        VMSTATE_TIMER_PTR(timer, RenesasRxRtcState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void rx_rtc_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = rx_rtc_realize;
+    dc->vmsd = &vmstate_rx_rtc;
+    device_class_set_legacy_reset(dc, rx_rtc_reset);
+}
+
+static const TypeInfo rx_rtc_info = {
+    .name = TYPE_RENESAS_RX_RTC,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(RenesasRxRtcState),
+    .instance_init = rx_rtc_init,
+    .class_init = rx_rtc_class_init,
+};
+
+static void rx_rtc_register_types(void)
+{
+    type_register_static(&rx_rtc_info);
+}
+
+type_init(rx_rtc_register_types)
diff --git a/include/hw/rtc/renesas_rx_rtc.h b/include/hw/rtc/renesas_rx_rtc.h
new file mode 100644
index 0000000000..762d8cea51
--- /dev/null
+++ b/include/hw/rtc/renesas_rx_rtc.h
@@ -0,0 +1,52 @@
+/*
+ * Renesas RX Realtime Clock (RTC)
+ *
+ * Datasheet: RX65N Group, RX651 Group User's Manual: Hardware
+ *            (Rev.1.00 R01UH0590EJ0100), section 26 (RTC)
+ *
+ * Copyright (c) 2026 Umar, Sayyad Mahammad
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ */
+
+#ifndef HW_RTC_RENESAS_RX_RTC_H
+#define HW_RTC_RENESAS_RX_RTC_H
+
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_RENESAS_RX_RTC "renesas-rx-rtc"
+typedef struct RenesasRxRtcState RenesasRxRtcState;
+DECLARE_INSTANCE_CHECKER(RenesasRxRtcState, RENESAS_RX_RTC, TYPE_RENESAS_RX_RTC)
+
+#define RX_RTC_REGS_SIZE    0x40
+
+struct RenesasRxRtcState {
+    /*< private >*/
+    SysBusDevice parent_obj;
+    /*< public >*/
+
+    MemoryRegion mr;
+    QEMUTimer *timer;
+
+    /* Current time held as binary fields (converted to/from BCD on access). */
+    int sec;
+    int min;
+    int hour;
+    int wday;       /* 0 = Sunday */
+    int mday;       /* 1..31 */
+    int mon;        /* 1..12 */
+    int year;       /* full year, e.g. 2024 */
+
+    /* Alarm match registers (raw BCD as written). */
+    uint8_t secar, minar, hrar, wkar, dayar, monar;
+    uint16_t yrar;
+
+    uint8_t rcr1;
+    uint8_t rcr2;
+    uint8_t rcr3;
+    uint8_t rcr4;
+};
+
+#endif /* HW_RTC_RENESAS_RX_RTC_H */

-- 
2.53.0


