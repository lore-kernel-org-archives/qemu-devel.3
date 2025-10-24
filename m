Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8D17CCD193
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 00:52:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vC620-00064M-Pb; Thu, 23 Oct 2025 20:51:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1vC61x-000643-Qe
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 20:51:45 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1vC61u-0005N3-Rp
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 20:51:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761267103; x=1792803103;
 h=message-id:date:mime-version:subject:from:to:cc:
 references:in-reply-to:content-transfer-encoding;
 bh=Nq2T+mtt4/jXbD9ztfl08Y+N1NJLtlENRQWzbWSeTYc=;
 b=X7zdaFOk+fCFH43hy1VRv/1N1mX9PKqZ9qsxizbaubZFgg3zvfoptQBl
 eAWBzz/Fj13PhNhitzEk8suxfjy50ZxYvbHGjVIMmzjk9qKFAozGhKts3
 TFJDa5Mq/c9m+bY44rLFzBpLco2iRGVfpqlkpAaXppT+pqlleX3r3aOT8
 dF7BhEk6Gp0fQUe6+IV25BrovMS6jMz7GkWOcYN0bxNS695bSjuzp2S6F
 jC9vH53Q8zkMk9NnEgMqyhrQWaF0ucPDsJhab5MVkpY2gDJMXT9UzBlbM
 fCsYjK26oVaQLPbmmTXc7RnnEUMNtRnOn7UkK8aoYXjoJ+p87EKeesvnf g==;
X-CSE-ConnectionGUID: mgzCOZDbTdWVTMJTdb5RBQ==
X-CSE-MsgGUID: M0TuIUvjRLKEIPLEz8oW4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63485399"
X-IronPort-AV: E=Sophos;i="6.19,251,1754982000"; d="scan'208";a="63485399"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2025 17:51:40 -0700
X-CSE-ConnectionGUID: 0+hRl0ZUSY2qIP2Go93dzA==
X-CSE-MsgGUID: dNQBlBj6TUudzPCLJyNSZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,251,1754982000"; d="scan'208";a="184371060"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.238.14])
 ([10.124.238.14])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2025 17:51:38 -0700
Message-ID: <f59ba5d2-e205-46c7-90c0-8e02ab91f5ae@intel.com>
Date: Fri, 24 Oct 2025 08:51:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hostmem/shm: Allow shm memory backend serve as shared
 memory for coco-VMs
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: David Hildenbrand <david@redhat.com>, Igor Mammedov
 <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Stefano Garzarella <sgarzare@redhat.com>
References: <20250721065220.895606-1-xiaoyao.li@intel.com>
 <f38c961d-9c5a-4e45-a42e-fbafb7e5e88b@intel.com>
 <b1263375-8fac-4452-9c4f-983ef8870a44@intel.com>
Content-Language: en-US
In-Reply-To: <b1263375-8fac-4452-9c4f-983ef8870a44@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.14; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.998, HK_RANDOM_FROM=0.998, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 9/12/2025 1:45 PM, Xiaoyao Li wrote:
> On 8/14/2025 5:45 PM, Xiaoyao Li wrote:
>> On 7/21/2025 2:52 PM, Xiaoyao Li wrote:
>>> shm can surely serve as the shared memory for coco-VMs. But currently it
>>> doesn't check the backend->guest_memfd to pass down the RAM_GUEST_MEMFD
>>> flag. It leads to failure when creating coco-VMs (e.g., TDX guest) which
>>> require private mmeory.
>>>
>>> Set and pass down RAM_GUEST_MEMFD when backend->guest_memfd is true, to
>>> allow shm memory backend serve as shared memory for coco-VMs.
>>
>> ping...
>>
>> Paolo, will you merge it for QEMU 10.1? I think it's worth it.
> 
> ping again.

ping++,

+ Peter,

Maybe you can queue it in case it gets missed from Paolo again?

>>> cc: Stefano Garzarella <sgarzare@redhat.com>
>>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>>> ---
>>>   backends/hostmem-shm.c | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/backends/hostmem-shm.c b/backends/hostmem-shm.c
>>> index f66211a2ec92..806e2670e039 100644
>>> --- a/backends/hostmem-shm.c
>>> +++ b/backends/hostmem-shm.c
>>> @@ -54,6 +54,7 @@ have_fd:
>>>       /* Let's do the same as memory-backend-ram,share=on would do. */
>>>       ram_flags = RAM_SHARED;
>>>       ram_flags |= backend->reserve ? 0 : RAM_NORESERVE;
>>> +    ram_flags |= backend->guest_memfd ? RAM_GUEST_MEMFD : 0;
>>>       return memory_region_init_ram_from_fd(&backend->mr, 
>>> OBJECT(backend),
>>>                                                 backend_name, 
>>> backend- >size,
>>
>>
> 
> 


