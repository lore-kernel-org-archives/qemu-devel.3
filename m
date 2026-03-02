Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32C29EB363C
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 22:04:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxBMI-0000Rn-Fi; Mon, 02 Mar 2026 17:03:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vxBMH-0000Qy-6N
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 17:03:21 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vxBMF-0001AT-5Z
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 17:03:20 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-4376acce52eso3342834f8f.1
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 14:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772488997; x=1773093797; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zLewkWpDZG84wNf0xW0RFI07PgVNVsc0k+H5ou4siNA=;
 b=glPCuHJCGG7NTjoFBfFUV7QB+YjFisayE8GSCt17aeE/VVc9n6mV9Y9UuLqZp4HFRK
 Omc7Qt+bQzlRh9Cr17AIRMkfKlE+FsfA8Dc4bzHqK15Q1KkGyf5LiQPySt1Z99P68IMb
 VmyUcu7Xrp0uoPbZXnM8ftMIOzykaNOitHOADGY6rR0A3Lw0fs86IWnt20UN7zvpcv5g
 A43KeW2ys7ZIvn15J/EIMveoEDB9HyMnpiYVdMV2hWHgs7EC/zi1uF2kJ00RM+SusfGj
 zdW5V7DdXUHwGWZHZGNh1Vl9PNSNyFViIpW7qmuhK5/gESYsxDcPIcEosu1UftFvP8r3
 qbiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772488997; x=1773093797;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zLewkWpDZG84wNf0xW0RFI07PgVNVsc0k+H5ou4siNA=;
 b=gTfkWgrFyJsSOLm4j3S67NPV4PiVnioXw04JqnLoejlst47xySkhiKeRvaJmRRe3fz
 xmRPm7fi8rIU3Tb+61z3xxugt8vACTbNjnMq02e0UgDxoWOQbcdd6B1Lp1OVWmS973RZ
 Tp6TvSEo0WhRWmyJBltMYaY33XFA6InsgaQpI3WU76Fx0sJifqbFJF6dHC8vMjYOXfSA
 wFYG3BKRoPa9khC9o5I6i0qgdrzv3NpQvijxYwk8MlwOvwYE77MfC9fyAmdFyBVOwPqi
 XmxQPSTzy7OfBng1lipnQe62jtPD6TL9ZaI6IEtOl1rDC/ROFvLHt9qxl3G+psyGmKYe
 RYKQ==
X-Gm-Message-State: AOJu0Yykr0iqysk6rqjR9DmQGRsf5hH+9w6LRmtKwe3to+zL6bQXI5je
 R6DQY1kPjyVLhiJwPli6WQ1yT/MbvAweA2eIPtzW5O1jvt7YR9FwsX4Ppiehjg==
X-Gm-Gg: ATEYQzwLWMIvUed2jvufy4gnvSaKO0zEsslCBoepmWqzVE9vWsh5bM3+K9HwMaaJmcp
 qsQSN1xzpruQRFX762nb3oyE91Y8XTo/YCtt3Ly4Lx2wc0RztyslPuQmp1NAriRWTcYud7tpZ6y
 3Qy3Pn3INWQI2iAa05Lr+FEZfd3CwOvVynDci/nKchUj89jjt5NyOYmDb4U4xLqVagYNoKZXQrQ
 KsnqSvXy/+CtZrXX9yw7q26JRG5Ij9A2wUV+F6qsOWvKSzKQn363mgY7a+w59UvRa575YmD35Js
 JPWyfAfJYz9UOH8pFcGFGvZcOxo5SynDc9e/1F57H7MO5Ca0dcwaMj0c6rTU/CQ73RH+xYKNVHg
 FbiCDvRdyBT6l0rF7cYFNdrX40SgEpDwpsU40YhpEtaorYwMui5HrWFGCMr1rMoCwg5Qmd7YaJj
 gzLF/q4l+szdkpgYk9OnOi3s3sKoxPnhRteo0Kt8CjCpqZqQcanFBiwRlvjXLp5TYL4UDxLSZ53
 EI8a312uy/N7QGbgAQynq2LJ/FP/Tq87mB7LfBv50O5gex7HeKQn7SWVg==
X-Received: by 2002:a05:6000:2388:b0:437:7168:af37 with SMTP id
 ffacd0b85a97d-4399de2c3eamr23297743f8f.42.1772488997128; 
 Mon, 02 Mar 2026 14:03:17 -0800 (PST)
Received: from Provence.localdomain
 (dynamic-2a02-3100-2e0b-4800-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:2e0b:4800:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4399c765c38sm29308102f8f.31.2026.03.02.14.03.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 14:03:16 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-arm@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Helge Deller <deller@gmx.de>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Troy Lee <leetroy@gmail.com>, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 11/12] hw/char: Have SerialState inherit from SysBusDevice
Date: Mon,  2 Mar 2026 23:02:53 +0100
Message-ID: <20260302220254.1166849-12-shentey@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302220254.1166849-1-shentey@gmail.com>
References: <20260302220254.1166849-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

SerialState currently inherits just from DeviceState and serial devices
use SerialState as an "IP block". Since DeviceState doesn't have an API
to provide MMIO regions or IRQs, all serial devices access attributes
internal to SerialState directly. Fix this by having SerialState inherit
from SysBusDevice.

In addition, SerialState doesn't participate in the reset framework
while SysBusDevice does. This allows for implementing reset
functionality more idiomatically.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 include/hw/char/serial.h   |  4 ++--
 hw/char/diva-gsp.c         | 22 +++++++++++-----------
 hw/char/serial-isa.c       | 19 ++++++++++++-------
 hw/char/serial-mm.c        | 10 +++++-----
 hw/char/serial-pci-multi.c | 22 +++++++++++-----------
 hw/char/serial-pci.c       | 13 +++++++------
 hw/char/serial.c           |  5 ++++-
 7 files changed, 52 insertions(+), 43 deletions(-)

diff --git a/include/hw/char/serial.h b/include/hw/char/serial.h
index ea82ffac47..650fc27693 100644
--- a/include/hw/char/serial.h
+++ b/include/hw/char/serial.h
@@ -26,7 +26,7 @@
 #ifndef HW_SERIAL_H
 #define HW_SERIAL_H
 
-#include "hw/core/qdev.h"
+#include "hw/core/sysbus.h"
 #include "chardev/char-fe.h"
 #include "system/memory.h"
 #include "qemu/fifo8.h"
@@ -35,7 +35,7 @@
 #define UART_FIFO_LENGTH    16      /* 16550A Fifo Length */
 
 struct SerialState {
-    DeviceState parent;
+    SysBusDevice parent;
 
     uint16_t divider;
     uint8_t rbr; /* receive register */
diff --git a/hw/char/diva-gsp.c b/hw/char/diva-gsp.c
index 280d0413c6..60ddc78752 100644
--- a/hw/char/diva-gsp.c
+++ b/hw/char/diva-gsp.c
@@ -57,13 +57,13 @@ typedef struct PCIDivaSerialState {
 static void diva_pci_exit(PCIDevice *dev)
 {
     PCIDivaSerialState *pci = DO_UPCAST(PCIDivaSerialState, dev, dev);
-    SerialState *s;
     int i;
 
     for (i = 0; i < pci->ports; i++) {
-        s = pci->state + i;
-        qdev_unrealize(DEVICE(s));
-        memory_region_del_subregion(&pci->membar, &s->io);
+        SysBusDevice *sbd = SYS_BUS_DEVICE(pci->state + i);
+        qdev_unrealize(DEVICE(sbd));
+        memory_region_del_subregion(&pci->membar,
+                                    sysbus_mmio_get_region(sbd, 0));
         g_free(pci->name[i]);
     }
     qemu_free_irqs(pci->irqs, pci->ports);
@@ -118,7 +118,6 @@ static void diva_pci_realize(PCIDevice *dev, Error **errp)
 {
     PCIDeviceClass *pc = PCI_DEVICE_GET_CLASS(dev);
     PCIDivaSerialState *pci = DO_UPCAST(PCIDivaSerialState, dev, dev);
-    SerialState *s;
     struct diva_info di = diva_get_diva_info(pc);
     size_t i, offset = 0;
     size_t portmask = di.omask;
@@ -130,22 +129,23 @@ static void diva_pci_realize(PCIDevice *dev, Error **errp)
     pci->irqs = qemu_allocate_irqs(multi_serial_irq_mux, pci, di.nports);
 
     for (i = 0; i < di.nports; i++) {
-        s = pci->state + i;
-        if (!qdev_realize(DEVICE(s), NULL, errp)) {
+        SysBusDevice *sbd = SYS_BUS_DEVICE(pci->state + i);
+        if (!sysbus_realize(sbd, errp)) {
             diva_pci_exit(dev);
             return;
         }
-        s->irq = pci->irqs[i];
+        sysbus_connect_irq(sbd, 0, pci->irqs[i]);
         pci->name[i] = g_strdup_printf("uart #%zu", i + 1);
-        memory_region_init_io(&s->io, OBJECT(pci), &serial_io_ops, s,
-                              pci->name[i], 8);
+        memory_region_init_io(sysbus_mmio_get_region(sbd, 0), OBJECT(pci),
+                              &serial_io_ops, sbd, pci->name[i], 8);
 
         /* calculate offset of given port based on bitmask */
         while ((portmask & BIT(0)) == 0) {
             offset += 8;
             portmask >>= 1;
         }
-        memory_region_add_subregion(&pci->membar, offset, &s->io);
+        memory_region_add_subregion(&pci->membar, offset,
+                                    sysbus_mmio_get_region(sbd, 0));
         offset += 8;
         portmask >>= 1;
         pci->ports++;
diff --git a/hw/char/serial-isa.c b/hw/char/serial-isa.c
index a4be0492c5..d3a401f56c 100644
--- a/hw/char/serial-isa.c
+++ b/hw/char/serial-isa.c
@@ -58,7 +58,7 @@ static void serial_isa_realizefn(DeviceState *dev, Error **errp)
     static int index;
     ISADevice *isadev = ISA_DEVICE(dev);
     ISASerialState *isa = ISA_SERIAL(dev);
-    SerialState *s = &isa->state;
+    SysBusDevice *sbd = SYS_BUS_DEVICE(&isa->state);
 
     if (isa->index == -1) {
         isa->index = index;
@@ -76,12 +76,13 @@ static void serial_isa_realizefn(DeviceState *dev, Error **errp)
     }
     index++;
 
-    s->irq = isa_get_irq(isadev, isa->isairq);
-    qdev_realize(DEVICE(s), NULL, errp);
+    sysbus_realize(sbd, errp);
+    sysbus_connect_irq(sbd, 0, isa_get_irq(isadev, isa->isairq));
     qdev_set_legacy_instance_id(dev, isa->iobase, 3);
 
-    memory_region_init_io(&s->io, OBJECT(isa), &serial_io_ops, s, "serial", 8);
-    isa_register_ioport(isadev, &s->io, isa->iobase);
+    memory_region_init_io(sysbus_mmio_get_region(sbd, 0), OBJECT(isa),
+                          &serial_io_ops, sbd, "serial", 8);
+    isa_register_ioport(isadev, sysbus_mmio_get_region(sbd, 0), isa->iobase);
 }
 
 static void serial_isa_build_aml(AcpiDevAmlIf *adev, Aml *scope)
@@ -188,13 +189,17 @@ void serial_hds_isa_init(ISABus *bus, int from, int to)
 void isa_serial_set_iobase(ISADevice *serial, hwaddr iobase)
 {
     ISASerialState *s = ISA_SERIAL(serial);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(&s->state);
 
     serial->ioport_id = iobase;
     s->iobase = iobase;
-    memory_region_set_address(&s->state.io, s->iobase);
+    memory_region_set_address(sysbus_mmio_get_region(sbd, 0), s->iobase);
 }
 
 void isa_serial_set_enabled(ISADevice *serial, bool enabled)
 {
-    memory_region_set_enabled(&ISA_SERIAL(serial)->state.io, enabled);
+    ISASerialState *s = ISA_SERIAL(serial);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(&s->state);
+
+    memory_region_set_enabled(sysbus_mmio_get_region(sbd, 0), enabled);
 }
diff --git a/hw/char/serial-mm.c b/hw/char/serial-mm.c
index 0e0be26fa9..de11498278 100644
--- a/hw/char/serial-mm.c
+++ b/hw/char/serial-mm.c
@@ -71,17 +71,17 @@ static const MemoryRegionOps serial_mm_ops[] = {
 static void serial_mm_realize(DeviceState *dev, Error **errp)
 {
     SerialMM *smm = SERIAL_MM(dev);
-    SerialState *s = &smm->serial;
+    SysBusDevice *sbd = SYS_BUS_DEVICE(&smm->serial);
 
-    if (!qdev_realize(DEVICE(s), NULL, errp)) {
+    if (!sysbus_realize(sbd, errp)) {
         return;
     }
 
-    memory_region_init_io(&s->io, OBJECT(dev),
+    memory_region_init_io(sysbus_mmio_get_region(sbd, 0), OBJECT(dev),
                           &serial_mm_ops[smm->endianness], smm, "serial",
                           8 << smm->regshift);
-    sysbus_init_mmio(SYS_BUS_DEVICE(smm), &s->io);
-    sysbus_init_irq(SYS_BUS_DEVICE(smm), &smm->serial.irq);
+    sysbus_init_mmio(SYS_BUS_DEVICE(smm), sysbus_mmio_get_region(sbd, 0));
+    sysbus_pass_irq(SYS_BUS_DEVICE(smm), SYS_BUS_DEVICE(sbd));
 }
 
 static const VMStateDescription vmstate_serial_mm = {
diff --git a/hw/char/serial-pci-multi.c b/hw/char/serial-pci-multi.c
index 17796b93dd..7545ab7425 100644
--- a/hw/char/serial-pci-multi.c
+++ b/hw/char/serial-pci-multi.c
@@ -51,13 +51,13 @@ typedef struct PCIMultiSerialState {
 static void multi_serial_pci_exit(PCIDevice *dev)
 {
     PCIMultiSerialState *pci = DO_UPCAST(PCIMultiSerialState, dev, dev);
-    SerialState *s;
     int i;
 
     for (i = 0; i < pci->ports; i++) {
-        s = pci->state + i;
-        qdev_unrealize(DEVICE(s));
-        memory_region_del_subregion(&pci->iobar, &s->io);
+        SysBusDevice *sbd = SYS_BUS_DEVICE(pci->state + i);
+        qdev_unrealize(DEVICE(sbd));
+        memory_region_del_subregion(&pci->iobar,
+                                    sysbus_mmio_get_region(sbd, 0));
         g_free(pci->name[i]);
     }
 }
@@ -93,7 +93,6 @@ static void multi_serial_pci_realize(PCIDevice *dev, Error **errp)
 {
     PCIDeviceClass *pc = PCI_DEVICE_GET_CLASS(dev);
     PCIMultiSerialState *pci = DO_UPCAST(PCIMultiSerialState, dev, dev);
-    SerialState *s;
     size_t i, nports = multi_serial_get_port_count(pc);
 
     pci->dev.config[PCI_CLASS_PROG] = 2; /* 16550 compatible */
@@ -102,16 +101,17 @@ static void multi_serial_pci_realize(PCIDevice *dev, Error **errp)
     pci_register_bar(&pci->dev, 0, PCI_BASE_ADDRESS_SPACE_IO, &pci->iobar);
 
     for (i = 0; i < nports; i++) {
-        s = pci->state + i;
-        if (!qdev_realize(DEVICE(s), NULL, errp)) {
+        SysBusDevice *sbd = SYS_BUS_DEVICE(pci->state + i);
+        if (!sysbus_realize(sbd, errp)) {
             multi_serial_pci_exit(dev);
             return;
         }
-        s->irq = &pci->irqs[i];
+        sysbus_connect_irq(sbd, 0, &pci->irqs[i]);
         pci->name[i] = g_strdup_printf("uart #%zu", i + 1);
-        memory_region_init_io(&s->io, OBJECT(pci), &serial_io_ops, s,
-                              pci->name[i], 8);
-        memory_region_add_subregion(&pci->iobar, 8 * i, &s->io);
+        memory_region_init_io(sysbus_mmio_get_region(sbd, 0), OBJECT(pci),
+                              &serial_io_ops, sbd, pci->name[i], 8);
+        memory_region_add_subregion(&pci->iobar, 8 * i,
+                                    sysbus_mmio_get_region(sbd, 0));
         pci->ports++;
     }
 }
diff --git a/hw/char/serial-pci.c b/hw/char/serial-pci.c
index d8cacc9085..10a99592b6 100644
--- a/hw/char/serial-pci.c
+++ b/hw/char/serial-pci.c
@@ -46,18 +46,20 @@ OBJECT_DECLARE_SIMPLE_TYPE(PCISerialState, PCI_SERIAL)
 static void serial_pci_realize(PCIDevice *dev, Error **errp)
 {
     PCISerialState *pci = DO_UPCAST(PCISerialState, dev, dev);
-    SerialState *s = &pci->state;
+    SysBusDevice *sbd = SYS_BUS_DEVICE(&pci->state);
 
-    if (!qdev_realize(DEVICE(s), NULL, errp)) {
+    if (!sysbus_realize(sbd, errp)) {
         return;
     }
 
     pci->dev.config[PCI_CLASS_PROG] = 2; /* 16550 compatible */
     pci->dev.config[PCI_INTERRUPT_PIN] = 1;
-    s->irq = pci_allocate_irq(&pci->dev);
+    sysbus_connect_irq(sbd, 0, pci_allocate_irq(&pci->dev));
 
-    memory_region_init_io(&s->io, OBJECT(pci), &serial_io_ops, s, "serial", 8);
-    pci_register_bar(&pci->dev, 0, PCI_BASE_ADDRESS_SPACE_IO, &s->io);
+    memory_region_init_io(sysbus_mmio_get_region(sbd, 0), OBJECT(pci),
+                          &serial_io_ops, sbd, "serial", 8);
+    pci_register_bar(&pci->dev, 0, PCI_BASE_ADDRESS_SPACE_IO,
+                     sysbus_mmio_get_region(sbd, 0));
 }
 
 static void serial_pci_exit(PCIDevice *dev)
@@ -66,7 +68,6 @@ static void serial_pci_exit(PCIDevice *dev)
     SerialState *s = &pci->state;
 
     qdev_unrealize(DEVICE(s));
-    qemu_free_irq(s->irq);
 }
 
 static const VMStateDescription vmstate_pci_serial = {
diff --git a/hw/char/serial.c b/hw/char/serial.c
index 0f3469a1e8..c58337bd20 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -934,6 +934,9 @@ static void serial_realize(DeviceState *dev, Error **errp)
                              serial_event, serial_be_change, s, NULL, true);
     fifo8_create(&s->recv_fifo, UART_FIFO_LENGTH);
     fifo8_create(&s->xmit_fifo, UART_FIFO_LENGTH);
+
+    sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->io);
+    sysbus_init_irq(SYS_BUS_DEVICE(s), &s->irq);
 }
 
 static void serial_unrealize(DeviceState *dev)
@@ -984,7 +987,7 @@ static void serial_class_init(ObjectClass *klass, const void *data)
 
 static const TypeInfo serial_info = {
     .name = TYPE_SERIAL,
-    .parent = TYPE_DEVICE,
+    .parent = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(SerialState),
     .class_init = serial_class_init,
 };
-- 
2.53.0


