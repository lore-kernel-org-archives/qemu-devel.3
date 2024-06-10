Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F1AAC27C55
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 20:00:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGlBY-0007cC-JL; Mon, 10 Jun 2024 16:00:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1sGlBR-0007as-Jn
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 16:00:01 -0400
Received: from mail-oo1-xc33.google.com ([2607:f8b0:4864:20::c33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1sGlBN-00010h-Ja
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 16:00:01 -0400
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-5bae81effd1so139360eaf.2
 for <qemu-devel@nongnu.org>; Mon, 10 Jun 2024 12:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718049595; x=1718654395; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i1Hw/V07I+/HkfD84XlX5hRaHW6fvtD6jJCHthCoIWE=;
 b=QXEEJ8J8K74jsxlZA+riZvjFi1lSEKqywCWiHQGSR2ftlh+7EQNKJC9PXgD6Yoyb2M
 nkuGrGN3nD4UyCYBHzXUKvgm0lC6zGEBFUL0a3mRrxrRqi4erye5rHEjhBvUcdZ/r5P7
 VI2V9Atn1dYi62DUqN6nyzt7xvpmR5tCR+zeOnuLw1F7tKhxx6oh+sqGFtKOgA8JA/kP
 6qTkqg4NhYGRLoo+0eTqgmWUxP1dSCoWpsMLcYTecDsI/nliEEhmYZhnN0JSkL73my8y
 SlKLERB1SGDcct26oRe4RNYoAlDJkvdAKncMLgc4tEmA84EbkPpzy9+scFSx03PeLd4c
 +A9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718049595; x=1718654395;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i1Hw/V07I+/HkfD84XlX5hRaHW6fvtD6jJCHthCoIWE=;
 b=FmD3uIWPtq4mPZzZuTGu+mz7ESQ1qgRSOHZVlHU05vFjiQ1Dk4sYv4EqM3Mo1XLK42
 Yt/48ki6Hei+SoHp4Aa3kkrMM4CLsXUyXIapDu+5UM0kM+3KpQer3LAWWS/1K1UG7rlo
 j9gdxVJcXsHLGNX0K4tKqhRwAVhz3rae8i1qXLaWzR+o4r2mgDtgTKy/8gX1Ckgl90fu
 QhWd2bOH+jOJSFrpZaKR269Cybrfqqc8YgLTkkROVHbA47Pj/C5bnrNaAT+fN/5AQtIk
 Tv2+YF063WbzTaD/iiLSu3kH+cHGst/3CRG5Yvvifvb2dIYslxybrGX+OCJPXBZVZmcp
 4POg==
X-Gm-Message-State: AOJu0YxIYCtbpcWUd50IyA+R+cu5SClRIgnDBtbSiY4ROkud2a0K2eZM
 i4FX79i0cWAsHXgfEK5XxZqmycELl+0TaXJBWOHEZd97ws8l+Y9CXfBD9nK9lQqP7eigifDLwiS
 vmgG4Ec7RM0RVo1kTfhqAaYPxVsY=
X-Google-Smtp-Source: AGHT+IECW5weAt02IkPpiXoTODAU9y8jT+K1+MA9CZwYMjWHrAp1HvPcGuIdjxIJQw3XZR3bRwa6dvF8RY6ydRDaAZM=
X-Received: by 2002:a4a:a381:0:b0:5ba:e1aa:9346 with SMTP id
 006d021491bc7-5bae1aa93f9mr5291824eaf.4.1718049595157; Mon, 10 Jun 2024
 12:59:55 -0700 (PDT)
MIME-Version: 1.0
References: <cover.rust-pl011-rfc-v1.git.manos.pitsidianakis@linaro.org>
In-Reply-To: <cover.rust-pl011-rfc-v1.git.manos.pitsidianakis@linaro.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 10 Jun 2024 15:59:42 -0400
Message-ID: <CAJSP0QU2Y_mNtYQtPbahnvj1eLLTu2Z-f4z-6VZgSSxqgVnPbQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1 0/6] Implement ARM PL011 in Rust
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, 
 Mads Ynddal <mads@ynddal.dk>, Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Zhao Liu <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c33;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc33.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, 10 Jun 2024 at 14:23, Manos Pitsidianakis
<manos.pitsidianakis@linaro.org> wrote:
>
> Hello everyone,
>
> This is an early draft of my work on implementing a very simple device,
> in this case the ARM PL011 (which in C code resides in hw/char/pl011.c
> and is used in hw/arm/virt.c).
>
> The device is functional, with copied logic from the C code but with
> effort not to make a direct C to Rust translation. In other words, do
> not write Rust as a C developer would.
>
> That goal is not complete but a best-effort case. To give a specific
> example, register values are typed but interrupt bit flags are not (but
> could be). I will leave such minutiae for later iterations.
>
> By the way, the wiki page for Rust was revived to keep track of all
> current series on the mailing list https://wiki.qemu.org/RustInQemu
>
> a #qemu-rust IRC channel was also created for rust-specific discussion
> that might flood #qemu
>
> ------------------------------------------------------------------------
> A request: keep comments to Rust in relation to the QEMU project and no
> debates on the merits of the language itself. These are valid concerns,
> but it'd be better if they were on separate mailing list threads.
> ------------------------------------------------------------------------
>
> Table of contents: [TOC]
>
> - How can I try it? [howcanItryit]
> - What are the most important points to focus on, at this point?
>   [whatarethemostimportant]
>   - What are the issues with not using the compiler, rustc, directly?
>     [whataretheissueswith]
>     1. Tooling
>     2. Rust dependencies
>
>   - Should QEMU use third-party dependencies? [shouldqemuusethirdparty]
>   - Should QEMU provide wrapping Rust APIs over QEMU internals?
>     [qemuprovidewrappingrustapis]
>   - Will QEMU now depend on Rust and thus not build on my XYZ platform?
>     [qemudependonrustnotbuildonxyz]
> - How is the compilation structured? [howisthecompilationstructured]
> - The generated.rs rust file includes a bunch of junk definitions?
>   [generatedrsincludesjunk]
> - The staticlib artifact contains a bunch of mangled .o objects?
>   [staticlibmangledobjects]
>
> How can I try it?
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [howcanItryit] Back to [TOC]
>
> Hopefully applying this patches (or checking out `master` branch from
> https://gitlab.com/epilys/rust-for-qemu/ current commit
> de81929e0e9d470deac2c6b449b7a5183325e7ee )
>
> Tag for this RFC is rust-pl011-rfc-v1
>
> Rustdoc documentation is hosted on
>
> https://rust-for-qemu-epilys-aebb06ca9f9adfe6584811c14ae44156501d935ba4.g=
itlab.io/pl011/index.html
>
> If `cargo` and `bindgen` is installed in your system, you should be able
> to build qemu-system-aarch64 with configure flag --enable-rust and
> launch an arm virt VM. One of the patches hardcodes the default UART of
> the machine to the Rust one, so if something goes wrong you will see it
> upon launching qemu-system-aarch64.
>
> To confirm it is there for sure, run e.g. info qom-tree on the monitor
> and look for x-pl011-rust.
>
>
> What are the most important points to focus on, at this point?
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [whatarethemostimportant] Back to [TOC]
>
> In my opinion, integration of the go-to Rust build system (Cargo and
> crates.io) with the build system we use in QEMU. This is "easily" done
> in some definition of the word with a python wrapper script.
>
> What are the issues with not using the compiler, rustc, directly?
> -----------------------------------------------------------------
> [whataretheissueswith] Back to [TOC]
>
> 1. Tooling
>    Mostly writing up the build-sys tooling to do so. Ideally we'd
>    compile everything without cargo but rustc directly.

Why would that be ideal?

>
>    If we decide we need Rust's `std` library support, we could
>    investigate whether building it from scratch is a good solution. This
>    will only build the bits we need in our devices.

Whether or not to use std is a fundamental decision. It might be
difficult to back from std later on. This is something that should be
discussed in more detail.

Do you want to avoid std for maximum flexibility in the future, or are
there QEMU use cases today where std is unavailable?

>
> 2. Rust dependencies
>    We could go without them completely. I chose deliberately to include
>    one dependency in my UART implementation, `bilge`[0], because it has
>    an elegant way of representing typed bitfields for the UART's
>    registers.
>
> [0]: Article: https://hecatia-elegua.github.io/blog/no-more-bit-fiddling/
>      Crates.io page: https://crates.io/crates/bilge
>      Repository: https://github.com/hecatia-elegua/bilge

I guess there will be interest in using rust-vmm crates in some way.

Bindings to platform features that are not available in core or std
will also be desirable. We probably don't want to reinvent them.

>
> Should QEMU use third-party dependencies?
> -----------------------------------------
> [shouldqemuusethirdparty] Back to [TOC]
>
> In my personal opinion, if we need a dependency we need a strong
> argument for it. A dependency needs a trusted upstream source, a QEMU
> maintainer to make sure it us up-to-date in QEMU etc.
>
> We already fetch some projects with meson subprojects, so this is not a
> new reality. Cargo allows you to define "locked" dependencies which is
> the same as only fetching specific commits by SHA. No suspicious
> tarballs, and no disappearing dependencies a la left-pad in npm.
>
> However, I believe it's worth considering vendoring every dependency by
> default, if they prove to be few, for the sake of having a local QEMU
> git clone buildable without network access.

Do you mean vendoring by committing them to qemu.git or just the
practice of running `cargo vendor` locally for users who decide they
want to keep a copy of the dependencies?

>
> Should QEMU provide wrapping Rust APIs over QEMU internals?
> -----------------------------------------------------------
> [qemuprovidewrappingrustapis] Back to [TOC]
>
> My personal opinion is no, with the reasoning being that QEMU internals
> are not documented or stable. However I do not see why creating stable
> opt-in interfaces is bad. It just needs someone to volunteer to maintain
> it and ensure there are no breakages through versions.

Rust code will need to interface with QEMU's C APIs, so Rust wrappers
seem unavoidable. Using a protocol like vhost-user might be possible
in some cases. It separates the two codebases so they can both be
native and without bindings, but that won't work for all parts of the
QEMU source tree.

Stable APIs aren't necessary if most developers in the QEMU community
are willing to work in both languages. They can adjust both C and Rust
code when making changes to APIs. I find this preferable to having
Rust maintainers whose job is to keep wrappers up-to-date. Those Rust
maintainers would probably burn out. This seems like a question of
which approach the developer community is comfortable with.

>
> Will QEMU now depend on Rust and thus not build on my XYZ platform?
> -------------------------------------------------------------------
> [qemudependonrustnotbuildonxyz] Back to [TOC]
>
> No, worry about this in some years if this experiment takes off. Rust
> has broad platform support and is present in most distro package
> managers. In the future we might have gcc support for it as well.
>
> For now, Rust will have an experimental status, and will be aimed to
> those who wish to try it. I leave it to the project leaders to make
> proper decisions and statements on this if necessary.

This can be discussed in a separate email thread if you prefer, but I
do think it needs agreement soon so that people have the confidence to
invest their time in writing Rust. They need to know that the code
they develop will be available on most platforms where QEMU is
available and that others in the community won't object or insist on a
C implementation for platform support reasons.

>
>
> How is the compilation structured?
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [howisthecompilationstructured] Back to [TOC]
>
> First, a meson target that runs `bindgen` on a bunch of header files
> (defined in `rust/wrapper.h`) is created as a target and as a dependency
> for any rust hardware device that needs it. You can see the generated
> bindings by running
>
>   ninja generated.rs
>
> inside your build directory.
>
> The devices are defined as dictionaries in rust/meson.build because they
> depend on the bindgen dependency, which is available much later in the
> meson process (when the static qemu lib and target emulator executables
> are defined).
>
> A cargo wrapper python script under scripts/ exists to build the crate
> library, by providing the path to the generated.rs bindings via the
> environment. Then, the qemu-system-aarch64 binary links against the
> staticlib archive (i.e. libpl011.a)
>
> The generated.rs rust file includes a bunch of junk definitions?
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [generatedrsincludesjunk] Back to [TOC]
>
> Yes, bindgen allows you to block certain types and identifiers from
> being generated but they are simply too many. I have trimmed some of the
> fat but vast improvements can be made.
>
> The staticlib artifact contains a bunch of mangled .o objects?
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [staticlibmangledobjects] Back to [TOC]
>
> Yes, until we compile without the `std` module library or we compile it
> manually instead of linking it, we will have some junk in it.

What is the consequence of this? As long as the linker is bringing in
.o files from the .a only through symbol dependencies, then unused .o
files in the .a won't be linked into the final QEMU binary.

>
> --
>
> Manos Pitsidianakis (6):
>   build-sys: Add rust feature option
>   rust: add PL011 device model
>   DO NOT MERGE: add rustdoc build for gitlab pages
>   DO NOT MERGE: replace TYPE_PL011 with x-pl011-rust in arm virt machine
>   rust: add bindgen step as a meson dependency
>   DO NOT MERGE: update rustdoc gitlab pages gen
>
>  .gitignore                     |   2 +
>  .gitlab-ci.d/buildtest.yml     |  64 ++--
>  configure                      |  12 +
>  hw/arm/virt.c                  |   2 +-
>  meson.build                    |  99 ++++++
>  meson_options.txt              |   4 +
>  rust/meson.build               |  93 ++++++
>  rust/pl011/.cargo/config.toml  |   2 +
>  rust/pl011/.gitignore          |   2 +
>  rust/pl011/Cargo.lock          | 120 +++++++
>  rust/pl011/Cargo.toml          |  26 ++
>  rust/pl011/README.md           |  42 +++
>  rust/pl011/build.rs            |  44 +++
>  rust/pl011/meson.build         |   7 +
>  rust/pl011/rustfmt.toml        |  10 +
>  rust/pl011/src/definitions.rs  |  95 ++++++
>  rust/pl011/src/device.rs       | 531 ++++++++++++++++++++++++++++++
>  rust/pl011/src/device_class.rs |  95 ++++++
>  rust/pl011/src/generated.rs    |   5 +
>  rust/pl011/src/lib.rs          | 575 +++++++++++++++++++++++++++++++++
>  rust/pl011/src/memory_ops.rs   |  38 +++
>  rust/wrapper.h                 |  39 +++
>  scripts/cargo_wrapper.py       | 221 +++++++++++++
>  scripts/meson-buildoptions.sh  |   5 +
>  24 files changed, 2113 insertions(+), 20 deletions(-)
>  create mode 100644 rust/meson.build
>  create mode 100644 rust/pl011/.cargo/config.toml
>  create mode 100644 rust/pl011/.gitignore
>  create mode 100644 rust/pl011/Cargo.lock
>  create mode 100644 rust/pl011/Cargo.toml
>  create mode 100644 rust/pl011/README.md
>  create mode 100644 rust/pl011/build.rs
>  create mode 100644 rust/pl011/meson.build
>  create mode 100644 rust/pl011/rustfmt.toml
>  create mode 100644 rust/pl011/src/definitions.rs
>  create mode 100644 rust/pl011/src/device.rs
>  create mode 100644 rust/pl011/src/device_class.rs
>  create mode 100644 rust/pl011/src/generated.rs
>  create mode 100644 rust/pl011/src/lib.rs
>  create mode 100644 rust/pl011/src/memory_ops.rs
>  create mode 100644 rust/wrapper.h
>  create mode 100644 scripts/cargo_wrapper.py
>
>
> base-commit: 01782d6b294f95bcde334386f0aaac593cd28c0d
> --
> =CE=B3=CE=B1=E1=BF=96=CE=B1 =CF=80=CF=85=CF=81=CE=AF =CE=BC=CE=B9=CF=87=
=CE=B8=CE=AE=CF=84=CF=89
>
>

