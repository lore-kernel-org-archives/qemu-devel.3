Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 500CDCCD1BF
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Oct 2025 00:16:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCRwR-0005n4-4A; Fri, 24 Oct 2025 20:15:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vCRwP-0005mb-2f; Fri, 24 Oct 2025 20:15:29 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vCRwM-0005dy-Uk; Fri, 24 Oct 2025 20:15:28 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 7F161597457;
 Sat, 25 Oct 2025 02:15:24 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id zFxIlEQoRc5S; Sat, 25 Oct 2025 02:15:22 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 6449A597450; Sat, 25 Oct 2025 02:15:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 5EAA759744F;
 Sat, 25 Oct 2025 02:15:22 +0200 (CEST)
Date: Sat, 25 Oct 2025 02:15:22 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 =?ISO-8859-15?Q?Herv=E9_Poussineau?= <hpoussin@reactos.org>, 
 Artyom Tarasenko <atar4qemu@gmail.com>, 
 Nicholas Piggin <npiggin@gmail.com>, Markus Armbruster <armbru@redhat.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: Re: [PATCH v5 09/13] hw/pci-host/raven: Simpify discontiguous IO
 access
In-Reply-To: <d5b2e390-c176-4615-83ef-b457fb53bac2@ilande.co.uk>
Message-ID: <5e5698df-2d9e-b1c6-66d3-1582e835c26d@eik.bme.hu>
References: <cover.1761232472.git.balaton@eik.bme.hu>
 <1e94db358c97b16a32a56b8ae485a8056580df99.1761232473.git.balaton@eik.bme.hu>
 <d5b2e390-c176-4615-83ef-b457fb53bac2@ilande.co.uk>
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

On Fri, 24 Oct 2025, Mark Cave-Ayland wrote:
> On 23/10/2025 16:26, BALATON Zoltan wrote:
>> PREP allows remapping of the 64k ISA IO addresses from the normal
>> contiguous IO space into a discontiguous 8MB region and can switch
>> between the two modes. We can implement this in a simpler way than is
>> done currently using an io region that forwards access to the
>> contiguous pci_io region and enabling/disabling the discontiguous
>> region as needed.
>> 
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>>   hw/pci-host/raven.c | 88 ++++++++++++---------------------------------
>>   1 file changed, 22 insertions(+), 66 deletions(-)
>> 
>> diff --git a/hw/pci-host/raven.c b/hw/pci-host/raven.c
>> index bb0be40eb4..bf4f4b7f71 100644
>> --- a/hw/pci-host/raven.c
>> +++ b/hw/pci-host/raven.c
>> @@ -42,17 +42,14 @@ struct PREPPCIState {
>>       PCIHostState parent_obj;
>>         qemu_irq irq;
>> -    AddressSpace pci_io_as;
>>       MemoryRegion pci_io;
>> -    MemoryRegion pci_io_non_contiguous;
>> +    MemoryRegion pci_discontiguous_io;
>>       MemoryRegion pci_memory;
>>       MemoryRegion pci_intack;
>>       MemoryRegion bm;
>>       MemoryRegion bm_ram_alias;
>>       MemoryRegion bm_pci_memory_alias;
>>       AddressSpace bm_as;
>> -
>> -    int contiguous_map;
>>   };
>>     #define PCI_IO_BASE_ADDR    0x80000000  /* Physical address on main bus 
>> */
>> @@ -103,63 +100,28 @@ static const MemoryRegionOps raven_intack_ops = {
>>       },
>>   };
>>   -static inline hwaddr raven_io_address(PREPPCIState *s,
>> -                                      hwaddr addr)
>> +/* Convert 8 MB non-contiguous address to 64k ISA IO address */
>> +static inline hwaddr raven_io_addr(hwaddr addr)
>>   {
>> -    if (s->contiguous_map == 0) {
>> -        /* 64 KB contiguous space for IOs */
>> -        addr &= 0xFFFF;
>> -    } else {
>> -        /* 8 MB non-contiguous space for IOs */
>> -        addr = (addr & 0x1F) | ((addr & 0x007FFF000) >> 7);
>> -    }
>> -
>> -    /* FIXME: handle endianness switch */
>> -
>> -    return addr;
>> +    return ((addr & 0x007FFF000) >> 7) | (addr & 0x1F);
>>   }
>>   -static uint64_t raven_io_read(void *opaque, hwaddr addr,
>> -                              unsigned int size)
>> +static uint64_t raven_io_read(void *opaque, hwaddr addr, unsigned int 
>> size)
>>   {
>> -    PREPPCIState *s = opaque;
>> -    uint8_t buf[4];
>> -
>> -    addr = raven_io_address(s, addr);
>> -    address_space_read(&s->pci_io_as, addr + PCI_IO_BASE_ADDR,
>> -                       MEMTXATTRS_UNSPECIFIED, buf, size);
>> -
>> -    if (size == 1) {
>> -        return buf[0];
>> -    } else if (size == 2) {
>> -        return lduw_le_p(buf);
>> -    } else if (size == 4) {
>> -        return ldl_le_p(buf);
>> -    } else {
>> -        g_assert_not_reached();
>> -    }
>> +    uint64_t val = 0xffffffffULL;
>> +
>> +    memory_region_dispatch_read(opaque, raven_io_addr(addr), &val,
>> +                                size_memop(size) | MO_LE,
>> +                                MEMTXATTRS_UNSPECIFIED);
>> +    return val;
>>   }
>>   -static void raven_io_write(void *opaque, hwaddr addr,
>> -                           uint64_t val, unsigned int size)
>> +static void raven_io_write(void *opaque, hwaddr addr, uint64_t val,
>> +                           unsigned int size)
>>   {
>> -    PREPPCIState *s = opaque;
>> -    uint8_t buf[4];
>> -
>> -    addr = raven_io_address(s, addr);
>> -
>> -    if (size == 1) {
>> -        buf[0] = val;
>> -    } else if (size == 2) {
>> -        stw_le_p(buf, val);
>> -    } else if (size == 4) {
>> -        stl_le_p(buf, val);
>> -    } else {
>> -        g_assert_not_reached();
>> -    }
>> -
>> -    address_space_write(&s->pci_io_as, addr + PCI_IO_BASE_ADDR,
>> -                        MEMTXATTRS_UNSPECIFIED, buf, size);
>> +    memory_region_dispatch_write(opaque, raven_io_addr(addr), val,
>> +                                 size_memop(size) | MO_LE,
>> +                                 MEMTXATTRS_UNSPECIFIED);
>>   }
>>     static const MemoryRegionOps raven_io_ops = {
>> @@ -208,7 +170,7 @@ static void raven_change_gpio(void *opaque, int n, int 
>> level)
>>   {
>>       PREPPCIState *s = opaque;
>>   -    s->contiguous_map = level;
>> +    memory_region_set_enabled(&s->pci_discontiguous_io, !!level);
>>   }
>>     static void raven_pcihost_realizefn(DeviceState *d, Error **errp)
>> @@ -254,23 +216,17 @@ static void raven_pcihost_initfn(Object *obj)
>>       MemoryRegion *address_space_mem = get_system_memory();
>>         memory_region_init(&s->pci_io, obj, "pci-io", 0x3f800000);
>> -    memory_region_init_io(&s->pci_io_non_contiguous, obj, &raven_io_ops, 
>> s,
>> -                          "pci-io-non-contiguous", 0x00800000);
>> +    memory_region_init_io(&s->pci_discontiguous_io, obj,
>> +                          &raven_io_ops, &s->pci_io,
>> +                          "pci-discontiguous-io", 8 * MiB);
>>       memory_region_init(&s->pci_memory, obj, "pci-memory", 0x3f000000);
>> -    address_space_init(&s->pci_io_as, &s->pci_io, "raven-io");
>> -
>> -    /*
>> -     * Raven's raven_io_ops use the address-space API to access 
>> pci-conf-idx
>> -     * (which is also owned by the raven device). As such, mark the
>> -     * pci_io_non_contiguous as re-entrancy safe.
>> -     */
>> -    s->pci_io_non_contiguous.disable_reentrancy_guard = true;
>>         /* CPU address space */
>>       memory_region_add_subregion(address_space_mem, PCI_IO_BASE_ADDR,
>>                                   &s->pci_io);
>>       memory_region_add_subregion_overlap(address_space_mem, 
>> PCI_IO_BASE_ADDR,
>> -                                        &s->pci_io_non_contiguous, 1);
>> +                                        &s->pci_discontiguous_io, 1);
>> +    memory_region_set_enabled(&s->pci_discontiguous_io, false);
>>       memory_region_add_subregion(address_space_mem, 0xc0000000, 
>> &s->pci_memory);
>>         /* Bus master address space */
>
> I'm still not convinced by this one switching to use 
> memory_region_{read,write}_dispatch() functions which do not handle all 
> accesses correctly over the preferred address_space_{read,write} APIs. There 
> might be some merit in using the address_space_ld*() and address_space_st*() 
> versions though.

Which accesses does it not handle correctly and what makes address_space_* 
functions preferred over accessing the memory region?

Regards,
BALATON Zoltan

