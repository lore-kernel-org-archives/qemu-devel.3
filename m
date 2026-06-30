Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E2FEC44501
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 04:33:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weQ8g-0006n3-4f; Tue, 30 Jun 2026 00:32:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1weQ8e-0006mA-G4
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 00:32:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1weQ8c-0003Es-EO
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 00:32:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782793917;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nS1YYHXSFyR4F9dbWX1Hiw8eryvGvQNobJeauXWMRgs=;
 b=WI3wYo5RAZ2P8QY3wFYiUiGQ6a8jHj1ytm1SXbwH1JDds97XpAtdby4pLGM6Oei0wqTjYe
 8l4smZjQOsw9JQt3RojbMXirhCZepq0BMvq3ny+btMTWFUw0SmBQGl2WSwjC8fln5Q0o3n
 vTEWbcFkFMGxx9hHvSMub2+lcqVNXS8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-567-2iorELukP2KTiDmDgnscdA-1; Tue,
 30 Jun 2026 00:31:55 -0400
X-MC-Unique: 2iorELukP2KTiDmDgnscdA-1
X-Mimecast-MFC-AGG-ID: 2iorELukP2KTiDmDgnscdA_1782793914
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BD0A019560B5; Tue, 30 Jun 2026 04:31:54 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.58])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 43FB31956045; Tue, 30 Jun 2026 04:31:53 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Nathan Chen <nathanc@nvidia.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 21/23] vfio/pci: Add ats property
Date: Tue, 30 Jun 2026 06:31:05 +0200
Message-ID: <20260630043107.1511076-22-clg@redhat.com>
In-Reply-To: <20260630043107.1511076-1-clg@redhat.com>
References: <20260630043107.1511076-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Nathan Chen <nathanc@nvidia.com>

Add an "ats" OnOffAuto property to vfio-pci. When the device has an ATS
extended capability in config space but we should not expose it (ats=off,
or ats=auto and kernel reports IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED), mask
the capability so the guest does not see it.

If ATS is explicitly requested but not supported by the kernel, fail
device realize.

This aligns with the kernel's per-device effective ATS reporting and allows
vfio-pci to mask ATS when the host kernel reports ATS as unsupported.

Emit a warning when ats=on is requested but the physical device does not
advertise ATS, since ATS cannot be exposed to the guest in this case.

Emit a warning when ats=auto, ats cap is present on the physical device,
but kernel reports ATS as unsupported.

Suggested-by: Shameer Kolothum <skolothumtho@nvidia.com>
Signed-off-by: Nathan Chen <nathanc@nvidia.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260623204943.989903-3-nathanc@nvidia.com
Reviewed-by: Shameer Kolothum <skolothumtho@nvidia.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/pci.h |  1 +
 hw/vfio/pci.c | 88 ++++++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 85 insertions(+), 4 deletions(-)

diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index cf56711587058b8cf5197945755fff2456168c00..fe52e9df6e67707c9899d418b0261afeedf4aab2 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -188,6 +188,7 @@ struct VFIOPCIDevice {
     bool clear_parent_atomics_on_exit;
     bool skip_vsc_check;
     uint16_t vpasid_cap_offset;
+    OnOffAuto ats;
     VFIODisplay *dpy;
     Notifier irqchip_change_notifier;
     VFIOPCICPR cpr;
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 6b04c6f94f9ade765e236d457e4828ac6199680a..c7f163399f8fbcc4ff70819a0d67879eb26980f9 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2548,10 +2548,53 @@ static bool vfio_pci_synthesize_pasid_cap(VFIOPCIDevice *vdev, Error **errp)
     return true;
 }
 
-static void vfio_add_ext_cap(VFIOPCIDevice *vdev)
+/*
+ * Determine whether ATS capability should be advertised for @vdev, based on
+ * whether it was enabled on the command line and whether it is supported
+ * according to the kernel.
+ *
+ * Store whether ATS capability should be advertised in @ats_needed.
+ *
+ * Returns false only when ats=on is explicitly requested but the kernel
+ * reports it is not supported. Returns true in all other cases.
+ */
+static bool vfio_pci_ats_requested_and_supported(VFIOPCIDevice *vdev,
+                                                 bool *ats_needed, Error **errp)
+{
+    HostIOMMUDevice *hiod = vdev->vbasedev.hiod;
+    HostIOMMUDeviceClass *hiodc;
+    bool ats_supported;
+    *ats_needed = false;
+
+    if (vdev->ats == ON_OFF_AUTO_OFF) {
+        return true;
+    }
+
+    *ats_needed = true;
+    if (!hiod) {
+        return true;
+    }
+    hiodc = HOST_IOMMU_DEVICE_GET_CLASS(hiod);
+    if (!hiodc || !hiodc->support_ats) {
+        return true;
+    }
+
+    ats_supported = hiodc->support_ats(hiod);
+    if (vdev->ats == ON_OFF_AUTO_ON && !ats_supported) {
+        error_setg(errp, "vfio-pci: ATS requested but not supported by kernel");
+        *ats_needed = false;
+        return false;
+    }
+
+    *ats_needed = ats_supported;
+    return true;
+}
+
+static void vfio_add_ext_cap(VFIOPCIDevice *vdev, bool ats_needed)
 {
     PCIDevice *pdev = PCI_DEVICE(vdev);
     bool pasid_cap_added = false;
+    bool ats_cap_present = false;
     Error *err = NULL;
     uint32_t header;
     uint16_t cap_id, next, size;
@@ -2637,7 +2680,19 @@ static void vfio_add_ext_cap(VFIOPCIDevice *vdev)
          */
         case PCI_EXT_CAP_ID_PASID:
             pasid_cap_added = true;
-            /* fallthrough */
+            pcie_add_capability(pdev, cap_id, cap_ver, next, size);
+            break;
+        case PCI_EXT_CAP_ID_ATS:
+            ats_cap_present = true;
+            /*
+             * If ATS is requested and supported according to the kernel, add
+             * the ATS capability. If not supported according to the kernel or
+             * disabled on the qemu command line, omit the ATS cap.
+             */
+            if (ats_needed) {
+                pcie_add_capability(pdev, cap_id, cap_ver, next, size);
+            }
+            break;
         default:
             pcie_add_capability(pdev, cap_id, cap_ver, next, size);
         }
@@ -2648,6 +2703,16 @@ static void vfio_add_ext_cap(VFIOPCIDevice *vdev)
         error_report_err(err);
     }
 
+    if (vdev->ats == ON_OFF_AUTO_ON && !ats_cap_present) {
+        warn_report("vfio-pci: ats=on requested, but host device has no "
+                    "ATS extended capability");
+    }
+
+    if (vdev->ats == ON_OFF_AUTO_AUTO && ats_cap_present && !ats_needed) {
+        warn_report("vfio-pci: host kernel reports ATS unsupported; "
+                    "ATS capability will be masked");
+    }
+
     /* Cleanup chain head ID if necessary */
     if (pci_get_word(pdev->config + PCI_CONFIG_SPACE_SIZE) == 0xFFFF) {
         pci_set_word(pdev->config + PCI_CONFIG_SPACE_SIZE, 0);
@@ -2659,6 +2724,7 @@ static void vfio_add_ext_cap(VFIOPCIDevice *vdev)
 bool vfio_pci_add_capabilities(VFIOPCIDevice *vdev, Error **errp)
 {
     PCIDevice *pdev = PCI_DEVICE(vdev);
+    bool ats_needed = false;
 
     if (!(pdev->config[PCI_STATUS] & PCI_STATUS_CAP_LIST) ||
         !pdev->config[PCI_CAPABILITY_LIST]) {
@@ -2669,7 +2735,11 @@ bool vfio_pci_add_capabilities(VFIOPCIDevice *vdev, Error **errp)
         return false;
     }
 
-    vfio_add_ext_cap(vdev);
+    if (!vfio_pci_ats_requested_and_supported(vdev, &ats_needed, errp)) {
+        return false;
+    }
+
+    vfio_add_ext_cap(vdev, ats_needed);
     return true;
 }
 
@@ -3819,6 +3889,7 @@ static const Property vfio_pci_properties[] = {
     DEFINE_PROP_BOOL("skip-vsc-check", VFIOPCIDevice, skip_vsc_check, true),
     DEFINE_PROP_UINT16("x-vpasid-cap-offset", VFIOPCIDevice,
                        vpasid_cap_offset, 0),
+    DEFINE_PROP_ON_OFF_AUTO("ats", VFIOPCIDevice, ats, ON_OFF_AUTO_AUTO),
 };
 
 static void vfio_pci_set_fd(Object *obj, const char *str, Error **errp)
@@ -3970,13 +4041,22 @@ static void vfio_pci_class_init(ObjectClass *klass, const void *data)
                                           "destination when doing live "
                                           "migration of device state via "
                                           "multifd channels");
-   object_class_property_set_description(klass, /* 11.0 */
+    object_class_property_set_description(klass, /* 11.0 */
                                           "x-vpasid-cap-offset",
                                           "PCIe extended configuration space offset at which to place a "
                                           "synthetic PASID extended capability when PASID is enabled via "
                                           "a vIOMMU. A value of 0 (default) places the capability at the "
                                           "end of the extended configuration space. The offset must be "
                                           "4-byte aligned and within the PCIe extended configuration space");
+    object_class_property_set_description(klass, /* 11.1 */
+                                          "ats",
+                                          "Control guest visibility of the ATS PCIe extended capability. "
+                                          "Valid values are on, off, and auto (default). "
+                                          "'off' always masks ATS. "
+                                          "'on' requires ATS support for the device and fails realize if the "
+                                          "host kernel reports ATS as unavailable for this device. "
+                                          "'auto' masks ATS only when the host kernel reports "
+                                          "ATS as unavailable");
 }
 
 static const TypeInfo vfio_pci_info = {
-- 
2.54.0


