Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE54BC02183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 19:02:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYV7R-0005sI-0Z; Thu, 16 Jan 2025 14:01:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1tYV7N-0005rO-6w
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 14:01:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1tYV7J-0006XI-7S
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 14:01:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737054078;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CyFWC/LsqenrAys/sMW6UGyseOoMCcwj4QqymCIHpIg=;
 b=R5hSdbeopTfkBYMf0OyT+DuCCGdkXgOZk3ygdvFSGUokMta1Gv05xu5bBi2mpyCqU+hMas
 mBLL9KLiOxUoFO8D1YZj+ISQ+QqiQTQavH2+eiuGW05eUQcoz969SIal8IEDgGOXCoizq2
 b694iCUVhuEaetlp1bHB98OLdyTaIoU=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-KgRiXOdVOaalcQCaBnolvA-1; Thu, 16 Jan 2025 14:01:17 -0500
X-MC-Unique: KgRiXOdVOaalcQCaBnolvA-1
X-Mimecast-MFC-AGG-ID: KgRiXOdVOaalcQCaBnolvA
Received: by mail-yb1-f197.google.com with SMTP id
 3f1490d57ef6-e573f577e13so3546153276.0
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 11:01:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737054077; x=1737658877;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CyFWC/LsqenrAys/sMW6UGyseOoMCcwj4QqymCIHpIg=;
 b=Ngsn0KrU3qfCuB6dj2rrIzndGoPMTVN9g/5A+0B0U4CbDKcD1SYmGz3X+wY/VAkIg0
 NNmnIUzRKKRFHxij956kDwbN1z1fUYO8qI3LafVGfkz3f7g8LXxw32manYxqzwO5tPAk
 dKdd2pUVF/o9DjMTfQYhP4ON//D8i5I/kqJqGznj7pTL+aHwex1FC+nNaEKhOJcT180E
 F3v9Ta+GssbLxtcQi4eGnY4qWEnKd60dMDYGk8v3UqAOqwneIU+TNEtVPos/I7hfS/I4
 efsqla9cX1Ha7dGzWLSMwQT+GSViudYo81ArfjQ1/gtp+4VEJXnMLsmsfa/+JVRhGnR5
 1ipQ==
X-Gm-Message-State: AOJu0YylMU70hpiET0HrBbl2m0h0i/2zE7HwPIuVOQ667G7l/G6pm5WB
 aKlPwTAu58e6e3ssrnP08WCH6FTheoNe6O6vTaegbrGe4TtWhsWeOaIE0cV31ucmWdWPeZQbxqk
 oxFN/nO9c7v9BwqdaJ7r+4ok+i//RIeRl4f1jRF2VqPYu1MmiUtJpjoeNX6+vHR5GFHcpARI8cj
 oEB1rDWnErP+CPt4vPAD4xEevx+Rw=
X-Gm-Gg: ASbGncuaz9+o5GrKj0bipm4mu8+PXg088U2pdyq2y0Rlvm7E3l9JNVcPB9/YuIvYFQx
 eGBDk0ZfRpaaXQ2fnfKX9nouVtyLgep5PBfB+5g==
X-Received: by 2002:a05:690c:9a8f:b0:6ef:7fc0:a378 with SMTP id
 00721157ae682-6f531203393mr279113907b3.9.1737054075478; 
 Thu, 16 Jan 2025 11:01:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG7Te/MDJMftRsTFtvq7nT3vFPdgw1dqKpqez0bwzup3bOcgOQCD1XRNsBqggmewTsmoiI1XebUAzF16wYdBNk=
X-Received: by 2002:a05:690c:9a8f:b0:6ef:7fc0:a378 with SMTP id
 00721157ae682-6f531203393mr279113227b3.9.1737054074922; Thu, 16 Jan 2025
 11:01:14 -0800 (PST)
MIME-Version: 1.0
References: <20250110170837.2747532-1-jonah.palmer@oracle.com>
 <20250110170837.2747532-4-jonah.palmer@oracle.com>
In-Reply-To: <20250110170837.2747532-4-jonah.palmer@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 16 Jan 2025 20:00:39 +0100
X-Gm-Features: AbW1kvb4oeyfGMcNINkM6SX3DcC_bCLLhjuA2mFtzpjGWe35-pWhD0GoSihmwGA
Message-ID: <CAJaqyWdv+Vh5SVGzqy08J8d0VEHYbYX8CK9YuNGZVpE85fOKKg@mail.gmail.com>
Subject: Re: [RFC v3 3/5] vhost-vdpa: Implement the GPA->IOVA tree
To: Jonah Palmer <jonah.palmer@oracle.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, leiyang@redhat.com, 
 peterx@redhat.com, dtatulea@nvidia.com, jasowang@redhat.com, 
 si-wei.liu@oracle.com, boris.ostrovsky@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.093,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.797,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Fri, Jan 10, 2025 at 6:09=E2=80=AFPM Jonah Palmer <jonah.palmer@oracle.c=
om> wrote:
>
> Implements the GPA->IOVA tree for handling mapping and unmapping for
> guest memory. This, alongside the SVQ IOVA->HVA tree & IOVA-only tree
> implemented in the previous patches, allows us to handle guest and
> host-only memory mapping operations separately via their own respective
> trees.
>
> The next patches will implement a method to determine if an incomming

s/incomming/incoming/ (credits to google syntax highlight actually :) )

> address for translation is backed by guest or host-only memory.
>
> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
> ---
>  hw/virtio/vhost-iova-tree.c | 50 +++++++++++++++++++++++++++++++++++++
>  hw/virtio/vhost-iova-tree.h |  4 +++
>  hw/virtio/vhost-vdpa.c      | 22 ++++++++++------
>  include/qemu/iova-tree.h    | 22 ++++++++++++++++
>  util/iova-tree.c            | 46 ++++++++++++++++++++++++++++++++++
>  5 files changed, 136 insertions(+), 8 deletions(-)
>
> diff --git a/hw/virtio/vhost-iova-tree.c b/hw/virtio/vhost-iova-tree.c
> index f6a5694857..540bc35660 100644
> --- a/hw/virtio/vhost-iova-tree.c
> +++ b/hw/virtio/vhost-iova-tree.c
> @@ -31,6 +31,9 @@ struct VhostIOVATree {
>
>      /* Allocated IOVA addresses */
>      IOVATree *iova_map;
> +
> +    /* GPA to IOVA address memory maps */
> +    IOVATree *gpa_iova_map;
>  };
>
>  /**
> @@ -48,6 +51,7 @@ VhostIOVATree *vhost_iova_tree_new(hwaddr iova_first, h=
waddr iova_last)
>
>      tree->iova_taddr_map =3D iova_tree_new();
>      tree->iova_map =3D iova_tree_new();
> +    tree->gpa_iova_map =3D gpa_tree_new();
>      return tree;
>  }
>
> @@ -58,6 +62,7 @@ void vhost_iova_tree_delete(VhostIOVATree *iova_tree)
>  {
>      iova_tree_destroy(iova_tree->iova_taddr_map);
>      iova_tree_destroy(iova_tree->iova_map);
> +    iova_tree_destroy(iova_tree->gpa_iova_map);
>      g_free(iova_tree);
>  }
>
> @@ -134,3 +139,48 @@ int vhost_iova_tree_insert(VhostIOVATree *iova_tree,=
 DMAMap *map)
>
>      return iova_tree_insert(iova_tree->iova_taddr_map, map);
>  }
> +
> +/** Insert a new GPA->IOVA mapping to the GPA->IOVA tree
> + *
> + * @iova_tree: The VhostIOVATree
> + * @map: The GPA->IOVA mapping
> + *
> + * Returns:
> + * - IOVA_OK if the map fits in the container
> + * - IOVA_ERR_INVALID if the map does not make sense (e.g. size overflow=
)
> + * - IOVA_ERR_OVERLAP if the GPA range overlaps with an existing range
> + */
> +int vhost_iova_tree_insert_gpa(VhostIOVATree *iova_tree, DMAMap *map)
> +{
> +    if (map->iova + map->size < map->iova || map->perm =3D=3D IOMMU_NONE=
) {
> +        return IOVA_ERR_INVALID;
> +    }
> +
> +    return gpa_tree_insert(iova_tree->gpa_iova_map, map);
> +}
> +
> +/**
> + * Find the IOVA address stored from a guest memory address (GPA)
> + *
> + * @tree: The VhostIOVATree
> + * @map: The map with the guest memory address
> + *
> + * Returns the stored GPA->IOVA mapping, or NULL if not found.
> + */
> +const DMAMap *vhost_iova_tree_find_gpa(const VhostIOVATree *tree,
> +                                       const DMAMap *map)
> +{
> +    return iova_tree_find_iova(tree->gpa_iova_map, map);
> +}
> +
> +/**
> + * Remove existing mappings from the GPA->IOVA & IOVA trees
> + *
> + * @iova_tree: The VhostIOVATree
> + * @map: The guest memory address map to remove
> + */
> +void vhost_iova_tree_remove_gpa(VhostIOVATree *iova_tree, DMAMap map)
> +{
> +    iova_tree_remove(iova_tree->gpa_iova_map, map);
> +    iova_tree_remove(iova_tree->iova_map, map);
> +}
> diff --git a/hw/virtio/vhost-iova-tree.h b/hw/virtio/vhost-iova-tree.h
> index 8bf7b64786..3e3dcd04fe 100644
> --- a/hw/virtio/vhost-iova-tree.h
> +++ b/hw/virtio/vhost-iova-tree.h
> @@ -24,5 +24,9 @@ const DMAMap *vhost_iova_tree_find_iova(const VhostIOVA=
Tree *iova_tree,
>  int vhost_iova_tree_map_alloc(VhostIOVATree *iova_tree, DMAMap *map);
>  void vhost_iova_tree_remove(VhostIOVATree *iova_tree, DMAMap map);
>  int vhost_iova_tree_insert(VhostIOVATree *iova_tree, DMAMap *map);
> +int vhost_iova_tree_insert_gpa(VhostIOVATree *iova_tree, DMAMap *map);
> +const DMAMap *vhost_iova_tree_find_gpa(const VhostIOVATree *iova_tree,
> +                                       const DMAMap *map);
> +void vhost_iova_tree_remove_gpa(VhostIOVATree *iova_tree, DMAMap map);
>
>  #endif
> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> index f5803f35f4..8587f3f6c8 100644
> --- a/hw/virtio/vhost-vdpa.c
> +++ b/hw/virtio/vhost-vdpa.c
> @@ -361,10 +361,10 @@ static void vhost_vdpa_listener_region_add(MemoryLi=
stener *listener,
>      if (s->shadow_data) {
>          int r;
>
> -        mem_region.translated_addr =3D (hwaddr)(uintptr_t)vaddr,
>          mem_region.size =3D int128_get64(llsize) - 1,
>          mem_region.perm =3D IOMMU_ACCESS_FLAG(true, section->readonly),
>
> +        /* Allocate an IOVA range in the IOVA tree */
>          r =3D vhost_iova_tree_map_alloc(s->iova_tree, &mem_region);
>          if (unlikely(r !=3D IOVA_OK)) {
>              error_report("Can't allocate a mapping (%d)", r);
> @@ -372,6 +372,14 @@ static void vhost_vdpa_listener_region_add(MemoryLis=
tener *listener,
>          }
>
>          iova =3D mem_region.iova;
> +        mem_region.translated_addr =3D section->offset_within_address_sp=
ace;
> +
> +        /* Add GPA->IOVA mapping to the GPA->IOVA tree */
> +        r =3D vhost_iova_tree_insert_gpa(s->iova_tree, &mem_region);
> +        if (unlikely(r !=3D IOVA_OK)) {
> +            error_report("Can't add listener region mapping (%d)", r);
> +            goto fail_map;
> +        }

If we want to make the two disjoint trees, we need to make the
previous commits working. I mean, either insert hva and then switch to
gpa here, or merge patches, or something similar. Otherwise, bisection
breaks.


>      }
>
>      vhost_vdpa_iotlb_batch_begin_once(s);
> @@ -386,7 +394,7 @@ static void vhost_vdpa_listener_region_add(MemoryList=
ener *listener,
>
>  fail_map:
>      if (s->shadow_data) {
> -        vhost_iova_tree_remove(s->iova_tree, mem_region);
> +        vhost_iova_tree_remove_gpa(s->iova_tree, mem_region);
>      }
>
>  fail:
> @@ -440,21 +448,19 @@ static void vhost_vdpa_listener_region_del(MemoryLi=
stener *listener,
>
>      if (s->shadow_data) {
>          const DMAMap *result;
> -        const void *vaddr =3D memory_region_get_ram_ptr(section->mr) +
> -            section->offset_within_region +
> -            (iova - section->offset_within_address_space);
>          DMAMap mem_region =3D {
> -            .translated_addr =3D (hwaddr)(uintptr_t)vaddr,
> +            .translated_addr =3D section->offset_within_address_space,
>              .size =3D int128_get64(llsize) - 1,
>          };
>
> -        result =3D vhost_iova_tree_find_iova(s->iova_tree, &mem_region);
> +        /* Search the GPA->IOVA tree */
> +        result =3D vhost_iova_tree_find_gpa(s->iova_tree, &mem_region);
>          if (!result) {
>              /* The memory listener map wasn't mapped */
>              return;
>          }
>          iova =3D result->iova;
> -        vhost_iova_tree_remove(s->iova_tree, *result);
> +        vhost_iova_tree_remove_gpa(s->iova_tree, *result);
>      }
>      vhost_vdpa_iotlb_batch_begin_once(s);
>      /*
> diff --git a/include/qemu/iova-tree.h b/include/qemu/iova-tree.h
> index 44a45931d5..8467912a0b 100644
> --- a/include/qemu/iova-tree.h
> +++ b/include/qemu/iova-tree.h
> @@ -40,6 +40,15 @@ typedef struct DMAMap {
>  } QEMU_PACKED DMAMap;
>  typedef gboolean (*iova_tree_iterator)(DMAMap *map);
>
> +/**
> + * gpa_tree_new:
> + *
> + * Create a new GPA->IOVA tree.
> + *
> + * Returns: the tree pointer on success, or NULL otherwise.
> + */
> +IOVATree *gpa_tree_new(void);
> +
>  /**
>   * iova_tree_new:
>   *
> @@ -49,6 +58,19 @@ typedef gboolean (*iova_tree_iterator)(DMAMap *map);
>   */
>  IOVATree *iova_tree_new(void);
>
> +/**
> + * gpa_tree_insert:
> + *
> + * @tree: The GPA->IOVA tree we're inserting the mapping to
> + * @map: The GPA->IOVA mapping to insert
> + *
> + * Inserts a GPA range to the GPA->IOVA tree. If there are overlapped
> + * ranges, IOVA_ERR_OVERLAP will be returned.
> + *
> + * Return: 0 if successful, < 0 otherwise.
> + */
> +int gpa_tree_insert(IOVATree *tree, const DMAMap *map);
> +
>  /**
>   * iova_tree_insert:
>   *
> diff --git a/util/iova-tree.c b/util/iova-tree.c
> index 06295e2755..f45e63c3de 100644
> --- a/util/iova-tree.c
> +++ b/util/iova-tree.c
> @@ -55,6 +55,22 @@ static void iova_tree_alloc_args_iterate(struct IOVATr=
eeAllocArgs *args,
>      args->this =3D next;
>  }
>
> +static int gpa_tree_compare(gconstpointer a, gconstpointer b, gpointer d=
ata)
> +{
> +    const DMAMap *m1 =3D a, *m2 =3D b;
> +
> +    if (m1->translated_addr > m2->translated_addr + m2->size) {
> +        return 1;
> +    }
> +
> +    if (m1->translated_addr + m1->size < m2->translated_addr) {
> +        return -1;
> +    }
> +
> +    /* Overlapped */
> +    return 0;
> +}
> +
>  static int iova_tree_compare(gconstpointer a, gconstpointer b, gpointer =
data)
>  {
>      const DMAMap *m1 =3D a, *m2 =3D b;
> @@ -71,6 +87,15 @@ static int iova_tree_compare(gconstpointer a, gconstpo=
inter b, gpointer data)
>      return 0;
>  }
>
> +IOVATree *gpa_tree_new(void)
> +{
> +    IOVATree *gpa_tree =3D g_new0(IOVATree, 1);
> +
> +    gpa_tree->tree =3D g_tree_new_full(gpa_tree_compare, NULL, g_free, N=
ULL);
> +
> +    return gpa_tree;
> +}
> +
>  IOVATree *iova_tree_new(void)
>  {
>      IOVATree *iova_tree =3D g_new0(IOVATree, 1);
> @@ -121,6 +146,27 @@ static inline void iova_tree_insert_internal(GTree *=
gtree, DMAMap *range)
>      g_tree_insert(gtree, range, range);
>  }
>
> +int gpa_tree_insert(IOVATree *tree, const DMAMap *map)
> +{
> +    DMAMap *new;
> +
> +    if (map->translated_addr + map->size < map->translated_addr ||
> +        map->perm =3D=3D IOMMU_NONE) {
> +        return IOVA_ERR_INVALID;
> +    }
> +
> +    /* We don't allow inserting ranges that overlap with existing ones *=
/
> +    if (iova_tree_find(tree,map)) {
> +        return IOVA_ERR_OVERLAP;
> +    }
> +
> +    new =3D g_new0(DMAMap, 1);
> +    memcpy(new, map, sizeof(*new));
> +    iova_tree_insert_internal(tree->tree, new);
> +
> +    return IOVA_OK;
> +}
> +

I'm missing the advantage of using all of these functions, why not use
another iova_tree_new and iova_tree_insert? gpa_tree_compare seems
like a 1:1 copy of iova_tree_compare to me. Same with _insert.

>  int iova_tree_insert(IOVATree *tree, const DMAMap *map)
>  {
>      DMAMap *new;
> --
> 2.43.5
>


