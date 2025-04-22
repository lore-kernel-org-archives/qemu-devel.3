Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10C23C369D7
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 15:24:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7FTZ-0004nQ-8g; Tue, 22 Apr 2025 11:23:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u7FTW-0004mx-MI
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 11:23:54 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u7FTU-0000Tw-QQ
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 11:23:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1745335433; x=1776871433;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=vcD9XM6pIPWcWw3WVTyBu1OKcV7oulRP7epPfihOBs4=;
 b=RiJqc2N4a/i6+vrGF8CdTnX+qJxyrcsQHIxc+CNIZlbJePpSz/NrapMo
 /Pk9myCJ0n/6EMiRlNrXy4RW4OqdCoH8TT4TsoUXD1+eJmeKl9VfOqhkE
 ZMbJwYUxCnGgNpLO+SYG+nDYDYWthPqnFetprLTP0oPHXOo7v7/BADGwb
 qqnkaqMznoDP6IC5e720ntewaZI0leR81j0W0JM3x4AcNyjdY3k8wxbl9
 t7XGVSotN23VQFIWv5ea5Abfh/02tN/IZSwdTKzIGK/2gcdrv0+QEh2fs
 98kO1jsh4sTw9mztBeyNOpR9fIvovAmXiMsK5INKbEgxcZKYDIGWioQS3 g==;
X-CSE-ConnectionGUID: WG47mOrCSneiZ6YNEBPohQ==
X-CSE-MsgGUID: 9jQY/Ga5S7Ss6r5F6Xf0+A==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="49563220"
X-IronPort-AV: E=Sophos;i="6.15,231,1739865600"; d="scan'208";a="49563220"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2025 08:23:49 -0700
X-CSE-ConnectionGUID: FdYEQUCpQCSeIzk8eTLqAA==
X-CSE-MsgGUID: eSOiVsngRyWYu+dgaC2uLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,231,1739865600"; d="scan'208";a="163095463"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa001.fm.intel.com with ESMTP; 22 Apr 2025 08:23:46 -0700
Date: Tue, 22 Apr 2025 23:44:41 +0800
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
Subject: Re: [PATCH v8 14/55] i386/tdx: Set APIC bus rate to match with what
 TDX module enforces
Message-ID: <aAe5aQ1C8+jzMtr7@intel.com>
References: <20250401130205.2198253-1-xiaoyao.li@intel.com>
 <20250401130205.2198253-15-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401130205.2198253-15-xiaoyao.li@intel.com>
Received-SPF: pass client-ip=192.198.163.13; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.411,
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

On Tue, Apr 01, 2025 at 09:01:24AM -0400, Xiaoyao Li wrote:
> Date: Tue,  1 Apr 2025 09:01:24 -0400
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> Subject: [PATCH v8 14/55] i386/tdx: Set APIC bus rate to match with what
>  TDX module enforces
> X-Mailer: git-send-email 2.34.1
> 
> TDX advertises core crystal clock with cpuid[0x15] as 25MHz for TD
> guests and it's unchangeable from VMM. As a result, TDX guest reads
> the APIC timer as the same frequency, 25MHz.
> 
> While KVM's default emulated frequency for APIC bus is 1GHz, set the
> APIC bus rate to match with TDX explicitly to ensure KVM provide correct
> emulated APIC timer for TD guest.
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
> Changes in v6:
>  - new patch;
> ---
>  target/i386/kvm/tdx.c | 13 +++++++++++++
>  target/i386/kvm/tdx.h |  3 +++
>  2 files changed, 16 insertions(+)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


