Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3380CD68B09
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 13:08:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBZa1-0003jj-1D; Thu, 14 Nov 2024 08:08:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tBZZj-0003b5-Vg
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 08:07:57 -0500
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tBZZf-00049R-GA
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 08:07:55 -0500
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2fb5fa911aaso9710601fa.2
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 05:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731589669; x=1732194469; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JWMRWYoKOuqB8XMnLbB/aSezhGwd0gHWTPVQDSETIqA=;
 b=YPFua7VDU7WEFVBjOc3nmNQVnIa5hjtQIR7kJ891vuXRuG+vDsQP0r1F9Fz6rRRspd
 Qo9eiJWa5MqIjdtxyxIw8ZB2DZjX0IpRqwDmf5j+ge9rfEMOkAbs41yR48y9X61Wo05f
 LPcID5Nu2JiAQ/wiwjWFQscqwXYYeDgwf/gO3cppJ9eGWZFdf/Ib0F1U1/DNsOfz6wFJ
 HOA3ma7ZmT2oS3wMRCK+awg9CMubLTVcIDQay3n1SGfQmJ1eQd4MehnzdCvrnwaU62pB
 NYksgbLSATCrttg5v6BOxPcCtQSjAgaId5BOcKbHT4lFfhrzz6FyIVKg/tb9wft2Fiap
 5Stg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731589669; x=1732194469;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JWMRWYoKOuqB8XMnLbB/aSezhGwd0gHWTPVQDSETIqA=;
 b=jOknYnlIAV2p2C8zRXeAyjL6sE8XVkvIe+s+RjQPnwh8HNbRcYqjR2cziI4tsQeVsm
 HwRGdPutCFJon+reMB/o+XGpDwUNgFKLlYMamLdRCW1xFRZmZhmgo2SdU6cSsenr1qb1
 TJUPdyHpGU5iqAYUUQR1WoqaTeUuZanPxGkEI38WstKJIIElkBocolppCDwLf58C8MWu
 9JkvAybrrs9vFZG0PW1Lrz0aBdroU+0I6I4iyQIpycFrNZ6JF5g5yBVI21ZHnVhc0oTK
 Zadj23AaTcrvRuRxfPIGujkYPQ5kH+sqtUfJp9tl67H89UZ+3SvNy/J+sCMbqWgjEMTm
 JaZw==
X-Gm-Message-State: AOJu0YwORCK1Sa/VcdnEXuf189q4iHFIQlcIt+/Z3wfbjz0kOv9tTGdl
 Es6GmUfEi4tr6dKFH449DjlfKbpzTdXg0KVmpwubMfsaXIES7J3v0ZWSkif4OaY=
X-Google-Smtp-Source: AGHT+IFOgO87CsSjvfRfNU2mOzqXJq1vlR88Qu7fL7Xs+XffnFe1mQCBoaFzU9JSVIWEGhOVEOZh2A==
X-Received: by 2002:a05:651c:b24:b0:2fb:63b5:c0bc with SMTP id
 38308e7fff4ca-2ff5900aeeamr17059191fa.3.1731589668997; 
 Thu, 14 Nov 2024 05:07:48 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa20dffba13sm61361066b.95.2024.11.14.05.07.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 05:07:47 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0F5715F867;
 Thu, 14 Nov 2024 13:07:47 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,  manos.pitsidianakis@linaro.org,
 kwolf@redhat.com,  junjie.mao@hotmail.com,  zhao1.liu@intel.com,
 qemu-rust@nondevel.org
Subject: Re: [RFC PATCH 00/11] rust: improved integration with cargo
In-Reply-To: <20241108180139.117112-1-pbonzini@redhat.com> (Paolo Bonzini's
 message of "Fri, 8 Nov 2024 19:01:28 +0100")
References: <20241108180139.117112-1-pbonzini@redhat.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Thu, 14 Nov 2024 13:07:46 +0000
Message-ID: <87plmyrmjh.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x230.google.com
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

Paolo Bonzini <pbonzini@redhat.com> writes:

> While we're not sure where we'll be going in the future, for now
> using cargo remains an important part of developing QEMU Rust code.
> This is because cargo is the easiest way to run clippy, rustfmt,
> rustdoc.  Cargo also allows working with doc tests, though there are
> pretty much none yet, and provides tools such as "cargo expand".
>
> This series aims at improving the integration with cargo and
> cargo-based tooling.
>
> First, while it is currently possible to run cargo on the rust/ directory,
> but it has the issue that the bindings.rs must be placed by hand in
> the build directory.  Therefore, this series starts by allowing
> cargo to "just work" when run in a "meson devenv" environment:
>
>     meson devenv -w ../rust cargo clippy --tests
>     meson devenv -w ../rust cargo fmt

Is this meant to be the rust source root, or the root of the rust
builddir:

$ meson devenv ../../rust

ERROR: Build data file './meson-private/build.dat' references functions or =
classes that don't exist. This probably means that it was generated with an=
 old version of meson. Try running from the source directory meson setup . =
--wipe
=F0=9F=95=9913:05:22 alex@draig:qemu.git/builds/rust  on =EE=82=A0 review/r=
ust-cargo-rfc [$!?] [=F0=9F=94=B4 ERROR]=20
$ meson devenv rust

ERROR: Build data file './meson-private/build.dat' references functions or =
classes that don't exist. This probably means that it was generated with an=
 old version of meson. Try running from the source directory meson setup . =
--wipe
=F0=9F=95=9913:05:53 alex@draig:qemu.git/builds/rust  on =EE=82=A0 review/r=
ust-cargo-rfc [$!?] [=F0=9F=94=B4 ERROR]=20

>
> If you are going to use cargo repeatedly, invoking just 'meson devenv'
> will put you in a shell where commands like 'cargo clippy' just work.
> For simplicity, I am also adding two targets 'make clippy' and 'make
> rustfmt'.
>
> Secondly, one problem with mixing Cargo and meson is having to redo the
> configuration of "lints" in both sides.  This series standardizes
> on using Cargo.toml to configure the build, and bringing the flags
> over to build.ninja with extensions to the existing rustc_args.py script.
> I admit that these additions to the script are pretty large and therefore
> I'm open to scrapping the idea.  I tried to organize the changes so that
> the changes are split over multiple patches.
>
> Finally, this series adds a CI job that runs rustfmt, clippy, and
> rustdoc, including running doctests.
>
> Please send comments!
>
> Paolo
>
> Paolo Bonzini (11):
>   rust: qemu_api: do not disable lints outside bindgen-generated code
>   rust: build: move rustc_args.py invocation to individual crates
>   rust: build: restrict --cfg generation to only required symbols
>   rust: build: generate warning flags from Cargo.toml
>   rust: cargo: store desired warning levels in workspace Cargo.toml
>   rust: build: move strict lints handling to rustc_args.py
>   rust: fix a couple style issues from clippy
>   rust: build: establish a baseline of lints across all crates
>   rust: build: add "make clippy", "make rustfmt"
>   rust: fix doc test syntax
>   rust: ci: add job that runs Rust tools
>
>  meson.build                                   |  56 +++---
>  .gitlab-ci.d/buildtest-template.yml           |  14 ++
>  .gitlab-ci.d/buildtest.yml                    |  14 ++
>  rust/Cargo.toml                               |  80 ++++++++
>  rust/hw/char/pl011/Cargo.toml                 |   3 +
>  rust/hw/char/pl011/src/device.rs              |   6 +-
>  rust/hw/char/pl011/src/lib.rs                 |  18 +-
>  rust/hw/char/pl011/src/memory_ops.rs          |   4 +-
>  rust/meson.build                              |  14 ++
>  rust/qemu-api-macros/Cargo.toml               |   3 +
>  rust/qemu-api/.gitignore                      |   2 +-
>  rust/qemu-api/Cargo.toml                      |   5 +-
>  rust/qemu-api/build.rs                        |  24 ++-
>  rust/qemu-api/meson.build                     |   5 +
>  rust/qemu-api/src/bindings.rs                 |  29 +++
>  rust/qemu-api/src/lib.rs                      |  22 ---
>  rust/qemu-api/src/zeroable.rs                 |   6 +-
>  rust/qemu-api/tests/tests.rs                  |   2 +-
>  scripts/rust/rustc_args.py                    | 178 ++++++++++++++++--
>  .../dockerfiles/fedora-rust-nightly.docker    |   4 +
>  tests/lcitool/refresh                         |   4 +
>  21 files changed, 391 insertions(+), 102 deletions(-)
>  create mode 100644 rust/qemu-api/src/bindings.rs

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

