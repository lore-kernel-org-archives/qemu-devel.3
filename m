Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BAB2C83F22
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 02:45:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucEcL-0004gw-CI; Wed, 16 Jul 2025 22:45:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ucEcG-0004XD-BZ; Wed, 16 Jul 2025 22:45:00 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ucEcE-0000px-NJ; Wed, 16 Jul 2025 22:45:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752720298; x=1784256298;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=JG+43YE4q0pQg1zZzquBVVhadgET8E1jT/8t/kAfX2Y=;
 b=VHsVTrbYO0yABpS2akSIuutPjtq0z3eL2i7aRlU99INbwwMoh/EZcapJ
 9RQpOe1YYwKGQQmCOLQjJOyUZ5VmogDGPd25e/5W1DpAOCyB0NeJ812un
 PjOMEFFsayXfkfYc0EWViW8yVLeV8hKSR2eEGa2JOeRdLgL2g5O/OxjzZ
 BekeiWPE8sZpbQ7FgA7DAvqvQCqnSqFZc3tJbUk8OVoDmNKfHXxVNeli2
 In3HyHWvOBkvm7q03rmusQuYLOubIlk8XpHlLFvFCg5PrIIdRBTFofrAN
 JjRUQ/2xXXl4rOWt3ItO4sn+AFyFpldlVEmbCeSN0Oh0Y1lJoyeYIbhpP Q==;
X-CSE-ConnectionGUID: E353v+uVSA+CMcO3XmSx6w==
X-CSE-MsgGUID: 8w/vxxyjT5eBVyCuqkaFXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="54954685"
X-IronPort-AV: E=Sophos;i="6.16,317,1744095600"; d="scan'208";a="54954685"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2025 19:44:56 -0700
X-CSE-ConnectionGUID: VEKx6418RLmIcjSZiQhEsA==
X-CSE-MsgGUID: d0MZqC+7TLKB6cAInpcm1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,317,1744095600"; d="scan'208";a="158020076"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa009.fm.intel.com with ESMTP; 16 Jul 2025 19:44:53 -0700
Date: Thu, 17 Jul 2025 11:06:24 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ewan Hai <ewanhai-oc@zhaoxin.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Tao Su <tao1.su@intel.com>,
 Yi Lai <yi1.lai@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>,
 qemu-devel@nongnu.org, Chuang Xu <xuchuangxclwt@bytedance.com>,
 Guixiong Wei <weiguixiong@bytedance.com>,
 Yipeng Yin <yinyipeng@bytedance.com>, qemu-stable <qemu-stable@nongnu.org>
Subject: Re: [PATCH v2 4/7] i386/cpu: Fix number of addressable IDs field for
 CPUID.01H.EBX[23:16]
Message-ID: <aHhosJ/VWEyjwQDc@intel.com>
References: <20250714080859.1960104-1-zhao1.liu@intel.com>
 <20250714080859.1960104-5-zhao1.liu@intel.com>
 <33497cb5-037b-4656-bd8d-6310c7c03e65@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33497cb5-037b-4656-bd8d-6310c7c03e65@tls.msk.ru>
Received-SPF: pass client-ip=198.175.65.17; envelope-from=zhao1.liu@intel.com;
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

> Hi!
> 
> Previous incarnation of this patch were Cc'd qemu-stable@, as it were
> supposed to be picked up for the stable qemu series.  However, this
> incarnation is not Cc'd to stable, and, most importantly, it relies
> on a feature which was introduced after all released qemu versions.
> Namely, vendor_cpuid_only_v2 is past v10.0.0, which is commit
> 216d9bb6d7716 "i386/cpu: Add x-vendor-cpuid-only-v2 option for
> compatibility".
> 
> Should I omit this change for stable-10.0 series, or should it be
> modified to work in 10.0?

Hi Michael, considerring current fix is covered by compat option,
it's not fit to be backported to the previous version.

This issue has existed for a very long time, and the feedback received
on this is currently one case and it based on a specific topology
configuration, so the impact is limited. Therefore, in this patch
version, I fixed it with the newly added compat option, which also
avoids the controversy about the impact of migration.

So I think you could omit this change for stable-10.0 series, if it's
also okay with Paolo.

Thanks,
Zhao


