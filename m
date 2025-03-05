Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81280C19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 10:22:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tplsv-00027B-Di; Wed, 05 Mar 2025 05:21:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tplsh-00025i-HV; Wed, 05 Mar 2025 05:21:40 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tplse-0003AA-QQ; Wed, 05 Mar 2025 05:21:39 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2234daaf269so2971785ad.3; 
 Wed, 05 Mar 2025 02:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741170094; x=1741774894; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tcDQ2T0cv/bbB9tmgB3SnrYT9IdlUeolPBJwxjP1W2w=;
 b=KjWHxlnjvUCPPFL578HodqzUKExIE0nlKXFcLTRNdrtfMTN6VTTQeZU6z8GlueRTf1
 uU1vmJtDm0h7eOTaHo0z38Rsfs9VJibFK4RPosAiKGjfIP8ol1eaXRENoI6gE0P5CIkj
 leXcw76HX/jTEP2O73bUonzZ6ogTiKSK11O+djvGXAgM3AS7DF8dIejgfWzQveve3IsM
 cGdcyVtPGQU48P0is9/+f5Z2paDkd54K/e2oLdZFT1rcgh/uOh/f6TqJ+vxdxlFtWkaY
 3w1GpRuZUa9Efz7lOKP+tyLCLqxExdp07x2RDtxc4IcwBSTI2bYWRzWjmmpfCExZC0tj
 NM8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741170094; x=1741774894;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tcDQ2T0cv/bbB9tmgB3SnrYT9IdlUeolPBJwxjP1W2w=;
 b=h/QBbW77Wmn5HYilyygBcIX1e5foUqQjWX6jCeDh/KIqt7E5dEpvRlhozdPnXMWzZJ
 OWGPL/y/9VvxbdiR6wIY7kw89qkDJvw6+5kkO2HXjfIFemjIcpTzpHPALmt9/8SVwKO/
 r0ej37OM6UzLZN2Zf9aH4+H1SQbXYyJPD5yhhCerSiv+AEkYPOhwVN53G3gKgdfC3cDp
 +qbOxT2YqaJr0phg3XNJ50RxXSvS2jJ1cmgmrDXzXhXlL8m1HwFSC/SOV4MIpaLHJzGN
 R6+Iuu8CwIZcihkVRHutfO3pNeFDVLrb+icZGfr+UaiYzaDHLcKuZQtCKqmy+8rUvtnq
 7c0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQ5l6P/rBlwfUCnd9w7wBgqOeGlONlFkCpLMljYOTCb0RSQa/VT4Tecy3yoqoU+/ngmeIJ+8SzalYV@nongnu.org,
 AJvYcCX51JQ4zDPwMg/PMeHdFZrdkoaez1LxYpbdezRsFY79024+xsoBKKN0GHe20bnh6TxyRtFHNbIdNolJ@nongnu.org
X-Gm-Message-State: AOJu0YxGQEYCJ7R8XTEoapmbawPZOhmLmKae+sP02ll5lx1TqAPpWFRU
 aMii6E2Cl5gx7YJKTFL/IdDgVc6thNx0tJk+4aO9GR7uEoDnAKTJ
X-Gm-Gg: ASbGnctI5L9WLjr1zf8JsrBLJ18SY4LqWlbIM0AJ/rmC69euWftBSpKgyljlOD8vcZx
 LGi35MuyFebP4L2NIuARmTsF7xM29bbcfwFIOD9PRERVDMen7DSGqa2DUb6vMh6PZudOoqTI0f3
 q6GJFeIcMQfO8sISnKfpcFZYkwqYR5HQIQ12ENvMMcKPIu1+Ri7o4WXM2Z4TW3y20UqRajwIrve
 iTEOtr2OmyFQ5VeNahkaVCSqPcXzuqexZGoxrMXlUhnuxsimV4fcENEBqi8RUSNP+OVBs+o5lQV
 4ZGhcGcDejv3cfpGMVXEKwBWLZgIgg732h2ObK+HzE2b+Bqpv27OeK6XYSq90EI=
X-Google-Smtp-Source: AGHT+IF2RdBfzZCMhEv5RSJ+3gaqjyhW6VDCloqRSo+em99I+YJmsSZyA6nV5RQE9dMH05uS+6RCdg==
X-Received: by 2002:a05:6a20:918b:b0:1f3:40d3:67d4 with SMTP id
 adf61e73a8af0-1f349574fb6mr5728334637.30.1741170092222; 
 Wed, 05 Mar 2025 02:21:32 -0800 (PST)
Received: from localhost (n11648126014.netvigator.com. [116.48.126.14])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-aee7dee0b96sm11604263a12.75.2025.03.05.02.21.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Mar 2025 02:21:31 -0800 (PST)
From: Stefan Hajnoczi <stefanha@gmail.com>
X-Google-Original-From: Stefan Hajnoczi <stefanha@fedora>
Date: Wed, 5 Mar 2025 18:21:27 +0800
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com, pbonzini@redhat.com,
 manos.pitsidianakis@linaro.org, philmd@linaro.org,
 qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH v2 10/11] bochs-rs: Add bochs block driver
 reimplementation in Rust
Message-ID: <20250305102127.GE247800@fedora>
References: <20250218182019.111467-1-kwolf@redhat.com>
 <20250218182019.111467-11-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="xL/OQ0NIyIsfQo4q"
Content-Disposition: inline
In-Reply-To: <20250218182019.111467-11-kwolf@redhat.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=stefanha@gmail.com; helo=mail-pl1-x633.google.com
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


--xL/OQ0NIyIsfQo4q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2025 at 07:20:18PM +0100, Kevin Wolf wrote:
> This adds a separate block driver for the bochs image format called
> 'bochs-rs' so that for the moment both the C implementation and the Rust
> implementation can be present in the same build. The intention is to
> remove the C implementation eventually and rename this one into 'bochs'.
> This can only happen once Rust can be a hard build dependency for QEMU.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  rust/block/Cargo.toml    |   2 +-
>  rust/block/src/bochs.rs  | 297 +++++++++++++++++++++++++++++++++++++++
>  rust/block/src/driver.rs |   5 -
>  rust/block/src/lib.rs    |   1 +
>  4 files changed, 299 insertions(+), 6 deletions(-)
>  create mode 100644 rust/block/src/bochs.rs
>=20
> diff --git a/rust/block/Cargo.toml b/rust/block/Cargo.toml
> index fbc2f2d6ef..b91483aed1 100644
> --- a/rust/block/Cargo.toml
> +++ b/rust/block/Cargo.toml
> @@ -3,7 +3,7 @@ name =3D "block"
>  version =3D "0.1.0"
>  edition =3D "2021"
>  authors =3D ["Kevin Wolf <kwolf@redhat.com>"]
> -license =3D "GPL-2.0-or-later"
> +license =3D "GPL-2.0-or-later AND MIT"
>  readme =3D "README.md"
>  description =3D "Block backends for QEMU"
>  repository =3D "https://gitlab.com/qemu-project/qemu/"
> diff --git a/rust/block/src/bochs.rs b/rust/block/src/bochs.rs
> new file mode 100644
> index 0000000000..9dd84446e1
> --- /dev/null
> +++ b/rust/block/src/bochs.rs
> @@ -0,0 +1,297 @@
> +// SPDX-License-Identifier: MIT
> +/*
> + * Block driver for the various disk image formats used by Bochs
> + * Currently only for "growing" type in read-only mode
> + *
> + * Copyright (c) 2005 Alex Beregszaszi
> + * Copyright (c) 2024 Red Hat
> + *
> + * Authors:
> + *   Alex Beregszaszi
> + *   Kevin Wolf <kwolf@redhat.com>
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
> + * of this software and associated documentation files (the "Software"),=
 to deal
> + * in the Software without restriction, including without limitation the=
 rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or =
sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHA=
LL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR =
OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI=
NG FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
> + * THE SOFTWARE.
> + */
> +
> +use crate::driver::{block_driver, BdrvChild, BlockDriver, Mapping, Mappi=
ngTarget, Request};
> +use crate::SizedIoBuffer;
> +use qemu_api::bindings;
> +use qemu_api::errno::Errno;
> +use qemu_api::futures::qemu_run_future;
> +use std::cmp::min;
> +use std::io::{self, Error, ErrorKind};
> +use std::mem::MaybeUninit;
> +use std::ptr;
> +use std::sync::Arc;
> +
> +const BDRV_SECTOR_SIZE: u64 =3D 512;
> +
> +const HEADER_MAGIC: [u8; 32] =3D *b"Bochs Virtual HD Image\0\0\0\0\0\0\0=
\0\0\0";
> +const HEADER_VERSION: u32 =3D 0x00020000;
> +const HEADER_V1: u32 =3D 0x00010000;
> +const HEADER_SIZE: usize =3D 512;
> +
> +const HEADER_TYPE_REDOLOG: [u8; 16] =3D *b"Redolog\0\0\0\0\0\0\0\0\0";
> +const HEADER_SUBTYPE_GROWING: [u8; 16] =3D *b"Growing\0\0\0\0\0\0\0\0\0";
> +
> +// TODO Use u64.div_ceil() when MSRV is updated to at least 1.73.0
> +fn div_ceil(a: u64, b: u64) -> u64 {
> +    (a + b - 1) / b
> +}
> +
> +// TODO Use little endian enforcing type for integers

I just wanted to check if anyone knows whether the Rust standard library
has an endian enforcing type? It seems like an omission of a basic
standard library primitive. I've seen crates re-inventing this again and
again because the standard library only supports endianness conversion
but not a type that enforces safe conversion. Would be awesome if Rust
had this in the standard library and I may have missed recent
developments.

> +
> +#[repr(C, packed)]
> +struct BochsHeader {
> +    pub magic: [u8; 32],
> +    pub imgtype: [u8; 16],
> +    pub subtype: [u8; 16],
> +    pub version: u32,
> +    pub header_size: u32,
> +    pub catalog_entries: u32,
> +    pub bitmap_size: u32,
> +    pub extent_size: u32,
> +    pub extra: BochsHeaderExtra,
> +}
> +unsafe impl SizedIoBuffer for BochsHeader {}
> +
> +#[repr(C, packed)]
> +union BochsHeaderExtra {
> +    v2: BochsHeaderExtraRedolog,
> +    v1: BochsHeaderExtraRedologV1,
> +    padding: [u8; HEADER_SIZE - 84],

A compile-time check that BochsHeader =3D=3D HEADER_SIZE would be nice. It
feels a little unsafe to have HEADER_SIZE and this explicit padding size
calculation without a check. And to be honest it took me a few moments
to verify the it's correct while reading the patch :).

> +}
> +
> +#[repr(C, packed)]
> +#[derive(Clone, Copy)]
> +struct BochsHeaderExtraRedolog {
> +    pub timestamp: u32,
> +    pub disk_size: u64,
> +}
> +
> +#[repr(C, packed)]
> +#[derive(Clone, Copy)]
> +struct BochsHeaderExtraRedologV1 {
> +    pub disk_size: u64,
> +}
> +
> +pub struct BochsImage {
> +    file: Arc<BdrvChild>,
> +    size: u64,
> +    data_offset: u64,
> +    bitmap_blocks: u64,
> +    extent_size: u64,
> +    extent_blocks: u64,
> +    catalog_bitmap: Vec<u32>, // TODO Rename
> +}
> +
> +impl BochsImage {
> +    pub async fn new(file: BdrvChild) -> io::Result<Self> {
> +        let header =3D file
> +            .read_uninit(0, Box::new(MaybeUninit::<BochsHeader>::uninit(=
)))
> +            .await?;
> +
> +        if header.magic !=3D HEADER_MAGIC
> +            || header.imgtype !=3D HEADER_TYPE_REDOLOG
> +            || header.subtype !=3D HEADER_SUBTYPE_GROWING
> +        {
> +            return Err(Error::new(
> +                ErrorKind::InvalidInput,
> +                "Image not in Bochs format",
> +            ));
> +        }
> +
> +        let size =3D match u32::from_le(header.version) {
> +            HEADER_VERSION =3D> unsafe { header.extra.v2.disk_size.to_le=
() },
> +            HEADER_V1 =3D> unsafe { header.extra.v1.disk_size.to_le() },

I don't understand why the names are HEADER_VERSION vs HEADER_V1. Does
it make sense to rename them to HEADER_V1 and HEADER_V2?

> +            _ =3D> return Err(Error::new(ErrorKind::InvalidInput, "Versi=
on not supported")),
> +        };
> +
> +        let header_size: u64 =3D header.header_size.to_le().into();
> +        let extent_size: u64 =3D header.extent_size.to_le().into();
> +
> +        if extent_size < BDRV_SECTOR_SIZE {
> +            // bximage actually never creates extents smaller than 4k
> +            return Err(Error::new(
> +                ErrorKind::InvalidInput,
> +                "Extent size must be at least 512",
> +            ));
> +        } else if !extent_size.is_power_of_two() {
> +            return Err(Error::new(
> +                ErrorKind::InvalidInput,
> +                format!("Extent size {extent_size} is not a power of two=
"),
> +            ));
> +        } else if extent_size > 0x800000 {
> +            return Err(Error::new(
> +                ErrorKind::InvalidInput,
> +                format!("Extent size {extent_size} is too large"),
> +            ));
> +        }
> +
> +        // Limit to 1M entries to avoid unbounded allocation. This is wh=
at is
> +        // needed for the largest image that bximage can create (~8 TB).
> +        let catalog_entries: usize =3D header
> +            .catalog_entries
> +            .to_le()
> +            .try_into()
> +            .map_err(|e| Error::new(ErrorKind::InvalidInput, e))?;
> +        if catalog_entries > 0x100000 {
> +            return Err(Error::new(ErrorKind::Other, "Catalog size is too=
 large"));
> +        } else if (catalog_entries as u64) < div_ceil(size, extent_size)=
 {
> +            return Err(Error::new(
> +                ErrorKind::InvalidInput,
> +                "Catalog size is too small for this disk size",
> +            ));
> +        }
> +
> +        // FIXME This was g_try_malloc() in C
> +        let mut catalog_bitmap =3D vec![0u32; catalog_entries];
> +        file.read(header_size, catalog_bitmap.as_mut_slice())
> +            .await?;
> +
> +        for entry in &mut catalog_bitmap {
> +            *entry =3D entry.to_le();
> +        }
> +
> +        let data_offset =3D header_size + (catalog_entries as u64 * 4);
> +        let bitmap_blocks =3D (1 + (header.bitmap_size.to_le() - 1) / 51=
2).into();
> +        let extent_blocks =3D 1 + (extent_size - 1) / 512;
> +
> +        Ok(Self {
> +            file: Arc::new(file),
> +            size,
> +            data_offset,
> +            bitmap_blocks,
> +            extent_size,
> +            extent_blocks,
> +            catalog_bitmap,
> +        })
> +    }
> +}
> +
> +impl BlockDriver for BochsImage {
> +    type Options =3D bindings::BlockdevOptionsGenericFormat;
> +
> +    unsafe fn parse_options(
> +        v: &mut bindings::Visitor,
> +        opts: &mut *mut Self::Options,
> +        errp: *mut *mut bindings::Error,
> +    ) {
> +        unsafe {
> +            bindings::visit_type_BlockdevOptionsGenericFormat(v, ptr::nu=
ll(), opts as *mut _, errp);
> +        }
> +    }
> +
> +    unsafe fn free_options(opts: *mut Self::Options) {
> +        unsafe {
> +            bindings::qapi_free_BlockdevOptionsGenericFormat(opts);
> +        }
> +    }
> +
> +    unsafe fn open(
> +        bs: *mut bindings::BlockDriverState,
> +        opts: &Self::Options,
> +        errp: *mut *mut bindings::Error,
> +    ) -> std::os::raw::c_int {
> +        let file_child;
> +        unsafe {
> +            /* No write support yet */
> +            bindings::bdrv_graph_rdlock_main_loop();
> +            let ret =3D bindings::bdrv_apply_auto_read_only(bs, ptr::nul=
l(), errp);
> +            bindings::bdrv_graph_rdunlock_main_loop();
> +            if ret < 0 {
> +                return ret;
> +            }
> +
> +            file_child =3D match BdrvChild::new(bs, opts.file, errp) {
> +                Some(c) =3D> c,
> +                None =3D> return -libc::EINVAL,
> +            };
> +        }
> +
> +        qemu_run_future(async {
> +            match BochsImage::new(file_child).await {
> +                Ok(bdrv) =3D> unsafe {
> +                    (*bs).total_sectors =3D
> +                        div_ceil(bdrv.size(), BDRV_SECTOR_SIZE).try_into=
().unwrap();
> +                    let state =3D (*bs).opaque as *mut BochsImage;
> +                    state.write(bdrv);
> +                    0
> +                },
> +                Err(e) =3D> -i32::from(Errno::from(e).0),
> +            }
> +        })
> +    }
> +
> +    fn size(&self) -> u64 {
> +        self.size
> +    }
> +
> +    async fn map(&self, req: &Request) -> io::Result<Mapping> {
> +        let (offset, len) =3D match *req {
> +            Request::Read { offset, len } =3D> (offset, len),
> +        };
> +
> +        let extent_index: usize =3D (offset / self.extent_size).try_into=
().unwrap();
> +        let extent_offset =3D (offset % self.extent_size) / 512;
> +
> +        if self.catalog_bitmap[extent_index] =3D=3D 0xffffffff {
> +            return Ok(Mapping {
> +                offset: (extent_index as u64) * self.extent_size,
> +                len: self.extent_size,
> +                target: MappingTarget::Unmapped,
> +            });
> +        }
> +
> +        let bitmap_offset =3D self.data_offset
> +            + (512
> +                * (self.catalog_bitmap[extent_index] as u64)
> +                * (self.extent_blocks + self.bitmap_blocks));
> +
> +        // Read in bitmap for current extent
> +        // TODO This should be cached
> +        let mut bitmap_entry =3D 0x8;

Why is bitmap_entry initialized to 0x8?

> +        self.file
> +            .read(bitmap_offset + (extent_offset / 8), &mut bitmap_entry)
> +            .await?;
> +
> +        // We checked only a single sector
> +        let offset =3D offset & !511;
> +        let len =3D min(len, 512);
> +
> +        if (bitmap_entry >> (extent_offset % 8)) & 1 =3D=3D 0 {
> +            return Ok(Mapping {
> +                offset,
> +                len,
> +                target: MappingTarget::Unmapped,
> +            });
> +        }
> +
> +        Ok(Mapping {
> +            offset,
> +            len,
> +            target: MappingTarget::Data {
> +                node: self.file.clone(),
> +                offset: bitmap_offset + (512 * (self.bitmap_blocks + ext=
ent_offset)),
> +            },
> +        })
> +    }
> +}
> +
> +block_driver!("bochs-rs", BochsImage);
> diff --git a/rust/block/src/driver.rs b/rust/block/src/driver.rs
> index 022d50ffbc..baeaf47eda 100644
> --- a/rust/block/src/driver.rs
> +++ b/rust/block/src/driver.rs
> @@ -2,11 +2,6 @@
>  // Author(s): Kevin Wolf <kwolf@redhat.com>
>  // SPDX-License-Identifier: GPL-2.0-or-later
> =20
> -// All of this is unused until the first block driver is added
> -#![allow(dead_code)]
> -#![allow(unused_macros)]
> -#![allow(unused_imports)]
> -
>  use crate::{IoBuffer, SizedIoBuffer};
>  use qemu_api::bindings;
>  use qemu_api::errno::Errno;
> diff --git a/rust/block/src/lib.rs b/rust/block/src/lib.rs
> index 54ebd480ec..ff528609bc 100644
> --- a/rust/block/src/lib.rs
> +++ b/rust/block/src/lib.rs
> @@ -1,3 +1,4 @@
> +mod bochs;
>  mod driver;
>  mod iobuffer;
> =20
> --=20
> 2.48.1
>=20
>=20

--xL/OQ0NIyIsfQo4q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmfIJacACgkQnKSrs4Gr
c8i5hwf9HLGgFZQMjNk/ofmzwJS9ziqRaxKbC/ZSx8850iwyq23mQh6fFYDIxhhk
6kbhvy4Cl3TmUDYxIpcIwrbAdihw56VRkea5tofjOrBeXCRoPwt/iF0ONnM5av2C
cK9WfrfrKZ5g0rv5RmyEcZRJW4t1I24FaOCZPLF7ITEGOJY3XgEM9g4BtX7Nha2K
EntQKzFPfEIaS4zAR67tkFDA1W6yaJ6hzbuvhAa66CSe+8BBsPbnwZsIMYFdD28K
ZifNYvxNQLXaEFnK0o/5QadMx6QKobmpAJIrCv+KzX0uzlSa72YLarTJP3q/oT79
C/LMR589kfKOJzpP2Pikepf6+Lzjnw==
=nXJL
-----END PGP SIGNATURE-----

--xL/OQ0NIyIsfQo4q--

