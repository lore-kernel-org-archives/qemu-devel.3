Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 864B3C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 18:26:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXPdi-0003km-7F; Fri, 26 Jul 2024 14:26:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1sXPdf-0003k5-B8
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 14:25:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1sXPdb-0005BW-W2
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 14:25:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722018353;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ieApKXKTk8B9uGMPL45sYoTMfTUGotn2FWMzSO/jLBE=;
 b=TupIbKuk+IsHBNA+/GuiVHVZsLt68c06T3O8Viw1xWN5ihI2p+IWRJyF6ptUFTjB9KMxf8
 sJPJ2juSqIKf02cLuPTLRbbr/TOQiVVNX4DkhMR8v/8dXBB1xGRqJH5r1PvGVj0XcoX5Ew
 yHoLWBfqhihtuFZj1fXKcZJyQFRuvIY=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-BcQ5v5R9OhuyrJIHdt0zHw-1; Fri, 26 Jul 2024 14:25:52 -0400
X-MC-Unique: BcQ5v5R9OhuyrJIHdt0zHw-1
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-664916e5b40so39146067b3.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2024 11:25:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722018352; x=1722623152;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ieApKXKTk8B9uGMPL45sYoTMfTUGotn2FWMzSO/jLBE=;
 b=sURfe0766QC/IjEJLa2q9RQZN+McTlASuA2+9T3UOoi0qe+dVgpvo/iouL/8UBRbSK
 bAQYQXwliSCJ0cEzEvjjNIBZYLn9UXU69X5DMTJiz80EUHLzCBciNsaVGVblD8x+kCkZ
 1Dx9y+GCJIiFCt6xqlJkTJF6tC+fNQ+NHCxehlnd7H+tsgkmmv/8wSbw+jzIgFBs024f
 SAD0ymNQCukkQVhUQOzbqw6+8DWpdpk8LiL7ufWfP0UrpVR+sncZaz/+IWCWZzRyEEPn
 mGqJ5Cs1gltCLZQ5Nk+IEWUymzIXAKeAD/9+WEdA2JWbZOA8TXCfM/rB4odCnst6izWI
 kntQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqsOpfKDQZSzb5lKZDVduPCNndyyoi5KESybVbko8/C4FsWiZPYZ0ok79XlV8ano1q9lITw1oBC94ucrRN4DoKjB1/KMY=
X-Gm-Message-State: AOJu0YzY8E2BhUCu1GPJ/teEJDFWBHtEd8/NmhB+L4c/+rQbcqXY19ca
 c7VlTOB36dAAJFiRH73nCqc2UNHHuRVZ3eUpKnTSjx06AGBgSzaD/dBB16CAq5PLo7LNKF6EkYT
 h8t45l1LtxTUuOL6XYosqlqH8iVbedTWbBoYKQA/uqIFqNrpZ79JgNe23K8wytnBEoPjPCq2VSW
 jxCIZWYkkY5Vwg9G9xeoYxJfnURJ4=
X-Received: by 2002:a0d:e482:0:b0:66a:bf53:e077 with SMTP id
 00721157ae682-67a2cf69cfcmr4146727b3.16.1722018351825; 
 Fri, 26 Jul 2024 11:25:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZDlA6pHVNNpemLLHe15PZnXX/AqQiodYqOoJer+fnh+BXSNzc4DX21jIugqzal45w+lRvv94LfFJHHPqCNJY=
X-Received: by 2002:a0d:e482:0:b0:66a:bf53:e077 with SMTP id
 00721157ae682-67a2cf69cfcmr4146607b3.16.1722018351514; Fri, 26 Jul 2024
 11:25:51 -0700 (PDT)
MIME-Version: 1.0
References: <20240726095822.104017-1-sahilcdq@proton.me>
 <CAJaqyWdZeohNn3BpD=Od9F9JekayYnXR-RBOn6OX_Oq4uYq5MQ@mail.gmail.com>
 <7801595.EvYhyI6sBW@valdaarhun>
In-Reply-To: <7801595.EvYhyI6sBW@valdaarhun>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 26 Jul 2024 20:25:14 +0200
Message-ID: <CAJaqyWdrOpeVOoK-VZYvcK809s9Gg5Dx_L76Mj03_omOtn4UrQ@mail.gmail.com>
Subject: Re: [RFC v2 0/3] Add packed virtqueue to shadow virtqueue
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
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Jul 26, 2024 at 7:11=E2=80=AFPM Sahil <icegambit91@gmail.com> wrote=
:
>
> Hi,
>
> On Friday, July 26, 2024 7:10:24=E2=80=AFPM GMT+5:30 Eugenio Perez Martin=
 wrote:
> > On Fri, Jul 26, 2024 at 11:58=E2=80=AFAM Sahil Siddiq <icegambit91@gmai=
l.com> wrote:
> > > [...]
> > > Q1.
> > > In virtio_ring.h [2], new aliases with memory alignment enforcement
> > > such as "vring_desc_t" have been created. I am not sure if this
> > > is required for the packed vq descriptor ring (vring_packed_desc)
> > > as well. I don't see a type alias that enforces memory alignment
> > > for "vring_packed_desc" in the linux kernel. I haven't used any
> > > alias either.
> >
> > The alignment is required to be 16 for the descriptor ring and 4 for
> > the device and driver ares by the standard [1]. In QEMU, this is
> > solved by calling mmap, which always returns page-aligned addresses.
>
> Ok, I understand this now.
>
> > > Q2.
> > > I see that parts of the "vhost-vdpa" implementation is based on
> > > the assumption that SVQ uses the split vq format. For example,
> > > "vhost_vdpa_svq_map_rings" [3], calls "vhost_svq_device_area_size"
> > > which is specific to split vqs. The "vhost_vring_addr" [4] struct
> > > is also specific to split vqs.
> > >
> > > My idea is to have a generic "vhost_vring_addr" structure that
> > > wraps around split and packed vq specific structures, rather
> > > than using them directly in if-else conditions wherever the
> > > vhost-vdpa functions require their usage. However, this will
> > > involve checking their impact in several other places where this
> > > struct is currently being used (eg.: "vhost-user", "vhost-backend",
> > > "libvhost-user").
> >
> > Ok I've just found this is under-documented actually :).
> >
> > As you mention, vhost-user is already using this same struct for
> > packed vqs [2], just translating the driver area from the avail vring
> > and the device area from the used vring. So the best option is to
> > stick with that, unless I'm missing something.
> >
> >
> > [1] https://docs.oasis-open.org/virtio/virtio/v1.3/virtio-v1.3.html
> > [2]
> > https://github.com/DPDK/dpdk/blob/82c47f005b9a0a1e3a649664b7713443d18ab=
e43/
> > lib/vhost/vhost_user.c#L841C1-L841C25
>
> Sorry, I am a little confused here. I was referring to QEMU's vhost-user
> implementation here.
>
> Based on what I have understood, "vhost_vring_addr" is only being used
> for split vqs in QEMU's vhost-user and in other places too. The implement=
ation
> does not take into account packed vqs.
>
> I was going through DPDK's source. In DPDK's implementation of vhost-user=
 [1],
> the same struct (vhost_virtqueue) is being used for split vqs and packed =
vqs. This
> is possible since "vhost_virtqueue" [2] uses a union to wrap around the s=
plit and
> packed versions of the vq.
>

Ok, now I get you better. Let me start again from a different angle :).

vhost_vring_addr is already part of the API that QEMU uses between
itself and vhost devices, all vhost-kernel, vhost-user and vhost-vdpa.
To make non-backward compatible changes to it is impossible, as it
involves changes in all of these elements.

QEMU and DPDK, using vhost-user, already send and receive packed
virtqueues addresses using the current structure layout. QEMU's
hw/virtio/vhost.c:vhost_virtqueue_set_addr already sets vq->desc,
vq->avail and vq->user, which has the values of the desc, driver and
device. In that sense, I recommend not to modify it.

On the other hand, DPDK's vhost_virtqueue is not the same struct as
vhost_vring_addr. It is internal to DPDK so it can be modified. We
need to do something similar for the SVQ, yes.

To do that union trick piece by piece in VhostShadowVirtqueue is
possible, but it requires modifying all the usages of the current
vring. I think it is easier for us to follow the kernel's
virtio_ring.c model, as it is a driver too, and create a vring_packed.
We can create an anonymous union and suffix all members with a _packed
so we don't need to modify current split usage.

Let me know what you think.

> > > My idea is to have a generic "vhost_vring_addr" structure that
> > > wraps around split and packed vq specific structures, rather
> > > than using them directly in if-else conditions wherever the
> > > vhost-vdpa functions require their usage. However, this will
> > > involve checking their impact in several other places where this
> > > struct is currently being used (eg.: "vhost-user", "vhost-backend",
> > > "libvhost-user").
>
> I was referring to something similar by this. The current "vhost_vring_ad=
dr"
> can be renamed to "vhost_vring_addr_split" for example, and a new struct
> "vhost_vring_addr" can wrap around this and "vhost_vring_addr_packed"
> using a union.
>
> I liked the idea of using three unions for each member in the virtqueue f=
ormat
> instead of having one union for the whole format. I didn't think of this.=
 I think
> by having three unions the "vhost_svq_get_vring_addr" [3] function won't =
have
> to be split into two new functions to handle split and packed formats sep=
arately.
> I am not sure if this is what you were referring to.
>

But you need the if/else anyway, as the members are not vring_desc_t
but vring_packed_desc, and same with vring_avail_t and vring_used_t
with struct vring_packed_desc_event. Or am I missing something?

Thanks!


