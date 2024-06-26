Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5167AC27C4F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 08:29:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMO0n-0007Q0-37; Wed, 26 Jun 2024 04:28:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sMO0h-0007LK-Sw
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 04:28:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sMO0Z-0007Aq-Nc
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 04:28:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719390483;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bZve/t/4IEVVs0YkFY83LrcVufG1gG2T8mz5Ir3gtRw=;
 b=HhFfKqonwjCUoE1JOeUcFxLW2WVLuZfg6F5+YYk9qAjRAR5hc5+4h2m90JuuwWI/b4dHoi
 3kcOtw3elfgUVXB5G4/4jtkjP7gec47dxjQKY1RzuyTJ9kN1C08TjXlWjJnmybSA8W45pX
 NIqyWYaFOtl78k7dYpmAhLF7mtd66Ps=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-520-Dg7AECljMLuwnfeKL0Nlmg-1; Wed,
 26 Jun 2024 04:28:00 -0400
X-MC-Unique: Dg7AECljMLuwnfeKL0Nlmg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 46CA919560AB; Wed, 26 Jun 2024 08:27:59 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.39.193.191])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 554E61955E82; Wed, 26 Jun 2024 08:27:54 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, mst@redhat.com, jean-philippe@linaro.org,
 peter.maydell@linaro.org, clg@redhat.com, yanghliu@redhat.com,
 zhenzhong.duan@intel.com, alex.williamson@redhat.com
Subject: [PATCH 4/7] HostIOMMUDevice: Introduce get_page_size_mask() callback
Date: Wed, 26 Jun 2024 10:26:49 +0200
Message-ID: <20240626082727.1278530-5-eric.auger@redhat.com>
In-Reply-To: <20240626082727.1278530-1-eric.auger@redhat.com>
References: <20240626082727.1278530-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
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

This callback will be used to retrieve the page size mask supported
along a given Host IOMMU device.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 include/hw/vfio/vfio-container-base.h |  7 +++++++
 include/sysemu/host_iommu_device.h    |  8 ++++++++
 hw/vfio/container.c                   | 10 ++++++++++
 hw/vfio/iommufd.c                     | 11 +++++++++++
 4 files changed, 36 insertions(+)

diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index 45d7c40fce..62a8b60d87 100644
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
index 05c7324a0d..c1bf74ae2c 100644
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
index adeab1ac89..b5ce559a0d 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -1174,6 +1174,15 @@ hiod_legacy_vfio_get_iova_ranges(HostIOMMUDevice *hiod)
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
@@ -1188,6 +1197,7 @@ static void hiod_legacy_vfio_class_init(ObjectClass *oc, void *data)
     hioc->realize = hiod_legacy_vfio_realize;
     hioc->get_cap = hiod_legacy_vfio_get_cap;
     hioc->get_iova_ranges = hiod_legacy_vfio_get_iova_ranges;
+    hioc->get_page_size_mask = hiod_legacy_vfio_get_page_size_mask;
 };
 
 static const TypeInfo types[] = {
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 211e7223f1..7b5f87a148 100644
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
2.41.0


