Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E563CF395D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 15:35:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srJAo-0000DY-UQ; Thu, 19 Sep 2024 11:34:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1srJAn-0000CI-In; Thu, 19 Sep 2024 11:34:25 -0400
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1srJAl-0002WY-Nr; Thu, 19 Sep 2024 11:34:25 -0400
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-5e174925b7bso503799eaf.0; 
 Thu, 19 Sep 2024 08:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726760061; x=1727364861; darn=nongnu.org;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tjDhq7+1RdYCrJ1i4TPTaRAHhdYLbWjdVx3paSErPag=;
 b=Xi62iXvYCTfkLLWfhJZbTzAn7++qZJS3rqbDg1THe2Qz+/ra7jY2QlcV1ZHM7raxwm
 53aVRawzgZyGSbDkAUv0Qi397MGa45aeQFJQzSIkRgjvLfkteijVSJFFRD8BEjskJHxC
 5m/TKDfZaX2i7PLwtFzfpkZtcBBRfMSlk3RA0Yn9e7fME3DtwVcCms7OmnrMbJd+/xmF
 jiUEBsgz5+u5FeWa74K1Z8l/ER+G6X6GgZP8Ot8aB18/qnjsbdzc+H20IukHQ1CBAkw3
 I5yUWc8a2U2kwJxpvvOkhvThtDb+06AqNeKArWeTQIxnkkzUQHKNEKTkGqndFq81KD+8
 TseA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726760061; x=1727364861;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tjDhq7+1RdYCrJ1i4TPTaRAHhdYLbWjdVx3paSErPag=;
 b=sZrKOwbgIc5bzAlGH7wdtLYIw2S1WuiP59cVccDeaHJxgYjVz7ruvhQPHJIXGB7AX8
 Vl7sI0G9KjpFJFS4IcvlMcXO/M9MYuLbSuvmcXpEnwjpzfjV20K6eVfUPqSijnI/U24+
 GL+wxo3GfxUnt8rzvnM54CNiBnwHBEAKBScg1cXcOR7Xc06c3wCJEYdBGIbr1yQXI2zs
 ql35VoCBOpYyLHkGI8nIjKUlQpYNmP2CfjMnaYYY5oveeDh8WgB4JzkT31NeJeFYd+kn
 iNS9dHNmrQ93wdITkoAK3Pxk4gQICHYN9ji6IWsg+nmkIjNq6u7tkMu80PXtHRuVR77S
 8Dng==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpjkMsjhQIv4TpTOH0ck9Mzt8oiYGlZOR5oRjbvlyX0YCS4h/4efkENotRVTaRUJEudsMmUrUqQg==@nongnu.org
X-Gm-Message-State: AOJu0YzVR1G4mvMccfp/dh8xvv7gkziuD7AdRa7z9GQwjK3GuSkLrMrB
 apd7V5CcIxA7Ow2nqpAVqb7O3Ea7w7fAPKDjWXGxc6Y9gVcCwTpF
X-Google-Smtp-Source: AGHT+IGkPtGASlsN1mWnU/lPiOwMx8LXKTp+l3V1wEIIDvN6gyZZ5xYjRG3djb2ALL6FjuDV5gqYKg==
X-Received: by 2002:a05:6808:211d:b0:3e0:451b:d029 with SMTP id
 5614622812f47-3e07a107173mr14248840b6e.15.1726760061048; 
 Thu, 19 Sep 2024 08:34:21 -0700 (PDT)
Received: from gmail.com (ip190-5-140-142.intercom.com.sv. [190.5.140.142])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-84939994e8dsm1436459241.27.2024.09.19.08.34.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2024 08:34:19 -0700 (PDT)
Date: Thu, 19 Sep 2024 17:34:17 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: qemu-devel@nongnu.org, anthony@xenproject.org, paul@xen.org,
 peter.maydell@linaro.org, alex.bennee@linaro.org,
 edgar.iglesias@amd.com, xen-devel@lists.xenproject.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-arm@nongnu.org
Subject: Re: [PATCH v1 2/4] hw/xen: xenpvh: Disable buffered IOREQs for ARM
Message-ID: <ZuxEedSaR4fLKvrn@zapote>
References: <20240916150853.1216703-1-edgar.iglesias@gmail.com>
 <20240916150853.1216703-3-edgar.iglesias@gmail.com>
 <alpine.DEB.2.22.394.2409161646360.1417852@ubuntu-linux-20-04-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2409161646360.1417852@ubuntu-linux-20-04-desktop>
User-Agent: Mutt/2.2.12 (2023-09-09)
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2a;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-oo1-xc2a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Sep 16, 2024 at 04:47:43PM -0700, Stefano Stabellini wrote:
> On Mon, 16 Sep 2024, Edgar E. Iglesias wrote:
> > From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
> > 
> > Add a way to enable/disable buffered IOREQs for PVH machines
> > and disable them for ARM. ARM does not support buffered
> > IOREQ's nor the legacy way to map IOREQ info pages.
> > 
> > See the following for more details:
> > https://xenbits.xen.org/gitweb/?p=xen.git;a=commitdiff;h=2fbd7e609e1803ac5e5c26e22aa8e4b5a6cddbb1
> > https://xenbits.xen.org/gitweb/?p=xen.git;a=blob;f=xen/arch/arm/ioreq.c;h=2e829d2e7f3760401b96fa7c930e2015fb1cf463;hb=HEAD#l138
> > 
> > Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
> > ---
> >  hw/arm/xen-pvh.c                | 3 +++
> >  hw/i386/xen/xen-pvh.c           | 3 +++
> >  hw/xen/xen-pvh-common.c         | 2 +-
> >  include/hw/xen/xen-pvh-common.h | 3 +++
> >  4 files changed, 10 insertions(+), 1 deletion(-)
> > 
> > diff --git a/hw/arm/xen-pvh.c b/hw/arm/xen-pvh.c
> > index 04cb9855af..28af3910ea 100644
> > --- a/hw/arm/xen-pvh.c
> > +++ b/hw/arm/xen-pvh.c
> > @@ -66,6 +66,9 @@ static void xen_arm_machine_class_init(ObjectClass *oc, void *data)
> >       */
> >      mc->max_cpus = GUEST_MAX_VCPUS;
> >  
> > +    /* Xen/ARM does not use buffered IOREQs.  */
> > +    xpc->handle_bufioreq = HVM_IOREQSRV_BUFIOREQ_OFF;
> > +
> >      /* List of supported features known to work on PVH ARM.  */
> >      xpc->has_tpm = true;
> >      xpc->has_virtio_mmio = true;
> > diff --git a/hw/i386/xen/xen-pvh.c b/hw/i386/xen/xen-pvh.c
> > index 45645667e9..f1f02d3311 100644
> > --- a/hw/i386/xen/xen-pvh.c
> > +++ b/hw/i386/xen/xen-pvh.c
> > @@ -89,6 +89,9 @@ static void xen_pvh_machine_class_init(ObjectClass *oc, void *data)
> >      /* We have an implementation specific init to create CPU objects.  */
> >      xpc->init = xen_pvh_init;
> >  
> > +    /* Enable buffered IOREQs.  */
> > +    xpc->handle_bufioreq = HVM_IOREQSRV_BUFIOREQ_ATOMIC;
> > +
> >      /*
> >       * PCI INTX routing.
> >       *
> > diff --git a/hw/xen/xen-pvh-common.c b/hw/xen/xen-pvh-common.c
> > index 08641fdcec..76a9b2b945 100644
> > --- a/hw/xen/xen-pvh-common.c
> > +++ b/hw/xen/xen-pvh-common.c
> > @@ -195,7 +195,7 @@ static void xen_pvh_init(MachineState *ms)
> >  
> >      xen_pvh_init_ram(s, sysmem);
> >      xen_register_ioreq(&s->ioreq, ms->smp.max_cpus,
> > -                       HVM_IOREQSRV_BUFIOREQ_ATOMIC,
> > +                       xpc->handle_bufioreq,
> >                         &xen_memory_listener);
> >  
> >      if (s->cfg.virtio_mmio_num) {
> > diff --git a/include/hw/xen/xen-pvh-common.h b/include/hw/xen/xen-pvh-common.h
> > index bc09eea936..62c44a1ce7 100644
> > --- a/include/hw/xen/xen-pvh-common.h
> > +++ b/include/hw/xen/xen-pvh-common.h
> > @@ -43,6 +43,9 @@ struct XenPVHMachineClass {
> >       */
> >      int (*set_pci_link_route)(uint8_t line, uint8_t irq);
> >  
> > +    /* Allow implementations to optionally enable buffered ioreqs.  */
> > +    int handle_bufioreq;
> 
> Looking at the corresponding Xen interface this field is uint8_t. I
> think it would be better to use the same type here and also as a
> parameter to xen_register_ioreq in QEMU
>

Thanks Stefano,

I chose int because the interface to the Xen libs uses int:
https://xenbits.xen.org/gitweb/?p=xen.git;a=blob;f=tools/include/xendevicemodel.h;h=797e0c6b2961926a68cd96b8ff5e1627067903ac;hb=HEAD#l40

But yes, the hypercall interface uses uint8_t, I'm happy to change it to
uint8_t in the next version!

Cheers,
Edgar


