Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11DA1C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 07:39:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJptw-0003Lt-Vg; Wed, 19 Jun 2024 03:38:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1sJptv-0003LX-5s
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 03:38:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1sJpts-0003eO-M7
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 03:38:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718782714;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QRhkercVm4n7oWg2lncgBCNrVSl4qnWtp1hjUikIQVE=;
 b=QBRnm2srUt3AatMD3w5Yhx3eeRGMCX/k7uH8tfyfc1q+Xs2ZODnTS9bNF2qLQNU+vZm2No
 PvE6gcYmJTn4/oyRLf9EqwtnEBmIW6OctdvahKYl2i3G+AxgA4nEedd4ONMlz0lH5VLKpK
 MVb0eU4kZEFPmH4OHu96mVVlgcLiVR8=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-140-p6NeGe3KOn6AwK6s7R3sPg-1; Wed, 19 Jun 2024 03:38:31 -0400
X-MC-Unique: p6NeGe3KOn6AwK6s7R3sPg-1
Received: by mail-yb1-f199.google.com with SMTP id
 3f1490d57ef6-dfefc2c8569so12924160276.3
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2024 00:38:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718782711; x=1719387511;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QRhkercVm4n7oWg2lncgBCNrVSl4qnWtp1hjUikIQVE=;
 b=bwLKi7UKtUdGY2Jc/LLUiJjZMn9+4DM2u15anP6Sqo0xq0rVtUGXBm4wb/vty+/SP5
 wiY9431cB9vVrc868bomlaaWFlDIWlkDXCOug9+K5poSxqlWE1crA/zRVaN99aEbdwtd
 Cgc2RqG6FVSpRWz8VbODvby3in8qXr5d29g6ljGl9E2eILYTtNWjFsOGLW2FmRMitloW
 pkJAlxOFue8/fcsjMuB6ZJqk5SRC5ZMp3yBk07CN5eMW/1Od9yfygU88VCbtDnZdIFCr
 7CFH6ZQEEXhvN26hZacmeUpSGzeRNqfF4QzFZ9BgCnvCtiD/pKGzG4XvI12EHE19aZJL
 f7jQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlur3GZ2Ceg5CkHHU/ZLicGK7EppVepSRqme4jKJQkLTaVXzb5RqgP6c44Kb1gVLqoCEXE2jjapEgjALSL9R+i0TJ+j4c=
X-Gm-Message-State: AOJu0YwoMu1eXb8aPMKCDSmzTTfyvXPivUuMQiXDnSwJ/ZoFTL7KTn0o
 jMUQSxoEQ5VaAc/PosWuqWpCyU0tCwcN9QKhjLHXAXOlblHd3OCYZUsuHf92q0WUQKC6tGg/F47
 hvwTq9WRJzbDvg8qQh3PISlRJic9AmlSqpp3zxsJJH2saWnmvBSWK4P+lZcnZyAycWBtt27Pq6Z
 ik6Kuj9ECGD+XFnaJlp0//0lZLE8U=
X-Received: by 2002:a25:ad23:0:b0:e02:b804:f5b1 with SMTP id
 3f1490d57ef6-e02be13f45cmr2234552276.21.1718782710992; 
 Wed, 19 Jun 2024 00:38:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlEKOOShKvNk3ABMRoeF6vtJ/n/7FE3gYYUmJz50lEmr4GvsqD0k3ceqQPEHyG56sCu7+PK3oNjC8GwL0mO9w=
X-Received: by 2002:a25:ad23:0:b0:e02:b804:f5b1 with SMTP id
 3f1490d57ef6-e02be13f45cmr2234539276.21.1718782710452; Wed, 19 Jun 2024
 00:38:30 -0700 (PDT)
MIME-Version: 1.0
References: <20240618181834.14173-1-sahilcdq@proton.me>
 <3813507.kQq0lBPeGt@valdaarhun>
In-Reply-To: <3813507.kQq0lBPeGt@valdaarhun>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 19 Jun 2024 09:37:54 +0200
Message-ID: <CAJaqyWcjfaU9mcdTsE2LkL755UCWU-KQ4jz83trr_T0C2ZaGhw@mail.gmail.com>
Subject: Re: [RFC] vhost: Introduce packed vq and add buffer elements
To: Sahil <icegambit91@gmail.com>
Cc: sgarzare@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, 
 Sahil Siddiq <sahilcdq@proton.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Jun 18, 2024 at 8:58=E2=80=AFPM Sahil <icegambit91@gmail.com> wrote=
:
>
> Hi,
>
> On Tuesday, June 18, 2024 11:48:34=E2=80=AFPM GMT+5:30 Sahil Siddiq wrote=
:
> > [...]
> >
> >  hw/virtio/vhost-shadow-virtqueue.c | 124 ++++++++++++++++++++++++++++-
> >  hw/virtio/vhost-shadow-virtqueue.h |  66 ++++++++++-----
> >  2 files changed, 167 insertions(+), 23 deletions(-)
> >
> > diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shado=
w-virtqueue.c
> > index fc5f408f77..e3b276a9e9 100644
> > --- a/hw/virtio/vhost-shadow-virtqueue.c
> > +++ b/hw/virtio/vhost-shadow-virtqueue.c
> > @@ -217,6 +217,122 @@ static bool vhost_svq_add_split(VhostShadowVirtqu=
eue *svq,
> >      return true;
> >  }
> >
> > +/**
> > + * Write descriptors to SVQ packed vring
> > + *
> > + * @svq: The shadow virtqueue
> > + * @sg: Cache for hwaddr
> > + * @out_sg: The iovec from the guest that is read-only for device
> > + * @out_num: iovec length
> > + * @in_sg: The iovec from the guest that is write-only for device
> > + * @in_num: iovec length
> > + * @head_flags: flags for first descriptor in list
> > + *
> > + * Return true if success, false otherwise and print error.
> > + */
> > +static bool vhost_svq_vring_write_descs_packed(VhostShadowVirtqueue *s=
vq, hwaddr *sg,
> > +                                        const struct iovec *out_sg, si=
ze_t out_num,
> > +                                        const struct iovec *in_sg, siz=
e_t in_num,
> > +                                        uint16_t *head_flags)
> > +{
> > +    uint16_t id, curr, head, i;
> > +    unsigned n;
> > +    struct vring_packed_desc *descs =3D svq->vring_packed.vring.desc;
> > +    bool ok;
> > +
> > +    head =3D svq->vring_packed.next_avail_idx;
> > +    i =3D head;
> > +    id =3D svq->free_head;
> > +    curr =3D id;
> > +
> > +    size_t num =3D out_num + in_num;
> > +
> > +    if (num =3D=3D 0) {
> > +        return true;
> > +    }
> > +
> > +    ok =3D vhost_svq_translate_addr(svq, sg, out_sg, out_num);
> > +    if (unlikely(!ok)) {
> > +        return false;
> > +    }
> > +
> > +    ok =3D vhost_svq_translate_addr(svq, sg + out_num, in_sg, in_num);
> > +    if (unlikely(!ok)) {
> > +        return false;
> > +    }
> > +
> > +    for (n =3D 0; n < num; n++) {
> > +        uint16_t flags =3D cpu_to_le16(svq->vring_packed.avail_used_fl=
ags |
> > +                (n < out_num ? 0 : VRING_DESC_F_WRITE) |
> > +                (n + 1 =3D=3D num ? 0 : VRING_DESC_F_NEXT));
> > +        if (i =3D=3D head) {
> > +            *head_flags =3D flags;
> > +        } else {
> > +            descs[i].flags =3D flags;
> > +        }
> > +
> > +        descs[i].addr =3D cpu_to_le64(sg[n]);
> > +        descs[i].id =3D id;
> > +        if (n < out_num) {
> > +            descs[i].len =3D cpu_to_le32(out_sg[n].iov_len);
> > +        } else {
> > +            descs[i].len =3D cpu_to_le32(in_sg[n - out_num].iov_len);
> > +        }
> > +
> > +        curr =3D cpu_to_le16(svq->desc_next[curr]);
>
> "curr" is being updated here, but descs[i].id is always set to id which d=
oesn't change in
> the loop. So all the descriptors in the chain will have the same id. I ca=
n't find anything
> in the virtio specification [1] that suggests that all descriptors in the=
 chain have the same
> id. Also, going by the figure captioned "Three chained descriptors availa=
ble" in the blog
> post on packed virtqueues [2], it looks like the descriptors in the chain=
 have different
> buffer ids.
>
> The virtio implementation in Linux also reuses the same id value for all =
the descriptors in a
> single chain. I am not sure if I am missing something here.
>

The code is right, the id that identifies the whole chain is just the
one on the last descriptor. The key is that all the tail descriptors
of the chains will have a different id, the rest ids are ignored so it
is easier this way. I got it wrong in a recent mail in the list, where
you can find more information. Let me know if you cannot find it :).

In the split vq is different as a chained descriptor can go back and
forth in the descriptor ring with the next id. So all of them must be
different. But in the packed vq, the device knows the next descriptor
is placed at the next entry in the descriptor ring, so the only
important id is the last one.

> > +        if (++i >=3D svq->vring_packed.vring.num) {
> > +            i =3D 0;
> > +            svq->vring_packed.avail_used_flags ^=3D
> > +                    1 << VRING_PACKED_DESC_F_AVAIL |
> > +                    1 << VRING_PACKED_DESC_F_USED;
> > +        }
> > +    }
> > +
> > +    if (i <=3D head) {
> > +        svq->vring_packed.avail_wrap_counter ^=3D 1;
> > +    }
> > +
> > +    svq->vring_packed.next_avail_idx =3D i;
> > +    svq->free_head =3D curr;
>
> Even though the same id is used, curr will not be id+1 here.
>

curr is not the descriptor index, but the id. They're used in a stack
format: One available chain pops an id and one used id pushes its id
in the stack.

Maybe I'm wrong, but I think the main reason is to reuse the same
memory region of the descriptor state etc so less memory is changed to
be used in all the operations.

> > +    return true;
> > +}
> > +
> > +static bool vhost_svq_add_packed(VhostShadowVirtqueue *svq,
> > +                                const struct iovec *out_sg, size_t out=
_num,
> > +                                const struct iovec *in_sg, size_t in_n=
um,
> > +                                unsigned *head)
> > +{
> > +    bool ok;
> > +    uint16_t head_flags =3D 0;
> > +    g_autofree hwaddr *sgs =3D g_new(hwaddr, out_num + in_num);
>
> I chose to use out_num+in_num as the size instead of MAX(ount_num, in_num=
). I
> found it easier to implement "vhost_svq_vring_write_descs_packed()" like =
this.
> Please let me know if this isn't feasible or ideal.
>

Not a big deal, I picked the MAX just because it is all the
hwaddresses the function needs at the same time. Addition should work
too, and AFAIK chains are usually short. We should get rid of this
dynamic allocation in the future anyway.

> > +    *head =3D svq->vring_packed.next_avail_idx;
> > +
> > +    /* We need some descriptors here */
> > +    if (unlikely(!out_num && !in_num)) {
> > +        qemu_log_mask(LOG_GUEST_ERROR,
> > +                      "Guest provided element with no descriptors");
> > +        return false;
> > +    }
> > +
> > +    ok =3D vhost_svq_vring_write_descs_packed(svq, sgs, out_sg, out_nu=
m,
> > +                                            in_sg, in_num, &head_flags=
);
> > +    if (unlikely(!ok)) {
> > +        return false;
> > +    }
> > +
> > +    /*
> > +     * A driver MUST NOT make the first descriptor in the list
> > +     * available before all subsequent descriptors comprising
> > +     * the list are made available.
> > +     */
> > +    smp_wmb();
> > +    svq->vring_packed.vring.desc[*head].flags =3D head_flags;
> > +
> > +    return true;
> > +}
> > +
> >  static void vhost_svq_kick(VhostShadowVirtqueue *svq)
> >  {
> >      bool needs_kick;
> > @@ -258,7 +374,13 @@ int vhost_svq_add(VhostShadowVirtqueue *svq, const=
 struct iovec *out_sg,
> >          return -ENOSPC;
> >      }
> >
> > -    ok =3D vhost_svq_add_split(svq, out_sg, out_num, in_sg, in_num, &q=
emu_head);
> > +    if (virtio_vdev_has_feature(svq->vdev, VIRTIO_F_RING_PACKED)) {
> > +        ok =3D vhost_svq_add_packed(svq, out_sg, out_num,
> > +                                  in_sg, in_num, &qemu_head);
> > +    } else {
> > +        ok =3D vhost_svq_add_split(svq, out_sg, out_num,
> > +                                 in_sg, in_num, &qemu_head);
> > +    }
> >      if (unlikely(!ok)) {
> >          return -EINVAL;
> >      }
> > diff --git a/hw/virtio/vhost-shadow-virtqueue.h b/hw/virtio/vhost-shado=
w-virtqueue.h
> > index 19c842a15b..ee1a87f523 100644
> > --- a/hw/virtio/vhost-shadow-virtqueue.h
> > +++ b/hw/virtio/vhost-shadow-virtqueue.h
> > @@ -46,10 +46,53 @@ typedef struct VhostShadowVirtqueueOps {
> >      VirtQueueAvailCallback avail_handler;
> >  } VhostShadowVirtqueueOps;
> >
> > +struct vring_packed {
> > +    /* Actual memory layout for this queue. */
> > +    struct {
> > +        unsigned int num;
> > +        struct vring_packed_desc *desc;
> > +        struct vring_packed_desc_event *driver;
> > +        struct vring_packed_desc_event *device;
> > +    } vring;
> > +
> > +    /* Avail used flags. */
> > +    uint16_t avail_used_flags;
> > +
> > +    /* Index of the next avail descriptor. */
> > +    uint16_t next_avail_idx;
> > +
> > +    /* Driver ring wrap counter */
> > +    bool avail_wrap_counter;
> > +};
> > +
> >  /* Shadow virtqueue to relay notifications */
> >  typedef struct VhostShadowVirtqueue {
> > +    /* Virtio queue shadowing */
> > +    VirtQueue *vq;
> > +
> > +    /* Virtio device */
> > +    VirtIODevice *vdev;
> > +
> > +    /* SVQ vring descriptors state */
> > +    SVQDescState *desc_state;
> > +
> > +    /*
> > +     * Backup next field for each descriptor so we can recover securel=
y, not
> > +     * needing to trust the device access.
> > +     */
> > +    uint16_t *desc_next;
> > +
> > +    /* Next free descriptor */
> > +    uint16_t free_head;
> > +
> > +    /* Size of SVQ vring free descriptors */
> > +    uint16_t num_free;
> > +
> >      /* Shadow vring */
> > -    struct vring vring;
> > +    union {
> > +        struct vring vring;
> > +        struct vring_packed vring_packed;
> > +    };
> >
> >      /* Shadow kick notifier, sent to vhost */
> >      EventNotifier hdev_kick;
> > @@ -69,27 +112,12 @@ typedef struct VhostShadowVirtqueue {
> >      /* Guest's call notifier, where the SVQ calls guest. */
> >      EventNotifier svq_call;
> >
> > -    /* Virtio queue shadowing */
> > -    VirtQueue *vq;
> > -
> > -    /* Virtio device */
> > -    VirtIODevice *vdev;
> > -
> >      /* IOVA mapping */
> >      VhostIOVATree *iova_tree;
> >
> > -    /* SVQ vring descriptors state */
> > -    SVQDescState *desc_state;
> > -
> >      /* Next VirtQueue element that guest made available */
> >      VirtQueueElement *next_guest_avail_elem;
> >
> > -    /*
> > -     * Backup next field for each descriptor so we can recover securel=
y, not
> > -     * needing to trust the device access.
> > -     */
> > -    uint16_t *desc_next;
> > -
> >      /* Caller callbacks */
> >      const VhostShadowVirtqueueOps *ops;
> >
> > @@ -99,17 +127,11 @@ typedef struct VhostShadowVirtqueue {
> >      /* Next head to expose to the device */
> >      uint16_t shadow_avail_idx;
> >
> > -    /* Next free descriptor */
> > -    uint16_t free_head;
> > -
> >      /* Last seen used idx */
> >      uint16_t shadow_used_idx;
> >
> >      /* Next head to consume from the device */
> >      uint16_t last_used_idx;
> > -
> > -    /* Size of SVQ vring free descriptors */
> > -    uint16_t num_free;
> >  } VhostShadowVirtqueue;
> >
> >  bool vhost_svq_valid_features(uint64_t features, Error **errp);
> > --
> > 2.45.2
> >
>
> In "struct VhostShadowVirtqueue", I rearranged the order in which some me=
mbers appear.
> I tried to keep the members common to split and packed virtqueues above t=
he union and
> the rest below the union. I haven't entirely understood the role of some =
of the members
> (for example, VhostShadowVirtqueueOps *ops). I'll change this ordering if=
 need be as I
> continue to understand them better.
>

That's fine, but do it in a separate patch for future series, so it is
easier to review.

ops is used when a kind of device wants specialized handling for the
descriptors forwarded. vdpa-net uses it when QEMU also needs to
inspect the descriptors. Feel free to ask more about it, but adding
packed format to SVQ should not affect the ops member.

> For the next step, I think I should work on "vhost_svq_start()" which is =
where members of
> the struct are actually initialized. At the moment, only the split ring p=
art of the structure is
> initialized.
>

Sounds reasonable. My recommendation is to mimic the patches of the
kernel, doing a git log and following that order. You also need to
apply the fixes in the history from that moment.

> I think I should also start working on enhancing "vhost_svq_kick()" to ac=
tually send the buffers
> to the device. I think it'll be easier to test these changes once that's =
done (I am not sure about
> this though). Would this involve implementing the notification mechanism =
and event_idx?
>

You can start omitting event_idx if you disable it from the device or
from qemu's commandline with event_idx=3Doff. If you use vdpa_sim, it's
easier to remove it using qemu's cmdline in my opinion. Also, there is
a needs_kick boolean that you can set to always true for testing
purposes, since it is valid to send extra notifications. I think you
don't need to modify anything else from vhost_svq_kick to test the
device receives the buffer, but let me know if you find problems.

Thanks!

> Thanks,
> Sahil
>
> [1] https://docs.oasis-open.org/virtio/virtio/v1.3/csd01/virtio-v1.3-csd0=
1.html#x1-720008
> [2] https://www.redhat.com/en/blog/packed-virtqueue-how-reduce-overhead-v=
irtio
>
>


