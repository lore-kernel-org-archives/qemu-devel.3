Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75B87C0218A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 22:32:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdd4y-0001nW-2Z; Thu, 30 Jan 2025 17:32:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1tdd4p-0001lQ-5Z; Thu, 30 Jan 2025 17:32:00 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1tdd4m-0002xP-VW; Thu, 30 Jan 2025 17:31:58 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5dc7eaaed68so1226413a12.2; 
 Thu, 30 Jan 2025 14:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738276314; x=1738881114; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kpGaiH7VnXxUn64FuhfExFcdESW0X9XnbZVfo4/X3ss=;
 b=GKIMCKxHigkcf0pNFUUcmpbrQkCeBS6aa+xVF3rC/fkEirHWG4dzgUDytFAEcewLIQ
 HQsNGG8OiDILsciUPw4zW491sTJcwRjLpR/ruEKBKIndVgc1HFyNstvTMC/TXVKM168F
 IjgXqxp/BH/FEQKtaxUgJl2rJqwf+ThkFWWn9w8I7Gm5x/AxOcddCksXSy8PVie9y5un
 1pEjrpnWh2t3Ke7oqcI/vDlZBNWSAElIuWYmP8DaveLV9zbUWRA2GCUdZTPnIWphWatS
 yo9tOp4Snb5aCryF3iJyduGpGRpdrdD3tOoojDJoEno4TpB2PFQHEYu647rBbRPz0mP3
 7GDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738276314; x=1738881114;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kpGaiH7VnXxUn64FuhfExFcdESW0X9XnbZVfo4/X3ss=;
 b=oCM3fkScXKcE6SeSUXEIwA13fx6r+NStixyP8trR1ExAQk6f+n4384GDfB5SIi0YVr
 NLW3jKItjg5sTWJR+j4yLeC4oNVeSEoujlkF3ZrFDZt4aQI7iR9nr4jc7WJ4FEwv5ji7
 VIfBH0rWXw5htfTsYqL3bW7smU5DJR8xCquSsN1wxQnOg/S4VI1ONYQcrB0EzX5APjjC
 IsBdLh85p/Do12Z4as4SKF23Whz3BhFgtY3cRR+3Ad9FQ3r73Gba/83xOmMIHUz3peEf
 pGbNFiUmrpH4zY2l/IusDuLPBNgIcw3rI3WCQy/7VCQ2LEsOXSB7E7BOefQGe02F1SnS
 HOmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2lzrJEsJViG++U1obic771STAGPThp50FxZWltCvIopLf+Nztw5H2TDpMi7x+i75HFr+46xDExg==@nongnu.org,
 AJvYcCXOl+aeA4daP1CB/tgEG9Pr8Vzq4DPMlRRyKqPJz+bJoZ9sJVXuyp8UMwf0L1ZFok9j/x1hvXgRn27/Kg==@nongnu.org
X-Gm-Message-State: AOJu0YzTgE6d9rn4u0Z5S4l93JBLekb4oNylBY8N+NNCgZVLL2tb6U5T
 etsxkkZfNZef4Ui84n2+R9DZBGns0WkOdRtKQf9OnbdlOu6SWGEsOMq3Zy2Z3NHUCidLTu3GtVg
 RHJQOKUhq0iRwruxWK3JTL0WiYrs=
X-Gm-Gg: ASbGncs8V6Q1hy48lhaLv0SOP7r7J0BEmWBk3F0qrnhQDWWii8L6D3wyHXFEHqopB5S
 GaDSGWQw4GGiE/um2iDkvcxWxTOXWvgQNmmEdtCMAVN5xIgB7WcwBFJlGBniVFKFWL6F/H5df4A
 ==
X-Google-Smtp-Source: AGHT+IF7i0l4zsYNQrstTcw0OWkxOFa9pWjWRNgRB7SjaktAytl0Z3ToHAKBIVdlVSxMK82VUSJUr2DDnlkeeyWx7yE=
X-Received: by 2002:a05:6402:a001:b0:5dc:7425:ea9b with SMTP id
 4fb4d7f45d1cf-5dc7425eb63mr2338867a12.25.1738276313986; Thu, 30 Jan 2025
 14:31:53 -0800 (PST)
MIME-Version: 1.0
References: <20241219061658.805-1-andrew.yuan@jaguarmicro.com>
 <CAFEAcA96ZLjOhBT9rhNhuk32ve0Qv4hUVuTTtgE=DBApbN98Pg@mail.gmail.com>
In-Reply-To: <CAFEAcA96ZLjOhBT9rhNhuk32ve0Qv4hUVuTTtgE=DBApbN98Pg@mail.gmail.com>
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Thu, 30 Jan 2025 16:31:42 -0600
X-Gm-Features: AWEUYZm1GObqDju-aMaJbFhKYYd9jyCN40o29AgIb63UdZjmkaD7VhYUj40UzAo
Message-ID: <CAJy5ezovedShKH=HFbK9uRY44no2ijQocs29CHLt2jKoNL+Vpw@mail.gmail.com>
Subject: Re: [PATCH v3] hw/net: cadence_gem: feat: add logic for the
 DISABLE_MASK bit in type2_compare_x_word_1
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "Andrew.Yuan" <andrew.yuan@jaguarmicro.com>, philmd@linaro.org,
 alistair@alistair23.me, 
 jasowang@redhat.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000377e83062cf3febf"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-ed1-x532.google.com
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

--000000000000377e83062cf3febf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 27, 2025 at 8:40=E2=80=AFAM Peter Maydell <peter.maydell@linaro=
.org>
wrote:

> Edgar or Alistair -- could one of you review this
> cadence GEM patch, please?
>
>
Sorry for the delay!



> On Thu, 19 Dec 2024 at 06:17, Andrew.Yuan <andrew.yuan@jaguarmicro.com>
> wrote:
> >
> > From: Andrew Yuan <andrew.yuan@jaguarmicro.com>
> >
> > As in the Cadence IP for Gigabit Ethernet MAC Part Number: IP7014 IP
> Rev: R1p12 - Doc Rev: 1.3 User Guide,
> > if the DISABLE_MASK bit in type2_compare_x_word_1 is set,
> > mask_value in type2_compare_x_word_0 is used as an additional 2 byte
> Compare Value
> >
> > Signed-off-by: Andrew Yuan <andrew.yuan@jaguarmicro.com>
> > Suggested-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> > ---
> >  hw/net/cadence_gem.c | 24 +++++++++++++++++++-----
> >  1 file changed, 19 insertions(+), 5 deletions(-)
> >
> > diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
> > index 3fce01315f..7bd176951e 100644
> > --- a/hw/net/cadence_gem.c
> > +++ b/hw/net/cadence_gem.c
> > @@ -909,8 +909,8 @@ static int get_queue_from_screen(CadenceGEMState *s=
,
> uint8_t *rxbuf_ptr,
> >
> >          /* Compare A, B, C */
> >          for (j =3D 0; j < 3; j++) {
> > -            uint32_t cr0, cr1, mask, compare;
> > -            uint16_t rx_cmp;
> > +            uint32_t cr0, cr1, mask, compare, disable_mask;
> > +            uint32_t rx_cmp;
> >              int offset;
> >              int cr_idx =3D extract32(reg,
> R_SCREENING_TYPE2_REG0_COMPARE_A_SHIFT + j * 6,
> >
>  R_SCREENING_TYPE2_REG0_COMPARE_A_LENGTH);
> > @@ -946,9 +946,23 @@ static int get_queue_from_screen(CadenceGEMState
> *s, uint8_t *rxbuf_ptr,
> >                  break;
> >              }
> >
> > -            rx_cmp =3D rxbuf_ptr[offset] << 8 | rxbuf_ptr[offset];
> > -            mask =3D FIELD_EX32(cr0, TYPE2_COMPARE_0_WORD_0, MASK_VALU=
E);
> > -            compare =3D FIELD_EX32(cr0, TYPE2_COMPARE_0_WORD_0,
> COMPARE_VALUE);
> > +            disable_mask =3D
> > +                FIELD_EX32(cr1, TYPE2_COMPARE_0_WORD_1, DISABLE_MASK);
> > +            if (disable_mask) {
> > +                /*
> > +                 * If disable_mask is set,
> > +                 * mask_value is used as an additional 2 byte Compare
> Value.
> > +                 * To simple, set mask =3D 0xFFFFFFFF, if disable_mask=
 is
> set.
> > +                 */
> > +                rx_cmp =3D ldl_le_p(rxbuf_ptr + offset);
> > +                mask =3D 0xFFFFFFFF;
> > +                compare =3D cr0;
> > +            } else {
> > +                rx_cmp =3D lduw_le_p(rxbuf_ptr + offset);
>
> Is the change in behaviour in the !disable_mask codepath here
> intentional? Previously we use one byte from rxbuf_ptr[offset],
> duplicated into both halves of rx_cmp; now we will load two
> different bytes from rxbuf_ptr[offset] and rxbuf_ptr[offset + 1].
>
> If this is intended, we should say so in the commit message.
>
>
I agree that it should be mentioned (looks like a correct bugfix).
Other than that this patch looks good to me!

Cheers,
Edgar


>
> > +                mask =3D FIELD_EX32(cr0, TYPE2_COMPARE_0_WORD_0,
> MASK_VALUE);
> > +                compare =3D
> > +                    FIELD_EX32(cr0, TYPE2_COMPARE_0_WORD_0,
> COMPARE_VALUE);
> > +            }
> >
> >              if ((rx_cmp & mask) =3D=3D (compare & mask)) {
> >                  matched =3D true;
> > --
> > 2.25.1
>
> thanks
> -- PMM
>

--000000000000377e83062cf3febf
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jan 27,=
 2025 at 8:40=E2=80=AFAM Peter Maydell &lt;<a href=3D"mailto:peter.maydell@=
linaro.org">peter.maydell@linaro.org</a>&gt; wrote:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">Edgar or Alistair -- could one of you r=
eview this<br>
cadence GEM patch, please?<br>
<br></blockquote><div><br></div><div>Sorry for the delay!</div><div><br></d=
iv><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
On Thu, 19 Dec 2024 at 06:17, Andrew.Yuan &lt;<a href=3D"mailto:andrew.yuan=
@jaguarmicro.com" target=3D"_blank">andrew.yuan@jaguarmicro.com</a>&gt; wro=
te:<br>
&gt;<br>
&gt; From: Andrew Yuan &lt;<a href=3D"mailto:andrew.yuan@jaguarmicro.com" t=
arget=3D"_blank">andrew.yuan@jaguarmicro.com</a>&gt;<br>
&gt;<br>
&gt; As in the Cadence IP for Gigabit Ethernet MAC Part Number: IP7014 IP R=
ev: R1p12 - Doc Rev: 1.3 User Guide,<br>
&gt; if the DISABLE_MASK bit in type2_compare_x_word_1 is set,<br>
&gt; mask_value in type2_compare_x_word_0 is used as an additional 2 byte C=
ompare Value<br>
&gt;<br>
&gt; Signed-off-by: Andrew Yuan &lt;<a href=3D"mailto:andrew.yuan@jaguarmic=
ro.com" target=3D"_blank">andrew.yuan@jaguarmicro.com</a>&gt;<br>
&gt; Suggested-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd=
@linaro.org" target=3D"_blank">philmd@linaro.org</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 hw/net/cadence_gem.c | 24 +++++++++++++++++++-----<br>
&gt;=C2=A0 1 file changed, 19 insertions(+), 5 deletions(-)<br>
&gt;<br>
&gt; diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c<br>
&gt; index 3fce01315f..7bd176951e 100644<br>
&gt; --- a/hw/net/cadence_gem.c<br>
&gt; +++ b/hw/net/cadence_gem.c<br>
&gt; @@ -909,8 +909,8 @@ static int get_queue_from_screen(CadenceGEMState *=
s, uint8_t *rxbuf_ptr,<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Compare A, B, C */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (j =3D 0; j &lt; 3; j++) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t cr0, cr1, mask, co=
mpare;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint16_t rx_cmp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t cr0, cr1, mask, co=
mpare, disable_mask;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t rx_cmp;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int offset;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int cr_idx =3D extract=
32(reg, R_SCREENING_TYPE2_REG0_COMPARE_A_SHIFT + j * 6,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0R_SCREENING_T=
YPE2_REG0_COMPARE_A_LENGTH);<br>
&gt; @@ -946,9 +946,23 @@ static int get_queue_from_screen(CadenceGEMState =
*s, uint8_t *rxbuf_ptr,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rx_cmp =3D rxbuf_ptr[offset=
] &lt;&lt; 8 | rxbuf_ptr[offset];<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mask =3D FIELD_EX32(cr0, TY=
PE2_COMPARE_0_WORD_0, MASK_VALUE);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 compare =3D FIELD_EX32(cr0,=
 TYPE2_COMPARE_0_WORD_0, COMPARE_VALUE);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 disable_mask =3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FIELD_EX32(cr=
1, TYPE2_COMPARE_0_WORD_1, DISABLE_MASK);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (disable_mask) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* If di=
sable_mask is set,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* mask_=
value is used as an additional 2 byte Compare Value.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* To si=
mple, set mask =3D 0xFFFFFFFF, if disable_mask is set.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rx_cmp =3D ld=
l_le_p(rxbuf_ptr + offset);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mask =3D 0xFF=
FFFFFF;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 compare =3D c=
r0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rx_cmp =3D ld=
uw_le_p(rxbuf_ptr + offset);<br>
<br>
Is the change in behaviour in the !disable_mask codepath here<br>
intentional? Previously we use one byte from rxbuf_ptr[offset],<br>
duplicated into both halves of rx_cmp; now we will load two<br>
different bytes from rxbuf_ptr[offset] and rxbuf_ptr[offset + 1].<br>
<br>
If this is intended, we should say so in the commit message.<br>
<br></blockquote><div><br></div><div>I agree that it should be mentioned (l=
ooks like a correct bugfix).</div><div>Other than that this patch looks goo=
d to me!</div><div><br></div><div>Cheers,</div><div>Edgar</div><div>=C2=A0<=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mask =3D FIEL=
D_EX32(cr0, TYPE2_COMPARE_0_WORD_0, MASK_VALUE);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 compare =3D<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 FIELD_EX32(cr0, TYPE2_COMPARE_0_WORD_0, COMPARE_VALUE);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((rx_cmp &amp; mask=
) =3D=3D (compare &amp; mask)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 matched =
=3D true;<br>
&gt; --<br>
&gt; 2.25.1<br>
<br>
thanks<br>
-- PMM<br>
</blockquote></div></div>

--000000000000377e83062cf3febf--

