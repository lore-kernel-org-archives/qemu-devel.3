Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33BDFC369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 08:48:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8EiR-0002lh-BB; Fri, 25 Apr 2025 04:47:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u8EiF-0002iF-4W
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 04:47:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u8EiB-0003Bn-RC
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 04:47:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745570827;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gBgpznxmwMkdPoCPXXwHNcIYnDpO/rm3Dg3GzUyU6gI=;
 b=UTBzSZvsvf6kU8DUl7F+8tQiHWTiVa7+CRTAznJdrF96de6ClT/fHKCLSlE4xGHt+b/RyT
 nhdhJb9LxyC061uwuVNT6iHz3NpvQCo3tOCLoGx9L23lw8xJBkrMMA3RTF1L56zrDB4LhY
 Ep4W8qzHtq0XugdqyA+OCxVYK9ll+4U=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-60-Q81m6SFDMya9M0Nh4lqxuA-1; Fri,
 25 Apr 2025 04:47:03 -0400
X-MC-Unique: Q81m6SFDMya9M0Nh4lqxuA-1
X-Mimecast-MFC-AGG-ID: Q81m6SFDMya9M0Nh4lqxuA_1745570822
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2A78319560A1; Fri, 25 Apr 2025 08:47:02 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.33.65])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0343730001A2; Fri, 25 Apr 2025 08:46:59 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Amit Machhiwal <amachhiw@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 03/50] vfio/spapr: Enhance error handling in
 vfio_spapr_create_window()
Date: Fri, 25 Apr 2025 10:45:56 +0200
Message-ID: <20250425084644.102196-4-clg@redhat.com>
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

From: Amit Machhiwal <amachhiw@linux.ibm.com>

Introduce an Error ** parameter to vfio_spapr_create_window() to enable
structured error reporting. This allows the function to propagate
detailed errors back to callers.

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250408124042.2695955-2-amachhiw@linux.ibm.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/spapr.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
index 66a2d2bb0dc1b7370ab89075085db185ecc56c40..3d6354134c3d517b810d28404f3e2a7eee9b1192 100644
--- a/hw/vfio/spapr.c
+++ b/hw/vfio/spapr.c
@@ -230,9 +230,9 @@ static int vfio_spapr_remove_window(VFIOContainer *container,
     return 0;
 }
 
-static int vfio_spapr_create_window(VFIOContainer *container,
+static bool vfio_spapr_create_window(VFIOContainer *container,
                                     MemoryRegionSection *section,
-                                    hwaddr *pgsize)
+                                    hwaddr *pgsize, Error **errp)
 {
     int ret = 0;
     VFIOContainerBase *bcontainer = &container->bcontainer;
@@ -252,11 +252,11 @@ static int vfio_spapr_create_window(VFIOContainer *container,
     pgmask = bcontainer->pgsizes & (pagesize | (pagesize - 1));
     pagesize = pgmask ? (1ULL << (63 - clz64(pgmask))) : 0;
     if (!pagesize) {
-        error_report("Host doesn't support page size 0x%"PRIx64
-                     ", the supported mask is 0x%lx",
-                     memory_region_iommu_get_min_page_size(iommu_mr),
-                     bcontainer->pgsizes);
-        return -EINVAL;
+        error_setg_errno(errp, EINVAL, "Host doesn't support page size 0x%"PRIx64
+                         ", the supported mask is 0x%lx",
+                         memory_region_iommu_get_min_page_size(iommu_mr),
+                         bcontainer->pgsizes);
+        return false;
     }
 
     /*
@@ -302,17 +302,17 @@ static int vfio_spapr_create_window(VFIOContainer *container,
         }
     }
     if (ret) {
-        error_report("Failed to create a window, ret = %d (%m)", ret);
-        return -errno;
+        error_setg_errno(errp, errno, "Failed to create a window, ret = %d", ret);
+        return false;
     }
 
     if (create.start_addr != section->offset_within_address_space) {
         vfio_spapr_remove_window(container, create.start_addr);
 
-        error_report("Host doesn't support DMA window at %"HWADDR_PRIx", must be %"PRIx64,
-                     section->offset_within_address_space,
-                     (uint64_t)create.start_addr);
-        return -EINVAL;
+        error_setg_errno(errp, EINVAL, "Host doesn't support DMA window at %"HWADDR_PRIx
+                         ", must be %"PRIx64, section->offset_within_address_space,
+                         (uint64_t)create.start_addr);
+        return false;
     }
     trace_vfio_spapr_create_window(create.page_shift,
                                    create.levels,
@@ -320,7 +320,7 @@ static int vfio_spapr_create_window(VFIOContainer *container,
                                    create.start_addr);
     *pgsize = pagesize;
 
-    return 0;
+    return true;
 }
 
 static bool
@@ -377,9 +377,8 @@ vfio_spapr_container_add_section_window(VFIOContainerBase *bcontainer,
         }
     }
 
-    ret = vfio_spapr_create_window(container, section, &pgsize);
-    if (ret) {
-        error_setg_errno(errp, -ret, "Failed to create SPAPR window");
+    ret = vfio_spapr_create_window(container, section, &pgsize, errp);
+    if (!ret) {
         return false;
     }
 
-- 
2.49.0


