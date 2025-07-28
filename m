Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3389CC87FCE
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 07:10:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugHzD-0004of-DT; Mon, 28 Jul 2025 03:09:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1ugHzB-0004mc-Pe
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 03:09:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1ugHz8-0000Fl-Uw
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 03:09:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753686559;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B5cq3ejceGnySzvjhPipmku1TFZuu0/CsirQBjjZ9ZY=;
 b=PBVSNP7jPRfDRE22ySC7gAm2eB+aPKzO4vzpHYPVjrOCl9vvhsmteGu1yn/OFomi3qr3dy
 oDJbKxoDMH3KRVciuRC805FEj2zSv5NkTF7UtrrtZ037qhZe79IIJPiwSSbpAzSUjyEgua
 PxfRgm2yOIN+2srw9mWQZqjOxMI4828=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-NTmQlBZYNWmsaC_JoYW8rA-1; Mon, 28 Jul 2025 03:09:17 -0400
X-MC-Unique: NTmQlBZYNWmsaC_JoYW8rA-1
X-Mimecast-MFC-AGG-ID: NTmQlBZYNWmsaC_JoYW8rA_1753686556
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-31327b2f8e4so3788243a91.1
 for <qemu-devel@nongnu.org>; Mon, 28 Jul 2025 00:09:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753686556; x=1754291356;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B5cq3ejceGnySzvjhPipmku1TFZuu0/CsirQBjjZ9ZY=;
 b=afYDE/f8aYVS0e7tJzgLqhn6uv/fLq3uhuT7jM4SujoBBfJxWYCX70P/LIZ8CzShBY
 ABHnrcnUjgMcunfnobuWYQiwtIMJZ8KJn07gBU+PM5SlDMBtcvxAqioW1dVct+CqyiYX
 8zEFM9T4Uox19lhJ8rqLPOdNNNNV9ioyrjlkJAH9hBwp/2A9xDdhRUmGHSVGpvfCmJg6
 IOWR/n86PNjgBsTYsL0rGobdJC2AQP9o3gyH++AwaRi8fxkUH8sZ3Jl8db8seMxH6KPV
 gxRkTSohx3W86tIgT/qLBvM+PVTLK/MC84izR2J6UdBdVTm7+7v6G+tPzfqYeqpGqm4F
 AKsg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYQ579ld+rpWw2ZLLKLEBf4tEcLlB4Wi/rJjrxsfOiSdYT3qzL9p1xCn/qfTZXX6cbSgHYb/fUu3uR@nongnu.org
X-Gm-Message-State: AOJu0Yy2+AocNRnmRvbU8h62OV3GUz0/5PFNlqG6Byr8ApaFasIN+M2w
 h00KSCCl+j/ZNDQURK6+ArUsXlWxo9maKivfYhYq7qgMRulJE6gFEJtBghE79FeqR47wBFVFM7U
 KeNQKQA0tmNmnzf3qEiVs3Qf7boEmm4VxY3CMb9i51+of2p71DW9SgRMeO+NfQxqXC4dFpdyuqO
 F8SzgGeuxoLbxv24K8M+3jKettXPdkVMw=
X-Gm-Gg: ASbGnct4CZeahaYCoWnR9XH1HxiGUXAlH8LJLzAbN/+6t3wNuytG4KNuNKY6lBGD6Tx
 8429PdUdkquA4LK4i0ErY02mjeTg6Gbb6qXEcSEqcRBm6Mp6kpNy2+OWqh3nWlWkT8KeByg6LuA
 FC7sILx7ozMkrZ7GxQz439BQ==
X-Received: by 2002:a17:90b:5608:b0:31e:8203:4b9d with SMTP id
 98e67ed59e1d1-31e82034c24mr12977999a91.29.1753686556049; 
 Mon, 28 Jul 2025 00:09:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYleuO1p53L8N3FNG3cuq3Qof/ZoRSAKiBsDW4qRjfFQ3pJpeqMIj4RsP4HWwtRds9zMQtoUO2ize3+KkGniY=
X-Received: by 2002:a17:90b:5608:b0:31e:8203:4b9d with SMTP id
 98e67ed59e1d1-31e82034c24mr12977953a91.29.1753686555479; Mon, 28 Jul 2025
 00:09:15 -0700 (PDT)
MIME-Version: 1.0
References: <20250722124127.2497406-1-jonah.palmer@oracle.com>
 <CACGkMEvrgAqSr9sgvq6F4oKBitZncqhsB_MEsbaNB7p0ZN5fEA@mail.gmail.com>
 <0f5b804d-3852-4159-b151-308a57f1ec74@oracle.com>
 <20250725053122-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250725053122-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 28 Jul 2025 15:09:03 +0800
X-Gm-Features: Ac12FXytOUqhpTDoFHEFv_v7C1WzICLhkaa-IhTKZAId3ymTwxa_CL_tni4aSbY
Message-ID: <CACGkMEvTgCAbBG20iLB1m_WfYzMZA7FYZ2FuL6To4EV86PXZbA@mail.gmail.com>
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

On Fri, Jul 25, 2025 at 5:33=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Thu, Jul 24, 2025 at 05:59:20PM -0400, Jonah Palmer wrote:
> >
> >
> > On 7/23/25 1:51 AM, Jason Wang wrote:
> > > On Tue, Jul 22, 2025 at 8:41=E2=80=AFPM Jonah Palmer <jonah.palmer@or=
acle.com> wrote:
> > > >
> > > > This series is an RFC initial implementation of iterative live
> > > > migration for virtio-net devices.
> > > >
> > > > The main motivation behind implementing iterative migration for
> > > > virtio-net devices is to start on heavy, time-consuming operations
> > > > for the destination while the source is still active (i.e. before
> > > > the stop-and-copy phase).
> > >
> > > It would be better to explain which kind of operations were heavy and
> > > time-consuming and how iterative migration help.
> > >
> >
> > You're right. Apologies for being vague here.
> >
> > I did do some profiling of the virtio_load call for virtio-net to try a=
nd
> > narrow down where exactly most of the downtime is coming from during th=
e
> > stop-and-copy phase.
> >
> > Pretty much the entirety of the downtime comes from the vmstate_load_st=
ate
> > call for the vmstate_virtio's subsections:
> >
> > /* Subsections */
> > ret =3D vmstate_load_state(f, &vmstate_virtio, vdev, 1);
> > if (ret) {
> >     return ret;
> > }
> >
> > More specifically, the vmstate_virtio_virtqueues and
> > vmstate_virtio_extra_state subsections.
> >
> > For example, currently (with no iterative migration), for a virtio-net
> > device, the virtio_load call took 13.29ms to finish. 13.20ms of that ti=
me
> > was spent in vmstate_load_state(f, &vmstate_virtio, vdev, 1).
> >
> > Of that 13.21ms, ~6.83ms was spent migrating vmstate_virtio_virtqueues =
and
> > ~6.33ms was spent migrating the vmstate_virtio_extra_state subsections.=
 And
> > I believe this is from walking VIRTIO_QUEUE_MAX virtqueues, twice.
>
> Can we optimize it simply by sending a bitmap of used vqs?

+1.

For example devices like virtio-net may know exactly the number of
virtqueues that will be used.

>
> > vmstate_load_state virtio-net v11
> > vmstate_load_state PCIDevice v2
> > vmstate_load_state_end PCIDevice end/0
> > vmstate_load_state virtio-net-device v11
> > vmstate_load_state virtio-net-queue-tx_waiting v0
> > vmstate_load_state_end virtio-net-queue-tx_waiting end/0
> > vmstate_load_state virtio-net-vnet v0
> > vmstate_load_state_end virtio-net-vnet end/0
> > vmstate_load_state virtio-net-ufo v0
> > vmstate_load_state_end virtio-net-ufo end/0
> > vmstate_load_state virtio-net-tx_waiting v0
> > vmstate_load_state virtio-net-queue-tx_waiting v0
> > vmstate_load_state_end virtio-net-queue-tx_waiting end/0
> > vmstate_load_state virtio-net-queue-tx_waiting v0
> > vmstate_load_state_end virtio-net-queue-tx_waiting end/0
> > vmstate_load_state virtio-net-queue-tx_waiting v0
> > vmstate_load_state_end virtio-net-queue-tx_waiting end/0
> > vmstate_load_state_end virtio-net-tx_waiting end/0
> > vmstate_load_state_end virtio-net-device end/0
> > vmstate_load_state virtio v1
> > vmstate_load_state virtio/64bit_features v1
> > vmstate_load_state_end virtio/64bit_features end/0
> > vmstate_load_state virtio/virtqueues v1
> > vmstate_load_state virtqueue_state v1  <--- Queue idx 0
> > ...
> > vmstate_load_state_end virtqueue_state end/0
> > vmstate_load_state virtqueue_state v1  <--- Queue idx 1023
> > vmstate_load_state_end virtqueue_state end/0
> > vmstate_load_state_end virtio/virtqueues end/0
> > vmstate_load_state virtio/extra_state v1
> > vmstate_load_state virtio_pci v1
> > vmstate_load_state virtio_pci/modern_state v1
> > vmstate_load_state virtio_pci/modern_queue_state v1  <--- Queue idx 0
> > vmstate_load_state_end virtio_pci/modern_queue_state end/0
> > ...
> > vmstate_load_state virtio_pci/modern_queue_state v1  <--- Queue idx 102=
3
> > vmstate_load_state_end virtio_pci/modern_queue_state end/0
> > vmstate_load_state_end virtio_pci/modern_state end/0
> > vmstate_load_state_end virtio_pci end/0
> > vmstate_load_state_end virtio/extra_state end/0
> > vmstate_load_state virtio/started v1
> > vmstate_load_state_end virtio/started end/0
> > vmstate_load_state_end virtio end/0
> > vmstate_load_state_end virtio-net end/0
> > vmstate_downtime_load type=3Dnon-iterable idstr=3D0000:00:03.0/virtio-n=
et
> > instance_id=3D0 downtime=3D13260
> >
> > With iterative migration for virtio-net (maybe all virtio devices?), we=
 can
> > send this early while the source is still running and then only send th=
e
> > deltas during the stop-and-copy phase. It's likely that the source wont=
 be
> > using all VIRTIO_QUEUE_MAX virtqueues during the migration period, so t=
his
> > could really minimize a large majority of the downtime contributed by
> > virtio-net.
> >
> > This could be one example.

Or if the system call is expensive, could we try io_uring to mitigate it.

> >
> > > >
> > > > The motivation behind this RFC series specifically is to provide an
> > > > initial framework for such an implementation and get feedback on th=
e
> > > > design and direction.
> > > > -------
> > > >
> > > > This implementation of iterative live migration for a virtio-net de=
vice
> > > > is enabled via setting the migration capability 'virtio-iterative' =
to
> > > > on for both the source & destination, e.g. (HMP):
> > > >
> > > > (qemu) migrate_set_capability virtio-iterative on
> > > >
> > > > The virtio-net device's SaveVMHandlers hooks are registered/unregis=
tered
> > > > during the device's realize/unrealize phase.
> > >
> > > I wonder about the plan for libvirt support.
> > >
> >
> > Could you elaborate on this a bit?

I meant how this feature will be supported by the libvirt.

> >
> > > >
> > > > Currently, this series only sends and loads the vmstate at the star=
t of
> > > > migration. The vmstate is still sent (again) during the stop-and-co=
py
> > > > phase, as it is today, to handle any deltas in the state since it w=
as
> > > > initially sent. A future patch in this series could avoid having to
> > > > re-send and re-load the entire state again and instead focus only o=
n the
> > > > deltas.
> > > >
> > > > There is a slight, modest improvement in guest-visible downtime fro=
m
> > > > this series. More specifically, when using iterative live migration=
 with
> > > > a virtio-net device, the downtime contributed by migrating a virtio=
-net
> > > > device decreased from ~3.2ms to ~1.4ms on average:
> > >
> > > Are you testing this via a software virtio device or hardware one?
> > >
> >
> > Just software (virtio-device, vhost-net) with these numbers. I can run =
some
> > tests with vDPA hardware though.

I see. Considering you see great improvement with software devices. It
should be sufficient.

> >
> > Those numbers were from a simple, 1 queue-pair virtio-net device.

Thanks

> >
> > > >
> > > > Before:
> > > > -------
> > > > vmstate_downtime_load type=3Dnon-iterable idstr=3D0000:00:03.0/virt=
io-net
> > > >    instance_id=3D0 downtime=3D3594
> > > >
> > > > After:
> > > > ------
> > > > vmstate_downtime_load type=3Dnon-iterable idstr=3D0000:00:03.0/virt=
io-net
> > > >    instance_id=3D0 downtime=3D1607
> > > >
> > > > This slight improvement is likely due to the initial vmstate_load_s=
tate
> > > > call "warming up" pages in memory such that, when it's called a sec=
ond
> > > > time during the stop-and-copy phase, allocation and page-fault late=
ncies
> > > > are reduced.
> > > > -------
> > > >
> > > > Comments, suggestions, etc. are welcome here.
> > > >
> > > > Jonah Palmer (6):
> > > >    migration: Add virtio-iterative capability
> > > >    virtio-net: Reorder vmstate_virtio_net and helpers
> > > >    virtio-net: Add SaveVMHandlers for iterative migration
> > > >    virtio-net: iter live migration - migrate vmstate
> > > >    virtio,virtio-net: skip consistency check in virtio_load for ite=
rative
> > > >      migration
> > > >    virtio-net: skip vhost_started assertion during iterative migrat=
ion
> > > >
> > > >   hw/net/virtio-net.c            | 246 +++++++++++++++++++++++++++-=
-----
> > > >   hw/virtio/virtio.c             |  32 +++--
> > > >   include/hw/virtio/virtio-net.h |   8 ++
> > > >   include/hw/virtio/virtio.h     |   7 +
> > > >   migration/savevm.c             |   1 +
> > > >   qapi/migration.json            |   7 +-
> > > >   6 files changed, 247 insertions(+), 54 deletions(-)
> > > >
> > > > --
> > > > 2.47.1
> > >
> > > Thanks
> > >
> > > >
> > >
>


