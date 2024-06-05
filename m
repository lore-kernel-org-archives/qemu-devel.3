Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18398C25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 03:33:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEhOd-0007zm-Gm; Tue, 04 Jun 2024 23:33:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1sEhOc-0007zP-6U
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 23:33:06 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1sEhOa-00076A-6v
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 23:33:05 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8DxP_Bs3F9m858DAA--.15641S3;
 Wed, 05 Jun 2024 11:33:00 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxlsVs3F9m5xkVAA--.42291S3; 
 Wed, 05 Jun 2024 11:33:00 +0800 (CST)
Subject: Re: [PATCH v3 4/4] hw/intc/loongson_ipi: Replace ipi_getcpu with
 cpu_by_arch_id
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
References: <20240605-loongson3-ipi-v3-0-ddd2c0e03fa3@flygoat.com>
 <20240605-loongson3-ipi-v3-4-ddd2c0e03fa3@flygoat.com>
From: gaosong <gaosong@loongson.cn>
Message-ID: <05a0391e-44b2-6ff8-5553-4a31969cfd52@loongson.cn>
Date: Wed, 5 Jun 2024 11:33:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20240605-loongson3-ipi-v3-4-ddd2c0e03fa3@flygoat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8BxlsVs3F9m5xkVAA--.42291S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7tFWxtF4rXr17WF4fKr1kCrX_yoW5Jr1UpF
 43u3WSgr45tFy3Jw1rJw4DXr17Arn3X343X3Wvg3ZYvFn8u34UWr1kK34Svr93u34jkr15
 ZFsxGFnxWF17trbCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4UJVWxJr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
 xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r12
 6r1DMcIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
 1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
 JVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
 vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IY
 x2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26c
 xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAF
 wI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8uuWJUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.522,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

在 2024/6/5 上午10:15, Jiaxun Yang 写道:
> cpu_by_arch_id is doing the same thing as our ipi_getcpu logic.
>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
Reviewed-by: Song Gao <gaosong@loongson.cn>

Thanks.
Song Gao
>   hw/intc/loongson_ipi.c | 39 +++------------------------------------
>   1 file changed, 3 insertions(+), 36 deletions(-)
>
> diff --git a/hw/intc/loongson_ipi.c b/hw/intc/loongson_ipi.c
> index c8a25b4eb8e2..b3cda5972793 100644
> --- a/hw/intc/loongson_ipi.c
> +++ b/hw/intc/loongson_ipi.c
> @@ -118,39 +118,6 @@ static MemTxResult send_ipi_data(CPUState *cpu, uint64_t val, hwaddr addr,
>       return MEMTX_OK;
>   }
>   
> -static int archid_cmp(const void *a, const void *b)
> -{
> -   CPUArchId *archid_a = (CPUArchId *)a;
> -   CPUArchId *archid_b = (CPUArchId *)b;
> -
> -   return archid_a->arch_id - archid_b->arch_id;
> -}
> -
> -static CPUArchId *find_cpu_by_archid(MachineState *ms, uint32_t id)
> -{
> -    CPUArchId apic_id, *found_cpu;
> -
> -    apic_id.arch_id = id;
> -    found_cpu = bsearch(&apic_id, ms->possible_cpus->cpus,
> -        ms->possible_cpus->len, sizeof(*ms->possible_cpus->cpus),
> -        archid_cmp);
> -
> -    return found_cpu;
> -}
> -
> -static CPUState *ipi_getcpu(int arch_id)
> -{
> -    MachineState *machine = MACHINE(qdev_get_machine());
> -    CPUArchId *archid;
> -
> -    archid = find_cpu_by_archid(machine, arch_id);
> -    if (archid) {
> -        return CPU(archid->cpu);
> -    }
> -
> -    return NULL;
> -}
> -
>   static MemTxResult mail_send(uint64_t val, MemTxAttrs attrs)
>   {
>       uint32_t cpuid;
> @@ -158,7 +125,7 @@ static MemTxResult mail_send(uint64_t val, MemTxAttrs attrs)
>       CPUState *cs;
>   
>       cpuid = extract32(val, 16, 10);
> -    cs = ipi_getcpu(cpuid);
> +    cs = cpu_by_arch_id(cpuid);
>       if (cs == NULL) {
>           return MEMTX_DECODE_ERROR;
>       }
> @@ -176,7 +143,7 @@ static MemTxResult any_send(uint64_t val, MemTxAttrs attrs)
>       CPUState *cs;
>   
>       cpuid = extract32(val, 16, 10);
> -    cs = ipi_getcpu(cpuid);
> +    cs = cpu_by_arch_id(cpuid);
>       if (cs == NULL) {
>           return MEMTX_DECODE_ERROR;
>       }
> @@ -227,7 +194,7 @@ static MemTxResult loongson_ipi_core_writel(void *opaque, hwaddr addr,
>           cpuid = extract32(val, 16, 10);
>           /* IPI status vector */
>           vector = extract8(val, 0, 5);
> -        cs = ipi_getcpu(cpuid);
> +        cs = cpu_by_arch_id(cpuid);
>           if (cs == NULL || cs->cpu_index >= ipi->num_cpu) {
>               return MEMTX_DECODE_ERROR;
>           }
>


