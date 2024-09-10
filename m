Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74E97EDE9A3
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 16:40:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so3uT-0001qg-Oc; Tue, 10 Sep 2024 12:40:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1so3uS-0001ph-7T
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 12:40:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1so3uQ-0006rz-4b
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 12:40:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725986405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DLLh/6VXPGegoNmyqJLqRDK+IN42bAipNMWmZ8vuOKc=;
 b=QkbTcVgDlwLXk2qSSMRXD6u18ZZ9bwpMlRCglV15efvTk8OtDnvwWE3QO4T8dUle6L9GRz
 uASuMI7zwWUyalATYNhLomwMSWXbx252iBmmGoZriOLRrBOeFNQxDwwnkdiNCVi1gMRIWm
 zT6RA6IGjJn6fsQxEcnKrRoeYUQN3YQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-zf9K-oYyOF6Dl4scw0iyPw-1; Tue, 10 Sep 2024 12:40:03 -0400
X-MC-Unique: zf9K-oYyOF6Dl4scw0iyPw-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-374b981dd62so535865f8f.3
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 09:40:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725986402; x=1726591202;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DLLh/6VXPGegoNmyqJLqRDK+IN42bAipNMWmZ8vuOKc=;
 b=IxWT0/Q5jM8TPUOAif3+NmdmrafroeYi1xk6sYFcr2enWuVIdTnT7zvBxjoj6AscXE
 UZPe3BZkssO5wpjP2C+hCRmX1uhP2oMDQLopaFkUZQyR5x/gSwIOhIHi1RIjYF1s1s7Z
 B+ymT9UfoYCC4st95YkVVbmfeISm5ZUrc3NG+cPfpgq8Ft9Nt4uwXsZaLssbxRcLyWDs
 nTHONRppuuf4uFdW4+Z13CsrRMzQLkkdSDcbbXvcvW057AtoFZXcBWXb+GqIKHh039m0
 GW7dZpX20U0iGRRFEjXd/rdX6FpshbfnM8rcUy5zLXRPuIN5yHJ352MPULfYYSsju8ii
 meUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZo2N6/LF2j4xalOyNzr22YWCbpfCGTM52Eh7K5Y3j4Qhc5LS3zVAPDKUSZ+rqMQjo/0gyiy/fviu/@nongnu.org
X-Gm-Message-State: AOJu0YxeDWdbns67mmAzs36qPmYjurdxOmWwdBdgZD+5jQXPuvmXZaK6
 +urQzxgmY8Ibe+N+6oNtvq6wZjeVcaVEPjswD2Z2e9WFLUXkq+mFwOATjFKPTL+PK+xb4yILTHj
 3TB/oSYgMB6bQ9NW/tFSTRX274bHVFdS0cxWBLS9jIcvfPxFnjFGt
X-Received: by 2002:a05:6000:1190:b0:371:844f:e0c with SMTP id
 ffacd0b85a97d-378b0791f5cmr221716f8f.10.1725986402272; 
 Tue, 10 Sep 2024 09:40:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKy5eGZ4yf9DG/fSVAcZRJ8ddS3zvX8105Zj2QfltZ3w6hxCf+N0rrHytvkG4M7Zgui4rOzA==
X-Received: by 2002:a05:6000:1190:b0:371:844f:e0c with SMTP id
 ffacd0b85a97d-378b0791f5cmr221687f8f.10.1725986401318; 
 Tue, 10 Sep 2024 09:40:01 -0700 (PDT)
Received: from redhat.com ([31.187.78.63]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378956ddae5sm9310793f8f.97.2024.09.10.09.39.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 09:40:00 -0700 (PDT)
Date: Tue, 10 Sep 2024 12:39:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Mattias Nissler <mnissler@rivosinc.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, stefanha@redhat.com,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH] softmmu: Support concurrent bounce buffers
Message-ID: <20240910123810-mutt-send-email-mst@kernel.org>
References: <20240819135455.2957406-1-mnissler@rivosinc.com>
 <20240910105002-mutt-send-email-mst@kernel.org>
 <CAFEAcA9dxdKmU-SPg1QGUbziKeydVB=i8BZUaKqMZvMSTr8RVw@mail.gmail.com>
 <CAGNS4Ta7RbLNCk3ffaS7fpqDJDjAUwnCXsVvjawSb6F7+inYxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGNS4Ta7RbLNCk3ffaS7fpqDJDjAUwnCXsVvjawSb6F7+inYxg@mail.gmail.com>
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

On Tue, Sep 10, 2024 at 06:10:50PM +0200, Mattias Nissler wrote:
> On Tue, Sep 10, 2024 at 5:44 PM Peter Maydell <peter.maydell@linaro.org> wrote:
> >
> > On Tue, 10 Sept 2024 at 15:53, Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Mon, Aug 19, 2024 at 06:54:54AM -0700, Mattias Nissler wrote:
> > > > When DMA memory can't be directly accessed, as is the case when
> > > > running the device model in a separate process without shareable DMA
> > > > file descriptors, bounce buffering is used.
> > > >
> > > > It is not uncommon for device models to request mapping of several DMA
> > > > regions at the same time. Examples include:
> > > >  * net devices, e.g. when transmitting a packet that is split across
> > > >    several TX descriptors (observed with igb)
> > > >  * USB host controllers, when handling a packet with multiple data TRBs
> > > >    (observed with xhci)
> > > >
> > > > Previously, qemu only provided a single bounce buffer per AddressSpace
> > > > and would fail DMA map requests while the buffer was already in use. In
> > > > turn, this would cause DMA failures that ultimately manifest as hardware
> > > > errors from the guest perspective.
> > > >
> > > > This change allocates DMA bounce buffers dynamically instead of
> > > > supporting only a single buffer. Thus, multiple DMA mappings work
> > > > correctly also when RAM can't be mmap()-ed.
> > > >
> > > > The total bounce buffer allocation size is limited individually for each
> > > > AddressSpace. The default limit is 4096 bytes, matching the previous
> > > > maximum buffer size. A new x-max-bounce-buffer-size parameter is
> > > > provided to configure the limit for PCI devices.
> > > >
> > > > Signed-off-by: Mattias Nissler <mnissler@rivosinc.com>
> > > > Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> > > > Acked-by: Peter Xu <peterx@redhat.com>
> > > > ---
> > > > This patch is split out from my "Support message-based DMA in vfio-user server"
> > > > series. With the series having been partially applied, I'm splitting this one
> > > > out as the only remaining patch to system emulation code in the hope to
> > > > simplify getting it landed. The code has previously been reviewed by Stefan
> > > > Hajnoczi and Peter Xu. This latest version includes changes to switch the
> > > > bounce buffer size bookkeeping to `size_t` as requested and LGTM'd by Phil in
> > > > v9.
> > > > ---
> > > >  hw/pci/pci.c                |  8 ++++
> > > >  include/exec/memory.h       | 14 +++----
> > > >  include/hw/pci/pci_device.h |  3 ++
> > > >  system/memory.c             |  5 ++-
> > > >  system/physmem.c            | 82 ++++++++++++++++++++++++++-----------
> > > >  5 files changed, 76 insertions(+), 36 deletions(-)
> > > >
> > > > diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> > > > index fab86d0567..d2caf3ee8b 100644
> > > > --- a/hw/pci/pci.c
> > > > +++ b/hw/pci/pci.c
> > > > @@ -85,6 +85,8 @@ static Property pci_props[] = {
> > > >                      QEMU_PCIE_ERR_UNC_MASK_BITNR, true),
> > > >      DEFINE_PROP_BIT("x-pcie-ari-nextfn-1", PCIDevice, cap_present,
> > > >                      QEMU_PCIE_ARI_NEXTFN_1_BITNR, false),
> > > > +    DEFINE_PROP_SIZE32("x-max-bounce-buffer-size", PCIDevice,
> > > > +                     max_bounce_buffer_size, DEFAULT_MAX_BOUNCE_BUFFER_SIZE),
> > > >      DEFINE_PROP_END_OF_LIST()
> > > >  };
> > > >
> > >
> > > I'm a bit puzzled by now there being two fields named
> > > max_bounce_buffer_size, one directly controllable by
> > > a property.
> 
> One is one the pci device, the other is on the address space. The
> former can be set via a command line parameter, and that value is used
> to initialize the field on the address space, which is then consulted
> when allocating bounce buffers.
> 
> I'm not sure which aspect of this is unclear and/or deserves
> additional commenting - let me know and I'll be happy to send a patch.

I'd document what does each field do.

> > >
> > > Pls add code comments explaining how they are related.
> > >
> > >
> > > Also, what is the point of adding a property without
> > > making it part of an API? No one will be able to rely on
> > > it working.
> >
> > Note that this patch is already upstream as commit 637b0aa13.
> >
> > thanks
> > -- PMM

Maybe you can answer this?


