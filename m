Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F67BC369D5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 15:03:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9Q1B-0007PZ-6B; Mon, 28 Apr 2025 11:03:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u9Q12-00078d-T1
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 11:03:30 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u9Q10-0005RK-9Q
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 11:03:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1745852606; x=1777388606;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=uCkPZ6weyUKiCrByTKbIBUfU/Gk3AiPx/L8vDF2PDzQ=;
 b=TGKYL9wUOTCGCDdRG8gJ2szBJebVcebUFAX1eAf+GunEy8nydoUb2+es
 Huu0opnRao+lxfT4HhcSn9cB9d85PUJ4TRbf/sm8QxHHvMeDUuWp5gR1a
 R109xwSF6gHssqsDykJ8ytUU9tnaozLXhpZIN9xHdyfL7yQMu9Cwj8joy
 /8nWYqu+oAefm2xEUNKigSv5bkGYlF6WSBzBF2Ggd3/gGhJiKDiTs0cel
 RcB6JrJLhH1F4Apr6bfGrlZhvCAbiNR23THn9hO5frF4bvob3VtlwsIS4
 u3soc2oxj/yME4v9pA1k4uKi61DygycCJJq/w2Yc7Qhdocg7/lccfV0mw w==;
X-CSE-ConnectionGUID: 6fxwxoGvQXK1mOSYzoZSHA==
X-CSE-MsgGUID: lqYbQz+oTlaIJKq5ElOusQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11417"; a="50102389"
X-IronPort-AV: E=Sophos;i="6.15,246,1739865600"; d="scan'208";a="50102389"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2025 08:03:00 -0700
X-CSE-ConnectionGUID: DLf3ENhCQj2N8PXAyLbWjQ==
X-CSE-MsgGUID: MWRc+gahSMeBC8+/5a0PYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,246,1739865600"; d="scan'208";a="138640017"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa004.fm.intel.com with ESMTP; 28 Apr 2025 08:02:57 -0700
Date: Mon, 28 Apr 2025 23:23:55 +0800
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
Subject: Re: [PATCH v8 29/55] i386/tdx: Wire TDX_REPORT_FATAL_ERROR with
 GuestPanic facility
Message-ID: <aA+di6hLWHo2UxO2@intel.com>
References: <20250401130205.2198253-1-xiaoyao.li@intel.com>
 <20250401130205.2198253-30-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401130205.2198253-30-xiaoyao.li@intel.com>
Received-SPF: pass client-ip=192.198.163.13; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.484,
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

On Tue, Apr 01, 2025 at 09:01:39AM -0400, Xiaoyao Li wrote:
> Date: Tue,  1 Apr 2025 09:01:39 -0400
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> Subject: [PATCH v8 29/55] i386/tdx: Wire TDX_REPORT_FATAL_ERROR with
>  GuestPanic facility
> X-Mailer: git-send-email 2.34.1
> 
> Integrate TDX's TDX_REPORT_FATAL_ERROR into QEMU GuestPanic facility
> 
> Originated-from: Isaku Yamahata <isaku.yamahata@intel.com>
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Acked-by: Markus Armbruster <armbru@redhat.com>
> ---
> Changes in v8:
> - use g_strdup() for copy string;
> - use the new data ABI of KVM_SYSTEM_EVENT_TDX_FATAL to grab gpa info;
> 
> Changes in v6:
> - change error_code of GuestPanicInformationTdx from uint64_t to
>   uint32_t, to only contains the bit 31:0 returned in r12.
> 
> Changes in v5:
> - mention additional error information in gpa when it presents;
> - refine the documentation; (Markus)
> 
> Changes in v4:
> - refine the documentation; (Markus)
> 
> Changes in v3:
> - Add docmentation of new type and struct; (Daniel)
> - refine the error message handling; (Daniel)
> ---
>  qapi/run-state.json   | 31 +++++++++++++++++++--
>  system/runstate.c     | 65 +++++++++++++++++++++++++++++++++++++++++++
>  target/i386/kvm/tdx.c | 24 +++++++++++++++-
>  3 files changed, 117 insertions(+), 3 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


