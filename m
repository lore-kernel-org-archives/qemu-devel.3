Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97FB8D29DF7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 09:39:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfarS-0003yf-Rh; Tue, 13 Jan 2026 04:38:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vfar2-0003FN-PT
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 04:38:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vfar0-0003UN-Ko
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 04:38:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768297102;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E+c0XSB3dj7G1jIOFSH8sQhzUXIiY/x0fc8xkAVaulg=;
 b=J014SdbGDdkHXVjQd2NcH7jKXLc/6+cnqC4eO+gvl6XxmaEqu3OUbV2pwd7NSZhni8qclr
 QSZzNjJdHlF6/3+D4yo18tMfZxYr57dvjWyxfyGggvZB5nqxKVQv+pi2MII/apXtdubivZ
 h8WImu22DV7CP1g+6waNgpbtsF26tEU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-25-_xAe-mGkNJGi2U5wmNkwkw-1; Tue,
 13 Jan 2026 04:38:20 -0500
X-MC-Unique: _xAe-mGkNJGi2U5wmNkwkw-1
X-Mimecast-MFC-AGG-ID: _xAe-mGkNJGi2U5wmNkwkw_1768297099
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 503B919560A2; Tue, 13 Jan 2026 09:38:19 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.79])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CB5CA30001A2; Tue, 13 Jan 2026 09:38:17 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 34/41] Workaround for ERRATA_772415_SPR17
Date: Tue, 13 Jan 2026 10:36:30 +0100
Message-ID: <20260113093637.1549214-35-clg@redhat.com>
In-Reply-To: <20260113093637.1549214-1-clg@redhat.com>
References: <20260113093637.1549214-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

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
Link: https://lore.kernel.org/qemu-devel/20260106062808.316574-5-zhenzhong.duan@intel.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 docs/devel/vfio-iommufd.rst      |  9 +++++++++
 include/hw/vfio/vfio-container.h |  1 +
 include/hw/vfio/vfio-device.h    |  3 +++
 hw/vfio/device.c                 | 14 ++++++++++++++
 hw/vfio/iommufd.c                |  9 ++++++++-
 hw/vfio/listener.c               |  6 ++++--
 6 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/docs/devel/vfio-iommufd.rst b/docs/devel/vfio-iommufd.rst
index 2d6e60dce1d38f1de136c3d65f3c396aef9e0805..6928b47643b876df51675e7607edca62435de139 100644
--- a/docs/devel/vfio-iommufd.rst
+++ b/docs/devel/vfio-iommufd.rst
@@ -169,3 +169,12 @@ otherwise below error shows:
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
index 9f6e8cedfc9541e84558d74bdb156e4963a68639..a7d5c5ed679a0338937ae02f37140d94720f6f11 100644
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
index 48d00c7bc47a2fd11a522a1ad09b051f16342545..f6f3d0e3786cf85553d75674828391e16f9fa250 100644
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
index 3bab082322633f7cbd4295b4e91717c83fbb48da..086f20f6762a3a86f52bbab840ef67f603850a01 100644
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
index 0bf68620d2c9a7a5e21553b9cc275e627b73327f..2947e1b80f5213d2781a32cb669bf3b66b69a643 100644
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
index f193468dee30354ea8c07e9bf2d89b4da42ab78a..8ba1cd255d146ab8055ab73c71eac640eafa1bdd 100644
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
2.52.0


