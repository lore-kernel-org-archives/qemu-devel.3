Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 048E0D1D892
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 08:42:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vR4ul-0007rV-Oh; Thu, 04 Dec 2025 03:42:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1vR4uh-0007r6-Ec
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 03:42:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1vR4uf-0006zd-85
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 03:42:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764837727;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ebSFv4cpPYIrnEX2hQbyZFOuOEtnALedvonMr0JAueI=;
 b=aqK62+2SmB53HRFepthjZl1u4QmmSlC8M5Ttao5qMYwkGOp4SqKo5LlsHOxGiLXAJlGRaJ
 iXTdXyIxaYro65/lxK/KhCrEME1D0WMhXPpEAucELhi/jquxf8WAOzBy6Hc/CSfebsr2ID
 JWCo5eFXyAMx2JrrFd5x60MBEnUn1Ek=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-eRsiz6dWMpCQ2F-CJmScrA-1; Thu, 04 Dec 2025 03:42:05 -0500
X-MC-Unique: eRsiz6dWMpCQ2F-CJmScrA-1
X-Mimecast-MFC-AGG-ID: eRsiz6dWMpCQ2F-CJmScrA_1764837725
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-78933e02c1bso16227237b3.0
 for <qemu-devel@nongnu.org>; Thu, 04 Dec 2025 00:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764837725; x=1765442525; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ebSFv4cpPYIrnEX2hQbyZFOuOEtnALedvonMr0JAueI=;
 b=ZOR3X5nvzTQj/zn46oBWa2k9oUu7U+v3YQqUjuClH7oglyKdhvmDF3/0L8rzWg8e2E
 zAbrFyjtHcUZOvo1ri0u0c3rkIsWEE1tJ0j9zdp4YU8UwHFOXL020utufXq2i8856/Yh
 cH/EWvZ0bq76y0ZO+y6WForbsd+bYq7YwcSbu2Nj4+Bum6PFjxB+3Ykug9Tfn5nUWzpa
 xumnQDzcRCkLAN4DnW4ofl0CDqtajhz66/cUei5hcEOaGjS4I9ajXx95acCbngW3lshR
 eMs1boK3RVbkSjM4Bvo+wFInvm0ZR1Xw00AOm2uU1Jh9FjLKQSvi6DDf5EO5hNX2roFn
 ruMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764837725; x=1765442525;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ebSFv4cpPYIrnEX2hQbyZFOuOEtnALedvonMr0JAueI=;
 b=i/aCwSb8QffGRVc/y2RD+/NoRFqohCfWVN/7iwoQVCnIuJkrkesvP36oa/q7Lrwn7d
 JOt5dm2UVoUZhKqvnnIVS7krPksrSSzKsNJN8lnLn1xyJkc+BrFmW/ceZP4rp72mvd+A
 p3BD0u3iNtz7x2uUm3UMSqIBV94JRu2PMNIgrvY57BNTto5+54yVAjp8X5Of/eWOIvFc
 BJZiqPjhRL/pcUAmtb7SwYnbzqKxowhbAjbN5wlxplB0koeg9Ov7lDVPh3uF8O/MWrqm
 JSWAnKHbIDYNPNT3SM4eCEOlmPXhfJxbEImiMWgBmCd1dY0Z/QUjKmz3isfFTWPYe0Pd
 Lg8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVU43OoibdestPpk80S+ZJQa+OyIGePbm0aJaqZyh+yZg66Gbz7HDn4otsmzkjiR3mVlj364P74mfHq@nongnu.org
X-Gm-Message-State: AOJu0Yxvd8o3ZHCWy4JEDgVhHVbhWP+l+rVdikG/xx1t+mOcnU/OgIUc
 4xoN9dp5s2qENGHsq7BEiHGt2ZA8VH8XAoXbYe10qp2sFTWMoyTvt0O5svDeycNEAtiTFL71l+S
 f/RVX6dejBgyZd3/xKLrld6yh8y2RzW5+RQg5W2f+bLvupGbeTz7asEVYAapuRX7JcswWOz55s8
 HcQPf/SPsI7abVo4Cm7sz1NOPtJ47GmdU=
X-Gm-Gg: ASbGncuQanR+dzX5/2s1Yz3SDdnauebdcCSzKazct6WtBPXC50Z899qlbFDKz6DCDne
 i9/kF0GbfPTFo1pNQXaasY7fLsm/OegFLh40H1IkwxupyoVfKKRljYfcKwavCEpSYr0iRGXs0kh
 CePYf5hQGz9I1/6TZce4zn0w3wypQuclpaVvmKCVJu25ncKOMQRDYrjKbVK2ZX3fNI284=
X-Received: by 2002:a05:690c:3345:b0:787:e738:54ed with SMTP id
 00721157ae682-78c17266206mr16491967b3.30.1764837724959; 
 Thu, 04 Dec 2025 00:42:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH+bxnFpQq9+9J1ukvBeHvjHtFHLp90fdi08ibUs21R0PCIXS1niGvFP8+Y1EMIm1S7llpCZhQDqBbbSCiaj/o=
X-Received: by 2002:a05:690c:3345:b0:787:e738:54ed with SMTP id
 00721157ae682-78c17266206mr16491857b3.30.1764837724563; Thu, 04 Dec 2025
 00:42:04 -0800 (PST)
MIME-Version: 1.0
References: <20251204073750.8953-1-wafer@jaguarmicro.com>
 <20251204073750.8953-3-wafer@jaguarmicro.com>
In-Reply-To: <20251204073750.8953-3-wafer@jaguarmicro.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 4 Dec 2025 09:41:28 +0100
X-Gm-Features: AWmQ_bmwNY4ca4VP4_kY-zhtd0tsD1suc2uoM-caWiLLDefXJhcRIZ_KGC6COak
Message-ID: <CAJaqyWcZ0kO=VED5Gwyco+JfML4X_k_m28=j3AyVoFUcaz-+4Q@mail.gmail.com>
Subject: Re: [PATCH 2/4] vdpa: implement the interfaces alloc/free for
 indirect desc
To: Wafer Xie <wafer@jaguarmicro.com>
Cc: mst@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org, 
 leiyang@redhat.com, sgarzare@redhat.com, angus.chen@jaguarmicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Thu, Dec 4, 2025 at 8:39=E2=80=AFAM Wafer Xie <wafer@jaguarmicro.com> wr=
ote:
>
> Dynamic Allocation/Free indirect descriptor.
>
> Signed-off-by: Wafer Xie <wafer@jaguarmicro.com>
> ---
>  hw/virtio/vhost-shadow-virtqueue.c |   5 +-
>  hw/virtio/vhost-shadow-virtqueue.h |  49 ++++++++++-
>  hw/virtio/vhost-vdpa.c             | 130 ++++++++++++++++++++++++++++-
>  3 files changed, 180 insertions(+), 4 deletions(-)
>
> diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-=
virtqueue.c
> index 2481d49345..ecc3245138 100644
> --- a/hw/virtio/vhost-shadow-virtqueue.c
> +++ b/hw/virtio/vhost-shadow-virtqueue.c
> @@ -756,15 +756,18 @@ void vhost_svq_stop(VhostShadowVirtqueue *svq)
>   *
>   * @ops: SVQ owner callbacks
>   * @ops_opaque: ops opaque pointer
> + * @indirect_ops: Indirect descriptor operations
>   */
>  VhostShadowVirtqueue *vhost_svq_new(const VhostShadowVirtqueueOps *ops,
> -                                    void *ops_opaque)
> +                                    void *ops_opaque,
> +                                    SVQIndirectOps *indirect_ops)
>  {
>      VhostShadowVirtqueue *svq =3D g_new0(VhostShadowVirtqueue, 1);
>
>      event_notifier_init_fd(&svq->svq_kick, VHOST_FILE_UNBIND);
>      svq->ops =3D ops;
>      svq->ops_opaque =3D ops_opaque;
> +    svq->indirect_ops =3D indirect_ops;
>      return svq;
>  }
>
> diff --git a/hw/virtio/vhost-shadow-virtqueue.h b/hw/virtio/vhost-shadow-=
virtqueue.h
> index 2b36df4dd5..c5d654eae8 100644
> --- a/hw/virtio/vhost-shadow-virtqueue.h
> +++ b/hw/virtio/vhost-shadow-virtqueue.h
> @@ -54,6 +54,49 @@ typedef struct VhostShadowVirtqueueOps {
>      VirtQueueAvailCallback avail_handler;
>  } VhostShadowVirtqueueOps;
>
> +/**
> + * Callback to allocate indirect descriptor table.
> + *
> + * @svq: Shadow virtqueue
> + * @num: Number of descriptors
> + * @desc: Output pointer to allocated descriptor table
> + * @iova: Output IOVA of the allocated table
> + * @size: Output size of the allocated region
> + * @opaque: Opaque data (vhost_vdpa pointer)
> + *
> + * Returns true on success, false on failure.
> + */
> +typedef bool (*SVQIndirectDescAlloc)(VhostShadowVirtqueue *svq,
> +                                     size_t num,
> +                                     vring_desc_t **desc,
> +                                     hwaddr *iova,
> +                                     size_t *size,
> +                                     void *opaque);
> +
> +/**
> + * Callback to free indirect descriptor table.
> + *
> + * @svq: Shadow virtqueue
> + * @desc: Descriptor table to free
> + * @iova: IOVA of the table
> + * @size: Size of the allocated region
> + * @opaque: Opaque data (vhost_vdpa pointer)
> + */
> +typedef void (*SVQIndirectDescFree)(VhostShadowVirtqueue *svq,
> +                                    vring_desc_t *desc,
> +                                    hwaddr iova,
> +                                    size_t size,
> +                                    void *opaque);
> +
> +/**
> + * Indirect descriptor operations and context
> + */
> +typedef struct SVQIndirectOps {
> +    SVQIndirectDescAlloc alloc;
> +    SVQIndirectDescFree free;
> +    void *opaque;  /* Pointer to struct vhost_vdpa */
> +} SVQIndirectOps;
> +
>  /* Shadow virtqueue to relay notifications */
>  typedef struct VhostShadowVirtqueue {
>      /* Shadow vring */
> @@ -104,6 +147,9 @@ typedef struct VhostShadowVirtqueue {
>      /* Caller callbacks opaque */
>      void *ops_opaque;
>
> +    /* Indirect descriptor operations */
> +    SVQIndirectOps *indirect_ops;
> +
>      /* Next head to expose to the device */
>      uint16_t shadow_avail_idx;
>
> @@ -143,7 +189,8 @@ void vhost_svq_start(VhostShadowVirtqueue *svq, VirtI=
ODevice *vdev,
>  void vhost_svq_stop(VhostShadowVirtqueue *svq);
>
>  VhostShadowVirtqueue *vhost_svq_new(const VhostShadowVirtqueueOps *ops,
> -                                    void *ops_opaque);
> +                                    void *ops_opaque,
> +                                    SVQIndirectOps *indirect_ops);
>
>  void vhost_svq_free(gpointer vq);
>  G_DEFINE_AUTOPTR_CLEANUP_FUNC(VhostShadowVirtqueue, vhost_svq_free);
> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> index 7061b6e1a3..1719993f52 100644
> --- a/hw/virtio/vhost-vdpa.c
> +++ b/hw/virtio/vhost-vdpa.c
> @@ -584,15 +584,130 @@ static int vhost_vdpa_get_dev_features(struct vhos=
t_dev *dev,
>      return ret;
>  }
>
> +/**
> + * Allocate indirect descriptor table for SVQ
> + *
> + * @svq: Shadow virtqueue
> + * @num: Number of descriptors needed
> + * @desc: Output pointer to the allocated table
> + * @iova: Output IOVA for the table
> + * @size: Output size of the allocated region
> + * @opaque: Opaque pointer (vhost_vdpa instance)
> + *
> + * Returns true on success, false on failure.
> + */
> +static bool vhost_vdpa_svq_indirect_desc_alloc(VhostShadowVirtqueue *svq=
,
> +                                                size_t num,
> +                                                vring_desc_t **desc,
> +                                                hwaddr *iova,
> +                                                size_t *size,
> +                                                void *opaque)
> +{
> +    struct vhost_vdpa *v =3D opaque;
> +    size_t desc_size =3D sizeof(vring_desc_t) * num;
> +    size_t alloc_size =3D ROUND_UP(desc_size, qemu_real_host_page_size()=
);
> +    DMAMap needle =3D {
> +        .size =3D alloc_size - 1,
> +        .perm =3D IOMMU_RO,
> +    };
> +    vring_desc_t *indirect_desc;
> +    int r;
> +
> +    indirect_desc =3D mmap(NULL, alloc_size, PROT_READ | PROT_WRITE,
> +                         MAP_SHARED | MAP_ANONYMOUS, -1, 0);
> +    if (indirect_desc =3D=3D MAP_FAILED) {
> +        error_report("Cannot allocate indirect descriptor table");
> +        return false;
> +    }
> +
> +    r =3D vhost_iova_tree_map_alloc(v->shared->iova_tree, &needle,
> +                                  (hwaddr)(uintptr_t)indirect_desc);
> +    if (unlikely(r !=3D IOVA_OK)) {
> +        error_report("Cannot allocate iova for indirect descriptors (%d)=
", r);
> +        goto err_iova_alloc;
> +    }
> +
> +    r =3D vhost_vdpa_dma_map(v->shared, v->address_space_id, needle.iova=
,
> +                           alloc_size, indirect_desc, true);

Thanks for moving this forward! But the map and unmap operations could
be heavy in vDPA. My idea was to use a static allocated buffer for the
indirect table first, but then we need to agree on the right size of
it etc.

Can you profile the impact of it vs converting them to chained? If we
find we can improve the performance then it would be a great addition.

> +    if (unlikely(r !=3D 0)) {
> +        error_report("Cannot map indirect descriptors to device: %s (%d)=
",
> +                     g_strerror(-r), -r);
> +        goto err_dma_map;
> +    }
> +
> +    *desc =3D indirect_desc;
> +    *iova =3D needle.iova;
> +    *size =3D alloc_size;
> +    return true;
> +
> +err_dma_map:
> +    vhost_iova_tree_remove(v->shared->iova_tree, needle);
> +err_iova_alloc:
> +    munmap(indirect_desc, alloc_size);
> +    return false;
> +}
> +
> +/**
> + * Free indirect descriptor table for SVQ
> + *
> + * @svq: Shadow virtqueue
> + * @desc: Descriptor table to free
> + * @iova: IOVA of the table
> + * @size: Size of the allocated region
> + * @opaque: Opaque pointer (vhost_vdpa instance)
> + */
> +static void vhost_vdpa_svq_indirect_desc_free(VhostShadowVirtqueue *svq,
> +                                               vring_desc_t *desc,
> +                                               hwaddr iova,
> +                                               size_t size,
> +                                               void *opaque)
> +{
> +    struct vhost_vdpa *v =3D opaque;
> +    const DMAMap needle =3D {
> +        .translated_addr =3D (hwaddr)(uintptr_t)desc,
> +    };
> +    const DMAMap *result;
> +    int r;
> +
> +    /* Find the mapping in the IOVA tree by HVA */
> +    result =3D vhost_iova_tree_find_iova(v->shared->iova_tree, &needle);
> +    if (unlikely(!result)) {
> +        error_report("Cannot find indirect descriptor mapping to unmap: =
"
> +                     "iova=3D0x%" HWADDR_PRIx " hva=3D0x%" HWADDR_PRIx "=
 size=3D%zu",
> +                     iova, needle.translated_addr, size);
> +        return;
> +    }
> +
> +    r =3D vhost_vdpa_dma_unmap(v->shared, v->address_space_id, result->i=
ova,
> +                             size);
> +    if (unlikely(r !=3D 0)) {
> +        error_report("Cannot unmap indirect descriptors: "
> +                     "iova=3D0x%" HWADDR_PRIx " size=3D%zu: %s (%d)",
> +                     result->iova, size, g_strerror(-r), -r);
> +    }
> +
> +    vhost_iova_tree_remove(v->shared->iova_tree, *result);
> +
> +    munmap(desc, size);
> +}
> +
>  static void vhost_vdpa_init_svq(struct vhost_dev *hdev, struct vhost_vdp=
a *v)
>  {
>      g_autoptr(GPtrArray) shadow_vqs =3D NULL;
> +    SVQIndirectOps *indirect_ops;
> +
> +    /* Create indirect descriptor ops */
> +    indirect_ops =3D g_new0(SVQIndirectOps, 1);
> +    indirect_ops->alloc =3D vhost_vdpa_svq_indirect_desc_alloc;
> +    indirect_ops->free =3D vhost_vdpa_svq_indirect_desc_free;
> +    indirect_ops->opaque =3D v;
>
>      shadow_vqs =3D g_ptr_array_new_full(hdev->nvqs, vhost_svq_free);
>      for (unsigned n =3D 0; n < hdev->nvqs; ++n) {
>          VhostShadowVirtqueue *svq;
>
> -        svq =3D vhost_svq_new(v->shadow_vq_ops, v->shadow_vq_ops_opaque)=
;
> +        svq =3D vhost_svq_new(v->shadow_vq_ops, v->shadow_vq_ops_opaque,
> +                            indirect_ops);
>          g_ptr_array_add(shadow_vqs, svq);
>      }
>
> @@ -789,10 +904,21 @@ static void vhost_vdpa_svq_cleanup(struct vhost_dev=
 *dev)
>  {
>      struct vhost_vdpa *v =3D dev->opaque;
>      size_t idx;
> +    SVQIndirectOps *indirect_ops =3D NULL;
>
>      for (idx =3D 0; idx < v->shadow_vqs->len; ++idx) {
> -        vhost_svq_stop(g_ptr_array_index(v->shadow_vqs, idx));
> +        VhostShadowVirtqueue *svq =3D g_ptr_array_index(v->shadow_vqs, i=
dx);
> +
> +        /* Save indirect_ops pointer from first SVQ (all share the same =
one) */

Why not put it in shared them?

But I don't really get why they are callbacks. What's the issue with
if (indirect) { call to indirect functions } ?

> +        if (idx =3D=3D 0 && svq->indirect_ops) {
> +            indirect_ops =3D svq->indirect_ops;
> +        }
> +
> +        vhost_svq_stop(svq);
>      }
> +
> +    g_free(indirect_ops);
> +
>      g_ptr_array_free(v->shadow_vqs, true);
>  }
>
> --
> 2.34.1
>


