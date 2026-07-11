Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDF27C44501
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 22:43:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wigPt-00005q-CW; Sat, 11 Jul 2026 18:43:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigPb-0008Cr-Kz; Sat, 11 Jul 2026 18:43:10 -0400
Received: from pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([35.155.198.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigPW-0006PQ-Ql; Sat, 11 Jul 2026 18:43:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1783809782; x=1815345782;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=+JQONIxLiKgSEvBk5WxaMW61+AyonZAMUAgYAySg9EM=;
 b=SL4xkQ/GgtB/jNOepxMPmo2BoLiCZ8UbAzld1qbf4anC0vk3PXDuxoXF
 4Q12DEOFG/s9obLwa/NAPXml7rJv+mp1VJ7TLR+bEQrEXPZrG4a1H6tsu
 vvwiA0dFXwCx9lIqIS0TZaiCGEgl1SoT7dGc2s6k6M6/UV/sOqJOZlOp4
 1rQgAdzbQh98D3YZ7kMV4G0pyfveUASsCZ9ExdxJM2rSvNsY92csPfGC4
 mLJGb3dQuS6yzFlWhEMb3qz2mLor38aJVoQxMM5Wp5RnLnL9BcHycnHD6
 kwnOIx/b+Vl9pCYeS+wd4vpp4Dtx6dIDKgm82VZNu0mSUDS1vSYwlS2ZE Q==;
X-CSE-ConnectionGUID: /makQJAkTm2qnQcrBo0gWg==
X-CSE-MsgGUID: fuBZ8w0mS1KQy/OUsY1fSQ==
X-IronPort-AV: E=Sophos;i="6.25,154,1779148800"; d="scan'208";a="23390381"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
 by internal-pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2026 22:42:59 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.111:25026]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.47.135:2525]
 with esmtp (Farcaster)
 id b513e70b-a5c0-47ef-86ff-ad21e2d96af8; Sat, 11 Jul 2026 22:42:58 +0000 (UTC)
X-Farcaster-Flow-ID: b513e70b-a5c0-47ef-86ff-ad21e2d96af8
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 22:42:58 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 22:42:49 +0000
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
Subject: [RFC PATCH 022/134] hw/intc: Give onboard devices a QOM parent
Date: Sat, 11 Jul 2026 22:35:15 +0000
Message-ID: <20260711223707.42139-23-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260711223707.42139-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D044UWB001.ant.amazon.com (10.13.139.171) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Received-SPF: pass client-ip=35.155.198.111;
 envelope-from=prvs=645f258d4=graf@amazon.de;
 helo=pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com
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

Convert the *_orphan() device-creation calls in hw/intc to the new
parented API introduced earlier in this series, so every onboard
device gets a stable path in the composition tree instead of landing
in /machine/unattached with an unstable device[N] name.

The parent for each device is the object that owns its lifetime: the
machine for board-created devices, the containing device for
composite children.  Names follow existing QOM conventions.

Per-site rationale (reviewers: dispute the modeling here):

hw/intc/apic_common.c:285 | sysbus_create_simple | qdev_get_machine() | "kvmvapic" | function-static singleton shared by all per-CPU APICs; cannot belong to any single APIC, so parent to the machine
hw/intc/exynos4210_gic.c:63 | qdev_new | OBJECT(dev) | "gic" | inside exynos4210_gic_realize(); inner GIC is a component of the composite Exynos GIC device
hw/intc/i8259_common.c:97 | isa_new | Object *parent (new arg) | "i8259[*]" | i8259_init_chip() is a helper with no parent-capable arg; thread Object *parent through i8259_init()/kvm_i8259_init() and their callers; two chips per parent so auto-index
hw/intc/riscv_aclint.c:372 | qdev_new | Object *parent (new arg) | "aclint-mtimer[*]" | riscv_aclint_mtimer_create() helper; parent threaded from board/SoC callers; per-socket instances so auto-index
hw/intc/riscv_aclint.c:555 | qdev_new | Object *parent (new arg) | "aclint-swi[*]" | riscv_aclint_swi_create() helper; parent threaded from board/SoC callers; per-socket M/S-SWI so auto-index
hw/intc/riscv_aplic.c:1116 | qdev_new | Object *parent (new arg) | "aplic[*]" | riscv_aplic_create() helper; existing DeviceState *parent (APLIC hierarchy) renamed to aplic_parent to avoid clash; multiple M/S instances so auto-index
hw/intc/riscv_imsic.c:477 | qdev_new | Object *parent (new arg) | "imsic[*]" | riscv_imsic_create() helper; parent threaded from board/SoC callers; per-hart M/S instances so auto-index
hw/intc/s390_flic.c:65 | qdev_new | qdev_get_machine() | TYPE_KVM_S390_FLIC | already followed by object_property_add_child(machine, ...); collapse into parented qdev_new() and drop the redundant add_child
hw/intc/s390_flic.c:69 | qdev_new | qdev_get_machine() | TYPE_QEMU_S390_FLIC | same as above; collapse into parented qdev_new() and drop the redundant add_child
hw/intc/sifive_plic.c:484 | qdev_new | Object *parent (new arg) | "plic[*]" | sifive_plic_create() helper; parent threaded from board/SoC callers; per-socket instances so auto-index

Link: https://lore.kernel.org/qemu-devel/87jyr3w9tc.fsf@pond.sub.org/
Assisted-by: Kiro
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 hw/hppa/machine.c               |  8 ++++----
 hw/i386/isapc.c                 |  2 +-
 hw/i386/kvm/i8259.c             |  6 +++---
 hw/i386/microvm.c               |  2 +-
 hw/i386/pc.c                    |  6 +++---
 hw/i386/pc_piix.c               |  2 +-
 hw/i386/pc_q35.c                |  2 +-
 hw/intc/apic_common.c           |  3 ++-
 hw/intc/exynos4210_gic.c        |  4 ++--
 hw/intc/i8259.c                 |  6 +++---
 hw/intc/i8259_common.c          |  7 ++++---
 hw/intc/riscv_aclint.c          | 16 ++++++++++------
 hw/intc/riscv_aplic.c           | 13 +++++++------
 hw/intc/riscv_imsic.c           |  7 ++++---
 hw/intc/s390_flic.c             | 12 +++++-------
 hw/intc/sifive_plic.c           |  7 ++++---
 hw/isa/i82378.c                 |  2 +-
 hw/isa/piix.c                   |  2 +-
 hw/isa/vt82c686.c               |  2 +-
 hw/mips/jazz.c                  |  2 +-
 hw/riscv/aia.c                  | 12 +++++++-----
 hw/riscv/aia.h                  |  3 ++-
 hw/riscv/cps.c                  |  9 +++++----
 hw/riscv/k230.c                 | 12 +++++++-----
 hw/riscv/microchip_pfsoc.c      |  7 ++++---
 hw/riscv/shakti_c.c             |  8 +++++---
 hw/riscv/sifive_e.c             |  7 ++++---
 hw/riscv/sifive_u.c             |  7 ++++---
 hw/riscv/spike.c                |  4 ++--
 hw/riscv/tt_atlantis.c          |  6 ++++--
 hw/riscv/virt.c                 | 27 +++++++++++++++++----------
 hw/riscv/xiangshan_kmh.c        | 18 ++++++++++--------
 include/hw/i386/pc.h            |  2 +-
 include/hw/intc/i8259.h         |  4 ++--
 include/hw/intc/riscv_aclint.h  |  6 ++++--
 include/hw/intc/riscv_aplic.h   |  5 +++--
 include/hw/intc/riscv_imsic.h   |  3 ++-
 include/hw/intc/sifive_plic.h   |  3 ++-
 include/hw/isa/i8259_internal.h |  3 ++-
 39 files changed, 146 insertions(+), 111 deletions(-)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 729524e065..e50f9adf41 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -97,7 +97,7 @@ static const MemoryRegionOps hppa_pci_ignore_ops = {
     },
 };
 
-static ISABus *hppa_isa_bus(hwaddr addr)
+static ISABus *hppa_isa_bus(Object *parent, hwaddr addr)
 {
     ISABus *isa_bus;
     qemu_irq *isa_irqs;
@@ -110,7 +110,7 @@ static ISABus *hppa_isa_bus(hwaddr addr)
 
     isa_bus = isa_bus_new(NULL, get_system_memory(), isa_region,
                           &error_abort);
-    isa_irqs = i8259_init(isa_bus, NULL);
+    isa_irqs = i8259_init(parent, isa_bus, NULL);
     isa_bus_register_input_irqs(isa_bus, isa_irqs);
 
     return isa_bus;
@@ -596,7 +596,7 @@ static void machine_HP_715_init(MachineState *machine)
     }
 
     /* Create ISA bus, needed for PS/2 kbd/mouse port emulation */
-    isa_bus = hppa_isa_bus(translate(NULL, IDE_HPA));
+    isa_bus = hppa_isa_bus(OBJECT(machine), translate(NULL, IDE_HPA));
     assert(isa_bus);
 
     /* Init Lasi chip */
@@ -690,7 +690,7 @@ static void machine_HP_B160L_init(MachineState *machine)
     assert(pci_bus);
 
     /* Create ISA bus, needed for PS/2 kbd/mouse port emulation */
-    isa_bus = hppa_isa_bus(translate(NULL, IDE_HPA));
+    isa_bus = hppa_isa_bus(OBJECT(machine), translate(NULL, IDE_HPA));
     assert(isa_bus);
 
     /* Serial ports: Lasi and Dino use a 7.272727 MHz clock. */
diff --git a/hw/i386/isapc.c b/hw/i386/isapc.c
index 03d68f748f..655ec599b5 100644
--- a/hw/i386/isapc.c
+++ b/hw/i386/isapc.c
@@ -123,7 +123,7 @@ static void pc_init_isa(MachineState *machine)
     pcms->hpet_enabled = false;
 
     if (x86ms->pic == ON_OFF_AUTO_ON || x86ms->pic == ON_OFF_AUTO_AUTO) {
-        pc_i8259_create(isa_bus, gsi_state->i8259_irq);
+        pc_i8259_create(OBJECT(machine), isa_bus, gsi_state->i8259_irq);
     }
 
     if (tcg_enabled()) {
diff --git a/hw/i386/kvm/i8259.c b/hw/i386/kvm/i8259.c
index 66f37e1303..5fb11d3613 100644
--- a/hw/i386/kvm/i8259.c
+++ b/hw/i386/kvm/i8259.c
@@ -131,10 +131,10 @@ static void kvm_pic_realize(DeviceState *dev, Error **errp)
     kpc->parent_realize(dev, errp);
 }
 
-qemu_irq *kvm_i8259_init(ISABus *bus)
+qemu_irq *kvm_i8259_init(Object *parent, ISABus *bus)
 {
-    i8259_init_chip(TYPE_KVM_I8259, bus, true);
-    i8259_init_chip(TYPE_KVM_I8259, bus, false);
+    i8259_init_chip(parent, TYPE_KVM_I8259, bus, true);
+    i8259_init_chip(parent, TYPE_KVM_I8259, bus, false);
 
     return qemu_allocate_irqs(kvm_pic_set_irq, NULL, ISA_NUM_IRQS);
 }
diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index 22688687c4..16bd885541 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -251,7 +251,7 @@ static void microvm_devices_init(MicrovmMachineState *mms)
     if (x86ms->pic == ON_OFF_AUTO_ON || x86ms->pic == ON_OFF_AUTO_AUTO) {
         qemu_irq *i8259;
 
-        i8259 = i8259_init(isa_bus, x86_allocate_cpu_irq());
+        i8259 = i8259_init(OBJECT(mms), isa_bus, x86_allocate_cpu_irq());
         for (i = 0; i < ISA_NUM_IRQS; i++) {
             gsi_state->i8259_irq[i] = i8259[i];
         }
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 905b4960a3..24ba1189d7 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1159,16 +1159,16 @@ void pc_nic_init(PCMachineClass *pcmc, ISABus *isa_bus, PCIBus *pci_bus)
     }
 }
 
-void pc_i8259_create(ISABus *isa_bus, qemu_irq *i8259_irqs)
+void pc_i8259_create(Object *parent, ISABus *isa_bus, qemu_irq *i8259_irqs)
 {
     qemu_irq *i8259;
 
     if (kvm_pic_in_kernel()) {
-        i8259 = kvm_i8259_init(isa_bus);
+        i8259 = kvm_i8259_init(parent, isa_bus);
     } else if (xen_enabled()) {
         i8259 = xen_interrupt_controller_init();
     } else {
-        i8259 = i8259_init(isa_bus, x86_allocate_cpu_irq());
+        i8259 = i8259_init(parent, isa_bus, x86_allocate_cpu_irq());
     }
 
     for (size_t i = 0; i < ISA_NUM_IRQS; i++) {
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index bd4c129143..3f361c8396 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -281,7 +281,7 @@ static void pc_init1(MachineState *machine, const char *pci_type)
 
 
     if (x86ms->pic == ON_OFF_AUTO_ON || x86ms->pic == ON_OFF_AUTO_AUTO) {
-        pc_i8259_create(isa_bus, gsi_state->i8259_irq);
+        pc_i8259_create(OBJECT(machine), isa_bus, gsi_state->i8259_irq);
     }
 
     ioapic_init_gsi(gsi_state, phb);
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index daa75dbc26..a4a7169398 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -272,7 +272,7 @@ static void pc_q35_init(MachineState *machine)
     isa_bus = ISA_BUS(qdev_get_child_bus(lpc_dev, "isa.0"));
 
     if (x86ms->pic == ON_OFF_AUTO_ON || x86ms->pic == ON_OFF_AUTO_AUTO) {
-        pc_i8259_create(isa_bus, gsi_state->i8259_irq);
+        pc_i8259_create(OBJECT(machine), isa_bus, gsi_state->i8259_irq);
     }
 
     ioapic_init_gsi(gsi_state, OBJECT(phb));
diff --git a/hw/intc/apic_common.c b/hw/intc/apic_common.c
index aaa7dca480..be90fe0d2b 100644
--- a/hw/intc/apic_common.c
+++ b/hw/intc/apic_common.c
@@ -282,7 +282,8 @@ static void apic_common_realize(DeviceState *dev, Error **errp)
     /* Note: We need at least 1M to map the VAPIC option ROM */
     if (!vapic && s->vapic_control & VAPIC_ENABLE_MASK &&
             current_machine->ram_size >= 1024 * 1024) {
-        vapic = sysbus_create_simple_orphan("kvmvapic", -1, NULL);
+        vapic = sysbus_create_simple(qdev_get_machine(), "kvmvapic",
+                                     "kvmvapic", -1, NULL);
     }
     s->vapic = vapic;
     if (apic_report_tpr_access && info->enable_tpr_reporting) {
diff --git a/hw/intc/exynos4210_gic.c b/hw/intc/exynos4210_gic.c
index dd29a86035..d6e987c8c6 100644
--- a/hw/intc/exynos4210_gic.c
+++ b/hw/intc/exynos4210_gic.c
@@ -60,11 +60,11 @@ static void exynos4210_gic_realize(DeviceState *dev, Error **errp)
     uint32_t n = s->num_cpu;
     uint32_t i;
 
-    s->gic = qdev_new_orphan("arm_gic");
+    s->gic = qdev_new(obj, "gic", "arm_gic");
     qdev_prop_set_uint32(s->gic, "num-cpu", s->num_cpu);
     qdev_prop_set_uint32(s->gic, "num-irq", EXYNOS4210_GIC_NIRQ);
     gicbusdev = SYS_BUS_DEVICE(s->gic);
-    sysbus_realize_and_unref(gicbusdev, &error_fatal);
+    sysbus_realize(gicbusdev, &error_fatal);
 
     /* Pass through outbound IRQ lines from the GIC */
     sysbus_pass_irq(sbd, gicbusdev);
diff --git a/hw/intc/i8259.c b/hw/intc/i8259.c
index 8f2aa1f0fb..1446d5197a 100644
--- a/hw/intc/i8259.c
+++ b/hw/intc/i8259.c
@@ -401,7 +401,7 @@ static void pic_realize(DeviceState *dev, Error **errp)
     pc->parent_realize(dev, errp);
 }
 
-qemu_irq *i8259_init(ISABus *bus, qemu_irq parent_irq_in)
+qemu_irq *i8259_init(Object *parent, ISABus *bus, qemu_irq parent_irq_in)
 {
     qemu_irq *irq_set;
     DeviceState *dev;
@@ -410,7 +410,7 @@ qemu_irq *i8259_init(ISABus *bus, qemu_irq parent_irq_in)
 
     irq_set = g_new0(qemu_irq, ISA_NUM_IRQS);
 
-    isadev = i8259_init_chip(TYPE_I8259, bus, true);
+    isadev = i8259_init_chip(parent, TYPE_I8259, bus, true);
     dev = DEVICE(isadev);
 
     qdev_connect_gpio_out(dev, 0, parent_irq_in);
@@ -420,7 +420,7 @@ qemu_irq *i8259_init(ISABus *bus, qemu_irq parent_irq_in)
 
     isa_pic = PIC_COMMON(dev);
 
-    isadev = i8259_init_chip(TYPE_I8259, bus, false);
+    isadev = i8259_init_chip(parent, TYPE_I8259, bus, false);
     dev = DEVICE(isadev);
 
     qdev_connect_gpio_out(dev, 0, irq_set[2]);
diff --git a/hw/intc/i8259_common.c b/hw/intc/i8259_common.c
index 45eb0e14a8..7d3137fe19 100644
--- a/hw/intc/i8259_common.c
+++ b/hw/intc/i8259_common.c
@@ -89,18 +89,19 @@ static void pic_common_realize(DeviceState *dev, Error **errp)
     qdev_set_legacy_instance_id(dev, s->iobase, 1);
 }
 
-ISADevice *i8259_init_chip(const char *name, ISABus *bus, bool master)
+ISADevice *i8259_init_chip(Object *parent, const char *name, ISABus *bus,
+                           bool master)
 {
     DeviceState *dev;
     ISADevice *isadev;
 
-    isadev = isa_new_orphan(name);
+    isadev = isa_new(parent, "i8259[*]", name);
     dev = DEVICE(isadev);
     qdev_prop_set_uint32(dev, "iobase", master ? 0x20 : 0xa0);
     qdev_prop_set_uint32(dev, "elcr_addr", master ? 0x4d0 : 0x4d1);
     qdev_prop_set_uint8(dev, "elcr_mask", master ? 0xf8 : 0xde);
     qdev_prop_set_bit(dev, "master", master);
-    isa_realize_and_unref(isadev, bus, &error_fatal);
+    qdev_realize(dev, BUS(bus), &error_fatal);
 
     return isadev;
 }
diff --git a/hw/intc/riscv_aclint.c b/hw/intc/riscv_aclint.c
index 92030d94b6..8a0e5d6d1c 100644
--- a/hw/intc/riscv_aclint.c
+++ b/hw/intc/riscv_aclint.c
@@ -363,13 +363,15 @@ static const TypeInfo riscv_aclint_mtimer_info = {
 /*
  * Create ACLINT MTIMER device.
  */
-DeviceState *riscv_aclint_mtimer_create(hwaddr addr, hwaddr size,
+DeviceState *riscv_aclint_mtimer_create(Object *parent,
+    hwaddr addr, hwaddr size,
     uint32_t hartid_base, uint32_t num_harts,
     uint32_t timecmp_base, uint32_t time_base, uint32_t timebase_freq,
     bool provide_rdtime)
 {
     int i;
-    DeviceState *dev = qdev_new_orphan(TYPE_RISCV_ACLINT_MTIMER);
+    DeviceState *dev = qdev_new(parent, "aclint-mtimer[*]",
+                                TYPE_RISCV_ACLINT_MTIMER);
     RISCVAclintMTimerState *s = RISCV_ACLINT_MTIMER(dev);
 
     assert(num_harts <= RISCV_ACLINT_MAX_HARTS);
@@ -383,7 +385,7 @@ DeviceState *riscv_aclint_mtimer_create(hwaddr addr, hwaddr size,
     qdev_prop_set_uint32(dev, "time-base", time_base);
     qdev_prop_set_uint32(dev, "aperture-size", size);
     qdev_prop_set_uint32(dev, "timebase-freq", timebase_freq);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, addr);
 
     for (i = 0; i < num_harts; i++) {
@@ -548,11 +550,13 @@ static const TypeInfo riscv_aclint_swi_info = {
 /*
  * Create ACLINT [M|S]SWI device.
  */
-DeviceState *riscv_aclint_swi_create(hwaddr addr, uint32_t hartid_base,
+DeviceState *riscv_aclint_swi_create(Object *parent, hwaddr addr,
+    uint32_t hartid_base,
     uint32_t num_harts, bool sswi)
 {
     int i;
-    DeviceState *dev = qdev_new_orphan(TYPE_RISCV_ACLINT_SWI);
+    DeviceState *dev = qdev_new(parent, "aclint-swi[*]",
+                                TYPE_RISCV_ACLINT_SWI);
 
     assert(num_harts <= RISCV_ACLINT_MAX_HARTS);
     assert(!(addr & 0x3));
@@ -560,7 +564,7 @@ DeviceState *riscv_aclint_swi_create(hwaddr addr, uint32_t hartid_base,
     qdev_prop_set_uint32(dev, "hartid-base", hartid_base);
     qdev_prop_set_uint32(dev, "num-harts", num_harts);
     qdev_prop_set_uint32(dev, "sswi", sswi ? true : false);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, addr);
 
     for (i = 0; i < num_harts; i++) {
diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
index 977e259cb9..491faaa2cf 100644
--- a/hw/intc/riscv_aplic.c
+++ b/hw/intc/riscv_aplic.c
@@ -1109,11 +1109,12 @@ void riscv_aplic_add_child(DeviceState *parent, DeviceState *child)
 /*
  * Create APLIC device.
  */
-DeviceState *riscv_aplic_create(hwaddr addr, hwaddr size,
+DeviceState *riscv_aplic_create(Object *parent, hwaddr addr, hwaddr size,
     uint32_t hartid_base, uint32_t num_harts, uint32_t num_sources,
-    uint32_t iprio_bits, bool msimode, bool mmode, DeviceState *parent)
+    uint32_t iprio_bits, bool msimode, bool mmode,
+    DeviceState *aplic_parent)
 {
-    DeviceState *dev = qdev_new_orphan(TYPE_RISCV_APLIC);
+    DeviceState *dev = qdev_new(parent, "aplic[*]", TYPE_RISCV_APLIC);
     uint32_t i;
 
     assert(num_harts < APLIC_MAX_IDC);
@@ -1130,11 +1131,11 @@ DeviceState *riscv_aplic_create(hwaddr addr, hwaddr size,
     qdev_prop_set_bit(dev, "msimode", msimode);
     qdev_prop_set_bit(dev, "mmode", mmode);
 
-    if (parent) {
-        riscv_aplic_add_child(parent, dev);
+    if (aplic_parent) {
+        riscv_aplic_add_child(aplic_parent, dev);
     }
 
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
 
     if (riscv_use_emulated_aplic(msimode)) {
         sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, addr);
diff --git a/hw/intc/riscv_imsic.c b/hw/intc/riscv_imsic.c
index f05917ad5e..1587be5e8b 100644
--- a/hw/intc/riscv_imsic.c
+++ b/hw/intc/riscv_imsic.c
@@ -471,10 +471,11 @@ type_init(riscv_imsic_register_types)
 /*
  * Create IMSIC device.
  */
-DeviceState *riscv_imsic_create(hwaddr addr, uint32_t hartid, bool mmode,
+DeviceState *riscv_imsic_create(Object *parent, hwaddr addr,
+                                uint32_t hartid, bool mmode,
                                 uint32_t num_pages, uint32_t num_ids)
 {
-    DeviceState *dev = qdev_new_orphan(TYPE_RISCV_IMSIC);
+    DeviceState *dev = qdev_new(parent, "imsic[*]", TYPE_RISCV_IMSIC);
     CPUState *cpu = cpu_by_arch_id(hartid);
     uint32_t i;
 
@@ -493,7 +494,7 @@ DeviceState *riscv_imsic_create(hwaddr addr, uint32_t hartid, bool mmode,
     qdev_prop_set_uint32(dev, "num-pages", num_pages);
     qdev_prop_set_uint32(dev, "num-irqs", num_ids + 1);
 
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, addr);
 
     if (!kvm_irqchip_in_kernel()) {
diff --git a/hw/intc/s390_flic.c b/hw/intc/s390_flic.c
index c86c0e1e60..8d165d6b9e 100644
--- a/hw/intc/s390_flic.c
+++ b/hw/intc/s390_flic.c
@@ -62,15 +62,13 @@ void s390_flic_init(void)
     DeviceState *dev;
 
     if (kvm_enabled()) {
-        dev = qdev_new_orphan(TYPE_KVM_S390_FLIC);
-        object_property_add_child(qdev_get_machine(), TYPE_KVM_S390_FLIC,
-                                  OBJECT(dev));
+        dev = qdev_new(qdev_get_machine(), TYPE_KVM_S390_FLIC,
+                       TYPE_KVM_S390_FLIC);
     } else {
-        dev = qdev_new_orphan(TYPE_QEMU_S390_FLIC);
-        object_property_add_child(qdev_get_machine(), TYPE_QEMU_S390_FLIC,
-                                  OBJECT(dev));
+        dev = qdev_new(qdev_get_machine(), TYPE_QEMU_S390_FLIC,
+                       TYPE_QEMU_S390_FLIC);
     }
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
 }
 
 static int qemu_s390_register_io_adapter(S390FLICState *fs, uint32_t id,
diff --git a/hw/intc/sifive_plic.c b/hw/intc/sifive_plic.c
index 00e6258403..f2262ed5ae 100644
--- a/hw/intc/sifive_plic.c
+++ b/hw/intc/sifive_plic.c
@@ -473,7 +473,8 @@ type_init(sifive_plic_register_types)
 /*
  * Create PLIC device.
  */
-DeviceState *sifive_plic_create(hwaddr addr, char *hart_config,
+DeviceState *sifive_plic_create(Object *parent, hwaddr addr,
+    char *hart_config,
     uint32_t num_harts,
     uint32_t hartid_base, uint32_t num_sources,
     uint32_t num_priorities, uint32_t priority_base,
@@ -481,7 +482,7 @@ DeviceState *sifive_plic_create(hwaddr addr, char *hart_config,
     uint32_t enable_stride, uint32_t context_base,
     uint32_t context_stride, uint32_t aperture_size)
 {
-    DeviceState *dev = qdev_new_orphan(TYPE_SIFIVE_PLIC);
+    DeviceState *dev = qdev_new(parent, "plic[*]", TYPE_SIFIVE_PLIC);
     int i;
     SiFivePLICState *plic;
 
@@ -498,7 +499,7 @@ DeviceState *sifive_plic_create(hwaddr addr, char *hart_config,
     qdev_prop_set_uint32(dev, "context-base", context_base);
     qdev_prop_set_uint32(dev, "context-stride", context_stride);
     qdev_prop_set_uint32(dev, "aperture-size", aperture_size);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, addr);
 
     plic = SIFIVE_PLIC(dev);
diff --git a/hw/isa/i82378.c b/hw/isa/i82378.c
index 63d4050db2..da09d869f5 100644
--- a/hw/isa/i82378.c
+++ b/hw/isa/i82378.c
@@ -94,7 +94,7 @@ static void i82378_realize(PCIDevice *pci, Error **errp)
      */
 
     /* 2 82C59 (irq) */
-    s->isa_irqs_in = i8259_init(isabus,
+    s->isa_irqs_in = i8259_init(OBJECT(pci), isabus,
                                 qemu_allocate_irq(i82378_request_out0_irq,
                                                   s, 0));
     isa_bus_register_input_irqs(isabus, s->isa_irqs_in);
diff --git a/hw/isa/piix.c b/hw/isa/piix.c
index 31fa53e6a4..6b2946d82c 100644
--- a/hw/isa/piix.c
+++ b/hw/isa/piix.c
@@ -319,7 +319,7 @@ static void pci_piix_realize(PCIDevice *dev, const char *uhci_type,
 
         qemu_init_irq_child(OBJECT(dev), "i8259-irq", &d->i8259_irq,
                             piix_request_i8259_irq, d, 0);
-        i8259 = i8259_init(isa_bus, &d->i8259_irq);
+        i8259 = i8259_init(OBJECT(dev), isa_bus, &d->i8259_irq);
 
         for (size_t i = 0; i < ISA_NUM_IRQS; i++) {
             d->isa_irqs_in[i] = i8259[i];
diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
index 99be41d0ad..de9006bd95 100644
--- a/hw/isa/vt82c686.c
+++ b/hw/isa/vt82c686.c
@@ -730,7 +730,7 @@ static void via_isa_realize(PCIDevice *d, Error **errp)
         return;
     }
 
-    s->isa_irqs_in = i8259_init(isa_bus, &s->i8259_irq);
+    s->isa_irqs_in = i8259_init(OBJECT(d), isa_bus, &s->i8259_irq);
     isa_bus_register_input_irqs(isa_bus, s->isa_irqs_in);
     i8254_pit_init(isa_bus, 0x40, 0, NULL);
     i8257_dma_init(OBJECT(d), isa_bus, 0);
diff --git a/hw/mips/jazz.c b/hw/mips/jazz.c
index 849c97eb10..5e34a6582d 100644
--- a/hw/mips/jazz.c
+++ b/hw/mips/jazz.c
@@ -285,7 +285,7 @@ static void mips_jazz_init(MachineState *machine,
     isa_bus = isa_bus_new(NULL, isa_mem, isa_io, &error_abort);
 
     /* ISA devices */
-    i8259 = i8259_init(isa_bus, env->irq[4]);
+    i8259 = i8259_init(OBJECT(machine), isa_bus, env->irq[4]);
     isa_bus_register_input_irqs(isa_bus, i8259);
     i8257_dma_init(OBJECT(rc4030), isa_bus, 0);
     pit = i8254_pit_init(isa_bus, 0x40, 0, NULL);
diff --git a/hw/riscv/aia.c b/hw/riscv/aia.c
index ed89160029..3ffdfe86fd 100644
--- a/hw/riscv/aia.c
+++ b/hw/riscv/aia.c
@@ -24,7 +24,8 @@ uint32_t imsic_num_bits(uint32_t count)
     return ret;
 }
 
-DeviceState *riscv_create_aia(bool msimode, int aia_guests,
+DeviceState *riscv_create_aia(Object *parent,
+                             bool msimode, int aia_guests,
                              uint32_t m_imsic_stride,
                              uint16_t num_sources,
                              const MemMapEntry *aplic_m,
@@ -48,7 +49,7 @@ DeviceState *riscv_create_aia(bool msimode, int aia_guests,
             /* Per-socket M-level IMSICs */
             addr = imsic_m->base + socket * (1U << IMSIC_MMIO_GROUP_MIN_SHIFT);
             for (i = 0; i < hart_count; i++) {
-                riscv_imsic_create(addr + i * m_imsic_stride,
+                riscv_imsic_create(parent, addr + i * m_imsic_stride,
                                    base_hartid + i, true, 1,
                                    num_msis);
             }
@@ -58,7 +59,8 @@ DeviceState *riscv_create_aia(bool msimode, int aia_guests,
         guest_bits = imsic_num_bits(aia_guests + 1);
         addr = imsic_s->base + socket * (1U << IMSIC_MMIO_GROUP_MIN_SHIFT);
         for (i = 0; i < hart_count; i++) {
-            riscv_imsic_create(addr + i * IMSIC_HART_SIZE(guest_bits),
+            riscv_imsic_create(parent,
+                               addr + i * IMSIC_HART_SIZE(guest_bits),
                                base_hartid + i, false, 1 + aia_guests,
                                num_msis);
         }
@@ -66,7 +68,7 @@ DeviceState *riscv_create_aia(bool msimode, int aia_guests,
 
     if (!kvm_enabled()) {
         /* Per-socket M-level APLIC */
-        aplic_m_dev = riscv_aplic_create(aplic_m->base +
+        aplic_m_dev = riscv_aplic_create(parent, aplic_m->base +
                                      socket * aplic_m->size,
                                      aplic_m->size,
                                      (msimode) ? 0 : base_hartid,
@@ -77,7 +79,7 @@ DeviceState *riscv_create_aia(bool msimode, int aia_guests,
     }
 
     /* Per-socket S-level APLIC */
-    aplic_s_dev = riscv_aplic_create(aplic_s->base +
+    aplic_s_dev = riscv_aplic_create(parent, aplic_s->base +
                                  socket * aplic_s->size,
                                  aplic_s->size,
                                  (msimode) ? 0 : base_hartid,
diff --git a/hw/riscv/aia.h b/hw/riscv/aia.h
index 565f91accc..09bae100e3 100644
--- a/hw/riscv/aia.h
+++ b/hw/riscv/aia.h
@@ -13,7 +13,8 @@
 
 uint32_t imsic_num_bits(uint32_t count);
 
-DeviceState *riscv_create_aia(bool msimode, int aia_guests,
+DeviceState *riscv_create_aia(Object *parent,
+                             bool msimode, int aia_guests,
                              uint32_t m_imsic_stride,
                              uint16_t num_sources,
                              const MemMapEntry *aplic_m,
diff --git a/hw/riscv/cps.c b/hw/riscv/cps.c
index 86172be5b3..b6b30e05e1 100644
--- a/hw/riscv/cps.c
+++ b/hw/riscv/cps.c
@@ -135,14 +135,15 @@ static void riscv_cps_realize(DeviceState *dev, Error **errp)
     for (i = 0; i < num_of_clusters; i++) {
         uint64_t cm_base = GLOBAL_CM_BASE + (CM_SIZE * i);
         uint32_t hartid_base = i << MHARTID_CLUSTER_SHIFT;
-        s->aplic = riscv_aplic_create(cm_base + AIA_PLIC_M_OFFSET,
+        s->aplic = riscv_aplic_create(OBJECT(dev),
+                                      cm_base + AIA_PLIC_M_OFFSET,
                                       AIA_PLIC_M_SIZE,
                                       hartid_base, /* hartid_base */
                                       MAX_HARTS, /* num_harts */
                                       APLIC_NUM_SOURCES,
                                       APLIC_NUM_PRIO_BITS,
                                       false, true, NULL);
-        riscv_aplic_create(cm_base + AIA_PLIC_S_OFFSET,
+        riscv_aplic_create(OBJECT(dev), cm_base + AIA_PLIC_S_OFFSET,
                            AIA_PLIC_S_SIZE,
                            hartid_base, /* hartid_base */
                            MAX_HARTS, /* num_harts */
@@ -151,9 +152,9 @@ static void riscv_cps_realize(DeviceState *dev, Error **errp)
                            false, false, s->aplic);
         /* PLIC changes msi_nonbroken to ture. We revert the change. */
         msi_nonbroken = false;
-        riscv_aclint_swi_create(cm_base + AIA_CLINT_OFFSET,
+        riscv_aclint_swi_create(OBJECT(dev), cm_base + AIA_CLINT_OFFSET,
                                 hartid_base, MAX_HARTS, false);
-        riscv_aclint_mtimer_create(cm_base + AIA_CLINT_OFFSET +
+        riscv_aclint_mtimer_create(OBJECT(dev), cm_base + AIA_CLINT_OFFSET +
                                    RISCV_ACLINT_SWI_SIZE,
                                    RISCV_ACLINT_DEFAULT_MTIMER_SIZE,
                                    hartid_base,
diff --git a/hw/riscv/k230.c b/hw/riscv/k230.c
index 656f28190c..9c67dfb895 100644
--- a/hw/riscv/k230.c
+++ b/hw/riscv/k230.c
@@ -117,7 +117,8 @@ static void k230_soc_init(Object *obj)
                          memmap[K230_DEV_BOOTROM].base);
 }
 
-static DeviceState *k230_create_plic(int base_hartid, int hartid_count)
+static DeviceState *k230_create_plic(Object *parent, int base_hartid,
+                                     int hartid_count)
 {
     g_autofree char *plic_hart_config = NULL;
 
@@ -125,7 +126,7 @@ static DeviceState *k230_create_plic(int base_hartid, int hartid_count)
     plic_hart_config = riscv_plic_hart_config_string(hartid_count);
 
     /* Per-socket PLIC */
-    return sifive_plic_create(memmap[K230_DEV_PLIC].base,
+    return sifive_plic_create(parent, memmap[K230_DEV_PLIC].base,
                               plic_hart_config, hartid_count, base_hartid,
                               K230_PLIC_NUM_SOURCES,
                               K230_PLIC_NUM_PRIORITIES,
@@ -174,12 +175,13 @@ static void k230_soc_realize(DeviceState *dev, Error **errp)
                                 &s->bootrom);
 
     /* PLIC */
-    s->c908_plic = k230_create_plic(C908_CPU_HARTID, c908_cpus);
+    s->c908_plic = k230_create_plic(OBJECT(dev), C908_CPU_HARTID, c908_cpus);
 
     /* CLINT */
-    riscv_aclint_swi_create(memmap[K230_DEV_CLINT].base,
+    riscv_aclint_swi_create(OBJECT(dev), memmap[K230_DEV_CLINT].base,
                             C908_CPU_HARTID, c908_cpus, false);
-    riscv_aclint_mtimer_create(memmap[K230_DEV_CLINT].base + 0x4000,
+    riscv_aclint_mtimer_create(OBJECT(dev),
+                               memmap[K230_DEV_CLINT].base + 0x4000,
                                RISCV_ACLINT_DEFAULT_MTIMER_SIZE,
                                C908_CPU_HARTID, c908_cpus,
                                RISCV_ACLINT_DEFAULT_MTIMECMP,
diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index cc93b5c2ba..18ce57fba4 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -250,9 +250,9 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
         memmap[MICROCHIP_PFSOC_BUSERR_UNIT4].size);
 
     /* CLINT */
-    riscv_aclint_swi_create(memmap[MICROCHIP_PFSOC_CLINT].base,
+    riscv_aclint_swi_create(OBJECT(dev), memmap[MICROCHIP_PFSOC_CLINT].base,
         0, ms->smp.cpus, false);
-    riscv_aclint_mtimer_create(
+    riscv_aclint_mtimer_create(OBJECT(dev),
         memmap[MICROCHIP_PFSOC_CLINT].base + RISCV_ACLINT_SWI_SIZE,
         RISCV_ACLINT_DEFAULT_MTIMER_SIZE, 0, ms->smp.cpus,
         RISCV_ACLINT_DEFAULT_MTIMECMP, RISCV_ACLINT_DEFAULT_MTIME,
@@ -281,7 +281,8 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
     plic_hart_config = riscv_plic_hart_config_string(ms->smp.cpus);
 
     /* PLIC */
-    s->plic = sifive_plic_create(memmap[MICROCHIP_PFSOC_PLIC].base,
+    s->plic = sifive_plic_create(OBJECT(dev),
+        memmap[MICROCHIP_PFSOC_PLIC].base,
         plic_hart_config, ms->smp.cpus, 0,
         MICROCHIP_PFSOC_PLIC_NUM_SOURCES,
         MICROCHIP_PFSOC_PLIC_NUM_PRIORITIES,
diff --git a/hw/riscv/shakti_c.c b/hw/riscv/shakti_c.c
index 835b1f879b..a6f832dd31 100644
--- a/hw/riscv/shakti_c.c
+++ b/hw/riscv/shakti_c.c
@@ -115,7 +115,8 @@ static void shakti_c_soc_state_realize(DeviceState *dev, Error **errp)
 
     sysbus_realize(SYS_BUS_DEVICE(&sss->cpus), &error_abort);
 
-    sss->plic = sifive_plic_create(shakti_c_memmap[SHAKTI_C_PLIC].base,
+    sss->plic = sifive_plic_create(OBJECT(dev),
+        shakti_c_memmap[SHAKTI_C_PLIC].base,
         (char *)SHAKTI_C_PLIC_HART_CONFIG, ms->smp.cpus, 0,
         SHAKTI_C_PLIC_NUM_SOURCES,
         SHAKTI_C_PLIC_NUM_PRIORITIES,
@@ -127,9 +128,10 @@ static void shakti_c_soc_state_realize(DeviceState *dev, Error **errp)
         SHAKTI_C_PLIC_CONTEXT_STRIDE,
         shakti_c_memmap[SHAKTI_C_PLIC].size);
 
-    riscv_aclint_swi_create(shakti_c_memmap[SHAKTI_C_CLINT].base,
+    riscv_aclint_swi_create(OBJECT(dev), shakti_c_memmap[SHAKTI_C_CLINT].base,
         0, 1, false);
-    riscv_aclint_mtimer_create(shakti_c_memmap[SHAKTI_C_CLINT].base +
+    riscv_aclint_mtimer_create(OBJECT(dev),
+        shakti_c_memmap[SHAKTI_C_CLINT].base +
             RISCV_ACLINT_SWI_SIZE,
         RISCV_ACLINT_DEFAULT_MTIMER_SIZE, 0, 1,
         RISCV_ACLINT_DEFAULT_MTIMECMP, RISCV_ACLINT_DEFAULT_MTIME,
diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index 71925583bd..dfdb7ae4c1 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -214,7 +214,7 @@ static void sifive_e_soc_realize(DeviceState *dev, Error **errp)
         memmap[SIFIVE_E_DEV_MROM].base, &s->mask_rom);
 
     /* MMIO */
-    s->plic = sifive_plic_create(memmap[SIFIVE_E_DEV_PLIC].base,
+    s->plic = sifive_plic_create(OBJECT(dev), memmap[SIFIVE_E_DEV_PLIC].base,
         (char *)SIFIVE_E_PLIC_HART_CONFIG, ms->smp.cpus, 0,
         SIFIVE_E_PLIC_NUM_SOURCES,
         SIFIVE_E_PLIC_NUM_PRIORITIES,
@@ -225,9 +225,10 @@ static void sifive_e_soc_realize(DeviceState *dev, Error **errp)
         SIFIVE_E_PLIC_CONTEXT_BASE,
         SIFIVE_E_PLIC_CONTEXT_STRIDE,
         memmap[SIFIVE_E_DEV_PLIC].size);
-    riscv_aclint_swi_create(memmap[SIFIVE_E_DEV_CLINT].base,
+    riscv_aclint_swi_create(OBJECT(dev), memmap[SIFIVE_E_DEV_CLINT].base,
         0, ms->smp.cpus, false);
-    riscv_aclint_mtimer_create(memmap[SIFIVE_E_DEV_CLINT].base +
+    riscv_aclint_mtimer_create(OBJECT(dev),
+        memmap[SIFIVE_E_DEV_CLINT].base +
             RISCV_ACLINT_SWI_SIZE,
         RISCV_ACLINT_DEFAULT_MTIMER_SIZE, 0, ms->smp.cpus,
         RISCV_ACLINT_DEFAULT_MTIMECMP, RISCV_ACLINT_DEFAULT_MTIME,
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 47ce75ef11..41eb22dc02 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -771,7 +771,7 @@ static void sifive_u_soc_realize(DeviceState *dev, Error **errp)
     plic_hart_config = riscv_plic_hart_config_string(ms->smp.cpus);
 
     /* MMIO */
-    s->plic = sifive_plic_create(memmap[SIFIVE_U_DEV_PLIC].base,
+    s->plic = sifive_plic_create(OBJECT(dev), memmap[SIFIVE_U_DEV_PLIC].base,
         plic_hart_config, ms->smp.cpus, 0,
         SIFIVE_U_PLIC_NUM_SOURCES,
         SIFIVE_U_PLIC_NUM_PRIORITIES,
@@ -787,9 +787,10 @@ static void sifive_u_soc_realize(DeviceState *dev, Error **errp)
         serial_hd(0), qdev_get_gpio_in(DEVICE(s->plic), SIFIVE_U_UART0_IRQ));
     sifive_uart_create(system_memory, memmap[SIFIVE_U_DEV_UART1].base,
         serial_hd(1), qdev_get_gpio_in(DEVICE(s->plic), SIFIVE_U_UART1_IRQ));
-    riscv_aclint_swi_create(memmap[SIFIVE_U_DEV_CLINT].base, 0,
+    riscv_aclint_swi_create(OBJECT(dev), memmap[SIFIVE_U_DEV_CLINT].base, 0,
         ms->smp.cpus, false);
-    riscv_aclint_mtimer_create(memmap[SIFIVE_U_DEV_CLINT].base +
+    riscv_aclint_mtimer_create(OBJECT(dev),
+        memmap[SIFIVE_U_DEV_CLINT].base +
             RISCV_ACLINT_SWI_SIZE,
         RISCV_ACLINT_DEFAULT_MTIMER_SIZE, 0, ms->smp.cpus,
         RISCV_ACLINT_DEFAULT_MTIMECMP, RISCV_ACLINT_DEFAULT_MTIME,
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index 9fde0faf39..c53409e4f1 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -163,10 +163,10 @@ static void spike_board_init(MachineState *machine)
         sysbus_realize(SYS_BUS_DEVICE(&s->soc[i]), &error_fatal);
 
         /* Core Local Interruptor (timer and IPI) for each socket */
-        riscv_aclint_swi_create(
+        riscv_aclint_swi_create(OBJECT(machine),
             memmap[SPIKE_CLINT].base + i * memmap[SPIKE_CLINT].size,
             base_hartid, hart_count, false);
-        riscv_aclint_mtimer_create(
+        riscv_aclint_mtimer_create(OBJECT(machine),
             memmap[SPIKE_CLINT].base + i * memmap[SPIKE_CLINT].size +
                 RISCV_ACLINT_SWI_SIZE,
             RISCV_ACLINT_DEFAULT_MTIMER_SIZE, base_hartid, hart_count,
diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
index c3be7eb913..6c12d85460 100644
--- a/hw/riscv/tt_atlantis.c
+++ b/hw/riscv/tt_atlantis.c
@@ -494,7 +494,8 @@ static void tt_atlantis_machine_init(MachineState *machine)
                             &error_abort);
     sysbus_realize(SYS_BUS_DEVICE(&s->soc), &error_fatal);
 
-    s->irqchip = riscv_create_aia(true, TT_IRQCHIP_GUESTS,
+    s->irqchip = riscv_create_aia(OBJECT(machine),
+                                  true, TT_IRQCHIP_GUESTS,
                                   TT_IRQCHIP_MIMSIC_STRIDE,
                                   TT_IRQCHIP_NUM_SOURCES,
                                   &s->memmap[TT_ATL_MAPLIC],
@@ -505,7 +506,8 @@ static void tt_atlantis_machine_init(MachineState *machine)
                                   TT_IRQCHIP_NUM_MSIS,
                                   TT_IRQCHIP_NUM_PRIO_BITS);
 
-    riscv_aclint_mtimer_create(s->memmap[TT_ATL_ACLINT].base,
+    riscv_aclint_mtimer_create(OBJECT(machine),
+            s->memmap[TT_ATL_ACLINT].base,
             TT_ACLINT_MTIME_SIZE,
             0, hart_count,
             TT_ACLINT_MTIMECMP,
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 44e1cfa7be..3ceb476b84 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1115,7 +1115,8 @@ static FWCfgState *create_fw_cfg(const MachineState *ms, hwaddr base)
     return fw_cfg;
 }
 
-static DeviceState *virt_create_plic(const MemMapEntry *memmap, int socket,
+static DeviceState *virt_create_plic(Object *parent,
+                                     const MemMapEntry *memmap, int socket,
                                      int base_hartid, int hart_count)
 {
     g_autofree char *plic_hart_config = NULL;
@@ -1124,7 +1125,7 @@ static DeviceState *virt_create_plic(const MemMapEntry *memmap, int socket,
     plic_hart_config = riscv_plic_hart_config_string(hart_count);
 
     /* Per-socket PLIC */
-    return sifive_plic_create(
+    return sifive_plic_create(parent,
              memmap[VIRT_PLIC].base + socket * memmap[VIRT_PLIC].size,
              plic_hart_config, hart_count, base_hartid,
              VIRT_IRQCHIP_NUM_SOURCES,
@@ -1357,7 +1358,8 @@ static void virt_machine_init(MachineState *machine)
         if (virt_aclint_allowed() && s->have_aclint) {
             if (s->aia_type == VIRT_AIA_TYPE_APLIC_IMSIC) {
                 /* Per-socket ACLINT MTIMER */
-                riscv_aclint_mtimer_create(s->memmap[VIRT_CLINT].base +
+                riscv_aclint_mtimer_create(OBJECT(machine),
+                        s->memmap[VIRT_CLINT].base +
                             i * RISCV_ACLINT_DEFAULT_MTIMER_SIZE,
                         RISCV_ACLINT_DEFAULT_MTIMER_SIZE,
                         base_hartid, hart_count,
@@ -1366,10 +1368,12 @@ static void virt_machine_init(MachineState *machine)
                         RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ, true);
             } else {
                 /* Per-socket ACLINT MSWI, MTIMER, and SSWI */
-                riscv_aclint_swi_create(s->memmap[VIRT_CLINT].base +
+                riscv_aclint_swi_create(OBJECT(machine),
+                        s->memmap[VIRT_CLINT].base +
                             i * s->memmap[VIRT_CLINT].size,
                         base_hartid, hart_count, false);
-                riscv_aclint_mtimer_create(s->memmap[VIRT_CLINT].base +
+                riscv_aclint_mtimer_create(OBJECT(machine),
+                        s->memmap[VIRT_CLINT].base +
                             i * s->memmap[VIRT_CLINT].size +
                             RISCV_ACLINT_SWI_SIZE,
                         RISCV_ACLINT_DEFAULT_MTIMER_SIZE,
@@ -1377,16 +1381,18 @@ static void virt_machine_init(MachineState *machine)
                         RISCV_ACLINT_DEFAULT_MTIMECMP,
                         RISCV_ACLINT_DEFAULT_MTIME,
                         RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ, true);
-                riscv_aclint_swi_create(s->memmap[VIRT_ACLINT_SSWI].base +
+                riscv_aclint_swi_create(OBJECT(machine),
+                        s->memmap[VIRT_ACLINT_SSWI].base +
                             i * s->memmap[VIRT_ACLINT_SSWI].size,
                         base_hartid, hart_count, true);
             }
         } else if (tcg_enabled()) {
             /* Per-socket SiFive CLINT */
-            riscv_aclint_swi_create(
+            riscv_aclint_swi_create(OBJECT(machine),
                     s->memmap[VIRT_CLINT].base + i * s->memmap[VIRT_CLINT].size,
                     base_hartid, hart_count, false);
-            riscv_aclint_mtimer_create(s->memmap[VIRT_CLINT].base +
+            riscv_aclint_mtimer_create(OBJECT(machine),
+                        s->memmap[VIRT_CLINT].base +
                     i * s->memmap[VIRT_CLINT].size + RISCV_ACLINT_SWI_SIZE,
                     RISCV_ACLINT_DEFAULT_MTIMER_SIZE, base_hartid, hart_count,
                     RISCV_ACLINT_DEFAULT_MTIMECMP, RISCV_ACLINT_DEFAULT_MTIME,
@@ -1395,10 +1401,11 @@ static void virt_machine_init(MachineState *machine)
 
         /* Per-socket interrupt controller */
         if (s->aia_type == VIRT_AIA_TYPE_NONE) {
-            s->irqchip[i] = virt_create_plic(s->memmap, i,
+            s->irqchip[i] = virt_create_plic(OBJECT(machine), s->memmap, i,
                                              base_hartid, hart_count);
         } else {
-            s->irqchip[i] = riscv_create_aia(s->aia_type == VIRT_AIA_TYPE_APLIC_IMSIC,
+            s->irqchip[i] = riscv_create_aia(OBJECT(machine),
+                                             s->aia_type == VIRT_AIA_TYPE_APLIC_IMSIC,
                                              s->aia_guests,
                                              IMSIC_HART_SIZE(0),
                                              s->num_sources,
diff --git a/hw/riscv/xiangshan_kmh.c b/hw/riscv/xiangshan_kmh.c
index 384624d69a..c1c10e9456 100644
--- a/hw/riscv/xiangshan_kmh.c
+++ b/hw/riscv/xiangshan_kmh.c
@@ -55,7 +55,8 @@ static const MemMapEntry xiangshan_kmh_memmap[] = {
     [XIANGSHAN_KMH_DRAM] =         { 0x80000000,           0x0 },
 };
 
-static DeviceState *xiangshan_kmh_create_aia(uint32_t num_harts)
+static DeviceState *xiangshan_kmh_create_aia(Object *parent,
+                                             uint32_t num_harts)
 {
     int i;
     const MemMapEntry *memmap = xiangshan_kmh_memmap;
@@ -65,27 +66,27 @@ static DeviceState *xiangshan_kmh_create_aia(uint32_t num_harts)
     /* M-level IMSICs */
     addr = memmap[XIANGSHAN_KMH_IMSIC_M].base;
     for (i = 0; i < num_harts; i++) {
-        riscv_imsic_create(addr + i * IMSIC_HART_SIZE(0), i, true,
+        riscv_imsic_create(parent, addr + i * IMSIC_HART_SIZE(0), i, true,
                            1, XIANGSHAN_KMH_IMSIC_NUM_IDS);
     }
 
     /* S-level IMSICs */
     addr = memmap[XIANGSHAN_KMH_IMSIC_S].base;
     for (i = 0; i < num_harts; i++) {
-        riscv_imsic_create(addr +
+        riscv_imsic_create(parent, addr +
                            i * IMSIC_HART_SIZE(XIANGSHAN_KMH_IMSIC_GUEST_BITS),
                            i, false, 1 + XIANGSHAN_KMH_IMSIC_GUEST_BITS,
                            XIANGSHAN_KMH_IMSIC_NUM_IDS);
     }
 
     /* M-level APLIC */
-    aplic_m = riscv_aplic_create(memmap[XIANGSHAN_KMH_APLIC_M].base,
+    aplic_m = riscv_aplic_create(parent, memmap[XIANGSHAN_KMH_APLIC_M].base,
                                  memmap[XIANGSHAN_KMH_APLIC_M].size,
                                  0, 0, XIANGSHAN_KMH_APLIC_NUM_SOURCES,
                                  1, true, true, NULL);
 
     /* S-level APLIC */
-    riscv_aplic_create(memmap[XIANGSHAN_KMH_APLIC_S].base,
+    riscv_aplic_create(parent, memmap[XIANGSHAN_KMH_APLIC_S].base,
                        memmap[XIANGSHAN_KMH_APLIC_S].size,
                        0, 0, XIANGSHAN_KMH_APLIC_NUM_SOURCES,
                        1, true, false, aplic_m);
@@ -108,7 +109,7 @@ static void xiangshan_kmh_soc_realize(DeviceState *dev, Error **errp)
     sysbus_realize(SYS_BUS_DEVICE(&s->cpus), &error_fatal);
 
     /* AIA */
-    s->irqchip = xiangshan_kmh_create_aia(num_harts);
+    s->irqchip = xiangshan_kmh_create_aia(OBJECT(dev), num_harts);
 
     /* UART */
     serial_mm_init(system_memory, memmap[XIANGSHAN_KMH_UART0].base, 2,
@@ -116,9 +117,10 @@ static void xiangshan_kmh_soc_realize(DeviceState *dev, Error **errp)
                    115200, serial_hd(0), DEVICE_LITTLE_ENDIAN);
 
     /* CLINT */
-    riscv_aclint_swi_create(memmap[XIANGSHAN_KMH_CLINT].base,
+    riscv_aclint_swi_create(OBJECT(dev), memmap[XIANGSHAN_KMH_CLINT].base,
                             0, num_harts, false);
-    riscv_aclint_mtimer_create(memmap[XIANGSHAN_KMH_CLINT].base +
+    riscv_aclint_mtimer_create(OBJECT(dev),
+                               memmap[XIANGSHAN_KMH_CLINT].base +
                                RISCV_ACLINT_SWI_SIZE,
                                RISCV_ACLINT_DEFAULT_MTIMER_SIZE,
                                0, num_harts, RISCV_ACLINT_DEFAULT_MTIMECMP,
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index d4b6d3ed57..dbaf61bcf1 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -191,7 +191,7 @@ void pc_basic_device_init(struct PCMachineState *pcms,
                           uint32_t hpet_irqs);
 void pc_nic_init(PCMachineClass *pcmc, ISABus *isa_bus, PCIBus *pci_bus);
 
-void pc_i8259_create(ISABus *isa_bus, qemu_irq *i8259_irqs);
+void pc_i8259_create(Object *parent, ISABus *isa_bus, qemu_irq *i8259_irqs);
 
 /* port92.c */
 #define PORT92_A20_LINE "a20"
diff --git a/include/hw/intc/i8259.h b/include/hw/intc/i8259.h
index 1f2420231f..9aa89890b1 100644
--- a/include/hw/intc/i8259.h
+++ b/include/hw/intc/i8259.h
@@ -14,8 +14,8 @@ extern PICCommonState *isa_pic;
  * connect its output to @parent_irq_in,
  * return an (allocated) array of 16 input IRQs.
  */
-qemu_irq *i8259_init(ISABus *bus, qemu_irq parent_irq_in);
-qemu_irq *kvm_i8259_init(ISABus *bus);
+qemu_irq *i8259_init(Object *parent, ISABus *bus, qemu_irq parent_irq_in);
+qemu_irq *kvm_i8259_init(Object *parent, ISABus *bus);
 int pic_get_output(PICCommonState *s);
 int pic_read_irq(PICCommonState *s);
 
diff --git a/include/hw/intc/riscv_aclint.h b/include/hw/intc/riscv_aclint.h
index 0e0b98acb0..18c70fd3c7 100644
--- a/include/hw/intc/riscv_aclint.h
+++ b/include/hw/intc/riscv_aclint.h
@@ -46,7 +46,8 @@ typedef struct RISCVAclintMTimerState {
     qemu_irq *timer_irqs;
 } RISCVAclintMTimerState;
 
-DeviceState *riscv_aclint_mtimer_create(hwaddr addr, hwaddr size,
+DeviceState *riscv_aclint_mtimer_create(Object *parent,
+    hwaddr addr, hwaddr size,
     uint32_t hartid_base, uint32_t num_harts,
     uint32_t timecmp_base, uint32_t time_base, uint32_t timebase_freq,
     bool provide_rdtime);
@@ -68,7 +69,8 @@ typedef struct RISCVAclintSwiState {
     qemu_irq *soft_irqs;
 } RISCVAclintSwiState;
 
-DeviceState *riscv_aclint_swi_create(hwaddr addr, uint32_t hartid_base,
+DeviceState *riscv_aclint_swi_create(Object *parent, hwaddr addr,
+    uint32_t hartid_base,
     uint32_t num_harts, bool sswi);
 
 enum {
diff --git a/include/hw/intc/riscv_aplic.h b/include/hw/intc/riscv_aplic.h
index c7a4d4ad01..8d45120f48 100644
--- a/include/hw/intc/riscv_aplic.h
+++ b/include/hw/intc/riscv_aplic.h
@@ -80,8 +80,9 @@ bool riscv_is_kvm_aia_aplic_imsic(bool msimode);
 bool riscv_use_emulated_aplic(bool msimode);
 void riscv_aplic_set_kvm_msicfgaddr(RISCVAPLICState *aplic, hwaddr addr);
 
-DeviceState *riscv_aplic_create(hwaddr addr, hwaddr size,
+DeviceState *riscv_aplic_create(Object *parent, hwaddr addr, hwaddr size,
     uint32_t hartid_base, uint32_t num_harts, uint32_t num_sources,
-    uint32_t iprio_bits, bool msimode, bool mmode, DeviceState *parent);
+    uint32_t iprio_bits, bool msimode, bool mmode,
+    DeviceState *aplic_parent);
 
 #endif
diff --git a/include/hw/intc/riscv_imsic.h b/include/hw/intc/riscv_imsic.h
index fae999731d..c46232fbc4 100644
--- a/include/hw/intc/riscv_imsic.h
+++ b/include/hw/intc/riscv_imsic.h
@@ -62,7 +62,8 @@ struct RISCVIMSICState {
     uint32_t num_irqs;
 };
 
-DeviceState *riscv_imsic_create(hwaddr addr, uint32_t hartid, bool mmode,
+DeviceState *riscv_imsic_create(Object *parent, hwaddr addr,
+                                uint32_t hartid, bool mmode,
                                 uint32_t num_pages, uint32_t num_ids);
 
 #endif
diff --git a/include/hw/intc/sifive_plic.h b/include/hw/intc/sifive_plic.h
index 32973dbf28..9e67098ce4 100644
--- a/include/hw/intc/sifive_plic.h
+++ b/include/hw/intc/sifive_plic.h
@@ -76,7 +76,8 @@ struct SiFivePLICState {
     qemu_irq *s_external_irqs;
 };
 
-DeviceState *sifive_plic_create(hwaddr addr, char *hart_config,
+DeviceState *sifive_plic_create(Object *parent, hwaddr addr,
+    char *hart_config,
     uint32_t num_harts,
     uint32_t hartid_base, uint32_t num_sources,
     uint32_t num_priorities, uint32_t priority_base,
diff --git a/include/hw/isa/i8259_internal.h b/include/hw/isa/i8259_internal.h
index f9dcc4163e..b351ac2672 100644
--- a/include/hw/isa/i8259_internal.h
+++ b/include/hw/isa/i8259_internal.h
@@ -71,7 +71,8 @@ struct PICCommonState {
 };
 
 void pic_reset_common(PICCommonState *s);
-ISADevice *i8259_init_chip(const char *name, ISABus *bus, bool master);
+ISADevice *i8259_init_chip(Object *parent, const char *name, ISABus *bus,
+                           bool master);
 void pic_stat_update_irq(int irq, int level);
 
 #endif /* QEMU_I8259_INTERNAL_H */
-- 
2.47.1


