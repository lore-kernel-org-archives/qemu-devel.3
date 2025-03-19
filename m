Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD18BC282EC
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 00:31:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuhKo-0002Lt-C7; Tue, 18 Mar 2025 20:31:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tuhKl-0002LL-Qf
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 20:30:59 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tuhKj-0003bE-MU
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 20:30:59 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-223fd89d036so125667935ad.1
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 17:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742344255; x=1742949055; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8dS2260TMwpXbn6fWurwNPQ9Z816dnQDalYIHkhIU40=;
 b=bFsWjDGwBL786OHymGZVQ5vv/68OdfIhPulq0nTJtEE+/+vG0He7+oQCVY64w3C6Dt
 w1Cvg1etuFFWqKr+46Q/Nq5xfXIdblJSFTDlVEJmjVPXubUx5Vm8j3klDtfuSby5dcCy
 7BZepKgH/OaNKsaKKWOfo67sHeSR2CWL5NsXWp6iBBzC/X6tZui4DFfQysY3LuZV3v+7
 BIVWrxTp/LK6nts1qzYTqTYKhvkIdGJkvopJcUfzwEhqqhJ7zk2oRdpoBGGWIKVfiR7r
 9wiF61gBgXnpFocQUjoAdT493wN/S4th/MC7DdAQ2KKp4npD09Mf2K+iBTPpWXrRW9IC
 uPhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742344255; x=1742949055;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8dS2260TMwpXbn6fWurwNPQ9Z816dnQDalYIHkhIU40=;
 b=w9+U6nZXkvCrGXzbJtkuekqQ9Ugav5ODF5xMYUJlIgHwHhy9utBa6+Efu02asqvoWk
 xEP5G5t2zgPZfISEFfLSLi+/9qPbjH5FjywKxXxIw4PHrHfo4+OlBTaobbLArvyG0/ke
 W7e7LyHJKietq/Ft5gFkjk2XZQGfQ3hcwxo3OZkqJ9xNLIN3pbWJJvCwNzKA6+zNh1Vl
 ifij1OTLq5Bjh53ISTqjWZ0/xzQPS37MbZ2N+Z6Yw4R0pYnC7RFX+s4EyOojWqsXGEIc
 WkoPqEyulK1Q6cxSSeYVQQYYGCKLQMlbmvrHxYdzN60/r9vEddkhUHjl8KZJ0oazWWJr
 cC4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhgDw7uSTyg+2uMfYiOPn6WMhAjfuhqk4mc3h/nU7J9x9ElUs/Mhm9p74I4nxcJ+zAAfECXaqsOtOm@nongnu.org
X-Gm-Message-State: AOJu0Yx/r2DgeWlnRqhXphWqoTj5g4OlujJcCqg9frBc1yBjuafb4bg5
 stFU4cRzrQO4aBCsfgYOdT2gwtx9M6Pebd7Efvrl+yQXKEBBfhWlor/xKo5fPKk=
X-Gm-Gg: ASbGncuC0L/HwZOKiPu291kGdq7gFq4qsHkLYsDSJExR8a1I/W/UmfH/sM7hrs6pBys
 fQdxAf02zYo60DQLNkq0hLmQOD85R1Ml4szMoTiIfdL1GGHcABv/T0E+JP0UfcW63Gitk8ANMHW
 VTCCxbaIGEkK+4xYFvoLv0GtEjzxSEn+Dv4qqpsUuGc9KQI4WDMuaueEa1uyAEX+xHUhaoitXxx
 vPLeo6ReQMRmmvuNIGcgCD//9B7p4XVLVzSusRGAbnSglB3sFZoPsCCee0R/GSu4PAD0Y7HUn80
 6m5/LXOGweLzFq2/yZEYDboj+Em7L4spq+yNvxRN9yv6VDzlLArRN2kr4Q==
X-Google-Smtp-Source: AGHT+IGvaYE3UJjH+iL9WAfYRHGEJzBo8xspnrFscVKvMsBQMlby619GzAySUOogjiJVYftZjuVhpw==
X-Received: by 2002:a17:902:e747:b0:225:ac99:ae08 with SMTP id
 d9443c01a7336-2264992df73mr13210495ad.5.1742344255225; 
 Tue, 18 Mar 2025 17:30:55 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-301bf58b413sm179869a91.13.2025.03.18.17.30.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Mar 2025 17:30:54 -0700 (PDT)
Message-ID: <618b1e6a-21ff-4fb3-9d43-a1ef123ab138@linaro.org>
Date: Tue, 18 Mar 2025 17:30:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 29/42] include/exec: Split out watchpoint.h
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@linaro.org
References: <20250318213209.2579218-1-richard.henderson@linaro.org>
 <20250318213209.2579218-30-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250318213209.2579218-30-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62a.google.com
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

On 3/18/25 14:31, Richard Henderson wrote:
> Relatively few objects in qemu care about watchpoints, so split
> out to a new header.  Removes an instance of CONFIG_USER_ONLY
> from hw/core/cpu.h.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/watchpoint.h           | 41 +++++++++++++++++++++++++++++
>   include/hw/core/cpu.h               | 30 ---------------------
>   accel/tcg/tcg-accel-ops.c           |  1 +
>   system/watchpoint.c                 |  1 +
>   target/arm/debug_helper.c           |  1 +
>   target/i386/cpu.c                   |  1 +
>   target/i386/machine.c               |  2 +-
>   target/i386/tcg/system/bpt_helper.c |  1 +
>   target/ppc/cpu.c                    |  1 +
>   target/ppc/cpu_init.c               |  2 +-
>   target/riscv/debug.c                |  1 +
>   target/s390x/helper.c               |  1 +
>   target/s390x/tcg/excp_helper.c      |  1 +
>   target/xtensa/dbg_helper.c          |  1 +
>   14 files changed, 53 insertions(+), 32 deletions(-)
>   create mode 100644 include/exec/watchpoint.h
> 
> diff --git a/include/exec/watchpoint.h b/include/exec/watchpoint.h
> new file mode 100644
> index 0000000000..4b6668826c
> --- /dev/null
> +++ b/include/exec/watchpoint.h
> @@ -0,0 +1,41 @@
> +/*
> + * CPU watchpoints
> + *
> + * Copyright (c) 2012 SUSE LINUX Products GmbH
> + * SPDX-License-Identifier: LGPL-2.1-or-later
> + */
> +
> +#ifndef EXEC_WATCHPOINT_H
> +#define EXEC_WATCHPOINT_H
> +
> +#if defined(CONFIG_USER_ONLY)
> +static inline int cpu_watchpoint_insert(CPUState *cpu, vaddr addr, vaddr len,
> +                                        int flags, CPUWatchpoint **watchpoint)
> +{
> +    return -ENOSYS;
> +}
> +
> +static inline int cpu_watchpoint_remove(CPUState *cpu, vaddr addr,
> +                                        vaddr len, int flags)
> +{
> +    return -ENOSYS;
> +}
> +
> +static inline void cpu_watchpoint_remove_by_ref(CPUState *cpu,
> +                                                CPUWatchpoint *wp)
> +{
> +}
> +
> +static inline void cpu_watchpoint_remove_all(CPUState *cpu, int mask)
> +{
> +}
> +#else
> +int cpu_watchpoint_insert(CPUState *cpu, vaddr addr, vaddr len,
> +                          int flags, CPUWatchpoint **watchpoint);
> +int cpu_watchpoint_remove(CPUState *cpu, vaddr addr,
> +                          vaddr len, int flags);
> +void cpu_watchpoint_remove_by_ref(CPUState *cpu, CPUWatchpoint *watchpoint);
> +void cpu_watchpoint_remove_all(CPUState *cpu, int mask);
> +#endif
> +
> +#endif /* EXEC_WATCHPOINT_H */
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index 5d11d26556..d1c1fefea3 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -1109,36 +1109,6 @@ static inline bool cpu_breakpoint_test(CPUState *cpu, vaddr pc, int mask)
>       return false;
>   }
>   
> -#if defined(CONFIG_USER_ONLY)
> -static inline int cpu_watchpoint_insert(CPUState *cpu, vaddr addr, vaddr len,
> -                                        int flags, CPUWatchpoint **watchpoint)
> -{
> -    return -ENOSYS;
> -}
> -
> -static inline int cpu_watchpoint_remove(CPUState *cpu, vaddr addr,
> -                                        vaddr len, int flags)
> -{
> -    return -ENOSYS;
> -}
> -
> -static inline void cpu_watchpoint_remove_by_ref(CPUState *cpu,
> -                                                CPUWatchpoint *wp)
> -{
> -}
> -
> -static inline void cpu_watchpoint_remove_all(CPUState *cpu, int mask)
> -{
> -}
> -#else
> -int cpu_watchpoint_insert(CPUState *cpu, vaddr addr, vaddr len,
> -                          int flags, CPUWatchpoint **watchpoint);
> -int cpu_watchpoint_remove(CPUState *cpu, vaddr addr,
> -                          vaddr len, int flags);
> -void cpu_watchpoint_remove_by_ref(CPUState *cpu, CPUWatchpoint *watchpoint);
> -void cpu_watchpoint_remove_all(CPUState *cpu, int mask);
> -#endif
> -
>   /**
>    * cpu_get_address_space:
>    * @cpu: CPU to get address space from
> diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
> index d9b662efe3..5c88056157 100644
> --- a/accel/tcg/tcg-accel-ops.c
> +++ b/accel/tcg/tcg-accel-ops.c
> @@ -37,6 +37,7 @@
>   #include "exec/hwaddr.h"
>   #include "exec/tb-flush.h"
>   #include "exec/translation-block.h"
> +#include "exec/watchpoint.h"
>   #include "gdbstub/enums.h"
>   
>   #include "hw/core/cpu.h"
> diff --git a/system/watchpoint.c b/system/watchpoint.c
> index 08dbd8483d..21d0bb36ca 100644
> --- a/system/watchpoint.c
> +++ b/system/watchpoint.c
> @@ -21,6 +21,7 @@
>   #include "qemu/error-report.h"
>   #include "exec/cputlb.h"
>   #include "exec/target_page.h"
> +#include "exec/watchpoint.h"
>   #include "hw/core/cpu.h"
>   
>   /* Add a watchpoint.  */
> diff --git a/target/arm/debug_helper.c b/target/arm/debug_helper.c
> index a9a619ba6b..473ee2af38 100644
> --- a/target/arm/debug_helper.c
> +++ b/target/arm/debug_helper.c
> @@ -13,6 +13,7 @@
>   #include "cpregs.h"
>   #include "exec/exec-all.h"
>   #include "exec/helper-proto.h"
> +#include "exec/watchpoint.h"
>   #include "system/tcg.h"
>   
>   #ifdef CONFIG_TCG
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index dba1b3ffef..af46c7a392 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -35,6 +35,7 @@
>   #include "standard-headers/asm-x86/kvm_para.h"
>   #include "hw/qdev-properties.h"
>   #include "hw/i386/topology.h"
> +#include "exec/watchpoint.h"
>   #ifndef CONFIG_USER_ONLY
>   #include "system/reset.h"
>   #include "qapi/qapi-commands-machine-target.h"
> diff --git a/target/i386/machine.c b/target/i386/machine.c
> index 70f632a36f..6cb561c632 100644
> --- a/target/i386/machine.c
> +++ b/target/i386/machine.c
> @@ -7,7 +7,7 @@
>   #include "hw/i386/x86.h"
>   #include "kvm/kvm_i386.h"
>   #include "hw/xen/xen.h"
> -
> +#include "exec/watchpoint.h"
>   #include "system/kvm.h"
>   #include "system/kvm_xen.h"
>   #include "system/tcg.h"
> diff --git a/target/i386/tcg/system/bpt_helper.c b/target/i386/tcg/system/bpt_helper.c
> index be232c1ca9..08ccd3f5e6 100644
> --- a/target/i386/tcg/system/bpt_helper.c
> +++ b/target/i386/tcg/system/bpt_helper.c
> @@ -21,6 +21,7 @@
>   #include "cpu.h"
>   #include "exec/exec-all.h"
>   #include "exec/helper-proto.h"
> +#include "exec/watchpoint.h"
>   #include "tcg/helper-tcg.h"
>   
>   
> diff --git a/target/ppc/cpu.c b/target/ppc/cpu.c
> index bfcc695de7..4d8faaddee 100644
> --- a/target/ppc/cpu.c
> +++ b/target/ppc/cpu.c
> @@ -22,6 +22,7 @@
>   #include "cpu-models.h"
>   #include "cpu-qom.h"
>   #include "exec/log.h"
> +#include "exec/watchpoint.h"
>   #include "fpu/softfloat-helpers.h"
>   #include "mmu-hash64.h"
>   #include "helper_regs.h"
> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> index 8b590e7f17..7394ffc557 100644
> --- a/target/ppc/cpu_init.c
> +++ b/target/ppc/cpu_init.c
> @@ -40,7 +40,7 @@
>   #include "qemu/cutils.h"
>   #include "disas/capstone.h"
>   #include "fpu/softfloat.h"
> -
> +#include "exec/watchpoint.h"
>   #include "helper_regs.h"
>   #include "internal.h"
>   #include "spr_common.h"
> diff --git a/target/riscv/debug.c b/target/riscv/debug.c
> index 9db4048523..fea989afe9 100644
> --- a/target/riscv/debug.c
> +++ b/target/riscv/debug.c
> @@ -30,6 +30,7 @@
>   #include "trace.h"
>   #include "exec/exec-all.h"
>   #include "exec/helper-proto.h"
> +#include "exec/watchpoint.h"
>   #include "system/cpu-timers.h"
>   
>   /*
> diff --git a/target/s390x/helper.c b/target/s390x/helper.c
> index c689e11b46..e660c69f60 100644
> --- a/target/s390x/helper.c
> +++ b/target/s390x/helper.c
> @@ -27,6 +27,7 @@
>   #include "target/s390x/kvm/pv.h"
>   #include "system/hw_accel.h"
>   #include "system/runstate.h"
> +#include "exec/watchpoint.h"
>   
>   void s390x_tod_timer(void *opaque)
>   {
> diff --git a/target/s390x/tcg/excp_helper.c b/target/s390x/tcg/excp_helper.c
> index ac733f407f..1d51043e88 100644
> --- a/target/s390x/tcg/excp_helper.c
> +++ b/target/s390x/tcg/excp_helper.c
> @@ -24,6 +24,7 @@
>   #include "exec/helper-proto.h"
>   #include "exec/cputlb.h"
>   #include "exec/exec-all.h"
> +#include "exec/watchpoint.h"
>   #include "s390x-internal.h"
>   #include "tcg_s390x.h"
>   #ifndef CONFIG_USER_ONLY
> diff --git a/target/xtensa/dbg_helper.c b/target/xtensa/dbg_helper.c
> index 163a1ffc7b..c4f4298a50 100644
> --- a/target/xtensa/dbg_helper.c
> +++ b/target/xtensa/dbg_helper.c
> @@ -31,6 +31,7 @@
>   #include "exec/helper-proto.h"
>   #include "qemu/host-utils.h"
>   #include "exec/exec-all.h"
> +#include "exec/watchpoint.h"
>   #include "system/address-spaces.h"
>   
>   void HELPER(wsr_ibreakenable)(CPUXtensaState *env, uint32_t v)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

To push further, it could be worth to remove inline stubs, put 
definitions in common-user/watchpoint.c, and add this file to user_ss.

