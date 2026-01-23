Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AF2CD74EDB
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 15:15:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjIrh-00065f-Oc; Fri, 23 Jan 2026 10:14:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1vjIqB-0004B5-KU
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 10:13:02 -0500
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1vjIq9-0003t0-2o
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 10:12:51 -0500
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-c05d66dbab2so1651361a12.0
 for <qemu-devel@nongnu.org>; Fri, 23 Jan 2026 07:12:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769181167; cv=none;
 d=google.com; s=arc-20240605;
 b=ROJawBUEUB3JUkUxIgusYEmJWUWI3MHWqJl2Oc0p0crJiWkL+8w2R1GBrHo/ynGycx
 402MashmqruaIaehNsyQrArQr3hwmQqiUGYoX1P+mMrT37IeNdsl8PPI+VE1bdpgQcxw
 gHWx0XzRDoTAMteVyGJPNi9MotdPxOY8Eqmg9a82muxCwpmCWTDRItCdXURIvzVpcwgZ
 1SdG8cPIWFwjvHnkwtJgLkMLv/mQkU7s7t8CTMNgB2mO33RDdpZZ7o3eVXeYiLBEdUXB
 +PkwVAwXeOL0q0OD9zDu+rQHXQiltcvOX25T1f1iCOleJBjs+EwbNVn0azFTUVpv1sBD
 KCVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=2BN9GJ3u9ttyITJk7gDAzuCbKreGEx8ZxbU0p6ZmdDQ=;
 fh=U0PKPYUS6jsP4tvNmd2bvHW3s0S9j6WgkStXJ0+FYuM=;
 b=INbBUVjjX5jYIWeMXtyTJlL8f9h4GLEycUSp1IvlYPk93yIwDLx5iXdhPHppAMLUcM
 Z8uCHddE5CS9fDekSuJipysMb2hx0ocStvCeI+9DDulImKb1eQdx6gbwY8F2xcCCgqBK
 PgH2x4irL3x3nkULIxzkkd7/jLbk6JsNPMlrOJEOqSQQF1vRYwo4BaPLju2fm2wy2wt6
 jRjBZXpoXejXstGXEMZDGlXBBEsC3BsWBSzhO08RO4smONh1s8Ox4fkTUeFMc6yvx1RT
 BD+8W5FCtz2LNXTS7FYHwghWuP4RUC6DnjVTqmeH/ZSzUk+N/Ggxdunmcp0rq0M4WD23
 Qcbw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1769181167; x=1769785967;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2BN9GJ3u9ttyITJk7gDAzuCbKreGEx8ZxbU0p6ZmdDQ=;
 b=0j6RBCgaGu3U1S1RCsuynGoSmmhrUuLjSjDf/J7VVDJplNZ9huuVFypPfn5u8SrN2b
 3LHM21mkyCDktaMb39ZAPUgDgSiO68NCplLszhpYtzBwx4836rGMpnsCx8/iDlppjkqy
 DExK7983S2l42p33EghdfVFJCfOGCiWxJg/PYjF1Bd4Oz+8Uvqj5z3bRiI9eDVV/c9m/
 vQdP8cIzsA8yQcc3mASaU8vRCfHBIQ84AQFJwrzCB0pZihkF19paaTdxLn5W0ccM0L01
 zd5nlTgyWJDgJhvSHwIEN3sWVVOrHCTltFCAnpyIFHf4yleMSjj5ZywYjIVrk4sBumpW
 hfPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769181167; x=1769785967;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2BN9GJ3u9ttyITJk7gDAzuCbKreGEx8ZxbU0p6ZmdDQ=;
 b=SRbm8SX9izOV9CnW9gmsLuQuTs8d22tT8QY4vdq6q+oRhhEhQWIgQwn3rKgXdAN23c
 klE5UGhx/sfj8wZA95DY4c+7CxlksS+TH+cB3Yqecqowz8ULRfDGI2nij92OxXSognU4
 pw1QWnrG4L7CU19s/X++F/H58tckBn1/3zNAo4dPxeceQMty3fOvcrAPdGj2E30nB2wD
 jo/gMZVHqv+yzM6GSxVal2eVFdKMUaGCyHPaarhzWW+Lln11quVtrU7KcGJRteY1/GvE
 QJNg9acYAO8+oTG+zVjpKPYhNJnqVG5NYth7PexvqbHMwisNTDNdjyuEfocx+misJ7hW
 a5dg==
X-Gm-Message-State: AOJu0YwhMnLtFRveZQFV1VMdaTViZyB8LZdUUhg+rRwiav+mWxrBLkIx
 dMBFoLcQeDS//6Tkoy2qvOJdEaEy+1mIvThzs1O+cfY0Zg9RqgbyFyUYKzSbTCIbYUNw35F9Qx/
 L6hk3cqfAIC62WLoOCX2VdmDWXHGWfUSLyOffBojeQQ==
X-Gm-Gg: AZuq6aIbRZYxxtL0m019G2pFPRG10m8LmGlsu9+MlzPsG2DFRRYkDQz5EximAtxDiLc
 MWKk+ZNcAUeA9P4jMuB8T92z7e/VW2Zf+V2CFW+dKv0r4FzNmDsZWHzjksOvXJIB4slzIuYNWeN
 A+v5uTduWRL3zHK508jv7qZSGVIt0LMeqAZCXi05JVbYQPXiZ97jTYMd4p6g4XuuntyWqoPyfF2
 NXxr50UVdWbwSbdkwjDH/KkSvNBjoAYv8Z0oZe9+dGP78lMJIdHGQxqhKUtiA/8ZEG5LmQ=
X-Received: by 2002:a17:90b:2711:b0:340:c179:3657 with SMTP id
 98e67ed59e1d1-35368f29af6mr2833436a91.33.1769181166781; Fri, 23 Jan 2026
 07:12:46 -0800 (PST)
MIME-Version: 1.0
References: <20260123145750.1200879-1-alex.bennee@linaro.org>
 <20260123145750.1200879-9-alex.bennee@linaro.org>
In-Reply-To: <20260123145750.1200879-9-alex.bennee@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Fri, 23 Jan 2026 08:12:33 -0700
X-Gm-Features: AZwV_QjYjgXKQMtx5nfk9pUq7hZcrOYwTAobAljvzaW3ZlFlqobWYBbuGpO13hU
Message-ID: <CANCZdfo3yz=aC-EOxd2LYBX=tf=RQTY6ibCpj-fCfGHZtH6WTw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 08/16] MAINTAINERS: be realistic about *-user
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Joe Perches <joe@perches.com>, John Snow <jsnow@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000fd568106490f96e7"
Received-SPF: none client-ip=2607:f8b0:4864:20::530;
 envelope-from=wlosh@bsdimp.com; helo=mail-pg1-x530.google.com
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

--000000000000fd568106490f96e7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 23, 2026 at 8:00=E2=80=AFAM Alex Benn=C3=A9e <alex.bennee@linar=
o.org> wrote:

> We should reflect the current status so users don't have unrealistic
> expectations of how quickly things can get reviewed and merged.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>

Reviewed-by: Warner Losh <imp@bsdimp.com>


> ---
>
> [AJB] I realise this is a slightly provocative patch but given how
> widely used *-user is downstream we should be clear about the current
> state and hopefully encourage those who rely on it to step-up.
>

For the bsd-user case this is likely correct. We run hot and cold about
being
proactive at fixing things, and we've been somewhat cold for a while now.

Part of the problem is that this submission process is very very heavyweigh=
t
compared to other projects I contribute to. Not sure what to do about that
since
there's a reluctance to move away from it. Or alternatively, I'm somehow
making
it too hard.

A lot of the upstreaming work that's stalled would be ideal to tell claude
to do,
but I'm unsure the project's stance on using claude to move code, and git
log
5 different trees to get the original author(s) of the code and make
trivial compile
tweaks.

Warner

--000000000000fd568106490f96e7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jan 23,=
 2026 at 8:00=E2=80=AFAM Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee=
@linaro.org">alex.bennee@linaro.org</a>&gt; wrote:<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">We should reflect the current status so =
users don&#39;t have unrealistic<br>
expectations of how quickly things can get reviewed and merged.<br>
<br>
Signed-off-by: Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.or=
g" target=3D"_blank">alex.bennee@linaro.org</a>&gt;<br></blockquote><div><b=
r></div><div>Reviewed-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com"=
>imp@bsdimp.com</a>&gt;</div><div>=C2=A0</div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">
---<br>
<br>
[AJB] I realise this is a slightly provocative patch but given how<br>
widely used *-user is downstream we should be clear about the current<br>
state and hopefully encourage those who rely on it to step-up.<br></blockqu=
ote><div><br></div><div>For the bsd-user case this is likely correct. We ru=
n hot and cold about being</div><div>proactive at fixing things, and we&#39=
;ve been somewhat cold for a while now.</div><div><br></div><div>Part of th=
e problem is that this submission process is very very heavyweight</div><di=
v>compared to other projects I contribute to. Not sure what to do about tha=
t since</div><div>there&#39;s a reluctance to move=C2=A0away from it. Or al=
ternatively, I&#39;m somehow making</div><div>it too hard.</div><div><br></=
div><div>A lot of the upstreaming work that&#39;s stalled would be ideal to=
 tell claude to do,</div><div>but I&#39;m unsure the project&#39;s stance o=
n using claude to move code, and git log</div><div>5 different trees to get=
 the original author(s) of the code and make trivial compile</div><div>twea=
ks.</div><div><br></div><div>Warner=C2=A0</div></div></div>

--000000000000fd568106490f96e7--

