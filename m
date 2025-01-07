Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A55BE77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 08:40:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV57z-0002Rt-J8; Tue, 07 Jan 2025 03:39:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tV57w-0002RB-4d; Tue, 07 Jan 2025 03:39:52 -0500
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tV57q-00082w-Sa; Tue, 07 Jan 2025 03:39:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1736239187; x=1767775187;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=wy4C1JLqouyAQa7rS1oC3i8VxtHk8A6mXEyq4Eb/X3s=;
 b=PGKanqSQjl5NnSjE7DOQRBsL0rUM8IGD9RWHxPFbz+KnHdkaiwqhDBIc
 vpwA3WRPo9C1+o65rxKIElLql7oJ9kG7qTdq27pMseFAJEMQU79/yvz6q
 7VrGP+xv60hICgz+Cf9VU5uadCjrNcSkDd20VyIupJjfMP0XwUiix9VDd
 KywK9sZ7VngiBDHRRk0jKaLr13p0Tgtu0fOYW6Cj7Wk39xbORB24TcHrV
 H2jwCfmb6cAdQIhdZckNIEG4ghQrN7HeRyPNNZ2Pg54YHYJhTnJ+gIZGB
 XCs6jYSJys4JBu15wAGzvmI4A9nOTLO8rDZwpyJhAD/1VjplLyusu2QUU w==;
X-CSE-ConnectionGUID: ztIfaf4UQXunlIWrezJGPg==
X-CSE-MsgGUID: PaSqxhltS6m+5B00BIGv8g==
X-IronPort-AV: E=McAfee;i="6700,10204,11307"; a="36426856"
X-IronPort-AV: E=Sophos;i="6.12,295,1728975600"; d="scan'208";a="36426856"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jan 2025 00:39:44 -0800
X-CSE-ConnectionGUID: FaL/xuO0TY6w99zRF3rQGA==
X-CSE-MsgGUID: HM74yDQpRVizIFmUN1SksQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,295,1728975600"; d="scan'208";a="102598663"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa007.fm.intel.com with ESMTP; 07 Jan 2025 00:39:42 -0800
Date: Tue, 7 Jan 2025 16:58:30 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, junjie.mao@hotmail.com
Subject: Re: [RFC PATCH 1/9] rust: vmstate: add new type safe implementation
Message-ID: <Z3zstgKXAgeRrIU2@intel.com>
References: <20241231002336.25931-1-pbonzini@redhat.com>
 <20241231002336.25931-2-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241231002336.25931-2-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.17; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.446,
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

On Tue, Dec 31, 2024 at 01:23:28AM +0100, Paolo Bonzini wrote:
> Date: Tue, 31 Dec 2024 01:23:28 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [RFC PATCH 1/9] rust: vmstate: add new type safe implementation
> X-Mailer: git-send-email 2.47.1
> 
> The existing translation of the C macros for vmstate does not make
> any attempt to type-check vmstate declarations against the struct, so
> introduce a new system that computes VMStateField based on the actual
> struct declaration.
> 
> Macros do not have full access to the type system, therefore a full
> implementation of this scheme requires a helper trait to analyze the
> type and produce a VMStateField from it; a macro "vmstate_of!" accepts
> arguments similar to "offset_of!" and tricks the compiler into looking
> up the trait for the right type.
> 
> The patch introduces not just vmstate_of!, but also the slightly too
> clever enabling macro call_func_with_field!.  The particular trick used
> here was proposed on the users.rust-lang.org forum, so I take no merit
> and all the blame.

This is very good work! I am curious about how QEMU plays with Rust
forum:

Rust forum's disscussion is under MIT and Apache 2.0 licenses [1], and
since vmstate.rs is under the GPLv2 license, do we need to specify that
certain code retains the MIT license?

[1]: https://users.rust-lang.org/t/tos-updated-to-match-rfcs-and-rust-repository/45650

> Introduce the trait and some functions to access it; the actual
> implementation comes later.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/qemu-api/src/prelude.rs |   2 +
>  rust/qemu-api/src/vmstate.rs | 110 +++++++++++++++++++++++++++++++++--
>  2 files changed, 106 insertions(+), 6 deletions(-)
> 
> diff --git a/rust/qemu-api/src/prelude.rs b/rust/qemu-api/src/prelude.rs
> index 4ea70b9c823..2dc86e19b29 100644
> --- a/rust/qemu-api/src/prelude.rs
> +++ b/rust/qemu-api/src/prelude.rs
> @@ -18,3 +18,5 @@
>  pub use crate::qom_isa;
>  
>  pub use crate::sysbus::SysBusDeviceMethods;
> +
> +pub use crate::vmstate::VMState;
> diff --git a/rust/qemu-api/src/vmstate.rs b/rust/qemu-api/src/vmstate.rs
> index 63c897abcdf..bfcf06e8f1d 100644
> --- a/rust/qemu-api/src/vmstate.rs
> +++ b/rust/qemu-api/src/vmstate.rs
> @@ -4,13 +4,111 @@
>  
>  //! Helper macros to declare migration state for device models.
>  //!
> -//! Some macros are direct equivalents to the C macros declared in
> -//! `include/migration/vmstate.h` while
> -//! [`vmstate_subsections`](crate::vmstate_subsections) and
> -//! [`vmstate_fields`](crate::vmstate_fields) are meant to be used when
> -//! declaring a device model state struct.
> +//! This module includes three families of macros:
> +//!
> +//! * [`vmstate_unused!`](crate::vmstate_unused) and
> +//!   [`vmstate_of!`](crate::vmstate_of), which are used to express the
> +//!   migration format for a struct.  This is based on the [`VMState`] trait,
> +//!   which is defined by all migrateable types.
> +//!
> +//! * helper macros to declare a device model state struct, in particular
> +//!   [`vmstate_subsections`](crate::vmstate_subsections) and
> +//!   [`vmstate_fields`](crate::vmstate_fields).
> +//!
> +//! * direct equivalents to the C macros declared in
> +//!   `include/migration/vmstate.h`. These are not type-safe and should not be
> +//!   used if the equivalent functionality is available with `vmstate_of!`.
>  
> -pub use crate::bindings::VMStateDescription;
> +use core::marker::PhantomData;
> +
> +pub use crate::bindings::{VMStateDescription, VMStateField};
> +
> +/// This macro is used to call a function with a generic argument bound
> +/// to the type of a field.  The function must take a
> +/// [`PhantomData`]`<T>` argument; `T` is the type of
> +/// field `$field` in the `$typ` type.
> +///
> +/// # Examples
> +///
> +/// ```
> +/// # use qemu_api::call_func_with_field;
> +/// # use core::marker::PhantomData;
> +/// const fn size_of_field<T>(_: PhantomData<T>) -> usize {
> +///     std::mem::size_of::<T>()
> +/// }
> +///
> +/// struct Foo {
> +///     x: u16,
> +/// };
> +/// // calls size_of_field::<u16>()
> +/// assert_eq!(call_func_with_field!(size_of_field, Foo, x), 2);
> +/// ```
> +#[macro_export]
> +macro_rules! call_func_with_field {
> +    ($func:expr, $typ:ty, $($field:tt).+) => {
> +        $func(loop {
> +            #![allow(unreachable_code)]
> +            const fn phantom__<T>(_: &T) -> ::core::marker::PhantomData<T> { ::core::marker::PhantomData }
> +            // Unreachable code is exempt from checks on uninitialized values.
> +            // Use that trick to infer the type of this PhantomData.
> +            break ::core::marker::PhantomData;
> +            break phantom__(&{ let value__: $typ; value__.$($field).+ });
> +        })
> +    };
> +}

Very flexible and powerful. (I even think this code could be released as
a new public crate.)

> +/// A trait for types that can be included in a device's migration stream.  It
> +/// provides the base contents of a `VMStateField` (minus the name and offset).
> +///
> +/// # Safety
> +///
> +/// The contents of this trait go straight into structs that are parsed by C
> +/// code and used to introspect into other structs.  Be careful.
> +pub unsafe trait VMState {
> +    /// The base contents of a `VMStateField` (minus the name and offset) for
> +    /// the type that is implementing the trait.
> +    const BASE: VMStateField;
> +}
> +
> +/// Internal utility function to retrieve a type's `VMStateField`;
> +/// used by [`vmstate_of!`](crate::vmstate_of).
> +pub const fn vmstate_base<T: VMState>(_: PhantomData<T>) -> VMStateField {
> +    T::BASE
> +}
> +
> +/// Return the `VMStateField` for a field of a struct.  The field must be
> +/// visible in the current scope.
> +///
> +/// In order to support other types, the trait `VMState` must be implemented
> +/// for them.
> +#[macro_export]
> +macro_rules! vmstate_of {
> +    ($struct_name:ty, $field_name:ident $(,)?) => {

why allow a comma at the end? It seems other patches don't use that
style.

> +        $crate::bindings::VMStateField {
> +            name: ::core::concat!(::core::stringify!($field_name), "\0")
> +                .as_bytes()
> +                .as_ptr() as *const ::std::os::raw::c_char,
> +            offset: $crate::offset_of!($struct_name, $field_name),
> +            // Compute most of the VMStateField from the type of the field.
> +            ..$crate::call_func_with_field!(
> +                $crate::vmstate::vmstate_base,
> +                $struct_name,
> +                $field_name
> +            )
> +        }
> +    };
> +}
> +
> +// Add a couple builder-style methods to VMStateField, allowing
> +// easy derivation of VMStateField constants from other types.
> +impl VMStateField {
> +    #[must_use]
> +    pub const fn with_version_id(mut self, version_id: i32) -> Self {

Why not use u32 (and omit an assert)?

> +        assert!(version_id >= 0);
> +        self.version_id = version_id;
> +        self
> +    }
> +}
>  
>  #[doc(alias = "VMSTATE_UNUSED_BUFFER")]
>  #[macro_export]
> -- 
> 2.47.1

Good design! Look good to me.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>



