Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 065BECF9C5B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2024 10:05:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ssfw9-000645-Ez; Mon, 23 Sep 2024 06:04:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1ssfw7-0005w4-BQ; Mon, 23 Sep 2024 06:04:55 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1ssfw4-0002Fw-L3; Mon, 23 Sep 2024 06:04:55 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 66CBD4E600E;
 Mon, 23 Sep 2024 12:04:50 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id hBrWWCE-TPmP; Mon, 23 Sep 2024 12:04:48 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 777014E601D; Mon, 23 Sep 2024 12:04:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 73A06746F60;
 Mon, 23 Sep 2024 12:04:48 +0200 (CEST)
Date: Mon, 23 Sep 2024 12:04:48 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Bernhard Beschow <shentey@gmail.com>
cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>, 
 qemu-ppc@nongnu.org, Kevin Wolf <kwolf@redhat.com>, 
 Corey Minyard <cminyard@mvista.com>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-block@nongnu.org, 
 Nicholas Piggin <npiggin@gmail.com>, Bin Meng <bmeng.cn@gmail.com>, 
 =?ISO-8859-15?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: Re: [PATCH 02/23] hw/ppc/e500: Reduce scope of env pointer
In-Reply-To: <20240923093016.66437-3-shentey@gmail.com>
Message-ID: <87efb774-720a-9628-9335-fbec17e68d12@eik.bme.hu>
References: <20240923093016.66437-1-shentey@gmail.com>
 <20240923093016.66437-3-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

On Mon, 23 Sep 2024, Bernhard Beschow wrote:
> The env pointer isn't used outside the for loop, so move it inside. After that,
> the firstenv pointer is never read, so remove it.

It's probably the other way arouns, you remove firstenv (which is the 
bigger part of this patch) then it's clear env is not needed outside of 
the loop any more so can be moved there. The purpose of this seems to be 
to preserve the env of the first CPU but as it's unused yet maybe it can 
be removed for now and readded later when needed.

Regards,
BALATON Zoltan

> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
> hw/ppc/e500.c | 9 +--------
> 1 file changed, 1 insertion(+), 8 deletions(-)
>
> diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
> index 75b051009f..f68779a1ea 100644
> --- a/hw/ppc/e500.c
> +++ b/hw/ppc/e500.c
> @@ -899,7 +899,6 @@ void ppce500_init(MachineState *machine)
>     const PPCE500MachineClass *pmc = PPCE500_MACHINE_GET_CLASS(machine);
>     MachineClass *mc = MACHINE_CLASS(pmc);
>     PCIBus *pci_bus;
> -    CPUPPCState *env = NULL;
>     uint64_t loadaddr;
>     hwaddr kernel_base = -1LL;
>     int kernel_size = 0;
> @@ -921,7 +920,6 @@ void ppce500_init(MachineState *machine)
>     IrqLines *irqs;
>     DeviceState *dev, *mpicdev;
>     DriveInfo *dinfo;
> -    CPUPPCState *firstenv = NULL;
>     MemoryRegion *ccsr_addr_space;
>     SysBusDevice *s;
>     PPCE500CCSRState *ccsr;
> @@ -930,6 +928,7 @@ void ppce500_init(MachineState *machine)
>     irqs = g_new0(IrqLines, smp_cpus);
>     for (i = 0; i < smp_cpus; i++) {
>         PowerPCCPU *cpu;
> +        CPUPPCState *env;
>         CPUState *cs;
>
>         cpu = POWERPC_CPU(object_new(machine->cpu_type));
> @@ -950,10 +949,6 @@ void ppce500_init(MachineState *machine)
>                                  &error_abort);
>         qdev_realize_and_unref(DEVICE(cs), NULL, &error_fatal);
>
> -        if (!firstenv) {
> -            firstenv = env;
> -        }
> -
>         irqs[i].irq[OPENPIC_OUTPUT_INT] =
>             qdev_get_gpio_in(DEVICE(cpu), PPCE500_INPUT_INT);
>         irqs[i].irq[OPENPIC_OUTPUT_CINT] =
> @@ -974,8 +969,6 @@ void ppce500_init(MachineState *machine)
>         }
>     }
>
> -    env = firstenv;
> -
>     if (!QEMU_IS_ALIGNED(machine->ram_size, RAM_SIZES_ALIGN)) {
>         error_report("RAM size must be multiple of %" PRIu64, RAM_SIZES_ALIGN);
>         exit(EXIT_FAILURE);
>

