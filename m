Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05310C982D8
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 16:41:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7bdt-0004dX-34; Fri, 18 Sep 2026 12:40:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>)
 id 1x7bc9-0003GY-4y; Fri, 18 Sep 2026 12:39:13 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>)
 id 1x7bby-0002iB-C1; Fri, 18 Sep 2026 12:38:56 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3C9616022B;
 Fri, 18 Sep 2026 16:38:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F41931F000FF;
 Fri, 18 Sep 2026 16:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789749530;
 bh=FhRw3AtyOopeiazjNZ1pbw976Fvw+qCbMTto/y6m/4k=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=jMqS1qbZayhAb2DIOFf+zjzreDWBQ5fpY9eAxXYXFoAaGKZOsD419iIZDIj+FUpFE
 6ll97+dbVFaSyBaDCt0Q7jOXKAW4NSF16HT3v3wEHmatiORzXY/BT92TNUmAvBzBfT
 ua1wC8X9+fpxVyaut5jrIfNYJw3rJYxoXH9aIwUFID1JZpziLPrLKF6xRIiO+qhN4B
 DAPjBm3mayHmw7U0nUXd9htZkjLVO1qNL3oaGIRcw8RvSsXxHeBq5OL9mDNtgkj6Rs
 ThJhlSTY71/olhXBjDPBSaLzNatAlfEASShhx+3c+zjbtRZQMGJfbGj13pBInJtk7/
 cuAZs8DlxBZ+Q==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Helge Deller <deller@gmx.de>, "Denis V. Lunev" <den@openvz.org>,
 Abizer Lokhandwala <abizerlokhandwalastd10@gmail.com>
Subject: [PULL 7/7] hw/hppa: Add NS 87560 SuperIO chip to HP C3700 machine
Date: Fri, 18 Sep 2026 18:38:28 +0200
Message-ID: <20260918163829.2917-8-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260918163829.2917-1-deller@kernel.org>
References: <20260918163829.2917-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=deller@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Abizer Lokhandwala <abizerlokhandwalastd10@gmail.com>

Due to the lack of the emulated NS 87560 SuperIO chip, we used until now the
emulated serial ports of a Diva GSP management board as a temporary
replacement.  Since the NS SuperIO chip emulation was just added in the
previous commits, switch over to use it which allows us to emulate the physical
hardware more closely.

Signed-off-by: Abizer Lokhandwala <abizerlokhandwalastd10@gmail.com>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/hppa/machine.c | 41 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 34 insertions(+), 7 deletions(-)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 98931481b2..96133f09ba 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -394,7 +394,7 @@ static TranslateFn *machine_HP_common_init_cpus(MachineState *machine)
  * Last creation step: Add NICs, graphics & load firmware
  */
 static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
-                                        TranslateFn *translate)
+                                    TranslateFn *translate, bool create_diva)
 {
     const char *kernel_filename = machine->kernel_filename;
     MachineClass *mc = MACHINE_GET_CLASS(machine);
@@ -426,7 +426,7 @@ static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
         pci_init_nic_devices(pci_bus, mc->default_nic);
     }
 
-    if (pci_bus && hppa_is_pa20(&cpu[0]->env)) {
+    if (pci_bus && hppa_is_pa20(&cpu[0]->env) && create_diva) {
         /* BMC board: HP Diva GSP PCI card */
         pci_dev = pci_new_multifunction(PCI_DEVFN(2, 0), "diva-gsp");
         if (!lasi_dev) {
@@ -442,8 +442,9 @@ static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
     /* create USB OHCI controller for USB keyboard & mouse on Astro machines */
     if (!lasi_dev && machine->enable_graphics && defaults_enabled()) {
         USBBus *usb_bus;
-
-        pci_create_simple(pci_bus, -1, "pci-ohci");
+        if (create_diva) {
+            pci_create_simple(pci_bus, -1, "pci-ohci");
+        }
         usb_bus = USB_BUS(object_resolve_type_unambiguous(TYPE_USB_BUS,
                                                           &error_abort));
         usb_create_simple(usb_bus, "usb-kbd");
@@ -647,7 +648,7 @@ static void machine_HP_715_init(MachineState *machine)
     }
 
     /* Add NICs, graphics & load firmware */
-    machine_HP_common_init_tail(machine, NULL, translate);
+    machine_HP_common_init_tail(machine, NULL, translate, false);
 }
 
 /*
@@ -726,7 +727,7 @@ static void machine_HP_B160L_init(MachineState *machine)
     }
 
     /* Add NICs, graphics & load firmware */
-    machine_HP_common_init_tail(machine, pci_bus, translate);
+    machine_HP_common_init_tail(machine, pci_bus, translate, false);
 }
 
 static AstroState *astro_init(void)
@@ -771,6 +772,32 @@ static void machine_HP_C3700_init(MachineState *machine)
     pci_bus = PCI_BUS(qdev_get_child_bus(DEVICE(astro->elroy[0]), "pci"));
     assert(pci_bus);
 
+    /* The C3700 has a SuperIO chip, while the A400 hasn't. */
+    MachineClass *mc = MACHINE_GET_CLASS(machine);
+    bool is_C3700 = strcmp(mc->name, "C3700") == 0;
+    if (is_C3700)  {
+        PCIDevice *ide_pdev = pci_create_simple(pci_bus, PCI_DEVFN(2, 0),
+                                                "pc87560-ide");
+        PCIDevice *usb_pdev = pci_create_simple(pci_bus, PCI_DEVFN(2, 2),
+                                                "pc87560-ohci");
+        PCIDevice *sio_pdev = pci_new(PCI_DEVFN(2, 1), "pc87560-superio");
+        if (serial_hd(0)) {
+            qdev_prop_set_chr(DEVICE(sio_pdev), "serial0", serial_hd(0));
+        }
+        if (serial_hd(1)) {
+            qdev_prop_set_chr(DEVICE(sio_pdev), "serial1", serial_hd(1));
+        }
+        pci_realize_and_unref(sio_pdev, pci_bus, &error_fatal);
+
+        qdev_connect_gpio_out(DEVICE(ide_pdev), 0,
+            qdev_get_gpio_in_named(DEVICE(sio_pdev), "pic-irq", 7));
+        qdev_connect_gpio_out(DEVICE(usb_pdev), 0,
+            qdev_get_gpio_in_named(DEVICE(sio_pdev), "pic-irq", 1));
+
+        qdev_connect_gpio_out_named(DEVICE(sio_pdev), "pic-out", 0,
+                                    pci_allocate_irq(usb_pdev));
+    }
+
     /* SCSI disk setup. */
     if (drive_get_max_bus(IF_SCSI) >= 0) {
         DeviceState *dev = DEVICE(pci_create_simple(pci_bus, -1, "lsi53c895a"));
@@ -778,7 +805,7 @@ static void machine_HP_C3700_init(MachineState *machine)
     }
 
     /* Add NICs, graphics & load firmware */
-    machine_HP_common_init_tail(machine, pci_bus, translate);
+    machine_HP_common_init_tail(machine, pci_bus, translate, !is_C3700);
 }
 
 /*
-- 
2.54.0


