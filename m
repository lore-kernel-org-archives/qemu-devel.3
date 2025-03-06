Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 680DCC282EC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 11:25:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tq9LL-00010s-ER; Thu, 06 Mar 2025 06:24:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tq9LG-0000zv-D7; Thu, 06 Mar 2025 06:24:42 -0500
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tq9L8-0004w6-45; Thu, 06 Mar 2025 06:24:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741260274; x=1772796274;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=r6wgExkk4U7GWJSctxjV7Bi6XilOhIqVrFjK/a1ZwRI=;
 b=MG/5WSMgX4LwxJSzhXlynVYyXxuDrwySup6XM+Rmpwf+0kGXre769o5z
 QlUvjQSBbM82p5mQGqp/9kuPlrWiuw5qnQNLllEVpGgretCFpMyE0K6n3
 E7LCLNEaMm69BgmRGnFDH6Md1KBFnFGOXSTsNQgGdCus/gWyiH73cBe9m
 khseES26k7apnC5pJmg9iiYO1H0Sd/JqHG0GQxdKkhXKJ3LAKsAN+FNXS
 7qgeUPGF7gYxUlBuc3pDtO02uizqiu+L+JFHQ5bhNOLGuK49DBmENjM11
 C+gF1f861JhGglgXwdcyBYEN0FWcHsflnzpuDqcwswA3GY9r2OU6BvVsE A==;
X-CSE-ConnectionGUID: WEHk3fI/RNWFAWL4yHWA9A==
X-CSE-MsgGUID: vRFAyiHvQpqf4SHfk2pJdg==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="52472196"
X-IronPort-AV: E=Sophos;i="6.14,226,1736841600"; d="scan'208";a="52472196"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Mar 2025 03:15:05 -0800
X-CSE-ConnectionGUID: cQ8Kb5HoRh2VEhTv4L70wA==
X-CSE-MsgGUID: TwxIT0DGTxaGxSoAO1Zm8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,226,1736841600"; d="scan'208";a="119491051"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa010.fm.intel.com with ESMTP; 06 Mar 2025 03:15:02 -0800
Date: Thu, 6 Mar 2025 19:35:10 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 04/12] rust: timer: wrap QEMUTimer with Opaque<> and
 express pinning requirements
Message-ID: <Z8mIbmv9fFmCzEsg@intel.com>
References: <20250227142219.812270-1-pbonzini@redhat.com>
 <20250227142219.812270-5-pbonzini@redhat.com>
 <Z8WzRyPbt6d7CHWM@intel.com>
 <7b09b4e3-3c1f-4c94-ad3a-054eaf74f24c@redhat.com>
 <Z8bEN0HFbfMJ5rmm@intel.com>
 <90a21eff-a7b4-41dd-99df-c36fd83a1c08@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90a21eff-a7b4-41dd-99df-c36fd83a1c08@redhat.com>
Received-SPF: pass client-ip=198.175.65.11; envelope-from=zhao1.liu@intel.com;
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

> While neither is good, a zeroed area of memory behaves better than an
> uninitialized one...  In particular, Drop calls timer_del() which works fine
> with a zeroed QEMUTimer.  With Opaque::uninit() you could have a crash just
> with
> 
>     drop(Timer::new());

Good point.

> > // No compiling error or runtime panic
> > let t: MaybeUninit<bindings::QEMUTimer> = MaybeUninit::zeroed();
> > let _t = unsafe { t.assume_init() };
> > 
> > Further more, I spent some time trying to figure out if MaybeUninit in
> > Opaque<> could help identify UB caused by uninitialized Timer, but I found
> > it doesn't work. :-(
> > 
> > // No compiling error or runtime panic
> > let mut v: UnsafeCell<MaybeUninit<bindings::QEMUTimer>> = UnsafeCell::new(MaybeUninit::uninit());
> > let _v = unsafe { v.get_mut().assume_init() };
> > 
> > But when I adjust MaybeUninit as the outer wrapper, the UB check can
> > work:
> > 
> > // Runtime panic: Illegal instruction
> > let v: MaybeUninit<UnsafeCell<bindings::QEMUTimer>> = MaybeUninit::uninit();
> > let _v = unsafe { v.assume_init() };
> > 
> > Compared with linux's Opaque, it also puts MaybeUninit on the outermost
> > layer.
> 
> Yes, I admit I just copied what Linux does. :)

Thanks for pointing this! I realized I referred the old code, since this
commit, linux puts the UnsafeCell to the outer layer [2]

[2]: https://github.com/torvalds/linux/commit/35cad617df2eeef8440a38e82bb2d81ae32ca50d

It seems that, at least from the Linux view, here the role of MaybeUninit
(as the cases I tested) is not a main concern, and Rust convention is
superior...

> > And there's another example:
> > 
> > https://doc.rust-lang.org/std/cell/struct.UnsafeCell.html#method.raw_get
> > 
> > Emm, I guess now we have UnsafeCell<MaybeUninit<>> because interior
> > mutability is expected... but this layout breaks MaybeUninit's functionality.
> 
> Thanks for the example from the documentation!  Indeed it should be possible
> to do
> 
>     /// Returns a raw mutable pointer to the opaque data.
>     pub const fn as_mut_ptr(&self) -> *mut T {
>         UnsafeCell::raw_get(self.value.as_ptr())
>     }
> 
>     /// Returns a raw pointer to the opaque data that can be passed to a
>     /// C function as `void *`.
>     pub const fn as_void_ptr(&self) -> *mut std::ffi::c_void {
>         self.as_mut_ptr().cast()
>     }
> 
>     pub const fn raw_get(slot: *const Self) -> *mut T {
>         // SAFETY: even if uninitialized, slot points to a MaybeUninit
>         let slot = slot.cast::<MaybeUninit<UnsafeCell<T>>>;
>         UnsafeCell::raw_get(slot.as_ptr())
>     }
> 
> if Opaque<> uses a MaybeUninit<UnsafeCell<T>>.  I'm a bit worried of
> deviating from what Linux does though...

Thank you, this convertion to UnsafeCell<MaybeUninit<T>> in Linux
history convinces me... I also agree that we should follow it for now :-).

Regards,
Zhao



