Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8979CEE498F
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 10:46:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soKrZ-0002kE-B6; Wed, 11 Sep 2024 06:46:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1soKrR-0002jk-Ap
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 06:46:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1soKrN-0004HE-Pi
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 06:46:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726051565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7nGnZnp8HZq5eXu1nbqWfMgbLLWKYs/mf/i3Lae38kw=;
 b=MQ//ep9yVb3sSurCixeLA8IUWk4aMw99l3ot6MUinyaXXYTJZPb2XSRFvLeiKKCXSRatyc
 IHr36ARs/SSsOJy8E6wxylkjNJGkseyBcH26wf8kTH34QZZ3jU1T81d/21QAzL8KTtVawn
 6jg+lstch0sz/ZCZe31mICVdXfr4crE=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-zlqLVjhTO0aXLU--UVi0Uw-1; Wed, 11 Sep 2024 06:46:03 -0400
X-MC-Unique: zlqLVjhTO0aXLU--UVi0Uw-1
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-690404fd230so42403677b3.3
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 03:46:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726051563; x=1726656363;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7nGnZnp8HZq5eXu1nbqWfMgbLLWKYs/mf/i3Lae38kw=;
 b=lzskC/bUaz87hIdFxm3WoUVLJWz0uLKo2isFvPFyirWEJo4MLQMf9GlamOxVi9TUIe
 i7NdIQjw2OZGpHH1ILVKiak+pkNbaj5AlEACAB6v6WagUALzudO0qFKyqs7wv3C7YI+K
 UXQNGhEs6knxd1A/lnH1JklvIpNUulNMLKPfREV9XMRj2b/bUmtMwMB7EM/TBnSs1jEy
 ZqDbKWCciMBYtdHmioLHqjToo+mlewQaVQP0lavz4Bz8TxRMXBrqb8wb0wFjnP47y4ki
 nmJXNaFCtjTS97RW1qOLrx0g1835sEh7UVDaEnkPAPigR6Faub3CupQ2NSf8A3REkko8
 0y+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEW6Nkhgyj7tUkWbmtdt1nmZPWh6RHK61Jj6Uy6BzFlrEwC91g63gGOmZbxJ6XY1aixHNShHk52tM/@nongnu.org
X-Gm-Message-State: AOJu0YykX+4/oa+ARfQNVyYFGtJIYNmSiKcmNs4BNmScDdG0VY59n4M0
 4Vp6Pbk38QqCxSf/e0CbQL+G0+nmulEi7KZyO7cgOJdM4vN5dhLOffru5HtaGl0j4r2+8junGE+
 lu61m2/xhgzjnsWXm2A0TiO9Pm2r6MbVKHhU9aNT8+Gi6FfmCDz46L7Mai1eGzwCh95JTFwxGCB
 N8k+nc/qCsiTSTE61Aa8dMFm6ytA0=
X-Received: by 2002:a05:690c:67c7:b0:6d3:fddc:9d6c with SMTP id
 00721157ae682-6dba6e04623mr24518097b3.29.1726051562960; 
 Wed, 11 Sep 2024 03:46:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwr2bvoSb4jkaW9LhWkipRIN90b7/CV2XjDvAqQ0mcevN0FScsAidEsgngJPkWwwm5W+hnE8U6r5IhhnlYK2Y=
X-Received: by 2002:a05:690c:67c7:b0:6d3:fddc:9d6c with SMTP id
 00721157ae682-6dba6e04623mr24517907b3.29.1726051562452; Wed, 11 Sep 2024
 03:46:02 -0700 (PDT)
MIME-Version: 1.0
References: <20240821125548.749143-1-jonah.palmer@oracle.com>
 <20240821125548.749143-2-jonah.palmer@oracle.com>
 <CAJaqyWegFi5h56HQ2Ga5BsJ-UwMmxF5rQujE6ZAYJKEZaRy65w@mail.gmail.com>
 <436fc148-d1ac-17be-09f4-e776661c534a@oracle.com>
 <CAJaqyWeEgSar8f_O26aw+WoSKFGc8DoVkxTv-XEPPo_AeLXLSw@mail.gmail.com>
 <43277dbe-fb11-025c-fe99-8ee074a6a345@oracle.com>
 <CAJaqyWcFBxF4+LzC7EDXgFsp+dUNaWmzOqY5x8dav88LM6LhCw@mail.gmail.com>
 <febc124c-dd19-4ae8-ad84-b77dc4e399a7@oracle.com>
 <CAJaqyWcLqHe_+K=DRXxkVqh3bpa9yS5P9sLgLOXUXTHcJ4fMLQ@mail.gmail.com>
 <93efb6c5-0985-4db7-bde0-11e1d9f692c8@oracle.com>
In-Reply-To: <93efb6c5-0985-4db7-bde0-11e1d9f692c8@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 11 Sep 2024 12:45:26 +0200
Message-ID: <CAJaqyWeDvA4HejwEUL=1teSv34=ZQLWZuXKB5vRRv80p-QUMEA@mail.gmail.com>
Subject: Re: [RFC 1/2] vhost-vdpa: Decouple the IOVA allocator
To: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: Jonah Palmer <jonah.palmer@oracle.com>, qemu-devel@nongnu.org,
 mst@redhat.com, 
 leiyang@redhat.com, peterx@redhat.com, dtatulea@nvidia.com, 
 jasowang@redhat.com, boris.ostrovsky@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
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

On Wed, Sep 11, 2024 at 11:06=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.com>=
 wrote:
>
>
>
> On 9/9/2024 11:22 PM, Eugenio Perez Martin wrote:
> > On Tue, Sep 10, 2024 at 7:30=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.c=
om> wrote:
> >> Sorry for the delayed response, it seems I missed the email reply for
> >> some reason during the long weekend.
> >>
> >> On 9/2/2024 4:09 AM, Eugenio Perez Martin wrote:
> >>> On Fri, Aug 30, 2024 at 11:05=E2=80=AFPM Si-Wei Liu <si-wei.liu@oracl=
e.com> wrote:
> >>>>
> >>>> On 8/30/2024 1:05 AM, Eugenio Perez Martin wrote:
> >>>>> On Fri, Aug 30, 2024 at 6:20=E2=80=AFAM Si-Wei Liu <si-wei.liu@orac=
le.com> wrote:
> >>>>>> On 8/29/2024 9:53 AM, Eugenio Perez Martin wrote:
> >>>>>>> On Wed, Aug 21, 2024 at 2:56=E2=80=AFPM Jonah Palmer <jonah.palme=
r@oracle.com> wrote:
> >>>>>>>> Decouples the IOVA allocator from the IOVA->HVA tree and instead=
 adds
> >>>>>>>> the allocated IOVA range to an IOVA-only tree (iova_map). This I=
OVA tree
> >>>>>>>> will hold all IOVA ranges that have been allocated (e.g. in the
> >>>>>>>> IOVA->HVA tree) and are removed when any IOVA ranges are dealloc=
ated.
> >>>>>>>>
> >>>>>>>> A new API function vhost_iova_tree_insert() is also created to a=
dd a
> >>>>>>>> IOVA->HVA mapping into the IOVA->HVA tree.
> >>>>>>>>
> >>>>>>> I think this is a good first iteration but we can take steps to
> >>>>>>> simplify it. Also, it is great to be able to make points on real =
code
> >>>>>>> instead of designs on the air :).
> >>>>>>>
> >>>>>>> I expected a split of vhost_iova_tree_map_alloc between the curre=
nt
> >>>>>>> vhost_iova_tree_map_alloc and vhost_iova_tree_map_alloc_gpa, or
> >>>>>>> similar. Similarly, a vhost_iova_tree_remove and
> >>>>>>> vhost_iova_tree_remove_gpa would be needed.
> >>>>>>>
> >>>>>>> The first one is used for regions that don't exist in the guest, =
like
> >>>>>>> SVQ vrings or CVQ buffers. The second one is the one used by the
> >>>>>>> memory listener to map the guest regions into the vdpa device.
> >>>>>>>
> >>>>>>> Implementation wise, only two trees are actually needed:
> >>>>>>> * Current iova_taddr_map that contains all IOVA->vaddr translatio=
ns as
> >>>>>>> seen by the device, so both allocation functions can work on a si=
ngle
> >>>>>>> tree. The function iova_tree_find_iova keeps using this one, so t=
he
> >>>>>> I thought we had thorough discussion about this and agreed upon th=
e
> >>>>>> decoupled IOVA allocator solution.
> >>>>> My interpretation of it is to leave the allocator as the current on=
e,
> >>>>> and create a new tree with GPA which is guaranteed to be unique. Bu=
t
> >>>>> we can talk over it of course.
> >>>>>
> >>>>>> But maybe I missed something earlier,
> >>>>>> I am not clear how come this iova_tree_find_iova function could st=
ill
> >>>>>> work with the full IOVA-> HVA tree when it comes to aliased memory=
 or
> >>>>>> overlapped HVAs? Granted, for the memory map removal in the
> >>>>>> .region_del() path, we could rely on the GPA tree to locate the
> >>>>>> corresponding IOVA, but how come the translation path could figure=
 out
> >>>>>> which IOVA range to return when the vaddr happens to fall in an
> >>>>>> overlapped HVA range?
> >>>>> That is not a problem, as they both translate to the same address a=
t the device.
> >>>> Not sure I followed, it might return a wrong IOVA (range) which the =
host
> >>>> kernel may have conflict or unmatched attribute i.e. permission, siz=
e et
> >>>> al in the map.
> >>>>
> >>> Let's leave out the permissions at the moment. I'm going to use the
> >>> example you found, but I'll reorder (1) and (3) insertions so it pick=
s
> >>> the "wrong" IOVA range intentionally:
> >>>
> >>> (1)
> >>> HVA: [0x7f7903ea0000, 0x7f7903ec0000)
> >>> GPA: [0xfeda0000, 0xfedc0000)
> >>> IOVA: [0x1000, 0x21000)
> >>>
> >>> (2)
> >>> HVA: [0x7f7983e00000, 0x7f9903e00000)
> >>> GPA: [0x100000000, 0x2080000000)
> >>> IOVA: [0x80001000, 0x2000001000)
> >>>
> >>> (3)
> >>> HVA: [0x7f7903e00000, 0x7f7983e00000)
> >>> GPA: [0x0, 0x80000000)
> >>> IOVA: [0x2000001000, 0x2080000000)
> >>>
> >>> Let's say that SVQ wants to translate the HVA range
> >>> 0xfeda0000-0xfedd0000. So it makes available for the device two
> >>> chained buffers: One with addr=3D0x1000 len=3D0x20000 and the other o=
ne
> >>> with addr=3D(0x20000c1000 len=3D0x10000).
> >>>
> >>> The VirtIO device should be able to translate these two buffers in
> >>> isolation and chain them. Not optimal but it helps to keep QEMU sourc=
e
> >>> clean, as the device already must support it. I don't foresee lots of
> >>> cases like this anyway :).
> >> Hmmm, this scheme will only work if the aliased map doesn't go away
> >> immediately. If the BQL is not held or an unmap is to be done out of R=
CU
> >> critical section, it's pretty dangerous to assume we can be always fin=
e
> >> to work with the other overlapped regions.
> > But all the updates and reads are done in the critical sections, and
> > will be that way in the future too. That's the reason why the iova
> > tree does not have any mutex or equivalent.
> Right. That's the way how the SVQ translation API is currently being
> used for sure. It's always protected in the critical section under BQL
> in the synchronized context. But if we want to support a future use
> caselike cache the translation result somewhere and get it used in an
> async context, this will be problematic. There's no way to correct the
> cached IOVA once the associated aliased map goes away, regardless of
> protection using mutex, BQL or something similar.

Sorry, I still don't follow this point :(. I still fail to see how
this series solves that problem, or how it is different from just
using two trees instead of three. Some questions trying to understand
it:

This series still uses vaddr -> gpa translation through the function
qemu_ram_block_from_host. It uses RCU for synchronization. How does
this series work if it gets updated out of the RCU?

The function qemu_ram_block_from_host could also pick the small region
contained in the big region, as it is the same linear search as we do
in the current case. There is no code to select the big region at the
moment. How do we avoid the consequences of that small region
vanishing in that case?

Is that cache just in the SVQ? How is the coherency handled
differently in the HVA -> IOVA case than IOVA -> HVA?

> >
> > If we take out SVQ from BQL, we will need to protect the update of it
> > with something, either a mutex or similar. But that's already part of
> > the plan, even without my proposal or if we implement this RFC the way
> > it is.
> Yep, I know currently we don't have such use case, or we don't even
> actually have to support or get any chance to trip over those edge use
> cases in the future. The point I wanted to make is that, this full HVA
> tree based translation path is tightly coupled with how SVQ is now
> supposed to work, while departing too much from the rest of memory
> subsystem. Not saying it is not okay to go this way, though you may be
> aware already that with this abstraction, there'll be loss of generality
> and consistency with memory system's view,  which would need duplicative
> work like the permission check to satisfy those well established
> functionalities already built in memory system itself; get it compared
> to the other IOTLB implementation or similar memory translation API in
> QEMU, limitation applies to where and how the API should be used.
>

I think we cannot compare, as other IOTLB implementations in QEMU are
acting as devices, not drivers. As SVQ is the only one acting as
drivers, it makes sense the code is very different from the rest of
the code.

> >
> >> In my opinion if we have to
> >> work with the HVA tree, it'd be ideal for the caller(s) to get more ai=
d
> >> in helping figure out the right IOVA range in match rather than for SV=
Q
> >> or vhost-iova-tree to blindly pick a random one or break up contiguous
> >> range into pieces (in an inconsistent and unnecessary way).
> > The point is that SVQ already needs to work like that, as it needs to
> > support that a contiguous GPA range is splitted between different HVA.
> > Moreover, this is not a part of SVQ, but of VirtQueue. Both should be
> > extremely rare cases. Is it worth it to complicate / penalize the
> > general case solution to benefit this weird case, which is supported?
> Sure, not saying SVQ shouldn't support split GPA range between
> difference HVA. I guess what I meant was the returned IOVA will likely
> not match the the memory system's view, which is kinda weird. For
> example, the IOVA returned from the translation API can't be used to
> infer the GPA via internal tree lookup, we still have to resort to
> another external lookup via the memory system API.

That will never be possible for the whole IOVA range here as SVQ also
needs to map QEMU's only memory.

But if that is a limitation, the second tree I propose can be the GPA
-> IOVA tree proposed in the patch 2/2 of this series for sure [1].

> From the looks the
> abstraction layer appears to be self-contained, but actually there are
> quite some odd assumptions here or there that may in turn prohibit
> possible future use case.
>
> Given this vhost-iova-tree abstraction can only work with the current
> assumption or the current limited usage in the SVQ code, I feel the
> abstraction might need a bit more time to evolve to a point, where with
> a feature-rich SVQ implementation we can gain more confidence to
> conclude it's the right time to abstract something up. For now I just
> mentally equalize SVQ with vhost-iova-tree both in concept and layering,
> so I have to admit I favored more on Jonah's sparse implementation with
> decoupled GPA tree plus partial HVA tree for the SVQ - it doesn't seem
> lose any generality for future extension. Do you feel if ever possible
> to start from this intuitive implementation and gradually get it evolved
> with future use cases?
>

Sorry if it sounded that way, but what I'm proposing is not too far
away from this RFC :). Let me summarize it here again,

1) Why not remove the iova allocator tree? (iova_map). We can just
follow all the allocations with the IOVA->HVA tree as we're doing now,
so we save the memory, the code needed to keep them both synchronized,
and the potential errors of these. If we implement the more optimized
HVA -> IOVA tree, we can reevaluate its inclusion of course, but I'd
start simple.

Pending: synchronization issues if we want to remove memory chunks out
of the RCU.

2) This series adds a conditional & a potentially expensive call to
qemu_ram_block_from_host in the translation path, which is a hot spot.
This is done so IOVATree knows if it needs to look in one tree or
another.

Instead of that, I propose to make this distinction at insertion /
removal time. This is both a way colder spot, and they don't need to
call qemu_ram_block_from_host or similar as the caller always knows if
it is being called from QEMU memory (via the listener) or adding SVQ
vrings / net specific code.

The first item is a prerequisite of this.

Does it make more sense?

[1] https://lists.nongnu.org/archive/html/qemu-devel/2024-08/msg04262.html

> >> This would
> >> require a bit extensive changes to all the callers to pass in more
> >> information though, like the GPA, or the RAMBlock/MemoryRegionSection
> >> backing the relevant guest memory, along with the offset.
> >>
> >>> About the permissions, maybe we can make the permissions to be part o=
f
> >>> the lookup? Instead of returning them at iova_tree_find_iova, make
> >>> them match at iova_tree_find_address_iterator.
> >> Yes, if there's no easy way out we have to add this extra info to the
> >> HVA tree and make the lookup routine even complex (or duplicative).
> >>
> > Right.
> >
> >>>>> The most complicated situation is where we have a region contained =
in
> >>>>> another region, and the requested buffer crosses them. If the IOVA
> >>>>> tree returns the inner region, it will return the buffer chained wi=
th
> >>>>> the rest of the content in the outer region. Not optimal, but solve=
d
> >>>>> either way.
> >>>> Don't quite understand what it means... So in this overlapping case,
> >>>> speaking of the expectation of the translation API, you would like t=
o
> >>>> have all IOVA ranges that match the overlapped HVA to be returned? A=
nd
> >>>> then to rely on the user (caller) to figure out which one is correct=
?
> >>>> Wouldn't it be easier for the user (SVQ) to use the memory system AP=
I
> >>>> directly to figure out?
> >>>>
> >>> All of them are correct in the translation path. The device should be
> >>> able to work with a buffer that spans over different IOTLB too. You
> >>> can see how QEMU handles it at hw/virtio/virtio.c:virtqueue_map_desc.
> >>> If the region is not big enough to contain the whole buffer, the
> >>> device must keep looking for the rest of it.
> >> Yeah I see why you prefer working with HVA tree even with overlapping
> >> ranges, as the current API virtqueue_map_desc() that returns the HVA
> >> already wraps up the translation internals well for e.g. when span ove=
r
> >> different IOMMU.  Are you worry with the vIOMMU case where the GPA is =
no
> >> longer cached in the virtqueue elem? Maybe we can add also that
> >> information to the elem even for vIOMMU (we can defer doing it until w=
e
> >> add the vIOMMU support to SVQ), so that SVQ can just look up the GPA
> >> tree directly in the translation path?
> > I think that IOVA should just replace GPA in the tree, isn't it? Or am
> > I missing something?
> Yeah, I mean that's the advantage for the full HVA tree solution, given
> the virtio device model that uses the virtqueue API virtqueue_map_desc()
> would return HVA rather than GPA, so when vIOMMU support is going to be
> added, SVQ translation code can still work with the returned HVA to
> translate back to IOVA as is. All the vIOMMU translation will be
> transparently handled in virtqueue_map_desc() itself.
>

[1] https://lists.nongnu.org/archive/html/qemu-devel/2024-08/msg04262.html

> Thanks,
> -Siwei
> >
> > So the user of the IOVA tree (vhost-vdpa.c) should be slightly changed
> > but there is no change required for SVQ or IOVATree as far as I know.
> >
> >>>> As we are talking about API we may want to build it in a way generic
> >>>> enough to address all possible needs (which goes with what memory
> >>>> subsystem is capable of), rather than just look on the current usage
> >>>> which has kind of narrow scope. Although virtio-net device doesn't w=
ork
> >>>> with aliased region now, some other virtio device may do, or maybe s=
ome
> >>>> day virtio-net would need to use aliased region than the API and the
> >>>> users (SVQ) would have to go with another round of significant
> >>>> refactoring due to the iova-tree internal working. I feel it's just =
too
> >>>> early or too tight to abstract the iova-tree layer and get the API
> >>>> customized for the current use case with a lot of limitations on how
> >>>> user should expect to use it. We need some more flexibility and ease=
 on
> >>>> extensibility if we want to take the chance to get it rewritten, giv=
en
> >>>> it is not a lot of code that Jonah had showed here ..
> >>>>
> >>> Let me know if they are addressed here. Sorry if I didn't explain it
> >>> well, but I'm not trying to limit the alias or to handle just a subse=
t
> >>> of them. I'm trying to delegate the handling of these to the device a=
s
> >>> much as possible, as the device already needs to handle them and the
> >>> less we complicate the QEMU solution, the better. Of course, the IOVA
> >>> tree is a very self-contained area easy to rewrite in theory, but wit=
h
> >>> potential future users it might get complicated.
> >> Sure, understood. I just want to compare the Pros and Cons for each
> >> candidate, so that Jonah won't spend quite a lot of time to come up wi=
th
> >> complicated code, then soon find out all or most of them have to be
> >> thrown away, due to short sighted design which is unable to cope with
> >> foreseeable future use cases.
> >>


