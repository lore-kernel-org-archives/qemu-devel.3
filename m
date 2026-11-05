Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFA7606A326
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 06:47:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOrFR-0005WI-5f; Thu, 05 Nov 2026 01:46:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixianglai@loongson.cn>)
 id 1xOrFK-0005Tv-Lj
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 01:46:52 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lixianglai@loongson.cn>) id 1xOrFI-000098-PY
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 01:46:50 -0500
Received: from loongson.cn (unknown [10.20.42.166])
 by gateway (Coremail) with SMTP id _____8CxfdJXJuxq_o4cAA--.17240S3;
 Thu, 05 Nov 2026 14:46:47 +0800 (CST)
Received: from [127.0.0.1] (unknown [127.0.0.1])
 by front1 (Coremail) with SMTP id qMiowJDxxMxWJuxqwIEyAA--.11137S2;
 Thu, 05 Nov 2026 14:46:46 +0800 (CST)
Subject: Re: [PATCH] target/loongarch: Support unaligned access for atomic
 instructions
To: Bibo Mao <maobibo@loongson.cn>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@mailo.com>, Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20261030031655.226617-1-maobibo@loongson.cn>
From: lixianglai <lixianglai@loongson.cn>
Message-ID: <e4319294-08c4-bca8-be9f-089b8715f35a@loongson.cn>
Date: Thu, 5 Nov 2026 14:45:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261030031655.226617-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowJDxxMxWJuxqwIEyAA--.11137S2
X-CM-SenderInfo: 5ol0xt5qjotxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxWFW7Gr45CrW5WrWDCF4rWFX_yoW5Cr13pr
 y7u345KrW8trZrA3saq34YqFn8ur1kGw42qa1ftrySkF4Yqrn7Xr1kt39FqFy8G3W8Ww1j
 qFnYyr1UXFyUWacCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE
 14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
 AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
 rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtw
 CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x02
 67AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr
 0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU84x
 RDUUUUU==
Received-SPF: pass client-ip=114.242.206.163;
 envelope-from=lixianglai@loongson.cn; helo=mail.loongson.cn
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.724,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Reviewed-by:  Xianglai Li <lixianglai@loongson.cn>

> For atomic instructions and LL/SC instruction pairs, the accessed
> address must be aligned to the access size. Otherwise, an EXCCODE_ALE
> exception is raised.
>
> Add support for unaligned address accesses for these instructions.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   target/loongarch/tcg/tcg_cpu.c       |  2 ++
>   target/loongarch/tcg/tcg_loongarch.h |  4 ++++
>   target/loongarch/tcg/tlb_helper.c    | 16 ++++++++++++++++
>   3 files changed, 22 insertions(+)
>
> diff --git a/target/loongarch/tcg/tcg_cpu.c b/target/loongarch/tcg/tcg_cpu.c
> index cbf0e12c81..0549506035 100644
> --- a/target/loongarch/tcg/tcg_cpu.c
> +++ b/target/loongarch/tcg/tcg_cpu.c
> @@ -92,6 +92,7 @@ static void loongarch_cpu_do_interrupt(CPUState *cs)
>       case EXCCODE_PME:
>       case EXCCODE_PNR:
>       case EXCCODE_PPI:
> +    case EXCCODE_ALE:
>           cause = cs->exception_index;
>           break;
>       default:
> @@ -289,5 +290,6 @@ const TCGCPUOps loongarch_tcg_ops = {
>       .cpu_exec_reset = cpu_reset,
>       .do_interrupt = loongarch_cpu_do_interrupt,
>       .do_transaction_failed = loongarch_cpu_do_transaction_failed,
> +    .do_unaligned_access = loongarch_cpu_do_unaligned_access,
>   #endif
>   };
> diff --git a/target/loongarch/tcg/tcg_loongarch.h b/target/loongarch/tcg/tcg_loongarch.h
> index 7fb627f2d6..9c8627972f 100644
> --- a/target/loongarch/tcg/tcg_loongarch.h
> +++ b/target/loongarch/tcg/tcg_loongarch.h
> @@ -15,6 +15,10 @@ void loongarch_csr_translate_init(void);
>   bool loongarch_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>                               MMUAccessType access_type, int mmu_idx,
>                               bool probe, uintptr_t retaddr);
> +G_NORETURN void loongarch_cpu_do_unaligned_access(CPUState *cs, vaddr vaddr,
> +                                                  MMUAccessType access_type,
> +                                                  int mmu_idx,
> +                                                  uintptr_t retaddr);
>   
>   TLBRet loongarch_get_addr_from_tlb(CPULoongArchState *env,
>                                      MMUContext *context,
> diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
> index a707de9876..5662b2c49a 100644
> --- a/target/loongarch/tcg/tlb_helper.c
> +++ b/target/loongarch/tcg/tlb_helper.c
> @@ -706,6 +706,22 @@ bool loongarch_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>       cpu_loop_exit_restore(cs, retaddr);
>   }
>   
> +G_NORETURN void loongarch_cpu_do_unaligned_access(CPUState *cs, vaddr vaddr,
> +                                                  MMUAccessType access_type,
> +                                                  int mmu_idx,
> +                                                  uintptr_t retaddr)
> +{
> +    CPULoongArchState *env = cpu_env(cs);
> +    CPUSysState *sys = env_sys(env);
> +
> +    /*
> +     * Unaligned accesses are currently triggered by atomic instructions
> +     * that impose alignment requirements on memory operands.
> +     */
> +    sys->CSR_BADV = vaddr;
> +    do_raise_exception(env, EXCCODE_ALE, retaddr);
> +}
> +
>   static inline uint64_t loongarch_sanitize_hw_pte(CPULoongArchState *env,
>                                                    uint64_t pte)
>   {
>
> base-commit: 73294d096cc591e122fde9e63db4739de6d84f2b


