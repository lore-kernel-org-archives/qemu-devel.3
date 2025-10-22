Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE911CCD1AB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 11:47:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBXJB-000645-3S; Wed, 22 Oct 2025 07:47:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vBXJ9-00063n-L2
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 07:47:11 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vBXJ6-0003OQ-Ue
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 07:47:11 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-782bfd0a977so5002862b3a.3
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 04:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1761133626; x=1761738426; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zFNl5bdI3wCBFYAkTWXOcIHimTRkmbNifGN0z9h66ZY=;
 b=PUJrZyD39fTFM/y72YJPFZjiRkZnmE8HMzTGL8c9YPCwm3y6BAExFEvLRLrMn9TxzB
 nd3XvGpX7kwXlrEljJqqJzdFlFnNWFDeRL2e6ZVUyo9WdfBhjv9W6dbcw0Tf70012lSN
 YgUzYPztsN2TXr1gDt1f9sL6K1F7o1seK+6/2UdZCZdHOhRZ6AY+UwlaJZsaIP9ne0VE
 iw7AymXjPBUqq/vw07IekPibLbDhfJN+COGEYg/kd2oM6YVRJtNEp0vsfhFIr082vY/G
 oKRrIhGz1C5iW0E8fa72uauN/A63lgSGe943L9VrE6ZxFBQAZW5Z5cRjYHIcyFIXNhS3
 MLzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761133626; x=1761738426;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zFNl5bdI3wCBFYAkTWXOcIHimTRkmbNifGN0z9h66ZY=;
 b=pn8VXqHjXWK2OAaPh/8CNw2a8OaW51eOcRnj1BlfoXUKOuiFDSBt3WIDQ8QCbiXXoK
 9SWeDP4lvtrRyknqbHJWVdddea+Zn2p9moCZYoltNMUA8eUzF8sBrKswKmOf8xVAbuow
 0RbSfeZwXH8JcelNGBA6RibAFr7xqPve03seQIeY5dt0Abz2QEpDcpfFisUbaw4SSqlL
 fQb3IT62FmZLK7tGRTrr8vFdhdDvgVmQMza31RXgm0fa6l5WFggCK+6iDz+tZKxGP3TZ
 T2yNIrpjN5lAjVf0jyYk20Ssy/odhs/vGY38TPR25ZdXBfwoeNrFv3a/lgSsMedkmXWZ
 VAdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9/JkIqbG+iNxmdSDoZC0GdtkNNmeKNe5060ZVpBVSxygTUIfBEdHEWPVRmmhglNiSqxmGbWEAYr0x@nongnu.org
X-Gm-Message-State: AOJu0YxhmJFkBXwWsuiN7b0+Fiusl4dKLBNbuCR3WnfuVI87y3e0XnQQ
 H7Qb6u5nzNbUrcsHsfPHppCYrGteSxc4Wu0R5yi8UnzypinequJfxu0X+9lITCHEE0jNoq3v9NC
 K5cj+s+s=
X-Gm-Gg: ASbGncsSJoixxB5odNyDntiBxNVd9HxXWFU0CY6rSqZmpmd1j7O7Qh6+1CXJiI0dbP3
 S3AaH6IZnCuYAzr3bfq9wvWr3b9Dr9jwSKsj/LNyWzvpNGBJTmaQxX0vYLzaJVPnF+xtkKiwmVD
 3IolkfQ6Z7V0KnfW57NKkeo6WXkxJV3a/ByUHSMXUBmGei58gLXnyIRxG6QWszt/3rthlz+ZnCi
 4GpLZd3SpYs03AQy54ZzZv1jyN2V91h5p9UAlx+jeeKR7HIKRa1V2u8RHzgSAw38t6PJVgPLDg1
 Y+C376XxIzaEuo5PgdZ6d3bwXlojLiQov/vca15gYHgf6BoX+vXqJVipn2X+W4JUTjyAWy6XfrI
 n0soEvcuFNdkC8VlFOiyux6qWHhMcRNCF2tN+yg1OukOaOtzlqvn2XA54rBNxQ8CKQH9ktskV0E
 oTAz6h6OmYc1bsCM5jz0zgTf4SLPNO2NIwgotypZBHFz0uPD0UrigOcSyxb8n9IKWB
X-Google-Smtp-Source: AGHT+IFUuRBQl3mzOmZOEfoU/EHxL0JpA33Luyw5hSi/48Xwu4qitDuUnUlx5BG2lqpwRloa6LneoQ==
X-Received: by 2002:a17:902:c942:b0:293:623:3241 with SMTP id
 d9443c01a7336-293062336a1mr24381445ad.58.1761133625723; 
 Wed, 22 Oct 2025 04:47:05 -0700 (PDT)
Received: from ?IPV6:2804:7f0:bcc1:92d3:4170:1cad:ed8e:78ba?
 ([2804:7f0:bcc1:92d3:4170:1cad:ed8e:78ba])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33dfb1db6aasm2554541a91.0.2025.10.22.04.47.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Oct 2025 04:47:04 -0700 (PDT)
Message-ID: <1c891573-794e-4650-9fa5-129824f96497@ventanamicro.com>
Date: Wed, 22 Oct 2025 08:47:00 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 1/2] Set KVM initial privilege mode and mp_state
To: Xie Bo <xb@ultrarisc.com>, qemu-devel@nongnu.org
Cc: ajones@ventanamicro.com, qemu-riscv@nongnu.org, alistair23@gmail.com,
 pbonzini@redhat.com, anup@brainfault.org, alistair.francis@wdc.com,
 rkrcmar@ventanamicro.com, palmer@dabbelt.com, xiamy@ultrarisc.com
References: <20250915070811.3422578-1-xb@ultrarisc.com>
 <20250915070811.3422578-2-xb@ultrarisc.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <20250915070811.3422578-2-xb@ultrarisc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Hi,

On 9/15/25 4:08 AM, Xie Bo wrote:
> For KVM mode, the privilege mode should not include M-mode, and the
> initial value should be set to S-mode. Additionally, a following patch
> adds the implementation of putting the vCPU privilege mode to KVM.
> When the vCPU runs for the first time, QEMU will first put the privilege
> state to KVM. If the initial value is set to M-mode, KVM will encounter
> an error.
> 
> In addition, this patch introduces the 'mp_state' field to RISC-V
> vCPUs, following the convention used by KVM on x86. The 'mp_state'
> reflects the multiprocessor state of a vCPU, and is used to control
> whether the vCPU is runnable by KVM. Randomly select one CPU as the
> boot CPU. Since each CPU executes the riscv_cpu_reset_hold() function
> and CPU0 executes first, only CPU0 randomly selects the boot CPU.
> 
> Signed-off-by: Xie Bo <xb@ultrarisc.com>
> ---
>   target/riscv/cpu.c | 17 ++++++++++++++++-
>   target/riscv/cpu.h |  2 ++
>   2 files changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index d055ddf462..55892a2fc7 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -37,6 +37,7 @@
>   #include "kvm/kvm_riscv.h"
>   #include "tcg/tcg-cpu.h"
>   #include "tcg/tcg.h"
> +#include "hw/boards.h"
>   
>   /* RISC-V CPU definitions */
>   static const char riscv_single_letter_exts[] = "IEMAFDQCBPVH";
> @@ -685,18 +686,32 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
>   #ifndef CONFIG_USER_ONLY
>       uint8_t iprio;
>       int i, irq, rdzero;
> +    static int boot_cpu_index;
>   #endif
>       CPUState *cs = CPU(obj);
>       RISCVCPU *cpu = RISCV_CPU(cs);
>       RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(obj);
>       CPURISCVState *env = &cpu->env;
> +    MachineState *ms = MACHINE(qdev_get_machine());
>   
>       if (mcc->parent_phases.hold) {
>           mcc->parent_phases.hold(obj, type);
>       }
>   #ifndef CONFIG_USER_ONLY
>       env->misa_mxl = mcc->def->misa_mxl_max;
> -    env->priv = PRV_M;
> +    if (kvm_enabled()) {
> +        env->priv = PRV_S;
> +    } else {
> +        env->priv = PRV_M;
> +    }

Sorry for the late v9 review. riscv_cpu_reset_hold() is reserved for TCG initialization
only. All kvm specific initialization is done in kvm_riscv_reset_vcpu(), called in the
end of this function:

     if (kvm_enabled()) {
         kvm_riscv_reset_vcpu(cpu);
     }

Everything that is KVM specific should be put in kvm_riscv_reset_vcpu() and other KVM
related helpers in target/riscv/kvm/kvm-cpu.c.


As for the except above, I just sent a patch that is fixing it inside kvm_riscv_reset_regs_csr():

("[PATCH] target/riscv/kvm: fix env->priv setting in reset_regs_csr()")
https://lore.kernel.org/qemu-riscv/20251022111105.483992-1-dbarboza@ventanamicro.com/


The reason I went ahead with that patch is because it is related to an opened Gitlab
issue (https://gitlab.com/qemu-project/qemu/-/issues/2991) and we already missed the
window for 10.1 to fix it.

In case you send another version of this series you can either drop this particular
change or move it to kvm_riscv_reset_regs_csr(). We'll keep whatever is merged first.


Thanks,

Daniel



> +    if (cs->cpu_index == 0) {
> +        boot_cpu_index = g_random_int_range(0, ms->smp.cpus);
> +    }
> +    if (cs->cpu_index == boot_cpu_index) {
> +        env->mp_state = KVM_MP_STATE_RUNNABLE;
> +    } else {
> +        env->mp_state = KVM_MP_STATE_STOPPED;
> +    }
>       env->mstatus &= ~(MSTATUS_MIE | MSTATUS_MPRV);
>       if (env->misa_mxl > MXL_RV32) {
>           /*
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 738e68fa6e..7ea4859de7 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -269,6 +269,8 @@ struct CPUArchState {
>   #endif
>   
>       target_ulong priv;
> +    /* Current multiprocessor state of this vCPU. */
> +    uint32_t mp_state;
>       /* CSRs for execution environment configuration */
>       uint64_t menvcfg;
>       target_ulong senvcfg;


