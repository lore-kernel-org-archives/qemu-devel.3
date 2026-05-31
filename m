Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C543CD6E52
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2026 18:22:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTkoA-0002d1-BV; Sun, 31 May 2026 14:22:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wTknw-0002Sf-Li
 for qemu-devel@nongnu.org; Sun, 31 May 2026 14:22:38 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wTkns-0003lE-Lc
 for qemu-devel@nongnu.org; Sun, 31 May 2026 14:22:31 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-c859878eb48so252218a12.0
 for <qemu-devel@nongnu.org>; Sun, 31 May 2026 11:22:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780251746; cv=none;
 d=google.com; s=arc-20240605;
 b=WVo26MKrn6jl01wg/PI2Bh/RatL7bbl+c28rZ65odOa8VUMYpiFsxIUz4EEW0QgzSb
 PpK6PWWsSiUyMwYd9UTPisZxN83nOYnotjDnda49lsK+w85PnSjWfGCpcX3FvKGzFUKW
 pmUFG/k3xiYOZCQfnr3Ga+NaXmBvuFrMrdwnma73WHVMMPG+f8DYQ/Uz3/92oCFvyY/Y
 1Scj53nzNNTyv0E8+yaOQNGxcRIzyiFrOQMsm64pwfs7jCojMhcUNUl1Ae6Uao2g1Lha
 mkQMlYHTaZlY6UAxk9E9ULZu2FLdGzYm2b45COEJZKfBpa5JrBftVLAkIXZwcQ+i4W6+
 plRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=T2jlzkw52YuSDE5Uz90QJ+PmFoyjk/F7jdTMC7FKKHM=;
 fh=+DxRVnEC95Ptxk5HMfIFqaUwIao1HhLaAPFCgZPm1R4=;
 b=DCc5RQbct4Wcu8aHn9haYu7MwZvQZMMpij4Nk+TqbMYFovh0fey+uM7c4FXUHese87
 nAq0ugI04dcUCrH1JeT7CK6ehzsd3eHrMvv2mtGAkiwjEyBOrDGo2zGHR+l+nxvsmDFW
 YZJTrBY1BGrOgv9JtpuiWRBGavG2UObZ2LDIWGlwWz0FRrNuAwoz/U4KyWIJpqdNg+oC
 tZr+mii29Ko3xUyI5CcB95iDSUExZ1tNOfNsw31PU+poOOW4OQALay8wqZUB8rqREsZU
 f+a1kQiOggvZfV2vx8gejF6ssSHBxcPg15Ux2wJE87TIpCP0U8K4hh78qI+qoNvXDAHR
 nN3g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1780251746; x=1780856546;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=T2jlzkw52YuSDE5Uz90QJ+PmFoyjk/F7jdTMC7FKKHM=;
 b=uPXLsgeSfvr+w91aB/HGJkMRWRt0es09kdEtm1pCk3lPSy5J15KO3q40iAMTIAQ7Mf
 chp53qROQtbhhNuJ6mYm3DY04ClXzRDZtk5/FFEGsxEc9MNo8Aconk0JnxrZKNtvsfzy
 9YGnZyVD18rGjfLdxRavQp0OoXQsrkTb5hPHdrSGV8TbH81hK7dxWhRpLhM+xgH1/JrI
 5dJR31Yg9qHGPE/Zc+abEz5wjg8q4pSFui0FkqhIGcdZqNiPsDGqRqPTOzEbWLQSydv7
 wlRTwo/lAVKVxhgNH8QfzEgU897eA161ktbayOB/MbsyF55JvJ68TAVkG5yN12b0xa2T
 r85Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780251746; x=1780856546;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T2jlzkw52YuSDE5Uz90QJ+PmFoyjk/F7jdTMC7FKKHM=;
 b=I9VhVoYAS7QElgpl9D5Hd9V/ca8F5b5H8u24mkYoOH/GiEjzOsRJ03r6lgojmB1/DN
 jPzLVSkyQkrUGFq0Si4oFOG/JMaP/b0GdtV+kc6hkRx7DoWRTF/BcvlEXvLStwrWuOBt
 2+zF1Ek/zGiDze3xF0f5oAoR7y+gZocv1jxYnCVSfDhaX67H//JtrVPM67NIZbG6V1eW
 9klkwxBM1VKmEqnCQEHrveA6X1+X67k2dR3NJrP2gs4GyZEJxpYnEHbXwcGZYiVtTUx0
 pDw74k880kp2CRuwrbvCln8YjnmP67dITqv1aqFlpjAAVrxIisEdJOP34esTsODmymDC
 ZMlw==
X-Gm-Message-State: AOJu0YzlSUS/gS9JmwhiqgTAL5UYWkk8Au6KzRpc5XhkWogthZ4D8RHP
 xtxqjkasv7oMJkurxI4ozMO7tCJkFX5gbErxawDkyHkrkdlWmz9auDhNAMJfbIvBHOsq0UmpDnG
 0m3qoZa6cmO1aDxIMDuAcpBSo6gK5ONN4pWTsYjkkTg==
X-Gm-Gg: Acq92OGEK42VA79KcCmbBbby0syhikJsiuotzN52HaqKFv8so06uvy8rtNWan058qxP
 YDbiu4Mf21vY8tNCTa1Cto91assCmGSEvwDMM9QLY2JlATl0aiyCgiyrZbJC8BK6pov6h5Fuon/
 81ag8pDgGiS8zJPgj2ic+m5VHmjIDrwwY0afMNuyn2HkLwIKyT7ikmewR37RgPnpZCwkaHKOZ5o
 by2u9M+DQwx0LflyUKJwFIT7yi2iJQNP19OLp0+Xr9+cfywe2ur3nZMmETCBuHv4VYKkmLnA4zs
 Ylt2q0RnXBQrKbsSjD7Q3tlSzX7vscnquWHt2e2J9S1ZuRipDWTVDh952w==
X-Received: by 2002:a05:6a21:3a47:b0:39f:1f92:28e with SMTP id
 adf61e73a8af0-3b42823a98bmr9506835637.27.1780251746330; Sun, 31 May 2026
 11:22:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260530211248.375318-1-richard.henderson@linaro.org>
 <20260530211248.375318-12-richard.henderson@linaro.org>
 <CANCZdfpLTPL4UKFMHrevMPJ-3NguLPpRXkNYrJnQjyMyvwVoQg@mail.gmail.com>
 <22f680f0-5323-4aa0-b692-f76889a04039@linaro.org>
In-Reply-To: <22f680f0-5323-4aa0-b692-f76889a04039@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Sun, 31 May 2026 12:22:14 -0600
X-Gm-Features: AVHnY4Ls-RxywyM2Tbw6ogAlmwFIq5jmVfHSYx_yTPvjrGsK3j4mNbsAJrQNTrc
Message-ID: <CANCZdfp4mTvmZijxezSr9Tk7wMqm_MVc_C1eNO0LAra9m454XA@mail.gmail.com>
Subject: Re: [PATCH 11/13] common-user: Move probe_guest_base from linux-user
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, deller@gmx.de
Content-Type: multipart/alternative; boundary="000000000000f3772d06532128ee"
Received-SPF: none client-ip=2607:f8b0:4864:20::535;
 envelope-from=wlosh@bsdimp.com; helo=mail-pg1-x535.google.com
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

--000000000000f3772d06532128ee
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 31, 2026 at 11:33=E2=80=AFAM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 5/30/26 21:44, Warner Losh wrote:
> >     +    void *p =3D mmap((void *)addr, size, PROT_NONE,
> >     +                   MAP_ANONYMOUS | MAP_PRIVATE |
> >     +                   MAP_NORESERVE | MAP_FIXED_NOREPLACE, -1, 0);
> >
> >
> > +    void *p =3D mmap((void *)addr, size, PROT_NONE,
> > +                   MAP_ANON | MAP_PRIVATE | MAP_FIXED | MAP_EXCL, -1,
> 0);
> >
> > is what I had in my port. ANON and ANONYMOUS are the same. FreeBSD
> doesn't define
> > MAP_NORESERVE that I can see, though you could define it above to be 0.
> FreeBSD used
> > to define this, but it has no meaning in the current kernels.
>
> We default MAP_NORESERVE to 0 in qemu/osdep.h.
>

Oh! So we do. I'd looked in a different file that I'd just cleaned up for
it...

Maybe MAP_FIXED_NOREPLACE could be defined in qemu/osdep.h as well?

Warner

--000000000000f3772d06532128ee
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Sun, May 31,=
 2026 at 11:33=E2=80=AFAM Richard Henderson &lt;<a href=3D"mailto:richard.h=
enderson@linaro.org">richard.henderson@linaro.org</a>&gt; wrote:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">On 5/30/26 21:44, Warner L=
osh wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 void *p =3D mmap((void *)addr, size,=
 PROT_NONE,<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0MAP_ANONYMOUS | MAP_PRIVATE |<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0MAP_NORESERVE | MAP_FIXED_NOREPLACE, -1, 0);<br>
&gt; <br>
&gt; <br>
&gt; + =C2=A0 =C2=A0void *p =3D mmap((void *)addr, size, PROT_NONE,<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 MAP_A=
NON | MAP_PRIVATE | MAP_FIXED | MAP_EXCL, -1, 0);<br>
&gt; <br>
&gt; is what I had in my port. ANON and ANONYMOUS are the same. FreeBSD doe=
sn&#39;t define<br>
&gt; MAP_NORESERVE that I can see, though you could define it above to be 0=
. FreeBSD used<br>
&gt; to define this, but it has no meaning in the current kernels.<br>
<br>
We default MAP_NORESERVE to 0 in qemu/osdep.h.<br></blockquote><div><br></d=
iv><div>Oh! So we do. I&#39;d looked in a different file that I&#39;d just =
cleaned up for it...</div><div><br></div><div>Maybe MAP_FIXED_NOREPLACE cou=
ld be defined in qemu/osdep.h as well?</div><div><br></div><div>Warner=C2=
=A0</div></div></div>

--000000000000f3772d06532128ee--

