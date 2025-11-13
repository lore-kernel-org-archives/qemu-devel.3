Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2542CD3445
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 00:45:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJLSZ-0001D5-Cg; Wed, 12 Nov 2025 19:45:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yubinz@google.com>) id 1vJLSU-00012z-HC
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 19:45:07 -0500
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yubinz@google.com>) id 1vJLSR-0006SY-Jw
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 19:45:05 -0500
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-5942f46ad87so2399e87.0
 for <qemu-devel@nongnu.org>; Wed, 12 Nov 2025 16:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1762994701; x=1763599501; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dlTiY6/YKQh3Ol3rdfLXYIM7s/dUNVdRB7ggLSppcng=;
 b=akNvblubVFjI0GjeQUpeVZH5COWB1bhCTtdLzS2S7mEHnDavvo9BVe4mKOGXpdt6pG
 dXhrjrukBZZwkDTXZ8G+HSp+fHpPB4LRcuHtNFDtzWRqcToBXa8neGs60XSr0ZX50Omp
 FqjdvqyxmpLoeaNE5e8buJuRZsKhzOqvhZr/t2CIx2o+pSqtjEQQWpIFEke2ZKPh21x2
 Z0ZmOxCYcshNtOKEWGH41QcshomPT2UVwb+FNzj+Xk+sNnxjOs3UupgJOBiwNMjqA7yU
 bdav431JCWrgELLOfeWCZm8YvOlYIlxSF6Z6EEXsdoYUvINcMKS0SF2sCjVW6dO8rEiK
 26HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762994701; x=1763599501;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dlTiY6/YKQh3Ol3rdfLXYIM7s/dUNVdRB7ggLSppcng=;
 b=Qounvws/jQrIoooW5tccK8OPxuGRKj4nm6skhO0oiVRVqv5uY4zufATvP9ZyaZY5pt
 FZWYeWHZFbQS1vv6mdGZQEn3ThGYgWr+OkscrLlgcz9uIYkASkjlsMFiUN8rZ2bMlVmA
 02bhspljy4Bv/Xm/ULjt8LajpoFk7ytUp/q6JWQCs6thZEdFGnq2U/DVoW9agnBf9XA6
 eYnkJyUkaWDadGchkMU0aowqG5MLCyuxkelvzW2Fn3Hryoc0wgixsiUQAhIpGbcBfWte
 poOoPt7vNkXkhGtfYrRJJbA/yDjsFYF57a+RqBn/CICk4fUDW8z/eqGJKNrSPZAVrW8M
 sBOw==
X-Gm-Message-State: AOJu0YzGGqP9rsf1ZcDC2awjpFLVy2ak/OECYy6sIrO2IhdOoqSdbK6r
 +PSxCJ4kNu2MfkCbKbSf5ElchcBOa2Ty1EajPD5p66rXCMetqPh3RT+4053PPfKdZFk+DLKp3S5
 YYkgLaBLQCmHYu8m1+IHgpesHt0TqMRyjq6KRqKMo
X-Gm-Gg: ASbGncs2ynFZWbjXzQhILRp3N8C7JQWl0WvXTQmiplZyDFUdhRM6ILmZNMc1/9kP0SG
 FFOqth3dLW3I+j5DlJq6RajX9fChdO3TEGwwrM6qEcQOtFpkcXP6oN7xxCJgOEa5pmxS9e+UJLn
 8J/mH1E8zk4noPW44tirFNFCTowzUEPopm7rsT4Q4vFi3DZrsaVsvVl5JUQfd4bUPu5R2UHR5cn
 cZhPUb9nq8XSvrnU7Xs/gRsCrs9bhyDqQteiGUcWxsb0s8NZoDpVflxGhnzr+XU4EiTokEmk9n8
 NOwaj30dkuRpZhse/BMdbitUuA==
X-Google-Smtp-Source: AGHT+IGpy6PPXZSZeZ1uznHFguHmsClXX+LpkDBcjG8nYeWWik8Rnz7N/POuvyI/E2InlbLAr2BUwcfNxxRaCQucvT0=
X-Received: by 2002:a05:6512:605:20b0:594:2f37:84d7 with SMTP id
 2adb3069b0e04-5957f075b2fmr88516e87.2.1762994700503; Wed, 12 Nov 2025
 16:45:00 -0800 (PST)
MIME-Version: 1.0
References: <20250916-quanta-q71l-eeproms-v1-0-3648692cc441@google.com>
 <20250916-quanta-q71l-eeproms-v1-2-3648692cc441@google.com>
 <08b6e571-bf4f-4e51-8a70-8c2c5c675277@kaod.org>
 <CABU_6BJ5zZ2VWHo4pS7r815RtTjdv5iZj=wYbXm5xc=X0+dh9w@mail.gmail.com>
 <660f1bfc-383f-4681-98e7-19aa4555b5fe@kaod.org>
In-Reply-To: <660f1bfc-383f-4681-98e7-19aa4555b5fe@kaod.org>
From: Yubin Zou <yubinz@google.com>
Date: Wed, 12 Nov 2025 16:44:48 -0800
X-Gm-Features: AWmQ_bnHAlZvUVu9ura2_0JE8mhgT_rnJCKK22h_GLiFXGffPhSkhe9cm96ImI0
Message-ID: <CABU_6BJinkS58UP6JH2yQ7zujTtV1am5iPGCuCwLTiYxnUBXdg@mail.gmail.com>
Subject: Re: [PATCH 2/2] hw/arm: enable eeproms for quanta-q71l
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Joel Stanley <joel@jms.id.au>, qemu-arm@nongnu.org,
 Patrick Venture <venture@google.com>
Content-Type: multipart/alternative; boundary="000000000000dd918506436f30f6"
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=yubinz@google.com; helo=mail-lf1-x135.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

--000000000000dd918506436f30f6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

Thanks for reminding me. I have updated the series to include the utility
function of at24c_eeprom_init_one.

Thanks

On Tue, Nov 11, 2025 at 10:26=E2=80=AFAM C=C3=A9dric Le Goater <clg@kaod.or=
g> wrote:

> Hi,
>
> On 10/1/25 00:17, Yubin Zou wrote:
> > Yes, I will include the patch containing the utility function of
> at24c_eeprom_init_one.
>
> Will you send an update or have you given up on the idea ?
>
>
> Thanks,
>
> C.
>
>
> >
> > Yubin
> >
> > On Tue, Sep 16, 2025 at 11:07=E2=80=AFPM C=C3=A9dric Le Goater <clg@kao=
d.org <mailto:
> clg@kaod.org>> wrote:
> >
> >     Hi,
> >
> >     On 9/16/25 19:50, Yubin Zou wrote:
> >      > From: Patrick Venture <venture@google.com <mailto:
> venture@google.com>>
> >      >
> >      > Tested: Quanta-q71l firmware booted to login and was populated
> via the
> >      > -drives for the corresponding eeproms.
> >      > Signed-off-by: Patrick Venture <venture@google.com <mailto:
> venture@google.com>>
> >      > ---
> >      >   hw/arm/aspeed.c | 10 +++++-----
> >      >   1 file changed, 5 insertions(+), 5 deletions(-)
> >      >
> >      > diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> >      > index
> bae59ae7394882e3fc93863049a37ff5a8737ff8..8cef387a0b431576a87355370492088=
6222cca86
> 100644
> >      > --- a/hw/arm/aspeed.c
> >      > +++ b/hw/arm/aspeed.c
> >      > @@ -562,16 +562,16 @@ static void
> quanta_q71l_bmc_i2c_init(AspeedMachineState *bmc)
> >      >       i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 1),
> "tmp105", 0x4f);
> >      >
> >      >       /* Baseboard FRU */
> >      > -    at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 1), 0x54,
> 8192);
> >      > +    at24c_eeprom_init_one(aspeed_i2c_get_bus(&soc->i2c, 1), 1,
> 0x54, 8192, 0);
> >
> >     Where is at24c_eeprom_init_one() implementation ?
> >
> >
> >     Thanks,
> >
> >     C.
> >
> >
> >      >       /* Frontpanel FRU */
> >      > -    at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 1), 0x57,
> 8192);
> >      > +    at24c_eeprom_init_one(aspeed_i2c_get_bus(&soc->i2c, 1), 1,
> 0x57, 8192, 1);
> >      >       /* TODO: Add Memory Riser i2c mux and eeproms. */
> >      >
> >      >       i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 2),
> "pca9546", 0x74);
> >      >       i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 2),
> "pca9548", 0x77);
> >      >
> >      >       /* Add BIOS FRU */
> >      > -    at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 3), 0x56,
> 8192);
> >      > +    at24c_eeprom_init_one(aspeed_i2c_get_bus(&soc->i2c, 3), 3,
> 0x56, 8192, 2);
> >      >
> >      >       /* i2c-7 */
> >      >       i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 7),
> "pca9546", 0x70);
> >      > @@ -581,9 +581,9 @@ static void
> quanta_q71l_bmc_i2c_init(AspeedMachineState *bmc)
> >      >       /*        - i2c@3: pmbus@59 */
> >      >
> >      >       /* PDB FRU */
> >      > -    at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 7), 0x52,
> 8192);
> >      > +    at24c_eeprom_init_one(aspeed_i2c_get_bus(&soc->i2c, 7), 7,
> 0x52, 8192, 3);
> >      >       /* BMC FRU */
> >      > -    at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 8), 0x50,
> 8192);
> >      > +    at24c_eeprom_init_one(aspeed_i2c_get_bus(&soc->i2c, 8), 8,
> 0x50, 8192, 4);
> >      >   }
> >      >
> >      >   static void ast2500_evb_i2c_init(AspeedMachineState *bmc)
> >      >
> >
>
>

--000000000000dd918506436f30f6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi<div><br></div><div>Thanks for reminding me. I have upda=
ted the series to include the utility function of at24c_eeprom_init_one.</d=
iv><div><br></div><div>Thanks</div></div><br><div class=3D"gmail_quote gmai=
l_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Nov 11, 20=
25 at 10:26=E2=80=AFAM C=C3=A9dric Le Goater &lt;<a href=3D"mailto:clg@kaod=
.org">clg@kaod.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">Hi,<br>
<br>
On 10/1/25 00:17, Yubin Zou wrote:<br>
&gt; Yes, I will include the patch containing the utility function of at24c=
_eeprom_init_one.<br>
<br>
Will you send an update or have you given up on the idea ?<br>
<br>
<br>
Thanks,<br>
<br>
C.<br>
<br>
<br>
&gt; <br>
&gt; Yubin<br>
&gt; <br>
&gt; On Tue, Sep 16, 2025 at 11:07=E2=80=AFPM C=C3=A9dric Le Goater &lt;<a =
href=3D"mailto:clg@kaod.org" target=3D"_blank">clg@kaod.org</a> &lt;mailto:=
<a href=3D"mailto:clg@kaod.org" target=3D"_blank">clg@kaod.org</a>&gt;&gt; =
wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Hi,<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0On 9/16/25 19:50, Yubin Zou wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; From: Patrick Venture &lt;<a href=3D"mailto:v=
enture@google.com" target=3D"_blank">venture@google.com</a> &lt;mailto:<a h=
ref=3D"mailto:venture@google.com" target=3D"_blank">venture@google.com</a>&=
gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Tested: Quanta-q71l firmware booted to login =
and was populated via the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; -drives for the corresponding eeproms.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Signed-off-by: Patrick Venture &lt;<a href=3D=
"mailto:venture@google.com" target=3D"_blank">venture@google.com</a> &lt;ma=
ilto:<a href=3D"mailto:venture@google.com" target=3D"_blank">venture@google=
.com</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; ---<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0hw/arm/aspeed.c | 10 +++++-----<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A01 file changed, 5 insertions(+), =
5 deletions(-)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.=
c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; index bae59ae7394882e3fc93863049a37ff5a8737ff=
8..8cef387a0b431576a873553704920886222cca86 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; --- a/hw/arm/aspeed.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +++ b/hw/arm/aspeed.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; @@ -562,16 +562,16 @@ static void quanta_q71l=
_bmc_i2c_init(AspeedMachineState *bmc)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0i2c_slave_create_si=
mple(aspeed_i2c_get_bus(&amp;soc-&gt;i2c, 1), &quot;tmp105&quot;, 0x4f);<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Baseboard FRU */=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; -=C2=A0 =C2=A0 at24c_eeprom_init(aspeed_i2c_g=
et_bus(&amp;soc-&gt;i2c, 1), 0x54, 8192);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 at24c_eeprom_init_one(aspeed_i=
2c_get_bus(&amp;soc-&gt;i2c, 1), 1, 0x54, 8192, 0);<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Where is at24c_eeprom_init_one() implementation ?<b=
r>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Thanks,<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0C.<br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Frontpanel FRU *=
/<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; -=C2=A0 =C2=A0 at24c_eeprom_init(aspeed_i2c_g=
et_bus(&amp;soc-&gt;i2c, 1), 0x57, 8192);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 at24c_eeprom_init_one(aspeed_i=
2c_get_bus(&amp;soc-&gt;i2c, 1), 1, 0x57, 8192, 1);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* TODO: Add Memory=
 Riser i2c mux and eeproms. */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0i2c_slave_create_si=
mple(aspeed_i2c_get_bus(&amp;soc-&gt;i2c, 2), &quot;pca9546&quot;, 0x74);<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0i2c_slave_create_si=
mple(aspeed_i2c_get_bus(&amp;soc-&gt;i2c, 2), &quot;pca9548&quot;, 0x77);<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Add BIOS FRU */<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; -=C2=A0 =C2=A0 at24c_eeprom_init(aspeed_i2c_g=
et_bus(&amp;soc-&gt;i2c, 3), 0x56, 8192);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 at24c_eeprom_init_one(aspeed_i=
2c_get_bus(&amp;soc-&gt;i2c, 3), 3, 0x56, 8192, 2);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* i2c-7 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0i2c_slave_create_si=
mple(aspeed_i2c_get_bus(&amp;soc-&gt;i2c, 7), &quot;pca9546&quot;, 0x70);<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; @@ -581,9 +581,9 @@ static void quanta_q71l_b=
mc_i2c_init(AspeedMachineState *bmc)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/*=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 - i2c@3: pmbus@59 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* PDB FRU */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; -=C2=A0 =C2=A0 at24c_eeprom_init(aspeed_i2c_g=
et_bus(&amp;soc-&gt;i2c, 7), 0x52, 8192);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 at24c_eeprom_init_one(aspeed_i=
2c_get_bus(&amp;soc-&gt;i2c, 7), 7, 0x52, 8192, 3);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* BMC FRU */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; -=C2=A0 =C2=A0 at24c_eeprom_init(aspeed_i2c_g=
et_bus(&amp;soc-&gt;i2c, 8), 0x50, 8192);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 at24c_eeprom_init_one(aspeed_i=
2c_get_bus(&amp;soc-&gt;i2c, 8), 8, 0x50, 8192, 4);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0static void ast2500_evb_i2c_init(=
AspeedMachineState *bmc)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt; <br>
<br>
</blockquote></div>

--000000000000dd918506436f30f6--

