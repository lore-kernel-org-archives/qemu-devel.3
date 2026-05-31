Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F149CD6E52
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2026 18:22:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTkmw-00020j-Ht; Sun, 31 May 2026 14:21:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wTkmv-00020b-5I
 for qemu-devel@nongnu.org; Sun, 31 May 2026 14:21:29 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wTkmt-0003XE-4t
 for qemu-devel@nongnu.org; Sun, 31 May 2026 14:21:28 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2c0c1e0d00bso6144195ad.0
 for <qemu-devel@nongnu.org>; Sun, 31 May 2026 11:21:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780251685; cv=none;
 d=google.com; s=arc-20240605;
 b=f1+i9+dB/jEW1d6Ub9bgJh3qjDupXTfCTquqskVNgK+DenBnBXL2/aU+4XLYAqadhv
 Os4QjJfQbmG4tOFuaza5ul0tgZcyz/uZTJsjtkhV4e+OTp1YLlQRkvJgYgXcgYP9lDuJ
 kuXQcV2XUzHZxHqBbUnHMSYxwVBUYmylcdRjZA/NKd4QRgxNKkylNXbk0cxwoepEZ2gS
 /uRtqh5a7I5VpS3CMiBnKtybh6TLABR/0TjHSwmARSVjhNjafJ2uAoX8xh5+s8sqjByT
 D4DFQ252PLNZQozWYIexb3n4VoZZnyE4HiEAJqYBS4AmgDNBHTSW25LdazWdwBeXdOds
 WNrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Gj2fTau0XZClSxCqtUBb+S21OuadF0MOIhHItQCsflM=;
 fh=+DxRVnEC95Ptxk5HMfIFqaUwIao1HhLaAPFCgZPm1R4=;
 b=Ou6WNsHPbX5yADre/+VDNAYzBL9gY0e9BigTEwZRNy9trXsAoo88C0vpNuLJYLnYvV
 sUT2f/Dh4okoOSIUUnaKY9cVKPbcmM9e/u7RBbhHsX6mfmj0itTcChwq6502j2FFzkJj
 zUB/XHXRSRjvb+rExmRhBXoDzDOIrmrSA7IN+1pXuU2HkZcd+5dO2v28dEUV8KHy/fus
 kU0b9hnmZZPwBETlZeisAkbTrrt1JqA5yLvNSDJem+CIE1XjK51nSNix4ThqP7Artv5t
 a65ztg6zU0UV34RT4+A0dFaljhf09M0eobEjDd5NgG3YCanv2dMYW0CSJZihQOOWbmWL
 zCLg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1780251685; x=1780856485;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Gj2fTau0XZClSxCqtUBb+S21OuadF0MOIhHItQCsflM=;
 b=wmC34EujN2tfwwpH8BVatqwr6PiSejkhWOPTCGo4id6mfe8FlIqAq127PyB2a0kVsG
 JTxBvVqjrPJ0LquNPgnJcv4VFJmFwF8Q0HRydbJ8dYIKqyleg23qycyd7J7CqtdumVDw
 g0/K8XcYkhhEGseh8krZtmN43ZlPc6cisWY+XAy/TONhuP66WDErdK1cxQrGJXY5lSXv
 ra8anD6gSOZAra20YxCgiTpQDWERpkXmrHJ2SZanFmDWWKF1qLVRz1tNznmrVMydcPm+
 zaetzLNSkTsw17fsCNsuOpeB2TEcYT7AEr4yEiUezqmIVq1gEEvl6MAXSZbaCN8nD4eq
 dSMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780251685; x=1780856485;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gj2fTau0XZClSxCqtUBb+S21OuadF0MOIhHItQCsflM=;
 b=bfWvTk3ntf8nVBjxujN7Uv4PrvEbQJxbGNljAAtx2eZMuX5dA4QaGQhg8bTne44E7n
 6MymtyQAGudiAESLKmfakm+MoB/R34oFbMfJL9J0OzwQeUQdOUW7IRUjFZerBhV+Y1f3
 JRom6e23YfRPBu47tck83hQwPRFqjUbj6LBpantTi3rZuxaPkdD07UuEdMvSHD3ppZav
 AMfp1KlbiAJY0ZsuqNKfx+FWJSGgwPZc8oIJC92eULyIQ0B4YXSk/DS2kXlKGmcMskUL
 52Ct326Ql01ozbSzJ/NqX1piX7j9KAfP9agfTBwMhZwWpj/ThCS+Eibf6/Maal5j72mm
 szdw==
X-Gm-Message-State: AOJu0Yz5ZubDnskYI9T1gJ/bEfjzrLp41kyf46ZpIs5c6e+c1cFt+qAt
 CSk0+6y87astEMmGnJ2Ydt2CpeloyUFnaWdUZEg6OyIESTn3j1IgX2R6jo+Qhb7CVad653/1j1D
 NzDEPWHu9nvtZoHWlqr1EM/64Fnx4ZGMiMnB3Z8OKaw==
X-Gm-Gg: Acq92OHdNLb0QDtrnH7kJJ54K7Q37hTn330xv+4UoktycKAl5gBmuapVbeegYfV/stU
 E7f69NauLIE7fgqf0Gc2xPYyszv1ajiipkueWQR6U+vCODaSzWbyyVsUHFlJRy9SWqp6jq0qX89
 Ra6ruES+zsAmV4ofM1VwFnW58G2AtZKzHvbkkfPwN8BNMlBAIYWyb293WVxKkMBNPDN4s8s/Klb
 hWn6ZiA6WmRGKav+rqdkDrhZwYBqd9uY9vvpOj0nQAzjyxuCJi4n93XtoePth3NlqmXrcWFWqq5
 mdnIUYd9gvCHimuu02W8c1REvZz1Ml3MS+riKSsAoMJItA8=
X-Received: by 2002:a17:902:f791:b0:2c0:cd80:47d4 with SMTP id
 d9443c01a7336-2c0cd805528mr27792125ad.23.1780251684920; Sun, 31 May 2026
 11:21:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260530211248.375318-1-richard.henderson@linaro.org>
 <20260530211248.375318-11-richard.henderson@linaro.org>
 <CANCZdfqE=MWrQZeYtSLPs=B3FUW4xRL_ebLyXj4txQ92PzZDUw@mail.gmail.com>
 <49b8837e-52e0-4805-9b27-b3fcd2918061@linaro.org>
In-Reply-To: <49b8837e-52e0-4805-9b27-b3fcd2918061@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Sun, 31 May 2026 12:21:10 -0600
X-Gm-Features: AVHnY4KqBAGqfWd0hgqxoYgNwxu72vp67dmKLoZwDIwfamuSYgA23Yu3-7EsU6Q
Message-ID: <CANCZdfoGJKyBMQ-N8Vec3T5SsowqhFZRVaiTpBM2djUmsvOtwA@mail.gmail.com>
Subject: Re: [PATCH 10/13] common-user: Implement read_self_maps for FreeBSD
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, deller@gmx.de
Content-Type: multipart/alternative; boundary="0000000000004a6c40065321250b"
Received-SPF: none client-ip=2607:f8b0:4864:20::62c;
 envelope-from=wlosh@bsdimp.com; helo=mail-pl1-x62c.google.com
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

--0000000000004a6c40065321250b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 31, 2026 at 11:44=E2=80=AFAM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 5/30/26 21:36, Warner Losh wrote:
> >     +    for (int i =3D 0; i < n; ++i) {
> >     +        struct kinfo_vmentry *k =3D &entries[i];
> >     +        size_t path_len =3D strnlen(k->kve_path, sizeof(k->kve_pat=
h))
> + 1;
> >
> >
> > This is shorter than what I had in blitz.
>
> Shorter, but wrong, since it's never 0.
>

True.


> >
> >     +        MapInfo *e =3D g_malloc0(sizeof(*e) + path_len);
> >
> >
> > My version did the following only if
> >        if (kve->kve_type !=3D KVME_TYPE_GUARD &&
> >              kve->kve_type !=3D KVME_TYPE_DEAD) {
> >
> > though now I see my version would have been better with the
> > contrapositive and continue.
>
> You wouldn't want to skip GUARD, since for the purpose of probe_guest_bas=
e
> GUARD is
> reserved memory.  What does DEAD mean?  Is that the multithreaded thing?
>

I don't know what I was thinking for either of those, now that I refresh my
memory
on what they are. GUARD works coincidentally because the regions are small
and
none would be selected...  DEAD can likely never happen in userland, since
it's only
for objects that are dying and in the process of being deallocated, but not
yet
unreferenced... I'm not sure how this could arise when this function is
being called,
though, so I guess my difference isn't any better at all.


> >     +    free(entries);
> >
> >
> > I had g_free() here, but I am a 'cargo cult' glib user...
>
> I know they're the same these days, but I minded the man page which says
> 'free'.
>

Oh! The sysctl method vs the kinfo_getvmmap method. Yes, this is right. I'd
malloced
memory for mine with g_malloc...


> >     +
> >     +if host_os =3D=3D 'freebsd'
> >     +  libutil =3D cc.find_library('util', required: true)
> >     +  user_ss.add(libutil)
> >     +endif
> >
> >
> > This dependency is likely fine, but as I said in my other mail using th=
e
> sysctl obviates
> > the need for this.
>
> I'm fine either way.  Perhaps this isn't worth pulling in the external
> dependency.
>

Same.


> > And thank you so much for writing this, even though there's a small
> collision here. I do
> > very much appreciate it.
>
> You're welcome.
>
>
> r~
>

--0000000000004a6c40065321250b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Sun, May 31,=
 2026 at 11:44=E2=80=AFAM Richard Henderson &lt;<a href=3D"mailto:richard.h=
enderson@linaro.org">richard.henderson@linaro.org</a>&gt; wrote:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">On 5/30/26 21:36, Warner L=
osh wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 for (int i =3D 0; i &lt; n; ++i) {<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct kinfo_vmentry *=
k =3D &amp;entries[i];<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 size_t path_len =3D st=
rnlen(k-&gt;kve_path, sizeof(k-&gt;kve_path)) + 1;<br>
&gt; <br>
&gt; <br>
&gt; This is shorter than what I had in blitz.<br>
<br>
Shorter, but wrong, since it&#39;s never 0.<br></blockquote><div><br></div>=
<div>True.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 MapInfo *e =3D g_mallo=
c0(sizeof(*e) + path_len);<br>
&gt; <br>
&gt; <br>
&gt; My version did the following only if<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (kve-&gt;kve_type !=3D KVME_TYPE_GUARD &=
amp;&amp;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 kve-&gt;kve_type !=3D =
KVME_TYPE_DEAD) {<br>
&gt; <br>
&gt; though now I see my version would have been better with the<br>
&gt; contrapositive and continue.<br>
<br>
You wouldn&#39;t want to skip GUARD, since for the purpose of probe_guest_b=
ase GUARD is <br>
reserved memory.=C2=A0 What does DEAD mean?=C2=A0 Is that the multithreaded=
 thing?<br></blockquote><div><br></div><div>I don&#39;t know what I was thi=
nking for either of those, now that I refresh my memory</div><div>on what t=
hey are. GUARD works coincidentally because the regions are small and</div>=
<div>none would be selected...=C2=A0 DEAD can likely never happen in userla=
nd, since it&#39;s only</div><div>for objects that are dying and in the pro=
cess of being deallocated, but not yet</div><div>unreferenced... I&#39;m no=
t sure how this could arise when this function is being called,</div><div>t=
hough, so I guess my difference isn&#39;t any better at all.</div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 free(entries);<br>
&gt; <br>
&gt; <br>
&gt; I had g_free() here, but I am a &#39;cargo cult&#39; glib user...<br>
<br>
I know they&#39;re the same these days, but I minded the man page which say=
s &#39;free&#39;.<br></blockquote><div><br></div><div>Oh! The sysctl method=
 vs the kinfo_getvmmap method. Yes, this is right. I&#39;d malloced</div><d=
iv>memory for mine with g_malloc...</div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+if host_os =3D=3D &#39;freebsd&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 libutil =3D cc.find_library(&#39;util&#39;,=
 required: true)<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 user_ss.add(libutil)<br>
&gt;=C2=A0 =C2=A0 =C2=A0+endif<br>
&gt; <br>
&gt; <br>
&gt; This dependency is likely fine, but as I said in my other mail using t=
he sysctl obviates <br>
&gt; the need for this.<br>
<br>
I&#39;m fine either way.=C2=A0 Perhaps this isn&#39;t worth pulling in the =
external dependency.<br></blockquote><div><br></div><div>Same.=C2=A0</div><=
div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; And thank you so much for writing this, even though there&#39;s a smal=
l collision here. I do <br>
&gt; very much appreciate it.<br>
<br>
You&#39;re welcome.<br>
<br>
<br>
r~<br>
</blockquote></div></div>

--0000000000004a6c40065321250b--

