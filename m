Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0FE7CCF9E3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 15:58:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIUHS-0003rw-81; Mon, 10 Nov 2025 10:58:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1vIUHQ-0003oD-OK
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 10:58:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1vIUHO-0002l7-Nh
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 10:58:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762790285;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DgTZYleRFSb4NsXaocdHdAj3su1qur320aC1QO4ZJdg=;
 b=FjTnQ06OKK/ESnhELwKS+8XkFsp2qJUPBHbdQYQXeiltklHfsf4P4HyxM7f8xLroRx5qDP
 2tVa6TgV2MuLK9zKQoaUYSSfbCnzisZfxKoTXDf0VWWrE9txq9M8IVnWWFHqXY1NdnL5X+
 Rs3MrTHXKaSxduS/L3UV8gOX5CHo2o4=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-ql1oS-7INZeLyHlNaJ6F2Q-1; Mon, 10 Nov 2025 10:58:04 -0500
X-MC-Unique: ql1oS-7INZeLyHlNaJ6F2Q-1
X-Mimecast-MFC-AGG-ID: ql1oS-7INZeLyHlNaJ6F2Q_1762790284
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-29806c42760so36076965ad.2
 for <qemu-devel@nongnu.org>; Mon, 10 Nov 2025 07:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762790283; x=1763395083; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DgTZYleRFSb4NsXaocdHdAj3su1qur320aC1QO4ZJdg=;
 b=S9b9vKI6oeTIbG0XID8w/OY+v+2zSBL1LZshY+YF8RKIuAkT/QoN33zlyAMafDdQsK
 DQbCHRjlU+I/Ukg2iDDM4aOTDz4zGzhe+hpQRuKT4K91Xjcjo29rQP9n/62lIGwptO7Z
 GGmracPS85aoDI3iujlfwBQ3wcV0T2Tw6ghkZ0P7sSq5IDfTrzx+G91OgVYDi/sronC5
 GRbMXXsRM5NLn3cDaNyRbIZ7RqPZGCrK+POrUDC/IxuYXRXyLeibqSfJD9woFTSwEVvR
 6E2k94KuWDam5shQl4kbKJ8iKMSd2vy94d8EPh9k9KKbxb/ojbLcORIMcsD185K5ZAVt
 DHbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762790283; x=1763395083;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DgTZYleRFSb4NsXaocdHdAj3su1qur320aC1QO4ZJdg=;
 b=MC/M8oRn21zqZ607jmKnTnu90yZJ8XVolGpG9HJ2Xj3434EueA/lEH7F5j2Gu+NPmD
 0/hgCngS+MMUvhaU+9wzXlo4l3ATc+k3VQY+biE8zZOwvCyoeGdPdhB3K1pyDuyfcEGO
 SEATiD5UjrPB50eOovzR40dQ4JfV98cFB4wWn00OcoUAwcxgbv61lKT0J3qQOUwC5cmD
 o8L3hghe/LB1yTitptOwvZYUd4bNuB+slm4NRunHTpQPxJ1iOAsYBebxYAP9MUooFS/+
 bpO0sQ7K8RSOOrWtDKnAV+L0eNIOSuZZxr+zrwQiiKn3+89As1Dgwj5EglJhq9JNWS7k
 xCXQ==
X-Gm-Message-State: AOJu0Yz+eogA4zVLc40Li4PoD2A5KRTVjJOWPFRgjnXgLGOrqvG3Qn7l
 7y7Zqv3s5p4+miF2718hTKlsoJ1YrFfOpeMcBfnUcE/8rDAjhT7tiQBHWCJMquBnvzr3zDC60N0
 iMtsWgs38kX2SRxZmjdaGqdr2nRTi3mlo6HA9YT1pU0axeoubxDeL03QyzEGYXP10EhkuBNzYSE
 j0teM6r7ismdfqBfHODspjv9keO9LK8V4=
X-Gm-Gg: ASbGnct+v1Kof1GH2EB5MgRyi9cRSPgU1iUpz0N7edphs5jG0XvYBFkz7txGJZCyrza
 tdEiZdr5P7zpCf5m+flK3Zz+tOk3n2xNwNIcljyFuzAcbDn/UDxb1WeBAaZoL4enKn2wJf+7ZsH
 PWpYFLHHusXPPjLiigIF0zWqsE+4TJxK4gl7y6kskfzWqtYR/f344=
X-Received: by 2002:a17:903:350d:b0:298:8ec:9991 with SMTP id
 d9443c01a7336-29808ec9a10mr68472985ad.37.1762790283520; 
 Mon, 10 Nov 2025 07:58:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE2jRME7u+h6gyInv105nzQEUhoE/xFtVobrb/Y1H/xIjyQF0ad9kqGQ3haWtfF19gzzf1G5MMriT7nckZ8laU=
X-Received: by 2002:a17:903:350d:b0:298:8ec:9991 with SMTP id
 d9443c01a7336-29808ec9a10mr68472725ad.37.1762790283089; Mon, 10 Nov 2025
 07:58:03 -0800 (PST)
MIME-Version: 1.0
References: <cover.1762698873.git.mst@redhat.com>
 <fde5930cc37175cfcd0f03a089e26f4458a52311.1762698873.git.mst@redhat.com>
 <CADSE00+FLWVdh1CGmy6i4hLdJOKGG6-4JZySXL=wFOyyTnnFpw@mail.gmail.com>
 <20251110104059-mutt-send-email-mst@kernel.org>
In-Reply-To: <20251110104059-mutt-send-email-mst@kernel.org>
From: Albert Esteve <aesteve@redhat.com>
Date: Mon, 10 Nov 2025 16:57:51 +0100
X-Gm-Features: AWmQ_bklUvRt__ouKznmgEc44iLqexVjksgxa82i2ZkOmOZO8mcJ8GrRQfSI_28
Message-ID: <CADSE00+8_pyV_qUGJ9WiP3miHPvpiOLsHGeCF1cs=7Y3OuajnA@mail.gmail.com>
Subject: Re: [PULL 04/14] vhost-user: fix shared object lookup handler logic
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 qemu-stable@nongnu.org, Stefano Garzarella <sgarzare@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=aesteve@redhat.com;
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

On Mon, Nov 10, 2025 at 4:42=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Mon, Nov 10, 2025 at 10:23:25AM +0100, Albert Esteve wrote:
> > On Sun, Nov 9, 2025 at 3:35=E2=80=AFPM Michael S. Tsirkin <mst@redhat.c=
om> wrote:
> > >
> > > From: Albert Esteve <aesteve@redhat.com>
> > >
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
> >
> > Hey Michal,
> >
> > This patch was
> > Based-on: <20251016143827.1850397-1-aesteve@redhat.com>
> > =E2=80=A6 for main.
>
> That's the SHMEM thing right?  Yes but I rebased it dropping
> the SHMEM dependency.
>
> At least, I think I did it correctly.

Yes, removing the dependency is correctly applied. But that was only
required for the backport to stable.

If we merge this patch to main without the one it is based on, then
I'd need to send a new version of the SHMEM patch with the block that
you have dropped. I can do it, but I was trying to prioritize the
other one, as it was a lot harder to get approved. That is why I based
this patch on top of the SHMEM one and not the other way around.

Sorry if that was not clear from the message.

>
> > As this was the first time I did this based-on thingy, I am just
> > making sure that the other patch was not missed.
> > If this PULL is only targeting stable, then it's ok as is.
>
> It is targeting 10.2 which is in freeze. So equivalently same.
>
>
> > BR,
> > Albert
> >
> > >
> > > Fixes: 1609476662 ("vhost-user: add shared_object msg")
> > > Cc: qemu-stable@nongnu.org
> > > Signed-off-by: Albert Esteve <aesteve@redhat.com>
> > > Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> > > Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > Message-Id: <20251017072011.1874874-2-aesteve@redhat.com>
> > > ---
> > >  hw/virtio/vhost-user.c | 40 +++++++++++++---------------------------
> > >  1 file changed, 13 insertions(+), 27 deletions(-)
> > >
> > > diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> > > index aac98f898a..4b0fae12ae 100644
> > > --- a/hw/virtio/vhost-user.c
> > > +++ b/hw/virtio/vhost-user.c
> > > @@ -1668,14 +1668,6 @@ static bool vhost_user_send_resp(QIOChannel *i=
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
> > > @@ -1716,19 +1708,15 @@ int vhost_user_get_shared_object(struct vhost=
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
> > >      CharFrontend *chr =3D u->user->chr;
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
> > > @@ -1737,18 +1725,16 @@ vhost_user_backend_handle_shared_object_looku=
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
> > > @@ -1757,11 +1743,6 @@ vhost_user_backend_handle_shared_object_lookup=
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
> > > @@ -1790,6 +1771,7 @@ static gboolean backend_read(QIOChannel *ioc, G=
IOCondition condition,
> > >      struct iovec iov;
> > >      g_autofree int *fd =3D NULL;
> > >      size_t fdsize =3D 0;
> > > +    bool reply_ack;
> > >      int i;
> > >
> > >      /* Read header */
> > > @@ -1808,6 +1790,8 @@ static gboolean backend_read(QIOChannel *ioc, G=
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
> > > @@ -1833,8 +1817,10 @@ static gboolean backend_read(QIOChannel *ioc, =
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
> > >      default:
> > >          error_report("Received unexpected msg type: %d.", hdr.reques=
t);
> > > @@ -1845,7 +1831,7 @@ static gboolean backend_read(QIOChannel *ioc, G=
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
> > > MST
> > >
>


