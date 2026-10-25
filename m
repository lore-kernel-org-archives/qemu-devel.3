Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F71606A31B
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 17:35:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xL26V-0004fq-M3; Sun, 25 Oct 2026 13:33:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <contact@sayyadumar.com>)
 id 1xL25H-0002R5-Sm; Sun, 25 Oct 2026 13:32:43 -0400
Received: from www675.your-server.de ([85.10.213.182])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <contact@sayyadumar.com>)
 id 1xL25F-0007OL-Uj; Sun, 25 Oct 2026 13:32:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sayyadumar.com; s=default2511; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=yqiVQm2uxF8h7YlBOlfy8QpJTGMKaJUh8ewNs/GVT9I=; b=n/0L0XAMfCMIojXN48SrIrHSjy
 1zJ8gXCIOQpJmU8NEkBi15Bt2IwKNjvNybW1EHNW/n0Lvly4/4ceBaUsdRXMftVxcdxAV3cvLscnf
 nFknGhhuDeMHVPoskGURm1gKQRVMCJPayy6ZRClzUidUpes7natMSSruB0JzGmkM5cG9NPt0fbgHf
 YE5e850GexKNlSDgubk97tos65U69lvvJgThD3oYQqtyMq20uH+kiAeGOHQqQ4aH52D1iwAlsPcpL
 tc/6HVApJi09fwUGqgrxGmVUFC2KnouRvnqDiDFcZdak9cXKRE+0SAetMIRvyOQksueB/ILEyjMmQ
 cOSnTBnA==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
 by www675.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <contact@sayyadumar.com>)
 id 1xL1gO-00097I-17; Sun, 25 Oct 2026 18:06:56 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy01.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <contact@sayyadumar.com>)
 id 1xL1Vw-000OzG-2I; Sun, 25 Oct 2026 17:56:08 +0100
From: Sayyad Mahammad Umar <contact@sayyadumar.com>
Date: Sun, 25 Oct 2026 17:55:38 +0100
Subject: [PATCH v2 22/31] hw/dma: add Renesas RX DTC
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261025-umar-rx-series-v2-22-9e846577cad0@sayyadumar.com>
References: <20261025-umar-rx-series-v2-0-9e846577cad0@sayyadumar.com>
In-Reply-To: <20261025-umar-rx-series-v2-0-9e846577cad0@sayyadumar.com>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>, 
 Alistair Francis <alistair@alistair23.me>, 
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowangio@gmail.com>, 
 qemu-arm@nongnu.org, Sayyad Mahammad Umar <contact@sayyadumar.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792947366; l=8844;
 i=contact@sayyadumar.com; s=qemu; h=from:subject:message-id;
 bh=0IDDL1GJ4GvlVMGRInc97lXLw7QBPz6EVLbNUCbsUts=;
 b=7rFCijpryNlnxTgwOqXZP4ul+d1/L0dwP0tqsfk0IX0DjcH7PkFe+xY7kKFDhafkP4nRczNKL
 82rIYAlkJcNC3mPpJiwr1vShDkFZgXeGRZY0soNYRaFwvTGNlqRpZNE
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

Add the RX Data Transfer Controller, section 18 (DTC) of the RX65N
hardware manual.

Signed-off-by: Sayyad Mahammad Umar <contact@sayyadumar.com>
---
 MAINTAINERS                            |   2 +
 configs/devices/rx-softmmu/default.mak |   1 +
 hw/dma/Kconfig                         |   3 +
 hw/dma/meson.build                     |   1 +
 hw/dma/renesas_rx_dtc.c                | 169 +++++++++++++++++++++++++++++++++
 include/hw/dma/renesas_rx_dtc.h        |  42 ++++++++
 6 files changed, 218 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d36aa0afa1..e747530308 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3082,11 +3082,13 @@ Renesas RX peripherals
 R: Yoshinori Sato <yoshinori.sato@nifty.com>
 S: Orphan
 F: hw/dma/renesas_rx_*.c
+F: hw/dma/renesas_rx_dtc.c
 F: hw/gpio/renesas_rx_gpio.c
 F: hw/intc/rx_icu.c
 F: hw/rx/
 F: hw/timer/renesas_mtu3.c
 F: include/hw/dma/renesas_rx_*.h
+F: include/hw/dma/renesas_rx_dtc.h
 F: include/hw/gpio/renesas_rx_gpio.h
 F: include/hw/intc/rx_icu.h
 F: include/hw/rx/
diff --git a/configs/devices/rx-softmmu/default.mak b/configs/devices/rx-softmmu/default.mak
index f14a65dac7..9e0e1ef31d 100644
--- a/configs/devices/rx-softmmu/default.mak
+++ b/configs/devices/rx-softmmu/default.mak
@@ -5,3 +5,4 @@
 CONFIG_RENESAS_MTU3=y
 CONFIG_RENESAS_RX_GPIO=y
 CONFIG_RENESAS_RX_DMAC=y
+CONFIG_RENESAS_RX_DTC=y
diff --git a/hw/dma/Kconfig b/hw/dma/Kconfig
index 2c95b8696d..8c70bc18c2 100644
--- a/hw/dma/Kconfig
+++ b/hw/dma/Kconfig
@@ -36,3 +36,6 @@ config K230_GSDMA
 
 config RENESAS_RX_DMAC
     bool
+
+config RENESAS_RX_DTC
+    bool
diff --git a/hw/dma/meson.build b/hw/dma/meson.build
index 1fb06fb13d..671b9aba29 100644
--- a/hw/dma/meson.build
+++ b/hw/dma/meson.build
@@ -14,3 +14,4 @@ system_ss.add(when: 'CONFIG_SIFIVE_PDMA', if_true: files('sifive_pdma.c'))
 system_ss.add(when: 'CONFIG_XLNX_CSU_DMA', if_true: files('xlnx_csu_dma.c'))
 system_ss.add(when: 'CONFIG_K230_GSDMA', if_true: files('k230_gsdma.c'))
 system_ss.add(when: 'CONFIG_RENESAS_RX_DMAC', if_true: files('renesas_rx_dmac.c'))
+system_ss.add(when: 'CONFIG_RENESAS_RX_DTC', if_true: files('renesas_rx_dtc.c'))
diff --git a/hw/dma/renesas_rx_dtc.c b/hw/dma/renesas_rx_dtc.c
new file mode 100644
index 0000000000..10ac87be9a
--- /dev/null
+++ b/hw/dma/renesas_rx_dtc.c
@@ -0,0 +1,169 @@
+/*
+ * Renesas RX Data Transfer Controller (DTC)
+ *
+ * Datasheet: RX65N Group, RX651 Group User's Manual: Hardware
+ *            (Rev.1.00 R01UH0590EJ0100), section 18 (DTC)
+ *
+ * Copyright (c) 2026 Umar, Sayyad Mahammad
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ *
+ * Register-level model of the DTC. The DTC fetches RAM-resident transfer
+ * descriptors when activated by a peripheral interrupt; that activation path is
+ * not modelled, so the control/status registers behave as storage and the
+ * module always reports idle. This lets FIT/RTOS drivers configure and enable
+ * the DTC (and fall back to interrupt-driven transfers) without faulting.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "hw/dma/renesas_rx_dtc.h"
+#include "hw/core/qdev-properties.h"
+#include "migration/vmstate.h"
+
+#define R_DTCCR     0x00    /* 8-bit  */
+#define R_DTCVBR    0x04    /* 32-bit */
+#define R_DTCADMOD  0x08    /* 8-bit  */
+#define R_DTCST     0x0C    /* 8-bit  */
+#define R_DTCSTS    0x0E    /* 16-bit */
+#define R_DTCIBR    0x10    /* 32-bit */
+#define R_DTCOR     0x14    /* 8-bit  */
+#define R_DTCEXBR   0x18    /* 16-bit */
+
+static uint64_t dtc_read(void *opaque, hwaddr offset, unsigned size)
+{
+    RenesasRxDtcState *s = opaque;
+
+    switch (offset) {
+    case R_DTCCR:
+        return s->dtccr;
+    case R_DTCVBR:
+        return s->dtcvbr;
+    case R_DTCADMOD:
+        return s->dtcadmod;
+    case R_DTCST:
+        return s->dtcst;
+    case R_DTCSTS:
+        /*ACT=0: never busy */
+        return s->dtcsts;
+    case R_DTCIBR:
+        return s->dtcibr;
+    case R_DTCOR:
+        return s->dtcor;
+    case R_DTCEXBR:
+        return s->dtcexbr;
+    default:
+        qemu_log_mask(LOG_UNIMP, "renesas-rx-dtc: read unimplemented 0x%"
+                      HWADDR_PRIx "\n", offset);
+        return 0;
+    }
+}
+
+static void dtc_write(void *opaque, hwaddr offset, uint64_t value,
+                      unsigned size)
+{
+    RenesasRxDtcState *s = opaque;
+
+    switch (offset) {
+    case R_DTCCR:
+        s->dtccr = value;
+        break;
+    case R_DTCVBR:
+        s->dtcvbr = value;
+        break;
+    case R_DTCADMOD:
+        s->dtcadmod = value;
+        break;
+    case R_DTCST:
+        s->dtcst = value;
+        break;
+    case R_DTCIBR:
+        s->dtcibr = value;
+        break;
+    case R_DTCOR:
+        s->dtcor = value;
+        break;
+    case R_DTCEXBR:
+        s->dtcexbr = value;
+        break;
+    case R_DTCSTS:
+        /*status, read-only */
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "renesas-rx-dtc: write unimplemented 0x%"
+                      HWADDR_PRIx "\n", offset);
+        break;
+    }
+}
+
+static const MemoryRegionOps dtc_ops = {
+    .read = dtc_read,
+    .write = dtc_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl = { .min_access_size = 1, .max_access_size = 4 },
+    .valid = { .min_access_size = 1, .max_access_size = 4 },
+};
+
+static void rx_dtc_reset(DeviceState *dev)
+{
+    RenesasRxDtcState *s = RENESAS_RX_DTC(dev);
+
+    s->dtccr = 0x08;    /* RRS = 1 out of reset */
+    s->dtcvbr = 0;
+    s->dtcadmod = 0;
+    s->dtcst = 0;
+    s->dtcsts = 0;
+    s->dtcibr = 0;
+    s->dtcor = 0;
+    s->dtcexbr = 0;
+}
+
+static void rx_dtc_init(Object *obj)
+{
+    RenesasRxDtcState *s = RENESAS_RX_DTC(obj);
+
+    memory_region_init_io(&s->mr, obj, &dtc_ops, s,
+                          "renesas-rx-dtc", RX_DTC_REGS_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mr);
+}
+
+static const VMStateDescription vmstate_rx_dtc = {
+    .name = "renesas-rx-dtc",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT8(dtccr, RenesasRxDtcState),
+        VMSTATE_UINT32(dtcvbr, RenesasRxDtcState),
+        VMSTATE_UINT8(dtcadmod, RenesasRxDtcState),
+        VMSTATE_UINT8(dtcst, RenesasRxDtcState),
+        VMSTATE_UINT16(dtcsts, RenesasRxDtcState),
+        VMSTATE_UINT32(dtcibr, RenesasRxDtcState),
+        VMSTATE_UINT8(dtcor, RenesasRxDtcState),
+        VMSTATE_UINT16(dtcexbr, RenesasRxDtcState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void rx_dtc_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->vmsd = &vmstate_rx_dtc;
+    device_class_set_legacy_reset(dc, rx_dtc_reset);
+}
+
+static const TypeInfo rx_dtc_info = {
+    .name = TYPE_RENESAS_RX_DTC,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(RenesasRxDtcState),
+    .instance_init = rx_dtc_init,
+    .class_init = rx_dtc_class_init,
+};
+
+static void rx_dtc_register_types(void)
+{
+    type_register_static(&rx_dtc_info);
+}
+
+type_init(rx_dtc_register_types)
diff --git a/include/hw/dma/renesas_rx_dtc.h b/include/hw/dma/renesas_rx_dtc.h
new file mode 100644
index 0000000000..aa02bf5d66
--- /dev/null
+++ b/include/hw/dma/renesas_rx_dtc.h
@@ -0,0 +1,42 @@
+/*
+ * Renesas RX Data Transfer Controller (DTC)
+ *
+ * Datasheet: RX65N Group, RX651 Group User's Manual: Hardware
+ *            (Rev.1.00 R01UH0590EJ0100), section 18 (DTC)
+ *
+ * Copyright (c) 2026 Umar, Sayyad Mahammad
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ */
+
+#ifndef HW_DMA_RENESAS_RX_DTC_H
+#define HW_DMA_RENESAS_RX_DTC_H
+
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_RENESAS_RX_DTC "renesas-rx-dtc"
+typedef struct RenesasRxDtcState RenesasRxDtcState;
+DECLARE_INSTANCE_CHECKER(RenesasRxDtcState, RENESAS_RX_DTC, TYPE_RENESAS_RX_DTC)
+
+#define RX_DTC_REGS_SIZE    0x20
+
+struct RenesasRxDtcState {
+    /*< private >*/
+    SysBusDevice parent_obj;
+    /*< public >*/
+
+    MemoryRegion mr;
+
+    uint8_t  dtccr;     /* control                    */
+    uint32_t dtcvbr;    /* vector base address        */
+    uint8_t  dtcadmod;  /* address mode               */
+    uint8_t  dtcst;     /* module start               */
+    uint16_t dtcsts;    /* status                     */
+    uint32_t dtcibr;    /* index table base           */
+    uint8_t  dtcor;     /* operation                  */
+    uint16_t dtcexbr;   /* extended repeat-area base  */
+};
+
+#endif /* HW_DMA_RENESAS_RX_DTC_H */

-- 
2.53.0


