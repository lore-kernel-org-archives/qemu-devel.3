Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCC31C43458
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 23:06:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wigmP-0004Vv-6G; Sat, 11 Jul 2026 19:06:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigmO-0004VA-BJ; Sat, 11 Jul 2026 19:06:40 -0400
Received: from pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([44.246.68.102])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigmJ-0003dF-Rh; Sat, 11 Jul 2026 19:06:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1783811195; x=1815347195;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=APA3Aj96SjjFE4GKXHDqPSKc1SHkwzYFyZRZ/nvhBHo=;
 b=AcQHCpa+1iUej7YKhdj3FtLVkCS7MzKCzvQHKXV7QFdNFDQJUvDrghQ0
 jNeFEF7VmHl+Oit8ebWerxiSrVEB97tPfolktAeQMVq/aNwkF/o45PYVv
 fnqZUcSNUJmaRA9bym1gpbqD5x5HnuRbINaZ5xyQvuBC+v33WftSDOrrl
 jMU8NWtv4M+cfAtkzK7d77DQzOQlw3T0T5OV0XxkABV/dqTdDI7kJ+0M4
 ShB0Ffa9L1LXK+4GgLN0Gr7RUmUSgYDIaheJCy/4fCWgUiKhz6tS4CnQc
 gXmldBBTcw2ip46MAwhvb1Cv2aJmxEofpwikri2VB1cimcHXUBGwFqLOy g==;
X-CSE-ConnectionGUID: fI5GcQvYRSWq6qijdIbdVg==
X-CSE-MsgGUID: Ga4PP28oTGy9Vs//eYJUew==
X-IronPort-AV: E=Sophos;i="6.25,154,1779148800"; d="scan'208";a="23517402"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
 by internal-pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2026 23:06:32 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.51:10019]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.40.123:2525]
 with esmtp (Farcaster)
 id 99166d13-31b6-41a5-9232-0e26da927882; Sat, 11 Jul 2026 23:06:31 +0000 (UTC)
X-Farcaster-Flow-ID: 99166d13-31b6-41a5-9232-0e26da927882
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 23:06:31 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 23:06:22 +0000
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
Subject: [RFC PATCH 111/134] hw/i386,
 hw/xen: Give allocated IRQs an owner and name
Date: Sat, 11 Jul 2026 22:36:44 +0000
Message-ID: <20260711223707.42139-112-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260711223707.42139-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D039UWB002.ant.amazon.com (10.13.138.79) To
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

Convert the IRQ allocation calls in hw/i386 and the Xen accelerator
to the parented form.  Thread an Object *parent through the small
helpers that had none:

  pc_gsi_create()               -> +Object *parent
  x86_allocate_cpu_irq()        -> +Object *parent
  xen_interrupt_controller_init() -> +Object *parent

Per-site owner/name:

  pc.c pc_gsi_create()          | parent          | "gsi"
  pc.c a20 line                 | parent          | "a20"
  pc_piix.c smi                 | OBJECT(machine) | "smi"
  x86-cpu.c CPU IRQ             | parent          | "pic-cpu-irq"
  microvm.c gsi                 | OBJECT(mms)     | "gsi"
  kvm/i8259.c                   | parent          | "kvm-pic-irq"
  xen-hvm.c                     | parent          | "xen-irq"

Assisted-by: Kiro
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 hw/i386/isapc.c       |  2 +-
 hw/i386/kvm/i8259.c   |  2 +-
 hw/i386/microvm.c     |  4 ++--
 hw/i386/pc.c          | 10 +++++-----
 hw/i386/pc_piix.c     |  5 +++--
 hw/i386/pc_q35.c      |  2 +-
 hw/i386/x86-cpu.c     |  4 ++--
 hw/i386/xen/xen-hvm.c |  4 ++--
 include/hw/i386/pc.h  |  2 +-
 include/hw/i386/x86.h |  2 +-
 include/hw/xen/xen.h  |  2 +-
 stubs/xen-hw-stub.c   |  2 +-
 12 files changed, 21 insertions(+), 20 deletions(-)

diff --git a/hw/i386/isapc.c b/hw/i386/isapc.c
index e8d5767b80..c9f2f14123 100644
--- a/hw/i386/isapc.c
+++ b/hw/i386/isapc.c
@@ -106,7 +106,7 @@ static void pc_init_isa(MachineState *machine)
         }
     }
 
-    gsi_state = pc_gsi_create(&x86ms->gsi, false);
+    gsi_state = pc_gsi_create(OBJECT(machine), &x86ms->gsi, false);
 
     isa_bus = isa_bus_new_bridge(OBJECT(machine), system_memory, system_io,
                           &error_abort);
diff --git a/hw/i386/kvm/i8259.c b/hw/i386/kvm/i8259.c
index 7ef7a0b487..db2847686b 100644
--- a/hw/i386/kvm/i8259.c
+++ b/hw/i386/kvm/i8259.c
@@ -136,7 +136,7 @@ qemu_irq *kvm_i8259_init(Object *parent, ISABus *bus)
     i8259_init_chip(parent, TYPE_KVM_I8259, bus, true);
     i8259_init_chip(parent, TYPE_KVM_I8259, bus, false);
 
-    return qemu_allocate_irqs_orphan(kvm_pic_set_irq, NULL, ISA_NUM_IRQS);
+    return qemu_allocate_irqs(parent, "kvm-pic-irq", kvm_pic_set_irq, NULL, ISA_NUM_IRQS);
 }
 
 static void kvm_i8259_class_init(ObjectClass *klass, const void *data)
diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index 07dbe3a18b..4c1a4d5661 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -168,7 +168,7 @@ static void microvm_devices_init(MicrovmMachineState *mms)
     /* Core components */
     ioapics = microvm_ioapics(mms);
     gsi_state = g_malloc0(sizeof(*gsi_state));
-    x86ms->gsi = qemu_allocate_irqs_orphan(gsi_handler, gsi_state,
+    x86ms->gsi = qemu_allocate_irqs(OBJECT(mms), "gsi", gsi_handler, gsi_state,
                                     IOAPIC_NUM_PINS * ioapics);
 
     isa_bus = isa_bus_new_bridge(OBJECT(mms), get_system_memory(), get_system_io(),
@@ -252,7 +252,7 @@ static void microvm_devices_init(MicrovmMachineState *mms)
     if (x86ms->pic == ON_OFF_AUTO_ON || x86ms->pic == ON_OFF_AUTO_AUTO) {
         qemu_irq *i8259;
 
-        i8259 = i8259_init(OBJECT(mms), isa_bus, x86_allocate_cpu_irq());
+        i8259 = i8259_init(OBJECT(mms), isa_bus, x86_allocate_cpu_irq(OBJECT(mms)));
         for (i = 0; i < ISA_NUM_IRQS; i++) {
             gsi_state->i8259_irq[i] = i8259[i];
         }
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 249fa699c7..398371ff6f 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -192,7 +192,7 @@ const size_t pc_compat_4_1_len = G_N_ELEMENTS(pc_compat_4_1);
  */
 #define PC_FW_DATA (0x20000 + 0x8000)
 
-GSIState *pc_gsi_create(qemu_irq **irqs, bool pci_enabled)
+GSIState *pc_gsi_create(Object *parent, qemu_irq **irqs, bool pci_enabled)
 {
     GSIState *s;
 
@@ -200,7 +200,7 @@ GSIState *pc_gsi_create(qemu_irq **irqs, bool pci_enabled)
     if (kvm_ioapic_in_kernel()) {
         kvm_pc_setup_irq_routing(pci_enabled);
     }
-    *irqs = qemu_allocate_irqs_orphan(gsi_handler, s, IOAPIC_NUM_PINS);
+    *irqs = qemu_allocate_irqs(parent, "gsi", gsi_handler, s, IOAPIC_NUM_PINS);
 
     return s;
 }
@@ -1028,7 +1028,7 @@ static void pc_superio_init(Object *parent, ISABus *isa_bus, bool create_fdctrl,
     }
     port92 = isa_create_simple(parent, "port92", isa_bus, TYPE_PORT92);
 
-    a20_line = qemu_allocate_irqs_orphan(handle_a20_line_change, first_cpu, 2);
+    a20_line = qemu_allocate_irqs(parent, "a20", handle_a20_line_change, first_cpu, 2);
     qdev_connect_gpio_out_named(DEVICE(i8042),
                                 I8042_A20_LINE, 0, a20_line[0]);
     qdev_connect_gpio_out_named(DEVICE(port92),
@@ -1167,9 +1167,9 @@ void pc_i8259_create(Object *parent, ISABus *isa_bus, qemu_irq *i8259_irqs)
     if (kvm_pic_in_kernel()) {
         i8259 = kvm_i8259_init(parent, isa_bus);
     } else if (xen_enabled()) {
-        i8259 = xen_interrupt_controller_init();
+        i8259 = xen_interrupt_controller_init(parent);
     } else {
-        i8259 = i8259_init(parent, isa_bus, x86_allocate_cpu_irq());
+        i8259 = i8259_init(parent, isa_bus, x86_allocate_cpu_irq(parent));
     }
 
     for (size_t i = 0; i < ISA_NUM_IRQS; i++) {
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index f76d684d6b..976c646822 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -233,7 +233,7 @@ static void pc_init1(MachineState *machine, const char *pci_type)
         }
     }
 
-    gsi_state = pc_gsi_create(&x86ms->gsi, true);
+    gsi_state = pc_gsi_create(OBJECT(machine), &x86ms->gsi, true);
 
     pci_dev = pci_new_multifunction(OBJECT(machine), "south-bridge", -1,
                                     pcms->south_bridge);
@@ -299,7 +299,8 @@ static void pc_init1(MachineState *machine, const char *pci_type)
     pc_nic_init(pcmc, isa_bus, pcms->pcibus);
 
     if (piix4_pm) {
-        smi_irq = qemu_allocate_irq_orphan(pc_acpi_smi_interrupt, first_cpu, 0);
+        smi_irq = qemu_allocate_irq(OBJECT(machine), "smi",
+                                    pc_acpi_smi_interrupt, first_cpu, 0);
 
         qdev_connect_gpio_out_named(DEVICE(piix4_pm), "smi-irq", 0, smi_irq);
         pcms->smbus = I2C_BUS(qdev_get_child_bus(DEVICE(piix4_pm), "i2c"));
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index b2cdca8ade..b6a79d2e13 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -233,7 +233,7 @@ static void pc_q35_init(MachineState *machine)
     pcms->pcibus = PCI_BUS(qdev_get_child_bus(DEVICE(phb), "pcie.0"));
 
     /* irq lines */
-    gsi_state = pc_gsi_create(&x86ms->gsi, true);
+    gsi_state = pc_gsi_create(OBJECT(machine), &x86ms->gsi, true);
 
     /* create ISA bus */
     lpc = pci_new_multifunction(OBJECT(machine), "lpc",
diff --git a/hw/i386/x86-cpu.c b/hw/i386/x86-cpu.c
index 6d010291cf..f92acf2778 100644
--- a/hw/i386/x86-cpu.c
+++ b/hw/i386/x86-cpu.c
@@ -61,9 +61,9 @@ static void pic_irq_request(void *opaque, int irq, int level)
     }
 }
 
-qemu_irq x86_allocate_cpu_irq(void)
+qemu_irq x86_allocate_cpu_irq(Object *parent)
 {
-    return qemu_allocate_irq_orphan(pic_irq_request, NULL, 0);
+    return qemu_allocate_irq(parent, "pic-cpu-irq", pic_irq_request, NULL, 0);
 }
 
 int cpu_get_pic_interrupt(CPUX86State *env)
diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index e87c8237ea..e19c9723da 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -112,9 +112,9 @@ static void xen_set_irq(void *opaque, int irq, int level)
     xen_set_isa_irq_level(xen_domid, irq, level);
 }
 
-qemu_irq *xen_interrupt_controller_init(void)
+qemu_irq *xen_interrupt_controller_init(Object *parent)
 {
-    return qemu_allocate_irqs_orphan(xen_set_irq, NULL, 16);
+    return qemu_allocate_irqs(parent, "xen-irq", xen_set_irq, NULL, 16);
 }
 
 /* Memory Ops */
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index a059409243..15e4cca288 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -126,7 +126,7 @@ OBJECT_DECLARE_TYPE(PCMachineState, PCMachineClass, PC_MACHINE)
 
 /* ioapic.c */
 
-GSIState *pc_gsi_create(qemu_irq **irqs, bool pci_enabled);
+GSIState *pc_gsi_create(Object *parent, qemu_irq **irqs, bool pci_enabled);
 
 /* pc.c */
 
diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
index 9d5d7694d4..a21b5d1384 100644
--- a/include/hw/i386/x86.h
+++ b/include/hw/i386/x86.h
@@ -145,7 +145,7 @@ typedef struct GSIState {
     qemu_irq ioapic2_irq[IOAPIC_NUM_PINS];
 } GSIState;
 
-qemu_irq x86_allocate_cpu_irq(void);
+qemu_irq x86_allocate_cpu_irq(Object *parent);
 void gsi_handler(void *opaque, int n, int level);
 void ioapic_init_gsi(GSIState *gsi_state, Object *parent);
 DeviceState *ioapic_init_secondary(Object *parent, GSIState *gsi_state);
diff --git a/include/hw/xen/xen.h b/include/hw/xen/xen.h
index e94c6e5a31..83b7f6c3aa 100644
--- a/include/hw/xen/xen.h
+++ b/include/hw/xen/xen.h
@@ -42,7 +42,7 @@ void xen_intx_set_irq(void *opaque, int irq_num, int level);
 void xen_hvm_inject_msi(uint64_t addr, uint32_t data);
 int xen_is_pirq_msi(uint32_t msi_data);
 
-qemu_irq *xen_interrupt_controller_init(void);
+qemu_irq *xen_interrupt_controller_init(Object *parent);
 
 void xen_register_framebuffer(struct MemoryRegion *mr);
 
diff --git a/stubs/xen-hw-stub.c b/stubs/xen-hw-stub.c
index 6cf0e9a4c1..4ea666cac8 100644
--- a/stubs/xen-hw-stub.c
+++ b/stubs/xen-hw-stub.c
@@ -29,7 +29,7 @@ int xen_is_pirq_msi(uint32_t msi_data)
     return 0;
 }
 
-qemu_irq *xen_interrupt_controller_init(void)
+qemu_irq *xen_interrupt_controller_init(Object *parent)
 {
     return NULL;
 }
-- 
2.47.1


