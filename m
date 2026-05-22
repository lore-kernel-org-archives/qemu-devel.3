Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 827A3CD5BB0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 12:48:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQPIa-0002mB-To; Fri, 22 May 2026 08:48:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1wQPIX-0002le-64
 for qemu-devel@nongnu.org; Fri, 22 May 2026 08:48:18 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1wQPIV-0004NI-7N
 for qemu-devel@nongnu.org; Fri, 22 May 2026 08:48:16 -0400
Received: from example.com (unknown [167.220.208.35])
 by linux.microsoft.com (Postfix) with ESMTPSA id D226420B7167;
 Fri, 22 May 2026 05:48:04 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D226420B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1779454086;
 bh=Phto6vJhdDd/DNhAMrnQ0spDaMkKyv0VaSgRuGuiFWg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=LsDV0BvQkgXA8rKGbr1G342Ub/LPeW91WFnIT0XhUuPzcQqBP/F2mWzQXzTLEguga
 qIytTkQCfjEUkyDBrPm9zztT6ZoUb7da9jBnxVUggo9RaQF43sfH9nhfUOelPIArKL
 +mrPFFwdgFR8sekWSR44PNRDCa0KdhTs+eu9MIFQ=
Date: Fri, 22 May 2026 14:48:10 +0200
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: Doru =?iso-8859-1?Q?Bl=E2nzeanu?= <dblanzeanu@linux.microsoft.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Wei Liu <liuwe@microsoft.com>,
 Magnus Kulke <magnuskulke@microsoft.com>, Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH v3 4/7] target/i386/mshv: hv_vp_register_page setup for
 the vcpu
Message-ID: <ahBQiliOXEMGn5AV@example.com>
References: <20260521165041.131477-1-dblanzeanu@linux.microsoft.com>
 <20260521165041.131477-5-dblanzeanu@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260521165041.131477-5-dblanzeanu@linux.microsoft.com>
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

On Thu, May 21, 2026 at 07:50:38PM +0300, Doru Blânzeanu wrote:
> When the vcpu is created, call mmap to configure access to the register page.
> In case the call to mmap fails, we log an error and abort to signal
> there is something wrong with the system.
> Check the register page version and compare with the expected version and
> abort in case of a mismatch.
> 
> Update CPUArchState to store a pointer to the mmapped hv_vp_register_page.
> 
> Signed-off-by: Doru Blânzeanu <dblanzeanu@linux.microsoft.com>
> ---
>  target/i386/cpu.h           |  4 ++++
>  target/i386/mshv/mshv-cpu.c | 24 ++++++++++++++++++++++++
>  2 files changed, 28 insertions(+)
> 
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index bdd4fff89d..d772b4c4cc 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -2214,6 +2214,10 @@ typedef struct CPUArchState {
>      struct {} end_reset_fields;
>  
>      /* Fields after this point are preserved across CPU reset. */
> +#ifdef CONFIG_MSHV
> +    /* Shared register page */
> +    struct hv_vp_register_page *regs_page;
> +#endif
>  
>      /* processor features (e.g. for CPUID insn) */
>      /* Minimum cpuid leaf 7 value */
> diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
> index 9defd05db6..45dc6e6331 100644
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
> @@ -1595,6 +1596,24 @@ void mshv_arch_init_vcpu(CPUState *cpu)
>                        + sizeof(hv_input_get_vp_registers)
>                        > HV_HYP_PAGE_SIZE));
>  
> +
> +    /* mmap the registers page */
> +    regs_page = mmap(NULL, page, PROT_READ | PROT_WRITE,
> +                    MAP_SHARED, mshv_vcpufd(cpu),
> +                    MSHV_VP_MMAP_OFFSET_REGISTERS * page);
> +    if (regs_page == MAP_FAILED) {
> +        /* This shouldn't fail, so we treat it as a fatal error */
> +        error_report("register page mmap failed: %s", strerror(errno));
> +        abort();
> +    }
> +    env->regs_page = (struct hv_vp_register_page *) regs_page;
> +
> +    if (env->regs_page->version != HV_VP_REGISTER_PAGE_VERSION_1) {
> +        error_report("register page version mismatch: got %u, expected %u",
> +                     env->regs_page->version, HV_VP_REGISTER_PAGE_VERSION_1);
> +        abort();
> +    }
> +
>      state->hvcall_args.base = mem;
>      state->hvcall_args.input_page = mem;
>      state->hvcall_args.output_page = (uint8_t *)mem + page;
> @@ -1608,6 +1627,11 @@ void mshv_arch_destroy_vcpu(CPUState *cpu)
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

Reviewed-by: Magnus Kulke <magnuskulke@linux.microsoft.com>

