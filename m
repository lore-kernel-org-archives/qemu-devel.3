Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A39C7E7718B
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Dec 2024 07:04:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tR4Np-0002lA-RO; Fri, 27 Dec 2024 02:03:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tR4Nn-0002kZ-0D
 for qemu-devel@nongnu.org; Fri, 27 Dec 2024 02:03:39 -0500
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tR4Nj-0003zy-La
 for qemu-devel@nongnu.org; Fri, 27 Dec 2024 02:03:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1735283016; x=1766819016;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=y94nrVnENXUFz2H0OL45bCRJtzZ8rg4Xy2dMJ69WcxQ=;
 b=jO2G0dV5PvVoK149zlCbOWDzzYbi9gCR/ngJtzf3/oxPUj0y39Dwu6rN
 MbgmS4+c2xtYVe2MeW/yNcqDodHSw/Jbu5Ps1M1qCsW0KmXJXJnpMrTUH
 JKzMTmBI+PXdvLXJEc7MCtVdKwYhDwJoAo6TUWRoYIpOzQfTjgYZoJHgd
 E1IgWD7H6Obh6KdR+yNVj7z4uIWCVFwMJ57rE79Av6dnKxDQxusAyrU3j
 FBqf9LKxyGUKslHi7PxYfP8AB2/R7w11cR7T+w6Nz3bX2xy27Y3IV4F+E
 N8ePW0gKYVCGHIvL37GwifwMymQxUjE5c7OAUXmYUsnoXCej/7ooPGTZz w==;
X-CSE-ConnectionGUID: RHqlj4VDSlqtLS+MdhuWDQ==
X-CSE-MsgGUID: 1cvqNDzVTvyqU0DClT1s0g==
X-IronPort-AV: E=McAfee;i="6700,10204,11297"; a="34999420"
X-IronPort-AV: E=Sophos;i="6.12,268,1728975600"; d="scan'208";a="34999420"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Dec 2024 23:03:27 -0800
X-CSE-ConnectionGUID: WoArNZajQNmFvwWGLfeWAw==
X-CSE-MsgGUID: Y9VSf7O+SImMVmg9lEsrDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,268,1728975600"; d="scan'208";a="100214543"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa006.jf.intel.com with ESMTP; 26 Dec 2024 23:03:25 -0800
Date: Fri, 27 Dec 2024 15:22:08 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Yanan Wang <wangyanan55@huawei.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH v2 01/10] i386/cpu: Extract a common fucntion to setup
 value of MSR_CORE_THREAD_COUNT
Message-ID: <Z25VoCfML4/ejV/A@intel.com>
References: <20241219110125.1266461-1-xiaoyao.li@intel.com>
 <20241219110125.1266461-2-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241219110125.1266461-2-xiaoyao.li@intel.com>
Received-SPF: pass client-ip=192.198.163.18; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
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

On Thu, Dec 19, 2024 at 06:01:16AM -0500, Xiaoyao Li wrote:
> Date: Thu, 19 Dec 2024 06:01:16 -0500
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> Subject: [PATCH v2 01/10] i386/cpu: Extract a common fucntion to setup
>  value of MSR_CORE_THREAD_COUNT
> X-Mailer: git-send-email 2.34.1
> 
> There are duplicated code to setup the value of MSR_CORE_THREAD_COUNT.
> Extract a common function for it.
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
> Changes in v2:
> - move the implementation of cpu_x86_get_msr_core_thread_count() to
>   target/i386/cpu-sysemu.c;
> ---
>  target/i386/cpu-sysemu.c             | 11 +++++++++++
>  target/i386/cpu.h                    |  2 ++
>  target/i386/hvf/x86_emu.c            |  3 +--
>  target/i386/kvm/kvm.c                |  5 +----
>  target/i386/tcg/sysemu/misc_helper.c |  3 +--
>  5 files changed, 16 insertions(+), 8 deletions(-)
> 

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


