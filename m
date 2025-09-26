Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79963CAC5B8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 21:51:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v2GKK-0004rO-0U; Fri, 26 Sep 2025 17:50:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixiaoyan@google.com>)
 id 1v2GKE-0004pN-V7
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 17:49:59 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lixiaoyan@google.com>)
 id 1v2GK6-0000yf-Rr
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 17:49:58 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-62fa84c6916so3439a12.0
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 14:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1758923387; x=1759528187; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TyQtqxcwVuUILv14pGNYKUXF2U0siZAi7IEnH+SlLmk=;
 b=Q+YNoEeWmepMpiUQvFChHLuiXv3XFUxfJQ+zFf6uWOBwM36wR3b9k8uhaLr0EHCKmg
 kdDxEMlszFEvbXq5PaI95YwhJs7XsgZ2SiJMWdob1gAslMrpKFmiBlbNiEoVee2TgXEO
 SYs038p7fOOAhW49GgzkfO3XX8Elnw3SqVdG4ebe8H9MN5botBq1Kw4NwSSQ+GAZXOi+
 En4zXFgBHdDXY9SdR0VQQw5m5ZjNlcBUm1jrrswoUfKpQCj3XreeFPLJFPk0LomqE6J7
 bmSULw5hD3qNI1zHpiZzmtvhoSZPfu7diggbVrbNVQIgbIPP5AvtIZlHEnpsXjx+SkdX
 Jo/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758923387; x=1759528187;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TyQtqxcwVuUILv14pGNYKUXF2U0siZAi7IEnH+SlLmk=;
 b=oeGSLVRDAEydUey0DK9/YWQZCdoxyPof/9OCDteQtl8/RrmRWneskmyqZvWQNxZIid
 O3pSGRnlqpFqs09ul4VM2yXxTt9YjX0yloH3irD3/qvP3BEgzEmufwis8iNg01/aI2iP
 iWq6XRmfu80+ARIcywnJtBLWsZ3td17tW/uIbdjxe3Jr/311aW7MVEvm7DSVOhP9DZ6A
 XxwYAEQiz+8luEjKT/+qFXEeA/HI2crGaa4PZoRt9gegv5DcNzCSEby2dZDrHVW/wNZL
 aDZkTDLOww5iOCkwNGl/N+33k+joEE8zUsO2s02pBhkR9jm2XARxgdygHdQmkmw2jMi7
 W0kQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+Pb5MTUZk/egmlDSvP5OutO7OXyZo6b0mfKGlwQejWfn3izMUzyuWmna0WMdBWU4/Uvvu72ChiQjq@nongnu.org
X-Gm-Message-State: AOJu0YwCTO5gDWn3fhAZrqN5YU8+AN67EfByAWZxBE0lo2YqI7MHal5Y
 G8bFahXaKI//BxZpQJhhv7g3Fxp0kkJJ8e4wUP2xN2lJd5DxxQPuAW0JnZfnjrw24gl81QJELD1
 PzYActDH9xZ/boE8SRwa6p5fMH5awO28WcRbWG9gC
X-Gm-Gg: ASbGncukoQ8YDo9ZlPuYf0ZuAlkBfTdAuzUTPfwk3v4qTqJk7cKL/3o8jH0PbDWABAP
 Np1sMPRKciV7TkJTbjX4HwmOjomFtvl4l0Y7+lIIAzGodSIlhteH61u036gcQbYeJvjLZiYZCrT
 3eGFmweZ8gfTzQRuRIVl8DKuldzJ+yEJoJzSnnvnhJfiRn3F3QOft98Jmfz9jtPD/5R5J5gNrq6
 vWuukzbPZPUx9+wzafCkQbVqoxgl4u9GR/uFA3a2g0zz4ZufBK49hxWTw==
X-Google-Smtp-Source: AGHT+IHNvYqnZb/806e7ueHZNChuMAzJ57MSZTJYUZctgIk39qYmLQSOWYn6DpHWD4iGUD/2zpn9iW6CLlhO3O6jwzU=
X-Received: by 2002:a50:99c4:0:b0:634:90bb:185e with SMTP id
 4fb4d7f45d1cf-634cd728159mr45877a12.5.1758923386456; Fri, 26 Sep 2025
 14:49:46 -0700 (PDT)
MIME-Version: 1.0
References: <20250925005832.3708492-1-lixiaoyan@google.com>
 <20250925005832.3708492-6-lixiaoyan@google.com>
 <132cc9e6-bab2-47d7-bfe3-c08ac5fc6816@linaro.org>
In-Reply-To: <132cc9e6-bab2-47d7-bfe3-c08ac5fc6816@linaro.org>
From: Coco Li <lixiaoyan@google.com>
Date: Fri, 26 Sep 2025 14:49:34 -0700
X-Gm-Features: AS18NWAYj3T_1ktEWi6X6TuQzG5Nb6gxoatkOPHTXnWG_UeQgkA_tTaUB747YD8
Message-ID: <CADjXwji7AHfRAUiSNxcxU-T7i7rnwDdddyyeC4tWxMf-cYqHww@mail.gmail.com>
Subject: Re: [PATCH v1 5/5] hw/gpio/npcm8xx: Implement npcm sgpio device input
 pin logic
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: peter.maydell@linaro.org, clg@kaod.org, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, 
 flwu@google.com, andrew@codeconstruct.com.au, Hao Wu <wuhaotsh@google.com>
Content-Type: multipart/alternative; boundary="000000000000a3c224063fbb4399"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=lixiaoyan@google.com; helo=mail-ed1-x529.google.com
X-Spam_score_int: -165
X-Spam_score: -16.6
X-Spam_bar: ----------------
X-Spam_report: (-16.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
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

--000000000000a3c224063fbb4399
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Good call, I can put it in the next version.

On Wed, Sep 24, 2025 at 6:11=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philmd=
@linaro.org>
wrote:

> On 25/9/25 02:58, Coco Li wrote:
> > Signed-off-by: Coco Li <lixiaoyan@google.com>
> > Reviewed-by: Hao Wu <wuhaotsh@google.com>
> > ---
> >   hw/gpio/npcm8xx_sgpio.c          | 134 ++++++++++++++++++++---
> >   include/hw/gpio/npcm8xx_sgpio.h  |   4 +-
> >   tests/qtest/npcm8xx_sgpio-test.c | 180 ++++++++++++++++++++++++++----=
-
> >   3 files changed, 274 insertions(+), 44 deletions(-)
> >
> > diff --git a/hw/gpio/npcm8xx_sgpio.c b/hw/gpio/npcm8xx_sgpio.c
>
>
> > +static uint8_t get_even_bits(uint16_t n)
> > +{
> > +    n &=3D 0x5555;
> > +
> > +    n =3D (n | (n >> 1)) & 0x3333;
> > +    n =3D (n | (n >> 2)) & 0x0F0F;
> > +    n =3D (n | (n >> 4)) & 0x00FF;
> > +
> > +    return (uint8_t)n;
> > +}
> > +
> > +static uint8_t get_odd_bits(uint16_t n)
> > +{
> > +    return get_even_bits(n >> 1);
> > +}
>
> Candidates for "include/qemu/bitops.h"?
>

--000000000000a3c224063fbb4399
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Good call, I can put it in the next version.</div><br><div=
 class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmai=
l_attr">On Wed, Sep 24, 2025 at 6:11=E2=80=AFPM Philippe Mathieu-Daud=C3=A9=
 &lt;<a href=3D"mailto:philmd@linaro.org">philmd@linaro.org</a>&gt; wrote:<=
br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">On 25/9/25 02:58=
, Coco Li wrote:<br>
&gt; Signed-off-by: Coco Li &lt;<a href=3D"mailto:lixiaoyan@google.com" tar=
get=3D"_blank">lixiaoyan@google.com</a>&gt;<br>
&gt; Reviewed-by: Hao Wu &lt;<a href=3D"mailto:wuhaotsh@google.com" target=
=3D"_blank">wuhaotsh@google.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0hw/gpio/npcm8xx_sgpio.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
| 134 ++++++++++++++++++++---<br>
&gt;=C2=A0 =C2=A0include/hw/gpio/npcm8xx_sgpio.h=C2=A0 |=C2=A0 =C2=A04 +-<b=
r>
&gt;=C2=A0 =C2=A0tests/qtest/npcm8xx_sgpio-test.c | 180 +++++++++++++++++++=
+++++++-----<br>
&gt;=C2=A0 =C2=A03 files changed, 274 insertions(+), 44 deletions(-)<br>
&gt; <br>
&gt; diff --git a/hw/gpio/npcm8xx_sgpio.c b/hw/gpio/npcm8xx_sgpio.c<br>
<br>
<br>
&gt; +static uint8_t get_even_bits(uint16_t n)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 n &amp;=3D 0x5555;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 n =3D (n | (n &gt;&gt; 1)) &amp; 0x3333;<br>
&gt; +=C2=A0 =C2=A0 n =3D (n | (n &gt;&gt; 2)) &amp; 0x0F0F;<br>
&gt; +=C2=A0 =C2=A0 n =3D (n | (n &gt;&gt; 4)) &amp; 0x00FF;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return (uint8_t)n;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static uint8_t get_odd_bits(uint16_t n)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 return get_even_bits(n &gt;&gt; 1);<br>
&gt; +}<br>
<br>
Candidates for &quot;include/qemu/bitops.h&quot;?<br>
</blockquote></div>

--000000000000a3c224063fbb4399--

