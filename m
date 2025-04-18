Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 095DBC369AB
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 09:03:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5hcX-0001ph-Ax; Fri, 18 Apr 2025 05:02:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u5hcT-0001pL-TH
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 05:02:45 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u5hcQ-00031l-N8
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 05:02:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744966963; x=1776502963;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=LTvbBX6z+k5xUwIyYfW5C1C3FI5SxUIhTKF2ln3y1hA=;
 b=Kc6ABMgp+Y2wuUWfl5IzF/O7le2vFESkj7aH0yvtUa00Ti9JHr4TECXF
 tY4FR36DihZtPjrQ4LHxfXoIRyV4JLSew04ZjKLKIbVvUut9VM62Ct3K0
 haoxA2Oo31VGkd9A/bs+UK2IAcIG3AVICpJGfqjyOTD8NsJFI1rQq6f+x
 1Sr4GfsuWaCaw0bdcXpavHD9CSWxVHwhYvPbFMeHW01AMD5JycoJWw8Ee
 B4O3NZWc01xlvHX6HKUQn9YhsRcVgg/eEULfG6JjLJguCKe2tjFNYCyU4
 RJA+rDLap3x55omZh5mShW3q/Ntox1fC0fo2rIB4MdCm3Ehe90x8Wybr1 A==;
X-CSE-ConnectionGUID: 8+cyXjXVTgOF/Aj53CDWWA==
X-CSE-MsgGUID: 5s1AR4LFT6GtLXFyJPUYPQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11406"; a="69087986"
X-IronPort-AV: E=Sophos;i="6.15,221,1739865600"; d="scan'208";a="69087986"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Apr 2025 02:02:41 -0700
X-CSE-ConnectionGUID: MJeqn92BT9GbiEP2dCBvJA==
X-CSE-MsgGUID: j/ctejokQ4Cu1P4RCX6SjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,221,1739865600"; d="scan'208";a="131021578"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa010.jf.intel.com with ESMTP; 18 Apr 2025 02:02:38 -0700
Date: Fri, 18 Apr 2025 17:23:31 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Francesco Lavra <francescolavra.fl@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: Re: [PATCH v8 03/55] i386/tdx: Implement tdx_kvm_type() for TDX
Message-ID: <aAIaE7RAW3bgPaHY@intel.com>
References: <20250401130205.2198253-1-xiaoyao.li@intel.com>
 <20250401130205.2198253-4-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401130205.2198253-4-xiaoyao.li@intel.com>
Received-SPF: pass client-ip=198.175.65.9; envelope-from=zhao1.liu@intel.com;
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

On Tue, Apr 01, 2025 at 09:01:13AM -0400, Xiaoyao Li wrote:
> Date: Tue,  1 Apr 2025 09:01:13 -0400
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> Subject: [PATCH v8 03/55] i386/tdx: Implement tdx_kvm_type() for TDX
> X-Mailer: git-send-email 2.34.1
> 
> TDX VM requires VM type to be KVM_X86_TDX_VM. Implement tdx_kvm_type()
> as X86ConfidentialGuestClass->kvm_type.
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
> Changes in v6:
>  - new added patch;
> ---
>  target/i386/kvm/kvm.c |  1 +
>  target/i386/kvm/tdx.c | 12 ++++++++++++
>  2 files changed, 13 insertions(+)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


