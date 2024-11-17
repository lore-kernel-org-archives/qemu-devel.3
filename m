Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BD75D68BF2
	for <qemu-devel@archiver.kernel.org>; Sun, 17 Nov 2024 10:05:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tCc8Y-0006av-Dv; Sun, 17 Nov 2024 05:04:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1tCc8W-0006Zw-Sn
 for qemu-devel@nongnu.org; Sun, 17 Nov 2024 05:04:08 -0500
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1tCc8T-0001i2-Kx
 for qemu-devel@nongnu.org; Sun, 17 Nov 2024 05:04:08 -0500
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a9e71401844so279528966b.3
 for <qemu-devel@nongnu.org>; Sun, 17 Nov 2024 02:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731837843; x=1732442643; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2L58zJzLrmBSxgjVBQyhgv0wYDJTdgfsrTPcv1081sE=;
 b=e9pDCBYVxymwrRv8NoBZHkPgHuAlzwK0aV2nb7mWmNJEAGiNkwP2DsybZurtvt7HOQ
 IxLNPzfr8xUQGVF4AsgkKI6dF+y7vCwQPMNfd+FvmZyt2xdz4jOZ3cmlW5IBdmDj5Kce
 iGVpw5GQvp/t0aNIdSpOnPsj2amjEZhgQaQVR5tla7GbiN5lcCsiRoNkDL3t5t7jF8gm
 /xvq2g6IZBU4G5yAwOU2SWMTmly5bqwM4xJpR5VPE9rQXklNxYsu8GnpQ/nwpx/TXt/V
 FvO1rXeb5rTsuWlb5ZsivuB7peeNFQ3J1xEPOH/QpHsMQbAbCI3EDiFPyQG758l6ofI8
 +lcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731837843; x=1732442643;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2L58zJzLrmBSxgjVBQyhgv0wYDJTdgfsrTPcv1081sE=;
 b=i8xtwRiTBCKbQbmjBalWVIHIPmEBu0VKuC+rJbuTPp763bx8FW8rFLduHcm2Mz8mFa
 TNKEOtmD4BwVfkdgWw5IgcWQPy6oWdjmxHV3wsV4nv3FXbxoyHviD1SkMRk6h6+u7Bv8
 RAyLWRSZ1CDtuFRGbdiIChr7qzy2Ey+yshv0Et1/RZGkgRO4CZrnd24g24cSWGDrWW73
 /VnzbMx7uAjxR8gwIXtz16HGvL8hneGIGQDNuzdJ+4vwaI2oqtA2I071k2hvhlSnWv56
 2t5l/Sh+Ry5fkbBIc54cW+x5fdxihHp2Z1nUWjQ1sctngTnd4shzm3R8hDm7EDfmm3v+
 uWvg==
X-Gm-Message-State: AOJu0YzoiGqC5lVnZ9t7C9HiNKk3WAqjn7H3M2JCzMpa65h8S26yj16i
 p+ZwKbiCXNjKAK34EJzoa0ZeZIcAVEi/JStlczLQ4NAbXLQWF9WWbdOOxWmTcVTZWiRbuVZEDB4
 TZ9Rqldd4CE48YuvDQl8CJuUTheAlP16b7avigA==
X-Google-Smtp-Source: AGHT+IH2wfXxpLdJxHRz9ANpN672+lNx3dMq5ieC+NJ0Zh4PRw9oxV5eUvoMuVAz1q9BRA+rrbEc70SiNSXw8/gWWSQ=
X-Received: by 2002:a17:906:dc8f:b0:a9a:3e33:8d9e with SMTP id
 a640c23a62f3a-aa48344ea5dmr708659066b.28.1731837843192; Sun, 17 Nov 2024
 02:04:03 -0800 (PST)
MIME-Version: 1.0
References: <20241116221757.3501603-1-manos.pitsidianakis@linaro.org>
 <CABgObfa8Qx7RzZK=VLFmsiEM=ExDb4T1WS4WzYc6D3ACuwc3fw@mail.gmail.com>
In-Reply-To: <CABgObfa8Qx7RzZK=VLFmsiEM=ExDb4T1WS4WzYc6D3ACuwc3fw@mail.gmail.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Sun, 17 Nov 2024 12:03:37 +0200
Message-ID: <CAAjaMXZ2GscKdUNrtP_YU0Lq49xzKmNCozYW-NMhBgw3eEmFYw@mail.gmail.com>
Subject: Re: [PATCH v2] rust/pl011: Fix DeviceID reads
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 qemu-rust@nongnu.org, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x631.google.com
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

On Sun, Nov 17, 2024 at 9:40=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
>
>
> Il sab 16 nov 2024, 23:18 Manos Pitsidianakis <manos.pitsidianakis@linaro=
.org> ha scritto:
>>
>> -    const PL011_ID_ARM: [c_uchar; 8] =3D [0x11, 0x10, 0x14, 0x00, 0x0d,=
 0xf0, 0x05, 0xb1];
>> -    const PL011_ID_LUMINARY: [c_uchar; 8] =3D [0x11, 0x00, 0x18, 0x01, =
0x0d, 0xf0, 0x05, 0xb1];
>> +    /// Value of `UARTPeriphID0` register, which contains the `PartNumb=
er0` value.
>> +    const fn uart_periph_id0(self) -> u64 {
>> +        0x11
>> +    }
>> +
>> +    /// Value of `UARTPeriphID1` register, which contains the `Designer=
0` and `PartNumber1` values.
>> +    const fn uart_periph_id1(self) -> u64 {
>> +        (match self {
>> +            Self::Arm =3D> 0x10,
>> +            Self::Luminary =3D> 0x00,
>> +        }) as u64
>> +    }
>> +
>> +    /// Value of `UARTPeriphID2` register, which contains the `Revision=
` and `Designer1` values.
>> +    const fn uart_periph_id2(self) -> u64 {
>> +        (match self {
>> +            Self::Arm =3D> 0x14,
>> +            Self::Luminary =3D> 0x18,
>> +        }) as u64
>> +    }
>> +
>> +    /// Value of `UARTPeriphID3` register, which contains the `Configur=
ation` value.
>> +    const fn uart_periph_id3(self) -> u64 {
>> +        (match self {
>> +            Self::Arm =3D> 0x0,
>> +            Self::Luminary =3D> 0x1,
>> +        }) as u64
>> +    }
>> +
>> +    /// Value of `UARTPCellID0` register.
>> +    const fn uart_pcell_id0(self) -> u64 {
>> +        0x0d
>> +    }
>> +
>> +    /// Value of `UARTPCellID1` register.
>> +    const fn uart_pcell_id1(self) -> u64 {
>> +        0xf0
>> +    }
>> +
>> +    /// Value of `UARTPCellID2` register.
>> +    const fn uart_pcell_id2(self) -> u64 {
>> +        0x05
>> +    }
>> +
>> +    /// Value of `UARTPCellID3` register.
>> +    const fn uart_pcell_id3(self) -> u64 {
>> +        0xb1
>> +    }
>>  }
>
>
> In your reply to V1 you wrote:
>
> > Eh, there's no real reason to do that though. I prefer verbosity and
> > static checking with symbols rather than indexing; we're not writing C
> > here.
>
> I don't see what C has to do with it. Of the three extant options for Dev=
iceId, you can write them in both C and Rust and they would look pretty muc=
h the same.
>
> I explained the real reason: it's much harder to verify/review the correc=
tness of independent functions instead of two arrays of four elements, beca=
use consecutive elements are four-five lines apart. There is also a lot mor=
e repetition in writing four match expressions instead of one.
>
> Given Peter's remark on rejecting writes, personally I see no reason to s=
witch away from Index; but I understand that you felt it was an important c=
hange, so I am trying very hard to find a middle ground that is more readab=
le than both the old code and your proposal here, and combines the advantag=
es of both. Please try to listen.

I very much prefer it this way; the only reason it was Index before
was because the DEVICE_ID arrays were lifted verbatim from C code. I
disagree that these are reasonable requests for code change, sorry.

>
>>          match RegisterOffset::try_from(offset) {
>> -            Err(_bad_offset) =3D> {
>> +            Err(_) =3D> {
>>                  eprintln!("write bad offset {offset} value {value}");
>>              }
>> +            Ok(
>> +                dev_id @ (PeriphID0 | PeriphID1 | PeriphID2 | PeriphID3=
 | PCellID0 | PCellID1
>> +                | PCellID2 | PCellID3),
>> +            ) =3D> {
>> +                eprintln!("write bad offset {offset} at RO register {de=
v_id:?} value {value}");
>> +            }
>>              Ok(FR) =3D> {
>> -                // flag writes are ignored
>> +                eprintln!("write bad offset {offset} at RO register UAR=
TFR value {value}");
>>              }
>> -            Ok(RIS) =3D> {}
>> -            Ok(MIS) =3D> {}
>> +            Ok(RIS) =3D> {
>> +                eprintln!("write bad offset {offset} at RO register UAR=
TRIS value {value}");
>> +            }
>> +            Ok(MIS) =3D> {
>> +                eprintln!("write bad offset {offset} at RO register UAR=
TMIS value {value}");
>> +            }
>
>
> Please use a single "dev_id @ (...)" pattern instead of duplicating code.
>
> Paolo
>
>>              Ok(ICR) =3D> {
>>                  self.int_level &=3D !value;
>>                  self.update();
>> diff --git a/rust/hw/char/pl011/src/lib.rs b/rust/hw/char/pl011/src/lib.=
rs
>> index cd0a49acb9..1f305aa13f 100644
>> --- a/rust/hw/char/pl011/src/lib.rs
>> +++ b/rust/hw/char/pl011/src/lib.rs
>> @@ -111,6 +111,22 @@ pub enum RegisterOffset {
>>      /// DMA control Register
>>      #[doc(alias =3D "UARTDMACR")]
>>      DMACR =3D 0x048,
>> +    #[doc(alias =3D "UARTPeriphID0")]
>> +    PeriphID0 =3D 0xFE0,
>> +    #[doc(alias =3D "UARTPeriphID1")]
>> +    PeriphID1 =3D 0xFE4,
>> +    #[doc(alias =3D "UARTPeriphID2")]
>> +    PeriphID2 =3D 0xFE8,
>> +    #[doc(alias =3D "UARTPeriphID3")]
>> +    PeriphID3 =3D 0xFEC,
>> +    #[doc(alias =3D "UARTPCellID0")]
>> +    PCellID0 =3D 0xFF0,
>> +    #[doc(alias =3D "UARTPCellID1")]
>> +    PCellID1 =3D 0xFF4,
>> +    #[doc(alias =3D "UARTPCellID2")]
>> +    PCellID2 =3D 0xFF8,
>> +    #[doc(alias =3D "UARTPCellID3")]
>> +    PCellID3 =3D 0xFFC,
>>      ///// Reserved, offsets `0x04C` to `0x07C`.
>>      //Reserved =3D 0x04C,
>>  }
>> @@ -137,7 +153,11 @@ const fn _assert_exhaustive(val: RegisterOffset) {
>>                  }
>>              }
>>          }
>> -        case! { DR, RSR, FR, FBRD, ILPR, IBRD, LCR_H, CR, FLS, IMSC, RI=
S, MIS, ICR, DMACR }
>> +        case! {
>> +            DR, RSR, FR, FBRD, ILPR, IBRD, LCR_H, CR, FLS, IMSC, RIS, M=
IS, ICR, DMACR,
>> +            PeriphID0, PeriphID1, PeriphID2, PeriphID3,
>> +            PCellID0, PCellID1, PCellID2, PCellID3,
>> +        }
>>      }
>>  }
>>
>>
>> base-commit: 43f2def68476697deb0d119cbae51b20019c6c86
>> --
>> =CE=B3=CE=B1=E1=BF=96=CE=B1 =CF=80=CF=85=CF=81=CE=AF =CE=BC=CE=B9=CF=87=
=CE=B8=CE=AE=CF=84=CF=89
>>
>>

