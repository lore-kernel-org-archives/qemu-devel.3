Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17345FF8867
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 11:22:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wI2z5-0001ES-Sy; Wed, 29 Apr 2026 07:21:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1wI2yx-0001E2-LG
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 07:21:32 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1wI2yw-0005UW-33
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 07:21:31 -0400
Received: from example.com (unknown [167.220.208.81])
 by linux.microsoft.com (Postfix) with ESMTPSA id 9749920B716C;
 Wed, 29 Apr 2026 04:21:27 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9749920B716C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1777461688;
 bh=ILqMNi8E0ZWRUMXGxnAYzHgDf8g8EDMKniRpfLKbTYs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=jyfLNQ4dGfQxmjRYDIUE78qhAZTwkWKUr/vQMaG3cikg+1TjSrOeT1/Dmj8Jc7hTo
 BjwCghWEAi5MDbxgQdEthZepkfLxz7yr2KL6PpOaU4ZVm2Ov1XhH/1f3ZMV8vmlfbG
 WPMZ9T8GUtE3R/wX2coWqxm5dp3+BK7KjkcgsJv8=
Date: Wed, 29 Apr 2026 13:21:24 +0200
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: Doru =?iso-8859-1?Q?Bl=E2nzeanu?= <dblanzeanu@linux.microsoft.com>
Cc: qemu-devel@nongnu.org, Wei Liu <wei.liu@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH 4/6] target/i386/mshv: hv_vp_register_page setup for the
 vcpu
Message-ID: <afHptC4d/vEs7sQv@example.com>
References: <20260428135053.251200-1-dblanzeanu@linux.microsoft.com>
 <20260428135053.251200-5-dblanzeanu@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260428135053.251200-5-dblanzeanu@linux.microsoft.com>
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

On Tue, Apr 28, 2026 at 04:50:51PM +0300, Doru Blânzeanu wrote:
> When the vcpu is created, call mmap to configure access to the register page.
> 
> Update CPUArchState to store a pointer to the mmapped hv_vp_register_page.
> 
> Signed-off-by: Doru Blânzeanu <dblanzeanu@linux.microsoft.com>
> ---
>  target/i386/cpu.h           |  3 +++
>  target/i386/mshv/mshv-cpu.c | 18 ++++++++++++++++++
>  2 files changed, 21 insertions(+)
> 
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 0b539155c4..0108e2157b 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -2016,6 +2016,9 @@ typedef struct CPUArchState {
>      uint64_t msr_bndcfgs;
>      uint64_t efer;
>  
> +    /* Shared register page */
> +    struct hv_vp_register_page *regs_page;
> +

We probably want to put this behind a compile-time guard:

#if defined(CONFIG_MSHV)
...
#endif

>      /* Beginning of state preserved by INIT (dummy marker).  */
>      struct {} start_init_save;
>  
> diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
> index 9defd05db6..42b6fb1912 100644
> --- a/target/i386/mshv/mshv-cpu.c
> +++ b/target/i386/mshv/mshv-cpu.c
> @@ -1595,6 +1595,19 @@ void mshv_arch_init_vcpu(CPUState *cpu)
>                        + sizeof(hv_input_get_vp_registers)
>                        > HV_HYP_PAGE_SIZE));
>  
> +
> +    /* mmap the registers page */
> +    void *rp = mmap(NULL, page, PROT_READ | PROT_WRITE,
> +                    MAP_SHARED, mshv_vcpufd(cpu),
> +                    MSHV_VP_MMAP_OFFSET_REGISTERS * page);

nit: convention is to declare variables at the top of a fn:

int cpu_fd = mshv_vcpufd(cpu);
void *regs_page;
...
regs_page = mmap(..., cpu_fd, ...);

> +    if (rp == MAP_FAILED) {
> +        warn_report("register page mmap failed, falling back to hypercalls: %s",

We're not falling back at this specific place. so it probably makes
sense to just say register page mmap failed and leave it at that here.

> +                    strerror(errno));
> +        env->regs_page = NULL;
> +    } else {
> +        env->regs_page = (struct hv_vp_register_page *) rp;
> +    }
> +
>      state->hvcall_args.base = mem;
>      state->hvcall_args.input_page = mem;
>      state->hvcall_args.output_page = (uint8_t *)mem + page;
> @@ -1608,6 +1621,11 @@ void mshv_arch_destroy_vcpu(CPUState *cpu)
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

