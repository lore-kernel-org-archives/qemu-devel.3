Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28D70C02181
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 14:40:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tabta-0004mJ-3T; Wed, 22 Jan 2025 09:39:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tabtX-0004lq-Mi; Wed, 22 Jan 2025 09:39:51 -0500
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tabtV-0001o3-1j; Wed, 22 Jan 2025 09:39:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737556789; x=1769092789;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=5Ym+M4cPeVCdBwJ2F7VMeBkHeKUlPQi1BcYbIzqqF/E=;
 b=P9CnB0f+98mmYDHpQYz6+RhyXnwjcqmvAl+xDckwIMZQkjrRnQoJnuM+
 fg4CbNG/IUQLyZq3u//Lciz/ZaDdg/r73tfW448BxMBWB5yCbYBZqvsiF
 UAx7nAkMfv3912nd1MOy0ONr7Shf9XToENmhQnhvgloVDeGQlk/VNHA2/
 U+WIcXsq0ROoxyh0GPS0tvWqoUeiaeDBtbwhIgc7HMbv+D6W8LaNypE9Y
 q5SyyveypFGEGDkwJCi5+GI0+AKsbO8J9BueRZMg9wCTiAA757hQpnSEw
 surhRl5K1YXIXVd/iLn9eNXycwk9TJnlyE7CcYTc0ZuHeql+aQg5rqXEr g==;
X-CSE-ConnectionGUID: hHKe6cgSTuOfU1EqYZoIVg==
X-CSE-MsgGUID: iq2YFhvbTSm903nr1269eQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11323"; a="41945132"
X-IronPort-AV: E=Sophos;i="6.13,225,1732608000"; d="scan'208";a="41945132"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jan 2025 06:39:46 -0800
X-CSE-ConnectionGUID: stABlHwbS2yLn4knySMOaQ==
X-CSE-MsgGUID: aX82KXngSeCBkmVW4/ecow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="111797938"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa005.fm.intel.com with ESMTP; 22 Jan 2025 06:39:45 -0800
Date: Wed, 22 Jan 2025 22:59:07 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 04/10] rust: pl011: extract CharBackend receive logic
 into a separate function
Message-ID: <Z5EHu/7nEbS51IlH@intel.com>
References: <20250117092657.1051233-1-pbonzini@redhat.com>
 <20250117092657.1051233-5-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250117092657.1051233-5-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.12; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
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

On Fri, Jan 17, 2025 at 10:26:51AM +0100, Paolo Bonzini wrote:
> Date: Fri, 17 Jan 2025 10:26:51 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 04/10] rust: pl011: extract CharBackend receive logic into
>  a separate function
> X-Mailer: git-send-email 2.47.1
> 
> Prepare for moving all references to the registers and the FIFO into a
> separate struct.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/hw/char/pl011/src/device.rs | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)

[snip]

> -    pub fn put_fifo(&mut self, value: c_uint) {
> +    pub fn put_fifo(&mut self, value: u32) {
>          let depth = self.fifo_depth();
>          assert!(depth > 0);
>          let slot = (self.read_pos + self.read_count) & (depth - 1);
> @@ -615,12 +621,9 @@ pub fn write(&mut self, offset: hwaddr, value: u64) {
>      unsafe {
>          debug_assert!(!opaque.is_null());
>          let mut state = NonNull::new_unchecked(opaque.cast::<PL011State>());
> -        if state.as_ref().loopback_enabled() {
> -            return;
> -        }
>          if size > 0 {
>              debug_assert!(!buf.is_null());
> -            state.as_mut().put_fifo(c_uint::from(buf.read_volatile()))

An extra question...here I'm not sure, do we really need read_volatile?

> +            state.as_mut().receive(u32::from(buf.read_volatile()));
>          }
>      }
>  }

Patch is fine for me,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>



