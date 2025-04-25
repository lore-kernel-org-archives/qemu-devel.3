Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4703C369D1
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 06:46:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8CoF-0003dP-N9; Fri, 25 Apr 2025 02:45:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u8CoD-0003cW-KD
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 02:45:13 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u8CoA-0005sA-MI
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 02:45:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1745563510; x=1777099510;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=q8UF8TdxaGi2PMafLQ5ROiLuEWNArITzldPU3fPw58Y=;
 b=ijsnkGa1UY6cPSUsytcheQ7zbCmIQaVLE1GWMqssA/9ck9lF0W8bXYGP
 hGsWaqexkDJ2CGcbX7sxXgD7bFUutJ+EOyJTWP14eDVMGiZrKwSs2nR6Z
 UPxGbWNoWjraI5036Co1NWBNpUf1n/Pw2gZ1M/Ipnh5epTmpA92JfNZ0W
 U9ZWcVlhowlSvJ6+0cxMNWLvHdL4jrHi1f/ESXq5tMgPytfeeVsVrlNTw
 x6mRMmWwq5egWTjlLnPW5N/xP8T8iE8hIknmRNoLDHSARf5EfnIDwroP7
 oySgCzRj6I8Dp4qFurHMmLxMGREZ1SJNNBKDV5DhmINU4RNBkTqvGVL2n g==;
X-CSE-ConnectionGUID: uSdkGMP5QMu/A9NkjQUU5A==
X-CSE-MsgGUID: Qew/ITsyTAONQJ1NiNAoxQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11413"; a="47345625"
X-IronPort-AV: E=Sophos;i="6.15,238,1739865600"; d="scan'208";a="47345625"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Apr 2025 23:45:06 -0700
X-CSE-ConnectionGUID: JydgkUASSwuqUx2vgBIMqw==
X-CSE-MsgGUID: 8irxqXJRRzy1vm8ZhlZ46Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,238,1739865600"; d="scan'208";a="163884228"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa001.fm.intel.com with ESMTP; 24 Apr 2025 23:45:03 -0700
Date: Fri, 25 Apr 2025 15:05:59 +0800
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
Subject: Re: [PATCH v8 23/55] i386/tdx: Setup the TD HOB list
Message-ID: <aAs0V5rRCYeSOZdS@intel.com>
References: <20250401130205.2198253-1-xiaoyao.li@intel.com>
 <20250401130205.2198253-24-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401130205.2198253-24-xiaoyao.li@intel.com>
Received-SPF: pass client-ip=198.175.65.18; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.84,
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

On Tue, Apr 01, 2025 at 09:01:33AM -0400, Xiaoyao Li wrote:
> Date: Tue,  1 Apr 2025 09:01:33 -0400
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> Subject: [PATCH v8 23/55] i386/tdx: Setup the TD HOB list
> X-Mailer: git-send-email 2.34.1
> 
> The TD HOB list is used to pass the information from VMM to TDVF. The TD
> HOB must include PHIT HOB and Resource Descriptor HOB. More details can
> be found in TDVF specification and PI specification.
> 
> Build the TD HOB in TDX's machine_init_done callback.
> 
> Co-developed-by: Isaku Yamahata <isaku.yamahata@intel.com>
> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
> Co-developed-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Acked-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
> Changes in v7:
>  - use SPDX tag for license info;
>  - clean up the included headers;
> 
> Changes in v1:
>  - drop the code of adding mmio resources since OVMF prepares all the
>    MMIO hob itself.
> ---
>  hw/i386/meson.build   |   2 +-
>  hw/i386/tdvf-hob.c    | 130 ++++++++++++++++++++++++++++++++++++++++++
>  hw/i386/tdvf-hob.h    |  26 +++++++++
>  target/i386/kvm/tdx.c |  16 ++++++
>  4 files changed, 173 insertions(+), 1 deletion(-)
>  create mode 100644 hw/i386/tdvf-hob.c
>  create mode 100644 hw/i386/tdvf-hob.h

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


