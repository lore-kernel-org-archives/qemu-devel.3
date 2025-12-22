Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E9A6E67810
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Dec 2025 18:21:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vXkWK-0008V2-8p; Mon, 22 Dec 2025 13:20:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1vXkWI-0008Ua-NG
 for qemu-devel@nongnu.org; Mon, 22 Dec 2025 13:20:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1vXkWG-0000qh-8T
 for qemu-devel@nongnu.org; Mon, 22 Dec 2025 13:20:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766427629;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ie4CaBMN/pBl+1WaLJYjH/pc2vw/kZ+A2hYiCSdUimY=;
 b=fTG9t0A3f80IsofCv7lMGp1l39p2t3yIHCq31P74mG93zesHKQFyWGAM+L1aYnrWQw0zl9
 V+wQkxrECZsH9Xflfo5XdFPCoivw+u+U6kSMS1999l49gVxgHo3vJ5aNmlT0bZ9Uv6250J
 +WS0jmLhRb6qLDqDye9OVKkmThO/l0M=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-XnrpA7M_Oau7JygBJ2dvgQ-1; Mon, 22 Dec 2025 13:20:26 -0500
X-MC-Unique: XnrpA7M_Oau7JygBJ2dvgQ-1
X-Mimecast-MFC-AGG-ID: XnrpA7M_Oau7JygBJ2dvgQ_1766427626
Received: by mail-yx1-f71.google.com with SMTP id
 956f58d0204a3-64651279fbdso6479929d50.0
 for <qemu-devel@nongnu.org>; Mon, 22 Dec 2025 10:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766427626; x=1767032426; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ie4CaBMN/pBl+1WaLJYjH/pc2vw/kZ+A2hYiCSdUimY=;
 b=c7Imwg+hKST0JgYI+apIxK4BKkTqHl2F3s6gJt7rvnfM1iaO8o0P+AM+5rsG4b0lwx
 m6QBaX3aVo2/m5mlFw1Vas2GMQtsAIxJ84QgwUSDZhxdXvkjzcK7liz/yFghMOi6CyjV
 aVqFuLPbnBUtcG8KUylOaEKiLhOTSrryzjLzxLf6suhasRUMhfjrqL/xHCE5wi3im/pu
 WTgR+8M3fxyw+8G0emdfnEG9oUMmHO3FO8MUy5kIHrNeB2fdegreHgbbOb53dOBqMW6b
 99GIkTIs/fo8W1c6BhnB6q11LM5SKoYhzf/XEmiKIY0X+ioeBZt5XmgG10NnVHfIwf+3
 RDcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766427626; x=1767032426;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ie4CaBMN/pBl+1WaLJYjH/pc2vw/kZ+A2hYiCSdUimY=;
 b=ZOozyCdhM0O/1ia4xUN38F9S3w0SGHwL8wAsa7WE9sSNcQkc9FqtGVwxq8fLvsIgci
 iCWZsuab01bKpUWJULIBL7qaGtRvB33SRV86h/XvjiIFPYotdqzVcOjPjn45pHuoRDwL
 vqfV7e5VREekL+fXmjoTE9aQUhHO34+w79b69fXeuRBKemf3aKoDKT4KHC0A0tYat0nT
 f5XLPS4lVw0XkqzQzS9uSqbsb4EHbkJ2UcL8FToqToJTtIOgAvqBpeXGb6LzQ1r0j7sl
 p5GIAiBA9zn4548cRaFdfq9TA6DbSJGZfEDm0w0KJfIJ2beLqgRuhUj0LG55AcAJzdUe
 UkZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWssD4GRMPj/6gAS724u5VU/VtzdUbc9qs5VWWVTR52JeJovnW5UUX/vZYbvJbBGlGr2PU9otpAe4X9@nongnu.org
X-Gm-Message-State: AOJu0YxHtGGMYPdY7uwxTsL/TQhSmrv66pSRC21nv9gtjDOki7ZaWc4B
 5tBQMbyUx8o9c/uA6tyxM/cMb+iikWoNPZEH/sFk9y04W0Jx4OXppIDmwwpwpkFK+MEhTuBCUDt
 3m3iIYOj7qRPBFmtk3gaFhcJnbHaLidHKYY196AtILot/OJD8kWFajXjNGT5l+drSJD86CrSiMn
 S4rswqPE/n7f3B4P/KnvgnHZ3d/BTcz5I=
X-Gm-Gg: AY/fxX4gwnVGEL8nqN1QpfQPNmHEUmP6YCko29mT4it2V/lJHIas1EZTQe+shhegfzc
 8mB5WZJXdMCrwXWd2igfHvy1E3/kmxUwp1FgLBuUelU5OFPiF6+bJIGFf2Zp/jGwFY29ByxgxAo
 Y8rYq0R+oM6hYx/OF2xLFDFi7WohvZZFI5Ij7+ovK3LdWjBeWHXGL1hlKikz188L31+w==
X-Received: by 2002:a05:690e:1881:b0:646:7da0:3a96 with SMTP id
 956f58d0204a3-6467da03affmr4513490d50.50.1766427625855; 
 Mon, 22 Dec 2025 10:20:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IElQmOISD9xzmwmY3+4Elxur5Gq2+7SukhGVvJ0xtRgg5f89UTF9OHSaJ/4k8Fe2QA322TDc/KdFtx+9031VXI=
X-Received: by 2002:a05:690e:1881:b0:646:7da0:3a96 with SMTP id
 956f58d0204a3-6467da03affmr4513459d50.50.1766427625354; Mon, 22 Dec 2025
 10:20:25 -0800 (PST)
MIME-Version: 1.0
References: <20251216015522.6540-1-wafer@jaguarmicro.com>
 <CAJaqyWcsVpE-CoHu_1V=9vhvSkgsSqY1QBq2OWitOvVPggVqpg@mail.gmail.com>
 <PUZPR06MB47136C0227E2506CCC34AAA4A2B4A@PUZPR06MB4713.apcprd06.prod.outlook.com>
In-Reply-To: <PUZPR06MB47136C0227E2506CCC34AAA4A2B4A@PUZPR06MB4713.apcprd06.prod.outlook.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 22 Dec 2025 19:19:49 +0100
X-Gm-Features: AQt7F2oPdavnhCdscmH1i6Koe9Vtqv1GiZep1KrgyCXY1YWa5DPXEUV0ib6QAHE
Message-ID: <CAJaqyWdb41Xzpq1z9Bikxsa63+QwPdScVZRE7B3UsdjNE+=sZA@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] vdpa: implement a statically allocated buffer for
 SVQ
To: Wafer <wafer@jaguarmicro.com>
Cc: "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "leiyang@redhat.com" <leiyang@redhat.com>, 
 "sgarzare@redhat.com" <sgarzare@redhat.com>,
 Angus Chen <angus.chen@jaguarmicro.com>
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

On Mon, Dec 22, 2025 at 6:10=E2=80=AFAM Wafer <wafer@jaguarmicro.com> wrote=
:
>
>
>
> > -----Original Message-----
> > From: Eugenio Perez Martin <eperezma@redhat.com>
> > Sent: 2025=E5=B9=B412=E6=9C=8819=E6=97=A5 16:12
> > To: Wafer <wafer@jaguarmicro.com>
> > Cc: mst@redhat.com; jasowang@redhat.com; qemu-devel@nongnu.org;
> > leiyang@redhat.com; sgarzare@redhat.com; Angus Chen
> > <angus.chen@jaguarmicro.com>
> > Subject: Re: [PATCH v3 2/4] vdpa: implement a statically allocated buff=
er for
> > SVQ
> >
> > External Mail: This email originated from OUTSIDE of the organization!
> > Do not click links, open attachments or provide ANY information unless =
you
> > recognize the sender and know the content is safe.
> >
> >
> > On Tue, Dec 16, 2025 at 2:55=E2=80=AFAM Wafer Xie <wafer@jaguarmicro.co=
m> wrote:
> > >
> > > From: wafer Xie <wafer@jaguarmicro.com>
> > >
> > > allocated and initialized when creating the vhost-vdpa device, and
> > > release the indirect buffer when vhost-vdpa is stopped.
> > >
> > > Signed-off-by: wafer Xie <wafer@jaguarmicro.com>
> > > ---
> > >  hw/virtio/vhost-shadow-virtqueue.c |  25 +++++
> > >  hw/virtio/vhost-vdpa.c             | 163 +++++++++++++++++++++++++++=
+-
> > >  2 files changed, 187 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/hw/virtio/vhost-shadow-virtqueue.c
> > > b/hw/virtio/vhost-shadow-virtqueue.c
> > > index 2481d49345..85eff1d841 100644
> > > --- a/hw/virtio/vhost-shadow-virtqueue.c
> > > +++ b/hw/virtio/vhost-shadow-virtqueue.c
> > > @@ -708,6 +708,25 @@ void vhost_svq_start(VhostShadowVirtqueue
> > *svq, VirtIODevice *vdev,
> > >      for (unsigned i =3D 0; i < svq->vring.num - 1; i++) {
> > >          svq->desc_next[i] =3D i + 1;
> > >      }
> > > +
> > > +    /* Initialize indirect descriptor state */
> > > +    svq->indirect_enabled =3D false;
> > > +    svq->current_indirect_buf =3D -1;
> > > +    for (int i =3D 0; i < SVQ_NUM_INDIRECT_BUFS; i++) {
> > > +        svq->indirect_bufs[i].desc =3D NULL;
> > > +        svq->indirect_bufs[i].iova =3D 0;
> > > +        svq->indirect_bufs[i].size =3D 0;
> > > +        svq->indirect_bufs[i].state =3D SVQ_INDIRECT_BUF_FREED;
> > > +        svq->indirect_bufs[i].num_descs =3D 0;
> > > +        svq->indirect_bufs[i].freed_descs =3D 0;
> > > +        svq->indirect_bufs[i].freeing_descs =3D 0;
> > > +        svq->indirect_bufs[i].freed_head =3D 0;
> > > +    }
> > > +
> > > +    /* Initialize desc_state indirect_buf_idx to -1 */
> > > +    for (unsigned i =3D 0; i < svq->vring.num; i++) {
> > > +        svq->desc_state[i].indirect_buf_idx =3D -1;
> > > +    }
> > >  }
> > >
> > >  /**
> > > @@ -748,6 +767,10 @@ void vhost_svq_stop(VhostShadowVirtqueue *svq)
> > >      munmap(svq->vring.desc, vhost_svq_driver_area_size(svq));
> > >      munmap(svq->vring.used, vhost_svq_device_area_size(svq));
> > >      event_notifier_set_handler(&svq->hdev_call, NULL);
> > > +
> > > +    /* Reset indirect descriptor state (memory is freed by vhost-vdp=
a) */
> > > +    svq->indirect_enabled =3D false;
> > > +    svq->current_indirect_buf =3D -1;
> > >  }
> > >
> > >  /**
> > > @@ -765,6 +788,8 @@ VhostShadowVirtqueue *vhost_svq_new(const
> > VhostShadowVirtqueueOps *ops,
> > >      event_notifier_init_fd(&svq->svq_kick, VHOST_FILE_UNBIND);
> > >      svq->ops =3D ops;
> > >      svq->ops_opaque =3D ops_opaque;
> > > +    svq->indirect_enabled =3D false;
> > > +    svq->current_indirect_buf =3D -1;
> > >      return svq;
> > >  }
> > >
> > > diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c index
> > > 7061b6e1a3..816868d153 100644
> > > --- a/hw/virtio/vhost-vdpa.c
> > > +++ b/hw/virtio/vhost-vdpa.c
> > > @@ -584,6 +584,155 @@ static int vhost_vdpa_get_dev_features(struct
> > vhost_dev *dev,
> > >      return ret;
> > >  }
> > >
> > > +/**
> > > + * Allocate a single indirect descriptor buffer for SVQ
> > > + *
> > > + * @v: vhost_vdpa instance
> > > + * @num_descs: Number of descriptors (should be vring.num)
> > > + * @buf: Output buffer structure to fill
> > > + *
> > > + * Returns true on success, false on failure.
> > > + */
> > > +static bool vhost_vdpa_alloc_indirect_buf(struct vhost_vdpa *v,
> > > +                                           uint16_t num_descs,
> > > +                                           SVQIndirectDescBuf *buf) =
{
> > > +    size_t desc_size =3D sizeof(vring_desc_t) * num_descs;
> > > +    size_t alloc_size =3D ROUND_UP(desc_size,
> > qemu_real_host_page_size());
> > > +    DMAMap needle =3D {
> > > +        .size =3D alloc_size - 1,
> > > +        .perm =3D IOMMU_RO,
> > > +    };
> > > +    vring_desc_t *indirect_desc;
> > > +    int r;
> > > +
> > > +    /* Allocate memory for indirect descriptors */
> > > +    indirect_desc =3D mmap(NULL, alloc_size, PROT_READ | PROT_WRITE,
> > > +                         MAP_SHARED | MAP_ANONYMOUS, -1, 0);
> > > +    if (indirect_desc =3D=3D MAP_FAILED) {
> > > +        error_report("Cannot allocate indirect descriptor buffer");
> > > +        return false;
> > > +    }
> > > +
> > > +    /* Allocate IOVA for the indirect descriptor buffer */
> > > +    r =3D vhost_iova_tree_map_alloc(v->shared->iova_tree, &needle,
> > > +                                  (hwaddr)(uintptr_t)indirect_desc);
> > > +    if (unlikely(r !=3D IOVA_OK)) {
> > > +        error_report("Cannot allocate iova for indirect descriptors =
(%d)", r);
> > > +        munmap(indirect_desc, alloc_size);
> > > +        return false;
> > > +    }
> > > +
> > > +    /* Map to device */
> > > +    r =3D vhost_vdpa_dma_map(v->shared, v->address_space_id,
> > needle.iova,
> > > +                           alloc_size, indirect_desc, true);
> > > +    if (unlikely(r !=3D 0)) {
> > > +        error_report("Cannot map indirect descriptors to device: %s =
(%d)",
> > > +                     g_strerror(-r), -r);
> > > +        vhost_iova_tree_remove(v->shared->iova_tree, needle);
> > > +        munmap(indirect_desc, alloc_size);
> > > +        return false;
> > > +    }
> > > +
> > > +    buf->desc =3D indirect_desc;
> > > +    buf->iova =3D needle.iova;
> > > +    buf->size =3D alloc_size;
> > > +    buf->state =3D SVQ_INDIRECT_BUF_FREED;
> > > +    buf->num_descs =3D num_descs;
> > > +    buf->freed_descs =3D num_descs;  /* All descriptors are free ini=
tially */
> > > +    buf->freeing_descs =3D 0;
> > > +    buf->freed_head =3D 0;
> > > +
> > > +    return true;
> > > +}
> > > +
> > > +/**
> > > + * Free a single indirect descriptor buffer
> > > + *
> > > + * @v: vhost_vdpa instance
> > > + * @buf: Buffer to free
> > > + */
> > > +static void vhost_vdpa_free_indirect_buf(struct vhost_vdpa *v,
> > > +                                          SVQIndirectDescBuf *buf) {
> > > +    DMAMap needle;
> > > +    const DMAMap *result;
> > > +    int r;
> > > +
> > > +    if (!buf->desc) {
> > > +        return;
> > > +    }
> > > +
> > > +    needle =3D (DMAMap) {
> > > +        .translated_addr =3D (uint64_t)(uintptr_t)buf->desc,
> > > +    };
> > > +    result =3D vhost_iova_tree_find_iova(v->shared->iova_tree,
> > > + &needle);
> > > +
> > > +    if (result) {
> > > +        r =3D vhost_vdpa_dma_unmap(v->shared, v->address_space_id,
> > > +                                 result->iova, buf->size);
> > > +        if (unlikely(r !=3D 0)) {
> > > +            error_report("Cannot unmap indirect descriptors: %s (%d)=
",
> > > +                         g_strerror(-r), -r);
> > > +        }
> > > +
> > > +        vhost_iova_tree_remove(v->shared->iova_tree, *result);
> > > +    }
> > > +
> > > +    munmap(buf->desc, buf->size);
> > > +    buf->desc =3D NULL;
> > > +    buf->iova =3D 0;
> > > +    buf->size =3D 0;
> > > +}
> > > +
> > > +/**
> > > + * Initialize indirect descriptor buffers for a single SVQ
> > > + *
> > > + * @v: vhost_vdpa instance
> > > + * @svq: Shadow virtqueue to initialize
> > > + *
> > > + * Returns true on success, false on failure.
> > > + */
> > > +static bool vhost_vdpa_svq_init_indirect(struct vhost_vdpa *v,
> > > +                                          VhostShadowVirtqueue *svq)
> > > +{
> > > +    if (!svq->vring.num) {
> > > +        return true;
> > > +    }
> > > +
> > > +    /* Allocate indirect descriptor buffers for this SVQ */
> > > +    for (int j =3D 0; j < SVQ_NUM_INDIRECT_BUFS; j++) {
> > > +        if (!vhost_vdpa_alloc_indirect_buf(v, svq->vring.num * 4,
> > > +                                           &svq->indirect_bufs[j])) =
{
> >
> > Why not allocate a single array of size "SVQ_NUM_INDIRECT_BUFS *
> > svq->vring.num * 4"? It should help management and maybe even
> > performance as memory accesses are more predictable.
> >
>
> We cannot assume or rely on the device to populate the used ring in the s=
ame order as the available ring.
> With a single large array, this may introduce holes, which makes managing=
 freed descriptors difficult.
> In addition, the virtio specification requires indirect descriptor addres=
ses to be contiguous, which further complicates management with a single ar=
ray.
>

Actually you made me review the QEMU's virtqueue_pop and vhost code
and it does not agree with the standard, so thanks for that :). As you
correctly point out, the standard says:

The first descriptor is located at the start of the indirect
descriptor table, additional indirect descriptors come immediately
afterwards. The VIRTQ_DESC_F_WRITE flags bit is the only valid flag
for descriptors in the indirect table. Others are reserved and are
ignored by the device. Buffer ID is also reserved and is ignored by
the device.

But in the do {} while after the "/* Collect all the descriptors */"
comments in the virtqueue_pop it follows the _F_NEXT field and
desc->next, as it is transversing a descriptor chain, and it should
ignore them if it is processing the indirect table. I think that
should be fixed, but maybe we can break some driver? Not Linux's one
for sure. Jason, MST, what do you think? If we should fix the device's
code, would you like to submit a patch, Wafer?

Now regarding the patch. We need the indirect descriptors to be
contiguous in memory, but my point is that having many different
tables makes it harder to manage. A good first step would be to just
allocate a buffer of that size and then divide it into
svq->indirect_bufs[i].

Instead of:
svq->indirect_buf[0].iova =3D mmap(size) && vhost_dma_map(...) ...
svq->indirect_buf[1].iova =3D mmap(size) && vhost_dma_map(...) ...

At least:
buf =3D mmap(size*2) && vhost_dma_map(...) ...
svq->indirect_buf[0].iova =3D buf
svq->indirect_buf[1].iova =3D buf + size

So the translation tree etc is smaller, QEMU need to do less ioctls,
less memory transactions, etc.

Even with that, we're losing opportunities of finding contiguous free
descriptors with many SVQIndirectDescBuf instead of a bigger single
one able to reuse the free holes. Let's say the SVQIndirectDescBuf are
4 descriptor length for simplicity. Now the driver makes available one
buffer that spans 3 descriptors (step 1), another one that spans three
descriptors (step 2), and another buffer than spans two descriptors
(step 3).

In this series the SVQ places the first indirect table in the first
SVQIndirectDescBuf, the second table at the second SVQIndirectDescBuf,
and then the third one must resort to chained descriptors. If we make
just one big buffer of size 8, all of them fits in the indirect table,
we just need to mark it as free.

Actually, as long as the device does not mark as used one descriptor,
we lose the all the SVQIndirectDescBuf from the time buf->freed_head
reaches the end.

Some ideas for that:
* Reuse IOVATree to handle the indirect table. It already do the
linear search on it, but the allocation and free may hurt performance.
Still, it should be able to find contiguous buffers if any.
* Use it in a circular way but store some data in desc_state so we can
coalesce the free entries. I can expand on that if needed.

If we still find that this approach still works better, I think we
should have many SVQIndirectDescBuf of queue length, which is the
maximum indirect table length. We can handle them as a free / used
stack, so looking for a free entry would be cheaper. What do you think
about that?

> > > +            /* Cleanup already allocated buffers */
> > > +            for (int k =3D 0; k < j; k++) {
> > > +                vhost_vdpa_free_indirect_buf(v, &svq->indirect_bufs[=
k]);
> > > +            }
> > > +            return false;
> > > +        }
> > > +    }
> > > +
> > > +    svq->indirect_enabled =3D true;
> > > +    svq->current_indirect_buf =3D 0;
> > > +    return true;
> > > +}
> > > +
> > > +/**
> > > + * Cleanup indirect descriptor buffers for a single SVQ
> > > + *
> > > + * @v: vhost_vdpa instance
> > > + * @svq: Shadow virtqueue to cleanup
> > > + */
> > > +static void vhost_vdpa_svq_cleanup_indirect(struct vhost_vdpa *v,
> > > +                                             VhostShadowVirtqueue
> > > +*svq) {
> > > +    for (int j =3D 0; j < SVQ_NUM_INDIRECT_BUFS; j++) {
> > > +        vhost_vdpa_free_indirect_buf(v, &svq->indirect_bufs[j]);
> > > +    }
> > > +    svq->indirect_enabled =3D false;
> > > +    svq->current_indirect_buf =3D -1;
> > > +}
> > > +
> > >  static void vhost_vdpa_init_svq(struct vhost_dev *hdev, struct
> > > vhost_vdpa *v)  {
> > >      g_autoptr(GPtrArray) shadow_vqs =3D NULL; @@ -791,8 +940,11 @@
> > > static void vhost_vdpa_svq_cleanup(struct vhost_dev *dev)
> > >      size_t idx;
> > >
> > >      for (idx =3D 0; idx < v->shadow_vqs->len; ++idx) {
> > > -        vhost_svq_stop(g_ptr_array_index(v->shadow_vqs, idx));
> > > +        VhostShadowVirtqueue *svq =3D g_ptr_array_index(v->shadow_vq=
s,
> > idx);
> > > +        vhost_vdpa_svq_cleanup_indirect(v, svq);
> >
> > All usages of vhost_vdpa_svq_cleanup_indirect go with vhost_svq_stop.
> > We can call vhost_vdpa_svq_cleanup_indirect from vhost_svq_stop or even
> > embed it.
> >
>
> Thank you for the suggestion. I will modify this in the next version of t=
he patch.
>
> However, I have one question: in hw/virtio/vhost-vdpa.c:vhost_vdpa_svq_cl=
eanup,
> why does it only call vhost_svq_stop(svq) without calling vhost_vdpa_svq_=
unmap_rings(dev, svq)?
>

We could call it, but the device is about to be totally destroyed,
either because it has been deleted from QEMU or because QEMU itself is
shutting down. The only action QEMU can do afterwards is to close the
descriptor, so the device should clean the maps anyway. But maybe I'm
missing something here.

> >
> > > +        vhost_svq_stop(svq);
> > >      }
> > > +
> > >      g_ptr_array_free(v->shadow_vqs, true);  }
> > >
> > > @@ -1299,6 +1451,13 @@ static bool vhost_vdpa_svqs_start(struct
> > vhost_dev *dev)
> > >              error_setg_errno(&err, -r, "Cannot set device address");
> > >              goto err_set_addr;
> > >          }
> > > +
> > > +        /* Initialize indirect descriptor buffers for this SVQ */
> > > +        if (!vhost_vdpa_svq_init_indirect(v, svq)) {
> > > +            /* Non-fatal: will fallback to chain mode */
> > > +            warn_report("Cannot initialize indirect descriptor for S=
VQ %u",
> > > +                virtio_get_queue_index(vq));
> > > +        }
> > >      }
> > >
> > >      return true;
> > > @@ -1313,6 +1472,7 @@ err:
> > >      error_reportf_err(err, "Cannot setup SVQ %u: ", i);
> > >      for (unsigned j =3D 0; j < i; ++j) {
> > >          VhostShadowVirtqueue *svq =3D g_ptr_array_index(v->shadow_vq=
s,
> > > j);
> > > +        vhost_vdpa_svq_cleanup_indirect(v, svq);
> > >          vhost_vdpa_svq_unmap_rings(dev, svq);
> > >          vhost_svq_stop(svq);
> > >      }
> > > @@ -1331,6 +1491,7 @@ static void vhost_vdpa_svqs_stop(struct
> > vhost_dev *dev)
> > >      for (unsigned i =3D 0; i < v->shadow_vqs->len; ++i) {
> > >          VhostShadowVirtqueue *svq =3D g_ptr_array_index(v->shadow_vq=
s,
> > > i);
> > >
> > > +        vhost_vdpa_svq_cleanup_indirect(v, svq);
> > >          vhost_svq_stop(svq);
> > >          vhost_vdpa_svq_unmap_rings(dev, svq);
> > >
> > > --
> > > 2.48.1
> > >
>


