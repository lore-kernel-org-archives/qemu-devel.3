Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EFEAC27C54
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 17:14:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFGgb-0002hM-Tn; Thu, 06 Jun 2024 13:14:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sFGgZ-0002gS-Gp; Thu, 06 Jun 2024 13:13:59 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sFGgW-0007Vj-2i; Thu, 06 Jun 2024 13:13:59 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Vw9mG37XGz6HJP4;
 Fri,  7 Jun 2024 01:09:18 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 336401402CB;
 Fri,  7 Jun 2024 01:13:40 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 6 Jun
 2024 18:13:39 +0100
Date: Thu, 6 Jun 2024 18:13:38 +0100
To: Peter Maydell <peter.maydell@linaro.org>
CC: Zhenyu Zhang <zhenyzha@redhat.com>, <qemu-arm@nongnu.org>,
 <qemu-devel@nongnu.org>, <gshan@redhat.com>, <eauger@redhat.com>,
 <sebott@redhat.com>, <cohuck@redhat.com>, <ddutile@redhat.com>,
 <shahuang@redhat.com>, Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH RFC] hw/arm/virt: Avoid unexpected warning from Linux
 guest on host with Fujitsu CPUs
Message-ID: <20240606181338.00003336@Huawei.com>
In-Reply-To: <CAFEAcA_ovHZWFi8Xn1YdPNkFjNWQ+BGQTA0Oc9oXTNuPD+bmmA@mail.gmail.com>
References: <20240606104745.291330-1-zhenyzha@redhat.com>
 <CAFEAcA_ovHZWFi8Xn1YdPNkFjNWQ+BGQTA0Oc9oXTNuPD+bmmA@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@Huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, 6 Jun 2024 12:56:59 +0100
Peter Maydell <peter.maydell@linaro.org> wrote:

> On Thu, 6 Jun 2024 at 11:48, Zhenyu Zhang <zhenyzha@redhat.com> wrote:
> >
> > Multiple warning messages and corresponding backtraces are observed when Linux
> > guest is booted on the host with Fujitsu CPUs. One of them is shown as below.
> >
> > [    0.032443] ------------[ cut here ]------------
> > [    0.032446] uart-pl011 9000000.pl011: ARCH_DMA_MINALIGN smaller than CTR_EL0.CWG (128 < 256)
> > [    0.032454] WARNING: CPU: 0 PID: 1 at arch/arm64/mm/dma-mapping.c:54 arch_setup_dma_ops+0xbc/0xcc
> > [    0.032470] Modules linked in:
> > [    0.032475] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.14.0-452.el9.aarch64 #1
> > [    0.032481] Hardware name: linux,dummy-virt (DT)
> > [    0.032484] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > [    0.032490] pc : arch_setup_dma_ops+0xbc/0xcc
> > [    0.032496] lr : arch_setup_dma_ops+0xbc/0xcc
> > [    0.032501] sp : ffff80008003b860
> > [    0.032503] x29: ffff80008003b860 x28: 0000000000000000 x27: ffffaae4b949049c
> > [    0.032510] x26: 0000000000000000 x25: 0000000000000000 x24: 0000000000000000
> > [    0.032517] x23: 0000000000000100 x22: 0000000000000000 x21: 0000000000000000
> > [    0.032523] x20: 0000000100000000 x19: ffff2f06c02ea400 x18: ffffffffffffffff
> > [    0.032529] x17: 00000000208a5f76 x16: 000000006589dbcb x15: ffffaae4ba071c89
> > [    0.032535] x14: 0000000000000000 x13: ffffaae4ba071c84 x12: 455f525443206e61
> > [    0.032541] x11: 68742072656c6c61 x10: 0000000000000029 x9 : ffffaae4b7d21da4
> > [    0.032547] x8 : 0000000000000029 x7 : 4c414e494d5f414d x6 : 0000000000000029
> > [    0.032553] x5 : 000000000000000f x4 : ffffaae4b9617a00 x3 : 0000000000000001
> > [    0.032558] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff2f06c029be40
> > [    0.032564] Call trace:
> > [    0.032566]  arch_setup_dma_ops+0xbc/0xcc
> > [    0.032572]  of_dma_configure_id+0x138/0x300
> > [    0.032591]  amba_dma_configure+0x34/0xc0
> > [    0.032600]  really_probe+0x78/0x3dc
> > [    0.032614]  __driver_probe_device+0x108/0x160
> > [    0.032619]  driver_probe_device+0x44/0x114
> > [    0.032624]  __device_attach_driver+0xb8/0x14c
> > [    0.032629]  bus_for_each_drv+0x88/0xe4
> > [    0.032634]  __device_attach+0xb0/0x1e0
> > [    0.032638]  device_initial_probe+0x18/0x20
> > [    0.032643]  bus_probe_device+0xa8/0xb0
> > [    0.032648]  device_add+0x4b4/0x6c0
> > [    0.032652]  amba_device_try_add.part.0+0x48/0x360
> > [    0.032657]  amba_device_add+0x104/0x144
> > [    0.032662]  of_amba_device_create.isra.0+0x100/0x1c4
> > [    0.032666]  of_platform_bus_create+0x294/0x35c
> > [    0.032669]  of_platform_populate+0x5c/0x150
> > [    0.032672]  of_platform_default_populate_init+0xd0/0xec
> > [    0.032697]  do_one_initcall+0x4c/0x2e0
> > [    0.032701]  do_initcalls+0x100/0x13c
> > [    0.032707]  kernel_init_freeable+0x1c8/0x21c
> > [    0.032712]  kernel_init+0x28/0x140
> > [    0.032731]  ret_from_fork+0x10/0x20
> > [    0.032735] ---[ end trace 0000000000000000 ]---
> >
> > In Linux, a check is applied to every device which is exposed through device-tree
> > node. The warning message is raised when the device isn't DMA coherent and the
> > cache line size is larger than ARCH_DMA_MINALIGN (128 bytes). The cache line is
> > sorted from CTR_EL0[CWG], which corresponds to 256 bytes on the guest CPUs.
> > The DMA coherent capability is claimed through 'dma-coherent' in their
> > device-tree nodes.  
> 
> For QEMU emulated all our DMA is always coherent, so where we
> have DMA-capable devices we should definitely tell the kernel
> that that DMA is coherent.
> 
> Our pl011 does not do DMA, though (we do not set the dmas property), so
> it's kind of bogus for the kernel to complain about that.
> 
> So I think we should take these changes where they refer to DMA
> capable devices and ask the kernel folks to fix the warnings
> where they refer to devices that aren't doing DMA. Looking through
> the patch, though, my initial impression is that all these are
> in the latter category...

I was curious and have a very slow test running, so took a look.
of_dma_configure() is being passed force_dma = true.
https://elixir.bootlin.com/linux/v6.10-rc2/source/drivers/amba/bus.c#L361

The is a comment in of_dma_configure()
		/*
		 * For legacy reasons, we have to assume some devices need
		 * DMA configuration regardless of whether "dma-ranges" is
		 * correctly specified or not.
		 */
So this I think this is being triggered by a workaround for broken DT.

This was introduced by Robin Murphy +CC though you may need to ask on
kernel list because ARM / QEMU fun.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=723288836628b

Relevant comment from that patch description:

"Certain bus types have a general expectation of
DMA capability and carry a well-established precedent that an absent
"dma-ranges" implies the same as the empty property, so we automatically
opt those in to DMA configuration regardless, to avoid regressing most
existing platforms."

The patch implies that AMBA is one of those.

So not sure this is solveable without a hack such as eliding the warning
message if dma_force was set as the situation probably isn't relevant then..

Jonathan

> 
> > diff --git a/hw/arm/boot.c b/hw/arm/boot.c
> > index d480a7da02..cdf99966e6 100644
> > --- a/hw/arm/boot.c
> > +++ b/hw/arm/boot.c
> > @@ -509,6 +509,7 @@ static void fdt_add_psci_node(void *fdt)
> >      qemu_fdt_setprop_cell(fdt, "/psci", "cpu_off", cpu_off_fn);
> >      qemu_fdt_setprop_cell(fdt, "/psci", "cpu_on", cpu_on_fn);
> >      qemu_fdt_setprop_cell(fdt, "/psci", "migrate", migrate_fn);
> > +    qemu_fdt_setprop(fdt, "/psci", "dma-coherent", NULL, 0);  
> 
> The PSCI node is describing the firmware interface for
> HVC or SMC calls -- I don't think it makes any sense
> to think of this as doing DMA. So I would query the kernel
> folks about this warning.
> 
> >  }
> >
> >  int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
> > diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> > index 3c93c0c0a6..d3e5f512e2 100644
> > --- a/hw/arm/virt.c
> > +++ b/hw/arm/virt.c
> > @@ -652,6 +652,7 @@ static void fdt_add_pmu_nodes(const VirtMachineState *vms)
> >          qemu_fdt_setprop_cells(ms->fdt, "/pmu", "interrupts",
> >                                 GIC_FDT_IRQ_TYPE_PPI,
> >                                 INTID_TO_PPI(VIRTUAL_PMU_IRQ), irqflags);
> > +        qemu_fdt_setprop(ms->fdt, "/pmu", "dma-coherent", NULL, 0);  
> 
> What DMA interface does the PMU have?
> 
> >      }
> >  }
> >
> > @@ -936,6 +937,7 @@ static void create_uart(const VirtMachineState *vms, int uart,
> >                                 vms->clock_phandle, vms->clock_phandle);
> >      qemu_fdt_setprop(ms->fdt, nodename, "clock-names",
> >                           clocknames, sizeof(clocknames));
> > +    qemu_fdt_setprop(ms->fdt, nodename, "dma-coherent", NULL, 0);  
> 
> As above, our PL011 doesn't do any DMA and we do not advertise
> to the kernel that it does.
> 
> >      if (uart == VIRT_UART) {
> >          qemu_fdt_setprop_string(ms->fdt, "/chosen", "stdout-path", nodename);
> > @@ -972,6 +974,7 @@ static void create_rtc(const VirtMachineState *vms)
> >                             GIC_FDT_IRQ_FLAGS_LEVEL_HI);
> >      qemu_fdt_setprop_cell(ms->fdt, nodename, "clocks", vms->clock_phandle);
> >      qemu_fdt_setprop_string(ms->fdt, nodename, "clock-names", "apb_pclk");
> > +    qemu_fdt_setprop(ms->fdt, nodename, "dma-coherent", NULL, 0);
> >      g_free(nodename);
> >  }  
> 
> What DMA does the pl031 do?
> 
> >
> > @@ -1077,6 +1080,7 @@ static void create_gpio_devices(const VirtMachineState *vms, int gpio,
> >      qemu_fdt_setprop_cell(ms->fdt, nodename, "clocks", vms->clock_phandle);
> >      qemu_fdt_setprop_string(ms->fdt, nodename, "clock-names", "apb_pclk");
> >      qemu_fdt_setprop_cell(ms->fdt, nodename, "phandle", phandle);
> > +    qemu_fdt_setprop(ms->fdt, nodename, "dma-coherent", NULL, 0);  
> 
> As far as I know the PL061 is also not a DMA-capable device.
> 
> >      if (gpio != VIRT_GPIO) {
> >          /* Mark as not usable by the normal world */
> > diff --git a/hw/core/sysbus-fdt.c b/hw/core/sysbus-fdt.c
> > index eebcd28f9a..da47071a95 100644
> > --- a/hw/core/sysbus-fdt.c
> > +++ b/hw/core/sysbus-fdt.c
> > @@ -554,6 +554,7 @@ void platform_bus_add_all_fdt_nodes(void *fdt, const char *intc, hwaddr addr,
> >      qemu_fdt_setprop_cells(fdt, node, "ranges", 0, addr >> 32, addr, bus_size);
> >
> >      qemu_fdt_setprop_phandle(fdt, node, "interrupt-parent", intc);
> > +    qemu_fdt_setprop(fdt, node, "dma-coherent", NULL, 0);  
> 
> Isn't this the fdt node for a bus, not a device?
> 
> thanks
> -- PMM
> 


