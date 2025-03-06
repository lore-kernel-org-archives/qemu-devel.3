Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83729C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 15:33:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqDDP-0000H6-O2; Thu, 06 Mar 2025 10:32:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tqDCo-00007k-Kx
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:32:20 -0500
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tqDCl-00046A-AO
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:32:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741275131; x=1772811131;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=zRp/7uMnJT5vLMmnXR+37wi6QWu/dy1lzTsljPFz+gk=;
 b=ibk1040pxdFULljWfrF1BLEwanVdIgFV4jKbgaknNF8T0q+RR2r1+tjV
 G+c4bSYe0GDazVU4M8dcV7npEDKi7/rgLJYnpvBQ9OAJSXc9CcyJiTruT
 yQoYdkLp+d+EpvGnZaTvLRLZ9lAJgWN7yUT6C4X9RW55kF43CbrAOxRC+
 jyUz8mgwVJvCwsGZtEG/fMF3Aay+RjX8BvjxO09bWj3477EDQGFacdjbX
 xPumYzeB25eicDZtDILjdkBsNpwamgNwy1Xmxk4855u3Bp5NrnVm9Kp80
 o9/iVnE9oPOC6tabiKbEBUvbSJeNZnZbMxt1Tu/NCOw0TDtW3OlVdScNQ Q==;
X-CSE-ConnectionGUID: CuCkTzdNTHGrIESQcgp/Lw==
X-CSE-MsgGUID: Dl8yU6IBRl2f0zzyocVPww==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="53694682"
X-IronPort-AV: E=Sophos;i="6.14,226,1736841600"; d="scan'208";a="53694682"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Mar 2025 07:32:08 -0800
X-CSE-ConnectionGUID: D4BGUIZdTFyk5FNU0QE61Q==
X-CSE-MsgGUID: 7szPwbsuR8GIngmAifx79Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,226,1736841600"; d="scan'208";a="124069539"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa004.jf.intel.com with ESMTP; 06 Mar 2025 07:32:07 -0800
Date: Thu, 6 Mar 2025 23:52:15 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Dongli Zhang <dongli.zhang@oracle.com>
Subject: Re: [PATCH 1/2] i386/cpu: Move adjustment of CPUID_EXT_PDCM before
 feature_dependencies[] check
Message-ID: <Z8nEr2tQ9PWd9sEC@intel.com>
References: <20250304052450.465445-1-xiaoyao.li@intel.com>
 <20250304052450.465445-2-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304052450.465445-2-xiaoyao.li@intel.com>
Received-SPF: pass client-ip=192.198.163.10; envelope-from=zhao1.liu@intel.com;
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

On Tue, Mar 04, 2025 at 12:24:49AM -0500, Xiaoyao Li wrote:
> Date: Tue, 4 Mar 2025 00:24:49 -0500
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> Subject: [PATCH 1/2] i386/cpu: Move adjustment of CPUID_EXT_PDCM before
>  feature_dependencies[] check
> X-Mailer: git-send-email 2.34.1
> 
> There is one entry relates to CPUID_EXT_PDCM in feature_dependencies[].
> So it needs to get correct value of CPUID_EXT_PDCM before using
> feature_dependencies[] to apply dependencies.
> 
> Besides, it also ensures CPUID_EXT_PDCM value is tracked in
> env->features[FEAT_1_ECX].
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
>  target/i386/cpu.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


