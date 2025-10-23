Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07D9FCCD1BE
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 00:07:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBiqs-0007p9-0J; Wed, 22 Oct 2025 20:06:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vBiqY-0007g7-U3; Wed, 22 Oct 2025 20:06:27 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vBiqT-0004Zz-7R; Wed, 22 Oct 2025 20:06:26 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 5B9E75972F1;
 Thu, 23 Oct 2025 02:06:19 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id UI87-wBVk5UI; Thu, 23 Oct 2025 02:06:17 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 60E825972E3; Thu, 23 Oct 2025 02:06:17 +0200 (CEST)
Message-ID: <b69e21e353b7d7f22a34db5f13443f60f51c7238.1761176219.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1761176219.git.balaton@eik.bme.hu>
References: <cover.1761176219.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v4 10/12] hw/ppc/pegasos2: Add bus frequency to machine state
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Date: Thu, 23 Oct 2025 02:06:17 +0200 (CEST)
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Store the bus frequency in the machine state and set it from instance
init method.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/ppc/pegasos2.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/hw/ppc/pegasos2.c b/hw/ppc/pegasos2.c
index f5b56c0e94..7eaefcf9a0 100644
--- a/hw/ppc/pegasos2.c
+++ b/hw/ppc/pegasos2.c
@@ -55,8 +55,6 @@
 #define H_PRIVILEGE  -3  /* Caller not privileged */
 #define H_PARAMETER  -4  /* Parameter invalid, out-of-range or conflicting */
 
-#define BUS_FREQ_HZ 133333333
-
 #define TYPE_PEGASOS_MACHINE MACHINE_TYPE_NAME("pegasos")
 OBJECT_DECLARE_SIMPLE_TYPE(PegasosMachineState, PEGASOS_MACHINE)
 
@@ -66,6 +64,7 @@ struct PegasosMachineState {
     PowerPCCPU *cpu;
     DeviceState *nb; /* north bridge */
     DeviceState *sb; /* south bridge */
+    int bus_freq_hz;
     IRQState pci_irqs[PCI_NUM_PINS];
     OrIRQState orirq[PCI_NUM_PINS];
     qemu_irq mv_pirq[PCI_NUM_PINS];
@@ -135,7 +134,7 @@ static void pegasos2_setup_pci_irq(PegasosMachineState *pm)
                                 qdev_get_gpio_in_named(pm->nb, "gpp", 31));
 }
 
-static void pegasos2_init(MachineState *machine)
+static void pegasos_init(MachineState *machine)
 {
     PegasosMachineState *pm = PEGASOS_MACHINE(machine);
     CPUPPCState *env;
@@ -158,7 +157,7 @@ static void pegasos2_init(MachineState *machine)
     }
 
     /* Set time-base frequency */
-    cpu_ppc_tb_init(env, BUS_FREQ_HZ / 4);
+    cpu_ppc_tb_init(env, pm->bus_freq_hz / 4);
     qemu_register_reset(pegasos2_cpu_reset, pm->cpu);
 
     /* RAM */
@@ -610,7 +609,7 @@ static void pegasos2_machine_class_init(ObjectClass *oc, const void *data)
     VofMachineIfClass *vmc = VOF_MACHINE_CLASS(oc);
 
     mc->desc = "Genesi/bPlan Pegasos II";
-    mc->init = pegasos2_init;
+    mc->init = pegasos_init;
     mc->reset = pegasos2_machine_reset;
     mc->block_default_type = IF_IDE;
     mc->default_boot_order = "cd";
@@ -629,6 +628,13 @@ static void pegasos2_machine_class_init(ObjectClass *oc, const void *data)
     vmc->setprop = pegasos2_setprop;
 }
 
+static void pegasos2_init(Object *obj)
+{
+    PegasosMachineState *pm = PEGASOS_MACHINE(obj);
+
+    pm->bus_freq_hz = 133333333;
+}
+
 static const TypeInfo pegasos_machine_types[] = {
     {
         .name          = TYPE_PEGASOS_MACHINE,
@@ -645,6 +651,7 @@ static const TypeInfo pegasos_machine_types[] = {
         .name          = MACHINE_TYPE_NAME("pegasos2"),
         .parent        = TYPE_PEGASOS_MACHINE,
         .class_init    = pegasos2_machine_class_init,
+        .instance_init = pegasos2_init,
     },
 };
 
@@ -777,7 +784,7 @@ static void add_pci_device(PCIBus *bus, PCIDevice *d, void *opaque)
     g_string_free(node, TRUE);
 }
 
-static void add_cpu_info(void *fdt, PowerPCCPU *cpu)
+static void add_cpu_info(void *fdt, PowerPCCPU *cpu, int bus_freq)
 {
     uint32_t cells[2];
 
@@ -824,8 +831,8 @@ static void add_cpu_info(void *fdt, PowerPCCPU *cpu)
     qemu_fdt_setprop_cell(fdt, cp, "reservation-granule-size", 4);
     qemu_fdt_setprop_cell(fdt, cp, "timebase-frequency",
                           cpu->env.tb_env->tb_freq);
-    qemu_fdt_setprop_cell(fdt, cp, "bus-frequency", BUS_FREQ_HZ);
-    qemu_fdt_setprop_cell(fdt, cp, "clock-frequency", BUS_FREQ_HZ * 7.5);
+    qemu_fdt_setprop_cell(fdt, cp, "bus-frequency", bus_freq);
+    qemu_fdt_setprop_cell(fdt, cp, "clock-frequency", bus_freq * 7.5);
     qemu_fdt_setprop_cell(fdt, cp, "cpu-version", cpu->env.spr[SPR_PVR]);
     cells[0] = 0;
     cells[1] = 0;
@@ -860,7 +867,7 @@ static void *pegasos2_build_fdt(PegasosMachineState *pm, int *fdt_size)
     }
     qemu_fdt_setprop_string(fdt, "/", "name", "bplan,Pegasos2");
 
-    add_cpu_info(fdt, pm->cpu);
+    add_cpu_info(fdt, pm->cpu, pm->bus_freq_hz);
 
     fi.fdt = fdt;
     fi.path = "/pci@c0000000";
-- 
2.41.3


