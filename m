Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7C97C25B74
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 01:37:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9auM-0001hf-1z; Tue, 21 May 2024 21:36:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1s9auJ-0001f1-I1
 for qemu-devel@nongnu.org; Tue, 21 May 2024 21:36:43 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1s9auF-0006SH-FB
 for qemu-devel@nongnu.org; Tue, 21 May 2024 21:36:42 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8AxiuoiTE1mCH4CAA--.2392S3;
 Wed, 22 May 2024 09:36:34 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxnscfTE1mXukEAA--.14446S3; 
 Wed, 22 May 2024 09:36:33 +0800 (CST)
Subject: Re: [PATCH v3 1/6] hw/loongarch: Refine acpi srat table for numa
 memory
To: Bibo Mao <maobibo@loongson.cn>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240515093927.3453674-1-maobibo@loongson.cn>
 <20240515093927.3453674-2-maobibo@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <08072a29-c2c2-4940-5094-48fd52e13d52@loongson.cn>
Date: Wed, 22 May 2024 09:36:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20240515093927.3453674-2-maobibo@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8BxnscfTE1mXukEAA--.14446S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxJFyUJr1fuF1rKFW8JrWfXrc_yoW5try8pa
 1fWr9avr13GFnxGrn3KF1UWF95Jr1kGay7Za47CrZ5uFsF9ryrWry8K3sFyFWDK348Zr18
 ZF1Dtr98Ga1SvrgCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
 14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
 kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
 wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
 4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8czVUUU
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
> node0 is removed for acpi srat table creation.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
Reviewed-by: Song Gao <gaosong@loongson.cn>

Thanks.
Song Gao
>   hw/loongarch/acpi-build.c | 58 +++++++++++++++++++++++----------------
>   1 file changed, 34 insertions(+), 24 deletions(-)
>
> diff --git a/hw/loongarch/acpi-build.c b/hw/loongarch/acpi-build.c
> index 5ef010d4da..af45ce526d 100644
> --- a/hw/loongarch/acpi-build.c
> +++ b/hw/loongarch/acpi-build.c
> @@ -166,8 +166,9 @@ static void
>   build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
>   {
>       int i, arch_id, node_id;
> -    uint64_t mem_len, mem_base;
> -    int nb_numa_nodes = machine->numa_state->num_nodes;
> +    hwaddr len, base, gap;
> +    NodeInfo *numa_info;
> +    int nodes, nb_numa_nodes = machine->numa_state->num_nodes;
>       LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(machine);
>       MachineClass *mc = MACHINE_GET_CLASS(lvms);
>       const CPUArchIdList *arch_ids = mc->possible_cpu_arch_ids(machine);
> @@ -196,35 +197,44 @@ build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
>           build_append_int_noprefix(table_data, 0, 4); /* Reserved */
>       }
>   
> -    /* Node0 */
> -    build_srat_memory(table_data, VIRT_LOWMEM_BASE, VIRT_LOWMEM_SIZE,
> -                      0, MEM_AFFINITY_ENABLED);
> -    mem_base = VIRT_HIGHMEM_BASE;
> -    if (!nb_numa_nodes) {
> -        mem_len = machine->ram_size - VIRT_LOWMEM_SIZE;
> -    } else {
> -        mem_len = machine->numa_state->nodes[0].node_mem - VIRT_LOWMEM_SIZE;
> +    base = VIRT_LOWMEM_BASE;
> +    gap = VIRT_LOWMEM_SIZE;
> +    numa_info = machine->numa_state->nodes;
> +    nodes = nb_numa_nodes;
> +    if (!nodes) {
> +        nodes = 1;
>       }
> -    if (mem_len)
> -        build_srat_memory(table_data, mem_base, mem_len, 0, MEM_AFFINITY_ENABLED);
> -
> -    /* Node1 - Nodemax */
> -    if (nb_numa_nodes) {
> -        mem_base += mem_len;
> -        for (i = 1; i < nb_numa_nodes; ++i) {
> -            if (machine->numa_state->nodes[i].node_mem > 0) {
> -                build_srat_memory(table_data, mem_base,
> -                                  machine->numa_state->nodes[i].node_mem, i,
> -                                  MEM_AFFINITY_ENABLED);
> -                mem_base += machine->numa_state->nodes[i].node_mem;
> -            }
> +
> +    for (i = 0; i < nodes; i++) {
> +        if (nb_numa_nodes) {
> +            len = numa_info[i].node_mem;
> +        } else {
> +            len = machine->ram_size;
> +        }
> +
> +        /*
> +         * memory for the node splited into two part
> +         *   lowram:  [base, +gap)
> +         *   highram: [VIRT_HIGHMEM_BASE, +(len - gap))
> +         */
> +        if (len >= gap) {
> +            build_srat_memory(table_data, base, len, i, MEM_AFFINITY_ENABLED);
> +            len -= gap;
> +            base = VIRT_HIGHMEM_BASE;
> +            gap = machine->ram_size - VIRT_LOWMEM_SIZE;
> +        }
> +
> +        if (len) {
> +            build_srat_memory(table_data, base, len, i, MEM_AFFINITY_ENABLED);
> +            base += len;
> +            gap  -= len;
>           }
>       }
>   
>       if (machine->device_memory) {
>           build_srat_memory(table_data, machine->device_memory->base,
>                             memory_region_size(&machine->device_memory->mr),
> -                          nb_numa_nodes - 1,
> +                          nodes - 1,
>                             MEM_AFFINITY_HOTPLUGGABLE | MEM_AFFINITY_ENABLED);
>       }
>   


