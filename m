Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1C1EC36008
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 12:06:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txPWP-000167-8v; Wed, 26 Mar 2025 08:06:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1txPWG-00014S-Fd
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 08:06:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1txPWB-00039h-2P
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 08:06:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742990751;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AY+SKPVr6lX1bdm0CMvOGnJv/pc4UnWkylPUQt9SGxo=;
 b=euolEdeyrqdY3s2ZNmiWfjC3E3O7flL+TJkBdbZt+4HxU600FIhABM40xkWY7+ITh/3DYT
 OthTlENSWbiinklngIgOU3zI+V1PLp4cbRX9XVF6fLWmKXypvGVNJmmPwRwktA+8ggDnj/
 5vgDKOzTfLtD2g6WS6Me8Z3ArkBrs0Q=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-308-o4boSoLXPAaWbWO_do9lDA-1; Wed, 26 Mar 2025 08:05:48 -0400
X-MC-Unique: o4boSoLXPAaWbWO_do9lDA-1
X-Mimecast-MFC-AGG-ID: o4boSoLXPAaWbWO_do9lDA_1742990747
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-22410053005so177309945ad.1
 for <qemu-devel@nongnu.org>; Wed, 26 Mar 2025 05:05:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742990747; x=1743595547;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AY+SKPVr6lX1bdm0CMvOGnJv/pc4UnWkylPUQt9SGxo=;
 b=T7pz92q0omAbm/azKX+WeDuyCUsFkMTsfXUsJWV4FRm6AZ0BoYp3TDcFT/hb2OdrIL
 gq9Iocp1umR5jU6u5ruczIwUKeKybEMJND915KnBtee+mjlXBbB2jkrRM1WsgiYm9/fx
 McFjDfSWYDGGRBJGs8JfA/HhF5rssg7b4JwfS6smY/nroLjwPfW8xy29SZl+fLbbNIgS
 Czr70FNWgjewb7jDaw9nCAxOI35l+KWe5Z6pyv2GPxlNJ7dza8ZycG2MLZRJYA6wI94N
 d3XaV7SjPK8xdU7SE3eiLCa2DNzO8aJADIQI1ScBE83EipZH536Y1khBSq2DpsyGhxuL
 HqCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWX8UfIH+zwLZRAHBclqWMzeiZ51uT2ZoZ+3HXjkaDm/yLYMWriLrHVIFp2qmYq/CLQvvHG9jRqB2Oz@nongnu.org
X-Gm-Message-State: AOJu0YziPCKPxYAQTDGwvTdjceppZUUYbEB8AqA/QdeG1rBuIlqMuGbE
 6ouFQBkEOVws86gBA7cbGKSPvMwEN2ih5R85d382+S/qdzLmfqQRor/ZIryYUPhApIv38s7smUi
 U1Mf053o713MpBf3Hwiwqo+ftgDQs71BJguGKa/bvb3kXh5VTcCeS01QpwY7C25329JPYQ2x1bG
 P8C8O+I26fFZaLxV5eJ2D+VaJoCdo=
X-Gm-Gg: ASbGncv16USqVrvIxR6wLGFkNSUjGnOq67lnr9+B7fVvErQRhFhcNF4mliMUlxWlP9E
 ArYjdQcLg68UO2Dc5ozFPmlPsTb/30qHqFYQizXfuRonFreBMltLJXeofk4YqWybovULTiIE=
X-Received: by 2002:a17:902:fc45:b0:21d:dfae:300c with SMTP id
 d9443c01a7336-22780c546a8mr318912505ad.3.1742990746427; 
 Wed, 26 Mar 2025 05:05:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHUhp48C+6rmnlEEgIdhdF2x3pTBojiCfvxG9yoAD2SSEE91XSAEzhgmeRqI5ilyYpSgmEP15u02gMEz5X69s=
X-Received: by 2002:a17:902:fc45:b0:21d:dfae:300c with SMTP id
 d9443c01a7336-22780c546a8mr318912135ad.3.1742990745989; Wed, 26 Mar 2025
 05:05:45 -0700 (PDT)
MIME-Version: 1.0
References: <20250324135929.74945-1-sahilcdq@proton.me>
 <20250324135929.74945-5-sahilcdq@proton.me>
In-Reply-To: <20250324135929.74945-5-sahilcdq@proton.me>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 26 Mar 2025 13:05:09 +0100
X-Gm-Features: AQ5f1JoPTggSaHqEGPKQ1gpGJxu-dMvE6VA0RbNpjP5QLCM0D2YyVZmJyMbaOdI
Message-ID: <CAJaqyWfcK3dtRXCqT5xrgd7L37qLgHQVf6zMvN3_DN8VeyUHNg@mail.gmail.com>
Subject: Re: [RFC v5 4/7] vdpa: Allocate memory for SVQ and map them to vdpa
To: Sahil Siddiq <icegambit91@gmail.com>
Cc: sgarzare@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, 
 sahilcdq@proton.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Mon, Mar 24, 2025 at 3:00=E2=80=AFPM Sahil Siddiq <icegambit91@gmail.com=
> wrote:
>
> Allocate memory for the packed vq format and map them to the vdpa device.
>
> Since "struct vring" and "struct vring_packed's vring" both have the same
> memory layout, the implementation in SVQ start and SVQ stop should not
> differ based on the vq's format.
>
> Also initialize flags, counters and indices for packed vqs before they
> are utilized.
>
> Signed-off-by: Sahil Siddiq <sahilcdq@proton.me>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> ---
> Changes from v4 -> v5:
> - vhost-shadow-virtqueue.c:
>   (vhost_svq_start): Initialize variables used by packed vring.
>
>  hw/virtio/vhost-shadow-virtqueue.c | 52 +++++++++++++++++++++---------
>  hw/virtio/vhost-shadow-virtqueue.h |  1 +
>  hw/virtio/vhost-vdpa.c             | 37 +++++++++++++++++----
>  3 files changed, 69 insertions(+), 21 deletions(-)
>
> diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-=
virtqueue.c
> index 6e16cd4bdf..126957231d 100644
> --- a/hw/virtio/vhost-shadow-virtqueue.c
> +++ b/hw/virtio/vhost-shadow-virtqueue.c
> @@ -707,19 +707,33 @@ void vhost_svq_get_vring_addr(const VhostShadowVirt=
queue *svq,
>      addr->used_user_addr =3D (uint64_t)(uintptr_t)svq->vring.used;
>  }
>
> -size_t vhost_svq_driver_area_size(const VhostShadowVirtqueue *svq)
> +size_t vhost_svq_descriptor_area_size(const VhostShadowVirtqueue *svq)
>  {
>      size_t desc_size =3D sizeof(vring_desc_t) * svq->vring.num;
> -    size_t avail_size =3D offsetof(vring_avail_t, ring[svq->vring.num]) =
+
> -                                                              sizeof(uin=
t16_t);
> +    return ROUND_UP(desc_size, qemu_real_host_page_size());
> +}
>
> -    return ROUND_UP(desc_size + avail_size, qemu_real_host_page_size());
> +size_t vhost_svq_driver_area_size(const VhostShadowVirtqueue *svq)
> +{
> +    size_t avail_size;
> +    if (svq->is_packed) {
> +        avail_size =3D sizeof(uint32_t);
> +    } else {
> +        avail_size =3D offsetof(vring_avail_t, ring[svq->vring.num]) +
> +                                                             sizeof(uint=
16_t);
> +    }
> +    return ROUND_UP(avail_size, qemu_real_host_page_size());
>  }
>
>  size_t vhost_svq_device_area_size(const VhostShadowVirtqueue *svq)
>  {
> -    size_t used_size =3D offsetof(vring_used_t, ring[svq->vring.num]) +
> -                                                              sizeof(uin=
t16_t);
> +    size_t used_size;
> +    if (svq->is_packed) {
> +        used_size =3D sizeof(uint32_t);
> +    } else {
> +        used_size =3D offsetof(vring_used_t, ring[svq->vring.num]) +
> +                                                           sizeof(uint16=
_t);
> +    }
>      return ROUND_UP(used_size, qemu_real_host_page_size());
>  }
>
> @@ -764,8 +778,6 @@ void vhost_svq_set_svq_kick_fd(VhostShadowVirtqueue *=
svq, int svq_kick_fd)
>  void vhost_svq_start(VhostShadowVirtqueue *svq, VirtIODevice *vdev,
>                       VirtQueue *vq, VhostIOVATree *iova_tree)
>  {
> -    size_t desc_size;
> -
>      event_notifier_set_handler(&svq->hdev_call, vhost_svq_handle_call);
>      svq->next_guest_avail_elem =3D NULL;
>      svq->shadow_avail_idx =3D 0;
> @@ -774,20 +786,29 @@ void vhost_svq_start(VhostShadowVirtqueue *svq, Vir=
tIODevice *vdev,
>      svq->vdev =3D vdev;
>      svq->vq =3D vq;
>      svq->iova_tree =3D iova_tree;
> +    svq->is_packed =3D virtio_vdev_has_feature(svq->vdev, VIRTIO_F_RING_=
PACKED);
> +
> +    if (svq->is_packed) {
> +        svq->vring_packed.avail_wrap_counter =3D 1;
> +        svq->vring_packed.next_avail_idx =3D 0;
> +        svq->vring_packed.avail_used_flags =3D 1 << VRING_PACKED_DESC_F_=
AVAIL;
> +        svq->last_used_idx =3D 0 | (1 << VRING_PACKED_EVENT_F_WRAP_CTR);
> +    }
>
>      svq->vring.num =3D virtio_queue_get_num(vdev, virtio_get_queue_index=
(vq));
>      svq->num_free =3D svq->vring.num;
> -    svq->vring.desc =3D mmap(NULL, vhost_svq_driver_area_size(svq),
> +    svq->vring.desc =3D mmap(NULL, vhost_svq_descriptor_area_size(svq),
>                             PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANON=
YMOUS,
>                             -1, 0);
> -    desc_size =3D sizeof(vring_desc_t) * svq->vring.num;
> -    svq->vring.avail =3D (void *)((char *)svq->vring.desc + desc_size);
> +    svq->vring.avail =3D mmap(NULL, vhost_svq_driver_area_size(svq),
> +                            PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANO=
NYMOUS,
> +                            -1, 0);
>      svq->vring.used =3D mmap(NULL, vhost_svq_device_area_size(svq),
>                             PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANON=
YMOUS,
>                             -1, 0);
> -    svq->desc_state =3D g_new0(SVQDescState, svq->vring.num);
> -    svq->desc_next =3D g_new0(uint16_t, svq->vring.num);
> -    for (unsigned i =3D 0; i < svq->vring.num - 1; i++) {
> +    svq->desc_state =3D g_new0(SVQDescState, svq->num_free);
> +    svq->desc_next =3D g_new0(uint16_t, svq->num_free);
> +    for (unsigned i =3D 0; i < svq->num_free - 1; i++) {
>          svq->desc_next[i] =3D i + 1;
>      }
>  }
> @@ -827,7 +848,8 @@ void vhost_svq_stop(VhostShadowVirtqueue *svq)
>      svq->vq =3D NULL;
>      g_free(svq->desc_next);
>      g_free(svq->desc_state);
> -    munmap(svq->vring.desc, vhost_svq_driver_area_size(svq));
> +    munmap(svq->vring.desc, vhost_svq_descriptor_area_size(svq));
> +    munmap(svq->vring.avail, vhost_svq_driver_area_size(svq));
>      munmap(svq->vring.used, vhost_svq_device_area_size(svq));
>      event_notifier_set_handler(&svq->hdev_call, NULL);
>  }
> diff --git a/hw/virtio/vhost-shadow-virtqueue.h b/hw/virtio/vhost-shadow-=
virtqueue.h
> index 5f7699da9d..12c6ea8be2 100644
> --- a/hw/virtio/vhost-shadow-virtqueue.h
> +++ b/hw/virtio/vhost-shadow-virtqueue.h
> @@ -152,6 +152,7 @@ void vhost_svq_set_svq_kick_fd(VhostShadowVirtqueue *=
svq, int svq_kick_fd);
>  void vhost_svq_set_svq_call_fd(VhostShadowVirtqueue *svq, int call_fd);
>  void vhost_svq_get_vring_addr(const VhostShadowVirtqueue *svq,
>                                struct vhost_vring_addr *addr);
> +size_t vhost_svq_descriptor_area_size(const VhostShadowVirtqueue *svq);
>  size_t vhost_svq_driver_area_size(const VhostShadowVirtqueue *svq);
>  size_t vhost_svq_device_area_size(const VhostShadowVirtqueue *svq);
>
> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> index 7efbde3d4c..58c8931d89 100644
> --- a/hw/virtio/vhost-vdpa.c
> +++ b/hw/virtio/vhost-vdpa.c
> @@ -1137,6 +1137,8 @@ static void vhost_vdpa_svq_unmap_rings(struct vhost=
_dev *dev,
>
>      vhost_vdpa_svq_unmap_ring(v, svq_addr.desc_user_addr);
>
> +    vhost_vdpa_svq_unmap_ring(v, svq_addr.avail_user_addr);
> +
>      vhost_vdpa_svq_unmap_ring(v, svq_addr.used_user_addr);
>  }
>
> @@ -1191,38 +1193,61 @@ static bool vhost_vdpa_svq_map_rings(struct vhost=
_dev *dev,
>                                       Error **errp)
>  {
>      ERRP_GUARD();
> -    DMAMap device_region, driver_region;
> +    DMAMap descriptor_region, device_region, driver_region;
>      struct vhost_vring_addr svq_addr;
>      struct vhost_vdpa *v =3D dev->opaque;
> +    size_t descriptor_size =3D vhost_svq_descriptor_area_size(svq);
>      size_t device_size =3D vhost_svq_device_area_size(svq);
>      size_t driver_size =3D vhost_svq_driver_area_size(svq);
> -    size_t avail_offset;
>      bool ok;
>
>      vhost_svq_get_vring_addr(svq, &svq_addr);
>
> +    descriptor_region =3D (DMAMap) {
> +        .translated_addr =3D svq_addr.desc_user_addr,
> +        .size =3D descriptor_size - 1,
> +        .perm =3D IOMMU_RO,
> +    };
> +    if (svq->is_packed) {
> +        descriptor_region.perm =3D IOMMU_RW;
> +    }
> +
> +    ok =3D vhost_vdpa_svq_map_ring(v, &descriptor_region, svq_addr.desc_=
user_addr,
> +                                 errp);
> +    if (unlikely(!ok)) {
> +        error_prepend(errp, "Cannot create vq descriptor region: ");
> +        return false;
> +    }
> +    addr->desc_user_addr =3D descriptor_region.iova;
> +
>      driver_region =3D (DMAMap) {
> +        .translated_addr =3D svq_addr.avail_user_addr,
>          .size =3D driver_size - 1,
>          .perm =3D IOMMU_RO,
>      };
> -    ok =3D vhost_vdpa_svq_map_ring(v, &driver_region, svq_addr.desc_user=
_addr,
> +    ok =3D vhost_vdpa_svq_map_ring(v, &driver_region, svq_addr.avail_use=
r_addr,
>                                   errp);
>      if (unlikely(!ok)) {
>          error_prepend(errp, "Cannot create vq driver region: ");
> +        vhost_vdpa_svq_unmap_ring(v, descriptor_region.translated_addr);
>          return false;
>      }
> -    addr->desc_user_addr =3D driver_region.iova;
> -    avail_offset =3D svq_addr.avail_user_addr - svq_addr.desc_user_addr;
> -    addr->avail_user_addr =3D driver_region.iova + avail_offset;
> +    addr->avail_user_addr =3D driver_region.iova;
>
>      device_region =3D (DMAMap) {
> +        .translated_addr =3D svq_addr.used_user_addr,
>          .size =3D device_size - 1,
>          .perm =3D IOMMU_RW,
>      };
> +    if (svq->is_packed) {
> +        device_region.perm =3D IOMMU_WO;
> +    }
> +
>      ok =3D vhost_vdpa_svq_map_ring(v, &device_region, svq_addr.used_user=
_addr,
>                                   errp);
>      if (unlikely(!ok)) {
>          error_prepend(errp, "Cannot create vq device region: ");
> +        vhost_vdpa_svq_unmap_ring(v, descriptor_region.translated_addr);
>          vhost_vdpa_svq_unmap_ring(v, driver_region.translated_addr);
>      }
>      addr->used_user_addr =3D device_region.iova;
> --
> 2.48.1
>


