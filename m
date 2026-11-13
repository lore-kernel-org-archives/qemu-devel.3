Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FA2606A327
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 10:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eI2L4CWH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRokO-0002Wx-Rg; Fri, 13 Nov 2026 05:43:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xRokM-0002Wk-Rj
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 05:43:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xRokK-0000m8-Gs
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 05:43:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794566583;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xFr1dQhBBL78PMKSl46jIM538GjmHObuOm8UAB81X98=;
 b=eI2L4CWHPNyiAhZqsESb6pm0XCFlIdu5A0lu+SjfP2fYENgLf9LgjzCwtKGmQ0dvK4XtqW
 DUcds9mHS9IaGP/YLz3x7A+KwmsIHJw0dsua/EGraCSb5+hYpBoAjKxUeP2II4h4wo9CpM
 +d6QwItz0kDmxjhtmC3Vm/Fnd0BWiB8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-445-fdaHyGAJMAePrEZzBwgb_Q-1; Fri,
 13 Nov 2026 05:43:01 -0500
X-MC-Unique: fdaHyGAJMAePrEZzBwgb_Q-1
X-Mimecast-MFC-AGG-ID: fdaHyGAJMAePrEZzBwgb_Q_1794566581
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 75CD118002AB; Fri, 13 Nov 2026 10:43:00 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0128B18004FC; Fri, 13 Nov 2026 10:42:58 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 13 Nov 2026 14:42:14 +0400
Subject: [PATCH v2 2/8] contrib/vhost-user-gpu: reset the frontend socket
 on stop and start
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261113-issue-4848-v2-2-631414664bca@redhat.com>
References: <20261113-issue-4848-v2-0-631414664bca@redhat.com>
In-Reply-To: <20261113-issue-4848-v2-0-631414664bca@redhat.com>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry R <rdmitry0911@gmail.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=14207;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=jAYcjhh3rhjI95AXqH052TM98qnmHcNDWIapo9x5vZU=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq9umnzBUjqqz45bFbmFmAQ0ujRd+sosXmFNpXu
 yGILlxP7OeJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCavbppwAKCRDa6OEJdZac
 5U/fEACCAxjZ8QIOyN32e4DaazhvcNDCQnWqTKg9lK7Sn3bvNsGFSGLcN+88B4xtrm/AAr9MjpK
 nq3t82WMDuHEiq9BAFybONi9EwLpRoeNcSbZTiDAvMPmxHntRU7TxZVHyrrKZJP2HQhpFBeRKGw
 7w4O+on4nq7jxgGIDsdsIheTWRnxjG+s5DQGvlsVdnImhXMR0WyMICHToTF7H8T65Z+dA6cKWj2
 4EvvOiTb8Q3EanASateMgPR4oMEqg47qFJ9AN1C42ZkAVvpgqA2rzakX0QjcVeBZSYllaPv+XCS
 yf6hL6NdpU7rY4ekGgS7lo0PkLOTa0Ol+Q8lraHmdfCOZWgllGTcZldyKg6sEB9jZIAvP8V+5Ke
 tHPP82FhsXmf+viIr+SQoPrTa7JOFndlaHJ1VjQP5Ibdamb4IR/wWSNz7s3jDuV2CVdOqoVJTIt
 9eeYL7a8CHhx/zHkGePLSBHBBg1bz178YrfDtweLnCvPuiNiA+awI3L+ea1Aq2a5rtpG8LCMGP8
 D57Fy6/r+PjJ5DYoJx8m9NH+K9XJP0iZ95Gpl8xRS4Wd2ijE91JaW3mAH0gpHwGKFxr/fOrrLey
 5N3a6qUbGA2ltbL972otSbcA/S2GP20OAeKHXMY+d5qzkjUeCK7QwvAEbLnvzXdhajhfRPHMjFz
 xWuBkmjN3DKk//A==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

vhost_user_gpu_set_status() closes its end of the GPU socket when the
device stops and sends a new one with SET_SOCKET on the next start. The
backend keeps the old socket until a read or write fails and refuses the
new one with g_return_val_if_fail(g->sock_fd == -1), so it keeps writing
into the dead socket and the guest loses its display.

A command waiting for a frontend reply also leaves wait_in set, which
blocks the control queue and trips the assertion in
set_gpu_protocol_features() on the next start. A zero-length read from
the closed socket is not detected as an error either, so the reply
source keeps firing on EOF.

Replace the previous socket when the frontend sends a new one, cancel
any outstanding wait when the control queue stops, and treat a short
read as an error. Complete a command left waiting for a reply with an
error instead of dropping it, and do not register a wait when the
socket is already gone.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4849
Reported-by: Dmitry R <rdmitry0911@gmail.com>
Tested-by: Dmitry R <rdmitry0911@gmail.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 contrib/vhost-user-gpu/vhost-user-gpu.c | 148 ++++++++++++++++++++++++++------
 contrib/vhost-user-gpu/virgl.c          |  18 ++--
 contrib/vhost-user-gpu/vugpu.h          |   4 +-
 3 files changed, 138 insertions(+), 32 deletions(-)

diff --git a/contrib/vhost-user-gpu/vhost-user-gpu.c b/contrib/vhost-user-gpu/vhost-user-gpu.c
index 5240b171d538..eab52c662775 100644
--- a/contrib/vhost-user-gpu/vhost-user-gpu.c
+++ b/contrib/vhost-user-gpu/vhost-user-gpu.c
@@ -93,35 +93,77 @@ vg_cmd_to_string(int cmd)
     }
 }
 
-static int
+static ssize_t
 vg_sock_fd_read(int sock, void *buf, ssize_t buflen)
 {
-    int ret;
+    ssize_t ret;
 
     do {
         ret = read(sock, buf, buflen);
     } while (ret < 0 && (errno == EINTR || errno == EAGAIN));
 
-    g_warn_if_fail(ret == buflen);
+    if (ret < 0) {
+        g_debug("%s: read: %s", G_STRFUNC, g_strerror(errno));
+        return -1;
+    }
+    if (ret == 0) {
+        g_debug("%s: frontend closed the connection", G_STRFUNC);
+        return -1;
+    }
+    if (ret != buflen) {
+        g_debug("%s: short read: %zd of %zd bytes",
+                G_STRFUNC, ret, buflen);
+        return -1;
+    }
+
     return ret;
 }
 
+static void
+vg_wait_drop(VuGpu *g)
+{
+    g_clear_handle_id(&g->wait_in, g_source_remove);
+    g_clear_pointer(&g->pending_cmd, free);
+}
+
+static void
+vg_wait_cancel(VuGpu *g)
+{
+    if (g->pending_cmd) {
+        /* the reply won't come, don't leave the guest waiting for it */
+        vg_ctrl_response_nodata(g, g->pending_cmd, VIRTIO_GPU_RESP_ERR_UNSPEC);
+    }
+    vg_wait_drop(g);
+}
+
+/* stop waiting for a frontend reply and close the socket */
 static void
 vg_sock_fd_close(VuGpu *g)
 {
+    vg_wait_cancel(g);
+
     if (g->sock_fd >= 0) {
         close(g->sock_fd);
         g->sock_fd = -1;
     }
 }
 
+/* resume the control queue */
+static void
+vg_ctrl_resume(VuGpu *g)
+{
+    vg_handle_ctrl(&g->dev.parent, 0);
+}
+
 static gboolean
 source_wait_cb(gint fd, GIOCondition condition, gpointer user_data)
 {
     VuGpu *g = user_data;
 
     if (!vg_recv_msg(g, VHOST_USER_GPU_DMABUF_UPDATE, 0, NULL)) {
-        return G_SOURCE_CONTINUE;
+        /* vg_recv_msg() closed the socket */
+        vg_ctrl_resume(g);
+        return G_SOURCE_REMOVE;
     }
 
     /* resume */
@@ -131,12 +173,18 @@ source_wait_cb(gint fd, GIOCondition condition, gpointer user_data)
     return G_SOURCE_REMOVE;
 }
 
-void
+bool
 vg_wait_ok(VuGpu *g)
 {
     assert(g->wait_in == 0);
+
+    if (g->sock_fd < 0) {
+        return false;
+    }
+
     g->wait_in = g_unix_fd_add(g->sock_fd, G_IO_IN | G_IO_HUP,
                                source_wait_cb, g);
+    return true;
 }
 
 static int
@@ -169,21 +217,34 @@ vg_sock_fd_write(int sock, const void *buf, ssize_t buflen, int fd)
         *((int *)CMSG_DATA(cmsg)) = fd;
     }
 
+    /* the frontend may have gone away, don't raise SIGPIPE */
     do {
-        ret = sendmsg(sock, &msg, 0);
+        ret = sendmsg(sock, &msg, MSG_NOSIGNAL);
     } while (ret == -1 && (errno == EINTR || errno == EAGAIN));
 
-    g_warn_if_fail(ret == buflen);
+    if (ret < 0) {
+        g_debug("%s: sendmsg: %s", G_STRFUNC, g_strerror(errno));
+        return -1;
+    }
+    if (ret != buflen) {
+        g_debug("%s: short write: %zd of %zd bytes",
+                G_STRFUNC, ret, buflen);
+        return -1;
+    }
+
     return ret;
 }
 
-void
+bool
 vg_send_msg(VuGpu *vg, const VhostUserGpuMsg *msg, int fd)
 {
     if (vg_sock_fd_write(vg->sock_fd, msg,
                          VHOST_USER_GPU_HDR_SIZE + msg->size, fd) < 0) {
         vg_sock_fd_close(vg);
+        return false;
     }
+
+    return true;
 }
 
 bool
@@ -198,9 +259,14 @@ vg_recv_msg(VuGpu *g, uint32_t expect_req, uint32_t expect_size,
         goto err;
     }
 
-    g_return_val_if_fail(req == expect_req, false);
-    g_return_val_if_fail(flags & VHOST_USER_GPU_MSG_FLAG_REPLY, false);
-    g_return_val_if_fail(size == expect_size, false);
+    if (!(req == expect_req &&
+          flags & VHOST_USER_GPU_MSG_FLAG_REPLY &&
+          size == expect_size)) {
+        g_debug("%s: bad reply req=0x%x flags=0x%x size=%u "
+                "(want req=0x%x size=%u)", G_STRFUNC, req, flags, size,
+                expect_req, expect_size);
+        goto err;
+    }
 
     if (size && vg_sock_fd_read(g->sock_fd, payload, size) != size) {
         goto err;
@@ -274,7 +340,9 @@ get_display_info_cb(gint fd, GIOCondition condition, gpointer user_data)
     assert(cmd && cmd->cmd_hdr.type == VIRTIO_GPU_CMD_GET_DISPLAY_INFO);
     if (!vg_recv_msg(vg, VHOST_USER_GPU_GET_DISPLAY_INFO,
                      sizeof(dpy_info), &dpy_info)) {
-        return G_SOURCE_CONTINUE;
+        /* vg_recv_msg() closed the socket */
+        vg_ctrl_resume(vg);
+        return G_SOURCE_REMOVE;
     }
 
     vg->pending_cmd = NULL;
@@ -282,7 +350,7 @@ get_display_info_cb(gint fd, GIOCondition condition, gpointer user_data)
     free(cmd);
 
     vg->wait_in = 0;
-    vg_handle_ctrl(&vg->dev.parent, 0);
+    vg_ctrl_resume(vg);
 
     return G_SOURCE_REMOVE;
 }
@@ -297,7 +365,10 @@ vg_get_display_info(VuGpu *vg, struct virtio_gpu_ctrl_command *cmd)
 
     assert(vg->wait_in == 0);
 
-    vg_send_msg(vg, &msg, -1);
+    if (!vg_send_msg(vg, &msg, -1)) {
+        cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
+        return;
+    }
     vg->pending_cmd = cmd;
     vg->wait_in = g_unix_fd_add(vg->sock_fd, G_IO_IN | G_IO_HUP,
                                get_display_info_cb, vg);
@@ -315,7 +386,9 @@ get_edid_cb(gint fd, GIOCondition condition, gpointer user_data)
     assert(cmd && cmd->cmd_hdr.type == VIRTIO_GPU_CMD_GET_EDID);
     if (!vg_recv_msg(vg, VHOST_USER_GPU_GET_EDID,
                      sizeof(resp_edid), &resp_edid)) {
-        return G_SOURCE_CONTINUE;
+        /* vg_recv_msg() closed the socket */
+        vg_ctrl_resume(vg);
+        return G_SOURCE_REMOVE;
     }
 
     vg->pending_cmd = NULL;
@@ -323,7 +396,7 @@ get_edid_cb(gint fd, GIOCondition condition, gpointer user_data)
     free(cmd);
 
     vg->wait_in = 0;
-    vg_handle_ctrl(&vg->dev.parent, 0);
+    vg_ctrl_resume(vg);
 
     return G_SOURCE_REMOVE;
 }
@@ -346,7 +419,10 @@ vg_get_edid(VuGpu *vg, struct virtio_gpu_ctrl_command *cmd)
 
     assert(vg->wait_in == 0);
 
-    vg_send_msg(vg, &msg, -1);
+    if (!vg_send_msg(vg, &msg, -1)) {
+        cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
+        return;
+    }
     vg->pending_cmd = cmd;
     vg->wait_in = g_unix_fd_add(vg->sock_fd, G_IO_IN | G_IO_HUP,
                                get_edid_cb, vg);
@@ -729,7 +805,9 @@ vg_set_scanout(VuGpu *g,
         };
 
         if (vugbm_buffer_get_dmabuf_fd(buffer, &fd)) {
-            vg_send_msg(g, &msg, fd);
+            if (!vg_send_msg(g, &msg, fd)) {
+                cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
+            }
             close(fd);
         }
     } else {
@@ -742,7 +820,9 @@ vg_set_scanout(VuGpu *g,
                 .height = scanout->height
             }
         };
-        vg_send_msg(g, &msg, -1);
+        if (!vg_send_msg(g, &msg, -1)) {
+            cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
+        }
     }
 }
 
@@ -814,8 +894,12 @@ vg_resource_flush(VuGpu *g,
                     .height = height,
                 }
             };
-            vg_send_msg(g, &vmsg, -1);
-            vg_wait_ok(g);
+            if (!vg_send_msg(g, &vmsg, -1) || !vg_wait_ok(g)) {
+                pixman_region_fini(&region);
+                pixman_region_fini(&finalregion);
+                cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
+                break;
+            }
         } else {
             size_t bpp =
                 PIXMAN_FORMAT_BPP(pixman_image_get_format(res->image)) / 8;
@@ -852,7 +936,9 @@ vg_resource_flush(VuGpu *g,
                                    0, 0, 0, 0,
                                    width, height);
             pixman_image_unref(img);
-            vg_send_msg(g, msg, -1);
+            if (!vg_send_msg(g, msg, -1)) {
+                cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
+            }
             g_free(msg);
         }
         pixman_region_fini(&region);
@@ -1064,12 +1150,16 @@ vg_panic(VuDev *dev, const char *msg)
 static void
 vg_queue_set_started(VuDev *dev, int qidx, bool started)
 {
+    VuGpu *g = container_of(dev, VuGpu, dev.parent);
     VuVirtq *vq = vu_get_queue(dev, qidx);
 
     g_debug("queue started %d:%d\n", qidx, started);
 
     switch (qidx) {
     case 0:
+        if (!started) {
+            vg_wait_drop(g);
+        }
         vu_set_queue_handler(dev, vq, started ? vg_handle_ctrl : NULL);
         break;
     case 1:
@@ -1093,7 +1183,9 @@ protocol_features_cb(gint fd, GIOCondition condition, gpointer user_data)
 
     if (!vg_recv_msg(g, msg.request,
                      sizeof(protocol_features), &protocol_features)) {
-        return G_SOURCE_CONTINUE;
+        /* vg_recv_msg() closed the socket and removed this source */
+        vg_ctrl_resume(g);
+        return G_SOURCE_REMOVE;
     }
 
     protocol_features &= (protocol_edid | protocol_dmabuf2);
@@ -1126,7 +1218,9 @@ set_gpu_protocol_features(VuGpu *g)
         .request = VHOST_USER_GPU_GET_PROTOCOL_FEATURES,
     };
 
-    vg_send_msg(g, &msg, -1);
+    if (!vg_send_msg(g, &msg, -1)) {
+        return;
+    }
     assert(g->wait_in == 0);
     g->wait_in = g_unix_fd_add(g->sock_fd, G_IO_IN | G_IO_HUP,
                                protocol_features_cb, g);
@@ -1140,7 +1234,8 @@ vg_process_msg(VuDev *dev, VhostUserMsg *msg, int *do_reply)
     switch (msg->request) {
     case VHOST_USER_GPU_SET_SOCKET: {
         g_return_val_if_fail(msg->fd_num == 1, 1);
-        g_return_val_if_fail(g->sock_fd == -1, 1);
+        /* the frontend replaces the socket on device start */
+        vg_sock_fd_close(g);
         g->sock_fd = msg->fds[0];
         set_gpu_protocol_features(g);
         return 1;
@@ -1230,6 +1325,9 @@ vg_destroy(VuGpu *g)
 {
     struct virtio_gpu_simple_resource *res, *tmp;
 
+    /* the guest is gone, don't try to complete a pending command */
+    vg_wait_drop(g);
+
     vug_deinit(&g->dev);
 
     vg_sock_fd_close(g);
diff --git a/contrib/vhost-user-gpu/virgl.c b/contrib/vhost-user-gpu/virgl.c
index 3242bf13586d..c33b3dbeb8b7 100644
--- a/contrib/vhost-user-gpu/virgl.c
+++ b/contrib/vhost-user-gpu/virgl.c
@@ -120,7 +120,9 @@ virgl_cmd_resource_unref(VuGpu *g,
                 .size = sizeof(VhostUserGpuDMABUFScanout),
                 .payload.dmabuf_scanout.scanout_id = i,
             };
-            vg_send_msg(g, &msg, -1);
+            if (!vg_send_msg(g, &msg, -1)) {
+                cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
+            }
             g->scanout[i].resource_id = 0;
         }
     }
@@ -439,7 +441,9 @@ virgl_cmd_set_scanout(VuGpu *g,
             msg.size = sizeof(VhostUserGpuDMABUFScanout);
         }
 
-        vg_send_msg(g, &msg, fd);
+        if (!vg_send_msg(g, &msg, fd)) {
+            cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
+        }
         close(fd);
     } else {
         VhostUserGpuMsg msg = {
@@ -448,7 +452,9 @@ virgl_cmd_set_scanout(VuGpu *g,
             .payload.dmabuf_scanout.scanout_id = ss.scanout_id,
         };
         g_debug("disable scanout");
-        vg_send_msg(g, &msg, -1);
+        if (!vg_send_msg(g, &msg, -1)) {
+            cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
+        }
     }
     g->scanout[ss.scanout_id].resource_id = ss.resource_id;
 }
@@ -480,8 +486,10 @@ virgl_cmd_resource_flush(VuGpu *g,
             .payload.update.width = rf.r.width,
             .payload.update.height = rf.r.height
         };
-        vg_send_msg(g, &msg, -1);
-        vg_wait_ok(g);
+        if (!vg_send_msg(g, &msg, -1) || !vg_wait_ok(g)) {
+            cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
+            return;
+        }
     }
 }
 
diff --git a/contrib/vhost-user-gpu/vugpu.h b/contrib/vhost-user-gpu/vugpu.h
index 1c2b0ed4fbe8..bfca1e0484ca 100644
--- a/contrib/vhost-user-gpu/vugpu.h
+++ b/contrib/vhost-user-gpu/vugpu.h
@@ -205,9 +205,9 @@ void    vg_cleanup_mapping_iov(VuGpu *g, struct iovec *iov, uint32_t count);
 void    vg_get_display_info(VuGpu *vg, struct virtio_gpu_ctrl_command *cmd);
 void    vg_get_edid(VuGpu *vg, struct virtio_gpu_ctrl_command *cmd);
 
-void    vg_wait_ok(VuGpu *g);
+bool    vg_wait_ok(VuGpu *g);
 
-void    vg_send_msg(VuGpu *g, const VhostUserGpuMsg *msg, int fd);
+bool    vg_send_msg(VuGpu *g, const VhostUserGpuMsg *msg, int fd);
 
 bool    vg_recv_msg(VuGpu *g, uint32_t expect_req, uint32_t expect_size,
                     gpointer payload);

-- 
2.56.0.116.g6de20f6092dc


