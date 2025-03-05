Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AEBBC19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 10:24:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tplvA-0002ps-9t; Wed, 05 Mar 2025 05:24:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tplv8-0002oi-1q; Wed, 05 Mar 2025 05:24:10 -0500
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tplv3-0003XZ-UA; Wed, 05 Mar 2025 05:24:09 -0500
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2fea795bafeso1133159a91.1; 
 Wed, 05 Mar 2025 02:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741170243; x=1741775043; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=PzDkHAPr8aRHB3Bk75iif9zJZ4pQbe5/L7Xwcn+2wLE=;
 b=XmKp9/n9Vef7aDlMQ86DJDciSyCXtC3a/R2eWPPCqq0Dl7OxwRT1VX0vOGvBogVkH2
 zIK796QRdQ0OLvQSMMSfYww4rYvMMtsUxqNZzg1Qzn5oKBZeyfRryE5rN2K3ejglQiht
 F9VOJWt9H/8BDx10YK5cEDYbC0HTFA2XzUv3aYjsYLdpBX8yFr2cm+OvxlH15QJW8YsV
 is+1kHXy4GyYbHcfDZd634feonkLcc2xlIw/Sicy5foQzHx4FQicZR8Yeuo8u7pii75t
 crWKKMFMkoTASFWcy6Em+xXI+kk19iIvdWOGZKlcPEG3Y2zVpNHMNAZD5nW+XIT5S8y2
 3VkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741170243; x=1741775043;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PzDkHAPr8aRHB3Bk75iif9zJZ4pQbe5/L7Xwcn+2wLE=;
 b=v8uXjMws2lECGQ9fbY+7hmVtXUrwmTPhh2u3zzG0FbiFOcppujCQGO04wtT0SJJR4S
 8nyqog6C1/ST7twP3UdYYjVVppzUzDPyWwIOEOsMnSG+/SIzDC6HRzX9cd3nnEZxh8+C
 QW1Jxs43DP69Mm9mkR//4lVrGgAlx5CTkQb7VEqOyc/jDXHUeIK4nP1PdRNg/QvirWKV
 jin4OMHdwx3BnB+75iSiop1JBq6SGUlKuSAB/3NqfW6LNXR1dL28UMGSx0GQB8arl0hI
 zZF/Tl5x0DOh1WNGEQ1i0gleS5AY6jG8iGHNDtplwlZn4osLkI4EAOma71eyoBrvwBxM
 wswg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPrm2+vOPPRwtypqEmJFRuTLJdOx0xJY+ozZ8P5S0LV3Ch1xUBRgcQ+Sgss8/FSLDILGDzNb4WrJCP@nongnu.org,
 AJvYcCXq+Yc/bFv5ohVmE/5o/rbXBo0Nxx6qyjqqdNdCeQUqYpeZ0iPAFdbRpfbdkPVqaKb9QAU9S1j7Sl0t@nongnu.org
X-Gm-Message-State: AOJu0Yy/oPnk0Iwf0OZECMnGJAuYQUakQhD1xf3LFYHnXgii/d39GhIP
 qQJtSKw/lufuxYqMfESRzFoQsJC4N5jQ+Dv7EBTB1Yl+lz0lzss8
X-Gm-Gg: ASbGnctW2u7VxwrI4MlJSG3yM1DiOXzYSpLNqf/k77EK8Cw+wWJQVGx/S49n2c8jeVd
 3yNG8ZxvlXfIxbiHwmSemIT5FyqPWX0qKPuuBM2/rDprdQ4zXVtg/RSVV2+7HXXlKpGWIaBzp2N
 LFoOOyV7PF43u70Vjgk5wqzUj3UGWBipbd1d05drEakf13a48kD92fJCi/KXZVabfYLT5yzmIQD
 yItFMSs13Pm6HT2c8GRvk9TbJQo1vzWK3IFfVAgsaQ4AqOnGfBE/W0FOP5ctpK0MhZdze0si2s+
 SVrXzVhblZozcGkIQyH8VQY8+hlnYdwINZLaBZHyo/Y1OfAMKAlx4fRWrByJk1E=
X-Google-Smtp-Source: AGHT+IG3U0Ys5YxJuIghaZvux8wui9QlzH9rRiFZ3MVbqcCTIiayCbhaCcXXL2f8UEUoh29f/zrpsQ==
X-Received: by 2002:a17:90b:2e44:b0:2fa:6793:e860 with SMTP id
 98e67ed59e1d1-2ff33994c2bmr11691441a91.0.1741170243260; 
 Wed, 05 Mar 2025 02:24:03 -0800 (PST)
Received: from localhost (n11648126014.netvigator.com. [116.48.126.14])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff4e7737a5sm979141a91.13.2025.03.05.02.24.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Mar 2025 02:24:02 -0800 (PST)
From: Stefan Hajnoczi <stefanha@gmail.com>
X-Google-Original-From: Stefan Hajnoczi <stefanha@fedora>
Date: Wed, 5 Mar 2025 18:23:59 +0800
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com, pbonzini@redhat.com,
 manos.pitsidianakis@linaro.org, philmd@linaro.org,
 qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH v2 00/11] rust/block: Add minimal block driver bindings
Message-ID: <20250305102359.GF247800@fedora>
References: <20250218182019.111467-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="72EG4UKRxHPSDCGu"
Content-Disposition: inline
In-Reply-To: <20250218182019.111467-1-kwolf@redhat.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=stefanha@gmail.com; helo=mail-pj1-x1030.google.com
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


--72EG4UKRxHPSDCGu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2025 at 07:20:08PM +0100, Kevin Wolf wrote:
> This series adds minimal bindings for writing block drivers in Rust and
> converts the bochs block driver as an example. Some parts (such as the
> open functions) are still essentially C written in Rust syntax, while
> other parts already try to provide somewhat idiomatic abstractions.
>=20
> The main purpose of this series is just to add a starting point for
> incremental improvements to the bindings; it's clearly not very polished
> yet and ignores some important points like enforcing the graph lock.
>=20
> Therefore, the main focus in the immediate future after this series
> should be cleaning up the bochs driver and the bindings it uses rather
> than adding more drivers.
>=20
> Based-on: <20250213143216.3910163-1-pbonzini@redhat.com>

Hi Kevin,
This is very cool: both the ability to write block drivers in Rust and
the new API design focussing on mappings instead of I/O request
processing.

I wonder whether BlockDriver should be called ImageFormatDriver instead
to differentiate it from protocol drivers (which are block drivers) as
they cannot be implemented with the mappings-based interface.

Stefan

>=20
> v2:
> - Rebased on top of current git master with qemu_api::errno patches
>   applied
> - Changed 'node' in MappingTarget from a dummy () to Arc<BdrvChild>
> - Changed BdrvChild::read_uninit() to use Box<MaybeUninit<T>>
> - Use libc crate instead of letting bindgen output EINVAL/EIO
> - Fixed errno translation logic, in parts by using qemu_api::errno
> - Changed two instances of incorrect *foo =3D ... into foo.write(...)
> - Added rust/block/ to MAINTAINERS
> - Some style and readability improvements
>=20
> Kevin Wolf (11):
>   rust: Build separate qemu_api_tools and qemu_api_system
>   meson: Add rust_block_ss and link tools with it
>   rust: Add some block layer bindings
>   rust/qemu-api: Add wrappers to run futures in QEMU
>   rust/block: Add empty crate
>   rust/block: Add I/O buffer traits
>   block: Add bdrv_open_blockdev_ref_file()
>   rust/block: Add driver module
>   rust/block: Add read support for block drivers
>   bochs-rs: Add bochs block driver reimplementation in Rust
>   rust/block: Add format probing
>=20
>  include/block/block-global-state.h |   4 +
>  include/qemu/coroutine-rust.h      |  24 +++
>  rust/wrapper-system.h              |  46 +++++
>  rust/wrapper.h                     |  16 +-
>  block.c                            |  31 ++-
>  util/qemu-co-rust-async.c          |  55 +++++
>  MAINTAINERS                        |   1 +
>  meson.build                        |  47 ++++-
>  rust/Cargo.lock                    |   8 +
>  rust/Cargo.toml                    |   1 +
>  rust/block/Cargo.toml              |  16 ++
>  rust/block/README.md               |   3 +
>  rust/block/meson.build             |  20 ++
>  rust/block/src/bochs.rs            | 317 +++++++++++++++++++++++++++++
>  rust/block/src/driver.rs           | 309 ++++++++++++++++++++++++++++
>  rust/block/src/iobuffer.rs         |  94 +++++++++
>  rust/block/src/lib.rs              |   5 +
>  rust/hw/char/pl011/meson.build     |   3 +-
>  rust/hw/timer/hpet/meson.build     |   3 +-
>  rust/meson.build                   |  12 +-
>  rust/qemu-api/Cargo.toml           |   1 +
>  rust/qemu-api/build.rs             |  10 +-
>  rust/qemu-api/meson.build          |  80 +++++---
>  rust/qemu-api/src/bindings.rs      |  52 +++--
>  rust/qemu-api/src/futures.rs       |  77 +++++++
>  rust/qemu-api/src/lib.rs           |   6 +
>  rust/qemu-api/src/prelude.rs       |   3 +
>  rust/qemu-api/src/zeroable.rs      |  34 ++--
>  storage-daemon/meson.build         |   2 +-
>  util/meson.build                   |   3 +
>  30 files changed, 1188 insertions(+), 95 deletions(-)
>  create mode 100644 include/qemu/coroutine-rust.h
>  create mode 100644 rust/wrapper-system.h
>  create mode 100644 util/qemu-co-rust-async.c
>  create mode 100644 rust/block/Cargo.toml
>  create mode 100644 rust/block/README.md
>  create mode 100644 rust/block/meson.build
>  create mode 100644 rust/block/src/bochs.rs
>  create mode 100644 rust/block/src/driver.rs
>  create mode 100644 rust/block/src/iobuffer.rs
>  create mode 100644 rust/block/src/lib.rs
>  create mode 100644 rust/qemu-api/src/futures.rs
>=20
> --=20
> 2.48.1
>=20
>=20

--72EG4UKRxHPSDCGu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmfIJj8ACgkQnKSrs4Gr
c8jGbwf/Tz2JGZIPphxG+NXOqCUpOnzo6WFIx3WsN4KmCU7+70sC0o41oC0SJf7M
dtB9VwuvS/NnrrtY0kkLRjn+WOQ0yCtt4/zyAKuV7PAxiLdrVhBw2kjiiy10+ZWv
1m4pC4wvsZ+7//WrTWyEm1YTMMBr8aNqkihhBT5R8dZawVLhsWyvMR5BgA5+W5GC
IpGZCCViHOWp8OsIQ14wELJfK4U902BLJmDXmrGshU5bLcE5xTF3b9SVzM/YjSdW
m06w/6YEpQykef1SyTnlSs/4PAy/U8BtFO6cFQ38sxKMtreeX6T4SMUHC3TatYoe
+iGlFY8ypBbT5JC21PLvEjXjREyzOw==
=D4w9
-----END PGP SIGNATURE-----

--72EG4UKRxHPSDCGu--

