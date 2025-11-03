Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6CCFCCFA06
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 13:22:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFuUS-0004I5-9m; Mon, 03 Nov 2025 08:20:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vFuUP-0004Gy-F1
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 08:20:53 -0500
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vFuUE-0001Qw-78
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 08:20:53 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id AD78D437E4;
 Mon,  3 Nov 2025 13:20:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50946C113D0;
 Mon,  3 Nov 2025 13:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1762176034;
 bh=5Re0U0XtnMK1OnF1RE48DGzPOaGJ227PY7sND6BN3mA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=bPTb2RWkxKJLapjvLrH/px5C11YlLLp1ZFveZUDcr379R6U91QtttlbC7MI34iK0h
 oDDAy5Egdf9OA2AP97qKJKliCRr9JrgAaJv4b0wZbN5NhjzZr+0rRQJSd5R7Cd49+U
 8d5oPd7G3eami7uML4lCIeEFZSMBwkrbP30UBi0/0sQATclZtskvb5Ueiw/Ni9AP+2
 nOlxsspMts9zh329ny1YH5LK4H+unpFATue0lzPydrO+5+QphoBpPSGzOoVXC8HKty
 qoitObFwrWXemkuEC26h1TtTEPqv530DY4z9K0MuCM74mpt+IQ1GUfYdbw/R+Qckwi
 RPzqpwQrazt+g==
From: deller@kernel.org
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Helge Deller <deller@gmx.de>
Subject: [PULL 1/3] hw/hppa: Enable LASI i82596 network on 715 machine
Date: Mon,  3 Nov 2025 14:20:27 +0100
Message-ID: <20251103132029.6725-2-deller@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251103132029.6725-1-deller@kernel.org>
References: <20251103132029.6725-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=deller@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Helge Deller <deller@gmx.de>

Enable the i82596 network chip which is included in the LASI
multi I/O chip. Since LASI has different start addresses on
the various machines, always initialize the LASI components
by their offsets.

Tested-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/hppa/hppa_hardware.h     | 10 ++--------
 hw/hppa/machine.c           | 31 +++++++++++++++++--------------
 hw/net/lasi_i82596.c        | 30 +++++++-----------------------
 include/hw/net/lasi_82596.h |  3 ---
 4 files changed, 26 insertions(+), 48 deletions(-)

diff --git a/hw/hppa/hppa_hardware.h b/hw/hppa/hppa_hardware.h
index d422af0429..0a89c3ed52 100644
--- a/hw/hppa/hppa_hardware.h
+++ b/hw/hppa/hppa_hardware.h
@@ -21,14 +21,6 @@
 #define DINO_SCSI_HPA   0xfff8c000
 #define LASI_HPA_715    0xf0100000
 #define LASI_HPA        0xffd00000
-#define LASI_UART_HPA   0xffd05000
-#define LASI_SCSI_HPA   0xffd06000
-#define LASI_LAN_HPA    0xffd07000
-#define LASI_RTC_HPA    0xffd09000
-#define LASI_LPT_HPA    0xffd02000
-#define LASI_AUDIO_HPA  0xffd04000
-#define LASI_PS2KBD_HPA 0xffd08000
-#define LASI_PS2MOU_HPA 0xffd08100
 #define LASI_GFX_HPA    0xf8000000
 #define ARTIST_FB_ADDR  0xf9000000
 #define CPU_HPA         0xfffb0000
@@ -44,6 +36,8 @@
 
 #define SCSI_HPA        0xf1040000      /* emulated SCSI, needs to be in f region */
 
+#define HPA_DISABLED_DEVICE     1       /* add to HPA to disable */
+
 /* offsets to DINO HPA: */
 #define DINO_PCI_ADDR           0x064
 #define DINO_CONFIG_DATA        0x068
diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index cbca0026ab..8c66eed5a2 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -50,8 +50,6 @@ struct HppaMachineState {
 #define HPA_POWER_BUTTON        (FIRMWARE_END - 0x10)
 static hwaddr soft_power_reg;
 
-#define enable_lasi_lan()       0
-
 static DeviceState *lasi_dev;
 
 static void hppa_powerdown_req(Notifier *n, void *opaque)
@@ -376,13 +374,6 @@ static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
         }
     }
 
-    /* Network setup. */
-    if (lasi_dev) {
-        lasi_82596_init(addr_space, translate(NULL, LASI_LAN_HPA),
-                        qdev_get_gpio_in(lasi_dev, LASI_IRQ_LAN_HPA),
-                        enable_lasi_lan());
-    }
-
     if (pci_bus) {
         pci_init_nic_devices(pci_bus, mc->default_nic);
 
@@ -595,6 +586,17 @@ static void machine_HP_715_init(MachineState *machine)
         lasi_ncr710_handle_legacy_cmdline(dev);
     }
 
+    /* LASI i82596 network */
+    dev = qemu_create_nic_device(TYPE_LASI_82596, true, "lasi");
+    if (dev) {
+        sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+        sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0,
+                           qdev_get_gpio_in(lasi_dev, LASI_IRQ_LAN_HPA));
+        memory_region_add_subregion(addr_space,
+                                    translate(NULL, LASI_HPA_715 + LASI_LAN),
+                                    sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0));
+    }
+
     /* Add NICs, graphics & load firmware */
     machine_HP_common_init_tail(machine, NULL, translate);
 }
@@ -638,7 +640,7 @@ static void machine_HP_B160L_init(MachineState *machine)
     assert(isa_bus);
 
     /* Serial ports: Lasi and Dino use a 7.272727 MHz clock. */
-    serial_mm_init(addr_space, translate(NULL, LASI_UART_HPA + 0x800), 0,
+    serial_mm_init(addr_space, translate(NULL, LASI_HPA + LASI_UART + 0x800), 0,
         qdev_get_gpio_in(lasi_dev, LASI_IRQ_UART_HPA), 7272727 / 16,
         serial_hd(0), DEVICE_BIG_ENDIAN);
 
@@ -647,7 +649,8 @@ static void machine_HP_B160L_init(MachineState *machine)
         serial_hd(1), DEVICE_BIG_ENDIAN);
 
     /* Parallel port */
-    parallel_mm_init(addr_space, translate(NULL, LASI_LPT_HPA + 0x800), 0,
+    parallel_mm_init(addr_space,
+                     translate(NULL, LASI_HPA + LASI_LPT + 0x800), 0,
                      qdev_get_gpio_in(lasi_dev, LASI_IRQ_LPT_HPA),
                      parallel_hds[0]);
 
@@ -657,11 +660,11 @@ static void machine_HP_B160L_init(MachineState *machine)
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0,
                        qdev_get_gpio_in(lasi_dev, LASI_IRQ_PS2KBD_HPA));
     memory_region_add_subregion(addr_space,
-                                translate(NULL, LASI_PS2KBD_HPA),
+                                translate(NULL, LASI_HPA + LASI_PS2),
                                 sysbus_mmio_get_region(SYS_BUS_DEVICE(dev),
                                                        0));
     memory_region_add_subregion(addr_space,
-                                translate(NULL, LASI_PS2KBD_HPA + 0x100),
+                                translate(NULL, LASI_HPA + LASI_PS2 + 0x100),
                                 sysbus_mmio_get_region(SYS_BUS_DEVICE(dev),
                                                        1));
 
@@ -832,7 +835,7 @@ static void HP_715_machine_init_class_init(ObjectClass *oc, const void *data)
     /* can only support up to max. 8 CPUs due inventory major numbers */
     mc->max_cpus = MIN_CONST(HPPA_MAX_CPUS, 8);
     mc->default_ram_size = 256 * MiB;
-    mc->default_nic = NULL;
+    mc->default_nic = TYPE_LASI_82596;
 }
 
 
diff --git a/hw/net/lasi_i82596.c b/hw/net/lasi_i82596.c
index 9e1dd21546..b87cea411a 100644
--- a/hw/net/lasi_i82596.c
+++ b/hw/net/lasi_i82596.c
@@ -115,30 +115,10 @@ static void lasi_82596_realize(DeviceState *dev, Error **errp)
     memory_region_init_io(&s->mmio, OBJECT(d), &lasi_82596_mem_ops, d,
                 "lasi_82596-mmio", PA_GET_MACADDR + 4);
 
-    i82596_common_init(dev, s, &net_lasi_82596_info);
-}
+    sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq);
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->mmio);
 
-SysBusI82596State *lasi_82596_init(MemoryRegion *addr_space, hwaddr hpa,
-                                   qemu_irq lan_irq, gboolean match_default)
-{
-    DeviceState *dev;
-    SysBusI82596State *s;
-    static const MACAddr HP_MAC = {
-        .a = { 0x08, 0x00, 0x09, 0xef, 0x34, 0xf6 } };
-
-    dev = qemu_create_nic_device(TYPE_LASI_82596, match_default, "lasi");
-    if (!dev) {
-        return NULL;
-    }
-
-    s = SYSBUS_I82596(dev);
-    s->state.irq = lan_irq;
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
-    s->state.conf.macaddr = HP_MAC; /* set HP MAC prefix */
-
-    /* LASI 82596 ports in main memory. */
-    memory_region_add_subregion(addr_space, hpa, &s->state.mmio);
-    return s;
+    i82596_common_init(dev, s, &net_lasi_82596_info);
 }
 
 static void lasi_82596_reset(DeviceState *dev)
@@ -152,6 +132,10 @@ static void lasi_82596_instance_init(Object *obj)
 {
     SysBusI82596State *d = SYSBUS_I82596(obj);
     I82596State *s = &d->state;
+    static const MACAddr HP_MAC = {
+        .a = { 0x08, 0x00, 0x09, 0xef, 0x34, 0xf6 } };
+
+    s->conf.macaddr = HP_MAC;
 
     device_add_bootindex_property(obj, &s->conf.bootindex,
                                   "bootindex", "/ethernet-phy@0",
diff --git a/include/hw/net/lasi_82596.h b/include/hw/net/lasi_82596.h
index 439356ec19..c46a4a137e 100644
--- a/include/hw/net/lasi_82596.h
+++ b/include/hw/net/lasi_82596.h
@@ -25,7 +25,4 @@ struct SysBusI82596State {
     int val_index:1;
 };
 
-SysBusI82596State *lasi_82596_init(MemoryRegion *addr_space, hwaddr hpa,
-                                   qemu_irq irq, gboolean match_default);
-
 #endif
-- 
2.51.0


