Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B5A2CCF9F8
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Nov 2025 10:39:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGavI-0002Uu-4Z; Wed, 05 Nov 2025 05:39:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1vGavG-0002Uk-Ul
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 05:39:26 -0500
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1vGavD-00053Z-Rz
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 05:39:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762339163; x=1793875163;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=5085uEIbKIBFCqGBmaKcUQr+3PnBlKPDZ5wQ2+/cins=;
 b=nSmCJXIlib+3z+l1lOwWd1BgyNzH7BeYBnMqmy+7xliRYoBcklCXV1XL
 c3kG/s29Mnqa4UO1e72Bmyski40lVsSdCnxtXu5MvXO9MvNUUul9PdhQs
 DawHGRB/FdhAsgADXuYMSNcezSl7zmgM+mLcFqBRUlRz5wE28vXN3Dbol
 HkktPQRlunXho8B1m1UnotrDin2LiJ9J1ppfJ0clp12DARtRNEu+ZetZu
 +vsxrga1U26Du+0+AUoBCskfg44LGQEHBAdYxKCAy6bw+0IehA7/CVsbb
 flRVm4tZQU0zo2Ag4nRphDD6L5s91RudPnpyFQDmcEQNNKzBPGLKmIM0h Q==;
X-CSE-ConnectionGUID: 4DpYUtFbRwiHHoncQ86g0A==
X-CSE-MsgGUID: HDO6/6P3TT+umG3VU5o/Hw==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="74743335"
X-IronPort-AV: E=Sophos;i="6.19,281,1754982000"; d="scan'208";a="74743335"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2025 02:39:19 -0800
X-CSE-ConnectionGUID: U8PLu0kuQFanWNF3e2W3Dg==
X-CSE-MsgGUID: vR34c48pSOeMKHBOXdJ3Ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,281,1754982000"; d="scan'208";a="187580928"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.49])
 ([10.124.240.49])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2025 02:39:15 -0800
Message-ID: <d3c34223-ab23-488b-8502-c4b5b85047d3@intel.com>
Date: Wed, 5 Nov 2025 18:39:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/20] i386/cpu: Add missing migratable xsave features
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Chao Gao <chao.gao@intel.com>, John Allen <john.allen@amd.com>,
 Babu Moger <babu.moger@amd.com>, Mathias Krause <minipli@grsecurity.net>,
 Dapeng Mi <dapeng1.mi@intel.com>, Zide Chen <zide.chen@intel.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>, Farrah Chen <farrah.chen@intel.com>
References: <20251024065632.1448606-1-zhao1.liu@intel.com>
 <20251024065632.1448606-11-zhao1.liu@intel.com>
 <0dc79cc8-f932-4025-aff3-b1d5b56cb654@intel.com> <aP9HPKwHPcOlBTwm@intel.com>
 <aP9VF7FkfGeY6B+Q@intel.com> <308bcfcd-6c43-4530-8ba7-8a2d8a7b0c8f@intel.com>
 <aQOKw/2lxg/EjyDY@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <aQOKw/2lxg/EjyDY@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.11; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.788,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.773, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
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

On 10/30/2025 11:56 PM, Zhao Liu wrote:
>> can you elaborate what will be broken without the patch?
> 
> Obviously, the migratable_flags has been broken.
> 
>> As I commented earlier, though the .migrable_flags determines the return
>> value of x86_cpu_get_supported_feature_word() for
>> features[FEAT_XSAVE_XCR0_LO] in x86_cpu_expand_features(), eventually the
>> x86_cpu_enable_xsave_components() overwrites features[FEAT_XSAVE_XCR0_LO].
>> So even we set the migratable_flags to 0 for FEAT_XSAVE_XCR0_LO, it doesn't
>> have any issue.
> 
> No. this seemingly 'correct' result what you see is just due to
> different bugs influencing each other: the flags are wrong, the code
> path is wrong, and the impact produced by the flags is also wrong.
> 
>> So I think we can remove migratable_flags totally.
> 
> migratable_flags is used for feature leaves that are non-migratable by
> default, while unmigratable_flags is used for feature leaves that are
> migratable by default. Simply removing it doesn't need much effort, but
> additional clarification is needed - about whether and how it affects
> the migratable/unmigratable feature setting. Therefore, it's better to
> do such refactor in the separate thread rather than combining it with
> CET for now.

I meant we don't need to bother touching .migratable_flags field as this 
patch because it doesn't make any difference to the functionality. Just 
drop it from the series and feel free to clean it up with a separate series.

> Regards,
> Zhao
> 
> 


