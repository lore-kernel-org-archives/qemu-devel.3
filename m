Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32E80C43458
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 22:45:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wigS1-0005bG-N6; Sat, 11 Jul 2026 18:45:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigRz-0005Y5-A4; Sat, 11 Jul 2026 18:45:35 -0400
Received: from pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([52.42.203.116])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigRx-00078c-5x; Sat, 11 Jul 2026 18:45:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1783809933; x=1815345933;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Yjj6bjc52hJrvGNoYEgZZOaZL70oE4aLasfwIgRs9Yc=;
 b=YIE93Qpj7iHJbINzEhNK5gGNeOxyB230xUi6YGu4DMTLQcONVsazxvgt
 bcRxEY1EN6Dmgmdj2U3GesiplqS+6SqDdbXCcGwOVyFGg0LxMT/VWErpn
 5FfGhgO1wGtcVOclPXOjYD3vT/lvk2B9yAqLMLbVO7/DF0gUBCEVYUZG2
 YyFl/mqN742Feea17hBnfBolphjgfITv0oTq7SN0fTs1bGUSWYeq4xB/F
 z1n63vTPSl3hAgav8ohcyqvZCBY6lj1xXe0Tpqzx6/lwG92PAOl5KWTLC
 8CIGgLg07J73q4Ch+UbTOBgW1wmr9+YA0ed19hSB1TsTOcRZ4/rNhLGaN w==;
X-CSE-ConnectionGUID: 9aEUzVSDQJefVn+WDWwBBQ==
X-CSE-MsgGUID: nqWeb9+BSrSaT3C9ZULJig==
X-IronPort-AV: E=Sophos;i="6.25,154,1779148800"; d="scan'208";a="23517779"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
 by internal-pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2026 22:45:29 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.53:19086]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.58.33:2525]
 with esmtp (Farcaster)
 id 727577cc-1245-4712-83ba-d12936fa9405; Sat, 11 Jul 2026 22:45:29 +0000 (UTC)
X-Farcaster-Flow-ID: 727577cc-1245-4712-83ba-d12936fa9405
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 22:45:28 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 22:45:20 +0000
From: Alexander Graf <graf@amazon.com>
To: <qemu-devel@nongnu.org>
CC: <qemu-arm@nongnu.org>, <qemu-ppc@nongnu.org>, <qemu-riscv@nongnu.org>,
 <qemu-s390x@nongnu.org>, Song Gao <17746591750@163.com>, Aditya Gupta
 <adityag@linux.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, Farhan Ali
 <alifm@linux.ibm.com>, Alistair Francis <alistair.francis@wdc.com>, "Alistair
 Francis" <alistair@alistair23.me>, Antony Pavlov <antonynpavlov@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, Artyom Tarasenko
 <atar4qemu@gmail.com>, BALATON Zoltan <balaton@eik.bme.hu>, Felipe Balbi
 <balbi@kernel.org>, Christian Borntraeger <borntraeger@linux.ibm.com>, "Brian
 Cain" <brian.cain@oss.qualcomm.com>, Hendrik Brueckner
 <brueckner@linux.ibm.com>, Chao Liu <chao.liu@processmission.com>, "Huacai
 Chen" <chenhuacai@kernel.org>, =?UTF-8?q?Cl=C3=A9ment=20Chigot?=
 <chigot@adacore.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Helge Deller <deller@gmx.de>, Dorjoy Chowdhury <dorjoychy111@gmail.com>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Alexandre Iooss
 <erdnaxe@crans.org>, Eric Farman <farman@linux.ibm.com>, Francisco Iglesias
 <francisco.iglesias@amd.com>, Gaurav Sharma <gaurav.sharma_7@nxp.com>,
 "Gautam Gala" <ggala@linux.ibm.com>, Harsh Prateek Bora
 <harshpb@linux.ibm.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?=
 <hpoussin@reactos.org>, Jan Kiszka <jan.kiszka@web.de>, Max Filippov
 <jcmvbkbc@gmail.com>, Joel Stanley <joel@jms.id.au>, Jared Rossi
 <jrossi@linux.ibm.com>, Tyrone Ting <kfting@nuvoton.com>, Frederic Konrad
 <konrad.frederic@yahoo.fr>, "Laurent Vivier" <laurent@vivier.eu>, Manos
 Pitsidianakis <manos.pitsidianakis@linaro.org>, Bibo Mao
 <maobibo@loongson.cn>, "Mark Cave-Ayland" <mark.cave-ayland@ilande.co.uk>,
 Glenn Miles <milesg@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 "Michael Rolnik" <mrolnik@gmail.com>, "Michael S . Tsirkin" <mst@redhat.com>, 
 "Niek Linnenbank" <nieklinnenbank@gmail.com>, Nicholas Piggin
 <npiggin@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Halil Pasic
 <pasic@linux.ibm.com>, "Paolo Bonzini" <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>, "Pierrick Bouvier" <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>, Sai Pavan Boddu
 <sai.pavan.boddu@amd.com>, Samuel Tardieu <sam@rfc1149.net>, Bernhard Beschow
 <shentey@gmail.com>, Stafford Horne <shorne@gmail.com>, Sergio Lopez
 <slp@redhat.com>, "Subbaraya Sundeep" <sundeep.lkml@gmail.com>, Thomas Huth
 <th.huth+qemu@posteo.eu>, "Ran Wang" <wangran@bosc.ac.cn>, Hao Wu
 <wuhaotsh@google.com>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: [RFC PATCH 032/134] hw/xen: Give onboard devices a QOM parent
Date: Sat, 11 Jul 2026 22:35:25 +0000
Message-ID: <20260711223707.42139-33-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260711223707.42139-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D032UWB001.ant.amazon.com (10.13.139.152) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Received-SPF: pass client-ip=52.42.203.116;
 envelope-from=prvs=645f258d4=graf@amazon.de;
 helo=pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_NONE=0.001, T_SPF_PERMERROR=0.01,
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

Convert the *_orphan() device-creation calls in hw/xen to the new
parented API introduced earlier in this series, so every onboard
device gets a stable path in the composition tree instead of landing
in /machine/unattached with an unstable device[N] name.

The parent for each device is the object that owns its lifetime: the
machine for board-created devices, the containing device for
composite children.  Names follow existing QOM conventions.

Per-site rationale (reviewers: dispute the modeling here):

hw/xen/xen-bus.c:1152 | qdev_new | qdev_get_machine() | "xen-bridge" | init helper called from 3 board paths with no parent arg; use qdev_get_machine() (already used in this subsystem)
hw/xen/xen-legacy-backend.c:601 | qdev_new | qdev_get_machine() | "xen-sysdev" | init helper with no parent arg; qdev_get_machine() already used just above in xen_set_dynamic_sysbus()
hw/xen/xen-pvh-common.c:176 | sysbus_create_simple | OBJECT(s) | "virtio-mmio[*]" | board-init helper receives XenPVHMachineState *s; loop-created
hw/xen/xen-pvh-common.c:196 | qdev_new | OBJECT(s) | "tpm" | board-init helper receives XenPVHMachineState *s
hw/xen/xen_pt_graphics.c:402 | pci_create_simple | OBJECT(s) | "isa-bridge" | called from XenPCIPassthroughState realize; s is the composite passthrough device

Link: https://lore.kernel.org/qemu-devel/87jyr3w9tc.fsf@pond.sub.org/
Assisted-by: Kiro
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 hw/xen/xen-bus.c            | 5 +++--
 hw/xen/xen-legacy-backend.c | 5 +++--
 hw/xen/xen-pvh-common.c     | 7 ++++---
 hw/xen/xen_pt_graphics.c    | 3 ++-
 4 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/hw/xen/xen-bus.c b/hw/xen/xen-bus.c
index 746014416b..934ff33402 100644
--- a/hw/xen/xen-bus.c
+++ b/hw/xen/xen-bus.c
@@ -1149,10 +1149,11 @@ type_init(xen_register_types)
 
 void xen_bus_init(void)
 {
-    DeviceState *dev = qdev_new_orphan(TYPE_XEN_BRIDGE);
+    DeviceState *dev = qdev_new(qdev_get_machine(), "xen-bridge",
+                                TYPE_XEN_BRIDGE);
     BusState *bus = qbus_new(TYPE_XEN_BUS, dev, NULL);
 
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
     qbus_set_bus_hotplug_handler(bus);
 
     qemu_create_nic_bus_devices(bus, TYPE_XEN_DEVICE, "xen-net-device",
diff --git a/hw/xen/xen-legacy-backend.c b/hw/xen/xen-legacy-backend.c
index 29c90a388c..0e1da18d12 100644
--- a/hw/xen/xen-legacy-backend.c
+++ b/hw/xen/xen-legacy-backend.c
@@ -598,8 +598,9 @@ void xen_be_init(void)
         exit(1);
     }
 
-    xen_sysdev = qdev_new_orphan(TYPE_XENSYSDEV);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(xen_sysdev), &error_fatal);
+    xen_sysdev = qdev_new(qdev_get_machine(), "xen-sysdev",
+                          TYPE_XENSYSDEV);
+    sysbus_realize(SYS_BUS_DEVICE(xen_sysdev), &error_fatal);
     xen_sysbus = qbus_new(TYPE_XENSYSBUS, xen_sysdev, "xen-sysbus");
     qbus_set_bus_hotplug_handler(xen_sysbus);
 
diff --git a/hw/xen/xen-pvh-common.c b/hw/xen/xen-pvh-common.c
index 17f545d07c..dae523f723 100644
--- a/hw/xen/xen-pvh-common.c
+++ b/hw/xen/xen-pvh-common.c
@@ -173,7 +173,8 @@ static void xen_create_virtio_mmio_devices(XenPVHMachineState *s)
         qemu_irq irq = qemu_allocate_irq(xen_set_irq, NULL,
                                          s->cfg.virtio_mmio_irq_base + i);
 
-        sysbus_create_simple_orphan("virtio-mmio", base, irq);
+        sysbus_create_simple(OBJECT(s), "virtio-mmio[*]", "virtio-mmio",
+                             base, irq);
 
         trace_xen_create_virtio_mmio_devices(i,
                                              s->cfg.virtio_mmio_irq_base + i,
@@ -193,7 +194,7 @@ static void xen_enable_tpm(XenPVHMachineState *s)
         error_report("Couldn't find tmp0 backend");
         return;
     }
-    dev = qdev_new_orphan(TYPE_TPM_TIS_SYSBUS);
+    dev = qdev_new(OBJECT(s), "tpm", TYPE_TPM_TIS_SYSBUS);
     /*
      * FIXME This use of &err is is wrong.  If both calls fail, the
      * second will trip error_setv()'s assertion.  If just one call
@@ -204,7 +205,7 @@ static void xen_enable_tpm(XenPVHMachineState *s)
     object_property_set_link(OBJECT(dev), "tpmdev", OBJECT(be), &err);
     object_property_set_str(OBJECT(dev), "tpmdev", be->id, &err);
     busdev = SYS_BUS_DEVICE(dev);
-    sysbus_realize_and_unref(busdev, &error_fatal);
+    sysbus_realize(busdev, &error_fatal);
     sysbus_mmio_map(busdev, 0, s->cfg.tpm.base);
 
     trace_xen_enable_tpm(s->cfg.tpm.base);
diff --git a/hw/xen/xen_pt_graphics.c b/hw/xen/xen_pt_graphics.c
index 4457209e83..2841b45ca1 100644
--- a/hw/xen/xen_pt_graphics.c
+++ b/hw/xen/xen_pt_graphics.c
@@ -399,7 +399,8 @@ void xen_igd_passthrough_isa_bridge_create(XenPCIPassthroughState *s,
     }
 
     /* Currently IGD drivers always need to access PCH by 1f.0. */
-    bridge_dev = pci_create_simple_orphan(bus, PCI_DEVFN(0x1f, 0),
+    bridge_dev = pci_create_simple(OBJECT(s), "isa-bridge", bus,
+                                   PCI_DEVFN(0x1f, 0),
                                    "igd-passthrough-isa-bridge");
 
     /*
-- 
2.47.1


