Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DFE9C2D0CD
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 09:51:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHg5p-0000cy-O6; Wed, 21 May 2025 05:50:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uHg5n-0000cP-FC
 for qemu-devel@nongnu.org; Wed, 21 May 2025 05:50:31 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uHg5j-0002O0-Jg
 for qemu-devel@nongnu.org; Wed, 21 May 2025 05:50:31 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-ad563b69908so532540366b.3
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 02:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747821025; x=1748425825; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mSJ2dLyj0fgXctb0JynLUulZpuqlzGEZsDk0RMSbTlg=;
 b=t6Fuzf76t9+hxwR9m8M2wfeB9Hx1CsjRSSzP3l7B/zaqNjxdVfWJxBm3crPFtD/2jh
 U2/OhTuGJY6SxQZujqbUZ+zCKsp2mGE27lraNAUFKWGbTB49cfTMUl+sYpn/+dNJhf9F
 TSSL8c6jbKixOcNA5bkbr8Bc/o/viOd1ZAQdhoqxnT8dYiV8wdxMIs9WsQGEigus/ep7
 BkEaKk4ra2YyBy7TVB9Izlrm9v4NT3Od6yXronBEBN9h2AMRcfxfH+HGVpj/ulZwUK+n
 yeZ80Z7BPFkc4plU4sGmVrifF3kk2M7MVvOeQZ9YRlYvG3UXqaDOxXz+xHygFMRAvLnD
 +8XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747821025; x=1748425825;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mSJ2dLyj0fgXctb0JynLUulZpuqlzGEZsDk0RMSbTlg=;
 b=ur20UnbH5sQ/D9Yhk5AtQ3dY0VS6L/7hrjHi2CDse0Kq49fjaruX0pFaeGdlAuofWH
 5ZtxAAbhpVcYJKjO6XuKb/mb+EaTYQ/ZLv9A4Pl1VGpr1deYRz1LdsPhbYx/Bhf0YRc2
 ZI/B/20PtRd1KSYfjqol/XUGcj/YCWKsmdTpDh9x3x+iDonuf3VTznjpOlAxO0Kx/7ca
 ySK3+PiASCGxh1Ulnc5lP+BXu96lrHct4dBSWmz0Bdz5P/e+n+3QnEpl7R4Q3aeJtcJt
 9ft9H5ULFdQYYCPpc5MLfqMxz+KqYYxrA4ygInlcjpxJhyXNEBYXqQ0f3Cdwo8Nx/7Qq
 KOQg==
X-Gm-Message-State: AOJu0Yw4qKn0X5TnZvlC9qFBJwf+VcWazIrfkQtnBpDJDv1lSYdkDz85
 NC6Dyo85n7g3Ls/VLxa2IwCobEqL9mkGk1GLmGQkJZ7RNzqzuSt6nGK080V9SOJXZmA=
X-Gm-Gg: ASbGncsNuufFZYCCA1hkqIVJT2MEhQM8eOmkYoGBfZtD5Ddby/LXF+Ya6N+alpo/i4V
 tWFsrGaRxk45ozpOvvlUL79QmiF5me1DaKTuZmvDsNuxcpinXz3kJ7szOGQKVjO1jKZbqPSYa/D
 ym4NW9O7h5RY91J0OyELLDTAbz5KKP/Syotx4sBy+oCOFBcoo7MpjKg+Xzn0QqJWAXnXdBKizn7
 15eELHIpxO9/9p85A8VmPrtF0IKSrq/kcTov1Mc8wJMe94tbRd5S4wIgb15nXxvkdm3euOu/hjP
 OoMaiLeP3xhchywGlaSUMNvVTbMQGwVfYKWKM+QR3SNoQARIDp7p
X-Google-Smtp-Source: AGHT+IH/c2xPf7AjpzkX6j8iEBFh/xN2JL9B/eCJDoxZL/wexAK0PtVAB6m9kQRMvVUGVAA0N8dlKA==
X-Received: by 2002:a17:907:7ea7:b0:ace:8398:b772 with SMTP id
 a640c23a62f3a-ad536b7c003mr1419677466b.14.1747821025011; 
 Wed, 21 May 2025 02:50:25 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad52d497214sm875146566b.146.2025.05.21.02.50.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 02:50:24 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 59B745F786;
 Wed, 21 May 2025 10:50:23 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,  peter.maydell@linaro.org,  qemu-rust@nongnu.org,
 manos.pitsidianakis@linaro.org
Subject: Re: [RFC PATCH 5/6] rust: pl011: switch from bilge to bitfield-struct
In-Reply-To: <20250521081845.496442-6-pbonzini@redhat.com> (Paolo Bonzini's
 message of "Wed, 21 May 2025 10:18:44 +0200")
References: <20250521081845.496442-1-pbonzini@redhat.com>
 <20250521081845.496442-6-pbonzini@redhat.com>
User-Agent: mu4e 1.12.11; emacs 30.1
Date: Wed, 21 May 2025 10:50:23 +0100
Message-ID: <871psi9tsw.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x634.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
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

Paolo Bonzini <pbonzini@redhat.com> writes:

> The bilge crate, while very nice and espressive, is heavily reliant on
> traits; because trait functions are never const, bilge and const mix
> about as well as water and oil.
>
> Try using the bitfield-struct crate instead.  It is built to support
> const very well and the only downside is that more manual annotations
> are needed (for enums and non-full-byte members).  Otherwise, the use
> is pretty much the same and in fact device code does not change at all,
> only register declarations.
>
> Recent versions want to use Rust 1.83, so this uses a slightly older
> version with basically no lost functionality; but anyway, I want to switch
> to 1.83 for QEMU as well due to improved "const" support in the compiler.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/Cargo.toml                     |   1 +
>  rust/hw/char/pl011/Cargo.toml       |   3 +-
>  rust/hw/char/pl011/meson.build      |  11 +--
>  rust/hw/char/pl011/src/registers.rs | 108 ++++++++++++++--------------
>  4 files changed, 56 insertions(+), 67 deletions(-)
>
> diff --git a/rust/Cargo.toml b/rust/Cargo.toml
> index 165328b6d01..3345858b5b4 100644
> --- a/rust/Cargo.toml
> +++ b/rust/Cargo.toml
> @@ -97,5 +97,6 @@ used_underscore_binding =3D "deny"
>  #wildcard_imports =3D "deny"   # still have many bindings::* imports
>=20=20
>  # these may have false positives
> +enum_variant_names =3D "allow"
>  #option_if_let_else =3D "deny"
>  cognitive_complexity =3D "deny"
> diff --git a/rust/hw/char/pl011/Cargo.toml b/rust/hw/char/pl011/Cargo.toml
> index 003ef9613d4..97e3dd00c35 100644
> --- a/rust/hw/char/pl011/Cargo.toml
> +++ b/rust/hw/char/pl011/Cargo.toml
> @@ -16,8 +16,7 @@ rust-version.workspace =3D true
>  crate-type =3D ["staticlib"]
>=20=20
>  [dependencies]
> -bilge =3D { version =3D "0.2.0" }
> -bilge-impl =3D { version =3D "0.2.0" }
> +bitfield-struct =3D { version =3D "0.9" }
>  bits =3D { path =3D "../../../bits" }
>  qemu_api =3D { path =3D "../../../qemu-api" }
>  qemu_api_macros =3D { path =3D "../../../qemu-api-macros" }
> diff --git a/rust/hw/char/pl011/meson.build b/rust/hw/char/pl011/meson.bu=
ild
> index f134a6cdc6b..1bae5a03310 100644
> --- a/rust/hw/char/pl011/meson.build
> +++ b/rust/hw/char/pl011/meson.build
> @@ -1,17 +1,10 @@
> -subproject('bilge-0.2-rs', required: true)
> -subproject('bilge-impl-0.2-rs', required: true)
> -
> -bilge_dep =3D dependency('bilge-0.2-rs')
> -bilge_impl_dep =3D dependency('bilge-impl-0.2-rs')
> -
>  _libpl011_rs =3D static_library(
>    'pl011',
>    files('src/lib.rs'),
>    override_options: ['rust_std=3D2021', 'build.rust_std=3D2021'],
>    rust_abi: 'rust',
>    dependencies: [
> -    bilge_dep,
> -    bilge_impl_dep,
> +    bitfield_struct_dep,
>      bits_rs,
>      qemu_api,
>      qemu_api_macros,
> @@ -22,6 +15,6 @@ rust_devices_ss.add(when: 'CONFIG_X_PL011_RUST', if_tru=
e: [declare_dependency(
>    link_whole: [_libpl011_rs],
>    # Putting proc macro crates in `dependencies` is necessary for Meson t=
o find
>    # them when compiling the root per-target static rust lib.
> -  dependencies: [bilge_impl_dep, qemu_api_macros],
> +  dependencies: [bitfield_struct_dep, qemu_api_macros],
>    variables: {'crate': 'pl011'},
>  )])
> diff --git a/rust/hw/char/pl011/src/registers.rs b/rust/hw/char/pl011/src=
/registers.rs
> index 7ececd39f86..f2138c637c5 100644
> --- a/rust/hw/char/pl011/src/registers.rs
> +++ b/rust/hw/char/pl011/src/registers.rs
> @@ -5,12 +5,16 @@
>  //! Device registers exposed as typed structs which are backed by arbitr=
ary
>  //! integer bitmaps. [`Data`], [`Control`], [`LineControl`], etc.
>=20=20
> +// rustc prefers "constant-like" enums to use upper case names, but that
> +// is inconsistent in its own way.
> +#![allow(non_upper_case_globals)]
> +
>  // For more detail see the PL011 Technical Reference Manual DDI0183:
>  // https://developer.arm.com/documentation/ddi0183/latest/
>=20=20
> -use bilge::prelude::*;
> +use bitfield_struct::bitfield;
>  use bits::bits;
> -use qemu_api::{impl_vmstate_bitsized, impl_vmstate_forward};
> +use qemu_api::impl_vmstate_forward;
>=20=20
>  /// Offset of each register from the base memory address of the device.
>  #[doc(alias =3D "offset")]
> @@ -78,14 +82,18 @@ pub enum RegisterOffset {
>  /// The `UARTRSR` register is updated only when a read occurs
>  /// from the `UARTDR` register with the same status information
>  /// that can also be obtained by reading the `UARTDR` register
> -#[bitsize(8)]
> -#[derive(Clone, Copy, Default, DebugBits, FromBits)]
> +#[bitfield(u8)]
>  pub struct Errors {
>      pub framing_error: bool,
>      pub parity_error: bool,
>      pub break_error: bool,
>      pub overrun_error: bool,
> -    _reserved_unpredictable: u4,
> +    #[bits(4)]
> +    _reserved_unpredictable: u8,

This does come off as a little janky - effectively casting the u8 to
only cover 4 bits. Is this not something we can derive from the type? I
see lower down...

> +}
> +
> +impl Errors {
> +    pub const BREAK: Self =3D Errors::new().with_break_error(true);
>  }
>=20=20
>  /// Data Register, `UARTDR`
> @@ -93,19 +101,18 @@ pub struct Errors {
>  /// The `UARTDR` register is the data register; write for TX and
>  /// read for RX. It is a 12-bit register, where bits 7..0 are the
>  /// character and bits 11..8 are error bits.
> -#[bitsize(32)]
> -#[derive(Clone, Copy, Default, DebugBits, FromBits)]
> +#[bitfield(u32)]
>  #[doc(alias =3D "UARTDR")]
>  pub struct Data {
>      pub data: u8,
> +    #[bits(8)]
>      pub errors: Errors,

We should be able to derive that Errors fits into 8 bits as defined above.

>      _reserved: u16,
>  }
> -impl_vmstate_bitsized!(Data);
> +impl_vmstate_forward!(Data);
>=20=20
>  impl Data {
> -    // bilge is not very const-friendly, unfortunately
> -    pub const BREAK: Self =3D Self { value: 1 << 10 };
> +    pub const BREAK: Self =3D Self::new().with_errors(Errors::BREAK);
>  }

I guess this flys a little over my head, is the effect only seen in the
generated code?

>=20=20
>  /// Receive Status Register / Error Clear Register, `UARTRSR/UARTECR`
> @@ -119,13 +126,14 @@ impl Data {
>  /// and UARTECR for writes, but really it's a single error status
>  /// register where writing anything to the register clears the error
>  /// bits.
> -#[bitsize(32)]
> -#[derive(Clone, Copy, DebugBits, FromBits)]
> +#[bitfield(u32)]
>  pub struct ReceiveStatusErrorClear {
> +    #[bits(8)]
>      pub errors: Errors,
> -    _reserved_unpredictable: u24,
> +    #[bits(24)]
> +    _reserved_unpredictable: u32,
>  }
> -impl_vmstate_bitsized!(ReceiveStatusErrorClear);
> +impl_vmstate_forward!(ReceiveStatusErrorClear);
>=20=20
>  impl ReceiveStatusErrorClear {
>      pub fn set_from_data(&mut self, data: Data) {
> @@ -138,14 +146,7 @@ pub fn reset(&mut self) {
>      }
>  }
>=20=20
> -impl Default for ReceiveStatusErrorClear {
> -    fn default() -> Self {
> -        0.into()
> -    }
> -}
> -
> -#[bitsize(32)]
> -#[derive(Clone, Copy, DebugBits, FromBits)]
> +#[bitfield(u32, default =3D false)]
>  /// Flag Register, `UARTFR`
>  ///
>  /// This has the usual inbound RS232 modem-control signals, plus flags
> @@ -171,9 +172,10 @@ pub struct Flags {
>      pub transmit_fifo_empty: bool,
>      /// RI: Ring indicator
>      pub ring_indicator: bool,
> -    _reserved_zero_no_modify: u23,
> +    #[bits(23)]
> +    _reserved_zero_no_modify: u32,
>  }
> -impl_vmstate_bitsized!(Flags);
> +impl_vmstate_forward!(Flags);
>=20=20
>  impl Flags {
>      pub fn reset(&mut self) {
> @@ -183,16 +185,14 @@ pub fn reset(&mut self) {
>=20=20
>  impl Default for Flags {
>      fn default() -> Self {
> -        let mut ret: Self =3D 0.into();
>          // After reset TXFF, RXFF, and BUSY are 0, and TXFE and RXFE are=
 1
> -        ret.set_receive_fifo_empty(true);
> -        ret.set_transmit_fifo_empty(true);
> -        ret
> +        Self::from(0)
> +            .with_receive_fifo_empty(true)
> +            .with_transmit_fifo_empty(true)

I guess skipping the mut is the advantage of being able to const eval.

>      }
>  }
>=20=20
> -#[bitsize(32)]
> -#[derive(Clone, Copy, DebugBits, FromBits)]
> +#[bitfield(u32)]
>  /// Line Control Register, `UARTLCR_H`
>  #[doc(alias =3D "UARTLCR_H")]
>  pub struct LineControl {
> @@ -201,48 +201,46 @@ pub struct LineControl {
>      /// PEN: Parity enable
>      pub parity_enabled: bool,
>      /// EPS: Even parity select
> +    #[bits(1)]
>      pub parity: Parity,
>      /// STP2: Two stop bits select
>      pub two_stops_bits: bool,
>      /// FEN: Enable FIFOs
> +    #[bits(1)]
>      pub fifos_enabled: Mode,
>      /// WLEN: Word length in bits
>      /// b11 =3D 8 bits
>      /// b10 =3D 7 bits
>      /// b01 =3D 6 bits
>      /// b00 =3D 5 bits.
> +    #[bits(2)]
>      pub word_length: WordLength,
>      /// SPS Stick parity select
>      pub sticky_parity: bool,
>      /// 31:8 - Reserved, do not modify, read as zero.
> -    _reserved_zero_no_modify: u24,
> +    #[bits(24)]
> +    _reserved_zero_no_modify: u32,
>  }
> -impl_vmstate_bitsized!(LineControl);
> +impl_vmstate_forward!(LineControl);
>=20=20
>  impl LineControl {
>      pub fn reset(&mut self) {
>          // All the bits are cleared to 0 when reset.
> -        *self =3D 0.into();
> +        *self =3D Self::default();
>      }
>  }
>=20=20
> -impl Default for LineControl {
> -    fn default() -> Self {
> -        0.into()
> -    }
> -}
> -
> -#[bitsize(1)]
> -#[derive(Clone, Copy, Debug, Eq, FromBits, PartialEq)]
>  /// `EPS` "Even parity select", field of [Line Control
>  /// register](LineControl).
> +#[repr(u8)]
> +#[derive(Clone, Copy, Debug, Eq, PartialEq, qemu_api_macros::TryInto)]
>  pub enum Parity {
>      Odd =3D 0,
>      Even =3D 1,
>  }
>=20=20
> -#[bitsize(1)]
> -#[derive(Clone, Copy, Debug, Eq, FromBits, PartialEq)]
> +#[repr(u8)]
> +#[derive(Clone, Copy, Debug, Eq, PartialEq, qemu_api_macros::TryInto)]
>  /// `FEN` "Enable FIFOs" or Device mode, field of [Line Control
>  /// register](LineControl).
>  pub enum Mode {
> @@ -253,8 +251,8 @@ pub enum Mode {
>      FIFO =3D 1,
>  }
>=20=20
> -#[bitsize(2)]
> -#[derive(Clone, Copy, Debug, Eq, FromBits, PartialEq)]
> +#[repr(u8)]
> +#[derive(Clone, Copy, Debug, Eq, PartialEq, qemu_api_macros::TryInto)]
>  /// `WLEN` Word length, field of [Line Control register](LineControl).
>  ///
>  /// These bits indicate the number of data bits transmitted or received =
in a
> @@ -275,9 +273,8 @@ pub enum WordLength {
>  /// The `UARTCR` register is the control register. It contains various
>  /// enable bits, and the bits to write to set the usual outbound RS232
>  /// modem control signals. All bits reset to 0 except TXE and RXE.
> -#[bitsize(32)]
> +#[bitfield(u32, default =3D false)]
>  #[doc(alias =3D "UARTCR")]
> -#[derive(Clone, Copy, DebugBits, FromBits)]
>  pub struct Control {
>      /// `UARTEN` UART enable: 0 =3D UART is disabled.
>      pub enable_uart: bool,
> @@ -285,9 +282,10 @@ pub struct Control {
>      /// QEMU does not model this.
>      pub enable_sir: bool,
>      /// `SIRLP` SIR low-power IrDA mode. QEMU does not model this.
> -    pub sir_lowpower_irda_mode: u1,
> +    pub sir_lowpower_irda_mode: bool,
>      /// Reserved, do not modify, read as zero.
> -    _reserved_zero_no_modify: u4,
> +    #[bits(4)]
> +    _reserved_zero_no_modify: u8,
>      /// `LBE` Loopback enable: feed UART output back to the input
>      pub enable_loopback: bool,
>      /// `TXE` Transmit enable
<snip>

I guess I'm not seeing a massive difference here. I guess the const eval
is nice but there is cognitive dissonance having annotations not match
types. It would be nice to have the best of both worlds.

For now I don't see a compelling reason to change from a standard crate
(which I guess is the reason this is an RFC ;-)

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

