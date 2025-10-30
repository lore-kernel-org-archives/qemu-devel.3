Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E497CCCF9E3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 15:36:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEUg6-0004iW-4Z; Thu, 30 Oct 2025 11:35:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vEUg3-0004hS-Np
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 11:35:04 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vEUfx-0000Ch-9f
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 11:35:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761838497; x=1793374497;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=pTXcdRYSjHNynWIEVGm+EuBIpQGZF5os4FAc1lkATuA=;
 b=buAvgtkutbw8dYqFerPjKMRluBqAKubNaxmFASdme49LQbgIBTG/7Eco
 jj7uMDlYCjhcWvZaM1W7edl0BfHFAatV3Hr94VX49L74NE4ipPidKlouN
 4RpTZg6HsYHYuVvN50EJ84ysx6fjyKCGXQdfTPd8erlXIeOppWNKVOh6C
 nkEEIsYCq1iGiUOOMF4UB6risrAU6Cs+Sa60T3Fyz3DWUqujnCZglIgnZ
 MxaX+3ePTivdAItpq34h8bZdgqPPgUI9QLs+pPl2f3LD9GZ1zTTvT3ePS
 tDOCZhbb2OZnYMsD2k6TeCv4R8d404SQIE67Ro8A6PnEw+4qvG4ty6rXV A==;
X-CSE-ConnectionGUID: suwFG9TQTUKnBVBXQn/plA==
X-CSE-MsgGUID: fSlUDlz/RwKPERTv/OVsnQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="74661672"
X-IronPort-AV: E=Sophos;i="6.19,267,1754982000"; d="scan'208";a="74661672"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2025 08:34:43 -0700
X-CSE-ConnectionGUID: uzvbaQXaQ6mQTiMiVQeviw==
X-CSE-MsgGUID: ATGxoKK+Rlu5bT0pnZOVBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,267,1754982000"; d="scan'208";a="223203672"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa001.jf.intel.com with ESMTP; 30 Oct 2025 08:34:41 -0700
Date: Thu, 30 Oct 2025 23:56:51 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Chao Gao <chao.gao@intel.com>,
 John Allen <john.allen@amd.com>, Babu Moger <babu.moger@amd.com>,
 Mathias Krause <minipli@grsecurity.net>,
 Dapeng Mi <dapeng1.mi@intel.com>, Zide Chen <zide.chen@intel.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>, Farrah Chen <farrah.chen@intel.com>
Subject: Re: [PATCH v3 10/20] i386/cpu: Add missing migratable xsave features
Message-ID: <aQOKw/2lxg/EjyDY@intel.com>
References: <20251024065632.1448606-1-zhao1.liu@intel.com>
 <20251024065632.1448606-11-zhao1.liu@intel.com>
 <0dc79cc8-f932-4025-aff3-b1d5b56cb654@intel.com>
 <aP9HPKwHPcOlBTwm@intel.com> <aP9VF7FkfGeY6B+Q@intel.com>
 <308bcfcd-6c43-4530-8ba7-8a2d8a7b0c8f@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <308bcfcd-6c43-4530-8ba7-8a2d8a7b0c8f@intel.com>
Received-SPF: pass client-ip=192.198.163.9; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

> can you elaborate what will be broken without the patch?

Obviously, the migratable_flags has been broken.

> As I commented earlier, though the .migrable_flags determines the return
> value of x86_cpu_get_supported_feature_word() for
> features[FEAT_XSAVE_XCR0_LO] in x86_cpu_expand_features(), eventually the
> x86_cpu_enable_xsave_components() overwrites features[FEAT_XSAVE_XCR0_LO].
> So even we set the migratable_flags to 0 for FEAT_XSAVE_XCR0_LO, it doesn't
> have any issue.

No. this seemingly 'correct' result what you see is just due to
different bugs influencing each other: the flags are wrong, the code
path is wrong, and the impact produced by the flags is also wrong.

> So I think we can remove migratable_flags totally.

migratable_flags is used for feature leaves that are non-migratable by
default, while unmigratable_flags is used for feature leaves that are
migratable by default. Simply removing it doesn't need much effort, but
additional clarification is needed - about whether and how it affects
the migratable/unmigratable feature setting. Therefore, it's better to
do such refactor in the separate thread rather than combining it with
CET for now.

Regards,
Zhao



