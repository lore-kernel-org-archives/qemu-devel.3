Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B913BCD5BB5
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 13:19:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQPlh-0001Cf-38; Fri, 22 May 2026 09:18:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1wQPlf-0001CR-C6
 for qemu-devel@nongnu.org; Fri, 22 May 2026 09:18:23 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1wQPld-0008M2-HD
 for qemu-devel@nongnu.org; Fri, 22 May 2026 09:18:23 -0400
Received: from example.com (unknown [167.220.208.35])
 by linux.microsoft.com (Postfix) with ESMTPSA id 6BABD20B7167;
 Fri, 22 May 2026 06:18:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6BABD20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1779455892;
 bh=tBrXCPG97Q4ID3MDLorF+JjsvK/nutC8cMcr95Q4Y8k=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=EQ5Ju123vTxBI/21YaHSpPD1ntHFaHyajc8FbQU9X9OQdstzIb2ZHzE/CzNObTMcV
 gvnp0vx2r9Lrry74tRe8lF6p1uJ9A4gTlkP2vSbNuwLX/2rtcGbwlHh3Di+RuA0ABg
 KVIA4XRIWl34TLIege/cFJt+b2un1X3GNWg3+bXQ=
Date: Fri, 22 May 2026 15:18:16 +0200
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: Doru =?iso-8859-1?Q?Bl=E2nzeanu?= <dblanzeanu@linux.microsoft.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Wei Liu <liuwe@microsoft.com>,
 Magnus Kulke <magnuskulke@microsoft.com>, Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH v3 6/7] target/i386/mshv: use the register page to set
 registers
Message-ID: <ahBXmC8KOkrjEzzQ@example.com>
References: <20260521165041.131477-1-dblanzeanu@linux.microsoft.com>
 <20260521165041.131477-7-dblanzeanu@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260521165041.131477-7-dblanzeanu@linux.microsoft.com>
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

On Thu, May 21, 2026 at 07:50:40PM +0300, Doru Blânzeanu wrote:
> Update mshv_store_regs to use the register page when it is mmapped and
> valid to set registers.
> Remove the ioctl based register retrieval and fail in case the register
> page is not correctly set or valid.
> 
> Signed-off-by: Doru Blânzeanu <dblanzeanu@linux.microsoft.com>
> ---
>  include/system/mshv_int.h   |  2 +-
>  target/i386/mshv/mshv-cpu.c | 70 ++++++++++++++++++++++++++-----------
>  2 files changed, 50 insertions(+), 22 deletions(-)
> 
> diff --git a/include/system/mshv_int.h b/include/system/mshv_int.h
> index a8a59ebf16..c2bc36ec60 100644
> --- a/include/system/mshv_int.h
> +++ b/include/system/mshv_int.h
> @@ -86,7 +86,7 @@ int mshv_get_standard_regs(CPUState *cpu);
>  int mshv_get_special_regs(CPUState *cpu);
>  int mshv_run_vcpu(int vm_fd, CPUState *cpu, hv_message *msg, MshvVmExit *exit);
>  void mshv_load_regs(CPUState *cpu);
> -int mshv_store_regs(CPUState *cpu);
> +void mshv_store_regs(CPUState *cpu);
>  int mshv_set_generic_regs(const CPUState *cpu, const hv_register_assoc *assocs,
>                            size_t n_regs);
>  int mshv_arch_put_registers(const CPUState *cpu);
> diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
> index 500967b53e..a2bc29abd4 100644
> --- a/target/i386/mshv/mshv-cpu.c
> +++ b/target/i386/mshv/mshv-cpu.c
> @@ -285,17 +285,56 @@ static int set_standard_regs(const CPUState *cpu)
>      return 0;
>  }
>  
> -int mshv_store_regs(CPUState *cpu)
> +static void mshv_set_standard_regs_vp_page(CPUState *cpu)

nit: per convention in the mshv files we have static fn's not prefixed
with mshv_, only the exported ones. It's probably not consistently used,
admitteldy.

>  {
> -    int ret;
> +    X86CPU *x86cpu = X86_CPU(cpu);
> +    CPUX86State *env = &x86cpu->env;
>  
> -    ret = set_standard_regs(cpu);
> -    if (ret < 0) {
> -        error_report("Failed to store standard registers");
> -        return -1;
> +    env->regs_page->rax = env->regs[R_EAX];
> +    env->regs_page->rbx = env->regs[R_EBX];
> +    env->regs_page->rcx = env->regs[R_ECX];
> +    env->regs_page->rdx = env->regs[R_EDX];
> +    env->regs_page->rsi = env->regs[R_ESI];
> +    env->regs_page->rdi = env->regs[R_EDI];
> +    env->regs_page->rsp = env->regs[R_ESP];
> +    env->regs_page->rbp = env->regs[R_EBP];
> +    env->regs_page->r8  = env->regs[R_R8];
> +    env->regs_page->r9  = env->regs[R_R9];
> +    env->regs_page->r10 = env->regs[R_R10];
> +    env->regs_page->r11 = env->regs[R_R11];
> +    env->regs_page->r12 = env->regs[R_R12];
> +    env->regs_page->r13 = env->regs[R_R13];
> +    env->regs_page->r14 = env->regs[R_R14];
> +    env->regs_page->r15 = env->regs[R_R15];
> +    env->regs_page->rip = env->eip;
> +    lflags_to_rflags(env);
> +    env->regs_page->rflags = env->eflags;
> +
> +    env->regs_page->dirty |= (1u << HV_X64_REGISTER_CLASS_GENERAL)
> +                                | (1u << HV_X64_REGISTER_CLASS_IP)
> +                                | (1u << HV_X64_REGISTER_CLASS_FLAGS);
> +}
> +
> +void mshv_store_regs(CPUState *cpu)
> +{
> +    X86CPU *x86cpu = X86_CPU(cpu);
> +    CPUX86State *env = &x86cpu->env;
> +
> +    /* Check register page pointer and abort if in unexpected state */
> +    if (!env->regs_page) {
> +        error_report(
> +                "store regs: register page not set for vcpu %d",
> +                cpu->cpu_index);
> +        abort();
> +    }
> +    if (env->regs_page->isvalid == 0) {
> +        error_report(
> +                "store regs: register page invalid for vcpu %d",
> +                cpu->cpu_index);
> +        abort();
>      }
>  
> -    return 0;
> +    mshv_set_standard_regs_vp_page(cpu);
>  }
>  
>  static void populate_standard_regs(const hv_register_assoc *assocs,
> @@ -1170,14 +1209,13 @@ static int set_memory_info(const struct hyperv_message *msg,
>      return 0;
>  }
>  
> -static int emulate_instruction(CPUState *cpu,
> +static void emulate_instruction(CPUState *cpu,
>                                 const uint8_t *insn_bytes, size_t insn_len,
>                                 uint64_t gva, uint64_t gpa)
>  {
>      X86CPU *x86_cpu = X86_CPU(cpu);
>      CPUX86State *env = &x86_cpu->env;
>      struct x86_decode decode = { 0 };
> -    int ret;
>      x86_insn_stream stream = { .bytes = insn_bytes, .len = insn_len };
>  
>      mshv_load_regs(cpu);
> @@ -1185,13 +1223,7 @@ static int emulate_instruction(CPUState *cpu,
>      decode_instruction_stream(env, &decode, &stream);
>      exec_instruction(env, &decode);
>  
> -    ret = mshv_store_regs(cpu);
> -    if (ret < 0) {
> -        error_report("failed to store registers");
> -        return -1;
> -    }
> -
> -    return 0;
> +    mshv_store_regs(cpu);
>  }
>  
>  static int handle_mmio(CPUState *cpu, const struct hyperv_message *msg,
> @@ -1227,13 +1259,9 @@ static int handle_mmio(CPUState *cpu, const struct hyperv_message *msg,
>  
>      instruction_bytes = info.instruction_bytes;
>  
> -    ret = emulate_instruction(cpu, instruction_bytes, insn_len,
> +    emulate_instruction(cpu, instruction_bytes, insn_len,
>                                info.guest_virtual_address,
>                                info.guest_physical_address);
> -    if (ret < 0) {
> -        error_report("failed to emulate mmio");
> -        return -1;
> -    }
>  
>      *exit_reason = MshvVmExitIgnore;
>  
> -- 
> 2.53.0

Reviewed-by: Magnus Kulke <magnuskulke@linux.microsoft.com>

