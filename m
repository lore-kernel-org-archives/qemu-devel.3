Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 983FCC282CD
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 13:29:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp5r8-0002vr-63; Mon, 03 Mar 2025 08:29:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tp5qq-0002u1-KI; Mon, 03 Mar 2025 08:28:59 -0500
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tp5qn-000806-Gy; Mon, 03 Mar 2025 08:28:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741008533; x=1772544533;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=0X6HNmOEjPPOHXHgDv4hf5mXi8TwipaxgsoMGSSkWD0=;
 b=JWjuGN5PQb6lpC47WdTY1z7yDJvQxR2qj95TpSvSrEDIzSFeWE6JS81w
 svekNecy0IFDzMRfVjPPkIzMW35kwYDjRbY2ygufF/HZLJbp7pc/XU4hg
 ZX1yMiAKd/kA1O7ZhBc2MSrGerllCY5WKcd61vBYJZYWlbQHnG2pHWbwW
 ak6PB8nssdwLd7McmxY88Ml0jJUl31AfyvezasP2Y7GvWYRGTbB8Cy3m/
 2pn7yLfIQC53spYninMnZ6V/xJnYsWG0/3CJvE784+jZojrnbi47bH6kX
 gvmz+nZEEGMAUaJWR79Is1BNLIGfVQnoEXSmWQ6Mqu2NNzXcmUvPXQaR8 Q==;
X-CSE-ConnectionGUID: qRUvJs6VR1CMLBjocbAHVA==
X-CSE-MsgGUID: 6Kmac9o6TymbTLWJIoJPSA==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="52526257"
X-IronPort-AV: E=Sophos;i="6.13,329,1732608000"; d="scan'208";a="52526257"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Mar 2025 05:28:49 -0800
X-CSE-ConnectionGUID: 1ABxd0P7SKq1kmfJygEx8g==
X-CSE-MsgGUID: AHN0v1Q0QESJ5Tgl2q/ogg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,329,1732608000"; d="scan'208";a="118039189"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa006.jf.intel.com with ESMTP; 03 Mar 2025 05:28:49 -0800
Date: Mon, 3 Mar 2025 21:48:55 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 04/12] rust: timer: wrap QEMUTimer with Opaque<> and
 express pinning requirements
Message-ID: <Z8WzRyPbt6d7CHWM@intel.com>
References: <20250227142219.812270-1-pbonzini@redhat.com>
 <20250227142219.812270-5-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227142219.812270-5-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.11; envelope-from=zhao1.liu@intel.com;
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

On Thu, Feb 27, 2025 at 03:22:11PM +0100, Paolo Bonzini wrote:
> Date: Thu, 27 Feb 2025 15:22:11 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 04/12] rust: timer: wrap QEMUTimer with Opaque<> and
>  express pinning requirements
> X-Mailer: git-send-email 2.48.1
> 
> Timers must be pinned in memory, because modify() stores a pointer to them
> in the TimerList.  To ensure this is the case, replace the separate new()
> and init_full() with a single function that returns a pinned box.  Because
> the only way to obtain a Timer is through Timer::new_full(), modify()
> knows that the timer it got is also pinned.  In the future the pinning
> requirement will be expressed through the pin_init crate instead.
> 
> Note that Timer is a bit different from other users of Opaque, in that
> it is created in Rust code rather than C code.  This is why it has to
> use the unsafe Opaque::new() function.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  meson.build                    |  7 -----
>  rust/hw/timer/hpet/src/hpet.rs | 23 ++++++++---------
>  rust/qemu-api/src/timer.rs     | 47 ++++++++++++++++++++++------------
>  3 files changed, 41 insertions(+), 36 deletions(-)

Great! LGTM,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

(But pls wait, I have a question below...)

> @@ -156,7 +157,7 @@ pub struct HPETTimer {
>      /// timer N index within the timer block (`HPETState`)
>      #[doc(alias = "tn")]
>      index: usize,
> -    qemu_timer: Option<Box<Timer>>,
> +    qemu_timer: Option<Pin<Box<Timer>>>,

I'm removing this Option<> wrapper in migration series. This is because
Option<> can't be treated as pointer as you mentioned in [*].

So for this reason, does this mean that VMStateField cannot accept
Option<>? I realize that all the current VMStateFlags don't seem
compatible with Option<> unless a new flag is introduced.

[*]: https://lore.kernel.org/qemu-devel/9a0389fa-765c-443b-ac2f-7c99ed862982@redhat.com/

Thanks,
Zhao


