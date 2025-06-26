Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E336BC7EE33
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Jun 2025 07:47:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUhJS-0004fG-06; Thu, 26 Jun 2025 03:46:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uUhJF-0004Uk-Jv
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 03:46:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uUhJ9-0001xR-3S
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 03:46:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750923965;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U2n7Dhy5Yznd0RJTImonPlt60nglT5ze/kfjz6hLk5I=;
 b=UWZbPdMtTYZgR3DKZhF/vyZ6uw+ma97ucoa+j8wKTHyWXTu/aHFJrXAOGf5bDDjWUONvN4
 PeCebm5jHShCYintfAfHIdGHOIiPtCAaGdxChyW9sEnPFL93Dn47HBlXkwk1JwpSDTeGGh
 cE90Oa/phiTnSNCds6AEM5vVHVDKuPA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-271-fMyTph_gNNy-kfrObnOaDw-1; Thu,
 26 Jun 2025 03:46:01 -0400
X-MC-Unique: fMyTph_gNNy-kfrObnOaDw-1
X-Mimecast-MFC-AGG-ID: fMyTph_gNNy-kfrObnOaDw_1750923959
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DE0A81944AA6; Thu, 26 Jun 2025 07:45:58 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.51])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3AFE2180045B; Thu, 26 Jun 2025 07:45:55 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 John Levon <john.levon@nutanix.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 09/25] vfio-user: implement message receive infrastructure
Date: Thu, 26 Jun 2025 09:45:13 +0200
Message-ID: <20250626074529.1384114-10-clg@redhat.com>
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

From: John Levon <john.levon@nutanix.com>

Add the basic implementation for receiving vfio-user messages from the
control socket.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250625193012.2316242-4-john.levon@nutanix.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 meson.build               |   1 +
 hw/vfio-user/protocol.h   |  53 +++++
 hw/vfio-user/proxy.h      |  11 +
 hw/vfio-user/trace.h      |   4 +
 hw/vfio-user/pci.c        |  11 +
 hw/vfio-user/proxy.c      | 411 ++++++++++++++++++++++++++++++++++++++
 hw/vfio-user/trace-events |   8 +
 7 files changed, 499 insertions(+)
 create mode 100644 hw/vfio-user/protocol.h
 create mode 100644 hw/vfio-user/trace.h
 create mode 100644 hw/vfio-user/trace-events

diff --git a/meson.build b/meson.build
index 4676908dbb2006181355785c7262a85df52fc87c..dbc97bfdf7a0d888e270056d52b565c494878646 100644
--- a/meson.build
+++ b/meson.build
@@ -3683,6 +3683,7 @@ if have_system
     'hw/ufs',
     'hw/usb',
     'hw/vfio',
+    'hw/vfio-user',
     'hw/virtio',
     'hw/vmapple',
     'hw/watchdog',
diff --git a/hw/vfio-user/protocol.h b/hw/vfio-user/protocol.h
new file mode 100644
index 0000000000000000000000000000000000000000..4ddfb5f222e60c3bd212110bba6855b81f191d27
--- /dev/null
+++ b/hw/vfio-user/protocol.h
@@ -0,0 +1,53 @@
+#ifndef VFIO_USER_PROTOCOL_H
+#define VFIO_USER_PROTOCOL_H
+
+/*
+ * vfio protocol over a UNIX socket.
+ *
+ * Copyright © 2018, 2021 Oracle and/or its affiliates.
+ *
+ * Each message has a standard header that describes the command
+ * being sent, which is almost always a VFIO ioctl().
+ *
+ * The header may be followed by command-specific data, such as the
+ * region and offset info for read and write commands.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+typedef struct {
+    uint16_t id;
+    uint16_t command;
+    uint32_t size;
+    uint32_t flags;
+    uint32_t error_reply;
+} VFIOUserHdr;
+
+/* VFIOUserHdr commands */
+enum vfio_user_command {
+    VFIO_USER_VERSION                   = 1,
+    VFIO_USER_DMA_MAP                   = 2,
+    VFIO_USER_DMA_UNMAP                 = 3,
+    VFIO_USER_DEVICE_GET_INFO           = 4,
+    VFIO_USER_DEVICE_GET_REGION_INFO    = 5,
+    VFIO_USER_DEVICE_GET_REGION_IO_FDS  = 6,
+    VFIO_USER_DEVICE_GET_IRQ_INFO       = 7,
+    VFIO_USER_DEVICE_SET_IRQS           = 8,
+    VFIO_USER_REGION_READ               = 9,
+    VFIO_USER_REGION_WRITE              = 10,
+    VFIO_USER_DMA_READ                  = 11,
+    VFIO_USER_DMA_WRITE                 = 12,
+    VFIO_USER_DEVICE_RESET              = 13,
+    VFIO_USER_DIRTY_PAGES               = 14,
+    VFIO_USER_MAX,
+};
+
+/* VFIOUserHdr flags */
+#define VFIO_USER_REQUEST       0x0
+#define VFIO_USER_REPLY         0x1
+#define VFIO_USER_TYPE          0xF
+
+#define VFIO_USER_NO_REPLY      0x10
+#define VFIO_USER_ERROR         0x20
+
+#endif /* VFIO_USER_PROTOCOL_H */
diff --git a/hw/vfio-user/proxy.h b/hw/vfio-user/proxy.h
index a9bce82239d0e9dc40a892e1542488cfffc4f3da..ff553cad9d50ce2ba4867d910adf92836dc068b5 100644
--- a/hw/vfio-user/proxy.h
+++ b/hw/vfio-user/proxy.h
@@ -12,6 +12,9 @@
 #include "io/channel.h"
 #include "io/channel-socket.h"
 
+#include "qemu/sockets.h"
+#include "hw/vfio-user/protocol.h"
+
 typedef struct {
     int send_fds;
     int recv_fds;
@@ -28,6 +31,7 @@ enum msg_type {
 
 typedef struct VFIOUserMsg {
     QTAILQ_ENTRY(VFIOUserMsg) next;
+    VFIOUserHdr *hdr;
     VFIOUserFDs *fds;
     uint32_t rsize;
     uint32_t id;
@@ -67,13 +71,20 @@ typedef struct VFIOUserProxy {
     VFIOUserMsgQ incoming;
     VFIOUserMsgQ outgoing;
     VFIOUserMsg *last_nowait;
+    VFIOUserMsg *part_recv;
+    size_t recv_left;
     enum proxy_state state;
 } VFIOUserProxy;
 
 /* VFIOProxy flags */
 #define VFIO_PROXY_CLIENT        0x1
 
+typedef struct VFIODevice VFIODevice;
+
 VFIOUserProxy *vfio_user_connect_dev(SocketAddress *addr, Error **errp);
 void vfio_user_disconnect(VFIOUserProxy *proxy);
+void vfio_user_set_handler(VFIODevice *vbasedev,
+                           void (*handler)(void *opaque, VFIOUserMsg *msg),
+                           void *reqarg);
 
 #endif /* VFIO_USER_PROXY_H */
diff --git a/hw/vfio-user/trace.h b/hw/vfio-user/trace.h
new file mode 100644
index 0000000000000000000000000000000000000000..9cf02d9506dd3d7e5a1d234497761f7c545aca76
--- /dev/null
+++ b/hw/vfio-user/trace.h
@@ -0,0 +1,4 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include "trace/trace-hw_vfio_user.h"
diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
index 642421e7916aad01a894ee390c43453dd5297356..bad2829f5cfc76ef5716a67ffb000c8d78ed360d 100644
--- a/hw/vfio-user/pci.c
+++ b/hw/vfio-user/pci.c
@@ -22,6 +22,16 @@ struct VFIOUserPCIDevice {
     SocketAddress *socket;
 };
 
+/*
+ * Incoming request message callback.
+ *
+ * Runs off main loop, so BQL held.
+ */
+static void vfio_user_pci_process_req(void *opaque, VFIOUserMsg *msg)
+{
+
+}
+
 /*
  * Emulated devices don't use host hot reset
  */
@@ -80,6 +90,7 @@ static void vfio_user_pci_realize(PCIDevice *pdev, Error **errp)
         return;
     }
     vbasedev->proxy = proxy;
+    vfio_user_set_handler(vbasedev, vfio_user_pci_process_req, vdev);
 
     /*
      * vfio-user devices are effectively mdevs (don't use a host iommu).
diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
index bb436c9db91b6ebd90542b4121b62d56bbbdf4ab..349ea2b27c9877993125f4f0f3ca27cb4df9b1b3 100644
--- a/hw/vfio-user/proxy.c
+++ b/hw/vfio-user/proxy.c
@@ -11,15 +11,31 @@
 
 #include "hw/vfio/vfio-device.h"
 #include "hw/vfio-user/proxy.h"
+#include "hw/vfio-user/trace.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/lockable.h"
+#include "qemu/main-loop.h"
 #include "system/iothread.h"
 
 static IOThread *vfio_user_iothread;
 
 static void vfio_user_shutdown(VFIOUserProxy *proxy);
+static VFIOUserMsg *vfio_user_getmsg(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
+                                     VFIOUserFDs *fds);
+static VFIOUserFDs *vfio_user_getfds(int numfds);
+static void vfio_user_recycle(VFIOUserProxy *proxy, VFIOUserMsg *msg);
 
+static void vfio_user_recv(void *opaque);
+static void vfio_user_cb(void *opaque);
+
+static void vfio_user_request(void *opaque);
+
+static inline void vfio_user_set_error(VFIOUserHdr *hdr, uint32_t err)
+{
+    hdr->flags |= VFIO_USER_ERROR;
+    hdr->error_reply = err;
+}
 
 /*
  * Functions called by main, CPU, or iothread threads
@@ -32,10 +48,343 @@ static void vfio_user_shutdown(VFIOUserProxy *proxy)
                                    proxy->ctx, NULL, NULL);
 }
 
+static VFIOUserMsg *vfio_user_getmsg(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
+                                     VFIOUserFDs *fds)
+{
+    VFIOUserMsg *msg;
+
+    msg = QTAILQ_FIRST(&proxy->free);
+    if (msg != NULL) {
+        QTAILQ_REMOVE(&proxy->free, msg, next);
+    } else {
+        msg = g_malloc0(sizeof(*msg));
+        qemu_cond_init(&msg->cv);
+    }
+
+    msg->hdr = hdr;
+    msg->fds = fds;
+    return msg;
+}
+
+/*
+ * Recycle a message list entry to the free list.
+ */
+static void vfio_user_recycle(VFIOUserProxy *proxy, VFIOUserMsg *msg)
+{
+    if (msg->type == VFIO_MSG_NONE) {
+        error_printf("vfio_user_recycle - freeing free msg\n");
+        return;
+    }
+
+    /* free msg buffer if no one is waiting to consume the reply */
+    if (msg->type == VFIO_MSG_NOWAIT || msg->type == VFIO_MSG_ASYNC) {
+        g_free(msg->hdr);
+        if (msg->fds != NULL) {
+            g_free(msg->fds);
+        }
+    }
+
+    msg->type = VFIO_MSG_NONE;
+    msg->hdr = NULL;
+    msg->fds = NULL;
+    msg->complete = false;
+    QTAILQ_INSERT_HEAD(&proxy->free, msg, next);
+}
+
+static VFIOUserFDs *vfio_user_getfds(int numfds)
+{
+    VFIOUserFDs *fds = g_malloc0(sizeof(*fds) + (numfds * sizeof(int)));
+
+    fds->fds = (int *)((char *)fds + sizeof(*fds));
+
+    return fds;
+}
+
 /*
  * Functions only called by iothread
  */
 
+/*
+ * Process a received message.
+ */
+static void vfio_user_process(VFIOUserProxy *proxy, VFIOUserMsg *msg,
+                              bool isreply)
+{
+
+    /*
+     * Replies signal a waiter, if none just check for errors
+     * and free the message buffer.
+     *
+     * Requests get queued for the BH.
+     */
+    if (isreply) {
+        msg->complete = true;
+        if (msg->type == VFIO_MSG_WAIT) {
+            qemu_cond_signal(&msg->cv);
+        } else {
+            if (msg->hdr->flags & VFIO_USER_ERROR) {
+                error_printf("vfio_user_process: error reply on async ");
+                error_printf("request command %x error %s\n",
+                             msg->hdr->command,
+                             strerror(msg->hdr->error_reply));
+            }
+            /* youngest nowait msg has been ack'd */
+            if (proxy->last_nowait == msg) {
+                proxy->last_nowait = NULL;
+            }
+            vfio_user_recycle(proxy, msg);
+        }
+    } else {
+        QTAILQ_INSERT_TAIL(&proxy->incoming, msg, next);
+        qemu_bh_schedule(proxy->req_bh);
+    }
+}
+
+/*
+ * Complete a partial message read
+ */
+static int vfio_user_complete(VFIOUserProxy *proxy, Error **errp)
+{
+    VFIOUserMsg *msg = proxy->part_recv;
+    size_t msgleft = proxy->recv_left;
+    bool isreply;
+    char *data;
+    int ret;
+
+    data = (char *)msg->hdr + (msg->hdr->size - msgleft);
+    while (msgleft > 0) {
+        ret = qio_channel_read(proxy->ioc, data, msgleft, errp);
+
+        /* error or would block */
+        if (ret <= 0) {
+            /* try for rest on next iternation */
+            if (ret == QIO_CHANNEL_ERR_BLOCK) {
+                proxy->recv_left = msgleft;
+            }
+            return ret;
+        }
+        trace_vfio_user_recv_read(msg->hdr->id, ret);
+
+        msgleft -= ret;
+        data += ret;
+    }
+
+    /*
+     * Read complete message, process it.
+     */
+    proxy->part_recv = NULL;
+    proxy->recv_left = 0;
+    isreply = (msg->hdr->flags & VFIO_USER_TYPE) == VFIO_USER_REPLY;
+    vfio_user_process(proxy, msg, isreply);
+
+    /* return positive value */
+    return 1;
+}
+
+/*
+ * Receive and process one incoming message.
+ *
+ * For replies, find matching outgoing request and wake any waiters.
+ * For requests, queue in incoming list and run request BH.
+ */
+static int vfio_user_recv_one(VFIOUserProxy *proxy, Error **errp)
+{
+    VFIOUserMsg *msg = NULL;
+    g_autofree int *fdp = NULL;
+    VFIOUserFDs *reqfds;
+    VFIOUserHdr hdr;
+    struct iovec iov = {
+        .iov_base = &hdr,
+        .iov_len = sizeof(hdr),
+    };
+    bool isreply = false;
+    int i, ret;
+    size_t msgleft, numfds = 0;
+    char *data = NULL;
+    char *buf = NULL;
+
+    /*
+     * Complete any partial reads
+     */
+    if (proxy->part_recv != NULL) {
+        ret = vfio_user_complete(proxy, errp);
+
+        /* still not complete, try later */
+        if (ret == QIO_CHANNEL_ERR_BLOCK) {
+            return ret;
+        }
+
+        if (ret <= 0) {
+            goto fatal;
+        }
+        /* else fall into reading another msg */
+    }
+
+    /*
+     * Read header
+     */
+    ret = qio_channel_readv_full(proxy->ioc, &iov, 1, &fdp, &numfds, 0,
+                                 errp);
+    if (ret == QIO_CHANNEL_ERR_BLOCK) {
+        return ret;
+    }
+
+    /* read error or other side closed connection */
+    if (ret <= 0) {
+        goto fatal;
+    }
+
+    if (ret < sizeof(hdr)) {
+        error_setg(errp, "short read of header");
+        goto fatal;
+    }
+
+    /*
+     * Validate header
+     */
+    if (hdr.size < sizeof(VFIOUserHdr)) {
+        error_setg(errp, "bad header size");
+        goto fatal;
+    }
+    switch (hdr.flags & VFIO_USER_TYPE) {
+    case VFIO_USER_REQUEST:
+        isreply = false;
+        break;
+    case VFIO_USER_REPLY:
+        isreply = true;
+        break;
+    default:
+        error_setg(errp, "unknown message type");
+        goto fatal;
+    }
+    trace_vfio_user_recv_hdr(proxy->sockname, hdr.id, hdr.command, hdr.size,
+                             hdr.flags);
+
+    /*
+     * For replies, find the matching pending request.
+     * For requests, reap incoming FDs.
+     */
+    if (isreply) {
+        QTAILQ_FOREACH(msg, &proxy->pending, next) {
+            if (hdr.id == msg->id) {
+                break;
+            }
+        }
+        if (msg == NULL) {
+            error_setg(errp, "unexpected reply");
+            goto err;
+        }
+        QTAILQ_REMOVE(&proxy->pending, msg, next);
+
+        /*
+         * Process any received FDs
+         */
+        if (numfds != 0) {
+            if (msg->fds == NULL || msg->fds->recv_fds < numfds) {
+                error_setg(errp, "unexpected FDs");
+                goto err;
+            }
+            msg->fds->recv_fds = numfds;
+            memcpy(msg->fds->fds, fdp, numfds * sizeof(int));
+        }
+    } else {
+        if (numfds != 0) {
+            reqfds = vfio_user_getfds(numfds);
+            memcpy(reqfds->fds, fdp, numfds * sizeof(int));
+        } else {
+            reqfds = NULL;
+        }
+    }
+
+    /*
+     * Put the whole message into a single buffer.
+     */
+    if (isreply) {
+        if (hdr.size > msg->rsize) {
+            error_setg(errp, "reply larger than recv buffer");
+            goto err;
+        }
+        *msg->hdr = hdr;
+        data = (char *)msg->hdr + sizeof(hdr);
+    } else {
+        buf = g_malloc0(hdr.size);
+        memcpy(buf, &hdr, sizeof(hdr));
+        data = buf + sizeof(hdr);
+        msg = vfio_user_getmsg(proxy, (VFIOUserHdr *)buf, reqfds);
+        msg->type = VFIO_MSG_REQ;
+    }
+
+    /*
+     * Read rest of message.
+     */
+    msgleft = hdr.size - sizeof(hdr);
+    while (msgleft > 0) {
+        ret = qio_channel_read(proxy->ioc, data, msgleft, errp);
+
+        /* prepare to complete read on next iternation */
+        if (ret == QIO_CHANNEL_ERR_BLOCK) {
+            proxy->part_recv = msg;
+            proxy->recv_left = msgleft;
+            return ret;
+        }
+
+        if (ret <= 0) {
+            goto fatal;
+        }
+        trace_vfio_user_recv_read(hdr.id, ret);
+
+        msgleft -= ret;
+        data += ret;
+    }
+
+    vfio_user_process(proxy, msg, isreply);
+    return 0;
+
+    /*
+     * fatal means the other side closed or we don't trust the stream
+     * err means this message is corrupt
+     */
+fatal:
+    vfio_user_shutdown(proxy);
+    proxy->state = VFIO_PROXY_ERROR;
+
+    /* set error if server side closed */
+    if (ret == 0) {
+        error_setg(errp, "server closed socket");
+    }
+
+err:
+    for (i = 0; i < numfds; i++) {
+        close(fdp[i]);
+    }
+    if (isreply && msg != NULL) {
+        /* force an error to keep sending thread from hanging */
+        vfio_user_set_error(msg->hdr, EINVAL);
+        msg->complete = true;
+        qemu_cond_signal(&msg->cv);
+    }
+    return -1;
+}
+
+static void vfio_user_recv(void *opaque)
+{
+    VFIOUserProxy *proxy = opaque;
+
+    QEMU_LOCK_GUARD(&proxy->lock);
+
+    if (proxy->state == VFIO_PROXY_CONNECTED) {
+        Error *local_err = NULL;
+
+        while (vfio_user_recv_one(proxy, &local_err) == 0) {
+            ;
+        }
+
+        if (local_err != NULL) {
+            error_report_err(local_err);
+        }
+    }
+}
+
 static void vfio_user_cb(void *opaque)
 {
     VFIOUserProxy *proxy = opaque;
@@ -51,6 +400,53 @@ static void vfio_user_cb(void *opaque)
  * Functions called by main or CPU threads
  */
 
+/*
+ * Process incoming requests.
+ *
+ * The bus-specific callback has the form:
+ *    request(opaque, msg)
+ * where 'opaque' was specified in vfio_user_set_handler
+ * and 'msg' is the inbound message.
+ *
+ * The callback is responsible for disposing of the message buffer,
+ * usually by re-using it when calling vfio_send_reply or vfio_send_error,
+ * both of which free their message buffer when the reply is sent.
+ *
+ * If the callback uses a new buffer, it needs to free the old one.
+ */
+static void vfio_user_request(void *opaque)
+{
+    VFIOUserProxy *proxy = opaque;
+    VFIOUserMsgQ new, free;
+    VFIOUserMsg *msg, *m1;
+
+    /* reap all incoming */
+    QTAILQ_INIT(&new);
+    WITH_QEMU_LOCK_GUARD(&proxy->lock) {
+        QTAILQ_FOREACH_SAFE(msg, &proxy->incoming, next, m1) {
+            QTAILQ_REMOVE(&proxy->incoming, msg, next);
+            QTAILQ_INSERT_TAIL(&new, msg, next);
+        }
+    }
+
+    /* process list */
+    QTAILQ_INIT(&free);
+    QTAILQ_FOREACH_SAFE(msg, &new, next, m1) {
+        QTAILQ_REMOVE(&new, msg, next);
+        trace_vfio_user_recv_request(msg->hdr->command);
+        proxy->request(proxy->req_arg, msg);
+        QTAILQ_INSERT_HEAD(&free, msg, next);
+    }
+
+    /* free list */
+    WITH_QEMU_LOCK_GUARD(&proxy->lock) {
+        QTAILQ_FOREACH_SAFE(msg, &free, next, m1) {
+            vfio_user_recycle(proxy, msg);
+        }
+    }
+}
+
+
 static QLIST_HEAD(, VFIOUserProxy) vfio_user_sockets =
     QLIST_HEAD_INITIALIZER(vfio_user_sockets);
 
@@ -89,6 +485,7 @@ VFIOUserProxy *vfio_user_connect_dev(SocketAddress *addr, Error **errp)
     }
 
     proxy->ctx = iothread_get_aio_context(vfio_user_iothread);
+    proxy->req_bh = qemu_bh_new(vfio_user_request, proxy);
 
     QTAILQ_INIT(&proxy->outgoing);
     QTAILQ_INIT(&proxy->incoming);
@@ -99,6 +496,18 @@ VFIOUserProxy *vfio_user_connect_dev(SocketAddress *addr, Error **errp)
     return proxy;
 }
 
+void vfio_user_set_handler(VFIODevice *vbasedev,
+                           void (*handler)(void *opaque, VFIOUserMsg *msg),
+                           void *req_arg)
+{
+    VFIOUserProxy *proxy = vbasedev->proxy;
+
+    proxy->request = handler;
+    proxy->req_arg = req_arg;
+    qio_channel_set_aio_fd_handler(proxy->ioc, proxy->ctx,
+                                   vfio_user_recv, NULL, NULL, proxy);
+}
+
 void vfio_user_disconnect(VFIOUserProxy *proxy)
 {
     VFIOUserMsg *r1, *r2;
@@ -114,6 +523,8 @@ void vfio_user_disconnect(VFIOUserProxy *proxy)
     }
     object_unref(OBJECT(proxy->ioc));
     proxy->ioc = NULL;
+    qemu_bh_delete(proxy->req_bh);
+    proxy->req_bh = NULL;
 
     proxy->state = VFIO_PROXY_CLOSING;
     QTAILQ_FOREACH_SAFE(r1, &proxy->outgoing, next, r2) {
diff --git a/hw/vfio-user/trace-events b/hw/vfio-user/trace-events
new file mode 100644
index 0000000000000000000000000000000000000000..ddeb9f4b2f62557c6c7307f61e0888524d158b36
--- /dev/null
+++ b/hw/vfio-user/trace-events
@@ -0,0 +1,8 @@
+# See docs/devel/tracing.rst for syntax documentation.
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+# common.c
+vfio_user_recv_hdr(const char *name, uint16_t id, uint16_t cmd, uint32_t size, uint32_t flags) " (%s) id 0x%x cmd 0x%x size 0x%x flags 0x%x"
+vfio_user_recv_read(uint16_t id, int read) " id 0x%x read 0x%x"
+vfio_user_recv_request(uint16_t cmd) " command 0x%x"
-- 
2.49.0


