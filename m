Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDCAAD2F7C6
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 09:35:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRSDl-0004Gt-OL; Fri, 05 Dec 2025 04:35:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vRSDj-0004FA-Ky
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 04:35:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vRSDh-00040o-Hh
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 04:35:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764927320;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fe+MI0iU5K1uop7AZy2LhCNulGAZOfxPiNeolNKQsMQ=;
 b=TWT+/SnOWU+p+o+wcOVVPQ1HQ8thwClcwC6ZCs/mUxAXJ4HPL9WTzhriJ4EDAjrv0FxlAy
 Z4PCPnmlHVQKXTcLZwTT2WDlz/CeLzz+pdKxVNS+SOI0tTDdHy7pY5hKsMp5PFCl5Iz34u
 OsxNyf+qZDCas41vpi7J+DKo0CK+69o=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-227-D_fRCHZANNykbb96E3Ii6A-1; Fri,
 05 Dec 2025 04:35:18 -0500
X-MC-Unique: D_fRCHZANNykbb96E3Ii6A-1
X-Mimecast-MFC-AGG-ID: D_fRCHZANNykbb96E3Ii6A_1764927317
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C91DC195606C; Fri,  5 Dec 2025 09:35:16 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.7])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0624E196B8DA; Fri,  5 Dec 2025 09:35:15 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1BF2821E6A27; Fri, 05 Dec 2025 10:35:13 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, qemu-rust@nongnu.org
Subject: Re: [PATCH 04/19] rust/qobject: add basic bindings
In-Reply-To: <20251010151006.791038-5-pbonzini@redhat.com> (Paolo Bonzini's
 message of "Fri, 10 Oct 2025 17:09:49 +0200")
References: <20251010151006.791038-1-pbonzini@redhat.com>
 <20251010151006.791038-5-pbonzini@redhat.com>
Date: Fri, 05 Dec 2025 10:35:13 +0100
Message-ID: <875xalz2y6.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Learning opportunity for me, I ask for your patience...

Paolo Bonzini <pbonzini@redhat.com> writes:

> This is only a basic API, intended to be used by the serde traits.
>
> Co-authored-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/util/wrapper.h          |   7 +
>  rust/util/meson.build        |   6 +-
>  rust/util/src/lib.rs         |   2 +
>  rust/util/src/qobject/mod.rs | 317 +++++++++++++++++++++++++++++++++++
>  4 files changed, 330 insertions(+), 2 deletions(-)
>  create mode 100644 rust/util/src/qobject/mod.rs
>
> diff --git a/rust/util/wrapper.h b/rust/util/wrapper.h
> index b9ed68a01d8..0907dd59142 100644
> --- a/rust/util/wrapper.h
> +++ b/rust/util/wrapper.h
> @@ -30,3 +30,10 @@ typedef enum memory_order {
>  #include "qemu/log.h"
>  #include "qemu/module.h"
>  #include "qemu/timer.h"
> +#include "qobject/qnull.h"
> +#include "qobject/qbool.h"
> +#include "qobject/qnum.h"
> +#include "qobject/qstring.h"
> +#include "qobject/qobject.h"
> +#include "qobject/qlist.h"
> +#include "qobject/qdict.h"
> diff --git a/rust/util/meson.build b/rust/util/meson.build
> index 8ad344dccbd..ce468ea5227 100644
> --- a/rust/util/meson.build
> +++ b/rust/util/meson.build
> @@ -36,8 +36,10 @@ _util_rs =3D static_library(
>        'src/module.rs',
>        'src/timer.rs',
>      ],
> -    {'.': _util_bindings_inc_rs}
> -  ),
> +    {'.': _util_bindings_inc_rs,
> +    'qobject': [
> +      'src/qobject/mod.rs',
> +    ]}),
>    override_options: ['rust_std=3D2021', 'build.rust_std=3D2021'],
>    rust_abi: 'rust',
>    dependencies: [anyhow_rs, libc_rs, foreign_rs, glib_sys_rs, common_rs,=
 qom, qemuutil],
> diff --git a/rust/util/src/lib.rs b/rust/util/src/lib.rs
> index 16c89b95174..fe0128103c8 100644
> --- a/rust/util/src/lib.rs
> +++ b/rust/util/src/lib.rs
> @@ -4,6 +4,8 @@
>  pub mod error;
>  pub mod log;
>  pub mod module;
> +#[macro_use]
> +pub mod qobject;
>  pub mod timer;
>=20=20
>  pub use error::{Error, Result};
> diff --git a/rust/util/src/qobject/mod.rs b/rust/util/src/qobject/mod.rs
> new file mode 100644
> index 00000000000..9c6f168d6e1
> --- /dev/null
> +++ b/rust/util/src/qobject/mod.rs
> @@ -0,0 +1,317 @@
> +//! `QObject` bindings
> +//!
> +//! This module implements bindings for QEMU's `QObject` data structure.
> +//! The bindings integrate with `serde`, which take the role of visitors
> +//! in Rust code.
> +
> +#![deny(clippy::unwrap_used)]
> +
> +use std::{
> +    cell::UnsafeCell,
> +    ffi::{c_char, CString},
> +    mem::ManuallyDrop,
> +    ptr::{addr_of, addr_of_mut},
> +    sync::atomic::{AtomicUsize, Ordering},
> +};
> +
> +use common::assert_field_type;
> +
> +use crate::bindings;
> +
> +/// A wrapper for a C `QObject`.
> +///
> +/// Because `QObject` is not thread-safe, the safety of these bindings
> +/// right now hinges on treating them as immutable.  It is part of the
> +/// contract with the `QObject` constructors that the Rust struct is
> +/// only built after the contents are stable.
> +///
> +/// Only a bare bones API is public; production and consumption of `QObj=
ect`
> +/// generally goes through `serde`.
> +pub struct QObject(&'static UnsafeCell<bindings::QObject>);

This defines the Rust QObject.  All it contains is a reference (wrapped
in UnsafeCell) self.0 to the C QObject.  Correct?

> +
> +// SAFETY: the QObject API are not thread-safe other than reference coun=
ting;
> +// but the Rust struct is only created once the contents are stable, and
> +// therefore it obeys the aliased XOR mutable invariant.

In other words, we promise never to change a QObject while Rust code
holds a reference, except for the reference counts.  Correct?

The reference count is the mutable part of an otherwise immutable
object.  Not mentioned here: it is atomic.  Therefore, concurrent
updates cannot mess it up.  Nothing depends on its value except
deallocation when the last reference drops.  I figure that's why the
exception to "aliased XOR mutable" is fine.  Correct?

> +unsafe impl Send for QObject {}
> +unsafe impl Sync for QObject {}
> +
> +// Since a QObject can be a floating-point value, and potentially a NaN,
> +// do not implement Eq
> +impl PartialEq for QObject {
> +    fn eq(&self, other: &Self) -> bool {
> +        unsafe { bindings::qobject_is_equal(self.0.get(), other.0.get())=
 }
> +    }
> +}
> +
> +impl QObject {
> +    /// Construct a [`QObject`] from a C `QObjectBase` pointer.

It's spelled QObjectBase_.  More of the same below, not flagging again.

Comment next to its definition:

    /* Not for use outside include/qobject/ */

We're using it outside now.  Do we really need to?

> +    /// The caller cedes its reference to the returned struct.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The `QObjectBase` must not be changed from C code while
> +    /// the Rust `QObject` lives
> +    const unsafe fn from_base(p: *const bindings::QObjectBase_) -> Self {
> +        QObject(unsafe { &*p.cast() })
> +    }
> +
> +    /// Construct a [`QObject`] from a C `QObject` pointer.
> +    /// The caller cedes its reference to the returned struct.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The `QObject` must not be changed from C code while
> +    /// the Rust `QObject` lives
> +    pub const unsafe fn from_raw(p: *const bindings::QObject) -> Self {
> +        QObject(unsafe { &*p.cast() })
> +    }
> +
> +    /// Obtain a raw C pointer from a reference. `self` is consumed
> +    /// and the C `QObject` pointer is leaked.

What exactly do you mean by "leaked"?

> +    pub fn into_raw(self) -> *mut bindings::QObject {
> +        let src =3D ManuallyDrop::new(self);
> +        src.0.get()
> +    }
> +
> +    /// Construct a [`QObject`] from a C `QObject` pointer.

Pasto?  Isn't it QObjectBase_ here?

> +    /// The caller *does not* cede its reference to the returned struct.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The `QObjectBase` must not be changed from C code while
> +    /// the Rust `QObject` lives
> +    unsafe fn cloned_from_base(p: *const bindings::QObjectBase_) -> Self=
 {
> +        let orig =3D unsafe { ManuallyDrop::new(QObject::from_base(p)) };
> +        (*orig).clone()
> +    }
> +
> +    /// Construct a [`QObject`] from a C `QObject` pointer.
> +    /// The caller *does not* cede its reference to the returned struct.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The `QObject` must not be changed from C code while
> +    /// the Rust `QObject` lives
> +    pub unsafe fn cloned_from_raw(p: *const bindings::QObject) -> Self {
> +        let orig =3D unsafe { ManuallyDrop::new(QObject::from_raw(p)) };
> +        (*orig).clone()
> +    }
> +
> +    fn refcnt(&self) -> &AtomicUsize {
> +        assert_field_type!(bindings::QObjectBase_, refcnt, usize);
> +        let qobj =3D self.0.get();
> +        unsafe { AtomicUsize::from_ptr(addr_of_mut!((*qobj).base.refcnt)=
) }
> +    }
> +}
> +
> +impl From<()> for QObject {
> +    fn from(_null: ()) -> Self {
> +        unsafe { QObject::cloned_from_base(addr_of!(bindings::qnull_.bas=
e)) }

qnull_ is not meant for use outside qnull.[ch] and its unit test
check-qnull.c.  Could we use qnull()?

> +    }
> +}
> +
> +impl<T> From<Option<T>> for QObject
> +where
> +    QObject: From<T>,
> +{
> +    fn from(o: Option<T>) -> Self {
> +        o.map_or_else(|| ().into(), Into::into)
> +    }
> +}
> +
> +impl From<bool> for QObject {
> +    fn from(b: bool) -> Self {
> +        let qobj =3D unsafe { &*bindings::qbool_from_bool(b) };
> +        unsafe { QObject::from_base(addr_of!(qobj.base)) }
> +    }
> +}
> +
> +macro_rules! from_int {
> +    ($t:ty) =3D> {
> +        impl From<$t> for QObject {
> +            fn from(n: $t) -> Self {
> +                let qobj =3D unsafe { &*bindings::qnum_from_int(n.into()=
) };
> +                unsafe { QObject::from_base(addr_of!(qobj.base)) }
> +            }
> +        }
> +    };
> +}
> +
> +from_int!(i8);
> +from_int!(i16);
> +from_int!(i32);
> +from_int!(i64);
> +
> +macro_rules! from_uint {
> +    ($t:ty) =3D> {
> +        impl From<$t> for QObject {
> +            fn from(n: $t) -> Self {
> +                let qobj =3D unsafe { &*bindings::qnum_from_uint(n.into(=
)) };
> +                unsafe { QObject::from_base(addr_of!(qobj.base)) }
> +            }
> +        }
> +    };
> +}
> +
> +from_uint!(u8);
> +from_uint!(u16);
> +from_uint!(u32);
> +from_uint!(u64);
> +
> +macro_rules! from_double {
> +    ($t:ty) =3D> {
> +        impl From<$t> for QObject {
> +            fn from(n: $t) -> Self {
> +                let qobj =3D unsafe { &*bindings::qnum_from_double(n.int=
o()) };
> +                unsafe { QObject::from_base(addr_of!(qobj.base)) }
> +            }
> +        }
> +    };
> +}
> +
> +from_double!(f32);

Uh, isn't the double in from_double misleading?

> +from_double!(f64);

Can you briefly explain why we need more than i64, u64, and double?

> +
> +impl From<CString> for QObject {
> +    fn from(s: CString) -> Self {
> +        let qobj =3D unsafe { &*bindings::qstring_from_str(s.as_ptr()) };
> +        unsafe { QObject::from_base(addr_of!(qobj.base)) }
> +    }
> +}
> +
> +impl<A> FromIterator<A> for QObject
> +where
> +    Self: From<A>,
> +{
> +    fn from_iter<I: IntoIterator<Item =3D A>>(it: I) -> Self {
> +        let qlist =3D unsafe { &mut *bindings::qlist_new() };
> +        for elem in it {
> +            let elem: QObject =3D elem.into();
> +            let elem =3D elem.into_raw();
> +            unsafe {
> +                bindings::qlist_append_obj(qlist, elem);
> +            }
> +        }
> +        unsafe { QObject::from_base(addr_of!(qlist.base)) }
> +    }
> +}
> +
> +impl<A> FromIterator<(CString, A)> for QObject
> +where
> +    Self: From<A>,
> +{
> +    fn from_iter<I: IntoIterator<Item =3D (CString, A)>>(it: I) -> Self {
> +        let qdict =3D unsafe { &mut *bindings::qdict_new() };
> +        for (key, val) in it {
> +            let val: QObject =3D val.into();
> +            let val =3D val.into_raw();
> +            unsafe {
> +                bindings::qdict_put_obj(qdict, key.as_ptr().cast::<c_cha=
r>(), val);
> +            }
> +        }
> +        unsafe { QObject::from_base(addr_of!(qdict.base)) }
> +    }
> +}
> +
> +impl Clone for QObject {
> +    fn clone(&self) -> Self {
> +        self.refcnt().fetch_add(1, Ordering::Acquire);
> +        QObject(self.0)
> +    }
> +}
> +
> +impl Drop for QObject {
> +    fn drop(&mut self) {
> +        if self.refcnt().fetch_sub(1, Ordering::Release) =3D=3D 1 {
> +            unsafe {
> +                bindings::qobject_destroy(self.0.get());
> +            }
> +        }
> +    }
> +}
> +

Skipping the remainder, it's too much macro magic for poor, ignorant me
:)

> +#[allow(unused)]
> +macro_rules! match_qobject {
> +    (@internal ($qobj:expr) =3D>
> +        $(() =3D> $unit:expr,)?
> +        $(bool($boolvar:tt) =3D> $bool:expr,)?
> +        $(i64($i64var:tt) =3D> $i64:expr,)?
> +        $(u64($u64var:tt) =3D> $u64:expr,)?
> +        $(f64($f64var:tt) =3D> $f64:expr,)?
> +        $(CStr($cstrvar:tt) =3D> $cstr:expr,)?
> +        $(QList($qlistvar:tt) =3D> $qlist:expr,)?
> +        $(QDict($qdictvar:tt) =3D> $qdict:expr,)?
> +        $(_ =3D> $other:expr,)?
> +    ) =3D> {
> +        loop {
> +            let qobj_ =3D $qobj.0.get();
> +            match unsafe { &* qobj_ }.base.type_ {
> +                $($crate::bindings::QTYPE_QNULL =3D> break $unit,)?
> +                $($crate::bindings::QTYPE_QBOOL =3D> break {
> +                    let qbool__: *mut $crate::bindings::QBool =3D qobj_.=
cast();
> +                    let $boolvar =3D unsafe { (&*qbool__).value };
> +                    $bool
> +                },)?
> +                $crate::bindings::QTYPE_QNUM =3D> {
> +                    let qnum__: *mut $crate::bindings::QNum =3D qobj_.ca=
st();
> +                    let qnum__ =3D unsafe { &*qnum__ };
> +                    match qnum__.kind {
> +                        $crate::bindings::QNUM_I64 |
> +                        $crate::bindings::QNUM_U64 |
> +                        $crate::bindings::QNUM_DOUBLE =3D> {}
> +                        _ =3D> {
> +                            panic!("unreachable");
> +                        }
> +                    }
> +
> +                    match qnum__.kind {
> +                        $($crate::bindings::QNUM_I64 =3D> break {
> +                            let $i64var =3D unsafe { qnum__.u.i64_ };
> +                            $i64
> +                        },)?
> +                        $($crate::bindings::QNUM_U64 =3D> break {
> +                            let $u64var =3D unsafe { qnum__.u.u64_ };
> +                            $u64
> +                        },)?
> +                        $($crate::bindings::QNUM_DOUBLE =3D> break {
> +                            let $f64var =3D unsafe { qnum__.u.dbl };
> +                            $f64
> +                        },)?
> +                        _ =3D> {}
> +                    }
> +                },
> +                $($crate::bindings::QTYPE_QSTRING =3D> break {
> +                    let qstring__: *mut $crate::bindings::QString =3D qo=
bj_.cast();
> +                    let $cstrvar =3D unsafe { ::core::ffi::CStr::from_pt=
r((&*qstring__).string) };
> +                    $cstr
> +                },)?
> +                $($crate::bindings::QTYPE_QLIST =3D> break {
> +                    let qlist__: *mut $crate::bindings::QList =3D qobj_.=
cast();
> +                    let $qlistvar =3D unsafe { &*qlist__ };
> +                    $qlist
> +                },)?
> +                $($crate::bindings::QTYPE_QDICT =3D> break {
> +                    let qdict__: *mut $crate::bindings::QDict =3D qobj_.=
cast();
> +                    let $qdictvar =3D unsafe { &*qdict__ };
> +                    $qdict
> +                },)?
> +                _ =3D> ()
> +            };
> +            $(break $other;)?
> +            #[allow(unreachable_code)]
> +            {
> +                panic!("unreachable");
> +            }
> +        }
> +    };
> +
> +    // first cleanup the syntax a bit, checking that there's at least
> +    // one pattern and always adding a trailing comma
> +    (($qobj:expr) =3D>
> +        $($type:tt$(($val:tt))? =3D> $code:expr ),+ $(,)?) =3D> {
> +            match_qobject!(@internal ($qobj) =3D>
> +                $($type $(($val))? =3D> $code,)+)
> +    };
> +}
> +#[allow(unused_imports)]
> +use match_qobject;


