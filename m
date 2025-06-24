Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10728C7EE2A
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 07:00:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTxdY-00075y-9l; Tue, 24 Jun 2025 03:00:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uTxdU-00074X-OL; Tue, 24 Jun 2025 03:00:05 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uTxdS-0008HF-Im; Tue, 24 Jun 2025 03:00:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750748403; x=1782284403;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=RycR102Wtr4p7SMK586lhgFL+Zx3BzOWjdXsAILJ25s=;
 b=ai88y5FNIuQhfyWeW5slVIu50WX20yEYm7035WRe1RFtM98oOyjBarT1
 trjqfe/cQ9+bv6GzE/reK7MnGtfGETLoCpiiCwvcuRtZTjgi17k+DH9Um
 4SCtH4kdJyTJUrPrYy/nq3pIr5kadvhjTa0nDkynzK/aLyTQUVdzn18xG
 0hF5j882Q+NaJ7yCXhFPhEidcWaXh1QBim7EMqV8KM9xwT5hAetl2V3w4
 UgfSv3d2itt9O3H5X9bJyia3qB+avgiwZ8nfoAA6YISXgCSpBedvsUWu8
 P4HOlnnJjrGhZemtNWpJpyiuDe/6BV05ymLSTWg1Yn1g3BGbAA2N43Qro g==;
X-CSE-ConnectionGUID: dJ/mKxytQjyqluTkM3+0RQ==
X-CSE-MsgGUID: T+I8trecSjWiEGlAIc4iOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11473"; a="70397824"
X-IronPort-AV: E=Sophos;i="6.16,260,1744095600"; d="scan'208";a="70397824"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2025 00:00:00 -0700
X-CSE-ConnectionGUID: olZOwTzrS/eWuP2XHptNQw==
X-CSE-MsgGUID: bBLeFKxuTxymoVsO5Msp/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,260,1744095600"; d="scan'208";a="152532379"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa010.fm.intel.com with ESMTP; 23 Jun 2025 23:59:58 -0700
Date: Tue, 24 Jun 2025 15:21:19 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 manos.pitsidianakis@linaro.org, shentey@gmail.com
Subject: Re: [PATCH] rust: log: implement io::Write
Message-ID: <aFpR7+RMBlgt5DTD@intel.com>
References: <20250617081213.115329-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250617081213.115329-1-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.10; envelope-from=zhao1.liu@intel.com;
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

>  /// A macro to log messages conditionally based on a provided mask.
> @@ -24,6 +96,8 @@ pub enum Log {
>  /// log level and, if so, formats and logs the message. It is the Rust
>  /// counterpart of the `qemu_log_mask()` macro in the C implementation.
>  ///
> +/// Errors from writing to the log are ignored.
> +///
>  /// # Parameters
>  ///
>  /// - `$mask`: A log level mask. This should be a variant of the `Log` enum.
> @@ -62,12 +136,9 @@ macro_rules! log_mask_ln {
>          if unsafe {
>              (::qemu_api::bindings::qemu_loglevel & ($mask as std::os::raw::c_int)) != 0
>          } {
> -            let formatted_string = format!("{}\n", format_args!($fmt $($args)*));
> -            let c_string = std::ffi::CString::new(formatted_string).unwrap();
> -
> -            unsafe {
> -                ::qemu_api::bindings::qemu_log(c_string.as_ptr());
> -            }
> +            #[allow(unused_must_use)]

I found this doesn't work :-( :

error: unused `Result` that must be used
   --> ../rust/hw/char/pl011/src/device.rs:281:21
    |
281 |                     log_mask_ln!(Log::Unimp, "pl011: DMA not implemented");
    |                     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    |
    = note: this `Result` may be an `Err` variant, which should be handled
    = note: `-D unused-must-use` implied by `-D warnings`
    = help: to override `-D warnings` add `#[allow(unused_must_use)]`
    = note: this error originates in the macro `log_mask_ln` (in Nightly builds, run with -Z macro-backtrace for more info)

I understand meson sets `-D warings` so that `allow` can't work...

What about just ignoring the return value? Afterall pl011 doesn't care
the returned value.

@@ -136,8 +137,7 @@ macro_rules! log_mask_ln {
         if unsafe {
             (::qemu_api::bindings::qemu_loglevel & ($mask as std::os::raw::c_int)) != 0
         } {
-            #[allow(unused_must_use)]
-            ::qemu_api::log::LogGuard::log_fmt(
+            let _ = ::qemu_api::log::LogGuard::log_fmt(
                 format_args!("{}\n", format_args!($fmt $($args)*)));
         }
     }};

Thanks,
Zhao

> +            ::qemu_api::log::LogGuard::log_fmt(
> +                format_args!("{}\n", format_args!($fmt $($args)*)));
>          }
>      }};
>  }
> -- 
> 2.49.0
> 
> 

