Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2456ECA0FE7
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 15:24:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqvWL-0000zE-Lr; Tue, 26 Aug 2025 11:23:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1uqvW6-0000wm-GN
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 11:23:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1uqvVs-0006Dw-Rf
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 11:23:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756221781;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uTl3wNhy5tnwPGP0Xk42Rh6ghQ5OYXj/BNnVIwoW/98=;
 b=MOv+ogECUqRSI5vy/fhY5E40ni6U4NsvnAxOGnSYm79A+Y5HTXdJ5XipQ4GU/evTaftxh8
 Pk67p+YQA5x/XZvtBWUfBZS8zoCf0pbqu/xh7YgchJ0+kHvd+nAk/kzk17AT35N3Krzwn2
 IqkAgEl3gS9MUu1nbzPr4YTvYE0PpQo=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-mANBWaCDNoCTZy7NKQhumQ-1; Tue, 26 Aug 2025 11:22:58 -0400
X-MC-Unique: mANBWaCDNoCTZy7NKQhumQ-1
X-Mimecast-MFC-AGG-ID: mANBWaCDNoCTZy7NKQhumQ_1756221778
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-325ce108e16so2876203a91.1
 for <qemu-devel@nongnu.org>; Tue, 26 Aug 2025 08:22:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756221777; x=1756826577;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uTl3wNhy5tnwPGP0Xk42Rh6ghQ5OYXj/BNnVIwoW/98=;
 b=eJu0a8DVdTYlEAgU4N+tjytLPzsB7zAwaKqkVgYWIamJG8/hyWIoqSarF6TCQk7XGe
 g0hhpyTq6O+FeFfQtigNz1+A04rQN4lGef2q5v4zxZkvhfksXNa+G5f6z11VO5FnmYtI
 uo1HLw3Xofwi8CbB15lJYTA7/fxZT7u9E/mmo8nDR/OQ4F9vaMs6CYBguPzdJezGZj+Y
 y2Lw0q3GSAs3rEGswdF3ZWcTlVqrLLlreT98TXU4QH9GDox+8ZLIACDLGOyxyWrWZsUH
 SgpHa4MbROIxpojNgiR7R16JZWCwJ42PElljP/64u5vW4oakztIVSRX7hCe4nupBbX0T
 56Bw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUQ5c8+DKbpklvyNlcFoTZEBy8z4YRUk4iXXLq9kz2DDsR2RvDDfgO8z4+affKhlCQKLW4NCLnOMh7@nongnu.org
X-Gm-Message-State: AOJu0YxK9zUMb/5seoOv+r1Z1ew8+pNdeK36EtWEupAie/5c81yL1yHY
 OBot+kHnUdm+raoN7wN50I16wIXlz7L3R0PlL3G20Gr7Wj0Ig/a+52ntqqPMdXqMEooVoFgNdUG
 E39udn9Soi9ZqYyahxyZ9PI5Wz0zZZ6LihWGHKT3NhYLrr/1qPlRsYMohUC2pEFDSxNm9P49pEm
 Ov9QSs+CgnDS7zc8stB0yB2qUzsC0+t5A=
X-Gm-Gg: ASbGncsYM6Pq1JLHcSdCkm19eCq6gk3bnyGzuYl2MvxeLxUwu69W9+83ae5n26fLwUP
 YVr82txYVE///dEXIKdu9wVXmgZlmRWtBNjg5Lv6FRGqnjf5Jnam7ob3oq85LcX2oWMbO4cxuEC
 o3V8S4psoS+XgQFnXLCHD7YcnrY1bzFsxgOlKH/dLjwqhhGcrcsOyCzQ==
X-Received: by 2002:a17:90b:1b4c:b0:312:639:a064 with SMTP id
 98e67ed59e1d1-32517d1f4d8mr20133787a91.28.1756221777404; 
 Tue, 26 Aug 2025 08:22:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGis0wJPKNtOXdNJkIFKg3woV+XkrFlKh23iaT3c8snB4Rm4yw9ixWJYip2hiOuK55ZAqWdiE2PJjupoq8QGXY=
X-Received: by 2002:a17:90b:1b4c:b0:312:639:a064 with SMTP id
 98e67ed59e1d1-32517d1f4d8mr20133746a91.28.1756221776814; Tue, 26 Aug 2025
 08:22:56 -0700 (PDT)
MIME-Version: 1.0
References: <20250826140449.4190022-1-marcandre.lureau@redhat.com>
 <e58ea933-f941-44d8-8477-c8298663cc24@redhat.com>
 <CAAjaMXYwEwpaybjEiA6tBCartTrzoAqsKNzHSfrs4f2wJx-wjA@mail.gmail.com>
In-Reply-To: <CAAjaMXYwEwpaybjEiA6tBCartTrzoAqsKNzHSfrs4f2wJx-wjA@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 26 Aug 2025 19:22:45 +0400
X-Gm-Features: Ac12FXzz1ar4aqy6rTZNITAJOhq5dUlDMgZcoXzMxzyRQAJd0i7lvtJIfA_uYkg
Message-ID: <CAMxuvaxLPuvGeO897jdWYHRW+3s33ki0-vhxtB7=JMsvAmyumA@mail.gmail.com>
Subject: Re: [RFC 00/18] rust: split qemu-api
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-rust@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000277b35063d463f13"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, HTML_MESSAGE=0.001, HTML_OBFUSCATE_10_20=0.093,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--000000000000277b35063d463f13
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Tue, Aug 26, 2025 at 6:56=E2=80=AFPM Manos Pitsidianakis <
manos.pitsidianakis@linaro.org> wrote:

> On Tue, Aug 26, 2025 at 5:44=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.co=
m> wrote:
> >
> > On 8/26/25 16:04, marcandre.lureau@redhat.com wrote:
> > > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > >
> > > Hi,
> > >
> > > qemu-api is providing bindings for various internal libraries.
> Instead, the
> > > bindings requirements should match the various libraries and use the
> minimal set
> > > of dependencies.
> > >
> > > An initial Rust-only "common" crate is introduced, then "util" (for
> libqemuutil,
> > > without bql), "migration" (so it doesn't depend on bql), "bql", "qom"
> (arguably,
> > > bql shouldn't be required?), and "chardev", "system", "hwcore".
> Finally the
> > > qemu-api crates are renamed and repurposed.
> > >
> > > This involves a lot of code churn, so hopefully it can be reviewed an=
d
> merged
> > > early and iterated upon :)
> >
> > The one comment that I would like to handle before merging, is that I'd
> > prefer to keep the preludes and, in fact, even add more exports to them
> > since they can now be chosen per-crate.  Ideally, many of the crates
> > you've crated would be accessed through many "use xyz::prelude::*"
> > statements.
>
> I kind of agree with this sentiment. What this series basically does
> is unwrapping most modules to standalone crates. Semantically, they
> make sense to be their own crates just like they made sense being
> their own modules before). But I'm not sure what developer benefit
>

Indeed, that's the point. The benefit is that you can compile and link only
what you need, just like how qemu code and libraries are organized. Modules
become quickly tangled between each other if you don't do it.


> this brings, it's like splitting Rust's std crate to separate crates
> (ergonomically speaking). Big crates like tokio split implementation
> to crates and then re-export them under tokio::* to ease compilation
> parallelism which we should definitely try to do as well. However in
> our case our Rust wrappers are very small. Let's do this if they ever
> end up growing unwieldy.
>

It will become difficult to manage. It's already hard to know which type
comes from which library/header. Better to do the split early imho. It was
nice to have a single crate in the early days, but we should prepare to
scale up now.


> > Also, if I understood correctly the split util/errno.rs can move to
> > common/.  While it has a dependency on libc, it doesn't need bindgen.
> >
> > There's a bunch of code duplication for the various bindings.rs and
> > build.rs files, which is not ideal but shouldn't grow much more than
> > this.  I wonder if, later, common code across build.rs could be written
> > just once by adding a new crate (e.g. "qemu_meson") to the workspace,
> > that can be used as a build-dependency.
> >
> > Paolo
> >
> > > Marc-Andr=C3=A9 Lureau (18):
> > >    rust: remove unused global qemu "allocator"
> > >    rust: add workspace authors
> > >    rust: split Rust-only "common" crate
> > >    rust: split "util" crate
> > >    rust: move vmstate_clock!() to qdev module
> > >    rust: move VMState handling to QOM module
> > >    rust: move Cell vmstate impl
> > >    rust: split "migration" crate
> > >    rust: split "bql" crate
> > >    rust: split "qom" crate
> > >    rust: split "chardev" crate
> > >    rust: split "system" crate
> > >    rust: split "hwcore" crate
> > >    rust: rename qemu_api_macros -> qemu_macros
> > >    rust/hpet: drop now unneeded qemu_api dep
> > >    rust/pl011: drop dependency on qemu_api
> > >    rust: repurpose qemu_api -> tests
> > >    docs: update rust.rst
> > >
> > >   MAINTAINERS                                   |  12 +-
> > >   docs/devel/rust.rst                           |  51 +--
> > >   meson.build                                   |   4 -
> > >   rust/bql/wrapper.h                            |  27 ++
> > >   rust/chardev/wrapper.h                        |  28 ++
> > >   rust/hw/char/pl011/wrapper.h                  |  51 +++
> > >   rust/hw/core/wrapper.h                        |  32 ++
> > >   rust/{qemu-api =3D> migration}/wrapper.h        |  20 --
> > >   rust/qom/wrapper.h                            |  27 ++
> > >   rust/system/wrapper.h                         |  29 ++
> > >   rust/util/wrapper.h                           |  32 ++
> > >   rust/Cargo.lock                               | 127 ++++++-
> > >   rust/Cargo.toml                               |  16 +-
> > >   rust/bits/Cargo.toml                          |   2 +-
> > >   rust/bits/meson.build                         |   2 +-
> > >   rust/bits/src/lib.rs                          |   4 +-
> > >   rust/{qemu-api =3D> bql}/Cargo.toml             |  13 +-
> > >   rust/{qemu-api =3D> bql}/build.rs               |   2 +-
> > >   rust/bql/meson.build                          |  52 +++
> > >   rust/bql/src/bindings.rs                      |  25 ++
> > >   rust/{qemu-api =3D> bql}/src/cell.rs            | 333
> +++---------------
> > >   rust/bql/src/lib.rs                           |  29 ++
> > >   rust/chardev/Cargo.toml                       |  24 ++
> > >   rust/chardev/build.rs                         |  43 +++
> > >   rust/chardev/meson.build                      |  54 +++
> > >   rust/chardev/src/bindings.rs                  |  36 ++
> > >   rust/{qemu-api =3D> chardev}/src/chardev.rs     |  35 +-
> > >   rust/chardev/src/lib.rs                       |   4 +
> > >   rust/common/Cargo.toml                        |  16 +
> > >   rust/common/meson.build                       |  32 ++
> > >   rust/{qemu-api =3D> common}/src/assertions.rs   |  16 +-
> > >   rust/{qemu-api =3D> common}/src/bitops.rs       |   1 -
> > >   rust/{qemu-api =3D> common}/src/callbacks.rs    |  12 +-
> > >   rust/common/src/lib.rs                        |  17 +
> > >   rust/common/src/opaque.rs                     | 240 +++++++++++++
> > >   rust/{qemu-api =3D> common}/src/uninit.rs       |   2 +-
> > >   rust/common/src/zeroable.rs                   |  18 +
> > >   rust/hw/char/pl011/Cargo.toml                 |  11 +-
> > >   rust/hw/char/pl011/build.rs                   |  43 +++
> > >   rust/hw/char/pl011/meson.build                |  39 +-
> > >   rust/hw/char/pl011/src/bindings.rs            |  27 ++
> > >   rust/hw/char/pl011/src/device.rs              |  49 +--
> > >   rust/hw/char/pl011/src/lib.rs                 |   1 +
> > >   rust/hw/char/pl011/src/registers.rs           |   4 +-
> > >   rust/hw/core/Cargo.toml                       |  26 ++
> > >   rust/hw/core/build.rs                         |  43 +++
> > >   rust/{qemu-api =3D> hw/core}/meson.build        |  86 ++---
> > >   rust/hw/core/src/bindings.rs                  |  41 +++
> > >   rust/{qemu-api =3D> hw/core}/src/irq.rs         |  18 +-
> > >   rust/hw/core/src/lib.rs                       |  12 +
> > >   rust/{qemu-api =3D> hw/core}/src/qdev.rs        |  81 +++--
> > >   rust/{qemu-api =3D> hw/core}/src/sysbus.rs      |  28 +-
> > >   rust/{qemu-api =3D> hw/core}/tests/tests.rs     |  29 +-
> > >   rust/hw/timer/hpet/Cargo.toml                 |  10 +-
> > >   rust/hw/timer/hpet/meson.build                |  12 +-
> > >   rust/hw/timer/hpet/src/device.rs              |  56 ++-
> > >   rust/hw/timer/hpet/src/fw_cfg.rs              |   6 +-
> > >   rust/meson.build                              |  12 +-
> > >   rust/migration/Cargo.toml                     |  21 ++
> > >   rust/migration/build.rs                       |  43 +++
> > >   rust/migration/meson.build                    |  57 +++
> > >   rust/migration/src/bindings.rs                |  48 +++
> > >   rust/migration/src/lib.rs                     |   4 +
> > >   rust/{qemu-api =3D> migration}/src/vmstate.rs   | 166 ++++-----
> > >   rust/qemu-api/.gitignore                      |   2 -
> > >   rust/qemu-api/README.md                       |  19 -
> > >   rust/qemu-api/src/lib.rs                      | 170 ---------
> > >   rust/qemu-api/src/prelude.rs                  |  31 --
> > >   rust/qemu-api/src/zeroable.rs                 |  37 --
> > >   .../Cargo.toml                                |   2 +-
> > >   .../meson.build                               |  10 +-
> > >   .../src/bits.rs                               |   0
> > >   .../src/lib.rs                                |  20 +-
> > >   .../src/tests.rs                              |   8 +-
> > >   rust/qom/Cargo.toml                           |  23 ++
> > >   rust/qom/build.rs                             |  43 +++
> > >   rust/qom/meson.build                          |  61 ++++
> > >   rust/qom/src/bindings.rs                      |  25 ++
> > >   rust/qom/src/lib.rs                           |   4 +
> > >   rust/{qemu-api =3D> qom}/src/qom.rs             |  27 +-
> > >   rust/qom/tests/tests.rs                       |  47 +++
> > >   rust/system/Cargo.toml                        |  22 ++
> > >   rust/system/build.rs                          |  43 +++
> > >   rust/system/meson.build                       |  57 +++
> > >   rust/{qemu-api =3D> system}/src/bindings.rs     |  33 +-
> > >   rust/system/src/lib.rs                        |   4 +
> > >   rust/{qemu-api =3D> system}/src/memory.rs       |  20 +-
> > >   rust/tests/Cargo.toml                         |  30 ++
> > >   rust/tests/meson.build                        |  14 +
> > >   .../tests/vmstate_tests.rs                    |  18 +-
> > >   rust/util/Cargo.toml                          |  23 ++
> > >   rust/util/build.rs                            |  43 +++
> > >   rust/util/meson.build                         |  61 ++++
> > >   rust/util/src/bindings.rs                     |  25 ++
> > >   rust/{qemu-api =3D> util}/src/errno.rs          |  11 +-
> > >   rust/{qemu-api =3D> util}/src/error.rs          |   6 +-
> > >   rust/util/src/lib.rs                          |  10 +
> > >   rust/{qemu-api =3D> util}/src/log.rs            |  12 +-
> > >   rust/{qemu-api =3D> util}/src/module.rs         |   2 +-
> > >   rust/{qemu-api =3D> util}/src/timer.rs          |  12 +-
> > >   100 files changed, 2372 insertions(+), 1044 deletions(-)
> > >   create mode 100644 rust/bql/wrapper.h
> > >   create mode 100644 rust/chardev/wrapper.h
> > >   create mode 100644 rust/hw/char/pl011/wrapper.h
> > >   create mode 100644 rust/hw/core/wrapper.h
> > >   rename rust/{qemu-api =3D> migration}/wrapper.h (77%)
> > >   create mode 100644 rust/qom/wrapper.h
> > >   create mode 100644 rust/system/wrapper.h
> > >   create mode 100644 rust/util/wrapper.h
> > >   rename rust/{qemu-api =3D> bql}/Cargo.toml (52%)
> > >   rename rust/{qemu-api =3D> bql}/build.rs (96%)
> > >   create mode 100644 rust/bql/meson.build
> > >   create mode 100644 rust/bql/src/bindings.rs
> > >   rename rust/{qemu-api =3D> bql}/src/cell.rs (70%)
> > >   create mode 100644 rust/bql/src/lib.rs
> > >   create mode 100644 rust/chardev/Cargo.toml
> > >   create mode 100644 rust/chardev/build.rs
> > >   create mode 100644 rust/chardev/meson.build
> > >   create mode 100644 rust/chardev/src/bindings.rs
> > >   rename rust/{qemu-api =3D> chardev}/src/chardev.rs (91%)
> > >   create mode 100644 rust/chardev/src/lib.rs
> > >   create mode 100644 rust/common/Cargo.toml
> > >   create mode 100644 rust/common/meson.build
> > >   rename rust/{qemu-api =3D> common}/src/assertions.rs (92%)
> > >   rename rust/{qemu-api =3D> common}/src/bitops.rs (98%)
> > >   rename rust/{qemu-api =3D> common}/src/callbacks.rs (97%)
> > >   create mode 100644 rust/common/src/lib.rs
> > >   create mode 100644 rust/common/src/opaque.rs
> > >   rename rust/{qemu-api =3D> common}/src/uninit.rs (98%)
> > >   create mode 100644 rust/common/src/zeroable.rs
> > >   create mode 100644 rust/hw/char/pl011/build.rs
> > >   create mode 100644 rust/hw/char/pl011/src/bindings.rs
> > >   create mode 100644 rust/hw/core/Cargo.toml
> > >   create mode 100644 rust/hw/core/build.rs
> > >   rename rust/{qemu-api =3D> hw/core}/meson.build (52%)
> > >   create mode 100644 rust/hw/core/src/bindings.rs
> > >   rename rust/{qemu-api =3D> hw/core}/src/irq.rs (92%)
> > >   create mode 100644 rust/hw/core/src/lib.rs
> > >   rename rust/{qemu-api =3D> hw/core}/src/qdev.rs (86%)
> > >   rename rust/{qemu-api =3D> hw/core}/src/sysbus.rs (87%)
> > >   rename rust/{qemu-api =3D> hw/core}/tests/tests.rs (88%)
> > >   create mode 100644 rust/migration/Cargo.toml
> > >   create mode 100644 rust/migration/build.rs
> > >   create mode 100644 rust/migration/meson.build
> > >   create mode 100644 rust/migration/src/bindings.rs
> > >   create mode 100644 rust/migration/src/lib.rs
> > >   rename rust/{qemu-api =3D> migration}/src/vmstate.rs (80%)
> > >   delete mode 100644 rust/qemu-api/.gitignore
> > >   delete mode 100644 rust/qemu-api/README.md
> > >   delete mode 100644 rust/qemu-api/src/lib.rs
> > >   delete mode 100644 rust/qemu-api/src/prelude.rs
> > >   delete mode 100644 rust/qemu-api/src/zeroable.rs
> > >   rename rust/{qemu-api-macros =3D> qemu-macros}/Cargo.toml (94%)
> > >   rename rust/{qemu-api-macros =3D> qemu-macros}/meson.build (63%)
> > >   rename rust/{qemu-api-macros =3D> qemu-macros}/src/bits.rs (100%)
> > >   rename rust/{qemu-api-macros =3D> qemu-macros}/src/lib.rs (91%)
> > >   rename rust/{qemu-api-macros =3D> qemu-macros}/src/tests.rs (93%)
> > >   create mode 100644 rust/qom/Cargo.toml
> > >   create mode 100644 rust/qom/build.rs
> > >   create mode 100644 rust/qom/meson.build
> > >   create mode 100644 rust/qom/src/bindings.rs
> > >   create mode 100644 rust/qom/src/lib.rs
> > >   rename rust/{qemu-api =3D> qom}/src/qom.rs (98%)
> > >   create mode 100644 rust/qom/tests/tests.rs
> > >   create mode 100644 rust/system/Cargo.toml
> > >   create mode 100644 rust/system/build.rs
> > >   create mode 100644 rust/system/meson.build
> > >   rename rust/{qemu-api =3D> system}/src/bindings.rs (56%)
> > >   create mode 100644 rust/system/src/lib.rs
> > >   rename rust/{qemu-api =3D> system}/src/memory.rs (95%)
> > >   create mode 100644 rust/tests/Cargo.toml
> > >   create mode 100644 rust/tests/meson.build
> > >   rename rust/{qemu-api =3D> tests}/tests/vmstate_tests.rs (96%)
> > >   create mode 100644 rust/util/Cargo.toml
> > >   create mode 100644 rust/util/build.rs
> > >   create mode 100644 rust/util/meson.build
> > >   create mode 100644 rust/util/src/bindings.rs
> > >   rename rust/{qemu-api =3D> util}/src/errno.rs (98%)
> > >   rename rust/{qemu-api =3D> util}/src/error.rs (98%)
> > >   create mode 100644 rust/util/src/lib.rs
> > >   rename rust/{qemu-api =3D> util}/src/log.rs (93%)
> > >   rename rust/{qemu-api =3D> util}/src/module.rs (97%)
> > >   rename rust/{qemu-api =3D> util}/src/timer.rs (93%)
> > >
> >
>
>

--000000000000277b35063d463f13
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi</div><br><div class=3D"gmail_quote gma=
il_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Aug 26, 2=
025 at 6:56=E2=80=AFPM Manos Pitsidianakis &lt;<a href=3D"mailto:manos.pits=
idianakis@linaro.org">manos.pitsidianakis@linaro.org</a>&gt; wrote:<br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">On Tue, Aug 26, 2025 at=
 5:44=E2=80=AFPM Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com" t=
arget=3D"_blank">pbonzini@redhat.com</a>&gt; wrote:<br>
&gt;<br>
&gt; On 8/26/25 16:04, <a href=3D"mailto:marcandre.lureau@redhat.com" targe=
t=3D"_blank">marcandre.lureau@redhat.com</a> wrote:<br>
&gt; &gt; From: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lure=
au@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
&gt; &gt;<br>
&gt; &gt; Hi,<br>
&gt; &gt;<br>
&gt; &gt; qemu-api is providing bindings for various internal libraries. In=
stead, the<br>
&gt; &gt; bindings requirements should match the various libraries and use =
the minimal set<br>
&gt; &gt; of dependencies.<br>
&gt; &gt;<br>
&gt; &gt; An initial Rust-only &quot;common&quot; crate is introduced, then=
 &quot;util&quot; (for libqemuutil,<br>
&gt; &gt; without bql), &quot;migration&quot; (so it doesn&#39;t depend on =
bql), &quot;bql&quot;, &quot;qom&quot; (arguably,<br>
&gt; &gt; bql shouldn&#39;t be required?), and &quot;chardev&quot;, &quot;s=
ystem&quot;, &quot;hwcore&quot;. Finally the<br>
&gt; &gt; qemu-api crates are renamed and repurposed.<br>
&gt; &gt;<br>
&gt; &gt; This involves a lot of code churn, so hopefully it can be reviewe=
d and merged<br>
&gt; &gt; early and iterated upon :)<br>
&gt;<br>
&gt; The one comment that I would like to handle before merging, is that I&=
#39;d<br>
&gt; prefer to keep the preludes and, in fact, even add more exports to the=
m<br>
&gt; since they can now be chosen per-crate.=C2=A0 Ideally, many of the cra=
tes<br>
&gt; you&#39;ve crated would be accessed through many &quot;use xyz::prelud=
e::*&quot;<br>
&gt; statements.<br>
<br>
I kind of agree with this sentiment. What this series basically does<br>
is unwrapping most modules to standalone crates. Semantically, they<br>
make sense to be their own crates just like they made sense being<br>
their own modules before). But I&#39;m not sure what developer benefit<br><=
/blockquote><div><br></div><div>Indeed, that&#39;s the point. The benefit i=
s that you can compile and link only what you need, just like how qemu code=
 and libraries are organized. Modules become quickly tangled between each o=
ther if you don&#39;t do it.</div><div>=C2=A0</div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">
this brings, it&#39;s like splitting Rust&#39;s std crate to separate crate=
s<br>
(ergonomically speaking). Big crates like tokio split implementation<br>
to crates and then re-export them under tokio::* to ease compilation<br>
parallelism which we should definitely try to do as well. However in<br>
our case our Rust wrappers are very small. Let&#39;s do this if they ever<b=
r>
end up growing unwieldy.<br></blockquote><div><br></div><div>It will become=
 difficult to manage. It&#39;s already hard to know which type comes from w=
hich library/header. Better to do the split early imho. It was nice to have=
 a single crate in the early days, but we should prepare to scale up now.=
=C2=A0</div><div><br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">
<br>
&gt; Also, if I understood correctly the split util/<a href=3D"http://errno=
.rs" rel=3D"noreferrer" target=3D"_blank">errno.rs</a> can move to<br>
&gt; common/.=C2=A0 While it has a dependency on libc, it doesn&#39;t need =
bindgen.<br>
&gt;<br>
&gt; There&#39;s a bunch of code duplication for the various <a href=3D"htt=
p://bindings.rs" rel=3D"noreferrer" target=3D"_blank">bindings.rs</a> and<b=
r>
&gt; <a href=3D"http://build.rs" rel=3D"noreferrer" target=3D"_blank">build=
.rs</a> files, which is not ideal but shouldn&#39;t grow much more than<br>
&gt; this.=C2=A0 I wonder if, later, common code across <a href=3D"http://b=
uild.rs" rel=3D"noreferrer" target=3D"_blank">build.rs</a> could be written=
<br>
&gt; just once by adding a new crate (e.g. &quot;qemu_meson&quot;) to the w=
orkspace,<br>
&gt; that can be used as a build-dependency.<br>
&gt;<br>
&gt; Paolo<br>
&gt;<br>
&gt; &gt; Marc-Andr=C3=A9 Lureau (18):<br>
&gt; &gt;=C2=A0 =C2=A0 rust: remove unused global qemu &quot;allocator&quot=
;<br>
&gt; &gt;=C2=A0 =C2=A0 rust: add workspace authors<br>
&gt; &gt;=C2=A0 =C2=A0 rust: split Rust-only &quot;common&quot; crate<br>
&gt; &gt;=C2=A0 =C2=A0 rust: split &quot;util&quot; crate<br>
&gt; &gt;=C2=A0 =C2=A0 rust: move vmstate_clock!() to qdev module<br>
&gt; &gt;=C2=A0 =C2=A0 rust: move VMState handling to QOM module<br>
&gt; &gt;=C2=A0 =C2=A0 rust: move Cell vmstate impl<br>
&gt; &gt;=C2=A0 =C2=A0 rust: split &quot;migration&quot; crate<br>
&gt; &gt;=C2=A0 =C2=A0 rust: split &quot;bql&quot; crate<br>
&gt; &gt;=C2=A0 =C2=A0 rust: split &quot;qom&quot; crate<br>
&gt; &gt;=C2=A0 =C2=A0 rust: split &quot;chardev&quot; crate<br>
&gt; &gt;=C2=A0 =C2=A0 rust: split &quot;system&quot; crate<br>
&gt; &gt;=C2=A0 =C2=A0 rust: split &quot;hwcore&quot; crate<br>
&gt; &gt;=C2=A0 =C2=A0 rust: rename qemu_api_macros -&gt; qemu_macros<br>
&gt; &gt;=C2=A0 =C2=A0 rust/hpet: drop now unneeded qemu_api dep<br>
&gt; &gt;=C2=A0 =C2=A0 rust/pl011: drop dependency on qemu_api<br>
&gt; &gt;=C2=A0 =C2=A0 rust: repurpose qemu_api -&gt; tests<br>
&gt; &gt;=C2=A0 =C2=A0 docs: update rust.rst<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 12 +-<br>
&gt; &gt;=C2=A0 =C2=A0docs/devel/rust.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 51 +=
--<br>
&gt; &gt;=C2=A0 =C2=A0meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 =C2=A04 -<br>
&gt; &gt;=C2=A0 =C2=A0rust/bql/wrapper.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 27 +=
+<br>
&gt; &gt;=C2=A0 =C2=A0rust/chardev/wrapper.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 28 ++<br>
&gt; &gt;=C2=A0 =C2=A0rust/hw/char/pl011/wrapper.h=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 51 +++<br>
&gt; &gt;=C2=A0 =C2=A0rust/hw/core/wrapper.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 32 ++<br>
&gt; &gt;=C2=A0 =C2=A0rust/{qemu-api =3D&gt; migration}/wrapper.h=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 20 --<br>
&gt; &gt;=C2=A0 =C2=A0rust/qom/wrapper.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 27 +=
+<br>
&gt; &gt;=C2=A0 =C2=A0rust/system/wrapper.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 29 ++<br=
>
&gt; &gt;=C2=A0 =C2=A0rust/util/wrapper.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 32 +=
+<br>
&gt; &gt;=C2=A0 =C2=A0rust/Cargo.lock=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =
127 ++++++-<br>
&gt; &gt;=C2=A0 =C2=A0rust/Cargo.toml=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 16 +-<br>
&gt; &gt;=C2=A0 =C2=A0rust/bits/Cargo.toml=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02=
 +-<br>
&gt; &gt;=C2=A0 =C2=A0rust/bits/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 =
+-<br>
&gt; &gt;=C2=A0 =C2=A0rust/bits/src/<a href=3D"http://lib.rs" rel=3D"norefe=
rrer" target=3D"_blank">lib.rs</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A04 +-<br>
&gt; &gt;=C2=A0 =C2=A0rust/{qemu-api =3D&gt; bql}/Cargo.toml=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 13 +-<br>
&gt; &gt;=C2=A0 =C2=A0rust/{qemu-api =3D&gt; bql}/<a href=3D"http://build.r=
s" rel=3D"noreferrer" target=3D"_blank">build.rs</a>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +-<br>
&gt; &gt;=C2=A0 =C2=A0rust/bql/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 52 +++<=
br>
&gt; &gt;=C2=A0 =C2=A0rust/bql/src/<a href=3D"http://bindings.rs" rel=3D"no=
referrer" target=3D"_blank">bindings.rs</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 25 ++<br>
&gt; &gt;=C2=A0 =C2=A0rust/{qemu-api =3D&gt; bql}/src/<a href=3D"http://cel=
l.rs" rel=3D"noreferrer" target=3D"_blank">cell.rs</a>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 | 333 +++---------------<br>
&gt; &gt;=C2=A0 =C2=A0rust/bql/src/<a href=3D"http://lib.rs" rel=3D"norefer=
rer" target=3D"_blank">lib.rs</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 29 ++<br>
&gt; &gt;=C2=A0 =C2=A0rust/chardev/Cargo.toml=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 24 ++<br>
&gt; &gt;=C2=A0 =C2=A0rust/chardev/<a href=3D"http://build.rs" rel=3D"noref=
errer" target=3D"_blank">build.rs</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 43 +++<br>
&gt; &gt;=C2=A0 =C2=A0rust/chardev/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 54 +++<br>
&gt; &gt;=C2=A0 =C2=A0rust/chardev/src/<a href=3D"http://bindings.rs" rel=
=3D"noreferrer" target=3D"_blank">bindings.rs</a>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 36 ++<br>
&gt; &gt;=C2=A0 =C2=A0rust/{qemu-api =3D&gt; chardev}/src/<a href=3D"http:/=
/chardev.rs" rel=3D"noreferrer" target=3D"_blank">chardev.rs</a>=C2=A0 =C2=
=A0 =C2=A0|=C2=A0 35 +-<br>
&gt; &gt;=C2=A0 =C2=A0rust/chardev/src/<a href=3D"http://lib.rs" rel=3D"nor=
eferrer" target=3D"_blank">lib.rs</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A04 +<br>
&gt; &gt;=C2=A0 =C2=A0rust/common/Cargo.toml=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 16 +<br>
&gt; &gt;=C2=A0 =C2=A0rust/common/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 32 ++<br>
&gt; &gt;=C2=A0 =C2=A0rust/{qemu-api =3D&gt; common}/src/<a href=3D"http://=
assertions.rs" rel=3D"noreferrer" target=3D"_blank">assertions.rs</a>=C2=A0=
 =C2=A0|=C2=A0 16 +-<br>
&gt; &gt;=C2=A0 =C2=A0rust/{qemu-api =3D&gt; common}/src/<a href=3D"http://=
bitops.rs" rel=3D"noreferrer" target=3D"_blank">bitops.rs</a>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 =C2=A01 -<br>
&gt; &gt;=C2=A0 =C2=A0rust/{qemu-api =3D&gt; common}/src/<a href=3D"http://=
callbacks.rs" rel=3D"noreferrer" target=3D"_blank">callbacks.rs</a>=C2=A0 =
=C2=A0 |=C2=A0 12 +-<br>
&gt; &gt;=C2=A0 =C2=A0rust/common/src/<a href=3D"http://lib.rs" rel=3D"nore=
ferrer" target=3D"_blank">lib.rs</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 17 +<br>
&gt; &gt;=C2=A0 =C2=A0rust/common/src/<a href=3D"http://opaque.rs" rel=3D"n=
oreferrer" target=3D"_blank">opaque.rs</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 240 +++++++++++++<br>
&gt; &gt;=C2=A0 =C2=A0rust/{qemu-api =3D&gt; common}/src/<a href=3D"http://=
uninit.rs" rel=3D"noreferrer" target=3D"_blank">uninit.rs</a>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 =C2=A02 +-<br>
&gt; &gt;=C2=A0 =C2=A0rust/common/src/<a href=3D"http://zeroable.rs" rel=3D=
"noreferrer" target=3D"_blank">zeroable.rs</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 18 +<br>
&gt; &gt;=C2=A0 =C2=A0rust/hw/char/pl011/Cargo.toml=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 11 +-<br>
&gt; &gt;=C2=A0 =C2=A0rust/hw/char/pl011/<a href=3D"http://build.rs" rel=3D=
"noreferrer" target=3D"_blank">build.rs</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 43 +++<br>
&gt; &gt;=C2=A0 =C2=A0rust/hw/char/pl011/meson.build=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 39 +-<br>
&gt; &gt;=C2=A0 =C2=A0rust/hw/char/pl011/src/<a href=3D"http://bindings.rs"=
 rel=3D"noreferrer" target=3D"_blank">bindings.rs</a>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 27 ++<br>
&gt; &gt;=C2=A0 =C2=A0rust/hw/char/pl011/src/<a href=3D"http://device.rs" r=
el=3D"noreferrer" target=3D"_blank">device.rs</a>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 49 +--<br>
&gt; &gt;=C2=A0 =C2=A0rust/hw/char/pl011/src/<a href=3D"http://lib.rs" rel=
=3D"noreferrer" target=3D"_blank">lib.rs</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
&gt; &gt;=C2=A0 =C2=A0rust/hw/char/pl011/src/<a href=3D"http://registers.rs=
" rel=3D"noreferrer" target=3D"_blank">registers.rs</a>=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A04 +-<br>
&gt; &gt;=C2=A0 =C2=A0rust/hw/core/Cargo.toml=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 26 ++<br>
&gt; &gt;=C2=A0 =C2=A0rust/hw/core/<a href=3D"http://build.rs" rel=3D"noref=
errer" target=3D"_blank">build.rs</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 43 +++<br>
&gt; &gt;=C2=A0 =C2=A0rust/{qemu-api =3D&gt; hw/core}/meson.build=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 86 ++---<br>
&gt; &gt;=C2=A0 =C2=A0rust/hw/core/src/<a href=3D"http://bindings.rs" rel=
=3D"noreferrer" target=3D"_blank">bindings.rs</a>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 41 +++<br>
&gt; &gt;=C2=A0 =C2=A0rust/{qemu-api =3D&gt; hw/core}/src/<a href=3D"http:/=
/irq.rs" rel=3D"noreferrer" target=3D"_blank">irq.rs</a>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 18 +-<br>
&gt; &gt;=C2=A0 =C2=A0rust/hw/core/src/<a href=3D"http://lib.rs" rel=3D"nor=
eferrer" target=3D"_blank">lib.rs</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 12 +<br>
&gt; &gt;=C2=A0 =C2=A0rust/{qemu-api =3D&gt; hw/core}/src/<a href=3D"http:/=
/qdev.rs" rel=3D"noreferrer" target=3D"_blank">qdev.rs</a>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 81 +++--<br>
&gt; &gt;=C2=A0 =C2=A0rust/{qemu-api =3D&gt; hw/core}/src/<a href=3D"http:/=
/sysbus.rs" rel=3D"noreferrer" target=3D"_blank">sysbus.rs</a>=C2=A0 =C2=A0=
 =C2=A0 |=C2=A0 28 +-<br>
&gt; &gt;=C2=A0 =C2=A0rust/{qemu-api =3D&gt; hw/core}/tests/<a href=3D"http=
://tests.rs" rel=3D"noreferrer" target=3D"_blank">tests.rs</a>=C2=A0 =C2=A0=
 =C2=A0|=C2=A0 29 +-<br>
&gt; &gt;=C2=A0 =C2=A0rust/hw/timer/hpet/Cargo.toml=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 10 +-<br>
&gt; &gt;=C2=A0 =C2=A0rust/hw/timer/hpet/meson.build=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 12 +-<br>
&gt; &gt;=C2=A0 =C2=A0rust/hw/timer/hpet/src/<a href=3D"http://device.rs" r=
el=3D"noreferrer" target=3D"_blank">device.rs</a>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 56 ++-<br>
&gt; &gt;=C2=A0 =C2=A0rust/hw/timer/hpet/src/<a href=3D"http://fw_cfg.rs" r=
el=3D"noreferrer" target=3D"_blank">fw_cfg.rs</a>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A06 +-<br>
&gt; &gt;=C2=A0 =C2=A0rust/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 12 +-<br>
&gt; &gt;=C2=A0 =C2=A0rust/migration/Cargo.toml=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 21 ++<br>
&gt; &gt;=C2=A0 =C2=A0rust/migration/<a href=3D"http://build.rs" rel=3D"nor=
eferrer" target=3D"_blank">build.rs</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 43 +++<br>
&gt; &gt;=C2=A0 =C2=A0rust/migration/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 57 +++<br>
&gt; &gt;=C2=A0 =C2=A0rust/migration/src/<a href=3D"http://bindings.rs" rel=
=3D"noreferrer" target=3D"_blank">bindings.rs</a>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 48 +++<br>
&gt; &gt;=C2=A0 =C2=A0rust/migration/src/<a href=3D"http://lib.rs" rel=3D"n=
oreferrer" target=3D"_blank">lib.rs</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A04 +<br>
&gt; &gt;=C2=A0 =C2=A0rust/{qemu-api =3D&gt; migration}/src/<a href=3D"http=
://vmstate.rs" rel=3D"noreferrer" target=3D"_blank">vmstate.rs</a>=C2=A0 =
=C2=A0| 166 ++++-----<br>
&gt; &gt;=C2=A0 =C2=A0rust/qemu-api/.gitignore=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 -<br>
&gt; &gt;=C2=A0 =C2=A0rust/qemu-api/README.md=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 19 -<br>
&gt; &gt;=C2=A0 =C2=A0rust/qemu-api/src/<a href=3D"http://lib.rs" rel=3D"no=
referrer" target=3D"_blank">lib.rs</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 170 ---------<br>
&gt; &gt;=C2=A0 =C2=A0rust/qemu-api/src/<a href=3D"http://prelude.rs" rel=
=3D"noreferrer" target=3D"_blank">prelude.rs</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 31 --<br>
&gt; &gt;=C2=A0 =C2=A0rust/qemu-api/src/<a href=3D"http://zeroable.rs" rel=
=3D"noreferrer" target=3D"_blank">zeroable.rs</a>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 37 --<br>
&gt; &gt;=C2=A0 =C2=A0.../Cargo.toml=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 =C2=A02 +-<br>
&gt; &gt;=C2=A0 =C2=A0.../meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 10 +-<br>
&gt; &gt;=C2=A0 =C2=A0.../src/<a href=3D"http://bits.rs" rel=3D"noreferrer"=
 target=3D"_blank">bits.rs</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =
=C2=A00<br>
&gt; &gt;=C2=A0 =C2=A0.../src/<a href=3D"http://lib.rs" rel=3D"noreferrer" =
target=3D"_blank">lib.rs</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
20 +-<br>
&gt; &gt;=C2=A0 =C2=A0.../src/<a href=3D"http://tests.rs" rel=3D"noreferrer=
" target=3D"_blank">tests.rs</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=
=A08 +-<br>
&gt; &gt;=C2=A0 =C2=A0rust/qom/Cargo.toml=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 23 +=
+<br>
&gt; &gt;=C2=A0 =C2=A0rust/qom/<a href=3D"http://build.rs" rel=3D"noreferre=
r" target=3D"_blank">build.rs</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 43 ++=
+<br>
&gt; &gt;=C2=A0 =C2=A0rust/qom/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 61 ++++=
<br>
&gt; &gt;=C2=A0 =C2=A0rust/qom/src/<a href=3D"http://bindings.rs" rel=3D"no=
referrer" target=3D"_blank">bindings.rs</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 25 ++<br>
&gt; &gt;=C2=A0 =C2=A0rust/qom/src/<a href=3D"http://lib.rs" rel=3D"norefer=
rer" target=3D"_blank">lib.rs</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A04 +<br=
>
&gt; &gt;=C2=A0 =C2=A0rust/{qemu-api =3D&gt; qom}/src/<a href=3D"http://qom=
.rs" rel=3D"noreferrer" target=3D"_blank">qom.rs</a>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 27 +-<br>
&gt; &gt;=C2=A0 =C2=A0rust/qom/tests/<a href=3D"http://tests.rs" rel=3D"nor=
eferrer" target=3D"_blank">tests.rs</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 47 +++<br>
&gt; &gt;=C2=A0 =C2=A0rust/system/Cargo.toml=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 22 ++<br>
&gt; &gt;=C2=A0 =C2=A0rust/system/<a href=3D"http://build.rs" rel=3D"norefe=
rrer" target=3D"_blank">build.rs</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 43 +++<br>
&gt; &gt;=C2=A0 =C2=A0rust/system/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 57 +++<br>
&gt; &gt;=C2=A0 =C2=A0rust/{qemu-api =3D&gt; system}/src/<a href=3D"http://=
bindings.rs" rel=3D"noreferrer" target=3D"_blank">bindings.rs</a>=C2=A0 =C2=
=A0 =C2=A0|=C2=A0 33 +-<br>
&gt; &gt;=C2=A0 =C2=A0rust/system/src/<a href=3D"http://lib.rs" rel=3D"nore=
ferrer" target=3D"_blank">lib.rs</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A04 +<br>
&gt; &gt;=C2=A0 =C2=A0rust/{qemu-api =3D&gt; system}/src/<a href=3D"http://=
memory.rs" rel=3D"noreferrer" target=3D"_blank">memory.rs</a>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 20 +-<br>
&gt; &gt;=C2=A0 =C2=A0rust/tests/Cargo.toml=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 30 ++<br=
>
&gt; &gt;=C2=A0 =C2=A0rust/tests/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 14 +<br>
&gt; &gt;=C2=A0 =C2=A0.../tests/<a href=3D"http://vmstate_tests.rs" rel=3D"=
noreferrer" target=3D"_blank">vmstate_tests.rs</a>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 18 +-<br>
&gt; &gt;=C2=A0 =C2=A0rust/util/Cargo.toml=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 23 ++<b=
r>
&gt; &gt;=C2=A0 =C2=A0rust/util/<a href=3D"http://build.rs" rel=3D"noreferr=
er" target=3D"_blank">build.rs</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 43 +++<br>
&gt; &gt;=C2=A0 =C2=A0rust/util/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 61 ++++<=
br>
&gt; &gt;=C2=A0 =C2=A0rust/util/src/<a href=3D"http://bindings.rs" rel=3D"n=
oreferrer" target=3D"_blank">bindings.rs</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 25 ++<br>
&gt; &gt;=C2=A0 =C2=A0rust/{qemu-api =3D&gt; util}/src/<a href=3D"http://er=
rno.rs" rel=3D"noreferrer" target=3D"_blank">errno.rs</a>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 11 +-<br>
&gt; &gt;=C2=A0 =C2=A0rust/{qemu-api =3D&gt; util}/src/<a href=3D"http://er=
ror.rs" rel=3D"noreferrer" target=3D"_blank">error.rs</a>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A06 +-<br>
&gt; &gt;=C2=A0 =C2=A0rust/util/src/<a href=3D"http://lib.rs" rel=3D"norefe=
rrer" target=3D"_blank">lib.rs</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 10 +<br>
&gt; &gt;=C2=A0 =C2=A0rust/{qemu-api =3D&gt; util}/src/<a href=3D"http://lo=
g.rs" rel=3D"noreferrer" target=3D"_blank">log.rs</a>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 12 +-<br>
&gt; &gt;=C2=A0 =C2=A0rust/{qemu-api =3D&gt; util}/src/<a href=3D"http://mo=
dule.rs" rel=3D"noreferrer" target=3D"_blank">module.rs</a>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +-<br>
&gt; &gt;=C2=A0 =C2=A0rust/{qemu-api =3D&gt; util}/src/<a href=3D"http://ti=
mer.rs" rel=3D"noreferrer" target=3D"_blank">timer.rs</a>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 12 +-<br>
&gt; &gt;=C2=A0 =C2=A0100 files changed, 2372 insertions(+), 1044 deletions=
(-)<br>
&gt; &gt;=C2=A0 =C2=A0create mode 100644 rust/bql/wrapper.h<br>
&gt; &gt;=C2=A0 =C2=A0create mode 100644 rust/chardev/wrapper.h<br>
&gt; &gt;=C2=A0 =C2=A0create mode 100644 rust/hw/char/pl011/wrapper.h<br>
&gt; &gt;=C2=A0 =C2=A0create mode 100644 rust/hw/core/wrapper.h<br>
&gt; &gt;=C2=A0 =C2=A0rename rust/{qemu-api =3D&gt; migration}/wrapper.h (7=
7%)<br>
&gt; &gt;=C2=A0 =C2=A0create mode 100644 rust/qom/wrapper.h<br>
&gt; &gt;=C2=A0 =C2=A0create mode 100644 rust/system/wrapper.h<br>
&gt; &gt;=C2=A0 =C2=A0create mode 100644 rust/util/wrapper.h<br>
&gt; &gt;=C2=A0 =C2=A0rename rust/{qemu-api =3D&gt; bql}/Cargo.toml (52%)<b=
r>
&gt; &gt;=C2=A0 =C2=A0rename rust/{qemu-api =3D&gt; bql}/<a href=3D"http://=
build.rs" rel=3D"noreferrer" target=3D"_blank">build.rs</a> (96%)<br>
&gt; &gt;=C2=A0 =C2=A0create mode 100644 rust/bql/meson.build<br>
&gt; &gt;=C2=A0 =C2=A0create mode 100644 rust/bql/src/<a href=3D"http://bin=
dings.rs" rel=3D"noreferrer" target=3D"_blank">bindings.rs</a><br>
&gt; &gt;=C2=A0 =C2=A0rename rust/{qemu-api =3D&gt; bql}/src/<a href=3D"htt=
p://cell.rs" rel=3D"noreferrer" target=3D"_blank">cell.rs</a> (70%)<br>
&gt; &gt;=C2=A0 =C2=A0create mode 100644 rust/bql/src/<a href=3D"http://lib=
.rs" rel=3D"noreferrer" target=3D"_blank">lib.rs</a><br>
&gt; &gt;=C2=A0 =C2=A0create mode 100644 rust/chardev/Cargo.toml<br>
&gt; &gt;=C2=A0 =C2=A0create mode 100644 rust/chardev/<a href=3D"http://bui=
ld.rs" rel=3D"noreferrer" target=3D"_blank">build.rs</a><br>
&gt; &gt;=C2=A0 =C2=A0create mode 100644 rust/chardev/meson.build<br>
&gt; &gt;=C2=A0 =C2=A0create mode 100644 rust/chardev/src/<a href=3D"http:/=
/bindings.rs" rel=3D"noreferrer" target=3D"_blank">bindings.rs</a><br>
&gt; &gt;=C2=A0 =C2=A0rename rust/{qemu-api =3D&gt; chardev}/src/<a href=3D=
"http://chardev.rs" rel=3D"noreferrer" target=3D"_blank">chardev.rs</a> (91=
%)<br>
&gt; &gt;=C2=A0 =C2=A0create mode 100644 rust/chardev/src/<a href=3D"http:/=
/lib.rs" rel=3D"noreferrer" target=3D"_blank">lib.rs</a><br>
&gt; &gt;=C2=A0 =C2=A0create mode 100644 rust/common/Cargo.toml<br>
&gt; &gt;=C2=A0 =C2=A0create mode 100644 rust/common/meson.build<br>
&gt; &gt;=C2=A0 =C2=A0rename rust/{qemu-api =3D&gt; common}/src/<a href=3D"=
http://assertions.rs" rel=3D"noreferrer" target=3D"_blank">assertions.rs</a=
> (92%)<br>
&gt; &gt;=C2=A0 =C2=A0rename rust/{qemu-api =3D&gt; common}/src/<a href=3D"=
http://bitops.rs" rel=3D"noreferrer" target=3D"_blank">bitops.rs</a> (98%)<=
br>
&gt; &gt;=C2=A0 =C2=A0rename rust/{qemu-api =3D&gt; common}/src/<a href=3D"=
http://callbacks.rs" rel=3D"noreferrer" target=3D"_blank">callbacks.rs</a> =
(97%)<br>
&gt; &gt;=C2=A0 =C2=A0create mode 100644 rust/common/src/<a href=3D"http://=
lib.rs" rel=3D"noreferrer" target=3D"_blank">lib.rs</a><br>
&gt; &gt;=C2=A0 =C2=A0create mode 100644 rust/common/src/<a href=3D"http://=
opaque.rs" rel=3D"noreferrer" target=3D"_blank">opaque.rs</a><br>
&gt; &gt;=C2=A0 =C2=A0rename rust/{qemu-api =3D&gt; common}/src/<a href=3D"=
http://uninit.rs" rel=3D"noreferrer" target=3D"_blank">uninit.rs</a> (98%)<=
br>
&gt; &gt;=C2=A0 =C2=A0create mode 100644 rust/common/src/<a href=3D"http://=
zeroable.rs" rel=3D"noreferrer" target=3D"_blank">zeroable.rs</a><br>
&gt; &gt;=C2=A0 =C2=A0create mode 100644 rust/hw/char/pl011/<a href=3D"http=
://build.rs" rel=3D"noreferrer" target=3D"_blank">build.rs</a><br>
&gt; &gt;=C2=A0 =C2=A0create mode 100644 rust/hw/char/pl011/src/<a href=3D"=
http://bindings.rs" rel=3D"noreferrer" target=3D"_blank">bindings.rs</a><br=
>
&gt; &gt;=C2=A0 =C2=A0create mode 100644 rust/hw/core/Cargo.toml<br>
&gt; &gt;=C2=A0 =C2=A0create mode 100644 rust/hw/core/<a href=3D"http://bui=
ld.rs" rel=3D"noreferrer" target=3D"_blank">build.rs</a><br>
&gt; &gt;=C2=A0 =C2=A0rename rust/{qemu-api =3D&gt; hw/core}/meson.build (5=
2%)<br>
&gt; &gt;=C2=A0 =C2=A0create mode 100644 rust/hw/core/src/<a href=3D"http:/=
/bindings.rs" rel=3D"noreferrer" target=3D"_blank">bindings.rs</a><br>
&gt; &gt;=C2=A0 =C2=A0rename rust/{qemu-api =3D&gt; hw/core}/src/<a href=3D=
"http://irq.rs" rel=3D"noreferrer" target=3D"_blank">irq.rs</a> (92%)<br>
&gt; &gt;=C2=A0 =C2=A0create mode 100644 rust/hw/core/src/<a href=3D"http:/=
/lib.rs" rel=3D"noreferrer" target=3D"_blank">lib.rs</a><br>
&gt; &gt;=C2=A0 =C2=A0rename rust/{qemu-api =3D&gt; hw/core}/src/<a href=3D=
"http://qdev.rs" rel=3D"noreferrer" target=3D"_blank">qdev.rs</a> (86%)<br>
&gt; &gt;=C2=A0 =C2=A0rename rust/{qemu-api =3D&gt; hw/core}/src/<a href=3D=
"http://sysbus.rs" rel=3D"noreferrer" target=3D"_blank">sysbus.rs</a> (87%)=
<br>
&gt; &gt;=C2=A0 =C2=A0rename rust/{qemu-api =3D&gt; hw/core}/tests/<a href=
=3D"http://tests.rs" rel=3D"noreferrer" target=3D"_blank">tests.rs</a> (88%=
)<br>
&gt; &gt;=C2=A0 =C2=A0create mode 100644 rust/migration/Cargo.toml<br>
&gt; &gt;=C2=A0 =C2=A0create mode 100644 rust/migration/<a href=3D"http://b=
uild.rs" rel=3D"noreferrer" target=3D"_blank">build.rs</a><br>
&gt; &gt;=C2=A0 =C2=A0create mode 100644 rust/migration/meson.build<br>
&gt; &gt;=C2=A0 =C2=A0create mode 100644 rust/migration/src/<a href=3D"http=
://bindings.rs" rel=3D"noreferrer" target=3D"_blank">bindings.rs</a><br>
&gt; &gt;=C2=A0 =C2=A0create mode 100644 rust/migration/src/<a href=3D"http=
://lib.rs" rel=3D"noreferrer" target=3D"_blank">lib.rs</a><br>
&gt; &gt;=C2=A0 =C2=A0rename rust/{qemu-api =3D&gt; migration}/src/<a href=
=3D"http://vmstate.rs" rel=3D"noreferrer" target=3D"_blank">vmstate.rs</a> =
(80%)<br>
&gt; &gt;=C2=A0 =C2=A0delete mode 100644 rust/qemu-api/.gitignore<br>
&gt; &gt;=C2=A0 =C2=A0delete mode 100644 rust/qemu-api/README.md<br>
&gt; &gt;=C2=A0 =C2=A0delete mode 100644 rust/qemu-api/src/<a href=3D"http:=
//lib.rs" rel=3D"noreferrer" target=3D"_blank">lib.rs</a><br>
&gt; &gt;=C2=A0 =C2=A0delete mode 100644 rust/qemu-api/src/<a href=3D"http:=
//prelude.rs" rel=3D"noreferrer" target=3D"_blank">prelude.rs</a><br>
&gt; &gt;=C2=A0 =C2=A0delete mode 100644 rust/qemu-api/src/<a href=3D"http:=
//zeroable.rs" rel=3D"noreferrer" target=3D"_blank">zeroable.rs</a><br>
&gt; &gt;=C2=A0 =C2=A0rename rust/{qemu-api-macros =3D&gt; qemu-macros}/Car=
go.toml (94%)<br>
&gt; &gt;=C2=A0 =C2=A0rename rust/{qemu-api-macros =3D&gt; qemu-macros}/mes=
on.build (63%)<br>
&gt; &gt;=C2=A0 =C2=A0rename rust/{qemu-api-macros =3D&gt; qemu-macros}/src=
/<a href=3D"http://bits.rs" rel=3D"noreferrer" target=3D"_blank">bits.rs</a=
> (100%)<br>
&gt; &gt;=C2=A0 =C2=A0rename rust/{qemu-api-macros =3D&gt; qemu-macros}/src=
/<a href=3D"http://lib.rs" rel=3D"noreferrer" target=3D"_blank">lib.rs</a> =
(91%)<br>
&gt; &gt;=C2=A0 =C2=A0rename rust/{qemu-api-macros =3D&gt; qemu-macros}/src=
/<a href=3D"http://tests.rs" rel=3D"noreferrer" target=3D"_blank">tests.rs<=
/a> (93%)<br>
&gt; &gt;=C2=A0 =C2=A0create mode 100644 rust/qom/Cargo.toml<br>
&gt; &gt;=C2=A0 =C2=A0create mode 100644 rust/qom/<a href=3D"http://build.r=
s" rel=3D"noreferrer" target=3D"_blank">build.rs</a><br>
&gt; &gt;=C2=A0 =C2=A0create mode 100644 rust/qom/meson.build<br>
&gt; &gt;=C2=A0 =C2=A0create mode 100644 rust/qom/src/<a href=3D"http://bin=
dings.rs" rel=3D"noreferrer" target=3D"_blank">bindings.rs</a><br>
&gt; &gt;=C2=A0 =C2=A0create mode 100644 rust/qom/src/<a href=3D"http://lib=
.rs" rel=3D"noreferrer" target=3D"_blank">lib.rs</a><br>
&gt; &gt;=C2=A0 =C2=A0rename rust/{qemu-api =3D&gt; qom}/src/<a href=3D"htt=
p://qom.rs" rel=3D"noreferrer" target=3D"_blank">qom.rs</a> (98%)<br>
&gt; &gt;=C2=A0 =C2=A0create mode 100644 rust/qom/tests/<a href=3D"http://t=
ests.rs" rel=3D"noreferrer" target=3D"_blank">tests.rs</a><br>
&gt; &gt;=C2=A0 =C2=A0create mode 100644 rust/system/Cargo.toml<br>
&gt; &gt;=C2=A0 =C2=A0create mode 100644 rust/system/<a href=3D"http://buil=
d.rs" rel=3D"noreferrer" target=3D"_blank">build.rs</a><br>
&gt; &gt;=C2=A0 =C2=A0create mode 100644 rust/system/meson.build<br>
&gt; &gt;=C2=A0 =C2=A0rename rust/{qemu-api =3D&gt; system}/src/<a href=3D"=
http://bindings.rs" rel=3D"noreferrer" target=3D"_blank">bindings.rs</a> (5=
6%)<br>
&gt; &gt;=C2=A0 =C2=A0create mode 100644 rust/system/src/<a href=3D"http://=
lib.rs" rel=3D"noreferrer" target=3D"_blank">lib.rs</a><br>
&gt; &gt;=C2=A0 =C2=A0rename rust/{qemu-api =3D&gt; system}/src/<a href=3D"=
http://memory.rs" rel=3D"noreferrer" target=3D"_blank">memory.rs</a> (95%)<=
br>
&gt; &gt;=C2=A0 =C2=A0create mode 100644 rust/tests/Cargo.toml<br>
&gt; &gt;=C2=A0 =C2=A0create mode 100644 rust/tests/meson.build<br>
&gt; &gt;=C2=A0 =C2=A0rename rust/{qemu-api =3D&gt; tests}/tests/<a href=3D=
"http://vmstate_tests.rs" rel=3D"noreferrer" target=3D"_blank">vmstate_test=
s.rs</a> (96%)<br>
&gt; &gt;=C2=A0 =C2=A0create mode 100644 rust/util/Cargo.toml<br>
&gt; &gt;=C2=A0 =C2=A0create mode 100644 rust/util/<a href=3D"http://build.=
rs" rel=3D"noreferrer" target=3D"_blank">build.rs</a><br>
&gt; &gt;=C2=A0 =C2=A0create mode 100644 rust/util/meson.build<br>
&gt; &gt;=C2=A0 =C2=A0create mode 100644 rust/util/src/<a href=3D"http://bi=
ndings.rs" rel=3D"noreferrer" target=3D"_blank">bindings.rs</a><br>
&gt; &gt;=C2=A0 =C2=A0rename rust/{qemu-api =3D&gt; util}/src/<a href=3D"ht=
tp://errno.rs" rel=3D"noreferrer" target=3D"_blank">errno.rs</a> (98%)<br>
&gt; &gt;=C2=A0 =C2=A0rename rust/{qemu-api =3D&gt; util}/src/<a href=3D"ht=
tp://error.rs" rel=3D"noreferrer" target=3D"_blank">error.rs</a> (98%)<br>
&gt; &gt;=C2=A0 =C2=A0create mode 100644 rust/util/src/<a href=3D"http://li=
b.rs" rel=3D"noreferrer" target=3D"_blank">lib.rs</a><br>
&gt; &gt;=C2=A0 =C2=A0rename rust/{qemu-api =3D&gt; util}/src/<a href=3D"ht=
tp://log.rs" rel=3D"noreferrer" target=3D"_blank">log.rs</a> (93%)<br>
&gt; &gt;=C2=A0 =C2=A0rename rust/{qemu-api =3D&gt; util}/src/<a href=3D"ht=
tp://module.rs" rel=3D"noreferrer" target=3D"_blank">module.rs</a> (97%)<br=
>
&gt; &gt;=C2=A0 =C2=A0rename rust/{qemu-api =3D&gt; util}/src/<a href=3D"ht=
tp://timer.rs" rel=3D"noreferrer" target=3D"_blank">timer.rs</a> (93%)<br>
&gt; &gt;<br>
&gt;<br>
<br>
</blockquote></div></div>

--000000000000277b35063d463f13--


