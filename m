Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E30A7C021B3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 10:42:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlQTV-0002JJ-EV; Fri, 21 Feb 2025 05:41:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tlQTT-0002Ig-HT
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 05:41:39 -0500
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tlQTR-0001lx-4T
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 05:41:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740134497; x=1771670497;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=nUtWMIndr5zkpXIRxh+/VIc9lT8JL+dI8djwCGRbtAQ=;
 b=QP0qPLW000X6f7HFwhsxu642+DH6UBCpRB72nU/NWLwO2ktX3vMZQGff
 7MI/DG34ZNcCFeKGyScq06OgJFmqkYhRHf4SgB1yueohD77mdWbOEtOgg
 /Y5pPfCLHHE2yEqKCx98PwscpAt69XYbfVmviIRc9dJBYdYdoZxdmu2WQ
 v1D96hKCujKA674mqZoKG/fEwaml81/7YoRbq+BVIsKGIzlSHeyiOluvz
 EGL3LXQ/QwzvMs2pU4lQMgB55cTdUkw35J1HX+buuqmkUydf281wHPGPL
 QuOb9EXHJhtNGAdwrDamNKtBjdFyWengtM01N3J11+BNzebKWsERy/Qzg Q==;
X-CSE-ConnectionGUID: 3+2kIqpUTtizCsyWUznm1A==
X-CSE-MsgGUID: LCXUn7crSemC1e5DLGlVtg==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="66312656"
X-IronPort-AV: E=Sophos;i="6.13,304,1732608000"; d="scan'208";a="66312656"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Feb 2025 02:41:32 -0800
X-CSE-ConnectionGUID: ffSF16yJTa2/e39jpLgNGw==
X-CSE-MsgGUID: WNdErkdjR3ukExmCFCVtxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,304,1732608000"; d="scan'208";a="115979040"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa009.fm.intel.com with ESMTP; 21 Feb 2025 02:41:32 -0800
Date: Fri, 21 Feb 2025 19:01:07 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com
Subject: Re: [PATCH v3 2/2] rust: add module to convert between
 success/-errno and io::Result
Message-ID: <Z7hc8+h+mGnT7CSh@intel.com>
References: <20250220113659.863332-1-pbonzini@redhat.com>
 <20250220113659.863332-3-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250220113659.863332-3-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.7; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.457,
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

Hi Paolo,

> It is a common convention in QEMU to return a positive value in case of
> success, and a negated errno value in case of error.  Unfortunately,
> using errno portably in Rust is a bit complicated; on Unix the errno
> values are supported natively by io::Error, but on Windows they are not;
> so, use the libc crate.

I'm a bit confused. The doc of error.h just said the negative value for
failure:

• integer-valued functions return non-negative / negative.

Why do we need to using libc's -errno for Windows as well?

Converting `io::Error::last_os_error().raw_os_error().unwrap()` to a
negative value seems compatible with Windows, except it returns Windows
error codes.

> This is a set of utility functions that are used by both chardev and
> block layer bindings.

...

> +// On Unix, from_raw_os_error takes an errno value and OS errors
> +// are printed using strerror.  On Windows however it takes a
> +// GetLastError() value; therefore we need to convert errno values
> +// into io::Error by hand.  This is the same mapping that the
> +// standard library uses to retrieve the kind of OS errors
> +// (`std::sys::pal::unix::decode_error_kind`).
> +impl From<Errno> for ErrorKind {
> +    fn from(value: Errno) -> ErrorKind {

What about `use ErrorKind::*;` to oimt the following "ErrorKind::"
prefix?

> +        let Errno(errno) = value;
> +        match i32::from(errno) {

Maybe `match i32::from(errno.0)` ?

> +            libc::EPERM | libc::EACCES => ErrorKind::PermissionDenied,
> +            libc::ENOENT => ErrorKind::NotFound,
> +            libc::EINTR => ErrorKind::Interrupted,
> +            x if x == libc::EAGAIN || x == libc::EWOULDBLOCK => ErrorKind::WouldBlock,
> +            libc::ENOMEM => ErrorKind::OutOfMemory,
> +            libc::EEXIST => ErrorKind::AlreadyExists,
> +            libc::EINVAL => ErrorKind::InvalidInput,
> +            libc::EPIPE => ErrorKind::BrokenPipe,
> +            libc::EADDRINUSE => ErrorKind::AddrInUse,
> +            libc::EADDRNOTAVAIL => ErrorKind::AddrNotAvailable,
> +            libc::ECONNABORTED => ErrorKind::ConnectionAborted,
> +            libc::ECONNREFUSED => ErrorKind::ConnectionRefused,
> +            libc::ECONNRESET => ErrorKind::ConnectionReset,
> +            libc::ENOTCONN => ErrorKind::NotConnected,
> +            libc::ENOTSUP => ErrorKind::Unsupported,
> +            libc::ETIMEDOUT => ErrorKind::TimedOut,
> +            _ => ErrorKind::Other,

Are these errno cases specifically selected? It seems to have fewer than
`decode_error_kind` lists. Why not support all the cases `decode_error_kind`
mentions? Or do we need to try to cover as many errno cases as possible
from rust/kernel/error.rs?

> +        }
> +    }
> +}
> +
> +// This is used on Windows for all io::Errors, but also on Unix if the
> +// io::Error does not have a raw OS error.  This is the reversed
> +// mapping of the above.

Maybe:

This is the "almost" reversed (except the default case) mapping

?

> +impl From<io::ErrorKind> for Errno {
> +    fn from(value: io::ErrorKind) -> Errno {

`use ErrorKind::*;` could save some words, too.

> +        let errno = match value {
> +            // can be both EPERM or EACCES :( pick one
> +            ErrorKind::PermissionDenied => libc::EPERM,
> +            ErrorKind::NotFound => libc::ENOENT,
> +            ErrorKind::Interrupted => libc::EINTR,
> +            ErrorKind::WouldBlock => libc::EAGAIN,
> +            ErrorKind::OutOfMemory => libc::ENOMEM,
> +            ErrorKind::AlreadyExists => libc::EEXIST,
> +            ErrorKind::InvalidInput => libc::EINVAL,
> +            ErrorKind::BrokenPipe => libc::EPIPE,
> +            ErrorKind::AddrInUse => libc::EADDRINUSE,
> +            ErrorKind::AddrNotAvailable => libc::EADDRNOTAVAIL,
> +            ErrorKind::ConnectionAborted => libc::ECONNABORTED,
> +            ErrorKind::ConnectionRefused => libc::ECONNREFUSED,
> +            ErrorKind::ConnectionReset => libc::ECONNRESET,
> +            ErrorKind::NotConnected => libc::ENOTCONN,
> +            ErrorKind::Unsupported => libc::ENOTSUP,
> +            ErrorKind::TimedOut => libc::ETIMEDOUT,
> +            _ => libc::EIO,
> +        };
> +        Errno(errno as u16)
> +    }
> +}
> +
> +impl From<Errno> for io::Error {
> +    #[cfg(unix)]
> +    fn from(value: Errno) -> io::Error {
> +        let Errno(errno) = value;
> +        io::Error::from_raw_os_error(errno.into())

Maybe `io::Error::from_raw_os_error(value.0.into())`?

> +    }
> +
> +    #[cfg(windows)]
> +    fn from(value: Errno) -> io::Error {
> +        let error_kind: ErrorKind = value.into();
> +        error_kind.into()

Even this works:

     fn from(value: Errno) -> io::Error {
-        let error_kind: ErrorKind = value.into();
-        error_kind.into()
+        value.into()

However, it's less readability, so I still prefer your current codes.
:-)

Thanks,
Zhao



