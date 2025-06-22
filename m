Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2981C71157
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 02:08:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTA84-0003UU-2G; Sat, 21 Jun 2025 22:08:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTA82-0003UI-7k
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 22:08:18 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTA80-0000UR-E6
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 22:08:17 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-3141f9ce4d1so2734617a91.2
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 19:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750558095; x=1751162895; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NquCHWfT9IR3/as6RiPkv5O8FXtfl/i1T4JYK23NSAY=;
 b=WkRPlzrdOgPUWE5Xatk929N/f4IG8dR0zcfLTI1/ZI6P9pgOcHO74WcqT0DWsHLA7m
 pcvH8mjc6Bq7LSiRrH/sZvw/ycjWQTU058C6sG4/EKYVv5IoyTfWDIwd9P7lHYUNJxof
 PHazyl5mC9FBGggX6lfGKItksztoYYlPKXVKHLUtHuj2oHNnQd5vdODLwrViOA1usyLb
 YQs+A8o7fxbPXzlRg6ILRBav6wR638nsBoTMsTRZRMzDOG4R5dT4Ibtc58cMbGRQgPzU
 pccY4keo2S3R8dypjnywmwmVCVODTXwIc6WlMspPBIGCoWiEoFjKbP+MG4GXx+vbkEmH
 xmkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750558095; x=1751162895;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NquCHWfT9IR3/as6RiPkv5O8FXtfl/i1T4JYK23NSAY=;
 b=YT9o2/sXKJJ0KdE45kMhAJaZF1zTWZhLYkWjCILSwh94wMe6B4U4INLUSeWilINPZn
 K2xr9VDfoehOX+yf3o7n4GTpYfvtXMDR63+RIIesFyagjte3br3yT1GUmfeCtVs5BpAj
 66/KgDmEYK3tzTXFhV6fYo8inFSKl8dJDsEoGdAaXnr70qgc+vaUdpwdv78iEQ/4qACo
 j3DoG9I1PX1eT/0+yEgyIRoLQJV2M9X7eBBdHpAh4Vbnylyf1kY3O9Ot5Cw3TSY6GH8s
 nr40XPtez2LqX+tnzCOotsreHq1Jrwd3HFmbEilauVGk8Mg8IquP1Wka17oyfn28EE5D
 Y5UA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWByeUG5WQUUCvDxoR5aB3Rlh+RLKqUxxRU8cFQRZdQUhmdaoXptVbDK7W7hsPjIEOZwi3BnT7BTGWt@nongnu.org
X-Gm-Message-State: AOJu0YxNfKAwVtQhhUs+HwIaC3qBZv+hWh2wPMWv9bgsJbv3tu0X08L5
 ug58WKwmX0cbUjN0K3K5qk/oHfxBxk9dkYYv3yll/F8VJavNoowABP8oScrWXMiHm8o=
X-Gm-Gg: ASbGnctfSkZOP0YL7I+fTCFwhe7li1YNjVkzLkurtuDAA/HzbsD+jBJZOtlWjoBolqf
 S3i5gsnzMgAxDBJcYhRoJ1CZlk0994Cddx8guOS8DGOIICeUySYIYAYOHUXZezyDMqDaMrvaNTg
 FpU3JJOwwb0+BmXj8yIrbQtmGeN3XTTCG1+kxbUzNHGQign0hF8LCkQ1AOItckCR7Kkw7D3iK4p
 yhTDzxISFRVMRfTQWVwaiQZQI+RNR47huWDecqNfJ8IKoUHbBBX89f9+I7xVdoAi7RO9OKDz5VS
 5OWUv1FEiKZOEPmqrcF0moSWtxKCEzB0St992LC1LHnj3VlnYhSYllcAJwnsPwMIny68Q3dacpZ
 YSKWSul6zqdqfWwLrOYc9lwPGgOnO
X-Google-Smtp-Source: AGHT+IG6d1m6BLg17G5q1qTNApqlqYfWxEEA6qtkueeUaDHo9hW/cJHfHdrL5+j9mWljmoBe0UF4fA==
X-Received: by 2002:a17:90b:5105:b0:311:a314:c2ca with SMTP id
 98e67ed59e1d1-3159d620720mr10905255a91.6.1750558094929; 
 Sat, 21 Jun 2025 19:08:14 -0700 (PDT)
Received: from [192.168.0.4] (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3159df71c24sm4781117a91.3.2025.06.21.19.08.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Jun 2025 19:08:14 -0700 (PDT)
Message-ID: <d776cb6a-5706-4570-8396-902995331058@linaro.org>
Date: Sat, 21 Jun 2025 19:08:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 39/48] accel/system: Introduce hwaccel_enabled()
 helper
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250620171342.92678-1-philmd@linaro.org>
 <20250620171342.92678-40-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250620171342.92678-40-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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

On 6/20/25 10:13, Philippe Mathieu-Daudé wrote:
> hwaccel_enabled() return whether any hardware accelerator
> is available.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/system/hw_accel.h | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)
> 
> diff --git a/include/system/hw_accel.h b/include/system/hw_accel.h
> index 574c9738408..49556b026e0 100644
> --- a/include/system/hw_accel.h
> +++ b/include/system/hw_accel.h
> @@ -28,7 +28,28 @@
>   void cpu_synchronize_state(CPUState *cpu);
>   void cpu_synchronize_pre_loadvm(CPUState *cpu);
>   
> +/**
> + * cpu_synchronize_post_reset:
> + * cpu_synchronize_post_init:
> + * @cpu: The vCPU to synchronize.
> + *
> + * Request to synchronize QEMU vCPU registers to the hardware accelerator
> + * (QEMU is the reference).
> + */
>   void cpu_synchronize_post_reset(CPUState *cpu);
>   void cpu_synchronize_post_init(CPUState *cpu);

This belongs to a previous patch.


>   
> +/**
> + * hwaccel_enabled:
> + *
> + * Returns: %true if a hardware accelerator is enabled, %false otherwise.
> + */
> +static inline bool hwaccel_enabled(void)
> +{
> +    return hvf_enabled()
> +        || kvm_enabled()
> +        || nvmm_enabled()
> +        || whpx_enabled();
> +}
> +
>   #endif /* QEMU_HW_ACCEL_H */

But the rest is ok.
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

