Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85385CEACFB
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 20:19:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svjLJ-0003CJ-Ls; Tue, 01 Oct 2024 16:19:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <strahinjapjankovic@gmail.com>)
 id 1svjLI-0003BD-6T; Tue, 01 Oct 2024 16:19:32 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <strahinjapjankovic@gmail.com>)
 id 1svjLF-0005tR-Ur; Tue, 01 Oct 2024 16:19:31 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5c89e66012aso2764584a12.2; 
 Tue, 01 Oct 2024 13:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727813968; x=1728418768; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=H2MP46GSGntyim8sGvnjmzPuS/ng9fYAo5WaLy4fl7o=;
 b=elT8THLukLsfBCwZj56uvDLFLEmwaZn7vphbcaP24iq3FEQRQGAK/UvMNr8yiued4j
 dIpsoxH/9WKD6TNWhtzp/zsmdhajLMtr5rcIEu5ECB6U53+cuz7/bv39chUmOj0Qtsuq
 s/x2S9S329Zu3xvMNDLV9t3Oo9VjDvoSI4NjdLTTKhF8uxBlT5xE6iN7EC7Yep37USgd
 DOtdhCALsf+gg5q+JaOuztvhFbDA0fjW9Du8Ku6eklhrlwdIDFYSPlcwDxUaUl65caTA
 GUXKwIuiK/NGFSCsaQFS2PAhnuJN3S65T32K1KTuShoF6Q0YKsS3AjP2RSnAfydYpSbi
 SmFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727813968; x=1728418768;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=H2MP46GSGntyim8sGvnjmzPuS/ng9fYAo5WaLy4fl7o=;
 b=G4kG4BFB7lktYSFGYgr4qB8y/LgAEFol+Y0zy+hw5REzc1c0unHMFbca56wI4sdmXY
 LqBGvECQbkJ+K50v/VH/eW3LnJHZCK+bBk+8R/gXxr2i6o7bTeOzIQH/f2JMIl9C2c/U
 uTEiVBaOB2WikK3CyKGVtfBH5Zn4AkQCm21HOr0PDzOCN5DSRsGk/rKEbzOk1uPKEbze
 xMQvLwXu0MSgA3Ev4KBU9EheIkKz8wzr1VcietOJMsYyEP0jf9nq/Phy35xko6Hv6rnC
 3N5rFMRI5vBKnbt4NyS8STyHbDtoHchPmWnmWahBS9uf8732w7QeXw9EVNVlZT4lujfv
 EvKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2KpxDEv4j8d0RjdW9+fIr3pn60b6a36rZek2FqhQEDL5jZMi0ZC+C2WFn9kyNVPHMwZMWVxHGxpAV0w==@nongnu.org,
 AJvYcCXbTuN/TZ7Ye8LjCIUgoPwNgFEIrtUHTQzT2zPJ6I++9L/LMfeAJdCHKxnOowjUdQ1bA0/OFmroKw==@nongnu.org
X-Gm-Message-State: AOJu0Yz6b6HyWXxqhOPH+GAhvEE3g6VXpNMl7NGthQ7t3azD7qM1j/Y4
 Wd5dt9LEvrz6ny98NoCQwwc0PtT6GSzhrS7kIdXSi7oMQkFLE5SsoLYurmi1rE6GfoNqhwQls9X
 XeKeGjLVKZtmkgI1nAPaowli0Pyc=
X-Google-Smtp-Source: AGHT+IGx6/ZSnAn/ROyVrt+fa3bjzLo2DTJc1+paAytozZCVLysNPEAkdTKnbECzZnog4Bjej2I9jStLsCb4Tm3q4fU=
X-Received: by 2002:a05:6402:4406:b0:5c8:a0fd:63d6 with SMTP id
 4fb4d7f45d1cf-5c8b1a36c94mr482779a12.20.1727813967681; Tue, 01 Oct 2024
 13:19:27 -0700 (PDT)
MIME-Version: 1.0
References: <20240919215525.22398-1-strahinja.p.jankovic@gmail.com>
 <CAFEAcA_RkwPgTksJCEP4=V0WY0wp0OiYP28PzXDJKRvpi_KWvw@mail.gmail.com>
 <CABtshVSsXPoMQy1EZaq2veo-80UMrUX+cqkvh5wq6cujW60s7A@mail.gmail.com>
 <CAFEAcA89cd3zNE3sC_+tSKo51S9V=COoGnqC-Ce37W6c4et_mg@mail.gmail.com>
In-Reply-To: <CAFEAcA89cd3zNE3sC_+tSKo51S9V=COoGnqC-Ce37W6c4et_mg@mail.gmail.com>
From: Strahinja Jankovic <strahinjapjankovic@gmail.com>
Date: Tue, 1 Oct 2024 22:19:14 +0200
Message-ID: <CABtshVRGSU4fA_zGiKn00PbfHNg+S2MywhY+5wum+S+HMjAqTw@mail.gmail.com>
Subject: Re: [PATCH] {hw/ssi,docs/system/arm}: Allwinner A10 SPI emulation
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Beniamino Galvani <b.galvani@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000c81f8d06237009d3"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=strahinjapjankovic@gmail.com; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--000000000000c81f8d06237009d3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 11:24=E2=80=AFAM Peter Maydell <peter.maydell@linaro=
.org>
wrote:

> On Mon, 30 Sept 2024 at 22:28, Strahinja Jankovic
> <strahinjapjankovic@gmail.com> wrote:
> >
> > Hi Peter,
> >
> > Thank you very much for the review and detailed comments.
> >
> > I will try to address all comments in the v2 of the patches, but I have
> some questions I added below.
> >
> > On Mon, Sep 30, 2024 at 4:45=E2=80=AFPM Peter Maydell <peter.maydell@li=
naro.org>
> wrote:
> >> > +static uint64_t allwinner_a10_spi_read(void *opaque, hwaddr offset,
> >> > +                                       unsigned size)
> >> > +{
> >> > +    uint32_t value =3D 0;
> >> > +    AWA10SPIState *s =3D opaque;
> >> > +    uint32_t index =3D offset >> 2;
> >>
> >> The MemoryRegionOps defines that size =3D=3D 1 is permitted,
> >> but this calculation of index without any validation
> >> of offset means that if the guest writes a byte to
> >> offset 1 we will treat that identically to writing a byte
> >> to offset 0. This probably isn't what the hardware does.
> >
> > I checked once more the User manual, and it does not mention
> > unaligned access (example for RXDATA)
> >
> > In 8-bits SPI bus width, this register can be accessed in byte,
> > half-word or word unit by AHB. In byte accessing method,
> > if there are words in RXFIFO, the top word is returned and
> > the RXFIFO depth is decreased by 1. In half-word accessing
> > method, the two SPI bursts are returned and the RXFIFO
> > depth is decrease by 2. In word accessing method, the four
> > SPI bursts are returned and the RXFIFO depth is decreased
> > by 4.
> >
> > I chose not to cover the half-word and word access methods,
> > since neither Linux kernel nor U-Boot use it
> > (both use only byte access).
> >
> > I guess that I could add `.valid.unaligned =3D false` when
> > initializing `MemoryRegionOps`?
>
> This wouldn't help, because a 2-byte load at offset 2
> is not "unaligned" from the memory system's point of view.
> (Also, unaligned =3D false is the default.)
>
> Looking again at your code I see I misread it a bit:
> I thought it was doing a switch() on index, but it is on
> offset.
>
> Using a switch on offset makes it easy to handle the case
> of "bogus write to an offset that isn't the start of a
> register":
>
>    switch (offset) {
>    case SOME_REG_OFFSET:
>        /*
>         * handle it; if size 1/2/4 behave differently,
>         * then look at 'size' to do the right thing.
>         */
>        break;
>    /* etc */
>    default:
>        qemu_log_mask(LOG_GUEST_ERROR,
>                      "%s: bad offset 0x%x\n", __func__,
>                      (uint32_t)offset);
>        break;
>    }
>
> Then both the "offset that's not a defined register"
> and "offset that's not aligned to the start of a register"
> go into the default case, we log it as a guest error,
> and do nothing.
>

Great, thanks for the suggestion! I will include it in v2.

Best regards,
Strahinja



>
> thanks
> -- PMM
>

--000000000000c81f8d06237009d3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Oct 1, 2024 at 11:24=E2=80=AF=
AM Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org">peter.mayd=
ell@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">On Mon, 30 Sept 2024 at 22:28, Strahinja Jankovic<br>
&lt;<a href=3D"mailto:strahinjapjankovic@gmail.com" target=3D"_blank">strah=
injapjankovic@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Hi Peter,<br>
&gt;<br>
&gt; Thank you very much for the review and detailed comments.<br>
&gt;<br>
&gt; I will try to address all comments in the v2 of the patches, but I hav=
e some questions I added below.<br>
&gt;<br>
&gt; On Mon, Sep 30, 2024 at 4:45=E2=80=AFPM Peter Maydell &lt;<a href=3D"m=
ailto:peter.maydell@linaro.org" target=3D"_blank">peter.maydell@linaro.org<=
/a>&gt; wrote:<br>
&gt;&gt; &gt; +static uint64_t allwinner_a10_spi_read(void *opaque, hwaddr =
offset,<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0unsigned size)<br>
&gt;&gt; &gt; +{<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 uint32_t value =3D 0;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 AWA10SPIState *s =3D opaque;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 uint32_t index =3D offset &gt;&gt; 2;<br>
&gt;&gt;<br>
&gt;&gt; The MemoryRegionOps defines that size =3D=3D 1 is permitted,<br>
&gt;&gt; but this calculation of index without any validation<br>
&gt;&gt; of offset means that if the guest writes a byte to<br>
&gt;&gt; offset 1 we will treat that identically to writing a byte<br>
&gt;&gt; to offset 0. This probably isn&#39;t what the hardware does.<br>
&gt;<br>
&gt; I checked once more the User manual, and it does not mention<br>
&gt; unaligned access (example for RXDATA)<br>
&gt;<br>
&gt; In 8-bits SPI bus width, this register can be accessed in byte,<br>
&gt; half-word or word unit by AHB. In byte accessing method,<br>
&gt; if there are words in RXFIFO, the top word is returned and<br>
&gt; the RXFIFO depth is decreased by 1. In half-word accessing<br>
&gt; method, the two SPI bursts are returned and the RXFIFO<br>
&gt; depth is decrease by 2. In word accessing method, the four<br>
&gt; SPI bursts are returned and the RXFIFO depth is decreased<br>
&gt; by 4.<br>
&gt;<br>
&gt; I chose not to cover the half-word and word access methods,<br>
&gt; since neither Linux kernel nor U-Boot use it<br>
&gt; (both use only byte access).<br>
&gt;<br>
&gt; I guess that I could add `.valid.unaligned =3D false` when<br>
&gt; initializing `MemoryRegionOps`?<br>
<br>
This wouldn&#39;t help, because a 2-byte load at offset 2<br>
is not &quot;unaligned&quot; from the memory system&#39;s point of view.<br=
>
(Also, unaligned =3D false is the default.)<br>
<br>
Looking again at your code I see I misread it a bit:<br>
I thought it was doing a switch() on index, but it is on<br>
offset.<br>
<br>
Using a switch on offset makes it easy to handle the case<br>
of &quot;bogus write to an offset that isn&#39;t the start of a<br>
register&quot;:<br>
<br>
=C2=A0 =C2=A0switch (offset) {<br>
=C2=A0 =C2=A0case SOME_REG_OFFSET:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 * handle it; if size 1/2/4 behave differently,<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 * then look at &#39;size&#39; to do the right t=
hing.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0/* etc */<br>
=C2=A0 =C2=A0default:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_log_mask(LOG_GUEST_ERROR,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0&quot;%s: bad offset 0x%x\n&quot;, __func__,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0(uint32_t)offset);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0}<br>
<br>
Then both the &quot;offset that&#39;s not a defined register&quot;<br>
and &quot;offset that&#39;s not aligned to the start of a register&quot;<br=
>
go into the default case, we log it as a guest error,<br>
and do nothing.<br></blockquote><div><br></div><div>Great, thanks for the s=
uggestion! I will include it in v2.</div><div><br></div><div>Best regards,<=
/div><div>Strahinja</div><div><br></div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
<br>
thanks<br>
-- PMM<br>
</blockquote></div></div>

--000000000000c81f8d06237009d3--

