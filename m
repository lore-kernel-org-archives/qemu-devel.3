Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC3F2C5B543
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 08:44:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uN6CK-0006jG-Rf; Thu, 05 Jun 2025 04:43:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uN6CB-0006dQ-O8
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 04:43:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uN6C9-0008HP-Vb
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 04:43:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749113009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rq3/p7+wMwNrqwNX0ag/QjHx8yDalShYV6NSoatJ55c=;
 b=VBovYa+1q9i+jZ+y6GoC+TT4o+0YOz86nihxcqBDBcdxMNOpFN30l2HH4b+vVQzzrJ7dRu
 Vq2NxqR1vKFIk/f/FgPCRMjiJi+tgjfXtZLa/kg8qcSb6QlCI1Bymj6J1JViF5C7Pw+h7g
 JOeeK1R0VVVXMfT2nUj9AyyJYxlWpBw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-633-W8pilgWFM3aPrIVd7klH7g-1; Thu,
 05 Jun 2025 04:43:25 -0400
X-MC-Unique: W8pilgWFM3aPrIVd7klH7g-1
X-Mimecast-MFC-AGG-ID: W8pilgWFM3aPrIVd7klH7g_1749113004
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6DE2D195608E; Thu,  5 Jun 2025 08:43:24 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.77])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 946311954B33; Thu,  5 Jun 2025 08:43:21 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, Yi Liu <yi.l.liu@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, Nicolin Chen <nicolinc@nvidia.com>
Subject: [PULL 12/16] vfio/iommufd: Implement [at|de]tach_hwpt handlers
Date: Thu,  5 Jun 2025 10:42:41 +0200
Message-ID: <20250605084245.1520562-13-clg@redhat.com>
In-Reply-To: <20250605084245.1520562-1-clg@redhat.com>
References: <20250605084245.1520562-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
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

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

Implement [at|de]tach_hwpt handlers in VFIO subsystem. vIOMMU
utilizes them to attach to or detach from hwpt on host side.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Link: https://lore.kernel.org/qemu-devel/20250604062115.4004200-4-zhenzhong.duan@intel.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/iommufd.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 625b1747a29648918298e3a6cb3af68c5459ead5..59033028373c82a22b1aaf092503d037a6d7e9b6 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -815,6 +815,24 @@ static void vfio_iommu_iommufd_class_init(ObjectClass *klass, const void *data)
     vioc->query_dirty_bitmap = iommufd_query_dirty_bitmap;
 };
 
+static bool
+host_iommu_device_iommufd_vfio_attach_hwpt(HostIOMMUDeviceIOMMUFD *idev,
+                                           uint32_t hwpt_id, Error **errp)
+{
+    VFIODevice *vbasedev = HOST_IOMMU_DEVICE(idev)->agent;
+
+    return !iommufd_cdev_attach_ioas_hwpt(vbasedev, hwpt_id, errp);
+}
+
+static bool
+host_iommu_device_iommufd_vfio_detach_hwpt(HostIOMMUDeviceIOMMUFD *idev,
+                                           Error **errp)
+{
+    VFIODevice *vbasedev = HOST_IOMMU_DEVICE(idev)->agent;
+
+    return iommufd_cdev_detach_ioas_hwpt(vbasedev, errp);
+}
+
 static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
                                       Error **errp)
 {
@@ -869,10 +887,14 @@ hiod_iommufd_vfio_get_page_size_mask(HostIOMMUDevice *hiod)
 static void hiod_iommufd_vfio_class_init(ObjectClass *oc, const void *data)
 {
     HostIOMMUDeviceClass *hiodc = HOST_IOMMU_DEVICE_CLASS(oc);
+    HostIOMMUDeviceIOMMUFDClass *idevc = HOST_IOMMU_DEVICE_IOMMUFD_CLASS(oc);
 
     hiodc->realize = hiod_iommufd_vfio_realize;
     hiodc->get_iova_ranges = hiod_iommufd_vfio_get_iova_ranges;
     hiodc->get_page_size_mask = hiod_iommufd_vfio_get_page_size_mask;
+
+    idevc->attach_hwpt = host_iommu_device_iommufd_vfio_attach_hwpt;
+    idevc->detach_hwpt = host_iommu_device_iommufd_vfio_detach_hwpt;
 };
 
 static const TypeInfo types[] = {
-- 
2.49.0


