Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AAA7C25B74
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 03:47:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEL8y-0005ya-WD; Mon, 03 Jun 2024 23:47:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sEL8u-0005sN-1F; Mon, 03 Jun 2024 23:47:24 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sEL8s-0002pm-Ds; Mon, 03 Jun 2024 23:47:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717472842; x=1749008842;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=git2OT0UIEDtb/bX8lyOcRRkdxqRgtAdhkuc7Y1gais=;
 b=NivGlJlLLElCuHmj2wzVIxXwN2RPicGFubT2Es8oDkcvaGrrxIX1wmdx
 5cBEWaoDV6Xp3/98WNUQhg0esLhKQC4HDERD9UeXM1ICqBuE6STES7NX3
 aSZIck6IbTsOW1JOGP/pdNb5VWE+019MvjLOKm9WnwKgGOJMOsk0iyuwa
 p9FwTreMyManAVvdDmbARedyYhKgoXM2//OVS4171riLtDMqxLh5jUrqP
 YvoMt7AzN1cr84cNDaJMvKDvTEutVUh7BAI7bwLYG1/6MIBd4oEruWmPS
 ZBkamFtfWUwvwx31oSJD7uWrULVE9IgU1c+eCZBFagCnW8CNkZYkSoXbB w==;
X-CSE-ConnectionGUID: 1c/WfEGQS1S05jHZe9GHWQ==
X-CSE-MsgGUID: cgEqoCC1TAaOvxW7kXZaMw==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="24652026"
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; d="scan'208";a="24652026"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2024 20:47:20 -0700
X-CSE-ConnectionGUID: 962IT0q2S0qNZwHf4r4/iQ==
X-CSE-MsgGUID: odMLjDu0Sc2n9HqEePWBSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; d="scan'208";a="37157855"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa009.jf.intel.com with ESMTP; 03 Jun 2024 20:47:17 -0700
Date: Tue, 4 Jun 2024 12:02:43 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Zide Chen <zide.chen@intel.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, mst@redhat.com,
 thuth@redhat.com, cfontana@suse.de, xiaoyao.li@intel.com,
 qemu-trivial@nongnu.org, seanjc@google.com
Subject: Re: [PATCH V3 2/2] target/i386: Advertise MWAIT iff host supports
Message-ID: <Zl6R47mj8T7nlWMc@intel.com>
References: <20240604000222.75065-1-zide.chen@intel.com>
 <20240604000222.75065-3-zide.chen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604000222.75065-3-zide.chen@intel.com>
Received-SPF: pass client-ip=192.198.163.9; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, Jun 03, 2024 at 05:02:22PM -0700, Zide Chen wrote:
> Date: Mon, 3 Jun 2024 17:02:22 -0700
> From: Zide Chen <zide.chen@intel.com>
> Subject: [PATCH V3 2/2] target/i386: Advertise MWAIT iff host supports
> X-Mailer: git-send-email 2.34.1
> 
> host_cpu_realizefn() sets CPUID_EXT_MONITOR without consulting host/KVM
> capabilities. This may cause problems:
> 
> - If MWAIT/MONITOR is not available on the host, advertising this
>   feature to the guest and executing MWAIT/MONITOR from the guest
>   triggers #UD and the guest doesn't boot.  This is because typically
>   #UD takes priority over VM-Exit interception checks and KVM doesn't
>   emulate MONITOR/MWAIT on #UD.
> 
> - If KVM doesn't support KVM_X86_DISABLE_EXITS_MWAIT, MWAIT/MONITOR
>   from the guest are intercepted by KVM, which is not what cpu-pm=on
>   intends to do.
> 
> In these cases, MWAIT/MONITOR should not be exposed to the guest.
> 
> The logic in kvm_arch_get_supported_cpuid() to handle CPUID_EXT_MONITOR
> is correct and sufficient, and we can't set CPUID_EXT_MONITOR after
> x86_cpu_filter_features().
> 
> This was not an issue before commit 662175b91ff ("i386: reorder call to
> cpu_exec_realizefn") because the feature added in the accel-specific
> realizefn could be checked against host availability and filtered out.
> 
> Additionally, it seems not a good idea to handle guest CPUID leaves in
> host_cpu_realizefn(), and this patch merges host_cpu_enable_cpu_pm()
> into kvm_cpu_realizefn().
> 
> Fixes: f5cc5a5c1686 ("i386: split cpu accelerators from cpu.c, using AccelCPUClass")
> Fixes: 662175b91ff2 ("i386: reorder call to cpu_exec_realizefn")
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---

LGTM,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


