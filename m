Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5738FC25B10
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 01:31:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s49ew-00070r-GE; Mon, 06 May 2024 21:30:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1s49ef-0006zR-NQ
 for qemu-devel@nongnu.org; Mon, 06 May 2024 21:30:13 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1s49ec-00060l-6m
 for qemu-devel@nongnu.org; Mon, 06 May 2024 21:30:05 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8CxCuoQhDlmgaIIAA--.11262S3;
 Tue, 07 May 2024 09:29:52 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8CxIlYMhDlmDHETAA--.21951S3; 
 Tue, 07 May 2024 09:29:50 +0800 (CST)
Subject: Re: [PULL 3/5] hw/loongarch: Add numa support
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 Tianrui Zhao <zhaotianrui@loongson.cn>
References: <20230616100158.1845239-1-gaosong@loongson.cn>
 <20230616100158.1845239-4-gaosong@loongson.cn>
 <CAFEAcA_iu05EA+XZ4ENW_5QZ4uxLNzmY5FV9W_Ev1KFaZaJ+hw@mail.gmail.com>
From: gaosong <gaosong@loongson.cn>
Message-ID: <489aec57-4c01-ac41-8133-765bbf55e782@loongson.cn>
Date: Tue, 7 May 2024 09:29:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_iu05EA+XZ4ENW_5QZ4uxLNzmY5FV9W_Ev1KFaZaJ+hw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8CxIlYMhDlmDHETAA--.21951S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxJw4DWrW8WF4UZw4kJFyUXFc_yoW5Kr1rpF
 s3tF1jgFW8tFn7Cr4xKF98WFykJwn5K3W7uFW7Ca1S9rn7Crn2kFykWw429Fyjy34xJF1Y
 vr4DtrZI9as8K3cCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
 14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
 kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
 wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
 4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1wL05UU
 UUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.593,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

在 2024/5/3 下午8:50, Peter Maydell 写道:
> On Fri, 16 Jun 2023 at 11:03, Song Gao <gaosong@loongson.cn> wrote:
>> From: Tianrui Zhao <zhaotianrui@loongson.cn>
>>
>> 1. Implement some functions for LoongArch numa support;
>> 2. Implement fdt_add_memory_node() for fdt;
>> 3. build_srat() fills node_id and adds build numa memory.
>>
>> Reviewed-by: Song Gao <gaosong@loongson.cn>
>> Signed-off-by: Tianrui Zhao <zhaotianrui@loongson.cn>
>> Signed-off-by: Song Gao <gaosong@loongson.cn>
>> Message-Id: <20230613122613.2471743-1-zhaotianrui@loongson.cn>
> Hi; Coverity has pointed out a memory leak in this commit
> (CID 1544773):
>
>> @@ -799,17 +823,43 @@ static void loongarch_init(MachineState *machine)
>>           machine->possible_cpus->cpus[i].cpu = OBJECT(cpu);
>>       }
>>       fdt_add_cpu_nodes(lams);
>> -    /* Add memory region */
>> -    memory_region_init_alias(&lams->lowmem, NULL, "loongarch.lowram",
>> -                             machine->ram, 0, 256 * MiB);
>> -    memory_region_add_subregion(address_space_mem, offset, &lams->lowmem);
>> -    offset += 256 * MiB;
>> -    memmap_add_entry(0, 256 * MiB, 1);
>> -    highram_size = ram_size - 256 * MiB;
>> -    memory_region_init_alias(&lams->highmem, NULL, "loongarch.highmem",
>> -                             machine->ram, offset, highram_size);
>> -    memory_region_add_subregion(address_space_mem, 0x90000000, &lams->highmem);
>> -    memmap_add_entry(0x90000000, highram_size, 1);
>> +
>> +    /* Node0 memory */
>> +    memmap_add_entry(VIRT_LOWMEM_BASE, VIRT_LOWMEM_SIZE, 1);
>> +    fdt_add_memory_node(machine, VIRT_LOWMEM_BASE, VIRT_LOWMEM_SIZE, 0);
>> +    memory_region_init_alias(&lams->lowmem, NULL, "loongarch.node0.lowram",
>> +                             machine->ram, offset, VIRT_LOWMEM_SIZE);
>> +    memory_region_add_subregion(address_space_mem, phyAddr, &lams->lowmem);
>> +
>> +    offset += VIRT_LOWMEM_SIZE;
>> +    if (nb_numa_nodes > 0) {
>> +        assert(numa_info[0].node_mem > VIRT_LOWMEM_SIZE);
>> +        highram_size = numa_info[0].node_mem - VIRT_LOWMEM_SIZE;
>> +    } else {
>> +        highram_size = ram_size - VIRT_LOWMEM_SIZE;
>> +    }
>> +    phyAddr = VIRT_HIGHMEM_BASE;
>> +    memmap_add_entry(phyAddr, highram_size, 1);
>> +    fdt_add_memory_node(machine, phyAddr, highram_size, 0);
>> +    memory_region_init_alias(&lams->highmem, NULL, "loongarch.node0.highram",
>> +                              machine->ram, offset, highram_size);
>> +    memory_region_add_subregion(address_space_mem, phyAddr, &lams->highmem);
>> +
>> +    /* Node1 - Nodemax memory */
>> +    offset += highram_size;
>> +    phyAddr += highram_size;
>> +
>> +    for (i = 1; i < nb_numa_nodes; i++) {
>> +        MemoryRegion *nodemem = g_new(MemoryRegion, 1);
>> +        ramName = g_strdup_printf("loongarch.node%d.ram", i);
>> +        memory_region_init_alias(nodemem, NULL, ramName, machine->ram,
>> +                                 offset,  numa_info[i].node_mem);
>> +        memory_region_add_subregion(address_space_mem, phyAddr, nodemem);
>> +        memmap_add_entry(phyAddr, numa_info[i].node_mem, 1);
>> +        fdt_add_memory_node(machine, phyAddr, numa_info[i].node_mem, i);
>> +        offset += numa_info[i].node_mem;
>> +        phyAddr += numa_info[i].node_mem;
> In this loop, we allocate memory via g_strdup_printf(),
> but never free it. The nicest fix for this is to use the
> g_autofree mechanism so that the memory is automatically
> freed when execution reaches the end of the block:
>     g_autofree ramName = g_strdup_printf("....", ...);
Thank you.   I will fix it.

Thanks
Song Gao
> thanks
> -- PMM


