Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2814EC3600E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 08:04:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txLjz-0006oi-Td; Wed, 26 Mar 2025 04:03:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1txLjy-0006oV-Hx
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 04:03:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1txLjv-0007Pu-UK
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 04:03:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742976234;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p17Gyc8KM3sO3ECFKMRQ1WTq16uzasIlGV7XQ3r0hL4=;
 b=U8Jz+lTu3qccYMA9/1Sv4AdqZVWc+2IF06Q1hEFTnHjSQKQU38g+yGJYisQSIy8rQIudE9
 baIPc38EPhvCUUdviziTPbR99w+7VT4Qf8LxiCtTh5mMu2xHb+9OTRnk4B3yp0gqWvLcFb
 ZK+m2DdkcsSZ3C2Zsi60zMJUo/BviWA=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-Olo6GG1xM6yb5jBKD4gEZw-1; Wed, 26 Mar 2025 04:03:53 -0400
X-MC-Unique: Olo6GG1xM6yb5jBKD4gEZw-1
X-Mimecast-MFC-AGG-ID: Olo6GG1xM6yb5jBKD4gEZw_1742976232
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3011bee1751so10473585a91.1
 for <qemu-devel@nongnu.org>; Wed, 26 Mar 2025 01:03:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742976232; x=1743581032;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p17Gyc8KM3sO3ECFKMRQ1WTq16uzasIlGV7XQ3r0hL4=;
 b=K5xVJ7o1TSrzvo7sdgP39vKgqAIgmNWRfwkovmXuF7LJ8jP3N/GWkm1KqQExXuhCxu
 Ljd3Uva4VbHxn8DZ0U2ofugR33fb0O/pHs61IR7A3XHBBVLOUw3z35PIuh4T5xeAfSdt
 igfTDNHsuLJPCR58yy0FUdKlgqULZwL2KfMQYjPuNtS9NxUCJgQ6CceEsi+8V9EGNMEb
 glyjrqOAjmrt3BvPBPPDXaERYDz3lI6BiqAv3unNQLKfVB2gUjhi3cKBiQDn7CsneYUT
 Jrqnaito9ysjHOQV1DRLbvF4akzdODnN2JrQd/6Rk/tKwUDFcifNpgnbMrhGcREJQHS1
 ctRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCMQ+sX+TYJ3+bZwNoCwtDgwUgj3XD/6FxF5ZD5Qrt8sUe5DS2WdyPVUudIl7zMVTQFVrJxOBaTGAf@nongnu.org
X-Gm-Message-State: AOJu0YyKRZASNtPJ8AOHn4QWkWq+9J4FBmERG1TQ92dlt/al0Px8nVci
 pL7vuyzzjZwbKsWrQYRXhowuDpo1kIa2sbkYzWLmWNXsdJMnos9ibzGzuz45AmFXyUeLNeUSRKI
 hR4H2HBPRm4IYu24Z9p10QX9bSmqhhoNu7bVSie/Wp3GRBdF5XOkYFr0VeZmH0EsWxHnnryKd4c
 bzlmG5218/oSqZrArzt0LdbP4mUDA=
X-Gm-Gg: ASbGncsMatDORP3zUaU0E/H3zwS/5EjmF7T0RqqisVDAK6Asrs/tQfrXkguo90f6I0J
 uXvhJUzy3uyHDoRbVGfOTh16mx6WSGzgWvxalsDTjInuMt1zGDlsvH5oZWlXyxmP//vg3wTo=
X-Received: by 2002:a17:90b:48c2:b0:2fa:15ab:4de7 with SMTP id
 98e67ed59e1d1-3030fe83954mr41032757a91.12.1742976232027; 
 Wed, 26 Mar 2025 01:03:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmGp4PpVOdPtKLeG0/HA2ZsyXdif5rYB8/d8PZ2NgzoN+R7WPPXC3EtiycgdYl/nGNs7C+zh4hYtlcw+l5w2Y=
X-Received: by 2002:a17:90b:48c2:b0:2fa:15ab:4de7 with SMTP id
 98e67ed59e1d1-3030fe83954mr41032715a91.12.1742976231659; Wed, 26 Mar 2025
 01:03:51 -0700 (PDT)
MIME-Version: 1.0
References: <20250324135929.74945-1-sahilcdq@proton.me>
 <20250324135929.74945-4-sahilcdq@proton.me>
 <a878b49b-0d00-483a-a5b6-27d048c4ebc7@gmail.com>
In-Reply-To: <a878b49b-0d00-483a-a5b6-27d048c4ebc7@gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 26 Mar 2025 09:03:14 +0100
X-Gm-Features: AQ5f1JpKK4JVSO6S5X5deVHD_vz-hasY1tg1kZfycqrDZ_mf9RzQJ2oB8IRTwoo
Message-ID: <CAJaqyWdAX6=ZvJdugW2_SmjQDZ31EhMfn=qodoWkZmjd2kY73A@mail.gmail.com>
Subject: Re: [RFC v5 3/7] vhost: Forward descriptors to device via packed SVQ
To: Sahil Siddiq <icegambit91@gmail.com>
Cc: sgarzare@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, 
 sahilcdq@proton.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon, Mar 24, 2025 at 3:14=E2=80=AFPM Sahil Siddiq <icegambit91@gmail.com=
> wrote:
>
> Hi,
>
> I had a few queries here.
>
> On 3/24/25 7:29 PM, Sahil Siddiq wrote:
> > Implement the insertion of available buffers in the descriptor area of
> > packed shadow virtqueues. It takes into account descriptor chains, but
> > does not consider indirect descriptors.
> >
> > Enable the packed SVQ to forward the descriptors to the device.
> >
> > Signed-off-by: Sahil Siddiq <sahilcdq@proton.me>
> > ---
> > Changes from v4 -> v5:
> > - This was commit #2 in v4. This has been reordered to commit #3
> >    based on review comments.
> > - vhost-shadow-virtqueue.c:
> >    (vhost_svq_valid_features): Move addition of enums to commit #6
> >    based on review comments.
> >    (vhost_svq_add_packed): Set head_idx to buffer id instead of vring's
> >    index.
> >    (vhost_svq_kick): Split into vhost_svq_kick_split and
> >    vhost_svq_kick_packed.
> >    (vhost_svq_add): Use new vhost_svq_kick_* functions.
> >
> >   hw/virtio/vhost-shadow-virtqueue.c | 117 +++++++++++++++++++++++++++-=
-
> >   1 file changed, 112 insertions(+), 5 deletions(-)
> >
> > diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shado=
w-virtqueue.c
> > index 4f74ad402a..6e16cd4bdf 100644
> > --- a/hw/virtio/vhost-shadow-virtqueue.c
> > +++ b/hw/virtio/vhost-shadow-virtqueue.c
> > @@ -193,10 +193,83 @@ static void vhost_svq_add_split(VhostShadowVirtqu=
eue *svq,
> >       /* Update the avail index after write the descriptor */
> >       smp_wmb();
> >       avail->idx =3D cpu_to_le16(svq->shadow_avail_idx);
> > +}
> > +
> > +/**
> > + * Write descriptors to SVQ packed vring
> > + *
> > + * @svq: The shadow virtqueue
> > + * @out_sg: The iovec to the guest
> > + * @out_num: Outgoing iovec length
> > + * @in_sg: The iovec from the guest
> > + * @in_num: Incoming iovec length
> > + * @sgs: Cache for hwaddr
> > + * @head: Saves current free_head
> > + */
> > +static void vhost_svq_add_packed(VhostShadowVirtqueue *svq,
> > +                                 const struct iovec *out_sg, size_t ou=
t_num,
> > +                                 const struct iovec *in_sg, size_t in_=
num,
> > +                                 hwaddr *sgs, unsigned *head)
> > +{
> > +    uint16_t id, curr, i, head_flags =3D 0, head_idx;
> > +    size_t num =3D out_num + in_num;
> > +    unsigned n;
> > +
> > +    struct vring_packed_desc *descs =3D svq->vring_packed.vring.desc;
> > +
> > +    head_idx =3D svq->vring_packed.next_avail_idx;
>
> Since "svq->vring_packed.next_avail_idx" is part of QEMU internals and no=
t
> stored in guest memory, no endianness conversion is required here, right?
>

Right!

> > +    i =3D head_idx;
> > +    id =3D svq->free_head;
> > +    curr =3D id;
> > +    *head =3D id;
>
> Should head be the buffer id or the idx of the descriptor ring where the
> first descriptor of a descriptor chain is inserted?
>

The buffer id of the *last* descriptor of a chain. See "2.8.6 Next
Flag: Descriptor Chaining" at [1].

> > +    /* Write descriptors to SVQ packed vring */
> > +    for (n =3D 0; n < num; n++) {
> > +        uint16_t flags =3D cpu_to_le16(svq->vring_packed.avail_used_fl=
ags |
> > +                                     (n < out_num ? 0 : VRING_DESC_F_W=
RITE) |
> > +                                     (n + 1 =3D=3D num ? 0 : VRING_DES=
C_F_NEXT));
> > +        if (i =3D=3D head_idx) {
> > +            head_flags =3D flags;
> > +        } else {
> > +            descs[i].flags =3D flags;
> > +        }
> > +
> > +        descs[i].addr =3D cpu_to_le64(sgs[n]);
> > +        descs[i].id =3D id;
> > +        if (n < out_num) {
> > +            descs[i].len =3D cpu_to_le32(out_sg[n].iov_len);
> > +        } else {
> > +            descs[i].len =3D cpu_to_le32(in_sg[n - out_num].iov_len);
> > +        }
> > +
> > +        curr =3D cpu_to_le16(svq->desc_next[curr]);
> > +
> > +        if (++i >=3D svq->vring_packed.vring.num) {
> > +            i =3D 0;
> > +            svq->vring_packed.avail_used_flags ^=3D
> > +                1 << VRING_PACKED_DESC_F_AVAIL |
> > +                1 << VRING_PACKED_DESC_F_USED;
> > +        }
> > +    }
> >
> > +    if (i <=3D head_idx) {
> > +        svq->vring_packed.avail_wrap_counter ^=3D 1;
> > +    }
> > +
> > +    svq->vring_packed.next_avail_idx =3D i;
> > +    svq->shadow_avail_idx =3D i;
> > +    svq->free_head =3D curr;
> > +
> > +    /*
> > +     * A driver MUST NOT make the first descriptor in the list
> > +     * available before all subsequent descriptors comprising
> > +     * the list are made available.
> > +     */
> > +    smp_wmb();
> > +    svq->vring_packed.vring.desc[head_idx].flags =3D head_flags;
> >   }
> >
> > -static void vhost_svq_kick(VhostShadowVirtqueue *svq)
> > +static void vhost_svq_kick_split(VhostShadowVirtqueue *svq)
> >   {
> >       bool needs_kick;
> >
> > @@ -209,7 +282,8 @@ static void vhost_svq_kick(VhostShadowVirtqueue *sv=
q)
> >       if (virtio_vdev_has_feature(svq->vdev, VIRTIO_RING_F_EVENT_IDX)) =
{
> >           uint16_t avail_event =3D le16_to_cpu(
> >                   *(uint16_t *)(&svq->vring.used->ring[svq->vring.num])=
);
> > -        needs_kick =3D vring_need_event(avail_event, svq->shadow_avail=
_idx, svq->shadow_avail_idx - 1);
> > +        needs_kick =3D vring_need_event(avail_event, svq->shadow_avail=
_idx,
> > +                     svq->shadow_avail_idx - 1);
> >       } else {
> >           needs_kick =3D
> >                   !(svq->vring.used->flags & cpu_to_le16(VRING_USED_F_N=
O_NOTIFY));
> > @@ -222,6 +296,30 @@ static void vhost_svq_kick(VhostShadowVirtqueue *s=
vq)
> >       event_notifier_set(&svq->hdev_kick);
> >   }
> >
> > +static void vhost_svq_kick_packed(VhostShadowVirtqueue *svq)
> > +{
> > +    bool needs_kick;
> > +
> > +    /*
> > +     * We need to expose the available array entries before checking
> > +     * notification suppressions.
> > +     */
> > +    smp_mb();
> > +
> > +    if (virtio_vdev_has_feature(svq->vdev, VIRTIO_RING_F_EVENT_IDX)) {
> > +        return;
> > +    } else {
> > +        needs_kick =3D (svq->vring_packed.vring.device->flags !=3D
> > +                      cpu_to_le16(VRING_PACKED_EVENT_FLAG_DISABLE));
> > +    }
> > +
> > +    if (!needs_kick) {
> > +        return;
> > +    }
> > +
> > +    event_notifier_set(&svq->hdev_kick);
> > +}
> > +
> >   /**
> >    * Add an element to a SVQ.
> >    *
> > @@ -258,13 +356,22 @@ int vhost_svq_add(VhostShadowVirtqueue *svq, cons=
t struct iovec *out_sg,
> >           return -EINVAL;
> >       }
> >
> > -    vhost_svq_add_split(svq, out_sg, out_num, in_sg,
> > -                        in_num, sgs, &qemu_head);
> > +    if (svq->is_packed) {
> > +        vhost_svq_add_packed(svq, out_sg, out_num, in_sg,
> > +                             in_num, sgs, &qemu_head);
> > +    } else {
> > +        vhost_svq_add_split(svq, out_sg, out_num, in_sg,
> > +                            in_num, sgs, &qemu_head);
> > +    }
> >
> >       svq->num_free -=3D ndescs;
> >       svq->desc_state[qemu_head].elem =3D elem;
> >       svq->desc_state[qemu_head].ndescs =3D ndescs;
>
> *head in vhost_svq_add_packed() is stored in "qemu_head" here.
>

Sorry I don't get this, can you expand?

[1] https://docs.oasis-open.org/virtio/virtio/v1.3/virtio-v1.3.html

> > -    vhost_svq_kick(svq);
> > +    if (svq->is_packed) {
> > +        vhost_svq_kick_packed(svq);
> > +    } else {
> > +        vhost_svq_kick_split(svq);
> > +    }
> >       return 0;
> >   }
> >
>
> Thanks,
> Sahil
>


