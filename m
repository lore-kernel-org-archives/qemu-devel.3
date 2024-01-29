Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45AF0C47258
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 02:24:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUHJZ-0001IU-Fi; Sun, 28 Jan 2024 21:24:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rUHJX-0001IL-2f
 for qemu-devel@nongnu.org; Sun, 28 Jan 2024 21:23:59 -0500
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rUHJV-0003pV-6y
 for qemu-devel@nongnu.org; Sun, 28 Jan 2024 21:23:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1706495037; x=1738031037;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=orAmYn8pMaJxl8CsOhFgwF/0wRPX8swPuGuvQx5fGAo=;
 b=WamNKXNbAPginP0RP9UeKl8ZQ/FEUAWY1uNTA+Rut/Yvkw1iyn/iuXC/
 P7+n4ENUgalv7Z+AmyaMrwMWJ+PUaa6Rq9FcqvqK3vE+osXfcIQBRZ9LW
 Gd26wt/W4RibmdfWx4O7ak4AC26FwAj8Ryb2lhxawr8p3vkx91LiGiclc
 P8vxxC1aqFEIh2ZsoZPmgYdTVz7DmW29MW0gT6g2g0ho7ObOQ4ayIdR0y
 uj5D7Mfd2ojB7XWIgiy3wHzX+GmwNnHahE2nZls+wUL9K9oFt2w/YAWRN
 bj9Ng0E6K3JzMTwhrSjam0kv2/y6b1M6HCXICs7RPaGUHEjYmvcxUFz3O A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="16188455"
X-IronPort-AV: E=Sophos;i="6.05,226,1701158400"; d="scan'208";a="16188455"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jan 2024 18:23:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,226,1701158400"; 
   d="scan'208";a="3206435"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.93.33.17])
 ([10.93.33.17])
 by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jan 2024 18:23:48 -0800
Message-ID: <28570a5f-a989-496d-b347-b75763c4ac69@intel.com>
Date: Mon, 29 Jan 2024 10:23:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/66] RAMBlock: Add support of KVM private guest memfd
Content-Language: en-US
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
 <20240125032328.2522472-3-xiaoyao.li@intel.com>
 <504fca4f-89a1-4f92-a2f0-f64b04473ec4@redhat.com>
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <504fca4f-89a1-4f92-a2f0-f64b04473ec4@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.10; envelope-from=xiaoyao.li@intel.com;
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

On 1/26/2024 9:57 PM, David Hildenbrand wrote:
>>   uint8_t memory_region_get_dirty_log_mask(MemoryRegion *mr)
>>   {
>>       uint8_t mask = mr->dirty_log_mask;
>> diff --git a/system/physmem.c b/system/physmem.c
>> index c1b22bac77c2..4735b0462ed9 100644
>> --- a/system/physmem.c
>> +++ b/system/physmem.c
>> @@ -1841,6 +1841,17 @@ static void ram_block_add(RAMBlock *new_block, 
>> Error **errp)
>>           }
>>       }
>> +    if (kvm_enabled() && (new_block->flags & RAM_GUEST_MEMFD) &&
>> +        new_block->guest_memfd < 0) {
> 
> How could we have a guest_memfd already at this point? Smells more like 
> an assert(new_block->guest_memfd < 0);

you are right. I will change it to the assert()

>> +        /* TODO: to decide if KVM_GUEST_MEMFD_ALLOW_HUGEPAGE is 
>> supported */
> 
> I suggest dropping that completely. As long as it's not upstream, not 
> even the name of that thing is stable.

OK

>> +        new_block->guest_memfd = 
>> kvm_create_guest_memfd(new_block->max_length,
>> +                                                        0, errp);
>> +        if (new_block->guest_memfd < 0) {
>> +            qemu_mutex_unlock_ramlist();
>> +            return;
>> +        }
>> +    }
>> +
> 
> 
> In general, LGTM. With the two nits above:
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>
> 

Thanks!



