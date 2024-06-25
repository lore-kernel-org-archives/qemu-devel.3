Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CF6DC30653
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 09:34:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sM2Ye-0004ip-0A; Tue, 25 Jun 2024 05:33:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sM2Ya-0004iJ-3Q
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 05:33:44 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sM2YU-0000km-Fk
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 05:33:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1719308018; x=1750844018;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=/EBGKUq/bPwKFGVxQK4hCA1mKw9MM/cSXI/gZArZTl0=;
 b=OJgScm+DXSTqNFgOn7Px5XI7khynDuy/PU0vl9gd4viTOFosJB9QFzXc
 BP4iwdWkXB5yVN+b5/uUatBE53V7fvqNhUzNAzhlbfHtguQp/jDJsDt8F
 qDwCaEChSMENIf/gIzv0orBfFvIC1HbCd+przGK1XFGC/8+IbazvHIOCq
 5IZJCoxcbBePeUe2t8JBG0rsLS8GYaYM/GVBZATiI5KPMYqm+eLNiCxPn
 f/EvRIUUs6WuOUj9AAqegcf/sDTsrDS63+vcm7vr1KmKIN11OzzA/j6eq
 TXDBlSlpM2hvjKSfP5P3BA0O+nKOkLHAr+jUDPgbcFWZ6CGpcLVUdwhV/ w==;
X-CSE-ConnectionGUID: JeV70J+9Q3OhgUgwUntsZw==
X-CSE-MsgGUID: PGotsDhnRKqdRM9aqpokVQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="16189563"
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; d="scan'208";a="16189563"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2024 02:33:32 -0700
X-CSE-ConnectionGUID: b5DvKGjFR2qbuNMfbmZCxA==
X-CSE-MsgGUID: Y6TWtXF1TwGaEfs0FJSv6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; d="scan'208";a="48557661"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa005.jf.intel.com with ESMTP; 25 Jun 2024 02:33:30 -0700
Date: Tue, 25 Jun 2024 17:49:03 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: EwanHai <ewanhai-oc@zhaoxin.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, pbonzini@redhat.com,
 mtosatti@redhat.com, kvm@vger.kernel.org, qemu-devel@nongnu.org,
 ewanhai@zhaoxin.com, cobechen@zhaoxin.com
Subject: Re: [PATCH v3] target/i386/kvm: Refine VMX controls setting for
 backward compatibility
Message-ID: <ZnqSj4PGrUeZ7OT1@intel.com>
References: <20240624095806.214525-1-ewanhai-oc@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624095806.214525-1-ewanhai-oc@zhaoxin.com>
Received-SPF: pass client-ip=192.198.163.17; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.207,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

On Mon, Jun 24, 2024 at 05:58:06AM -0400, EwanHai wrote:
> Date: Mon, 24 Jun 2024 05:58:06 -0400
> From: EwanHai <ewanhai-oc@zhaoxin.com>
> Subject: [PATCH v3] target/i386/kvm: Refine VMX controls setting for
>  backward compatibility
> X-Mailer: git-send-email 2.34.1
> 
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
> kernels(4.17~5.2) where `MSR_IA32_VMX_PROCBASED_CTLS2` is in
> `kvm_feature_msrs`-obtained by ioctl(KVM_GET_MSR_FEATURE_INDEX_LIST),
> but not in `kvm_msr_list`-obtained by ioctl(KVM_GET_MSR_INDEX_LIST).
> As a result,it did not set the `has_msr_vmx_procbased_clts2` flag based
> on `kvm_msr_list` alone, even though KVM does maintain the value of
> this MSR.
> 
> This patch supplements the above logic, ensuring that
> `has_msr_vmx_procbased_clts2` is correctly set by checking both MSR
> lists, thus maintaining compatibility with older kernels.
> 
> Signed-off-by: EwanHai <ewanhai-oc@zhaoxin.com>
> ---
> Changes in v3:
> - Use a more precise version range in the comment, specifically "4.17~5.2"
> instead of "<5.3".
> 
> Changes in v2:
> - Adjusted some punctuation in the commit message as per suggestions.
> - Added comments to the newly added code to indicate that it is a compatibility fix.
> 
> v1 link:
> https://lore.kernel.org/all/20230925071453.14908-1-ewanhai-oc@zhaoxin.com/
> 
> v2 link:
> https://lore.kernel.org/all/20231127034326.257596-1-ewanhai-oc@zhaoxin.com/
> ---
>  target/i386/kvm/kvm.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index 7ad8072748..a7c6c5b2d0 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -2386,6 +2386,7 @@ void kvm_arch_do_init_vcpu(X86CPU *cpu)
>  static int kvm_get_supported_feature_msrs(KVMState *s)
>  {
>      int ret = 0;
> +    int i;
>  
>      if (kvm_feature_msrs != NULL) {
>          return 0;
> @@ -2420,6 +2421,20 @@ static int kvm_get_supported_feature_msrs(KVMState *s)
>          return ret;
>      }
>  
> +   /*
> +    * Compatibility fix:
> +    * Older Linux kernels (4.17~5.2) report MSR_IA32_VMX_PROCBASED_CTLS2
> +    * in KVM_GET_MSR_FEATURE_INDEX_LIST but not in KVM_GET_MSR_INDEX_LIST.
> +    * This leads to an issue in older kernel versions where QEMU,
> +    * through the KVM_GET_MSR_INDEX_LIST check, assumes the kernel
> +    * doesn't maintain MSR_IA32_VMX_PROCBASED_CTLS2, resulting in
> +    * incorrect settings by QEMU for this MSR.
> +    */
> +    for (i = 0; i < kvm_feature_msrs->nmsrs; i++) {

nit: `i` could be declared here,

for (int i = 0; i < kvm_feature_msrs->nmsrs; i++) {

> +        if (kvm_feature_msrs->indices[i] == MSR_IA32_VMX_PROCBASED_CTLS2) {
> +            has_msr_vmx_procbased_ctls2 = true;
> +        }
> +    }
>      return 0;
>  }
>  
> -- 
> 2.34.1
>

Since the minimum KVM version supported for i386 is v4.5 (docs/system/
target-i386.rst), this fix makes sense, so for this patch,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

Additionally, has_msr_vmx_vmfunc has the similar compat issue. I think
it deserves a fix, too.

-Zhao


