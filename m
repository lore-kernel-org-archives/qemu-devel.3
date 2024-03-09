Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AB90C54798
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Mar 2024 17:35:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rj0bN-0003ZX-BP; Sat, 09 Mar 2024 12:35:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rj0bL-0003ZJ-JN
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 12:35:15 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rj0bJ-0002Xc-2X
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 12:35:15 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id AC5644E6005;
 Sat,  9 Mar 2024 18:35:10 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id Csl6-wDZPonN; Sat,  9 Mar 2024 18:35:08 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id B1FD64E6004; Sat,  9 Mar 2024 18:35:08 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id B06BA7456B4;
 Sat,  9 Mar 2024 18:35:08 +0100 (CET)
Date: Sat, 9 Mar 2024 18:35:08 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Isaac Woods <isaacwoods.home@gmail.com>
cc: qemu-devel@nongnu.org, kraxel@redhat.com
Subject: Re: [PATCH] usb: add support for sending MSIs from EHCI PCI
 devices
In-Reply-To: <20240309151031.29417-2-isaacwoods.home@gmail.com>
Message-ID: <8f6fa543-1ab7-3df0-675f-02c7ea42054e@eik.bme.hu>
References: <20240309151031.29417-2-isaacwoods.home@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sat, 9 Mar 2024, Isaac Woods wrote:
> Signed-off-by: Isaac Woods <isaacwoods.home@gmail.com>
> ---
> hw/usb/hcd-ehci-pci.c    | 27 +++++++++++++++++++++++++++
> hw/usb/hcd-ehci-sysbus.c |  7 +++++++
> hw/usb/hcd-ehci.c        |  2 +-
> hw/usb/hcd-ehci.h        |  2 ++
> 4 files changed, 37 insertions(+), 1 deletion(-)
>
> diff --git a/hw/usb/hcd-ehci-pci.c b/hw/usb/hcd-ehci-pci.c
> index 3ff54edf62..8a714b6733 100644
> --- a/hw/usb/hcd-ehci-pci.c
> +++ b/hw/usb/hcd-ehci-pci.c
> @@ -21,6 +21,8 @@
> #include "migration/vmstate.h"
> #include "qemu/module.h"
> #include "qemu/range.h"
> +#include "hw/pci/msi.h"
> +#include "qapi/error.h"
>
> typedef struct EHCIPCIInfo {
>     const char *name;
> @@ -30,11 +32,27 @@ typedef struct EHCIPCIInfo {
>     bool companion;
> } EHCIPCIInfo;
>
> +static void ehci_pci_intr_update(EHCIState *ehci, bool enable)
> +{
> +    EHCIPCIState *s = container_of(ehci, EHCIPCIState, ehci);
> +    PCIDevice *pci_dev = PCI_DEVICE(s);
> +
> +    if (msi_enabled(pci_dev)) {
> +        if (enable) {
> +            msi_notify(pci_dev, 0);
> +        }
> +    } else {
> +        pci_set_irq(pci_dev, enable);
> +    }
> +}
> +
> static void usb_ehci_pci_realize(PCIDevice *dev, Error **errp)
> {
>     EHCIPCIState *i = PCI_EHCI(dev);
>     EHCIState *s = &i->ehci;
>     uint8_t *pci_conf = dev->config;
> +    Error *err = NULL;
> +    int ret;
>
>     pci_set_byte(&pci_conf[PCI_CLASS_PROG], 0x20);
>
> @@ -68,8 +86,17 @@ static void usb_ehci_pci_realize(PCIDevice *dev, Error **errp)
>     s->irq = pci_allocate_irq(dev);
>     s->as = pci_get_address_space(dev);
>
> +    s->intr_update = ehci_pci_intr_update;
> +
>     usb_ehci_realize(s, DEVICE(dev), NULL);
>     pci_register_bar(dev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY, &s->mem);
> +
> +    ret = msi_init(dev, 0x70, 1, true, false, &err);
> +    if (ret) {
> +        error_propagate(errp, err);
> +    } else {
> +        error_free(err);
> +    }

I could be wrong but I think you don't have to do this and can just pass 
errp to msi_init here. You might need to check if (msi_init()) { return;} 
but as this is at the end even that does not matter (althogh may worth 
adding in case something is later added after this).

Regards,
BALATON Zoltan

> }
>
> static void usb_ehci_pci_init(Object *obj)
> diff --git a/hw/usb/hcd-ehci-sysbus.c b/hw/usb/hcd-ehci-sysbus.c
> index fe1dabd0bb..e08c856e2b 100644
> --- a/hw/usb/hcd-ehci-sysbus.c
> +++ b/hw/usb/hcd-ehci-sysbus.c
> @@ -38,6 +38,11 @@ static Property ehci_sysbus_properties[] = {
>     DEFINE_PROP_END_OF_LIST(),
> };
>
> +static void usb_ehci_sysbus_intr_update(EHCIState *ehci, bool level)
> +{
> +    qemu_set_irq(s->irq, level);
> +}
> +
> static void usb_ehci_sysbus_realize(DeviceState *dev, Error **errp)
> {
>     SysBusDevice *d = SYS_BUS_DEVICE(dev);
> @@ -70,6 +75,8 @@ static void ehci_sysbus_init(Object *obj)
>     s->portnr = sec->portnr;
>     s->as = &address_space_memory;
>
> +    s->intr_update = usb_ehci_sysbus_intr_update;
> +
>     usb_ehci_init(s, DEVICE(obj));
>     sysbus_init_mmio(d, &s->mem);
> }
> diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c
> index 01864d4649..e1f71dc445 100644
> --- a/hw/usb/hcd-ehci.c
> +++ b/hw/usb/hcd-ehci.c
> @@ -209,7 +209,7 @@ static inline void ehci_update_irq(EHCIState *s)
>     }
>
>     trace_usb_ehci_irq(level, s->frindex, s->usbsts, s->usbintr);
> -    qemu_set_irq(s->irq, level);
> +    (s->intr_update)(s, level);
> }
>
> /* flag interrupt condition */
> diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h
> index 56a1c09d1f..bc017aec79 100644
> --- a/hw/usb/hcd-ehci.h
> +++ b/hw/usb/hcd-ehci.h
> @@ -305,6 +305,8 @@ struct EHCIState {
>     EHCIQueueHead aqueues;
>     EHCIQueueHead pqueues;
>
> +    void (*intr_update)(EHCIState *s, bool enable);
> +
>     /* which address to look at next */
>     uint32_t a_fetch_addr;
>     uint32_t p_fetch_addr;
>

