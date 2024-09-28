Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2408FCF6493
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Sep 2024 13:34:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1suXaE-0005lu-CW; Sat, 28 Sep 2024 09:34:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1suXaC-0005lO-Pt
 for qemu-devel@nongnu.org; Sat, 28 Sep 2024 09:34:01 -0400
Received: from mail-vs1-xe2c.google.com ([2607:f8b0:4864:20::e2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1suXaB-0003KF-2v
 for qemu-devel@nongnu.org; Sat, 28 Sep 2024 09:34:00 -0400
Received: by mail-vs1-xe2c.google.com with SMTP id
 ada2fe7eead31-49bc12c0041so1042830137.0
 for <qemu-devel@nongnu.org>; Sat, 28 Sep 2024 06:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1727530437; x=1728135237;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vm3htQug5IegHhPT7cgIzFuuhqyJyuEF+dcjUhM6fq0=;
 b=LOJqj7rtUHRPq6Yvr2RRag9jTvEs/1LVc699OimAvXFmrjGOgtBMMw9owpLSew7vu6
 uG3aeB0GaefqsoA2WrZCGAuIK4kn45q5DuP425E2HiQrPInhH020cjca+BUmulNzy21m
 LkjVxIseZjqJsERsgJ+hCmVaJK0AYyLJgdbg3lo7cgyDCToy9Ie42msSia1VLZg62qw5
 AQ56NbzfRdS9Sk4P+HIvSfIOytTZjvGFxEYLFBNtb99Hf4WdPKaGYvsKSr0hhaHMoQZK
 7KgV+VOz+NtebuMu9MSfDVL7NDuFPXsR17ft0BNDvJVP9I3s9FJgPpDS+jlC909iMpS7
 SRFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727530437; x=1728135237;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vm3htQug5IegHhPT7cgIzFuuhqyJyuEF+dcjUhM6fq0=;
 b=OUMLMoD+yonhFs80oHNOV0MZrBMKuO4Q4P3Ls+zucPga51UNi/B92A2iuZSgRApTgJ
 S9prQP1mlLL4CIno91HtJkwI+Ws0/NeLVyixeMJ2QyXoz1DJJOtA+uo9SarsVSX5WF0Z
 YiSHP1gsIWMiB9Xp8miK+SgQ3XsH8zaaKAThnd+rtH0OFq3yCVZbC0DitNWMiYFZkWMe
 M7oyPVh3JDykr9fZrGlmGjdkpG4JOlz1hsDxnL6xxNWa4rxza2ZHmNywae6BPW3ZLbfV
 a5T6salgAxpYKM9c4aJgd1/mBV44I/pOWTm5QQDgYOeu2EVvfAdz4B2g3gb5J1UjhVo3
 3OtA==
X-Gm-Message-State: AOJu0Yzm07aZdn2YLRQVN5Jts/cuyv8jnQ3xaPiefQrcryad9WaGeIMC
 rI95UkZUiXq+/2E6fF8h3bTf+InnRG07Gd6xlN9IUCCQWLj6KjtdymDadUOtlE6GypjFPoAZkNj
 YvwdGOOfb9DHBUT8QBmtZS/foQ5goa/jpRIv5Amh07Ik9L8DxKA==
X-Google-Smtp-Source: AGHT+IE91n9KdpjE94C24E1+vbgSdz/DJUsqVGIYk9t1eMY5kEeqJQyAykdm7BxFpVU0KRcle3WlgQUWjQ1yWW3m2XI=
X-Received: by 2002:a05:6102:370b:b0:495:6a25:d1ed with SMTP id
 ada2fe7eead31-4a2e1154ad4mr5128492137.25.1727530437233; Sat, 28 Sep 2024
 06:33:57 -0700 (PDT)
MIME-Version: 1.0
References: <20240928085727.56883-1-phil@philjordan.eu>
 <20240928085727.56883-3-phil@philjordan.eu>
 <67acdfdc-348d-fcd2-7891-06a38349beb1@eik.bme.hu>
In-Reply-To: <67acdfdc-348d-fcd2-7891-06a38349beb1@eik.bme.hu>
From: Phil Dennis-Jordan <phil@philjordan.eu>
Date: Sat, 28 Sep 2024 15:33:46 +0200
Message-ID: <CAAibmn2reoq9K0cWorWp2jJ+dUwjdjOT3oa=2RRP15dtOb02Ww@mail.gmail.com>
Subject: Re: [PATCH v3 02/14] hw/display/apple-gfx: Adds PCI implementation
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000000cee1106232e0656"
Received-SPF: neutral client-ip=2607:f8b0:4864:20::e2c;
 envelope-from=phil@philjordan.eu; helo=mail-vs1-xe2c.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

--0000000000000cee1106232e0656
Content-Type: text/plain; charset="UTF-8"

On Sat, 28 Sept 2024 at 12:39, BALATON Zoltan <balaton@eik.bme.hu> wrote:

> > +typedef struct AppleGFXPCIState {
> > +    PCIDevice parent_obj;
> > +
> > +    AppleGFXState common;
> > +} AppleGFXPCIState;
>
> You don't need typedef here because OBJECT_DECLARE_SIMPLE_TYPE will add
> that. You can also put the struct AppleGFXPCIState definition after the
> OBJECT_DECLARE_SIMPLE_TYPE line. (See other devices for example.)
>
>
Thanks for pointing that out. I've locally applied that advice to this and
the other relevant type declarations in the series, it'll be in v4.

Phil

--0000000000000cee1106232e0656
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Sat, 28 Sept 2024 at 12:39, BALATO=
N Zoltan &lt;<a href=3D"mailto:balaton@eik.bme.hu">balaton@eik.bme.hu</a>&g=
t; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">&gt; +=
typedef struct AppleGFXPCIState {<br>
&gt; +=C2=A0 =C2=A0 PCIDevice parent_obj;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 AppleGFXState common;<br>
&gt; +} AppleGFXPCIState;<br>
<br>
You don&#39;t need typedef here because OBJECT_DECLARE_SIMPLE_TYPE will add=
 <br>
that. You can also put the struct AppleGFXPCIState definition after the <br=
>
OBJECT_DECLARE_SIMPLE_TYPE line. (See other devices for example.)<br>
<br></blockquote><div><br></div><div>Thanks for pointing that out. I&#39;ve=
 locally applied that advice to this and the other relevant type declaratio=
ns in the series, it&#39;ll be in v4.</div><div><br></div><div>Phil</div><d=
iv><br></div></div></div>

--0000000000000cee1106232e0656--

