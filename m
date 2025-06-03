Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 562E9C5AD49
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 13:51:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMS2l-0000nz-Ef; Tue, 03 Jun 2025 09:51:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@jedlik.phy.bme.hu>)
 id 1uMS2O-0000g4-Ld; Tue, 03 Jun 2025 09:50:52 -0400
Received: from jedlik.phy.bme.hu ([152.66.102.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@jedlik.phy.bme.hu>)
 id 1uMS2B-0003X7-LM; Tue, 03 Jun 2025 09:50:36 -0400
Received: by jedlik.phy.bme.hu (Postfix, from userid 1000)
 id E5CA3A0136; Tue,  3 Jun 2025 15:50:27 +0200 (CEST)
Date: Tue, 3 Jun 2025 15:50:27 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 =?ISO-8859-15?Q?Herv=E9_Poussineau?= <hpoussin@reactos.org>, 
 Artyom Tarasenko <atar4qemu@gmail.com>, 
 Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 15/16] hw/pci-host/raven: Do not map regions in init method
In-Reply-To: <bfd1359d-2a25-4c53-9eee-cec527197f8e@linaro.org>
Message-ID: <alpine.LMD.2.03.2506031547560.13449@eik.bme.hu>
References: <cover.1746374076.git.balaton@eik.bme.hu>
 <1e85cddcd56f2431e349d21fcf6e539a663a64c3.1746374076.git.balaton@eik.bme.hu>
 <bfd1359d-2a25-4c53-9eee-cec527197f8e@linaro.org>
User-Agent: Alpine 2.03 (LMD 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
 BOUNDARY="1117279078-745840053-1748958627=:13449"
Received-SPF: pass client-ip=152.66.102.83;
 envelope-from=balaton@jedlik.phy.bme.hu; helo=jedlik.phy.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--1117279078-745840053-1748958627=:13449
Content-Type: TEXT/PLAIN; charset=UTF-8; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 3 Jun 2025, Philippe Mathieu-Daud=C3=A9 wrote:
> On 4/5/25 18:01, BALATON Zoltan wrote:
>> Export memory regions as sysbus mmio regions and let the board code
>> map them.
>>=20
>
> Why? The mapping belong to the host bridge, not the board...

I took inspiration from grackle that does it the same way.

Regards,
BALATON Zoltan

>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>>   hw/pci-host/raven.c | 37 ++++++++++++-------------------------
>>   hw/ppc/prep.c       | 11 +++++++++--
>>   2 files changed, 21 insertions(+), 27 deletions(-)
>>=20
>> diff --git a/hw/pci-host/raven.c b/hw/pci-host/raven.c
>> index 68d64e3a97..c9df3db401 100644
>> --- a/hw/pci-host/raven.c
>> +++ b/hw/pci-host/raven.c
>> @@ -49,8 +49,6 @@ struct PREPPCIState {
>>       AddressSpace bm_as;
>>   };
>>   -#define PCI_IO_BASE_ADDR    0x80000000  /* Physical address on main b=
us=20
>> */
>> -
>>   static inline uint32_t raven_idsel_to_addr(hwaddr addr)
>>   {
>>       return (ctz16(addr >> 11) << 11) | (addr & 0x7ff);
>> @@ -166,7 +164,7 @@ static void raven_change_gpio(void *opaque, int n, i=
nt=20
>> level)
>>       memory_region_set_enabled(&s->pci_discontiguous_io, !!level);
>>   }
>>   -static void raven_pcihost_realizefn(DeviceState *d, Error **errp)
>> +static void raven_pcihost_realize(DeviceState *d, Error **errp)
>>   {
>>       SysBusDevice *dev =3D SYS_BUS_DEVICE(d);
>>       PCIHostState *h =3D PCI_HOST_BRIDGE(dev);
>> @@ -176,7 +174,17 @@ static void raven_pcihost_realizefn(DeviceState *d,=
=20
>> Error **errp)
>>         qdev_init_gpio_in(d, raven_change_gpio, 1);
>>   +    memory_region_init(&s->pci_io, o, "pci-io", 0x3f800000);
>> +    memory_region_init_io(&s->pci_discontiguous_io, o,
>> +                          &raven_io_ops, &s->pci_io,
>> +                          "pci-discontiguous-io", 8 * MiB);
>> +    memory_region_init(&s->pci_memory, o, "pci-memory", 0x3f000000);
>> +
>> +    sysbus_init_mmio(dev, &s->pci_io);
>> +    sysbus_init_mmio(dev, &s->pci_discontiguous_io);
>> +    sysbus_init_mmio(dev, &s->pci_memory);
>>       sysbus_init_irq(dev, &s->irq);
>> +
>>       h->bus =3D pci_register_root_bus(d, NULL, raven_set_irq, raven_map=
_irq,
>>                                      &s->irq, &s->pci_memory, &s->pci_io=
,=20
>> 0, 1,
>>                                      TYPE_PCI_BUS);
>> @@ -215,32 +223,12 @@ static void raven_pcihost_realizefn(DeviceState *d=
,=20
>> Error **errp)
>>       pci_setup_iommu(h->bus, &raven_iommu_ops, s);
>>   }
>>   -static void raven_pcihost_initfn(Object *obj)
>> -{
>> -    PREPPCIState *s =3D RAVEN_PCI_HOST_BRIDGE(obj);
>> -    MemoryRegion *address_space_mem =3D get_system_memory();
>> -
>> -    memory_region_init(&s->pci_io, obj, "pci-io", 0x3f800000);
>> -    memory_region_init_io(&s->pci_discontiguous_io, obj,
>> -                          &raven_io_ops, &s->pci_io,
>> -                          "pci-discontiguous-io", 8 * MiB);
>> -    memory_region_init(&s->pci_memory, obj, "pci-memory", 0x3f000000);
>> -
>> -    /* CPU address space */
>> -    memory_region_add_subregion(address_space_mem, PCI_IO_BASE_ADDR,
>> -                                &s->pci_io);
>> -    memory_region_add_subregion_overlap(address_space_mem,=20
>> PCI_IO_BASE_ADDR,
>> -                                        &s->pci_discontiguous_io, 1);
>> -    memory_region_set_enabled(&s->pci_discontiguous_io, false);
>> -    memory_region_add_subregion(address_space_mem, 0xc0000000,=20
>> &s->pci_memory);
>> -}
>> -
>>   static void raven_pcihost_class_init(ObjectClass *klass, const void=20
>> *data)
>>   {
>>       DeviceClass *dc =3D DEVICE_CLASS(klass);
>>         set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
>> -    dc->realize =3D raven_pcihost_realizefn;
>> +    dc->realize =3D raven_pcihost_realize;
>>       dc->fw_name =3D "pci";
>>   }
>>   @@ -274,7 +262,6 @@ static const TypeInfo raven_types[] =3D {
>>           .name =3D TYPE_RAVEN_PCI_HOST_BRIDGE,
>>           .parent =3D TYPE_PCI_HOST_BRIDGE,
>>           .instance_size =3D sizeof(PREPPCIState),
>> -        .instance_init =3D raven_pcihost_initfn,
>>           .class_init =3D raven_pcihost_class_init,
>>       },
>>       {
>> diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
>> index d3365414d2..23d0e1eeaa 100644
>> --- a/hw/ppc/prep.c
>> +++ b/hw/ppc/prep.c
>> @@ -53,8 +53,11 @@
>>     #define CFG_ADDR 0xf0000510
>>   -#define KERNEL_LOAD_ADDR 0x01000000
>> -#define INITRD_LOAD_ADDR 0x01800000
>> +#define KERNEL_LOAD_ADDR  0x01000000
>> +#define INITRD_LOAD_ADDR  0x01800000
>> +
>> +#define PCI_IO_BASE_ADDR  0x80000000
>> +#define PCI_MEM_BASE_ADDR 0xc0000000
>>     #define BIOS_ADDR         0xfff00000
>>   #define BIOS_SIZE         (1 * MiB)
>> @@ -293,6 +296,10 @@ static void ibm_40p_init(MachineState *machine)
>>       pcihost =3D SYS_BUS_DEVICE(dev);
>>       object_property_add_child(qdev_get_machine(), "raven", OBJECT(dev)=
);
>>       sysbus_realize_and_unref(pcihost, &error_fatal);
>> +    sysbus_mmio_map(pcihost, 0, PCI_IO_BASE_ADDR);
>> +    sysbus_mmio_map_overlap(pcihost, 1, PCI_IO_BASE_ADDR, 1);
>> +    memory_region_set_enabled(sysbus_mmio_get_region(pcihost, 1), false=
);
>> +    sysbus_mmio_map(pcihost, 2, PCI_MEM_BASE_ADDR);
>>       pci_bus =3D PCI_BUS(qdev_get_child_bus(dev, "pci.0"));
>>       if (!pci_bus) {
>>           error_report("could not create PCI host controller");
>
>
--1117279078-745840053-1748958627=:13449--

