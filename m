Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46B1BC369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 08:54:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8ElO-0000LU-VA; Fri, 25 Apr 2025 04:50:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u8Ekg-0007SV-3d
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 04:49:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u8Ekd-0003Ov-GU
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 04:49:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745570978;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nwQ7525kQm3xWKABt9b1aTs7VzJeYwXUVZDlkEh38yY=;
 b=cr+MEgok3+H+8N0hFNsDNoIWTgaKjVpvzuxDWfiseug49YEST/TKSvmNF+TlLWreoi/hab
 OKXN4LfAxysMxeSoSWAnb0KEv3b2DrqJ6m478M+1vzuBkypsIEdt8Ef+aNNK0pf/WqTgY0
 4K4fUA8UUIKDSRh+0wP3dZcaMja94go=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-13-2h5xC0EyOLWx74A4Btz_dw-1; Fri,
 25 Apr 2025 04:49:35 -0400
X-MC-Unique: 2h5xC0EyOLWx74A4Btz_dw-1
X-Mimecast-MFC-AGG-ID: 2h5xC0EyOLWx74A4Btz_dw_1745570974
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4B8441800264; Fri, 25 Apr 2025 08:49:34 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.33.65])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CD77530001A2; Fri, 25 Apr 2025 08:49:31 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 John Levon <john.levon@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 50/50] vfio: refactor out vfio_pci_config_setup()
Date: Fri, 25 Apr 2025 10:46:43 +0200
Message-ID: <20250425084644.102196-51-clg@redhat.com>
In-Reply-To: <20250425084644.102196-1-clg@redhat.com>
References: <20250425084644.102196-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.84,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: John Levon <john.levon@nutanix.com>

Refactor the PCI config setup code out of vfio_realize() for
readability.

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
Link: https://lore.kernel.org/qemu-devel/20250409134814.478903-3-john.levon@nutanix.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/pci.c | 176 +++++++++++++++++++++++++++-----------------------
 1 file changed, 94 insertions(+), 82 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 27cc6426a54080dfaf5b9a50e4e57567bdeb9063..4a9484dfbe85085386ef90613acd7461dffc4903 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2962,6 +2962,99 @@ static void vfio_unregister_req_notifier(VFIOPCIDevice *vdev)
     vdev->req_enabled = false;
 }
 
+static bool vfio_pci_config_setup(VFIOPCIDevice *vdev, Error **errp)
+{
+    PCIDevice *pdev = &vdev->pdev;
+    VFIODevice *vbasedev = &vdev->vbasedev;
+
+    /* vfio emulates a lot for us, but some bits need extra love */
+    vdev->emulated_config_bits = g_malloc0(vdev->config_size);
+
+    /* QEMU can choose to expose the ROM or not */
+    memset(vdev->emulated_config_bits + PCI_ROM_ADDRESS, 0xff, 4);
+    /* QEMU can also add or extend BARs */
+    memset(vdev->emulated_config_bits + PCI_BASE_ADDRESS_0, 0xff, 6 * 4);
+
+    /*
+     * The PCI spec reserves vendor ID 0xffff as an invalid value.  The
+     * device ID is managed by the vendor and need only be a 16-bit value.
+     * Allow any 16-bit value for subsystem so they can be hidden or changed.
+     */
+    if (vdev->vendor_id != PCI_ANY_ID) {
+        if (vdev->vendor_id >= 0xffff) {
+            error_setg(errp, "invalid PCI vendor ID provided");
+            return false;
+        }
+        vfio_add_emulated_word(vdev, PCI_VENDOR_ID, vdev->vendor_id, ~0);
+        trace_vfio_pci_emulated_vendor_id(vbasedev->name, vdev->vendor_id);
+    } else {
+        vdev->vendor_id = pci_get_word(pdev->config + PCI_VENDOR_ID);
+    }
+
+    if (vdev->device_id != PCI_ANY_ID) {
+        if (vdev->device_id > 0xffff) {
+            error_setg(errp, "invalid PCI device ID provided");
+            return false;
+        }
+        vfio_add_emulated_word(vdev, PCI_DEVICE_ID, vdev->device_id, ~0);
+        trace_vfio_pci_emulated_device_id(vbasedev->name, vdev->device_id);
+    } else {
+        vdev->device_id = pci_get_word(pdev->config + PCI_DEVICE_ID);
+    }
+
+    if (vdev->sub_vendor_id != PCI_ANY_ID) {
+        if (vdev->sub_vendor_id > 0xffff) {
+            error_setg(errp, "invalid PCI subsystem vendor ID provided");
+            return false;
+        }
+        vfio_add_emulated_word(vdev, PCI_SUBSYSTEM_VENDOR_ID,
+                               vdev->sub_vendor_id, ~0);
+        trace_vfio_pci_emulated_sub_vendor_id(vbasedev->name,
+                                              vdev->sub_vendor_id);
+    }
+
+    if (vdev->sub_device_id != PCI_ANY_ID) {
+        if (vdev->sub_device_id > 0xffff) {
+            error_setg(errp, "invalid PCI subsystem device ID provided");
+            return false;
+        }
+        vfio_add_emulated_word(vdev, PCI_SUBSYSTEM_ID, vdev->sub_device_id, ~0);
+        trace_vfio_pci_emulated_sub_device_id(vbasedev->name,
+                                              vdev->sub_device_id);
+    }
+
+    /* QEMU can change multi-function devices to single function, or reverse */
+    vdev->emulated_config_bits[PCI_HEADER_TYPE] =
+                                              PCI_HEADER_TYPE_MULTI_FUNCTION;
+
+    /* Restore or clear multifunction, this is always controlled by QEMU */
+    if (vdev->pdev.cap_present & QEMU_PCI_CAP_MULTIFUNCTION) {
+        vdev->pdev.config[PCI_HEADER_TYPE] |= PCI_HEADER_TYPE_MULTI_FUNCTION;
+    } else {
+        vdev->pdev.config[PCI_HEADER_TYPE] &= ~PCI_HEADER_TYPE_MULTI_FUNCTION;
+    }
+
+    /*
+     * Clear host resource mapping info.  If we choose not to register a
+     * BAR, such as might be the case with the option ROM, we can get
+     * confusing, unwritable, residual addresses from the host here.
+     */
+    memset(&vdev->pdev.config[PCI_BASE_ADDRESS_0], 0, 24);
+    memset(&vdev->pdev.config[PCI_ROM_ADDRESS], 0, 4);
+
+    vfio_pci_size_rom(vdev);
+
+    vfio_bars_prepare(vdev);
+
+    if (!vfio_msix_early_setup(vdev, errp)) {
+        return false;
+    }
+
+    vfio_bars_register(vdev);
+
+    return true;
+}
+
 static bool vfio_interrupt_setup(VFIOPCIDevice *vdev, Error **errp)
 {
     PCIDevice *pdev = &vdev->pdev;
@@ -3066,91 +3159,10 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
         goto error;
     }
 
-    /* vfio emulates a lot for us, but some bits need extra love */
-    vdev->emulated_config_bits = g_malloc0(vdev->config_size);
-
-    /* QEMU can choose to expose the ROM or not */
-    memset(vdev->emulated_config_bits + PCI_ROM_ADDRESS, 0xff, 4);
-    /* QEMU can also add or extend BARs */
-    memset(vdev->emulated_config_bits + PCI_BASE_ADDRESS_0, 0xff, 6 * 4);
-
-    /*
-     * The PCI spec reserves vendor ID 0xffff as an invalid value.  The
-     * device ID is managed by the vendor and need only be a 16-bit value.
-     * Allow any 16-bit value for subsystem so they can be hidden or changed.
-     */
-    if (vdev->vendor_id != PCI_ANY_ID) {
-        if (vdev->vendor_id >= 0xffff) {
-            error_setg(errp, "invalid PCI vendor ID provided");
-            goto error;
-        }
-        vfio_add_emulated_word(vdev, PCI_VENDOR_ID, vdev->vendor_id, ~0);
-        trace_vfio_pci_emulated_vendor_id(vbasedev->name, vdev->vendor_id);
-    } else {
-        vdev->vendor_id = pci_get_word(pdev->config + PCI_VENDOR_ID);
-    }
-
-    if (vdev->device_id != PCI_ANY_ID) {
-        if (vdev->device_id > 0xffff) {
-            error_setg(errp, "invalid PCI device ID provided");
-            goto error;
-        }
-        vfio_add_emulated_word(vdev, PCI_DEVICE_ID, vdev->device_id, ~0);
-        trace_vfio_pci_emulated_device_id(vbasedev->name, vdev->device_id);
-    } else {
-        vdev->device_id = pci_get_word(pdev->config + PCI_DEVICE_ID);
-    }
-
-    if (vdev->sub_vendor_id != PCI_ANY_ID) {
-        if (vdev->sub_vendor_id > 0xffff) {
-            error_setg(errp, "invalid PCI subsystem vendor ID provided");
-            goto error;
-        }
-        vfio_add_emulated_word(vdev, PCI_SUBSYSTEM_VENDOR_ID,
-                               vdev->sub_vendor_id, ~0);
-        trace_vfio_pci_emulated_sub_vendor_id(vbasedev->name,
-                                              vdev->sub_vendor_id);
-    }
-
-    if (vdev->sub_device_id != PCI_ANY_ID) {
-        if (vdev->sub_device_id > 0xffff) {
-            error_setg(errp, "invalid PCI subsystem device ID provided");
-            goto error;
-        }
-        vfio_add_emulated_word(vdev, PCI_SUBSYSTEM_ID, vdev->sub_device_id, ~0);
-        trace_vfio_pci_emulated_sub_device_id(vbasedev->name,
-                                              vdev->sub_device_id);
-    }
-
-    /* QEMU can change multi-function devices to single function, or reverse */
-    vdev->emulated_config_bits[PCI_HEADER_TYPE] =
-                                              PCI_HEADER_TYPE_MULTI_FUNCTION;
-
-    /* Restore or clear multifunction, this is always controlled by QEMU */
-    if (vdev->pdev.cap_present & QEMU_PCI_CAP_MULTIFUNCTION) {
-        vdev->pdev.config[PCI_HEADER_TYPE] |= PCI_HEADER_TYPE_MULTI_FUNCTION;
-    } else {
-        vdev->pdev.config[PCI_HEADER_TYPE] &= ~PCI_HEADER_TYPE_MULTI_FUNCTION;
-    }
-
-    /*
-     * Clear host resource mapping info.  If we choose not to register a
-     * BAR, such as might be the case with the option ROM, we can get
-     * confusing, unwritable, residual addresses from the host here.
-     */
-    memset(&vdev->pdev.config[PCI_BASE_ADDRESS_0], 0, 24);
-    memset(&vdev->pdev.config[PCI_ROM_ADDRESS], 0, 4);
-
-    vfio_pci_size_rom(vdev);
-
-    vfio_bars_prepare(vdev);
-
-    if (!vfio_msix_early_setup(vdev, errp)) {
+    if (!vfio_pci_config_setup(vdev, errp)) {
         goto error;
     }
 
-    vfio_bars_register(vdev);
-
     if (!vbasedev->mdev &&
         !pci_device_set_iommu_device(pdev, vbasedev->hiod, errp)) {
         error_prepend(errp, "Failed to set vIOMMU: ");
-- 
2.49.0


