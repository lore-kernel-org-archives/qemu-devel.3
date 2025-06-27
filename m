Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53087C77B7F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Jun 2025 08:23:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uV4MV-000810-Ut; Fri, 27 Jun 2025 04:23:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uV4MI-0007zu-61
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 04:22:56 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uV4MA-0001Q1-1F
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 04:22:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751012566; x=1782548566;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Kbz47DuMnWT0v9tfwC0nho0rIfl4eEfmfBomwBJYoKA=;
 b=A12aqH3w0LjcFncnNOlTSybDsEzzDYMQhrXX9IJcel9J647K7LiOD/yk
 QLyS5xvT5dn4NTFa+t62odb1Pgekeki1AKQheeLAxLcNK42/+PIuIYmDf
 BHmsv8KyqV33L2CnjtXy0l5Ur9Yty4QIn4l5nFp83ej5mRTILjdxU47ri
 VDFFyutEPnlxWtVpvcZ40PQT3A0UuzgpSfL0bnQ2aNTKRIFJquyFy2ssY
 wzvsk3SYLAJ58bfdE3bJjPfyMWtGHlPwjons+6KL+5eQsiwgRlwGnjJ2+
 wyXjLjSeZc394ZZSn+PrjJSKTSAvnn4eLT5w+cWnWgRRtgWQGcLkkU051 w==;
X-CSE-ConnectionGUID: U81rmcAcQy2wNA0JwEnuAA==
X-CSE-MsgGUID: V438YjZQQcWjy96D8AgMaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11476"; a="57000815"
X-IronPort-AV: E=Sophos;i="6.16,270,1744095600"; d="scan'208";a="57000815"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jun 2025 01:22:43 -0700
X-CSE-ConnectionGUID: Yy3HybgzQI6OBoEZwlTfXg==
X-CSE-MsgGUID: mlLRaNBtSFOc+PXLlxDLmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,270,1744095600"; d="scan'208";a="153456758"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa010.fm.intel.com with ESMTP; 27 Jun 2025 01:22:41 -0700
Date: Fri, 27 Jun 2025 16:44:03 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] i386/tdx: Don't mask off CPUID_EXT_PDCM
Message-ID: <aF5Z02o1BFDZSqLS@intel.com>
References: <20250625035710.2770679-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625035710.2770679-1-xiaoyao.li@intel.com>
Received-SPF: pass client-ip=198.175.65.15; envelope-from=zhao1.liu@intel.com;
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

On Wed, Jun 25, 2025 at 11:57:10AM +0800, Xiaoyao Li wrote:
> Date: Wed, 25 Jun 2025 11:57:10 +0800
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> Subject: [PATCH] i386/tdx: Don't mask off CPUID_EXT_PDCM
> X-Mailer: git-send-email 2.43.0
> 
> It gets below warning when booting TDX VMs:
> 
>   warning: TDX forcibly sets the feature: CPUID[eax=01h].ECX.pdcm [bit 15]
> 
> Because CPUID_EXT_PDCM is fixed1 for TDX, and MSR_IA32_PERF_CAPABILITIES is
> supported for TDX guest unconditioanlly.
> 
> Don't mask off CPUID_EXT_PDCM for TDX.
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
>  target/i386/cpu.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


