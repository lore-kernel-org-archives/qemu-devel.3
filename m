Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A6A4C04FF9
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 20:51:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvNqg-00080K-GE; Fri, 12 Apr 2024 16:50:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rvNqa-0007zT-32; Fri, 12 Apr 2024 16:50:08 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rvNqX-0006O2-S6; Fri, 12 Apr 2024 16:50:07 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id C4F294E6013;
 Fri, 12 Apr 2024 22:49:59 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id mF61I7aYWncp; Fri, 12 Apr 2024 22:49:57 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 89C504E6005; Fri, 12 Apr 2024 22:49:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 87ABF7456B4;
 Fri, 12 Apr 2024 22:49:57 +0200 (CEST)
Date: Fri, 12 Apr 2024 22:49:57 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
cc: Nicholas Piggin <npiggin@gmail.com>, 
 Peter Maydell <peter.maydell@linaro.org>, philmd@linaro.org
Subject: Re: [PATCH v2] ppc440_pcix: Do not expose a bridge device on PCI bus
In-Reply-To: <20240411192443.B4D644E6026@zero.eik.bme.hu>
Message-ID: <e373f830-0f0b-b1d3-3754-3e9f4f8cfcd8@eik.bme.hu>
References: <20240411192443.B4D644E6026@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
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

On Thu, 11 Apr 2024, BALATON Zoltan wrote:
> Real 460EX SoC apparently does not expose a bridge device and having
> it appear on PCI bus confuses an AmigaOS file system driver that uses
> this to detect which machine it is running on.
>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
> Here's another version that keeps the values and only drops the device
> so it's even less likely it could break anything, in case this can be
> accepted for 9.0.

Looks like there will be an rc4 so can this one and
https://patchew.org/QEMU/20240410222543.0EA534E6005@zero.eik.bme.hu/
be also merged for 9.0 please?

Regards,
BALATON Zoltan

> hw/pci-host/ppc440_pcix.c | 11 ++++-------
> 1 file changed, 4 insertions(+), 7 deletions(-)
>
> diff --git a/hw/pci-host/ppc440_pcix.c b/hw/pci-host/ppc440_pcix.c
> index 1926ae2a27..ef212d99aa 100644
> --- a/hw/pci-host/ppc440_pcix.c
> +++ b/hw/pci-host/ppc440_pcix.c
> @@ -52,7 +52,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(PPC440PCIXState, PPC440_PCIX_HOST)
> struct PPC440PCIXState {
>     PCIHostState parent_obj;
>
> -    PCIDevice *dev;
> +    uint8_t config[PCI_CONFIG_SPACE_SIZE];
>     struct PLBOutMap pom[PPC440_PCIX_NR_POMS];
>     struct PLBInMap pim[PPC440_PCIX_NR_PIMS];
>     uint32_t sts;
> @@ -171,7 +171,7 @@ static void ppc440_pcix_reg_write4(void *opaque, hwaddr addr,
>     trace_ppc440_pcix_reg_write(addr, val, size);
>     switch (addr) {
>     case PCI_VENDOR_ID ... PCI_MAX_LAT:
> -        stl_le_p(s->dev->config + addr, val);
> +        stl_le_p(s->config + addr, val);
>         break;
>
>     case PCIX0_POM0LAL:
> @@ -302,7 +302,7 @@ static uint64_t ppc440_pcix_reg_read4(void *opaque, hwaddr addr,
>
>     switch (addr) {
>     case PCI_VENDOR_ID ... PCI_MAX_LAT:
> -        val = ldl_le_p(s->dev->config + addr);
> +        val = ldl_le_p(s->config + addr);
>         break;
>
>     case PCIX0_POM0LAL:
> @@ -498,10 +498,7 @@ static void ppc440_pcix_realize(DeviceState *dev, Error **errp)
>     memory_region_init(&s->iomem, OBJECT(dev), "pci-io", 64 * KiB);
>     h->bus = pci_register_root_bus(dev, NULL, ppc440_pcix_set_irq,
>                          ppc440_pcix_map_irq, &s->irq, &s->busmem, &s->iomem,
> -                         PCI_DEVFN(0, 0), 1, TYPE_PCI_BUS);
> -
> -    s->dev = pci_create_simple(h->bus, PCI_DEVFN(0, 0),
> -                               TYPE_PPC4xx_HOST_BRIDGE);
> +                         PCI_DEVFN(1, 0), 1, TYPE_PCI_BUS);
>
>     memory_region_init(&s->bm, OBJECT(s), "bm-ppc440-pcix", UINT64_MAX);
>     memory_region_add_subregion(&s->bm, 0x0, &s->busmem);
>

