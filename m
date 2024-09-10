Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85FE1ECE564
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 06:23:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snuHS-0000P7-SX; Tue, 10 Sep 2024 02:23:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1snuHQ-0000Nu-FD
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 02:23:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1snuHM-0003zJ-Vh
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 02:23:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725949387;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Oafz0srtZ39dbgDQ+xR592IzsTYYh0I8vvWDGWKmgXU=;
 b=TsYc981EgAZTh0/o0MO2z7b0mAYUseK5EbkfOwPQ2FQ0E/EJOQSbLC3LdkBkXSgDCbbGnM
 6H1ZCqK/dyqhefEUUu3XlEYbeVPj4bVNgzv82/rvzhmNpeWGwWwtZpMdAwWq0slbowftK0
 aipd4Sl/Y0tSpog3rNzLPtQFQjpFZjk=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-423-vG7_PYjKMtO3HFtYh6VM3A-1; Tue, 10 Sep 2024 02:23:05 -0400
X-MC-Unique: vG7_PYjKMtO3HFtYh6VM3A-1
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-6d73dd8ac65so152045817b3.1
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 23:23:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725949385; x=1726554185;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Oafz0srtZ39dbgDQ+xR592IzsTYYh0I8vvWDGWKmgXU=;
 b=p46euwpc/xGY3JNAPDoEkxpGdOaZaPc/Keob86UEAFfRUWfIgjBVn4iJhazv4cj+fM
 oElebuG7tXo2vxYzKcih4YiAwQHwrNL36idxVPnxFLJcqwT9sv+/OlAxqpvt4tWmDv3V
 1mJvWS37InbJTnMeha/SiOg3X0/3UU3bpGOX60vVlk8ezE7nz6s5ZcMb3XFrDYxnQ77O
 2Ea4cJTn8FToAS4I81I+fRTpBB+N12dlhNbIpPfM2EsLuqCsa1WpVEqqb6hXe8AYNwNc
 NcJEvHOMySJAgOwO9cfbnnesRA1kHEBNHKnx9lOj+fxIi00aY/fw+9l2pZkMElQg0VhV
 45Dw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbreikFuZ34ty59KfW7GNr08L9mysKSgni7HXzAp1sgTgxcUuxV5aGO5d+FmkthGJN7xKcSWQ8fXMd@nongnu.org
X-Gm-Message-State: AOJu0Yy+VE2RNtgm+GTY51lHWaxnqMEyGQu69mcIrkbSUAtBk1RBCJhB
 mCV6l9niODvThYHP+ytle/QXf3PDlwuI75geJfbpVYqcC/x6cAdSFTS4sHdzvvCe4fruGw9K4mx
 7txRaAY6/8jI6SPwVTOkf7XgsQzJs2ptVuduyfiznHzsLWeq+lZqoFb+M9YkzKoDEZcFNmCGNry
 KWObNF0kK/4oI+jg7DglMYsJwqUc4=
X-Received: by 2002:a05:690c:4391:b0:6b0:e93b:7179 with SMTP id
 00721157ae682-6db44f41516mr101655987b3.26.1725949384930; 
 Mon, 09 Sep 2024 23:23:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFb1XTZKtRxqLDyrfMlZ0MJN75vtX1C5gC9lDqmNea4iMxB/xlWkhB44dTdW0//8ffCIAySjzWEwZfts2JEPQU=
X-Received: by 2002:a05:690c:4391:b0:6b0:e93b:7179 with SMTP id
 00721157ae682-6db44f41516mr101655857b3.26.1725949384378; Mon, 09 Sep 2024
 23:23:04 -0700 (PDT)
MIME-Version: 1.0
References: <20240821125548.749143-1-jonah.palmer@oracle.com>
 <20240821125548.749143-2-jonah.palmer@oracle.com>
 <CAJaqyWegFi5h56HQ2Ga5BsJ-UwMmxF5rQujE6ZAYJKEZaRy65w@mail.gmail.com>
 <436fc148-d1ac-17be-09f4-e776661c534a@oracle.com>
 <CAJaqyWeEgSar8f_O26aw+WoSKFGc8DoVkxTv-XEPPo_AeLXLSw@mail.gmail.com>
 <43277dbe-fb11-025c-fe99-8ee074a6a345@oracle.com>
 <CAJaqyWcFBxF4+LzC7EDXgFsp+dUNaWmzOqY5x8dav88LM6LhCw@mail.gmail.com>
 <febc124c-dd19-4ae8-ad84-b77dc4e399a7@oracle.com>
In-Reply-To: <febc124c-dd19-4ae8-ad84-b77dc4e399a7@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 10 Sep 2024 08:22:28 +0200
Message-ID: <CAJaqyWcLqHe_+K=DRXxkVqh3bpa9yS5P9sLgLOXUXTHcJ4fMLQ@mail.gmail.com>
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
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Sep 10, 2024 at 7:30=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.com> =
wrote:
>
> Sorry for the delayed response, it seems I missed the email reply for
> some reason during the long weekend.
>
> On 9/2/2024 4:09 AM, Eugenio Perez Martin wrote:
> > On Fri, Aug 30, 2024 at 11:05=E2=80=AFPM Si-Wei Liu <si-wei.liu@oracle.=
com> wrote:
> >>
> >>
> >> On 8/30/2024 1:05 AM, Eugenio Perez Martin wrote:
> >>> On Fri, Aug 30, 2024 at 6:20=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle=
.com> wrote:
> >>>>
> >>>> On 8/29/2024 9:53 AM, Eugenio Perez Martin wrote:
> >>>>> On Wed, Aug 21, 2024 at 2:56=E2=80=AFPM Jonah Palmer <jonah.palmer@=
oracle.com> wrote:
> >>>>>> Decouples the IOVA allocator from the IOVA->HVA tree and instead a=
dds
> >>>>>> the allocated IOVA range to an IOVA-only tree (iova_map). This IOV=
A tree
> >>>>>> will hold all IOVA ranges that have been allocated (e.g. in the
> >>>>>> IOVA->HVA tree) and are removed when any IOVA ranges are deallocat=
ed.
> >>>>>>
> >>>>>> A new API function vhost_iova_tree_insert() is also created to add=
 a
> >>>>>> IOVA->HVA mapping into the IOVA->HVA tree.
> >>>>>>
> >>>>> I think this is a good first iteration but we can take steps to
> >>>>> simplify it. Also, it is great to be able to make points on real co=
de
> >>>>> instead of designs on the air :).
> >>>>>
> >>>>> I expected a split of vhost_iova_tree_map_alloc between the current
> >>>>> vhost_iova_tree_map_alloc and vhost_iova_tree_map_alloc_gpa, or
> >>>>> similar. Similarly, a vhost_iova_tree_remove and
> >>>>> vhost_iova_tree_remove_gpa would be needed.
> >>>>>
> >>>>> The first one is used for regions that don't exist in the guest, li=
ke
> >>>>> SVQ vrings or CVQ buffers. The second one is the one used by the
> >>>>> memory listener to map the guest regions into the vdpa device.
> >>>>>
> >>>>> Implementation wise, only two trees are actually needed:
> >>>>> * Current iova_taddr_map that contains all IOVA->vaddr translations=
 as
> >>>>> seen by the device, so both allocation functions can work on a sing=
le
> >>>>> tree. The function iova_tree_find_iova keeps using this one, so the
> >>>> I thought we had thorough discussion about this and agreed upon the
> >>>> decoupled IOVA allocator solution.
> >>> My interpretation of it is to leave the allocator as the current one,
> >>> and create a new tree with GPA which is guaranteed to be unique. But
> >>> we can talk over it of course.
> >>>
> >>>> But maybe I missed something earlier,
> >>>> I am not clear how come this iova_tree_find_iova function could stil=
l
> >>>> work with the full IOVA-> HVA tree when it comes to aliased memory o=
r
> >>>> overlapped HVAs? Granted, for the memory map removal in the
> >>>> .region_del() path, we could rely on the GPA tree to locate the
> >>>> corresponding IOVA, but how come the translation path could figure o=
ut
> >>>> which IOVA range to return when the vaddr happens to fall in an
> >>>> overlapped HVA range?
> >>> That is not a problem, as they both translate to the same address at =
the device.
> >> Not sure I followed, it might return a wrong IOVA (range) which the ho=
st
> >> kernel may have conflict or unmatched attribute i.e. permission, size =
et
> >> al in the map.
> >>
> > Let's leave out the permissions at the moment. I'm going to use the
> > example you found, but I'll reorder (1) and (3) insertions so it picks
> > the "wrong" IOVA range intentionally:
> >
> > (1)
> > HVA: [0x7f7903ea0000, 0x7f7903ec0000)
> > GPA: [0xfeda0000, 0xfedc0000)
> > IOVA: [0x1000, 0x21000)
> >
> > (2)
> > HVA: [0x7f7983e00000, 0x7f9903e00000)
> > GPA: [0x100000000, 0x2080000000)
> > IOVA: [0x80001000, 0x2000001000)
> >
> > (3)
> > HVA: [0x7f7903e00000, 0x7f7983e00000)
> > GPA: [0x0, 0x80000000)
> > IOVA: [0x2000001000, 0x2080000000)
> >
> > Let's say that SVQ wants to translate the HVA range
> > 0xfeda0000-0xfedd0000. So it makes available for the device two
> > chained buffers: One with addr=3D0x1000 len=3D0x20000 and the other one
> > with addr=3D(0x20000c1000 len=3D0x10000).
> >
> > The VirtIO device should be able to translate these two buffers in
> > isolation and chain them. Not optimal but it helps to keep QEMU source
> > clean, as the device already must support it. I don't foresee lots of
> > cases like this anyway :).
> Hmmm, this scheme will only work if the aliased map doesn't go away
> immediately. If the BQL is not held or an unmap is to be done out of RCU
> critical section, it's pretty dangerous to assume we can be always fine
> to work with the other overlapped regions.

But all the updates and reads are done in the critical sections, and
will be that way in the future too. That's the reason why the iova
tree does not have any mutex or equivalent.

If we take out SVQ from BQL, we will need to protect the update of it
with something, either a mutex or similar. But that's already part of
the plan, even without my proposal or if we implement this RFC the way
it is.

> In my opinion if we have to
> work with the HVA tree, it'd be ideal for the caller(s) to get more aid
> in helping figure out the right IOVA range in match rather than for SVQ
> or vhost-iova-tree to blindly pick a random one or break up contiguous
> range into pieces (in an inconsistent and unnecessary way).

The point is that SVQ already needs to work like that, as it needs to
support that a contiguous GPA range is splitted between different HVA.
Moreover, this is not a part of SVQ, but of VirtQueue. Both should be
extremely rare cases. Is it worth it to complicate / penalize the
general case solution to benefit this weird case, which is supported?

> This would
> require a bit extensive changes to all the callers to pass in more
> information though, like the GPA, or the RAMBlock/MemoryRegionSection
> backing the relevant guest memory, along with the offset.
>
> > About the permissions, maybe we can make the permissions to be part of
> > the lookup? Instead of returning them at iova_tree_find_iova, make
> > them match at iova_tree_find_address_iterator.
> Yes, if there's no easy way out we have to add this extra info to the
> HVA tree and make the lookup routine even complex (or duplicative).
>

Right.

> >
> >>> The most complicated situation is where we have a region contained in
> >>> another region, and the requested buffer crosses them. If the IOVA
> >>> tree returns the inner region, it will return the buffer chained with
> >>> the rest of the content in the outer region. Not optimal, but solved
> >>> either way.
> >> Don't quite understand what it means... So in this overlapping case,
> >> speaking of the expectation of the translation API, you would like to
> >> have all IOVA ranges that match the overlapped HVA to be returned? And
> >> then to rely on the user (caller) to figure out which one is correct?
> >> Wouldn't it be easier for the user (SVQ) to use the memory system API
> >> directly to figure out?
> >>
> > All of them are correct in the translation path. The device should be
> > able to work with a buffer that spans over different IOTLB too. You
> > can see how QEMU handles it at hw/virtio/virtio.c:virtqueue_map_desc.
> > If the region is not big enough to contain the whole buffer, the
> > device must keep looking for the rest of it.
> Yeah I see why you prefer working with HVA tree even with overlapping
> ranges, as the current API virtqueue_map_desc() that returns the HVA
> already wraps up the translation internals well for e.g. when span over
> different IOMMU.  Are you worry with the vIOMMU case where the GPA is no
> longer cached in the virtqueue elem? Maybe we can add also that
> information to the elem even for vIOMMU (we can defer doing it until we
> add the vIOMMU support to SVQ), so that SVQ can just look up the GPA
> tree directly in the translation path?

I think that IOVA should just replace GPA in the tree, isn't it? Or am
I missing something?

So the user of the IOVA tree (vhost-vdpa.c) should be slightly changed
but there is no change required for SVQ or IOVATree as far as I know.

> >
> >> As we are talking about API we may want to build it in a way generic
> >> enough to address all possible needs (which goes with what memory
> >> subsystem is capable of), rather than just look on the current usage
> >> which has kind of narrow scope. Although virtio-net device doesn't wor=
k
> >> with aliased region now, some other virtio device may do, or maybe som=
e
> >> day virtio-net would need to use aliased region than the API and the
> >> users (SVQ) would have to go with another round of significant
> >> refactoring due to the iova-tree internal working. I feel it's just to=
o
> >> early or too tight to abstract the iova-tree layer and get the API
> >> customized for the current use case with a lot of limitations on how
> >> user should expect to use it. We need some more flexibility and ease o=
n
> >> extensibility if we want to take the chance to get it rewritten, given
> >> it is not a lot of code that Jonah had showed here ..
> >>
> > Let me know if they are addressed here. Sorry if I didn't explain it
> > well, but I'm not trying to limit the alias or to handle just a subset
> > of them. I'm trying to delegate the handling of these to the device as
> > much as possible, as the device already needs to handle them and the
> > less we complicate the QEMU solution, the better. Of course, the IOVA
> > tree is a very self-contained area easy to rewrite in theory, but with
> > potential future users it might get complicated.
> Sure, understood. I just want to compare the Pros and Cons for each
> candidate, so that Jonah won't spend quite a lot of time to come up with
> complicated code, then soon find out all or most of them have to be
> thrown away, due to short sighted design which is unable to cope with
> foreseeable future use cases.
>
> Thanks,
> -Siwei
>
> >
> >>> The only problem that comes to my mind is the case where the inner
> >>> region is RO
> >> Yes, this is one of examples around the permission or size I mentioned
> >> above, which may have a conflict view with the memory system or the ke=
rnel.
> >>
> >> Thanks,
> >> -Siwei
> >>
> >>> and it is a write command, but I don't think we have this
> >>> case in a sane guest. A malicious guest cannot do any harm this way
> >>> anyway.
> >>>
> >>>> Do we still assume some overlapping order so we
> >>>> always return the first match from the tree? Or we expect every curr=
ent
> >>>> user of iova_tree_find_iova should pass in GPA rather than HVA and u=
se
> >>>> the vhost_iova_xxx_gpa API variant to look up IOVA?
> >>>>
> >>> No, iova_tree_find_iova should keep asking for vaddr, as the result i=
s
> >>> guaranteed to be there. Users of VhostIOVATree only need to modify ho=
w
> >>> they add or remove regions, knowing if they come from the guest or
> >>> not. As shown by this series, it is easier to do in that place than i=
n
> >>> translation.
> >>>
> >>>> Thanks,
> >>>> -Siwei
> >>>>
> >>>>> user does not need to know if the address is from the guest or only
> >>>>> exists in QEMU by using RAMBlock etc. All insert and remove functio=
ns
> >>>>> use this tree.
> >>>>> * A new tree that relates IOVA to GPA, that only
> >>>>> vhost_iova_tree_map_alloc_gpa and vhost_iova_tree_remove_gpa uses.
> >>>>>
> >>>>> The ideal case is that the key in this new tree is the GPA and the
> >>>>> value is the IOVA. But IOVATree's DMA is named the reverse: iova is
> >>>>> the key and translated_addr is the vaddr. We can create a new tree
> >>>>> struct for that, use GTree directly, or translate the reverse
> >>>>> linearly. As memory add / remove should not be frequent, I think th=
e
> >>>>> simpler is the last one, but I'd be ok with creating a new tree.
> >>>>>
> >>>>> vhost_iova_tree_map_alloc_gpa needs to add the map to this new tree
> >>>>> also. Similarly, vhost_iova_tree_remove_gpa must look for the GPA i=
n
> >>>>> this tree, and only remove the associated DMAMap in iova_taddr_map
> >>>>> that matches the IOVA.
> >>>>>
> >>>>> Does it make sense to you?
> >>>>>
> >>>>>> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
> >>>>>> ---
> >>>>>>     hw/virtio/vhost-iova-tree.c | 38 +++++++++++++++++++++++++++++=
+++-----
> >>>>>>     hw/virtio/vhost-iova-tree.h |  1 +
> >>>>>>     hw/virtio/vhost-vdpa.c      | 31 ++++++++++++++++++++++++-----=
-
> >>>>>>     net/vhost-vdpa.c            | 13 +++++++++++--
> >>>>>>     4 files changed, 70 insertions(+), 13 deletions(-)
> >>>>>>
> >>>>>> diff --git a/hw/virtio/vhost-iova-tree.c b/hw/virtio/vhost-iova-tr=
ee.c
> >>>>>> index 3d03395a77..32c03db2f5 100644
> >>>>>> --- a/hw/virtio/vhost-iova-tree.c
> >>>>>> +++ b/hw/virtio/vhost-iova-tree.c
> >>>>>> @@ -28,12 +28,17 @@ struct VhostIOVATree {
> >>>>>>
> >>>>>>         /* IOVA address to qemu memory maps. */
> >>>>>>         IOVATree *iova_taddr_map;
> >>>>>> +
> >>>>>> +    /* IOVA tree (IOVA allocator) */
> >>>>>> +    IOVATree *iova_map;
> >>>>>>     };
> >>>>>>
> >>>>>>     /**
> >>>>>> - * Create a new IOVA tree
> >>>>>> + * Create a new VhostIOVATree with a new set of IOVATree's:
> >>>>> s/IOVA tree/VhostIOVATree/ is good, but I think the rest is more an
> >>>>> implementation detail.
> >>>>>
> >>>>>> + * - IOVA allocator (iova_map)
> >>>>>> + * - IOVA->HVA tree (iova_taddr_map)
> >>>>>>      *
> >>>>>> - * Returns the new IOVA tree
> >>>>>> + * Returns the new VhostIOVATree
> >>>>>>      */
> >>>>>>     VhostIOVATree *vhost_iova_tree_new(hwaddr iova_first, hwaddr i=
ova_last)
> >>>>>>     {
> >>>>>> @@ -44,6 +49,7 @@ VhostIOVATree *vhost_iova_tree_new(hwaddr iova_f=
irst, hwaddr iova_last)
> >>>>>>         tree->iova_last =3D iova_last;
> >>>>>>
> >>>>>>         tree->iova_taddr_map =3D iova_tree_new();
> >>>>>> +    tree->iova_map =3D iova_tree_new();
> >>>>>>         return tree;
> >>>>>>     }
> >>>>>>
> >>>>>> @@ -53,6 +59,7 @@ VhostIOVATree *vhost_iova_tree_new(hwaddr iova_f=
irst, hwaddr iova_last)
> >>>>>>     void vhost_iova_tree_delete(VhostIOVATree *iova_tree)
> >>>>>>     {
> >>>>>>         iova_tree_destroy(iova_tree->iova_taddr_map);
> >>>>>> +    iova_tree_destroy(iova_tree->iova_map);
> >>>>>>         g_free(iova_tree);
> >>>>>>     }
> >>>>>>
> >>>>>> @@ -88,13 +95,12 @@ int vhost_iova_tree_map_alloc(VhostIOVATree *t=
ree, DMAMap *map)
> >>>>>>         /* Some vhost devices do not like addr 0. Skip first page =
*/
> >>>>>>         hwaddr iova_first =3D tree->iova_first ?: qemu_real_host_p=
age_size();
> >>>>>>
> >>>>>> -    if (map->translated_addr + map->size < map->translated_addr |=
|
> >>>>> Why remove this condition? If the request is invalid we still need =
to
> >>>>> return an error here.
> >>>>>
> >>>>> Maybe we should move it to iova_tree_alloc_map though.
> >>>>>
> >>>>>> -        map->perm =3D=3D IOMMU_NONE) {
> >>>>>> +    if (map->perm =3D=3D IOMMU_NONE) {
> >>>>>>             return IOVA_ERR_INVALID;
> >>>>>>         }
> >>>>>>
> >>>>>>         /* Allocate a node in IOVA address */
> >>>>>> -    return iova_tree_alloc_map(tree->iova_taddr_map, map, iova_fi=
rst,
> >>>>>> +    return iova_tree_alloc_map(tree->iova_map, map, iova_first,
> >>>>>>                                    tree->iova_last);
> >>>>>>     }
> >>>>>>
> >>>>>> @@ -107,4 +113,26 @@ int vhost_iova_tree_map_alloc(VhostIOVATree *=
tree, DMAMap *map)
> >>>>>>     void vhost_iova_tree_remove(VhostIOVATree *iova_tree, DMAMap m=
ap)
> >>>>>>     {
> >>>>>>         iova_tree_remove(iova_tree->iova_taddr_map, map);
> >>>>>> +    iova_tree_remove(iova_tree->iova_map, map);
> >>>>>> +}
> >>>>>> +
> >>>>>> +/**
> >>>>>> + * Insert a new mapping to the IOVA->HVA tree
> >>>>>> + *
> >>>>>> + * @tree: The VhostIOVATree
> >>>>>> + * @map: The iova map
> >>>>>> + *
> >>>>>> + * Returns:
> >>>>>> + * - IOVA_OK if the map fits in the container
> >>>>>> + * - IOVA_ERR_INVALID if the map does not make sense (like size o=
verflow)
> >>>>>> + * - IOVA_ERR_OVERLAP if the IOVA range overlaps with an existing=
 range
> >>>>>> + */
> >>>>>> +int vhost_iova_tree_insert(VhostIOVATree *iova_tree, DMAMap *map)
> >>>>>> +{
> >>>>>> +    if (map->translated_addr + map->size < map->translated_addr |=
|
> >>>>>> +        map->perm =3D=3D IOMMU_NONE) {
> >>>>>> +        return IOVA_ERR_INVALID;
> >>>>>> +    }
> >>>>>> +
> >>>>>> +    return iova_tree_insert(iova_tree->iova_taddr_map, map);
> >>>>>>     }
> >>>>>> diff --git a/hw/virtio/vhost-iova-tree.h b/hw/virtio/vhost-iova-tr=
ee.h
> >>>>>> index 4adfd79ff0..8bf7b64786 100644
> >>>>>> --- a/hw/virtio/vhost-iova-tree.h
> >>>>>> +++ b/hw/virtio/vhost-iova-tree.h
> >>>>>> @@ -23,5 +23,6 @@ const DMAMap *vhost_iova_tree_find_iova(const Vh=
ostIOVATree *iova_tree,
> >>>>>>                                             const DMAMap *map);
> >>>>>>     int vhost_iova_tree_map_alloc(VhostIOVATree *iova_tree, DMAMap=
 *map);
> >>>>>>     void vhost_iova_tree_remove(VhostIOVATree *iova_tree, DMAMap m=
ap);
> >>>>>> +int vhost_iova_tree_insert(VhostIOVATree *iova_tree, DMAMap *map)=
;
> >>>>>>
> >>>>>>     #endif
> >>>>>> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> >>>>>> index 3cdaa12ed5..6702459065 100644
> >>>>>> --- a/hw/virtio/vhost-vdpa.c
> >>>>>> +++ b/hw/virtio/vhost-vdpa.c
> >>>>>> @@ -361,10 +361,10 @@ static void vhost_vdpa_listener_region_add(M=
emoryListener *listener,
> >>>>>>         if (s->shadow_data) {
> >>>>>>             int r;
> >>>>>>
> >>>>>> -        mem_region.translated_addr =3D (hwaddr)(uintptr_t)vaddr,
> >>>>>>             mem_region.size =3D int128_get64(llsize) - 1,
> >>>>>>             mem_region.perm =3D IOMMU_ACCESS_FLAG(true, section->r=
eadonly),
> >>>>>>
> >>>>>> +        /* Allocate IOVA range and add the mapping to the IOVA tr=
ee */
> >>>>>>             r =3D vhost_iova_tree_map_alloc(s->iova_tree, &mem_reg=
ion);
> >>>>>>             if (unlikely(r !=3D IOVA_OK)) {
> >>>>>>                 error_report("Can't allocate a mapping (%d)", r);
> >>>>>> @@ -372,6 +372,14 @@ static void vhost_vdpa_listener_region_add(Me=
moryListener *listener,
> >>>>>>             }
> >>>>>>
> >>>>>>             iova =3D mem_region.iova;
> >>>>>> +
> >>>>>> +        /* Add mapping to the IOVA->HVA tree */
> >>>>>> +        mem_region.translated_addr =3D (hwaddr)(uintptr_t)vaddr;
> >>>>>> +        r =3D vhost_iova_tree_insert(s->iova_tree, &mem_region);
> >>>>>> +        if (unlikely(r !=3D IOVA_OK)) {
> >>>>>> +            error_report("Can't add listener region mapping (%d)"=
, r);
> >>>>>> +            goto fail_map;
> >>>>>> +        }
> >>>>> I'd say it is not intuitive for the caller code.
> >>>>>
> >>>>>>         }
> >>>>>>
> >>>>>>         vhost_vdpa_iotlb_batch_begin_once(s);
> >>>>>> @@ -1142,19 +1150,30 @@ static void vhost_vdpa_svq_unmap_rings(str=
uct vhost_dev *dev,
> >>>>>>      *
> >>>>>>      * @v: Vhost-vdpa device
> >>>>>>      * @needle: The area to search iova
> >>>>>> + * @taddr: The translated address (SVQ HVA)
> >>>>>>      * @errorp: Error pointer
> >>>>>>      */
> >>>>>>     static bool vhost_vdpa_svq_map_ring(struct vhost_vdpa *v, DMAM=
ap *needle,
> >>>>>> -                                    Error **errp)
> >>>>>> +                                    hwaddr taddr, Error **errp)
> >>>>>>     {
> >>>>>>         int r;
> >>>>>>
> >>>>>> +    /* Allocate IOVA range and add the mapping to the IOVA tree *=
/
> >>>>>>         r =3D vhost_iova_tree_map_alloc(v->shared->iova_tree, need=
le);
> >>>>>>         if (unlikely(r !=3D IOVA_OK)) {
> >>>>>>             error_setg(errp, "Cannot allocate iova (%d)", r);
> >>>>>>             return false;
> >>>>>>         }
> >>>>>>
> >>>>>> +    /* Add mapping to the IOVA->HVA tree */
> >>>>>> +    needle->translated_addr =3D taddr;
> >>>>>> +    r =3D vhost_iova_tree_insert(v->shared->iova_tree, needle);
> >>>>>> +    if (unlikely(r !=3D IOVA_OK)) {
> >>>>>> +        error_setg(errp, "Cannot add SVQ vring mapping (%d)", r);
> >>>>>> +        vhost_iova_tree_remove(v->shared->iova_tree, *needle);
> >>>>>> +        return false;
> >>>>>> +    }
> >>>>>> +
> >>>>>>         r =3D vhost_vdpa_dma_map(v->shared, v->address_space_id, n=
eedle->iova,
> >>>>>>                                needle->size + 1,
> >>>>>>                                (void *)(uintptr_t)needle->translat=
ed_addr,
> >>>>>> @@ -1192,11 +1211,11 @@ static bool vhost_vdpa_svq_map_rings(struc=
t vhost_dev *dev,
> >>>>>>         vhost_svq_get_vring_addr(svq, &svq_addr);
> >>>>>>
> >>>>>>         driver_region =3D (DMAMap) {
> >>>>>> -        .translated_addr =3D svq_addr.desc_user_addr,
> >>>>>>             .size =3D driver_size - 1,
> >>>>>>             .perm =3D IOMMU_RO,
> >>>>>>         };
> >>>>>> -    ok =3D vhost_vdpa_svq_map_ring(v, &driver_region, errp);
> >>>>>> +    ok =3D vhost_vdpa_svq_map_ring(v, &driver_region, svq_addr.de=
sc_user_addr,
> >>>>>> +                                 errp);
> >>>>>>         if (unlikely(!ok)) {
> >>>>>>             error_prepend(errp, "Cannot create vq driver region: "=
);
> >>>>>>             return false;
> >>>>>> @@ -1206,11 +1225,11 @@ static bool vhost_vdpa_svq_map_rings(struc=
t vhost_dev *dev,
> >>>>>>         addr->avail_user_addr =3D driver_region.iova + avail_offse=
t;
> >>>>>>
> >>>>>>         device_region =3D (DMAMap) {
> >>>>>> -        .translated_addr =3D svq_addr.used_user_addr,
> >>>>>>             .size =3D device_size - 1,
> >>>>>>             .perm =3D IOMMU_RW,
> >>>>>>         };
> >>>>>> -    ok =3D vhost_vdpa_svq_map_ring(v, &device_region, errp);
> >>>>>> +    ok =3D vhost_vdpa_svq_map_ring(v, &device_region, svq_addr.us=
ed_user_addr,
> >>>>>> +                                 errp);
> >>>>>>         if (unlikely(!ok)) {
> >>>>>>             error_prepend(errp, "Cannot create vq device region: "=
);
> >>>>>>             vhost_vdpa_svq_unmap_ring(v, driver_region.translated_=
addr);
> >>>>>> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> >>>>>> index 03457ead66..81da956b92 100644
> >>>>>> --- a/net/vhost-vdpa.c
> >>>>>> +++ b/net/vhost-vdpa.c
> >>>>>> @@ -512,15 +512,24 @@ static int vhost_vdpa_cvq_map_buf(struct vho=
st_vdpa *v, void *buf, size_t size,
> >>>>>>         DMAMap map =3D {};
> >>>>>>         int r;
> >>>>>>
> >>>>>> -    map.translated_addr =3D (hwaddr)(uintptr_t)buf;
> >>>>>>         map.size =3D size - 1;
> >>>>>>         map.perm =3D write ? IOMMU_RW : IOMMU_RO,
> >>>>>> +
> >>>>>> +    /* Allocate IOVA range and add the mapping to the IOVA tree *=
/
> >>>>>>         r =3D vhost_iova_tree_map_alloc(v->shared->iova_tree, &map=
);
> >>>>>>         if (unlikely(r !=3D IOVA_OK)) {
> >>>>>> -        error_report("Cannot map injected element");
> >>>>>> +        error_report("Cannot allocate IOVA range for injected ele=
ment");
> >>>>>>             return r;
> >>>>>>         }
> >>>>>>
> >>>>>> +    /* Add mapping to the IOVA->HVA tree */
> >>>>>> +    map.translated_addr =3D (hwaddr)(uintptr_t)buf;
> >>>>>> +    r =3D vhost_iova_tree_insert(v->shared->iova_tree, &map);
> >>>>>> +    if (unlikely(r !=3D IOVA_OK)) {
> >>>>>> +        error_report("Cannot map injected element into IOVA->HVA =
tree");
> >>>>>> +        goto dma_map_err;
> >>>>>> +    }
> >>>>>> +
> >>>>>>         r =3D vhost_vdpa_dma_map(v->shared, v->address_space_id, m=
ap.iova,
> >>>>>>                                vhost_vdpa_net_cvq_cmd_page_len(), =
buf, !write);
> >>>>>>         if (unlikely(r < 0)) {
> >>>>>> --
> >>>>>> 2.43.5
> >>>>>>
>


