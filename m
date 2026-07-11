Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ACC4C43458
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 22:41:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wigNL-00047u-19; Sat, 11 Jul 2026 18:40:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigNJ-00043v-Hy; Sat, 11 Jul 2026 18:40:45 -0400
Received: from pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([44.246.68.102])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigNF-0005mg-Kr; Sat, 11 Jul 2026 18:40:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1783809641; x=1815345641;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=8qB3yVqVzEHdcQcyvRloVub+hLfEuv5n21OR2C+g0CU=;
 b=O0fVth1pzSzpLoc7etW0tmUqTjGXrcM138jUFYbinMQbgOOwLvxSUQxZ
 ZY3DfRht/NlsfscN1cSwlNf+DggfU/YFhhiRqueRm+9r55X+Ue8XAdBm/
 XtR9tJlFhX6U2kY7mGOBSDrA/wQFLYTksjVSYMo8yE4Zvi2NqjwyqzHHj
 ZueazEIMyNawKmjzY8BmlTQv2A8NZlfrBjRyFK3PoUICyCsaCXi1/6ZRG
 qUQQ7gKgd7BkWywR5OL+laZ11BVuL7s+HD/RwoObszmJbpyDJiKgUxqy1
 ritI+gk5QbDHycyTtnZpbOmGCEwxi8qynTvTT+I/X3i6VGa+HM2lx+P0h w==;
X-CSE-ConnectionGUID: mhBJrtIQR7GXKYwYvwUE/Q==
X-CSE-MsgGUID: kUFf/vlYS06QlpXKX5gf7w==
X-IronPort-AV: E=Sophos;i="6.25,154,1779148800"; d="scan'208";a="23517015"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
 by internal-pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2026 22:40:37 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.111:8026]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.35.214:2525]
 with esmtp (Farcaster)
 id b54a1bf2-3fb6-4c80-8bc5-1137b2e286ce; Sat, 11 Jul 2026 22:40:37 +0000 (UTC)
X-Farcaster-Flow-ID: b54a1bf2-3fb6-4c80-8bc5-1137b2e286ce
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 22:40:36 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 22:40:28 +0000
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
Subject: [RFC PATCH 013/134] hw/alpha: Give onboard devices a QOM parent
Date: Sat, 11 Jul 2026 22:35:06 +0000
Message-ID: <20260711223707.42139-14-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260711223707.42139-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D031UWC004.ant.amazon.com (10.13.139.246) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Received-SPF: pass client-ip=44.246.68.102;
 envelope-from=prvs=645f258d4=graf@amazon.de;
 helo=pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com
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

Convert the *_orphan() device-creation calls in hw/alpha to the new
parented API introduced earlier in this series, so every onboard
device gets a stable path in the composition tree instead of landing
in /machine/unattached with an unstable device[N] name.

The parent for each device is the object that owns its lifetime: the
machine for board-created devices, the containing device for
composite children.  Names follow existing QOM conventions.

Per-site rationale (reviewers: dispute the modeling here):

  file:line       | parent           | name         | rationale
  dp264.c:68      | OBJECT(machine)  | "cpu[*]"     | SMP CPUs created by board init()
  dp264.c:113     | OBJECT(machine)  | "isa-bridge" | i82378 PCI-ISA bridge is a fixed onboard device; the machine owns it
  dp264.c:129     | OBJECT(machine)  | "sio"        | SMC37C669 Super-I/O is a fixed onboard device
  dp264.c:132     | OBJECT(machine)  | "ide"        | CMD646 IDE controller is a fixed onboard device
  typhoon.c:833   | OBJECT(machine)  | "typhoon"    | Typhoon PCI host bridge is a fixed chipset of the DP264 board; thread an Object *parent argument through typhoon_init() from clipper_init()

Link: https://lore.kernel.org/qemu-devel/87jyr3w9tc.fsf@pond.sub.org/
Assisted-by: Kiro
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 hw/alpha/alpha_sys.h |  3 ++-
 hw/alpha/dp264.c     | 12 +++++++-----
 hw/alpha/typhoon.c   |  6 +++---
 3 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/hw/alpha/alpha_sys.h b/hw/alpha/alpha_sys.h
index 6e6691d116..f8aaf74933 100644
--- a/hw/alpha/alpha_sys.h
+++ b/hw/alpha/alpha_sys.h
@@ -9,7 +9,8 @@
 #include "hw/intc/i8259.h"
 
 
-PCIBus *typhoon_init(MemoryRegion *, qemu_irq *, qemu_irq *, AlphaCPU *[4],
+PCIBus *typhoon_init(Object *parent, MemoryRegion *,
+                     qemu_irq *, qemu_irq *, AlphaCPU *[4],
                      pci_map_irq_fn, uint8_t devfn_min);
 
 /* alpha_pci.c.  */
diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
index 512b270838..9cd448cff1 100644
--- a/hw/alpha/dp264.c
+++ b/hw/alpha/dp264.c
@@ -49,6 +49,7 @@ static void clipper_init(MachineState *machine)
     const char *kernel_cmdline = machine->kernel_cmdline;
     const char *initrd_filename = machine->initrd_filename;
     MachineClass *mc = MACHINE_GET_CLASS(machine);
+    Object *mo = OBJECT(machine);
     AlphaCPU *cpus[4];
     PCIBus *pci_bus;
     PCIDevice *pci_dev;
@@ -65,7 +66,7 @@ static void clipper_init(MachineState *machine)
     /* Create up to 4 cpus.  */
     memset(cpus, 0, sizeof(cpus));
     for (i = 0; i < smp_cpus; ++i) {
-        cpus[i] = ALPHA_CPU(cpu_create_orphan(machine->cpu_type));
+        cpus[i] = ALPHA_CPU(cpu_create(mo, "cpu[*]", machine->cpu_type));
     }
 
     /*
@@ -86,7 +87,7 @@ static void clipper_init(MachineState *machine)
      * Init the chipset.  Because we're using CLIPPER IRQ mappings,
      * the minimum PCI device IdSel is 1.
      */
-    pci_bus = typhoon_init(machine->ram, &isa_irq, &rtc_irq, cpus,
+    pci_bus = typhoon_init(mo, machine->ram, &isa_irq, &rtc_irq, cpus,
                            clipper_pci_map_irq, PCI_DEVFN(1, 0));
 
     /*
@@ -110,7 +111,8 @@ static void clipper_init(MachineState *machine)
      * Importantly, we need to provide a PCI device node for it, otherwise
      * some operating systems won't notice there's an ISA bus to configure.
      */
-    i82378_dev = DEVICE(pci_create_simple_orphan(pci_bus, PCI_DEVFN(7, 0), "i82378"));
+    i82378_dev = DEVICE(pci_create_simple(mo, "isa-bridge", pci_bus,
+                                          PCI_DEVFN(7, 0), "i82378"));
     isa_bus = ISA_BUS(qdev_get_child_bus(i82378_dev, "isa.0"));
 
     /* Connect the ISA PIC to the Typhoon IRQ used for ISA interrupts. */
@@ -126,10 +128,10 @@ static void clipper_init(MachineState *machine)
     pci_init_nic_devices(pci_bus, mc->default_nic);
 
     /* Super I/O */
-    isa_create_simple_orphan(isa_bus, TYPE_SMC37C669_SUPERIO);
+    isa_create_simple(mo, "sio", isa_bus, TYPE_SMC37C669_SUPERIO);
 
     /* IDE disk setup.  */
-    pci_dev = pci_create_simple_orphan(pci_bus, -1, "cmd646-ide");
+    pci_dev = pci_create_simple(mo, "ide", pci_bus, -1, "cmd646-ide");
     pci_ide_create_devs(pci_dev);
 
     /* Load PALcode.  Given that this is not "real" cpu palcode,
diff --git a/hw/alpha/typhoon.c b/hw/alpha/typhoon.c
index af40647ccd..af39f2659b 100644
--- a/hw/alpha/typhoon.c
+++ b/hw/alpha/typhoon.c
@@ -819,7 +819,7 @@ static void typhoon_alarm_timer(void *opaque)
     cpu_interrupt(CPU(s->cchip.cpu[cpu]), CPU_INTERRUPT_TIMER);
 }
 
-PCIBus *typhoon_init(MemoryRegion *ram, qemu_irq *p_isa_irq,
+PCIBus *typhoon_init(Object *parent, MemoryRegion *ram, qemu_irq *p_isa_irq,
                      qemu_irq *p_rtc_irq, AlphaCPU *cpus[4],
                      pci_map_irq_fn sys_map_irq, uint8_t devfn_min)
 {
@@ -830,7 +830,7 @@ PCIBus *typhoon_init(MemoryRegion *ram, qemu_irq *p_isa_irq,
     PCIBus *b;
     int i;
 
-    dev = qdev_new_orphan(TYPE_TYPHOON_PCI_HOST_BRIDGE);
+    dev = qdev_new(parent, "typhoon", TYPE_TYPHOON_PCI_HOST_BRIDGE);
 
     s = TYPHOON_PCI_HOST_BRIDGE(dev);
     phb = PCI_HOST_BRIDGE(dev);
@@ -894,7 +894,7 @@ PCIBus *typhoon_init(MemoryRegion *ram, qemu_irq *p_isa_irq,
                               &s->pchip.reg_mem, &s->pchip.reg_io,
                               devfn_min, 64, TYPE_PCI_BUS);
     phb->bus = b;
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
 
     /* Host memory as seen from the PCI side, via the IOMMU.  */
     memory_region_init_iommu(&s->pchip.iommu, sizeof(s->pchip.iommu),
-- 
2.47.1


