Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC70ED6A221
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 18:59:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBeyq-0001Cm-Gs; Thu, 14 Nov 2024 13:54:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBeyn-0000za-N3
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 13:54:09 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBeyc-0007yL-6D
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 13:54:09 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-720c286bcd6so886906b3a.3
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 10:53:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731610436; x=1732215236; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eQJ914oOJf5HJnWV+RpMv+Pzu2o/yVuyJC80hmImRvI=;
 b=LG2fMpL8boZq+yoh5FRB9eOYwoIVy5s1qso+FMALA+WPRt7dqyH+hFo75NJmybQkVP
 iP0xVc7qlTxyfAW2aV7M2Ygz1YDUsaiObj2h05MtYfF/sAtth85+bw9rJmOU7Q0SWtKl
 MAD7HpA/aUAnuA5/9lpHql1n7k3K2k8Zvch5KUSpK0x7ol1HRFKwUNOnueVj9KuTVmXS
 kaoUZaPagd6lsWBRgcbgFFG9wgXooR3Uq8SIGtsTuthgC6fnyOvk14a0z/GtTS1mL6C6
 uHSwBwUebv+XUqiqs0P2irww0IRZ4dAEdquTr5K/o27mH6b5gqreIBBKi8u+dlp/a8si
 ax6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731610436; x=1732215236;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eQJ914oOJf5HJnWV+RpMv+Pzu2o/yVuyJC80hmImRvI=;
 b=N4ysNSVIgW1hLbJYCDfe7znYUNVdYdP8QoQeCyfaov5Y9gvpIIPxxWbBFuNZb9nMyk
 /4fGRxOYdZlw8e/M+2jTu/NATLsQYfbBDm5gM2DuACRKEjFPlUBwoDVoxKkVrCpQ+Mru
 u+5yS6xzgZk0US46KvZ2w83WJoARoDCJVjhjvsXiz8wegM9toKeNxgoy3vL+DJLGdlgh
 pDoiEQgbeGgUYY5xHRhZLS2cF5a7JoTBTZYYC1TTLldfPnSPiJacVKVFRBLS/LzTK18t
 6PprabK0B9CKoyBzcAtI3RqkCDOzwt3OFCydWbWIL6/0B/wYkcHIlmcwyKHdxYmNDk0l
 KOpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYWHMEBAMZE3hoiFXlcuusjRFAi1ajvMD9mqFBT50PL7BkybzHlbIBFL4Wz7nWCO0lkq9744QE4CRd@nongnu.org
X-Gm-Message-State: AOJu0YxREt4PEDut1ivR/NDFazpZ4oDaaoCKqJwhuJ/LHgxb4xrp1/Er
 JFJ0w9bjsdE9FqcmyK8bwQAiC4eCHreEoVIlWnfcEcrRwIG4FWJ1l0Nl43+FMyTHbQsrU/2p7kD
 ta8Vp5A==
X-Google-Smtp-Source: AGHT+IEuiQEKBjOlkrCYWe6h8ZpMB2WyCXD6sroq8BU4jkTwMhfgn4KrJU1eQsT4TyTb/WJNbvjRMw==
X-Received: by 2002:a05:6a00:2385:b0:71e:cc7:c511 with SMTP id
 d2e1a72fcca58-7241338b594mr34473327b3a.23.1731610436290; 
 Thu, 14 Nov 2024 10:53:56 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7246a5ceda0sm1592394b3a.1.2024.11.14.10.53.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2024 10:53:55 -0800 (PST)
Message-ID: <6721d1c9-f8be-4e25-bc65-bf076d973ed1@linaro.org>
Date: Thu, 14 Nov 2024 10:53:55 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 42/54] target/openrisc: Convert to
 TCGCPUOps.tlb_fill_align
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241114160131.48616-1-richard.henderson@linaro.org>
 <20241114160131.48616-43-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241114160131.48616-43-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x434.google.com
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
>   target/openrisc/cpu.h |  8 +++++---
>   target/openrisc/cpu.c |  2 +-
>   target/openrisc/mmu.c | 39 +++++++++++++++++++++------------------
>   3 files changed, 27 insertions(+), 22 deletions(-)
> 
> diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
> index c9fe9ae12d..e177ad8b84 100644
> --- a/target/openrisc/cpu.h
> +++ b/target/openrisc/cpu.h
> @@ -22,6 +22,7 @@
>   
>   #include "cpu-qom.h"
>   #include "exec/cpu-defs.h"
> +#include "exec/memop.h"
>   #include "fpu/softfloat-types.h"
>   
>   /**
> @@ -306,9 +307,10 @@ int print_insn_or1k(bfd_vma addr, disassemble_info *info);
>   #ifndef CONFIG_USER_ONLY
>   hwaddr openrisc_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
>   
> -bool openrisc_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
> -                           MMUAccessType access_type, int mmu_idx,
> -                           bool probe, uintptr_t retaddr);
> +bool openrisc_cpu_tlb_fill_align(CPUState *cs, CPUTLBEntryFull *out,
> +                                 vaddr addr, MMUAccessType access_type,
> +                                 int mmu_idx, MemOp memop, int size,
> +                                 bool probe, uintptr_t ra);
>   
>   extern const VMStateDescription vmstate_openrisc_cpu;
>   
> diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
> index b96561d1f2..6aa04ff7d3 100644
> --- a/target/openrisc/cpu.c
> +++ b/target/openrisc/cpu.c
> @@ -237,7 +237,7 @@ static const TCGCPUOps openrisc_tcg_ops = {
>       .restore_state_to_opc = openrisc_restore_state_to_opc,
>   
>   #ifndef CONFIG_USER_ONLY
> -    .tlb_fill = openrisc_cpu_tlb_fill,
> +    .tlb_fill_align = openrisc_cpu_tlb_fill_align,
>       .cpu_exec_interrupt = openrisc_cpu_exec_interrupt,
>       .cpu_exec_halt = openrisc_cpu_has_work,
>       .do_interrupt = openrisc_cpu_do_interrupt,
> diff --git a/target/openrisc/mmu.c b/target/openrisc/mmu.c
> index c632d5230b..eafab356a6 100644
> --- a/target/openrisc/mmu.c
> +++ b/target/openrisc/mmu.c
> @@ -104,39 +104,42 @@ static void raise_mmu_exception(OpenRISCCPU *cpu, target_ulong address,
>       cpu->env.lock_addr = -1;
>   }
>   
> -bool openrisc_cpu_tlb_fill(CPUState *cs, vaddr addr, int size,
> -                           MMUAccessType access_type, int mmu_idx,
> -                           bool probe, uintptr_t retaddr)
> +bool openrisc_cpu_tlb_fill_align(CPUState *cs, CPUTLBEntryFull *out,
> +                                 vaddr addr, MMUAccessType access_type,
> +                                 int mmu_idx, MemOp memop, int size,
> +                                 bool probe, uintptr_t retaddr)
>   {
>       OpenRISCCPU *cpu = OPENRISC_CPU(cs);
> -    int excp = EXCP_DPF;
>       int prot;
>       hwaddr phys_addr;
>   
> +    /* TODO: alignment faults not currently handled. */
> +
>       if (mmu_idx == MMU_NOMMU_IDX) {
>           /* The mmu is disabled; lookups never fail.  */
>           get_phys_nommu(&phys_addr, &prot, addr);
> -        excp = 0;
>       } else {
>           bool super = mmu_idx == MMU_SUPERVISOR_IDX;
>           int need = (access_type == MMU_INST_FETCH ? PAGE_EXEC
>                       : access_type == MMU_DATA_STORE ? PAGE_WRITE
>                       : PAGE_READ);
> -        excp = get_phys_mmu(cpu, &phys_addr, &prot, addr, need, super);
> +        int excp = get_phys_mmu(cpu, &phys_addr, &prot, addr, need, super);
> +
> +        if (unlikely(excp)) {
> +            if (probe) {
> +                return false;
> +            }
> +            raise_mmu_exception(cpu, addr, excp);
> +            cpu_loop_exit_restore(cs, retaddr);
> +        }
>       }
>   
> -    if (likely(excp == 0)) {
> -        tlb_set_page(cs, addr & TARGET_PAGE_MASK,
> -                     phys_addr & TARGET_PAGE_MASK, prot,
> -                     mmu_idx, TARGET_PAGE_SIZE);
> -        return true;
> -    }
> -    if (probe) {
> -        return false;
> -    }
> -
> -    raise_mmu_exception(cpu, addr, excp);
> -    cpu_loop_exit_restore(cs, retaddr);
> +    memset(out, 0, sizeof(*out));
> +    out->phys_addr = phys_addr;
> +    out->prot = prot;
> +    out->lg_page_size = TARGET_PAGE_BITS;
> +    out->attrs = MEMTXATTRS_UNSPECIFIED;
> +    return true;
>   }
>   
>   hwaddr openrisc_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


