Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92233C52D7B
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 15:26:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seFtA-0003WX-WB; Wed, 14 Aug 2024 11:26:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1seFt8-0003OF-Ki
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 11:26:14 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1seFt6-0006A0-M1
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 11:26:14 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-52ef95ec938so7153530e87.3
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2024 08:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723649171; x=1724253971; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=cYmZmpJgLLQrHUQazIqEoQJSKSP9xtHfcufNHThOFxA=;
 b=P0ydSifJJNty1z/1/L2Z7HCkGFGg/Bw50oC7+41mDMFkS/rJ8IYdxVqDWvhQLfhvRF
 Bv5C2yZU0u36Ax/08Hx6szkbj/LYs+IzHNaw8k6Tik9v3LTEc1Thws2RSVaz+k1qOuyU
 kf8wpWHNUUwa3zvZgoAhx5NU5PolV73gaS4lroattTuukfy9ga4wUS11zEXxS1fQKkJ2
 pu3cdms8Iv5FYCOLIXQc02iKUiITRTpc8XCq5HEUnaTR1b4sNYQa8lTfhs9VfpMp5X12
 MLRLLkuH1R7ttAnWH8UtHw2dweSpPF2ixDiU+eaZWYlli+dTE7sQrYBMsyAEibjTUnDb
 NQLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723649171; x=1724253971;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cYmZmpJgLLQrHUQazIqEoQJSKSP9xtHfcufNHThOFxA=;
 b=Oh3k6eozr5zdN8nEHKjfBoOaQjTrcILtxqX+hZdu5cCf23Q/n79RTcAjnKoMjKw9LJ
 f8/rspww7XY+H0myReQWot8b5fQyVK+lwNSzG/hguoNrQJb3NPdtnjlCOVYN8oFRDU+9
 03Iq185o83MFZDOjvKzXv2mFIY6/CWhynpDJM+8oYMLXOjhyBks37nsoHeuV4m4V/Gp6
 CPyXPLjLiLemTxclMkMXeZX2BDdY1swBk7G9xAPOLfE9EBexlJvA4Ti07Cq27K2gc6hu
 fd5jhC07wllZo0s7G+COy3EHKqh+iHoh7BIZ7pTFgjaYivk3qiyz3n4vizP1d35XPYUe
 T+9A==
X-Gm-Message-State: AOJu0YyZJyCmrProuAYBWf4pmvO4JU6oPQRy7eFoaIgAm4713ppT18v/
 cfuHjHPqGKzu/2RvMp2U/IOW7VRFRhyfdrzTagYIlAlYI+5LxoNY
X-Google-Smtp-Source: AGHT+IG1Tnr3tLyBrgc/O5GzweCTeGDL9nfPEC8VxaJ8ErG8oekcC7nHueShqJcul+pp0L8HwsIUhw==
X-Received: by 2002:a05:6512:33cf:b0:52e:9619:e26a with SMTP id
 2adb3069b0e04-532eda81a21mr2049698e87.26.1723649169776; 
 Wed, 14 Aug 2024 08:26:09 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53200f42734sm1303062e87.290.2024.08.14.08.26.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Aug 2024 08:26:09 -0700 (PDT)
Date: Wed, 14 Aug 2024 17:26:08 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: qemu-devel@nongnu.org, anthony@xenproject.org, paul@xen.org,
 peter.maydell@linaro.org, alex.bennee@linaro.org,
 xenia.ragiadakou@amd.com, jason.andryuk@amd.com,
 edgar.iglesias@amd.com, xen-devel@lists.xenproject.org
Subject: Re: [PATCH v1 08/10] hw/xen: pvh-common: Add support for creating
 PCIe/GPEX
Message-ID: <ZrzMkI5jGUtXU2qA@zapote>
References: <20240812130606.90410-1-edgar.iglesias@gmail.com>
 <20240812130606.90410-9-edgar.iglesias@gmail.com>
 <alpine.DEB.2.22.394.2408121822370.298534@ubuntu-linux-20-04-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2408121822370.298534@ubuntu-linux-20-04-desktop>
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x12f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, Aug 12, 2024 at 06:48:37PM -0700, Stefano Stabellini wrote:
> On Mon, 12 Aug 2024, Edgar E. Iglesias wrote:
> > From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
> > 
> > Add support for optionally creating a PCIe/GPEX controller.
> > 
> > Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
> > ---
> >  hw/xen/xen-pvh-common.c         | 66 +++++++++++++++++++++++++++++++++
> >  include/hw/xen/xen-pvh-common.h | 10 ++++-
> >  2 files changed, 75 insertions(+), 1 deletion(-)
> > 
> > diff --git a/hw/xen/xen-pvh-common.c b/hw/xen/xen-pvh-common.c
> > index 69a2dbdb6d..b1432e4bd9 100644
> > --- a/hw/xen/xen-pvh-common.c
> > +++ b/hw/xen/xen-pvh-common.c
> > @@ -120,6 +120,59 @@ static void xen_enable_tpm(XenPVHCommonState *s)
> >  }
> >  #endif
> >  
> > +static void xen_set_pci_intx_irq(void *opaque, int irq, int level)
> > +{
> > +    if (xen_set_pci_intx_level(xen_domid, 0, 0, 0, irq, level)) {
> 
> Looking at the implementation of XEN_DMOP_set_pci_intx_level in
> xen/arch/x86/hvm/dm.c, it looks like the device parameter of
> xen_set_pci_intx_level is required?

Yes, by setting device = 0, we're bypassing the irq swizzling in Xen.
I'll try to clarify below.


> 
> 
> > +        error_report("xendevicemodel_set_pci_intx_level failed");
> > +    }
> > +}
> > +
> > +static inline void xenpvh_gpex_init(XenPVHCommonState *s,
> > +                                    MemoryRegion *sysmem,
> > +                                    hwaddr ecam_base, hwaddr ecam_size,
> > +                                    hwaddr mmio_base, hwaddr mmio_size,
> > +                                    hwaddr mmio_high_base,
> > +                                    hwaddr mmio_high_size,
> > +                                    int intx_irq_base)
> > +{
> > +    MemoryRegion *ecam_reg;
> > +    MemoryRegion *mmio_reg;
> > +    DeviceState *dev;
> > +    int i;
> > +
> > +    object_initialize_child(OBJECT(s), "gpex", &s->pci.gpex,
> > +                            TYPE_GPEX_HOST);
> > +    dev = DEVICE(&s->pci.gpex);
> > +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> > +
> > +    ecam_reg = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
> > +    memory_region_add_subregion(sysmem, ecam_base, ecam_reg);
> 
> I notice we don't use ecam_size anywhere? Is that because the size is
> standard?

Yes. we could remove the size property, having it slightly simplifies the
prop setting code (keeping these memmap prop-pairs alike) but it's not a big deal.

> 
> 
> > +    mmio_reg = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 1);
> > +
> > +    if (mmio_size) {
> > +        memory_region_init_alias(&s->pci.mmio_alias, OBJECT(dev), "pcie-mmio",
> > +                                 mmio_reg, mmio_base, mmio_size);
> > +        memory_region_add_subregion(sysmem, mmio_base, &s->pci.mmio_alias);
> > +    }
> > +
> > +    if (mmio_high_size) {
> > +        memory_region_init_alias(&s->pci.mmio_high_alias, OBJECT(dev),
> > +                "pcie-mmio-high",
> > +                mmio_reg, mmio_high_base, mmio_high_size);
> > +        memory_region_add_subregion(sysmem, mmio_high_base,
> > +                &s->pci.mmio_high_alias);
> > +    }
> > +
> > +    for (i = 0; i < GPEX_NUM_IRQS; i++) {
> > +        qemu_irq irq = qemu_allocate_irq(xen_set_pci_intx_irq, s, i);
> > +
> > +        sysbus_connect_irq(SYS_BUS_DEVICE(dev), i, irq);
> > +        gpex_set_irq_num(GPEX_HOST(dev), i, intx_irq_base + i);
> > +        xen_set_pci_link_route(i, intx_irq_base + i);
> 
> xen_set_pci_link_route is not currently implemented on ARM?
> 
> Looking at hw/i386/pc_piix.c:piix_intx_routing_notifier_xen it seems
> that the routing is much more complex over there. But looking at other
> machines that use GPEX such as hw/arm/virt.c it looks like the routing
> is straightforward the same way as in this patch.
> 
> I thought that PCI interrupt pin swizzling was required, but maybe not ?
> 
> It is totally fine if we do something different, simpler, than
> hw/i386/pc_piix.c:piix_intx_routing_notifier_xen. I just want to make
> sure that things remain consistent between ARM and x86, and also between
> Xen and QEMU view of virtual PCI interrupt routing.
>

Good questions. The following is the way I understand things but I may
ofcourse be wrong.

Yes, we're doing things differently than hw/i386/pc_piix.c mainly
because we're using the GPEX PCIe host bridge with it's internal
standard swizzling down to 4 INTX interrupts. Similar to microvm and
the ARM virt machine.

The swizzling for the GPEX is done inside the GPEX model and it's
described by xl in the ACPI tables for PVH guests. We don't want
Xen to do any additional swizzling in xen_set_pci_intx_level(), hence
device=0.

I haven't plumbed the GPEX connectinos for ARM yet but I think we could
simply call xendevicemodel_set_irq_level() and not use the pci_intx
calls that aren't implement (we wouldn't need them).

For x86/pvh, I wonder if we should be using xen_set_pci_intx_level() /
xen_set_pci_link_route() or some other API? since we're basically
bypassing things?
In one of the first implementations we used set_isa_irq_level() but
that call only reaches into irqs < 16 so it messed things up.

Does any one have any better ideas or suggestions?

Cheers,
Edgar

