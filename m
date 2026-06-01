Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89E1ACD6E56
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 02:33:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTsRr-0007M2-3B; Sun, 31 May 2026 22:32:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven_lee@aspeedtech.com>)
 id 1wTsRp-0007LI-HB; Sun, 31 May 2026 22:32:13 -0400
Received: from mail.aspeedtech.com ([211.20.114.72]
 helo=twmbx01.aspeedtech.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven_lee@aspeedtech.com>)
 id 1wTsRn-0004V7-NN; Sun, 31 May 2026 22:32:13 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 1 Jun
 2026 10:31:51 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 1 Jun 2026 10:31:51 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Troy Lee <leetroy@gmail.com>, Jamin Lin
 <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, "Andrew
 Jeffery" <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, Fabiano Rosas
 <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: <troy_lee@aspeedtech.com>, <longzl2@lenovo.com>,
 <yunlin.tang@aspeedtech.com>, <steven_lee@aspeedtech.com>
Subject: [PATCH 4/6] hw/arm/aspeed_ast1040: Wire Caliptra mailbox
Date: Mon, 1 Jun 2026 10:31:45 +0800
Message-ID: <20260601023149.2309299-5-steven_lee@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260601023149.2309299-1-steven_lee@aspeedtech.com>
References: <20260601023149.2309299-1-steven_lee@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=steven_lee@aspeedtech.com; helo=twmbx01.aspeedtech.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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
Reply-to:  Steven Lee <steven_lee@aspeedtech.com>
From:  Steven Lee via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Instantiate the Caliptra mailbox in the AST1040 SoC and map its SRAM and CSR windows at the guest-visible MCI addresses.

Add the 4 KiB MCI aperture controlled by the AST1040 SCU CPTRA page register, switch the SoC to the AST1040 SCU model, and expose a machine option that links an external mailbox peer after machine initialization.

Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>
---
 include/hw/arm/aspeed_soc.h | 11 ++++++
 hw/arm/aspeed_ast1040.c     | 60 ++++++++++++++++++++++++++++--
 hw/arm/aspeed_ast1040_evb.c | 74 ++++++++++++++++++++++++++++++++++++-
 3 files changed, 140 insertions(+), 5 deletions(-)

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index 3aac144cd4..9fad3bc082 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -46,6 +46,7 @@
 #include "hw/intc/arm_gicv3.h"
 #include "hw/misc/aspeed_ltpi.h"
 #include "hw/arm/aspeed_ast1700.h"
+#include "hw/misc/aspeed_cptra_mbox.h"
 
 #define VBOOTROM_FILE_NAME  "ast27x0_bootrom.bin"
 
@@ -165,6 +166,16 @@ struct Aspeed10x0SoCState {
 #define TYPE_ASPEED10X0_SOC "aspeed10x0-soc"
 OBJECT_DECLARE_SIMPLE_TYPE(Aspeed10x0SoCState, ASPEED10X0_SOC)
 
+struct Aspeed1040SoCState {
+    Aspeed10x0SoCState parent;
+
+    AspeedCptraMboxState cptra_mbox;
+    MemoryRegion cptra_mci_window;
+};
+
+#define TYPE_ASPEED1040_SOC "ast1040-a0"
+OBJECT_DECLARE_SIMPLE_TYPE(Aspeed1040SoCState, ASPEED1040_SOC)
+
 struct AspeedSoCClass {
     DeviceClass parent_class;
 
diff --git a/hw/arm/aspeed_ast1040.c b/hw/arm/aspeed_ast1040.c
index 8efcdad8f6..c597982bc5 100644
--- a/hw/arm/aspeed_ast1040.c
+++ b/hw/arm/aspeed_ast1040.c
@@ -8,12 +8,17 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "system/address-spaces.h"
 #include "system/system.h"
 #include "hw/core/qdev-clock.h"
 #include "hw/misc/unimp.h"
+#include "hw/misc/aspeed_cptra_mbox.h"
 #include "hw/arm/aspeed_soc.h"
 
+#define AST1040_CPTRA_MCI_WINDOW_BASE 0x74200000
+#define AST1040_CPTRA_MCI_WINDOW_SIZE 0x1000
+#define AST1040_CPTRA_MBOX_SRAM_BASE  0x21400000
+#define AST1040_CPTRA_MBOX_CSR_BASE   0x21600000
+
 static const hwaddr aspeed_soc_ast1040_memmap[] = {
     [ASPEED_DEV_SRAM1]     = 0x00000000, /* Hyper RAM */
     [ASPEED_DEV_FMC]       = 0x74000000,
@@ -88,6 +93,7 @@ static qemu_irq aspeed_soc_ast1040_get_irq(AspeedSoCState *s, int dev)
 
 static void aspeed_soc_ast1040_init(Object *obj)
 {
+    Aspeed1040SoCState *a1040 = ASPEED1040_SOC(obj);
     Aspeed10x0SoCState *a = ASPEED10X0_SOC(obj);
     AspeedSoCState *s = ASPEED_SOC(obj);
     AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
@@ -96,12 +102,13 @@ static void aspeed_soc_ast1040_init(Object *obj)
 
     s->sysclk = qdev_init_clock_in(DEVICE(s), "sysclk", NULL, NULL, 0);
 
-    /* AST1040 uses the AST2700 SCUIO model */
-    object_initialize_child(obj, "scu", &s->scu, TYPE_ASPEED_2700_SCUIO);
+    object_initialize_child(obj, "scu", &s->scu, TYPE_ASPEED_1040_SCU);
     qdev_prop_set_uint32(DEVICE(&s->scu), "silicon-rev", sc->silicon_rev);
 
     object_property_add_alias(obj, "hw-strap1", OBJECT(&s->scu), "hw-strap1");
     object_property_add_alias(obj, "hw-strap2", OBJECT(&s->scu), "hw-strap2");
+    object_initialize_child(obj, "cptra-mbox", &a1040->cptra_mbox,
+                            TYPE_ASPEED_CPTRA_MBOX);
 
     for (i = 0; i < sc->uarts_num; i++) {
         object_initialize_child(obj, "uart[*]", &s->uart[i], TYPE_SERIAL_MM);
@@ -120,8 +127,31 @@ static void aspeed_soc_ast1040_init(Object *obj)
                             TYPE_UNIMPLEMENTED_DEVICE);
 }
 
+static bool aspeed_soc_ast1040_realize_cptra_mbox(Aspeed1040SoCState *a1040,
+                                                  Error **errp)
+{
+    AspeedSoCState *s = ASPEED_SOC(a1040);
+    DeviceState *mbox = DEVICE(&a1040->cptra_mbox);
+
+    /*
+     * Caliptra is an AST1040 integrated RoT IP. The external peer is
+     * optional; without a peer, the mailbox registers remain present and
+     * EXECUTE completes with CMD_FAILURE.
+     */
+    if (!sysbus_realize(SYS_BUS_DEVICE(mbox), errp)) {
+        return false;
+    }
+
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(mbox), 0,
+                    AST1040_CPTRA_MBOX_SRAM_BASE);
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(mbox), 1,
+                    AST1040_CPTRA_MBOX_CSR_BASE);
+    return true;
+}
+
 static void aspeed_soc_ast1040_realize(DeviceState *dev_soc, Error **errp)
 {
+    Aspeed1040SoCState *a1040 = ASPEED1040_SOC(dev_soc);
     Aspeed10x0SoCState *a = ASPEED10X0_SOC(dev_soc);
     AspeedSoCState *s = ASPEED_SOC(dev_soc);
     AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
@@ -171,6 +201,27 @@ static void aspeed_soc_ast1040_realize(DeviceState *dev_soc, Error **errp)
     memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_SRAM1],
                                 &s->sram[1]);
 
+    if (!aspeed_soc_ast1040_realize_cptra_mbox(a1040, errp)) {
+        return;
+    }
+
+    /*
+     * The Caliptra MCI aperture is a 4 KiB alias whose target is selected by
+     * AST1040_SCU_CPTRA_PAGE_REG0. Firmware commonly switches it between
+     * mailbox SRAM (0x21400000) and mailbox CSR (0x21600000), then accesses
+     * the selected page through 0x74200000.
+     */
+    memory_region_init_alias(&a1040->cptra_mci_window, OBJECT(s),
+                             "aspeed.ast1040.cptra-mci-window", s->memory,
+                             0, AST1040_CPTRA_MCI_WINDOW_SIZE);
+    memory_region_add_subregion(s->memory, AST1040_CPTRA_MCI_WINDOW_BASE,
+                                &a1040->cptra_mci_window);
+    /* The SCU drives the aperture's target offset via SCU_CPTRA_PAGE_REG0. */
+    object_property_set_link(OBJECT(&s->scu), "cptra-page-window",
+                             OBJECT(&a1040->cptra_mci_window), &error_abort);
+    object_property_set_uint(OBJECT(&s->scu), "cptra-page-window-base",
+                             AST1040_CPTRA_MCI_WINDOW_BASE, &error_abort);
+
     /* SCU */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->scu), errp)) {
         return;
@@ -244,8 +295,9 @@ static void aspeed_soc_ast1040_class_init(ObjectClass *klass, const void *data)
 
 static const TypeInfo aspeed_soc_ast1040_types[] = {
     {
-        .name           = "ast1040-a0",
+        .name           = TYPE_ASPEED1040_SOC,
         .parent         = TYPE_ASPEED10X0_SOC,
+        .instance_size  = sizeof(Aspeed1040SoCState),
         .instance_init  = aspeed_soc_ast1040_init,
         .class_init     = aspeed_soc_ast1040_class_init,
     }
diff --git a/hw/arm/aspeed_ast1040_evb.c b/hw/arm/aspeed_ast1040_evb.c
index 1d9b55247f..eb325a1095 100644
--- a/hw/arm/aspeed_ast1040_evb.c
+++ b/hw/arm/aspeed_ast1040_evb.c
@@ -8,17 +8,59 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qemu/error-report.h"
 #include "hw/arm/boot.h"
 #include "hw/arm/machines-qom.h"
 #include "hw/arm/aspeed.h"
 #include "hw/arm/aspeed_soc.h"
 #include "hw/core/qdev-clock.h"
+#include "hw/misc/aspeed_cptra_mbox.h"
 #include "system/system.h"
 
 #define AST1040_INTERNAL_FLASH_SIZE (4 * MiB)
 /* Main SYSCLK frequency in Hz (400MHz) */
 #define SYSCLK_FRQ 400000000ULL
 
+#define TYPE_AST1040_EVB_MACHINE MACHINE_TYPE_NAME("ast1040-evb")
+OBJECT_DECLARE_SIMPLE_TYPE(Ast1040EvbMachineState, AST1040_EVB_MACHINE)
+
+struct Ast1040EvbMachineState {
+    AspeedMachineState parent_obj;
+
+    char *cptra_peer;
+    Notifier machine_done;
+};
+
+static void aspeed_bic_machine_done(Notifier *notifier, void *data)
+{
+    Ast1040EvbMachineState *m = container_of(notifier,
+                                             Ast1040EvbMachineState,
+                                             machine_done);
+    AspeedMachineState *bmc = ASPEED_MACHINE(m);
+    Aspeed1040SoCState *a1040 = ASPEED1040_SOC(bmc->soc);
+    bool ambiguous = false;
+    Object *peer;
+    Error *err = NULL;
+
+    if (!m->cptra_peer) {
+        return;
+    }
+
+    peer = object_resolve_path_type(m->cptra_peer, TYPE_CPTRA_MBOX_PEER,
+                                    &ambiguous);
+    if (!peer || ambiguous) {
+        error_report("cptra-peer: peer '%s' not found%s",
+                     m->cptra_peer, ambiguous ? " (ambiguous)" : "");
+        exit(1);
+    }
+
+    if (!aspeed_cptra_mbox_set_peer(&a1040->cptra_mbox,
+                                    CPTRA_MBOX_PEER(peer), &err)) {
+        error_report_err(err);
+        exit(1);
+    }
+}
+
 static void aspeed_bic_machine_init(MachineState *machine)
 {
     AspeedMachineState *bmc = ASPEED_MACHINE(machine);
@@ -38,12 +80,35 @@ static void aspeed_bic_machine_init(MachineState *machine)
     aspeed_connect_serial_hds_to_uarts(bmc);
     qdev_realize(DEVICE(bmc->soc), NULL, &error_abort);
 
+    if (AST1040_EVB_MACHINE(machine)->cptra_peer) {
+        AST1040_EVB_MACHINE(machine)->machine_done.notify =
+            aspeed_bic_machine_done;
+        qemu_add_machine_init_done_notifier(
+            &AST1040_EVB_MACHINE(machine)->machine_done);
+    }
+
     armv7m_load_kernel(ARM_CPU(first_cpu),
                        machine->kernel_filename,
                        0,
                        AST1040_INTERNAL_FLASH_SIZE);
 }
 
+static char *aspeed_bic_get_cptra_peer(Object *obj, Error **errp)
+{
+    Ast1040EvbMachineState *m = AST1040_EVB_MACHINE(obj);
+
+    return g_strdup(m->cptra_peer);
+}
+
+static void aspeed_bic_set_cptra_peer(Object *obj, const char *value,
+                                      Error **errp)
+{
+    Ast1040EvbMachineState *m = AST1040_EVB_MACHINE(obj);
+
+    g_free(m->cptra_peer);
+    m->cptra_peer = g_strdup(value);
+}
+
 static void aspeed_machine_ast1040_evb_class_init(ObjectClass *oc,
                                                   const void *data)
 {
@@ -59,12 +124,19 @@ static void aspeed_machine_ast1040_evb_class_init(ObjectClass *oc,
     amc->macs_mask = 0;
     amc->uart_default = ASPEED_DEV_UART12;
     aspeed_machine_class_init_cpus_defaults(mc);
+
+    object_class_property_add_str(oc, "cptra-peer",
+                                  aspeed_bic_get_cptra_peer,
+                                  aspeed_bic_set_cptra_peer);
+    object_class_property_set_description(oc, "cptra-peer",
+        "Caliptra mailbox peer object id");
 }
 
 static const TypeInfo aspeed_ast1040_evb_types[] = {
     {
-        .name           = MACHINE_TYPE_NAME("ast1040-evb"),
+        .name           = TYPE_AST1040_EVB_MACHINE,
         .parent         = TYPE_ASPEED_MACHINE,
+        .instance_size  = sizeof(Ast1040EvbMachineState),
         .class_init     = aspeed_machine_ast1040_evb_class_init,
         .interfaces     = arm_machine_interfaces,
     }
-- 
2.43.0


