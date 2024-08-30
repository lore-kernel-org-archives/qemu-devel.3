Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FFEACA0EE8
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 08:06:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjweB-0003p9-17; Fri, 30 Aug 2024 04:06:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1sjwe9-0003iw-BN
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 04:06:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1sjwe6-0001Zx-DA
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 04:06:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725005172;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h00oZd2DQqQ+H6dazXU8Ymm8aao2OUL6MlL9JJI3kOk=;
 b=f3XSm/FPpiHKs8MoDM8E8v30Fph0f0RgoWYWXNkipO5sQHufhWiZiVByJsI79y4ViOc/uo
 sawXSppKPWzhV0yIS0+VAaBIP2Xb9sFd6XkuQJVbCEue1i4wasr5C7efv5CzHXDP5pwVFN
 zpDHyhyVxI+6faEbMJ45LA+SJLrLqEc=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-Kbe2HiDuPNq61l3Jdnk0rg-1; Fri, 30 Aug 2024 04:06:10 -0400
X-MC-Unique: Kbe2HiDuPNq61l3Jdnk0rg-1
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-6b991a4727eso28730357b3.1
 for <qemu-devel@nongnu.org>; Fri, 30 Aug 2024 01:06:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725005169; x=1725609969;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h00oZd2DQqQ+H6dazXU8Ymm8aao2OUL6MlL9JJI3kOk=;
 b=dvMF7XNY8KL8VtT6wRJSrv/46N3QiNncCY7DTB1XR5jvYn20aqGrLqJLrdjRKdG5fB
 FrxCHsQwvzzCOYreKX3vsloeaR47dergl80a+1lydc34nzxTSq5GtjGF7FbyiPXnVzZQ
 X5TGrDgJv/F8sUzeKFNz5o3NKA2LW3IZLSZthFd2sDq5avB+0qPHGTa4XD7EPR1dVm+f
 tw29iOrVgo1avtyzRqX0m701aX7QBxkBx0mY6cu/FB7KyLB7YiQFutnQ6TpkhaitWPZd
 h7H9Ln6ExlrTXUyaLfKlO+famFr/OA9eTwndZMpe9pdlX89mBPJ/ZW0ZCvBboI39VnC3
 p8xw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgYhZi1oZAb+0F43wvt7OipiGiG73YLejxcIV6kjxH8AFDX0QFirVAI40CJd1pPnECFSkjCDyDnwva@nongnu.org
X-Gm-Message-State: AOJu0YzU6nIU76bcslafV1Zg5gt5HoTz4fu/cN/VWOSbu+T7WyoF0KI1
 ukSjYHlNhcXx1ClVGbSIHFdFKM7yPEfyBnKJhvyyeYv8YNkfCijF2qhoahtIj1153r5JAKPcWwM
 MHJ3lOgwzcLipVv4r0200Hs/1uUk4c8mutfm/CWiR+FyWdWUOqdHLFKZgBMR4qE8jNwjzIya77T
 XjgZu10kSOozvzVgV7/I7aADnTqg0=
X-Received: by 2002:a05:690c:893:b0:6af:8662:ff43 with SMTP id
 00721157ae682-6d40fe1326cmr13282227b3.37.1725005169288; 
 Fri, 30 Aug 2024 01:06:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMEvyeb4Ptqk4kN1mo0goKVU+BRlEBfdnbVo3C9apcZeVU8IhK5sKpgAGpHu9T+miwtDOAvr3QtZnrScLgSTo=
X-Received: by 2002:a05:690c:893:b0:6af:8662:ff43 with SMTP id
 00721157ae682-6d40fe1326cmr13281967b3.37.1725005168828; Fri, 30 Aug 2024
 01:06:08 -0700 (PDT)
MIME-Version: 1.0
References: <20240821125548.749143-1-jonah.palmer@oracle.com>
 <20240821125548.749143-2-jonah.palmer@oracle.com>
 <CAJaqyWegFi5h56HQ2Ga5BsJ-UwMmxF5rQujE6ZAYJKEZaRy65w@mail.gmail.com>
 <436fc148-d1ac-17be-09f4-e776661c534a@oracle.com>
In-Reply-To: <436fc148-d1ac-17be-09f4-e776661c534a@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 30 Aug 2024 10:05:31 +0200
Message-ID: <CAJaqyWeEgSar8f_O26aw+WoSKFGc8DoVkxTv-XEPPo_AeLXLSw@mail.gmail.com>
Subject: Re: [RFC 1/2] vhost-vdpa: Decouple the IOVA allocator
To: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: Jonah Palmer <jonah.palmer@oracle.com>, qemu-devel@nongnu.org,
 mst@redhat.com, 
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
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Fri, Aug 30, 2024 at 6:20=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.com> =
wrote:
>
>
>
> On 8/29/2024 9:53 AM, Eugenio Perez Martin wrote:
> > On Wed, Aug 21, 2024 at 2:56=E2=80=AFPM Jonah Palmer <jonah.palmer@orac=
le.com> wrote:
> >> Decouples the IOVA allocator from the IOVA->HVA tree and instead adds
> >> the allocated IOVA range to an IOVA-only tree (iova_map). This IOVA tr=
ee
> >> will hold all IOVA ranges that have been allocated (e.g. in the
> >> IOVA->HVA tree) and are removed when any IOVA ranges are deallocated.
> >>
> >> A new API function vhost_iova_tree_insert() is also created to add a
> >> IOVA->HVA mapping into the IOVA->HVA tree.
> >>
> > I think this is a good first iteration but we can take steps to
> > simplify it. Also, it is great to be able to make points on real code
> > instead of designs on the air :).
> >
> > I expected a split of vhost_iova_tree_map_alloc between the current
> > vhost_iova_tree_map_alloc and vhost_iova_tree_map_alloc_gpa, or
> > similar. Similarly, a vhost_iova_tree_remove and
> > vhost_iova_tree_remove_gpa would be needed.
> >
> > The first one is used for regions that don't exist in the guest, like
> > SVQ vrings or CVQ buffers. The second one is the one used by the
> > memory listener to map the guest regions into the vdpa device.
> >
> > Implementation wise, only two trees are actually needed:
> > * Current iova_taddr_map that contains all IOVA->vaddr translations as
> > seen by the device, so both allocation functions can work on a single
> > tree. The function iova_tree_find_iova keeps using this one, so the
> I thought we had thorough discussion about this and agreed upon the
> decoupled IOVA allocator solution.

My interpretation of it is to leave the allocator as the current one,
and create a new tree with GPA which is guaranteed to be unique. But
we can talk over it of course.

> But maybe I missed something earlier,
> I am not clear how come this iova_tree_find_iova function could still
> work with the full IOVA-> HVA tree when it comes to aliased memory or
> overlapped HVAs? Granted, for the memory map removal in the
> .region_del() path, we could rely on the GPA tree to locate the
> corresponding IOVA, but how come the translation path could figure out
> which IOVA range to return when the vaddr happens to fall in an
> overlapped HVA range?

That is not a problem, as they both translate to the same address at the de=
vice.

The most complicated situation is where we have a region contained in
another region, and the requested buffer crosses them. If the IOVA
tree returns the inner region, it will return the buffer chained with
the rest of the content in the outer region. Not optimal, but solved
either way.

The only problem that comes to my mind is the case where the inner
region is RO and it is a write command, but I don't think we have this
case in a sane guest. A malicious guest cannot do any harm this way
anyway.

> Do we still assume some overlapping order so we
> always return the first match from the tree? Or we expect every current
> user of iova_tree_find_iova should pass in GPA rather than HVA and use
> the vhost_iova_xxx_gpa API variant to look up IOVA?
>

No, iova_tree_find_iova should keep asking for vaddr, as the result is
guaranteed to be there. Users of VhostIOVATree only need to modify how
they add or remove regions, knowing if they come from the guest or
not. As shown by this series, it is easier to do in that place than in
translation.

> Thanks,
> -Siwei
>
> > user does not need to know if the address is from the guest or only
> > exists in QEMU by using RAMBlock etc. All insert and remove functions
> > use this tree.
> > * A new tree that relates IOVA to GPA, that only
> > vhost_iova_tree_map_alloc_gpa and vhost_iova_tree_remove_gpa uses.
> >
> > The ideal case is that the key in this new tree is the GPA and the
> > value is the IOVA. But IOVATree's DMA is named the reverse: iova is
> > the key and translated_addr is the vaddr. We can create a new tree
> > struct for that, use GTree directly, or translate the reverse
> > linearly. As memory add / remove should not be frequent, I think the
> > simpler is the last one, but I'd be ok with creating a new tree.
> >
> > vhost_iova_tree_map_alloc_gpa needs to add the map to this new tree
> > also. Similarly, vhost_iova_tree_remove_gpa must look for the GPA in
> > this tree, and only remove the associated DMAMap in iova_taddr_map
> > that matches the IOVA.
> >
> > Does it make sense to you?
> >
> >> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
> >> ---
> >>   hw/virtio/vhost-iova-tree.c | 38 ++++++++++++++++++++++++++++++++---=
--
> >>   hw/virtio/vhost-iova-tree.h |  1 +
> >>   hw/virtio/vhost-vdpa.c      | 31 ++++++++++++++++++++++++------
> >>   net/vhost-vdpa.c            | 13 +++++++++++--
> >>   4 files changed, 70 insertions(+), 13 deletions(-)
> >>
> >> diff --git a/hw/virtio/vhost-iova-tree.c b/hw/virtio/vhost-iova-tree.c
> >> index 3d03395a77..32c03db2f5 100644
> >> --- a/hw/virtio/vhost-iova-tree.c
> >> +++ b/hw/virtio/vhost-iova-tree.c
> >> @@ -28,12 +28,17 @@ struct VhostIOVATree {
> >>
> >>       /* IOVA address to qemu memory maps. */
> >>       IOVATree *iova_taddr_map;
> >> +
> >> +    /* IOVA tree (IOVA allocator) */
> >> +    IOVATree *iova_map;
> >>   };
> >>
> >>   /**
> >> - * Create a new IOVA tree
> >> + * Create a new VhostIOVATree with a new set of IOVATree's:
> > s/IOVA tree/VhostIOVATree/ is good, but I think the rest is more an
> > implementation detail.
> >
> >> + * - IOVA allocator (iova_map)
> >> + * - IOVA->HVA tree (iova_taddr_map)
> >>    *
> >> - * Returns the new IOVA tree
> >> + * Returns the new VhostIOVATree
> >>    */
> >>   VhostIOVATree *vhost_iova_tree_new(hwaddr iova_first, hwaddr iova_la=
st)
> >>   {
> >> @@ -44,6 +49,7 @@ VhostIOVATree *vhost_iova_tree_new(hwaddr iova_first=
, hwaddr iova_last)
> >>       tree->iova_last =3D iova_last;
> >>
> >>       tree->iova_taddr_map =3D iova_tree_new();
> >> +    tree->iova_map =3D iova_tree_new();
> >>       return tree;
> >>   }
> >>
> >> @@ -53,6 +59,7 @@ VhostIOVATree *vhost_iova_tree_new(hwaddr iova_first=
, hwaddr iova_last)
> >>   void vhost_iova_tree_delete(VhostIOVATree *iova_tree)
> >>   {
> >>       iova_tree_destroy(iova_tree->iova_taddr_map);
> >> +    iova_tree_destroy(iova_tree->iova_map);
> >>       g_free(iova_tree);
> >>   }
> >>
> >> @@ -88,13 +95,12 @@ int vhost_iova_tree_map_alloc(VhostIOVATree *tree,=
 DMAMap *map)
> >>       /* Some vhost devices do not like addr 0. Skip first page */
> >>       hwaddr iova_first =3D tree->iova_first ?: qemu_real_host_page_si=
ze();
> >>
> >> -    if (map->translated_addr + map->size < map->translated_addr ||
> > Why remove this condition? If the request is invalid we still need to
> > return an error here.
> >
> > Maybe we should move it to iova_tree_alloc_map though.
> >
> >> -        map->perm =3D=3D IOMMU_NONE) {
> >> +    if (map->perm =3D=3D IOMMU_NONE) {
> >>           return IOVA_ERR_INVALID;
> >>       }
> >>
> >>       /* Allocate a node in IOVA address */
> >> -    return iova_tree_alloc_map(tree->iova_taddr_map, map, iova_first,
> >> +    return iova_tree_alloc_map(tree->iova_map, map, iova_first,
> >>                                  tree->iova_last);
> >>   }
> >>
> >> @@ -107,4 +113,26 @@ int vhost_iova_tree_map_alloc(VhostIOVATree *tree=
, DMAMap *map)
> >>   void vhost_iova_tree_remove(VhostIOVATree *iova_tree, DMAMap map)
> >>   {
> >>       iova_tree_remove(iova_tree->iova_taddr_map, map);
> >> +    iova_tree_remove(iova_tree->iova_map, map);
> >> +}
> >> +
> >> +/**
> >> + * Insert a new mapping to the IOVA->HVA tree
> >> + *
> >> + * @tree: The VhostIOVATree
> >> + * @map: The iova map
> >> + *
> >> + * Returns:
> >> + * - IOVA_OK if the map fits in the container
> >> + * - IOVA_ERR_INVALID if the map does not make sense (like size overf=
low)
> >> + * - IOVA_ERR_OVERLAP if the IOVA range overlaps with an existing ran=
ge
> >> + */
> >> +int vhost_iova_tree_insert(VhostIOVATree *iova_tree, DMAMap *map)
> >> +{
> >> +    if (map->translated_addr + map->size < map->translated_addr ||
> >> +        map->perm =3D=3D IOMMU_NONE) {
> >> +        return IOVA_ERR_INVALID;
> >> +    }
> >> +
> >> +    return iova_tree_insert(iova_tree->iova_taddr_map, map);
> >>   }
> >> diff --git a/hw/virtio/vhost-iova-tree.h b/hw/virtio/vhost-iova-tree.h
> >> index 4adfd79ff0..8bf7b64786 100644
> >> --- a/hw/virtio/vhost-iova-tree.h
> >> +++ b/hw/virtio/vhost-iova-tree.h
> >> @@ -23,5 +23,6 @@ const DMAMap *vhost_iova_tree_find_iova(const VhostI=
OVATree *iova_tree,
> >>                                           const DMAMap *map);
> >>   int vhost_iova_tree_map_alloc(VhostIOVATree *iova_tree, DMAMap *map)=
;
> >>   void vhost_iova_tree_remove(VhostIOVATree *iova_tree, DMAMap map);
> >> +int vhost_iova_tree_insert(VhostIOVATree *iova_tree, DMAMap *map);
> >>
> >>   #endif
> >> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> >> index 3cdaa12ed5..6702459065 100644
> >> --- a/hw/virtio/vhost-vdpa.c
> >> +++ b/hw/virtio/vhost-vdpa.c
> >> @@ -361,10 +361,10 @@ static void vhost_vdpa_listener_region_add(Memor=
yListener *listener,
> >>       if (s->shadow_data) {
> >>           int r;
> >>
> >> -        mem_region.translated_addr =3D (hwaddr)(uintptr_t)vaddr,
> >>           mem_region.size =3D int128_get64(llsize) - 1,
> >>           mem_region.perm =3D IOMMU_ACCESS_FLAG(true, section->readonl=
y),
> >>
> >> +        /* Allocate IOVA range and add the mapping to the IOVA tree *=
/
> >>           r =3D vhost_iova_tree_map_alloc(s->iova_tree, &mem_region);
> >>           if (unlikely(r !=3D IOVA_OK)) {
> >>               error_report("Can't allocate a mapping (%d)", r);
> >> @@ -372,6 +372,14 @@ static void vhost_vdpa_listener_region_add(Memory=
Listener *listener,
> >>           }
> >>
> >>           iova =3D mem_region.iova;
> >> +
> >> +        /* Add mapping to the IOVA->HVA tree */
> >> +        mem_region.translated_addr =3D (hwaddr)(uintptr_t)vaddr;
> >> +        r =3D vhost_iova_tree_insert(s->iova_tree, &mem_region);
> >> +        if (unlikely(r !=3D IOVA_OK)) {
> >> +            error_report("Can't add listener region mapping (%d)", r)=
;
> >> +            goto fail_map;
> >> +        }
> > I'd say it is not intuitive for the caller code.
> >
> >>       }
> >>
> >>       vhost_vdpa_iotlb_batch_begin_once(s);
> >> @@ -1142,19 +1150,30 @@ static void vhost_vdpa_svq_unmap_rings(struct =
vhost_dev *dev,
> >>    *
> >>    * @v: Vhost-vdpa device
> >>    * @needle: The area to search iova
> >> + * @taddr: The translated address (SVQ HVA)
> >>    * @errorp: Error pointer
> >>    */
> >>   static bool vhost_vdpa_svq_map_ring(struct vhost_vdpa *v, DMAMap *ne=
edle,
> >> -                                    Error **errp)
> >> +                                    hwaddr taddr, Error **errp)
> >>   {
> >>       int r;
> >>
> >> +    /* Allocate IOVA range and add the mapping to the IOVA tree */
> >>       r =3D vhost_iova_tree_map_alloc(v->shared->iova_tree, needle);
> >>       if (unlikely(r !=3D IOVA_OK)) {
> >>           error_setg(errp, "Cannot allocate iova (%d)", r);
> >>           return false;
> >>       }
> >>
> >> +    /* Add mapping to the IOVA->HVA tree */
> >> +    needle->translated_addr =3D taddr;
> >> +    r =3D vhost_iova_tree_insert(v->shared->iova_tree, needle);
> >> +    if (unlikely(r !=3D IOVA_OK)) {
> >> +        error_setg(errp, "Cannot add SVQ vring mapping (%d)", r);
> >> +        vhost_iova_tree_remove(v->shared->iova_tree, *needle);
> >> +        return false;
> >> +    }
> >> +
> >>       r =3D vhost_vdpa_dma_map(v->shared, v->address_space_id, needle-=
>iova,
> >>                              needle->size + 1,
> >>                              (void *)(uintptr_t)needle->translated_add=
r,
> >> @@ -1192,11 +1211,11 @@ static bool vhost_vdpa_svq_map_rings(struct vh=
ost_dev *dev,
> >>       vhost_svq_get_vring_addr(svq, &svq_addr);
> >>
> >>       driver_region =3D (DMAMap) {
> >> -        .translated_addr =3D svq_addr.desc_user_addr,
> >>           .size =3D driver_size - 1,
> >>           .perm =3D IOMMU_RO,
> >>       };
> >> -    ok =3D vhost_vdpa_svq_map_ring(v, &driver_region, errp);
> >> +    ok =3D vhost_vdpa_svq_map_ring(v, &driver_region, svq_addr.desc_u=
ser_addr,
> >> +                                 errp);
> >>       if (unlikely(!ok)) {
> >>           error_prepend(errp, "Cannot create vq driver region: ");
> >>           return false;
> >> @@ -1206,11 +1225,11 @@ static bool vhost_vdpa_svq_map_rings(struct vh=
ost_dev *dev,
> >>       addr->avail_user_addr =3D driver_region.iova + avail_offset;
> >>
> >>       device_region =3D (DMAMap) {
> >> -        .translated_addr =3D svq_addr.used_user_addr,
> >>           .size =3D device_size - 1,
> >>           .perm =3D IOMMU_RW,
> >>       };
> >> -    ok =3D vhost_vdpa_svq_map_ring(v, &device_region, errp);
> >> +    ok =3D vhost_vdpa_svq_map_ring(v, &device_region, svq_addr.used_u=
ser_addr,
> >> +                                 errp);
> >>       if (unlikely(!ok)) {
> >>           error_prepend(errp, "Cannot create vq device region: ");
> >>           vhost_vdpa_svq_unmap_ring(v, driver_region.translated_addr);
> >> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> >> index 03457ead66..81da956b92 100644
> >> --- a/net/vhost-vdpa.c
> >> +++ b/net/vhost-vdpa.c
> >> @@ -512,15 +512,24 @@ static int vhost_vdpa_cvq_map_buf(struct vhost_v=
dpa *v, void *buf, size_t size,
> >>       DMAMap map =3D {};
> >>       int r;
> >>
> >> -    map.translated_addr =3D (hwaddr)(uintptr_t)buf;
> >>       map.size =3D size - 1;
> >>       map.perm =3D write ? IOMMU_RW : IOMMU_RO,
> >> +
> >> +    /* Allocate IOVA range and add the mapping to the IOVA tree */
> >>       r =3D vhost_iova_tree_map_alloc(v->shared->iova_tree, &map);
> >>       if (unlikely(r !=3D IOVA_OK)) {
> >> -        error_report("Cannot map injected element");
> >> +        error_report("Cannot allocate IOVA range for injected element=
");
> >>           return r;
> >>       }
> >>
> >> +    /* Add mapping to the IOVA->HVA tree */
> >> +    map.translated_addr =3D (hwaddr)(uintptr_t)buf;
> >> +    r =3D vhost_iova_tree_insert(v->shared->iova_tree, &map);
> >> +    if (unlikely(r !=3D IOVA_OK)) {
> >> +        error_report("Cannot map injected element into IOVA->HVA tree=
");
> >> +        goto dma_map_err;
> >> +    }
> >> +
> >>       r =3D vhost_vdpa_dma_map(v->shared, v->address_space_id, map.iov=
a,
> >>                              vhost_vdpa_net_cvq_cmd_page_len(), buf, !=
write);
> >>       if (unlikely(r < 0)) {
> >> --
> >> 2.43.5
> >>
>


