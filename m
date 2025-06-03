Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E446EC5AE59
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 07:42:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMMHX-0002LS-1V; Tue, 03 Jun 2025 03:41:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uMMHV-0002LD-1Z
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 03:41:57 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uMMHT-00028Y-00
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 03:41:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748936515; x=1780472515;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=RdjSYOLIhqYxSDIPjkjRquUPKxKRqn8hTjGyKY7tIjY=;
 b=T2KdfvHwArfL6q1dKLu18MkoG1XiinA0j8/ErQjMfaOpchBceHAV41tU
 RkAq7HWASJ6DVHFUzGEGwuvcFPGRC8PA22d3rJD4fCCenXootOALUx34p
 vgUlEH+Xy8xneuqlYUNGd0ZpMTg664SJerAtmdwtSi3r97V97vQxDgMjK
 U58fMoSOsL36LF6OJBxmn3HtYsw1Uhq6xX+YuksMjzXEH7uyjaZ6u1RCz
 8nFWBLkpV64V+9TrYUYkAXPgjuQdN1r29ar2wbu+qVU5LAV3mJE/4N4/V
 iXfSaV+LAEF5EKGI/YNQMA4YnVKarHNARuTz3oNFx39noYqXVHCx3bQmT Q==;
X-CSE-ConnectionGUID: vPE+SV0TQsiuWD6F0jF5vQ==
X-CSE-MsgGUID: lJexExmGT/aERtrKT1NwCw==
X-IronPort-AV: E=McAfee;i="6700,10204,11451"; a="50828100"
X-IronPort-AV: E=Sophos;i="6.16,205,1744095600"; d="scan'208";a="50828100"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2025 00:41:53 -0700
X-CSE-ConnectionGUID: j+uJMciYSTKKa1y07eGVnA==
X-CSE-MsgGUID: 9pt0EXLfTPq7FkCCp/byxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,205,1744095600"; d="scan'208";a="175634245"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2025 00:41:50 -0700
Message-ID: <4a757796-11c2-47f1-ae0d-335626e818fd@intel.com>
Date: Tue, 3 Jun 2025 15:41:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i386/kvm: Prefault memory on page state change
To: Tom Lendacky <thomas.lendacky@amd.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, Michael Roth <michael.roth@amd.com>
References: <f5411c42340bd2f5c14972551edb4e959995e42b.1743193824.git.thomas.lendacky@amd.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <f5411c42340bd2f5c14972551edb4e959995e42b.1743193824.git.thomas.lendacky@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.21; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.015,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
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

On 3/29/2025 4:30 AM, Tom Lendacky wrote:
> A page state change is typically followed by an access of the page(s) and
> results in another VMEXIT in order to map the page into the nested page
> table. Depending on the size of page state change request, this can
> generate a number of additional VMEXITs. For example, under SNP, when
> Linux is utilizing lazy memory acceptance, memory is typically accepted in
> 4M chunks. A page state change request is submitted to mark the pages as
> private, followed by validation of the memory. Since the guest_memfd
> currently only supports 4K pages, each page validation will result in
> VMEXIT to map the page, resulting in 1024 additional exits.
> 
> When performing a page state change, invoke KVM_PRE_FAULT_MEMORY for the
> size of the page state change in order to pre-map the pages and avoid the
> additional VMEXITs. This helps speed up boot times.

Unfortunately, it breaks TDX guest.

   kvm_hc_map_gpa_range gpa 0x80000000 size 0x200000 attributes 0x0 
flags 0x1

For TDX guest, it uses MAPGPA to maps the range [0x8000 0000, 
+0x0x200000] to shared. The call of KVM_PRE_FAULT_MEMORY on such range 
leads to the TD being marked as bugged

[353467.266761] WARNING: CPU: 109 PID: 295970 at 
arch/x86/kvm/mmu/tdp_mmu.c:674 
tdp_mmu_map_handle_target_level+0x301/0x460 [kvm]

[353472.621399] WARNING: CPU: 109 PID: 295970 at 
arch/x86/kvm/../../../virt/kvm/kvm_main.c:4281 
kvm_vcpu_pre_fault_memory+0x167/0x1a0 [kvm]


It seems the pre map on the non MR back'ed range has issue. But I'm 
still debugging it to understand the root cause.


