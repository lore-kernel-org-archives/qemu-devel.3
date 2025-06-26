Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A025C77B7F
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Jun 2025 07:48:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUhJq-0005b0-Ef; Thu, 26 Jun 2025 03:46:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uUhJi-0005G6-Ra
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 03:46:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uUhJc-00020Q-VC
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 03:46:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750923995;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=52nDQriU5UkQa7Cq5IVTKOLBOOicAj6GSABdDv3pt98=;
 b=OUhvh+2rkuvoXpxsYt/WcBq+WL5iKibHa7sugVuanxAy9y7HvWggxLNRjssO1E0mfd5HUR
 5vfTkJUehCwDooasZEKE0VjR1ezEWWE/cGTRns//16yKQbpUsLHX16Gox7pOECJI4M+e/B
 upu43CVqzgGKniaBlXtf7FswmLPwMeU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-679-DX5jjTBPOXeYbuxzrZ8PYg-1; Thu,
 26 Jun 2025 03:46:31 -0400
X-MC-Unique: DX5jjTBPOXeYbuxzrZ8PYg-1
X-Mimecast-MFC-AGG-ID: DX5jjTBPOXeYbuxzrZ8PYg_1750923990
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 233721808993; Thu, 26 Jun 2025 07:46:30 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.51])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 295A6180045B; Thu, 26 Jun 2025 07:46:26 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 John Levon <levon@movementarian.org>,
 John Johnson <john.g.johnson@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 John Levon <john.levon@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 19/25] vfio-user: implement VFIO_USER_DMA_MAP/UNMAP
Date: Thu, 26 Jun 2025 09:45:23 +0200
Message-ID: <20250626074529.1384114-20-clg@redhat.com>
In-Reply-To: <20250626074529.1384114-1-clg@redhat.com>
References: <20250626074529.1384114-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: John Levon <levon@movementarian.org>

When the vfio-user container gets mapping updates, share them with the
vfio-user by sending a message; this can include the region fd, allowing
the server to directly mmap() the region as needed.

For performance, we only wait for the message responses when we're doing
with a series of updates via the listener_commit() callback.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250625193012.2316242-14-john.levon@nutanix.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio-user/protocol.h   |  32 +++++++++
 hw/vfio-user/proxy.h      |   6 ++
 hw/vfio-user/container.c  | 135 +++++++++++++++++++++++++++++++++++++-
 hw/vfio-user/proxy.c      |  84 +++++++++++++++++++++++-
 hw/vfio-user/trace-events |   4 ++
 5 files changed, 257 insertions(+), 4 deletions(-)

diff --git a/hw/vfio-user/protocol.h b/hw/vfio-user/protocol.h
index 48144b2c33324faad4a07e1457a4709575466afb..524f3d633ab8800ad0934ffad861c7b86a8e70b3 100644
--- a/hw/vfio-user/protocol.h
+++ b/hw/vfio-user/protocol.h
@@ -112,6 +112,31 @@ typedef struct {
  */
 #define VFIO_USER_DEF_MAX_BITMAP (256 * 1024 * 1024)
 
+/*
+ * VFIO_USER_DMA_MAP
+ * imported from struct vfio_iommu_type1_dma_map
+ */
+typedef struct {
+    VFIOUserHdr hdr;
+    uint32_t argsz;
+    uint32_t flags;
+    uint64_t offset;    /* FD offset */
+    uint64_t iova;
+    uint64_t size;
+} VFIOUserDMAMap;
+
+/*
+ * VFIO_USER_DMA_UNMAP
+ * imported from struct vfio_iommu_type1_dma_unmap
+ */
+typedef struct {
+    VFIOUserHdr hdr;
+    uint32_t argsz;
+    uint32_t flags;
+    uint64_t iova;
+    uint64_t size;
+} VFIOUserDMAUnmap;
+
 /*
  * VFIO_USER_DEVICE_GET_INFO
  * imported from struct vfio_device_info
@@ -175,4 +200,11 @@ typedef struct {
     char data[];
 } VFIOUserRegionRW;
 
+/*imported from struct vfio_bitmap */
+typedef struct {
+    uint64_t pgsize;
+    uint64_t size;
+    char data[];
+} VFIOUserBitmap;
+
 #endif /* VFIO_USER_PROTOCOL_H */
diff --git a/hw/vfio-user/proxy.h b/hw/vfio-user/proxy.h
index ba1c33aba8d08083c9afd2f203ed0a04a56cf70f..e2fc83ca3b12aa891d6843345c7c5015e8811aa5 100644
--- a/hw/vfio-user/proxy.h
+++ b/hw/vfio-user/proxy.h
@@ -70,6 +70,7 @@ typedef struct VFIOUserProxy {
     QemuCond close_cv;
     AioContext *ctx;
     QEMUBH *req_bh;
+    bool async_ops;
 
     /*
      * above only changed when BQL is held
@@ -99,9 +100,14 @@ void vfio_user_set_handler(VFIODevice *vbasedev,
                            void *reqarg);
 bool vfio_user_validate_version(VFIOUserProxy *proxy, Error **errp);
 
+VFIOUserFDs *vfio_user_getfds(int numfds);
+
 void vfio_user_request_msg(VFIOUserHdr *hdr, uint16_t cmd,
                            uint32_t size, uint32_t flags);
+void vfio_user_wait_reqs(VFIOUserProxy *proxy);
 bool vfio_user_send_wait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
                          VFIOUserFDs *fds, int rsize, Error **errp);
+bool vfio_user_send_nowait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
+                           VFIOUserFDs *fds, int rsize, Error **errp);
 
 #endif /* VFIO_USER_PROXY_H */
diff --git a/hw/vfio-user/container.c b/hw/vfio-user/container.c
index b4a5a840b089c5622ade83e632c2560475076e5b..3133fef17738e14fc512ad5272bc349d928c980a 100644
--- a/hw/vfio-user/container.c
+++ b/hw/vfio-user/container.c
@@ -12,23 +12,152 @@
 
 #include "hw/vfio-user/container.h"
 #include "hw/vfio-user/device.h"
+#include "hw/vfio-user/trace.h"
 #include "hw/vfio/vfio-cpr.h"
 #include "hw/vfio/vfio-device.h"
 #include "hw/vfio/vfio-listener.h"
 #include "qapi/error.h"
 
+/*
+ * When DMA space is the physical address space, the region add/del listeners
+ * will fire during memory update transactions.  These depend on BQL being held,
+ * so do any resulting map/demap ops async while keeping BQL.
+ */
+static void vfio_user_listener_begin(VFIOContainerBase *bcontainer)
+{
+    VFIOUserContainer *container = container_of(bcontainer, VFIOUserContainer,
+                                                 bcontainer);
+
+    container->proxy->async_ops = true;
+}
+
+static void vfio_user_listener_commit(VFIOContainerBase *bcontainer)
+{
+    VFIOUserContainer *container = container_of(bcontainer, VFIOUserContainer,
+                                            bcontainer);
+
+    /* wait here for any async requests sent during the transaction */
+    container->proxy->async_ops = false;
+    vfio_user_wait_reqs(container->proxy);
+}
+
 static int vfio_user_dma_unmap(const VFIOContainerBase *bcontainer,
                                hwaddr iova, ram_addr_t size,
                                IOMMUTLBEntry *iotlb, bool unmap_all)
 {
-    return -ENOTSUP;
+    VFIOUserContainer *container = container_of(bcontainer, VFIOUserContainer,
+                                            bcontainer);
+    Error *local_err = NULL;
+    int ret = 0;
+
+    VFIOUserDMAUnmap *msgp = g_malloc(sizeof(*msgp));
+
+    vfio_user_request_msg(&msgp->hdr, VFIO_USER_DMA_UNMAP, sizeof(*msgp), 0);
+    msgp->argsz = sizeof(struct vfio_iommu_type1_dma_unmap);
+    msgp->flags = unmap_all ? VFIO_DMA_UNMAP_FLAG_ALL : 0;
+    msgp->iova = iova;
+    msgp->size = size;
+    trace_vfio_user_dma_unmap(msgp->iova, msgp->size, msgp->flags,
+                              container->proxy->async_ops);
+
+    if (container->proxy->async_ops) {
+        if (!vfio_user_send_nowait(container->proxy, &msgp->hdr, NULL,
+                              0, &local_err)) {
+            error_report_err(local_err);
+            ret = -EFAULT;
+        } else {
+            ret = 0;
+        }
+    } else {
+        if (!vfio_user_send_wait(container->proxy, &msgp->hdr, NULL,
+                                 0, &local_err)) {
+                error_report_err(local_err);
+                ret = -EFAULT;
+        }
+
+        if (msgp->hdr.flags & VFIO_USER_ERROR) {
+            ret = -msgp->hdr.error_reply;
+        }
+
+        g_free(msgp);
+    }
+
+    return ret;
 }
 
 static int vfio_user_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
                              ram_addr_t size, void *vaddr, bool readonly,
                              MemoryRegion *mrp)
 {
-    return -ENOTSUP;
+    VFIOUserContainer *container = container_of(bcontainer, VFIOUserContainer,
+                                                bcontainer);
+    int fd = memory_region_get_fd(mrp);
+    Error *local_err = NULL;
+    int ret;
+
+    VFIOUserFDs *fds = NULL;
+    VFIOUserDMAMap *msgp = g_malloc0(sizeof(*msgp));
+
+    vfio_user_request_msg(&msgp->hdr, VFIO_USER_DMA_MAP, sizeof(*msgp), 0);
+    msgp->argsz = sizeof(struct vfio_iommu_type1_dma_map);
+    msgp->flags = VFIO_DMA_MAP_FLAG_READ;
+    msgp->offset = 0;
+    msgp->iova = iova;
+    msgp->size = size;
+
+    /*
+     * vaddr enters as a QEMU process address; make it either a file offset
+     * for mapped areas or leave as 0.
+     */
+    if (fd != -1) {
+        msgp->offset = qemu_ram_block_host_offset(mrp->ram_block, vaddr);
+    }
+
+    if (!readonly) {
+        msgp->flags |= VFIO_DMA_MAP_FLAG_WRITE;
+    }
+
+    trace_vfio_user_dma_map(msgp->iova, msgp->size, msgp->offset, msgp->flags,
+                            container->proxy->async_ops);
+
+    /*
+     * The async_ops case sends without blocking. They're later waited for in
+     * vfio_send_wait_reqs.
+     */
+    if (container->proxy->async_ops) {
+        /* can't use auto variable since we don't block */
+        if (fd != -1) {
+            fds = vfio_user_getfds(1);
+            fds->send_fds = 1;
+            fds->fds[0] = fd;
+        }
+
+        if (!vfio_user_send_nowait(container->proxy, &msgp->hdr, fds,
+                              0, &local_err)) {
+            error_report_err(local_err);
+            ret = -EFAULT;
+        } else {
+            ret = 0;
+        }
+    } else {
+        VFIOUserFDs local_fds = { 1, 0, &fd };
+
+        fds = fd != -1 ? &local_fds : NULL;
+
+        if (!vfio_user_send_wait(container->proxy, &msgp->hdr, fds,
+                                 0, &local_err)) {
+                error_report_err(local_err);
+                ret = -EFAULT;
+        }
+
+        if (msgp->hdr.flags & VFIO_USER_ERROR) {
+            ret = -msgp->hdr.error_reply;
+        }
+
+        g_free(msgp);
+    }
+
+    return ret;
 }
 
 static int
@@ -218,6 +347,8 @@ static void vfio_iommu_user_class_init(ObjectClass *klass, const void *data)
     VFIOIOMMUClass *vioc = VFIO_IOMMU_CLASS(klass);
 
     vioc->setup = vfio_user_setup;
+    vioc->listener_begin = vfio_user_listener_begin,
+    vioc->listener_commit = vfio_user_listener_commit,
     vioc->dma_map = vfio_user_dma_map;
     vioc->dma_unmap = vfio_user_dma_unmap;
     vioc->attach_device = vfio_user_device_attach;
diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
index aed7b22e2a657cfc2ddd391163d380ee5ea22f68..c8ae8a59b441a1151c884dfb8625fde696af664c 100644
--- a/hw/vfio-user/proxy.c
+++ b/hw/vfio-user/proxy.c
@@ -27,7 +27,6 @@ static IOThread *vfio_user_iothread;
 static void vfio_user_shutdown(VFIOUserProxy *proxy);
 static VFIOUserMsg *vfio_user_getmsg(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
                                      VFIOUserFDs *fds);
-static VFIOUserFDs *vfio_user_getfds(int numfds);
 static void vfio_user_recycle(VFIOUserProxy *proxy, VFIOUserMsg *msg);
 
 static void vfio_user_recv(void *opaque);
@@ -132,7 +131,7 @@ static void vfio_user_recycle(VFIOUserProxy *proxy, VFIOUserMsg *msg)
     QTAILQ_INSERT_HEAD(&proxy->free, msg, next);
 }
 
-static VFIOUserFDs *vfio_user_getfds(int numfds)
+VFIOUserFDs *vfio_user_getfds(int numfds)
 {
     VFIOUserFDs *fds = g_malloc0(sizeof(*fds) + (numfds * sizeof(int)));
 
@@ -618,6 +617,43 @@ static bool vfio_user_send_queued(VFIOUserProxy *proxy, VFIOUserMsg *msg,
     return true;
 }
 
+/*
+ * nowait send - vfio_wait_reqs() can wait for it later
+ *
+ * Returns false if we did not successfully receive a reply message, in which
+ * case @errp will be populated.
+ *
+ * In either case, ownership of @hdr and @fds is taken, and the caller must
+ * *not* free them itself.
+ */
+bool vfio_user_send_nowait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
+                           VFIOUserFDs *fds, int rsize, Error **errp)
+{
+    VFIOUserMsg *msg;
+
+    QEMU_LOCK_GUARD(&proxy->lock);
+
+    msg = vfio_user_getmsg(proxy, hdr, fds);
+    msg->id = hdr->id;
+    msg->rsize = rsize ? rsize : hdr->size;
+    msg->type = VFIO_MSG_NOWAIT;
+
+    if (hdr->flags & VFIO_USER_NO_REPLY) {
+        error_setg_errno(errp, EINVAL, "%s on NO_REPLY message", __func__);
+        vfio_user_recycle(proxy, msg);
+        return false;
+    }
+
+    if (!vfio_user_send_queued(proxy, msg, errp)) {
+        vfio_user_recycle(proxy, msg);
+        return false;
+    }
+
+    proxy->last_nowait = msg;
+
+    return true;
+}
+
 /*
  * Returns false if we did not successfully receive a reply message, in which
  * case @errp will be populated.
@@ -666,6 +702,50 @@ bool vfio_user_send_wait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
     return ok;
 }
 
+void vfio_user_wait_reqs(VFIOUserProxy *proxy)
+{
+    VFIOUserMsg *msg;
+
+    /*
+     * Any DMA map/unmap requests sent in the middle
+     * of a memory region transaction were sent nowait.
+     * Wait for them here.
+     */
+    qemu_mutex_lock(&proxy->lock);
+    if (proxy->last_nowait != NULL) {
+        /*
+         * Change type to WAIT to wait for reply
+         */
+        msg = proxy->last_nowait;
+        msg->type = VFIO_MSG_WAIT;
+        proxy->last_nowait = NULL;
+        while (!msg->complete) {
+            if (!qemu_cond_timedwait(&msg->cv, &proxy->lock, wait_time)) {
+                VFIOUserMsgQ *list;
+
+                list = msg->pending ? &proxy->pending : &proxy->outgoing;
+                QTAILQ_REMOVE(list, msg, next);
+                error_printf("vfio_wait_reqs - timed out\n");
+                break;
+            }
+        }
+
+        if (msg->hdr->flags & VFIO_USER_ERROR) {
+            error_printf("vfio_user_wait_reqs - error reply on async ");
+            error_printf("request: command %x error %s\n", msg->hdr->command,
+                         strerror(msg->hdr->error_reply));
+        }
+
+        /*
+         * Change type back to NOWAIT to free
+         */
+        msg->type = VFIO_MSG_NOWAIT;
+        vfio_user_recycle(proxy, msg);
+    }
+
+    qemu_mutex_unlock(&proxy->lock);
+}
+
 static QLIST_HEAD(, VFIOUserProxy) vfio_user_sockets =
     QLIST_HEAD_INITIALIZER(vfio_user_sockets);
 
diff --git a/hw/vfio-user/trace-events b/hw/vfio-user/trace-events
index aa8f3c3d4d3b30e3d5091d77b8ca2fccaa847a73..44dde020b3198e215065c4adcb9d13832e5c4287 100644
--- a/hw/vfio-user/trace-events
+++ b/hw/vfio-user/trace-events
@@ -13,3 +13,7 @@ vfio_user_get_region_info(uint32_t index, uint32_t flags, uint64_t size) " index
 vfio_user_region_rw(uint32_t region, uint64_t off, uint32_t count) " region %d offset 0x%"PRIx64" count %d"
 vfio_user_get_irq_info(uint32_t index, uint32_t flags, uint32_t count) " index %d flags 0x%x count %d"
 vfio_user_set_irqs(uint32_t index, uint32_t start, uint32_t count, uint32_t flags) " index %d start %d count %d flags 0x%x"
+
+# container.c
+vfio_user_dma_map(uint64_t iova, uint64_t size, uint64_t off, uint32_t flags, bool async_ops) " iova 0x%"PRIx64" size 0x%"PRIx64" off 0x%"PRIx64" flags 0x%x async_ops %d"
+vfio_user_dma_unmap(uint64_t iova, uint64_t size, uint32_t flags,  bool async_ops) " iova 0x%"PRIx64" size 0x%"PRIx64" flags 0x%x async_ops %d"
-- 
2.49.0


