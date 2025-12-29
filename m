Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 456BBE8FDB1
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 04:20:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1va4ji-0001Bu-59; Sun, 28 Dec 2025 23:20:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lihang.lin@gmail.com>)
 id 1va4jc-0001Ae-Rm
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 23:19:58 -0500
Received: from mail-vs1-xe29.google.com ([2607:f8b0:4864:20::e29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lihang.lin@gmail.com>)
 id 1va4ja-0005Tk-85
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 23:19:56 -0500
Received: by mail-vs1-xe29.google.com with SMTP id
 ada2fe7eead31-5dbd150efe8so3404718137.0
 for <qemu-devel@nongnu.org>; Sun, 28 Dec 2025 20:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766981993; x=1767586793; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uJEL4RKSM536WrhiVNtubZxgtGjAp6vJubgCFmbwf4s=;
 b=j/ZR8IxSrWngY3/9pWy6PKjzGqY54JwLwp/k0h5F+1cMQOSHZJE1DQ3H8N1rcJ31eT
 Gzy81r4Y0yoPb4mOATrn1umnHOtG+s6nYWGCE03G1WsxrxT207EaNfkC1UA+AQoriPDz
 0k1F6UVwnJpoFp7LeEFWhKt3P8FO55cCR/RaGO/E96PmpL4ZJSXpPVNH+0Sf6FWS3mZT
 dYGdMZffESD7j5/GUvM3xBcKvsguyNmFkO+hcEPUe/GYGOXnaVAPOsYKvgRj5ym+6RtW
 U6WlrwXz9EZZsmPw2J/myezbg/H8lBsU92Ut+VLt22yYhSPRrwc90LLJWVfEh0bzYuXt
 sGxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766981993; x=1767586793;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uJEL4RKSM536WrhiVNtubZxgtGjAp6vJubgCFmbwf4s=;
 b=NbhLKk/fuM0Tg4EtAYfken3IK6GIUQdfoU42J+w4g2ZyyWUqMh3LNo5jIEDq0NoE7H
 4tWd2JmUTw9m55oAOaw2/0VEsFNU0j2dmLprksxTEtyT9EO8eqvIPx9MzCFFkvDgTk1r
 4Gz7inJ4fp+R8PDSONlVJgF2VnohLznh6S64sntzKmgJaAaP3s+QP+tkKNz3VrqMwZW6
 QxNus3EUQca8WFWbAD1usEi5XsNz+d0BogeitgHWedT7GliBWNDs23Bisr+dDsYJIdwF
 rne6qAZj00CKOVaAbJN9TzV/0KiriRLNvupHb05v3uumf0nZna9xkTkTj2/yld0atKPu
 d7vg==
X-Gm-Message-State: AOJu0YwkKbC9TiMs1rT9L7+YwoEIGCb/Mczw40RjcYqvHM2+/oQLXwdD
 brqdoa3wd/fPD0jbLutm0sVxWcBTHBvl59jnDJcxiYMcLCtO2iRgblxwnbMiE07mfMxfGY4Aq7G
 nJdLpdtbRTjdjs1vZDiHWxf8jhyOjFPpOPd9BG7Y=
X-Gm-Gg: AY/fxX5M8MvwQ+/ZhaFXJ0Wc6UYZ10CQf00dMVwQ3WmUmpfUwm0nCOvoPPewCSeATjk
 fojzn9GHI0pGwHbQEaJh3TH4mloBZ8u/DON/7ru/5Ve4WOFk7ik7K0it5WOKdvEJv3PnQg5wb06
 c6oT9DDp33q1edVB8jrJQalWjA8mKuOg796042ZB9QVubeYsf3q8NXAoa3rJz1iSrYBLGXE8jCa
 5q0kDDQUCwHZcSV2oUZh+hnQXFJUzomHsmVO/MtC95+/EojrV2jT6u7/6+yzdsfgi/8quLnGmiq
 OGVf6OV0OCM3TzoPTt9eBciIpQ==
X-Google-Smtp-Source: AGHT+IHvbhWJSfhahh16B83Yc7r6kOQ+2nx68fnq0WVlNnXIsjENxAGDYDDNdyDK2LpWCyd07YbUNS2g/GoZMDFoMKg=
X-Received: by 2002:a05:6102:3a13:b0:5e5:5cb7:eb0a with SMTP id
 ada2fe7eead31-5eb1a7dc7fbmr9153298137.21.1766981992698; Sun, 28 Dec 2025
 20:19:52 -0800 (PST)
MIME-Version: 1.0
References: <20251226064225.791454-1-lihang.lin@gmail.com>
 <CAFEAcA_ovy2HzhVTKJiRNaZvVQ3qvkw0Pres0HZ+TFJjx1wc3g@mail.gmail.com>
In-Reply-To: <CAFEAcA_ovy2HzhVTKJiRNaZvVQ3qvkw0Pres0HZ+TFJjx1wc3g@mail.gmail.com>
From: Lin Li-Hang <lihang.lin@gmail.com>
Date: Mon, 29 Dec 2025 12:19:41 +0800
X-Gm-Features: AQt7F2p2KrQx7--aI22dW9QRRyivqoax88AdsD6ipZynvwoGCCTdlveMj00SUqQ
Message-ID: <CAPR+-WF6uSsm6nBY7jmmxKEMSHR3t+d4KG5KAtsDNJPxen-r9A@mail.gmail.com>
Subject: Re: [PATCH] target/arm/tcg/vfp_helper: Fix incorrect bit field
 deposition in rsqrte_f64
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000ffd7cc06470f8d57"
Received-SPF: pass client-ip=2607:f8b0:4864:20::e29;
 envelope-from=lihang.lin@gmail.com; helo=mail-vs1-xe29.google.com
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

--000000000000ffd7cc06470f8d57
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Peter,

Thank you for your reply.

I initially identified this error while reviewing the code and was curious
why it hadn't caused any bugs.
After further testing, it appears the original code behaved correctly by
coincidence.

The ASL code in the ARM ARM for FRSQRTE states:

```
elsif sign =3D=3D '1' then
         result =3D FPDefaultNaN(fpcr, N);
         if fpexc then FPProcessException(FPExc_InvalidOp, fpcr);
```

As it turns out, the sign bit must be zero by the time it reaches the final
deposition code, which explains why the incorrect bit placement did not
surface as a functional bug.


On Mon, Dec 29, 2025 at 1:15=E2=80=AFAM Peter Maydell <peter.maydell@linaro=
.org>
wrote:

> On Fri, 26 Dec 2025 at 06:43, Li-Hang Lin <lihang.lin@gmail.com> wrote:
> >
> > Fix an error in rsqrte_f64() where the sign bit was being
> > placed incorrectly. Specifically, ensure f64_sign is deposited
> > into bit 63.
> >
> > Additionally, update the comments regarding the exponent (exp) bit
> > width to reflect the correct double-precision specifications.
>
> This seems like it would produce incorrect results -- do you
> have an example of an instruction plus input data values that p
> produces a different output value to the hardware?
>
> thanks
> -- PMM
>

--000000000000ffd7cc06470f8d57
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Peter,</div><div><br></div><div>Thank you for your=
 reply.</div><div><br></div><div>I initially identified this error while re=
viewing the code and was curious why it hadn&#39;t caused any bugs.</div><d=
iv>After further testing, it appears the original code behaved correctly by=
 coincidence.</div><div><br></div><div>The ASL code in the ARM ARM for FRSQ=
RTE states:</div><div><br></div><div>```</div><div>elsif sign =3D=3D &#39;1=
&#39; then</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0result =3D FPDefault=
NaN(fpcr, N);</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if fpexc then FPP=
rocessException(FPExc_InvalidOp, fpcr);</div><div>```</div><div><br></div><=
div>As it turns out, the sign bit must be zero by the time it reaches the f=
inal deposition code, which explains why the incorrect bit placement did no=
t surface as a functional bug.</div><div><br></div></div><br><div class=3D"=
gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On=
 Mon, Dec 29, 2025 at 1:15=E2=80=AFAM Peter Maydell &lt;<a href=3D"mailto:p=
eter.maydell@linaro.org">peter.maydell@linaro.org</a>&gt; wrote:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">On Fri, 26 Dec 2025 at 06:=
43, Li-Hang Lin &lt;<a href=3D"mailto:lihang.lin@gmail.com" target=3D"_blan=
k">lihang.lin@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Fix an error in rsqrte_f64() where the sign bit was being<br>
&gt; placed incorrectly. Specifically, ensure f64_sign is deposited<br>
&gt; into bit 63.<br>
&gt;<br>
&gt; Additionally, update the comments regarding the exponent (exp) bit<br>
&gt; width to reflect the correct double-precision specifications.<br>
<br>
This seems like it would produce incorrect results -- do you<br>
have an example of an instruction plus input data values that p<br>
produces a different output value to the hardware?<br>
<br>
thanks<br>
-- PMM<br>
</blockquote></div>

--000000000000ffd7cc06470f8d57--

