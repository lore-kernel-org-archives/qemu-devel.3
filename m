Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB68DC3ABC3
	for <qemu-devel@archiver.kernel.org>; Sat, 10 May 2025 02:24:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDZsD-0002D3-Cy; Fri, 09 May 2025 22:23:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kaidokert@Kaidos-MacBook-Pro.local>)
 id 1uDZsB-0002Cj-3S; Fri, 09 May 2025 22:23:31 -0400
Received: from static-119-110-246-4.violin.co.th ([119.110.246.4]
 helo=Kaidos-MacBook-Pro.local)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kaidokert@Kaidos-MacBook-Pro.local>)
 id 1uDZs7-00012m-G5; Fri, 09 May 2025 22:23:30 -0400
Received: by Kaidos-MacBook-Pro.local (Postfix, from userid 501)
 id 6106E5071683; Sat, 10 May 2025 09:23:21 +0700 (+07)
From: Kaido Kert <kaidokert@gmail.com>
To: qemu-devel@nongnu.org
Cc: joel@jms.id.au, peter.maydell@linaro.org, qemu-arm@nongnu.org,
 Kaido Kert <kaidokert@gmail.com>
Subject: [PATCH] Add nRF51 RTC timer
Date: Sat, 10 May 2025 09:23:04 +0700
Message-Id: <20250510022304.70305-1-kaidokert@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=119.110.246.4;
 envelope-from=kaidokert@Kaidos-MacBook-Pro.local;
 helo=Kaidos-MacBook-Pro.local
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_ADSP_CUSTOM_MED=0.001,
 FORGED_GMAIL_RCVD=1, FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, KHOP_HELO_FCRDNS=0.399,
 NML_ADSP_CUSTOM_MED=0.9, NO_DNS_FOR_FROM=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001, SPOOFED_FREEMAIL=0.001,
 SPOOF_GMAIL_MID=0.413 autolearn=no autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Implements the RTC timer for nRF51. Implementation is based
on existing nrf51_timer.
Event signaling through PPI peripheral is not implemented.
Tests added in microbit board.

Signed-off-by: Kaido Kert <kaidokert@gmail.com>
---
 hw/arm/nrf51_soc.c          |  13 ++
 hw/rtc/Kconfig              |   3 +
 hw/rtc/meson.build          |   1 +
 hw/rtc/nrf51_rtc.c          | 373 ++++++++++++++++++++++++++++++++++++
 hw/rtc/trace-events         |   4 +
 include/hw/arm/nrf51.h      |   1 +
 include/hw/arm/nrf51_soc.h  |   2 +
 include/hw/rtc/nrf51_rtc.h  |  68 +++++++
 tests/qtest/microbit-test.c | 249 ++++++++++++++++++++++++
 9 files changed, 714 insertions(+)
 create mode 100644 hw/rtc/nrf51_rtc.c
 create mode 100644 include/hw/rtc/nrf51_rtc.h

diff --git a/hw/arm/nrf51_soc.c b/hw/arm/nrf51_soc.c
index d8cc3214ed..f1e3aadf19 100644
--- a/hw/arm/nrf51_soc.c
+++ b/hw/arm/nrf51_soc.c
@@ -118,6 +118,17 @@ static void nrf51_soc_realize(DeviceState *dev_soc, Error **errp)
                        qdev_get_gpio_in(DEVICE(&s->armv7m),
                        BASE_TO_IRQ(NRF51_RNG_BASE)));
 
+    /* RTC */
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->rtc), errp)) {
+        return;
+    }
+    mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->rtc), 0);
+    memory_region_add_subregion_overlap(&s->container, NRF51_RTC0_BASE, mr, 0);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->rtc), 0,
+                       qdev_get_gpio_in(DEVICE(&s->armv7m),
+                       BASE_TO_IRQ(NRF51_RTC0_BASE)
+                       ));
+
     /* UICR, FICR, NVMC, FLASH */
     if (!object_property_set_uint(OBJECT(&s->nvm), "flash-size",
                                   s->flash_size, errp)) {
@@ -195,6 +206,8 @@ static void nrf51_soc_init(Object *obj)
 
     object_initialize_child(obj, "rng", &s->rng, TYPE_NRF51_RNG);
 
+    object_initialize_child(obj, "rtc", &s->rtc, TYPE_NRF51_RTC);
+
     object_initialize_child(obj, "nvm", &s->nvm, TYPE_NRF51_NVM);
 
     object_initialize_child(obj, "gpio", &s->gpio, TYPE_NRF51_GPIO);
diff --git a/hw/rtc/Kconfig b/hw/rtc/Kconfig
index 315b0e4ecc..18306c5db2 100644
--- a/hw/rtc/Kconfig
+++ b/hw/rtc/Kconfig
@@ -31,3 +31,6 @@ config RS5C372_RTC
     bool
     depends on I2C
     default y if I2C_DEVICES
+
+config NRF51_RTC
+    bool
diff --git a/hw/rtc/meson.build b/hw/rtc/meson.build
index 6c87864dc0..b959c9efe3 100644
--- a/hw/rtc/meson.build
+++ b/hw/rtc/meson.build
@@ -14,3 +14,4 @@ system_ss.add(when: 'CONFIG_LS7A_RTC', if_true: files('ls7a_rtc.c'))
 system_ss.add(when: 'CONFIG_ALLWINNER_H3', if_true: files('allwinner-rtc.c'))
 system_ss.add(when: 'CONFIG_MC146818RTC', if_true: files('mc146818rtc.c'))
 system_ss.add(when: 'CONFIG_RS5C372_RTC', if_true: files('rs5c372.c'))
+system_ss.add(when: 'CONFIG_NRF51_SOC', if_true: files('nrf51_rtc.c'))
diff --git a/hw/rtc/nrf51_rtc.c b/hw/rtc/nrf51_rtc.c
new file mode 100644
index 0000000000..5ffb269133
--- /dev/null
+++ b/hw/rtc/nrf51_rtc.c
@@ -0,0 +1,373 @@
+/*
+ * nRF51 SoC RTC emulation
+ *
+ * Copyright 2025 Kaido Kert <kaidokert@gmail.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/rtc/nrf51_rtc.h"
+#include "hw/irq.h"
+#include "hw/registerfields.h"
+#include "hw/sysbus.h"
+#include "migration/vmstate.h"
+#include "qemu/log.h"
+#include "qemu/timer.h"
+#include "qemu/units.h"
+#include "system/rtc.h"
+#include "system/system.h"
+#include "trace.h"
+
+#define NRF51_RTC_SIZE 0x1000
+#define NRF51_RTC_TICK_HZ 32768 /* 32.768 kHz LFCLK */
+#define NRF51_RTC_TICK_NS (NANOSECONDS_PER_SECOND / NRF51_RTC_TICK_HZ)
+
+/* Register field definitions */
+FIELD(NRF51_RTC_INTEN, TICK, 0, 1)
+FIELD(NRF51_RTC_INTEN, OVRFLW, 1, 1)
+FIELD(NRF51_RTC_INTEN, COMPARE0, 16, 1)
+FIELD(NRF51_RTC_INTEN, COMPARE1, 17, 1)
+FIELD(NRF51_RTC_INTEN, COMPARE2, 18, 1)
+FIELD(NRF51_RTC_INTEN, COMPARE3, 19, 1)
+
+/* 24-bit counter mask */
+#define BIT24_MASK 0xFFFFFF
+
+/* Map event address to s->events index */
+static int nrf51_rtc_event_index(hwaddr addr)
+{
+    switch (addr) {
+    case NRF51_RTC_EVENTS_TICK:
+        return 0;
+    case NRF51_RTC_EVENTS_OVRFLW:
+        return 1;
+    case NRF51_RTC_EVENTS_COMPARE0:
+        return 2;
+    case NRF51_RTC_EVENTS_COMPARE1:
+        return 3;
+    case NRF51_RTC_EVENTS_COMPARE2:
+        return 4;
+    case NRF51_RTC_EVENTS_COMPARE3:
+        return 5;
+    default:
+        return -1; /* Invalid */
+    }
+}
+
+static void nrf51_rtc_update_irq(NRF51RTCState *s)
+{
+    bool irq_pending = false;
+
+    irq_pending |= s->events[NRF51_RTC_EVENT_TICK] &&
+        FIELD_EX32(s->inten, NRF51_RTC_INTEN, TICK);
+    irq_pending |= s->events[NRF51_RTC_EVENT_OVRFLW] &&
+        FIELD_EX32(s->inten, NRF51_RTC_INTEN, OVRFLW);
+    for (int i = 0; i < 4; i++) {
+        irq_pending |= s->events[NRF51_RTC_EVENT_COMPARE + i]
+        && (s->inten & BIT(16 + i));
+    }
+
+    s->irq_pending = irq_pending;
+    qemu_set_irq(s->irq, s->irq_pending);
+}
+
+static void nrf51_rtc_tick(void *opaque)
+{
+    NRF51RTCState *s = opaque;
+    uint64_t now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    uint64_t elapsed_ns = now - s->last_update;
+    uint64_t tick_period_ns = NRF51_RTC_TICK_NS * (s->prescaler + 1);
+    uint32_t num_ticks = elapsed_ns / tick_period_ns;
+
+    /* Schedule next tick before any early returns */
+    timer_mod_ns(s->timer, now + tick_period_ns);
+
+    if (!s->powered || s->last_update == 0) {
+        s->last_update = now;
+        /*  Skip increment on first tick */
+        return;
+    }
+
+    for (uint32_t tick = 0; tick < num_ticks; tick++) {
+        s->tick_count = (s->tick_count + 1) & BIT24_MASK; /* 24-bit counter */
+        /*
+         * Check for tick event. Note: Events are always generated
+         * regardless of EVTEN register settings. EVTEN only controls
+         * PPI routing of events.
+         */
+        s->events[NRF51_RTC_EVENT_TICK] = 1;
+
+        /* Check for overflow (24-bit counter) */
+        if (s->tick_count == 0) {
+            s->events[NRF51_RTC_EVENT_OVRFLW] = 1;
+        }
+
+        /* Check compare registers */
+        for (int i = 0; i < 4; i++) {
+            if (s->tick_count == s->cc[i]) {
+                s->events[NRF51_RTC_EVENT_COMPARE + i] = 1;
+            }
+        }
+    }
+
+    s->last_update += num_ticks * tick_period_ns;
+    nrf51_rtc_update_irq(s);
+}
+
+static uint64_t nrf51_rtc_read(void *opaque, hwaddr addr, unsigned size)
+{
+    NRF51RTCState *s = opaque;
+    uint64_t value = 0;
+
+    if (!s->powered) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: read at 0x%" HWADDR_PRIx " when powered off\n",
+                      __func__,
+                      addr);
+        return 0;
+    }
+
+    switch (addr) {
+    case NRF51_RTC_EVENTS_TICK:
+    case NRF51_RTC_EVENTS_OVRFLW:
+    case NRF51_RTC_EVENTS_COMPARE0:
+    case NRF51_RTC_EVENTS_COMPARE1:
+    case NRF51_RTC_EVENTS_COMPARE2:
+    case NRF51_RTC_EVENTS_COMPARE3: {
+        int index = nrf51_rtc_event_index(addr);
+        if (index >= 0) {
+            value = s->events[index];
+        }
+        break;
+    }
+    case NRF51_RTC_INTENSET:
+    case NRF51_RTC_INTENCLR:
+        value = s->inten;
+        break;
+    case NRF51_RTC_EVTEN:
+    case NRF51_RTC_EVTENSET:
+    case NRF51_RTC_EVTENCLR:
+        value = s->evten;
+        break;
+    case NRF51_RTC_COUNTER:
+        value = s->tick_count & BIT24_MASK; /* 24-bit counter */
+        break;
+    case NRF51_RTC_PRESCALER:
+        value = s->prescaler & 0xFFF; /* 12-bit prescaler */
+        break;
+    case NRF51_RTC_CC0:
+    case NRF51_RTC_CC1:
+    case NRF51_RTC_CC2:
+    case NRF51_RTC_CC3:
+        value = s->cc[(addr - NRF51_RTC_CC0) / 4];
+        break;
+    case NRF51_RTC_POWER:
+        value = s->powered ? 1 : 0;
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP,
+                      "%s: unimplemented read at 0x%" HWADDR_PRIx "\n",
+                      __func__,
+                      addr);
+        break;
+    }
+
+    trace_nrf51_rtc_read(addr, value);
+    return value;
+}
+
+static void nrf51_rtc_write(void *opaque,
+                            hwaddr addr,
+                            uint64_t value,
+                            unsigned size) {
+    NRF51RTCState *s = opaque;
+
+    if (!s->powered && addr != NRF51_RTC_POWER) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: write at 0x%" HWADDR_PRIx " when powered off\n",
+                      __func__,
+                      addr);
+        return;
+    }
+
+    switch (addr) {
+    case NRF51_RTC_TASKS_START:
+        if (value == 1) {
+            s->running = true;
+            s->last_update = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+            timer_mod_ns(s->timer,
+                         s->last_update +
+                             NRF51_RTC_TICK_NS * (s->prescaler + 1));
+        }
+        break;
+    case NRF51_RTC_TASKS_STOP:
+        if (value == 1) {
+            s->running = false;
+            timer_del(s->timer);
+        }
+        break;
+    case NRF51_RTC_TASKS_CLEAR:
+        if (value == 1) {
+            s->tick_count = 0;
+            memset(s->events, 0, sizeof(s->events)); /* Clear all events */
+            s->last_update = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+            nrf51_rtc_update_irq(s);
+        }
+        break;
+    case NRF51_RTC_TASKS_TRIGOVRFLW:
+        if (value == 1) {
+            s->tick_count = 0xFFFFFE; /* Trigger overflow on next tick */
+        }
+        break;
+    case NRF51_RTC_EVENTS_TICK:
+    case NRF51_RTC_EVENTS_OVRFLW:
+    case NRF51_RTC_EVENTS_COMPARE0:
+    case NRF51_RTC_EVENTS_COMPARE1:
+    case NRF51_RTC_EVENTS_COMPARE2:
+    case NRF51_RTC_EVENTS_COMPARE3: {
+        int index = nrf51_rtc_event_index(addr);
+        if (index >= 0) {
+            s->events[index] = value & 1;
+            nrf51_rtc_update_irq(s);
+        }
+        break;
+    }
+    case NRF51_RTC_INTENSET:
+        s->inten |= value;
+        nrf51_rtc_update_irq(s);
+        break;
+    case NRF51_RTC_INTENCLR:
+        s->inten &= ~value;
+        nrf51_rtc_update_irq(s);
+        break;
+    case NRF51_RTC_EVTENSET:
+        s->evten |= value;
+        break;
+    case NRF51_RTC_EVTENCLR:
+        s->evten &= ~value;
+        break;
+    case NRF51_RTC_PRESCALER:
+        if (s->running) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: PRESCALER write while RTC running\n",
+                          __func__);
+        } else {
+            s->prescaler = value & 0xFFF; /* 12-bit prescaler */
+        }
+        break;
+    case NRF51_RTC_CC0:
+    case NRF51_RTC_CC1:
+    case NRF51_RTC_CC2:
+    case NRF51_RTC_CC3: {
+        int index = (addr - NRF51_RTC_CC0) / 4;
+        s->cc[index] = value & BIT24_MASK;
+         /* Writing to a CC register clears its associated COMPARE event */
+        s->events[NRF51_RTC_EVENT_COMPARE + index] = 0;
+        nrf51_rtc_update_irq(s);
+        break;
+    }
+    case NRF51_RTC_POWER:
+        s->powered = (value & 1) != 0;
+        if (!s->powered) {
+            s->running = false;
+            timer_del(s->timer);
+            s->tick_count = 0;
+            s->last_update = 0;
+        }
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP,
+                      "%s: unimplemented write at 0x%" HWADDR_PRIx "\n",
+                      __func__,
+                      addr);
+        break;
+    }
+
+    trace_nrf51_rtc_write(addr, value);
+}
+
+static const MemoryRegionOps nrf51_rtc_ops = {
+    .read = nrf51_rtc_read,
+    .write = nrf51_rtc_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+static void nrf51_rtc_reset(DeviceState *dev)
+{
+    NRF51RTCState *s = NRF51_RTC(dev);
+
+    timer_del(s->timer);
+    s->tick_count = 0;
+    s->prescaler = 0;
+    s->running = false;
+    s->powered = false; /* Reset to disabled per POWER register */
+    s->irq_pending = false;
+    s->inten = 0;
+    s->evten = 0;
+    s->last_update = 0;
+    memset(s->cc, 0, sizeof(s->cc));
+    memset(s->events, 0, sizeof(s->events));
+}
+
+static void nrf51_rtc_realize(DeviceState *dev, Error **errp)
+{
+    NRF51RTCState *s = NRF51_RTC(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+
+    memory_region_init_io(&s->iomem,
+                          OBJECT(s),
+                          &nrf51_rtc_ops,
+                          s,
+                          TYPE_NRF51_RTC,
+                          NRF51_RTC_SIZE);
+    sysbus_init_mmio(sbd, &s->iomem);
+    sysbus_init_irq(sbd, &s->irq);
+
+    s->timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, nrf51_rtc_tick, s);
+}
+
+static const VMStateDescription nrf51_rtc_vmstate = {
+    .name = TYPE_NRF51_RTC,
+    .version_id = 1,
+    .fields = (const VMStateField[]){VMSTATE_UINT32(tick_count, NRF51RTCState),
+                                     VMSTATE_UINT64(last_update, NRF51RTCState),
+                                     VMSTATE_UINT32(prescaler, NRF51RTCState),
+                                     VMSTATE_BOOL(running, NRF51RTCState),
+                                     VMSTATE_BOOL(powered, NRF51RTCState),
+                                     VMSTATE_BOOL(irq_pending, NRF51RTCState),
+                                     VMSTATE_UINT32(inten, NRF51RTCState),
+                                     VMSTATE_UINT32(evten, NRF51RTCState),
+                                     VMSTATE_UINT32_ARRAY(cc, NRF51RTCState, 4),
+                                     VMSTATE_UINT32_ARRAY(events,
+                                                          NRF51RTCState,
+                                                          6),
+                                     VMSTATE_END_OF_LIST()},
+};
+
+static void nrf51_rtc_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = nrf51_rtc_realize;
+    device_class_set_legacy_reset(dc, nrf51_rtc_reset);
+    dc->vmsd = &nrf51_rtc_vmstate;
+}
+
+static const TypeInfo nrf51_rtc_info = {
+    .name = TYPE_NRF51_RTC,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(NRF51RTCState),
+    .class_init = nrf51_rtc_class_init,
+};
+
+static void nrf51_rtc_register_types(void)
+{
+    type_register_static(&nrf51_rtc_info);
+}
+
+type_init(nrf51_rtc_register_types)
diff --git a/hw/rtc/trace-events b/hw/rtc/trace-events
index b9f2852d35..b9dd52e6d0 100644
--- a/hw/rtc/trace-events
+++ b/hw/rtc/trace-events
@@ -36,6 +36,10 @@ m48txx_nvram_mem_write(uint32_t addr, uint32_t value) "mem write addr:0x%04x val
 goldfish_rtc_read(uint64_t addr, uint64_t value) "addr 0x%02" PRIx64 " value 0x%08" PRIx64
 goldfish_rtc_write(uint64_t addr, uint64_t value) "addr 0x%02" PRIx64 " value 0x%08" PRIx64
 
+# nrf51_rtc.c
+nrf51_rtc_read(uint64_t addr, uint64_t value) "addr 0x%" PRIx64 " value 0x%" PRIx64
+nrf51_rtc_write(uint64_t addr, uint64_t value) "addr 0x%" PRIx64 " value 0x%" PRIx64
+
 # rs5c372.c
 rs5c372_recv(uint32_t addr, uint8_t value) "[0x%" PRIx32 "] -> 0x%02" PRIx8
 rs5c372_send(uint32_t addr, uint8_t value) "[0x%" PRIx32 "] <- 0x%02" PRIx8
diff --git a/include/hw/arm/nrf51.h b/include/hw/arm/nrf51.h
index de836beaa4..b20519bd0a 100644
--- a/include/hw/arm/nrf51.h
+++ b/include/hw/arm/nrf51.h
@@ -28,6 +28,7 @@
 #define NRF51_UART_BASE       0x40002000
 #define NRF51_TWI_BASE        0x40003000
 #define NRF51_TIMER_BASE      0x40008000
+#define NRF51_RTC0_BASE       0x4000B000
 #define NRF51_RNG_BASE        0x4000D000
 #define NRF51_NVMC_BASE       0x4001E000
 #define NRF51_GPIO_BASE       0x50000000
diff --git a/include/hw/arm/nrf51_soc.h b/include/hw/arm/nrf51_soc.h
index f88ab1b7d3..633100d4d0 100644
--- a/include/hw/arm/nrf51_soc.h
+++ b/include/hw/arm/nrf51_soc.h
@@ -16,6 +16,7 @@
 #include "hw/misc/nrf51_rng.h"
 #include "hw/gpio/nrf51_gpio.h"
 #include "hw/nvram/nrf51_nvm.h"
+#include "hw/rtc/nrf51_rtc.h"
 #include "hw/timer/nrf51_timer.h"
 #include "hw/clock.h"
 #include "qom/object.h"
@@ -34,6 +35,7 @@ struct NRF51State {
 
     NRF51UARTState uart;
     NRF51RNGState rng;
+    NRF51RTCState rtc;
     NRF51NVMState nvm;
     NRF51GPIOState gpio;
     NRF51TimerState timer[NRF51_NUM_TIMERS];
diff --git a/include/hw/rtc/nrf51_rtc.h b/include/hw/rtc/nrf51_rtc.h
new file mode 100644
index 0000000000..08c8319fd5
--- /dev/null
+++ b/include/hw/rtc/nrf51_rtc.h
@@ -0,0 +1,68 @@
+/*
+ * nRF51 SoC RTC emulation
+ *
+ * Copyright 2025 Kaido Kert <kaidokert@gmail.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_RTC_NRF51_RTC_H
+#define HW_RTC_NRF51_RTC_H
+
+#include "hw/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_NRF51_RTC "nrf51_soc.rtc"
+OBJECT_DECLARE_SIMPLE_TYPE(NRF51RTCState, NRF51_RTC)
+
+/* Register offsets */
+#define NRF51_RTC_TASKS_START 0x000
+#define NRF51_RTC_TASKS_STOP 0x004
+#define NRF51_RTC_TASKS_CLEAR 0x008
+#define NRF51_RTC_TASKS_TRIGOVRFLW 0x00C
+#define NRF51_RTC_EVENTS_TICK 0x100
+#define NRF51_RTC_EVENTS_OVRFLW 0x104
+#define NRF51_RTC_EVENTS_COMPARE0 0x140
+#define NRF51_RTC_EVENTS_COMPARE1 0x144
+#define NRF51_RTC_EVENTS_COMPARE2 0x148
+#define NRF51_RTC_EVENTS_COMPARE3 0x14C
+#define NRF51_RTC_INTENSET 0x304
+#define NRF51_RTC_INTENCLR 0x308
+#define NRF51_RTC_EVTEN 0x340
+#define NRF51_RTC_EVTENSET 0x344
+#define NRF51_RTC_EVTENCLR 0x348
+#define NRF51_RTC_COUNTER 0x504
+#define NRF51_RTC_PRESCALER 0x508
+#define NRF51_RTC_CC0 0x540
+#define NRF51_RTC_CC1 0x544
+#define NRF51_RTC_CC2 0x548
+#define NRF51_RTC_CC3 0x54C
+#define NRF51_RTC_POWER 0xFFC
+
+#define NRF51_RTC_CC_REG_COUNT 4
+#define NRF51_RTC_EVENT_COUNT 6
+
+#define NRF51_RTC_EVENT_TICK 0
+#define NRF51_RTC_EVENT_OVRFLW 1
+#define NRF51_RTC_EVENT_COMPARE 2
+
+struct NRF51RTCState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion iomem;
+    QEMUTimer *timer;
+    qemu_irq irq;
+
+    uint32_t tick_count;  /* Current counter value, 24-bit */
+    uint64_t last_update; /* Last tick update time (ns) */
+    uint32_t prescaler;   /* 12-bit prescaler */
+    bool running;         /* RTC running state */
+    bool powered;         /* RTC power state (POWER register) */
+    bool irq_pending;     /* Pending interrupts */
+    uint32_t inten;       /* Interrupt enable */
+    uint32_t evten;       /* Event enable */
+    uint32_t cc[NRF51_RTC_CC_REG_COUNT];    /* Compare registers CC[0-3] */
+    uint32_t events[NRF51_RTC_EVENT_COUNT]; /* TICK, OVRFLW, COMPARE[0-3] */
+};
+
+#endif /* HW_RTC_NRF51_RTC_H */
diff --git a/tests/qtest/microbit-test.c b/tests/qtest/microbit-test.c
index 505c831f13..8c0b81192f 100644
--- a/tests/qtest/microbit-test.c
+++ b/tests/qtest/microbit-test.c
@@ -22,6 +22,7 @@
 #include "hw/char/nrf51_uart.h"
 #include "hw/gpio/nrf51_gpio.h"
 #include "hw/nvram/nrf51_nvm.h"
+#include "hw/rtc/nrf51_rtc.h"
 #include "hw/timer/nrf51_timer.h"
 #include "hw/i2c/microbit_i2c.h"
 
@@ -538,6 +539,253 @@ static void test_nrf51_timer(void)
     qtest_quit(qts);
 }
 
+/* RTC Helper Functions */
+static void rtc_task(QTestState *qts, hwaddr task)
+{
+    qtest_writel(qts, NRF51_RTC0_BASE + task, NRF51_TRIGGER_TASK);
+}
+
+static void rtc_clear_event(QTestState *qts, hwaddr event)
+{
+    qtest_writel(qts, NRF51_RTC0_BASE + event, NRF51_EVENT_CLEAR);
+}
+
+static void rtc_set_prescaler(QTestState *qts, uint32_t prescaler)
+{
+    qtest_writel(qts, NRF51_RTC0_BASE + NRF51_RTC_PRESCALER, prescaler);
+}
+
+static void rtc_set_cc(QTestState *qts, size_t idx, uint32_t value)
+{
+    qtest_writel(qts, NRF51_RTC0_BASE + NRF51_RTC_CC0 + idx * 4, value);
+}
+
+static void rtc_assert_events(QTestState *qts,
+                              uint32_t tick,
+                              uint32_t ovrflw,
+                              uint32_t cmp0,
+                              uint32_t cmp1,
+                              uint32_t cmp2,
+                              uint32_t cmp3) {
+    g_assert_cmpuint(qtest_readl(qts, NRF51_RTC0_BASE + NRF51_RTC_EVENTS_TICK),
+                     ==,
+                     tick);
+    g_assert_cmpuint(qtest_readl(qts,
+                                 NRF51_RTC0_BASE + NRF51_RTC_EVENTS_OVRFLW),
+                     ==,
+                     ovrflw);
+    g_assert_cmpuint(qtest_readl(qts,
+                                 NRF51_RTC0_BASE + NRF51_RTC_EVENTS_COMPARE0),
+                     ==,
+                     cmp0);
+    g_assert_cmpuint(qtest_readl(qts,
+                                 NRF51_RTC0_BASE + NRF51_RTC_EVENTS_COMPARE1),
+                     ==,
+                     cmp1);
+    g_assert_cmpuint(qtest_readl(qts,
+                                 NRF51_RTC0_BASE + NRF51_RTC_EVENTS_COMPARE2),
+                     ==,
+                     cmp2);
+    g_assert_cmpuint(qtest_readl(qts,
+                                 NRF51_RTC0_BASE + NRF51_RTC_EVENTS_COMPARE3),
+                     ==,
+                     cmp3);
+}
+
+static void test_nrf51_rtc(void)
+{
+    QTestState *qts = qtest_init("-M microbit");
+    uint64_t tick_ns = 30517; /* 32.768 kHz = ~30.517 µs per tick */
+
+    /* Check reset state */
+    g_assert_cmpuint(qtest_readl(qts, NRF51_RTC0_BASE + NRF51_RTC_COUNTER),
+                     ==,
+                     0);
+    g_assert_cmpuint(qtest_readl(qts, NRF51_RTC0_BASE + NRF51_RTC_PRESCALER),
+                     ==,
+                     0);
+    g_assert_cmpuint(qtest_readl(qts, NRF51_RTC0_BASE + NRF51_RTC_INTENSET),
+                     ==,
+                     0);
+    g_assert_cmpuint(qtest_readl(qts, NRF51_RTC0_BASE + NRF51_RTC_EVTEN),
+                     ==,
+                     0);
+    g_assert_cmpuint(qtest_readl(qts, NRF51_RTC0_BASE + NRF51_RTC_POWER),
+                     ==,
+                     0);
+    rtc_assert_events(qts, 0, 0, 0, 0, 0, 0);
+
+    /* Test power control */
+    qtest_writel(qts, NRF51_RTC0_BASE + NRF51_RTC_POWER, 1); /* Enable power */
+    g_assert_cmpuint(qtest_readl(qts, NRF51_RTC0_BASE + NRF51_RTC_POWER),
+                     ==,
+                     1);
+    qtest_writel(qts,
+                 NRF51_RTC0_BASE + NRF51_RTC_TASKS_START,
+                 1); /* Start RTC */
+    /* Perform multiple smaller clock steps to ensure timer fires */
+    for (int i = 0; i < 10; i++) {
+        qtest_clock_step(qts, tick_ns * 2); /* Advance 2 ticks per step */
+    }
+    g_assert_cmpuint(qtest_readl(qts, NRF51_RTC0_BASE + NRF51_RTC_COUNTER),
+                     ==,
+                     19);
+    qtest_writel(qts, NRF51_RTC0_BASE + NRF51_RTC_POWER, 0); /* Disable power */
+    g_assert_cmpuint(qtest_readl(qts, NRF51_RTC0_BASE + NRF51_RTC_POWER),
+                     ==,
+                     0);
+    qtest_clock_step(qts, tick_ns * 10);
+    g_assert_cmpuint(qtest_readl(qts, NRF51_RTC0_BASE + NRF51_RTC_COUNTER),
+                     ==,
+                     0); /* No increment */
+    qtest_writel(qts,
+                 NRF51_RTC0_BASE + NRF51_RTC_POWER,
+                 1); /* Re-enable power */
+
+    /* Test counter increment with prescaler = 0 */
+    rtc_task(qts, NRF51_RTC_TASKS_START);
+    qtest_clock_step(qts, tick_ns * 10); /* Advance 10 ticks */
+    g_assert_cmpuint(qtest_readl(qts, NRF51_RTC0_BASE + NRF51_RTC_COUNTER),
+                     ==,
+                     10);
+    rtc_task(qts, NRF51_RTC_TASKS_STOP);
+    qtest_clock_step(qts, tick_ns * 10); /* No increment when stopped */
+    g_assert_cmpuint(qtest_readl(qts, NRF51_RTC0_BASE + NRF51_RTC_COUNTER),
+                     ==,
+                     10);
+
+    /* Test PRESCALER write restriction */
+    rtc_task(qts, NRF51_RTC_TASKS_START);
+    qtest_writel(qts,
+                 NRF51_RTC0_BASE + NRF51_RTC_PRESCALER,
+                 1); /* Try to write while running */
+    g_assert_cmpuint(qtest_readl(qts, NRF51_RTC0_BASE + NRF51_RTC_PRESCALER),
+                     ==,
+                     0); /* No change */
+    rtc_task(qts, NRF51_RTC_TASKS_STOP);
+    qtest_writel(qts,
+                 NRF51_RTC0_BASE + NRF51_RTC_PRESCALER,
+                 1); /* Write when stopped */
+    g_assert_cmpuint(qtest_readl(qts, NRF51_RTC0_BASE + NRF51_RTC_PRESCALER),
+                     ==,
+                     1);
+
+    /* Test TICK and COMPARE events with IRQ */
+    qtest_irq_intercept_out_named(qts,
+                                  "/machine/nrf51/rtc",
+                                  "sysbus-irq"); /* Intercept RTC IRQ */
+    rtc_task(qts, NRF51_RTC_TASKS_CLEAR);
+    g_assert_cmpuint(qtest_readl(qts, NRF51_RTC0_BASE + NRF51_RTC_COUNTER),
+                     ==,
+                     0);
+    qtest_writel(qts,
+                 NRF51_RTC0_BASE + NRF51_RTC_EVTENSET,
+                 0x00010001); /* Enable TICK, COMPARE0 events */
+    qtest_writel(qts,
+                 NRF51_RTC0_BASE + NRF51_RTC_INTENSET,
+                 0x00010001); /* Enable TICK, COMPARE0 interrupts */
+    rtc_set_cc(qts, 0, 5);    /* COMPARE0 at counter = 5 */
+    g_assert_false(qtest_get_irq(qts, 0)); /* No IRQ yet */
+    rtc_task(qts, NRF51_RTC_TASKS_START);
+    qtest_clock_step(qts, tick_ns * 6); /* Advance 3 ticks */
+    rtc_assert_events(qts, 1, 0, 0, 0, 0, 0);
+    g_assert_true(qtest_get_irq(qts, 0)); /* TICK IRQ */
+    qtest_clock_step(qts, tick_ns * 6);   /* Advance to 6 ticks */
+    rtc_assert_events(qts, 1, 0, 1, 0, 0, 0);
+    g_assert_true(qtest_get_irq(qts, 0)); /* COMPARE0 IRQ */
+    g_assert_cmpuint(qtest_readl(qts, NRF51_RTC0_BASE + NRF51_RTC_COUNTER),
+                     ==,
+                     6);
+    rtc_clear_event(qts, NRF51_RTC_EVENTS_TICK);
+    rtc_clear_event(qts, NRF51_RTC_EVENTS_COMPARE0);
+    rtc_assert_events(qts, 0, 0, 0, 0, 0, 0);
+    g_assert_false(qtest_get_irq(qts, 0)); /* IRQ cleared */
+
+    /* Test prescaler */
+    rtc_task(qts, NRF51_RTC_TASKS_CLEAR);
+    rtc_set_prescaler(qts, 1); /* Prescaler = 1, tick period = 2 * 30.517 µs */
+    rtc_task(qts, NRF51_RTC_TASKS_START);
+    qtest_clock_step(qts, tick_ns * 4); /* 4 base ticks = 2 prescaled ticks */
+    g_assert_cmpuint(qtest_readl(qts, NRF51_RTC0_BASE + NRF51_RTC_COUNTER),
+                     ==,
+                     2);
+    rtc_task(qts, NRF51_RTC_TASKS_STOP);
+
+    /* Test interrupt enable */
+    rtc_task(qts, NRF51_RTC_TASKS_CLEAR);
+    qtest_writel(qts,
+                 NRF51_RTC0_BASE + NRF51_RTC_INTENSET,
+                 0x00010001); /* Enable TICK, COMPARE0 interrupts */
+    g_assert_cmpuint(qtest_readl(qts, NRF51_RTC0_BASE + NRF51_RTC_INTENSET),
+                     ==,
+                     0x00010001);
+    qtest_writel(qts, NRF51_RTC0_BASE + NRF51_RTC_INTENCLR, 0x00010001);
+    g_assert_cmpuint(qtest_readl(qts, NRF51_RTC0_BASE + NRF51_RTC_INTENSET),
+                     ==,
+                     0x00000000);
+
+    /* Test overflow */
+    rtc_task(qts, NRF51_RTC_TASKS_CLEAR);
+    qtest_writel(qts,
+                 NRF51_RTC0_BASE + NRF51_RTC_EVTENCLR,
+                 0x00000001); /* Disable TICK event */
+    rtc_task(qts, NRF51_RTC_TASKS_TRIGOVRFLW);
+    qtest_writel(qts,
+                 NRF51_RTC0_BASE + NRF51_RTC_EVTENSET,
+                 0x00000002); /* Enable OVRFLW event */
+    qtest_writel(qts,
+                 NRF51_RTC0_BASE + NRF51_RTC_INTENSET,
+                 0x00000002); /* Enable OVRFLW interrupt */
+    rtc_set_prescaler(qts, 0);
+    g_assert_false(qtest_get_irq(qts, 0)); /* No IRQ yet */
+    rtc_task(qts, NRF51_RTC_TASKS_START);
+    qtest_clock_step(qts, tick_ns * 3); /* Advance 3 ticks to overflow */
+    g_assert_cmpuint(qtest_readl(qts, NRF51_RTC0_BASE + NRF51_RTC_COUNTER),
+                     ==,
+                     1); /* Wrapped to 1 */
+    rtc_assert_events(qts, 1, 1, 0, 1, 1, 1);
+    g_assert_true(qtest_get_irq(qts, 0)); /* OVRFLW IRQ */
+    /* Clear overflow & tick */
+    rtc_clear_event(qts, NRF51_RTC_EVENTS_OVRFLW);
+    rtc_clear_event(qts, NRF51_RTC_EVENTS_TICK);
+    /* Clear the spurious compare events */
+    rtc_clear_event(qts, NRF51_RTC_EVENTS_COMPARE1);
+    rtc_clear_event(qts, NRF51_RTC_EVENTS_COMPARE2);
+    rtc_clear_event(qts, NRF51_RTC_EVENTS_COMPARE3);
+    rtc_assert_events(qts, 0, 0, 0, 0, 0, 0);
+    g_assert_false(qtest_get_irq(qts, 0)); /* IRQ cleared */
+
+    /* Test multiple COMPARE registers */
+    rtc_task(qts, NRF51_RTC_TASKS_CLEAR);
+    qtest_writel(qts,
+                 NRF51_RTC0_BASE + NRF51_RTC_EVTENSET,
+                 0x000F0000); /* Enable COMPARE[0-3] events */
+    qtest_writel(qts,
+                 NRF51_RTC0_BASE + NRF51_RTC_INTENSET,
+                 0x000F0000); /* Enable COMPARE[0-3] interrupts */
+    rtc_set_cc(qts, 0, 2);
+    rtc_set_cc(qts, 1, 4);
+    rtc_set_cc(qts, 2, 6);
+    rtc_set_cc(qts, 3, 8);
+    g_assert_false(qtest_get_irq(qts, 0)); /* No IRQ yet */
+    rtc_task(qts, NRF51_RTC_TASKS_START);
+    qtest_clock_step(qts, tick_ns * 3); /* Advance to 3 ticks */
+    rtc_assert_events(qts, 1, 0, 1, 0, 0, 0);
+    g_assert_true(qtest_get_irq(qts, 0)); /* COMPARE0 IRQ */
+    qtest_clock_step(qts, tick_ns * 2);   /* Advance to 5 ticks */
+    rtc_assert_events(qts, 1, 0, 1, 1, 0, 0);
+    g_assert_true(qtest_get_irq(qts, 0)); /* COMPARE1 IRQ */
+    qtest_clock_step(qts, tick_ns * 2);   /* Advance to 7 ticks */
+    rtc_assert_events(qts, 1, 0, 1, 1, 1, 0);
+    g_assert_true(qtest_get_irq(qts, 0)); /* COMPARE2 IRQ */
+    qtest_clock_step(qts, tick_ns * 2);   /* Advance to 9 ticks */
+    rtc_assert_events(qts, 1, 0, 1, 1, 1, 1);
+    g_assert_true(qtest_get_irq(qts, 0)); /* COMPARE3 IRQ */
+    rtc_task(qts, NRF51_RTC_TASKS_STOP);
+
+    qtest_quit(qts);
+}
+
 int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
@@ -548,6 +796,7 @@ int main(int argc, char **argv)
     qtest_add_func("/microbit/nrf51/nvmc", test_nrf51_nvmc);
     qtest_add_func("/microbit/nrf51/timer", test_nrf51_timer);
     qtest_add_func("/microbit/microbit/i2c", test_microbit_i2c);
+    qtest_add_func("/microbit/nrf51/rtc", test_nrf51_rtc);
 
     return g_test_run();
 }
-- 
2.39.5 (Apple Git-154)


