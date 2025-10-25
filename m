Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6405CCD1BF
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Oct 2025 00:10:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCRqZ-0004VZ-EM; Fri, 24 Oct 2025 20:09:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vCRqV-0004VG-Nl; Fri, 24 Oct 2025 20:09:23 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vCRqR-0004Zf-Gh; Fri, 24 Oct 2025 20:09:23 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 2FFE1597450;
 Sat, 25 Oct 2025 02:09:16 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id RIApMtOdvcsH; Sat, 25 Oct 2025 02:09:14 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 20D3D59744F; Sat, 25 Oct 2025 02:09:14 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 1EF99597307;
 Sat, 25 Oct 2025 02:09:14 +0200 (CEST)
Date: Sat, 25 Oct 2025 02:09:14 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 =?ISO-8859-15?Q?Herv=E9_Poussineau?= <hpoussin@reactos.org>, 
 Artyom Tarasenko <atar4qemu@gmail.com>, 
 Nicholas Piggin <npiggin@gmail.com>, Markus Armbruster <armbru@redhat.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: Re: [PATCH v5 07/13] hw/pci-host/raven: Do not use parent object
 for mmcfg region
In-Reply-To: <3ba2fb2d-1808-45de-896c-dc0cf98c549a@ilande.co.uk>
Message-ID: <d8660bad-21f1-637b-9111-059080d706d2@eik.bme.hu>
References: <cover.1761232472.git.balaton@eik.bme.hu>
 <797587b52159d2db79ed924b4962be7e7ba84207.1761232472.git.balaton@eik.bme.hu>
 <3ba2fb2d-1808-45de-896c-dc0cf98c549a@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, 24 Oct 2025, Mark Cave-Ayland wrote:
> On 23/10/2025 16:26, BALATON Zoltan wrote:
>> The mmcfg field in PCIHostState is only used by raven for the PCI
>> config direct access but is not actually needed as the memory region
>> lifetime can be managed by the object given during init so use that
>> and remove the unused field from PCIHostState.
>> 
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>>   hw/pci-host/raven.c       | 7 ++++---
>>   include/hw/pci/pci_host.h | 1 -
>>   2 files changed, 4 insertions(+), 4 deletions(-)
>> 
>> diff --git a/hw/pci-host/raven.c b/hw/pci-host/raven.c
>> index 2057a1869f..23020fd09f 100644
>> --- a/hw/pci-host/raven.c
>> +++ b/hw/pci-host/raven.c
>> @@ -216,7 +216,7 @@ static void raven_pcihost_realizefn(DeviceState *d, 
>> Error **errp)
>>       SysBusDevice *dev = SYS_BUS_DEVICE(d);
>>       PCIHostState *h = PCI_HOST_BRIDGE(dev);
>>       PREPPCIState *s = RAVEN_PCI_HOST_BRIDGE(dev);
>> -    MemoryRegion *address_space_mem = get_system_memory();
>> +    MemoryRegion *mr, *address_space_mem = get_system_memory();
>>         qdev_init_gpio_in(d, raven_change_gpio, 1);
>>   @@ -233,9 +233,10 @@ static void raven_pcihost_realizefn(DeviceState *d, 
>> Error **errp)
>>                             "pci-conf-data", 4);
>>       memory_region_add_subregion(&s->pci_io, 0xcfc, &h->data_mem);
>>   -    memory_region_init_io(&h->mmcfg, OBJECT(h), &raven_mmcfg_ops, 
>> h->bus,
>> +    mr = g_new0(MemoryRegion, 1);
>> +    memory_region_init_io(mr, OBJECT(h), &raven_mmcfg_ops, h->bus,
>>                             "pci-mmcfg", 0x00400000);
>> -    memory_region_add_subregion(address_space_mem, 0x80800000, &h->mmcfg);
>> +    memory_region_add_subregion(address_space_mem, 0x80800000, mr);
>>         memory_region_init_io(&s->pci_intack, OBJECT(s), &raven_intack_ops, 
>> s,
>>                             "pci-intack", 1);
>> diff --git a/include/hw/pci/pci_host.h b/include/hw/pci/pci_host.h
>> index 954dd446fa..a13f879872 100644
>> --- a/include/hw/pci/pci_host.h
>> +++ b/include/hw/pci/pci_host.h
>> @@ -41,7 +41,6 @@ struct PCIHostState {
>>         MemoryRegion conf_mem;
>>       MemoryRegion data_mem;
>> -    MemoryRegion mmcfg;
>>       uint32_t config_reg;
>>       bool mig_enabled;
>>       PCIBus *bus;
>
> Looking back at this patch in respect of patch 2, should RavenPCIState 
> actually be kept and mmcfg moved there instead? It feels like the wrong 
> approach simply because it isn't possible to access the MR directly from the 
> device state when debugging.

No, that's not even the same object. What I removed in patch 2 is an empty 
subclass for the PCI facing part of the host bridge which is a subclass of 
PCIDevice and this is part of the sysbus facing part (PCIHostState) that 
already has a state struct but we don't need to store this memory region 
there. Not even for debugging, because all it does is just forwarding to 
PCI (look at the read/write ops) so you can fully debug it by -trace 
enable="pci*" or add debug logs to the read/write ops if you want. We also 
don't need to put it in a state struct to free it as 
memory_region_init_io(mr, OBJECT...) takes care of that and frees it with 
the OBJECT so I don't think what you say is a real concern or should block 
this patch.

Regards,
BALATON Zoltan

