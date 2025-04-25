Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CAA0C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 08:55:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8EjP-0003Ya-UD; Fri, 25 Apr 2025 04:48:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u8EjH-0003Ri-Et
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 04:48:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u8EjE-0003Ga-5B
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 04:48:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745570887;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qOKPEmVG3cL7qwvWrWnc6oMtBMiJ4La+cPHLDKNEb0k=;
 b=WFCF1UvOr2Kd2xDRbFJVaLM8bt5WCjsHDoRKBnPHgGtOSMVr0ZLpc/mWDHowWdD4tVpxbp
 6vQZCH8QGQbcqMQxIwwtvXqXjtzinNlaTbGL45myuJfq+K4kAZT1LutXd5InsT2bnnNKs/
 NfZFCaJIJuq/1WGueBtgQ9+JWRVy+Io=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-82-RnHDP8ldMymMgB6_78qpDA-1; Fri,
 25 Apr 2025 04:48:03 -0400
X-MC-Unique: RnHDP8ldMymMgB6_78qpDA-1
X-Mimecast-MFC-AGG-ID: RnHDP8ldMymMgB6_78qpDA_1745570883
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E0BCF1800876; Fri, 25 Apr 2025 08:48:02 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.33.65])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0ADC230001A2; Fri, 25 Apr 2025 08:48:00 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 John Levon <john.levon@nutanix.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PULL 21/50] vfio: Move vfio_get_info_dma_avail() into helpers.c
Date: Fri, 25 Apr 2025 10:46:14 +0200
Message-ID: <20250425084644.102196-22-clg@redhat.com>
In-Reply-To: <20250425084644.102196-1-clg@redhat.com>
References: <20250425084644.102196-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
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

vfio_get_info_dma_avail() is a low level routine similar to the other
routines extracting capabilities from 'struct vfio_iommu_type1_info'.
It belongs to file "helpers.c".

Reviewed-by: John Levon <john.levon@nutanix.com>
Link: https://lore.kernel.org/qemu-devel/20250318095415.670319-17-clg@redhat.com
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Link: https://lore.kernel.org/qemu-devel/20250326075122.1299361-18-clg@redhat.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/vfio-helpers.h        |  5 ++++-
 include/hw/vfio/vfio-common.h |  2 --
 hw/vfio/container.c           | 31 -------------------------------
 hw/vfio/helpers.c             | 31 +++++++++++++++++++++++++++++++
 4 files changed, 35 insertions(+), 34 deletions(-)

diff --git a/hw/vfio/vfio-helpers.h b/hw/vfio/vfio-helpers.h
index d7e4dcba512a2a842c4a9d75e2d834bdf97c8f31..9af43878b8b90c0247221543423a5aca8be2eef5 100644
--- a/hw/vfio/vfio-helpers.h
+++ b/hw/vfio/vfio-helpers.h
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
index 8e465111d26ff612148fcd1af9a39a4e4de5184e..be2558f7e4e1e577caf69ee98798e490e80be96b 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -147,8 +147,6 @@ int vfio_get_region_info(VFIODevice *vbasedev, int index,
 int vfio_get_dev_region_info(VFIODevice *vbasedev, uint32_t type,
                              uint32_t subtype, struct vfio_region_info **info);
 bool vfio_has_region_cap(VFIODevice *vbasedev, int region, uint16_t cap_type);
-bool vfio_get_info_dma_avail(struct vfio_iommu_type1_info *info,
-                             unsigned int *avail);
 #endif
 
 bool vfio_devices_all_dirty_tracking_started(
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index b2d72f5036c5182e4b2d48b8cf57260d906e0bb5..3fdd5dac379bd43fdd8f606e02029c1f44bdb69a 100644
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
index 054ee6e31ebd080cc10516b9fc5a0373725b63d8..1a584ba5f007995a16d2364faeb72cb2b22de4e9 100644
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
2.49.0


