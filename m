Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CF41C25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 11:50:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBYr4-0000m6-Qb; Mon, 27 May 2024 07:49:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bjorn@kernel.org>)
 id 1sBYr3-0000lN-4N; Mon, 27 May 2024 07:49:29 -0400
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bjorn@kernel.org>)
 id 1sBYqz-0004v8-6x; Mon, 27 May 2024 07:49:27 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 71D026164B;
 Mon, 27 May 2024 11:49:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8139C32781;
 Mon, 27 May 2024 11:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1716810556;
 bh=ANc93QpJU98kip+ce/cUfXu1x9xaQYAdf5V6F0ChfKg=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=TEcQWe5ObqSvEjnk52pqhipPWYk38kt1Ppo0bQk3hdlc+lafBIuv2RKY+hhUmnuL3
 zhD5hXqd5tdcQEZm6jtJOh7evKc8mtXxe1goGedk1XejaD/hrx4HRw22/DE7+Ov2fv
 r468CMQ1JoewfxaTwH8A/FW8O802Rxcl0sGXZ/V2QPiUaUvVwOWgcQKWbYU4AzY5VE
 1mjigHVNTIyHOq6ZMFc4ubEc6NxkvAvKwoVTyk8CZGTcfIrqj4Cz99+SdKvP8R/237
 v45fSQRiF9ba3wzG20eTkcrfCZJpr24KqeUAzI7pWPlvKNHka8/BJ4D7EqBK8NGCm+
 RP7IbFJ+j3HdQ==
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
Subject: Re: [PATCH v2 1/3] hw/riscv/virt: Add memory hotplugging and
 virtio-md-pci support
In-Reply-To: <f1513236-867f-4780-a51f-81b5ac91a485@ventanamicro.com>
References: <20240521105635.795211-1-bjorn@kernel.org>
 <20240521105635.795211-2-bjorn@kernel.org>
 <f1513236-867f-4780-a51f-81b5ac91a485@ventanamicro.com>
Date: Mon, 27 May 2024 13:49:11 +0200
Message-ID: <87y17v8og8.fsf@all.your.base.are.belong.to.us>
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
>> Virtio-based memory devices (virtio-mem/virtio-pmem) allows for
>> dynamic resizing of virtual machine memory, and requires proper
>> hotplugging (add/remove) support to work.
>>=20
>> Add device memory support for RISC-V "virt" machine, and enable
>> virtio-md-pci with the corresponding missing hotplugging callbacks.
>>=20
>> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>> ---
>>   hw/riscv/Kconfig       |  2 +
>>   hw/riscv/virt.c        | 83 +++++++++++++++++++++++++++++++++++++++++-
>>   hw/virtio/virtio-mem.c |  5 ++-
>>   3 files changed, 87 insertions(+), 3 deletions(-)
>>=20
>> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
>> index a2030e3a6ff0..08f82dbb681a 100644
>> --- a/hw/riscv/Kconfig
>> +++ b/hw/riscv/Kconfig
>> @@ -56,6 +56,8 @@ config RISCV_VIRT
>>       select PLATFORM_BUS
>>       select ACPI
>>       select ACPI_PCI
>> +    select VIRTIO_MEM_SUPPORTED
>> +    select VIRTIO_PMEM_SUPPORTED
>>=20=20=20
>>   config SHAKTI_C
>>       bool
>> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
>> index 4fdb66052587..443902f919d2 100644
>> --- a/hw/riscv/virt.c
>> +++ b/hw/riscv/virt.c
>> @@ -53,6 +53,8 @@
>>   #include "hw/pci-host/gpex.h"
>>   #include "hw/display/ramfb.h"
>>   #include "hw/acpi/aml-build.h"
>> +#include "hw/mem/memory-device.h"
>> +#include "hw/virtio/virtio-mem-pci.h"
>>   #include "qapi/qapi-visit-common.h"
>>   #include "hw/virtio/virtio-iommu.h"
>>=20=20=20
>> @@ -1407,6 +1409,7 @@ static void virt_machine_init(MachineState *machin=
e)
>>       DeviceState *mmio_irqchip, *virtio_irqchip, *pcie_irqchip;
>>       int i, base_hartid, hart_count;
>>       int socket_count =3D riscv_socket_count(machine);
>> +    hwaddr device_memory_base, device_memory_size;
>>=20=20=20
>>       /* Check socket count limit */
>>       if (VIRT_SOCKETS_MAX < socket_count) {
>> @@ -1420,6 +1423,12 @@ static void virt_machine_init(MachineState *machi=
ne)
>>           exit(1);
>>       }
>>=20=20=20
>> +    if (machine->ram_slots > ACPI_MAX_RAM_SLOTS) {
>> +        error_report("unsupported amount of memory slots: %"PRIu64,
>> +                     machine->ram_slots);
>
> Let's also add the maximum amount allowed in this message, e.g. this erro=
r:
>
> $ (...) -m 2G,slots=3D512,maxmem=3D8G
> qemu-system-riscv64: unsupported amount of memory slots: 512
>
> could be something like:
>
> qemu-system-riscv64: unsupported amount of memory slots (512), maximum am=
ount: 256
>
>
> LGTM otherwise. Thanks,

Thanks for getting back!

Sure! I'll fix this in the next rev.


Bj=C3=B6rn

