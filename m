Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D51FC369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 10:24:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7XGs-0002vr-Bo; Wed, 23 Apr 2025 06:24:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7XGo-0002vV-5m
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 06:23:58 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7XGm-0004Ib-CJ
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 06:23:57 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43cf05f0c3eso46287675e9.0
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 03:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745403833; x=1746008633; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Nl50mRTpPNOc5qeu9DrruLOwy6Pw3Av3kopr9qWIMm8=;
 b=wlunIbgRjm2MiT0SBGdYKh09HtSpRzwVmNdVsLPY3QcQKwp3amfQfbuo7xckSQVPuX
 +GzOJiXmNMt1RKzSy2j8PTv2keoOIpV1tneYThPlB4w3Qm+XrLk/eHZrdtvW3IjjFBgW
 cOZvSl7U+IwbrLMmWNz/yvR3OrTt6tjLlNj5NqgO1FrG8AaRKvl8F4GiMiAKvWMKj99j
 AxEDoKrJOSRhf0VgsnWJYOX+PyBefqeowQ3wo6nPrRHllIIgcF+7kEcQJ0JvV2bK0oZT
 IplD8womzWAMJGRVcjN+bUVpDGyWCIBJw8VYnCB6x+pKp0QXOJZjMhpCGJhLaWCnJsdE
 0n3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745403833; x=1746008633;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Nl50mRTpPNOc5qeu9DrruLOwy6Pw3Av3kopr9qWIMm8=;
 b=f1xTnC9NhsDp4rMWNFOHn4HstyyEGrhJrLn8f+cR62Op5/iDp0leXWdcmKzFsku6JB
 RQUg4rdiSad5PCFillFj+nNnEEtz362qcr6jieY7guB/Qmi2ohNe1GoRXcRnwEsAzPZN
 KJb/a8YaS3Nu/sc0yMMd5yq1YKr463OHiR2SExDBrBq3fFlhiJL9KWhzbFxdJEzU4X3E
 N/5N9QWaFQbBo7L2SAMW6hW+wvHpJdwLQk6S7/nLkWUucudR/loJRNL4N4VsWP2Bral/
 Lq5g8t9w5hNS1inyXIToaTLoES6obzFHM1Lh8COYJ7O3ORSkKTI+LWb1Mp5gCS/HyYPz
 jpWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPnn0pOVmktI1f63h83UUI5UHNTIJgWwT0sxguK7WMe42LODr6GC6aLnFDDjVC+YkzZcbCo08Wrtkv@nongnu.org
X-Gm-Message-State: AOJu0YxHZ/bzQwZMN8GDTUiGrIs/V9WrME0zA6w6RHR9xSyEFoBoRZYa
 LPhPCg6fHIJrW4VSJ8+GFTjLVHsGgjrWQ2cJtjgcu/orzHWlPIo/QIdPRQ8mhkM=
X-Gm-Gg: ASbGncuw90/Ps65ukmzhFTQK7+LJinOyzqQz3J06f7e6B0TZ6L8PVaIe62JiqYnYT8a
 zZlsLDAslsUQ6cwq57br8EakMIsDAy5vXbIP+O9vjhkO6oQRB+IdeZIEJkDUYV5p1S0fKSg0gro
 fMb+CTDHZR3/ZJe1G1FAadVE9zi3skHzOlslrfgAgM/1uPFt7Z9TQpw5bfyU9goObt7/DCSHoKp
 3QHsEYNW9oyIX3ss8uqHzdU6smPfGucWZA1fMlPeldoj5e9uaRxVF05oFDd3EER5T70sI+/o/W1
 E8L4B7GZ3syIz+mrxZ3mqAQn8Vszrnl+ASMlLVTF3DkpSNu/Jv8vDcKSTEblKSH9PNMVuG3gV1L
 GmCEn/jhE
X-Google-Smtp-Source: AGHT+IFCi4JX56J/75UfKmMLl5TvgasNI0psDxm6VQzLV9YtGsGK+gfqw+ouRusyMImJNzjjaW/56g==
X-Received: by 2002:a05:600c:1383:b0:43d:585f:ebf5 with SMTP id
 5b1f17b1804b1-4406ab7a7dfmr160413085e9.1.1745403833215; 
 Wed, 23 Apr 2025 03:23:53 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-44092d16ca2sm21043585e9.8.2025.04.23.03.23.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Apr 2025 03:23:52 -0700 (PDT)
Message-ID: <df8ac9ee-be76-407b-ad36-e66a6280402d@linaro.org>
Date: Wed, 23 Apr 2025 12:23:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 101/147] exec/cpu-all: move cpu_copy to linux-user/qemu.h
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
 <20250422192819.302784-102-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250422192819.302784-102-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 22/4/25 21:27, Richard Henderson wrote:
> From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> Message-ID: <20250325045915.994760-3-pierrick.bouvier@linaro.org>
> ---
>   include/exec/cpu-all.h | 2 --
>   linux-user/qemu.h      | 3 +++
>   2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
> index 5c4379f0d0..2aaaf0548d 100644
> --- a/include/exec/cpu-all.h
> +++ b/include/exec/cpu-all.h
> @@ -31,8 +31,6 @@
>   #endif
>   
>   
> -CPUArchState *cpu_copy(CPUArchState *env);
> -
>   #include "cpu.h"
>   
>   /* Validate correct placement of CPUArchState. */
> diff --git a/linux-user/qemu.h b/linux-user/qemu.h
> index 5f00750151..948de8431a 100644
> --- a/linux-user/qemu.h
> +++ b/linux-user/qemu.h
> @@ -362,4 +362,7 @@ void *lock_user_string(abi_ulong guest_addr);
>   #define unlock_user_struct(host_ptr, guest_addr, copy)		\
>       unlock_user(host_ptr, guest_addr, (copy) ? sizeof(*host_ptr) : 0)
>   
> +/* Clone cpu state */
> +CPUArchState *cpu_copy(CPUArchState *env);
> +
>   #endif /* QEMU_H */

I don't see any OS-specific code in cpu_copy() (and don't expect
to see any). Maybe "user/cpu_loop.h" is a better fit, as it also
declares target_cpu_copy_regs()?


