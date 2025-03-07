Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90B85C19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 08:41:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqTGD-0002t6-TP; Fri, 07 Mar 2025 03:40:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tqTGC-0002sj-Ic
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 03:40:48 -0500
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tqTG9-0005ot-Qf
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 03:40:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741336846; x=1772872846;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=HSEx1h7Wj2hEuSbAVMCuuoZ/xzSn15mJMjAE6PL4bZ4=;
 b=Kh+8iiAfYg5BrCGAvbNc4gsjjCqtYai7k5Z+N7IBE73/7xUJWuthmU92
 of49MPrqSvUEtRdpJkjuUeL9rRI1wlqT6yyHUB/ZkBwXLnPAGhOAe9xi9
 LvGr544L16X5QiUF2fjAu/j9+4MpUzNyqnExZzQ2KxsbMG+sR8Lmj9DQS
 QDLL5fMOeHArTs2dVPdVBSTRV6AisTNepMyAZ342D/U9yqmCoRnTQ9uWK
 B6dQdV86zJD9hZax8OsbmZBcFap3NhMPS8okJQBtc9nmVijmg/imtMnYs
 pUctNm8shVQxyAl3CzGDKAazaCBvukviFKCpTGThU/pR5WrdfytMrnJBC A==;
X-CSE-ConnectionGUID: /fQYdEWIS32AgHEaV8xtIg==
X-CSE-MsgGUID: l0ax0OeuQhiPgAB1czuDyg==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="46306007"
X-IronPort-AV: E=Sophos;i="6.14,228,1736841600"; d="scan'208";a="46306007"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Mar 2025 00:40:42 -0800
X-CSE-ConnectionGUID: MQYHKvbeSKWtjt9XPsXJGA==
X-CSE-MsgGUID: n3gH5xQhR5ChX39nvWcjmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="150217523"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Mar 2025 00:40:38 -0800
Message-ID: <01e203cf-6bed-4939-8881-7fb552daadd7@intel.com>
Date: Fri, 7 Mar 2025 16:40:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/10] [DO NOT MERGE] kvm: Introduce
 kvm_arch_pre_create_vcpu()
To: Zhao Liu <zhao1.liu@intel.com>, dongli.zhang@oracle.com
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, pbonzini@redhat.com,
 mtosatti@redhat.com, sandipan.das@amd.com, babu.moger@amd.com,
 likexu@tencent.com, like.xu.linux@gmail.com, zhenyuw@linux.intel.com,
 groug@kaod.org, khorenko@virtuozzo.com, alexander.ivanov@virtuozzo.com,
 den@virtuozzo.com, davydov-max@yandex-team.ru, dapeng1.mi@linux.intel.com,
 joe.jin@oracle.com
References: <20250302220112.17653-1-dongli.zhang@oracle.com>
 <20250302220112.17653-4-dongli.zhang@oracle.com> <Z8hjy/8OBTXEA1kp@intel.com>
 <acef41fc-9eb1-4df7-b7b6-61995a76fcc4@oracle.com>
 <Z8qlrjciHEbdnqaA@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <Z8qlrjciHEbdnqaA@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.12; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.998, RCVD_IN_DNSWL_MED=-2.3,
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

On 3/7/2025 3:52 PM, Zhao Liu wrote:
>> I didn't know if I would need to wait until this patch is merged into
>> mainline QEMU. That's why I didn't add my signed-off.
> 
> No problem if Xiaoyao is okay with it (copyright of patches need to
> honor the original author & signed-off). IMO, if your series is accepted
> first, it also helps to reduce the size of the TDX series, and it helps
> the subsequent PMU development (like mediated PMU). Conversely, it's
> also not a big deal; you can simply rebase and remove this patch at that
> time.

Hi Dongli,

Usually, if my TDX series is going to be merged soon, or you think this 
series won't be accepted soon before TDX series, you can just mention in 
the cover letter that this series has a dependency on other patch.

For the case that your series might be accepted earlier, it's better to 
just grab the patches needed by this series from others' series. Just 
like what you did here.

Like Zhao mentioned, when you grab a patch from others and post with 
your series, you need keep the original patch as is (the unchanged 
authorship and signed-off-by chain), in addition to add your 
signed-off-by at last in the chain.

> Even I'm thinking that my KVM PMU filter should perhaps base on your work.
> 
>> I will add in v3 and remove "DO NOT MERGE" if the patch isn't in QEMU when
>> I am sending out v3.

Be sure to add your signed-off-by, which tells you are involved.

> Okay.
> 
> Thanks,
> Zhao
> 


