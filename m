Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79941C7115B
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Jun 2025 07:49:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUhJT-0004gD-75; Thu, 26 Jun 2025 03:46:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uUhJI-0004Z0-DL
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 03:46:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uUhJE-0001xe-3L
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 03:46:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750923971;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+zqaNpLmwjF+LRDhKXd6plBT9jkQ1fHc9Vy4M+yxq48=;
 b=ZEvqWpkKiDq4w0brBP1r+rksGQ94U7U3HTwfwHsuAHIaVzkjYyhe25lJRU3DogP+ScvQsg
 IG1czycq2ODqhQ3s/DFB3h3h/XAeahbtJUlzrQUXsX1182LOhPr11ktkUkIVijXmGLyIvi
 lHAtJlrGff4qAQgidTnKgE5VNIxoqFo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-544--d_fnVnAOtKbG7XXi6FDhA-1; Thu,
 26 Jun 2025 03:46:02 -0400
X-MC-Unique: -d_fnVnAOtKbG7XXi6FDhA-1
X-Mimecast-MFC-AGG-ID: -d_fnVnAOtKbG7XXi6FDhA_1750923961
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C9C601944A83; Thu, 26 Jun 2025 07:46:01 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.51])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 64279180045B; Thu, 26 Jun 2025 07:45:59 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 John Levon <john.levon@nutanix.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 10/25] vfio-user: implement message send infrastructure
Date: Thu, 26 Jun 2025 09:45:14 +0200
Message-ID: <20250626074529.1384114-11-clg@redhat.com>
In-Reply-To: <20250626074529.1384114-1-clg@redhat.com>
References: <20250626074529.1384114-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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

From: John Levon <john.levon@nutanix.com>

Add plumbing for sending vfio-user messages on the control socket.
Add initial version negotation on connection.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250625193012.2316242-5-john.levon@nutanix.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio-user/protocol.h   |  62 +++++
 hw/vfio-user/proxy.h      |   9 +
 hw/vfio-user/pci.c        |  20 +-
 hw/vfio-user/proxy.c      | 515 ++++++++++++++++++++++++++++++++++++++
 hw/vfio-user/trace-events |   2 +
 5 files changed, 606 insertions(+), 2 deletions(-)

diff --git a/hw/vfio-user/protocol.h b/hw/vfio-user/protocol.h
index 4ddfb5f222e60c3bd212110bba6855b81f191d27..2d52d0fb10d1418207bf383e5f8ec24230431443 100644
--- a/hw/vfio-user/protocol.h
+++ b/hw/vfio-user/protocol.h
@@ -50,4 +50,66 @@ enum vfio_user_command {
 #define VFIO_USER_NO_REPLY      0x10
 #define VFIO_USER_ERROR         0x20
 
+
+/*
+ * VFIO_USER_VERSION
+ */
+typedef struct {
+    VFIOUserHdr hdr;
+    uint16_t major;
+    uint16_t minor;
+    char capabilities[];
+} VFIOUserVersion;
+
+#define VFIO_USER_MAJOR_VER     0
+#define VFIO_USER_MINOR_VER     0
+
+#define VFIO_USER_CAP           "capabilities"
+
+/* "capabilities" members */
+#define VFIO_USER_CAP_MAX_FDS   "max_msg_fds"
+#define VFIO_USER_CAP_MAX_XFER  "max_data_xfer_size"
+#define VFIO_USER_CAP_PGSIZES   "pgsizes"
+#define VFIO_USER_CAP_MAP_MAX   "max_dma_maps"
+#define VFIO_USER_CAP_MIGR      "migration"
+
+/* "migration" members */
+#define VFIO_USER_CAP_PGSIZE            "pgsize"
+#define VFIO_USER_CAP_MAX_BITMAP        "max_bitmap_size"
+
+/*
+ * Max FDs mainly comes into play when a device supports multiple interrupts
+ * where each ones uses an eventfd to inject it into the guest.
+ * It is clamped by the the number of FDs the qio channel supports in a
+ * single message.
+ */
+#define VFIO_USER_DEF_MAX_FDS   8
+#define VFIO_USER_MAX_MAX_FDS   16
+
+/*
+ * Max transfer limits the amount of data in region and DMA messages.
+ * Region R/W will be very small (limited by how much a single instruction
+ * can process) so just use a reasonable limit here.
+ */
+#define VFIO_USER_DEF_MAX_XFER  (1024 * 1024)
+#define VFIO_USER_MAX_MAX_XFER  (64 * 1024 * 1024)
+
+/*
+ * Default pagesizes supported is 4k.
+ */
+#define VFIO_USER_DEF_PGSIZE    4096
+
+/*
+ * Default max number of DMA mappings is stolen from the
+ * linux kernel "dma_entry_limit"
+ */
+#define VFIO_USER_DEF_MAP_MAX   65535
+
+/*
+ * Default max bitmap size is also take from the linux kernel,
+ * where usage of signed ints limits the VA range to 2^31 bytes.
+ * Dividing that by the number of bits per byte yields 256MB
+ */
+#define VFIO_USER_DEF_MAX_BITMAP (256 * 1024 * 1024)
+
 #endif /* VFIO_USER_PROTOCOL_H */
diff --git a/hw/vfio-user/proxy.h b/hw/vfio-user/proxy.h
index ff553cad9d50ce2ba4867d910adf92836dc068b5..5bc890a0f5f06cce83e2bf54711f7ff9af01cf8b 100644
--- a/hw/vfio-user/proxy.h
+++ b/hw/vfio-user/proxy.h
@@ -37,6 +37,7 @@ typedef struct VFIOUserMsg {
     uint32_t id;
     QemuCond cv;
     bool complete;
+    bool pending;
     enum msg_type type;
 } VFIOUserMsg;
 
@@ -56,6 +57,12 @@ typedef struct VFIOUserProxy {
     struct QIOChannel *ioc;
     void (*request)(void *opaque, VFIOUserMsg *msg);
     void *req_arg;
+    uint64_t max_xfer_size;
+    uint64_t max_send_fds;
+    uint64_t max_dma;
+    uint64_t dma_pgsizes;
+    uint64_t max_bitmap;
+    uint64_t migr_pgsize;
     int flags;
     QemuCond close_cv;
     AioContext *ctx;
@@ -78,6 +85,7 @@ typedef struct VFIOUserProxy {
 
 /* VFIOProxy flags */
 #define VFIO_PROXY_CLIENT        0x1
+#define VFIO_PROXY_FORCE_QUEUED  0x4
 
 typedef struct VFIODevice VFIODevice;
 
@@ -86,5 +94,6 @@ void vfio_user_disconnect(VFIOUserProxy *proxy);
 void vfio_user_set_handler(VFIODevice *vbasedev,
                            void (*handler)(void *opaque, VFIOUserMsg *msg),
                            void *reqarg);
+bool vfio_user_validate_version(VFIOUserProxy *proxy, Error **errp);
 
 #endif /* VFIO_USER_PROXY_H */
diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
index bad2829f5cfc76ef5716a67ffb000c8d78ed360d..61f525cf4a77f0dd0204d1cf28d213ef13824164 100644
--- a/hw/vfio-user/pci.c
+++ b/hw/vfio-user/pci.c
@@ -20,6 +20,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(VFIOUserPCIDevice, VFIO_USER_PCI)
 struct VFIOUserPCIDevice {
     VFIOPCIDevice device;
     SocketAddress *socket;
+    bool send_queued;   /* all sends are queued */
 };
 
 /*
@@ -92,6 +93,16 @@ static void vfio_user_pci_realize(PCIDevice *pdev, Error **errp)
     vbasedev->proxy = proxy;
     vfio_user_set_handler(vbasedev, vfio_user_pci_process_req, vdev);
 
+    vbasedev->name = g_strdup_printf("vfio-user:%s", sock_name);
+
+    if (udev->send_queued) {
+        proxy->flags |= VFIO_PROXY_FORCE_QUEUED;
+    }
+
+    if (!vfio_user_validate_version(proxy, errp)) {
+        goto error;
+    }
+
     /*
      * vfio-user devices are effectively mdevs (don't use a host iommu).
      */
@@ -101,9 +112,13 @@ static void vfio_user_pci_realize(PCIDevice *pdev, Error **errp)
     if (!vfio_device_attach_by_iommu_type(TYPE_VFIO_IOMMU_USER,
                                           vbasedev->name, vbasedev,
                                           as, errp)) {
-        error_prepend(errp, VFIO_MSG_PREFIX, vbasedev->name);
-        return;
+        goto error;
     }
+
+    return;
+
+error:
+    error_prepend(errp, VFIO_MSG_PREFIX, vdev->vbasedev.name);
 }
 
 static void vfio_user_instance_init(Object *obj)
@@ -153,6 +168,7 @@ static const Property vfio_user_pci_dev_properties[] = {
                        sub_vendor_id, PCI_ANY_ID),
     DEFINE_PROP_UINT32("x-pci-sub-device-id", VFIOPCIDevice,
                        sub_device_id, PCI_ANY_ID),
+    DEFINE_PROP_BOOL("x-send-queued", VFIOUserPCIDevice, send_queued, false),
 };
 
 static void vfio_user_pci_set_socket(Object *obj, Visitor *v, const char *name,
diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
index 349ea2b27c9877993125f4f0f3ca27cb4df9b1b3..874142e9e50ced664a7fce71971eaa040cfe1e2b 100644
--- a/hw/vfio-user/proxy.c
+++ b/hw/vfio-user/proxy.c
@@ -13,11 +13,15 @@
 #include "hw/vfio-user/proxy.h"
 #include "hw/vfio-user/trace.h"
 #include "qapi/error.h"
+#include "qobject/qdict.h"
+#include "qobject/qjson.h"
+#include "qobject/qnum.h"
 #include "qemu/error-report.h"
 #include "qemu/lockable.h"
 #include "qemu/main-loop.h"
 #include "system/iothread.h"
 
+static int wait_time = 5000;   /* wait up to 5 sec for busy servers */
 static IOThread *vfio_user_iothread;
 
 static void vfio_user_shutdown(VFIOUserProxy *proxy);
@@ -27,9 +31,12 @@ static VFIOUserFDs *vfio_user_getfds(int numfds);
 static void vfio_user_recycle(VFIOUserProxy *proxy, VFIOUserMsg *msg);
 
 static void vfio_user_recv(void *opaque);
+static void vfio_user_send(void *opaque);
 static void vfio_user_cb(void *opaque);
 
 static void vfio_user_request(void *opaque);
+static void vfio_user_request_msg(VFIOUserHdr *hdr, uint16_t cmd,
+                                  uint32_t size, uint32_t flags);
 
 static inline void vfio_user_set_error(VFIOUserHdr *hdr, uint32_t err)
 {
@@ -48,6 +55,41 @@ static void vfio_user_shutdown(VFIOUserProxy *proxy)
                                    proxy->ctx, NULL, NULL);
 }
 
+/*
+ * Same return values as qio_channel_writev_full():
+ *
+ * QIO_CHANNEL_ERR_BLOCK: *errp not set
+ * -1: *errp will be populated
+ * otherwise: bytes written
+ */
+static ssize_t vfio_user_send_qio(VFIOUserProxy *proxy, VFIOUserMsg *msg,
+                                  Error **errp)
+{
+    VFIOUserFDs *fds =  msg->fds;
+    struct iovec iov = {
+        .iov_base = msg->hdr,
+        .iov_len = msg->hdr->size,
+    };
+    size_t numfds = 0;
+    int *fdp = NULL;
+    ssize_t ret;
+
+    if (fds != NULL && fds->send_fds != 0) {
+        numfds = fds->send_fds;
+        fdp = fds->fds;
+    }
+
+    ret = qio_channel_writev_full(proxy->ioc, &iov, 1, fdp, numfds, 0, errp);
+
+    if (ret == -1) {
+        vfio_user_set_error(msg->hdr, EIO);
+        vfio_user_shutdown(proxy);
+    }
+    trace_vfio_user_send_write(msg->hdr->id, ret);
+
+    return ret;
+}
+
 static VFIOUserMsg *vfio_user_getmsg(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
                                      VFIOUserFDs *fds)
 {
@@ -88,6 +130,7 @@ static void vfio_user_recycle(VFIOUserProxy *proxy, VFIOUserMsg *msg)
     msg->hdr = NULL;
     msg->fds = NULL;
     msg->complete = false;
+    msg->pending = false;
     QTAILQ_INSERT_HEAD(&proxy->free, msg, next);
 }
 
@@ -385,6 +428,62 @@ static void vfio_user_recv(void *opaque)
     }
 }
 
+/*
+ * Send a single message, same return semantics as vfio_user_send_qio().
+ *
+ * Sent async messages are freed, others are moved to pending queue.
+ */
+static ssize_t vfio_user_send_one(VFIOUserProxy *proxy, Error **errp)
+{
+    VFIOUserMsg *msg;
+    ssize_t ret;
+
+    msg = QTAILQ_FIRST(&proxy->outgoing);
+    ret = vfio_user_send_qio(proxy, msg, errp);
+    if (ret < 0) {
+        return ret;
+    }
+
+    QTAILQ_REMOVE(&proxy->outgoing, msg, next);
+    if (msg->type == VFIO_MSG_ASYNC) {
+        vfio_user_recycle(proxy, msg);
+    } else {
+        QTAILQ_INSERT_TAIL(&proxy->pending, msg, next);
+        msg->pending = true;
+    }
+
+    return ret;
+}
+
+/*
+ * Send messages from outgoing queue when the socket buffer has space.
+ * If we deplete 'outgoing', remove ourselves from the poll list.
+ */
+static void vfio_user_send(void *opaque)
+{
+    VFIOUserProxy *proxy = opaque;
+
+    QEMU_LOCK_GUARD(&proxy->lock);
+
+    if (proxy->state == VFIO_PROXY_CONNECTED) {
+        while (!QTAILQ_EMPTY(&proxy->outgoing)) {
+            Error *local_err = NULL;
+            int ret;
+
+            ret = vfio_user_send_one(proxy, &local_err);
+
+            if (ret == QIO_CHANNEL_ERR_BLOCK) {
+                return;
+            } else if (ret == -1) {
+                error_report_err(local_err);
+                return;
+            }
+        }
+        qio_channel_set_aio_fd_handler(proxy->ioc, proxy->ctx,
+                                       vfio_user_recv, NULL, NULL, proxy);
+    }
+}
+
 static void vfio_user_cb(void *opaque)
 {
     VFIOUserProxy *proxy = opaque;
@@ -446,6 +545,128 @@ static void vfio_user_request(void *opaque)
     }
 }
 
+/*
+ * Messages are queued onto the proxy's outgoing list.
+ *
+ * It handles 3 types of messages:
+ *
+ * async messages - replies and posted writes
+ *
+ * There will be no reply from the server, so message
+ * buffers are freed after they're sent.
+ *
+ * nowait messages - map/unmap during address space transactions
+ *
+ * These are also sent async, but a reply is expected so that
+ * vfio_wait_reqs() can wait for the youngest nowait request.
+ * They transition from the outgoing list to the pending list
+ * when sent, and are freed when the reply is received.
+ *
+ * wait messages - all other requests
+ *
+ * The reply to these messages is waited for by their caller.
+ * They also transition from outgoing to pending when sent, but
+ * the message buffer is returned to the caller with the reply
+ * contents.  The caller is responsible for freeing these messages.
+ *
+ * As an optimization, if the outgoing list and the socket send
+ * buffer are empty, the message is sent inline instead of being
+ * added to the outgoing list.  The rest of the transitions are
+ * unchanged.
+ */
+static bool vfio_user_send_queued(VFIOUserProxy *proxy, VFIOUserMsg *msg,
+                                  Error **errp)
+{
+    int ret;
+
+    /*
+     * Unsent outgoing msgs - add to tail
+     */
+    if (!QTAILQ_EMPTY(&proxy->outgoing)) {
+        QTAILQ_INSERT_TAIL(&proxy->outgoing, msg, next);
+        return true;
+    }
+
+    /*
+     * Try inline - if blocked, queue it and kick send poller
+     */
+    if (proxy->flags & VFIO_PROXY_FORCE_QUEUED) {
+        ret = QIO_CHANNEL_ERR_BLOCK;
+    } else {
+        ret = vfio_user_send_qio(proxy, msg, errp);
+    }
+
+    if (ret == QIO_CHANNEL_ERR_BLOCK) {
+        QTAILQ_INSERT_HEAD(&proxy->outgoing, msg, next);
+        qio_channel_set_aio_fd_handler(proxy->ioc, proxy->ctx,
+                                       vfio_user_recv, proxy->ctx,
+                                       vfio_user_send, proxy);
+        return true;
+    }
+    if (ret == -1) {
+        return false;
+    }
+
+    /*
+     * Sent - free async, add others to pending
+     */
+    if (msg->type == VFIO_MSG_ASYNC) {
+        vfio_user_recycle(proxy, msg);
+    } else {
+        QTAILQ_INSERT_TAIL(&proxy->pending, msg, next);
+        msg->pending = true;
+    }
+
+    return true;
+}
+
+/*
+ * Returns false if we did not successfully receive a reply message, in which
+ * case @errp will be populated.
+ *
+ * In either case, the caller must free @hdr and @fds if needed.
+ */
+static bool vfio_user_send_wait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
+                                VFIOUserFDs *fds, int rsize, Error **errp)
+{
+    VFIOUserMsg *msg;
+    bool ok = false;
+
+    if (hdr->flags & VFIO_USER_NO_REPLY) {
+        error_setg_errno(errp, EINVAL, "%s on NO_REPLY message", __func__);
+        return false;
+    }
+
+    qemu_mutex_lock(&proxy->lock);
+
+    msg = vfio_user_getmsg(proxy, hdr, fds);
+    msg->id = hdr->id;
+    msg->rsize = rsize ? rsize : hdr->size;
+    msg->type = VFIO_MSG_WAIT;
+
+    ok = vfio_user_send_queued(proxy, msg, errp);
+
+    if (ok) {
+        while (!msg->complete) {
+            if (!qemu_cond_timedwait(&msg->cv, &proxy->lock, wait_time)) {
+                VFIOUserMsgQ *list;
+
+                list = msg->pending ? &proxy->pending : &proxy->outgoing;
+                QTAILQ_REMOVE(list, msg, next);
+                error_setg_errno(errp, ETIMEDOUT,
+                                 "timed out waiting for reply");
+                ok = false;
+                break;
+            }
+        }
+    }
+
+    vfio_user_recycle(proxy, msg);
+
+    qemu_mutex_unlock(&proxy->lock);
+
+    return ok;
+}
 
 static QLIST_HEAD(, VFIOUserProxy) vfio_user_sockets =
     QLIST_HEAD_INITIALIZER(vfio_user_sockets);
@@ -474,6 +695,15 @@ VFIOUserProxy *vfio_user_connect_dev(SocketAddress *addr, Error **errp)
     proxy = g_malloc0(sizeof(VFIOUserProxy));
     proxy->sockname = g_strdup_printf("unix:%s", sockname);
     proxy->ioc = ioc;
+
+    /* init defaults */
+    proxy->max_xfer_size = VFIO_USER_DEF_MAX_XFER;
+    proxy->max_send_fds = VFIO_USER_DEF_MAX_FDS;
+    proxy->max_dma = VFIO_USER_DEF_MAP_MAX;
+    proxy->dma_pgsizes = VFIO_USER_DEF_PGSIZE;
+    proxy->max_bitmap = VFIO_USER_DEF_MAX_BITMAP;
+    proxy->migr_pgsize = VFIO_USER_DEF_PGSIZE;
+
     proxy->flags = VFIO_PROXY_CLIENT;
     proxy->state = VFIO_PROXY_CONNECTED;
 
@@ -571,3 +801,288 @@ void vfio_user_disconnect(VFIOUserProxy *proxy)
     g_free(proxy->sockname);
     g_free(proxy);
 }
+
+static void vfio_user_request_msg(VFIOUserHdr *hdr, uint16_t cmd,
+                                  uint32_t size, uint32_t flags)
+{
+    static uint16_t next_id;
+
+    hdr->id = qatomic_fetch_inc(&next_id);
+    hdr->command = cmd;
+    hdr->size = size;
+    hdr->flags = (flags & ~VFIO_USER_TYPE) | VFIO_USER_REQUEST;
+    hdr->error_reply = 0;
+}
+
+struct cap_entry {
+    const char *name;
+    bool (*check)(VFIOUserProxy *proxy, QObject *qobj, Error **errp);
+};
+
+static bool caps_parse(VFIOUserProxy *proxy, QDict *qdict,
+                       struct cap_entry caps[], Error **errp)
+{
+    QObject *qobj;
+    struct cap_entry *p;
+
+    for (p = caps; p->name != NULL; p++) {
+        qobj = qdict_get(qdict, p->name);
+        if (qobj != NULL) {
+            if (!p->check(proxy, qobj, errp)) {
+                return false;
+            }
+            qdict_del(qdict, p->name);
+        }
+    }
+
+    /* warning, for now */
+    if (qdict_size(qdict) != 0) {
+        warn_report("spurious capabilities");
+    }
+    return true;
+}
+
+static bool check_migr_pgsize(VFIOUserProxy *proxy, QObject *qobj, Error **errp)
+{
+    QNum *qn = qobject_to(QNum, qobj);
+    uint64_t pgsize;
+
+    if (qn == NULL || !qnum_get_try_uint(qn, &pgsize)) {
+        error_setg(errp, "malformed %s", VFIO_USER_CAP_PGSIZE);
+        return false;
+    }
+
+    /* must be larger than default */
+    if (pgsize & (VFIO_USER_DEF_PGSIZE - 1)) {
+        error_setg(errp, "pgsize 0x%"PRIx64" too small", pgsize);
+        return false;
+    }
+
+    proxy->migr_pgsize = pgsize;
+    return true;
+}
+
+static bool check_bitmap(VFIOUserProxy *proxy, QObject *qobj, Error **errp)
+{
+    QNum *qn = qobject_to(QNum, qobj);
+    uint64_t bitmap_size;
+
+    if (qn == NULL || !qnum_get_try_uint(qn, &bitmap_size)) {
+        error_setg(errp, "malformed %s", VFIO_USER_CAP_MAX_BITMAP);
+        return false;
+    }
+
+    /* can only lower it */
+    if (bitmap_size > VFIO_USER_DEF_MAX_BITMAP) {
+        error_setg(errp, "%s too large", VFIO_USER_CAP_MAX_BITMAP);
+        return false;
+    }
+
+    proxy->max_bitmap = bitmap_size;
+    return true;
+}
+
+static struct cap_entry caps_migr[] = {
+    { VFIO_USER_CAP_PGSIZE, check_migr_pgsize },
+    { VFIO_USER_CAP_MAX_BITMAP, check_bitmap },
+    { NULL }
+};
+
+static bool check_max_fds(VFIOUserProxy *proxy, QObject *qobj, Error **errp)
+{
+    QNum *qn = qobject_to(QNum, qobj);
+    uint64_t max_send_fds;
+
+    if (qn == NULL || !qnum_get_try_uint(qn, &max_send_fds) ||
+        max_send_fds > VFIO_USER_MAX_MAX_FDS) {
+        error_setg(errp, "malformed %s", VFIO_USER_CAP_MAX_FDS);
+        return false;
+    }
+    proxy->max_send_fds = max_send_fds;
+    return true;
+}
+
+static bool check_max_xfer(VFIOUserProxy *proxy, QObject *qobj, Error **errp)
+{
+    QNum *qn = qobject_to(QNum, qobj);
+    uint64_t max_xfer_size;
+
+    if (qn == NULL || !qnum_get_try_uint(qn, &max_xfer_size) ||
+        max_xfer_size > VFIO_USER_MAX_MAX_XFER) {
+        error_setg(errp, "malformed %s", VFIO_USER_CAP_MAX_XFER);
+        return false;
+    }
+    proxy->max_xfer_size = max_xfer_size;
+    return true;
+}
+
+static bool check_pgsizes(VFIOUserProxy *proxy, QObject *qobj, Error **errp)
+{
+    QNum *qn = qobject_to(QNum, qobj);
+    uint64_t pgsizes;
+
+    if (qn == NULL || !qnum_get_try_uint(qn, &pgsizes)) {
+        error_setg(errp, "malformed %s", VFIO_USER_CAP_PGSIZES);
+        return false;
+    }
+
+    /* must be larger than default */
+    if (pgsizes & (VFIO_USER_DEF_PGSIZE - 1)) {
+        error_setg(errp, "pgsize 0x%"PRIx64" too small", pgsizes);
+        return false;
+    }
+
+    proxy->dma_pgsizes = pgsizes;
+    return true;
+}
+
+static bool check_max_dma(VFIOUserProxy *proxy, QObject *qobj, Error **errp)
+{
+    QNum *qn = qobject_to(QNum, qobj);
+    uint64_t max_dma;
+
+    if (qn == NULL || !qnum_get_try_uint(qn, &max_dma)) {
+        error_setg(errp, "malformed %s", VFIO_USER_CAP_MAP_MAX);
+        return false;
+    }
+
+    /* can only lower it */
+    if (max_dma > VFIO_USER_DEF_MAP_MAX) {
+        error_setg(errp, "%s too large", VFIO_USER_CAP_MAP_MAX);
+        return false;
+    }
+
+    proxy->max_dma = max_dma;
+    return true;
+}
+
+static bool check_migr(VFIOUserProxy *proxy, QObject *qobj, Error **errp)
+{
+    QDict *qdict = qobject_to(QDict, qobj);
+
+    if (qdict == NULL) {
+        error_setg(errp, "malformed %s", VFIO_USER_CAP_MAX_FDS);
+        return true;
+    }
+    return caps_parse(proxy, qdict, caps_migr, errp);
+}
+
+static struct cap_entry caps_cap[] = {
+    { VFIO_USER_CAP_MAX_FDS, check_max_fds },
+    { VFIO_USER_CAP_MAX_XFER, check_max_xfer },
+    { VFIO_USER_CAP_PGSIZES, check_pgsizes },
+    { VFIO_USER_CAP_MAP_MAX, check_max_dma },
+    { VFIO_USER_CAP_MIGR, check_migr },
+    { NULL }
+};
+
+static bool check_cap(VFIOUserProxy *proxy, QObject *qobj, Error **errp)
+{
+   QDict *qdict = qobject_to(QDict, qobj);
+
+    if (qdict == NULL) {
+        error_setg(errp, "malformed %s", VFIO_USER_CAP);
+        return false;
+    }
+    return caps_parse(proxy, qdict, caps_cap, errp);
+}
+
+static struct cap_entry ver_0_0[] = {
+    { VFIO_USER_CAP, check_cap },
+    { NULL }
+};
+
+static bool caps_check(VFIOUserProxy *proxy, int minor, const char *caps,
+                       Error **errp)
+{
+    QObject *qobj;
+    QDict *qdict;
+    bool ret;
+
+    qobj = qobject_from_json(caps, NULL);
+    if (qobj == NULL) {
+        error_setg(errp, "malformed capabilities %s", caps);
+        return false;
+    }
+    qdict = qobject_to(QDict, qobj);
+    if (qdict == NULL) {
+        error_setg(errp, "capabilities %s not an object", caps);
+        qobject_unref(qobj);
+        return false;
+    }
+    ret = caps_parse(proxy, qdict, ver_0_0, errp);
+
+    qobject_unref(qobj);
+    return ret;
+}
+
+static GString *caps_json(void)
+{
+    QDict *dict = qdict_new();
+    QDict *capdict = qdict_new();
+    QDict *migdict = qdict_new();
+    GString *str;
+
+    qdict_put_int(migdict, VFIO_USER_CAP_PGSIZE, VFIO_USER_DEF_PGSIZE);
+    qdict_put_int(migdict, VFIO_USER_CAP_MAX_BITMAP, VFIO_USER_DEF_MAX_BITMAP);
+    qdict_put_obj(capdict, VFIO_USER_CAP_MIGR, QOBJECT(migdict));
+
+    qdict_put_int(capdict, VFIO_USER_CAP_MAX_FDS, VFIO_USER_MAX_MAX_FDS);
+    qdict_put_int(capdict, VFIO_USER_CAP_MAX_XFER, VFIO_USER_DEF_MAX_XFER);
+    qdict_put_int(capdict, VFIO_USER_CAP_PGSIZES, VFIO_USER_DEF_PGSIZE);
+    qdict_put_int(capdict, VFIO_USER_CAP_MAP_MAX, VFIO_USER_DEF_MAP_MAX);
+
+    qdict_put_obj(dict, VFIO_USER_CAP, QOBJECT(capdict));
+
+    str = qobject_to_json(QOBJECT(dict));
+    qobject_unref(dict);
+    return str;
+}
+
+bool vfio_user_validate_version(VFIOUserProxy *proxy, Error **errp)
+{
+    g_autofree VFIOUserVersion *msgp = NULL;
+    GString *caps;
+    char *reply;
+    int size, caplen;
+
+    caps = caps_json();
+    caplen = caps->len + 1;
+    size = sizeof(*msgp) + caplen;
+    msgp = g_malloc0(size);
+
+    vfio_user_request_msg(&msgp->hdr, VFIO_USER_VERSION, size, 0);
+    msgp->major = VFIO_USER_MAJOR_VER;
+    msgp->minor = VFIO_USER_MINOR_VER;
+    memcpy(&msgp->capabilities, caps->str, caplen);
+    g_string_free(caps, true);
+    trace_vfio_user_version(msgp->major, msgp->minor, msgp->capabilities);
+
+    if (!vfio_user_send_wait(proxy, &msgp->hdr, NULL, 0, errp)) {
+        return false;
+    }
+
+    if (msgp->hdr.flags & VFIO_USER_ERROR) {
+        error_setg_errno(errp, msgp->hdr.error_reply, "version reply");
+        return false;
+    }
+
+    if (msgp->major != VFIO_USER_MAJOR_VER ||
+        msgp->minor > VFIO_USER_MINOR_VER) {
+        error_setg(errp, "incompatible server version");
+        return false;
+    }
+
+    reply = msgp->capabilities;
+    if (reply[msgp->hdr.size - sizeof(*msgp) - 1] != '\0') {
+        error_setg(errp, "corrupt version reply");
+        return false;
+    }
+
+    if (!caps_check(proxy, msgp->minor, reply, errp)) {
+        return false;
+    }
+
+    trace_vfio_user_version(msgp->major, msgp->minor, msgp->capabilities);
+    return true;
+}
diff --git a/hw/vfio-user/trace-events b/hw/vfio-user/trace-events
index ddeb9f4b2f62557c6c7307f61e0888524d158b36..a965c7b1f2843aa757818238524bd90165267eb0 100644
--- a/hw/vfio-user/trace-events
+++ b/hw/vfio-user/trace-events
@@ -6,3 +6,5 @@
 vfio_user_recv_hdr(const char *name, uint16_t id, uint16_t cmd, uint32_t size, uint32_t flags) " (%s) id 0x%x cmd 0x%x size 0x%x flags 0x%x"
 vfio_user_recv_read(uint16_t id, int read) " id 0x%x read 0x%x"
 vfio_user_recv_request(uint16_t cmd) " command 0x%x"
+vfio_user_send_write(uint16_t id, int wrote) " id 0x%x wrote 0x%x"
+vfio_user_version(uint16_t major, uint16_t minor, const char *caps) " major %d minor %d caps: %s"
-- 
2.49.0


