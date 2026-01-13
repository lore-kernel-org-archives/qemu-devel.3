Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E08AD29DF3
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 09:38:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfaqa-0001Lk-HU; Tue, 13 Jan 2026 04:37:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vfaqY-000161-Iz
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 04:37:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vfaqW-0003PV-UI
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 04:37:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768297072;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o5tqwJ/c3cR/g2ZIcrgCqfs0Sk0VmFjx1wb4iWXHXaA=;
 b=B18ARniiQhB/n7dvcli0pPXRMg4zr18vB9wZosZohaP7TQQyHRV0gzQzqMv4AaAQ75u5eA
 YgzIrZJaxWfmd7w5EVAe+uEgPA5V7AzhkjsbluZwc89a9LtRxVSqwsWw9Lkw1U29MjbfBn
 BKDjW7eC9iezEBD05CWBJ0NYghhVz70=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-42-bliF4gsBMcS-hU4VNxnbtw-1; Tue,
 13 Jan 2026 04:37:48 -0500
X-MC-Unique: bliF4gsBMcS-hU4VNxnbtw-1
X-Mimecast-MFC-AGG-ID: bliF4gsBMcS-hU4VNxnbtw_1768297067
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 88548195605B; Tue, 13 Jan 2026 09:37:47 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.79])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 046FE30001A2; Tue, 13 Jan 2026 09:37:44 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>, Xudong Hao <xudong.hao@intel.com>,
 Giovannio Cabiddu <giovanni.cabiddu@intel.com>,
 Rohith S R <rohith.s.r@intel.com>
Subject: [PULL 22/41] vfio/iommufd: Add framework code to support getting
 dirty bitmap before unmap
Date: Tue, 13 Jan 2026 10:36:18 +0100
Message-ID: <20260113093637.1549214-23-clg@redhat.com>
In-Reply-To: <20260113093637.1549214-1-clg@redhat.com>
References: <20260113093637.1549214-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Currently we support device and iommu dirty tracking, device dirty tracking
is preferred.

Add the framework code in iommufd_cdev_unmap() to choose either device or
iommu dirty tracking, just like vfio_legacy_dma_unmap_one().

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Tested-by: Xudong Hao <xudong.hao@intel.com>
Tested-by: Giovannio Cabiddu <giovanni.cabiddu@intel.com>
Tested-by: Rohith S R <rohith.s.r@intel.com>
Link: https://lore.kernel.org/qemu-devel/20251218062643.624796-2-zhenzhong.duan@intel.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/iommufd.c | 34 +++++++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index e5328c63a366076199015b25f55d273b91a4327a..f56349faf5669cfeed10d7fc5e8d3bf8397bb04d 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -61,14 +61,42 @@ static int iommufd_cdev_unmap(const VFIOContainer *bcontainer,
                               IOMMUTLBEntry *iotlb, bool unmap_all)
 {
     const VFIOIOMMUFDContainer *container = VFIO_IOMMU_IOMMUFD(bcontainer);
+    IOMMUFDBackend *be = container->be;
+    uint32_t ioas_id = container->ioas_id;
+    bool need_dirty_sync = false;
+    Error *local_err = NULL;
+    int ret;
 
     if (unmap_all) {
         size = UINT64_MAX;
     }
 
-    /* TODO: Handle dma_unmap_bitmap with iotlb args (migration) */
-    return iommufd_backend_unmap_dma(container->be,
-                                     container->ioas_id, iova, size);
+    if (iotlb && vfio_container_dirty_tracking_is_started(bcontainer)) {
+        if (!vfio_container_devices_dirty_tracking_is_supported(bcontainer) &&
+            bcontainer->dirty_pages_supported) {
+            /* TODO: query dirty bitmap before DMA unmap */
+            return iommufd_backend_unmap_dma(be, ioas_id, iova, size);
+        }
+
+        need_dirty_sync = true;
+    }
+
+    ret = iommufd_backend_unmap_dma(be, ioas_id, iova, size);
+    if (ret) {
+        return ret;
+    }
+
+    if (need_dirty_sync) {
+        ret = vfio_container_query_dirty_bitmap(bcontainer, iova, size,
+                                                iotlb->translated_addr,
+                                                &local_err);
+        if (ret) {
+            error_report_err(local_err);
+            return ret;
+        }
+    }
+
+    return 0;
 }
 
 static bool iommufd_cdev_kvm_device_add(VFIODevice *vbasedev, Error **errp)
-- 
2.52.0


