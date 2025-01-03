Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D0BDE7718F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2025 08:45:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTdI9-0000Of-BK; Fri, 03 Jan 2025 03:44:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tTdI3-0000OE-9r; Fri, 03 Jan 2025 03:44:20 -0500
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tTdHt-0005P3-19; Fri, 03 Jan 2025 03:44:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1735893849; x=1767429849;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=IP0N4rA9fC6fq0fvtdX//sG5i+5U7I47ylSvHqDyEoU=;
 b=RSKZfpnsReYQwb/D8eVXmRLImaGjdkFdEmlWYdSgAz7NvYXwGkBZ+adi
 D0br4kuv3+lqPECSlovCwxWpnZJrGQGuEF4snnNKww7aDP0AaYSzSZQu7
 0b8YMFWUZAg5s0Z94C+ilXdLbBzeEcz8scaD36+tG52ZhoNKppA6bMl7v
 mundTvLOTxpFZparN8XPAQhhEawj9/Dz9Biy1Ff7ACNk3idV9FXWYg1p8
 ZF3FEfIMxVZhzJmqMDUVuOvaF/MtBLBGgA5mj6Xa0qDOlF6c7cbEsNQPK
 /UkYUPIOPWiKLMGyEB0Z7c63i+UTYHrz3Uyip4/H+Zvkt9OB892RzqYgy Q==;
X-CSE-ConnectionGUID: VltXQhtaRjeA+c5A+Symqg==
X-CSE-MsgGUID: s52yw8YJRhGDrZ6PMysHkw==
X-IronPort-AV: E=McAfee;i="6700,10204,11303"; a="46814176"
X-IronPort-AV: E=Sophos;i="6.12,286,1728975600"; d="scan'208";a="46814176"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jan 2025 00:44:05 -0800
X-CSE-ConnectionGUID: i6Wf5Xj3SuyyazIYJ0vb1A==
X-CSE-MsgGUID: /ynekpAHQRWecY6s/LSe8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,286,1728975600"; d="scan'208";a="101577813"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa009.jf.intel.com with ESMTP; 03 Jan 2025 00:44:03 -0800
Date: Fri, 3 Jan 2025 17:02:49 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 qemu-rust@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PULL 25/41] rust: qom: put class_init together from multiple
 ClassInitImpl<>
Message-ID: <Z3enuYCHnKuiANmv@intel.com>
References: <20241219083228.363430-1-pbonzini@redhat.com>
 <20241219083228.363430-26-pbonzini@redhat.com>
 <daea6757-a67b-45d5-bf2a-807fd9569a70@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <daea6757-a67b-45d5-bf2a-807fd9569a70@linaro.org>
Received-SPF: pass client-ip=192.198.163.9; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.185,
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

> > -/// # Safety
> > -///
> > -/// We expect the FFI user of this function to pass a valid pointer that
> > -/// can be downcasted to type `DeviceClass`, because `T` implements
> > -/// `DeviceImpl`.
> > -pub unsafe extern "C" fn rust_device_class_init<T: DeviceImpl>(
> > -    klass: *mut ObjectClass,
> > -    _: *mut c_void,
> > -) {
> > -    let mut dc = ::core::ptr::NonNull::new(klass.cast::<DeviceClass>()).unwrap();
> > -    unsafe {
> > -        let dc = dc.as_mut();
> > +impl<T> ClassInitImpl<DeviceClass> for T
> > +where
> > +    T: DeviceImpl,
> > +{
> > +    fn class_init(dc: &mut DeviceClass) {
> >           if <T as DeviceImpl>::REALIZE.is_some() {
> >               dc.realize = Some(rust_realize_fn::<T>);
> >           }
> >           if <T as DeviceImpl>::RESET.is_some() {
> > -            bindings::device_class_set_legacy_reset(dc, Some(rust_reset_fn::<T>));
> > +            unsafe {
> > +                bindings::device_class_set_legacy_reset(dc, Some(rust_reset_fn::<T>));
> 
> Pre-existing, but since it appears on this patch, Rust device models
> should not implement this legacy interface. 

Rust pl011 is just faithful to the C functionality, and it's really time
to make the rust version drop the previous technical debt too! 

But I think this patch is OK for now since using legacy interface is the
most simplified approach, and next step we can consider how to convert
it to the modern interface with proper rust binding (my initial thought
tells me that there is at least some effort needed here to explore
whether a simple resettable trait would be enough...).

> If a non-Rust parent
> implements it, I think we should convert the non-Rust parent before
> adding a Rust child. No clue how to check a parent don't implement
> this interface in Rust.

For C side, I also didn't find some case to check parent's
legacy_reset before device_class_set_legacy_reset().

Maybe we should add `assert(!dc->legacy_reset)` in 
device_class_set_legacy_reset()?

Similarly, device_class_set_parent_[realize|unrealize] are worth
adding assert().

If you agree, I'd be happy to add assert() to these three functions as
well. :-)

> Generally, we shouldn't access legacy API from Rust IMHO.
> 
> > +            }
> >           }
> >           if let Some(vmsd) = <T as DeviceImpl>::vmsd() {
> >               dc.vmsd = vmsd;
> >           }
> >           let prop = <T as DeviceImpl>::properties();
> >           if !prop.is_empty() {
> > -            bindings::device_class_set_props_n(dc, prop.as_ptr(), prop.len());
> > +            unsafe {
> > +                bindings::device_class_set_props_n(dc, prop.as_ptr(), prop.len());
> > +            }
> >           }
> >       }
> >   }
> 

