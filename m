Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BEA6E7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 03:45:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLa7h-0000qH-7Z; Wed, 11 Dec 2024 22:44:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tLa7e-0000q1-Gl
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 22:44:18 -0500
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tLa7b-0000Bs-Ix
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 22:44:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733975055; x=1765511055;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=+wucua3PkIdimHEQpSJ5QJWaEULv43kIlkiXzrAGwhU=;
 b=mCV2py0lmwaQ3muEkNgBS5w1vIZASzKi9GwqhProgmZXxgc+20vt0nam
 yELslzPDA/HdmbcFuNuQPYgPLHG1zosV37BXqEJ2vksFiSS5PgD1ZJq0V
 q6QTGHupCVGvRqdRPbViUdeGE5+9ADAkhq9kQbcFqxJTjKtH/6097hnkf
 u7d2KVwxftcFjzSVnHYCJTJOBKtCs2rfE4fGcump8LXHT6bSbPgEmdXxn
 5LakmANWFanixEyTjJD2czz7ot94OMpK3zrWsxqCE3mQpOTxtRjiM9OQD
 YfnA7u21v5dr7jN/Jjfz+ceLQFLz30xW0imaNBKiGPBmmTlCrZjscPJpK w==;
X-CSE-ConnectionGUID: 7WdfAwD8Rp+YsuV85UjQtg==
X-CSE-MsgGUID: dhfhZgcVTG+PvANesQx3jQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11283"; a="33707631"
X-IronPort-AV: E=Sophos;i="6.12,227,1728975600"; d="scan'208";a="33707631"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Dec 2024 19:44:10 -0800
X-CSE-ConnectionGUID: iS/EYUjbQdaGI1JbhbAplw==
X-CSE-MsgGUID: JCZugvyySKm22cOSJglwLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="101033599"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Dec 2024 19:44:08 -0800
Message-ID: <2144c2c0-4a5d-4efd-b5e2-f2b4096c08b5@intel.com>
Date: Thu, 12 Dec 2024 11:44:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i386/kvm: Set return value after handling
 KVM_EXIT_HYPERCALL
To: Binbin Wu <binbin.wu@linux.intel.com>, pbonzini@redhat.com,
 qemu-devel@nongnu.org
Cc: seanjc@google.com, michael.roth@amd.com, rick.p.edgecombe@intel.com,
 isaku.yamahata@intel.com, farrah.chen@intel.com, kvm@vger.kernel.org
References: <20241212032628.475976-1-binbin.wu@linux.intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20241212032628.475976-1-binbin.wu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.18; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.472,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 12/12/2024 11:26 AM, Binbin Wu wrote:
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
> ---
>   target/i386/kvm/kvm.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index 8e17942c3b..4bcccb48d1 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -6005,10 +6005,14 @@ static int kvm_handle_hc_map_gpa_range(struct kvm_run *run)
>   
>   static int kvm_handle_hypercall(struct kvm_run *run)
>   {
> +    int ret = -EINVAL;
> +
>       if (run->hypercall.nr == KVM_HC_MAP_GPA_RANGE)
> -        return kvm_handle_hc_map_gpa_range(run);
> +        ret = kvm_handle_hc_map_gpa_range(run);
> +
> +    run->hypercall.ret = ret;

Updating run->hypercall.ret is useful only when QEMU needs to re-enter 
the guest. For the case of ret < 0, QEMU will stop the vcpu.

I think we might need re-think on the handling of KVM_EXIT_HYPERCALL. 
E.g., in what error case should QEMU stop the vcpu, and in what case can 
QEMU return the error back to the guest via run->hypercall.ret.

> -    return -EINVAL;
> +    return ret;
>   }
>   
>   #define VMX_INVALID_GUEST_STATE 0x80000021
> 
> base-commit: ae35f033b874c627d81d51070187fbf55f0bf1a7


