Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C0A1F513E1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 22:11:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyGtM-0001dj-9s; Thu, 05 Mar 2026 17:10:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vyGt5-0001EB-6q
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 17:09:43 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vyGt0-0002JP-M3
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 17:09:41 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4836f363d0dso75686595e9.3
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 14:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772748577; x=1773353377; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O5hVaSTXWRxltgVf7vgCJNKkl1B/gcHXmbqtoOkqFq4=;
 b=DG/hlFeHYxibT6k6N+yqETOS9aw4UyQ1msYs4oDBHdGYIDr69U8BITwIVjwKT6G6On
 jr59/+78mlNk73gwPYJ/zKluveWfe4yLbMSoVayTCGHCrqVY7GQIUGuaaYHuL6HSbw07
 XN9dAFwUlyW4KqkeqaJwaBHbz4mfnfl8tZY3WM8vzxFzXxlt0oLSMTsbdIHj4vFxjfDI
 n7A7dGeAoEGSO9uKdPIyKr+rT9urLYBtnpiQt5iIOHXrmlXX1VPlY6Ow6HYP2bRwv1wV
 0Gnldt3gRpcP7syNbuA4vdzwvR8v6+22mQxGBXBp4e6L8uPUlMsGVX6Ct31gC5Odr5qd
 Ig9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772748577; x=1773353377;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=O5hVaSTXWRxltgVf7vgCJNKkl1B/gcHXmbqtoOkqFq4=;
 b=btHgCi8pg86pWNJAgqTdS/qecA4xvIUoEHzTiDx1arNDlKHGiHjCpYo0JAF1Ns0Yq6
 73aUGotBBunM3OBn0jSn4u4wFgVc40I8h8Rtm4WwSp7klAK9ZvN2MGdemxptONH+zesl
 gX3qWDKUtKNwNOdXlc3rF92vxfZDCwx73Q961q57UhxYOe/7qc7zS94t/8/MjrWp2tuY
 BFcC+W9QnwIl0KBDo0rKSJoGijVsmvm8t8ZsX//yM0D1Kv2S5j5qX7WL5FmLfS2VUREm
 qm6IoJRVSKczdUpqEqXe/QhbQSsJe2k228B52AyNWArQ8PztqzPx21T/PtVaR43F3Fxt
 kSaQ==
X-Gm-Message-State: AOJu0Yzxiy1mfSzIUQmMSVk1YaXiNICtz/nBNMjtLUDdp5vI93UG06Fx
 7LbK+iDgGABff/0GK2MGoMF70fbFvyiYctoUxWNF5u430lcyq3a42IflJ0aDvw==
X-Gm-Gg: ATEYQzw1vAWHrwEeGh0G4NIz2KmPZA8DUSjee7I2azSyYEuPQl9Sn0ulJckf91xyx4W
 YdKD17jcafouvlqYj9HkW/S8PetWrLAWxKI0ly1KossYN6eIBkXoOXh3pgGBgWnKm9fXVqbeabN
 PvcWcME/AqBj7rnCfYtgSBjuTowpOQqV7CV9bBr8urFYPjsShpa+0HPsJJLO6UIG5JD13j1h+nf
 9OIxKTdfLNpVpbxupaCLRyh0laQo/rxlbK7ea16cMWJZ55qGzQzownktqH0dQmnFH1kPWHW+MWW
 ToT8ZLSDbRsOVkJKW3d9C6BPejHpsKaELMG+ipqa26SNocoiC662iZnR34Bde3LG9lm3QTfXebn
 e/zGEGdLGbQ9/ydkfS29KK6Gstg/YZiOOU8ereDr5ohxQWtplatL2Yg+9C2GD7WawLuPk/XMNNo
 MoiB/E3s5sMOl/DdwAffFFkINMTd6FVs7Z+P6YJI+k8jandxThztj4DlFQ7QXOVpvHzrur1CdC6
 aAc8hshzJbJ1v84PxNFIY4gQKBzxnud9bQB/UszQGxf9jc=
X-Received: by 2002:a05:600c:3ba2:b0:47a:814c:ee95 with SMTP id
 5b1f17b1804b1-4851984bc7dmr129482695e9.12.1772748576831; 
 Thu, 05 Mar 2026 14:09:36 -0800 (PST)
Received: from Provence.localdomain
 (dynamic-2a02-3100-2989-c400-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:2989:c400:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4851fa87e56sm67419615e9.0.2026.03.05.14.09.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 14:09:36 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Troy Lee <leetroy@gmail.com>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, qemu-arm@nongnu.org,
 Helge Deller <deller@gmx.de>, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v3 13/14] hw/char/serial: Inherit from SysBusDevice
Date: Thu,  5 Mar 2026 23:09:10 +0100
Message-ID: <20260305220911.131508-14-shentey@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260305220911.131508-1-shentey@gmail.com>
References: <20260305220911.131508-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32e.google.com
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

In addition, DeviceState doesn't participate in the reset framework
while SysBusDevice does. This allows for implementing reset
functionality more idiomatically.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 include/hw/char/serial.h   |  4 ++--
 hw/char/diva-gsp.c         | 18 +++++++++---------
 hw/char/serial-isa.c       | 16 ++++++++++------
 hw/char/serial-mm.c        |  8 ++++----
 hw/char/serial-pci-multi.c | 18 +++++++++---------
 hw/char/serial-pci.c       | 10 +++++-----
 hw/char/serial.c           |  5 ++++-
 7 files changed, 43 insertions(+), 36 deletions(-)

diff --git a/include/hw/char/serial.h b/include/hw/char/serial.h
index 0cf641a860..2ee9e5984c 100644
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
index b0a2437c85..8e467f047d 100644
--- a/hw/char/diva-gsp.c
+++ b/hw/char/diva-gsp.c
@@ -56,13 +56,13 @@ typedef struct PCIDivaSerialState {
 static void diva_pci_exit(PCIDevice *dev)
 {
     PCIDivaSerialState *pci = DO_UPCAST(PCIDivaSerialState, dev, dev);
-    SerialState *s;
     int i;
 
     for (i = 0; i < pci->ports; i++) {
-        s = pci->state + i;
-        memory_region_del_subregion(&pci->membar, &s->io);
-        qdev_unrealize(DEVICE(s));
+        SysBusDevice *sbd = SYS_BUS_DEVICE(pci->state + i);
+        memory_region_del_subregion(&pci->membar,
+                                    sysbus_mmio_get_region(sbd, 0));
+        qdev_unrealize(DEVICE(sbd));
     }
     qemu_free_irqs(pci->irqs, pci->ports);
 }
@@ -116,7 +116,6 @@ static void diva_pci_realize(PCIDevice *dev, Error **errp)
 {
     PCIDeviceClass *pc = PCI_DEVICE_GET_CLASS(dev);
     PCIDivaSerialState *pci = DO_UPCAST(PCIDivaSerialState, dev, dev);
-    SerialState *s;
     struct diva_info di = diva_get_diva_info(pc);
     size_t i, offset = 0;
     size_t portmask = di.omask;
@@ -128,19 +127,20 @@ static void diva_pci_realize(PCIDevice *dev, Error **errp)
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
index 3a48b2495e..5eb2dc6350 100644
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
@@ -76,11 +76,11 @@ static void serial_isa_realizefn(DeviceState *dev, Error **errp)
     }
     index++;
 
-    s->irq = isa_get_irq(isadev, isa->isairq);
-    qdev_realize(DEVICE(s), NULL, errp);
+    sysbus_realize(sbd, errp);
+    sysbus_connect_irq(sbd, 0, isa_get_irq(isadev, isa->isairq));
     qdev_set_legacy_instance_id(dev, isa->iobase, 3);
 
-    isa_register_ioport(isadev, &s->io, isa->iobase);
+    isa_register_ioport(isadev, sysbus_mmio_get_region(sbd, 0), isa->iobase);
 }
 
 static void serial_isa_build_aml(AcpiDevAmlIf *adev, Aml *scope)
@@ -187,13 +187,17 @@ void serial_hds_isa_init(ISABus *bus, int from, int to)
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
index 1dba4fc694..ba4061aa69 100644
--- a/hw/char/serial-mm.c
+++ b/hw/char/serial-mm.c
@@ -33,14 +33,14 @@
 static void serial_mm_realize(DeviceState *dev, Error **errp)
 {
     SerialMM *smm = SERIAL_MM(dev);
-    SerialState *s = &smm->serial;
+    SysBusDevice *sbd = SYS_BUS_DEVICE(&smm->serial);
 
-    if (!qdev_realize(DEVICE(s), NULL, errp)) {
+    if (!sysbus_realize(sbd, errp)) {
         return;
     }
 
-    sysbus_init_mmio(SYS_BUS_DEVICE(smm), &s->io);
-    sysbus_init_irq(SYS_BUS_DEVICE(smm), &smm->serial.irq);
+    sysbus_init_mmio(SYS_BUS_DEVICE(smm), sysbus_mmio_get_region(sbd, 0));
+    sysbus_pass_irq(SYS_BUS_DEVICE(smm), SYS_BUS_DEVICE(sbd));
 }
 
 static const VMStateDescription vmstate_serial_mm = {
diff --git a/hw/char/serial-pci-multi.c b/hw/char/serial-pci-multi.c
index eda0d43bcf..f5ea7f4188 100644
--- a/hw/char/serial-pci-multi.c
+++ b/hw/char/serial-pci-multi.c
@@ -50,13 +50,13 @@ typedef struct PCIMultiSerialState {
 static void multi_serial_pci_exit(PCIDevice *dev)
 {
     PCIMultiSerialState *pci = DO_UPCAST(PCIMultiSerialState, dev, dev);
-    SerialState *s;
     int i;
 
     for (i = 0; i < pci->ports; i++) {
-        s = pci->state + i;
-        memory_region_del_subregion(&pci->iobar, &s->io);
-        qdev_unrealize(DEVICE(s));
+        SysBusDevice *sbd = SYS_BUS_DEVICE(pci->state + i);
+        memory_region_del_subregion(&pci->iobar,
+                                    sysbus_mmio_get_region(sbd, 0));
+        qdev_unrealize(DEVICE(sbd));
     }
 }
 
@@ -91,7 +91,6 @@ static void multi_serial_pci_realize(PCIDevice *dev, Error **errp)
 {
     PCIDeviceClass *pc = PCI_DEVICE_GET_CLASS(dev);
     PCIMultiSerialState *pci = DO_UPCAST(PCIMultiSerialState, dev, dev);
-    SerialState *s;
     size_t i, nports = multi_serial_get_port_count(pc);
 
     pci->dev.config[PCI_CLASS_PROG] = 2; /* 16550 compatible */
@@ -100,13 +99,14 @@ static void multi_serial_pci_realize(PCIDevice *dev, Error **errp)
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
-        memory_region_add_subregion(&pci->iobar, 8 * i, &s->io);
+        sysbus_connect_irq(sbd, 0, &pci->irqs[i]);
+        memory_region_add_subregion(&pci->iobar, 8 * i,
+                                    sysbus_mmio_get_region(sbd, 0));
         pci->ports++;
     }
 }
diff --git a/hw/char/serial-pci.c b/hw/char/serial-pci.c
index 9a0bf2d890..b702de8219 100644
--- a/hw/char/serial-pci.c
+++ b/hw/char/serial-pci.c
@@ -46,17 +46,18 @@ OBJECT_DECLARE_SIMPLE_TYPE(PCISerialState, PCI_SERIAL)
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
 
-    pci_register_bar(&pci->dev, 0, PCI_BASE_ADDRESS_SPACE_IO, &s->io);
+    pci_register_bar(&pci->dev, 0, PCI_BASE_ADDRESS_SPACE_IO,
+                     sysbus_mmio_get_region(sbd, 0));
 }
 
 static void serial_pci_exit(PCIDevice *dev)
@@ -65,7 +66,6 @@ static void serial_pci_exit(PCIDevice *dev)
     SerialState *s = &pci->state;
 
     qdev_unrealize(DEVICE(s));
-    qemu_free_irq(s->irq);
 }
 
 static const VMStateDescription vmstate_pci_serial = {
diff --git a/hw/char/serial.c b/hw/char/serial.c
index 49227830e1..fc92897376 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -991,6 +991,9 @@ static void serial_realize(DeviceState *dev, Error **errp)
                              serial_event, serial_be_change, s, NULL, true);
     fifo8_create(&s->recv_fifo, UART_FIFO_LENGTH);
     fifo8_create(&s->xmit_fifo, UART_FIFO_LENGTH);
+
+    sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->io);
+    sysbus_init_irq(SYS_BUS_DEVICE(s), &s->irq);
 }
 
 static void serial_unrealize(DeviceState *dev)
@@ -1034,7 +1037,7 @@ static void serial_class_init(ObjectClass *klass, const void *data)
 
 static const TypeInfo serial_info = {
     .name = TYPE_SERIAL,
-    .parent = TYPE_DEVICE,
+    .parent = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(SerialState),
     .class_init = serial_class_init,
 };
-- 
2.53.0


