Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91DABC27C53
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2024 06:03:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFSgo-0007hS-0o; Fri, 07 Jun 2024 02:03:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sFSgk-0007gy-S4
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 02:02:59 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sFSgi-0004C7-MN
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 02:02:58 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a68ee841138so218034666b.1
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2024 23:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717740175; x=1718344975; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jSOscKnTR2DWdP1aL7t6OCU9TpO/YbxxE81jmy8HO3w=;
 b=jk9PekROuWx/AUqkEq/AP6PJn0Ep6wyCt+HTRc75kWNLrZeQ+NqNLPaw4XeF2nM70l
 pbn1IoSrQI/E+evotBmdfhqak7MvqbTICst0NU6txwhBx2qQyfWdOVceedQojOMs2UpK
 3CkWoKV5Jjj235f0fRiO+1mrU04MUpQTQh+HD86AMfByzBSnsRlr/mUUmQRlfeT/jz4c
 3+TtwKJ3Z2Z8AGBufmtTaEqlVuO6wGTIcXe3CiaZMBZm1afQfgyKfnS6CWsdQy+GolII
 3qQiW/w0pUDGGPajAI3KyyhtkR8ld3FrrGrnD5OV0nu/MZi+gnZBw+0ZS70pKJlyobUB
 BSsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717740175; x=1718344975;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jSOscKnTR2DWdP1aL7t6OCU9TpO/YbxxE81jmy8HO3w=;
 b=ABZ1d0Mq0x0hNEFFMO4WLGv4BYmHHgUZLZynjYvVDglvmpYQNstivejtDzHM2kCrJO
 jEYC2qBB8tttziDaU9W4jy+3Cw1I+DacXopkDgg+3d8njh9Xl6h3DjiriQqBV+kEjZdV
 E8smMgGVhyCgUWVVMWsHKFEDGe2f+0t4pZcX/kXfEvBAWGVGgWry7190yZy/TaCPQlEd
 hTt7QBtj5fl2+u7Daai3xeWQf/lpOp3rfum1EAKj6xJHNeDbqUApztkgfWetxSnsYVHl
 ls3BrjEaH1KLk8jGVJCrj2xBzkQPCc4kTd95Oovuiu2g2VVAxC3wI6AXFMXkB3Cb+WUP
 gLig==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZrv+B47S3cK3QwRanDSm5fVfuqM+43xbUcYaK1domquLZC+gkzZFeUMAJJSx7H2BhFrvEw8TUMVenCuMdu7tpP5DhgeM=
X-Gm-Message-State: AOJu0YySmAcp/u7dsq9T+odaa57YHEFi8/1qd1fO28EVCVzI4EhwswRZ
 Y1wbfQ7nIvD34+0TyZrnkhaf4pa8Enf8hEuGEep9Y6kDfgan5Boq5N/DiQ4w1e4=
X-Google-Smtp-Source: AGHT+IECC7gogu91yEul9vo6WXdNuydYZqFByb2rqpPTfv3j3irzB0Wj0NUpGkv1gma5w7GjYMgC3w==
X-Received: by 2002:a17:906:c0d4:b0:a62:1347:ad40 with SMTP id
 a640c23a62f3a-a6cd5616b72mr100986166b.16.1717740174560; 
 Thu, 06 Jun 2024 23:02:54 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.196.231])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6c805ccb1csm195585466b.80.2024.06.06.23.02.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Jun 2024 23:02:53 -0700 (PDT)
Message-ID: <1dd777bb-184d-4c0d-ad80-afa65e0c58bd@linaro.org>
Date: Fri, 7 Jun 2024 08:02:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/6] Convert 'info tlb' to use generic iterator
To: Don Porter <porter@cs.unc.edu>, qemu-devel@nongnu.org
Cc: dave@treblig.org, peter.maydell@linaro.org, nadav.amit@gmail.com,
 richard.henderson@linaro.org, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
References: <20240606140253.2277760-1-porter@cs.unc.edu>
 <20240606140253.2277760-3-porter@cs.unc.edu>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240606140253.2277760-3-porter@cs.unc.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
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

Hi Don,

(Cc'ing Daniel for HumanReadableText)

On 6/6/24 16:02, Don Porter wrote:
> Signed-off-by: Don Porter <porter@cs.unc.edu>
> ---
>   include/hw/core/sysemu-cpu-ops.h |   7 +
>   monitor/hmp-cmds-target.c        |   1 +
>   target/i386/cpu.h                |   2 +
>   target/i386/monitor.c            | 217 ++++++-------------------------
>   4 files changed, 53 insertions(+), 174 deletions(-)
> 
> diff --git a/include/hw/core/sysemu-cpu-ops.h b/include/hw/core/sysemu-cpu-ops.h
> index eb16a1c3e2..bf3de3e004 100644
> --- a/include/hw/core/sysemu-cpu-ops.h
> +++ b/include/hw/core/sysemu-cpu-ops.h
> @@ -243,6 +243,13 @@ typedef struct SysemuCPUOps {
>       bool (*mon_flush_page_print_state)(CPUState *cs,
>                                          struct mem_print_state *state);
>   
> +    /**
> +     * @mon_print_pte: Hook called by the monitor to print a page
> +     * table entry at address addr, with contents pte.
> +     */
> +    void (*mon_print_pte) (Monitor *mon, CPUArchState *env, hwaddr addr,
> +                           hwaddr pte);

IMO the SysemuCPUOps prototype should not use the monitor and return
a HumanReadableText:

       HumanReadableText *(*mon_print_pte)(CPUArchState *env,
                                           hwaddr addr, hwaddr pte);

Then define a QMP handler, itself registered to the monitor using
monitor_register_hmp_info_hrt().

Otherwise the cleanup is nice!

Regards,

Phil.

> +
>   } SysemuCPUOps;
>   
>   #endif /* SYSEMU_CPU_OPS_H */
> diff --git a/monitor/hmp-cmds-target.c b/monitor/hmp-cmds-target.c
> index 60a8bd0c37..3393e5ad0b 100644
> --- a/monitor/hmp-cmds-target.c
> +++ b/monitor/hmp-cmds-target.c
> @@ -318,6 +318,7 @@ void hmp_info_pg(Monitor *mon, const QDict *qdict)
>       /* Print last entry, if one present */
>       cc->sysemu_ops->mon_flush_page_print_state(cs, &state);
>   }
> +
>   static void memory_dump(Monitor *mon, int count, int format, int wsize,
>                           hwaddr addr, int is_physical)
>   {
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index cbb6f6fc4d..1346ec0033 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -2167,6 +2167,8 @@ bool x86_mon_init_page_table_iterator(Monitor *mon,
>                                         struct mem_print_state *state);
>   void x86_mon_info_pg_print_header(Monitor *mon, struct mem_print_state *state);
>   bool x86_mon_flush_print_pg_state(CPUState *cs, struct mem_print_state *state);
> +void x86_mon_print_pte(Monitor *mon, CPUArchState *env, hwaddr addr,
> +                       hwaddr pte);
>   
>   void x86_cpu_dump_state(CPUState *cs, FILE *f, int flags);
>   
> diff --git a/target/i386/monitor.c b/target/i386/monitor.c
> index 65e82e73e8..ecde164857 100644
> --- a/target/i386/monitor.c
> +++ b/target/i386/monitor.c
> @@ -214,202 +214,71 @@ static hwaddr addr_canonical(CPUArchState *env, hwaddr addr)
>       return addr;
>   }
>   
> -static void print_pte(Monitor *mon, CPUArchState *env, hwaddr addr,
> -                      hwaddr pte, hwaddr mask)
> +void x86_mon_print_pte(Monitor *mon, CPUArchState *env, hwaddr addr,
> +                       hwaddr pte)
>   {
> +    char buf[128];
> +    char *pos = buf, *end = buf + sizeof(buf);
> +
>       addr = addr_canonical(env, addr);
>   
> -    monitor_printf(mon, HWADDR_FMT_plx ": " HWADDR_FMT_plx
> -                   " %c%c%c%c%c%c%c%c%c\n",
> -                   addr,
> -                   pte & mask,
> -                   pte & PG_NX_MASK ? 'X' : '-',
> -                   pte & PG_GLOBAL_MASK ? 'G' : '-',
> -                   pte & PG_PSE_MASK ? 'P' : '-',
> -                   pte & PG_DIRTY_MASK ? 'D' : '-',
> -                   pte & PG_ACCESSED_MASK ? 'A' : '-',
> -                   pte & PG_PCD_MASK ? 'C' : '-',
> -                   pte & PG_PWT_MASK ? 'T' : '-',
> -                   pte & PG_USER_MASK ? 'U' : '-',
> -                   pte & PG_RW_MASK ? 'W' : '-');
> -}
> +    pos += snprintf(pos, end - pos, HWADDR_FMT_plx ": " HWADDR_FMT_plx " ",
> +                    addr, (hwaddr) (pte & PG_ADDRESS_MASK));
>   
> -static void tlb_info_32(Monitor *mon, CPUArchState *env)
> -{
> -    unsigned int l1, l2;
> -    uint32_t pgd, pde, pte;
> +    pos += snprintf(pos, end - pos, " %s", pg_bits(pte));
>   
> -    pgd = env->cr[3] & ~0xfff;
> -    for(l1 = 0; l1 < 1024; l1++) {
> -        cpu_physical_memory_read(pgd + l1 * 4, &pde, 4);
> -        pde = le32_to_cpu(pde);
> -        if (pde & PG_PRESENT_MASK) {
> -            if ((pde & PG_PSE_MASK) && (env->cr[4] & CR4_PSE_MASK)) {
> -                /* 4M pages */
> -                print_pte(mon, env, (l1 << 22), pde, ~((1 << 21) - 1));
> -            } else {
> -                for(l2 = 0; l2 < 1024; l2++) {
> -                    cpu_physical_memory_read((pde & ~0xfff) + l2 * 4, &pte, 4);
> -                    pte = le32_to_cpu(pte);
> -                    if (pte & PG_PRESENT_MASK) {
> -                        print_pte(mon, env, (l1 << 22) + (l2 << 12),
> -                                  pte & ~PG_PSE_MASK,
> -                                  ~0xfff);
> -                    }
> -                }
> -            }
> -        }
> +    /* Trim line to fit screen */
> +    if (pos - buf > 79) {
> +        strcpy(buf + 77, "..");
>       }
> -}
>   
> -static void tlb_info_pae32(Monitor *mon, CPUArchState *env)
> -{
> -    unsigned int l1, l2, l3;
> -    uint64_t pdpe, pde, pte;
> -    uint64_t pdp_addr, pd_addr, pt_addr;
> -
> -    pdp_addr = env->cr[3] & ~0x1f;
> -    for (l1 = 0; l1 < 4; l1++) {
> -        cpu_physical_memory_read(pdp_addr + l1 * 8, &pdpe, 8);
> -        pdpe = le64_to_cpu(pdpe);
> -        if (pdpe & PG_PRESENT_MASK) {
> -            pd_addr = pdpe & 0x3fffffffff000ULL;
> -            for (l2 = 0; l2 < 512; l2++) {
> -                cpu_physical_memory_read(pd_addr + l2 * 8, &pde, 8);
> -                pde = le64_to_cpu(pde);
> -                if (pde & PG_PRESENT_MASK) {
> -                    if (pde & PG_PSE_MASK) {
> -                        /* 2M pages with PAE, CR4.PSE is ignored */
> -                        print_pte(mon, env, (l1 << 30) + (l2 << 21), pde,
> -                                  ~((hwaddr)(1 << 20) - 1));
> -                    } else {
> -                        pt_addr = pde & 0x3fffffffff000ULL;
> -                        for (l3 = 0; l3 < 512; l3++) {
> -                            cpu_physical_memory_read(pt_addr + l3 * 8, &pte, 8);
> -                            pte = le64_to_cpu(pte);
> -                            if (pte & PG_PRESENT_MASK) {
> -                                print_pte(mon, env, (l1 << 30) + (l2 << 21)
> -                                          + (l3 << 12),
> -                                          pte & ~PG_PSE_MASK,
> -                                          ~(hwaddr)0xfff);
> -                            }
> -                        }
> -                    }
> -                }
> -            }
> -        }
> -    }
> +    monitor_printf(mon, "%s\n", buf);
>   }
>   
> -#ifdef TARGET_X86_64
> -static void tlb_info_la48(Monitor *mon, CPUArchState *env,
> -        uint64_t l0, uint64_t pml4_addr)
> +static
> +int mem_print_tlb(CPUState *cs, void *data, PTE_t *pte,
> +                  vaddr vaddr_in, int height, int offset)
>   {
> -    uint64_t l1, l2, l3, l4;
> -    uint64_t pml4e, pdpe, pde, pte;
> -    uint64_t pdp_addr, pd_addr, pt_addr;
> -
> -    for (l1 = 0; l1 < 512; l1++) {
> -        cpu_physical_memory_read(pml4_addr + l1 * 8, &pml4e, 8);
> -        pml4e = le64_to_cpu(pml4e);
> -        if (!(pml4e & PG_PRESENT_MASK)) {
> -            continue;
> -        }
> +    struct mem_print_state *state = (struct mem_print_state *) data;
> +    CPUClass *cc = CPU_GET_CLASS(cs);
>   
> -        pdp_addr = pml4e & 0x3fffffffff000ULL;
> -        for (l2 = 0; l2 < 512; l2++) {
> -            cpu_physical_memory_read(pdp_addr + l2 * 8, &pdpe, 8);
> -            pdpe = le64_to_cpu(pdpe);
> -            if (!(pdpe & PG_PRESENT_MASK)) {
> -                continue;
> -            }
> -
> -            if (pdpe & PG_PSE_MASK) {
> -                /* 1G pages, CR4.PSE is ignored */
> -                print_pte(mon, env, (l0 << 48) + (l1 << 39) + (l2 << 30),
> -                        pdpe, 0x3ffffc0000000ULL);
> -                continue;
> -            }
> -
> -            pd_addr = pdpe & 0x3fffffffff000ULL;
> -            for (l3 = 0; l3 < 512; l3++) {
> -                cpu_physical_memory_read(pd_addr + l3 * 8, &pde, 8);
> -                pde = le64_to_cpu(pde);
> -                if (!(pde & PG_PRESENT_MASK)) {
> -                    continue;
> -                }
> -
> -                if (pde & PG_PSE_MASK) {
> -                    /* 2M pages, CR4.PSE is ignored */
> -                    print_pte(mon, env, (l0 << 48) + (l1 << 39) + (l2 << 30) +
> -                            (l3 << 21), pde, 0x3ffffffe00000ULL);
> -                    continue;
> -                }
> -
> -                pt_addr = pde & 0x3fffffffff000ULL;
> -                for (l4 = 0; l4 < 512; l4++) {
> -                    cpu_physical_memory_read(pt_addr
> -                            + l4 * 8,
> -                            &pte, 8);
> -                    pte = le64_to_cpu(pte);
> -                    if (pte & PG_PRESENT_MASK) {
> -                        print_pte(mon, env, (l0 << 48) + (l1 << 39) +
> -                                (l2 << 30) + (l3 << 21) + (l4 << 12),
> -                                pte & ~PG_PSE_MASK, 0x3fffffffff000ULL);
> -                    }
> -                }
> -            }
> -        }
> -    }
> +    cc->sysemu_ops->mon_print_pte(state->mon, state->env, vaddr_in,
> +                                  pte->pte64_t);
> +    return 0;
>   }
>   
> -static void tlb_info_la57(Monitor *mon, CPUArchState *env)
> +void hmp_info_tlb(Monitor *mon, const QDict *qdict)
>   {
> -    uint64_t l0;
> -    uint64_t pml5e;
> -    uint64_t pml5_addr;
> +    struct mem_print_state state;
>   
> -    pml5_addr = env->cr[3] & 0x3fffffffff000ULL;
> -    for (l0 = 0; l0 < 512; l0++) {
> -        cpu_physical_memory_read(pml5_addr + l0 * 8, &pml5e, 8);
> -        pml5e = le64_to_cpu(pml5e);
> -        if (pml5e & PG_PRESENT_MASK) {
> -            tlb_info_la48(mon, env, l0, pml5e & 0x3fffffffff000ULL);
> -        }
> +    CPUState *cs = mon_get_cpu(mon);
> +    if (!cs) {
> +        monitor_printf(mon, "Unable to get CPUState.  Internal error\n");
> +        return;
>       }
> -}
> -#endif /* TARGET_X86_64 */
>   
> -void hmp_info_tlb(Monitor *mon, const QDict *qdict)
> -{
> -    CPUArchState *env;
> +    CPUClass *cc = CPU_GET_CLASS(cs);
>   
> -    env = mon_get_cpu_env(mon);
> -    if (!env) {
> -        monitor_printf(mon, "No CPU available\n");
> -        return;
> +    if ((!cc->sysemu_ops->pte_child)
> +        || (!cc->sysemu_ops->pte_leaf)
> +        || (!cc->sysemu_ops->pte_leaf_page_size)
> +        || (!cc->sysemu_ops->page_table_entries_per_node)
> +        || (!cc->sysemu_ops->pte_flags)
> +        || (!cc->sysemu_ops->mon_print_pte)
> +        || (!cc->sysemu_ops->mon_init_page_table_iterator)) {
> +        monitor_printf(mon, "Info tlb unsupported on this ISA\n");
>       }
>   
> -    if (!(env->cr[0] & CR0_PG_MASK)) {
> -        monitor_printf(mon, "PG disabled\n");
> +    if (!cc->sysemu_ops->mon_init_page_table_iterator(mon, &state)) {
> +        monitor_printf(mon, "Unable to initialize page table iterator\n");
>           return;
>       }
> -    if (env->cr[4] & CR4_PAE_MASK) {
> -#ifdef TARGET_X86_64
> -        if (env->hflags & HF_LMA_MASK) {
> -            if (env->cr[4] & CR4_LA57_MASK) {
> -                tlb_info_la57(mon, env);
> -            } else {
> -                tlb_info_la48(mon, env, 0, env->cr[3] & 0x3fffffffff000ULL);
> -            }
> -        } else
> -#endif
> -        {
> -            tlb_info_pae32(mon, env);
> -        }
> -    } else {
> -        tlb_info_32(mon, env);
> -    }
> +
> +    /**
> +     * 'info tlb' visits only leaf PTEs marked present.
> +     * It does not check other protection bits.
> +     */
> +    for_each_pte(cs, &mem_print_tlb, &state, false, false);
>   }
>   
>   static void mem_print(Monitor *mon, CPUArchState *env,


