Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4D04C282D0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 02:16:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpeIr-0004Oj-Sr; Tue, 04 Mar 2025 21:16:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tpeIO-0004M4-L0; Tue, 04 Mar 2025 21:15:42 -0500
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tpeIL-0005Dj-Kf; Tue, 04 Mar 2025 21:15:40 -0500
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2fe848040b1so12929627a91.3; 
 Tue, 04 Mar 2025 18:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741140935; x=1741745735; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=l1qeFEEjOAAigLBXucqEKGRjvpQU2PXzgTPoFxOqU9Q=;
 b=QK52i6/m3E/ohKVd/V0PiWywzRHDc50iMfhoGieQwcYXoI7dYjhQblQTBAuE8ySEAP
 yS4hX35Ym4goIrPTfQdQVg3uSvlvhAuysJY6ICCW/HeLLz6RYl2VQYuoM9ORMM8MjEOv
 DfIYB2koaXcfdSx0lkWG9aHK2jR/FMHwlRvJ0ncq3FS2qomxSNBrwzVORxUsjQ0BgrPK
 afNleL4q7EhAd9mjFy8wn3zu7SFHddzk2/FcT8oAzDYyvlYygaKgzy8l9JwcfXSaBefm
 Xopzu1k4Gpoj+piR4gnZxTy+9LfuejfgZq+4gVmbmLZbztMdSphl3hqC/55MZ8n64K4F
 dczg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741140935; x=1741745735;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l1qeFEEjOAAigLBXucqEKGRjvpQU2PXzgTPoFxOqU9Q=;
 b=BTq/kooCDdkcTklSbNzFx067lGxc6GyGmnpAlJ9C9mbAZ0h2adcQe4mII9g+M6lc7U
 L8SNRYwlBb3qkeHLjj2SB89rlyqBnMovb4oZOEPs9KvuY9lE1L6GLIEPs/gKS1rIUTP3
 0Tms0hRUj+b8r0/aVu5bGmBXO1MD6nR3OBnh9llfIWksx4HW0S8z5xIPT63kNYNraAWC
 DO74EjBctBnKvr3v0j2m9Y+seVCEEvrytzVgtMqijBV//87SVqkSU8SqvzJtpNvTmNSq
 RkFLyg16qXEK1vj4uqmei9wRygLT4QScirIEngCTnecZzsk8Il5fWgnYEMAyBj6de9ov
 nk2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUAg3t26NoD/caY2lIUkPq1gB3H6LqggC2Oy23sUSmK2fTflQDMBDKN99hEsP7gT9HKQmMXqjLOWoe@nongnu.org,
 AJvYcCXfA+WHx2tIxQkJsUeoMiaJwZOcnQx/xr7u9QgH6EzvGqmi9Is1WYEBa2OvMDVjoov1Wpgo5Mb/wPMk@nongnu.org
X-Gm-Message-State: AOJu0YxEwjDMN6e2yGIwDuM6MalqgdneMmz+KLqUr1BNQeZM7v69R8/h
 6srZW0Xf+4NTZ30AyPNKiUJ9+Wg6tC0TGc79xL/Fmf0+phBhG74MbK6xuAP1
X-Gm-Gg: ASbGncsBWHdxzfcy8yLjfZUWzE7tcjsAl6N8PKyFr15QZnRbqhEA7YlXFANSP73IX48
 c7VgxdE1uxiNHlMOc5sFi0x2tUTTr+uUIo3jQxXbdODOc0tbXTMV5cayu+Fop3ZzHFkXEpqISnZ
 d6d3RHlNBhOJuRFq1HCsQeMS7FeMHQOFzJqr7aCS+2fnRmGcxIybMrsJMH6UMmIIEWWFrSjElKn
 O4nN3txpsSWeMXtR0ZGFl5UacgpGnYDW5cR7vwpEudPgQNC0NmAGl2ybjgGYor+GDLKyF+3MeTC
 4zJNtoiceTMlln1OYrMpAEIS+DU7UE6v+q5j/JlAsknNg/cPdawEn1pV8Eo26cM=
X-Google-Smtp-Source: AGHT+IEDc4V5klj+zeXy4maEhDvbfCB6WdKK4y01cVkF/mYcK2VnI4YHbh0qThxsLuu+BoPqyUSGZQ==
X-Received: by 2002:a17:90b:6cb:b0:2fa:17dd:6afa with SMTP id
 98e67ed59e1d1-2ff49753458mr3003710a91.17.1741140935332; 
 Tue, 04 Mar 2025 18:15:35 -0800 (PST)
Received: from localhost (n11648126014.netvigator.com. [116.48.126.14])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff4e7a2c3bsm151013a91.39.2025.03.04.18.15.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 18:15:34 -0800 (PST)
From: Stefan Hajnoczi <stefanha@gmail.com>
X-Google-Original-From: Stefan Hajnoczi <stefanha@fedora>
Date: Wed, 5 Mar 2025 10:15:30 +0800
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com, pbonzini@redhat.com,
 manos.pitsidianakis@linaro.org, philmd@linaro.org,
 qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH v2 04/11] rust/qemu-api: Add wrappers to run futures in
 QEMU
Message-ID: <20250305021530.GA247800@fedora>
References: <20250218182019.111467-1-kwolf@redhat.com>
 <20250218182019.111467-5-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="h5u3hztMFs09Paiw"
Content-Disposition: inline
In-Reply-To: <20250218182019.111467-5-kwolf@redhat.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=stefanha@gmail.com; helo=mail-pj1-x102b.google.com
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


--h5u3hztMFs09Paiw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2025 at 07:20:12PM +0100, Kevin Wolf wrote:
> This adds helper functions that allow running Rust futures to completion
> using QEMU's event loops.

This commit is a cliff-hanger. I'm intrigued to find out how timer, fd,
etc event loop integration will work :).

>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/qemu/coroutine-rust.h | 24 +++++++++++
>  rust/wrapper.h                |  1 +
>  util/qemu-co-rust-async.c     | 55 +++++++++++++++++++++++++
>  rust/qemu-api/meson.build     |  1 +
>  rust/qemu-api/src/futures.rs  | 77 +++++++++++++++++++++++++++++++++++
>  rust/qemu-api/src/lib.rs      |  1 +
>  util/meson.build              |  3 ++
>  7 files changed, 162 insertions(+)
>  create mode 100644 include/qemu/coroutine-rust.h
>  create mode 100644 util/qemu-co-rust-async.c
>  create mode 100644 rust/qemu-api/src/futures.rs
>=20
> diff --git a/include/qemu/coroutine-rust.h b/include/qemu/coroutine-rust.h
> new file mode 100644
> index 0000000000..0c5cf42a6b
> --- /dev/null
> +++ b/include/qemu/coroutine-rust.h
> @@ -0,0 +1,24 @@
> +/* SPDX-License-Identifier: LGPL-2.1-or-later */
> +/*
> + * Helpers to run Rust futures using QEMU coroutines
> + *
> + * Copyright Red Hat
> + *
> + * Author:
> + *   Kevin Wolf <kwolf@redhat.com>
> + *
> + * This work is licensed under the terms of the GNU LGPL, version 2.1 or=
 later.
> + * See the COPYING.LIB file in the top-level directory.
> + */
> +
> +#ifndef QEMU_COROUTINE_RUST_H
> +#define QEMU_COROUTINE_RUST_H
> +
> +typedef struct RustBoxedFuture RustBoxedFuture;
> +typedef void coroutine_fn RunFuture(RustBoxedFuture *future, void *opaqu=
e);
> +
> +void no_coroutine_fn rust_run_future(RustBoxedFuture *future,
> +                                     RunFuture *entry,
> +                                     void *opaque);

This adds a blocking (aio_poll()-style) API. The more blocking APIs we
add, the more points are created where QEMU hangs when the async
operation doesn't complete in a reasonable amount of time. It would be
best to avoid introducing new blocking APIs, but sometimes it is
unavoidable.

rust_run_future() is very generic and I think the downsides should be
pointed out to discourage people from using it when not absolutely
necessary. Can you document when it's appropriate to use this API?

> +
> +#endif
> diff --git a/rust/wrapper.h b/rust/wrapper.h
> index 303d7bba7f..3dc385e256 100644
> --- a/rust/wrapper.h
> +++ b/rust/wrapper.h
> @@ -58,3 +58,4 @@ typedef enum memory_order {
>  #include "block/block_int.h"
>  #include "block/qdict.h"
>  #include "qapi/qapi-visit-block-core.h"
> +#include "qemu/coroutine-rust.h"
> diff --git a/util/qemu-co-rust-async.c b/util/qemu-co-rust-async.c
> new file mode 100644
> index 0000000000..d893dfb7bd
> --- /dev/null
> +++ b/util/qemu-co-rust-async.c
> @@ -0,0 +1,55 @@
> +/* SPDX-License-Identifier: LGPL-2.1-or-later */
> +/*
> + * Helpers to run Rust futures using QEMU coroutines
> + *
> + * Copyright Red Hat
> + *
> + * Author:
> + *   Kevin Wolf <kwolf@redhat.com>
> + *
> + * This work is licensed under the terms of the GNU LGPL, version 2.1 or=
 later.
> + * See the COPYING.LIB file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +
> +#include "block/aio-wait.h"
> +#include "qemu/coroutine.h"
> +#include "qemu/coroutine-rust.h"
> +#include "qemu/main-loop.h"
> +
> +typedef struct FutureCo {
> +    RustBoxedFuture *future;
> +    RunFuture *entry;
> +    void *opaque;
> +    bool done;
> +} FutureCo;
> +
> +static void coroutine_fn rust_co_run_future_entry(void *opaque)
> +{
> +    FutureCo *data =3D opaque;
> +
> +    data->entry(data->future, data->opaque);
> +    data->done =3D true;
> +    aio_wait_kick();
> +}
> +
> +void no_coroutine_fn rust_run_future(RustBoxedFuture *future,
> +                                     RunFuture *entry,
> +                                     void *opaque)
> +{
> +    AioContext *ctx =3D qemu_get_current_aio_context();
> +    Coroutine *co;
> +    FutureCo data =3D {
> +        .future =3D future,
> +        .entry =3D entry,
> +        .opaque =3D opaque,
> +        .done =3D false,
> +    };
> +
> +    GLOBAL_STATE_CODE();
> +
> +    co =3D qemu_coroutine_create(rust_co_run_future_entry, &data);
> +    aio_co_enter(ctx, co);
> +    AIO_WAIT_WHILE(ctx, !data.done);
> +}
> diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
> index e0a3052c79..44fd34e193 100644
> --- a/rust/qemu-api/meson.build
> +++ b/rust/qemu-api/meson.build
> @@ -22,6 +22,7 @@ sources_core =3D [
>    'src/chardev.rs',
>    'src/c_str.rs',
>    'src/errno.rs',
> +  'src/futures.rs',
>    'src/module.rs',
>    'src/offset_of.rs',
>    'src/prelude.rs',
> diff --git a/rust/qemu-api/src/futures.rs b/rust/qemu-api/src/futures.rs
> new file mode 100644
> index 0000000000..cd307a1d62
> --- /dev/null
> +++ b/rust/qemu-api/src/futures.rs
> @@ -0,0 +1,77 @@
> +use crate::bindings;
> +use std::ffi::c_void;
> +use std::future::Future;
> +use std::mem::MaybeUninit;
> +use std::sync::Arc;
> +use std::task::{Context, Poll, Wake, Waker};
> +
> +struct RunFutureWaker {
> +    co: *mut bindings::Coroutine,
> +}
> +unsafe impl Send for RunFutureWaker {}
> +unsafe impl Sync for RunFutureWaker {}
> +
> +impl Wake for RunFutureWaker {
> +    fn wake(self: Arc<Self>) {
> +        unsafe {
> +            bindings::aio_co_wake(self.co);
> +        }
> +    }
> +}
> +
> +/// Use QEMU's event loops to run a Rust [`Future`] to completion and re=
turn its result.
> +///
> +/// This function must be called in coroutine context. If the future isn=
't ready yet, it yields.
> +pub fn qemu_co_run_future<F: Future>(future: F) -> F::Output {
> +    let waker =3D Waker::from(Arc::new(RunFutureWaker {
> +        co: unsafe { bindings::qemu_coroutine_self() },
> +    }));
> +    let mut cx =3D Context::from_waker(&waker);
> +
> +    let mut pinned_future =3D std::pin::pin!(future);
> +    loop {
> +        match pinned_future.as_mut().poll(&mut cx) {
> +            Poll::Ready(res) =3D> return res,
> +            Poll::Pending =3D> unsafe {
> +                bindings::qemu_coroutine_yield();
> +            },
> +        }
> +    }
> +}
> +
> +/// Wrapper around [`qemu_co_run_future`] that can be called from C.
> +///
> +/// # Safety
> +///
> +/// `future` must be a valid pointer to an owned `F` (it will be freed i=
n this function).  `output`
> +/// must be a valid pointer representing a mutable reference to an `F::O=
utput` where the result can
> +/// be stored.
> +unsafe extern "C" fn rust_co_run_future<F: Future>(
> +    future: *mut bindings::RustBoxedFuture,
> +    output: *mut c_void,
> +) {
> +    let future =3D unsafe { Box::from_raw(future.cast::<F>()) };
> +    let output =3D output.cast::<F::Output>();
> +    let ret =3D qemu_co_run_future(*future);
> +    unsafe {
> +        output.write(ret);
> +    }
> +}
> +
> +/// Use QEMU's event loops to run a Rust [`Future`] to completion and re=
turn its result.
> +///
> +/// This function must be called outside of coroutine context to avoid d=
eadlocks. It blocks and

rust_run_future() has GLOBAL_STATE_CODE() so qemu_run_future() needs to
run not just outside coroutine context, but also under the BQL. Should
this be mentioned?

> +/// runs a nested even loop until the future is ready and returns a resu=
lt.
> +pub fn qemu_run_future<F: Future>(future: F) -> F::Output {
> +    let future_ptr =3D Box::into_raw(Box::new(future));
> +    let mut output =3D MaybeUninit::<F::Output>::uninit();
> +    unsafe {
> +        bindings::rust_run_future(
> +            future_ptr.cast::<bindings::RustBoxedFuture>(),
> +            #[allow(clippy::as_underscore)]
> +            Some(rust_co_run_future::<F> as _),

This line is hard to follow. I think it's casting to the C equivalent
type:

 void coroutine_fn (*)(RustBoxedFuture *future, void *opaque)

I wonder if there's a clearer way of writing this. Maybe being explicit
rather than implicit here would be helpful.

If not, it's not a big deal, but I spent some time trying to figure out
what this does and others might too.

> +            output.as_mut_ptr().cast::<c_void>(),
> +        );
> +        output.assume_init()
> +    }
> +}
> diff --git a/rust/qemu-api/src/lib.rs b/rust/qemu-api/src/lib.rs
> index 825443abde..84928905f1 100644
> --- a/rust/qemu-api/src/lib.rs
> +++ b/rust/qemu-api/src/lib.rs
> @@ -20,6 +20,7 @@
>  pub mod cell;
>  pub mod chardev;
>  pub mod errno;
> +pub mod futures;
>  #[cfg(feature =3D "system")]
>  pub mod irq;
>  #[cfg(feature =3D "system")]
> diff --git a/util/meson.build b/util/meson.build
> index 780b5977a8..14a2ae17fd 100644
> --- a/util/meson.build
> +++ b/util/meson.build
> @@ -101,6 +101,9 @@ if have_block
>    util_ss.add(files('qemu-coroutine-sleep.c'))
>    util_ss.add(files('qemu-co-shared-resource.c'))
>    util_ss.add(files('qemu-co-timeout.c'))
> +  if have_rust
> +    util_ss.add(files('qemu-co-rust-async.c'))
> +  endif
>    util_ss.add(files('readline.c'))
>    util_ss.add(files('throttle.c'))
>    util_ss.add(files('timed-average.c'))
> --=20
> 2.48.1
>=20
>=20

--h5u3hztMFs09Paiw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmfHs8IACgkQnKSrs4Gr
c8hGiAf+NOviB8GIuCttSMS6JgpN2D8+11emqUAroVsKv5AjCGjjQidIuvEOgjOY
XYpYlyIvLfSi3PBzuXujaJweZjnpNtzGlxoxERhRTw5fMpsSeIHPjV/MdUGeQ4x7
E5qU9NcVHJVeP50PskmGzvguXRJmnDbiaDaVJ/LAgsrWp/ZyOTlZCeCBYHQg/JXI
IhIbo8TtHsEKEo2nq89SmAQXgh9uZ9UgKalHJB8/n8/UQWK8aMHvKTusLReZeMsJ
52vMrKYhRNfNxPv3V/21tBSz/7gyM4dC3viYnVCrTKoKsutX5ZNFKZ92/MEv7g+y
pzKG90KabceSsPrIJgEEVqOlMYsHxQ==
=r8ZW
-----END PGP SIGNATURE-----

--h5u3hztMFs09Paiw--

