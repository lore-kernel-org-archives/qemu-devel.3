Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2035C3ABB2
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 09:50:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKDQ6-0001j8-Gf; Wed, 28 May 2025 05:49:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uKDPt-0001eB-Rw
 for qemu-devel@nongnu.org; Wed, 28 May 2025 05:49:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uKDPp-0004bt-SN
 for qemu-devel@nongnu.org; Wed, 28 May 2025 05:49:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748425780;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/kuIqLJC0qU4Ia4Fp1mpUynwqTqdtoBftLqREcHOSSI=;
 b=N/7ecrMhAUVtKNy+rJcLyO57/ujNznH04e2ay1J/7DR4G2QkcXe9ongzRXNUuUbi1Pn7Qa
 gIwQMWQF+rqiPuYSRwMsdihPtJ6/pO68y6rBN1sQ/PDaUl5xFaG477+uF2GPrj77Q+CD5T
 wF+WIQI5HF2c45oSfVHoSJcUQERjv3Y=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-332-OzHtEBQhMgaTNAUSMOdaWw-1; Wed,
 28 May 2025 05:49:38 -0400
X-MC-Unique: OzHtEBQhMgaTNAUSMOdaWw-1
X-Mimecast-MFC-AGG-ID: OzHtEBQhMgaTNAUSMOdaWw_1748425777
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 91BFA1800446; Wed, 28 May 2025 09:49:37 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.2])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AE29C19560AA; Wed, 28 May 2025 09:49:36 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 00B4421E6757; Wed, 28 May 2025 11:49:33 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,  qemu-rust@nongnu.org
Subject: Re: [PATCH 07/12] qemu-api: add bindings to Error
In-Reply-To: <20250526142455.1061519-7-pbonzini@redhat.com> (Paolo Bonzini's
 message of "Mon, 26 May 2025 16:24:50 +0200")
References: <20250526142254.1061009-1-pbonzini@redhat.com>
 <20250526142455.1061519-7-pbonzini@redhat.com>
Date: Wed, 28 May 2025 11:49:33 +0200
Message-ID: <87o6vddpzm.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) DKIMWL_WL_HIGH=-2.907, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

My Rust-fu is far to weak for an actual review.  But let me try to
stumble through your patch.  I'll pretend to explain the Rust code to a
noob like myself.  Please correct my mistakes.

> ---
>  rust/Cargo.lock            |  17 +++
>  rust/Cargo.toml            |   1 +
>  rust/meson.build           |   2 +
>  rust/qemu-api/Cargo.toml   |   2 +
>  rust/qemu-api/meson.build  |   3 +-
>  rust/qemu-api/src/error.rs | 273 +++++++++++++++++++++++++++++++++++++
>  rust/qemu-api/src/lib.rs   |   3 +
>  7 files changed, 300 insertions(+), 1 deletion(-)
>  create mode 100644 rust/qemu-api/src/error.rs
>
> diff --git a/rust/Cargo.lock b/rust/Cargo.lock
> index 13d580c693b..37fd10064f9 100644
> --- a/rust/Cargo.lock
> +++ b/rust/Cargo.lock
> @@ -2,6 +2,12 @@
>  # It is not intended for manual editing.
>  version = 3
>  
> +[[package]]
> +name = "anyhow"
> +version = "1.0.98"
> +source = "registry+https://github.com/rust-lang/crates.io-index"
> +checksum = "e16d2d3311acee920a9eb8d33b8cbc1787ce4a264e85f964c2404b969bdcd487"
> +
>  [[package]]
>  name = "arbitrary-int"
>  version = "1.2.7"
> @@ -37,6 +43,15 @@ version = "1.12.0"
>  source = "registry+https://github.com/rust-lang/crates.io-index"
>  checksum = "3dca9240753cf90908d7e4aac30f630662b02aebaa1b58a3cadabdb23385b58b"
>  
> +[[package]]
> +name = "foreign"
> +version = "0.2.0"
> +source = "registry+https://github.com/rust-lang/crates.io-index"
> +checksum = "37dd09e47ea8fd592a333f59fc52b894a97fe966ae9c6b7ef21ae38de6043462"
> +dependencies = [
> + "libc",
> +]
> +
>  [[package]]
>  name = "hpet"
>  version = "0.1.0"
> @@ -106,6 +121,8 @@ dependencies = [
>  name = "qemu_api"
>  version = "0.1.0"
>  dependencies = [
> + "anyhow",
> + "foreign",
>   "libc",
>   "qemu_api_macros",
>  ]
> diff --git a/rust/Cargo.toml b/rust/Cargo.toml
> index d9faeecb10b..2726b1f72e3 100644
> --- a/rust/Cargo.toml
> +++ b/rust/Cargo.toml
> @@ -67,6 +67,7 @@ multiple_crate_versions = "deny"
>  mut_mut = "deny"
>  needless_bitwise_bool = "deny"
>  needless_pass_by_ref_mut = "deny"
> +needless_update = "deny"
>  no_effect_underscore_binding = "deny"
>  option_option = "deny"
>  or_fun_call = "deny"
> diff --git a/rust/meson.build b/rust/meson.build
> index 3e0b6ed4afa..9eb69174dea 100644
> --- a/rust/meson.build
> +++ b/rust/meson.build
> @@ -1,11 +1,13 @@
>  subproject('anyhow-1.0-rs', required: true)
>  subproject('bilge-0.2-rs', required: true)
>  subproject('bilge-impl-0.2-rs', required: true)
> +subproject('foreign-0.2-rs', required: true)
>  subproject('libc-0.2-rs', required: true)
>  
>  anyhow_rs = dependency('anyhow-1.0-rs')
>  bilge_rs = dependency('bilge-0.2-rs')
>  bilge_impl_rs = dependency('bilge-impl-0.2-rs')
> +foreign_rs = dependency('foreign-0.2-rs')
>  libc_rs = dependency('libc-0.2-rs')
>  
>  subproject('proc-macro2-1-rs', required: true)
> diff --git a/rust/qemu-api/Cargo.toml b/rust/qemu-api/Cargo.toml
> index c96cf50e7a1..ca6b81db10a 100644
> --- a/rust/qemu-api/Cargo.toml
> +++ b/rust/qemu-api/Cargo.toml
> @@ -15,7 +15,9 @@ rust-version.workspace = true
>  
>  [dependencies]
>  qemu_api_macros = { path = "../qemu-api-macros" }
> +anyhow = "~1.0"
>  libc = "0.2.162"
> +foreign = "~0.2"
>  
>  [features]
>  default = ["debug_cell"]
> diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
> index 1ea86b8bbf1..11cbd6d375a 100644
> --- a/rust/qemu-api/meson.build
> +++ b/rust/qemu-api/meson.build
> @@ -19,6 +19,7 @@ _qemu_api_rs = static_library(
>        'src/cell.rs',
>        'src/chardev.rs',
>        'src/errno.rs',
> +      'src/error.rs',
>        'src/irq.rs',
>        'src/memory.rs',
>        'src/module.rs',
> @@ -35,7 +36,7 @@ _qemu_api_rs = static_library(
>    override_options: ['rust_std=2021', 'build.rust_std=2021'],
>    rust_abi: 'rust',
>    rust_args: _qemu_api_cfg,
> -  dependencies: [libc_rs, qemu_api_macros],
> +  dependencies: [anyhow_rs, foreign_rs, libc_rs, qemu_api_macros],
>  )
>  
>  rust.test('rust-qemu-api-tests', _qemu_api_rs,

Mere plumbing so far.  I assume I don't need to understand it at this
point :)

> diff --git a/rust/qemu-api/src/error.rs b/rust/qemu-api/src/error.rs
> new file mode 100644
> index 00000000000..f08fed81028
> --- /dev/null
> +++ b/rust/qemu-api/src/error.rs
> @@ -0,0 +1,273 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +//! Error class for QEMU Rust code
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
> +use crate::{
> +    bindings,
> +    bindings::{error_free, error_get_pretty},
> +};
> +
> +pub type Result<T> = std::result::Result<T, Error>;
> +
> +#[derive(Debug, Default)]
> +pub struct Error {

We're defining a custom error type Error for use with Result<>.  This
requires implementing a number of traits.  For trait Debug, we take the
auto-generated solution here.  Other traits are implemented below, in
particular Display.

I don't yet understand the role of trait Default.

Does the name Error risk confusion with std::error::Error?

> +    msg: Option<Cow<'static, str>>,
> +    /// Appends the print string of the error to the msg if not None
> +    cause: Option<anyhow::Error>,
> +    file: &'static str,
> +    line: u32,
> +}

This is the Rust equivalent to C struct Error.  High-level differences:

* No @err_class.  It's almost always ERROR_CLASS_GENERIC_ERROR in C
  nowadays.  You're hardcoding that value in Rust for now.  Good.

* @cause, optional.  This is the bridge to idiomatic Rust error types.

* @msg is optional.  This is so you can wrap a @cause without having to
  add some useless message.

Is having Errors with neither @msg nor @cause a good idea?

> +
> +impl std::error::Error for Error {
> +    fn source(&self) -> Option<&(dyn std::error::Error + 'static)> {

Provide the optional method source() that returns the lower-level source
of the error, if any.  I guess the system will put it to good use :)

> +        self.cause.as_ref().map(AsRef::as_ref)

It returns the std::error::Error that's wrapped in @cause, if any.
Reasonable.

> +    }
> +
> +    #[allow(deprecated)]

Needed for what?  Oh, method description() is deprecated since 1.42.0:
"use the Display impl or to_string()".  I figure we need it because the
new way doesn't work with our oldest supported Rust version.  Could
perhaps use a comment to help future garbage collectors.

> +    fn description(&self) -> &str {
> +        self.msg
> +            .as_deref()
> +            .or_else(|| self.cause.as_deref().map(std::error::Error::description))
> +            .unwrap_or("error")

This gives us @msg, or else @cause, or else "error".

Is it a good idea to ignore @cause when we have @msg?

Above, I doubted the wisdom of having Errors with neither @msg nor
@cause.  description() returns the rather unhelpful "error" then.

> +    }
> +}
> +
> +impl Display for Error {
> +    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
> +        let mut prefix = "";
> +        if let Some(ref msg) = self.msg {
> +            write!(f, "{msg}")?;
> +            prefix = ": ";
> +        }
> +        if let Some(ref cause) = self.cause {
> +            write!(f, "{prefix}{cause}")?;
> +        } else if prefix.is_empty() {
> +            f.write_str("unknown error")?;
> +        }
> +        Ok(())
> +    }

This combines @msg and @cause:

* If we have both: msg:cause

* If we have just msg: msg

* If we have just cause: cause

* If we have neither: "unknown error"

Differs from description().  Why?

> +}
> +
> +impl From<String> for Error {
> +    #[track_caller]

This enables use of panic::Location::caller().file() and .line() right
below.  Neat!

> +    fn from(msg: String) -> Self {
> +        let location = panic::Location::caller();
> +        Error {
> +            msg: Some(Cow::Owned(msg)),
> +            file: location.file(),
> +            line: location.line(),
> +            ..Default::default()

I don't understand this line, I'm afraid.

> +        }
> +    }

This creates an Error from an error message string, recording the spot
where it's done.  The resulting Error has @msg, but not @cause.

> +}
> +
> +impl From<&'static str> for Error {
> +    #[track_caller]
> +    fn from(msg: &'static str) -> Self {
> +        let location = panic::Location::caller();
> +        Error {
> +            msg: Some(Cow::Borrowed(msg)),
> +            file: location.file(),
> +            line: location.line(),
> +            ..Default::default()
> +        }
> +    }
> +}

Same for another string type.

> +
> +impl From<anyhow::Error> for Error {
> +    #[track_caller]
> +    fn from(error: anyhow::Error) -> Self {
> +        let location = panic::Location::caller();
> +        Error {
> +            cause: Some(error),
> +            file: location.file(),
> +            line: location.line(),
> +            ..Default::default()
> +        }
> +    }
> +}

This creates an Error from an anyhow::Error, recording the spot where
it's done.  The resulting Error has @cause, but not @msg.

> +
> +impl Error {
> +    /// Create a new error, prepending `msg` to the
> +    /// description of `cause`
> +    #[track_caller]
> +    pub fn with_error<E: std::error::Error + Send + Sync + 'static>(msg: &'static str, cause: E) -> Self {
> +        let location = panic::Location::caller();
> +        Error {
> +            msg: Some(Cow::Borrowed(msg)),
> +            cause: Some(cause.into()),
> +            file: location.file(),
> +            line: location.line(),
> +        }
> +    }

This creates an Error from an error message string and an anyhow::Error,
recording the spot where it's done.  The resulting Error has both @msg
and @cause.

Is there a way to create an Error with neither @msg nor @cause?

> +
> +    /// Consume a result, returning false if it is an error and
> +    /// true if it is successful.  The error is propagated into
> +    /// `errp` like the C API `error_propagate` would do.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `errp` must be valid; typically it is received from C code
> +    pub unsafe fn bool_or_propagate(result: Result<()>, errp: *mut *mut bindings::Error) -> bool {
> +        // SAFETY: caller guarantees errp is valid
> +        unsafe { Self::ok_or_propagate(result, errp) }.is_some()
> +    }

Note: I jumped down to ok_or_propagate(), then returned here.  

Note: I'm ignoring everything about safety in this first pass.

Alright, this is "return true on success (nothing propagated), return
false and propagate on error".  Okay.

> +
> +    /// Consume a result, returning a `NULL` pointer if it is an
> +    /// error and a C representation of the contents if it is
> +    /// successful.  The error is propagated into `errp` like
> +    /// the C API `error_propagate` would do.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `errp` must be valid; typically it is received from C code
> +    #[must_use]
> +    pub unsafe fn ptr_or_propagate<T: CloneToForeign>(
> +        result: Result<T>,
> +        errp: *mut *mut bindings::Error,
> +    ) -> *mut T::Foreign {
> +        // SAFETY: caller guarantees errp is valid
> +        unsafe { Self::ok_or_propagate(result, errp) }.clone_to_foreign_ptr()
> +    }

And this is "return result as foreign pointer on success (nothing
propagated), return NULL and propagate on error".  Okay.

> +
> +    /// Consume a result in the same way as `self.ok()`, but also propagate
> +    /// a possible error into `errp`, like the C API `error_propagate`
> +    /// would do.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `errp` must be valid; typically it is received from C code
> +    pub unsafe fn ok_or_propagate<T>(
> +        result: Result<T>,

@result is either a success value of type T, or an error value.

> +        errp: *mut *mut bindings::Error,
> +    ) -> Option<T> {
> +        let Err(err) = result else {

If @result is an Error, put the error value in @err.

> +            return result.ok();

Else succeed and return the success value.

> +        };
> +
> +        // SAFETY: caller guarantees errp is valid
> +        unsafe {
> +            err.propagate(errp);
> +        }
> +        None

@result is an Error.  Propagate it, and return None.

This is indeed like self.ok() with propagation added.

> +    }
> +
> +    /// Equivalent of the C function `error_propagate`.  Fill `*errp`
> +    /// with the information container in `result` if `errp` is not NULL;
> +    /// then consume it.

Note error_propagate() has the arguments in the opposite order.

> +    ///
> +    /// # Safety
> +    ///
> +    /// `errp` must be valid; typically it is received from C code

What does "valid" mean exactly?

C error_propagate()'s function comment:

    /*
     * Propagate error object (if any) from @local_err to @dst_errp.
     * If @local_err is NULL, do nothing (because there's nothing to
     * propagate).
     * Else, if @dst_errp is NULL, errors are being ignored.  Free the
     * error object.
     * Else, if @dst_errp is &error_abort, print a suitable message and
     * abort().
     * Else, if @dst_errp is &error_fatal, print a suitable message and
     * exit(1).
     * Else, if @dst_errp already contains an error, ignore this one: free
     * the error object.
     * Else, move the error object from @local_err to *@dst_errp.
     * On return, @local_err is invalid.
     * Please use ERRP_GUARD() instead when possible.
     * Please don't error_propagate(&error_fatal, ...), use
     * error_report_err() and exit(), because that's more obvious.
     */

> +    pub unsafe fn propagate(self, errp: *mut *mut bindings::Error) {

The function comment mentions `result`.  The function signature doesn't
have it.  Do you mean self?

If yes, what does it mean to consume self?

Ignored for now: how exactly the code below consumes.

> +        if errp.is_null() {

Errors are being ignored.

> +            return;
> +        }
> +
> +        let err = self.clone_to_foreign_ptr();
> +
> +        // SAFETY: caller guarantees errp is valid
> +        unsafe {
> +            errp.write(err);

I *guess* this writes the foreign pointer we just obtained to @errp.

> +        }
> +    }

Brief switch to the design level...

In C, you're almost always better off with ERRP_GUARD().  Would you like
me to elaborate?

You still have to use error_propagate() to accumulate multiple errors so
that the first one wins.  That's commonly a dumb idea.  Should we avoid
this pattern in Rust?

> +
> +    /// Convert a C `Error*` into a Rust `Result`, using
> +    /// `Ok(())` if `c_error` is NULL.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `c_error` must be valid; typically it has been filled by a C
> +    /// function.

What does "valid" mean exactly?

> +    pub unsafe fn err_or_unit(c_error: *mut bindings::Error) -> Result<()> {
> +        // SAFETY: caller guarantees c_error is valid
> +        unsafe { Self::err_or_else(c_error, || ()) }
> +    }
> +
> +    /// Convert a C `Error*` into a Rust `Result`, calling `f()` to
> +    /// obtain an `Ok` value if `c_error` is NULL.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `c_error` must be valid; typically it has been filled by a C
> +    /// function.
> +    pub unsafe fn err_or_else<T, F: FnOnce() -> T>(
> +        c_error: *mut bindings::Error,
> +        f: F,
> +    ) -> Result<T> {
> +        // SAFETY: caller guarantees c_error is valid
> +        let err = unsafe { Option::<Self>::from_foreign(c_error) };
> +        match err {
> +            None => Ok(f()),
> +            Some(err) => Err(err),
> +        }
> +    }
> +}

Getting tired...

> +
> +impl FreeForeign for Error {
> +    type Foreign = bindings::Error;
> +
> +    unsafe fn free_foreign(p: *mut bindings::Error) {
> +        // SAFETY: caller guarantees p is valid
> +        unsafe {
> +            error_free(p);
> +        }
> +    }
> +}
> +
> +impl CloneToForeign for Error {
> +    fn clone_to_foreign(&self) -> OwnedPointer<Self> {
> +        // SAFETY: all arguments are controlled by this function
> +        unsafe {
> +            let err: *mut c_void = libc::malloc(std::mem::size_of::<bindings::Error>());
> +            let err: &mut bindings::Error = &mut *err.cast();
> +            *err = bindings::Error {
> +                msg: format!("{self}").clone_to_foreign_ptr(),
> +                err_class: bindings::ERROR_CLASS_GENERIC_ERROR,
> +                src_len: self.file.len() as isize,
> +                src: self.file.as_ptr().cast::<c_char>(),
> +                line: self.line as c_int,
> +                func: ptr::null_mut(),
> +                hint: ptr::null_mut(),
> +            };
> +            OwnedPointer::new(err)
> +        }
> +    }
> +}

Plausible to this Rust ignoramus :)

> +
> +impl FromForeign for Error {
> +    unsafe fn cloned_from_foreign(c_error: *const bindings::Error) -> Self {
> +        // SAFETY: caller guarantees c_error is valid
> +        unsafe {
> +            let error = &*c_error;
> +            let file = if error.src_len < 0 {
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
> +                msg: FromForeign::cloned_from_foreign(error_get_pretty(error)),
> +                cause: None,
> +                file: file.unwrap(),
> +                line: error.line as u32,
> +            }
> +        }
> +    }
> +}

Likewise.

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
>  
> +pub use error::{Error, Result};
> +
>  #[cfg(HAVE_GLIB_WITH_ALIGNED_ALLOC)]
>  extern "C" {
>      fn g_aligned_alloc0(


