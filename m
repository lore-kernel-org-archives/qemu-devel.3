Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93AA2CCD199
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 18:25:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAuYZ-0007h7-GM; Mon, 20 Oct 2025 14:24:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1vAuYY-0007gz-Be
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 14:24:30 -0400
Received: from mail-il1-x12c.google.com ([2607:f8b0:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1vAuYW-00073L-A8
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 14:24:29 -0400
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-430aeaffeaeso21475995ab.3
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 11:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760984666; x=1761589466; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3GHxR/8VHFxa7zRseihoRbRmCRMMRZjWlJ4mV+J6v98=;
 b=denNok1/05qCYDA+Ai2M2Wwkq0IkfWI96UICoo4MtYXOjUJGZ/j6tb+Jmo07Taiokx
 VAzjhhpiCJGzxumAGCAwtZhUQhTCRKOuTxWz8VyVaKYv7rt8bME4otlDPr/MaxG3SC3v
 WzmCaJOnsfaPJzJB6ZK7b7qnNqVeZLTULaqPdwzAd5Os16UVHnDiMsUlWQGh6X5GM4Bo
 ESAZWJ6vZTJF/SUdkdgOVE5hbbA8TBfiEKcU4VnTBeWRlUPfIqVsEALgrQEUTXlZ/Lll
 4dYWnolHG1uT4uJr48ag8N/jSgV+rTA+SKIUNztUaNE1uu4flfsfC6VuIbpaEWsXjCc3
 vzXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760984666; x=1761589466;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3GHxR/8VHFxa7zRseihoRbRmCRMMRZjWlJ4mV+J6v98=;
 b=D7J9rFJZHktkCUdQKST9KYfmENva+LI9Z4/vJWq3bDs4/Lb8pI2FaeO63pJOpeQyEY
 ZfsIbXnQuJzZMVwwr+23coLYEcdiVfMDbzse/Lt3KOKrTeCGHNazqamNVIqL2bdIc7NI
 cTewbN8vvzOo1CFU6zkQ7pfFYzDC0+SmVmADqjY7KmZEqUAmDwZufyQTnRK0cCW67n/e
 FIZq0Vz2SdS3NoFJYr9jxp2Fv+x8tetuxxddFhKiy0zkaE/Y6xtih4q83d1XQg0vkomP
 Y3BaNKL0ccnbjtWmp1ICueU9AVfrqamPE0+xoy/dfyDX8FV7W3uJTHHAZXEv3gWGh/Rc
 Z8CQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtEQKt+k136QzjspGjwH08kZV7+x7csmUve2cVarL864+7X4/EfTHsAEE9wC1Yew+zY2QpXCzOYvn0@nongnu.org
X-Gm-Message-State: AOJu0YyY1p2whM1yWXTZ6isu7HACcq4nDqM7zvYhA7/YYYrbD+MfCpsY
 Z3FDK8ceSAK0OaPv6V3Uo+WNf5+phs3TrhmNRdoiFA7T+BEwjRNGPjN+VfZrUNkQVw4p2oofYv3
 wjMP4OZBtxjw6NDT6HwuMNYe7B7JD1Lw=
X-Gm-Gg: ASbGncupw8Nnco44Afak71K2jxzfCbqgLcCRVvv+H0SFYGOtYpYsXBiH2JRsGeJHKKC
 4g10b/vl0epuRpDpvQm2Hkx70q4VfnHItPmf3um+tGsfzxF6rQW/xn7aRsVTx3qpotdVP4iorM8
 QpIffySfOru4YexDpZo6zA5fjsuZazizflwSFxc4TMQnxZRJM64HKuPgtCcIhkyhUCnpiila/7H
 YxPJ6x7HsS++xdWVg10BEvatnKF2KHtiIkxNfiDCq88FXfBzZiqCqtfN2hxE/UIog3hEDc=
X-Google-Smtp-Source: AGHT+IHzryDOxkrbnqQ1aKX45/h5tpR9eJ4ULKCY0qebGjJEHd/bibln7mzoMuAvQs6ClPdZt3kPYWdrFhp3Hq8FuCg=
X-Received: by 2002:a92:c24f:0:b0:424:1774:6915 with SMTP id
 e9e14a558f8ab-430c521f957mr167901605ab.8.1760984666123; Mon, 20 Oct 2025
 11:24:26 -0700 (PDT)
MIME-Version: 1.0
References: <20251015145808.1112843-1-vsementsov@yandex-team.ru>
 <20251015145808.1112843-11-vsementsov@yandex-team.ru>
In-Reply-To: <20251015145808.1112843-11-vsementsov@yandex-team.ru>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Mon, 20 Oct 2025 14:24:14 -0400
X-Gm-Features: AS18NWDmSZ15jD-tcUPd3NxOCEBbjRHNYYTvXVcGdxWO5MniimLeui319AuKSy4
Message-ID: <CAFubqFuZjy2kmQtuxsbVQrh3AQR2X5hW7BKxwA0J0KfqFbaQOQ@mail.gmail.com>
Subject: Re: [PATCH v3 10/23] vhost: vhost_virtqueue_start(): fix failure path
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: mst@redhat.com, sgarzare@redhat.com, raphael@enfabrica.net, 
 qemu-devel@nongnu.org, yc-core@yandex-team.ru, d-tatianin@yandex-team.ru
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

On Wed, Oct 15, 2025 at 11:07=E2=80=AFAM Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> We miss call to unmap in cases when vhost_memory_map() returns
> lenght less than requested (still we consider such cases as an
> error). Let's fix it in vhost_memory_map().
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> Reviewed-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
> ---
>  hw/virtio/vhost.c | 35 ++++++++++++++++++++++-------------
>  1 file changed, 22 insertions(+), 13 deletions(-)
>
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 94efa409aa..be2245cc7e 100644
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
>

