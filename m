Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BF16C4450A
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2026 22:09:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlDDq-0001Fr-PR; Sat, 18 Jul 2026 18:09:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlDDp-0001F4-FQ; Sat, 18 Jul 2026 18:09:25 -0400
Received: from pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([52.12.53.23])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlDDn-0006Uu-Dx; Sat, 18 Jul 2026 18:09:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1784412563; x=1815948563;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=zU/K/BxWeNS68XvW3pbgpcTI1u1JLeVFt6e/zQVeYoE=;
 b=SudNiwCcyKc/+gS1foiw8fGEostR5J/7jA2OJ7l66DV0sTYRzMtpeFmi
 Vg4YUaJAr1t7evTqn1ISsi50GziP59Lkgp9GPGc/9phq5mIvdBzqZGPyN
 +1/NmWai+F3tQ1lKwhDGbP3de41on5sK28h/6HTh2fxbM4Uw4EXh4Ja8z
 hacdn0JXTg4XTyOrowwKtKDJJ57We/QgqGdwi7KHsfcxIbOkCSzyeR1lR
 1T2ILs3S9y3x6LuhrAPGDE5/HPhT/TLd50qro8ZFwwMkjehGHKRcuEJ5I
 cNsvW3G6hJs9bwJL64EMHUUv5v//fw1pWBWj0UIPYhChxBQJwdSL84fcV w==;
X-CSE-ConnectionGUID: DxLXWio2TQyRzVEgqTrCWw==
X-CSE-MsgGUID: VWwDaW4HQEC7lX2+w/8gvg==
X-IronPort-AV: E=Sophos;i="6.25,171,1779148800"; d="scan'208";a="23795896"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
 by internal-pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2026 22:09:19 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.51:13948]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.58.199:2525]
 with esmtp (Farcaster)
 id 52b3fccf-f8e3-4403-b877-cd21dc8499df; Sat, 18 Jul 2026 22:09:19 +0000 (UTC)
X-Farcaster-Flow-ID: 52b3fccf-f8e3-4403-b877-cd21dc8499df
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 22:09:18 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 22:09:09 +0000
From: Alexander Graf <graf@amazon.com>
To: <qemu-devel@nongnu.org>
CC: <qemu-arm@nongnu.org>, <qemu-ppc@nongnu.org>, <qemu-riscv@nongnu.org>,
 <qemu-s390x@nongnu.org>, Song Gao <17746591750@163.com>, Aditya Gupta
 <adityag@linux.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Farhan Ali
 <alifm@linux.ibm.com>, Alistair Francis <alistair.francis@wdc.com>, "Alistair
 Francis" <alistair@alistair23.me>, Antony Pavlov <antonynpavlov@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, Artyom Tarasenko
 <atar4qemu@gmail.com>, BALATON Zoltan <balaton@eik.bme.hu>, Felipe Balbi
 <balbi@kernel.org>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?=
 <berrange@redhat.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Hendrik Brueckner
 <brueckner@linux.ibm.com>, Chao Liu <chao.liu@processmission.com>, "Huacai
 Chen" <chenhuacai@kernel.org>, =?UTF-8?q?Cl=C3=A9ment=20Chigot?=
 <chigot@adacore.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Helge Deller <deller@gmx.de>, Dorjoy Chowdhury <dorjoychy111@gmail.com>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Alexandre Iooss
 <erdnaxe@crans.org>, Eric Farman <farman@linux.ibm.com>, Fabiano Rosas
 <farosas@suse.de>, Francisco Iglesias <francisco.iglesias@amd.com>, "Gaurav
 Sharma" <gaurav.sharma_7@nxp.com>, Gautam Gala <ggala@linux.ibm.com>, "Harsh
 Prateek Bora" <harshpb@linux.ibm.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?=
 <hpoussin@reactos.org>, Jan Kiszka <jan.kiszka@web.de>, Max Filippov
 <jcmvbkbc@gmail.com>, Joel Stanley <joel@jms.id.au>, Jared Rossi
 <jrossi@linux.ibm.com>, Tyrone Ting <kfting@nuvoton.com>, Frederic Konrad
 <konrad.frederic@yahoo.fr>, Laurent Vivier <laurent@vivier.eu>, "Manos
 Pitsidianakis" <manos.pitsidianakis@linaro.org>, Bibo Mao
 <maobibo@loongson.cn>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Glenn Miles <milesg@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Michael Rolnik <mrolnik@gmail.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, Nicholas Piggin
 <npiggin@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Halil Pasic
 <pasic@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 "Pierrick Bouvier" <pierrick.bouvier@oss.qualcomm.com>, Richard Henderson
 <richard.henderson@linaro.org>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 Samuel Tardieu <sam@rfc1149.net>, Bernhard Beschow <shentey@gmail.com>,
 Stafford Horne <shorne@gmail.com>, Sergio Lopez <slp@redhat.com>, "Subbaraya
 Sundeep" <sundeep.lkml@gmail.com>, Thomas Huth <th.huth+qemu@posteo.eu>, "Ran
 Wang" <wangran@bosc.ac.cn>, Hao Wu <wuhaotsh@google.com>
Subject: [RFC PATCH v2 116/137] hw/core: Parent GPIO input IRQs and embedded
 IRQState via QOM
Date: Sat, 18 Jul 2026 21:36:31 +0000
Message-ID: <20260718213652.37673-117-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260718213652.37673-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
 <20260718213652.37673-1-graf@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D033UWA002.ant.amazon.com (10.13.139.10) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Received-SPF: pass client-ip=52.12.53.23;
 envelope-from=prvs=65292d44c=graf@amazon.de;
 helo=pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_NONE=0.001, T_SPF_PERMERROR=0.01,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

qdev_init_gpio_in_named_with_opaque() now uses qemu_extend_irqs()
directly, so the input IRQ objects are parented under the device via
object_new_child() and the manual object_property_add_child() loop
goes away.  device_finalize() no longer needs to free the IRQ objects
explicitly since child<> property destruction does that; only the
qemu_irq* array itself needs g_free().

Convert the six users of qemu_init_irq()/qemu_init_irqs() (which
initialize an IRQState embedded in a device struct) to
qemu_init_irq_child() so those IRQs also get a QOM parent.

qdev_connect_gpio_out_named() now asserts that its input pin has a
parent instead of falling back to /machine/unattached; every
qemu_irq that reaches it is parented after this and the preceding
commits.

AI-used-for: code (refactoring)
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 hw/core/gpio.c    | 24 ++++--------------------
 hw/core/qdev.c    |  3 ++-
 hw/ipack/ipack.c  | 11 +++++++++--
 hw/isa/vt82c686.c |  3 ++-
 hw/net/imx_fec.c  |  2 +-
 hw/net/lan9118.c  |  2 +-
 hw/ppc/pegasos.c  |  3 ++-
 hw/sh4/r2d.c      |  5 ++++-
 8 files changed, 25 insertions(+), 28 deletions(-)

diff --git a/hw/core/gpio.c b/hw/core/gpio.c
index ef8ef8f25a..f76d604520 100644
--- a/hw/core/gpio.c
+++ b/hw/core/gpio.c
@@ -45,24 +45,12 @@ void qdev_init_gpio_in_named_with_opaque(DeviceState *dev,
                                          void *opaque,
                                          const char *name, int n)
 {
-    int i;
     NamedGPIOList *gpio_list = qdev_get_named_gpio_list(dev, name);
 
     assert(gpio_list->num_out == 0 || !name);
-    gpio_list->in = qemu_extend_irqs_orphan(gpio_list->in, gpio_list->num_in, handler,
-                                     opaque, n);
-
-    if (!name) {
-        name = "unnamed-gpio-in";
-    }
-    for (i = gpio_list->num_in; i < gpio_list->num_in + n; i++) {
-        gchar *propname = g_strdup_printf("%s[%u]", name, i);
-
-        object_property_add_child(OBJECT(dev), propname,
-                                  OBJECT(gpio_list->in[i]));
-        g_free(propname);
-    }
-
+    gpio_list->in = qemu_extend_irqs(OBJECT(dev), name ?: "unnamed-gpio-in",
+                                     gpio_list->in, gpio_list->num_in,
+                                     handler, opaque, n);
     gpio_list->num_in += n;
 }
 
@@ -119,11 +107,7 @@ void qdev_connect_gpio_out_named(DeviceState *dev, const char *name, int n,
 {
     char *propname = g_strdup_printf("%s[%d]",
                                      name ? name : "unnamed-gpio-out", n);
-    if (input_pin && !OBJECT(input_pin)->parent) {
-        /* We need a name for object_property_set_link to work */
-        object_property_add_child(machine_get_container("unattached"),
-                                  "non-qdev-gpio[*]", OBJECT(input_pin));
-    }
+    g_assert(!input_pin || OBJECT(input_pin)->parent);
     object_property_set_link(OBJECT(dev), propname,
                              OBJECT(input_pin), &error_abort);
     g_free(propname);
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 89bc1e30c0..9a68fb426e 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -698,7 +698,8 @@ static void device_finalize(Object *obj)
 
     QLIST_FOREACH_SAFE(ngl, &dev->gpios, node, next) {
         QLIST_REMOVE(ngl, node);
-        qemu_free_irqs(ngl->in, ngl->num_in);
+        /* IRQs are child<> properties of dev; freed via child destruction */
+        g_free(ngl->in);
         g_free(ngl->name);
         g_free(ngl);
         /* ngl->out irqs are owned by the other end and should not be freed
diff --git a/hw/ipack/ipack.c b/hw/ipack/ipack.c
index f2e5524fa8..dad0d486df 100644
--- a/hw/ipack/ipack.c
+++ b/hw/ipack/ipack.c
@@ -55,18 +55,25 @@ static void ipack_device_realize(DeviceState *dev, Error **errp)
     }
     bus->free_slot = idev->slot + 1;
 
-    qemu_init_irqs(idev->irq, ARRAY_SIZE(idev->irq), bus->set_irq, idev);
+    for (int i = 0; i < ARRAY_SIZE(idev->irq); i++) {
+        qemu_init_irq_child(OBJECT(idev), "irq[*]", &idev->irq[i],
+                            bus->set_irq, idev, i);
+    }
 
     k->realize(dev, errp);
 }
 
 static void ipack_device_unrealize(DeviceState *dev)
 {
+    IPackDevice *idev = IPACK_DEVICE(dev);
     IPackDeviceClass *k = IPACK_DEVICE_GET_CLASS(dev);
 
     if (k->unrealize) {
         k->unrealize(dev);
-        return;
+    }
+
+    for (int i = 0; i < ARRAY_SIZE(idev->irq); i++) {
+        object_unparent(OBJECT(&idev->irq[i]));
     }
 }
 
diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
index 2337c3115b..f93bf49754 100644
--- a/hw/isa/vt82c686.c
+++ b/hw/isa/vt82c686.c
@@ -722,7 +722,8 @@ static void via_isa_realize(PCIDevice *d, Error **errp)
 
     qdev_init_gpio_out_named(dev, &s->cpu_intr, "intr", 1);
     qdev_init_gpio_in_named(dev, via_isa_pirq, "pirq", PCI_NUM_PINS);
-    qemu_init_irq(&s->i8259_irq, via_isa_request_i8259_irq, s, 0);
+    qemu_init_irq_child(OBJECT(s), "i8259-irq", &s->i8259_irq,
+                        via_isa_request_i8259_irq, s, 0);
     isa_bus = isa_bus_new(dev, pci_address_space(d), pci_address_space_io(d),
                           errp);
 
diff --git a/hw/net/imx_fec.c b/hw/net/imx_fec.c
index c177b7ff2b..38e0f64462 100644
--- a/hw/net/imx_fec.c
+++ b/hw/net/imx_fec.c
@@ -1205,7 +1205,7 @@ static void imx_eth_realize(DeviceState *dev, Error **errp)
     sysbus_init_irq(sbd, &s->irq[0]);
     sysbus_init_irq(sbd, &s->irq[1]);
 
-    qemu_init_irq(&s->mii_irq, imx_phy_update_irq, s, 0);
+    qemu_init_irq_child(OBJECT(s), "mii-irq", &s->mii_irq, imx_phy_update_irq, s, 0);
     object_initialize_child(OBJECT(s), "mii", &s->mii, TYPE_LAN9118_PHY);
     if (!sysbus_realize_and_unref(SYS_BUS_DEVICE(&s->mii), errp)) {
         return;
diff --git a/hw/net/lan9118.c b/hw/net/lan9118.c
index 91c3533702..2003280fc4 100644
--- a/hw/net/lan9118.c
+++ b/hw/net/lan9118.c
@@ -1274,7 +1274,7 @@ static void lan9118_realize(DeviceState *dev, Error **errp)
     const MemoryRegionOps *mem_ops =
             s->mode_16bit ? &lan9118_16bit_mem_ops : &lan9118_mem_ops;
 
-    qemu_init_irq(&s->mii_irq, lan9118_update_irq, s, 0);
+    qemu_init_irq_child(OBJECT(s), "mii-irq", &s->mii_irq, lan9118_update_irq, s, 0);
     object_initialize_child(OBJECT(s), "mii", &s->mii, TYPE_LAN9118_PHY);
     if (!sysbus_realize_and_unref(SYS_BUS_DEVICE(&s->mii), errp)) {
         return;
diff --git a/hw/ppc/pegasos.c b/hw/ppc/pegasos.c
index 426a54d8ee..845b6355e9 100644
--- a/hw/ppc/pegasos.c
+++ b/hw/ppc/pegasos.c
@@ -134,7 +134,8 @@ static void pegasos2_setup_pci_irq(PegasosMachineState *pm)
                                                    TYPE_OR_IRQ, &error_fatal,
                                                    "num-lines", "2", NULL);
                 qdev_realize(DEVICE(ori), NULL, &error_fatal);
-                qemu_init_irq(&pm->pci_irqs[i], pegasos2_pci_irq, pm, i);
+                qemu_init_irq_child(OBJECT(pm), "pci-irq[*]", &pm->pci_irqs[i],
+                                    pegasos2_pci_irq, pm, i);
                 qdev_connect_gpio_out(DEVICE(ori), 0, &pm->pci_irqs[i]);
                 pm->mv_pirq[i] = qdev_get_gpio_in_named(pm->nb, "gpp", 12 + i);
                 pm->via_pirq[i] = qdev_get_gpio_in_named(pm->sb, "pirq", i);
diff --git a/hw/sh4/r2d.c b/hw/sh4/r2d.c
index 8deda6e5f4..21e804f3d9 100644
--- a/hw/sh4/r2d.c
+++ b/hw/sh4/r2d.c
@@ -200,7 +200,10 @@ static r2d_fpga_t *r2d_fpga_init(Object *owner,
     memory_region_init_io(&s->iomem, owner, &r2d_fpga_ops, s, "r2d-fpga", 0x40);
     memory_region_add_subregion(sysmem, base, &s->iomem);
 
-    qemu_init_irqs(s->irq, NR_IRQS, r2d_fpga_irq_set, s);
+    for (int i = 0; i < NR_IRQS; i++) {
+        qemu_init_irq_child(owner, "fpga-irq[*]", &s->irq[i],
+                            r2d_fpga_irq_set, s, i);
+    }
 
     return s;
 }
-- 
2.47.1


