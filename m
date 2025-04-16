Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81165C369B1
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 08:26:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4y2V-0008AU-5H; Wed, 16 Apr 2025 04:22:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dapeng1.mi@linux.intel.com>)
 id 1u4xxo-0002x1-DJ
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 04:17:50 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dapeng1.mi@linux.intel.com>)
 id 1u4xxl-000630-FP
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 04:17:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744791461; x=1776327461;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=L8NvFQCdlJUp/6uJoWj6yMFzx+igvTzyuYbhBvkmkrQ=;
 b=IJiWbp2A/Kf8GDAGQDL0A7dxSd6yUamPOKcQjnrsM8kcUn0ZeMfYk3VZ
 64/hze2oN6QBO12m7kvKKSuMSUaXtlg62YsDKmfs+y1T5pwZMTVUAbEp6
 Ix/CJ3RhMVxphMLYJDuqLXtMsnJUB9KqbF7HeTTK7MLeg/PTu5smZu2t8
 SZsuSKvEK66+avNLns2t0SlvR/npdXCjeBsjcN6XTf+f9AH1etZalAAFA
 Je5K4JFpqOZ1NUGR8dT4nOoYFBmfbfXMTmFWsqykziT5uthYaoLpqHfoz
 4fVS4Z9MxNluT4adXPknn1rbcRfUydzIIKeIiZ+QiPmDwzKZ38+V38PgD g==;
X-CSE-ConnectionGUID: HJjx+xfNRg62qa2bFQzwsg==
X-CSE-MsgGUID: f1+LCJ3fSvmoW8r/vVKpZw==
X-IronPort-AV: E=McAfee;i="6700,10204,11404"; a="46416916"
X-IronPort-AV: E=Sophos;i="6.15,215,1739865600"; d="scan'208";a="46416916"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Apr 2025 01:17:37 -0700
X-CSE-ConnectionGUID: sqQIBIPXSgCFn0oht0TD8A==
X-CSE-MsgGUID: Y+Vs40CMRmWbXe4IspPIGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,215,1739865600"; d="scan'208";a="130897585"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.245.128])
 ([10.124.245.128])
 by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Apr 2025 01:17:31 -0700
Message-ID: <42f59e7f-8353-461b-9c7a-d333083ba791@linux.intel.com>
Date: Wed, 16 Apr 2025 16:17:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/10] target/i386/kvm: reset AMD PMU registers during
 VM reset
To: Ewan Hai <ewanhai-oc@zhaoxin.com>, Zhao Liu <zhao1.liu@intel.com>
Cc: Dongli Zhang <dongli.zhang@oracle.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, pbonzini@redhat.com, mtosatti@redhat.com,
 sandipan.das@amd.com, babu.moger@amd.com, likexu@tencent.com,
 like.xu.linux@gmail.com, zhenyuw@linux.intel.com, groug@kaod.org,
 khorenko@virtuozzo.com, alexander.ivanov@virtuozzo.com, den@virtuozzo.com,
 davydov-max@yandex-team.ru, xiaoyao.li@intel.com, joe.jin@oracle.com,
 ewanhai@zhaoxin.com, cobechen@zhaoxin.com, louisqi@zhaoxin.com,
 liamni@zhaoxin.com, frankzhu@zhaoxin.com, silviazhao@zhaoxin.com,
 yeeli@zhaoxin.com
References: <20250302220112.17653-1-dongli.zhang@oracle.com>
 <20250302220112.17653-9-dongli.zhang@oracle.com>
 <8a547bf5-bdd4-4a49-883a-02b4aa0cc92c@zhaoxin.com>
 <84653627-3a20-44fd-8955-a19264bd2348@oracle.com>
 <e3a64575-ab1f-4b6f-a91d-37a862715742@zhaoxin.com>
 <a94487ab-b06d-4df4-92d8-feceeeaf5ec3@oracle.com>
 <65a6e617-8dd8-46ee-b867-931148985e79@zhaoxin.com>
 <Z/OSEw+yJkN89aDG@intel.com>
 <94e8451f-1b44-4e22-8e3f-378c8490cf00@zhaoxin.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <94e8451f-1b44-4e22-8e3f-378c8490cf00@zhaoxin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=198.175.65.16;
 envelope-from=dapeng1.mi@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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


On 4/7/2025 5:33 PM, Ewan Hai wrote:
>
> On 4/7/25 4:51 PM, Zhao Liu wrote:
>
>> On Tue, Apr 01, 2025 at 11:35:49AM +0800, Ewan Hai wrote:
>>> Date: Tue, 1 Apr 2025 11:35:49 +0800
>>> From: Ewan Hai <ewanhai-oc@zhaoxin.com>
>>> Subject: Re: [PATCH v2 08/10] target/i386/kvm: reset AMD PMU registers
>>>   during VM reset
>>>
>>>>> [2] As mentioned in [1], QEMU always sets the vCPU's vendor to match the host's
>>>>> vendor
>>>>> when acceleration (KVM or HVF) is enabled. Therefore, if users want to emulate a
>>>>> Zhaoxin CPU on an Intel host, the vendor must be set manually.Furthermore,
>>>>> should we display a warning to users who enable both vPMU and KVM acceleration
>>>>> but do not manually set the guest vendor when it differs from the host vendor?
>>>> Maybe not? Sometimes I emulate AMD on Intel host, while vendor is still the
>>>> default :)
>>> Okay, handling this situation can be rather complex, so let's keep it
>>> simple. I have added a dedicated function to capture the intended behavior
>>> for potential future reference.
>>>
>>> Anyway, Thanks for taking Zhaoxin's situation into account, regardless.
>>>
>> Thanks for your code example!!
>>
>> Zhaoxin implements perfmon v2, so I think checking the vendor might be
>> overly complicated. If a check is needed, it seems more reasonable to
>> check the perfmon version rather than the vendor, similar to how avx10
>> version is checked in x86_cpu_filter_features().
>>
>> I understand Ewan's concern is that if an Intel guest requires a higher
>> perfmon version that the Zhaoxin host doesn't support, there could be
>> issues (although I think this situation doesn't currently exist in KVM-QEMU,
>> one reason is QEMU uses the pmu_version in 0xa queried from KVM directly,
>> which means QEMU currently doesn't support custom pmu_version).
> Yeah, that's exactly what I was concerned about.
> Thanks for clearing that up!
>
> perfmon_version is a great idea --- I might add it as a property to the QEMU 
> vCPU template in the future, so it can adjust based on user input and host support.
> Can't promise a timeline yet, but it's definitely something I'll keep in mind.

I'm wondering if there are real user cases that sets a lower PMU version
than host PMU version (live migration on different HW platforms?). In
theory, the higher PMU version should fully back compatible with lower PMU
version, but it's not always true in reality. One example is that the
Anythread bit introduced in v3 is dropped in PMU v5 on Intel processors.
This causes some difficulties to support PMU version 3/4 on host with PMU
version 5+. Different PMU versions between host and guest could cause
similar issues on other platforms.

Currently KVM supported highest PMU version is v2. We plan to support
higher PMU version for Intel processors on top of mediated vPMU. If guest
sets pmu version to 3/4 on host with PMU version 5+, the Anythread bit
would be marked as reserved,


