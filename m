Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEF4DCE8E97
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 17:07:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t41IT-0000YO-Gj; Thu, 24 Oct 2024 13:06:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1t41IQ-0000Xt-T1
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 13:06:50 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1t41IN-0004ZW-RS
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 13:06:50 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a99f646ff1bso148810566b.2
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2024 10:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729789606; x=1730394406; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=278LJAcTdLBIyixQe0cruXl3aFUS/nJyAF/3vU5Hq7I=;
 b=tvqOckF1XhNo9F+shP8aO+tUR1hO8KiyddmLWZMNkX75I9jPeNUIcNkGByfiMrW66K
 5uPIO9/RebjlN006v8NltAysv5H5pW2X5xw3IUyExFA88ijlRJrcdYF6oA5ypdAFFWd8
 gNpBsRqVn8omgsrN+qu38J19M83H1VoIzshIbxeOTlap8O5UM+jumPXbiEfH3ul7uQkj
 eg/DuD2RwxDiGxZRgUM+NyH4lVPA63PlqaUiTkWLx/u9p43+qIZxchqw8Y2Y/4UQXMmz
 Fyzir9H5rj0oCn8lpB7vVrNGsVu6Vm+ZyQv1MHF/NxIwuQarHn1muwRKkOWFWL8tm+e4
 +KXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729789606; x=1730394406;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=278LJAcTdLBIyixQe0cruXl3aFUS/nJyAF/3vU5Hq7I=;
 b=BnjFvKAWFpEbHvjF1o1dtwVH/Emn0UzJyywQg1W0hgC3Atwo/g0Mwf5czRnrYhDoHK
 SGPzJPxUESvSXToWG3ZhEUrZNbQszJP0KjLK4P6umKsyjmLDCeMqXGYIk3HWwVw/piFy
 IEt2o1FZRev4F+pRWLAO9nplu5xm9H5b2ZdGsg0XhtgJiCN5lbv6x2creNUnb6iUXnqb
 09DMqBa098VYFGvNwtq32DDYPMqUg95hzhJBZzyTlmQFQGzrKjKruvGVW0jEHYMFRXzi
 oWaxb3khZs0zN5mqTGjPoCYjnrt2N7f6lc5AEB5Gmm5B4jIswvQl31o7ydRJJ2A8szmE
 QIBg==
X-Gm-Message-State: AOJu0YwB3df8Ei4DtE6V9kk/R54huRRmaQDnzixMEkRMuBU8io6Nkxyz
 Q2auyojWww0XJuMZ6xUj60JjxQLduJN8mh3+DKzeQmwiQo8oiMr5zxQrLr0yV9jy4Bd+MD/9Cvg
 vyk2JaxfJHdyTi8hWBA8Z2HOW7NTPqAcpZBQ5gg==
X-Google-Smtp-Source: AGHT+IFXVCAcncvV2LbEpmQdQ9cI+txJCfM6Lu1ga09YGsN9l1wSqbrZ3UQB0sxgGyTIIEJRT7/ziw1DaUjurr72ufc=
X-Received: by 2002:a17:907:2cc2:b0:a9a:2e12:1a06 with SMTP id
 a640c23a62f3a-a9abf92d71bmr664249966b.51.1729789605824; Thu, 24 Oct 2024
 10:06:45 -0700 (PDT)
MIME-Version: 1.0
References: <20241024-rust-round-2-v1-0-051e7a25b978@linaro.org>
 <20241024-rust-round-2-v1-3-051e7a25b978@linaro.org>
 <87plnpile2.fsf@draig.linaro.org>
In-Reply-To: <87plnpile2.fsf@draig.linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Thu, 24 Oct 2024 20:06:29 +0300
Message-ID: <CAAjaMXak0ZhOFZM0=7f1CJucX7LQm7MhOLTHY+-1NhSBPjOF3g@mail.gmail.com>
Subject: Re: [PATCH 03/11] rust/qemu-api-macros: introduce Device proc macro
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Junjie Mao <junjie.mao@hotmail.com>, 
 Junjie Mao <junjie.mao@intel.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Kevin Wolf <kwolf@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x635.google.com
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

On Thu, 24 Oct 2024 at 18:14, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> Manos Pitsidianakis <manos.pitsidianakis@linaro.org> writes:
>
> > Add a new derive procedural macro to declare device models. Add
> > corresponding DeviceImpl trait after already existing ObjectImpl trait.
> > At the same time, add instance_init, instance_post_init,
> > instance_finalize methods to the ObjectImpl trait and call them from th=
e
> > ObjectImplUnsafe trait, which is generated by the procedural macro.
> >
> > This allows all the boilerplate device model registration to be handled
> > by macros, and all pertinent details to be declared through proc macro
> > attributes or trait associated constants and methods.
> >
> > The device class can now be generated automatically and the name can be
> > optionally overridden:
> >
> >   ------------------------ >8 ------------------------
> >  #[repr(C)]
> >  #[derive(Debug, qemu_api_macros::Object, qemu_api_macros::Device)]
> >  #[device(class_name_override =3D PL011Class)]
> >  /// PL011 Device Model in QEMU
> >  pub struct PL011State {
> >   ------------------------ >8 ------------------------
> >
> > Properties are now marked as field attributes:
> >
> >   ------------------------ >8 ------------------------
> >  #[property(name =3D c"chardev", qdev_prop =3D qdev_prop_chr)]
> >  pub char_backend: CharBackend,
> >   ------------------------ >8 ------------------------
> >
> > Object methods (instance_init, etc) methods are now trait methods:
> >
> >   ------------------------ >8 ------------------------
> >  /// Trait a type must implement to be registered with QEMU.
> >  pub trait ObjectImpl {
> >      type Class: ClassImpl;
> >      const TYPE_NAME: &'static CStr;
> >      const PARENT_TYPE_NAME: Option<&'static CStr>;
> >      const ABSTRACT: bool;
> >
> >      unsafe fn instance_init(&mut self) {}
> >      fn instance_post_init(&mut self) {}
> >      fn instance_finalize(&mut self) {}
> >  }
> >   ------------------------ >8 ------------------------
> >
> > Device methods (realize/reset etc) are now safe idiomatic trait methods=
:
> >
> >   ------------------------ >8 ------------------------
> >  /// Implementation methods for device types.
> >  pub trait DeviceImpl: ObjectImpl {
> >      fn realize(&mut self) {}
> >      fn reset(&mut self) {}
> >  }
> >   ------------------------ >8 ------------------------
> >
> > The derive Device macro is responsible for creating all the extern "C" =
FFI
> > functions that QEMU needs to call these methods.
> >
> > Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> > ---
> >  rust/hw/char/pl011/src/device.rs              | 124 +++-----
> >  rust/hw/char/pl011/src/device_class.rs        |  70 -----
> >  rust/hw/char/pl011/src/lib.rs                 |   1 -
> >  rust/qemu-api-macros/src/device.rs            | 433 ++++++++++++++++++=
++++++++
> >  rust/qemu-api-macros/src/lib.rs               |  45 +--
> >  rust/qemu-api-macros/src/object.rs            | 107 +++++++
> >  rust/qemu-api-macros/src/symbols.rs           |  55 ++++
> >  rust/qemu-api-macros/src/utilities.rs         | 152 +++++++++
> >  rust/qemu-api/meson.build                     |   3 +-
> >  rust/qemu-api/src/definitions.rs              |  97 ------
> >  rust/qemu-api/src/device_class.rs             | 128 --------
> >  rust/qemu-api/src/lib.rs                      |   6 +-
> >  rust/qemu-api/src/objects.rs                  |  90 ++++++
> >  rust/qemu-api/src/tests.rs                    |  49 ---
> >  subprojects/packagefiles/syn-2-rs/meson.build |   1 +
> >  15 files changed, 902 insertions(+), 459 deletions(-)
>
> My initial reaction is these patches are getting quite large because we
> are doing several things at once. Is it possible to split them so:
>
>   - we bring in one macro at a time (with unit tests)
>   - we then convert pl011 to the new idiom

Sure, I think it's possible to split them on some level. (Make changes
on the existing Object derive macro and then introduce the Device
macro) We can't unfortunately do changes without pl011 not being
updated though, since it uses the code.

As for unit tests, the only way to test proc macros is to match
generated code output to expected output. Otherwise they are
indirectly tested by the device not breaking other qemu tests. What do
you think should be our unit testing approach for this instance?

