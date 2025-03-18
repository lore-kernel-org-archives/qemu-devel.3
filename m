Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0539CC28B28
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 09:56:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuTg7-0005Ab-RX; Tue, 18 Mar 2025 05:56:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tuTfk-0004dB-3r
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 05:55:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tuTfg-0002LZ-0K
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 05:55:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742291739;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ESS7h5PCoG1T0ha3GxHJSiG3a7eNeky+Z87IF26EPxc=;
 b=gIEukMEtFrnuxLptJV578gPCqZ0m2+Zc81CzB9OkLtBPrQyirmE1AQIfkN38EwtFNWBId9
 QG405nkVxMbTTpJ4QLom1UhDEDj11CFYkns9gGBrlQ2RDW4mWJSZQsKQWdAVe/o567yr2O
 whRb17UDj2Ek43wMOFMCltl3GI16N6k=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-632-866JOix4Oj2jsK91Q6GSgw-1; Tue,
 18 Mar 2025 05:55:35 -0400
X-MC-Unique: 866JOix4Oj2jsK91Q6GSgw-1
X-Mimecast-MFC-AGG-ID: 866JOix4Oj2jsK91Q6GSgw_1742291734
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D10F31800262; Tue, 18 Mar 2025 09:55:34 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.25])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B35E81828A80; Tue, 18 Mar 2025 09:55:32 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org,
	Alex Williamson <alex.williamson@redhat.com>
Cc: Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH for-10.1 16/32] vfio: Move vfio_get_info_dma_avail() into
 helpers.c
Date: Tue, 18 Mar 2025 10:53:59 +0100
Message-ID: <20250318095415.670319-17-clg@redhat.com>
In-Reply-To: <20250318095415.670319-1-clg@redhat.com>
References: <20250318095415.670319-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.335,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

vfio_get_info_dma_avail() is a low level routine similar to the other
routines extracting capabilities from 'struct vfio_iommu_type1_info'.
It belongs to file "helpers.c".

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/helpers.h             |  5 ++++-
 include/hw/vfio/vfio-common.h |  2 --
 hw/vfio/container.c           | 31 -------------------------------
 hw/vfio/helpers.c             | 31 +++++++++++++++++++++++++++++++
 4 files changed, 35 insertions(+), 34 deletions(-)

diff --git a/hw/vfio/helpers.h b/hw/vfio/helpers.h
index b70f7082562dedff9d97db80d2eecc7ddf71e2af..c70eef4fd6f98fc1df9bc8ecbf72fa1ea484e3c0 100644
--- a/hw/vfio/helpers.h
+++ b/hw/vfio/helpers.h
@@ -18,7 +18,10 @@ struct vfio_info_cap_header *
 vfio_get_device_info_cap(struct vfio_device_info *info, uint16_t id);
 struct vfio_info_cap_header *
 vfio_get_region_info_cap(struct vfio_region_info *info, uint16_t id);
-
+struct vfio_info_cap_header *
+vfio_get_iommu_type1_info_cap(struct vfio_iommu_type1_info *info, uint16_t id);
+bool vfio_get_info_dma_avail(struct vfio_iommu_type1_info *info,
+                             unsigned int *avail);
 #endif
 
 int vfio_bitmap_alloc(VFIOBitmap *vbmap, hwaddr size);
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 0fe424633c9cb94195c08d0b62ca4fb8ffccd79c..b7c1f049582c07aefdc2a0cef2805e7b478ffe84 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -146,8 +146,6 @@ int vfio_get_region_info(VFIODevice *vbasedev, int index,
 int vfio_get_dev_region_info(VFIODevice *vbasedev, uint32_t type,
                              uint32_t subtype, struct vfio_region_info **info);
 bool vfio_has_region_cap(VFIODevice *vbasedev, int region, uint16_t cap_type);
-bool vfio_get_info_dma_avail(struct vfio_iommu_type1_info *info,
-                             unsigned int *avail);
 #endif
 
 bool vfio_devices_all_dirty_tracking_started(
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index a6f7359faefc02b01ca05f76b4c1f8a9934a9091..e1b06e71c47ab8d24e7da878f801020b22936430 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -278,37 +278,6 @@ static int vfio_legacy_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
     return ret;
 }
 
-static struct vfio_info_cap_header *
-vfio_get_iommu_type1_info_cap(struct vfio_iommu_type1_info *info, uint16_t id)
-{
-    if (!(info->flags & VFIO_IOMMU_INFO_CAPS)) {
-        return NULL;
-    }
-
-    return vfio_get_cap((void *)info, info->cap_offset, id);
-}
-
-bool vfio_get_info_dma_avail(struct vfio_iommu_type1_info *info,
-                             unsigned int *avail)
-{
-    struct vfio_info_cap_header *hdr;
-    struct vfio_iommu_type1_info_dma_avail *cap;
-
-    /* If the capability cannot be found, assume no DMA limiting */
-    hdr = vfio_get_iommu_type1_info_cap(info,
-                                        VFIO_IOMMU_TYPE1_INFO_DMA_AVAIL);
-    if (!hdr) {
-        return false;
-    }
-
-    if (avail != NULL) {
-        cap = (void *) hdr;
-        *avail = cap->avail;
-    }
-
-    return true;
-}
-
 static bool vfio_get_info_iova_range(struct vfio_iommu_type1_info *info,
                                      VFIOContainerBase *bcontainer)
 {
diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
index 9d635c18156d3271bad824b74fbc5b6f1f810a95..f42dcf82c58c978a45975eb1d015d64f4e39b3cf 100644
--- a/hw/vfio/helpers.c
+++ b/hw/vfio/helpers.c
@@ -222,6 +222,37 @@ retry:
     return 0;
 }
 
+struct vfio_info_cap_header *
+vfio_get_iommu_type1_info_cap(struct vfio_iommu_type1_info *info, uint16_t id)
+{
+    if (!(info->flags & VFIO_IOMMU_INFO_CAPS)) {
+        return NULL;
+    }
+
+    return vfio_get_cap((void *)info, info->cap_offset, id);
+}
+
+bool vfio_get_info_dma_avail(struct vfio_iommu_type1_info *info,
+                             unsigned int *avail)
+{
+    struct vfio_info_cap_header *hdr;
+    struct vfio_iommu_type1_info_dma_avail *cap;
+
+    /* If the capability cannot be found, assume no DMA limiting */
+    hdr = vfio_get_iommu_type1_info_cap(info,
+                                        VFIO_IOMMU_TYPE1_INFO_DMA_AVAIL);
+    if (!hdr) {
+        return false;
+    }
+
+    if (avail != NULL) {
+        cap = (void *) hdr;
+        *avail = cap->avail;
+    }
+
+    return true;
+}
+
 int vfio_get_dev_region_info(VFIODevice *vbasedev, uint32_t type,
                              uint32_t subtype, struct vfio_region_info **info)
 {
-- 
2.48.1


