Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30A08FCB61C
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 16:28:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyY2M-0004wk-Ho; Fri, 06 Mar 2026 11:28:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1vyY2K-0004t9-8i
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 11:28:24 -0500
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1vyY2H-0001fP-OK
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 11:28:24 -0500
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-35995cb33a8so3138068a91.0
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 08:28:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772814500; cv=none;
 d=google.com; s=arc-20240605;
 b=ddR4K+Uy0VrIZDRhTHJY525XYbcPX0ERWWE65Sant9F6ccSVMRVGRo6VKNHqBYe7LS
 iBu4MC3A4fQRBNZk4gHlzhoh/7B1wOfLh/VNaFXkPOGLLTTncyKXaX1fngJ540Kx9W4G
 X9iiW3SUj/0FPRaZxJc0K8ARwBPOG1k9LjHt7+AKHUlrzRtS/KF2BUAFoCmITUDfR63S
 NX5oUooCTRwyzEQ9CBy7FglRgoEwAmNUEqEl3eqA/+eBNgfj+BajdJj6C8Hj79ZEQYDI
 2Eoi1fCHa4K6YUcoD86+x6HESKXc38s7fFm1M4X5F6xxJQYm4a6BqlYyJ+jZU6SVNgbw
 GA5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=tKEwHO7uwqOBIZgNKpgfUN6U1qEvZJo9YUDOie9ou28=;
 fh=3qUuBNeQGLGc8SJQr+mdaV1sqgu10HJzCBUR3PXbE/8=;
 b=R8/TXAFLvM0w/Ex9EPDuBJ7EaecEEG8JeyDPiGE+PwN9W2RdL0eocS4e+vM5r8wrkQ
 IuV+FOr+hLAmmzjgqicFAUrxdoz48UwTBo0aD7Y9h8tXz+X+xB0Z3pvYJtiHrFeV4u0f
 DOXCTjq4gVviEIXJ4taMhBkeOX7kiHCdo+t+/Gd7vbUl1YtBYUz56PJROZsHLSqOaUYj
 bcBbGfcOZO/mg9zwLRBFWJYj2gXL03jEdzkMJFXcMV+LVwoCIRx8o454hcQW2cit604O
 HL3c7P6ee+qVFVDMgNt24M4ZzXBgoc8iCzqvtwzc9v8U2O++SiRithEFolsFXfdNuX7U
 zIEg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1772814500; x=1773419300;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tKEwHO7uwqOBIZgNKpgfUN6U1qEvZJo9YUDOie9ou28=;
 b=tc/U1V+Bi3wJXdho4aHOvv9kJIuor0ttfYWpG1bqYBiDrgtV/WK9TNt6IghMpVb6j+
 fLfO6aeXE0tiwwPleJQvVUy8z2Z2TIRK4HOm8oi2Sl1yQajm3ov0gHOuZT0rjrUi+WpX
 g2Q48b2xsDa9SdapLQf9x4GGWAvqq77OcbhCQkhGOtz10XcGjutlSh69HAP0s3Em99Zh
 Sj76rPX3HJYWC8VLF8ena3knkVI2ISGDGArzobN7GUUhxb93VsWE07Wc38EuKK4jycQO
 nKb+/CCao7aCwtURdf7ko55Gh8ScwTmn/K+7rAWkXJNJ+GIC1d8D19HRnGToCJYXOZtX
 H4Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772814500; x=1773419300;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tKEwHO7uwqOBIZgNKpgfUN6U1qEvZJo9YUDOie9ou28=;
 b=i4CeXAcKkphddcj7d/XG4bOgAjejYjbmMQBogJ5ZsigLIqact0or9SwQAmIAB6pycM
 a/TNXSZ0JxpdsvdsPZRki/z0wjJyy3WL3WFlgMS1seN6RXXOVzPpOup94XvMs02MvNT6
 h8k6MCOJZNMRTMPnRAzenY6xFYOa3qnw1PpUsphYm7DDzaC35Yxc4QJyzd5ZkjKsag8+
 p2QDBpjaBRP2sq3rOASVabu0RggOPc3QlFz4M9d3ckYzlp9NQRQYxkKnJMNzTfq1rdl/
 v+Ln0HTYDGOWiUFgmqKna4JPMhYCTaiOe8N9/L2HXnOjewfKewNfe3IrJHYkTBs1xa37
 0v9g==
X-Gm-Message-State: AOJu0YwKxLl47RXtZMXQ/KBH8/3rhnK0Rdzawq889lZob7dxXET5L0sl
 PRom6F9Im4xUwLAvSVC6CmZikKCtSomrmsaJb+4qHB77Kbe4sMYDuCsjSn7XjPdryDLTAAvxDYR
 dLvv5LgD3+xV31Sy7x0JkbXAXDrvfoOrgUl+pfBDWGw==
X-Gm-Gg: ATEYQzzWw3VJSDMNLuDju+4VKZVGXMaPqWlxNEGMvwY5TkgRJksyEF062lGtHXVbYc1
 iaUD0wuNTQvKr3F4hPgXTFtx1qH6ic+qCckqShSRQTpm9PVZjUMk22U0FuF8lLLEgYgQdDeN3rX
 iRXAMxiyXhbvM1nbdhZs8SYtDqxVkZBEXGzAmHbVHJivADP6m27jpgQuQcg+wJaiWS6LdRco/vr
 xDACvU3DEf+P3z0x2PEEoh9ohHYkzkiWK8sYXSznKp6kA8vDmfe3fYhswl3hRQXmTtpzscjH5oF
 FKRu9B8=
X-Received: by 2002:a17:90b:2c90:b0:358:fbe2:b3df with SMTP id
 98e67ed59e1d1-359b1c31037mr6029114a91.15.1772814500073; Fri, 06 Mar 2026
 08:28:20 -0800 (PST)
MIME-Version: 1.0
References: <20260304-bsd-user-copyright-v2-1-173525ffa614@bsdimp.com>
 <aarg1MVnbcnxLMEL@redhat.com>
In-Reply-To: <aarg1MVnbcnxLMEL@redhat.com>
From: Warner Losh <imp@bsdimp.com>
Date: Fri, 6 Mar 2026 09:28:09 -0700
X-Gm-Features: AaiRm513IW5cBmIY_EpJaCkKIIIK1MS5mBKvE6Ewceq1OiSfP8iBrLbCV5MChcg
Message-ID: <CANCZdfrs5JgsSCoRnNvsN5uQH3KbO8n+8gm7s5WyKJHzR1Wu4Q@mail.gmail.com>
Subject: Re: [PATCH v2] bsd-user: Switch to SPDX-License-Expression
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Kyle Evans <kevans@freebsd.org>, 
 Stacey Son <sson@freebsd.org>, Sean Bruno <sbruno@freebsd.org>, 
 =?UTF-8?Q?Mika=C3=ABl_Urankar?= <mikael.urankar@gmail.com>, 
 Guy Yur <guyyur@gmail.com>, Alexander Kabaev <kan@freebsd.org>,
 Michal Meloun <mmel@freebsd.org>, Ed Schouten <ed@nuxi.nl>
Content-Type: multipart/alternative; boundary="00000000000087a0c5064c5d8a48"
Received-SPF: none client-ip=2607:f8b0:4864:20::1030;
 envelope-from=wlosh@bsdimp.com; helo=mail-pj1-x1030.google.com
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

--00000000000087a0c5064c5d8a48
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 6, 2026 at 7:12=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@re=
dhat.com>
wrote:

> On Wed, Mar 04, 2026 at 09:05:33AM -0700, Warner Losh wrote:
> > Two minor changes to the copyright and license marking for these files:
> > (1) Stacey D Son is used instead of variations of his name.
> > (2) The GPL boilerplate is replaced by SPDX markings. No change to the
> > terms of the license are intended, and this matches current QEMU
> practice.
> >
> > There's no changes to the license or additional claims to any IP that
> > others may hold in these files. All the S-o-bs in this commit have give=
n
> > me permission to do this to the extent they may hold rights. git blame
> > over multiple repos and branches suggests that only minimal other
> > material is present (much of it likely not subject to copyright
> > protection). The project's long and complex history as well as tooling
> > limitations make it hard to be 100% sure. Any omissions are
> > unintentional and I will correct them as they come to light.
> >
> > Signed-off-by: Stacey Son <sson@FreeBSD.org>
> > Signed-off-by: Sean Bruno <sbruno@FreeBSD.org>
> > Signed-off-by: Mika=C3=ABl Urankar <mikael.urankar@gmail.com>
> > Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
> > Signed-off-by: Guy Yur <guyyur@gmail.com>
> > Signed-off-by: Alexander Kabaev <kan@FreeBSD.org>
> > Signed-off-by: Michal Meloun <mmel@FreeBSD.org>
> > Signed-off-by: Ed Schouten <ed@nuxi.nl>
> > Signed-off-by: Warner Losh <imp@bsdimp.com>
>
> Thanks, I used that set of emails to filter out commits
>
> Out of the remaining commits/files with other authors, most were a
> case of  trivial function renames, code deletion, or trivial syntax
> fixes to deal with external cleanups which can be exluded.
>
> The only files where I saw any non-trivial code from other contributors
> are
>
> bsd-user/bsd-mem.h: 8
> bsd-user/elfload.c: 36
> bsd-user/freebsd/os-misc.h: 1
> bsd-user/freebsd/os-proc.c: 3
> bsd-user/freebsd/os-proc.h: 3
> bsd-user/qemu.h: 58
> bsd-user/strace.c: 7
>
> There are way too many historic authors for elfload.c, qemu.h and
> strace.c to make it worth chasing those down, so I'd suggest just
> dropping those three files from the commit.
>

I'll drop those. The qemu.h issue is more Blue Swirl shows in git blame,
and those files are more from linux-user, which git blame is useless to
chase down.


> For bsd-mem.h, and freebsd/os* Karim Taha <kariem.taha2.7@gmail.com>
> is the only notable omission I saw. Up to you whether to check with
> them or just drop those files from the cleanup.
>

Karim's case is interesting. He was a GSoC student that took the work
from bsd-user blitz branch. In the blitz branch, the blame shows style
changes and a few other tweaks from the upstreaming. He also contributed
some things that aren't in these files. He shows up as more than that in
in qemu's upstream repo because of the code copying. That's why I
hadn't contacted him.

I'll chase those down and also see if I can make contact with him. I had
trouble reaching him after he entered the military after GSoC finished, but
haven't tried in years.

Warner

--00000000000087a0c5064c5d8a48
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Mar 6, =
2026 at 7:12=E2=80=AFAM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berra=
nge@redhat.com">berrange@redhat.com</a>&gt; wrote:<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">On Wed, Mar 04, 2026 at 09:05:33AM -0700=
, Warner Losh wrote:<br>
&gt; Two minor changes to the copyright and license marking for these files=
:<br>
&gt; (1) Stacey D Son is used instead of variations of his name.<br>
&gt; (2) The GPL boilerplate is replaced by SPDX markings. No change to the=
<br>
&gt; terms of the license are intended, and this matches current QEMU pract=
ice.<br>
&gt; <br>
&gt; There&#39;s no changes to the license or additional claims to any IP t=
hat<br>
&gt; others may hold in these files. All the S-o-bs in this commit have giv=
en<br>
&gt; me permission to do this to the extent they may hold rights. git blame=
<br>
&gt; over multiple repos and branches suggests that only minimal other<br>
&gt; material is present (much of it likely not subject to copyright<br>
&gt; protection). The project&#39;s long and complex history as well as too=
ling<br>
&gt; limitations make it hard to be 100% sure. Any omissions are<br>
&gt; unintentional and I will correct them as they come to light.<br>
&gt; <br>
&gt; Signed-off-by: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
&gt; Signed-off-by: Sean Bruno &lt;sbruno@FreeBSD.org&gt;<br>
&gt; Signed-off-by: Mika=C3=ABl Urankar &lt;<a href=3D"mailto:mikael.uranka=
r@gmail.com" target=3D"_blank">mikael.urankar@gmail.com</a>&gt;<br>
&gt; Signed-off-by: Kyle Evans &lt;kevans@FreeBSD.org&gt;<br>
&gt; Signed-off-by: Guy Yur &lt;<a href=3D"mailto:guyyur@gmail.com" target=
=3D"_blank">guyyur@gmail.com</a>&gt;<br>
&gt; Signed-off-by: Alexander Kabaev &lt;kan@FreeBSD.org&gt;<br>
&gt; Signed-off-by: Michal Meloun &lt;mmel@FreeBSD.org&gt;<br>
&gt; Signed-off-by: Ed Schouten &lt;<a href=3D"mailto:ed@nuxi.nl" target=3D=
"_blank">ed@nuxi.nl</a>&gt;<br>
&gt; Signed-off-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com" targe=
t=3D"_blank">imp@bsdimp.com</a>&gt;<br>
<br>
Thanks, I used that set of emails to filter out commits <br>
<br>
Out of the remaining commits/files with other authors, most were a<br>
case of=C2=A0 trivial function renames, code deletion, or trivial syntax<br=
>
fixes to deal with external cleanups which can be exluded.<br>
<br>
The only files where I saw any non-trivial code from other contributors<br>
are<br>
<br>
bsd-user/bsd-mem.h: 8<br>
bsd-user/elfload.c: 36<br>
bsd-user/freebsd/os-misc.h: 1<br>
bsd-user/freebsd/os-proc.c: 3<br>
bsd-user/freebsd/os-proc.h: 3<br>
bsd-user/qemu.h: 58<br>
bsd-user/strace.c: 7<br>
<br>
There are way too many historic authors for elfload.c, qemu.h and<br>
strace.c to make it worth chasing those down, so I&#39;d suggest just<br>
dropping those three files from the commit.<br></blockquote><div><br></div>=
<div>I&#39;ll drop those. The qemu.h issue is more Blue Swirl shows in git =
blame,</div><div>and those files are more from linux-user, which git blame =
is useless to</div><div>chase down.</div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
For bsd-mem.h, and freebsd/os* Karim Taha &lt;<a href=3D"mailto:kariem.taha=
2.7@gmail.com" target=3D"_blank">kariem.taha2.7@gmail.com</a>&gt;<br>
is the only notable omission I saw. Up to you whether to check with<br>
them or just drop those files from the cleanup.<br></blockquote><div><br></=
div><div>Karim&#39;s case is interesting. He was a GSoC student that took t=
he work</div><div>from bsd-user blitz branch. In the blitz branch, the blam=
e shows style</div><div>changes and a few other tweaks from the upstreaming=
. He also contributed</div><div>some things that aren&#39;t in these files.=
 He shows up as more than that in</div><div>in qemu&#39;s upstream repo bec=
ause of the code copying. That&#39;s why I</div><div>hadn&#39;t contacted h=
im.</div><div><br></div><div>I&#39;ll chase those down and also see if I ca=
n make contact with him. I had</div><div>trouble reaching him after he ente=
red the military after GSoC finished, but</div><div>haven&#39;t tried in ye=
ars.</div><div><br></div><div>Warner</div></div></div>

--00000000000087a0c5064c5d8a48--

