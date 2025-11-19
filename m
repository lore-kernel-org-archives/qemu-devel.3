Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B684CF34B2
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 14:45:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLjQP-0008Hd-Ow; Wed, 19 Nov 2025 09:44:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1vLjQN-0008HO-T9
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 09:44:48 -0500
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1vLjQM-000535-4w
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 09:44:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763563486; x=1795099486;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=N6/4xLkXn/UEsjhCQ0rtAQhE9Mcq6+4eeh/G/2p2EYA=;
 b=jzz6LLolC0eF/QBlAc4NKSM77xGXXWfn2bcaaqgNhgttTxSPsNUux9G4
 YbUmeIKraZP1/UY5Q7GNixaAfhtozrHdMoLAtbT482wXv+T5lb4vp4/cI
 LyU0GYeeJBF2kzFQ2BXwjpchuyr3rjZR5xTtyNepzp+TTqFxMQXm67uxm
 xh7g8PtiR06mgVc/8tBeOkLT6CrmcErvS87V7GCJzBDG3hKwA4TljaqQ2
 FWXwEZh0dZ5Q//p2vyD9GRr9v+GExeuYEhOl8jQJTLOlczfhhKNelj2Vs
 7VQJ2HeoSSyXffjfmtEOB+YeDgT6fJFkDGg1qx3b5GwRjXtOiNI4YpDO+ Q==;
X-CSE-ConnectionGUID: QOp7oVkHTWWcwocryGk5/A==
X-CSE-MsgGUID: jiO2mcUeQyabRU044PCqQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11618"; a="91082585"
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; d="scan'208";a="91082585"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2025 06:44:43 -0800
X-CSE-ConnectionGUID: IRbRyXrBRtKbHD29jB3LWQ==
X-CSE-MsgGUID: YlQhc8LMSSygkk8R2zWyqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; d="scan'208";a="191323730"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.78])
 ([10.124.240.78])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2025 06:44:41 -0800
Message-ID: <2c0589f9-f3aa-44ac-b8c8-8c518cc751de@intel.com>
Date: Wed, 19 Nov 2025 22:44:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] kvm: Detect guest-memfd flags supported
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Chenyi Qiang <chenyi.qiang@intel.com>,
 David Hildenbrand <david@redhat.com>, Alexey Kardashevskiy <aik@amd.com>,
 Juraj Marcin <jmarcin@redhat.com>
References: <20251023185913.2923322-1-peterx@redhat.com>
 <20251023185913.2923322-4-peterx@redhat.com>
 <30f9d0b9-0a27-4b78-9633-8912bc18998b@intel.com> <aRZKhniIgG7HFaoq@x1.local>
 <aRZLaJZ8ZP5lU6Hy@x1.local>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <aRZLaJZ8ZP5lU6Hy@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.7; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On 11/14/2025 5:19 AM, Peter Xu wrote:
> On Thu, Nov 13, 2025 at 04:15:50PM -0500, Peter Xu wrote:
>> On Fri, Oct 24, 2025 at 11:52:01AM +0800, Xiaoyao Li wrote:
>>>> @@ -2781,6 +2782,11 @@ static int kvm_init(AccelState *as, MachineState *ms)
>>>>        kvm_supported_memory_attributes = kvm_vm_check_extension(s, KVM_CAP_MEMORY_ATTRIBUTES);
>>>>        kvm_guest_memfd_supported = kvm_vm_check_extension(s, KVM_CAP_GUEST_MEMFD) &&
>>>>            kvm_vm_check_extension(s, KVM_CAP_USER_MEMORY2);
>>>> +    ret = kvm_vm_check_extension(s, KVM_CAP_GUEST_MEMFD_FLAGS);
>>>> +    if (ret > 0)
>>>> +        kvm_guest_memfd_flags_supported = (uint64_t)ret;
>>>> +    else
>>>> +        kvm_guest_memfd_flags_supported = 0;
>>>
>>> Nit:
>>> 1. QEMU's coding style always requires curly braces.
>>> 2. is the (uint64_t) necessary?
>>> 3. can we name it "kvm_supported_guest_memfd_flags" to make it consistent
>>> with "kvm_supported_memory_attributes"?
>>>
>>> so how about
>>>
>>> kvm_supported_guest_memfd_flags = kvm_vm_check_extension(s,
>>> KVM_CAP_GUEST_MEMFD_FLAGS);
>>>      if (kvm_supported_guest_memfd_flags < 0) {
>>>          kvm_supported_guest_memfd_flags = 0;
>>>      }
>>
>> Yep this looks good, I'll use it, thanks.
> 
> About naming: note that we already have different styles (both below
> variables introduced by your previous commits):
> 
> static uint64_t kvm_supported_memory_attributes;
> static bool kvm_guest_memfd_supported;

The kvm_supported_* is for multiple bits, while
kvm_*_supported is for a boolean.

> I personally preferred kvm_guest_memfd* as prefix, so I kept it.

I'm fine with it.


