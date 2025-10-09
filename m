Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 400A8CCD184
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 18:59:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6vrL-0000uI-1R; Thu, 09 Oct 2025 14:59:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1v6vr8-0000jp-Kk
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 14:59:16 -0400
Received: from mail-io1-xd31.google.com ([2607:f8b0:4864:20::d31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1v6vr6-0006Dx-N5
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 14:59:14 -0400
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-9298eba27c2so58384339f.3
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 11:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760036351; x=1760641151; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aiFPW9xf2x08b0VN8SOgYp6Ob36eaYFr1ZUBNcy9ll4=;
 b=FoWK5yqU3PZaGgiyfi2dB9tcZoiz5HYfM49x0ikEjQHXH8dy46QQoFvJPk77BJdvJf
 CO+/gHCYhxrUcvVJ9fpKK8b4inY/51gb1dN6/AVefEk0HKTWI4VjZYCMW3YGA1aj8oL6
 w28YDN84E8vay/9k3uf5Y+Tu7RBA8f2CiGd2eLKKf4OFrqxAAMyW16wFm8AkpDf2hh9p
 DJChhXFQQ+uDhMFnDg+A90mH5el7YMixbc/nnxwWOEjYKa86JaY9A5iOLLWERJPXd9pX
 zSigu6DIF6U2fRkxgeKZWYZ3Q49ye2vzGct1I5boAz/i+EYQXfiymysO/JLdo9hUKbOX
 GAfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760036351; x=1760641151;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aiFPW9xf2x08b0VN8SOgYp6Ob36eaYFr1ZUBNcy9ll4=;
 b=ekJiy3bG1+R8Zq6RSH6WSbr/0EqNOEkha2vSD2DwK93tPfh6NsuNde2JnOskWkInNj
 ZIYHcspG2UhmWXMu9ehNBk35KnhyLjMGOlTpFNqnNiOXvgKc1XKF3bzlTP5y9dYIzRIy
 uLwe6TE5YLYbWdRBoFveuelUjFtPTx8DWmkBNXa61VlBLKyZrUivo9ddGbalp+KqKWju
 HMDqPZGXLaDzXGwgWRZHN+xynEVhH/eOFEDgzzaQ8liVpai7jxmkfB5/mS5Zil4S3JkW
 Wug3d5VQ9DjJtS4uHdPKx8Vomy9XqrVcGFEcQWoSxyCd3NImipwf6u9ovMgh8na5LUL1
 xvyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnLZBLQD4cdcKYJHkW2Pa329UcNw0TNbfAsFHPmdo/AZ3HwzalvZHAYsiFdnAUM6yxBGG7+NAiKEbd@nongnu.org
X-Gm-Message-State: AOJu0YwBXhKJ89amNwvv3AbytKdLvbHPE1BFm+nB7x1mbt2hvonp7MqN
 BLF/GgLKx3z0YTHGGrZxMrHLEcCBxLMytRv54h0heA4okghhtHGkGat8CHKL1eFFK7vS5lsJSRn
 +W9g3s4GxD/0trX964+WMJXZs5qXEXiw=
X-Gm-Gg: ASbGncspHpSyWUwXaSY9HTb4OamzMOVIOj2faEe6e99k/F+NfoPe/x6boA/twIOauOc
 pBcZLTeqH+BJcaaHQeK/G8dfZq5c/bD2v943UHsKZeEWnr8sZDelQtkB6hMTAUKi6VjAA9mqjr2
 sG6Wcu0sW8gA8g98+KEJoxgle8XctXcAxT7GGo4ednfleHjXw5s5G5P6PxNcj9pYLviRYUeIxhl
 D2m5XzC/i/qNTaHDXRdHWk9iC6+A3o=
X-Google-Smtp-Source: AGHT+IHshuljN7+bcl4p2NjI25KpzFJvNYfOF7OO/je/kzcGJbOvG2xdOt1iMxJdF+VBNcJpfSktezUqCFWVJ0mgO0w=
X-Received: by 2002:a05:6602:494:b0:887:732f:6a96 with SMTP id
 ca18e2360f4ac-93bd192a615mr1022489839f.17.1760036350833; Thu, 09 Oct 2025
 11:59:10 -0700 (PDT)
MIME-Version: 1.0
References: <20250813164856.950363-1-vsementsov@yandex-team.ru>
 <20250813164856.950363-10-vsementsov@yandex-team.ru>
In-Reply-To: <20250813164856.950363-10-vsementsov@yandex-team.ru>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Thu, 9 Oct 2025 14:58:59 -0400
X-Gm-Features: AS18NWD1_G2lGnQE9jpKo5w7LSxbd7FuCz6g9d9AWFmEGOGVzGoipjuxgU6WIHg
Message-ID: <CAFubqFuWb=S165X5ZuM7if3tUbdB0ShcVb1p1v3sJXso5PMoXw@mail.gmail.com>
Subject: Re: [PATCH 09/33] vhost-user: keep QIOChannelSocket for backend
 channel
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: mst@redhat.com, peterx@redhat.com, farosas@suse.de, raphael@enfabrica.net, 
 sgarzare@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com, 
 kwolf@redhat.com, hreitz@redhat.com, berrange@redhat.com, eblake@redhat.com, 
 armbru@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 steven.sistare@oracle.com, den-plotnikov@yandex-team.ru
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d31;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-io1-xd31.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Acked-by: Raphael Norwitz <raphael.s.norwitz@gmail.com>

On Wed, Aug 13, 2025 at 1:01=E2=80=AFPM Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> Keep QIOChannelSocket pointer instead of more generic
> QIOChannel. No real difference for now, but it would
> be simpler to migrate socket fd in further commit.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  hw/virtio/vhost-user.c | 21 ++++++++++-----------
>  1 file changed, 10 insertions(+), 11 deletions(-)
>
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index 46f09f5988..fe9d91348d 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -244,7 +244,7 @@ struct vhost_user {
>      struct vhost_dev *dev;
>      /* Shared between vhost devs of the same virtio device */
>      VhostUserState *user;
> -    QIOChannel *backend_ioc;
> +    QIOChannelSocket *backend_sioc;
>      GSource *backend_src;
>      NotifierWithReturn postcopy_notifier;
>      struct PostCopyFD  postcopy_fd;
> @@ -1789,8 +1789,8 @@ static void close_backend_channel(struct vhost_user=
 *u)
>      g_source_destroy(u->backend_src);
>      g_source_unref(u->backend_src);
>      u->backend_src =3D NULL;
> -    object_unref(OBJECT(u->backend_ioc));
> -    u->backend_ioc =3D NULL;
> +    object_unref(OBJECT(u->backend_sioc));
> +    u->backend_sioc =3D NULL;
>  }
>
>  static gboolean backend_read(QIOChannel *ioc, GIOCondition condition,
> @@ -1897,7 +1897,6 @@ static int vhost_setup_backend_channel(struct vhost=
_dev *dev)
>      bool reply_supported =3D
>          vhost_user_has_prot(dev, VHOST_USER_PROTOCOL_F_REPLY_ACK);
>      Error *local_err =3D NULL;
> -    QIOChannel *ioc;
>
>      if (!vhost_user_has_prot(dev, VHOST_USER_PROTOCOL_F_BACKEND_REQ)) {
>          return 0;
> @@ -1909,15 +1908,15 @@ static int vhost_setup_backend_channel(struct vho=
st_dev *dev)
>          return -saved_errno;
>      }
>
> -    ioc =3D QIO_CHANNEL(qio_channel_socket_new_fd(sv[0], &local_err));
> -    if (!ioc) {
> +    u->backend_sioc =3D qio_channel_socket_new_fd(sv[0], &local_err);
> +    if (!u->backend_sioc) {
>          error_report_err(local_err);
>          return -ECONNREFUSED;
>      }
> -    u->backend_ioc =3D ioc;
> -    u->backend_src =3D qio_channel_add_watch_source(u->backend_ioc,
> -                                                G_IO_IN | G_IO_HUP,
> -                                                backend_read, dev, NULL,=
 NULL);
> +    u->backend_src =3D qio_channel_add_watch_source(QIO_CHANNEL(u->backe=
nd_sioc),
> +                                                  G_IO_IN | G_IO_HUP,
> +                                                  backend_read, dev,
> +                                                  NULL, NULL);
>
>      if (reply_supported) {
>          msg.hdr.flags |=3D VHOST_USER_NEED_REPLY_MASK;
> @@ -2321,7 +2320,7 @@ static int vhost_user_backend_cleanup(struct vhost_=
dev *dev)
>          close(u->postcopy_fd.fd);
>          u->postcopy_fd.handler =3D NULL;
>      }
> -    if (u->backend_ioc) {
> +    if (u->backend_sioc) {
>          close_backend_channel(u);
>      }
>      g_free(u->region_rb);
> --
> 2.48.1
>
>

