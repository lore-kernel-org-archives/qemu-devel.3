Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3418C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 15:35:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCLK4-0000c0-Nz; Wed, 29 May 2024 11:34:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCLK2-0000b9-8n
 for qemu-devel@nongnu.org; Wed, 29 May 2024 11:34:38 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCLK0-0005oj-9p
 for qemu-devel@nongnu.org; Wed, 29 May 2024 11:34:38 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2e95a7545bdso24315951fa.2
 for <qemu-devel@nongnu.org>; Wed, 29 May 2024 08:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716996874; x=1717601674; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5OcVCa51iUK/qcfAIdbmVeHiVzVTtE47QaRCEnOel/U=;
 b=Y2m47dOeh0F5wjZWmbeybUvW7y2R/kkyeFG2meLRhGvcrdkmvHXZ1MwjQZUo4zk93v
 xaIMCW/fK7dZa63WkBGeDAzv5b+rK+MTxKxkIs5RkWb9bokHPeng16nDObxi9Kitqe2Z
 aZQdILPCn7hc6k5Ri1/AUxPG3tDQP+adQKMVsZ7phC+lZsSEwn1KPgBJKAixrXxO5AmR
 HJnSYs9bT3w/8HEMpBa0T8Bbdf6P1/WkNg7Kamu6f6gpOOmUVIaA87OIKV7l3k+BmmKV
 sQQbRus0WDhwoUemPy4ghT77vI1jfuCFrgTMReRh0IKnaynusMlJHEXfH8fbqkrAdgAr
 q6sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716996874; x=1717601674;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5OcVCa51iUK/qcfAIdbmVeHiVzVTtE47QaRCEnOel/U=;
 b=gqseDCs1B1i2MD8hLqd/xtUig/xjFPX6qJbOHJ2qtvsztrt3xXfdRH+6trjqIDDK+8
 0fdI/xyrLJxzqnXoDdV6qIM94n/Rx27D4aQ1AAn1h9GDpqEKw8GSb+lzPGeYkdoBO5kG
 p7jHUaPSJiucfHRO4nnsG0+W4HnijA/sB+7eeBU8kHhoJx2Dj1cjynko2S1YkJ//EI5K
 8Cbu+wQYdJXNfZZ3svG4T1wyFmfWqLYNxhgUUr9pINLigJs710557FOuEzVjiy6LpVYF
 DQcaxcIdRPB1CLF179FfSzoTg7FRPf4v1eZMW+/e1rPzZsx7YDf/27MxpsjGDoiaMsOU
 zRzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyphj1Jxni6+SI1+fxM150drgKBZazZ2A31TGx3iHttdTIaRZw8tpcU0a8/qv7nPJNhFGwUKEXxolhXqzrJLtKQccSftQ=
X-Gm-Message-State: AOJu0YxBLl9N80HwuN/QJuIfpYiN7VX5BXoNSu4lKP36Sw8NZzyjwp9R
 TcPTO6zhI1QIKtjxe9yd9Qcma04Re6Srr7DzdxEgPqasUoarAJJ3WPmJL6irItc=
X-Google-Smtp-Source: AGHT+IF7nytmZHyG376PQnSq14DG/z7VsCn5nvmwa37uuIWklGGzxvDfqCN6A34dxQn55bGQO/aGMg==
X-Received: by 2002:a2e:97c3:0:b0:2d9:f00c:d2d5 with SMTP id
 38308e7fff4ca-2e95b27b08amr87541401fa.46.1716996874269; 
 Wed, 29 May 2024 08:34:34 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.204.141])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42108966642sm183325785e9.7.2024.05.29.08.34.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 May 2024 08:34:33 -0700 (PDT)
Message-ID: <c98aeb97-e229-4b97-874c-5cc2deceeaf9@linaro.org>
Date: Wed, 29 May 2024 17:34:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] cpus: split qemu_init_vcpu and delay vCPU thread
 creation
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
References: <20240529152219.825680-1-alex.bennee@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240529152219.825680-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x234.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi Alex,

On 29/5/24 17:22, Alex Bennée wrote:
> This ensures we don't start the thread until cpu_common_realizefn has
> finished. This ensures that plugins will always run
> qemu_plugin_vcpu_init__async first before any other states. It doesn't
> totally eliminate the race that plugin_cpu_update__locked has to work
> around though. I found this while reviewing the ips plugin which makes
> heavy use of the vcpu phase callbacks.
> 
> An alternative might be to move the explicit creation of vCPU threads
> to qdev_machine_creation_done()? It doesn't affect user-mode which
> already has a thread to execute in and ensures the QOM object has
> completed creation in cpu_create() before continuing.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/core/cpu.h      |  8 ++++++++
>   accel/tcg/user-exec-stub.c |  5 +++++
>   hw/core/cpu-common.c       |  7 ++++++-
>   plugins/core.c             |  5 +++++
>   system/cpus.c              | 15 ++++++++++-----
>   5 files changed, 34 insertions(+), 6 deletions(-)
> 
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index bb398e8237..6920699585 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -1041,6 +1041,14 @@ void end_exclusive(void);
>    */
>   void qemu_init_vcpu(CPUState *cpu);
>   
> +/**
> + * qemu_start_vcpu:
> + * @cpu: The vCPU to start.
> + *
> + * Create the vCPU thread and start it running.
> + */
> +void qemu_start_vcpu(CPUState *cpu);
> +
>   #define SSTEP_ENABLE  0x1  /* Enable simulated HW single stepping */
>   #define SSTEP_NOIRQ   0x2  /* Do not use IRQ while single stepping */
>   #define SSTEP_NOTIMER 0x4  /* Do not Timers while single stepping */
> diff --git a/accel/tcg/user-exec-stub.c b/accel/tcg/user-exec-stub.c
> index 4fbe2dbdc8..162bb72bbe 100644
> --- a/accel/tcg/user-exec-stub.c
> +++ b/accel/tcg/user-exec-stub.c
> @@ -18,6 +18,11 @@ void cpu_exec_reset_hold(CPUState *cpu)
>   {
>   }
>   
> +void qemu_start_vcpu(CPUState *cpu)
> +{
> +    /* NOP for user-mode, we already have a thread */
> +}
> +
>   /* User mode emulation does not support record/replay yet.  */
>   
>   bool replay_exception(void)
> diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
> index 0f0a247f56..68895ddd59 100644
> --- a/hw/core/cpu-common.c
> +++ b/hw/core/cpu-common.c
> @@ -230,7 +230,12 @@ static void cpu_common_realizefn(DeviceState *dev, Error **errp)
>       }
>   #endif
>   
> -    /* NOTE: latest generic point where the cpu is fully realized */
> +    /*
> +     * With everything set up we can finally start the vCPU thread.
> +     * This is a NOP for linux-user.
> +     * NOTE: latest generic point where the cpu is fully realized
> +     */
> +    qemu_start_vcpu(cpu);
>   }
>   
>   static void cpu_common_unrealizefn(DeviceState *dev)
> diff --git a/plugins/core.c b/plugins/core.c
> index 0726bc7f25..1e5da7853b 100644
> --- a/plugins/core.c
> +++ b/plugins/core.c
> @@ -65,6 +65,11 @@ static void plugin_cpu_update__locked(gpointer k, gpointer v, gpointer udata)
>       CPUState *cpu = container_of(k, CPUState, cpu_index);
>       run_on_cpu_data mask = RUN_ON_CPU_HOST_ULONG(*plugin.mask);
>   
> +    /*
> +     * There is a race condition between the starting of the vCPU
> +     * thread at the end of cpu_common_realizefn and when realized is
> +     * finally set.
> +     */

I'd like we simply assert(DEVICE(cpu)->realized) here;
I still don't understand when this can be called while
the vcpu isn't yet realized.

>       if (DEVICE(cpu)->realized) {
>           async_run_on_cpu(cpu, plugin_cpu_update__async, mask);
>       } else {
> diff --git a/system/cpus.c b/system/cpus.c
> index d3640c9503..7dd8464c5e 100644
> --- a/system/cpus.c
> +++ b/system/cpus.c
> @@ -488,11 +488,13 @@ void cpus_kick_thread(CPUState *cpu)
>   
>   void qemu_cpu_kick(CPUState *cpu)
>   {
> -    qemu_cond_broadcast(cpu->halt_cond);
> -    if (cpus_accel->kick_vcpu_thread) {
> -        cpus_accel->kick_vcpu_thread(cpu);
> -    } else { /* default */
> -        cpus_kick_thread(cpu);
> +    if (cpu->halt_cond) {

cpu->halt_cond = NULL is a bug, why kicking a vcpu not
yet fully created?

> +        qemu_cond_broadcast(cpu->halt_cond);
> +        if (cpus_accel->kick_vcpu_thread) {
> +            cpus_accel->kick_vcpu_thread(cpu);
> +        } else { /* default */
> +            cpus_kick_thread(cpu);
> +        }
>       }
>   }
>   
> @@ -674,7 +676,10 @@ void qemu_init_vcpu(CPUState *cpu)
>           cpu->num_ases = 1;
>           cpu_address_space_init(cpu, 0, "cpu-memory", cpu->memory);
>       }
> +}
>   
> +void qemu_start_vcpu(CPUState *cpu)
> +{
>       /* accelerators all implement the AccelOpsClass */
>       g_assert(cpus_accel != NULL && cpus_accel->create_vcpu_thread != NULL);
>       cpus_accel->create_vcpu_thread(cpu);


