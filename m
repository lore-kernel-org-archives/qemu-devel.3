Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07DA5C021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 08:33:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmqMv-000354-QZ; Tue, 25 Feb 2025 03:32:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tmqMs-00033f-KW; Tue, 25 Feb 2025 03:32:42 -0500
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tmqMq-0005pQ-AB; Tue, 25 Feb 2025 03:32:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740472361; x=1772008361;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=oXJaA35bR33V9to2KnGqgUZArNmmJdOABbqLVcCkd18=;
 b=YUrE0zzwePAHprY/v/0CrkQCMO5deYNmZAXMHiNBVvVLxD7XMp2T1QaD
 4lybIozrvOkhxjNquaCBKpmh8IGbgP1YH2IBB4STJY7NmpZuQwpmiUGpt
 SmuyfC4bM8kZ2lYfFKcBIg5azaPfRHAXR3OjQFTIxr2q2W95+7/xyaqvQ
 5H37JEKohRFwrbIX5z+anjIsQr34VH35tQWJLP3mPg4GT1y3NZuSf+URZ
 I2QSeQ1NFR4p9MNiLO3G4/XqIzNiBwo7EwikupSYV4jch+kCIFjv9rPrH
 HLyYujZWI6ZpLqYKyghL9aCDjdEaaw4Llf5KMQduMnAtxCeKM7xkqbtCR w==;
X-CSE-ConnectionGUID: aESu0RfRR2ixt7YtlaDSeA==
X-CSE-MsgGUID: rVtvzi48Rrix3oYH8UjNKQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="41285105"
X-IronPort-AV: E=Sophos;i="6.13,313,1732608000"; d="scan'208";a="41285105"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2025 00:32:38 -0800
X-CSE-ConnectionGUID: yEPIEPz3RIKu0vFe2H4VHg==
X-CSE-MsgGUID: TdXaUyQnRFCQ1C5tSmyb4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,313,1732608000"; d="scan'208";a="116095284"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa009.jf.intel.com with ESMTP; 25 Feb 2025 00:32:36 -0800
Date: Tue, 25 Feb 2025 16:52:13 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 11/15] rust: qdev: wrap Clock and DeviceState with Opaque<>
Message-ID: <Z72EvUcb2hWxknpw@intel.com>
References: <20250221170342.63591-1-pbonzini@redhat.com>
 <20250221170342.63591-12-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221170342.63591-12-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.17; envelope-from=zhao1.liu@intel.com;
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

> -unsafe extern "C" fn rust_realize_fn<T: DeviceImpl>(dev: *mut DeviceState, _errp: *mut *mut Error) {
> +unsafe extern "C" fn rust_realize_fn<T: DeviceImpl>(
> +    dev: *mut bindings::DeviceState,
> +    _errp: *mut *mut Error,
> +) {
>      let state = NonNull::new(dev).unwrap().cast::<T>();
>      T::REALIZE.unwrap()(unsafe { state.as_ref() });
>  }
> @@ -251,7 +270,7 @@ fn init_clock_in<F: for<'a> FnCall<(&'a Self::Target, ClockEvent)>>(
>          events: ClockEvent,
>      ) -> Owned<Clock> {
>          fn do_init_clock_in(
> -            dev: *mut DeviceState,
> +            dev: &DeviceState,
>              name: &str,
>              cb: Option<unsafe extern "C" fn(*mut c_void, ClockEvent)>,
>              events: ClockEvent,
> @@ -265,14 +284,15 @@ fn do_init_clock_in(
>              unsafe {
>                  let cstr = CString::new(name).unwrap();
>                  let clk = bindings::qdev_init_clock_in(
> -                    dev,
> +                    dev.0.as_mut_ptr(),

This can be simplfied as dev.as_mut_ptr().

>                      cstr.as_ptr(),
>                      cb,
> -                    dev.cast::<c_void>(),
> +                    dev.0.as_void_ptr(),

If Wrapper provides as_void_ptr(), then this can also be simplified.

>                      events.0,
>                  );
>  
> -                Owned::from(&*clk)
> +                let clk: &Clock = Clock::from_raw(clk);
> +                Owned::from(clk)
>              }
>          }

LGTM,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


