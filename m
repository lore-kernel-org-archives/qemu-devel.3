Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B6D0E7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 07:50:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLdx2-0007aN-NV; Thu, 12 Dec 2024 02:49:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tLdwz-0007a8-8a
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 02:49:33 -0500
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tLdww-0007b5-7p
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 02:49:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733989771; x=1765525771;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=mHjSpBL3vmykAIaKbW2WYbZBw4kigGEu4qrdClZvK5U=;
 b=dVmybkkQsuozO7z1dYO6BuIbswcd7T1wlmJlpwnP2ZQh1sOTxrU4RDtV
 eSKlrCZLEQXUQQlHI51+aeKNtlO2W+xBnuApb5Sr2VoixLnpUN0+EbNU1
 EwaNMlN2IQkBSPuA4dEK8Ao1QvGENpVxJ406QRAtxHDMxr7SdGObeya9a
 wd7a7k38EY4vfHgKgIRx7aB567ALFoQVm/o43/mN80F/hGqAt/eg3WsMj
 knLjRf/aLsJa5qxIjSYGJoVUYwNu9+jc8dKcY3MM+DelBhnPwVpkQGfee
 DIIFxVVX2grCwkGZGzf2XT0P9jlX4jH4RNuPOqoab+k24FynhyOltba5Z A==;
X-CSE-ConnectionGUID: x3iqp82YTp+iESrqcPDrXQ==
X-CSE-MsgGUID: QagBMhHQQECjyX4FGhag9w==
X-IronPort-AV: E=McAfee;i="6700,10204,11283"; a="34439265"
X-IronPort-AV: E=Sophos;i="6.12,227,1728975600"; d="scan'208";a="34439265"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Dec 2024 23:49:26 -0800
X-CSE-ConnectionGUID: 7okOIhM0Td+7Ouqa45RhEA==
X-CSE-MsgGUID: zmgxLfqXTWedfbcXlMc7xA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,227,1728975600"; d="scan'208";a="101179535"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa004.jf.intel.com with ESMTP; 11 Dec 2024 23:49:23 -0800
Date: Thu, 12 Dec 2024 16:07:38 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: pbonzini@redhat.com, xiaoyao.li@intel.com, qemu-devel@nongnu.org,
 seanjc@google.com, michael.roth@amd.com, rick.p.edgecombe@intel.com,
 isaku.yamahata@intel.com, farrah.chen@intel.com, kvm@vger.kernel.org
Subject: Re: [PATCH] i386/kvm: Set return value after handling
 KVM_EXIT_HYPERCALL
Message-ID: <Z1qZygKqvjIfpOXD@intel.com>
References: <20241212032628.475976-1-binbin.wu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212032628.475976-1-binbin.wu@linux.intel.com>
Received-SPF: pass client-ip=198.175.65.17; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.472,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Thu, Dec 12, 2024 at 11:26:28AM +0800, Binbin Wu wrote:
> Date: Thu, 12 Dec 2024 11:26:28 +0800
> From: Binbin Wu <binbin.wu@linux.intel.com>
> Subject: [PATCH] i386/kvm: Set return value after handling
>  KVM_EXIT_HYPERCALL
> X-Mailer: git-send-email 2.46.0
> 
> Userspace should set the ret field of hypercall after handling
> KVM_EXIT_HYPERCALL.  Otherwise, a stale value could be returned to KVM.
> 
> Fixes: 47e76d03b15 ("i386/kvm: Add KVM_EXIT_HYPERCALL handling for KVM_HC_MAP_GPA_RANGE")
> Reported-by: Farrah Chen <farrah.chen@intel.com>
> Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
> Tested-by: Farrah Chen <farrah.chen@intel.com>
> ---
> To test the TDX code in kvm-coco-queue, please apply the patch to the QEMU,
> otherwise, TDX guest boot could fail.
> A matching QEMU tree including this patch is here:
> https://github.com/intel-staging/qemu-tdx/releases/tag/tdx-qemu-upstream-v6.1-fix_kvm_hypercall_return_value
> 
> Previously, the issue was not triggered because no one would modify the ret
> value. But with the refactor patch for __kvm_emulate_hypercall() in KVM,
> https://lore.kernel.org/kvm/20241128004344.4072099-7-seanjc@google.com/, the
> value could be modified.

Could you explain the specific reasons here in detail? It would be
helpful with debugging or reproducing the issue.

> ---
>  target/i386/kvm/kvm.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index 8e17942c3b..4bcccb48d1 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -6005,10 +6005,14 @@ static int kvm_handle_hc_map_gpa_range(struct kvm_run *run)
>  
>  static int kvm_handle_hypercall(struct kvm_run *run)
>  {
> +    int ret = -EINVAL;
> +
>      if (run->hypercall.nr == KVM_HC_MAP_GPA_RANGE)
> -        return kvm_handle_hc_map_gpa_range(run);
> +        ret = kvm_handle_hc_map_gpa_range(run);
> +
> +    run->hypercall.ret = ret;

ret may be negative but hypercall.ret is u64. Do we need to set it to
-ret?

> -    return -EINVAL;
> +    return ret;
>  }
>  
>  #define VMX_INVALID_GUEST_STATE 0x80000021
> 
> base-commit: ae35f033b874c627d81d51070187fbf55f0bf1a7
> -- 
> 2.46.0
> 
> 

