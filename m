Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39B27C54E68
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 21:02:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmgah-0003hl-5U; Tue, 19 Mar 2024 17:01:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1rmgae-0003fZ-KF
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 17:01:44 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1rmgac-0005qI-AI
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 17:01:44 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-513ccc70a6dso10380579e87.1
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 14:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710882100; x=1711486900; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=1Z3BC4aZqYfmkT0MIaPS7MzDIJklWpLXS1BcfmCujVc=;
 b=e/FMITRcg/pT+POEifqJkj7qd1tKR08CBEqoK9c1M0Js2OCsw0da4q6zJy1yOlhFXk
 H8I7+C2wyro34/cHxfG7AF6+7aNgMw/bFAkdNb7XSu1QdBpDHKpOAZ3jRNP0gg75YRp/
 UVRoIiQXWbPWh5UdLPLUHuiJipJYke1pBXiZPMxyGaaSqTji1LsdoifPKS8yKTV18xiD
 CHXvu63wh6hKIeNzwH1qJ81BnOXyyAqaiQ41bVMI/Oy0aR4xHVg+zisNCkbLehSf6ors
 YC2rOYjdI0UqbhNTmLl+FFB5MQisvIHFqvy6SwesiFhG/uHyPqAL9vtvKSIeGTahJo/3
 /lIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710882100; x=1711486900;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1Z3BC4aZqYfmkT0MIaPS7MzDIJklWpLXS1BcfmCujVc=;
 b=lMDSm+jOLV5FAnFM4DAYcUDWy7YpYpl+V7QksX9ORE767TCzY62JXR3StiXdh/RY65
 AebojdSg+99srCoBt9xyjiPRLnh5xJDRwFD9wjEtc4WNpMTnS11CL379/whP1pfMsEF/
 CeRep/K06l6DgZmzerg1qG87yxAmn8h4vxPlP8EIawW7AzNqg+5tnwnzgT8Q9IGBTOrT
 l0JCvRMwJcUVW+pgB6saScTCzq/Vgt7VpV53QuLDVHuJ8L0VU5M/YUZlA0jtat6/IP3T
 nlJra7xCcZ+kbh/F/1KimWXHVKCFaMgriaSNuBcmXopndZg2wg2y8oQttPYqm1j5d6AB
 3ODA==
X-Gm-Message-State: AOJu0Yy13Nl/ZCbdlDqV8w//BhXF38d74PVG7GsVsKODF/CbJnG0SKdR
 MUMV6h0y5jKPuls8muCeYnIkx5INYYyu1/lUfGVfY3LJ02xm07Ul
X-Google-Smtp-Source: AGHT+IE0JH4N5SVx2oGhfkHLBEgltByM+66txJo++UQFcOOYSk4096zC6gDEB858Gh5Rj2AWdKsXsA==
X-Received: by 2002:a19:6907:0:b0:514:b450:99b4 with SMTP id
 e7-20020a196907000000b00514b45099b4mr4587210lfc.65.1710882100501; 
 Tue, 19 Mar 2024 14:01:40 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 be37-20020a056512252500b00513dd355e19sm849131lfb.165.2024.03.19.14.01.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Mar 2024 14:01:40 -0700 (PDT)
Date: Tue, 19 Mar 2024 22:01:39 +0100
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Anton Johansson <anjo@rev.ng>,
 Alistair Francis <alistair@alistair23.me>
Subject: Re: [PATCH-for-9.1 7/8] target/microblaze: Move MMU helpers to
 sys_helper.c
Message-ID: <Zfn9M6cjVCo93iey@toto>
References: <20240319062855.8025-1-philmd@linaro.org>
 <20240319062855.8025-8-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240319062855.8025-8-philmd@linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x12b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Tue, Mar 19, 2024 at 07:28:54AM +0100, Philippe Mathieu-Daudé wrote:
> MMU helpers are only used during system emulation,
> move them to sys_helper.c.

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>


> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  target/microblaze/op_helper.c  | 48 ----------------------------------
>  target/microblaze/sys_helper.c | 47 +++++++++++++++++++++++++++++++++
>  2 files changed, 47 insertions(+), 48 deletions(-)
> 
> diff --git a/target/microblaze/op_helper.c b/target/microblaze/op_helper.c
> index f6378030b7..45dbed4aaa 100644
> --- a/target/microblaze/op_helper.c
> +++ b/target/microblaze/op_helper.c
> @@ -381,51 +381,3 @@ void helper_stackprot(CPUMBState *env, target_ulong addr)
>          cpu_loop_exit_restore(cs, GETPC());
>      }
>  }
> -
> -#if !defined(CONFIG_USER_ONLY)
> -/* Writes/reads to the MMU's special regs end up here.  */
> -uint32_t helper_mmu_read(CPUMBState *env, uint32_t ext, uint32_t rn)
> -{
> -    return mmu_read(env, ext, rn);
> -}
> -
> -void helper_mmu_write(CPUMBState *env, uint32_t ext, uint32_t rn, uint32_t v)
> -{
> -    mmu_write(env, ext, rn, v);
> -}
> -
> -void mb_cpu_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr addr,
> -                               unsigned size, MMUAccessType access_type,
> -                               int mmu_idx, MemTxAttrs attrs,
> -                               MemTxResult response, uintptr_t retaddr)
> -{
> -    MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
> -    CPUMBState *env = &cpu->env;
> -
> -    qemu_log_mask(CPU_LOG_INT, "Transaction failed: vaddr 0x%" VADDR_PRIx
> -                  " physaddr 0x" HWADDR_FMT_plx " size %d access type %s\n",
> -                  addr, physaddr, size,
> -                  access_type == MMU_INST_FETCH ? "INST_FETCH" :
> -                  (access_type == MMU_DATA_LOAD ? "DATA_LOAD" : "DATA_STORE"));
> -
> -    if (!(env->msr & MSR_EE)) {
> -        return;
> -    }
> -
> -    if (access_type == MMU_INST_FETCH) {
> -        if (!cpu->cfg.iopb_bus_exception) {
> -            return;
> -        }
> -        env->esr = ESR_EC_INSN_BUS;
> -    } else {
> -        if (!cpu->cfg.dopb_bus_exception) {
> -            return;
> -        }
> -        env->esr = ESR_EC_DATA_BUS;
> -    }
> -
> -    env->ear = addr;
> -    cs->exception_index = EXCP_HW_EXCP;
> -    cpu_loop_exit_restore(cs, retaddr);
> -}
> -#endif
> diff --git a/target/microblaze/sys_helper.c b/target/microblaze/sys_helper.c
> index 5180500354..7531f95ca7 100644
> --- a/target/microblaze/sys_helper.c
> +++ b/target/microblaze/sys_helper.c
> @@ -21,6 +21,7 @@
>  #include "qemu/osdep.h"
>  #include "cpu.h"
>  #include "exec/exec-all.h"
> +#include "exec/helper-proto.h"
>  #include "qemu/host-utils.h"
>  #include "exec/log.h"
>  
> @@ -292,3 +293,49 @@ void mb_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
>      cs->exception_index = EXCP_HW_EXCP;
>      cpu_loop_exit(cs);
>  }
> +
> +/* Writes/reads to the MMU's special regs end up here.  */
> +uint32_t helper_mmu_read(CPUMBState *env, uint32_t ext, uint32_t rn)
> +{
> +    return mmu_read(env, ext, rn);
> +}
> +
> +void helper_mmu_write(CPUMBState *env, uint32_t ext, uint32_t rn, uint32_t v)
> +{
> +    mmu_write(env, ext, rn, v);
> +}
> +
> +void mb_cpu_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr addr,
> +                               unsigned size, MMUAccessType access_type,
> +                               int mmu_idx, MemTxAttrs attrs,
> +                               MemTxResult response, uintptr_t retaddr)
> +{
> +    MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
> +    CPUMBState *env = &cpu->env;
> +
> +    qemu_log_mask(CPU_LOG_INT, "Transaction failed: vaddr 0x%" VADDR_PRIx
> +                  " physaddr 0x" HWADDR_FMT_plx " size %d access type %s\n",
> +                  addr, physaddr, size,
> +                  access_type == MMU_INST_FETCH ? "INST_FETCH" :
> +                  (access_type == MMU_DATA_LOAD ? "DATA_LOAD" : "DATA_STORE"));
> +
> +    if (!(env->msr & MSR_EE)) {
> +        return;
> +    }
> +
> +    if (access_type == MMU_INST_FETCH) {
> +        if (!cpu->cfg.iopb_bus_exception) {
> +            return;
> +        }
> +        env->esr = ESR_EC_INSN_BUS;
> +    } else {
> +        if (!cpu->cfg.dopb_bus_exception) {
> +            return;
> +        }
> +        env->esr = ESR_EC_DATA_BUS;
> +    }
> +
> +    env->ear = addr;
> +    cs->exception_index = EXCP_HW_EXCP;
> +    cpu_loop_exit_restore(cs, retaddr);
> +}
> -- 
> 2.41.0
> 

