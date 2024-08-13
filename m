Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EEF7C52D7C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 06:55:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdlQc-000533-2G; Tue, 13 Aug 2024 02:54:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1sdlQX-00052I-AB
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 02:54:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1sdlQU-0000NS-Kk
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 02:54:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723532075;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mVpQOykrEyQsVoxZYpmEOv09WcloxDJSgsVuEsnQXQw=;
 b=TeJd0th+192x1Iqub14whczlzba/NDmhEP6CpNFOPY0/2VA8OVc45T604NBTfb94kGY0Lf
 rcAA6+txroOdWwLAg3xV0Bhl6+FGvjOwvq5ujvPl7NnaYYu8QsDTtvl54PeHjrIDAEud9h
 QYErmkpZpT30o82GFQ4SR0WMroUUxRo=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-tMVY1xQ_NI2Lo8KlJIMFrQ-1; Tue, 13 Aug 2024 02:54:32 -0400
X-MC-Unique: tMVY1xQ_NI2Lo8KlJIMFrQ-1
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-66628e9ec89so110535817b3.1
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2024 23:54:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723532072; x=1724136872;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mVpQOykrEyQsVoxZYpmEOv09WcloxDJSgsVuEsnQXQw=;
 b=th/UAu4P1h6S6JGooYb8/v0DI9Pe99vXXQsAxaLXCmDfb+0fZaT84C1/QAe20UlQJG
 PUq0Xk7znSBzh229EdwkyVGT5XJ9rAIQRiFqJJQHYmfNKCDsuLqJTDOkVfRmI7HA8jBT
 fT57VLCJtOEew9pLUqNpyg6S5Fog6QtmgJ+LxNRCYJCdQILW9vdTcCtvkxWApZIVImoT
 ugoxih97WCDMYOSuc98W2TQJfcINPH3lvdCLLujV+C4HUhXHSdTibLFgaGBIPgsCu6Uw
 XkzIMnpfdZpzrE1nj7smU81klhVKC72EYjS13c+pLp0cj+7b08cU2xT+ZPQ08PFjFhot
 uH2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6aYZzq8tP0iA/V5ykrxt8KZCXu5CEDaMX9avDOtm8G+5MkW4N1ZgqhkZOQRxK3f+7Fkq+OZGCcE6uBT+pjwZa/VHksLU=
X-Gm-Message-State: AOJu0YzsTjPF7bUa8+GZAJ2zLSfqvHr5Ofh3yRBGk+bDfqlnNeZ7bX32
 6qk+Fq5I+nQnwbtqoGEzejLqIoObkd3qshah9DNsLLPPjCSLc63M80qeMTxlLfqBQ3HvN0LyeG+
 +rY9WmWMkUfziUZnGIPuPT8/pbxGdCShcZgw168zxUhRO337WF2c5DYfvy3sjmAIqP+hnv5p45E
 JY0veIapoGsGBfsrqNPnbqRNyVVaA=
X-Received: by 2002:a05:690c:2b0a:b0:65f:dfd9:b672 with SMTP id
 00721157ae682-6a97238e59emr26628077b3.11.1723532072339; 
 Mon, 12 Aug 2024 23:54:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8RIfuywcAlrBq+lOAvqWim6ElUvwUGPk0YYLRCN/LlSAkbpcSqySCTsC+qbvN8zRDu22XktlwtKRFMz+RCLs=
X-Received: by 2002:a05:690c:2b0a:b0:65f:dfd9:b672 with SMTP id
 00721157ae682-6a97238e59emr26627927b3.11.1723532072018; Mon, 12 Aug 2024
 23:54:32 -0700 (PDT)
MIME-Version: 1.0
References: <20240802112138.46831-1-sahilcdq@proton.me>
 <20240802112138.46831-4-sahilcdq@proton.me>
 <CAJaqyWcrcEJimGqF3_K7YWCobPw00Yx+rcYQH1JXGcKesb5M2w@mail.gmail.com>
 <8454459.NyiUUSuA9g@valdaarhun>
In-Reply-To: <8454459.NyiUUSuA9g@valdaarhun>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 13 Aug 2024 08:53:55 +0200
Message-ID: <CAJaqyWf3Vv6LvCHvRtpdZFQrhVHMOUTdzhJGj7PkbVDYeKox_w@mail.gmail.com>
Subject: Re: [RFC v3 3/3] vhost: Allocate memory for packed vring
To: Sahil <icegambit91@gmail.com>
Cc: sgarzare@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, 
 Sahil Siddiq <sahilcdq@proton.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Aug 12, 2024 at 9:32=E2=80=AFPM Sahil <icegambit91@gmail.com> wrote=
:
>
> Hi,
>
> On Monday, August 12, 2024 12:01:00=E2=80=AFPM GMT+5:30 you wrote:
> > On Sun, Aug 11, 2024 at 7:20=E2=80=AFPM Sahil <icegambit91@gmail.com> w=
rote:
> > > On Wednesday, August 7, 2024 9:52:10=E2=80=AFPM GMT+5:30 Eugenio Pere=
z Martin wrote:
> > > > On Fri, Aug 2, 2024 at 1:22=E2=80=AFPM Sahil Siddiq <icegambit91@gm=
ail.com> wrote:
> > > > > [...]
> > > > > @@ -726,17 +738,30 @@ void vhost_svq_start(VhostShadowVirtqueue *=
svq, VirtIODevice *vdev,
> > > > >      svq->vring.num =3D virtio_queue_get_num(vdev,
> > > > >      virtio_get_queue_index(vq));
> > > > >      svq->num_free =3D svq->vring.num;
> > > > >
> > > > > -    svq->vring.desc =3D mmap(NULL, vhost_svq_driver_area_size(sv=
q),
> > > > > -                           PROT_READ | PROT_WRITE, MAP_SHARED | =
MAP_ANONYMOUS,
> > > > > -                           -1, 0);
> > > > > -    desc_size =3D sizeof(vring_desc_t) * svq->vring.num;
> > > > > -    svq->vring.avail =3D (void *)((char *)svq->vring.desc + desc=
_size);
> > > > > -    svq->vring.used =3D mmap(NULL, vhost_svq_device_area_size(sv=
q),
> > > > > -                           PROT_READ | PROT_WRITE, MAP_SHARED | =
MAP_ANONYMOUS,
> > > > > -                           -1, 0);
> > > > > -    svq->desc_state =3D g_new0(SVQDescState, svq->vring.num);
> > > > > -    svq->desc_next =3D g_new0(uint16_t, svq->vring.num);
> > > > > -    for (unsigned i =3D 0; i < svq->vring.num - 1; i++) {
> > > > > +    svq->is_packed =3D virtio_vdev_has_feature(svq->vdev, VIRTIO=
_F_RING_PACKED);
> > > > > +
> > > > > +    if (virtio_vdev_has_feature(svq->vdev, VIRTIO_F_RING_PACKED)=
) {
> > > > > +        svq->vring_packed.vring.desc =3D mmap(NULL, vhost_svq_me=
mory_packed(svq),
> > > > > +                                          PROT_READ | PROT_WRITE=
, MAP_SHARED | MAP_ANONYMOUS,
> > > > > +                                          -1, 0);
> > > > > +        desc_size =3D sizeof(struct vring_packed_desc) * svq->vr=
ing.num;
> > > > > +        svq->vring_packed.vring.driver =3D (void *)((char *)svq-=
>vring_packed.vring.desc + desc_size);
> > > > > +        svq->vring_packed.vring.device =3D (void *)((char *)svq-=
>vring_packed.vring.driver +
> > > > > +                                     sizeof(struct vring_packed_=
desc_event));
> > > >
> > > > This is a great start but it will be problematic when you start
> > > > mapping the areas to the vdpa device. The driver area should be rea=
d
> > > > only for the device, but it is placed in the same page as a RW one.
> > > >
> > > > More on this later.
> > > >
> > > > > +    } else {
> > > > > +        svq->vring.desc =3D mmap(NULL, vhost_svq_driver_area_siz=
e(svq),
> > > > > +                               PROT_READ | PROT_WRITE, MAP_SHARE=
D |MAP_ANONYMOUS,
> > > > > +                               -1, 0);
> > > > > +        desc_size =3D sizeof(vring_desc_t) * svq->vring.num;
> > > > > +        svq->vring.avail =3D (void *)((char *)svq->vring.desc + =
desc_size);
> > > > > +        svq->vring.used =3D mmap(NULL, vhost_svq_device_area_siz=
e(svq),
> > > > > +                               PROT_READ | PROT_WRITE, MAP_SHARE=
D |MAP_ANONYMOUS,
> > > > > +                               -1, 0);
> > > > > +    }
> > > >
> > > > I think it will be beneficial to avoid "if (packed)" conditionals o=
n
> > > > the exposed functions that give information about the memory maps.
> > > > These need to be replicated at
> > > > hw/virtio/vhost-vdpa.c:vhost_vdpa_svq_map_rings.
> > > >
> > > > However, the current one depends on the driver area to live in the
> > > > same page as the descriptor area, so it is not suitable for this.
> > >
> > > I haven't really understood this.
> > >
> > > In split vqs the descriptor, driver and device areas are mapped to RW=
 pages.
> > > In vhost_vdpa.c:vhost_vdpa_svq_map_rings, the regions are mapped with
> > > the appropriate "perm" field that sets the R/W permissions in the DMA=
Map
> > > object. Is this problematic for the split vq format because the avail=
 ring is
> > > anyway mapped to a RW page in "vhost_svq_start"?
> > >
> >
> > Ok so maybe the map word is misleading here. The pages needs to be
> > allocated for the QEMU process with both PROT_READ | PROT_WRITE, as
> > QEMU needs to write into it.
> >
> > They are mapped to the device with vhost_vdpa_dma_map, and the last
> > bool parameter indicates if the device needs write permissions or not.
> > You can see how hw/virtio/vhost-vdpa.c:vhost_vdpa_svq_map_ring checks
> > the needle permission for this, and the needle permissions are stored
> > at hw/virtio/vhost-vdpa.c:vhost_vdpa_svq_map_rings. This is the
> > function that needs to check for the maps permissions.
> >
>
> I think I have understood what's going on in "vhost_vdpa_svq_map_rings",
> "vhost_vdpa_svq_map_ring" and "vhost_vdpa_dma_map". But based on
> what I have understood it looks like the driver area is getting mapped to
> an iova which is read-only for vhost_vdpa. Please let me know where I am
> going wrong.
>

You're not going wrong there. The device does not need to write into
this area, so we map it read only.

> Consider the following implementation in hw/virtio/vhost_vdpa.c:
>
> > size_t device_size =3D vhost_svq_device_area_size(svq);
> > size_t driver_size =3D vhost_svq_driver_area_size(svq);
>
> The driver size includes the descriptor area and the driver area. For
> packed vq, the driver area is the "driver event suppression" structure
> which should be read-only for the device according to the virtio spec
> (section 2.8.10) [1].
>
> > size_t avail_offset;
> > bool ok;
> >
> > vhost_svq_get_vring_addr(svq, &svq_addr);
>
> Over here "svq_addr.desc_user_addr" will point to the descriptor area
> while "svq_addr.avail_user_addr" will point to the driver area/driver
> event suppression structure.
>
> > driver_region =3D (DMAMap) {
> >     .translated_addr =3D svq_addr.desc_user_addr,
> >     .size =3D driver_size - 1,
> >     .perm =3D IOMMU_RO,
> > };
>
> This region points to the descriptor area and its size encompasses the
> driver area as well with RO permission.
>
> > ok =3D vhost_vdpa_svq_map_ring(v, &driver_region, errp);
>
> The above function checks the value of needle->perm and sees that it is R=
O.
> It then calls "vhost_vdpa_dma_map" with the following arguments:
>
> > r =3D vhost_vdpa_dma_map(v->shared, v->address_space_id, needle->iova,
> >                                                needle->size + 1,
> >                                                (void *)(uintptr_t)needl=
e->translated_addr,
> >                                                needle->perm =3D=3D IOMM=
U_RO);
>
> Since needle->size includes the driver area as well, the driver area will=
 be
> mapped to a RO page in the device's address space, right?
>

Yes, the device does not need to write into the descriptor area in the
supported split virtqueue case. So the descriptor area is also mapped
RO at this moment.

This change in the packed virtqueue case, so we need to map it RW.

> > if (unlikely(!ok)) {
> >     error_prepend(errp, "Cannot create vq driver region: ");
> >     return false;
> > }
> > addr->desc_user_addr =3D driver_region.iova;
> > avail_offset =3D svq_addr.avail_user_addr - svq_addr.desc_user_addr;
> > addr->avail_user_addr =3D driver_region.iova + avail_offset;
>
> I think "addr->desc_user_addr" and "addr->avail_user_addr" will both be
> mapped to a RO page in the device's address space.
>
> > device_region =3D (DMAMap) {
> >     .translated_addr =3D svq_addr.used_user_addr,
> >     .size =3D device_size - 1,
> >     .perm =3D IOMMU_RW,
> > };
>
> The device area/device event suppression structure on the other hand will
> be mapped to a RW page.
>
> I also think there are other issues with the current state of the patch. =
According
> to the virtio spec (section 2.8.10) [1], the "device event suppression" s=
tructure
> needs to be write-only for the device but is mapped to a RW page.
>

Yes, I'm not sure if all IOMMU supports write-only maps to be honest.

> Another concern I have is regarding the driver area size for packed vq. I=
n
> "hw/virtio/vhost-shadow-virtqueue.c" of the current patch:
> > size_t vhost_svq_driver_area_size(const VhostShadowVirtqueue *svq)
> > {
> >     size_t desc_size =3D sizeof(vring_desc_t) * svq->vring.num;
> >     size_t avail_size =3D offsetof(vring_avail_t, ring[svq->vring.num])=
 +
> >                                                               sizeof(ui=
nt16_t);
> >
> >     return ROUND_UP(desc_size + avail_size, qemu_real_host_page_size())=
;
> > }
> >
> > [...]
> >
> > size_t vhost_svq_memory_packed(const VhostShadowVirtqueue *svq)
> > {
> >     size_t desc_size =3D sizeof(struct vring_packed_desc) * svq->num_fr=
ee;
> >     size_t driver_event_suppression =3D sizeof(struct vring_packed_desc=
_event);
> >     size_t device_event_suppression =3D sizeof(struct vring_packed_desc=
_event);
> >
> >     return ROUND_UP(desc_size + driver_event_suppression + device_event=
_suppression,
> >                     qemu_real_host_page_size());
> > }
>
> The size returned by "vhost_svq_driver_area_size" might not be the actual=
 driver
> size which is given by desc_size + driver_event_suppression, right? Will =
this have to
> be changed too?
>

Yes, you're right this needs to be changed too.

> Thanks,
> Sahil
>
> [1] https://docs.oasis-open.org/virtio/virtio/v1.3/csd01/virtio-v1.3-csd0=
1.html#x1-720008
>
>
>


