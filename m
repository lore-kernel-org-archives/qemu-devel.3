Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BA1FC02183
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 05:18:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXvnc-00060W-Q1; Wed, 15 Jan 2025 00:18:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tXvna-000605-PR
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 00:18:38 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tXvnZ-0006sQ-2N
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 00:18:38 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-21634338cfdso106601415ad.2
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 21:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736918315; x=1737523115; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WyvlXlWH5Q+Q/3sMmRHCC3sw7n8CXw94MRVBYnAYwjg=;
 b=vAo64mvY828fkYD2JFRQLz8w7Jzkfq5O5ZIev3QXiwc1SzPboYYCmK9wvvSVVB/MQb
 hwsyiM0GwDz9O8lHTsLxBJmX7tqffMDLFOPn+pJQu/+w33ngtrHewziXeTzX0bPbu9W1
 T652Maa8tq8iHiM1J2ITcMW5y4TX1fSKn5gVklBA9pI2FFcWOKZfOpohJKsNiuJzs8kV
 CsjiDZF/3Ws5HtZpW0b6Rmp0SWIgQ8XIK45Y/tEkXRRZYhWTYCnjNcTu7vzurPQHPW0E
 pO4GZz5uvhDFwW1zGIqAMYezjmNSklwKphNWScuk4pKaQm+fuZPbuW0hom3zRHzX8paq
 DcsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736918315; x=1737523115;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WyvlXlWH5Q+Q/3sMmRHCC3sw7n8CXw94MRVBYnAYwjg=;
 b=WbEBSrevi+Lb1lypRddCbWFwarvVSy6Xjy3dZBnS9b78140rEPAWNnA9pgK9WjV8aK
 AF5us4eS28Mhcr2taZGdTQ4FdhtfURVtwy3Ut23tLe0GSeDfJCf1jAqNqIsT4x5SMaf+
 OkV44ayaG8UVeRd1B0DInRpm9JemfJ+QeVFdMxs5Zv4q6xbx9AdWD2JBSFrkSFq7PUc4
 JlPQQ7vWLgsQ4tXUlgY/E9mvF208F0aGQqGtk9NzjBX97CN6d4U5QcmRquYZaAi2NWqd
 cJL2jW0XYReZQIsNYHji+uPY+wBLqvWkepV5E2EoUAcr8lGQ5fk0hbNfI++86+8O4n9N
 joHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJmBtXvKGyRv4rysEeNfoiRCTzu8wsMV7auPabwGSHbWt/O70oKvyXl0dq3bp/MNRmr7L2KEEH2C68@nongnu.org
X-Gm-Message-State: AOJu0YzQDpM0732ZAKjv2+P1YvG+qc2eo9KkiUUQU1jVW9yF0LVPjIJ0
 l3LfcQ90ZW0DzH27L0Chu/+1cSqktzdiFQkXzNsJutTV2TYyNHYD5eIhft58iSw=
X-Gm-Gg: ASbGncvbggVCbM48zlLJYsXb4LUesczhf+Cy6fZc9BRnbIz/Cf4aZQUGPVEen8Yqcg+
 JGBvhIUllizQ3WqwP7mJfXoUUjOSuJdAIv/r1ejCU6i2oc5VPiz/t9mOJj4ySQuq2oNa4Oestk0
 dkh32DQ7G1d3cuit53y5I3N6/nT/d2Zon81hUO8aaE6JFcfbM5Rw6c2YLsUGIwGL3O2GgUUP7vk
 QKPqQ39LayiGA98snZ1eCRWLgZzHX5XbCISqI66fwnh42mXSKZ6NEiPo8UsxFLL+iXVnta/m1WM
 w/aLs2N38oMLXd8kXcdHGEg=
X-Google-Smtp-Source: AGHT+IFno5dDhwmyT5CBBos5bgiPIqMeMtopJk9tUCArjhqyyOAoTygOGerkx6pvRJegRx+X9YS4Bw==
X-Received: by 2002:a05:6a00:3912:b0:72a:8cc8:34aa with SMTP id
 d2e1a72fcca58-72d21df2fb5mr44156349b3a.0.1736918315232; 
 Tue, 14 Jan 2025 21:18:35 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72d40549422sm8564461b3a.10.2025.01.14.21.18.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jan 2025 21:18:34 -0800 (PST)
Message-ID: <6c194ca4-6d37-416b-8ebe-b4789eee0de5@linaro.org>
Date: Tue, 14 Jan 2025 21:18:33 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/11] hw/mips/loongson3_virt: Keep reference of vCPUs in
 machine_init()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20250112215835.29320-1-philmd@linaro.org>
 <20250112215835.29320-3-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250112215835.29320-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

On 1/12/25 13:58, Philippe Mathieu-Daudé wrote:
> Keep references of all vCPUs created. That allows
> to directly access the first vCPU without using the
> &first_cpu global.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/mips/loongson3_virt.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
> index 47d112981a2..4b19941c1dc 100644
> --- a/hw/mips/loongson3_virt.c
> +++ b/hw/mips/loongson3_virt.c
> @@ -492,9 +492,8 @@ static void mips_loongson3_virt_init(MachineState *machine)
>   {
>       int i;
>       long bios_size;
> -    MIPSCPU *cpu;
> +    g_autofree MIPSCPU **cpus = NULL;
>       Clock *cpuclk;
> -    CPUMIPSState *env;
>       DeviceState *liointc;
>       DeviceState *ipi = NULL;
>       char *filename;
> @@ -569,13 +568,16 @@ static void mips_loongson3_virt_init(MachineState *machine)
>       cpuclk = clock_new(OBJECT(machine), "cpu-refclk");
>       clock_set_hz(cpuclk, DEF_LOONGSON3_FREQ);
>   
> +    cpus = g_new(MIPSCPU *, machine->smp.cpus);
>       for (i = 0; i < machine->smp.cpus; i++) {
> +        MIPSCPU *cpu;
>           int node = i / LOONGSON3_CORE_PER_NODE;
>           int core = i % LOONGSON3_CORE_PER_NODE;
>           int ip;
>   
>           /* init CPUs */
>           cpu = mips_cpu_create_with_clock(machine->cpu_type, cpuclk, false);
> +        cpus[i] = cpu;
>   
>           /* Init internal devices */
>           cpu_mips_irq_init_cpu(cpu);
> @@ -609,7 +611,6 @@ static void mips_loongson3_virt_init(MachineState *machine)
>                                  pin, cpu->env.irq[ip + 2]);
>           }
>       }
> -    env = &MIPS_CPU(first_cpu)->env;
>   
>       /* Allocate RAM/BIOS, 0x00000000~0x10000000 is alias of 0x80000000~0x90000000 */
>       memory_region_init_rom(bios, NULL, "loongson3.bios",
> @@ -640,7 +641,7 @@ static void mips_loongson3_virt_init(MachineState *machine)
>           loaderparams.kernel_filename = kernel_filename;
>           loaderparams.kernel_cmdline = kernel_cmdline;
>           loaderparams.initrd_filename = initrd_filename;
> -        loaderparams.kernel_entry = load_kernel(env);
> +        loaderparams.kernel_entry = load_kernel(&cpus[0]->env);
We only ever use cpu[0].  We don't really need the whole array.


r~

