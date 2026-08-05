Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14BC2C55174
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 09:15:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrXih-0002VR-Qj; Wed, 05 Aug 2026 05:15:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <17746591750@163.com>)
 id 1wrXiV-0002Sy-F9
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 05:15:15 -0400
Received: from m16.mail.163.com ([220.197.31.4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <17746591750@163.com>)
 id 1wrXiT-0001Hs-Cn
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 05:15:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Subject:To:From:Message-ID:Date:MIME-Version:
 Content-Type; bh=3jzEdz8rhQc1ijMgLLUfcFpTWIIc7ojSpMgTk1FWpBY=;
 b=JIFRwa6gFQ9/P7/GoheF7vNIzY5dFuM89/850YDNCV/CR6td454dY/+DPwk62b
 byWYTvKrH9/jrs/J1uxBkXSrF6Cmtlf/1HnGsZk+eXaZ7LvrEPtf8CnKxT2ZuavV
 5zwupyUxag71NSUA67hQLaZi3u8eEncToxMMcmFLDoVJY=
Received: from [10.2.10.30] (unknown [])
 by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id
 _____wD370VQ_nJqoa4gNQ--.39031S2; 
 Wed, 05 Aug 2026 17:11:45 +0800 (CST)
Subject: Re: [PATCH v2] target/loongarch: Fix SWI interrupt delivery via
 CSR_ESTAT
To: Bibo Mao <maobibo@loongson.cn>
Cc: Xianglai Li <lixianglai@loongson.cn>,
 "Andrew S . Rightenburg" <andrew@rail5.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
References: <20260805084705.898107-1-maobibo@loongson.cn>
From: Song Gao <17746591750@163.com>
Message-ID: <3d1b013d-2cc0-91ea-5aa7-42c2a9a08ccd@163.com>
Date: Wed, 5 Aug 2026 17:11:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20260805084705.898107-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: _____wD370VQ_nJqoa4gNQ--.39031S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZw13Jryrtryrtw4UGw4kJFb_yoWrGFyfpr
 W7u3W5Kw48KrWDAa4agas09rn8Zr4xGr129an3t34xCw45Xr1aqr1kt39FgFs8C34UWr40
 qF1Fkw1UZay8Za7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRgtxgUUUUU=
X-Originating-IP: [114.242.206.180]
X-CM-SenderInfo: jprxlkywvzilivq6il2tof0z/xtbC8hELFGpy-lGtoAAA3G
Received-SPF: pass client-ip=220.197.31.4; envelope-from=17746591750@163.com;
 helo=m16.mail.163.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, FROM_LOCAL_DIGITS=0.001,
 FROM_LOCAL_HEX=0.006, NICE_REPLY_A=-2.999, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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


在 2026/8/5 下午4:47, Bibo Mao 写道:
> In TCG mode, helper_csrwr_estat() updates CSR.ESTAT.IS[1:0] (SWI0/SWI1)
> when the guest writes CSR_ESTAT, but it did not update the CPU interrupt
> request state. As a result, software interrupts could be observed as pending
> in CSR.ESTAT while no interrupt exception was taken.
>
> Update CPU_INTERRUPT_HARD after modifying CSR_ESTAT, matching the behavior of
> loongarch_cpu_set_irq(). The helper runs without the Big QEMU Lock (BQL), so
> take the BQL while calling cpu_interrupt().
>
> Fixes: 5b1dedfe848b ("target/loongarch: Add LoongArch CSR instruction")
> Reported-by: Andrew S. Rightenburg <andrew@rail5.org>
> Signed-off-by: Andrew S. Rightenburg <andrew@rail5.org>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   target/loongarch/cpu.c            | 20 ++++++++++++++------
>   target/loongarch/internals.h      |  1 +
>   target/loongarch/tcg/csr_helper.c | 10 ++++++++++
>   3 files changed, 25 insertions(+), 6 deletions(-)

Reviewed-by:  Song Gao <17746591750@163.com>

Thanks.
Song Gao
> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
> index fb03424ffa..4d9f7b08de 100644
> --- a/target/loongarch/cpu.c
> +++ b/target/loongarch/cpu.c
> @@ -57,11 +57,23 @@ static vaddr loongarch_cpu_get_pc(CPUState *cs)
>   #ifndef CONFIG_USER_ONLY
>   #include "hw/loongarch/virt.h"
>   
> +void loongarch_cpu_update_irq(LoongArchCPU *cpu)
> +{
> +    CPULoongArchState *env = &cpu->env;
> +    CPUState *cs = CPU(cpu);
> +    CPUSysState *sys = env_sys(env);
> +
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
>       CPULoongArchState *env = &cpu->env;
> -    CPUState *cs = CPU(cpu);
>       CPUSysState *sys = env_sys(env);
>   
>       if (irq < 0 || irq >= N_IRQS) {
> @@ -72,11 +84,7 @@ void loongarch_cpu_set_irq(void *opaque, int irq, int level)
>           kvm_loongarch_set_interrupt(cpu, irq, level);
>       } else if (tcg_enabled()) {
>           sys->CSR_ESTAT = deposit64(sys->CSR_ESTAT, irq, 1, level != 0);
> -        if (FIELD_EX64(sys->CSR_ESTAT, CSR_ESTAT, IS)) {
> -            cpu_interrupt(cs, CPU_INTERRUPT_HARD);
> -        } else {
> -            cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
> -        }
> +        loongarch_cpu_update_irq(cpu);
>       }
>   }
>   
> diff --git a/target/loongarch/internals.h b/target/loongarch/internals.h
> index e01dbed40f..40565ee91b 100644
> --- a/target/loongarch/internals.h
> +++ b/target/loongarch/internals.h
> @@ -31,6 +31,7 @@ void restore_fp_status(CPULoongArchState *env);
>   #ifndef CONFIG_USER_ONLY
>   extern const VMStateDescription vmstate_loongarch_cpu;
>   
> +void loongarch_cpu_update_irq(LoongArchCPU *cpu);
>   void loongarch_cpu_set_irq(void *opaque, int irq, int level);
>   
>   void loongarch_constant_timer_cb(void *opaque);
> diff --git a/target/loongarch/tcg/csr_helper.c b/target/loongarch/tcg/csr_helper.c
> index 7dc33bc180..a9db071098 100644
> --- a/target/loongarch/tcg/csr_helper.c
> +++ b/target/loongarch/tcg/csr_helper.c
> @@ -106,6 +106,16 @@ target_ulong helper_csrwr_estat(CPULoongArchState *env, target_ulong val)
>   
>       /* Only IS[1:0] can be written */
>       sys->CSR_ESTAT = deposit64(sys->CSR_ESTAT, 0, 2, val);
> +    /*
> +     * Software interrupts (SWI0/SWI1) are latched in CSR.ESTAT.IS[1:0].
> +     * Make sure the CPU interrupt request state tracks the pending bits,
> +     * matching the behavior of loongarch_cpu_set_irq().
> +     */
> +    if ((old_v ^ val) & 0x3) {
> +        bql_lock();
> +        loongarch_cpu_update_irq(env_archcpu(env));
> +        bql_unlock();
> +    }
>   
>       return old_v;
>   }
>
> base-commit: b428fe036233cbd15d37e3c027ab6ca4d3661a80


