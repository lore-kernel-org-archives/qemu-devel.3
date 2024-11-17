Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18FB8D68BF9
	for <qemu-devel@archiver.kernel.org>; Sun, 17 Nov 2024 11:17:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tCdGj-0006np-TS; Sun, 17 Nov 2024 06:16:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tCdGi-0006nH-49
 for qemu-devel@nongnu.org; Sun, 17 Nov 2024 06:16:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tCdGg-00041d-BB
 for qemu-devel@nongnu.org; Sun, 17 Nov 2024 06:16:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731842196;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Akw0Jpsvyllf2/gLpC1tMXDGBC/KDHr+UbcU6YPA/WU=;
 b=O/+gHumIlbHaqnLjDJ33rDWKRjfZ6jVj5WahaQflEPOv1YV1SpvbNpX9kA0rNC2mfPN19Z
 TrFS5afVnDVz7kpl7Bifgl8u3xPMWWxBC7o6vWw9ig73SdxdU/LQXucf84ajC22wka6lav
 /jPtWlLyZCO5kZxzhzDrP9VzsQWy0qI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-VO3iHsSfOeWG3hPv7zcsaw-1; Sun, 17 Nov 2024 06:16:32 -0500
X-MC-Unique: VO3iHsSfOeWG3hPv7zcsaw-1
X-Mimecast-MFC-AGG-ID: VO3iHsSfOeWG3hPv7zcsaw
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-382440c1f83so98591f8f.1
 for <qemu-devel@nongnu.org>; Sun, 17 Nov 2024 03:16:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731842191; x=1732446991;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Akw0Jpsvyllf2/gLpC1tMXDGBC/KDHr+UbcU6YPA/WU=;
 b=jTyzhT46eln+F8tpbZUaPpgkPXWaYbrn8M1d8keihrkQhkjnXTlajw8NU3PLEtfpOm
 YjE2KQMgIZtFOJiKdb13ujKV5oAtOblkjRP9qWKcNKiYIFpZHAl8mZRs8tOylAvc8BIF
 kOfuVjI19ba1mDGO3Gh74QmZGJz9DnV1O2yRVaNoEkmoiVOFnr3hD9vLURBLx3gZbhvq
 PcpH3deLOltjxSuAhyvw1A/FNW5xooleyuyTaK6A5j4tCHi63YmmwpP9l8TjnbGBqaaj
 8NeGfBkymqTlB1zcZhWOCFqFN47ioMmil+tAeWmBG3e1i6bPyZUg9YDZo/x7vEepFsOp
 dP0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUt+vTPRL5V5kO2TRqj/vBKXvJve2Q5FV+sAf6UDdO1L/4IbxHvsvJiz/ZmkaDhmIAX/GixGwiMVAWV@nongnu.org
X-Gm-Message-State: AOJu0YzlAJn8+zANXZa8nitDBOr6PqtyVXaf2tV1Fc+n1WSgpJ4NsxkA
 v30LOsy6N9EQqDj1yXU5AC/Fr48TNgybAzY5hCuPDn3dpglWW2xsizeS+TiF5Nb+1GmiQdk64XL
 U5GnMmQU662T3Il4jodc8N5ZMjm8mqAbU2k5rxgFM0Fc+p9/ayl30qQgqgVpwvVZPF2rvhqhTt1
 JChWNvFxTJ2gUIH5qGfiBQMglCEwI=
X-Received: by 2002:a5d:59a2:0:b0:37d:47ef:17d0 with SMTP id
 ffacd0b85a97d-38224f861c6mr7780334f8f.13.1731842190816; 
 Sun, 17 Nov 2024 03:16:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEsq/Rt+FvkdfdzUjIPzwKKJw2/70evih/TGHOMIubDLE9+WyIiWflyt489kYjOz4x8v5efk+1Ld9aK48Z8VNo=
X-Received: by 2002:a5d:59a2:0:b0:37d:47ef:17d0 with SMTP id
 ffacd0b85a97d-38224f861c6mr7780320f8f.13.1731842190516; Sun, 17 Nov 2024
 03:16:30 -0800 (PST)
MIME-Version: 1.0
References: <20241116221757.3501603-1-manos.pitsidianakis@linaro.org>
 <CAFEAcA9m7EnMX+=T0TL2R_NCJqaPUPCUcoYzAo4P2oRUZbM6Kg@mail.gmail.com>
 <CAAjaMXZE+KKJnvcMpmpaH+dmO7MQVmJm7pD+i1yo_5Wb9-ERcQ@mail.gmail.com>
In-Reply-To: <CAAjaMXZE+KKJnvcMpmpaH+dmO7MQVmJm7pD+i1yo_5Wb9-ERcQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sun, 17 Nov 2024 12:16:16 +0100
Message-ID: <CABgObfadfaohQNf5AheVAUSL5G8i9+zeTOwXRPhOwC_6NpTvmQ@mail.gmail.com>
Subject: Re: [PATCH v2] rust/pl011: Fix DeviceID reads
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, 
 "open list:ARM SMMU <qemu-arm@nongnu.org>, " <qemu-devel@nongnu.org>,
 "open list:ARM SMMU" <qemu-arm@nongnu.org>, qemu-rust@nongnu.org, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="00000000000092c2d5062719ee65"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.121,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.696,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--00000000000092c2d5062719ee65
Content-Type: text/plain; charset="UTF-8"

Il dom 17 nov 2024, 11:21 Manos Pitsidianakis <
manos.pitsidianakis@linaro.org> ha scritto:

> This seems extremely verbose and rather obscures the fact that these
>> registers are a set of adjacent simple ID registers, compared to
>> the previous code which defined them as an array of values.
>
>
> One could abstract them with declarative macros to reduce the line count.
> WDYT about that approach?
>

No, this is just overcomplicating things. Like Peter said, just use arrays.
Copying from the V1 review for reference:

     const UART_PCELL_ID: [u8; 4] = [0x0d, 0xf0, 0x05, 0xb1];
     const ARM_UART_PERIPH_ID: [u8; 4] = [0x11, 0x10, 0x14, 0x00];
     const LUMINARY_UART_PERIPH_ID: [u8; 4] = [0x11, 0x00, 0x18, 0x01];

     /// Value of `UARTPeriphID0` through `UARTPeriphID3` registers
     const fn uart_periph_id(&self, idx: usize) -> u8 {
         match self {
             Self::Arm => ARM_UART_PERIPH_ID,
             Self::Luminary => LUMINARY_UART_PERIPH_ID,
         }[idx]
     }

     /// Value of `UARTPCellID0` through `UARTPCellID3` registers
     const fn uart_pcell_id(idx: usize) -> u8 {
         Self::UART_PCELL_ID[idx]
     }

Paolo

>

--00000000000092c2d5062719ee65
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><br><br><div class=3D"gmail_quote" dir=3D"auto"><div dir=
=3D"ltr" class=3D"gmail_attr">Il dom 17 nov 2024, 11:21 Manos Pitsidianakis=
 &lt;<a href=3D"mailto:manos.pitsidianakis@linaro.org">manos.pitsidianakis@=
linaro.org</a>&gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex"><div dir=3D"auto"><div><div class=3D"gmail_quote"><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">This seems extremely verbose and ra=
ther obscures the fact that these<br>
registers are a set of adjacent simple ID registers, compared to<br>
the previous code which defined them as an array of values.</blockquote></d=
iv></div><div dir=3D"auto"><br></div><div dir=3D"auto">One could abstract t=
hem with declarative macros to reduce the line count. WDYT about that appro=
ach?</div></div></blockquote></div><div dir=3D"auto"><br></div><div dir=3D"=
auto"><div dir=3D"auto">No, this is just overcomplicating things. Like Pete=
r said, just use arrays. Copying from the V1 review for reference:</div><di=
v dir=3D"auto"><br></div><div dir=3D"auto">=C2=A0 =C2=A0 =C2=A0const UART_P=
CELL_ID: [u8; 4] =3D [0x0d, 0xf0, 0x05, 0xb1];</div><div dir=3D"auto">=C2=
=A0 =C2=A0 =C2=A0const ARM_UART_PERIPH_ID: [u8; 4] =3D [0x11, 0x10, 0x14, 0=
x00];</div><div dir=3D"auto">=C2=A0 =C2=A0 =C2=A0const LUMINARY_UART_PERIPH=
_ID: [u8; 4] =3D [0x11, 0x00, 0x18, 0x01];</div><div dir=3D"auto"><br></div=
><div dir=3D"auto">=C2=A0 =C2=A0 =C2=A0/// Value of `UARTPeriphID0` through=
 `UARTPeriphID3` registers</div><div dir=3D"auto">=C2=A0 =C2=A0 =C2=A0const=
 fn uart_periph_id(&amp;self, idx: usize) -&gt; u8 {</div><div dir=3D"auto"=
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0match self {</div><div dir=3D"auto">=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Self::Arm =3D&gt; ARM_UART_PER=
IPH_ID,</div><div dir=3D"auto">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0Self::Luminary =3D&gt; LUMINARY_UART_PERIPH_ID,</div><div dir=3D"auto=
">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}[idx]</div><div dir=3D"auto">=C2=A0 =
=C2=A0 =C2=A0}</div><div dir=3D"auto"><br></div><div dir=3D"auto">=C2=A0 =
=C2=A0 =C2=A0/// Value of `UARTPCellID0` through `UARTPCellID3` registers</=
div><div dir=3D"auto">=C2=A0 =C2=A0 =C2=A0const fn uart_pcell_id(idx: usize=
) -&gt; u8 {</div><div dir=3D"auto">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Self:=
:UART_PCELL_ID[idx]</div><div dir=3D"auto">=C2=A0 =C2=A0 =C2=A0}</div><div =
dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div></div><div class=3D"gma=
il_quote" dir=3D"auto"><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><d=
iv dir=3D"auto"><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">
</blockquote></div></div></div>
</blockquote></div></div>

--00000000000092c2d5062719ee65--


