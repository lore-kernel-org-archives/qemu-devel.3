Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20453EB5943
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 23:47:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpxR7-0008NO-5s; Tue, 10 Feb 2026 18:46:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1vpxR6-0008M2-7Z
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 18:46:28 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1vpxR3-00005A-W4
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 18:46:27 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2aaed195901so13312985ad.0
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 15:46:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770767182; cv=none;
 d=google.com; s=arc-20240605;
 b=QcXh/4gMct4zz8vOhDOAI4WNfFuBWRx8+kU0L0NTwFb5qvHHWiDoPsvBiNvyD0yC6R
 tRosKtiU4Se692k7ah2RVea+nI8ynjdRSa29MJKw+sbJUtxLOLXd4HFwAOhIQT+GPQv3
 49cRCVS7qcjpNZE/PyO0MxLzVcJMg2EIvZnZKHR1ftE626N8tGkm5pG5dq+j/Xd47GqP
 D2hr3VjCW4KpTE0fooqaBD000NsJ56TwI5ljI9FFhXiuBgsXp5iF9unC2kwlCz2zYk/i
 iOntZ7jaeLDtDSaQcoiClUfyE5OGXNgnNayobTKsppINOpy3T9mqKoKedxnwynUO/0a/
 2jpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=el56fPFom+iX099FqWO//oE4U4zVJxBdl2ifwbDhaek=;
 fh=KfNA4twi5yKjZolFArD6GKxNbv+5932nte5njHWJM0I=;
 b=HMSq22SzV+nW/FC3+3leBQbV/WhjFz/Q1g57/frg4DB72rxNWMIWjVsPxC31w3ozeR
 oxDwPU08/TbZuxVqTYJoCATfOGYX0Y0vgarbQ+S4HEE/CF3h/ipJw1OS8WWjVB2YnV/D
 B3LnxFUbyc2NemkCwY0ndx5qP9qNyzUCPBISxjfTrBCUlXhIk4QPZLPLQzabLFHLlxpR
 ILAwtSvC2ASqTZxOTwy72H4V5fglBeLaDHAhMMGO2c+Cbm7GLUeAJHQfGBdrVx+aTgJu
 CFi66CL8nXOOOVVrPqOjp2FOtmotMWovaO+gK2WkCur+BumQ5bHV0OUoiuEgzgb5+r0v
 hJYA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1770767182; x=1771371982;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=el56fPFom+iX099FqWO//oE4U4zVJxBdl2ifwbDhaek=;
 b=bRCP/KY+pq8hwKKyQyceiW1oN53JWJqTdCax5X6Dt5S5ckkgTowiMn503ddG16+rfN
 1ZYRh3pduLoc3Ps4jIglFqCN2Uj40L4aRqmx2W2TYomaXhS7RLmgbB1JvnaYCvTeb74y
 QkWMrQdCRBOoYhd5zSRInc65668aMbDKe35xrS7xhb2+8VJLmc1rNiKdcGftKnbYp+c4
 0pqVZIjPi8CGzDfWsYhb4/JVuuLPM3OS9Fnk7ZKNaClwiYnjA+NMMBQDlxuL5fu95nci
 EfMcRqW6sDEkuDhM6N9x1TJg0Z6xWeWsMa66uwhC0gWMPr3auuEK0DSes3t5kTyKCIdz
 0mJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770767182; x=1771371982;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=el56fPFom+iX099FqWO//oE4U4zVJxBdl2ifwbDhaek=;
 b=PA0fJGfM5zzrQHYb86br3yypg6NeeEf6wy6loICkjvK2Zu+Hig4tmdHDDsYeISsAlN
 DaYuw3Hkhlq3nEp6HyzSoG5SRLVspecghGawn2Eq9ucziHNiNNpaNhmvAd+fud4Azjra
 yjtX/EsJdY7r7nQYlxIJxFUoPW4422pa/I/WeJj3Owun8TVxeRq3k+8Rp3/v25HooCdr
 mksK0HKwQMl2+hn5hU3Jkp8W+SSyW01Fk+sjt52no1KNyiin2z10mEsJLrsjzLjF9wrc
 hyKk8prG42oxTyrl3s/0c9Q5k7tuLKM9oLVzNyAM8c7BDLxukjlAlzZUptWe52GX/Xkb
 wwlw==
X-Gm-Message-State: AOJu0Yy+0QADGvOXwa9WKenNwIUUY4es4tjyAAUxCehutlKBkdXgfbAL
 mH9p/GZ5IbfJtcnJBMF38BFxxabN5mOem9g4Efud/TLN/CGJ1Zq6/Fed1bjEx5zKkNcs4Bcdunf
 G6BYmByzxBtjDmteTTgW94NijxSedi6+73L+gvovK0hUhh/yFvRcWCD4=
X-Gm-Gg: AZuq6aLOiipRjbVF2njhpw/2CJHWGl2/Ra3HWJuw0eZR3GBIXCPhegtJc93W5KutrGH
 qvgmOURtRlZ0OieuelBGQ5eGPVDSHZlh1jn4dohDqBCMSgozf9fIgdvIOy7lFZhUh1RGrT3Cn7R
 595uFTASvdia61WgNZa6gIxEBlDgOpr1VeIOPoVLfLXEBLhUiyruT42GIcKRcci1EkpkXxekIX5
 pDzoUbZ674IlaPm9jtcpRPWvVIx+xKAxzysPkaPIVi6p+rQMoQCoa8iWUDMta8ZLWlhDf0MQHfS
 BhrMcCk=
X-Received: by 2002:a17:902:da91:b0:2a7:c8db:488a with SMTP id
 d9443c01a7336-2ab102f5998mr41704865ad.7.1770767181747; Tue, 10 Feb 2026
 15:46:21 -0800 (PST)
MIME-Version: 1.0
References: <20260210-bsd-user-rm-openbsd-netbsd-v1-0-8b8b0f50c29d@bsdimp.com>
 <20260210-bsd-user-rm-openbsd-netbsd-v1-3-8b8b0f50c29d@bsdimp.com>
 <def06a55-ab7f-4a2b-b43d-f9571c26a5a1@linaro.org>
 <CANCZdfpcVBpLMeZ3Wpbj_g+-_NpBd=mBKLfRQjp33X3GxtD-rQ@mail.gmail.com>
 <bded12af-5f9a-4ee9-a6e0-f87dffe87f21@linaro.org>
In-Reply-To: <bded12af-5f9a-4ee9-a6e0-f87dffe87f21@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 10 Feb 2026 16:46:10 -0700
X-Gm-Features: AZwV_QjrWb1ISZ9Ek0F97lAjNKQc8M1MQC2YvzEe1F1rmwqcbQglpfHnCMuntDk
Message-ID: <CANCZdfo4LaEY+oZqaE7G_HtHLqiT9O4nrKiPWDciR4Kw06Z-kw@mail.gmail.com>
Subject: Re: [PATCH 3/3] bsd-user: Remove NetBSD supprot
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kyle Evans <kevans@freebsd.org>, Brad Smith <brad@comstyle.com>, 
 Reinoud Zandijk <reinoud@netbsd.org>, Ryo ONODERA <ryoon@netbsd.org>
Content-Type: multipart/alternative; boundary="000000000000d91fda064a80dcec"
Received-SPF: none client-ip=2607:f8b0:4864:20::62b;
 envelope-from=wlosh@bsdimp.com; helo=mail-pl1-x62b.google.com
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

--000000000000d91fda064a80dcec
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 10, 2026 at 2:53=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philmd=
@linaro.org>
wrote:

> On 10/2/26 22:11, Warner Losh wrote:
> >
> >
> > On Tue, Feb 10, 2026 at 1:56=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
> > <philmd@linaro.org <mailto:philmd@linaro.org>> wrote:
> >
>
> >     Typo "support" in $Subject.
> >
> >
> > <blush> OK. Will fix.
>
> No need to repost IMO ;)
>

Unless something ELSE changes, I hadn't planned on it.

Warner

--000000000000d91fda064a80dcec
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Feb 10,=
 2026 at 2:53=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:=
philmd@linaro.org">philmd@linaro.org</a>&gt; wrote:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">On 10/2/26 22:11, Warner Losh wrote:<br=
>
&gt; <br>
&gt; <br>
&gt; On Tue, Feb 10, 2026 at 1:56=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <b=
r>
&gt; &lt;<a href=3D"mailto:philmd@linaro.org" target=3D"_blank">philmd@lina=
ro.org</a> &lt;mailto:<a href=3D"mailto:philmd@linaro.org" target=3D"_blank=
">philmd@linaro.org</a>&gt;&gt; wrote:<br>
&gt; <br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0Typo &quot;support&quot; in $Subject.<br>
&gt; <br>
&gt; <br>
&gt; &lt;blush&gt; OK. Will fix.<br>
<br>
No need to repost IMO ;)<br></blockquote><div><br></div><div>Unless somethi=
ng ELSE changes, I hadn&#39;t planned on it.</div><div><br></div><div>Warne=
r</div></div></div>

--000000000000d91fda064a80dcec--

