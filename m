Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DE3FFF8867
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 11:31:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wI391-0004KE-Gk; Wed, 29 Apr 2026 07:31:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1wI38z-0004Js-AI
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 07:31:53 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1wI38x-0000LT-FI
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 07:31:53 -0400
Received: from example.com (unknown [167.220.208.81])
 by linux.microsoft.com (Postfix) with ESMTPSA id 0F27820B716C;
 Wed, 29 Apr 2026 04:31:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0F27820B716C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1777462310;
 bh=VTeUmvrowZ5KEwQhdobWjOGoJJMLtnKmRIKWO/DyW/E=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=iZUmPyRa/K6UY0uE58puRbcU92tq/0AkRrH7DeH+Fr7o0m6FE4ZCNcLdFvtB/3xpS
 Br+11UUC/7ugPFA7Luywny5TAXSywiToENXfOY4OKojXy17LhXbCpfK3U+qifP+a1J
 Q9ViEatvfn63RgGyZsuDjW2M5wTuZWwNd7uQ8/5k=
Date: Wed, 29 Apr 2026 13:31:45 +0200
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: Doru =?iso-8859-1?Q?Bl=E2nzeanu?= <dblanzeanu@linux.microsoft.com>
Cc: qemu-devel@nongnu.org, Wei Liu <wei.liu@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH 5/6] target/i386/mshv: use the register page to get
 registers
Message-ID: <afHsIXVVG1vFsVK0@example.com>
References: <20260428135053.251200-1-dblanzeanu@linux.microsoft.com>
 <20260428135053.251200-6-dblanzeanu@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260428135053.251200-6-dblanzeanu@linux.microsoft.com>
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Apr 28, 2026 at 04:50:52PM +0300, Doru Blânzeanu wrote:
> Change the mshv_load_regs to use the register page when it is mmapped
> and is valid.
> Otherwise use the existing logic that uses ioctls to fetch registers.
> 
> When retrieving the special registers, there are some registers that are
> not present in the register page: TR, LDTR, GDTR, IDTR, CR2, APIC_BASE.
> For this ones we still need to use ioctls to correctly fetch.
> 
> Signed-off-by: Doru Blânzeanu <dblanzeanu@linux.microsoft.com>
> ---
>  target/i386/mshv/mshv-cpu.c | 137 +++++++++++++++++++++++++++++++++---
>  1 file changed, 128 insertions(+), 9 deletions(-)
> 
> diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
> index 42b6fb1912..7949493e97 100644
> --- a/target/i386/mshv/mshv-cpu.c
> +++ b/target/i386/mshv/mshv-cpu.c
> @@ -107,6 +107,15 @@ static enum hv_register_name FPU_REGISTER_NAMES[26] = {
>      HV_X64_REGISTER_XMM_CONTROL_STATUS,
>  };
>  
> +static enum hv_register_name NON_VP_PAGE_REGISTER_NAMES[6] = {
> +    HV_X64_REGISTER_TR,
> +    HV_X64_REGISTER_LDTR,
> +    HV_X64_REGISTER_GDTR,
> +    HV_X64_REGISTER_IDTR,
> +    HV_X64_REGISTER_CR2,
> +    HV_X64_REGISTER_APIC_BASE,
> +};
> +
>  static int translate_gva(const CPUState *cpu, uint64_t gva, uint64_t *gpa,
>                           uint64_t flags)
>  {
> @@ -401,6 +410,105 @@ static void populate_special_regs(const hv_register_assoc *assocs,
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
> +static int mshv_get_special_regs_vp_page(CPUState *cpu)
> +{
> +    X86CPU *x86cpu = X86_CPU(cpu);
> +    CPUX86State *env = &x86cpu->env;
> +    struct hv_register_assoc assocs[ARRAY_SIZE(NON_VP_PAGE_REGISTER_NAMES)];
> +    int ret;
> +    size_t n_regs = ARRAY_SIZE(NON_VP_PAGE_REGISTER_NAMES);
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
> +
> +    /* The rest of the special registers that are not in the VP register page */
> +    for (size_t i = 0; i < n_regs; i++) {
> +        assocs[i].name = NON_VP_PAGE_REGISTER_NAMES[i];
> +    }
> +
> +    ret = get_generic_regs(cpu, assocs, n_regs);
> +    if (ret < 0) {
> +        error_report("failed to get non-vp-page special registers");
> +        return -1;
> +    }
> +
> +    /* Non-VP page registers - TR, LDTR, GDTR, IDTR, CR2, APIC_BASE */
> +    populate_segment_reg(&assocs[0].value.segment, &env->tr);
> +    populate_segment_reg(&assocs[1].value.segment, &env->ldt);
> +
> +    populate_table_reg(&assocs[2].value.table, &env->gdt);
> +    populate_table_reg(&assocs[3].value.table, &env->idt);
> +    env->cr[2] = assocs[4].value.reg64;
> +
> +    cpu_set_apic_base(x86cpu->apic_state, assocs[5].value.reg64);

Do we know whether MMIO emulation requires the
NON_VP_PAGE_REGISTER_NAMES to be roundtripped? I understand this is how
it is done in the mshv-ioctls crate, but I understand this was motivated
mostly by maitaining parity for sregs between KVM and MSHV
implementations.

Did you test what happens if we don't perform an ioctl and just ignore
those registers?

> +
> +    return ret;
> +}
> +
> +static int mshv_get_registers_vp_page(CPUState *cpu)
> +{
> +    int ret;
> +
> +    /* General Purpose Registers  */
> +    mshv_get_standard_regs_vp_page(cpu);
> +
> +    /* Special Registers - makes a hypercall */
> +    ret = mshv_get_special_regs_vp_page(cpu);
> +    if (ret < 0) {
> +        error_report("failed to get special registers for vp page");
> +        return -1;
> +    }
> +
> +    return 0;
> +}
> +
>  
>  int mshv_get_special_regs(CPUState *cpu)
>  {
> @@ -424,18 +532,29 @@ int mshv_get_special_regs(CPUState *cpu)
>  
>  int mshv_load_regs(CPUState *cpu)
>  {
> +    X86CPU *x86_cpu = X86_CPU(cpu);
> +    CPUX86State *env = &x86_cpu->env;
>      int ret;
>  
> -    ret = mshv_get_standard_regs(cpu);
> -    if (ret < 0) {
> -        error_report("Failed to load standard registers");
> -        return -1;
> -    }
> +    /* Use register vp page to optimize registers access */
> +    if (env->regs_page && env->regs_page->isvalid != 0) {
> +        ret = mshv_get_registers_vp_page(cpu);
> +        if (ret < 0) {
> +            error_report("Failed to load registers from vp page");

nit: slightly inaccurate, since loading registers is infallible. it's
the ioctl op that fails, no?

> +            return -1;
> +        }
> +    } else {
> +        ret = mshv_get_standard_regs(cpu);
> +        if (ret < 0) {
> +            error_report("Failed to load standard registers");
> +            return -1;
> +        }
>  
> -    ret = mshv_get_special_regs(cpu);
> -    if (ret < 0) {
> -        error_report("Failed to load special registers");
> -        return -1;
> +        ret = mshv_get_special_regs(cpu);
> +        if (ret < 0) {
> +            error_report("Failed to load special registers");
> +            return -1;
> +        }
>      }
>  
>      return 0;
> -- 
> 2.53.0

