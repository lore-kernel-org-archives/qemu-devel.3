Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FECCC282D0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 03:05:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpf3g-0004u6-1f; Tue, 04 Mar 2025 22:04:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tpf3f-0004tQ-14; Tue, 04 Mar 2025 22:04:31 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tpf3c-0000XP-Ac; Tue, 04 Mar 2025 22:04:30 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-223480ea43aso157437345ad.1; 
 Tue, 04 Mar 2025 19:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741143866; x=1741748666; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QLcgE8yUo/zShcOLQFfIjpRxCQoguCjvk3qipznlNXw=;
 b=RdfuHuK8+lj2vmz+YJCoV7Udq3AvZGrFDjU6DwbV3AukhTN2jCilGo/wSGC8pML5V2
 f8ddNUHHVo9cgwVRqgT7yyb9EN6t/kBAP1TZpQGYW/pQgqASe+fVPbJXNEKu9i+uwBG2
 oB0LxITW+QbpLphtFyZw1Mso0zPuewmIpp6ab88jTLY2ljTi96b7uTr+CQh8rQK1pkVZ
 MSlpan1h/BZPWGcNP31rwUlj0D/N1Hl1l1OVcyNQeWtSOROFWKT4O9SMiH42H22jDDXv
 p9tlkPib+W8jTcHltvm7VktkBH2fUSGOiyjCrXOhDXLgSl5UxOw5eO7LJhijzMZeouPy
 3G0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741143866; x=1741748666;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QLcgE8yUo/zShcOLQFfIjpRxCQoguCjvk3qipznlNXw=;
 b=PFtTrbpeDFaa5JSUSkhpBVN3460K3xV6ttOAxkKjLYVBqJB4j1vYa+fpIAsUUMCX9E
 AVMT0A+h7ixNvRKaMceGMb7DlbuvDJQFj2EcNRMjgw2l2kz4uO1hClObxl6hT7m+MzAT
 MlJW3pvFMGrK4xVfuqNhykoga5AkKCIMhz/RsDw+ByXS07utsgRHZLOq0xHIDBgkMn1C
 yvnXBC5e4o6SfadF1BCLynDlwMZ9e1oUmOz+mBwBvz30TY8ioeez10mKLe5XIiMUTuDi
 6Qn3Xo+lPL0yDinGYX7qLFg1vNdOS0k1r4wjnyTYG/I7uJF0PlU5R7EpPoDolTeXgpxq
 jElg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEhIJ+wdVrAQjP/6kyzO7Y12WLz1x9YUeQch2oPNVSIqK7W5SaRdlUbLdnyv7bZ5IrCzoSQ7tCJgB9@nongnu.org,
 AJvYcCXucKJB5ydBwLO0k8dGrG/TOUKOX7l7vs/UCy6cPsvrLArIDJRo34P0M2FZMvWTGsp0QMe9o5v95pP7@nongnu.org
X-Gm-Message-State: AOJu0YzR2cl05DmdpVbE4bpEdeY8iqZMrwtt3G+Y7DkEgKyGqs/c++R2
 LdMB1lfwGKM1Sn0A2622BuFKikxY1+CBE53iH45vc/1fFMX+l+4AtExCz5OQ
X-Gm-Gg: ASbGnct0odWCCZO+hI4eK3eAmUpBw5SZZQHVewjfQH6syPYor+ek7wtXbDVUE8zVmC1
 OVmDe90PbTZrP20xdKl1jMhTFfX0hUMUDmPn8DxrAVstjVKKQh30Z7mPA9ajvsIiUMcVIoPYLfR
 mo4iWu6pgWfJzZj/y/bWYtLQnwVcPCbDmBJXgTTgGD+AlaP2hi0EOtcEo6HOAXrSw0GzGVA2XzK
 LSVVY30Xitxgz+YXqnlQyAFYC0j6OvZtQl6Aoi44RmZaSZSStvxwm+LRlKvC5+z7GaRbO0OfXAe
 CLxsIKaIjCFQHC942dLX/v9Qf7fkRiTRoMmCw8JT8of6/a5iAowbM48+rRmqsrk=
X-Google-Smtp-Source: AGHT+IHBKewSNecbWeNtLaqd7usGubmbEaZ1LnIR5IwOn/y2ZhjoAJVRSl/wceihno9DVOsb09rjKQ==
X-Received: by 2002:a17:902:da88:b0:223:2744:cb32 with SMTP id
 d9443c01a7336-223f1c81c41mr23994095ad.5.1741143866036; 
 Tue, 04 Mar 2025 19:04:26 -0800 (PST)
Received: from localhost (n11648126014.netvigator.com. [116.48.126.14])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-223504e1b2dsm103635915ad.170.2025.03.04.19.04.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 19:04:25 -0800 (PST)
From: Stefan Hajnoczi <stefanha@gmail.com>
X-Google-Original-From: Stefan Hajnoczi <stefanha@fedora>
Date: Wed, 5 Mar 2025 11:04:21 +0800
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com, pbonzini@redhat.com,
 manos.pitsidianakis@linaro.org, philmd@linaro.org,
 qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH v2 09/11] rust/block: Add read support for block drivers
Message-ID: <20250305030421.GC247800@fedora>
References: <20250218182019.111467-1-kwolf@redhat.com>
 <20250218182019.111467-10-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="h/NQToe/oFUJD5v/"
Content-Disposition: inline
In-Reply-To: <20250218182019.111467-10-kwolf@redhat.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=stefanha@gmail.com; helo=mail-pl1-x630.google.com
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


--h/NQToe/oFUJD5v/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2025 at 07:20:17PM +0100, Kevin Wolf wrote:
> This adds a map() function to the BlockDriver trait and makes use of it
> to implement reading from an image.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  rust/block/src/driver.rs | 95 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 95 insertions(+)
>=20
> diff --git a/rust/block/src/driver.rs b/rust/block/src/driver.rs
> index fe19f4b88f..022d50ffbc 100644
> --- a/rust/block/src/driver.rs
> +++ b/rust/block/src/driver.rs
> @@ -9,10 +9,45 @@
> =20
>  use crate::{IoBuffer, SizedIoBuffer};
>  use qemu_api::bindings;
> +use qemu_api::errno::Errno;
> +use qemu_api::futures::qemu_co_run_future;
> +use std::cmp::min;
>  use std::ffi::c_void;
>  use std::io::{self, Error, ErrorKind};
>  use std::mem::MaybeUninit;
>  use std::ptr;
> +use std::sync::Arc;
> +
> +/// A request to a block driver
> +pub enum Request {
> +    Read { offset: u64, len: u64 },
> +}
> +
> +/// The target for a number of guest blocks, e.g. a location in a child =
node or the information
> +/// that the described blocks are unmapped.
> +pub enum MappingTarget {
> +    /// The described blocks are unallocated. Reading from them yields z=
eros.
> +    Unmapped,
> +
> +    /// The described blocks are stored in a child node.
> +    Data {
> +        /// Child node in which the data is stored
> +        node: Arc<BdrvChild>,
> +
> +        /// Offset in the child node at which the data is stored
> +        offset: u64,
> +    },
> +}
> +
> +/// A mapping for a number of contiguous guest blocks
> +pub struct Mapping {
> +    /// Offset of the mapped blocks from the perspective of the guest
> +    pub offset: u64,
> +    /// Length of the mapping in bytes
> +    pub len: u64,
> +    /// Where the data for the described blocks is stored
> +    pub target: MappingTarget,
> +}
> =20
>  /// A trait for writing block drivers.
>  ///
> @@ -37,6 +72,11 @@ unsafe fn open(
> =20
>      /// Returns the size of the image in bytes
>      fn size(&self) -> u64;
> +
> +    /// Returns the mapping for the first part of `req`. If the returned=
 mapping is shorter than
> +    /// the request, the function can be called again with a shortened r=
equest to get the mapping
> +    /// for the remaining part.
> +    async fn map(&self, req: &Request) -> io::Result<Mapping>;

What are the constraints on the lifetime of returned mappings? I don't
mean a Rust lifetimes, but how long a returned mapping remains valid. I
guess at the moment returned mappings stay valid forever (i.e. the
BlockDriver cannot move data once it has been mapped)?

This becomes more interesting once write or discard requests are
supported or truncate() is implemented, but it would be worth spelling
out the lifetime of a mappings from the start and extending that model
later because it's an important assumption.

>  }
> =20
>  /// Represents the connection between a parent and its child node.
> @@ -166,6 +206,60 @@ pub async fn read_uninit<T: SizedIoBuffer>(
>      }
>  }
> =20
> +#[doc(hidden)]
> +pub unsafe extern "C" fn bdrv_co_preadv_part<D: BlockDriver>(
> +    bs: *mut bindings::BlockDriverState,
> +    offset: i64,
> +    bytes: i64,
> +    qiov: *mut bindings::QEMUIOVector,
> +    mut qiov_offset: usize,
> +    flags: bindings::BdrvRequestFlags,
> +) -> std::os::raw::c_int {
> +    let s =3D unsafe { &mut *((*bs).opaque as *mut D) };
> +
> +    let mut offset =3D offset as u64;
> +    let mut bytes =3D bytes as u64;
> +
> +    while bytes > 0 {
> +        let req =3D Request::Read { offset, len: bytes };
> +        let mapping =3D match qemu_co_run_future(s.map(&req)) {
> +            Ok(mapping) =3D> mapping,
> +            Err(e) =3D> return -i32::from(Errno::from(e).0),
> +        };
> +
> +        let mapping_offset =3D offset - mapping.offset;
> +        let cur_bytes =3D min(bytes, mapping.len - mapping_offset);
> +
> +        match mapping.target {
> +            MappingTarget::Unmapped =3D> unsafe {
> +                bindings::qemu_iovec_memset(qiov, qiov_offset, 0, cur_by=
tes.try_into().unwrap());
> +            },
> +            MappingTarget::Data {
> +                node,
> +                offset: target_offset,
> +            } =3D> unsafe {
> +                let ret =3D bindings::bdrv_co_preadv_part(
> +                    node.child,
> +                    (target_offset + mapping_offset) as i64,
> +                    cur_bytes as i64,
> +                    qiov,
> +                    qiov_offset,
> +                    flags,
> +                );
> +                if ret < 0 {
> +                    return ret;
> +                }
> +            },
> +        }
> +
> +        offset +=3D cur_bytes;
> +        qiov_offset +=3D cur_bytes as usize;
> +        bytes -=3D cur_bytes;
> +    }
> +
> +    0
> +}
> +
>  /// Declare a format block driver. This macro is meant to be used at the=
 top level.
>  ///
>  /// `typ` is a type implementing the [`BlockDriver`] trait to handle the=
 image format with the
> @@ -179,6 +273,7 @@ macro_rules! block_driver {
>                      instance_size: ::std::mem::size_of::<$typ>() as i32,
>                      bdrv_open: Some($crate::driver::bdrv_open::<$typ>),
>                      bdrv_close: Some($crate::driver::bdrv_close::<$typ>),
> +                    bdrv_co_preadv_part: Some($crate::driver::bdrv_co_pr=
eadv_part::<$typ>),
>                      bdrv_child_perm: Some(::qemu_api::bindings::bdrv_def=
ault_perms),
>                      is_format: true,
>                      ..::qemu_api::zeroable::Zeroable::ZERO
> --=20
> 2.48.1
>=20
>=20

--h/NQToe/oFUJD5v/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmfHvzUACgkQnKSrs4Gr
c8jgvgf/ZqkpfIjP02y6xJ97ktOZz3KOqL1v3G/DeiQ0B/FB1QHJwdO7HfZ6lztd
f4I7+3ArMTKilYatZy2+GSyolBa3n5yB4TpHVAIZpiV2x+ItYyqo/FJfiAwUrFak
/yVTik+LZmUStuBgUDHABbdDxBZQ1Ue5QQD6DKLK+vHTGNI2DHbjwH7i7EByHpe0
1EkV4wd5eybF7ltEqogEZAxT8u+chS5GDvZTtpkhr0nKuk9V6NQEsDg0xV5c3udM
RkTXhRA5S4NVRc7iQEl7BIAbwdTiMu73lVmlgsrRcYQY5QP4YYhT7UTEjyaP+oWA
nDsImKBgVJ6w8KZHIJVMNwgZNEk7ig==
=ITpS
-----END PGP SIGNATURE-----

--h/NQToe/oFUJD5v/--

