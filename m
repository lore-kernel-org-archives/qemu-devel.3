Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCA44C5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 09:04:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjbZ1-0008JP-8E; Mon, 11 Mar 2024 05:03:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rjbYz-0008It-7u
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 05:03:17 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rjbYx-0001RP-0K
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 05:03:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710147795; x=1741683795;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=MvbBDzNtZdKOo0U/flo4h6NM7ejkTqnXNce/6zUN2ag=;
 b=Wte0Y+4SXEHsr66+wo5qBu7H6x81+7QE4RrXYCqEiGTDFotKrWgph9mD
 z9X8Qzy01P/FpeXvaYjrxVTboy90+FIIit4J9UL8/8Takaipo4qdLgHk8
 iq1z+6EtHmoyhFpy489RaykeYHzJPzN06B65q9h6MDY6uhny2IfWUd6LQ
 0kuF5ybvq5eqdodTf5ZQmfWtyB67JS939hwAaDHJ05LjluXi5wUjS/KXC
 J6rJPgwfG7rhLBDAZhKdpnVJTUrOAIrLgv6PgPlNuOva74Lkye38moBjX
 FenZajIlvluvi0JqxACRtOzJsIkR/vykt2evbMg+E4lU61h1Dsi8GZrK7 Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="4721617"
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="4721617"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Mar 2024 02:03:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; d="scan'208";a="42087839"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.125.243.127])
 ([10.125.243.127])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Mar 2024 02:03:05 -0700
Message-ID: <164e9fe1-c89d-4354-a7f7-a565c624934e@intel.com>
Date: Mon, 11 Mar 2024 17:03:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 06/21] i386/cpu: Use APIC ID info to encode cache topo
 in CPUID[4]
Content-Language: en-US
To: Zhao Liu <zhao1.liu@linux.intel.com>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Zhuocheng Ding <zhuocheng.ding@intel.com>, Babu Moger <babu.moger@amd.com>,
 Yongwei Ma <yongwei.ma@intel.com>, Zhao Liu <zhao1.liu@intel.com>,
 Robert Hoo <robert.hu@linux.intel.com>
References: <20240227103231.1556302-1-zhao1.liu@linux.intel.com>
 <20240227103231.1556302-7-zhao1.liu@linux.intel.com>
 <c88ee253-f212-4aa7-9db9-e90a99a9a1e3@intel.com> <Ze23y7UzGxnsyo6O@intel.com>
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <Ze23y7UzGxnsyo6O@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.21; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.945,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 3/10/2024 9:38 PM, Zhao Liu wrote:
> Hi Xiaoyao,
> 
>>>                case 3: /* L3 cache info */
>>> -                die_offset = apicid_die_offset(&topo_info);
>>>                    if (cpu->enable_l3_cache) {
>>> +                    addressable_threads_width = apicid_die_offset(&topo_info);
>>
>> Please get rid of the local variable @addressable_threads_width.
>>
>> It is truly confusing.
> 
> There're several reasons for this:
> 
> 1. This commit is trying to use APIC ID topology layout to decode 2
> cache topology fields in CPUID[4], CPUID.04H:EAX[bits 25:14] and
> CPUID.04H:EAX[bits 31:26]. When there's a addressable_cores_width to map
> to CPUID.04H:EAX[bits 31:26], it's more clear to also map
> CPUID.04H:EAX[bits 25:14] to another variable.

I don't dislike using a variable. I dislike the name of that variable 
since it's misleading

> 2. All these 2 variables are temporary in this commit, and they will be
> replaed by 2 helpers in follow-up cleanup of this series.

you mean patch 20?

I don't see how removing the local variable @addressable_threads_width 
conflicts with patch 20. As a con, it introduces code churn.

> 3. Similarly, to make it easier to clean up later with the helper and
> for more people to review, it's neater to explicitly indicate the
> CPUID.04H:EAX[bits 25:14] with a variable here.

If you do want keeping the variable. Please add a comment above it to 
explain the meaning.

> 4. I call this field as addressable_threads_width since it's "Maximum
> number of addressable IDs for logical processors sharing this cache".
> 
> Its own name is long, but given the length, only individual words could
> be selected as names.
> 
> TBH, "addressable" deserves more emphasis than "sharing". The former
> emphasizes the fact that the number of threads chosen here is based on
> the APIC ID layout and does not necessarily correspond to actual threads.
> 
> Therefore, this variable is needed here.
> 
> Thanks,
> Zhao
> 


