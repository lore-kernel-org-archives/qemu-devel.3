Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDF0FC83F1A
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Jul 2025 08:51:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueVBq-0004kg-Qx; Wed, 23 Jul 2025 04:51:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ueVBa-0004iR-28
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 04:50:50 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ueVBU-0005KJ-2q
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 04:50:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753260644; x=1784796644;
 h=message-id:date:mime-version:subject:from:to:cc:
 references:in-reply-to:content-transfer-encoding;
 bh=TK8DYv1PHjhFjScJ5kLfKZ8i0nW2pZl+oHS3/788X54=;
 b=L6yOCh6vpLs6/SH9XZ3I+3eXgKoKHqM40Y/zGQSuGspsXu2L6gA7Xhhe
 +vInywcixrKBvTX9rNZRjYAOvVL5C0jDcvCgpI06VGcLRwsBv2b05Vzan
 1WMAKotjwPVOsxH3xrrhpb08JP9mKwmTNw5/i7jH+07OH7sAqs56LfILq
 UJi9vuqQ6MzbPPLIroeaE/+Fa6K7bXbcvADlq1/z+Rt+x5icg3AZdHb0O
 D8kYUbOwb5NHumVYPzZXwOoL/i2s3KKkecV7KJWsiDW3dVBg8hTKeggP2
 2+2AWLhXyL2aewe6GCVH9kGxaHgsAcqoyIFO2mDRSZzAr+n6BUhXTW8Gf w==;
X-CSE-ConnectionGUID: dRxzaDLqTpOTL/J2C8mXcg==
X-CSE-MsgGUID: sgw37Jg2Q76MRgzHOw/maQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="59335275"
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; d="scan'208";a="59335275"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2025 01:50:31 -0700
X-CSE-ConnectionGUID: 1s2nVqlOQtCqcn9JBNMT0w==
X-CSE-MsgGUID: ipSRNVPtSJu4rgY2T5akTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; d="scan'208";a="163646079"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2025 01:50:29 -0700
Message-ID: <c787981c-dc21-4b74-b219-03255781f927@intel.com>
Date: Wed, 23 Jul 2025 16:50:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] i386/kvm: Disable hypercall patching quirk by default
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Mathias Krause <minipli@grsecurity.net>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org,
 Oliver Upton <oliver.upton@linux.dev>,
 Sean Christopherson <seanjc@google.com>
References: <20250722204316.1186096-1-minipli@grsecurity.net>
 <206a04b9-91cb-41e4-b762-92201c659d78@intel.com>
 <ebbb7c3c-b8cb-49b6-a029-e291105300fd@grsecurity.net>
 <fbd47fb6-838e-47bf-a344-f90be06eed99@intel.com>
Content-Language: en-US
In-Reply-To: <fbd47fb6-838e-47bf-a344-f90be06eed99@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.14; envelope-from=xiaoyao.li@intel.com;
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

On 7/23/2025 4:42 PM, Xiaoyao Li wrote:
> On 7/23/2025 3:53 PM, Mathias Krause wrote:
>>> I would leave it to Paolo to decide whether a compat property is needed
>>> to disable the hypercall patching by default for newer machine, and keep
>>> the old machine with old behavior (hypercall patching is enabled) by
>>> default.
>> Bleh, I just noticed that there are KUT tests that actually rely on the
>> feature[1]. I'll fix these but, looks like, we need to default on for
>> the feature -- at least for existing machine definitions 🙁
> 
> You reminds me.
> 
> There is also even a specific KUT hypercall.c, and default off fails it 
> as well.
> 
> enabling apic
> smp: waiting for 0 APs
> Hypercall via VMCALL: OK
> Unhandled exception 6 #UD at ip 00000000004003dd
> error_code=0000      rflags=00010002      cs=00000008
> rax=00000000ffffffff rcx=00000000000003fd rdx=00000000000003f8 
> rbx=0000000000000001
> rbp=0000000000710ff0 rsi=00000000007107b1 rdi=000000000000000a
>   r8=00000000007107b1  r9=00000000000003f8 r10=000000000000000d 
> r11=0000000000000020
> r12=0000000000000001 r13=0000000000000000 r14=0000000000000000 
> r15=0000000000000000
> cr0=0000000080000011 cr2=0000000000000000 cr3=000000000040c000 
> cr4=0000000000000020
> cr8=0000000000000000
>      STACK: @4003dd 4001ad

>> Looks like I have to go the compat property route.

BTW, the compat property doesn't fix KUT issues actually.

Since KUT doesn't use versioned machine, instead of it always uses the 
latest machine.

>>
>> [1]
>> https://gitlab.com/kvm-unit-tests/kvm-unit-tests/-/blob/master/x86/ 
>> vmexit.c?ref_type=heads#L36
> 
> 


