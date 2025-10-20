Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 233C3CCD1A2
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 23:29:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAzId-0001yD-Lx; Mon, 20 Oct 2025 19:28:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1vAzIc-0001xQ-Ec
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 19:28:22 -0400
Received: from mail-il1-x12c.google.com ([2607:f8b0:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1vAzIa-0008Oc-Jf
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 19:28:22 -0400
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-430abca3354so47056515ab.2
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 16:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761002899; x=1761607699; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ypeBLW1sNlrDXo8VDK0vl89DKnwmBDnrKS6ztIztt2s=;
 b=dYKydXyhmlyXhlIgncy6blxFfnvJw1qShr5V0cJRD3X9yQGk3ijTTdgzBHqUrll3qI
 RhlepgvXZMBsZP9FZJGTW+DYYYMSBiRltIjGPnL/vAy4x+82BStsta/md77qt9NR4Yhb
 aepS5YO5BzaLDCNM1qmDfoerZMnnLBvpMDmmKpl6NnAJcJtc+lrOavP0MLgcQbIYlVTE
 PKuB2icgiZRbPV1/Afi96y4OYs0LyrIQn8vhydP82lDvYmi6+wjvvDs1ebhS37aKXSPo
 pvE6YY3IbzLUdh0pxrf/esHEI3/3uQ4TCqnntJfsjAGz/d5fVu86LYHBI8fup7Kp2vI4
 WC5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761002899; x=1761607699;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ypeBLW1sNlrDXo8VDK0vl89DKnwmBDnrKS6ztIztt2s=;
 b=gzRkV3XXx5IaBQbIBHC+katORR6fcRCvncPsT44zyNltHbe5gHYs1cvyK97Hm9H4vX
 C0AzYpv3Qih9Sf/iGVP7nVhh5ftgWOBdye+nLFzCpkOnsvxU1x1zRS46fhy81ckZDFnY
 t93DWuMFaeZvlQgeGV9nhi7wMCFcOjNGWVAfBG10RaTJWAxgEucDBRZ7GumRGgQtrhmo
 Pu3Kwn9kCZk+mrw0aCDLrYdQi7K/RyalfyD+1nch9yu56+tpY/JrRuKjiyF0a2Y1cHt/
 57h2cMS1dMjyII7sJ2keSyYcj6GlWjW4Vk3T6anESmitjTj23DWNh4/pC8TkXz+7GpJw
 pg/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+DKGLbPAqP+P0kUurSBhlEfab7gSm2NBHKTF4urp2hRGSROJ+XkMZQv5ypXRBCQFbPH9I2+h1uf2t@nongnu.org
X-Gm-Message-State: AOJu0YzAAWcVa55LLL3QugxJfGRJeiTEyI22eKwvt++Hsp51ThvHmULn
 lPHi9KkzyKZoFTSNHLEl3rL1RL8IlMKAoDF3Ge73wETdUX7fZwP2PVXTgxa6hrycLcnH/Z6Na60
 ewGdTzNz0sQgwkTf8oXdjGPLXFtqXPAc=
X-Gm-Gg: ASbGncsaq/BtlFVSMPy5H7FINvutRT9T22M4V2CQ+L5zng4mLSJ4CTUG5exaZ66IysT
 1f+X+fo/dtrM2lqPn5eZhpPXJXUvHn7uq5YCcbUY+WjyE0MVG8tqWzyUPnx7YfFkDGOlwc5+vWI
 jhrtnepZj8MATFXGq4yk9ZGssWmAFirdYSqeESz+fG6aVlbKhJFSe1OtMyYx44dxDQEt70GhEOX
 rF9E9t4+JpYkvOFE0Iw4LhfZKGdJUZFin4TU0Fo9DEYiSva90dDecxVJmXTFuZ11fKo8mY=
X-Google-Smtp-Source: AGHT+IFaR/F2RYTY+1d95UTECbBQwWJHFAeXwstjNVg231xnygKaGabWzmSNfOYTzINVqW85SdFiifepxVnqME1QWh0=
X-Received: by 2002:a05:6e02:2288:b0:430:db8d:79e4 with SMTP id
 e9e14a558f8ab-430db8d7c5dmr91812035ab.31.1761002899106; Mon, 20 Oct 2025
 16:28:19 -0700 (PDT)
MIME-Version: 1.0
References: <20251016114104.1384675-1-vsementsov@yandex-team.ru>
 <20251016114104.1384675-11-vsementsov@yandex-team.ru>
In-Reply-To: <20251016114104.1384675-11-vsementsov@yandex-team.ru>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Mon, 20 Oct 2025 19:28:07 -0400
X-Gm-Features: AS18NWAUCZPw34ieay5ChsxxWPx5U45PRdiYu39fgcx2BAC51qgj1VchzcK5RnI
Message-ID: <CAFubqFvUzAAYJPq8MB-vCCdSQookd7OvWEwAG36RcPE+-fx28A@mail.gmail.com>
Subject: Re: [PATCH v2 10/25] vhost-user-blk: split vhost_user_blk_init()
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: raphael@enfabrica.net, pbonzini@redhat.com, farosas@suse.de, 
 mst@redhat.com, sgarzare@redhat.com, marcandre.lureau@redhat.com, 
 kwolf@redhat.com, hreitz@redhat.com, berrange@redhat.com, eblake@redhat.com, 
 armbru@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 steven.sistare@oracle.com, yc-core@yandex-team.ru, d-tatianin@yandex-team.ru, 
 jasowang@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::12c;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-il1-x12c.google.com
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

Reviewed-by: Raphael Norwitz <raphael.s.norwitz@gmail.com>


On Thu, Oct 16, 2025 at 7:46=E2=80=AFAM Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> Split it into _init() and _connect() part, following pattern of
> vhost_dev_init / vhost_dev_connect.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  hw/block/vhost-user-blk.c | 27 ++++++++++++++++++++++++---
>  1 file changed, 24 insertions(+), 3 deletions(-)
>
> diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
> index c31c265a0e..9c727c3977 100644
> --- a/hw/block/vhost-user-blk.c
> +++ b/hw/block/vhost-user-blk.c
> @@ -58,6 +58,7 @@ static const int user_feature_bits[] =3D {
>  };
>
>  static void vhost_user_blk_event(void *opaque, QEMUChrEvent event);
> +static int vhost_user_blk_connect(DeviceState *dev, Error **errp);
>
>  static void vhost_user_blk_update_config(VirtIODevice *vdev, uint8_t *co=
nfig)
>  {
> @@ -352,9 +353,6 @@ static int vhost_user_blk_init(DeviceState *dev, bool=
 connect, Error **errp)
>
>      trace_vhost_user_blk_init_in(vdev);
>
> -    /* TODO: implement support for connect=3Dfalse */
> -    assert(connect);
> -
>      assert(!s->connected);
>
>      s->dev.num_queues =3D s->num_queues;
> @@ -371,6 +369,29 @@ static int vhost_user_blk_init(DeviceState *dev, boo=
l connect, Error **errp)
>          return ret;
>      }
>
> +    if (connect) {
> +        ret =3D vhost_user_blk_connect(dev, errp);
> +        if (ret < 0) {
> +            return ret;
> +        }
> +    }
> +
> +    trace_vhost_user_blk_init_out(vdev);
> +
> +    return 0;
> +}
> +
> +static int vhost_user_blk_connect(DeviceState *dev,
> +                                  Error **errp)
> +{
> +    VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
> +    VHostUserBlk *s =3D VHOST_USER_BLK(vdev);
> +    int ret =3D 0;
> +
> +    trace_vhost_user_blk_connect_in(vdev);
> +
> +    assert(!s->connected);
> +
>      ret =3D vhost_dev_connect(&s->dev, errp);
>      if (ret < 0) {
>          return ret;
> --
> 2.48.1
>
>

