Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C84E7C02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 18:25:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taIvo-0000ZX-Lt; Tue, 21 Jan 2025 13:24:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taIvk-0000Z2-MB
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 13:24:53 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taIvi-0000iJ-OT
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 13:24:52 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4363ae65100so66602525e9.0
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 10:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737483887; x=1738088687; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yOWRnxzAlHtI8QW2bVm0IK8CuRFXNnYXHyfDzPFWGXw=;
 b=T55Xe0nbMxV0aCXyGIJwkEZiqpGDjGmdzhWkkzQ8QoUHQNxvcZ80QWlhpV52N37LDV
 mwQTwvcbcQ/ZZ0Yjiw/JZCRsNJBMNGmgXYo/JvUMC859YSArfZdEtz8sbIRf2qrzsI7C
 csywd3FtdOORHFfKyOuHbpbr8sQghbkDKKMSxr6Bv0dXFI8PspyE4fr7DzncpvaeXRVM
 /xLj2KVfpaj/V+zKLRRFpgJxrfaM9FMWYqh/b6t+w2KbfeXoSMH/aTLneHaym5KbHK6s
 Gvr3C8+TUYcDw+yFjOsP7QBfy2ePoHkTffhu8VK5Nvf1wO8DiUnvWhAXW0vj8my0pQZs
 yJ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737483887; x=1738088687;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yOWRnxzAlHtI8QW2bVm0IK8CuRFXNnYXHyfDzPFWGXw=;
 b=nVJuT8GEdzaRk4YX9TCJmKC7vN14SHZvD1yCCnOuIeE4cbeRAFKndKY7qmUP0H2n8b
 EA9jEYMeRyM2asJuXpYTacN64W3Hu/I5Kfb3gsHM1IrDiNEyLUrOY8n0CNHBkSyCfa7X
 KDz400OZauVu6abKxBW6M73AXMLotudGtAbqrvcqVxTjkcCqIpgJ2mSb/xCn/kgXrjTn
 5yNvG2ppIzLH8KXNMgAAi0H99d8pYxFFJ2VTs1qyq5Txc8Og3ArA/hc+dU0IJopLRXx6
 ZUffzr3KKvas8a3V01DhO+z2qy4XLz5zm37uEZE5AIXnpisrO+FM0Bmi95eO6BfGx/7v
 pSsQ==
X-Gm-Message-State: AOJu0YzFITF2q8fzT1Gg6dVcEGL8F3HevXARY6jINpqpUXLVdXp5vvam
 NTCSgQImXJemjuG3c5p8kY9EpWKvOduZUWJ0yuKWWWI2w/9yUhmX0E0cfGEoLb77qAI5p6BFbNJ
 QVi4=
X-Gm-Gg: ASbGnctXxKv2R4ESErZdq+PejB7wEyX8pLooW0z7ek/NGiZaZiJNGq1rxm+jdV1a08q
 QjR86W2wZpdF961GQ+OnvFBYteocfqfl7LPAuIOrzuHt/4Y8zgVRQ28aL5WKn+rQHiInI8wk20a
 WOO1mIJk7MQHmV4fvyKBQdBMUEfIMbEKN8BFyANq1hAPV3rw3oakhtdU6hnZTmF9SGPYZoG86jb
 S//x/B4eMcknQtiw0b6bZSF5S7kdOiwSH8x8eSx9PmVaEVpr7oJYcb1juw+y39TTvvch4EsuY8P
 G5Tp+jUhkly0mdDupfPiNyoOvHWbp3mk18SxV5e9DnDK
X-Google-Smtp-Source: AGHT+IHIwLozA0WPINB/9g9nPBA2u+Gan0zg/oLc2wmukMkfsqdIGHTjM88UoIOs6qTGjl9lJff4gg==
X-Received: by 2002:a5d:5986:0:b0:38a:9fdb:7307 with SMTP id
 ffacd0b85a97d-38bf57a7c07mr18556554f8f.43.1737483886934; 
 Tue, 21 Jan 2025 10:24:46 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf32222d1sm14183151f8f.38.2025.01.21.10.24.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Jan 2025 10:24:46 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] hw/sh4/r2d: Convert legacy qemu_allocate_irqs() to
 qemu_init_irqs()
Date: Tue, 21 Jan 2025 19:24:45 +0100
Message-ID: <20250121182445.35309-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The FPGA exposes a fixed set of IRQs. Hold them in the FPGA
state and initialize them in place calling qemu_init_irqs().

Move r2d_fpga_irq enums earlier so we can use NR_IRQS within
the r2d_fpga_t structure. r2d_fpga_init() returns r2d_fpga_t,
and we dereference irq from it in r2d_init().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Based-on: <20250121155526.29982-2-philmd@linaro.org>
          "hw/irq: Introduce qemu_init_irqs() helper"
---
 hw/sh4/r2d.c | 38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/hw/sh4/r2d.c b/hw/sh4/r2d.c
index 2fa439819e3..d68c94e82ef 100644
--- a/hw/sh4/r2d.c
+++ b/hw/sh4/r2d.c
@@ -63,6 +63,12 @@
 #define PA_VERREG 0x32
 #define PA_OUTPORT 0x36
 
+enum r2d_fpga_irq {
+    PCI_INTD, CF_IDE, CF_CD, PCI_INTC, SM501, KEY, RTC_A, RTC_T,
+    SDCARD, PCI_INTA, PCI_INTB, EXT, TP,
+    NR_IRQS
+};
+
 typedef struct {
     uint16_t bcr;
     uint16_t irlmsk;
@@ -88,15 +94,10 @@ typedef struct {
 
 /* output pin */
     qemu_irq irl;
+    IRQState irq[NR_IRQS];
     MemoryRegion iomem;
 } r2d_fpga_t;
 
-enum r2d_fpga_irq {
-    PCI_INTD, CF_IDE, CF_CD, PCI_INTC, SM501, KEY, RTC_A, RTC_T,
-    SDCARD, PCI_INTA, PCI_INTB, EXT, TP,
-    NR_IRQS
-};
-
 static const struct { short irl; uint16_t msk; } irqtab[NR_IRQS] = {
     [CF_IDE] =   {  1, 1 << 9 },
     [CF_CD] =    {  2, 1 << 8 },
@@ -186,8 +187,8 @@ static const MemoryRegionOps r2d_fpga_ops = {
     .endianness = DEVICE_NATIVE_ENDIAN,
 };
 
-static qemu_irq *r2d_fpga_init(MemoryRegion *sysmem,
-                               hwaddr base, qemu_irq irl)
+static r2d_fpga_t *r2d_fpga_init(MemoryRegion *sysmem,
+                                 hwaddr base, qemu_irq irl)
 {
     r2d_fpga_t *s;
 
@@ -197,7 +198,10 @@ static qemu_irq *r2d_fpga_init(MemoryRegion *sysmem,
 
     memory_region_init_io(&s->iomem, NULL, &r2d_fpga_ops, s, "r2d-fpga", 0x40);
     memory_region_add_subregion(sysmem, base, &s->iomem);
-    return qemu_allocate_irqs(r2d_fpga_irq_set, s, NR_IRQS);
+
+    qemu_init_irqs(s->irq, NR_IRQS, r2d_fpga_irq_set, s);
+
+    return s;
 }
 
 typedef struct ResetData {
@@ -239,13 +243,13 @@ static void r2d_init(MachineState *machine)
     ResetData *reset_info;
     struct SH7750State *s;
     MemoryRegion *sdram = g_new(MemoryRegion, 1);
-    qemu_irq *irq;
     DriveInfo *dinfo;
     DeviceState *dev;
     SysBusDevice *busdev;
     MemoryRegion *address_space_mem = get_system_memory();
     PCIBus *pci_bus;
     USBBus *usb_bus;
+    r2d_fpga_t *fpga;
 
     cpu = SUPERH_CPU(cpu_create(machine->cpu_type));
     env = &cpu->env;
@@ -260,7 +264,7 @@ static void r2d_init(MachineState *machine)
     memory_region_add_subregion(address_space_mem, SDRAM_BASE, sdram);
     /* Register peripherals */
     s = sh7750_init(cpu, address_space_mem);
-    irq = r2d_fpga_init(address_space_mem, 0x04000000, sh7750_irl(s));
+    fpga = r2d_fpga_init(address_space_mem, 0x04000000, sh7750_irl(s));
 
     dev = qdev_new("sh_pci");
     busdev = SYS_BUS_DEVICE(dev);
@@ -268,10 +272,10 @@ static void r2d_init(MachineState *machine)
     pci_bus = PCI_BUS(qdev_get_child_bus(dev, "pci"));
     sysbus_mmio_map(busdev, 0, P4ADDR(0x1e200000));
     sysbus_mmio_map(busdev, 1, A7ADDR(0x1e200000));
-    sysbus_connect_irq(busdev, 0, irq[PCI_INTA]);
-    sysbus_connect_irq(busdev, 1, irq[PCI_INTB]);
-    sysbus_connect_irq(busdev, 2, irq[PCI_INTC]);
-    sysbus_connect_irq(busdev, 3, irq[PCI_INTD]);
+    sysbus_connect_irq(busdev, 0, &fpga->irq[PCI_INTA]);
+    sysbus_connect_irq(busdev, 1, &fpga->irq[PCI_INTB]);
+    sysbus_connect_irq(busdev, 2, &fpga->irq[PCI_INTC]);
+    sysbus_connect_irq(busdev, 3, &fpga->irq[PCI_INTD]);
 
     dev = qdev_new("sysbus-sm501");
     busdev = SYS_BUS_DEVICE(dev);
@@ -281,13 +285,13 @@ static void r2d_init(MachineState *machine)
     sysbus_realize_and_unref(busdev, &error_fatal);
     sysbus_mmio_map(busdev, 0, 0x10000000);
     sysbus_mmio_map(busdev, 1, 0x13e00000);
-    sysbus_connect_irq(busdev, 0, irq[SM501]);
+    sysbus_connect_irq(busdev, 0, &fpga->irq[SM501]);
 
     /* onboard CF (True IDE mode, Master only). */
     dinfo = drive_get(IF_IDE, 0, 0);
     dev = qdev_new("mmio-ide");
     busdev = SYS_BUS_DEVICE(dev);
-    sysbus_connect_irq(busdev, 0, irq[CF_IDE]);
+    sysbus_connect_irq(busdev, 0, &fpga->irq[CF_IDE]);
     qdev_prop_set_uint32(dev, "shift", 1);
     sysbus_realize_and_unref(busdev, &error_fatal);
     sysbus_mmio_map(busdev, 0, 0x14001000);
-- 
2.47.1


