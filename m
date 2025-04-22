Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64293C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 07:19:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u77tw-0006vd-8E; Tue, 22 Apr 2025 03:18:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u77tu-0006rw-K8
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 03:18:38 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u77ts-0003JK-3N
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 03:18:38 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3914aba1ce4so3122328f8f.2
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 00:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745306312; x=1745911112; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JuhzA3ztdNwB/VjgDRci3zkAprZzi2gFFN7mG/c3z00=;
 b=meKRl6kroNHfSL1alDCf9LX6gqra9adPGHdEC/TBogbF3BgApq1mx+eBEVgpBUaC9Y
 W86ZNNC0UkcOwveq10EHKFmbhM0+ZF4ll0H1/JEp+JwHtMYgC7H2x/xH3yy663YNQUAl
 vEFym16KmKSsezTTg92izWQp4mpJlXYA3l7pj9p4fR8hZuZ+4h3OTB0FVpB6cvPnc8Dn
 E0j75jbwFGfrrSFBBHqfy2bN5r3DWvsJ5X+30ZQ9ZCIGYwCp0WI2gjtEYh7OhY+MDOdt
 8CGAMDfuEXHkFzmqCmbxzs4Jrjn4gnZiz4sK+Ryo509NM4VMfR5GsFBwEPH0HqjJ0BDI
 I0Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745306312; x=1745911112;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JuhzA3ztdNwB/VjgDRci3zkAprZzi2gFFN7mG/c3z00=;
 b=ZnAhhc3guqMpY3lvilcvWoJ/fIU+uOfcgPsK6fZRnWmTLPGmmz5zorywmKh8pS5L+I
 49acfz4Lkd8g74m3uU5y0tEYFzl8Bd5frvzwH2o4dE1KekHQxSkdxzQLM5ta9rHgQAQG
 hfxqTV8XcnCy1ijiqMZGI85zQpyMlYA1jbKqypZYFIBRY9eL5O/jp+0FvtgJNusKJT6H
 kU19NKX061jyXwnsDVZMm8tXF8EJudpT8INFAxoYSz2RzJaGsnfGvUJwCqjeXkHXBWGI
 x9FvaL0tPwwkYNbLNBmcZHjmwIuOk4u3XXg4sySVchZ44pkdToXjKQ/tpueLaN0xW74d
 j8qA==
X-Gm-Message-State: AOJu0YyBr3Q2vCsWE7xTCgMZ2xaBXbOLqPR8AkEJM7QytFJNr1ntaBzI
 v2DuXEJmK0KaEG7L0+gtIBdQY6JyRPx+D+VMgqz0VaclNS2c9E5qQA0PZend63A=
X-Gm-Gg: ASbGncu6bbMrvxK2mPTlV1gaMsW9ZOF5+SKKBfngZ92yLfTo5feVL3AGfNpTANJdlLP
 QiGdyU5xsiRBIdNHo4YYqtguBxsDDM3763Vani8sDP5XYcr4FIIyXgGZSqVc0h8qdpYdz0bCG3/
 spLPCfArjOV0szg0OJkgx54i1ImVLXo33pf6AiUeWVORTBFIFwZAOKxki2A+RdO2Ndmi0tgr0R8
 6k72uhe4X5bcZZjvqFb98IlzB0LnDDecby875GkKcCk6O86uiVSVH+vspSLLyTmbgLWA8zkDSYq
 9LN+MsE/6bmWDrwm64se+is8Us6O0qFMrSKlluZL1ChZjF/+03PRjPVLTGyfK2v10irDtkxJE04
 YKGfV4ZR+oXzfddm/c+w=
X-Google-Smtp-Source: AGHT+IEspqcrWal3soYLJiEH4MloyyVfOrmYHQVBJHh+eT+exj3OCJZVFerIzKrVs3bIM1l0+Wqb8w==
X-Received: by 2002:a05:6000:2287:b0:391:466f:314e with SMTP id
 ffacd0b85a97d-39efba461c4mr11351055f8f.16.1745306312323; 
 Tue, 22 Apr 2025 00:18:32 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa493105sm14229535f8f.76.2025.04.22.00.18.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Apr 2025 00:18:31 -0700 (PDT)
Message-ID: <e86b1efe-514c-4757-9a7d-477c27803c95@linaro.org>
Date: Tue, 22 Apr 2025 09:18:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/9] target/loongarch: Define function
 loongarch_get_addr_from_tlb() non-static
To: Bibo Mao <maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20250422025742.2693096-1-maobibo@loongson.cn>
 <20250422025742.2693096-7-maobibo@loongson.cn>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250422025742.2693096-7-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

On 22/4/25 04:57, Bibo Mao wrote:
> Define function loongarch_get_addr_from_tlb() non-static, and add its
> definition in header file tcg/tcg_loongarch.h
> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   target/loongarch/cpu_helper.c        | 10 ++--------
>   target/loongarch/tcg/tcg_loongarch.h | 16 ++++++++++++++++
>   2 files changed, 18 insertions(+), 8 deletions(-)
> 
> diff --git a/target/loongarch/cpu_helper.c b/target/loongarch/cpu_helper.c
> index 5db64a45cc..7636b2c265 100644
> --- a/target/loongarch/cpu_helper.c
> +++ b/target/loongarch/cpu_helper.c
> @@ -11,6 +11,7 @@
>   #include "cpu.h"
>   #include "internals.h"
>   #include "cpu-csr.h"
> +#include "tcg/tcg_loongarch.h"
>   
>   #ifdef CONFIG_TCG
>   static int loongarch_map_tlb_entry(CPULoongArchState *env, hwaddr *physical,
> @@ -142,7 +143,7 @@ bool loongarch_tlb_search(CPULoongArchState *env, target_ulong vaddr,
>       return false;
>   }
>   
> -static int loongarch_get_addr_from_tlb(CPULoongArchState *env, hwaddr *physical,
> +int loongarch_get_addr_from_tlb(CPULoongArchState *env, hwaddr *physical,
>                                          int *prot, target_ulong address,
>                                          MMUAccessType access_type, int mmu_idx)
>   {
> @@ -156,13 +157,6 @@ static int loongarch_get_addr_from_tlb(CPULoongArchState *env, hwaddr *physical,
>   
>       return TLBRET_NOMATCH;
>   }
> -#else
> -static int loongarch_get_addr_from_tlb(CPULoongArchState *env, hwaddr *physical,
> -                                       int *prot, target_ulong address,
> -                                       MMUAccessType access_type, int mmu_idx)
> -{
> -    return TLBRET_NOMATCH;
> -}
>   #endif
>   
>   void get_dir_base_width(CPULoongArchState *env, uint64_t *dir_base,
> diff --git a/target/loongarch/tcg/tcg_loongarch.h b/target/loongarch/tcg/tcg_loongarch.h
> index da2539e995..69a93bfc3e 100644
> --- a/target/loongarch/tcg/tcg_loongarch.h
> +++ b/target/loongarch/tcg/tcg_loongarch.h
> @@ -6,7 +6,23 @@
>    */
>   #ifndef TARGET_LOONGARCH_TCG_LOONGARCH_H
>   #define TARGET_LOONGARCH_TCG_LOONGARCH_H
> +#include "cpu.h"
>   
>   void loongarch_csr_translate_init(void);
>   
> +#ifdef CONFIG_TCG
> +int loongarch_get_addr_from_tlb(CPULoongArchState *env, hwaddr *physical,
> +                                int *prot, target_ulong address,
> +                                MMUAccessType access_type, int mmu_idx);
> +#else
> +static inline int loongarch_get_addr_from_tlb(CPULoongArchState *env,
> +                                              hwaddr *physical,
> +                                              int *prot, target_ulong address,
> +                                              MMUAccessType access_type,
> +                                              int mmu_idx)
> +{
> +    return TLBRET_NOMATCH;

CONFIG_TCG should always be defined when including tcg/tcg_loongarch.h.

> +}
> +#endif
> +
>   #endif  /* TARGET_LOONGARCH_TCG_LOONGARCH_H */


