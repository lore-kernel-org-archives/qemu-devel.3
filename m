Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06184CD11C2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 11:04:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruVkC-00011c-RM; Wed, 10 Apr 2024 07:03:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1ruVkA-00011H-IN; Wed, 10 Apr 2024 07:03:54 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1ruVk5-0006rG-VK; Wed, 10 Apr 2024 07:03:53 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id DCC8F4E601C;
 Wed, 10 Apr 2024 13:03:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id MU4Pys85kDK0; Wed, 10 Apr 2024 13:03:43 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id E37334E6027; Wed, 10 Apr 2024 13:03:43 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id E01487456B4;
 Wed, 10 Apr 2024 13:03:43 +0200 (CEST)
Date: Wed, 10 Apr 2024 13:03:43 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Nicholas Piggin <npiggin@gmail.com>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>, philmd@linaro.org
Subject: Re: [PATCH for-9.0] ppc440_pcix: Do not expose a bridge device on
 PCI bus
In-Reply-To: <D0G5YFXXNK98.3NO5536V5LC8N@gmail.com>
Message-ID: <887fc804-54a6-8f00-1b62-afcf247ba319@eik.bme.hu>
References: <20240409235543.0E0C34E601C@zero.eik.bme.hu>
 <D0G5YFXXNK98.3NO5536V5LC8N@gmail.com>
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

On Wed, 10 Apr 2024, Nicholas Piggin wrote:
> On Wed Apr 10, 2024 at 9:55 AM AEST, BALATON Zoltan wrote:
>> Real 460EX SoC apparently does not expose a bridge device and having
>> it appear on PCI bus confuses an AmigaOS file system driver that uses
>> this to detect which machine it is running on. Since values written
>> here by firmware are never read, just ignore these writes and drop the
>> bridge device.
>>
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>> This is only used by sam460ex and this fixes an issue with AmigaOS on
>> this machine so I'd like this to be merged for 9.0 please.
>
> Is it a regression? Does it have a fixes: or resolves: tag?
>
> Unless we broke it in this cycle, I would be inclined to wait,
> and we can ask to put it in stable.

It's not something that broke in this cycle but since this does not affect 
anything else than sam460ex I think it's OK to change this for 9.0. The 
changes to 440 tlb in this cycle made sam460ex more useful to run AmigaOS 
and this fixes the file system driver on it so it would make 9.0 really 
usable. Otherwise people would have to wait longer until August or install 
a stable update. Since this has low chance to break anything (tested with 
AmogaOS and Linux and MorphOS does not boot due to do_io changes anyway) I 
don't think we have to wait with this.

Regards,
BALATON Zoltan

> Thanks,
> Nick
>
>>
>>  hw/pci-host/ppc440_pcix.c | 14 +-------------
>>  1 file changed, 1 insertion(+), 13 deletions(-)
>>
>> diff --git a/hw/pci-host/ppc440_pcix.c b/hw/pci-host/ppc440_pcix.c
>> index 1926ae2a27..ba38172989 100644
>> --- a/hw/pci-host/ppc440_pcix.c
>> +++ b/hw/pci-host/ppc440_pcix.c
>> @@ -52,7 +52,6 @@ OBJECT_DECLARE_SIMPLE_TYPE(PPC440PCIXState, PPC440_PCIX_HOST)
>>  struct PPC440PCIXState {
>>      PCIHostState parent_obj;
>>
>> -    PCIDevice *dev;
>>      struct PLBOutMap pom[PPC440_PCIX_NR_POMS];
>>      struct PLBInMap pim[PPC440_PCIX_NR_PIMS];
>>      uint32_t sts;
>> @@ -170,10 +169,6 @@ static void ppc440_pcix_reg_write4(void *opaque, hwaddr addr,
>>
>>      trace_ppc440_pcix_reg_write(addr, val, size);
>>      switch (addr) {
>> -    case PCI_VENDOR_ID ... PCI_MAX_LAT:
>> -        stl_le_p(s->dev->config + addr, val);
>> -        break;
>> -
>>      case PCIX0_POM0LAL:
>>          s->pom[0].la &= 0xffffffff00000000ULL;
>>          s->pom[0].la |= val;
>> @@ -301,10 +296,6 @@ static uint64_t ppc440_pcix_reg_read4(void *opaque, hwaddr addr,
>>      uint32_t val;
>>
>>      switch (addr) {
>> -    case PCI_VENDOR_ID ... PCI_MAX_LAT:
>> -        val = ldl_le_p(s->dev->config + addr);
>> -        break;
>> -
>>      case PCIX0_POM0LAL:
>>          val = s->pom[0].la;
>>          break;
>> @@ -498,10 +489,7 @@ static void ppc440_pcix_realize(DeviceState *dev, Error **errp)
>>      memory_region_init(&s->iomem, OBJECT(dev), "pci-io", 64 * KiB);
>>      h->bus = pci_register_root_bus(dev, NULL, ppc440_pcix_set_irq,
>>                           ppc440_pcix_map_irq, &s->irq, &s->busmem, &s->iomem,
>> -                         PCI_DEVFN(0, 0), 1, TYPE_PCI_BUS);
>> -
>> -    s->dev = pci_create_simple(h->bus, PCI_DEVFN(0, 0),
>> -                               TYPE_PPC4xx_HOST_BRIDGE);
>> +                         PCI_DEVFN(1, 0), 1, TYPE_PCI_BUS);
>>
>>      memory_region_init(&s->bm, OBJECT(s), "bm-ppc440-pcix", UINT64_MAX);
>>      memory_region_add_subregion(&s->bm, 0x0, &s->busmem);
>
>
>

