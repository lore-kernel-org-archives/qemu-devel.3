Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D20CCC28B30
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Mar 2025 21:25:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twSoC-0004RS-1D; Sun, 23 Mar 2025 17:24:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1twSoA-0004Qr-B8
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 17:24:38 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1twSo7-0006DW-Bw
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 17:24:38 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43d04dc73b7so40149835e9.3
 for <qemu-devel@nongnu.org>; Sun, 23 Mar 2025 14:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742765073; x=1743369873; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EoEtcm6LsfD8xLgiFuX12mIF4gxms7kBYoj+va1SHSg=;
 b=ZvalTA2AXBJ175skyUa0UKk5XbvXNEqQUeTNtETbr8ECXwvppOuZZR+cbAFpt88bx+
 9xoc3+YfZobdLaBXpLjkIWgxb128uDVPKBelT3F3zygFSAt5uRqMgzMo3bBhDR6X9/vC
 u+CO9wIxWKPN4bJwS25isdWRo0nEUDjgCSDmHJzV/4SfFqCOBQe6lWTdFsNH4/jDvyzH
 6Z69n8t56SXJB0eTIyQqplUURU9NLpR5wTezMpgbwn0SbMbgUEM4jVNGRQ0/uPWxwSfq
 5HlExOEL5OqZvgbJnnr4zKG7RqIsFtOZ2L4s/5qtdi3hCOBA0DTAMGA98vtZW546dWYn
 2Q7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742765073; x=1743369873;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EoEtcm6LsfD8xLgiFuX12mIF4gxms7kBYoj+va1SHSg=;
 b=fM7tzBYFUTRBXRO4NiVOZj3kDTvE1Zt3SH2wWr5K1tW9A4HqpMqwmRM4AhvI27AzkR
 hrrkTBttdthU5/gsT6Tls+3OYfMbW6Y/1zx7rvcLXyAPcAwXhtmBhlvmapszw7HnxMMZ
 yPvyMWoqmgSZjkXYW1nPT+J9xVJU110VknK5du4YYxz5fPhU1E588VSBcFitDiE5SBXm
 1j1jtIZmvHnIapOdSOQs8lW9ggsfjeW45xMyu8aoiV386AY24Iau184Tv3w8ypAa0zNO
 jf8ASUgH6QI8A1A1qFIwcCjT9bMHmx0AB6CYGd7ac+JvKMXyzEVAtss8k0jgUK/gVrFM
 nOZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJk0giYUNaNf61nN1CApreeqLfAY4D4QuoBTqwHi8PaKDILCu9WQGbho5FF6btFvMrPsb8U/zWcA0z@nongnu.org
X-Gm-Message-State: AOJu0YwLNKNcatW51cnGRTl4zHcj+8qEM5DRMpxb8WTdI7KlVOA/mtji
 Xns4nqKQkGfCOBzp3phVZCFPx7R/e/oovH5K1JkUcz4EkxlAVWzSYciXvEsP0+I=
X-Gm-Gg: ASbGncv8SM+TEsCkb+KAMrhtUKc8a3RET3QYNzQaE40UoHnzuI+sbvfdYXToy8MK2w5
 Lx9VZIpM9k7CmcYEQkJOMnXRk9A/ZelcecVX8Wg05OzCVDaeD8K7EQz1jxeWVivLBboEZzxbixn
 jDupeVU5Xrgaa4xiknQDU1QjDHQdPpwOLpmND1rM3D43fjBmWqDDrIyJu2YfymufdXu1SOsH9OH
 /teKLGMr4Y4Eh0QQCZZetksaW5Lx8MoAZqIfdKKbA0jjgGmy98Li9oKsr9sS+7ZzSAoEithYBvk
 uZwnU/97c321+D/9pKYr2YE8NR/hZ+Mvrt7DxUOG0Dtx8GETs3Z1VQFqz9vi1vE2jeIdR3BbsWE
 toRbBQWsnitUk3glT9A==
X-Google-Smtp-Source: AGHT+IEIDHBv9cV6VFeAXsx09K6KuhFOjB0c9zRsh5J2Rdn/og9HjW31E2wDSYG9RPdWy8MrFTL81g==
X-Received: by 2002:a05:600c:190e:b0:43d:b51:46fb with SMTP id
 5b1f17b1804b1-43d509e0514mr97289055e9.2.1742765073502; 
 Sun, 23 Mar 2025 14:24:33 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d4fd9ec84sm97266275e9.26.2025.03.23.14.24.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Mar 2025 14:24:32 -0700 (PDT)
Message-ID: <5bd8498c-b5ff-4fb1-94d7-a2efa2f20fd9@linaro.org>
Date: Sun, 23 Mar 2025 22:24:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 4/4] tcg: Convert TARGET_SUPPORTS_MTTCG to
 TCGCPUOps::mttcg_supported field
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-ppc <qemu-ppc@nongnu.org>
Cc: Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
References: <20250321155925.96626-1-philmd@linaro.org>
 <20250321155925.96626-5-philmd@linaro.org>
 <8cc6f6a4-b868-4dc8-bc14-25b438ad62a5@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <8cc6f6a4-b868-4dc8-bc14-25b438ad62a5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 23/3/25 20:07, Richard Henderson wrote:
> On 3/21/25 08:59, Philippe Mathieu-Daudé wrote:
>> Instead of having a compile-time TARGET_SUPPORTS_MTTCG definition,
>> have each target set the 'mttcg_supported' field in the TCGCPUOps
>> structure.
>>
>> Since so far we only emulate one target architecture at a time,
>> tcg_init_machine() gets whether MTTCG is supported via the
>> &first_cpu global.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   docs/devel/multi-thread-tcg.rst          | 2 +-
>>   configs/targets/aarch64-softmmu.mak      | 1 -
>>   configs/targets/alpha-softmmu.mak        | 1 -
>>   configs/targets/arm-softmmu.mak          | 1 -
>>   configs/targets/hppa-softmmu.mak         | 1 -
>>   configs/targets/i386-softmmu.mak         | 1 -
>>   configs/targets/loongarch64-softmmu.mak  | 1 -
>>   configs/targets/microblaze-softmmu.mak   | 1 -
>>   configs/targets/microblazeel-softmmu.mak | 1 -
>>   configs/targets/mips-softmmu.mak         | 1 -
>>   configs/targets/mipsel-softmmu.mak       | 1 -
>>   configs/targets/or1k-softmmu.mak         | 1 -
>>   configs/targets/ppc64-softmmu.mak        | 1 -
>>   configs/targets/riscv32-softmmu.mak      | 1 -
>>   configs/targets/riscv64-softmmu.mak      | 1 -
>>   configs/targets/s390x-softmmu.mak        | 1 -
>>   configs/targets/sparc-softmmu.mak        | 1 -
>>   configs/targets/sparc64-softmmu.mak      | 1 -
>>   configs/targets/x86_64-softmmu.mak       | 1 -
>>   configs/targets/xtensa-softmmu.mak       | 1 -
>>   configs/targets/xtensaeb-softmmu.mak     | 1 -
>>   include/accel/tcg/cpu-ops.h              | 8 ++++++++
>>   include/exec/poison.h                    | 1 -
>>   accel/tcg/tcg-all.c                      | 7 ++-----
>>   target/alpha/cpu.c                       | 1 +
>>   target/arm/cpu.c                         | 1 +
>>   target/arm/tcg/cpu-v7m.c                 | 1 +
>>   target/avr/cpu.c                         | 1 +
>>   target/hexagon/cpu.c                     | 1 +
>>   target/hppa/cpu.c                        | 1 +
>>   target/i386/tcg/tcg-cpu.c                | 1 +
>>   target/loongarch/cpu.c                   | 1 +
>>   target/m68k/cpu.c                        | 1 +
>>   target/microblaze/cpu.c                  | 1 +
>>   target/mips/cpu.c                        | 1 +
>>   target/openrisc/cpu.c                    | 1 +
>>   target/ppc/cpu_init.c                    | 1 +
>>   target/riscv/tcg/tcg-cpu.c               | 1 +
>>   target/rx/cpu.c                          | 1 +
>>   target/s390x/cpu.c                       | 1 +
>>   target/sh4/cpu.c                         | 1 +
>>   target/sparc/cpu.c                       | 1 +
>>   target/tricore/cpu.c                     | 1 +
>>   target/xtensa/cpu.c                      | 1 +
>>   44 files changed, 31 insertions(+), 27 deletions(-)
> 
> As far as this goes,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
>> @@ -91,11 +92,7 @@ static int tcg_init_machine(MachineState *ms)
>>   #else
>>       unsigned max_cpus = ms->smp.max_cpus;
>>   #endif
>> -#ifdef TARGET_SUPPORTS_MTTCG
>> -    bool mttcg_supported = true;
>> -#else
>> -    bool mttcg_supported = false;
>> -#endif
>> +    bool mttcg_supported = first_cpu->cc->tcg_ops->mttcg_supported; / 
>> * FIXME avoid first_cpu */
> 
> Intersection of CPU_FOREACH?

Short term I used CPU_RESOLVING_TYPE:

     CPUClass *cc = CPU_CLASS(object_class_by_name(CPU_RESOLVING_TYPE));
     mttcg_supported = cc->tcg_ops->mttcg_supported;

I'll move to some helper.

Long term we need the intersection. I'll add a comment for now.

>> diff --git a/target/avr/cpu.c b/target/avr/cpu.c
>> index 24e52e28f44..9bc921c1cb2 100644
>> --- a/target/avr/cpu.c
>> +++ b/target/avr/cpu.c
>> @@ -216,6 +216,7 @@ static const TCGCPUOps avr_tcg_ops = {
>>       .cpu_exec_halt = avr_cpu_has_work,
>>       .tlb_fill = avr_cpu_tlb_fill,
>>       .do_interrupt = avr_cpu_do_interrupt,
>> +    .mttcg_supported = false,
>>       .guest_default_memory_order = 0,
>>   };
> 
> This may well be the only true not supported.
> I'm not sure what needs to happen to make that true.

I'd postpone that for later ;)

>> diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
>> index 34734b0edb0..7bcf297998f 100644
>> --- a/target/hexagon/cpu.c
>> +++ b/target/hexagon/cpu.c
>> @@ -324,6 +324,7 @@ static const TCGCPUOps hexagon_tcg_ops = {
>>       .translate_code = hexagon_translate_code,
>>       .synchronize_from_tb = hexagon_cpu_synchronize_from_tb,
>>       .restore_state_to_opc = hexagon_restore_state_to_opc,
>> +    .mttcg_supported = false,
>>       /* MTTCG not yet supported: require strict ordering */
>>       .guest_default_memory_order = TCG_MO_ALL,
> 
> We now have strict ordering, right there with TCG_MO_ALL.
> Likewise for m68k, sh4, tricore.
> I think we simply forgot to update.

Doh... I'll clean in a preliminary patch, thanks.

>> diff --git a/target/mips/cpu.c b/target/mips/cpu.c
>> index 5ddc9bbb829..eee604e9254 100644
>> --- a/target/mips/cpu.c
>> +++ b/target/mips/cpu.c
>> @@ -554,6 +554,7 @@ static const TCGCPUOps mips_tcg_ops = {
>>       .synchronize_from_tb = mips_cpu_synchronize_from_tb,
>>       .restore_state_to_opc = mips_restore_state_to_opc,
>> +    .mttcg_supported = TARGET_LONG_BITS == 32,
>>       .guest_default_memory_order = 0,
> 
> What is missing from mip64?

See:

commit a092a95547710bcbb8c168e5ec03f55fb4ab1ad7
Author: Alex Bennée <alex.bennee@linaro.org>
Date:   Mon Mar 23 16:15:09 2020 +0000

     configure: disable MTTCG for MIPS guests

     While debugging check-acceptance failures I found an instability in
     the mips64el test case. Briefly the test case:

       retry.py -n 100 -c -- ./mips64el-softmmu/qemu-system-mips64el \
         -display none -vga none -serial mon:stdio \
         -machine malta -kernel ./vmlinux-4.7.0-rc1.I6400 \
         -cpu I6400 -smp 8 -vga std \
         -append "printk.time=0 clocksource=GIC console=tty0 " \
                 "console=ttyS0 panic=-1" \
         --no-reboot

     Reports about a 9% failure rate:

       Results summary:
       0: 91 times (91.00%), avg time 5.547 (0.45 varience/0.67 deviation)
       -6: 9 times (9.00%), avg time 3.394 (0.02 varience/0.13 deviation)
       Ran command 100 times, 91 passes

     When re-run with "--accel tcg,thread=single" the instability goes
     away.

       Results summary:
       0: 100 times (100.00%), avg time 17.318 (249.76 varience/15.80 
deviation)
       Ran command 100 times, 100 passes

     Which seems to indicate there is some aspect of the MIPS MTTCG fixes
     that has been missed. Ideally we would fix that but I'm afraid I
     don't have time to investigate and am not super familiar with the
     architecture anyway. In lieu of someone tracking down the failure
     lets disable it for now.

> 
>> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
>> index 28fbbb8d3c1..ed79cc1a6b7 100644
>> --- a/target/ppc/cpu_init.c
>> +++ b/target/ppc/cpu_init.c
>> @@ -7490,6 +7490,7 @@ static const TCGCPUOps ppc_tcg_ops = {
>>     .translate_code = ppc_translate_code,
>>     .restore_state_to_opc = ppc_restore_state_to_opc,
>> +  .mttcg_supported = TARGET_LONG_BITS == 64,
>>     .guest_default_memory_order = 0,
> 
> Similarly.  I'd be surprised if ppc32 can't use mttcg, really.

Per Cédric on IRC our ppc32 implementations are single core,
so never tested for mttcg.

Regards,

Phil.

