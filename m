Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05BDCC25B7C
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 12:09:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBZ9X-0002nx-V5; Mon, 27 May 2024 08:08:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bjorn@kernel.org>)
 id 1sBZ9S-0002n4-PB; Mon, 27 May 2024 08:08:32 -0400
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bjorn@kernel.org>)
 id 1sBZ9P-0000Jj-0r; Mon, 27 May 2024 08:08:30 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 3A91661539;
 Mon, 27 May 2024 12:08:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D366C2BBFC;
 Mon, 27 May 2024 12:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1716811704;
 bh=qIMa/xuUiwpJX/jPycyINr04sXFpaWfLmm6i3tz96OA=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=DsIu0M6t4mKzhocpq7CKET8wsgy16c2SfcPxza4FjbL6mZZGmnO4G7lPFPtqC1rKO
 kkNbO+INSdsb2irymKh0EKk3rvYCJZ4LVu9JI/Oc1d15EF+dyPer5zoSz+d7KuyPNT
 TSyI+4ZRLqNZe0VfIeFm7DITvnLyq6PYBEkflhlBmwyDULp1Ce+R1pCOWIhnF9FDOS
 844ttYaw4w/5jmaGUAFCnVZ9GbXwjHwxch5fYDR7AE6xea3v2k4F0A9wX5aCg+uqN+
 oi3wly/BVP/4jjfkIyK7oZWfiWGXmzcsad9XBOHSPQcMcbqtctqr1L4JGa+uGlwfXl
 Lc4xflh2zSFlA==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Alistair Francis <alistair.francis@wdc.com>, Bin
 Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>, Atish Patra
 <atishp@atishpatra.org>, Atish Patra <atishp@rivosinc.com>
Cc: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, Sunil V L
 <sunilvl@ventanamicro.com>,
 Santosh Mamila <santosh.mamila@catalinasystems.io>, Chethan Seshadri
 <Chethan.Seshadri@catalinasystems.io>, Sivakumar Munnangi
 <siva.munnangi@catalinasystems.io>
Subject: Re: [PATCH v2 3/3] hw/riscv/virt: Add ACPI GED and PC-DIMM MHP support
In-Reply-To: <40ae0cb9-1596-4cec-994c-71e0abaa0d1e@ventanamicro.com>
References: <20240521105635.795211-1-bjorn@kernel.org>
 <20240521105635.795211-4-bjorn@kernel.org>
 <40ae0cb9-1596-4cec-994c-71e0abaa0d1e@ventanamicro.com>
Date: Mon, 27 May 2024 14:08:21 +0200
Message-ID: <87o78r8nka.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=139.178.84.217; envelope-from=bjorn@kernel.org;
 helo=dfw.source.kernel.org
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Daniel Henrique Barboza <dbarboza@ventanamicro.com> writes:

> On 5/21/24 07:56, Bj=C3=B6rn T=C3=B6pel wrote:
>> From: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>>=20
>> Add ACPI GED for the RISC-V "virt" machine, and wire up PC-DIMM memory
>> hotplugging support. Heavily based/copied from hw/arm/virt.c.
>>=20
>> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>> ---
>>   hw/riscv/Kconfig           |   3 ++
>>   hw/riscv/virt-acpi-build.c |  16 ++++++
>>   hw/riscv/virt.c            | 104 ++++++++++++++++++++++++++++++++++++-
>>   include/hw/riscv/virt.h    |   6 ++-
>>   4 files changed, 126 insertions(+), 3 deletions(-)
>>=20
>> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
>> index 08f82dbb681a..bebe412f2107 100644
>> --- a/hw/riscv/Kconfig
>> +++ b/hw/riscv/Kconfig
>> @@ -56,6 +56,9 @@ config RISCV_VIRT
>>       select PLATFORM_BUS
>>       select ACPI
>>       select ACPI_PCI
>> +    select MEM_DEVICE
>> +    select DIMM
>> +    select ACPI_HW_REDUCED
>>       select VIRTIO_MEM_SUPPORTED
>>       select VIRTIO_PMEM_SUPPORTED
>>=20=20=20
>> diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
>> index 6dc3baa9ec86..61813abdef3f 100644
>> --- a/hw/riscv/virt-acpi-build.c
>> +++ b/hw/riscv/virt-acpi-build.c
>> @@ -27,6 +27,8 @@
>>   #include "hw/acpi/acpi-defs.h"
>>   #include "hw/acpi/acpi.h"
>>   #include "hw/acpi/aml-build.h"
>> +#include "hw/acpi/memory_hotplug.h"
>> +#include "hw/acpi/generic_event_device.h"
>>   #include "hw/acpi/pci.h"
>>   #include "hw/acpi/utils.h"
>>   #include "hw/intc/riscv_aclint.h"
>> @@ -432,6 +434,20 @@ static void build_dsdt(GArray *table_data,
>>           acpi_dsdt_add_gpex_host(scope, PCIE_IRQ + VIRT_IRQCHIP_NUM_SOU=
RCES * 2);
>>       }
>>=20=20=20
>> +    if (s->acpi_dev) {
>> +        uint32_t event =3D object_property_get_uint(OBJECT(s->acpi_dev),
>> +                                                  "ged-event", &error_a=
bort);
>> +
>> +        build_ged_aml(scope, "\\_SB."GED_DEVICE, HOTPLUG_HANDLER(s->acp=
i_dev),
>> +                      GED_IRQ, AML_SYSTEM_MEMORY, memmap[VIRT_ACPI_GED]=
.base);
>> +
>> +        if (event & ACPI_GED_MEM_HOTPLUG_EVT) {
>> +            build_memory_hotplug_aml(scope, ms->ram_slots, "\\_SB", NUL=
L,
>> +                                     AML_SYSTEM_MEMORY,
>> +                                     memmap[VIRT_PCDIMM_ACPI].base);
>> +        }
>> +    }
>> +
>>       aml_append(dsdt, scope);
>>=20=20=20
>>       /* copy AML table into ACPI tables blob and patch header there */
>> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
>> index 443902f919d2..2e35890187f2 100644
>> --- a/hw/riscv/virt.c
>> +++ b/hw/riscv/virt.c
>> @@ -53,10 +53,13 @@
>>   #include "hw/pci-host/gpex.h"
>>   #include "hw/display/ramfb.h"
>>   #include "hw/acpi/aml-build.h"
>> +#include "hw/acpi/generic_event_device.h"
>> +#include "hw/acpi/memory_hotplug.h"
>>   #include "hw/mem/memory-device.h"
>>   #include "hw/virtio/virtio-mem-pci.h"
>>   #include "qapi/qapi-visit-common.h"
>>   #include "hw/virtio/virtio-iommu.h"
>> +#include "hw/mem/pc-dimm.h"
>>=20=20=20
>>   /* KVM AIA only supports APLIC MSI. APLIC Wired is always emulated by =
QEMU. */
>>   static bool virt_use_kvm_aia(RISCVVirtState *s)
>> @@ -84,6 +87,8 @@ static const MemMapEntry virt_memmap[] =3D {
>>       [VIRT_UART0] =3D        { 0x10000000,         0x100 },
>>       [VIRT_VIRTIO] =3D       { 0x10001000,        0x1000 },
>>       [VIRT_FW_CFG] =3D       { 0x10100000,          0x18 },
>> +    [VIRT_PCDIMM_ACPI] =3D  { 0x10200000, MEMORY_HOTPLUG_IO_LEN },
>> +    [VIRT_ACPI_GED] =3D     { 0x10210000, ACPI_GED_EVT_SEL_LEN },
>>       [VIRT_FLASH] =3D        { 0x20000000,     0x4000000 },
>>       [VIRT_IMSIC_M] =3D      { 0x24000000, VIRT_IMSIC_MAX_SIZE },
>>       [VIRT_IMSIC_S] =3D      { 0x28000000, VIRT_IMSIC_MAX_SIZE },
>> @@ -1400,6 +1405,28 @@ static void virt_machine_done(Notifier *notifier,=
 void *data)
>>       }
>>   }
>>=20=20=20
>> +static DeviceState *create_acpi_ged(RISCVVirtState *s)
>> +{
>> +    DeviceState *dev;
>> +    MachineState *ms =3D MACHINE(s);
>> +    uint32_t event =3D 0;
>> +
>> +    if (ms->ram_slots) {
>> +        event |=3D ACPI_GED_MEM_HOTPLUG_EVT;
>> +    }
>> +
>> +    dev =3D qdev_new(TYPE_ACPI_GED);
>> +    qdev_prop_set_uint32(dev, "ged-event", event);
>> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
>> +
>> +    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, s->memmap[VIRT_ACPI_GED].ba=
se);
>> +    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 1, s->memmap[VIRT_PCDIMM_ACPI]=
.base);
>> +    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, qdev_get_gpio_in(s->irqc=
hip[0],
>> +                                                                GED_IRQ=
));
>> +
>> +    return dev;
>> +}
>> +
>>   static void virt_machine_init(MachineState *machine)
>>   {
>>       const MemMapEntry *memmap =3D virt_memmap;
>> @@ -1612,6 +1639,10 @@ static void virt_machine_init(MachineState *machi=
ne)
>>=20=20=20
>>       gpex_pcie_init(system_memory, pcie_irqchip, s);
>>=20=20=20
>> +    if (virt_is_acpi_enabled(s)) {
>> +        s->acpi_dev =3D create_acpi_ged(s);
>> +    }
>> +
>>       create_platform_bus(s, mmio_irqchip);
>>=20=20=20
>>       serial_mm_init(system_memory, memmap[VIRT_UART0].base,
>> @@ -1752,6 +1783,7 @@ static HotplugHandler *virt_machine_get_hotplug_ha=
ndler(MachineState *machine,
>>       MachineClass *mc =3D MACHINE_GET_CLASS(machine);
>>=20=20=20
>>       if (device_is_dynamic_sysbus(mc, dev) ||
>> +        object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM) ||
>>           object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI) ||
>>           object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI)) {
>>           return HOTPLUG_HANDLER(machine);
>> @@ -1759,14 +1791,42 @@ static HotplugHandler *virt_machine_get_hotplug_=
handler(MachineState *machine,
>>       return NULL;
>>   }
>>=20=20=20
>> +static void virt_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceSta=
te *dev,
>> +                                 Error **errp)
>> +{
>> +    RISCVVirtState *s =3D RISCV_VIRT_MACHINE(hotplug_dev);
>> +
>> +    if (!s->acpi_dev) {
>> +        error_setg(errp,
>> +                   "memory hotplug is not enabled: missing acpi-ged dev=
ice");
>> +        return;
>> +    }
>> +
>> +    pc_dimm_pre_plug(PC_DIMM(dev), MACHINE(hotplug_dev), NULL, errp);
>> +}
>> +
>
> Note that we're not doing any aligment checks in this pre_plug(), meaning=
 that
> we're kind of accepting whatever the pc-dimm device throw at us.
>
> Testing in an AMD x86 machine will force the pc-dimm to be 2Mb aligned:
>
> $ ./build/qemu-system-riscv64 -M virt -m 2G,slots=3D4,maxmem=3D8G -nograp=
hic
> (...)
> (qemu) object_add memory-backend-ram,id=3Dram0,size=3D111M
> (qemu) device_add pc-dimm,id=3Ddimm0,memdev=3Dram0
> Error: backend memory size must be multiple of 0x200000
> (qemu) object_del ram0
>
> This happens because the DIMM must be aligned with its own backend, in th=
is case
> the host memory itself (backends/hostmem.c).
>
> There's no guarantee that we'll always run in a host that is mem aligned =
with the board,
> so it would be nice to add align checks in virt_memory_pre_plug().

Indeed! I'll look into that.

>>   static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_de=
v,
>>                                               DeviceState *dev, Error **=
errp)
>>   {
>> +    if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
>> +        virt_memory_pre_plug(hotplug_dev, dev, errp);
>> +    }
>> +
>>       if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI)) {
>>           virtio_md_pci_pre_plug(VIRTIO_MD_PCI(dev), MACHINE(hotplug_dev=
), errp);
>>       }
>>   }
>>=20=20=20
>> +static void virt_memory_plug(HotplugHandler *hotplug_dev,
>> +                             DeviceState *dev, Error **errp)
>> +{
>> +    RISCVVirtState *s =3D RISCV_VIRT_MACHINE(hotplug_dev);
>> +
>> +    pc_dimm_plug(PC_DIMM(dev), MACHINE(s));
>> +
>> +    hotplug_handler_plug(HOTPLUG_HANDLER(s->acpi_dev), dev, &error_abor=
t);
>> +}
>> +
>>   static void virt_machine_device_plug_cb(HotplugHandler *hotplug_dev,
>>                                           DeviceState *dev, Error **errp)
>>   {
>> @@ -1785,16 +1845,36 @@ static void virt_machine_device_plug_cb(HotplugH=
andler *hotplug_dev,
>>           create_fdt_virtio_iommu(s, pci_get_bdf(PCI_DEVICE(dev)));
>>       }
>>=20=20=20
>> +    if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
>> +        virt_memory_plug(hotplug_dev, dev, errp);
>> +    }
>> +
>>       if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI)) {
>>           virtio_md_pci_plug(VIRTIO_MD_PCI(dev), MACHINE(hotplug_dev), e=
rrp);
>>       }
>>   }
>>=20=20=20
>> +static void virt_dimm_unplug_request(HotplugHandler *hotplug_dev,
>> +                                     DeviceState *dev, Error **errp)
>> +{
>> +    RISCVVirtState *s =3D RISCV_VIRT_MACHINE(hotplug_dev);
>> +
>> +    if (!s->acpi_dev) {
>> +        error_setg(errp,
>> +                   "memory hotplug is not enabled: missing acpi-ged dev=
ice");
>> +        return;
>> +    }
>> +
>> +    hotplug_handler_unplug_request(HOTPLUG_HANDLER(s->acpi_dev), dev, e=
rrp);
>> +}
>> +
>
> I'm unsure if we're ready to support both hotplug and hot-unplug, but I t=
ested anyway.
> Hotplug seems to work but hot-unplug doesn't:
>
> $ ./build/qemu-system-riscv64 -M virt -m 2G,slots=3D4,maxmem=3D8G -nograp=
hic
> (...)
> (qemu) object_add memory-backend-ram,id=3Dram0,size=3D112M
> (qemu) device_add pc-dimm,id=3Ddimm0,memdev=3Dram0
> (qemu)
> (qemu) info memory-devices
> Memory device [dimm]: "dimm0"
>    addr: 0x100000000
>    slot: 0
>    node: 0
>    size: 117440512
>    memdev: /objects/ram0
>    hotplugged: true
>    hotpluggable: true
> (qemu)
> (qemu) device_del dimm0
> (qemu) object_del ram0
> Error: object 'ram0' is in use, can not be deleted
> (qemu) info memory-devices
> Memory device [dimm]: "dimm0"
>    addr: 0x100000000
>    slot: 0
>    node: 0
>    size: 117440512
>    memdev: /objects/ram0
>    hotplugged: true
>    hotpluggable: true
> (qemu)
>
> In short: hotplugged a 112Mb DIMM, then tried to remove it. 'device_del' =
doesn't error
> out but doesn't let me remove the memory backing created, i.e. the dimm0 =
device is
> still around.
>
> In a quick digging I see that we're hitting virt_dimm_unplug_request() al=
l the way
> down to acpi_memory_unplug_request_cb(), where an ACPI_MEMORY_HOTPLUG_STA=
TUS is being
> sent. We never reach virt_dimm_unplug() afterwards, so the PC_DIMM is nev=
er removed.
>
> I'm not acquainted with ACPI enough to say if we're missing stuff in QEMU=
, or if we
> need SW to be aware of this ACPI HP event to trigger the release of the d=
imm, or
> anything in between.
>
> I consider this more as a FYI. If we're up to the point of hotplugging pc=
-dimms it's
> already an improvement worth having. Hot-unplugging can come later.

I'll debug this as well!

Thanks for all the input, Daniel!


Bj=C3=B6rn

