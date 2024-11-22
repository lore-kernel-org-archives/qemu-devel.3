Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB1B5E69183
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2024 17:27:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEXR3-0008OS-2O; Fri, 22 Nov 2024 12:27:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tEXQs-0008NX-AC
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 12:27:04 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tEXQp-0001Dm-RW
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 12:27:01 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4315e62afe0so21760725e9.1
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2024 09:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732296418; x=1732901218; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9zJLTUOHy8eB9gweQwwCyTwnOEqP405oQC7LUekK7Iw=;
 b=rIYMS3reAODXSCsidfOccOipzhnOQZp6DN+e7mhUG+uhM7p4l4HkBy7qumo/vVVEUo
 qGb8nsOhc+rcRyObcqSwXfZpR825PQqPYPjcg3oTBjLTpBjKMx1a09o3B930NFk0cuvh
 htljwJTtr/gpaJNm0sXNsJFUEk0AHJqhEn7je79M6BW4FY2BEAmPpsstdEggjtl/Xy6R
 PG5IDTgi3c76fPqN2l5LYHGCUtpftemGEo+FuwDdvc8zBSPAzJfpUOJsswofjCmLR+1X
 tNJOLXM6xAoT7hjme59A8Imf+3FyRxKEUlhUqR/Q7pfU8QTn2TOzGsZW/nEXSO6krCjj
 T4AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732296418; x=1732901218;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9zJLTUOHy8eB9gweQwwCyTwnOEqP405oQC7LUekK7Iw=;
 b=J56UgahC81imKUopZjmRqAid9oJpxb+RrganRohauMLyIdgc9wVlhJ2D7k1BCrcIBU
 lnZsugvawbqZN88M3/fDTPh0n30Z+SSB+9lQfV55kZ+S7K1xe0ZuscydM6b6WDKbZbvU
 m+q0aqApkIri2xvE4yz4sRVIa+2wr3AoYed44mJESBfUZOM2Sh61tkd+MLKYWMhOhP5H
 4exDkyQ7ULEEz1qK+UoXDtm7LR2Slz3yB8pkV+oX1NoXLsD++Ptf1rVJKAbXA9ivtVLt
 5dqnJVKALK7e1yxJ4Ln2vhk9bJE1aTqShDDV8/yYBgj3Z79nogKHlsb6qNHzRldo7VkE
 aw6w==
X-Gm-Message-State: AOJu0YyDoa8Cy/ZE3ZAzmf1WFcXUuTCgpVQ1iu5Ul7jj2SU0JLRIBQGG
 m3awmcSFWo3O7gfFE1gOm5o3uo3XNY+vpx9kpW00AF1BHqn/perzmlEueBY5EAg=
X-Gm-Gg: ASbGnctJQEGPyWG0cQBRaoVomRQWgM/6ErHKN5mTfFetdWbNMSOOmDJMR3ihFGEf8FE
 k4ufql1guhU0OSQY4BIFVzsRRRJ5rVenMczJp1KpN3PFqqvTp2a1eb84dUfl+kl1z6qY7qGhCzs
 NAIw94Ar1k/5NOKioTvAmaHV199Kah6bG9K031AyqPGpIQi7t3Xqb1P0CkVv+BX1r+JRgCJUgJe
 v48js4kiYxWPHcPhrDZFNAfBxFv6Bwhfx2g0+W/orWvAyDLOfuz42M0JgZHt4k=
X-Google-Smtp-Source: AGHT+IHCAcaaPWgZeFB/QZFIh69Pn4JBoDIO0aHVJ9Htwbcif2DNNwlrONnlIqDz69L9vO3GLSrwsA==
X-Received: by 2002:a05:600c:310b:b0:42e:93af:61c5 with SMTP id
 5b1f17b1804b1-433ce41e542mr33457235e9.14.1732296417639; 
 Fri, 22 Nov 2024 09:26:57 -0800 (PST)
Received: from [192.168.1.121] ([176.187.211.33])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-433b45d40basm101966015e9.21.2024.11.22.09.26.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Nov 2024 09:26:56 -0800 (PST)
Message-ID: <dc286a4a-1885-4457-a248-846c16d847fa@linaro.org>
Date: Fri, 22 Nov 2024 18:26:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpu: Initialize nr_cores and nr_threads in
 cpu_common_initfn()
To: Xiaoyao Li <xiaoyao.li@intel.com>, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>
References: <20241108070609.3653085-2-xiaoyao.li@intel.com>
 <20241122160317.4070177-1-xiaoyao.li@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241122160317.4070177-1-xiaoyao.li@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 22/11/24 17:03, Xiaoyao Li wrote:
> Currently cpu->nr_cores and cpu->nr_threads are initialized in
> qemu_init_vcpu(), which is called a bit late in *cpu_realizefn() for
> each ARCHes.
> 
> x86 arch would like to use nr_cores and nr_threads earlier in its
> realizefn(). To serve this purpose, initialize nr_cores and nr_threads
> in cpu_common_initfn(), which is earlier than *cpu_realizefn().
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
>   hw/core/cpu-common.c | 10 +++++++++-
>   system/cpus.c        |  4 ----
>   2 files changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
> index 09c79035949b..6de92ed854bc 100644
> --- a/hw/core/cpu-common.c
> +++ b/hw/core/cpu-common.c
> @@ -237,14 +237,22 @@ static void cpu_common_unrealizefn(DeviceState *dev)
>   static void cpu_common_initfn(Object *obj)
>   {
>       CPUState *cpu = CPU(obj);
> +    Object *machine = qdev_get_machine();
> +    MachineState *ms;
>   
>       gdb_init_cpu(cpu);
>       cpu->cpu_index = UNASSIGNED_CPU_INDEX;
>       cpu->cluster_index = UNASSIGNED_CLUSTER_INDEX;
>       /* user-mode doesn't have configurable SMP topology */
> -    /* the default value is changed by qemu_init_vcpu() for system-mode */
>       cpu->nr_cores = 1;
>       cpu->nr_threads = 1;
> +#ifndef CONFIG_USER_ONLY

Is CONFIG_USER_ONLY available in an common_ss[] object? I don't recall.

Anyway, can we not use CONFIG_USER_ONLY in cpu-common.c?

> +    if (object_dynamic_cast(machine, TYPE_MACHINE)) {
> +        ms = MACHINE(machine);
> +        cpu->nr_cores = machine_topo_get_cores_per_socket(ms);
> +        cpu->nr_threads = ms->smp.threads;
> +    }
> +#endif
>       cpu->cflags_next_tb = -1;
>   
>       /* allocate storage for thread info, initialise condition variables */
> diff --git a/system/cpus.c b/system/cpus.c
> index 1c818ff6828c..c1547fbfd39b 100644
> --- a/system/cpus.c
> +++ b/system/cpus.c
> @@ -664,10 +664,6 @@ const AccelOpsClass *cpus_get_accel(void)
>   
>   void qemu_init_vcpu(CPUState *cpu)
>   {
> -    MachineState *ms = MACHINE(qdev_get_machine());
> -
> -    cpu->nr_cores = machine_topo_get_cores_per_socket(ms);
> -    cpu->nr_threads =  ms->smp.threads;
>       cpu->stopped = true;
>       cpu->random_seed = qemu_guest_random_seed_thread_part1();
>   


