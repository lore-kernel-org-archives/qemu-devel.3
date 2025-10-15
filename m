Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06422CCD192
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 12:59:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v914P-0008AW-Dx; Wed, 15 Oct 2025 08:57:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1v914J-0008AB-J1
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 08:57:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1v914G-0007oK-1w
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 08:57:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760533038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DB7jV/gC3gIXY/yKSAUmGfSINSLdMJxUN2xjqjrtVCo=;
 b=f0Q3Ie5JFoBtZUm6LqEBZ1M4BeBZuli1pFpnfQK33pHhbbjt9w68gv4812doNmVMgNEjYC
 wfv00+4K6CV7I9l3egowkGxc8xccOcfovU0ojIcRkJEIQ/6z84DVUzOghz41E1TN6DfjJ5
 Dj8MH3YjzPaRQ42c+jww/OML52J9m8s=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-vj_PzvkQM_uJ0POZ-TVs3w-1; Wed, 15 Oct 2025 08:57:17 -0400
X-MC-Unique: vj_PzvkQM_uJ0POZ-TVs3w-1
X-Mimecast-MFC-AGG-ID: vj_PzvkQM_uJ0POZ-TVs3w_1760533037
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-88e35354330so308269585a.1
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 05:57:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760533036; x=1761137836;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DB7jV/gC3gIXY/yKSAUmGfSINSLdMJxUN2xjqjrtVCo=;
 b=khDWzBnx0sbdPSfO2ZBO4R3Kf8TgBQdKQWyXTIvWCS4IlfmMKa6ZGNfUs7Byo0g/s6
 8WebSqxT0SrK7WAh9V57BAYZmbW/nK+y0oCl6NsmIgsUXUh/mDS9vfw4Ufnh2Cc+1+5u
 0h3JCwNLJIIhWkx7t/NJkwWRriArVC1wioXAN1uea74v5sAhyYcsCx3eWS1Is3JTI6yP
 jytxDRE1RWXw9i7soy+kCl9uIkvbsdGAiJdcWuFUm/DEXCMsLBzEkwHYAgohexwN3X6W
 O4YFUVmTzRsmxGYPStDihe9vuFH6o+eRh/cKxFvkBI5+uEVfbfjbvcf3RLZA/zJy03w6
 XgMg==
X-Gm-Message-State: AOJu0YxNP6CBdbAzolDOljCE1oSYwhFp0aHA89NqB8RS6wYdN7afJ5MB
 lf5dS+eXsfzugIxCxyQ51Hu8kz0lstqO6eA3Y8VFAZEfFN3d78091QGdbUzW5JASNNATtYkN8Ln
 FUBzId08COsY+UBbpOABi2aKWa+gjjiiaaDd+gWPbItALW5qp2QYle/k5
X-Gm-Gg: ASbGnct3mlMqe1MpY2vsM8CNj80awK08hf22JVbdQ1gZp5oJc7/L+07k1+Hf76ybGoR
 34i1YE75MHI0aoEeSG3SycrKo3rRSNnHUrX5Q1+b0trvBWaW28zcioebUDhZ/lIsZwE+U4+mmsU
 uXu+KC6EOMp+Z8IeWyRFaid4NXIOj/+CzgYXDqQLgwGh7rAWmT+6dblMEbl7/NtOgKX42DdFHiy
 kpPE0Mw1/6DvPswGNWvGb2UKmrUCGcqkEfggFFDUr0RPt3dZjBO6WcM3I+7UG7hx3f2qyIBhLp2
 qkVMncMdgrCPqLp5BYBdpH6wpV4ClVqwuKV7Kz+ZOnga+8NK/gDllyV8xDvuiTXAsZajelDOQ7W
 6yH3MENHQKjemaZe1
X-Received: by 2002:ac8:5885:0:b0:4b6:2f52:5342 with SMTP id
 d75a77b69052e-4e6ead7c8b1mr376540881cf.79.1760533036524; 
 Wed, 15 Oct 2025 05:57:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQzBqB9A0Azl9DKjOVSVE7puZI/5VwS88WbpwLdqJke/HAZuOc1+ZMj5XrdXUX8dEbHRQn+A==
X-Received: by 2002:ac8:5885:0:b0:4b6:2f52:5342 with SMTP id
 d75a77b69052e-4e6ead7c8b1mr376540611cf.79.1760533035941; 
 Wed, 15 Oct 2025 05:57:15 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-153.retail.telecomitalia.it.
 [79.46.200.153]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4e881d01f5asm18771851cf.27.2025.10.15.05.57.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 05:57:15 -0700 (PDT)
Date: Wed, 15 Oct 2025 14:57:08 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Albert Esteve <aesteve@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 qemu-stable@nongnu.org
Subject: Re: [PATCH v3] vhost-user: fix shared object lookup handler logic
Message-ID: <zey3wf53mapbrc25xwal3dia5fb4tddyxghvzjpy2p2fm6cdcp@7dlkcuzpcoho>
References: <20251015124314.1588018-1-aesteve@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251015124314.1588018-1-aesteve@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Oct 15, 2025 at 02:43:14PM +0200, Albert Esteve wrote:
>Refactor backend_read() function and add a reply_ack variable
>to have the option for handlers to force tweak whether they should
>send a reply or not without depending on VHOST_USER_NEED_REPLY_MASK
>flag.
>
>This fixes an issue with
>vhost_user_backend_handle_shared_object_lookup() logic, as the
>error path was not closing the backend channel correctly. So,
>we can remove the reply call from within the handler, make
>sure it returns early on errors as other handlers do and
>set the reply_ack variable on backend_read() to true to ensure
>that it will send a response, thus keeping the original intent.
>
>Fixes: 160947666276c5b7f6bca4d746bcac2966635d79
>Cc: qemu-stable@nongnu.org
>Signed-off-by: Albert Esteve <aesteve@redhat.com>
>---
> hw/virtio/vhost-user.c | 40 +++++++++++++---------------------------
> 1 file changed, 13 insertions(+), 27 deletions(-)

Thanks! This patch LGTM, so

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>


But I left couple of comments that is not related to this fix and maybe 
should be fixed separately:

>
>diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
>index 36c9c2e04d..8a93f1d4b5 100644
>--- a/hw/virtio/vhost-user.c
>+++ b/hw/virtio/vhost-user.c
>@@ -1668,14 +1668,6 @@ static bool vhost_user_send_resp(QIOChannel *ioc, VhostUserHeader *hdr,
>     return !qio_channel_writev_all(ioc, iov, ARRAY_SIZE(iov), errp);
> }
>
>-static bool
>-vhost_user_backend_send_dmabuf_fd(QIOChannel *ioc, VhostUserHeader *hdr,
>-                                  VhostUserPayload *payload, Error **errp)
>-{
>-    hdr->size = sizeof(payload->u64);
>-    return vhost_user_send_resp(ioc, hdr, payload, errp);
>-}
>-
> int vhost_user_get_shared_object(struct vhost_dev *dev, unsigned char *uuid,
>                                  int *dmabuf_fd)
> {
>@@ -1716,19 +1708,15 @@ int vhost_user_get_shared_object(struct vhost_dev *dev, unsigned char *uuid,
>
> static int
> vhost_user_backend_handle_shared_object_lookup(struct vhost_user *u,
>-                                               QIOChannel *ioc,
>-                                               VhostUserHeader *hdr,
>-                                               VhostUserPayload 
>*payload)
>+                                               VhostUserShared *object)
> {
>     QemuUUID uuid;
>     CharBackend *chr = u->user->chr;
>-    Error *local_err = NULL;
>     int dmabuf_fd = -1;
>     int fd_num = 0;
>
>-    memcpy(uuid.data, payload->object.uuid, sizeof(payload->object.uuid));
>+    memcpy(uuid.data, object->uuid, sizeof(object->uuid));
>
>-    payload->u64 = 0;
>     switch (virtio_object_type(&uuid)) {
>     case TYPE_DMABUF:
>         dmabuf_fd = virtio_lookup_dmabuf(&uuid);
>@@ -1737,18 +1725,16 @@ vhost_user_backend_handle_shared_object_lookup(struct vhost_user *u,
>     {
>         struct vhost_dev *dev = virtio_lookup_vhost_device(&uuid);
>         if (dev == NULL) {
>-            payload->u64 = -EINVAL;
>-            break;
>+            return -EINVAL;
>         }
>         int ret = vhost_user_get_shared_object(dev, uuid.data, &dmabuf_fd);
>         if (ret < 0) {
>-            payload->u64 = ret;
>+            return ret;
>         }
>         break;
>     }
>     case TYPE_INVALID:
>-        payload->u64 = -EINVAL;
>-        break;
>+        return -EINVAL;

So, after this patch, we are not going to call 
`qemu_chr_fe_set_msgfds()` when we are returning an error to the 
backend. I guess this is even better than before, right?

>     }
>
>     if (dmabuf_fd != -1) {
>@@ -1757,11 +1743,6 @@ 
>vhost_user_backend_handle_shared_object_lookup(struct vhost_user *u,
>

Should we call qemu_chr_fe_set_msgfds() only if fd_num > 0?
Or should we return an error if `dmabuf_fd` is not a valid fd?

I guess this is pre-existing and maybe should be fixed in another patch 
if it's a problem.

Thanks,
Stefano

>     if (qemu_chr_fe_set_msgfds(chr, &dmabuf_fd, fd_num) < 0) {
>         error_report("Failed to set msg fds.");
>-        payload->u64 = -EINVAL;
>-    }
>-
>-    if (!vhost_user_backend_send_dmabuf_fd(ioc, hdr, payload, &local_err)) {
>-        error_report_err(local_err);
>         return -EINVAL;
>     }
>
>@@ -1790,6 +1771,7 @@ static gboolean backend_read(QIOChannel *ioc, GIOCondition condition,
>     struct iovec iov;
>     g_autofree int *fd = NULL;
>     size_t fdsize = 0;
>+    bool reply_ack;
>     int i;
>
>     /* Read header */
>@@ -1808,6 +1790,8 @@ static gboolean backend_read(QIOChannel *ioc, GIOCondition condition,
>         goto err;
>     }
>
>+    reply_ack = hdr.flags & VHOST_USER_NEED_REPLY_MASK;
>+
>     /* Read payload */
>     if (qio_channel_read_all(ioc, (char *) &payload, hdr.size, &local_err)) {
>         error_report_err(local_err);
>@@ -1833,8 +1817,10 @@ static gboolean backend_read(QIOChannel *ioc, GIOCondition condition,
>                                                              &payload.object);
>         break;
>     case VHOST_USER_BACKEND_SHARED_OBJECT_LOOKUP:
>-        ret = vhost_user_backend_handle_shared_object_lookup(dev->opaque, ioc,
>-                                                             &hdr, &payload);
>+        /* The backend always expects a response */
>+        reply_ack = true;
>+        ret = vhost_user_backend_handle_shared_object_lookup(dev->opaque,
>+                                                             &payload.object);
>         break;
>     default:
>         error_report("Received unexpected msg type: %d.", hdr.request);
>@@ -1845,7 +1831,7 @@ static gboolean backend_read(QIOChannel *ioc, GIOCondition condition,
>      * REPLY_ACK feature handling. Other reply types has to be managed
>      * directly in their request handlers.
>      */
>-    if (hdr.flags & VHOST_USER_NEED_REPLY_MASK) {
>+    if (reply_ack) {
>         payload.u64 = !!ret;
>         hdr.size = sizeof(payload.u64);
>
>-- 
>2.49.0
>


