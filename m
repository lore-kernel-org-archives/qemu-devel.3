Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C108FEE498F
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 10:25:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soKWw-0007lm-Ei; Wed, 11 Sep 2024 06:24:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1soKWr-0007l4-VK
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 06:24:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1soKWn-0002G2-VU
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 06:24:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726050286;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yx9UdMmcw46YCjYItSL5u5+hHb22G4vYPQoV46dkGGg=;
 b=gxBMto6otBngIOogkQzp1vnDEPtiP5xwis8OU4Cwc6aNgJQzLXPWhQyNAc97J5KUFjB+cc
 CcoJdd1b9HTvfcnMmdceAdZskh6LFf3kranR/YKl3cd//ET6rhfNpdtKsotS/sWj1xse7U
 o9thCcmT0Z5nRUTUDpue/slF80pkksQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-TbatKv3wPxaR29wSSFX1GA-1; Wed, 11 Sep 2024 06:24:45 -0400
X-MC-Unique: TbatKv3wPxaR29wSSFX1GA-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a7d2d414949so507063766b.0
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 03:24:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726050285; x=1726655085;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Yx9UdMmcw46YCjYItSL5u5+hHb22G4vYPQoV46dkGGg=;
 b=fDfdz7TKf+GbSSJq/815homrIr1/CozjoYsyHWeMoU61sBMQXseOlvBVWgfuh8WFKX
 ILPgFjZi94SHUmTZ7ZEstaCECe2rd1+SdMaB7xS0/rYPnaMa/MVRPzFr0j0kBG6Z2L17
 wcQVtvBPxMkcv3OnGpTFrVzds3Zk1npdVqLXjXZSue44DDSF7yVP6e9BvDDFqfGshU1Q
 zPZl02Qhdu2GEQM/PiICF4NZMZlHa0xIda/8mW0z5QiURL4TB3jBggzOPhGMIUe+ZwGW
 DsGUed2Qmz9d8dfeHvi4xaCKwdhClHc6S3PgczCSFGuj3jH6g04DkM1BjdsxNgX6hrvW
 ZK7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQUPtInvAvqiJCDjR3l4DPTSmFUDIJOt+1qE6A4KOrbWPDS6K8pi/fE57+umbeYlXzofloPX1Pp9Gu@nongnu.org
X-Gm-Message-State: AOJu0YynDtN5eFKbpg96ezEGJcacxaQ7oM3zNLm//DwXpESwEC4W8uv0
 MgEPl+f7ol80RUO6Khx1zXOsA9+RVe36p/3n7dFNlDfS+GAEgU/5wFUlxnX/1WIfhoM2uy5DF9T
 dBcT7c/MUdVaWEjQLn3fh5SBLGwUYc2AfIVLszFGgPft1BIO+E6J0
X-Received: by 2002:a17:906:4fc4:b0:a8a:8d81:97a8 with SMTP id
 a640c23a62f3a-a8ffaaa23b0mr423227366b.1.1726050284517; 
 Wed, 11 Sep 2024 03:24:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGouZ6B8uIdviDNrwANAXO6mcRy1pETBQDnTIe5ZC5xIz2y15CHmUks0ulX6prdu0u960KYbA==
X-Received: by 2002:a17:906:4fc4:b0:a8a:8d81:97a8 with SMTP id
 a640c23a62f3a-a8ffaaa23b0mr423223966b.1.1726050283831; 
 Wed, 11 Sep 2024 03:24:43 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1ec:a3d1:80b4:b3a2:70bf:9d18])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25cee72bsm604819366b.173.2024.09.11.03.24.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 03:24:43 -0700 (PDT)
Date: Wed, 11 Sep 2024 06:24:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Mattias Nissler <mnissler@rivosinc.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, stefanha@redhat.com,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH] softmmu: Support concurrent bounce buffers
Message-ID: <20240911062402-mutt-send-email-mst@kernel.org>
References: <20240819135455.2957406-1-mnissler@rivosinc.com>
 <20240910105002-mutt-send-email-mst@kernel.org>
 <CAFEAcA9dxdKmU-SPg1QGUbziKeydVB=i8BZUaKqMZvMSTr8RVw@mail.gmail.com>
 <CAGNS4Ta7RbLNCk3ffaS7fpqDJDjAUwnCXsVvjawSb6F7+inYxg@mail.gmail.com>
 <20240910123810-mutt-send-email-mst@kernel.org>
 <CAGNS4Tb9=H=c4=nihUYQH6oB8as++r8nG8SyOZtLo0XuiJR6kQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGNS4Tb9=H=c4=nihUYQH6oB8as++r8nG8SyOZtLo0XuiJR6kQ@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
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

On Tue, Sep 10, 2024 at 11:36:08PM +0200, Mattias Nissler wrote:
> On Tue, Sep 10, 2024 at 6:40 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Tue, Sep 10, 2024 at 06:10:50PM +0200, Mattias Nissler wrote:
> > > On Tue, Sep 10, 2024 at 5:44 PM Peter Maydell <peter.maydell@linaro.org> wrote:
> > > >
> > > > On Tue, 10 Sept 2024 at 15:53, Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > >
> > > > > On Mon, Aug 19, 2024 at 06:54:54AM -0700, Mattias Nissler wrote:
> > > > > > When DMA memory can't be directly accessed, as is the case when
> > > > > > running the device model in a separate process without shareable DMA
> > > > > > file descriptors, bounce buffering is used.
> > > > > >
> > > > > > It is not uncommon for device models to request mapping of several DMA
> > > > > > regions at the same time. Examples include:
> > > > > >  * net devices, e.g. when transmitting a packet that is split across
> > > > > >    several TX descriptors (observed with igb)
> > > > > >  * USB host controllers, when handling a packet with multiple data TRBs
> > > > > >    (observed with xhci)
> > > > > >
> > > > > > Previously, qemu only provided a single bounce buffer per AddressSpace
> > > > > > and would fail DMA map requests while the buffer was already in use. In
> > > > > > turn, this would cause DMA failures that ultimately manifest as hardware
> > > > > > errors from the guest perspective.
> > > > > >
> > > > > > This change allocates DMA bounce buffers dynamically instead of
> > > > > > supporting only a single buffer. Thus, multiple DMA mappings work
> > > > > > correctly also when RAM can't be mmap()-ed.
> > > > > >
> > > > > > The total bounce buffer allocation size is limited individually for each
> > > > > > AddressSpace. The default limit is 4096 bytes, matching the previous
> > > > > > maximum buffer size. A new x-max-bounce-buffer-size parameter is
> > > > > > provided to configure the limit for PCI devices.
> > > > > >
> > > > > > Signed-off-by: Mattias Nissler <mnissler@rivosinc.com>
> > > > > > Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> > > > > > Acked-by: Peter Xu <peterx@redhat.com>
> > > > > > ---
> > > > > > This patch is split out from my "Support message-based DMA in vfio-user server"
> > > > > > series. With the series having been partially applied, I'm splitting this one
> > > > > > out as the only remaining patch to system emulation code in the hope to
> > > > > > simplify getting it landed. The code has previously been reviewed by Stefan
> > > > > > Hajnoczi and Peter Xu. This latest version includes changes to switch the
> > > > > > bounce buffer size bookkeeping to `size_t` as requested and LGTM'd by Phil in
> > > > > > v9.
> > > > > > ---
> > > > > >  hw/pci/pci.c                |  8 ++++
> > > > > >  include/exec/memory.h       | 14 +++----
> > > > > >  include/hw/pci/pci_device.h |  3 ++
> > > > > >  system/memory.c             |  5 ++-
> > > > > >  system/physmem.c            | 82 ++++++++++++++++++++++++++-----------
> > > > > >  5 files changed, 76 insertions(+), 36 deletions(-)
> > > > > >
> > > > > > diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> > > > > > index fab86d0567..d2caf3ee8b 100644
> > > > > > --- a/hw/pci/pci.c
> > > > > > +++ b/hw/pci/pci.c
> > > > > > @@ -85,6 +85,8 @@ static Property pci_props[] = {
> > > > > >                      QEMU_PCIE_ERR_UNC_MASK_BITNR, true),
> > > > > >      DEFINE_PROP_BIT("x-pcie-ari-nextfn-1", PCIDevice, cap_present,
> > > > > >                      QEMU_PCIE_ARI_NEXTFN_1_BITNR, false),
> > > > > > +    DEFINE_PROP_SIZE32("x-max-bounce-buffer-size", PCIDevice,
> > > > > > +                     max_bounce_buffer_size, DEFAULT_MAX_BOUNCE_BUFFER_SIZE),
> > > > > >      DEFINE_PROP_END_OF_LIST()
> > > > > >  };
> > > > > >
> > > > >
> > > > > I'm a bit puzzled by now there being two fields named
> > > > > max_bounce_buffer_size, one directly controllable by
> > > > > a property.
> > >
> > > One is one the pci device, the other is on the address space. The
> > > former can be set via a command line parameter, and that value is used
> > > to initialize the field on the address space, which is then consulted
> > > when allocating bounce buffers.
> > >
> > > I'm not sure which aspect of this is unclear and/or deserves
> > > additional commenting - let me know and I'll be happy to send a patch.
> >
> > I'd document what does each field do.
> 
> I have just sent a patch to expand the comments, let's discuss details there.
> 
> >
> > > > >
> > > > > Pls add code comments explaining how they are related.
> > > > >
> > > > >
> > > > > Also, what is the point of adding a property without
> > > > > making it part of an API? No one will be able to rely on
> > > > > it working.
> 
> All I needed was a practical way to allow the bounce buffer size limit
> to be adjusted in the somewhat exotic situations where we're making
> DMA requests to indirect memory regions (in my case it is a qemu
> vfio-user server accessed by a client that can't or doesn't want to
> provide direct memory-mapped access to its RAM). There was some
> discussion about the nature of the parameter when I first proposed the
> patch, see https://lore.kernel.org/qemu-devel/20230823092905.2259418-2-mnissler@rivosinc.com/
> - an x-prefixed experimental command-line parameter was suggested
> there as a practical way to allow this without qemu committing to
> supporting this forever. For the unlikely case that this parameter
> proves popular, it can still be added to a stable API (or
> alternatively we could discuss whether a large-enough limit is
> feasible after all, or even consider DMA API changes to obviate the
> need for bounce buffering).


Yes but how happy will you be if we rename the parameter in the
future? All your scripts will break.

> > > >
> > > > Note that this patch is already upstream as commit 637b0aa13.
> > > >
> > > > thanks
> > > > -- PMM
> >
> > Maybe you can answer this?
> >


