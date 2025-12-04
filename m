Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26141D2444B
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 17:31:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRDA1-0001lK-0p; Thu, 04 Dec 2025 12:30:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vRD9p-0001k2-R9
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 12:30:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vRD9l-0000Xi-Mh
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 12:30:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764869414;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ha9Yhi1RnCsOPopMfTBzvDZYyFAfAljzcfLsCRvtCek=;
 b=dA5sXBuipQ+BUEHZgEWIBsDuWvk4djNZDwcnOyqb7mjq9AESkjBwC4lCQSkNA9rngqpGOW
 qtroWXrTnVfswE9dqm54dnRMSIwcS5ccCN2F8PzXpZBXNidRwitLqKVZmU2BzvBi0bOOv4
 niv46xP8V7IotNBCNvjvTz/+/and/MM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-517-uDa5_pNmO8Cc5_IBls5M_w-1; Thu,
 04 Dec 2025 12:30:13 -0500
X-MC-Unique: uDa5_pNmO8Cc5_IBls5M_w-1
X-Mimecast-MFC-AGG-ID: uDa5_pNmO8Cc5_IBls5M_w_1764869412
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2C9151956046; Thu,  4 Dec 2025 17:30:12 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.45.225.150])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4DC6D1800577; Thu,  4 Dec 2025 17:30:08 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, mst@redhat.com,
 akihiko.odaki@daynix.com, qemu-stable@nongnu.org
Subject: [PATCH] virtio: Fix crash when sriov-pf is set for non-PCI-Express
 device
Date: Thu,  4 Dec 2025 18:26:57 +0100
Message-ID: <20251204172657.174391-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
---
 hw/virtio/virtio-pci.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 99cb30fe595..c9a162728cd 100644
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
2.52.0


