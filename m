Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8156CCF9E3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 09:30:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIODa-0001KE-4Y; Mon, 10 Nov 2025 04:29:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1vIO7m-0007ce-3z
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 04:23:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1vIO7j-0001CQ-3j
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 04:23:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762766620;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xQsoIwMEtDcOUzCOCwSHPzBoFkmpbQBaRG92OkL+1vg=;
 b=GFxDHFpkRmLPQBjgFlXXBOlQENudCmptqhY+Wi+c5QwcebdLSjrzefzHVDBobp8pcsqIhi
 CV/FXPKx/iN29SeubzMzafXbHBpo2+HPhDdfJiDyVDlQfUFp7ynRS1aaWxoCSyxpH2xKiV
 Y0fREPpC41eE+XGrLR41wJPcjG1xSWM=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-DYj-pXsDMSqqJswsz7sLhA-1; Mon, 10 Nov 2025 04:23:38 -0500
X-MC-Unique: DYj-pXsDMSqqJswsz7sLhA-1
X-Mimecast-MFC-AGG-ID: DYj-pXsDMSqqJswsz7sLhA_1762766618
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-297e5a18652so20224585ad.1
 for <qemu-devel@nongnu.org>; Mon, 10 Nov 2025 01:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762766617; x=1763371417; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xQsoIwMEtDcOUzCOCwSHPzBoFkmpbQBaRG92OkL+1vg=;
 b=abXcg022hFBHwm/ME820oy2YwGFdI7jrz3N+r57cmUWUj1iYoYtjX1nA/LVNGuW9Ai
 MFl1S9Xz3HYNITnK7fWQ4QuL4WwTfGBmv/nsWVDdEzm3zDxvPI/4AWZ4ymywuabZYdmn
 qJrUfWwJullO6udDB35/UoWc97F5OArb23DJzpwHsRYzO5S4ZLh8VsWCwL7IJjz6RiqK
 xjy+SnXl+nRx56Yn9Oka4rgnGOXzj9vy0hpIxF7rGvARtBRwmkeelO7yYQ7dQLc+gHwX
 gEASWWQBQoBKEUu9wA1uBfYeb/tdluNyPNPQNLIgjRPnzKXKmRoiR4/ZIomzouLrRlGy
 TNdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762766617; x=1763371417;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xQsoIwMEtDcOUzCOCwSHPzBoFkmpbQBaRG92OkL+1vg=;
 b=RuoC/Viu6QVC0kPLCzqRe41vorXWxihYqM+U0S2jIeHPB3jxsaso7IjN9ksWlQRKmr
 utDR4EfmR/UiIpKmmwy9rBh/dtjKqkuVlUmEoVpDySTAFN220NEqrhEhU69bWmvP2ejI
 tLF1BAo1tLl8N/r2g/2MnrE8VpB6JhR96tWESZ/f2sDI02kL5xTfN4rbNP46OUCTsBJl
 V1Euw0vo1JO+HW19mZpCdpipWNm8mLTVJFH3JmjWonN3RJlIB82hzUXKQGv1O0avqEa6
 gyoOuanXuZT2IxaY3q7lJnOSa3DuFrkoxFPCNGrxXMo6tXIuc+BEjAtMnsDeq5IF3gPX
 A1Aw==
X-Gm-Message-State: AOJu0YwsZzc03FOWOmSQSfdAQsKU2r86jxRWnQIVI6W5qsqfKBThn0nm
 VLGoFeSA02n0tEvS8J/JqhYs6NrsLF+JSFMfNDjr4d5vHFD/1hS+aSVPa5+Iv6e3+dTWoA2EH1K
 Fr1ln9XpSzPdR7h+R+DHqqjBJNP/TqgECpX5jlKOj6e7c8M8EkJrd2U0+aaHtn9qtoSY6QRrNkc
 mQCUtpxdCj/2GBY0IicYCDNBSzQjZeR0Q=
X-Gm-Gg: ASbGncto+gyKsszhfy2Cbq/Dln4pPNLH7E4hNTRqXk4xMPVi/fV7fYpP48XHS3/k8i7
 R9wjGiTkXNt6lrTzg7T+eMyt0kl5kBcJKfZqqHf1bbM7W0RlW6aZ9ix8wDlRtn4ROmTtj7AbvvB
 7VTcWYwGR4h7XUyTw0O0OODoyXrT9xaqLnXK8kXX3/cvSabs1DNuM=
X-Received: by 2002:a17:902:ec90:b0:275:81ca:2c5 with SMTP id
 d9443c01a7336-297e5715ea2mr125712715ad.59.1762766617613; 
 Mon, 10 Nov 2025 01:23:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEgO1hZoPNqAVxB8f1OqizhIyihAj+l7LrhNnYhQasuQiWlFNRhQ3AgcGeEt82BXcKSbI9ihcsOPtiSVLeknNM=
X-Received: by 2002:a17:902:ec90:b0:275:81ca:2c5 with SMTP id
 d9443c01a7336-297e5715ea2mr125712485ad.59.1762766617183; Mon, 10 Nov 2025
 01:23:37 -0800 (PST)
MIME-Version: 1.0
References: <cover.1762698873.git.mst@redhat.com>
 <fde5930cc37175cfcd0f03a089e26f4458a52311.1762698873.git.mst@redhat.com>
In-Reply-To: <fde5930cc37175cfcd0f03a089e26f4458a52311.1762698873.git.mst@redhat.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Mon, 10 Nov 2025 10:23:25 +0100
X-Gm-Features: AWmQ_blr16BQ_TMjt2fs-SKhxyPbS_8xKSJUFO3F8OgVfGm6LKIezjmk5IYSIHI
Message-ID: <CADSE00+FLWVdh1CGmy6i4hLdJOKGG6-4JZySXL=wFOyyTnnFpw@mail.gmail.com>
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

On Sun, Nov 9, 2025 at 3:35=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> From: Albert Esteve <aesteve@redhat.com>
>
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

Hey Michal,

This patch was
Based-on: <20251016143827.1850397-1-aesteve@redhat.com>
=E2=80=A6 for main.

As this was the first time I did this based-on thingy, I am just
making sure that the other patch was not missed.
If this PULL is only targeting stable, then it's ok as is.

BR,
Albert

>
> Fixes: 1609476662 ("vhost-user: add shared_object msg")
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Albert Esteve <aesteve@redhat.com>
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Message-Id: <20251017072011.1874874-2-aesteve@redhat.com>
> ---
>  hw/virtio/vhost-user.c | 40 +++++++++++++---------------------------
>  1 file changed, 13 insertions(+), 27 deletions(-)
>
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index aac98f898a..4b0fae12ae 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -1668,14 +1668,6 @@ static bool vhost_user_send_resp(QIOChannel *ioc, =
VhostUserHeader *hdr,
>      return !qio_channel_writev_all(ioc, iov, ARRAY_SIZE(iov), errp);
>  }
>
> -static bool
> -vhost_user_backend_send_dmabuf_fd(QIOChannel *ioc, VhostUserHeader *hdr,
> -                                  VhostUserPayload *payload, Error **err=
p)
> -{
> -    hdr->size =3D sizeof(payload->u64);
> -    return vhost_user_send_resp(ioc, hdr, payload, errp);
> -}
> -
>  int vhost_user_get_shared_object(struct vhost_dev *dev, unsigned char *u=
uid,
>                                   int *dmabuf_fd)
>  {
> @@ -1716,19 +1708,15 @@ int vhost_user_get_shared_object(struct vhost_dev=
 *dev, unsigned char *uuid,
>
>  static int
>  vhost_user_backend_handle_shared_object_lookup(struct vhost_user *u,
> -                                               QIOChannel *ioc,
> -                                               VhostUserHeader *hdr,
> -                                               VhostUserPayload *payload=
)
> +                                               VhostUserShared *object)
>  {
>      QemuUUID uuid;
>      CharFrontend *chr =3D u->user->chr;
> -    Error *local_err =3D NULL;
>      int dmabuf_fd =3D -1;
>      int fd_num =3D 0;
>
> -    memcpy(uuid.data, payload->object.uuid, sizeof(payload->object.uuid)=
);
> +    memcpy(uuid.data, object->uuid, sizeof(object->uuid));
>
> -    payload->u64 =3D 0;
>      switch (virtio_object_type(&uuid)) {
>      case TYPE_DMABUF:
>          dmabuf_fd =3D virtio_lookup_dmabuf(&uuid);
> @@ -1737,18 +1725,16 @@ vhost_user_backend_handle_shared_object_lookup(st=
ruct vhost_user *u,
>      {
>          struct vhost_dev *dev =3D virtio_lookup_vhost_device(&uuid);
>          if (dev =3D=3D NULL) {
> -            payload->u64 =3D -EINVAL;
> -            break;
> +            return -EINVAL;
>          }
>          int ret =3D vhost_user_get_shared_object(dev, uuid.data, &dmabuf=
_fd);
>          if (ret < 0) {
> -            payload->u64 =3D ret;
> +            return ret;
>          }
>          break;
>      }
>      case TYPE_INVALID:
> -        payload->u64 =3D -EINVAL;
> -        break;
> +        return -EINVAL;
>      }
>
>      if (dmabuf_fd !=3D -1) {
> @@ -1757,11 +1743,6 @@ vhost_user_backend_handle_shared_object_lookup(str=
uct vhost_user *u,
>
>      if (qemu_chr_fe_set_msgfds(chr, &dmabuf_fd, fd_num) < 0) {
>          error_report("Failed to set msg fds.");
> -        payload->u64 =3D -EINVAL;
> -    }
> -
> -    if (!vhost_user_backend_send_dmabuf_fd(ioc, hdr, payload, &local_err=
)) {
> -        error_report_err(local_err);
>          return -EINVAL;
>      }
>
> @@ -1790,6 +1771,7 @@ static gboolean backend_read(QIOChannel *ioc, GIOCo=
ndition condition,
>      struct iovec iov;
>      g_autofree int *fd =3D NULL;
>      size_t fdsize =3D 0;
> +    bool reply_ack;
>      int i;
>
>      /* Read header */
> @@ -1808,6 +1790,8 @@ static gboolean backend_read(QIOChannel *ioc, GIOCo=
ndition condition,
>          goto err;
>      }
>
> +    reply_ack =3D hdr.flags & VHOST_USER_NEED_REPLY_MASK;
> +
>      /* Read payload */
>      if (qio_channel_read_all(ioc, (char *) &payload, hdr.size, &local_er=
r)) {
>          error_report_err(local_err);
> @@ -1833,8 +1817,10 @@ static gboolean backend_read(QIOChannel *ioc, GIOC=
ondition condition,
>                                                               &payload.ob=
ject);
>          break;
>      case VHOST_USER_BACKEND_SHARED_OBJECT_LOOKUP:
> -        ret =3D vhost_user_backend_handle_shared_object_lookup(dev->opaq=
ue, ioc,
> -                                                             &hdr, &payl=
oad);
> +        /* The backend always expects a response */
> +        reply_ack =3D true;
> +        ret =3D vhost_user_backend_handle_shared_object_lookup(dev->opaq=
ue,
> +                                                             &payload.ob=
ject);
>          break;
>      default:
>          error_report("Received unexpected msg type: %d.", hdr.request);
> @@ -1845,7 +1831,7 @@ static gboolean backend_read(QIOChannel *ioc, GIOCo=
ndition condition,
>       * REPLY_ACK feature handling. Other reply types has to be managed
>       * directly in their request handlers.
>       */
> -    if (hdr.flags & VHOST_USER_NEED_REPLY_MASK) {
> +    if (reply_ack) {
>          payload.u64 =3D !!ret;
>          hdr.size =3D sizeof(payload.u64);
>
> --
> MST
>


