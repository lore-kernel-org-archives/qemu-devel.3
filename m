Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07A62CCD184
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 19:03:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6vus-0005eo-2Z; Thu, 09 Oct 2025 15:03:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1v6vup-0005dK-77
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 15:03:03 -0400
Received: from mail-io1-xd30.google.com ([2607:f8b0:4864:20::d30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1v6vul-0006oc-PW
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 15:03:02 -0400
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-92b92e4b078so54492839f.0
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 12:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760036578; x=1760641378; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q7ISF1Zio3LRktd7VytfLR6ITcBjsQ/w8Wi0n94pHTw=;
 b=O45AawKoKX/hEXY5iBbV0HW4YNc/tFOmI7j3PU32BgyxBmut0CstI7thSRh96JZDKZ
 bWKhR1RaU223mMDrBbQicq340G8borZERmBDTLmmXjJAoPaipuHpUeNTcUNBlKHqRLW0
 +5X9ELPT7XiKW73jC0VF8+TuO/2NNsV1L61OfWZhr/FCnC6k3BWy56kWx7gIEVgrdNHJ
 WZ1XwDjjnBDzU3cSEhzPeHK/Pp7Wldd2CMiCLFH5Tle7QsSFI5luKuQQaGuuNxpBNIVZ
 /GvKklVivePba8iDd3/m41aZc8u3dIZ7dFj1NPW+Nb5wtGq20PqHjh9E+Upgc5igLwfT
 gdEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760036578; x=1760641378;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q7ISF1Zio3LRktd7VytfLR6ITcBjsQ/w8Wi0n94pHTw=;
 b=N/345tcIpBMN2q5NH8ipBn248RKIJjKag3GDu1wj4Hooh2WtUSSpHnWbhZrLl04PoK
 eW0ElRi5omkYPVPkaGlmfxZFRN8///q465gCR/LrC2L3IZCZh4rYimUZV0vySz6szSxJ
 K0lm2FXvQ3bN/5CcNux99tX+wdvNKlT9GVtqTtnwUBEFSMvGG3Q9cfgVozifTN8VHOS8
 wFRvYRMQ+MxeLhOP90cyXM8CfnGtMGtN9TZUC/6TmDtKbPlkAhf2jm+5uJpM8LDdQlq8
 buRPNc0jnZKoiTuPNQOW3H55rGkdKbZoHdt7Eg6lAOPgyjluKBqQ6j9Vp8mhgAnnk7dJ
 HXlQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlfUf37HTCSKs91GrzRS+I3p+mv94r+GEP8hJhMnC1a3xu132g7dN5n9RcT+DwEpoWQ+PkZKQ2sTu/@nongnu.org
X-Gm-Message-State: AOJu0Ywq0dQowh1N/x6BSgz5QPHK5NZiHiPtXROKZkTvQC5xm4Wwh4ex
 9DueWoE3ysgsKK1qd8g7jcmJBU1Rq48g/pZNH1kPaSawrwlKu9hgMmmbx68cxbepPZM4/0ZV4g3
 szsSAqVgx3gryG/ItQ7tnnuySbjdz7jE=
X-Gm-Gg: ASbGncsxiaovi9BlbOIUAZD5CYHS8xmmBss70tg56HK0ySOKp1s2HJ4hxjIp/u/i2uo
 avKm3EN9+MgqnS/SpTupAw0azuIwiPdXGH0gmeLh6cR7Z2UUP8zafWCR+ocftyGczG9n4pzVQLG
 y4/cWSWDyFIK/eap62F1X/uRnz0SslpcKS1ZpVx+jIqfEhTa3qtf3vJxep2nFslaNjoTYGE6Egl
 1G+RfozsnJBTgwunyEfraUGDiZJRSHdP8Z8nDxpjA==
X-Google-Smtp-Source: AGHT+IEpBAdyPRW2Ghhr0FzyRnAjELIEQB2bgmvo3U/YiAvBVWyxagqkqExJHSfAo46WGAjwNOa4nd5fXHn+/vC5Jwo=
X-Received: by 2002:a05:6e02:12cb:b0:42e:7589:6290 with SMTP id
 e9e14a558f8ab-42f87377de2mr84232745ab.12.1760036575266; Thu, 09 Oct 2025
 12:02:55 -0700 (PDT)
MIME-Version: 1.0
References: <20250813164856.950363-1-vsementsov@yandex-team.ru>
 <20250813164856.950363-16-vsementsov@yandex-team.ru>
In-Reply-To: <20250813164856.950363-16-vsementsov@yandex-team.ru>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Thu, 9 Oct 2025 15:02:44 -0400
X-Gm-Features: AS18NWDjaip0rSWC-CYlG5sDhQE6HIIeOh4vDTMucUiekpvrBDRBG2om2RK6wrs
Message-ID: <CAFubqFt+sUt9aDfD6nXYEgdOs4HZkQZCK_GxtZ=E_WgEO8F58w@mail.gmail.com>
Subject: Re: [PATCH 15/33] vhost: final refactoring of vhost vrings map/unmap
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: mst@redhat.com, peterx@redhat.com, farosas@suse.de, raphael@enfabrica.net, 
 sgarzare@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com, 
 kwolf@redhat.com, hreitz@redhat.com, berrange@redhat.com, eblake@redhat.com, 
 armbru@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 steven.sistare@oracle.com, den-plotnikov@yandex-team.ru
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d30;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-io1-xd30.google.com
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

I=E2=80=99m happy with factoring out these helpers. My only concern is the =
one
around vq->{used, avail, desc} being nulled out in patch 11/33.

On Wed, Aug 13, 2025 at 12:51=E2=80=AFPM Vladimir Sementsov-Ogievskiy
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
> index c76e2dbb4e..f6ee59425f 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -498,6 +498,53 @@ static void vhost_memory_unmap(struct vhost_dev *dev=
, void *buffer,
>      }
>  }
>
> +static void vhost_vrings_unmap(struct vhost_dev *dev,
> +                               struct vhost_virtqueue *vq, bool touched)
> +{
> +    vhost_memory_unmap(dev, vq->used, vq->used_size, touched,
> +                       touched ? vq->used_size : 0);
> +    vhost_memory_unmap(dev, vq->avail, vq->avail_size, 0,
> +                       touched ? vq->avail_size : 0);
> +    vhost_memory_unmap(dev, vq->desc, vq->desc_size, 0,
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
> @@ -1282,30 +1329,9 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
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
> @@ -1367,9 +1393,7 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
>      return 0;
>
>  fail:
> -    vhost_memory_unmap(dev, vq->used, vq->used_size, 0, 0);
> -    vhost_memory_unmap(dev, vq->avail, vq->avail_size, 0, 0);
> -    vhost_memory_unmap(dev, vq->desc, vq->desc_size, 0, 0);
> +    vhost_vrings_unmap(dev, vq, false);
>      return r;
>  }
>
> @@ -1416,9 +1440,7 @@ static int do_vhost_virtqueue_stop(struct vhost_dev=
 *dev,
>                                                  vhost_vq_index);
>      }
>
> -    vhost_memory_unmap(dev, vq->used, vq->used_size, 1, vq->used_size);
> -    vhost_memory_unmap(dev, vq->avail, vq->avail_size, 0, vq->avail_size=
);
> -    vhost_memory_unmap(dev, vq->desc, vq->desc_size, 0, vq->desc_size);
> +    vhost_vrings_unmap(dev, vq, true);
>      return r;
>  }
>
> --
> 2.48.1
>
>

