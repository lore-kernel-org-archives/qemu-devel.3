Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 984C2C369AB
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 09:12:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5hkt-0006kr-65; Fri, 18 Apr 2025 05:11:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u5hkr-0006kh-Vf
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 05:11:26 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u5hkp-0004xn-0E
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 05:11:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744967483; x=1776503483;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=ZKmxl0BpbBGg7r13V5PwyimvTeJhvEUNuT8F7RPW/wk=;
 b=XdFYWaQUqlSLi9laQ3FIKJcsKdEC1emYsEOtya5U22MU7sZf/f0cmoKX
 +V5gfObUcN5aLZE9Nq8hvuylkgIYse9KxvSTtbPyRoN803LxXH0vlCMEy
 QqhbSVhr6vKWmhqXDAAroe7zssD7+0fmiqznXQxjlctg28aaAanGXT6eF
 PK4mEdv1x4Ad/6IwCbyPqtODomnEvfgoHxYAi1F1RCDbAHI0qWhgJngCA
 XEV6sbO0fap8HJ81cihI3/RLm3jsVABC4xonltZ0aqwTSZN8tA+/s0Ml5
 l90qfk7hsanduOAJidnuCh79YnILZ0ljwNpeQ8ajan8REMdQTZ9ThWjeU Q==;
X-CSE-ConnectionGUID: gx+E/MCLTFajxcQckprurw==
X-CSE-MsgGUID: gdEC0uy3QweozVtLnmQ0CQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11406"; a="46511322"
X-IronPort-AV: E=Sophos;i="6.15,221,1739865600"; d="scan'208";a="46511322"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Apr 2025 02:11:20 -0700
X-CSE-ConnectionGUID: 6nJuRxz2RI2Z9vrN/wZ3vA==
X-CSE-MsgGUID: /Azhy+4MSrCDG8FBzvLaMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,221,1739865600"; d="scan'208";a="135169633"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa003.fm.intel.com with ESMTP; 18 Apr 2025 02:11:17 -0700
Date: Fri, 18 Apr 2025 17:32:10 +0800
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
Subject: Re: [PATCH v8 04/55] i386/tdx: Implement tdx_kvm_init() to
 initialize TDX VM context
Message-ID: <aAIcGkLaChSMqEeF@intel.com>
References: <20250401130205.2198253-1-xiaoyao.li@intel.com>
 <20250401130205.2198253-5-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401130205.2198253-5-xiaoyao.li@intel.com>
Received-SPF: pass client-ip=198.175.65.21; envelope-from=zhao1.liu@intel.com;
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

On Tue, Apr 01, 2025 at 09:01:14AM -0400, Xiaoyao Li wrote:
> Date: Tue,  1 Apr 2025 09:01:14 -0400
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> Subject: [PATCH v8 04/55] i386/tdx: Implement tdx_kvm_init() to initialize
>  TDX VM context
> X-Mailer: git-send-email 2.34.1
> 
> Implement TDX specific ConfidentialGuestSupportClass::kvm_init()
> callback, tdx_kvm_init().
> 
> Mark guest state is proctected for TDX VM.  More TDX specific
> initialization will be added later.
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
> Changes in v6:
>  - remove Acked-by from Gerd since the patch changed due to use
>    ConfidentialGuestSupportClass::kvm_init();
> ---
>  target/i386/kvm/kvm.c | 11 +----------
>  target/i386/kvm/tdx.c | 10 ++++++++++
>  2 files changed, 11 insertions(+), 10 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


