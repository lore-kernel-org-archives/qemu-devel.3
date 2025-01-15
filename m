Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E88AC02183
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 23:03:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYCPl-0003WD-Fg; Wed, 15 Jan 2025 18:03:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYCPg-0003VO-Te
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 18:03:05 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYCPf-0000s5-7M
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 18:03:04 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2162c0f6a39so28447535ad.0
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 15:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736982180; x=1737586980; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=b2oA85agaZ+Jx63KWWGQgc3a7oBCD6e89wvn8M4lAG4=;
 b=jwP+dn2ytIo76Mqj/FQ1vjv0CzKHS39jEzentMu9MPRbfWBdGoXpfa8B2iXSt6z5Kx
 xf1GhDwq9yZqSqUOsOUG7XcjsUI+hHu9KnsJVYvF3IW4HY9tPWLVeA9EzBaF7iodUrcq
 1Ub1sidmrFObUyc8ocOa/BArHfJqhIlup7K9lXfog0EFjgfrTF2PU6LevYls+Lf2oGlc
 AXl5Y7RD8vORX4LE2dQHssHpTcbtII05B3LSwHp97G/5uAoFW9y/Fyse6m7dHmCGfZok
 NMnG8HjH1aszj4II2AA5ygX/EhpDrh8UiC0en1AYurXrKUro/UVTpTUCjTE33v1X/g+w
 Ovuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736982180; x=1737586980;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=b2oA85agaZ+Jx63KWWGQgc3a7oBCD6e89wvn8M4lAG4=;
 b=BjL6Sx4X1p0QcuV/dDIZ2xmB1vkWYaIO0RUPsE7YEdn+ewszVAQAGcEe3dYlKT/B9I
 6VvkjbTrmHewldW8iKUsA89P2hIsl3AIDun0QBejMSIh0SP2Sb20K5glNHRuqBfZRi3W
 RLfAzQWsol5iA2zVGK9GsO3kzgGmGS7fU1fNDN5dldcrjBEW5rob9lld26FPkSpVxQ6V
 idndAfwLmWUHxn4lfz7kMCpUpnPRJL7wm/aDvw0NpomIPiv/KlQMSx4clQ7PwF9fJFlo
 qs8fTP0liqZyZJOnWKN6LbuO13DLdqk/Ofbsy1wwnex2FT3MziRH/hjZo1L5v0l4CZyj
 hcxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnnhFhJ9Pmj1wiMnQfNMTk6IbnEf5kS77F/jKXGCEm1lvQLyBclHlMs1CzybZEdSFbgHBbEnCTq6X6@nongnu.org
X-Gm-Message-State: AOJu0YyJ38vfS+fNQuGDSWm4HjsHVd8ourzqRQmkg31/oqXAAYJ+wNdD
 FU392l1p2O2dr0SQVU/dfmWBp86+VhxoVuqdBhjR7VbL0UUpG1TTPatsrQjRPao=
X-Gm-Gg: ASbGncv9Aikh6hx47oEEggdtewgtZVRvD90ZL9DPOYcibje7FOZRAQlG8udMzAQsbKi
 BZGesT+ZOshM1iVniDCRRJAxUFwJcMEiVQ8JBYNZMe1augvd8QOcOhiyZs/UZJf2mUWX5t90you
 4oGkyvQHxOVhPn1bMmb7S8Q94VvAFmMD543Von6pKyBiQ5df8SFAJar/f1pII180RG4mFrtUFKG
 w6A1rEfNV7tMBgPwf2X1iFgSYoZGoD+Ey2G6FEgu/VldGgffuUQEYcbFDGeQHyDDD0ASRhOmNfe
 O75dvE+9GUI+8RdNU0a/oOQ=
X-Google-Smtp-Source: AGHT+IEKXKWF7moe2N6yMXnJ3RV1f5RLd8bYmQwmxoKPLYu08DKxgXhYZGfOW72Ylz7qASSoCWoV7g==
X-Received: by 2002:a05:6a20:734c:b0:1e1:adcd:eadb with SMTP id
 adf61e73a8af0-1eb025257f0mr6958548637.11.1736982180054; 
 Wed, 15 Jan 2025 15:03:00 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-a862a22fee0sm3056835a12.13.2025.01.15.15.02.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jan 2025 15:02:59 -0800 (PST)
Message-ID: <9946d536-cdf6-40cc-bdfd-8adcefd81684@linaro.org>
Date: Wed, 15 Jan 2025 15:02:57 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/11] hw/mips/loongson3_virt: Keep reference of vCPUs in
 machine_init()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20250112215835.29320-1-philmd@linaro.org>
 <20250112215835.29320-3-philmd@linaro.org>
 <6c194ca4-6d37-416b-8ebe-b4789eee0de5@linaro.org>
 <63214572-5012-42ea-9872-6d5e2bb39823@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <63214572-5012-42ea-9872-6d5e2bb39823@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

On 1/15/25 12:32, Philippe Mathieu-Daudé wrote:
> On 15/1/25 06:18, Richard Henderson wrote:
>> On 1/12/25 13:58, Philippe Mathieu-Daudé wrote:
>>> Keep references of all vCPUs created. That allows
>>> to directly access the first vCPU without using the
>>> &first_cpu global.
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>>   hw/mips/loongson3_virt.c | 9 +++++----
>>>   1 file changed, 5 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
>>> index 47d112981a2..4b19941c1dc 100644
>>> --- a/hw/mips/loongson3_virt.c
>>> +++ b/hw/mips/loongson3_virt.c
>>> @@ -492,9 +492,8 @@ static void mips_loongson3_virt_init(MachineState *machine)
>>>   {
>>>       int i;
>>>       long bios_size;
>>> -    MIPSCPU *cpu;
>>> +    g_autofree MIPSCPU **cpus = NULL;
>>>       Clock *cpuclk;
>>> -    CPUMIPSState *env;
>>>       DeviceState *liointc;
>>>       DeviceState *ipi = NULL;
>>>       char *filename;
>>> @@ -569,13 +568,16 @@ static void mips_loongson3_virt_init(MachineState *machine)
>>>       cpuclk = clock_new(OBJECT(machine), "cpu-refclk");
>>>       clock_set_hz(cpuclk, DEF_LOONGSON3_FREQ);
>>> +    cpus = g_new(MIPSCPU *, machine->smp.cpus);
>>>       for (i = 0; i < machine->smp.cpus; i++) {
>>> +        MIPSCPU *cpu;
>>>           int node = i / LOONGSON3_CORE_PER_NODE;
>>>           int core = i % LOONGSON3_CORE_PER_NODE;
>>>           int ip;
>>>           /* init CPUs */
>>>           cpu = mips_cpu_create_with_clock(machine->cpu_type, cpuclk, false);
>>> +        cpus[i] = cpu;
>>>           /* Init internal devices */
>>>           cpu_mips_irq_init_cpu(cpu);
>>> @@ -609,7 +611,6 @@ static void mips_loongson3_virt_init(MachineState *machine)
>>>                                  pin, cpu->env.irq[ip + 2]);
>>>           }
>>>       }
>>> -    env = &MIPS_CPU(first_cpu)->env;
>>>       /* Allocate RAM/BIOS, 0x00000000~0x10000000 is alias of 0x80000000~0x90000000 */
>>>       memory_region_init_rom(bios, NULL, "loongson3.bios",
>>> @@ -640,7 +641,7 @@ static void mips_loongson3_virt_init(MachineState *machine)
>>>           loaderparams.kernel_filename = kernel_filename;
>>>           loaderparams.kernel_cmdline = kernel_cmdline;
>>>           loaderparams.initrd_filename = initrd_filename;
>>> -        loaderparams.kernel_entry = load_kernel(env);
>>> +        loaderparams.kernel_entry = load_kernel(&cpus[0]->env);
> 
>> We only ever use cpu[0].  We don't really need the whole array.
> 
> Yes. What about:
> 
> -- >8 --
> commit ffc8c8873c0c102457f0e660437874555b022cc2
> Author: Philippe Mathieu-Daudé <philmd@linaro.org>
> Date:   Sun Jan 12 21:01:24 2025 +0100
> 
>      hw/mips/loongson3_virt: Invert vCPU creation order to remove &first_cpu
> 
>      Create vCPUs from the last one to the first one.
>      No need to use the &first_cpu global since we already
>      have it referenced.
> 
>      Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
> index 47d112981a2..488eba495cd 100644
> --- a/hw/mips/loongson3_virt.c
> +++ b/hw/mips/loongson3_virt.c
> @@ -496,3 +496,2 @@ static void mips_loongson3_virt_init(MachineState *machine)
>       Clock *cpuclk;
> -    CPUMIPSState *env;
>       DeviceState *liointc;
> @@ -571,3 +570,3 @@ static void mips_loongson3_virt_init(MachineState *machine)
> 
> -    for (i = 0; i < machine->smp.cpus; i++) {
> +    for (i = machine->smp.cpus - 1; i >= 0; --i) {
>           int node = i / LOONGSON3_CORE_PER_NODE;
> @@ -611,3 +610,2 @@ static void mips_loongson3_virt_init(MachineState *machine)
>       }
> -    env = &MIPS_CPU(first_cpu)->env;
> 
> @@ -642,3 +640,3 @@ static void mips_loongson3_virt_init(MachineState *machine)
>           loaderparams.initrd_filename = initrd_filename;
> -        loaderparams.kernel_entry = load_kernel(env);
> +        loaderparams.kernel_entry = load_kernel(&cpu->env);
> 
> ---

Looks good, thanks.


r~

