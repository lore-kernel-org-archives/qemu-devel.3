Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9CE3C2D0CD
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 09:42:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHfwz-0001Ks-C1; Wed, 21 May 2025 05:41:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uHfwx-0001KT-QG
 for qemu-devel@nongnu.org; Wed, 21 May 2025 05:41:24 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uHfws-0001UH-9u
 for qemu-devel@nongnu.org; Wed, 21 May 2025 05:41:23 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-602039559d8so4270772a12.1
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 02:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747820475; x=1748425275; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TPpIkdf+hDnPlUEbIpj5ssdgSn1OIa9RxGGCUye0EEw=;
 b=DdVH5DyP2vtuRKF2/8WbFLDu0gbeIHvWKEKa969VlRtVtSciURVH+4TKA/La1A3Jg/
 kv69wWjBc2Wb+4nHT2rv5NQdE0udHE8lL+hkhUVlvsPpGD0x3zhWlDGyRfmhIrN987Nb
 iLBa7FYsWQNTqi7xLBpN5dMl0i7WVeZFjnmLbz+ZW4S287KI+IDGMpwtgA/2JuK7Q73l
 xYXr4oj5EEE7wuPANLT1ypq8PDPg8S/CGStLbRwnBNpPgdOQJoHSHL8VfCGoMqiwpqm4
 oi63lQwB06wBihBVFq+llVdiFNcIz8ARq/FRoB+yYk9moFthzJeL30IT3I/I729LToau
 ozCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747820475; x=1748425275;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TPpIkdf+hDnPlUEbIpj5ssdgSn1OIa9RxGGCUye0EEw=;
 b=A9+akt/FT9daXNnbgHmr4iH4DEFz07uuC0tT2nrA/C2Jh3K1pF7MOHgTztbqvRC0SI
 VfXNZsAqEAUznjvbmi2RWdIIK56zu6QosEV3jmc1hBX4oM+obw/WjtHtD5Lp1Q+eJS6S
 YYX2kVV2qv+v1GPPSzQ4ttDwegLGvPEQ6J6YKLc3+Wya9lp6KKQmCnBHYFnlGPAwufi+
 d7d4I5Hz/86B380DyqHGcRuIClCMjYxG8G9yFmjQdyL9qX21hBfqHcGoP27ZIJmjdJtJ
 q62Sxn3q8KVQ/uH0fjZ/Tfi42J46PoSCh3aFLvhPKZHHdjGHguWssbvNMIxEzgMvhKSL
 FB1w==
X-Gm-Message-State: AOJu0YyUs7BlvFxPOmKHwwvYRKfFeQNuG2YNXL9o8dCLd9e51wDX5VQZ
 AQtzcq0iFj9RI7x9opmp39DxeyrHoXhCGV5SmQ7UrtszPsh2K+Lq75haatx1jM/VivphZBF8XtY
 oZV1rRimXVI1Jzrt0BzIgK5N2e2SUfbkol+TrbFAEMQ==
X-Gm-Gg: ASbGncsFUWdB6en1Ug7bUrU17Bwoe4nOsWZ0PDtXAXPHWJYL0wTnW7sRmFWjPibEH1t
 aya2IbInISRs/DinGCKNoLN4dKrupVjeIJD2rSUGhYaOY8mKrH1yycC84mOjESXzmZEROposr7z
 D+5UFGj/4vYjQ+tzUNFlX/D8xGTEjF
X-Google-Smtp-Source: AGHT+IG0/dNk/2qndHJHdhR0Hco+Lzv43Na5m3fBk80mqI1MPIcpfdAOLTFzWhv9TUT6tWJN0tuzATWkkYbL6bSGArU=
X-Received: by 2002:a05:6402:2108:b0:5fd:1972:7fac with SMTP id
 4fb4d7f45d1cf-60114069aeamr19020353a12.3.1747820475134; Wed, 21 May 2025
 02:41:15 -0700 (PDT)
MIME-Version: 1.0
References: <20250521081845.496442-1-pbonzini@redhat.com>
 <20250521081845.496442-6-pbonzini@redhat.com>
 <CAAjaMXaeM0Nt3dzEJLCiAOeCQzneEDO6yeX3+CF5tZ2dhQ=YLw@mail.gmail.com>
In-Reply-To: <CAAjaMXaeM0Nt3dzEJLCiAOeCQzneEDO6yeX3+CF5tZ2dhQ=YLw@mail.gmail.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Wed, 21 May 2025 12:40:49 +0300
X-Gm-Features: AX0GCFuZzmybzWUExLaq1t1r1cpykH6zfJL1FV68lrc6d6d0cBY-ZN_rV4BfSKM
Message-ID: <CAAjaMXb-LUR5hB-ajAJO+mwrcyDT9gBX8LyfGBBzjnQBUQ8Fqw@mail.gmail.com>
Subject: Re: [RFC PATCH 5/6] rust: pl011: switch from bilge to bitfield-struct
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, qemu-rust@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, May 21, 2025 at 12:21=E2=80=AFPM Manos Pitsidianakis
<manos.pitsidianakis@linaro.org> wrote:
>
> On Wed, May 21, 2025 at 11:19=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.c=
om> wrote:
> >
> > The bilge crate, while very nice and espressive, is heavily reliant on
> > traits; because trait functions are never const, bilge and const mix
> > about as well as water and oil.
> >
> > Try using the bitfield-struct crate instead.  It is built to support
> > const very well and the only downside is that more manual annotations
> > are needed (for enums and non-full-byte members).  Otherwise, the use
> > is pretty much the same and in fact device code does not change at all,
> > only register declarations.
> >
> > Recent versions want to use Rust 1.83, so this uses a slightly older
> > version with basically no lost functionality; but anyway, I want to swi=
tch
> > to 1.83 for QEMU as well due to improved "const" support in the compile=
r.
> >
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >  rust/Cargo.toml                     |   1 +
> >  rust/hw/char/pl011/Cargo.toml       |   3 +-
> >  rust/hw/char/pl011/meson.build      |  11 +--
> >  rust/hw/char/pl011/src/registers.rs | 108 ++++++++++++++--------------
> >  4 files changed, 56 insertions(+), 67 deletions(-)
> >
> > diff --git a/rust/Cargo.toml b/rust/Cargo.toml
> > index 165328b6d01..3345858b5b4 100644
> > --- a/rust/Cargo.toml
> > +++ b/rust/Cargo.toml
> > @@ -97,5 +97,6 @@ used_underscore_binding =3D "deny"
> >  #wildcard_imports =3D "deny"   # still have many bindings::* imports
> >
> >  # these may have false positives
> > +enum_variant_names =3D "allow"
> >  #option_if_let_else =3D "deny"
> >  cognitive_complexity =3D "deny"
> > diff --git a/rust/hw/char/pl011/Cargo.toml b/rust/hw/char/pl011/Cargo.t=
oml
> > index 003ef9613d4..97e3dd00c35 100644
> > --- a/rust/hw/char/pl011/Cargo.toml
> > +++ b/rust/hw/char/pl011/Cargo.toml
> > @@ -16,8 +16,7 @@ rust-version.workspace =3D true
> >  crate-type =3D ["staticlib"]
> >
> >  [dependencies]
> > -bilge =3D { version =3D "0.2.0" }
> > -bilge-impl =3D { version =3D "0.2.0" }
> > +bitfield-struct =3D { version =3D "0.9" }
> >  bits =3D { path =3D "../../../bits" }
> >  qemu_api =3D { path =3D "../../../qemu-api" }
> >  qemu_api_macros =3D { path =3D "../../../qemu-api-macros" }
> > diff --git a/rust/hw/char/pl011/meson.build b/rust/hw/char/pl011/meson.=
build
> > index f134a6cdc6b..1bae5a03310 100644
> > --- a/rust/hw/char/pl011/meson.build
> > +++ b/rust/hw/char/pl011/meson.build
> > @@ -1,17 +1,10 @@
> > -subproject('bilge-0.2-rs', required: true)
> > -subproject('bilge-impl-0.2-rs', required: true)
> > -
> > -bilge_dep =3D dependency('bilge-0.2-rs')
> > -bilge_impl_dep =3D dependency('bilge-impl-0.2-rs')
> > -
> >  _libpl011_rs =3D static_library(
> >    'pl011',
> >    files('src/lib.rs'),
> >    override_options: ['rust_std=3D2021', 'build.rust_std=3D2021'],
> >    rust_abi: 'rust',
> >    dependencies: [
> > -    bilge_dep,
> > -    bilge_impl_dep,
> > +    bitfield_struct_dep,
> >      bits_rs,
> >      qemu_api,
> >      qemu_api_macros,
> > @@ -22,6 +15,6 @@ rust_devices_ss.add(when: 'CONFIG_X_PL011_RUST', if_t=
rue: [declare_dependency(
> >    link_whole: [_libpl011_rs],
> >    # Putting proc macro crates in `dependencies` is necessary for Meson=
 to find
> >    # them when compiling the root per-target static rust lib.
> > -  dependencies: [bilge_impl_dep, qemu_api_macros],
> > +  dependencies: [bitfield_struct_dep, qemu_api_macros],
> >    variables: {'crate': 'pl011'},
> >  )])
> > diff --git a/rust/hw/char/pl011/src/registers.rs b/rust/hw/char/pl011/s=
rc/registers.rs
> > index 7ececd39f86..f2138c637c5 100644
> > --- a/rust/hw/char/pl011/src/registers.rs
> > +++ b/rust/hw/char/pl011/src/registers.rs
> > @@ -5,12 +5,16 @@
> >  //! Device registers exposed as typed structs which are backed by arbi=
trary
> >  //! integer bitmaps. [`Data`], [`Control`], [`LineControl`], etc.
> >
> > +// rustc prefers "constant-like" enums to use upper case names, but th=
at
> > +// is inconsistent in its own way.
> > +#![allow(non_upper_case_globals)]
> > +
> >  // For more detail see the PL011 Technical Reference Manual DDI0183:
> >  // https://developer.arm.com/documentation/ddi0183/latest/
> >
> > -use bilge::prelude::*;
> > +use bitfield_struct::bitfield;
> >  use bits::bits;
> > -use qemu_api::{impl_vmstate_bitsized, impl_vmstate_forward};
> > +use qemu_api::impl_vmstate_forward;
> >
> >  /// Offset of each register from the base memory address of the device=
.
> >  #[doc(alias =3D "offset")]
> > @@ -78,14 +82,18 @@ pub enum RegisterOffset {
> >  /// The `UARTRSR` register is updated only when a read occurs
> >  /// from the `UARTDR` register with the same status information
> >  /// that can also be obtained by reading the `UARTDR` register
> > -#[bitsize(8)]
> > -#[derive(Clone, Copy, Default, DebugBits, FromBits)]
> > +#[bitfield(u8)]
> >  pub struct Errors {
> >      pub framing_error: bool,
> >      pub parity_error: bool,
> >      pub break_error: bool,
> >      pub overrun_error: bool,
> > -    _reserved_unpredictable: u4,
> > +    #[bits(4)]
> > +    _reserved_unpredictable: u8,
> > +}
> > +
> > +impl Errors {
> > +    pub const BREAK: Self =3D Errors::new().with_break_error(true);
> >  }
> >
> >  /// Data Register, `UARTDR`
> > @@ -93,19 +101,18 @@ pub struct Errors {
> >  /// The `UARTDR` register is the data register; write for TX and
> >  /// read for RX. It is a 12-bit register, where bits 7..0 are the
> >  /// character and bits 11..8 are error bits.
> > -#[bitsize(32)]
> > -#[derive(Clone, Copy, Default, DebugBits, FromBits)]
> > +#[bitfield(u32)]
> >  #[doc(alias =3D "UARTDR")]
> >  pub struct Data {
> >      pub data: u8,
> > +    #[bits(8)]
> >      pub errors: Errors,
> >      _reserved: u16,
> >  }
> > -impl_vmstate_bitsized!(Data);
> > +impl_vmstate_forward!(Data);
> >
> >  impl Data {
> > -    // bilge is not very const-friendly, unfortunately
> > -    pub const BREAK: Self =3D Self { value: 1 << 10 };
> > +    pub const BREAK: Self =3D Self::new().with_errors(Errors::BREAK);
> >  }
> >
> >  /// Receive Status Register / Error Clear Register, `UARTRSR/UARTECR`
> > @@ -119,13 +126,14 @@ impl Data {
> >  /// and UARTECR for writes, but really it's a single error status
> >  /// register where writing anything to the register clears the error
> >  /// bits.
> > -#[bitsize(32)]
> > -#[derive(Clone, Copy, DebugBits, FromBits)]
> > +#[bitfield(u32)]
> >  pub struct ReceiveStatusErrorClear {
> > +    #[bits(8)]
> >      pub errors: Errors,
> > -    _reserved_unpredictable: u24,
> > +    #[bits(24)]
> > +    _reserved_unpredictable: u32,
> >  }
> > -impl_vmstate_bitsized!(ReceiveStatusErrorClear);
> > +impl_vmstate_forward!(ReceiveStatusErrorClear);
> >
> >  impl ReceiveStatusErrorClear {
> >      pub fn set_from_data(&mut self, data: Data) {
> > @@ -138,14 +146,7 @@ pub fn reset(&mut self) {
> >      }
> >  }
> >
> > -impl Default for ReceiveStatusErrorClear {
> > -    fn default() -> Self {
> > -        0.into()
> > -    }
> > -}
> > -
> > -#[bitsize(32)]
> > -#[derive(Clone, Copy, DebugBits, FromBits)]
> > +#[bitfield(u32, default =3D false)]
> >  /// Flag Register, `UARTFR`
> >  ///
> >  /// This has the usual inbound RS232 modem-control signals, plus flags
> > @@ -171,9 +172,10 @@ pub struct Flags {
> >      pub transmit_fifo_empty: bool,
> >      /// RI: Ring indicator
> >      pub ring_indicator: bool,
> > -    _reserved_zero_no_modify: u23,
> > +    #[bits(23)]
> > +    _reserved_zero_no_modify: u32,
> >  }
> > -impl_vmstate_bitsized!(Flags);
> > +impl_vmstate_forward!(Flags);
> >
> >  impl Flags {
> >      pub fn reset(&mut self) {
> > @@ -183,16 +185,14 @@ pub fn reset(&mut self) {
> >
> >  impl Default for Flags {
> >      fn default() -> Self {
> > -        let mut ret: Self =3D 0.into();
> >          // After reset TXFF, RXFF, and BUSY are 0, and TXFE and RXFE a=
re 1
> > -        ret.set_receive_fifo_empty(true);
> > -        ret.set_transmit_fifo_empty(true);
> > -        ret
> > +        Self::from(0)
> > +            .with_receive_fifo_empty(true)
> > +            .with_transmit_fifo_empty(true)
> >      }
> >  }
> >
> > -#[bitsize(32)]
> > -#[derive(Clone, Copy, DebugBits, FromBits)]
> > +#[bitfield(u32)]
> >  /// Line Control Register, `UARTLCR_H`
> >  #[doc(alias =3D "UARTLCR_H")]
> >  pub struct LineControl {
> > @@ -201,48 +201,46 @@ pub struct LineControl {
> >      /// PEN: Parity enable
> >      pub parity_enabled: bool,
> >      /// EPS: Even parity select
> > +    #[bits(1)]
> >      pub parity: Parity,
> >      /// STP2: Two stop bits select
> >      pub two_stops_bits: bool,
> >      /// FEN: Enable FIFOs
> > +    #[bits(1)]
> >      pub fifos_enabled: Mode,
> >      /// WLEN: Word length in bits
> >      /// b11 =3D 8 bits
> >      /// b10 =3D 7 bits
> >      /// b01 =3D 6 bits
> >      /// b00 =3D 5 bits.
> > +    #[bits(2)]
> >      pub word_length: WordLength,
> >      /// SPS Stick parity select
> >      pub sticky_parity: bool,
> >      /// 31:8 - Reserved, do not modify, read as zero.
> > -    _reserved_zero_no_modify: u24,
> > +    #[bits(24)]
> > +    _reserved_zero_no_modify: u32,
> >  }
> > -impl_vmstate_bitsized!(LineControl);
> > +impl_vmstate_forward!(LineControl);
> >
> >  impl LineControl {
> >      pub fn reset(&mut self) {
> >          // All the bits are cleared to 0 when reset.
> > -        *self =3D 0.into();
> > +        *self =3D Self::default();
> >      }
> >  }
> >
> > -impl Default for LineControl {
> > -    fn default() -> Self {
> > -        0.into()
> > -    }
> > -}
> > -
> > -#[bitsize(1)]
> > -#[derive(Clone, Copy, Debug, Eq, FromBits, PartialEq)]
> >  /// `EPS` "Even parity select", field of [Line Control
> >  /// register](LineControl).
> > +#[repr(u8)]
> > +#[derive(Clone, Copy, Debug, Eq, PartialEq, qemu_api_macros::TryInto)]
> >  pub enum Parity {
> >      Odd =3D 0,
> >      Even =3D 1,
> >  }
> >
> > -#[bitsize(1)]
> > -#[derive(Clone, Copy, Debug, Eq, FromBits, PartialEq)]
> > +#[repr(u8)]
> > +#[derive(Clone, Copy, Debug, Eq, PartialEq, qemu_api_macros::TryInto)]
> >  /// `FEN` "Enable FIFOs" or Device mode, field of [Line Control
> >  /// register](LineControl).
> >  pub enum Mode {
> > @@ -253,8 +251,8 @@ pub enum Mode {
> >      FIFO =3D 1,
> >  }
> >
> > -#[bitsize(2)]
> > -#[derive(Clone, Copy, Debug, Eq, FromBits, PartialEq)]
> > +#[repr(u8)]
> > +#[derive(Clone, Copy, Debug, Eq, PartialEq, qemu_api_macros::TryInto)]
> >  /// `WLEN` Word length, field of [Line Control register](LineControl).
> >  ///
> >  /// These bits indicate the number of data bits transmitted or receive=
d in a
> > @@ -275,9 +273,8 @@ pub enum WordLength {
> >  /// The `UARTCR` register is the control register. It contains various
> >  /// enable bits, and the bits to write to set the usual outbound RS232
> >  /// modem control signals. All bits reset to 0 except TXE and RXE.
> > -#[bitsize(32)]
> > +#[bitfield(u32, default =3D false)]
> >  #[doc(alias =3D "UARTCR")]
> > -#[derive(Clone, Copy, DebugBits, FromBits)]
> >  pub struct Control {
> >      /// `UARTEN` UART enable: 0 =3D UART is disabled.
> >      pub enable_uart: bool,
> > @@ -285,9 +282,10 @@ pub struct Control {
> >      /// QEMU does not model this.
> >      pub enable_sir: bool,
> >      /// `SIRLP` SIR low-power IrDA mode. QEMU does not model this.
> > -    pub sir_lowpower_irda_mode: u1,
> > +    pub sir_lowpower_irda_mode: bool,
> >      /// Reserved, do not modify, read as zero.
> > -    _reserved_zero_no_modify: u4,
> > +    #[bits(4)]
> > +    _reserved_zero_no_modify: u8,
> >      /// `LBE` Loopback enable: feed UART output back to the input
> >      pub enable_loopback: bool,
> >      /// `TXE` Transmit enable
> > @@ -309,21 +307,19 @@ pub struct Control {
> >      /// 31:16 - Reserved, do not modify, read as zero.
> >      _reserved_zero_no_modify2: u16,
> >  }
> > -impl_vmstate_bitsized!(Control);
> > +impl_vmstate_forward!(Control);
> >
> >  impl Control {
> >      pub fn reset(&mut self) {
> > -        *self =3D 0.into();
> > -        self.set_enable_receive(true);
> > -        self.set_enable_transmit(true);
> > +        *self =3D Self::default();
> >      }
> >  }
> >
> >  impl Default for Control {
> >      fn default() -> Self {
> > -        let mut ret: Self =3D 0.into();
> > -        ret.reset();
> > -        ret
> > +        Self::from(0)
> > +            .with_enable_receive(true)
> > +            .with_enable_transmit(true)
> >      }
> >  }
> >
> > --
> > 2.49.0
> >
>
> Perhaps it'd be simpler to contribute const-ability to upstream bilge?
> Is From/Into the only problem trait? I was thinking we can generate
> from/into associated methods for each type that are const. It'd not
> even be a big change and we can carry it as a patch until we can
> catchup with upstream crates.io version in subprojects/. WDYT?

I see that https://github.com/danlehmann/arbitrary-int for example
says almost everything can be used in const context. If we just skip
using traits for generated register types and use associated const
methods (and even implement From/Into that call these internally)
maybe it's not really a problem anymore.



--=20
Manos Pitsidianakis
Emulation and Virtualization Engineer at Linaro Ltd

