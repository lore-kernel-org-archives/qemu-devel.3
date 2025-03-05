Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E10CC282D9
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 02:44:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpejh-0006mj-RD; Tue, 04 Mar 2025 21:43:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tpejg-0006lx-Ga; Tue, 04 Mar 2025 21:43:52 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tpeje-0005R4-0u; Tue, 04 Mar 2025 21:43:52 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-219f8263ae0so118025965ad.0; 
 Tue, 04 Mar 2025 18:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741142628; x=1741747428; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5sppU0FCF9jDLgCOEFiKj3D933OKeDqndzQMLl816kU=;
 b=WzC4HYib8BMR7eHP5vTFnDS440mzu5a8Xsn15t4j12GlAVoKpJuK+ubixIEj6P3slz
 nsas16svN97AAJ0gPHkJMyUzpoCLRi4TP5rRDfZpeRuX5MueNY67Qkk0XK7Io5HVVaef
 uPMEZbf14u75/ZnTZns4hyrsvSLO31GiampnlbDdGJCDr689Z7XmN4JCsO67DGsSRhSa
 B4WDQoP3v3STrHtbEnt9kgtwp24vlpMkcKpoE7crlEVbFKf2AYtbADHJpy5cMb61Ywky
 R91yXQMAddr9a/sk6DtMKPIv6IGMEhLvu9+5uhj2cMaPQ9wNTYeBPpjl0gr9ABkW5R6Y
 LzDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741142628; x=1741747428;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5sppU0FCF9jDLgCOEFiKj3D933OKeDqndzQMLl816kU=;
 b=a7apjXCvBGflf8ohI729Nv5ZHHjh+bKJfuD0bvLU8NzPeS4Vg0sNW9pV7XA2nCiC/x
 F2y+gkRvZM049DS1okmBRPzVR6iGh60OZNyl7Ar0qua7RSGygwl9NPeeBne8tJneja8c
 Mq47cOd6+hJNIInLpQDNe1+Q2++2RuiwMeD3RzKs8W5WEFyi2BFbFrftBLaLzkcWUqHp
 OtDbLuMElFNjMKXs8psiHXe/l1HYZCX1QbIEm0UtPgXmmvTn8puLMuYRVcflyEKvI1xa
 2GtZE855ztTeknI1sfacRYNOFt2yWmNCH9YjvagCBokVqFRPCKunkdS5Yer2s6fuMJ0j
 1hHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcN68KZk37Fhb1oKSzCIQgRv+NDCYLcexQgjSzYFKEsRCm3/YumbowHHWtfdk9PpwvbvRAL2UkO7QF@nongnu.org,
 AJvYcCWZ5HMWxKumxTocZUziViJ4EosK+XUuA3iIbk05G3vcdRaPaJiylULvu5ZM6HU42KIiNAFjJjuKLEKG@nongnu.org
X-Gm-Message-State: AOJu0Ywua7hVfeFzY3R7PpUPBzYj7Nvr/yk7cLsS10p+kHZhlvc+cHya
 pAjSKRCuBnJBCaqHtqNrgj9G75/VKGUF4yJEerKAeVmmrjWsqCnu
X-Gm-Gg: ASbGnctnLX6gsrm9unBPGsNhandERo5y0ooQ1lDXbhBHhi7o1xDUVUEPoFAU0tArhvp
 sM1i67yxv3aLpw5GMp1b3bSCnONwOwQXkPYVlV01nIXh7zKVK4k4tiaaNSL+R/xU4GXIdMK3WiA
 dVtBWDzcur5dYR/MXE+SBudgRSSCwZLVTWMm2XVyaAFDp8g3KzMhKud9QWXIFo/zOhV7r4MGLoK
 HmpLFBsQBsDrPSUVDJjB31rrNSZRjrMf8DLa25YUJ+0onLGFYGBRy/m9dJ43Bt7RpGV8qsomZeA
 pcPu1Ch9rs8K58WYPVzeDW44BOp/zCaLb0qwrgq2G20Km5QJ3t7MF4EYExaIVME=
X-Google-Smtp-Source: AGHT+IEgNIK25Nev1CUtxHsMv0/iUQMVxA1I9lwKZ11r3BddPzgB3PIQP1RXnvALiehWTzmAE9uR1g==
X-Received: by 2002:a05:6a00:14d1:b0:730:8386:6070 with SMTP id
 d2e1a72fcca58-736829cd997mr2143414b3a.0.1741142627301; 
 Tue, 04 Mar 2025 18:43:47 -0800 (PST)
Received: from localhost (n11648126014.netvigator.com. [116.48.126.14])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7349fe48849sm11701791b3a.46.2025.03.04.18.43.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 18:43:46 -0800 (PST)
From: Stefan Hajnoczi <stefanha@gmail.com>
X-Google-Original-From: Stefan Hajnoczi <stefanha@fedora>
Date: Wed, 5 Mar 2025 10:43:42 +0800
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com, pbonzini@redhat.com,
 manos.pitsidianakis@linaro.org, philmd@linaro.org,
 qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH v2 08/11] rust/block: Add driver module
Message-ID: <20250305024342.GB247800@fedora>
References: <20250218182019.111467-1-kwolf@redhat.com>
 <20250218182019.111467-9-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="DnLHf8xUuxM2eJhW"
Content-Disposition: inline
In-Reply-To: <20250218182019.111467-9-kwolf@redhat.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=stefanha@gmail.com; helo=mail-pl1-x629.google.com
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


--DnLHf8xUuxM2eJhW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2025 at 07:20:16PM +0100, Kevin Wolf wrote:
> This adds a barebones module for a block driver interface. Because there
> is no native QAPI support for Rust yet, opening images takes a few
> unsafe functions to call into C visitor functions. This should be
> cleaned up later.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  rust/block/src/driver.rs | 195 +++++++++++++++++++++++++++++++++++++++
>  rust/block/src/lib.rs    |   1 +
>  2 files changed, 196 insertions(+)
>  create mode 100644 rust/block/src/driver.rs
>=20
> diff --git a/rust/block/src/driver.rs b/rust/block/src/driver.rs
> new file mode 100644
> index 0000000000..fe19f4b88f
> --- /dev/null
> +++ b/rust/block/src/driver.rs
> @@ -0,0 +1,195 @@
> +// Copyright Red Hat Inc.
> +// Author(s): Kevin Wolf <kwolf@redhat.com>
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +// All of this is unused until the first block driver is added
> +#![allow(dead_code)]
> +#![allow(unused_macros)]
> +#![allow(unused_imports)]
> +
> +use crate::{IoBuffer, SizedIoBuffer};
> +use qemu_api::bindings;
> +use std::ffi::c_void;
> +use std::io::{self, Error, ErrorKind};
> +use std::mem::MaybeUninit;
> +use std::ptr;
> +
> +/// A trait for writing block drivers.
> +///
> +/// Types that implement this trait can be registered as QEMU block driv=
ers using the
> +/// [`block_driver`] macro.
> +pub trait BlockDriver {

> +    /// The type that contains the block driver specific options for ope=
ning an image
> +    type Options;
> +
> +    // TODO Native support for QAPI types and deserialization
> +    unsafe fn parse_options(
> +        v: &mut bindings::Visitor,
> +        opts: &mut *mut Self::Options,
> +        errp: *mut *mut bindings::Error,
> +    );
> +    unsafe fn free_options(opts: *mut Self::Options);
> +    unsafe fn open(
> +        bs: *mut bindings::BlockDriverState,
> +        opts: &Self::Options,
> +        errp: *mut *mut bindings::Error,
> +    ) -> std::os::raw::c_int;
> +
> +    /// Returns the size of the image in bytes
> +    fn size(&self) -> u64;

I wonder if it makes sense to separate different parts of the
BlockDriver API into multiple traits:
1. Pre-open APIs (open(), probe()?, etc)
2. I/O path - Future or async-based and can run in any thread
3. Control path (size(), close(), reopen()?, etc)

That way the type system guarantees that sub-APIs that are only valid in
a specific state (e.g. when the BlockDriverState is open) cannot be
called.

size() is an example of a method that would benefit from more
fine-grained traits that keep states separated. size() -> u64 doesn't
make sense before open().

What do you think?

> +}
> +
> +/// Represents the connection between a parent and its child node.
> +///
> +/// This is a wrapper around the `BdrvChild` type in C.
> +pub struct BdrvChild {
> +    child: *mut bindings::BdrvChild,
> +}
> +
> +// TODO Represent the graph lock and let the compiler verify it's held w=
hen accessing child
> +unsafe impl Send for BdrvChild {}
> +unsafe impl Sync for BdrvChild {}
> +
> +impl BdrvChild {
> +    /// Creates a new child reference from a `BlockdevRef`.
> +    pub unsafe fn new(
> +        parent: *mut bindings::BlockDriverState,
> +        bref: *mut bindings::BlockdevRef,
> +        errp: *mut *mut bindings::Error,
> +    ) -> Option<Self> {
> +        unsafe {
> +            let child_bs =3D bindings::bdrv_open_blockdev_ref_file(bref,=
 parent, errp);
> +            if child_bs.is_null() {
> +                return None;
> +            }
> +
> +            bindings::bdrv_graph_wrlock();
> +            let child =3D bindings::bdrv_attach_child(
> +                parent,
> +                child_bs,
> +                c"file".as_ptr(),
> +                &bindings::child_of_bds as *const _,
> +                bindings::BDRV_CHILD_IMAGE,
> +                errp,
> +            );
> +            bindings::bdrv_graph_wrunlock();
> +
> +            if child.is_null() {
> +                None
> +            } else {
> +                Some(BdrvChild { child })
> +            }
> +        }
> +    }
> +
> +    /// Reads data from the child node into a linear byte buffer.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `buf` must be a valid I/O buffer that can store at least `bytes`=
 bytes.
> +    pub async unsafe fn read_raw(&self, offset: u64, bytes: usize, buf: =
*mut u8) -> io::Result<()> {
> +        let offset: i64 =3D offset
> +            .try_into()
> +            .map_err(|e| Error::new(ErrorKind::InvalidInput, e))?;
> +        let bytes: i64 =3D bytes
> +            .try_into()
> +            .map_err(|e| Error::new(ErrorKind::InvalidInput, e))?;
> +
> +        let ret =3D unsafe { bindings::bdrv_pread(self.child, offset, by=
tes, buf as *mut c_void, 0) };
> +        if ret < 0 {
> +            Err(Error::from_raw_os_error(-ret))
> +        } else {
> +            Ok(())
> +        }
> +    }
> +
> +    /// Reads data from the child node into a linear typed buffer.
> +    pub async fn read<T: IoBuffer + ?Sized>(&self, offset: u64, buf: &mu=
t T) -> io::Result<()> {
> +        unsafe {
> +            self.read_raw(offset, buf.buffer_len(), buf.buffer_mut_ptr())
> +                .await
> +        }
> +    }
> +
> +    /// Reads data from the child node into a linear, potentially uninit=
ialised typed buffer.
> +    pub async fn read_uninit<T: SizedIoBuffer>(
> +        &self,
> +        offset: u64,
> +        mut buf: Box<MaybeUninit<T>>,
> +    ) -> io::Result<Box<T>> {
> +        unsafe {
> +            self.read_raw(offset, buf.buffer_len(), buf.buffer_mut_ptr())
> +                .await?;
> +            let ptr =3D Box::into_raw(buf) as *mut T;
> +            Ok(Box::from_raw(ptr))
> +        }
> +    }
> +}
> +
> +#[doc(hidden)]
> +pub unsafe extern "C" fn bdrv_open<D: BlockDriver>(
> +    bs: *mut bindings::BlockDriverState,
> +    options: *mut bindings::QDict,
> +    _flags: std::os::raw::c_int,
> +    errp: *mut *mut bindings::Error,
> +) -> std::os::raw::c_int {
> +    unsafe {
> +        let v =3D match bindings::qobject_input_visitor_new_flat_confuse=
d(options, errp).as_mut() {
> +            None =3D> return -libc::EINVAL,
> +            Some(v) =3D> v,
> +        };
> +
> +        let mut opts: *mut D::Options =3D ptr::null_mut();
> +        D::parse_options(v, &mut opts, errp);
> +        bindings::visit_free(v);
> +
> +        let opts =3D match opts.as_mut() {
> +            None =3D> return -libc::EINVAL,
> +            Some(opts) =3D> opts,
> +        };
> +
> +        while let Some(e) =3D bindings::qdict_first(options).as_ref() {
> +            bindings::qdict_del(options, e.key);
> +        }
> +
> +        let ret =3D D::open(bs, opts, errp);
> +        D::free_options(opts);
> +        ret
> +    }
> +}
> +
> +#[doc(hidden)]
> +pub unsafe extern "C" fn bdrv_close<D: BlockDriver>(bs: *mut bindings::B=
lockDriverState) {
> +    unsafe {
> +        let state =3D (*bs).opaque as *mut D;
> +        ptr::drop_in_place(state);
> +    }
> +}
> +
> +/// Declare a format block driver. This macro is meant to be used at the=
 top level.
> +///
> +/// `typ` is a type implementing the [`BlockDriver`] trait to handle the=
 image format with the
> +/// user-visible name `fmtname`.
> +macro_rules! block_driver {
> +    ($fmtname:expr, $typ:ty) =3D> {
> +        const _: () =3D {
> +            static mut BLOCK_DRIVER: ::qemu_api::bindings::BlockDriver =
=3D
> +                ::qemu_api::bindings::BlockDriver {
> +                    format_name: ::qemu_api::c_str!($fmtname).as_ptr(),
> +                    instance_size: ::std::mem::size_of::<$typ>() as i32,
> +                    bdrv_open: Some($crate::driver::bdrv_open::<$typ>),
> +                    bdrv_close: Some($crate::driver::bdrv_close::<$typ>),
> +                    bdrv_child_perm: Some(::qemu_api::bindings::bdrv_def=
ault_perms),
> +                    is_format: true,
> +                    ..::qemu_api::zeroable::Zeroable::ZERO
> +                };
> +
> +            qemu_api::module_init! {
> +                MODULE_INIT_BLOCK =3D> unsafe {
> +                    ::qemu_api::bindings::bdrv_register(std::ptr::addr_o=
f_mut!(BLOCK_DRIVER));
> +                }
> +            }
> +        };
> +    };
> +}
> +pub(crate) use block_driver;
> diff --git a/rust/block/src/lib.rs b/rust/block/src/lib.rs
> index 1c03549821..54ebd480ec 100644
> --- a/rust/block/src/lib.rs
> +++ b/rust/block/src/lib.rs
> @@ -1,3 +1,4 @@
> +mod driver;
>  mod iobuffer;
> =20
>  pub use iobuffer::{IoBuffer, SizedIoBuffer};
> --=20
> 2.48.1
>=20
>=20

--DnLHf8xUuxM2eJhW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmfHul0ACgkQnKSrs4Gr
c8jhFwf/fy29pFvGq1Nj+uSHLFtkwzhsD1c7twoeI4pM6gPswG2o8xTvkYPV8ZHw
k6HFnJbZ0dRiQmqVbuGSy064pPEpKeD485kqo3jLAQWG58jtvYbwjgpJz3+fAmVU
Ru1w543eAxEGWTzgqfUVQG2sSnzNNNc1sjP2paQIEM7xeS+sXQJX62/jBMKRGm1D
xUmOpqpPMvFH0kxyMhVs8hREU/YzAH7CdXXGoGg1QXbKOg8WyLgeclzsRG/2hkug
WJQbgDT7xkRdyojyNWNkSt5JGZzn0L4569w2fXpKjLgfV6deYX9u4FeERg9emrEl
dWZABdwBJ7BXxgM0IYF5TfKfnSAzSA==
=5wlD
-----END PGP SIGNATURE-----

--DnLHf8xUuxM2eJhW--

