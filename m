Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84202CCD184
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 19:03:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6vuP-0004ts-RS; Thu, 09 Oct 2025 15:02:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1v6vuO-0004sr-6V
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 15:02:36 -0400
Received: from mail-io1-xd34.google.com ([2607:f8b0:4864:20::d34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1v6vuM-0006nU-62
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 15:02:35 -0400
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-938bf212b72so47240839f.1
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 12:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760036552; x=1760641352; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pb/Nogl9oQvhc44yzmYG3LXxgaYvFd5TftJU4gsSFx8=;
 b=JyObaoG7xEeGxWjpbxMbjbQetxs0HQomg7K8CElm3pe5jO4cQ1KeT0RNYDrmytA5hM
 Nw5DqlRQxZf6X+XwtXcG1EGn0Mq4zxgNvIchE6FZJ3anhqafK5ImrFjlV5eGsw3v03/E
 OIew63Q0asNDG7u2UdOEA9pbVTByZ/AqWSbDhPG5PVQgf7GYi1tdBcNKSggwiUt6/IZi
 NqD00K9O4rThQmUDZ6uQse5UxaMmldhB0ChiH7g1qp0r92e06fpQPBIi9BRCvbP6lGZR
 RpZya98ZdziqY847C47NzQmW2YlGhZLzxEt56ro1CEGmC2BjvRO8aHs5u0xBrIwVgneN
 RRLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760036552; x=1760641352;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pb/Nogl9oQvhc44yzmYG3LXxgaYvFd5TftJU4gsSFx8=;
 b=YMdq3eobzjeNDtwGkcYOgLgw6dJnAAiwXXckIiN7LD7vt3nwnpIfzRxxzsqlhGN4Fa
 uOkMo/DQYa/mF/zGnjAlgqfzwCckZOKoeWCK6sRKB2gJL4wL3dQk7Y+4JlHTs4RZJR7w
 F0pmi9BN1j+SIRSEtDRmMVZuvfHLDpZrmkoj2fkblO35+h6wGuSN54pTNu2z+o4cbjzW
 4SCaUhSaEFm4koH5NNRMCEppX6oCSIIOx/Ft/v+qCCPCa6YOg1n3KCq4sOJaB90sOrO1
 rYlyBAOziDkWNFa/KaYxozNOcoUtLuruvjXuax8RC8ixD8g8rN3/lFJ6MpxOgYIRJUNQ
 73kQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXX1YPigOzuY1yherjwqrb7qBl7rEoBg0ZOA0tJND5zmejeNyB4kDUJbsOmakXLX0dD6gzMUSzxY75z@nongnu.org
X-Gm-Message-State: AOJu0Yw1aj4tSM4GIFDJadB5F0x6Wzi0tkTV6/Q1+mJDp36SUsvEctYm
 SmlsId3Uco9S9/xqJ1yxfTHgLYO8HolQ9kqPdkTJGV7xK5ukeFKy/ZuMbXFs0BMS7eDQq1sKx2D
 KUyzmzQsd79SYJRu2WdOC8zqYl7z3bJo=
X-Gm-Gg: ASbGnctxKffORaTXi6it+4vvdOOw3LTtHVGho7OpoygZ5pM/RJQd9Cxvgdxv7jHXbwj
 2BkVdXDY19sN8658OtLja2KXsvCfbSjY5ZhUV6eMXuc9H+2W5wiM5ETWzWN601mJODMMJ/p7Y8G
 2wyNLV/Pez92LtxNFaH7rggfJ+a5CooNtr7U3bzhJXNKlMeCnT/Q/cMYvFCAtM1+D5Ef3q39F6D
 yEDxpJei9Soww4Vm25VC2BvRnJkuhGy3TO5e5h4Pw==
X-Google-Smtp-Source: AGHT+IGFzQ04MGioMaa6ZdQV9XWuPugq9IU66c7ZXAOP8HwExRLzOsRhMxopXIq+A0az94mOegDOmbkoU4E0nufgjJo=
X-Received: by 2002:a05:6e02:12c3:b0:42e:7a9d:f5ff with SMTP id
 e9e14a558f8ab-42f8737025amr79764525ab.11.1760036552235; Thu, 09 Oct 2025
 12:02:32 -0700 (PDT)
MIME-Version: 1.0
References: <20250813164856.950363-1-vsementsov@yandex-team.ru>
 <20250813164856.950363-15-vsementsov@yandex-team.ru>
In-Reply-To: <20250813164856.950363-15-vsementsov@yandex-team.ru>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Thu, 9 Oct 2025 15:02:20 -0400
X-Gm-Features: AS18NWANa-bjpRhOhYSpk-gK62JwD0E9biHLCgL9hKGV38GKmEEiQeIrQH7sC7k
Message-ID: <CAFubqFtS+RqaH-L2NSdNbzn8_AUAWPpT=0jLaCacG6UxmcxpWA@mail.gmail.com>
Subject: Re: [PATCH 14/33] vhost: vhost_virtqueue_start(): drop extra local
 variables
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: mst@redhat.com, peterx@redhat.com, farosas@suse.de, raphael@enfabrica.net, 
 sgarzare@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com, 
 kwolf@redhat.com, hreitz@redhat.com, berrange@redhat.com, eblake@redhat.com, 
 armbru@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 steven.sistare@oracle.com, den-plotnikov@yandex-team.ru
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d34;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-io1-xd34.google.com
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

On Wed, Aug 13, 2025 at 12:56=E2=80=AFPM Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> One letter named variables doesn't really help to read the code,
> and they simply duplicate structure fields.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  hw/virtio/vhost.c | 22 ++++++++++------------
>  1 file changed, 10 insertions(+), 12 deletions(-)
>
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 97113174b9..c76e2dbb4e 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -1272,7 +1272,6 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
>      BusState *qbus =3D BUS(qdev_get_parent_bus(DEVICE(vdev)));
>      VirtioBusState *vbus =3D VIRTIO_BUS(qbus);
>      VirtioBusClass *k =3D VIRTIO_BUS_GET_CLASS(vbus);
> -    hwaddr l, a;
>      int r;
>      int vhost_vq_index =3D dev->vhost_ops->vhost_get_vq_index(dev, idx);
>      struct vhost_vring_file file =3D {
> @@ -1283,28 +1282,27 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
>      };
>      struct VirtQueue *vvq =3D virtio_get_queue(vdev, idx);
>
> -    a =3D virtio_queue_get_desc_addr(vdev, idx);
> -    if (a =3D=3D 0) {
> +    vq->desc_phys =3D virtio_queue_get_desc_addr(vdev, idx);
> +    if (vq->desc_phys =3D=3D 0) {
>          /* Queue might not be ready for start */
>          return 0;
>      }
> -    vq->desc_size =3D l =3D virtio_queue_get_desc_size(vdev, idx);
> -    vq->desc_phys =3D a;
> -    vq->desc =3D vhost_memory_map(dev, a, l, false);
> +    vq->desc_size =3D virtio_queue_get_desc_size(vdev, idx);
> +    vq->desc =3D vhost_memory_map(dev, vq->desc_phys, vq->desc_size, fal=
se);
>      if (!vq->desc) {
>          r =3D -ENOMEM;
>          goto fail;
>      }
> -    vq->avail_size =3D l =3D virtio_queue_get_avail_size(vdev, idx);
> -    vq->avail_phys =3D a =3D virtio_queue_get_avail_addr(vdev, idx);
> -    vq->avail =3D vhost_memory_map(dev, a, l, false);
> +    vq->avail_size =3D virtio_queue_get_avail_size(vdev, idx);
> +    vq->avail_phys =3D virtio_queue_get_avail_addr(vdev, idx);
> +    vq->avail =3D vhost_memory_map(dev, vq->avail_phys, vq->avail_size, =
false);
>      if (!vq->avail) {
>          r =3D -ENOMEM;
>          goto fail;
>      }
> -    vq->used_size =3D l =3D virtio_queue_get_used_size(vdev, idx);
> -    vq->used_phys =3D a =3D virtio_queue_get_used_addr(vdev, idx);
> -    vq->used =3D vhost_memory_map(dev, a, l, true);
> +    vq->used_size =3D virtio_queue_get_used_size(vdev, idx);
> +    vq->used_phys =3D virtio_queue_get_used_addr(vdev, idx);
> +    vq->used =3D vhost_memory_map(dev, vq->used_phys, vq->used_size, tru=
e);
>      if (!vq->used) {
>          r =3D -ENOMEM;
>          goto fail;
> --
> 2.48.1
>
>

