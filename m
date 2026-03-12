Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F63F105A591
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 12:20:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0f0y-00019K-2U; Thu, 12 Mar 2026 08:19:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikingtc4@gmail.com>)
 id 1w0f0w-00018N-7W
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 08:19:42 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <vikingtc4@gmail.com>)
 id 1w0f0t-0007l6-RI
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 08:19:41 -0400
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7d55b97f358so754232a34.3
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 05:19:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773317978; cv=none;
 d=google.com; s=arc-20240605;
 b=U9XdpaCFmOkPNFAjIvIw4yIJ5k9DPSas/NpsOGOaJb060EraT/GnpvOk/SYCpAUWfM
 E4sI5737ALeTJcMTJu/vXmoWb+ZdgKjjyipgVTpn79+BYJWzqchyox0b4mNew5r08Zpi
 b/ColeUqAgi6vBa6oHiCwb2Tc6hWXQF1jjIuq8CszzcymqZRPXpOBN2lliMoOchzA7u9
 zjWvWIPO11+iDjcMlLfml2q6HkZkNyyaXHRZOEGqtUVvnor/D6dWAPw/4BV0mG8AIn0C
 3nkqPatlnr4rX8vUp79LPfKO4vXVcqrZEvrl9bClvq75p2om+J3dfgTQOZob0Q+sPG3v
 DC9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=mekxJSGbWdjsK9hbEP3sjvsJfLvaJlVrZRJ1ObCsn5c=;
 fh=GNpqN5F/FwnVjMoCd1YevecAvtYrD8kwzPEEE+7sys0=;
 b=CBuNy9u2QSEjrWk62GxsGu1r1PHShdnQXdAcotuxCpWwUS2cbuYD1LRBixHnEqb7XX
 pMgNRBCB9E54vHlVTHf9Kuf3mZercyN8/niRP+KOcbnzIJ0tPhgJ/WJnOz1qGuf3/uNL
 j/+3jgS/QakzC7jW/JL6XGyqE+N5nKVs7OkQY4rUeGJvXAw8ozi4+BROm4P4P+43qCBj
 mXYONNKThEve9IvQ1Us5MsF2Q0JKiZt2wKQWUqcwXiHbRaWqE8D1wXiltNCa2PqNaJEN
 hNdtYbxTWXtIODEvYDi2Hrog93qtiVWpEy+sbqJVkkRxOXwq0yT9fexDCuMPtGz3zlJa
 04fQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773317978; x=1773922778; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mekxJSGbWdjsK9hbEP3sjvsJfLvaJlVrZRJ1ObCsn5c=;
 b=Qw1eV2+Sqnf9g367Q9MiCjjVz6ikww5WEEhcDd98op+A+h20/fffEGSfgtlS6i7Nwe
 +5agPqZEvGcFFB2yU/qw6jVMBFVdxrRCjGSK5DAQEYzOgPxwfCCuJz1+SzqxSt3lP1eH
 q+t/W2y8QSNBXPcslUiqSdPsvFRQBKvscSX0yJrYww+gGL0M9vi13k23WGfrXx70f3xj
 g/YQlS2zy8ITr15tEvU9ngOjfQV4SYav3op8lBSqDOFg42pMz0oPq9SVOtoPw5mkMofs
 SJigVG8psUrrYaDcGu2iLnawOmjvywh73Q7d3FsqAMP8lnsYhfYqhjVpFb9MCLgTw2rs
 7ZiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773317978; x=1773922778;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mekxJSGbWdjsK9hbEP3sjvsJfLvaJlVrZRJ1ObCsn5c=;
 b=gxOeN9b3K/Wvs2KsZ9gk9jIuM2EhI1pG1762Fb0+WnhrCLwoYNVrDA5WgDBV3KDpkM
 ZcS9JDIl/oCqHKu2aR/8nEJ+MpP0hUp0lzv6E84gL9ZXjSyYdsZVFyZrfrvG8sRmqKwW
 TaPULdTD9u2G8hE7lB3KdwY8evpdLVQ//mZhmfKunAAPFAhzHyT4dFqKcnDYid7ssOp3
 wKJVlRx4GRuYHRq551VQb4YJd3gGS/jVCvVhdNNDI/SwgFvfyOcl5dBaxWKynQFWHiTx
 dUp8dZgpf0h+6YE/L0PJ0wgqIu7rg1oXaBuYhoHmbZVxd2YippBcwUCtzHAecKXviLlY
 yQSw==
X-Gm-Message-State: AOJu0YyMJzVigew/YY01oS5URxU/7p98Q2AdefsZefWUsDeoORmwrqhI
 cvZSq3P4Mr8eiGuPvKMnTyIHUt7ES0rlL4rfL9dAq3VQNGuFmQioLA7twNztvq9Wtz2FFtD1jHN
 M4Izt3AuaVajWWC/ex+Nl5Wrgj4d+t28=
X-Gm-Gg: ATEYQzxiLTPKjkI0Rnnxlx+40b0dzrVLrOKWsz/i/PIaK9hMkqrttoBr9JIyMr8jeDd
 5ZXeqpK2xLQ/JIdoNvJMMBi/wyqEznTvF+K7v4kDOSRpjGoq/M7wsXMphOTTag/WE1aTH95ptKK
 I0mu3ygI4pGqdYS197gfoYPjsewXipwmRrlt8p1SDRklD8NOzl0zDSWqxOGdNy8vdFNZYOdcQXY
 p4tkDJ7qkjUoD3d/F4wQgsD3ZvuWxdj/EWzx3LKaT9DaaOT0crkYmkXUdLjO/0Ax08PS9J1mfSO
 erYAAEK9HQ==
X-Received: by 2002:a05:6820:4dc9:b0:67a:1d88:46d5 with SMTP id
 006d021491bc7-67bc88c7600mr3251930eaf.31.1773317978230; Thu, 12 Mar 2026
 05:19:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260312085220.194207-1-vikingtc4@gmail.com>
 <CAFEAcA9SxRVkosA0HMfomLKAVxHki4xOR-LyLWAFEn24K56mMg@mail.gmail.com>
In-Reply-To: <CAFEAcA9SxRVkosA0HMfomLKAVxHki4xOR-LyLWAFEn24K56mMg@mail.gmail.com>
From: Trieu Huynh <vikingtc4@gmail.com>
Date: Thu, 12 Mar 2026 19:19:27 +0700
X-Gm-Features: AaiRm529PIwulykwoB5F8ccHp4n6M1bXeoVcolTRzfaEX2YGdF3be9vmGqbftUc
Message-ID: <CAMO1v35eCFdNaCE=Wtfo+w-9y8cbLuWBD0sadLsZXm8HVfZAJw@mail.gmail.com>
Subject: Re: [PATCH] block/curl: Fix Resource Leak in curl_header_cb
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com, 
 qemu-block@nongnu.org, "trieu2.huynh" <trieu2.huynh@lge.com>
Content-Type: multipart/alternative; boundary="0000000000002a947d064cd2c461"
Received-SPF: pass client-ip=2607:f8b0:4864:20::336;
 envelope-from=vikingtc4@gmail.com; helo=mail-ot1-x336.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--0000000000002a947d064cd2c461
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

ack.

BRs,


V=C3=A0o Th=E1=BB=A9 5, 12 thg 3, 2026 va=CC=80o lu=CC=81c 16:34 Peter Mayd=
ell <
peter.maydell@linaro.org> =C4=91=C3=A3 vi=E1=BA=BFt:

> On Thu, 12 Mar 2026 at 08:53, Trieu Huynh <vikingtc4@gmail.com> wrote:
> >
> > From: "trieu2.huynh" <trieu2.huynh@lge.com>
> >
> > The function curl_header_cb uses g_autofree with
> g_strstrip(g_strndup(...)).
> > However, g_strstrip may return a pointer that is an offset from the
> > original allocated memory, causing g_autofree to attempt to free
> > an invalid pointer or leak the original.
>
> I don't believe this is correct. g_strstrip() will
> always return the string argument it is passed. (The glib
> documentation for g_strstrip() doesn't say so explicitly, but
> it is a macro for g_strchomp(g_strchug(string)), and both
> those functions say that they return the input argmuent.)
>
> > Separate the allocation and the stripping to ensure the original
> > pointer is correctly tracked and freed.
> >
> > Resolves: CID 1645633
> >
> > Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
> > ---
> >  block/curl.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/block/curl.c b/block/curl.c
> > index 66aecfb20e..5b66c80704 100644
> > --- a/block/curl.c
> > +++ b/block/curl.c
> > @@ -208,7 +208,8 @@ static size_t curl_header_cb(void *ptr, size_t size=
,
> size_t nmemb, void *opaque)
> >  {
> >      BDRVCURLState *s =3D opaque;
> >      size_t realsize =3D size * nmemb;
> > -    g_autofree char *header =3D g_strstrip(g_strndup(ptr, realsize));
> > +    g_autofree char *header =3D g_strndup(ptr, realsize);
> > +    g_strstrip(header);
>
> Being able to rewrite the code like this confirms that we
> don't actually have a leak -- we are still relying here on
> g_strstrip(X) =3D=3D X, just in a different way.
>
> >      char *val =3D strchr(header, ':');
> >
> >      if (!val) {
>
> This looks like a Coverity false positive to me, so I've marked it
> that way in the Coverity Scan UI.
>
> thanks
> -- PMM
>

--0000000000002a947d064cd2c461
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>ack.</div><div><div dir=3D"ltr" class=3D"gmail_signat=
ure" data-smartmail=3D"gmail_signature"><div dir=3D"ltr"><div dir=3D"ltr"><=
div dir=3D"ltr"><p class=3D"MsoNormal" style=3D""><font color=3D"#0b5394">B=
Rs,</font></p></div></div></div></div></div><br></div><br><div class=3D"gma=
il_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">V=C3=
=A0o Th=E1=BB=A9 5, 12 thg 3, 2026 va=CC=80o lu=CC=81c 16:34 Peter Maydell =
&lt;<a href=3D"mailto:peter.maydell@linaro.org">peter.maydell@linaro.org</a=
>&gt; =C4=91=C3=A3 vi=E1=BA=BFt:<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">On Thu, 12 Mar 2026 at 08:53, Trieu Huynh &lt;<a href=3D"m=
ailto:vikingtc4@gmail.com" target=3D"_blank">vikingtc4@gmail.com</a>&gt; wr=
ote:<br>
&gt;<br>
&gt; From: &quot;trieu2.huynh&quot; &lt;<a href=3D"mailto:trieu2.huynh@lge.=
com" target=3D"_blank">trieu2.huynh@lge.com</a>&gt;<br>
&gt;<br>
&gt; The function curl_header_cb uses g_autofree with g_strstrip(g_strndup(=
...)).<br>
&gt; However, g_strstrip may return a pointer that is an offset from the<br=
>
&gt; original allocated memory, causing g_autofree to attempt to free<br>
&gt; an invalid pointer or leak the original.<br>
<br>
I don&#39;t believe this is correct. g_strstrip() will<br>
always return the string argument it is passed. (The glib<br>
documentation for g_strstrip() doesn&#39;t say so explicitly, but<br>
it is a macro for g_strchomp(g_strchug(string)), and both<br>
those functions say that they return the input argmuent.)<br>
<br>
&gt; Separate the allocation and the stripping to ensure the original<br>
&gt; pointer is correctly tracked and freed.<br>
&gt;<br>
&gt; Resolves: CID 1645633<br>
&gt;<br>
&gt; Signed-off-by: Trieu Huynh &lt;<a href=3D"mailto:vikingtc4@gmail.com" =
target=3D"_blank">vikingtc4@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 block/curl.c | 3 ++-<br>
&gt;=C2=A0 1 file changed, 2 insertions(+), 1 deletion(-)<br>
&gt;<br>
&gt; diff --git a/block/curl.c b/block/curl.c<br>
&gt; index 66aecfb20e..5b66c80704 100644<br>
&gt; --- a/block/curl.c<br>
&gt; +++ b/block/curl.c<br>
&gt; @@ -208,7 +208,8 @@ static size_t curl_header_cb(void *ptr, size_t siz=
e, size_t nmemb, void *opaque)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 BDRVCURLState *s =3D opaque;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 size_t realsize =3D size * nmemb;<br>
&gt; -=C2=A0 =C2=A0 g_autofree char *header =3D g_strstrip(g_strndup(ptr, r=
ealsize));<br>
&gt; +=C2=A0 =C2=A0 g_autofree char *header =3D g_strndup(ptr, realsize);<b=
r>
&gt; +=C2=A0 =C2=A0 g_strstrip(header);<br>
<br>
Being able to rewrite the code like this confirms that we<br>
don&#39;t actually have a leak -- we are still relying here on<br>
g_strstrip(X) =3D=3D X, just in a different way.<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 char *val =3D strchr(header, &#39;:&#39;);<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (!val) {<br>
<br>
This looks like a Coverity false positive to me, so I&#39;ve marked it<br>
that way in the Coverity Scan UI.<br>
<br>
thanks<br>
-- PMM<br>
</blockquote></div>

--0000000000002a947d064cd2c461--

