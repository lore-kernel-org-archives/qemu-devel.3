Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56BC4CED25D
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 09:30:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syT0v-00071P-PD; Wed, 09 Oct 2024 05:29:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1syT0t-00071G-MW
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 05:29:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1syT0r-0006d8-JG
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 05:29:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728466183;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jfvWZTAGY5/W3+gJ2SO3IHWZzB25DuYdJiYXYElDDT8=;
 b=dxzophcM3SBXlp4DFPU1h5ZCV5jxwX6XzDOACpYVs9AiuYqA0hM9pgqRYtIlzkuc8qyV7P
 WaS7Gk8pGRSuIbhNf5kYiYFnkMamh8yud8KvX6HjjEgnaNPG6MLU2VQhc78OLkl31PIFmT
 VZYVTm0K4E1l4rgOKwtEJzW6rRvtyNc=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-Ys0AV3A5MO6C_r_xTWgmxQ-1; Wed, 09 Oct 2024 05:29:42 -0400
X-MC-Unique: Ys0AV3A5MO6C_r_xTWgmxQ-1
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-6e2d1860a62so69715917b3.0
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 02:29:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728466181; x=1729070981;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jfvWZTAGY5/W3+gJ2SO3IHWZzB25DuYdJiYXYElDDT8=;
 b=kQtU0UnFvOK2kGhhpqod/C6fcfpS7tz5zbeTATyi8+Z5EmEDh2dVSe09flQ+F76vMe
 +o7V3bncfuQzumaDszaKKNEbdjRKB2NXQ4cEYPOR4Z2moevAWbiejRlj03psm9CdYsMp
 Epi9XYSIqH781f8FKuLeRaUwTNwdlXtc8D6sEjv26EjIm84cidLh3DYlOFF4n05xeIeZ
 W7oZczecvw520P4ax3zHasDI5ZuyFtV+Uy+aZps+DuPmQd8XAJKM/NZ+i3rCIJ4tkKgC
 9ZRG4SQQCVx3+y81Ov6mZzUPVLqZZeHHzdOslLmNuqWN9Su9pgJxbJyJJiBeWMBQzePq
 9L0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAiW280R4czdRgY2Eky7NfWPyudW08fmYYm15jLZBB5KgJs1dNeUPUqmY9uQT6pCfPhpSnih/g4XBK@nongnu.org
X-Gm-Message-State: AOJu0YyFMWvqaJ/Fb+koA/4XrYnmkNWYeskjWw20fsi5kE4whvUNUOmW
 VBDb3aH2/xel7Z+S5rO+HQP6EW1wu9oIx0rmLnnpEhgvXHhi20GYle+Fk6EegN/dDYN0lZxrY27
 2bFBn53n8ZJkPl+M0WAiZ/aTQuTQGFzmk0OIg4kh6ZjfuW5lc1qUaI3hD66lpxtHvIaT9NtiDwu
 yZoF1HF+lGzJ52SZ+LVj++eB+jyLs=
X-Received: by 2002:a05:690c:6a0b:b0:6be:92c7:a27e with SMTP id
 00721157ae682-6e32217d00emr15983377b3.28.1728466181465; 
 Wed, 09 Oct 2024 02:29:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcAXU0f2K53qOoFBZS6CNuFRUyT51+ISpiHiLnCXa3m6lhc1MlJb3cBRFaDmMcuS7nQ5ZQl7ZF037kEC9k19k=
X-Received: by 2002:a05:690c:6a0b:b0:6be:92c7:a27e with SMTP id
 00721157ae682-6e32217d00emr15983217b3.28.1728466181138; Wed, 09 Oct 2024
 02:29:41 -0700 (PDT)
MIME-Version: 1.0
References: <20241004124445.3802090-1-jonah.palmer@oracle.com>
 <20241004124445.3802090-2-jonah.palmer@oracle.com>
 <CAJaqyWd7c6ZU_4Hk_Wo79Ghw_LRxxjmvXUvZrASKE6WSWZcytg@mail.gmail.com>
 <e3108f34-f951-47d6-ac41-cbbc045a7bd1@oracle.com>
 <CAJaqyWcmjnPaAFGvE5=2e19wuAxOr2=AHX1y-dj70+49sdQh7Q@mail.gmail.com>
 <a1711695-9d0c-44f4-b799-1879404581d9@oracle.com>
 <CAJaqyWfYvD0nEYU9UgKzYgUo5JzuFu3PBKNEkDrM0BE0Ek5LfA@mail.gmail.com>
 <5ebfd766-c8b5-4fb3-86ad-17a74212ef5e@oracle.com>
 <c0983e7c-b857-46fa-a6ec-82215829bbc7@oracle.com>
In-Reply-To: <c0983e7c-b857-46fa-a6ec-82215829bbc7@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 9 Oct 2024 11:29:05 +0200
Message-ID: <CAJaqyWcP8EyE+nyCF1JBouhQp8Lgi5RwoK7SCJe8QKoshDfbhg@mail.gmail.com>
Subject: Re: [RFC v2 1/2] vhost-vdpa: Implement IOVA->GPA tree
To: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: Jonah Palmer <jonah.palmer@oracle.com>, qemu-devel@nongnu.org,
 mst@redhat.com, 
 leiyang@redhat.com, peterx@redhat.com, dtatulea@nvidia.com, 
 jasowang@redhat.com, boris.ostrovsky@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
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

On Tue, Oct 8, 2024 at 10:30=E2=80=AFPM Si-Wei Liu <si-wei.liu@oracle.com> =
wrote:
>
>
>
> On 10/8/2024 8:40 AM, Jonah Palmer wrote:
> >
> >
> > On 10/8/24 2:51 AM, Eugenio Perez Martin wrote:
> >> On Tue, Oct 8, 2024 at 2:14=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.c=
om> wrote:
> >>>
> >>>
> >>>
> >>> On 10/7/2024 6:51 AM, Eugenio Perez Martin wrote:
> >>>> On Fri, Oct 4, 2024 at 8:48=E2=80=AFPM Jonah Palmer
> >>>> <jonah.palmer@oracle.com> wrote:
> >>>>>
> >>>>>
> >>>>> On 10/4/24 11:17 AM, Eugenio Perez Martin wrote:
> >>>>>> On Fri, Oct 4, 2024 at 2:45=E2=80=AFPM Jonah Palmer
> >>>>>> <jonah.palmer@oracle.com> wrote:
> >>>>>>> Implements the IOVA->GPA tree for handling mapping, unmapping, an=
d
> >>>>>>> translations for guest memory regions.
> >>>>>>>
> >>>>>>> When the guest has overlapping memory regions, an HVA to IOVA
> >>>>>>> translation
> >>>>>>> may return an incorrect IOVA when searching the IOVA->HVA tree.
> >>>>>>> This is
> >>>>>>> due to one HVA range being contained (overlapping) in another
> >>>>>>> HVA range
> >>>>>>> in the IOVA->HVA tree. By creating an IOVA->GPA tree, we can use
> >>>>>>> GPAs to
> >>>>>>> translate and find the correct IOVA for guest memory regions.
> >>>>>>>
> >>>>>> Yes, this first patch is super close to what I meant, just one iss=
ue
> >>>>>> and a pair of nits here and there.
> >>>>>>
> >>>>>> I'd leave the second patch as an optimization on top, if the numbe=
rs
> >>>>>> prove that adding the code is worth it.
> >>>>>>
> >>>>> Ah okay, gotcha. I also wasn't sure if what you mentioned below on
> >>>>> the
> >>>>> previous series you also wanted implemented or if these would also =
be
> >>>>> optimizations on top.
> >>>>>
> >>>>> [Adding code to the vhost_iova_tree layer for handling multiple
> >>>>> buffers
> >>>>> returned from translation for the memory area where each iovec
> >>>>> covers]:
> >>>>> -------------------------------------------------------------------=
----
> >>>>>
> >>>>> "Let's say that SVQ wants to translate the HVA range
> >>>>> 0xfeda0000-0xfedd0000. So it makes available for the device two
> >>>>> chained buffers: One with addr=3D0x1000 len=3D0x20000 and the other=
 one
> >>>>> with addr=3D(0x20000c1000 len=3D0x10000).
> >>>>>
> >>>>> The VirtIO device should be able to translate these two buffers in
> >>>>> isolation and chain them. Not optimal but it helps to keep QEMU
> >>>>> source
> >>>>> clean, as the device already must support it."
> >>>>>
> >>>> This is 100% in the device and QEMU is already able to split the
> >>>> buffers that way, so we don't need any change in QEMU.
> >>> Noted that if working with the full HVA tree directly, the internal
> >>> iova
> >>> tree linear iterator iova_tree_find_address_iterator() today doesn't
> >>> guarantee the iova range returned can cover the entire length of the
> >>> iov, so things could happen like that the aliased range with smaller
> >>> size (than the requested) happens to be hit first in the linear searc=
h
> >>> and be returned, the fragmentation of which can't be guarded against =
by
> >>> the VirtIO device or the DMA API mentioned above.
> >>>
> >>> The second patch in this series kind of mitigated this side effect by
> >>> sorting out the backing ram_block with the help of
> >>> qemu_ram_block_from_host() in case of guest memory backed iov, so it
> >>> doesn't really count on vhost_iova_gpa_tree_find_iova() to find the
> >>> matching IOVA, but instead (somehow implicitly) avoids the
> >>> fragmentation
> >>> side effect as mentioned above would never happen. Not saying I like
> >>> the
> >>> way how it is implemented, but just wanted to point out the implicati=
on
> >>> if the second patch has to be removed - either add special handling
> >>> code
> >>> to the iova-tree iterator sizing the range (same as how range selecti=
on
> >>> based upon permission will be done), or add special code in SVQ
> >>> layer to
> >>> deal with fragmented IOVA ranges due to aliasing.
> >>>
> >>
> >> This special code in SVQ is already there. And it will be needed even
> >> if we look for the buffers by GPA instead of by vaddr, the same way
> >> virtqueue_map_desc needs to handle it even if it works with GPA.
> >> Continuous GPA does not imply continuous vaddr.
> >>
> >
> > My apologies if I misunderstood something here regarding size &
> > permission matching, but I attempted to implement both the size and
> > permission check to iova_tree_find_address_iterator(), however,
> > there's a sizing mismatch in the vhost_svq_translate_addr() code path
> > that's causing vhost-net to fail to start.
> >
> > qemu-system-x86_64: unable to start vhost net: 22: falling back on
> > userspace virtio
> >
> > More specifically, in vhost_svq_add_split(), the first call to
> > vhost_svq_vring_write_descs() returns false:
> >
> >     ok =3D vhost_svq_vring_write_descs(svq, sgs, out_sg, out_num, in_nu=
m >
> >                                      0, false);
> >     if (unlikely(!ok)) {
> >         return false;
> >     }
> >
> > Maybe I misunderstood the proposal, but in
> > iova_tree_find_address_iterator I'm checking for an exact match for
> > sizes:
> >
> >     if (map->size !=3D needle->size || map->perm !=3D needle->perm) {
> >         return false;
> >     }
> The permission needs to exact match,

Care with this, read only buffers can live in the guest's RW memory. I
think the only actual condition is that if the buffer is writable, the
memory area must be writable. If they don't match, we should keep
looking for the right area.


> while the size doesn't have to. The
> current iova_tree_find_address_iterator() has the following check:
>
>      if (map->translated_addr + map->size < needle->translated_addr ||
>          needle->translated_addr + needle->size < map->translated_addr) {
>          return false;
>      }
>
> So essentially it does make sure the starting translated_addr on the
> needle is greater than or equal to the starting translated_addr on the
> map, and the first match of the map range in an ordered linear search
> will be returned, but it doesn't guarantee the ending address on the
> needle (needle->translated_addr + needle->size) will be covered by the
> ending address on the map (map->translated_addr + map->size), so this
> implementation is subjected to fragmented iova ranges with contiguous
> HVA address. I don't see the current SVQ handles this well, and the
> reason of iova fragmentation is due to overlapped region or memory
> aliasing (unlike the GPA tree implementation, we have no additional info
> to help us identify the exact IOVA when two or more overlapped HVA
> ranges are given), which is orthogonal to the HVA fragmentation (with
> contiguous GPA) handling in virtqueue_map_desc().
>
> How to handle this situation? Well, I guess Eugenio may have different
> opinion, but to me the only way seems to continue to search till a
> well-covered IOVA range can be found, or we may have to return multiple
> IOVA ranges splitting a contiguous HVA buffer...
>

Not sure if I followed this 100%, but we must be capable of returning
multiple IOVA ranges if we trust in SVQ to do the translation anyway.

When SVQ starts, the guest memory listener already gives the GPA ->
HVA translations fragmented and unordered, as QEMU can hotplug memory
for example. Let me put a simple example:

GPA [0, 0x1000) -> HVA [0x10000, 0x10100)
GPA [0x1000, 0x2000) -> HVA [0x20000, 0x20100)

Now we send the IOVA to the device this way:
IOVA [0x2000, 0x3000) -> HVA [0x20000, 0x20100)
IOVA [0x3000, 0x4000) -> HVA [0x10000, 0x10100)

So we have this translation tree (assuming we already store them as GPA->IO=
VA):
GPA [0, 0x1000) -> IOVA [0x3000, 0x4000)
GPA [0x1000, 0x2000) -> IOVA [0x2000, 0x3000)

Now the guest sends this single buffer in a single descriptor:
GPA 0x500, len 0x1000.

We need to split it into two descriptors anyway. Without memory
aliases we're covered at this moment, as virtqueue_pop already solves
these splits for us in virtqueue_map_desc.

Now I realize that SVQ may not be able to cover these splits with
aliases, as we might need to return more addresses than MAX(out_num,
in_num) in vhost_svq_vring_write_descs. So maybe we need to allocate
the translated addresses array in vhost_svq_vring_write_descs and
return it, or allow it to grow.

Having said that, I'd keep the plan as building something simple that
works first, re-prioritize if we want to focus on reducing the
downtime or in increasing the SVQ throughput, and then act in
consequence by profiling the advantages of the changes. I'm really
looking forward to the switching to (GPA|HVA)->IOVA tree, as I'm sure
it will increase the performance of the solution, but to review all of
it in one shot is out of my bandwith capabilities at the moment.

> Regards,
> -Siwei
>
>
>
> >
> > During the device setup phase, vhost_svq_add_split() ->
> > vhost_svq_vring_write_descs() -> vhost_svq_translate_addr() ->
> > vhost_iova_tree_find_iova() -> iova_tree_find_iova() is called, but in
> > iova_tree_find_address_iterator() map->size & needle->size mismatch. I
> > inserted some printf's to give more information:
> >
> > ...
> > [    8.019672] ahci 0000:00:1f.2: 6/6 ports implemented (port mask 0x3f=
)
> > [    8.020694] ahci 0000:00:1f.2: flags: 64bit ncq only
> > [    8.022403] scsi host0: ahci
> > [    8.023511] scsi host1: ahci
> > [    8.024446] scsi host2: ahci
> > [    8.025308
> > vhost_svq_translate_addr: iovec[i].iov_len =3D 0x8
> > iova_tree_find_address_iterator: mismatched sizes
> > map->size: 0xfff, needle->size: 0x8
> > map->perm: 1, needle->perm: 1
> > vhost_svq_add_split: _write_descs fail, sgs: 0x7fd85018ea80, out_sg:
> > 0x7ff8649fbb50, out_num: 1, in_sg: 0x7ff8649fbb60, in_num: 1,
> > more_descs: true, write: false
> > vhost_vdpa_svq_unmap_ring
> > vhost_vdpa_svq_unmap_ring
> > vhost_vdpa_listener_region_del
> > vhost_vdpa_listener_region_del
> > vhost_vdpa_listener_region_del
> > vhost_vdpa_listener_region_del
> > vhost_vdpa_listener_region_del
> > vhost_vdpa_svq_unmap_ring
> > vhost_vdpa_svq_unmap_ring
> > vhost_vdpa_svq_unmap_ring
> > vhost_vdpa_svq_unmap_ring
> > 2024-10-08T15:12:22.184902Z qemu-system-x86_64: unable to start vhost
> > net: 22: falling back on userspace virtio
> > ] scsi host3: ahci
> > [   10.921733] scsi host4: ahci
> > [   10.922946] scsi host5: ahci
> > [   10.923486] virtio_net virtio1 enp0s2: renamed from eth0
> > ...
> >
> > This is with similar Qemu args as Si-Wei's from way back when:
> >
> > -m size=3D128G,slots=3D8,maxmem=3D256G
> >
> > There are also some error catches with just the permission check but
> > it appears the vhost-net device is still able to start up (when not
> > matching sizes also).
>

I think this is because of the forced check for equal sizes, but let
me know if it is not caused by that!

Thanks!


