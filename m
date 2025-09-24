Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11542CAC5A5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 17:51:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1TdM-0007W7-NC; Wed, 24 Sep 2025 13:50:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1TdF-0007OS-2a
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 13:50:22 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1Td9-00044c-OZ
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 13:50:18 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-279e2554b5fso349175ad.1
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 10:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758736208; x=1759341008; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=C7HophvV50zQjgDuislDijlxxcmyj7QX5e3sa2xQvnw=;
 b=J5J9J3sY5zFAqlYRg9j19uu3fxtt0SDV6XdZE6uZhhmNyvIDsPpus5Tznv03yNZiM2
 2LgZ0dNu8L4VTf7117eS0YmkqAb+HTefE849E9QVSCdKhUsaatjyNC9GVkdKyG1jJg71
 vTJLn4anU3uF3fiD8amiqZX7tqAkmltQb27sBKZ+HZCUjrUHpvxcwcgdYIA8AVnWPzRm
 wsFq+umhM6oilgvVxogsSVY07NTBsppxF7HD/X9ezAgUKxP4UGLEizYuEUQO9lnBPprU
 filCnMdXfS3DU4tZ3MYsCXsFe0rQxlvultKdcC2wlLKNAqfvE0irYPUWj/eskGxrgE2T
 X33w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758736208; x=1759341008;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=C7HophvV50zQjgDuislDijlxxcmyj7QX5e3sa2xQvnw=;
 b=ML8CC84bkS/ZDImpGVhPsx/6fbHtISnsAmqwTxqT8VS1A51/Jhn84LH7eNjdpfnTea
 tJu0KML8Crl1nVyLpBg+A/zYpvZeXnj2daAXT6x+drWvZsgFCo5XzNhlL16q/7LMTNxu
 imRXZ82M4OJesEVxgt58VVb5rTWNeME6qHLjjhhlHbBMdGrMX6h2BbTw+iW8x9zVk40z
 rhf22Epu2E5gHVJTFlXod13NlU5mlhkbfyWO0w8TCeyutm1UqzPPThaJQnVYSwzb0flZ
 1gQn1Rc3heWz5b/Jg0C+wrMHlIxSsTTFT3qMarzDAvleyj8wFA9evw6+/jPkeAf5ooyk
 p5kA==
X-Gm-Message-State: AOJu0YwqilCaKOHfG4xBGXPKFF3ywWRJVh4XO/skm1cu6I8Ta8IggVTG
 cyQUSXtBnhCEZg7GICTH5wIK/BRdwZ1jDx0grsRSAgoZYxoC3a8TMxd1PxShV/nxgCiGwMoelup
 Y4HIe
X-Gm-Gg: ASbGnct6vzJqbYki5fqF6v09Atz6lxylvGyGrpv+D9QOqSOBVzVhXu8IT59TnR/TcbV
 J8gzFMJsc2LDzLGDb1xJeiZ2QwLALRdV4pHkThgabfNJv8nz2vbResejxPX2MMQIQunnIZTjm4F
 ShNm8VsLHzgxHInVKLD/e730TUyp6uNB5dY2XzTr0KKAbCqEUzSqYL817X37CidHVfWPyUreXC1
 BsqckWxwPM7I1qpQkN+APrPu3R3OnuE7HKXjCLcrPe6HYtcqr4HhLWLRw5dHntgDOCX79zClwQa
 VV/kxZ3dcyRBxuMLZyP1EHxtVsf6bnOki4cXXDmdbjEbIe7kdWJ1d5J2Ep0szfSD++Ele1IEfEH
 Fr0gyRXAoUTUzb7W2WeP2O+yxzPFSilpN+JUe
X-Google-Smtp-Source: AGHT+IH7QwU0h7lv4+2X0hstE0ho7jzRTqbYaIfasvQen3FHqfQtsPFdSeOPI7bE5kRaH9SzwCImbA==
X-Received: by 2002:a17:902:e848:b0:269:95a1:94c2 with SMTP id
 d9443c01a7336-27ed4c6790amr4962825ad.3.1758736208601; 
 Wed, 24 Sep 2025 10:50:08 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-27ec9da0eb1sm20083855ad.121.2025.09.24.10.50.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Sep 2025 10:50:08 -0700 (PDT)
Message-ID: <d9109c47-6452-401f-94a6-784949d5f421@linaro.org>
Date: Wed, 24 Sep 2025 10:50:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] target/xtensa: Replace CPUXtensa:runstall by
 CPUState:start_powered_off
To: qemu-devel@nongnu.org
References: <20250924174045.54241-1-philmd@linaro.org>
 <20250924174045.54241-3-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250924174045.54241-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

On 9/24/25 10:40, Philippe Mathieu-Daudé wrote:
> CPUXtensa::runstall and CPUState::start_powered_off are
> semantically equivalent. Replace the target specific field
> by the generic one.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/xtensa/cpu.h    | 1 -
>   target/xtensa/cpu.c    | 8 ++++++--
>   target/xtensa/helper.c | 6 ++++--
>   3 files changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
> index 74122ebe15c..43b8cabdcd3 100644
> --- a/target/xtensa/cpu.h
> +++ b/target/xtensa/cpu.h
> @@ -529,7 +529,6 @@ struct CPUArchState {
>       xtensa_tlb_entry dtlb[10][MAX_TLB_WAY_SIZE];
>       xtensa_mpu_entry mpu_fg[MAX_MPU_FOREGROUND_SEGMENTS];
>       unsigned autorefill_idx;
> -    bool runstall;
>       AddressSpace *address_space_er;
>       MemoryRegion *system_er;
>       int pending_irq_level; /* level of last raised IRQ */
> diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
> index ea9b6df3aa2..65f0e778775 100644
> --- a/target/xtensa/cpu.c
> +++ b/target/xtensa/cpu.c
> @@ -143,7 +143,7 @@ static bool xtensa_cpu_has_work(CPUState *cs)
>   {
>       CPUXtensaState *env = cpu_env(cs);
>   
> -    return !env->runstall && env->pending_irq_level;
> +    return !cs->start_powered_off && env->pending_irq_level;
>   }
>   #endif /* !CONFIG_USER_ONLY */
>   
> @@ -204,7 +204,11 @@ static void xtensa_cpu_reset_hold(Object *obj, ResetType type)
>   
>   #ifndef CONFIG_USER_ONLY
>       reset_mmu(env);
> -    cs->halted = env->runstall;
> +    if (cs->start_powered_off) {
> +        cs->halted = 1;
> +    } else {
> +        cs->halted = 0;
> +    }

This would of course be

   cs->halted = cs->start_powered_off;

though I'm a bit surprised that such generic fields must
be handled in target-specific code.


>   #endif
>       /* For inf * 0 + NaN, return the input NaN */
>       set_float_infzeronan_rule(float_infzeronan_dnan_never, &env->fp_status);
> diff --git a/target/xtensa/helper.c b/target/xtensa/helper.c
> index 2d93b45036d..a64df1cadac 100644
> --- a/target/xtensa/helper.c
> +++ b/target/xtensa/helper.c
> @@ -311,11 +311,13 @@ void xtensa_runstall(CPUXtensaState *env, bool runstall)
>   {
>       CPUState *cpu = env_cpu(env);
>   
> -    env->runstall = runstall;
> -    cpu->halted = runstall;
>       if (runstall) {
> +        cpu->start_powered_off = true;
> +        cpu->halted = 1;
>           cpu_interrupt(cpu, CPU_INTERRUPT_HALT);
>       } else {
> +        cpu->start_powered_off = false;
> +        cpu->halted = 0;
>           qemu_cpu_kick(cpu);
>       }
>   }

Why this change?


r~


