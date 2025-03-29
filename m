Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB48AC36008
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Mar 2025 13:19:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tyW5J-0001Gu-PE; Sat, 29 Mar 2025 09:18:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tyW5E-0001GJ-4T
 for qemu-devel@nongnu.org; Sat, 29 Mar 2025 09:18:44 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tyW59-0008LD-3t
 for qemu-devel@nongnu.org; Sat, 29 Mar 2025 09:18:43 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 661254E6031;
 Sat, 29 Mar 2025 14:18:33 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id MMfjYfMqA2Ff; Sat, 29 Mar 2025 14:18:30 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id E49144E6029; Sat, 29 Mar 2025 14:18:30 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id E2B5A74577C;
 Sat, 29 Mar 2025 14:18:30 +0100 (CET)
Date: Sat, 29 Mar 2025 14:18:30 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: rakeshj <rakeshjb010@gmail.com>, qemu-devel@nongnu.org, 
 pbonzini@redhat.com, thuth@redhat.com, marcandre.lureau@redhat.com
Subject: Re: [PATCH v2] hw/pci-host/gt64120.c: Fix PCI host bridge endianness
 handling
In-Reply-To: <5cfc6e91-b50e-4541-b924-50306459a11b@linaro.org>
Message-ID: <e4ad2e1d-4cfc-115b-5144-df389e70f027@eik.bme.hu>
References: <20250329004941.372000-1-rakeshjb010@gmail.com>
 <5cfc6e91-b50e-4541-b924-50306459a11b@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-157987653-1743254310=:12301"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-157987653-1743254310=:12301
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Sat, 29 Mar 2025, Philippe Mathieu-Daudé wrote:
> Hi Rakesh,
>
> On 29/3/25 01:49, rakeshj wrote:
>> The GT-64120 PCI controller requires special handling where:
>> 1. Host bridge (device 0) must use native endianness
>> 2. Other devices follow MByteSwap bit in GT_PCI0_CMD
>> 
>> Previous implementation accidentally swapped all accesses, breaking
>> host bridge detection (lspci -d 11ab:4620).
>> 
>> This patch:
>> - Adds custom read/write handlers to preserve native big-endian for the 
>> host
>>    bridge (phb->config_reg & 0x00fff800 == 0).
>
> Here you check for bus == 0 && device == 0, is that what you want? (I'm
> confused because you only describe "for the host bridge").
>
> If so I'd rather add a self-describing method:
>
> static bool is_phb_dev0(const PCIHostState *phb)
> {
>     return extract32(phb->config_reg, 11, 5 /* dev */ + 8 /* bus) == 0;
> }

There are already macros such as PCI_BUS_NUM PCI_FUNC. Are they any use 
instead of another function?

Regards,
BALATON Zoltan

>> - Swaps non-bridge devices when MByteSwap = 0, using size-appropriate swaps
>>    (bswap16 for 2-byte, bswap32 for 4-byte) to convert PCI's little-endian 
>> data
>>    to match the MIPS guest's big-endian expectation; no swap occurs for the 
>> host
>>    bridge or when MByteSwap = 1 (little-endian mode).
>> - Removes gt64120_update_pci_cfgdata_mapping(), moving data_mem 
>> initialization
>>    to gt64120_realize()
>> - Removes unused pci_host_data_be_ops and a misleading comment in dino.h.
>> 
>> Fixes: 145e2198 ("hw/mips/gt64xxx_pci: Endian-swap using PCI_HOST_BRIDGE 
>> MemoryRegionOps")
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2826
>> Signed-off-by: Rakesh Jeyasingh <rakeshjb010@gmail.com>
>> ---
>>   hw/pci-host/gt64120.c      | 83 ++++++++++++++++++++++----------------
>>   hw/pci/pci_host.c          |  6 ---
>>   include/hw/pci-host/dino.h |  5 +--
>>   include/hw/pci/pci_host.h  |  1 -
>>   4 files changed, 50 insertions(+), 45 deletions(-)
>> 
>> diff --git a/hw/pci-host/gt64120.c b/hw/pci-host/gt64120.c
>> index d5c13a89b6..4e45d0aa53 100644
>> --- a/hw/pci-host/gt64120.c
>> +++ b/hw/pci-host/gt64120.c
>> @@ -320,38 +320,6 @@ static void gt64120_isd_mapping(GT64120State *s)
>>       memory_region_transaction_commit();
>>   }
>>   -static void gt64120_update_pci_cfgdata_mapping(GT64120State *s)
>> -{
>> -    /* Indexed on MByteSwap bit, see Table 158: PCI_0 Command, Offset: 
>> 0xc00 */
>> -    static const MemoryRegionOps *pci_host_data_ops[] = {
>> -        &pci_host_data_be_ops, &pci_host_data_le_ops
>> -    };
>> -    PCIHostState *phb = PCI_HOST_BRIDGE(s);
>> -
>> -    memory_region_transaction_begin();
>> -
>> -    /*
>> -     * The setting of the MByteSwap bit and MWordSwap bit in the PCI 
>> Internal
>> -     * Command Register determines how data transactions from the CPU 
>> to/from
>> -     * PCI are handled along with the setting of the Endianness bit in the 
>> CPU
>> -     * Configuration Register. See:
>> -     * - Table 16: 32-bit PCI Transaction Endianness
>> -     * - Table 158: PCI_0 Command, Offset: 0xc00
>> -     */
>> -
>> -    if (memory_region_is_mapped(&phb->data_mem)) {
>> -        memory_region_del_subregion(&s->ISD_mem, &phb->data_mem);
>> -        object_unparent(OBJECT(&phb->data_mem));
>> -    }
>> -    memory_region_init_io(&phb->data_mem, OBJECT(phb),
>> -                          pci_host_data_ops[s->regs[GT_PCI0_CMD] & 1],
>> -                          s, "pci-conf-data", 4);
>> -    memory_region_add_subregion_overlap(&s->ISD_mem, GT_PCI0_CFGDATA << 2,
>> -                                        &phb->data_mem, 1);
>> -
>> -    memory_region_transaction_commit();
>> -}
>> -
>>   static void gt64120_pci_mapping(GT64120State *s)
>>   {
>>       memory_region_transaction_begin();
>> @@ -645,7 +613,6 @@ static void gt64120_writel(void *opaque, hwaddr addr,
>>       case GT_PCI0_CMD:
>>       case GT_PCI1_CMD:
>>           s->regs[saddr] = val & 0x0401fc0f;
>> -        gt64120_update_pci_cfgdata_mapping(s);
>>           break;
>>       case GT_PCI0_TOR:
>>       case GT_PCI0_BS_SCS10:
>> @@ -1024,6 +991,49 @@ static const MemoryRegionOps isd_mem_ops = {
>>       },
>>   };
>>   +static uint64_t gt64120_pci_data_read(void *opaque, hwaddr addr, 
>> unsigned size)
>> +{
>> +    GT64120State *s = opaque;
>> +    PCIHostState *phb = PCI_HOST_BRIDGE(s);
>> +    uint32_t val = pci_data_read(phb->bus, phb->config_reg, size);
>
> You check the Enable bit in the write path but not here, any reason?
>> +
>> +    /* Only swap for non-bridge devices in big-endian mode */
>> +    if (!(s->regs[GT_PCI0_CMD] & 1) && (phb->config_reg & 0x00fff800)) {
>
> Please use instead of (s->regs[GT_PCI0_CMD] & 1):
>
>  bswap = FIELD_EX32(s->regs[GT_PCI0_CMD]m GT_PCI0_CMD, MByteSwap);
>
>> +        if (size == 2) {
>> +            val = bswap16(val);
>> +        } else if (size == 4) {
>> +            val = bswap32(val);
>> +        }
>> +    }
>> +    return val;
>> +}
>> +
>> +static void gt64120_pci_data_write(void *opaque, hwaddr addr,
>> +    uint64_t val, unsigned size)
>> +{
>> +    GT64120State *s = opaque;
>> +    PCIHostState *phb = PCI_HOST_BRIDGE(s);
>> +    if (!(s->regs[GT_PCI0_CMD] & 1) && (phb->config_reg & 0x00fff800)) {
>> +        if (size == 2) {
>> +            val = bswap16(val);
>> +        } else if (size == 4) {
>> +            val = bswap32(val);
>> +        }
>> +    }
>> +    if (phb->config_reg & (1u << 31))
>> +        pci_data_write(phb->bus, phb->config_reg | (addr & 3), val, size);
>> +}
>> +
>> +static const MemoryRegionOps gt64120_pci_data_ops = {
>> +    .read = gt64120_pci_data_read,
>> +    .write = gt64120_pci_data_write,
>> +    .endianness = DEVICE_LITTLE_ENDIAN,
>> +    .valid = {
>> +        .min_access_size = 1,
>> +        .max_access_size = 4,
>> +    },
>> +};
>
> Per GT64120 rev 1.4, chapter "6.2.2 PCI Master CPU Byte Swapping":
>
>  When the GT–64120 is configured for 64-bit PCI mode, byte
>  swapping occurs across all 8 byte lanes when the ByteSwap
>  bit is set for PCI_0.
>
>>   static void gt64120_reset(DeviceState *dev)
>>   {
>>       GT64120State *s = GT64120_PCI_HOST_BRIDGE(dev);
>> @@ -1178,7 +1188,6 @@ static void gt64120_reset(DeviceState *dev)
>>         gt64120_isd_mapping(s);
>>       gt64120_pci_mapping(s);
>> -    gt64120_update_pci_cfgdata_mapping(s);
>>   }
>>     static void gt64120_realize(DeviceState *dev, Error **errp)
>> @@ -1202,6 +1211,12 @@ static void gt64120_realize(DeviceState *dev, Error 
>> **errp)
>>       memory_region_add_subregion_overlap(&s->ISD_mem, GT_PCI0_CFGADDR << 
>> 2,
>>                                           &phb->conf_mem, 1);
>>   +    memory_region_init_io(&phb->data_mem, OBJECT(phb),
>> +                          &gt64120_pci_data_ops,
>> +                          s, "pci-conf-data", 4);
>> +    memory_region_add_subregion_overlap(&s->ISD_mem, GT_PCI0_CFGDATA << 2,
>> +                                        &phb->data_mem, 1);
>> +
>>         /*
>>        * The whole address space decoded by the GT-64120A doesn't generate
>
> Please split the changes below in a distinct cleanup patch.
>
>> diff --git a/hw/pci/pci_host.c b/hw/pci/pci_host.c
>> index 80f91f409f..56f7f28a1a 100644
>> --- a/hw/pci/pci_host.c
>> +++ b/hw/pci/pci_host.c
>> @@ -217,12 +217,6 @@ const MemoryRegionOps pci_host_data_le_ops = {
>>       .endianness = DEVICE_LITTLE_ENDIAN,
>>   };
>>   -const MemoryRegionOps pci_host_data_be_ops = {
>> -    .read = pci_host_data_read,
>> -    .write = pci_host_data_write,
>> -    .endianness = DEVICE_BIG_ENDIAN,
>> -};
>> -
>>   static bool pci_host_needed(void *opaque)
>>   {
>>       PCIHostState *s = opaque;
>> diff --git a/include/hw/pci-host/dino.h b/include/hw/pci-host/dino.h
>> index fd7975c798..df509dbc18 100644
>> --- a/include/hw/pci-host/dino.h
>> +++ b/include/hw/pci-host/dino.h
>> @@ -109,10 +109,7 @@ static const uint32_t reg800_keep_bits[DINO800_REGS] = 
>> {
>>   struct DinoState {
>>       PCIHostState parent_obj;
>>   -    /*
>> -     * PCI_CONFIG_ADDR is parent_obj.config_reg, via pci_host_conf_be_ops,
>> -     * so that we can map PCI_CONFIG_DATA to pci_host_data_be_ops.
>> -     */
>> +
>>       uint32_t config_reg_dino; /* keep original copy, including 2 lowest 
>> bits */
>>         uint32_t iar0;
>> diff --git a/include/hw/pci/pci_host.h b/include/hw/pci/pci_host.h
>> index e52d8ec2cd..954dd446fa 100644
>> --- a/include/hw/pci/pci_host.h
>> +++ b/include/hw/pci/pci_host.h
>> @@ -68,6 +68,5 @@ uint32_t pci_data_read(PCIBus *s, uint32_t addr, unsigned 
>> len);
>>   extern const MemoryRegionOps pci_host_conf_le_ops;
>>   extern const MemoryRegionOps pci_host_conf_be_ops;
>>   extern const MemoryRegionOps pci_host_data_le_ops;
>> -extern const MemoryRegionOps pci_host_data_be_ops;
>>     #endif /* PCI_HOST_H */
>
>
--3866299591-157987653-1743254310=:12301--

