Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C25CC25B7A
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 09:58:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9ihP-0004kE-RY; Wed, 22 May 2024 05:55:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9ihJ-000458-M6
 for qemu-devel@nongnu.org; Wed, 22 May 2024 05:55:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9ihH-0001mW-Qi
 for qemu-devel@nongnu.org; Wed, 22 May 2024 05:55:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716371747;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wrt6okKOnmpVXT/eryr4wzTcDbGf2/zr75j5q/NxDYM=;
 b=B7QZHUX9dXKcB19BfukZ/G1GeSk9fTVriFJqVxp5wemQ5NuCte5LeMfdCOBZ1WyHCQZkVi
 yBY1QcwB0u4PDIH/8ILdqRv23wg7xU4td2uKS7zLM9KQ9cy85sgHKBylnoxYTtvbu8tgeJ
 L6edKthMN4fyA6/bv7vi7uTaRFWUh3w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-387-PsrgeyJBPFan7zxVji58Xw-1; Wed, 22 May 2024 05:55:45 -0400
X-MC-Unique: PsrgeyJBPFan7zxVji58Xw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1705C80118E;
 Wed, 22 May 2024 09:55:45 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.133])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EABB451BF;
 Wed, 22 May 2024 09:55:43 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 39/47] vfio/pci: Make vfio_populate_device() return a bool
Date: Wed, 22 May 2024 11:54:34 +0200
Message-ID: <20240522095442.195243-40-clg@redhat.com>
In-Reply-To: <20240522095442.195243-1-clg@redhat.com>
References: <20240522095442.195243-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

Since vfio_populate_device() takes an 'Error **' argument,
best practices suggest to return a bool. See the qapi/error.h
Rules section.

By this chance, pass errp directly to vfio_populate_device() to
avoid calling error_propagate().

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/pci.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 4fb5fd0c9f61627c402164fc4bed1868540350e0..46d3c618596d95266543e9a0ebc65c04d9a7cc5d 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2740,7 +2740,7 @@ int vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp)
     return 0;
 }
 
-static void vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
+static bool vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
 {
     VFIODevice *vbasedev = &vdev->vbasedev;
     struct vfio_region_info *reg_info;
@@ -2750,18 +2750,18 @@ static void vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
     /* Sanity check device */
     if (!(vbasedev->flags & VFIO_DEVICE_FLAGS_PCI)) {
         error_setg(errp, "this isn't a PCI device");
-        return;
+        return false;
     }
 
     if (vbasedev->num_regions < VFIO_PCI_CONFIG_REGION_INDEX + 1) {
         error_setg(errp, "unexpected number of io regions %u",
                    vbasedev->num_regions);
-        return;
+        return false;
     }
 
     if (vbasedev->num_irqs < VFIO_PCI_MSIX_IRQ_INDEX + 1) {
         error_setg(errp, "unexpected number of irqs %u", vbasedev->num_irqs);
-        return;
+        return false;
     }
 
     for (i = VFIO_PCI_BAR0_REGION_INDEX; i < VFIO_PCI_ROM_REGION_INDEX; i++) {
@@ -2773,7 +2773,7 @@ static void vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
 
         if (ret) {
             error_setg_errno(errp, -ret, "failed to get region %d info", i);
-            return;
+            return false;
         }
 
         QLIST_INIT(&vdev->bars[i].quirks);
@@ -2783,7 +2783,7 @@ static void vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
                                VFIO_PCI_CONFIG_REGION_INDEX, &reg_info);
     if (ret) {
         error_setg_errno(errp, -ret, "failed to get config info");
-        return;
+        return false;
     }
 
     trace_vfio_populate_device_config(vdev->vbasedev.name,
@@ -2804,7 +2804,7 @@ static void vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
         if (ret) {
             error_append_hint(errp, "device does not support "
                               "requested feature x-vga\n");
-            return;
+            return false;
         }
     }
 
@@ -2821,6 +2821,8 @@ static void vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
                     "Could not enable error recovery for the device",
                     vbasedev->name);
     }
+
+    return true;
 }
 
 static void vfio_pci_put_device(VFIOPCIDevice *vdev)
@@ -2977,7 +2979,6 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
     VFIOPCIDevice *vdev = VFIO_PCI(pdev);
     VFIODevice *vbasedev = &vdev->vbasedev;
     char *subsys;
-    Error *err = NULL;
     int i, ret;
     bool is_mdev;
     char uuid[UUID_STR_LEN];
@@ -3036,9 +3037,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
         goto error;
     }
 
-    vfio_populate_device(vdev, &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!vfio_populate_device(vdev, errp)) {
         goto error;
     }
 
-- 
2.45.1


