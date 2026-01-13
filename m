Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BEB3D29DF8
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 09:39:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfaqg-00026W-Ps; Tue, 13 Jan 2026 04:38:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vfaqe-0001nW-4Y
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 04:38:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vfaqc-0003QM-Dk
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 04:37:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768297077;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gjuUPb1vbhlPDXI27DbfmDSRpGuiGT5u895EaUv2uyw=;
 b=UK1kwEIdUb6o7yEZ/aUl0qXLaqHO8RwIQCjrRgSFVvDNhfHRivGOGiLjOad0lXCbTbPGgz
 L6HxvBXQotoD6UCXGi9iZ5B99026C42xuVm+yneo8pylyCOnKIF7ENVBOxgERYZEftEvEO
 Tc4J/uSHcKdb4stqw7XX03wMhJRmOIU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-364-t1DVyuPrPuSaXeqAnHymbw-1; Tue,
 13 Jan 2026 04:37:52 -0500
X-MC-Unique: t1DVyuPrPuSaXeqAnHymbw-1
X-Mimecast-MFC-AGG-ID: t1DVyuPrPuSaXeqAnHymbw_1768297070
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CE4F51956080; Tue, 13 Jan 2026 09:37:50 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.79])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E377330001A2; Tue, 13 Jan 2026 09:37:47 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>, Xudong Hao <xudong.hao@intel.com>,
 Giovannio Cabiddu <giovanni.cabiddu@intel.com>,
 Rohith S R <rohith.s.r@intel.com>
Subject: [PULL 23/41] vfio/iommufd: Query dirty bitmap before DMA unmap
Date: Tue, 13 Jan 2026 10:36:19 +0100
Message-ID: <20260113093637.1549214-24-clg@redhat.com>
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

When an existing mapping is unmapped, there could already be dirty bits
which need to be recorded before unmap.

If query dirty bitmap fails, we still need to do unmapping or else there
is stale mapping and it's risky to guest.

Co-developed-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Tested-by: Xudong Hao <xudong.hao@intel.com>
Tested-by: Giovannio Cabiddu <giovanni.cabiddu@intel.com>
Tested-by: Rohith S R <rohith.s.r@intel.com>
Link: https://lore.kernel.org/qemu-devel/20251218062643.624796-3-zhenzhong.duan@intel.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/iommufd.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index f56349faf5669cfeed10d7fc5e8d3bf8397bb04d..6d6244d7b9723def647f3dd4eec7ef1558415bb2 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -65,7 +65,7 @@ static int iommufd_cdev_unmap(const VFIOContainer *bcontainer,
     uint32_t ioas_id = container->ioas_id;
     bool need_dirty_sync = false;
     Error *local_err = NULL;
-    int ret;
+    int ret, unmap_ret;
 
     if (unmap_all) {
         size = UINT64_MAX;
@@ -74,8 +74,21 @@ static int iommufd_cdev_unmap(const VFIOContainer *bcontainer,
     if (iotlb && vfio_container_dirty_tracking_is_started(bcontainer)) {
         if (!vfio_container_devices_dirty_tracking_is_supported(bcontainer) &&
             bcontainer->dirty_pages_supported) {
-            /* TODO: query dirty bitmap before DMA unmap */
-            return iommufd_backend_unmap_dma(be, ioas_id, iova, size);
+            ret = vfio_container_query_dirty_bitmap(bcontainer, iova, size,
+                                                    iotlb->translated_addr,
+                                                    &local_err);
+            if (ret) {
+                error_report_err(local_err);
+            }
+            /* Unmap stale mapping even if query dirty bitmap fails */
+            unmap_ret = iommufd_backend_unmap_dma(be, ioas_id, iova, size);
+
+            /*
+             * If dirty tracking fails, return the failure to VFIO core to
+             * fail the migration, or else there will be dirty pages missed
+             * to be migrated.
+             */
+            return unmap_ret ? : ret;
         }
 
         need_dirty_sync = true;
-- 
2.52.0


