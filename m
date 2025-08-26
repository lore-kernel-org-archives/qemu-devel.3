Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77E2DCA0EFA
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 14:56:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqv3k-0005iE-Np; Tue, 26 Aug 2025 10:54:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uqv3i-0005hL-Vr
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 10:54:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uqv3d-0008TR-ET
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 10:54:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756220029;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Nps4IlED43xWxmuWOmflLnTm3tCGmWtdt9Sg7sShXQg=;
 b=KXOOZ3j5qeoNWU3Dly2i2V1wxEqGf9Dk2J7WHGPaH7xOBR0Oga2LbuWLsRK9ZMsg8SAO2N
 lhbiw1F/fbEwMk0MLuLoLPlONT2K0FDBsOOS90AmR/Mp8aJwgpeABLrx8mzhVQLksmXGl5
 2lFl2Vx+ruyQ7cCgfwN5vZpfUkkTSp0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-Z1FxR407MkWSIPUYPcAW4w-1; Tue, 26 Aug 2025 10:53:47 -0400
X-MC-Unique: Z1FxR407MkWSIPUYPcAW4w-1
X-Mimecast-MFC-AGG-ID: Z1FxR407MkWSIPUYPcAW4w_1756220026
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3c6abcfd218so2533352f8f.3
 for <qemu-devel@nongnu.org>; Tue, 26 Aug 2025 07:53:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756220026; x=1756824826;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Nps4IlED43xWxmuWOmflLnTm3tCGmWtdt9Sg7sShXQg=;
 b=sk0T8KirVU6vjbZB+kwlZUuDBzZZen8B6jSD3U6lVE+a65zPzfXsm4WIumoebb5uAV
 cmFneBfrjrTBO9OeaPTtzVtNxYn5MFb8CG2x9QcdnL76+rIXlFssx8V0SOZIf4CdMOQH
 K6Gug5kWLLNdi5m4HwWUlSp0YXBF0Kfq7NsWeCf+5e9VzhWCblqedOzmy0FDrJAb+LW1
 MQkiiXcNyvI/JhU6/CaT4FDzd4nCeMWOhd4DXptd/sT6+kEGX63msn5r45G6MlF3iTf6
 FpUoO4/nFHoQ05eOHhAer9/YONSADHGyGXTB6Sr2Jxea2722ZHevQcHBwvOJzigN+3Cw
 5GMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXil34Sf/0FAr9gopMLMhZ0whykkfYpBYSlzu3+SyFV2151HWGAfRKuYV0P0yp43w+NmCjjMSKQ5IY/@nongnu.org
X-Gm-Message-State: AOJu0Yy6oZSaVYpOTZdkkdx35kPx6/JsEetXoROBaYd/s9uJKwd4va2p
 8NpU80NyHDMdA9ezhOJ6tFAn5m3UeXVcZqynTgwoFrjn5P0wVOIRD5lS2RMXax5aiQ4+U9T7evG
 oty2ET99hn3ifDgGQmg77KxzwqtkoxYmtM6TVvPPVMIzsw8SqsOQFFP2w
X-Gm-Gg: ASbGncvrMzNy0UU+OEd9ElhQt+7A1xuOFUIjB8omCY6CynNGBCTK74J7KwCpT1ezl6W
 jORvrrkQsuSprfwDv5wyVktEgvlo4YibLoKkWZ34QMeeSh+1AfdEM9lflz9WFlM2eM3c1N3jJyi
 +4cLkvE/IfTcSrSgYkau+VwUor7imSbRs6aXCkyXZ3NB70ONVVSXNnDwWpyZ+VUGXlhMMOmceQ8
 ltz7U+czNmkEd75WeXe0XBiyMjrvgZKbjO1SNd/6LO4LkdYEz3kSmfHzqd8seo9Kqj6PW+YqBMr
 1EPVAYLI6Rd/LcOYJpDPM6jnqoYlWwTAmpDzs2zy3Uksp7unIQkm6cX5510uQc5wLC4Iq3y0Db7
 NyEl914PSxxOTur5NRlkJVCAl
X-Received: by 2002:adf:f58f:0:b0:3cb:fbc9:2679 with SMTP id
 ffacd0b85a97d-3cbfbc92a08mr813559f8f.32.1756220025810; 
 Tue, 26 Aug 2025 07:53:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF57+nMEdFZZUjThL+JylZTel9fjzjejJQygyKIMVEahq9Gje9YsIdopofsDeHKquPsRir+Jw==
X-Received: by 2002:adf:f58f:0:b0:3cb:fbc9:2679 with SMTP id
 ffacd0b85a97d-3cbfbc92a08mr813533f8f.32.1756220025142; 
 Tue, 26 Aug 2025 07:53:45 -0700 (PDT)
Received: from [192.168.178.61] ([151.36.40.144])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-45b5f28da75sm93051425e9.24.2025.08.26.07.53.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Aug 2025 07:53:44 -0700 (PDT)
Message-ID: <d65f6de8-744a-4c85-a85b-695bb3893868@redhat.com>
Date: Tue, 26 Aug 2025 16:53:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 14/18] rust: rename qemu_api_macros -> qemu_macros
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-rust@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20250826140449.4190022-1-marcandre.lureau@redhat.com>
 <20250826140449.4190022-15-marcandre.lureau@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20250826140449.4190022-15-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 8/26/25 16:04, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Since "qemu_api" is no longer the unique crate to provide APIs.

In addition to renaming, maybe you can re-export the macros from the 
appropriate crate?

derive(Object) -> qom
derive(Wrapper) -> common
derive(TryInto) -> common
derive(Device) -> hwcore

That is, keep a single qemu_api_macros crate for the implementation but 
allow using the nicer #[derive(qom::Object)].

Paolo

> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   MAINTAINERS                                   |  2 +-
>   rust/Cargo.lock                               | 22 +++++++++----------
>   rust/Cargo.toml                               |  2 +-
>   rust/bits/Cargo.toml                          |  2 +-
>   rust/bits/meson.build                         |  2 +-
>   rust/bits/src/lib.rs                          |  4 ++--
>   rust/chardev/Cargo.toml                       |  2 +-
>   rust/chardev/meson.build                      |  4 ++--
>   rust/chardev/src/chardev.rs                   |  2 +-
>   rust/common/src/opaque.rs                     |  4 ++--
>   rust/hw/char/pl011/Cargo.toml                 |  2 +-
>   rust/hw/char/pl011/meson.build                |  4 ++--
>   rust/hw/char/pl011/src/device.rs              |  4 ++--
>   rust/hw/char/pl011/src/registers.rs           |  2 +-
>   rust/hw/core/Cargo.toml                       |  2 +-
>   rust/hw/core/meson.build                      |  4 ++--
>   rust/hw/core/src/irq.rs                       |  2 +-
>   rust/hw/core/src/qdev.rs                      |  4 ++--
>   rust/hw/core/src/sysbus.rs                    |  2 +-
>   rust/hw/core/tests/tests.rs                   |  4 ++--
>   rust/hw/timer/hpet/Cargo.toml                 |  2 +-
>   rust/hw/timer/hpet/meson.build                |  4 ++--
>   rust/hw/timer/hpet/src/device.rs              |  6 ++---
>   rust/meson.build                              |  2 +-
>   rust/migration/Cargo.toml                     |  2 +-
>   rust/qemu-api/Cargo.toml                      |  2 +-
>   rust/qemu-api/meson.build                     |  4 ++--
>   .../Cargo.toml                                |  2 +-
>   .../meson.build                               | 10 ++++-----
>   .../src/bits.rs                               |  0
>   .../src/lib.rs                                |  0
>   .../src/tests.rs                              |  0
>   rust/qom/Cargo.toml                           |  2 +-
>   rust/qom/meson.build                          |  4 ++--
>   rust/qom/src/qom.rs                           |  4 ++--
>   rust/qom/tests/tests.rs                       |  2 +-
>   rust/system/Cargo.toml                        |  2 +-
>   rust/system/meson.build                       |  4 ++--
>   rust/system/src/memory.rs                     |  2 +-
>   rust/util/Cargo.toml                          |  2 +-
>   rust/util/meson.build                         |  2 +-
>   rust/util/src/timer.rs                        |  4 ++--
>   42 files changed, 69 insertions(+), 69 deletions(-)
>   rename rust/{qemu-api-macros => qemu-macros}/Cargo.toml (94%)
>   rename rust/{qemu-api-macros => qemu-macros}/meson.build (63%)
>   rename rust/{qemu-api-macros => qemu-macros}/src/bits.rs (100%)
>   rename rust/{qemu-api-macros => qemu-macros}/src/lib.rs (100%)
>   rename rust/{qemu-api-macros => qemu-macros}/src/tests.rs (100%)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3f40a80240..62790c7b5d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3516,7 +3516,7 @@ F: rust/common/
>   F: rust/hw/core/
>   F: rust/migration/
>   F: rust/qemu-api
> -F: rust/qemu-api-macros
> +F: rust/qemu-macros/
>   F: rust/qom/
>   F: rust/rustfmt.toml
>   F: rust/system/
> diff --git a/rust/Cargo.lock b/rust/Cargo.lock
> index 7ed22ca687..9bb2ab5bf6 100644
> --- a/rust/Cargo.lock
> +++ b/rust/Cargo.lock
> @@ -41,7 +41,7 @@ dependencies = [
>   name = "bits"
>   version = "0.1.0"
>   dependencies = [
> - "qemu_api_macros",
> + "qemu_macros",
>   ]
>   
>   [[package]]
> @@ -58,7 +58,7 @@ dependencies = [
>    "bql",
>    "common",
>    "migration",
> - "qemu_api_macros",
> + "qemu_macros",
>    "qom",
>    "util",
>   ]
> @@ -91,7 +91,7 @@ dependencies = [
>    "hwcore",
>    "migration",
>    "qemu_api",
> - "qemu_api_macros",
> + "qemu_macros",
>    "qom",
>    "system",
>    "util",
> @@ -105,7 +105,7 @@ dependencies = [
>    "chardev",
>    "common",
>    "migration",
> - "qemu_api_macros",
> + "qemu_macros",
>    "qom",
>    "system",
>    "util",
> @@ -131,7 +131,7 @@ name = "migration"
>   version = "0.1.0"
>   dependencies = [
>    "common",
> - "qemu_api_macros",
> + "qemu_macros",
>    "util",
>   ]
>   
> @@ -148,7 +148,7 @@ dependencies = [
>    "hwcore",
>    "migration",
>    "qemu_api",
> - "qemu_api_macros",
> + "qemu_macros",
>    "qom",
>    "system",
>    "util",
> @@ -198,14 +198,14 @@ dependencies = [
>    "hwcore",
>    "libc",
>    "migration",
> - "qemu_api_macros",
> + "qemu_macros",
>    "qom",
>    "system",
>    "util",
>   ]
>   
>   [[package]]
> -name = "qemu_api_macros"
> +name = "qemu_macros"
>   version = "0.1.0"
>   dependencies = [
>    "proc-macro2",
> @@ -220,7 +220,7 @@ dependencies = [
>    "bql",
>    "common",
>    "migration",
> - "qemu_api_macros",
> + "qemu_macros",
>    "util",
>   ]
>   
> @@ -249,7 +249,7 @@ name = "system"
>   version = "0.1.0"
>   dependencies = [
>    "common",
> - "qemu_api_macros",
> + "qemu_macros",
>    "qom",
>    "util",
>   ]
> @@ -268,7 +268,7 @@ dependencies = [
>    "common",
>    "foreign",
>    "libc",
> - "qemu_api_macros",
> + "qemu_macros",
>   ]
>   
>   [[package]]
> diff --git a/rust/Cargo.toml b/rust/Cargo.toml
> index ca94d2cf40..1acee9e7cb 100644
> --- a/rust/Cargo.toml
> +++ b/rust/Cargo.toml
> @@ -5,7 +5,7 @@ members = [
>       "bql",
>       "common",
>       "migration",
> -    "qemu-api-macros",
> +    "qemu-macros",
>       "qemu-api",
>       "qom",
>       "system",
> diff --git a/rust/bits/Cargo.toml b/rust/bits/Cargo.toml
> index 1ff38a4117..7fce972b27 100644
> --- a/rust/bits/Cargo.toml
> +++ b/rust/bits/Cargo.toml
> @@ -13,7 +13,7 @@ repository.workspace = true
>   rust-version.workspace = true
>   
>   [dependencies]
> -qemu_api_macros = { path = "../qemu-api-macros" }
> +qemu_macros = { path = "../qemu-macros" }
>   
>   [lints]
>   workspace = true
> diff --git a/rust/bits/meson.build b/rust/bits/meson.build
> index 2a41e138c5..359ca86f15 100644
> --- a/rust/bits/meson.build
> +++ b/rust/bits/meson.build
> @@ -3,7 +3,7 @@ _bits_rs = static_library(
>     'src/lib.rs',
>     override_options: ['rust_std=2021', 'build.rust_std=2021'],
>     rust_abi: 'rust',
> -  dependencies: [qemu_api_macros],
> +  dependencies: [qemu_macros],
>   )
>   
>   bits_rs = declare_dependency(link_with: _bits_rs)
> diff --git a/rust/bits/src/lib.rs b/rust/bits/src/lib.rs
> index d485d6bd11..4e091aebbd 100644
> --- a/rust/bits/src/lib.rs
> +++ b/rust/bits/src/lib.rs
> @@ -380,11 +380,11 @@ fn from(x: $type) -> Self {
>       };
>   
>       { $type:ty: $expr:expr } => {
> -        ::qemu_api_macros::bits_const_internal! { $type @ ($expr) }
> +        ::qemu_macros::bits_const_internal! { $type @ ($expr) }
>       };
>   
>       { $type:ty as $int_type:ty: $expr:expr } => {
> -        (::qemu_api_macros::bits_const_internal! { $type @ ($expr) }.into_bits()) as $int_type
> +        (::qemu_macros::bits_const_internal! { $type @ ($expr) }.into_bits()) as $int_type
>       };
>   }
>   
> diff --git a/rust/chardev/Cargo.toml b/rust/chardev/Cargo.toml
> index 7df9c677fc..c139177307 100644
> --- a/rust/chardev/Cargo.toml
> +++ b/rust/chardev/Cargo.toml
> @@ -18,7 +18,7 @@ bql = { path = "../bql" }
>   migration = { path = "../migration" }
>   qom = { path = "../qom" }
>   util = { path = "../util" }
> -qemu_api_macros = { path = "../qemu-api-macros" }
> +qemu_macros = { path = "../qemu-macros" }
>   
>   [lints]
>   workspace = true
> diff --git a/rust/chardev/meson.build b/rust/chardev/meson.build
> index 918e0a5224..487f36e27d 100644
> --- a/rust/chardev/meson.build
> +++ b/rust/chardev/meson.build
> @@ -39,10 +39,10 @@ _chardev_rs = static_library(
>     override_options: ['rust_std=2021', 'build.rust_std=2021'],
>     rust_abi: 'rust',
>     rust_args: _chardev_cfg,
> -  dependencies: [qemuutil_rs, common_rs, bql_rs, migration_rs, qemu_api_macros, qom_rs, util_rs, chardev],
> +  dependencies: [qemuutil_rs, common_rs, bql_rs, migration_rs, qemu_macros, qom_rs, util_rs, chardev],
>   )
>   
> -chardev_rs = declare_dependency(link_with: [_chardev_rs], dependencies: [qemu_api_macros, chardev])
> +chardev_rs = declare_dependency(link_with: [_chardev_rs], dependencies: [qemu_macros, chardev])
>   
>   # Doctests are essentially integration tests, so they need the same dependencies.
>   # Note that running them requires the object files for C code, so place them
> diff --git a/rust/chardev/src/chardev.rs b/rust/chardev/src/chardev.rs
> index 1a6795a938..fe90126b84 100644
> --- a/rust/chardev/src/chardev.rs
> +++ b/rust/chardev/src/chardev.rs
> @@ -26,7 +26,7 @@
>   
>   /// A safe wrapper around [`bindings::Chardev`].
>   #[repr(transparent)]
> -#[derive(qemu_api_macros::Wrapper)]
> +#[derive(qemu_macros::Wrapper)]
>   pub struct Chardev(Opaque<bindings::Chardev>);
>   
>   pub type ChardevClass = bindings::ChardevClass;
> diff --git a/rust/common/src/opaque.rs b/rust/common/src/opaque.rs
> index e076964634..06f6b8cd29 100644
> --- a/rust/common/src/opaque.rs
> +++ b/rust/common/src/opaque.rs
> @@ -194,7 +194,7 @@ pub unsafe fn new() -> Self {
>   
>   /// Annotates [`Self`] as a transparent wrapper for another type.
>   ///
> -/// Usually defined via the [`qemu_api_macros::Wrapper`] derive macro.
> +/// Usually defined via the [`qemu_macros::Wrapper`] derive macro.
>   ///
>   /// # Examples
>   ///
> @@ -230,7 +230,7 @@ pub unsafe fn new() -> Self {
>   ///
>   /// They are not defined here to allow them to be `const`.
>   ///
> -/// [`qemu_api_macros::Wrapper`]: ../../qemu_api_macros/derive.Wrapper.html
> +/// [`qemu_macros::Wrapper`]: ../../qemu_macros/derive.Wrapper.html
>   pub unsafe trait Wrapper {
>       type Wrapped;
>   }
> diff --git a/rust/hw/char/pl011/Cargo.toml b/rust/hw/char/pl011/Cargo.toml
> index 830d88586b..9e451fc0aa 100644
> --- a/rust/hw/char/pl011/Cargo.toml
> +++ b/rust/hw/char/pl011/Cargo.toml
> @@ -25,7 +25,7 @@ chardev = { path = "../../../chardev" }
>   system = { path = "../../../system" }
>   hwcore = { path = "../../../hw/core" }
>   qemu_api = { path = "../../../qemu-api" }
> -qemu_api_macros = { path = "../../../qemu-api-macros" }
> +qemu_macros = { path = "../../../qemu-macros" }
>   
>   [lints]
>   workspace = true
> diff --git a/rust/hw/char/pl011/meson.build b/rust/hw/char/pl011/meson.build
> index 83030476de..7d90f2aad6 100644
> --- a/rust/hw/char/pl011/meson.build
> +++ b/rust/hw/char/pl011/meson.build
> @@ -12,7 +12,7 @@ _libpl011_rs = static_library(
>       migration_rs,
>       bql_rs,
>       qemu_api,
> -    qemu_api_macros,
> +    qemu_macros,
>       qom_rs,
>       chardev_rs,
>       system_rs,
> @@ -24,6 +24,6 @@ rust_devices_ss.add(when: 'CONFIG_X_PL011_RUST', if_true: [declare_dependency(
>     link_whole: [_libpl011_rs],
>     # Putting proc macro crates in `dependencies` is necessary for Meson to find
>     # them when compiling the root per-target static rust lib.
> -  dependencies: [bilge_impl_rs, qemu_api_macros],
> +  dependencies: [bilge_impl_rs, qemu_macros],
>     variables: {'crate': 'pl011'},
>   )])
> diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
> index e0d89db28d..caaa05c04c 100644
> --- a/rust/hw/char/pl011/src/device.rs
> +++ b/rust/hw/char/pl011/src/device.rs
> @@ -106,7 +106,7 @@ pub struct PL011Registers {
>   }
>   
>   #[repr(C)]
> -#[derive(qemu_api_macros::Object)]
> +#[derive(qemu_macros::Object)]
>   /// PL011 Device Model in QEMU
>   pub struct PL011State {
>       pub parent_obj: ParentField<SysBusDevice>,
> @@ -691,7 +691,7 @@ pub fn post_load(&self, _version_id: u32) -> Result<(), ()> {
>   }
>   
>   #[repr(C)]
> -#[derive(qemu_api_macros::Object)]
> +#[derive(qemu_macros::Object)]
>   /// PL011 Luminary device model.
>   pub struct PL011Luminary {
>       parent_obj: ParentField<PL011State>,
> diff --git a/rust/hw/char/pl011/src/registers.rs b/rust/hw/char/pl011/src/registers.rs
> index 2bfbd81095..a1c41347ed 100644
> --- a/rust/hw/char/pl011/src/registers.rs
> +++ b/rust/hw/char/pl011/src/registers.rs
> @@ -16,7 +16,7 @@
>   #[doc(alias = "offset")]
>   #[allow(non_camel_case_types)]
>   #[repr(u64)]
> -#[derive(Debug, Eq, PartialEq, qemu_api_macros::TryInto)]
> +#[derive(Debug, Eq, PartialEq, qemu_macros::TryInto)]
>   pub enum RegisterOffset {
>       /// Data Register
>       ///
> diff --git a/rust/hw/core/Cargo.toml b/rust/hw/core/Cargo.toml
> index 0b35380264..0eb9ffee26 100644
> --- a/rust/hw/core/Cargo.toml
> +++ b/rust/hw/core/Cargo.toml
> @@ -20,7 +20,7 @@ chardev = { path = "../../chardev" }
>   migration = { path = "../../migration" }
>   system = { path = "../../system" }
>   util = { path = "../../util" }
> -qemu_api_macros = { path = "../../qemu-api-macros" }
> +qemu_macros = { path = "../../qemu-macros" }
>   
>   [lints]
>   workspace = true
> diff --git a/rust/hw/core/meson.build b/rust/hw/core/meson.build
> index d390f2d665..692c4b8e0f 100644
> --- a/rust/hw/core/meson.build
> +++ b/rust/hw/core/meson.build
> @@ -62,7 +62,7 @@ _hwcore_rs = static_library(
>     override_options: ['rust_std=2021', 'build.rust_std=2021'],
>     rust_abi: 'rust',
>     rust_args: _hwcore_cfg,
> -  dependencies: [qemu_api_macros, common_rs, bql_rs, chardev_rs, migration_rs, qemuutil_rs, qom_rs, system_rs, util_rs,
> +  dependencies: [qemu_macros, common_rs, bql_rs, chardev_rs, migration_rs, qemuutil_rs, qom_rs, system_rs, util_rs,
>                    qom, hwcore, chardev, migration],
>   )
>   
> @@ -85,7 +85,7 @@ test('rust-hwcore-rs-integration',
>           override_options: ['rust_std=2021', 'build.rust_std=2021'],
>           rust_args: ['--test'],
>           install: false,
> -        dependencies: [common_rs, hwcore_rs, bql_rs, migration_rs, qemu_api_macros, util_rs]),
> +        dependencies: [common_rs, hwcore_rs, bql_rs, migration_rs, qemu_macros, util_rs]),
>       args: [
>           '--test', '--test-threads', '1',
>           '--format', 'pretty',
> diff --git a/rust/hw/core/src/irq.rs b/rust/hw/core/src/irq.rs
> index 5a380923fe..828e6cb28f 100644
> --- a/rust/hw/core/src/irq.rs
> +++ b/rust/hw/core/src/irq.rs
> @@ -18,7 +18,7 @@
>   
>   /// An opaque wrapper around [`bindings::IRQState`].
>   #[repr(transparent)]
> -#[derive(Debug, qemu_api_macros::Wrapper)]
> +#[derive(Debug, qemu_macros::Wrapper)]
>   pub struct IRQState(Opaque<bindings::IRQState>);
>   
>   /// Interrupt sources are used by devices to pass changes to a value (typically
> diff --git a/rust/hw/core/src/qdev.rs b/rust/hw/core/src/qdev.rs
> index 16a4769758..62f518a11a 100644
> --- a/rust/hw/core/src/qdev.rs
> +++ b/rust/hw/core/src/qdev.rs
> @@ -26,7 +26,7 @@
>   
>   /// A safe wrapper around [`bindings::Clock`].
>   #[repr(transparent)]
> -#[derive(Debug, qemu_api_macros::Wrapper)]
> +#[derive(Debug, qemu_macros::Wrapper)]
>   pub struct Clock(Opaque<bindings::Clock>);
>   
>   unsafe impl Send for Clock {}
> @@ -34,7 +34,7 @@ unsafe impl Sync for Clock {}
>   
>   /// A safe wrapper around [`bindings::DeviceState`].
>   #[repr(transparent)]
> -#[derive(Debug, qemu_api_macros::Wrapper)]
> +#[derive(Debug, qemu_macros::Wrapper)]
>   pub struct DeviceState(Opaque<bindings::DeviceState>);
>   
>   unsafe impl Send for DeviceState {}
> diff --git a/rust/hw/core/src/sysbus.rs b/rust/hw/core/src/sysbus.rs
> index 66b618c705..51631cd237 100644
> --- a/rust/hw/core/src/sysbus.rs
> +++ b/rust/hw/core/src/sysbus.rs
> @@ -19,7 +19,7 @@
>   
>   /// A safe wrapper around [`bindings::SysBusDevice`].
>   #[repr(transparent)]
> -#[derive(Debug, qemu_api_macros::Wrapper)]
> +#[derive(Debug, qemu_macros::Wrapper)]
>   pub struct SysBusDevice(Opaque<bindings::SysBusDevice>);
>   
>   unsafe impl Send for SysBusDevice {}
> diff --git a/rust/hw/core/tests/tests.rs b/rust/hw/core/tests/tests.rs
> index f11c15ac62..2898844baf 100644
> --- a/rust/hw/core/tests/tests.rs
> +++ b/rust/hw/core/tests/tests.rs
> @@ -25,7 +25,7 @@
>   };
>   
>   #[repr(C)]
> -#[derive(qemu_api_macros::Object)]
> +#[derive(qemu_macros::Object)]
>   pub struct DummyState {
>       parent: ParentField<DeviceState>,
>       migrate_clock: bool,
> @@ -77,7 +77,7 @@ fn vmsd() -> Option<&'static VMStateDescription> {
>   }
>   
>   #[repr(C)]
> -#[derive(qemu_api_macros::Object)]
> +#[derive(qemu_macros::Object)]
>   pub struct DummyChildState {
>       parent: ParentField<DummyState>,
>   }
> diff --git a/rust/hw/timer/hpet/Cargo.toml b/rust/hw/timer/hpet/Cargo.toml
> index e28d66f645..68e8187bb8 100644
> --- a/rust/hw/timer/hpet/Cargo.toml
> +++ b/rust/hw/timer/hpet/Cargo.toml
> @@ -18,7 +18,7 @@ bql = { path = "../../../bql" }
>   qom = { path = "../../../qom" }
>   system = { path = "../../../system" }
>   qemu_api = { path = "../../../qemu-api" }
> -qemu_api_macros = { path = "../../../qemu-api-macros" }
> +qemu_macros = { path = "../../../qemu-macros" }
>   hwcore = { path = "../../../hw/core" }
>   
>   [lints]
> diff --git a/rust/hw/timer/hpet/meson.build b/rust/hw/timer/hpet/meson.build
> index d65306c169..b2eee01faf 100644
> --- a/rust/hw/timer/hpet/meson.build
> +++ b/rust/hw/timer/hpet/meson.build
> @@ -9,7 +9,7 @@ _libhpet_rs = static_library(
>       migration_rs,
>       bql_rs,
>       qemu_api,
> -    qemu_api_macros,
> +    qemu_macros,
>       qom_rs,
>       system_rs,
>       hwcore_rs,
> @@ -20,6 +20,6 @@ rust_devices_ss.add(when: 'CONFIG_X_HPET_RUST', if_true: [declare_dependency(
>     link_whole: [_libhpet_rs],
>     # Putting proc macro crates in `dependencies` is necessary for Meson to find
>     # them when compiling the root per-target static rust lib.
> -  dependencies: [qemu_api_macros],
> +  dependencies: [qemu_macros],
>     variables: {'crate': 'hpet'},
>   )])
> diff --git a/rust/hw/timer/hpet/src/device.rs b/rust/hw/timer/hpet/src/device.rs
> index 2ea101bb7f..b883d56a9a 100644
> --- a/rust/hw/timer/hpet/src/device.rs
> +++ b/rust/hw/timer/hpet/src/device.rs
> @@ -97,7 +97,7 @@
>   /// Timer N Interrupt Routing Capability (bits 32:63)
>   const HPET_TN_CFG_INT_ROUTE_CAP_SHIFT: usize = 32;
>   
> -#[derive(qemu_api_macros::TryInto)]
> +#[derive(qemu_macros::TryInto)]
>   #[repr(u64)]
>   #[allow(non_camel_case_types)]
>   /// Timer registers, masked by 0x18
> @@ -110,7 +110,7 @@ enum TimerRegister {
>       ROUTE = 16,
>   }
>   
> -#[derive(qemu_api_macros::TryInto)]
> +#[derive(qemu_macros::TryInto)]
>   #[repr(u64)]
>   #[allow(non_camel_case_types)]
>   /// Global registers
> @@ -516,7 +516,7 @@ fn write(&mut self, reg: TimerRegister, value: u64, shift: u32, len: u32) {
>   
>   /// HPET Event Timer Block Abstraction
>   #[repr(C)]
> -#[derive(qemu_api_macros::Object)]
> +#[derive(qemu_macros::Object)]
>   pub struct HPETState {
>       parent_obj: ParentField<SysBusDevice>,
>       iomem: MemoryRegion,
> diff --git a/rust/meson.build b/rust/meson.build
> index 041b0a473e..9f6a0b161d 100644
> --- a/rust/meson.build
> +++ b/rust/meson.build
> @@ -23,7 +23,7 @@ qemuutil_rs = qemuutil.partial_dependency(link_args: true, links: true)
>   genrs = []
>   
>   subdir('common')
> -subdir('qemu-api-macros')
> +subdir('qemu-macros')
>   subdir('bits')
>   subdir('util')
>   subdir('migration')
> diff --git a/rust/migration/Cargo.toml b/rust/migration/Cargo.toml
> index 98e6df2109..66af81e0a3 100644
> --- a/rust/migration/Cargo.toml
> +++ b/rust/migration/Cargo.toml
> @@ -15,7 +15,7 @@ rust-version.workspace = true
>   [dependencies]
>   common = { path = "../common" }
>   util = { path = "../util" }
> -qemu_api_macros = { path = "../qemu-api-macros" }
> +qemu_macros = { path = "../qemu-macros" }
>   
>   [lints]
>   workspace = true
> diff --git a/rust/qemu-api/Cargo.toml b/rust/qemu-api/Cargo.toml
> index 9f216e45a6..b6744f0286 100644
> --- a/rust/qemu-api/Cargo.toml
> +++ b/rust/qemu-api/Cargo.toml
> @@ -20,7 +20,7 @@ hwcore = { path = "../hw/core" }
>   migration = { path = "../migration" }
>   util = { path = "../util" }
>   bql = { path = "../bql" }
> -qemu_api_macros = { path = "../qemu-api-macros" }
> +qemu_macros = { path = "../qemu-macros" }
>   qom = { path = "../qom" }
>   system = { path = "../system" }
>   anyhow = "~1.0"
> diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
> index a4c90b2bf7..02318950ff 100644
> --- a/rust/qemu-api/meson.build
> +++ b/rust/qemu-api/meson.build
> @@ -52,7 +52,7 @@ _qemu_api_rs = static_library(
>     override_options: ['rust_std=2021', 'build.rust_std=2021'],
>     rust_abi: 'rust',
>     rust_args: _qemu_api_cfg,
> -  dependencies: [anyhow_rs, common_rs, chardev_rs, foreign_rs, libc_rs, qemu_api_macros, qemuutil_rs, util_rs, migration_rs, bql_rs, qom_rs, system_rs, hwcore_rs,
> +  dependencies: [anyhow_rs, common_rs, chardev_rs, foreign_rs, libc_rs, qemu_macros, qemuutil_rs, util_rs, migration_rs, bql_rs, qom_rs, system_rs, hwcore_rs,
>                    qom, hwcore, chardev, migration],
>   )
>   
> @@ -60,7 +60,7 @@ rust.test('rust-qemu-api-tests', _qemu_api_rs,
>             suite: ['unit', 'rust'])
>   
>   qemu_api = declare_dependency(link_with: [_qemu_api_rs],
> -  dependencies: [qemu_api_macros, qom, hwcore, chardev, migration])
> +  dependencies: [qemu_macros, qom, hwcore, chardev, migration])
>   
>   # Doctests are essentially integration tests, so they need the same dependencies.
>   # Note that running them requires the object files for C code, so place them
> diff --git a/rust/qemu-api-macros/Cargo.toml b/rust/qemu-macros/Cargo.toml
> similarity index 94%
> rename from rust/qemu-api-macros/Cargo.toml
> rename to rust/qemu-macros/Cargo.toml
> index 0cd40c8e16..3b6f1d337f 100644
> --- a/rust/qemu-api-macros/Cargo.toml
> +++ b/rust/qemu-macros/Cargo.toml
> @@ -1,5 +1,5 @@
>   [package]
> -name = "qemu_api_macros"
> +name = "qemu_macros"
>   version = "0.1.0"
>   authors = ["Manos Pitsidianakis <manos.pitsidianakis@linaro.org>"]
>   description = "Rust bindings for QEMU - Utility macros"
> diff --git a/rust/qemu-api-macros/meson.build b/rust/qemu-macros/meson.build
> similarity index 63%
> rename from rust/qemu-api-macros/meson.build
> rename to rust/qemu-macros/meson.build
> index 2152bcb99b..d0b2992e20 100644
> --- a/rust/qemu-api-macros/meson.build
> +++ b/rust/qemu-macros/meson.build
> @@ -1,5 +1,5 @@
> -_qemu_api_macros_rs = rust.proc_macro(
> -  'qemu_api_macros',
> +_qemu_macros_rs = rust.proc_macro(
> +  'qemu_macros',
>     files('src/lib.rs'),
>     override_options: ['rust_std=2021', 'build.rust_std=2021'],
>     rust_args: [
> @@ -14,9 +14,9 @@ _qemu_api_macros_rs = rust.proc_macro(
>     ],
>   )
>   
> -qemu_api_macros = declare_dependency(
> -  link_with: _qemu_api_macros_rs,
> +qemu_macros = declare_dependency(
> +  link_with: _qemu_macros_rs,
>   )
>   
> -rust.test('rust-qemu-api-macros-tests', _qemu_api_macros_rs,
> +rust.test('rust-qemu-macros-tests', _qemu_macros_rs,
>             suite: ['unit', 'rust'])
> diff --git a/rust/qemu-api-macros/src/bits.rs b/rust/qemu-macros/src/bits.rs
> similarity index 100%
> rename from rust/qemu-api-macros/src/bits.rs
> rename to rust/qemu-macros/src/bits.rs
> diff --git a/rust/qemu-api-macros/src/lib.rs b/rust/qemu-macros/src/lib.rs
> similarity index 100%
> rename from rust/qemu-api-macros/src/lib.rs
> rename to rust/qemu-macros/src/lib.rs
> diff --git a/rust/qemu-api-macros/src/tests.rs b/rust/qemu-macros/src/tests.rs
> similarity index 100%
> rename from rust/qemu-api-macros/src/tests.rs
> rename to rust/qemu-macros/src/tests.rs
> diff --git a/rust/qom/Cargo.toml b/rust/qom/Cargo.toml
> index 46bbf7c7fe..060ad2ec34 100644
> --- a/rust/qom/Cargo.toml
> +++ b/rust/qom/Cargo.toml
> @@ -16,7 +16,7 @@ rust-version.workspace = true
>   common = { path = "../common" }
>   bql = { path = "../bql" }
>   migration = { path = "../migration" }
> -qemu_api_macros = { path = "../qemu-api-macros" }
> +qemu_macros = { path = "../qemu-macros" }
>   util = { path = "../util" }
>   
>   [lints]
> diff --git a/rust/qom/meson.build b/rust/qom/meson.build
> index 6e95d75fa0..40a2bf9ae0 100644
> --- a/rust/qom/meson.build
> +++ b/rust/qom/meson.build
> @@ -31,10 +31,10 @@ _qom_rs = static_library(
>     override_options: ['rust_std=2021', 'build.rust_std=2021'],
>     rust_abi: 'rust',
>     rust_args: _qom_cfg,
> -  dependencies: [qemuutil_rs, bql_rs, common_rs, migration_rs, qemu_api_macros, qom],
> +  dependencies: [qemuutil_rs, bql_rs, common_rs, migration_rs, qemu_macros, qom],
>   )
>   
> -qom_rs = declare_dependency(link_with: [_qom_rs], dependencies: [qemu_api_macros, qom])
> +qom_rs = declare_dependency(link_with: [_qom_rs], dependencies: [qemu_macros, qom])
>   
>   # Doctests are essentially integration tests, so they need the same dependencies.
>   # Note that running them requires the object files for C code, so place them
> diff --git a/rust/qom/src/qom.rs b/rust/qom/src/qom.rs
> index a632ec43f2..880bef6c47 100644
> --- a/rust/qom/src/qom.rs
> +++ b/rust/qom/src/qom.rs
> @@ -112,7 +112,7 @@
>   
>   /// A safe wrapper around [`bindings::Object`].
>   #[repr(transparent)]
> -#[derive(Debug, qemu_api_macros::Wrapper)]
> +#[derive(Debug, qemu_macros::Wrapper)]
>   pub struct Object(Opaque<bindings::Object>);
>   
>   unsafe impl Send for Object {}
> @@ -173,7 +173,7 @@ fn as_ref(&self) -> &$parent {
>   ///
>   /// ```ignore
>   /// #[repr(C)]
> -/// #[derive(qemu_api_macros::Object)]
> +/// #[derive(qemu_macros::Object)]
>   /// pub struct MyDevice {
>   ///     parent: ParentField<DeviceState>,
>   ///     ...
> diff --git a/rust/qom/tests/tests.rs b/rust/qom/tests/tests.rs
> index 49f1cbecf5..4d710f96a6 100644
> --- a/rust/qom/tests/tests.rs
> +++ b/rust/qom/tests/tests.rs
> @@ -4,7 +4,7 @@
>   use util::bindings::{module_call_init, module_init_type};
>   
>   #[repr(C)]
> -#[derive(qemu_api_macros::Object)]
> +#[derive(qemu_macros::Object)]
>   pub struct DummyObject {
>       parent: ParentField<Object>,
>   }
> diff --git a/rust/system/Cargo.toml b/rust/system/Cargo.toml
> index 6803895e08..d8338c8348 100644
> --- a/rust/system/Cargo.toml
> +++ b/rust/system/Cargo.toml
> @@ -16,7 +16,7 @@ rust-version.workspace = true
>   common = { path = "../common" }
>   qom = { path = "../qom" }
>   util = { path = "../util" }
> -qemu_api_macros = { path = "../qemu-api-macros" }
> +qemu_macros = { path = "../qemu-macros" }
>   
>   [lints]
>   workspace = true
> diff --git a/rust/system/meson.build b/rust/system/meson.build
> index cbd3eb4717..710462376d 100644
> --- a/rust/system/meson.build
> +++ b/rust/system/meson.build
> @@ -39,12 +39,12 @@ _system_rs = static_library(
>     override_options: ['rust_std=2021', 'build.rust_std=2021'],
>     rust_abi: 'rust',
>     rust_args: _system_cfg,
> -  dependencies: [qemuutil_rs, common_rs, bql_rs, migration_rs, qemu_api_macros, qom_rs, util_rs,
> +  dependencies: [qemuutil_rs, common_rs, bql_rs, migration_rs, qemu_macros, qom_rs, util_rs,
>                   hwcore],
>   )
>   
>   system_rs = declare_dependency(link_with: [_system_rs],
> -  dependencies: [qemu_api_macros, hwcore])
> +  dependencies: [qemu_macros, hwcore])
>   
>   # Doctests are essentially integration tests, so they need the same dependencies.
>   # Note that running them requires the object files for C code, so place them
> diff --git a/rust/system/src/memory.rs b/rust/system/src/memory.rs
> index af69fb30bf..898401c33b 100644
> --- a/rust/system/src/memory.rs
> +++ b/rust/system/src/memory.rs
> @@ -129,7 +129,7 @@ fn default() -> Self {
>   
>   /// A safe wrapper around [`bindings::MemoryRegion`].
>   #[repr(transparent)]
> -#[derive(qemu_api_macros::Wrapper)]
> +#[derive(qemu_macros::Wrapper)]
>   pub struct MemoryRegion(Opaque<bindings::MemoryRegion>);
>   
>   unsafe impl Send for MemoryRegion {}
> diff --git a/rust/util/Cargo.toml b/rust/util/Cargo.toml
> index aa10f03384..c5d1adb8fe 100644
> --- a/rust/util/Cargo.toml
> +++ b/rust/util/Cargo.toml
> @@ -17,7 +17,7 @@ anyhow = "~1.0"
>   libc = "0.2.162"
>   foreign = "~0.3.1"
>   common = { path = "../common" }
> -qemu_api_macros = { path = "../qemu-api-macros" }
> +qemu_macros = { path = "../qemu-macros" }
>   
>   [lints]
>   workspace = true
> diff --git a/rust/util/meson.build b/rust/util/meson.build
> index 3fe8e3975f..1e449b8dc7 100644
> --- a/rust/util/meson.build
> +++ b/rust/util/meson.build
> @@ -45,7 +45,7 @@ _util_rs = static_library(
>     override_options: ['rust_std=2021', 'build.rust_std=2021'],
>     rust_abi: 'rust',
>     rust_args: _util_cfg,
> -  dependencies: [anyhow_rs, libc_rs, foreign_rs, qemuutil_rs, common_rs, qemu_api_macros],
> +  dependencies: [anyhow_rs, libc_rs, foreign_rs, qemuutil_rs, common_rs, qemu_macros],
>   )
>   
>   util_rs = declare_dependency(link_with: [_util_rs], dependencies: [qemuutil_rs, qom])
> diff --git a/rust/util/src/timer.rs b/rust/util/src/timer.rs
> index 441072a949..42096cef0d 100644
> --- a/rust/util/src/timer.rs
> +++ b/rust/util/src/timer.rs
> @@ -15,14 +15,14 @@
>   
>   /// A safe wrapper around [`bindings::QEMUTimer`].
>   #[repr(transparent)]
> -#[derive(Debug, qemu_api_macros::Wrapper)]
> +#[derive(Debug, qemu_macros::Wrapper)]
>   pub struct Timer(Opaque<bindings::QEMUTimer>);
>   
>   unsafe impl Send for Timer {}
>   unsafe impl Sync for Timer {}
>   
>   #[repr(transparent)]
> -#[derive(qemu_api_macros::Wrapper)]
> +#[derive(qemu_macros::Wrapper)]
>   pub struct TimerListGroup(Opaque<bindings::QEMUTimerListGroup>);
>   
>   unsafe impl Send for TimerListGroup {}


