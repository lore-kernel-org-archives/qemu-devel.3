Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D242E9B248
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 10:04:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vupGy-00041j-8T; Tue, 24 Feb 2026 05:04:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vupGw-00041M-PD
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 05:04:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vupGt-0004Nz-No
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 05:04:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771927441;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5HHARSOmTxty/Ap1tfHt3z96ZsFPs29n2S6Oe0KifXY=;
 b=Ez8jXtFa+6c+rt3vkF8+72UCXTrCFUjqwiDuzo+j87y36bEQhuKrWO1GZZy9Mpy0P/pp+F
 AOkoIgfFs1uDK8WwvdfduwWlydKVZJCxIr/ZM5LilvS5w5rt2UtbXMNFywNQdCUKmDNoPl
 1pl0lMFeTx7TGJe/slbUa04IGDzHh1k=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-652-RSrknTy5Nh-Ia_YG_s3q7g-1; Tue,
 24 Feb 2026 05:03:59 -0500
X-MC-Unique: RSrknTy5Nh-Ia_YG_s3q7g-1
X-Mimecast-MFC-AGG-ID: RSrknTy5Nh-Ia_YG_s3q7g_1771927438
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B7F92195609D; Tue, 24 Feb 2026 10:03:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.13])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 06F3B30001BB; Tue, 24 Feb 2026 10:03:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6042521E692D; Tue, 24 Feb 2026 11:03:54 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,  armbru@redhat.com,  =?utf-8?Q?Marc-Andr=C3=A9?=
 Lureau <marcandre.lureau@redhat.com>,  qemu-rust@nongnu.org,  Zhao Liu
 <zhao1.liu@intel.com>
Subject: Re: [PATCH v2 01/16] rust/qobject: add basic bindings
In-Reply-To: <20260108131043.490084-2-pbonzini@redhat.com> (Paolo Bonzini's
 message of "Thu, 8 Jan 2026 14:10:28 +0100")
References: <20260108131043.490084-1-pbonzini@redhat.com>
 <20260108131043.490084-2-pbonzini@redhat.com>
Date: Tue, 24 Feb 2026 11:03:54 +0100
Message-ID: <87jyw24fw5.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1.179, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.717,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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

> This is only a basic API, intended to be used by the serde traits.
>
> Co-authored-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  include/qobject/qobject.h    |   5 +-
>  rust/util/wrapper.h          |   7 +
>  rust/util/meson.build        |   6 +-
>  rust/util/src/lib.rs         |   4 +
>  rust/util/src/qobject/mod.rs | 331 +++++++++++++++++++++++++++++++++++
>  5 files changed, 350 insertions(+), 3 deletions(-)
>  create mode 100644 rust/util/src/qobject/mod.rs
>
> diff --git a/include/qobject/qobject.h b/include/qobject/qobject.h
> index 02f4c6a6eb2..567da7b6c51 100644
> --- a/include/qobject/qobject.h
> +++ b/include/qobject/qobject.h
> @@ -35,7 +35,10 @@
>  #include "qemu/atomic.h"
>  #include "qapi/qapi-builtin-types.h"
>=20=20
> -/* Not for use outside include/qobject/ */
> +/*
> + * Not for use outside include/qobject/ (and Rust bindings, when they
> + * have to redo inline functions here).

Suggest "defined here".

> + */
>  struct QObjectBase_ {
>      QType type;
>      size_t refcnt;
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

Is this file just for bindgen, and never actually fed to the C compiler?

> diff --git a/rust/util/meson.build b/rust/util/meson.build
> index 98629394afb..28593286134 100644
> --- a/rust/util/meson.build
> +++ b/rust/util/meson.build
> @@ -37,8 +37,10 @@ _util_rs =3D static_library(
>        'src/prelude.rs',
>        'src/timer.rs',
>      ],
> -    {'.': _util_bindings_inc_rs}
> -  ),
> +    {'.': _util_bindings_inc_rs,
> +    'qobject': [
> +      'src/qobject/mod.rs',
> +    ]}),
>    dependencies: [anyhow_rs, libc_rs, foreign_rs, glib_sys_rs, common_rs],
>  )
>=20=20
> diff --git a/rust/util/src/lib.rs b/rust/util/src/lib.rs
> index 7d2de3ed811..96334466895 100644
> --- a/rust/util/src/lib.rs
> +++ b/rust/util/src/lib.rs
> @@ -9,6 +9,10 @@
>  // for prelude-like modules
>  #[rustfmt::skip]
>  pub mod prelude;
> +
> +#[macro_use]
> +pub mod qobject;
> +
>  pub mod timer;
>=20=20
>  pub use error::{Error, Result, ResultExt};
> diff --git a/rust/util/src/qobject/mod.rs b/rust/util/src/qobject/mod.rs
> new file mode 100644
> index 00000000000..5744870ad1c
> --- /dev/null
> +++ b/rust/util/src/qobject/mod.rs
> @@ -0,0 +1,331 @@
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
> +
> +// SAFETY: the QObject API are not thread-safe other than reference coun=
ting;
> +// but the Rust struct is only created once the contents are stable, and
> +// therefore it obeys the aliased XOR mutable invariant.
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
> +    /// without decreasing the reference count; therefore, the reference
> +    /// is transferred to the `*mut bindings::QObject`.
> +    pub fn into_raw(self) -> *mut bindings::QObject {
> +        let src =3D ManuallyDrop::new(self);
> +        src.0.get()
> +    }
> +
> +    /// Construct a [`QObject`] from a C `QObjectBase` pointer.
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
> +/// Rust equivalent of the C `QOBJECT` macro; for internal use only, bec=
ause
> +/// all access should go through `From` (which already returns [`QObject=
`]
> +/// or serde.

(which already returns [`QObject`]),

> +macro_rules! qobject {
> +    ($qobj:expr) =3D> {{
> +        let qobj: &bindings::QObjectBase_ =3D &$qobj.base;
> +        // SAFETY: this `let` guarantees that either $qobj is a reference
> +        // (not a raw pointer), or we're in an outer unsafe block
> +        unsafe { QObject::from_base(qobj) }
> +    }};
> +}
> +
> +impl From<()> for QObject {
> +    fn from(_null: ()) -> Self {
> +        // Conversion of the C inline `qnull` function
> +        unsafe { QObject::cloned_from_base(addr_of!(bindings::qnull_.bas=
e)) }
> +    }
> +}

Could we call C qnull() instead of using qnull_.base?

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
> +        qobject!(qobj)
> +    }
> +}
> +
> +macro_rules! impl_from_return_qnum_int {
> +    ($t:ty) =3D> {
> +        impl From<$t> for QObject {
> +            fn from(n: $t) -> Self {
> +                let qobj =3D unsafe { &*bindings::qnum_from_int(n.into()=
) };
> +                qobject!(qobj)
> +            }
> +        }
> +    };
> +}
> +
> +impl_from_return_qnum_int!(i8);
> +impl_from_return_qnum_int!(i16);
> +impl_from_return_qnum_int!(i32);
> +impl_from_return_qnum_int!(i64);
> +
> +macro_rules! impl_from_return_qnum_uint {
> +    ($t:ty) =3D> {
> +        impl From<$t> for QObject {
> +            fn from(n: $t) -> Self {
> +                let qobj =3D unsafe { &*bindings::qnum_from_uint(n.into(=
)) };
> +                qobject!(qobj)
> +            }
> +        }
> +    };
> +}
> +
> +impl_from_return_qnum_uint!(u8);
> +impl_from_return_qnum_uint!(u16);
> +impl_from_return_qnum_uint!(u32);
> +impl_from_return_qnum_uint!(u64);
> +
> +macro_rules! impl_from_return_qnum_double {
> +    ($t:ty) =3D> {
> +        impl From<$t> for QObject {
> +            fn from(n: $t) -> Self {
> +                let qobj =3D unsafe { &*bindings::qnum_from_double(n.int=
o()) };
> +                qobject!(qobj)
> +            }
> +        }
> +    };
> +}
> +
> +impl_from_return_qnum_double!(f32);
> +impl_from_return_qnum_double!(f64);
> +
> +impl From<CString> for QObject {
> +    fn from(s: CString) -> Self {
> +        let qobj =3D unsafe { &*bindings::qstring_from_str(s.as_ptr()) };
> +        qobject!(qobj)
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
> +        qobject!(qlist)
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
> +        qobject!(qdict)
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
> +                        _ =3D> {} // evaluate $other
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


