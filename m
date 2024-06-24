Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31D5EC30653
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 21:27:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLrCz-0006Ir-9K; Mon, 24 Jun 2024 17:26:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sLrCx-0006Bw-6J
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 17:26:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sLrCv-0006rw-Ii
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 17:26:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719264396;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vz9vSeuLasEHT5I+I8Hgtl8nl0fnQvntfTqHhcbwF6U=;
 b=S1MuGiOrvI5Jy0Rt+MPH0ZedbeQsJ0NgwzQMP0HSPeZVHJmbjMjvEjtQPx87Gl4EnbAmjI
 fJPNNXixQQXNqWP/WCnXBCUMH4SdJxQyAErDl1I9x2Ae4tUe1YYY8ejiYKuaXhCYGZp6VK
 l1ZXodAfrw8dOrjESC7nafOEHawdGgw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-477-erw2HbXJNNKZ-xjEtt1vhA-1; Mon,
 24 Jun 2024 17:26:35 -0400
X-MC-Unique: erw2HbXJNNKZ-xjEtt1vhA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9379C19560B5; Mon, 24 Jun 2024 21:26:34 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.49])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E099B1956053; Mon, 24 Jun 2024 21:26:32 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Eric Auger <eric.auger@redhat.com>
Subject: [PULL 38/42] vfio/container: Introduce an instance_init() handler
Date: Mon, 24 Jun 2024 23:24:52 +0200
Message-ID: <20240624212456.350919-39-clg@redhat.com>
In-Reply-To: <20240624212456.350919-1-clg@redhat.com>
References: <20240624212456.350919-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.207,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
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


