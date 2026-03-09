Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EB88FCA171
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 18:11:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzf45-0000al-DH; Mon, 09 Mar 2026 14:10:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vzf3t-0000Av-VE
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 14:10:39 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vzf3n-0007cS-Vp
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 14:10:37 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id A8A015969E7;
 Mon, 09 Mar 2026 19:10:28 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id vQ7Ohft2EVQl; Mon,  9 Mar 2026 19:10:26 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id AAD2D5969EC; Mon, 09 Mar 2026 19:10:26 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id A921C5969E5;
 Mon, 09 Mar 2026 19:10:26 +0100 (CET)
Date: Mon, 9 Mar 2026 19:10:26 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Peter Maydell <peter.maydell@linaro.org>
cc: qemu-devel@nongnu.org, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 =?ISO-8859-15?Q?Herv=E9_Poussineau?= <hpoussin@reactos.org>
Subject: Re: [PATCH] hw/isa/piix: Embed i8259 irq in device state instead of
 allocating
In-Reply-To: <20260309171258.1905205-1-peter.maydell@linaro.org>
Message-ID: <947b79c6-cd6a-945d-be07-415647c14142@eik.bme.hu>
References: <20260309171258.1905205-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, 9 Mar 2026, Peter Maydell wrote:
> The pci_piix_realize() function's use of qemu_allocate_irqs()
> results in a memory leak:
>
> Direct leak of 8 byte(s) in 1 object(s) allocated from:
>    #0 0x61045c7a1a43 in malloc (/home/pm215/qemu/build/san/qemu-system-mips+0x16f8a43) (BuildId: aa43d3865e0f1991b1fc04422b5570fe522b6fa7)
>    #1 0x724cc3095ac9 in g_malloc (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x62ac9) (BuildId: 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
>    #2 0x61045db72134 in qemu_extend_irqs /home/pm215/qemu/build/san/../../hw/core/irq.c:77:51
>    #3 0x61045cd7bf49 in pci_piix_realize /home/pm215/qemu/build/san/../../hw/isa/piix.c:318:35
>    #4 0x61045cf4533e in pci_qdev_realize /home/pm215/qemu/build/san/../../hw/pci/pci.c:2308:9
>    #5 0x61045db6cbca in device_set_realized /home/pm215/qemu/build/san/../../hw/core/qdev.c:523:13
>    #6 0x61045db86bd9 in property_set_bool /home/pm215/qemu/build/san/../../qom/object.c:2376:5
>    #7 0x61045db81c5e in object_property_set /home/pm215/qemu/build/san/../../qom/object.c:1450:5
>    #8 0x61045db8e2fc in object_property_set_qobject /home/pm215/qemu/build/san/../../qom/qom-qobject.c:28:10
>    #9 0x61045db8258f in object_property_set_bool /home/pm215/qemu/build/san/../../qom/object.c:1520:15
>    #10 0x61045db687aa in qdev_realize_and_unref /home/pm215/qemu/build/san/../../hw/core/qdev.c:283:11
>    #11 0x61045d892e21 in mips_malta_init /home/pm215/qemu/build/san/../../hw/mips/malta.c:1239:5
>
> (The i386 PC sets the has-pic property to 'false', so this only
> affects the MIPS Malta board.)
>
> Fix this by embedding the i8259 irq in the device state instead of
> allocating it.  This is a similar fix to the one we used for vt82c686
> in commit 2225dc562a93dc, except that we use qemu_init_irq_child()
> instead of qemu_init_irq().  The behaviour is identical except that
> the _child() version avoids what would be a leak if we ever
> unrealized the device.

How could it leak if it's embedded? This should be freed with PIIXState so 
I think the _child probably only affects where it shows up in qom-tree or 
I may be missing something.

> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>

> ---
> The handling of IRQs in i8259_init() is rather convoluted and forces
> its callers into having an IRQ that just forwards the set operation
> outwards. It could in theory be cleaned up, but it's used in too
> many places for that to seem worthwhile just now.

I think we've tried that before and found that the forwarder is needed to 
avoid problems with creating and connecting interrupts that need to be in 
specific order which would lead to hard to follow rules that's easy to get 
wrong so it's easier to have a forwarder that works without further 
thought. I can't find the discussion about this now but was probably 
around commit 3820001131. Or maybe it's a different issue.

Regards,
BALATON Zoltan

> ---
> hw/isa/piix.c                 | 11 ++++++-----
> include/hw/southbridge/piix.h |  3 +++
> 2 files changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/hw/isa/piix.c b/hw/isa/piix.c
> index 04b2be2cc3..31fa53e6a4 100644
> --- a/hw/isa/piix.c
> +++ b/hw/isa/piix.c
> @@ -315,12 +315,13 @@ static void pci_piix_realize(PCIDevice *dev, const char *uhci_type,
>
>     /* PIC */
>     if (d->has_pic) {
> -        qemu_irq *i8259_out_irq = qemu_allocate_irqs(piix_request_i8259_irq, d,
> -                                                     1);
> -        qemu_irq *i8259 = i8259_init(isa_bus, *i8259_out_irq);
> -        size_t i;
> +        qemu_irq *i8259;
>
> -        for (i = 0; i < ISA_NUM_IRQS; i++) {
> +        qemu_init_irq_child(OBJECT(dev), "i8259-irq", &d->i8259_irq,
> +                            piix_request_i8259_irq, d, 0);
> +        i8259 = i8259_init(isa_bus, &d->i8259_irq);
> +
> +        for (size_t i = 0; i < ISA_NUM_IRQS; i++) {
>             d->isa_irqs_in[i] = i8259[i];
>         }
>
> diff --git a/include/hw/southbridge/piix.h b/include/hw/southbridge/piix.h
> index 86709ba2e4..a296b1205a 100644
> --- a/include/hw/southbridge/piix.h
> +++ b/include/hw/southbridge/piix.h
> @@ -17,6 +17,7 @@
> #include "hw/ide/pci.h"
> #include "hw/rtc/mc146818rtc.h"
> #include "hw/usb/hcd-uhci.h"
> +#include "hw/core/irq.h"
>
> /* PIRQRC[A:D]: PIRQx Route Control Registers */
> #define PIIX_PIRQCA 0x60
> @@ -52,6 +53,8 @@ struct PIIXState {
>     qemu_irq cpu_intr;
>     qemu_irq isa_irqs_in[ISA_NUM_IRQS];
>
> +    IRQState i8259_irq;
> +
>     /* This member isn't used. Just for save/load compatibility */
>     int32_t pci_irq_levels_vmstate[PIIX_NUM_PIRQS];
>
>

