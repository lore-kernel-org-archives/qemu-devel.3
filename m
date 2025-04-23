Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD2B9C369C2
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 03:05:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7QPg-0002YR-7R; Tue, 22 Apr 2025 23:04:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u7QPe-0002YF-Lc
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 23:04:38 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u7QPb-0004p4-Bk
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 23:04:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1745377475; x=1776913475;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=WTQm2u4iP01bF9Q0+aqoUjJjydCuXyRZ6MzXC/f9H9k=;
 b=KCXjqnRX0ckQFkStEhDBvjlPzH61xm4wxvGIIBn4c+gkx2CXpcwtMXyS
 wN2BXEltZcN+CiOfDLQUxLmgqklCZ2BesohBcYW5eqorJgh01k4ObdQf9
 K+KopwArxtmN/YI1kUryFd92AhUt4wD01buY8MRDJKmRuKbH0BhOA+gjG
 JaqFhmXpPSxgpSceDLqV4o4xhwaZpz9M9JBg7zM0kgZzzXUqA9g8QpMsc
 uB0qnmGDgYgzijivWDQrV89fkOHFePD3khNAuFHF4ynXnNspneOj48c0s
 zWA74slZ2llY7g8eavfqIL9oIspnf7hqTqu9Pt5/F0+AsKRbGzeXu79du w==;
X-CSE-ConnectionGUID: xanQyDsOS9evgyiovB7ypw==
X-CSE-MsgGUID: ipF7CrQXQZSXD+3ltr2q7A==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="64367658"
X-IronPort-AV: E=Sophos;i="6.15,232,1739865600"; d="scan'208";a="64367658"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2025 20:04:32 -0700
X-CSE-ConnectionGUID: NarXM0pITRmgBVABl2lQcw==
X-CSE-MsgGUID: 1yby85Y+QdGLC+kUHAdMfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,232,1739865600"; d="scan'208";a="132720793"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa007.jf.intel.com with ESMTP; 22 Apr 2025 20:04:30 -0700
Date: Wed, 23 Apr 2025 11:25:24 +0800
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
Subject: Re: [PATCH v8 15/55] i386/tdx: Implement user specified tsc frequency
Message-ID: <aAhdpCwCx93NbKrk@intel.com>
References: <20250401130205.2198253-1-xiaoyao.li@intel.com>
 <20250401130205.2198253-16-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401130205.2198253-16-xiaoyao.li@intel.com>
Received-SPF: pass client-ip=198.175.65.10; envelope-from=zhao1.liu@intel.com;
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

On Tue, Apr 01, 2025 at 09:01:25AM -0400, Xiaoyao Li wrote:
> Date: Tue,  1 Apr 2025 09:01:25 -0400
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> Subject: [PATCH v8 15/55] i386/tdx: Implement user specified tsc frequency
> X-Mailer: git-send-email 2.34.1
> 
> Reuse "-cpu,tsc-frequency=" to get user wanted tsc frequency and call VM
> scope VM_SET_TSC_KHZ to set the tsc frequency of TD before KVM_TDX_INIT_VM.
> 
> Besides, sanity check the tsc frequency to be in the legal range and
> legal granularity (required by TDX module).
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Acked-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
> Changes in v3:
> - use @errp to report error info; (Daniel)
> 
> Changes in v1:
> - Use VM scope VM_SET_TSC_KHZ to set the TSC frequency of TD since KVM
>   side drop the @tsc_khz field in struct kvm_tdx_init_vm
> ---
>  target/i386/kvm/kvm.c |  9 +++++++++
>  target/i386/kvm/tdx.c | 25 +++++++++++++++++++++++++
>  2 files changed, 34 insertions(+)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


