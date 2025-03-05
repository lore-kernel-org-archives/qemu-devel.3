Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32B17C19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 14:01:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tppIn-0000J7-9z; Wed, 05 Mar 2025 09:00:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tppIj-0000Gg-Cj
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 09:00:46 -0500
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tppIg-0001li-Bo
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 09:00:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741183242; x=1772719242;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=gxIy8ueMCd4X6MIxHjdnqpDtjVZtahN6h+VUJ5acYwU=;
 b=R+CWDIyT6dLpKxCBZmg9eKeA8vkrbOFlAQZQ0bBlYwiGyV3m6qSsgS/T
 xQusawnPEBywfPAGiBYXDxF2S8Vf+53SQx4cqCwyf74LO2Kd5QOoVv2yQ
 evEePp5D2mzzC8rEk5of9cGczCnPsW3qMjl3FZDQ5zMCHUy6ovFx/vcio
 /WxQ6lQ7vlKro0BxDzJ/kiVQpr+RPMosAupP2YC/GyEtoNU9B8p6o1Tli
 HCbGqRmo2BFNGSKFlQyW+1EIljf6hU2AK5NkL+xbOTBL3j3+XNYlelQOV
 l5mLe/RNXDQcz0PXuT7TP82oLpXPIBsNp1JnvDu9ZFJYRhi11xCyWVbkC g==;
X-CSE-ConnectionGUID: WT04MLhkTHOXj0Zk3KQF/A==
X-CSE-MsgGUID: 0wg6eGAfQtaBpZvsCjp01w==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="59558616"
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; d="scan'208";a="59558616"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Mar 2025 06:00:39 -0800
X-CSE-ConnectionGUID: HEE7XtrFQqWU73Ojc81ZOQ==
X-CSE-MsgGUID: YdeBfGBYS0mT90dge/v51g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; d="scan'208";a="118848760"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa008.fm.intel.com with ESMTP; 05 Mar 2025 06:00:34 -0800
Date: Wed, 5 Mar 2025 22:20:42 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, pbonzini@redhat.com,
 mtosatti@redhat.com, sandipan.das@amd.com, babu.moger@amd.com,
 likexu@tencent.com, like.xu.linux@gmail.com,
 zhenyuw@linux.intel.com, groug@kaod.org, khorenko@virtuozzo.com,
 alexander.ivanov@virtuozzo.com, den@virtuozzo.com,
 davydov-max@yandex-team.ru, xiaoyao.li@intel.com,
 dapeng1.mi@linux.intel.com, joe.jin@oracle.com
Subject: Re: [PATCH v2 01/10] target/i386: disable PerfMonV2 when PERFCORE
 unavailable
Message-ID: <Z8hdurk8e0CSB6hP@intel.com>
References: <20250302220112.17653-1-dongli.zhang@oracle.com>
 <20250302220112.17653-2-dongli.zhang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250302220112.17653-2-dongli.zhang@oracle.com>
Received-SPF: pass client-ip=198.175.65.10; envelope-from=zhao1.liu@intel.com;
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

On Sun, Mar 02, 2025 at 02:00:09PM -0800, Dongli Zhang wrote:
> Date: Sun,  2 Mar 2025 14:00:09 -0800
> From: Dongli Zhang <dongli.zhang@oracle.com>
> Subject: [PATCH v2 01/10] target/i386: disable PerfMonV2 when PERFCORE
>  unavailable
> X-Mailer: git-send-email 2.43.5
> 
> When the PERFCORE is disabled with "-cpu host,-perfctr-core", it is
> reflected in in guest dmesg.
> 
> [    0.285136] Performance Events: AMD PMU driver.
> 
> However, the guest CPUID indicates the PerfMonV2 is still available.
> 
> CPU:
>    Extended Performance Monitoring and Debugging (0x80000022):
>       AMD performance monitoring V2         = true
>       AMD LBR V2                            = false
>       AMD LBR stack & PMC freezing          = false
>       number of core perf ctrs              = 0x6 (6)
>       number of LBR stack entries           = 0x0 (0)
>       number of avail Northbridge perf ctrs = 0x0 (0)
>       number of available UMC PMCs          = 0x0 (0)
>       active UMCs bitmask                   = 0x0
> 
> Disable PerfMonV2 in CPUID when PERFCORE is disabled.
> 
> Suggested-by: Zhao Liu <zhao1.liu@intel.com>
> Fixes: 209b0ac12074 ("target/i386: Add PerfMonV2 feature bit")
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> ---
> Changed since v1:
>   - Use feature_dependencies (suggested by Zhao Liu).
> 
>  target/i386/cpu.c | 4 ++++
>  1 file changed, 4 insertions(+)

Thanks!

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


