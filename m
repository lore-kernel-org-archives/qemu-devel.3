Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5195EC5DF81
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 20:14:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwmg1-000718-Ll; Wed, 19 Aug 2026 16:14:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwmfz-00070u-Hf
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 16:14:19 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwmfx-0005dr-S4
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 16:14:19 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-38e347638adso1677499a91.0
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 13:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787170456; x=1787775256; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=PQ/X5M0KjaaeVriedh+tWd1p8VlqTLWK5t49DuYJU3M=;
 b=HBsHATcipU6jEzC1cgMnGFVs1p8BoBeHOUw9vyfeKAKoYO6Pzk5vstFMFW0TRaztXl
 /UftMnJVaK6PfFC78GFoFsTbkhDKoBh2T96fa6Gjwsqk/XfRp/HjKAgx5vaIkXaDEnj+
 HW3MgXJ4dfU6ZX0kKxUS595fpKuVHMi+NXBGqMKXmGpCmM8AzpnVh6viMvyk2P6Qqklr
 9xLwD/HFwK+Z2WeI3V9kz/KuZwIpyCco7jKcodh+U5UB8wetHxHpZGPxmnv8esUrtVVX
 +LZLazuNVS4jHkrM25UOzwRiy8jg3S6YSZdO7pXwJ2tp85jn5joo76sXhhh+3qdUY7QY
 lH1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787170456; x=1787775256;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PQ/X5M0KjaaeVriedh+tWd1p8VlqTLWK5t49DuYJU3M=;
 b=JiTBxPK6G2VfcTAkLjgytmZ1rsVsyVzeeUvsAsUA86stlGROFoQkWx0l4bcAgkC30q
 wsXStKSBi6ps99ee/WRgdg92Qhd92Fd9JT20VdeR5isaDcyevh6K+riqk9cGd7dVBfiF
 ljWC0w356GGgChZ3rK7gyHkKMK8DQdYarZOz3n1awBg2lytGj3LQrg3xrL8EaDL8MIY1
 3gc5nsGaT4jN7a+5o/i0k+sWKK4FgpTkiYr31K6d0CIDSSrqL2x77u3SkqFgM4qTFON0
 GGGzFTwLeEFojoSBEfH7PMokaaGgXgcueVwTfNlKOf6CSqybFyWkq2E2UAo1FEIaAfZg
 JqZw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqq74B7Bjxum1OI4Yo9+eSlVLRTm+/S8NbvF9jWLi3NMpSYdpcPrIOuOVnAYKQhRxKs9CB7uzoMpxI8@nongnu.org
X-Gm-Message-State: AFuF++koL/+2TDeCXTEOmkM7V3Ryr8ZPmLt0gt7lYCZbymNxervcqYYh
 B7faD2+rToCHDLE2Bf4IeOdCLoTLRDaaMD2JS6itgqeBxJoQTb6pvt3RDiiKFHxU4IY=
X-Gm-Gg: AR+sD10cHkOCIqLfg7N1FqmD5A/Q+6EwkQUnAxL3ZbNBA3NonsqnE3T6AhE/Hd5o+lr
 amEAW1JPB6r+UNd3JPOKj3txPRB8vvQxtKaP/NuwYPOcTEI/ZtjnO9SGAjr3TVHQCoNeQhoHIHn
 SfWuokSQxTehslUZ96Dc4XHel/NCfjoDhCboQ/CPgyvo3aokD9vAh6kjvhOOZqj+UBurSwTJjjn
 GVTQgHZhPtCJ/KzIXEgAE56E3y59HVF7w/Fo/DJ7V4CxbTbZmcj4Gz1ouKqqsF7TNBgwJFta3TU
 QZfedvLctemGoM/gSXFTLThJ6XZdPI4Mb4mJWMsr+4N8acChara0UOIwPylN5vG3ecuMOAEM2+i
 7hirGJNr8vfrSVidUN9m/BqaWgelOBIgVNpyhtzjoY06QqKFMF840WXbnSEnh4ZNc2ISEToXSXZ
 fBQGezTywHJ+XKdIpB5ohLIQMlDILdkYxEO+sI1lFNqyPO/KqWiyUyICgaLODfilmlDDbMhr9wC
 gPYvCA0
X-Received: by 2002:a17:90b:4b89:b0:380:7688:fbe9 with SMTP id
 98e67ed59e1d1-39580eae6a1mr12922339a91.8.1787170456107; 
 Wed, 19 Aug 2026 13:14:16 -0700 (PDT)
Received: from [192.168.122.51] ([173.164.107.233])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3957fb12145sm3767836a91.4.2026.08.19.13.14.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Aug 2026 13:14:15 -0700 (PDT)
Message-ID: <44833559-f73d-4b8c-acec-a3e86b98c393@linaro.org>
Date: Wed, 19 Aug 2026 13:13:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/11] target/arm: Extract halt-to-exec transition out of
 arm_cpu_exec_halt()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260819145649.23439-1-philmd@oss.qualcomm.com>
 <20260819145649.23439-7-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260819145649.23439-7-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 8/19/26 07:56, Philippe Mathieu-Daudé wrote:
> Refactor the target-specific halt-to-execution transition
> logic (disable WFE/WFI timers, clear the halt_reason flag)
> into a separate arm_cpu_transition_halt_to_exec() function.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>   target/arm/cpu.c | 22 +++++++++++++++-------
>   1 file changed, 15 insertions(+), 7 deletions(-)
> 
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 77aa78f00e2..8e9b584559d 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -870,18 +870,26 @@ static bool arm_cpu_internal_is_big_endian(CPUState *cs)
>   }
>   
>   #ifdef CONFIG_TCG
> +static void arm_cpu_transition_halt_to_exec(CPUState *cs)
> +{
> +    ARMCPU *cpu = ARM_CPU(cs);
> +
> +    assert(cpu_has_work(cs));

In reply to patch 11 you suggest removing this.
I wonder why you added it in the first place.

Anyway,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

> +
> +    /* We're about to come out of WFI/WFE: disable the WFxT timer */
> +    if (cpu->wfxt_timer) {
> +        timer_del(cpu->wfxt_timer);
> +    }
> +    /* clear the halt reason */
> +    cpu->env.halt_reason = NOT_HALTED;
> +}
> +
>   bool arm_cpu_exec_halt(CPUState *cs)
>   {
>       bool leave_halt = cpu_has_work(cs);
>   
>       if (leave_halt) {
> -        /* We're about to come out of WFI/WFE: disable the WFxT timer */
> -        ARMCPU *cpu = ARM_CPU(cs);
> -        if (cpu->wfxt_timer) {
> -            timer_del(cpu->wfxt_timer);
> -        }
> -        /* clear the halt reason */
> -        cpu->env.halt_reason = NOT_HALTED;
> +        arm_cpu_transition_halt_to_exec(cs);
>       }
>       return leave_halt;
>   }


