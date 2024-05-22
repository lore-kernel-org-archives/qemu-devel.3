Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D2D6C25B74
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 01:48:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9b4l-0005FC-2l; Tue, 21 May 2024 21:47:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1s9b4j-0005Dc-Hd
 for qemu-devel@nongnu.org; Tue, 21 May 2024 21:47:29 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1s9b4g-0000w6-GT
 for qemu-devel@nongnu.org; Tue, 21 May 2024 21:47:29 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8BxHOupTk1mUn8CAA--.5244S3;
 Wed, 22 May 2024 09:47:21 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Cx78enTk1mcewEAA--.14349S3; 
 Wed, 22 May 2024 09:47:21 +0800 (CST)
Subject: Re: [PATCH v3 2/6] hw/loongarch: Refine fadt memory table for numa
 memory
To: Bibo Mao <maobibo@loongson.cn>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240515093927.3453674-1-maobibo@loongson.cn>
 <20240515093927.3453674-3-maobibo@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <74612e74-d5c3-391a-d72a-adbac473a93b@loongson.cn>
Date: Wed, 22 May 2024 09:47:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20240515093927.3453674-3-maobibo@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8Cx78enTk1mcewEAA--.14349S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxJFyUJr1fuF1rKFW8AFy5GFX_yoW5tr1xpF
 4fKFn5uF4UtFnrGw1fKFyUuFn8Jr18Ka17WFy7uanakFnrCr1I9F48Xw4qqFyYk348ZF1Y
 qF1DGrZxW3WYqrXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
 14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
 kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
 wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
 4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8r9N3UU
 UUU==
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
> One LoongArch virt machine platform, there is limitation for memory
> map information. The minimum memory size is 256M and minimum memory
> size for numa node0 is 256M also. With qemu numa qtest, it is possible
> that memory size of numa node0 is 128M.
>
> Limitations for minimum memory size for both total memory and numa
> node0 is removed for fadt numa memory table creation.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
Reviewed-by: Song Gao <gaosong@loongson.cn>

Thanks.
Song Gao
>   hw/loongarch/virt.c | 46 ++++++++++++++++++++++++++++++++++++++++++---
>   1 file changed, 43 insertions(+), 3 deletions(-)
>
> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
> index f0640d2d80..c996305d87 100644
> --- a/hw/loongarch/virt.c
> +++ b/hw/loongarch/virt.c
> @@ -473,6 +473,48 @@ static void fdt_add_memory_node(MachineState *ms,
>       g_free(nodename);
>   }
>   
> +static void fdt_add_memory_nodes(MachineState *ms)
> +{
> +    hwaddr base, size, ram_size, gap;
> +    int i, nb_numa_nodes, nodes;
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
> +    for (i = 0; i < nodes; i++) {
> +        if (nb_numa_nodes) {
> +            size = numa_info[i].node_mem;
> +        } else {
> +            size = ram_size;
> +        }
> +
> +        /*
> +         * memory for the node splited into two part
> +         *   lowram:  [base, +gap)
> +         *   highram: [VIRT_HIGHMEM_BASE, +(len - gap))
> +         */
> +        if (size >= gap) {
> +            fdt_add_memory_node(ms, base, gap, i);
> +            size -= gap;
> +            base = VIRT_HIGHMEM_BASE;
> +            gap = ram_size - VIRT_LOWMEM_SIZE;
> +        }
> +
> +        if (size) {
> +            fdt_add_memory_node(ms, base, size, i);
> +            base += size;
> +            gap -= size;
> +        }
> +    }
> +}
> +
>   static void virt_build_smbios(LoongArchVirtMachineState *lvms)
>   {
>       MachineState *ms = MACHINE(lvms);
> @@ -915,10 +957,10 @@ static void virt_init(MachineState *machine)
>           lacpu->phy_id = machine->possible_cpus->cpus[i].arch_id;
>       }
>       fdt_add_cpu_nodes(lvms);
> +    fdt_add_memory_nodes(machine);
>   
>       /* Node0 memory */
>       memmap_add_entry(VIRT_LOWMEM_BASE, VIRT_LOWMEM_SIZE, 1);
> -    fdt_add_memory_node(machine, VIRT_LOWMEM_BASE, VIRT_LOWMEM_SIZE, 0);
>       memory_region_init_alias(&lvms->lowmem, NULL, "loongarch.node0.lowram",
>                                machine->ram, offset, VIRT_LOWMEM_SIZE);
>       memory_region_add_subregion(address_space_mem, phyAddr, &lvms->lowmem);
> @@ -932,7 +974,6 @@ static void virt_init(MachineState *machine)
>       }
>       phyAddr = VIRT_HIGHMEM_BASE;
>       memmap_add_entry(phyAddr, highram_size, 1);
> -    fdt_add_memory_node(machine, phyAddr, highram_size, 0);
>       memory_region_init_alias(&lvms->highmem, NULL, "loongarch.node0.highram",
>                                 machine->ram, offset, highram_size);
>       memory_region_add_subregion(address_space_mem, phyAddr, &lvms->highmem);
> @@ -948,7 +989,6 @@ static void virt_init(MachineState *machine)
>                                    offset,  numa_info[i].node_mem);
>           memory_region_add_subregion(address_space_mem, phyAddr, nodemem);
>           memmap_add_entry(phyAddr, numa_info[i].node_mem, 1);
> -        fdt_add_memory_node(machine, phyAddr, numa_info[i].node_mem, i);
>           offset += numa_info[i].node_mem;
>           phyAddr += numa_info[i].node_mem;
>       }


