Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 683E8E7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 08:36:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM18k-0003PI-JY; Fri, 13 Dec 2024 03:35:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tM18j-0003Oj-AT; Fri, 13 Dec 2024 03:35:13 -0500
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tM18d-0008OD-Ge; Fri, 13 Dec 2024 03:35:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1734078907; x=1765614907;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=YaE4IkK5AV+coszAICjl/n893OwhkcIehAwDV4r7L5Y=;
 b=OH4Bdy9HYnuYIdzzDIZy39cuZVQXcb7V2XYtHBBVsd1IQi5BWLO5e4Aq
 4i82TkFUy83mfnIglZvUAu54SXUtZEKQPol7SL/s3IREao/9XN/W6v8i6
 74tdX4kO2LNZhfzcbY2AOryBMtmaXEVpeGGNXpGHoHylWFN8laRAbpMZS
 LWM7+xsK0gl730T5RDiYsEudbE+9un2lHKh81DdsnEl4LeRQOQrFzTQuq
 ptQBLE92oPJgMnF/AkoBSXYdBQFHCPJBf28v8GN/yu9+uvr4b8gIQy2ux
 PtpbOXCUC9roP4iS4YsQ809NYrFnvHzG1prap/4KgxRRkxRwi2uul++gF A==;
X-CSE-ConnectionGUID: Ukq8+HRbTMau7yQCONDn2Q==
X-CSE-MsgGUID: I5bc4yXnTnqyfqz6/OJYPg==
X-IronPort-AV: E=McAfee;i="6700,10204,11284"; a="56997677"
X-IronPort-AV: E=Sophos;i="6.12,230,1728975600"; d="scan'208";a="56997677"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Dec 2024 00:35:03 -0800
X-CSE-ConnectionGUID: S9E/mUSpQdirWdjDlM+/Bw==
X-CSE-MsgGUID: n6p+iwYqRQ2LZj5jPgMrWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,230,1728975600"; d="scan'208";a="127287537"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa002.jf.intel.com with ESMTP; 13 Dec 2024 00:35:02 -0800
Date: Fri, 13 Dec 2024 16:53:17 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-rust@nongnu.org,
 Junjie Mao <junjie.mao@hotmail.com>
Subject: Re: [PATCH 14/26] rust: qom: move bridge for TypeInfo functions out
 of pl011
Message-ID: <Z1v1/WswJ+rNU5th@intel.com>
References: <20241209123717.99077-1-pbonzini@redhat.com>
 <20241209123717.99077-15-pbonzini@redhat.com>
 <Z1hjX+5Yyi46N+sX@intel.com>
 <ada60844-546a-42ca-a05f-7b6dc225ff53@redhat.com>
 <Z1lGZdXsVR5ra4hl@intel.com>
 <CABgObfbs57rVNU4jTwUbPeZEbvEKpVPAZj0Pd8OF75D8ojQEMQ@mail.gmail.com>
 <Z1nEUmzHa5dA5C0d@intel.com>
 <CABgObfY0T1N5-6ZwMWERsptEXHYhWnZP=TABGt3iovjtM3uWBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABgObfY0T1N5-6ZwMWERsptEXHYhWnZP=TABGt3iovjtM3uWBA@mail.gmail.com>
Received-SPF: pass client-ip=198.175.65.9; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.496,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

> I see -- though, thinking more about it, since you have
> 
>     fn init_timer(&mut self) {
>         let raw_ptr: *mut HPETState = self;
> 
>         for i in 0..HPET_MAX_TIMERS {
>             let mut timer = self.get_timer(i).borrow_mut();
>             timer.init(i, raw_ptr).init_timer_with_state();
>         }
>     }
> 
> It seems to me that you can do everything in instance_init. Later on a
> function like the above
> will become something like
> 
> impl HPETTimer {
>     fn init_timer(hpet: NonNull<HPETState>, n: usize) -> impl PinInit<Self> {

Thank you! I should pass NonNull type other than `*mut HPETState` for now :-)

>         pin_init!(&this in HPETTimer {
>             index: n,
>             qemu_timer <- Timer::init_ns(...),
>             state: hpet,
>             config: 0,
>             cmp: 0,
>             fsb: 0,
>             cmp64: 0,
>             period: 0,
>             wrap_flag: false,
>             last: 0,
>         }
>     }
> }

That's the right and ideal way, and I like it.

> But even now you can write something that takes a &mut self as the
> first argument. It's undefined behavior but it's okay as long as we
> have a path forward.

Yes, I agree. In the next version, I can follow your suggestion and put
these embedded items into instance_init(), to be better prepared for the
next step.

> > > > > The way that this will become safe is to use the pinned_init crate from
> > > > > Linux: instance_init returns the initialization as an "impl
> > > > PinInit<Self>",
> > > >
> > > > Then do we need to place OBJECT in some suitable memory location (Box or
> > > > something) for Rust implementation?
> > > >
> > >
> > > Allocation is still done by the C code, so I am not sure I understand the
> > > question. Rust code allocates QOM objects with object_new() so they are
> > > malloc-ed.
> >
> > Sorry, I'm not familiar enough with this piece...I have the question
> > because PinInit doc said "you will need a suitable memory location that
> > can hold a T. This can be KBox<T>, Arc<T>, UniqueArc<T> or even the
> > stack (see stack_pin_init!)."
> 
> Ah, I see. You can use __pinned_init directly on the memory that is
> passed to rust_instance_init. See for example the implementation of
> InPlaceWrite for Box
> (https://docs.rs/pinned-init/latest/src/pinned_init/lib.rs.html#1307).

Thank you! I understand your intention. A similar implementation would
also be quite natural in rust_instance_init.

> > I see that the core point is ensuring that structures cannot be moved.
> > Given that object_new() on the C side ensures that the allocated object
> > will not be moved, Rust side does not need to worry about pinning, correct?
> 
> Sort of... You still need to worry about it for two reasons:
> 
> 1) if you have &mut Self you can move values out of the object using
> e.g. mem::replace or mem::swap. Those would move the value in memory
> and cause trouble (think of moving a QEMUTimer while it is pointed to
> by the QEMUTimerList). This is solved by 1) using &Self all the time +
> interior mutability

With your help and through our discussions, I have gained a clearer
understanding of this intention.

> 2) using pinned_init's "PinnedDrop" functionality,
> because &Self can be used in QEMU-specific APIs but (obviously) not in
> the built-in Drop trait.
> 
> 2) right now marking something as pinned is an indirect way to tell
> the compiler and miri that there are external references to it. For a
> longer discussion you can read
> https://crates.io/crates/pinned-aliasable or
> https://gist.github.com/Darksonn/1567538f56af1a8038ecc3c664a42462.

Thanks for sharing!

> Linux does this with a wrapper type similar to the one in pinned-aliasable:
> 
> /// Stores an opaque value.
> ///
> /// This is meant to be used with FFI objects that are never
> interpreted by Rust code.
> #[repr(transparent)]
> pub struct Opaque<T> {
>     value: UnsafeCell<MaybeUninit<T>>,
>     _pin: PhantomPinned,
> }
> 
> It's on my todo list to introduce it in qemu_api::cell and (for
> example) change qom::Object from
> 
>     pub use bindings::Object
> 
> to
> 
>     pub type Object = Opaque<bindings::Object>;
> 
> Or something like that.

Yes, I agree with this idea. It's what we need.

Regards,
Zhao


