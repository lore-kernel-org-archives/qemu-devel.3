Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4483C982DA
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 02:39:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8TvN-0006sW-0P; Sun, 20 Sep 2026 22:38:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1x8TvL-0006sO-NA
 for qemu-devel@nongnu.org; Sun, 20 Sep 2026 22:38:31 -0400
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1x8TvJ-0002B5-CB
 for qemu-devel@nongnu.org; Sun, 20 Sep 2026 22:38:31 -0400
Received: by mail-pz2-x10.google.com with SMTP id
 d2e1a72fcca58-85469a33c9cso3342911b3a.0
 for <qemu-devel@nongnu.org>; Sun, 20 Sep 2026 19:38:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789958307; cv=none;
 d=google.com; s=arc-20260327;
 b=BtG2Zb66vRor4K3jQn0bJRYOMTleARh1tRobHOdAOD21R17SwmlcbS5ZRhAkJFaTTH
 EqONVnn4IYBmaqLWqabGZxvUeLLgTtuNQ5NaJO9emVkdg3KWkegXSPfugVIPAKtvz4pT
 YkFQ81ZOS0UuvuuHCJ7A7wCRIezEMamn5GLZpHFedXIvDdeBxHVIV1IBeWd90KfoamSh
 9BTZvxnTH0ClCFmovrSQ/gvPXlPdwAxu0ynnUYARzGnE2vNEwfkQuiWZobLyhq3CnhPk
 GMRJIhVJkf0ngOlCHx8yNKIw3bziFssmE0Cq7nWkm4SpSE1yisipwYvbjxFhsSETAQOY
 dMVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=7srmsyt5o7JS668pRrHZkL7pqB2sDob+W/Eq1beMSCA=;
 fh=rlUQkUrV+2wvL97nNNwjCaJG84ej6IucOR2StcsJUgM=;
 b=M06kbXRkqbfNaE6g9OuxHzkUCWGACLwq0xtZduHiZu/qwof9SzvtKSJWsQVABsJu2I
 RSsbKpDh5Q7EKpgEMrvvQ18Wog8JMvnctlxTN65uJJGQh/TCbMSunk08E+9baygUEvPf
 PdV5ODWbY/YNWKtWvGY+9uQ/kn4ZCDvpQkTL56fespvgBhXj1AnN4DhooPOfBelY6F6s
 tIHwrJ5QpFIOVbLPAcvL3j806ybwOBPGqlhsLxe0qfj3pAMGD6xSf8lWv5GPlylmfdMc
 bFQLA46VRHJ7yJBI+oyNhjaV/PZHpsYxOalDRzk+tygCH4PgZHb1iJyOAA2TnnhyRL+z
 VxAA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1789958307; x=1790563107;
 darn=nongnu.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=7srmsyt5o7JS668pRrHZkL7pqB2sDob+W/Eq1beMSCA=;
 b=O/DpOyqPGi517PyJWrFJGwLKugqH0TWwOQogZZWTzG+k0FCqotBi7WuI+1WdG5ZG6m
 PpgZBCVOCG9oZvPqFqiV1xHjeZ6VEzKuzD/uuoWsC/5Xa01v/K6nC5/6LLTWq4gliEJP
 9rqZw94BthFhofpVZNsk1cLcUaIvNyyRdA+/lHEXqmskdJb7UKMWhqPmPZ9SURxT4xpJ
 z92SsUL0D9jwON9SalPtlULhA2BsFTKT0V5QHY69eUppBkmrtXYCif807HlfPDilm1rZ
 HNMK5G7DCeW5swNr6Rh8/5DAK6QtomT2GEYef27k/YUiQW86VBeDPyCa0doHwMvR+yJ/
 +o8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789958307; x=1790563107;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=7srmsyt5o7JS668pRrHZkL7pqB2sDob+W/Eq1beMSCA=;
 b=pGqp/d8QEtauP3s9HiC9jsw4rXF1aJl2+kLpBrJ2V5ffH8Rnz6iyJW9kjsBh09yCT0
 wy6/YraxbCzkHgP6askeFYjZEN2AV3GGH4kvDNglRlCSAS4N9WNCgyWnPd8qDadKO3b2
 B709IiUwPzy2bT295lo96sHYCMe3U6BjTiDMMb87KKfIC1Lj6s0aV3fu5TqNolZ09FEx
 meYo6eGUQBxIxU+I5BLhnrbyjEGFV9LXOkdKyaPSFgRm6lFHf5dBbB65qU8+KqfxW+WI
 fjH6xuZ/6HxX25MMs09uRJUL6TnNJEQ/t6qUyGiMG0h8Q2CMvzVWa64RPIY8zGzc13Sn
 Hezg==
X-Gm-Message-State: AFuF++lL7xuiIurH+OnM4thJ3In9roPdfrg4SCcgRkJafUgrP+q//ePA
 HDSL0I9IlAdJ9RFWPP3VbyFie6JKHbdWgASLVE6YVY4+AkngIcRu0L1j7mmHyPA82J1QiZSCtKE
 4BecwjOGxO5F2aX2O7gzLXUqcNRySUDDcTthDcxnI8g==
X-Gm-Gg: AYBFou0TgwIjpQ27LJVj0+9wNa0DVsU/2rlCDkH93o5+7QC6I2jSuEVXAySxdyTe0Ns
 V7k8PAyFvwkom+JKtASMsJmTj2hDP2Mg9agLOT+IbUcV1HVaAm5Z84HCBBcRFKprOgDK9Sl0yG6
 5gTmNzOT690wy1eZ8ea92C+VrLw0hSerCxaHNiNuXocP95OJpF4EN+kxwKxR2X4+/fEjdDnbUdO
 orsnnvSgsOMFmHdJ3o7xzD7vELdlr4GawLes04nyTz800GDExSzZPmeh8S4F38oXfKlrlBtByhZ
 zB6NZi3v0qxsCDXW6TfbyB2Whod2/UiutGGIKlsb1C28Ms/1KcvAkPYVKpm6GjAAyXGMotPI9Bs
 XFDaJAXGCLw==
X-Received: by 2002:a05:6a00:ad08:b0:857:726d:270e with SMTP id
 d2e1a72fcca58-874dea02499mr13431928b3a.26.1789958307030; Sun, 20 Sep 2026
 19:38:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260919-misc-2025q4-v1-0-ebfa61049bd7@bsdimp.com>
 <20260919-misc-2025q4-v1-6-ebfa61049bd7@bsdimp.com>
 <0b7b6ab1-5d55-42fe-8591-f67f8143c7ac@linaro.org>
In-Reply-To: <0b7b6ab1-5d55-42fe-8591-f67f8143c7ac@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Sun, 20 Sep 2026 20:38:15 -0600
X-Gm-Features: AcwNN1WQpGJsk11m4Oc8btba1ZJVoHw5EhwCkWTRvKtrVnIVaOXxr_tTTCb1cpE
Message-ID: <CANCZdfqvUVbR77k8Py69JzGdqiCDs7YbRk5y8+111K7xWbZu-g@mail.gmail.com>
Subject: Re: [PATCH 06/14] bsd-user: Fix crazy bug with mmap
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Kyle Evans <kevans@freebsd.org>
Content-Type: multipart/alternative; boundary="0000000000000dba54065bf52557"
Received-SPF: none client-ip=2607:f8b0:4864:3b::10;
 envelope-from=wlosh@bsdimp.com; helo=mail-pz2-x10.google.com
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

--0000000000000dba54065bf52557
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 20, 2026 at 4:09=E2=80=AFPM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 9/19/26 19:20, Warner Losh wrote:
> > +++ b/bsd-user/mmap.c
> > @@ -215,10 +215,13 @@ static int mmap_frag(abi_ulong real_start,
> >
> >       prot_new =3D prot | prot1;
> >       if (fd !=3D -1) {
> > -        /* msync() won't work here, so we return an error if write is
> > -           possible while it is a shared mapping */
> > -        if ((flags & TARGET_BSD_MAP_FLAGMASK) =3D=3D MAP_SHARED &&
> > -            (prot & PROT_WRITE))
> > +        /*
> > +         * msync() won't work here, so we return an error if write is
> > +         * possible while it is a shared mapping
> > +         */
> > +        if (!(flags & MAP_ANON)
> > +            && (flags & MAP_TYPE) =3D=3D MAP_SHARED
> > +            && (prot & PROT_WRITE))
> >               return -1;
> >
> >           /* adjust protection to be able to read */
>
> Need braces, even if they were missing beforehand.  Otherwise,
>

OK. I'll fix this for this series, but I'm tempted to land my 'fix all the
style bugs in bsd-user' patches
since this issue stubs my toe all the time.


> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>

Thanks!


> r~
>

--0000000000000dba54065bf52557
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Sun, Sep 20,=
 2026 at 4:09=E2=80=AFPM Richard Henderson &lt;<a href=3D"mailto:richard.he=
nderson@linaro.org">richard.henderson@linaro.org</a>&gt; wrote:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">On 9/19/26 19:20, Warner Lo=
sh wrote:<br>
&gt; +++ b/bsd-user/mmap.c<br>
&gt; @@ -215,10 +215,13 @@ static int mmap_frag(abi_ulong real_start,<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0prot_new =3D prot | prot1;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (fd !=3D -1) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* msync() won&#39;t work here, so we ret=
urn an error if write is<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0possible while it is a share=
d mapping */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((flags &amp; TARGET_BSD_MAP_FLAGMASK)=
 =3D=3D MAP_SHARED &amp;&amp;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (prot &amp; PROT_WRITE))<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* msync() won&#39;t work here, so w=
e return an error if write is<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* possible while it is a shared map=
ping<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(flags &amp; MAP_ANON)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;&amp; (flags &amp; MAP=
_TYPE) =3D=3D MAP_SHARED<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;&amp; (prot &amp; PROT=
_WRITE))<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* adjust protection to be abl=
e to read */<br>
<br>
Need braces, even if they were missing beforehand.=C2=A0 Otherwise,<br></bl=
ockquote><div><br></div><div>OK. I&#39;ll fix this for this series, but I&#=
39;m tempted to land my &#39;fix all the style bugs in bsd-user&#39; patche=
s</div><div>since this issue stubs my toe all the time.</div><div>=C2=A0</d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex">
Reviewed-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@lina=
ro.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;<br></blockqu=
ote><div><br></div><div>Thanks!</div><div>=C2=A0</div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">
r~<br>
</blockquote></div></div>

--0000000000000dba54065bf52557--

