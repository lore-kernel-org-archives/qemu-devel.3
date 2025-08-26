Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAD3CCA0FE7
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 14:57:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqv6D-000795-JM; Tue, 26 Aug 2025 10:56:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uqv68-00078N-IK
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 10:56:34 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uqv5y-0000Zl-M1
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 10:56:32 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-61c3360bbaeso4187919a12.1
 for <qemu-devel@nongnu.org>; Tue, 26 Aug 2025 07:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756220172; x=1756824972; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bHYXXI+kjS/eHEH37nYKV+5H7TWdOYDjvDJ+ZzFlFvY=;
 b=lBoJYvzZfW2Yf2kETI6fxGUSLE38yy35ntL2wvy3gppSwdZke/Apmk0jSf1XM5bUZi
 0wwUx1onC/NHMAzV2KXTmgWL0bhUnLp8DfVVHgppedFQ2pugqwuTXpz0huvGSAjN87EQ
 79GgDvotwIpbyAtiekKBenhgZf27v1ruv0ZUerlKwXAOeKbPmDa2xrsBAK98km8IC92+
 s6i6NPON+51gGO4s8UXCnJ1rY28oZYIvTajFt3SadUla4Jaf6rdo0yaymUBUe5G8+QVN
 PBTV+haFXecu3uvZz6cd3pXYkeS+Njy+h+2ezchhjJmrtQGbHJNToc64ikmXkou4qozN
 m9SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756220172; x=1756824972;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bHYXXI+kjS/eHEH37nYKV+5H7TWdOYDjvDJ+ZzFlFvY=;
 b=wfmnqMkuPZ9Y9TeiTpqiKBHWqTAAUYIDyA/MwaFUVD1INrIKPIDbYalDWg5LBHTyKw
 zPIZTuqYejWOg0LTb9+4Psu6VSxC7ZXklYIZTl89KOnNadUKzhD1mPjHv8Se+S/doG0n
 m4MgAr/MPS2jZkBbBRUrXRE6aM+8djn88k5S4U0WFPkv/IquW2EcxkTJIlQWsinQG+r/
 i+L67/wUcvZ7zP7T/na85LZUbtocW97SdKyOPHhW2znSUV1phXYjrVuBYctsaxgXtPco
 qslmrGcqZtnYEFQizz13ZbJeN8EnnC7vqK49Dd8BWOZGRg+9OIqDMyMv/F1U+FpiR3CY
 OLZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQlEFiPEnv4hPIkkSrD/oHBry4ktk8CKhzIh7fG4TyH/ojNNXw1eUj8c2i4SfjCjgR7Ce2wIRwqPEH@nongnu.org
X-Gm-Message-State: AOJu0YzvacOZId+NvHoSXyBE9lSUiPf7I63aT5DYCcLf0OojX2l9A7l+
 FjCuUVZMX1S1OBNu5VfzYFBFJfSPQssAKH5nWbNyTRVqXB+l525vXOahFynrv6OOFmfp82OfHFB
 jVW7ICQNXbVLihsahvUe0Ba13N4isHOBERx2vHRZ3zQ==
X-Gm-Gg: ASbGnctVOxKL0qYLkP1gMnoJ63aYGt+1fczftTd+yx3DMhA9idGSJoJK4hy69IWofg0
 6Kt3TvxWPXLrna8BOH56BMUfDGPKChgtZggajd+VO4HBI2wkrfyEi7diWkOoN7jk68M/TXQsvNQ
 AZmcTnG7cNvK8ScTmeqIluBFoEt9MJ+p0qiyWMs8+f01iEZRQ8wfXhS1CPhVIh370E3GMH0Yv4E
 SyN7syddQ+ElBbLGW4=
X-Google-Smtp-Source: AGHT+IHNBSDkbK/igcktoyk+ezJp2BBa0HZ1T9Bp/dgMt2k6H/GUN+yu9Dr1IjTWqIAoF+WkZtwG1VRrRvO5wHMwf8E=
X-Received: by 2002:a05:6402:2684:b0:61c:7902:54b1 with SMTP id
 4fb4d7f45d1cf-61c79025a4fmr4284421a12.18.1756220172452; Tue, 26 Aug 2025
 07:56:12 -0700 (PDT)
MIME-Version: 1.0
References: <20250826140449.4190022-1-marcandre.lureau@redhat.com>
 <e58ea933-f941-44d8-8477-c8298663cc24@redhat.com>
In-Reply-To: <e58ea933-f941-44d8-8477-c8298663cc24@redhat.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Tue, 26 Aug 2025 17:55:46 +0300
X-Gm-Features: Ac12FXwzb2H0Cw9XOm0hZZ7pXJKOP_fCvBP2m1sv8omrxqiZ69rJ7BeJ8iNvVdg
Message-ID: <CAAjaMXYwEwpaybjEiA6tBCartTrzoAqsKNzHSfrs4f2wJx-wjA@mail.gmail.com>
Subject: Re: [RFC 00/18] rust: split qemu-api
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-rust@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Tue, Aug 26, 2025 at 5:44=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> On 8/26/25 16:04, marcandre.lureau@redhat.com wrote:
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > Hi,
> >
> > qemu-api is providing bindings for various internal libraries. Instead,=
 the
> > bindings requirements should match the various libraries and use the mi=
nimal set
> > of dependencies.
> >
> > An initial Rust-only "common" crate is introduced, then "util" (for lib=
qemuutil,
> > without bql), "migration" (so it doesn't depend on bql), "bql", "qom" (=
arguably,
> > bql shouldn't be required?), and "chardev", "system", "hwcore". Finally=
 the
> > qemu-api crates are renamed and repurposed.
> >
> > This involves a lot of code churn, so hopefully it can be reviewed and =
merged
> > early and iterated upon :)
>
> The one comment that I would like to handle before merging, is that I'd
> prefer to keep the preludes and, in fact, even add more exports to them
> since they can now be chosen per-crate.  Ideally, many of the crates
> you've crated would be accessed through many "use xyz::prelude::*"
> statements.

I kind of agree with this sentiment. What this series basically does
is unwrapping most modules to standalone crates. Semantically, they
make sense to be their own crates just like they made sense being
their own modules before). But I'm not sure what developer benefit
this brings, it's like splitting Rust's std crate to separate crates
(ergonomically speaking). Big crates like tokio split implementation
to crates and then re-export them under tokio::* to ease compilation
parallelism which we should definitely try to do as well. However in
our case our Rust wrappers are very small. Let's do this if they ever
end up growing unwieldy.

> Also, if I understood correctly the split util/errno.rs can move to
> common/.  While it has a dependency on libc, it doesn't need bindgen.
>
> There's a bunch of code duplication for the various bindings.rs and
> build.rs files, which is not ideal but shouldn't grow much more than
> this.  I wonder if, later, common code across build.rs could be written
> just once by adding a new crate (e.g. "qemu_meson") to the workspace,
> that can be used as a build-dependency.
>
> Paolo
>
> > Marc-Andr=C3=A9 Lureau (18):
> >    rust: remove unused global qemu "allocator"
> >    rust: add workspace authors
> >    rust: split Rust-only "common" crate
> >    rust: split "util" crate
> >    rust: move vmstate_clock!() to qdev module
> >    rust: move VMState handling to QOM module
> >    rust: move Cell vmstate impl
> >    rust: split "migration" crate
> >    rust: split "bql" crate
> >    rust: split "qom" crate
> >    rust: split "chardev" crate
> >    rust: split "system" crate
> >    rust: split "hwcore" crate
> >    rust: rename qemu_api_macros -> qemu_macros
> >    rust/hpet: drop now unneeded qemu_api dep
> >    rust/pl011: drop dependency on qemu_api
> >    rust: repurpose qemu_api -> tests
> >    docs: update rust.rst
> >
> >   MAINTAINERS                                   |  12 +-
> >   docs/devel/rust.rst                           |  51 +--
> >   meson.build                                   |   4 -
> >   rust/bql/wrapper.h                            |  27 ++
> >   rust/chardev/wrapper.h                        |  28 ++
> >   rust/hw/char/pl011/wrapper.h                  |  51 +++
> >   rust/hw/core/wrapper.h                        |  32 ++
> >   rust/{qemu-api =3D> migration}/wrapper.h        |  20 --
> >   rust/qom/wrapper.h                            |  27 ++
> >   rust/system/wrapper.h                         |  29 ++
> >   rust/util/wrapper.h                           |  32 ++
> >   rust/Cargo.lock                               | 127 ++++++-
> >   rust/Cargo.toml                               |  16 +-
> >   rust/bits/Cargo.toml                          |   2 +-
> >   rust/bits/meson.build                         |   2 +-
> >   rust/bits/src/lib.rs                          |   4 +-
> >   rust/{qemu-api =3D> bql}/Cargo.toml             |  13 +-
> >   rust/{qemu-api =3D> bql}/build.rs               |   2 +-
> >   rust/bql/meson.build                          |  52 +++
> >   rust/bql/src/bindings.rs                      |  25 ++
> >   rust/{qemu-api =3D> bql}/src/cell.rs            | 333 +++------------=
---
> >   rust/bql/src/lib.rs                           |  29 ++
> >   rust/chardev/Cargo.toml                       |  24 ++
> >   rust/chardev/build.rs                         |  43 +++
> >   rust/chardev/meson.build                      |  54 +++
> >   rust/chardev/src/bindings.rs                  |  36 ++
> >   rust/{qemu-api =3D> chardev}/src/chardev.rs     |  35 +-
> >   rust/chardev/src/lib.rs                       |   4 +
> >   rust/common/Cargo.toml                        |  16 +
> >   rust/common/meson.build                       |  32 ++
> >   rust/{qemu-api =3D> common}/src/assertions.rs   |  16 +-
> >   rust/{qemu-api =3D> common}/src/bitops.rs       |   1 -
> >   rust/{qemu-api =3D> common}/src/callbacks.rs    |  12 +-
> >   rust/common/src/lib.rs                        |  17 +
> >   rust/common/src/opaque.rs                     | 240 +++++++++++++
> >   rust/{qemu-api =3D> common}/src/uninit.rs       |   2 +-
> >   rust/common/src/zeroable.rs                   |  18 +
> >   rust/hw/char/pl011/Cargo.toml                 |  11 +-
> >   rust/hw/char/pl011/build.rs                   |  43 +++
> >   rust/hw/char/pl011/meson.build                |  39 +-
> >   rust/hw/char/pl011/src/bindings.rs            |  27 ++
> >   rust/hw/char/pl011/src/device.rs              |  49 +--
> >   rust/hw/char/pl011/src/lib.rs                 |   1 +
> >   rust/hw/char/pl011/src/registers.rs           |   4 +-
> >   rust/hw/core/Cargo.toml                       |  26 ++
> >   rust/hw/core/build.rs                         |  43 +++
> >   rust/{qemu-api =3D> hw/core}/meson.build        |  86 ++---
> >   rust/hw/core/src/bindings.rs                  |  41 +++
> >   rust/{qemu-api =3D> hw/core}/src/irq.rs         |  18 +-
> >   rust/hw/core/src/lib.rs                       |  12 +
> >   rust/{qemu-api =3D> hw/core}/src/qdev.rs        |  81 +++--
> >   rust/{qemu-api =3D> hw/core}/src/sysbus.rs      |  28 +-
> >   rust/{qemu-api =3D> hw/core}/tests/tests.rs     |  29 +-
> >   rust/hw/timer/hpet/Cargo.toml                 |  10 +-
> >   rust/hw/timer/hpet/meson.build                |  12 +-
> >   rust/hw/timer/hpet/src/device.rs              |  56 ++-
> >   rust/hw/timer/hpet/src/fw_cfg.rs              |   6 +-
> >   rust/meson.build                              |  12 +-
> >   rust/migration/Cargo.toml                     |  21 ++
> >   rust/migration/build.rs                       |  43 +++
> >   rust/migration/meson.build                    |  57 +++
> >   rust/migration/src/bindings.rs                |  48 +++
> >   rust/migration/src/lib.rs                     |   4 +
> >   rust/{qemu-api =3D> migration}/src/vmstate.rs   | 166 ++++-----
> >   rust/qemu-api/.gitignore                      |   2 -
> >   rust/qemu-api/README.md                       |  19 -
> >   rust/qemu-api/src/lib.rs                      | 170 ---------
> >   rust/qemu-api/src/prelude.rs                  |  31 --
> >   rust/qemu-api/src/zeroable.rs                 |  37 --
> >   .../Cargo.toml                                |   2 +-
> >   .../meson.build                               |  10 +-
> >   .../src/bits.rs                               |   0
> >   .../src/lib.rs                                |  20 +-
> >   .../src/tests.rs                              |   8 +-
> >   rust/qom/Cargo.toml                           |  23 ++
> >   rust/qom/build.rs                             |  43 +++
> >   rust/qom/meson.build                          |  61 ++++
> >   rust/qom/src/bindings.rs                      |  25 ++
> >   rust/qom/src/lib.rs                           |   4 +
> >   rust/{qemu-api =3D> qom}/src/qom.rs             |  27 +-
> >   rust/qom/tests/tests.rs                       |  47 +++
> >   rust/system/Cargo.toml                        |  22 ++
> >   rust/system/build.rs                          |  43 +++
> >   rust/system/meson.build                       |  57 +++
> >   rust/{qemu-api =3D> system}/src/bindings.rs     |  33 +-
> >   rust/system/src/lib.rs                        |   4 +
> >   rust/{qemu-api =3D> system}/src/memory.rs       |  20 +-
> >   rust/tests/Cargo.toml                         |  30 ++
> >   rust/tests/meson.build                        |  14 +
> >   .../tests/vmstate_tests.rs                    |  18 +-
> >   rust/util/Cargo.toml                          |  23 ++
> >   rust/util/build.rs                            |  43 +++
> >   rust/util/meson.build                         |  61 ++++
> >   rust/util/src/bindings.rs                     |  25 ++
> >   rust/{qemu-api =3D> util}/src/errno.rs          |  11 +-
> >   rust/{qemu-api =3D> util}/src/error.rs          |   6 +-
> >   rust/util/src/lib.rs                          |  10 +
> >   rust/{qemu-api =3D> util}/src/log.rs            |  12 +-
> >   rust/{qemu-api =3D> util}/src/module.rs         |   2 +-
> >   rust/{qemu-api =3D> util}/src/timer.rs          |  12 +-
> >   100 files changed, 2372 insertions(+), 1044 deletions(-)
> >   create mode 100644 rust/bql/wrapper.h
> >   create mode 100644 rust/chardev/wrapper.h
> >   create mode 100644 rust/hw/char/pl011/wrapper.h
> >   create mode 100644 rust/hw/core/wrapper.h
> >   rename rust/{qemu-api =3D> migration}/wrapper.h (77%)
> >   create mode 100644 rust/qom/wrapper.h
> >   create mode 100644 rust/system/wrapper.h
> >   create mode 100644 rust/util/wrapper.h
> >   rename rust/{qemu-api =3D> bql}/Cargo.toml (52%)
> >   rename rust/{qemu-api =3D> bql}/build.rs (96%)
> >   create mode 100644 rust/bql/meson.build
> >   create mode 100644 rust/bql/src/bindings.rs
> >   rename rust/{qemu-api =3D> bql}/src/cell.rs (70%)
> >   create mode 100644 rust/bql/src/lib.rs
> >   create mode 100644 rust/chardev/Cargo.toml
> >   create mode 100644 rust/chardev/build.rs
> >   create mode 100644 rust/chardev/meson.build
> >   create mode 100644 rust/chardev/src/bindings.rs
> >   rename rust/{qemu-api =3D> chardev}/src/chardev.rs (91%)
> >   create mode 100644 rust/chardev/src/lib.rs
> >   create mode 100644 rust/common/Cargo.toml
> >   create mode 100644 rust/common/meson.build
> >   rename rust/{qemu-api =3D> common}/src/assertions.rs (92%)
> >   rename rust/{qemu-api =3D> common}/src/bitops.rs (98%)
> >   rename rust/{qemu-api =3D> common}/src/callbacks.rs (97%)
> >   create mode 100644 rust/common/src/lib.rs
> >   create mode 100644 rust/common/src/opaque.rs
> >   rename rust/{qemu-api =3D> common}/src/uninit.rs (98%)
> >   create mode 100644 rust/common/src/zeroable.rs
> >   create mode 100644 rust/hw/char/pl011/build.rs
> >   create mode 100644 rust/hw/char/pl011/src/bindings.rs
> >   create mode 100644 rust/hw/core/Cargo.toml
> >   create mode 100644 rust/hw/core/build.rs
> >   rename rust/{qemu-api =3D> hw/core}/meson.build (52%)
> >   create mode 100644 rust/hw/core/src/bindings.rs
> >   rename rust/{qemu-api =3D> hw/core}/src/irq.rs (92%)
> >   create mode 100644 rust/hw/core/src/lib.rs
> >   rename rust/{qemu-api =3D> hw/core}/src/qdev.rs (86%)
> >   rename rust/{qemu-api =3D> hw/core}/src/sysbus.rs (87%)
> >   rename rust/{qemu-api =3D> hw/core}/tests/tests.rs (88%)
> >   create mode 100644 rust/migration/Cargo.toml
> >   create mode 100644 rust/migration/build.rs
> >   create mode 100644 rust/migration/meson.build
> >   create mode 100644 rust/migration/src/bindings.rs
> >   create mode 100644 rust/migration/src/lib.rs
> >   rename rust/{qemu-api =3D> migration}/src/vmstate.rs (80%)
> >   delete mode 100644 rust/qemu-api/.gitignore
> >   delete mode 100644 rust/qemu-api/README.md
> >   delete mode 100644 rust/qemu-api/src/lib.rs
> >   delete mode 100644 rust/qemu-api/src/prelude.rs
> >   delete mode 100644 rust/qemu-api/src/zeroable.rs
> >   rename rust/{qemu-api-macros =3D> qemu-macros}/Cargo.toml (94%)
> >   rename rust/{qemu-api-macros =3D> qemu-macros}/meson.build (63%)
> >   rename rust/{qemu-api-macros =3D> qemu-macros}/src/bits.rs (100%)
> >   rename rust/{qemu-api-macros =3D> qemu-macros}/src/lib.rs (91%)
> >   rename rust/{qemu-api-macros =3D> qemu-macros}/src/tests.rs (93%)
> >   create mode 100644 rust/qom/Cargo.toml
> >   create mode 100644 rust/qom/build.rs
> >   create mode 100644 rust/qom/meson.build
> >   create mode 100644 rust/qom/src/bindings.rs
> >   create mode 100644 rust/qom/src/lib.rs
> >   rename rust/{qemu-api =3D> qom}/src/qom.rs (98%)
> >   create mode 100644 rust/qom/tests/tests.rs
> >   create mode 100644 rust/system/Cargo.toml
> >   create mode 100644 rust/system/build.rs
> >   create mode 100644 rust/system/meson.build
> >   rename rust/{qemu-api =3D> system}/src/bindings.rs (56%)
> >   create mode 100644 rust/system/src/lib.rs
> >   rename rust/{qemu-api =3D> system}/src/memory.rs (95%)
> >   create mode 100644 rust/tests/Cargo.toml
> >   create mode 100644 rust/tests/meson.build
> >   rename rust/{qemu-api =3D> tests}/tests/vmstate_tests.rs (96%)
> >   create mode 100644 rust/util/Cargo.toml
> >   create mode 100644 rust/util/build.rs
> >   create mode 100644 rust/util/meson.build
> >   create mode 100644 rust/util/src/bindings.rs
> >   rename rust/{qemu-api =3D> util}/src/errno.rs (98%)
> >   rename rust/{qemu-api =3D> util}/src/error.rs (98%)
> >   create mode 100644 rust/util/src/lib.rs
> >   rename rust/{qemu-api =3D> util}/src/log.rs (93%)
> >   rename rust/{qemu-api =3D> util}/src/module.rs (97%)
> >   rename rust/{qemu-api =3D> util}/src/timer.rs (93%)
> >
>

