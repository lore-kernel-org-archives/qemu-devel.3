Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40CCBC04FFE
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2024 18:34:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s97pj-0000NN-2l; Mon, 20 May 2024 14:34:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bjorn@kernel.org>)
 id 1s97pd-0000MX-IA; Mon, 20 May 2024 14:33:57 -0400
Received: from sin.source.kernel.org ([145.40.73.55])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bjorn@kernel.org>)
 id 1s97pa-0003Jn-QG; Mon, 20 May 2024 14:33:57 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 3571ECE0C47;
 Mon, 20 May 2024 18:33:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4803C2BD10;
 Mon, 20 May 2024 18:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1716230021;
 bh=xu+kl7kjSGnDX+nb2nk6EBZPHESM4Za/vrprxGJk3iU=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=J3dfIoWBHURqbrL0mpawzamLLyoMJQZS/pgs4+wBCVJxXYSzoIIl9ZwtjYNOTROee
 zJz1Y8s+z7fQGRP2KX1dWulW7ed3pAFX0XrL47YQZnm9fwbZrd1dRvZ7fTryCZrCBT
 I1zGsdBORo3MbfGoGMSiMayIMQWw9MtdAYxx0M0XZdZTKvVnxAbvUAHli9wWSY/8tK
 /bslWyXmwvsEA+8KK60UVDNLU5S6I7sZ4ZqsWkhAo/Dkyz/5tUPxAHdl+ubJBE7M2p
 CdbUL+ffzLkg9FmTjByA4itJBTtgxHKH+vwtmkLoYrDaua2Li7wOn4c1D5X3FKYx4k
 I7N9LoreIsOKg==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Alistair Francis <alistair.francis@wdc.com>, Bin
 Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>
Cc: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, Sunil V L
 <sunilvl@ventanamicro.com>,
 Santosh Mamila <santosh.mamila@catalinasystems.io>, Chethan Seshadri
 <Chethan.Seshadri@catalinasystems.io>, Sivakumar Munnangi
 <siva.munnangi@catalinasystems.io>
Subject: Re: [PATCH] hw/riscv/virt: Add hotplugging and virtio-md-pci support
In-Reply-To: <3cb00bbb-7742-40b7-858c-4bdd2f9cc79b@ventanamicro.com>
References: <20240514110615.399065-1-bjorn@kernel.org>
 <3cb00bbb-7742-40b7-858c-4bdd2f9cc79b@ventanamicro.com>
Date: Mon, 20 May 2024 20:33:37 +0200
Message-ID: <875xv8wcxq.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=145.40.73.55; envelope-from=bjorn@kernel.org;
 helo=sin.source.kernel.org
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

Daniel,

Thanks for taking a look!

Daniel Henrique Barboza <dbarboza@ventanamicro.com> writes:

> Hi Bj=C3=B6rj,
>
> On 5/14/24 08:06, Bj=C3=B6rn T=C3=B6pel wrote:
>> From: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>>=20
>> Virtio-based memory devices allows for dynamic resizing of virtual
>> machine memory, and requires proper hotplugging (add/remove) support
>> to work.
>>=20
>> Enable virtio-md-pci with the corresponding missing hotplugging
>> callbacks for the RISC-V "virt" machine.
>>=20
>> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>> ---
>> This is basic support for MHP that works with DT. There some minor
>> ACPI SRAT plumbing in there as well. Ideally we'd like proper ACPI MHP
>> support as well. I have a branch [1], where I've applied this patch,
>> plus ACPI GED/PC-DIMM MHP support on top of Sunil's QEMU branch
>> (contains some ACPI DSDT additions) [2], for the curious/brave ones.
>> However, the ACPI MHP support this is not testable on upstream Linux
>> yet (ACPI AIA support, and ACPI NUMA SRAT series are ongoing).
>>=20
>> I'll follow-up with proper ACPI GED/PC-DIMM MHP patches, once the
>> dependencies land (Linux kernel and QEMU).
>>=20
>> I'll post the Linux MHP/virtio-mem v2 patches later this week!
>>=20
>>=20
>> Cheers,
>> Bj=C3=B6rn
>>=20
>> [1] https://github.com/bjoto/qemu/commits/virtio-mem-pc-dimm-mhp-acpi/
>> [2] https://lore.kernel.org/linux-riscv/20240501121742.1215792-1-sunilvl=
@ventanamicro.com/
>> ---
>>   hw/riscv/Kconfig           |  2 ++
>>   hw/riscv/virt-acpi-build.c |  7 +++++
>>   hw/riscv/virt.c            | 64 +++++++++++++++++++++++++++++++++++++-
>>   hw/virtio/virtio-mem.c     |  2 +-
>>   4 files changed, 73 insertions(+), 2 deletions(-)
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
>> diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
>> index 0925528160f8..6dc3baa9ec86 100644
>> --- a/hw/riscv/virt-acpi-build.c
>> +++ b/hw/riscv/virt-acpi-build.c
>> @@ -610,6 +610,13 @@ build_srat(GArray *table_data, BIOSLinker *linker, =
RISCVVirtState *vms)
>>           }
>>       }
>>=20=20=20
>> +    if (ms->device_memory) {
>> +        build_srat_memory(table_data, ms->device_memory->base,
>> +                          memory_region_size(&ms->device_memory->mr),
>> +                          ms->numa_state->num_nodes - 1,
>> +                          MEM_AFFINITY_HOTPLUGGABLE | MEM_AFFINITY_ENAB=
LED);
>> +    }
>> +
>>       acpi_table_end(linker, &table);
>
> When the time comes I believe we'll want this chunk in a separated ACPI p=
atch.

Hmm, I first thought about adding this to the ACPI MHP series, but then
realized that virtio-mem relies on SRAT for ACPI boots (again -- RISC-V
Linux does not support that upstream yet...).

Do you mean that you'd prefer this chunk in a separate patch?


Bj=C3=B6rn

