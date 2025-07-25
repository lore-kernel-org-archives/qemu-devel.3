Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 797BFC87FCE
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 09:20:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufEaH-0007sj-Bn; Fri, 25 Jul 2025 05:19:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1ufEaE-0007nb-5W
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 05:19:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1ufEaB-0000Xn-B1
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 05:19:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753435150;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8jDPIlW3qnT9v6CbF1D7ueXTAB06Yu3PZBOgce6Zy+w=;
 b=hJmTP+2//rpP3dET1JbCgxCLKAXk8TbqlSfVM0XLQjzNeCAJBJl1ilp9qXotrbiFtjoMcg
 0DQpPR7yXrqimix6DsEQK/SuhBtw2qvmLGBR5tfe8nJkScfYQngIKIVOqmm7sIg9uLe7tQ
 90TuYEHkesxNWQXtFPQpGtG3OtBRW8o=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-aECxVZ6nOVW3QaUXezQJAg-1; Fri, 25 Jul 2025 05:19:09 -0400
X-MC-Unique: aECxVZ6nOVW3QaUXezQJAg-1
X-Mimecast-MFC-AGG-ID: aECxVZ6nOVW3QaUXezQJAg_1753435148
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-ad56a52edc5so252811466b.0
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 02:19:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753435148; x=1754039948;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8jDPIlW3qnT9v6CbF1D7ueXTAB06Yu3PZBOgce6Zy+w=;
 b=Gvyhkr2I2X/gCOY/H3Vp7UVWnMxUa+g0RAq3OuUp4CCnCzr4Dehy5jHVZLiEBsgGld
 KSExHXCCVVZxc0c058mWs4BYCO9pVXePhjkqsHSkWPOFqxoJpABXIaQw7FIaXtDjsAex
 mW/tXslZCFJ47PhGL1CJXiN9TVZiOFuj9ywSFq/I20riq5u8MO8f1pefk3Mlcxy5w1Eh
 qn5yR0rJqDWu6FxXaio9sQ/869ITKr36WUz9cB1T9C8vaIhdU+Ta79Xb64xrJE4JFKvY
 fr2X4o0b6Aob+Sfkpgi9ZYWwzbc4wl4raf9kGUpxRuasDAUruP55CTOCmonzniOW+D4T
 7J4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0YTa94NrirD4aOgD1PLc1qPFOHVdHrW+sm2WtFYRnb1NrKsKJDqzHhXlfW5wMuliLyiKl8p+Fahjv@nongnu.org
X-Gm-Message-State: AOJu0Ywylag8L0aGBRAgOxGBDV09zM+eWQ+tFerVZWGHpQavZcCtL1Hw
 IOLuJfpNP1O3GZ8FrNxS1+ha5zD9xJuMv31r9f/b8l5Lfn5kJzEe3FEQAWXP8jDMTuFSUNK0diz
 hVqOKoX0BLae2meQToHwmLfeMhNFlBBcETtwpE8VDK2on7z2VICwvSZpsDRAncFFHJQ3cyLaM0m
 DkCaLvQMGWl8220lE7vNQlv2keAyjvqzs=
X-Gm-Gg: ASbGncsmA/mD+F6FY4pYR58kRqd+qbwU9JZZ9HcHkqQuL0iX+8RIcMRtqdhcJFm5t0f
 pZvfd3mf04fhQN9z2My6qs7tZmwTRLt0laZvZDOb9eaWHU8LTKy2LrK7lKTWK+NRo9KomOWLXyV
 enpKMaPWaDQ+pd4bJgjk1LHQ==
X-Received: by 2002:a17:906:478e:b0:ad5:2328:e39b with SMTP id
 a640c23a62f3a-af618f02ee2mr155829766b.31.1753435147715; 
 Fri, 25 Jul 2025 02:19:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCmAtangdJR67mgMhkkx0dJKbuVP1F4Gmw43IR2exqn3s/1/POlfkPi+kXYS1ufqYLiANn6C8SriZP3BRqoYQ=
X-Received: by 2002:a17:906:478e:b0:ad5:2328:e39b with SMTP id
 a640c23a62f3a-af618f02ee2mr155826866b.31.1753435147251; Fri, 25 Jul 2025
 02:19:07 -0700 (PDT)
MIME-Version: 1.0
References: <20250722124127.2497406-1-jonah.palmer@oracle.com>
 <CACGkMEvrgAqSr9sgvq6F4oKBitZncqhsB_MEsbaNB7p0ZN5fEA@mail.gmail.com>
 <0f5b804d-3852-4159-b151-308a57f1ec74@oracle.com>
In-Reply-To: <0f5b804d-3852-4159-b151-308a57f1ec74@oracle.com>
From: Lei Yang <leiyang@redhat.com>
Date: Fri, 25 Jul 2025 17:18:29 +0800
X-Gm-Features: Ac12FXxNaJDF3CtvDPCAFwq4PxP5-goq1dkn-oKB8_TNkfTD5S4ow3qOMizUkXY
Message-ID: <CAPpAL=yRCpsY6VnDs069MmQ6cfGa9hguA1gdzuUw=0VwZZSK5A@mail.gmail.com>
Subject: Re: [RFC 0/6] virtio-net: initial iterative live migration support
To: Jonah Palmer <jonah.palmer@oracle.com>
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, peterx@redhat.com,
 farosas@suse.de, eblake@redhat.com, armbru@redhat.com, mst@redhat.com, 
 si-wei.liu@oracle.com, eperezma@redhat.com, boris.ostrovsky@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=leiyang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.45,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Tested this series of patches with virtio-net regression tests,
everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>


On Fri, Jul 25, 2025 at 6:01=E2=80=AFAM Jonah Palmer <jonah.palmer@oracle.c=
om> wrote:
>
>
>
> On 7/23/25 1:51 AM, Jason Wang wrote:
> > On Tue, Jul 22, 2025 at 8:41=E2=80=AFPM Jonah Palmer <jonah.palmer@orac=
le.com> wrote:
> >>
> >> This series is an RFC initial implementation of iterative live
> >> migration for virtio-net devices.
> >>
> >> The main motivation behind implementing iterative migration for
> >> virtio-net devices is to start on heavy, time-consuming operations
> >> for the destination while the source is still active (i.e. before
> >> the stop-and-copy phase).
> >
> > It would be better to explain which kind of operations were heavy and
> > time-consuming and how iterative migration help.
> >
>
> You're right. Apologies for being vague here.
>
> I did do some profiling of the virtio_load call for virtio-net to try
> and narrow down where exactly most of the downtime is coming from during
> the stop-and-copy phase.
>
> Pretty much the entirety of the downtime comes from the
> vmstate_load_state call for the vmstate_virtio's subsections:
>
> /* Subsections */
> ret =3D vmstate_load_state(f, &vmstate_virtio, vdev, 1);
> if (ret) {
>      return ret;
> }
>
> More specifically, the vmstate_virtio_virtqueues and
> vmstate_virtio_extra_state subsections.
>
> For example, currently (with no iterative migration), for a virtio-net
> device, the virtio_load call took 13.29ms to finish. 13.20ms of that
> time was spent in vmstate_load_state(f, &vmstate_virtio, vdev, 1).
>
> Of that 13.21ms, ~6.83ms was spent migrating vmstate_virtio_virtqueues
> and ~6.33ms was spent migrating the vmstate_virtio_extra_state
> subsections. And I believe this is from walking VIRTIO_QUEUE_MAX
> virtqueues, twice.
>
> vmstate_load_state virtio-net v11
> vmstate_load_state PCIDevice v2
> vmstate_load_state_end PCIDevice end/0
> vmstate_load_state virtio-net-device v11
> vmstate_load_state virtio-net-queue-tx_waiting v0
> vmstate_load_state_end virtio-net-queue-tx_waiting end/0
> vmstate_load_state virtio-net-vnet v0
> vmstate_load_state_end virtio-net-vnet end/0
> vmstate_load_state virtio-net-ufo v0
> vmstate_load_state_end virtio-net-ufo end/0
> vmstate_load_state virtio-net-tx_waiting v0
> vmstate_load_state virtio-net-queue-tx_waiting v0
> vmstate_load_state_end virtio-net-queue-tx_waiting end/0
> vmstate_load_state virtio-net-queue-tx_waiting v0
> vmstate_load_state_end virtio-net-queue-tx_waiting end/0
> vmstate_load_state virtio-net-queue-tx_waiting v0
> vmstate_load_state_end virtio-net-queue-tx_waiting end/0
> vmstate_load_state_end virtio-net-tx_waiting end/0
> vmstate_load_state_end virtio-net-device end/0
> vmstate_load_state virtio v1
> vmstate_load_state virtio/64bit_features v1
> vmstate_load_state_end virtio/64bit_features end/0
> vmstate_load_state virtio/virtqueues v1
> vmstate_load_state virtqueue_state v1  <--- Queue idx 0
> ...
> vmstate_load_state_end virtqueue_state end/0
> vmstate_load_state virtqueue_state v1  <--- Queue idx 1023
> vmstate_load_state_end virtqueue_state end/0
> vmstate_load_state_end virtio/virtqueues end/0
> vmstate_load_state virtio/extra_state v1
> vmstate_load_state virtio_pci v1
> vmstate_load_state virtio_pci/modern_state v1
> vmstate_load_state virtio_pci/modern_queue_state v1  <--- Queue idx 0
> vmstate_load_state_end virtio_pci/modern_queue_state end/0
> ...
> vmstate_load_state virtio_pci/modern_queue_state v1  <--- Queue idx 1023
> vmstate_load_state_end virtio_pci/modern_queue_state end/0
> vmstate_load_state_end virtio_pci/modern_state end/0
> vmstate_load_state_end virtio_pci end/0
> vmstate_load_state_end virtio/extra_state end/0
> vmstate_load_state virtio/started v1
> vmstate_load_state_end virtio/started end/0
> vmstate_load_state_end virtio end/0
> vmstate_load_state_end virtio-net end/0
> vmstate_downtime_load type=3Dnon-iterable idstr=3D0000:00:03.0/virtio-net
> instance_id=3D0 downtime=3D13260
>
> With iterative migration for virtio-net (maybe all virtio devices?), we
> can send this early while the source is still running and then only send
> the deltas during the stop-and-copy phase. It's likely that the source
> wont be using all VIRTIO_QUEUE_MAX virtqueues during the migration
> period, so this could really minimize a large majority of the downtime
> contributed by virtio-net.
>
> This could be one example.
>
> >>
> >> The motivation behind this RFC series specifically is to provide an
> >> initial framework for such an implementation and get feedback on the
> >> design and direction.
> >> -------
> >>
> >> This implementation of iterative live migration for a virtio-net devic=
e
> >> is enabled via setting the migration capability 'virtio-iterative' to
> >> on for both the source & destination, e.g. (HMP):
> >>
> >> (qemu) migrate_set_capability virtio-iterative on
> >>
> >> The virtio-net device's SaveVMHandlers hooks are registered/unregister=
ed
> >> during the device's realize/unrealize phase.
> >
> > I wonder about the plan for libvirt support.
> >
>
> Could you elaborate on this a bit?
>
> >>
> >> Currently, this series only sends and loads the vmstate at the start o=
f
> >> migration. The vmstate is still sent (again) during the stop-and-copy
> >> phase, as it is today, to handle any deltas in the state since it was
> >> initially sent. A future patch in this series could avoid having to
> >> re-send and re-load the entire state again and instead focus only on t=
he
> >> deltas.
> >>
> >> There is a slight, modest improvement in guest-visible downtime from
> >> this series. More specifically, when using iterative live migration wi=
th
> >> a virtio-net device, the downtime contributed by migrating a virtio-ne=
t
> >> device decreased from ~3.2ms to ~1.4ms on average:
> >
> > Are you testing this via a software virtio device or hardware one?
> >
>
> Just software (virtio-device, vhost-net) with these numbers. I can run
> some tests with vDPA hardware though.
>
> Those numbers were from a simple, 1 queue-pair virtio-net device.
>
> >>
> >> Before:
> >> -------
> >> vmstate_downtime_load type=3Dnon-iterable idstr=3D0000:00:03.0/virtio-=
net
> >>    instance_id=3D0 downtime=3D3594
> >>
> >> After:
> >> ------
> >> vmstate_downtime_load type=3Dnon-iterable idstr=3D0000:00:03.0/virtio-=
net
> >>    instance_id=3D0 downtime=3D1607
> >>
> >> This slight improvement is likely due to the initial vmstate_load_stat=
e
> >> call "warming up" pages in memory such that, when it's called a second
> >> time during the stop-and-copy phase, allocation and page-fault latenci=
es
> >> are reduced.
> >> -------
> >>
> >> Comments, suggestions, etc. are welcome here.
> >>
> >> Jonah Palmer (6):
> >>    migration: Add virtio-iterative capability
> >>    virtio-net: Reorder vmstate_virtio_net and helpers
> >>    virtio-net: Add SaveVMHandlers for iterative migration
> >>    virtio-net: iter live migration - migrate vmstate
> >>    virtio,virtio-net: skip consistency check in virtio_load for iterat=
ive
> >>      migration
> >>    virtio-net: skip vhost_started assertion during iterative migration
> >>
> >>   hw/net/virtio-net.c            | 246 +++++++++++++++++++++++++++----=
--
> >>   hw/virtio/virtio.c             |  32 +++--
> >>   include/hw/virtio/virtio-net.h |   8 ++
> >>   include/hw/virtio/virtio.h     |   7 +
> >>   migration/savevm.c             |   1 +
> >>   qapi/migration.json            |   7 +-
> >>   6 files changed, 247 insertions(+), 54 deletions(-)
> >>
> >> --
> >> 2.47.1
> >
> > Thanks
> >
> >>
> >
>
>


