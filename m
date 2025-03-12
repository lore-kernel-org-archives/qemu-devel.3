Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F27D3C28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 19:20:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsRcs-0006sl-OS; Wed, 12 Mar 2025 15:20:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tsRcg-0006mY-Gp
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 15:20:11 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tsRcb-0001yG-Eq
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 15:20:10 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43ce70f9afbso1321615e9.0
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 12:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741807204; x=1742412004; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dLiX1Sgl4VyNolfg332UFSiPH/GfOmS4xB63LJQEEFM=;
 b=WCfCtlQXbhLSFlq3SL3FSDfwtxBDnWJyXBHAJmMYv81AAAbMwgtO/g8BL6YVmqpb66
 LFvG8Qoe3H5wJePyhwl2/IFId8sBOytvSD84gGL7CdjZZp9XgaQNMWCG/ff6T3Dby3lj
 DJAVeVrKbnRaDCQtYLHLi0K0uVETQNcUPDDdJ/lSwHqykTf3vw038lOlCOoRc6vbmoJK
 5ri6kRZiEiR6H+VxJF6D1MkRMhlCZLJ2xUB6glfwyq9tULwM5YCDK8mR+V/IeHl+8loW
 AfFNI7poFgQdA9jixciyN3V5RIpo84TEfmLgBQAwIroMY7IayaUE/GuyRjgXdJuMDfx4
 JrOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741807204; x=1742412004;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dLiX1Sgl4VyNolfg332UFSiPH/GfOmS4xB63LJQEEFM=;
 b=YwSW7Sdh8x9uNzRgNnTeN3EsKDjU+PySPNFv2Ed8K6sViGOXolGkgeeiRs8KvM57Ip
 ESM0PCjhu/oVeN9KjAsPDPIvpbjKPlqcUuisEF/LNV4WgAsc3cCtUFEozeY7gQ2WwzPT
 EDUuKHwuyRdpW6KftdGcyrb9J/A4ikbLlIselDm2TFb4F7fBu6C8pDSn9cxvzy0eqlx4
 4d67SV5JFUtN1UolZblJ+MoJsXypVHTl1CeaQFCx21uKA+P+wRRLTkPqkMlzYWwANfxh
 1TPdBHbWrPCnRIbeTXRLH2hRY6WQDDObPvhnw9zS3Q1c0EwuVLYTuilB1VkXYzMjmqyp
 mpFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdIRoj+E9NGOa/WT7QV/CCzbzbiwAi+V9b9WOpSNQCpiaD204cK0XphQFja+CJDsOr2L1TMFKLzpic@nongnu.org
X-Gm-Message-State: AOJu0Ywz8KoF4pMYhIITok8ynYxiEBMwHY9W7f2kZ+p1xjKi+fV7ynL3
 4lS1JaoFPv5MSHYB/n/rGjVCFngC/6NjcXOji8O8T8diE+FTgWwQO+mhPalZIwg=
X-Gm-Gg: ASbGnctIIM/W/gle/BFDHph3k7BJIGUA2/jJfM4jYbgA7fJSe6SKf4+9wso9ZreyRWy
 Um1zg+K6Bo7Mh7P4lla5kV9k3KS6Xi1Vph3nHSfrzRX6sFXJSazW4aPWHc9RCQW8u6o5PFrf6/u
 CNVEk2mYZtC9opB/Vh5FofOlTQh13Jn/Rq5NIkPp6ookAWvhf0Mfh3UXIDKfC1n6LHz5IvtR55j
 6YEiKWFI9/PGo3OSbU3aKBxgsFOblASaddRF7bSXH9niAfRHdUJjFpdzbGHwXngZAadl7JeDrPk
 /huLFivIkcsxYvUxwZZh32g5Sps0jkVx0yDo8JZcFDsjrYx83nkOfvQKsjMTXjetBDxprFp8REK
 aTV/Q5L9Z7syoAyc=
X-Google-Smtp-Source: AGHT+IGkb2K0pZqtm7dZ2vgs/wJ4k/egoaBLtduYvtlwa5BMqO0Qau5Ewf7W4ouueag7L0Bz/JPFrQ==
X-Received: by 2002:a05:600c:4e8f:b0:43c:f597:d582 with SMTP id
 5b1f17b1804b1-43cf597d806mr105082815e9.1.1741807203587; 
 Wed, 12 Mar 2025 12:20:03 -0700 (PDT)
Received: from [192.168.1.20] (88-178-97-237.subs.proxad.net. [88.178.97.237])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d0a8d0b79sm29354805e9.36.2025.03.12.12.20.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Mar 2025 12:20:03 -0700 (PDT)
Message-ID: <fa38864b-8dfb-4475-9bb9-44e4a0657f68@linaro.org>
Date: Wed, 12 Mar 2025 20:20:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 34/38] target/hexagon: Add initial MMU model
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, quic_mathbern@quicinc.com, ale@rev.ng,
 anjo@rev.ng, quic_mliebel@quicinc.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 Brian Cain <bcain@quicinc.com>, Michael Lambert <mlambert@quicinc.com>
References: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
 <20250301052628.1011210-35-brian.cain@oss.qualcomm.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250301052628.1011210-35-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 1/3/25 06:26, Brian Cain wrote:
> From: Brian Cain <bcain@quicinc.com>
> 
> Co-authored-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> Co-authored-by: Michael Lambert <mlambert@quicinc.com>
> Co-authored-by: Sid Manning <sidneym@quicinc.com>
> Co-authored-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   target/hexagon/cpu-param.h |   4 +
>   target/hexagon/cpu.h       |  13 +
>   target/hexagon/hex_mmu.h   |  30 +++
>   target/hexagon/internal.h  |   3 +
>   target/hexagon/cpu.c       |  27 +-
>   target/hexagon/hex_mmu.c   | 528 +++++++++++++++++++++++++++++++++++++
>   target/hexagon/machine.c   |  30 +++
>   target/hexagon/translate.c |   2 +-
>   target/hexagon/meson.build |   3 +-
>   9 files changed, 637 insertions(+), 3 deletions(-)
>   create mode 100644 target/hexagon/hex_mmu.h
>   create mode 100644 target/hexagon/hex_mmu.c


> diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
> index 34c39cecd9..7ff678195d 100644
> --- a/target/hexagon/cpu.c
> +++ b/target/hexagon/cpu.c
> @@ -28,6 +28,7 @@
>   #include "exec/gdbstub.h"
>   #include "cpu_helper.h"
>   #include "max.h"
> +#include "hex_mmu.h"
>   
>   #ifndef CONFIG_USER_ONLY
>   #include "sys_macros.h"
> @@ -283,6 +284,18 @@ static void hexagon_restore_state_to_opc(CPUState *cs,
>       cpu_env(cs)->gpr[HEX_REG_PC] = data[0];
>   }
>   
> +
> +#ifndef CONFIG_USER_ONLY
> +static void mmu_reset(CPUHexagonState *env)
> +{
> +    CPUState *cs = env_cpu(env);
> +    if (cs->cpu_index == 0) {

This doesn't scale to heterogeneous emulation.

> +        memset(env->hex_tlb, 0, sizeof(*env->hex_tlb));
> +    }
> +}
> +#endif
> +
> +
>   static void hexagon_cpu_reset_hold(Object *obj, ResetType type)
>   {
>       CPUState *cs = CPU(obj);
> @@ -310,6 +323,7 @@ static void hexagon_cpu_reset_hold(Object *obj, ResetType type)
>       if (cs->cpu_index == 0) {
>           arch_set_system_reg(env, HEX_SREG_MODECTL, 0x1);
>       }
> +    mmu_reset(env);
>       arch_set_system_reg(env, HEX_SREG_HTID, cs->cpu_index);
>       memset(env->t_sreg, 0, sizeof(target_ulong) * NUM_SREGS);
>       memset(env->greg, 0, sizeof(target_ulong) * NUM_GREGS);
> @@ -341,6 +355,14 @@ static void hexagon_cpu_realize(DeviceState *dev, Error **errp)
>           return;
>       }
>   
> +#ifndef CONFIG_USER_ONLY
> +    HexagonCPU *cpu = HEXAGON_CPU(cs);
> +    if (cpu->num_tlbs > MAX_TLB_ENTRIES) {
> +        error_setg(errp, "Number of TLBs selected is invalid");
> +        return;
> +    }
> +#endif
> +
>       gdb_register_coprocessor(cs, hexagon_hvx_gdb_read_register,
>                                hexagon_hvx_gdb_write_register,
>                                gdb_find_static_feature("hexagon-hvx.xml"), 0);
> @@ -352,9 +374,12 @@ static void hexagon_cpu_realize(DeviceState *dev, Error **errp)
>   #endif
>   
>       qemu_init_vcpu(cs);
> +#ifndef CONFIG_USER_ONLY
> +    CPUHexagonState *env = cpu_env(cs);
> +    hex_mmu_realize(env);
> +#endif
>       cpu_reset(cs);
>   #ifndef CONFIG_USER_ONLY
> -    CPUHexagonState *env = cpu_env(cs);
>       if (cs->cpu_index == 0) {
>           env->g_sreg = g_new0(target_ulong, NUM_SREGS);
>       } else {
> diff --git a/target/hexagon/hex_mmu.c b/target/hexagon/hex_mmu.c
> new file mode 100644
> index 0000000000..54c4ba2dbf
> --- /dev/null
> +++ b/target/hexagon/hex_mmu.c
> @@ -0,0 +1,528 @@
> +/*
> + * Copyright(c) 2019-2025 Qualcomm Innovation Center, Inc. All Rights Reserved.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/main-loop.h"
> +#include "qemu/qemu-print.h"
> +#include "cpu.h"
> +#include "system/cpus.h"
> +#include "internal.h"
> +#include "exec/exec-all.h"
> +#include "hex_mmu.h"
> +#include "macros.h"
> +#include "sys_macros.h"
> +#include "reg_fields.h"
> +
> +#define GET_TLB_FIELD(ENTRY, FIELD)                               \
> +    ((uint64_t)fEXTRACTU_BITS(ENTRY, reg_field_info[FIELD].width, \
> +                              reg_field_info[FIELD].offset))
> +
> +/* PPD (physical page descriptor) */
> +static inline uint64_t GET_PPD(uint64_t entry)
> +{
> +    return GET_TLB_FIELD(entry, PTE_PPD) |
> +        (GET_TLB_FIELD(entry, PTE_PA35) << reg_field_info[PTE_PPD].width);
> +}
> +
> +#define NO_ASID      (1 << 8)
> +
> +typedef enum {
> +    PGSIZE_4K,
> +    PGSIZE_16K,
> +    PGSIZE_64K,
> +    PGSIZE_256K,
> +    PGSIZE_1M,
> +    PGSIZE_4M,
> +    PGSIZE_16M,
> +    PGSIZE_64M,
> +    PGSIZE_256M,
> +    PGSIZE_1G,
> +    NUM_PGSIZE_TYPES

Is NUM_PGSIZE_TYPES part of the enum?

> +} tlb_pgsize_t;
> +
> +static const char *pgsize_str[NUM_PGSIZE_TYPES] = {
> +    "4K",
> +    "16K",
> +    "64K",
> +    "256K",
> +    "1M",
> +    "4M",
> +    "16M",
> +    "64M",
> +    "256M",
> +    "1G",
> +};
> +
> +#define INVALID_MASK 0xffffffffLL
> +
> +static const uint64_t encmask_2_mask[] = {
> +    0x0fffLL,                           /* 4k,   0000 */
> +    0x3fffLL,                           /* 16k,  0001 */
> +    0xffffLL,                           /* 64k,  0010 */
> +    0x3ffffLL,                          /* 256k, 0011 */
> +    0xfffffLL,                          /* 1m,   0100 */
> +    0x3fffffLL,                         /* 4m,   0101 */
> +    0xffffffLL,                         /* 16m,  0110 */
> +    0x3ffffffLL,                        /* 64m,  0111 */
> +    0xfffffffLL,                        /* 256m, 1000 */
> +    0x3fffffffLL,                       /* 1g,   1001 */
> +    INVALID_MASK,                      /* RSVD, 0111 */
> +};
> +
> +/*
> + * @return the page size type from @a entry.
> + */
> +static inline tlb_pgsize_t hex_tlb_pgsize_type(uint64_t entry)
> +{
> +    if (entry == 0) {
> +        qemu_log_mask(CPU_LOG_MMU, "%s: Supplied TLB entry was 0!\n", __func__);
> +        return 0;
> +    }
> +    tlb_pgsize_t size = ctz64(entry);
> +    g_assert(size < NUM_PGSIZE_TYPES);
> +    return size;
> +}
> +
> +/*
> + * @return the page size of @a entry, in bytes.
> + */
> +static inline uint64_t hex_tlb_page_size_bytes(uint64_t entry)
> +{
> +    return 1ull << (TARGET_PAGE_BITS + 2 * hex_tlb_pgsize_type(entry));
> +}
> +
> +static inline uint64_t hex_tlb_phys_page_num(uint64_t entry)
> +{
> +    uint32_t ppd = GET_PPD(entry);
> +    return ppd >> 1;
> +}
> +
> +static inline uint64_t hex_tlb_phys_addr(uint64_t entry)
> +{
> +    uint64_t pagemask = encmask_2_mask[hex_tlb_pgsize_type(entry)];
> +    uint64_t pagenum = hex_tlb_phys_page_num(entry);
> +    uint64_t PA = (pagenum << TARGET_PAGE_BITS) & (~pagemask);
> +    return PA;
> +}
> +
> +static inline uint64_t hex_tlb_virt_addr(uint64_t entry)
> +{
> +    return (uint64_t)GET_TLB_FIELD(entry, PTE_VPN) << TARGET_PAGE_BITS;

return vaddr type?

> +}
> +
> +static bool hex_dump_mmu_entry(FILE *f, uint64_t entry)
> +{
> +    if (GET_TLB_FIELD(entry, PTE_V)) {
> +        fprintf(f, "0x%016" PRIx64 ": ", entry);
> +        uint64_t PA = hex_tlb_phys_addr(entry);
> +        uint64_t VA = hex_tlb_virt_addr(entry);
> +        fprintf(f, "V:%" PRId64 " G:%" PRId64 " A1:%" PRId64 " A0:%" PRId64,
> +                GET_TLB_FIELD(entry, PTE_V), GET_TLB_FIELD(entry, PTE_G),
> +                GET_TLB_FIELD(entry, PTE_ATR1), GET_TLB_FIELD(entry, PTE_ATR0));
> +        fprintf(f, " ASID:0x%02" PRIx64 " VA:0x%08" PRIx64,
> +                GET_TLB_FIELD(entry, PTE_ASID), VA);
> +        fprintf(f,
> +                " X:%" PRId64 " W:%" PRId64 " R:%" PRId64 " U:%" PRId64
> +                " C:%" PRId64,
> +                GET_TLB_FIELD(entry, PTE_X), GET_TLB_FIELD(entry, PTE_W),
> +                GET_TLB_FIELD(entry, PTE_R), GET_TLB_FIELD(entry, PTE_U),
> +                GET_TLB_FIELD(entry, PTE_C));
> +        fprintf(f, " PA:0x%09" PRIx64 " SZ:%s (0x%" PRIx64 ")", PA,
> +                pgsize_str[hex_tlb_pgsize_type(entry)],
> +                hex_tlb_page_size_bytes(entry));
> +        fprintf(f, "\n");
> +        return true;
> +    }
> +
> +    /* Not valid */
> +    return false;
> +}
> +
> +void dump_mmu(CPUHexagonState *env)
> +{
> +    int i;
> +
> +    HexagonCPU *cpu = env_archcpu(env);
> +    for (i = 0; i < cpu->num_tlbs; i++) {
> +        uint64_t entry = env->hex_tlb->entries[i];
> +        if (GET_TLB_FIELD(entry, PTE_V)) {
> +            qemu_printf("0x%016" PRIx64 ": ", entry);
> +            uint64_t PA = hex_tlb_phys_addr(entry);
> +            uint64_t VA = hex_tlb_virt_addr(entry);
> +            qemu_printf(
> +                "V:%" PRId64 " G:%" PRId64 " A1:%" PRId64 " A0:%" PRId64,
> +                GET_TLB_FIELD(entry, PTE_V), GET_TLB_FIELD(entry, PTE_G),
> +                GET_TLB_FIELD(entry, PTE_ATR1), GET_TLB_FIELD(entry, PTE_ATR0));
> +            qemu_printf(" ASID:0x%02" PRIx64 " VA:0x%08" PRIx64,
> +                        GET_TLB_FIELD(entry, PTE_ASID), VA);
> +            qemu_printf(
> +                " X:%" PRId64 " W:%" PRId64 " R:%" PRId64 " U:%" PRId64
> +                " C:%" PRId64,
> +                GET_TLB_FIELD(entry, PTE_X), GET_TLB_FIELD(entry, PTE_W),
> +                GET_TLB_FIELD(entry, PTE_R), GET_TLB_FIELD(entry, PTE_U),
> +                GET_TLB_FIELD(entry, PTE_C));
> +            qemu_printf(" PA:0x%09" PRIx64 " SZ:%s (0x%" PRIx64 ")", PA,
> +                        pgsize_str[hex_tlb_pgsize_type(entry)],
> +                        hex_tlb_page_size_bytes(entry));
> +            qemu_printf("\n");
> +        }
> +    }
> +}
> +
> +static inline void hex_log_tlbw(uint32_t index, uint64_t entry)
> +{
> +    if (qemu_loglevel_mask(CPU_LOG_MMU)) {
> +        if (qemu_log_enabled()) {
> +            FILE *logfile = qemu_log_trylock();
> +            if (logfile) {
> +                fprintf(logfile, "tlbw[%03d]: ", index);
> +                if (!hex_dump_mmu_entry(logfile, entry)) {
> +                    fprintf(logfile, "invalid\n");
> +                }
> +                qemu_log_unlock(logfile);
> +            }
> +        }
> +    }
> +}
> +
> +void hex_tlbw(CPUHexagonState *env, uint32_t index, uint64_t value)
> +{
> +    uint32_t myidx = fTLB_NONPOW2WRAP(fTLB_IDXMASK(index));
> +    bool old_entry_valid = GET_TLB_FIELD(env->hex_tlb->entries[myidx], PTE_V);
> +    if (old_entry_valid && hexagon_cpu_mmu_enabled(env)) {
> +        CPUState *cs = env_cpu(env);
> +
> +        tlb_flush(cs);
> +    }
> +    env->hex_tlb->entries[myidx] = (value);
> +    hex_log_tlbw(myidx, value);
> +}
> +
> +void hex_mmu_realize(CPUHexagonState *env)
> +{
> +    CPUState *cs = env_cpu(env);
> +    if (cs->cpu_index == 0) {

Problem with heterogeneous emulation.

> +        env->hex_tlb = g_malloc0(sizeof(CPUHexagonTLBContext));
> +    } else {
> +        CPUState *cpu0_s = NULL;
> +        CPUHexagonState *env0 = NULL;
> +        CPU_FOREACH(cpu0_s) {
> +            assert(cpu0_s->cpu_index == 0);
> +            env0 = &(HEXAGON_CPU(cpu0_s)->env);
> +            break;
> +        }
> +        env->hex_tlb = env0->hex_tlb;
> +    }
> +}
> +
> +void hex_mmu_on(CPUHexagonState *env)
> +{
> +    CPUState *cs = env_cpu(env);
> +    qemu_log_mask(CPU_LOG_MMU, "Hexagon MMU turned on!\n");
> +    tlb_flush(cs);
> +}
> +
> +void hex_mmu_off(CPUHexagonState *env)
> +{
> +    CPUState *cs = env_cpu(env);
> +    qemu_log_mask(CPU_LOG_MMU, "Hexagon MMU turned off!\n");
> +    tlb_flush(cs);
> +}
> +
> +void hex_mmu_mode_change(CPUHexagonState *env)
> +{
> +    qemu_log_mask(CPU_LOG_MMU, "Hexagon mode change!\n");
> +    CPUState *cs = env_cpu(env);
> +    tlb_flush(cs);
> +}
> +
> +static inline bool hex_tlb_entry_match_noperm(uint64_t entry, uint32_t asid,
> +                                              uint64_t VA)
> +{
> +    if (GET_TLB_FIELD(entry, PTE_V)) {
> +        if (GET_TLB_FIELD(entry, PTE_G)) {
> +            /* Global entry - ingnore ASID */
> +        } else if (asid != NO_ASID) {
> +            uint32_t tlb_asid = GET_TLB_FIELD(entry, PTE_ASID);
> +            if (tlb_asid != asid) {
> +                return false;
> +            }
> +        }
> +
> +        uint64_t page_size = hex_tlb_page_size_bytes(entry);
> +        uint64_t page_start =
> +            ROUND_DOWN(hex_tlb_virt_addr(entry), page_size);
> +        if (page_start <= VA && VA < page_start + page_size) {
> +            return true;
> +        }
> +    }
> +    return false;
> +}
> +
> +static inline void hex_tlb_entry_get_perm(CPUHexagonState *env, uint64_t entry,
> +                                          MMUAccessType access_type,
> +                                          int mmu_idx, int *prot,
> +                                          int32_t *excp)
> +{
> +    g_assert_not_reached();
> +}
> +
> +static inline bool hex_tlb_entry_match(CPUHexagonState *env, uint64_t entry,
> +                                       uint8_t asid, target_ulong VA,
> +                                       MMUAccessType access_type, hwaddr *PA,
> +                                       int *prot, int *size, int32_t *excp,
> +                                       int mmu_idx)
> +{
> +    if (hex_tlb_entry_match_noperm(entry, asid, VA)) {
> +        hex_tlb_entry_get_perm(env, entry, access_type, mmu_idx, prot, excp);
> +        *PA = hex_tlb_phys_addr(entry);
> +        *size = hex_tlb_page_size_bytes(entry);
> +        return true;
> +    }
> +    return false;
> +}
> +
> +bool hex_tlb_find_match(CPUHexagonState *env, target_ulong VA,
> +                        MMUAccessType access_type, hwaddr *PA, int *prot,
> +                        int *size, int32_t *excp, int mmu_idx)
> +{
> +    *PA = 0;
> +    *prot = 0;
> +    *size = 0;
> +    *excp = 0;
> +    uint32_t ssr = arch_get_system_reg(env, HEX_SREG_SSR);
> +    uint8_t asid = GET_SSR_FIELD(SSR_ASID, ssr);
> +    int i;
> +    HexagonCPU *cpu = env_archcpu(env);
> +    for (i = 0; i < cpu->num_tlbs; i++) {
> +        uint64_t entry = env->hex_tlb->entries[i];
> +        if (hex_tlb_entry_match(env, entry, asid, VA, access_type, PA, prot,
> +                                size, excp, mmu_idx)) {
> +            return true;
> +        }
> +    }
> +    return false;
> +}
> +
> +static uint32_t hex_tlb_lookup_by_asid(CPUHexagonState *env, uint32_t asid,
> +                                       uint32_t VA)
> +{
> +    g_assert_not_reached();
> +}
> +
> +/* Called from tlbp instruction */
> +uint32_t hex_tlb_lookup(CPUHexagonState *env, uint32_t ssr, uint32_t VA)
> +{
> +    return hex_tlb_lookup_by_asid(env, GET_SSR_FIELD(SSR_ASID, ssr), VA);
> +}
> +
> +static bool hex_tlb_is_match(CPUHexagonState *env,
> +                             uint64_t entry1, uint64_t entry2,
> +                             bool consider_gbit)
> +{
> +    bool valid1 = GET_TLB_FIELD(entry1, PTE_V);
> +    bool valid2 = GET_TLB_FIELD(entry2, PTE_V);
> +    uint64_t size1 = hex_tlb_page_size_bytes(entry1);
> +    uint64_t vaddr1 = ROUND_DOWN(hex_tlb_virt_addr(entry1), size1);
> +    uint64_t size2 = hex_tlb_page_size_bytes(entry2);
> +    uint64_t vaddr2 = ROUND_DOWN(hex_tlb_virt_addr(entry2), size2);
> +    int asid1 = GET_TLB_FIELD(entry1, PTE_ASID);
> +    int asid2 = GET_TLB_FIELD(entry2, PTE_ASID);
> +    bool gbit1 = GET_TLB_FIELD(entry1, PTE_G);
> +    bool gbit2 = GET_TLB_FIELD(entry2, PTE_G);
> +
> +    if (!valid1 || !valid2) {
> +        return false;
> +    }
> +
> +    if (((vaddr1 <= vaddr2) && (vaddr2 < (vaddr1 + size1))) ||
> +        ((vaddr2 <= vaddr1) && (vaddr1 < (vaddr2 + size2)))) {
> +        if (asid1 == asid2) {
> +            return true;
> +        }
> +        if ((consider_gbit && gbit1) || gbit2) {
> +            return true;
> +        }
> +    }
> +    return false;
> +}
> +
> +/*
> + * Return codes:
> + * 0 or positive             index of match
> + * -1                        multiple matches
> + * -2                        no match
> + */
> +int hex_tlb_check_overlap(CPUHexagonState *env, uint64_t entry, uint64_t index)
> +{
> +    int matches = 0;
> +    int last_match = 0;
> +    int i;
> +
> +    HexagonCPU *cpu = env_archcpu(env);
> +    for (i = 0; i < cpu->num_tlbs; i++) {
> +        if (hex_tlb_is_match(env, entry, env->hex_tlb->entries[i], false)) {
> +            matches++;
> +            last_match = i;
> +        }
> +    }
> +
> +    if (matches == 1) {
> +        return last_match;
> +    }
> +    if (matches == 0) {
> +        return -2;
> +    }
> +    return -1;
> +}
> +
> +static inline void print_thread(const char *str, CPUState *cs)
> +{
> +    g_assert(bql_locked());
> +    CPUHexagonState *thread = cpu_env(cs);
> +    bool is_stopped = cpu_is_stopped(cs);
> +    int exe_mode = get_exe_mode(thread);
> +    hex_lock_state_t lock_state = thread->tlb_lock_state;
> +    qemu_log_mask(CPU_LOG_MMU,
> +           "%s: threadId = %d: %s, exe_mode = %s, tlb_lock_state = %s\n",
> +           str,
> +           thread->threadId,
> +           is_stopped ? "stopped" : "running",
> +           exe_mode == HEX_EXE_MODE_OFF ? "off" :
> +           exe_mode == HEX_EXE_MODE_RUN ? "run" :
> +           exe_mode == HEX_EXE_MODE_WAIT ? "wait" :
> +           exe_mode == HEX_EXE_MODE_DEBUG ? "debug" :
> +           "unknown",
> +           lock_state == HEX_LOCK_UNLOCKED ? "unlocked" :
> +           lock_state == HEX_LOCK_WAITING ? "waiting" :
> +           lock_state == HEX_LOCK_OWNER ? "owner" :
> +           "unknown");
> +}
> +
> +static inline void print_thread_states(const char *str)
> +{
> +    CPUState *cs;
> +    CPU_FOREACH(cs) {

Ditto heterogeneous emulation.

> +        print_thread(str, cs);
> +    }
> +}
> +
> +void hex_tlb_lock(CPUHexagonState *env)
> +{
> +    qemu_log_mask(CPU_LOG_MMU, "hex_tlb_lock: %d\n", env->threadId);
> +    BQL_LOCK_GUARD();
> +    g_assert((env->tlb_lock_count == 0) || (env->tlb_lock_count == 1));
> +
> +    uint32_t syscfg = arch_get_system_reg(env, HEX_SREG_SYSCFG);
> +    uint8_t tlb_lock = GET_SYSCFG_FIELD(SYSCFG_TLBLOCK, syscfg);
> +    if (tlb_lock) {
> +        if (env->tlb_lock_state == HEX_LOCK_QUEUED) {
> +            env->next_PC += 4;
> +            env->tlb_lock_count++;
> +            env->tlb_lock_state = HEX_LOCK_OWNER;
> +            SET_SYSCFG_FIELD(env, SYSCFG_TLBLOCK, 1);
> +            return;
> +        }
> +        if (env->tlb_lock_state == HEX_LOCK_OWNER) {
> +            qemu_log_mask(CPU_LOG_MMU | LOG_GUEST_ERROR,
> +                          "Double tlblock at PC: 0x%x, thread may hang\n",
> +                          env->next_PC);
> +            env->next_PC += 4;
> +            CPUState *cs = env_cpu(env);
> +            cpu_interrupt(cs, CPU_INTERRUPT_HALT);
> +            return;
> +        }
> +        env->tlb_lock_state = HEX_LOCK_WAITING;
> +        CPUState *cs = env_cpu(env);
> +        cpu_interrupt(cs, CPU_INTERRUPT_HALT);
> +    } else {
> +        env->next_PC += 4;
> +        env->tlb_lock_count++;
> +        env->tlb_lock_state = HEX_LOCK_OWNER;
> +        SET_SYSCFG_FIELD(env, SYSCFG_TLBLOCK, 1);
> +    }
> +
> +    if (qemu_loglevel_mask(CPU_LOG_MMU)) {
> +        qemu_log_mask(CPU_LOG_MMU, "Threads after hex_tlb_lock:\n");
> +        print_thread_states("\tThread");
> +    }
> +}
> +
> +void hex_tlb_unlock(CPUHexagonState *env)
> +{
> +    BQL_LOCK_GUARD();
> +    g_assert((env->tlb_lock_count == 0) || (env->tlb_lock_count == 1));
> +
> +    /* Nothing to do if the TLB isn't locked by this thread */
> +    uint32_t syscfg = arch_get_system_reg(env, HEX_SREG_SYSCFG);
> +    uint8_t tlb_lock = GET_SYSCFG_FIELD(SYSCFG_TLBLOCK, syscfg);
> +    if ((tlb_lock == 0) ||
> +        (env->tlb_lock_state != HEX_LOCK_OWNER)) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "thread %d attempted to tlbunlock without having the "
> +                      "lock, tlb_lock state = %d\n",
> +                      env->threadId, env->tlb_lock_state);
> +        g_assert(env->tlb_lock_state != HEX_LOCK_WAITING);
> +        return;
> +    }
> +
> +    env->tlb_lock_count--;
> +    env->tlb_lock_state = HEX_LOCK_UNLOCKED;
> +    SET_SYSCFG_FIELD(env, SYSCFG_TLBLOCK, 0);
> +
> +    /* Look for a thread to unlock */
> +    unsigned int this_threadId = env->threadId;
> +    CPUHexagonState *unlock_thread = NULL;
> +    CPUState *cs;
> +    CPU_FOREACH(cs) {

Ditto.

> +        CPUHexagonState *thread = cpu_env(cs);
> +
> +        /*
> +         * The hardware implements round-robin fairness, so we look for threads
> +         * starting at env->threadId + 1 and incrementing modulo the number of
> +         * threads.
> +         *
> +         * To implement this, we check if thread is a earlier in the modulo
> +         * sequence than unlock_thread.
> +         *     if unlock thread is higher than this thread
> +         *         thread must be between this thread and unlock_thread
> +         *     else
> +         *         thread higher than this thread is ahead of unlock_thread
> +         *         thread must be lower then unlock thread
> +         */
> +        if (thread->tlb_lock_state == HEX_LOCK_WAITING) {
> +            if (!unlock_thread) {
> +                unlock_thread = thread;
> +            } else if (unlock_thread->threadId > this_threadId) {
> +                if (this_threadId < thread->threadId &&
> +                    thread->threadId < unlock_thread->threadId) {
> +                    unlock_thread = thread;
> +                }
> +            } else {
> +                if (thread->threadId > this_threadId) {
> +                    unlock_thread = thread;
> +                }
> +                if (thread->threadId < unlock_thread->threadId) {
> +                    unlock_thread = thread;
> +                }
> +            }
> +        }
> +    }

