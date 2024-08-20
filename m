Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44D90C5320E
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 11:57:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgNTu-0004FB-3M; Tue, 20 Aug 2024 07:56:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaoshiyuan@baidu.com>)
 id 1sgNTs-0004Da-AG
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 07:56:56 -0400
Received: from mx24.baidu.com ([111.206.215.185] helo=baidu.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaoshiyuan@baidu.com>)
 id 1sgNTp-0001bu-6C
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 07:56:56 -0400
To: "Michael S. Tsirkin" <mst@redhat.com>, Stefano Garzarella
 <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>, <zuoboqun@baidu.com>
CC: <qemu-devel@nongnu.org>, <gaoshiyuan@baidu.com>
Subject: [PATCH V2 1/1] virtio-pci: Add lookup subregion of VirtIOPCIRegion MR
Date: Tue, 20 Aug 2024 19:56:31 +0800
Message-ID: <20240820115631.52522-1-gaoshiyuan@baidu.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.127.73.8]
X-ClientProxiedBy: BJHW-Mail-Ex13.internal.baidu.com (10.127.64.36) To
 bjkjy-mail-ex26.internal.baidu.com (172.31.50.42)
X-FEAS-Client-IP: 172.31.51.54
X-FE-Policy-ID: 52:10:53:SYSTEM
Received-SPF: pass client-ip=111.206.215.185;
 envelope-from=gaoshiyuan@baidu.com; helo=baidu.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Reply-to:  Gao Shiyuan <gaoshiyuan@baidu.com>
From:  Gao Shiyuan via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

When VHOST_USER_PROTOCOL_F_HOST_NOTIFIER feature negotiated and
virtio_queue_set_host_notifier_mr success on system blk
device's queue, the VM can't load MBR if the notify region's
address above 4GB.

Assign the address of notify region in the modern bar above 4G, the vp_notify
in SeaBIOS will use PCI Cfg Capability to write notify region. This will trap
into QEMU and be handled by the host bridge when we don't enable mmconfig.
QEMU will call virtio_write_config and since it writes to the BAR region
through the PCI Cfg Capability, it will call virtio_address_space_write.

virtio_queue_set_host_notifier_mr add host notifier subregion of notify region
MR, QEMU need write the mmap address instead of eventfd notify the hardware
accelerator at the vhost-user backend. So virtio_address_space_lookup in
virtio_address_space_write need return a host-notifier subregion of notify MR
instead of notify MR.

Add lookup subregion of VirtIOPCIRegion MR instead of only lookup container MR.

Fixes: a93c8d8 ("virtio-pci: Replace modern_as with direct access to modern_bar")

Co-developed-by: Zuo Boqun <zuoboqun@baidu.com>
Signed-off-by: Gao Shiyuan <gaoshiyuan@baidu.com>
Signed-off-by: Zuo Boqun <zuoboqun@baidu.com>
---
 hw/virtio/virtio-pci.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

---
v1 -> v2:
* modify commit message
* replace direct iteration over subregions with memory_region_find.

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 9534730bba..5d2d27a6a3 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -610,19 +610,29 @@ static MemoryRegion *virtio_address_space_lookup(VirtIOPCIProxy *proxy,
 {
     int i;
     VirtIOPCIRegion *reg;
+    MemoryRegion *mr = NULL;
+    MemoryRegionSection mrs;
 
     for (i = 0; i < ARRAY_SIZE(proxy->regs); ++i) {
         reg = &proxy->regs[i];
         if (*off >= reg->offset &&
             *off + len <= reg->offset + reg->size) {
-            *off -= reg->offset;
-            return &reg->mr;
+            mrs = memory_region_find(&reg->mr, *off - reg->offset, len);
+            if (!mrs.mr) {
+                error_report("Failed to find memory region for address"
+                             "0x%" PRIx64 "", *off);
+                return NULL;
+            }
+            *off = mrs.offset_within_region;
+            memory_region_unref(mrs.mr);
+            return mrs.mr;
         }
     }
 
     return NULL;
 }
 
+
 /* Below are generic functions to do memcpy from/to an address space,
  * without byteswaps, with input validation.
  *
-- 
2.39.3 (Apple Git-146)


