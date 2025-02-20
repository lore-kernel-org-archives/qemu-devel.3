Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D5EDC021B1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 11:41:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl4vF-0006XJ-Pc; Thu, 20 Feb 2025 06:40:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tl4vD-0006X5-Jo
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 06:40:51 -0500
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tl4vB-0001Lx-Gf
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 06:40:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740051650; x=1771587650;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=wvVYXdb28yocyBnfn+6sHaNU/1L9E6JEziRM+W82XE0=;
 b=YowDV2d36DnSr1NwKkvIZh+Mqa3DIGcct16qQ0tQF9QtgsCdYJSAxyyZ
 agCqnTmuXXfhVPMj3L3+BflzAdAYLoutbWlEdgWky480opgXzlUV5voUe
 thAO+fmtkVCGv3LqcLa5zRbySYZov5q2qhNpn1IG9fZhhE3UIqWjpgOp2
 dXeKJjI0gQSin2QxC6amwi3ZXAKxdX+BjAwbQfzAI8aWE6hG5DvroGYLY
 RsbRENc6hRJuE3fZiJ7Nf5+lvWNF5W/waRrAHXoHY4V6l7kPiPqkN0WVa
 z1IJMuCdw8YxHOuo0FRab+nqF7AhPNp4ycehnX7vVWRh4Y9Nw48Rqs+aF A==;
X-CSE-ConnectionGUID: at9IiXWfTpK9ceNXjHIgMQ==
X-CSE-MsgGUID: kr2UtbpASxSIT856sfiiuA==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="40946500"
X-IronPort-AV: E=Sophos;i="6.13,301,1732608000"; d="scan'208";a="40946500"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Feb 2025 03:40:46 -0800
X-CSE-ConnectionGUID: 6Q9c9oxBQtmES3qrPPeglA==
X-CSE-MsgGUID: TUTSnQ/5T5iVTVK5IwvYwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="115507424"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa007.jf.intel.com with ESMTP; 20 Feb 2025 03:40:45 -0800
Date: Thu, 20 Feb 2025 20:00:20 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Babu Moger <babu.moger@amd.com>
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org,
 davydov-max@yandex-team.ru
Subject: Re: [PATCH v5 4/6] target/i386: Add feature that indicates WRMSR to
 BASE reg is non-serializing
Message-ID: <Z7cZVNsZ/PCXA1+7@intel.com>
References: <cover.1738869208.git.babu.moger@amd.com>
 <ad5bf4dde8ab637e9c5c24d7391ad36c7aafd8b7.1738869208.git.babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad5bf4dde8ab637e9c5c24d7391ad36c7aafd8b7.1738869208.git.babu.moger@amd.com>
Received-SPF: pass client-ip=198.175.65.16; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.457,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Thu, Feb 06, 2025 at 01:28:37PM -0600, Babu Moger wrote:
> Date: Thu, 6 Feb 2025 13:28:37 -0600
> From: Babu Moger <babu.moger@amd.com>
> Subject: [PATCH v5 4/6] target/i386: Add feature that indicates WRMSR to
>  BASE reg is non-serializing
> X-Mailer: git-send-email 2.34.1
> 
> Add the CPUID bit indicates that a WRMSR to MSR_FS_BASE, MSR_GS_BASE, or
> MSR_KERNEL_GS_BASE is non-serializing.
> 
> CPUID_Fn80000021_EAX
> Bit    Feature description
> 1      FsGsKernelGsBaseNonSerializing.
>        WRMSR to FS_BASE, GS_BASE and KernelGSbase are non-serializing.
> 
> Link: https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/programmer-references/57238.zip
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> Reviewed-by: Maksim Davydov <davydov-max@yandex-team.ru>
> ---
>  target/i386/cpu.c | 2 +-
>  target/i386/cpu.h | 2 ++
>  2 files changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


