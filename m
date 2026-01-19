Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54173D2ECF5
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 23:50:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhz0x-0007Df-F6; Mon, 19 Jan 2026 18:50:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1vhz0l-0006wm-CL
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 18:50:21 -0500
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1vhz0j-0005Yq-5C
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 18:50:18 -0500
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-40418578e28so1762463fac.1
 for <qemu-devel@nongnu.org>; Mon, 19 Jan 2026 15:50:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768866615; cv=none;
 d=google.com; s=arc-20240605;
 b=SzoLqhUf8nZ8un4rqJGKh1+OIfBKW+NeqgOCmCc8VV0BtU0gBa1mc7Hz1B8MQJxO/7
 3ew8Bof2/7L2ZI24sFzwrlHZfVEicODnuVqgHy5OV3WmsRGgi6SFyU9Tx0zuYPPZ8xl8
 xKWBvFxSAOOtWeBXUyYfk8ssK8k4orqOT6GaeoZDfCqBkSt6YC70AIED6n+HQo7blGs0
 IKp8KqCK8bO4ZYekDlmxsD0PuFo0NIYP4mc2Gu43iK3H4r3vKBP/xIPxfacPcLKLz2by
 b4goZbfibEOmPdheMioMQk9pSqM3Qtfzx5mWfuJf7Fx82FQvDjxhBWFiF4IP+QMZlJHv
 ceBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=n2emQqz3DGz/4eC+tspuCzbvNqFJQ7T4yhGPMQj45Ig=;
 fh=svEAy46AT1kXPMPru3+Pi3qVa0SEH2oG99PC61HTRBo=;
 b=HPz18cV4wwtwIQSvNalyiuth0JEG/9hpBjSNeSjSCQsQYqch8hOoEn3hDQ3JFKHB7B
 bNIIvyQfnthENPngxuydPT9jpbzxZb+fltVEUNLAY7y2bhqg6l0BH12cbVkVQ9aJPp8W
 nudaPKqxre3VdcYQMsUowAqI/To+vhCXuDA9CabzBfyMJOVceymV0N2OX1LxCw4bbpD+
 NUTBKv0pG7WG92pC+ISEQUc9WCgHKgR+xbLXolKo11iwm8p7ghmZIkujn4Qu56DDPAxh
 L3LFKaOslwaTRoUJgUD5NrK3DDh9Wp+leCVGvMdNqg10WxxEYXbxm6SLj/goO7sOPYE7
 ZS6Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768866615; x=1769471415; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n2emQqz3DGz/4eC+tspuCzbvNqFJQ7T4yhGPMQj45Ig=;
 b=Ji3bCVNIRKKPtpdMZXzuposi6ZSRakjI6LUtNpsSyioUh3tXg4bPvN48IXJaG2H7X2
 BFw2Qs91s9qulvJwtYrzVBVyWHgu4k2b6DBq3hdmHZAE3LLXU/s4zSXRiGQyAmTjC0PA
 j4hgjuJ3ZyiCxyLiHFqDVkdrd9qKfbxydpCskuFiDLf0nQI1Yp0w6eAKpOONw4t7p9ZW
 qhdeArbEhtL/3NwFIOxORVvrIFrdX7aCgU0qx2hj0gfUjNSTJDDievNIs8D3R1lrSJuT
 fM38xHR5tSIJuNkHdmkcdQNiAsUCLQTKx8iIGol+NUJ/ub2q2051E89oBiXiCFfzRomf
 6fzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768866615; x=1769471415;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=n2emQqz3DGz/4eC+tspuCzbvNqFJQ7T4yhGPMQj45Ig=;
 b=h25ApyVF0gWdUQKnbac4/MwPiXgudqinIFUwHB18/FovK2DaBils+fNL1iEH2SRIi+
 SLe2Kh+jnCSc/+rSLWsHzRbjhX42Q/COeyA5DsvR2or7Yf1Avnjno+Iz0dakHmUK8IrG
 l5ymOz+Py0FimbTUkV3X/QNj+nlDKNXctWGiNrHirNdlwwCVTyZiwZRvwR7y194Gsguf
 t4bn+Mbtcfd68nJ5/mqJCRMIrMwY8F1flBlsZCnlFwhj3wOMNqMgXDi0VYn3BM3pYwpX
 1ylrxhGJKzHc15G4Yqsl+6R7P6KhIMotjwSt6tMBcwruL1jgxg0mOXqARrkcjxb0M55u
 pqDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOVBwj9nOj4JKRXq+kcnraja37d5uXHtzJgOqjCNhTTfeW+/pvCsqyrqejJMsNXtogOLzThzxN/zk1@nongnu.org
X-Gm-Message-State: AOJu0YznVrwT2lNQXDEzS8jH5W5HUxaCDThQHGh9Mh1FBpoYbUBS9L9v
 plMyQLa3T3CuU8b26ojRTCxrCEa4+ygoQ8rB+psO2Q7cFfGFb+1HqRmqezUuRxB7qeKdx7INSvK
 cKTwHwjkaVWuat6I/Sepqdnk4aUsqRsI=
X-Gm-Gg: AY/fxX48ql2rYL1eARC94h2P6IzaP2fLU42qHTakv3abr5qzcvlo7cKVlS6gP+uL9VY
 RL8oTVPhPg1Xeqd+8Hn3qCaToPwUeIaxZcb7K5banNe1MRBon+W58wnj4FSeQuQdUXM5jkXP6JU
 wWiskMFVl/zdZN+2kWqZlSkcdVFqJ1lRN58sjBlKPv1pC2N1CyQDt/X0L64Ty4NlZKQIyuc96qr
 m29QpI7ci0s3r3BkZNB42iaBnFJ3lyiDr0dVhuTZ+mDQlo5oMUIAAD1IX9Dyk/P5pP91lBkVVO/
 j/DR9TRS1fjigG5nZXNJopFo5xQ=
X-Received: by 2002:a05:6820:821:b0:65c:fa23:2d00 with SMTP id
 006d021491bc7-66118887145mr4437895eaf.9.1768866614762; Mon, 19 Jan 2026
 15:50:14 -0800 (PST)
MIME-Version: 1.0
References: <20260119185228.203296-1-vsementsov@yandex-team.ru>
 <20260119185228.203296-17-vsementsov@yandex-team.ru>
In-Reply-To: <20260119185228.203296-17-vsementsov@yandex-team.ru>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Mon, 19 Jan 2026 18:50:03 -0500
X-Gm-Features: AZwV_QhJibfX1z2QKO39kZqYmkdhFNmp_Es2VIAu9EvDz6oBLkcKlF3zZYxmBzE
Message-ID: <CAFubqFuME3umgZCvJZ+f7LadxUe_HzghEa22W9JZo4LnJgCuuw@mail.gmail.com>
Subject: Re: [PATCH v4 16/23] vhost: final refactoring of vhost vrings
 map/unmap
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: mst@redhat.com, sgarzare@redhat.com, raphael@enfabrica.net, 
 qemu-devel@nongnu.org, yc-core@yandex-team.ru, d-tatianin@yandex-team.ru
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2001:4860:4864:20::31;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-oa1-x31.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
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

On Mon, Jan 19, 2026 at 1:55=E2=80=AFPM Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> Introduce helper functions vhost_vrings_map() and
> vhost_vrings_unmap() and use them.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  hw/virtio/vhost.c | 89 +++++++++++++++++++++++++++++------------------
>  1 file changed, 55 insertions(+), 34 deletions(-)
>
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 653cb706cc..7efdc4643d 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -489,6 +489,56 @@ static void vhost_memory_unmap(struct vhost_dev *dev=
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
> +    vq->desc_size =3D virtio_queue_get_desc_size(vdev, idx);
> +    vq->desc_phys =3D virtio_queue_get_desc_addr(vdev, idx);
> +    vq->desc =3D NULL;
> +    vq->avail_size =3D virtio_queue_get_avail_size(vdev, idx);
> +    vq->avail_phys =3D virtio_queue_get_avail_addr(vdev, idx);
> +    vq->avail =3D NULL;
> +    vq->used_size =3D virtio_queue_get_used_size(vdev, idx);
> +    vq->used_phys =3D virtio_queue_get_used_addr(vdev, idx);
> +    vq->used =3D NULL;
> +
> +    if (vq->desc_phys =3D=3D 0) {
> +        /* Queue might not be ready for start */
> +        return 0;
> +    }
> +    vq->desc =3D vhost_memory_map(dev, vq->desc_phys, vq->desc_size, fal=
se);
> +    if (!vq->desc) {
> +        goto fail;
> +    }
> +    vq->avail =3D vhost_memory_map(dev, vq->avail_phys, vq->avail_size, =
false);
> +    if (!vq->avail) {
> +        goto fail;
> +    }
> +    vq->used =3D vhost_memory_map(dev, vq->used_phys, vq->used_size, tru=
e);
> +    if (!vq->used) {
> +        goto fail;
> +    }
> +
> +    return 1;
> +
> +fail:
> +    vhost_vrings_unmap(dev, vq, false);
> +    return -ENOMEM;
> +}
> +
>  static int vhost_verify_ring_part_mapping(void *ring_hva,
>                                            uint64_t ring_gpa,
>                                            uint64_t ring_size,
> @@ -1287,34 +1337,9 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
>      };
>      struct VirtQueue *vvq =3D virtio_get_queue(vdev, idx);
>
> -    vq->desc_size =3D virtio_queue_get_desc_size(vdev, idx);
> -    vq->desc_phys =3D virtio_queue_get_desc_addr(vdev, idx);
> -    vq->desc =3D NULL;
> -    vq->avail_size =3D virtio_queue_get_avail_size(vdev, idx);
> -    vq->avail_phys =3D virtio_queue_get_avail_addr(vdev, idx);
> -    vq->avail =3D NULL;
> -    vq->used_size =3D virtio_queue_get_used_size(vdev, idx);
> -    vq->used_phys =3D virtio_queue_get_used_addr(vdev, idx);
> -    vq->used =3D NULL;
> -
> -    if (vq->desc_phys =3D=3D 0) {
> -        /* Queue might not be ready for start */
> -        return 0;
> -    }
> -    vq->desc =3D vhost_memory_map(dev, vq->desc_phys, vq->desc_size, fal=
se);
> -    if (!vq->desc) {
> -        r =3D -ENOMEM;
> -        goto fail;
> -    }
> -    vq->avail =3D vhost_memory_map(dev, vq->avail_phys, vq->avail_size, =
false);
> -    if (!vq->avail) {
> -        r =3D -ENOMEM;
> -        goto fail;
> -    }
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
> @@ -1376,9 +1401,7 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
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
> @@ -1425,9 +1448,7 @@ static int do_vhost_virtqueue_stop(struct vhost_dev=
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
> 2.52.0
>
>

