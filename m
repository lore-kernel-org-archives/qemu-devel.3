Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FCC2CAC5AE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 08:30:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v23fI-00010B-8s; Fri, 26 Sep 2025 04:18:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v23fE-0000rA-Jj; Fri, 26 Sep 2025 04:18:48 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v23ez-0002AE-MW; Fri, 26 Sep 2025 04:18:46 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 49C35157D7F;
 Fri, 26 Sep 2025 11:10:35 +0300 (MSK)
Received: from think4mjt.origo (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 5B08E290C63;
 Fri, 26 Sep 2025 11:10:36 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.1.1 55/60] hw/pci-host/astro: Don't call
 pci_regsiter_root_bus() in init
Date: Fri, 26 Sep 2025 11:10:23 +0300
Message-ID: <20250926081031.2214971-55-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.1.1-20250926101857@cover.tls.msk.ru>
References: <qemu-stable-10.1.1-20250926101857@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Peter Maydell <peter.maydell@linaro.org>

In the astro PCI host bridge device, we call pci_register_root_bus()
in the device's instance_init. This is a problem for two reasons
 * the PCI bridge is then available to the rest of the simulation
   (e.g. via pci_qdev_find_device()), even though it hasn't
   yet been realized
 * we do not attempt to unregister in an instance_deinit,
   which means that if you go through an instance_init -> deinit
   lifecycle the freed memory for the host-bridge device is
   left on the pci_host_bridges list

ASAN reports the resulting use-after-free:

==1776584==ERROR: AddressSanitizer: heap-use-after-free on address 0x51f00000cb00 at pc 0x5b2d460a89b5 bp 0x7ffef7617f50 sp 0x7ffef7617f48
WRITE of size 8 at 0x51f00000cb00 thread T0
    #0 0x5b2d460a89b4 in pci_host_bus_register /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/hppa-asan/../../hw/pci/pci.c:608:5
    #1 0x5b2d46093566 in pci_root_bus_internal_init /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/hppa-asan/../../hw/pci/pci.c:677:5
    #2 0x5b2d460935e0 in pci_root_bus_new /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/hppa-asan/../../hw/pci/pci.c:706:5
    #3 0x5b2d46093fe5 in pci_register_root_bus /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/hppa-asan/../../hw/pci/pci.c:751:11
    #4 0x5b2d46fe2335 in elroy_pcihost_init /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/hppa-asan/../../hw/pci-host/astro.c:455:16

0x51f00000cb00 is located 1664 bytes inside of 3456-byte region [0x51f00000c480,0x51f00000d200)
freed by thread T0 here:
    #0 0x5b2d4582385a in free (/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/hppa-asan/qemu-system-hppa+0x17ad85a) (BuildId: 692b49eedc6fb0ef618bbb6784a09311b3b7f1e8)
    #1 0x5b2d47160723 in object_finalize /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/hppa-asan/../../qom/object.c:734:9
    #2 0x5b2d471589db in object_unref /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/hppa-asan/../../qom/object.c:1232:9
    #3 0x5b2d477d373c in qmp_device_list_properties /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/hppa-asan/../../qom/qom-qmp-cmds.c:237:5

previously allocated by thread T0 here:
    #0 0x5b2d45823af3 in malloc (/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/hppa-asan/qemu-system-hppa+0x17adaf3) (BuildId: 692b49eedc6fb0ef618bbb6784a09311b3b7f1e8)
    #1 0x79728fa08b09 in g_malloc (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x62b09) (BuildId: 1eb6131419edb83b2178b682829a6913cf682d75)
    #2 0x5b2d471595fc in object_new_with_type /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/hppa-asan/../../qom/object.c:767:15
    #3 0x5b2d47159409 in object_new_with_class /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/hppa-asan/../../qom/object.c:782:12
    #4 0x5b2d477d29a5 in qmp_device_list_properties /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/hppa-asan/../../qom/qom-qmp-cmds.c:206:11

Cc: qemu-stable@nongnu.org
Fixes: e029bb00a79be ("hw/pci-host: Add Astro system bus adapter found on PA-RISC machines")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3118
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250918114259.1802337-3-peter.maydell@linaro.org>
(cherry picked from commit 76d2b8d42adb0db2d1ccd08a626f25ddd30208a8)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/pci-host/astro.c b/hw/pci-host/astro.c
index 859e308c57..1024ede7b6 100644
--- a/hw/pci-host/astro.c
+++ b/hw/pci-host/astro.c
@@ -424,22 +424,23 @@ static void elroy_reset(DeviceState *dev)
     }
 }
 
-static void elroy_pcihost_init(Object *obj)
+static void elroy_pcihost_realize(DeviceState *dev, Error **errp)
 {
-    ElroyState *s = ELROY_PCI_HOST_BRIDGE(obj);
-    PCIHostState *phb = PCI_HOST_BRIDGE(obj);
-    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+    ElroyState *s = ELROY_PCI_HOST_BRIDGE(dev);
+    PCIHostState *phb = PCI_HOST_BRIDGE(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+    Object *obj = OBJECT(s);
 
     /* Elroy config access from CPU.  */
-    memory_region_init_io(&s->this_mem, OBJECT(s), &elroy_chip_ops,
+    memory_region_init_io(&s->this_mem, obj, &elroy_chip_ops,
                           s, "elroy", 0x2000);
 
     /* Elroy PCI config. */
-    memory_region_init_io(&phb->conf_mem, OBJECT(phb),
-                          &elroy_config_addr_ops, DEVICE(s),
+    memory_region_init_io(&phb->conf_mem, obj,
+                          &elroy_config_addr_ops, dev,
                           "pci-conf-idx", 8);
-    memory_region_init_io(&phb->data_mem, OBJECT(phb),
-                          &elroy_config_data_ops, DEVICE(s),
+    memory_region_init_io(&phb->data_mem, obj,
+                          &elroy_config_data_ops, dev,
                           "pci-conf-data", 8);
     memory_region_add_subregion(&s->this_mem, 0x40,
                                 &phb->conf_mem);
@@ -447,8 +448,8 @@ static void elroy_pcihost_init(Object *obj)
                                 &phb->data_mem);
 
     /* Elroy PCI bus memory.  */
-    memory_region_init(&s->pci_mmio, OBJECT(s), "pci-mmio", UINT64_MAX);
-    memory_region_init_io(&s->pci_io, OBJECT(s), &unassigned_io_ops, obj,
+    memory_region_init(&s->pci_mmio, obj, "pci-mmio", UINT64_MAX);
+    memory_region_init_io(&s->pci_io, obj, &unassigned_io_ops, obj,
                             "pci-isa-mmio",
                             ((uint32_t) IOS_DIST_BASE_SIZE) / ROPES_PER_IOC);
 
@@ -459,7 +460,7 @@ static void elroy_pcihost_init(Object *obj)
 
     sysbus_init_mmio(sbd, &s->this_mem);
 
-    qdev_init_gpio_in(DEVICE(obj), elroy_set_irq, ELROY_IRQS);
+    qdev_init_gpio_in(dev, elroy_set_irq, ELROY_IRQS);
 }
 
 static const VMStateDescription vmstate_elroy = {
@@ -487,6 +488,7 @@ static void elroy_pcihost_class_init(ObjectClass *klass, const void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     device_class_set_legacy_reset(dc, elroy_reset);
+    dc->realize = elroy_pcihost_realize;
     dc->vmsd = &vmstate_elroy;
     dc->user_creatable = false;
 }
@@ -494,7 +496,6 @@ static void elroy_pcihost_class_init(ObjectClass *klass, const void *data)
 static const TypeInfo elroy_pcihost_info = {
     .name          = TYPE_ELROY_PCI_HOST_BRIDGE,
     .parent        = TYPE_PCI_HOST_BRIDGE,
-    .instance_init = elroy_pcihost_init,
     .instance_size = sizeof(ElroyState),
     .class_init    = elroy_pcihost_class_init,
 };
-- 
2.47.3


