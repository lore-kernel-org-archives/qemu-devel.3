Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47FEFCD5BB1
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 13:10:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQPd2-0007pA-An; Fri, 22 May 2026 09:09:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1wQPcz-0007o0-36
 for qemu-devel@nongnu.org; Fri, 22 May 2026 09:09:25 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1wQPcx-0000hC-4m
 for qemu-devel@nongnu.org; Fri, 22 May 2026 09:09:24 -0400
Received: from example.com (unknown [167.220.208.35])
 by linux.microsoft.com (Postfix) with ESMTPSA id D04B920B7167;
 Fri, 22 May 2026 06:09:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D04B920B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1779455353;
 bh=nw6WKbrb00ienDRoZRX7xhYguAnBNd4IuvQ533RkD9M=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=legfR4DfxDdUrZZ4s82rkxGGOpk2/ATBhS742X4b26rns60I4wwpJmElpOA0FgLG/
 fOTFG9CCdTmLKfsaYzwK+5wEjz4OwIM6tzW4u051STI/ZXtwlFCQxTZxeen5zRzo/m
 bfaVfsbB3lYsewOFqfI+MxRrng9kXz0HqxaFLRMQ=
Date: Fri, 22 May 2026 15:09:17 +0200
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: Doru =?iso-8859-1?Q?Bl=E2nzeanu?= <dblanzeanu@linux.microsoft.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Wei Liu <liuwe@microsoft.com>,
 Magnus Kulke <magnuskulke@microsoft.com>, Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH v3 5/7] target/i386/mshv: use the register page to get
 registers
Message-ID: <ahBVfSErBWl5FB4Q@example.com>
References: <20260521165041.131477-1-dblanzeanu@linux.microsoft.com>
 <20260521165041.131477-6-dblanzeanu@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260521165041.131477-6-dblanzeanu@linux.microsoft.com>
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_PASS=-0.001,
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

On Thu, May 21, 2026 at 07:50:39PM +0300, Doru Blânzeanu wrote:
> Change the mshv_load_regs to use the register page when it is mmapped
> and is valid.
> Eliminate the hypercall based logic and fail in case the register page
> is found in an unexpected state.
> 
> When retrieving the special registers, there are some registers that are
> not present in the register page: TR, LDTR, GDTR, IDTR, CR2, APIC_BASE.
> As this registers are not likely to be used in an MMIO/PIO operation,
> and to avoid a hypercall overhead we do not retrieve them.
> 
> Local testing showed no regression when using this logic. To properly
> retrieve all the necessary registers for each decoded operation implies
> having a mechanism that tracks the state of each register, which is
> beyond the scope of this patch series.
> 
> Signed-off-by: Doru Blânzeanu <dblanzeanu@linux.microsoft.com>
> ---
>  accel/mshv/mshv-all.c       |   9 +--
>  include/system/mshv_int.h   |   2 +-
>  target/i386/mshv/mshv-cpu.c | 113 +++++++++++++++++++++++++++++-------
>  3 files changed, 93 insertions(+), 31 deletions(-)
> 
> diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
> index e3da583f21..bd3bf557ec 100644
> --- a/accel/mshv/mshv-all.c
> +++ b/accel/mshv/mshv-all.c
> @@ -666,14 +666,7 @@ static void mshv_cpu_synchronize_pre_loadvm(CPUState *cpu)
>  static void do_mshv_cpu_synchronize(CPUState *cpu, run_on_cpu_data arg)
>  {
>      if (!cpu->accel->dirty) {
> -        int ret = mshv_load_regs(cpu);
> -        if (ret < 0) {
> -            error_report("Failed to load registers for vcpu %d",
> -                         cpu->cpu_index);
> -
> -            cpu_dump_state(cpu, stderr, CPU_DUMP_CODE);
> -            vm_stop(RUN_STATE_INTERNAL_ERROR);
> -        }
> +        mshv_load_regs(cpu);
>  
>          cpu->accel->dirty = true;
>      }
> diff --git a/include/system/mshv_int.h b/include/system/mshv_int.h
> index 35386c422f..a8a59ebf16 100644
> --- a/include/system/mshv_int.h
> +++ b/include/system/mshv_int.h
> @@ -85,7 +85,7 @@ int mshv_configure_vcpu(const CPUState *cpu, const MshvFPU *fpu, uint64_t xcr0);
>  int mshv_get_standard_regs(CPUState *cpu);
>  int mshv_get_special_regs(CPUState *cpu);
>  int mshv_run_vcpu(int vm_fd, CPUState *cpu, hv_message *msg, MshvVmExit *exit);
> -int mshv_load_regs(CPUState *cpu);
> +void mshv_load_regs(CPUState *cpu);
>  int mshv_store_regs(CPUState *cpu);
>  int mshv_set_generic_regs(const CPUState *cpu, const hv_register_assoc *assocs,
>                            size_t n_regs);
> diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
> index 45dc6e6331..500967b53e 100644
> --- a/target/i386/mshv/mshv-cpu.c
> +++ b/target/i386/mshv/mshv-cpu.c
> @@ -401,6 +401,80 @@ static void populate_special_regs(const hv_register_assoc *assocs,
>      cpu_set_apic_base(x86cpu->apic_state, assocs[16].value.reg64);
>  }
>  
> +static void mshv_get_standard_regs_vp_page(CPUState *cpu)
> +{
> +    X86CPU *x86cpu = X86_CPU(cpu);
> +    CPUX86State *env = &x86cpu->env;
> +
> +    /* General Purpose Registers  */
> +    env->regs[R_EAX] = env->regs_page->rax;
> +    env->regs[R_EBX] = env->regs_page->rbx;
> +    env->regs[R_ECX] = env->regs_page->rcx;
> +    env->regs[R_EDX] = env->regs_page->rdx;
> +    env->regs[R_ESI] = env->regs_page->rsi;
> +    env->regs[R_EDI] = env->regs_page->rdi;
> +    env->regs[R_ESP] = env->regs_page->rsp;
> +    env->regs[R_EBP] = env->regs_page->rbp;
> +    env->regs[R_R8]  = env->regs_page->r8;
> +    env->regs[R_R9]  = env->regs_page->r9;
> +    env->regs[R_R10] = env->regs_page->r10;
> +    env->regs[R_R11] = env->regs_page->r11;
> +    env->regs[R_R12] = env->regs_page->r12;
> +    env->regs[R_R13] = env->regs_page->r13;
> +    env->regs[R_R14] = env->regs_page->r14;
> +    env->regs[R_R15] = env->regs_page->r15;
> +
> +    env->eip = env->regs_page->rip;
> +    env->eflags = env->regs_page->rflags;
> +    rflags_to_lflags(env);
> +}
> +
> +/*
> + * This function synchronizes the special registers present in the
> + * register vp page, which are not all the special registers.
> + * The rest of the special registers (LD, TR, GDT, IDT, CR2, APIC_BASE)
> + * are not synchronized to avoid the overhead of a hypercall.
> + *
> + * These special registers are not normally used by the guest,
> + * and are only used in some specific cases.
> + */
> +static void mshv_get_special_regs_vp_page(CPUState *cpu)
> +{
> +    X86CPU *x86cpu = X86_CPU(cpu);
> +    CPUX86State *env = &x86cpu->env;
> +    hv_x64_segment_register seg;
> +
> +    /* Populate special registers that are in the VP register page */
> +    env->cr[0] = env->regs_page->cr0;
> +    env->cr[3] = env->regs_page->cr3;
> +    env->cr[4] = env->regs_page->cr4;
> +    env->efer = env->regs_page->efer;
> +    cpu_set_apic_tpr(x86cpu->apic_state, env->regs_page->cr8);
> +
> +    /* Segment Registers - copy from packed struct to avoid unaligned access */
> +    memcpy(&seg, &env->regs_page->es, sizeof(hv_x64_segment_register));
> +    populate_segment_reg(&seg, &env->segs[R_ES]);
> +    memcpy(&seg, &env->regs_page->cs, sizeof(hv_x64_segment_register));
> +    populate_segment_reg(&seg, &env->segs[R_CS]);
> +    memcpy(&seg, &env->regs_page->ss, sizeof(hv_x64_segment_register));
> +    populate_segment_reg(&seg, &env->segs[R_SS]);
> +    memcpy(&seg, &env->regs_page->ds, sizeof(hv_x64_segment_register));
> +    populate_segment_reg(&seg, &env->segs[R_DS]);
> +    memcpy(&seg, &env->regs_page->fs, sizeof(hv_x64_segment_register));
> +    populate_segment_reg(&seg, &env->segs[R_FS]);
> +    memcpy(&seg, &env->regs_page->gs, sizeof(hv_x64_segment_register));
> +    populate_segment_reg(&seg, &env->segs[R_GS]);
> +}
> +
> +static void mshv_get_registers_vp_page(CPUState *cpu)
> +{
> +    /* General Purpose Registers  */
> +    mshv_get_standard_regs_vp_page(cpu);
> +
> +    /* Special Registers */
> +    mshv_get_special_regs_vp_page(cpu);
> +}
> +
>  
>  int mshv_get_special_regs(CPUState *cpu)
>  {
> @@ -422,23 +496,26 @@ int mshv_get_special_regs(CPUState *cpu)
>      return 0;
>  }
>  
> -int mshv_load_regs(CPUState *cpu)
> +void mshv_load_regs(CPUState *cpu)
>  {
> -    int ret;
> +    X86CPU *x86_cpu = X86_CPU(cpu);
> +    CPUX86State *env = &x86_cpu->env;
>  
> -    ret = mshv_get_standard_regs(cpu);
> -    if (ret < 0) {
> -        error_report("Failed to load standard registers");
> -        return -1;
> +    /* Check register page pointer and abort if in unexpected state */

nit: I would generally just assert() those invariants, since this really
represents an internal error that the user cannot do anything about.

> +    if (!env->regs_page) {
> +        error_report(
> +                "load regs: register page not set for vcpu %d",
> +                cpu->cpu_index);
> +        abort();
>      }
> -
> -    ret = mshv_get_special_regs(cpu);
> -    if (ret < 0) {
> -        error_report("Failed to load special registers");
> -        return -1;
> +    if (env->regs_page->isvalid == 0) {
> +        error_report(
> +                "load regs: register page invalid for vcpu %d",
> +                cpu->cpu_index);
> +        abort();
>      }
>  
> -    return 0;
> +    mshv_get_registers_vp_page(cpu);
>  }
>  
>  static void add_cpuid_entry(GList *cpuid_entries,
> @@ -1103,11 +1180,7 @@ static int emulate_instruction(CPUState *cpu,
>      int ret;
>      x86_insn_stream stream = { .bytes = insn_bytes, .len = insn_len };
>  
> -    ret = mshv_load_regs(cpu);
> -    if (ret < 0) {
> -        error_report("failed to load registers");
> -        return -1;
> -    }
> +    mshv_load_regs(cpu);
>  
>      decode_instruction_stream(env, &decode, &stream);
>      exec_instruction(env, &decode);
> @@ -1410,11 +1483,7 @@ static int handle_pio_str(CPUState *cpu, hv_x64_io_port_intercept_message *info)
>      X86CPU *x86_cpu = X86_CPU(cpu);
>      CPUX86State *env = &x86_cpu->env;
>  
> -    ret = mshv_load_regs(cpu);
> -    if (ret < 0) {
> -        error_report("Failed to fetch guest state");
> -        return -1;
> -    }
> +    mshv_load_regs(cpu);
>  
>      direction_flag = (env->eflags & DESC_E_MASK) != 0;
>  
> -- 
> 2.53.0

Reviewed-by: Magnus Kulke <magnuskulke@linux.microsoft.com>

