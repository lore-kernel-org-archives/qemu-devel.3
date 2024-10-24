Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EBABCE8E8A
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 15:14:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3zXK-000346-61; Thu, 24 Oct 2024 11:14:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t3zXI-00033p-CD
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 11:14:04 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t3zXG-0006Bd-Mv
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 11:14:04 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5c937b5169cso1710966a12.1
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2024 08:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729782840; x=1730387640; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MKdowG/oXFcqkv2oR/61p1xVAKxJgpt6Y4ntRqh95Uk=;
 b=BqAdCtvLIYr95WIOdnuu/OQKVd/MNQSbe/gOT11VCnyBoXZsATZQASluduCn0nSm5V
 i8Bpq95f7NFsKAeFDwfw7vZ/EDevHCB2dIKMwR+s6X7iBYt7RCW6wpOIHNGXX0q8Lpwu
 If/WrB4S5mwWQAtg/rW9aka4vbco2KhTwtPNj92DC0mNOw2LDW35Eiuv3sQytP1MqGuk
 tTVCZdCAUZYTwXuuET9NTowspWq7Q5ZRIcLAO0ROpJCsAnRzM57KEPdOLtl74Wql5BFP
 4kjsGrqQPpSaj74+3qkMc/Bsk31Y3N6djApiGg3ef1eyozy0ZXEoMd2TENPpAe7Bw96/
 zMvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729782840; x=1730387640;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MKdowG/oXFcqkv2oR/61p1xVAKxJgpt6Y4ntRqh95Uk=;
 b=a0cFtlQmPW9+JMPocVnDGpK9lfe5sAqUI+2JlbNvkGrHemOrMnfaNzIue9Tq0YQZo/
 NQ2So5h/khsEYR/kZdV5+SxaEB9LDMj9+hAMSjirqy2n8CYKjDAK1siHn5ig8Cy5Phs2
 EY5pyj3q7DS060Vynv92VDml6yOFbo+pqPpgYC4MpKEmpO7YMxuc3LsyyxH9k+2RY3AU
 Pjjx7G8BO5R/Qe0u0Aeulyl++tkDXEJKVFSdVu8o1wN1ESRvldbwPezdIwpvpDMh0ge7
 n2JI4TFNT9IV58PgR11p7eENrgO+Mzm2CJHRjQMGkgFyNLZfY2ZjFaNeGPDsUcnaq/65
 e9Fw==
X-Gm-Message-State: AOJu0YwyIBw/LoJJSRoFkC3cbXg13i6jZCoMMUZg8Q03Dqf0rAuh7fHl
 lg2046W+D7RuEnKjYcHHlhBwDoGgiEdY3LCdRZx+5xqxbVP6mjwDGHJ6DG7+8T0=
X-Google-Smtp-Source: AGHT+IGzg5sZl3ehw9fPyu82gIps9EOdy6IJCzzsiTY7Nn0kDNw5y2jfQf1sHEfnrVsRSnK9GiVdrg==
X-Received: by 2002:a05:6402:3508:b0:5cb:881e:6d3c with SMTP id
 4fb4d7f45d1cf-5cba202d253mr2453618a12.8.1729782840465; 
 Thu, 24 Oct 2024 08:14:00 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cb66c725easm5974146a12.91.2024.10.24.08.13.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2024 08:13:59 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 86A975F856;
 Thu, 24 Oct 2024 16:13:57 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Peter
 Maydell <peter.maydell@linaro.org>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Thomas Huth
 <thuth@redhat.com>,  Junjie Mao <junjie.mao@hotmail.com>,  Junjie Mao
 <junjie.mao@intel.com>,  Zhao Liu <zhao1.liu@intel.com>,  Kevin Wolf
 <kwolf@redhat.com>,  Richard Henderson <richard.henderson@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,  Pierrick Bouvier
 <pierrick.bouvier@linaro.org>
Subject: Re: [PATCH 03/11] rust/qemu-api-macros: introduce Device proc macro
In-Reply-To: <20241024-rust-round-2-v1-3-051e7a25b978@linaro.org> (Manos
 Pitsidianakis's message of "Thu, 24 Oct 2024 17:03:01 +0300")
References: <20241024-rust-round-2-v1-0-051e7a25b978@linaro.org>
 <20241024-rust-round-2-v1-3-051e7a25b978@linaro.org>
User-Agent: mu4e 1.12.6; emacs 29.4
Date: Thu, 24 Oct 2024 16:13:57 +0100
Message-ID: <87plnpile2.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x533.google.com
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

Manos Pitsidianakis <manos.pitsidianakis@linaro.org> writes:

> Add a new derive procedural macro to declare device models. Add
> corresponding DeviceImpl trait after already existing ObjectImpl trait.
> At the same time, add instance_init, instance_post_init,
> instance_finalize methods to the ObjectImpl trait and call them from the
> ObjectImplUnsafe trait, which is generated by the procedural macro.
>
> This allows all the boilerplate device model registration to be handled
> by macros, and all pertinent details to be declared through proc macro
> attributes or trait associated constants and methods.
>
> The device class can now be generated automatically and the name can be
> optionally overridden:
>
>   ------------------------ >8 ------------------------
>  #[repr(C)]
>  #[derive(Debug, qemu_api_macros::Object, qemu_api_macros::Device)]
>  #[device(class_name_override =3D PL011Class)]
>  /// PL011 Device Model in QEMU
>  pub struct PL011State {
>   ------------------------ >8 ------------------------
>
> Properties are now marked as field attributes:
>
>   ------------------------ >8 ------------------------
>  #[property(name =3D c"chardev", qdev_prop =3D qdev_prop_chr)]
>  pub char_backend: CharBackend,
>   ------------------------ >8 ------------------------
>
> Object methods (instance_init, etc) methods are now trait methods:
>
>   ------------------------ >8 ------------------------
>  /// Trait a type must implement to be registered with QEMU.
>  pub trait ObjectImpl {
>      type Class: ClassImpl;
>      const TYPE_NAME: &'static CStr;
>      const PARENT_TYPE_NAME: Option<&'static CStr>;
>      const ABSTRACT: bool;
>
>      unsafe fn instance_init(&mut self) {}
>      fn instance_post_init(&mut self) {}
>      fn instance_finalize(&mut self) {}
>  }
>   ------------------------ >8 ------------------------
>
> Device methods (realize/reset etc) are now safe idiomatic trait methods:
>
>   ------------------------ >8 ------------------------
>  /// Implementation methods for device types.
>  pub trait DeviceImpl: ObjectImpl {
>      fn realize(&mut self) {}
>      fn reset(&mut self) {}
>  }
>   ------------------------ >8 ------------------------
>
> The derive Device macro is responsible for creating all the extern "C" FFI
> functions that QEMU needs to call these methods.
>
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>  rust/hw/char/pl011/src/device.rs              | 124 +++-----
>  rust/hw/char/pl011/src/device_class.rs        |  70 -----
>  rust/hw/char/pl011/src/lib.rs                 |   1 -
>  rust/qemu-api-macros/src/device.rs            | 433 ++++++++++++++++++++=
++++++
>  rust/qemu-api-macros/src/lib.rs               |  45 +--
>  rust/qemu-api-macros/src/object.rs            | 107 +++++++
>  rust/qemu-api-macros/src/symbols.rs           |  55 ++++
>  rust/qemu-api-macros/src/utilities.rs         | 152 +++++++++
>  rust/qemu-api/meson.build                     |   3 +-
>  rust/qemu-api/src/definitions.rs              |  97 ------
>  rust/qemu-api/src/device_class.rs             | 128 --------
>  rust/qemu-api/src/lib.rs                      |   6 +-
>  rust/qemu-api/src/objects.rs                  |  90 ++++++
>  rust/qemu-api/src/tests.rs                    |  49 ---
>  subprojects/packagefiles/syn-2-rs/meson.build |   1 +
>  15 files changed, 902 insertions(+), 459 deletions(-)

My initial reaction is these patches are getting quite large because we
are doing several things at once. Is it possible to split them so:

  - we bring in one macro at a time (with unit tests)
  - we then convert pl011 to the new idiom

?=20

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

