Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81864C52D7C
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 06:32:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdOar-0008OQ-Pr; Mon, 12 Aug 2024 02:31:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1sdOaq-0008Nw-AA
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 02:31:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1sdOam-0005PQ-Bb
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 02:31:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723444301;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EJ3DQuN8GUlrrdjBsng8MgAX/LSTXyg0KzYBtt+xOsc=;
 b=SMCMTp8mULvv5Ceo1Q6cKaOGeylRGWrcsXH0dGGWCICYhyS0TzZybVfGSlV1/6XaeTet+e
 CzBMOcKnWNJRpjM4w67D/PEUYin6h0pw3CxPEcl1v/4DOnNdtMwraWfacADJj3+29yd63N
 mQ95f8kh0hgoOsn5wDVQgRQ5DplFV0s=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-0UezqRRMPkepulbzY1s0DA-1; Mon, 12 Aug 2024 02:31:37 -0400
X-MC-Unique: 0UezqRRMPkepulbzY1s0DA-1
Received: by mail-yb1-f197.google.com with SMTP id
 3f1490d57ef6-e0baf2a2ed1so7804176276.1
 for <qemu-devel@nongnu.org>; Sun, 11 Aug 2024 23:31:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723444297; x=1724049097;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EJ3DQuN8GUlrrdjBsng8MgAX/LSTXyg0KzYBtt+xOsc=;
 b=NuJZF5oIto7aXRHBpNq4H5fekL5+UQba5dmGqDNzM4tPbJ64AiJPhWwsnDR0QQeZyQ
 8H7AgZrAB6LEoXf2UIyFLZYkD5GWq3ooGXY2vh0KjSsg9sFCM9wzu4V3hGwpEg4iLpXK
 XD6ZeJTDC6y2saMuvzZCnL6fONYM4C4KPUWey5Qt7OxO4Z6CkTcGHEJHNlwSIvd9homS
 ab+o2q1sfdRiFem7KsdXku4aDZ8VgTpwsvJf3Mu1opPeh6hfGi8+p+9WMUR4amWGNvVM
 i14ktz+4j0spjR7cnVVDgWqtrNe+SGyXLtDhR46YYKyjAEAbowaa4Bk3f8Ji7nriAdym
 GyZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHpu59hKU5YSJd+j75vTDFQK2xH4yqK6FKAjtKC+P8iUDXI6I9e/JK5oLXfjKbhHJ83avCqdUEZ4NK@nongnu.org
X-Gm-Message-State: AOJu0YwS6IF69MF7zz/3250uMjTrqrMe5tmrqJZQtNGLb5bOukJDCyvY
 zfRaVimXrZi0DXlb61RCw7P1g9gcNbgimdeUuBn6mX7yy98iYii+pd0hXzmkEERpK+Nt7ErgXM7
 AfIeIsGhOOkNRVkE9pxDhPQAV9agpqyH7MumfJfEC+aH4jXVRUtF1lT6QXy27vOezz9b89AWcxS
 kA+7bqWIaZNidQNcUjFcbsW2StzSc=
X-Received: by 2002:a05:6902:987:b0:e0b:d2e3:4da7 with SMTP id
 3f1490d57ef6-e0e9fdf7ea9mr9682864276.18.1723444297141; 
 Sun, 11 Aug 2024 23:31:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHB1FkpqhvoR/2vqXyFGCS/hZvnCiMj8mxHDDb+mfwp/CubxTucaJqamSv9kUwo8xOyj+rV3hWXYAi5CY/0Zfw=
X-Received: by 2002:a05:6902:987:b0:e0b:d2e3:4da7 with SMTP id
 3f1490d57ef6-e0e9fdf7ea9mr9682858276.18.1723444296683; Sun, 11 Aug 2024
 23:31:36 -0700 (PDT)
MIME-Version: 1.0
References: <20240802112138.46831-1-sahilcdq@proton.me>
 <20240802112138.46831-4-sahilcdq@proton.me>
 <CAJaqyWcrcEJimGqF3_K7YWCobPw00Yx+rcYQH1JXGcKesb5M2w@mail.gmail.com>
 <23656540.6Emhk5qWAg@valdaarhun>
In-Reply-To: <23656540.6Emhk5qWAg@valdaarhun>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 12 Aug 2024 08:31:00 +0200
Message-ID: <CAJaqyWe=RVretesMG_cLkYydUpthnaDjfcVp-vmF3BDyDTAauQ@mail.gmail.com>
Subject: Re: [RFC v3 3/3] vhost: Allocate memory for packed vring
To: Sahil <icegambit91@gmail.com>
Cc: sgarzare@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, 
 Sahil Siddiq <sahilcdq@proton.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Sun, Aug 11, 2024 at 7:20=E2=80=AFPM Sahil <icegambit91@gmail.com> wrote=
:
>
> Hi,
>
> On Wednesday, August 7, 2024 9:52:10=E2=80=AFPM GMT+5:30 Eugenio Perez Ma=
rtin wrote:
> > On Fri, Aug 2, 2024 at 1:22=E2=80=AFPM Sahil Siddiq <icegambit91@gmail.=
com> wrote:
> > > [...]
> > > @@ -726,17 +738,30 @@ void vhost_svq_start(VhostShadowVirtqueue *svq,=
 VirtIODevice *vdev,
> > >      svq->vring.num =3D virtio_queue_get_num(vdev,
> > >      virtio_get_queue_index(vq));
> > >      svq->num_free =3D svq->vring.num;
> > >
> > > -    svq->vring.desc =3D mmap(NULL, vhost_svq_driver_area_size(svq),
> > > -                           PROT_READ | PROT_WRITE, MAP_SHARED | MAP_=
ANONYMOUS,
> > > -                           -1, 0);
> > > -    desc_size =3D sizeof(vring_desc_t) * svq->vring.num;
> > > -    svq->vring.avail =3D (void *)((char *)svq->vring.desc + desc_siz=
e);
> > > -    svq->vring.used =3D mmap(NULL, vhost_svq_device_area_size(svq),
> > > -                           PROT_READ | PROT_WRITE, MAP_SHARED | MAP_=
ANONYMOUS,
> > > -                           -1, 0);
> > > -    svq->desc_state =3D g_new0(SVQDescState, svq->vring.num);
> > > -    svq->desc_next =3D g_new0(uint16_t, svq->vring.num);
> > > -    for (unsigned i =3D 0; i < svq->vring.num - 1; i++) {
> > > +    svq->is_packed =3D virtio_vdev_has_feature(svq->vdev, VIRTIO_F_R=
ING_PACKED);
> > > +
> > > +    if (virtio_vdev_has_feature(svq->vdev, VIRTIO_F_RING_PACKED)) {
> > > +        svq->vring_packed.vring.desc =3D mmap(NULL, vhost_svq_memory=
_packed(svq),
> > > +                                          PROT_READ | PROT_WRITE, MA=
P_SHARED | MAP_ANONYMOUS,
> > > +                                          -1, 0);
> > > +        desc_size =3D sizeof(struct vring_packed_desc) * svq->vring.=
num;
> > > +        svq->vring_packed.vring.driver =3D (void *)((char *)svq->vri=
ng_packed.vring.desc + desc_size);
> > > +        svq->vring_packed.vring.device =3D (void *)((char *)svq->vri=
ng_packed.vring.driver +
> > > +                                     sizeof(struct vring_packed_desc=
_event));
> >
> > This is a great start but it will be problematic when you start
> > mapping the areas to the vdpa device. The driver area should be read
> > only for the device, but it is placed in the same page as a RW one.
> >
> > More on this later.
> >
> > > +    } else {
> > > +        svq->vring.desc =3D mmap(NULL, vhost_svq_driver_area_size(sv=
q),
> > > +                               PROT_READ | PROT_WRITE, MAP_SHARED |M=
AP_ANONYMOUS,
> > > +                               -1, 0);
> > > +        desc_size =3D sizeof(vring_desc_t) * svq->vring.num;
> > > +        svq->vring.avail =3D (void *)((char *)svq->vring.desc + desc=
_size);
> > > +        svq->vring.used =3D mmap(NULL, vhost_svq_device_area_size(sv=
q),
> > > +                               PROT_READ | PROT_WRITE, MAP_SHARED |M=
AP_ANONYMOUS,
> > > +                               -1, 0);
> > > +    }
> >
> > I think it will be beneficial to avoid "if (packed)" conditionals on
> > the exposed functions that give information about the memory maps.
> > These need to be replicated at
> > hw/virtio/vhost-vdpa.c:vhost_vdpa_svq_map_rings.
> >
> > However, the current one depends on the driver area to live in the
> > same page as the descriptor area, so it is not suitable for this.
>
> I haven't really understood this.
>
> In split vqs the descriptor, driver and device areas are mapped to RW pag=
es.
> In vhost_vdpa.c:vhost_vdpa_svq_map_rings, the regions are mapped with
> the appropriate "perm" field that sets the R/W permissions in the DMAMap
> object. Is this problematic for the split vq format because the avail rin=
g is
> anyway mapped to a RW page in "vhost_svq_start"?
>

Ok so maybe the map word is misleading here. The pages needs to be
allocated for the QEMU process with both PROT_READ | PROT_WRITE, as
QEMU needs to write into it.

They are mapped to the device with vhost_vdpa_dma_map, and the last
bool parameter indicates if the device needs write permissions or not.
You can see how hw/virtio/vhost-vdpa.c:vhost_vdpa_svq_map_ring checks
the needle permission for this, and the needle permissions are stored
at hw/virtio/vhost-vdpa.c:vhost_vdpa_svq_map_rings. This is the
function that needs to check for the maps permissions.

> For packed vqs, the "Driver Event Suppression" data structure should be
> read-only for the device. Similar to split vqs, this is mapped to a RW pa=
ge
> in "vhost_svq_start" but it is then mapped to a DMAMap object with read-
> only perms in "vhost_vdpa_svq_map_rings".
>
> I am a little confused about where the issue lies.
>
> Thanks,
> Sahil
>
>


