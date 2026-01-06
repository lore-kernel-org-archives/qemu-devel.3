Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB7A8C2A073
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 06:29:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vd0Yl-0007L3-8T; Tue, 06 Jan 2026 01:28:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vd0Yd-0007FT-8L
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 01:28:43 -0500
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vd0YX-00036X-W0
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 01:28:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1767680918; x=1799216918;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=B4SFUiNS4ZBT6eaE6xNWbkXFzOzwS2oRkoe054wIUqY=;
 b=Ro9+S1mS2rB5lo0z2Qd+PQG7GN7Ey3wzla0bAxzBZO70gTf67h3BPL9J
 SyM817gx2jSyLlgmQ5vnlWNLc52LC68KAhCf5bUhbwYJlWVTPhERbeBA3
 xoubo/bDKuDvFnaZGanakMUoCUgH3zMnOfkPjbXWBT5p+u5vCHr5M4jqu
 SrEvcqmbZnTOfwz0RoJnU3OrFOnwbNvVGMxsbAfUiOMQnQYd9v/wlMAEz
 wq96P91aqBvVCVTVhIOfM088yQUP05vr/kbzTqi9RFxVIDWgvToxcZhu5
 o5mgkvKDFgbuyvePeyywhl1Zxnko3o3EhcQHIzqbzHUwrtrX5XeXvopNK w==;
X-CSE-ConnectionGUID: MFwyH5/CSzWeHo1YgIBirg==
X-CSE-MsgGUID: +59lO68GQnGDFdxns7307Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11662"; a="69025429"
X-IronPort-AV: E=Sophos;i="6.21,204,1763452800"; d="scan'208";a="69025429"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jan 2026 22:28:36 -0800
X-CSE-ConnectionGUID: dmW0eVngSw2JolVcvJiHdg==
X-CSE-MsgGUID: ZIEu7Jd5TRuQrzOWYmTk3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,204,1763452800"; d="scan'208";a="202346137"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jan 2026 22:28:32 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v10 4/4] Workaround for ERRATA_772415_SPR17
Date: Tue,  6 Jan 2026 01:28:06 -0500
Message-ID: <20260106062808.316574-5-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260106062808.316574-1-zhenzhong.duan@intel.com>
References: <20260106062808.316574-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.17;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On a system influenced by ERRATA_772415, IOMMU_HW_INFO_VTD_ERRATA_772415_SPR17
is repored by IOMMU_DEVICE_GET_HW_INFO. Due to this errata, even the readonly
range mapped on second stage page table could still be written.

Reference from 4th Gen Intel Xeon Processor Scalable Family Specification
Update, Errata Details, SPR17.
Link https://edc.intel.com/content/www/us/en/design/products-and-solutions/processors-and-chipsets/eagle-stream/sapphire-rapids-specification-update/
Backup https://cdrdv2.intel.com/v1/dl/getContent/772415

Also copied the SPR17 details from above link:
"Problem: When remapping hardware is configured by system software in
scalable mode as Nested (PGTT=011b) and with PWSNP field Set in the
PASID-table-entry, it may Set Accessed bit and Dirty bit (and Extended
Access bit if enabled) in first-stage page-table entries even when
second-stage mappings indicate that corresponding first-stage page-table
is Read-Only.

Implication: Due to this erratum, pages mapped as Read-only in second-stage
page-tables may be modified by remapping hardware Access/Dirty bit updates.

Workaround: None identified. System software enabling nested translations
for a VM should ensure that there are no read-only pages in the
corresponding second-stage mappings."

Introduce a helper vfio_device_get_host_iommu_quirk_bypass_ro to check if
readonly mappings should be bypassed.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 docs/devel/vfio-iommufd.rst      |  9 +++++++++
 include/hw/vfio/vfio-container.h |  1 +
 include/hw/vfio/vfio-device.h    |  3 +++
 hw/vfio/device.c                 | 14 ++++++++++++++
 hw/vfio/iommufd.c                |  9 ++++++++-
 hw/vfio/listener.c               |  6 ++++--
 6 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/docs/devel/vfio-iommufd.rst b/docs/devel/vfio-iommufd.rst
index cbf59924ba..0ee50339a5 100644
--- a/docs/devel/vfio-iommufd.rst
+++ b/docs/devel/vfio-iommufd.rst
@@ -181,3 +181,12 @@ otherwise below error shows:
 .. code-block:: none
 
     qemu-system-x86_64: -device vfio-pci,host=0000:02:00.0,bus=bridge1,iommufd=iommufd0: vfio 0000:02:00.0: Failed to set vIOMMU: Host device downstream to a PCI bridge is unsupported when x-flts=on
+
+If host IOMMU has ERRATA_772415_SPR17, running guest with "intel_iommu=on,sm_off"
+is unsupported, kexec or reboot guest from "intel_iommu=on,sm_on" to
+"intel_iommu=on,sm_off" is also unsupported. Configure scalable mode off as
+below if it's not needed by guest:
+
+.. code-block:: bash
+
+    -device intel-iommu,x-scalable-mode=off
diff --git a/include/hw/vfio/vfio-container.h b/include/hw/vfio/vfio-container.h
index 9f6e8cedfc..a7d5c5ed67 100644
--- a/include/hw/vfio/vfio-container.h
+++ b/include/hw/vfio/vfio-container.h
@@ -52,6 +52,7 @@ struct VFIOContainer {
     QLIST_HEAD(, VFIODevice) device_list;
     GList *iova_ranges;
     NotifierWithReturn cpr_reboot_notifier;
+    bool bypass_ro;
 };
 
 #define TYPE_VFIO_IOMMU "vfio-iommu"
diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index 48d00c7bc4..f6f3d0e378 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -268,6 +268,9 @@ void vfio_device_prepare(VFIODevice *vbasedev, VFIOContainer *bcontainer,
 void vfio_device_unprepare(VFIODevice *vbasedev);
 
 bool vfio_device_get_viommu_flags_want_nesting(VFIODevice *vbasedev);
+bool vfio_device_get_host_iommu_quirk_bypass_ro(VFIODevice *vbasedev,
+                                                uint32_t type, void *caps,
+                                                uint32_t size);
 
 int vfio_device_get_region_info(VFIODevice *vbasedev, int index,
                                 struct vfio_region_info **info);
diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index 3bab082322..086f20f676 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -533,6 +533,20 @@ bool vfio_device_get_viommu_flags_want_nesting(VFIODevice *vbasedev)
     return false;
 }
 
+bool vfio_device_get_host_iommu_quirk_bypass_ro(VFIODevice *vbasedev,
+                                                uint32_t type, void *caps,
+                                                uint32_t size)
+{
+    VFIOPCIDevice *vdev = vfio_pci_from_vfio_device(vbasedev);
+
+    if (vdev) {
+        return !!(pci_device_get_host_iommu_quirks(PCI_DEVICE(vdev), type,
+                                                   caps, size) &
+                  HOST_IOMMU_QUIRK_NESTING_PARENT_BYPASS_RO);
+    }
+    return false;
+}
+
 /*
  * Traditional ioctl() based io
  */
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 0bf68620d2..2947e1b80f 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -351,6 +351,7 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
     VFIOContainer *bcontainer = VFIO_IOMMU(container);
     uint32_t type, flags = 0;
     uint64_t hw_caps;
+    VendorCaps caps;
     VFIOIOASHwpt *hwpt;
     uint32_t hwpt_id;
     int ret;
@@ -396,7 +397,8 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
      * instead.
      */
     if (!iommufd_backend_get_device_info(vbasedev->iommufd, vbasedev->devid,
-                                         &type, NULL, 0, &hw_caps, errp)) {
+                                         &type, &caps, sizeof(caps), &hw_caps,
+                                         errp)) {
         return false;
     }
 
@@ -411,6 +413,11 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
      */
     if (vfio_device_get_viommu_flags_want_nesting(vbasedev)) {
         flags |= IOMMU_HWPT_ALLOC_NEST_PARENT;
+
+        if (vfio_device_get_host_iommu_quirk_bypass_ro(vbasedev, type,
+                                                       &caps, sizeof(caps))) {
+            bcontainer->bypass_ro = true;
+        }
     }
 
     if (cpr_is_incoming()) {
diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
index f193468dee..8ba1cd255d 100644
--- a/hw/vfio/listener.c
+++ b/hw/vfio/listener.c
@@ -502,7 +502,8 @@ void vfio_container_region_add(VFIOContainer *bcontainer,
     int ret;
     Error *err = NULL;
 
-    if (!vfio_listener_valid_section(section, false, "region_add")) {
+    if (!vfio_listener_valid_section(section, bcontainer->bypass_ro,
+                                     "region_add")) {
         return;
     }
 
@@ -668,7 +669,8 @@ static void vfio_listener_region_del(MemoryListener *listener,
     int ret;
     bool try_unmap = true;
 
-    if (!vfio_listener_valid_section(section, false, "region_del")) {
+    if (!vfio_listener_valid_section(section, bcontainer->bypass_ro,
+                                     "region_del")) {
         return;
     }
 
-- 
2.47.1


