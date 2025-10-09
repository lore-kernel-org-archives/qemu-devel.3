Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FC3DCCD184
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 14:14:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6rPL-0000vs-Gr; Thu, 09 Oct 2025 10:14:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6rPG-0000vY-Vs
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 10:14:12 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6rPE-0000I0-1w
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 10:14:10 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3f0134ccc0cso738640f8f.1
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 07:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760019245; x=1760624045; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uiAndZ5h0BaxToWyVH30SManz3spE/lV8OAscQ62MwU=;
 b=pM26Ng8POKgTJzZYJGD+N97pk1gAMF45kaeDfRYVecM5lqCy5zNCXLfxq/XVOq/GmF
 w9NBX85JvrAjMCo3RysgZvnBPuRNH2Q7yXSJMdChWrp9vwuPBowXEpAVjijYmtUJHwTu
 DSmdvWBMwniD5Pc6rmOB6JJf6D9uNlxUMkQXAnQGNwKa9j8QHfADx+RV4Epu2e5QDYBv
 t8ddy5Fl2XYTZovmqfTNsuWhebVkbe/n4Pi4MNYtIrh//CyBn7t5M3Uoe9PGtXSTLFk8
 5on6TJzj6HpTlrvT6RZUk+TUaLqA7ju2cuJo+SMOhqUPebAsf+r+pd5iNlvPS4FiRAkT
 VmpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760019245; x=1760624045;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uiAndZ5h0BaxToWyVH30SManz3spE/lV8OAscQ62MwU=;
 b=bo+oClMSIvSw13ROsYJIp4AVLp5evWyknxrQR6jrPHsV0ojNlkgMwjVARayl/7AFRY
 sYxXV1XnP6h++zox2fdU0K+fqLFL/9IXVijlp4iqRTEp8ycjaKNGZtj+bUq0gsB9Fu6l
 ydNeU4HE9W3or5Cd30cdUIY2q6Yen+tS4iRFn2CH5DLoX2WILL+4nbIwCTbebxI587Ze
 mDx5HLPQGimTxNa/yuhpgx7X9jzdhxxzw57A94Jce93Np/AOmqmjfIg5qeNv8W3gERfl
 XZkVa266kDcOMuQcWlFqLgcc2FnZaWnBG5d4GZyW/L4S54zmVcxucl9Fwu65gJLnO/QK
 xkyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8LYUsHFi3+HMEWFvpbbRWZmBBpDR14XEwhurbSdmdGJ6/GJqywJzTHpK05gRAFLP5jrcuDH83ZSRz@nongnu.org
X-Gm-Message-State: AOJu0Yzi36ZJ5auDytC5AQnwaCBKohh2g/8s7Y9lmAZ2mJdXF+jQhs/1
 XxulxXlHWCjuhSRkxO3RNusxqe9owrffHJrgWqONq/OxRvuIuYP0rKjhUzmlfyB5l4k=
X-Gm-Gg: ASbGncvQ09sdSH0ustK3K4gNiRuSLTAQVKD4abM4+rXDHUcvfUzcnFVgoHcJhfywADN
 A6XdRPmmjQ+WntwqxnX7mYEyKVaARqbAA5OGDQCH9eLbaESRasGTcvWNz/lh99+9LT2TzHiBk4o
 RaALEtcJgFh1n+YLzpAu1y4rXt6Ba69z/y1ES7GpIAiBCpSWTX+B+yiPwVx0FefjqFAf8qdtCbj
 9h3kUa90X8EctpzO23fXW7pR72YckDEfhHD4OWfw06tPd0JgD1XUq6trQFFI0i3fVuur6xFdGFH
 rmd6fNtyhWEVvBx7ZHYkAkDsKurOPQ68nOx5nu/O4nvGopSGYeG45vFeCvyBl/YpY4YuX08/zAM
 J8sgrJRwt37lNxPnMAV0/JRJUOatAuygLC2rRfK6azlgG9FDY7gyYA6CK7VJPPx6ZhVlUZJF35U
 D2tOReHcA6f4LmI23AZQ==
X-Google-Smtp-Source: AGHT+IEuU0dS0L7Mv2XaUwAIWSJUOcqWpt0XoE/5r8vYD+YU39tRz1oJMgwakSqcdtuMG9ZKFeO+RQ==
X-Received: by 2002:a05:6000:4028:b0:425:825d:25d5 with SMTP id
 ffacd0b85a97d-4266e8de0demr5090789f8f.45.1760019244686; 
 Thu, 09 Oct 2025 07:14:04 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8f0853sm35589606f8f.50.2025.10.09.07.14.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Oct 2025 07:14:04 -0700 (PDT)
Message-ID: <e16277df-c8e1-41ea-8a59-da2ae11dafe1@linaro.org>
Date: Thu, 9 Oct 2025 16:14:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 10/73] target/arm: Expand
 CPUARMState.exception.syndrome to 64 bits
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20251008215613.300150-1-richard.henderson@linaro.org>
 <20251008215613.300150-11-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251008215613.300150-11-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

Hi,

On 8/10/25 23:55, Richard Henderson wrote:
> This will be used for storing the ISS2 portion of the
> ESR_ELx registers in aarch64 state.  Re-order the fsr
> member to eliminate two structure holes.
> 
> Drop the comment about "if we implement EL2" since we
> have already done so.
> 
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/cpu.h     |  7 ++-----
>   target/arm/helper.c  |  2 +-
>   target/arm/machine.c | 32 +++++++++++++++++++++++++++++++-
>   3 files changed, 34 insertions(+), 7 deletions(-)
> 
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index c9ea160d03..04b57f1dc5 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -633,13 +633,10 @@ typedef struct CPUArchState {
>        * entry process.
>        */
>       struct {
> -        uint32_t syndrome; /* AArch64 format syndrome register */
> -        uint32_t fsr; /* AArch32 format fault status register info */
> +        uint64_t syndrome; /* AArch64 format syndrome register */
>           uint64_t vaddress; /* virtual addr associated with exception, if any */
> +        uint32_t fsr; /* AArch32 format fault status register info */
>           uint32_t target_el; /* EL the exception should be targeted for */
> -        /* If we implement EL2 we will also need to store information
> -         * about the intermediate physical address for stage 2 faults.
> -         */
>       } exception;


> diff --git a/target/arm/machine.c b/target/arm/machine.c
> index 6666a0c50c..ce20b46f50 100644
> --- a/target/arm/machine.c
> +++ b/target/arm/machine.c
> @@ -848,6 +848,23 @@ static const VMStateInfo vmstate_powered_off = {
>       .put = put_power,
>   };
>   
> +static bool syndrome64_needed(void *opaque)
> +{
> +    ARMCPU *cpu = opaque;
> +    return cpu->env.exception.syndrome > UINT32_MAX;

Hmm...

> +}
> +
> +static const VMStateDescription vmstate_syndrome64 = {
> +    .name = "cpu/syndrome64",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = syndrome64_needed,

Why not simply add a new description for the high bits and
always migrate?

        .info = &vmstate_info_uint32,
        .offset = offsetofhigh32(ARMCPU, env.exception.syndrome),

> +    .fields = (const VMStateField[]) {
> +        VMSTATE_UINT64(env.exception.syndrome, ARMCPU),
> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
>   static int cpu_pre_save(void *opaque)
>   {
>       ARMCPU *cpu = opaque;
> @@ -1065,7 +1082,19 @@ const VMStateDescription vmstate_arm_cpu = {
>           VMSTATE_UINT64(env.exclusive_val, ARMCPU),
>           VMSTATE_UINT64(env.exclusive_high, ARMCPU),
>           VMSTATE_UNUSED(sizeof(uint64_t)),
> -        VMSTATE_UINT32(env.exception.syndrome, ARMCPU),
> +        /*
> +         * If any bits are set in the upper 32 bits of syndrome,
> +         * then the cpu/syndrome64 subsection will override this
> +         * with the full 64 bit state.
> +         */
> +        {
> +            .name = "env.exception.syndrome",
> +            .version_id = 0,
> +            .size = sizeof(uint32_t),
> +            .info = &vmstate_info_uint32,
> +            .flags = VMS_SINGLE,
> +            .offset = offsetoflow32(ARMCPU, env.exception.syndrome),
> +        },
>           VMSTATE_UINT32(env.exception.fsr, ARMCPU),
>           VMSTATE_UINT64(env.exception.vaddress, ARMCPU),
>           VMSTATE_TIMER_PTR(gt_timer[GTIMER_PHYS], ARMCPU),
> @@ -1098,6 +1127,7 @@ const VMStateDescription vmstate_arm_cpu = {
>           &vmstate_serror,
>           &vmstate_irq_line_state,
>           &vmstate_wfxt_timer,
> +        &vmstate_syndrome64,
>           NULL
>       }
>   };

