Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FBD8C3814E
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 21:00:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPTY5-0003BI-BC; Thu, 04 Jul 2024 16:59:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1sPTY0-00038a-MQ; Thu, 04 Jul 2024 16:59:21 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1sPTXy-0000nk-Uc; Thu, 04 Jul 2024 16:59:20 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a77b4387302so127184566b.1; 
 Thu, 04 Jul 2024 13:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720126756; x=1720731556; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oWtJCgARShGh4Hv3ul6ITFwgpH0VxBhfZ7ANN/LEg44=;
 b=iqhnb+fiDPLkBBrxz2hK4frUoR684LcWHUrioIqDR6Z+UCeppTEyVewj8WEVIwqLee
 rFjL42hHJJa1HVUsXlhErCpSftsIgmT1feeUYHFoH7TcL6F7tVwOGEBDp4Xd86WCLV4o
 lwXj272kyjqbq74S5AhXoIpDKI048fEOpbHs0wAHdyqJFV67dJhq/kBCEvvEOLACujho
 kVP6sdgIgNweoj/Rg3Atgu3FQn4mERIYWHl5hISl7UblZQB7hWypXk3IDyMU0Vdhgte3
 Kl1NbmiOIsmYE99EPiiTpvER3D6mN+EV4tjl7EyctFsD4v5a08MqZaYvy/f8DIPAa/WW
 YZ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720126756; x=1720731556;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oWtJCgARShGh4Hv3ul6ITFwgpH0VxBhfZ7ANN/LEg44=;
 b=ZtSN4KsCAJNgqSyWhiiAzIBr8h4gidOipBC60t1UvJ1rIekz2WIa0MYfF3/3FobvuG
 fh/5dN2DWT36eougSVw9NhU2+JuDLZwXS+C1Kh/wYgshIDzbcvT6M8uRie+G/hEPKu9/
 uGI9H0oz7rkQdB7My4WA6bKi45ESZj8YhWCftv8GlKM4CtuXifOVyusFcNohi2/An5ak
 dGfamOpvFgMcgrT5gw4zdrzKcAV0B33YuhGsWbj9tOHykb8M91U1IkXzvDO7zefblum+
 6+MO/397B4qr6NtbUvXJPuPzQcgk4VHU+TKvlgCUexoroTdPmz/f/Na+AEcG5ChTE8rM
 2mKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFASauvKmafwHDW809WmO00G/KhIXcmRYUdUQwhIAf6Sfb+74inadMuNyugIrjL1wLEorbE8gl4TuVh5jRy8MohNo9
X-Gm-Message-State: AOJu0YyETQ+Ae8VgeskGg7HFE3fGjXqHWW1ZH2B/tnNq5HAxIZEzE8SI
 ntq02+QJwQGC9SN1UXliZtEazbcr+SMBoOd3OTSVCob4Qen0ARgcKnigbA==
X-Google-Smtp-Source: AGHT+IEe+em4smMM6Uqg6zq6iNFvUwHYfqckmsWbkAP/ZX2TFe1Nc8PHNMVA6jnLSEumIr0GAmsK+A==
X-Received: by 2002:a17:906:f0d1:b0:a72:8296:ca40 with SMTP id
 a640c23a62f3a-a77ba46f820mr184343566b.18.1720126755653; 
 Thu, 04 Jul 2024 13:59:15 -0700 (PDT)
Received: from archlinux.. (dynamic-077-188-087-180.77.188.pool.telefonica.de.
 [77.188.87.180]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7400456582sm526153866b.153.2024.07.04.13.59.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jul 2024 13:59:15 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-ppc@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>, Huacai Chen <chenhuacai@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 2/3] hw/isa/vt82c686: Resolve intermediate IRQ forwarder
Date: Thu,  4 Jul 2024 22:58:53 +0200
Message-ID: <20240704205854.18537-3-shentey@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240704205854.18537-1-shentey@gmail.com>
References: <20240704205854.18537-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62c.google.com
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

When @cpu_intr is populated before vt82xx's realize(), it can be directly passed
to i8259_init(), avoiding the need for the intermediate
via_isa_request_i8259_irq() handler. The result is less code and runtime
overhead, and a fixed memory leak caused by qemu_allocate_irqs().

Inspired-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/isa/vt82c686.c   | 12 ++----------
 hw/mips/fuloong2e.c |  2 +-
 hw/ppc/amigaone.c   |  8 ++++----
 hw/ppc/pegasos2.c   |  4 ++--
 4 files changed, 9 insertions(+), 17 deletions(-)

diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
index 505b44c4e6..ca02ad4c20 100644
--- a/hw/isa/vt82c686.c
+++ b/hw/isa/vt82c686.c
@@ -624,6 +624,7 @@ static void via_isa_init(Object *obj)
     object_initialize_child(obj, "uhci2", &s->uhci[1], TYPE_VT82C686B_USB_UHCI);
     object_initialize_child(obj, "ac97", &s->ac97, TYPE_VIA_AC97);
     object_initialize_child(obj, "mc97", &s->mc97, TYPE_VIA_MC97);
+    qdev_init_gpio_out_named(DEVICE(obj), &s->cpu_intr, "intr", 1);
 }
 
 static const TypeInfo via_isa_info = {
@@ -704,24 +705,15 @@ static void via_isa_pirq(void *opaque, int pin, int level)
     via_isa_set_irq(opaque, pin, level);
 }
 
-static void via_isa_request_i8259_irq(void *opaque, int irq, int level)
-{
-    ViaISAState *s = opaque;
-    qemu_set_irq(s->cpu_intr, level);
-}
-
 static void via_isa_realize(PCIDevice *d, Error **errp)
 {
     ViaISAState *s = VIA_ISA(d);
     DeviceState *dev = DEVICE(d);
     PCIBus *pci_bus = pci_get_bus(d);
-    qemu_irq *isa_irq;
     ISABus *isa_bus;
     int i;
 
-    qdev_init_gpio_out_named(dev, &s->cpu_intr, "intr", 1);
     qdev_init_gpio_in_named(dev, via_isa_pirq, "pirq", PCI_NUM_PINS);
-    isa_irq = qemu_allocate_irqs(via_isa_request_i8259_irq, s, 1);
     isa_bus = isa_bus_new(dev, pci_address_space(d), pci_address_space_io(d),
                           errp);
 
@@ -729,7 +721,7 @@ static void via_isa_realize(PCIDevice *d, Error **errp)
         return;
     }
 
-    s->isa_irqs_in = i8259_init(isa_bus, *isa_irq);
+    s->isa_irqs_in = i8259_init(isa_bus, s->cpu_intr);
     isa_bus_register_input_irqs(isa_bus, s->isa_irqs_in);
     i8254_pit_init(isa_bus, 0x40, 0, NULL);
     i8257_dma_init(OBJECT(d), isa_bus, 0);
diff --git a/hw/mips/fuloong2e.c b/hw/mips/fuloong2e.c
index 6e4303ba47..e6487c34d8 100644
--- a/hw/mips/fuloong2e.c
+++ b/hw/mips/fuloong2e.c
@@ -286,6 +286,7 @@ static void mips_fuloong2e_init(MachineState *machine)
     /* South bridge -> IP5 */
     pci_dev = pci_new_multifunction(PCI_DEVFN(FULOONG2E_VIA_SLOT, 0),
                                     TYPE_VT82C686B_ISA);
+    qdev_connect_gpio_out_named(DEVICE(pci_dev), "intr", 0, env->irq[5]);
 
     /* Set properties on individual devices before realizing the south bridge */
     if (machine->audiodev) {
@@ -299,7 +300,6 @@ static void mips_fuloong2e_init(MachineState *machine)
                               object_resolve_path_component(OBJECT(pci_dev),
                                                             "rtc"),
                               "date");
-    qdev_connect_gpio_out_named(DEVICE(pci_dev), "intr", 0, env->irq[5]);
 
     dev = DEVICE(object_resolve_path_component(OBJECT(pci_dev), "ide"));
     pci_ide_create_devs(PCI_DEVICE(dev));
diff --git a/hw/ppc/amigaone.c b/hw/ppc/amigaone.c
index 9dcc486c1a..2110875f56 100644
--- a/hw/ppc/amigaone.c
+++ b/hw/ppc/amigaone.c
@@ -148,13 +148,13 @@ static void amigaone_init(MachineState *machine)
     pci_bus = PCI_BUS(qdev_get_child_bus(dev, "pci.0"));
 
     /* VIA VT82c686B South Bridge (multifunction PCI device) */
-    via = OBJECT(pci_create_simple_multifunction(pci_bus, PCI_DEVFN(7, 0),
-                                                 TYPE_VT82C686B_ISA));
+    via = OBJECT(pci_new_multifunction(PCI_DEVFN(7, 0), TYPE_VT82C686B_ISA));
+    qdev_connect_gpio_out_named(DEVICE(via), "intr", 0,
+                                qdev_get_gpio_in(DEVICE(cpu), PPC6xx_INPUT_INT));
+    pci_realize_and_unref(PCI_DEVICE(via), pci_bus, &error_abort);
     object_property_add_alias(OBJECT(machine), "rtc-time",
                               object_resolve_path_component(via, "rtc"),
                               "date");
-    qdev_connect_gpio_out_named(DEVICE(via), "intr", 0,
-                                qdev_get_gpio_in(DEVICE(cpu), PPC6xx_INPUT_INT));
     for (i = 0; i < PCI_NUM_PINS; i++) {
         qdev_connect_gpio_out(dev, i, qdev_get_gpio_in_named(DEVICE(via),
                                                              "pirq", i));
diff --git a/hw/ppc/pegasos2.c b/hw/ppc/pegasos2.c
index 9b0a6b70ab..54e60082ce 100644
--- a/hw/ppc/pegasos2.c
+++ b/hw/ppc/pegasos2.c
@@ -181,6 +181,8 @@ static void pegasos2_init(MachineState *machine)
 
     /* VIA VT8231 South Bridge (multifunction PCI device) */
     via = OBJECT(pci_new_multifunction(PCI_DEVFN(12, 0), TYPE_VT8231_ISA));
+    qdev_connect_gpio_out_named(DEVICE(via), "intr", 0,
+                                qdev_get_gpio_in_named(pm->mv, "gpp", 31));
 
     /* Set properties on individual devices before realizing the south bridge */
     if (machine->audiodev) {
@@ -195,8 +197,6 @@ static void pegasos2_init(MachineState *machine)
     object_property_add_alias(OBJECT(machine), "rtc-time",
                               object_resolve_path_component(via, "rtc"),
                               "date");
-    qdev_connect_gpio_out_named(DEVICE(via), "intr", 0,
-                                qdev_get_gpio_in_named(pm->mv, "gpp", 31));
 
     dev = PCI_DEVICE(object_resolve_path_component(via, "ide"));
     pci_ide_create_devs(dev);
-- 
2.45.2


