Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABB70CD98F7
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 05:25:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wa5F6-00024G-BN; Thu, 18 Jun 2026 01:24:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wa5F4-00023B-Jr
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 01:24:42 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wa5F2-00071I-Ke
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 01:24:42 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 65I5OFhD053741
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 18 Jun 2026 14:24:15 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=GLRKYmHwUgdJ6yqvzDvMBrLoQgnPOQHpq95peEmzZ84=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1781760255; v=1;
 b=kgyLeZGiLXfBP2TPTuaX/5cJY5rodOhZpAe0QBGMuCI8ml0qSZuNowGpkXdjvRG8
 072awSsF+Vz91g4FvEgLIxOd5bK04B9X54f6Sd+knCU4eFAyKb4TSClfxEZ5Jgt1
 okiRImYz0k8oYYOn7EDt9BbAK0Frwzl0BzoY0inZkb9fqJ+pq2ujjb66IKpDrETD
 KhEb2QjYVjYix/GEWOrS7Ci1yXib8uYEcOy2v6h52Wj2q2pyrRFG22aXXUzIZHz4
 QhTdCaRN5JQBOhdAt9KGHeqIjybrQWeWiQDScMs4Yl7QE4b+A8fccQzXpbU34t26
 Mo8fXExCyGhl/uRySY/hZw==
Message-ID: <c89fed00-86fd-4be3-b4a2-f4b1b9e5796b@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 18 Jun 2026 14:24:14 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 6/7] hw/isa: convert PIIX embedded QOM objects to heap
 allocated
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Herv=C3=A9_Poussineau?=
 <hpoussin@reactos.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20260616155554.264412-1-berrange@redhat.com>
 <20260616155554.264412-7-berrange@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260616155554.264412-7-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2026/06/17 0:55, Daniel P. Berrangé wrote:
> Update for the new preferred QOM design by removing embedded QOM
> objects from the PIIXState struct for the RTC, IDE, UHCI, PM,
> IRQ and memory region classes.
> 
> XXXX:  there seems to be little benefit in having any of the
> instance fields for RTC, IDE, UHCI, PM & IRQ objects.  These
> objects are all kept alive via the 'child' property which owns
> the primary reference. The instance fields are accessed durnig
> setup and then never again, so all these instances fields could
> arguably go away entirely.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   hw/isa/piix.c                 | 65 ++++++++++++++++++++++-------------
>   include/hw/southbridge/piix.h | 12 +++----
>   2 files changed, 47 insertions(+), 30 deletions(-)
> 
> diff --git a/hw/isa/piix.c b/hw/isa/piix.c
> index 31fa53e6a4..cd23486ef9 100644
> --- a/hw/isa/piix.c
> +++ b/hw/isa/piix.c
> @@ -308,18 +308,22 @@ static void pci_piix_realize(PCIDevice *dev, const char *uhci_type,
>           return;
>       }
>   
> -    memory_region_init_io(&d->rcr_mem, OBJECT(dev), &rcr_ops, d,
> -                          "piix-reset-control", 1);
> +    d->rcr_mem = memory_region_new_io(OBJECT(dev), &rcr_ops, d,
> +                                      "piix-reset-control", 1);
>       memory_region_add_subregion_overlap(pci_address_space_io(dev),
> -                                        PIIX_RCR_IOPORT, &d->rcr_mem, 1);
> +                                        PIIX_RCR_IOPORT, d->rcr_mem, 1);
>   
>       /* PIC */
>       if (d->has_pic) {
>           qemu_irq *i8259;
>   
> -        qemu_init_irq_child(OBJECT(dev), "i8259-irq", &d->i8259_irq,
> -                            piix_request_i8259_irq, d, 0);
> -        i8259 = i8259_init(isa_bus, &d->i8259_irq);
> +        d->i8259_irq = qemu_irq_new_child(OBJECT(dev), "i8259-irq",
> +                                          piix_request_i8259_irq, d, 0,
> +                                          errp);
> +        if (!d->i8259_irq) {
> +            return;
> +        }
> +        i8259 = i8259_init(isa_bus, d->i8259_irq);
>   
>           for (size_t i = 0; i < ISA_NUM_IRQS; i++) {
>               d->isa_irqs_in[i] = i8259[i];
> @@ -340,38 +344,45 @@ static void pci_piix_realize(PCIDevice *dev, const char *uhci_type,
>       i8257_dma_init(OBJECT(dev), isa_bus, 0);
>   
>       /* RTC */
> -    qdev_prop_set_int32(DEVICE(&d->rtc), "base_year", 2000);
> -    if (!qdev_realize(DEVICE(&d->rtc), BUS(isa_bus), errp)) {
> +    qdev_prop_set_int32(DEVICE(d->rtc), "base_year", 2000);
> +    if (!qdev_realize(DEVICE(d->rtc), BUS(isa_bus), errp)) {
>           return;
>       }
> -    irq = object_property_get_uint(OBJECT(&d->rtc), "irq", &error_fatal);
> -    isa_connect_gpio_out(ISA_DEVICE(&d->rtc), 0, irq);
> +    irq = object_property_get_uint(OBJECT(d->rtc), "irq", &error_fatal);
> +    isa_connect_gpio_out(ISA_DEVICE(d->rtc), 0, irq);
>   
>       /* IDE */
> -    qdev_prop_set_int32(DEVICE(&d->ide), "addr", dev->devfn + 1);
> -    if (!qdev_realize(DEVICE(&d->ide), BUS(pci_bus), errp)) {
> +    qdev_prop_set_int32(DEVICE(d->ide), "addr", dev->devfn + 1);
> +    if (!qdev_realize(DEVICE(d->ide), BUS(pci_bus), errp)) {
>           return;
>       }
>   
>       /* USB */
>       if (d->has_usb) {
> -        object_initialize_child(OBJECT(dev), "uhci", &d->uhci, uhci_type);
> -        qdev_prop_set_int32(DEVICE(&d->uhci), "addr", dev->devfn + 2);
> -        if (!qdev_realize(DEVICE(&d->uhci), BUS(pci_bus), errp)) {
> +        d->uhci = UHCI(object_new_with_props(
> +                           uhci_type, OBJECT(d), "uhci", errp, NULL));
> +        if (!d->uhci) {
> +            return;
> +        }
> +        qdev_prop_set_int32(DEVICE(d->uhci), "addr", dev->devfn + 2);
> +        if (!qdev_realize(DEVICE(d->uhci), BUS(pci_bus), errp)) {
>               return;
>           }
>       }
>   
>       /* Power Management */
>       if (d->has_acpi) {
> -        object_initialize_child(OBJECT(d), "pm", &d->pm, TYPE_PIIX4_PM);
> -        qdev_prop_set_int32(DEVICE(&d->pm), "addr", dev->devfn + 3);
> -        qdev_prop_set_uint32(DEVICE(&d->pm), "smb_io_base", d->smb_io_base);
> -        qdev_prop_set_bit(DEVICE(&d->pm), "smm-enabled", d->smm_enabled);
> -        if (!qdev_realize(DEVICE(&d->pm), BUS(pci_bus), errp)) {
> +        d->pm = PIIX4_PM(object_new_with_props(
> +                             TYPE_PIIX4_PM, OBJECT(d), "pm", errp, NULL));
> +        if (!d->pm) {
> +        }

This if block doesn't have a body.

Regards,
Akihiko Odaki

> +        qdev_prop_set_int32(DEVICE(d->pm), "addr", dev->devfn + 3);
> +        qdev_prop_set_uint32(DEVICE(d->pm), "smb_io_base", d->smb_io_base);
> +        qdev_prop_set_bit(DEVICE(d->pm), "smm-enabled", d->smm_enabled);
> +        if (!qdev_realize(DEVICE(d->pm), BUS(pci_bus), errp)) {
>               return;
>           }
> -        qdev_connect_gpio_out(DEVICE(&d->pm), 0, d->isa_irqs_in[9]);
> +        qdev_connect_gpio_out(DEVICE(d->pm), 0, d->isa_irqs_in[9]);
>       }
>   
>       pci_bus_irqs(pci_bus, piix_set_pci_irq, d, PIIX_NUM_PIRQS);
> @@ -406,7 +417,9 @@ static void pci_piix_init(Object *obj)
>       qdev_init_gpio_out_named(DEVICE(obj), d->isa_irqs_in, "isa-irqs",
>                                ISA_NUM_IRQS);
>   
> -    object_initialize_child(obj, "rtc", &d->rtc, TYPE_MC146818_RTC);
> +    d->rtc = MC146818_RTC(
> +        object_new_with_props(TYPE_MC146818_RTC, obj, "rtc",
> +                              &error_abort, NULL));
>   }
>   
>   static const Property pci_piix_props[] = {
> @@ -462,7 +475,9 @@ static void piix3_init(Object *obj)
>   {
>       PIIXState *d = PIIX_PCI_DEVICE(obj);
>   
> -    object_initialize_child(obj, "ide", &d->ide, TYPE_PIIX3_IDE);
> +    d->ide = PCI_IDE(
> +        object_new_with_props(TYPE_PIIX3_IDE, obj, "ide",
> +                              &error_abort, NULL));
>   }
>   
>   static void piix3_class_init(ObjectClass *klass, const void *data)
> @@ -492,7 +507,9 @@ static void piix4_init(Object *obj)
>   {
>       PIIXState *s = PIIX_PCI_DEVICE(obj);
>   
> -    object_initialize_child(obj, "ide", &s->ide, TYPE_PIIX4_IDE);
> +    s->ide = PCI_IDE(
> +        object_new_with_props(TYPE_PIIX4_IDE, obj, "ide",
> +                              &error_abort, NULL));
>   }
>   
>   static void piix4_class_init(ObjectClass *klass, const void *data)
> diff --git a/include/hw/southbridge/piix.h b/include/hw/southbridge/piix.h
> index a296b1205a..8bd24946de 100644
> --- a/include/hw/southbridge/piix.h
> +++ b/include/hw/southbridge/piix.h
> @@ -53,15 +53,15 @@ struct PIIXState {
>       qemu_irq cpu_intr;
>       qemu_irq isa_irqs_in[ISA_NUM_IRQS];
>   
> -    IRQState i8259_irq;
> +    IRQState *i8259_irq;
>   
>       /* This member isn't used. Just for save/load compatibility */
>       int32_t pci_irq_levels_vmstate[PIIX_NUM_PIRQS];
>   
> -    MC146818RtcState rtc;
> -    PCIIDEState ide;
> -    UHCIState uhci;
> -    PIIX4PMState pm;
> +    MC146818RtcState *rtc;
> +    PCIIDEState *ide;
> +    UHCIState *uhci;
> +    PIIX4PMState *pm;
>   
>       uint32_t smb_io_base;
>   
> @@ -69,7 +69,7 @@ struct PIIXState {
>       uint8_t rcr;
>   
>       /* IO memory region for Reset Control Register (PIIX_RCR_IOPORT) */
> -    MemoryRegion rcr_mem;
> +    MemoryRegion *rcr_mem;
>   
>       bool has_acpi;
>       bool has_pic;


