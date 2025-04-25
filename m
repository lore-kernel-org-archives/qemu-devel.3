Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BFBCC369D1
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 08:55:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8Ejq-0005FU-HQ; Fri, 25 Apr 2025 04:48:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u8Ejm-0004xQ-3g
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 04:48:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u8Ejj-0003JU-Ua
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 04:48:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745570922;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JgcXIo0J1CjwfiJNfxR0gjhTwNBc70YEky+ixZ0qS4M=;
 b=aj4aUY6Im8FBB8Xmp3c94oGS/ihu6iZtz25QyNzxDGmEnSz2NqK2oPx+awGDF9xIEJTIMa
 i3PdypelAerW639HZ4pg7hMlYuBx8KiM3RhvXIK7IVtRwn+dTDaGkS7/lsdRp6NLHuHXHd
 p5M4mVYNBUVAHTdvZ9RaSXA0t0ug0D0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-615-pFyBi_DVMi6oZ854GVguvA-1; Fri,
 25 Apr 2025 04:48:36 -0400
X-MC-Unique: pFyBi_DVMi6oZ854GVguvA-1
X-Mimecast-MFC-AGG-ID: pFyBi_DVMi6oZ854GVguvA_1745570915
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 730F8195609D; Fri, 25 Apr 2025 08:48:35 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.33.65])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2B0DC30001A2; Fri, 25 Apr 2025 08:48:32 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 John Levon <john.levon@nutanix.com>, Avihai Horon <avihaih@nvidia.com>
Subject: [PULL 32/50] vfio: Make vfio_container_query_dirty_bitmap() static
Date: Fri, 25 Apr 2025 10:46:25 +0200
Message-ID: <20250425084644.102196-33-clg@redhat.com>
In-Reply-To: <20250425084644.102196-1-clg@redhat.com>
References: <20250425084644.102196-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
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

vfio_container_query_dirty_bitmap() is only used in "container-base.c".
Also, rename to vfio_container_iommu_query_dirty_bitmap() to reflect it
is using the VFIO IOMMU backend device ->query_dirty_bitmap() handler.

Reviewed-by: Joao Martins <joao.m.martins@oracle.com>
Reviewed-by: John Levon <john.levon@nutanix.com>
Reviewed-by: Avihai Horon <avihaih@nvidia.com>
Link: https://lore.kernel.org/qemu-devel/20250326075122.1299361-29-clg@redhat.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-container-base.h |  2 --
 hw/vfio/container-base.c              | 24 ++++++++++++------------
 2 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index 60975194a3bdb911b06d5816bcfe4bdd9c946445..69fb698bc19a693de92d361097413557e3cc2b62 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -89,8 +89,6 @@ void vfio_container_del_section_window(VFIOContainerBase *bcontainer,
                                        MemoryRegionSection *section);
 int vfio_container_set_dirty_page_tracking(VFIOContainerBase *bcontainer,
                                            bool start, Error **errp);
-int vfio_container_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
-                   VFIOBitmap *vbmap, hwaddr iova, hwaddr size, Error **errp);
 bool vfio_devices_all_dirty_tracking_started(const VFIOContainerBase *bcontainer);
 bool vfio_devices_all_device_dirty_tracking(const VFIOContainerBase *bcontainer);
 int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
index eb7ab8461e34d4a47e810bd607dcde4e77314959..3c8039d52aa1838ca942a7ac29ebbd61fa074e67 100644
--- a/hw/vfio/container-base.c
+++ b/hw/vfio/container-base.c
@@ -141,16 +141,6 @@ int vfio_container_set_dirty_page_tracking(VFIOContainerBase *bcontainer,
     return ret;
 }
 
-int vfio_container_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
-                   VFIOBitmap *vbmap, hwaddr iova, hwaddr size, Error **errp)
-{
-    VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
-
-    g_assert(vioc->query_dirty_bitmap);
-    return vioc->query_dirty_bitmap(bcontainer, vbmap, iova, size,
-                                               errp);
-}
-
 static bool vfio_devices_all_device_dirty_tracking_started(
     const VFIOContainerBase *bcontainer)
 {
@@ -214,6 +204,16 @@ static int vfio_device_dma_logging_report(VFIODevice *vbasedev, hwaddr iova,
     return 0;
 }
 
+static int vfio_container_iommu_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
+                   VFIOBitmap *vbmap, hwaddr iova, hwaddr size, Error **errp)
+{
+    VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
+
+    g_assert(vioc->query_dirty_bitmap);
+    return vioc->query_dirty_bitmap(bcontainer, vbmap, iova, size,
+                                               errp);
+}
+
 static int vfio_container_devices_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
                  VFIOBitmap *vbmap, hwaddr iova, hwaddr size, Error **errp)
 {
@@ -263,8 +263,8 @@ int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
         ret = vfio_container_devices_query_dirty_bitmap(bcontainer, &vbmap, iova, size,
                                                         errp);
     } else {
-        ret = vfio_container_query_dirty_bitmap(bcontainer, &vbmap, iova, size,
-                                                errp);
+        ret = vfio_container_iommu_query_dirty_bitmap(bcontainer, &vbmap, iova, size,
+                                                     errp);
     }
 
     if (ret) {
-- 
2.49.0


