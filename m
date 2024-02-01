Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0F0FC48286
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 16:45:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVaAz-0002tA-VR; Thu, 01 Feb 2024 11:44:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+1220c4869a9b484313cc+7466+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1rVaAq-0002qi-To
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 11:44:25 -0500
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+1220c4869a9b484313cc+7466+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1rVaAm-0002Uq-9b
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 11:44:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
 Cc:Content-Type:Content-ID:Content-Description;
 bh=TA17OVi49hCfDCSb/FocGIXS9Sfw+etv8YHmfCgYILA=; b=aCMip3eP7NY1og3yZWUHI9qERA
 o0rZx2ET/NFIHjfYEAZUbizWkoOCs2BKgY55ujW4lsSD7y919NWhMBf99wQWfQ5CdJdV0ifzAaPLl
 6Q+Vo/pmfgL/9UmjNIrJztUyAsQrIvdgHbS/iOM1difqzz4ZwnNe4DQ6sg4HDwPLLFsGFS/mLBWCD
 11q0685D+smrusQLuk6eBA7if/xR18ERt/toF+IsayaK88arMt6QktDy+UTcsFzrKCcg7HO3S1WWE
 /KPEuevNZNb8zQ7ccuBOpJNtTKmgrwywWBiZf0cyLUBN+hazTlzNs5Ltg/dSxOTTrId9orduY7c4Y
 QSqGSmFQ==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
 by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
 id 1rVaAh-00000009cM7-1xcE for qemu-devel@nongnu.org;
 Thu, 01 Feb 2024 16:44:15 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.97.1 #2 (Red
 Hat Linux)) id 1rVaAg-00000003INU-11KH for qemu-devel@nongnu.org;
 Thu, 01 Feb 2024 16:44:14 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: qemu-devel@nongnu.org
Subject: [PULL 25/47] hw/net/smc91c111: use qemu_configure_nic_device()
Date: Thu,  1 Feb 2024 16:43:50 +0000
Message-ID: <20240201164412.785520-26-dwmw2@infradead.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201164412.785520-1-dwmw2@infradead.org>
References: <20240201164412.785520-1-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 desiato.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05;
 envelope-from=BATV+1220c4869a9b484313cc+7466+infradead.org+dwmw2@desiato.srs.infradead.org;
 helo=desiato.infradead.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: David Woodhouse <dwmw@amazon.co.uk>

Some callers instantiate the device unconditionally, others will do so only
if there is a NICInfo to go with it. This appears to be fairly random, but
preserve the existing behaviour of each caller for now.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 hw/arm/gumstix.c           |  6 ++----
 hw/arm/integratorcp.c      |  5 +++--
 hw/arm/mainstone.c         |  3 +--
 hw/arm/realview.c          | 25 ++++++++++---------------
 hw/arm/versatilepb.c       | 15 ++++-----------
 hw/net/smc91c111.c         |  5 ++---
 include/hw/net/smc91c111.h |  2 +-
 7 files changed, 23 insertions(+), 38 deletions(-)

diff --git a/hw/arm/gumstix.c b/hw/arm/gumstix.c
index 3f2bcaa24e..d5de5409e1 100644
--- a/hw/arm/gumstix.c
+++ b/hw/arm/gumstix.c
@@ -73,8 +73,7 @@ static void connex_init(MachineState *machine)
                           FLASH_SECTOR_SIZE, 2, 0, 0, 0, 0, 0);
 
     /* Interrupt line of NIC is connected to GPIO line 36 */
-    smc91c111_init(&nd_table[0], 0x04000300,
-                    qdev_get_gpio_in(cpu->gpio, 36));
+    smc91c111_init(0x04000300, qdev_get_gpio_in(cpu->gpio, 36));
 }
 
 static void verdex_init(MachineState *machine)
@@ -97,8 +96,7 @@ static void verdex_init(MachineState *machine)
                           FLASH_SECTOR_SIZE, 2, 0, 0, 0, 0, 0);
 
     /* Interrupt line of NIC is connected to GPIO line 99 */
-    smc91c111_init(&nd_table[0], 0x04000300,
-                    qdev_get_gpio_in(cpu->gpio, 99));
+    smc91c111_init(0x04000300, qdev_get_gpio_in(cpu->gpio, 99));
 }
 
 static void connex_class_init(ObjectClass *oc, void *data)
diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
index 793262eca8..f016d20485 100644
--- a/hw/arm/integratorcp.c
+++ b/hw/arm/integratorcp.c
@@ -666,8 +666,9 @@ static void integratorcp_init(MachineState *machine)
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0x1d000000);
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic[25]);
 
-    if (nd_table[0].used)
-        smc91c111_init(&nd_table[0], 0xc8000000, pic[27]);
+    if (qemu_find_nic_info("smc91c111", true, NULL)) {
+        smc91c111_init(0xc8000000, pic[27]);
+    }
 
     sysbus_create_simple("pl110", 0xc0000000, pic[22]);
 
diff --git a/hw/arm/mainstone.c b/hw/arm/mainstone.c
index fc14e05060..d2e2e68aa3 100644
--- a/hw/arm/mainstone.c
+++ b/hw/arm/mainstone.c
@@ -152,8 +152,7 @@ static void mainstone_common_init(MachineState *machine,
             qdev_get_gpio_in(mst_irq, S1_IRQ),
             qdev_get_gpio_in(mst_irq, S1_CD_IRQ));
 
-    smc91c111_init(&nd_table[0], MST_ETH_PHYS,
-                    qdev_get_gpio_in(mst_irq, ETHERNET_IRQ));
+    smc91c111_init(MST_ETH_PHYS, qdev_get_gpio_in(mst_irq, ETHERNET_IRQ));
 
     mainstone_binfo.board_id = arm_id;
     arm_load_kernel(mpu->cpu, machine, &mainstone_binfo);
diff --git a/hw/arm/realview.c b/hw/arm/realview.c
index 566deff9ce..c6bd6e5961 100644
--- a/hw/arm/realview.c
+++ b/hw/arm/realview.c
@@ -90,7 +90,6 @@ static void realview_init(MachineState *machine,
     I2CBus *i2c;
     int n;
     unsigned int smp_cpus = machine->smp.cpus;
-    int done_nic = 0;
     qemu_irq cpu_irq[4];
     int is_mpcore = 0;
     int is_pb = 0;
@@ -296,24 +295,20 @@ static void realview_init(MachineState *machine,
             n--;
         }
     }
-    for(n = 0; n < nb_nics; n++) {
-        nd = &nd_table[n];
-
-        if (!done_nic && (!nd->model ||
-                    strcmp(nd->model, is_pb ? "lan9118" : "smc91c111") == 0)) {
-            if (is_pb) {
-                lan9118_init(nd, 0x4e000000, pic[28]);
-            } else {
-                smc91c111_init(nd, 0x4e000000, pic[28]);
-            }
-            done_nic = 1;
+
+    nd = qemu_find_nic_info(is_pb ? "lan9118" : "smc91c111", true, NULL);
+    if (nd) {
+        if (is_pb) {
+            lan9118_init(nd, 0x4e000000, pic[28]);
         } else {
-            if (pci_bus) {
-                pci_nic_init_nofail(nd, pci_bus, "rtl8139", NULL);
-            }
+            smc91c111_init(0x4e000000, pic[28]);
         }
     }
 
+    if (pci_bus) {
+        pci_init_nic_devices(pci_bus, "rtl8139");
+    }
+
     dev = sysbus_create_simple(TYPE_ARM_SBCON_I2C, 0x10002000, NULL);
     i2c = (I2CBus *)qdev_get_child_bus(dev, "i2c");
     i2c_slave_create_simple(i2c, "ds1338", 0x68);
diff --git a/hw/arm/versatilepb.c b/hw/arm/versatilepb.c
index 1d813aa23b..d10b75dfdb 100644
--- a/hw/arm/versatilepb.c
+++ b/hw/arm/versatilepb.c
@@ -192,10 +192,8 @@ static void versatile_init(MachineState *machine, int board_id)
     SysBusDevice *busdev;
     DeviceState *pl041;
     PCIBus *pci_bus;
-    NICInfo *nd;
     I2CBus *i2c;
     int n;
-    int done_smc = 0;
     DriveInfo *dinfo;
 
     if (machine->ram_size > 0x10000000) {
@@ -263,16 +261,11 @@ static void versatile_init(MachineState *machine, int board_id)
     sysbus_connect_irq(busdev, 3, sic[30]);
     pci_bus = (PCIBus *)qdev_get_child_bus(dev, "pci");
 
-    for(n = 0; n < nb_nics; n++) {
-        nd = &nd_table[n];
-
-        if (!done_smc && (!nd->model || strcmp(nd->model, "smc91c111") == 0)) {
-            smc91c111_init(nd, 0x10010000, sic[25]);
-            done_smc = 1;
-        } else {
-            pci_nic_init_nofail(nd, pci_bus, "rtl8139", NULL);
-        }
+    if (qemu_find_nic_info("smc91c111", true, NULL)) {
+        smc91c111_init(0x10010000, sic[25]);
     }
+    pci_init_nic_devices(pci_bus, "rtl8139");
+
     if (machine_usb(machine)) {
         pci_create_simple(pci_bus, -1, "pci-ohci");
     }
diff --git a/hw/net/smc91c111.c b/hw/net/smc91c111.c
index 49b7c26102..702d0e8e83 100644
--- a/hw/net/smc91c111.c
+++ b/hw/net/smc91c111.c
@@ -818,14 +818,13 @@ static void smc91c111_register_types(void)
 
 /* Legacy helper function.  Should go away when machine config files are
    implemented.  */
-void smc91c111_init(NICInfo *nd, uint32_t base, qemu_irq irq)
+void smc91c111_init(uint32_t base, qemu_irq irq)
 {
     DeviceState *dev;
     SysBusDevice *s;
 
-    qemu_check_nic_model(nd, "smc91c111");
     dev = qdev_new(TYPE_SMC91C111);
-    qdev_set_nic_properties(dev, nd);
+    qemu_configure_nic_device(dev, true, NULL);
     s = SYS_BUS_DEVICE(dev);
     sysbus_realize_and_unref(s, &error_fatal);
     sysbus_mmio_map(s, 0, base);
diff --git a/include/hw/net/smc91c111.h b/include/hw/net/smc91c111.h
index df5b11dcef..dba32a233f 100644
--- a/include/hw/net/smc91c111.h
+++ b/include/hw/net/smc91c111.h
@@ -13,6 +13,6 @@
 
 #include "net/net.h"
 
-void smc91c111_init(NICInfo *, uint32_t, qemu_irq);
+void smc91c111_init(uint32_t, qemu_irq);
 
 #endif
-- 
2.43.0


