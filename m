Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 760C6C87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 21:16:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukURV-0007II-JN; Fri, 08 Aug 2025 17:16:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ukURO-0007HX-Vu
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 17:15:55 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ukURL-0007Wm-4T
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 17:15:54 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3b78310b296so1320429f8f.2
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 14:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754687748; x=1755292548; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cAhfcFpP3ajcsivFU3R5VD1yiuNV3+1WEfXFIMIWtio=;
 b=JPR6B3DLnISs0a8aLF+qrbAm+FrtMi5OotGASEwoEn8B6cciftzJbfYBhReJZ0kzMg
 BgGc4X0cfO07x3xDXhIKlvKMga4sfLPWlMDkG/eQWW8+u296Ql60Kx5k2IdLIGYhh/23
 JkNb6kFQ4aJ8jGeEuF33vMbEAqoFDHPiqr0LxaivnxAjnRIPRNit6ZNzGzk1lRqIGFG2
 5nfPOuK9fFHCsGinXXzItLhOSp60+bT9KuQRTSeHAZIg2tLBBXzM6P4PGcy7drmNk0w3
 i1+Wi18g+rcZO2Ist39wAGXDbozyRs5gUCo0tECMNT/gqHvk4dGGNMsjW5+bmJY86Hr/
 VlKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754687748; x=1755292548;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cAhfcFpP3ajcsivFU3R5VD1yiuNV3+1WEfXFIMIWtio=;
 b=TxjasanlYwCio5nnyvAefzxeARbTjYE8iCHkrtrkCOkI1ONOQA426hAT4aEk6spcyD
 jmU/U0vDmJ89pLZvnkf4WaRzwyo5VpvzyBFTb9a49N7mL+ObzFKFlHXMgxpWmwudzp3+
 Qmt1DjkDkaBvpd3hPOO9LNNUCCKpY+TDv1+agqwd54sLrgXl8jOB0POQ14GjxXmNYHPi
 aI69cP256HUUHTwF9GI9amfV30u+qAAt7guMtIaY8mmFfIZJpJvyD7UEOPxKTyWj/YU3
 Ea7d8ncfjg23d6xAgo4f5c6/x6DtdxF+R4PHbLe1crW1ku4VY8Y3YLZWqZaCiu+2Mwm3
 KooQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUK/h/coY8tV8/qPSYIm2XOT1xmJv3VnrkgnDS/o1cIKY5fzSfpt4u+4ZgkkZoOZceW/k1o+GlKETa3@nongnu.org
X-Gm-Message-State: AOJu0YzL0WkuoOQzCgtjRPJjIka5jUt9OAV78VNJvgp+p5aV8nzYrqof
 skW3UiaNcLnJQNORFDKoxmwj22QO1mQ0Giq16CtGT8DkCnOQTNQeguk0zzuaJHp+ECs=
X-Gm-Gg: ASbGnctha7GabRylHhlp7Op8M48XApyooraW8JMMTvcw/qOB6U/8sLLHovqj985yN1/
 WToS6LdTvCau/UaJPMCzx9f9P/F9bs2v6v+Tym9l+7MB3XX+5OF9n2tsSBlsi1dmQDwA//vB88k
 XsqRMz63AkTi+Utpi7wEFHwJLAx21ZZ+isfpw09Lak/xZAIP93Cf5S8vqHbCW/DTP4SHKUzRUhm
 snLPdiMVbUHqZPjL9vqjc3YKsVGbA1bgwUoyW1Y39okxKV2vvWiRnVuHRgNrs/J6AZhi5+18JjZ
 3KfGX98lxnyjh9wUFEcNsTnofRgs6HDpGKAaE/NWId29Jow6c93ypKznXtul5I0QVOR5QnG4HZG
 y0rKAxFWqHPoFYEqoOaCIBrH9BLc7io41leVvzY4RpxLCFA6DQu47JNHhgGrveqHWtw==
X-Google-Smtp-Source: AGHT+IE6ZswjRdXcLBkWVjoPbqHqu4djhiSX530NSaPOeVnWiBSHxI08AwYvoOZPGHLyD2gvQOekSQ==
X-Received: by 2002:a5d:5f8d:0:b0:3b8:d893:5230 with SMTP id
 ffacd0b85a97d-3b900b510dcmr3861736f8f.47.1754687748074; 
 Fri, 08 Aug 2025 14:15:48 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c47c516sm31791967f8f.62.2025.08.08.14.15.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Aug 2025 14:15:47 -0700 (PDT)
Message-ID: <6a3b97ad-63c4-4b29-98e6-fba98eba33c4@linaro.org>
Date: Fri, 8 Aug 2025 23:15:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] accel/tcg: introduce tcg_kick_vcpu_thread
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: imammedo@redhat.com, richard.henderson@linaro.org, peterx@redhat.com
References: <20250808185905.62776-1-pbonzini@redhat.com>
 <20250808185905.62776-5-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250808185905.62776-5-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

On 8/8/25 20:59, Paolo Bonzini wrote:
> qemu_cpu_kick() does not always have to set cpu->exit_request,
> though it does for now.  Introduce a function tcg_kick_vcpu_thread()
> which can be changed in the future to not set cpu->exit_request,
> and reserve cpu_exit() for when *all accelerators* need to set
> that flag.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   docs/devel/tcg-icount.rst       |  2 +-
>   accel/tcg/tcg-accel-ops-mttcg.h |  3 ---
>   include/exec/cpu-common.h       |  1 +
>   accel/tcg/cpu-exec.c            | 17 ++++++++++++++++-
>   accel/tcg/tcg-accel-ops-mttcg.c |  5 -----
>   accel/tcg/tcg-accel-ops-rr.c    |  2 +-
>   accel/tcg/tcg-accel-ops.c       |  2 +-
>   bsd-user/main.c                 |  2 +-
>   linux-user/main.c               |  2 +-
>   9 files changed, 22 insertions(+), 14 deletions(-)
> 
> diff --git a/docs/devel/tcg-icount.rst b/docs/devel/tcg-icount.rst
> index 7df883446a7..a1dcd79e0fd 100644
> --- a/docs/devel/tcg-icount.rst
> +++ b/docs/devel/tcg-icount.rst
> @@ -37,7 +37,7 @@ translator starts by allocating a budget of instructions to be
>   executed. The budget of instructions is limited by how long it will be
>   until the next timer will expire. We store this budget as part of a
>   vCPU icount_decr field which shared with the machinery for handling
> -cpu_exit(). The whole field is checked at the start of every
> +qemu_cpu_kick(). The whole field is checked at the start of every
>   translated block and will cause a return to the outer loop to deal
>   with whatever caused the exit.
>   
> diff --git a/accel/tcg/tcg-accel-ops-mttcg.h b/accel/tcg/tcg-accel-ops-mttcg.h
> index 8ffa7a9a9fe..5c145cc8595 100644
> --- a/accel/tcg/tcg-accel-ops-mttcg.h
> +++ b/accel/tcg/tcg-accel-ops-mttcg.h
> @@ -10,9 +10,6 @@
>   #ifndef TCG_ACCEL_OPS_MTTCG_H
>   #define TCG_ACCEL_OPS_MTTCG_H
>   
> -/* kick MTTCG vCPU thread */
> -void mttcg_kick_vcpu_thread(CPUState *cpu);
> -
>   /* start an mttcg vCPU thread */
>   void mttcg_start_vcpu_thread(CPUState *cpu);
>   
> diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
> index 9b658a3f48f..e843b09cc99 100644
> --- a/include/exec/cpu-common.h
> +++ b/include/exec/cpu-common.h
> @@ -226,6 +226,7 @@ G_NORETURN void cpu_loop_exit(CPUState *cpu);
>   G_NORETURN void cpu_loop_exit_restore(CPUState *cpu, uintptr_t pc);
>   
>   /* accel/tcg/cpu-exec.c */
> +void tcg_kick_vcpu_thread(CPUState *cpu);

"exec/cpu-common.h" is not the place, maybe "accel/tcg/cpu-ops.h"?

(Nitpicking, for clarity I'd rather a preliminary pach renaming
mttcg_kick_vcpu_thread -> tcg_kick_vcpu_thread and using it
instead of cpu_exit, then this patch only modifying
tcg_kick_vcpu_thread).

>   int cpu_exec(CPUState *cpu);
>   
>   /**
> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> index 4bd9ee01c19..1a973596d87 100644
> --- a/accel/tcg/cpu-exec.c
> +++ b/accel/tcg/cpu-exec.c
> @@ -748,6 +748,20 @@ static inline bool cpu_handle_exception(CPUState *cpu, int *ret)
>       return false;
>   }
>   
> +void tcg_kick_vcpu_thread(CPUState *cpu)
> +{
> +    /*
> +     * Ensure cpu_exec will see the reason why the exit request was set.
> +     * FIXME: this is not always needed.  Other accelerators instead
> +     * read interrupt_request and set exit_request on demand from the
> +     * CPU thread; see kvm_arch_pre_run() for example.
> +     */
> +    qatomic_store_release(&cpu->exit_request, 1);
> +
> +    /* Ensure cpu_exec will see the exit request after TCG has exited.  */
> +    qatomic_store_release(&cpu->neg.icount_decr.u16.high, -1);
> +}
> +
>   static inline bool icount_exit_request(CPUState *cpu)
>   {
>       if (!icount_enabled()) {
> @@ -774,7 +788,8 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
>       /* Clear the interrupt flag now since we're processing
>        * cpu->interrupt_request and cpu->exit_request.
>        * Ensure zeroing happens before reading cpu->exit_request or
> -     * cpu->interrupt_request (see also smp_wmb in cpu_exit())
> +     * cpu->interrupt_request (see also store-release in
> +     * tcg_kick_vcpu_thread())
>        */
>       qatomic_set_mb(&cpu->neg.icount_decr.u16.high, 0);
>   
> diff --git a/accel/tcg/tcg-accel-ops-mttcg.c b/accel/tcg/tcg-accel-ops-mttcg.c
> index 39237421757..5757324a8c2 100644
> --- a/accel/tcg/tcg-accel-ops-mttcg.c
> +++ b/accel/tcg/tcg-accel-ops-mttcg.c
> @@ -123,11 +123,6 @@ static void *mttcg_cpu_thread_fn(void *arg)
>       return NULL;
>   }
>   
> -void mttcg_kick_vcpu_thread(CPUState *cpu)
> -{
> -    cpu_exit(cpu);
> -}
> -
>   void mttcg_start_vcpu_thread(CPUState *cpu)
>   {
>       char thread_name[VCPU_THREAD_NAME_SIZE];
> diff --git a/accel/tcg/tcg-accel-ops-rr.c b/accel/tcg/tcg-accel-ops-rr.c
> index c06f3beef2e..87b49377c78 100644
> --- a/accel/tcg/tcg-accel-ops-rr.c
> +++ b/accel/tcg/tcg-accel-ops-rr.c
> @@ -43,7 +43,7 @@ void rr_kick_vcpu_thread(CPUState *unused)
>       CPUState *cpu;
>   
>       CPU_FOREACH(cpu) {
> -        cpu_exit(cpu);
> +        tcg_kick_vcpu_thread(cpu);
>       };
>   }
>   
> diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
> index 02c7600bb7d..f4d5372866a 100644
> --- a/accel/tcg/tcg-accel-ops.c
> +++ b/accel/tcg/tcg-accel-ops.c
> @@ -207,7 +207,7 @@ static void tcg_accel_ops_init(AccelClass *ac)
>   
>       if (qemu_tcg_mttcg_enabled()) {
>           ops->create_vcpu_thread = mttcg_start_vcpu_thread;
> -        ops->kick_vcpu_thread = mttcg_kick_vcpu_thread;
> +        ops->kick_vcpu_thread = tcg_kick_vcpu_thread;
>           ops->handle_interrupt = tcg_handle_interrupt;
>       } else {
>           ops->create_vcpu_thread = rr_start_vcpu_thread;
> diff --git a/bsd-user/main.c b/bsd-user/main.c
> index 7e5d4bbce09..20159207040 100644
> --- a/bsd-user/main.c
> +++ b/bsd-user/main.c
> @@ -216,7 +216,7 @@ bool qemu_cpu_is_self(CPUState *cpu)
>   
>   void qemu_cpu_kick(CPUState *cpu)
>   {
> -    cpu_exit(cpu);
> +    tcg_kick_vcpu_thread(cpu);
>   }
>   
>   /* Assumes contents are already zeroed.  */
> diff --git a/linux-user/main.c b/linux-user/main.c
> index 68972f00a15..dc68fd448b7 100644
> --- a/linux-user/main.c
> +++ b/linux-user/main.c
> @@ -192,7 +192,7 @@ bool qemu_cpu_is_self(CPUState *cpu)
>   
>   void qemu_cpu_kick(CPUState *cpu)
>   {
> -    cpu_exit(cpu);
> +    tcg_kick_vcpu_thread(cpu);
>   }
>   
>   void task_settid(TaskState *ts)


