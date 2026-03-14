Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91FDF10854AA
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2026 23:53:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w1YnD-00067G-0v; Sat, 14 Mar 2026 19:53:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1w1Yn7-00066z-6q
 for qemu-devel@nongnu.org; Sat, 14 Mar 2026 19:53:09 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1w1Yn3-0003uA-Bk
 for qemu-devel@nongnu.org; Sat, 14 Mar 2026 19:53:08 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-829a568f3ccso1789353b3a.0
 for <qemu-devel@nongnu.org>; Sat, 14 Mar 2026 16:53:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773532384; cv=none;
 d=google.com; s=arc-20240605;
 b=KrvJke9fbQo9fyxxkbJHGo16tOOoVZTeI2BYTEA+Zq+tLtHede2ww/+eiPy3Nwybzi
 jsiR2J+mq94tlSAL9itBzdXi1oPwjoLErAq+mzd2bEqB8FbFFAqhOAA0ij0S6sJAp7c3
 Pohs90NQjkhYbVvbKb8KVxeMNco3vewTUbdFHf9jqcPAqFCVubH4uALtxwvLnH44xucg
 FWNdAzPwjaGT+VgPpD3mJ9XEf2Hf/xgjTN+b/CNOQzOHGJdx7nqW3JAJbJMeQKY0K7ma
 1k9yL1ty2jpFq4wQaQOYNI33eJ4SBcTi8P1FXo171gHzoOvgGpn9Tn+ckDK4conjDR4g
 zMXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=zSk+YEpVIHbDHKjzXFy1lXm0+d8GxWTCBGd8yeseJ4o=;
 fh=z0XINYJCuFxeX+u8PHoCyhXnlhB/sk5j5lIGyUyxmv0=;
 b=OvQ9Z6mGrev/YMbG/9EWTvNMPUyBmwZShNWoo5SfyFZwhAu6VfeForHGDehz0FBC2I
 cBxBC/0nuM4fZCxRT0RzYOZeH/YQneQf4wvMhWHwcS4oyvsuKGeqJkfo+LHHR0FyyRDc
 vunO1CZJQJ4JaKsyKnH7yFerU5NQm3/9IL6P2h+KvHMsJJLToDjTdcWZqEYXI4IGtQne
 O/Z9mZqmk2tfAKHEzHQu/XMv0v7xRsQHp+1ldo/o2E1EIpdAImyarXBqIFKJ04pD3WUE
 rVopg4mpznq/cnBoW925lgN0cG3Mh8l2OIIFUO/DO4WlPTFdF3nccCx1CVf9JQX9CWhM
 aIug==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773532384; x=1774137184; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zSk+YEpVIHbDHKjzXFy1lXm0+d8GxWTCBGd8yeseJ4o=;
 b=T9aZGejp2eOQJEHe2DgnP5U//pvSXO6cV6NXyTx2IIyMRB7pU+efr2ciS2L9qpH+fb
 0SuYvCIyvC724Q+r/EAlfNcGP8UXdmLcgPxWW+2+Noh37dH+U0rhhHJ/bq1aYV+f1v93
 G9q6VOKVZJi64R1rc/i6gWIQbwvn9WTBJLfqxJSog6afMBGzSpAzKvFvQ+mT27Kr6Z1d
 OEysrlQpoDzWbxqvPbBVOfLseWPrCrnc8bHjSntTvCpd4RDZVrKLrwoSk3qOoKGcS1k5
 L5HPMfeanxYQLtprD6aAQn8t2FjmPdPQ51BGyIvf6a73hBmHxpmwveVXRxMV//1LcPys
 cgNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773532384; x=1774137184;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zSk+YEpVIHbDHKjzXFy1lXm0+d8GxWTCBGd8yeseJ4o=;
 b=UJBPbDUTcJMknhXpm/9kMl+T0wIf26Seghd/vAZmAZQvldcfyk+Fpi1zpBrHRSTvHk
 fiQqFslZ7doJVs0SC4K+HeNtcD0Vd27YfDicg7nTYlviVTmn+5n7s92laNFvafxTi6pT
 moL2o0tAg3pCBBDtdGXT440SJPVRMIIkK1Vgcry/aOg65Sf8GqZ0OGi03l60UhjHKbjd
 n1UM8ELn3h4gA0KPknG8yCDX4iGcfywgd+y/fOxGswSwv19MXZEr4TEUaSghrID8qJq/
 HNftvrW4NEBB6rmYJUK8Jjquta3vYXDvMhH6G3PxRwfCQ0J5XB6c55gzWWNDbiyQjGmv
 mDdw==
X-Gm-Message-State: AOJu0YxVSxdlfJSbnmuHuuH1EtiqrrZLpxUlm1GOLk3hn9tsd1lQYQ46
 bSoypF0PazOk+k6pZzGSkCaUbI6PbsHH0HIaZL35FseJOsAvETgKElgv7/HYX5K3zMPYbgnBfGb
 jCxS/5A1PUvqvf2YhXGPpmtADFNQlFyQ=
X-Gm-Gg: ATEYQzwrmnOe1P4EWMUzNxbN6LMe3LenCX/S0XotD20lgqIkYusg3ahgQw9BhbN4yjW
 N7OVFTopYHLMcGmLMvs9VeH4cXAJDXOjol+vw/JKI9zA4G4BQiixxPBr81YyU0boue3C8V868zO
 k3hlaepGDNTaPo4LIWqga5G+MGxD0SAjBgwGOobI9SUf7w+wPmKtlXn2k84rZ6afD+4HuelGCBp
 VKFYPCPP36xa4S2HeiXCSYzOqSLBwnPY/YMyyPgSssz7wEy3uXoa4LvQ2bAU3/xCkSmVMmAOj8X
 2BGRPcVQpvUfc4isDB4VZ2tbdHJwpRrW3mafZNU=
X-Received: by 2002:a05:6a00:4b52:b0:829:95f6:7625 with SMTP id
 d2e1a72fcca58-82a1986c862mr7292200b3a.28.1773532383766; Sat, 14 Mar 2026
 16:53:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260311040758.1068731-1-brian.cain@oss.qualcomm.com>
 <20260311040758.1068731-12-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260311040758.1068731-12-brian.cain@oss.qualcomm.com>
From: Taylor Simpson <ltaylorsimpson@gmail.com>
Date: Sat, 14 Mar 2026 17:52:52 -0600
X-Gm-Features: AaiRm525DRTOZLNHkiCylp3pkrR8z1TvPFIseejDWGmC-dvkYjcmeu6dlXNmKLc
Message-ID: <CAATN3NpjzNsSzLxsLy85DAjfx7wZ19tGWn83ST30GRv+fR-Jvw@mail.gmail.com>
Subject: Re: [PATCH v3 11/32] target/hexagon: Implement software interrupt
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com, 
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng, 
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>,
 Mike Lambert <mlambert@quicinc.com>
Content-Type: multipart/alternative; boundary="000000000000bb6a9e064d04af85"
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-pf1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--000000000000bb6a9e064d04af85
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 10:08=E2=80=AFPM Brian Cain <brian.cain@oss.qualcom=
m.com>
wrote:

> From: Brian Cain <bcain@quicinc.com>
>
> Co-authored-by: Mike Lambert <mlambert@quicinc.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/hexswi.h |  17 +++
>  target/hexagon/cpu.c    |   1 +
>  target/hexagon/hexswi.c | 260 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 278 insertions(+)
>  create mode 100644 target/hexagon/hexswi.h
>  create mode 100644 target/hexagon/hexswi.c
>
> diff --git a/target/hexagon/hexswi.h b/target/hexagon/hexswi.h
> new file mode 100644
> index 00000000000..48c1ae6e4c1
> --- /dev/null
> +++ b/target/hexagon/hexswi.h
> @@ -0,0 +1,17 @@
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef HEXSWI_H
> +#define HEXSWI_H
> +
> +
> +#include "cpu.h"
> +
> +void hexagon_cpu_do_interrupt(CPUState *cpu);
> +void register_trap_exception(CPUHexagonState *env, int type, int imm,
> +                             uint32_t PC);
> +
> +#endif /* HEXSWI_H */
> diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
> index 1c8a188dec4..2964d8a63f6 100644
> --- a/target/hexagon/cpu.c
> +++ b/target/hexagon/cpu.c
> @@ -34,6 +34,7 @@
>  #include "sys_macros.h"
>  #include "accel/tcg/cpu-ldst.h"
>  #include "qemu/main-loop.h"
> +#include "hex_interrupts.h"
>  #endif
>
>  static void hexagon_v66_cpu_init(Object *obj) { }
> diff --git a/target/hexagon/hexswi.c b/target/hexagon/hexswi.c
> new file mode 100644
> index 00000000000..77a4dd5bc43
> --- /dev/null
> +++ b/target/hexagon/hexswi.c
> @@ -0,0 +1,260 @@
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "cpu.h"
> +#include "cpu_helper.h"
> +#include "exec/helper-proto.h"
> +#include "qemu/log.h"
> +#include "qemu/main-loop.h"
> +#include "arch.h"
> +#include "internal.h"
> +#include "macros.h"
> +#include "sys_macros.h"
> +#include "tcg/tcg-op.h"
> +#include "hex_mmu.h"
> +#include "hexswi.h"
> +#include "hw/hexagon/hexagon_globalreg.h"
> +
> +#ifdef CONFIG_USER_ONLY
> +#error "This file is only used in system emulation"
> +#endif
> +
> +static void set_addresses(CPUHexagonState *env, uint32_t pc_offset,
> +                          uint32_t exception_index)
> +
> +{
> +    HexagonCPU *cpu =3D env_archcpu(env);
> +    uint32_t evb =3D cpu->globalregs ?
> +        hexagon_globalreg_read(cpu->globalregs, HEX_SREG_EVB,
> +                               env->threadId) :
> +        cpu->boot_addr;
> +    env->t_sreg[HEX_SREG_ELR] =3D env->gpr[HEX_REG_PC] + pc_offset;
> +    env->gpr[HEX_REG_PC] =3D evb | (exception_index << 2);
>

Does this work when globalregs is false and evb is set to cpu->boot_addr?


> +}
> +
> +static const char *event_name[] =3D {
> +    [HEX_EVENT_RESET] =3D "HEX_EVENT_RESET",
> +    [HEX_EVENT_IMPRECISE] =3D "HEX_EVENT_IMPRECISE",
> +    [HEX_EVENT_PRECISE] =3D "HEX_EVENT_PRECISE",
> +    [HEX_EVENT_TLB_MISS_X] =3D "HEX_EVENT_TLB_MISS_X",
> +    [HEX_EVENT_TLB_MISS_RW] =3D "HEX_EVENT_TLB_MISS_RW",
> +    [HEX_EVENT_TRAP0] =3D "HEX_EVENT_TRAP0",
> +    [HEX_EVENT_TRAP1] =3D "HEX_EVENT_TRAP1",
> +    [HEX_EVENT_FPTRAP] =3D "HEX_EVENT_FPTRAP",
> +    [HEX_EVENT_DEBUG] =3D "HEX_EVENT_DEBUG",
> +    [HEX_EVENT_INT0] =3D "HEX_EVENT_INT0",
> +    [HEX_EVENT_INT1] =3D "HEX_EVENT_INT1",
> +    [HEX_EVENT_INT2] =3D "HEX_EVENT_INT2",
> +    [HEX_EVENT_INT3] =3D "HEX_EVENT_INT3",
> +    [HEX_EVENT_INT4] =3D "HEX_EVENT_INT4",
> +    [HEX_EVENT_INT5] =3D "HEX_EVENT_INT5",
> +    [HEX_EVENT_INT6] =3D "HEX_EVENT_INT6",
> +    [HEX_EVENT_INT7] =3D "HEX_EVENT_INT7",
> +    [HEX_EVENT_INT8] =3D "HEX_EVENT_INT8",
> +    [HEX_EVENT_INT9] =3D "HEX_EVENT_INT9",
> +    [HEX_EVENT_INTA] =3D "HEX_EVENT_INTA",
> +    [HEX_EVENT_INTB] =3D "HEX_EVENT_INTB",
> +    [HEX_EVENT_INTC] =3D "HEX_EVENT_INTC",
> +    [HEX_EVENT_INTD] =3D "HEX_EVENT_INTD",
> +    [HEX_EVENT_INTE] =3D "HEX_EVENT_INTE",
> +    [HEX_EVENT_INTF] =3D "HEX_EVENT_INTF"
> +};
> +
> +void hexagon_cpu_do_interrupt(CPUState *cs)
> +
> +{
> +    CPUHexagonState *env =3D cpu_env(cs);
> +    uint32_t ssr;
> +
> +    BQL_LOCK_GUARD();
> +
> +    qemu_log_mask(CPU_LOG_INT, "\t%s: event 0x%x:%s, cause 0x%x(%d)\n",
>

Don't use %x or %d in format strings.


> +                  __func__, cs->exception_index,
> +                  event_name[cs->exception_index], env->cause_code,
> +                  env->cause_code);
> +
> +    env->llsc_addr =3D ~0;
> +
> +    ssr =3D env->t_sreg[HEX_SREG_SSR];
> +    if (GET_SSR_FIELD(SSR_EX, ssr) =3D=3D 1) {
> +        HexagonCPU *cpu =3D env_archcpu(env);
> +        if (cpu->globalregs) {
> +            hexagon_globalreg_write(cpu->globalregs, HEX_SREG_DIAG,
> +                                    env->cause_code, env->threadId);
> +        }
> +        env->cause_code =3D HEX_CAUSE_DOUBLE_EXCEPT;
> +        cs->exception_index =3D HEX_EVENT_PRECISE;
> +    }
> +
> +    switch (cs->exception_index) {
> +    case HEX_EVENT_TRAP0:
> +        if (env->cause_code =3D=3D 0) {
> +            qemu_log_mask(LOG_UNIMP,
> +                          "trap0 is unhandled, no semihosting
> available\n");
> +        }
> +
> +        hexagon_ssr_set_cause(env, env->cause_code);
> +        set_addresses(env, 4, cs->exception_index);
> +        break;
> +
> +    case HEX_EVENT_TRAP1:
> +        hexagon_ssr_set_cause(env, env->cause_code);
> +        set_addresses(env, 4, cs->exception_index);
> +        break;
> +
> +    case HEX_EVENT_TLB_MISS_X:
> +        switch (env->cause_code) {
> +        case HEX_CAUSE_TLBMISSX_CAUSE_NORMAL:
> +        case HEX_CAUSE_TLBMISSX_CAUSE_NEXTPAGE:
> +            qemu_log_mask(CPU_LOG_MMU,
> +                          "TLB miss EX exception (0x%x) caught: "
> +                          "Cause code (0x%x) "
>

Don't use %x


> +                          "TID =3D 0x%" PRIx32 ", PC =3D 0x%" PRIx32
> +                          ", BADVA =3D 0x%" PRIx32 "\n",
> +                          cs->exception_index, env->cause_code,
> env->threadId,
> +                          env->gpr[HEX_REG_PC],
> +                          env->t_sreg[HEX_SREG_BADVA]);
> +
> +            hexagon_ssr_set_cause(env, env->cause_code);
> +            set_addresses(env, 0, cs->exception_index);
> +            break;
> +
> +        default:
> +            cpu_abort(cs,
> +                      "1:Hexagon exception %d/0x%x: "
> +                      "Unknown cause code %d/0x%x\n",
>

Don't use %x


> +                      cs->exception_index, cs->exception_index,
> env->cause_code,
> +                      env->cause_code);
> +            break;
> +        }
> +        break;
> +
> +    case HEX_EVENT_TLB_MISS_RW:
> +        switch (env->cause_code) {
> +        case HEX_CAUSE_TLBMISSRW_CAUSE_READ:
> +        case HEX_CAUSE_TLBMISSRW_CAUSE_WRITE:
> +            qemu_log_mask(CPU_LOG_MMU,
> +                          "TLB miss RW exception (0x%x) caught: "
> +                          "Cause code (0x%x) "
>

Don't use %x


> +                          "TID =3D 0x%" PRIx32 ", PC =3D 0x%" PRIx32
> +                          ", BADVA =3D 0x%" PRIx32 "\n",
> +                          cs->exception_index, env->cause_code,
> env->threadId,
> +                          env->gpr[HEX_REG_PC],
> +                          env->t_sreg[HEX_SREG_BADVA]);
> +
> +            hexagon_ssr_set_cause(env, env->cause_code);
> +            set_addresses(env, 0, cs->exception_index);
> +            /* env->sreg[HEX_SREG_BADVA] is set when the exception is
> raised */
> +            break;
> +
> +        default:
> +            cpu_abort(cs,
> +                      "2:Hexagon exception %d/0x%x: "
> +                      "Unknown cause code %d/0x%x\n",
> +                      cs->exception_index, cs->exception_index,
> env->cause_code,
> +                      env->cause_code);
> +            break;
> +        }
> +        break;
> +
> +    case HEX_EVENT_FPTRAP:
> +        hexagon_ssr_set_cause(env, env->cause_code);
> +        set_addresses(env, 0, cs->exception_index);
> +        break;
> +
> +    case HEX_EVENT_DEBUG:
> +        hexagon_ssr_set_cause(env, env->cause_code);
> +        set_addresses(env, 0, cs->exception_index);
> +        qemu_log_mask(LOG_UNIMP, "single-step exception is not
> handled\n");
> +        break;
> +
> +    case HEX_EVENT_PRECISE:
> +        switch (env->cause_code) {
> +        case HEX_CAUSE_FETCH_NO_XPAGE:
> +        case HEX_CAUSE_FETCH_NO_UPAGE:
> +        case HEX_CAUSE_PRIV_NO_READ:
> +        case HEX_CAUSE_PRIV_NO_UREAD:
> +        case HEX_CAUSE_PRIV_NO_WRITE:
> +        case HEX_CAUSE_PRIV_NO_UWRITE:
> +        case HEX_CAUSE_MISALIGNED_LOAD:
> +        case HEX_CAUSE_MISALIGNED_STORE:
> +        case HEX_CAUSE_PC_NOT_ALIGNED:
> +            qemu_log_mask(CPU_LOG_MMU,
> +                          "MMU permission exception (0x%x) caught: "
> +                          "Cause code (0x%x) "
>

Don't use %x


> +                          "TID =3D 0x%" PRIx32 ", PC =3D 0x%" PRIx32
> +                          ", BADVA =3D 0x%" PRIx32 "\n",
> +                          cs->exception_index, env->cause_code,
> env->threadId,
> +                          env->gpr[HEX_REG_PC],
> +                          env->t_sreg[HEX_SREG_BADVA]);
> +
> +
> +            hexagon_ssr_set_cause(env, env->cause_code);
> +            set_addresses(env, 0, cs->exception_index);
> +            /* env->sreg[HEX_SREG_BADVA] is set when the exception is
> raised */
> +            break;
> +
> +        case HEX_CAUSE_DOUBLE_EXCEPT:
> +        case HEX_CAUSE_PRIV_USER_NO_SINSN:
> +        case HEX_CAUSE_PRIV_USER_NO_GINSN:
> +        case HEX_CAUSE_INVALID_OPCODE:
> +        case HEX_CAUSE_NO_COPROC_ENABLE:
> +        case HEX_CAUSE_NO_COPROC2_ENABLE:
> +        case HEX_CAUSE_UNSUPPORTED_HVX_64B:
> +        case HEX_CAUSE_REG_WRITE_CONFLICT:
> +        case HEX_CAUSE_VWCTRL_WINDOW_MISS:
> +            hexagon_ssr_set_cause(env, env->cause_code);
> +            set_addresses(env, 0, cs->exception_index);
> +            break;
> +
> +        case HEX_CAUSE_COPROC_LDST:
> +            hexagon_ssr_set_cause(env, env->cause_code);
> +            set_addresses(env, 0, cs->exception_index);
> +            break;
> +
> +        case HEX_CAUSE_STACK_LIMIT:
> +            hexagon_ssr_set_cause(env, env->cause_code);
> +            set_addresses(env, 0, cs->exception_index);
> +            break;
> +
> +        default:
> +            cpu_abort(cs,
> +                      "3:Hexagon exception %d/0x%x: "
> +                      "Unknown cause code %d/0x%x\n",
>

Don't use %x


> +                      cs->exception_index, cs->exception_index,
> env->cause_code,
> +                      env->cause_code);
> +            break;
> +        }
> +        break;
> +
> +    case HEX_EVENT_IMPRECISE:
> +        qemu_log_mask(LOG_UNIMP,
> +                "Imprecise exception: this case is not yet handled");
> +        break;
> +
> +    default:
> +        qemu_log_mask(LOG_UNIMP,
> +                "Hexagon Unsupported exception 0x%x/0x%x\n",
>

Don't use %x


> +                  cs->exception_index, env->cause_code);
> +        break;
> +    }
> +
> +    cs->exception_index =3D HEX_EVENT_NONE;
> +}
> +
> +void register_trap_exception(CPUHexagonState *env, int traptype, int imm=
,
> +                             uint32_t PC)
> +{
> +    CPUState *cs =3D env_cpu(env);
> +
> +    cs->exception_index =3D (traptype =3D=3D 0) ? HEX_EVENT_TRAP0 :
> HEX_EVENT_TRAP1;
> +    ASSERT_DIRECT_TO_GUEST_UNSET(env, cs->exception_index);
> +
> +    env->cause_code =3D imm;
> +    env->gpr[HEX_REG_PC] =3D PC;
> +    cpu_loop_exit(cs);
> +}
> --
> 2.34.1
>
>

--000000000000bb6a9e064d04af85
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Mar 10,=
 2026 at 10:08=E2=80=AFPM Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.q=
ualcomm.com">brian.cain@oss.qualcomm.com</a>&gt; wrote:<br></div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">From: Brian Cain &lt;<a href=3D"mai=
lto:bcain@quicinc.com" target=3D"_blank">bcain@quicinc.com</a>&gt;<br>
<br>
Co-authored-by: Mike Lambert &lt;<a href=3D"mailto:mlambert@quicinc.com" ta=
rget=3D"_blank">mlambert@quicinc.com</a>&gt;<br>
Signed-off-by: Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.qualcomm.com=
" target=3D"_blank">brian.cain@oss.qualcomm.com</a>&gt;<br>
---<br>
=C2=A0target/hexagon/hexswi.h |=C2=A0 17 +++<br>
=C2=A0target/hexagon/cpu.c=C2=A0 =C2=A0 |=C2=A0 =C2=A01 +<br>
=C2=A0target/hexagon/hexswi.c | 260 +++++++++++++++++++++++++++++++++++++++=
+<br>
=C2=A03 files changed, 278 insertions(+)<br>
=C2=A0create mode 100644 target/hexagon/hexswi.h<br>
=C2=A0create mode 100644 target/hexagon/hexswi.c<br>
<br>
diff --git a/target/hexagon/hexswi.h b/target/hexagon/hexswi.h<br>
new file mode 100644<br>
index 00000000000..48c1ae6e4c1<br>
--- /dev/null<br>
+++ b/target/hexagon/hexswi.h<br>
@@ -0,0 +1,17 @@<br>
+/*<br>
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.<br>
+ *<br>
+ * SPDX-License-Identifier: GPL-2.0-or-later<br>
+ */<br>
+<br>
+#ifndef HEXSWI_H<br>
+#define HEXSWI_H<br>
+<br>
+<br>
+#include &quot;cpu.h&quot;<br>
+<br>
+void hexagon_cpu_do_interrupt(CPUState *cpu);<br>
+void register_trap_exception(CPUHexagonState *env, int type, int imm,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t PC);<br>
+<br>
+#endif /* HEXSWI_H */<br>
diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c<br>
index 1c8a188dec4..2964d8a63f6 100644<br>
--- a/target/hexagon/cpu.c<br>
+++ b/target/hexagon/cpu.c<br>
@@ -34,6 +34,7 @@<br>
=C2=A0#include &quot;sys_macros.h&quot;<br>
=C2=A0#include &quot;accel/tcg/cpu-ldst.h&quot;<br>
=C2=A0#include &quot;qemu/main-loop.h&quot;<br>
+#include &quot;hex_interrupts.h&quot;<br>
=C2=A0#endif<br>
<br>
=C2=A0static void hexagon_v66_cpu_init(Object *obj) { }<br>
diff --git a/target/hexagon/hexswi.c b/target/hexagon/hexswi.c<br>
new file mode 100644<br>
index 00000000000..77a4dd5bc43<br>
--- /dev/null<br>
+++ b/target/hexagon/hexswi.c<br>
@@ -0,0 +1,260 @@<br>
+/*<br>
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.<br>
+ *<br>
+ * SPDX-License-Identifier: GPL-2.0-or-later<br>
+ */<br>
+<br>
+#include &quot;qemu/osdep.h&quot;<br>
+#include &quot;cpu.h&quot;<br>
+#include &quot;cpu_helper.h&quot;<br>
+#include &quot;exec/helper-proto.h&quot;<br>
+#include &quot;qemu/log.h&quot;<br>
+#include &quot;qemu/main-loop.h&quot;<br>
+#include &quot;arch.h&quot;<br>
+#include &quot;internal.h&quot;<br>
+#include &quot;macros.h&quot;<br>
+#include &quot;sys_macros.h&quot;<br>
+#include &quot;tcg/tcg-op.h&quot;<br>
+#include &quot;hex_mmu.h&quot;<br>
+#include &quot;hexswi.h&quot;<br>
+#include &quot;hw/hexagon/hexagon_globalreg.h&quot;<br>
+<br>
+#ifdef CONFIG_USER_ONLY<br>
+#error &quot;This file is only used in system emulation&quot;<br>
+#endif<br>
+<br>
+static void set_addresses(CPUHexagonState *env, uint32_t pc_offset,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 uint32_t exception_index)<br>
+<br>
+{<br>
+=C2=A0 =C2=A0 HexagonCPU *cpu =3D env_archcpu(env);<br>
+=C2=A0 =C2=A0 uint32_t evb =3D cpu-&gt;globalregs ?<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 hexagon_globalreg_read(cpu-&gt;globalregs, HEX=
_SREG_EVB,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;threadId) :<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu-&gt;boot_addr;<br>
+=C2=A0 =C2=A0 env-&gt;t_sreg[HEX_SREG_ELR] =3D env-&gt;gpr[HEX_REG_PC] + p=
c_offset;<br>
+=C2=A0 =C2=A0 env-&gt;gpr[HEX_REG_PC] =3D evb | (exception_index &lt;&lt; =
2);<br></blockquote><div><br></div><div>Does this work when globalregs=C2=
=A0is false and evb is set to cpu-&gt;boot_addr?</div><div>=C2=A0</div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">
+}<br>
+<br>
+static const char *event_name[] =3D {<br>
+=C2=A0 =C2=A0 [HEX_EVENT_RESET] =3D &quot;HEX_EVENT_RESET&quot;,<br>
+=C2=A0 =C2=A0 [HEX_EVENT_IMPRECISE] =3D &quot;HEX_EVENT_IMPRECISE&quot;,<b=
r>
+=C2=A0 =C2=A0 [HEX_EVENT_PRECISE] =3D &quot;HEX_EVENT_PRECISE&quot;,<br>
+=C2=A0 =C2=A0 [HEX_EVENT_TLB_MISS_X] =3D &quot;HEX_EVENT_TLB_MISS_X&quot;,=
<br>
+=C2=A0 =C2=A0 [HEX_EVENT_TLB_MISS_RW] =3D &quot;HEX_EVENT_TLB_MISS_RW&quot=
;,<br>
+=C2=A0 =C2=A0 [HEX_EVENT_TRAP0] =3D &quot;HEX_EVENT_TRAP0&quot;,<br>
+=C2=A0 =C2=A0 [HEX_EVENT_TRAP1] =3D &quot;HEX_EVENT_TRAP1&quot;,<br>
+=C2=A0 =C2=A0 [HEX_EVENT_FPTRAP] =3D &quot;HEX_EVENT_FPTRAP&quot;,<br>
+=C2=A0 =C2=A0 [HEX_EVENT_DEBUG] =3D &quot;HEX_EVENT_DEBUG&quot;,<br>
+=C2=A0 =C2=A0 [HEX_EVENT_INT0] =3D &quot;HEX_EVENT_INT0&quot;,<br>
+=C2=A0 =C2=A0 [HEX_EVENT_INT1] =3D &quot;HEX_EVENT_INT1&quot;,<br>
+=C2=A0 =C2=A0 [HEX_EVENT_INT2] =3D &quot;HEX_EVENT_INT2&quot;,<br>
+=C2=A0 =C2=A0 [HEX_EVENT_INT3] =3D &quot;HEX_EVENT_INT3&quot;,<br>
+=C2=A0 =C2=A0 [HEX_EVENT_INT4] =3D &quot;HEX_EVENT_INT4&quot;,<br>
+=C2=A0 =C2=A0 [HEX_EVENT_INT5] =3D &quot;HEX_EVENT_INT5&quot;,<br>
+=C2=A0 =C2=A0 [HEX_EVENT_INT6] =3D &quot;HEX_EVENT_INT6&quot;,<br>
+=C2=A0 =C2=A0 [HEX_EVENT_INT7] =3D &quot;HEX_EVENT_INT7&quot;,<br>
+=C2=A0 =C2=A0 [HEX_EVENT_INT8] =3D &quot;HEX_EVENT_INT8&quot;,<br>
+=C2=A0 =C2=A0 [HEX_EVENT_INT9] =3D &quot;HEX_EVENT_INT9&quot;,<br>
+=C2=A0 =C2=A0 [HEX_EVENT_INTA] =3D &quot;HEX_EVENT_INTA&quot;,<br>
+=C2=A0 =C2=A0 [HEX_EVENT_INTB] =3D &quot;HEX_EVENT_INTB&quot;,<br>
+=C2=A0 =C2=A0 [HEX_EVENT_INTC] =3D &quot;HEX_EVENT_INTC&quot;,<br>
+=C2=A0 =C2=A0 [HEX_EVENT_INTD] =3D &quot;HEX_EVENT_INTD&quot;,<br>
+=C2=A0 =C2=A0 [HEX_EVENT_INTE] =3D &quot;HEX_EVENT_INTE&quot;,<br>
+=C2=A0 =C2=A0 [HEX_EVENT_INTF] =3D &quot;HEX_EVENT_INTF&quot;<br>
+};<br>
+<br>
+void hexagon_cpu_do_interrupt(CPUState *cs)<br>
+<br>
+{<br>
+=C2=A0 =C2=A0 CPUHexagonState *env =3D cpu_env(cs);<br>
+=C2=A0 =C2=A0 uint32_t ssr;<br>
+<br>
+=C2=A0 =C2=A0 BQL_LOCK_GUARD();<br>
+<br>
+=C2=A0 =C2=A0 qemu_log_mask(CPU_LOG_INT, &quot;\t%s: event 0x%x:%s, cause =
0x%x(%d)\n&quot;,<br></blockquote><div><br></div><div>Don&#39;t use %x or %=
d in format strings.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __func__, c=
s-&gt;exception_index,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 event_name[=
cs-&gt;exception_index], env-&gt;cause_code,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;cau=
se_code);<br>
+<br>
+=C2=A0 =C2=A0 env-&gt;llsc_addr =3D ~0;<br>
+<br>
+=C2=A0 =C2=A0 ssr =3D env-&gt;t_sreg[HEX_SREG_SSR];<br>
+=C2=A0 =C2=A0 if (GET_SSR_FIELD(SSR_EX, ssr) =3D=3D 1) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 HexagonCPU *cpu =3D env_archcpu(env);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (cpu-&gt;globalregs) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hexagon_globalreg_write(cpu-&gt;=
globalregs, HEX_SREG_DIAG,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;cause_code, en=
v-&gt;threadId);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;cause_code =3D HEX_CAUSE_DOUBLE_EXCEPT=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 cs-&gt;exception_index =3D HEX_EVENT_PRECISE;<=
br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 switch (cs-&gt;exception_index) {<br>
+=C2=A0 =C2=A0 case HEX_EVENT_TRAP0:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (env-&gt;cause_code =3D=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_UNIMP,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &quot;trap0 is unhandled, no semihosting available\n&quot=
;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 hexagon_ssr_set_cause(env, env-&gt;cause_code)=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 set_addresses(env, 4, cs-&gt;exception_index);=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+<br>
+=C2=A0 =C2=A0 case HEX_EVENT_TRAP1:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 hexagon_ssr_set_cause(env, env-&gt;cause_code)=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 set_addresses(env, 4, cs-&gt;exception_index);=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+<br>
+=C2=A0 =C2=A0 case HEX_EVENT_TLB_MISS_X:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (env-&gt;cause_code) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case HEX_CAUSE_TLBMISSX_CAUSE_NORMAL:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case HEX_CAUSE_TLBMISSX_CAUSE_NEXTPAGE:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(CPU_LOG_MMU,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &quot;TLB miss EX exception (0x%x) caught: &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &quot;Cause code (0x%x) &quot;<br></blockquote><div><br><=
/div><div>Don&#39;t use %x</div><div>=C2=A0</div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &quot;TID =3D 0x%&quot; PRIx32 &quot;, PC =3D 0x%&quot; P=
RIx32<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &quot;, BADVA =3D 0x%&quot; PRIx32 &quot;\n&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 cs-&gt;exception_index, env-&gt;cause_code, env-&gt;threa=
dId,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 env-&gt;gpr[HEX_REG_PC],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 env-&gt;t_sreg[HEX_SREG_BADVA]);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hexagon_ssr_set_cause(env, env-&=
gt;cause_code);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 set_addresses(env, 0, cs-&gt;exc=
eption_index);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 default:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_abort(cs,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 &quot;1:Hexagon exception %d/0x%x: &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 &quot;Unknown cause code %d/0x%x\n&quot;,<br></blockquote><div><br></di=
v><div>Don&#39;t use %x</div><div>=C2=A0</div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 cs-&gt;exception_index, cs-&gt;exception_index, env-&gt;cause_code,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 env-&gt;cause_code);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+<br>
+=C2=A0 =C2=A0 case HEX_EVENT_TLB_MISS_RW:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (env-&gt;cause_code) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case HEX_CAUSE_TLBMISSRW_CAUSE_READ:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case HEX_CAUSE_TLBMISSRW_CAUSE_WRITE:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(CPU_LOG_MMU,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &quot;TLB miss RW exception (0x%x) caught: &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &quot;Cause code (0x%x) &quot;<br></blockquote><div><br><=
/div><div>Don&#39;t use %x</div><div>=C2=A0</div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &quot;TID =3D 0x%&quot; PRIx32 &quot;, PC =3D 0x%&quot; P=
RIx32<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &quot;, BADVA =3D 0x%&quot; PRIx32 &quot;\n&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 cs-&gt;exception_index, env-&gt;cause_code, env-&gt;threa=
dId,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 env-&gt;gpr[HEX_REG_PC],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 env-&gt;t_sreg[HEX_SREG_BADVA]);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hexagon_ssr_set_cause(env, env-&=
gt;cause_code);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 set_addresses(env, 0, cs-&gt;exc=
eption_index);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* env-&gt;sreg[HEX_SREG_BADVA] =
is set when the exception is raised */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 default:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_abort(cs,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 &quot;2:Hexagon exception %d/0x%x: &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 &quot;Unknown cause code %d/0x%x\n&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 cs-&gt;exception_index, cs-&gt;exception_index, env-&gt;cause_code,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 env-&gt;cause_code);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+<br>
+=C2=A0 =C2=A0 case HEX_EVENT_FPTRAP:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 hexagon_ssr_set_cause(env, env-&gt;cause_code)=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 set_addresses(env, 0, cs-&gt;exception_index);=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+<br>
+=C2=A0 =C2=A0 case HEX_EVENT_DEBUG:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 hexagon_ssr_set_cause(env, env-&gt;cause_code)=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 set_addresses(env, 0, cs-&gt;exception_index);=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_UNIMP, &quot;single-step exc=
eption is not handled\n&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+<br>
+=C2=A0 =C2=A0 case HEX_EVENT_PRECISE:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (env-&gt;cause_code) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case HEX_CAUSE_FETCH_NO_XPAGE:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case HEX_CAUSE_FETCH_NO_UPAGE:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case HEX_CAUSE_PRIV_NO_READ:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case HEX_CAUSE_PRIV_NO_UREAD:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case HEX_CAUSE_PRIV_NO_WRITE:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case HEX_CAUSE_PRIV_NO_UWRITE:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case HEX_CAUSE_MISALIGNED_LOAD:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case HEX_CAUSE_MISALIGNED_STORE:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case HEX_CAUSE_PC_NOT_ALIGNED:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(CPU_LOG_MMU,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &quot;MMU permission exception (0x%x) caught: &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &quot;Cause code (0x%x) &quot;<br></blockquote><div><br><=
/div><div>Don&#39;t use %x</div><div>=C2=A0</div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &quot;TID =3D 0x%&quot; PRIx32 &quot;, PC =3D 0x%&quot; P=
RIx32<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &quot;, BADVA =3D 0x%&quot; PRIx32 &quot;\n&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 cs-&gt;exception_index, env-&gt;cause_code, env-&gt;threa=
dId,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 env-&gt;gpr[HEX_REG_PC],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 env-&gt;t_sreg[HEX_SREG_BADVA]);<br>
+<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hexagon_ssr_set_cause(env, env-&=
gt;cause_code);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 set_addresses(env, 0, cs-&gt;exc=
eption_index);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* env-&gt;sreg[HEX_SREG_BADVA] =
is set when the exception is raised */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case HEX_CAUSE_DOUBLE_EXCEPT:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case HEX_CAUSE_PRIV_USER_NO_SINSN:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case HEX_CAUSE_PRIV_USER_NO_GINSN:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case HEX_CAUSE_INVALID_OPCODE:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case HEX_CAUSE_NO_COPROC_ENABLE:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case HEX_CAUSE_NO_COPROC2_ENABLE:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case HEX_CAUSE_UNSUPPORTED_HVX_64B:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case HEX_CAUSE_REG_WRITE_CONFLICT:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case HEX_CAUSE_VWCTRL_WINDOW_MISS:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hexagon_ssr_set_cause(env, env-&=
gt;cause_code);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 set_addresses(env, 0, cs-&gt;exc=
eption_index);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case HEX_CAUSE_COPROC_LDST:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hexagon_ssr_set_cause(env, env-&=
gt;cause_code);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 set_addresses(env, 0, cs-&gt;exc=
eption_index);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case HEX_CAUSE_STACK_LIMIT:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hexagon_ssr_set_cause(env, env-&=
gt;cause_code);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 set_addresses(env, 0, cs-&gt;exc=
eption_index);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 default:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_abort(cs,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 &quot;3:Hexagon exception %d/0x%x: &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 &quot;Unknown cause code %d/0x%x\n&quot;,<br></blockquote><div><br></di=
v><div>Don&#39;t use %x</div><div>=C2=A0</div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 cs-&gt;exception_index, cs-&gt;exception_index, env-&gt;cause_code,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 env-&gt;cause_code);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+<br>
+=C2=A0 =C2=A0 case HEX_EVENT_IMPRECISE:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_UNIMP,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;Imprecise ex=
ception: this case is not yet handled&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+<br>
+=C2=A0 =C2=A0 default:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_UNIMP,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;Hexagon Unsu=
pported exception 0x%x/0x%x\n&quot;,<br></blockquote><div><br></div><div>Do=
n&#39;t use %x</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cs-&gt;exce=
ption_index, env-&gt;cause_code);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 cs-&gt;exception_index =3D HEX_EVENT_NONE;<br>
+}<br>
+<br>
+void register_trap_exception(CPUHexagonState *env, int traptype, int imm,<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t PC)<br>
+{<br>
+=C2=A0 =C2=A0 CPUState *cs =3D env_cpu(env);<br>
+<br>
+=C2=A0 =C2=A0 cs-&gt;exception_index =3D (traptype =3D=3D 0) ? HEX_EVENT_T=
RAP0 : HEX_EVENT_TRAP1;<br>
+=C2=A0 =C2=A0 ASSERT_DIRECT_TO_GUEST_UNSET(env, cs-&gt;exception_index);<b=
r>
+<br>
+=C2=A0 =C2=A0 env-&gt;cause_code =3D imm;<br>
+=C2=A0 =C2=A0 env-&gt;gpr[HEX_REG_PC] =3D PC;<br>
+=C2=A0 =C2=A0 cpu_loop_exit(cs);<br>
+}<br>
-- <br>
2.34.1<br>
<br>
</blockquote></div></div>

--000000000000bb6a9e064d04af85--

