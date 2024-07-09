Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B86BC2BD09
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 11:52:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sR9Mx-0005TY-4f; Tue, 09 Jul 2024 07:50:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sR9Mr-000569-Mi
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 07:50:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sR9Mg-0006K6-Up
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 07:50:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720525834;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F5RrE26PP86wAXgz2hxMg3FUebCPD4iG1R8gJZN5wNo=;
 b=MRch5nLBs91qpwSmnWWkL2KuPMpxfhzkFWSR59c+lGO8QcpmmmcAT7Qn6FGr/lzpkdZGn0
 chDTcqzIY1xawhX3YokPKiE//NLPOEoIG4YQOPxerq7MNjLqwxdF6uXulSrp6BtP7jA1Rh
 7JXe/auJ3DrBhmIJZQ5x/JAwcHVjlpw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-323-jc-1MXBlOBetayHg_5ybmg-1; Tue,
 09 Jul 2024 07:50:31 -0400
X-MC-Unique: jc-1MXBlOBetayHg_5ybmg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F2E2B19560AA; Tue,  9 Jul 2024 11:50:30 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.193.243])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 284433000181; Tue,  9 Jul 2024 11:50:28 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: [PULL 4/9] HostIOMMUDevice: Introduce get_page_size_mask() callback
Date: Tue,  9 Jul 2024 13:50:12 +0200
Message-ID: <20240709115017.798043-5-clg@redhat.com>
In-Reply-To: <20240709115017.798043-1-clg@redhat.com>
References: <20240709115017.798043-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
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

From: Eric Auger <eric.auger@redhat.com>

This callback will be used to retrieve the page size mask supported
along a given Host IOMMU device.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/vfio/vfio-container-base.h |  7 +++++++
 include/sysemu/host_iommu_device.h    |  8 ++++++++
 hw/vfio/container.c                   | 10 ++++++++++
 hw/vfio/iommufd.c                     | 11 +++++++++++
 4 files changed, 36 insertions(+)

diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index 45d7c40fce8f4f3508cbc08b436b2db1dfaa01e4..62a8b60d87db263225147a21eff2ef6e21cb22df 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -88,6 +88,13 @@ int vfio_container_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
 
 GList *vfio_container_get_iova_ranges(const VFIOContainerBase *bcontainer);
 
+static inline uint64_t
+vfio_container_get_page_size_mask(const VFIOContainerBase *bcontainer)
+{
+    assert(bcontainer);
+    return bcontainer->pgsizes;
+}
+
 #define TYPE_VFIO_IOMMU "vfio-iommu"
 #define TYPE_VFIO_IOMMU_LEGACY TYPE_VFIO_IOMMU "-legacy"
 #define TYPE_VFIO_IOMMU_SPAPR TYPE_VFIO_IOMMU "-spapr"
diff --git a/include/sysemu/host_iommu_device.h b/include/sysemu/host_iommu_device.h
index 05c7324a0d1ccd2e30bc42ca1f0353e55361500a..c1bf74ae2c7a729b22d6512f3ca37ce65fa6bcec 100644
--- a/include/sysemu/host_iommu_device.h
+++ b/include/sysemu/host_iommu_device.h
@@ -89,6 +89,14 @@ struct HostIOMMUDeviceClass {
      * @hiod: handle to the host IOMMU device
      */
     GList* (*get_iova_ranges)(HostIOMMUDevice *hiod);
+    /**
+     *
+     * @get_page_size_mask: Return the page size mask supported along this
+     * @hiod Host IOMMU device
+     *
+     * @hiod: handle to the host IOMMU device
+     */
+    uint64_t (*get_page_size_mask)(HostIOMMUDevice *hiod);
 };
 
 /*
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index ddd835996cfae13dcab01e53fd381ace1cdae668..425db1a14c076fd6eaca0d25e06237e4e21fb798 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -1173,6 +1173,15 @@ hiod_legacy_vfio_get_iova_ranges(HostIOMMUDevice *hiod)
     return vfio_container_get_iova_ranges(vdev->bcontainer);
 }
 
+static uint64_t
+hiod_legacy_vfio_get_page_size_mask(HostIOMMUDevice *hiod)
+{
+    VFIODevice *vdev = hiod->agent;
+
+    g_assert(vdev);
+    return vfio_container_get_page_size_mask(vdev->bcontainer);
+}
+
 static void vfio_iommu_legacy_instance_init(Object *obj)
 {
     VFIOContainer *container = VFIO_IOMMU_LEGACY(obj);
@@ -1187,6 +1196,7 @@ static void hiod_legacy_vfio_class_init(ObjectClass *oc, void *data)
     hioc->realize = hiod_legacy_vfio_realize;
     hioc->get_cap = hiod_legacy_vfio_get_cap;
     hioc->get_iova_ranges = hiod_legacy_vfio_get_iova_ranges;
+    hioc->get_page_size_mask = hiod_legacy_vfio_get_page_size_mask;
 };
 
 static const TypeInfo types[] = {
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 211e7223f150ee3c8447a9c454c5a3528860682f..7b5f87a1488111f7b88ce7588db4f5e5bd976978 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -652,12 +652,23 @@ hiod_iommufd_vfio_get_iova_ranges(HostIOMMUDevice *hiod)
     return vfio_container_get_iova_ranges(vdev->bcontainer);
 }
 
+static uint64_t
+hiod_iommufd_vfio_get_page_size_mask(HostIOMMUDevice *hiod)
+{
+    VFIODevice *vdev = hiod->agent;
+
+    g_assert(vdev);
+    return vfio_container_get_page_size_mask(vdev->bcontainer);
+}
+
+
 static void hiod_iommufd_vfio_class_init(ObjectClass *oc, void *data)
 {
     HostIOMMUDeviceClass *hiodc = HOST_IOMMU_DEVICE_CLASS(oc);
 
     hiodc->realize = hiod_iommufd_vfio_realize;
     hiodc->get_iova_ranges = hiod_iommufd_vfio_get_iova_ranges;
+    hiodc->get_page_size_mask = hiod_iommufd_vfio_get_page_size_mask;
 };
 
 static const TypeInfo types[] = {
-- 
2.45.2


