Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7BA4C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 16:44:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whVNk-0006Wj-Jp; Wed, 08 Jul 2026 12:44:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1whVNj-0006T3-4m
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 12:44:19 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1whVNh-000395-Dm
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 12:44:18 -0400
Received: from example.com (unknown [167.220.208.42])
 by linux.microsoft.com (Postfix) with ESMTPSA id C54F720B7167;
 Wed,  8 Jul 2026 09:44:04 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C54F720B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1783529046;
 bh=DY2qObzKyxh0ok6Pcyi8n6b6EV+cuk6j2kBW8KO0Kps=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=SXMg+ob3XzbTx+w1kYsdyOdd2zlzlJZyv3p9mKnjjoLYCAiAviHQ38yQzmlBSye5P
 2Lkh6HzR+vs5f+2Yo//YVKsTUnEGcQX4sC4dI8cMOIEXaOo+10pchLYW0CVxZoY273
 f9G0gadg6x/mCyvVuxRngCxJSm7PUtRDHYatQF3U=
Date: Wed, 8 Jul 2026 18:44:07 +0200
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: Doru =?iso-8859-1?Q?Bl=E2nzeanu?= <dblanzeanu@linux.microsoft.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Wei Liu <wei.liu@kernel.org>, Magnus Kulke <magnuskulke@microsoft.com>,
 Doru =?iso-8859-1?Q?Bl=E2nzeanu?= <dblanzeanu@microsoft.com>,
 Wei Liu <liuwe@microsoft.com>
Subject: Re: [PATCH 4/5] target/i386/mshv: remove fallback for register page
 set registers
Message-ID: <ak5+V9XXGOvt5neR@example.com>
References: <20260707221645.24557-1-dblanzeanu@linux.microsoft.com>
 <20260707221645.24557-5-dblanzeanu@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260707221645.24557-5-dblanzeanu@linux.microsoft.com>
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

On Wed, Jul 08, 2026 at 01:16:44AM +0300, Doru Blânzeanu wrote:
> Update `store_regs` to use the register page when it is mmapped and
> valid to set registers.
> Remove the ioctl based register retrieval and fail in case the register
> page is not correctly set or valid.
> 
> Fixes: 80c7f8e9cd
> Signed-off-by: Doru Blânzeanu <dblanzeanu@linux.microsoft.com>
> ---
>  target/i386/mshv/mshv-cpu.c | 48 +++++++++++++------------------------
>  1 file changed, 17 insertions(+), 31 deletions(-)
> 
> diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
> index 9ec5c19c67..8a59a0b40e 100644
> --- a/target/i386/mshv/mshv-cpu.c
> +++ b/target/i386/mshv/mshv-cpu.c
> @@ -448,7 +448,7 @@ static int set_standard_regs(const CPUState *cpu)
>      return 0;
>  }
>  
> -static void mshv_set_standard_regs_vp_page(CPUState *cpu)
> +static void set_standard_regs_vp_page(CPUState *cpu)
>  {
>      X86CPU *x86cpu = X86_CPU(cpu);
>      CPUX86State *env = &x86cpu->env;
> @@ -478,29 +478,26 @@ static void mshv_set_standard_regs_vp_page(CPUState *cpu)
>                                  | (1u << HV_X64_REGISTER_CLASS_FLAGS);
>  }
>  
> -static int store_regs(CPUState *cpu)
> +static void store_regs(CPUState *cpu)
>  {
>      X86CPU *x86cpu = X86_CPU(cpu);
>      CPUX86State *env = &x86cpu->env;
> -    int ret;
>  
> -    /* Use register vp page to optimize registers access */
> -    if (env->regs_page && env->regs_page->isvalid != 0) {
> -        mshv_set_standard_regs_vp_page(cpu);
> -    } else {
> -        ret = set_standard_regs(cpu);
> -        if (ret < 0) {
> -            return ret;
> -        }
> +    /* Check register page pointer and abort if in unexpected state */
> +    if (!env->regs_page) {
> +        error_report(
> +                "store regs: register page not set for vcpu %d",
> +                cpu->cpu_index);
> +        abort();
>      }
> -
> -    ret = set_special_regs(cpu);
> -    if (ret < 0) {
> -        error_report("Failed to store speical registers");
> -        return ret;
> +    if (env->regs_page->isvalid == 0) {
> +        error_report(
> +                "store regs: register page invalid for vcpu %d",
> +                cpu->cpu_index);
> +        abort();
>      }
>  
> -    return 0;
> +    set_standard_regs_vp_page(cpu);
>  }
>  
>  static void populate_standard_regs(const hv_register_assoc *assocs,
> @@ -1518,14 +1515,13 @@ static int set_memory_info(const struct hyperv_message *msg,
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
>      load_regs(cpu);
> @@ -1533,13 +1529,7 @@ static int emulate_instruction(CPUState *cpu,
>      decode_instruction_stream(env, &decode, &stream);
>      exec_instruction(env, &decode);
>  
> -    ret = store_regs(cpu);
> -    if (ret < 0) {
> -        error_report("failed to store registers");
> -        return -1;
> -    }
> -
> -    return 0;
> +    store_regs(cpu);
>  }
>  
>  static int handle_mmio(CPUState *cpu, const struct hyperv_message *msg,
> @@ -1575,13 +1565,9 @@ static int handle_mmio(CPUState *cpu, const struct hyperv_message *msg,
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

