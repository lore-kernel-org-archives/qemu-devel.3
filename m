Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48426C67861
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 04:56:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rth2F-00012d-9v; Mon, 08 Apr 2024 00:55:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rth2D-00012U-2c
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 00:55:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rth2B-00038D-3p
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 00:55:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712552104;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=veQYq9vZJzpYWKQI7CJh5BkWpDebxchSfxFtetVisU8=;
 b=ftkD5SUP8OqPPFr8fHxshLy1zxRgci3NTZA16LSeM0TorNEdnHFRkTvORubCFBNngB5v7P
 Pdopj4i6bgR8XKkoQXT+ljKF6Bx9gn+P6htgjA9B3qp8fyV92lwQ9d+PCE3L1irjunlKkj
 VSvuAkBTSjz5Ja1AhPtEU+x6ABuYr7A=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-MiiOJPkWNimZlDAR8RCC0Q-1; Mon, 08 Apr 2024 00:55:02 -0400
X-MC-Unique: MiiOJPkWNimZlDAR8RCC0Q-1
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-5d8bcf739e5so3635469a12.1
 for <qemu-devel@nongnu.org>; Sun, 07 Apr 2024 21:55:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712552101; x=1713156901;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=veQYq9vZJzpYWKQI7CJh5BkWpDebxchSfxFtetVisU8=;
 b=rFFcTf4BZJMuYihPnbRzPKLg9p3VZvJkcoRbgBBlZavoG0k2AXzrdjZD9ZjrIvgU5W
 dpeyUVZIX3v62lYsS3PtglV8vZwUeQSzUYoPdP4Ru4xRxo4cSyhu0gck2WDY3cNUJgps
 MjzjtthZdwvrGhYlIj6slswYflTH/ZxxIBLag45OWZDKIsFF/eu/umoHXnDN6gg60JDL
 MSY/1XLfymMcG32cOXi19/hOeHeuY9nubIkkBynsonVldIc1WjLQecrfpxTbLiv4F+fv
 DS8gFs8nR9cMoCZnU9PBzIAYT7qDFBax5h2GpG/j4Ygo8pETrvUJB+9mZS8LjsJyGu6Z
 IPbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFjdXcV4DexK31+lAxGDHenp+Twm2e4H6RoQn7G2BsfhIHWcNeINi0EBJdTIOys6XCiRvcs9qbrEHnzkdnaV626VJP2w8=
X-Gm-Message-State: AOJu0YwC0LURAj4ZQH7o5YzeVgRz6B9JQ0+8EbKyBhL0YCV7SIopzl6y
 WQzvHN7INO8IW1lr5ZZcKciaZVDdnA9Gp6D8v2ME6cweJU4r6dbGNju5+IKi0KT7eDT0a7ATajV
 U/JwwAoTHojTb1MVWesI43dw4LeBpXnWuBTFcz07c/K53ZlBtwu9253zf7SRuenJ0frPuk8aWs1
 571AdrUtgbuem2zAOyXRiftAChEI0=
X-Received: by 2002:a05:6a21:2728:b0:1a3:4863:f70e with SMTP id
 rm40-20020a056a21272800b001a34863f70emr5626242pzb.46.1712552101118; 
 Sun, 07 Apr 2024 21:55:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8G2SeqLVNzIkhq2Uj0tpnYz/dAo/EHyuHIvLTG/X7aK5/Jg8sopc+QfQzNjeqtkkkpTWvtrG6858R16zxyss=
X-Received: by 2002:a05:6a21:2728:b0:1a3:4863:f70e with SMTP id
 rm40-20020a056a21272800b001a34863f70emr5626239pzb.46.1712552100794; Sun, 07
 Apr 2024 21:55:00 -0700 (PDT)
MIME-Version: 1.0
References: <20240402150218.270587-1-lulu@redhat.com>
 <20240402150218.270587-2-lulu@redhat.com>
 <CACGkMEuQc+e+JOnScUdJckP1yb1Ushu9E0VEQKhwdn26W422bw@mail.gmail.com>
 <20240407075135-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240407075135-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 8 Apr 2024 12:54:49 +0800
Message-ID: <CACGkMEsYfTu0_8OHs1j1ZV=uKENigBkVxLgLCqX29K7-u=pvsw@mail.gmail.com>
Subject: Re: [PATCH 1/1] virtio-pci: Fix the crash when the vector changes
 back from VIRTIO_NO_VECTOR
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Cindy Lu <lulu@redhat.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.355,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Sun, Apr 7, 2024 at 7:53=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Sun, Apr 07, 2024 at 12:19:57PM +0800, Jason Wang wrote:
> > On Tue, Apr 2, 2024 at 11:02=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrot=
e:
> > >
> > > When the guest calls virtio_stop and then virtio_reset,
> >
> > Guests could not call those functions directly, it is triggered by for
> > example writing to some of the registers like reset or others.
> >
> > > the vector will change
> > > to VIRTIO_NO_VECTOR and the IRQFD for this vector will be released. A=
fter that
> > > If you want to change the vector back,
> >
> > What do you mean by "change the vector back"? Something like
> >
> > assign VIRTIO_MSI_NO_VECTOR to vector 0
> > assign X to vector 0
> >
> > And I guess what you meant is to configure the vector after DRIVER_OK.
> >
> >
> > > it will cause a crash.
> > >
> > > To fix this, we need to call the function "kvm_virtio_pci_vector_use_=
one()"
> > > when the vector changes back from VIRTIO_NO_VECTOR
> > >
> > > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > > ---
> > >  hw/virtio/virtio-pci.c | 31 ++++++++++++++++++++++++++++---
> > >  1 file changed, 28 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> > > index e433879542..45f3ab38c3 100644
> > > --- a/hw/virtio/virtio-pci.c
> > > +++ b/hw/virtio/virtio-pci.c
> > > @@ -874,12 +874,14 @@ static int virtio_pci_get_notifier(VirtIOPCIPro=
xy *proxy, int queue_no,
> > >      return 0;
> > >  }
> > >
> > > -static int kvm_virtio_pci_vector_use_one(VirtIOPCIProxy *proxy, int =
queue_no)
> > > +static int kvm_virtio_pci_vector_use_one(VirtIOPCIProxy *proxy, int =
queue_no,
> > > +                                         bool recovery)
> > >  {
> > >      unsigned int vector;
> > >      int ret;
> > >      EventNotifier *n;
> > >      PCIDevice *dev =3D &proxy->pci_dev;
> > > +    VirtIOIRQFD *irqfd;
> > >      VirtIODevice *vdev =3D virtio_bus_get_device(&proxy->bus);
> > >      VirtioDeviceClass *k =3D VIRTIO_DEVICE_GET_CLASS(vdev);
> > >
> > > @@ -890,10 +892,21 @@ static int kvm_virtio_pci_vector_use_one(VirtIO=
PCIProxy *proxy, int queue_no)
> > >      if (vector >=3D msix_nr_vectors_allocated(dev)) {
> > >          return 0;
> > >      }
> > > +    /*
> > > +     * if this is recovery and irqfd still in use, means the irqfd w=
as not
> > > +     * release before and don't need to set up again
> > > +     */
> > > +    if (recovery) {
> > > +        irqfd =3D &proxy->vector_irqfd[vector];
> > > +        if (irqfd->users !=3D 0) {
> > > +            return 0;
> > > +        }
> > > +    }
> > >      ret =3D kvm_virtio_pci_vq_vector_use(proxy, vector);
> > >      if (ret < 0) {
> > >          goto undo;
> > >      }
> > > +
> > >      /*
> > >       * If guest supports masking, set up irqfd now.
> > >       * Otherwise, delay until unmasked in the frontend.
> > > @@ -932,14 +945,14 @@ static int kvm_virtio_pci_vector_vq_use(VirtIOP=
CIProxy *proxy, int nvqs)
> > >          if (!virtio_queue_get_num(vdev, queue_no)) {
> > >              return -1;
> > >          }
> > > -        ret =3D kvm_virtio_pci_vector_use_one(proxy, queue_no);
> > > +        ret =3D kvm_virtio_pci_vector_use_one(proxy, queue_no, false=
);
> > >      }
> > >      return ret;
> > >  }
> > >
> > >  static int kvm_virtio_pci_vector_config_use(VirtIOPCIProxy *proxy)
> > >  {
> > > -    return kvm_virtio_pci_vector_use_one(proxy, VIRTIO_CONFIG_IRQ_ID=
X);
> > > +    return kvm_virtio_pci_vector_use_one(proxy, VIRTIO_CONFIG_IRQ_ID=
X, false);
> > >  }
> > >
> > >  static void kvm_virtio_pci_vector_release_one(VirtIOPCIProxy *proxy,
> > > @@ -1570,7 +1583,13 @@ static void virtio_pci_common_write(void *opaq=
ue, hwaddr addr,
> > >          } else {
> > >              val =3D VIRTIO_NO_VECTOR;
> > >          }
> > > +        vector =3D vdev->config_vector;
> > >          vdev->config_vector =3D val;
> > > +        /*check if the vector need to recovery*/
> > > +        if ((val !=3D VIRTIO_NO_VECTOR) && (vector =3D=3D VIRTIO_NO_=
VECTOR) &&
> > > +            (vdev->status & VIRTIO_CONFIG_S_DRIVER_OK)) {
> > > +            kvm_virtio_pci_vector_use_one(proxy, VIRTIO_CONFIG_IRQ_I=
DX, true);
> > > +        }
> >
> > This looks too tricky.
> >
> > Think hard of this. I think it's better to split this into two parts:
> >
> > 1) a series that disables config irqfd for vhost-net, this series
> > needs to be backported to -stable which needs to be conservative. It
> > looks more like your V1, but let's add a boolean for pci proxy.
>
> I don't get it. Looks like a huge change to do in stable.
> All as a replacement to a small 20 line patch?

For example, this patch needs more tweak so it won't be that tiny:

1) needs to check if we can use guest notifiers (irqfd)
2) the switching from X to NO_VECTOR might need
kvm_virtio_pci_vq_vector_release()

>
> Generally I think irqfd is best used everywhere.

Only when msix and kvm are both enabled.

>
>
> > 2) a series that deal with the msix vector configuration after
> > driver_ok, we probably need some refactoring to do per vq use instead
> > of the current loop in DRIVER_OK
> >
> > Does this make sense?
> >
> > Thanks
>
>
> Not really let's fix the bug for starters, refactoring can be done later
> as appropriate.

This is exactly my point. Avoiding that for non vDPA device seems to
be easier or maybe I was wrong.

Thanks

>
> > >          break;
> > >      case VIRTIO_PCI_COMMON_STATUS:
> > >          if (!(val & VIRTIO_CONFIG_S_DRIVER_OK)) {
> > > @@ -1611,6 +1630,12 @@ static void virtio_pci_common_write(void *opaq=
ue, hwaddr addr,
> > >              val =3D VIRTIO_NO_VECTOR;
> > >          }
> > >          virtio_queue_set_vector(vdev, vdev->queue_sel, val);
> > > +
> > > +        /*check if the vector need to recovery*/
> > > +        if ((val !=3D VIRTIO_NO_VECTOR) && (vector =3D=3D VIRTIO_NO_=
VECTOR) &&
> > > +            (vdev->status & VIRTIO_CONFIG_S_DRIVER_OK)) {
> > > +            kvm_virtio_pci_vector_use_one(proxy, vdev->queue_sel, tr=
ue);
> > > +        }
> > >          break;
> > >      case VIRTIO_PCI_COMMON_Q_ENABLE:
> > >          if (val =3D=3D 1) {
> > > --
> > > 2.43.0
> > >
>


