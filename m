Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 711D2C28B20
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Mar 2025 07:53:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ty4WE-0008Km-JD; Fri, 28 Mar 2025 03:52:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1ty4WB-0008J1-8P
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 03:52:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1ty4W5-0005Cg-JF
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 03:52:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743148355;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4HIvNwBPwfOWlv9sGnbfEpzBAuf2q1lGMqVaiPlYBRY=;
 b=E50ywrmNndrQdYsdik5G8PIlC9q/I37pY6n2accVmcl5oTSaP+KtK8dSlzfhmEqQ+9r4HD
 zMlFjsjxBf8O2KysmBxvd180slPHWkFV2V73unoVdA5ReFMe7y3LXWfsueuITYLymT9n/I
 cA55IhtD1+13Ot4yCE5QIlu8RVAIa68=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-mvIUPoC9OCyNKFDEz5hpRw-1; Fri, 28 Mar 2025 03:52:33 -0400
X-MC-Unique: mvIUPoC9OCyNKFDEz5hpRw-1
X-Mimecast-MFC-AGG-ID: mvIUPoC9OCyNKFDEz5hpRw_1743148353
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2ff7aecba07so3190375a91.2
 for <qemu-devel@nongnu.org>; Fri, 28 Mar 2025 00:52:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743148353; x=1743753153;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4HIvNwBPwfOWlv9sGnbfEpzBAuf2q1lGMqVaiPlYBRY=;
 b=HZxOMVKMDfKjmfSkaYDCDMBv7OL+3bLdVHIZQ14xpEm038GlP/bzfMrj31eUHiRF8Z
 klf9SrGsqGdwssNliG7MqLYz+UJY+qHn98Nxem78kkFLzuVeoiNZRJSmb6KWaVdh5je+
 SAoMX+5jRW4kXMTVzKYEBdH14dTnsH4WmCONPsPM82ir2S7BnUXoqW8WPa92EE1N9rlG
 1g+1kw4Pi2FxXscJbVDFl9FPsKLGY9TCi19mH0Riv2T2TEnjlSb15R5mJCH+MxGc8t34
 NFeI/1FMTHUne0Bref6yy83vZHdbMVt7aKlwwVYBr7rz4nbm88Ra6lphqkAL2IZUBKu4
 WnbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCULG+wchQR0WyKORCq/Bieq7BmefaDtvv8LyOUzku11kEqoLRGUJcIaIVjr1ozAli4ov1VFR4j4FIxq@nongnu.org
X-Gm-Message-State: AOJu0Yx5PBA2dGJwEHjZBaTRYVfO4yPSS/FxVNF6NeVRySgKAeECVVmn
 sIV/jRSY5qB26sgcmO1+j4AbEI0ht39+b7wjr4VykcnofduGkmL1/vZ8Bh0xG0nPV/PskqTR3BS
 G7OLQzccOFUkqioJ7Gisb5SEmYahDr0t4DuJVCp02MZ1oQ/NrqcSCDQilXYwTMhPVj/z4DgPCR+
 w0CtM5bbwB3Yndb5MaObzmmqnC0xw=
X-Gm-Gg: ASbGncu+herBpYs9IIpbzaTe1k5wDR3V3Rmi0YTMQOy3BAI33OjwTBt1STIQsIn7Xjt
 9J4IHHV9xwyY1+Ysw2qGgmljMeNPETscJ3Dm0l8y1L3bcS2ByX/3MW2XIt4G/KYGeaGrgceU=
X-Received: by 2002:a17:90b:534d:b0:2f9:c144:9d13 with SMTP id
 98e67ed59e1d1-303a906c683mr10046202a91.24.1743148352633; 
 Fri, 28 Mar 2025 00:52:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9Io3Tx95ydC1+v6Ab3MyPOZUwxlChy79sfVGSWV0eN4iqoeAfa7LWM/xP7DBZIIWtyF74vSxd2WfkEyHnSjc=
X-Received: by 2002:a17:90b:534d:b0:2f9:c144:9d13 with SMTP id
 98e67ed59e1d1-303a906c683mr10046163a91.24.1743148352137; Fri, 28 Mar 2025
 00:52:32 -0700 (PDT)
MIME-Version: 1.0
References: <20250324135929.74945-1-sahilcdq@proton.me>
 <20250324135929.74945-4-sahilcdq@proton.me>
 <a878b49b-0d00-483a-a5b6-27d048c4ebc7@gmail.com>
 <CAJaqyWdAX6=ZvJdugW2_SmjQDZ31EhMfn=qodoWkZmjd2kY73A@mail.gmail.com>
 <2fa2b2b2-dc9f-4a63-b24f-50cb190dadcf@gmail.com>
In-Reply-To: <2fa2b2b2-dc9f-4a63-b24f-50cb190dadcf@gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 28 Mar 2025 08:51:55 +0100
X-Gm-Features: AQ5f1JrL9DioL5IBfef-2t0cnbprg-8iMnKeU-n-rO0xMMsqQiMRJtvJxN59cSg
Message-ID: <CAJaqyWfwUqek9McKYZoDpPxf-woxw0g8AJ589W9t6LSdqzdniQ@mail.gmail.com>
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

On Thu, Mar 27, 2025 at 7:42=E2=80=AFPM Sahil Siddiq <icegambit91@gmail.com=
> wrote:
>
> Hi,
>
> On 3/26/25 1:33 PM, Eugenio Perez Martin wrote:
> > On Mon, Mar 24, 2025 at 3:14=E2=80=AFPM Sahil Siddiq <icegambit91@gmail=
.com> wrote:
> >> On 3/24/25 7:29 PM, Sahil Siddiq wrote:
> >>> Implement the insertion of available buffers in the descriptor area o=
f
> >>> packed shadow virtqueues. It takes into account descriptor chains, bu=
t
> >>> does not consider indirect descriptors.
> >>>
> >>> Enable the packed SVQ to forward the descriptors to the device.
> >>>
> >>> Signed-off-by: Sahil Siddiq <sahilcdq@proton.me>
> >>> ---
> >>> Changes from v4 -> v5:
> >>> - This was commit #2 in v4. This has been reordered to commit #3
> >>>     based on review comments.
> >>> - vhost-shadow-virtqueue.c:
> >>>     (vhost_svq_valid_features): Move addition of enums to commit #6
> >>>     based on review comments.
> >>>     (vhost_svq_add_packed): Set head_idx to buffer id instead of vrin=
g's
> >>>     index.
> >>>     (vhost_svq_kick): Split into vhost_svq_kick_split and
> >>>     vhost_svq_kick_packed.
> >>>     (vhost_svq_add): Use new vhost_svq_kick_* functions.
> >>>
> >>>    hw/virtio/vhost-shadow-virtqueue.c | 117 +++++++++++++++++++++++++=
++--
> >>>    1 file changed, 112 insertions(+), 5 deletions(-)
> >>>
> >>> diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-sha=
dow-virtqueue.c
> >>> index 4f74ad402a..6e16cd4bdf 100644
> >>> --- a/hw/virtio/vhost-shadow-virtqueue.c
> >>> +++ b/hw/virtio/vhost-shadow-virtqueue.c
> >>> @@ -193,10 +193,83 @@ static void vhost_svq_add_split(VhostShadowVirt=
queue *svq,
> >>>        /* Update the avail index after write the descriptor */
> >>>        smp_wmb();
> >>>        avail->idx =3D cpu_to_le16(svq->shadow_avail_idx);
> >>> +}
> >>> +
> >>> +/**
> >>> + * Write descriptors to SVQ packed vring
> >>> + *
> >>> + * @svq: The shadow virtqueue
> >>> + * @out_sg: The iovec to the guest
> >>> + * @out_num: Outgoing iovec length
> >>> + * @in_sg: The iovec from the guest
> >>> + * @in_num: Incoming iovec length
> >>> + * @sgs: Cache for hwaddr
> >>> + * @head: Saves current free_head
> >>> + */
> >>> +static void vhost_svq_add_packed(VhostShadowVirtqueue *svq,
> >>> +                                 const struct iovec *out_sg, size_t =
out_num,
> >>> +                                 const struct iovec *in_sg, size_t i=
n_num,
> >>> +                                 hwaddr *sgs, unsigned *head)
> >>> +{
> >>> +    uint16_t id, curr, i, head_flags =3D 0, head_idx;
> >>> +    size_t num =3D out_num + in_num;
> >>> +    unsigned n;
> >>> +
> >>> +    struct vring_packed_desc *descs =3D svq->vring_packed.vring.desc=
;
> >>> +
> >>> +    head_idx =3D svq->vring_packed.next_avail_idx;
> >>
> >> Since "svq->vring_packed.next_avail_idx" is part of QEMU internals and=
 not
> >> stored in guest memory, no endianness conversion is required here, rig=
ht?
> >>
> >
> > Right!
>
> Understood.
>
> >>> +    i =3D head_idx;
> >>> +    id =3D svq->free_head;
> >>> +    curr =3D id;
> >>> +    *head =3D id;
> >>
> >> Should head be the buffer id or the idx of the descriptor ring where t=
he
> >> first descriptor of a descriptor chain is inserted?
> >>
> >
> > The buffer id of the *last* descriptor of a chain. See "2.8.6 Next
> > Flag: Descriptor Chaining" at [1].
>
> Ah, yes. The second half of my question in incorrect.
>
> The tail descriptor of the chain includes the buffer id. In this implemen=
tation
> we place the same tail buffer id in other locations of the descriptor rin=
g since
> they will be ignored anyway [1].
>
> The explanation below frames my query better.
>
> >>> +    /* Write descriptors to SVQ packed vring */
> >>> +    for (n =3D 0; n < num; n++) {
> >>> +        uint16_t flags =3D cpu_to_le16(svq->vring_packed.avail_used_=
flags |
> >>> +                                     (n < out_num ? 0 : VRING_DESC_F=
_WRITE) |
> >>> +                                     (n + 1 =3D=3D num ? 0 : VRING_D=
ESC_F_NEXT));
> >>> +        if (i =3D=3D head_idx) {
> >>> +            head_flags =3D flags;
> >>> +        } else {
> >>> +            descs[i].flags =3D flags;
> >>> +        }
> >>> +
> >>> +        descs[i].addr =3D cpu_to_le64(sgs[n]);
> >>> +        descs[i].id =3D id;
> >>> +        if (n < out_num) {
> >>> +            descs[i].len =3D cpu_to_le32(out_sg[n].iov_len);
> >>> +        } else {
> >>> +            descs[i].len =3D cpu_to_le32(in_sg[n - out_num].iov_len)=
;
> >>> +        }
> >>> +
> >>> +        curr =3D cpu_to_le16(svq->desc_next[curr]);
> >>> +
> >>> +        if (++i >=3D svq->vring_packed.vring.num) {
> >>> +            i =3D 0;
> >>> +            svq->vring_packed.avail_used_flags ^=3D
> >>> +                1 << VRING_PACKED_DESC_F_AVAIL |
> >>> +                1 << VRING_PACKED_DESC_F_USED;
> >>> +        }
> >>> +    }
> >>>
> >>> +    if (i <=3D head_idx) {
> >>> +        svq->vring_packed.avail_wrap_counter ^=3D 1;
> >>> +    }
> >>> +
> >>> +    svq->vring_packed.next_avail_idx =3D i;
> >>> +    svq->shadow_avail_idx =3D i;
> >>> +    svq->free_head =3D curr;
> >>> +
> >>> +    /*
> >>> +     * A driver MUST NOT make the first descriptor in the list
> >>> +     * available before all subsequent descriptors comprising
> >>> +     * the list are made available.
> >>> +     */
> >>> +    smp_wmb();
> >>> +    svq->vring_packed.vring.desc[head_idx].flags =3D head_flags;
> >>>    }
> >>>
> >>> -static void vhost_svq_kick(VhostShadowVirtqueue *svq)
> >>> +static void vhost_svq_kick_split(VhostShadowVirtqueue *svq)
> >>>    {
> >>>        bool needs_kick;
> >>>
> >>> @@ -209,7 +282,8 @@ static void vhost_svq_kick(VhostShadowVirtqueue *=
svq)
> >>>        if (virtio_vdev_has_feature(svq->vdev, VIRTIO_RING_F_EVENT_IDX=
)) {
> >>>            uint16_t avail_event =3D le16_to_cpu(
> >>>                    *(uint16_t *)(&svq->vring.used->ring[svq->vring.nu=
m]));
> >>> -        needs_kick =3D vring_need_event(avail_event, svq->shadow_ava=
il_idx, svq->shadow_avail_idx - 1);
> >>> +        needs_kick =3D vring_need_event(avail_event, svq->shadow_ava=
il_idx,
> >>> +                     svq->shadow_avail_idx - 1);
> >>>        } else {
> >>>            needs_kick =3D
> >>>                    !(svq->vring.used->flags & cpu_to_le16(VRING_USED_=
F_NO_NOTIFY));
> >>> @@ -222,6 +296,30 @@ static void vhost_svq_kick(VhostShadowVirtqueue =
*svq)
> >>>        event_notifier_set(&svq->hdev_kick);
> >>>    }
> >>>
> >>> +static void vhost_svq_kick_packed(VhostShadowVirtqueue *svq)
> >>> +{
> >>> +    bool needs_kick;
> >>> +
> >>> +    /*
> >>> +     * We need to expose the available array entries before checking
> >>> +     * notification suppressions.
> >>> +     */
> >>> +    smp_mb();
> >>> +
> >>> +    if (virtio_vdev_has_feature(svq->vdev, VIRTIO_RING_F_EVENT_IDX))=
 {
> >>> +        return;
> >>> +    } else {
> >>> +        needs_kick =3D (svq->vring_packed.vring.device->flags !=3D
> >>> +                      cpu_to_le16(VRING_PACKED_EVENT_FLAG_DISABLE));
> >>> +    }
> >>> +
> >>> +    if (!needs_kick) {
> >>> +        return;
> >>> +    }
> >>> +
> >>> +    event_notifier_set(&svq->hdev_kick);
> >>> +}
> >>> +
> >>>    /**
> >>>     * Add an element to a SVQ.
> >>>     *
> >>> @@ -258,13 +356,22 @@ int vhost_svq_add(VhostShadowVirtqueue *svq, co=
nst struct iovec *out_sg,
> >>>            return -EINVAL;
> >>>        }
> >>>
> >>> -    vhost_svq_add_split(svq, out_sg, out_num, in_sg,
> >>> -                        in_num, sgs, &qemu_head);
> >>> +    if (svq->is_packed) {
> >>> +        vhost_svq_add_packed(svq, out_sg, out_num, in_sg,
> >>> +                             in_num, sgs, &qemu_head);
> >>> +    } else {
> >>> +        vhost_svq_add_split(svq, out_sg, out_num, in_sg,
> >>> +                            in_num, sgs, &qemu_head);
> >>> +    }
> >>>
> >>>        svq->num_free -=3D ndescs;
> >>>        svq->desc_state[qemu_head].elem =3D elem;
> >>>        svq->desc_state[qemu_head].ndescs =3D ndescs;
> >>
> >> *head in vhost_svq_add_packed() is stored in "qemu_head" here.
> >>
> >
> > Sorry I don't get this, can you expand?
>
> Sure. In vhost_svq_add(), after the descriptors have been added
> (either using vhost_svq_add_split or vhost_svq_add_packed),
> VirtQueueElement elem and ndescs are both saved in the
> svq->desc_state array. "elem" and "ndescs" are later used when
> the guest consumes used descriptors from the device in
> vhost_svq_get_buf_(split|packed).
>
> For split vqs, the index of svq->desc where elem and ndescs are
> saved matches the index of the descriptor ring where the head of
> the descriptor ring is placed.
>
> In vhost_svq_add_split:
>
> *head =3D svq->free_head;
> [...]
> avail_idx =3D svq->shadow_avail_idx & (svq->vring.num - 1);
> avail->ring[avail_idx] =3D cpu_to_le16(*head);
>
> "qemu_head" in vhost_svq_add gets its value from "*head" in
> vhost_svq_add_split:
>
> svq->desc_state[qemu_head].elem =3D elem;
> svq->desc_state[qemu_head].ndescs =3D ndescs;
>
> For packed vq, something similar has to be done. My approach was
> to have the index of svq->desc_state match the buffer id in the
> tail of the descriptor ring.
>
> The entire chain is written to the descriptor ring in the loop
> in vhost_svq_add_packed. I am not sure if the index of
> svq->desc_state should be the buffer id or if it should be a
> descriptor index ("head_idx" or the index corresponding to the
> tail of the chain).
>

I think both approaches should be valid. My advice is to follow
Linux's code and let it be the tail descriptor id. This descriptor id
is pushed and popped from vq->free_head in a stack style.

In addition to that, Linux also sets the same id to all the chain
elements. I think this is useful when dealing with bad devices. In
particular, QEMU's packed vq implementation looked at the first
desciptor's id, which is an incorrect behavior.


