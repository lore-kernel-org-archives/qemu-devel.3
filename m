Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EA6AC25B77
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 07:19:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9gFn-0003h0-HL; Wed, 22 May 2024 03:19:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1s9gFk-0003gc-If
 for qemu-devel@nongnu.org; Wed, 22 May 2024 03:19:12 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1s9gFh-00070o-Af
 for qemu-devel@nongnu.org; Wed, 22 May 2024 03:19:12 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8Bx369fnE1mQ5MCAA--.1990S3;
 Wed, 22 May 2024 15:18:55 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8CxZcVcnE1mAD0FAA--.4435S3; 
 Wed, 22 May 2024 15:18:55 +0800 (CST)
Subject: Re: [PATCH v3 3/6] hw/loongarch: Refine fwcfg memory map
To: Bibo Mao <maobibo@loongson.cn>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240515093927.3453674-1-maobibo@loongson.cn>
 <20240515093927.3453674-4-maobibo@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <d016a31c-76fb-458e-9d75-73cefe9db0c5@loongson.cn>
Date: Wed, 22 May 2024 15:18:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20240515093927.3453674-4-maobibo@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8CxZcVcnE1mAD0FAA--.4435S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxWF4xtF17Ar17AF17Kw4UAwc_yoW5Kw4xpF
 4SqFsagw48JF9rGF1fKa4UWas8Ar1kKay29FW7CF1vkrn7Cr109F48Jw1qqFWkCry8AFy0
 qF4qkrZxu3WYqrXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
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
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8cz
 VUUUUUU==
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
> Memory map table for fwcfg is used for UEFI BIOS, UEFI BIOS uses the first
> entry from fwcfg memory map as the first memory HOB, the second memory HOB
> will be used if the first memory HOB is used up.
>
> Memory map table for fwcfg does not care about numa node, however in
> generic the first memory HOB is part of numa node0, so that runtime
> memory of UEFI which is allocated from the first memory HOB is located
> at numa node0.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
Reviewed-by: Song Gao <gaosong@loongson.cn>

Thanks.
Song Gao
>   hw/loongarch/virt.c | 60 ++++++++++++++++++++++++++++++++++++++++++---
>   1 file changed, 57 insertions(+), 3 deletions(-)
>
> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
> index c996305d87..b67d691fa5 100644
> --- a/hw/loongarch/virt.c
> +++ b/hw/loongarch/virt.c
> @@ -912,6 +912,62 @@ static const MemoryRegionOps virt_iocsr_misc_ops = {
>       },
>   };
>   
> +static void fw_cfg_add_memory(MachineState *ms)
> +{
> +    hwaddr base, size, ram_size, gap;
> +    int nb_numa_nodes, nodes;
> +    NodeInfo *numa_info;
> +
> +    ram_size = ms->ram_size;
> +    base = VIRT_LOWMEM_BASE;
> +    gap = VIRT_LOWMEM_SIZE;
> +    nodes = nb_numa_nodes = ms->numa_state->num_nodes;
> +    numa_info = ms->numa_state->nodes;
> +    if (!nodes) {
> +        nodes = 1;
> +    }
> +
> +    /* add fw_cfg memory map of node0 */
> +    if (nb_numa_nodes) {
> +        size = numa_info[0].node_mem;
> +    } else {
> +        size = ram_size;
> +    }
> +
> +    if (size >= gap) {
> +        memmap_add_entry(base, gap, 1);
> +        size -= gap;
> +        base = VIRT_HIGHMEM_BASE;
> +        gap = ram_size - VIRT_LOWMEM_SIZE;
> +    }
> +
> +    if (size) {
> +        memmap_add_entry(base, size, 1);
> +        base += size;
> +    }
> +
> +    if (nodes < 2) {
> +        return;
> +    }
> +
> +    /* add fw_cfg memory map of other nodes */
> +    size = ram_size - numa_info[0].node_mem;
> +    gap  = VIRT_LOWMEM_BASE + VIRT_LOWMEM_SIZE;
> +    if (base < gap && (base + size) > gap) {
> +        /*
> +         * memory map for the maining nodes splited into two part
> +         *   lowram:  [base, +(gap - base))
> +         *   highram: [VIRT_HIGHMEM_BASE, +(size - (gap - base)))
> +         */
> +        memmap_add_entry(base, gap - base, 1);
> +        size -= gap - base;
> +        base = VIRT_HIGHMEM_BASE;
> +    }
> +
> +   if (size)
> +        memmap_add_entry(base, size, 1);
> +}
> +
>   static void virt_init(MachineState *machine)
>   {
>       LoongArchCPU *lacpu;
> @@ -958,9 +1014,9 @@ static void virt_init(MachineState *machine)
>       }
>       fdt_add_cpu_nodes(lvms);
>       fdt_add_memory_nodes(machine);
> +    fw_cfg_add_memory(machine);
>   
>       /* Node0 memory */
> -    memmap_add_entry(VIRT_LOWMEM_BASE, VIRT_LOWMEM_SIZE, 1);
>       memory_region_init_alias(&lvms->lowmem, NULL, "loongarch.node0.lowram",
>                                machine->ram, offset, VIRT_LOWMEM_SIZE);
>       memory_region_add_subregion(address_space_mem, phyAddr, &lvms->lowmem);
> @@ -973,7 +1029,6 @@ static void virt_init(MachineState *machine)
>           highram_size = ram_size - VIRT_LOWMEM_SIZE;
>       }
>       phyAddr = VIRT_HIGHMEM_BASE;
> -    memmap_add_entry(phyAddr, highram_size, 1);
>       memory_region_init_alias(&lvms->highmem, NULL, "loongarch.node0.highram",
>                                 machine->ram, offset, highram_size);
>       memory_region_add_subregion(address_space_mem, phyAddr, &lvms->highmem);
> @@ -988,7 +1043,6 @@ static void virt_init(MachineState *machine)
>           memory_region_init_alias(nodemem, NULL, ramName, machine->ram,
>                                    offset,  numa_info[i].node_mem);
>           memory_region_add_subregion(address_space_mem, phyAddr, nodemem);
> -        memmap_add_entry(phyAddr, numa_info[i].node_mem, 1);
>           offset += numa_info[i].node_mem;
>           phyAddr += numa_info[i].node_mem;
>       }


