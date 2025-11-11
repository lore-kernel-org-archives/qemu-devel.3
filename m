Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C063CCFA18
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 08:48:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIk3O-00061K-ES; Tue, 11 Nov 2025 03:48:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1vIk35-0005wX-V5
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 03:48:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1vIk32-00010K-FJ
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 03:48:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762850899;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OGx3yG3LLQrvMDyXFsK0mIu5DepnAPUW9HsTyRRzhp4=;
 b=au2otduS8i0h1IVjIbJAYJA70LPFrunc+LIwS43g4tTHZd0EzViRoNxcX6P8igE8eORuXZ
 VvkOFMmKg0IQJL6MpIOqz6qqUCqCDfd4FRRm48QHHg+vCXTdYaDsO9I89m35KtDsFWmytR
 klgvz/2r4DY/btaxJgC837go10a5X40=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-361-3wL0rO6-OE20g6WnFtkRQQ-1; Tue, 11 Nov 2025 03:48:17 -0500
X-MC-Unique: 3wL0rO6-OE20g6WnFtkRQQ-1
X-Mimecast-MFC-AGG-ID: 3wL0rO6-OE20g6WnFtkRQQ_1762850897
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-297b35951b7so65771415ad.3
 for <qemu-devel@nongnu.org>; Tue, 11 Nov 2025 00:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762850896; x=1763455696; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OGx3yG3LLQrvMDyXFsK0mIu5DepnAPUW9HsTyRRzhp4=;
 b=sj8Ub1ZCsVe6hDWINx9n6//VdG7VKo0JA6cjnWjjbc6Lrdubrxpn/ChWx2rTgY/iwM
 UkySZ8Lb6f54R9js4svbfbJYYhr+yrcXufySbCyMaQJvanSdAOh5f1pDNJpMpY6BN0FJ
 Jb/8xhBFnr1wx6ZZcpS3gul3tdMqKsCN/Otg+F3O3BpYBvolG8TSOsU7hx/7YhUKEBsa
 hWupHodZ1ZyIME8FL2t5IRTUiK7KKDMQgWFLFWM4Heopd9WQWh+5SLHXbaqscnzSUmyE
 KWcHYIHzumHS5SXBhYw7aASj4K6vy+FPJWIttpFxFmsWHStK6dhduga2B0JEbfFGwXEq
 pFTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762850896; x=1763455696;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OGx3yG3LLQrvMDyXFsK0mIu5DepnAPUW9HsTyRRzhp4=;
 b=je6dLfWuNyRmq4N1S7g6/ykgcG2MZNhaBS4mK68jfVciDpI3gxF3SGV/8WJeogPxGU
 CdF91RlQREB9vkd5XMKXZsZKNmkJVK9FDnByDzq2KaUibf4ywN68laKFOaIAqUTMY3Cj
 O7Zps+nyf0BpwoVfHaeegoTgojilPn1JcP/c+oTaGUR4r4KFlqbPzuAD8FDV8fOaWMs9
 13jIrzsuqviBAvkffegVoabn6omOvmeQa0ep0CCvDGJzo+/ei/0YAPOb2YfRLampSl++
 3GeBs+WYANDvdkw3uGKq+IHBiG6LGvosE+J2qj3DtPWlxQ+p/G3RijTdbTI36mqTXV9u
 LB9g==
X-Gm-Message-State: AOJu0YxA28HqTA3FcVYTb2oYD+Ah5akD+Jm0IBXcyhtUjxqVjXatj8n4
 a5rS6o2HVVR22KrSdcstmfy4iRrPP80oDlMXIOr4YcgBDo3pS5sDzIokNGY4l/tbTdL9tK9Q6Pa
 RYwFxa06PjrlxappnSQN4kBE6TgjUfMiGUazYGQYaZvsge29sgzFswadJtJ8sY8zMS6f1Q+NyW2
 5Q1DOnCG7oqW/gFiNsrWyXE9x2ic6BTQQ=
X-Gm-Gg: ASbGncsV4iASBz2TmmoI2FQ+L7KgJx2WqickpZLLZgJT8c/dIfFww7cB4qL1Ct4b7+2
 UYNyUmpI4AnMHy8SdnXnsx3dzy+8updrV8x81ZhHcLmh4JLHHE6Wi/xNsgsvg4+uNo2QwgZhSdy
 /jbneah/8hQWX8SP46VQ4dVkoHDrskyxWxxKduPgAqScIuN8YxhCc=
X-Received: by 2002:a17:902:744c:b0:296:3f23:b909 with SMTP id
 d9443c01a7336-297e56c9e07mr115990245ad.39.1762850896543; 
 Tue, 11 Nov 2025 00:48:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFF3KJBPC6xHbv4hlZX0Co6eH+X1EVJ44uis2uozh6xY8U3XqkdZVEWxJeMrVzsBYfWL3GSS6cxEu2pFjsXS8o=
X-Received: by 2002:a17:902:744c:b0:296:3f23:b909 with SMTP id
 d9443c01a7336-297e56c9e07mr115990045ad.39.1762850896053; Tue, 11 Nov 2025
 00:48:16 -0800 (PST)
MIME-Version: 1.0
References: <20251017072011.1874874-1-aesteve@redhat.com>
 <20251017072011.1874874-2-aesteve@redhat.com>
 <20251107082334-mutt-send-email-mst@kernel.org>
 <CADSE00+ZN0-KGj-zHJOsxbEbGeLFaG0WzZdW4joD2ypzbcqOeQ@mail.gmail.com>
In-Reply-To: <CADSE00+ZN0-KGj-zHJOsxbEbGeLFaG0WzZdW4joD2ypzbcqOeQ@mail.gmail.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Tue, 11 Nov 2025 09:48:04 +0100
X-Gm-Features: AWmQ_bng2YyPYYTHYkZdO7-Yw0qq6g_KANMmNTC6Y42gr8GDsNn9XD_2LJ2AgUM
Message-ID: <CADSE00LjbhB5sgjFnph8U8u31Htn=UJ9_Nit+Z2AOBY+eT8qKA@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] vhost-user: fix shared object lookup handler logic
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Stefano Garzarella <sgarzare@redhat.com>,
 qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aesteve@redhat.com;
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

On Fri, Nov 7, 2025 at 3:58=E2=80=AFPM Albert Esteve <aesteve@redhat.com> w=
rote:
>
> On Fri, Nov 7, 2025 at 2:26=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com=
> wrote:
> >
> > On Fri, Oct 17, 2025 at 09:20:11AM +0200, Albert Esteve wrote:
> > > Refactor backend_read() function and add a reply_ack variable
> > > to have the option for handlers to force tweak whether they should
> > > send a reply or not without depending on VHOST_USER_NEED_REPLY_MASK
> > > flag.
> > >
> > > This fixes an issue with
> > > vhost_user_backend_handle_shared_object_lookup() logic, as the
> > > error path was not closing the backend channel correctly. So,
> > > we can remove the reply call from within the handler, make
> > > sure it returns early on errors as other handlers do and
> > > set the reply_ack variable on backend_read() to true to ensure
> > > that it will send a response, thus keeping the original intent.
> > >
> > > Fixes: 160947666276c5b7f6bca4d746bcac2966635d79
> >
> >
> > I fixed this, should include the subject.
> >
> > > Cc: qemu-stable@nongnu.org
> > > Signed-off-by: Albert Esteve <aesteve@redhat.com>
> >
> >
> > So I picked this for now, but I worry that we are opening ourselves
> > up to buggy backends which forget to set the flag and expect
> > frontend to behave properly.
> >
> > I think a better fix would be instead of forcing, check reply_ack,
> > and fail if not set correctly.
>
> Fair point. I will send a follow-up PATCH with this check and fail early.

So I was going to do this follow-up patch but then reading the spec in
vhost-user.rst I saw:
```For the message types that already solicit a reply from the back-end,
the presence of ``VHOST_USER_PROTOCOL_F_REPLY_ACK`` or need_reply bit
being set brings no behavioural change.```

Since this message type (SHARED_OBJECT_LOOKUP) explicitly solicit a
reply, I understand that the correct behaviour is what we did in this
patch: forcing it to true.

>
> >
> > > ---
> > >  hw/virtio/vhost-user.c | 42 +++++++++++++++-------------------------=
--
> > >  1 file changed, 15 insertions(+), 27 deletions(-)
> > >
> > > diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> > > index 890be55937..762d7218d3 100644
> > > --- a/hw/virtio/vhost-user.c
> > > +++ b/hw/virtio/vhost-user.c
> > > @@ -1696,14 +1696,6 @@ static bool vhost_user_send_resp(QIOChannel *i=
oc, VhostUserHeader *hdr,
> > >      return !qio_channel_writev_all(ioc, iov, ARRAY_SIZE(iov), errp);
> > >  }
> > >
> > > -static bool
> > > -vhost_user_backend_send_dmabuf_fd(QIOChannel *ioc, VhostUserHeader *=
hdr,
> > > -                                  VhostUserPayload *payload, Error *=
*errp)
> > > -{
> > > -    hdr->size =3D sizeof(payload->u64);
> > > -    return vhost_user_send_resp(ioc, hdr, payload, errp);
> > > -}
> > > -
> > >  int vhost_user_get_shared_object(struct vhost_dev *dev, unsigned cha=
r *uuid,
> > >                                   int *dmabuf_fd)
> > >  {
> > > @@ -1744,19 +1736,15 @@ int vhost_user_get_shared_object(struct vhost=
_dev *dev, unsigned char *uuid,
> > >
> > >  static int
> > >  vhost_user_backend_handle_shared_object_lookup(struct vhost_user *u,
> > > -                                               QIOChannel *ioc,
> > > -                                               VhostUserHeader *hdr,
> > > -                                               VhostUserPayload *pay=
load)
> > > +                                               VhostUserShared *obje=
ct)
> > >  {
> > >      QemuUUID uuid;
> > >      CharBackend *chr =3D u->user->chr;
> > > -    Error *local_err =3D NULL;
> > >      int dmabuf_fd =3D -1;
> > >      int fd_num =3D 0;
> > >
> > > -    memcpy(uuid.data, payload->object.uuid, sizeof(payload->object.u=
uid));
> > > +    memcpy(uuid.data, object->uuid, sizeof(object->uuid));
> > >
> > > -    payload->u64 =3D 0;
> > >      switch (virtio_object_type(&uuid)) {
> > >      case TYPE_DMABUF:
> > >          dmabuf_fd =3D virtio_lookup_dmabuf(&uuid);
> > > @@ -1765,18 +1753,16 @@ vhost_user_backend_handle_shared_object_looku=
p(struct vhost_user *u,
> > >      {
> > >          struct vhost_dev *dev =3D virtio_lookup_vhost_device(&uuid);
> > >          if (dev =3D=3D NULL) {
> > > -            payload->u64 =3D -EINVAL;
> > > -            break;
> > > +            return -EINVAL;
> > >          }
> > >          int ret =3D vhost_user_get_shared_object(dev, uuid.data, &dm=
abuf_fd);
> > >          if (ret < 0) {
> > > -            payload->u64 =3D ret;
> > > +            return ret;
> > >          }
> > >          break;
> > >      }
> > >      case TYPE_INVALID:
> > > -        payload->u64 =3D -EINVAL;
> > > -        break;
> > > +        return -EINVAL;
> > >      }
> > >
> > >      if (dmabuf_fd !=3D -1) {
> > > @@ -1785,11 +1771,6 @@ vhost_user_backend_handle_shared_object_lookup=
(struct vhost_user *u,
> > >
> > >      if (qemu_chr_fe_set_msgfds(chr, &dmabuf_fd, fd_num) < 0) {
> > >          error_report("Failed to set msg fds.");
> > > -        payload->u64 =3D -EINVAL;
> > > -    }
> > > -
> > > -    if (!vhost_user_backend_send_dmabuf_fd(ioc, hdr, payload, &local=
_err)) {
> > > -        error_report_err(local_err);
> > >          return -EINVAL;
> > >      }
> > >
> > > @@ -2008,6 +1989,7 @@ static gboolean backend_read(QIOChannel *ioc, G=
IOCondition condition,
> > >      struct iovec iov;
> > >      g_autofree int *fd =3D NULL;
> > >      size_t fdsize =3D 0;
> > > +    bool reply_ack;
> > >      int i;
> > >
> > >      /* Read header */
> > > @@ -2026,6 +2008,8 @@ static gboolean backend_read(QIOChannel *ioc, G=
IOCondition condition,
> > >          goto err;
> > >      }
> > >
> > > +    reply_ack =3D hdr.flags & VHOST_USER_NEED_REPLY_MASK;
> > > +
> > >      /* Read payload */
> > >      if (qio_channel_read_all(ioc, (char *) &payload, hdr.size, &loca=
l_err)) {
> > >          error_report_err(local_err);
> > > @@ -2051,11 +2035,14 @@ static gboolean backend_read(QIOChannel *ioc,=
 GIOCondition condition,
> > >                                                               &payloa=
d.object);
> > >          break;
> > >      case VHOST_USER_BACKEND_SHARED_OBJECT_LOOKUP:
> > > -        ret =3D vhost_user_backend_handle_shared_object_lookup(dev->=
opaque, ioc,
> > > -                                                             &hdr, &=
payload);
> > > +        /* The backend always expects a response */
> > > +        reply_ack =3D true;
> > > +        ret =3D vhost_user_backend_handle_shared_object_lookup(dev->=
opaque,
> > > +                                                             &payloa=
d.object);
> > >          break;
> > >      case VHOST_USER_BACKEND_SHMEM_MAP:
> > >          /* Handler manages its own response, check error and close c=
onnection */
> > > +        reply_ack =3D false;
> > >          if (vhost_user_backend_handle_shmem_map(dev, ioc, &hdr, &pay=
load,
> > >                                                  fd ? fd[0] : -1) < 0=
) {
> > >              goto err;
> > > @@ -2063,6 +2050,7 @@ static gboolean backend_read(QIOChannel *ioc, G=
IOCondition condition,
> > >          break;
> > >      case VHOST_USER_BACKEND_SHMEM_UNMAP:
> > >          /* Handler manages its own response, check error and close c=
onnection */
> > > +        reply_ack =3D false;
> > >          if (vhost_user_backend_handle_shmem_unmap(dev, ioc, &hdr, &p=
ayload) < 0) {
> > >              goto err;
> > >          }
> > > @@ -2076,7 +2064,7 @@ static gboolean backend_read(QIOChannel *ioc, G=
IOCondition condition,
> > >       * REPLY_ACK feature handling. Other reply types has to be manag=
ed
> > >       * directly in their request handlers.
> > >       */
> > > -    if (hdr.flags & VHOST_USER_NEED_REPLY_MASK) {
> > > +    if (reply_ack) {
> > >          payload.u64 =3D !!ret;
> > >          hdr.size =3D sizeof(payload.u64);
> > >
> > > --
> > > 2.49.0
> >


