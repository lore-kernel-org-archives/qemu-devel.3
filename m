Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B80DC25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 10:49:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA600-0007nb-Vk; Thu, 23 May 2024 06:48:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1sA5zz-0007mr-96
 for qemu-devel@nongnu.org; Thu, 23 May 2024 06:48:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1sA5zx-0004gp-9x
 for qemu-devel@nongnu.org; Thu, 23 May 2024 06:48:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716461316;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LsKlGJYohu5RsJn846NAapVIb9h8a0Dbbqc6cKw84wI=;
 b=bUnfkJYLO227j8OyLYqkm3YnUpbmy2xfT0g0dzmWilInO5jGqBS8V8SnYUlAEUOftvUsYN
 TsEcdUf92bvN8WaMoI/7YZDfzx76vEXwuGesot3j56K6FCfqMtF9aW08hiFa/zbMZRtG/W
 1B1g0++WxMxgIGU33o5f1HzEbodOhNk=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-35-TXZI56uGM8SFYHUmeRX9kA-1; Thu, 23 May 2024 06:48:35 -0400
X-MC-Unique: TXZI56uGM8SFYHUmeRX9kA-1
Received: by mail-yb1-f198.google.com with SMTP id
 3f1490d57ef6-df4e7854de8so2518663276.1
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 03:48:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716461314; x=1717066114;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LsKlGJYohu5RsJn846NAapVIb9h8a0Dbbqc6cKw84wI=;
 b=Sy10UBv9GIruyVwGCkAYc94pgGghC/+WT1N1RDxvlK1mk9s3ij37VnZwTxWkargnIQ
 shW9fz2gmUSvHkia3m9mhD01bb4WmPdSkRes3hYVeqcb/A9ghttzpIdUbFKoQFuLuHPF
 uJhyjPwLvOAWrIUuhSZtjNf1oURucFAVKwoWF33r5aY9UpTF4xSKMd3IiAXwgOT1Zbnn
 vcHsdYJvgpInxtFL2QSu6xDC6IyA3gVwb8Gl5VbR0hzDcmQme7BYqs9x54xWhX/sh3Jx
 k2qUiyAzM/Vuj9r5Gj8ChRHz3FzWA/FNJzT/VuhMXyOMhDU7zQQ974AbqHl9aBi1uzMQ
 8mXw==
X-Gm-Message-State: AOJu0YxxmmObnvDEl7GBhmGneCnPcjWXSCoZ4dYixHaYc+3qSkjGceks
 Mc/MesX6wzFnHComwpzy0Xx8qijRFWe4BIgmi1pgPPew03VOLTLD1FpG/1SIQasQqO+tgiHV+ym
 foZb7HHxtJrD993GtoKxZvaV280a/NbyB7Zp/qEyyrfNJfiwMhpOh+BoWLNnbHRYalLg0uJ0zaZ
 hkQo6dj/ZpO0crnWz/ny0xuVsOuMg=
X-Received: by 2002:a25:b285:0:b0:df4:db71:c666 with SMTP id
 3f1490d57ef6-df4e0d31cc6mr5276837276.38.1716461314659; 
 Thu, 23 May 2024 03:48:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/68hVrVD2BM9Yb1HLGkfr7uikTT5HtvWhioQpaVyU14Ct4yXIqFd5ViowehU+j3JqsmHPEsRzrumUBsYOvzM=
X-Received: by 2002:a25:b285:0:b0:df4:db71:c666 with SMTP id
 3f1490d57ef6-df4e0d31cc6mr5276823276.38.1716461314333; Thu, 23 May 2024
 03:48:34 -0700 (PDT)
MIME-Version: 1.0
References: <20240520130048.1483177-1-jonah.palmer@oracle.com>
 <20240520130048.1483177-4-jonah.palmer@oracle.com>
 <CAJaqyWdxt+cPNR=unm6P1cGCKV=LwhuMYdVeQLbWF6wYLBLWKg@mail.gmail.com>
 <5469bc3f-7fb5-4fcf-ad9c-6467aba635b9@oracle.com>
In-Reply-To: <5469bc3f-7fb5-4fcf-ad9c-6467aba635b9@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 23 May 2024 12:47:58 +0200
Message-ID: <CAJaqyWe1ozf867a7tnSKjkijnHtT+5i7y8p9zvtTXqgZNk74aA@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] virtio: virtqueue_ordered_fill - VIRTIO_F_IN_ORDER
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
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, May 23, 2024 at 12:30=E2=80=AFPM Jonah Palmer <jonah.palmer@oracle.=
com> wrote:
>
>
>
> On 5/22/24 12:07 PM, Eugenio Perez Martin wrote:
> > On Mon, May 20, 2024 at 3:01=E2=80=AFPM Jonah Palmer <jonah.palmer@orac=
le.com> wrote:
> >>
> >> Add VIRTIO_F_IN_ORDER feature support for the virtqueue_fill operation=
.
> >>
> >> The goal of the virtqueue_ordered_fill operation when the
> >> VIRTIO_F_IN_ORDER feature has been negotiated is to search for this
> >> now-used element, set its length, and mark the element as filled in
> >> the VirtQueue's used_elems array.
> >>
> >> By marking the element as filled, it will indicate that this element h=
as
> >> been processed and is ready to be flushed, so long as the element is
> >> in-order.
> >>
> >> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
> >> ---
> >>   hw/virtio/virtio.c | 36 +++++++++++++++++++++++++++++++++++-
> >>   1 file changed, 35 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> >> index 7456d61bc8..01b6b32460 100644
> >> --- a/hw/virtio/virtio.c
> >> +++ b/hw/virtio/virtio.c
> >> @@ -873,6 +873,38 @@ static void virtqueue_packed_fill(VirtQueue *vq, =
const VirtQueueElement *elem,
> >>       vq->used_elems[idx].ndescs =3D elem->ndescs;
> >>   }
> >>
> >> +static void virtqueue_ordered_fill(VirtQueue *vq, const VirtQueueElem=
ent *elem,
> >> +                                   unsigned int len)
> >> +{
> >> +    unsigned int i, steps, max_steps;
> >> +
> >> +    i =3D vq->used_idx;
> >> +    steps =3D 0;
> >> +    /*
> >> +     * We shouldn't need to increase 'i' by more than the distance
> >> +     * between used_idx and last_avail_idx.
> >> +     */
> >> +    max_steps =3D (vq->last_avail_idx + vq->vring.num - vq->used_idx)
> >> +                % vq->vring.num;
> >
> > I may be missing something, but (+vq->vring.num) is redundant if we (%
> > vq->vring.num), isn't it?
> >
>
> It ensures the result is always non-negative (e.g. when
> vq->last_avail_idx < vq->used_idx).
>
> I wasn't sure how different platforms or compilers would handle
> something like -5 % 10, so to be safe I included the '+ vq->vring.num'.
>
> For example, on my system, in test.c;
>
>     #include <stdio.h>
>
>     int main() {
>         unsigned int result =3D -5 % 10;
>         printf("Result of -5 %% 10 is: %d\n", result);
>         return 0;
>     }
>
> # gcc -o test test.c
>
> # ./test
> Result of -5 % 10 is: -5
>

I think the modulo is being done in signed ints in your test, and then
converting a signed int to an unsigned int. Like result =3D (-5 % 10).

The unsigned wrap is always defined in C, and vq->last_avail_idx and
vq->used_idx are both unsigned. Here is a closer test:
int main(void) {
    unsigned int a =3D -5, b =3D 2;
    unsigned int result =3D (b-a) % 10;
    printf("Result of -5 %% 10 is: %u\n", result);
    return 0;
}

But it is a good catch for signed ints for sure :).

Thanks!

> >> +
> >> +    /* Search for element in vq->used_elems */
> >> +    while (steps <=3D max_steps) {
> >> +        /* Found element, set length and mark as filled */
> >> +        if (vq->used_elems[i].index =3D=3D elem->index) {
> >> +            vq->used_elems[i].len =3D len;
> >> +            vq->used_elems[i].in_order_filled =3D true;
> >> +            break;
> >> +        }
> >> +
> >> +        i +=3D vq->used_elems[i].ndescs;
> >> +        steps +=3D vq->used_elems[i].ndescs;
> >> +
> >> +        if (i >=3D vq->vring.num) {
> >> +            i -=3D vq->vring.num;
> >> +        }
> >> +    }
> >> +}
> >> +
> >
> > Let's report an error if we finish the loop. I think:
> > qemu_log_mask(LOG_GUEST_ERROR,
> >                "%s: %s cannot fill buffer id %u\n",
> >                __func__, vdev->name, elem->index);
> >
> > (or similar) should do.
> >
> > apart form that,
> >
> > Reviewed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> >
>
> Gotcha. Will add this in v3.
>
> Thank you Eugenio!
>
> >>   static void virtqueue_packed_fill_desc(VirtQueue *vq,
> >>                                          const VirtQueueElement *elem,
> >>                                          unsigned int idx,
> >> @@ -923,7 +955,9 @@ void virtqueue_fill(VirtQueue *vq, const VirtQueue=
Element *elem,
> >>           return;
> >>       }
> >>
> >> -    if (virtio_vdev_has_feature(vq->vdev, VIRTIO_F_RING_PACKED)) {
> >> +    if (virtio_vdev_has_feature(vq->vdev, VIRTIO_F_IN_ORDER)) {
> >> +        virtqueue_ordered_fill(vq, elem, len);
> >> +    } else if (virtio_vdev_has_feature(vq->vdev, VIRTIO_F_RING_PACKED=
)) {
> >>           virtqueue_packed_fill(vq, elem, len, idx);
> >>       } else {
> >>           virtqueue_split_fill(vq, elem, len, idx);
> >> --
> >> 2.39.3
> >>
> >
>


