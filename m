Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82CBAECD9BF
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 02:45:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voBql-0001sU-AR; Thu, 05 Feb 2026 21:45:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1voBqi-0001rp-1N
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 21:45:37 -0500
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1voBqf-0004Rg-7F
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 21:45:35 -0500
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-35334ea1f98so731728a91.1
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 18:45:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770345920; cv=none;
 d=google.com; s=arc-20240605;
 b=ceCBQUJSQEUUKhxLKFKvCRLrZyresPrdwVYewPfZyLSsNLR5Pdgv5scm4RWeF37iVk
 2YcYeECxKkWvSGePWyP/Sygat5USvMXwpr28A2vO1XgL5PxCUCabqfOJ93OJ4V+bKqTR
 w8CgbpMvL2YGrd6vrvF66FkUilHNHNQZY5dETKQuM/J5LyETB84qmTYrby/jUDHvA3Eh
 nul9Qc2kZWcLHROuIbZGAoVgQ5yA6OCpDPDm5Pd5c4qdT23pI8z2LfJ1+xnYcMComqSl
 6tpr2GuWgIFxJHlHJrSLEn8oO4sh5aIufG8Pmf+zkNhIGrOU5rpSti37s1uQPPI0V+zT
 fN1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=dt59y2xSfNQaI8++IPEitv86UroTOxsfWCr9SLZlW8s=;
 fh=GI2e/SBiq4MTIPc9mHou6R6WJe3VvhdDMWKbaXflkfU=;
 b=TVyilKrXobem/do1GOit8gOMAmFPU6/k/N1g1cq+1zbWUQrOlYaYDIDEeqLwnJSDfH
 SG+3s9jqZDPzRISjhcMnwwrimVTUJyGWG1BuqdNZGK0NfUbKyqCVMaGIrUBW4EKLo109
 iIfQ5+jr7wdQZiS19mprG/jI7taq7+8Lx7pUouxwmj7QGZevf2uCwxdkl8e2OACU+UHQ
 OpFXGOSN/jXDfhRRcd/1TTTv257ns0NRYv0zBnQY5fUPtckMz+pk4Xu9/hLLIoByPDVa
 98WJyml8CyZ9uMcKFnC6kME8GlUhuXebUN6sXAQuNK2I5UoP88vkEMc4A0OY1dZCZSb7
 vVDQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1770345920; x=1770950720;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dt59y2xSfNQaI8++IPEitv86UroTOxsfWCr9SLZlW8s=;
 b=z5Md5KNh76Y0Z12+KkDnMiZEC5jo701gdXx/rm+XBUeCi37dF8YApY83V6nhWJ8uQI
 gIH2yZycP4ZA9DOByPrFdIj7WwSBc5yDilA/lB5IaqdsoULg3V6hKJZy+mlkRqX75yHE
 afd9Cx4Cs2CcCcDwaLDK7Cv0Qp5K/7I2OPQ1uYeEWoSsWUGK5xqTtANo3MhsVEijlvAP
 Op/ULon3eHaxrWjk/4vTN3nSZqbaYfeUXtMa6X4KaQOP0w8WQ5GWsXelWe13rBRCBVpt
 Mr0+pNE1j9Q+qGtGZcg9nnJAsc48nVouFJMcB5A/VhPAe4gI3HsUq0BYWGy4zrFV4WLH
 1Cdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770345920; x=1770950720;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dt59y2xSfNQaI8++IPEitv86UroTOxsfWCr9SLZlW8s=;
 b=alrQ8Plw5QNAAWlb4mBEccpeOfr+Iv1KPa+D0NXNmgedr6D6y4z6dwMyiH4g2hNooT
 gHiXg/zqgdF5IVcHcKEIfrIlNXdRviAOG28RoB/MZ67IWmq1K38IS0GljPztApVutzQv
 v4rioW+eAttzR/+2YLzV48XjMuUvDm2Qiu5HXQif7xpdP/JTdNhA4b6jmSWPbsUabSHy
 5q3M+1rCAUlYajxZ6fKlgHuUodTWI6e/hNUpqguhr/UgWKhmUUbsHcuF5suugZAvyjWv
 qbzij+Z7fKrnoDnPsq3+AkRnokNfHcV+8zl51YSmElDVnyYl0pEws+XgDdMLd/laxg+P
 yDUg==
X-Gm-Message-State: AOJu0Yxt7Nlxwwdlw2kL9C8iaykt0buGWMiqJN/5vSdZjPHZxnlt24yo
 y2pOe0S4m30BPdJxLHlJzsxF2mB6lLH4Wm3PQ21NNBWA7o1w9qBSljXz2cpRtVgcp8mirnjuzqS
 YpAcXLlsIgGhsUKVoOghzLR8jTKQGfG1BoBOyhJDqeWa/CyobWBkyJQk=
X-Gm-Gg: AZuq6aKbejKNg3clAP3P3WjjAjypN03kUjObdT/RUiHEWtiObOP5AnSeVjikWDHfY4k
 GOp8B5jPhE1eOh72cSIKoVp6ne9iL8XdbUjHzLd1b4LavDS9hg2VSK+5uGpqa8thluI191HETAN
 3NItD1oI0GpJfGtvQoEnZ8gq4obT//zZBXvjVtatVfSuRVWRvVbknGlZYi93iOkTb1vkBaMW/T/
 Jn3Tliqs5csTF+jVXIMwDsNCXQtBMa1NvTs2g84VtcMClaEuXHUeWFotC6uybsOT+qrrAs=
X-Received: by 2002:a17:90b:1d52:b0:34e:5516:3fe3 with SMTP id
 98e67ed59e1d1-354b3c84de4mr998523a91.11.1770345920478; Thu, 05 Feb 2026
 18:45:20 -0800 (PST)
MIME-Version: 1.0
References: <20260205-bsd-user-claude-v1-0-8d8ff0035372@bsdimp.com>
 <20260205-bsd-user-claude-v1-8-8d8ff0035372@bsdimp.com>
 <c4925c4c-0562-4033-8a6b-5311dd419c9b@linaro.org>
In-Reply-To: <c4925c4c-0562-4033-8a6b-5311dd419c9b@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Thu, 5 Feb 2026 19:45:09 -0700
X-Gm-Features: AZwV_Qh0zoYPKoVfUw6yWJ4rlGnXo3b1Z0fTH1LOAZ5i_cDCsPwZMOFBGTWJnDs
Message-ID: <CANCZdfr0v-U_jveZorvU76vAxZkMT=p55P5E7OJTi7W-+Fi8sw@mail.gmail.com>
Subject: Re: [PATCH 08/24] bsd-user: Add host_to_target_semarray for semaphore
 operations
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000b84bd0064a1ec792"
Received-SPF: none client-ip=2607:f8b0:4864:20::1029;
 envelope-from=wlosh@bsdimp.com; helo=mail-pj1-x1029.google.com
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

--000000000000b84bd0064a1ec792
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 5, 2026 at 6:47=E2=80=AFPM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 2/6/26 03:26, Warner Losh wrote:
> > From: Stacey Son <sson@FreeBSD.org>
> >
> > Add host_to_target_semarray() to convert host semaphore array to target
> > format for semctl(2) GETALL operations.
> >
> > Signed-off-by: Stacey Son <sson@FreeBSD.org>
> > Signed-off-by: Warner Losh <imp@bsdimp.com>
> > ---
> >   bsd-user/bsd-misc.c | 32 ++++++++++++++++++++++++++++++++
> >   1 file changed, 32 insertions(+)
> >
> > diff --git a/bsd-user/bsd-misc.c b/bsd-user/bsd-misc.c
> > index 07d8bf1304..7bdf65450a 100644
> > --- a/bsd-user/bsd-misc.c
> > +++ b/bsd-user/bsd-misc.c
> > @@ -79,3 +79,35 @@ abi_long target_to_host_semarray(int semid, unsigned
> short **host_array,
> >
> >       return 0;
> >   }
> > +
> > +abi_long host_to_target_semarray(int semid, abi_ulong target_addr,
> > +        unsigned short **host_array)
> > +{
> > +    abi_long ret;
> > +    int nsems, i;
> > +    unsigned short *array;
> > +    union semun semun;
> > +    struct semid_ds semid_ds;
> > +
> > +    semun.buf =3D &semid_ds;
> > +
> > +    ret =3D semctl(semid, 0, IPC_STAT, semun);
> > +    if (ret =3D=3D -1) {
> > +        free(*host_array);
> > +        return get_errno(ret);
> > +    }
> > +
> > +    nsems =3D semid_ds.sem_nsems;
> > +    array =3D (unsigned short *)lock_user(VERIFY_WRITE, target_addr,
> > +        nsems * sizeof(unsigned short), 0);
> > +    if (array =3D=3D NULL) {
> > +        free(*host_array);
> > +        return -TARGET_EFAULT;
> > +    }
> > +    for (i =3D 0; i < nsems; i++) {
> > +        array[i] =3D (*host_array)[i];
> > +    }
> > +    free(*host_array);
> > +    unlock_user(array, target_addr, 1);
> > +    return 0;
> > +}
> >
>
> You can simplify this a bit:
>
> ...     unsigned short **host_arrayp)
> {
>      g_autofree unsigned short *host_array =3D *host_arrayp;
>
> which now takes care of releasing the memory across all return paths.
> You also don't need double-indirection in the loop.
>
> You do need __put_user (or tswap16) in the loop for endianness.
>

Right you are. Thanks! Will fix in v2

Warner


>
> r~
>
>

--000000000000b84bd0064a1ec792
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Feb 5, =
2026 at 6:47=E2=80=AFPM Richard Henderson &lt;<a href=3D"mailto:richard.hen=
derson@linaro.org">richard.henderson@linaro.org</a>&gt; wrote:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">On 2/6/26 03:26, Warner Losh=
 wrote:<br>
&gt; From: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
&gt; <br>
&gt; Add host_to_target_semarray() to convert host semaphore array to targe=
t<br>
&gt; format for semctl(2) GETALL operations.<br>
&gt; <br>
&gt; Signed-off-by: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
&gt; Signed-off-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com" targe=
t=3D"_blank">imp@bsdimp.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0bsd-user/bsd-misc.c | 32 ++++++++++++++++++++++++++++++++<=
br>
&gt;=C2=A0 =C2=A01 file changed, 32 insertions(+)<br>
&gt; <br>
&gt; diff --git a/bsd-user/bsd-misc.c b/bsd-user/bsd-misc.c<br>
&gt; index 07d8bf1304..7bdf65450a 100644<br>
&gt; --- a/bsd-user/bsd-misc.c<br>
&gt; +++ b/bsd-user/bsd-misc.c<br>
&gt; @@ -79,3 +79,35 @@ abi_long target_to_host_semarray(int semid, unsigne=
d short **host_array,<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt;=C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +abi_long host_to_target_semarray(int semid, abi_ulong target_addr,<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned short **host_array)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 abi_long ret;<br>
&gt; +=C2=A0 =C2=A0 int nsems, i;<br>
&gt; +=C2=A0 =C2=A0 unsigned short *array;<br>
&gt; +=C2=A0 =C2=A0 union semun semun;<br>
&gt; +=C2=A0 =C2=A0 struct semid_ds semid_ds;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 semun.buf =3D &amp;semid_ds;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 ret =3D semctl(semid, 0, IPC_STAT, semun);<br>
&gt; +=C2=A0 =C2=A0 if (ret =3D=3D -1) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 free(*host_array);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return get_errno(ret);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 nsems =3D semid_ds.sem_nsems;<br>
&gt; +=C2=A0 =C2=A0 array =3D (unsigned short *)lock_user(VERIFY_WRITE, tar=
get_addr,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 nsems * sizeof(unsigned short), 0);<br>
&gt; +=C2=A0 =C2=A0 if (array =3D=3D NULL) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 free(*host_array);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -TARGET_EFAULT;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 for (i =3D 0; i &lt; nsems; i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 array[i] =3D (*host_array)[i];<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 free(*host_array);<br>
&gt; +=C2=A0 =C2=A0 unlock_user(array, target_addr, 1);<br>
&gt; +=C2=A0 =C2=A0 return 0;<br>
&gt; +}<br>
&gt; <br>
<br>
You can simplify this a bit:<br>
<br>
...=C2=A0 =C2=A0 =C2=A0unsigned short **host_arrayp)<br>
{<br>
=C2=A0 =C2=A0 =C2=A0g_autofree unsigned short *host_array =3D *host_arrayp;=
<br>
<br>
which now takes care of releasing the memory across all return paths.<br>
You also don&#39;t need double-indirection in the loop.<br>
<br>
You do need __put_user (or tswap16) in the loop for endianness.<br></blockq=
uote><div><br></div><div>Right you are. Thanks! Will fix in v2</div><div><b=
r></div><div>Warner</div><div>=C2=A0</div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">
<br>
r~<br>
<br>
</blockquote></div></div>

--000000000000b84bd0064a1ec792--

