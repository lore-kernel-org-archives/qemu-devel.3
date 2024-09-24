Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46675CF9C74
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2024 01:13:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ssu6Y-0002wR-Gy; Mon, 23 Sep 2024 21:12:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaoshiyuan@baidu.com>)
 id 1ssu6V-0002vB-TQ
 for qemu-devel@nongnu.org; Mon, 23 Sep 2024 21:12:35 -0400
Received: from mx24.baidu.com ([111.206.215.185] helo=baidu.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaoshiyuan@baidu.com>)
 id 1ssu6P-0000XV-Al
 for qemu-devel@nongnu.org; Mon, 23 Sep 2024 21:12:35 -0400
To: "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>
CC: <gaoshiyuan@baidu.com>, <zuoboqun@baidu.com>, <david@redhat.com>,
 <thuth@redhat.com>, <alxndr@bu.edu>, <peterx@redhat.com>,
 <qemu-devel@nongnu.org>, <imammedo@redhat.com>
Subject: [PATCH 1/1] virtio-pci: fix memory_region_find for VirtIOPCIRegion's
 MR
Date: Tue, 24 Sep 2024 09:11:56 +0800
Message-ID: <20240924011156.48252-1-gaoshiyuan@baidu.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.127.73.8]
X-ClientProxiedBy: BJHW-MAIL-EX04.internal.baidu.com (10.127.64.14) To
 bjkjy-mail-ex26.internal.baidu.com (172.31.50.42)
X-FEAS-Client-IP: 10.127.64.32
X-FE-Policy-ID: 52:10:53:SYSTEM
Received-SPF: pass client-ip=111.206.215.185;
 envelope-from=gaoshiyuan@baidu.com; helo=baidu.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Introduce the virtio-pci and pci_bridge_pci address spaces to solve this problem.

Before:
memory-region: pci_bridge_pci
  0000000000000000-ffffffffffffffff (prio 0, i/o): pci_bridge_pci
    00000000fe200000-00000000fe200fff (prio 1, i/o): virtio-blk-pci-msix
      00000000fe200000-00000000fe20016f (prio 0, i/o): msix-table
      00000000fe200800-00000000fe200807 (prio 0, i/o): msix-pba
    000000a000400000-000000a000403fff (prio 1, i/o): virtio-pci
      000000a000400000-000000a000400fff (prio 0, i/o): virtio-pci-common-virtio-blk
      000000a000401000-000000a000401fff (prio 0, i/o): virtio-pci-isr-virtio-blk
      000000a000402000-000000a000402fff (prio 0, i/o): virtio-pci-device-virtio-blk
      000000a000403000-000000a000403fff (prio 0, i/o): virtio-pci-notify-virtio-blk

After:
address-space: pci_bridge_pci
  0000000000000000-ffffffffffffffff (prio 0, i/o): pci_bridge_pci
    00000000fe200000-00000000fe200fff (prio 1, i/o): virtio-blk-pci-msix
      00000000fe200000-00000000fe20016f (prio 0, i/o): msix-table
      00000000fe200800-00000000fe200807 (prio 0, i/o): msix-pba
    000000a000400000-000000a000403fff (prio 1, i/o): virtio-pci
      000000a000400000-000000a000400fff (prio 0, i/o): virtio-pci-common-virtio-blk
      000000a000401000-000000a000401fff (prio 0, i/o): virtio-pci-isr-virtio-blk
      000000a000402000-000000a000402fff (prio 0, i/o): virtio-pci-device-virtio-blk
      000000a000403000-000000a000403fff (prio 0, i/o): virtio-pci-notify-virtio-blk

address-space: virtio-pci
  000000a000400000-000000a000403fff (prio 1, i/o): virtio-pci
    000000a000400000-000000a000400fff (prio 0, i/o): virtio-pci-common-virtio-blk
    000000a000401000-000000a000401fff (prio 0, i/o): virtio-pci-isr-virtio-blk
    000000a000402000-000000a000402fff (prio 0, i/o): virtio-pci-device-virtio-blk
    000000a000403000-000000a000403fff (prio 0, i/o): virtio-pci-notify-virtio-blk

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2576
Fixes: ffa8a3e ("virtio-pci: Add lookup subregion of VirtIOPCIRegion MR")

Signed-off-by: Gao Shiyuan <gaoshiyuan@baidu.com>
Signed-off-by: Zuo Boqun <zuoboqun@baidu.com>
---
 hw/pci/pci_bridge.c            | 2 ++
 hw/virtio/virtio-pci.c         | 3 +++
 include/hw/pci/pci_bridge.h    | 1 +
 include/hw/virtio/virtio-pci.h | 1 +
 4 files changed, 7 insertions(+)

diff --git a/hw/pci/pci_bridge.c b/hw/pci/pci_bridge.c
index 6a4e38856d..74683e7445 100644
--- a/hw/pci/pci_bridge.c
+++ b/hw/pci/pci_bridge.c
@@ -380,6 +380,7 @@ void pci_bridge_initfn(PCIDevice *dev, const char *typename)
     sec_bus->map_irq = br->map_irq ? br->map_irq : pci_swizzle_map_irq_fn;
     sec_bus->address_space_mem = &br->address_space_mem;
     memory_region_init(&br->address_space_mem, OBJECT(br), "pci_bridge_pci", UINT64_MAX);
+    address_space_init(&br->as_mem, &br->address_space_mem, "pci_bridge_pci");
     sec_bus->address_space_io = &br->address_space_io;
     memory_region_init(&br->address_space_io, OBJECT(br), "pci_bridge_io",
                        4 * GiB);
@@ -399,6 +400,7 @@ void pci_bridge_exitfn(PCIDevice *pci_dev)
     PCIBridge *s = PCI_BRIDGE(pci_dev);
     assert(QLIST_EMPTY(&s->sec_bus.child));
     QLIST_REMOVE(&s->sec_bus, sibling);
+    address_space_destroy(&s->as_mem);
     pci_bridge_region_del(s, &s->windows);
     pci_bridge_region_cleanup(s, &s->windows);
     /* object_unparent() is called automatically during device deletion */
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 4d832fe845..502b9751dc 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -2180,6 +2180,8 @@ static void virtio_pci_realize(PCIDevice *pci_dev, Error **errp)
                        /* PCI BAR regions must be powers of 2 */
                        pow2ceil(proxy->notify.offset + proxy->notify.size));
 
+    address_space_init(&proxy->modern_as, &proxy->modern_bar, "virtio-pci");
+
     if (proxy->disable_legacy == ON_OFF_AUTO_AUTO) {
         proxy->disable_legacy = pcie_port ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
     }
@@ -2275,6 +2277,7 @@ static void virtio_pci_exit(PCIDevice *pci_dev)
         pci_is_express(pci_dev)) {
         pcie_aer_exit(pci_dev);
     }
+    address_space_destroy(&proxy->modern_as);
 }
 
 static void virtio_pci_reset(DeviceState *qdev)
diff --git a/include/hw/pci/pci_bridge.h b/include/hw/pci/pci_bridge.h
index 5cd452115a..2e807760e4 100644
--- a/include/hw/pci/pci_bridge.h
+++ b/include/hw/pci/pci_bridge.h
@@ -72,6 +72,7 @@ struct PCIBridge {
      */
     MemoryRegion address_space_mem;
     MemoryRegion address_space_io;
+    AddressSpace as_mem;
 
     PCIBridgeWindows windows;
 
diff --git a/include/hw/virtio/virtio-pci.h b/include/hw/virtio/virtio-pci.h
index 9e67ba38c7..fddceaaa47 100644
--- a/include/hw/virtio/virtio-pci.h
+++ b/include/hw/virtio/virtio-pci.h
@@ -147,6 +147,7 @@ struct VirtIOPCIProxy {
     };
     MemoryRegion modern_bar;
     MemoryRegion io_bar;
+    AddressSpace modern_as;
     uint32_t legacy_io_bar_idx;
     uint32_t msix_bar_idx;
     uint32_t modern_io_bar_idx;
-- 
2.34.1


