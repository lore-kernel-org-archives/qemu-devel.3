Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7488D606A321
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 10:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MD80Acyl
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRokM-0002WY-S4; Fri, 13 Nov 2026 05:43:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xRokJ-0002WB-KW
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 05:43:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xRokH-0000VE-Oe
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 05:43:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794566580;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+S8fSHCIiKwp92L9xr81yyI105aIv8fYGbv9YYPa8+w=;
 b=MD80AcylMBZvYnstFX8qAPd34PrsnDl7np3esdllsT1AfBj65rRlCMAAm0r/yWQAHvaW4y
 HWHX4E1hU299rSh6FYNVYYCKjXirnNYzuCxvw0o4oFbEZJKXtLhDE4bv9QfbS3ABA/NNYz
 /rMGSjoUxCW7tLBtHQ52V5GlAAaYiac=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-478-RbIk5t4PNGWZLKKzb1UsZA-1; Fri,
 13 Nov 2026 05:42:57 -0500
X-MC-Unique: RbIk5t4PNGWZLKKzb1UsZA-1
X-Mimecast-MFC-AGG-ID: RbIk5t4PNGWZLKKzb1UsZA_1794566576
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2993E18004D8; Fri, 13 Nov 2026 10:42:56 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8689F19634EC; Fri, 13 Nov 2026 10:42:54 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 13 Nov 2026 14:42:13 +0400
Subject: [PATCH v2 1/8] contrib/vhost-user-gpu: don't fence commands
 waiting for a reply
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261113-issue-4848-v2-1-631414664bca@redhat.com>
References: <20261113-issue-4848-v2-0-631414664bca@redhat.com>
In-Reply-To: <20261113-issue-4848-v2-0-631414664bca@redhat.com>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry R <rdmitry0911@gmail.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=5478;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=bRx/CR1bmd+TdmoebQdsG6sRV5DGD9DXaX+0sP+F5cQ=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq9umnPRFHlQyIsBGcausriC1RImZIFunS1jEIe
 nPDv4CmhMeJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCavbppwAKCRDa6OEJdZac
 5UmlEACrXS0/Nu/W+4IQqICxafR5xQ5m1deZtdSzDjgdEPSMQfjdJPDqKgxQbVtTFvQSIzVfImt
 JEZQRaopqli0GqdeoNl3HQhVIoWqTWJSsshxcC0PUctTQICzjFc2w458XLwIwjDChLt3TcGZwss
 i59PMaQbflrMnbjWkKf5pw+Naa+twlHCY5FBMe8DNckRy6fB9G0gmAEpZPAuGZNggvvM+67qYm2
 jwibiPQVvoAdTre7vlhAUeJjlZypZMbRIKoDFot0N3s0yX0XrKQVr4Dj0ibzOe8gZtPvRXg4tw3
 s4yt5qWufHlhjx9pw9/gL+dU5UN02sjy5ROo3X2NOYsg/Js+3nhbMagUUHurZvgLW5BlnQZS6F5
 cY7yVEYFlxJDe6OJOGifoV2iIIxAA0yMyqtH8p6Ku72izQtCQY9CKs+iwqlwIBRZKgIFU1jVyGH
 r1TpKOqMANj9lUrkxs9lYEpld37mwJ/Q0u4No5d+fiFGa+pgSGEE/XuAwDlxvYBE5xPFbbO3RGq
 0FXdxPA4PoZELzv5398MhYcmZum5Udx4yy2QK4sTc6IiArcDKkRnBU/bPVjKIxL24CfLrT6GMEX
 G4Ue7LLBmnPSi6wV6LncPtYYrfam+SlsUCtkGQgk9EGRaeAAV9rDP6Hjl1Z9Vwhd2/u0Uj2V7Tx
 5ikjiu6iLp9Iz0A==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

virgl_write_fence() completes and frees every command on fenceq whose
fence_id is not above the signalled fence, without checking its state.
GET_DISPLAY_INFO and GET_EDID wait for a reply from the frontend on that
same queue, in VG_CMD_STATE_PENDING with a zero fence_id, so the next
signalled fence frees them. The reply callback then takes QTAILQ_LAST()
of the queue, which is either empty or another command, and crashes or
trips the type assertion.

Keep the command that waits for the frontend reply in VuGpu instead,
free it from the reply callback, and don't put it on fenceq at all, so
that the queue and the inflight count only track commands submitted to
virglrenderer.

Fixes: bd690feb1554 ("vhost-user-gpu: handle display-info in a callback")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4848
Reported-by: Dmitry R <rdmitry0911@gmail.com>
Tested-by: Dmitry R <rdmitry0911@gmail.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 contrib/vhost-user-gpu/vhost-user-gpu.c | 21 +++++++++++++++------
 contrib/vhost-user-gpu/virgl.c          |  4 ++++
 contrib/vhost-user-gpu/vugpu.h          |  3 +++
 3 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/contrib/vhost-user-gpu/vhost-user-gpu.c b/contrib/vhost-user-gpu/vhost-user-gpu.c
index f70b34c179f3..5240b171d538 100644
--- a/contrib/vhost-user-gpu/vhost-user-gpu.c
+++ b/contrib/vhost-user-gpu/vhost-user-gpu.c
@@ -268,17 +268,18 @@ get_display_info_cb(gint fd, GIOCondition condition, gpointer user_data)
 {
     struct virtio_gpu_resp_display_info dpy_info = { {} };
     VuGpu *vg = user_data;
-    struct virtio_gpu_ctrl_command *cmd = QTAILQ_LAST(&vg->fenceq);
+    struct virtio_gpu_ctrl_command *cmd = vg->pending_cmd;
 
     g_debug("disp info cb");
-    assert(cmd->cmd_hdr.type == VIRTIO_GPU_CMD_GET_DISPLAY_INFO);
+    assert(cmd && cmd->cmd_hdr.type == VIRTIO_GPU_CMD_GET_DISPLAY_INFO);
     if (!vg_recv_msg(vg, VHOST_USER_GPU_GET_DISPLAY_INFO,
                      sizeof(dpy_info), &dpy_info)) {
         return G_SOURCE_CONTINUE;
     }
 
-    QTAILQ_REMOVE(&vg->fenceq, cmd, next);
+    vg->pending_cmd = NULL;
     vg_ctrl_response(vg, cmd, &dpy_info.hdr, sizeof(dpy_info));
+    free(cmd);
 
     vg->wait_in = 0;
     vg_handle_ctrl(&vg->dev.parent, 0);
@@ -297,6 +298,7 @@ vg_get_display_info(VuGpu *vg, struct virtio_gpu_ctrl_command *cmd)
     assert(vg->wait_in == 0);
 
     vg_send_msg(vg, &msg, -1);
+    vg->pending_cmd = cmd;
     vg->wait_in = g_unix_fd_add(vg->sock_fd, G_IO_IN | G_IO_HUP,
                                get_display_info_cb, vg);
     cmd->state = VG_CMD_STATE_PENDING;
@@ -307,17 +309,18 @@ get_edid_cb(gint fd, GIOCondition condition, gpointer user_data)
 {
     struct virtio_gpu_resp_edid resp_edid;
     VuGpu *vg = user_data;
-    struct virtio_gpu_ctrl_command *cmd = QTAILQ_LAST(&vg->fenceq);
+    struct virtio_gpu_ctrl_command *cmd = vg->pending_cmd;
 
     g_debug("get edid cb");
-    assert(cmd->cmd_hdr.type == VIRTIO_GPU_CMD_GET_EDID);
+    assert(cmd && cmd->cmd_hdr.type == VIRTIO_GPU_CMD_GET_EDID);
     if (!vg_recv_msg(vg, VHOST_USER_GPU_GET_EDID,
                      sizeof(resp_edid), &resp_edid)) {
         return G_SOURCE_CONTINUE;
     }
 
-    QTAILQ_REMOVE(&vg->fenceq, cmd, next);
+    vg->pending_cmd = NULL;
     vg_ctrl_response(vg, cmd, &resp_edid.hdr, sizeof(resp_edid));
+    free(cmd);
 
     vg->wait_in = 0;
     vg_handle_ctrl(&vg->dev.parent, 0);
@@ -344,6 +347,7 @@ vg_get_edid(VuGpu *vg, struct virtio_gpu_ctrl_command *cmd)
     assert(vg->wait_in == 0);
 
     vg_send_msg(vg, &msg, -1);
+    vg->pending_cmd = cmd;
     vg->wait_in = g_unix_fd_add(vg->sock_fd, G_IO_IN | G_IO_HUP,
                                get_edid_cb, vg);
     cmd->state = VG_CMD_STATE_PENDING;
@@ -940,6 +944,11 @@ vg_handle_ctrl(VuDev *dev, int qidx)
             }
         }
 
+        if (cmd->state == VG_CMD_STATE_PENDING) {
+            /* freed by the frontend reply callback */
+            continue;
+        }
+
         if (cmd->state != VG_CMD_STATE_FINISHED) {
             QTAILQ_INSERT_TAIL(&vg->fenceq, cmd, next);
             vg->inflight++;
diff --git a/contrib/vhost-user-gpu/virgl.c b/contrib/vhost-user-gpu/virgl.c
index 0ef4b9d8c903..3242bf13586d 100644
--- a/contrib/vhost-user-gpu/virgl.c
+++ b/contrib/vhost-user-gpu/virgl.c
@@ -608,6 +608,10 @@ virgl_write_fence(void *opaque, uint32_t fence)
          * the guest can end up emitting fences out of order
          * so we should check all fenced cmds not just the first one.
          */
+        if (cmd->state == VG_CMD_STATE_PENDING) {
+            /* not fenced, completed by the frontend reply */
+            continue;
+        }
         if (cmd->cmd_hdr.fence_id > fence) {
             continue;
         }
diff --git a/contrib/vhost-user-gpu/vugpu.h b/contrib/vhost-user-gpu/vugpu.h
index aaf2870cb24d..1c2b0ed4fbe8 100644
--- a/contrib/vhost-user-gpu/vugpu.h
+++ b/contrib/vhost-user-gpu/vugpu.h
@@ -147,6 +147,9 @@ typedef struct VuGpu {
     struct virtio_gpu_scanout scanout[VIRTIO_GPU_MAX_SCANOUTS];
     QTAILQ_HEAD(, virtio_gpu_simple_resource) reslist;
     QTAILQ_HEAD(, virtio_gpu_ctrl_command) fenceq;
+
+    /* command waiting for a reply from the frontend */
+    struct virtio_gpu_ctrl_command *pending_cmd;
 } VuGpu;
 
 enum {

-- 
2.56.0.116.g6de20f6092dc


