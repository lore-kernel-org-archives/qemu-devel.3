Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7B2FC28B25
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 16:10:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqDgy-0003ut-Fi; Thu, 06 Mar 2025 11:03:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tqDgW-0003D2-Gd
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 11:02:57 -0500
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tqDgU-0007ro-86
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 11:02:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741276974; x=1772812974;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=tFAUos7YRNSU2MirkPiVo9raKTjzn98Zr1WYKgiI16Y=;
 b=B2XPloeZBIqjzbrS/tFQronZmv2waVVx9qBDFgxufkBLFCX7EeRpVs3F
 UMZvZSvt7UdzkLW8tMtMd4Yee5NRwOxV0bkBAVInsAJ36DYmre+H4KHcu
 9QkzYxehmTe9wNu60NMQO3x+eNtyqSycZrYrsmFL8rT4IPuDBQLDwtmTW
 sv1NUUkf+CzN8awhKHXYNWp6QUxkRH33CHciKcYwzzy3IjiUAUTwmAJM5
 LYBzFnFDshzVAwaLrvg9+LGa1yaLF+yWhIUFvYgksTDdb4MSyrS4vxMUE
 R+D2dvI3++Zji/GTz853XLm0/pVt/z5J49bcqjVuDj5F0JuvXg7c1XsOp A==;
X-CSE-ConnectionGUID: I0sX/Sq4Rxip5NcRS0/7DQ==
X-CSE-MsgGUID: e+/GixYLSVmpnoLItMX5tw==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="41546422"
X-IronPort-AV: E=Sophos;i="6.14,226,1736841600"; d="scan'208";a="41546422"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Mar 2025 08:02:34 -0800
X-CSE-ConnectionGUID: tBOxjrUnTNWjU1RFgus0ZA==
X-CSE-MsgGUID: bXpeDC06QpWMOAU6Yb3LvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="124275590"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa005.jf.intel.com with ESMTP; 06 Mar 2025 08:02:33 -0800
Date: Fri, 7 Mar 2025 00:22:41 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Dongli Zhang <dongli.zhang@oracle.com>
Subject: Re: [PATCH 0/2] i386: Adjust CPUID_EXT_PDCM based on enable_pmu at
 realization
Message-ID: <Z8nL0eLE/trEtlNd@intel.com>
References: <20250304052450.465445-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304052450.465445-1-xiaoyao.li@intel.com>
Received-SPF: pass client-ip=192.198.163.18; envelope-from=zhao1.liu@intel.com;
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

Hi Xiaoyao,

> First, it's not a good practice that values in env->features[] cannot be
> directly used for guest CPUID in void cpu_x86_cpuid(), but require further
> adjustment there. env->features[] are supposed to be finalized at cpu
> realization, so that after it env->features[] is reliable.
> 
> Second, there is one dependency entry relates to CPUID_EXT_PDCM in
> feature_dependencies[]. QEMU needs to get correct value of
> CPUID_EXT_PDCM in env->features[] to ensure applying the dependencies
> correctly.

I agree that this is a very good idea, especially since PDCM has a
dependency entry.

"pmu" is totally a property rather than a feature bit, which makes the
dependency relationships in the code complex. Therefore, I think it's
worth having a series to clarify the dependencies of pmu as much as
possible.

I remember Dapeng/Zide also have fixes for pmu dependencies, and if
possible, I could help you combine this series with others' cleanups.

Additionally, I think patch 1 and patch 2 can be merged together. Do you
agree?

Thanks,
Zhao


