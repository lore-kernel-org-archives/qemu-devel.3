Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60B5DC369D5
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Apr 2025 08:34:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8xSd-0005Uj-3K; Sun, 27 Apr 2025 04:34:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u8xSb-0005UE-0Q
 for qemu-devel@nongnu.org; Sun, 27 Apr 2025 04:34:01 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u8xSY-0007lD-Ck
 for qemu-devel@nongnu.org; Sun, 27 Apr 2025 04:34:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1745742838; x=1777278838;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=4rGlzdu8He8ClHKNopue69zlaCk1VKVz+yGQua4n6FQ=;
 b=JEy4rCFDXuJ7ahIjWEVmspbDWpbwXh0t+X0vyvdJLIUMT7fPNuqzu12C
 P4zGTh0sBXuGwxhfnVZ2LAsN1pySWbUfywv69GJ+kFVa1nHQHeF539ZGR
 fNL0p5eIdZFhk36rczwsVuwWZ9mSuCvWZsiYpIIaqvq9UBmSljxsGG9eO
 9afqWFi+Of5trDWq9k9TJKnkX39zTjlN0DQO2h83n3vp1GI23o8Y5XVtw
 bu4GLvux6mXQ9ECkdDhUF7QdCtbx84s5ZIhItWzlQlLn/E06F8uypKVFr
 7tUk+67DtF9v+QDMzMvWBGHKxrltSCMg2EIj08azB7pdoeAv4n9ByVzb3 Q==;
X-CSE-ConnectionGUID: 2RAH1MLjTwKZl1mcRC9Cug==
X-CSE-MsgGUID: xPcgzVBATv2NnWH79qq5cg==
X-IronPort-AV: E=McAfee;i="6700,10204,11415"; a="57995102"
X-IronPort-AV: E=Sophos;i="6.15,243,1739865600"; d="scan'208";a="57995102"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Apr 2025 01:33:55 -0700
X-CSE-ConnectionGUID: Qcy2UMLbRIaepBdyJ083tw==
X-CSE-MsgGUID: CFL9Pbq7TRmRVanh/NT93w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,243,1739865600"; d="scan'208";a="133782755"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa007.jf.intel.com with ESMTP; 27 Apr 2025 01:33:51 -0700
Date: Sun, 27 Apr 2025 16:54:48 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Zide Chen <zide.chen@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Dongli Zhang <dongli.zhang@oracle.com>,
 Mingwei Zhang <mizhang@google.com>, Das Sandipan <Sandipan.Das@amd.com>,
 Shukla Manali <Manali.Shukla@amd.com>, Dapeng Mi <dapeng1.mi@intel.com>
Subject: Re: [PATCH 3/3] target/i386: Support
 VMX_VM_EXIT_SAVE_IA32_PERF_GLOBAL_CTRL
Message-ID: <aA3w2PiRuNOMKwdM@intel.com>
References: <20250324123712.34096-1-dapeng1.mi@linux.intel.com>
 <20250324123712.34096-4-dapeng1.mi@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324123712.34096-4-dapeng1.mi@linux.intel.com>
Received-SPF: pass client-ip=192.198.163.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.738,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=ham autolearn_force=no
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

> @@ -4212,7 +4213,8 @@ static const X86CPUDefinition builtin_x86_defs[] = {
>              VMX_VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL |
>              VMX_VM_EXIT_ACK_INTR_ON_EXIT | VMX_VM_EXIT_SAVE_IA32_PAT |
>              VMX_VM_EXIT_LOAD_IA32_PAT | VMX_VM_EXIT_SAVE_IA32_EFER |
> -            VMX_VM_EXIT_LOAD_IA32_EFER | VMX_VM_EXIT_SAVE_VMX_PREEMPTION_TIMER,
> +            VMX_VM_EXIT_LOAD_IA32_EFER | VMX_VM_EXIT_SAVE_VMX_PREEMPTION_TIMER |
> +            VMX_VM_EXIT_SAVE_IA32_PERF_GLOBAL_CTRL,
>          .features[FEAT_VMX_MISC] =
>              MSR_VMX_MISC_STORE_LMA | MSR_VMX_MISC_ACTIVITY_HLT |
>              MSR_VMX_MISC_VMWRITE_VMEXIT,
> @@ -4368,7 +4370,8 @@ static const X86CPUDefinition builtin_x86_defs[] = {
>              VMX_VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL |
>              VMX_VM_EXIT_ACK_INTR_ON_EXIT | VMX_VM_EXIT_SAVE_IA32_PAT |
>              VMX_VM_EXIT_LOAD_IA32_PAT | VMX_VM_EXIT_SAVE_IA32_EFER |
> -            VMX_VM_EXIT_LOAD_IA32_EFER | VMX_VM_EXIT_SAVE_VMX_PREEMPTION_TIMER,
> +            VMX_VM_EXIT_LOAD_IA32_EFER | VMX_VM_EXIT_SAVE_VMX_PREEMPTION_TIMER |
> +            VMX_VM_EXIT_SAVE_IA32_PERF_GLOBAL_CTRL,
>          .features[FEAT_VMX_MISC] =
>              MSR_VMX_MISC_STORE_LMA | MSR_VMX_MISC_ACTIVITY_HLT |
>              MSR_VMX_MISC_VMWRITE_VMEXIT,
> @@ -4511,7 +4514,8 @@ static const X86CPUDefinition builtin_x86_defs[] = {
>              VMX_VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL |
>              VMX_VM_EXIT_ACK_INTR_ON_EXIT | VMX_VM_EXIT_SAVE_IA32_PAT |
>              VMX_VM_EXIT_LOAD_IA32_PAT | VMX_VM_EXIT_SAVE_IA32_EFER |
> -            VMX_VM_EXIT_LOAD_IA32_EFER | VMX_VM_EXIT_SAVE_VMX_PREEMPTION_TIMER,
> +            VMX_VM_EXIT_LOAD_IA32_EFER | VMX_VM_EXIT_SAVE_VMX_PREEMPTION_TIMER |
> +            VMX_VM_EXIT_SAVE_IA32_PERF_GLOBAL_CTRL,
>          .features[FEAT_VMX_MISC] =
>              MSR_VMX_MISC_STORE_LMA | MSR_VMX_MISC_ACTIVITY_HLT |
>              MSR_VMX_MISC_VMWRITE_VMEXIT,

Instead of modifying SPR's CPU model directly, we should introduce a new
version (SapphireRapids-v4), like Skylake-Server-v4 enables
"vmx-eptp-switching".


