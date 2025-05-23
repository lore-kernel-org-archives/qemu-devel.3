Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1F4DC54ED1
	for <qemu-devel@archiver.kernel.org>; Fri, 23 May 2025 15:02:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uITuc-0006TJ-Dm; Fri, 23 May 2025 11:02:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uITua-0006Sc-V0; Fri, 23 May 2025 11:02:16 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uITuY-0003Az-RS; Fri, 23 May 2025 11:02:16 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 1C3F855C1B9;
 Fri, 23 May 2025 17:02:13 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id 13fdVsjNdQeh; Fri, 23 May 2025 17:02:11 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 2479A55BC03; Fri, 23 May 2025 17:02:11 +0200 (CEST)
Message-ID: <431166f96ff12ff3dbc670d40544974415f11305.1748012109.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1748012109.git.balaton@eik.bme.hu>
References: <cover.1748012109.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 1/3] hw/ppc/e500: Move clock and TB frequency to machine class
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>, Nicholas Piggin <npiggin@gmail.com>
Date: Fri, 23 May 2025 17:02:11 +0200 (CEST)
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

Different machines have different frequencies so make this
configurable in machine class instead of using a hard coded constant.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/ppc/e500.c      | 18 +++++++++---------
 hw/ppc/e500.h      |  4 ++++
 hw/ppc/e500plat.c  |  2 ++
 hw/ppc/mpc8544ds.c |  2 ++
 4 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 809078a2c3..dedd96b057 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -79,8 +79,6 @@
 #define MPC85XX_ESDHC_IRQ          72
 #define RTC_REGS_OFFSET            0x68
 
-#define PLATFORM_CLK_FREQ_HZ       (400 * 1000 * 1000)
-
 struct boot_info
 {
     uint32_t dt_base;
@@ -120,7 +118,7 @@ static uint32_t *pci_map_create(void *fdt, uint32_t mpic, int first_slot,
 }
 
 static void dt_serial_create(void *fdt, unsigned long long offset,
-                             const char *soc, const char *mpic,
+                             const char *soc, uint32_t freq, const char *mpic,
                              const char *alias, int idx, bool defcon)
 {
     char *ser;
@@ -131,7 +129,7 @@ static void dt_serial_create(void *fdt, unsigned long long offset,
     qemu_fdt_setprop_string(fdt, ser, "compatible", "ns16550");
     qemu_fdt_setprop_cells(fdt, ser, "reg", offset, 0x100);
     qemu_fdt_setprop_cell(fdt, ser, "cell-index", idx);
-    qemu_fdt_setprop_cell(fdt, ser, "clock-frequency", PLATFORM_CLK_FREQ_HZ);
+    qemu_fdt_setprop_cell(fdt, ser, "clock-frequency", freq);
     qemu_fdt_setprop_cells(fdt, ser, "interrupts", 42, 2);
     qemu_fdt_setprop_phandle(fdt, ser, "interrupt-parent", mpic);
     qemu_fdt_setprop_string(fdt, "/aliases", alias, ser);
@@ -382,8 +380,7 @@ static int ppce500_load_device_tree(PPCE500MachineState *pms,
     int fdt_size;
     void *fdt;
     uint8_t hypercall[16];
-    uint32_t clock_freq = PLATFORM_CLK_FREQ_HZ;
-    uint32_t tb_freq = PLATFORM_CLK_FREQ_HZ;
+    uint32_t clock_freq, tb_freq;
     int i;
     char compatible_sb[] = "fsl,mpc8544-immr\0simple-bus";
     char *soc;
@@ -484,6 +481,9 @@ static int ppce500_load_device_tree(PPCE500MachineState *pms,
         if (kvmppc_get_hasidle(env)) {
             qemu_fdt_setprop(fdt, "/hypervisor", "has-idle", NULL, 0);
         }
+    } else {
+        clock_freq = pmc->clock_freq;
+        tb_freq = pmc->tb_freq;
     }
 
     /* Create CPU nodes */
@@ -564,12 +564,12 @@ static int ppce500_load_device_tree(PPCE500MachineState *pms,
      */
     if (serial_hd(1)) {
         dt_serial_create(fdt, MPC8544_SERIAL1_REGS_OFFSET,
-                         soc, mpic, "serial1", 1, false);
+                         soc, pmc->clock_freq, mpic, "serial1", 1, false);
     }
 
     if (serial_hd(0)) {
         dt_serial_create(fdt, MPC8544_SERIAL0_REGS_OFFSET,
-                         soc, mpic, "serial0", 0, true);
+                         soc, pmc->clock_freq, mpic, "serial0", 0, true);
     }
 
     /* i2c */
@@ -968,7 +968,7 @@ void ppce500_init(MachineState *machine)
         env->spr_cb[SPR_BOOKE_PIR].default_value = cs->cpu_index = i;
         env->mpic_iack = pmc->ccsrbar_base + MPC8544_MPIC_REGS_OFFSET + 0xa0;
 
-        ppc_booke_timers_init(cpu, PLATFORM_CLK_FREQ_HZ, PPC_TIMER_E500);
+        ppc_booke_timers_init(cpu, pmc->tb_freq, PPC_TIMER_E500);
 
         /* Register reset handler */
         if (!i) {
diff --git a/hw/ppc/e500.h b/hw/ppc/e500.h
index 01db102625..00f490519c 100644
--- a/hw/ppc/e500.h
+++ b/hw/ppc/e500.h
@@ -5,6 +5,8 @@
 #include "hw/platform-bus.h"
 #include "qom/object.h"
 
+#define PLATFORM_CLK_FREQ_HZ (400 * 1000 * 1000)
+
 struct PPCE500MachineState {
     /*< private >*/
     MachineState parent_obj;
@@ -37,6 +39,8 @@ struct PPCE500MachineClass {
     hwaddr pci_mmio_base;
     hwaddr pci_mmio_bus_base;
     hwaddr spin_base;
+    uint32_t clock_freq;
+    uint32_t tb_freq;
 };
 
 void ppce500_init(MachineState *machine);
diff --git a/hw/ppc/e500plat.c b/hw/ppc/e500plat.c
index 775b9d8da0..4f1d659e72 100644
--- a/hw/ppc/e500plat.c
+++ b/hw/ppc/e500plat.c
@@ -93,6 +93,8 @@ static void e500plat_machine_class_init(ObjectClass *oc, const void *data)
     pmc->pci_mmio_base = 0xC00000000ULL;
     pmc->pci_mmio_bus_base = 0xE0000000ULL;
     pmc->spin_base = 0xFEF000000ULL;
+    pmc->clock_freq = PLATFORM_CLK_FREQ_HZ;
+    pmc->tb_freq = PLATFORM_CLK_FREQ_HZ;
 
     mc->desc = "generic paravirt e500 platform";
     mc->init = e500plat_init;
diff --git a/hw/ppc/mpc8544ds.c b/hw/ppc/mpc8544ds.c
index 97fb0f35ba..582698559d 100644
--- a/hw/ppc/mpc8544ds.c
+++ b/hw/ppc/mpc8544ds.c
@@ -55,6 +55,8 @@ static void mpc8544ds_machine_class_init(ObjectClass *oc, const void *data)
     pmc->pci_mmio_bus_base = 0xC0000000ULL;
     pmc->pci_pio_base = 0xE1000000ULL;
     pmc->spin_base = 0xEF000000ULL;
+    pmc->clock_freq = PLATFORM_CLK_FREQ_HZ;
+    pmc->tb_freq = PLATFORM_CLK_FREQ_HZ;
 
     mc->desc = "mpc8544ds";
     mc->init = mpc8544ds_init;
-- 
2.41.3


