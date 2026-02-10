Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB851EA8105
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 12:19:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpme8-0000tw-CQ; Tue, 10 Feb 2026 07:15:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vpme2-0000pY-HX; Tue, 10 Feb 2026 07:15:07 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vpme0-0008Vd-Lt; Tue, 10 Feb 2026 07:15:06 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 3184E187DA4;
 Tue, 10 Feb 2026 15:13:52 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id C18EA360CC6;
 Tue, 10 Feb 2026 15:14:47 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.1 66/78] virtio: Fix crash when sriov-pf is set for
 non-PCI-Express device
Date: Tue, 10 Feb 2026 15:14:19 +0300
Message-ID: <20260210121438.67781-10-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.1-20260210151332@cover.tls.msk.ru>
References: <qemu-stable-10.2.1-20260210151332@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Kevin Wolf <kwolf@redhat.com>

Setting the sriov-pf property on devices that aren't PCI Express causes
an assertion failure:

    $ qemu-system-x86_64 \
        -blockdev null-co,node-name=null \
        -blockdev null-co,node-name=null2 \
        -device virtio-blk,drive=null,id=pf \
        -device virtio-blk,sriov-pf=pf,drive=null2
    qemu-system-x86_64: ../hw/pci/pcie.c:1062: void pcie_add_capability(PCIDevice *, uint16_t, uint8_t, uint16_t, uint16_t): Assertion `offset >= PCI_CONFIG_SPACE_SIZE' failed.

This is because proxy->last_pcie_cap_offset is only initialised to a
non-zero value in virtio_pci_realize() if it's a PCI Express device, and
then virtio_pci_device_plugged() still tries to use it.

To fix this, just skip the SR-IOV code for !pci_is_express(). Then the
next thing pci_qdev_realize() does is call pcie_sriov_register_device(),
which returns the appropriate error.

Cc: qemu-stable@nongnu.org
Fixes: d0c280d3fac6 ('pcie_sriov: Make a PCI device with user-created VF ARI-capable')
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20251204172657.174391-1-kwolf@redhat.com>
(cherry picked from commit 623db856476806124e9ae45fbc39e75012261570)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 99cb30fe59..c9a162728c 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -2183,15 +2183,17 @@ static void virtio_pci_device_plugged(DeviceState *d, Error **errp)
                          PCI_BASE_ADDRESS_SPACE_IO, &proxy->bar);
     }
 
-    if (pci_is_vf(&proxy->pci_dev)) {
-        pcie_ari_init(&proxy->pci_dev, proxy->last_pcie_cap_offset);
-        proxy->last_pcie_cap_offset += PCI_ARI_SIZEOF;
-    } else {
-        res = pcie_sriov_pf_init_from_user_created_vfs(
-            &proxy->pci_dev, proxy->last_pcie_cap_offset, errp);
-        if (res > 0) {
-            proxy->last_pcie_cap_offset += res;
-            virtio_add_feature(&vdev->host_features, VIRTIO_F_SR_IOV);
+    if (pci_is_express(&proxy->pci_dev)) {
+        if (pci_is_vf(&proxy->pci_dev)) {
+            pcie_ari_init(&proxy->pci_dev, proxy->last_pcie_cap_offset);
+            proxy->last_pcie_cap_offset += PCI_ARI_SIZEOF;
+        } else {
+            res = pcie_sriov_pf_init_from_user_created_vfs(
+                &proxy->pci_dev, proxy->last_pcie_cap_offset, errp);
+            if (res > 0) {
+                proxy->last_pcie_cap_offset += res;
+                virtio_add_feature(&vdev->host_features, VIRTIO_F_SR_IOV);
+            }
         }
     }
 }
-- 
2.47.3


