Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6E5FCCFA1A
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Nov 2025 14:37:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vI6Vq-00029w-4N; Sun, 09 Nov 2025 09:35:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vI6Vo-00029W-KP
 for qemu-devel@nongnu.org; Sun, 09 Nov 2025 09:35:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vI6Vn-0001mk-4B
 for qemu-devel@nongnu.org; Sun, 09 Nov 2025 09:35:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762698922;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Pt3iK4k3XJgwCHPG4a0Z+4Zt+KSBFtaVquZ5c/VlL5E=;
 b=Pn9bypKN+a2LRKgC707sxRkzon6RFXNcytj1ERGntXBSTzhzWCwGPfcpL6PP38NybTdyE1
 V3wtWj8X02esZRnOuG5mLmWfulkRL9TCfLL8bKID/EDFwnpSPA2hBMUA5Ik3HGpoiykb+a
 P4I1XGoDP2km9KP3LUczyhnmi347RXw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-278-HkSkFu0dNEaiUcDlO8PR6Q-1; Sun, 09 Nov 2025 09:35:20 -0500
X-MC-Unique: HkSkFu0dNEaiUcDlO8PR6Q-1
X-Mimecast-MFC-AGG-ID: HkSkFu0dNEaiUcDlO8PR6Q_1762698919
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-47496b3c1dcso16572265e9.3
 for <qemu-devel@nongnu.org>; Sun, 09 Nov 2025 06:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762698919; x=1763303719; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Pt3iK4k3XJgwCHPG4a0Z+4Zt+KSBFtaVquZ5c/VlL5E=;
 b=JVdMkAIPsOD03kq3A1MRvLaUphwQvFa/C9mAnVwphC00Bgnj4ZZNsfkbD2OcMZ6wgx
 LExaTax1AWERKdZpcI8RxETOfuoZGMgKb6ZFSJP8snFheCzvJgrQly1SKQrEhdg3+F0k
 KTJvIzi3wJURs5xUYBRHV4Q57shgcp3Gs818NF6FbIwQajTBzGLh+oC1Wa8yFrJBrXfd
 vd3rQt+BDSCw0S2UotT3bL121iavhDyCmfgaAFmJgl3K1Vb8uPUNoLnPKWsW8j4tbaPI
 Gr97QxJpO1DjLZ3ZmI6Tyah+KhmBLfPncT3J0AX9Y8NbJXOcLf27GMUZGgZnwsGDB29j
 AZSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762698919; x=1763303719;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pt3iK4k3XJgwCHPG4a0Z+4Zt+KSBFtaVquZ5c/VlL5E=;
 b=P+UI/LeobP0lkJ+vOmkAHew4RB7ELTxUpy/tIP3J2JvivefosyU8zpIsOZkBPMPqYJ
 9/PLpxhx5KFSFgBIr8VgE3V110gg+gx2balX/g7RUFnkraJ4tnhpy1mZ4VcgK6khUTh2
 P50NQcCD2yVFW1DujKPqYOdAnOG4/EiflHNKxadwVy9FM1XAtKKH705P3GlFc7a8+KOE
 Y/Ug275YdeMCdF6cxbMv068GbeyLjbVJFEl6MNWMthf1LzTYGcHjkFO1QRa4be7R1OQU
 0hI9Fa0m3vb2ph/f93sIPpeA0QArpDaOOLq9d0ckHjlaam8N9rw6YS6bW1CMawZUCAxn
 bfYg==
X-Gm-Message-State: AOJu0Ywy9cS7kNmf0lcaA/IUyVS9TywgDC1VqvJcMutyh5LyG3YnjpLe
 ZHJUkYHFz84q3btL0ohiGFPk69zfGOGsAZxjRVhAKe34fMCRfXu7BaFVJdgn1qsY4YOZNP460Ri
 n1rJja5nxUhKL3GxfJ6JIGrWPtR+5t7pUuSfXnJkaAGK1fK/JC7+ZxFvXV7Sx/jmpZ73Jb24ka7
 D9QlUYhiLe3ERP4xvnl/ePuc9SwBCtiFWI4g==
X-Gm-Gg: ASbGncsgXR7DEo2Ld40NBkall/Zse4A99ebbV3b+BY5CkmiPEcsZjIL8jFWmrJOSwZc
 lpAsYzpyu6ArWO1SBbofPBXurDIas/U0baHv/Cf1ekJyz0iNRGpiKnf4ZKmIS83oGd/M6LE6KbB
 93fjoQsIipRwdocu2aTviBd/N6Fg9YvGSQIod5X0fKB/Dzwv+cmec4eMEcA/dbXHKTCmcMqHTfp
 O2Nl1nSPWgV0yibm1rReIoF/MKJyeffyyn0xluP+3uWNQSxlaVWBP8n1yP+++73Nm+JrtDXEqDX
 W5Qar8XQe0oYw1tk+bJHOmIAZGY99y4k6zkCNBVPMz0i6MiG2UXga/nzAdQPkZ+pAS8=
X-Received: by 2002:a05:600c:468e:b0:477:63b5:7148 with SMTP id
 5b1f17b1804b1-477732298bbmr41798115e9.6.1762698918990; 
 Sun, 09 Nov 2025 06:35:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGVd3ngk0MBEx6uqvnrG/1n3mpzGOuiPvXoHFf2jzbyDF+3R4HArGNg6Pv6SIanSiXG3yBsEg==
X-Received: by 2002:a05:600c:468e:b0:477:63b5:7148 with SMTP id
 5b1f17b1804b1-477732298bbmr41797785e9.6.1762698918244; 
 Sun, 09 Nov 2025 06:35:18 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1536:2700:9203:49b4:a0d:b580])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47763e170ecsm87914155e9.2.2025.11.09.06.35.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Nov 2025 06:35:17 -0800 (PST)
Date: Sun, 9 Nov 2025 09:35:16 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Albert Esteve <aesteve@redhat.com>, qemu-stable@nongnu.org,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL 04/14] vhost-user: fix shared object lookup handler logic
Message-ID: <fde5930cc37175cfcd0f03a089e26f4458a52311.1762698873.git.mst@redhat.com>
References: <cover.1762698873.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1762698873.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Albert Esteve <aesteve@redhat.com>

Refactor backend_read() function and add a reply_ack variable
to have the option for handlers to force tweak whether they should
send a reply or not without depending on VHOST_USER_NEED_REPLY_MASK
flag.

This fixes an issue with
vhost_user_backend_handle_shared_object_lookup() logic, as the
error path was not closing the backend channel correctly. So,
we can remove the reply call from within the handler, make
sure it returns early on errors as other handlers do and
set the reply_ack variable on backend_read() to true to ensure
that it will send a response, thus keeping the original intent.

Fixes: 1609476662 ("vhost-user: add shared_object msg")
Cc: qemu-stable@nongnu.org
Signed-off-by: Albert Esteve <aesteve@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20251017072011.1874874-2-aesteve@redhat.com>
---
 hw/virtio/vhost-user.c | 40 +++++++++++++---------------------------
 1 file changed, 13 insertions(+), 27 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index aac98f898a..4b0fae12ae 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -1668,14 +1668,6 @@ static bool vhost_user_send_resp(QIOChannel *ioc, VhostUserHeader *hdr,
     return !qio_channel_writev_all(ioc, iov, ARRAY_SIZE(iov), errp);
 }
 
-static bool
-vhost_user_backend_send_dmabuf_fd(QIOChannel *ioc, VhostUserHeader *hdr,
-                                  VhostUserPayload *payload, Error **errp)
-{
-    hdr->size = sizeof(payload->u64);
-    return vhost_user_send_resp(ioc, hdr, payload, errp);
-}
-
 int vhost_user_get_shared_object(struct vhost_dev *dev, unsigned char *uuid,
                                  int *dmabuf_fd)
 {
@@ -1716,19 +1708,15 @@ int vhost_user_get_shared_object(struct vhost_dev *dev, unsigned char *uuid,
 
 static int
 vhost_user_backend_handle_shared_object_lookup(struct vhost_user *u,
-                                               QIOChannel *ioc,
-                                               VhostUserHeader *hdr,
-                                               VhostUserPayload *payload)
+                                               VhostUserShared *object)
 {
     QemuUUID uuid;
     CharFrontend *chr = u->user->chr;
-    Error *local_err = NULL;
     int dmabuf_fd = -1;
     int fd_num = 0;
 
-    memcpy(uuid.data, payload->object.uuid, sizeof(payload->object.uuid));
+    memcpy(uuid.data, object->uuid, sizeof(object->uuid));
 
-    payload->u64 = 0;
     switch (virtio_object_type(&uuid)) {
     case TYPE_DMABUF:
         dmabuf_fd = virtio_lookup_dmabuf(&uuid);
@@ -1737,18 +1725,16 @@ vhost_user_backend_handle_shared_object_lookup(struct vhost_user *u,
     {
         struct vhost_dev *dev = virtio_lookup_vhost_device(&uuid);
         if (dev == NULL) {
-            payload->u64 = -EINVAL;
-            break;
+            return -EINVAL;
         }
         int ret = vhost_user_get_shared_object(dev, uuid.data, &dmabuf_fd);
         if (ret < 0) {
-            payload->u64 = ret;
+            return ret;
         }
         break;
     }
     case TYPE_INVALID:
-        payload->u64 = -EINVAL;
-        break;
+        return -EINVAL;
     }
 
     if (dmabuf_fd != -1) {
@@ -1757,11 +1743,6 @@ vhost_user_backend_handle_shared_object_lookup(struct vhost_user *u,
 
     if (qemu_chr_fe_set_msgfds(chr, &dmabuf_fd, fd_num) < 0) {
         error_report("Failed to set msg fds.");
-        payload->u64 = -EINVAL;
-    }
-
-    if (!vhost_user_backend_send_dmabuf_fd(ioc, hdr, payload, &local_err)) {
-        error_report_err(local_err);
         return -EINVAL;
     }
 
@@ -1790,6 +1771,7 @@ static gboolean backend_read(QIOChannel *ioc, GIOCondition condition,
     struct iovec iov;
     g_autofree int *fd = NULL;
     size_t fdsize = 0;
+    bool reply_ack;
     int i;
 
     /* Read header */
@@ -1808,6 +1790,8 @@ static gboolean backend_read(QIOChannel *ioc, GIOCondition condition,
         goto err;
     }
 
+    reply_ack = hdr.flags & VHOST_USER_NEED_REPLY_MASK;
+
     /* Read payload */
     if (qio_channel_read_all(ioc, (char *) &payload, hdr.size, &local_err)) {
         error_report_err(local_err);
@@ -1833,8 +1817,10 @@ static gboolean backend_read(QIOChannel *ioc, GIOCondition condition,
                                                              &payload.object);
         break;
     case VHOST_USER_BACKEND_SHARED_OBJECT_LOOKUP:
-        ret = vhost_user_backend_handle_shared_object_lookup(dev->opaque, ioc,
-                                                             &hdr, &payload);
+        /* The backend always expects a response */
+        reply_ack = true;
+        ret = vhost_user_backend_handle_shared_object_lookup(dev->opaque,
+                                                             &payload.object);
         break;
     default:
         error_report("Received unexpected msg type: %d.", hdr.request);
@@ -1845,7 +1831,7 @@ static gboolean backend_read(QIOChannel *ioc, GIOCondition condition,
      * REPLY_ACK feature handling. Other reply types has to be managed
      * directly in their request handlers.
      */
-    if (hdr.flags & VHOST_USER_NEED_REPLY_MASK) {
+    if (reply_ack) {
         payload.u64 = !!ret;
         hdr.size = sizeof(payload.u64);
 
-- 
MST


