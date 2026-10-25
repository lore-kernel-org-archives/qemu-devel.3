Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3626606A31D
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 17:34:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xL26R-0004At-8p; Sun, 25 Oct 2026 13:33:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <contact@sayyadumar.com>)
 id 1xL25c-0002mU-3Y; Sun, 25 Oct 2026 13:33:07 -0400
Received: from www675.your-server.de ([85.10.213.182])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <contact@sayyadumar.com>)
 id 1xL25U-0007PH-S2; Sun, 25 Oct 2026 13:32:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sayyadumar.com; s=default2511; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=sY4MR7u4WQyIj7u5DGvAixmNpQq9Lbb541rx1qnoJFQ=; b=BmgO8FCcOtzJmi1y0VWIWvZNGI
 eOiwKBAS8taHEIVsGHn1baXcNsT3hvhyX/WcydtlE0Hh2uj+bJC1qS7OalQrI1H8cojccJLw78Q3u
 +p3i6VJDPHrjk5Pasy1HmQSlvsyE30aS1m/KzDgU3S3MsdDnsAGsKTJnKDwdZ3tntkktgGXtwcWJD
 B2AaKbEppDh7IQQtMUsbjc4QcSDPZ2uY4pOmoJpG52kkPji9KJHDlR3zvUXNaUnCvnP2RUu27EDYj
 SyOzIoYAYzsgYtHbpbNUjCFloxAY6UMk0Mgz95Ngp8MDzA34E85Vexr3QithOlotuA0DaPrl/pflP
 31h/Q7hA==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
 by www675.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <contact@sayyadumar.com>)
 id 1xL1gO-00097Q-2S; Sun, 25 Oct 2026 18:06:56 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy01.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <contact@sayyadumar.com>)
 id 1xL1Vw-000OzG-3B; Sun, 25 Oct 2026 17:56:08 +0100
From: Sayyad Mahammad Umar <contact@sayyadumar.com>
Date: Sun, 25 Oct 2026 17:55:42 +0100
Subject: [PATCH v2 26/31] hw/misc: add Renesas RX CRC calculator
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261025-umar-rx-series-v2-26-9e846577cad0@sayyadumar.com>
References: <20261025-umar-rx-series-v2-0-9e846577cad0@sayyadumar.com>
In-Reply-To: <20261025-umar-rx-series-v2-0-9e846577cad0@sayyadumar.com>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>, 
 Alistair Francis <alistair@alistair23.me>, 
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowangio@gmail.com>, 
 qemu-arm@nongnu.org, Sayyad Mahammad Umar <contact@sayyadumar.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792947366; l=10526;
 i=contact@sayyadumar.com; s=qemu; h=from:subject:message-id;
 bh=ney1/4QnelinSnzRtjLVg9AamFVDbqHOGMb9pIs8gNo=;
 b=yYI3PPFDwEX38Vdkjr3E0ztHrZ3vxaLIG6UXgIngjaxnqaFnAKvOkGXt+W7h3SuN8ZMFzwRra
 03S5DD+U25XCm8v46U/7CpMYnixeUSrmbhQQNZyTULAEidt8YYkdWhy
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
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add the RX CRCA, section 42 of the RX65N hardware manual.

Signed-off-by: Sayyad Mahammad Umar <contact@sayyadumar.com>
---
 MAINTAINERS                            |   2 +
 configs/devices/rx-softmmu/default.mak |   1 +
 hw/misc/Kconfig                        |   3 +
 hw/misc/meson.build                    |   1 +
 hw/misc/renesas_rx_crc.c               | 219 +++++++++++++++++++++++++++++++++
 include/hw/misc/renesas_rx_crc.h       |  30 +++++
 6 files changed, 256 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b8bbb0e749..efeb40ee01 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3086,6 +3086,7 @@ F: hw/dma/renesas_rx_*.c
 F: hw/dma/renesas_rx_dtc.c
 F: hw/gpio/renesas_rx_gpio.c
 F: hw/intc/rx_icu.c
+F: hw/misc/renesas_rx_*.c
 F: hw/rtc/renesas_rx_rtc.c
 F: hw/rx/
 F: hw/ssi/renesas_rspi.c
@@ -3095,6 +3096,7 @@ F: include/hw/dma/renesas_rx_*.h
 F: include/hw/dma/renesas_rx_dtc.h
 F: include/hw/gpio/renesas_rx_gpio.h
 F: include/hw/intc/rx_icu.h
+F: include/hw/misc/renesas_rx_*.h
 F: include/hw/rtc/renesas_rx_rtc.h
 F: include/hw/rx/
 F: include/hw/ssi/renesas_rspi.h
diff --git a/configs/devices/rx-softmmu/default.mak b/configs/devices/rx-softmmu/default.mak
index cbc4641143..c8419d64cc 100644
--- a/configs/devices/rx-softmmu/default.mak
+++ b/configs/devices/rx-softmmu/default.mak
@@ -9,3 +9,4 @@ CONFIG_RENESAS_RX_DTC=y
 CONFIG_RENESAS_S12AD=y
 CONFIG_RENESAS_RSPI=y
 CONFIG_RENESAS_RX_RTC=y
+CONFIG_RENESAS_RX_CRC=y
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 7abd22869a..b1c4fd7cba 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -267,3 +267,6 @@ config SOPHGO_CV1800B_CLK
     bool
 
 source macio/Kconfig
+
+config RENESAS_RX_CRC
+    bool
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 90f3f89de7..22f933a17e 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -181,3 +181,4 @@ system_ss.add(when: 'CONFIG_SBSA_REF', if_true: files('sbsa_ec.c'))
 system_ss.add(when: 'CONFIG_LASI', if_true: files('lasi.c'))
 
 system_ss.add(when: 'CONFIG_AXIADO_CLK', if_true: files('axiado_clk.c'))
+system_ss.add(when: 'CONFIG_RENESAS_RX_CRC', if_true: files('renesas_rx_crc.c'))
diff --git a/hw/misc/renesas_rx_crc.c b/hw/misc/renesas_rx_crc.c
new file mode 100644
index 0000000000..f06ac4a64e
--- /dev/null
+++ b/hw/misc/renesas_rx_crc.c
@@ -0,0 +1,219 @@
+/*
+ * Renesas RX CRC Calculator (CRCA)
+ *
+ * Datasheet: RX65N Group, RX651 Group User's Manual: Hardware
+ *            (Rev.2.40 R01UH0590EJ0240), section 42
+ *
+ * Copyright (c) 2026 Umar, Sayyad Mahammad
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Writing to CRCDIR runs the selected polynomial over the data and leaves the
+ * result in CRCDOR, which doubles as the initial value: it is zero out of
+ * reset, DORCLR puts it back, and firmware wanting a different seed writes it
+ * directly. There is no final XOR, so the familiar CRC-32 of a message is
+ * obtained by seeding CRCDOR with all ones and inverting the result.
+ *
+ * CRCCR.LMS picks the bit order. MSB first is the plain shift-left form; LSB
+ * first is the reflected form, computed with the reversed polynomial. The two
+ * worked examples in section 42.3 pin this down: with the CCITT polynomial and
+ * a cleared CRCDOR, feeding 0xf0 gives 0xef1f MSB first and 0xf78f LSB first.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qemu/bitops.h"
+#include "hw/misc/renesas_rx_crc.h"
+#include "hw/core/registerfields.h"
+#include "hw/core/qdev-properties.h"
+#include "migration/vmstate.h"
+
+REG8(CRCCR, 0)
+    FIELD(CRCCR, GPS, 0, 3)
+    FIELD(CRCCR, LMS, 6, 1)
+    FIELD(CRCCR, DORCLR, 7, 1)
+
+#define R_CRCDIR    0x04
+#define R_CRCDOR    0x08
+
+/* CRCCR is read/write apart from the write-only DORCLR bit. */
+#define CRCCR_RW_MASK   (R_CRCCR_GPS_MASK | R_CRCCR_LMS_MASK)
+
+/*
+ * Generating polynomials selected by CRCCR.GPS, without the implicit top
+ * term. Entries 0, 6 and 7 select "no calculation".
+ */
+static const struct {
+    uint32_t poly;
+    uint8_t width;
+} crc_gps[8] = {
+    [1] = { 0x07,       8  },   /* X8 + X2 + X + 1                          */
+    [2] = { 0x8005,     16 },   /* X16 + X15 + X2 + 1                       */
+    [3] = { 0x1021,     16 },   /* X16 + X12 + X5 + 1                       */
+    [4] = { 0x04c11db7, 32 },   /* X32 + X26 + X23 + ... + X2 + X + 1       */
+    [5] = { 0x1edc6f41, 32 },   /* X32 + X28 + X27 + ... + X8 + X6 + 1      */
+};
+
+static uint32_t bitreverse(uint32_t value, unsigned width)
+{
+    return revbit32(value) >> (32 - width);
+}
+
+/* Run nbits of data through the selected polynomial. */
+static void crc_feed(RenesasRxCrcState *s, uint32_t data, unsigned nbits)
+{
+    unsigned gps = FIELD_EX8(s->crccr, CRCCR, GPS);
+    uint32_t poly = crc_gps[gps].poly;
+    unsigned width = crc_gps[gps].width;
+    uint32_t mask, crc;
+
+    if (width == 0) {
+        return;             /* GPS selects no calculation */
+    }
+    if (nbits > width) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "renesas-rx-crc: %u-bit write to CRCDIR with a %u-bit "
+                      "polynomial selected\n", nbits, width);
+        nbits = width;
+    }
+
+    mask = width == 32 ? UINT32_MAX : (1u << width) - 1;
+    crc = s->crcdor & mask;
+
+    if (FIELD_EX8(s->crccr, CRCCR, LMS)) {
+        /* MSB first: shift up, align the data with the top of the register. */
+        crc ^= (data << (width - nbits)) & mask;
+        while (nbits--) {
+            crc = (crc & (mask ^ (mask >> 1))) ? ((crc << 1) ^ poly) & mask
+                                               : (crc << 1) & mask;
+        }
+    } else {
+        /* LSB first: the reflected form, so shift down with a reversed poly. */
+        uint32_t rpoly = bitreverse(poly, width);
+
+        crc ^= data & mask;
+        while (nbits--) {
+            crc = (crc & 1) ? (crc >> 1) ^ rpoly : crc >> 1;
+        }
+    }
+
+    s->crcdor = crc;
+}
+
+static uint64_t crc_read(void *opaque, hwaddr offset, unsigned size)
+{
+    RenesasRxCrcState *s = opaque;
+
+    switch (offset) {
+    case A_CRCCR:
+        /* DORCLR always reads back as 0. */
+        return s->crccr & CRCCR_RW_MASK;
+    case R_CRCDIR:
+        /*
+         * CRCDIR is documented readable, but the hardware keeps no separate
+         * copy of the data written to it, so nothing meaningful comes back.
+         */
+        return 0;
+    case R_CRCDOR:
+        if (size >= 4) {
+            return s->crcdor;
+        }
+        return s->crcdor & ((1u << (size * 8)) - 1);
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "renesas-rx-crc: read from unmapped offset 0x%"
+                      HWADDR_PRIx "\n", offset);
+        return 0;
+    }
+}
+
+static void crc_write(void *opaque, hwaddr offset, uint64_t value,
+                      unsigned size)
+{
+    RenesasRxCrcState *s = opaque;
+
+    switch (offset) {
+    case A_CRCCR:
+        s->crccr = value & CRCCR_RW_MASK;
+        if (FIELD_EX8(value, CRCCR, DORCLR)) {
+            s->crcdor = 0;
+        }
+        break;
+    case R_CRCDIR:
+        crc_feed(s, value, size * 8);
+        break;
+    case R_CRCDOR:
+        /* Writable so firmware can seed the calculation. */
+        if (size >= 4) {
+            s->crcdor = value;
+        } else {
+            uint32_t m = (1u << (size * 8)) - 1;
+            s->crcdor = (s->crcdor & ~m) | (value & m);
+        }
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "renesas-rx-crc: write to unmapped offset 0x%"
+                      HWADDR_PRIx "\n", offset);
+        break;
+    }
+}
+
+static const MemoryRegionOps crc_ops = {
+    .read = crc_read,
+    .write = crc_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl = { .min_access_size = 1, .max_access_size = 4 },
+    .valid = { .min_access_size = 1, .max_access_size = 4 },
+};
+
+static void rx_crc_reset(DeviceState *dev)
+{
+    RenesasRxCrcState *s = RENESAS_RX_CRC(dev);
+
+    s->crccr = 0;
+    s->crcdor = 0;
+}
+
+static void rx_crc_init(Object *obj)
+{
+    RenesasRxCrcState *s = RENESAS_RX_CRC(obj);
+
+    memory_region_init_io(&s->memory, obj, &crc_ops, s,
+                          "renesas-rx-crc", RX_CRC_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->memory);
+}
+
+static const VMStateDescription vmstate_rx_crc = {
+    .name = "renesas-rx-crc",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT8(crccr, RenesasRxCrcState),
+        VMSTATE_UINT32(crcdor, RenesasRxCrcState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void rx_crc_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->vmsd = &vmstate_rx_crc;
+    device_class_set_legacy_reset(dc, rx_crc_reset);
+}
+
+static const TypeInfo rx_crc_info = {
+    .name          = TYPE_RENESAS_RX_CRC,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(RenesasRxCrcState),
+    .instance_init = rx_crc_init,
+    .class_init    = rx_crc_class_init,
+};
+
+static void rx_crc_register_types(void)
+{
+    type_register_static(&rx_crc_info);
+}
+
+type_init(rx_crc_register_types)
diff --git a/include/hw/misc/renesas_rx_crc.h b/include/hw/misc/renesas_rx_crc.h
new file mode 100644
index 0000000000..1c41b6bd4b
--- /dev/null
+++ b/include/hw/misc/renesas_rx_crc.h
@@ -0,0 +1,30 @@
+/*
+ * Renesas RX CRC Calculator (CRCA)
+ *
+ * Copyright (c) 2026 Umar, Sayyad Mahammad
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_MISC_RENESAS_RX_CRC_H
+#define HW_MISC_RENESAS_RX_CRC_H
+
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_RENESAS_RX_CRC "renesas-rx-crc"
+OBJECT_DECLARE_SIMPLE_TYPE(RenesasRxCrcState, RENESAS_RX_CRC)
+
+/* CRCCR, CRCDIR and CRCDOR occupy 0x8280, 0x8284 and 0x8288. */
+#define RX_CRC_SIZE     0x10
+
+struct RenesasRxCrcState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion memory;
+
+    uint8_t crccr;      /* control: GPS[2:0], LMS, DORCLR */
+    uint32_t crcdor;    /* running result, also the initial value */
+};
+
+#endif /* HW_MISC_RENESAS_RX_CRC_H */

-- 
2.53.0


