Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 057B8CCD185
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 20:14:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8Ovn-0005jS-D1; Mon, 13 Oct 2025 16:14:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1v8Ovl-0005jJ-S8
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 16:14:05 -0400
Received: from mail-io1-xd33.google.com ([2607:f8b0:4864:20::d33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1v8Ovk-0000DL-Ak
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 16:14:05 -0400
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-9335a918867so469165739f.2
 for <qemu-devel@nongnu.org>; Mon, 13 Oct 2025 13:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760386443; x=1760991243; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KigrxIVEd2ccjOJEMrXGhnKJfAXrnpcc9JwEzCo+flY=;
 b=dlCIzorpgkNuUdqsAG3B7wWFVr7S1UbFcvGG+Dgv+hWQZjHiQZ2PgYDrhDIWpUFmVx
 hil3Hsmm7ZKasg1dz1JBqw5wjwvVrYqvIDH1zGTBCfI/kh9PiyUxxyfUK7CYXbQAkKwz
 v1eySwdXB+p9lBO+m5lJ7vhNuxCsbWsCgWGvRXh2BBKIT9qUIre8lXNq2ME8o/IIlzKt
 1jRDUfQP3hyfpDYZrUmuPprRGiXLssa1WyR1l8bAnzAWT8VrXVIdT4rEiYUv4DZkmlLp
 hWvXpjOiBA7hIE7o5PQGxpV+t/OIBKrZJuffxf0gQREFdoLOzG9zbcTOhW4yl7iZmDJb
 DVYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760386443; x=1760991243;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KigrxIVEd2ccjOJEMrXGhnKJfAXrnpcc9JwEzCo+flY=;
 b=q/7SULGQdLqI1O72xu+BKSmOtiExtBJVeHofomiqdH7RAvlK9MsLbEn4tbvxfixknD
 4yKKwatKz3CMSIAfe2usEUs/VbCMtVt+/g17WGY2zrJdB+P+lDU1NlflEildiqth8YbK
 JeNWGGvQH97ShHFzkk7+x4ZCgyFeoDXQ+Oe+k7x7icmYQA8A/H8lHan1YrSbPP08KC/3
 t0NUG+N9ohPHhP4pemAPLpp3iRbsNEJJ0S8ZLQn87SafCLKaCkvVHqtEnQNr6q+SDFa5
 9NKybQsEM/UM4xqVJZEBcZ7zTzS7TaFom1mw6EGsVde6AyEGOUzvhAz/t/tABYMCcJpn
 WQeg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSCfYjFjFCcy5muyhdtpEcRl5sC/IGuo/csoOwjb+7EcR+rIvyE4ukYe3rvlAhQrIthPbpDefN0vf/@nongnu.org
X-Gm-Message-State: AOJu0Ywbg0EOzP53xEbb3TH6cTUQsVNo65eEsMTzF+bDFW38ztryLCRS
 Lu/von/F4XFYJsryKhZ1vAfaWv1geR8ik+zzC6/fD9Ir1Moy72tQE2x/b7LTHuZkhPBHDTT1ehe
 7K4I4AyQQQkRB+TOIXoGGdrzpk4H+6ZE=
X-Gm-Gg: ASbGncswylgPtRG/XJqWKwnevxmYqxxdB/QeKXf/gajT+QzM0sMvI8Rp+0HIfcUCjHS
 3Oj19R/afZTmalQKr+rED4q7bb6nx3odESKXexhVIq/zZrscSDXgRcJ+KjroYC22U0RTSIZuarS
 qv/hHvBRSBdMnUVhCB/ogDFWf9h+SDHhsWlP38L283gZ8PwwOCQpc9ZV16nekGqz4TqiMuQXjo6
 p2Bp6D7svfwxHpfxEk6IUxS/fuODMaekq0Q
X-Google-Smtp-Source: AGHT+IFMJHkiFCLf4xPeVsftoc5zq5kFMag7c9AC6DIqAEiuAm8rinZpoSKgkzVmH6Jickdd3/MSabpu9BnKSe/vOaI=
X-Received: by 2002:a05:6e02:1a09:b0:42f:946f:8eb6 with SMTP id
 e9e14a558f8ab-42f946f905bmr187383395ab.26.1760386442986; Mon, 13 Oct 2025
 13:14:02 -0700 (PDT)
MIME-Version: 1.0
References: <20251011232404.561024-1-vsementsov@yandex-team.ru>
 <20251011232404.561024-11-vsementsov@yandex-team.ru>
In-Reply-To: <20251011232404.561024-11-vsementsov@yandex-team.ru>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Mon, 13 Oct 2025 16:13:52 -0400
X-Gm-Features: AS18NWAMmmTfr6x-LW2doMpeCuNR9m77h3naQmGfLkNaIBAm6uPFL7A3jC-LqMw
Message-ID: <CAFubqFuuBbuoSjofH1XnTrqfi5m_wDuZXN7-Jox82QunBXsFXg@mail.gmail.com>
Subject: Re: [PATCH v2 10/23] vhost: vhost_virtqueue_start(): fix failure path
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: mst@redhat.com, sgarzare@redhat.com, raphael@enfabrica.net, 
 qemu-devel@nongnu.org, yc-core@yandex-team.ru, d-tatianin@yandex-team.ru
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d33;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-io1-xd33.google.com
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

Overall looks good just once comment.

On Sat, Oct 11, 2025 at 7:24=E2=80=AFPM Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> We miss call to unmap in cases when vhost_memory_map() returns
> lenght less than requested (still we consider such cases as an
> error). Let's fix it in vhost_memory_map().
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  hw/virtio/vhost.c | 35 ++++++++++++++++++++++-------------
>  1 file changed, 22 insertions(+), 13 deletions(-)
>
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 773b91c0a0..8031c74e7b 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -453,11 +453,20 @@ static inline void vhost_dev_log_resize(struct vhos=
t_dev *dev, uint64_t size)
>  }
>
>  static void *vhost_memory_map(struct vhost_dev *dev, hwaddr addr,
> -                              hwaddr *plen, bool is_write)
> +                              hwaddr len, bool is_write)
>  {
>      if (!vhost_dev_has_iommu(dev)) {
> -        return address_space_map(dev->vdev->dma_as, addr, plen, is_write=
,
> -                                 MEMTXATTRS_UNSPECIFIED);
> +        hwaddr mapped_len =3D len;
> +        void *res =3D address_space_map(dev->vdev->dma_as, addr, &mapped=
_len,
> +                                      is_write, MEMTXATTRS_UNSPECIFIED);
> +        if (!res) {
> +            return NULL;
> +        }
> +        if (len !=3D mapped_len) {

Should this be:

address_space_unmap(dev->vdev->dma_as, res, mapped_len, is_write,
MEMTXATTRS_UNSPECIFIED);

rather than address_space_unmap(...0,0)?

> +            address_space_unmap(dev->vdev->dma_as, res, mapped_len, 0, 0=
);
> +            return NULL;
> +        }
> +        return res;
>      } else {
>          return (void *)(uintptr_t)addr;
>      }
> @@ -1261,7 +1270,7 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
>      BusState *qbus =3D BUS(qdev_get_parent_bus(DEVICE(vdev)));
>      VirtioBusState *vbus =3D VIRTIO_BUS(qbus);
>      VirtioBusClass *k =3D VIRTIO_BUS_GET_CLASS(vbus);
> -    hwaddr s, l, a;
> +    hwaddr l, a;
>      int r;
>      int vhost_vq_index =3D dev->vhost_ops->vhost_get_vq_index(dev, idx);
>      struct vhost_vring_file file =3D {
> @@ -1301,24 +1310,24 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
>          }
>      }
>
> -    vq->desc_size =3D s =3D l =3D virtio_queue_get_desc_size(vdev, idx);
> +    vq->desc_size =3D l =3D virtio_queue_get_desc_size(vdev, idx);
>      vq->desc_phys =3D a;
> -    vq->desc =3D vhost_memory_map(dev, a, &l, false);
> -    if (!vq->desc || l !=3D s) {
> +    vq->desc =3D vhost_memory_map(dev, a, l, false);
> +    if (!vq->desc) {
>          r =3D -ENOMEM;
>          goto fail_alloc_desc;
>      }
> -    vq->avail_size =3D s =3D l =3D virtio_queue_get_avail_size(vdev, idx=
);
> +    vq->avail_size =3D l =3D virtio_queue_get_avail_size(vdev, idx);
>      vq->avail_phys =3D a =3D virtio_queue_get_avail_addr(vdev, idx);
> -    vq->avail =3D vhost_memory_map(dev, a, &l, false);
> -    if (!vq->avail || l !=3D s) {
> +    vq->avail =3D vhost_memory_map(dev, a, l, false);
> +    if (!vq->avail) {
>          r =3D -ENOMEM;
>          goto fail_alloc_avail;
>      }
> -    vq->used_size =3D s =3D l =3D virtio_queue_get_used_size(vdev, idx);
> +    vq->used_size =3D l =3D virtio_queue_get_used_size(vdev, idx);
>      vq->used_phys =3D a =3D virtio_queue_get_used_addr(vdev, idx);
> -    vq->used =3D vhost_memory_map(dev, a, &l, true);
> -    if (!vq->used || l !=3D s) {
> +    vq->used =3D vhost_memory_map(dev, a, l, true);
> +    if (!vq->used) {
>          r =3D -ENOMEM;
>          goto fail_alloc_used;
>      }
> --
> 2.48.1
>

