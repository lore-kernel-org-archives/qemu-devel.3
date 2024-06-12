Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DC32C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 13:12:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHNcN-0003RP-KD; Wed, 12 Jun 2024 09:02:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sHNcD-0003Dk-1L
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 09:02:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sHNc3-00080r-3h
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 09:02:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718197321;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wZmcgFMvgRdwuVB8jTrsKpoEok8IGGidAmfsen4KOfg=;
 b=GEBI/oYYpo4n9sYicrR6ZDdcmhxXCYE3jd6RAFVVPPWdh4AfETeHFnzloEdxK/KwtUJrU7
 Y3DNepqXElOljfWaDy3BHy4vVndBaX/zSJ7WsuYBzBw92VQ2ew4LxSPaE9U1MHEKb+w+0z
 AYARAGlzNm/eO0rKtMNkuEVLq+A4YQM=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-179-aWog0iRPPZab3__3kgdIBw-1; Wed,
 12 Jun 2024 09:01:57 -0400
X-MC-Unique: aWog0iRPPZab3__3kgdIBw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E867C1955DC5; Wed, 12 Jun 2024 13:01:56 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.49])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1A3FE1956053; Wed, 12 Jun 2024 13:01:54 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v1 13/16] vfio/container: Introduce an instance_init() handler
Date: Wed, 12 Jun 2024 15:01:19 +0200
Message-ID: <20240612130122.813935-14-clg@redhat.com>
In-Reply-To: <20240612130122.813935-1-clg@redhat.com>
References: <20240612130122.813935-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

This allows us to move the initialization code from vfio_container_init(),
which we will soon remove.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/container-base.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
index 98c15e174dd78df5146ee83c05c98f3ea9c1e52c..3858f5ab1d68e897f9013161d7c5c20c0553029d 100644
--- a/hw/vfio/container-base.c
+++ b/hw/vfio/container-base.c
@@ -75,12 +75,6 @@ void vfio_container_init(VFIOContainerBase *bcontainer,
                          const VFIOIOMMUClass *ops)
 {
     bcontainer->ops = ops;
-    bcontainer->error = NULL;
-    bcontainer->dirty_pages_supported = false;
-    bcontainer->dma_max_mappings = 0;
-    bcontainer->iova_ranges = NULL;
-    QLIST_INIT(&bcontainer->giommu_list);
-    QLIST_INIT(&bcontainer->vrdl_list);
 }
 
 void vfio_container_destroy(VFIOContainerBase *bcontainer)
@@ -99,10 +93,23 @@ void vfio_container_destroy(VFIOContainerBase *bcontainer)
     g_list_free_full(bcontainer->iova_ranges, g_free);
 }
 
+static void vfio_container_instance_init(Object *obj)
+{
+    VFIOContainerBase *bcontainer = VFIO_IOMMU(obj);
+
+    bcontainer->error = NULL;
+    bcontainer->dirty_pages_supported = false;
+    bcontainer->dma_max_mappings = 0;
+    bcontainer->iova_ranges = NULL;
+    QLIST_INIT(&bcontainer->giommu_list);
+    QLIST_INIT(&bcontainer->vrdl_list);
+}
+
 static const TypeInfo types[] = {
     {
         .name = TYPE_VFIO_IOMMU,
         .parent = TYPE_OBJECT,
+        .instance_init = vfio_container_instance_init,
         .instance_size = sizeof(VFIOContainerBase),
         .class_size = sizeof(VFIOIOMMUClass),
         .abstract = true,
-- 
2.45.2


