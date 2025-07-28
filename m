Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67884C83F26
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 07:41:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugIT0-0003we-31; Mon, 28 Jul 2025 03:40:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1ugIP5-000167-4Q
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 03:36:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1ugIOz-0003mH-Jb
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 03:36:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753688163;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/ES2nJU5IwOdyBdCtRCBXVMjiU/i5Uq9es+Zy04owIE=;
 b=Mt92Xo/J8NPGRdiVYu0HhCQiBYajgV43CqwjHS+rNrc68aWs+oo0NTZe1wYS+9nPtJx6/y
 w7ULigHqGUrsFmGj1V4G/1yumBOPeOAvCQiB+8yjI12U9aYt8gv55QiTQGGZlTy3hRjiCP
 KKklFocFN76DRSjCsr6LeJ5vSLDb8V4=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-hZpsccx5ODS1_Zv0NtBNSQ-1; Mon, 28 Jul 2025 03:36:02 -0400
X-MC-Unique: hZpsccx5ODS1_Zv0NtBNSQ-1
X-Mimecast-MFC-AGG-ID: hZpsccx5ODS1_Zv0NtBNSQ_1753688161
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3138e64b3f1so6731578a91.3
 for <qemu-devel@nongnu.org>; Mon, 28 Jul 2025 00:36:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753688161; x=1754292961;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/ES2nJU5IwOdyBdCtRCBXVMjiU/i5Uq9es+Zy04owIE=;
 b=b+gyClYpnZqkTmr14zUpnXj00tRWwi5KwQvsuGW35mAL6USep2wcRs7SIt5QsBkMch
 ezUr54802IzfikJrb9XzLfRSt+dAR5VrUrOPh766vXG8MHUODtCIT6KWPaQuMsozGMZK
 Ys9AOu0xP8Lyj59Xa7fnf1TDkV9LIdR+UTWjCvfbAN/+UmYNfijrlmnjsMqZ6Wkp2bDi
 JzISKQOkb2ZVwX+9y2GalQuLsKqzk4GJFEL5GAHEXLed+f5RrzI9XRWTXLEDUe7+/H77
 Qi2/MGHbt0+zQs9tdreRg33v1PXJ5DepMAB52C4AIZHfGL8zTGDjH4ClAE3SrTK5PYm7
 oppg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUK0MuSu0eTgUcPVBUoRFt0XBW97NquF77WQYzSFLqG0Ks7muzgTyh0brIiBbMgxOHEj/IK0jNeGf7L@nongnu.org
X-Gm-Message-State: AOJu0YxSEzh/2ifLJDgpdbmNeGPJZJg+StNbmJ6iTNew0cLWrPKpUuqt
 odNXT2iGsnLPIvY31vv0kTP4cmRe4/ZRxMC3cVSKUB3AsqOiUNhlYwuzrWUwsgcpFvZP+6TgxkX
 mdPCMcQed0E6L+KQjhS83hxlREuvLQs41sQQ+zeCaKo6Of8GKs3h7UF0BXAxiPnm++1vuiYl8Ts
 P97lvVe/SYbEfjcfkFrPwDAe/lxqkO+ho=
X-Gm-Gg: ASbGncvRNQakqCPalTZC9Ovwwlj+0qdMtDjnbvRaNFX0GRdxQL9JRWtMl7usiFSb2Nd
 xuZ45rbuge9o65PukDWfOTMBGXsJjkp4q5GPTnayMEOohHAaAsFsrXLi5qcGfmewZzr3f2aDYzI
 h5LZa3nHtzvi/6ii7Q4JI=
X-Received: by 2002:a17:90b:35cb:b0:312:639:a064 with SMTP id
 98e67ed59e1d1-31e77afec2fmr15667410a91.28.1753688160761; 
 Mon, 28 Jul 2025 00:36:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1c7fTgyjOuyjL9chp7LSZAFBagdwI0U2mtEsN9d9o1URcV3gM1J3PFAwQhNGtHHCxZThOrHjPe8R3jTfLrLU=
X-Received: by 2002:a17:90b:35cb:b0:312:639:a064 with SMTP id
 98e67ed59e1d1-31e77afec2fmr15667372a91.28.1753688160261; Mon, 28 Jul 2025
 00:36:00 -0700 (PDT)
MIME-Version: 1.0
References: <20250722124127.2497406-1-jonah.palmer@oracle.com>
 <CACGkMEvrgAqSr9sgvq6F4oKBitZncqhsB_MEsbaNB7p0ZN5fEA@mail.gmail.com>
 <0f5b804d-3852-4159-b151-308a57f1ec74@oracle.com>
 <20250725053122-mutt-send-email-mst@kernel.org>
 <CACGkMEvTgCAbBG20iLB1m_WfYzMZA7FYZ2FuL6To4EV86PXZbA@mail.gmail.com>
In-Reply-To: <CACGkMEvTgCAbBG20iLB1m_WfYzMZA7FYZ2FuL6To4EV86PXZbA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 28 Jul 2025 15:35:49 +0800
X-Gm-Features: Ac12FXyqd7JR0OzGsvflsIS1NN52iSbomy8B45Qhao0dSXf6eajr6HO8RxblkmI
Message-ID: <CACGkMEtCiqq0P_7aB-d5CrQraHL2xky5Qa+9LyZce4hk+wvvYQ@mail.gmail.com>
Subject: Re: [RFC 0/6] virtio-net: initial iterative live migration support
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jonah Palmer <jonah.palmer@oracle.com>, qemu-devel@nongnu.org,
 peterx@redhat.com, 
 farosas@suse.de, eblake@redhat.com, armbru@redhat.com, si-wei.liu@oracle.com, 
 eperezma@redhat.com, boris.ostrovsky@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Jul 28, 2025 at 3:09=E2=80=AFPM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Fri, Jul 25, 2025 at 5:33=E2=80=AFPM Michael S. Tsirkin <mst@redhat.co=
m> wrote:
> >
> > On Thu, Jul 24, 2025 at 05:59:20PM -0400, Jonah Palmer wrote:
> > >
> > >
> > > On 7/23/25 1:51 AM, Jason Wang wrote:
> > > > On Tue, Jul 22, 2025 at 8:41=E2=80=AFPM Jonah Palmer <jonah.palmer@=
oracle.com> wrote:
> > > > >
> > > > > This series is an RFC initial implementation of iterative live
> > > > > migration for virtio-net devices.
> > > > >
> > > > > The main motivation behind implementing iterative migration for
> > > > > virtio-net devices is to start on heavy, time-consuming operation=
s
> > > > > for the destination while the source is still active (i.e. before
> > > > > the stop-and-copy phase).
> > > >
> > > > It would be better to explain which kind of operations were heavy a=
nd
> > > > time-consuming and how iterative migration help.
> > > >
> > >
> > > You're right. Apologies for being vague here.
> > >
> > > I did do some profiling of the virtio_load call for virtio-net to try=
 and
> > > narrow down where exactly most of the downtime is coming from during =
the
> > > stop-and-copy phase.
> > >
> > > Pretty much the entirety of the downtime comes from the vmstate_load_=
state
> > > call for the vmstate_virtio's subsections:
> > >
> > > /* Subsections */
> > > ret =3D vmstate_load_state(f, &vmstate_virtio, vdev, 1);
> > > if (ret) {
> > >     return ret;
> > > }
> > >
> > > More specifically, the vmstate_virtio_virtqueues and
> > > vmstate_virtio_extra_state subsections.
> > >
> > > For example, currently (with no iterative migration), for a virtio-ne=
t
> > > device, the virtio_load call took 13.29ms to finish. 13.20ms of that =
time
> > > was spent in vmstate_load_state(f, &vmstate_virtio, vdev, 1).
> > >
> > > Of that 13.21ms, ~6.83ms was spent migrating vmstate_virtio_virtqueue=
s and
> > > ~6.33ms was spent migrating the vmstate_virtio_extra_state subsection=
s. And
> > > I believe this is from walking VIRTIO_QUEUE_MAX virtqueues, twice.
> >
> > Can we optimize it simply by sending a bitmap of used vqs?
>
> +1.
>
> For example devices like virtio-net may know exactly the number of
> virtqueues that will be used.

Ok, I think it comes from the following subsections:

static const VMStateDescription vmstate_virtio_virtqueues =3D {
    .name =3D "virtio/virtqueues",
    .version_id =3D 1,
    .minimum_version_id =3D 1,
    .needed =3D &virtio_virtqueue_needed,
    .fields =3D (const VMStateField[]) {
        VMSTATE_STRUCT_VARRAY_POINTER_KNOWN(vq, struct VirtIODevice,
                      VIRTIO_QUEUE_MAX, 0, vmstate_virtqueue, VirtQueue),
        VMSTATE_END_OF_LIST()
    }
};

static const VMStateDescription vmstate_virtio_packed_virtqueues =3D {
    .name =3D "virtio/packed_virtqueues",
    .version_id =3D 1,
    .minimum_version_id =3D 1,
    .needed =3D &virtio_packed_virtqueue_needed,
    .fields =3D (const VMStateField[]) {
        VMSTATE_STRUCT_VARRAY_POINTER_KNOWN(vq, struct VirtIODevice,
                      VIRTIO_QUEUE_MAX, 0, vmstate_packed_virtqueue, VirtQu=
eue),
        VMSTATE_END_OF_LIST()
    }
};

A rough idea is to disable those subsections and use new subsections
instead (and do the compatibility work) like virtio_save():

    for (i =3D 0; i < VIRTIO_QUEUE_MAX; i++) {
        if (vdev->vq[i].vring.num =3D=3D 0)
            break;
    }

    qemu_put_be32(f, i);
    ....

Thanks

>
> >
> > > vmstate_load_state virtio-net v11
> > > vmstate_load_state PCIDevice v2
> > > vmstate_load_state_end PCIDevice end/0
> > > vmstate_load_state virtio-net-device v11
> > > vmstate_load_state virtio-net-queue-tx_waiting v0
> > > vmstate_load_state_end virtio-net-queue-tx_waiting end/0
> > > vmstate_load_state virtio-net-vnet v0
> > > vmstate_load_state_end virtio-net-vnet end/0
> > > vmstate_load_state virtio-net-ufo v0
> > > vmstate_load_state_end virtio-net-ufo end/0
> > > vmstate_load_state virtio-net-tx_waiting v0
> > > vmstate_load_state virtio-net-queue-tx_waiting v0
> > > vmstate_load_state_end virtio-net-queue-tx_waiting end/0
> > > vmstate_load_state virtio-net-queue-tx_waiting v0
> > > vmstate_load_state_end virtio-net-queue-tx_waiting end/0
> > > vmstate_load_state virtio-net-queue-tx_waiting v0
> > > vmstate_load_state_end virtio-net-queue-tx_waiting end/0
> > > vmstate_load_state_end virtio-net-tx_waiting end/0
> > > vmstate_load_state_end virtio-net-device end/0
> > > vmstate_load_state virtio v1
> > > vmstate_load_state virtio/64bit_features v1
> > > vmstate_load_state_end virtio/64bit_features end/0
> > > vmstate_load_state virtio/virtqueues v1
> > > vmstate_load_state virtqueue_state v1  <--- Queue idx 0
> > > ...
> > > vmstate_load_state_end virtqueue_state end/0
> > > vmstate_load_state virtqueue_state v1  <--- Queue idx 1023
> > > vmstate_load_state_end virtqueue_state end/0
> > > vmstate_load_state_end virtio/virtqueues end/0
> > > vmstate_load_state virtio/extra_state v1
> > > vmstate_load_state virtio_pci v1
> > > vmstate_load_state virtio_pci/modern_state v1
> > > vmstate_load_state virtio_pci/modern_queue_state v1  <--- Queue idx 0
> > > vmstate_load_state_end virtio_pci/modern_queue_state end/0
> > > ...
> > > vmstate_load_state virtio_pci/modern_queue_state v1  <--- Queue idx 1=
023
> > > vmstate_load_state_end virtio_pci/modern_queue_state end/0
> > > vmstate_load_state_end virtio_pci/modern_state end/0
> > > vmstate_load_state_end virtio_pci end/0
> > > vmstate_load_state_end virtio/extra_state end/0
> > > vmstate_load_state virtio/started v1
> > > vmstate_load_state_end virtio/started end/0
> > > vmstate_load_state_end virtio end/0
> > > vmstate_load_state_end virtio-net end/0
> > > vmstate_downtime_load type=3Dnon-iterable idstr=3D0000:00:03.0/virtio=
-net
> > > instance_id=3D0 downtime=3D13260
> > >
> > > With iterative migration for virtio-net (maybe all virtio devices?), =
we can
> > > send this early while the source is still running and then only send =
the
> > > deltas during the stop-and-copy phase. It's likely that the source wo=
nt be
> > > using all VIRTIO_QUEUE_MAX virtqueues during the migration period, so=
 this
> > > could really minimize a large majority of the downtime contributed by
> > > virtio-net.
> > >
> > > This could be one example.
>
> Or if the system call is expensive, could we try io_uring to mitigate it.
>
> > >
> > > > >
> > > > > The motivation behind this RFC series specifically is to provide =
an
> > > > > initial framework for such an implementation and get feedback on =
the
> > > > > design and direction.
> > > > > -------
> > > > >
> > > > > This implementation of iterative live migration for a virtio-net =
device
> > > > > is enabled via setting the migration capability 'virtio-iterative=
' to
> > > > > on for both the source & destination, e.g. (HMP):
> > > > >
> > > > > (qemu) migrate_set_capability virtio-iterative on
> > > > >
> > > > > The virtio-net device's SaveVMHandlers hooks are registered/unreg=
istered
> > > > > during the device's realize/unrealize phase.
> > > >
> > > > I wonder about the plan for libvirt support.
> > > >
> > >
> > > Could you elaborate on this a bit?
>
> I meant how this feature will be supported by the libvirt.
>
> > >
> > > > >
> > > > > Currently, this series only sends and loads the vmstate at the st=
art of
> > > > > migration. The vmstate is still sent (again) during the stop-and-=
copy
> > > > > phase, as it is today, to handle any deltas in the state since it=
 was
> > > > > initially sent. A future patch in this series could avoid having =
to
> > > > > re-send and re-load the entire state again and instead focus only=
 on the
> > > > > deltas.
> > > > >
> > > > > There is a slight, modest improvement in guest-visible downtime f=
rom
> > > > > this series. More specifically, when using iterative live migrati=
on with
> > > > > a virtio-net device, the downtime contributed by migrating a virt=
io-net
> > > > > device decreased from ~3.2ms to ~1.4ms on average:
> > > >
> > > > Are you testing this via a software virtio device or hardware one?
> > > >
> > >
> > > Just software (virtio-device, vhost-net) with these numbers. I can ru=
n some
> > > tests with vDPA hardware though.
>
> I see. Considering you see great improvement with software devices. It
> should be sufficient.
>
> > >
> > > Those numbers were from a simple, 1 queue-pair virtio-net device.
>
> Thanks
>
> > >
> > > > >
> > > > > Before:
> > > > > -------
> > > > > vmstate_downtime_load type=3Dnon-iterable idstr=3D0000:00:03.0/vi=
rtio-net
> > > > >    instance_id=3D0 downtime=3D3594
> > > > >
> > > > > After:
> > > > > ------
> > > > > vmstate_downtime_load type=3Dnon-iterable idstr=3D0000:00:03.0/vi=
rtio-net
> > > > >    instance_id=3D0 downtime=3D1607
> > > > >
> > > > > This slight improvement is likely due to the initial vmstate_load=
_state
> > > > > call "warming up" pages in memory such that, when it's called a s=
econd
> > > > > time during the stop-and-copy phase, allocation and page-fault la=
tencies
> > > > > are reduced.
> > > > > -------
> > > > >
> > > > > Comments, suggestions, etc. are welcome here.
> > > > >
> > > > > Jonah Palmer (6):
> > > > >    migration: Add virtio-iterative capability
> > > > >    virtio-net: Reorder vmstate_virtio_net and helpers
> > > > >    virtio-net: Add SaveVMHandlers for iterative migration
> > > > >    virtio-net: iter live migration - migrate vmstate
> > > > >    virtio,virtio-net: skip consistency check in virtio_load for i=
terative
> > > > >      migration
> > > > >    virtio-net: skip vhost_started assertion during iterative migr=
ation
> > > > >
> > > > >   hw/net/virtio-net.c            | 246 ++++++++++++++++++++++++++=
+------
> > > > >   hw/virtio/virtio.c             |  32 +++--
> > > > >   include/hw/virtio/virtio-net.h |   8 ++
> > > > >   include/hw/virtio/virtio.h     |   7 +
> > > > >   migration/savevm.c             |   1 +
> > > > >   qapi/migration.json            |   7 +-
> > > > >   6 files changed, 247 insertions(+), 54 deletions(-)
> > > > >
> > > > > --
> > > > > 2.47.1
> > > >
> > > > Thanks
> > > >
> > > > >
> > > >
> >


