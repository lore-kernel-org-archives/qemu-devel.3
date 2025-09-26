Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7215BCAC5AE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 08:27:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v23fA-0000Nl-Se; Fri, 26 Sep 2025 04:18:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v23f4-0000Iq-Cn; Fri, 26 Sep 2025 04:18:38 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v23ew-00029b-AR; Fri, 26 Sep 2025 04:18:38 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 36F59157D7E;
 Fri, 26 Sep 2025 11:10:35 +0300 (MSK)
Received: from think4mjt.origo (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 48994290C62;
 Fri, 26 Sep 2025 11:10:36 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.1.1 54/60] hw/pci-host/dino: Don't call
 pci_register_root_bus() in init
Date: Fri, 26 Sep 2025 11:10:22 +0300
Message-ID: <20250926081031.2214971-54-mjt@tls.msk.ru>
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

From: Peter Maydell <peter.maydell@linaro.org>

In the dino PCI host bridge device, we call pci_register_root_bus()
in the device's instance_init. This is a problem for two reasons
 * the PCI bridge is then available to the rest of the simulation
   (e.g. via pci_qdev_find_device()), even though it hasn't
   yet been realized
 * we do not attempt to unregister in an instance_deinit,
   which means that if you go through an instance_init -> deinit
   lifecycle the freed memory for the host-bridge device is
   left on the pci_host_bridges list

ASAN reports the resulting use-after-free:

==1771223==ERROR: AddressSanitizer: heap-use-after-free on address 0x527000018f80 at pc 0x5b4b9d3369b5 bp 0x7ffd01929980 sp 0x7ffd01929978
WRITE of size 8 at 0x527000018f80 thread T0
    #0 0x5b4b9d3369b4 in pci_host_bus_register /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/hppa-asan/../../hw/pci/pci.c:608:5
    #1 0x5b4b9d321566 in pci_root_bus_internal_init /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/hppa-asan/../../hw/pci/pci.c:677:5
    #2 0x5b4b9d3215e0 in pci_root_bus_new /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/hppa-asan/../../hw/pci/pci.c:706:5
    #3 0x5b4b9d321fe5 in pci_register_root_bus /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/hppa-asan/../../hw/pci/pci.c:751:11
    #4 0x5b4b9d390521 in dino_pcihost_init /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/hppa-asan/../../hw/pci-host/dino.c:473:16

0x527000018f80 is located 1664 bytes inside of 12384-byte region [0x527000018900,0x52700001b960)
freed by thread T0 here:
    #0 0x5b4b9cab185a in free (/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/hppa-asan/qemu-system-hppa+0x17ad85a) (BuildId: ca496bb2e4fc750ebd289b448bad8d99c0ecd140)
    #1 0x5b4b9e3ee723 in object_finalize /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/hppa-asan/../../qom/object.c:734:9
    #2 0x5b4b9e3e69db in object_unref /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/hppa-asan/../../qom/object.c:1232:9
    #3 0x5b4b9ea6173c in qmp_device_list_properties /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/hppa-asan/../../qom/qom-qmp-cmds.c:237:5
    #4 0x5b4b9ec4e0f3 in qmp_marshal_device_list_properties /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/hppa-asan/qapi/qapi-commands-qdev.c:65:14

previously allocated by thread T0 here:
    #0 0x5b4b9cab1af3 in malloc (/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/hppa-asan/qemu-system-hppa+0x17adaf3) (BuildId: ca496bb2e4fc750ebd289b448bad8d99c0ecd140)
    #1 0x799d8270eb09 in g_malloc (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x62b09) (BuildId: 1eb6131419edb83b2178b682829a6913cf682d75)
    #2 0x5b4b9e3e75fc in object_new_with_type /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/hppa-asan/../../qom/object.c:767:15
    #3 0x5b4b9e3e7409 in object_new_with_class /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/hppa-asan/../../qom/object.c:782:12
    #4 0x5b4b9ea609a5 in qmp_device_list_properties /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/hppa-asan/../../qom/qom-qmp-cmds.c:206:11

where we allocated one instance of the dino device, put it on the
list, freed it, and then trying to allocate a second instance touches
the freed memory on the pci_host_bridges list.

Fix this by deferring all the setup of memory regions and registering
the PCI bridge to the device's realize method.  This brings it into
line with almost all other PCI host bridges, which call
pci_register_root_bus() in realize.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3118
Fixes: 63901b6cc4d8b4 ("dino: move PCI bus initialisation to dino_pcihost_init()")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250918114259.1802337-2-peter.maydell@linaro.org>
(cherry picked from commit e4a1b308b27cd77338b8f05d3a31e6b38eb717c7)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/pci-host/dino.c b/hw/pci-host/dino.c
index 11b353be2e..924053499c 100644
--- a/hw/pci-host/dino.c
+++ b/hw/pci-host/dino.c
@@ -413,43 +413,7 @@ static void dino_pcihost_reset(DeviceState *dev)
 static void dino_pcihost_realize(DeviceState *dev, Error **errp)
 {
     DinoState *s = DINO_PCI_HOST_BRIDGE(dev);
-
-    /* Set up PCI view of memory: Bus master address space.  */
-    memory_region_init(&s->bm, OBJECT(s), "bm-dino", 4 * GiB);
-    memory_region_init_alias(&s->bm_ram_alias, OBJECT(s),
-                             "bm-system", s->memory_as, 0,
-                             0xf0000000 + DINO_MEM_CHUNK_SIZE);
-    memory_region_init_alias(&s->bm_pci_alias, OBJECT(s),
-                             "bm-pci", &s->pci_mem,
-                             0xf0000000 + DINO_MEM_CHUNK_SIZE,
-                             30 * DINO_MEM_CHUNK_SIZE);
-    memory_region_init_alias(&s->bm_cpu_alias, OBJECT(s),
-                             "bm-cpu", s->memory_as, 0xfff00000,
-                             0xfffff);
-    memory_region_add_subregion(&s->bm, 0,
-                                &s->bm_ram_alias);
-    memory_region_add_subregion(&s->bm,
-                                0xf0000000 + DINO_MEM_CHUNK_SIZE,
-                                &s->bm_pci_alias);
-    memory_region_add_subregion(&s->bm, 0xfff00000,
-                                &s->bm_cpu_alias);
-
-    address_space_init(&s->bm_as, &s->bm, "pci-bm");
-}
-
-static void dino_pcihost_unrealize(DeviceState *dev)
-{
-    DinoState *s = DINO_PCI_HOST_BRIDGE(dev);
-
-    address_space_destroy(&s->bm_as);
-}
-
-static void dino_pcihost_init(Object *obj)
-{
-    DinoState *s = DINO_PCI_HOST_BRIDGE(obj);
-    PCIHostState *phb = PCI_HOST_BRIDGE(obj);
-    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
-    int i;
+    PCIHostState *phb = PCI_HOST_BRIDGE(dev);
 
     /* Dino PCI access from main memory.  */
     memory_region_init_io(&s->this_mem, OBJECT(s), &dino_chip_ops,
@@ -476,7 +440,7 @@ static void dino_pcihost_init(Object *obj)
                                      PCI_DEVFN(0, 0), 32, TYPE_PCI_BUS);
 
     /* Set up windows into PCI bus memory.  */
-    for (i = 1; i < 31; i++) {
+    for (int i = 1; i < 31; i++) {
         uint32_t addr = 0xf0000000 + i * DINO_MEM_CHUNK_SIZE;
         char *name = g_strdup_printf("PCI Outbound Window %d", i);
         memory_region_init_alias(&s->pci_mem_alias[i], OBJECT(s),
@@ -487,9 +451,38 @@ static void dino_pcihost_init(Object *obj)
 
     pci_setup_iommu(phb->bus, &dino_iommu_ops, s);
 
-    sysbus_init_mmio(sbd, &s->this_mem);
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->this_mem);
 
-    qdev_init_gpio_in(DEVICE(obj), dino_set_irq, DINO_IRQS);
+    qdev_init_gpio_in(dev, dino_set_irq, DINO_IRQS);
+
+    /* Set up PCI view of memory: Bus master address space.  */
+    memory_region_init(&s->bm, OBJECT(s), "bm-dino", 4 * GiB);
+    memory_region_init_alias(&s->bm_ram_alias, OBJECT(s),
+                             "bm-system", s->memory_as, 0,
+                             0xf0000000 + DINO_MEM_CHUNK_SIZE);
+    memory_region_init_alias(&s->bm_pci_alias, OBJECT(s),
+                             "bm-pci", &s->pci_mem,
+                             0xf0000000 + DINO_MEM_CHUNK_SIZE,
+                             30 * DINO_MEM_CHUNK_SIZE);
+    memory_region_init_alias(&s->bm_cpu_alias, OBJECT(s),
+                             "bm-cpu", s->memory_as, 0xfff00000,
+                             0xfffff);
+    memory_region_add_subregion(&s->bm, 0,
+                                &s->bm_ram_alias);
+    memory_region_add_subregion(&s->bm,
+                                0xf0000000 + DINO_MEM_CHUNK_SIZE,
+                                &s->bm_pci_alias);
+    memory_region_add_subregion(&s->bm, 0xfff00000,
+                                &s->bm_cpu_alias);
+
+    address_space_init(&s->bm_as, &s->bm, "pci-bm");
+}
+
+static void dino_pcihost_unrealize(DeviceState *dev)
+{
+    DinoState *s = DINO_PCI_HOST_BRIDGE(dev);
+
+    address_space_destroy(&s->bm_as);
 }
 
 static const Property dino_pcihost_properties[] = {
@@ -511,7 +504,6 @@ static void dino_pcihost_class_init(ObjectClass *klass, const void *data)
 static const TypeInfo dino_pcihost_info = {
     .name          = TYPE_DINO_PCI_HOST_BRIDGE,
     .parent        = TYPE_PCI_HOST_BRIDGE,
-    .instance_init = dino_pcihost_init,
     .instance_size = sizeof(DinoState),
     .class_init    = dino_pcihost_class_init,
 };
-- 
2.47.3


