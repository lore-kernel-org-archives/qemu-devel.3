Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12442F8FA90
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 16:37:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFE5N-0005eB-HP; Tue, 21 Apr 2026 12:36:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wFE4B-0004jb-M1
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 12:35:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wFE47-0007Qa-92
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 12:35:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776789307;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VvTNqp++Rdp2v3KRck3Tf7+xvqfTdXk5NH7kjqmKGWw=;
 b=agN1j8Kij/1KOslJruKoNThLQtgca0YOmx04NtZVtVG2ws2t1g4d3WpQyv4LTlN8P9jK8/
 Nl8IoUNMSojilF8q8sM5QH5p6YlW4mh9T/xqhRHrPBWUVhC812gWuPFYBmU5kozKrfsJJG
 uf7056QnkqO7fY5lyfztDwwqiNiMNyc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-62-5Utkm1NqOlqx8OgkUovcTg-1; Tue,
 21 Apr 2026 12:35:06 -0400
X-MC-Unique: 5Utkm1NqOlqx8OgkUovcTg-1
X-Mimecast-MFC-AGG-ID: 5Utkm1NqOlqx8OgkUovcTg_1776789305
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0CFE719560AA; Tue, 21 Apr 2026 16:35:05 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.70])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 193701956095; Tue, 21 Apr 2026 16:35:02 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
 Shameer Kolothum <skolothumtho@nvidia.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 10/14] hw/vfio/iommufd: Control dirty tracking for nesting
 parent HWPT
Date: Tue, 21 Apr 2026 18:34:34 +0200
Message-ID: <20260421163438.3447280-11-clg@redhat.com>
In-Reply-To: <20260421163438.3447280-1-clg@redhat.com>
References: <20260421163438.3447280-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Shameer Kolothum <skolothumtho@nvidia.com>

QEMU smmuv3 accel does not support live migration yet, so dirty
tracking for the nesting parent HWPT is not useful.

Also, nested vIOMMU use cases can break on some platforms. For
example, SMMUv3 with HTTU may advertise dirty tracking capability,
but the kernel supports it only for stage-1. Requesting dirty
tracking for a nesting parent HWPT (stage-2) can fail.

Add a vIOMMU flag to explicitly request dirty tracking for the
nesting parent HWPT. For nested cases, dirty tracking is enabled
only when requested by the vIOMMU.

Non-nested cases and Intel vIOMMU keep the existing behavior.

Fixes: fc6dafb98cec ("hw/arm/smmuv3: Implement get_viommu_cap() callback")
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Link: https://lore.kernel.org/qemu-devel/20260401084133.56266-1-skolothumtho@nvidia.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/core/iommu.h       |  2 ++
 include/hw/vfio/vfio-device.h |  1 +
 hw/i386/intel_iommu.c         |  7 +++++--
 hw/vfio/device.c              | 11 +++++++++++
 hw/vfio/iommufd.c             | 11 +++++++++--
 5 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/include/hw/core/iommu.h b/include/hw/core/iommu.h
index 86af315c153763d4d217a2e255c3f7aced228e91..cd59a367ceb9517885a5a8c14a40af3404e99832 100644
--- a/include/hw/core/iommu.h
+++ b/include/hw/core/iommu.h
@@ -21,6 +21,8 @@ enum viommu_flags {
     /* vIOMMU needs nesting parent HWPT to create nested HWPT */
     VIOMMU_FLAG_WANT_NESTING_PARENT = BIT_ULL(0),
     VIOMMU_FLAG_PASID_SUPPORTED = BIT_ULL(1),
+    /* vIOMMU needs dirty tracking on the nesting parent HWPT for nested use */
+    VIOMMU_FLAG_WANT_NESTING_DIRTY_TRACKING = BIT_ULL(2),
 };
 
 /* Host IOMMU quirks. Extracted from host IOMMU capabilities */
diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index 828a31c006ec9fc372760fee023da31b0e7acc4b..a95c5bf50302a7394582dcc493d96aef00b47dc8 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -268,6 +268,7 @@ void vfio_device_prepare(VFIODevice *vbasedev, VFIOContainer *bcontainer,
 void vfio_device_unprepare(VFIODevice *vbasedev);
 
 bool vfio_device_get_viommu_flags_want_nesting(VFIODevice *vbasedev);
+bool vfio_device_get_viommu_flags_want_nesting_dirty(VFIODevice *vbasedev);
 bool vfio_device_get_host_iommu_quirk_bypass_ro(VFIODevice *vbasedev,
                                                 uint32_t type, void *caps,
                                                 uint32_t size);
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index f395fa248c009c663be281774c8455ee3b85d8a2..b784c5f10aebbd3fe1f1c332c4ecc5aecc2b9136 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -4825,9 +4825,12 @@ static void vtd_dev_unset_iommu_device(PCIBus *bus, void *opaque, int devfn)
 static uint64_t vtd_get_viommu_flags(void *opaque)
 {
     IntelIOMMUState *s = opaque;
-    uint64_t flags;
+    uint64_t flags = 0;
 
-    flags = s->fsts ? VIOMMU_FLAG_WANT_NESTING_PARENT : 0;
+    if (s->fsts) {
+        flags = VIOMMU_FLAG_WANT_NESTING_PARENT |
+                VIOMMU_FLAG_WANT_NESTING_DIRTY_TRACKING;
+    }
 
     return flags;
 }
diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index 973fc35b59d4bdaa34c0f2773ec78df0f151dfa2..8f7ae919a55dd9e08bdd072eee33f5b46a91aa2a 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -522,6 +522,17 @@ void vfio_device_unprepare(VFIODevice *vbasedev)
     vbasedev->bcontainer = NULL;
 }
 
+bool vfio_device_get_viommu_flags_want_nesting_dirty(VFIODevice *vbasedev)
+{
+    VFIOPCIDevice *vdev = vfio_pci_from_vfio_device(vbasedev);
+
+    if (vdev) {
+        return !!(pci_device_get_viommu_flags(PCI_DEVICE(vdev)) &
+                  VIOMMU_FLAG_WANT_NESTING_DIRTY_TRACKING);
+    }
+    return false;
+}
+
 bool vfio_device_get_viommu_flags_want_nesting(VFIODevice *vbasedev)
 {
     VFIOPCIDevice *vdev = vfio_pci_from_vfio_device(vbasedev);
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 399b36aa752ebe24d5ea7eb4d0a991785c51e642..df148a49a762b1f6b05d548cb9f9b0413b743439 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -352,6 +352,7 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
     ERRP_GUARD();
     IOMMUFDBackend *iommufd = vbasedev->iommufd;
     VFIOContainer *bcontainer = VFIO_IOMMU(container);
+    bool viommu_nesting, viommu_nesting_dirty;
     uint32_t type, flags = 0;
     uint64_t hw_caps;
     VendorCaps caps;
@@ -405,8 +406,14 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
         return false;
     }
 
+    viommu_nesting = vfio_device_get_viommu_flags_want_nesting(vbasedev);
+    viommu_nesting_dirty =
+        vfio_device_get_viommu_flags_want_nesting_dirty(vbasedev);
+
     if (hw_caps & IOMMU_HW_CAP_DIRTY_TRACKING) {
-        flags = IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
+        if (!viommu_nesting || viommu_nesting_dirty) {
+            flags |= IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
+        }
     }
 
     /*
@@ -414,7 +421,7 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
      * force to create it so that it could be reused by vIOMMU to create
      * nested HWPT.
      */
-    if (vfio_device_get_viommu_flags_want_nesting(vbasedev)) {
+    if (viommu_nesting) {
         flags |= IOMMU_HWPT_ALLOC_NEST_PARENT;
 
         if (vfio_device_get_host_iommu_quirk_bypass_ro(vbasedev, type,
-- 
2.53.0


