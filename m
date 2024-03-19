Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3442BCD11DB
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 16:03:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmbvK-0005Wk-7z; Tue, 19 Mar 2024 12:02:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1rmbvE-0005KD-Ba
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 12:02:42 -0400
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1rmbvB-0000ZJ-Tn
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 12:02:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=YURpLAq1je9L1upoxyjcSnADCwZR/W5YfNNABpqWU7c=; b=LNSw7vW8dxFwLcQSWi5Hi2QKVa
 PEqdRN82K9m78te6lhpQhyTiAHn8SBXnHCa03r4yYaaYug9h9OXwy8pD/IJZ6rDkpnnhDvHWg89+K
 Q95gdJVzvFTjVQnBPDhQVdTr0IOymJM2TjvYW1VmurdR4phFoyVm3OvgetIy1xtCNVUQ=;
Date: Tue, 19 Mar 2024 17:03:26 +0100
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Laurent Vivier <laurent@vivier.eu>, Alistair Francis <alistair@alistair23.me>
Subject: Re: [PATCH-for-9.1 7/8] target/microblaze: Move MMU helpers to
 sys_helper.c
Message-ID: <5bg3o2o5fflpxi63gjdihwaiyim4c2dhte2jsdrc5hhe45qpm2@5kppjftie4xa>
References: <20240319062855.8025-1-philmd@linaro.org>
 <20240319062855.8025-8-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240319062855.8025-8-philmd@linaro.org>
Received-SPF: pass client-ip=5.9.113.41; envelope-from=anjo@rev.ng; helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 19/03/24, Philippe Mathieu-Daudé wrote:
> MMU helpers are only used during system emulation,
> move them to sys_helper.c.
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
Reviewed-by: Anton Johansson <anjo@rev.ng>

