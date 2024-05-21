Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AC41C25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 05:44:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9IIC-0003PE-Cf; Tue, 21 May 2024 01:44:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bjorn@kernel.org>)
 id 1s9II7-0003OR-M7; Tue, 21 May 2024 01:44:04 -0400
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bjorn@kernel.org>)
 id 1s9II5-0001eD-4U; Tue, 21 May 2024 01:44:03 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 1DD8DCE0B60;
 Tue, 21 May 2024 05:43:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC872C2BD11;
 Tue, 21 May 2024 05:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1716270234;
 bh=WMV9MBvRaoHU8emcq0A3mUlZojLsuE3PMtuTWtiXRYg=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=PGu2nDS3af12yRmND2KZ+uboQL/ohO/uxVOfY1jY4awUr00gfChVjackeoGSaDvu0
 fdQ01YuIn67AqFbIoHsr0O9ySMkfxG0mgXALO7nFN6Lr6oLT+XLSLj4NaNQmnoS1vM
 9stE2oKjQz9TpfB8aGYKHTdB3e1+/e7Q+YiECfcHKtzXhv+UHgXUIOqgm7MZ1H57dZ
 kHU5ignXzLNDwrgPenaYJEMn4cKMgqM9rMGUtHWsWEsLiVmRKNmYQDDmc9AROGtRK6
 xpYdEiGFAnTn2sN+YGRBL4yAgUBfVwsUBL60aOgiuvnK4djvgdwfBKpkf55vgkh4Ks
 t6hGmdxWVl70g==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, David Hildenbrand
 <david@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>, Alistair Francis
 <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, Sunil V L
 <sunilvl@ventanamicro.com>,
 Santosh Mamila <santosh.mamila@catalinasystems.io>, Chethan Seshadri
 <Chethan.Seshadri@catalinasystems.io>, Sivakumar Munnangi
 <siva.munnangi@catalinasystems.io>
Subject: Re: [PATCH] hw/riscv/virt: Add hotplugging and virtio-md-pci support
In-Reply-To: <c9332de0-f36e-4e62-a46c-9d3fd8448795@ventanamicro.com>
References: <20240514110615.399065-1-bjorn@kernel.org>
 <3cb00bbb-7742-40b7-858c-4bdd2f9cc79b@ventanamicro.com>
 <91086379-1fbc-4179-863a-6bb2e797d564@redhat.com>
 <afbd3799-fa2a-4c7d-8097-aeaedecf4ec3@ventanamicro.com>
 <87v838uxk5.fsf@all.your.base.are.belong.to.us>
 <c9332de0-f36e-4e62-a46c-9d3fd8448795@ventanamicro.com>
Date: Tue, 21 May 2024 07:43:50 +0200
Message-ID: <877cfniusp.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2604:1380:40e1:4800::1;
 envelope-from=bjorn@kernel.org; helo=sin.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Daniel Henrique Barboza <dbarboza@ventanamicro.com> writes:

> On 5/20/24 15:51, Bj=C3=B6rn T=C3=B6pel wrote:
>> Daniel/David,
>>=20
>> Daniel Henrique Barboza <dbarboza@ventanamicro.com> writes:
>>=20
>>> On 5/18/24 16:50, David Hildenbrand wrote:
>>>>
>>>> Hi,
>>>>
>>>>
>>>>>> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
>>>>>> index 4fdb66052587..16c2bdbfe6b6 100644
>>>>>> --- a/hw/riscv/virt.c
>>>>>> +++ b/hw/riscv/virt.c
>>>>>> @@ -53,6 +53,8 @@
>>>>>>  =C2=A0=C2=A0 #include "hw/pci-host/gpex.h"
>>>>>>  =C2=A0=C2=A0 #include "hw/display/ramfb.h"
>>>>>>  =C2=A0=C2=A0 #include "hw/acpi/aml-build.h"
>>>>>> +#include "hw/mem/memory-device.h"
>>>>>> +#include "hw/virtio/virtio-mem-pci.h"
>>>>>>  =C2=A0=C2=A0 #include "qapi/qapi-visit-common.h"
>>>>>>  =C2=A0=C2=A0 #include "hw/virtio/virtio-iommu.h"
>>>>>> @@ -1407,6 +1409,7 @@ static void virt_machine_init(MachineState *ma=
chine)
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DeviceState *mmio_irqchip, *vi=
rtio_irqchip, *pcie_irqchip;
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int i, base_hartid, hart_count;
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int socket_count =3D riscv_soc=
ket_count(machine);
>>>>>> +=C2=A0=C2=A0=C2=A0 hwaddr device_memory_base, device_memory_size;
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Check socket count limit */
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (VIRT_SOCKETS_MAX < socket_=
count) {
>>>>>> @@ -1553,6 +1556,25 @@ static void virt_machine_init(MachineState *m=
achine)
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memory_region_add_subregion(sy=
stem_memory, memmap[VIRT_MROM].base,
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mask_rom);
>>>>>> +=C2=A0=C2=A0=C2=A0 device_memory_base =3D ROUND_UP(s->memmap[VIRT_D=
RAM].base + machine->ram_size,
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GiB);
>>>>>> +=C2=A0=C2=A0=C2=A0 device_memory_size =3D machine->maxram_size - ma=
chine->ram_size;
>>>>>> +
>>>>>> +=C2=A0=C2=A0=C2=A0 if (riscv_is_32bit(&s->soc[0])) {
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hwaddr memtop =3D device=
_memory_base + ROUND_UP(device_memory_size, GiB);
>>>>>> +
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (memtop > UINT32_MAX)=
 {
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
error_report("Memory exceeds 32-bit limit by %lu bytes",
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 memtop - UINT32_MAX);
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
exit(EXIT_FAILURE);
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>> +=C2=A0=C2=A0=C2=A0 }
>>>>>> +
>>>>>> +=C2=A0=C2=A0=C2=A0 if (device_memory_size > 0) {
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 machine_memory_devices_i=
nit(machine, device_memory_base,
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devic=
e_memory_size);
>>>>>> +=C2=A0=C2=A0=C2=A0 }
>>>>>> +
>>>>>
>>>>> I think we need a design discussion before proceeding here. You're al=
locating all
>>>>> available memory as a memory device area, but in theory we might also=
 support
>>>>> pc-dimm hotplugs (which would be the equivalent of adding physical RA=
M dimms to
>>>>> the board.) in the future too. If you're not familiar with this featu=
re you can
>>>>> check it out the docs in [1].
>>>>
>>>> Note that DIMMs are memory devices as well. You can plug into the memo=
ry device area both, ACPI-based memory devices (DIMM, NVDIMM) or virtio-bas=
ed memory devices (virtio-mem, virtio-pmem).
>>>>
>>>>>
>>>>> As an example, the 'virt' ARM board (hw/arm/virt.c) reserves a space =
for this
>>>>> type of hotplug by checking how much 'ram_slots' we're allocating for=
 it:
>>>>>
>>>>> device_memory_size =3D ms->maxram_size - ms->ram_size + ms->ram_slots=
 * GiB;
>>>>>
>>>>
>>>> Note that we increased the region size to be able to fit most requests=
 even if alignment of memory devices is weird. See below.
>>>>
>>>> In sane setups, this is usually not required (adding a single addition=
al GB for some flexiility might be good enough).
>>>>
>>>>> Other boards do the same with ms->ram_slots. We should consider doing=
 it as well,
>>>>> now, even if we're not up to the point of supporting pc-dimm hotplug,=
 to avoid
>>>>> having to change the memory layout later in the road and breaking exi=
sting
>>>>> setups.
>>>>>
>>>>> If we want to copy the ARM board, ram_slots is capped to ACPI_MAX_RAM=
_SLOTS (256).
>>>>> Each RAM slot is considered to be a 1GiB dimm, i.e. we would reserve =
256GiB for
>>>>> them.
>>>>
>>>> This only reserves some *additional* space to fixup weird alignment of=
 memory devices. *not* the actual space for these devices.
>>>>
>>>> We don't consider each DIMM to be 1 GiB in size, but add an additional=
 1 GiB in case we have to align DIMMs in physical address space.
>>>>
>>>> I *think* this dates back to old x86 handling where we aligned the add=
ress of each DIMM to be at a 1 GiB boundary. So if you would have plugged t=
wo 128 MiB DIMMs, you'd have required more than 256 MiB of space in the are=
a after aligning inside the memory device area.
>>>>
>>>
>>> Thanks for the explanation. I missed the part where the ram_slots were =
being
>>> used just to solve potential alignment issues and pc-dimms could occupy=
 the same
>>> space being allocated via machine_memory_devices_init().
>>>
>>> This patch isn't far off then. If we take care to avoid plugging unalig=
ned memory
>>> we might not even need this spare area.
>>=20
>> I'm a bit lost here, so please bare with me. We don't require the 1 GiB
>> alignment on RV AFAIU. I'm having a hard time figuring out what missing
>> in my patch.
>
> Forget about the 1 GiB size. This is something that we won't need to deal=
 with
> because we don't align in 1 Gib.
>
> Let's say for example that we want to support pc-dimm hotplug of 256 slot=
s like the
> 'virt' ARM machine does. Let's also say that we will allow users to hotpl=
ug any
> DIMM size they want, taking care of any alignment issues by ourselves.
>
> In hw/riscv/boot.c I see that our alignment sizes are 4Mb for 32 bits and=
 2Mb for
> 64 bits. Forget 32 bits a bit and let's say that our alignment is 2Mb.
>
> So, in a worst case scenario, an user could hotplug 256 slots, all of the=
m unaligned,
> and then we would need to align each one of them by adding 2Mb. So, to ac=
count for
> this alignment fixup, we would need 256 * 2Mb RAM reserved for it.
>
> What I said about "If we take care to avoid plugging unaligned memory we =
might not even
> need this spare area" is a possible design where we would force every hot=
plugged DIMM
> to always be memory aligned, avoiding the need for this spare RAM for ali=
gnment. This
> would put a bit of extra straing in users/management apps to always deliv=
er aligned
> DIMMs.
>
> In hindsight this is not needed. It's fairly easy to reserve ACPI_MAX_RAM=
_SLOTS * (2Mb/4Mb)
> and let users hotplug whatever DIMM size they want.
>
> Hope this explains the situation a bit. If we agree on allocating this sp=
are RAM for
> hotplugged mem alignment, we'll probalby need a pre-patch to do a little =
handling of
> ms->ram_slots, limiting it to ACPI_MAX_RAM_SLOTS (ram_slots can be change=
d via command
> line). Then it's a matter of reserving ms->ram_slots * align_size when ca=
lculating
> device_memory_size.

Thanks for the elaborate explaination! I'll take a stab at it in v2.


Bj=C3=B6rn

