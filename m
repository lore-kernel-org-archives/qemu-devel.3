Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53FBBC02187
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 16:46:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYT0P-0002Js-VB; Thu, 16 Jan 2025 11:46:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1tYSzw-0002Hf-SO
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 11:45:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1tYSzt-0004Cp-JO
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 11:45:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737045930;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YjB1l9pVyGgyYDb1NUnvUOJFosFHu1n0oThIDrtPV14=;
 b=HleyFuZhOgYaEF+xPUzb0b1wi43aAJHPIZ9N4GD8m5NaSnCFEoCG81uqtwLqJUVseY/ilg
 6mzk6/zCJIowi30fjUdH+mmlL6s6YKjY9oYNjNMk290k7xov9deI5GsW/P7GSZOyTHdh+4
 H40b5acqdx/jwxiXa3pGFTkD2PmBhwM=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-443-U1MkZEXEPoSjJNVTUJMy7g-1; Thu, 16 Jan 2025 11:45:29 -0500
X-MC-Unique: U1MkZEXEPoSjJNVTUJMy7g-1
X-Mimecast-MFC-AGG-ID: U1MkZEXEPoSjJNVTUJMy7g
Received: by mail-yb1-f199.google.com with SMTP id
 3f1490d57ef6-e38d8aaeb4aso3150591276.1
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 08:45:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737045929; x=1737650729;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YjB1l9pVyGgyYDb1NUnvUOJFosFHu1n0oThIDrtPV14=;
 b=K+nsCFKHU6JhIpsgkfDCwmbJoZAmVn8HsE9ysnPAoU+iC9YhAOWG7JiVELaecGqFrl
 KMmLja8YPn844kKPj88odhomEvGz7L8i3x+a7xJlLFbQGXREN493CZawlQ38e0Q986fD
 joLAkkpSQSvt0zKGWK3D/J2gjF0/FS0G9nEveVAFYjKU+kbss8NC2T2dJ+dcojs/9qG3
 15RLmed8+5VAPwPTqhszj9DdggcNi5k25b3DiRhz/YX/woNbbE/14SRZm/ZtKcrLhPtV
 oUGOZP3zPIda2BER5KTO3KEhuUthJVWGcossD4BhX1akfX+3i/WO18wQ4rXFKqPDSC0l
 lJ/Q==
X-Gm-Message-State: AOJu0Yx/hQAMqnj724vp4q7wx7USkDVQhULeVG8NCNA/vjBPUiNECv3e
 OMyr7jPgW7oTTcTk2ZTcV0t+U3UDhT4OxdfBpid4phmRHYLHO3HWo8JuMp4x2ClkfHgoR4ZnDuD
 TyLR8rS0pTUvUzufdOq4y0M5EQlZtySHU+qtfYYR0USKORsHh3JtMXItwQ0RnQKGB9+NCO48jcl
 xv3LwLhU8wv/g9TXLHGV+fK20gjHA=
X-Gm-Gg: ASbGnctRfFmGXG5iOU4uuMQjgEfPrzqFZHhXZgdFQsZE7f4XKBR5wsqq3XKsMRYgOQP
 aa8p0CL7w3kmmZNYttyZkTmOBLST1M66Tbfc8Zw==
X-Received: by 2002:a05:690c:3692:b0:6ef:75af:6155 with SMTP id
 00721157ae682-6f5312d6976mr305503647b3.32.1737045928586; 
 Thu, 16 Jan 2025 08:45:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF4VwLjtPibFImb03pmrYie4C7cd5pwo1CTbXCQB2/mz+fXEz8ytm+WD1vqeaAN4sLk/5X15rEKLXZHVyG8J/0=
X-Received: by 2002:a05:690c:3692:b0:6ef:75af:6155 with SMTP id
 00721157ae682-6f5312d6976mr305503247b3.32.1737045928214; Thu, 16 Jan 2025
 08:45:28 -0800 (PST)
MIME-Version: 1.0
References: <20250110170837.2747532-1-jonah.palmer@oracle.com>
 <20250110170837.2747532-2-jonah.palmer@oracle.com>
In-Reply-To: <20250110170837.2747532-2-jonah.palmer@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 16 Jan 2025 17:44:52 +0100
X-Gm-Features: AbW1kva-DNWwmamcQD6nkUjXO7ZN1sFOhMlhyr4eASQQuWg2grI7o_zy8diQ5Eg
Message-ID: <CAJaqyWc-ygnHZmb-aLBG9Hik3v9PbBsnFMdrxXTmGMxsMB+ZOA@mail.gmail.com>
Subject: Re: [RFC v3 1/5] vhost-vdpa: Decouple the IOVA allocator
To: Jonah Palmer <jonah.palmer@oracle.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, leiyang@redhat.com, 
 peterx@redhat.com, dtatulea@nvidia.com, jasowang@redhat.com, 
 si-wei.liu@oracle.com, boris.ostrovsky@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.093,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Jan 10, 2025 at 6:09=E2=80=AFPM Jonah Palmer <jonah.palmer@oracle.c=
om> wrote:
>
> Decouples the IOVA allocator from the full IOVA->HVA tree to support a
> SVQ IOVA->HVA tree for host-only memory mappings.
>
> The IOVA allocator still allocates an IOVA range but instead adds this
> range to an IOVA-only tree (iova_map) that keeps track of allocated IOVA
> ranges for both guest & host-only memory mappings.
>
> A new API function vhost_iova_tree_insert() is also created for adding
> IOVA->HVA mappings into the SVQ IOVA->HVA tree, since the allocator is
> no longer doing that.
>

What is the reason for not adding IOVA -> HVA tree on _alloc
automatically? The problematic one is GPA -> HVA, isn't it? Doing this
way we force all the allocations to do the two calls (alloc+insert),
or the trees will be inconsistent.

> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
> ---
>  hw/virtio/vhost-iova-tree.c | 35 +++++++++++++++++++++++++++++++----
>  hw/virtio/vhost-iova-tree.h |  1 +
>  hw/virtio/vhost-vdpa.c      | 21 ++++++++++++++++-----
>  net/vhost-vdpa.c            | 13 +++++++++++--
>  4 files changed, 59 insertions(+), 11 deletions(-)
>
> diff --git a/hw/virtio/vhost-iova-tree.c b/hw/virtio/vhost-iova-tree.c
> index 3d03395a77..b1cfd17843 100644
> --- a/hw/virtio/vhost-iova-tree.c
> +++ b/hw/virtio/vhost-iova-tree.c
> @@ -28,12 +28,15 @@ struct VhostIOVATree {
>
>      /* IOVA address to qemu memory maps. */
>      IOVATree *iova_taddr_map;
> +
> +    /* Allocated IOVA addresses */
> +    IOVATree *iova_map;
>  };
>
>  /**
> - * Create a new IOVA tree
> + * Create a new VhostIOVATree
>   *
> - * Returns the new IOVA tree
> + * Returns the new VhostIOVATree
>   */
>  VhostIOVATree *vhost_iova_tree_new(hwaddr iova_first, hwaddr iova_last)
>  {
> @@ -44,15 +47,17 @@ VhostIOVATree *vhost_iova_tree_new(hwaddr iova_first,=
 hwaddr iova_last)
>      tree->iova_last =3D iova_last;
>
>      tree->iova_taddr_map =3D iova_tree_new();
> +    tree->iova_map =3D iova_tree_new();
>      return tree;
>  }
>
>  /**
> - * Delete an iova tree
> + * Delete a VhostIOVATree

Thanks for fixing the doc of new and delete :) Maybe it is better to
put it in an independent patch?

>   */
>  void vhost_iova_tree_delete(VhostIOVATree *iova_tree)
>  {
>      iova_tree_destroy(iova_tree->iova_taddr_map);
> +    iova_tree_destroy(iova_tree->iova_map);
>      g_free(iova_tree);
>  }
>
> @@ -94,7 +99,7 @@ int vhost_iova_tree_map_alloc(VhostIOVATree *tree, DMAM=
ap *map)
>      }
>
>      /* Allocate a node in IOVA address */
> -    return iova_tree_alloc_map(tree->iova_taddr_map, map, iova_first,
> +    return iova_tree_alloc_map(tree->iova_map, map, iova_first,
>                                 tree->iova_last);
>  }
>
> @@ -107,4 +112,26 @@ int vhost_iova_tree_map_alloc(VhostIOVATree *tree, D=
MAMap *map)
>  void vhost_iova_tree_remove(VhostIOVATree *iova_tree, DMAMap map)
>  {
>      iova_tree_remove(iova_tree->iova_taddr_map, map);
> +    iova_tree_remove(iova_tree->iova_map, map);
> +}
> +
> +/**
> + * Insert a new mapping to the IOVA->HVA tree
> + *
> + * @tree: The VhostIOVATree
> + * @map: The IOVA->HVA mapping
> + *
> + * Returns:
> + * - IOVA_OK if the map fits in the container
> + * - IOVA_ERR_INVALID if the map does not make sense (e.g. size overflow=
)
> + * - IOVA_ERR_OVERLAP if the IOVA range overlaps with an existing range
> + */
> +int vhost_iova_tree_insert(VhostIOVATree *iova_tree, DMAMap *map)
> +{
> +    if (map->translated_addr + map->size < map->translated_addr ||
> +        map->perm =3D=3D IOMMU_NONE) {
> +        return IOVA_ERR_INVALID;
> +    }
> +
> +    return iova_tree_insert(iova_tree->iova_taddr_map, map);
>  }
> diff --git a/hw/virtio/vhost-iova-tree.h b/hw/virtio/vhost-iova-tree.h
> index 4adfd79ff0..8bf7b64786 100644
> --- a/hw/virtio/vhost-iova-tree.h
> +++ b/hw/virtio/vhost-iova-tree.h
> @@ -23,5 +23,6 @@ const DMAMap *vhost_iova_tree_find_iova(const VhostIOVA=
Tree *iova_tree,
>                                          const DMAMap *map);
>  int vhost_iova_tree_map_alloc(VhostIOVATree *iova_tree, DMAMap *map);
>  void vhost_iova_tree_remove(VhostIOVATree *iova_tree, DMAMap map);
> +int vhost_iova_tree_insert(VhostIOVATree *iova_tree, DMAMap *map);
>
>  #endif
> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> index 3cdaa12ed5..f5803f35f4 100644
> --- a/hw/virtio/vhost-vdpa.c
> +++ b/hw/virtio/vhost-vdpa.c
> @@ -1142,18 +1142,29 @@ static void vhost_vdpa_svq_unmap_rings(struct vho=
st_dev *dev,
>   *
>   * @v: Vhost-vdpa device
>   * @needle: The area to search iova
> + * @taddr: The translated address (SVQ HVA)
>   * @errorp: Error pointer
>   */
>  static bool vhost_vdpa_svq_map_ring(struct vhost_vdpa *v, DMAMap *needle=
,
> -                                    Error **errp)
> +                                    hwaddr taddr, Error **errp)
>  {
>      int r;
>
> +    /* Allocate an IOVA range in the IOVA tree */
>      r =3D vhost_iova_tree_map_alloc(v->shared->iova_tree, needle);
>      if (unlikely(r !=3D IOVA_OK)) {
>          error_setg(errp, "Cannot allocate iova (%d)", r);
>          return false;
>      }
> +    needle->translated_addr =3D taddr;
> +
> +    /* Add IOVA->HVA mapping to the IOVA->HVA tree */
> +    r =3D vhost_iova_tree_insert(v->shared->iova_tree, needle);
> +    if (unlikely(r !=3D IOVA_OK)) {
> +        error_setg(errp, "Cannot add SVQ vring mapping (%d)", r);
> +        vhost_iova_tree_remove(v->shared->iova_tree, *needle);
> +        return false;
> +    }
>
>      r =3D vhost_vdpa_dma_map(v->shared, v->address_space_id, needle->iov=
a,
>                             needle->size + 1,
> @@ -1192,11 +1203,11 @@ static bool vhost_vdpa_svq_map_rings(struct vhost=
_dev *dev,
>      vhost_svq_get_vring_addr(svq, &svq_addr);
>
>      driver_region =3D (DMAMap) {
> -        .translated_addr =3D svq_addr.desc_user_addr,
>          .size =3D driver_size - 1,
>          .perm =3D IOMMU_RO,
>      };
> -    ok =3D vhost_vdpa_svq_map_ring(v, &driver_region, errp);
> +    ok =3D vhost_vdpa_svq_map_ring(v, &driver_region, svq_addr.desc_user=
_addr,
> +                                 errp);
>      if (unlikely(!ok)) {
>          error_prepend(errp, "Cannot create vq driver region: ");
>          return false;
> @@ -1206,11 +1217,11 @@ static bool vhost_vdpa_svq_map_rings(struct vhost=
_dev *dev,
>      addr->avail_user_addr =3D driver_region.iova + avail_offset;
>
>      device_region =3D (DMAMap) {
> -        .translated_addr =3D svq_addr.used_user_addr,
>          .size =3D device_size - 1,
>          .perm =3D IOMMU_RW,
>      };
> -    ok =3D vhost_vdpa_svq_map_ring(v, &device_region, errp);
> +    ok =3D vhost_vdpa_svq_map_ring(v, &device_region, svq_addr.used_user=
_addr,
> +                                 errp);
>      if (unlikely(!ok)) {
>          error_prepend(errp, "Cannot create vq device region: ");
>          vhost_vdpa_svq_unmap_ring(v, driver_region.translated_addr);
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index 231b45246c..1ef555e04e 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -512,14 +512,23 @@ static int vhost_vdpa_cvq_map_buf(struct vhost_vdpa=
 *v, void *buf, size_t size,
>      DMAMap map =3D {};
>      int r;
>
> -    map.translated_addr =3D (hwaddr)(uintptr_t)buf;
>      map.size =3D size - 1;
>      map.perm =3D write ? IOMMU_RW : IOMMU_RO,
> +
> +    /* Allocate an IOVA range in the IOVA tree */
>      r =3D vhost_iova_tree_map_alloc(v->shared->iova_tree, &map);
>      if (unlikely(r !=3D IOVA_OK)) {
> -        error_report("Cannot map injected element");
> +        error_report("Cannot allocate IOVA range for injected element");
>          return r;
>      }
> +    map.translated_addr =3D (hwaddr)(uintptr_t)buf;
> +
> +    /* Add IOVA->HVA mapping to the IOVA->HVA tree */
> +    r =3D vhost_iova_tree_insert(v->shared->iova_tree, &map);
> +    if (unlikely(r !=3D IOVA_OK)) {
> +        error_report("Cannot map injected element into IOVA->HVA tree");
> +        goto dma_map_err;
> +    }
>
>      r =3D vhost_vdpa_dma_map(v->shared, v->address_space_id, map.iova,
>                             vhost_vdpa_net_cvq_cmd_page_len(), buf, !writ=
e);
> --
> 2.43.5
>


