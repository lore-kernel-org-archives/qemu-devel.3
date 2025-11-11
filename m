Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE7EBCCFA18
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 08:59:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIkDO-0005y9-1K; Tue, 11 Nov 2025 03:59:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vIkDM-0005vt-RN
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 03:59:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vIkDK-0002rS-JX
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 03:59:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762851537;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YMeolxTu7oXOmzLPvSHMus7aoozurkhAA7+uGAmWklg=;
 b=VLLHMFYOWwbWCgEYEAcdBo0VxMdhJnIn5gNL53D61VfHlZCv4pmH39AEhQC7ilpO5tsaw/
 459Nte2xv+uM5eQjHqTfWEP4Tikb3FtO/x47gOs+AdVuftp/Dnp5IiobR3H3MN7aO4MdFG
 pBmDH/uCycNXuOQcGm1ftzjFZYMM/kw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-424-Mh6KLEwgPoSlVlFTtVEKxA-1; Tue, 11 Nov 2025 03:58:56 -0500
X-MC-Unique: Mh6KLEwgPoSlVlFTtVEKxA-1
X-Mimecast-MFC-AGG-ID: Mh6KLEwgPoSlVlFTtVEKxA_1762851535
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-42b352355a1so243052f8f.1
 for <qemu-devel@nongnu.org>; Tue, 11 Nov 2025 00:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762851535; x=1763456335; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=YMeolxTu7oXOmzLPvSHMus7aoozurkhAA7+uGAmWklg=;
 b=XllQCWp5v0fuFp3/Gnx4aKRKWdoNoKqwvCz6ELArKA5CyHdF0dHySx5aPUHK2OGZh/
 SddzoqmtykgBxLdg1DB4PpJJ3emz+XOgJvXNUitsqwt+0eavA+DdW/dq9O++Jz8sMHi0
 cBe2fxR49ZIfe/vViPAI9pHbqikJsQZTEuoR3ThHnu3zy8Txh0wePf+9V3+7H8LDYOZk
 3iNpiiF/NIIWIM6+jl27TmYSdJE1uIFiljIfcRHiFCxndyUzO0jXiylcOHb3qlZaYOIq
 mevnZuVtB+G35j6g7o+EdtOxrbR3HnFPPA04i008SHVEBnlvQdLlDvRs5YmUzInP0xDW
 Z1/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762851535; x=1763456335;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YMeolxTu7oXOmzLPvSHMus7aoozurkhAA7+uGAmWklg=;
 b=AFp5qHD/Pzrgm7S1VC93j+gmTDEby5IvWwk0E9UYRJ7iy+V43DZtUvuz3X26gtGD5U
 7H9n4e99fuc3U7+ocDFKrKF7JdXa94yxU6j4pLaU3wc9K9IItBQ36L3S2er1K9g3tRNH
 aXvEtO6FSAJkmQMFCdQeuLRJYexbMcge11HivQZ8s/p4+0ANGZFLaQUGQTYfcFw1JO0g
 XPrkKGD6gEWGQWs0wHIAXnf4tFxS1yBAQ7lj3DqhlTIad1nQSQmKIgacO/iWXjoCFLUI
 1d2lc/5iNfPaYV2/WDn8G8vIKvJ+lglik7fZmT6sqqDi3yNlr8PvYAKRNJ6t3rbTdV7i
 GYTQ==
X-Gm-Message-State: AOJu0YylXv0vNLXEHJ5zsktVJYPtTpr2dRBuWx9Q9voARhU69AKVX7Hp
 UxWo38Z0on7IOVY5GH01vCcbEEx8pIwBVeAoUerlp/uh9/Wl0JD62fJJOP3XVGZtb8tf5yCfajR
 GqKWDQADapIZpsWf9/LfNVGzbYgjqiSyEVu6JyhES5dQ92zQ84RiXcFSa
X-Gm-Gg: ASbGncuKMef/J9n1r0LGZgiQMa1l4Jx3NIHrnyAN1gbPBRyZK8Lt/JqteoRD8sc372D
 USD+Zg+G6vs3d7jaehCjczC92N8lRc5jGH2SKNqL0Ehs86FwDfFdiBTB2zOd6R2pLMfOd/D5ivg
 44cxWYx2oHeulH2if8r2jRh6X1jyJdUxr6b0W/GB52Y/pnJGLOO5NTyDKsNp98fhmPu0O8YMXAH
 RMikCjbTVAkryN8UJQAZquqvQ7ASfXe9bg4E/hE0u8VoUEgqFmdNwP+DS08wxcNCjiqA9ZNbO1C
 DD+jibevKlQ2K6A4B5qgncXQqaY3eo0Klxkxglu9qWn4FSNnnjb4l9Y45QtlNwXF48A=
X-Received: by 2002:a5d:64c4:0:b0:429:ccd0:d36c with SMTP id
 ffacd0b85a97d-42b432c93a2mr2030588f8f.14.1762851534702; 
 Tue, 11 Nov 2025 00:58:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHPoM2Xpfp1tVfDmMI81cv2rotGRU+a1rEx4w8wrmZOdSPUOaVGIdoYgjIkJ6PR7XJ6OUPfKQ==
X-Received: by 2002:a5d:64c4:0:b0:429:ccd0:d36c with SMTP id
 ffacd0b85a97d-42b432c93a2mr2030553f8f.14.1762851534084; 
 Tue, 11 Nov 2025 00:58:54 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1536:2700:9203:49b4:a0d:b580])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42ac6794f6esm30199856f8f.41.2025.11.11.00.58.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Nov 2025 00:58:53 -0800 (PST)
Date: Tue, 11 Nov 2025 03:58:51 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Albert Esteve <aesteve@redhat.com>
Cc: qemu-devel@nongnu.org, Stefano Garzarella <sgarzare@redhat.com>,
 qemu-stable@nongnu.org
Subject: Re: [PATCH v4 1/1] vhost-user: fix shared object lookup handler logic
Message-ID: <20251111035843-mutt-send-email-mst@kernel.org>
References: <20251017072011.1874874-1-aesteve@redhat.com>
 <20251017072011.1874874-2-aesteve@redhat.com>
 <20251107082334-mutt-send-email-mst@kernel.org>
 <CADSE00+ZN0-KGj-zHJOsxbEbGeLFaG0WzZdW4joD2ypzbcqOeQ@mail.gmail.com>
 <CADSE00LjbhB5sgjFnph8U8u31Htn=UJ9_Nit+Z2AOBY+eT8qKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADSE00LjbhB5sgjFnph8U8u31Htn=UJ9_Nit+Z2AOBY+eT8qKA@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Tue, Nov 11, 2025 at 09:48:04AM +0100, Albert Esteve wrote:
> On Fri, Nov 7, 2025 at 3:58 PM Albert Esteve <aesteve@redhat.com> wrote:
> >
> > On Fri, Nov 7, 2025 at 2:26 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Fri, Oct 17, 2025 at 09:20:11AM +0200, Albert Esteve wrote:
> > > > Refactor backend_read() function and add a reply_ack variable
> > > > to have the option for handlers to force tweak whether they should
> > > > send a reply or not without depending on VHOST_USER_NEED_REPLY_MASK
> > > > flag.
> > > >
> > > > This fixes an issue with
> > > > vhost_user_backend_handle_shared_object_lookup() logic, as the
> > > > error path was not closing the backend channel correctly. So,
> > > > we can remove the reply call from within the handler, make
> > > > sure it returns early on errors as other handlers do and
> > > > set the reply_ack variable on backend_read() to true to ensure
> > > > that it will send a response, thus keeping the original intent.
> > > >
> > > > Fixes: 160947666276c5b7f6bca4d746bcac2966635d79
> > >
> > >
> > > I fixed this, should include the subject.
> > >
> > > > Cc: qemu-stable@nongnu.org
> > > > Signed-off-by: Albert Esteve <aesteve@redhat.com>
> > >
> > >
> > > So I picked this for now, but I worry that we are opening ourselves
> > > up to buggy backends which forget to set the flag and expect
> > > frontend to behave properly.
> > >
> > > I think a better fix would be instead of forcing, check reply_ack,
> > > and fail if not set correctly.
> >
> > Fair point. I will send a follow-up PATCH with this check and fail early.
> 
> So I was going to do this follow-up patch but then reading the spec in
> vhost-user.rst I saw:
> ```For the message types that already solicit a reply from the back-end,
> the presence of ``VHOST_USER_PROTOCOL_F_REPLY_ACK`` or need_reply bit
> being set brings no behavioural change.```
> 
> Since this message type (SHARED_OBJECT_LOOKUP) explicitly solicit a
> reply, I understand that the correct behaviour is what we did in this
> patch: forcing it to true.

ok


> >
> > >
> > > > ---
> > > >  hw/virtio/vhost-user.c | 42 +++++++++++++++---------------------------
> > > >  1 file changed, 15 insertions(+), 27 deletions(-)
> > > >
> > > > diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> > > > index 890be55937..762d7218d3 100644
> > > > --- a/hw/virtio/vhost-user.c
> > > > +++ b/hw/virtio/vhost-user.c
> > > > @@ -1696,14 +1696,6 @@ static bool vhost_user_send_resp(QIOChannel *ioc, VhostUserHeader *hdr,
> > > >      return !qio_channel_writev_all(ioc, iov, ARRAY_SIZE(iov), errp);
> > > >  }
> > > >
> > > > -static bool
> > > > -vhost_user_backend_send_dmabuf_fd(QIOChannel *ioc, VhostUserHeader *hdr,
> > > > -                                  VhostUserPayload *payload, Error **errp)
> > > > -{
> > > > -    hdr->size = sizeof(payload->u64);
> > > > -    return vhost_user_send_resp(ioc, hdr, payload, errp);
> > > > -}
> > > > -
> > > >  int vhost_user_get_shared_object(struct vhost_dev *dev, unsigned char *uuid,
> > > >                                   int *dmabuf_fd)
> > > >  {
> > > > @@ -1744,19 +1736,15 @@ int vhost_user_get_shared_object(struct vhost_dev *dev, unsigned char *uuid,
> > > >
> > > >  static int
> > > >  vhost_user_backend_handle_shared_object_lookup(struct vhost_user *u,
> > > > -                                               QIOChannel *ioc,
> > > > -                                               VhostUserHeader *hdr,
> > > > -                                               VhostUserPayload *payload)
> > > > +                                               VhostUserShared *object)
> > > >  {
> > > >      QemuUUID uuid;
> > > >      CharBackend *chr = u->user->chr;
> > > > -    Error *local_err = NULL;
> > > >      int dmabuf_fd = -1;
> > > >      int fd_num = 0;
> > > >
> > > > -    memcpy(uuid.data, payload->object.uuid, sizeof(payload->object.uuid));
> > > > +    memcpy(uuid.data, object->uuid, sizeof(object->uuid));
> > > >
> > > > -    payload->u64 = 0;
> > > >      switch (virtio_object_type(&uuid)) {
> > > >      case TYPE_DMABUF:
> > > >          dmabuf_fd = virtio_lookup_dmabuf(&uuid);
> > > > @@ -1765,18 +1753,16 @@ vhost_user_backend_handle_shared_object_lookup(struct vhost_user *u,
> > > >      {
> > > >          struct vhost_dev *dev = virtio_lookup_vhost_device(&uuid);
> > > >          if (dev == NULL) {
> > > > -            payload->u64 = -EINVAL;
> > > > -            break;
> > > > +            return -EINVAL;
> > > >          }
> > > >          int ret = vhost_user_get_shared_object(dev, uuid.data, &dmabuf_fd);
> > > >          if (ret < 0) {
> > > > -            payload->u64 = ret;
> > > > +            return ret;
> > > >          }
> > > >          break;
> > > >      }
> > > >      case TYPE_INVALID:
> > > > -        payload->u64 = -EINVAL;
> > > > -        break;
> > > > +        return -EINVAL;
> > > >      }
> > > >
> > > >      if (dmabuf_fd != -1) {
> > > > @@ -1785,11 +1771,6 @@ vhost_user_backend_handle_shared_object_lookup(struct vhost_user *u,
> > > >
> > > >      if (qemu_chr_fe_set_msgfds(chr, &dmabuf_fd, fd_num) < 0) {
> > > >          error_report("Failed to set msg fds.");
> > > > -        payload->u64 = -EINVAL;
> > > > -    }
> > > > -
> > > > -    if (!vhost_user_backend_send_dmabuf_fd(ioc, hdr, payload, &local_err)) {
> > > > -        error_report_err(local_err);
> > > >          return -EINVAL;
> > > >      }
> > > >
> > > > @@ -2008,6 +1989,7 @@ static gboolean backend_read(QIOChannel *ioc, GIOCondition condition,
> > > >      struct iovec iov;
> > > >      g_autofree int *fd = NULL;
> > > >      size_t fdsize = 0;
> > > > +    bool reply_ack;
> > > >      int i;
> > > >
> > > >      /* Read header */
> > > > @@ -2026,6 +2008,8 @@ static gboolean backend_read(QIOChannel *ioc, GIOCondition condition,
> > > >          goto err;
> > > >      }
> > > >
> > > > +    reply_ack = hdr.flags & VHOST_USER_NEED_REPLY_MASK;
> > > > +
> > > >      /* Read payload */
> > > >      if (qio_channel_read_all(ioc, (char *) &payload, hdr.size, &local_err)) {
> > > >          error_report_err(local_err);
> > > > @@ -2051,11 +2035,14 @@ static gboolean backend_read(QIOChannel *ioc, GIOCondition condition,
> > > >                                                               &payload.object);
> > > >          break;
> > > >      case VHOST_USER_BACKEND_SHARED_OBJECT_LOOKUP:
> > > > -        ret = vhost_user_backend_handle_shared_object_lookup(dev->opaque, ioc,
> > > > -                                                             &hdr, &payload);
> > > > +        /* The backend always expects a response */
> > > > +        reply_ack = true;
> > > > +        ret = vhost_user_backend_handle_shared_object_lookup(dev->opaque,
> > > > +                                                             &payload.object);
> > > >          break;
> > > >      case VHOST_USER_BACKEND_SHMEM_MAP:
> > > >          /* Handler manages its own response, check error and close connection */
> > > > +        reply_ack = false;
> > > >          if (vhost_user_backend_handle_shmem_map(dev, ioc, &hdr, &payload,
> > > >                                                  fd ? fd[0] : -1) < 0) {
> > > >              goto err;
> > > > @@ -2063,6 +2050,7 @@ static gboolean backend_read(QIOChannel *ioc, GIOCondition condition,
> > > >          break;
> > > >      case VHOST_USER_BACKEND_SHMEM_UNMAP:
> > > >          /* Handler manages its own response, check error and close connection */
> > > > +        reply_ack = false;
> > > >          if (vhost_user_backend_handle_shmem_unmap(dev, ioc, &hdr, &payload) < 0) {
> > > >              goto err;
> > > >          }
> > > > @@ -2076,7 +2064,7 @@ static gboolean backend_read(QIOChannel *ioc, GIOCondition condition,
> > > >       * REPLY_ACK feature handling. Other reply types has to be managed
> > > >       * directly in their request handlers.
> > > >       */
> > > > -    if (hdr.flags & VHOST_USER_NEED_REPLY_MASK) {
> > > > +    if (reply_ack) {
> > > >          payload.u64 = !!ret;
> > > >          hdr.size = sizeof(payload.u64);
> > > >
> > > > --
> > > > 2.49.0
> > >


