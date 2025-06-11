Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E817CC678DC
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 15:07:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPN2m-0005G0-Iz; Wed, 11 Jun 2025 11:07:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uPN2k-00052j-1A
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 11:07:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uPN2i-00079E-3q
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 11:07:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749654427;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O3wgTLUn2fR2m5v//wDP/7WBTVXLyozQY2h0ba5Srzo=;
 b=K2HLqAr+mhJwYxdlJvoa0yQzzswu7/vLg+8C/FNCaKDDS0SDbq5OscdBwSUAZrNl0E19s5
 ci4NfeeMTZO7fgEdHlHwN0hUwoKswTIWOrFVMqVXd8gEFCZK58qWbUJ54Q0PZBMUEV700B
 CJ/kGXS/lLKrkjeB7xujSjeKHSQrKFY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-224-zb2MflPXOJyK4ru2aQdGoQ-1; Wed,
 11 Jun 2025 11:07:03 -0400
X-MC-Unique: zb2MflPXOJyK4ru2aQdGoQ-1
X-Mimecast-MFC-AGG-ID: zb2MflPXOJyK4ru2aQdGoQ_1749654422
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A81D018002A4; Wed, 11 Jun 2025 15:07:02 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.225.191])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 133E9180045C; Wed, 11 Jun 2025 15:07:00 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 15/27] vfio/container: restore DMA vaddr
Date: Wed, 11 Jun 2025 17:06:07 +0200
Message-ID: <20250611150620.701903-16-clg@redhat.com>
In-Reply-To: <20250611150620.701903-1-clg@redhat.com>
References: <20250611150620.701903-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Steve Sistare <steven.sistare@oracle.com>

In new QEMU, do not register the memory listener at device creation time.
Register it later, in the container post_load handler, after all vmstate
that may affect regions and mapping boundaries has been loaded.  The
post_load registration will cause the listener to invoke its callback on
each flat section, and the calls will match the mappings remembered by the
kernel.

The listener calls a special dma_map handler that passes the new VA of each
section to the kernel using VFIO_DMA_MAP_FLAG_VADDR.  Restore the normal
handler at the end.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/1749569991-25171-7-git-send-email-steven.sistare@oracle.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-cpr.h |  3 ++
 hw/vfio/container.c        | 15 ++++++++--
 hw/vfio/cpr-legacy.c       | 57 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 73 insertions(+), 2 deletions(-)

diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
index 5a2e5f6b21e690cf91fd731ff9aa21a569f92f61..04624475f87361954a09ba3c9a47cf1d8e7cc5b3 100644
--- a/include/hw/vfio/vfio-cpr.h
+++ b/include/hw/vfio/vfio-cpr.h
@@ -17,6 +17,9 @@ struct VFIOGroup;
 
 typedef struct VFIOContainerCPR {
     Error *blocker;
+    int (*saved_dma_map)(const struct VFIOContainerBase *bcontainer,
+                         hwaddr iova, ram_addr_t size,
+                         void *vaddr, bool readonly, MemoryRegion *mr);
 } VFIOContainerCPR;
 
 
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 5caae4ccae59bf114f37a49019c40bb125ed4ba1..936ce37f190686b0875ed934ee277d9e4ff8cb2f 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -136,6 +136,8 @@ static int vfio_legacy_dma_unmap_one(const VFIOContainerBase *bcontainer,
     int ret;
     Error *local_err = NULL;
 
+    g_assert(!cpr_is_incoming());
+
     if (iotlb && vfio_container_dirty_tracking_is_started(bcontainer)) {
         if (!vfio_container_devices_dirty_tracking_is_supported(bcontainer) &&
             bcontainer->dirty_pages_supported) {
@@ -690,8 +692,17 @@ static bool vfio_container_connect(VFIOGroup *group, AddressSpace *as,
     }
     group_was_added = true;
 
-    if (!vfio_listener_register(bcontainer, errp)) {
-        goto fail;
+    /*
+     * If CPR, register the listener later, after all state that may
+     * affect regions and mapping boundaries has been cpr load'ed.  Later,
+     * the listener will invoke its callback on each flat section and call
+     * dma_map to supply the new vaddr, and the calls will match the mappings
+     * remembered by the kernel.
+     */
+    if (!cpr_is_incoming()) {
+        if (!vfio_listener_register(bcontainer, errp)) {
+            goto fail;
+        }
     }
 
     bcontainer->initialized = true;
diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
index ef106d0ea865e86e3fdce86928e987e812724a0e..2fd8348c7cd37964af87ef04e32ce3dcd2bfde1a 100644
--- a/hw/vfio/cpr-legacy.c
+++ b/hw/vfio/cpr-legacy.c
@@ -9,11 +9,13 @@
 #include "qemu/osdep.h"
 #include "hw/vfio/vfio-container.h"
 #include "hw/vfio/vfio-device.h"
+#include "hw/vfio/vfio-listener.h"
 #include "migration/blocker.h"
 #include "migration/cpr.h"
 #include "migration/migration.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
+#include "qemu/error-report.h"
 
 static bool vfio_dma_unmap_vaddr_all(VFIOContainer *container, Error **errp)
 {
@@ -30,6 +32,32 @@ static bool vfio_dma_unmap_vaddr_all(VFIOContainer *container, Error **errp)
     return true;
 }
 
+/*
+ * Set the new @vaddr for any mappings registered during cpr load.
+ * The incoming state is cleared thereafter.
+ */
+static int vfio_legacy_cpr_dma_map(const VFIOContainerBase *bcontainer,
+                                   hwaddr iova, ram_addr_t size, void *vaddr,
+                                   bool readonly, MemoryRegion *mr)
+{
+    const VFIOContainer *container = container_of(bcontainer, VFIOContainer,
+                                                  bcontainer);
+    struct vfio_iommu_type1_dma_map map = {
+        .argsz = sizeof(map),
+        .flags = VFIO_DMA_MAP_FLAG_VADDR,
+        .vaddr = (__u64)(uintptr_t)vaddr,
+        .iova = iova,
+        .size = size,
+    };
+
+    g_assert(cpr_is_incoming());
+
+    if (ioctl(container->fd, VFIO_IOMMU_MAP_DMA, &map)) {
+        return -errno;
+    }
+
+    return 0;
+}
 
 static bool vfio_cpr_supported(VFIOContainer *container, Error **errp)
 {
@@ -58,11 +86,34 @@ static int vfio_container_pre_save(void *opaque)
     return 0;
 }
 
+static int vfio_container_post_load(void *opaque, int version_id)
+{
+    VFIOContainer *container = opaque;
+    VFIOContainerBase *bcontainer = &container->bcontainer;
+    VFIOGroup *group;
+    Error *local_err = NULL;
+
+    if (!vfio_listener_register(bcontainer, &local_err)) {
+        error_report_err(local_err);
+        return -1;
+    }
+
+    QLIST_FOREACH(group, &container->group_list, container_next) {
+        VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
+
+        /* Restore original dma_map function */
+        vioc->dma_map = container->cpr.saved_dma_map;
+    }
+    return 0;
+}
+
 static const VMStateDescription vfio_container_vmstate = {
     .name = "vfio-container",
     .version_id = 0,
     .minimum_version_id = 0,
+    .priority = MIG_PRI_LOW,  /* Must happen after devices and groups */
     .pre_save = vfio_container_pre_save,
+    .post_load = vfio_container_post_load,
     .needed = cpr_incoming_needed,
     .fields = (VMStateField[]) {
         VMSTATE_END_OF_LIST()
@@ -85,6 +136,12 @@ bool vfio_legacy_cpr_register_container(VFIOContainer *container, Error **errp)
 
     vmstate_register(NULL, -1, &vfio_container_vmstate, container);
 
+    /* During incoming CPR, divert calls to dma_map. */
+    if (cpr_is_incoming()) {
+        VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
+        container->cpr.saved_dma_map = vioc->dma_map;
+        vioc->dma_map = vfio_legacy_cpr_dma_map;
+    }
     return true;
 }
 
-- 
2.49.0


