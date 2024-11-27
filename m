Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64CD1D6ACC5
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 12:31:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGHCn-0006bp-Ii; Wed, 27 Nov 2024 07:31:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1tGHCl-0006bU-Ci
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 07:31:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1tGHCj-0006l0-CI
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 07:31:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732710695;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RX4ft4oZz5LIL6k1HIhbV0cBXWkKYoG70ku7bxa+9BA=;
 b=bvOqiXyXd843+UxhP8jJ7GKHmcpxlpFascOgrI1QoU2o4Y+tSmJRt6tgNZSG33NBG7wNTG
 E7lIeWd1bn3Z1E+6q6bltkUvwUwg6Wfy+y+9J+uragoIx4CxgbL1eGe2CNe0YMCEOvyMYv
 Er4myd2N404FDNoj5D8Eyc4yH7CVRx4=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-314-Z6RSFItJNWW2rPtLH_nhgQ-1; Wed, 27 Nov 2024 07:31:31 -0500
X-MC-Unique: Z6RSFItJNWW2rPtLH_nhgQ-1
X-Mimecast-MFC-AGG-ID: Z6RSFItJNWW2rPtLH_nhgQ
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2ea50564395so732500a91.0
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2024 04:31:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732710691; x=1733315491;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RX4ft4oZz5LIL6k1HIhbV0cBXWkKYoG70ku7bxa+9BA=;
 b=Kqykcm+9uYjvdQr+r1e7jfpIT5Y+Sup/IhSiSkVcsXN0NzUKCzgafk8qvLuQAPFkWd
 Xdo6hvv7Ny3rHi3VMi2Q4vlkRZzc9BczcsFlVwh69CIxJWcetFO7u2QwEWZh/CnwOqUn
 Cl4zrx0ugfLA+ROiruAzCgSdp0kV5lnzyxNyNPeRP7ladb3wfPcwi9inxNbS2dzwvxZm
 kHDar257nuCArgX60oWjykdFHPYm7uUYVCwdS5jcgaUYmV/JK8Asc8aAMafycRebg8pq
 6z9b00NAvVsRD1yK3/EIMFx6NSPg5WUUhrET8Prsl+ma6GUyHFoVJOtDD4mjCUJv37Qq
 Qpow==
X-Gm-Message-State: AOJu0Yz9Ef4aZvVTgbjqdPA25sJgudeFqvInK0hf+pT2nPUbNUC7Kox5
 Qzqz2KwRHYXM4Jf0qmBvYEjNVZRRItOBwrnW0yW4qIBhEfIvMTeO5xK/pdI6G0PPYQ3AUzoIUvg
 agupw+i8y9jhj4+JhBTqEW6reMzYaJFEnwbrzWl47pLAckOfcS2Sln72b5sOdd6My2vEBjA9byp
 USO3/a6xks27Q/N9qLflPs035bb5g=
X-Gm-Gg: ASbGncvCLMu8Ag9bykQIsn//gHXl94DUn6+cp4Yj6860TP9xNPe0XQDfVBKqum6Xjcc
 UX97xLwyoWtZ5TGEvv8i2DxkowJi6sTm6
X-Received: by 2002:a17:90b:1c01:b0:2eb:140d:f6c5 with SMTP id
 98e67ed59e1d1-2ee08ec8229mr4650969a91.4.1732710690620; 
 Wed, 27 Nov 2024 04:31:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHfZraGGrUIXTsZE+EWB8WTWEhzN6wlDEQ+LoQcsV/XsLvG1RnRxsocRNjbyb9L5naalfIJzNG1w/f4cx6mpAY=
X-Received: by 2002:a17:90b:1c01:b0:2eb:140d:f6c5 with SMTP id
 98e67ed59e1d1-2ee08ec8229mr4650935a91.4.1732710690250; Wed, 27 Nov 2024
 04:31:30 -0800 (PST)
MIME-Version: 1.0
References: <20240912145335.129447-1-aesteve@redhat.com>
 <20240912145335.129447-2-aesteve@redhat.com>
 <abfd06b7-ad85-454b-a973-6c939c4588e3@redhat.com>
 <CADSE00+Yg+ufOT1NQ+8H7DSaE0zCFrWbn-yTajx72G0BZdUw9g@mail.gmail.com>
 <c998c231-5034-4a7e-bf97-1470959c052d@redhat.com>
 <44de54b5-8336-4d84-96f0-36f809f48eff@redhat.com>
 <6714e754-8d2d-4751-8b3b-dd7ce469a469@redhat.com>
In-Reply-To: <6714e754-8d2d-4751-8b3b-dd7ce469a469@redhat.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Wed, 27 Nov 2024 13:31:18 +0100
Message-ID: <CADSE00LQM1eT36c2Va3mxbO7sqnyH54L_b-eis4E6-MYhrOGAw@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] vhost-user: Add VIRTIO Shared Memory map request
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 slp@redhat.com, hi@alyssa.is, mst@redhat.com, jasowang@redhat.com, 
 stefanha@redhat.com, Stefano Garzarella <sgarzare@redhat.com>,
 stevensd@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Nov 27, 2024 at 1:18=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 27.11.24 13:10, David Hildenbrand wrote:
> > On 27.11.24 11:50, David Hildenbrand wrote:
> >>
> >>>> RAM memory region/ RAMBlock that has properly set flags/fd/whatssoev=
er
> >>>> and map whatever you want in there.
> >>>>
> >>>> Likely you would need a distinct RAMBlock/RAM memory region per mmap=
(),
> >>>> and would end up mmaping implicitly via qemu_ram_mmap().
> >>>>
> >>>> Then, your shared region would simply be an empty container into whi=
ch
> >>>> you map these RAM memory regions.
> >>>
> >>
> >> Hi,
> >>
> >>> Hi, sorry it took me so long to get back to this. Lately I have been
> >>> testing the patch and fixing bugs, and I am was going to add some
> >>> tests to be able to verify the patch without having to use a backend
> >>> (which is what I am doing right now).
> >>>
> >>> But I wanted to address/discuss this comment. I am not sure of the
> >>> actual problem with the current approach (I am not completely aware o=
f
> >>> the concern in your first paragraph), but I see other instances where
> >>> qemu mmaps stuff into a MemoryRegion.
> >>
> >> I suggest you take a look at the three relevant MAP_FIXED users outsid=
e
> >> of user emulation code.
> >>
> >> (1) hw/vfio/helpers.c: We create a custom memory region + RAMBlock wit=
h
> >>        memory_region_init_ram_device_ptr(). This doesn't mmap(MAP_FIXE=
D)
> >>        into any existing RAMBlock.
> >>
> >> (2) system/physmem.c: I suggest you take a close look at
> >>        qemu_ram_remap() and how it is one example of how RAMBlock
> >>        properties describe exactly what is mmaped.
> >>
> >> (3) util/mmap-alloc.c: Well, this is the code that performs the mmap()=
,
> >>        to bring a RAMBlock to life. See qemu_ram_mmap().
> >>
> >> There is some oddity hw/xen/xen-mapcache.c; XEN mapcache seems to mana=
ge
> >> guest RAM without RAMBlocks.
> >>
> >>> Take into account that the
> >>> implementation follows the definition of shared memory region here:
> >>> https://docs.oasis-open.org/virtio/virtio/v1.3/csd01/virtio-v1.3-csd0=
1.html#x1-10200010
> >>> Which hints to a memory region per ID, not one per required map. So
> >>> the current strategy seems to fit it better.
> >>
> >> I'm confused, we are talking about an implementation detail here? How =
is
> >> that related to the spec?
> >>
> >>>
> >>> Also, I was aware that I was not the first one attempting this, so I
> >>> based this code in previous attempts (maybe I should give credit in
> >>> the commit now that I think of):
> >>> https://gitlab.com/virtio-fs/qemu/-/blob/qemu5.0-virtiofs-dax/hw/virt=
io/vhost-user-fs.c?ref_type=3Dheads#L75
> >>> As you can see, it pretty much follows the same strategy.
> >>
> >> So, people did some hacky things in a QEMU fork 6 years ago ... :) Tha=
t
> >> cannot possibly be a good argument why we should have it like that in =
QEMU.
> >>
> >>> And in my
> >>> examples I have been able to use this to video stream with multiple
> >>> queues mapped into the shared memory (used to capture video frames),
> >>> using the backend I mentioned above for testing. So the concept works=
.
> >>> I may be wrong with this, but for what I understood looking at the
> >>> code, crosvm uses a similar strategy. Reserve a memory block and use
> >>> for all your mappings, and use an allocator to find a free slot.
> >>>
> >>
> >> Again, I suggest you take a look at what a RAMBlock is, and how it's
> >> properties describe the containing mmap().
> >>
> >>> And if I were to do what you say, those distinct RAMBlocks should be
> >>> created when the device starts? What would be their size? Should I
> >>> create them when qemu receives a request to mmap? How would the drive=
r
> >>> find the RAMBlock?
> >>
> >> You'd have an empty memory region container into which you will map
> >> memory regions that describe the memory you want to share.
> >>
> >> mr =3D g_new0(MemoryRegion, 1);
> >> memory_region_init(mr, OBJECT(TODO), "vhost-user-shm", region_size);
> >>
> >>
> >> Assuming you are requested to mmap an fd, you'd create a new
> >> MemoryRegion+RAMBlock that describes the memory and performs the mmap(=
)
> >> for you:
> >>
> >> map_mr =3D g_new0(MemoryRegion, 1);
> >> memory_region_init_ram_from_fd(map_mr, OBJECT(TODO), "TODO", map_size,
> >>                             RAM_SHARED, map_fd, map_offs, errp);
> >>
> >> To then map it into your container:
> >>
> >> memory_region_add_subregion(mr, offset_within_container, map_mr);
> >>
> >>
> >> To unmap, you'd first remove the subregion, to then unref the map_mr.
> >>
> >>
> >>
> >> The only alternative would be to do it like (1) above: you perform all
> >> of the mmap() yourself, and create it using
> >> memory_region_init_ram_device_ptr(). This will set RAM_PREALLOC on the
> >> RAMBlock and tell QEMU "this is special, just disregard it". The bad
> >> thing about RAM_PREALLOC will be that it will not be compatible with
> >> vfio, not communicated to other vhost-user devices etc ... whereby wha=
t
> >> I describe above would just work with them.
> >>
> >
> > FWIW, I took another look at this patch and I cannot really make sense
> > of what you are doing.
> >
> > In virtio_new_shmem_region(), you allocate a region, but I don't see ho=
w
> > it would ever get initialized?
> >
> > In vhost_user_backend_handle_shmem_map(), you then assume that it is
> > suddenly a RAM memory region? For example, that
> > memory_region_get_ram_ptr() returns something reasonable.
> >
> > Likely, you really just want to initialize that MR using
> > memory_region_init_ram_from_fd(), and have that just perform the proper
> > mmap() for you and setup the RAMBlock?
>
> In patch #4 I find: memory_region_init_ram_ptr(vdev->shmem_list[i].mr ...
>
> Which does what I describe as the alternative. That makes it clearer
> that you are not operating on arbitrary RAMBlocks. So that should indeed
> work.
>
> The way you structured these patches really is suboptimal for review.

Firstly, thank you so much for taking another look at the patch after
so much time. I understand it may be challenging given the time it
passed since I sent this version. Also, I rushed this version trying
to get to settle the spec first while I was working on something else,
so the code was untested and has quite a few bugs. I am mentioning it
just to note that I think this patch should not get a fine grain
review in its current status (although Stefan kindly did review it). I
fixed all (at least most) of the bugs in what would be the next
version, and it is what I use for testing. When I say I proved this
code and works, I am mostly referring to my local changes. As it is
here, this won't work.

That said, I understand what you mean, I will try to refactor /
reorder the patch to make it easier to review.

BR,
Albert.

>
> --
> Cheers,
>
> David / dhildenb
>


