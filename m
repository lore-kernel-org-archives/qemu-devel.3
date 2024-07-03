Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE4E7C2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 08:53:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOvkI-0004JC-93; Wed, 03 Jul 2024 04:53:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ying.huang@intel.com>)
 id 1sOvkF-0004IV-ME
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 04:53:43 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ying.huang@intel.com>)
 id 1sOvkD-0004iJ-F2
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 04:53:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1719996821; x=1751532821;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=uJy6npIbvFhICTmqeRyyXfHKUe2Xu5teyWK4mPdnf60=;
 b=g/ahm4rmFWfpd3VC3C/iUTS0xUy/Ao6OI3QE3fHrqJpzDuSlP1kwaJF5
 axotzHVs/6Laq4B7SpNId6lMHB8awO0t1V09F9KofBOC+s5qmxW89yPIE
 RvxZuM1oou6+3OTa0J5wn7/eYxC0hvDghkvK4UGBd6jl8sfTfbRnRyg8N
 u4YoR0HrYaK0Jv7rJRf3uIrUtUpn1AjnVvCXwOUbhiL9dcH7ztey8Y4Uh
 JciTNE+qIFopTNioz7hXIleT8KahGI7sVzDVFnjUkLBMOtM0AqY77m3hq
 4iKdS6/t5UksnEYd0hLGPSqI17iSf0PnQhNjn728sbJem0JsiYxTPmF0D g==;
X-CSE-ConnectionGUID: K7x1ja/gR8ygFmNR+htxfA==
X-CSE-MsgGUID: Ip34g9+8QUqfWM7Z8oxPFQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="27818569"
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; d="scan'208";a="27818569"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2024 01:53:36 -0700
X-CSE-ConnectionGUID: TNLyrCPHR5SOEUdQfrNb3w==
X-CSE-MsgGUID: b4l4Pq1yTnWXfVH4a1AjFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; d="scan'208";a="50633629"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com)
 ([10.238.208.55])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2024 01:53:31 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: "Ho-Ren (Jack) Chuang" <horen.chuang@linux.dev>,  Gregory Price
 <gourry.memverge@gmail.com>,  <aneesh.kumar@linux.ibm.com>,
 <mhocko@suse.com>,  <tj@kernel.org>,  <john@jagalactic.com>,  Eishan
 Mirakhur <emirakhur@micron.com>,  Vinicius Tavares Petrucci
 <vtavarespetr@micron.com>,  Ravis OpenSrc <Ravis.OpenSrc@micron.com>,
 Alistair Popple <apopple@nvidia.com>,  Srinivasulu Thanneeru
 <sthanneeru@micron.com>,  SeongJae Park <sj@kernel.org>,  "Rafael J.
 Wysocki" <rafael@kernel.org>,  "Len Brown" <lenb@kernel.org>,  Andrew
 Morton <akpm@linux-foundation.org>,  "Dave Jiang" <dave.jiang@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,  <linux-acpi@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>,  <linux-mm@kvack.org>,  "Ho-Ren (Jack)
 Chuang" <horenc@vt.edu>,  "Ho-Ren (Jack) Chuang"
 <horenchuang@bytedance.com>,  "Ho-Ren (Jack) Chuang"
 <horenchuang@gmail.com>,  <linux-cxl@vger.kernel.org>,
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2 1/1] memory tier: consolidate the initialization of
 memory tiers
In-Reply-To: <20240702142535.00003dc0@Huawei.com> (Jonathan Cameron's message
 of "Tue, 2 Jul 2024 14:25:35 +0100")
References: <20240628060925.303309-1-horen.chuang@linux.dev>
 <20240628060925.303309-2-horen.chuang@linux.dev>
 <20240702142535.00003dc0@Huawei.com>
Date: Wed, 03 Jul 2024 16:51:40 +0800
Message-ID: <87a5iykgdf.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Received-SPF: pass client-ip=198.175.65.11; envelope-from=ying.huang@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Jonathan Cameron <Jonathan.Cameron@Huawei.com> writes:

> On Fri, 28 Jun 2024 06:09:23 +0000
> "Ho-Ren (Jack) Chuang" <horen.chuang@linux.dev> wrote:

[snip]

>> @@ -875,8 +886,7 @@ static int __meminit memtier_hotplug_callback(struct notifier_block *self,
>>  
>>  static int __init memory_tier_init(void)
>>  {
>> -	int ret, node;
>> -	struct memory_tier *memtier;
>> +	int ret;
>>  
>>  	ret = subsys_virtual_register(&memory_tier_subsys, NULL);
>>  	if (ret)
>> @@ -887,7 +897,8 @@ static int __init memory_tier_init(void)
>>  				GFP_KERNEL);
>>  	WARN_ON(!node_demotion);
>>  #endif
>> -	mutex_lock(&memory_tier_lock);
>> +
>> +	guard(mutex)(&memory_tier_lock);
>
> If this was safe to do without the rest of the change (I think so)
> then better to pull that out as a trivial precursor so less noise
> in here.
>
>>  	/*
>>  	 * For now we can have 4 faster memory tiers with smaller adistance
>>  	 * than default DRAM tier.
>> @@ -897,29 +908,9 @@ static int __init memory_tier_init(void)
>>  	if (IS_ERR(default_dram_type))
>>  		panic("%s() failed to allocate default DRAM tier\n", __func__);
>>  
>> -	/*
>> -	 * Look at all the existing N_MEMORY nodes and add them to
>> -	 * default memory tier or to a tier if we already have memory
>> -	 * types assigned.
>> -	 */
>> -	for_each_node_state(node, N_MEMORY) {
>> -		if (!node_state(node, N_CPU))
>> -			/*
>> -			 * Defer memory tier initialization on
>> -			 * CPUless numa nodes. These will be initialized
>> -			 * after firmware and devices are initialized.
>> -			 */
>> -			continue;
>> -
>> -		memtier = set_node_memory_tier(node);
>> -		if (IS_ERR(memtier))
>> -			/*
>> -			 * Continue with memtiers we are able to setup
>> -			 */
>> -			break;
>> -	}
>> -	establish_demotion_targets();
>> -	mutex_unlock(&memory_tier_lock);
>> +	/* Record nodes with memory and CPU to set default DRAM performance. */
>> +	nodes_and(default_dram_nodes, node_states[N_MEMORY],
>> +		  node_states[N_CPU]);
>
> There are systems where (for various esoteric reasons, such as describing an
> association with some other memory that isn't DRAM where the granularity
> doesn't match) the CPU nodes contain no DRAM but rather it's one node away.
> Handling that can be a job for another day though.
>
> Why does this need to be computed here?  Why not do it in
> hmat_set_default_dram_perf? Doesn't seem to be used anywhere else.

IMO, which node is default dram node is a general concept instead of
HMAT specific.  So, I think that it's better to decide that in the
general code (memory-tiers.c).

>>  
>>  	hotplug_memory_notifier(memtier_hotplug_callback, MEMTIER_HOTPLUG_PRI);
>>  	return 0;

--
Best Regards,
Huang, Ying

