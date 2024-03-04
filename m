Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDE85C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 16:54:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhBZO-0004b7-7S; Mon, 04 Mar 2024 11:53:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rhBZK-0004as-Ul
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 11:53:39 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rhBZJ-0000Qf-Cl
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 11:53:38 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1dcce5e84bcso37637185ad.1
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 08:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709571215; x=1710176015; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YXIrWZwouHSttlPE/11Vh5ARQLJuQaURZm9KbUFry4g=;
 b=nBvwg21r0PGRphngpr7yjfV3/L+Pn+lzyzequf83j89SlBCezjMTj8zzf9q1zFv8at
 ytWnLENVdoAIGmL0m2Mlo0bosLH35O612dCvvQHPbWJe8wHBmkJN3XDQAMjPZVsHaaCZ
 eZGAVgetHIVIefJsabOEhej0z5D3fnVFA4U5Bc/uNsGV9zFKjFv6BE3rUeJ150+3hIZx
 bUMquE3v+LmTiueoLaTpYWWuzE3Z84E8wjywIvVOnYV8dWMXoxK9SLZgmcfmSKRhk+xQ
 SwijzTlmdu9vzxwqD2F8kkqqNXXlHyJq+4brpC1PLzwh7o6C8kHobT4N+/s3vXPin5pp
 aoWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709571215; x=1710176015;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YXIrWZwouHSttlPE/11Vh5ARQLJuQaURZm9KbUFry4g=;
 b=ncn/UWXMIr7nEq02nyJghA/Vz0g7JZbYYv+UStykhDzEHAVeuYQAR6JYNR33VcoZlx
 25JaSJN2c3nw43cA5ng3js8tfIIhhxAUJfIRE2m3V+Hq84cVOb9L/B1XCKeVpi3emjrP
 GK/21xibkdKi7y13dOdSMWkFL2UW/cMIneAlybTufFCcXtRmuQ2Bee3NPmwe0UTHg9+z
 8MZjUAGZK6CGHC/w5wUjL2m4zvECAgaFp9CatDhLuyVGsm58+M+l7CuMNio8j5wqr3oL
 V4QaIcUDO15u0NW9Vk3eBxSfZo8+dVSdt2hkSnbyGOhLAiL4re/T9tEsI0/WUuiEHZ5I
 WbWQ==
X-Gm-Message-State: AOJu0YzMHEYJ/HpTJReii2YQ7+4sjBT26VRkFmZxQZO8rrN9RsUd0D5x
 9DE9fIVdKIbSizFBU4J65rNRR9xPw+O+6GduRmajHZ1g0Zh1m1mN/bMq94pdQso=
X-Google-Smtp-Source: AGHT+IH4VYt8fa6daw2vrqAibOQ6w1vBA4zi/nqct/63R17Bj7gpboCyqBv6aPZK7bLpTlUUWG4U1g==
X-Received: by 2002:a17:902:ec8a:b0:1dd:151b:fa9e with SMTP id
 x10-20020a170902ec8a00b001dd151bfa9emr2893749plg.63.1709571215437; 
 Mon, 04 Mar 2024 08:53:35 -0800 (PST)
Received: from [192.168.6.128] (098-147-055-211.res.spectrum.com.
 [98.147.55.211]) by smtp.gmail.com with ESMTPSA id
 w16-20020a1709026f1000b001dc90b62393sm8908581plk.216.2024.03.04.08.53.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Mar 2024 08:53:35 -0800 (PST)
Message-ID: <a6fa3bf6-2e5f-4068-82ec-44720e4be34a@linaro.org>
Date: Mon, 4 Mar 2024 06:53:31 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] target/loongarch: Add TCG macro in structure
 CPUArchState
Content-Language: en-US
To: Bibo Mao <maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org
References: <20240304021844.1449164-1-maobibo@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240304021844.1449164-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 3/3/24 16:18, Bibo Mao wrote:
> @@ -696,11 +700,15 @@ void loongarch_cpu_dump_state(CPUState *cs, FILE *f, int flags)
>   {
>       LoongArchCPU *cpu = LOONGARCH_CPU(cs);
>       CPULoongArchState *env = &cpu->env;
> -    int i;
> +    int i, fp_status;
>   
> +#ifdef CONFIG_TCG
> +    fp_status = get_float_exception_flags(&env->fp_status);
> +#else
> +    fp_status = 0;
> +#endif
>       qemu_fprintf(f, " PC=%016" PRIx64 " ", env->pc);
> -    qemu_fprintf(f, " FCSR0 0x%08x  fp_status 0x%02x\n", env->fcsr0,
> -                 get_float_exception_flags(&env->fp_status));
> +    qemu_fprintf(f, " FCSR0 0x%08x  fp_status 0x%02x\n", env->fcsr0, fp_status);

fp_status, I think, is unnecessary to print all of the time.

In update_fcsr0_mask, we ensure that fcsr0 is updated and fp_status.exception_flags is 0. 
So I would expect this field to be 0 all of the time -- anything else is a bug.

> +#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
> +static bool tlb_needed(void *opaque)
> +{
> +    if (kvm_enabled()) {
> +        return false;
> +    }
> +
> +    return true;
> +}

Better as return tcg_enabled();


r~

