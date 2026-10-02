Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FC72CA5FDD
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 21:51:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCl97-0001KI-ML; Fri, 02 Oct 2026 17:50:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xCl95-0001JM-Ah
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 17:50:23 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xCl93-0006Rh-FS
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 17:50:23 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9975943D17;
 Fri,  2 Oct 2026 21:50:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 610C41F00893;
 Fri,  2 Oct 2026 21:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790977819;
 bh=NkT44wOH/Bm8CQMq/WHe4RMkOg0p5p+CGjBUunZw5QY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=j+44RCpx/xWyibFfw1s0bhqDREFSx9v3lXeyg61ca5dWBsH7PVDBhNWESAU3aMcKd
 jiwIgu3aF2vjBp+TfwD9soIICVKbG/ONZosZI49qMxAU0q/bnP1pMmR14L3jvOuK8F
 wIvOTg5W+f7TSLmZSqOXNczImCw9ni5YnYpJJgqmwqvQckDMHc9NEaSHwLMQfreCwc
 hCMyiZytTff22skrszGsZLJ8HCW+HuXMfdn2gEyePLY47rHNzStE47cCNOnDZFPhVA
 N5hIs0pcYMNabB9GJ0yipruBM2yhRE2FNDpYyYzoBSvlLZHtB0hI/S4wrLErc+GOYL
 1mlSFWcKbT5AQ==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Craig Lalley <mr_lalley@yahoo.com>, Helge Deller <deller@gmx.de>
Subject: [PULL 1/4] hw/hppa: Rotate Elroy PCI interrupts by pin on the A400
Date: Fri,  2 Oct 2026 23:50:11 +0200
Message-ID: <20261002215014.45371-2-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261002215014.45371-1-deller@kernel.org>
References: <20261002215014.45371-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=deller@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.336,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Craig Lalley <mr_lalley@yahoo.com>

elroy_pci_map_irq() routes all four interrupt pins of a PCI slot to the
same IOSAPIC input, so on a multi-function device all functions share
one line.

Add an Astro property "rotate-pci-pins" and set it for the A400: INTA
of slot n then goes to IOSAPIC input n, INTB to n+1, and so on (modulo
ELROY_IRQS).  The C3700 is unchanged.

The firmware describes the routing to the OS in the interrupt routing
table, so this needs the matching SeaBIOS-hppa change "parisc: Rotate
IRT interrupt lines by PCI pin on the A400".  With only one side
applied, functions using INTB..INTD on an A400 are described with an
IOSAPIC input which never fires.

Signed-off-by: Craig Lalley <mr_lalley@yahoo.com>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/hppa/machine.c           | 10 ++++++----
 hw/pci-host/astro.c         |  6 ++++++
 include/hw/pci-host/astro.h |  1 +
 3 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 96133f09ba..df25877cb1 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -730,7 +730,7 @@ static void machine_HP_B160L_init(MachineState *machine)
     machine_HP_common_init_tail(machine, pci_bus, translate, false);
 }
 
-static AstroState *astro_init(void)
+static AstroState *astro_init(bool is_a400)
 {
     DeviceState *dev;
 
@@ -738,6 +738,8 @@ static AstroState *astro_init(void)
     object_property_set_int(OBJECT(dev), "phys-addr-bits",
                             hppa_phys_addr_bits(&cpu[0]->env),
                             &error_abort);
+    object_property_set_bool(OBJECT(dev), "rotate-pci-pins", is_a400,
+                             &error_abort);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
     return ASTRO_CHIP(dev);
@@ -753,6 +755,8 @@ static void machine_HP_C3700_init(MachineState *machine)
     DeviceState *astro_dev;
     MemoryRegion *addr_space = get_system_memory();
     TranslateFn *translate;
+    MachineClass *mc = MACHINE_GET_CLASS(machine);
+    bool is_C3700 = strcmp(mc->name, "C3700") == 0;
 
     /* Create CPUs and RAM.  */
     translate = machine_HP_common_init_cpus(machine);
@@ -764,7 +768,7 @@ static void machine_HP_C3700_init(MachineState *machine)
     }
 
     /* Init Astro and the Elroys (PCI host bus chips).  */
-    astro = astro_init();
+    astro = astro_init(!is_C3700);
     astro_dev = DEVICE(astro);
     memory_region_add_subregion(addr_space, translate(NULL, ASTRO_HPA),
                                 sysbus_mmio_get_region(
@@ -773,8 +777,6 @@ static void machine_HP_C3700_init(MachineState *machine)
     assert(pci_bus);
 
     /* The C3700 has a SuperIO chip, while the A400 hasn't. */
-    MachineClass *mc = MACHINE_GET_CLASS(machine);
-    bool is_C3700 = strcmp(mc->name, "C3700") == 0;
     if (is_C3700)  {
         PCIDevice *ide_pdev = pci_create_simple(pci_bus, PCI_DEVFN(2, 0),
                                                 "pc87560-ide");
diff --git a/hw/pci-host/astro.c b/hw/pci-host/astro.c
index fc07608da7..c024dab858 100644
--- a/hw/pci-host/astro.c
+++ b/hw/pci-host/astro.c
@@ -406,9 +406,14 @@ static void elroy_set_irq(void *opaque, int irq, int level)
 
 static int elroy_pci_map_irq(PCIDevice *d, int irq_num)
 {
+    ElroyState *s = pci_get_bus(d)->irq_opaque;
     int slot = PCI_SLOT(d->devfn);
 
     assert(irq_num >= 0 && irq_num < ELROY_IRQS);
+    /* INTB..INTD of a slot may be rotated to the following inputs */
+    if (s->astro && s->astro->rotate_pci_pins) {
+        return (slot + irq_num) & (ELROY_IRQS - 1);
+    }
     return slot & (ELROY_IRQS - 1);
 }
 
@@ -1064,6 +1069,7 @@ static void astro_realize(DeviceState *obj, Error **errp)
 
 static const Property astro_props[] = {
     DEFINE_PROP_UINT8("phys-addr-bits", AstroState, phys_addr_bits, 32),
+    DEFINE_PROP_BOOL("rotate-pci-pins", AstroState, rotate_pci_pins, false),
 };
 
 static void astro_class_init(ObjectClass *klass, const void *data)
diff --git a/include/hw/pci-host/astro.h b/include/hw/pci-host/astro.h
index 0cd384bceb..3297cd2e62 100644
--- a/include/hw/pci-host/astro.h
+++ b/include/hw/pci-host/astro.h
@@ -84,6 +84,7 @@ struct AstroState {
     uint64_t tlb_pdir_base;
 
     uint8_t phys_addr_bits;
+    bool rotate_pci_pins;       /* PCI INTx pin rotation (A400) */
 
     struct ElroyState *elroy[ELROY_NUM];
 
-- 
2.54.0


