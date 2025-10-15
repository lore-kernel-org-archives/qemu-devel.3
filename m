Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF0EFCCD193
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 11:54:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v903m-0006Tk-Ql; Wed, 15 Oct 2025 07:52:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1v903l-0006TF-4O
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 07:52:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1v903a-0006wL-6F
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 07:52:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760529146;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lBRxFcs45EXG1VdekFCCLohl0yrjHFOEkbEcXwZAR9c=;
 b=gBJE/3bzPtibZwyomzBQPp/LE/LZsAoJKTVpvvJge0vcUIENi7bBS/ziDHbvkiE1tABFvk
 e0qrof+OCQ/BetCb+OTRJ4Shvxsjk27Ryy/pAfJ3oY5AdBzjjZOQTqYWn+II6M2ZapLa0l
 i1eX00+ilZ/emt8NeVBcEfMOR5ySHBg=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-jagqdWVgPLGFJyxOwN556Q-1; Wed, 15 Oct 2025 07:52:22 -0400
X-MC-Unique: jagqdWVgPLGFJyxOwN556Q-1
X-Mimecast-MFC-AGG-ID: jagqdWVgPLGFJyxOwN556Q_1760529142
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8776a952dd4so409799776d6.3
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 04:52:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760529142; x=1761133942;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lBRxFcs45EXG1VdekFCCLohl0yrjHFOEkbEcXwZAR9c=;
 b=bua6jRiaSpd3UO1p3UqKZbA6cVk5Ar50Z9h/BGht7DyeRgF7nIsd3mJO5T8dS7ocga
 COANAL6amsnhE7Z6ordQcy26q7WB0XBPCB8evQ8/XN9cBFNeYgPbuhaTyfMqU1dmK3tw
 TDonAje1sRjTIf9qa+tDUaGWRIEOfKx3TmSu3AOwkU6/vKgbfZllTgLYZur7Q7WKvjbw
 hnM18BqvXqMzplUy/yVikjNhDs7mc69VFItaUfZWaZVSUpflJ0ZWpcf+W2QlFAreoCjL
 fiSQruIc6pIu5PkqbcWxqlftot4KK/tZcsQHju+Y1Y29nS/+0rJoImMhy9oEFDgpNHS9
 /9zQ==
X-Gm-Message-State: AOJu0YwuxN7PF0iVI9bcQ3KmVShgqSn5dWeFLKz3VuvlBvbZ/wpU15yy
 aiUQUp+AumZa7Knlk8PJYLwt3IwdXbvIv03zWOdNp89tJmwo7rQeQoxzKnPi1KPDj/OiAze3igi
 JpxxX835u3eHVY0UN1ArCZkbxj2qdEuyE4f393Q5HzXUtQZdRpwyEJ/+9
X-Gm-Gg: ASbGncu6sHJj+SA9KVMWTYp8docWHKZm7cGJmJ632pwxmYKMq03haqbpiuq1nJhMqFg
 VbwUeIc8KSIPlbReCzWII7pElmKuGTXooAiYUIVI1aPtomPrr0BHZ4mDYQ6w9AlpytgborMQJ2M
 EM8aHaeYuuKpORwZErOCZ2RR0GokF537PGvdqYkVU3JgsUNZZG+t49eTSkXyulFYH7hPpMnTZMA
 oAuBGaeYCdrRRhwuMcd2nhmWhZpOCKNZfCXspXEnUDwP+Np0yi6VgurSq39gTFEgDYfikfJnhlZ
 rRkTPI4tx8/mm8VgvA7JeTGjtLLcwT63hQon+5MgAI8MpxhVfovxPtr8DLHvG9oXRwEvkOJNeBE
 8sOqCcsy8xf049/fS
X-Received: by 2002:a05:622a:5914:b0:4b3:775:ba3 with SMTP id
 d75a77b69052e-4e6ead4ab9dmr442562161cf.49.1760529141770; 
 Wed, 15 Oct 2025 04:52:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQZ2cs+vw8L/WHBbQpxvZLNl9/HqyzvvO2Dg3d7mif1kVZEjmwNGKnwl7adPCp0MKqhfjVVA==
X-Received: by 2002:a05:622a:5914:b0:4b3:775:ba3 with SMTP id
 d75a77b69052e-4e6ead4ab9dmr442561741cf.49.1760529141278; 
 Wed, 15 Oct 2025 04:52:21 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-153.retail.telecomitalia.it.
 [79.46.200.153]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-87c012b5d5csm16325696d6.62.2025.10.15.04.52.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 04:52:20 -0700 (PDT)
Date: Wed, 15 Oct 2025 13:52:15 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Albert Esteve <aesteve@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2] vhost-user: add reply_ack to backend_read
Message-ID: <lsk6b2gl76fmp7zukzjnuncxs7nrscwhy2vxq3wv77rhed4kmg@5lcajhmx2kef>
References: <20251015113634.1566785-1-aesteve@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251015113634.1566785-1-aesteve@redhat.com>
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

Thanks for the refactoring, IMO now it's much better and easy to read.

BTW, the previous title was better IMHO because it made it clear that 
this is a fix, whereas now it looks more like a refactoring and could 
therefore be difficult to interpret as something to be backported to 
stable branches. So I suggest just to revert the title, the following 
description LGTM.

On Wed, Oct 15, 2025 at 01:36:34PM +0200, Albert Esteve wrote:
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

Should we cc stable?
If yes, please add:

Cc: qemu-stable@nongnu.org

>Signed-off-by: Albert Esteve <aesteve@redhat.com>
>---
> hw/virtio/vhost-user.c | 36 +++++++++++-------------------------
> 1 file changed, 11 insertions(+), 25 deletions(-)
>
>diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
>index 36c9c2e04d..b0bcee2d30 100644
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
>                                                VhostUserPayload *payload)

Can we now uniform this function with the other `*_shared_object_*` 
functions, passing `VhostUserShared *object` instead of the entire 
payload?

The rest LGTM!

Thanks,
Stefano

> {
>     QemuUUID uuid;
>     CharBackend *chr = u->user->chr;
>-    Error *local_err = NULL;
>     int dmabuf_fd = -1;
>     int fd_num = 0;
>
>     memcpy(uuid.data, payload->object.uuid, sizeof(payload->object.uuid));
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
>     }
>
>     if (dmabuf_fd != -1) {
>@@ -1757,11 +1743,6 @@ vhost_user_backend_handle_shared_object_lookup(struct vhost_user *u,
>
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
>+                                                             &payload);
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


