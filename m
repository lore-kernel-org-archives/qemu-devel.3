Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08544D711D6
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 08:14:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWVbn-0006Qh-5h; Fri, 19 Dec 2025 03:13:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1vWVbk-0006QP-M4
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 03:13:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1vWVbi-0005Qt-IR
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 03:13:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766131981;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6UdbwRyD5dA07jFKLxRcps0eTOPZV03Ni7XEKS4HoSw=;
 b=eewwiaaoKHuPh198QXke01U756u27eWopf0BhZAvmJv8hJVucn7ACv97E5lXxZiymGCKZY
 Z8CexDNA6Zt4OR1ogcXCkE9kWEOC8zdleMwnG7kMA1qMMAwTwaRLji8pGZe6lJEBlWxSfF
 f5xH2b42cLmDbtJf7m9sx0ty5TFWo4w=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-2xMrbouLNZaMEqMytgv3lA-1; Fri, 19 Dec 2025 03:13:00 -0500
X-MC-Unique: 2xMrbouLNZaMEqMytgv3lA-1
X-Mimecast-MFC-AGG-ID: 2xMrbouLNZaMEqMytgv3lA_1766131980
Received: by mail-yx1-f69.google.com with SMTP id
 956f58d0204a3-6465127c7fcso2448803d50.0
 for <qemu-devel@nongnu.org>; Fri, 19 Dec 2025 00:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766131980; x=1766736780; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6UdbwRyD5dA07jFKLxRcps0eTOPZV03Ni7XEKS4HoSw=;
 b=TGt0HpkW1KLrqF07l8TFi0RfgpEakBRm2Msgg1+2JwrhH6q9mxuMqfkgcKiF+OjFLH
 8JngGA4DjTy2eTZvj83yncceO6rdPUSza6H4SynK1WAFFzia2WHOH4LVdInGiIctCxAz
 HoBbFhcXYhMC2Z5d5GnmdbTA3+x054dTa82K7UePk0qSgDQLU8vK3dRCAWmr8vmKQiHG
 QShvE+l4I2owXf1wMd9j2KyfRvAkgoPN3DskmOuKoIxd4Gx7WieHkQqzdwvgEDpBs3Oe
 FEwTs+8f9ag0tPea/IrKxOQlQ8NvhW+uUpmrqSXGdIQgxgnMuY4CzelyiB3LrSWf4hdQ
 7RmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766131980; x=1766736780;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6UdbwRyD5dA07jFKLxRcps0eTOPZV03Ni7XEKS4HoSw=;
 b=o4vf1MeAP5UNaOvCkfgY6j6W7zhFa5/4b7450Tu3wHke5+K0e71zX+6X5tZ60qcSW0
 HEvQPTJNduafoMU+bY1cEe9pRw6aUJy0kB4EZPpuX7RDHTVu3gxij4PuGJ/bVM8NBomg
 W8sZmdWKoH/oVC4fuDC2kR8ON0LKx8x8QPgnNciBiUjJ6nrcr+MSkJiffcljnQmBcci2
 3axXP2OW1rHVCoMe9ybYM0DubX2AkOSm3/sPZI9oUqQH7SGqGW8S7ZTgaKzkUjXe5Cai
 xom+oDlncz+CsfQDnkNd0s2ZvQcvWvUhJdo8fSj8yxTZa45ewxbwV6DidpTuikjfmGgc
 t6cA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIzM6kFY6LZt29SNo/hbX0lUMEVMo0533BUw20w/IS1qxlXebdVNoLapbOI4L5Jbyj4CfkHGtVRkqy@nongnu.org
X-Gm-Message-State: AOJu0Yx5AqnYrMirPc+XT/RoJMZA4yAL5+aZQROGiy4HUVoLhcyoiPGA
 y3dZSIV8nTvlNoNNA+EHOIHdDhceWe45jh3alGBcwZe25hu2EhgFqDokrSGgsQCOzOqIMQfFccF
 9oAXDY/o5tOVdCpr5BXftMYlPKpxHmFd1FkTFLdd5Hej159fm7EWRetIFXxGJM6uKjMbwJXVYxM
 b1L+tKpTCkpxyJnsYXBsMPgmQA1DgVv7orfRmF+Uw=
X-Gm-Gg: AY/fxX5oYIWjL6KE4mU4gKNpHyvLz2KxX1DQPEXLFFGpL5sOC35s7b3+9ssarwzJY5V
 mCRJtfd9R1Dn3k/KT6P5qOq+q0Pa1DRCGrPUiWYKh+jRIW3jYMOzJF0QltTrT76FxZ500P+Kobs
 3BJBgj8Td1Y6T6tdEAcjNhtwCS6HcnG4auNAVXJn94Mf9XYt2RVO0xAxp3dKRSsn/H+18=
X-Received: by 2002:a05:690e:18c:b0:63f:b410:e98 with SMTP id
 956f58d0204a3-6466a856606mr1186412d50.37.1766131979809; 
 Fri, 19 Dec 2025 00:12:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEC1SIGDjhtsFIW88MJRxF5OBRFoo3zdjwTVoWgbKC0Z+0xLhqLGLotIU8YfA8qPUYfB5p3dackhsurEyuC9JU=
X-Received: by 2002:a05:690e:18c:b0:63f:b410:e98 with SMTP id
 956f58d0204a3-6466a856606mr1186403d50.37.1766131979249; Fri, 19 Dec 2025
 00:12:59 -0800 (PST)
MIME-Version: 1.0
References: <20251216015522.6540-1-wafer@jaguarmicro.com>
In-Reply-To: <20251216015522.6540-1-wafer@jaguarmicro.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 19 Dec 2025 09:12:22 +0100
X-Gm-Features: AQt7F2ryh9keLW245rFDg6r3WvFuf2pLuksiP9k-m83OwGD-iu5Qj13f77UQU1I
Message-ID: <CAJaqyWcsVpE-CoHu_1V=9vhvSkgsSqY1QBq2OWitOvVPggVqpg@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] vdpa: implement a statically allocated buffer for
 SVQ
To: Wafer Xie <wafer@jaguarmicro.com>
Cc: mst@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org, 
 leiyang@redhat.com, sgarzare@redhat.com, angus.chen@jaguarmicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, Dec 16, 2025 at 2:55=E2=80=AFAM Wafer Xie <wafer@jaguarmicro.com> w=
rote:
>
> From: wafer Xie <wafer@jaguarmicro.com>
>
> allocated and initialized when creating the vhost-vdpa device,
> and release the indirect buffer when vhost-vdpa is stopped.
>
> Signed-off-by: wafer Xie <wafer@jaguarmicro.com>
> ---
>  hw/virtio/vhost-shadow-virtqueue.c |  25 +++++
>  hw/virtio/vhost-vdpa.c             | 163 ++++++++++++++++++++++++++++-
>  2 files changed, 187 insertions(+), 1 deletion(-)
>
> diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-=
virtqueue.c
> index 2481d49345..85eff1d841 100644
> --- a/hw/virtio/vhost-shadow-virtqueue.c
> +++ b/hw/virtio/vhost-shadow-virtqueue.c
> @@ -708,6 +708,25 @@ void vhost_svq_start(VhostShadowVirtqueue *svq, Virt=
IODevice *vdev,
>      for (unsigned i =3D 0; i < svq->vring.num - 1; i++) {
>          svq->desc_next[i] =3D i + 1;
>      }
> +
> +    /* Initialize indirect descriptor state */
> +    svq->indirect_enabled =3D false;
> +    svq->current_indirect_buf =3D -1;
> +    for (int i =3D 0; i < SVQ_NUM_INDIRECT_BUFS; i++) {
> +        svq->indirect_bufs[i].desc =3D NULL;
> +        svq->indirect_bufs[i].iova =3D 0;
> +        svq->indirect_bufs[i].size =3D 0;
> +        svq->indirect_bufs[i].state =3D SVQ_INDIRECT_BUF_FREED;
> +        svq->indirect_bufs[i].num_descs =3D 0;
> +        svq->indirect_bufs[i].freed_descs =3D 0;
> +        svq->indirect_bufs[i].freeing_descs =3D 0;
> +        svq->indirect_bufs[i].freed_head =3D 0;
> +    }
> +
> +    /* Initialize desc_state indirect_buf_idx to -1 */
> +    for (unsigned i =3D 0; i < svq->vring.num; i++) {
> +        svq->desc_state[i].indirect_buf_idx =3D -1;
> +    }
>  }
>
>  /**
> @@ -748,6 +767,10 @@ void vhost_svq_stop(VhostShadowVirtqueue *svq)
>      munmap(svq->vring.desc, vhost_svq_driver_area_size(svq));
>      munmap(svq->vring.used, vhost_svq_device_area_size(svq));
>      event_notifier_set_handler(&svq->hdev_call, NULL);
> +
> +    /* Reset indirect descriptor state (memory is freed by vhost-vdpa) *=
/
> +    svq->indirect_enabled =3D false;
> +    svq->current_indirect_buf =3D -1;
>  }
>
>  /**
> @@ -765,6 +788,8 @@ VhostShadowVirtqueue *vhost_svq_new(const VhostShadow=
VirtqueueOps *ops,
>      event_notifier_init_fd(&svq->svq_kick, VHOST_FILE_UNBIND);
>      svq->ops =3D ops;
>      svq->ops_opaque =3D ops_opaque;
> +    svq->indirect_enabled =3D false;
> +    svq->current_indirect_buf =3D -1;
>      return svq;
>  }
>
> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> index 7061b6e1a3..816868d153 100644
> --- a/hw/virtio/vhost-vdpa.c
> +++ b/hw/virtio/vhost-vdpa.c
> @@ -584,6 +584,155 @@ static int vhost_vdpa_get_dev_features(struct vhost=
_dev *dev,
>      return ret;
>  }
>
> +/**
> + * Allocate a single indirect descriptor buffer for SVQ
> + *
> + * @v: vhost_vdpa instance
> + * @num_descs: Number of descriptors (should be vring.num)
> + * @buf: Output buffer structure to fill
> + *
> + * Returns true on success, false on failure.
> + */
> +static bool vhost_vdpa_alloc_indirect_buf(struct vhost_vdpa *v,
> +                                           uint16_t num_descs,
> +                                           SVQIndirectDescBuf *buf)
> +{
> +    size_t desc_size =3D sizeof(vring_desc_t) * num_descs;
> +    size_t alloc_size =3D ROUND_UP(desc_size, qemu_real_host_page_size()=
);
> +    DMAMap needle =3D {
> +        .size =3D alloc_size - 1,
> +        .perm =3D IOMMU_RO,
> +    };
> +    vring_desc_t *indirect_desc;
> +    int r;
> +
> +    /* Allocate memory for indirect descriptors */
> +    indirect_desc =3D mmap(NULL, alloc_size, PROT_READ | PROT_WRITE,
> +                         MAP_SHARED | MAP_ANONYMOUS, -1, 0);
> +    if (indirect_desc =3D=3D MAP_FAILED) {
> +        error_report("Cannot allocate indirect descriptor buffer");
> +        return false;
> +    }
> +
> +    /* Allocate IOVA for the indirect descriptor buffer */
> +    r =3D vhost_iova_tree_map_alloc(v->shared->iova_tree, &needle,
> +                                  (hwaddr)(uintptr_t)indirect_desc);
> +    if (unlikely(r !=3D IOVA_OK)) {
> +        error_report("Cannot allocate iova for indirect descriptors (%d)=
", r);
> +        munmap(indirect_desc, alloc_size);
> +        return false;
> +    }
> +
> +    /* Map to device */
> +    r =3D vhost_vdpa_dma_map(v->shared, v->address_space_id, needle.iova=
,
> +                           alloc_size, indirect_desc, true);
> +    if (unlikely(r !=3D 0)) {
> +        error_report("Cannot map indirect descriptors to device: %s (%d)=
",
> +                     g_strerror(-r), -r);
> +        vhost_iova_tree_remove(v->shared->iova_tree, needle);
> +        munmap(indirect_desc, alloc_size);
> +        return false;
> +    }
> +
> +    buf->desc =3D indirect_desc;
> +    buf->iova =3D needle.iova;
> +    buf->size =3D alloc_size;
> +    buf->state =3D SVQ_INDIRECT_BUF_FREED;
> +    buf->num_descs =3D num_descs;
> +    buf->freed_descs =3D num_descs;  /* All descriptors are free initial=
ly */
> +    buf->freeing_descs =3D 0;
> +    buf->freed_head =3D 0;
> +
> +    return true;
> +}
> +
> +/**
> + * Free a single indirect descriptor buffer
> + *
> + * @v: vhost_vdpa instance
> + * @buf: Buffer to free
> + */
> +static void vhost_vdpa_free_indirect_buf(struct vhost_vdpa *v,
> +                                          SVQIndirectDescBuf *buf)
> +{
> +    DMAMap needle;
> +    const DMAMap *result;
> +    int r;
> +
> +    if (!buf->desc) {
> +        return;
> +    }
> +
> +    needle =3D (DMAMap) {
> +        .translated_addr =3D (uint64_t)(uintptr_t)buf->desc,
> +    };
> +    result =3D vhost_iova_tree_find_iova(v->shared->iova_tree, &needle);
> +
> +    if (result) {
> +        r =3D vhost_vdpa_dma_unmap(v->shared, v->address_space_id,
> +                                 result->iova, buf->size);
> +        if (unlikely(r !=3D 0)) {
> +            error_report("Cannot unmap indirect descriptors: %s (%d)",
> +                         g_strerror(-r), -r);
> +        }
> +
> +        vhost_iova_tree_remove(v->shared->iova_tree, *result);
> +    }
> +
> +    munmap(buf->desc, buf->size);
> +    buf->desc =3D NULL;
> +    buf->iova =3D 0;
> +    buf->size =3D 0;
> +}
> +
> +/**
> + * Initialize indirect descriptor buffers for a single SVQ
> + *
> + * @v: vhost_vdpa instance
> + * @svq: Shadow virtqueue to initialize
> + *
> + * Returns true on success, false on failure.
> + */
> +static bool vhost_vdpa_svq_init_indirect(struct vhost_vdpa *v,
> +                                          VhostShadowVirtqueue *svq)
> +{
> +    if (!svq->vring.num) {
> +        return true;
> +    }
> +
> +    /* Allocate indirect descriptor buffers for this SVQ */
> +    for (int j =3D 0; j < SVQ_NUM_INDIRECT_BUFS; j++) {
> +        if (!vhost_vdpa_alloc_indirect_buf(v, svq->vring.num * 4,
> +                                           &svq->indirect_bufs[j])) {

Why not allocate a single array of size "SVQ_NUM_INDIRECT_BUFS *
svq->vring.num * 4"? It should help management and maybe even
performance as memory accesses are more predictable.

> +            /* Cleanup already allocated buffers */
> +            for (int k =3D 0; k < j; k++) {
> +                vhost_vdpa_free_indirect_buf(v, &svq->indirect_bufs[k]);
> +            }
> +            return false;
> +        }
> +    }
> +
> +    svq->indirect_enabled =3D true;
> +    svq->current_indirect_buf =3D 0;
> +    return true;
> +}
> +
> +/**
> + * Cleanup indirect descriptor buffers for a single SVQ
> + *
> + * @v: vhost_vdpa instance
> + * @svq: Shadow virtqueue to cleanup
> + */
> +static void vhost_vdpa_svq_cleanup_indirect(struct vhost_vdpa *v,
> +                                             VhostShadowVirtqueue *svq)
> +{
> +    for (int j =3D 0; j < SVQ_NUM_INDIRECT_BUFS; j++) {
> +        vhost_vdpa_free_indirect_buf(v, &svq->indirect_bufs[j]);
> +    }
> +    svq->indirect_enabled =3D false;
> +    svq->current_indirect_buf =3D -1;
> +}
> +
>  static void vhost_vdpa_init_svq(struct vhost_dev *hdev, struct vhost_vdp=
a *v)
>  {
>      g_autoptr(GPtrArray) shadow_vqs =3D NULL;
> @@ -791,8 +940,11 @@ static void vhost_vdpa_svq_cleanup(struct vhost_dev =
*dev)
>      size_t idx;
>
>      for (idx =3D 0; idx < v->shadow_vqs->len; ++idx) {
> -        vhost_svq_stop(g_ptr_array_index(v->shadow_vqs, idx));
> +        VhostShadowVirtqueue *svq =3D g_ptr_array_index(v->shadow_vqs, i=
dx);
> +        vhost_vdpa_svq_cleanup_indirect(v, svq);

All usages of vhost_vdpa_svq_cleanup_indirect go with vhost_svq_stop.
We can call vhost_vdpa_svq_cleanup_indirect from vhost_svq_stop or
even embed it.


> +        vhost_svq_stop(svq);
>      }
> +
>      g_ptr_array_free(v->shadow_vqs, true);
>  }
>
> @@ -1299,6 +1451,13 @@ static bool vhost_vdpa_svqs_start(struct vhost_dev=
 *dev)
>              error_setg_errno(&err, -r, "Cannot set device address");
>              goto err_set_addr;
>          }
> +
> +        /* Initialize indirect descriptor buffers for this SVQ */
> +        if (!vhost_vdpa_svq_init_indirect(v, svq)) {
> +            /* Non-fatal: will fallback to chain mode */
> +            warn_report("Cannot initialize indirect descriptor for SVQ %=
u",
> +                virtio_get_queue_index(vq));
> +        }
>      }
>
>      return true;
> @@ -1313,6 +1472,7 @@ err:
>      error_reportf_err(err, "Cannot setup SVQ %u: ", i);
>      for (unsigned j =3D 0; j < i; ++j) {
>          VhostShadowVirtqueue *svq =3D g_ptr_array_index(v->shadow_vqs, j=
);
> +        vhost_vdpa_svq_cleanup_indirect(v, svq);
>          vhost_vdpa_svq_unmap_rings(dev, svq);
>          vhost_svq_stop(svq);
>      }
> @@ -1331,6 +1491,7 @@ static void vhost_vdpa_svqs_stop(struct vhost_dev *=
dev)
>      for (unsigned i =3D 0; i < v->shadow_vqs->len; ++i) {
>          VhostShadowVirtqueue *svq =3D g_ptr_array_index(v->shadow_vqs, i=
);
>
> +        vhost_vdpa_svq_cleanup_indirect(v, svq);
>          vhost_svq_stop(svq);
>          vhost_vdpa_svq_unmap_rings(dev, svq);
>
> --
> 2.48.1
>


