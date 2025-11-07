Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FD1ACCF9E3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Nov 2025 13:26:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vHMTe-0004lQ-5P; Fri, 07 Nov 2025 08:26:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vHMTc-0004l3-Og
 for qemu-devel@nongnu.org; Fri, 07 Nov 2025 08:26:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vHMTa-0007kE-Js
 for qemu-devel@nongnu.org; Fri, 07 Nov 2025 08:26:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762521961;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xKH1IpeQCoNT/j75bSpk1L1CPw7frkK8KuxMoiJTUh8=;
 b=Kn7KOAntc8XIJYeYxwAt3ZZC4+kIRL6WzMD0GXrKaLk1P9XZUbk/qQSZ8L764jb0XJt+PM
 EXvo4yTcoft/+Wlpl4uh2HxjV/kXNOmYpb8as3yJGz9IF3E5dQuq0TQAuWHwu6EoSnqIir
 cohFd4xkCvIa/qshKS3Kkugd5iXa6Qo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-Mg0UM6ERMeiwFB06-VDjtw-1; Fri, 07 Nov 2025 08:26:00 -0500
X-MC-Unique: Mg0UM6ERMeiwFB06-VDjtw-1
X-Mimecast-MFC-AGG-ID: Mg0UM6ERMeiwFB06-VDjtw_1762521959
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4775e00b16fso6073145e9.2
 for <qemu-devel@nongnu.org>; Fri, 07 Nov 2025 05:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762521959; x=1763126759; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xKH1IpeQCoNT/j75bSpk1L1CPw7frkK8KuxMoiJTUh8=;
 b=rvHxYADW9m2YPhm2fV+xmbJkXWIVY3y8L+SbT38vZNo5AYZ9eA7IxLVAuQYYTW2gTw
 caznt0iVF2lxMwxws5UB0Wzp77ssq4OrAvPvxouMJchFVgqL3UT3x5ScH3ld7p1El40e
 NAZR+BRF9JWqF8GE68e0g5yuxazqz6l+soYw78E4O1d6ly4tU+GkdUOv/NfRcsz5c/si
 nOay/ebUKmvUSSDgXXwdJNaio5xOTkEibHaGaGefKTcYO/aevYFDb2Gctx841QgDoSGP
 4S9FvY2cLjoYE41duBFVU6tw6pcbP0Af2Cz1hZFp+7NJZ+DsXblhPS+sAzcxgsnjALHh
 mqFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762521959; x=1763126759;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xKH1IpeQCoNT/j75bSpk1L1CPw7frkK8KuxMoiJTUh8=;
 b=NaZDCnSh8L4tFSIfxfidsRK6YaEjZoFGXF5LahcaW/FWBXynqZ43S5wFE2fOYtoPUB
 E9wmQsA615eb+lTop8eM7Z93M0ulXU/ni+I/pvE1YgYL7/648h+cQTEzCgiQqQLFuTSC
 GfAlTL6w7XwfHXkAsmHd7JMAEHARiYGaZ9Ge/HvWm/PIImnCgsLgRmWPd7LwkIpn9CoN
 u2CKhPR/I91k/bhflKqGCVUQeS6ugZVcc4O6YH9QEr9mUQezcm7JUo6H2kOAf/uw450U
 QHmJ7DSoc4gbPYpRwiBfQx/cPgKN9gvElbas7UPZaM1X2xX/xMbPKX2NZ8JvITbIsO+x
 7Tog==
X-Gm-Message-State: AOJu0Yz/HgN+6/bQNtIdzftI9a8pXlLOXCj2MVySTNVhcI0XROLIVsrZ
 V8ZUPMNYSrEuXgOrBdQ3QkFTmWLNELDAEyS6h0bsh/LT6AEWat1ecndEEcuU3XozuBXtL0dP6Jq
 f9tc2PrrNcNCpfnY3wkE+hnP+TpMtqLItikTlYtHUcd1tTmCWjqUwtT1k
X-Gm-Gg: ASbGncuQKJ3uKDpug8cdE0CV1Mx31TRHhQWMwHY9VCxq2azFUPvGHhOthSzS/XnjVvj
 Bpp8K0tJTmal4jsZOE4bkvMcGeBvsZMV25Dv+SXIwfoWLlILGPLz26YNxiSPhJSdPflE0CP1ByA
 wDIFK4x82gXrywrFfd1NuOzRueUiD922ddGA1i5+BM1m3fJUorqi9UQO4u5yDg4IL9fEsDxSCk7
 GP6gc0Lp/zIoJA7MZuj4kbFjTD6uyTsoWOyTUXXWOMZBEDy5vy5fJqYTYoDjxpMoiEejZ/GCdPJ
 /gOKohFGBVSM3fUrO+b4kwNjxCNCRp7bTNBCpuC7/6rGbGDNviZetf4IkDQKigvgWoo=
X-Received: by 2002:a05:600c:524f:b0:477:54b3:3478 with SMTP id
 5b1f17b1804b1-4776bc86518mr23776795e9.8.1762521959080; 
 Fri, 07 Nov 2025 05:25:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEjH+84/QZO2hTt+43A8QIQk83GCYD/QI455O47BOMreF5nNVHj419j3krUx4QBkYlnZyCO5A==
X-Received: by 2002:a05:600c:524f:b0:477:54b3:3478 with SMTP id
 5b1f17b1804b1-4776bc86518mr23776565e9.8.1762521958533; 
 Fri, 07 Nov 2025 05:25:58 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1536:2700:9203:49b4:a0d:b580])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4775cdc33c8sm163980405e9.2.2025.11.07.05.25.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Nov 2025 05:25:57 -0800 (PST)
Date: Fri, 7 Nov 2025 08:25:55 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Albert Esteve <aesteve@redhat.com>
Cc: qemu-devel@nongnu.org, Stefano Garzarella <sgarzare@redhat.com>,
 qemu-stable@nongnu.org
Subject: Re: [PATCH v4 1/1] vhost-user: fix shared object lookup handler logic
Message-ID: <20251107082334-mutt-send-email-mst@kernel.org>
References: <20251017072011.1874874-1-aesteve@redhat.com>
 <20251017072011.1874874-2-aesteve@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017072011.1874874-2-aesteve@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

On Fri, Oct 17, 2025 at 09:20:11AM +0200, Albert Esteve wrote:
> Refactor backend_read() function and add a reply_ack variable
> to have the option for handlers to force tweak whether they should
> send a reply or not without depending on VHOST_USER_NEED_REPLY_MASK
> flag.
> 
> This fixes an issue with
> vhost_user_backend_handle_shared_object_lookup() logic, as the
> error path was not closing the backend channel correctly. So,
> we can remove the reply call from within the handler, make
> sure it returns early on errors as other handlers do and
> set the reply_ack variable on backend_read() to true to ensure
> that it will send a response, thus keeping the original intent.
> 
> Fixes: 160947666276c5b7f6bca4d746bcac2966635d79


I fixed this, should include the subject.

> Cc: qemu-stable@nongnu.org
> Signed-off-by: Albert Esteve <aesteve@redhat.com>


So I picked this for now, but I worry that we are opening ourselves
up to buggy backends which forget to set the flag and expect
frontend to behave properly.

I think a better fix would be instead of forcing, check reply_ack,
and fail if not set correctly.

> ---
>  hw/virtio/vhost-user.c | 42 +++++++++++++++---------------------------
>  1 file changed, 15 insertions(+), 27 deletions(-)
> 
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index 890be55937..762d7218d3 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -1696,14 +1696,6 @@ static bool vhost_user_send_resp(QIOChannel *ioc, VhostUserHeader *hdr,
>      return !qio_channel_writev_all(ioc, iov, ARRAY_SIZE(iov), errp);
>  }
>  
> -static bool
> -vhost_user_backend_send_dmabuf_fd(QIOChannel *ioc, VhostUserHeader *hdr,
> -                                  VhostUserPayload *payload, Error **errp)
> -{
> -    hdr->size = sizeof(payload->u64);
> -    return vhost_user_send_resp(ioc, hdr, payload, errp);
> -}
> -
>  int vhost_user_get_shared_object(struct vhost_dev *dev, unsigned char *uuid,
>                                   int *dmabuf_fd)
>  {
> @@ -1744,19 +1736,15 @@ int vhost_user_get_shared_object(struct vhost_dev *dev, unsigned char *uuid,
>  
>  static int
>  vhost_user_backend_handle_shared_object_lookup(struct vhost_user *u,
> -                                               QIOChannel *ioc,
> -                                               VhostUserHeader *hdr,
> -                                               VhostUserPayload *payload)
> +                                               VhostUserShared *object)
>  {
>      QemuUUID uuid;
>      CharBackend *chr = u->user->chr;
> -    Error *local_err = NULL;
>      int dmabuf_fd = -1;
>      int fd_num = 0;
>  
> -    memcpy(uuid.data, payload->object.uuid, sizeof(payload->object.uuid));
> +    memcpy(uuid.data, object->uuid, sizeof(object->uuid));
>  
> -    payload->u64 = 0;
>      switch (virtio_object_type(&uuid)) {
>      case TYPE_DMABUF:
>          dmabuf_fd = virtio_lookup_dmabuf(&uuid);
> @@ -1765,18 +1753,16 @@ vhost_user_backend_handle_shared_object_lookup(struct vhost_user *u,
>      {
>          struct vhost_dev *dev = virtio_lookup_vhost_device(&uuid);
>          if (dev == NULL) {
> -            payload->u64 = -EINVAL;
> -            break;
> +            return -EINVAL;
>          }
>          int ret = vhost_user_get_shared_object(dev, uuid.data, &dmabuf_fd);
>          if (ret < 0) {
> -            payload->u64 = ret;
> +            return ret;
>          }
>          break;
>      }
>      case TYPE_INVALID:
> -        payload->u64 = -EINVAL;
> -        break;
> +        return -EINVAL;
>      }
>  
>      if (dmabuf_fd != -1) {
> @@ -1785,11 +1771,6 @@ vhost_user_backend_handle_shared_object_lookup(struct vhost_user *u,
>  
>      if (qemu_chr_fe_set_msgfds(chr, &dmabuf_fd, fd_num) < 0) {
>          error_report("Failed to set msg fds.");
> -        payload->u64 = -EINVAL;
> -    }
> -
> -    if (!vhost_user_backend_send_dmabuf_fd(ioc, hdr, payload, &local_err)) {
> -        error_report_err(local_err);
>          return -EINVAL;
>      }
>  
> @@ -2008,6 +1989,7 @@ static gboolean backend_read(QIOChannel *ioc, GIOCondition condition,
>      struct iovec iov;
>      g_autofree int *fd = NULL;
>      size_t fdsize = 0;
> +    bool reply_ack;
>      int i;
>  
>      /* Read header */
> @@ -2026,6 +2008,8 @@ static gboolean backend_read(QIOChannel *ioc, GIOCondition condition,
>          goto err;
>      }
>  
> +    reply_ack = hdr.flags & VHOST_USER_NEED_REPLY_MASK;
> +
>      /* Read payload */
>      if (qio_channel_read_all(ioc, (char *) &payload, hdr.size, &local_err)) {
>          error_report_err(local_err);
> @@ -2051,11 +2035,14 @@ static gboolean backend_read(QIOChannel *ioc, GIOCondition condition,
>                                                               &payload.object);
>          break;
>      case VHOST_USER_BACKEND_SHARED_OBJECT_LOOKUP:
> -        ret = vhost_user_backend_handle_shared_object_lookup(dev->opaque, ioc,
> -                                                             &hdr, &payload);
> +        /* The backend always expects a response */
> +        reply_ack = true;
> +        ret = vhost_user_backend_handle_shared_object_lookup(dev->opaque,
> +                                                             &payload.object);
>          break;
>      case VHOST_USER_BACKEND_SHMEM_MAP:
>          /* Handler manages its own response, check error and close connection */
> +        reply_ack = false;
>          if (vhost_user_backend_handle_shmem_map(dev, ioc, &hdr, &payload,
>                                                  fd ? fd[0] : -1) < 0) {
>              goto err;
> @@ -2063,6 +2050,7 @@ static gboolean backend_read(QIOChannel *ioc, GIOCondition condition,
>          break;
>      case VHOST_USER_BACKEND_SHMEM_UNMAP:
>          /* Handler manages its own response, check error and close connection */
> +        reply_ack = false;
>          if (vhost_user_backend_handle_shmem_unmap(dev, ioc, &hdr, &payload) < 0) {
>              goto err;
>          }
> @@ -2076,7 +2064,7 @@ static gboolean backend_read(QIOChannel *ioc, GIOCondition condition,
>       * REPLY_ACK feature handling. Other reply types has to be managed
>       * directly in their request handlers.
>       */
> -    if (hdr.flags & VHOST_USER_NEED_REPLY_MASK) {
> +    if (reply_ack) {
>          payload.u64 = !!ret;
>          hdr.size = sizeof(payload.u64);
>  
> -- 
> 2.49.0


