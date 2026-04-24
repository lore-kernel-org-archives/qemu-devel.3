Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7AFCFB44A2
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 04:23:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wG84B-0003wR-0e; Fri, 24 Apr 2026 00:22:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wG849-0003w1-SF
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 00:22:57 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wG846-0007Wd-SA
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 00:22:57 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-676a89de629so6134738a12.1
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 21:22:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777004572; cv=none;
 d=google.com; s=arc-20240605;
 b=O+0sZ/PxSUAszZr3ct7CL8M+UTYNBQ747hDo5hvBMs9vSrynbewIO26BylOTc5vjTC
 7dh6vO3oiJeZlLnyqWqr3OcdB6EcO4x04NpPUrZw+N7S4xXXfIsGmhlzlz14rArRb1U0
 4CWwPgP7zI8If5yYjvJ27vUvMbPJaOz+o9VmGZHu5AGr+8FjkkGxRlb7nDlpU7ERu6MS
 a0jrNpYley/rK4nFeTLk05mhKKxk/X2Vo5PlzHxN9vE86ctIssKuUfkeGUWBicbG5qmZ
 qBXVYqQ9bOvk4XGGd3SuDHnxPfE7Lt8i3LD1NLGZ3SvleQB00WNHqR6TzJGGLR60m5uF
 vRaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=u1f0O94g8U/SS+6OPKnao0PQNkyUF5KdjyZnBmaqmi4=;
 fh=7IRPdKWihurlpF15buHAUNV1ji30dsHBjOJ6xZ//2b4=;
 b=Q39w+JNCUm/TdV8ejhOPY4oM5Ghu86dADbAHlOcxuktQSnV7DFDuCqhYMfa8bYcuoR
 vFF4Og62YRcCxDIt+HXAZjy4Yflqnrxy+kRW99MvyBtwqKynS4mDsgoXytg6VpppQGnx
 BhFgOMsv4PU29hPU5LakRsogdACCHLFfjUGf8A5HQkMqRXXOyazzOOZg0neGyQNO7MUX
 87wfC/kYXYPLOVI3Hhl9gXt0pZ91ihWyY3bjSuMhnVdFjWGfsWV3USJxV7vCEGP54A2t
 PJwcBdSyEFPxflhCyhS4+ZsQlBPvfu0+T41s+BZuAasSos68vWWCqAQyn4S9/UtZkcqB
 7TBA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1777004572; x=1777609372; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=u1f0O94g8U/SS+6OPKnao0PQNkyUF5KdjyZnBmaqmi4=;
 b=bRfnvor1a0YyIlkLl/lo0m5hWEk+R3GYWA89mma5axaF5/3iem3GjaOi7uesQdM/Ob
 x6l6tyCxkQU5EavzD17ZF+R+3w/5o0uFed8Rr/3VeJB782oRh4R8Ij05OPb5xikeiaws
 ubJg7tiA2GBSmsaz/dIht4u7OKv+s23hMfYDUAauLeNLCpo5+dd3gnoOhpYVWXZkcY9E
 jkbpQxIhH7Mr7p02mYhfZlwfIksmkxKKkqIYyEFW+d0cNqtyS0nxNgiNZuMhkZVEelUO
 1VONjUf3nVWq74PQVZm9k57Xgjlt2qTpLoqHK94TrMvjgXE/cxB4CdDf74OlozHDOgLC
 F+vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777004572; x=1777609372;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u1f0O94g8U/SS+6OPKnao0PQNkyUF5KdjyZnBmaqmi4=;
 b=Qu0SG+k7FqiyPhnZVPJbmKDaz32d8duaA4qVciwuRrT1mzVCfXwrpNrJY5m9JTibuo
 4OM/Ekk3VHc2q9OiC+gGQLmqYKjvpjgu/VcHMPzlFDmsd2U5G4vJl5c9bAIf7Zji/cP5
 WLIwcs5hQq3iv1kwRYI1UWKF9EMnZhF9jlnieEGZNjDVX8jE/Gh520R7gNy4jEkaNAoB
 ghsE7ZWyVi33OiZJyxKahJ2qTioWXMVrn7Bc/9sR1HW8w1anQOi7sEAK994IPS+V8Vdu
 xkbpsljD2Pfdz4knKs/Z1W1pS5jjqDMUvo6cvZSazbZypa8z2i7M0PJmIo15hB5Yt3a6
 eRgw==
X-Gm-Message-State: AOJu0YzGHu/tgAOUsojqQGcmtsZIQGxT73ntR2GxAg/ocLKBLAHi9APZ
 8c7QNLKbxN+2bbGLdXO9WTkrDFV66jg9QW2GG1S3gIEx+4ZDPMWR9/35Vm726s+jAuCJKxGd/r8
 NasZHpGZACBliBrM5ozvapYPeYyArC6BNMPldqMwxBw==
X-Gm-Gg: AeBDietj1yl4mEjMdNnLOGhMv6/+XxTpCh6v3Hnco8IpPGOEdTW3+5fz4XEswOrmxmr
 R5+bZ6uw1i388uuo9ZTciA55ue9+9vtG14d6jTqOTvx4MzfXFhtZqmpJQqqk7Ov9ERkQasJdcp0
 rni3axzdJvG5+U7L/xlD/E+TBbDEYXV1sq9qlMNA57liV6pvbcvcSoPoEWItDnnFZ1/GZ0F9WNN
 24Aiy4K1frtB5Vp9uxPjiIdrDmxFrtKHQgkXude2OMzo6HkwOQ2SpJKPkb1ahMJLWy05dFViAAQ
 V1r7gEZ7WEyFQjV/SE+P0sz7Im4ezfE=
X-Received: by 2002:a17:907:a0d6:b0:b98:595c:a76f with SMTP id
 a640c23a62f3a-ba418888cfdmr1441623166b.16.1777004572364; Thu, 23 Apr 2026
 21:22:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260421074204.2908422-1-frank.chang@sifive.com>
 <CAKmqyKN95aMOGAXDeVt89fduMiefeA6OHj4x80Nx0wj9_jAL8A@mail.gmail.com>
In-Reply-To: <CAKmqyKN95aMOGAXDeVt89fduMiefeA6OHj4x80Nx0wj9_jAL8A@mail.gmail.com>
From: Frank Chang <frank.chang@sifive.com>
Date: Fri, 24 Apr 2026 12:22:40 +0800
X-Gm-Features: AQROBzDehgGVBOEu4wpD2iDAgnRSHveVxfHuY8WdFuWd3E0Q9YCkjTHvNugJpn8
Message-ID: <CAE_xrPhpZaY2rGswVXo1-+mmSskGTq9HR15zGiUmUfq1YbPBKg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Add the implied rules for G and B extensions
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, 
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>
Content-Type: multipart/alternative; boundary="0000000000004ce61206502d1ed6"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=frank.chang@sifive.com; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--0000000000004ce61206502d1ed6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 22, 2026 at 7:41=E2=80=AFAM Alistair Francis <alistair23@gmail.=
com>
wrote:

> On Tue, Apr 21, 2026 at 5:42=E2=80=AFPM <frank.chang@sifive.com> wrote:
> >
> > From: Frank Chang <frank.chang@sifive.com>
> >
> > Add the implied rules for G and B extensions to enable the implied
> > extensions.
> >
> > Changelog:
> >   v2: Remove riscv_cpu_validate_g() and riscv_cpu_validate_b() as the
> >       implied extensions can be enabled by the implied rules.
>
> Can they though?
>
> The original commit  8b3b3451052cd7a115c9352de1bb8c74ee54a62e says
>
> For every RVG MISA bit (IMAFD), zicsr and zifencei, the logic then
> becomes:
>
> - if enabled, do nothing;
> - if disabled and not user set, enable it;
> - if disabled and user set, throw a warning that it's a RVG mandatory
>   extension.
>
> Isn't that what we want?


> Alistair
>

Hi Alistair,

Thanks for the review.
You are right. I think the proper way is to remove the auto-enables in
riscv_cpu_validate_g() and riscv_cpu_validate_b() only, but keep the
warnings.

Implied rule won't enable the extensions that are set by the user.
So, if users disable the implied extension explicitly,
we should warn them without enabling the implied extension.

For examples,
$ -cpu rv64,g=3Dtrue,a=3Dfalse
qemu-system-riscv64: warning: RVG mandates disabled extension a

$ -cpu rv64,g=3Dtrue,zicsr=3Dfalse
qemu-system-riscv64: warning: RVG mandates disabled extension zicsr
qemu-system-riscv64: F extension requires Zicsr

$ -cpu rv64,b=3Dtrue,zbb=3Dfalse
qemu-system-riscv64: warning: RVB mandates disabled extension zbb

However, if user sets"g=3Dtrue" or "b=3Dtrue", the implied extensions will =
be
enabled by the implied rules.

I will fix it and send out a new patchset.

Regards,
Frank Chang

>
> >
> > Frank Chang (1):
> >   target/riscv: Add standard B extension implied rule
> >
> > Jim Shu (1):
> >   target/riscv: Add the implied rule for G extension
> >
> >  target/riscv/cpu.c         | 26 ++++++++++++-
> >  target/riscv/tcg/tcg-cpu.c | 77 --------------------------------------
> >  2 files changed, 25 insertions(+), 78 deletions(-)
> >
> > --
> > 2.43.0
> >
> >
>

--0000000000004ce61206502d1ed6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Apr 22,=
 2026 at 7:41=E2=80=AFAM Alistair Francis &lt;<a href=3D"mailto:alistair23@=
gmail.com">alistair23@gmail.com</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">On Tue, Apr 21, 2026 at 5:42=E2=80=AFPM &l=
t;<a href=3D"mailto:frank.chang@sifive.com" target=3D"_blank">frank.chang@s=
ifive.com</a>&gt; wrote:<br>
&gt;<br>
&gt; From: Frank Chang &lt;<a href=3D"mailto:frank.chang@sifive.com" target=
=3D"_blank">frank.chang@sifive.com</a>&gt;<br>
&gt;<br>
&gt; Add the implied rules for G and B extensions to enable the implied<br>
&gt; extensions.<br>
&gt;<br>
&gt; Changelog:<br>
&gt;=C2=A0 =C2=A0v2: Remove riscv_cpu_validate_g() and riscv_cpu_validate_b=
() as the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0implied extensions can be enabled by the imp=
lied rules.<br>
<br>
Can they though?<br>
<br>
The original commit=C2=A0 8b3b3451052cd7a115c9352de1bb8c74ee54a62e says<br>
<br>
For every RVG MISA bit (IMAFD), zicsr and zifencei, the logic then<br>
becomes:<br>
<br>
- if enabled, do nothing;<br>
- if disabled and not user set, enable it;<br>
- if disabled and user set, throw a warning that it&#39;s a RVG mandatory<b=
r>
=C2=A0 extension.<br>
<br>
Isn&#39;t that what we want?=C2=A0</blockquote><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">
<br>
Alistair<br></blockquote><div><br></div><div>Hi Alistair,</div><div><br></d=
iv><div>Thanks for the review.</div><div>You are right. I think the proper =
way is to remove the auto-enables in</div><div>riscv_cpu_validate_g() and=
=C2=A0riscv_cpu_validate_b() only, but keep the warnings.</div><div><br></d=
iv><div>Implied rule won&#39;t enable the extensions that <span class=3D"As=
give ng" style=3D"border-style:none;background:none">are set by the user.</=
span></div><div>So, if <span class=3D"Asgive ng" style=3D"border-style:none=
;background:none">users disable the implied extension explicitly,</span></d=
iv><div><span class=3D"Q6ibn ng" style=3D"border-style:none;background:none=
">we</span> should warn them without enabling the implied extension.</div><=
div><br></div><div>For <span class=3D"Asgive ng" style=3D"border-style:none=
;background:none">examples,</span></div><div>$ -cpu rv64,g=3Dtrue,a=3Dfalse=
</div><div>qemu-system-riscv64: <span class=3D"Q6ibn ng" style=3D"border-st=
yle:none;background:none">warning:</span> RVG mandates disabled extension a=
</div><div><br></div><div>$ -cpu rv64,g=3Dtrue,zicsr=3Dfalse</div><div>qemu=
-system-riscv64: warning: RVG mandates disabled extension zicsr<br>qemu-sys=
tem-riscv64: F extension requires Zicsr</div><div><br></div><div>$=C2=A0-cp=
u rv64,b=3Dtrue,zbb=3Dfalse</div><div>qemu-system-riscv64: warning: RVB man=
dates disabled extension zbb</div><div><br></div><div>However, if user sets=
&quot;g=3Dtrue&quot; or &quot;b=3Dtrue&quot;, the implied extensions will b=
e enabled by the implied rules.</div><div><br></div><div>I will fix it and =
send <span class=3D"Asgive ng" style=3D"border-style:none;background:none">=
out </span>a new patchset.</div><div><br></div><div>Regards,</div><div>Fran=
k Chang</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt;<br>
&gt; Frank Chang (1):<br>
&gt;=C2=A0 =C2=A0target/riscv: Add standard B extension implied rule<br>
&gt;<br>
&gt; Jim Shu (1):<br>
&gt;=C2=A0 =C2=A0target/riscv: Add the implied rule for G extension<br>
&gt;<br>
&gt;=C2=A0 target/riscv/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 26 +++++++=
+++++-<br>
&gt;=C2=A0 target/riscv/tcg/tcg-cpu.c | 77 --------------------------------=
------<br>
&gt;=C2=A0 2 files changed, 25 insertions(+), 78 deletions(-)<br>
&gt;<br>
&gt; --<br>
&gt; 2.43.0<br>
&gt;<br>
&gt;<br>
</blockquote></div></div>

--0000000000004ce61206502d1ed6--

