Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5CBCC5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 09:38:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwGHE-0000v4-RX; Tue, 18 Aug 2026 05:38:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wwGHD-0000uO-C1; Tue, 18 Aug 2026 05:38:35 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wwGHA-0004Y3-QG; Tue, 18 Aug 2026 05:38:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1787045886; bh=JmfyJXkW3cYp5MdcGvzaRpYOC9KlLZA4jCCzQ4eQJRE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=E0R8GrqtaIQcGxhzWVGAtlCFjkFVRpDejeSkrpOGOlqZ9dACjQNQixjZRM3g4lnI3
 Uny+2yqg/DZ3ajdYAM3WCkhLHn7G16Vvplx212VECmUk2MUTapHm9hbByk/JX+GGGM
 PVTxwcII42U1MmXgh24efBfRdcDPsxTaulCfY5AAIiXxOAbUEb33oEjD6D5/ejLY6e
 c7VACYz4B8prPFvVBoZmDPprWBlHRBvfgNREB3dDSQuFDgPQDYTFk/Yjn07VE+8haF
 bZ+nbbnOquCsyhAKRE1kYNDE3QzPnpfqmMBqF5mPkJYOkK4onyUwjj48rM9kUrlQL/
 jVkQPVxCuLavg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 2AC921CC152;
 Tue, 18 Aug 2026 12:38:06 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id F21AD40DC0C;
 Tue, 18 Aug 2026 12:38:28 +0300 (MSK)
Message-ID: <f0b5bad1-4652-4d20-9e5d-aa57f709ca93@tls.msk.ru>
Date: Tue, 18 Aug 2026 12:38:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] target/loongarch: fix data race in CSR_ESTAT
To: shankerwangmiao@gmail.com, qemu-devel@nongnu.org
Cc: Song Gao <17746591750@163.com>, Bibo Mao <maobibo@loongson.cn>,
 Xianglai Li <lixianglai@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Xi Ruoyao <xry111@xry111.site>, QEMU Stable <qemu-stable@nongnu.org>
References: <20260716-loong-race-v2-1-01e68e4b850f@gmail.com>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
Autocrypt: addr=mjt@tls.msk.ru; keydata=
 xsFNBGYpLkcBEACsajkUXU2lngbm6RyZuCljo19q/XjZTMikctzMoJnBGVSmFV66kylUghxs
 HDQQF2YZJbnhSVt/mP6+V7gG6MKR5gYXYxLmypgu2lJdqelrtGf1XtMrobG6kuKFiD8OqV6l
 2M5iyOZT3ydIFOUX0WB/B9Lz9WcQ6zYO9Ohm92tiWWORCqhAnwZy4ua/nMZW3RgO7bM6GZKt
 /SFIorK9rVqzv40D6KNnSyeWfqf4WN3EvEOozMfWrXbEqA7kvd6ShjJoe1FzCEQ71Fj9dQHL
 DZG+44QXvN650DqEtQ4RW9ozFk3Du9u8lbrXC5cqaCIO4dx4E3zxIddqf6xFfu4Oa5cotCM6
 /4dgxDoF9udvmC36qYta+zuDsnAXrYSrut5RBb0moez/AR8HD/cs/dS360CLMrl67dpmA+XD
 7KKF+6g0RH46CD4cbj9c2egfoBOc+N5XYyr+6ejzeZNf40yjMZ9SFLrcWp4yQ7cpLsSz08lk
 a0RBKTpNWJdblviPQaLW5gair3tyJR+J1ER1UWRmKErm+Uq0VgLDBDQoFd9eqfJjCwuWZECp
 z2JUO+zBuGoKDzrDIZH2ErdcPx3oSlVC2VYOk6H4cH1CWr9Ri8i91ClivRAyVTbs67ha295B
 y4XnxIVaZU+jJzNgLvrXrkI1fTg4FJSQfN4W5BLCxT4sq8BDtwARAQABzSBNaWNoYWVsIFRv
 a2FyZXYgPG1qdEB0bHMubXNrLnJ1PsLBlAQTAQoAPhYhBJ2L4U4/Kp3XkZko8WGtPZjs3yyO
 BQJmKS5HAhsDBQkSzAMABQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEGGtPZjs3yyOZSAP
 /ibilK1gbHqEI2zR2J59Dc0tjtbByVmQ8IMh0SYU3j1jeUoku2UCgdnGKpwvLXtwZINgdl6Q
 cEaDBRX6drHLJFAi/sdgwVgdnDxaWVJO/ZIN/uJI0Tx7+FSAk8CWSa4IWUOzPNmtrDfb4z6v
 G36rppY8bTNKbX6nWFXuv2LXQr7g6+kKnbwv4QFpD+UFF1CrLm3byMq4ikdBXpZx030qBL61
 b7PrfXcBLao0357kWGH6C2Zu4wBnDUJwGi68pI5rzSRAFyAQsE89sjLdR1yFoBH8NiFnAQXP
 LA8Am9FMsC7D/bi/kwKTJdcZvzdGU1HG6tJvXLWC+nqGpJNBzRdDpjqtxNuL76vVd/JbsFMS
 JchLN+01fNQ5FHglvkd6md7vO+ULq+r9An5hMiDoRbYVUOBN8uiYNk+qKbdgSfbhsgPURqHi
 1bXkgMeMasqWbGMe7iBW/YH2ePfZ6HuKLNQDCkiWZYPQZvyXHvQHjuJJ5+US81tkqM+Q6Snq
 0L/O/LD0qLlbinHrcx0abg06VXBoYmGICJpf/3hhWQM4f+B/5w4vpl8q0B6Osz01pBUBfYak
 CiYCNHMWWVZkW9ZnY7FWiiPOu8iE1s5oPYqBljk3FNUk04SDKMF5TxL87I2nMBnVnvp0ZAuY
 k9ojiLqlhaKnZ1+zwmwmPmXzFSwlyMczPUMSzsFNBGYpLkcBEAC0mxV2j5M1x7GiXqxNVyWy
 OnlWqJkbkoyMlWFSErf+RUYlC9qVGwUihgsgEhQMg0nJiSISmU3vsNEx5j0T13pTEyWXWBdS
 XtZpNEW1lZ2DptoGg+6unpvxd2wn+dqzJqlpr4AY3vc95q4Za/NptWtSCsyJebZ7DxCCkzET
 tzbbnCjW1souCETrMy+G916w1gJkz4V1jLlRMEEoJHLrr1XKDdJRk/34AqXPKOzILlWRFK6s
 zOWa80/FNQV5cvjc2eN1HsTMFY5hjG3zOZb60WqwTisJwArjQbWKF49NLHp/6MpiSXIxF/FU
 jcVYrEk9sKHN+pERnLqIjHA8023whDWvJide7f1V9lrVcFt0zRIhZOp0IAE86E3stSJhZRhY
 xyIAx4dpDrw7EURLOhu+IXLeEJbtW89tp2Ydm7TVAt5iqBubpHpGTWV7hwPRQX2w2MBq1hCn
 K5Xx79omukJisbLqG5xUCR1RZBUfBlYnArssIZSOpdJ9wWMK+fl5gn54cs+yziUYU3Tgk0fJ
 t0DzQsgfd2JkxOEzJACjJWti2Gh3szmdgdoPEJH1Og7KeqbOu2mVCJm+2PrNlzCybOZuHOV5
 +vSarkb69qg9nU+4ZGX1m+EFLDqVUt1g0SjY6QmM5yjGBA46G3dwTEV0/u5Wh7idNT0mRg8R
 eP/62iTL55AM6QARAQABwsF8BBgBCgAmFiEEnYvhTj8qndeRmSjxYa09mOzfLI4FAmYpLkcC
 GwwFCRLMAwAACgkQYa09mOzfLI53ag/+ITb3WW9iqvbjDueV1ZHwUXYvebUEyQV7BFofaJbJ
 Sr7ek46iYdV4Jdosvq1FW+mzuzrhT+QzadEfYmLKrQV4EK7oYTyQ5hcch55eX00o+hyBHqM2
 RR/B5HGLYsuyQNv7a08dAUmmi9eAktQ29IfJi+2Y+S1okAEkWFxCUs4EE8YinCrVergB/MG5
 S7lN3XxITIaW00faKbqGtNqij3vNxua7UenN8NHNXTkrCgA+65clqYI3MGwpqkPnXIpTLGl+
 wBI5S540sIjhgrmWB0trjtUNxe9QcTGHoHtLeGX9QV5KgzNKoUNZsyqh++CPXHyvcN3OFJXm
 VUNRs/O3/b1capLdrVu+LPd6Zi7KAyWUqByPkK18+kwNUZvGsAt8WuVQF5telJ6TutfO8xqT
 FUzuTAHE+IaRU8DEnBpqv0LJ4wqqQ2MeEtodT1icXQ/5EDtM7OTH231lJCR5JxXOnWPuG6el
 YPkzzso6HT7rlapB5nulYmplJZSZ4RmE1ATZKf+wUPocDu6N10LtBNbwHWTT5NLtxNJAJAvl
 ojis6H1kRWZE/n5buyPY2NYeyWfjjrerOYt3er55n4C1I88RSCTGeejVmXWuo65QD2epvzE6
 3GgKngeVm7shlp7+d3D3+fAAHTvulQQqV3jOodz+B4yzuZ7WljkNrmrWrH8aI4uA98c=
In-Reply-To: <20260716-loong-race-v2-1-01e68e4b850f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Ping?

This too, seems to be a qemu-stable material.

Thanks,

/mjt

On 7/15/26 23:48, Miao Wang via B4 Relay wrote:
> From: Miao Wang <shankerwangmiao@gmail.com>
> 
> The CSR_ESTAT register of a CPU can be read and written by both the
> CPU thread and other threads (e.g., the interrupt controller thread).
> Currently the possible readers and writers of CSR_ESTAT are:
> 
> - Readers
>    - tcg generated by trans_csrrd(, CSR_ESTAT)
>    - loongarch_cpu_has_work()
> 
> - Writers
>    - tcg generated by trans_csrxchg(, CSR_ESTAT)
>    - helper_csrwr_estat()
>    - helper_csrrd_msgir()
>    - loongarch_cpu_set_irq()
>    - loongarch_cpu_do_interrupt()
>    - loongarch_cpu_exec_interrupt()
> 
> The access from the CPU thread is not synchronized with the access from
> other threads, which may lead to data races. The above readers and
> writers shall all run on the corresponding CPU thread except for
> loongarch_cpu_set_irq(). To fix this, the access to CSR_ESTAT in
> loongarch_cpu_set_irq() is moved to the CPU thread by using
> async_run_on_cpu().
> 
> The data race has been identified while running the test cases from
> dracut, which is using QEMU to boot a LoongArch guest. By running the
> tests repeatedly (about 30 times) in the following conditions, the
> guest will hang in the middle of booting:
> 
> - Host architecture: LoongArch64 or Aarch64
> - Guest kernel: 7.1.3+deb14-loong64
> - Number of vCPUs: 1 or 2
> - CPU Features: max, la464,msgint=off,ptw=off, or la464,msgint=off,ptw=on
> - Accelerator: tcg
> 
> When the guest hangs, the guest kernel log shows various errors related
> to RCU stalls or other Soft Lockup or Hard Lockup issues. When running
> with 1 vCPU and the guest hangs, the guest kernel directly hangs without
> any messages and stucks at idle_exit.
> 
> With this patch, the guest can boot successfully without any hangs
> during repeated runs of the test cases.
> 
> Signed-off-by: Miao Wang <shankerwangmiao@gmail.com>
> ---
> Changes in v2:
> - Simplify the changes to move the access to CSR_ESTAT from the only
>    unsynchronized loongarch_cpu_set_irq() to the CPU thread using
>    async_run_on_cpu() to avoid the race condition.
> - Link to v1: https://lore.kernel.org/qemu-devel/20260714-loong-race-v1-1-54111549c95e@gmail.com
> ---
>   target/loongarch/cpu.c | 27 +++++++++++++++++++--------
>   1 file changed, 19 insertions(+), 8 deletions(-)
> 
> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
> index fb03424ffa8cd5e5d250531cc2a36fa789fc25a9..126c3ad276cc44311942542e086bcabe41d91b63 100644
> --- a/target/loongarch/cpu.c
> +++ b/target/loongarch/cpu.c
> @@ -57,12 +57,27 @@ static vaddr loongarch_cpu_get_pc(CPUState *cs)
>   #ifndef CONFIG_USER_ONLY
>   #include "hw/loongarch/virt.h"
>   
> +static void do_set_cpu_estat(CPUState *cs, run_on_cpu_data data)
> +{
> +    CPULoongArchState *env = cpu_env(cs);
> +    CPUSysState *sys = env_sys(env);
> +
> +    int irq = data.host_int;
> +    int level = irq >= 0 ? 1 : 0;
> +    irq = level ? irq : -irq;
> +
> +    sys->CSR_ESTAT = deposit64(sys->CSR_ESTAT, irq, 1, level != 0);
> +    if (FIELD_EX64(sys->CSR_ESTAT, CSR_ESTAT, IS)) {
> +        cpu_interrupt(cs, CPU_INTERRUPT_HARD);
> +    } else {
> +        cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
> +    }
> +}
> +
>   void loongarch_cpu_set_irq(void *opaque, int irq, int level)
>   {
>       LoongArchCPU *cpu = opaque;
> -    CPULoongArchState *env = &cpu->env;
>       CPUState *cs = CPU(cpu);
> -    CPUSysState *sys = env_sys(env);
>   
>       if (irq < 0 || irq >= N_IRQS) {
>           return;
> @@ -71,12 +86,8 @@ void loongarch_cpu_set_irq(void *opaque, int irq, int level)
>       if (kvm_enabled()) {
>           kvm_loongarch_set_interrupt(cpu, irq, level);
>       } else if (tcg_enabled()) {
> -        sys->CSR_ESTAT = deposit64(sys->CSR_ESTAT, irq, 1, level != 0);
> -        if (FIELD_EX64(sys->CSR_ESTAT, CSR_ESTAT, IS)) {
> -            cpu_interrupt(cs, CPU_INTERRUPT_HARD);
> -        } else {
> -            cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
> -        }
> +        async_run_on_cpu(cs, do_set_cpu_estat,
> +                         RUN_ON_CPU_HOST_INT(level ? irq : -irq));
>       }
>   }
>   
> 
> ---
> base-commit: 499039798cdad7d86b787fec0eaf1da4151c0f05
> change-id: 20260707-loong-race-63639e8f5afb
> 
> Best regards,


