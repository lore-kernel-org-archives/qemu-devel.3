Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ACEBC28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 17:05:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsPW2-0003Jy-7n; Wed, 12 Mar 2025 13:05:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tsPVp-00039S-ES
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 13:05:01 -0400
Received: from mail-qv1-xf2b.google.com ([2607:f8b0:4864:20::f2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tsPVl-0008PT-8y
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 13:04:57 -0400
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6e89a2501a0so1117496d6.1
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 10:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741799091; x=1742403891; darn=nongnu.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=HxJH9s9vvPp7ZlWWxtPX+0xAe6mjh56RlGe8V40aTVE=;
 b=GoGzBwkndjxXVldH9uYsNK82m0rbFVrClH9thi2dC6XXOBlNA5wKWP6Xkbmbqsdb9K
 tlCiFU2vYdsqwaD7F8MMWpne95qbzmpk78eKwHUAnkguE7LgahR1qDmgQAdY1qz2tUXZ
 uMRYq1L8mXIsu1j544RggANAfJxdQ3bxFG2eEwji/iyd6lxvTo+iJ3INIMP1O7YqHK4t
 gzpdB97nrOd7zvsf062vxAkM0x3cEcW8b+B3KRS5hUgi/fpfLLp5V1SP3nA2YWyknTI/
 o2QAif03tLjFB6/5g+M+hVXEbWdidiTqjHYMlge4SM75AqVlI6/CaOB8nA6nu4477VUS
 EDDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741799091; x=1742403891;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HxJH9s9vvPp7ZlWWxtPX+0xAe6mjh56RlGe8V40aTVE=;
 b=IrVGFp+rjpLzSn6nli4laX50TF2BW+suR/xCnkMPP8vIeM/TxpeEfFbGEB+oQ9Jh9e
 8DIBfUqlYgbAKLRH9NuVSOsEPFtVecEzr9DFg1wl32j6oLwbjsGAsR5tdBbUuP1GkQyB
 hDqtJGjKIcKEx+hU/OgRFD9lgmQgZ7eHaB4l/U20MyN+FzJBsTMm1aQ+JrBYJD3XcZaj
 GTIOGL7ibloT1bT87Pwx5stY1LobdSBBt56nMP/+feVg6kFxwWeZRoKFUkHmBBVyzULk
 tDrBZ40aodzKCGN1eEoersztSglPR/bv4UrNL3hWjCO5/aE06OWgufs5T/ywsUPHbvDd
 7cyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOABRla/9knFwGs4phOrCth1hN1ttHTu3vnNm7ioUUP3aqhghxZ1yPOffjDH5ock9PLinyQv/jZPZy@nongnu.org
X-Gm-Message-State: AOJu0Yxa47tRZzJ/zGfWQ4NoNdRynX4vw/UaaHaHFOOEsp2fCpU3HJ37
 Oe/hzyhHy9pAq8UknYMfr+2YAHo73CavSFI138uCdTsEoelKnlvT
X-Gm-Gg: ASbGncsqgAmXN6QHROgrqb1HG2yD6DWa6F8CD0CIx+jbllV4W9kqBQgXz+SKLH85WdO
 IlaxsSIjZQSG6VRXbW8fBL3cbcfesonv1JcqmAxMI210ZAhiQyYlTPn86sIHFsXua9igdGIC63V
 3GLdt+1AEYwYXHxJ+sHu3+tiGy3rAzLjmfN9CpGeGEowuAKr/t+CR8lqgeWwtxZ1OXFOPKDtMZ9
 xB6Y8JHQxymllSRDsyeLq7CdHpYDp6wIDMyGFA2ho+WJkcI18x+sutriIwdpDhmEekQvu15TgSb
 Jl8lZzMfzCeI3KIKnDA1DHeoUW1mHl9r02QvXLop3+2c6RTMEdZP21dRNdRc4dM=
X-Google-Smtp-Source: AGHT+IFJvniWsOloYoz5VDEQUi1dGgpdrF9Y8lxiVefMZSdFyuRkDpJbmTbkL/vhrj9CRcODz7y/Vw==
X-Received: by 2002:a05:6214:258f:b0:6e8:86d3:be73 with SMTP id
 6a1803df08f44-6e900693295mr373915616d6.37.1741799091105; 
 Wed, 12 Mar 2025 10:04:51 -0700 (PDT)
Received: from DESKTOPUU50BPD ([2603:6000:a500:306:9cc3:cdb3:7013:e1db])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e8f71709aesm86301596d6.116.2025.03.12.10.04.49
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 12 Mar 2025 10:04:50 -0700 (PDT)
From: <ltaylorsimpson@gmail.com>
To: "'Brian Cain'" <brian.cain@oss.qualcomm.com>,
	<qemu-devel@nongnu.org>
Cc: <richard.henderson@linaro.org>, <philmd@linaro.org>,
 <quic_mathbern@quicinc.com>, <ale@rev.ng>, <anjo@rev.ng>,
 <quic_mliebel@quicinc.com>, <alex.bennee@linaro.org>,
 <quic_mburton@quicinc.com>, <sidneym@quicinc.com>,
 "'Brian Cain'" <bcain@quicinc.com>,
 "'Michael Lambert'" <mlambert@quicinc.com>
References: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
 <20250301052628.1011210-35-brian.cain@oss.qualcomm.com>
In-Reply-To: <20250301052628.1011210-35-brian.cain@oss.qualcomm.com>
Subject: RE: [PATCH 34/38] target/hexagon: Add initial MMU model
Date: Wed, 12 Mar 2025 12:04:49 -0500
Message-ID: <011101db9370$ddebf410$99c3dc30$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQERX/uiI+LG127bCFnOJB03IqEGrgFdV9mmtPks0oA=
Content-Language: en-us
X-Antivirus: Norton (VPS 250312-2, 3/12/2025), Outbound message
X-Antivirus-Status: Clean
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2b;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-qv1-xf2b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



> -----Original Message-----
> From: Brian Cain <brian.cain@oss.qualcomm.com>
> Sent: Friday, February 28, 2025 11:26 PM
> To: qemu-devel@nongnu.org
> Cc: brian.cain@oss.qualcomm.com; richard.henderson@linaro.org;
> philmd@linaro.org; quic_mathbern@quicinc.com; ale@rev.ng; anjo@rev.ng;
> quic_mliebel@quicinc.com; ltaylorsimpson@gmail.com;
> alex.bennee@linaro.org; quic_mburton@quicinc.com;
> sidneym@quicinc.com; Brian Cain <bcain@quicinc.com>; Michael Lambert
> <mlambert@quicinc.com>
> Subject: [PATCH 34/38] target/hexagon: Add initial MMU model
>=20
> From: Brian Cain <bcain@quicinc.com>
>=20
> Co-authored-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> Co-authored-by: Michael Lambert <mlambert@quicinc.com>
> Co-authored-by: Sid Manning <sidneym@quicinc.com>
> Co-authored-by: Matheus Tavares Bernardino
> <quic_mathbern@quicinc.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>


> diff --git a/target/hexagon/hex_mmu.c b/target/hexagon/hex_mmu.c new
> file mode 100644 index 0000000000..54c4ba2dbf
> --- /dev/null
> +++ b/target/hexagon/hex_mmu.c
> @@ -0,0 +1,528 @@
> +/*
> + * Copyright(c) 2019-2025 Qualcomm Innovation Center, Inc. All Rights
> Reserved.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later  */
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
> +static inline uint64_t GET_PPD(uint64_t entry) {
> +    return GET_TLB_FIELD(entry, PTE_PPD) |
> +        (GET_TLB_FIELD(entry, PTE_PA35) <<
> +reg_field_info[PTE_PPD].width); }
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
> +} tlb_pgsize_t;
> +
> +static const char *pgsize_str[NUM_PGSIZE_TYPES] =3D {
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
> +static const uint64_t encmask_2_mask[] =3D {
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
> +static inline tlb_pgsize_t hex_tlb_pgsize_type(uint64_t entry) {
> +    if (entry =3D=3D 0) {
> +        qemu_log_mask(CPU_LOG_MMU, "%s: Supplied TLB entry was 0!\n",
> __func__);
> +        return 0;
> +    }
> +    tlb_pgsize_t size =3D ctz64(entry);
> +    g_assert(size < NUM_PGSIZE_TYPES);
> +    return size;
> +}
> +
> +/*
> + * @return the page size of @a entry, in bytes.
> + */
> +static inline uint64_t hex_tlb_page_size_bytes(uint64_t entry) {
> +    return 1ull << (TARGET_PAGE_BITS + 2 * =
hex_tlb_pgsize_type(entry));
> +}
> +
> +static inline uint64_t hex_tlb_phys_page_num(uint64_t entry) {
> +    uint32_t ppd =3D GET_PPD(entry);
> +    return ppd >> 1;
> +}
> +
> +static inline uint64_t hex_tlb_phys_addr(uint64_t entry) {
> +    uint64_t pagemask =3D encmask_2_mask[hex_tlb_pgsize_type(entry)];
> +    uint64_t pagenum =3D hex_tlb_phys_page_num(entry);
> +    uint64_t PA =3D (pagenum << TARGET_PAGE_BITS) & (~pagemask);
> +    return PA;
> +}
> +
> +static inline uint64_t hex_tlb_virt_addr(uint64_t entry) {
> +    return (uint64_t)GET_TLB_FIELD(entry, PTE_VPN) <<
> TARGET_PAGE_BITS;
> +}
> +
> +static bool hex_dump_mmu_entry(FILE *f, uint64_t entry) {
> +    if (GET_TLB_FIELD(entry, PTE_V)) {
> +        fprintf(f, "0x%016" PRIx64 ": ", entry);
> +        uint64_t PA =3D hex_tlb_phys_addr(entry);
> +        uint64_t VA =3D hex_tlb_virt_addr(entry);
> +        fprintf(f, "V:%" PRId64 " G:%" PRId64 " A1:%" PRId64 " A0:%" =
PRId64,
> +                GET_TLB_FIELD(entry, PTE_V), GET_TLB_FIELD(entry, =
PTE_G),
> +                GET_TLB_FIELD(entry, PTE_ATR1), GET_TLB_FIELD(entry,
> PTE_ATR0));
> +        fprintf(f, " ASID:0x%02" PRIx64 " VA:0x%08" PRIx64,
> +                GET_TLB_FIELD(entry, PTE_ASID), VA);
> +        fprintf(f,
> +                " X:%" PRId64 " W:%" PRId64 " R:%" PRId64 " U:%" =
PRId64
> +                " C:%" PRId64,
> +                GET_TLB_FIELD(entry, PTE_X), GET_TLB_FIELD(entry, =
PTE_W),
> +                GET_TLB_FIELD(entry, PTE_R), GET_TLB_FIELD(entry, =
PTE_U),
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
> +    HexagonCPU *cpu =3D env_archcpu(env);
> +    for (i =3D 0; i < cpu->num_tlbs; i++) {
> +        uint64_t entry =3D env->hex_tlb->entries[i];
> +        if (GET_TLB_FIELD(entry, PTE_V)) {
> +            qemu_printf("0x%016" PRIx64 ": ", entry);
> +            uint64_t PA =3D hex_tlb_phys_addr(entry);
> +            uint64_t VA =3D hex_tlb_virt_addr(entry);
> +            qemu_printf(
> +                "V:%" PRId64 " G:%" PRId64 " A1:%" PRId64 " A0:%" =
PRId64,
> +                GET_TLB_FIELD(entry, PTE_V), GET_TLB_FIELD(entry, =
PTE_G),
> +                GET_TLB_FIELD(entry, PTE_ATR1), GET_TLB_FIELD(entry,
> PTE_ATR0));
> +            qemu_printf(" ASID:0x%02" PRIx64 " VA:0x%08" PRIx64,
> +                        GET_TLB_FIELD(entry, PTE_ASID), VA);
> +            qemu_printf(
> +                " X:%" PRId64 " W:%" PRId64 " R:%" PRId64 " U:%" =
PRId64
> +                " C:%" PRId64,
> +                GET_TLB_FIELD(entry, PTE_X), GET_TLB_FIELD(entry, =
PTE_W),
> +                GET_TLB_FIELD(entry, PTE_R), GET_TLB_FIELD(entry, =
PTE_U),
> +                GET_TLB_FIELD(entry, PTE_C));
> +            qemu_printf(" PA:0x%09" PRIx64 " SZ:%s (0x%" PRIx64 ")", =
PA,
> +                        pgsize_str[hex_tlb_pgsize_type(entry)],
> +                        hex_tlb_page_size_bytes(entry));
> +            qemu_printf("\n");

Use hex_dump_mmu_entry instead.

> +        }
> +    }
> +}
> +
> +static inline void hex_log_tlbw(uint32_t index, uint64_t entry) {
> +    if (qemu_loglevel_mask(CPU_LOG_MMU)) {
> +        if (qemu_log_enabled()) {
> +            FILE *logfile =3D qemu_log_trylock();
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
> +void hex_tlbw(CPUHexagonState *env, uint32_t index, uint64_t value) {
> +    uint32_t myidx =3D fTLB_NONPOW2WRAP(fTLB_IDXMASK(index));
> +    bool old_entry_valid =3D =
GET_TLB_FIELD(env->hex_tlb->entries[myidx],
> PTE_V);
> +    if (old_entry_valid && hexagon_cpu_mmu_enabled(env)) {
> +        CPUState *cs =3D env_cpu(env);
> +
> +        tlb_flush(cs);
> +    }
> +    env->hex_tlb->entries[myidx] =3D (value);
> +    hex_log_tlbw(myidx, value);
> +}
> +
> +void hex_mmu_realize(CPUHexagonState *env) {
> +    CPUState *cs =3D env_cpu(env);
> +    if (cs->cpu_index =3D=3D 0) {
> +        env->hex_tlb =3D g_malloc0(sizeof(CPUHexagonTLBContext));
> +    } else {
> +        CPUState *cpu0_s =3D NULL;
> +        CPUHexagonState *env0 =3D NULL;
> +        CPU_FOREACH(cpu0_s) {
> +            assert(cpu0_s->cpu_index =3D=3D 0);
> +            env0 =3D &(HEXAGON_CPU(cpu0_s)->env);
> +            break;
> +        }

Seems fragile to assume cpu_index =3D=3D 0 will be first in CPU_FOREACH. =
 This would be better
    CPU_FOREACH(cpu0_s) {
        if (cpu0_s->cpu_index =3D=3D 0) {
            env0 =3D &(HEXAGON_CPU(cpu0_s)->env);
            break;
        }
    }
    g_assert(env0);  /* Make sure we found it */


> +        env->hex_tlb =3D env0->hex_tlb;
> +    }
> +}


> diff --git a/target/hexagon/meson.build b/target/hexagon/meson.build
> index 3ec53010fa..aa729a3683 100644
> --- a/target/hexagon/meson.build
> +++ b/target/hexagon/meson.build
> @@ -273,7 +273,8 @@ hexagon_ss.add(files(
>  #     idef-generated-enabled-instructions
>  #
>  idef_parser_enabled =3D get_option('hexagon_idef_parser') -if
> idef_parser_enabled and 'hexagon-linux-user' in target_dirs
> +if idef_parser_enabled and ('hexagon-linux-user' in target_dirs or
> +                            'hexagon-softmmu' in target_dirs)
>      idef_parser_input_generated =3D custom_target(
>          'idef_parser_input.h.inc',
>          output: 'idef_parser_input.h.inc',

Move this to later patch "add build config for softmmu"




