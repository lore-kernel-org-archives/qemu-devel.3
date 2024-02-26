Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E03BC48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 05:15:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reTKH-0001jC-Aa; Mon, 26 Feb 2024 00:14:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1reTKE-0001ib-IO
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 00:14:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1reTKB-0000ux-FK
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 00:14:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708924484;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fWmhcNftqt7i7qWP/miAn5J6AlxmbnGbjD+ETQyClbo=;
 b=gs2qOaa4vGXq/I56m6cO01U7haVJLwqjgZ90p1ehxQeF/gv6q7NzoX1WRAb5EI3wro1ctI
 G2JZ2D6QeDHAEFniOxEDys5nYUFpEyk0WkF8tJRnhrjj6xrkCAgP98BC7QBM32fmJX7WpU
 6W87dvA1StjPpUHvrDoOcd1AkIlWUzs=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-WOdPMWULM1uuPzTrx_6atw-1; Mon, 26 Feb 2024 00:14:43 -0500
X-MC-Unique: WOdPMWULM1uuPzTrx_6atw-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-299ba5ae65eso1844171a91.3
 for <qemu-devel@nongnu.org>; Sun, 25 Feb 2024 21:14:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708924482; x=1709529282;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fWmhcNftqt7i7qWP/miAn5J6AlxmbnGbjD+ETQyClbo=;
 b=BtZi+3bmE9N+Kt2zs51dQ/J+PxVlc7bn7FuSyWB7hclQU4w9+EByeZOGXN8CNn9ip9
 +aG1dOm8sL72Be66Bm1LoVkGiMR1loru83E0bIwNp+hjxla6Epmj4A5FXJoRr9UjBzuo
 qSbHWykjITFmpzn8bmyuR31/FB7zb24nTsBpPMcul1uhqRlmHPn6g8ob5KDtcfHSWIln
 pDUkAJWDa+ap5988xegAor2MLtiI6aHiIO+aKK9g0YnGuTxHozUubB08ChLtafAG1wrC
 XRwt58UAbLBtDQry1ShD6NPCmvhrGGnCtRlAIKoWiozhHUH0er3gNuDpRfg6zxf1Rr0/
 P/gw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/9H1Tq2kJDDdZiPDAh7kgVEXbevrOyl2/XkVPlCwmFq0iSdvdtP9ztHwjGqa8jn8rMGG+UcDEFcw51gsDeOzaZn+4xJI=
X-Gm-Message-State: AOJu0Yy5r880l4uqBbcEyCyC6C0VKJ61vg/l0EIrPoiFtlrRTxtHYjZ/
 /SyYErdCZsTn7InBqErXdnBDfS51WEYQ2UfVYEXLKHxCl0fgO8k9d+13BIRnO2yiLG85pfksFVP
 9bUwMwOOSWoYHOKeFpfXz+a+Pz26jhG2JiUxmPdXsoSh6aeLkoooadKy6wIj69ftyyxzFyfVe7B
 JXEnCgBs0dSlSdQLtR9m18vRjdZBk=
X-Received: by 2002:a17:90a:7402:b0:299:519b:7108 with SMTP id
 a2-20020a17090a740200b00299519b7108mr3838896pjg.9.1708924482095; 
 Sun, 25 Feb 2024 21:14:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFjV6Umoj1Wn6c9WGmW8mjS6kr1LKgwg2NMvhoi2XWnX23YHIgZz8iQoW5CQq6dgbbNqUX3Qfr4tPPGXyXHkBE=
X-Received: by 2002:a17:90a:7402:b0:299:519b:7108 with SMTP id
 a2-20020a17090a740200b00299519b7108mr3838886pjg.9.1708924481772; Sun, 25 Feb
 2024 21:14:41 -0800 (PST)
MIME-Version: 1.0
References: <20240220070935.1617570-1-schalla@marvell.com>
 <20240220024043-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240220024043-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 26 Feb 2024 13:14:30 +0800
Message-ID: <CACGkMEtXF7AeNoZFRDaQktypSRAxN_f2KzJwS2nCXyrYABs0Pg@mail.gmail.com>
Subject: Re: [PATCH v2] virtio-pci: correctly set virtio pci queue mem
 multiplier
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Srujana Challa <schalla@marvell.com>, qemu-devel@nongnu.org,
 vattunuru@marvell.com, jerinj@marvell.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.097,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Tue, Feb 20, 2024 at 3:41=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Tue, Feb 20, 2024 at 12:39:35PM +0530, Srujana Challa wrote:
> > Currently, virtio_pci_queue_mem_mult function always returns 4K
> > when VIRTIO_PCI_FLAG_PAGE_PER_VQ is set. But this won't
> > work for vhost vdpa when host has page size other than 4K.
> > This patch introduces a new property(page-per-vdpa-vq) for vdpa
> > use case to fix the same.
> >
> > Signed-off-by: Srujana Challa <schalla@marvell.com>
> > ---
> > v1->v2:
> > - Introduced a new property to get virtqueue mem multiplier for
> >   vdpa use case.
>
>
> OK, I would maybe call it host-page-per-vq?
>
> Jason?
>

I agree.

Thanks

> >  hw/virtio/virtio-pci.c         | 10 ++++++++--
> >  include/hw/virtio/virtio-pci.h |  5 +++++
> >  2 files changed, 13 insertions(+), 2 deletions(-)
> >
> > diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> > index 1a7039fb0c..28dd6ab8b5 100644
> > --- a/hw/virtio/virtio-pci.c
> > +++ b/hw/virtio/virtio-pci.c
> > @@ -320,8 +320,12 @@ static bool virtio_pci_ioeventfd_enabled(DeviceSta=
te *d)
> >
> >  static inline int virtio_pci_queue_mem_mult(struct VirtIOPCIProxy *pro=
xy)
> >  {
> > -    return (proxy->flags & VIRTIO_PCI_FLAG_PAGE_PER_VQ) ?
> > -        QEMU_VIRTIO_PCI_QUEUE_MEM_MULT : 4;
> > +    if (proxy->flags & VIRTIO_PCI_FLAG_PAGE_PER_VQ)
> > +        return QEMU_VIRTIO_PCI_QUEUE_MEM_MULT;
> > +    else if (proxy->flags & VIRTIO_PCI_FLAG_PAGE_PER_VDPA_VQ)
> > +        return qemu_real_host_page_size();
> > +    else
> > +        return 4;
> >  }
> >
> >  static int virtio_pci_ioeventfd_assign(DeviceState *d, EventNotifier *=
notifier,
> > @@ -2301,6 +2305,8 @@ static Property virtio_pci_properties[] =3D {
> >                      VIRTIO_PCI_FLAG_INIT_FLR_BIT, true),
> >      DEFINE_PROP_BIT("aer", VirtIOPCIProxy, flags,
> >                      VIRTIO_PCI_FLAG_AER_BIT, false),
> > +    DEFINE_PROP_BIT("page-per-vdpa-vq", VirtIOPCIProxy, flags,
> > +                    VIRTIO_PCI_FLAG_PAGE_PER_VDPA_VQ_BIT, false),
> >      DEFINE_PROP_END_OF_LIST(),
> >  };
> >
> > diff --git a/include/hw/virtio/virtio-pci.h b/include/hw/virtio/virtio-=
pci.h
> > index 59d88018c1..10a30c26a2 100644
> > --- a/include/hw/virtio/virtio-pci.h
> > +++ b/include/hw/virtio/virtio-pci.h
> > @@ -43,6 +43,7 @@ enum {
> >      VIRTIO_PCI_FLAG_INIT_FLR_BIT,
> >      VIRTIO_PCI_FLAG_AER_BIT,
> >      VIRTIO_PCI_FLAG_ATS_PAGE_ALIGNED_BIT,
> > +    VIRTIO_PCI_FLAG_PAGE_PER_VDPA_VQ_BIT,
> >  };
> >
> >  /* Need to activate work-arounds for buggy guests at vmstate load. */
> > @@ -89,6 +90,10 @@ enum {
> >  #define VIRTIO_PCI_FLAG_ATS_PAGE_ALIGNED \
> >    (1 << VIRTIO_PCI_FLAG_ATS_PAGE_ALIGNED_BIT)
> >
> > +/* page per vdpa vq flag to be used for vhost vdpa backends */
> > +#define VIRTIO_PCI_FLAG_PAGE_PER_VDPA_VQ \
> > +    (1 << VIRTIO_PCI_FLAG_PAGE_PER_VDPA_VQ_BIT)
> > +
> >  typedef struct {
> >      MSIMessage msg;
> >      int virq;
> > --
> > 2.25.1
>


