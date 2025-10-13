Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 548D3CCD185
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 20:24:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8P5H-0007Zn-CT; Mon, 13 Oct 2025 16:23:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1v8P5F-0007Zf-GA
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 16:23:53 -0400
Received: from mail-il1-x12f.google.com ([2607:f8b0:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1v8P5D-0001Su-Oe
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 16:23:53 -0400
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-42f9353c810so18420465ab.0
 for <qemu-devel@nongnu.org>; Mon, 13 Oct 2025 13:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760387029; x=1760991829; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qGRn/kV2ubzwgczNU2l2OI2PoLDD3KOX/uj2JSesERc=;
 b=Qu0FW6qZQfMG5p+YsHRx1E6f0w08YWn/xyHuR+JsC8ZiQzfvkI0OHCGBvHpdz3cW5m
 0i3dq+VNC4TV7tXa65XHRfKt866R7mD2u8+p6E6vrQuvizOunn6uDQqTsuvRlglBH5My
 Izy4pp9grczh1v4JCfvyDdxvn785GAoXUSdFRnGwGMAVhttduiDA68RW/qalzmLiIzjw
 0hqdCq0LA2PlJHOaYsqfhvNeDdOtfA64D3xAApS5Ssyl2/jpp/8pEVWnvO8GYHW6vnYv
 +oOhpceuQlWTmjNXHE0Mza3S5tPHIm9zFR0EsYN7jVm1CpE4stqFLNL4FmkvyUx4e00O
 mwPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760387029; x=1760991829;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qGRn/kV2ubzwgczNU2l2OI2PoLDD3KOX/uj2JSesERc=;
 b=Sln/4Nx11qebRZZZj1C1a07nFoNHMwb/gf4EO/NCtnnYvmQ4UP0V01fLADicNDirb+
 MAxNXGtRYoj50bTOkgzNL7a9ynob6dhcYZxNKeJywfxmbuzW6TZ6owprk8WFzMnLRodW
 crLegU1U2Ae6Z/wdXQ6YAXrKAwAKiD7zAuIjQPbK1WVLF+xAhyelA/gSHUvo637cYSEs
 2zLEq8SoBpUtZL8uNYd5aWgDzSTHhmXeLFTTk0573gS/FiwRaWDTtfMGsYJN/L4DXQxA
 PVHTLqATbjuvoAetA2N2WVQBmHn7iXhY73ek9tFTQcVTDE3L6tMN+aPPYjXcEAE4m7sT
 RRSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHz1CljkQ9OyVUdGYLNV8Zm7ZXURPFnVHBec9sym5PKhr4WsWUieMPZLvOa7YD94U1PvuucoFoaSqW@nongnu.org
X-Gm-Message-State: AOJu0YxXL6jCSAx/b8ClIRqqgSF4je3X9/K9kQjGOVoSVePa52VguYHG
 k01RlvjBK4HjXTEDmvizj2GzD9ANZ5+MG8tVivOVcbNNVqq0lR2GOHMDmpS4pMdKk7xEdlTcaCG
 bP4nj0xheypCeI+QYFITFBBwlJRYnL28=
X-Gm-Gg: ASbGncui1eToxhN51btA9tz3uDIj/Xq/fUcrhMs2Rluj0hRYRhh1bdx9SRFkjb156Du
 CfNg+xgfs3hlkeIuRRmRQ/g0oRSaWNXvYpaW6jyoenzNitZZpWF3XT3MoqFC0pZsui199tslHW5
 ACa9dceQ/2kunsd2RuCvdNqRf6JqZWv1LJgAfp0Tzc1y0KjQi0SQAugCqneWiQNzdTv/V+ErsCq
 UrvEW5D52D4EHQHjMzPU5vprg==
X-Google-Smtp-Source: AGHT+IGWsPWls+AozL+EC1xNeU5aCvV6IgdYIdgb4J+IpwD7Fp73kgCmqXtq6KmY+GkyNieepMPfc9aQY18ii6d4EoI=
X-Received: by 2002:a05:6e02:194d:b0:42f:9db5:26d0 with SMTP id
 e9e14a558f8ab-42f9db52b1cmr129501885ab.1.1760387029242; Mon, 13 Oct 2025
 13:23:49 -0700 (PDT)
MIME-Version: 1.0
References: <20251011232404.561024-1-vsementsov@yandex-team.ru>
 <20251011232404.561024-12-vsementsov@yandex-team.ru>
In-Reply-To: <20251011232404.561024-12-vsementsov@yandex-team.ru>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Mon, 13 Oct 2025 16:23:38 -0400
X-Gm-Features: AS18NWCC5QhKpNL8vGPqb_Qn-VkeK1pQTn7xaZZmBBnJKf2clcBoa3bnbVtZK6s
Message-ID: <CAFubqFuPWHqVsd23VEe8ai9D=tivq9N8=98YX8MNAxABHn3sjA@mail.gmail.com>
Subject: Re: [PATCH v2 11/23] vhost: make vhost_memory_unmap() null-safe
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: mst@redhat.com, sgarzare@redhat.com, raphael@enfabrica.net, 
 qemu-devel@nongnu.org, yc-core@yandex-team.ru, d-tatianin@yandex-team.ru
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::12f;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-il1-x12f.google.com
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

On Sat, Oct 11, 2025 at 7:24=E2=80=AFPM Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> This helps to simplify failure paths of vhost_virtqueue_start()
> a lot. We also need to zero-out pointers on unmap, to not try
> to unmap invalid pointers.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  hw/virtio/vhost.c | 41 +++++++++++++++++++++--------------------
>  1 file changed, 21 insertions(+), 20 deletions(-)
>
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 8031c74e7b..6fec193d5f 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -472,14 +472,20 @@ static void *vhost_memory_map(struct vhost_dev *dev=
, hwaddr addr,
>      }
>  }
>
> -static void vhost_memory_unmap(struct vhost_dev *dev, void *buffer,
> +static void vhost_memory_unmap(struct vhost_dev *dev, void **buffer,
>                                 hwaddr len, int is_write,
>                                 hwaddr access_len)
>  {
> +    if (!*buffer) {
> +        return;
> +    }
> +
>      if (!vhost_dev_has_iommu(dev)) {
> -        address_space_unmap(dev->vdev->dma_as, buffer, len, is_write,
> +        address_space_unmap(dev->vdev->dma_as, *buffer, len, is_write,
>                              access_len);
>      }
> +
> +    *buffer =3D NULL;
>  }
>
>  static int vhost_verify_ring_part_mapping(void *ring_hva,
> @@ -1315,33 +1321,33 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
>      vq->desc =3D vhost_memory_map(dev, a, l, false);
>      if (!vq->desc) {
>          r =3D -ENOMEM;
> -        goto fail_alloc_desc;
> +        goto fail;
>      }
>      vq->avail_size =3D l =3D virtio_queue_get_avail_size(vdev, idx);
>      vq->avail_phys =3D a =3D virtio_queue_get_avail_addr(vdev, idx);
>      vq->avail =3D vhost_memory_map(dev, a, l, false);
>      if (!vq->avail) {
>          r =3D -ENOMEM;
> -        goto fail_alloc_avail;
> +        goto fail;
>      }
>      vq->used_size =3D l =3D virtio_queue_get_used_size(vdev, idx);
>      vq->used_phys =3D a =3D virtio_queue_get_used_addr(vdev, idx);
>      vq->used =3D vhost_memory_map(dev, a, l, true);
>      if (!vq->used) {
>          r =3D -ENOMEM;
> -        goto fail_alloc_used;
> +        goto fail;
>      }
>
>      r =3D vhost_virtqueue_set_addr(dev, vq, vhost_vq_index, dev->log_ena=
bled);
>      if (r < 0) {
> -        goto fail_alloc;
> +        goto fail;
>      }
>
>      file.fd =3D event_notifier_get_fd(virtio_queue_get_host_notifier(vvq=
));
>      r =3D dev->vhost_ops->vhost_set_vring_kick(dev, &file);
>      if (r) {
>          VHOST_OPS_DEBUG(r, "vhost_set_vring_kick failed");
> -        goto fail_kick;
> +        goto fail;
>      }
>
>      /* Clear and discard previous events if any. */
> @@ -1361,24 +1367,19 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
>          file.fd =3D -1;
>          r =3D dev->vhost_ops->vhost_set_vring_call(dev, &file);
>          if (r) {
> -            goto fail_vector;
> +            goto fail;
>          }
>      }
>
>      return 0;
>
> -fail_vector:
> -fail_kick:
> -fail_alloc:
> -    vhost_memory_unmap(dev, vq->used, virtio_queue_get_used_size(vdev, i=
dx),
> +fail:
> +    vhost_memory_unmap(dev, &vq->used, virtio_queue_get_used_size(vdev, =
idx),
>                         0, 0);
> -fail_alloc_used:
> -    vhost_memory_unmap(dev, vq->avail, virtio_queue_get_avail_size(vdev,=
 idx),
> +    vhost_memory_unmap(dev, &vq->avail, virtio_queue_get_avail_size(vdev=
, idx),
>                         0, 0);
> -fail_alloc_avail:
> -    vhost_memory_unmap(dev, vq->desc, virtio_queue_get_desc_size(vdev, i=
dx),
> +    vhost_memory_unmap(dev, &vq->desc, virtio_queue_get_desc_size(vdev, =
idx),
>                         0, 0);
> -fail_alloc_desc:
>      return r;
>  }
>
> @@ -1425,11 +1426,11 @@ static int do_vhost_virtqueue_stop(struct vhost_d=
ev *dev,
>                                                  vhost_vq_index);
>      }
>
> -    vhost_memory_unmap(dev, vq->used, virtio_queue_get_used_size(vdev, i=
dx),
> +    vhost_memory_unmap(dev, &vq->used, virtio_queue_get_used_size(vdev, =
idx),
>                         1, virtio_queue_get_used_size(vdev, idx));
> -    vhost_memory_unmap(dev, vq->avail, virtio_queue_get_avail_size(vdev,=
 idx),
> +    vhost_memory_unmap(dev, &vq->avail, virtio_queue_get_avail_size(vdev=
, idx),
>                         0, virtio_queue_get_avail_size(vdev, idx));
> -    vhost_memory_unmap(dev, vq->desc, virtio_queue_get_desc_size(vdev, i=
dx),
> +    vhost_memory_unmap(dev, &vq->desc, virtio_queue_get_desc_size(vdev, =
idx),
>                         0, virtio_queue_get_desc_size(vdev, idx));
>      return r;
>  }
> --
> 2.48.1
>

