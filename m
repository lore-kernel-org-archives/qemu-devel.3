Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 718ABC35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 21:29:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tv0xc-0006oT-Mk; Wed, 19 Mar 2025 17:28:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tv0xV-0006nb-Gc
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 17:28:18 -0400
Received: from mail-qk1-x72b.google.com ([2607:f8b0:4864:20::72b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tv0xT-0007NR-5l
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 17:28:17 -0400
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-7c56321b22cso12775485a.1
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 14:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742419694; x=1743024494; darn=nongnu.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=S8DbKhe32JRrL++4AZWPDqZaY1sZ9qrvz+bqUxv/2mU=;
 b=Sdtk99vA2SJ8XBAycP4VtJZQWbX2K0FdnCfzdS0vpGc1GpkAh0HEVnoIMF+dCIH9Su
 SnF3QjcxKcO4Z1R5e1tSf51n4zPCDFWFJfiY0CpvYlFIPSR3yzvbUygXuPehu5da2hgF
 84ABCqXZUH7ca2Nrv1PCMP81PSPfMnVeMl17GR3FfPd5ytigIR0PFeCPOJjKUgY7tiGI
 w9o4DUVyclEvM6/Uh6EwkcrmeCDfbyH+7PsiQ0K0s1SQU9ZC6ZatBqJe7MaUICnR1Xrl
 KPukujAKLoeeNAeKvoUzh/7/6fsYarTN3VmvIy6Er9kgB01h/ZjA+4cNYcIRAGlbfFHT
 8C2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742419694; x=1743024494;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=S8DbKhe32JRrL++4AZWPDqZaY1sZ9qrvz+bqUxv/2mU=;
 b=gYl8+W9BZ4+Y1E9GXWs7kxagjbLL2kfZ3RDT2rej2f4oXOQrsVTnzZQCPjqfsrqhFw
 4N5IUwNo1VHDAhW30p5LSYZVbiUEYxBfnhwd3rGOpEsKAhbD3PRI173PkFQjgVEibr2v
 DnrQcLWlZZ0VuolFM1q+WwY5/SMZV+m3yFxoBtdUhK4P4rli3eywmfGXIaqLFgFf5zzR
 ZpTh+7HZ5MoKCdpOczc7QdhEkBKLLjoXRYtEB/bdzj1prjlTB88k3/xFLS9OFFiIo8BJ
 6a5AqHXsIb41IcgoEnii5WliaxtNqTBJybrVGjOJ5aBxP99C0EiC61Z60MnNBTb95/w6
 947g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuiW4k8lTQVNcvHAsyXPqJIZjR82YE1Blif13JhrtWz7BYM5ImcwzMDy/Vf4K5qJMihZsfL/fVRGND@nongnu.org
X-Gm-Message-State: AOJu0Yy3bkFFFRveuYUKSM2wcEUjgT5TpNbBZmUOkD0v/NxIDnJFmhbc
 W+1mxIrM+zwdU/uPBy2oD0fhXsQzCHaRBx1OYMut2jogcGKfyjAv
X-Gm-Gg: ASbGncvaVdU4EMsuQd8isG4BAITHFH4dknOqVjxeK+RWqrXrDIl3zQ8CJs3S0yMkRNW
 bikqjm5HL2wLIDOCrr1H3DIbUCGcrPdIZwK1iaT3TFS8pPuCdEL5qhRxKowSeJmCR3+zWwuRMDY
 UHUWTMfrIeXNfcvslHORhJ/PUHpxXyAUhMQm7Rn3Miz1aXRjWwxty+44mmFHvNGeLPKl3YdeUnD
 uubuIFZ3qD1XV6YtTtvY/ThDyt75gV6+1Qx1YKMpe3XA7NeRBiPc6YtR/OCUU6D4LgITXGGLjhI
 w84l3SrWIeEH4JjMYjEEpKRu97i6WSvmFNJqDFMMv6URsW3lmpzYqqP/o9lhTJXYzm3cd97B
X-Google-Smtp-Source: AGHT+IH+FsNImI6zzZP+iYkeU/dGiqVhgpDDFBnohQ9JdZN/iI3E+Pk0jLkvmRdhUiu7TS/Hrb4OtA==
X-Received: by 2002:a05:620a:d86:b0:7c5:99e7:1d4a with SMTP id
 af79cd13be357-7c5b0519013mr208448085a.8.1742419693900; 
 Wed, 19 Mar 2025 14:28:13 -0700 (PDT)
Received: from DESKTOPUU50BPD ([2603:6000:a500:306:992d:4509:eca7:6f8])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c573c9e081sm904970685a.56.2025.03.19.14.28.12
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 19 Mar 2025 14:28:13 -0700 (PDT)
From: <ltaylorsimpson@gmail.com>
To: "'Brian Cain'" <brian.cain@oss.qualcomm.com>,
	<qemu-devel@nongnu.org>
Cc: <richard.henderson@linaro.org>, <philmd@linaro.org>,
 <quic_mathbern@quicinc.com>, <ale@rev.ng>, <anjo@rev.ng>,
 <quic_mliebel@quicinc.com>, <alex.bennee@linaro.org>,
 <quic_mburton@quicinc.com>, <sidneym@quicinc.com>,
 "'Brian Cain'" <bcain@quicinc.com>, "'Mike Lambert'" <mlambert@quicinc.com>
References: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
 <20250301052845.1012069-18-brian.cain@oss.qualcomm.com>
In-Reply-To: <20250301052845.1012069-18-brian.cain@oss.qualcomm.com>
Subject: RE: [PATCH 17/39] target/hexagon: Implement software interrupt
Date: Wed, 19 Mar 2025 16:28:11 -0500
Message-ID: <02e101db9915$d1c42fe0$754c8fa0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIWUu77rEigiK0ljjjo9ZdCZqs5mQHhbL4QsvZ2Q8A=
Content-Language: en-us
X-Antivirus: Norton (VPS 250319-0, 3/18/2025), Outbound message
X-Antivirus-Status: Clean
Received-SPF: pass client-ip=2607:f8b0:4864:20::72b;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-qk1-x72b.google.com
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
> Sent: Friday, February 28, 2025 11:28 PM
> To: qemu-devel@nongnu.org
> Cc: brian.cain@oss.qualcomm.com; richard.henderson@linaro.org;
> philmd@linaro.org; quic_mathbern@quicinc.com; ale@rev.ng; anjo@rev.ng;
> quic_mliebel@quicinc.com; ltaylorsimpson@gmail.com;
> alex.bennee@linaro.org; quic_mburton@quicinc.com;
> sidneym@quicinc.com; Brian Cain <bcain@quicinc.com>; Mike Lambert
> <mlambert@quicinc.com>
> Subject: [PATCH 17/39] target/hexagon: Implement software interrupt
>=20
> From: Brian Cain <bcain@quicinc.com>
>=20
> Co-authored-by: Mike Lambert <mlambert@quicinc.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/cpu.h       |   1 -
>  target/hexagon/hexswi.h    |  17 +++
>  target/hexagon/cpu.c       |   2 +
>  target/hexagon/hexswi.c    | 258
> +++++++++++++++++++++++++++++++++++++
>  target/hexagon/op_helper.c |   1 +
>  5 files changed, 278 insertions(+), 1 deletion(-)  create mode 100644
> target/hexagon/hexswi.h  create mode 100644 target/hexagon/hexswi.c
>=20
> diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h index
> dabee310c5..045581d7be 100644
> --- a/target/hexagon/cpu.h
> +++ b/target/hexagon/cpu.h
> @@ -256,5 +256,4 @@ typedef HexagonCPU ArchCPU;  void
> hexagon_translate_init(void);  void hexagon_translate_code(CPUState =
*cs,
> TranslationBlock *tb,
>                              int *max_insns, vaddr pc, void *host_pc);
> -

Gratuitous change

>  #endif /* HEXAGON_CPU_H */
> diff --git a/target/hexagon/hexswi.h b/target/hexagon/hexswi.h new =
file
> mode 100644 index 0000000000..5d232cb06c
> --- /dev/null
> +++ b/target/hexagon/hexswi.h
> @@ -0,0 +1,17 @@
> +/*
> + * Copyright(c) 2025 Qualcomm Innovation Center, Inc. All Rights =
Reserved.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later  */
> +
> +#ifndef HEXSWI_H
> +#define HEXSWI_H
> +
> +
> +#include "cpu.h"
> +
> +void hexagon_cpu_do_interrupt(CPUState *cpu); void
> +register_trap_exception(CPUHexagonState *env, int type, int imm,
> +                             target_ulong PC);
> +
> +#endif /* HEXSWI_H */
> diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c index
> 89a051b41d..843be8221f 100644
> --- a/target/hexagon/cpu.c
> +++ b/target/hexagon/cpu.c
> @@ -33,6 +33,8 @@
>  #ifndef CONFIG_USER_ONLY
>  #include "sys_macros.h"
>  #include "qemu/main-loop.h"
> +#include "hex_interrupts.h"
> +#include "hexswi.h"

Move these added include to a different patch where the contents are =
needed.

>  #endif
>=20
>  static void hexagon_v66_cpu_init(Object *obj) { } diff --git
> a/target/hexagon/hexswi.c b/target/hexagon/hexswi.c new file mode
> 100644 index 0000000000..5fcf9b2be9
> --- /dev/null
> +++ b/target/hexagon/hexswi.c
> @@ -0,0 +1,258 @@
> +/*
> + * Copyright(c) 2019-2025 Qualcomm Innovation Center, Inc. All Rights
> Reserved.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later  */
> +
> +#include "qemu/osdep.h"
> +#include "cpu.h"
> +#ifdef CONFIG_USER_ONLY

This file is only included in the system-mode build, so we don't need =
these guards.  Several in this file.

> +#include "exec/helper-proto.h"
> +#include "qemu.h"
> +#endif
> +#include "exec/cpu_ldst.h"
> +#include "exec/exec-all.h"
> +#include "qemu/log.h"
> +#include "qemu/main-loop.h"
> +#include "arch.h"
> +#include "internal.h"
> +#include "macros.h"
> +#include "sys_macros.h"
> +#include "tcg/tcg-op.h"
> +#ifndef CONFIG_USER_ONLY
> +#include "hex_mmu.h"
> +#include "hexswi.h"
> +#endif
> +
> +#ifndef CONFIG_USER_ONLY
> +
> +
> +static void set_addresses(CPUHexagonState *env, target_ulong =
pc_offset,
> +                          target_ulong exception_index)
> +
> +{
> +    arch_set_system_reg(env, HEX_SREG_ELR,
> +                        arch_get_thread_reg(env, HEX_REG_PC) + =
pc_offset);
> +    arch_set_thread_reg(env, HEX_REG_PC,
> +                        arch_get_system_reg(env, HEX_SREG_EVB) |
> +                            (exception_index << 2)); }
> +
> +static const char *event_name[] =3D {
> +    [HEX_EVENT_RESET] =3D "HEX_EVENT_RESET",
> +    [HEX_EVENT_IMPRECISE] =3D "HEX_EVENT_IMPRECISE",
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
> +    BQL_LOCK_GUARD();
> +
> +    qemu_log_mask(CPU_LOG_INT, "\t%s: event 0x%x:%s, cause
> 0x%x(%d)\n",
> +                  __func__, cs->exception_index,
> +                  event_name[cs->exception_index], env->cause_code,
> +                  env->cause_code);
> +
> +    env->llsc_addr =3D ~0;
> +
> +    uint32_t ssr =3D arch_get_system_reg(env, HEX_SREG_SSR);

Declarations at the beginning of the function.

> +    if (GET_SSR_FIELD(SSR_EX, ssr) =3D=3D 1) {
> +        arch_set_system_reg(env, HEX_SREG_DIAG, env->cause_code);
> +        env->cause_code =3D HEX_CAUSE_DOUBLE_EXCEPT;
> +        cs->exception_index =3D HEX_EVENT_PRECISE;
> +    }
> +
> +    switch (cs->exception_index) {
> +    case HEX_EVENT_TRAP0:
> +        if (env->cause_code =3D=3D 0) {
> +            qemu_log_mask(LOG_UNIMP,
> +                          "trap0 is unhandled, no semihosting =
available\n");
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
> +                          "TID =3D 0x%" PRIx32 ", PC =3D 0x%" PRIx32
> +                          ", BADVA =3D 0x%" PRIx32 "\n",
> +                          cs->exception_index, env->cause_code, =
env->threadId,
> +                          arch_get_thread_reg(env, HEX_REG_PC),
> +                          arch_get_system_reg(env, HEX_SREG_BADVA));
> +
> +            hexagon_ssr_set_cause(env, env->cause_code);
> +            set_addresses(env, 0, cs->exception_index);
> +            break;
> +
> +        default:
> +            cpu_abort(cs,
> +                      "1:Hexagon exception %d/0x%x: "
> +                      "Unknown cause code %d/0x%x\n",
> +                      cs->exception_index, cs->exception_index, =
env->cause_code,
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
> +                          "TID =3D 0x%" PRIx32 ", PC =3D 0x%" PRIx32
> +                          ", BADVA =3D 0x%" PRIx32 "\n",
> +                          cs->exception_index, env->cause_code, =
env->threadId,
> +                          env->gpr[HEX_REG_PC],
> +                          arch_get_system_reg(env, HEX_SREG_BADVA));
> +
> +            hexagon_ssr_set_cause(env, env->cause_code);
> +            set_addresses(env, 0, cs->exception_index);
> +            /* env->sreg[HEX_SREG_BADVA] is set when the exception is =
raised
> */
> +            break;
> +
> +        default:
> +            cpu_abort(cs,
> +                      "2:Hexagon exception %d/0x%x: "
> +                      "Unknown cause code %d/0x%x\n",
> +                      cs->exception_index, cs->exception_index, =
env->cause_code,
> +                      env->cause_code);
> +            break;
> +        }
> +        break;
> +
> +    case HEX_EVENT_FPTRAP:
> +        hexagon_ssr_set_cause(env, env->cause_code);
> +        arch_set_thread_reg(env, HEX_REG_PC,
> +                            arch_get_system_reg(env, HEX_SREG_EVB) |
> +                                (cs->exception_index << 2));

Why not use set_addresses here?  How is ELR set?

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
> +                          "TID =3D 0x%" PRIx32 ", PC =3D 0x%" PRIx32
> +                          ", BADVA =3D 0x%" PRIx32 "\n",
> +                          cs->exception_index, env->cause_code, =
env->threadId,
> +                          env->gpr[HEX_REG_PC],
> +                          arch_get_system_reg(env, HEX_SREG_BADVA));
> +
> +
> +            hexagon_ssr_set_cause(env, env->cause_code);
> +            set_addresses(env, 0, cs->exception_index);
> +            /* env->sreg[HEX_SREG_BADVA] is set when the exception is =
raised
> */
> +            break;
> +
> +        case HEX_CAUSE_DOUBLE_EXCEPT:
> +        case HEX_CAUSE_PRIV_USER_NO_SINSN:
> +        case HEX_CAUSE_PRIV_USER_NO_GINSN:
> +        case HEX_CAUSE_INVALID_OPCODE:
> +        case HEX_CAUSE_NO_COPROC_ENABLE:
> +        case HEX_CAUSE_NO_COPROC2_ENABLE:
> +        case HEX_CAUSE_UNSUPORTED_HVX_64B:
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
> +                      cs->exception_index, cs->exception_index, =
env->cause_code,
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
> +                  cs->exception_index, env->cause_code);
> +        break;
> +    }
> +
> +    cs->exception_index =3D HEX_EVENT_NONE; }
> +
> +void register_trap_exception(CPUHexagonState *env, int traptype, int
> imm,
> +                             target_ulong PC) {
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
> +#endif
> diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
> index 42805d0f1d..687e7f45c2 100644
> --- a/target/hexagon/op_helper.c
> +++ b/target/hexagon/op_helper.c
> @@ -38,6 +38,7 @@
>  #include "hex_mmu.h"
>  #include "hw/intc/l2vic.h"
>  #include "hex_interrupts.h"
> +#include "hexswi.h"

Move this do a different patch where the contents are needed

>  #endif
>=20
>  #define SF_BIAS        127
> --
> 2.34.1



