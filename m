Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 635DECAC582
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 05:46:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwwbW-0002X0-G9; Fri, 12 Sep 2025 01:45:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uwwbU-0002WY-Lj
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 01:45:48 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uwwbT-0001tR-4D
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 01:45:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1757655947; x=1789191947;
 h=message-id:date:mime-version:subject:from:to:cc:
 references:in-reply-to:content-transfer-encoding;
 bh=p8K1sW4Kid3fzpsaK6PQNYLx9bTE89OTl0+vvECFNpw=;
 b=QHaUYNabnxplZ+Hc0/6lOogkzaqhVyK09nChTzwSJRyW92HNLg7rW6XE
 PX3D59eeLjkqeHLIdKEaT2xRoAQWKO8tLNtBnoSARB0pPepoj6fkZaxTf
 fVygvONy822jTil+ubMO1SBoUlN6IdoDMxBAyep5zRi+lSTmEBbeZIgOF
 4Jj9ExePni29fiacW57V7eQJeEhC0lWaSzFpFnAoBz1HJBuXRRnx6N1XF
 aUAO0p320hkm63O+tWLoMdQu3SWtqNg5NWRQ1gD/xS/dSaVbrPcEOAYP2
 T9fpH9hJAHV/rxHL/bCyClT1B72q5SEKfF0MBsJk4j0LFp5tDnjiFvbUp g==;
X-CSE-ConnectionGUID: jD4Rq1LyRfWsWwwW/f/xNg==
X-CSE-MsgGUID: Dz9CqyNERdGUqE1HPaRV2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11550"; a="60144474"
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; d="scan'208";a="60144474"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2025 22:45:45 -0700
X-CSE-ConnectionGUID: 3b5CkZQATOiXu+7tLQ+viw==
X-CSE-MsgGUID: 1Sn+6juTR8KEoOjyixMTzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; d="scan'208";a="173055492"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.238.14])
 ([10.124.238.14])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2025 22:45:45 -0700
Message-ID: <b1263375-8fac-4452-9c4f-983ef8870a44@intel.com>
Date: Fri, 12 Sep 2025 13:45:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hostmem/shm: Allow shm memory backend serve as shared
 memory for coco-VMs
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: David Hildenbrand <david@redhat.com>, Igor Mammedov
 <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Stefano Garzarella <sgarzare@redhat.com>
References: <20250721065220.895606-1-xiaoyao.li@intel.com>
 <f38c961d-9c5a-4e45-a42e-fbafb7e5e88b@intel.com>
Content-Language: en-US
In-Reply-To: <f38c961d-9c5a-4e45-a42e-fbafb7e5e88b@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.16; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 8/14/2025 5:45 PM, Xiaoyao Li wrote:
> On 7/21/2025 2:52 PM, Xiaoyao Li wrote:
>> shm can surely serve as the shared memory for coco-VMs. But currently it
>> doesn't check the backend->guest_memfd to pass down the RAM_GUEST_MEMFD
>> flag. It leads to failure when creating coco-VMs (e.g., TDX guest) which
>> require private mmeory.
>>
>> Set and pass down RAM_GUEST_MEMFD when backend->guest_memfd is true, to
>> allow shm memory backend serve as shared memory for coco-VMs.
> 
> ping...
> 
> Paolo, will you merge it for QEMU 10.1? I think it's worth it.

ping again.

>> cc: Stefano Garzarella <sgarzare@redhat.com>
>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> ---
>>   backends/hostmem-shm.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/backends/hostmem-shm.c b/backends/hostmem-shm.c
>> index f66211a2ec92..806e2670e039 100644
>> --- a/backends/hostmem-shm.c
>> +++ b/backends/hostmem-shm.c
>> @@ -54,6 +54,7 @@ have_fd:
>>       /* Let's do the same as memory-backend-ram,share=on would do. */
>>       ram_flags = RAM_SHARED;
>>       ram_flags |= backend->reserve ? 0 : RAM_NORESERVE;
>> +    ram_flags |= backend->guest_memfd ? RAM_GUEST_MEMFD : 0;
>>       return memory_region_init_ram_from_fd(&backend->mr, 
>> OBJECT(backend),
>>                                                 backend_name, backend- 
>> >size,
> 
> 


