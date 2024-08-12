Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E97AEC52D7C
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 12:23:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdU50-0006o3-49; Mon, 12 Aug 2024 08:23:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaoshiyuan@baidu.com>)
 id 1sdU4o-0006nD-8C
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 08:23:07 -0400
Received: from mx24.baidu.com ([111.206.215.185] helo=baidu.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaoshiyuan@baidu.com>)
 id 1sdU4j-0005lZ-Lv
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 08:23:05 -0400
To: "Michael S. Tsirkin" <mst@redhat.com>, Tiwei Bie <tiwei.bie@intel.com>,
 <zuoboqun@baidu.com>
CC: <qemu-devel@nongnu.org>, Gao Shiyuan <gaoshiyuan@baidu.com>
Subject: [PATCH 1/1] virtio-pci: return RAM device MR when set host notifier
 success
Date: Mon, 12 Aug 2024 20:20:27 +0800
Message-ID: <20240812122027.65600-1-gaoshiyuan@baidu.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.127.73.8]
X-ClientProxiedBy: BC-Mail-Ex13.internal.baidu.com (172.31.51.53) To
 bjkjy-mail-ex26.internal.baidu.com (172.31.50.42)
X-FEAS-Client-IP: 172.31.51.49
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

When vhost-user backend register memory region based host notifiers,
we should return RAM device MR of notify region MR's subregion in
virtio_address_space_lookup.

In seabios, it will use virtio PCI Configration Access Capability
access notify region when assign notify region above 4GB. This will
exit to QEMU and invoke virtio_address_space_write. When vhost-user
backend register memory region based host notifiers, return RAM device
MR instead of notify region MR is suitable.

Co-developed-by: Zuo Boqun <zuoboqun@baidu.com>
Signed-off-by: Gao Shiyuan <gaoshiyuan@baidu.com>
Signed-off-by: Zuo Boqun <zuoboqun@baidu.com>
---
 hw/virtio/virtio-pci.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 9534730bba..167ac9718a 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -610,13 +610,22 @@ static MemoryRegion *virtio_address_space_lookup(VirtIOPCIProxy *proxy,
 {
     int i;
     VirtIOPCIRegion *reg;
+    MemoryRegion *mr, *submr;
 
     for (i = 0; i < ARRAY_SIZE(proxy->regs); ++i) {
         reg = &proxy->regs[i];
         if (*off >= reg->offset &&
             *off + len <= reg->offset + reg->size) {
             *off -= reg->offset;
-            return &reg->mr;
+            mr = &reg->mr;
+            QTAILQ_FOREACH(submr, &mr->subregions, subregions_link) {
+                if (*off >= submr->addr &&
+                    *off + len < submr->addr + submr->size) {
+                    *off -= submr->addr;
+                    return submr;
+                }
+            }
+            return mr;
         }
     }
 
-- 
2.39.3 (Apple Git-146)


