Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE460F88089
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 07:17:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDGyc-00059H-4m; Thu, 16 Apr 2026 03:17:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <munkhuu0825@gmail.com>)
 id 1wDGyb-00058m-5Z
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 03:17:25 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <munkhuu0825@gmail.com>)
 id 1wDGyZ-0002K1-Fo
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 03:17:24 -0400
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-38ea6a5a0b3so9468041fa.3
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 00:17:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776323839; cv=none;
 d=google.com; s=arc-20240605;
 b=XrbgGF5FxYc5u5fmCn7n1T3yBckl50IZd8t0knYPuAN4aXq0q6APMv9VqVtI12Z7Yc
 bP4/Hx/UUAgLHrczmURqaeK4WpIInu1DsnYwOVzFuu0JcHAyOZkRQgil/upoKMa0N/nI
 ywyIXSA/T3QUTxNSMjpTbcdBfbwGgTJZHaKk1hTwFPduPhJMMOJW0/8q/ta39gxI+Qli
 OjI1impgjwgTvLPkW4G+b4ubid2AMn993AF3XsRL9CPOFD/3XJfWTB7B1kJWSYo5dkio
 I1QmVa+ytB/Ln5DLS2pTcJhQ79r6ItWcifSDSod54Uy+3kJujAGsyW2TJxhukELJFlYT
 fFFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=AKr4okNZNLNSjUGPZBkf0k8pFmH5OMo09p+IYMIrO2I=;
 fh=O3rzrV6S0hETXie+puRJbh+nDBDd2TOFQAdmkpP9rgU=;
 b=EfHgJ//evoqcCHTiNUwjRoiHBSm1Gbc9FK/9nWwhltTC7DRMGmhUP2uGmdkLHFlO3N
 9YTzycwG9thQU0tsB3kSUM8vhO7bZSiOuJv4c/Qi6822CxBEzXzfIRKnCWUHTcyRhK/o
 dg3dTA/uwj0e4ZyZXWS9N0vBxxuTk2BOSeS5vat2hphh1JFvedHS+piYUiZ21MgNiwBx
 P6xiyLo2CQNUFcwyB0OdJRjYvEkCjeVB5VKgQD+oRdRPWhSnRQrYOLpv1bsOBDGWwZ/E
 YmSmZ7yPDeqtmtOXta3mbDjwp7OOtDZyczPeiiGlmcpUUj9MoHQ9XksLtP3VzRVu2dr3
 a3HA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776323839; x=1776928639; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AKr4okNZNLNSjUGPZBkf0k8pFmH5OMo09p+IYMIrO2I=;
 b=sZNHQZesX3xWt/ooxjYnbtfQ/2dOU/BducOz5Tk5R1RkZxXcZqoqF2uNtgask+dNbE
 N9Ys1dZ1PVUcKXdhqUt0vPMzOgYfYI+7DRDa5xoxQtTalSQVuvzEGJ8kiGXb2jV/05lS
 1lDJn9umRT/NUwKHmCtxM+p3VeoSTDVlSeIYHKZuNmn/5A0RTuCExo8S21iVzb+Z2nxE
 SIpCwXzGfGRV1uvex23leuu6n7RND3YfHbqI6bnYdaQl+dIz8Te/5UOhY0F58CMvoqtZ
 MPKnVdjP9Hj9pgSBZ4S/GoQ3/ofW40Ree6NZgSZ6USQVtYUB9uGMaW6v02DsEyswJom2
 dUyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776323839; x=1776928639;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AKr4okNZNLNSjUGPZBkf0k8pFmH5OMo09p+IYMIrO2I=;
 b=aGI1XFD4lTBtHJraThZYdI1O4SQvz3z9Tg/3eVNs5a3NPkzML0r4poL+4Yk2BRuHQm
 6fU1O0PyUUw/GwmbExDkfZE0bopLnA2AA1LnAkdufk8y9NB0o9Urn6WvM9dSKPdAh5d3
 DLlshZKG0GdtafKMP/IA4NH94DjSf7oYj3JSlI5jv4dcP45b1QKKBuvI9oTGg6RjJY7W
 WOU6WSfsn1YKEJ9bT0+df/zDBWS8TF9h7RvUenXTzEUyWC/1VoFYo4KMGMoIfOPP8YYW
 VqL93jJPX/dXYoEx1uRvid0P1VY9hsjHfFoaC8a7S/5aFkk+1d24uKqIqvdbpPpZ9CeI
 pKEQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8YtH2YvDk3zQ1vY7qHa4W0eQG099OdeyZ/PAWT7O8DiObwdT8c0ydo3jPKHmi+l7Hr7jxcRtYNMDHC@nongnu.org
X-Gm-Message-State: AOJu0Yxa6Tpfy/+KMb2M110qvLplYbuhDjSyXqu9A6r/rVOi9Bdjn6/F
 Yimlk+EVvTJ7osVrujeLgP8gLjIY5lSBTr7rtx9dv/hlOec7j4P/1D6Vci7/wFsfvD55jcQqYIu
 AdKYfmBrhW1lsQ0jv0RTg6+nuBwiHK4g=
X-Gm-Gg: AeBDievL9652e7/wmetoJ1BYDsQDd8yzayldQXt19iREY2OYJsvxELBPcjozigz72a1
 n71rt/mdD9Se7S92nEs3vVtqY6fwD8p92aezYx38r2iH+G4ugqxMT5vKbdvD9+7T3gbW02g6Ius
 asHGmuAfGFz4vTtE2Go8UoqMvgj92wk7P12KuQ0tmNaYEHqepJ/YSFDI1eK3WmfUZw6xXrYvQA1
 lbOkMiBK4mqNx4vegwuZXJGhtlXMARW8FTzNd8uQrf0JP3WnZ0RSrZ2mAY+tNy9bEK2RdRZehVD
 Wb1/9QCG
X-Received: by 2002:a2e:a553:0:b0:38b:e639:443e with SMTP id
 38308e7fff4ca-38e4bf53b0emr77354221fa.26.1776323839114; Thu, 16 Apr 2026
 00:17:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260415134826.1742308-1-chao.liu.zevorn@gmail.com>
 <CAKmqyKPeqzjYDvG9GfmQ37psGEiqmx+tFGR=YES87YUd-FA7SA@mail.gmail.com>
 <aeB8vRtG0njYb3zt@ZEVORN-PC.localdomain>
In-Reply-To: <aeB8vRtG0njYb3zt@ZEVORN-PC.localdomain>
From: Munkhbaatar Enkhbaabar <munkhuu0825@gmail.com>
Date: Thu, 16 Apr 2026 15:17:06 +0800
X-Gm-Features: AQROBzCgJm6_jTB8KYsLzdTLcurHo2T1RuUgFyPeioa8d4OART9q9eUcuY8p-u4
Message-ID: <CA+0p-WyCijikCrwgtF3xGtNfvfU8xpFwzq6rjk7+o764-ViNwg@mail.gmail.com>
Subject: Re: [PATCH v2] hw/char/riscv_htif: Fix format specifier for uint64_t
To: Chao Liu <chao.liu.zevorn@gmail.com>
Cc: Alistair Francis <alistair23@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 tangtao1634@phytium.com.cn, qemu-riscv@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000006fc226064f8e9f86"
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=munkhuu0825@gmail.com; helo=mail-lj1-x22b.google.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--0000000000006fc226064f8e9f86
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sounds good to me, thanks.

On Thu, Apr 16, 2026 at 2:09=E2=80=AFPM Chao Liu <chao.liu.zevorn@gmail.com=
> wrote:

> On Thu, Apr 16, 2026 at 01:50:39PM +1000, Alistair Francis wrote:
> > On Wed, Apr 15, 2026 at 11:51=E2=80=AFPM Chao Liu <chao.liu.zevorn@gmai=
l.com>
> wrote:
> > >
> > > Use PRIx64 instead of %llx for uint64_t arguments to avoid
> > > -Werror=3Dformat warnings on platforms where uint64_t is not
> > > long long.
> > >
> > > This fixes the cross-riscv64-system CI failure:
> > >
> > >   ../hw/char/riscv_htif.c: In function 'htif_handle_tohost_write':
> > >   ../hw/char/riscv_htif.c:175:38: error: format '%llx' expects argume=
nt
> > >   of type 'long long unsigned int', but argument 2 has type 'uint64_t=
'
> > >   {aka 'long unsigned int'} [-Werror=3Dformat=3D]
> > >
> > > Fixes: d98f7a541c2c ("riscv_htif: reject invalid signature ranges (en=
d
> <=3D begin)")
> > > Tested-by: Tao Tang <tangtao1634@phytium.com.cn>
> > > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> > > Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> > > Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
> >
> > Again, is it ok if I squash this patch with "reject invalid signature
> > ranges (end <=3D begin)" to maintain bisectability?
> Agreed, this is a good idea.
>
> Thanks,
> Chao
>
> >
> > Alistair
>

--0000000000006fc226064f8e9f86
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><span style=3D"color:rgb(0,0,0)"><font face=3D"arial, sans=
-serif">Sounds good to me, thanks.</font></span><br></div><br><div class=3D=
"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">O=
n Thu, Apr 16, 2026 at 2:09=E2=80=AFPM Chao Liu &lt;<a href=3D"mailto:chao.=
liu.zevorn@gmail.com">chao.liu.zevorn@gmail.com</a>&gt; wrote:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">On Thu, Apr 16, 2026 at 01:5=
0:39PM +1000, Alistair Francis wrote:<br>
&gt; On Wed, Apr 15, 2026 at 11:51=E2=80=AFPM Chao Liu &lt;<a href=3D"mailt=
o:chao.liu.zevorn@gmail.com" target=3D"_blank">chao.liu.zevorn@gmail.com</a=
>&gt; wrote:<br>
&gt; &gt;<br>
&gt; &gt; Use PRIx64 instead of %llx for uint64_t arguments to avoid<br>
&gt; &gt; -Werror=3Dformat warnings on platforms where uint64_t is not<br>
&gt; &gt; long long.<br>
&gt; &gt;<br>
&gt; &gt; This fixes the cross-riscv64-system CI failure:<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0../hw/char/riscv_htif.c: In function &#39;htif_handle=
_tohost_write&#39;:<br>
&gt; &gt;=C2=A0 =C2=A0../hw/char/riscv_htif.c:175:38: error: format &#39;%l=
lx&#39; expects argument<br>
&gt; &gt;=C2=A0 =C2=A0of type &#39;long long unsigned int&#39;, but argumen=
t 2 has type &#39;uint64_t&#39;<br>
&gt; &gt;=C2=A0 =C2=A0{aka &#39;long unsigned int&#39;} [-Werror=3Dformat=
=3D]<br>
&gt; &gt;<br>
&gt; &gt; Fixes: d98f7a541c2c (&quot;riscv_htif: reject invalid signature r=
anges (end &lt;=3D begin)&quot;)<br>
&gt; &gt; Tested-by: Tao Tang &lt;<a href=3D"mailto:tangtao1634@phytium.com=
.cn" target=3D"_blank">tangtao1634@phytium.com.cn</a>&gt;<br>
&gt; &gt; Reviewed-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:ph=
ilmd@linaro.org" target=3D"_blank">philmd@linaro.org</a>&gt;<br>
&gt; &gt; Reviewed-by: Alistair Francis &lt;<a href=3D"mailto:alistair.fran=
cis@wdc.com" target=3D"_blank">alistair.francis@wdc.com</a>&gt;<br>
&gt; &gt; Signed-off-by: Chao Liu &lt;<a href=3D"mailto:chao.liu.zevorn@gma=
il.com" target=3D"_blank">chao.liu.zevorn@gmail.com</a>&gt;<br>
&gt; <br>
&gt; Again, is it ok if I squash this patch with &quot;reject invalid signa=
ture<br>
&gt; ranges (end &lt;=3D begin)&quot; to maintain bisectability?<br>
Agreed, this is a good idea.<br>
<br>
Thanks,<br>
Chao<br>
<br>
&gt; <br>
&gt; Alistair<br>
</blockquote></div>

--0000000000006fc226064f8e9f86--

