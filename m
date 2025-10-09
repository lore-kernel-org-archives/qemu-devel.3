Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37312CCD183
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 19:00:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6vsH-0002K1-EW; Thu, 09 Oct 2025 15:00:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1v6vsG-0002IW-Il
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 15:00:24 -0400
Received: from mail-il1-x12e.google.com ([2607:f8b0:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1v6vsB-0006ZK-HG
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 15:00:24 -0400
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-4248b34fc8eso14595115ab.3
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 12:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760036417; x=1760641217; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EOlg8HT1U5B3S81siaXOZ5qGLBUBpn1A1O4NI5MVsY8=;
 b=iVMfuqd0BR9YLSKOVMmDqU6NYcN2GUzR5Xuu7SdaFnGVRjmeE0iWuISVXms6Qf7ewk
 b5E5ulHT+K7pIQR0YAcV2YuJJUse72Ia0HOKL6N4l+X1MAz8UeFPOGgheM9Kyuo2Cpar
 LFik+Er+0dbTBCiH9t08+449yCKoR9NQwiOAvW0b6ItKt7aDxbIhkUmRebS6EenJXIZA
 8FYXA6+vw8RGcIoRgqGcVtR8j34l7HPyspopUZobzJJIxheuOBS4OkmVIkidK8OSLLo5
 9KahKLUhX8YYU84B38zYlCG5NBiQoKF8014f2Ugq2aquirLNhIhJ0bI69TVm8ZFr/OYo
 TNmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760036417; x=1760641217;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EOlg8HT1U5B3S81siaXOZ5qGLBUBpn1A1O4NI5MVsY8=;
 b=irGyUDj9H9mZJvMA/vK2naOoMqWjC43KGwbZfwszjXe/kkpY+8T+qzTnL3sYyouXAo
 mpR0Cz158L+uv1trsbFge5LKTd8hZXuJKWfR09iM2v+JV/ewIqroT0Bq5qROWrOt3RsF
 0TOEbyPPPniXegY/mWrqDAbwYYUlHmRJxDQqBVwJj7qclg+iEstzp6Vhcnb22YTFVVuc
 5AuiUHQ/qvUdDvWykYUqatkL+BrE1eEklYu2PMq9/57Ua14wKceCWFr7IFJOZk2jq5ol
 Rtkwy5qUhsmnLBGNOrVQhE7KCp/F7trtCnihO5xvHI7kkgZKTFAIb5dz8RcWeVV9CNtW
 XrWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRq7EzEjYo9UCl6cWz2FpGK6zxICtuYCGjWGTaXbGI+t2YBJZ9lMV6AzbsNDW2kasls9S8asxlmjel@nongnu.org
X-Gm-Message-State: AOJu0Yy/qng3/SiDn6cbqTBdnDaDDS/qJhNifIoTbZ06U3uT1G91VNF9
 9EUk4pThQwGrA9VwxyHxyNxXnAemXVEEUQBYIsyc5P9pztmkdQKlIkE1BEd/BqOhxX2l2MUwnoO
 MvEehvu2OYLmPiIQVmNbWq93I0RCCUv0=
X-Gm-Gg: ASbGncttI6GZ+OpHCOHHfhNSg6X3qdaw9vWVrki/jwADf/9zk4fCFOlxr8rSWpVt4Yo
 8v+KMXd5hT0eKwgPLhGiFH0JIJszQW0T3ovsatVpHFoKQ5YtGoSfnH6sxJvcVZjto9wOe8C0eRJ
 qUmvKd/HN/JxZOMxn6gsdXuHc0p0sgxvbSIQuiIFCbPXDtepSrKRJHOCzblwY5Y2ObkPuxgXVWV
 RO4YCDFH2kKlv6IVMbp3MFRTuwVmVxkVYs7xU8dwdqTZDWiJRM5
X-Google-Smtp-Source: AGHT+IHMv0mEZ/irr7B6XYvznIH27I7Y+h01RaDJX0unOGcVxzvimGrxJ2Z8OSaN+IXtV26yCldeU0Fj/oD6l8lZXt8=
X-Received: by 2002:a05:6e02:148a:b0:42f:988a:65e6 with SMTP id
 e9e14a558f8ab-42f988a685cmr15259555ab.30.1760036417047; Thu, 09 Oct 2025
 12:00:17 -0700 (PDT)
MIME-Version: 1.0
References: <20250813164856.950363-1-vsementsov@yandex-team.ru>
 <20250813164856.950363-11-vsementsov@yandex-team.ru>
In-Reply-To: <20250813164856.950363-11-vsementsov@yandex-team.ru>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Thu, 9 Oct 2025 15:00:05 -0400
X-Gm-Features: AS18NWBi4yNKR-RZPoSMe-ssFwF-mA2ylvLqiMG0FnjDMbV0yuZ_NKwXvEiaSFI
Message-ID: <CAFubqFs1azct9_UPyDD9npgPie3bBpSbMc9b0agZrDE8kasSUg@mail.gmail.com>
Subject: Re: [PATCH 10/33] vhost: vhost_virtqueue_start(): fix failure path
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: mst@redhat.com, peterx@redhat.com, farosas@suse.de, raphael@enfabrica.net, 
 sgarzare@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com, 
 kwolf@redhat.com, hreitz@redhat.com, berrange@redhat.com, eblake@redhat.com, 
 armbru@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 steven.sistare@oracle.com, den-plotnikov@yandex-team.ru
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

Nice cleanup.

Reviewed-by: Raphael Norwitz <raphael.s.norwitz@gmail.com>

On Wed, Aug 13, 2025 at 12:56=E2=80=AFPM Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> We miss call to unmap in cases when vhost_memory_map() returns
> lenght less than requested (still we consider such cases as an
> error). Let's fix it in vhost_memory_map().
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  hw/virtio/vhost.c | 33 +++++++++++++++++++++------------
>  1 file changed, 21 insertions(+), 12 deletions(-)
>
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 2631bbabcf..1e14987cd5 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -467,10 +467,19 @@ static inline void vhost_dev_log_resize(struct vhos=
t_dev *dev, uint64_t size)
>  }
>
>  static void *vhost_memory_map(struct vhost_dev *dev, hwaddr addr,
> -                              hwaddr *plen, bool is_write)
> +                              hwaddr len, bool is_write)
>  {
> +    hwaddr mapped_len =3D len;
>      if (!vhost_dev_has_iommu(dev)) {
> -        return cpu_physical_memory_map(addr, plen, is_write);
> +        void *res =3D cpu_physical_memory_map(addr, &mapped_len, is_writ=
e);
> +        if (!res) {
> +            return NULL;
> +        }
> +        if (len !=3D mapped_len) {
> +            cpu_physical_memory_unmap(res, mapped_len, 0, 0);
> +            return NULL;
> +        }
> +        return res;
>      } else {
>          return (void *)(uintptr_t)addr;
>      }
> @@ -1259,7 +1268,7 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
>      BusState *qbus =3D BUS(qdev_get_parent_bus(DEVICE(vdev)));
>      VirtioBusState *vbus =3D VIRTIO_BUS(qbus);
>      VirtioBusClass *k =3D VIRTIO_BUS_GET_CLASS(vbus);
> -    hwaddr s, l, a;
> +    hwaddr l, a;
>      int r;
>      int vhost_vq_index =3D dev->vhost_ops->vhost_get_vq_index(dev, idx);
>      struct vhost_vring_file file =3D {
> @@ -1299,24 +1308,24 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
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
>

