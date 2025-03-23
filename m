Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36AE8C28B30
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Mar 2025 19:08:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twQfj-0000Qq-0x; Sun, 23 Mar 2025 15:07:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1twQfh-0000Qc-Eo
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 15:07:45 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1twQff-0005Ze-0z
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 15:07:45 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-224019ad9edso89064725ad.1
 for <qemu-devel@nongnu.org>; Sun, 23 Mar 2025 12:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742756861; x=1743361661; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VX+Vt3+BF4hKcnyWdhBgYxnf1kOxeyXkUXVwZQGhr5g=;
 b=IhfAhsVRYcS8mdS6rM6Kh/r65fgZznMOe4nCDqrU3wzqnIG4+jiLd3paQuZMZd3SCh
 MauXtbfk0RECJEADPmhwm94jP7wswPsq1l2BVtGMEandFVLpVFwSia+3ehmMKuv0QxiX
 Wu1DZtXYe1bgl8HGGvVeKnLkd3H8jSl3ODmCgiqn0NIrQFos3yfftL4QurVXmidHPs/L
 9KrEJe0nZ085Dy096R7VsvmF3RXFJ5d9f0Tf+xqtNuuGrL54M7CtzG5M3Q+NaD/aFFBl
 WsfzzPKiUQuAZv6wetOfPyjh30QV835Y19nYYKcgHdAfa9hXkQx9MIdB2+UymPMshEyu
 /ZgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742756861; x=1743361661;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VX+Vt3+BF4hKcnyWdhBgYxnf1kOxeyXkUXVwZQGhr5g=;
 b=vFdpB0sKdgzgMHzg0iq5haV6IJRQIsn8kLCZMl4lHreX+XqOKbb4KqIvyPxtoZlE4e
 SgeiWAgdceMTNNj8n6Bhb/h/tMxsJsluekiFdAxp4EwuExTQalhaM/ZLmj0lpGIC8/7X
 0yEgH5JMUZPrsZLvt0Uvk8F2b6cd7L9R/XzmtPQgdJVZs8tXLAhtHoBtic1UFVCcWzlb
 ck04QqnzSl37otiU4Nu8BROOm4STNuCb5ykaZCcFIwBRSYM2SJO4+n/XxZYBQNIpwvXy
 l7bBw5IrkE7ItUiS9FFlEm7ZEi68aaY8qshiIs9PF9BcHztN+zp/pVr2MhYdlcgf3kk9
 6Dqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnduPxWJHc5Ir2tBtOKa7fn/Lym90DHz/V9loIvR9JKaoNuBAzhVwGUWMXbPnf9aj/axxkAE+JfPgi@nongnu.org
X-Gm-Message-State: AOJu0YxsGWKi9kLRGfwt36yTRNafkrBcibzDeYMyc1lNPxsyJS6qEa+t
 Ikmy0doOwqzpILM/6AnSzHCQHG52YqlMXhLNxps1zeSU1qSjjuoh7qC43ydeTFI=
X-Gm-Gg: ASbGnctHvjJKtcPOrys79PZDmPPZ0o0x/ToH5f6zXgkuqNoVnJxB+B58PchoqzqeOPj
 9ppeRrsxkS7+gcX3sGs6z6G3nX52kzYoxUJ3B9DBcB9W4gjoF/PPkO59czd/vzMo8vsuP3lZJYU
 XPN1OdkZs6xCKzUEOjamzkIzwKU0Nm+1LzN8cfqxXysM1OY/xT2vouXMYzYRomiEvDvFwU+04Zc
 ucQnqSX33qPNBv6Bqbp5Yc5gTz91vbKxkatxT0jQvaGMaDKirUBM8NSCy1NtwT5XHJP/JWfHm+k
 YEkUztJkPjSFRmVp6WLkh/K/4thMFH+Su6xe3GGQSHT2sI5Pv5noiVGeP7RxiyrLX8fcO/j7xxJ
 eEq08KsFZ
X-Google-Smtp-Source: AGHT+IHwyQcqF2zRGwurVZzX1WJCmUwqEC87/Ia20brIjauuBeMkiW6X+K+D5sqhJn6B0cnk/grebw==
X-Received: by 2002:a17:902:c94c:b0:21f:b483:2ad5 with SMTP id
 d9443c01a7336-22780d74f1amr116449045ad.20.1742756860465; 
 Sun, 23 Mar 2025 12:07:40 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22780f3980dsm55049695ad.47.2025.03.23.12.07.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Mar 2025 12:07:40 -0700 (PDT)
Message-ID: <8cc6f6a4-b868-4dc8-bc14-25b438ad62a5@linaro.org>
Date: Sun, 23 Mar 2025 12:07:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 4/4] tcg: Convert TARGET_SUPPORTS_MTTCG to
 TCGCPUOps::mttcg_supported field
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250321155925.96626-1-philmd@linaro.org>
 <20250321155925.96626-5-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250321155925.96626-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

On 3/21/25 08:59, Philippe Mathieu-Daudé wrote:
> Instead of having a compile-time TARGET_SUPPORTS_MTTCG definition,
> have each target set the 'mttcg_supported' field in the TCGCPUOps
> structure.
> 
> Since so far we only emulate one target architecture at a time,
> tcg_init_machine() gets whether MTTCG is supported via the
> &first_cpu global.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   docs/devel/multi-thread-tcg.rst          | 2 +-
>   configs/targets/aarch64-softmmu.mak      | 1 -
>   configs/targets/alpha-softmmu.mak        | 1 -
>   configs/targets/arm-softmmu.mak          | 1 -
>   configs/targets/hppa-softmmu.mak         | 1 -
>   configs/targets/i386-softmmu.mak         | 1 -
>   configs/targets/loongarch64-softmmu.mak  | 1 -
>   configs/targets/microblaze-softmmu.mak   | 1 -
>   configs/targets/microblazeel-softmmu.mak | 1 -
>   configs/targets/mips-softmmu.mak         | 1 -
>   configs/targets/mipsel-softmmu.mak       | 1 -
>   configs/targets/or1k-softmmu.mak         | 1 -
>   configs/targets/ppc64-softmmu.mak        | 1 -
>   configs/targets/riscv32-softmmu.mak      | 1 -
>   configs/targets/riscv64-softmmu.mak      | 1 -
>   configs/targets/s390x-softmmu.mak        | 1 -
>   configs/targets/sparc-softmmu.mak        | 1 -
>   configs/targets/sparc64-softmmu.mak      | 1 -
>   configs/targets/x86_64-softmmu.mak       | 1 -
>   configs/targets/xtensa-softmmu.mak       | 1 -
>   configs/targets/xtensaeb-softmmu.mak     | 1 -
>   include/accel/tcg/cpu-ops.h              | 8 ++++++++
>   include/exec/poison.h                    | 1 -
>   accel/tcg/tcg-all.c                      | 7 ++-----
>   target/alpha/cpu.c                       | 1 +
>   target/arm/cpu.c                         | 1 +
>   target/arm/tcg/cpu-v7m.c                 | 1 +
>   target/avr/cpu.c                         | 1 +
>   target/hexagon/cpu.c                     | 1 +
>   target/hppa/cpu.c                        | 1 +
>   target/i386/tcg/tcg-cpu.c                | 1 +
>   target/loongarch/cpu.c                   | 1 +
>   target/m68k/cpu.c                        | 1 +
>   target/microblaze/cpu.c                  | 1 +
>   target/mips/cpu.c                        | 1 +
>   target/openrisc/cpu.c                    | 1 +
>   target/ppc/cpu_init.c                    | 1 +
>   target/riscv/tcg/tcg-cpu.c               | 1 +
>   target/rx/cpu.c                          | 1 +
>   target/s390x/cpu.c                       | 1 +
>   target/sh4/cpu.c                         | 1 +
>   target/sparc/cpu.c                       | 1 +
>   target/tricore/cpu.c                     | 1 +
>   target/xtensa/cpu.c                      | 1 +
>   44 files changed, 31 insertions(+), 27 deletions(-)

As far as this goes,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

> @@ -91,11 +92,7 @@ static int tcg_init_machine(MachineState *ms)
>   #else
>       unsigned max_cpus = ms->smp.max_cpus;
>   #endif
> -#ifdef TARGET_SUPPORTS_MTTCG
> -    bool mttcg_supported = true;
> -#else
> -    bool mttcg_supported = false;
> -#endif
> +    bool mttcg_supported = first_cpu->cc->tcg_ops->mttcg_supported; /* FIXME avoid first_cpu */

Intersection of CPU_FOREACH?

> diff --git a/target/avr/cpu.c b/target/avr/cpu.c
> index 24e52e28f44..9bc921c1cb2 100644
> --- a/target/avr/cpu.c
> +++ b/target/avr/cpu.c
> @@ -216,6 +216,7 @@ static const TCGCPUOps avr_tcg_ops = {
>       .cpu_exec_halt = avr_cpu_has_work,
>       .tlb_fill = avr_cpu_tlb_fill,
>       .do_interrupt = avr_cpu_do_interrupt,
> +    .mttcg_supported = false,
>       .guest_default_memory_order = 0,
>   };

This may well be the only true not supported.
I'm not sure what needs to happen to make that true.

> diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
> index 34734b0edb0..7bcf297998f 100644
> --- a/target/hexagon/cpu.c
> +++ b/target/hexagon/cpu.c
> @@ -324,6 +324,7 @@ static const TCGCPUOps hexagon_tcg_ops = {
>       .translate_code = hexagon_translate_code,
>       .synchronize_from_tb = hexagon_cpu_synchronize_from_tb,
>       .restore_state_to_opc = hexagon_restore_state_to_opc,
> +    .mttcg_supported = false,
>       /* MTTCG not yet supported: require strict ordering */
>       .guest_default_memory_order = TCG_MO_ALL,

We now have strict ordering, right there with TCG_MO_ALL.
Likewise for m68k, sh4, tricore.
I think we simply forgot to update.

> diff --git a/target/mips/cpu.c b/target/mips/cpu.c
> index 5ddc9bbb829..eee604e9254 100644
> --- a/target/mips/cpu.c
> +++ b/target/mips/cpu.c
> @@ -554,6 +554,7 @@ static const TCGCPUOps mips_tcg_ops = {
>       .synchronize_from_tb = mips_cpu_synchronize_from_tb,
>       .restore_state_to_opc = mips_restore_state_to_opc,
>   
> +    .mttcg_supported = TARGET_LONG_BITS == 32,
>       .guest_default_memory_order = 0,

What is missing from mip64?

> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> index 28fbbb8d3c1..ed79cc1a6b7 100644
> --- a/target/ppc/cpu_init.c
> +++ b/target/ppc/cpu_init.c
> @@ -7490,6 +7490,7 @@ static const TCGCPUOps ppc_tcg_ops = {
>     .translate_code = ppc_translate_code,
>     .restore_state_to_opc = ppc_restore_state_to_opc,
>   
> +  .mttcg_supported = TARGET_LONG_BITS == 64,
>     .guest_default_memory_order = 0,

Similarly.  I'd be surprised if ppc32 can't use mttcg, really.


r~

