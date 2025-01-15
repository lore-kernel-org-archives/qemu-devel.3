Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98BF4C02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 20:33:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYA3v-0003Vx-Lc; Wed, 15 Jan 2025 15:32:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYA3u-0003Vp-Tk
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 15:32:26 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYA3t-0000xX-3b
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 15:32:26 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4361f796586so1044975e9.3
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 12:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736973143; x=1737577943; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wCIIgIMGJ8aAeQLt4psSpE+bBi3Y6NNWp8GaPwHwF+0=;
 b=ar8CscoJv0S04dVldVWLaBAMd7z0kBtSreGD95Yo5L+KUyoWuoIj7XxKKV+0s7cTvL
 pHwOt87zvOU3vTWgLql7nK0ka5Bf//ozitCRJ6u1f1fgGQSL0Xen4kCricKnXwrPbMsT
 6nhRNaETglbnDa9fJ2OPxFi0QPJJI/vLL2ZOGYkTBhWzqAEEpPdhiiZFHYD/5qTVZbf+
 zVby5y9LJ9v3I+O9TOpVYyjgVuA/2QFNCjyh4ZYOi0hQ/SD19XMDh4Jm4XqUq2paGvwd
 JONsdSA140Rp1ntJWAOf4Vi8FkmV5uwnusw86nAJO4l5NXtb0qaay443KJ+ktB9yTgLY
 frcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736973143; x=1737577943;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wCIIgIMGJ8aAeQLt4psSpE+bBi3Y6NNWp8GaPwHwF+0=;
 b=eGPjYDiYrHvDM7VAUwUn4QyNV0crNyJD08d3p8oa4xYC686+G5qYZ7/irv1T39fRAA
 gDueR9rmC+eSm7A45y2UIwRBotZaFY9AKlAR6LntN2JyCxbNNwfvOHV6a0gP53fdapzp
 AtwKcI7saQ2HOu4oyB0nNSpug0faPaTs4oRPQ7eLhsCWReevmgacwZwRsfiuipBaNmu0
 mUKk7WfmKyWQKYC5uqbSHHvLpUw5rA8S8QAwg++gGQVA3V+NC+v6zkPqITEnPlhDrvXM
 QJBHdDqIVtqLwvVFFcsci/U3ksqaFcsUFbBJnB4nTPFcDVIx1yReSAqzJGNzDmMvMtmi
 09Jg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7t33bqxJwQyBhHR+KRP3Xu1WVsNdxBFB3SJ4fmERk0ALWtbUyzDdG9rb2+OaIi29VAoiFnoaZFw1W@nongnu.org
X-Gm-Message-State: AOJu0YxRTEfKhTq2+HZIxtn3nKiANzoXibJQRm6ghGucmcp2dNorCxUJ
 snLV17G/YpAtSo66xE+injQcHO/G3Mn6Cp5c+0KQ6IrWJmkh4ZJeRSXBtyDSXfU=
X-Gm-Gg: ASbGncvIRoTRmcSS4S9jHgqK2uEOHplJl50kV/zKsepX8ZC+hw1UUDU414yd3+28iOy
 btW8kQBOMu7PfXAKTtJisaiKztVVCFsVbVkwz3zY5DQ8gVAC5tHk2OwZPqQt8sywyy2Z5zx028x
 dYuUT5O/an28hUwMOcnx1G/xmmPmiifUsemPI1078gh/L3Yp3bfQOWmeIH/WNa4lxMcx+yjLUKu
 gaUoISahyM0yTS8471tQSINDSn8781K0bh+170Fwtig6+JkfAP5IVcfa+o2PLljESnOB0np6S2z
 VZhNi40QGeGbZmomEsme2SGH
X-Google-Smtp-Source: AGHT+IE8qZr96m0zCsZRu6fva+Y2qgzLgB1jsCktSHMyyYibCbDdu04tNHOGkBYGQQjnaMWCEGKkyA==
X-Received: by 2002:a05:600c:4f47:b0:431:542d:2599 with SMTP id
 5b1f17b1804b1-436e26e1f6dmr265068195e9.22.1736973142735; 
 Wed, 15 Jan 2025 12:32:22 -0800 (PST)
Received: from [192.168.69.181] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c74d845esm34290345e9.27.2025.01.15.12.32.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jan 2025 12:32:22 -0800 (PST)
Message-ID: <63214572-5012-42ea-9872-6d5e2bb39823@linaro.org>
Date: Wed, 15 Jan 2025 21:32:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/11] hw/mips/loongson3_virt: Keep reference of vCPUs in
 machine_init()
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20250112215835.29320-1-philmd@linaro.org>
 <20250112215835.29320-3-philmd@linaro.org>
 <6c194ca4-6d37-416b-8ebe-b4789eee0de5@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <6c194ca4-6d37-416b-8ebe-b4789eee0de5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 15/1/25 06:18, Richard Henderson wrote:
> On 1/12/25 13:58, Philippe Mathieu-Daudé wrote:
>> Keep references of all vCPUs created. That allows
>> to directly access the first vCPU without using the
>> &first_cpu global.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   hw/mips/loongson3_virt.c | 9 +++++----
>>   1 file changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
>> index 47d112981a2..4b19941c1dc 100644
>> --- a/hw/mips/loongson3_virt.c
>> +++ b/hw/mips/loongson3_virt.c
>> @@ -492,9 +492,8 @@ static void mips_loongson3_virt_init(MachineState 
>> *machine)
>>   {
>>       int i;
>>       long bios_size;
>> -    MIPSCPU *cpu;
>> +    g_autofree MIPSCPU **cpus = NULL;
>>       Clock *cpuclk;
>> -    CPUMIPSState *env;
>>       DeviceState *liointc;
>>       DeviceState *ipi = NULL;
>>       char *filename;
>> @@ -569,13 +568,16 @@ static void 
>> mips_loongson3_virt_init(MachineState *machine)
>>       cpuclk = clock_new(OBJECT(machine), "cpu-refclk");
>>       clock_set_hz(cpuclk, DEF_LOONGSON3_FREQ);
>> +    cpus = g_new(MIPSCPU *, machine->smp.cpus);
>>       for (i = 0; i < machine->smp.cpus; i++) {
>> +        MIPSCPU *cpu;
>>           int node = i / LOONGSON3_CORE_PER_NODE;
>>           int core = i % LOONGSON3_CORE_PER_NODE;
>>           int ip;
>>           /* init CPUs */
>>           cpu = mips_cpu_create_with_clock(machine->cpu_type, cpuclk, 
>> false);
>> +        cpus[i] = cpu;
>>           /* Init internal devices */
>>           cpu_mips_irq_init_cpu(cpu);
>> @@ -609,7 +611,6 @@ static void mips_loongson3_virt_init(MachineState 
>> *machine)
>>                                  pin, cpu->env.irq[ip + 2]);
>>           }
>>       }
>> -    env = &MIPS_CPU(first_cpu)->env;
>>       /* Allocate RAM/BIOS, 0x00000000~0x10000000 is alias of 
>> 0x80000000~0x90000000 */
>>       memory_region_init_rom(bios, NULL, "loongson3.bios",
>> @@ -640,7 +641,7 @@ static void mips_loongson3_virt_init(MachineState 
>> *machine)
>>           loaderparams.kernel_filename = kernel_filename;
>>           loaderparams.kernel_cmdline = kernel_cmdline;
>>           loaderparams.initrd_filename = initrd_filename;
>> -        loaderparams.kernel_entry = load_kernel(env);
>> +        loaderparams.kernel_entry = load_kernel(&cpus[0]->env);

> We only ever use cpu[0].  We don't really need the whole array.

Yes. What about:

-- >8 --
commit ffc8c8873c0c102457f0e660437874555b022cc2
Author: Philippe Mathieu-Daudé <philmd@linaro.org>
Date:   Sun Jan 12 21:01:24 2025 +0100

     hw/mips/loongson3_virt: Invert vCPU creation order to remove &first_cpu

     Create vCPUs from the last one to the first one.
     No need to use the &first_cpu global since we already
     have it referenced.

     Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
index 47d112981a2..488eba495cd 100644
--- a/hw/mips/loongson3_virt.c
+++ b/hw/mips/loongson3_virt.c
@@ -496,3 +496,2 @@ static void mips_loongson3_virt_init(MachineState 
*machine)
      Clock *cpuclk;
-    CPUMIPSState *env;
      DeviceState *liointc;
@@ -571,3 +570,3 @@ static void mips_loongson3_virt_init(MachineState 
*machine)

-    for (i = 0; i < machine->smp.cpus; i++) {
+    for (i = machine->smp.cpus - 1; i >= 0; --i) {
          int node = i / LOONGSON3_CORE_PER_NODE;
@@ -611,3 +610,2 @@ static void mips_loongson3_virt_init(MachineState 
*machine)
      }
-    env = &MIPS_CPU(first_cpu)->env;

@@ -642,3 +640,3 @@ static void mips_loongson3_virt_init(MachineState 
*machine)
          loaderparams.initrd_filename = initrd_filename;
-        loaderparams.kernel_entry = load_kernel(env);
+        loaderparams.kernel_entry = load_kernel(&cpu->env);

---

