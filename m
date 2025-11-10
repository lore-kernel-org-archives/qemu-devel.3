Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16B88CCF9E3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 19:14:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIXKr-0004qA-8h; Mon, 10 Nov 2025 14:13:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1vIX2h-0001YI-UC
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 13:55:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1vIX2c-0002wP-UC
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 13:55:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762800902;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uxvlh7JJGdeVJPqrfMtJjGSPK5ScCrWVZ19Asjc7xV8=;
 b=btJa9CAnDk+flBimr5VqeOXLXOzr7dAghcoR4LtIY66ing5ncdvpGEeL3OXJAViqFNfVYT
 IcNovUYqUQ6eAzKoRgoXS4nXNl6DnAbmlVNBvnWOXlGzcK2V9yHl7ugoVU/bZm86+w84on
 RCFn1d6N3HNqFwL+FHkkgkeyjJRJ0c4=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-XFSCXwb1PWC9sBikXQY87w-1; Mon, 10 Nov 2025 13:54:56 -0500
X-MC-Unique: XFSCXwb1PWC9sBikXQY87w-1
X-Mimecast-MFC-AGG-ID: XFSCXwb1PWC9sBikXQY87w_1762800895
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-295595cd102so82155845ad.3
 for <qemu-devel@nongnu.org>; Mon, 10 Nov 2025 10:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762800895; x=1763405695; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uxvlh7JJGdeVJPqrfMtJjGSPK5ScCrWVZ19Asjc7xV8=;
 b=nXsvblq9q4fXXGObRV7PFS3QDAhZAzZ6f57wtPGprDDinm/qCAD4cm8JFshkYv6FMR
 be6Peg1WKQFmtwyQvxosZ5s6oL4UDqq9jyNt9t+uwerb8ztjxNXVE7MGLg3bLXLWjvnH
 tFCgmn+G7z3lxFF7YE35yBsFUm54ZCNUMRZ8h4GAvDZgAuVy1lEU2vn8DYkDhZ0X+ynI
 p0LIMxvp3fS8z/WW7qi/8ASrsYZZQ3GbjXBZjLGOprWzOmj5g3uz25Egp+vw2yVmVI4V
 YKTIq1anB5XZClhu5Ocr2dd8hjhu4xDXVt53/wGLidnHFoZRnTBh7WAOgkIZqAwdGFDT
 lgcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762800895; x=1763405695;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uxvlh7JJGdeVJPqrfMtJjGSPK5ScCrWVZ19Asjc7xV8=;
 b=sqyIi3mY7Uk0OC3Pw2hpAR3AG8im5qUqesctUlUSZ3fTkTx4xfI51lELwYkCFtgqV4
 TAKufSFac3qpbTGC27cI+F5qMGwYdaZR1Xui+sR24JOLRybqXnkpOi14vpnhadDgD6ic
 PDisbVkw0B8r++J+deR1X9MCZGEHzhW2i1Hesu57C1/Lz3+aS5kHKHOfwJuzVX8wQgWU
 ObnsES/XPYi+VzwgcD5/YTKuA57ojx1UDzrc/ODsaZWfi20b9Bs+mRMGMsufCATbiJ0E
 mtpe5kdNEvTgvgHVVX4ne3KmpPHNplvkzvoq6rcge2sMBrRVA+G8332R9eKYKcDUSvOu
 xKUg==
X-Gm-Message-State: AOJu0YxSCLPtKyrGsl3cWa5hYjCj3QwlV4RK3anNFYB5LPWQe5vQ8h/E
 FKOG1i7BlXmgmTeSevpibWpCeSFqtNI+CWy5B/rNNXHZZqV79KaOS7Yw2UZL+H3gfKfvNvJX+rt
 kZdkJLEF+2nMzobixbHGfkMm/jDvz2zCBV5lhAldbpD+A8YNqoDCQBnMehdaGCTzbn/IApKTfvo
 6d3FTEwAbpqkAnCFVbvBBnWam9P3pm+70=
X-Gm-Gg: ASbGncvPDjJ7dKiwBFnQ1zov4FgogZ+0rIFwzWWBiOr/DgC3hY2ANKdclsGqWN0bJAM
 XC0j6yjZa46MVeP/WR/pxPFy8rDk3pS1xep7PjHaA8jfF6UMOynPfP/vdGIfI1766jDkTuT0VLt
 abrCC3AHKiKwdpm5Y7Upo3YSnFYx2d7qnDLDf6mWb7JS1gFdJvP4s=
X-Received: by 2002:a17:903:1a2e:b0:297:e1e1:beb1 with SMTP id
 d9443c01a7336-297e5611fc8mr126640605ad.16.1762800894762; 
 Mon, 10 Nov 2025 10:54:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGpGSwrSaR6b96mxlqfwk1IQ3piJwpdWa9wjT1zCFgpp9nrCcv2mH7e1VYm3/C1HJlFZgwH2FrWaI4LIVKUVnA=
X-Received: by 2002:a17:903:1a2e:b0:297:e1e1:beb1 with SMTP id
 d9443c01a7336-297e5611fc8mr126640395ad.16.1762800894350; Mon, 10 Nov 2025
 10:54:54 -0800 (PST)
MIME-Version: 1.0
References: <cover.1762698873.git.mst@redhat.com>
 <fde5930cc37175cfcd0f03a089e26f4458a52311.1762698873.git.mst@redhat.com>
 <CADSE00+FLWVdh1CGmy6i4hLdJOKGG6-4JZySXL=wFOyyTnnFpw@mail.gmail.com>
 <20251110104059-mutt-send-email-mst@kernel.org>
 <CADSE00+8_pyV_qUGJ9WiP3miHPvpiOLsHGeCF1cs=7Y3OuajnA@mail.gmail.com>
 <20251110110546-mutt-send-email-mst@kernel.org>
In-Reply-To: <20251110110546-mutt-send-email-mst@kernel.org>
From: Albert Esteve <aesteve@redhat.com>
Date: Mon, 10 Nov 2025 19:54:43 +0100
X-Gm-Features: AWmQ_bkQnh4cDetGfkDWL59NVrCmv2cu__gUtPzjHpYISyRvfei7bh2ZUfGB4Ec
Message-ID: <CADSE00K3uKoOGZ5i21fh5M64ZgFcRTm4GSizyQ0K0iN67dpccA@mail.gmail.com>
Subject: Re: [PULL 04/14] vhost-user: fix shared object lookup handler logic
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 qemu-stable@nongnu.org, Stefano Garzarella <sgarzare@redhat.com>
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

On Mon, Nov 10, 2025 at 5:06=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Mon, Nov 10, 2025 at 04:57:51PM +0100, Albert Esteve wrote:
> > On Mon, Nov 10, 2025 at 4:42=E2=80=AFPM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > >
> > > On Mon, Nov 10, 2025 at 10:23:25AM +0100, Albert Esteve wrote:
> > > > On Sun, Nov 9, 2025 at 3:35=E2=80=AFPM Michael S. Tsirkin <mst@redh=
at.com> wrote:
> > > > >
> > > > > From: Albert Esteve <aesteve@redhat.com>
> > > > >
> > > > > Refactor backend_read() function and add a reply_ack variable
> > > > > to have the option for handlers to force tweak whether they shoul=
d
> > > > > send a reply or not without depending on VHOST_USER_NEED_REPLY_MA=
SK
> > > > > flag.
> > > > >
> > > > > This fixes an issue with
> > > > > vhost_user_backend_handle_shared_object_lookup() logic, as the
> > > > > error path was not closing the backend channel correctly. So,
> > > > > we can remove the reply call from within the handler, make
> > > > > sure it returns early on errors as other handlers do and
> > > > > set the reply_ack variable on backend_read() to true to ensure
> > > > > that it will send a response, thus keeping the original intent.
> > > >
> > > > Hey Michal,
> > > >
> > > > This patch was
> > > > Based-on: <20251016143827.1850397-1-aesteve@redhat.com>
> > > > =E2=80=A6 for main.
> > >
> > > That's the SHMEM thing right?  Yes but I rebased it dropping
> > > the SHMEM dependency.
> > >
> > > At least, I think I did it correctly.
> >
> > Yes, removing the dependency is correctly applied. But that was only
> > required for the backport to stable.
> >
> > If we merge this patch to main without the one it is based on, then
> > I'd need to send a new version of the SHMEM patch with the block that
> > you have dropped. I can do it, but I was trying to prioritize the
> > other one, as it was a lot harder to get approved. That is why I based
> > this patch on top of the SHMEM one and not the other way around.
> >
> > Sorry if that was not clear from the message.
>
>
> Right but I can't apply SHMEM patch in freeze so yes, it has to go
> on top. Sorry it's like this.

Got it. Then it'll have to be the other way around. Thanks for
handling the rebase, then. I'll send the new version of the SHMEM
patch after this one lands.

>
> > >
> > > > As this was the first time I did this based-on thingy, I am just
> > > > making sure that the other patch was not missed.
> > > > If this PULL is only targeting stable, then it's ok as is.
> > >
> > > It is targeting 10.2 which is in freeze. So equivalently same.
> > >
> > >
> > > > BR,
> > > > Albert
> > > >
> > > > >
> > > > > Fixes: 1609476662 ("vhost-user: add shared_object msg")
> > > > > Cc: qemu-stable@nongnu.org
> > > > > Signed-off-by: Albert Esteve <aesteve@redhat.com>
> > > > > Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> > > > > Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> > > > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > > > Message-Id: <20251017072011.1874874-2-aesteve@redhat.com>
> > > > > ---
> > > > >  hw/virtio/vhost-user.c | 40 +++++++++++++-----------------------=
----
> > > > >  1 file changed, 13 insertions(+), 27 deletions(-)
> > > > >
> > > > > diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> > > > > index aac98f898a..4b0fae12ae 100644
> > > > > --- a/hw/virtio/vhost-user.c
> > > > > +++ b/hw/virtio/vhost-user.c
> > > > > @@ -1668,14 +1668,6 @@ static bool vhost_user_send_resp(QIOChanne=
l *ioc, VhostUserHeader *hdr,
> > > > >      return !qio_channel_writev_all(ioc, iov, ARRAY_SIZE(iov), er=
rp);
> > > > >  }
> > > > >
> > > > > -static bool
> > > > > -vhost_user_backend_send_dmabuf_fd(QIOChannel *ioc, VhostUserHead=
er *hdr,
> > > > > -                                  VhostUserPayload *payload, Err=
or **errp)
> > > > > -{
> > > > > -    hdr->size =3D sizeof(payload->u64);
> > > > > -    return vhost_user_send_resp(ioc, hdr, payload, errp);
> > > > > -}
> > > > > -
> > > > >  int vhost_user_get_shared_object(struct vhost_dev *dev, unsigned=
 char *uuid,
> > > > >                                   int *dmabuf_fd)
> > > > >  {
> > > > > @@ -1716,19 +1708,15 @@ int vhost_user_get_shared_object(struct v=
host_dev *dev, unsigned char *uuid,
> > > > >
> > > > >  static int
> > > > >  vhost_user_backend_handle_shared_object_lookup(struct vhost_user=
 *u,
> > > > > -                                               QIOChannel *ioc,
> > > > > -                                               VhostUserHeader *=
hdr,
> > > > > -                                               VhostUserPayload =
*payload)
> > > > > +                                               VhostUserShared *=
object)
> > > > >  {
> > > > >      QemuUUID uuid;
> > > > >      CharFrontend *chr =3D u->user->chr;
> > > > > -    Error *local_err =3D NULL;
> > > > >      int dmabuf_fd =3D -1;
> > > > >      int fd_num =3D 0;
> > > > >
> > > > > -    memcpy(uuid.data, payload->object.uuid, sizeof(payload->obje=
ct.uuid));
> > > > > +    memcpy(uuid.data, object->uuid, sizeof(object->uuid));
> > > > >
> > > > > -    payload->u64 =3D 0;
> > > > >      switch (virtio_object_type(&uuid)) {
> > > > >      case TYPE_DMABUF:
> > > > >          dmabuf_fd =3D virtio_lookup_dmabuf(&uuid);
> > > > > @@ -1737,18 +1725,16 @@ vhost_user_backend_handle_shared_object_l=
ookup(struct vhost_user *u,
> > > > >      {
> > > > >          struct vhost_dev *dev =3D virtio_lookup_vhost_device(&uu=
id);
> > > > >          if (dev =3D=3D NULL) {
> > > > > -            payload->u64 =3D -EINVAL;
> > > > > -            break;
> > > > > +            return -EINVAL;
> > > > >          }
> > > > >          int ret =3D vhost_user_get_shared_object(dev, uuid.data,=
 &dmabuf_fd);
> > > > >          if (ret < 0) {
> > > > > -            payload->u64 =3D ret;
> > > > > +            return ret;
> > > > >          }
> > > > >          break;
> > > > >      }
> > > > >      case TYPE_INVALID:
> > > > > -        payload->u64 =3D -EINVAL;
> > > > > -        break;
> > > > > +        return -EINVAL;
> > > > >      }
> > > > >
> > > > >      if (dmabuf_fd !=3D -1) {
> > > > > @@ -1757,11 +1743,6 @@ vhost_user_backend_handle_shared_object_lo=
okup(struct vhost_user *u,
> > > > >
> > > > >      if (qemu_chr_fe_set_msgfds(chr, &dmabuf_fd, fd_num) < 0) {
> > > > >          error_report("Failed to set msg fds.");
> > > > > -        payload->u64 =3D -EINVAL;
> > > > > -    }
> > > > > -
> > > > > -    if (!vhost_user_backend_send_dmabuf_fd(ioc, hdr, payload, &l=
ocal_err)) {
> > > > > -        error_report_err(local_err);
> > > > >          return -EINVAL;
> > > > >      }
> > > > >
> > > > > @@ -1790,6 +1771,7 @@ static gboolean backend_read(QIOChannel *io=
c, GIOCondition condition,
> > > > >      struct iovec iov;
> > > > >      g_autofree int *fd =3D NULL;
> > > > >      size_t fdsize =3D 0;
> > > > > +    bool reply_ack;
> > > > >      int i;
> > > > >
> > > > >      /* Read header */
> > > > > @@ -1808,6 +1790,8 @@ static gboolean backend_read(QIOChannel *io=
c, GIOCondition condition,
> > > > >          goto err;
> > > > >      }
> > > > >
> > > > > +    reply_ack =3D hdr.flags & VHOST_USER_NEED_REPLY_MASK;
> > > > > +
> > > > >      /* Read payload */
> > > > >      if (qio_channel_read_all(ioc, (char *) &payload, hdr.size, &=
local_err)) {
> > > > >          error_report_err(local_err);
> > > > > @@ -1833,8 +1817,10 @@ static gboolean backend_read(QIOChannel *i=
oc, GIOCondition condition,
> > > > >                                                               &pa=
yload.object);
> > > > >          break;
> > > > >      case VHOST_USER_BACKEND_SHARED_OBJECT_LOOKUP:
> > > > > -        ret =3D vhost_user_backend_handle_shared_object_lookup(d=
ev->opaque, ioc,
> > > > > -                                                             &hd=
r, &payload);
> > > > > +        /* The backend always expects a response */
> > > > > +        reply_ack =3D true;
> > > > > +        ret =3D vhost_user_backend_handle_shared_object_lookup(d=
ev->opaque,
> > > > > +                                                             &pa=
yload.object);
> > > > >          break;
> > > > >      default:
> > > > >          error_report("Received unexpected msg type: %d.", hdr.re=
quest);
> > > > > @@ -1845,7 +1831,7 @@ static gboolean backend_read(QIOChannel *io=
c, GIOCondition condition,
> > > > >       * REPLY_ACK feature handling. Other reply types has to be m=
anaged
> > > > >       * directly in their request handlers.
> > > > >       */
> > > > > -    if (hdr.flags & VHOST_USER_NEED_REPLY_MASK) {
> > > > > +    if (reply_ack) {
> > > > >          payload.u64 =3D !!ret;
> > > > >          hdr.size =3D sizeof(payload.u64);
> > > > >
> > > > > --
> > > > > MST
> > > > >
> > >
>


