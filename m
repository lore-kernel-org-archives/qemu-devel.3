Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A54A8CD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 12:26:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRqrj-00009Y-1t; Tue, 26 May 2026 08:26:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wRqrW-00005M-Nu
 for qemu-devel@nongnu.org; Tue, 26 May 2026 08:26:23 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wRqrT-0004IQ-8m
 for qemu-devel@nongnu.org; Tue, 26 May 2026 08:26:21 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-44a14580111so7851570f8f.0
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 05:26:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779798377; cv=none;
 d=google.com; s=arc-20240605;
 b=NN76l4sdBCdM1U7IvyjfIQ7jKR8PFJtKO/ZW7FtCgVs1niHnajgez/QfEHHFGbzNIV
 YJof5NE6YNU9wFIIn0JotfroKNXZCwd64tcu6lDfk8dNlCat5lh1S9bPBK6TLy3ix8lO
 WVdUtEZKrmUz8WLuTRFW3MydbahjoQJV85MrJZ7YkKOj1WF05WARgUSuO+0vLLmU2efl
 N/T9fOxgYS5Uz5KkpdHgYlmp6JClOzH410QHSsEU4I7ZvjrbaRkTtWfyoIb80NOQP7mU
 Bdl1JSnNrANqsOOH8982lMMZDnmiajnuoncr21p7UWdmUfzFb/yWFt0NsrJlAfuFne4Y
 prgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=o7hWIS2WNvbrQR2SwzJeU13LJQ/PseWsZxtCae+c7Ds=;
 fh=B22JtR9ZUsXUrdiOg5Iw9LSBCcKra7oUC9BuSyZP/90=;
 b=F95Yz1RAbzJM8yxvcg8hTBC3HA4tg84l97XJCfSd/e7PpqqieHmPmWY8COD0pwW4xn
 bNwGNcDm+BqC/GbL06Sg3ZZcuT7seoepZOrClHyZRj0ta+gaMJ41YoK3PD3708/EdcwP
 fmdAieDA0wEioTlYRSNgdmSKpsZWmyMalppm0jDH4A4mNUfH4k2QYGOy2s3l8/A6SgBH
 TapjKDqmRRX8OU1VVVYIHjWnGrrai4UfrtXcLvsivvw1AvS+WKphTv7ZeHkrPPpb5Hfd
 dZPL8FbCwgkxPxz5rNZRNbkDBR6HGGidPUA2YnQxkfhxuGYqgZ095Ht/gbdS7TyVxs/P
 ybGA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779798377; x=1780403177; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o7hWIS2WNvbrQR2SwzJeU13LJQ/PseWsZxtCae+c7Ds=;
 b=Re1767AxRs1NxEgrVtMjPIeeJkZ/5ZHRucbVhQoGxBIL53+yZHNhAXFzqwMNpWSid8
 nIQGqNrTo8CKgUcALDNEOKrnSh7mPKiZT5xAYcGzMNSGpd0f4ZsXq6uOKiIy1WAnrGIO
 iR59mX5f7VlphOOr29w4WfUSYAeTUrTqq6dIC3Q0CPswu5oHB/RAajXGr1r1TQs2kXtd
 mLcMWCWvEHtHDvXxil364aZOJ7qcnZ3WdC4Y8mV69jXk3YnwN3DY3Rz8NFjvGh0aWzx3
 DdNtyYqY8DxdFqWqfACK/4nHX0IorwpRtHzCND63r/QCqYJUL3DVAtJNy1FdiFKVbIQF
 ofQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779798377; x=1780403177;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=o7hWIS2WNvbrQR2SwzJeU13LJQ/PseWsZxtCae+c7Ds=;
 b=LsYZZ41Vtj+Lft8S+lqrYhj4tQj47vurx0rrKRJghIts9ZSHF0c8Rm/4Bl6ERMdwze
 wZrNx6M3TAOQDPV8twFZkic5uiKNj9tK9cyZtN521ggw/Enejs7EkbCY4xH/ocwRKpIn
 aBitVyUtRHMYg/gv7J9T8Mfoa9ga9juvJE/FRRm/whqznSYNCJpkA1kpDz8mp4yzShSr
 rABU220ZmcWXhIF09c3G5X33N3YIwfGbxZLMGugO1YZExqCmRZQliNp//my1+eBlgMlV
 wt0zxIvGi/TSF2Yrue0aFhMBa7ly8RznAYsUO6NIesN1F2sbS1iTh1tMlckFrBGR6cE0
 /qFA==
X-Gm-Message-State: AOJu0YytWBpmWX2psbfm3HV6KeljnopRyBTQT2pkrr4coWT/qTEYRPaT
 z+0BhIXa/ahvsiTOQKs/syCn2ZioCCgaKYtKC7RoZ/CLGMxwhka1OtfybKLvqMQIL4UJ8GRpxaG
 EVVN6RUiYZMcKNZEqo3wVvRtrswLPxIluFbfRzZrJJuK1TbhA80Kf
X-Gm-Gg: Acq92OGP7s2yWl9mDTNwkC/dHaABfbu2ber4NpPT5/Z9UHE8gxVGxZWPJdI1K8mgxFD
 qNYUlHe1GPy60HO5mgbRoA3nt//JOK1MLztxOxl4ALrzGfQ/G5VuEkkUZZvQ9t84TMFbqNKw0rk
 h6kdt+5X6Zp/EqHN3OXrQK0GZBfh6tEWrer8+sT4Xm7WK6a3WXi8awFws6eZIELa1odAJdDSZas
 twzOoXGiNy3B7hZePVvrXKP9jFTDHHxn9aWL+9dGraTuA5cpWRBbtXlos5lWf+928tm6t4Ej+V9
 SH6DdPYEcuFcT9d+M1c4ZVEqiSWwcoU8nsIMKAJxim7pQNJng8bQSlrD9CL7
X-Received: by 2002:a05:6000:4b06:b0:43b:5672:efe with SMTP id
 ffacd0b85a97d-45eb3688fdcmr28010283f8f.9.1779798376662; Tue, 26 May 2026
 05:26:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260526092546.149241-1-pbonzini@redhat.com>
In-Reply-To: <20260526092546.149241-1-pbonzini@redhat.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Tue, 26 May 2026 15:25:50 +0300
X-Gm-Features: AVHnY4Keg0lSkBpc0Pt5haf7cx-YrRZmI1q0hZKqhN-VP9ayXygWwE8r8Ro_l7Y
Message-ID: <CAAjaMXaRijkxAWDFsQy_6wA0peWeCtfrRrFYYgO=3PM6d-s5GQ@mail.gmail.com>
Subject: Re: [PATCH preview 0/6] rust: use meson automatic parsing of
 Cargo.toml
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x431.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, May 26, 2026 at 12:26=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com=
> wrote:
>
> These are relatively old patches, but it's time to post them now
> that the light is visible at the end of the Meson tunnel.
>
> Meson 1.11.x greatly increased the ability to parse Cargo.toml
> and automatically build complete targets out of the information in
> there---this was more or less always the intention when Manos decided
> to build Rust crates with Meson, but it took some time to get there.
>
> It still does not support cross compiling, but that should be added in
> 1.12.0 and should be completely transparent, so it is already possible
> to post patches for the final shape of the Meson rules.
>
> With this change, it is possible to have a much more compact
> description of Rust devices in meson.build, compared to what
> was used before:
>
>   _libhpet_rs =3D cargo_ws.package('hpet').library()
>   rust_devices_ss.add(when: 'CONFIG_X_HPET_RUST', if_true: [declare_depen=
dency(
>     link_whole: [_libhpet_rs],
>     variables: {'crate': 'hpet'},
>   )])
>
> For a description of Cargo support in Meson see
> https://mesonbuild.com/Rust.html
> and https://mesonbuild.com/Rust-module.html#workspace.
>
> Paolo
>
> Paolo Bonzini (6):
>   meson: use compiler_target() to get rustc target
>   rust: switch to cargo subprojects
>   rust: switch to autogenerated meson rules
>   rust: remove unnecessary wrap files
>   rust: use meson automatic parsing of Cargo.toml
>   scripts: remove now dead parts of rustc_args.py

Missing patch to update minimum meson version check in configure (it's
hardcoded to 1.10.0)?

>
>  configure                                     |  3 -
>  meson.build                                   | 13 +--
>  rust/Cargo.lock =3D> Cargo.lock                 |  0
>  rust/Cargo.toml =3D> Cargo.toml                 |  6 +-
>  rust/bindings/chardev-sys/meson.build         | 11 +--
>  rust/bindings/hwcore-sys/meson.build          | 11 +--
>  rust/bindings/migration-sys/meson.build       | 11 +--
>  rust/bindings/qom-sys/meson.build             | 11 +--
>  rust/bindings/system-sys/meson.build          | 11 +--
>  rust/bindings/util-sys/meson.build            | 11 +--
>  rust/bits/meson.build                         |  7 +-
>  rust/bql/meson.build                          | 13 +--
>  rust/chardev/meson.build                      |  8 +-
>  rust/common/meson.build                       | 10 +--
>  rust/hw/char/pl011/meson.build                | 22 +----
>  rust/hw/core/meson.build                      | 10 +--
>  rust/hw/timer/hpet/meson.build                | 17 +---
>  rust/meson.build                              | 32 +-------
>  rust/migration/meson.build                    |  8 +-
>  rust/qemu-macros/meson.build                  | 12 +--
>  rust/qom/meson.build                          |  8 +-
>  rust/system/meson.build                       |  8 +-
>  rust/trace/meson.build                        |  9 +--
>  rust/util/meson.build                         |  7 +-
>  scripts/qapi/rs_types.py                      |  2 +-
>  scripts/rust/rustc_args.py                    | 80 +------------------
>  subprojects/anyhow-1-rs.wrap                  |  7 --
>  subprojects/arbitrary-int-1-rs.wrap           | 10 ---
>  subprojects/attrs-0.2-rs.wrap                 |  7 --
>  subprojects/bilge-0.2-rs.wrap                 | 10 ---
>  subprojects/bilge-impl-0.2-rs.wrap            | 10 ---
>  subprojects/either-1-rs.wrap                  | 10 ---
>  subprojects/foreign-0.3-rs.wrap               |  7 --
>  subprojects/glib-sys-0.21-rs.wrap             |  7 --
>  subprojects/itertools-0.11-rs.wrap            | 10 ---
>  subprojects/libc-0.2-rs.wrap                  |  7 --
>  .../packagefiles/anyhow-1-rs/meson.build      | 33 --------
>  .../anyhow-1-rs/meson/meson.build             |  9 +++
>  .../arbitrary-int-1-rs/meson.build            | 21 -----
>  .../packagefiles/attrs-0.2-rs/meson.build     | 33 --------
>  .../packagefiles/bilge-0.2-rs/meson.build     | 31 -------
>  .../bilge-impl-0.2-rs/meson.build             | 44 ----------
>  .../bilge-impl-0.2-rs/meson/meson.build       |  3 +
>  .../packagefiles/either-1-rs/meson.build      | 26 ------
>  .../packagefiles/foreign-0.3-rs/meson.build   | 26 ------
>  .../packagefiles/glib-sys-0.21-rs/meson.build | 33 --------
>  .../itertools-0.11-rs/meson.build             | 32 --------
>  .../packagefiles/libc-0.2-rs/meson.build      | 37 ---------
>  .../libc-0.2-rs/meson/meson.build             | 16 ++++
>  .../proc-macro-error-1-rs/meson.build         | 41 ----------
>  .../proc-macro-error-1-rs/meson/meson.build   |  3 +
>  .../proc-macro-error-attr-1-rs/meson.build    | 31 -------
>  .../meson/meson.build                         |  3 +
>  .../packagefiles/proc-macro2-1-rs/meson.build | 35 --------
>  .../proc-macro2-1-rs/meson/meson.build        |  6 ++
>  .../packagefiles/quote-1-rs/meson.build       | 31 -------
>  .../packagefiles/serde-1-rs/meson.build       | 36 ---------
>  .../packagefiles/serde_core-1-rs/meson.build  | 25 ------
>  .../serde_core-1-rs/private.rs.in             |  6 ++
>  .../serde_derive-1-rs/meson.build             | 35 --------
>  subprojects/packagefiles/syn-2-rs/meson.build | 43 ----------
>  .../unicode-ident-1-rs/meson.build            | 22 -----
>  subprojects/probe-0.5-rs.wrap                 |  7 --
>  subprojects/proc-macro-error-1-rs.wrap        | 10 ---
>  subprojects/proc-macro-error-attr-1-rs.wrap   | 10 ---
>  subprojects/proc-macro2-1-rs.wrap             | 10 ---
>  subprojects/quote-1-rs.wrap                   | 10 ---
>  subprojects/serde-1-rs.wrap                   |  5 +-
>  subprojects/serde_core-1-rs.wrap              |  5 +-
>  subprojects/serde_derive-1-rs.wrap            |  5 +-
>  subprojects/syn-2-rs.wrap                     | 10 ---
>  subprojects/unicode-ident-1-rs.wrap           | 10 ---
>  72 files changed, 116 insertions(+), 1053 deletions(-)
>  rename rust/Cargo.lock =3D> Cargo.lock (100%)
>  rename rust/Cargo.toml =3D> Cargo.toml (97%)
>  delete mode 100644 subprojects/anyhow-1-rs.wrap
>  delete mode 100644 subprojects/arbitrary-int-1-rs.wrap
>  delete mode 100644 subprojects/attrs-0.2-rs.wrap
>  delete mode 100644 subprojects/bilge-0.2-rs.wrap
>  delete mode 100644 subprojects/bilge-impl-0.2-rs.wrap
>  delete mode 100644 subprojects/either-1-rs.wrap
>  delete mode 100644 subprojects/foreign-0.3-rs.wrap
>  delete mode 100644 subprojects/glib-sys-0.21-rs.wrap
>  delete mode 100644 subprojects/itertools-0.11-rs.wrap
>  delete mode 100644 subprojects/libc-0.2-rs.wrap
>  delete mode 100644 subprojects/packagefiles/anyhow-1-rs/meson.build
>  create mode 100644 subprojects/packagefiles/anyhow-1-rs/meson/meson.buil=
d
>  delete mode 100644 subprojects/packagefiles/arbitrary-int-1-rs/meson.bui=
ld
>  delete mode 100644 subprojects/packagefiles/attrs-0.2-rs/meson.build
>  delete mode 100644 subprojects/packagefiles/bilge-0.2-rs/meson.build
>  delete mode 100644 subprojects/packagefiles/bilge-impl-0.2-rs/meson.buil=
d
>  create mode 100644 subprojects/packagefiles/bilge-impl-0.2-rs/meson/meso=
n.build
>  delete mode 100644 subprojects/packagefiles/either-1-rs/meson.build
>  delete mode 100644 subprojects/packagefiles/foreign-0.3-rs/meson.build
>  delete mode 100644 subprojects/packagefiles/glib-sys-0.21-rs/meson.build
>  delete mode 100644 subprojects/packagefiles/itertools-0.11-rs/meson.buil=
d
>  delete mode 100644 subprojects/packagefiles/libc-0.2-rs/meson.build
>  create mode 100644 subprojects/packagefiles/libc-0.2-rs/meson/meson.buil=
d
>  delete mode 100644 subprojects/packagefiles/proc-macro-error-1-rs/meson.=
build
>  create mode 100644 subprojects/packagefiles/proc-macro-error-1-rs/meson/=
meson.build
>  delete mode 100644 subprojects/packagefiles/proc-macro-error-attr-1-rs/m=
eson.build
>  create mode 100644 subprojects/packagefiles/proc-macro-error-attr-1-rs/m=
eson/meson.build
>  delete mode 100644 subprojects/packagefiles/proc-macro2-1-rs/meson.build
>  create mode 100644 subprojects/packagefiles/proc-macro2-1-rs/meson/meson=
.build
>  delete mode 100644 subprojects/packagefiles/quote-1-rs/meson.build
>  delete mode 100644 subprojects/packagefiles/serde-1-rs/meson.build
>  delete mode 100644 subprojects/packagefiles/serde_core-1-rs/meson.build
>  create mode 100644 subprojects/packagefiles/serde_core-1-rs/private.rs.i=
n
>  delete mode 100644 subprojects/packagefiles/serde_derive-1-rs/meson.buil=
d
>  delete mode 100644 subprojects/packagefiles/syn-2-rs/meson.build
>  delete mode 100644 subprojects/packagefiles/unicode-ident-1-rs/meson.bui=
ld
>  delete mode 100644 subprojects/probe-0.5-rs.wrap
>  delete mode 100644 subprojects/proc-macro-error-1-rs.wrap
>  delete mode 100644 subprojects/proc-macro-error-attr-1-rs.wrap
>  delete mode 100644 subprojects/proc-macro2-1-rs.wrap
>  delete mode 100644 subprojects/quote-1-rs.wrap
>  delete mode 100644 subprojects/syn-2-rs.wrap
>  delete mode 100644 subprojects/unicode-ident-1-rs.wrap
>
> --
> 2.54.0
>
>

