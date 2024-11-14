Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27800D6A221
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 18:57:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBf0q-0003m8-C7; Thu, 14 Nov 2024 13:56:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBezd-0001jw-HF
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 13:55:04 -0500
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBezU-0008S7-HD
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 13:54:59 -0500
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-7ea8c4ce232so955517a12.0
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 10:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731610482; x=1732215282; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=chqXBjUcdQGJQjwFN4HRQDISwooTfhDJDce/cCqS2yQ=;
 b=n/kaZ2FvsnF0jly7nRyuQGSv9x73o8YwINAt8165yzGxbDlQEwhwpFE9Y6JXEIMyvY
 3QiOzFy54h+32s0IU5ZB86mElbdjacS3aoUuUdSlEtHAyh9A1pAk918M5Bq6SGIonDnH
 mkf4q45DiCC5RoGEuRV0jOsmnYhr29RDuJ2Wwcmmr3QnqNq1Rp7Tg1vwJv6mrHzW7pgH
 Mq2RkCWPzQVDEcaGcX1pcUfz5s4mLo7qQQe6E4EEVjALsF7FjYsLQH/eSY8XITNBxL2v
 UITtd9wFA3v9dbco/+7gJu44Fc8e8WVJEQU0NjqG3Ijrp8X+ztlsDdlsvl+y6GVwQ4qT
 rz/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731610482; x=1732215282;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=chqXBjUcdQGJQjwFN4HRQDISwooTfhDJDce/cCqS2yQ=;
 b=koXwehqOVV4uPY3EwSk3HZHyZeCf5DaRFey2k6rlsCmfI/UDxvj09LnX69SXYScf1v
 HQtw5dT7rLAoRg9DGdt+erofe75DQ4HuhjgvaTghG1tnYuklNRk2Pjv1CE0qte573vOV
 ODiJcUpXKtaEteRqhzSYbw8JIbhcnQR9BJkxut0S2o4Ru4olbQx+eTQrzdNa6bMv0Lyk
 TnzyleqEnx4R/3VyYG6TH9eYrxAFa2Tm+JTHUN2VO8mtRf74EzKx3aRjak++AGfRrnO1
 zJRshfVMtAdvWw5E9F0TXi8COVTm7HufiGy65G2KLTqDJHDQwdqQ/zliL770QGIrz4ja
 mmpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJs/BJ5Qp/TvjeWXJNjNhkc+JPE2FeOFOH7OhORkxtdL0SoOANLIRAJTy+TxvxkIcUKdi/3GqKvOIM@nongnu.org
X-Gm-Message-State: AOJu0Yz3kO9fZ9KKlMj2NVuRsc9EViwhfxoZQqVdd8QiTxDEBbyzIhf1
 ZT/h2Yw4Lfpns/hh4ju20YE2XPCkq2QYK7Kb1zfBf6+xhWgXTlyylVLkbrWYpp1fub85WCSpPg1
 Sk7e2CQ==
X-Google-Smtp-Source: AGHT+IFE1734SAFq6pCQo+fEZgQe3D9kXjumUBfpYBACl2HWrXfpoPMPa0JdFLFGiprVBw3L7q+8gw==
X-Received: by 2002:a05:6a20:9185:b0:1db:eb50:abb0 with SMTP id
 adf61e73a8af0-1dc832ecbbfmr4458467637.3.1731610480482; 
 Thu, 14 Nov 2024 10:54:40 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7246a9bbb17sm1590345b3a.168.2024.11.14.10.54.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2024 10:54:40 -0800 (PST)
Message-ID: <53dff494-5f70-4b9f-9835-fa839692b3d7@linaro.org>
Date: Thu, 14 Nov 2024 10:54:39 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 50/54] target/xtensa: Convert to
 TCGCPUOps.tlb_fill_align
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241114160131.48616-1-richard.henderson@linaro.org>
 <20241114160131.48616-51-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241114160131.48616-51-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x535.google.com
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

On 11/14/24 08:01, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/xtensa/cpu.h    |  8 +++++---
>   target/xtensa/cpu.c    |  2 +-
>   target/xtensa/helper.c | 28 ++++++++++++++++++++--------
>   3 files changed, 26 insertions(+), 12 deletions(-)
> 
> diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
> index 77e48eef19..68c3d90d41 100644
> --- a/target/xtensa/cpu.h
> +++ b/target/xtensa/cpu.h
> @@ -31,6 +31,7 @@
>   #include "cpu-qom.h"
>   #include "qemu/cpu-float.h"
>   #include "exec/cpu-defs.h"
> +#include "exec/memop.h"
>   #include "hw/clock.h"
>   #include "xtensa-isa.h"
>   
> @@ -580,9 +581,10 @@ struct XtensaCPUClass {
>   };
>   
>   #ifndef CONFIG_USER_ONLY
> -bool xtensa_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
> -                         MMUAccessType access_type, int mmu_idx,
> -                         bool probe, uintptr_t retaddr);
> +bool xtensa_cpu_tlb_fill_align(CPUState *cs, CPUTLBEntryFull *out,
> +                               vaddr addr, MMUAccessType access_type,
> +                               int mmu_idx, MemOp memop, int size,
> +                               bool probe, uintptr_t retaddr);
>   void xtensa_cpu_do_interrupt(CPUState *cpu);
>   bool xtensa_cpu_exec_interrupt(CPUState *cpu, int interrupt_request);
>   void xtensa_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr addr,
> diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
> index 6f9039abae..3e4ec97e0e 100644
> --- a/target/xtensa/cpu.c
> +++ b/target/xtensa/cpu.c
> @@ -232,7 +232,7 @@ static const TCGCPUOps xtensa_tcg_ops = {
>       .restore_state_to_opc = xtensa_restore_state_to_opc,
>   
>   #ifndef CONFIG_USER_ONLY
> -    .tlb_fill = xtensa_cpu_tlb_fill,
> +    .tlb_fill_align = xtensa_cpu_tlb_fill_align,
>       .cpu_exec_interrupt = xtensa_cpu_exec_interrupt,
>       .cpu_exec_halt = xtensa_cpu_has_work,
>       .do_interrupt = xtensa_cpu_do_interrupt,
> diff --git a/target/xtensa/helper.c b/target/xtensa/helper.c
> index ca214b948a..69b0e661c8 100644
> --- a/target/xtensa/helper.c
> +++ b/target/xtensa/helper.c
> @@ -261,15 +261,26 @@ void xtensa_cpu_do_unaligned_access(CPUState *cs,
>                                     addr);
>   }
>   
> -bool xtensa_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
> -                         MMUAccessType access_type, int mmu_idx,
> -                         bool probe, uintptr_t retaddr)
> +bool xtensa_cpu_tlb_fill_align(CPUState *cs, CPUTLBEntryFull *out,
> +                               vaddr address, MMUAccessType access_type,
> +                               int mmu_idx, MemOp memop, int size,
> +                               bool probe, uintptr_t retaddr)
>   {
>       CPUXtensaState *env = cpu_env(cs);
>       uint32_t paddr;
>       uint32_t page_size;
>       unsigned access;
> -    int ret = xtensa_get_physical_addr(env, true, address, access_type,
> +    int ret;
> +
> +    if (address & ((1 << memop_alignment_bits(memop)) - 1)) {
> +        if (probe) {
> +            return false;
> +        }
> +        xtensa_cpu_do_unaligned_access(cs, address, access_type,
> +                                       mmu_idx, retaddr);
> +    }
> +
> +    ret = xtensa_get_physical_addr(env, true, address, access_type,
>                                          mmu_idx, &paddr, &page_size, &access);
>   
>       qemu_log_mask(CPU_LOG_MMU, "%s(%08" VADDR_PRIx
> @@ -277,10 +288,11 @@ bool xtensa_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>                     __func__, address, access_type, mmu_idx, paddr, ret);
>   
>       if (ret == 0) {
> -        tlb_set_page(cs,
> -                     address & TARGET_PAGE_MASK,
> -                     paddr & TARGET_PAGE_MASK,
> -                     access, mmu_idx, page_size);
> +        memset(out, 0, sizeof(*out));
> +        out->phys_addr = paddr;
> +        out->prot = access;
> +        out->lg_page_size = ctz32(page_size);
> +        out->attrs = MEMTXATTRS_UNSPECIFIED;
>           return true;
>       } else if (probe) {
>           return false;

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


