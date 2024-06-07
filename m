Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30C02C27C53
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2024 12:21:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFYZx-0008Ag-Vc; Fri, 07 Jun 2024 08:20:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenyzha@redhat.com>)
 id 1sFYZw-0008AI-CB
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 08:20:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenyzha@redhat.com>)
 id 1sFYZr-0005d2-0L
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 08:20:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717762812;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rSrV4j3eJBBleJVySron3BHOBwl+x5AOcM7IMz+YgsA=;
 b=SGNnZ0boJBfmdpoydVPjZ9v6b2FGNuWkR7TP52lje3KeAg9S70QXlKYZgCL4oGWEZs/AUy
 NO9Asm84rbgEmiUtiqmuTqSmhoUgTGLhnFmLDuPSwFA526ZO4oCaOAYSZYYgsdSvBGsJjG
 USFljvi9XIQNNkw9LBzffWfMrbrQD6o=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-yrVfKcfjM1Owx8zZRf3pTg-1; Fri, 07 Jun 2024 08:20:08 -0400
X-MC-Unique: yrVfKcfjM1Owx8zZRf3pTg-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a6a4615420bso93937766b.3
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2024 05:20:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717762807; x=1718367607;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rSrV4j3eJBBleJVySron3BHOBwl+x5AOcM7IMz+YgsA=;
 b=WniMxGP7+SOe5vVV1L9ahPgf5Cc+QRpbVaviv8zdd0PU2FgbDSeOLQyXDcG7bCYNJp
 SG8PtJJTVbDdSp+rsdHPTuOMJVz5r37uFMB3/7VIpb72Z11lWbVKAJ0NDNOxEEhepOtg
 67vytQnRZWrV3sKKkLB/kKZt4dEbO6tF4AubnNDmzQCJuFhNhW7O5Vb0Uc+kYpeLNSer
 ox84rn5OeLgZvU6Rh1MDywS/99xLu2+utATLmUWLJU/wMuncp83NaFwc0SK2OJRRrOGz
 2G5qN6ukEZZtkU8s/0C/L9v9zPsOS5dRYNshiCzF/izBh2+VStB9XuOZ1SaPop2fNyWU
 tMRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCMRlKJTfrVqVlF32mcyaulVqVa/pqjk/y5lpGKtKbc+BQ7zqOwn26CHPN05yIHJHHA+e1XiWMvHmbAt4HTpXIWdN7h7Q=
X-Gm-Message-State: AOJu0Yzff2jAceLB9gL6nLDhTe/liE4j0+elpuRbDfbF0dr+byt8djmB
 38+YcTI5xbFKEsfCrzPLjdtgIMmprNudS10wEyAfsS3044HQc5R7IU0dk2AYSt5PcqARzVJR9Zh
 sFTs0Gz9JE+vdWPBbbEuGkwHJGkHyp3L+QG4IToKuhQ1jFJyOUypRCvi/QiLXOjvxT2AAVcFbMO
 Il2RW8ql5ZsksfuzXb8Ah3G8r9McY=
X-Received: by 2002:a17:906:b357:b0:a68:e21b:35f0 with SMTP id
 a640c23a62f3a-a6cd789201emr168116466b.38.1717762807125; 
 Fri, 07 Jun 2024 05:20:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExPEC0f78zBo/CwFgBTK28p35LEgpEwnQhwMYPpS+sWrd/Z5jpVOXhd1tira/ZjwIfB7iIqdDMqOCo3jr+/Fw=
X-Received: by 2002:a17:906:b357:b0:a68:e21b:35f0 with SMTP id
 a640c23a62f3a-a6cd789201emr168111866b.38.1717762805370; Fri, 07 Jun 2024
 05:20:05 -0700 (PDT)
MIME-Version: 1.0
References: <20240606104745.291330-1-zhenyzha@redhat.com>
 <CAFEAcA_ovHZWFi8Xn1YdPNkFjNWQ+BGQTA0Oc9oXTNuPD+bmmA@mail.gmail.com>
In-Reply-To: <CAFEAcA_ovHZWFi8Xn1YdPNkFjNWQ+BGQTA0Oc9oXTNuPD+bmmA@mail.gmail.com>
From: Zhenyu Zhang <zhenyzha@redhat.com>
Date: Fri, 7 Jun 2024 20:19:27 +0800
Message-ID: <CAJFLiBKm2PA1_KrXATPPHHvzp-Rm-wyP0nXDYk9Lwua7fft5cw@mail.gmail.com>
Subject: Re: [PATCH RFC] hw/arm/virt: Avoid unexpected warning from Linux
 guest on host with Fujitsu CPUs
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, gshan@redhat.com, 
 eauger@redhat.com, sebott@redhat.com, cohuck@redhat.com, ddutile@redhat.com, 
 shahuang@redhat.com, robin.murphy@arm.com, Jonathan.Cameron@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=zhenyzha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Thu, Jun 6, 2024 at 7:57=E2=80=AFPM Peter Maydell <peter.maydell@linaro.=
org> wrote:
>
> On Thu, 6 Jun 2024 at 11:48, Zhenyu Zhang <zhenyzha@redhat.com> wrote:
> >
> > Multiple warning messages and corresponding backtraces are observed whe=
n Linux
> > guest is booted on the host with Fujitsu CPUs. One of them is shown as =
below.
> >
> > [    0.032443] ------------[ cut here ]------------
> > [    0.032446] uart-pl011 9000000.pl011: ARCH_DMA_MINALIGN smaller than=
 CTR_EL0.CWG (128 < 256)
> > [    0.032454] WARNING: CPU: 0 PID: 1 at arch/arm64/mm/dma-mapping.c:54=
 arch_setup_dma_ops+0xbc/0xcc
> > [    0.032470] Modules linked in:
> > [    0.032475] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.14.0-452.el9=
.aarch64 #1
> > [    0.032481] Hardware name: linux,dummy-virt (DT)
> > [    0.032484] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BT=
YPE=3D--)
> > [    0.032490] pc : arch_setup_dma_ops+0xbc/0xcc
> > [    0.032496] lr : arch_setup_dma_ops+0xbc/0xcc
> > [    0.032501] sp : ffff80008003b860
> > [    0.032503] x29: ffff80008003b860 x28: 0000000000000000 x27: ffffaae=
4b949049c
> > [    0.032510] x26: 0000000000000000 x25: 0000000000000000 x24: 0000000=
000000000
> > [    0.032517] x23: 0000000000000100 x22: 0000000000000000 x21: 0000000=
000000000
> > [    0.032523] x20: 0000000100000000 x19: ffff2f06c02ea400 x18: fffffff=
fffffffff
> > [    0.032529] x17: 00000000208a5f76 x16: 000000006589dbcb x15: ffffaae=
4ba071c89
> > [    0.032535] x14: 0000000000000000 x13: ffffaae4ba071c84 x12: 455f525=
443206e61
> > [    0.032541] x11: 68742072656c6c61 x10: 0000000000000029 x9 : ffffaae=
4b7d21da4
> > [    0.032547] x8 : 0000000000000029 x7 : 4c414e494d5f414d x6 : 0000000=
000000029
> > [    0.032553] x5 : 000000000000000f x4 : ffffaae4b9617a00 x3 : 0000000=
000000001
> > [    0.032558] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff2f0=
6c029be40
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
> > In Linux, a check is applied to every device which is exposed through d=
evice-tree
> > node. The warning message is raised when the device isn't DMA coherent =
and the
> > cache line size is larger than ARCH_DMA_MINALIGN (128 bytes). The cache=
 line is
> > sorted from CTR_EL0[CWG], which corresponds to 256 bytes on the guest C=
PUs.
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
My initial thought was to fix it in the kernel too.
However, through preliminary research, I discovered some
'legacy reasons' mentioned in the discussion above.
So I'm worried that the fix will bring new risks.

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
Thanks a lot for your help!
>
> >  }
> >
> >  int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
> > diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> > index 3c93c0c0a6..d3e5f512e2 100644
> > --- a/hw/arm/virt.c
> > +++ b/hw/arm/virt.c
> > @@ -652,6 +652,7 @@ static void fdt_add_pmu_nodes(const VirtMachineStat=
e *vms)
> >          qemu_fdt_setprop_cells(ms->fdt, "/pmu", "interrupts",
> >                                 GIC_FDT_IRQ_TYPE_PPI,
> >                                 INTID_TO_PPI(VIRTUAL_PMU_IRQ), irqflags=
);
> > +        qemu_fdt_setprop(ms->fdt, "/pmu", "dma-coherent", NULL, 0);
>
> What DMA interface does the PMU have?
]# dmesg | grep PMU
hw perfevents: enabled with armv8_pmuv3_0 PMU driver, 9 counters available

>
> >      }
> >  }
> >
> > @@ -936,6 +937,7 @@ static void create_uart(const VirtMachineState *vms=
, int uart,
> >                                 vms->clock_phandle, vms->clock_phandle)=
;
> >      qemu_fdt_setprop(ms->fdt, nodename, "clock-names",
> >                           clocknames, sizeof(clocknames));
> > +    qemu_fdt_setprop(ms->fdt, nodename, "dma-coherent", NULL, 0);
>
> As above, our PL011 doesn't do any DMA and we do not advertise
> to the kernel that it does.
Indeed so.

>
> >      if (uart =3D=3D VIRT_UART) {
> >          qemu_fdt_setprop_string(ms->fdt, "/chosen", "stdout-path", nod=
ename);
> > @@ -972,6 +974,7 @@ static void create_rtc(const VirtMachineState *vms)
> >                             GIC_FDT_IRQ_FLAGS_LEVEL_HI);
> >      qemu_fdt_setprop_cell(ms->fdt, nodename, "clocks", vms->clock_phan=
dle);
> >      qemu_fdt_setprop_string(ms->fdt, nodename, "clock-names", "apb_pcl=
k");
> > +    qemu_fdt_setprop(ms->fdt, nodename, "dma-coherent", NULL, 0);
> >      g_free(nodename);
> >  }
>
> What DMA does the pl031 do?
I hit the warning on rtc-pl031

[    2.176009] ------------[ cut here ]------------
[    2.177959] rtc-pl031 9010000.pl031: ARCH_DMA_MINALIGN smaller than
CTR_EL0.CWG (128 < 256)
[    2.177975] WARNING: CPU: 0 PID: 1 at
arch/arm64/mm/dma-mapping.c:54 arch_setup_dma_ops+0xc0/0xe0
[    2.177998] Modules linked in:
[    2.178006] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G S
  -------  ---  6.9.0-7.el10.aarch64 #1
[    2.178015] Hardware name: linux,dummy-virt (DT)
[    2.178020] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=
=3D--)
[    2.178028] pc : arch_setup_dma_ops+0xc0/0xe0
[    2.178037] lr : arch_setup_dma_ops+0xc0/0xe0
[    2.178044] sp : ffff80008003bac0
[    2.178048] x29: ffff80008003bac0 x28: 0000000000000000 x27: 00000000000=
00000
[    2.178059] x26: 0000000000000000 x25: 0000000000000000 x24: 00000000fff=
fffed
[    2.178070] x23: 0000000000000000 x22: 0000000000000100 x21: 00000000000=
00000
[    2.178080] x20: 0000000100000000 x19: ffff277b80311400 x18: fffffffffff=
fffff
[    2.178091] x17: 000000002e2c3887 x16: 000000006b071b85 x15: ffffab158b0=
e45eb
[    2.178101] x14: 0000000000000000 x13: ffffab158b0e45f0 x12: ffffab158ad=
ec6c0
[    2.178112] x11: ffffab158ab2c718 x10: ffffab158adec718 x9 : ffffab15889=
4a9d0
[    2.178122] x8 : 0000000000000001 x7 : 00000000000bffe8 x6 : c0000000fff=
f7fff
[    2.178132] x5 : 00000000002bffa8 x4 : ffffab158ab2c4c8 x3 : 00000000000=
00001
[    2.178142] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff277b802=
c2a00
[    2.178152] Call trace:
[    2.178155]  arch_setup_dma_ops+0xc0/0xe0
[    2.178164]  of_dma_configure_id+0x29c/0x3f0
[    2.178178]  amba_dma_configure+0x38/0xd0
[    2.178188]  really_probe+0x7c/0x3a0
[    2.178196]  __driver_probe_device+0x84/0x160
[    2.178202]  driver_probe_device+0x44/0x130
[    2.178208]  __driver_attach+0xcc/0x208
[    2.178214]  bus_for_each_dev+0x84/0x100
[    2.178223]  driver_attach+0x2c/0x40
[    2.178229]  bus_add_driver+0x11c/0x238
[    2.178237]  driver_register+0x70/0x138
[    2.178244]  amba_driver_register+0x2c/0x48
[    2.178251]  pl031_driver_init+0x20/0x38
[    2.178260]  do_one_initcall+0x60/0x378
[    2.178268]  do_initcalls+0x114/0x158
[    2.178277]  kernel_init_freeable+0x1c4/0x228
[    2.178284]  kernel_init+0x28/0x158
[    2.178292]  ret_from_fork+0x10/0x20
[    2.178299] ---[ end trace 0000000000000000 ]---
[    2.178951] rtc-pl031 9010000.pl031: registered as rtc0
[    2.270706] rtc-pl031 9010000.pl031: setting system clock to
2024-06-07T08:14:37 UTC (1717748077)
[    2.282868] hid: raw HID events driver (C) Jiri Kosina
[    2.285235] usbcore: registered new interface driver usbhid
[    2.287579] usbhid: USB HID core driver

>
> >
> > @@ -1077,6 +1080,7 @@ static void create_gpio_devices(const VirtMachine=
State *vms, int gpio,
> >      qemu_fdt_setprop_cell(ms->fdt, nodename, "clocks", vms->clock_phan=
dle);
> >      qemu_fdt_setprop_string(ms->fdt, nodename, "clock-names", "apb_pcl=
k");
> >      qemu_fdt_setprop_cell(ms->fdt, nodename, "phandle", phandle);
> > +    qemu_fdt_setprop(ms->fdt, nodename, "dma-coherent", NULL, 0);
>
> As far as I know the PL061 is also not a DMA-capable device.
For the same reason, this is the warning I hit on pl061_gpio

[    1.479175] ------------[ cut here ]------------
[    1.570587] pl061_gpio 9030000.pl061: ARCH_DMA_MINALIGN smaller
than CTR_EL0.CWG (128 < 256)
[    1.570606] WARNING: CPU: 0 PID: 1 at
arch/arm64/mm/dma-mapping.c:54 arch_setup_dma_ops+0xc0/0xe0
[    1.570629] Modules linked in:
[    1.570638] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G S
  -------  ---  6.9.0-7.el10.aarch64 #1
[    1.570646] Hardware name: linux,dummy-virt (DT)
[    1.570652] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=
=3D--)
[    1.570660] pc : arch_setup_dma_ops+0xc0/0xe0
[    1.570669] lr : arch_setup_dma_ops+0xc0/0xe0
[    1.570677] sp : ffff80008003bac0
[    1.570680] x29: ffff80008003bac0 x28: 0000000000000000 x27: 00000000000=
00000
[    1.570691] x26: 0000000000000000 x25: 0000000000000000 x24: 00000000fff=
fffed
[    1.570702] x23: 0000000000000000 x22: 0000000000000100 x21: 00000000000=
00000
[    1.570712] x20: 0000000100000000 x19: ffff277b8030c000 x18: fffffffffff=
fffff
[    1.570723] x17: 3061326332303862 x16: 3737326666666620 x15: ffffab158b0=
e1524
[    1.570733] x14: 0000000000000000 x13: ffffab158b0e1529 x12: ffffab158ad=
ec6c0
[    1.570743] x11: ffffab158ab2c718 x10: ffffab158adec718 x9 : ffffab15889=
4a9d0
[    1.570754] x8 : 0000000000000001 x7 : 00000000000bffe8 x6 : c0000000fff=
f7fff
[    1.570764] x5 : 00000000002bffa8 x4 : ffffab158ab2c4c8 x3 : 00000000000=
00001
[    1.570773] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff277b802=
c2a00
[    1.570783] Call trace:
[    1.570787]  arch_setup_dma_ops+0xc0/0xe0
[    1.570796]  of_dma_configure_id+0x29c/0x3f0
[    1.570810]  amba_dma_configure+0x38/0xd0
[    1.570820]  really_probe+0x7c/0x3a0
[    1.570828]  __driver_probe_device+0x84/0x160
[    1.570834]  driver_probe_device+0x44/0x130
[    1.570839]  __driver_attach+0xcc/0x208
[    1.570845]  bus_for_each_dev+0x84/0x100
[    1.570855]  driver_attach+0x2c/0x40
[    1.570860]  bus_add_driver+0x11c/0x238
[    1.570868]  driver_register+0x70/0x138
[    1.570875]  amba_driver_register+0x2c/0x48
[    1.570882]  pl061_gpio_driver_init+0x20/0x38
[    1.570895]  do_one_initcall+0x60/0x378
[    1.570902]  do_initcalls+0x114/0x158
[    1.570911]  kernel_init_freeable+0x1c4/0x228
[    1.570918]  kernel_init+0x28/0x158
[    1.570926]  ret_from_fork+0x10/0x20
[    1.570934] ---[ end trace 0000000000000000 ]---

>
> >      if (gpio !=3D VIRT_GPIO) {
> >          /* Mark as not usable by the normal world */
> > diff --git a/hw/core/sysbus-fdt.c b/hw/core/sysbus-fdt.c
> > index eebcd28f9a..da47071a95 100644
> > --- a/hw/core/sysbus-fdt.c
> > +++ b/hw/core/sysbus-fdt.c
> > @@ -554,6 +554,7 @@ void platform_bus_add_all_fdt_nodes(void *fdt, cons=
t char *intc, hwaddr addr,
> >      qemu_fdt_setprop_cells(fdt, node, "ranges", 0, addr >> 32, addr, b=
us_size);
> >
> >      qemu_fdt_setprop_phandle(fdt, node, "interrupt-parent", intc);
> > +    qemu_fdt_setprop(fdt, node, "dma-coherent", NULL, 0);
>
> Isn't this the fdt node for a bus, not a device?
Yes, since I hit the same warning messages.
So I want to fix it together.
Sorry for not describing it clearly.

[    1.476145] ------------[ cut here ]------------
[    1.478210] simple-pm-bus platform-bus@c000000: ARCH_DMA_MINALIGN
smaller than CTR_EL0.CWG (128 < 256)
[    1.478225] WARNING: CPU: 0 PID: 1 at
arch/arm64/mm/dma-mapping.c:54 arch_setup_dma_ops+0xc0/0xe0
[    1.478248] Modules linked in:
[    1.478257] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G S
  -------  ---  6.9.0-7.el10.aarch64 #1
[    1.478266] Hardware name: linux,dummy-virt (DT)
[    1.478270] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=
=3D--)
[    1.478279] pc : arch_setup_dma_ops+0xc0/0xe0
[    1.478287] lr : arch_setup_dma_ops+0xc0/0xe0
[    1.478295] sp : ffff80008003bac0
[    1.478299] x29: ffff80008003bac0 x28: 0000000000000000 x27: 00000000000=
00000
[    1.478310] x26: 0000000000000000 x25: 0000000000000000 x24: 00000000fff=
fffed
[    1.478321] x23: 0000000000000000 x22: 0000000000000100 x21: 00000000000=
00000
[    1.478331] x20: 0000000100000000 x19: ffff277b80300010 x18: fffffffffff=
fffff
[    1.478342] x17: 0000000098c949f4 x16: 00000000099ae637 x15: ffffab158b0=
e0c2e
[    1.478352] x14: 0000000000000000 x13: ffffab158b0e0c33 x12: ffffab158ad=
ec6c0
[    1.478363] x11: ffffab158ab2c718 x10: ffffab158adec718 x9 : ffffab15889=
4a9d0
[    1.478373] x8 : 0000000000000001 x7 : 00000000000bffe8 x6 : c0000000fff=
f7fff
[    1.478383] x5 : 00000000002bffa8 x4 : ffffab158ab2c4c8 x3 : 00000000000=
00001
[    1.478393] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff277b802=
c2a00
[    1.478403] Call trace:
[    1.478406]  arch_setup_dma_ops+0xc0/0xe0
[    1.478415]  of_dma_configure_id+0x29c/0x3f0
[    1.478429]  platform_dma_configure+0x108/0x120
[    1.478439]  really_probe+0x7c/0x3a0
[    1.478445]  __driver_probe_device+0x84/0x160
[    1.478451]  driver_probe_device+0x44/0x130
[    1.478457]  __driver_attach+0xcc/0x208
[    1.478462]  bus_for_each_dev+0x84/0x100
[    1.478472]  driver_attach+0x2c/0x40
[    1.478477]  bus_add_driver+0x11c/0x238
[    1.478485]  driver_register+0x70/0x138
[    1.478491]  __platform_driver_register+0x30/0x48
[    1.478498]  simple_pm_bus_driver_init+0x24/0x38
[    1.478511]  do_one_initcall+0x60/0x378
[    1.478518]  do_initcalls+0x114/0x158
[    1.478527]  kernel_init_freeable+0x1c4/0x228
[    1.478534]  kernel_init+0x28/0x158
[    1.478542]  ret_from_fork+0x10/0x20
[    1.478550] ---[ end trace 0000000000000000 ]---
[    1.479175] ------------[ cut here ]------------

>
> thanks
> -- PMM
>


