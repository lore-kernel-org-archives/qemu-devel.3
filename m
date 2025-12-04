Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62381D2069A
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 13:52:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vR9js-00022B-Lj; Thu, 04 Dec 2025 08:51:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vR9jq-00021G-5N; Thu, 04 Dec 2025 08:51:18 -0500
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vR9jn-0008Ns-Lu; Thu, 04 Dec 2025 08:51:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764856275; x=1796392275;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=EGGGVaj2kauQb09SV9MFwvcfUD+qnSno1YOd+Dsuhq0=;
 b=fpk9gMCqrp6Jp2RcSAWVnvLRleudiPj0r58PgqhlyUuJOcInYKHpZvgN
 x0Fhuo1ex90enC1PdeXF/kXBeuzeA5f+ZZEonJSRGW/UkS9zU26v5wLlb
 f+4Dj4D7g/MR6w8A5Tnc8cipQpteJxOdV1t8ldBrP4PdjYIvTF1Y0PPcz
 xafoBoVQlCOI+uVbgE4bOE+ucBkewCzzS+OqIfyrYAb7Cl3deN3NzruPX
 sx+abvwGzpoJd3OTgwm4IvJ3Vn9O9Mld0KHt/UVRdw1HhKuaStnrDd6oo
 dVKiwBjT37B0eZCp9yw8zwC++tAsXPzatSCG5t9T+TC6hkhCYRw/vjiNG A==;
X-CSE-ConnectionGUID: qypG80ONSsmuREDebzFe2w==
X-CSE-MsgGUID: 2+xONj9TTNGD4W5iESPFdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11632"; a="84271516"
X-IronPort-AV: E=Sophos;i="6.20,249,1758610800"; d="scan'208";a="84271516"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Dec 2025 05:51:11 -0800
X-CSE-ConnectionGUID: k9CJq4nuTDeuSzvBpscQKQ==
X-CSE-MsgGUID: TlB+1gqcSpGxp7lzcUCXcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,249,1758610800"; d="scan'208";a="195413000"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa009.fm.intel.com with ESMTP; 04 Dec 2025 05:51:10 -0800
Date: Thu, 4 Dec 2025 22:15:53 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, armbru@redhat.com,
 marcandre.lureau@redhat.com
Subject: Re: [PATCH 02/14] rust: add basic QObject bindings
Message-ID: <aTGXmfbzug5cQAbV@intel.com>
References: <20251001075005.1041833-1-pbonzini@redhat.com>
 <20251001080051.1043944-3-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001080051.1043944-3-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

> diff --git a/rust/util/src/qobject/mod.rs b/rust/util/src/qobject/mod.rs
> new file mode 100644
> index 00000000000..f43d87a3b66
> --- /dev/null
> +++ b/rust/util/src/qobject/mod.rs
> @@ -0,0 +1,309 @@
> +//! `QObject` bindings
> +//!
> +//! This module implements bindings for QEMU's `QObject` data structure.
> +//! The bindings integrate with `serde`, which take the role of visitors
> +//! in Rust code.
> +
> +#![deny(clippy::unwrap_used)]

Are there are any specific considerations for this lint rule?

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
> +/// Only a bare bones API is public; production and consumption of `QObject`
> +/// generally goes through `serde`.
> +pub struct QObject(&'static UnsafeCell<bindings::QObject>);

It seems Opaque<> feels more natural than UnsafeCell<>.

Opaque::from_raw() requires *mut T, but QObject::from_raw() and
QObject::clone_from_raw() mainly play with C bindings which usually use
*mut pointer. So it seems unnecessary to convert *mut to *const in the
middle.

And furthermore, I think QObject(Opaque<bindings::QObject>) is better
than QObject(&'static Opaque<bindings::QObject>). From a semantic view,
C's QObject is a struct, while Rust's QObject is a reference, which seems
somewhat mismatched.

I'm not sure yet if there may be gaps when remove &'static, but it
looks like using &'static Opaque<> instead of &'static UnsafeCell<> is
Okay in code?

> +    /// Construct a [`QObject`] from a C `QObject` pointer.
> +    /// The caller *does not* cede its reference to the returned struct.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The `QObjectBase` must not be changed from C code while
> +    /// the Rust `QObject` lives
> +    unsafe fn cloned_from_base(p: *const bindings::QObjectBase_) -> Self {
> +        let orig = unsafe { ManuallyDrop::new(QObject::from_base(p)) };
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
> +        let orig = unsafe { ManuallyDrop::new(QObject::from_raw(p)) };
> +        (*orig).clone()
> +    }

These 2 methods are the clone, but it seems they're actually similar to
Owned<>, i.e., increase refcnt when Rust side wants to "own" or ensure
to use this safely.

However, there indeed isn't a non-object version of Owned for now, so I
think this kind of clone should be okay. Hmm, for long-term, is it
valuable to consider a more generic Owned<>?

> +impl<A> FromIterator<A> for QObject
> +where
> +    Self: From<A>,
> +{
> +    fn from_iter<I: IntoIterator<Item = A>>(it: I) -> Self {

nit: maybe the name "iter" is better than "it"?

> +        let qlist = unsafe { &mut *bindings::qlist_new() };
> +        for elem in it {
> +            let elem: QObject = elem.into();
> +            let elem: *mut bindings::QObject = elem.0.get();
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
> +    fn from_iter<I: IntoIterator<Item = (CString, A)>>(it: I) -> Self {

ditto.

> +        let qdict = unsafe { &mut *bindings::qdict_new() };
> +        for (key, val) in it {
> +            let val: QObject = val.into();
> +            let val = val.into_raw();
> +            unsafe {
> +                bindings::qdict_put_obj(qdict, key.as_ptr().cast::<c_char>(), val);
> +            }
> +        }
> +        unsafe { QObject::from_base(addr_of!(qdict.base)) }
> +    }
> +}

I think these the mappings of qdict and qlist look quite good.

> +#[allow(unused)]
> +macro_rules! match_qobject {
> +    (@internal ($qobj:expr) =>
> +        $(() => $unit:expr,)?
> +        $(bool($boolvar:tt) => $bool:expr,)?
> +        $(i64($i64var:tt) => $i64:expr,)?
> +        $(u64($u64var:tt) => $u64:expr,)?
> +        $(f64($f64var:tt) => $f64:expr,)?
> +        $(CStr($cstrvar:tt) => $cstr:expr,)?
> +        $(QList($qlistvar:tt) => $qlist:expr,)?
> +        $(QDict($qdictvar:tt) => $qdict:expr,)?
> +        $(_ => $other:expr,)?
> +    ) => {
> +        loop {
> +            let qobj_ = $qobj.0.get();
> +            match unsafe { &* qobj_ }.base.type_ {
> +                $($crate::bindings::QTYPE_QNULL => break $unit,)?
> +                $($crate::bindings::QTYPE_QBOOL => break {
> +                    let qbool__: *mut $crate::bindings::QBool = qobj_.cast();
> +                    let $boolvar = unsafe { (&*qbool__).value };
> +                    $bool
> +                },)?
> +                $crate::bindings::QTYPE_QNUM => {
> +                    let qnum__: *mut $crate::bindings::QNum = qobj_.cast();
> +                    let qnum__ = unsafe { &*qnum__ };
> +                    match qnum__.kind {
> +                        $crate::bindings::QNUM_I64 |
> +                        $crate::bindings::QNUM_U64 |
> +                        $crate::bindings::QNUM_DOUBLE => {}
> +                        _ => {
> +                            panic!("unreachable");
> +                        }
> +                    }
> +
> +                    match qnum__.kind {
> +                        $($crate::bindings::QNUM_I64 => break {
> +                            let $i64var = unsafe { qnum__.u.i64_ };
> +                            $i64
> +                        },)?
> +                        $($crate::bindings::QNUM_U64 => break {
> +                            let $u64var = unsafe { qnum__.u.u64_ };
> +                            $u64
> +                        },)?
> +                        $($crate::bindings::QNUM_DOUBLE => break {
> +                            let $f64var = unsafe { qnum__.u.dbl };
> +                            $f64
> +                        },)?
> +                        _ => {}

I think this doesn't handle a special case: qobj's QNUM type doesn't
macth the value type, for example, qobj is QNUM_U64 but value is i64.

Though external code won't use this macro, I think panic may be better
than {}?

> +                    }

Thurther, there're 2 match blocks. Could we merge them as one?

diff --git a/rust/util/src/qobject/mod.rs b/rust/util/src/qobject/mod.rs
index 292a3c9c2385..4053a3b7610d 100644
--- a/rust/util/src/qobject/mod.rs
+++ b/rust/util/src/qobject/mod.rs
@@ -280,14 +280,6 @@ macro_rules! match_qobject {
                 $crate::bindings::QTYPE_QNUM => {
                     let qnum__: *mut $crate::bindings::QNum = qobj_.cast();
                     let qnum__ = unsafe { &*qnum__ };
-                    match qnum__.kind {
-                        $crate::bindings::QNUM_I64 |
-                        $crate::bindings::QNUM_U64 |
-                        $crate::bindings::QNUM_DOUBLE => {}
-                        _ => {
-                            panic!("unreachable");
-                        }
-                    }

                     match qnum__.kind {
                         $($crate::bindings::QNUM_I64 => break {
@@ -302,7 +294,9 @@ macro_rules! match_qobject {
                             let $f64var = unsafe { qnum__.u.dbl };
                             $f64
                         },)?
-                        _ => {}
+                        _ => {
+                            panic!("unreachable");
+                        }
                     }
                 },
                 $($crate::bindings::QTYPE_QSTRING => break {


Regards,
Zhao


