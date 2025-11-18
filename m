Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F6EBCED619
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 11:21:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLJmC-0006yk-4j; Tue, 18 Nov 2025 06:21:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vLJmA-0006y4-O0
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 06:21:34 -0500
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vLJm9-0004An-4b
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 06:21:34 -0500
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-bc274b8b15bso4169503a12.1
 for <qemu-devel@nongnu.org>; Tue, 18 Nov 2025 03:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1763464892; x=1764069692; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eEeFZx2f/83xQm3ItuB8PrAy+hUwtqLueNCVMYkKF/E=;
 b=TyLXhgypY1jGFlLgEDtnjgFfehFVCGi0K5NRiVwzD2Y/30A+atGRbDNyJaCIHCzS0E
 P95mxuEfY511fhXD1eJ5lrYNdfhTCInOlhjcIQBjDBHmhXeutgusxHWzgdoBjb3/K/F4
 q3Cb91LfcF11x1o/FkrGkFY74qiskfmGjytMwdxd3IuBYB+YYABuqqjiKycUtREWtt0p
 cfP/JW0/O1p/ZH4u2mrY4OfcWY/1ReBm7X80fW7YhzS1zB7lufoJqoCcGfRyWn2iHIMY
 U82DWsyn3nAezz2efmOeJ2mOM/ygGH4NSP8vWiCoy/TIWPYgObNxQqULs8BMtFLAX9fq
 /aqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763464892; x=1764069692;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eEeFZx2f/83xQm3ItuB8PrAy+hUwtqLueNCVMYkKF/E=;
 b=KlPH8oaLy/gRk8z8jGRqugj7MeTgTEaASsRnKC/b0XL87kh3hRwacaNUY0/GA4Zdgd
 3JYzlDRAmBW2zPbTtDjxdKLOA7r81oFybfe2IHLtr9BAkUZOb3XeHwRG9C/OnlbH8yLz
 sM9qoQ5QWjQbnUiSL7RKhKj5W+VnNF7rtf2mmEfbzbBfVtqWoJX6TE7xb0+gmyeVmuDb
 ByVCJdnDDq5RQrEW7geDX2cq5hQuGTvcFCMLPPlt7MaqdLtOsjE8rpv8Moe/RvqwvUA0
 Zo/aztdlzyJznOk5rjrvpNUvdAu/gO1N3Xq37wp7oTLmEsFAdm30p2TG9ZTXnBMKAiuF
 fuqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWn4wGxxLVncKIxOEPm5wfUr94Z60wQo5B1j0QjKxL+s81VYKEH7SAWGVj6NC4O9l1K75+VpPawwNO3@nongnu.org
X-Gm-Message-State: AOJu0YxbnLb6KvEF/kOMIY3JyJEjD5Cxs6yVvnjB22UeHmcxFaPWuiJM
 fEGS7Nn2d6rM39+36SxNRe74KsAht38ILmSh4WDCl1dh5cKaZ3t46+sF3EBmgZD50ig=
X-Gm-Gg: ASbGncvaNb8rJcCGjLm8ZfopsJT4y6WTh3hnoYOBlnGeuEipKzgvmOaH0/X7I5vFDjU
 MupgeGIfaKSYkoiHlAX14h3NRaA7mAqL16YHowf0U21eHHhnYVwethy8fOhSZX30TkQ8cZPHyS/
 Li4PIqpr4m+AWQ7M5X3UN0G+6tihCHu8awk8DDot27aCsR4g+38s1bs8So4CUjk7zna3BuQ9L3x
 uT9pASU0WwGdQlZ//V0LK3Z+RAER/CTLXu2YuZ+Kw8o6lxodLBDWLEnSP2Z2HlH9DSFwIJtDKhP
 O77R2wAQPE9zdxWXBt86MvQ/rR2t8G0switxN6Qp0b1FBx79DNmxxWD76w3mDrEYoiksZeTMOUN
 TwDyxOh5tKQpr42YcIIje0wUmL/6euXiNzEtpNr1xVTmEioIdLUPpJbz85FNhe/vDS6GLuKI1St
 CWbKaO9T/p/s2YT2M=
X-Google-Smtp-Source: AGHT+IFnAEeyqSW6mkNkFEcHrHc+COd/xnV6wyR1Ho2xai6I7y0V170l1KKW1uJFyPphQJX/rJNkIA==
X-Received: by 2002:a05:7300:7890:b0:2a4:3592:cf75 with SMTP id
 5a478bee46e88-2a4abb032a2mr8751494eec.25.1763464891654; 
 Tue, 18 Nov 2025 03:21:31 -0800 (PST)
Received: from [192.168.68.110] ([191.202.237.26])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2a49db7a753sm56810755eec.6.2025.11.18.03.21.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Nov 2025 03:21:31 -0800 (PST)
Message-ID: <b766a87c-1c06-4f28-b5b6-18c3947afd45@ventanamicro.com>
Date: Tue, 18 Nov 2025 08:21:27 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] target/riscv: Rename riscv_pm_get_virt_pmm() to
 riscv_pm_get_vm_ldst_pmm()
To: frank.chang@sifive.com, qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>
References: <20251118105936.2839054-1-frank.chang@sifive.com>
 <20251118105936.2839054-4-frank.chang@sifive.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <20251118105936.2839054-4-frank.chang@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x536.google.com
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



On 11/18/25 7:59 AM, frank.chang@sifive.com wrote:
> From: Frank Chang <frank.chang@sifive.com>
> 
> Rename riscv_pm_get_virt_pmm() to riscv_pm_get_vm_ldst_pmm() to better
> reflect its actual usage. This function is used when checking the PMM
> configuration for virtual-machine load/store instructions (HLV.* and HSV.*).
> 
> No functional change intended.
> 
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/cpu.h        | 2 +-
>   target/riscv/cpu_helper.c | 2 +-
>   target/riscv/internals.h  | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 8899bf7667a..abc87e64648 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -846,7 +846,7 @@ bool riscv_cpu_is_32bit(RISCVCPU *cpu);
>   
>   bool riscv_cpu_virt_mem_enabled(CPURISCVState *env);
>   RISCVPmPmm riscv_pm_get_pmm(CPURISCVState *env);
> -RISCVPmPmm riscv_pm_get_virt_pmm(CPURISCVState *env);
> +RISCVPmPmm riscv_pm_get_vm_ldst_pmm(CPURISCVState *env);
>   uint32_t riscv_pm_get_pmlen(RISCVPmPmm pmm);
>   
>   RISCVException riscv_csrr(CPURISCVState *env, int csrno,
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 112093012b0..40b1e8da471 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -190,7 +190,7 @@ RISCVPmPmm riscv_pm_get_pmm(CPURISCVState *env)
>   #endif
>   }
>   
> -RISCVPmPmm riscv_pm_get_virt_pmm(CPURISCVState *env)
> +RISCVPmPmm riscv_pm_get_vm_ldst_pmm(CPURISCVState *env)
>   {
>   #ifndef CONFIG_USER_ONLY
>       int priv_mode = cpu_address_mode(env);
> diff --git a/target/riscv/internals.h b/target/riscv/internals.h
> index 9b3f01144d2..b17b661e2a8 100644
> --- a/target/riscv/internals.h
> +++ b/target/riscv/internals.h
> @@ -190,7 +190,7 @@ static inline target_ulong adjust_addr_body(CPURISCVState *env,
>   
>       /* get pmm field depending on whether addr is */
>       if (is_virt_addr) {
> -        pmm = riscv_pm_get_virt_pmm(env);
> +        pmm = riscv_pm_get_vm_ldst_pmm(env);
>       } else {
>           pmm = riscv_pm_get_pmm(env);
>       }


