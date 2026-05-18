Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72F30CD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 11:46:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOwPN-0003be-Nl; Mon, 18 May 2026 07:45:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avi@scylladb.com>) id 1wOwP8-0003a2-4C
 for qemu-devel@nongnu.org; Mon, 18 May 2026 07:45:09 -0400
Received: from mail-vk1-xa35.google.com ([2607:f8b0:4864:20::a35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <avi@scylladb.com>) id 1wOwOr-000292-R9
 for qemu-devel@nongnu.org; Mon, 18 May 2026 07:44:47 -0400
Received: by mail-vk1-xa35.google.com with SMTP id
 71dfb90a1353d-575212eb419so1555561e0c.1
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 04:44:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779104683; cv=none;
 d=google.com; s=arc-20240605;
 b=jVRetfNC+oaVsHMtu/Shb5CsNtmo30fPPzDtFvhuIjzUWmHyFX56lTi+xP1qUHe248
 LhYsw9pdro5u44JhM2X8jgaarvAFrD5Z0CeEo77c2tU3qfCjmXUPQbXIaEcnvXsoghRk
 4Ko0mMvpDK7CNmpQH82N9fREakKtzqZMnBNQgKTAYVLJe7K7jwRbd7dhnrCAC2GLrASs
 +jXJSc6Oqs6AlQw/r9SlVGnPnloPb7J4Lw4ql/ORlh/GgufeUCiRg/UkC9cQ2Jg5lA6S
 ydakfehxbMRypK6FdCkBp0PTkZ0+Iu5uV7owYMKQHvG75wlaTWNh71NBxNaZILlIZgzI
 iegQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Dsu9VmyPA3MFI6qwx5Ke2ianplKMkJa4tw9F7/oXies=;
 fh=F2XsAGgEqHrLS/qtDmFV1PM0/P8vrcSnPQ7nUxdP7Mg=;
 b=ff6V/fiG0y5qIQCw0m6xi0V8+1kbhwIyjuLmu09gWnV0Z/myrZRyo+/dSVLNNWQPkk
 HPnL+hx+IJJ7bdiwTbGypxRH1oLElmfRz5k1JpB7puee4F5M6eFJp9bXvd0QVP1aiKc6
 NTBJAYv7ssq25qYkw0Ok5IS+l+LhlWZjiMg04fKpTT5BhmrKZhRp7C/PoJaIhtlvnc9V
 zrpj/LN8xU3VGoBQAWZ2DxYbjRzHFjtMNXbSL6ks2sDZ8YRVfzxxYlxiqyxgh3IyZCX7
 w2HRq95/fahZ8eseX493eVVn+Knz+K/8MD7UGko2nJFbHdUF5Fch7zTzzXfgj1VOUWW3
 gY4w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=scylladb.com; s=google; t=1779104683; x=1779709483; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Dsu9VmyPA3MFI6qwx5Ke2ianplKMkJa4tw9F7/oXies=;
 b=pQ/IjqsLg9Opdk8ULp3N20rDn6CCU920M1ZkU4w3Am3CG6+fr6frpETE2MIYLIZRX1
 5ic8ayEtQSnp/XjSbwaXEMdzoh1OmSiB07tlfacvah9f3kSHMzbDqKsBBgn+6NizXu71
 6TXyfbkXOETlkI58AneqhK0pU0HYApfdPKZ+GhUMYGSFI5dqMgM4p/W5wsQAGF7lB02e
 LKs8x27JhG8ytA4NPRD4zAJKeh34D9iMvhB44Eu4wwhWOXYvM9QJhicf69pUGwyBg4Kq
 Ht9YqM3HqPh6mcSgi4MTzGkH19JFnj+C2nGo8I2nTwkfLw46MA6L3yrqYaN5PSi8GW1+
 Q2Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779104683; x=1779709483;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dsu9VmyPA3MFI6qwx5Ke2ianplKMkJa4tw9F7/oXies=;
 b=RsXsfnx7toDal2f8xnNG5RG9zTZ8/fPIT9Xe4AfJ/9uCJR0mqdJAFqIa/5zrk7v1eE
 n2ZW/CxM30nhRWhAvni7M5U5AOIzESz2lUf2jdu8wj6b1TZmDjy5yq3rcf2CVBVZavft
 QR+YBstPkALHC7sulnSelgSazekwxmvPlfYm0cPUfZNUHMYI9+tSHglYk1XVJu0tcAIK
 ZcBfBh2fbY3y9JrpRStL8q90Ap8iX34d36R7XViUFGHBpfIq8RK+AN+UNSZ1sX2AsBZ8
 jU2JM9ZqWg0H7LtW4P2ymBPgIwvP3zx6tyfQmNeMHe/mGZS/kjcY9r9f9YGu43VQ7l6E
 +6yQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Lwz4k9aIROEDqoHOtMC4U4FwOuj4rV5lZpHL8IjMYXlsbfcYdrRTM244ksBRPwlmG/zwajRSJ6uu/@nongnu.org
X-Gm-Message-State: AOJu0YwmhrDjr51cR8QpWr8lTx0imepOEdD7u45ra4fijZS4c8auLFrK
 k6gVFVvQ2uRnOaemJroYoCYQOBFwL949oNhDNnYLDghuV033rW02/XzkK649/h8+hKCxHqdUwkY
 7j8t/OOGnUul5PIqS3gqXUZBmhNWQCqMA2oQ7SyX0mXhoCVV1SZzA8Nm4yNWB9PDLGnJSb6c2Pn
 rJqVJz4YEiQQrXo3V+jfMqsHZ13M7g2ojqnhtf5o932c8Tt+IVFawimWDtmQdusd77XtHw8tBor
 /GaLsEgHRNJZGYO2VUno3WfKoAzw4dENHLzzr2UVWv+GKCWWgYzQnQ4jkHydPSxt1ZXHHrdlHRc
 sMK9NWMDOxin4EOuaI1kkojE0b5WLz+VMu15oPZke1hG0jwKzW6LD4bh4NU1D9i5NWrxw5aH
X-Gm-Gg: Acq92OEyIH9fJjrfx78B0G+c1SbowdEyQr7iE3ZZ7kWsmJAM7/AJjl2d5tM//jLG5kg
 PPfU2anVmCooIZMpkOhw5OHf+xdPUA5YvphqBRMrc5o1nSlQl69DnWLNE1+qhKh0MdjfFO75fAb
 SCuC6edG8I0LB1FAgcDOlp7JifihgWCC2A26jheKTLea1/xbfj87xINhEt07gyCqSq9fDqT2xM2
 gU48lY3dST/tTrwfZsyd0XYmc9o8GDKevKzaccD789xxNToI5KCeDvOtOJDZ3hoo1kGzsyRCJNO
 CERc8Og=
X-Received: by 2002:a05:6122:6b8a:10b0:56e:e652:2c10 with SMTP id
 71dfb90a1353d-575f574b7e6mr4783861e0c.4.1779104683482; Mon, 18 May 2026
 04:44:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260306165717.3360110-1-berrange@redhat.com>
 <ad0pQDzYIki56wUe@AALNPWKJENSEN.aal.scsc.local>
In-Reply-To: <ad0pQDzYIki56wUe@AALNPWKJENSEN.aal.scsc.local>
From: Avi Kivity <avi@scylladb.com>
Date: Mon, 18 May 2026 14:44:32 +0300
X-Gm-Features: AVHnY4Iwp4Xbj5eY70Z_v637NQ21s0vVezHouk84pJwtosKilIxDsg0TajzIQHc
Message-ID: <CAF950WJM4=n=L-cSEgTFWTkOFDJCD9+aWSVwxm3oaN5+rvR7+g@mail.gmail.com>
Subject: Re: [PATCH 0/4] hw/nvme: make model & firmware version cnofigurable
To: Klaus Jensen <its@irrelevant.dk>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Keith Busch <kbusch@kernel.org>, Kevin Wolf <kwolf@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>,
 Hanna Reitz <hreitz@redhat.com>, 
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000ad75000652161684"
X-CLOUD-SEC-AV-Sent: true
X-CLOUD-SEC-AV-Info: scylladb,google_mail,monitor
X-Gm-Spam: 0
X-Gm-Phishy: 0
X-CLOUD-SEC-AV-Sent: true
X-CLOUD-SEC-AV-Info: scylla,google_mail,monitor
X-Gm-Spam: 0
X-Gm-Phishy: 0
Received-SPF: pass client-ip=2607:f8b0:4864:20::a35;
 envelope-from=avi@scylladb.com; helo=mail-vk1-xa35.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
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

--000000000000ad75000652161684
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 13, 2026 at 8:34=E2=80=AFPM Klaus Jensen <its@irrelevant.dk> wr=
ote:

> On Mar  6 16:57, Daniel P. Berrang=C3=A9 wrote:
> > These are both currently set to QEMU specific hardcoded defaults,
> > and in common with other block devices, should allow user overrides.
> >
> > The pre-existing serial field should also be length checked to
> > detect & report invalid user input instead of silently truncating.
> >
> > Daniel P. Berrang=C3=A9 (4):
> >   include/block: define constants for NVME string fields
> >   hw/nvme: report error for oversized 'serial' parameter
> >   hw/nvme: add user controlled 'model' property
> >   hw/nvme: add user controlled 'firmware-version' property
> >
> >  docs/system/devices/nvme.rst | 10 ++++++++++
> >  hw/nvme/ctrl.c               | 31 ++++++++++++++++++++++++++++---
> >  hw/nvme/nvme.h               |  2 ++
> >  include/block/nvme.h         | 10 +++++++---
> >  4 files changed, 47 insertions(+), 6 deletions(-)
> >
> > --
> > 2.53.0
> >
> >
>
> Given the reference to prior art on introducing error checking in these
> cases, this LGTM.
>
> Applied to nvme.for-11.1. Thanks!
>

I don't see it in master. What's the schedule for upstreaming it?

--000000000000ad75000652161684
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Mon, Apr 13, 2026 at 8:34=E2=80=AFPM K=
laus Jensen &lt;<a href=3D"mailto:its@irrelevant.dk">its@irrelevant.dk</a>&=
gt; wrote:</div><div class=3D"gmail_quote gmail_quote_container"><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">On Mar=C2=A0 6 16:57, Daniel P. Ber=
rang=C3=A9 wrote:<br>
&gt; These are both currently set to QEMU specific hardcoded defaults,<br>
&gt; and in common with other block devices, should allow user overrides.<b=
r>
&gt; <br>
&gt; The pre-existing serial field should also be length checked to<br>
&gt; detect &amp; report invalid user input instead of silently truncating.=
<br>
&gt; <br>
&gt; Daniel P. Berrang=C3=A9 (4):<br>
&gt;=C2=A0 =C2=A0include/block: define constants for NVME string fields<br>
&gt;=C2=A0 =C2=A0hw/nvme: report error for oversized &#39;serial&#39; param=
eter<br>
&gt;=C2=A0 =C2=A0hw/nvme: add user controlled &#39;model&#39; property<br>
&gt;=C2=A0 =C2=A0hw/nvme: add user controlled &#39;firmware-version&#39; pr=
operty<br>
&gt; <br>
&gt;=C2=A0 docs/system/devices/nvme.rst | 10 ++++++++++<br>
&gt;=C2=A0 hw/nvme/ctrl.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0| 31 ++++++++++++++++++++++++++++---<br>
&gt;=C2=A0 hw/nvme/nvme.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 2 ++<br>
&gt;=C2=A0 include/block/nvme.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 10 +++++=
++---<br>
&gt;=C2=A0 4 files changed, 47 insertions(+), 6 deletions(-)<br>
&gt; <br>
&gt; -- <br>
&gt; 2.53.0<br>
&gt; <br>
&gt; <br>
<br>
Given the reference to prior art on introducing error checking in these<br>
cases, this LGTM.<br>
<br>
Applied to nvme.for-11.1. Thanks!<br></blockquote><div><br></div><div>I don=
&#39;t see it in master. What&#39;s the schedule for upstreaming it?=C2=A0<=
/div></div></div>

--000000000000ad75000652161684--

