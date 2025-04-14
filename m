Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 693C0C369A2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 15:09:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4LQN-0006xt-1M; Mon, 14 Apr 2025 11:08:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1u4LQ3-0006rA-Jf
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 11:08:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1u4LQ0-00072E-M8
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 11:08:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744643294;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xsH1kP3ojqCRtEu6esIqRExLaxMVL1Ah8sWWpxCI2fA=;
 b=VZccbVPIj0UdYnNo/oSXrarzaZdhotBW7krtdmAHgVQAPCm/MaphnjvFilWpNHUlzBX3sP
 X+u98TTb9lVzqNRGeJCNcme2dXyynibgw3960fbAGH57hwDzt6uaXmNG2tzoFqd9PWnPEj
 rgkHHV5Pa2sb3IkiTl4mrg3y13f3m2o=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-PB6b0KaGMCycgOH-B6MlDg-1; Mon, 14 Apr 2025 11:08:13 -0400
X-MC-Unique: PB6b0KaGMCycgOH-B6MlDg-1
X-Mimecast-MFC-AGG-ID: PB6b0KaGMCycgOH-B6MlDg_1744643292
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-30828f9af10so6182835a91.3
 for <qemu-devel@nongnu.org>; Mon, 14 Apr 2025 08:08:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744643291; x=1745248091;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xsH1kP3ojqCRtEu6esIqRExLaxMVL1Ah8sWWpxCI2fA=;
 b=GaVxExE5G8hLt/aeG3pvJ4GnsDXaVelkepyymV/mXXVwD73I6uj5e2a9XUJLfS9jqU
 bW/pPPq/E0loBUMxWhUh9DmlmuJQDg/j2/iFDbGCxsflnjqflq8jRCnFae27E2PL3CEq
 s4VUQ9msPCMnRB/fFoh4FGx0PWSQXku5fSTvjrKqMqbC/amztanUxqWP5B0SfOE40A3x
 JEY+KLiHWfuEYJ2FB34htsry/nS2i1nfvqw53Ovd/HdD4SY6EAXGjmy9riW7HQht6rVJ
 U33J4x63Hn30COtD2zkHYT+zRfjisiTttKUIErDaULyJqYi6ucJPPLEkXUX2RAmNETBl
 S4JQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVo/QMYvtS48XU2LfvvWe9bAmCWGshw+tsF8zSCm4xeAD0HHpwWCFqI/9AKuvDEQ9a1O0KGG219Qeyq@nongnu.org
X-Gm-Message-State: AOJu0Yxp6ABjgo+aIF9cBBqMzfAS1CHDDqOEt1QZFKhS7bRqu4dbtV0W
 BHNj5q3F2Bt03W/nbT2oLsWfA3CVBeK9t98b6771lsCXWDkTsAK9KvcGlzIS3trAUKNj3V+hzni
 IKZ7dQ5C3AqKIWNqOjVs4RiD3GCcYFK0W6LS3ZjL2LMVlo2wJIybleOi8Pk32WShIdfdFwtV00c
 4X/rwy9nu4qHgyN8hgxryX3Vc4s50bBATGeZo=
X-Gm-Gg: ASbGncswxnPYy7b8TJhXGUKUZY8om8nk01FhqQPllCI5JXaA9KolHHl9CvNdYcoJTMO
 UevNoauj9yycC1G33/4JF6IpKP6xti/2IcUN4hM520mkLMNagH3TYm8eoYkKjanduoFA=
X-Received: by 2002:a17:90b:3bc4:b0:2f8:49ad:4079 with SMTP id
 98e67ed59e1d1-3082363452cmr17297832a91.6.1744643291239; 
 Mon, 14 Apr 2025 08:08:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEv/7TW0ndkQH10iXfLreKzSJ1tam1E+hl8QoDbDFYcci1HynEN5rTSsWeD+R3wU6HzFmyabS8uFUAXTrDhmLk=
X-Received: by 2002:a17:90b:3bc4:b0:2f8:49ad:4079 with SMTP id
 98e67ed59e1d1-3082363452cmr17297789a91.6.1744643290760; Mon, 14 Apr 2025
 08:08:10 -0700 (PDT)
MIME-Version: 1.0
References: <20250324135929.74945-1-sahilcdq@proton.me>
 <20250324135929.74945-4-sahilcdq@proton.me>
 <a878b49b-0d00-483a-a5b6-27d048c4ebc7@gmail.com>
 <CAJaqyWdAX6=ZvJdugW2_SmjQDZ31EhMfn=qodoWkZmjd2kY73A@mail.gmail.com>
 <2fa2b2b2-dc9f-4a63-b24f-50cb190dadcf@gmail.com>
 <CAJaqyWfwUqek9McKYZoDpPxf-woxw0g8AJ589W9t6LSdqzdniQ@mail.gmail.com>
 <5f970447-2547-4ce2-8d27-420540d5896b@gmail.com>
In-Reply-To: <5f970447-2547-4ce2-8d27-420540d5896b@gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 14 Apr 2025 17:07:32 +0200
X-Gm-Features: ATxdqUFAL0guZOcGmkZG9U88MI6N2RQr2FvGYQrU8_llYOxJj1AfY4tr4ySvYHY
Message-ID: <CAJaqyWdJCaP79Pvy1YgkrZC4p7HBsg1U5MDmQR-LLDFmrBGSzg@mail.gmail.com>
Subject: Re: [RFC v5 3/7] vhost: Forward descriptors to device via packed SVQ
To: Sahil Siddiq <icegambit91@gmail.com>
Cc: sgarzare@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, 
 sahilcdq@proton.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Mon, Apr 14, 2025 at 11:38=E2=80=AFAM Sahil Siddiq <icegambit91@gmail.co=
m> wrote:
>
> Hi,
>
> On 3/28/25 1:21 PM, Eugenio Perez Martin wrote:
> > On Thu, Mar 27, 2025 at 7:42=E2=80=AFPM Sahil Siddiq <icegambit91@gmail=
.com> wrote:
> >> On 3/26/25 1:33 PM, Eugenio Perez Martin wrote:
> >>> On Mon, Mar 24, 2025 at 3:14=E2=80=AFPM Sahil Siddiq <icegambit91@gma=
il.com> wrote:
> >>>> On 3/24/25 7:29 PM, Sahil Siddiq wrote:
> >>>>> Implement the insertion of available buffers in the descriptor area=
 of
> >>>>> packed shadow virtqueues. It takes into account descriptor chains, =
but
> >>>>> does not consider indirect descriptors.
> >>>>>
> >>>>> Enable the packed SVQ to forward the descriptors to the device.
> >>>>>
> >>>>> Signed-off-by: Sahil Siddiq <sahilcdq@proton.me>
> >>>>> ---
> >>>>> [...]
> >>>>> +
> >>>>> +/**
> >>>>> + * Write descriptors to SVQ packed vring
> >>>>> + *
> >>>>> + * @svq: The shadow virtqueue
> >>>>> + * @out_sg: The iovec to the guest
> >>>>> + * @out_num: Outgoing iovec length
> >>>>> + * @in_sg: The iovec from the guest
> >>>>> + * @in_num: Incoming iovec length
> >>>>> + * @sgs: Cache for hwaddr
> >>>>> + * @head: Saves current free_head
> >>>>> + */
> >>>>> +static void vhost_svq_add_packed(VhostShadowVirtqueue *svq,
> >>>>> +                                 const struct iovec *out_sg, size_=
t out_num,
> >>>>> +                                 const struct iovec *in_sg, size_t=
 in_num,
> >>>>> +                                 hwaddr *sgs, unsigned *head)
> >>>>> +{
> >>>>> +    uint16_t id, curr, i, head_flags =3D 0, head_idx;
> >>>>> +    size_t num =3D out_num + in_num;
> >>>>> +    unsigned n;
> >>>>> +
> >>>>> +    struct vring_packed_desc *descs =3D svq->vring_packed.vring.de=
sc;
> >>>>> +
> >>>>> +    head_idx =3D svq->vring_packed.next_avail_idx;
> >>>>
> >>>> Since "svq->vring_packed.next_avail_idx" is part of QEMU internals a=
nd not
> >>>> stored in guest memory, no endianness conversion is required here, r=
ight?
> >>>>
> >>>
> >>> Right!
> >>
> >> Understood.
> >>
> >>>>> +    i =3D head_idx;
> >>>>> +    id =3D svq->free_head;
> >>>>> +    curr =3D id;
> >>>>> +    *head =3D id;
> >>>>
> >>>> Should head be the buffer id or the idx of the descriptor ring where=
 the
> >>>> first descriptor of a descriptor chain is inserted?
> >>>>
> >>>
> >>> The buffer id of the *last* descriptor of a chain. See "2.8.6 Next
> >>> Flag: Descriptor Chaining" at [1].
> >>
> >> Ah, yes. The second half of my question in incorrect.
> >>
> >> The tail descriptor of the chain includes the buffer id. In this imple=
mentation
> >> we place the same tail buffer id in other locations of the descriptor =
ring since
> >> they will be ignored anyway [1].
> >>
> >> The explanation below frames my query better.
> >>
> >>>>> +    /* Write descriptors to SVQ packed vring */
> >>>>> +    for (n =3D 0; n < num; n++) {
> >>>>> +        uint16_t flags =3D cpu_to_le16(svq->vring_packed.avail_use=
d_flags |
> >>>>> +                                     (n < out_num ? 0 : VRING_DESC=
_F_WRITE) |
> >>>>> +                                     (n + 1 =3D=3D num ? 0 : VRING=
_DESC_F_NEXT));
> >>>>> +        if (i =3D=3D head_idx) {
> >>>>> +            head_flags =3D flags;
> >>>>> +        } else {
> >>>>> +            descs[i].flags =3D flags;
> >>>>> +        }
> >>>>> +
> >>>>> +        descs[i].addr =3D cpu_to_le64(sgs[n]);
> >>>>> +        descs[i].id =3D id;
> >>>>> +        if (n < out_num) {
> >>>>> +            descs[i].len =3D cpu_to_le32(out_sg[n].iov_len);
> >>>>> +        } else {
> >>>>> +            descs[i].len =3D cpu_to_le32(in_sg[n - out_num].iov_le=
n);
> >>>>> +        }
> >>>>> +
> >>>>> +        curr =3D cpu_to_le16(svq->desc_next[curr]);
> >>>>> +
> >>>>> +        if (++i >=3D svq->vring_packed.vring.num) {
> >>>>> +            i =3D 0;
> >>>>> +            svq->vring_packed.avail_used_flags ^=3D
> >>>>> +                1 << VRING_PACKED_DESC_F_AVAIL |
> >>>>> +                1 << VRING_PACKED_DESC_F_USED;
> >>>>> +        }
> >>>>> +    }
> >>>>>
> >>>>> +    if (i <=3D head_idx) {
> >>>>> +        svq->vring_packed.avail_wrap_counter ^=3D 1;
> >>>>> +    }
> >>>>> +
> >>>>> +    svq->vring_packed.next_avail_idx =3D i;
> >>>>> +    svq->shadow_avail_idx =3D i;
> >>>>> +    svq->free_head =3D curr;
> >>>>> +
> >>>>> +    /*
> >>>>> +     * A driver MUST NOT make the first descriptor in the list
> >>>>> +     * available before all subsequent descriptors comprising
> >>>>> +     * the list are made available.
> >>>>> +     */
> >>>>> +    smp_wmb();
> >>>>> +    svq->vring_packed.vring.desc[head_idx].flags =3D head_flags;
> >>>>>     }
> >>>>>
> >>>>> [...]
> >>>>> @@ -258,13 +356,22 @@ int vhost_svq_add(VhostShadowVirtqueue *svq, =
const struct iovec *out_sg,
> >>>>>             return -EINVAL;
> >>>>>         }
> >>>>>
> >>>>> -    vhost_svq_add_split(svq, out_sg, out_num, in_sg,
> >>>>> -                        in_num, sgs, &qemu_head);
> >>>>> +    if (svq->is_packed) {
> >>>>> +        vhost_svq_add_packed(svq, out_sg, out_num, in_sg,
> >>>>> +                             in_num, sgs, &qemu_head);
> >>>>> +    } else {
> >>>>> +        vhost_svq_add_split(svq, out_sg, out_num, in_sg,
> >>>>> +                            in_num, sgs, &qemu_head);
> >>>>> +    }
> >>>>>
> >>>>>         svq->num_free -=3D ndescs;
> >>>>>         svq->desc_state[qemu_head].elem =3D elem;
> >>>>>         svq->desc_state[qemu_head].ndescs =3D ndescs;
> >>>>
> >>>> *head in vhost_svq_add_packed() is stored in "qemu_head" here.
> >>>>
> >>>
> >>> Sorry I don't get this, can you expand?
> >>
> >> Sure. In vhost_svq_add(), after the descriptors have been added
> >> (either using vhost_svq_add_split or vhost_svq_add_packed),
> >> VirtQueueElement elem and ndescs are both saved in the
> >> svq->desc_state array. "elem" and "ndescs" are later used when
> >> the guest consumes used descriptors from the device in
> >> vhost_svq_get_buf_(split|packed).
> >>
> >> For split vqs, the index of svq->desc where elem and ndescs are
> >> saved matches the index of the descriptor ring where the head of
> >> the descriptor ring is placed.
> >>
> >> In vhost_svq_add_split:
> >>
> >> *head =3D svq->free_head;
> >> [...]
> >> avail_idx =3D svq->shadow_avail_idx & (svq->vring.num - 1);
> >> avail->ring[avail_idx] =3D cpu_to_le16(*head);
> >>
> >> "qemu_head" in vhost_svq_add gets its value from "*head" in
> >> vhost_svq_add_split:
> >>
> >> svq->desc_state[qemu_head].elem =3D elem;
> >> svq->desc_state[qemu_head].ndescs =3D ndescs;
> >>
> >> For packed vq, something similar has to be done. My approach was
> >> to have the index of svq->desc_state match the buffer id in the
> >> tail of the descriptor ring.
> >>
> >> The entire chain is written to the descriptor ring in the loop
> >> in vhost_svq_add_packed. I am not sure if the index of
> >> svq->desc_state should be the buffer id or if it should be a
> >> descriptor index ("head_idx" or the index corresponding to the
> >> tail of the chain).
> >>
> >
> > I think both approaches should be valid. My advice is to follow
> > Linux's code and let it be the tail descriptor id. This descriptor id
> > is pushed and popped from vq->free_head in a stack style.
> >
> > In addition to that, Linux also sets the same id to all the chain
> > elements. I think this is useful when dealing with bad devices. In
> > particular,
>
> Understood. So far, I have implemented this so it matches the
> implementation in Linux.
>
> > QEMU's packed vq implementation looked at the first
> > desciptor's id, which is an incorrect behavior.
>
> Are you referring to:
>
> 1. svq->desc_state[qemu_head].elem =3D elem (in vhost_svq_add()), and
> 2. *head =3D id (in vhost_svq_add_packed())
>

I meant "it used to use the first descriptor id by mistake". It was
fixed in commit 33abfea23959 ("hw/virtio: Fix obtain the buffer id
from the last descriptor"). It is better to set the descriptor id in
all the descriptors of the chain, so if QEMU does not contain this
patch in the nested VM case it can still work with this version.


