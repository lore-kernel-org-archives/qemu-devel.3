Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCDD7C41513
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2024 14:10:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s54SS-0008Eb-MY; Thu, 09 May 2024 10:09:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1s54SR-0008EQ-9g
 for qemu-devel@nongnu.org; Thu, 09 May 2024 10:09:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1s54SP-0005jW-6g
 for qemu-devel@nongnu.org; Thu, 09 May 2024 10:09:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715263752;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QcDlEInEE+lxtzTRhb2xwAAma+0g1x25vdI1AGC9KKA=;
 b=gpVToWsNtDzPW6BaJJLoG3B56syXx5nmyid36UMH6L3rw8u+wBf34WMi4XgyGJOichG8be
 WTw6Q/jvIO8fBkPQxOv1VM/HkuvHctd0J7/b+I0Tjc9IR/d9xSi9O1cqs7wWgOyIqz2Yfs
 UAGSIMS3+kTtc8/jP9NOA7aSn2MNMjE=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-oSk_RpDAMRalqmx-ki5-QQ-1; Thu, 09 May 2024 10:09:07 -0400
X-MC-Unique: oSk_RpDAMRalqmx-ki5-QQ-1
Received: by mail-yb1-f200.google.com with SMTP id
 3f1490d57ef6-deb45f85880so1400933276.2
 for <qemu-devel@nongnu.org>; Thu, 09 May 2024 07:09:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715263746; x=1715868546;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QcDlEInEE+lxtzTRhb2xwAAma+0g1x25vdI1AGC9KKA=;
 b=g+4t8w7B36od+ZxHaMMwVWI9PmnT1rVaAzacbst2yaQUVHJGquHnpU3wHy2XeXDUyo
 YcyJw3MgQxu1IF3fkC7rRfCTq+jviYLcHhiWmqe7zgzciA9vyj8cIvuSMvfUsJfBr5zh
 Kl19n1EKhd/VzCGnC9sd0Y0ASMdtPcesodTkqbTEeDGNu2E/yGU/tp/qvGNy7gsJnJ6g
 X1Tut6ZXLqawe4CjiCMBsfcx+BY/7mIvsxm5TACwNJ/1v/yrHLAkzwN05P9UNpZQh0eS
 v7W7g6sejenjKXAsdxZdcKyTd2ypctUA0efIcq0rOkGGkOKuP1GZxArtJMmL2xnq1Doy
 JPFQ==
X-Gm-Message-State: AOJu0YzMqz4hgIlYqEkCIxXLTBpgdmUXxQdj5sCF+YqTedZuPhRPZlou
 sgELXNc5aEPIJk4pgAelfWPML+h1VZhRihsaMQPe56sRNsR+Q6X6Rof4iNnVlcCdcaf5Faf6Hzd
 HrLrX2dbfyML67+5ZsUAbsJP0aRBYYaFWwwAYaufFX4FmnbL130C55K+B/BiE2SKiKlVi1oMGFY
 zFppIc1SuFqmqQ+3CafFUnYzEzkmo=
X-Received: by 2002:a5b:64c:0:b0:dda:a4ba:2a5 with SMTP id
 3f1490d57ef6-debb9dd94c2mr5756720276.63.1715263746634; 
 Thu, 09 May 2024 07:09:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFplgAc9BugENhNfTYu2SQLewArgeXQNAEFenvlIUMcnDEn0GNuPrsjJ/+qLHk5ljL1f3/RBixyjp8XvDXCiaQ=
X-Received: by 2002:a5b:64c:0:b0:dda:a4ba:2a5 with SMTP id
 3f1490d57ef6-debb9dd94c2mr5756693276.63.1715263746265; 
 Thu, 09 May 2024 07:09:06 -0700 (PDT)
MIME-Version: 1.0
References: <20240506150428.1203387-1-jonah.palmer@oracle.com>
 <20240506150428.1203387-4-jonah.palmer@oracle.com>
In-Reply-To: <20240506150428.1203387-4-jonah.palmer@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 9 May 2024 16:08:29 +0200
Message-ID: <CAJaqyWcTSQ4hyzfYRENE93GnHMhgvY4X_gz3ydnpYUMz1_J8aA@mail.gmail.com>
Subject: Re: [PATCH 3/6] virtio: virtqueue_ordered_fill - VIRTIO_F_IN_ORDER
 support
To: Jonah Palmer <jonah.palmer@oracle.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, raphael@enfabrica.net, 
 kwolf@redhat.com, hreitz@redhat.com, jasowang@redhat.com, pbonzini@redhat.com, 
 fam@euphon.net, stefanha@redhat.com, qemu-block@nongnu.org, 
 schalla@marvell.com, leiyang@redhat.com, virtio-fs@lists.linux.dev, 
 si-wei.liu@oracle.com, boris.ostrovsky@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, May 6, 2024 at 5:05=E2=80=AFPM Jonah Palmer <jonah.palmer@oracle.co=
m> wrote:
>
> Add VIRTIO_F_IN_ORDER feature support for virtqueue_fill operations.
>
> The goal of the virtqueue_fill operation when the VIRTIO_F_IN_ORDER
> feature has been negotiated is to search for this now-used element,
> set its length, and mark the element as filled in the VirtQueue's
> used_elems array.
>
> By marking the element as filled, it will indicate that this element is
> ready to be flushed, so long as the element is in-order.
>
> Tested-by: Lei Yang <leiyang@redhat.com>
> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
> ---
>  hw/virtio/virtio.c | 26 +++++++++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
>
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index e6eb1bb453..064046b5e2 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -873,6 +873,28 @@ static void virtqueue_packed_fill(VirtQueue *vq, con=
st VirtQueueElement *elem,
>      vq->used_elems[idx].ndescs =3D elem->ndescs;
>  }
>
> +static void virtqueue_ordered_fill(VirtQueue *vq, const VirtQueueElement=
 *elem,
> +                                   unsigned int len)
> +{
> +    unsigned int i =3D vq->used_idx;
> +
> +    /* Search for element in vq->used_elems */
> +    while (i !=3D vq->last_avail_idx) {
> +        /* Found element, set length and mark as filled */
> +        if (vq->used_elems[i].index =3D=3D elem->index) {
> +            vq->used_elems[i].len =3D len;
> +            vq->used_elems[i].filled =3D true;
> +            break;
> +        }
> +
> +        i +=3D vq->used_elems[i].ndescs;
> +
> +        if (i >=3D vq->vring.num) {
> +            i -=3D vq->vring.num;
> +        }
> +    }

This has a subtle problem: ndescs and elems->id are controlled by the
guest, so it could make QEMU to loop forever looking for the right
descriptor. For each iteration, the code must control that the
variable "i" will be different for the next iteration, and that there
will be no more than vq->last_avail_idx - vq->used_idx iterations.

Apart of that, I think it makes more sense to split the logical
sections of the function this way:
/* declarations */
i =3D vq->used_idx

/* Search for element in vq->used_elems */
while (vq->used_elems[i].index !=3D elem->index &&
vq->used_elems[i].index i !=3D vq->last_avail_idx && ...) {
...
}

/* Set length and mark as filled */
vq->used_elems[i].len =3D len;
vq->used_elems[i].filled =3D true;
---

But I'm ok either way.

> +}
> +
>  static void virtqueue_packed_fill_desc(VirtQueue *vq,
>                                         const VirtQueueElement *elem,
>                                         unsigned int idx,
> @@ -923,7 +945,9 @@ void virtqueue_fill(VirtQueue *vq, const VirtQueueEle=
ment *elem,
>          return;
>      }
>
> -    if (virtio_vdev_has_feature(vq->vdev, VIRTIO_F_RING_PACKED)) {
> +    if (virtio_vdev_has_feature(vq->vdev, VIRTIO_F_IN_ORDER)) {
> +        virtqueue_ordered_fill(vq, elem, len);
> +    } else if (virtio_vdev_has_feature(vq->vdev, VIRTIO_F_RING_PACKED)) =
{
>          virtqueue_packed_fill(vq, elem, len, idx);
>      } else {
>          virtqueue_split_fill(vq, elem, len, idx);
> --
> 2.39.3
>


