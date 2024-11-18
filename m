Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA320D49211
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 11:42:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD07t-0003i2-Li; Mon, 18 Nov 2024 06:41:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tD07q-0003aX-5m
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 06:41:02 -0500
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tD07n-0002DK-3M
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 06:41:01 -0500
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2fb59652cb9so25855891fa.3
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2024 03:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731930056; x=1732534856; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ISRXUaZ54GwptFenGo+LwGD0F1mMiQvyt2NygcCSjHM=;
 b=kc/4IM4zudOvoVgVzJ0wKF/U4S4a57XHyWMACEKL4nVutQKlHGZCMV83OXSRpB2JsQ
 amSWDizd0ybG99XB+Ij5v2GGHOFKWiKkjb8L+olgZFMXAFkWdOyLTJ6Zq6LSnKOhYNfb
 76MIAsefg+YZ8zMWlNmwMTNkA5dtzNqNNWYsg89ms49SkJ359yUe7oKvCKvWvwhRyctK
 W9Gj6Mvmn+85aQJtUxx1INxXFJJ4ZpN6nytW9fTlzIcN44yL0ZZfQ8ubVcmZXT18JOXH
 NP46R6EcwH0VVFd0Z8F5vhO/6ytV75h43rd7ww8hVcPnren5TGa769UJEMtSzeL+2VpY
 Uz9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731930056; x=1732534856;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ISRXUaZ54GwptFenGo+LwGD0F1mMiQvyt2NygcCSjHM=;
 b=YELaXmtV7EmO0oeXHBt7oXmo8hmTmy4Br3BMufSxQ7zWsMJzT5zXWjXFZMgpe4M2yo
 NxQ7R4Z+zyxM6GrwdB0XV4pV5OA51MYaCvdPTpzRUnuu7Uq8OQGtmA8nXFRG5BUFI6MM
 jyRweZAFafCpC7cC1Sg9ZZNahjAFXLBp84pnQBcmGiDFevyF0MhBJyeG7c5m9og5E+iL
 q0IFrcb3CLY6FWvvrKM+S+XhJtFWRkDZ+xMZmEkZcZire56CX0iN5pfMAevg4KFH3EwH
 CFSRCwfqgSJbnVAUkn/UIzuwuQvDVJX25RwIbqSX88Xxq7rfg4cM1fJXpNf4CgObeKWS
 vUOw==
X-Gm-Message-State: AOJu0YyLKM61c/1DIqGAoT0AFMr1FGXcN/dc/kYrjW06+Z3J9bWCeb6Z
 T8I7bJk7jlCV/UmwtJ7zU37aurJt5xeOx+oU+eb4ciBFtgYFSY65aPhFlcLk2m0=
X-Google-Smtp-Source: AGHT+IEsQEIWxzRdVrTbs8lxcxFrcL7WE6sY3mEeNg77R675RHvVwz8GLyNEbT0IwJNMGDKtucny4Q==
X-Received: by 2002:a2e:bd17:0:b0:2f7:58bc:f497 with SMTP id
 38308e7fff4ca-2ff6070e77emr62064311fa.28.1731930056437; 
 Mon, 18 Nov 2024 03:40:56 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-382331a90a5sm7540533f8f.21.2024.11.18.03.40.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Nov 2024 03:40:55 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6B7235F7C6;
 Mon, 18 Nov 2024 11:40:54 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org,  qemu-arm@nongnu.org,  qemu-rust@nongnu.org,
 Gustavo Romero <gustavo.romero@linaro.org>,  Peter Maydell
 <peter.maydell@linaro.org>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,  Richard Henderson
 <richard.henderson@linaro.org>
Subject: Re: [PATCH v3] rust/pl011: Fix DeviceID reads
In-Reply-To: <20241117161039.3758840-1-manos.pitsidianakis@linaro.org> (Manos
 Pitsidianakis's message of "Sun, 17 Nov 2024 18:10:36 +0200")
References: <20241117161039.3758840-1-manos.pitsidianakis@linaro.org>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Mon, 18 Nov 2024 11:40:54 +0000
Message-ID: <875xoku5vd.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x233.google.com
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

Manos Pitsidianakis <manos.pitsidianakis@linaro.org> writes:

> DeviceId, which maps the peripheral and PCell registers of a PL011
> device, was not treating each register value as a 32 bit value.
>
> Change DeviceId enum to return register values via constified getter
> functions instead of leveraging the std::ops::Index<_> trait.
>
> While at it, print errors when guest attempts to write to other RO
> registers as well.
>
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>
> Notes:
>     Changes from v2:
>=20=20=20=20=20
>     - Group invalid write case matches (Paolo)
>     - Reduce register getter line count to aid review (Peter Maydell)
>=20=20=20=20=20
<snip>
> diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/de=
vice.rs
> index 2a85960b81..f1d959ca28 100644
> --- a/rust/hw/char/pl011/src/device.rs
> +++ b/rust/hw/char/pl011/src/device.rs
> @@ -5,7 +5,7 @@
>  use core::ptr::{addr_of, addr_of_mut, NonNull};
>  use std::{
>      ffi::CStr,
> -    os::raw::{c_int, c_uchar, c_uint, c_void},
> +    os::raw::{c_int, c_uint, c_void},
>  };
>=20=20
>  use qemu_api::{
> @@ -32,6 +32,7 @@
>  /// QEMU sourced constant.
>  pub const PL011_FIFO_DEPTH: usize =3D 16_usize;
>=20=20
> +/// State enum that represents the values of the peripheral and PCell re=
gisters of a PL011 device.
>  #[derive(Clone, Copy, Debug)]
>  enum DeviceId {
>      #[allow(dead_code)]
> @@ -39,20 +40,51 @@ enum DeviceId {
>      Luminary,
>  }
>=20=20
> -impl std::ops::Index<hwaddr> for DeviceId {
> -    type Output =3D c_uchar;
> +macro_rules! pcell_reg_getter {
> +    ($($(#[$attrs:meta])* fn $getter_fn:ident -> $value:literal),*$(,)?)=
 =3D> {
> +        $($(#[$attrs])* const fn $getter_fn(self) -> u64 { $value })*
> +    };
> +}
>=20=20
> -    fn index(&self, idx: hwaddr) -> &Self::Output {
> -        match self {
> -            Self::Arm =3D> &Self::PL011_ID_ARM[idx as usize],
> -            Self::Luminary =3D> &Self::PL011_ID_LUMINARY[idx as usize],
> -        }
> -    }
> +macro_rules! periph_reg_getter {
> +    ($($(#[$attrs:meta])* fn $getter_fn:ident -> { Arm =3D> $arm:literal=
, Luminary =3D> $lum:literal$(,)?}),*$(,)?) =3D> {
> +        $(
> +            $(#[$attrs])*
> +            const fn $getter_fn(self) -> u64 {
> +                (match self {
> +                    Self::Arm =3D> $arm,
> +                    Self::Luminary =3D> $lum,
> +                }) as u64
> +            }
> +        )*
> +    };
>  }
>=20=20
>  impl DeviceId {
> -    const PL011_ID_ARM: [c_uchar; 8] =3D [0x11, 0x10, 0x14, 0x00, 0x0d, =
0xf0, 0x05, 0xb1];
> -    const PL011_ID_LUMINARY: [c_uchar; 8] =3D [0x11, 0x00, 0x18, 0x01, 0=
x0d, 0xf0, 0x05, 0xb1];
> +    /// Value of `UARTPeriphID0` register, which contains the `PartNumbe=
r0` value.
> +    const fn uart_periph_id0(self) -> u64 {
> +        0x11
> +    }
> +
> +    periph_reg_getter! {
> +        /// Value of `UARTPeriphID1` register, which contains the `Desig=
ner0` and `PartNumber1` values.
> +        fn uart_periph_id1 -> { Arm =3D> 0x10, Luminary =3D> 0x00 },
> +        /// Value of `UARTPeriphID2` register, which contains the `Revis=
ion` and `Designer1` values.
> +        fn uart_periph_id2 -> { Arm =3D> 0x14, Luminary =3D> 0x18 },
> +        /// Value of `UARTPeriphID3` register, which contains the `Confi=
guration` value.
> +        fn uart_periph_id3 -> { Arm =3D> 0x0, Luminary =3D> 0x1 }
> +    }
> +
> +    pcell_reg_getter! {
> +        /// Value of `UARTPCellID0` register.
> +        fn uart_pcell_id0 -> 0x0d,
> +        /// Value of `UARTPCellID1` register.
> +        fn uart_pcell_id1 -> 0xf0,
> +        /// Value of `UARTPCellID2` register.
> +        fn uart_pcell_id2 -> 0x05,
> +        /// Value of `UARTPCellID3` register.
> +        fn uart_pcell_id3 -> 0xb1,
> +    }

I share the concern that this is quite a verbose way of handling a
fairly simple set of read-only constants. Is the end result really
folded away to a simple const lookup?

Perhaps this comes down to unfamiliarity with the way macros are working
here but in general macros should be eliding boilerplate to allow us to
concisely represent the relevant data and functionality. Here it adds an
additional indirection when reading the code just to see what is going
on.

>  }
>=20=20
>  #[repr(C)]
> @@ -182,9 +214,14 @@ pub fn read(&mut self, offset: hwaddr, _size: c_uint=
) -> std::ops::ControlFlow<u
>          use RegisterOffset::*;
>=20=20
>          std::ops::ControlFlow::Break(match RegisterOffset::try_from(offs=
et) {
> -            Err(v) if (0x3f8..0x400).contains(&v) =3D> {
> -                u64::from(self.device_id[(offset - 0xfe0) >> 2])
> -            }
> +            Ok(PeriphID0) =3D> self.device_id.uart_periph_id0(),
> +            Ok(PeriphID1) =3D> self.device_id.uart_periph_id1(),
> +            Ok(PeriphID2) =3D> self.device_id.uart_periph_id2(),
> +            Ok(PeriphID3) =3D> self.device_id.uart_periph_id3(),
> +            Ok(PCellID0) =3D> self.device_id.uart_pcell_id0(),
> +            Ok(PCellID1) =3D> self.device_id.uart_pcell_id1(),
> +            Ok(PCellID2) =3D> self.device_id.uart_pcell_id2(),
> +            Ok(PCellID3) =3D> self.device_id.uart_pcell_id3(),
>              Err(_) =3D> {
>                  // qemu_log_mask(LOG_GUEST_ERROR, "pl011_read: Bad offse=
t 0x%x\n", (int)offset);
>                  0
> @@ -236,9 +273,15 @@ pub fn write(&mut self, offset: hwaddr, value: u64) {
>          use RegisterOffset::*;
>          let value: u32 =3D value as u32;
>          match RegisterOffset::try_from(offset) {
> -            Err(_bad_offset) =3D> {
> +            Err(_) =3D> {
>                  eprintln!("write bad offset {offset} value {value}");
>              }
> +            Ok(
> +                dev_id @ (PeriphID0 | PeriphID1 | PeriphID2 | PeriphID3 =
| PCellID0 | PCellID1
> +                | PCellID2 | PCellID3 | FR | RIS | MIS),
> +            ) =3D> {

This is a nice improvement in conciseness over the separate legs removed be=
llow.

> +                eprintln!("write bad offset {offset} at RO register {dev=
_id:?} value {value}");
> +            }

Is a binding for qemu_log and friends on the todo list?

>              Ok(DR) =3D> {
>                  // ??? Check if transmitter is enabled.
>                  let ch: u8 =3D value as u8;
> @@ -257,9 +300,6 @@ pub fn write(&mut self, offset: hwaddr, value: u64) {
>              Ok(RSR) =3D> {
>                  self.receive_status_error_clear =3D 0.into();
>              }
> -            Ok(FR) =3D> {
> -                // flag writes are ignored
> -            }
>              Ok(ILPR) =3D> {
>                  self.ilpr =3D value;
>              }
> @@ -308,8 +348,6 @@ pub fn write(&mut self, offset: hwaddr, value: u64) {
>                  self.int_enabled =3D value;
>                  self.update();
>              }
> -            Ok(RIS) =3D> {}
> -            Ok(MIS) =3D> {}
>              Ok(ICR) =3D> {
>                  self.int_level &=3D !value;
>                  self.update();
> diff --git a/rust/hw/char/pl011/src/lib.rs b/rust/hw/char/pl011/src/lib.rs
> index cd0a49acb9..1f305aa13f 100644
> --- a/rust/hw/char/pl011/src/lib.rs
> +++ b/rust/hw/char/pl011/src/lib.rs
> @@ -111,6 +111,22 @@ pub enum RegisterOffset {
>      /// DMA control Register
>      #[doc(alias =3D "UARTDMACR")]
>      DMACR =3D 0x048,
> +    #[doc(alias =3D "UARTPeriphID0")]
> +    PeriphID0 =3D 0xFE0,
> +    #[doc(alias =3D "UARTPeriphID1")]
> +    PeriphID1 =3D 0xFE4,
> +    #[doc(alias =3D "UARTPeriphID2")]
> +    PeriphID2 =3D 0xFE8,
> +    #[doc(alias =3D "UARTPeriphID3")]
> +    PeriphID3 =3D 0xFEC,
> +    #[doc(alias =3D "UARTPCellID0")]
> +    PCellID0 =3D 0xFF0,
> +    #[doc(alias =3D "UARTPCellID1")]
> +    PCellID1 =3D 0xFF4,
> +    #[doc(alias =3D "UARTPCellID2")]
> +    PCellID2 =3D 0xFF8,
> +    #[doc(alias =3D "UARTPCellID3")]
> +    PCellID3 =3D 0xFFC,

Why do we have specific doc aliases rather than just naming the
registers with the full name?

>      ///// Reserved, offsets `0x04C` to `0x07C`.
>      //Reserved =3D 0x04C,
>  }
> @@ -137,7 +153,11 @@ const fn _assert_exhaustive(val: RegisterOffset) {
>                  }
>              }
>          }
> -        case! { DR, RSR, FR, FBRD, ILPR, IBRD, LCR_H, CR, FLS, IMSC, RIS=
, MIS, ICR, DMACR }
> +        case! {
> +            DR, RSR, FR, FBRD, ILPR, IBRD, LCR_H, CR, FLS, IMSC, RIS, MI=
S, ICR, DMACR,
> +            PeriphID0, PeriphID1, PeriphID2, PeriphID3,
> +            PCellID0, PCellID1, PCellID2, PCellID3,
> +        }
>      }
>  }
>=20=20
>
> base-commit: 43f2def68476697deb0d119cbae51b20019c6c86

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

