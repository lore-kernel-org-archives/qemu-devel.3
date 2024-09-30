Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ACBFCF6497
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 10:51:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svE0F-00019i-JB; Mon, 30 Sep 2024 06:51:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1svE08-0000zP-Cl
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 06:51:36 -0400
Received: from mail-oo1-xc2f.google.com ([2607:f8b0:4864:20::c2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1svE05-0007a4-6o
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 06:51:36 -0400
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-5e1b55346c0so1765062eaf.3
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2024 03:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727693491; x=1728298291; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6je4AeBhA07k2xVNljyBA5pChrHLCrplye3LX/qRrmY=;
 b=HCH7qAylwTOVRAFTivpM7r93ScfTwztqhQ4vs6N5EBB9XVdPpw7RYI6QE6K4wMuf+Y
 P5zFVGPJGNlDZULHyyquF3+XSr1fPyMJMxFaXKiO6g896h5y+YiMC1qbICZnZf4j4J8D
 PnqHPO3OKHEkFp2+jR4Cv9CAs+qSm7V/OY8wfjmboHlDHikVi5Mf7sSbUug86tTeK64U
 IAyiyLLmPwQMMbFIJllKkZngCFe0CkrskV22NS+sGusn9V1OpAFM/gNa2GObZs2iRwEg
 GSJcWCJeA+YfPYQp5v2gJKWRBAxMcQQ9VwoPPM2f0tcmNSkyG+dXRFaHR/r9mPJ/+juS
 eyDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727693491; x=1728298291;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6je4AeBhA07k2xVNljyBA5pChrHLCrplye3LX/qRrmY=;
 b=vM6EwD3O8QnRceR5Jc4ynt4A60fovbV5QUE1Wftr8yrwCfr0IzSiQLepPcVFMHKvn1
 aZAVr4ingDzmexyytixdprmMM8etSMzZHtw0ke63dbVCHZn6ZEPkAj1NGuZ8eDUj+P0u
 0Xo1o37e1EVOZCZraScCFmRJsfCixacsoAHYSWG6CcRzjU8v3GkEh2BixweEV6CYCwjy
 xS7QzicDrVHjsBK4aSrNtMZABXr6AnmYOhP6e931drL5uqtsYAL9qPvWye4VPJO310JN
 z73pagTiyrXRWyHFaWCww4J1lBVuAdfaRtiYJyD6D5YKAZykPrneII4nF+cRgiR0JLXU
 a7eA==
X-Gm-Message-State: AOJu0Yy7nMcsLTSH6gzM7qYtjOn/3Tl797ie2UXrvQVy5dpRyyQ3mZo5
 cm9dmDQd2Zap2hvg7IJicVHD9JiBZUyp4+bnsdV8rrVtqd7RLFgCLChFRm1NoqOTVFOJGUSFzsa
 0EulaKBR4zzMBTO6T/ygecbkvC50=
X-Google-Smtp-Source: AGHT+IFCRzlI+8jY0d6hNHGbynZ3hqVv7IRMi5vq82vMcvdnlpL5C++zw2X9NA1Ix6AI8cUjcb1dNUc4xPoUEKAodXM=
X-Received: by 2002:a05:6820:1ca0:b0:5e1:ec93:2227 with SMTP id
 006d021491bc7-5e7727a11f3mr5413878eaf.6.1727693491284; Mon, 30 Sep 2024
 03:51:31 -0700 (PDT)
MIME-Version: 1.0
References: <871q16fq9c.fsf@draig.linaro.org>
 <CAJSP0QVB+e1JSyQ3iMRivyh=ufyDkz12AESvJhoPnYJEnt9eug@mail.gmail.com>
 <87y139o2wx.fsf@draig.linaro.org>
In-Reply-To: <87y139o2wx.fsf@draig.linaro.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 30 Sep 2024 06:51:20 -0400
Message-ID: <CAJSP0QVcFvXDKvWVoNa0WTMYMgjzfvawQF6L4xCD72ALKa73wg@mail.gmail.com>
Subject: Re: Rust BoF and maintainer minutes and planning the roadmap to Rust
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 pkg-qemu-devel@lists.alioth.debian.org, 
 Michael Tokarev <mjt@tls.msk.ru>, Natanael Copa <ncopa@alpinelinux.org>,
 bofh@freebsd.org, 
 emulation@freebsd.org, virtualization@gentoo.org, dilfridge@gentoo.org, 
 Alyssa Ross <hi@alyssa.is>, edolstra+nixpkgs@gmail.com,
 Brad <brad@comstyle.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Thomas Huth <thuth@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, dvzrv@archlinux.org,
 anatol.pomozov@gmail.com, Miroslav Rezanina <mrezanin@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000d43448062353fc3c"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2f;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc2f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--000000000000d43448062353fc3c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024, 06:24 Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote=
:

> Stefan Hajnoczi <stefanha@gmail.com> writes:
>
> > On Thu, 26 Sept 2024 at 10:24, Alex Benn=C3=A9e <alex.bennee@linaro.org=
>
> wrote:
> <snip>
> >> Another potential area for conversion was the VirtIO device and
> >> vhost-user code which could expect to re-use a lot of the crates from
> >> the rust-vmm project. However this did bring up the point of maintaine=
r
> >> buy in. Stefan brought up the example of the simpletrace rewrite which
> >> while it may have brought some advantages he felt he was unable to tak=
e
> >> as a maintainer as he was not familiar with Rust at that point.
> >
> > Familiarity with Rust was not the issue with simpletrace. I had
> > already worked on libblkio in Rust and was able to understand the Rust
> > simpletrace patches.
>
> Apologies for misrepresenting the issue there. My notes obviously didn't
> capture that nuance.


No worries. Thanks for taking notes!

Stefan


>
> > It was a question of when rewriting in Rust is appropriate. Surprising
> > maintainers with a rewrite is risky because they may not be convinced
> > by the rewrite after all the work to write it has been done.
> >
> > In the case of simpletrace there wasn't a clear benefit to a rewrite:
> > performance was potentially better in Rust (performance hadn't been a
> > problem for users though) but usability was impacted by converting a
> > scriptable Python module to Rust (requiring users to rewrite their
> > scripts). The rewrite was dropped.
> >
> > What I tried to express at the Rust BoF was: talk to maintainers
> > before embarking on a rewrite.
>
> Yes this is the I think the key takeaway because the project would not
> be able to absorb a bunch of drive-by rust rewrites from well meaning
> contributors.
>
> >> With relative inexperience there was a concern we could inadvertently
> >> introduce technical debt in the code base (C-like Rust vs Rusty rust).
> >> What can we do to mitigate that issue?
> >
> > My suggestion is that every `unsafe` needs a comment explaining why it
> > is safe. That increases the cost of using `unsafe` and encourages safe
> > abstractions.
> >
> > There are plenty of unidiomatic ways of using Rust, but none are as
> > bad as sprinkling `unsafe` everywhere (i.e. writing C in Rust) since
> > that's how undefined behavior is introduced.
> >
> > Stefan
>
> --
> Alex Benn=C3=A9e
> Virtualisation Tech Lead @ Linaro
>

--000000000000d43448062353fc3c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Mon, Sep 30, 2024, 06:24 Alex Benn=C3=A9e &lt;<a hr=
ef=3D"mailto:alex.bennee@linaro.org">alex.bennee@linaro.org</a>&gt; wrote:<=
br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">Stefan Hajnoczi =
&lt;<a href=3D"mailto:stefanha@gmail.com" target=3D"_blank" rel=3D"noreferr=
er">stefanha@gmail.com</a>&gt; writes:<br>
<br>
&gt; On Thu, 26 Sept 2024 at 10:24, Alex Benn=C3=A9e &lt;<a href=3D"mailto:=
alex.bennee@linaro.org" target=3D"_blank" rel=3D"noreferrer">alex.bennee@li=
naro.org</a>&gt; wrote:<br>
&lt;snip&gt;<br>
&gt;&gt; Another potential area for conversion was the VirtIO device and<br=
>
&gt;&gt; vhost-user code which could expect to re-use a lot of the crates f=
rom<br>
&gt;&gt; the rust-vmm project. However this did bring up the point of maint=
ainer<br>
&gt;&gt; buy in. Stefan brought up the example of the simpletrace rewrite w=
hich<br>
&gt;&gt; while it may have brought some advantages he felt he was unable to=
 take<br>
&gt;&gt; as a maintainer as he was not familiar with Rust at that point.<br=
>
&gt;<br>
&gt; Familiarity with Rust was not the issue with simpletrace. I had<br>
&gt; already worked on libblkio in Rust and was able to understand the Rust=
<br>
&gt; simpletrace patches.<br>
<br>
Apologies for misrepresenting the issue there. My notes obviously didn&#39;=
t<br>
capture that nuance.</blockquote></div></div><div dir=3D"auto"><br></div><d=
iv dir=3D"auto">No worries. Thanks for taking notes!</div><div dir=3D"auto"=
><br></div><div dir=3D"auto">Stefan</div><div dir=3D"auto"><br></div><div d=
ir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex"> <br>
<br>
&gt; It was a question of when rewriting in Rust is appropriate. Surprising=
<br>
&gt; maintainers with a rewrite is risky because they may not be convinced<=
br>
&gt; by the rewrite after all the work to write it has been done.<br>
&gt;<br>
&gt; In the case of simpletrace there wasn&#39;t a clear benefit to a rewri=
te:<br>
&gt; performance was potentially better in Rust (performance hadn&#39;t bee=
n a<br>
&gt; problem for users though) but usability was impacted by converting a<b=
r>
&gt; scriptable Python module to Rust (requiring users to rewrite their<br>
&gt; scripts). The rewrite was dropped.<br>
&gt;<br>
&gt; What I tried to express at the Rust BoF was: talk to maintainers<br>
&gt; before embarking on a rewrite.<br>
<br>
Yes this is the I think the key takeaway because the project would not<br>
be able to absorb a bunch of drive-by rust rewrites from well meaning<br>
contributors.<br>
<br>
&gt;&gt; With relative inexperience there was a concern we could inadverten=
tly<br>
&gt;&gt; introduce technical debt in the code base (C-like Rust vs Rusty ru=
st).<br>
&gt;&gt; What can we do to mitigate that issue?<br>
&gt;<br>
&gt; My suggestion is that every `unsafe` needs a comment explaining why it=
<br>
&gt; is safe. That increases the cost of using `unsafe` and encourages safe=
<br>
&gt; abstractions.<br>
&gt;<br>
&gt; There are plenty of unidiomatic ways of using Rust, but none are as<br=
>
&gt; bad as sprinkling `unsafe` everywhere (i.e. writing C in Rust) since<b=
r>
&gt; that&#39;s how undefined behavior is introduced.<br>
&gt;<br>
&gt; Stefan<br>
<br>
-- <br>
Alex Benn=C3=A9e<br>
Virtualisation Tech Lead @ Linaro<br>
</blockquote></div></div></div>

--000000000000d43448062353fc3c--

