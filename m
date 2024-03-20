Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9FE9C54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 12:44:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmvIX-0001x4-Mx; Wed, 20 Mar 2024 08:44:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rmvIV-0001wh-Ot
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 08:43:59 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rmvIU-0008Ep-07
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 08:43:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710938639; x=1742474639;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=WQRuq3hosaq8AklV8ipALSq5HIOOVOi9Ij25lva5twA=;
 b=m0ItuainDzmvO+AofIIbVVIhczw1lN0o9bS0rpHTMmgxd4Am1I6FkdKT
 9o82ilJ3+vBZdYKe6ZbWZFkP8oX68ieKM/f185puxs4FvhctLscgp9hEo
 hqnQTbjvUZmI3mTE5bgAa77y7sbsZS8pwGASEv7EyZcSBSdGz0jGe/yxw
 Cm1CUqeo7qrzO31Jn8GG+P2622ixFz2slTRUII2WVliosOI8Z6/ibjGD+
 BOj0M0vx8m/g5nbLuIe8GWreF+JvrfVHbyJhbRxQvcDhIFlLeL+kn7FeN
 2cDA2VQFrGYdwCn9sudDfaUsVY+BZtvOo19MepjPy6AXVI3PQOezLFXno A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="5980111"
X-IronPort-AV: E=Sophos;i="6.07,140,1708416000"; 
   d="scan'208";a="5980111"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2024 05:43:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,140,1708416000"; d="scan'208";a="14119340"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.242.48])
 ([10.124.242.48])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2024 05:43:50 -0700
Message-ID: <8498f23d-0e11-46a6-8519-fc3261457ec3@intel.com>
Date: Wed, 20 Mar 2024 20:43:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/49] physmem: Introduce
 ram_block_discard_guest_memfd_range()
To: David Hildenbrand <david@redhat.com>, Michael Roth
 <michael.roth@amd.com>, qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Pankaj Gupta <pankaj.gupta@amd.com>,
 Isaku Yamahata <isaku.yamahata@linux.intel.com>
References: <20240320083945.991426-1-michael.roth@amd.com>
 <20240320083945.991426-12-michael.roth@amd.com>
 <750e7d5c-cc8b-4794-a7ef-b104c28729fa@redhat.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <750e7d5c-cc8b-4794-a7ef-b104c28729fa@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.18; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.417,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 3/20/2024 5:37 PM, David Hildenbrand wrote:
> On 20.03.24 09:39, Michael Roth wrote:
>> From: Xiaoyao Li <xiaoyao.li@intel.com>
>>
>> When memory page is converted from private to shared, the original
>> private memory is back'ed by guest_memfd. Introduce
>> ram_block_discard_guest_memfd_range() for discarding memory in
>> guest_memfd.
>>
>> Originally-from: Isaku Yamahata <isaku.yamahata@intel.com>
>> Codeveloped-by: Xiaoyao Li <xiaoyao.li@intel.com>
> 
> "Co-developed-by"

Michael is using the patch from my TDX-QEMU v5 series[1]. I need to fix it.

>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> Reviewed-by: David Hildenbrand <david@redhat.com>
> 
> Your SOB should go here.
> 
>> ---
>> Changes in v5:
>> - Collect Reviewed-by from David;
>>
>> Changes in in v4:
>> - Drop ram_block_convert_range() and open code its implementation in the
>>    next Patch.
>>
>> Signed-off-by: Michael Roth <michael.roth@amd.com>
> 
> I only received 3 patches from this series, and now I am confused: 
> changelog talks about v5 and this is "PATCH v3"

As above, because the guest_memfd patches in my TDX-QEMU v5[1] were 
directly picked for this series, so the change history says v5. They are 
needed by SEV-SNP as well.

I want to raise the question, how do we want to proceed with the guest 
memfd patches (patch 2 to 10 in [1])? Can they be merged separately 
before TDX/SNP patches?

> Please make sure to send at least the cover letter along (I might not 
> need the other 46 patches :D ).
> 


[1] 
https://lore.kernel.org/qemu-devel/20240229063726.610065-1-xiaoyao.li@intel.com/

