Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D5FFC83F1A
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Jul 2025 08:45:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueV59-0007r4-13; Wed, 23 Jul 2025 04:44:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ueV3e-0006Yk-P6
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 04:42:39 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ueV3b-0001kr-O6
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 04:42:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753260156; x=1784796156;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=QNYAp68jc80gMi8DboSo831/pCWYJq8t+unCh2agpCo=;
 b=XSOYOJBMtLIe5saoEEwicpaW64vdKNXIEdH5DPbOYM/c8NF9AOHk+hrs
 IyzihWCAJDvru5FdwuR6AhBHIdAjZnLQeKUlNPe+aRm7vjQ1aBgTCV/OK
 t4/04l8/KgYdC4MXaXA/m5wLWPwtVmS0hHhX9GpN0WXB7+GD6pGJ35gfF
 1IvisgUQLsNDpSPt3Lh+bUsw+SLP8k/bXpY5YxQAuYGDR7qGGloandEov
 mf60IwHOHP2NFN2GqB2/lv+swqQHHVClyyP/WqNe+EtmCw3MS/xRJEN5F
 dn9zg3kXRKUaS9Q7z0Mkts5comRYFqfFgCs2HrSs71XgvVdHxbvaCGTTi A==;
X-CSE-ConnectionGUID: +zudM4ckRKO1q4ZxNnocwQ==
X-CSE-MsgGUID: Tav7wsYdSM6Ag3w0Fua3IA==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="59351798"
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; d="scan'208";a="59351798"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2025 01:42:32 -0700
X-CSE-ConnectionGUID: c2/SzqT6QzO8r37kmmWaBQ==
X-CSE-MsgGUID: Ryun+ZNWTSSf0WZQv13n6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; d="scan'208";a="160114778"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2025 01:42:30 -0700
Message-ID: <fbd47fb6-838e-47bf-a344-f90be06eed99@intel.com>
Date: Wed, 23 Jul 2025 16:42:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] i386/kvm: Disable hypercall patching quirk by default
To: Mathias Krause <minipli@grsecurity.net>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org,
 Oliver Upton <oliver.upton@linux.dev>,
 Sean Christopherson <seanjc@google.com>
References: <20250722204316.1186096-1-minipli@grsecurity.net>
 <206a04b9-91cb-41e4-b762-92201c659d78@intel.com>
 <ebbb7c3c-b8cb-49b6-a029-e291105300fd@grsecurity.net>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <ebbb7c3c-b8cb-49b6-a029-e291105300fd@grsecurity.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.12; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.633,
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

On 7/23/2025 3:53 PM, Mathias Krause wrote:
>> I would leave it to Paolo to decide whether a compat property is needed
>> to disable the hypercall patching by default for newer machine, and keep
>> the old machine with old behavior (hypercall patching is enabled) by
>> default.
> Bleh, I just noticed that there are KUT tests that actually rely on the
> feature[1]. I'll fix these but, looks like, we need to default on for
> the feature -- at least for existing machine definitions 🙁

You reminds me.

There is also even a specific KUT hypercall.c, and default off fails it 
as well.

enabling apic
smp: waiting for 0 APs
Hypercall via VMCALL: OK
Unhandled exception 6 #UD at ip 00000000004003dd
error_code=0000      rflags=00010002      cs=00000008
rax=00000000ffffffff rcx=00000000000003fd rdx=00000000000003f8 
rbx=0000000000000001
rbp=0000000000710ff0 rsi=00000000007107b1 rdi=000000000000000a
  r8=00000000007107b1  r9=00000000000003f8 r10=000000000000000d 
r11=0000000000000020
r12=0000000000000001 r13=0000000000000000 r14=0000000000000000 
r15=0000000000000000
cr0=0000000080000011 cr2=0000000000000000 cr3=000000000040c000 
cr4=0000000000000020
cr8=0000000000000000
	STACK: @4003dd 4001ad
  > Looks like I have to go the compat property route.
> 
> [1]
> https://gitlab.com/kvm-unit-tests/kvm-unit-tests/-/blob/master/x86/ 
> vmexit.c?ref_type=heads#L36


