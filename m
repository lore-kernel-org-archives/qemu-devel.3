Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16495CF34C6
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 14:55:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLjaj-0004VX-Ma; Wed, 19 Nov 2025 09:55:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vLjad-0004TQ-9u; Wed, 19 Nov 2025 09:55:23 -0500
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vLjaZ-00070J-Jq; Wed, 19 Nov 2025 09:55:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763564120; x=1795100120;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=BvWoA0vcaVwNEvekTuM6kdC7rccVbQxYMtHbR62Pfk0=;
 b=LyhDf1n0TQjUY1WvT8DxgK4bXE9vGYNEoJf7BLHTb4ouvFYgoCp8uCYY
 xcDK00PnU53OZ7O+Na4KYXhd2aBmxAPHQCn0s0HCIbcBWLbx4k195zaPt
 ZmtZ3zCGPdY2Zmoz7S/Cz7TJsQvby87yQuDdy0wZPPzUq8BGwydV3vEzd
 kA6nWQ5K+v8sCcPdZfANzbNRashNF67DepkzPf7Hrj7WioUPFy4Dg6hXn
 VHS+pguzZimrOF+IiCu6aMiON1xhsE/DLD/UQmRcmlZsBvgXv/SCsG8Bc
 wZUc8+udqve1nKxmDjOyR/TISyj7L0zPCr1uQQe9L1NOyWmXQ6LJODGXL g==;
X-CSE-ConnectionGUID: XKOy1T8qSXesxOqJJC/rTA==
X-CSE-MsgGUID: fbGYCpVrS0CtrAJBq+yAhA==
X-IronPort-AV: E=McAfee;i="6800,10657,11618"; a="88260010"
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; d="scan'208";a="88260010"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2025 06:55:11 -0800
X-CSE-ConnectionGUID: FSTV/1J0Tn+xunJeWROH+g==
X-CSE-MsgGUID: HySRJuYnSiKj7csWUwh7rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; d="scan'208";a="191108678"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa007.jf.intel.com with ESMTP; 19 Nov 2025 06:55:08 -0800
Date: Wed, 19 Nov 2025 23:17:26 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 3/5] rust/hpet: remove BqlRefCell around HPETTimer
Message-ID: <aR3fhvpIsXRnQcj8@intel.com>
References: <20251117084752.203219-1-pbonzini@redhat.com>
 <20251117084752.203219-4-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251117084752.203219-4-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.9; envelope-from=zhao1.liu@intel.com;
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

> -    fn init_timer_with_cell(cell: &BqlRefCell<Self>) {
> -        let mut timer = cell.borrow_mut();
> -        // SAFETY: HPETTimer is only used as part of HPETState, which is
> -        // always pinned.
> -        let qemu_timer = unsafe { Pin::new_unchecked(&mut timer.qemu_timer) };
> -        qemu_timer.init_full(None, CLOCK_VIRTUAL, Timer::NS, 0, timer_handler, cell);
> +    fn init_timer(timer: Pin<&mut Self>) {
> +        Timer::init_full(
> +            timer,
> +            None,
> +            CLOCK_VIRTUAL,
> +            Timer::NS,
> +            0,
> +            timer_handler,
> +            |t| &mut t.qemu_timer,
> +        );
>      }

I find this way could also work for BqlRefCell case:

    fn init_timer_with_cell(cell: &mut BqlRefCell<Self>) {
        // SAFETY: HPETTimer is only used as part of HPETState, which is
        // always pinned.
        let timer = unsafe { Pin::new_unchecked(cell) };
        Timer::init_full(
            timer,
            None,
            CLOCK_VIRTUAL,
            Timer::NS,
            0,
            timer_handler,
            |t| {
                assert!(bql::is_locked());
                &mut t.get_mut().qemu_timer
            },
        );
    }


So any other non-lockless timer can also use this interface to
initialize their BqlRefCell<>.

(BTW, I find BqlRefCell::get_mut() / as_ref() missed bql::is_locked().
 right?)

...

> diff --git a/rust/util/src/timer.rs b/rust/util/src/timer.rs
> index c6b3e4088ec..829f52d111e 100644
> --- a/rust/util/src/timer.rs
> +++ b/rust/util/src/timer.rs
> @@ -45,14 +45,14 @@ impl Timer {
>      }
>  
>      /// Create a new timer with the given attributes.
> -    pub fn init_full<'timer, 'opaque: 'timer, T, F>(
> -        self: Pin<&'timer mut Self>,
> +    pub fn init_full<T, F>(
> +        opaque: Pin<&mut T>,
>          timer_list_group: Option<&TimerListGroup>,
>          clk_type: ClockType,
>          scale: u32,
>          attributes: u32,
>          _cb: F,
> -        opaque: &'opaque T,
> +        field: impl FnOnce(&mut T) -> &mut Self,
>      ) where
>          F: for<'a> FnCall<(&'a T,)>,


This is more tricky than I previously imaged. Good solution!

Another way to handle this kind of 'self reference' issue would probably
be to consider passing raw pointers as opaque parameters... but that's
definitely not as clean/idiomatic as the current approach.

I think it may be better to add doc about how to use this for
BqlRefCell<> case since there'll be no example after this patch.


Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


