Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16783C369D1
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 08:51:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8ElI-0008E8-L8; Fri, 25 Apr 2025 04:50:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u8EkT-00073b-Nw
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 04:49:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u8EkQ-0003Na-Vw
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 04:49:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745570966;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YB4bT7X5Ei4XBUUch0D+TK6fEAPbX+If5u9eieOsydE=;
 b=Dvg51CubbXfLQ+5lgTZODcMuS8MkuZGQG6kTnJL6pLQ/NRxKXnTGkjKRp+tHhkMgXnVYZW
 BX3T5z4+LcHdkI+T0CTfGX7bFPJBEC4SrJdf81OgeNM6isjRkvFrjb0hx7EORgUeiydjRj
 2zDI6Z+FVxeOhaHkQlrAXrKzPhJ4tdY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-636-BT-cSXBINsy5GYsoY2QcLA-1; Fri,
 25 Apr 2025 04:49:20 -0400
X-MC-Unique: BT-cSXBINsy5GYsoY2QcLA-1
X-Mimecast-MFC-AGG-ID: BT-cSXBINsy5GYsoY2QcLA_1745570959
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5B2861800263; Fri, 25 Apr 2025 08:49:19 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.33.65])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DF19330001A2; Fri, 25 Apr 2025 08:49:16 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 47/50] vfio: Remove hiod_typename property
Date: Fri, 25 Apr 2025 10:46:40 +0200
Message-ID: <20250425084644.102196-48-clg@redhat.com>
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

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

Because we handle host IOMMU device creation in each container backend,
we know which type name to use, so hiod_typename property is useless
now, just remove it.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250423072824.3647952-6-zhenzhong.duan@intel.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-container-base.h | 3 ---
 hw/vfio/container.c                   | 2 --
 hw/vfio/iommufd.c                     | 2 --
 3 files changed, 7 deletions(-)

diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index af63373c92359ec53eb1669edfd4deb5a5177c20..5527e027220ac05f82d2a9beaf8b921e26597271 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -115,9 +115,6 @@ OBJECT_DECLARE_TYPE(VFIOContainerBase, VFIOIOMMUClass, VFIO_IOMMU)
 struct VFIOIOMMUClass {
     ObjectClass parent_class;
 
-    /* Properties */
-    const char *hiod_typename;
-
     /* basic feature */
     bool (*setup)(VFIOContainerBase *bcontainer, Error **errp);
     int (*dma_map)(const VFIOContainerBase *bcontainer,
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 78f70e63d6fcef09a7c12cbd01526701073e6952..29170f063465e2c428a760a081603543c46f1ca3 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -1103,8 +1103,6 @@ static void vfio_iommu_legacy_class_init(ObjectClass *klass, void *data)
 {
     VFIOIOMMUClass *vioc = VFIO_IOMMU_CLASS(klass);
 
-    vioc->hiod_typename = TYPE_HOST_IOMMU_DEVICE_LEGACY_VFIO;
-
     vioc->setup = vfio_legacy_setup;
     vioc->dma_map = vfio_legacy_dma_map;
     vioc->dma_unmap = vfio_legacy_dma_unmap;
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 8a010a51ea3882ef62fd1906b97ed3b77c5e57ef..f24054a6a5467e3b3436f106bf764c7de8019b0c 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -795,8 +795,6 @@ static void vfio_iommu_iommufd_class_init(ObjectClass *klass, void *data)
 {
     VFIOIOMMUClass *vioc = VFIO_IOMMU_CLASS(klass);
 
-    vioc->hiod_typename = TYPE_HOST_IOMMU_DEVICE_IOMMUFD_VFIO;
-
     vioc->dma_map = iommufd_cdev_map;
     vioc->dma_unmap = iommufd_cdev_unmap;
     vioc->attach_device = iommufd_cdev_attach;
-- 
2.49.0


