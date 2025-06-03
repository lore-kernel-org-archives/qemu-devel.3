Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C2B4C5AE59
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 11:48:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMQ7o-000404-0g; Tue, 03 Jun 2025 07:48:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uMQ7l-0003yK-34
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 07:48:09 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uMQ7f-00089D-La
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 07:48:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748951283; x=1780487283;
 h=message-id:date:mime-version:subject:from:to:cc:
 references:in-reply-to:content-transfer-encoding;
 bh=wFPfWtNIqyhU8/iBwm/da5MNUTLhigsz8vAWZNDTGCU=;
 b=l9afz1H4wjF64pGwKlxwaGb4NBGotIIxgJB6tx2RxmwstHi3dhROuEl/
 CTPmhmUQeCieb/X1dCwYz9tiIQz6xcCHtQIMCjgKWQ8ZKVeuGpNEPA1tW
 ifDHYeI84hrYxfvJpdp4HQfaShux7cV13R/1MnC9p6MoI3nqWx71IcwlH
 dTllORgmonK09xA0lx5Una/xo7+ZtX2KY9Yl2pBEYUhPtnrSk99AKqRPu
 lru1UHFSgzT3H+PRqbXFTF1mAfzlnU+DfBwCf3IouJ4OYhMtZ8cKAOs+g
 mJWN0IcsZ4wSOLSu1mY7n0pUwB29IF/KmfEFaHAmK+EyKDKrxb1a35AR6 A==;
X-CSE-ConnectionGUID: IGka9JI6QFuogFQefdQMuQ==
X-CSE-MsgGUID: Xu8uMrbpT7WWtvd6vArlag==
X-IronPort-AV: E=McAfee;i="6700,10204,11451"; a="51055867"
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; d="scan'208";a="51055867"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2025 04:48:00 -0700
X-CSE-ConnectionGUID: 3fuKTgmhQ2e6/yWCId+uqg==
X-CSE-MsgGUID: jGHfrD9oRYqkMGFllyW5GA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; d="scan'208";a="145794207"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2025 04:47:58 -0700
Message-ID: <cc2dc418-8e33-4c01-9b8a-beca0a376400@intel.com>
Date: Tue, 3 Jun 2025 19:47:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i386/kvm: Prefault memory on page state change
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Tom Lendacky <thomas.lendacky@amd.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, Michael Roth <michael.roth@amd.com>
References: <f5411c42340bd2f5c14972551edb4e959995e42b.1743193824.git.thomas.lendacky@amd.com>
 <4a757796-11c2-47f1-ae0d-335626e818fd@intel.com>
Content-Language: en-US
In-Reply-To: <4a757796-11c2-47f1-ae0d-335626e818fd@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.16; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 6/3/2025 3:41 PM, Xiaoyao Li wrote:
> On 3/29/2025 4:30 AM, Tom Lendacky wrote:
>> A page state change is typically followed by an access of the page(s) and
>> results in another VMEXIT in order to map the page into the nested page
>> table. Depending on the size of page state change request, this can
>> generate a number of additional VMEXITs. For example, under SNP, when
>> Linux is utilizing lazy memory acceptance, memory is typically 
>> accepted in
>> 4M chunks. A page state change request is submitted to mark the pages as
>> private, followed by validation of the memory. Since the guest_memfd
>> currently only supports 4K pages, each page validation will result in
>> VMEXIT to map the page, resulting in 1024 additional exits.
>>
>> When performing a page state change, invoke KVM_PRE_FAULT_MEMORY for the
>> size of the page state change in order to pre-map the pages and avoid the
>> additional VMEXITs. This helps speed up boot times.
> 
> Unfortunately, it breaks TDX guest.
> 
>    kvm_hc_map_gpa_range gpa 0x80000000 size 0x200000 attributes 0x0 
> flags 0x1
> 
> For TDX guest, it uses MAPGPA to maps the range [0x8000 0000, 
> +0x0x200000] to shared. The call of KVM_PRE_FAULT_MEMORY on such range 
> leads to the TD being marked as bugged
> 
> [353467.266761] WARNING: CPU: 109 PID: 295970 at arch/x86/kvm/mmu/ 
> tdp_mmu.c:674 tdp_mmu_map_handle_target_level+0x301/0x460 [kvm]

It turns out to be a KVM bug.

The gpa passed in in KVM_PRE_FAULT_MEMORY, i.e., range->gpa has no 
indication for share vs. private. KVM directly passes range->gpa to 
kvm_tdp_map_page() in kvm_arch_vcpu_pre_fault_memory(), which is then 
assigned to fault.addr

However, fault.addr is supposed to be a gpa of real access in TDX guest, 
which means it needs to have shared bit set if the map is for shared 
access, for TDX case. tdp_mmu_get_root_for_fault() will use it to 
determine which root to be used.

For this case, the pre fault is on the shared memory, while the 
fault.addr leads to mirror_root which is for private memory. Thus it 
triggers KVM_BUG_ON().


> [353472.621399] WARNING: CPU: 109 PID: 295970 at arch/x86/kvm/../../../ 
> virt/kvm/kvm_main.c:4281 kvm_vcpu_pre_fault_memory+0x167/0x1a0 [kvm]
> 
> 
> It seems the pre map on the non MR back'ed range has issue. But I'm 
> still debugging it to understand the root cause.
> 
> 


