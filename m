Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 131CDD3B997
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 14:38:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFwhZ-0000iQ-Bs; Tue, 26 Nov 2024 09:38:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tFwhX-0000i7-T1; Tue, 26 Nov 2024 09:38:04 -0500
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tFwhV-0004b4-8q; Tue, 26 Nov 2024 09:38:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1732631881; x=1764167881;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=tWnKBX6Qf1ceyQZF9SkLZLjcN5RoYjdfpd3Rs8PjOxc=;
 b=WgYG7kP8Re3jsX1UnCrY9AuUDCF/C1qj62PnYSLePFOlpczsnbaFVIrq
 3cm5vXBwOOgLVV7ytK5fazcLU9XUHtG8w66vMuGma4Dyg9eCZ5J58ZPzQ
 m3l5iIydjDGuqS3pzbh93Z3+9iJFIxDxjTMOO1DfbiGL+sjE4Kb511rXc
 sS2w/7PfDzwa42lviqqzn6h2CqEu8y2tUJ5NYxXbzKHn8goo2zIS75lqO
 MxOzLHarpPmnllY9wSaxT5Pm/eMJerSJmQllMqYw5vPJOip4uTz/Timfd
 tek1RefUapVrtof4VIUCux0aovUNlXkins6e43wlDPhEBH1EJ/6s0VOun Q==;
X-CSE-ConnectionGUID: zG7FD+OKQ8e/Gh4F42NSSg==
X-CSE-MsgGUID: miDrGnUcT22RmReSVgIT7w==
X-IronPort-AV: E=McAfee;i="6700,10204,11268"; a="36721890"
X-IronPort-AV: E=Sophos;i="6.12,186,1728975600"; d="scan'208";a="36721890"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2024 06:37:57 -0800
X-CSE-ConnectionGUID: 9hX/TuovTD2Hjv6AwdGBiA==
X-CSE-MsgGUID: Ee90qsKLTFS2vkXKsjdeMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,186,1728975600"; d="scan'208";a="91249842"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa006.fm.intel.com with ESMTP; 26 Nov 2024 06:37:55 -0800
Date: Tue, 26 Nov 2024 22:56:04 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, junjie.mao@hotmail.com, qemu-rust@nongnu.org
Subject: Re: [PATCH 1/2] rust: add BQL-enforcing Cell variant
Message-ID: <Z0XhhB48W4Nqagku@intel.com>
References: <20241122074756.282142-1-pbonzini@redhat.com>
 <20241122074756.282142-2-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241122074756.282142-2-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.12; envelope-from=zhao1.liu@intel.com;
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

On Fri, Nov 22, 2024 at 08:47:55AM +0100, Paolo Bonzini wrote:
> Date: Fri, 22 Nov 2024 08:47:55 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 1/2] rust: add BQL-enforcing Cell variant
> X-Mailer: git-send-email 2.47.0
> 
> QEMU objects usually have their pointer shared with the "outside
> world" very early in their lifetime, for example when they create their
> MemoryRegions.  Because at this point it is not valid anymore to
> create a &mut reference to the device, individual parts of the
> device struct must be made mutable in a controlled manner.

I try to understand this description with the words in v1 :) :

>> But this actually applies to _all_ of the device struct!  Once a
>> pointer to the device has been handed out (for example via
>> memory_region_init_io or qdev_init_clock_in), accesses to the device
>> struct must not use &mut anymore.

is the final goal to wrap the entire DeviceState into the
BQLRefCell as well?

> QEMU's Big Lock (BQL) effectively turns multi-threaded code into
> single-threaded code while device code runs, as long as the BQL is not
> released while the device is borrowed (because C code could sneak in and
> mutate the device).  We can then introduce custom interior mutability primitives
> that are semantically similar to the standard library's (single-threaded)
> Cell and RefCell, but account for QEMU's threading model.  Accessing
> the "BqlCell" or borrowing the "BqlRefCell" requires proving that the
> BQL is held, and attempting to access without the BQL is a runtime panic,
> similar to RefCell's already-borrowed panic.

This design is very clever and clear!

But I'm a little fuzzy on when to use it. And could you educate me on
whether there are any guidelines for determining which bindings should
be placed in the BQLCell, such as anything that might be shared?

...

> diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
> index d719c13f46d..edc21e1a3f8 100644
> --- a/rust/qemu-api/meson.build
> +++ b/rust/qemu-api/meson.build
> @@ -13,6 +13,7 @@ _qemu_api_rs = static_library(
>      [
>        'src/lib.rs',
>        'src/bindings.rs',
         ^^^^^^^^^^^^^^^^^

need to rebase :-)

> +      'src/cell.rs',
>        'src/c_str.rs',
>        'src/definitions.rs',
>        'src/device_class.rs',
> +        self.get().fmt(f)
> +    }
> +}

...

> +    /// Replaces the contained value with `val`, and returns the old contained
> +    /// value.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// use qemu_api::cell::BqlCell;
> +    ///
> +    /// let cell = BqlCell::new(5);
> +    /// assert_eq!(cell.get(), 5);
> +    /// assert_eq!(cell.replace(10), 5);
> +    /// assert_eq!(cell.get(), 10);
> +    /// ```
> +    #[inline]
> +    pub fn replace(&self, val: T) -> T {
> +        debug_assert!(bql_locked());

Could debug_assert() work? IIUC, it requires to pass `-C debug-assertions` to
compiler, but currently we don't support this flag in meson...

...so, should we add a debug option in meson configure?

> +        // SAFETY: This can cause data races if called from a separate thread,
> +        // but `BqlCell` is `!Sync` so this won't happen.
> +        mem::replace(unsafe { &mut *self.value.get() }, val)
> +    }
> +

Regards,
Zhao


