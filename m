Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A888C83F1D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 06:58:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubZbi-0000fh-MA; Tue, 15 Jul 2025 02:57:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubZba-0000ZR-Ru
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 02:57:35 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubZbY-0002gz-9V
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 02:57:34 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3a4fd1ba177so3320985f8f.0
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 23:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752562649; x=1753167449; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dx8QkFpRfi1Db8qixQ0aOOCFY9z/4Vclrxbud9FdyCs=;
 b=hMrujFcV8S7bcAOtVvMi+Nfx/uykzFNIM6Tv2oj6WWj3d/dU1LDIs/wma3OzAbz7QP
 Rw+B8U76bhW1lihmIQ2t33diLSZtgW+24FAEMT7fyiz2Dxq8rVj3ncTIpAJOSOZ03eve
 vHZdTsEoIZ8VLO5XQ4B5ck5P19eHp9wRJRSx0SY/z/raxy3+J49ag9cyY3F8JOT6CJUw
 vfyJ2/479yqJuxsdqhJ+efjgQqYgc+Ib01BmglZpWqBS4cq3ZlrRhH24gFp4o0C4pUUr
 8BMhhbvtZOPEKt6ptK8fyA+z4/fjGhzlIYCQLWoRy8V1ngro9NTWaJxLAaPpqIjeRuyN
 SmSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752562649; x=1753167449;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dx8QkFpRfi1Db8qixQ0aOOCFY9z/4Vclrxbud9FdyCs=;
 b=ORIXkN22/5KK2fHuVgTZy2MFVFKge4e2mVmDUN4Sna+iRiLiUHYXXGQ8PAYiCj+eIh
 1JhYsJsRU+5HlnEHQjr37b2LqNsGpBraYy4xWvO/0hcNkdMh+UwD6KncqxuIrA6BfEwh
 xjxMN5FlKqLTzQMsWoJl223ieWbLs8zYK5SlCjbAnICfuNBqJmEO6pnjd5bru4js5zYc
 rMRR+BEQYo9Wk2nH5ho8OsZMEx2pvLgFYnS/yIrjkfUYhZ7/T2+RIRGJfUNcOPiyAgmT
 KrMfgezDdtf2jE1n/xszYCPFW8el78XlH/s65nSCyZzcedXdeW2ZJWucZIW3Ia/MsRj8
 TAlg==
X-Gm-Message-State: AOJu0YwsU5IVcp5hp/2Q9trEdoDADmXlr4TeHl9dpLgdkKXMdt8J1dQm
 FkudJDotgPPiVaptkhY5OJK5p3Hv5Ma1oQ5W9U8qRZXaRQ8X07IXJcwl0q3r4jg8RoapmNCbffG
 eu9cC
X-Gm-Gg: ASbGnctdIklLBZa4up/sQhyiOelGXS0ewbHh7dJNABBoudl3krV4k43N2jONUhFtzyh
 AeVSEtEkEIxWcTX1oR2tI9KOjUccVPT60I7n1RRK6TsSKZ3Js+3QnUDPiz9tq/KMUn8fL/ELUnz
 BdKYETXKOsCb0D85c/Bv2sjKk2maf8dzEa4pLiE1MY9qztys6czawALi5W63GMiVJq8KOf/nkET
 2gbA/OGi9e5E5eEEah6eNpwX6DJ5SAYHI4rbpDZVVayk720WY/C+QLZeuYoJKVAfxffz1sRpRs7
 7h7xMlSLd3fNPQ3NECzIp0eIFyFi4bGF+KE2FgMCNCz6h8I8zkU6IgT7dumOUqhnyuUYU5Bw+wO
 76N2TMxOZnb2SSydAj4ZncN/imAyPVuB3tWkZurJxEtTc22XKFRzVi6cnwLBitMCz1UiMa3P0ja
 oer0/8Og==
X-Google-Smtp-Source: AGHT+IFJQxubv0woBVz8zjh//luA9/UYH580NPzWbiLiaNAj4DVSrTiOZ/wrmleCc6lqzmE/cjxYCA==
X-Received: by 2002:a05:6000:2511:b0:3a5:2b1e:c49b with SMTP id
 ffacd0b85a97d-3b6095459f9mr1623662f8f.29.1752562648870; 
 Mon, 14 Jul 2025 23:57:28 -0700 (PDT)
Received: from [192.168.69.239] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-456297f8621sm3172435e9.4.2025.07.14.23.57.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Jul 2025 23:57:28 -0700 (PDT)
Message-ID: <3cfa886a-c0f2-40ae-af16-d9f019ab70d3@linaro.org>
Date: Tue, 15 Jul 2025 08:57:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] target/mips: Only update MVPControl.EVP bit if
 executed by master VPE
To: qemu-devel@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Hansni Bu <1926277@bugs.launchpad.net>
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>
References: <20210427133343.159718-1-f4bug@amsat.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20210427133343.159718-1-f4bug@amsat.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

Ping?

On 27/4/21 15:33, Philippe Mathieu-Daudé wrote:
> According to the 'MIPS MT Application-Speciﬁc Extension' manual:
> 
>    If the VPE executing the instruction is not a Master VPE,
>    with the MVP bit of the VPEConf0 register set, the EVP bit
>    is unchanged by the instruction.
> 
> Modify the DVPE/EVPE opcodes to only update the MVPControl.EVP bit
> if executed on a master VPE.
> 
> Reported-by: Hansni Bu <https://launchpad.net/%7Ehansni/+contactuser>
> Buglink: https://bugs.launchpad.net/qemu/+bug/1926277
> Fixes: f249412c749 ("mips: Add MT halting and waking of VPEs")
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
> Supersedes: <20210427103555.112652-1-f4bug@amsat.org>
> v2: Check VPEConf0.MVP bit (hansni)
> ---
>   target/mips/cp0_helper.c | 32 ++++++++++++++++++--------------
>   1 file changed, 18 insertions(+), 14 deletions(-)
> 
> diff --git a/target/mips/cp0_helper.c b/target/mips/cp0_helper.c
> index aae2af6eccc..d5f274f5cdf 100644
> --- a/target/mips/cp0_helper.c
> +++ b/target/mips/cp0_helper.c
> @@ -1635,12 +1635,14 @@ target_ulong helper_dvpe(CPUMIPSState *env)
>       CPUState *other_cs = first_cpu;
>       target_ulong prev = env->mvp->CP0_MVPControl;
>   
> -    CPU_FOREACH(other_cs) {
> -        MIPSCPU *other_cpu = MIPS_CPU(other_cs);
> -        /* Turn off all VPEs except the one executing the dvpe.  */
> -        if (&other_cpu->env != env) {
> -            other_cpu->env.mvp->CP0_MVPControl &= ~(1 << CP0MVPCo_EVP);
> -            mips_vpe_sleep(other_cpu);
> +    if (env->CP0_VPEConf0 & (1 << CP0VPEC0_MVP)) {
> +        CPU_FOREACH(other_cs) {
> +            MIPSCPU *other_cpu = MIPS_CPU(other_cs);
> +            /* Turn off all VPEs except the one executing the dvpe.  */
> +            if (&other_cpu->env != env) {
> +                other_cpu->env.mvp->CP0_MVPControl &= ~(1 << CP0MVPCo_EVP);
> +                mips_vpe_sleep(other_cpu);
> +            }
>           }
>       }
>       return prev;
> @@ -1651,15 +1653,17 @@ target_ulong helper_evpe(CPUMIPSState *env)
>       CPUState *other_cs = first_cpu;
>       target_ulong prev = env->mvp->CP0_MVPControl;
>   
> -    CPU_FOREACH(other_cs) {
> -        MIPSCPU *other_cpu = MIPS_CPU(other_cs);
> +    if (env->CP0_VPEConf0 & (1 << CP0VPEC0_MVP)) {
> +        CPU_FOREACH(other_cs) {
> +            MIPSCPU *other_cpu = MIPS_CPU(other_cs);
>   
> -        if (&other_cpu->env != env
> -            /* If the VPE is WFI, don't disturb its sleep.  */
> -            && !mips_vpe_is_wfi(other_cpu)) {
> -            /* Enable the VPE.  */
> -            other_cpu->env.mvp->CP0_MVPControl |= (1 << CP0MVPCo_EVP);
> -            mips_vpe_wake(other_cpu); /* And wake it up.  */
> +            if (&other_cpu->env != env
> +                /* If the VPE is WFI, don't disturb its sleep.  */
> +                && !mips_vpe_is_wfi(other_cpu)) {
> +                /* Enable the VPE.  */
> +                other_cpu->env.mvp->CP0_MVPControl |= (1 << CP0MVPCo_EVP);
> +                mips_vpe_wake(other_cpu); /* And wake it up.  */
> +            }
>           }
>       }
>       return prev;


