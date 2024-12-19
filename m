Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FCB4E77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 07:35:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOB37-0007Iu-8i; Thu, 19 Dec 2024 02:34:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tOB2y-0007Fz-24; Thu, 19 Dec 2024 02:34:16 -0500
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tOB2w-0008Hs-6n; Thu, 19 Dec 2024 02:34:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1734593651; x=1766129651;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=VSXnfC/+nR0iFTlqbuV2xSEtbkIHUp5UGQVwwn/8ZoE=;
 b=CpmF1QvZGOmtzjxGskwCbbf4UKwX5W4flXOSPbboXwFO7JtMU/MAMZ8A
 hdl4UVinlLiMgL2pj2zbfZOVE9+eLodjuOMJGHyPJxSkvdKlnM8K3Bait
 xE3bthntyoUPlY5hQG0wGsSWFTZkxUDLp12RKOs1D8SzlyX4PoIifPx/p
 RaWP2vyUEp9W7VSCjozDU29jtHmR7bVRS+nULfwQgVvAjZXur/sktQ5Rr
 z2jUr5+trke9HEeKMly3sYc/p+Km3XBQNn55ATm7F7OZR+WGQRPB5hwvl
 Ef1qqJJjwrlMI21Oa6zi7SLcN6bTpT1RydBfyx4VVcVTqJDVdsVfpRhtC g==;
X-CSE-ConnectionGUID: lDqKUYgXQL61Z0dkTvONOA==
X-CSE-MsgGUID: O6Yez/ByS6C4rS/E8DVMww==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="46100296"
X-IronPort-AV: E=Sophos;i="6.12,247,1728975600"; d="scan'208";a="46100296"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Dec 2024 23:34:06 -0800
X-CSE-ConnectionGUID: 0lqVE+CcSoiO6tdt4Y203w==
X-CSE-MsgGUID: JhoetIzvSrKUVMGAgJS5Lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,247,1728975600"; d="scan'208";a="102966802"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa004.fm.intel.com with ESMTP; 18 Dec 2024 23:34:06 -0800
Date: Thu, 19 Dec 2024 15:52:45 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 6/7] rust: pl011: fix migration stream
Message-ID: <Z2PQzYc3aoyElDSn@intel.com>
References: <20241212172209.533779-1-pbonzini@redhat.com>
 <20241212172209.533779-7-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212172209.533779-7-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.13; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Thu, Dec 12, 2024 at 06:22:03PM +0100, Paolo Bonzini wrote:
> Date: Thu, 12 Dec 2024 18:22:03 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 6/7] rust: pl011: fix migration stream
> X-Mailer: git-send-email 2.47.1
> 
> The Rust vmstate macros lack the type-safety of their C equivalents (so
> safe, much abstraction), and therefore they were predictably wrong.

Yes, this makes Rust more unsafe than C code...

> The registers have already been changed to 32-bits in the previous patch,
> but read_pos/read_count/read_trigger also have to be u32 instead of usize.
> The easiest way to do so is to let the FIFO use u32 indices instead
> of usize.
> 
> My plan for making VMStateField typesafe is to have a trait to retrieve
> a basic VMStateField; for example something like vmstate_uint32 would
> become an implementation of the VMState trait on u32.  Then you'd write
> something like "vmstate_of!(Type, field).with_version_id(2)".  That is,
> vmstate_of retrieves the basic VMStateField and fills in the offset,
> and then more changes can be applied on top.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/hw/char/pl011/src/device.rs       | 38 ++++++++++++++++++++++----
>  rust/hw/char/pl011/src/device_class.rs |  8 +++---
>  rust/qemu-api/src/vmstate.rs           | 22 ---------------
>  3 files changed, 36 insertions(+), 32 deletions(-)
> 
> @@ -64,9 +64,9 @@ extern "C" fn pl011_post_load(opaque: *mut c_void, version_id: c_int) -> c_int {
>          vmstate_uint32!(ibrd, PL011State),
>          vmstate_uint32!(fbrd, PL011State),
>          vmstate_uint32!(ifl, PL011State),
> -        vmstate_int32!(read_pos, PL011State),
> -        vmstate_int32!(read_count, PL011State),
> -        vmstate_int32!(read_trigger, PL011State),
> +        vmstate_uint32!(read_pos, PL011State),
> +        vmstate_uint32!(read_count, PL011State),
> +        vmstate_uint32!(read_trigger, PL011State),

uint32 and int32 types both use `qemu_put_be32s` and `qemu_get_be32s`
to save and store vmstate, so I think it's safe to convert
vmstate_int32! to vmstate_uint32! here.

>      },

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


