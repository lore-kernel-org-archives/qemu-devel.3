Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06947C47258
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 02:19:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUHEH-0000Mc-Dc; Sun, 28 Jan 2024 21:18:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rUHEF-0000MK-3f
 for qemu-devel@nongnu.org; Sun, 28 Jan 2024 21:18:31 -0500
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rUHED-0003B2-2U
 for qemu-devel@nongnu.org; Sun, 28 Jan 2024 21:18:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1706494710; x=1738030710;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=7Ckr2Cq+5wBZxzyfGfy82+8eibA0jeCeuSZAZYN+s44=;
 b=bW8buqTBTL2xOdINu0fXKtfcyFTcHJEd4ZXpFMjtY9EyV5HmQpcZGyOL
 PRjM04TeuEP/BDvYxcFpIXPuWq65fOqkNKSwbMrXxhAWZWsgMtJZXSqu3
 IgDPKJ8Evumn3oR0UxREQ7pvH84JirfYDUwSHh6bE/fDkwL26eceuliNd
 5fwTUZbPRVk35RYvZ/KIvdESUmb3tb8ZJgPRUxU/ftPN/UDMTF2iE7Q1r
 qYSjEcFvifi51VLRwHdgv53Z4TwI6EMTpC5cYCugARKZQBpNMMcRuOlQp
 Dhu23P5vXc3Z8JhTrPZKfib2m25kHpWPWIGzrWBV3S9tTIS+dPg4drjKo g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="10216687"
X-IronPort-AV: E=Sophos;i="6.05,226,1701158400"; d="scan'208";a="10216687"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jan 2024 18:18:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="737241304"
X-IronPort-AV: E=Sophos;i="6.05,226,1701158400"; d="scan'208";a="737241304"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.93.33.17])
 ([10.93.33.17])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jan 2024 18:18:14 -0800
Message-ID: <86cda9fa-3921-458f-9930-d73d247ccaa1@intel.com>
Date: Mon, 29 Jan 2024 10:18:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 33/66] i386/tdx: Make memory type private by default
To: David Hildenbrand <david@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Michael Roth <michael.roth@amd.com>, Sean Christopherson
 <seanjc@google.com>, Claudio Fontana <cfontana@suse.de>,
 Gerd Hoffmann <kraxel@redhat.com>, Isaku Yamahata
 <isaku.yamahata@gmail.com>, Chenyi Qiang <chenyi.qiang@intel.com>
References: <20240125032328.2522472-1-xiaoyao.li@intel.com>
 <20240125032328.2522472-34-xiaoyao.li@intel.com>
 <12d89ebd-3497-4e60-8900-7a7a1ffbd6e2@redhat.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <12d89ebd-3497-4e60-8900-7a7a1ffbd6e2@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.12; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.485,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.999, HK_RANDOM_FROM=0.999, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/26/2024 10:58 PM, David Hildenbrand wrote:
> On 25.01.24 04:22, Xiaoyao Li wrote:
>> By default (due to the recent UPM change), restricted memory attribute is
>> shared.  Convert the memory region from shared to private at the memory
>> slot creation time.
>>
>> add kvm region registering function to check the flag
>> and convert the region, and add memory listener to TDX guest code to set
>> the flag to the possible memory region.
>>
>> Without this patch
>> - Secure-EPT violation on private area
>> - KVM_MEMORY_FAULT EXIT (kvm -> qemu)
>> - qemu converts the 4K page from shared to private
>> - Resume VCPU execution
>> - Secure-EPT violation again
>> - KVM resolves EPT Violation
>> This also prevents huge page because page conversion is done at 4K
>> granularity.  Although it's possible to merge 4K private mapping into
>> 2M large page, it slows guest boot.
>>
>> With this patch
>> - After memory slot creation, convert the region from private to shared
>> - Secure-EPT violation on private area.
>> - KVM resolves EPT Violation
>>
>> Originated-from: Isaku Yamahata <isaku.yamahata@intel.com>
>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> ---
>>   include/exec/memory.h |  1 +
>>   target/i386/kvm/tdx.c | 20 ++++++++++++++++++++
>>   2 files changed, 21 insertions(+)
>>
>> diff --git a/include/exec/memory.h b/include/exec/memory.h
>> index 7229fcc0415f..f25959f6d30f 100644
>> --- a/include/exec/memory.h
>> +++ b/include/exec/memory.h
>> @@ -850,6 +850,7 @@ struct IOMMUMemoryRegion {
>>   #define MEMORY_LISTENER_PRIORITY_MIN            0
>>   #define MEMORY_LISTENER_PRIORITY_ACCEL          10
>>   #define MEMORY_LISTENER_PRIORITY_DEV_BACKEND    10
>> +#define MEMORY_LISTENER_PRIORITY_ACCEL_HIGH     20
>>   /**
>>    * struct MemoryListener: callbacks structure for updates to the 
>> physical memory map
>> diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
>> index 7b250d80bc1d..f892551821ce 100644
>> --- a/target/i386/kvm/tdx.c
>> +++ b/target/i386/kvm/tdx.c
>> @@ -19,6 +19,7 @@
>>   #include "standard-headers/asm-x86/kvm_para.h"
>>   #include "sysemu/kvm.h"
>>   #include "sysemu/sysemu.h"
>> +#include "exec/address-spaces.h"
>>   #include "hw/i386/x86.h"
>>   #include "kvm_i386.h"
>> @@ -621,6 +622,19 @@ int tdx_pre_create_vcpu(CPUState *cpu, Error **errp)
>>       return 0;
>>   }
>> +static void tdx_guest_region_add(MemoryListener *listener,
>> +                                 MemoryRegionSection *section)
>> +{
>> +    memory_region_set_default_private(section->mr);
>> +}
> 
> That looks fishy. Why is TDX to decide what happens to other memory 
> regions it doesn't own?
> 
> We should define that behavior when creating these memory region, and 
> TDX could sanity check that they have been setup properly.
> 
> Let me ask differently: For which memory region where we have 
> RAM_GUEST_MEMFD set would we *not* want to set private as default right 
> from the start?

All memory regions have RAM_GUEST_MEMFD set will benefit from being 
private as default, for TDX guest.

I will update the implementation to set RAM_DEFAULT_PRIVATE flag when 
guest_memfd is created successfully, like

diff --git a/system/physmem.c b/system/physmem.c
index fc59470191ef..60676689c807 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -1850,6 +1850,8 @@ static void ram_block_add(RAMBlock *new_block, 
Error **errp)
              qemu_mutex_unlock_ramlist();
              return;
          }
+
+        new_block->flags |= RAM_DEFAULT_PRIVATE;
      }

then this patch can be dropped, and the calling of 
memory_region_set_default_private(mr) of Patch 45 can be dropped too.

I think this is what you suggested, right?



