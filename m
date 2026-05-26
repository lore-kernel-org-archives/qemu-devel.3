Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E8D2CD5BB1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 12:43:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRr7a-00085R-DW; Tue, 26 May 2026 08:42:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wRr7Q-00084k-MY
 for qemu-devel@nongnu.org; Tue, 26 May 2026 08:42:49 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wRr7O-0005il-95
 for qemu-devel@nongnu.org; Tue, 26 May 2026 08:42:48 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-43fe62837baso6172172f8f.3
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 05:42:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779799364; cv=none;
 d=google.com; s=arc-20240605;
 b=J8M1myRszzseJ3tY2cmr+B3p5ksSvt+agQCpsqrnxbrUHRL7jnqKoulgkGPp4TWR2N
 x13RhNfG3zn6DWPEanXtT5c1xDUUN1D3BzpneaetfsWxAI89ud/2xyd+OTiYspQM7pyT
 FacIZWGXZiZXSLLB3W09sfAH1A3Zrf/KMtg7/OmVSvOghI1ekEnzIb5MS39FoL3x+cLi
 QGK2xTOYa4VzUkhK0iV80DJMINFl/+Q6JRf96ZqyoJK8fDRM2rd4l3Lftj12jo7vONmV
 /+0xaMVLGXs7xhciQqgB0/BB1TaUqzgRh8RMR5vpK4I4ltVaa8WqgUrjyzVAJjn93UgJ
 nf8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=B4f6TMgkzv91D6IZ3dfq+ozw159Oyar4LWARXkrkgpE=;
 fh=B22JtR9ZUsXUrdiOg5Iw9LSBCcKra7oUC9BuSyZP/90=;
 b=cJ/s9mzc4mvlD/2qeIEh6UH8fcHOWo5W5FcmFqBFItLgw5O2DTgN2XxYTkzJizzCK3
 luO7Zh6ioZ+ji5zKhNyBX5gVZCDgtopKun0WAL9L7Ta0wn377KMjSNC98DScVFfRhenF
 dGF4oTjI+yS3X1PTDYeApXZlP5xWiqPo3EywbgzuC0JTJjNsQPRH3Q4HYqiy1YsY1n4B
 33cNSYcGWiCxmIKl7bn+IiW4V9hwO5FYVR2Gr732Edm8zXPaOwk8dkXZZxslNCF8wOOS
 CW/m8eVS+7YuyOiT/QQoRRlV87A5PyRjsPJ+eQrfu+Tb2eRBl0ZEW6Q1BMfQIq9DX3V/
 HfIA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779799364; x=1780404164; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B4f6TMgkzv91D6IZ3dfq+ozw159Oyar4LWARXkrkgpE=;
 b=dLwFtgC9n9O4VnqiEkKEbQPTFLVtSp/5ujkfbUky4npv0CQtMyL5M/QoABa66VKB1b
 BmqafYi9tBoOUty/Bf0IHWvhRYCHzy+u/iznm+shepElLhMRRMKpCPXUXdRVUrZKwfT1
 yrStTuX00wj4ih5OOm9r2oOYKpg/i5TS7M/Eec55XMJ809Qhi/bkFUDapWO9atdriNkj
 TxodcyBSwjRf0NKh4OaM5agft77il5ES1MwNzlc8pre3plK+Xuw9ohbxsQFQTIvImLCa
 nJiPiA7NxRxezVryxGUc2eBJo78qfnPk/ZzUG09buB5JEpLAUee0CK3zyEysa7bJXyx3
 dPJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779799364; x=1780404164;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=B4f6TMgkzv91D6IZ3dfq+ozw159Oyar4LWARXkrkgpE=;
 b=dQtwnbUSCdYPIB9NmRmMDdolmiZRRt0nWbKJqcXyIa5gm960FLACq/nolDoMgjVXRH
 ktHKS3NpoUXi/tM55hyEpMmKEvSXUPOanMOUrdhXIH/ebjkC9bSEqP38QqzOMSlpNBsX
 dO/QnIUsZ7EgB0aA6ngEL9JFKgVPCVFBOEfYg2sI8QqW6JCmlopUwN1TMDvk6YDISazu
 VJBcwylts+ABd7fnL9EMzMO7HYjKyi1Llk/UjBuTMgaTLVNEivkOqOqbiIpJumje82fj
 V1LXfNlunMRhfBslC5WXoOr2T3prb6lejJcu34MgR9VtogC2OSo4xVGWIw1ipgI0VQXr
 iA3A==
X-Gm-Message-State: AOJu0YzpIOOImUHn9/CtpgEZ80hlMsR0lFIHG3WYelvwfM4YMkdAn5PH
 DE9E1OQVFrPOk1UK+tRJcFEv6DCTddcUDaPxb87Xr0pL2rZN6zcnmmo1wBCabQt4+RzD5EhjDcr
 wPUouISzWlWinlnLI9kAVj7R2KQFbCClkbbJFwpKWWhel/b1UsgYL
X-Gm-Gg: Acq92OG+0OGuxwBeKx3omI+9pS8s7EZw0G7zgrXlAZtg1EvIwQ95lE0fR0pRmegdtGc
 9k67J+lMvN+l8TTilAWKPfIqlezp38ylNMzqpizZZ7XTkD++mxH+MW1nD5J4w+R0TZR3rygmwhH
 ciPXh9JXDkJDT1GHKO9GTzejCUW+eWrbJA7GMB5ryVAIDqRH40PNjmSeAlJWgD0yKu3XrYkkAm6
 Jivv4meOBO9/WsS+cYLOFNZ6zsS9UbP/bB/1aYPsZz0skdo9Nc7XjBCzfQM2CJNtwy3Dg4DZlpO
 uibIH4olZ8Wj38iXmQPymBE9WVcUp+PSzFBGDEydlAxPBP0Wkbe6MgZenk/kx/W0DM4KFJE=
X-Received: by 2002:a05:6000:25e8:b0:43c:ef4f:79e4 with SMTP id
 ffacd0b85a97d-45eb3af14fcmr31933475f8f.37.1779799364197; Tue, 26 May 2026
 05:42:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260526092546.149241-1-pbonzini@redhat.com>
 <CAAjaMXaRijkxAWDFsQy_6wA0peWeCtfrRrFYYgO=3PM6d-s5GQ@mail.gmail.com>
In-Reply-To: <CAAjaMXaRijkxAWDFsQy_6wA0peWeCtfrRrFYYgO=3PM6d-s5GQ@mail.gmail.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Tue, 26 May 2026 15:42:18 +0300
X-Gm-Features: AVHnY4KjF78kZK_E3BDGeVX0-jOSfViICNEBY8nCLmi20Wnwd6JMy9Ai1OJFm-8
Message-ID: <CAAjaMXY7QnrygSJtTGU4DEOhC-ezSeBdTz4ZYOQz54TsKQtRwQ@mail.gmail.com>
Subject: Re: [PATCH preview 0/6] rust: use meson automatic parsing of
 Cargo.toml
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x42b.google.com
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

On Tue, May 26, 2026 at 3:25=E2=80=AFPM Manos Pitsidianakis
<manos.pitsidianakis@linaro.org> wrote:
>
> On Tue, May 26, 2026 at 12:26=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.c=
om> wrote:
> >
> > These are relatively old patches, but it's time to post them now
> > that the light is visible at the end of the Meson tunnel.
> >
> > Meson 1.11.x greatly increased the ability to parse Cargo.toml
> > and automatically build complete targets out of the information in
> > there---this was more or less always the intention when Manos decided
> > to build Rust crates with Meson, but it took some time to get there.
> >
> > It still does not support cross compiling, but that should be added in
> > 1.12.0 and should be completely transparent, so it is already possible
> > to post patches for the final shape of the Meson rules.
> >
> > With this change, it is possible to have a much more compact
> > description of Rust devices in meson.build, compared to what
> > was used before:
> >
> >   _libhpet_rs =3D cargo_ws.package('hpet').library()
> >   rust_devices_ss.add(when: 'CONFIG_X_HPET_RUST', if_true: [declare_dep=
endency(
> >     link_whole: [_libhpet_rs],
> >     variables: {'crate': 'hpet'},
> >   )])
> >
> > For a description of Cargo support in Meson see
> > https://mesonbuild.com/Rust.html
> > and https://mesonbuild.com/Rust-module.html#workspace.
> >
> > Paolo
> >
> > Paolo Bonzini (6):
> >   meson: use compiler_target() to get rustc target
> >   rust: switch to cargo subprojects
> >   rust: switch to autogenerated meson rules
> >   rust: remove unnecessary wrap files
> >   rust: use meson automatic parsing of Cargo.toml
> >   scripts: remove now dead parts of rustc_args.py
>
> Missing patch to update minimum meson version check in configure (it's
> hardcoded to 1.10.0)?


pythondeps.toml points to 1.11.1 already, but if these new changes
require 1.11 then I expect building to stop working with meson 1.10
and rust enabled

>
> >
> >  configure                                     |  3 -
> >  meson.build                                   | 13 +--
> >  rust/Cargo.lock =3D> Cargo.lock                 |  0
> >  rust/Cargo.toml =3D> Cargo.toml                 |  6 +-
> >  rust/bindings/chardev-sys/meson.build         | 11 +--
> >  rust/bindings/hwcore-sys/meson.build          | 11 +--
> >  rust/bindings/migration-sys/meson.build       | 11 +--
> >  rust/bindings/qom-sys/meson.build             | 11 +--
> >  rust/bindings/system-sys/meson.build          | 11 +--
> >  rust/bindings/util-sys/meson.build            | 11 +--
> >  rust/bits/meson.build                         |  7 +-
> >  rust/bql/meson.build                          | 13 +--
> >  rust/chardev/meson.build                      |  8 +-
> >  rust/common/meson.build                       | 10 +--
> >  rust/hw/char/pl011/meson.build                | 22 +----
> >  rust/hw/core/meson.build                      | 10 +--
> >  rust/hw/timer/hpet/meson.build                | 17 +---
> >  rust/meson.build                              | 32 +-------
> >  rust/migration/meson.build                    |  8 +-
> >  rust/qemu-macros/meson.build                  | 12 +--
> >  rust/qom/meson.build                          |  8 +-
> >  rust/system/meson.build                       |  8 +-
> >  rust/trace/meson.build                        |  9 +--
> >  rust/util/meson.build                         |  7 +-
> >  scripts/qapi/rs_types.py                      |  2 +-
> >  scripts/rust/rustc_args.py                    | 80 +------------------
> >  subprojects/anyhow-1-rs.wrap                  |  7 --
> >  subprojects/arbitrary-int-1-rs.wrap           | 10 ---
> >  subprojects/attrs-0.2-rs.wrap                 |  7 --
> >  subprojects/bilge-0.2-rs.wrap                 | 10 ---
> >  subprojects/bilge-impl-0.2-rs.wrap            | 10 ---
> >  subprojects/either-1-rs.wrap                  | 10 ---
> >  subprojects/foreign-0.3-rs.wrap               |  7 --
> >  subprojects/glib-sys-0.21-rs.wrap             |  7 --
> >  subprojects/itertools-0.11-rs.wrap            | 10 ---
> >  subprojects/libc-0.2-rs.wrap                  |  7 --
> >  .../packagefiles/anyhow-1-rs/meson.build      | 33 --------
> >  .../anyhow-1-rs/meson/meson.build             |  9 +++
> >  .../arbitrary-int-1-rs/meson.build            | 21 -----
> >  .../packagefiles/attrs-0.2-rs/meson.build     | 33 --------
> >  .../packagefiles/bilge-0.2-rs/meson.build     | 31 -------
> >  .../bilge-impl-0.2-rs/meson.build             | 44 ----------
> >  .../bilge-impl-0.2-rs/meson/meson.build       |  3 +
> >  .../packagefiles/either-1-rs/meson.build      | 26 ------
> >  .../packagefiles/foreign-0.3-rs/meson.build   | 26 ------
> >  .../packagefiles/glib-sys-0.21-rs/meson.build | 33 --------
> >  .../itertools-0.11-rs/meson.build             | 32 --------
> >  .../packagefiles/libc-0.2-rs/meson.build      | 37 ---------
> >  .../libc-0.2-rs/meson/meson.build             | 16 ++++
> >  .../proc-macro-error-1-rs/meson.build         | 41 ----------
> >  .../proc-macro-error-1-rs/meson/meson.build   |  3 +
> >  .../proc-macro-error-attr-1-rs/meson.build    | 31 -------
> >  .../meson/meson.build                         |  3 +
> >  .../packagefiles/proc-macro2-1-rs/meson.build | 35 --------
> >  .../proc-macro2-1-rs/meson/meson.build        |  6 ++
> >  .../packagefiles/quote-1-rs/meson.build       | 31 -------
> >  .../packagefiles/serde-1-rs/meson.build       | 36 ---------
> >  .../packagefiles/serde_core-1-rs/meson.build  | 25 ------
> >  .../serde_core-1-rs/private.rs.in             |  6 ++
> >  .../serde_derive-1-rs/meson.build             | 35 --------
> >  subprojects/packagefiles/syn-2-rs/meson.build | 43 ----------
> >  .../unicode-ident-1-rs/meson.build            | 22 -----
> >  subprojects/probe-0.5-rs.wrap                 |  7 --
> >  subprojects/proc-macro-error-1-rs.wrap        | 10 ---
> >  subprojects/proc-macro-error-attr-1-rs.wrap   | 10 ---
> >  subprojects/proc-macro2-1-rs.wrap             | 10 ---
> >  subprojects/quote-1-rs.wrap                   | 10 ---
> >  subprojects/serde-1-rs.wrap                   |  5 +-
> >  subprojects/serde_core-1-rs.wrap              |  5 +-
> >  subprojects/serde_derive-1-rs.wrap            |  5 +-
> >  subprojects/syn-2-rs.wrap                     | 10 ---
> >  subprojects/unicode-ident-1-rs.wrap           | 10 ---
> >  72 files changed, 116 insertions(+), 1053 deletions(-)
> >  rename rust/Cargo.lock =3D> Cargo.lock (100%)
> >  rename rust/Cargo.toml =3D> Cargo.toml (97%)
> >  delete mode 100644 subprojects/anyhow-1-rs.wrap
> >  delete mode 100644 subprojects/arbitrary-int-1-rs.wrap
> >  delete mode 100644 subprojects/attrs-0.2-rs.wrap
> >  delete mode 100644 subprojects/bilge-0.2-rs.wrap
> >  delete mode 100644 subprojects/bilge-impl-0.2-rs.wrap
> >  delete mode 100644 subprojects/either-1-rs.wrap
> >  delete mode 100644 subprojects/foreign-0.3-rs.wrap
> >  delete mode 100644 subprojects/glib-sys-0.21-rs.wrap
> >  delete mode 100644 subprojects/itertools-0.11-rs.wrap
> >  delete mode 100644 subprojects/libc-0.2-rs.wrap
> >  delete mode 100644 subprojects/packagefiles/anyhow-1-rs/meson.build
> >  create mode 100644 subprojects/packagefiles/anyhow-1-rs/meson/meson.bu=
ild
> >  delete mode 100644 subprojects/packagefiles/arbitrary-int-1-rs/meson.b=
uild
> >  delete mode 100644 subprojects/packagefiles/attrs-0.2-rs/meson.build
> >  delete mode 100644 subprojects/packagefiles/bilge-0.2-rs/meson.build
> >  delete mode 100644 subprojects/packagefiles/bilge-impl-0.2-rs/meson.bu=
ild
> >  create mode 100644 subprojects/packagefiles/bilge-impl-0.2-rs/meson/me=
son.build
> >  delete mode 100644 subprojects/packagefiles/either-1-rs/meson.build
> >  delete mode 100644 subprojects/packagefiles/foreign-0.3-rs/meson.build
> >  delete mode 100644 subprojects/packagefiles/glib-sys-0.21-rs/meson.bui=
ld
> >  delete mode 100644 subprojects/packagefiles/itertools-0.11-rs/meson.bu=
ild
> >  delete mode 100644 subprojects/packagefiles/libc-0.2-rs/meson.build
> >  create mode 100644 subprojects/packagefiles/libc-0.2-rs/meson/meson.bu=
ild
> >  delete mode 100644 subprojects/packagefiles/proc-macro-error-1-rs/meso=
n.build
> >  create mode 100644 subprojects/packagefiles/proc-macro-error-1-rs/meso=
n/meson.build
> >  delete mode 100644 subprojects/packagefiles/proc-macro-error-attr-1-rs=
/meson.build
> >  create mode 100644 subprojects/packagefiles/proc-macro-error-attr-1-rs=
/meson/meson.build
> >  delete mode 100644 subprojects/packagefiles/proc-macro2-1-rs/meson.bui=
ld
> >  create mode 100644 subprojects/packagefiles/proc-macro2-1-rs/meson/mes=
on.build
> >  delete mode 100644 subprojects/packagefiles/quote-1-rs/meson.build
> >  delete mode 100644 subprojects/packagefiles/serde-1-rs/meson.build
> >  delete mode 100644 subprojects/packagefiles/serde_core-1-rs/meson.buil=
d
> >  create mode 100644 subprojects/packagefiles/serde_core-1-rs/private.rs=
.in
> >  delete mode 100644 subprojects/packagefiles/serde_derive-1-rs/meson.bu=
ild
> >  delete mode 100644 subprojects/packagefiles/syn-2-rs/meson.build
> >  delete mode 100644 subprojects/packagefiles/unicode-ident-1-rs/meson.b=
uild
> >  delete mode 100644 subprojects/probe-0.5-rs.wrap
> >  delete mode 100644 subprojects/proc-macro-error-1-rs.wrap
> >  delete mode 100644 subprojects/proc-macro-error-attr-1-rs.wrap
> >  delete mode 100644 subprojects/proc-macro2-1-rs.wrap
> >  delete mode 100644 subprojects/quote-1-rs.wrap
> >  delete mode 100644 subprojects/syn-2-rs.wrap
> >  delete mode 100644 subprojects/unicode-ident-1-rs.wrap
> >
> > --
> > 2.54.0
> >
> >

