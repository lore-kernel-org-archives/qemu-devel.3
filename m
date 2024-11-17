Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC60ED68BF2
	for <qemu-devel@archiver.kernel.org>; Sun, 17 Nov 2024 10:15:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tCcIo-0008Nx-53; Sun, 17 Nov 2024 05:14:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tCcIm-0008NY-JJ
 for qemu-devel@nongnu.org; Sun, 17 Nov 2024 05:14:44 -0500
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tCcIk-0002cF-5a
 for qemu-devel@nongnu.org; Sun, 17 Nov 2024 05:14:43 -0500
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a9ef275b980so368697966b.0
 for <qemu-devel@nongnu.org>; Sun, 17 Nov 2024 02:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731838480; x=1732443280; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mHeEnxj6FSVQ9gUgCmwZgAJaHnlsmHPOgpH2cS45R5c=;
 b=quyvPS8Iz9WpQf9sCnpsEhuO2UCEqZ+odnfOTMbVnZ5GRj0QzHf6XNv7wNYrzpsmi9
 NNtlQkK0B+1TsDVuq6zQcAR/Nz7ObwM2pAqGnqlCMS44fiyu09/iPcRHLJkDAo3k1C4e
 yl9Q3EvHOKImjIy+lyKwEytGr2u8WDuSHwQtR0qWJ1EJ2COP/sDjAdD8vdYH5IkTyzxQ
 IJiJC0AMJkr1rVDJmSO/md8Xs8STJVpB8B+olRhNZC0KWGxkJh6ojMdn6Qpf0lNodclh
 FVcER1tufPpiDnH4aamIUCXiGS2saBe6kt9hStngXuGO/jLWTkKDfMTiiWbRG7EjJaRL
 kyDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731838480; x=1732443280;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mHeEnxj6FSVQ9gUgCmwZgAJaHnlsmHPOgpH2cS45R5c=;
 b=j1wPkDqPZ3HBcIkYTQB9ssg3Lmz6CJMdBvyID0zUVTtw4zPVO0ZZAJP3Ik5XWQoTDk
 ovOGFAxV28f3GjD2u2UlGV7yglKzBVYqXXjbUW62CLSKPl1EY2ZJm9nlBiFx51oGZg2L
 WvW1I73KlGlh/+GgR7P0x4W20mjiz16I7/VpiXQE9Ryb6XVfvkh1dBaJh2fUDWvZZwH2
 S3t8RhAjHd1nOFujPlkh84JMM8odlIbd5snB3DY7URjghrd0Vx1dU+Ry7k90OVoJPVtd
 WiaU5bEt8/ZxaQ/V5TIfeAfgkRx+Ke9+9D5/+qz7Na7L2Waa88oAZloAIy+n67dh/0P0
 /4aw==
X-Gm-Message-State: AOJu0Yz6LL2W/J8BsArcIQNB+hETb+r1wuctsqO5z/+K/2SKsS4BFtuC
 tPyTAqKAQzQZYW7625a/2vj2CjrewfE1Kn8W173pqNUv3PW0nYvyza1nhORU877S3pCtyxfExts
 uk4nv1Pu15gSN/dcYhQc5sItJBsiUdumyh0oL4w==
X-Google-Smtp-Source: AGHT+IF4++eWbTfA40zWMpS3vmibIp4IDq+JiEvZyxqVV7nQY+5tBZ+0tdFgcye7beqVKwh/xEIzBEetZgq4lTEq++w=
X-Received: by 2002:a17:907:1b2a:b0:a9d:e1d6:41fc with SMTP id
 a640c23a62f3a-aa48354d137mr846122666b.53.1731838479814; Sun, 17 Nov 2024
 02:14:39 -0800 (PST)
MIME-Version: 1.0
References: <20241116221757.3501603-1-manos.pitsidianakis@linaro.org>
In-Reply-To: <20241116221757.3501603-1-manos.pitsidianakis@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 17 Nov 2024 10:14:29 +0000
Message-ID: <CAFEAcA9m7EnMX+=T0TL2R_NCJqaPUPCUcoYzAo4P2oRUZbM6Kg@mail.gmail.com>
Subject: Re: [PATCH v2] rust/pl011: Fix DeviceID reads
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-rust@nongnu.org, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62d.google.com
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

On Sat, 16 Nov 2024 at 22:18, Manos Pitsidianakis
<manos.pitsidianakis@linaro.org> wrote:
>
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



>  rust/hw/char/pl011/src/device.rs | 93 ++++++++++++++++++++++++--------
>  rust/hw/char/pl011/src/lib.rs    | 22 +++++++-
>  2 files changed, 93 insertions(+), 22 deletions(-)
>
> diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
> index 2a85960b81..fc6f3f394d 100644
> --- a/rust/hw/char/pl011/src/device.rs
> +++ b/rust/hw/char/pl011/src/device.rs
> @@ -5,7 +5,7 @@
>  use core::ptr::{addr_of, addr_of_mut, NonNull};
>  use std::{
>      ffi::CStr,
> -    os::raw::{c_int, c_uchar, c_uint, c_void},
> +    os::raw::{c_int, c_uint, c_void},
>  };
>
>  use qemu_api::{
> @@ -32,6 +32,7 @@
>  /// QEMU sourced constant.
>  pub const PL011_FIFO_DEPTH: usize = 16_usize;
>
> +/// State enum that represents the values of the peripheral and PCell registers of a PL011 device.
>  #[derive(Clone, Copy, Debug)]
>  enum DeviceId {
>      #[allow(dead_code)]
> @@ -39,20 +40,55 @@ enum DeviceId {
>      Luminary,
>  }
>
> -impl std::ops::Index<hwaddr> for DeviceId {
> -    type Output = c_uchar;
> -
> -    fn index(&self, idx: hwaddr) -> &Self::Output {
> -        match self {
> -            Self::Arm => &Self::PL011_ID_ARM[idx as usize],
> -            Self::Luminary => &Self::PL011_ID_LUMINARY[idx as usize],
> -        }
> -    }
> -}
> -
>  impl DeviceId {
> -    const PL011_ID_ARM: [c_uchar; 8] = [0x11, 0x10, 0x14, 0x00, 0x0d, 0xf0, 0x05, 0xb1];
> -    const PL011_ID_LUMINARY: [c_uchar; 8] = [0x11, 0x00, 0x18, 0x01, 0x0d, 0xf0, 0x05, 0xb1];
> +    /// Value of `UARTPeriphID0` register, which contains the `PartNumber0` value.
> +    const fn uart_periph_id0(self) -> u64 {
> +        0x11
> +    }
> +
> +    /// Value of `UARTPeriphID1` register, which contains the `Designer0` and `PartNumber1` values.
> +    const fn uart_periph_id1(self) -> u64 {
> +        (match self {
> +            Self::Arm => 0x10,
> +            Self::Luminary => 0x00,
> +        }) as u64
> +    }
> +
> +    /// Value of `UARTPeriphID2` register, which contains the `Revision` and `Designer1` values.
> +    const fn uart_periph_id2(self) -> u64 {
> +        (match self {
> +            Self::Arm => 0x14,
> +            Self::Luminary => 0x18,
> +        }) as u64
> +    }
> +
> +    /// Value of `UARTPeriphID3` register, which contains the `Configuration` value.
> +    const fn uart_periph_id3(self) -> u64 {
> +        (match self {
> +            Self::Arm => 0x0,
> +            Self::Luminary => 0x1,
> +        }) as u64
> +    }
> +
> +    /// Value of `UARTPCellID0` register.
> +    const fn uart_pcell_id0(self) -> u64 {
> +        0x0d
> +    }
> +
> +    /// Value of `UARTPCellID1` register.
> +    const fn uart_pcell_id1(self) -> u64 {
> +        0xf0
> +    }
> +
> +    /// Value of `UARTPCellID2` register.
> +    const fn uart_pcell_id2(self) -> u64 {
> +        0x05
> +    }
> +
> +    /// Value of `UARTPCellID3` register.
> +    const fn uart_pcell_id3(self) -> u64 {
> +        0xb1
> +    }

This seems extremely verbose and rather obscures the fact that these
registers are a set of adjacent simple ID registers, compared to
the previous code which defined them as an array of values.

Isn't there some way to write this that doesn't need so much code to do it?
All the PLxxx devices and various others have this set of standard
ID registers, because it's part of a standardized scheme, so we're
going to end up with similar code in multiple device models. I would
hope that Rust offers us ways to avoid having boilerplate code
where you need to write dozens of lines to express this.

thanks
-- PMM

