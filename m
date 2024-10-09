Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE328CF044A
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 09:59:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syTTH-0003uR-Ar; Wed, 09 Oct 2024 05:59:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaoshiyuan@baidu.com>)
 id 1syTTF-0003uE-Hh
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 05:59:05 -0400
Received: from mx24.baidu.com ([111.206.215.185] helo=baidu.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaoshiyuan@baidu.com>)
 id 1syTTC-0001Gi-6r
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 05:59:04 -0400
To: "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>
CC: <gaoshiyuan@baidu.com>, <zuoboqun@baidu.com>, <david@redhat.com>,
 <qemu-devel@nongnu.org>, Junjie Mao <junjie.mao@hotmail.com>,
 <wangliang44@baidu.com>
Subject: [PATCH v2 1/1] virtio-pci: fix memory_region_find for
 VirtIOPCIRegion's MR
Date: Wed, 9 Oct 2024 17:58:27 +0800
Message-ID: <20241009095827.67393-1-gaoshiyuan@baidu.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.127.73.8]
X-ClientProxiedBy: BC-Mail-Ex15.internal.baidu.com (172.31.51.55) To
 bjkjy-mail-ex26.internal.baidu.com (172.31.50.42)
X-FEAS-Client-IP: 172.31.51.47
X-FE-Policy-ID: 52:10:53:SYSTEM
Received-SPF: pass client-ip=111.206.215.185;
 envelope-from=gaoshiyuan@baidu.com; helo=baidu.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Gao Shiyuan <gaoshiyuan@baidu.com>
From:  Gao Shiyuan via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

As shown below, if a virtio PCI device is attached under a pci-bridge, the MR
of VirtIOPCIRegion does not belong to any address space. So memory_region_find
cannot be used to search for this MR.

Introduce the virtio-pci and pci_bridge address spaces to solve this problem.

Before:
memory-region: pci_bridge_pci
  0000000000000000-ffffffffffffffff (prio 0, i/o): pci_bridge_pci
    00000000fe840000-00000000fe840fff (prio 1, i/o): virtio-net-pci-msix
      00000000fe840000-00000000fe84003f (prio 0, i/o): msix-table
      00000000fe840800-00000000fe840807 (prio 0, i/o): msix-pba
    0000380000000000-0000380000003fff (prio 1, i/o): virtio-pci
      0000380000000000-0000380000000fff (prio 0, i/o): virtio-pci-common-virtio-net
      0000380000001000-0000380000001fff (prio 0, i/o): virtio-pci-isr-virtio-net
      0000380000002000-0000380000002fff (prio 0, i/o): virtio-pci-device-virtio-net
      0000380000003000-0000380000003fff (prio 0, i/o): virtio-pci-notify-virtio-net

After:
address-space: virtio-pci-cfg-mem-as
  0000380000000000-0000380000003fff (prio 1, i/o): virtio-pci
    0000380000000000-0000380000000fff (prio 0, i/o): virtio-pci-common-virtio-net
    0000380000001000-0000380000001fff (prio 0, i/o): virtio-pci-isr-virtio-net
    0000380000002000-0000380000002fff (prio 0, i/o): virtio-pci-device-virtio-net
    0000380000003000-0000380000003fff (prio 0, i/o): virtio-pci-notify-virtio-net

address-space: pci_bridge_pci_mem
  0000000000000000-ffffffffffffffff (prio 0, i/o): pci_bridge_pci
    00000000fe840000-00000000fe840fff (prio 1, i/o): virtio-net-pci-msix
      00000000fe840000-00000000fe84003f (prio 0, i/o): msix-table
      00000000fe840800-00000000fe840807 (prio 0, i/o): msix-pba
    0000380000000000-0000380000003fff (prio 1, i/o): virtio-pci
      0000380000000000-0000380000000fff (prio 0, i/o): virtio-pci-common-virtio-net
      0000380000001000-0000380000001fff (prio 0, i/o): virtio-pci-isr-virtio-net
      0000380000002000-0000380000002fff (prio 0, i/o): virtio-pci-device-virtio-net
      0000380000003000-0000380000003fff (prio 0, i/o): virtio-pci-notify-virtio-net

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2576
Fixes: ffa8a3e3b2e6 ("virtio-pci: Add lookup subregion of VirtIOPCIRegion MR")

Signed-off-by: Gao Shiyuan <gaoshiyuan@baidu.com>
Signed-off-by: Zuo Boqun <zuoboqun@baidu.com>
Signed-off-by: Wang Liang <wangliang44@baidu.com>
---
 hw/pci/pci_bridge.c            | 4 ++++
 hw/virtio/virtio-pci.c         | 5 +++++
 include/hw/pci/pci_bridge.h    | 2 ++
 include/hw/virtio/virtio-pci.h | 3 +++
 4 files changed, 14 insertions(+)

v1 -> v2:
* modify commit message
* add address space for port I/O notification config region

diff --git a/hw/pci/pci_bridge.c b/hw/pci/pci_bridge.c
index 6a4e38856d..099ea9e24e 100644
--- a/hw/pci/pci_bridge.c
+++ b/hw/pci/pci_bridge.c
@@ -380,9 +380,11 @@ void pci_bridge_initfn(PCIDevice *dev, const char *typename)
     sec_bus->map_irq = br->map_irq ? br->map_irq : pci_swizzle_map_irq_fn;
     sec_bus->address_space_mem = &br->address_space_mem;
     memory_region_init(&br->address_space_mem, OBJECT(br), "pci_bridge_pci", UINT64_MAX);
+    address_space_init(&br->as_mem, &br->address_space_mem, "pci_bridge_pci_mem");
     sec_bus->address_space_io = &br->address_space_io;
     memory_region_init(&br->address_space_io, OBJECT(br), "pci_bridge_io",
                        4 * GiB);
+    address_space_init(&br->as_io, &br->address_space_io, "pci_bridge_pci_io");
     pci_bridge_region_init(br);
     QLIST_INIT(&sec_bus->child);
     QLIST_INSERT_HEAD(&parent->child, sec_bus, sibling);
@@ -399,6 +401,8 @@ void pci_bridge_exitfn(PCIDevice *pci_dev)
     PCIBridge *s = PCI_BRIDGE(pci_dev);
     assert(QLIST_EMPTY(&s->sec_bus.child));
     QLIST_REMOVE(&s->sec_bus, sibling);
+    address_space_destroy(&s->as_mem);
+    address_space_destroy(&s->as_io);
     pci_bridge_region_del(s, &s->windows);
     pci_bridge_region_cleanup(s, &s->windows);
     /* object_unparent() is called automatically during device deletion */
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 4d832fe845..1e862dd0df 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -2057,6 +2057,7 @@ static void virtio_pci_device_plugged(DeviceState *d, Error **errp)
         if (modern_pio) {
             memory_region_init(&proxy->io_bar, OBJECT(proxy),
                                "virtio-pci-io", 0x4);
+            address_space_init(&proxy->modern_cfg_io_as, &proxy->io_bar, "virtio-pci-cfg-io-as");
 
             pci_register_bar(&proxy->pci_dev, proxy->modern_io_bar_idx,
                              PCI_BASE_ADDRESS_SPACE_IO, &proxy->io_bar);
@@ -2180,6 +2181,8 @@ static void virtio_pci_realize(PCIDevice *pci_dev, Error **errp)
                        /* PCI BAR regions must be powers of 2 */
                        pow2ceil(proxy->notify.offset + proxy->notify.size));
 
+    address_space_init(&proxy->modern_cfg_mem_as, &proxy->modern_bar, "virtio-pci-cfg-mem-as");
+
     if (proxy->disable_legacy == ON_OFF_AUTO_AUTO) {
         proxy->disable_legacy = pcie_port ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
     }
@@ -2275,6 +2278,8 @@ static void virtio_pci_exit(PCIDevice *pci_dev)
         pci_is_express(pci_dev)) {
         pcie_aer_exit(pci_dev);
     }
+    address_space_destroy(&proxy->modern_cfg_mem_as);
+    address_space_destroy(&proxy->modern_cfg_io_as);
 }
 
 static void virtio_pci_reset(DeviceState *qdev)
diff --git a/include/hw/pci/pci_bridge.h b/include/hw/pci/pci_bridge.h
index 5cd452115a..bd12fbe4ef 100644
--- a/include/hw/pci/pci_bridge.h
+++ b/include/hw/pci/pci_bridge.h
@@ -72,6 +72,8 @@ struct PCIBridge {
      */
     MemoryRegion address_space_mem;
     MemoryRegion address_space_io;
+    AddressSpace as_mem;
+    AddressSpace as_io;
 
     PCIBridgeWindows windows;
 
diff --git a/include/hw/virtio/virtio-pci.h b/include/hw/virtio/virtio-pci.h
index 9e67ba38c7..971c5fabd4 100644
--- a/include/hw/virtio/virtio-pci.h
+++ b/include/hw/virtio/virtio-pci.h
@@ -147,6 +147,9 @@ struct VirtIOPCIProxy {
     };
     MemoryRegion modern_bar;
     MemoryRegion io_bar;
+    /* address space for VirtIOPCIRegions */
+    AddressSpace modern_cfg_mem_as;
+    AddressSpace modern_cfg_io_as;
     uint32_t legacy_io_bar_idx;
     uint32_t msix_bar_idx;
     uint32_t modern_io_bar_idx;
-- 
2.34.1


