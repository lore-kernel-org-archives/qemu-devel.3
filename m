Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F4178E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 15:19:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQ6e5-0007XH-8h; Tue, 24 Dec 2024 10:16:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tQ6dz-0007IN-7Y
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 10:16:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tQ6dx-00045J-I2
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 10:16:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735053381;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IEgAdogEzbKyknL1BFXfkTdpSmiNeDGhUW7lvmH4k1k=;
 b=XK9vAkpWlNLk/hYSbSFWfyvmHE8sbNJceBJLMBspvhuNENBKcG6NL4llD48BNC5dUrdw7j
 BGnAk/C+vvCRtSoUX08JZlXC6J/DeMJOAGXN6JvUImOI73tqW6i40dnsG0P4cqol7DB3a+
 UYOF3XXFE+839JjGloHTajba0qm/Mz0=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-518-NMO3wECEMEWt8HUqODVc0g-1; Tue,
 24 Dec 2024 10:16:16 -0500
X-MC-Unique: NMO3wECEMEWt8HUqODVc0g-1
X-Mimecast-MFC-AGG-ID: NMO3wECEMEWt8HUqODVc0g
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1502019560AB; Tue, 24 Dec 2024 15:16:15 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.6])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7F3E73000197; Tue, 24 Dec 2024 15:16:13 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 11/17] vfio/container: Add dirty tracking started flag
Date: Tue, 24 Dec 2024 16:15:41 +0100
Message-ID: <20241224151547.386529-12-clg@redhat.com>
In-Reply-To: <20241224151547.386529-1-clg@redhat.com>
References: <20241224151547.386529-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

From: Avihai Horon <avihaih@nvidia.com>

Add a flag to VFIOContainerBase that indicates whether dirty tracking
has been started for the container or not.

This will be used in the following patches to allow dirty page syncs
only if dirty tracking has been started.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Reviewed-by: Joao Martins <joao.m.martins@oracle.com>
Tested-by: Joao Martins <joao.m.martins@oracle.com>
Link: https://lore.kernel.org/r/20241218134022.21264-2-avihaih@nvidia.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-container-base.h |  1 +
 hw/vfio/container-base.c              | 12 +++++++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index 62a8b60d87db263225147a21eff2ef6e21cb22df..4cff9943ab4861a25d07b5ebd1200509ebfab12d 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -44,6 +44,7 @@ typedef struct VFIOContainerBase {
     unsigned long pgsizes;
     unsigned int dma_max_mappings;
     bool dirty_pages_supported;
+    bool dirty_pages_started; /* Protected by BQL */
     QLIST_HEAD(, VFIOGuestIOMMU) giommu_list;
     QLIST_HEAD(, VFIORamDiscardListener) vrdl_list;
     QLIST_ENTRY(VFIOContainerBase) next;
diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
index 6f86c37d971ec38426dacd471bca837c0d0df806..749a3fd29dd6fc9143f14edf7e4ac6238315fcce 100644
--- a/hw/vfio/container-base.c
+++ b/hw/vfio/container-base.c
@@ -64,13 +64,23 @@ int vfio_container_set_dirty_page_tracking(VFIOContainerBase *bcontainer,
                                            bool start, Error **errp)
 {
     VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
+    int ret;
 
     if (!bcontainer->dirty_pages_supported) {
         return 0;
     }
 
     g_assert(vioc->set_dirty_page_tracking);
-    return vioc->set_dirty_page_tracking(bcontainer, start, errp);
+    if (bcontainer->dirty_pages_started == start) {
+        return 0;
+    }
+
+    ret = vioc->set_dirty_page_tracking(bcontainer, start, errp);
+    if (!ret) {
+        bcontainer->dirty_pages_started = start;
+    }
+
+    return ret;
 }
 
 int vfio_container_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
-- 
2.47.1


