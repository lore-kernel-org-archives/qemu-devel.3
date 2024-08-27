Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5833BC5472F
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 15:31:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1siyAH-00011U-7w; Tue, 27 Aug 2024 11:31:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1siyAD-00010J-Np
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 11:31:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1siyAB-0002wR-5Y
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 11:31:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724772676;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ppg8Cg1AhMvsEg1b2Svv09WgIDeObYGhOqqrUTJComM=;
 b=D4PdOjZV70S/+ggz9A40fVJsmiWCLonjKhMxPNTf/reXEH0o3lyXCVm8VI/SaHfR92G4yg
 183L6gsGd8r2UEJIO+ydPR8fsViMor34Y5nKUws+rEBOwckHa2r0KyxbnLzalqUKFDLX4n
 AhBda3DoVugS6pfibG9MbuiqTz6Vcng=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-pdwNkOZLMWi6VhPo2t7lgg-1; Tue, 27 Aug 2024 11:31:14 -0400
X-MC-Unique: pdwNkOZLMWi6VhPo2t7lgg-1
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-6b41e02c255so121305007b3.3
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2024 08:31:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724772673; x=1725377473;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ppg8Cg1AhMvsEg1b2Svv09WgIDeObYGhOqqrUTJComM=;
 b=eaNzB2jvBTGOEdYBp51PHjC0YDYbn9G3dn72aL+F6f5C+1Ek7hDAGvZ+2UMeLDYheq
 Py63ZJ8aBywDt35AhWJ8/Baq6MXZhqWFxiVXXGzKAMe29KZNzGrKSPLk9YGZlG8M8kfu
 jMiz3CP3m/0vyTaxjxetJ95BBSJbwwvTlMRTFjEogplV9aT/5y1xSMKgHBak+OWrQYXb
 xkqB3v2J7jT7422a/qt0rjRthjR7dDK9tl4sPK/WKIyjGDSxNSgf7R7saMG4oSekJ5pL
 c2klIHhoVfQzwogEDPNNMTV0ZMMkjVccJ2/L3+P5MXAGEzGL3iXymDVNqU59/awTVjlh
 /IpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQzat2sgpKf0gQSi5+4OrdRL2r9a5K33tYlvenX9TTcW08ox+ULTXYdkQzToDy0WtRudFwG2nhfNWF@nongnu.org
X-Gm-Message-State: AOJu0YzK2rreXiYaFk0tzGDeVHEWbRpYl+/wkXibxbgfzIOJ3tcQjcFb
 KxrPNXGnY4RijzJSl0G4EhGkBIpkKZ1WGW205rbKRkfXyDtlHWz8Hakhna5QATUnid3aMyyfgVb
 t6tlGIjwPHmTfw/gJ3wdB7oWDt8o7et96bXYgOPiE6OGMvmo6hjLdyq4Wq3LzeaK2IMCAnaw0Dt
 KQzNBtOtkwsB1XAE6q/KmfrlA0hM8=
X-Received: by 2002:a05:690c:288:b0:63b:df6e:3f6d with SMTP id
 00721157ae682-6c6288aa1f2mr122669217b3.37.1724772673361; 
 Tue, 27 Aug 2024 08:31:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOMS5MQoejgGS7kahB2hRFy3vCNtkvO8bsJXfCsQHHSZ13K2pBgfP7k6Gtl0Pr9r5fNyXPPgMsZj/nywbLRrQ=
X-Received: by 2002:a05:690c:288:b0:63b:df6e:3f6d with SMTP id
 00721157ae682-6c6288aa1f2mr122668837b3.37.1724772672942; Tue, 27 Aug 2024
 08:31:12 -0700 (PDT)
MIME-Version: 1.0
References: <20240802112138.46831-1-sahilcdq@proton.me>
 <8454459.NyiUUSuA9g@valdaarhun>
 <CAJaqyWf3Vv6LvCHvRtpdZFQrhVHMOUTdzhJGj7PkbVDYeKox_w@mail.gmail.com>
 <1901750.tdWV9SEqCh@valdaarhun>
In-Reply-To: <1901750.tdWV9SEqCh@valdaarhun>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 27 Aug 2024 17:30:36 +0200
Message-ID: <CAJaqyWeDxL039GV=QzreenSNGm7S1XWWp=FH2KeB6PLGf=11-w@mail.gmail.com>
Subject: Re: [RFC v3 3/3] vhost: Allocate memory for packed vring
To: Sahil <icegambit91@gmail.com>
Cc: sgarzare@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, 
 Sahil Siddiq <sahilcdq@proton.me>
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

On Wed, Aug 21, 2024 at 2:20=E2=80=AFPM Sahil <icegambit91@gmail.com> wrote=
:
>
> Hi,
>
> Sorry for the late reply.
>
> On Tuesday, August 13, 2024 12:23:55=E2=80=AFPM GMT+5:30 Eugenio Perez Ma=
rtin wrote:
> > [...]
> > > I think I have understood what's going on in "vhost_vdpa_svq_map_ring=
s",
> > > "vhost_vdpa_svq_map_ring" and "vhost_vdpa_dma_map". But based on
> > > what I have understood it looks like the driver area is getting mappe=
d to
> > > an iova which is read-only for vhost_vdpa. Please let me know where I=
 am
> > > going wrong.
> >
> > You're not going wrong there. The device does not need to write into
> > this area, so we map it read only.
> >
> > > Consider the following implementation in hw/virtio/vhost_vdpa.c:
> > > > size_t device_size =3D vhost_svq_device_area_size(svq);
> > > > size_t driver_size =3D vhost_svq_driver_area_size(svq);
> > >
> > > The driver size includes the descriptor area and the driver area. For
> > > packed vq, the driver area is the "driver event suppression" structur=
e
> > > which should be read-only for the device according to the virtio spec
> > > (section 2.8.10) [1].
> > >
> > > > size_t avail_offset;
> > > > bool ok;
> > > >
> > > > vhost_svq_get_vring_addr(svq, &svq_addr);
> > >
> > > Over here "svq_addr.desc_user_addr" will point to the descriptor area
> > > while "svq_addr.avail_user_addr" will point to the driver area/driver
> > > event suppression structure.
> > >
> > > > driver_region =3D (DMAMap) {
> > > >
> > > >     .translated_addr =3D svq_addr.desc_user_addr,
> > > >     .size =3D driver_size - 1,
> > > >     .perm =3D IOMMU_RO,
> > > >
> > > > };
> > >
> > > This region points to the descriptor area and its size encompasses th=
e
> > > driver area as well with RO permission.
> > >
> > > > ok =3D vhost_vdpa_svq_map_ring(v, &driver_region, errp);
> > >
> > > The above function checks the value of needle->perm and sees that it =
is
> > > RO.
> > >
> > > It then calls "vhost_vdpa_dma_map" with the following arguments:
> > > > r =3D vhost_vdpa_dma_map(v->shared, v->address_space_id, needle->io=
va,
> > > >
> > > >                                                needle->size + 1,
> > > >                                                (void
> > > >                                                *)(uintptr_t)needle-=
>tra
> > > >                                                nslated_addr,
> > > >                                                needle->perm =3D=3D
> > > >                                                IOMMU_RO);
> > >
> > > Since needle->size includes the driver area as well, the driver area =
will
> > > be mapped to a RO page in the device's address space, right?
> >
> > Yes, the device does not need to write into the descriptor area in the
> > supported split virtqueue case. So the descriptor area is also mapped
> > RO at this moment.
> >
> > This change in the packed virtqueue case, so we need to map it RW.
>
> I understand this now. I'll see how the implementation can be modified to=
 take
> this into account. I'll see if making the driver area and descriptor ring=
 helps.
>
> > > > if (unlikely(!ok)) {
> > > >
> > > >     error_prepend(errp, "Cannot create vq driver region: ");
> > > >     return false;
> > > >
> > > > }
> > > > addr->desc_user_addr =3D driver_region.iova;
> > > > avail_offset =3D svq_addr.avail_user_addr - svq_addr.desc_user_addr=
;
> > > > addr->avail_user_addr =3D driver_region.iova + avail_offset;
> > >
> > > I think "addr->desc_user_addr" and "addr->avail_user_addr" will both =
be
> > > mapped to a RO page in the device's address space.
> > >
> > > > device_region =3D (DMAMap) {
> > > >
> > > >     .translated_addr =3D svq_addr.used_user_addr,
> > > >     .size =3D device_size - 1,
> > > >     .perm =3D IOMMU_RW,
> > > >
> > > > };
> > >
> > > The device area/device event suppression structure on the other hand =
will
> > > be mapped to a RW page.
> > >
> > > I also think there are other issues with the current state of the pat=
ch.
> > > According to the virtio spec (section 2.8.10) [1], the "device event
> > > suppression" structure needs to be write-only for the device but is
> > > mapped to a RW page.
> >
> > Yes, I'm not sure if all IOMMU supports write-only maps to be honest.
>
> Got it. I think it should be alright to defer this issue until later.
>
> > > Another concern I have is regarding the driver area size for packed v=
q. In
> > >
> > > "hw/virtio/vhost-shadow-virtqueue.c" of the current patch:
> > > > size_t vhost_svq_driver_area_size(const VhostShadowVirtqueue *svq)
> > > > {
> > > >
> > > >     size_t desc_size =3D sizeof(vring_desc_t) * svq->vring.num;
> > > >     size_t avail_size =3D offsetof(vring_avail_t, ring[svq->vring.n=
um]) +
> > > >
> > > >                                                               sizeo=
f(uin
> > > >                                                               t16_t=
);
> > > >
> > > >     return ROUND_UP(desc_size + avail_size, qemu_real_host_page_siz=
e());
> > > >
> > > > }
> > > >
> > > > [...]
> > > >
> > > > size_t vhost_svq_memory_packed(const VhostShadowVirtqueue *svq)
> > > > {
> > > >
> > > >     size_t desc_size =3D sizeof(struct vring_packed_desc) * svq->nu=
m_free;
> > > >     size_t driver_event_suppression =3D sizeof(struct
> > > >     vring_packed_desc_event);
> > > >     size_t device_event_suppression =3D sizeof(struct
> > > >     vring_packed_desc_event);
> > > >
> > > >     return ROUND_UP(desc_size + driver_event_suppression +
> > > >     device_event_suppression,> >
> > > >                     qemu_real_host_page_size());
> > > >
> > > > }
> > >
> > > The size returned by "vhost_svq_driver_area_size" might not be the ac=
tual
> > > driver size which is given by desc_size + driver_event_suppression,
> > > right? Will this have to be changed too?
> >
> > Yes, you're right this needs to be changed too.
>
> Understood. I'll modify this too.
>
> I have been trying to test my changes so far as well. I am not very clear=
 on
> a few things.
>
> Q1.
> I built QEMU from source with my changes and followed the vdpa_sim +
> vhost_vdpa tutorial [1]. The VM seems to be running fine. How do I check
> if the packed format is being used instead of the split vq format for sha=
dow
> virtqueues? I know the packed format is used when virtio_vdev has got the
> VIRTIO_F_RING_PACKED bit enabled. Is there a way of checking that this is
> the case?
>

You can see the features that the driver acked from the guest by
checking sysfs. Once you know the PCI BFN from lspci:
# lspci -nn|grep '\[1af4:1041\]'
01:00.0 Ethernet controller [0200]: Red Hat, Inc. Virtio 1.0 network
device [1af4:1041] (rev 01)
# cut -c 35 /sys/devices/pci0000:00/0000:00:02.0/0000:01:00.0/virtio0/featu=
res
0

Also, you can check from QEMU by simply tracing if your functions are
being called.

> Q2.
> What's the recommended way to see what's going on under the hood? I tried
> using the -D option so QEMU's logs are written to a file but the file was=
 empty.
> Would using qemu with -monitor stdio or attaching gdb to the QEMU VM be
> worthwhile?
>

You need to add --trace options with the regex you want to get to
enable any output. For example, --trace 'vhost_vdpa_*' print all the
trace_vhost_vdpa_* functions.

If you want to speed things up, you can just replace the interesting
trace_... functions with fprintf(stderr, ...). We can add the trace
ones afterwards.


