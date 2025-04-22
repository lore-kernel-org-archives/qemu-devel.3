Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1506FC369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 15:15:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7FL1-00081y-Va; Tue, 22 Apr 2025 11:15:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u7FKr-0007zO-QP
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 11:15:00 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u7FKp-0007hJ-VS
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 11:14:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1745334896; x=1776870896;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Hu4lrMHy2xrhs9qCtCUfRn9WydvvwgOphy3WYHeYGKY=;
 b=HeZMZaCyh41nwULcUzWqnKfxT1Oag6tbwrZJx/e/s74Y76YXuQLTc0sd
 i94Ogr0/IA1brwzMGTk6+2JGYb0szvrrcmrG51nVDRI+PSQ6y+sxg/qEt
 faKW92QhBZrSMGqMKgmubxRbKJHbPlriTOWeSpT/PbePm3/ycMGb7spYB
 mdL6XVTCqZDFcBYPJ9p2aspL6hxEoeVY4GS1FVYa5KxeVeH21GUx/EzXJ
 f3xV1V2677dgm2A8ADr8FIgTwvVyAavQOrBcKhvqpS69kdKAOuUQBY0yl
 C/BDaacS8esLbuEgqX5A86VkuWaQbLSZPQdJwiACByRxhHIdhcz21xhca A==;
X-CSE-ConnectionGUID: p3TV30uYQXOHq0lNzIKeqQ==
X-CSE-MsgGUID: AAoybQZhSbKvIkyVF57ibg==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="47079772"
X-IronPort-AV: E=Sophos;i="6.15,231,1739865600"; d="scan'208";a="47079772"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2025 08:14:54 -0700
X-CSE-ConnectionGUID: 6p6grq8RT4eItLbGWZ3a+g==
X-CSE-MsgGUID: SX0rmRcQQ+qpWOq+iqt8yQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,231,1739865600"; d="scan'208";a="132582006"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa007.jf.intel.com with ESMTP; 22 Apr 2025 08:14:51 -0700
Date: Tue, 22 Apr 2025 23:35:46 +0800
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
Subject: Re: [PATCH v8 12/55] i386/tdx: Validate TD attributes
Message-ID: <aAe3UoY4ERZUhrKs@intel.com>
References: <20250401130205.2198253-1-xiaoyao.li@intel.com>
 <20250401130205.2198253-13-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401130205.2198253-13-xiaoyao.li@intel.com>
Received-SPF: pass client-ip=192.198.163.14; envelope-from=zhao1.liu@intel.com;
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

On Tue, Apr 01, 2025 at 09:01:22AM -0400, Xiaoyao Li wrote:
> Date: Tue,  1 Apr 2025 09:01:22 -0400
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> Subject: [PATCH v8 12/55] i386/tdx: Validate TD attributes
> X-Mailer: git-send-email 2.34.1
> 
> Validate TD attributes with tdx_caps that only supported bits are
> allowed by KVM.
> 
> Besides, sanity check the attribute bits that have not been supported by
> QEMU yet. e.g., debug bit, it will be allowed in the future when debug
> TD support lands in QEMU.
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Acked-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
> Changes in v8:
> - Split the mrconfigid/mrowner/mrownerconfig part into a seperate next
>   patch;
> 
> Changes in v7:
> - Define TDX_SUPPORTED_TD_ATTRS as QEMU supported mask, to validates
>   user's request. (Rick)
> 
> Changes in v3:
> - using error_setg() for error report; (Daniel)
> ---
>  target/i386/kvm/tdx.c | 32 ++++++++++++++++++++++++++++++--
>  1 file changed, 30 insertions(+), 2 deletions(-)

Overall LGTM,

(with Daniel's comment fixed)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


