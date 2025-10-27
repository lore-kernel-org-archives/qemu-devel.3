Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBDEDCCF9E5
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 12:05:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDLy6-0006CR-3N; Mon, 27 Oct 2025 08:04:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1vDLwT-0005CM-KR
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 08:03:17 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1vDLwN-0000WE-Pn
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 08:03:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761566592; x=1793102592;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=6LCxF2jA+tRNbEsvz636k3v92U5z6MVr9ifOurEWXoI=;
 b=hs00f2LrQUmn8VO8Lxx+R23JoPm9p/iFUO2C8iceHnZ2OtrJT28Km3+a
 dDgnzHQMsDoayEbns06e1CJjm5igDlCnhR+WssE9GiP3lGWtXUCkVccWh
 U14koo2FFgzk925haYALM96vJ2W4okpaDF+7wRG8zAYCBaUgpQBP/ty+O
 fQDu8va3aecteazm94xj7LP3DzkQwmuthQgPEtfyluCRewqDCFlRU5yVH
 lrij07GAdPN6P3IALuszMmgLIlu/YDt4WAfoeTuHerIL2miAe2T7hGRmx
 mG4AyoAWktgCd6igU1WJkzeLJM8LjSUxRLNW33qUkC/ae7mMduGU6fgaX Q==;
X-CSE-ConnectionGUID: Bqn8nqleRES/BqpUBvvwnQ==
X-CSE-MsgGUID: zjEJ1MGOSq2yZphE61vGIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63735562"
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; d="scan'208";a="63735562"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2025 05:03:05 -0700
X-CSE-ConnectionGUID: N+Q9za3bSYybuKHJA7IsZQ==
X-CSE-MsgGUID: 0kPqkZuySniQb1bI7Vwfaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; d="scan'208";a="184648115"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.238.14])
 ([10.124.238.14])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2025 05:03:01 -0700
Message-ID: <308bcfcd-6c43-4530-8ba7-8a2d8a7b0c8f@intel.com>
Date: Mon, 27 Oct 2025 20:02:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/20] i386/cpu: Add missing migratable xsave features
To: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Chao Gao <chao.gao@intel.com>,
 John Allen <john.allen@amd.com>, Babu Moger <babu.moger@amd.com>,
 Mathias Krause <minipli@grsecurity.net>, Dapeng Mi <dapeng1.mi@intel.com>,
 Zide Chen <zide.chen@intel.com>, Chenyi Qiang <chenyi.qiang@intel.com>,
 Farrah Chen <farrah.chen@intel.com>
References: <20251024065632.1448606-1-zhao1.liu@intel.com>
 <20251024065632.1448606-11-zhao1.liu@intel.com>
 <0dc79cc8-f932-4025-aff3-b1d5b56cb654@intel.com> <aP9HPKwHPcOlBTwm@intel.com>
 <aP9VF7FkfGeY6B+Q@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <aP9VF7FkfGeY6B+Q@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.15; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.574, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
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

On 10/27/2025 7:18 PM, Zhao Liu wrote:
> On Mon, Oct 27, 2025 at 06:19:40PM +0800, Zhao Liu wrote:
>> Date: Mon, 27 Oct 2025 18:19:40 +0800
>> From: Zhao Liu <zhao1.liu@intel.com>
>> Subject: Re: [PATCH v3 10/20] i386/cpu: Add missing migratable xsave
>>   features
>>
>>> Though the feature expansion in x86_cpu_expand_features() under
>>>
>>> 	if (xcc->max_features) {
>>> 		...
>>> 	}
>>>
>>> only enables migratable features when cpu->migratable is true,
>>> x86_cpu_enable_xsave_components() overwrite the value later.
>>
>> I have not changed the related logic, and this was intentional...too,
>> which is planed to be cleaned up after CET.
> 
> There's only 1 use case of migratable_flags, so I would try to drop
> it directly.
> 
> The xsave-managed/enabled feature is not suitable as the configurable
> feature. Therefore, it is best to keep it non-configurable as it is
> currently.
> 
> At least with this fix, the support for the new xsave feature —
> including APX next — will not be broken, 

can you elaborate what will be broken without the patch?

As I see, we can drop the .migratable_flags directly.

migrable_flags is only used in x86_cpu_get_migratable_flags(), which is 
only called by x86_cpu_get_supported_feature_word() when passed @cpu is 
not null and cpu->migratable is true. So it only affects the case of

   x86_cpu_expand_features()
     -> x86_cpu_get_supported_feature_word()

And only FEAT_XSAVE_XCR0_LO defines .migratable_flags

As I commented earlier, though the .migrable_flags determines the return 
value of x86_cpu_get_supported_feature_word() for 
features[FEAT_XSAVE_XCR0_LO] in x86_cpu_expand_features(), eventually 
the x86_cpu_enable_xsave_components() overwrites 
features[FEAT_XSAVE_XCR0_LO]. So even we set the migratable_flags to 0 
for FEAT_XSAVE_XCR0_LO, it doesn't have any issue.

So I think we can remove migratable_flags totally.

> and the migratable flag
> refactoring will become a separate RFC.
> 
> Regards,
> Zhao
> 


