Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08CD4E77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 09:18:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOCfG-0002fR-KP; Thu, 19 Dec 2024 04:17:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1tOCfE-0002f4-Ja
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 04:17:48 -0500
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1tOCfB-00070G-PF
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 04:17:48 -0500
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-aabbb507998so101080866b.2
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 01:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734599863; x=1735204663; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:to:from:date:from:to:cc:subject:date:message-id
 :reply-to; bh=P6DuchlNgu4ElupWrhNiwqN+5vtXUVIHX7nuFLs1VJw=;
 b=XXE5YsbRG30CmMeys9rj3udGV9vmq56QXnUznHbtNP7SpUl9aEwnRUbS+ct3zcA80g
 spP6f8cNGAW9+PbVdpBRfHgbqxnn4AqpBXYaLCdICGNFL8NazJcRVsIqyrwncuib95V8
 otrVdH2WcgG0NDb20gsgvNSjefFC9HJ6wocGM5ah4IpF0x+B9oCrzCb+chlYTBSczQ7d
 M5iY56jT3ReoJ+vgJZ93wobsidoe5iqIYGkRnfDHfRnh4mH76Hj8/GGrD68eMJQxP7af
 jiKdyqx9d//tCGgzDjqIOkcl9h8xMQalG0J8HUoxCKukZ1ioMUa6ET0rgoZbo9M8rzoQ
 byLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734599863; x=1735204663;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P6DuchlNgu4ElupWrhNiwqN+5vtXUVIHX7nuFLs1VJw=;
 b=XG1ApFxukkzF6TSE5r/j18fMLUplmsKm171aD+X111s3p4cRiLCxugpZxu2nTPzm/z
 aYc4GA74PQha/8coH0ou0vYg8lLinXGqj8D8BPyxJO+T7hwL7vqnDnbrM+aRtpHybiZ3
 Hw5qnJ0n0Z5TovUjOIkcxCt6Yd7iuEteOxYUmUgyGg1YCc7FJguYgPQ+qoCKVTt90ozc
 oBLHYDb/4rwtVTHpYBvJOYU0HJ4iVeeQ7HTWun4oh6StjWMjnk64plmGuwZO670xptF2
 FQc5zANxsmZ70WCO0UMLb0KolWb4LogjH9GvcpvPs4G8yP4ras7cE0+SDKP288MVoiqe
 lYxQ==
X-Gm-Message-State: AOJu0Yy5pOv4Ngtn7TTBUnD+UOa3C0lqHOApbcPnDGhEVUC3hEroeL6P
 V3IUhDT8F3O8MltUCyLnNfl2yqds/6w5+xhSo6e/aguDJc29L4FevM25hQ==
X-Gm-Gg: ASbGncuIfHoKMSjtsguRWkrERyac8UIKOSmOV42vhZgBtSFZ0DGUksoBuocqKAtNCVN
 zgTrMWQJb8uPmOQxKdV9b3PF+57IQY3BemnyGoA09y/+3uDN0N65sx0lSgjRcGNszW6EqW9mqNY
 vH1BpxmAlhL/6UnMIZk9eavIdmZUuRp0fYlLxAG4Sh3SoQxw0ZGLnLYztdAvC1s8z1JVU8pOGj5
 ZRPOLN7ezBsxEeu7eaqwWwVlPxyR13Cc0DUxFF0Xs+vK97rTiBL1NMG5Ri25SvDWYXVbSNBG/9E
 Sis1vMSg6QiF9eTJ8wuvsM3bai88UIU=
X-Google-Smtp-Source: AGHT+IEwE0TCUu+Uh4O1YhYrPkiU2mZ70inzCXupi2QUfEvU7Pa6OUyjXW3pdKxaikBfPd5KJksifA==
X-Received: by 2002:a17:906:6a04:b0:aa6:7107:db00 with SMTP id
 a640c23a62f3a-aabf496e77emr466128466b.50.1734599863037; 
 Thu, 19 Dec 2024 01:17:43 -0800 (PST)
Received: from [127.0.0.1] (dynamic-077-191-068-081.77.191.pool.telefonica.de.
 [77.191.68.81]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aac0f05ee5esm43098466b.171.2024.12.19.01.17.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Dec 2024 01:17:42 -0800 (PST)
Date: Thu, 19 Dec 2024 09:17:33 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PULL 37/49] rust: cell: add BQL-enforcing RefCell variant
In-Reply-To: <20241211162720.320070-38-pbonzini@redhat.com>
References: <20241211162720.320070-1-pbonzini@redhat.com>
 <20241211162720.320070-38-pbonzini@redhat.com>
Message-ID: <8402250C-2E92-4F8A-B989-B72AC087CC09@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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



Am 11=2E Dezember 2024 16:27:07 UTC schrieb Paolo Bonzini <pbonzini@redhat=
=2Ecom>:
>Similar to the existing BqlCell, introduce a custom interior mutability
>primitive that resembles RefCell but accounts for QEMU's threading model=
=2E
>Borrowing the RefCell requires proving that the BQL is held, and
>attempting to access without the BQL is a runtime panic=2E
>
>Almost all of the code was taken from Rust's standard library, while
>removing unstable features and probably-unnecessary functionality that
>amounts to 60% of the original code=2E  A lot of what's left is documenta=
tion,
>as well as unit tests in the form of doctests=2E  These are not yet integ=
rated
>in "make check" but can be run with "cargo test --doc"=2E
>
>Signed-off-by: Paolo Bonzini <pbonzini@redhat=2Ecom>
>---
> rust/qemu-api/Cargo=2Etoml  |   3 +-
> rust/qemu-api/meson=2Ebuild |   3 +
> rust/qemu-api/src/cell=2Ers | 544 +++++++++++++++++++++++++++++++++++++-
> 3 files changed, 539 insertions(+), 11 deletions(-)
>
>diff --git a/rust/qemu-api/Cargo=2Etoml b/rust/qemu-api/Cargo=2Etoml
>index 669f288d1cb=2E=2E4aa22f31986 100644
>--- a/rust/qemu-api/Cargo=2Etoml
>+++ b/rust/qemu-api/Cargo=2Etoml
>@@ -20,8 +20,9 @@ qemu_api_macros =3D { path =3D "=2E=2E/qemu-api-macros"=
 }
> version_check =3D "~0=2E9"
>=20
> [features]
>-default =3D []
>+default =3D ["debug_cell"]
> allocator =3D []
>+debug_cell =3D []
>=20
> [lints]
> workspace =3D true
>diff --git a/rust/qemu-api/meson=2Ebuild b/rust/qemu-api/meson=2Ebuild
>index edc21e1a3f8=2E=2Ecacb112c5c3 100644
>--- a/rust/qemu-api/meson=2Ebuild
>+++ b/rust/qemu-api/meson=2Ebuild
>@@ -6,6 +6,9 @@ _qemu_api_cfg =3D run_command(rustc_args,
> if rustc=2Eversion()=2Eversion_compare('>=3D1=2E77=2E0')
>   _qemu_api_cfg +=3D ['--cfg', 'has_offset_of']
> endif
>+if get_option('debug_mutex')
>+  _qemu_api_cfg +=3D ['--feature', 'debug_cell']

That should be:

_qemu_api_cfg +=3D ['--cfg', 'feature=3D"debug_cell"']

otherwise this results in compile error "Unrecogninzed option: 'feature'"

Best regards,
Bernhard

>+endif
>=20
> _qemu_api_rs =3D static_library(
>   'qemu_api',
>diff --git a/rust/qemu-api/src/cell=2Ers b/rust/qemu-api/src/cell=2Ers
>index 2e4ea8d590d=2E=2E28349de291a 100644
>--- a/rust/qemu-api/src/cell=2Ers
>+++ b/rust/qemu-api/src/cell=2Ers
>@@ -46,20 +46,30 @@
> //! parts of a  device must be made mutable in a controlled manner throu=
gh the
> //! use of cell types=2E
> //!
>-//! This module provides a way to do so via the Big QEMU Lock=2E  While
>-//! [`BqlCell<T>`] is essentially the same single-threaded primitive tha=
t is
>-//! available in `std::cell`, the BQL allows it to be used from a multi-=
threaded
>-//! context and to share references across threads, while maintaining Ru=
st's
>-//! safety guarantees=2E  For this reason, unlike its `std::cell` counte=
rpart,
>-//! `BqlCell` implements the `Sync` trait=2E
>+//! [`BqlCell<T>`] and [`BqlRefCell<T>`] allow doing this via the Big QE=
MU Lock=2E
>+//! While they are essentially the same single-threaded primitives that =
are
>+//! available in `std::cell`, the BQL allows them to be used from a
>+//! multi-threaded context and to share references across threads, while
>+//! maintaining Rust's safety guarantees=2E  For this reason, unlike
>+//! their `std::cell` counterparts, `BqlCell` and `BqlRefCell` implement=
 the
>+//! `Sync` trait=2E
> //!
> //! BQL checks are performed in debug builds but can be optimized away i=
n
> //! release builds, providing runtime safety during development with no =
overhead
> //! in production=2E
> //!
>-//! Warning: While `BqlCell` is similar to its `std::cell` counterpart, =
the two
>-//! are not interchangeable=2E Using `std::cell` types in QEMU device
>-//! implementations is usually incorrect and can lead to thread-safety i=
ssues=2E
>+//! The two provide different ways of handling interior mutability=2E
>+//! `BqlRefCell` is best suited for data that is primarily accessed by t=
he
>+//! device's own methods, where multiple reads and writes can be grouped=
 within
>+//! a single borrow and a mutable reference can be passed around=2E  Ins=
tead,
>+//! [`BqlCell`] is a better choice when sharing small pieces of data wit=
h
>+//! external code (especially C code), because it provides simple get/se=
t
>+//! operations that can be used one at a time=2E
>+//!
>+//! Warning: While `BqlCell` and `BqlRefCell` are similar to their `std:=
:cell`
>+//! counterparts, they are not interchangeable=2E Using `std::cell` type=
s in
>+//! QEMU device implementations is usually incorrect and can lead to
>+//! thread-safety issues=2E
> //!
> //! ## `BqlCell<T>`
> //!
>@@ -80,8 +90,37 @@
> //!      returns the replaced value=2E
> //!    - [`set`](BqlCell::set): this method replaces the interior value,
> //!      dropping the replaced value=2E
>+//!
>+//! ## `BqlRefCell<T>`
>+//!
>+//! [`BqlRefCell<T>`] uses Rust's lifetimes to implement "dynamic borrow=
ing", a
>+//! process whereby one can claim temporary, exclusive, mutable access t=
o the
>+//! inner value:
>+//!
>+//! ```ignore
>+//! fn clear_interrupts(&self, val: u32) {
>+//!     // A mutable borrow gives read-write access to the registers
>+//!     let mut regs =3D self=2Eregisters=2Eborrow_mut();
>+//!     let old =3D regs=2Einterrupt_status();
>+//!     regs=2Eupdate_interrupt_status(old & !val);
>+//! }
>+//! ```
>+//!
>+//! Borrows for `BqlRefCell<T>`s are tracked at _runtime_, unlike Rust's=
 native
>+//! reference types which are entirely tracked statically, at compile ti=
me=2E
>+//! Multiple immutable borrows are allowed via [`borrow`](BqlRefCell::bo=
rrow),
>+//! or a single mutable borrow via [`borrow_mut`](BqlRefCell::borrow_mut=
)=2E  The
>+//! thread will panic if these rules are violated or if the BQL is not h=
eld=2E
>=20
>-use std::{cell::UnsafeCell, cmp::Ordering, fmt, mem};
>+use std::{
>+    cell::{Cell, UnsafeCell},
>+    cmp::Ordering,
>+    fmt,
>+    marker::PhantomData,
>+    mem,
>+    ops::{Deref, DerefMut},
>+    ptr::NonNull,
>+};
>=20
> use crate::bindings;
>=20
>@@ -93,6 +132,15 @@ pub fn bql_locked() -> bool {
>     !cfg!(MESON) || unsafe { bindings::bql_locked() }
> }
>=20
>+fn bql_block_unlock(increase: bool) {
>+    if cfg!(MESON) {
>+        // SAFETY: this only adjusts a counter
>+        unsafe {
>+            bindings::bql_block_unlock(increase);
>+        }
>+    }
>+}
>+
> /// A mutable memory location that is protected by the Big QEMU Lock=2E
> ///
> /// # Memory layout
>@@ -296,3 +344,479 @@ pub fn take(&self) -> T {
>         self=2Ereplace(Default::default())
>     }
> }
>+
>+/// A mutable memory location with dynamically checked borrow rules,
>+/// protected by the Big QEMU Lock=2E
>+///
>+/// See the [module-level documentation](self) for more=2E
>+///
>+/// # Memory layout
>+///
>+/// `BqlRefCell<T>` starts with the same in-memory representation as its
>+/// inner type `T`=2E
>+#[repr(C)]
>+pub struct BqlRefCell<T> {
>+    // It is important that this is the first field (which is not the ca=
se
>+    // for std::cell::BqlRefCell), so that we can use offset_of! on it=
=2E
>+    // UnsafeCell and repr(C) both prevent usage of niches=2E
>+    value: UnsafeCell<T>,
>+    borrow: Cell<BorrowFlag>,
>+    // Stores the location of the earliest currently active borrow=2E
>+    // This gets updated whenever we go from having zero borrows
>+    // to having a single borrow=2E When a borrow occurs, this gets incl=
uded
>+    // in the panic message
>+    #[cfg(feature =3D "debug_cell")]
>+    borrowed_at: Cell<Option<&'static std::panic::Location<'static>>>,
>+}
>+
>+// Positive values represent the number of `BqlRef` active=2E Negative v=
alues
>+// represent the number of `BqlRefMut` active=2E Right now QEMU's implem=
entation
>+// does not allow to create `BqlRefMut`s that refer to distinct, nonover=
lapping
>+// components of a `BqlRefCell` (e=2Eg=2E, different ranges of a slice)=
=2E
>+//
>+// `BqlRef` and `BqlRefMut` are both two words in size, and so there wil=
l likely
>+// never be enough `BqlRef`s or `BqlRefMut`s in existence to overflow ha=
lf of
>+// the `usize` range=2E Thus, a `BorrowFlag` will probably never overflo=
w or
>+// underflow=2E However, this is not a guarantee, as a pathological prog=
ram could
>+// repeatedly create and then mem::forget `BqlRef`s or `BqlRefMut`s=2E T=
hus, all
>+// code must explicitly check for overflow and underflow in order to avo=
id
>+// unsafety, or at least behave correctly in the event that overflow or
>+// underflow happens (e=2Eg=2E, see BorrowRef::new)=2E
>+type BorrowFlag =3D isize;
>+const UNUSED: BorrowFlag =3D 0;
>+
>+#[inline(always)]
>+const fn is_writing(x: BorrowFlag) -> bool {
>+    x < UNUSED
>+}
>+
>+#[inline(always)]
>+const fn is_reading(x: BorrowFlag) -> bool {
>+    x > UNUSED
>+}
>+
>+impl<T> BqlRefCell<T> {
>+    /// Creates a new `BqlRefCell` containing `value`=2E
>+    ///
>+    /// # Examples
>+    ///
>+    /// ```
>+    /// use qemu_api::cell::BqlRefCell;
>+    ///
>+    /// let c =3D BqlRefCell::new(5);
>+    /// ```
>+    #[inline]
>+    pub const fn new(value: T) -> BqlRefCell<T> {
>+        BqlRefCell {
>+            value: UnsafeCell::new(value),
>+            borrow: Cell::new(UNUSED),
>+            #[cfg(feature =3D "debug_cell")]
>+            borrowed_at: Cell::new(None),
>+        }
>+    }
>+}
>+
>+// This ensures the panicking code is outlined from `borrow_mut` for
>+// `BqlRefCell`=2E
>+#[inline(never)]
>+#[cold]
>+#[cfg(feature =3D "debug_cell")]
>+fn panic_already_borrowed(source: &Cell<Option<&'static std::panic::Loca=
tion<'static>>>) -> ! {
>+    // If a borrow occurred, then we must already have an outstanding bo=
rrow,
>+    // so `borrowed_at` will be `Some`
>+    panic!("already borrowed at {:?}", source=2Etake()=2Eunwrap())
>+}
>+
>+#[inline(never)]
>+#[cold]
>+#[cfg(not(feature =3D "debug_cell"))]
>+fn panic_already_borrowed() -> ! {
>+    panic!("already borrowed")
>+}
>+
>+impl<T> BqlRefCell<T> {
>+    #[inline]
>+    #[allow(clippy::unused_self)]
>+    fn panic_already_borrowed(&self) -> ! {
>+        #[cfg(feature =3D "debug_cell")]
>+        {
>+            panic_already_borrowed(&self=2Eborrowed_at)
>+        }
>+        #[cfg(not(feature =3D "debug_cell"))]
>+        {
>+            panic_already_borrowed()
>+        }
>+    }
>+
>+    /// Immutably borrows the wrapped value=2E
>+    ///
>+    /// The borrow lasts until the returned `BqlRef` exits scope=2E Mult=
iple
>+    /// immutable borrows can be taken out at the same time=2E
>+    ///
>+    /// # Panics
>+    ///
>+    /// Panics if the value is currently mutably borrowed=2E
>+    ///
>+    /// # Examples
>+    ///
>+    /// ```
>+    /// use qemu_api::cell::BqlRefCell;
>+    ///
>+    /// let c =3D BqlRefCell::new(5);
>+    ///
>+    /// let borrowed_five =3D c=2Eborrow();
>+    /// let borrowed_five2 =3D c=2Eborrow();
>+    /// ```
>+    ///
>+    /// An example of panic:
>+    ///
>+    /// ```should_panic
>+    /// use qemu_api::cell::BqlRefCell;
>+    ///
>+    /// let c =3D BqlRefCell::new(5);
>+    ///
>+    /// let m =3D c=2Eborrow_mut();
>+    /// let b =3D c=2Eborrow(); // this causes a panic
>+    /// ```
>+    #[inline]
>+    #[track_caller]
>+    pub fn borrow(&self) -> BqlRef<'_, T> {
>+        if let Some(b) =3D BorrowRef::new(&self=2Eborrow) {
>+            // `borrowed_at` is always the *first* active borrow
>+            if b=2Eborrow=2Eget() =3D=3D 1 {
>+                #[cfg(feature =3D "debug_cell")]
>+                self=2Eborrowed_at=2Eset(Some(std::panic::Location::call=
er()));
>+            }
>+
>+            bql_block_unlock(true);
>+
>+            // SAFETY: `BorrowRef` ensures that there is only immutable =
access
>+            // to the value while borrowed=2E
>+            let value =3D unsafe { NonNull::new_unchecked(self=2Evalue=
=2Eget()) };
>+            BqlRef { value, borrow: b }
>+        } else {
>+            self=2Epanic_already_borrowed()
>+        }
>+    }
>+
>+    /// Mutably borrows the wrapped value=2E
>+    ///
>+    /// The borrow lasts until the returned `BqlRefMut` or all `BqlRefMu=
t`s
>+    /// derived from it exit scope=2E The value cannot be borrowed while=
 this
>+    /// borrow is active=2E
>+    ///
>+    /// # Panics
>+    ///
>+    /// Panics if the value is currently borrowed=2E
>+    ///
>+    /// # Examples
>+    ///
>+    /// ```
>+    /// use qemu_api::cell::BqlRefCell;
>+    ///
>+    /// let c =3D BqlRefCell::new("hello"=2Eto_owned());
>+    ///
>+    /// *c=2Eborrow_mut() =3D "bonjour"=2Eto_owned();
>+    ///
>+    /// assert_eq!(&*c=2Eborrow(), "bonjour");
>+    /// ```
>+    ///
>+    /// An example of panic:
>+    ///
>+    /// ```should_panic
>+    /// use qemu_api::cell::BqlRefCell;
>+    ///
>+    /// let c =3D BqlRefCell::new(5);
>+    /// let m =3D c=2Eborrow();
>+    ///
>+    /// let b =3D c=2Eborrow_mut(); // this causes a panic
>+    /// ```
>+    #[inline]
>+    #[track_caller]
>+    pub fn borrow_mut(&self) -> BqlRefMut<'_, T> {
>+        if let Some(b) =3D BorrowRefMut::new(&self=2Eborrow) {
>+            #[cfg(feature =3D "debug_cell")]
>+            {
>+                self=2Eborrowed_at=2Eset(Some(std::panic::Location::call=
er()));
>+            }
>+
>+            // SAFETY: this only adjusts a counter
>+            bql_block_unlock(true);
>+
>+            // SAFETY: `BorrowRefMut` guarantees unique access=2E
>+            let value =3D unsafe { NonNull::new_unchecked(self=2Evalue=
=2Eget()) };
>+            BqlRefMut {
>+                value,
>+                _borrow: b,
>+                marker: PhantomData,
>+            }
>+        } else {
>+            self=2Epanic_already_borrowed()
>+        }
>+    }
>+
>+    /// Returns a raw pointer to the underlying data in this cell=2E
>+    ///
>+    /// # Examples
>+    ///
>+    /// ```
>+    /// use qemu_api::cell::BqlRefCell;
>+    ///
>+    /// let c =3D BqlRefCell::new(5);
>+    ///
>+    /// let ptr =3D c=2Eas_ptr();
>+    /// ```
>+    #[inline]
>+    pub const fn as_ptr(&self) -> *mut T {
>+        self=2Evalue=2Eget()
>+    }
>+}
>+
>+// SAFETY: Same as for std::sync::Mutex=2E  In the end this is a Mutex t=
hat is
>+// stored out-of-line=2E  Even though BqlRefCell includes Cells, they ar=
e
>+// themselves protected by the Big QEMU Lock=2E  Furtheremore, the Big Q=
EMU
>+// Lock cannot be released while any borrows is active=2E
>+unsafe impl<T> Send for BqlRefCell<T> where T: Send {}
>+unsafe impl<T> Sync for BqlRefCell<T> {}
>+
>+impl<T: Clone> Clone for BqlRefCell<T> {
>+    /// # Panics
>+    ///
>+    /// Panics if the value is currently mutably borrowed=2E
>+    #[inline]
>+    #[track_caller]
>+    fn clone(&self) -> BqlRefCell<T> {
>+        BqlRefCell::new(self=2Eborrow()=2Eclone())
>+    }
>+
>+    /// # Panics
>+    ///
>+    /// Panics if `source` is currently mutably borrowed=2E
>+    #[inline]
>+    #[track_caller]
>+    fn clone_from(&mut self, source: &Self) {
>+        self=2Evalue=2Eget_mut()=2Eclone_from(&source=2Eborrow())
>+    }
>+}
>+
>+impl<T: Default> Default for BqlRefCell<T> {
>+    /// Creates a `BqlRefCell<T>`, with the `Default` value for T=2E
>+    #[inline]
>+    fn default() -> BqlRefCell<T> {
>+        BqlRefCell::new(Default::default())
>+    }
>+}
>+
>+impl<T: PartialEq> PartialEq for BqlRefCell<T> {
>+    /// # Panics
>+    ///
>+    /// Panics if the value in either `BqlRefCell` is currently mutably
>+    /// borrowed=2E
>+    #[inline]
>+    fn eq(&self, other: &BqlRefCell<T>) -> bool {
>+        *self=2Eborrow() =3D=3D *other=2Eborrow()
>+    }
>+}
>+
>+impl<T: Eq> Eq for BqlRefCell<T> {}
>+
>+impl<T: PartialOrd> PartialOrd for BqlRefCell<T> {
>+    /// # Panics
>+    ///
>+    /// Panics if the value in either `BqlRefCell` is currently mutably
>+    /// borrowed=2E
>+    #[inline]
>+    fn partial_cmp(&self, other: &BqlRefCell<T>) -> Option<Ordering> {
>+        self=2Eborrow()=2Epartial_cmp(&*other=2Eborrow())
>+    }
>+}
>+
>+impl<T: Ord> Ord for BqlRefCell<T> {
>+    /// # Panics
>+    ///
>+    /// Panics if the value in either `BqlRefCell` is currently mutably
>+    /// borrowed=2E
>+    #[inline]
>+    fn cmp(&self, other: &BqlRefCell<T>) -> Ordering {
>+        self=2Eborrow()=2Ecmp(&*other=2Eborrow())
>+    }
>+}
>+
>+impl<T> From<T> for BqlRefCell<T> {
>+    /// Creates a new `BqlRefCell<T>` containing the given value=2E
>+    fn from(t: T) -> BqlRefCell<T> {
>+        BqlRefCell::new(t)
>+    }
>+}
>+
>+struct BorrowRef<'b> {
>+    borrow: &'b Cell<BorrowFlag>,
>+}
>+
>+impl<'b> BorrowRef<'b> {
>+    #[inline]
>+    fn new(borrow: &'b Cell<BorrowFlag>) -> Option<BorrowRef<'b>> {
>+        let b =3D borrow=2Eget()=2Ewrapping_add(1);
>+        if !is_reading(b) {
>+            // Incrementing borrow can result in a non-reading value (<=
=3D 0) in these cases:
>+            // 1=2E It was < 0, i=2Ee=2E there are writing borrows, so w=
e can't allow a read
>+            //    borrow due to Rust's reference aliasing rules
>+            // 2=2E It was isize::MAX (the max amount of reading borrows=
) and it overflowed
>+            //    into isize::MIN (the max amount of writing borrows) so=
 we can't allow an
>+            //    additional read borrow because isize can't represent s=
o many read borrows
>+            //    (this can only happen if you mem::forget more than a s=
mall constant amount
>+            //    of `BqlRef`s, which is not good practice)
>+            None
>+        } else {
>+            // Incrementing borrow can result in a reading value (> 0) i=
n these cases:
>+            // 1=2E It was =3D 0, i=2Ee=2E it wasn't borrowed, and we ar=
e taking the first read
>+            //    borrow
>+            // 2=2E It was > 0 and < isize::MAX, i=2Ee=2E there were rea=
d borrows, and isize is
>+            //    large enough to represent having one more read borrow
>+            borrow=2Eset(b);
>+            Some(BorrowRef { borrow })
>+        }
>+    }
>+}
>+
>+impl Drop for BorrowRef<'_> {
>+    #[inline]
>+    fn drop(&mut self) {
>+        let borrow =3D self=2Eborrow=2Eget();
>+        debug_assert!(is_reading(borrow));
>+        self=2Eborrow=2Eset(borrow - 1);
>+        bql_block_unlock(false)
>+    }
>+}
>+
>+impl Clone for BorrowRef<'_> {
>+    #[inline]
>+    fn clone(&self) -> Self {
>+        BorrowRef::new(self=2Eborrow)=2Eunwrap()
>+    }
>+}
>+
>+/// Wraps a borrowed reference to a value in a `BqlRefCell` box=2E
>+/// A wrapper type for an immutably borrowed value from a `BqlRefCell<T>=
`=2E
>+///
>+/// See the [module-level documentation](self) for more=2E
>+pub struct BqlRef<'b, T: 'b> {
>+    // NB: we use a pointer instead of `&'b T` to avoid `noalias` violat=
ions, because a
>+    // `BqlRef` argument doesn't hold immutability for its whole scope, =
only until it drops=2E
>+    // `NonNull` is also covariant over `T`, just like we would have wit=
h `&T`=2E
>+    value: NonNull<T>,
>+    borrow: BorrowRef<'b>,
>+}
>+
>+impl<T> Deref for BqlRef<'_, T> {
>+    type Target =3D T;
>+
>+    #[inline]
>+    fn deref(&self) -> &T {
>+        // SAFETY: the value is accessible as long as we hold our borrow=
=2E
>+        unsafe { self=2Evalue=2Eas_ref() }
>+    }
>+}
>+
>+impl<'b, T> BqlRef<'b, T> {
>+    /// Copies a `BqlRef`=2E
>+    ///
>+    /// The `BqlRefCell` is already immutably borrowed, so this cannot f=
ail=2E
>+    ///
>+    /// This is an associated function that needs to be used as
>+    /// `BqlRef::clone(=2E=2E=2E)`=2E A `Clone` implementation or a meth=
od would
>+    /// interfere with the widespread use of `r=2Eborrow()=2Eclone()` to=
 clone
>+    /// the contents of a `BqlRefCell`=2E
>+    #[must_use]
>+    #[inline]
>+    #[allow(clippy::should_implement_trait)]
>+    pub fn clone(orig: &BqlRef<'b, T>) -> BqlRef<'b, T> {
>+        BqlRef {
>+            value: orig=2Evalue,
>+            borrow: orig=2Eborrow=2Eclone(),
>+        }
>+    }
>+}
>+
>+impl<T: fmt::Debug> fmt::Debug for BqlRef<'_, T> {
>+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
>+        (**self)=2Efmt(f)
>+    }
>+}
>+
>+impl<T: fmt::Display> fmt::Display for BqlRef<'_, T> {
>+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
>+        (**self)=2Efmt(f)
>+    }
>+}
>+
>+struct BorrowRefMut<'b> {
>+    borrow: &'b Cell<BorrowFlag>,
>+}
>+
>+impl<'b> BorrowRefMut<'b> {
>+    #[inline]
>+    fn new(borrow: &'b Cell<BorrowFlag>) -> Option<BorrowRefMut<'b>> {
>+        // There must currently be no existing references when borrow_mu=
t() is
>+        // called, so we explicitly only allow going from UNUSED to UNUS=
ED - 1=2E
>+        match borrow=2Eget() {
>+            UNUSED =3D> {
>+                borrow=2Eset(UNUSED - 1);
>+                Some(BorrowRefMut { borrow })
>+            }
>+            _ =3D> None,
>+        }
>+    }
>+}
>+
>+impl Drop for BorrowRefMut<'_> {
>+    #[inline]
>+    fn drop(&mut self) {
>+        let borrow =3D self=2Eborrow=2Eget();
>+        debug_assert!(is_writing(borrow));
>+        self=2Eborrow=2Eset(borrow + 1);
>+        bql_block_unlock(false)
>+    }
>+}
>+
>+/// A wrapper type for a mutably borrowed value from a `BqlRefCell<T>`=
=2E
>+///
>+/// See the [module-level documentation](self) for more=2E
>+pub struct BqlRefMut<'b, T: 'b> {
>+    // NB: we use a pointer instead of `&'b mut T` to avoid `noalias` vi=
olations, because a
>+    // `BqlRefMut` argument doesn't hold exclusivity for its whole scope=
, only until it drops=2E
>+    value: NonNull<T>,
>+    _borrow: BorrowRefMut<'b>,
>+    // `NonNull` is covariant over `T`, so we need to reintroduce invari=
ance=2E
>+    marker: PhantomData<&'b mut T>,
>+}
>+
>+impl<T> Deref for BqlRefMut<'_, T> {
>+    type Target =3D T;
>+
>+    #[inline]
>+    fn deref(&self) -> &T {
>+        // SAFETY: the value is accessible as long as we hold our borrow=
=2E
>+        unsafe { self=2Evalue=2Eas_ref() }
>+    }
>+}
>+
>+impl<T> DerefMut for BqlRefMut<'_, T> {
>+    #[inline]
>+    fn deref_mut(&mut self) -> &mut T {
>+        // SAFETY: the value is accessible as long as we hold our borrow=
=2E
>+        unsafe { self=2Evalue=2Eas_mut() }
>+    }
>+}
>+
>+impl<T: fmt::Debug> fmt::Debug for BqlRefMut<'_, T> {
>+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
>+        (**self)=2Efmt(f)
>+    }
>+}
>+
>+impl<T: fmt::Display> fmt::Display for BqlRefMut<'_, T> {
>+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
>+        (**self)=2Efmt(f)
>+    }
>+}

