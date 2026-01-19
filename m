Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A6C4D2ECF5
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 23:50:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhz0O-0006PZ-GT; Mon, 19 Jan 2026 18:49:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1vhz0M-0006OY-Rv
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 18:49:54 -0500
Received: from mail-oa1-x2b.google.com ([2001:4860:4864:20::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1vhz0L-0005LV-Eg
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 18:49:54 -0500
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-4045e70f36eso2145238fac.1
 for <qemu-devel@nongnu.org>; Mon, 19 Jan 2026 15:49:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768866592; cv=none;
 d=google.com; s=arc-20240605;
 b=T6Pt82s3yRlllsrMWL+7fQ9U7/YxKTjInt6cWAY+tNQreRg1lpipZnDcVvqvQA1wM+
 NCAi9DLU6cKQlx/4UZJ81OWL+zQaQqpFExxr60mn3+kujyb+EIlkBa+0ZtBoKtyON/YB
 3Mg0JB3UMWq2szOOW6/4xPzNtBiRFauQzNU3s5UMJrqa236BD55eF9aVxbkmExYCEQmq
 YJRS9rUlg+HKf82ediMO3VHFhoF1gaB4D674Nu5GVLG4N149c3KQt1cmPmiHJ09nkWeT
 CCyn5Ouisil1DuP8kZWg3L+7ARJ9rAdlHV8CMUs0gj+he3gFVW4WnG27VuGh3FjUR1T5
 YpAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=UGm1NKEf7UM9QlU9jilzDTRbI1uUaP6wyzACI3va/HI=;
 fh=ZNDD+KoGE6J2ViEo3ShEbUCyyLqxprhN9GVi8HtWc8E=;
 b=M8F5ONGNduhZZeUPa8VLB4qs+wshR5qOqRvbybM02GwGK/71AYoltaakjeY/Xe6AzW
 EVOWuHNjHicaQxCsFs/CYjEXZXI6icOHJj4lNz8VoIr0yecB1rSXomtGOwK37gLXiES7
 3AJiO6rYwgPG7tUfJk6OdTLwf4YD2x8RIMn/pucvuA79frfJoESEZp6smRikZYyJy1t1
 6zjCCco0ZBpMU1bxIHFHX8HwJLWkganecoF7uWDvPnAyelYgGzMJUOyfqC9tKbAKcUv7
 sjXYi17Mddyy7KqNuFwBCC4eY/JwsV7b+kB79bx4AhFmnH6vYeDUXJUcTRfz8Wrzu54+
 pA1Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768866592; x=1769471392; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UGm1NKEf7UM9QlU9jilzDTRbI1uUaP6wyzACI3va/HI=;
 b=e9b9Cza7AY8zozxDtvJMbGV1c83WQvfIqlsPW6omcnFhEtenUxnMLO3UMp9xOTPuYj
 oE9AvLRSGQlGJFPI1OAKjsn8AkIdN6TDU8l/emG64dmB1x4Jf+6alUaVPGkv7F5CDXHN
 keNRIT9WSvVAoLea9zEXiGBax2Hieu+TCcbz9J9zu0txXfvQmLHwWxXJn3Yplbf6P0dY
 oOBRlr9Ml4xhxtF6dOhMVwypJy/LPsIvjf59ExLz2HRXZmhfREmje13m2UkGjlNybtqw
 J8fD7Yl2mvLkOPn1YK5VP7VwZdCGP77pJ6XkzeksN3ongwYbtToQj9oAVmzV/rBuhfRR
 2qsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768866592; x=1769471392;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UGm1NKEf7UM9QlU9jilzDTRbI1uUaP6wyzACI3va/HI=;
 b=HMlV8qP3gBUR6d/d5h3Fc7UJ7S2unkpZz2oH4NJ61ACoKz9bDu1BOlYuTlVzXyNvgE
 q1wrovTQb3mouZiv3/8TLYyHY5xxIoi2Vb+jBvgyMCW7B/3savGZ75hQ1acMzMLwi5ci
 j1eqqwqZgdwpsZhtaDf90UVIzLd/Jkj87uRKQFgceW2FWTqewsJN0usTaGOWuMNnopPx
 XFOSFW61qqOQ9bbdmrL8Xg3N0I9hTBFcRQDDfJ+06rpdUBz2CgcfKsgBzpkiGES220Re
 5wMxPFlDhOYjt2Rv8ZQ9X5fpAi70Riu7IhdKWHWTfj3YIpXWbH8T7SJmgEkIIs2aBi7C
 lDAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUasm7wQMkhCnk6h698ziydHkx9Yy/SCfdyC8o6gUvQQIZmFjsO6Oitg8zJRn/w6vUgGkrxKJqcQYJu@nongnu.org
X-Gm-Message-State: AOJu0YwQ4lYT96A2llvaEcOxYkRJ1Gn2rMCoG9xDq8+UVG5KzbXs4U/Y
 C46LRHeEs2qJlBuijQpL2bvuQ7qkIdcvKaT725tpSNlHm0k7oV4+kUBTIGfZ7bwKExoHGkk3A7s
 ad5sv7qlkH2FKehzqfWatDx/S/6JwontTuA9f
X-Gm-Gg: AY/fxX7di9SvmerbSV2DcZg/j2hRksmdStl6c2McKjXtQHEcdTdlm1NpRM1mwBnpG53
 sdbbxh7AVUiKr9AKY3a7ZNdr/MgdIZ8I8A3jc0/ivrvbvcGUqBZwB5yVtAbQozBS5JyHVsC5yLO
 qB43aM+pmpDGz5RrcjDf/YYePceM9Di6XE76qVG1SAuNy5TVsJQFJ33SOoZnzVEESuwhe8W5PWn
 rW1p5FvUg3/+HTNpyz/2pNzepymo6cWZeIu7Ox8LXz7fzlpX27UDN1eMoNULBFR+zt9c1wopbBo
 SYH2J+h0KUeiCBTnFWzYkb6vfmU=
X-Received: by 2002:a05:6820:2d09:b0:659:9a49:8f1f with SMTP id
 006d021491bc7-662b0042330mr33620eaf.48.1768866592064; Mon, 19 Jan 2026
 15:49:52 -0800 (PST)
MIME-Version: 1.0
References: <20260119185228.203296-1-vsementsov@yandex-team.ru>
 <20260119185228.203296-16-vsementsov@yandex-team.ru>
In-Reply-To: <20260119185228.203296-16-vsementsov@yandex-team.ru>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Mon, 19 Jan 2026 18:49:40 -0500
X-Gm-Features: AZwV_QizPXZa9vc07wg-it29M42FKKsv9DvbO5xobLH4Gg-M-cgh3GOEKdcmQyI
Message-ID: <CAFubqFsEs4MgRfVqVYaLPEY+=DTo3=sa=9yvb9GEoTn7qR8LDA@mail.gmail.com>
Subject: Re: [PATCH v4 15/23] vhost: vhost_virtqueue_start(): drop extra local
 variables
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: mst@redhat.com, sgarzare@redhat.com, raphael@enfabrica.net, 
 qemu-devel@nongnu.org, yc-core@yandex-team.ru, d-tatianin@yandex-team.ru
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2001:4860:4864:20::2b;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-oa1-x2b.google.com
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
> One letter named variables doesn't really help to read the code,
> and they simply duplicate structure fields.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  hw/virtio/vhost.c | 13 +++----------
>  1 file changed, 3 insertions(+), 10 deletions(-)
>
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 06b0b34cd3..653cb706cc 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -1277,7 +1277,6 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
>      BusState *qbus =3D BUS(qdev_get_parent_bus(DEVICE(vdev)));
>      VirtioBusState *vbus =3D VIRTIO_BUS(qbus);
>      VirtioBusClass *k =3D VIRTIO_BUS_GET_CLASS(vbus);
> -    hwaddr l;
>      int r;
>      int vhost_vq_index =3D dev->vhost_ops->vhost_get_vq_index(dev, idx);
>      struct vhost_vring_file file =3D {
> @@ -1302,23 +1301,17 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
>          /* Queue might not be ready for start */
>          return 0;
>      }
> -
> -    l =3D vq->desc_size;
> -    vq->desc =3D vhost_memory_map(dev, vq->desc_phys, l, false);
> +    vq->desc =3D vhost_memory_map(dev, vq->desc_phys, vq->desc_size, fal=
se);
>      if (!vq->desc) {
>          r =3D -ENOMEM;
>          goto fail;
>      }
> -
> -    l =3D vq->avail_size;
> -    vq->avail =3D vhost_memory_map(dev, vq->avail_phys, l, false);
> +    vq->avail =3D vhost_memory_map(dev, vq->avail_phys, vq->avail_size, =
false);
>      if (!vq->avail) {
>          r =3D -ENOMEM;
>          goto fail;
>      }
> -
> -    l =3D vq->used_size;
> -    vq->used =3D vhost_memory_map(dev, vq->used_phys, l, true);
> +    vq->used =3D vhost_memory_map(dev, vq->used_phys, vq->used_size, tru=
e);
>      if (!vq->used) {
>          r =3D -ENOMEM;
>          goto fail;
> --
> 2.52.0
>
>

