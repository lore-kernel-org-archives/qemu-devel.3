Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88E2EC0219D
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 12:59:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiYoO-0007jG-Fv; Thu, 13 Feb 2025 07:59:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiYoN-0007j8-D1
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 07:59:23 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiYoL-0008P5-RO
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 07:59:23 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4395578be70so8829905e9.2
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2025 04:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739451560; x=1740056360; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qZGHM3MVJGEWuNecPZ98UcURwNCkVLdMYzLmnVB/P5w=;
 b=fVQ8i1lXfbxEVby7kYrtdouPC0EO1aQPrJPi6At1yMh2hJq2M7tmnP5+WuJDtCye9q
 nGp4RCdywtY3RVVEvD4i6YAxEyunMPgsE3BeDTsFb/rE/GmYu1dX8fWUW95OIrJU8FVQ
 iWzkMPqoGXR0jNGTaAokozvlhmjxnXlRguuCPSfTwOqo9r9TfdQLfjH5p2CmzmOIK/fe
 2fprk06ZSWJZ6HOB7FjPVDt8NCbssgFtOZD9RE+iwUSrpa5Xt+0lbWH6T7aMB7CclIJL
 CGCSKtIj/3HtGtXVzFbei7EbUMF18Zt1Ud2s4RG7aFxkTjJ2S4ezR2OPoAhAz+CtA5M6
 2cYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739451560; x=1740056360;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qZGHM3MVJGEWuNecPZ98UcURwNCkVLdMYzLmnVB/P5w=;
 b=hKsvl7rR/43Owiv82/VwD7HZ5z9mZsCH4zzbBspRKI5MhHBSIX/7gfR1ACv+avYawk
 rQ/M6dDtkE3lLf9e2q8rESbV5+RwGYaZ1moI9A4Vkasla587/LIBbAfy3cDzSvM8CKf8
 Ahc4BZlbz48t11fjuxlz3B0+LRyuZAg/vYn8YqMrQgPhOrh4ZWxAP9EfSTYUH+z1Y9TM
 84IQOYSaBEfMmPWxtMmx9hsFZkR1hPuHzn5CY7Ok7U1BhP2PTI4PbyCDrteQSCilug1W
 HVU9aFoo/yf3/9Pbmf2dknsROq1IsyiWLlMqMikWGFu34ALGHIW7YhSlCF/A9cntrYrq
 XTOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSysfAPqlTtjlgj8pfdjuE3uVVVxdiuN2sw1s0IO2LV8O4I9LMYatiZY6Nrvp9khz8Dh2/WDOzZFrM@nongnu.org
X-Gm-Message-State: AOJu0Yy59f2fP7DNUBL14yBqNLxgHLhcP5+hNmFamPlQLlzpMGWnCRSV
 j37HQDiDyGCQ3PqwqbUoT7bFwb29gNeQ3oAi0zrSzugBJuyRJDTKP3y14o0Y2LXcuXcamZfd/+a
 46kw=
X-Gm-Gg: ASbGncvCWd13Fzzf7cGiX8SSC6xde87m5aI+vPLwOi+275BMe7rZKQboPGowMDHKebX
 FdwNjMpiaP+Wcz/R+at+ppF6yqCjRXxpzZofWSSLCVWeVgFaXyYXfj+apIEfJyx8hE3RbyYUIIe
 +nT5PYQ4i/Jad1sPo8xS21n26Snrqen4v7PULt0rS3sy/VmsvuU3tDxgMoJpNI6DlqcRNLC9ghO
 HPKxzMJxdOVbZ0P5JA+1M5H/aSFYzdk40Zb9rAIcENQaDTSsDs2h02rbZzCXtPY3H7Ohs/YTuW/
 WK2qLY+Vtz4mOInWsA+125EpaoSMXD8hbMxrOTP10Cx3k+Q=
X-Google-Smtp-Source: AGHT+IFgoXvIWyD4NN/Wg8A2KJtJ528UinTn9oP0tiBgE1qaiQGw73jycZDrt4XHpoJ2xYvMmzXLkw==
X-Received: by 2002:a05:600c:5487:b0:438:a240:c63 with SMTP id
 5b1f17b1804b1-43958157c4bmr72095505e9.2.1739451560201; 
 Thu, 13 Feb 2025 04:59:20 -0800 (PST)
Received: from [10.223.46.213] (6.170.88.92.rev.sfr.net. [92.88.170.6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258dcc45sm1848611f8f.33.2025.02.13.04.59.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Feb 2025 04:59:19 -0800 (PST)
Message-ID: <46ffafd4-111c-4583-9039-da61d6a9cd80@linaro.org>
Date: Thu, 13 Feb 2025 13:59:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] target/microblaze: Split out
 mb_transaction_failed_internal
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: edgar.iglesias@gmail.com
References: <20250212220155.1147144-1-richard.henderson@linaro.org>
 <20250212220155.1147144-3-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250212220155.1147144-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 12/2/25 23:01, Richard Henderson wrote:
> Use an explicit 64-bit type for the address to store in EAR.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/microblaze/op_helper.c | 70 +++++++++++++++++++++--------------
>   1 file changed, 42 insertions(+), 28 deletions(-)


> +static void mb_transaction_failed_internal(CPUState *cs, hwaddr physaddr,
> +                                           uint64_t addr, unsigned size,
> +                                           MMUAccessType access_type,
> +                                           uintptr_t retaddr)
> +{
> +    CPUMBState *env = cpu_env(cs);
> +    MicroBlazeCPU *cpu = env_archcpu(env);
> +    const char *access_name = "INVALID";
> +    bool take = env->msr & MSR_EE;
> +    uint32_t esr = ESR_EC_DATA_BUS;
> +
> +    switch (access_type) {
> +    case MMU_INST_FETCH:
> +        access_name = "INST_FETCH";
> +        esr = ESR_EC_INSN_BUS;
> +        take &= cpu->cfg.iopb_bus_exception;
> +        break;
> +    case MMU_DATA_LOAD:
> +        access_name = "DATA_LOAD";
> +        take &= cpu->cfg.dopb_bus_exception;
> +        break;
> +    case MMU_DATA_STORE:
> +        access_name = "DATA_STORE";
> +        take &= cpu->cfg.dopb_bus_exception;
> +        break;
> +    }
> +
> +    qemu_log_mask(CPU_LOG_INT, "Transaction failed: addr 0x%" PRIx64
> +                  "physaddr 0x" HWADDR_FMT_plx " size %d access-type %s (%s)\n",
> +                  addr, physaddr, size, access_name,
> +                  take ? "TAKEN" : "DROPPED");

Helpful.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> +
> +    if (take) {
> +        env->esr = esr;
> +        env->ear = addr;
> +        cs->exception_index = EXCP_HW_EXCP;
> +        cpu_loop_exit_restore(cs, retaddr);
> +    }
> +}


