Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE252CCD183
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 19:02:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6vtx-0004gq-AD; Thu, 09 Oct 2025 15:02:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1v6vtv-0004gI-Hr
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 15:02:07 -0400
Received: from mail-io1-xd2a.google.com ([2607:f8b0:4864:20::d2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1v6vtr-0006m9-Ru
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 15:02:06 -0400
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-92aee734585so50939039f.3
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 12:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760036522; x=1760641322; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DNmAlGlHKdAsP+3VdtI8g+Hpoc+y4dVZly3cQCqKXNI=;
 b=YENoc4sqTzCf2+/CjePY5U0MyfaPJh/7PClk7W2LVU/kn0Mgxj9d+HT5Kk9mY9vMXp
 IXG0ublqSyZih0+VTt6KxfA2BDuickx6vtcvV/cmuzt28RoDKlgTkQ+ZhSDsn4BfvdhZ
 hfOTgyldEtRgN8WEHWQdQ7YzQD17QsGBhQmob80WWS1lwkbl+QuqKO4Ige8XzUHu1+Jh
 ktiheO309r48gAJ5dhqWkboqhAUa9F06VEhsPXYVCOjj+MFJVvyphzt+sAuKac10nAWk
 sO5paCxNH2GHNd39v0psJn3IFYhusrdW2iDQikCRLP/tZQf6aeCkTpmMTh01dp9OKsTm
 RU8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760036522; x=1760641322;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DNmAlGlHKdAsP+3VdtI8g+Hpoc+y4dVZly3cQCqKXNI=;
 b=gktXbDLT4qZsf4QY4QVSRkK55TlD69V+bRmobdegCHD3d8AgPLXQPycLBKx1akkkaE
 BtAjVs/P6Nys2KjogLetJWN6FjT3Ae5TmeNPOLZy9xk+it7MMv1od919lKOaBe8ErxsH
 2KX/4280KSh0aCeiQF7ve/0A8WrjpM6rWN7JRWRUKUWDt+fhONmq728FufAF+vmDTf2m
 2H1iVTI3yje6owj4Uk1v7crrS41W4BxxlwJDAlP9w2NRrc7/q5j7UYJjCmR71AiNkaUr
 V1DDnMIeeJ89iahJFOHYRD8EogurDwES/M2B4Yc+O0W5KkeAUa04+750QrYhX3GwHGCf
 5a5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWX8Mfu6GJokqZecWInrAE6nJ5lipXCqVCC5nC8ka8fXZ2IiJRCl4hca3Oyz/6iiYIx54+LFR8xE58I@nongnu.org
X-Gm-Message-State: AOJu0YzZlWujtChPbeFlw9GzVjSKKIxC9mHt4t/9V3Og7R8IoJDqUeTQ
 3IjvOkuE2LtwYt9B4IRqQGNSPUo7wJ+5bjG4B22/xICt+lsi/81aJQHnjUzLkCva+AsVPbHSLKZ
 oudbEvNFVT9+JSYIXxyHyIRMe7pMsvqY=
X-Gm-Gg: ASbGncuR2bAQBPLsmI6ypvjdUKkN5cgEMxUJLWiO1cabuPWOZjj2b/IVfx/GWMGT788
 vc777keEmjP53ThM4+EK+BZ2Hy8my8lMQSXKRFkfVDgu/rFlc8XO5zmCh+r3H1EnlajnIZwFiP5
 WwoKUtTNoHj25SF8YWt3ts1gkQJk/LU8go3vk+FYH7KhDbHJ1CfL4Fcw1MD7DKzD34kpA7+jBQO
 X9Mjd7rZzR4vCIkE1uWVmVnCvcnWneAODPRtVmNtA==
X-Google-Smtp-Source: AGHT+IEF9q3QKZWY1yk9eDzw9xN0J1ywBw18mzoOfkFHPL07YRV+YG/VaoEVmDnONbYYKyZ0qVSa3Sz16v/ngfH31IQ=
X-Received: by 2002:a05:6602:26c5:b0:887:574d:dfbb with SMTP id
 ca18e2360f4ac-93bd1987f13mr963402339f.11.1760036522101; Thu, 09 Oct 2025
 12:02:02 -0700 (PDT)
MIME-Version: 1.0
References: <20250813164856.950363-1-vsementsov@yandex-team.ru>
 <20250813164856.950363-14-vsementsov@yandex-team.ru>
In-Reply-To: <20250813164856.950363-14-vsementsov@yandex-team.ru>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Thu, 9 Oct 2025 15:01:49 -0400
X-Gm-Features: AS18NWDqJxKTO4-89wvju966bINbIH9aTw2GPWuZH5ucuJegFXBb7wzRbJXiXAs
Message-ID: <CAFubqFuYrQsEnJ35Cj=yVZf9qwbruegyuf=3KGK8nr5AefVvkQ@mail.gmail.com>
Subject: Re: [PATCH 13/33] vhost: move vrings mapping to the top of
 vhost_virtqueue_start()
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: mst@redhat.com, peterx@redhat.com, farosas@suse.de, raphael@enfabrica.net, 
 sgarzare@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com, 
 kwolf@redhat.com, hreitz@redhat.com, berrange@redhat.com, eblake@redhat.com, 
 armbru@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 steven.sistare@oracle.com, den-plotnikov@yandex-team.ru
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d2a;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-io1-xd2a.google.com
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

On Wed, Aug 13, 2025 at 12:52=E2=80=AFPM Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> This simplifies further refactoring and final introduction
> of vhost backend live migration.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  hw/virtio/vhost.c | 47 +++++++++++++++++++++++------------------------
>  1 file changed, 23 insertions(+), 24 deletions(-)
>
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index bc1821eadd..97113174b9 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -1288,30 +1288,6 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
>          /* Queue might not be ready for start */
>          return 0;
>      }
> -
> -    vq->num =3D state.num =3D virtio_queue_get_num(vdev, idx);
> -    r =3D dev->vhost_ops->vhost_set_vring_num(dev, &state);
> -    if (r) {
> -        VHOST_OPS_DEBUG(r, "vhost_set_vring_num failed");
> -        return r;
> -    }
> -
> -    state.num =3D virtio_queue_get_last_avail_idx(vdev, idx);
> -    r =3D dev->vhost_ops->vhost_set_vring_base(dev, &state);
> -    if (r) {
> -        VHOST_OPS_DEBUG(r, "vhost_set_vring_base failed");
> -        return r;
> -    }
> -
> -    if (vhost_needs_vring_endian(vdev)) {
> -        r =3D vhost_virtqueue_set_vring_endian_legacy(dev,
> -                                                    virtio_is_big_endian=
(vdev),
> -                                                    vhost_vq_index);
> -        if (r) {
> -            return r;
> -        }
> -    }
> -
>      vq->desc_size =3D l =3D virtio_queue_get_desc_size(vdev, idx);
>      vq->desc_phys =3D a;
>      vq->desc =3D vhost_memory_map(dev, a, l, false);
> @@ -1334,6 +1310,29 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
>          goto fail;
>      }
>
> +    vq->num =3D state.num =3D virtio_queue_get_num(vdev, idx);
> +    r =3D dev->vhost_ops->vhost_set_vring_num(dev, &state);
> +    if (r) {
> +        VHOST_OPS_DEBUG(r, "vhost_set_vring_num failed");
> +        goto fail;
> +    }
> +
> +    state.num =3D virtio_queue_get_last_avail_idx(vdev, idx);
> +    r =3D dev->vhost_ops->vhost_set_vring_base(dev, &state);
> +    if (r) {
> +        VHOST_OPS_DEBUG(r, "vhost_set_vring_base failed");
> +        goto fail;
> +    }
> +
> +    if (vhost_needs_vring_endian(vdev)) {
> +        r =3D vhost_virtqueue_set_vring_endian_legacy(dev,
> +                                                    virtio_is_big_endian=
(vdev),
> +                                                    vhost_vq_index);
> +        if (r) {
> +            goto fail;
> +        }
> +    }
> +
>      r =3D vhost_virtqueue_set_addr(dev, vq, vhost_vq_index, dev->log_ena=
bled);
>      if (r < 0) {
>          goto fail;
> --
> 2.48.1
>
>

