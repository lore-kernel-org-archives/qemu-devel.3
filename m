Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53C4BCCD183
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 20:40:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8PKY-0002aB-78; Mon, 13 Oct 2025 16:39:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1v8PKW-0002a3-O7
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 16:39:40 -0400
Received: from mail-il1-x12e.google.com ([2607:f8b0:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1v8PKQ-0003Ac-E3
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 16:39:40 -0400
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-43094e0aeaeso12414875ab.2
 for <qemu-devel@nongnu.org>; Mon, 13 Oct 2025 13:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760387973; x=1760992773; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0/8uRY7gZ0GNOKvj9mtMZSptl5iQEplehnmX9nvAKZI=;
 b=m4mZzpmLPI6MJuqWxcWMtD+abFDeWH1zsR6NKOPQRWuy6z2uFtP8lV9FkkEXB/vR9z
 HOQcPt4zmrb1v3V0D5yw298eWeBxgBrBXJEHARDJNne6vFIFdtCOqdkX6zjntRt9nFSR
 h83cvsDaLZg112uFb3WyZJw5RizDB7RnOun7rns/eGSxUqLL6+jJjYoB7SlwAZN+sf0I
 be8g8LmfMyBPTjK/Lu2excSHnqCksb0jzvDdpNrfcI/forgSESFB/JdG+bjmgB+o+dPH
 6xJmg2hnxU7qJeaGDheCLJt0Id61bwy6l997KRPy4qN+Iv0uUJ1lePRD4diMQsX1AOSc
 8biA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760387973; x=1760992773;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0/8uRY7gZ0GNOKvj9mtMZSptl5iQEplehnmX9nvAKZI=;
 b=wXDY8oJ1Gg0z1jWO4IOfaGcRYGJGtgX0L6iaOFc8LsxG3xTynXR1i9261D5kKIoBqs
 l4t3N3uyeppXXLLKAyBYOiFRsYiV8jweiR2CDQ2tChVy8g3HiFneizdDMJKyry4HEGQd
 cdKrVj2qHYspSJ7WRTcoJge/8qpnBx6OuI2q+nyfsN7LFLk8HWgcwMD6ugaZgfK22eI6
 qVsJYCkTAjr2AyCi7KGuuxcXXzHCurxrzOSLDsE4e9Bu3KxBkC8AgKtB/9xS6hwHhnEo
 s1R32u7XuItzy4SoXp6g0Dh2wlCdASd+veVY9r66T6WpdgpBlgtT6YY+WMxd5rAeLPTk
 1Deg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfuTddLGKZLluFMni72cS3lV298F4kMCP76BmODc4S7xgBxGNzpRMXPWqGTeE+8B7gutt6IHcNMwlW@nongnu.org
X-Gm-Message-State: AOJu0Yy7uQtU//+tmWP1Y3jEHGZVY7ev+HNtf3OXv74T5YR19lf78WqB
 a3yC5CNoSXjVeV4+nu+D2XYpEi32lNsPesdStMsQKv0iPhi8WEzPGVSUUaP1J1jRK6pyFaEHxHX
 KLmz9QMBx31F91OzpcDjEghE85zQ2Gwo=
X-Gm-Gg: ASbGncvuCdgUcuXpfPnp2pEsRhHXz+G5a2EkEHUrXjL4IA//2sQR8Pc79uuo+3l1Uus
 TTnu+WSm+hpUiZX8WzYRv7qG4nfS24rFkceDL28eoCOzA7jxCGoax7yxOYGjpRqUoNscizIWmyd
 JGDizxj5zm96+Q2ZMUy+8hdmM2hrmruiSxvHZym6WqMAyDeD/hyafqlICvblQwGUeTehizvkfhV
 ECeDgGTYPeS0Xj5QgY43/ng2NFvpsNfp6ls
X-Google-Smtp-Source: AGHT+IEXKWkmgRlaoSj5BD5oxqnqDtgBTnZuDYkTRU3ih1kOYlrd0tJys6xHPplsS2l8QblzqSCHQAmN7AzWdo3jaZk=
X-Received: by 2002:a05:6e02:b2f:b0:42d:b5d0:1930 with SMTP id
 e9e14a558f8ab-42f873fae6amr233489745ab.23.1760387973098; Mon, 13 Oct 2025
 13:39:33 -0700 (PDT)
MIME-Version: 1.0
References: <20251011232404.561024-1-vsementsov@yandex-team.ru>
 <20251011232404.561024-16-vsementsov@yandex-team.ru>
In-Reply-To: <20251011232404.561024-16-vsementsov@yandex-team.ru>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Mon, 13 Oct 2025 16:39:21 -0400
X-Gm-Features: AS18NWAxU38KXnh1NgBHnKPZDwQHCLsgbC-hfuJesx_Y39V0DMLZYa4dF1MrccA
Message-ID: <CAFubqFsuB4pN4N73gQ3wAUKLOdPZbZooJ76vvN5SiFtRfFw=Vw@mail.gmail.com>
Subject: Re: [PATCH v2 15/23] vhost: final refactoring of vhost vrings
 map/unmap
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: mst@redhat.com, sgarzare@redhat.com, raphael@enfabrica.net, 
 qemu-devel@nongnu.org, yc-core@yandex-team.ru, d-tatianin@yandex-team.ru
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::12e;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-il1-x12e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
> Introduce helper functions vhost_vrings_map() and
> vhost_vrings_unmap() and use them.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  hw/virtio/vhost.c | 82 ++++++++++++++++++++++++++++++-----------------
>  1 file changed, 52 insertions(+), 30 deletions(-)
>
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index cc07450dcb..ebdea096aa 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -488,6 +488,53 @@ static void vhost_memory_unmap(struct vhost_dev *dev=
, void **buffer,
>      *buffer =3D NULL;
>  }
>
> +static void vhost_vrings_unmap(struct vhost_dev *dev,
> +                               struct vhost_virtqueue *vq, bool touched)
> +{
> +    vhost_memory_unmap(dev, &vq->used, vq->used_size, touched,
> +                       touched ? vq->used_size : 0);
> +    vhost_memory_unmap(dev, &vq->avail, vq->avail_size, 0,
> +                       touched ? vq->avail_size : 0);
> +    vhost_memory_unmap(dev, &vq->desc, vq->desc_size, 0,
> +                       touched ? vq->desc_size : 0);
> +}
> +
> +static int vhost_vrings_map(struct vhost_dev *dev,
> +                            struct VirtIODevice *vdev,
> +                            struct vhost_virtqueue *vq,
> +                            unsigned idx)
> +{
> +    vq->desc_phys =3D virtio_queue_get_desc_addr(vdev, idx);
> +    if (vq->desc_phys =3D=3D 0) {
> +        /* Queue might not be ready for start */
> +        return 0;
> +    }
> +    vq->desc_size =3D virtio_queue_get_desc_size(vdev, idx);
> +    vq->desc =3D vhost_memory_map(dev, vq->desc_phys, vq->desc_size, fal=
se);
> +    if (!vq->desc) {
> +        return -ENOMEM;
> +    }
> +
> +    vq->avail_size =3D virtio_queue_get_avail_size(vdev, idx);
> +    vq->avail_phys =3D virtio_queue_get_avail_addr(vdev, idx);
> +    vq->avail =3D vhost_memory_map(dev, vq->avail_phys, vq->avail_size, =
false);
> +    if (!vq->avail) {
> +        goto fail;
> +    }
> +
> +    vq->used_size =3D virtio_queue_get_used_size(vdev, idx);
> +    vq->used_phys =3D virtio_queue_get_used_addr(vdev, idx);
> +    vq->used =3D vhost_memory_map(dev, vq->used_phys, vq->used_size, tru=
e);
> +    if (!vq->used) {
> +        goto fail;
> +    }
> +
> +    return 1;
> +fail:
> +    vhost_vrings_unmap(dev, vq, false);
> +    return -ENOMEM;
> +}
> +
>  static int vhost_verify_ring_part_mapping(void *ring_hva,
>                                            uint64_t ring_gpa,
>                                            uint64_t ring_size,
> @@ -1286,30 +1333,9 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
>      };
>      struct VirtQueue *vvq =3D virtio_get_queue(vdev, idx);
>
> -    vq->desc_phys =3D virtio_queue_get_desc_addr(vdev, idx);
> -    if (vq->desc_phys =3D=3D 0) {
> -        /* Queue might not be ready for start */
> -        return 0;
> -    }
> -    vq->desc_size =3D virtio_queue_get_desc_size(vdev, idx);
> -    vq->desc =3D vhost_memory_map(dev, vq->desc_phys, vq->desc_size, fal=
se);
> -    if (!vq->desc) {
> -        r =3D -ENOMEM;
> -        goto fail;
> -    }
> -    vq->avail_size =3D virtio_queue_get_avail_size(vdev, idx);
> -    vq->avail_phys =3D virtio_queue_get_avail_addr(vdev, idx);
> -    vq->avail =3D vhost_memory_map(dev, vq->avail_phys, vq->avail_size, =
false);
> -    if (!vq->avail) {
> -        r =3D -ENOMEM;
> -        goto fail;
> -    }
> -    vq->used_size =3D virtio_queue_get_used_size(vdev, idx);
> -    vq->used_phys =3D virtio_queue_get_used_addr(vdev, idx);
> -    vq->used =3D vhost_memory_map(dev, vq->used_phys, vq->used_size, tru=
e);
> -    if (!vq->used) {
> -        r =3D -ENOMEM;
> -        goto fail;
> +    r =3D vhost_vrings_map(dev, vdev, vq, idx);
> +    if (r <=3D 0) {
> +        return r;
>      }
>
>      vq->num =3D state.num =3D virtio_queue_get_num(vdev, idx);
> @@ -1371,9 +1397,7 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
>      return 0;
>
>  fail:
> -    vhost_memory_unmap(dev, &vq->used, vq->used_size, 0, 0);
> -    vhost_memory_unmap(dev, &vq->avail, vq->avail_size, 0, 0);
> -    vhost_memory_unmap(dev, &vq->desc, vq->desc_size, 0, 0);
> +    vhost_vrings_unmap(dev, vq, false);
>      return r;
>  }
>
> @@ -1420,9 +1444,7 @@ static int do_vhost_virtqueue_stop(struct vhost_dev=
 *dev,
>                                                  vhost_vq_index);
>      }
>
> -    vhost_memory_unmap(dev, &vq->used, vq->used_size, 1, vq->used_size);
> -    vhost_memory_unmap(dev, &vq->avail, vq->avail_size, 0, vq->avail_siz=
e);
> -    vhost_memory_unmap(dev, &vq->desc, vq->desc_size, 0, vq->desc_size);
> +    vhost_vrings_unmap(dev, vq, true);
>      return r;
>  }
>
> --
> 2.48.1
>

