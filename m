Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F512D41C38
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 11:32:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBBb4-0006E0-Ce; Wed, 13 Nov 2024 06:31:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1tBBb2-0006Dc-D1
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 06:31:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1tBBaz-0002ke-U7
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 06:31:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731497495;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j1kXf2RlZaNMPGdVUIqHB3ATN1b2Cv4f0ZyLP28Kenw=;
 b=bOr4kxecnTf+sbGoA94zHDsmizSMnv5d91WERrdNK5hnyopv75tMbsevHNFM4AlphYMi/f
 L88z9c2+JTusGOeHFKmBbNleIKCJfnfpPHQW8LAjn1AQGyaWtHitjEMjEDqFM/1jyWACE5
 9Akd/uNsUMSjfOfVmdKGchjI4JbDbdc=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-EefmReauNwiUl-5GB_8kGw-1; Wed, 13 Nov 2024 06:31:34 -0500
X-MC-Unique: EefmReauNwiUl-5GB_8kGw-1
X-Mimecast-MFC-AGG-ID: EefmReauNwiUl-5GB_8kGw
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-6e59dc7df64so7611487b3.1
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2024 03:31:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731497493; x=1732102293;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j1kXf2RlZaNMPGdVUIqHB3ATN1b2Cv4f0ZyLP28Kenw=;
 b=b51H7WGm6zspHwrZ0FjuagRSR1OV1x7MAHOhyl4JKrZYXH+ToWzf7J8jLryD6petIN
 d5eBmuCUmgBs0N8JoBbuHjjpJV9sECjOaOV5mrvROAV00iItFsmNDKdCjXdVXL2GXuHP
 j/jsfCz9A8jc9Q/+VsTYgGAIWlCrwxD7E5f+KCuHWO7KbaJUkJ+UEllOaxCyuucXDuYM
 nEUCT5gWpve9+1GTUv11ELfy4QOBB5WdgNC7aC0+Lk9lntok5qVLPMBrmVItf4zjp/kH
 XhUFv0A5OaZSW+aK9X8EIXHhfHTVP/ogng1+N6w4GjZ1mMsKySpBjIYXoWldzemunA02
 MYFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8bG7llA2y8rzz/1C5OQ6nMVlZfSujgreWxdsjts5SqawTYtRLMMN9l4o79XyPQz4KyNbs4sdeSVTP@nongnu.org
X-Gm-Message-State: AOJu0Yxr9dKSREzaRMb/6BlVRdtypsr18dsJXPXiHa3YUFtZekDOHaJO
 u8jrh2bQTv2NhgSnlxP7iiPJnxE/6/ZThBf22MTVmYiUSh+ZxwAyxHSxlJsm8tVF+B1o9SnR2ls
 3xELHDrWHhb8EZ6AxOAAidRtJAZhP+ER4onfDen0Ya32RDoPjr+viNkd0P9vCvdqgznSP1ekcg3
 M8qQiLtCtgXjXWpaAmowNGQls6Xwj7UWfFrpL1oYdV
X-Received: by 2002:a05:690c:fcf:b0:6e2:451c:df02 with SMTP id
 00721157ae682-6eade50eb4amr158320537b3.16.1731497492798; 
 Wed, 13 Nov 2024 03:31:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF1gQuACvgMFgsCUNFOYVkoZA3AOQuOhM6aq1vVYLRTClrb3qcS8hm/yrPhd/LV3tjpq6WhGpfkzYOaHAjMqf4=
X-Received: by 2002:a05:690c:fcf:b0:6e2:451c:df02 with SMTP id
 00721157ae682-6eade50eb4amr158320357b3.16.1731497492421; Wed, 13 Nov 2024
 03:31:32 -0800 (PST)
MIME-Version: 1.0
References: <20240802112138.46831-1-sahilcdq@proton.me>
 <3311761.aeNJFYEL58@valdaarhun>
 <CAJaqyWeus1zqEqE4ZzoGOzrY=w=_vEMdPGoHrv+Gxvc6zhiNmw@mail.gmail.com>
 <1904291.tdWV9SEqCh@valdaarhun>
 <CAFcRUGb-Nh0E0tKJkKiw7X2E+wOcA6yavRBe7Ly9WKeTK46ENA@mail.gmail.com>
 <89ae0aad-eb82-4f51-9384-689a19e1626d@gmail.com>
In-Reply-To: <89ae0aad-eb82-4f51-9384-689a19e1626d@gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 13 Nov 2024 12:30:55 +0100
Message-ID: <CAJaqyWedOSc-jm5DnxyPNfmFNcuxnaUNt3jK6MoKB+Gyr2ZQ+Q@mail.gmail.com>
Subject: Re: [RFC v3 3/3] vhost: Allocate memory for packed vring
To: Sahil Siddiq <icegambit91@gmail.com>
Cc: sgarzare@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, 
 Sahil Siddiq <sahilcdq@proton.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.119,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Wed, Nov 13, 2024 at 6:11=E2=80=AFAM Sahil Siddiq <icegambit91@gmail.com=
> wrote:
>
> Hi,
>
> On 10/28/24 11:07 AM, Sahil Siddiq wrote:
> > [...]
> > The payload that VHOST_SET_VRING_BASE accepts depends on whether
> > split virtqueues or packed virtqueues are used [6].  In hw/virtio/vhost=
-
> > vdpa.c:vhost_vdpa_svq_setup() [7], the following payload is used which =
is
> > not suitable for packed virtqueues:
> >
> > struct vhost_vring_state s =3D {
> >          .index =3D vq_index,
> > };
> >
> > Based on the implementation in the linux kernel, the payload needs to
> > be as shown below for the ioctl to succeed for packed virtqueues:
> >
> > struct vhost_vring_state s =3D {
> >          .index =3D vq_index,
> >          .num =3D 0x80008000,
> > };
> >
> > After making these changes, it looks like QEMU is able to set up the
> > virtqueues and shadow virtqueues are enabled as well.
> >
> > Unfortunately, before the L2 VM can finish booting the kernel crashes.
> > The reason is that even though packed virtqueues are to be used, the
> > kernel tries to run
> > drivers/virtio/virtio_ring.c:virtqueue_get_buf_ctx_split() [8]
> > (instead of virtqueue_get_buf_ctx_packed) and throws an "invalid vring
> > head" error. I am still investigating this issue.
>
> I made a mistake here. "virtqueue_get_buf_ctx_packed" [1] in the linux
> kernel also throws the same error. I think the issue might be because
> hw/virtio/vhost-vdpa.c:vhost_vdpa_svq_map_rings [2] does not handle
> mapping packed virtqueues at the moment.
>
> Probably because of this, vq->packed.desc_state[id].data [1] is NULL in t=
he
> kernel.
>
> Regarding one of the earlier reviews in the same thread [3]:
>

I think it is a good first step, yes. Looking forward to your findings!

> On 8/7/24 9:52 PM, Eugenio Perez Martin wrote:
> > On Fri, Aug 2, 2024 at 1:22=E2=80=AFPM Sahil Siddiq <icegambit91@gmail.=
com> wrote:
> >>
> >> Allocate memory for the packed vq format and support
> >> packed vq in the SVQ "start" and "stop" operations.
> >>
> >> Signed-off-by: Sahil Siddiq <sahilcdq@proton.me>
> >> ---
> >> [...]
> >>
> >> diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shad=
ow-virtqueue.c
> >> index 4c308ee53d..f4285db2b4 100644
> >> --- a/hw/virtio/vhost-shadow-virtqueue.c
> >> +++ b/hw/virtio/vhost-shadow-virtqueue.c
> >> [...]
> >> @@ -672,6 +674,16 @@ size_t vhost_svq_device_area_size(const VhostShad=
owVirtqueue *svq)
> >>       return ROUND_UP(used_size, qemu_real_host_page_size());
> >>   }
> >>
> >> +size_t vhost_svq_memory_packed(const VhostShadowVirtqueue *svq)
> >> +{
> >> +    size_t desc_size =3D sizeof(struct vring_packed_desc) * svq->num_=
free;
> >> +    size_t driver_event_suppression =3D sizeof(struct vring_packed_de=
sc_event);
> >> +    size_t device_event_suppression =3D sizeof(struct vring_packed_de=
sc_event);
> >> +
> >> +    return ROUND_UP(desc_size + driver_event_suppression + device_eve=
nt_suppression,
> >> +                    qemu_real_host_page_size());
> >> +}
> >> +
> >>   /**
> >>    * Set a new file descriptor for the guest to kick the SVQ and notif=
y for avail
> >>    *
> >> @@ -726,17 +738,30 @@ void vhost_svq_start(VhostShadowVirtqueue *svq, =
VirtIODevice *vdev,
> >>
> >>      svq->vring.num =3D virtio_queue_get_num(vdev, virtio_get_queue_in=
dex(vq));
> >>      svq->num_free =3D svq->vring.num;
> >> -    svq->vring.desc =3D mmap(NULL, vhost_svq_driver_area_size(svq),
> >> -                           PROT_READ | PROT_WRITE, MAP_SHARED | MAP_A=
NONYMOUS,
> >> -                           -1, 0);
> >> -    desc_size =3D sizeof(vring_desc_t) * svq->vring.num;
> >> -    svq->vring.avail =3D (void *)((char *)svq->vring.desc + desc_size=
);
> >> -    svq->vring.used =3D mmap(NULL, vhost_svq_device_area_size(svq),
> >> -                           PROT_READ | PROT_WRITE, MAP_SHARED | MAP_A=
NONYMOUS,
> >> -                           -1, 0);
> >> -    svq->desc_state =3D g_new0(SVQDescState, svq->vring.num);
> >> -    svq->desc_next =3D g_new0(uint16_t, svq->vring.num);
> >> -    for (unsigned i =3D 0; i < svq->vring.num - 1; i++) {
> >> +    svq->is_packed =3D virtio_vdev_has_feature(svq->vdev, VIRTIO_F_RI=
NG_PACKED);
> >> +
> >> +    if (virtio_vdev_has_feature(svq->vdev, VIRTIO_F_RING_PACKED)) {
> >> +        svq->vring_packed.vring.desc =3D mmap(NULL, vhost_svq_memory_=
packed(svq),
> >> +                                            PROT_READ | PROT_WRITE, M=
AP_SHARED | MAP_ANONYMOUS,
> >> +                                            -1, 0);
> >> +        desc_size =3D sizeof(struct vring_packed_desc) * svq->vring.n=
um;
> >> +        svq->vring_packed.vring.driver =3D (void *)((char *)svq->vrin=
g_packed.vring.desc + desc_size);
> >> +        svq->vring_packed.vring.device =3D (void *)((char *)svq->vrin=
g_packed.vring.driver +
> >> +                                                  sizeof(struct vring=
_packed_desc_event));
> >
> > This is a great start but it will be problematic when you start
> > mapping the areas to the vdpa device. The driver area should be read
> > only for the device, but it is placed in the same page as a RW one.
> >
> > More on this later.
> >
> >> +    } else {
> >> +        svq->vring.desc =3D mmap(NULL, vhost_svq_driver_area_size(svq=
),
> >> +                               PROT_READ | PROT_WRITE, MAP_SHARED | M=
AP_ANONYMOUS,
> >> +                               -1, 0);
> >> +        desc_size =3D sizeof(vring_desc_t) * svq->vring.num;
> >> +        svq->vring.avail =3D (void *)((char *)svq->vring.desc + desc_=
size);
> >> +        svq->vring.used =3D mmap(NULL, vhost_svq_device_area_size(svq=
),
> >> +                               PROT_READ | PROT_WRITE, MAP_SHARED | M=
AP_ANONYMOUS,
> >> +                               -1, 0);
> >> +    }
> >
> > I think it will be beneficial to avoid "if (packed)" conditionals on
> > the exposed functions that give information about the memory maps.
> > These need to be replicated at
> > hw/virtio/vhost-vdpa.c:vhost_vdpa_svq_map_rings.
>
> Based on what I have understood, I'll need to have an if(packed)
> condition in vhost_vdpa_svq_map_rings() because the mappings will
> differ in the packed and split cases.
>
> > However, the current one depends on the driver area to live in the
> > same page as the descriptor area, so it is not suitable for this.
>
> Right, for the split case, svq->vring.desc and svq->vring.avail are
> mapped to the same page.
>
>      svq->vring.desc =3D mmap(NULL, vhost_svq_driver_area_size(svq),
>                             PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANON=
YMOUS,
>                             -1, 0);
>      desc_size =3D sizeof(vring_desc_t) * svq->vring.num;
>      svq->vring.avail =3D (void *)((char *)svq->vring.desc + desc_size);
>
> vhost_svq_driver_area_size() encompasses the descriptor area and avail ri=
ng.
>
> > So what about this action plan:
> > 1) Make the avail ring (or driver area) independent of the descriptor r=
ing.
> > 2) Return the mapping permissions of the descriptor area (not needed
> > here, but needed for hw/virtio/vhost-vdpa.c:vhost_vdpa_svq_map_rings
>
> Does point 1 refer to mapping the descriptor and avail rings to separate
> pages for both split and packed cases. I am not sure if my understanding
> is correct.
>
> I believe, however, that this approach will make it easier to map the
> rings in the vdpa device. It might also help in removing the if(packed)
> condition in vhost_svq_start().
>

That's right, you understood it perfectly :). It's not a big deal but
it makes the code simpler in my opinion.

Thanks!


