Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79ED4C25B7C
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 09:58:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9ihN-0004Vs-RM; Wed, 22 May 2024 05:55:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9ihI-000400-EQ
 for qemu-devel@nongnu.org; Wed, 22 May 2024 05:55:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9ihG-0001m5-IV
 for qemu-devel@nongnu.org; Wed, 22 May 2024 05:55:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716371745;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jiXazmRRX1pWr+z+tk9NOgQnGvpDX8eXjR2eT/8ADoM=;
 b=RXaw5olRa0pfXgyykDQSQRLdSWKHid6p3lpOIbtRTY9Vo9BtkBdTCUwF8GzMAfJsYY9siI
 Qyr10twE/1O8rs0cBT79rZVOXhw2QmlwwOgLE0AbF6n2iJAJe7uLhEtmJEBr/TPDzHrVJa
 uRrZ6paLJSTae+fQOMAQBj/U/Bj34I4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-397-kLtksRauPqaz_tuYysGRVA-1; Wed,
 22 May 2024 05:55:44 -0400
X-MC-Unique: kLtksRauPqaz_tuYysGRVA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B58AA29AA3B2;
 Wed, 22 May 2024 09:55:43 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.133])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 935DD2818;
 Wed, 22 May 2024 09:55:42 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 38/47] vfio/pci: Make vfio_pci_relocate_msix() and
 vfio_msix_early_setup() return a bool
Date: Wed, 22 May 2024 11:54:33 +0200
Message-ID: <20240522095442.195243-39-clg@redhat.com>
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

Since vfio_pci_relocate_msix() and vfio_msix_early_setup() takes
an 'Error **' argument, best practices suggest to return a bool.
See the qapi/error.h Rules section.

By this chance, pass errp directly to vfio_msix_early_setup() to avoid
calling error_propagate().

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/pci.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 12fb534d796f52724f365746c9c8c2491265f03d..4fb5fd0c9f61627c402164fc4bed1868540350e0 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -1450,13 +1450,13 @@ static void vfio_pci_fixup_msix_region(VFIOPCIDevice *vdev)
     }
 }
 
-static void vfio_pci_relocate_msix(VFIOPCIDevice *vdev, Error **errp)
+static bool vfio_pci_relocate_msix(VFIOPCIDevice *vdev, Error **errp)
 {
     int target_bar = -1;
     size_t msix_sz;
 
     if (!vdev->msix || vdev->msix_relo == OFF_AUTOPCIBAR_OFF) {
-        return;
+        return true;
     }
 
     /* The actual minimum size of MSI-X structures */
@@ -1479,7 +1479,7 @@ static void vfio_pci_relocate_msix(VFIOPCIDevice *vdev, Error **errp)
         if (target_bar < 0) {
             error_setg(errp, "No automatic MSI-X relocation available for "
                        "device %04x:%04x", vdev->vendor_id, vdev->device_id);
-            return;
+            return false;
         }
     } else {
         target_bar = (int)(vdev->msix_relo - OFF_AUTOPCIBAR_BAR0);
@@ -1489,7 +1489,7 @@ static void vfio_pci_relocate_msix(VFIOPCIDevice *vdev, Error **errp)
     if (vdev->bars[target_bar].ioport) {
         error_setg(errp, "Invalid MSI-X relocation BAR %d, "
                    "I/O port BAR", target_bar);
-        return;
+        return false;
     }
 
     /* Cannot use a BAR in the "shadow" of a 64-bit BAR */
@@ -1497,7 +1497,7 @@ static void vfio_pci_relocate_msix(VFIOPCIDevice *vdev, Error **errp)
          target_bar > 0 && vdev->bars[target_bar - 1].mem64) {
         error_setg(errp, "Invalid MSI-X relocation BAR %d, "
                    "consumed by 64-bit BAR %d", target_bar, target_bar - 1);
-        return;
+        return false;
     }
 
     /* 2GB max size for 32-bit BARs, cannot double if already > 1G */
@@ -1505,7 +1505,7 @@ static void vfio_pci_relocate_msix(VFIOPCIDevice *vdev, Error **errp)
         !vdev->bars[target_bar].mem64) {
         error_setg(errp, "Invalid MSI-X relocation BAR %d, "
                    "no space to extend 32-bit BAR", target_bar);
-        return;
+        return false;
     }
 
     /*
@@ -1540,6 +1540,7 @@ static void vfio_pci_relocate_msix(VFIOPCIDevice *vdev, Error **errp)
 
     trace_vfio_msix_relo(vdev->vbasedev.name,
                          vdev->msix->table_bar, vdev->msix->table_offset);
+    return true;
 }
 
 /*
@@ -1550,7 +1551,7 @@ static void vfio_pci_relocate_msix(VFIOPCIDevice *vdev, Error **errp)
  * need to first look for where the MSI-X table lives.  So we
  * unfortunately split MSI-X setup across two functions.
  */
-static void vfio_msix_early_setup(VFIOPCIDevice *vdev, Error **errp)
+static bool vfio_msix_early_setup(VFIOPCIDevice *vdev, Error **errp)
 {
     uint8_t pos;
     uint16_t ctrl;
@@ -1562,25 +1563,25 @@ static void vfio_msix_early_setup(VFIOPCIDevice *vdev, Error **errp)
 
     pos = pci_find_capability(&vdev->pdev, PCI_CAP_ID_MSIX);
     if (!pos) {
-        return;
+        return true;
     }
 
     if (pread(fd, &ctrl, sizeof(ctrl),
               vdev->config_offset + pos + PCI_MSIX_FLAGS) != sizeof(ctrl)) {
         error_setg_errno(errp, errno, "failed to read PCI MSIX FLAGS");
-        return;
+        return false;
     }
 
     if (pread(fd, &table, sizeof(table),
               vdev->config_offset + pos + PCI_MSIX_TABLE) != sizeof(table)) {
         error_setg_errno(errp, errno, "failed to read PCI MSIX TABLE");
-        return;
+        return false;
     }
 
     if (pread(fd, &pba, sizeof(pba),
               vdev->config_offset + pos + PCI_MSIX_PBA) != sizeof(pba)) {
         error_setg_errno(errp, errno, "failed to read PCI MSIX PBA");
-        return;
+        return false;
     }
 
     ctrl = le16_to_cpu(ctrl);
@@ -1598,7 +1599,7 @@ static void vfio_msix_early_setup(VFIOPCIDevice *vdev, Error **errp)
     if (ret < 0) {
         error_setg_errno(errp, -ret, "failed to get MSI-X irq info");
         g_free(msix);
-        return;
+        return false;
     }
 
     msix->noresize = !!(irq_info.flags & VFIO_IRQ_INFO_NORESIZE);
@@ -1630,7 +1631,7 @@ static void vfio_msix_early_setup(VFIOPCIDevice *vdev, Error **errp)
             error_setg(errp, "hardware reports invalid configuration, "
                        "MSIX PBA outside of specified BAR");
             g_free(msix);
-            return;
+            return false;
         }
     }
 
@@ -1641,7 +1642,7 @@ static void vfio_msix_early_setup(VFIOPCIDevice *vdev, Error **errp)
 
     vfio_pci_fixup_msix_region(vdev);
 
-    vfio_pci_relocate_msix(vdev, errp);
+    return vfio_pci_relocate_msix(vdev, errp);
 }
 
 static int vfio_msix_setup(VFIOPCIDevice *vdev, int pos, Error **errp)
@@ -3130,9 +3131,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
 
     vfio_bars_prepare(vdev);
 
-    vfio_msix_early_setup(vdev, &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!vfio_msix_early_setup(vdev, errp)) {
         goto error;
     }
 
-- 
2.45.1


