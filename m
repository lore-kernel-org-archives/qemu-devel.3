Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60C85EF06E6
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 03:59:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpIQi-0006Gy-Qs; Sun, 08 Feb 2026 22:59:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1vpIQi-0006Gf-2e
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 22:59:20 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1vpIQg-0007he-Eu
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 22:59:19 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2a7b47a5460so23668155ad.1
 for <qemu-devel@nongnu.org>; Sun, 08 Feb 2026 19:59:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770609557; cv=none;
 d=google.com; s=arc-20240605;
 b=SZpZn/IYzok+NqNYAKLRF7OhYr2MdP3VbkqQoRnn581Mw5BSe5LLWP05OWutKlQmEX
 bY2+XxieTn/XieFesbSU1+8a+NQwgMCm0AdAhTLwNuAqjMxIMs3aN/aC6lQ0kV5WTATx
 X4yUZgIZn36tgkD2VIRNX0F+bW7uTDtNls7M5h3RkP7oaZA4fa/11KHTSxDddxWfUnOJ
 z7RDXA4/4cmbIGQMBjgr4HZ5FALk5mhUspzj1ovlcIE3VDfdoqDfbp9IG72uwnm0Z4BS
 l8yutMy4KWGoQ+HUv7HzxDOVY5t8/h57rWEk72ua2aPOgHhwnLOo3KbHcqcFVz4jQUlq
 7UBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=XnMJsYYoAKmbtQfQuZLZcfD0IQzmm5Ab15ysBQ3Yx4s=;
 fh=GI2e/SBiq4MTIPc9mHou6R6WJe3VvhdDMWKbaXflkfU=;
 b=HlvVfmbNrsZIyztn8Aev8QhR/ZLUHL23TPQFs5rhOWSiDy8sX7qMbOesnRPK9AfZyb
 aavqSQqTyoZIdNmPIxa+p6ljMfg81oXZIBYzpzPKf4z0+3/OZmlt2NZmmFkxAyAKFVOg
 8TNcA/yzDPbMYwMdr4JEA3yizxccthVAVLBDEf+U/ECvU7bSHlDagDccIAQaM9lhp0J8
 A4oiw00d7fWg2yCXgKDHOhsKePx231IyBO//TcweXPqQXxuWgtzRhJGnwVEqVKbVvEGL
 C0huToUF53YcGqVFfUjxaKeYtHXuBTrd1VLUHJJEKLvdixZWiIBjh4WrqTQL8Kns9cF4
 H8WA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1770609557; x=1771214357;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XnMJsYYoAKmbtQfQuZLZcfD0IQzmm5Ab15ysBQ3Yx4s=;
 b=V8Gj6K7fo9MaErnEltdb7K9aYUJ0V6fM2vnyMfHMtuheg8Z9c6HyejdgDK7fv3MmIV
 goPyt1/I5Drb8cLBNQOZdlzQvo8Ijo3LisPxWSXw2w0cxZVU1w58SVJxUk+CjLXMyuBm
 nqvGIjBzPB9rWCCoI7mddMC3yzEH+aLB+kD1vLBoQ2S0zC3rI53+6lhVNVz3hF6G53Z9
 gH2uymoQg3jYQOEYoWdo5rdd+PMG7a5LqW+ESx5K8WzbHve7Mj6QWLZq9yMOddVwwtTI
 UTOD4J4wyj1tslF1XGaTpAU1eFPpGersGxFKrOfcj8F7KAXSW6ROKsnyNKcHrPSXhlbn
 cnuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770609557; x=1771214357;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XnMJsYYoAKmbtQfQuZLZcfD0IQzmm5Ab15ysBQ3Yx4s=;
 b=cKSUFlGVX4QDC42Ctnm2PwfcPLp5atCfpc+NWGfXYQ6a4gTFaiubZsBjz8NQmfCTr3
 quBLQtvyBSYHIWh300SsfgHCfufzB2Fb9JiDSKMcXQKcO8Nqz1mWqVEcjrCD7xxie3ww
 dOH5XCgklj+78Z98+3mNeHvOW5M3qGcPxp11T1QlKOdbqw6deY4HsxDEih7s0Kb173C6
 B7U5ekSlnD9tg2l7CacV0O2DUB1u1biWbwXM2QOgIW9lWW5cjExR0olK4wU89lZ6IjRZ
 pdpqLQCd1wFQyhKcLvjIWxK2gLAiMhixtv3sBLYHEP+PlWt3j5+P3nLy/jwR7br3K5+m
 ZKPA==
X-Gm-Message-State: AOJu0YwUkO/m2cBDsIv/fVXh0O2P88M9RBAaxwX6E7tImj3SaRw33V8f
 z2ot8tgj5+MbfIPCaq1WyGLreabIwnW1Q8cJ//UMu5O0N+o8GBMxH/61ex4l5+k8z2ryz5p5U3I
 ebJI54UI/+5Mwsq3gi+xa2O7y+U+mt+HBt8D6ixPNtdc0p0+Avci8oIE=
X-Gm-Gg: AZuq6aI3mre2WSPT+70W6/XrsWJUN8ICmTvFj1J4JnUthdycu1SWWQB+xLAFWn1aldn
 WIy64H8tVyAD3ETfBfQ6h6nk+LPtsOYCNj/2woJUMsJjPVv/riseVXTpkkay2xjbwksjQbG7WiI
 Sfh5cF1hkoXoL25dD0arxIw6pghQq5r7Zc6/e8L/m8Vq85y/1UnPjWBFvNMSvQPanG6iRgJh9gD
 aLTTzVVZBVMb+iVyewkYdVkV2r225wQzqsIcwsN7Ob/05Wua+qmQKtmQ8GGvOlFG3hX9w/IC2Yy
 CyIFLg==
X-Received: by 2002:a17:903:94e:b0:2aa:d6a1:e183 with SMTP id
 d9443c01a7336-2aad6a1e24cmr42190065ad.1.1770609556751; Sun, 08 Feb 2026
 19:59:16 -0800 (PST)
MIME-Version: 1.0
References: <20260208-bsd-user-claude-v2-0-58e5fcfdb84f@bsdimp.com>
 <20260208-bsd-user-claude-v2-15-58e5fcfdb84f@bsdimp.com>
 <60f644bf-db93-4f8d-bc39-d1cf2af50c1a@linaro.org>
In-Reply-To: <60f644bf-db93-4f8d-bc39-d1cf2af50c1a@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Sun, 8 Feb 2026 20:59:05 -0700
X-Gm-Features: AZwV_QjlHebeKPh6XxiAl0D8nropiakrEZyANldzrAU6dhFx7JBYq9m9qPS5qRw
Message-ID: <CANCZdfoVoAFHjfYCZaP1V8Oc447x7Bw2LeBCB2pB-=mtWQTDAA@mail.gmail.com>
Subject: Re: [PATCH v2 15/24] bsd-user: Add do_bsd_uuidgen implementation
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000aa941e064a5c29f8"
Received-SPF: none client-ip=2607:f8b0:4864:20::634;
 envelope-from=wlosh@bsdimp.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

--000000000000aa941e064a5c29f8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 8, 2026 at 7:04=E2=80=AFPM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 2/9/26 05:26, Warner Losh wrote:
> > From: Stacey Son <sson@FreeBSD.org>
> >
> > Add implementation of uuidgen(2) syscall that generates UUIDs and
> > converts them to target ABI format.
> >
> > Signed-off-by: Stacey Son <sson@FreeBSD.org>
> > Signed-off-by: Warner Losh <imp@bsdimp.com>
> > ---
> >   bsd-user/bsd-misc.h | 29 +++++++++++++++++++++++++++++
> >   1 file changed, 29 insertions(+)
> >
> > diff --git a/bsd-user/bsd-misc.h b/bsd-user/bsd-misc.h
> > index d81b4fbaef..ad248c3b79 100644
> > --- a/bsd-user/bsd-misc.h
> > +++ b/bsd-user/bsd-misc.h
> > @@ -43,6 +43,35 @@ static inline abi_long do_bsd_reboot(abi_long how)
> >       return -TARGET_ENOSYS;
> >   }
> >
> > +/* uuidgen(2) */
> > +static inline abi_long do_bsd_uuidgen(abi_ulong target_addr, int count=
)
> > +{
> > +    int i;
> > +    abi_long ret;
> > +    g_autofree struct uuid *host_uuid;
>
> autofree variables *must* be initialized.
> NULL is sufficient.
>

OK. I'd forgotten that.. Thanks for the reminder.


> > +
> > +    if (count < 1 || count > 2048) {
>

I've also added a comment that 2048 is the kernel limit, but there's no
#define nor sysctl to query it.


> > +        return -TARGET_EINVAL;
> > +    }
> > +
> > +    host_uuid =3D g_malloc(count * sizeof(struct uuid));
> > +
> > +    ret =3D get_errno(uuidgen(host_uuid, count));
> > +    if (is_error(ret)) {
> > +        goto out;
> > +    }
> > +    for (i =3D 0; i < count; i++) {
> > +        ret =3D host_to_target_uuid(target_addr +
> > +            (abi_ulong)(sizeof(struct target_uuid) * i), &host_uuid[i]=
);
> > +        if (is_error(ret)) {
> > +            goto out;
>
> break is sufficient.
>

So it is...

Warner


> r~
>
> > +        }
> > +    }
> > +
> > +out:
> > +    return ret;
> > +}
> > +
> >   /* getdtablesize(2) */
> >   static inline abi_long do_bsd_getdtablesize(void)
> >   {
> >
>
>
>

--000000000000aa941e064a5c29f8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Sun, Feb 8, =
2026 at 7:04=E2=80=AFPM Richard Henderson &lt;<a href=3D"mailto:richard.hen=
derson@linaro.org">richard.henderson@linaro.org</a>&gt; wrote:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">On 2/9/26 05:26, Warner Losh=
 wrote:<br>
&gt; From: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
&gt; <br>
&gt; Add implementation of uuidgen(2) syscall that generates UUIDs and<br>
&gt; converts them to target ABI format.<br>
&gt; <br>
&gt; Signed-off-by: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
&gt; Signed-off-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com" targe=
t=3D"_blank">imp@bsdimp.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0bsd-user/bsd-misc.h | 29 +++++++++++++++++++++++++++++<br>
&gt;=C2=A0 =C2=A01 file changed, 29 insertions(+)<br>
&gt; <br>
&gt; diff --git a/bsd-user/bsd-misc.h b/bsd-user/bsd-misc.h<br>
&gt; index d81b4fbaef..ad248c3b79 100644<br>
&gt; --- a/bsd-user/bsd-misc.h<br>
&gt; +++ b/bsd-user/bsd-misc.h<br>
&gt; @@ -43,6 +43,35 @@ static inline abi_long do_bsd_reboot(abi_long how)<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return -TARGET_ENOSYS;<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +/* uuidgen(2) */<br>
&gt; +static inline abi_long do_bsd_uuidgen(abi_ulong target_addr, int coun=
t)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 int i;<br>
&gt; +=C2=A0 =C2=A0 abi_long ret;<br>
&gt; +=C2=A0 =C2=A0 g_autofree struct uuid *host_uuid;<br>
<br>
autofree variables *must* be initialized.<br>
NULL is sufficient.<br></blockquote><div><br></div><div>OK. I&#39;d forgott=
en that.. Thanks for the reminder.</div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (count &lt; 1 || count &gt; 2048) {<br></blockquote>=
<div><br></div><div>I&#39;ve also added a comment that 2048 is the kernel l=
imit, but there&#39;s no #define nor sysctl to query it.</div><div>=C2=A0</=
div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -TARGET_EINVAL;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 host_uuid =3D g_malloc(count * sizeof(struct uuid));<br=
>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 ret =3D get_errno(uuidgen(host_uuid, count));<br>
&gt; +=C2=A0 =C2=A0 if (is_error(ret)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 for (i =3D 0; i &lt; count; i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D host_to_target_uuid(target_addr +=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (abi_ulong)(sizeof(struct t=
arget_uuid) * i), &amp;host_uuid[i]);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (is_error(ret)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
<br>
break is sufficient.<br></blockquote><div><br></div><div>So it is...</div><=
div><br></div><div>Warner</div><div>=C2=A0</div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">
r~<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +out:<br>
&gt; +=C2=A0 =C2=A0 return ret;<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0/* getdtablesize(2) */<br>
&gt;=C2=A0 =C2=A0static inline abi_long do_bsd_getdtablesize(void)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt; <br>
<br>
<br>
</blockquote></div></div>

--000000000000aa941e064a5c29f8--

