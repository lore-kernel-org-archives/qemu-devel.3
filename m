Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53389CD342C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 14:36:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKdMR-0008Ri-5b; Wed, 06 May 2026 10:36:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1wKdML-0008RG-9a
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:36:21 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1wKdMJ-0008Bp-Br
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:36:20 -0400
Received: from example.com (unknown [167.220.208.68])
 by linux.microsoft.com (Postfix) with ESMTPSA id 0295120B7165;
 Wed,  6 May 2026 07:36:13 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0295120B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1778078175;
 bh=FKUfSDsIXOoZFWgGKOL6KFKf7v4gDq85YHXef0xMwsw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=M7SI55G/WcRHfMYvgmBXam9yrGusXPCojVPY6LZwGshuEmLlhfJo5V8HOqpRA0GcU
 3c2AQnyAkQ71cjDwVlk9EAG/OU0qMFew5Htvc8TkoeRjRENMGmz7KzFaJknsN+npS9
 SlOACibC0/dffJNGsFSVkp+2nme8jCTfAKUjx1p0=
Date: Wed, 6 May 2026 16:36:13 +0200
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: Doru =?iso-8859-1?Q?Bl=E2nzeanu?= <dblanzeanu@linux.microsoft.com>
Cc: qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Wei Liu <wei.liu@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 4/7] target/i386/mshv: hv_vp_register_page setup for
 the vcpu
Message-ID: <aftR3eiNjbwCoqS/@example.com>
References: <20260505185028.237207-1-dblanzeanu@linux.microsoft.com>
 <20260505185028.237207-5-dblanzeanu@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260505185028.237207-5-dblanzeanu@linux.microsoft.com>
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
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

On Tue, May 05, 2026 at 09:50:25PM +0300, Doru Blânzeanu wrote:
> When the vcpu is created, call mmap to configure access to the register page.
> In case the call to mmap fails, we log an error and continue with the
> previous logic (using hypercalls).
> 
> Update CPUArchState to store a pointer to the mmapped hv_vp_register_page.
> 
> Signed-off-by: Doru Blânzeanu <dblanzeanu@linux.microsoft.com>
> ---
>  target/i386/cpu.h           |  5 +++++
>  target/i386/mshv/mshv-cpu.c | 22 ++++++++++++++++++++++
>  2 files changed, 27 insertions(+)
> 
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 16de67e546..fd4c3712b1 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -2019,6 +2019,11 @@ typedef struct CPUArchState {
>      uint64_t msr_bndcfgs;
>      uint64_t efer;
>  
> +#ifdef CONFIG_MSHV
> +    /* Shared register page */
> +    struct hv_vp_register_page *regs_page;
> +#endif

since this is declared before this marker

    /* Fields up to this point are cleared by a CPU reset */
    struct {} end_reset_fields;

the pointer will be zeroed out on init, best move it after the
emu_mmio_buf field.

> +
>      /* Beginning of state preserved by INIT (dummy marker).  */
>      struct {} start_init_save;
>  
> diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
> index 9defd05db6..3a3c269c33 100644
> --- a/target/i386/mshv/mshv-cpu.c
> +++ b/target/i386/mshv/mshv-cpu.c
> @@ -1587,6 +1587,7 @@ void mshv_arch_init_vcpu(CPUState *cpu)
>      CPUX86State *env = &x86_cpu->env;
>      AccelCPUState *state = cpu->accel;
>      size_t page = HV_HYP_PAGE_SIZE;
> +    void *regs_page;
>      void *mem = qemu_memalign(page, 2 * page);
>  
>      /* sanity check, to make sure we don't overflow the page */
> @@ -1595,6 +1596,22 @@ void mshv_arch_init_vcpu(CPUState *cpu)
>                        + sizeof(hv_input_get_vp_registers)
>                        > HV_HYP_PAGE_SIZE));
>  
> +
> +    /* mmap the registers page */
> +    regs_page = mmap(NULL, page, PROT_READ | PROT_WRITE,
> +                    MAP_SHARED, mshv_vcpufd(cpu),
> +                    MSHV_VP_MMAP_OFFSET_REGISTERS * page);
> +    if (regs_page == MAP_FAILED) {
> +        /*
> +         * Error is not fatal, but we won't be able to use the
> +         * fast path for register access
> +         */
> +        error_report("register page mmap failed: %s", strerror(errno));
> +        env->regs_page = NULL;
> +    } else {
> +        env->regs_page = (struct hv_vp_register_page *) regs_page;
> +    }
> +
>      state->hvcall_args.base = mem;
>      state->hvcall_args.input_page = mem;
>      state->hvcall_args.output_page = (uint8_t *)mem + page;
> @@ -1608,6 +1625,11 @@ void mshv_arch_destroy_vcpu(CPUState *cpu)
>      CPUX86State *env = &x86_cpu->env;
>      AccelCPUState *state = cpu->accel;
>  
> +    /* Unmap the register page */
> +    if (env->regs_page) {
> +        munmap(env->regs_page, HV_HYP_PAGE_SIZE);
> +        env->regs_page = NULL;
> +    }
>      g_free(state->hvcall_args.base);
>      state->hvcall_args = (MshvHvCallArgs){0};
>      g_clear_pointer(&env->emu_mmio_buf, g_free);
> -- 
> 2.53.0

