Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E79A1CD8CAA
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 13:42:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWwhr-000250-NJ; Tue, 09 Jun 2026 09:41:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1wWwhp-00024R-Ti; Tue, 09 Jun 2026 09:41:25 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1wWwhn-0004U4-Ez; Tue, 09 Jun 2026 09:41:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781012483; x=1812548483;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=0/cb6X+3/7WDEPBMpZS9PoJb9fPynqblASk+IpgSwBA=;
 b=h5SzogQ+qb4e3o1McZqKdnOJzPSuEkrmSnfxCDMy2uAbC/WOFZUzkSBD
 fAU7HuHMt+6RtnJKDcHSRJQhdlTu76+EBNSiciPTDh0CgrTOb1iof3ieG
 7E0FPScY14vZHTZyon8drTYIG6+9KZWw4yqZPdGA+l5d//inOdDpY9jZc
 QIvmAJXd0ZOI1js2oZCkNNPWKdDwYXCzTmRB4ysbhmqGmIDSo8rP3d+QL
 nD21DpgDRvvYoI5bExDem4cF4hVYgzCeJ70yifAdImODr4Gl3mvBcqVzO
 AHd1cpvAdVWWjB2CenL/7je53Cv/8Oz2b8I4FiMbksaO7W8v1j2Z4QDFw Q==;
X-CSE-ConnectionGUID: nRFf6ejGQD2GNNuAysUWxQ==
X-CSE-MsgGUID: HUArv9P3Tk6IVWmlZPA3sg==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="69305660"
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; d="scan'208";a="69305660"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2026 06:41:19 -0700
X-CSE-ConnectionGUID: dI1afqVvRE2u2hWhsADygg==
X-CSE-MsgGUID: 3S6CJqNqTUKf+M/aa9Mvvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; d="scan'208";a="239527819"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa009.fm.intel.com with ESMTP; 09 Jun 2026 06:41:16 -0700
Date: Tue, 9 Jun 2026 22:09:23 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, pbonzini@redhat.com,
 mtosatti@redhat.com, dapeng1.mi@linux.intel.com,
 sandipan.das@amd.com, zide.chen@intel.com, joe.jin@oracle.com,
 qemu-stable@nongnu.org
Subject: Re: [PATCH 1/1] target/i386/kvm: Use logical counter index for AMD
 PMU getter
Message-ID: <aigek5eqJr6DHZau@intel.com>
References: <20260325021236.14574-1-dongli.zhang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325021236.14574-1-dongli.zhang@oracle.com>
Received-SPF: pass client-ip=192.198.163.16; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Cc: qemu-stable@nongnu.org

On Tue, Mar 24, 2026 at 07:12:36PM -0700, Dongli Zhang wrote:
> Date: Tue, 24 Mar 2026 19:12:36 -0700
> From: Dongli Zhang <dongli.zhang@oracle.com>
> Subject: [PATCH 1/1] target/i386/kvm: Use logical counter index for AMD PMU
>  getter
> X-Mailer: git-send-email 2.43.5
> 
> For Intel PMU, the counter and selector MSR ranges are disjoint. AMD PMU
> behaves the same way when PerfCore is unavailable.
> 
> However, once PerfCore is present, AMD PMU switches to an interleaved
> layout in which selector and counter MSRs share a single alternating range.
> 
> MSR_F15H_PERF_CTL0 = 0xc0010200
> MSR_F15H_PERF_CTR0 = 0xc0010201
> ... ...
> ... ...
> MSR_F15H_PERF_CTL5 = 0xc001020a
> MSR_F15H_PERF_CTR5 = 0xc001020b
> 
> The commit 4c7f05232c ("target/i386/kvm: reset AMD PMU registers during VM
> reset") added the getter/putter pair for AMD PMU MSRs to clear them on
> reset, but it ignored that, without PerfCore, AMD reuses alternating MSR
> addresses for selectors and counters. env->msr_gp_counters[] holds the raw
> counts and env->msr_gp_evtsel[] holds the selectors, so with the
> interleaved layout we must translate the MSR address back to the logical
> counter index instead of treating the interleaved slot as the array index.
> 
> The arrays are sized to MAX_GP_COUNTERS = 18, so the code never writes past
> the end. And in the reset path QEMU simply zeroes everything, so that use
> case still works.
> 
> However, the live migration is broken. The PMU state is stored at the
> wrong indices, so the destination VM reloads mismatched selector/counter
> pairs. Fix the getter to use the logical counter index rather than the raw
> interleaved offset.
> 
> Fixes: 4c7f05232c ("target/i386/kvm: reset AMD PMU registers during VM reset")
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> ---
>  target/i386/kvm/kvm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Sorry for late response, LGTM,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>



