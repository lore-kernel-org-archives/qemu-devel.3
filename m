Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83DB3C25B77
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 07:56:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9goz-0004p1-3O; Wed, 22 May 2024 03:55:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1s9gow-0004oe-4o
 for qemu-devel@nongnu.org; Wed, 22 May 2024 03:55:34 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1s9gos-0005tK-CO
 for qemu-devel@nongnu.org; Wed, 22 May 2024 03:55:33 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8CxKOrspE1mAZYCAA--.2054S3;
 Wed, 22 May 2024 15:55:24 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxRcXppE1mqUUFAA--.4525S3; 
 Wed, 22 May 2024 15:55:23 +0800 (CST)
Subject: Re: [PATCH v3 4/6] hw/loongarch: Refine system dram memory region
To: Bibo Mao <maobibo@loongson.cn>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240515093927.3453674-1-maobibo@loongson.cn>
 <20240515093927.3453674-5-maobibo@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <ec8554f6-83b4-edbd-d99a-1d8a996fafda@loongson.cn>
Date: Wed, 22 May 2024 15:55:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20240515093927.3453674-5-maobibo@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8AxRcXppE1mqUUFAA--.4525S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxCw48Ar45JFy7ur4kJr45twc_yoWrCrW3pF
 4fAr17ur4UtF93GFn7K3WkWFykJw1kKa47uFy7Cr4vkFn3ur1jkr18Jws2vayUA3yDXF1r
 Xr4kJryfX3Z8t3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j8
 yCJUUUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: 1
X-Spam_score: 0.1
X-Spam_bar: /
X-Spam_report: (0.1 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 NICE_REPLY_A=-0.405, SPF_HELO_NONE=0.001,
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

ÔÚ 2024/5/15 ÏÂÎç5:39, Bibo Mao Ð´µÀ:
> For system dram memory region, it is not necessary to use numa node
> information. There is only low memory region and high memory region.
>
> Remove numa node information for ddr memory region here, it can reduce
> memory region number on LoongArch virt machine.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   hw/loongarch/virt.c | 55 +++++++++++++++------------------------------
>   1 file changed, 18 insertions(+), 37 deletions(-)
>
> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
> index b67d691fa5..ac980aec8e 100644
> --- a/hw/loongarch/virt.c
> +++ b/hw/loongarch/virt.c
> @@ -972,14 +972,10 @@ static void virt_init(MachineState *machine)
>   {
>       LoongArchCPU *lacpu;
>       const char *cpu_model = machine->cpu_type;
> -    ram_addr_t offset = 0;
> -    ram_addr_t ram_size = machine->ram_size;
> -    uint64_t highram_size = 0, phyAddr = 0;
>       MemoryRegion *address_space_mem = get_system_memory();
>       LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(machine);
> -    int nb_numa_nodes = machine->numa_state->num_nodes;
> -    NodeInfo *numa_info = machine->numa_state->nodes;
>       int i;
> +    hwaddr base, size, ram_size = machine->ram_size;
>       const CPUArchIdList *possible_cpus;
>       MachineClass *mc = MACHINE_GET_CLASS(machine);
>       CPUState *cpu;
> @@ -1017,40 +1013,27 @@ static void virt_init(MachineState *machine)
>       fw_cfg_add_memory(machine);
>   
>       /* Node0 memory */
> -    memory_region_init_alias(&lvms->lowmem, NULL, "loongarch.node0.lowram",
> -                             machine->ram, offset, VIRT_LOWMEM_SIZE);
> -    memory_region_add_subregion(address_space_mem, phyAddr, &lvms->lowmem);
> -
> -    offset += VIRT_LOWMEM_SIZE;
> -    if (nb_numa_nodes > 0) {
> -        assert(numa_info[0].node_mem > VIRT_LOWMEM_SIZE);
> -        highram_size = numa_info[0].node_mem - VIRT_LOWMEM_SIZE;
> -    } else {
> -        highram_size = ram_size - VIRT_LOWMEM_SIZE;
> -    }
> -    phyAddr = VIRT_HIGHMEM_BASE;
> -    memory_region_init_alias(&lvms->highmem, NULL, "loongarch.node0.highram",
> -                              machine->ram, offset, highram_size);
> -    memory_region_add_subregion(address_space_mem, phyAddr, &lvms->highmem);
> -
> -    /* Node1 - Nodemax memory */
> -    offset += highram_size;
> -    phyAddr += highram_size;
> -
> -    for (i = 1; i < nb_numa_nodes; i++) {
> -        MemoryRegion *nodemem = g_new(MemoryRegion, 1);
> -        g_autofree char *ramName = g_strdup_printf("loongarch.node%d.ram", i);
> -        memory_region_init_alias(nodemem, NULL, ramName, machine->ram,
> -                                 offset,  numa_info[i].node_mem);
> -        memory_region_add_subregion(address_space_mem, phyAddr, nodemem);
> -        offset += numa_info[i].node_mem;
> -        phyAddr += numa_info[i].node_mem;
> +    size = ram_size;
> +    base = VIRT_LOWMEM_BASE;
> +    if (size > VIRT_LOWMEM_SIZE) {
> +        size = VIRT_LOWMEM_SIZE;
>       }
>   
> +    memory_region_init_alias(&lvms->lowmem, NULL, "loongarch.lowram",
> +                              machine->ram, base, size);
> +    memory_region_add_subregion(address_space_mem, base, &lvms->lowmem);
> +    base += size;
> +    if (ram_size - size) {
> +        base = VIRT_HIGHMEM_BASE;
> +        memory_region_init_alias(&lvms->highmem, NULL, "loongarch.highram",
> +                machine->ram, VIRT_LOWMEM_BASE + size, ram_size - size);
> +        memory_region_add_subregion(address_space_mem, base, &lvms->highmem);
> +        base += ram_size - size;
> +     }
an extra space before '}'

Reviewed-by: Song Gao <gaosong@loongson.cn>

Thanks.
Song Gao
> +
>       /* initialize device memory address space */
>       if (machine->ram_size < machine->maxram_size) {
>           ram_addr_t device_mem_size = machine->maxram_size - machine->ram_size;
> -        hwaddr device_mem_base;
>   
>           if (machine->ram_slots > ACPI_MAX_RAM_SLOTS) {
>               error_report("unsupported amount of memory slots: %"PRIu64,
> @@ -1064,9 +1047,7 @@ static void virt_init(MachineState *machine)
>                            "%d bytes", TARGET_PAGE_SIZE);
>               exit(EXIT_FAILURE);
>           }
> -        /* device memory base is the top of high memory address. */
> -        device_mem_base = ROUND_UP(VIRT_HIGHMEM_BASE + highram_size, 1 * GiB);
> -        machine_memory_devices_init(machine, device_mem_base, device_mem_size);
> +        machine_memory_devices_init(machine, base, device_mem_size);
>       }
>   
>       /* load the BIOS image. */


