Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D7B6F55102
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 16:41:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyuhW-0000pZ-AR; Sat, 07 Mar 2026 11:40:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1vyuhQ-0000oG-Du
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 11:40:21 -0500
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1vyuhN-0001HN-A9
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 11:40:19 -0500
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-3599019ae92so3677222a91.0
 for <qemu-devel@nongnu.org>; Sat, 07 Mar 2026 08:40:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772901614; cv=none;
 d=google.com; s=arc-20240605;
 b=Hm3KTAkRSpynje4BPNBAGRYy0l6pJpdK6DQZiTR7PUD3qqlN4PgyDJnDBSyx2QLUXb
 mooPjQeXb5xuQXv6JXtwqWnfkP2XpuI7Y8hsTawQKfg7AA8gPukQpl/llrfb+T+3ffyg
 IJ58qQIHkLVY02xHdWrRR5s1++WF8ev+3hV4POLL+eOQ4iJR4kKWx9nX3x85z+7oXXnd
 cm5U5slyiD7SF2pSoceWXsipvwxSOy+QEU6LjHa44zpZ5ibZy1163KoWPbchHgftE88V
 hc9gMp3SjxiPUCIfBm15DH6scF8Fb1OqMPqwCtnJkG6NNb2cIYkaEzO0E4rajFP3TU5u
 UAyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=meslNmp+n0fRo0zTI5W8zqnlA4dRQyXdOewvqu3bMbA=;
 fh=3qUuBNeQGLGc8SJQr+mdaV1sqgu10HJzCBUR3PXbE/8=;
 b=fqKUkhM1y09K4GSWLu4yiYUcuC/L3mChqMYlInaEvlVq0vSMazZlaivB/7vFrv5lNO
 9u9N0wwzI5ZceeDFgVz3c1CJHjXi+5HKN7tnRgNFvEHacSrpHDKpJgUVBW3WkcHZbXbH
 BGRTOneMJWb6jsD9mq1+Xlv0ZLR6I/GgMFYa5O/eKrp4l7Rc+X1BbZFpWhk25rCTrNUk
 OPAMErDchbsTvJ/eADKjqWIABbVUbQO01S72h/vm8Cno1qQi+GS2CNB6hnhoV/uJxijm
 D8MTHUIywjRGypuvtOf4PtgorsQZ3FBXvsMgfcONs/sHyeTUJha7I/8C9DP+5Iu91U3y
 wINQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1772901614; x=1773506414;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=meslNmp+n0fRo0zTI5W8zqnlA4dRQyXdOewvqu3bMbA=;
 b=ZaJ7M2fbBRU0LkNbj7LPfAy4KUpceaTsyBM1BRZe6S69MIUvwuLJZCZgX1k8heU5zy
 wg2LLKKAnt8DAyJUiZKtOiLs1yNM08DFMwVWD/SsCguXbG0A7cOWKh/ev79Lox661sbQ
 vhROhqUFnqCJhhtXoagPFQmIh8n6JgtmStM7HQJISP1utYWaYd6zXkqiJ+/AN+RTfiBo
 pzHom1rCPjQfv15VW/Sa4fE74gw6XUJmVTn+GajvCCfR474w33UBS3+D1W3CnPCT0S/r
 xCQQGjUHFt8jVbCuwXOj2myprBsFEaQuOlChEawCGGqdez+mmNbJBsFSGJLChXPRwLjs
 3ivw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772901614; x=1773506414;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=meslNmp+n0fRo0zTI5W8zqnlA4dRQyXdOewvqu3bMbA=;
 b=Rm26ztAknesgvfOlofnNgSq1gYhQ9VC8qusmXnQe9NLsg0mbw1qsNtd/VDgS1qoE32
 Cgf3Cbea+sCY+dD3H7QGZP51fPo/JMQPfb9JhpVlH0UtiBsS4ODvKmW0XLrAU26qwn3k
 LtiSk043p07mYnVmaDeORSy+lrUc8Z890b2pPmNgEBA0+X8I5QgQ1mayX6kodXFybg0I
 78OVvELHeR5ow6loyTW7uKunjqIr/wth9dMJvv3Vz2vteewN/xxc5SzT0n1IhweyNZVb
 HSdHGmkA66TwjNm04WtgxAN3pVungZDFZtu4kZ7kz3WnWxW2ovve2oixw1gmiWWAe8q5
 bXjw==
X-Gm-Message-State: AOJu0Ywmgil2iJNHxFh44Xq7FAOyIAkGbW41SoEq6OdcDqRJXJwcijc6
 YJKSrrl+hSJgv+2nwp8ezIn/hIijbphMlDEhWXXc6g4s/lFeOsm09MdtOHSJzG8Hw4nqqw6pSYK
 5m023+HSj0jqtfQyoDytA2y1f1eWxULrwWlmbqb4onfrWdDndh7+2
X-Gm-Gg: ATEYQzyipWWzdLlAA7c0nCkq9Q8NvLFEfLiSq2pK3UxKInPIKRoAwqwXPy3JOTpBZgc
 fT/FnzGejzUSaJCsWlZcTLraWDdDJhbjpiRhBzWEq0Ic4sV1XV7zcP8v4+gjf5dEBTe7GxBlB+b
 lXH+m9Ga48joP9XMqtunqSSipyvVJYl/hw3ixLorUCeC2m+QzmTOnDMxG7+E09KoVdAXGQtYgaj
 yUWYirOKNNJUrraZrY8lBzJzNoyEoMeiAb6X1ugqIZmTuxLHGBwStAy1FYoW8b9Gum7MRNg2GpB
 BQYHOIA=
X-Received: by 2002:a17:90a:d404:b0:341:134:a962 with SMTP id
 98e67ed59e1d1-359be31e147mr5174121a91.28.1772901614116; Sat, 07 Mar 2026
 08:40:14 -0800 (PST)
MIME-Version: 1.0
References: <20260304-bsd-user-copyright-v2-1-173525ffa614@bsdimp.com>
 <aarg1MVnbcnxLMEL@redhat.com>
 <CANCZdfrs5JgsSCoRnNvsN5uQH3KbO8n+8gm7s5WyKJHzR1Wu4Q@mail.gmail.com>
In-Reply-To: <CANCZdfrs5JgsSCoRnNvsN5uQH3KbO8n+8gm7s5WyKJHzR1Wu4Q@mail.gmail.com>
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 7 Mar 2026 09:40:02 -0700
X-Gm-Features: AaiRm53saFjQtbykqXLlLTabQUbjtYZyvMqplsjrSAh5oLXKVdnc0RPPXH247HI
Message-ID: <CANCZdfrSxWbKwEZmD3EEZtu+pNCYMChJNzfhCX921nwmyUbN2A@mail.gmail.com>
Subject: Re: [PATCH v2] bsd-user: Switch to SPDX-License-Expression
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Kyle Evans <kevans@freebsd.org>, 
 Stacey Son <sson@freebsd.org>, Sean Bruno <sbruno@freebsd.org>, 
 =?UTF-8?Q?Mika=C3=ABl_Urankar?= <mikael.urankar@gmail.com>, 
 Guy Yur <guyyur@gmail.com>, Alexander Kabaev <kan@freebsd.org>,
 Michal Meloun <mmel@freebsd.org>, Ed Schouten <ed@nuxi.nl>
Content-Type: multipart/alternative; boundary="000000000000ee6cfd064c71d277"
Received-SPF: none client-ip=2607:f8b0:4864:20::1031;
 envelope-from=wlosh@bsdimp.com; helo=mail-pj1-x1031.google.com
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

--000000000000ee6cfd064c71d277
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 6, 2026 at 9:28=E2=80=AFAM Warner Losh <imp@bsdimp.com> wrote:

>
>
> On Fri, Mar 6, 2026 at 7:12=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@=
redhat.com>
> wrote:
>
>> On Wed, Mar 04, 2026 at 09:05:33AM -0700, Warner Losh wrote:
>> > Two minor changes to the copyright and license marking for these files=
:
>> > (1) Stacey D Son is used instead of variations of his name.
>> > (2) The GPL boilerplate is replaced by SPDX markings. No change to the
>> > terms of the license are intended, and this matches current QEMU
>> practice.
>> >
>> > There's no changes to the license or additional claims to any IP that
>> > others may hold in these files. All the S-o-bs in this commit have giv=
en
>> > me permission to do this to the extent they may hold rights. git blame
>> > over multiple repos and branches suggests that only minimal other
>> > material is present (much of it likely not subject to copyright
>> > protection). The project's long and complex history as well as tooling
>> > limitations make it hard to be 100% sure. Any omissions are
>> > unintentional and I will correct them as they come to light.
>> >
>> > Signed-off-by: Stacey Son <sson@FreeBSD.org>
>> > Signed-off-by: Sean Bruno <sbruno@FreeBSD.org>
>> > Signed-off-by: Mika=C3=ABl Urankar <mikael.urankar@gmail.com>
>> > Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
>> > Signed-off-by: Guy Yur <guyyur@gmail.com>
>> > Signed-off-by: Alexander Kabaev <kan@FreeBSD.org>
>> > Signed-off-by: Michal Meloun <mmel@FreeBSD.org>
>> > Signed-off-by: Ed Schouten <ed@nuxi.nl>
>> > Signed-off-by: Warner Losh <imp@bsdimp.com>
>>
>> Thanks, I used that set of emails to filter out commits
>>
>> Out of the remaining commits/files with other authors, most were a
>> case of  trivial function renames, code deletion, or trivial syntax
>> fixes to deal with external cleanups which can be exluded.
>>
>> The only files where I saw any non-trivial code from other contributors
>> are
>>
>> bsd-user/bsd-mem.h: 8
>> bsd-user/elfload.c: 36
>> bsd-user/freebsd/os-misc.h: 1
>> bsd-user/freebsd/os-proc.c: 3
>> bsd-user/freebsd/os-proc.h: 3
>> bsd-user/qemu.h: 58
>> bsd-user/strace.c: 7
>>
>> There are way too many historic authors for elfload.c, qemu.h and
>> strace.c to make it worth chasing those down, so I'd suggest just
>> dropping those three files from the commit.
>>
>
> I'll drop those. The qemu.h issue is more Blue Swirl shows in git blame,
> and those files are more from linux-user, which git blame is useless to
> chase down.
>
>
>> For bsd-mem.h, and freebsd/os* Karim Taha <kariem.taha2.7@gmail.com>
>> is the only notable omission I saw. Up to you whether to check with
>> them or just drop those files from the cleanup.
>>
>
> Karim's case is interesting. He was a GSoC student that took the work
> from bsd-user blitz branch. In the blitz branch, the blame shows style
> changes and a few other tweaks from the upstreaming. He also contributed
> some things that aren't in these files. He shows up as more than that in
> in qemu's upstream repo because of the code copying. That's why I
> hadn't contacted him.
>
> I'll chase those down and also see if I can make contact with him. I had
> trouble reaching him after he entered the military after GSoC finished, b=
ut
> haven't tried in years.
>

Ah! He's back online and has given me permission. I'll update with what we
discussed.

Warner

--000000000000ee6cfd064c71d277
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Mar 6, =
2026 at 9:28=E2=80=AFAM Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com">i=
mp@bsdimp.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex"><div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"=
gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Mar 6, 2026 at 7=
:12=E2=80=AFAM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redha=
t.com" target=3D"_blank">berrange@redhat.com</a>&gt; wrote:<br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">On Wed, Mar 04, 2026 at 09:05:3=
3AM -0700, Warner Losh wrote:<br>
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
ars.</div></div></div></blockquote><div><br></div><div>Ah! He&#39;s back on=
line and has given me permission. I&#39;ll update with what we discussed.</=
div><div><br></div><div>Warner=C2=A0</div></div></div>

--000000000000ee6cfd064c71d277--

