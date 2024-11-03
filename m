Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA4F9D11040
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Nov 2024 13:41:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7akx-0006GK-38; Sun, 03 Nov 2024 08:35:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7akq-0006BJ-Cj; Sun, 03 Nov 2024 08:34:57 -0500
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7ako-0001F8-HS; Sun, 03 Nov 2024 08:34:55 -0500
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a9e8522c10bso161327866b.1; 
 Sun, 03 Nov 2024 05:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730640891; x=1731245691; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CdW4RukPeYbtzE571oJ5Ywld87248Qqc7eArKKusu5M=;
 b=PTlpFZFR80O0XHcf9OcTnAgb9CJTAWFilBrEEaJjtXaaldmZxl+r2scDw7MlVd1Cqx
 sXPyeABX/qvf4ipKZ8DYN/j3ZLoQuh5AOZyiudy6K8RQZgx2nuiKsGU8hMyuA7PjDmkC
 8JX1f9uFy9AyYJ+dD5X4USOayLQxiydf8cquk7vwSjCNWejcKrgKYHnQG5upYJZylY1Q
 dz3cEXzfU/5YXvhj65B/4GTmcRiFiyRxhro6l5MBLwKFjLCgn9q199FEpnzu7SA9uevr
 9Dy7XeCcj1MgE9xrLtZ8YRbI3lR2GQ00JXx2NaQy4IfLPNFFakeVl3j7LBKxBfNQbpk3
 99cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730640891; x=1731245691;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CdW4RukPeYbtzE571oJ5Ywld87248Qqc7eArKKusu5M=;
 b=BjLCsanlp6on//q6bsxpuhB+SzhuHUsmSKdXBCBNImL5H2Bga2YyitH/hXSVs34NRz
 2gFNaHq2zOkpnkyf8DIeYrkvl8LfS95YYxQK+lkBQy2YvP47DiveU9Y3Pe5UN2oEjiJq
 SxQEbvcy9an9SwHdrIV9Hw7XKVWGz1g5j8M0CCo/ki9c1hejorGc1VFf4oEgkjXIBeg4
 B40qm2Pqd8q9NS2UEjfgNwm7n90m+nDDWihEvZJZe0URQ62ojLulSCx19bLp4LiMglLa
 OvKyC7XRx7G9DF6WCD0vPHqzEzO2irJQ8UsgoLWHTTHbocfL7wbHau1KkmU3YqwezV9g
 MUEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWCMpl+zMX44e+y4i7hd66otarWx13eLZmTKESVjDhDAGd2dFptD4Yqv5bygHtestwIG9PHdxEsMCI@nongnu.org,
 AJvYcCWmxvxVZngq2rCWCKK6UzNSTrL4u+wGQ5to8eoa+NGL76EMtICSwWh6LnyBMOHaXX8+eLRnB2roccs=@nongnu.org
X-Gm-Message-State: AOJu0YzNTSprYPj+7HjtuV8XBf4MfBnyvixRIo8O3d24qc72wdIYWDZ2
 ZyY9UUOhBQY828lnCHXoXZZtRgx86R41eYV/ePEFJLXV/2jcDyPdB4GDiw==
X-Google-Smtp-Source: AGHT+IGqK/4vu9rfQhq+xLQiXk8jzYoKDP8OSpCx8cF49FFD+92B8FCTFaak50T7pkxg3DreS+3y8A==
X-Received: by 2002:a17:907:94cb:b0:a99:f94b:f92e with SMTP id
 a640c23a62f3a-a9e654924a6mr1024746966b.27.1730640890410; 
 Sun, 03 Nov 2024 05:34:50 -0800 (PST)
Received: from archlinux.. (pd9ed7f6d.dip0.t-ipconnect.de. [217.237.127.109])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9e5664350esm424328866b.159.2024.11.03.05.34.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Nov 2024 05:34:49 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, Corey Minyard <cminyard@mvista.com>,
 Kevin Wolf <kwolf@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, qemu-block@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v4 07/26] hw/ppc/e500: Use SysBusDevice API to access
 TYPE_CCSR's internal resources
Date: Sun,  3 Nov 2024 14:33:53 +0100
Message-ID: <20241103133412.73536-8-shentey@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241103133412.73536-1-shentey@gmail.com>
References: <20241103133412.73536-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Rather than accessing the attributes of TYPE_CCSR directly, use the SysBusDevice
API which exists exactly for that purpose. Furthermore, registering the memory
region with the SysBusDevice API makes it show up in QMP's `info qom-tree`
command.

Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/pci-host/ppce500.c | 10 +++++-----
 hw/ppc/e500.c         |  8 ++++----
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/hw/pci-host/ppce500.c b/hw/pci-host/ppce500.c
index 95b983b2b3..97e5d47cec 100644
--- a/hw/pci-host/ppce500.c
+++ b/hw/pci-host/ppce500.c
@@ -16,7 +16,6 @@
 
 #include "qemu/osdep.h"
 #include "hw/irq.h"
-#include "hw/ppc/e500-ccsr.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "hw/pci/pci_device.h"
@@ -419,11 +418,12 @@ static const VMStateDescription vmstate_ppce500_pci = {
 static void e500_pcihost_bridge_realize(PCIDevice *d, Error **errp)
 {
     PPCE500PCIBridgeState *b = PPC_E500_PCI_BRIDGE(d);
-    PPCE500CCSRState *ccsr = CCSR(container_get(qdev_get_machine(),
-                                  "/e500-ccsr"));
+    SysBusDevice *ccsr = SYS_BUS_DEVICE(container_get(qdev_get_machine(),
+                                                      "/e500-ccsr"));
+    MemoryRegion *ccsr_space = sysbus_mmio_get_region(ccsr, 0);
 
-    memory_region_init_alias(&b->bar0, OBJECT(ccsr), "e500-pci-bar0", &ccsr->ccsr_space,
-                             0, int128_get64(ccsr->ccsr_space.size));
+    memory_region_init_alias(&b->bar0, OBJECT(ccsr), "e500-pci-bar0",
+                             ccsr_space, 0, int128_get64(ccsr_space->size));
     pci_register_bar(d, 0, PCI_BASE_ADDRESS_SPACE_MEMORY, &b->bar0);
 }
 
diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 5d75a090ee..2849fba524 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -915,7 +915,6 @@ void ppce500_init(MachineState *machine)
     DriveInfo *dinfo;
     MemoryRegion *ccsr_addr_space;
     SysBusDevice *s;
-    PPCE500CCSRState *ccsr;
     I2CBus *i2c;
 
     irqs = g_new0(IrqLines, smp_cpus);
@@ -971,10 +970,10 @@ void ppce500_init(MachineState *machine)
     memory_region_add_subregion(address_space_mem, 0, machine->ram);
 
     dev = qdev_new("e500-ccsr");
+    s = SYS_BUS_DEVICE(dev);
     object_property_add_child(OBJECT(machine), "e500-ccsr", OBJECT(dev));
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
-    ccsr = CCSR(dev);
-    ccsr_addr_space = &ccsr->ccsr_space;
+    sysbus_realize_and_unref(s, &error_fatal);
+    ccsr_addr_space = sysbus_mmio_get_region(s, 0);
     memory_region_add_subregion(address_space_mem, pmc->ccsrbar_base,
                                 ccsr_addr_space);
 
@@ -1262,6 +1261,7 @@ static void e500_ccsr_initfn(Object *obj)
     PPCE500CCSRState *ccsr = CCSR(obj);
     memory_region_init(&ccsr->ccsr_space, obj, "e500-ccsr",
                        MPC8544_CCSRBAR_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(ccsr), &ccsr->ccsr_space);
 }
 
 static const TypeInfo e500_ccsr_info = {
-- 
2.47.0


