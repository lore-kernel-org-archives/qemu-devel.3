Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0592CCD184
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 18:58:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6vpB-00062U-9s; Thu, 09 Oct 2025 14:57:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1v6vp9-000614-0k
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 14:57:11 -0400
Received: from mail-io1-xd2d.google.com ([2607:f8b0:4864:20::d2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1v6vp6-0005tt-Vg
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 14:57:10 -0400
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-9298eba27c2so58304939f.3
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 11:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760036226; x=1760641026; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X0dknKoZUQotkXZcmI+ktAP6nUB+cGYDGfHpMEkZ+k8=;
 b=bj6NPRUVKSkUxh7LczfsBvjG/sIiRSoVVAzYj+xJKz3ZpaMzZ9ZpLlEpB1zl1aj6fZ
 4MdIVQo22hLSTTJ3pYPKU5nE6Uvl+dx94OQLXKo97HNonT2LpsyXkvbHiYS5hGmA/EPj
 hlsRdszZwtey5HsV+KMizRqzeVKR63AlYPo6zTCOByoOPmdAZCu8BQdb9r6UjGASMQJb
 KgFUg9EkC1aZk6j9FlkJTCijv0OZfB06qQUzLWM0XvnQtqYv/C4OUk5VRQaN9ot3vkJn
 PdBoOgT7baref70tcgDnDQDt5MCJpuWd9A/KpwjJFVFIzRapm1Xg56xFwG1K8jRUcQib
 Q7BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760036226; x=1760641026;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X0dknKoZUQotkXZcmI+ktAP6nUB+cGYDGfHpMEkZ+k8=;
 b=waPOe6QPplgghdyYzX2QayEKHrEFIJMb23LXIKHI+C1/PraVbMsE1M/pxFoUvRD74G
 fFa7p43ut1CGQjBpe+CE209CGZGwufNONw99o2YVibY/EohVELcwc5jsxkpV5gKNP69A
 7tASUXXOzvnyTE+DyPWuQNZXPQjCj9xcrLVP1bNkeH5iBFd6YPmkrvt4lyHIqMxUx27I
 pq1VTkU9F0GmBRd0EE6S9lYNXO9p5VZX9Pu4cVurGroScSIbmJCdaIVsxFe6n0tAxiu2
 0b92t3r/G+jXd4rEa6iQNszd3CkzoNHIzva+qA+nJGcxtTX6j98PxqS49652yakTNFYx
 6ftA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuzXlc9XpP6vomZWsiJidHGtkCK86KYyhkvxC/8pjlk6/0ANyeNTkGaI9ycuPcklyf5LScdNtz1NmN@nongnu.org
X-Gm-Message-State: AOJu0Yw47Qye0XMEuIxhPqBxX3ifPlM9i4W3tcBtrtlyXPjEOFvFQs5r
 bHWGAE3T1JvWKBtINXVKtdu5nb46yAW2Drj/TXtcYQ6k22W4yZH4Vu8EA/5KdZob7vs1MH1ZpAE
 rExQJjY+Pc+f4Y7w8aBw+okX/g/aEUJI=
X-Gm-Gg: ASbGnctDF+YPLpgjellzrNnWhTQRHXmptD/ImB1VjzAqRDsra8eGBx2Yil9az3AKP0Q
 RJ0K1Fgxya8ZMzscdVJ6dWBQ8mZ45HiqkJWlJf+8IvbOwRJ+snpCkdjUIGpT7rODkOk/st9HONz
 OousmKr4ZwevgBY4jP35PHrhwvaMxbaSZTLzWgEESmVrmBuigkPTn7OWFfqsbdC1FY+Zrm2hThw
 jYwmDxZ7GKWiBnP6u2VppYTMXNiS5O3s8dFyKrk7w==
X-Google-Smtp-Source: AGHT+IFG85Pg+xVYlIaTOgzK+OOn01ziUcCWpBEs9RURIqbV9q6XoZZyKth2NEnqnQSOerEQh6L8r86yZE/fQthvaQ8=
X-Received: by 2002:a05:6602:1401:b0:936:eded:d78a with SMTP id
 ca18e2360f4ac-93bd17d0c2amr1017722039f.6.1760036226535; Thu, 09 Oct 2025
 11:57:06 -0700 (PDT)
MIME-Version: 1.0
References: <20250813164856.950363-1-vsementsov@yandex-team.ru>
 <20250813164856.950363-2-vsementsov@yandex-team.ru>
In-Reply-To: <20250813164856.950363-2-vsementsov@yandex-team.ru>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Thu, 9 Oct 2025 14:56:55 -0400
X-Gm-Features: AS18NWALl4w3QQaqguVfqn5wHsG8gDn_u_w4aTiQy6UGoeHYeuXOtdV8jwgmf7Y
Message-ID: <CAFubqFvWwHu2B-Tg6eB+-j86mhGu8MKsHBLL-4+sQy9WS5XbWQ@mail.gmail.com>
Subject: Re: [PATCH 01/33] vhost: introduce
 vhost_ops->vhost_set_vring_enable_supported method
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: mst@redhat.com, peterx@redhat.com, farosas@suse.de, raphael@enfabrica.net, 
 sgarzare@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com, 
 kwolf@redhat.com, hreitz@redhat.com, berrange@redhat.com, eblake@redhat.com, 
 armbru@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 steven.sistare@oracle.com, den-plotnikov@yandex-team.ru
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d2d;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-io1-xd2d.google.com
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

On Wed, Aug 13, 2025 at 12:53=E2=80=AFPM Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> Remove vhost-user specific hack from generic code.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  hw/virtio/vhost-user.c            |  8 ++++++++
>  hw/virtio/vhost.c                 | 15 ++++++---------
>  include/hw/virtio/vhost-backend.h |  2 ++
>  3 files changed, 16 insertions(+), 9 deletions(-)
>
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index 1e1d6b0d6e..1b2879a90c 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -1230,6 +1230,12 @@ static int vhost_user_set_vring_base(struct vhost_=
dev *dev,
>      return vhost_set_vring(dev, VHOST_USER_SET_VRING_BASE, ring, false);
>  }
>
> +static bool vhost_user_set_vring_enable_supported(struct vhost_dev *dev)
> +{
> +    return virtio_has_feature(dev->backend_features,
> +                              VHOST_USER_F_PROTOCOL_FEATURES);
> +}
> +
>  static int vhost_user_set_vring_enable(struct vhost_dev *dev, int enable=
)
>  {
>      int i;
> @@ -3032,6 +3038,8 @@ const VhostOps user_ops =3D {
>          .vhost_reset_device =3D vhost_user_reset_device,
>          .vhost_get_vq_index =3D vhost_user_get_vq_index,
>          .vhost_set_vring_enable =3D vhost_user_set_vring_enable,
> +        .vhost_set_vring_enable_supported =3D
> +            vhost_user_set_vring_enable_supported,

Why not make this a callback like vhost_user_gpu_{set|shared}_socket()
in vhost_backend.h instead?


>          .vhost_requires_shm_log =3D vhost_user_requires_shm_log,
>          .vhost_migration_done =3D vhost_user_migration_done,
>          .vhost_net_set_mtu =3D vhost_user_net_set_mtu,
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 6557c58d12..c33dad4acd 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -1986,15 +1986,12 @@ static int vhost_dev_set_vring_enable(struct vhos=
t_dev *hdev, int enable)
>          return 0;
>      }
>
> -    /*
> -     * For vhost-user devices, if VHOST_USER_F_PROTOCOL_FEATURES has not
> -     * been negotiated, the rings start directly in the enabled state, a=
nd
> -     * .vhost_set_vring_enable callback will fail since
> -     * VHOST_USER_SET_VRING_ENABLE is not supported.
> -     */
> -    if (hdev->vhost_ops->backend_type =3D=3D VHOST_BACKEND_TYPE_USER &&
> -        !virtio_has_feature(hdev->backend_features,
> -                            VHOST_USER_F_PROTOCOL_FEATURES)) {
> +    if (hdev->vhost_ops->vhost_set_vring_enable_supported &&
> +        !hdev->vhost_ops->vhost_set_vring_enable_supported(hdev)) {
> +        /*
> +         * This means, that rings are always enabled, and disable/enable
> +         * API is not supported.
> +         */
>          return 0;
>      }
>
> diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhost-=
backend.h
> index d6df209a2f..f65fa26298 100644
> --- a/include/hw/virtio/vhost-backend.h
> +++ b/include/hw/virtio/vhost-backend.h
> @@ -105,6 +105,7 @@ typedef int (*vhost_reset_device_op)(struct vhost_dev=
 *dev);
>  typedef int (*vhost_get_vq_index_op)(struct vhost_dev *dev, int idx);
>  typedef int (*vhost_set_vring_enable_op)(struct vhost_dev *dev,
>                                           int enable);
> +typedef bool (*vhost_set_vring_enable_supported_op)(struct vhost_dev *de=
v);
>  typedef bool (*vhost_requires_shm_log_op)(struct vhost_dev *dev);
>  typedef int (*vhost_migration_done_op)(struct vhost_dev *dev,
>                                         char *mac_addr);
> @@ -193,6 +194,7 @@ typedef struct VhostOps {
>      vhost_reset_device_op vhost_reset_device;
>      vhost_get_vq_index_op vhost_get_vq_index;
>      vhost_set_vring_enable_op vhost_set_vring_enable;
> +    vhost_set_vring_enable_supported_op vhost_set_vring_enable_supported=
;
>      vhost_requires_shm_log_op vhost_requires_shm_log;
>      vhost_migration_done_op vhost_migration_done;
>      vhost_vsock_set_guest_cid_op vhost_vsock_set_guest_cid;
> --
> 2.48.1
>
>

