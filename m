Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54A45C46CD2
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jan 2024 12:09:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rThUE-0002yS-I3; Sat, 27 Jan 2024 07:08:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rThUC-0002xv-Sg; Sat, 27 Jan 2024 07:08:36 -0500
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rThU9-0006zk-Nc; Sat, 27 Jan 2024 07:08:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1706357314; x=1737893314;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=3x780jZTGqOv7hVPrMhBFyVFEFi8QjUCScTBKCbV9CE=;
 b=df6/nqNHva3T5YPlXO6O22XXcq0O3QhKKmr/qsvq64JkkMKFpOtPmw7C
 PWId5bSQxbOHYQ/U0DrWe+w+/bPV9OXbyOqjyXkI9moN6wfSMMguE+EcZ
 fIbnCfm3XOIXghxngdNLxskR1pQERiIEiYxAjmlm7YJf3oDpXCyD/OuC1
 UgCwcnMcmDzjaL/h668jszLzu8PhbYr8VEDPiQ/yUTjbGEEqFi8ntCg0W
 uJwkV3x7m9NUxxr48g3nNPywE9274cJ5Z/ww51u9aLcIlu+IgzXU+I1oj
 eWn3pGGMPDNf49gfsdnUytLj2aNbSWJ8it1ae1xdp6nXJvttAPfotKx6e A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="2506045"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="2506045"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jan 2024 04:08:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; d="scan'208";a="29342189"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa001.fm.intel.com with ESMTP; 27 Jan 2024 04:08:23 -0800
Date: Sat, 27 Jan 2024 20:21:27 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 qemu-riscv@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 kvm@vger.kernel.org, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 Paul Durrant <paul@xen.org>, Cameron Esfahani <dirty@apple.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>, xen-devel@lists.xenproject.org
Subject: Re: [PATCH v2 10/23] target/i386: Prefer fast cpu_env() over slower
 CPU QOM cast macro
Message-ID: <ZbT1R7impEw4whqP@intel.com>
References: <20240126220407.95022-1-philmd@linaro.org>
 <20240126220407.95022-11-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240126220407.95022-11-philmd@linaro.org>
Received-SPF: pass client-ip=192.198.163.12; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.282,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi Philippe,

On Fri, Jan 26, 2024 at 11:03:52PM +0100, Philippe Mathieu-Daudé wrote:
> Date: Fri, 26 Jan 2024 23:03:52 +0100
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH v2 10/23] target/i386: Prefer fast cpu_env() over slower
>  CPU QOM cast macro
> X-Mailer: git-send-email 2.41.0
> 
> Mechanical patch produced running the command documented
> in scripts/coccinelle/cpu_env.cocci_template header.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  target/i386/hvf/vmx.h               | 13 +++-------
>  hw/i386/vmmouse.c                   |  6 ++---
>  hw/i386/xen/xen-hvm.c               |  3 +--
>  target/i386/arch_memory_mapping.c   |  3 +--
>  target/i386/cpu-dump.c              |  3 +--
>  target/i386/cpu.c                   | 37 +++++++++------------------
>  target/i386/helper.c                | 39 ++++++++---------------------
>  target/i386/hvf/hvf.c               |  8 ++----
>  target/i386/hvf/x86.c               |  4 +--
>  target/i386/hvf/x86_emu.c           |  6 ++---
>  target/i386/hvf/x86_task.c          | 10 +++-----
>  target/i386/hvf/x86hvf.c            |  6 ++---
>  target/i386/kvm/kvm.c               |  6 ++---
>  target/i386/kvm/xen-emu.c           | 32 ++++++++---------------
>  target/i386/tcg/sysemu/bpt_helper.c |  3 +--
>  target/i386/tcg/tcg-cpu.c           | 14 +++--------
>  target/i386/tcg/user/excp_helper.c  |  3 +--
>  target/i386/tcg/user/seg_helper.c   |  3 +--
>  18 files changed, 59 insertions(+), 140 deletions(-)
> 

[snip]

> diff --git a/target/i386/hvf/x86hvf.c b/target/i386/hvf/x86hvf.c
> index 3b1ef5f49a..1e7fd587fe 100644
> --- a/target/i386/hvf/x86hvf.c
> +++ b/target/i386/hvf/x86hvf.c
> @@ -238,8 +238,7 @@ void hvf_get_msrs(CPUState *cs)
>  
>  int hvf_put_registers(CPUState *cs)
>  {
> -    X86CPU *x86cpu = X86_CPU(cs);
> -    CPUX86State *env = &x86cpu->env;
> +    CPUX86State *env = cpu_env(cs);
>  
>      wreg(cs->accel->fd, HV_X86_RAX, env->regs[R_EAX]);
>      wreg(cs->accel->fd, HV_X86_RBX, env->regs[R_EBX]);
> @@ -282,8 +281,7 @@ int hvf_put_registers(CPUState *cs)
>  
>  int hvf_get_registers(CPUState *cs)
>  {
> -    X86CPU *x86cpu = X86_CPU(cs);
> -    CPUX86State *env = &x86cpu->env;
> +    CPUX86State *env = cpu_env(cs);
>  
>      env->regs[R_EAX] = rreg(cs->accel->fd, HV_X86_RAX);
>      env->regs[R_EBX] = rreg(cs->accel->fd, HV_X86_RBX);

In this file, there's another corner case:

diff --git a/target/i386/hvf/x86hvf.c b/target/i386/hvf/x86hvf.c
index 3b1ef5f49a8a..9a145aa5aa4f 100644
--- a/target/i386/hvf/x86hvf.c
+++ b/target/i386/hvf/x86hvf.c
@@ -342,8 +342,7 @@ void vmx_clear_int_window_exiting(CPUState *cs)

 bool hvf_inject_interrupts(CPUState *cs)
 {
-    X86CPU *x86cpu = X86_CPU(cs);
-    CPUX86State *env = &x86cpu->env;
+    CPUX86State *env = cpu_env(cs);

     uint8_t vector;
     uint64_t intr_type;
@@ -408,7 +407,7 @@ bool hvf_inject_interrupts(CPUState *cs)
     if (!(env->hflags & HF_INHIBIT_IRQ_MASK) &&
         (cs->interrupt_request & CPU_INTERRUPT_HARD) &&
         (env->eflags & IF_MASK) && !(info & VMCS_INTR_VALID)) {
-        int line = cpu_get_pic_interrupt(&x86cpu->env);
+        int line = cpu_get_pic_interrupt(env);
         cs->interrupt_request &= ~CPU_INTERRUPT_HARD;
         if (line >= 0) {
             wvmcs(cs->accel->fd, VMCS_ENTRY_INTR_INFO, line |


For this special case, I'm not sure if the script can cover it as well,
otherwise maybe it's OK to be cleaned up manually ;-).

> diff --git a/target/i386/tcg/user/excp_helper.c b/target/i386/tcg/user/excp_helper.c
> index b3bdb7831a..bfcae9f39e 100644
> --- a/target/i386/tcg/user/excp_helper.c
> +++ b/target/i386/tcg/user/excp_helper.c
> @@ -26,8 +26,7 @@ void x86_cpu_record_sigsegv(CPUState *cs, vaddr addr,
>                              MMUAccessType access_type,
>                              bool maperr, uintptr_t ra)
>  {
> -    X86CPU *cpu = X86_CPU(cs);
> -    CPUX86State *env = &cpu->env;
> +    CPUX86State *env = cpu_env(cs);
>  
>      /*
>       * The error_code that hw reports as part of the exception frame

In this file, there's another case:

diff --git a/target/i386/tcg/user/excp_helper.c b/target/i386/tcg/user/excp_helper.c
index b3bdb7831a7a..02fcd64fc080 100644
--- a/target/i386/tcg/user/excp_helper.c
+++ b/target/i386/tcg/user/excp_helper.c
@@ -52,6 +52,5 @@ void x86_cpu_record_sigsegv(CPUState *cs, vaddr addr,
 void x86_cpu_record_sigbus(CPUState *cs, vaddr addr,
                            MMUAccessType access_type, uintptr_t ra)
 {
-    X86CPU *cpu = X86_CPU(cs);
-    handle_unaligned_access(&cpu->env, addr, access_type, ra);
+    handle_unaligned_access(cpu_env(cs), addr, access_type, ra);
 }

[snip]

LGTM.
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>



