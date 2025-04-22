Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2762BC369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 07:16:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u77rx-0005so-UP; Tue, 22 Apr 2025 03:16:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u77rt-0005q8-LM
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 03:16:33 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u77rr-00037d-LR
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 03:16:33 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43edecbfb46so35449265e9.0
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 00:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745306189; x=1745910989; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=f7fJE9WXdoE++wCNoz+1UHA/jxXA+ZBx0oz2MHOXCxk=;
 b=vbIcik8HUDB9evs3WAG4zaWK4oElX/CHVVRI/xPYQseo5Z36Gs8yegNmJ/IqVnXDka
 KyzhC6yiDRHIy6yolCzJWrUNmbFd9YTgWVNm+EAHf6ebXRKbu7uWeAlYPIhyyZrm/Flt
 Oz9YtSk5/ieLpbuRYwRT52kRXeojl/D2YW8I6XtXVdeVOMLiWypB78kEfrr8Qdsh9/Q7
 mAPKcbQuJlLqZiOGJ8eBkrSOlFl8JHo81HcmSahOYdctNnrrzVrhwOlGz255nJfBgXSV
 8mZz5cceI5/xph6Mnm3gly0YST7mq7abl31JeUv2TEcKAVmns8gC8wVyqoUuGiumat65
 wOMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745306189; x=1745910989;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=f7fJE9WXdoE++wCNoz+1UHA/jxXA+ZBx0oz2MHOXCxk=;
 b=F880iKSPL2Twte0roIVyzgoUqc1palHlqO3e8TQnYWppVrZ2aNmTgd7UmWAgRlc1Be
 L8jbLUUOcdRmC/hs9ZJpxh07LPOu/962nZpK7UDtVhSGCqAPok9F7Z6yGBKfmyGCoth9
 UNV9OdF+7ZGmyFPmTcY2kmgheMbeUKLIESfcK97O2S6KG3C8hqSF32EQzIqRSszbkp4A
 LNWrzaOlzPnyJR3DPMtd//1oXzyhLqCYkCNWzGwdJCCiqyr2DNGWZ17WaVnoPCOUw7en
 u/aqhq1KEim4oPZInJ1xnToZPowmj47AwqhhbcwWKKJwLB6z3NQH7OixbFxmys0O2j2T
 pbDg==
X-Gm-Message-State: AOJu0YyFk30z6WmXZFb7YvMXPR3nf7OfGeM+sMyXUKrcEOYcBitW2aML
 tyhpAqFuKyMFIhcoyCno/Lp6A+5aCYDGL6QK4kW4NcKYUQlJCSkX9pcfvMsC93pj70KVzXJgI7a
 Z
X-Gm-Gg: ASbGncvTe20FiGb+1eaNYnadPfSLz5vAg5dDD13aYTo4mRmQkkyfa8FAgLfFd8ffFLT
 r4KY88OTOQNpP0Lum/aTokka0TUEkFmFQbg/M1NAtE0s7O6ZWj9avb3hjUWDDGSMgvSnZmU4z5E
 2Io03Vz2W0rvkzu/wEj3JNHF3euBQY5wE0rHtS6XFQdQGP+9uK9zR7cBQOZio/16uyadTHW3m/j
 d77ZfjCXwVCu1Q8brOTO/MZORNuYwW8/ysYVuIeqw8FfOlECwSsPY4ZWfqY0cNmQwdXRqvEzg2F
 9dKqf1EX173lwdQkSkiwoz6L0TWN+jM+Pa9r6/eNkRiiolSS1jKFth2f0zPwnK7+mwfQPUpB5J1
 BQypp0yPkWO2aQ+luLoE=
X-Google-Smtp-Source: AGHT+IFTi0scrU4ITPehuDI8mnt7ID+O1122tS1ICoJfslOYqglbK5V90QZKi7e1r/7mie88mcD8ag==
X-Received: by 2002:a05:600c:46c6:b0:43d:b3:f95 with SMTP id
 5b1f17b1804b1-4406ac0fb4amr78652425e9.28.1745306189501; 
 Tue, 22 Apr 2025 00:16:29 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4406d5cf2dfsm164623785e9.29.2025.04.22.00.16.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Apr 2025 00:16:28 -0700 (PDT)
Message-ID: <2e774ee1-552e-41d8-abb2-bb8ae3552798@linaro.org>
Date: Tue, 22 Apr 2025 09:16:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 9/9] target/loongarch: Move definition of TCG specified
 function to tcg directory
To: Bibo Mao <maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20250422025742.2693096-1-maobibo@loongson.cn>
 <20250422025742.2693096-10-maobibo@loongson.cn>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250422025742.2693096-10-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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
> Function loongarch_cpu_tlb_fill() only works in TCG mode, move its
> definition from header file internals.h to file tcg/tcg_loongarch.h
> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   target/loongarch/cpu.c               | 1 +
>   target/loongarch/internals.h         | 5 -----
>   target/loongarch/tcg/tcg_loongarch.h | 4 ++++
>   3 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
> index ea1665e270..f9e35f2693 100644
> --- a/target/loongarch/cpu.c
> +++ b/target/loongarch/cpu.c
> @@ -31,6 +31,7 @@
>   #ifdef CONFIG_TCG
>   #include "exec/cpu_ldst.h"
>   #include "tcg/tcg.h"
> +#include "tcg/tcg_loongarch.h"
>   #endif
>   
>   const char * const regnames[32] = {
> diff --git a/target/loongarch/internals.h b/target/loongarch/internals.h
> index 3a079feb1d..a7384b0d31 100644
> --- a/target/loongarch/internals.h
> +++ b/target/loongarch/internals.h
> @@ -61,11 +61,6 @@ void get_dir_base_width(CPULoongArchState *env, uint64_t *dir_base,
>                                  uint64_t *dir_width, target_ulong level);
>   hwaddr loongarch_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
>   
> -#ifdef CONFIG_TCG
> -bool loongarch_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
> -                            MMUAccessType access_type, int mmu_idx,
> -                            bool probe, uintptr_t retaddr);
> -#endif
>   #endif /* !CONFIG_USER_ONLY */
>   
>   uint64_t read_fcc(CPULoongArchState *env);
> diff --git a/target/loongarch/tcg/tcg_loongarch.h b/target/loongarch/tcg/tcg_loongarch.h
> index 69a93bfc3e..3796c85f6e 100644
> --- a/target/loongarch/tcg/tcg_loongarch.h
> +++ b/target/loongarch/tcg/tcg_loongarch.h
> @@ -11,6 +11,10 @@
>   void loongarch_csr_translate_init(void);
>   
>   #ifdef CONFIG_TCG
> +bool loongarch_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
> +                            MMUAccessType access_type, int mmu_idx,
> +                            bool probe, uintptr_t retaddr);

Out of the #ifdef.

>   int loongarch_get_addr_from_tlb(CPULoongArchState *env, hwaddr *physical,
>                                   int *prot, target_ulong address,
>                                   MMUAccessType access_type, int mmu_idx);


