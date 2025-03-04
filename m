Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D772C021B8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 08:53:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpO1s-00061h-87; Tue, 04 Mar 2025 03:53:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tpO1o-00061U-LY; Tue, 04 Mar 2025 03:53:29 -0500
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tpO1l-0005dW-4N; Tue, 04 Mar 2025 03:53:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741078406; x=1772614406;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=DD49mn5QPTgW6QPY2uCSYg7OQGI8uI8Cu0Gz/Ynm4gw=;
 b=E7SVNs9Bifo51fWh1BlvHNXpXKmxPwyCQktTWUX5Iy7GJpbjnSO1DYlW
 J4odx03Lwi6OrpAfpcuQ+LC0ypiHhxwsCNFmDpnakbZDSDXuiR9VRGfRT
 000vvMdoV36kZa8Ny4LPWDPxO2kIUICOBpU4c1OLANNJRU/n7IAZBYLOE
 jTJQB18RRaLczulq52Mf8cySkXWQa+FWcg/RQrp8SJDT7LTuvpWY0HE+x
 Unwcqu5ql4/X3T0UTRaDlVcMtyeAG2lZzdBPO6QHbmNUP0vVMVn6mGH1g
 uDqdq9bnVBVPyf99FR3ibSpfppKLCKuglW2NtRgEraANwq0n+1qNSkHER A==;
X-CSE-ConnectionGUID: ukduHEtSQ8KFAUliQfZCXg==
X-CSE-MsgGUID: +G6hsJWCQ+SsEnQAwqiAZw==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="53380107"
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; d="scan'208";a="53380107"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2025 00:53:22 -0800
X-CSE-ConnectionGUID: bBGm1DP2QYqwvaX1NRAGeA==
X-CSE-MsgGUID: TjFVd6ErQ8mKdi6wjY4vEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; d="scan'208";a="123434460"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa004.fm.intel.com with ESMTP; 04 Mar 2025 00:53:19 -0800
Date: Tue, 4 Mar 2025 17:13:27 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 04/12] rust: timer: wrap QEMUTimer with Opaque<> and
 express pinning requirements
Message-ID: <Z8bEN0HFbfMJ5rmm@intel.com>
References: <20250227142219.812270-1-pbonzini@redhat.com>
 <20250227142219.812270-5-pbonzini@redhat.com>
 <Z8WzRyPbt6d7CHWM@intel.com>
 <7b09b4e3-3c1f-4c94-ad3a-054eaf74f24c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b09b4e3-3c1f-4c94-ad3a-054eaf74f24c@redhat.com>
Received-SPF: pass client-ip=198.175.65.12; envelope-from=zhao1.liu@intel.com;
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

On Mon, Mar 03, 2025 at 04:58:57PM +0100, Paolo Bonzini wrote:
> Date: Mon, 3 Mar 2025 16:58:57 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: Re: [PATCH 04/12] rust: timer: wrap QEMUTimer with Opaque<> and
>  express pinning requirements
> 
> On 3/3/25 14:48, Zhao Liu wrote:
> > > @@ -156,7 +157,7 @@ pub struct HPETTimer {
> > >       /// timer N index within the timer block (`HPETState`)
> > >       #[doc(alias = "tn")]
> > >       index: usize,
> > > -    qemu_timer: Option<Box<Timer>>,
> > > +    qemu_timer: Option<Pin<Box<Timer>>>,
> > 
> > I'm removing this Option<> wrapper in migration series. This is because
> > Option<> can't be treated as pointer as you mentioned in [*].
> > 
> > So for this reason, does this mean that VMStateField cannot accept
> > Option<>? I realize that all the current VMStateFlags don't seem
> > compatible with Option<> unless a new flag is introduced.
> > 
> > [*]: https://lore.kernel.org/qemu-devel/9a0389fa-765c-443b-ac2f-7c99ed862982@redhat.com/
> 
> Ok, so let's get rid of the option.  I didn't really like it anyway...
> 
> If the Timer is embedded in the HPETTimer, there needs to be some
> "unsafe" in order to make sure that the pinning is observed, and also
> because an uninitialized Timer is bad and can cause a NULL pointer
> dereference in modify()... i.e. Timer shouldn't have implemented
> Default!

Yes! Good point.

> However, the lifetime checks in init_full() are preserved, so overall
> this is better---at least for now.  Linux also had unsafe initialization
> for quite some time, so I'm okay with it.

The overall design is okay for me too.

> The replacements for this patch are below.

I have comments about current Opaque<> implemation below...
  
> From 2d74bdf176b2fbeb6205396d0021f68a9e72bde1 Mon Sep 17 00:00:00 2001
> From: Paolo Bonzini <pbonzini@redhat.com>
> Date: Mon, 3 Mar 2025 16:27:08 +0100
> Subject: [PATCH 1/2] rust: hpet: embed Timer without the Option and Box
>  indirection
> 
> This simplifies things for migration, since Option<Box<QEMUTimer>> does not
> implement VMState.
> 
> This also shows a soundness issue because Timer::new() will leave a NULL
> timer list pointer, which can then be dereferenced by Timer::modify().  It
> will be fixed shortly.

Good catch!

> Suggested-by: Zhao Liu <zhao1.liu@intel.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/hw/timer/hpet/src/hpet.rs | 59 ++++++++++++++++------------------
>  1 file changed, 28 insertions(+), 31 deletions(-)

Thanks. This cleanup is fine for me!

...

> From 276020645786b6537c50bb37795f281b5d630f27 Mon Sep 17 00:00:00 2001
> From: Paolo Bonzini <pbonzini@redhat.com>
> Date: Fri, 14 Feb 2025 12:06:13 +0100
> Subject: [PATCH 2/2] rust: timer: wrap QEMUTimer with Opaque<> and express
>  pinning requirements
> 
> Timers must be pinned in memory, because modify() stores a pointer to them
> in the TimerList.  To express this requirement, change init_full() to take
> a pinned reference.  Because the only way to obtain a Timer is through
> Timer::new(), which is unsafe, modify() can assume that the timer it got
> was later initialized; and because the initialization takes a Pin<&mut
> Timer> modify() can assume that the timer is pinned.  In the future the
> pinning requirement will be expressed through the pin_init crate instead.
> 
> Note that Timer is a bit different from other users of Opaque, in that
> it is created in Rust code rather than C code.  This is why it has to
> use the unsafe constructors provided by Opaque; and in fact Timer::new()
> is also unsafe, because it leaves it to the caller to invoke init_full()
> before modify().  Without a call to init_full(), modify() will cause a
> NULL pointer dereference.
> 
> An alternative could be to combine new() + init_full() by returning a
> pinned box; however, using a reference makes it easier to express
> the requirement that the opaque outlives the timer.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  meson.build                    |  7 -----
>  rust/hw/timer/hpet/src/hpet.rs | 10 ++++++--
>  rust/qemu-api/src/timer.rs     | 47 ++++++++++++++++++++++++++--------
>  3 files changed, 44 insertions(+), 20 deletions(-)

...

>  impl Timer {
>      pub const MS: u32 = bindings::SCALE_MS;
>      pub const US: u32 = bindings::SCALE_US;
>      pub const NS: u32 = bindings::SCALE_NS;
> -    pub fn new() -> Self {
> -        Default::default()
> -    }
> -
> -    const fn as_mut_ptr(&self) -> *mut Self {
> -        self as *const Timer as *mut _
> +    /// Create a `Timer` struct without initializing it.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The timer must be initialized before it is armed with
> +    /// [`modify`](Self::modify).
> +    pub unsafe fn new() -> Self {
> +        // SAFETY: requirements relayed to callers of Timer::new
> +        Self(unsafe { Opaque::zeroed() })

We should use Opaque::uninit()? Because MaybeUninit::<bindings::QEMUTimer>::zeroed()
marks the timer as initialized, which disables MaybeUninit's ability to check for
initialization. e.g.,

// No compiling error or runtime panic
let t: MaybeUninit<bindings::QEMUTimer> = MaybeUninit::zeroed();
let _t = unsafe { t.assume_init() };

Further more, I spent some time trying to figure out if MaybeUninit in
Opaque<> could help identify UB caused by uninitialized Timer, but I found
it doesn't work. :-(

There're 2 cases:

// No compiling error or runtime panic
let mut v: UnsafeCell<MaybeUninit<bindings::QEMUTimer>> = UnsafeCell::new(MaybeUninit::uninit());
let _v = unsafe { v.get_mut().assume_init() };

// Runtime panic: Illegal instruction
let t: MaybeUninit<bindings::QEMUTimer> = MaybeUninit::uninit();
let _t = unsafe { t.assume_init() };

I understand that the outer UnsafeCell wrapper makes MaybeUninit's
checks not work.

But when I adjust MaybeUninit as the outer wrapper, the UB check can
work:

// Runtime panic: Illegal instruction
let v: MaybeUninit<UnsafeCell<bindings::QEMUTimer>> = MaybeUninit::uninit();
let _v = unsafe { v.assume_init() };

And there's another example:

https://doc.rust-lang.org/std/cell/struct.UnsafeCell.html#method.raw_get

Compared with linux's Opaque, it also puts MaybeUninit on the outermost
layer.

Emm, I guess now we have UnsafeCell<MaybeUninit<>> because interior
mutability is expected... but this layout breaks MaybeUninit's functionality.

> +    /// Create a new timer with the given attributes.
>      pub fn init_full<'timer, 'opaque: 'timer, T, F>(
> -        &'timer mut self,
> +        self: Pin<&'timer mut Self>,
>          timer_list_group: Option<&TimerListGroup>,
>          clk_type: ClockType,
>          scale: u32,
> @@ -51,7 +71,7 @@ pub fn init_full<'timer, 'opaque: 'timer, T, F>(
>          // SAFETY: the opaque outlives the timer
>          unsafe {
>              timer_init_full(
> -                self,
> +                self.as_mut_ptr(),
>                  if let Some(g) = timer_list_group {
>                      g as *const TimerListGroup as *mut _
>                  } else {
> @@ -67,14 +87,19 @@ pub fn init_full<'timer, 'opaque: 'timer, T, F>(
>      }
>      pub fn modify(&self, expire_time: u64) {
> +        // SAFETY: the only way to obtain a Timer safely is via methods that
> +        // take a Pin<&mut Self>, therefore the timer is pinned

The SAFETY should also be ensured by MaybeUninit, I think. But I haven't
verified if MaybeUninit<UnsafeCell<>> can work on FFI case...

>          unsafe { timer_mod(self.as_mut_ptr(), expire_time as i64) }
>      }
>      pub fn delete(&self) {
> +        // SAFETY: the only way to obtain a Timer safely is via methods that
> +        // take a Pin<&mut Self>, therefore the timer is pinned
>          unsafe { timer_del(self.as_mut_ptr()) }
>      }
>  }
> +// FIXME: use something like PinnedDrop from the pinned_init crate
>  impl Drop for Timer {
>      fn drop(&mut self) {
>          self.delete()
> -- 
> 2.48.1
> 
> 
> 

