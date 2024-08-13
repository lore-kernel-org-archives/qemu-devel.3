Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FB60C52D7C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 01:48:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdgea-00010r-8c; Mon, 12 Aug 2024 21:48:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1sdgeR-0000Rx-JV
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 21:48:44 -0400
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1sdgeP-0000UX-4M
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 21:48:42 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 5DB7561524;
 Tue, 13 Aug 2024 01:48:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C015EC4AF0E;
 Tue, 13 Aug 2024 01:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1723513720;
 bh=G6inMSvY1KniC+SCcLnpUK0HXdFGeYhyTMLJYR3qE7w=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=VjyXlIeV4kQ2WzOXxbxlCYIi6UptcMnZdLkoF3e8r9kG9Ydz9kfLxBg0T+sUZjXsp
 +gFY6p8zEleJAxF4daY4Thi9wrUbvtKoB1i4cpy+yGyGtS71GK2Xc4v5UjlWfAhdbe
 IZgsZHbTVJbIwe4ZLarKn+gz6MXKmItENYqdNHeaCNcx/0Bu2JGQY3izVXAsQ0mxde
 UiChJOKpQ3J5uoYOTID4Co8tygjuhxjYGEyHodpHPFPEEKFqnJaOgVJTBiMLZoMr5T
 YyFvzWDroSIVEPuoaR/TQrTorGLZK6chHtgsHS119qk8DXjgGyMYzWNX7UAsBCG0j+
 iqM1M7sYw+VkQ==
Date: Mon, 12 Aug 2024 18:48:37 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
cc: qemu-devel@nongnu.org, sstabellini@kernel.org, anthony@xenproject.org, 
 paul@xen.org, peter.maydell@linaro.org, alex.bennee@linaro.org, 
 xenia.ragiadakou@amd.com, jason.andryuk@amd.com, edgar.iglesias@amd.com, 
 xen-devel@lists.xenproject.org
Subject: Re: [PATCH v1 08/10] hw/xen: pvh-common: Add support for creating
 PCIe/GPEX
In-Reply-To: <20240812130606.90410-9-edgar.iglesias@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2408121822370.298534@ubuntu-linux-20-04-desktop>
References: <20240812130606.90410-1-edgar.iglesias@gmail.com>
 <20240812130606.90410-9-edgar.iglesias@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=sstabellini@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, 12 Aug 2024, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
> 
> Add support for optionally creating a PCIe/GPEX controller.
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
> ---
>  hw/xen/xen-pvh-common.c         | 66 +++++++++++++++++++++++++++++++++
>  include/hw/xen/xen-pvh-common.h | 10 ++++-
>  2 files changed, 75 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/xen/xen-pvh-common.c b/hw/xen/xen-pvh-common.c
> index 69a2dbdb6d..b1432e4bd9 100644
> --- a/hw/xen/xen-pvh-common.c
> +++ b/hw/xen/xen-pvh-common.c
> @@ -120,6 +120,59 @@ static void xen_enable_tpm(XenPVHCommonState *s)
>  }
>  #endif
>  
> +static void xen_set_pci_intx_irq(void *opaque, int irq, int level)
> +{
> +    if (xen_set_pci_intx_level(xen_domid, 0, 0, 0, irq, level)) {

Looking at the implementation of XEN_DMOP_set_pci_intx_level in
xen/arch/x86/hvm/dm.c, it looks like the device parameter of
xen_set_pci_intx_level is required?


> +        error_report("xendevicemodel_set_pci_intx_level failed");
> +    }
> +}
> +
> +static inline void xenpvh_gpex_init(XenPVHCommonState *s,
> +                                    MemoryRegion *sysmem,
> +                                    hwaddr ecam_base, hwaddr ecam_size,
> +                                    hwaddr mmio_base, hwaddr mmio_size,
> +                                    hwaddr mmio_high_base,
> +                                    hwaddr mmio_high_size,
> +                                    int intx_irq_base)
> +{
> +    MemoryRegion *ecam_reg;
> +    MemoryRegion *mmio_reg;
> +    DeviceState *dev;
> +    int i;
> +
> +    object_initialize_child(OBJECT(s), "gpex", &s->pci.gpex,
> +                            TYPE_GPEX_HOST);
> +    dev = DEVICE(&s->pci.gpex);
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> +
> +    ecam_reg = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
> +    memory_region_add_subregion(sysmem, ecam_base, ecam_reg);

I notice we don't use ecam_size anywhere? Is that because the size is
standard?


> +    mmio_reg = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 1);
> +
> +    if (mmio_size) {
> +        memory_region_init_alias(&s->pci.mmio_alias, OBJECT(dev), "pcie-mmio",
> +                                 mmio_reg, mmio_base, mmio_size);
> +        memory_region_add_subregion(sysmem, mmio_base, &s->pci.mmio_alias);
> +    }
> +
> +    if (mmio_high_size) {
> +        memory_region_init_alias(&s->pci.mmio_high_alias, OBJECT(dev),
> +                "pcie-mmio-high",
> +                mmio_reg, mmio_high_base, mmio_high_size);
> +        memory_region_add_subregion(sysmem, mmio_high_base,
> +                &s->pci.mmio_high_alias);
> +    }
> +
> +    for (i = 0; i < GPEX_NUM_IRQS; i++) {
> +        qemu_irq irq = qemu_allocate_irq(xen_set_pci_intx_irq, s, i);
> +
> +        sysbus_connect_irq(SYS_BUS_DEVICE(dev), i, irq);
> +        gpex_set_irq_num(GPEX_HOST(dev), i, intx_irq_base + i);
> +        xen_set_pci_link_route(i, intx_irq_base + i);

xen_set_pci_link_route is not currently implemented on ARM?

Looking at hw/i386/pc_piix.c:piix_intx_routing_notifier_xen it seems
that the routing is much more complex over there. But looking at other
machines that use GPEX such as hw/arm/virt.c it looks like the routing
is straightforward the same way as in this patch.

I thought that PCI interrupt pin swizzling was required, but maybe not ?

It is totally fine if we do something different, simpler, than
hw/i386/pc_piix.c:piix_intx_routing_notifier_xen. I just want to make
sure that things remain consistent between ARM and x86, and also between
Xen and QEMU view of virtual PCI interrupt routing.



> +    }
> +}
> +
>  static void xen_pvh_realize(DeviceState *dev, Error **errp)
>  {
>      XenPVHCommonState *s = XEN_PVH_COMMON(dev);
> @@ -152,6 +205,14 @@ static void xen_pvh_realize(DeviceState *dev, Error **errp)
>          warn_report("tpm-base-addr is not provided. TPM will not be enabled");
>      }
>  #endif
> +
> +    if (s->cfg.ecam.size) {
> +        xenpvh_gpex_init(s, sysmem,
> +                         s->cfg.ecam.base, s->cfg.ecam.size,
> +                         s->cfg.mmio.base, s->cfg.mmio.size,
> +                         s->cfg.mmio_high.base, s->cfg.mmio_high.size,
> +                         s->cfg.pci_intx_irq_base);
> +    }
>  }
>  
>  #define DEFINE_PROP_MEMMAP(n, f) \
> @@ -165,10 +226,15 @@ static Property xen_pvh_properties[] = {
>      DEFINE_PROP_MEMMAP("ram-high", ram_high),
>      DEFINE_PROP_MEMMAP("virtio-mmio", virtio_mmio),
>      DEFINE_PROP_MEMMAP("tpm", tpm),
> +    DEFINE_PROP_MEMMAP("pci-ecam", ecam),
> +    DEFINE_PROP_MEMMAP("pci-mmio", mmio),
> +    DEFINE_PROP_MEMMAP("pci-mmio-high", mmio_high),
>      DEFINE_PROP_UINT32("virtio-mmio-num", XenPVHCommonState,
>                         cfg.virtio_mmio_num, 0),
>      DEFINE_PROP_UINT32("virtio-mmio-irq-base", XenPVHCommonState,
>                         cfg.virtio_mmio_irq_base, 0),
> +    DEFINE_PROP_UINT32("pci-intx-irq-base", XenPVHCommonState,
> +                       cfg.pci_intx_irq_base, 0),
>      DEFINE_PROP_END_OF_LIST()
>  };
>  
> diff --git a/include/hw/xen/xen-pvh-common.h b/include/hw/xen/xen-pvh-common.h
> index e958b441fd..faacfca70e 100644
> --- a/include/hw/xen/xen-pvh-common.h
> +++ b/include/hw/xen/xen-pvh-common.h
> @@ -29,17 +29,25 @@ typedef struct XenPVHCommonState {
>          MemoryRegion high;
>      } ram;
>  
> +    struct {
> +        GPEXHost gpex;
> +        MemoryRegion mmio_alias;
> +        MemoryRegion mmio_high_alias;
> +    } pci;
> +
>      struct {
>          uint64_t ram_size;
>          uint32_t max_cpus;
>          uint32_t virtio_mmio_num;
>          uint32_t virtio_mmio_irq_base;
> +        uint32_t pci_intx_irq_base;
>          struct {
>              uint64_t base;
>              uint64_t size;
>          } ram_low, ram_high,
>            virtio_mmio,
> -          tpm;
> +          tpm,
> +          ecam, mmio, mmio_high;
>      } cfg;
>  } XenPVHCommonState;
>  #endif
> -- 
> 2.43.0
> 

