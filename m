Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63AFEC8303C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 05:16:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ua66j-00031A-7I; Fri, 11 Jul 2025 01:15:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ua66g-0002vS-AD
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 01:15:34 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ua66d-00019f-6G
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 01:15:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752210931; x=1783746931;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=MHqe8QAVGW14hW2TuVHbPnrxaaaU2pez3Fp4gtwSO1s=;
 b=E/KQKM/QXw6GGN3biMAqGxj3YE+B8dHSmZSNglyNlOJ4JNY/XgLmmZCx
 CYv/vEvi/ceyt2w37NEiNBm1TZaEAUlSML4k8DXUzf+oHEyoRhIPRir3r
 C5DfM2Iheaw7vaX5O3jY3kIlFts6ffyQ8shd/WS506/kEkKe3nRm1vMOB
 er78bLmq0kt4H7WgLMlkzCoiRsn/9rXP5YyontM5DYiOWorzdqfUU7xAL
 2n+N4v7GBZy537aGVTmzS08qgI4be8ZLccvmvrYADf6QT0ETSDoWoctub
 XLEa09xjuCl5F1wnzD/6qQO9/CZzClwMteAJFQBRBP8iAmloXr4U66dtY g==;
X-CSE-ConnectionGUID: ahTmVYcwRHW9nPe9ab80NA==
X-CSE-MsgGUID: 8SI0elZ1T4at5vi1XvQWKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="54441274"
X-IronPort-AV: E=Sophos;i="6.16,302,1744095600"; d="scan'208";a="54441274"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2025 22:15:26 -0700
X-CSE-ConnectionGUID: kM5rtqH7Sn6SNUZLJnRgVA==
X-CSE-MsgGUID: KXCWAsTZSHWrn6prEkFQbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,302,1744095600"; d="scan'208";a="187277801"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa002.jf.intel.com with ESMTP; 10 Jul 2025 22:15:25 -0700
Date: Fri, 11 Jul 2025 13:36:53 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, xiaoyao.li@intel.com
Subject: Re: [PATCH 2/4] target/i386: nvmm, whpx: add accel/CPU class that
 sets host vendor
Message-ID: <aHCi9TOICIdg1Qg/@intel.com>
References: <20250711000603.438312-1-pbonzini@redhat.com>
 <20250711000603.438312-3-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250711000603.438312-3-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.17; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Jul 11, 2025 at 02:06:01AM +0200, Paolo Bonzini wrote:
> Date: Fri, 11 Jul 2025 02:06:01 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 2/4] target/i386: nvmm, whpx: add accel/CPU class that sets
>  host vendor
> X-Mailer: git-send-email 2.50.0
> 
> NVMM and WHPX are virtualizers, and therefore they need to use
> (at least by default) the host vendor for the guest CPUID.

Here's a comment of about why the vendor needs to be overridden in KVM:

(in x86_cpu_load_model())

    /* sysenter isn't supported in compatibility mode on AMD,
     * syscall isn't supported in compatibility mode on Intel.
     * Normally we advertise the actual CPU vendor, but you can
     * override this using the 'vendor' property if you want to use
     * KVM's sysenter/syscall emulation in compatibility mode and
     * when doing cross vendor migration
     */

This is a KVM default-vendor hack since the 1st KVM commit [*].

I guess that this hack might have been related to the immaturity of
vDSO at the time (it's been so long, I just took a quick look at the
general time, maybe linux v2.6), or just to reduce overhead.

Now, both KVM's emulation and vDSO seem to be quite stable. Do you
think QEMU KVM still needs to keep this hack today?

Maybe it's difficult to change for QEMU KVM because it's been a
long-time practice, but other accels don't seem to need to inherit KVM's
history. What do you think?

[*]: 1201818980-27534-7-git-send-email-aliguori@us.ibm.com

> Add a cpu_instance_init implementation to these accelerators.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  target/i386/cpu.c           |  8 +++++++-
>  target/i386/nvmm/nvmm-all.c | 23 +++++++++++++++++++++++
>  target/i386/whpx/whpx-all.c | 23 +++++++++++++++++++++++
>  3 files changed, 53 insertions(+), 1 deletion(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 624cebc3ff7..69bdffbfe46 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -43,6 +43,7 @@
>  #include "hw/boards.h"
>  #include "hw/i386/sgx-epc.h"
>  #endif
> +#include "system/qtest.h"
>  #include "tcg/tcg-cpu.h"
>  
>  #include "disas/capstone.h"
> @@ -1943,7 +1944,7 @@ uint32_t xsave_area_size(uint64_t mask, bool compacted)
>  
>  static inline bool accel_uses_host_cpuid(void)
>  {
> -    return kvm_enabled() || hvf_enabled();
> +    return !tcg_enabled() && !qtest_enabled();
>  }

I was considerreing whether we could check this helper and call
host_cpu_instance_init(cpu) directly in x86_cpu_load_model().

However, this goes against the original intent of moving this hack to
the KVM-specific code. But when it can cover almost all accels, it
becomes a general case...

...

So in summary, the benefits of having all accels override the vendor now
include:

the behavior of -cpu NAMED_CPU is consistent across all accels (except
TCG), and all showing the same vendor as the Host.

The possible issue would be: 
 * This changes the previous behavior of these accels, which might not
   have required setting the vendor before, but now the vendor has
   changed... (I'm unsure if these accels are used in migration
   scenarios, but it's better to add a compat option?)
 * expand the scope of historical KVM hack (if it's still a hack?)

Thanks,
Zhao


