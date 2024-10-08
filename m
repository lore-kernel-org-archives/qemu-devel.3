Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7254CED258
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 02:56:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sy0ON-0008Pj-2q; Mon, 07 Oct 2024 22:56:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sy0OL-0008PQ-NL; Mon, 07 Oct 2024 22:56:05 -0400
Received: from mail-vk1-xa31.google.com ([2607:f8b0:4864:20::a31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sy0OI-0000po-PB; Mon, 07 Oct 2024 22:56:05 -0400
Received: by mail-vk1-xa31.google.com with SMTP id
 71dfb90a1353d-50792ed3b0bso1571085e0c.1; 
 Mon, 07 Oct 2024 19:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728356160; x=1728960960; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2UzALMQHjDeQZ/cA6IpiJORlJbmPsQ0X20YCpMAnQaw=;
 b=YjRyj7dZ4RpdRoCKPshksL5o0h2jmnNIOKZFmWRkLGOCKd8ulCT9+X64UMKshuKElV
 v+tRZZ5utjWnVEtz+50b7Pd4z3MAQSoH0jQX8EhK8CKhnx6X/GwK/4Ut4elNzSZjitp8
 qgCCoVnTmXnEorbnPn7tmLzEmUlDyomrcOh/bGzNCoQYWCagcJgU6BwYybxzrVS8fqXW
 sSJryqH0RLoCO+G5xxNrjJAf8cP2O25tvfPehbvLa7TXF9dgfGWUIMHVAJF2/HJhPRrz
 nlZ6Rr6BifuAIrhIScNcV99dPqURsCIZ7QaplaNBG5ZB9pjpOj4sLJ1OkmwRNJS8FSC2
 DgJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728356160; x=1728960960;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2UzALMQHjDeQZ/cA6IpiJORlJbmPsQ0X20YCpMAnQaw=;
 b=lEn8Nkmd2GwPW3Bs1vngnvryqKBEnrTpf334/gAkxT3FTC6UNg1Nz3S5SHxGg6z7u0
 Itze6sqTZMwRC249qHcgEo8BQyE4HgLLTj1UQlYgJcOEGpaeV7TWa/6/8+YO9FCTvw0N
 jCEDBwT5dSUYQxGOBckCpWSPEg+ZXPdtyOJ6kc6viWk3i29ZwQLh/3coshQNnfUl7FhK
 rCzQM4VMWZ3KAM3HEMwrWsoHhEDSvCU5V6Kbak6FkKiwhxot6n8+HpSWPOD9RZqiV2AV
 2HiGUcIHWlmWLsMsfFWlIjj7nc5na9vA6xJ8XufSsfR0UpjO1E1Ml9HgN+CDz6svqDWf
 DoDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNAWEeurTtIbNQd8GvV4hfWOs+zb5nJ9ByC4kXDBcxbDIuNs08y/lQ60m4c9Q/oMqWTYqgOyFHlE/MlQ==@nongnu.org,
 AJvYcCXYNxV/pFLI4OAJu5aPsELKf6W+2AxHZow3665wimNa8EkAEfX/dXFnRIBUb/38BpfU8lW/VosWC6YT@nongnu.org
X-Gm-Message-State: AOJu0YwhkldZGW+m1f0SKK8lqS+X6yqX5hY8Wdk22UXFLpA8IFX+jIK3
 iGRdq0yPjzVaVYx+rhLCNmhelcLUZd5uQDG9/F6r5hCn6Qx01b9Nchsti4DO4B3nn1uMmWXff9K
 adW1fUPPVWHksYHY2Tcd732G8h24=
X-Google-Smtp-Source: AGHT+IFfHJ4k13w+UDF3eTSvzluUGXdJHA68kedFrtUANch4ec8PnYj0cEEL2Ha/NAWcvPq0CDCuuWW3IlktZC1tV5g=
X-Received: by 2002:a05:6122:179d:b0:4f5:abe4:50e2 with SMTP id
 71dfb90a1353d-50c854803e8mr8038462e0c.6.1728356160024; Mon, 07 Oct 2024
 19:56:00 -0700 (PDT)
MIME-Version: 1.0
References: <20240910174747.148141-1-alexei.filippov@syntacore.com>
 <20240910174747.148141-3-alexei.filippov@syntacore.com>
In-Reply-To: <20240910174747.148141-3-alexei.filippov@syntacore.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 8 Oct 2024 12:55:33 +1000
Message-ID: <CAKmqyKMEZRDaL5rTTAspBjE-+L8O1-wZKwL5EUJ=jazs7oNkdA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] hw/riscv/sifive_u.c: Add initial HPM support
To: Alexei Filippov <alexei.filippov@syntacore.com>
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, bmeng.cn@gmail.com, 
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, liwei1518@gmail.com, 
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a31;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa31.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Wed, Sep 11, 2024 at 3:50=E2=80=AFAM Alexei Filippov
<alexei.filippov@syntacore.com> wrote:
>
> Add support of hardware performance monitor into sifive_u machine.
> HPM support was made along to [SiFive FU740-C000 manual v1p6] sec. 3.8.
> All described events for now counting by the same algorithm. Each event
> counting could be implemented separately in read/write call backs, also
> events combination are working, but right counting for them should be
> implemented separatly.
>
> Signed-off-by: Alexei Filippov <alexei.filippov@syntacore.com>
> ---
>  hw/misc/meson.build            |   1 +
>  hw/misc/sifive_u_pmu.c         | 384 +++++++++++++++++++++++++++++++++
>  hw/riscv/sifive_u.c            |  14 ++
>  include/hw/misc/sifive_u_pmu.h |  24 +++
>  target/riscv/cpu.c             |  20 +-
>  5 files changed, 442 insertions(+), 1 deletion(-)
>  create mode 100644 hw/misc/sifive_u_pmu.c
>  create mode 100644 include/hw/misc/sifive_u_pmu.h
>
> diff --git a/hw/misc/meson.build b/hw/misc/meson.build
> index 2ca8717be2..ea93a38268 100644
> --- a/hw/misc/meson.build
> +++ b/hw/misc/meson.build
> @@ -34,6 +34,7 @@ system_ss.add(when: 'CONFIG_SIFIVE_E_PRCI', if_true: fi=
les('sifive_e_prci.c'))
>  system_ss.add(when: 'CONFIG_SIFIVE_E_AON', if_true: files('sifive_e_aon.=
c'))
>  system_ss.add(when: 'CONFIG_SIFIVE_U_OTP', if_true: files('sifive_u_otp.=
c'))
>  system_ss.add(when: 'CONFIG_SIFIVE_U_PRCI', if_true: files('sifive_u_prc=
i.c'))
> +specific_ss.add(when: 'CONFIG_SIFIVE_U', if_true: files('sifive_u_pmu.c'=
))
>
>  subdir('macio')
>
> diff --git a/hw/misc/sifive_u_pmu.c b/hw/misc/sifive_u_pmu.c
> new file mode 100644
> index 0000000000..929a2517cc
> --- /dev/null
> +++ b/hw/misc/sifive_u_pmu.c
> @@ -0,0 +1,384 @@
> +/*
> + * RISC-V SiFive U PMU emulation.
> + *
> + * Copyright (c) 2024 Alexei Filippov <alexei.filippov@syntacore.com>.
> + *
> + * This program is free software; you can redistribute it and/or modify =
it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOU=
T
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License=
 for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License alo=
ng with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/log.h"
> +#include "qemu/error-report.h"
> +#include "target/riscv/cpu.h"
> +#include "target/riscv/pmu.h"
> +#include "include/hw/misc/sifive_u_pmu.h"
> +#include "sysemu/cpu-timers.h"
> +#include "sysemu/device_tree.h"
> +
> +REG32(SIFIVE_U_PMU_MHPMEVENT, 0x323)
> +    FIELD(SIFIVE_U_PMU_MHPMEVENT, EVENT_CLASS, 0, 8)
> +    FIELD(SIFIVE_U_PMU_MHPMEVENT, EVENT_MASK, 8, 18)
> +
> +    /*
> +     * Support all PMU events  described in
> +     * https://sifive.cdn.prismic.io/sifive/1a82e600-1f93-4f41-b2d8-86ed=
8b16acba_fu740-c000-manual-v1p6.pdf
> +     * FU740-C000 Manual sec. 3.8 "Hardware Performace Monitor", all

We don't explicitly support the FU740 CPU, so this is a little
strange. What about when the FU740 v2 comes out and it has new events
or the FU540 (which I assume has less)?

Alistair

> +     * events trigger irq by counter overflow, by default all caunters
> +     * caunted identically, special behavior, combining events for examp=
le,
> +     * must be described separately in write/read and trigger irq functi=
ons.
> +     */
> +
> +#define SIFIVE_U_PMU_INST { \
> +    X(RISCV_SIFIVE_U_EVENT_EXCEPTION_TAKEN,                   0x00001), =
\
> +    X(RISCV_SIFIVE_U_EVENT_INTEGER_LOAD_RETIRED,              0x00002), =
\
> +    X(RISCV_SIFIVE_U_EVENT_INTEGER_STORE_RETIRED,             0x00004), =
\
> +    X(RISCV_SIFIVE_U_EVENT_ATOMIC_MEMORY_RETIRED,             0x00008), =
\
> +    X(RISCV_SIFIVE_U_EVENT_SYSTEM_INSTRUCTION_RETIRED,        0x00010), =
\
> +    X(RISCV_SIFIVE_U_EVENT_INTEGER_ARITHMETIC_RETIRED,        0x00020), =
\
> +    X(RISCV_SIFIVE_U_EVENT_CONDITIONAL_BRANCH_RETIRED,        0x00040), =
\
> +    X(RISCV_SIFIVE_U_EVENT_JAL_INSTRUCTION_RETIRED,           0x00080), =
\
> +    X(RISCV_SIFIVE_U_EVENT_JALR_INSTRUCTION_RETIRED,          0x00100), =
\
> +    X(RISCV_SIFIVE_U_EVENT_INTEGER_MULTIPLICATION_RETIRED,    0x00200), =
\
> +    X(RISCV_SIFIVE_U_EVENT_INTEGER_DIVISION_RETIRED,          0x00400), =
\
> +    X(RISCV_SIFIVE_U_EVENT_FP_LOAD_RETIRED,                   0x00800), =
\
> +    X(RISCV_SIFIVE_U_EVENT_FP_STORE_RETIRED,                  0x01000), =
\
> +    X(RISCV_SIFIVE_U_EVENT_FP_ADDITION_RETIRED,               0x02000), =
\
> +    X(RISCV_SIFIVE_U_EVENT_FP_MULTIPLICATION_RETIRED,         0x04000), =
\
> +    X(RISCV_SIFIVE_U_EVENT_FP_FUSEDMADD_RETIRED,              0x08000), =
\
> +    X(RISCV_SIFIVE_U_EVENT_FP_DIV_SQRT_RETIRED,               0x10000), =
\
> +    X(RISCV_SIFIVE_U_EVENT_OTHER_FP_RETIRED,                  0x20000), =
}
> +
> +#define SIFIVE_U_PMU_MICROARCH { \
> +    X(RISCV_SIFIVE_U_EVENT_ADDRESSGEN_INTERLOCK,              0x00001), =
\
> +    X(RISCV_SIFIVE_U_EVENT_LONGLAT_INTERLOCK,                 0x00002), =
\
> +    X(RISCV_SIFIVE_U_EVENT_CSR_READ_INTERLOCK,                0x00004), =
\
> +    X(RISCV_SIFIVE_U_EVENT_ICACHE_ITIM_BUSY,                  0x00008), =
\
> +    X(RISCV_SIFIVE_U_EVENT_DCACHE_DTIM_BUSY,                  0x00010), =
\
> +    X(RISCV_SIFIVE_U_EVENT_BRANCH_DIRECTION_MISPREDICTION,    0x00020), =
\
> +    X(RISCV_SIFIVE_U_EVENT_BRANCH_TARGET_MISPREDICTION,       0x00040), =
\
> +    X(RISCV_SIFIVE_U_EVENT_PIPE_FLUSH_CSR_WRITE,              0x00080), =
\
> +    X(RISCV_SIFIVE_U_EVENT_PIPE_FLUSH_OTHER_EVENT,            0x00100), =
\
> +    X(RISCV_SIFIVE_U_EVENT_INTEGER_MULTIPLICATION_INTERLOCK,  0x00200), =
\
> +    X(RISCV_SIFIVE_U_EVENT_FP_INTERLOCK,                      0x00400), =
}
> +
> +#define SIFIVE_U_PMU_MEM { \
> +    X(RISCV_SIFIVE_U_EVENT_ICACHE_RETIRED,                    0x00001), =
\
> +    X(RISCV_SIFIVE_U_EVENT_DCACHE_MISS_MMIO_ACCESSES,         0x00002), =
\
> +    X(RISCV_SIFIVE_U_EVENT_DCACHE_WRITEBACK,                  0x00004), =
\
> +    X(RISCV_SIFIVE_U_EVENT_INST_TLB_MISS,                     0x00008), =
\
> +    X(RISCV_SIFIVE_U_EVENT_DATA_TLB_MISS,                     0x00010), =
\
> +    X(RISCV_SIFIVE_U_EVENT_UTLB_MISS,                         0x00020), =
}
> +
> +#define X(a, b) a =3D b
> +    enum SIFIVE_U_PMU_INST;
> +    enum SIFIVE_U_PMU_MEM;
> +    enum SIFIVE_U_PMU_MICROARCH;
> +#undef X
> +
> +#define X(a, b) a
> +    const uint32_t
> +    riscv_sifive_u_pmu_events[RISCV_SIFIVE_U_CLASS_MAX][RISCV_SIFIVE_U_M=
ASK_MAX] =3D {
> +    SIFIVE_U_PMU_INST,
> +    SIFIVE_U_PMU_MICROARCH,
> +    SIFIVE_U_PMU_MEM,
> +    };
> +#undef X
> +
> +void sifive_u_pmu_generate_fdt_node(void *fdt, uint32_t cmask, char *pmu=
_name)
> +{
> +    uint32_t fdt_event_mhpmevent_map[10 * 3] =3D {};
> +    uint32_t fdt_event_mhpmctr_map[6 * 4] =3D {};
> +    uint32_t event_idx;
> +
> +    /*
> +     * SBI_PMU_HW_CACHE_REFERENCES: 0x3 -> Instruction cache/ITIM busy |
> +     *                                     Data cache/DTIM busy
> +     * result: < 0x3 0x0 1801 >
> +     */
> +    fdt_event_mhpmevent_map[0]  =3D cpu_to_be32(0x3);
> +    fdt_event_mhpmevent_map[1]  =3D cpu_to_be32(0x0);
> +    event_idx =3D FIELD_DP32(0, SIFIVE_U_PMU_MHPMEVENT, EVENT_MASK,
> +                           RISCV_SIFIVE_U_EVENT_ICACHE_ITIM_BUSY |
> +                           RISCV_SIFIVE_U_EVENT_DCACHE_DTIM_BUSY);
> +    event_idx =3D FIELD_DP32(event_idx, SIFIVE_U_PMU_MHPMEVENT, EVENT_CL=
ASS,
> +                           RISCV_SIFIVE_U_CLASS_MICROARCH);
> +    fdt_event_mhpmevent_map[2]  =3D cpu_to_be32(event_idx);
> +
> +
> +    /*
> +     * SBI_PMU_HW_CACHE_MISSES: 0x4 -> Instruction cache miss |
> +     *                                 Data cache miss or mem-mapped I/O=
 access
> +     * result: < 0x4 0x0 0x302 >
> +     */
> +    fdt_event_mhpmevent_map[3]  =3D cpu_to_be32(0x4);
> +    fdt_event_mhpmevent_map[4]  =3D cpu_to_be32(0x0);
> +    event_idx =3D FIELD_DP32(0, SIFIVE_U_PMU_MHPMEVENT, EVENT_MASK,
> +                           RISCV_SIFIVE_U_EVENT_ICACHE_RETIRED |
> +                           RISCV_SIFIVE_U_EVENT_DCACHE_MISS_MMIO_ACCESSE=
S);
> +    event_idx =3D FIELD_DP32(event_idx, SIFIVE_U_PMU_MHPMEVENT, EVENT_CL=
ASS,
> +                           RISCV_SIFIVE_U_CLASS_MEM);
> +    fdt_event_mhpmevent_map[5]  =3D cpu_to_be32(event_idx);
> +
> +    /*
> +     * SBI_PMU_HW_BRANCH_INSTRUCTIONS: 0x5 -> Conditional branch retired
> +     * result: < 0x5 0x0 0x4000 >
> +     */
> +    fdt_event_mhpmevent_map[6]  =3D cpu_to_be32(0x5);
> +    fdt_event_mhpmevent_map[7]  =3D cpu_to_be32(0x0);
> +    event_idx =3D FIELD_DP32(0, SIFIVE_U_PMU_MHPMEVENT, EVENT_MASK,
> +                           RISCV_SIFIVE_U_EVENT_CONDITIONAL_BRANCH_RETIR=
ED);
> +    event_idx =3D FIELD_DP32(event_idx, SIFIVE_U_PMU_MHPMEVENT, EVENT_CL=
ASS,
> +                           RISCV_SIFIVE_U_CLASS_INST);
> +    fdt_event_mhpmevent_map[8]  =3D cpu_to_be32(event_idx);
> +
> +    /*
> +     * SBI_PMU_HW_BRANCH_MISSES: 0x6 -> Branch direction misprediction |
> +     *                                  Branch/jump target misprediction
> +     * result: < 0x6 0x0 0x6001 >
> +     */
> +    fdt_event_mhpmevent_map[9]  =3D cpu_to_be32(0x6);
> +    fdt_event_mhpmevent_map[10] =3D cpu_to_be32(0x0);
> +    event_idx =3D FIELD_DP32(0, SIFIVE_U_PMU_MHPMEVENT, EVENT_MASK,
> +                           RISCV_SIFIVE_U_EVENT_BRANCH_DIRECTION_MISPRED=
ICTION |
> +                           RISCV_SIFIVE_U_EVENT_BRANCH_TARGET_MISPREDICT=
ION);
> +    event_idx =3D FIELD_DP32(event_idx, SIFIVE_U_PMU_MHPMEVENT, EVENT_CL=
ASS,
> +                           RISCV_SIFIVE_U_CLASS_MICROARCH);
> +    fdt_event_mhpmevent_map[11] =3D cpu_to_be32(event_idx);
> +
> +    /*
> +     * L1D_READ_MISS: 0x10001 -> Data cache miss or memory-mapped I/O ac=
cess
> +     * result: < 0x10001 0x0 0x202 >
> +     */
> +    fdt_event_mhpmevent_map[12]  =3D cpu_to_be32(0x10001);
> +    fdt_event_mhpmevent_map[13] =3D cpu_to_be32(0x0);
> +    event_idx =3D FIELD_DP32(0, SIFIVE_U_PMU_MHPMEVENT, EVENT_MASK,
> +                           RISCV_SIFIVE_U_EVENT_DCACHE_MISS_MMIO_ACCESSE=
S);
> +    event_idx =3D FIELD_DP32(event_idx, SIFIVE_U_PMU_MHPMEVENT, EVENT_CL=
ASS,
> +                           RISCV_SIFIVE_U_CLASS_MEM);
> +    fdt_event_mhpmevent_map[14] =3D cpu_to_be32(event_idx);
> +
> +    /*
> +     * L1D_WRITE_ACCESS: 0x10002 -> Data cache write back
> +     * result: < 0x10002 0x0 0x402 >
> +     */
> +    fdt_event_mhpmevent_map[15]  =3D cpu_to_be32(0x10002);
> +    fdt_event_mhpmevent_map[16] =3D cpu_to_be32(0x0);
> +    event_idx =3D FIELD_DP32(0, SIFIVE_U_PMU_MHPMEVENT, EVENT_MASK,
> +                           RISCV_SIFIVE_U_EVENT_DCACHE_WRITEBACK);
> +    event_idx =3D FIELD_DP32(event_idx, SIFIVE_U_PMU_MHPMEVENT, EVENT_CL=
ASS,
> +                           RISCV_SIFIVE_U_CLASS_MEM);
> +    fdt_event_mhpmevent_map[17] =3D cpu_to_be32(event_idx);
> +
> +    /*
> +     * L1I_READ_ACCESS: 0x10009 -> Instruction cache miss
> +     * result: < 0x10009 0x0 0x102 >
> +     */
> +    fdt_event_mhpmevent_map[18]  =3D cpu_to_be32(0x10009);
> +    fdt_event_mhpmevent_map[19] =3D cpu_to_be32(0x0);
> +    event_idx =3D FIELD_DP32(0, SIFIVE_U_PMU_MHPMEVENT, EVENT_MASK,
> +                           RISCV_SIFIVE_U_EVENT_ICACHE_RETIRED);
> +    event_idx =3D FIELD_DP32(event_idx, SIFIVE_U_PMU_MHPMEVENT, EVENT_CL=
ASS,
> +                           RISCV_SIFIVE_U_CLASS_MEM);
> +    fdt_event_mhpmevent_map[20] =3D cpu_to_be32(event_idx);
> +
> +    /*
> +     * LL_READ_MISS: 0x10011 -> UTLB miss
> +     * result: < 0x10011 0x0 0x2002 >
> +     */
> +    fdt_event_mhpmevent_map[21]  =3D cpu_to_be32(0x10011);
> +    fdt_event_mhpmevent_map[22] =3D cpu_to_be32(0x0);
> +    event_idx =3D FIELD_DP32(0, SIFIVE_U_PMU_MHPMEVENT, EVENT_MASK,
> +                           RISCV_SIFIVE_U_EVENT_UTLB_MISS);
> +    event_idx =3D FIELD_DP32(event_idx, SIFIVE_U_PMU_MHPMEVENT, EVENT_CL=
ASS,
> +                           RISCV_SIFIVE_U_CLASS_MEM);
> +    fdt_event_mhpmevent_map[23] =3D cpu_to_be32(event_idx);
> +
> +    /*
> +     * DTLB_READ_MISS: 0x10019 -> Data TLB miss
> +     * result: < 0x10019 0x0 0x1002 >
> +     */
> +    fdt_event_mhpmevent_map[24]  =3D cpu_to_be32(0x10019);
> +    fdt_event_mhpmevent_map[25] =3D cpu_to_be32(0x0);
> +    event_idx =3D FIELD_DP32(0, SIFIVE_U_PMU_MHPMEVENT, EVENT_MASK,
> +                           RISCV_SIFIVE_U_EVENT_DATA_TLB_MISS);
> +    event_idx =3D FIELD_DP32(event_idx, SIFIVE_U_PMU_MHPMEVENT, EVENT_CL=
ASS,
> +                           RISCV_SIFIVE_U_CLASS_MEM);
> +    fdt_event_mhpmevent_map[26] =3D cpu_to_be32(event_idx);
> +
> +    /*
> +     * DTLB_READ_MISS: 0x10021 -> Data TLB miss
> +     * result: < 0x10019 0x0 0x802 >
> +     */
> +    fdt_event_mhpmevent_map[27]  =3D cpu_to_be32(0x10021);
> +    fdt_event_mhpmevent_map[28] =3D cpu_to_be32(0x0);
> +    event_idx =3D FIELD_DP32(0, SIFIVE_U_PMU_MHPMEVENT, EVENT_MASK,
> +                           RISCV_SIFIVE_U_EVENT_INST_TLB_MISS);
> +    event_idx =3D FIELD_DP32(event_idx, SIFIVE_U_PMU_MHPMEVENT, EVENT_CL=
ASS,
> +                           RISCV_SIFIVE_U_CLASS_MEM);
> +    fdt_event_mhpmevent_map[29] =3D cpu_to_be32(event_idx);
> +
> +    fdt_event_mhpmctr_map[0] =3D cpu_to_be32(0x00003);
> +    fdt_event_mhpmctr_map[1] =3D cpu_to_be32(0x00006);
> +    fdt_event_mhpmctr_map[2] =3D cpu_to_be32(cmask);
> +
> +    fdt_event_mhpmctr_map[3] =3D cpu_to_be32(0x10001);
> +    fdt_event_mhpmctr_map[4] =3D cpu_to_be32(0x10002);
> +    fdt_event_mhpmctr_map[5] =3D cpu_to_be32(cmask);
> +
> +    fdt_event_mhpmctr_map[6] =3D cpu_to_be32(0x10009);
> +    fdt_event_mhpmctr_map[7] =3D cpu_to_be32(0x10009);
> +    fdt_event_mhpmctr_map[8] =3D cpu_to_be32(cmask);
> +
> +    fdt_event_mhpmctr_map[9] =3D cpu_to_be32(0x10011);
> +    fdt_event_mhpmctr_map[10] =3D cpu_to_be32(0x10011);
> +    fdt_event_mhpmctr_map[11] =3D cpu_to_be32(cmask);
> +
> +    fdt_event_mhpmctr_map[12] =3D cpu_to_be32(0x10019);
> +    fdt_event_mhpmctr_map[13] =3D cpu_to_be32(0x10019);
> +    fdt_event_mhpmctr_map[14] =3D cpu_to_be32(cmask);
> +
> +    fdt_event_mhpmctr_map[15] =3D cpu_to_be32(0x10021);
> +    fdt_event_mhpmctr_map[16] =3D cpu_to_be32(0x10021);
> +    fdt_event_mhpmctr_map[17] =3D cpu_to_be32(cmask);
> +
> +    fdt_event_mhpmctr_map[18] =3D cpu_to_be32(0x1);
> +    fdt_event_mhpmctr_map[19] =3D cpu_to_be32(0x1);
> +    fdt_event_mhpmctr_map[20] =3D cpu_to_be32(cmask | 1 << 0);
> +
> +    fdt_event_mhpmctr_map[21] =3D cpu_to_be32(0x2);
> +    fdt_event_mhpmctr_map[22] =3D cpu_to_be32(0x2);
> +    fdt_event_mhpmctr_map[23] =3D cpu_to_be32(cmask | 1 << 2);
> +
> +   /* This a OpenSBI specific DT property documented in OpenSBI docs */
> +    qemu_fdt_setprop(fdt, pmu_name, "riscv,event-to-mhpmevent",
> +                     fdt_event_mhpmevent_map, sizeof(fdt_event_mhpmevent=
_map));
> +    qemu_fdt_setprop(fdt, pmu_name, "riscv,event-to-mhpmcounters",
> +                     fdt_event_mhpmctr_map, sizeof(fdt_event_mhpmctr_map=
));
> +
> +}
> +
> +bool riscv_sifive_u_supported_events(uint32_t event_idx)
> +{
> +    uint32_t group =3D FIELD_EX32(event_idx, SIFIVE_U_PMU_MHPMEVENT, EVE=
NT_CLASS);
> +    uint32_t event_mask =3D FIELD_EX32(event_idx, SIFIVE_U_PMU_MHPMEVENT=
,
> +                                     EVENT_MASK);
> +    uint32_t idx =3D 32 - clz32(event_mask);
> +
> +    if (group >=3D RISCV_SIFIVE_U_CLASS_MAX || idx > RISCV_SIFIVE_U_MASK=
_MAX) {
> +        return 0;
> +    }
> +
> +    bool event_match =3D true;
> +    if (!idx) {
> +        event_match =3D false;
> +    }
> +    while (event_match && idx) {
> +        if (!riscv_sifive_u_pmu_events[group][idx - 1]) {
> +            event_match =3D false;
> +        }
> +        event_mask =3D event_mask & (~(1 << (idx - 1)));
> +        idx =3D 32 - clz32(event_mask);
> +    }
> +    return event_match;
> +}
> +
> +static target_ulong get_ticks(bool icnt, bool high_half)
> +{
> +    int64_t val;
> +    target_ulong res;
> +
> +    if (icnt && icount_enabled()) {
> +        val =3D icount_get_raw();
> +    } else {
> +        val =3D cpu_get_host_ticks();
> +    }
> +
> +    if (high_half) {
> +        res =3D val >> 32;
> +    } else {
> +        res =3D val;
> +    }
> +
> +    return res;
> +}
> +
> +target_ulong riscv_sifive_u_pmu_ctr_read(PMUCTRState *counter,
> +                                         uint32_t event_idx, bool high_h=
alf)
> +{
> +    target_ulong ctrl_val =3D high_half ? counter->mhpmcounterh_val :
> +                                        counter->mhpmcounter_val;
> +    uint32_t event_class_field =3D FIELD_EX32(event_idx,
> +                                                SIFIVE_U_PMU_MHPMEVENT,
> +                                                EVENT_CLASS);
> +    uint32_t event_mask_field =3D FIELD_EX32(event_idx,
> +                                               SIFIVE_U_PMU_MHPMEVENT,
> +                                               EVENT_MASK);
> +
> +    if (event_class_field >=3D RISCV_SIFIVE_U_CLASS_MAX ||
> +        (32 - clz32(event_mask_field)) >=3D RISCV_SIFIVE_U_MASK_MAX) {
> +        return ctrl_val;
> +    }
> +
> +    switch (event_class_field) {
> +    /* If we want to handle some events separately */
> +
> +    /* fall through */
> +    default:
> +    /* In case we do not want handle it separately */
> +        if (riscv_sifive_u_supported_events(event_idx)) {
> +                return get_ticks(false, high_half);
> +        }
> +    /* Did not find event in supported */
> +        return ctrl_val;
> +    }
> +
> +    g_assert_not_reached(); /* unreachable */
> +    return 0;
> +}
> +
> +void riscv_sifive_u_pmu_ctr_write(PMUCTRState *counter, uint32_t event_i=
dx,
> +                             target_ulong val, bool high_half)
> +{
> +    target_ulong *ctr_prev =3D high_half ? &counter->mhpmcounterh_prev :
> +                                         &counter->mhpmcounter_prev;
> +    uint32_t event_class_field =3D FIELD_EX32(event_idx,
> +                                                SIFIVE_U_PMU_MHPMEVENT,
> +                                                EVENT_CLASS);
> +    uint32_t event_mask_field =3D FIELD_EX32(event_idx,
> +                                               SIFIVE_U_PMU_MHPMEVENT,
> +                                               EVENT_MASK);
> +
> +    if (event_class_field >=3D RISCV_SIFIVE_U_CLASS_MAX ||
> +        (32 - clz32(event_mask_field)) >=3D RISCV_SIFIVE_U_MASK_MAX) {
> +        *ctr_prev =3D val;
> +        return;
> +    }
> +
> +    switch (event_class_field) {
> +    /* If we want to handle some events separately */
> +
> +    /* fall through */
> +    default:
> +    /* In case we do not want handle it separately */
> +        if (riscv_sifive_u_supported_events(event_idx)) {
> +            *ctr_prev =3D get_ticks(false, high_half);
> +            return;
> +        }
> +    /* Did not find event in supported */
> +        *ctr_prev =3D val;
> +        return;
> +    }
> +
> +    g_assert_not_reached(); /* unreachable */
> +    return;
> +}
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index af5f923f54..2771102fbe 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -60,6 +60,7 @@
>  #include "sysemu/device_tree.h"
>  #include "sysemu/runstate.h"
>  #include "sysemu/sysemu.h"
> +#include "include/hw/misc/sifive_u_pmu.h"
>
>  #include <libfdt.h>
>
> @@ -93,6 +94,17 @@ static const MemMapEntry sifive_u_memmap[] =3D {
>  #define OTP_SERIAL          1
>  #define GEM_REVISION        0x10070109
>
> +static void create_fdt_pmu(MachineState *s)
> +{
> +    g_autofree char *pmu_name =3D g_strdup_printf("/pmu");
> +    MachineState *ms =3D MACHINE(s);
> +    RISCVCPU *hart =3D RISCV_CPU(qemu_get_cpu(0));
> +
> +    qemu_fdt_add_subnode(ms->fdt, pmu_name);
> +    qemu_fdt_setprop_string(ms->fdt, pmu_name, "compatible", "riscv,pmu"=
);
> +    sifive_u_pmu_generate_fdt_node(ms->fdt, hart->pmu_avail_ctrs, pmu_na=
me);
> +}
> +
>  static void create_fdt(SiFiveUState *s, const MemMapEntry *memmap,
>                         bool is_32_bit)
>  {
> @@ -499,6 +511,8 @@ static void create_fdt(SiFiveUState *s, const MemMapE=
ntry *memmap,
>      qemu_fdt_setprop_string(fdt, "/aliases", "serial0", nodename);
>
>      g_free(nodename);
> +
> +    create_fdt_pmu(ms);
>  }
>
>  static void sifive_u_machine_reset(void *opaque, int n, int level)
> diff --git a/include/hw/misc/sifive_u_pmu.h b/include/hw/misc/sifive_u_pm=
u.h
> new file mode 100644
> index 0000000000..8877c2ba46
> --- /dev/null
> +++ b/include/hw/misc/sifive_u_pmu.h
> @@ -0,0 +1,24 @@
> +#ifndef RISCV_SIFIVE_U_PMU_H
> +#define RISCV_SIFIVE_U_PMU_H
> +
> +#include "target/riscv/cpu.h"
> +#include "qapi/error.h"
> +
> +/* Maximum events per class */
> +#define RISCV_SIFIVE_U_MASK_MAX 18
> +
> +enum riscv_sifive_u_pmu_classes {
> +    RISCV_SIFIVE_U_CLASS_INST =3D 0x0,
> +    RISCV_SIFIVE_U_CLASS_MICROARCH,
> +    RISCV_SIFIVE_U_CLASS_MEM,
> +    RISCV_SIFIVE_U_CLASS_MAX  =3D 0x3
> +};
> +
> +bool riscv_sifive_u_supported_events(uint32_t event_idx);
> +void riscv_sifive_u_pmu_ctr_write(PMUCTRState *counter, uint32_t event_i=
dx,
> +                                    target_ulong val, bool high_half);
> +target_ulong riscv_sifive_u_pmu_ctr_read(PMUCTRState *counter,
> +                                           uint32_t event_idx, bool high=
_half);
> +void sifive_u_pmu_generate_fdt_node(void *fdt, uint32_t cmask, char *pmu=
_name);
> +
> +#endif /* RISCV_SCR_PMU_H */
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index a90808a3ba..2ae43c7658 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -38,6 +38,7 @@
>  #include "kvm/kvm_riscv.h"
>  #include "tcg/tcg-cpu.h"
>  #include "tcg/tcg.h"
> +#include "include/hw/misc/sifive_u_pmu.h"
>
>  /* RISC-V CPU definitions */
>  static const char riscv_single_letter_exts[] =3D "IEMAFDQCBPVH";
> @@ -477,6 +478,15 @@ static void riscv_max_cpu_init(Object *obj)
>  #endif
>  }
>
> +#ifndef CONFIG_USER_ONLY
> +static void riscv_sifive_u_hart_reg_pmu_cb(CPURISCVState *env)
> +{
> +    env->pmu_vendor_support =3D riscv_sifive_u_supported_events;
> +    env->pmu_ctr_write =3D riscv_sifive_u_pmu_ctr_write;
> +    env->pmu_ctr_read =3D riscv_sifive_u_pmu_ctr_read;
> +}
> +#endif
> +
>  #if defined(TARGET_RISCV64)
>  static void rv64_base_cpu_init(Object *obj)
>  {
> @@ -498,9 +508,12 @@ static void rv64_sifive_u_cpu_init(Object *obj)
>      RISCVCPU *cpu =3D RISCV_CPU(obj);
>      CPURISCVState *env =3D &cpu->env;
>      riscv_cpu_set_misa_ext(env, RVI | RVM | RVA | RVF | RVD | RVC | RVS =
| RVU);
> -    env->priv_ver =3D PRIV_VERSION_1_10_0;
> +    env->priv_ver =3D PRIV_VERSION_1_12_0;
>  #ifndef CONFIG_USER_ONLY
>      set_satp_mode_max_supported(RISCV_CPU(obj), VM_1_10_SV39);
> +    if (!kvm_enabled()) {
> +        riscv_sifive_u_hart_reg_pmu_cb(env);
> +    }
>  #endif
>
>      /* inherited from parent obj via riscv_cpu_init() */
> @@ -508,6 +521,8 @@ static void rv64_sifive_u_cpu_init(Object *obj)
>      cpu->cfg.ext_zicsr =3D true;
>      cpu->cfg.mmu =3D true;
>      cpu->cfg.pmp =3D true;
> +    cpu->cfg.ext_sscofpmf =3D true;
> +    cpu->cfg.pmu_mask =3D MAKE_64BIT_MASK(3, 2);
>  }
>
>  static void rv64_sifive_e_cpu_init(Object *obj)
> @@ -660,6 +675,9 @@ static void rv32_sifive_u_cpu_init(Object *obj)
>      env->priv_ver =3D PRIV_VERSION_1_10_0;
>  #ifndef CONFIG_USER_ONLY
>      set_satp_mode_max_supported(RISCV_CPU(obj), VM_1_10_SV32);
> +    if (!kvm_enabled()) {
> +        riscv_sifive_u_hart_reg_pmu_cb(env);
> +    }
>  #endif
>
>      /* inherited from parent obj via riscv_cpu_init() */
> --
> 2.34.1
>
>

