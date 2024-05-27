Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 812ECC25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 12:03:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBZ4q-0001Dy-3r; Mon, 27 May 2024 08:03:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bjorn@kernel.org>)
 id 1sBZ4n-0001DM-NT; Mon, 27 May 2024 08:03:41 -0400
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bjorn@kernel.org>)
 id 1sBZ4j-0007vp-Cu; Mon, 27 May 2024 08:03:40 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 1B066CE0ED0;
 Mon, 27 May 2024 12:03:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6448C2BBFC;
 Mon, 27 May 2024 12:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1716811411;
 bh=IG6zXsfS3dQmkbJcQpTn2+d5jURhljxkwHHNnelw/MI=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=qZD/Ut4/BfcW0GF2pviPJAlYhJpE57qTOSdowTR+8KAHQ7rlufv9vccjWKv+2ef6R
 mYmgjSyuxtifpgnrQ/x4WRvby4O72KLOWw9T6iexMDtCQssrtSFHbvFqMQtbXi8noc
 SmqfXUiNu0e5OFPnzxSNhgp8X5G85bJV1O1Zj/W1uysv8EeO86X7E+dXs8vGmPXWwD
 beVcbGKOECG3BHB4dbQE5XubqHEQRKYSlrWfi6iVzXHZ5TZ0zseYzuAxWTal4ejM18
 ZGvN/EJZJ+PeqKal/uN4xQ1wyfjSnxHD1bLH4N7RSZ9V2C4Qo9us3VmB5Mvgx/tkr0
 CxTHEdvxARP8Q==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: David Hildenbrand <david@redhat.com>, Daniel Henrique Barboza
 <dbarboza@ventanamicro.com>, Palmer Dabbelt <palmer@dabbelt.com>, Alistair
 Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>, Weiwei
 Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org, Atish Patra
 <atishp@atishpatra.org>, Atish Patra <atishp@rivosinc.com>
Cc: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, Sunil V L
 <sunilvl@ventanamicro.com>,
 Santosh Mamila <santosh.mamila@catalinasystems.io>, Chethan Seshadri
 <Chethan.Seshadri@catalinasystems.io>, Sivakumar Munnangi
 <siva.munnangi@catalinasystems.io>
Subject: Re: [PATCH v2 1/3] hw/riscv/virt: Add memory hotplugging and
 virtio-md-pci support
In-Reply-To: <51ef570c-da63-4e25-9c48-dbdf8a40a34d@redhat.com>
References: <20240521105635.795211-1-bjorn@kernel.org>
 <20240521105635.795211-2-bjorn@kernel.org>
 <55810d52-0360-40ad-a8d2-3b6a8aa220ae@ventanamicro.com>
 <51ef570c-da63-4e25-9c48-dbdf8a40a34d@redhat.com>
Date: Mon, 27 May 2024 14:03:28 +0200
Message-ID: <87sey38nsf.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2604:1380:40e1:4800::1;
 envelope-from=bjorn@kernel.org; helo=sin.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

David Hildenbrand <david@redhat.com> writes:

> On 24.05.24 15:14, Daniel Henrique Barboza wrote:
>>=20
>>=20
>> On 5/21/24 07:56, Bj=C3=B6rn T=C3=B6pel wrote:
>>> From: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>>>
>>> Virtio-based memory devices (virtio-mem/virtio-pmem) allows for
>>> dynamic resizing of virtual machine memory, and requires proper
>>> hotplugging (add/remove) support to work.
>>>
>>> Add device memory support for RISC-V "virt" machine, and enable
>>> virtio-md-pci with the corresponding missing hotplugging callbacks.
>>>
>>> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>>> ---
>>>    hw/riscv/Kconfig       |  2 +
>>>    hw/riscv/virt.c        | 83 ++++++++++++++++++++++++++++++++++++++++=
+-
>>>    hw/virtio/virtio-mem.c |  5 ++-
>>>    3 files changed, 87 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
>>> index a2030e3a6ff0..08f82dbb681a 100644
>>> --- a/hw/riscv/Kconfig
>>> +++ b/hw/riscv/Kconfig
>>> @@ -56,6 +56,8 @@ config RISCV_VIRT
>>>        select PLATFORM_BUS
>>>        select ACPI
>>>        select ACPI_PCI
>>> +    select VIRTIO_MEM_SUPPORTED
>>> +    select VIRTIO_PMEM_SUPPORTED
>>>=20=20=20=20
>>>    config SHAKTI_C
>>>        bool
>>> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
>>> index 4fdb66052587..443902f919d2 100644
>>> --- a/hw/riscv/virt.c
>>> +++ b/hw/riscv/virt.c
>>> @@ -53,6 +53,8 @@
>>>    #include "hw/pci-host/gpex.h"
>>>    #include "hw/display/ramfb.h"
>>>    #include "hw/acpi/aml-build.h"
>>> +#include "hw/mem/memory-device.h"
>>> +#include "hw/virtio/virtio-mem-pci.h"
>>>    #include "qapi/qapi-visit-common.h"
>>>    #include "hw/virtio/virtio-iommu.h"
>>>=20=20=20=20
>>> @@ -1407,6 +1409,7 @@ static void virt_machine_init(MachineState *machi=
ne)
>>>        DeviceState *mmio_irqchip, *virtio_irqchip, *pcie_irqchip;
>>>        int i, base_hartid, hart_count;
>>>        int socket_count =3D riscv_socket_count(machine);
>>> +    hwaddr device_memory_base, device_memory_size;
>>>=20=20=20=20
>>>        /* Check socket count limit */
>>>        if (VIRT_SOCKETS_MAX < socket_count) {
>>> @@ -1420,6 +1423,12 @@ static void virt_machine_init(MachineState *mach=
ine)
>>>            exit(1);
>>>        }
>>>=20=20=20=20
>>> +    if (machine->ram_slots > ACPI_MAX_RAM_SLOTS) {
>>> +        error_report("unsupported amount of memory slots: %"PRIu64,
>>> +                     machine->ram_slots);
>>> +        exit(EXIT_FAILURE);
>>> +    }
>>> +
>>>        /* Initialize sockets */
>>>        mmio_irqchip =3D virtio_irqchip =3D pcie_irqchip =3D NULL;
>>>        for (i =3D 0; i < socket_count; i++) {
>>> @@ -1553,6 +1562,37 @@ static void virt_machine_init(MachineState *mach=
ine)
>>>        memory_region_add_subregion(system_memory, memmap[VIRT_MROM].bas=
e,
>>>                                    mask_rom);
>>>=20=20=20=20
>>> +    /* device memory */
>>> +    device_memory_base =3D ROUND_UP(s->memmap[VIRT_DRAM].base + machin=
e->ram_size,
>>> +                                  GiB);
>>> +    device_memory_size =3D machine->maxram_size - machine->ram_size;
>>> +    if (device_memory_size > 0) {
>>> +        /*
>>> +         * Each DIMM is aligned based on the backend's alignment value.
>>> +         * Assume max 1G hugepage alignment per slot.
>>> +         */
>>> +        device_memory_size +=3D machine->ram_slots * GiB;
>>=20
>> We don't need to align to 1GiB. This calc can use 2MiB instead (or 4MiB =
if we're
>> running 32 bits).
>>=20
>>> +
>>> +        if (riscv_is_32bit(&s->soc[0])) {
>>> +            hwaddr memtop =3D device_memory_base + ROUND_UP(device_mem=
ory_size,
>>> +                                                          GiB);
>>=20
>> Same here - alignment is 2/4 MiB.
>>=20
>>> +
>>> +            if (memtop > UINT32_MAX) {
>>> +                error_report("memory exceeds 32-bit limit by %lu bytes=
",
>>> +                             memtop - UINT32_MAX);
>>> +                exit(EXIT_FAILURE);
>>> +            }
>>> +        }
>>> +
>>> +        if (device_memory_base + device_memory_size < device_memory_si=
ze) {
>>> +            error_report("unsupported amount of device memory");
>>> +            exit(EXIT_FAILURE);
>>> +        }
>>=20
>> Took another look and found this a bit strange. These are all unsigned v=
ars, so
>> if (unsigned a + unsigned b < unsigned b) will always be 'false'. The co=
mpiler is
>> probably cropping this out.
>
> No. Unsigned interger overflow is defined behavior and this is a common=20
> check to detect such overflow. tI's consistent with what we do for other=
=20
> architectures.
>
>>=20
>> The calc we need to do is to ensure that the extra ram_slots * alignment=
 will fit into
>> the VIRT_DRAM block, i.e. maxram_size + (ram_slots * alignment) < memmap=
[VIRT_DRAM].size.
>>=20
>>=20
>> TBH I'm starting to have second thoughts about letting users hotplug wha=
tever they want.
>> It seems cleaner to just force the 2/4 Mb alignment in pre_plug() and be=
 done with it,
>> no need to allocate ram_slots * alignment and doing all these extra chec=
ks.
>
> It's worth noting that if user space decides to specify addresses=20
> manually, it can mess up everything already. There are other events that=
=20
> can result in fragmentation of the memory device area (repeated=20
> hot(un)plug of differing DIMMs).
>
> Assume you have 1 GiB range and hotplug a 512 MiB DIMM at offset 256=20
> MiB. You won't be able to hotplug another 512 MiB DIMM even though we=20
> reserved space.
>
> My take so far is: if the user wants to do such stuff it should size the=
=20
> area (maxmem) much larger or deal with the concequences (not being able=20
> to hotplug memory).
>
> It usually does not happen in practice ...

Daniel/David, again thanks for spending time on the patches.

The reason I picked 1 GiB per slot was because the alignment is also
dependent on the backend AFAIU. Rationale in commit 085f8e88ba73 ("pc:
count in 1Gb hugepage alignment when sizing hotplug-memory container").

What I'm reading from you guys are: Just depend on whatever maxmem says
(modulo 2/4M alignment), and leave at that. I agree that that's much
easier to reason about.

Correct?

>> As I sent in an earlier email, users must already comply to the alignmen=
t of the host
>> memory when plugging pc-dimms, so I'm not sure our value/proposition wit=
h all this
>> extra code is worth it - the alignment will most likely be forced by the=
 host memory
>> backend, so might as well force ourselves in pre_plug().
>
> At least on x86-64, the 2 MiB alignment requirement is handled=20
> automatically. QEMU_VMALLOC_ALIGN implicitly enforces that.
>
> Maybe RISCV also wants to set QEMU_VMALLOC_ALIGN?

I'll look into this for the next rev!


Bj=C3=B6rn

