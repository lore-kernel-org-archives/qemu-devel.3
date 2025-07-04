Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5411C83F05
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 08:46:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXc3O-0007fl-NV; Fri, 04 Jul 2025 04:45:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uXc3E-0007df-Eg
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 04:45:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uXc3B-0008Ji-ND
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 04:45:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751618741;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wE+XJ85jNc+dBoCJkszkYSjGdKErWQ60+oYEQW5oaSk=;
 b=dR9X+QAJ1WzeF9ABK1rGhbdpmJ0J9n8m2/eaKJgDZsz0acnqgOHfudTb8HW/9CuNbfx0kM
 gCpLtBTkjVgtQaQkfRmT03uc5rAZn9AieoDG4DAeFzmOfGrlOVUGV8Zy2YXIpQtqbQZOFO
 yZLhKwq6sHfSlEQJm/P3iMo57a/qxxo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-42-jVGuzoVyPwiAoYYKfDnaAQ-1; Fri,
 04 Jul 2025 04:45:39 -0400
X-MC-Unique: jVGuzoVyPwiAoYYKfDnaAQ-1
X-Mimecast-MFC-AGG-ID: jVGuzoVyPwiAoYYKfDnaAQ_1751618738
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6C5E9180029E; Fri,  4 Jul 2025 08:45:38 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.43])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3F5BE19560A7; Fri,  4 Jul 2025 08:45:35 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 02/27] vfio/container: Fix vfio_container_post_load()
Date: Fri,  4 Jul 2025 10:45:03 +0200
Message-ID: <20250704084528.1412959-3-clg@redhat.com>
In-Reply-To: <20250704084528.1412959-1-clg@redhat.com>
References: <20250704084528.1412959-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

When there are multiple VFIO containers, vioc->dma_map is restored
multiple times, this made only first container work and remaining
containers using vioc->dma_map restored by first container.

Fix it by save and restore vioc->dma_map locally. saved_dma_map in
VFIOContainerCPR becomes useless and is removed.

Fixes: 7e9f21411302 ("vfio/container: restore DMA vaddr")
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Steve Sistare <steven.sistare@oracle.com>
Link: https://lore.kernel.org/qemu-devel/20250627063332.5173-3-zhenzhong.duan@intel.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-cpr.h |  7 ++++---
 hw/vfio/cpr-legacy.c       | 23 +++++++++--------------
 2 files changed, 13 insertions(+), 17 deletions(-)

diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
index 8bf85b9f4ec2cd712ef835dc5d720fe03d767d03..dbb2a16b7a8174c15412a9297e0beb3d274ab520 100644
--- a/include/hw/vfio/vfio-cpr.h
+++ b/include/hw/vfio/vfio-cpr.h
@@ -16,14 +16,15 @@ struct VFIOContainer;
 struct VFIOContainerBase;
 struct VFIOGroup;
 
+typedef int (*dma_map_fn)(const struct VFIOContainerBase *bcontainer,
+                          hwaddr iova, ram_addr_t size, void *vaddr,
+                          bool readonly, MemoryRegion *mr);
+
 typedef struct VFIOContainerCPR {
     Error *blocker;
     bool vaddr_unmapped;
     NotifierWithReturn transfer_notifier;
     MemoryListener remap_listener;
-    int (*saved_dma_map)(const struct VFIOContainerBase *bcontainer,
-                         hwaddr iova, ram_addr_t size,
-                         void *vaddr, bool readonly, MemoryRegion *mr);
 } VFIOContainerCPR;
 
 typedef struct VFIODeviceCPR {
diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
index 0a5d1bd480ee510f4ab5fc952170fba80a5f41c8..1216717546ca13d6f33e802777aa69ab4d59ecba 100644
--- a/hw/vfio/cpr-legacy.c
+++ b/hw/vfio/cpr-legacy.c
@@ -99,20 +99,21 @@ static int vfio_container_post_load(void *opaque, int version_id)
 {
     VFIOContainer *container = opaque;
     VFIOContainerBase *bcontainer = &container->bcontainer;
-    VFIOGroup *group;
+    VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
+    dma_map_fn saved_dma_map = vioc->dma_map;
     Error *local_err = NULL;
 
+    /* During incoming CPR, divert calls to dma_map. */
+    vioc->dma_map = vfio_legacy_cpr_dma_map;
+
     if (!vfio_listener_register(bcontainer, &local_err)) {
         error_report_err(local_err);
         return -1;
     }
 
-    QLIST_FOREACH(group, &container->group_list, container_next) {
-        VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
+    /* Restore original dma_map function */
+    vioc->dma_map = saved_dma_map;
 
-        /* Restore original dma_map function */
-        vioc->dma_map = container->cpr.saved_dma_map;
-    }
     return 0;
 }
 
@@ -148,6 +149,7 @@ static int vfio_cpr_fail_notifier(NotifierWithReturn *notifier,
          */
 
         VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
+        dma_map_fn saved_dma_map = vioc->dma_map;
         vioc->dma_map = vfio_legacy_cpr_dma_map;
 
         container->cpr.remap_listener = (MemoryListener) {
@@ -158,7 +160,7 @@ static int vfio_cpr_fail_notifier(NotifierWithReturn *notifier,
                                  bcontainer->space->as);
         memory_listener_unregister(&container->cpr.remap_listener);
         container->cpr.vaddr_unmapped = false;
-        vioc->dma_map = container->cpr.saved_dma_map;
+        vioc->dma_map = saved_dma_map;
     }
     return 0;
 }
@@ -179,13 +181,6 @@ bool vfio_legacy_cpr_register_container(VFIOContainer *container, Error **errp)
 
     vmstate_register(NULL, -1, &vfio_container_vmstate, container);
 
-    /* During incoming CPR, divert calls to dma_map. */
-    VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
-    container->cpr.saved_dma_map = vioc->dma_map;
-    if (cpr_is_incoming()) {
-        vioc->dma_map = vfio_legacy_cpr_dma_map;
-    }
-
     migration_add_notifier_mode(&container->cpr.transfer_notifier,
                                 vfio_cpr_fail_notifier,
                                 MIG_MODE_CPR_TRANSFER);
-- 
2.50.0


