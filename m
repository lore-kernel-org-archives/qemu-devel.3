Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54054C3271E
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 00:33:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPWs9-0001VG-7a; Thu, 04 Jul 2024 20:32:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sPWs7-0001Un-Af; Thu, 04 Jul 2024 20:32:19 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sPWs5-0008HX-F5; Thu, 04 Jul 2024 20:32:19 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 6A6914E6004;
 Fri, 05 Jul 2024 02:32:13 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id 4OMt6LgTSG8t; Fri,  5 Jul 2024 02:32:11 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 6A2394E6001; Fri, 05 Jul 2024 02:32:11 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 653F0746E3B;
 Fri, 05 Jul 2024 02:32:11 +0200 (CEST)
Date: Fri, 5 Jul 2024 02:32:11 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Bernhard Beschow <shentey@gmail.com>
cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, 
 =?ISO-8859-15?Q?Herv=E9_Poussineau?= <hpoussin@reactos.org>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-ppc@nongnu.org, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 Huacai Chen <chenhuacai@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 1/3] hw/isa/vt82c686: Turn "intr" irq into a named gpio
In-Reply-To: <20240704205854.18537-2-shentey@gmail.com>
Message-ID: <5f8089ed-fb3f-d92c-0287-e055e8448677@eik.bme.hu>
References: <20240704205854.18537-1-shentey@gmail.com>
 <20240704205854.18537-2-shentey@gmail.com>
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

On Thu, 4 Jul 2024, Bernhard Beschow wrote:
> Makes the code more comprehensible, matches the datasheet and the piix4 device
> model.
>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
> hw/isa/vt82c686.c   | 2 +-
> hw/mips/fuloong2e.c | 2 +-
> hw/ppc/amigaone.c   | 4 ++--
> hw/ppc/pegasos2.c   | 4 ++--
> 4 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
> index 8582ac0322..505b44c4e6 100644
> --- a/hw/isa/vt82c686.c
> +++ b/hw/isa/vt82c686.c
> @@ -719,7 +719,7 @@ static void via_isa_realize(PCIDevice *d, Error **errp)
>     ISABus *isa_bus;
>     int i;
>
> -    qdev_init_gpio_out(dev, &s->cpu_intr, 1);
> +    qdev_init_gpio_out_named(dev, &s->cpu_intr, "intr", 1);
>     qdev_init_gpio_in_named(dev, via_isa_pirq, "pirq", PCI_NUM_PINS);
>     isa_irq = qemu_allocate_irqs(via_isa_request_i8259_irq, s, 1);
>     isa_bus = isa_bus_new(dev, pci_address_space(d), pci_address_space_io(d),
> diff --git a/hw/mips/fuloong2e.c b/hw/mips/fuloong2e.c
> index a45aac368c..6e4303ba47 100644
> --- a/hw/mips/fuloong2e.c
> +++ b/hw/mips/fuloong2e.c
> @@ -299,7 +299,7 @@ static void mips_fuloong2e_init(MachineState *machine)
>                               object_resolve_path_component(OBJECT(pci_dev),
>                                                             "rtc"),
>                               "date");
> -    qdev_connect_gpio_out(DEVICE(pci_dev), 0, env->irq[5]);
> +    qdev_connect_gpio_out_named(DEVICE(pci_dev), "intr", 0, env->irq[5]);

I was wondering why we still have 0 when we have a name so checked the doc 
commant in include/hw/qdev-core.h and found that the docs in 
qdev_connect_gpio_out_named is mostly just a copy&paste of the 
qdev_connect_gpio_out and it also talks about output GPIO array but then 
says input GPIOs in that array. I've stopped reading at that point as this 
text makes little sense. Somebody who knows how this actually works might 
want to update that doc comment.

But that's unrelated to this patch so this is

Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>

>
>     dev = DEVICE(object_resolve_path_component(OBJECT(pci_dev), "ide"));
>     pci_ide_create_devs(PCI_DEVICE(dev));
> diff --git a/hw/ppc/amigaone.c b/hw/ppc/amigaone.c
> index ddfa09457a..9dcc486c1a 100644
> --- a/hw/ppc/amigaone.c
> +++ b/hw/ppc/amigaone.c
> @@ -153,8 +153,8 @@ static void amigaone_init(MachineState *machine)
>     object_property_add_alias(OBJECT(machine), "rtc-time",
>                               object_resolve_path_component(via, "rtc"),
>                               "date");
> -    qdev_connect_gpio_out(DEVICE(via), 0,
> -                          qdev_get_gpio_in(DEVICE(cpu), PPC6xx_INPUT_INT));
> +    qdev_connect_gpio_out_named(DEVICE(via), "intr", 0,
> +                                qdev_get_gpio_in(DEVICE(cpu), PPC6xx_INPUT_INT));
>     for (i = 0; i < PCI_NUM_PINS; i++) {
>         qdev_connect_gpio_out(dev, i, qdev_get_gpio_in_named(DEVICE(via),
>                                                              "pirq", i));
> diff --git a/hw/ppc/pegasos2.c b/hw/ppc/pegasos2.c
> index c1bd8dfa21..9b0a6b70ab 100644
> --- a/hw/ppc/pegasos2.c
> +++ b/hw/ppc/pegasos2.c
> @@ -195,8 +195,8 @@ static void pegasos2_init(MachineState *machine)
>     object_property_add_alias(OBJECT(machine), "rtc-time",
>                               object_resolve_path_component(via, "rtc"),
>                               "date");
> -    qdev_connect_gpio_out(DEVICE(via), 0,
> -                          qdev_get_gpio_in_named(pm->mv, "gpp", 31));
> +    qdev_connect_gpio_out_named(DEVICE(via), "intr", 0,
> +                                qdev_get_gpio_in_named(pm->mv, "gpp", 31));
>
>     dev = PCI_DEVICE(object_resolve_path_component(via, "ide"));
>     pci_ide_create_devs(dev);
>

