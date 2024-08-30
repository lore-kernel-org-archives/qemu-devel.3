Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA0F7CA0FFD
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 14:52:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sk2xz-0001Sx-37; Fri, 30 Aug 2024 10:51:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1sk2xx-0001SL-6y
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 10:51:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1sk2xt-00044c-EM
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 10:51:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725029463;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Io0VT6k7l6UXbC1ZumNWLAeZ1iJ2zBoBFYq7rayzfAQ=;
 b=CSROXkguTY5Usj7PTHzyJXArtG12NLliGGw+ZF80B2p0wyJyqcLUoXroobB8TCuUgTKq0D
 2pq5QgkQjONGVqNeVCFzDtH80G7EdbjCQKjtTDODL8SsmQL5cK6mBkis9QEgPVsf/j4Uxh
 tjL/3CXkPsQc3VZwA51vC5tFte+Uj4g=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-2b4y8jy3OheUv76phkzspg-1; Fri, 30 Aug 2024 10:50:57 -0400
X-MC-Unique: 2b4y8jy3OheUv76phkzspg-1
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-690404fd230so32763727b3.3
 for <qemu-devel@nongnu.org>; Fri, 30 Aug 2024 07:50:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725029456; x=1725634256;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Io0VT6k7l6UXbC1ZumNWLAeZ1iJ2zBoBFYq7rayzfAQ=;
 b=SlQCMzuXCOCrOPaqtQ5mH/DUIrImLQFnpBi6ixtoMkiWFNa1Z8Iq2RHgCGnjFMvSkk
 Q7Y7IGE6zvcbKiMLeSSLkkX1CZjMPjl+iuJwznbZ3vk1k/AerKgeEzks9yaT+GRCzV+d
 fFzyV2EkroQ4AbDPsGfRDo2UZvcsKEnKSX7njTB7kpZRsGBCujaphLPCooJILNkluDJJ
 EFH/0SE4mGzvmFxtwo2Tt3Kq0CMVsLW+va3ekVnvULFgWFFJhVELUINW5IP5Q7ufqDiI
 49G0WLu2shcSpFNim+/0ECGrsaA9FOYRHsy5z5bB7dcBoUs+p1m9VqHz9nYuCwCPw92L
 eZ2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbbsFVXsweR/mF8ROYK/4m+ku3UMJIDRmU7xWGWYU1lUwEOL32cJv6ul9XO4lMUMFmJxbLF8RvjAEI@nongnu.org
X-Gm-Message-State: AOJu0YyYHdhr07x+wHp8AM+AGBKOdoWZAPt9EoE7DXnYCO9gNigfAmmh
 asDCfllkNmRuRutZ2QhF54OTo9CIPUMkc4I5B80ywUy3GY+IpkiWu+iWDc/EaUF7tJ/cX3bMsew
 Vne4CdnfIzI8Icee00SvLJOOhxVDTvPPJZYLJliQvj+R4bSbEQ1wwYx9zj4Qjgcxjd+UVFOb9fp
 Ffo73y/A3zS2OI0CQF7S3bVQ+sNMs=
X-Received: by 2002:a05:690c:3001:b0:6b9:fd00:95c9 with SMTP id
 00721157ae682-6d40f722464mr28026087b3.28.1725029456374; 
 Fri, 30 Aug 2024 07:50:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESKWgClqPvyc5FyiaVn6n5H4MiVqGbEz/5ogkRpCjRFJuDezNHfqrJX59xCD2G2NdTZrYUBivLSrZquGBWX0M=
X-Received: by 2002:a05:690c:3001:b0:6b9:fd00:95c9 with SMTP id
 00721157ae682-6d40f722464mr28025797b3.28.1725029455890; Fri, 30 Aug 2024
 07:50:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240821125548.749143-1-jonah.palmer@oracle.com>
 <20240821125548.749143-2-jonah.palmer@oracle.com>
 <CAJaqyWegFi5h56HQ2Ga5BsJ-UwMmxF5rQujE6ZAYJKEZaRy65w@mail.gmail.com>
 <436fc148-d1ac-17be-09f4-e776661c534a@oracle.com>
 <CAJaqyWeEgSar8f_O26aw+WoSKFGc8DoVkxTv-XEPPo_AeLXLSw@mail.gmail.com>
 <82663e6b-0591-44da-ba88-58622e0ca56d@oracle.com>
In-Reply-To: <82663e6b-0591-44da-ba88-58622e0ca56d@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 30 Aug 2024 16:50:19 +0200
Message-ID: <CAJaqyWdY1wUUuUq+n9Vvb-Jo3=JCFXfE+SMPB3Gt7OowpkruPA@mail.gmail.com>
Subject: Re: [RFC 1/2] vhost-vdpa: Decouple the IOVA allocator
To: Jonah Palmer <jonah.palmer@oracle.com>
Cc: Si-Wei Liu <si-wei.liu@oracle.com>, qemu-devel@nongnu.org, mst@redhat.com, 
 leiyang@redhat.com, peterx@redhat.com, dtatulea@nvidia.com, 
 jasowang@redhat.com, boris.ostrovsky@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Fri, Aug 30, 2024 at 3:52=E2=80=AFPM Jonah Palmer <jonah.palmer@oracle.c=
om> wrote:
>
>
>
> On 8/30/24 4:05 AM, Eugenio Perez Martin wrote:
> > On Fri, Aug 30, 2024 at 6:20=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.c=
om> wrote:
> >>
> >>
> >>
> >> On 8/29/2024 9:53 AM, Eugenio Perez Martin wrote:
> >>> On Wed, Aug 21, 2024 at 2:56=E2=80=AFPM Jonah Palmer <jonah.palmer@or=
acle.com> wrote:
> >>>> Decouples the IOVA allocator from the IOVA->HVA tree and instead add=
s
> >>>> the allocated IOVA range to an IOVA-only tree (iova_map). This IOVA =
tree
> >>>> will hold all IOVA ranges that have been allocated (e.g. in the
> >>>> IOVA->HVA tree) and are removed when any IOVA ranges are deallocated=
.
> >>>>
> >>>> A new API function vhost_iova_tree_insert() is also created to add a
> >>>> IOVA->HVA mapping into the IOVA->HVA tree.
> >>>>
> >>> I think this is a good first iteration but we can take steps to
> >>> simplify it. Also, it is great to be able to make points on real code
> >>> instead of designs on the air :).
> >>>
>
> I can add more comments in the code if this is what you mean, no problem!
>

No action needed about this feedback :). I just meant that it will be
easier to iterate on code than designing just by talking at this
stage.

> >>> I expected a split of vhost_iova_tree_map_alloc between the current
> >>> vhost_iova_tree_map_alloc and vhost_iova_tree_map_alloc_gpa, or
> >>> similar. Similarly, a vhost_iova_tree_remove and
> >>> vhost_iova_tree_remove_gpa would be needed.
> >>> >>> The first one is used for regions that don't exist in the guest, =
like
> >>> SVQ vrings or CVQ buffers. The second one is the one used by the
> >>> memory listener to map the guest regions into the vdpa device.
> >>>
> >>> Implementation wise, only two trees are actually needed:
> >>> * Current iova_taddr_map that contains all IOVA->vaddr translations a=
s
> >>> seen by the device, so both allocation functions can work on a single
> >>> tree. The function iova_tree_find_iova keeps using this one, so the
> >> I thought we had thorough discussion about this and agreed upon the
> >> decoupled IOVA allocator solution.
> >
> > My interpretation of it is to leave the allocator as the current one,
> > and create a new tree with GPA which is guaranteed to be unique. But
> > we can talk over it of course.
> >
>
> So you mean keep the full IOVA->HVA tree but also have a GPA->IOVA tree
> as well for guest memory regions, correct?
>

Right.

> >> But maybe I missed something earlier,
> >> I am not clear how come this iova_tree_find_iova function could still
> >> work with the full IOVA-> HVA tree when it comes to aliased memory or
> >> overlapped HVAs? Granted, for the memory map removal in the
> >> .region_del() path, we could rely on the GPA tree to locate the
> >> corresponding IOVA, but how come the translation path could figure out
> >> which IOVA range to return when the vaddr happens to fall in an
> >> overlapped HVA range?
> >
> > That is not a problem, as they both translate to the same address at th=
e device.
> >
> > The most complicated situation is where we have a region contained in
> > another region, and the requested buffer crosses them. If the IOVA
> > tree returns the inner region, it will return the buffer chained with
> > the rest of the content in the outer region. Not optimal, but solved
> > either way.
> >
> > The only problem that comes to my mind is the case where the inner
> > region is RO and it is a write command, but I don't think we have this
> > case in a sane guest. A malicious guest cannot do any harm this way
> > anyway.
> >
> >> Do we still assume some overlapping order so we
> >> always return the first match from the tree? Or we expect every curren=
t
> >> user of iova_tree_find_iova should pass in GPA rather than HVA and use
> >> the vhost_iova_xxx_gpa API variant to look up IOVA?
> >>
> >
> > No, iova_tree_find_iova should keep asking for vaddr, as the result is
> > guaranteed to be there. Users of VhostIOVATree only need to modify how
> > they add or remove regions, knowing if they come from the guest or
> > not. As shown by this series, it is easier to do in that place than in
> > translation.
> >
> >> Thanks,
> >> -Siwei
> >>
> >>> user does not need to know if the address is from the guest or only
> >>> exists in QEMU by using RAMBlock etc. All insert and remove functions
> >>> use this tree.
> >>> * A new tree that relates IOVA to GPA, that only
> >>> vhost_iova_tree_map_alloc_gpa and vhost_iova_tree_remove_gpa uses.
> >>>
> >>> The ideal case is that the key in this new tree is the GPA and the
> >>> value is the IOVA. But IOVATree's DMA is named the reverse: iova is
> >>> the key and translated_addr is the vaddr. We can create a new tree
> >>> struct for that, use GTree directly, or translate the reverse
> >>> linearly. As memory add / remove should not be frequent, I think the
> >>> simpler is the last one, but I'd be ok with creating a new tree.
> >>>
>
> Is the concern here that making the gpa_map (GPA->IOVA tree) of type
> IOVATree can be confusing for users from an API perspective?
>
> In other words, IOVATree users should always use its iova member as the
> key and the translated_addr member as the value (and thus IOVATree
> gpa_map feels out of place since it uses the translated_addr as the key
> and iova as the value)?
>

Totally right.

> Also, could you elaborate a bit more on "translate the reverse
> linearly"? Do you mean to create an IOVA->GPA tree but always search the
> tree using the GPA (e.g. via iova_tree_find_iova)?
>

Yes, that's the other option. I'm comparing the two options here:
* IOVA->GPA has the advantage of reusing IOVATree, but lookups for GPA is O=
(N).
* GPA->IOVA is more natural but we cannot reuse IOVATree in a simple way.

> >>> vhost_iova_tree_map_alloc_gpa needs to add the map to this new tree
> >>> also. Similarly, vhost_iova_tree_remove_gpa must look for the GPA in
> >>> this tree, and only remove the associated DMAMap in iova_taddr_map
> >>> that matches the IOVA.
> >>>
> >>> Does it make sense to you?
>
> Would using a name like vhost_iova_tree_map_alloc_gpa seem a bit
> misleading given that we're already allocating the IOVA range in
> vhost_iova_tree_map_alloc?

With the vhost_iova_tree_map_alloc_gpa there is no need to call
vhost_iova_tree_map_alloc. It's like merging the two operations, so
the caller does not need to know the internals.

> It seems this would be more of an insertion
> rather than an allocation when adding a map to the GPA->IOVA tree.
>

Let's put it another way, why complicate IOVATree or VhostIOVATree by
integrating the GPA->IOVA or the IOVA->GPA if we could simply store
that information in the caller and make each struct simpler?

If we abstract away the two trees under a coherent API, the struct
makes sense. If not, it would be better to let the caller handle the
information.

> Also, are you saying that vhost_iova_tree_remove_gpa only removes the
> DMAMap in the IOVA->HVA tree or should it also remove the corresponding
> mapping in the GPA->IOVA tree?
>

It should remove it in both.

> >>>
> >>>> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
> >>>> ---
> >>>>    hw/virtio/vhost-iova-tree.c | 38 ++++++++++++++++++++++++++++++++=
-----
> >>>>    hw/virtio/vhost-iova-tree.h |  1 +
> >>>>    hw/virtio/vhost-vdpa.c      | 31 ++++++++++++++++++++++++------
> >>>>    net/vhost-vdpa.c            | 13 +++++++++++--
> >>>>    4 files changed, 70 insertions(+), 13 deletions(-)
> >>>>
> >>>> diff --git a/hw/virtio/vhost-iova-tree.c b/hw/virtio/vhost-iova-tree=
.c
> >>>> index 3d03395a77..32c03db2f5 100644
> >>>> --- a/hw/virtio/vhost-iova-tree.c
> >>>> +++ b/hw/virtio/vhost-iova-tree.c
> >>>> @@ -28,12 +28,17 @@ struct VhostIOVATree {
> >>>>
> >>>>        /* IOVA address to qemu memory maps. */
> >>>>        IOVATree *iova_taddr_map;
> >>>> +
> >>>> +    /* IOVA tree (IOVA allocator) */
> >>>> +    IOVATree *iova_map;
> >>>>    };
> >>>>
> >>>>    /**
> >>>> - * Create a new IOVA tree
> >>>> + * Create a new VhostIOVATree with a new set of IOVATree's:
> >>> s/IOVA tree/VhostIOVATree/ is good, but I think the rest is more an
> >>> implementation detail.
> >>>
>
> Gotcha. Would you like me to remove the other comments then?
>

Yes, it is better to remove the ones that expose internals. We should
be able to change these kind of details without the users of the
VhostIOVATree notice it.

> >>>> + * - IOVA allocator (iova_map)
> >>>> + * - IOVA->HVA tree (iova_taddr_map)
> >>>>     *
> >>>> - * Returns the new IOVA tree
> >>>> + * Returns the new VhostIOVATree
> >>>>     */
> >>>>    VhostIOVATree *vhost_iova_tree_new(hwaddr iova_first, hwaddr iova=
_last)
> >>>>    {
> >>>> @@ -44,6 +49,7 @@ VhostIOVATree *vhost_iova_tree_new(hwaddr iova_fir=
st, hwaddr iova_last)
> >>>>        tree->iova_last =3D iova_last;
> >>>>
> >>>>        tree->iova_taddr_map =3D iova_tree_new();
> >>>> +    tree->iova_map =3D iova_tree_new();
> >>>>        return tree;
> >>>>    }
> >>>>
> >>>> @@ -53,6 +59,7 @@ VhostIOVATree *vhost_iova_tree_new(hwaddr iova_fir=
st, hwaddr iova_last)
> >>>>    void vhost_iova_tree_delete(VhostIOVATree *iova_tree)
> >>>>    {
> >>>>        iova_tree_destroy(iova_tree->iova_taddr_map);
> >>>> +    iova_tree_destroy(iova_tree->iova_map);
> >>>>        g_free(iova_tree);
> >>>>    }
> >>>>
> >>>> @@ -88,13 +95,12 @@ int vhost_iova_tree_map_alloc(VhostIOVATree *tre=
e, DMAMap *map)
> >>>>        /* Some vhost devices do not like addr 0. Skip first page */
> >>>>        hwaddr iova_first =3D tree->iova_first ?: qemu_real_host_page=
_size();
> >>>>
> >>>> -    if (map->translated_addr + map->size < map->translated_addr ||
> >>> Why remove this condition? If the request is invalid we still need to
> >>> return an error here.
> >>>
> >>> Maybe we should move it to iova_tree_alloc_map though.
> >>>
>
> This series decoupled the IOVA allocator from also adding a mapping to
> the IOVA->HVA tree and instead added IOVA ranges only to an IOVA-only
> tree. So no value existed under translated_addr for these mappings
> specifically.
>
> This check was moved to vhost_iova_tree_insert since that function
> covered adding the host-only memory mappings to the IOVA->SVQ HVA tree.
>

Ok, I missed that then. Can you extract that in a separated patch? I
think it makes sense by itself.

> >>>> -        map->perm =3D=3D IOMMU_NONE) {
> >>>> +    if (map->perm =3D=3D IOMMU_NONE) {
> >>>>            return IOVA_ERR_INVALID;
> >>>>        }
> >>>>
> >>>>        /* Allocate a node in IOVA address */
> >>>> -    return iova_tree_alloc_map(tree->iova_taddr_map, map, iova_firs=
t,
> >>>> +    return iova_tree_alloc_map(tree->iova_map, map, iova_first,
> >>>>                                   tree->iova_last);
> >>>>    }
> >>>>
> >>>> @@ -107,4 +113,26 @@ int vhost_iova_tree_map_alloc(VhostIOVATree *tr=
ee, DMAMap *map)
> >>>>    void vhost_iova_tree_remove(VhostIOVATree *iova_tree, DMAMap map)
> >>>>    {
> >>>>        iova_tree_remove(iova_tree->iova_taddr_map, map);
> >>>> +    iova_tree_remove(iova_tree->iova_map, map);
> >>>> +}
> >>>> +
> >>>> +/**
> >>>> + * Insert a new mapping to the IOVA->HVA tree
> >>>> + *
> >>>> + * @tree: The VhostIOVATree
> >>>> + * @map: The iova map
> >>>> + *
> >>>> + * Returns:
> >>>> + * - IOVA_OK if the map fits in the container
> >>>> + * - IOVA_ERR_INVALID if the map does not make sense (like size ove=
rflow)
> >>>> + * - IOVA_ERR_OVERLAP if the IOVA range overlaps with an existing r=
ange
> >>>> + */
> >>>> +int vhost_iova_tree_insert(VhostIOVATree *iova_tree, DMAMap *map)
> >>>> +{
> >>>> +    if (map->translated_addr + map->size < map->translated_addr ||
> >>>> +        map->perm =3D=3D IOMMU_NONE) {
> >>>> +        return IOVA_ERR_INVALID;
> >>>> +    }
> >>>> +
> >>>> +    return iova_tree_insert(iova_tree->iova_taddr_map, map);
> >>>>    }
> >>>> diff --git a/hw/virtio/vhost-iova-tree.h b/hw/virtio/vhost-iova-tree=
.h
> >>>> index 4adfd79ff0..8bf7b64786 100644
> >>>> --- a/hw/virtio/vhost-iova-tree.h
> >>>> +++ b/hw/virtio/vhost-iova-tree.h
> >>>> @@ -23,5 +23,6 @@ const DMAMap *vhost_iova_tree_find_iova(const Vhos=
tIOVATree *iova_tree,
> >>>>                                            const DMAMap *map);
> >>>>    int vhost_iova_tree_map_alloc(VhostIOVATree *iova_tree, DMAMap *m=
ap);
> >>>>    void vhost_iova_tree_remove(VhostIOVATree *iova_tree, DMAMap map)=
;
> >>>> +int vhost_iova_tree_insert(VhostIOVATree *iova_tree, DMAMap *map);
> >>>>
> >>>>    #endif
> >>>> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> >>>> index 3cdaa12ed5..6702459065 100644
> >>>> --- a/hw/virtio/vhost-vdpa.c
> >>>> +++ b/hw/virtio/vhost-vdpa.c
> >>>> @@ -361,10 +361,10 @@ static void vhost_vdpa_listener_region_add(Mem=
oryListener *listener,
> >>>>        if (s->shadow_data) {
> >>>>            int r;
> >>>>
> >>>> -        mem_region.translated_addr =3D (hwaddr)(uintptr_t)vaddr,
> >>>>            mem_region.size =3D int128_get64(llsize) - 1,
> >>>>            mem_region.perm =3D IOMMU_ACCESS_FLAG(true, section->read=
only),
> >>>>
> >>>> +        /* Allocate IOVA range and add the mapping to the IOVA tree=
 */
> >>>>            r =3D vhost_iova_tree_map_alloc(s->iova_tree, &mem_region=
);
> >>>>            if (unlikely(r !=3D IOVA_OK)) {
> >>>>                error_report("Can't allocate a mapping (%d)", r);
> >>>> @@ -372,6 +372,14 @@ static void vhost_vdpa_listener_region_add(Memo=
ryListener *listener,
> >>>>            }
> >>>>
> >>>>            iova =3D mem_region.iova;
> >>>> +
> >>>> +        /* Add mapping to the IOVA->HVA tree */
> >>>> +        mem_region.translated_addr =3D (hwaddr)(uintptr_t)vaddr;
> >>>> +        r =3D vhost_iova_tree_insert(s->iova_tree, &mem_region);
> >>>> +        if (unlikely(r !=3D IOVA_OK)) {
> >>>> +            error_report("Can't add listener region mapping (%d)", =
r);
> >>>> +            goto fail_map;
> >>>> +        }
> >>> I'd say it is not intuitive for the caller code.
> >>>
>
> Sorry, I'm not sure what you mean by this here. Would you mind
> elaborating a bit more?
>

If VhostIOVATree gets reused it is easy to miss the
vhost_iova_tree_insert after the allocation.

If we're going to expose this second GPA tree, I think it would be
better to place it directly in VhostShadowVirtqueue. All the
conditionals fit better that way and we don't make VhostIOVATree /
IOVATree harder to reuse. However, I keep thinking it is easy enough
to hide in VhostIOVATree.

> >>>>        }
> >>>>
> >>>>        vhost_vdpa_iotlb_batch_begin_once(s);
> >>>> @@ -1142,19 +1150,30 @@ static void vhost_vdpa_svq_unmap_rings(struc=
t vhost_dev *dev,
> >>>>     *
> >>>>     * @v: Vhost-vdpa device
> >>>>     * @needle: The area to search iova
> >>>> + * @taddr: The translated address (SVQ HVA)
> >>>>     * @errorp: Error pointer
> >>>>     */
> >>>>    static bool vhost_vdpa_svq_map_ring(struct vhost_vdpa *v, DMAMap =
*needle,
> >>>> -                                    Error **errp)
> >>>> +                                    hwaddr taddr, Error **errp)
> >>>>    {
> >>>>        int r;
> >>>>
> >>>> +    /* Allocate IOVA range and add the mapping to the IOVA tree */
> >>>>        r =3D vhost_iova_tree_map_alloc(v->shared->iova_tree, needle)=
;
> >>>>        if (unlikely(r !=3D IOVA_OK)) {
> >>>>            error_setg(errp, "Cannot allocate iova (%d)", r);
> >>>>            return false;
> >>>>        }
> >>>>
> >>>> +    /* Add mapping to the IOVA->HVA tree */
> >>>> +    needle->translated_addr =3D taddr;
> >>>> +    r =3D vhost_iova_tree_insert(v->shared->iova_tree, needle);
> >>>> +    if (unlikely(r !=3D IOVA_OK)) {
> >>>> +        error_setg(errp, "Cannot add SVQ vring mapping (%d)", r);
> >>>> +        vhost_iova_tree_remove(v->shared->iova_tree, *needle);
> >>>> +        return false;
> >>>> +    }
> >>>> +
> >>>>        r =3D vhost_vdpa_dma_map(v->shared, v->address_space_id, need=
le->iova,
> >>>>                               needle->size + 1,
> >>>>                               (void *)(uintptr_t)needle->translated_=
addr,
> >>>> @@ -1192,11 +1211,11 @@ static bool vhost_vdpa_svq_map_rings(struct =
vhost_dev *dev,
> >>>>        vhost_svq_get_vring_addr(svq, &svq_addr);
> >>>>
> >>>>        driver_region =3D (DMAMap) {
> >>>> -        .translated_addr =3D svq_addr.desc_user_addr,
> >>>>            .size =3D driver_size - 1,
> >>>>            .perm =3D IOMMU_RO,
> >>>>        };
> >>>> -    ok =3D vhost_vdpa_svq_map_ring(v, &driver_region, errp);
> >>>> +    ok =3D vhost_vdpa_svq_map_ring(v, &driver_region, svq_addr.desc=
_user_addr,
> >>>> +                                 errp);
> >>>>        if (unlikely(!ok)) {
> >>>>            error_prepend(errp, "Cannot create vq driver region: ");
> >>>>            return false;
> >>>> @@ -1206,11 +1225,11 @@ static bool vhost_vdpa_svq_map_rings(struct =
vhost_dev *dev,
> >>>>        addr->avail_user_addr =3D driver_region.iova + avail_offset;
> >>>>
> >>>>        device_region =3D (DMAMap) {
> >>>> -        .translated_addr =3D svq_addr.used_user_addr,
> >>>>            .size =3D device_size - 1,
> >>>>            .perm =3D IOMMU_RW,
> >>>>        };
> >>>> -    ok =3D vhost_vdpa_svq_map_ring(v, &device_region, errp);
> >>>> +    ok =3D vhost_vdpa_svq_map_ring(v, &device_region, svq_addr.used=
_user_addr,
> >>>> +                                 errp);
> >>>>        if (unlikely(!ok)) {
> >>>>            error_prepend(errp, "Cannot create vq device region: ");
> >>>>            vhost_vdpa_svq_unmap_ring(v, driver_region.translated_add=
r);
> >>>> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> >>>> index 03457ead66..81da956b92 100644
> >>>> --- a/net/vhost-vdpa.c
> >>>> +++ b/net/vhost-vdpa.c
> >>>> @@ -512,15 +512,24 @@ static int vhost_vdpa_cvq_map_buf(struct vhost=
_vdpa *v, void *buf, size_t size,
> >>>>        DMAMap map =3D {};
> >>>>        int r;
> >>>>
> >>>> -    map.translated_addr =3D (hwaddr)(uintptr_t)buf;
> >>>>        map.size =3D size - 1;
> >>>>        map.perm =3D write ? IOMMU_RW : IOMMU_RO,
> >>>> +
> >>>> +    /* Allocate IOVA range and add the mapping to the IOVA tree */
> >>>>        r =3D vhost_iova_tree_map_alloc(v->shared->iova_tree, &map);
> >>>>        if (unlikely(r !=3D IOVA_OK)) {
> >>>> -        error_report("Cannot map injected element");
> >>>> +        error_report("Cannot allocate IOVA range for injected eleme=
nt");
> >>>>            return r;
> >>>>        }
> >>>>
> >>>> +    /* Add mapping to the IOVA->HVA tree */
> >>>> +    map.translated_addr =3D (hwaddr)(uintptr_t)buf;
> >>>> +    r =3D vhost_iova_tree_insert(v->shared->iova_tree, &map);
> >>>> +    if (unlikely(r !=3D IOVA_OK)) {
> >>>> +        error_report("Cannot map injected element into IOVA->HVA tr=
ee");
> >>>> +        goto dma_map_err;
> >>>> +    }
> >>>> +
> >>>>        r =3D vhost_vdpa_dma_map(v->shared, v->address_space_id, map.=
iova,
> >>>>                               vhost_vdpa_net_cvq_cmd_page_len(), buf=
, !write);
> >>>>        if (unlikely(r < 0)) {
> >>>> --
> >>>> 2.43.5
> >>>>
> >>
> >
>


