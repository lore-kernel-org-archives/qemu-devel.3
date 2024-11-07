Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBF4CD43358
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 12:29:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t91da-0001rd-Vx; Thu, 07 Nov 2024 07:29:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1t91dS-0001rB-GT
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 07:29:15 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1t91dP-0000O4-99
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 07:29:13 -0500
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8CxC+KTsixnfFw3AA--.43765S3;
 Thu, 07 Nov 2024 20:29:07 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front1 (Coremail) with SMTP id qMiowMBxP+GSsixnZQtKAA--.44374S3;
 Thu, 07 Nov 2024 20:29:06 +0800 (CST)
Subject: Re: [PATCH v2] hw/intc/loongarch_ipi: Add safer check about cpu
To: Bibo Mao <maobibo@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
References: <20241028125747.2094026-1-maobibo@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <51f100ad-8eb0-5444-f980-042c2906dce2@loongson.cn>
Date: Thu, 7 Nov 2024 20:30:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20241028125747.2094026-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowMBxP+GSsixnZQtKAA--.44374S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxJr4xuFyDXr13ZFy3Jr1UArc_yoW8CFykpr
 yxu3Z8Kr48JryDAa95Was0gF1DXrs7Ww129an3Gr97Crs8Jryvqr48tw4qqFWDA345WrW0
 q3WSyFyDXay2qrbCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv
 67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8P5
 r7UUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 NICE_REPLY_A=-2.588, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

ÔÚ 2024/10/28 ÏÂÎç8:57, Bibo Mao Ð´µÀ:
> If cpu hotplug is enabled, all possible_cpus is initialized with
> arch_id set. For ipi interrupt controller, cpu is searched from
> possible_cpus with specified arch_id. However it is possible that
> cpu object is not created for offlined cpu.
>
> Here safer check is added. If cpu object is not created, archid->cpu
> will be NULL.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
> v1 ... v2:
>    1. since physical cpuid is the same with cpu_index when cpu_index
>       is set again as index of possible_cpus. Remove phy_id set about
>       CSR_CPUID in function loongarch_cpu_reset_hold()
> ---
>   hw/intc/loongarch_ipi.c           | 3 ++-
>   target/loongarch/tcg/csr_helper.c | 4 ----
>   2 files changed, 2 insertions(+), 5 deletions(-)
Acked-by: Song Gao <gaosong@loongson.cn>

Thanks.
Song Gao
> diff --git a/hw/intc/loongarch_ipi.c b/hw/intc/loongarch_ipi.c
> index 2ae1a42c46..78b6fce81b 100644
> --- a/hw/intc/loongarch_ipi.c
> +++ b/hw/intc/loongarch_ipi.c
> @@ -42,7 +42,8 @@ static CPUState *loongarch_cpu_by_arch_id(int64_t arch_id)
>       CPUArchId *archid;
>   
>       archid = find_cpu_by_archid(machine, arch_id);
> -    if (archid) {
> +    /* For offlined cpus, archid->cpu may be NULL */
> +    if (archid && archid->cpu) {
>           return CPU(archid->cpu);
>       }
>   
> diff --git a/target/loongarch/tcg/csr_helper.c b/target/loongarch/tcg/csr_helper.c
> index 15f94caefa..2aeca2343d 100644
> --- a/target/loongarch/tcg/csr_helper.c
> +++ b/target/loongarch/tcg/csr_helper.c
> @@ -37,10 +37,6 @@ target_ulong helper_csrrd_pgd(CPULoongArchState *env)
>   
>   target_ulong helper_csrrd_cpuid(CPULoongArchState *env)
>   {
> -    LoongArchCPU *lac = env_archcpu(env);
> -
> -    env->CSR_CPUID = CPU(lac)->cpu_index;
> -
>       return env->CSR_CPUID;
>   }
>   
>
> base-commit: cea8ac78545a83e1f01c94d89d6f5a3f6b5c05d2


