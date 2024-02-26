Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D75FC48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 08:18:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reWB2-0003sg-Uo; Mon, 26 Feb 2024 03:17:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1reWB1-0003sS-Ek
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 03:17:31 -0500
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1reWAy-0003nV-Pi
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 03:17:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1708935449; x=1740471449;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=0ADXXO2r47p7fuXD5UFpMkpRzd+xcKRiizDP9YjbV0I=;
 b=Zb5tr7mUxJNFNyLu2m78tc/jxur0/5QKwjQg5NCW6XSt317rUJJBU6Mv
 yZHwzpuXmcOGKzyeFNfbHspUtBWV8NoYdmR5r78Bbetv8qh/CVJfmwXLz
 ikMsRD7B4HaabqUdtqSNc/r8++NY2rS827V6qU/8tfSTC7vRI3q6yORqc
 j/FQdAPyS1Lzgo02vwFlVxAwRtw/Amvp3Ua9UqnK1BdqvKvPeDJmNoHIG
 SZqNWOwaOQ3qzVzlADIQhrCMNt/UESQi5cGspYx25uVECOqmaACzv2pph
 7l85iXI3ScY87rHHSIBdlt80Hcv/jFgZr13vuKWlWpgLZW7j0ii3/Utjz A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="13900895"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; d="scan'208";a="13900895"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2024 00:17:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; d="scan'208";a="11303640"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa003.jf.intel.com with ESMTP; 26 Feb 2024 00:17:24 -0800
Date: Mon, 26 Feb 2024 16:31:05 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, mcb30@ipxe.org
Subject: Re: [PATCH v2 5/7] target/i386: Fix physical address truncation
Message-ID: <ZdxMSVTBqQQ4Qpuh@intel.com>
References: <20240223130948.237186-1-pbonzini@redhat.com>
 <20240223130948.237186-6-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223130948.237186-6-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.9; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.097,
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

On Fri, Feb 23, 2024 at 02:09:46PM +0100, Paolo Bonzini wrote:
> Date: Fri, 23 Feb 2024 14:09:46 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH v2 5/7] target/i386: Fix physical address truncation
> X-Mailer: git-send-email 2.43.0
> 
> The address translation logic in get_physical_address() will currently
> truncate physical addresses to 32 bits unless long mode is enabled.
> This is incorrect when using physical address extensions (PAE) outside
> of long mode, with the result that a 32-bit operating system using PAE
> to access memory above 4G will experience undefined behaviour.
> 
> The truncation code was originally introduced in commit 33dfdb5 ("x86:
> only allow real mode to access 32bit without LMA"), where it applied
> only to translations performed while paging is disabled (and so cannot
> affect guests using PAE).
> 
> Commit 9828198 ("target/i386: Add MMU_PHYS_IDX and MMU_NESTED_IDX")
> rearranged the code such that the truncation also applied to the use
> of MMU_PHYS_IDX and MMU_NESTED_IDX.  Commit 4a1e9d4 ("target/i386: Use
> atomic operations for pte updates") brought this truncation into scope
> for page table entry accesses, and is the first commit for which a
> Windows 10 32-bit guest will reliably fail to boot if memory above 4G
> is present.
> 
> The truncation code however is not completely redundant.  Even though the
> maximum address size for any executed instruction is 32 bits, helpers for
> operations such as BOUND, FSAVE or XSAVE may ask get_physical_address()
> to translate an address outside of the 32-bit range, if invoked with an
> argument that is close to the 4G boundary.  Likewise for processor
> accesses, for example TSS or IDT accesses, when EFER.LMA==0.
> 
> So, move the address truncation in get_physical_address() so that it
> applies to 32-bit MMU indexes, but not to MMU_PHYS_IDX and MMU_NESTED_IDX.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2040
> Fixes: 4a1e9d4d11c ("target/i386: Use atomic operations for pte updates", 2022-10-18)
> Co-developed-by: Michael Brown <mcb30@ipxe.org>
> Signed-off-by: Michael Brown <mcb30@ipxe.org>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  target/i386/cpu.h                    |  6 ++++++
>  target/i386/cpu.c                    |  2 +-
>  target/i386/tcg/sysemu/excp_helper.c | 12 +++++-------
>  3 files changed, 12 insertions(+), 8 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

> 
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index ee4ad372021..8a165889de6 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -2326,6 +2326,12 @@ static inline bool is_mmu_index_user(int mmu_index)
>      return (mmu_index & ~1) == MMU_USER64_IDX;
>  }
>  
> +static inline bool is_mmu_index_32(int mmu_index)
> +{
> +    assert(mmu_index < MMU_PHYS_IDX);
> +    return mmu_index & 1;
> +}
> +
>  static inline int cpu_mmu_index_kernel(CPUX86State *env)
>  {
>      int mmu_index_32 = (env->hflags & HF_LMA_MASK) ? 1 : 0;
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 647371198c7..ba6d7b80a7f 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -7732,7 +7732,7 @@ static bool x86_cpu_has_work(CPUState *cs)
>      return x86_cpu_pending_interrupt(cs, cs->interrupt_request) != 0;
>  }
>  
> -static int x86_cpu_mmu_index(CPUState *env, bool ifetch)
> +static int x86_cpu_mmu_index(CPUState *cs, bool ifetch)
>  {
>      CPUX86State *env = cpu_env(cs);
>      int mmu_index_32 = (env->hflags & HF_CS64_MASK) ? 1 : 0;
> diff --git a/target/i386/tcg/sysemu/excp_helper.c b/target/i386/tcg/sysemu/excp_helper.c
> index b2c525e1a92..8bcdd2906d5 100644
> --- a/target/i386/tcg/sysemu/excp_helper.c
> +++ b/target/i386/tcg/sysemu/excp_helper.c
> @@ -558,6 +558,10 @@ static bool get_physical_address(CPUX86State *env, vaddr addr,
>          break;
>  
>      default:
> +        if (is_mmu_index_32(mmu_idx)) {
> +            addr = (uint32_t)addr;
> +        }
> +
>          if (likely(env->cr[0] & CR0_PG_MASK)) {
>              in.cr3 = env->cr[3];
>              in.mmu_idx = mmu_idx;
> @@ -581,14 +585,8 @@ static bool get_physical_address(CPUX86State *env, vaddr addr,
>          break;
>      }
>  
> -    /* Translation disabled. */
> +    /* No translation needed. */
>      out->paddr = addr & x86_get_a20_mask(env);
> -#ifdef TARGET_X86_64
> -    if (!(env->hflags & HF_LMA_MASK)) {
> -        /* Without long mode we can only address 32bits in real mode */
> -        out->paddr = (uint32_t)out->paddr;
> -    }
> -#endif
>      out->prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
>      out->page_size = TARGET_PAGE_SIZE;
>      return true;
> -- 
> 2.43.0
> 
> 

