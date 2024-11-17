Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FFA0D68BF2
	for <qemu-devel@archiver.kernel.org>; Sun, 17 Nov 2024 10:22:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tCcOt-00017E-2m; Sun, 17 Nov 2024 05:21:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1tCcOj-00015b-9S
 for qemu-devel@nongnu.org; Sun, 17 Nov 2024 05:20:53 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1tCcOg-000446-LJ
 for qemu-devel@nongnu.org; Sun, 17 Nov 2024 05:20:52 -0500
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a9aa8895facso592449466b.2
 for <qemu-devel@nongnu.org>; Sun, 17 Nov 2024 02:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731838848; x=1732443648; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5TFie3jflLdTWu1yrKd+zm0CeFLD0NoKa4Ds0DfigUY=;
 b=t6xdFnIye1SsQhoTwPlBDKtu43PdBoIMeRbljlV7S1lTEayc8hYywd6VPb/cYAjk0T
 xbDr6P4CpnluPbLyVpRKN/qkmgcyLAnYeXr0uYjH5tpnVNTdTnS9LvDEBcQrKRkyb+9l
 676YnTAZjHPjn2eF3qFO8DIjN6q9zxtEzhij63BM/2vE11zSh3aRLSaJc49eVn61hL/2
 +XzXkkKrrQ1W3n4MVbLgaWfgbuCTnG7J5js7+JaRhYLPuGLSnL/sWPrWdf4QLeF0Ci95
 weDzHBD+uNAnl2ct8eIMFgrOEVThCHN7GbbeJA4Yc5uslNj/YHhXwr2chKFvhr66gZRY
 +fSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731838848; x=1732443648;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5TFie3jflLdTWu1yrKd+zm0CeFLD0NoKa4Ds0DfigUY=;
 b=OBBqv67nExyz+poFWcRp4r9F7tYZeEHUT3QGqxkmFWtISPkXl2awjauyiqkSCOCfyV
 Evl9+wHbONOhRq10+YOo0wcOYyg8sdpM/akMlZV3uHf5k57HIH66vsHmmIKxwUObD4Fi
 +uQc1ifStJnx7eXbwaaYi6v5k+TtYzYKWqJkb1JEQJgPNR8LJQejX36M/P/kbW6G1joj
 nSEI52B9xWJsQPsz3nba1HCHNYnl2QNFzCpR9xIu7iI37I2X+4q/Nkf8Ss0lNZJbUDPZ
 S0t0aCHbiIfd+HPumEv8LoaNdXL0V3rPYUwoWrehLD6yBe0TDvO5PiMZQg1iMUeGvbDf
 YNeA==
X-Gm-Message-State: AOJu0YwwSR/8U0hcm8xEg93UP7R1W/wgZvrj0XSZw8e7Eh8IZmZyV1rU
 YTPh9zKlWojraQZsUESbfZLwFBEQSAB18haW8oVwM3uQCFCNi+RfEjEByma3eZRAxqLZot1E3Tn
 w/rLCnZBazppCDoA6ZVhp2CiLxInYxJkPwDYexw==
X-Google-Smtp-Source: AGHT+IHdu/CFI1ysFJWFGIZRibMDNuA7EEvc2+XuiqkNnAO5db6DIx65j/F7HA9s9K5WsvKqGn+S7WwHik5Phco1V4s=
X-Received: by 2002:a17:907:96ab:b0:a99:ec3c:15cd with SMTP id
 a640c23a62f3a-aa483552e2amr797050466b.54.1731838848335; Sun, 17 Nov 2024
 02:20:48 -0800 (PST)
MIME-Version: 1.0
References: <20241116221757.3501603-1-manos.pitsidianakis@linaro.org>
 <CAFEAcA9m7EnMX+=T0TL2R_NCJqaPUPCUcoYzAo4P2oRUZbM6Kg@mail.gmail.com>
In-Reply-To: <CAFEAcA9m7EnMX+=T0TL2R_NCJqaPUPCUcoYzAo4P2oRUZbM6Kg@mail.gmail.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Sun, 17 Nov 2024 12:20:37 +0200
Message-ID: <CAAjaMXZE+KKJnvcMpmpaH+dmO7MQVmJm7pD+i1yo_5Wb9-ERcQ@mail.gmail.com>
Subject: Re: [PATCH v2] rust/pl011: Fix DeviceID reads
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "open list:ARM SMMU <qemu-arm@nongnu.org>, " <qemu-devel@nongnu.org>,
 "open list:ARM SMMU" <qemu-arm@nongnu.org>, qemu-rust@nongnu.org, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000005d20b80627192758"
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
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

--0000000000005d20b80627192758
Content-Type: text/plain; charset="UTF-8"

On Sun, Nov 17, 2024, 12:14 PM Peter Maydell <peter.maydell@linaro.org>
wrote:

> On Sat, 16 Nov 2024 at 22:18, Manos Pitsidianakis
> <manos.pitsidianakis@linaro.org> wrote:
> >
> > DeviceId, which maps the peripheral and PCell registers of a PL011
> > device, was not treating each register value as a 32 bit value.
> >
> > Change DeviceId enum to return register values via constified getter
> > functions instead of leveraging the std::ops::Index<_> trait.
> >
> > While at it, print errors when guest attempts to write to other RO
> > registers as well.
> >
> > Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>
>
>
> >  rust/hw/char/pl011/src/device.rs | 93 ++++++++++++++++++++++++--------
> >  rust/hw/char/pl011/src/lib.rs    | 22 +++++++-
> >  2 files changed, 93 insertions(+), 22 deletions(-)
> >
> > diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/
> device.rs
> > index 2a85960b81..fc6f3f394d 100644
> > --- a/rust/hw/char/pl011/src/device.rs
> > +++ b/rust/hw/char/pl011/src/device.rs
> > @@ -5,7 +5,7 @@
> >  use core::ptr::{addr_of, addr_of_mut, NonNull};
> >  use std::{
> >      ffi::CStr,
> > -    os::raw::{c_int, c_uchar, c_uint, c_void},
> > +    os::raw::{c_int, c_uint, c_void},
> >  };
> >
> >  use qemu_api::{
> > @@ -32,6 +32,7 @@
> >  /// QEMU sourced constant.
> >  pub const PL011_FIFO_DEPTH: usize = 16_usize;
> >
> > +/// State enum that represents the values of the peripheral and PCell
> registers of a PL011 device.
> >  #[derive(Clone, Copy, Debug)]
> >  enum DeviceId {
> >      #[allow(dead_code)]
> > @@ -39,20 +40,55 @@ enum DeviceId {
> >      Luminary,
> >  }
> >
> > -impl std::ops::Index<hwaddr> for DeviceId {
> > -    type Output = c_uchar;
> > -
> > -    fn index(&self, idx: hwaddr) -> &Self::Output {
> > -        match self {
> > -            Self::Arm => &Self::PL011_ID_ARM[idx as usize],
> > -            Self::Luminary => &Self::PL011_ID_LUMINARY[idx as usize],
> > -        }
> > -    }
> > -}
> > -
> >  impl DeviceId {
> > -    const PL011_ID_ARM: [c_uchar; 8] = [0x11, 0x10, 0x14, 0x00, 0x0d,
> 0xf0, 0x05, 0xb1];
> > -    const PL011_ID_LUMINARY: [c_uchar; 8] = [0x11, 0x00, 0x18, 0x01,
> 0x0d, 0xf0, 0x05, 0xb1];
> > +    /// Value of `UARTPeriphID0` register, which contains the
> `PartNumber0` value.
> > +    const fn uart_periph_id0(self) -> u64 {
> > +        0x11
> > +    }
> > +
> > +    /// Value of `UARTPeriphID1` register, which contains the
> `Designer0` and `PartNumber1` values.
> > +    const fn uart_periph_id1(self) -> u64 {
> > +        (match self {
> > +            Self::Arm => 0x10,
> > +            Self::Luminary => 0x00,
> > +        }) as u64
> > +    }
> > +
> > +    /// Value of `UARTPeriphID2` register, which contains the
> `Revision` and `Designer1` values.
> > +    const fn uart_periph_id2(self) -> u64 {
> > +        (match self {
> > +            Self::Arm => 0x14,
> > +            Self::Luminary => 0x18,
> > +        }) as u64
> > +    }
> > +
> > +    /// Value of `UARTPeriphID3` register, which contains the
> `Configuration` value.
> > +    const fn uart_periph_id3(self) -> u64 {
> > +        (match self {
> > +            Self::Arm => 0x0,
> > +            Self::Luminary => 0x1,
> > +        }) as u64
> > +    }
> > +
> > +    /// Value of `UARTPCellID0` register.
> > +    const fn uart_pcell_id0(self) -> u64 {
> > +        0x0d
> > +    }
> > +
> > +    /// Value of `UARTPCellID1` register.
> > +    const fn uart_pcell_id1(self) -> u64 {
> > +        0xf0
> > +    }
> > +
> > +    /// Value of `UARTPCellID2` register.
> > +    const fn uart_pcell_id2(self) -> u64 {
> > +        0x05
> > +    }
> > +
> > +    /// Value of `UARTPCellID3` register.
> > +    const fn uart_pcell_id3(self) -> u64 {
> > +        0xb1
> > +    }
>
> This seems extremely verbose and rather obscures the fact that these
> registers are a set of adjacent simple ID registers, compared to
> the previous code which defined them as an array of values.
>
> Isn't there some way to write this that doesn't need so much code to do it?
> All the PLxxx devices and various others have this set of standard
> ID registers, because it's part of a standardized scheme, so we're
> going to end up with similar code in multiple device models. I would
> hope that Rust offers us ways to avoid having boilerplate code
> where you need to write dozens of lines to express this.
>
> thanks
> -- PMM
>


One could abstract them with declarative macros to reduce the line count.
WDYT about that approach?

>

--0000000000005d20b80627192758
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Sun, Nov 17, 2024, 12:14 PM Peter Maydell &lt;<a hr=
ef=3D"mailto:peter.maydell@linaro.org">peter.maydell@linaro.org</a>&gt; wro=
te:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Sat, 16 N=
ov 2024 at 22:18, Manos Pitsidianakis<br>
&lt;<a href=3D"mailto:manos.pitsidianakis@linaro.org" target=3D"_blank" rel=
=3D"noreferrer">manos.pitsidianakis@linaro.org</a>&gt; wrote:<br>
&gt;<br>
&gt; DeviceId, which maps the peripheral and PCell registers of a PL011<br>
&gt; device, was not treating each register value as a 32 bit value.<br>
&gt;<br>
&gt; Change DeviceId enum to return register values via constified getter<b=
r>
&gt; functions instead of leveraging the std::ops::Index&lt;_&gt; trait.<br=
>
&gt;<br>
&gt; While at it, print errors when guest attempts to write to other RO<br>
&gt; registers as well.<br>
&gt;<br>
&gt; Signed-off-by: Manos Pitsidianakis &lt;<a href=3D"mailto:manos.pitsidi=
anakis@linaro.org" target=3D"_blank" rel=3D"noreferrer">manos.pitsidianakis=
@linaro.org</a>&gt;<br>
<br>
<br>
<br>
&gt;=C2=A0 rust/hw/char/pl011/src/<a href=3D"http://device.rs" rel=3D"noref=
errer noreferrer" target=3D"_blank">device.rs</a> | 93 ++++++++++++++++++++=
++++--------<br>
&gt;=C2=A0 rust/hw/char/pl011/src/<a href=3D"http://lib.rs" rel=3D"noreferr=
er noreferrer" target=3D"_blank">lib.rs</a>=C2=A0 =C2=A0 | 22 +++++++-<br>
&gt;=C2=A0 2 files changed, 93 insertions(+), 22 deletions(-)<br>
&gt;<br>
&gt; diff --git a/rust/hw/char/pl011/src/<a href=3D"http://device.rs" rel=
=3D"noreferrer noreferrer" target=3D"_blank">device.rs</a> b/rust/hw/char/p=
l011/src/<a href=3D"http://device.rs" rel=3D"noreferrer noreferrer" target=
=3D"_blank">device.rs</a><br>
&gt; index 2a85960b81..fc6f3f394d 100644<br>
&gt; --- a/rust/hw/char/pl011/src/<a href=3D"http://device.rs" rel=3D"noref=
errer noreferrer" target=3D"_blank">device.rs</a><br>
&gt; +++ b/rust/hw/char/pl011/src/<a href=3D"http://device.rs" rel=3D"noref=
errer noreferrer" target=3D"_blank">device.rs</a><br>
&gt; @@ -5,7 +5,7 @@<br>
&gt;=C2=A0 use core::ptr::{addr_of, addr_of_mut, NonNull};<br>
&gt;=C2=A0 use std::{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 ffi::CStr,<br>
&gt; -=C2=A0 =C2=A0 os::raw::{c_int, c_uchar, c_uint, c_void},<br>
&gt; +=C2=A0 =C2=A0 os::raw::{c_int, c_uint, c_void},<br>
&gt;=C2=A0 };<br>
&gt;<br>
&gt;=C2=A0 use qemu_api::{<br>
&gt; @@ -32,6 +32,7 @@<br>
&gt;=C2=A0 /// QEMU sourced constant.<br>
&gt;=C2=A0 pub const PL011_FIFO_DEPTH: usize =3D 16_usize;<br>
&gt;<br>
&gt; +/// State enum that represents the values of the peripheral and PCell=
 registers of a PL011 device.<br>
&gt;=C2=A0 #[derive(Clone, Copy, Debug)]<br>
&gt;=C2=A0 enum DeviceId {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 #[allow(dead_code)]<br>
&gt; @@ -39,20 +40,55 @@ enum DeviceId {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 Luminary,<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt; -impl std::ops::Index&lt;hwaddr&gt; for DeviceId {<br>
&gt; -=C2=A0 =C2=A0 type Output =3D c_uchar;<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 fn index(&amp;self, idx: hwaddr) -&gt; &amp;Self::Outpu=
t {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 match self {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Self::Arm =3D&gt; &amp;Self=
::PL011_ID_ARM[idx as usize],<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Self::Luminary =3D&gt; &amp=
;Self::PL011_ID_LUMINARY[idx as usize],<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; -=C2=A0 =C2=A0 }<br>
&gt; -}<br>
&gt; -<br>
&gt;=C2=A0 impl DeviceId {<br>
&gt; -=C2=A0 =C2=A0 const PL011_ID_ARM: [c_uchar; 8] =3D [0x11, 0x10, 0x14,=
 0x00, 0x0d, 0xf0, 0x05, 0xb1];<br>
&gt; -=C2=A0 =C2=A0 const PL011_ID_LUMINARY: [c_uchar; 8] =3D [0x11, 0x00, =
0x18, 0x01, 0x0d, 0xf0, 0x05, 0xb1];<br>
&gt; +=C2=A0 =C2=A0 /// Value of `UARTPeriphID0` register, which contains t=
he `PartNumber0` value.<br>
&gt; +=C2=A0 =C2=A0 const fn uart_periph_id0(self) -&gt; u64 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x11<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /// Value of `UARTPeriphID1` register, which contains t=
he `Designer0` and `PartNumber1` values.<br>
&gt; +=C2=A0 =C2=A0 const fn uart_periph_id1(self) -&gt; u64 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 (match self {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Self::Arm =3D&gt; 0x10,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Self::Luminary =3D&gt; 0x00=
,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }) as u64<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /// Value of `UARTPeriphID2` register, which contains t=
he `Revision` and `Designer1` values.<br>
&gt; +=C2=A0 =C2=A0 const fn uart_periph_id2(self) -&gt; u64 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 (match self {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Self::Arm =3D&gt; 0x14,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Self::Luminary =3D&gt; 0x18=
,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }) as u64<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /// Value of `UARTPeriphID3` register, which contains t=
he `Configuration` value.<br>
&gt; +=C2=A0 =C2=A0 const fn uart_periph_id3(self) -&gt; u64 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 (match self {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Self::Arm =3D&gt; 0x0,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Self::Luminary =3D&gt; 0x1,=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }) as u64<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /// Value of `UARTPCellID0` register.<br>
&gt; +=C2=A0 =C2=A0 const fn uart_pcell_id0(self) -&gt; u64 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x0d<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /// Value of `UARTPCellID1` register.<br>
&gt; +=C2=A0 =C2=A0 const fn uart_pcell_id1(self) -&gt; u64 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 0xf0<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /// Value of `UARTPCellID2` register.<br>
&gt; +=C2=A0 =C2=A0 const fn uart_pcell_id2(self) -&gt; u64 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x05<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /// Value of `UARTPCellID3` register.<br>
&gt; +=C2=A0 =C2=A0 const fn uart_pcell_id3(self) -&gt; u64 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 0xb1<br>
&gt; +=C2=A0 =C2=A0 }<br>
<br>
This seems extremely verbose and rather obscures the fact that these<br>
registers are a set of adjacent simple ID registers, compared to<br>
the previous code which defined them as an array of values.<br>
<br>
Isn&#39;t there some way to write this that doesn&#39;t need so much code t=
o do it?<br>
All the PLxxx devices and various others have this set of standard<br>
ID registers, because it&#39;s part of a standardized scheme, so we&#39;re<=
br>
going to end up with similar code in multiple device models. I would<br>
hope that Rust offers us ways to avoid having boilerplate code<br>
where you need to write dozens of lines to express this.<br>
<br>
thanks<br>
-- PMM<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"=
auto"><br></div><div dir=3D"auto">One could abstract them with declarative =
macros to reduce the line count. WDYT about that approach?</div><div dir=3D=
"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
</blockquote></div></div></div>

--0000000000005d20b80627192758--

