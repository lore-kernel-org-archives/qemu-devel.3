Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24662D4335D
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 13:43:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t92mO-0008MM-Nl; Thu, 07 Nov 2024 08:42:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t92mL-0008M9-28
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 08:42:29 -0500
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t92mH-0006Jq-Sd
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 08:42:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730986946; x=1762522946;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=J6CgFxiyQMzoLTjZ+LzKonhOxj/NCOiWWf17hAfwvwE=;
 b=bd6lW0GTUOGp+r8dchUGo1hKq98UI5vkooD1PH9P3YUWX2MlfPUkfCz9
 UIxHGX2M+L/GVxHvI4Tbwbnz46ZidkxjfL6PVNyJrVsldkBfgOPmNo7q7
 F2Wiisb/TCjo9jAndFhwa2llJi4NdqTHs5NObQ29SqHmKtT/p6YY29nip
 1t57RHM9oNRhtocqFB64yrzKfVUeJzYo83AKsSGtY+nmpx+kUUmAbIl+F
 6AAwK5XqhoUXokBCoqvuSExeBBoWxTUPS6gak5RUUbmu5Nu/ecH/b2Z4o
 SqXd/hH3iz81AKFZuLWxxR7qUwcNCcHqrqaToyVrAHbSvPKvJO1OUzmLO g==;
X-CSE-ConnectionGUID: AqWfHmkTTaaIa8XdIlt+nQ==
X-CSE-MsgGUID: medTwf9sRNSUA4UVrgS4vg==
X-IronPort-AV: E=McAfee;i="6700,10204,11249"; a="42233838"
X-IronPort-AV: E=Sophos;i="6.12,266,1728975600"; d="scan'208";a="42233838"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Nov 2024 05:42:24 -0800
X-CSE-ConnectionGUID: ySgRJEloT3C9qS2NodSwYg==
X-CSE-MsgGUID: JmSzA1zKQ7+JEKEBAF3JUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,266,1728975600"; d="scan'208";a="89049795"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa003.fm.intel.com with ESMTP; 07 Nov 2024 05:42:21 -0800
Date: Thu, 7 Nov 2024 22:00:17 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Bibo Mao <maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org,
 Xianglai Li <lixianglai@loongson.cn>
Subject: Re: [PATCH v2 1/4] hw/loongarch/virt: Add CPU topology support
Message-ID: <ZyzH8cjpTmkN88us@intel.com>
References: <20241029095335.2219343-1-maobibo@loongson.cn>
 <20241029095335.2219343-2-maobibo@loongson.cn>
 <ZyDg00Vwowxkt5LO@intel.com>
 <20241106114150.5af254a7@imammedo.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241106114150.5af254a7@imammedo.users.ipa.redhat.com>
Received-SPF: pass client-ip=198.175.65.12; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Hi Igor,

> > What's the difference between arch_id and CPU index (CPUState.cpu_index)?
> 
> They might be the same but not necessarily.
> arch_id is unique cpu identifier from architecture point of view
> (which easily could be sparse and without specific order).
> (ex: for x86 it's apic_id, for spapr it's core_id)

Yes, I was previously puzzled as to why the core_id of spapr is global,
which is completely different from the meaning of core_id in x86. Now,
your analogy has made it very clear to me. Thanks!

> while cpu_index is internal QEMU, that existed before possible_cpus[]
> and non-sparse range and depends on order of cpus are created.
> For machines that support possible_cpus[], we override default
> cpu_index assignment to fit possible_cpus[].
> 
> It might be nice to get rid of cpu_index in favor of possible_cpus[],
> but that would be a lot work probably with no huge benefit
> when it comes majority of machines that don't need variable
> cpu count. 

Thank you! Now I see.

> > In include/hw/boards.h, the doc of CPUArchId said:
> > 
> > vcpus_count - number of threads provided by @cpu object
> > 
> > And I undersatnd each element in possible_cpus->cpus[] is mapped to a
> > CPU object, so that here vcpus_count should be 1.
> 
> it's arch specific, CPU object in possible_cpus was meant to point to
> thread/core/..higher layers in future../
> 
> For example spapr put's there CPUCore, where vcpus_count can be > 1
>
> That is a bit broken though, since CPUCore is not CPUState by any means,
> spapr_core_plug() gets away with it only because
>   core_slot->cpu = CPU(dev)
> CPU() is dumb pointer cast.

Is it also because of architectural reasons that the smallest granularity
supported by spapr can only be the core?

> Ideally CPUArchId::cpu should be (Object*) to accommodate various
> levels of granularity correctly (with dumb cast above it's just
> cosmetics though as long as we treat it as Object in non arch
> specific code).

Thank you. So, I would like to ask, should the elements in possible_cpus
be understood as the smallest granularity supported by hotplug?

I want to understand that this reason is unrelated to the loongarch patch,
instead I mainly want to continue thinking about my previous qom-topo[*]
proposal.

I remember your hotplug slides also mentioned larger granularity hotplug,
which I understand, for example, allows x86 to support core/socket, etc.
(this of course requires core/socket object abstraction).

If possible_cpus[] only needs to correspond to the smallest granularity
topo object, then it matches my qom-topo proposal quite well, essentially
mapping one layer of a complete topology tree (which is built from socket
to thread, layer by layer) to possible_cpus[] (actually, this is my design:
mapping the thread layer of the x86 topology tree to possible_cpus[]. :) )

Although many years have passed, I still believe that larger granularity
hotplug is valuable, especially as hardware includes more and more CPUs.

[*]: https://lore.kernel.org/qemu-devel/20240919015533.766754-1-zhao1.liu@intel.com/

[snip]

> > IIUC, the phy_id is kind of like the x86 apic_id, but the field is completely
> > derived from topology, so why do you need to define it as a property and then
> > expose it to the user?
> 
> for x86 we do expose apic_id as a property as well, partly from historical pov
> but also it's better to access cpu fields via properties from outside of
> CPU object than directly poke inside of CPU structure from outside of CPU
> (especially if it comes to generic code)

Thank you for your guidance. Similar to Bibo¡¯s question, I also wonder
if there is the need for a property that won't be exposed to users.

Regards,
Zhao


