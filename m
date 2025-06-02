Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B484C54FB3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 13:19:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uM53t-000691-Ag; Mon, 02 Jun 2025 09:18:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uM53o-00068e-Ee
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 09:18:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uM53h-0002vh-MB
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 09:18:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748870312;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=br6+UQ/WWb9DT1SvkpVgbkb2RvCODV2LYUq8vHX/r1Q=;
 b=CYT6FklcTU3072BNx3s0qJtxmo4McBOEi0STGjsH6tYoc74C1YFfSTPwphBIfxvbGlyWc1
 KFFVYV600L6Tn8De8NZl1cTs07VhQtKmxtEKIvaPU0U0qJ3Is7dg85dhxi0r/0r4+0BNpS
 1XRTFHEXMypcwMURQ3Oo2ZwnYCVLK/c=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-397-Hh0B9DaZMiWNgsRjlarxQQ-1; Mon,
 02 Jun 2025 09:18:28 -0400
X-MC-Unique: Hh0B9DaZMiWNgsRjlarxQQ-1
X-Mimecast-MFC-AGG-ID: Hh0B9DaZMiWNgsRjlarxQQ_1748870308
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A973318001CA; Mon,  2 Jun 2025 13:18:27 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.38])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 216B21954191; Mon,  2 Jun 2025 13:18:27 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 74F2621E66C3; Mon, 02 Jun 2025 15:18:24 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,  qemu-rust@nongnu.org
Subject: Re: [PATCH 06/14] rust: qemu-api: add bindings to Error
In-Reply-To: <20250530080307.2055502-7-pbonzini@redhat.com> (Paolo Bonzini's
 message of "Fri, 30 May 2025 10:02:58 +0200")
References: <20250530080307.2055502-1-pbonzini@redhat.com>
 <20250530080307.2055502-7-pbonzini@redhat.com>
Date: Mon, 02 Jun 2025 15:18:24 +0200
Message-ID: <877c1uffj3.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.015,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Paolo Bonzini <pbonzini@redhat.com> writes:

> Provide an implementation of std::error::Error that bridges the Rust
> anyhow::Error and std::panic::Location types with QEMU's Error*.
> It also has several utility methods, analogous to error_propagate(),
> that convert a Result into a return value + Error** pair.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

[...]

> diff --git a/rust/qemu-api/src/error.rs b/rust/qemu-api/src/error.rs
> new file mode 100644
> index 00000000000..0bdd413a0a2
> --- /dev/null
> +++ b/rust/qemu-api/src/error.rs
> @@ -0,0 +1,299 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +//! Error propagation for QEMU Rust code
> +//!
> +//! In QEMU, an `Error` usually consists of a message and an errno value.

Uh, it actually consists of a message and an ErrorClass value.  However,
use of anything but ERROR_CLASS_GENERIC_ERROR is strongly discouraged.
Historical reasons...

You completely ignore ErrorClass in your Rust interface.  I approve.

There are convenience functions that accept an errno, but they don't
store the errno in the Error struct, they append ": " and
strerror(errno) to the message.  Same for Windows GetLastError() values.

> +//! In this wrapper, the errno value is replaced by an [`anyhow::Error`]

I'm not sure the anyhow::Error replaces anything.  It's simply the
bridge to idiomatic Rust errors.

> +//! so that it is easy to pass any other Rust error type up to C code.

This is true.

> +//! Note that the backtrace that is provided by `anyhow` is not used yet,
> +//! only the message ends up in the QEMU `Error*`.
> +//!
> +//! The message part can be used to clarify the inner error, similar to
> +//! `error_prepend`, and of course to describe an erroneous condition th=
at

Clarify you're talking about C error_prepend() here?

> +//! does not come from another [`Error`](std::error::Error) (for example=
 an
> +//! invalid argument).
> +//!
> +//! On top of implementing [`std::error::Error`], [`Error`] provides fun=
ctions

Suggest to wrap comments a bit earlier.

> +//! to simplify conversion between [`Result<>`](std::result::Result) and
> +//! C `Error**` conventions.  In particular:
> +//!
> +//! * [`ok_or_propagate`](qemu_api::Error::ok_or_propagate),
> +//!   [`bool_or_propagate`](qemu_api::Error::bool_or_propagate),
> +//!   [`ptr_or_propagate`](qemu_api::Error::ptr_or_propagate) can be use=
d to
> +//!   build a C return value while also propagating an error condition
> +//!
> +//! * [`err_or_else`](qemu_api::Error::err_or_else) and
> +//!   [`err_or_unit`](qemu_api::Error::err_or_unit) can be used to build=
 a
> +//!   `Result`
> +//!
> +//! While these facilities are useful at the boundary between C and Rust=
 code,
> +//! other Rust code need not care about the existence of this module; it=
 can
> +//! just use the [`qemu_api::Result`] type alias and rely on the `?` ope=
rator as
> +//! usual.
> +//!
> +//! @author Paolo Bonzini
> +
> +use std::{
> +    borrow::Cow,
> +    ffi::{c_char, c_int, c_void, CStr},
> +    fmt::{self, Display},
> +    panic, ptr,
> +};
> +
> +use foreign::{prelude::*, OwnedPointer};
> +
> +use crate::bindings;
> +
> +pub type Result<T> =3D std::result::Result<T, Error>;
> +
> +#[derive(Debug)]
> +pub struct Error {
> +    msg: Option<Cow<'static, str>>,
> +    /// Appends the print string of the error to the msg if not None
> +    cause: Option<anyhow::Error>,
> +    file: &'static str,
> +    line: u32,
> +}
> +
> +impl std::error::Error for Error {
> +    fn source(&self) -> Option<&(dyn std::error::Error + 'static)> {
> +        self.cause.as_ref().map(AsRef::as_ref)
> +    }
> +
> +    #[allow(deprecated)]
> +    fn description(&self) -> &str {
> +        self.msg
> +            .as_deref()
> +            .or_else(|| self.cause.as_deref().map(std::error::Error::des=
cription))
> +            .unwrap_or("unknown error")

Can "unknown error" still happen now you dropped the Default trait?

> +    }
> +}
> +
> +impl Display for Error {
> +    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
> +        let mut prefix =3D "";
> +        if let Some(ref msg) =3D self.msg {
> +            write!(f, "{msg}")?;
> +            prefix =3D ": ";
> +        }
> +        if let Some(ref cause) =3D self.cause {
> +            write!(f, "{prefix}{cause}")?;
> +        } else if prefix.is_empty() {
> +            f.write_str("unknown error")?;

Can we still get here now you dropped the Default trait?

> +        }
> +        Ok(())
> +    }
> +}
> +
> +impl From<String> for Error {
> +    #[track_caller]
> +    fn from(msg: String) -> Self {
> +        let location =3D panic::Location::caller();
> +        Error {
> +            msg: Some(Cow::Owned(msg)),
> +            cause: None,
> +            file: location.file(),
> +            line: location.line(),
> +        }
> +    }
> +}
> +
> +impl From<&'static str> for Error {
> +    #[track_caller]
> +    fn from(msg: &'static str) -> Self {
> +        let location =3D panic::Location::caller();
> +        Error {
> +            msg: Some(Cow::Borrowed(msg)),
> +            cause: None,
> +            file: location.file(),
> +            line: location.line(),
> +        }
> +    }
> +}
> +
> +impl From<anyhow::Error> for Error {
> +    #[track_caller]
> +    fn from(error: anyhow::Error) -> Self {
> +        let location =3D panic::Location::caller();
> +        Error {
> +            msg: None,
> +            cause: Some(error),
> +            file: location.file(),
> +            line: location.line(),
> +        }
> +    }
> +}
> +
> +impl Error {
> +    /// Create a new error, prepending `msg` to the
> +    /// description of `cause`
> +    #[track_caller]
> +    pub fn with_error(msg: impl Into<Cow<'static, str>>, cause: impl Int=
o<anyhow::Error>) -> Self {
> +        let location =3D panic::Location::caller();
> +        Error {
> +            msg: Some(msg.into()),
> +            cause: Some(cause.into()),
> +            file: location.file(),
> +            line: location.line(),
> +        }
> +    }
> +
> +    /// Consume a result, returning `false` if it is an error and
> +    /// `true` if it is successful.  The error is propagated into
> +    /// `errp` like the C API `error_propagate` would do.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `errp` must be a valid argument to `error_propagate`;
> +    /// typically it is received from C code and need not be
> +    /// checked further at the Rust=E2=86=94C boundary.
> +    pub unsafe fn bool_or_propagate(result: Result<()>, errp: *mut *mut =
bindings::Error) -> bool {
> +        // SAFETY: caller guarantees errp is valid
> +        unsafe { Self::ok_or_propagate(result, errp) }.is_some()
> +    }
> +
> +    /// Consume a result, returning a `NULL` pointer if it is an
> +    /// error and a C representation of the contents if it is
> +    /// successful.  The error is propagated into `errp` like
> +    /// the C API `error_propagate` would do.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `errp` must be a valid argument to `error_propagate`;
> +    /// typically it is received from C code and need not be
> +    /// checked further at the Rust=E2=86=94C boundary.
> +    #[must_use]
> +    pub unsafe fn ptr_or_propagate<T: CloneToForeign>(
> +        result: Result<T>,
> +        errp: *mut *mut bindings::Error,
> +    ) -> *mut T::Foreign {
> +        // SAFETY: caller guarantees errp is valid
> +        unsafe { Self::ok_or_propagate(result, errp) }.clone_to_foreign_=
ptr()
> +    }
> +
> +    /// Consume a result in the same way as `self.ok()`, but also propag=
ate
> +    /// a possible error into `errp`, like the C API `error_propagate`
> +    /// would do.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `errp` must be a valid argument to `error_propagate`;
> +    /// typically it is received from C code and need not be
> +    /// checked further at the Rust=E2=86=94C boundary.
> +    pub unsafe fn ok_or_propagate<T>(
> +        result: Result<T>,
> +        errp: *mut *mut bindings::Error,
> +    ) -> Option<T> {
> +        result.map_err(|err| unsafe { err.propagate(errp) }).ok()
> +    }
> +
> +    /// Equivalent of the C function `error_propagate`.  Fill `*errp`

Uh, is it?  Let's see...

> +    /// with the information container in `self` if `errp` is not NULL;
> +    /// then consume it.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `errp` must be a valid argument to `error_propagate`;

Reminder for later: the valid @errp arguments for C error_propagate()
are

* NULL

* &error_abort

* &error_fatal

* Address of some Error * variable containing NULL

* Address of some Error * variable containing non-NULL

The last one is *not* valid with error_setg().

> +    /// typically it is received from C code and need not be
> +    /// checked further at the Rust=E2=86=94C boundary.
> +    pub unsafe fn propagate(self, errp: *mut *mut bindings::Error) {

Reminder, just to avoid confusion: C error_propagate() has the arguments
in the opposite order.

> +        if errp.is_null() {
> +            return;
> +        }
> +
> +        let err =3D self.clone_to_foreign_ptr();
> +
> +        // SAFETY: caller guarantees errp is valid
> +        unsafe {
> +            errp.write(err);
> +        }
> +    }

In C, we have two subtly different ways to store into some Error **errp
argument: error_setg() and error_propagate().

Their obvious difference is that error_setg() creates the Error object
to store, while error_propagate() stores an existing Error object if
any, else does nothing.

Their unobvious difference is behavior when the destination already
contains an Error.  With error_setg(), this must not happen.
error_propagate() instead throws away the new error.  This permits
"first one wins" error accumulation.  Design mistake if you ask me.

Your Rust propagate() also stores an existing bindings::Error.  Note
that "else does nothing" doesn't apply, because we always have an
existing error object here, namely @self.  In the error_propagate() camp
so far.

Let's examine the other aspect: how exactly "storing" behaves.

error_setg() according to its contract:

    If @errp is NULL, the error is ignored.  [...]

    If @errp is &error_abort, print a suitable message and abort().

    If @errp is &error_fatal, print a suitable message and exit(1).

    If @errp is anything else, *@errp must be NULL.

error_propagate() according to its contract:

    [...] if @dst_errp is NULL, errors are being ignored.  Free the
    error object.

    Else, if @dst_errp is &error_abort, print a suitable message and
    abort().

    Else, if @dst_errp is &error_fatal, print a suitable message and
    exit(1).

    Else, if @dst_errp already contains an error, ignore this one: free
    the error object.

    Else, move the error object from @local_err to *@dst_errp.

The second to last clause is where its storing differs from
error_setg().

What does errp.write(err) do?  I *guess* it simply stores @err in @errp.
Matches neither behavior.

If that's true, then passing &error_abort or &error_fatal to Rust does
not work, and neither does error accumulation.  Not equivalent of C
error_propagate().

Is "propagate" semantics what you want here?

If not, use another name.

> +
> +    /// Convert a C `Error*` into a Rust `Result`, using
> +    /// `Ok(())` if `c_error` is NULL.  Free the `Error*`.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `c_error` must be `NULL` or valid; typically it was initialized

Double-checking: "valid" means it points to struct Error.

> +    /// with `ptr::null_mut()` and passed by reference to a C function.
> +    pub unsafe fn err_or_unit(c_error: *mut bindings::Error) -> Result<(=
)> {
> +        // SAFETY: caller guarantees c_error is valid
> +        unsafe { Self::err_or_else(c_error, || ()) }
> +    }
> +
> +    /// Convert a C `Error*` into a Rust `Result`, calling `f()` to
> +    /// obtain an `Ok` value if `c_error` is NULL.  Free the `Error*`.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `c_error` must be `NULL` or valid; typically it was initialized
> +    /// with `ptr::null_mut()` and passed by reference to a C function.
> +    pub unsafe fn err_or_else<T, F: FnOnce() -> T>(
> +        c_error: *mut bindings::Error,
> +        f: F,
> +    ) -> Result<T> {
> +        // SAFETY: caller guarantees c_error is valid
> +        let err =3D unsafe { Option::<Self>::from_foreign(c_error) };
> +        match err {
> +            None =3D> Ok(f()),
> +            Some(err) =3D> Err(err),
> +        }
> +    }
> +}
> +
> +impl FreeForeign for Error {
> +    type Foreign =3D bindings::Error;
> +
> +    unsafe fn free_foreign(p: *mut bindings::Error) {
> +        // SAFETY: caller guarantees p is valid
> +        unsafe {
> +            bindings::error_free(p);
> +        }
> +    }
> +}
> +
> +impl CloneToForeign for Error {
> +    fn clone_to_foreign(&self) -> OwnedPointer<Self> {
> +        // SAFETY: all arguments are controlled by this function
> +        unsafe {
> +            let err: *mut c_void =3D libc::malloc(std::mem::size_of::<bi=
ndings::Error>());
> +            let err: &mut bindings::Error =3D &mut *err.cast();
> +            *err =3D bindings::Error {
> +                msg: format!("{self}").clone_to_foreign_ptr(),
> +                err_class: bindings::ERROR_CLASS_GENERIC_ERROR,
> +                src_len: self.file.len() as c_int,
> +                src: self.file.as_ptr().cast::<c_char>(),
> +                line: self.line as c_int,
> +                func: ptr::null_mut(),
> +                hint: ptr::null_mut(),
> +            };
> +            OwnedPointer::new(err)
> +        }
> +    }
> +}
> +
> +impl FromForeign for Error {
> +    unsafe fn cloned_from_foreign(c_error: *const bindings::Error) -> Se=
lf {
> +        // SAFETY: caller guarantees c_error is valid
> +        unsafe {
> +            let error =3D &*c_error;
> +            let file =3D if error.src_len < 0 {
> +                // NUL-terminated
> +                CStr::from_ptr(error.src).to_str()
> +            } else {
> +                // Can become str::from_utf8 with Rust 1.87.0
> +                std::str::from_utf8(std::slice::from_raw_parts(
> +                    &*error.src.cast::<u8>(),
> +                    error.src_len as usize,
> +                ))
> +            };
> +
> +            Error {
> +                msg: FromForeign::cloned_from_foreign(error.msg),
> +                cause: None,
> +                file: file.unwrap(),
> +                line: error.line as u32,
> +            }
> +        }
> +    }
> +}
> diff --git a/rust/qemu-api/src/lib.rs b/rust/qemu-api/src/lib.rs
> index 234a94e3c29..93902fc94bc 100644
> --- a/rust/qemu-api/src/lib.rs
> +++ b/rust/qemu-api/src/lib.rs
> @@ -19,6 +19,7 @@
>  pub mod cell;
>  pub mod chardev;
>  pub mod errno;
> +pub mod error;
>  pub mod irq;
>  pub mod memory;
>  pub mod module;
> @@ -34,6 +35,8 @@
>      ffi::c_void,
>  };
>=20=20
> +pub use error::{Error, Result};
> +
>  #[cfg(HAVE_GLIB_WITH_ALIGNED_ALLOC)]
>  extern "C" {
>      fn g_aligned_alloc0(


