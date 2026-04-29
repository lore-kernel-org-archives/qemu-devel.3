Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2369FF8875
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 11:39:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wI3Fe-0006Ep-WC; Wed, 29 Apr 2026 07:38:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1wI3FO-0006Du-Vj
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 07:38:33 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1wI3FM-0003LE-4D
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 07:38:29 -0400
Received: from example.com (unknown [167.220.208.81])
 by linux.microsoft.com (Postfix) with ESMTPSA id 9FC6320B716C;
 Wed, 29 Apr 2026 04:38:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9FC6320B716C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1777462705;
 bh=NS7XOFJ1CtQnB/JU8/hzjogMH1giz3e0WYCtN5uCU4Q=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Z7OAF+PSjF9gyXiOtmogIhXaFHGW+n5TNYEdWCiQj/aNc4+98A9J8X9K71Uf58dDu
 D/S/Yw/u1CzmZoXhZEuLxRKebFOm8d1LSZCuGkENIEIzbZISgH8UVP+E7EsvUtkjes
 EQ5R7Bmvq23K0z6dr7TxlMlfUtqcnaXPKG/j3H58=
Date: Wed, 29 Apr 2026 13:38:21 +0200
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: Doru =?iso-8859-1?Q?Bl=E2nzeanu?= <dblanzeanu@linux.microsoft.com>
Cc: qemu-devel@nongnu.org, Wei Liu <wei.liu@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH 6/6] target/i386/mshv: use the register page to set
 registers
Message-ID: <afHtrYCfOwAKoL+B@example.com>
References: <20260428135053.251200-1-dblanzeanu@linux.microsoft.com>
 <20260428135053.251200-7-dblanzeanu@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260428135053.251200-7-dblanzeanu@linux.microsoft.com>
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

On Tue, Apr 28, 2026 at 04:50:53PM +0300, Doru Blânzeanu wrote:
> Update mshv_store_regs to use the register page when it is mmapped and
> valid to set registers.
> Otherwise use the ioctls to set the registers.
> 
> Signed-off-by: Doru Blânzeanu <dblanzeanu@linux.microsoft.com>
> ---
>  target/i386/mshv/mshv-cpu.c | 45 +++++++++++++++++++++++++++++++++----
>  1 file changed, 41 insertions(+), 4 deletions(-)
> 
> diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
> index 7949493e97..6bb3e6d4a9 100644
> --- a/target/i386/mshv/mshv-cpu.c
> +++ b/target/i386/mshv/mshv-cpu.c
> @@ -294,14 +294,51 @@ static int set_standard_regs(const CPUState *cpu)
>      return 0;
>  }
>  
> +static void mshv_set_standard_regs_vp_page(CPUState *cpu)
> +{
> +    X86CPU *x86cpu = X86_CPU(cpu);
> +    CPUX86State *env = &x86cpu->env;
> +
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
>  int mshv_store_regs(CPUState *cpu)
>  {
> +    X86CPU *x86cpu = X86_CPU(cpu);
> +    CPUX86State *env = &x86cpu->env;
>      int ret;
>  
> -    ret = set_standard_regs(cpu);
> -    if (ret < 0) {
> -        error_report("Failed to store standard registers");
> -        return -1;
> +    /* Use register vp page to optimize registers access */
> +    if (env->regs_page && env->regs_page->isvalid != 0) {
> +        mshv_set_standard_regs_vp_page(cpu);
> +    } else {
> +        ret = set_standard_regs(cpu);
> +        if (ret < 0) {
> +            error_report("Failed to store standard registers");
> +            return -1;
> +        }
>      }

I think for consistency sake it would be better to also write back
sregs, but this is reworked in the migration patch series anyway, so we
can leave it as is here.

>  
>      return 0;
> -- 
> 2.53.0

Reviewed-By: Magnus Kulke <magnuskulke@linux.microsoft.com>

