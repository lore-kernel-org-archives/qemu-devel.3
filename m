Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B798C48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 08:33:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcLYO-0000mG-TY; Tue, 20 Feb 2024 03:32:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rcLYI-0000lr-SO
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 03:32:35 -0500
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rcLYF-0004VJ-8c
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 03:32:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1708417951; x=1739953951;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=4i3wXuUUCZl45VDOs9eLSI3djwSURdciX6oeG3Vvx9M=;
 b=KvY+QxNkcFgkzh7xF9HUarvhEl/zYmS1GWU8YPHkRlzEvNPL2AfF6w9Z
 IdY8dV5xsqbwCcY+4RacDNYoOUutSYYIxpRS6zfJ5jEoZBL6kk5UhV8s1
 4ujAvCWb6dbXEdt5d+rg21IGH9kX9BBzBoOrNg2rfZZipn3XUB0fy5VaC
 SfjAGLGu3dVskrPWSmgEAqa3yGYWgKe/oacL8gGNPf3d2vn4Nw+wDhu/2
 0Tcz1cHJsparF0hvCGoPzv3iIQNpSQq1CBFD54E56Ps5SZUNB+blXr3Zs
 qwcENQ2729z40rCo9kzXrpSMGSTd+GeC3aZcB4RSDBzaNmUSS5N5yOcrf Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="20040934"
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; d="scan'208";a="20040934"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Feb 2024 00:32:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="4679611"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.93.12.199])
 ([10.93.12.199])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Feb 2024 00:32:08 -0800
Message-ID: <b041fdb3-5b08-4a85-913a-ebb3c7dfbe1d@intel.com>
Date: Tue, 20 Feb 2024 16:32:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] target/i386/kvm: Refine VMX controls setting for
 backward compatibility
To: EwanHai <ewanhai-oc@zhaoxin.com>, pbonzini@redhat.com,
 mtosatti@redhat.com, kvm@vger.kernel.org, zhao1.liu@intel.com
Cc: qemu-devel@nongnu.org, cobechen@zhaoxin.com, ewanhai@zhaoxin.com
References: <20231127034326.257596-1-ewanhai-oc@zhaoxin.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20231127034326.257596-1-ewanhai-oc@zhaoxin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.8; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.072,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.999, HK_RANDOM_FROM=1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 11/27/2023 11:43 AM, EwanHai wrote:
> Commit 4a910e1 ("target/i386: do not set unsupported VMX secondary
> execution controls") implemented a workaround for hosts that have
> specific CPUID features but do not support the corresponding VMX
> controls, e.g., hosts support RDSEED but do not support RDSEED-Exiting.
> 
> In detail, commit 4a910e1 introduced a flag `has_msr_vmx_procbased_clts2`.
> If KVM has `MSR_IA32_VMX_PROCBASED_CTLS2` in its msr list, QEMU would
> use KVM's settings, avoiding any modifications to this MSR.
> 
> However, this commit (4a910e1) didn't account for cases in older Linux
> kernels(<5.3) where `MSR_IA32_VMX_PROCBASED_CTLS2` is in
> `kvm_feature_msrs`-obtained by ioctl(KVM_GET_MSR_FEATURE_INDEX_LIST),
> but not in `kvm_msr_list`-obtained by ioctl(KVM_GET_MSR_INDEX_LIST).
> As a result,it did not set the `has_msr_vmx_procbased_clts2` flag based
> on `kvm_msr_list` alone, even though KVM maintains the value of this MSR.
> 
> This patch supplements the above logic, ensuring that
> `has_msr_vmx_procbased_clts2` is correctly set by checking both MSR
> lists, thus maintaining compatibility with older kernels.
> 
> Signed-off-by: EwanHai <ewanhai-oc@zhaoxin.com>
> ---
> In response to the suggestions from ZhaoLiu(zhao1.liu@intel.com),
> the following changes have been implemented in v2:
> - Adjusted some punctuation in the commit message as per the
>    suggestions.
> - Added comments to the newly added code to indicate that it is a
>    compatibility fix.
> 
> v1 link:
> https://lore.kernel.org/all/20230925071453.14908-1-ewanhai-oc@zhaoxin.com/
> ---
>   target/i386/kvm/kvm.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index 11b8177eff..c8f6c0b531 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -2296,6 +2296,7 @@ void kvm_arch_do_init_vcpu(X86CPU *cpu)
>   static int kvm_get_supported_feature_msrs(KVMState *s)
>   {
>       int ret = 0;
> +    int i;
>   
>       if (kvm_feature_msrs != NULL) {
>           return 0;
> @@ -2330,6 +2331,19 @@ static int kvm_get_supported_feature_msrs(KVMState *s)
>           return ret;
>       }
>   
> +    /*
> +     * Compatibility fix:
> +     * Older Linux kernels(<5.3) include the MSR_IA32_VMX_PROCBASED_CTLS2

we can be more accurate, that kernel version 4.17 to 5.2, reports 
MSR_IA32_VMX_PROCBASED_CTLS2 in KVM_GET_MSR_FEATURE_INDEX_LIST but not 
KVM_GET_MSR_INDEX_LIST.

> +     * only in feature msr list, but not in regular msr list. This lead to
> +     * an issue in older kernel versions where QEMU, through the regular
> +     * MSR list check, assumes the kernel doesn't maintain this msr,
> +     * resulting in incorrect settings by QEMU for this msr.
> +     */
> +    for (i = 0; i < kvm_feature_msrs->nmsrs; i++) {
> +        if (kvm_feature_msrs->indices[i] == MSR_IA32_VMX_PROCBASED_CTLS2) {
> +            has_msr_vmx_procbased_ctls2 = true;
> +        }
> +    }

I'm wondering should we move all the initialization of has_msr_*, that 
associated with feature MSRs, to here. e.g., has_msr_arch_capabs, 
has_msr_vmx_vmfunc,...

>       return 0;
>   }
>   


