Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3C9FCCFA05
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Nov 2025 15:00:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vHNvp-0007ra-Jq; Fri, 07 Nov 2025 09:59:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1vHNvm-0007r2-6S
 for qemu-devel@nongnu.org; Fri, 07 Nov 2025 09:59:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1vHNvk-0002r4-4A
 for qemu-devel@nongnu.org; Fri, 07 Nov 2025 09:59:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762527550;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G7bZH5hXbSUYQo70UYPRI3c0LRZuYjPIiGpRwTWgsVs=;
 b=XG3WWMQeKH6uxdvcNfdZ7/EyjItEK3Ymto8v1ZrvZIW7Slm26kzWar1r2BZWqZYUEmIibN
 gpyzQgsJkSbQCaASm98hG25sbAzRkOUF6dN0PSJxdxETMBGunQ5Y/mtmJDcISzJgARfh9j
 Z6Sk34GmkPqCMA6WbbLaQr5uhUrGM4c=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-110-XTAbdzfdMsKtEFnORuvNug-1; Fri, 07 Nov 2025 09:59:09 -0500
X-MC-Unique: XTAbdzfdMsKtEFnORuvNug-1
X-Mimecast-MFC-AGG-ID: XTAbdzfdMsKtEFnORuvNug_1762527544
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-b5edecdf94eso1933068a12.2
 for <qemu-devel@nongnu.org>; Fri, 07 Nov 2025 06:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762527544; x=1763132344; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G7bZH5hXbSUYQo70UYPRI3c0LRZuYjPIiGpRwTWgsVs=;
 b=bDrcOlGAj/dXOJYi0amCdpaIrwNgt0+MGzJiA/RQP+vES8iSr7q9XuZPOdaFPe/Akg
 nXlAvQ90NcCxYdHhmRIhIpKJOrigc0gwypUpFr2RjbyF6XXV7HWmDtrikaV6HIp5GKGO
 JibKTA5LKJABgPdIN2/s/1pKzVTsWbfwzolTvhecLqrZgAseuIVmIy4Z5W6gUk8w3yP2
 0YFxFw9p/cOXnBb3JJ849TZpfqqgtxC+BURpPZi9h5chg5+b6WpS7TmQf5i5Y8ewem/f
 bJ8LfLO0FgTZaSSkuhAOo6p1nYIQdfeXuNEqUhfrTSvb/yFq5VQIBXdhZ0PRZ3EtgLhR
 y3Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762527544; x=1763132344;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=G7bZH5hXbSUYQo70UYPRI3c0LRZuYjPIiGpRwTWgsVs=;
 b=PPPQlBzitOGu3A4th4jjr1s3TcbWB887aaL8ThQX6IeVLZE0af6kgbvoG1oG+Djeof
 Nr+YHHgfm/rypifwaYmc1o4KIBKjgCMqVOa4lCqkXT89OoLrCzfA4PmFXnJGdd5PK6kr
 WutNOgetRWXXQxu1Iebe9VSaHegJ4AoEg2im8a7vbwcwYlHrGRGxQyW502vuWGEBbbW0
 w0xqMvc3ITPqdfSlxX8Ttmol0fid4xDttiHVUNV1gimC9ekzU9L9/blnKQbj8QYwqGG1
 tN2R4PXvHB3XUpHWDMESgZ+uqtng7TDX10A0ieKRKoSkAhwUV4KAhB99m2nZ+cEs/Hi1
 qfMQ==
X-Gm-Message-State: AOJu0Yy0lRyfx9E/k868m79BOGqIPvic9chWpHeHeUGnClCzC2kHJ8Sd
 16cAezewnnKADOwm4BBsD/6puNPK5F+NWf00oIJ5JWFr0xycRgPjN0ka4JDHDEyt88o2tBXY2/N
 q63UPyglBzaT1Q5ciDiqhq4wWCBCodot/rJt6awijiObx8QUYTornRhIXQIUt06lgWuOj24tqg8
 /SovuVb3FNbGmxkpw5s00PyFyACSsmZa0=
X-Gm-Gg: ASbGncuIbwsWUER1BaOcuIe6XOVLPmlk5B+G8TxbMBC9QcNxgKewJCCjx/XWrcBAJMi
 tDzAfAiU8tm2xOeLKH6ehd20NxxrTGln5r9seY7ocVBpw7IVYC/pX6wU0ESJu9u3S5EVTjoBF0R
 dyYCuz/aofM5b0IpJzSB5ilmEGG8r7oRhWfKKESKVOp17QJFCsT5U=
X-Received: by 2002:a05:6a21:e098:b0:2e6:b58a:ddec with SMTP id
 adf61e73a8af0-3522ae79178mr5332938637.36.1762527543932; 
 Fri, 07 Nov 2025 06:59:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGgLBIiARFhPSEyVwmMob/LwtW0am02lvFcUYdRxNnCjH+ZdMjyxGRYGa1xiN7s1yEGKlKrTlvrhRePDxy+NkY=
X-Received: by 2002:a05:6a21:e098:b0:2e6:b58a:ddec with SMTP id
 adf61e73a8af0-3522ae79178mr5332906637.36.1762527543504; Fri, 07 Nov 2025
 06:59:03 -0800 (PST)
MIME-Version: 1.0
References: <20251017072011.1874874-1-aesteve@redhat.com>
 <20251017072011.1874874-2-aesteve@redhat.com>
 <20251107082334-mutt-send-email-mst@kernel.org>
In-Reply-To: <20251107082334-mutt-send-email-mst@kernel.org>
From: Albert Esteve <aesteve@redhat.com>
Date: Fri, 7 Nov 2025 15:58:52 +0100
X-Gm-Features: AWmQ_bm7nKh1hhVFDHa2m4vJC7jctcffnZYbYDIqB6660I-zaCsuTF4h1dDJnt4
Message-ID: <CADSE00+ZN0-KGj-zHJOsxbEbGeLFaG0WzZdW4joD2ypzbcqOeQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] vhost-user: fix shared object lookup handler logic
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Stefano Garzarella <sgarzare@redhat.com>,
 qemu-stable@nongnu.org
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

On Fri, Nov 7, 2025 at 2:26=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Fri, Oct 17, 2025 at 09:20:11AM +0200, Albert Esteve wrote:
> > Refactor backend_read() function and add a reply_ack variable
> > to have the option for handlers to force tweak whether they should
> > send a reply or not without depending on VHOST_USER_NEED_REPLY_MASK
> > flag.
> >
> > This fixes an issue with
> > vhost_user_backend_handle_shared_object_lookup() logic, as the
> > error path was not closing the backend channel correctly. So,
> > we can remove the reply call from within the handler, make
> > sure it returns early on errors as other handlers do and
> > set the reply_ack variable on backend_read() to true to ensure
> > that it will send a response, thus keeping the original intent.
> >
> > Fixes: 160947666276c5b7f6bca4d746bcac2966635d79
>
>
> I fixed this, should include the subject.
>
> > Cc: qemu-stable@nongnu.org
> > Signed-off-by: Albert Esteve <aesteve@redhat.com>
>
>
> So I picked this for now, but I worry that we are opening ourselves
> up to buggy backends which forget to set the flag and expect
> frontend to behave properly.
>
> I think a better fix would be instead of forcing, check reply_ack,
> and fail if not set correctly.

Fair point. I will send a follow-up PATCH with this check and fail early.

>
> > ---
> >  hw/virtio/vhost-user.c | 42 +++++++++++++++---------------------------
> >  1 file changed, 15 insertions(+), 27 deletions(-)
> >
> > diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> > index 890be55937..762d7218d3 100644
> > --- a/hw/virtio/vhost-user.c
> > +++ b/hw/virtio/vhost-user.c
> > @@ -1696,14 +1696,6 @@ static bool vhost_user_send_resp(QIOChannel *ioc=
, VhostUserHeader *hdr,
> >      return !qio_channel_writev_all(ioc, iov, ARRAY_SIZE(iov), errp);
> >  }
> >
> > -static bool
> > -vhost_user_backend_send_dmabuf_fd(QIOChannel *ioc, VhostUserHeader *hd=
r,
> > -                                  VhostUserPayload *payload, Error **e=
rrp)
> > -{
> > -    hdr->size =3D sizeof(payload->u64);
> > -    return vhost_user_send_resp(ioc, hdr, payload, errp);
> > -}
> > -
> >  int vhost_user_get_shared_object(struct vhost_dev *dev, unsigned char =
*uuid,
> >                                   int *dmabuf_fd)
> >  {
> > @@ -1744,19 +1736,15 @@ int vhost_user_get_shared_object(struct vhost_d=
ev *dev, unsigned char *uuid,
> >
> >  static int
> >  vhost_user_backend_handle_shared_object_lookup(struct vhost_user *u,
> > -                                               QIOChannel *ioc,
> > -                                               VhostUserHeader *hdr,
> > -                                               VhostUserPayload *paylo=
ad)
> > +                                               VhostUserShared *object=
)
> >  {
> >      QemuUUID uuid;
> >      CharBackend *chr =3D u->user->chr;
> > -    Error *local_err =3D NULL;
> >      int dmabuf_fd =3D -1;
> >      int fd_num =3D 0;
> >
> > -    memcpy(uuid.data, payload->object.uuid, sizeof(payload->object.uui=
d));
> > +    memcpy(uuid.data, object->uuid, sizeof(object->uuid));
> >
> > -    payload->u64 =3D 0;
> >      switch (virtio_object_type(&uuid)) {
> >      case TYPE_DMABUF:
> >          dmabuf_fd =3D virtio_lookup_dmabuf(&uuid);
> > @@ -1765,18 +1753,16 @@ vhost_user_backend_handle_shared_object_lookup(=
struct vhost_user *u,
> >      {
> >          struct vhost_dev *dev =3D virtio_lookup_vhost_device(&uuid);
> >          if (dev =3D=3D NULL) {
> > -            payload->u64 =3D -EINVAL;
> > -            break;
> > +            return -EINVAL;
> >          }
> >          int ret =3D vhost_user_get_shared_object(dev, uuid.data, &dmab=
uf_fd);
> >          if (ret < 0) {
> > -            payload->u64 =3D ret;
> > +            return ret;
> >          }
> >          break;
> >      }
> >      case TYPE_INVALID:
> > -        payload->u64 =3D -EINVAL;
> > -        break;
> > +        return -EINVAL;
> >      }
> >
> >      if (dmabuf_fd !=3D -1) {
> > @@ -1785,11 +1771,6 @@ vhost_user_backend_handle_shared_object_lookup(s=
truct vhost_user *u,
> >
> >      if (qemu_chr_fe_set_msgfds(chr, &dmabuf_fd, fd_num) < 0) {
> >          error_report("Failed to set msg fds.");
> > -        payload->u64 =3D -EINVAL;
> > -    }
> > -
> > -    if (!vhost_user_backend_send_dmabuf_fd(ioc, hdr, payload, &local_e=
rr)) {
> > -        error_report_err(local_err);
> >          return -EINVAL;
> >      }
> >
> > @@ -2008,6 +1989,7 @@ static gboolean backend_read(QIOChannel *ioc, GIO=
Condition condition,
> >      struct iovec iov;
> >      g_autofree int *fd =3D NULL;
> >      size_t fdsize =3D 0;
> > +    bool reply_ack;
> >      int i;
> >
> >      /* Read header */
> > @@ -2026,6 +2008,8 @@ static gboolean backend_read(QIOChannel *ioc, GIO=
Condition condition,
> >          goto err;
> >      }
> >
> > +    reply_ack =3D hdr.flags & VHOST_USER_NEED_REPLY_MASK;
> > +
> >      /* Read payload */
> >      if (qio_channel_read_all(ioc, (char *) &payload, hdr.size, &local_=
err)) {
> >          error_report_err(local_err);
> > @@ -2051,11 +2035,14 @@ static gboolean backend_read(QIOChannel *ioc, G=
IOCondition condition,
> >                                                               &payload.=
object);
> >          break;
> >      case VHOST_USER_BACKEND_SHARED_OBJECT_LOOKUP:
> > -        ret =3D vhost_user_backend_handle_shared_object_lookup(dev->op=
aque, ioc,
> > -                                                             &hdr, &pa=
yload);
> > +        /* The backend always expects a response */
> > +        reply_ack =3D true;
> > +        ret =3D vhost_user_backend_handle_shared_object_lookup(dev->op=
aque,
> > +                                                             &payload.=
object);
> >          break;
> >      case VHOST_USER_BACKEND_SHMEM_MAP:
> >          /* Handler manages its own response, check error and close con=
nection */
> > +        reply_ack =3D false;
> >          if (vhost_user_backend_handle_shmem_map(dev, ioc, &hdr, &paylo=
ad,
> >                                                  fd ? fd[0] : -1) < 0) =
{
> >              goto err;
> > @@ -2063,6 +2050,7 @@ static gboolean backend_read(QIOChannel *ioc, GIO=
Condition condition,
> >          break;
> >      case VHOST_USER_BACKEND_SHMEM_UNMAP:
> >          /* Handler manages its own response, check error and close con=
nection */
> > +        reply_ack =3D false;
> >          if (vhost_user_backend_handle_shmem_unmap(dev, ioc, &hdr, &pay=
load) < 0) {
> >              goto err;
> >          }
> > @@ -2076,7 +2064,7 @@ static gboolean backend_read(QIOChannel *ioc, GIO=
Condition condition,
> >       * REPLY_ACK feature handling. Other reply types has to be managed
> >       * directly in their request handlers.
> >       */
> > -    if (hdr.flags & VHOST_USER_NEED_REPLY_MASK) {
> > +    if (reply_ack) {
> >          payload.u64 =3D !!ret;
> >          hdr.size =3D sizeof(payload.u64);
> >
> > --
> > 2.49.0
>


