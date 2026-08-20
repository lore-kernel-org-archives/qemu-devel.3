Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0687C5DF87
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 23:16:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxBz8-0003YS-Bn; Thu, 20 Aug 2026 19:15:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wxBz6-0003Xe-Dx
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 19:15:44 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wxBz3-0007VN-HY
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 19:15:44 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-84f3ab8750cso281687b3a.0
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 16:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787267739; x=1787872539; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=lUw/tl68lr0AGsM4Oc3dKTj4tWdEtIV3qnHlengnk2o=;
 b=XKgS/hXsu9hRLXF06zgJAskDUlJCLjFtk7zsIUkM14Q2UbQ+KmcndFVAgCfrE9wQiO
 8Oi/RLLTL0JjtIFXfOMFdhdSh8Ktqv5G42OhsHLPY7/HftptJXiQjtRCw42VoTzs6Wb9
 4lPgfVKcPDWXC2QB2MNpplGiobkSA8HlNfPuz14xSzJGeewaa6tFYCvGS57SPNnU4ruw
 tXOleZ9sZcwPvUKxLooILowtHek+eX/EHIf+aQomfblFoWxp33/0okt0uMlXoRvAS3hx
 eqOzm+kB2KFXsTfAMVb5cuKH7rDyEIgtnIGzCnnJ9VzC8WsV//NEhIowPOEoy20A8yBK
 yTaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787267739; x=1787872539;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lUw/tl68lr0AGsM4Oc3dKTj4tWdEtIV3qnHlengnk2o=;
 b=FDSM4QKAEl2DIAjG9mFZXxWf1gqSsDiTOCS+eya6pC6vnq+u210qNHOir9ly6aVbOc
 Q5coRolR3JVyTI/T8Q58bsDX4/4jva3SEPhXhHZHKdPncynI2B4ApX4Oe9q+hLYxHI3d
 BZ22e/OHa8Up5pB/K0I7A7uCWHlO/U2gNHtxHVOIuIlotjuklyCZzXW0OEaB97CC1MRK
 9spT4dj+bWxc2Zb2k1TQCJ8TTP2NvekVAuD520Ycjm8FBVntTuCCMY2M3REWM2ttIbr7
 1hT/UXmJF+q0QPgl1y8hCo3YepHV9O8lNfzbCtFXE0NjBkfo+GqucgXaKaZ4tnJ60G1A
 uVeQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr33Yg+9kAqBjYzBR0StZUmZLFdWyGKzY+9fEp62jJU+xFV8Myp+ysZ2VH8jUnwq3gaUhNXmOkq8cEX@nongnu.org
X-Gm-Message-State: AFuF++nJmOMMWLVksABlreYuExlAWg/zITKxWVdkUHrqhXm1xBMQZWxu
 mqm+AHNzkXxiWrECzMd5iH84RWIhsJrAAz1L9o8lyunCinmLYBhp51MKd1db/KY2kIg=
X-Gm-Gg: AR+sD13M9B8fXBMAvRnV30Kwacqx9vmM02Z78xDW1491ALriaGAOTn8WtdtrTE6WS/s
 z49bkp7zBdJxXIWl4oBwl8VgJuWOyPHf10zQY7KNuaGIYAglufkmzO4Q7FToD44dgBpOblVMcIN
 C2FjwHLBawA04WdBz8ea14elZBf61CeFicbSMRLm9NPn8ewddusY7ezCnNenGD7m7ms8LyeIjMn
 kz5pZy24yAnSLkn3GldUPAOxiFLVOwXVUvqHIUKYVQ8gmdxEyvhVQbL/sicbg9Dlq1VAzYpvOoj
 DxkvUy/6kRLJ7vkqV9itXiqjM9cEW446SmBgCuQl0IQQsjO4J35BQUHf+ZYf410TAhOTYXFIZlc
 bL1i4V0CRype6zvdlNtf9W5xFWAo58JoAFCDdvD1FtrEWFU0EaGN9/6T9c+MsUACoghXdE6zK1/
 AbkpZT4ab5ZBoRPm+rPkf2SlJ1zlWObXls7J7ph0Lb2nEqqLyI+3fl740t4s2WSLYyfk72JmPfU
 wWM
X-Received: by 2002:a05:6a00:2ea1:b0:84c:5b65:ef86 with SMTP id
 d2e1a72fcca58-851fa060bf6mr2280857b3a.17.1787267739475; 
 Thu, 20 Aug 2026 16:15:39 -0700 (PDT)
Received: from [172.20.6.151] ([108.174.179.84])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-851d365378esm2107761b3a.45.2026.08.20.16.15.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2026 16:15:38 -0700 (PDT)
Message-ID: <89f4bf70-7ac9-4356-85e9-114d252c19b6@linaro.org>
Date: Thu, 20 Aug 2026 16:15:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 09/13] cpus: Add const-qualified CPU environment
 accessors
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Zhao Liu <zhao1.liu@intel.com>
References: <20260820104730.25462-1-philmd@oss.qualcomm.com>
 <20260820104730.25462-10-philmd@oss.qualcomm.com>
 <0b70e3cc-e14f-4737-b265-c7d12898169a@linaro.org>
 <854739cc-1275-4324-aaea-576f0a504172@oss.qualcomm.com>
 <fb2425af-9f89-4413-a31e-1f22fd42d869@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <fb2425af-9f89-4413-a31e-1f22fd42d869@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

On 8/20/26 09:50, Philippe Mathieu-Daudé wrote:
> Actually simpler and even well readable:
> 
> -- >8 --
> diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
> index 6594f7fa1b..d67d008236 100644
> --- a/include/exec/cpu-common.h
> +++ b/include/exec/cpu-common.h
> @@ -85,21 +85,11 @@ static inline bool cpu_loop_exit_requested(const CPUState *cpu)
>    *
>    * Return the ArchCPU associated with the environment.
>    */
> -static inline ArchCPU *env_archcpu(CPUArchState *env)
> -{
> -    return (void *)env - sizeof(CPUState);
> -}
> -
> -/**
> - * env_cpu_const(env)
> - * @env: The architecture environment
> - *
> - * Return the CPUState associated with the environment.
> - */
> -static inline const CPUState *env_cpu_const(const CPUArchState *env)
> -{
> -    return (void *)env - sizeof(CPUState);
> -}
> +#define env_archcpu(env) _Generic(*(env), \
> +            CPUArchState: \
> +                (ArchCPU *)((void *)env - sizeof(CPUState)), \
> +            const CPUArchState: \
> +                (const ArchCPU *)((const void *)env - sizeof(CPUState)))
> 
>   /**
>    * env_cpu(env)
> @@ -107,9 +97,10 @@ static inline const CPUState *env_cpu_const(const CPUArchState *env)
>    *
>    * Return the CPUState associated with the environment.
>    */
> -static inline CPUState *env_cpu(CPUArchState *env)
> -{
> -    return (CPUState *)env_cpu_const(env);
> -}
> +#define env_cpu(env) _Generic(*(env), \
> +            CPUArchState: \
> +                (CPUState *)((void *)env - sizeof(CPUState)), \
> +            const CPUArchState: \
> +                (const CPUState *)((const void *)env - sizeof(CPUState)))
> 
>   #endif /* CPU_COMMON_H */
> ---

Exactly what I had in mind, thanks.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

