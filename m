Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 279C4CD4F3C
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2026 18:52:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOK6z-0002wa-TM; Sat, 16 May 2026 14:51:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOK6x-0002wC-VP
 for qemu-devel@nongnu.org; Sat, 16 May 2026 14:51:44 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOK6w-0003Zn-F6
 for qemu-devel@nongnu.org; Sat, 16 May 2026 14:51:43 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2b941cd869cso5530485ad.1
 for <qemu-devel@nongnu.org>; Sat, 16 May 2026 11:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778957500; x=1779562300; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jScxpgt2mJfzt7Y/1I7xEdCIMGAILhtQiL4JXrg/sqc=;
 b=Bp+E/OpCB26gI+y8H7BBLbXUbTC/HkLJZfqnd9NycLYS/kxFqAeJv+HzfjnFHyJCE9
 7lgJHlTNq6P5Zmw82hQUIjxG4Ev0f5SBZPtKmGiZO8H1lE7m71FiF6BUO0yA4mmeCSG2
 Zc4/2balZTTvh7RxtIeySsCLovLQXG/QYOv58ggmTaymzPR60CrFn0ba+2YfGxDZZcDE
 Xgb3qWCrLqXrYGwro63KYOB7C2XByWTDDxLUJs6MupDX/Ux9+XW1hWFI/hEGnu8dRLIQ
 qKfgdFpcPcmOucPn8UNJIYWtUYUjxA4ksuEAp4nCXMrvO+U28LvZ4kdrIJRC7ZKkT0+I
 JnfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778957500; x=1779562300;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jScxpgt2mJfzt7Y/1I7xEdCIMGAILhtQiL4JXrg/sqc=;
 b=AdgPK/1MG0wsJxAg0ljLbSzBYljjunRLpC2RW9/DGXfxNoDlNBEHHG+dGq6ojX8qkQ
 6S56lElWsro2EnjJa9RK0hSAJxeN5eqOsWeLTddp34l8l0tCari57+eDl8rjbYfCsK+S
 1uqmSplQ6u14833+aIJ6Wdlnm3DW47dh6UG87048AjDBbVo9SzKxomUhl6bPCmr/hC14
 xOk3B4v3w9IPhgVxOJWorQjclmYnOOGctadRyYDI9NxojAUv4X6plm8kLPfp1dzeT7zJ
 GVKAHN+KtdhajQhs2ad4zUeOFIBUz3XqkGtiO50OQBDQFtF8Z9NGEg9KB6/h2F+UPK1P
 q3Xw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/Dmq8pvWXp248BshedmT5W8syiV6TIeLNf/ie5LuY8OrMoA4PTgkOvKxwBSSS1YSMPsXhxacElUol9@nongnu.org
X-Gm-Message-State: AOJu0YxK2jsKA8aRedWN19c3/nIQSNmQHO9BM5i+LSSGyUPvzJZZkrGo
 ZeV4xI0m0D4U2wiYqCpYe/3EmdTqxOLquA2LfO7tb64be6duMi6/trHq9eWT38TPHq8=
X-Gm-Gg: Acq92OFwGph9A06n9eTka7O4dmUPxAOnjk7KzkFmixWogTTWIwLKmgMAWZcpvUboQkH
 gnsZdVLn8Hguau6HApCZaHCf/rJ07nYh//3/gUVuTheZA8+DzX6xOkYuVpmjqB1DCD0by93yIqr
 NGnHQwKOEcPt+ajPUXU7DP7dSg7VqOIRuGTwyVbF/e8LA4f//0lGlLwbR43kXsunKGVjKSg3UFu
 +MszdqUS8kimwC7pjTuwsHPoZGj9fPIMie4cqFMot0234JwhCbr8umg8oikymJWJPsnMbScNhvs
 +MvgKDFcU9cVh+LQWC8tCp8L2RpdrajRgCHsEPRhpyzF5Ts3br8nGMMHa8/dMNrvs3kO8Yzch+T
 ooYHox5ngjumO3VmaSi2djWZF/p76uwcx+zvx+rlD3qQdRdOpI1jPT5briDBr/IuI4LvOCI45gU
 RVll/sHdlzQWUx+8hpA0Xo5LdlBt8F4DJYx4Ct
X-Received: by 2002:a17:903:2984:b0:2b4:63bf:5535 with SMTP id
 d9443c01a7336-2bd7e9ea98amr86886665ad.41.1778957500403; 
 Sat, 16 May 2026 11:51:40 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5c05f27csm94541215ad.25.2026.05.16.11.51.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 16 May 2026 11:51:39 -0700 (PDT)
Message-ID: <52828194-de59-4d7f-8047-c3ae53276c51@linaro.org>
Date: Sat, 16 May 2026 11:51:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] target/microblaze: Convert to translate_for_debug
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <20260515125727.349675-1-peter.maydell@linaro.org>
 <20260515125727.349675-2-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260515125727.349675-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

On 5/15/26 05:57, Peter Maydell wrote:
> -hwaddr mb_cpu_get_phys_addr_attrs_debug(CPUState *cs, vaddr addr,
> -                                        MemTxAttrs *attrs)
> +bool mb_cpu_translate_for_debug(CPUState *cs, vaddr addr,
> +                                TranslateForDebugResult *result)
>   {
>       MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
> -    hwaddr paddr = 0;
>       MicroBlazeMMULookup lu;
>       int mmu_idx = cpu_mmu_index(cs, false);
>       unsigned int hit;
>   
> -    /* Caller doesn't initialize */
> -    *attrs = (MemTxAttrs) {};
> -    attrs->secure = mb_cpu_access_is_secure(cpu, MMU_DATA_LOAD);
> +    result->attrs = (MemTxAttrs) {
> +        .secure = mb_cpu_access_is_secure(cpu, MMU_DATA_LOAD),
> +        .debug = 1,
> +    };
> +
> +    result->lg_page_size = TARGET_PAGE_SIZE;

TARGET_PAGE_BITS.

>   
>       if (mmu_idx != MMU_NOMMU_IDX) {
>           hit = mmu_translate(cpu, &lu, addr, 0, 0);
>           if (hit) {
> -            paddr = lu.paddr + addr - lu.vaddr;
> -        } else
> -            paddr = 0; /* ???.  */
> +            result->physaddr = lu.paddr + addr - lu.vaddr;
> +        } else {
> +            result->physaddr = 0; /* ???.  */
> +        }

Surely this is the "return false" case.
Fixing an existing bug, obviously.

>       } else {
> -        paddr = addr;
> +        result->physaddr = addr;
>       }
>   
> -    return paddr;
> +    return true;

Perhaps cleaner to finish with

     *result = (TranslateForDebugResult){
         .physaddr = paddr,
         .lg_page_size = TARGET_PAGE_SIZE,
         .attrs.secure = mb_cpu_access_is_secure(cpu, MMU_DATA_LOAD),
         .attrs.debug = true,
     };
     return true;

?


r~

