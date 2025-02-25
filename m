Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90366C021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 08:40:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmqUI-0004uk-4S; Tue, 25 Feb 2025 03:40:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tmqUG-0004uP-RK; Tue, 25 Feb 2025 03:40:20 -0500
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tmqUE-0006xA-SL; Tue, 25 Feb 2025 03:40:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740472819; x=1772008819;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=X+6YwobAZHS/ZNCYW6Ko03wPfvvRr317mo0xh0JB3rI=;
 b=ccFKdEucdox7Dn+EEdZ2D+NAFPt4z2eUoT8t/oTE3R+DsNRZbIvDz+pN
 zcY8vepYmIKVWUQpxBH5/FXxlWIqFDwxdnSXNFIRJk+Xx4F/iPe1lDdMl
 hlfd9ekOe83du2Gi9UOm7ajUx6k1/ct4IrmQCZl3ttfDCqFOB7sY4mw7V
 sxjnVo1trg/nExeqqvFFqhcR098oWk2Wzjk5AQm2kTNvZQDxUHSa742cj
 ZNOmNfmu/H+G6wbjbccK2VMUq9sGvvQtCsAOOUrkuYpb0MWwg+XW1+USr
 u2vv5hhroCJnipV3YmQf7RFs8O8MJUoaK7OE2Zyz/wiEoz/7fMs0OR6nP Q==;
X-CSE-ConnectionGUID: cFWQayPFSEmRKtKVjkFbIw==
X-CSE-MsgGUID: kDOdLMIyQH2HEUKFq0O0ug==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="44089747"
X-IronPort-AV: E=Sophos;i="6.13,313,1732608000"; d="scan'208";a="44089747"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2025 00:40:15 -0800
X-CSE-ConnectionGUID: Ce37mBdZTa+VwkNKM5PFtQ==
X-CSE-MsgGUID: ZG044S3hT72T0Y7OGC9+Dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="147211832"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa001.fm.intel.com with ESMTP; 25 Feb 2025 00:40:15 -0800
Date: Tue, 25 Feb 2025 16:59:52 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 12/15] rust: sysbus: wrap SysBusDevice with Opaque<>
Message-ID: <Z72GiF11dlzuDQ+i@intel.com>
References: <20250221170342.63591-1-pbonzini@redhat.com>
 <20250221170342.63591-13-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221170342.63591-13-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.13; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
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

On Fri, Feb 21, 2025 at 06:03:39PM +0100, Paolo Bonzini wrote:
> Date: Fri, 21 Feb 2025 18:03:39 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 12/15] rust: sysbus: wrap SysBusDevice with Opaque<>
> X-Mailer: git-send-email 2.48.1
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/hw/timer/hpet/src/hpet.rs |  2 +-
>  rust/qemu-api/src/bindings.rs  |  3 ---
>  rust/qemu-api/src/sysbus.rs    | 25 ++++++++++++++++++-------
>  3 files changed, 19 insertions(+), 11 deletions(-)
> 
> diff --git a/rust/hw/timer/hpet/src/hpet.rs b/rust/hw/timer/hpet/src/hpet.rs
> index be27eb0eff4..19e63465cff 100644
> --- a/rust/hw/timer/hpet/src/hpet.rs
> +++ b/rust/hw/timer/hpet/src/hpet.rs
> @@ -741,7 +741,7 @@ fn reset_hold(&self, _type: ResetType) {
>          HPETFwConfig::update_hpet_cfg(
>              self.hpet_id.get(),
>              self.capability.get() as u32,
> -            sbd.mmio[0].addr,
> +            unsafe { *sbd.as_ptr() }.mmio[0].addr,

We can wrap this unsafe code into SysBusDeviceMethods...then the device
won't introduce more unsafe code.

>          );
>  
>          // to document that the RTC lowers its output on reset as well

Others, fine for me,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


