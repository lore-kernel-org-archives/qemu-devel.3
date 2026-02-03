Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13D58E7FDF3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 00:50:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn4cD-0004BJ-EH; Mon, 02 Feb 2026 19:50:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1vn4cC-0004AL-CA
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 19:50:00 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1vn4c9-0008SY-Hh
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 19:50:00 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-823f9f81da5so655103b3a.1
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 16:49:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770079796; cv=none;
 d=google.com; s=arc-20240605;
 b=ffeJDaME8/6Za5+nHVDcCGjqNJltmggldRttot+8EKHoJmAWgX0jUBQ0zJ83liPx8v
 DIwomLYUsjH/2m8YHRPRdabkm+vbAy9ZNXkuVTMyC0X9d2GOLa8oVc83eTDR1Hd5/3fW
 WZ0zotLqdty98ZPM6gPyYlH34XazHs2USzkIv0Y1EMlaMRjkY/g0/RJkrXn472pglnlK
 +SHTo6X2czW0PCw/tzr88tdnIYadbCuFPZyoY87qJrv2Y6QRGxr5+06scd/VC4nCd4bH
 MzJxZmZLfUr+zvg97MiF6bM2XstvhRmWktJwgi19WG0CRBzd1xTGkoFQOIdHPhUpcN32
 TfhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=2leWZ29RZDKZ1Gecofft/S0HF9TuCW8Ox1MuTCE3s+0=;
 fh=OWbyEKLOhGzawzxcEswLE8TYHYrtQBk15PBDYK93Np8=;
 b=hqLzJuF0WGf+6nfRVogBUobor72gtRQIxKAl5aECs3HJKim8iCDwk6pM2xp6gl2dR4
 /xzcUgJatiFG8ahwUth2pKWl6YAY1nIHBN+UNfxL/1Guo2exfJBZfAm4YwubQmHo0DAv
 tgQ0RYH1oZa4Fupv2m7fcVCuilgLlc5+bs3MWyayqhAhRyBCrEJpx3kGxRMyO9Ap9Z+1
 LbtlyDTVlYKvxhplWiiBELlNKLMpXJnNYG6El7veA7CnXyq7lkwaAyEccgvNgiiS0qQf
 2VEJnx1F5urjSdCD4e93A2jSiSYUMIEU+RFN1WThXaUDrLkh1lUP6TSdh+Us2Wc7jW6l
 uShA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1770079796; x=1770684596;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2leWZ29RZDKZ1Gecofft/S0HF9TuCW8Ox1MuTCE3s+0=;
 b=RN51kuEqls0LQPTJ78sNz9Vg0pKQPWRbJgtiEAZhSf9BW44JR51jc1h5a8/0UIpwpv
 LO4+OZm7yzgO6ryPXZup3bUmkox12rZfOghxOpuznyTghxinEOyR1ZaHKL4XYlU+HEoQ
 XS5X8J7P1GA557id9hU7rr+gRC/aKPg4PN3VdqIQ3QTeOQwJvbn4n4JTVLptbqg6dVxt
 YfFhRmPdmaTObARevHCGOnD/4AXQ2UEF91sytOh2n3OMAUdjWCWjG5IshJNEAFepu7uY
 AYvaRgmytDsO1FZG8QWReCEnlXQZ72+hfNlwLwVe+OweEiBWjVmwZD+jksiWaL6G4C5X
 HrOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770079796; x=1770684596;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2leWZ29RZDKZ1Gecofft/S0HF9TuCW8Ox1MuTCE3s+0=;
 b=mbJfIVKXd4d5mUEDWFKVHDEQYRUCravcyLbDkl1aOvyEXdGVAQ2exzaI3q2vXLRIlZ
 5F//r9WOl03fi9eEfZh4ULMdBcgR80Q0Gra/a8LJ5zjOjA0Jb2tk0BbD+D1WLxWGjo9a
 zbOexIN/nkIHRO5JZM777qejJ+ADD0sppQpRoWNBiHH5zxWRT9cPBsAhcHkOUYqakT4H
 qUF/fuThP3zPSNyLfpYONCVUNSluAcQ1xy0jF76Y3s2e9Ie2T8mDMhWXJnc/hrc2m4H3
 RwCX/UlCbpbE0+gat7ql443PfDcyRmK7n7Ym02iuv/3hwdHJlKOz+IUeGZed83G9ZoGn
 g/vA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0kgV9xwvd6HJPIi3ZPQ8mAt3rnWbMlgZIbJajHPOLtapdgXWbhUrpZwQAVjpcDe14cV+4ExijogAg@nongnu.org
X-Gm-Message-State: AOJu0YwxkaDxvcrWg3kxF/ulv1k/IuWkpLMk9ulm5tYy8MTiEk2mz5pW
 9/kM8VReAjVygTz7zIb7sJkvnbmaLnpE1yw09dENPa6B0WW9fatoR94GthD14ZVRuNKlnZ8b9rd
 ygUNEdvSQm7fjXng7gZDAaKm2liqWLZISTR5eA+ngQtDOu+5AR1o2RFQ=
X-Gm-Gg: AZuq6aKwy6FnQJuvV2naL16JNCTaj0RtHwZCVErLyFhqwKEmiknSevEsU1aPWfqWY6U
 8pxhXj3P2Z3SJ1UV6/+YYaO31rT9lD9XJhMp7nrcSJcoO/BnIyIaKcPhyzvYQ3wFNhr3C3Af/jv
 8a8GOgbyReUd6clbNY++RvTT/31tjkCKZMPSv4qbbcxg0UdN2liWKrMMpbNCSXMH6PJft2PMuMx
 07abbpC1SVOJja1bm6lTZ2+zWEuiz5icKA7B9PkvIOvw9bd6B3KTlS8nFwFyUuWzMQPKaA=
X-Received: by 2002:a17:90b:3b46:b0:34a:b8e0:dd64 with SMTP id
 98e67ed59e1d1-3543b31393cmr12000521a91.1.1770079795703; Mon, 02 Feb 2026
 16:49:55 -0800 (PST)
MIME-Version: 1.0
References: <20260123145750.1200879-1-alex.bennee@linaro.org>
 <20260123145750.1200879-9-alex.bennee@linaro.org>
 <CANCZdfo3yz=aC-EOxd2LYBX=tf=RQTY6ibCpj-fCfGHZtH6WTw@mail.gmail.com>
 <aXOok4KRTvgwx7GJ@redhat.com>
 <CANCZdfoXfeBh5For_Cag+191GkjDtsqBNZ4LU1g2DYepkYoaBw@mail.gmail.com>
 <CANCZdfqBKMt5qxfrEhudTbrkMzKRzVATuTWXnRnPttVj6UZ5HA@mail.gmail.com>
In-Reply-To: <CANCZdfqBKMt5qxfrEhudTbrkMzKRzVATuTWXnRnPttVj6UZ5HA@mail.gmail.com>
From: Warner Losh <imp@bsdimp.com>
Date: Mon, 2 Feb 2026 17:49:44 -0700
X-Gm-Features: AZwV_QiyGuxvUBXc4S6eJNRSx4N1IPnFg_Ej5bOAmoTI-uPBUTtJ4ndkI0_LRt8
Message-ID: <CANCZdfrZnHWN62WZGAzyNo2JsnK0=LwExqQfYD6K_hRUE7dzMA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 08/16] MAINTAINERS: be realistic about *-user
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Joe Perches <joe@perches.com>, John Snow <jsnow@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000727cc40649e0d159"
Received-SPF: none client-ip=2607:f8b0:4864:20::435;
 envelope-from=wlosh@bsdimp.com; helo=mail-pf1-x435.google.com
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

--000000000000727cc40649e0d159
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 2, 2026 at 2:57=E2=80=AFPM Warner Losh <imp@bsdimp.com> wrote:

> Just to follow up....
>
> On Fri, Jan 23, 2026 at 3:14=E2=80=AFPM Warner Losh <imp@bsdimp.com> wrot=
e:
>
>>
>>
>> On Fri, Jan 23, 2026 at 9:58=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrang=
e@redhat.com>
>> wrote:
>>
>>> On Fri, Jan 23, 2026 at 08:12:33AM -0700, Warner Losh wrote:
>>> > On Fri, Jan 23, 2026 at 8:00=E2=80=AFAM Alex Benn=C3=A9e <alex.bennee=
@linaro.org>
>>> wrote:
>>> >
>>> > > We should reflect the current status so users don't have unrealisti=
c
>>> > > expectations of how quickly things can get reviewed and merged.
>>> > >
>>> > > Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>> > >
>>> >
>>> > Reviewed-by: Warner Losh <imp@bsdimp.com>
>>>
>>> snip
>>>
>>> > A lot of the upstreaming work that's stalled would be ideal to tell
>>> claude
>>> > to do,
>>> > but I'm unsure the project's stance on using claude to move code, and
>>> git
>>> > log
>>> > 5 different trees to get the original author(s) of the code and make
>>> > trivial compile
>>> > tweaks.
>>>
>>> The critical thing we don't want is such tools making changes to the
>>> contents of source files.
>>>
>>> Automating the moving around of files is a non-issue.
>>>
>>> The use of AI for writing commit messages is arguably in scope of QEMU'=
s
>>> AI policy given that is part of "the contribution", but it is less
>>> serious
>>> there, since commit messages don't have a copyright implication on what
>>> we
>>> host & distribute.
>>>
>>> More important is that the commit messages are accurate and well writte=
n.
>>> LLMs have a tendancy to be overly verbose about irrelevant stuff, and o=
f
>>> course the well known danger of hallucinating nonsense. IME that makes =
it
>>> challenging to benefit from an LLM, due to review & re-writing overhead=
s
>>> you then incurr to validate and fix their output.
>>>
>>
>> Yea, the commit messages llm would generate is 'do function X' and I'd
>> then
>> fill it in from there, changing everything except X.
>>
>>
>>> I'd be wary of relying on an AI to extract and report on authorship of
>>> code. Accuracy is important there since it implies copyright ownership
>>> associations. Likewise a Signed-off-by tag should be added by humans
>>> only since it is a statement they are complying with the DCO policy.
>>>
>>
>> I'd be verifying everything done. Verification is relatively easy,
>> extraction is
>> the hard part. And the range of people it could be is tiny, so I'd know
>> if it
>> was making stuff up, or had gone off the rails...  And I'd have it add
>> something
>> like 'Supposed-author: ' that I'd change once I verified it. That's ugly
>> grunt work,
>> but ugly grunt work I can do in an hour or two rather than the dozens of
>> hours
>> it usually takes me to do the extraction...
>>
>
> So, claude looks likeit's doing a passing fair job at this work. I plan o=
n
> submitting
> a patch series for one of the minor files in the coming weeks (depending =
on
> how much time I can find to work on it). Any guidance you can give me up
> front?
>
> Before I submit, I plan on auditing every single change to make sure clau=
de
> didn't introduce anything that's not in bsd-user's blitz branch. Make sur=
e
> the authors
> are correct to the same level that I've been doing so far. And make sure
> I've rewritten
> all the commit messages.
>
> One question I have, should include these lines
>     =F0=9F=A4=96 Generated with [Claude Code](https://claude.com/claude-c=
ode)
>     Co-Authored-By: Claude <noreply@anthropic.com>
> it is adding to the commit messages or not? Claude generated this as a
> series of
> commits from the blitz branch to the master branch, but didn't actually
> generate
> any new code or fix any bugs. I'm happy to include them if you want, but
> also
> am weary about setting of a knee-jerk reaction that would be unhelpful
> since
> it's responding to the 'slop' worries and not the merits of the current
> work.
>
> Comments?
>

To not clutter up the mailing list, here's the changes. They are identical
to what's in the qemu-bsd-user blitz branch. I've not curated the commit
messages yet (they are what claude produced, but there's no copyright
issues with commit messages), but plan on doing so since glancing over them
right now I do see a few minor issues that need to be tweaked.

https://github.com/bsdimp/qemu/tree/bsd-user-claude

git diff master..bsd-user-claude --stat
 bsd-user/bsd-misc.c           | 222
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++++++++++++++++++
 bsd-user/bsd-misc.h           | 386
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |  57 ++++++++++++++++++++++++++
 bsd-user/meson.build          |   1 +
 bsd-user/qemu-bsd.h           |  15 +++++++
 bsd-user/syscall_defs.h       |  67 +++++++++++++++++++++++++++++++
 common-user/safe-syscall.S    |   2 +-
 meson.build                   |  20 ++++-----
 8 files changed, 759 insertions(+), 11 deletions(-)

The last two are cherry-picks of something I wrote myself. The meson.build
is because inotify is now in libc, and I don't know how to express it. so I
figured if I did it wrong, somebody would help :).

Thanks in advance for any feedback you can provide.

Warner

--000000000000727cc40649e0d159
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Feb 2, =
2026 at 2:57=E2=80=AFPM Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com">i=
mp@bsdimp.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex"><div dir=3D"ltr"><div dir=3D"ltr">Just to follow up....</div><=
br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri,=
 Jan 23, 2026 at 3:14=E2=80=AFPM Warner Losh &lt;<a href=3D"mailto:imp@bsdi=
mp.com" target=3D"_blank">imp@bsdimp.com</a>&gt; wrote:<br></div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div dir=3D"ltr"><=
br></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_att=
r">On Fri, Jan 23, 2026 at 9:58=E2=80=AFAM Daniel P. Berrang=C3=A9 &lt;<a h=
ref=3D"mailto:berrange@redhat.com" target=3D"_blank">berrange@redhat.com</a=
>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On =
Fri, Jan 23, 2026 at 08:12:33AM -0700, Warner Losh wrote:<br>
&gt; On Fri, Jan 23, 2026 at 8:00=E2=80=AFAM Alex Benn=C3=A9e &lt;<a href=
=3D"mailto:alex.bennee@linaro.org" target=3D"_blank">alex.bennee@linaro.org=
</a>&gt; wrote:<br>
&gt; <br>
&gt; &gt; We should reflect the current status so users don&#39;t have unre=
alistic<br>
&gt; &gt; expectations of how quickly things can get reviewed and merged.<b=
r>
&gt; &gt;<br>
&gt; &gt; Signed-off-by: Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee=
@linaro.org" target=3D"_blank">alex.bennee@linaro.org</a>&gt;<br>
&gt; &gt;<br>
&gt; <br>
&gt; Reviewed-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com" target=
=3D"_blank">imp@bsdimp.com</a>&gt;<br>
<br>
snip<br>
<br>
&gt; A lot of the upstreaming work that&#39;s stalled would be ideal to tel=
l claude<br>
&gt; to do,<br>
&gt; but I&#39;m unsure the project&#39;s stance on using claude to move co=
de, and git<br>
&gt; log<br>
&gt; 5 different trees to get the original author(s) of the code and make<b=
r>
&gt; trivial compile<br>
&gt; tweaks.<br>
<br>
The critical thing we don&#39;t want is such tools making changes to the<br=
>
contents of source files.<br>
<br>
Automating the moving around of files is a non-issue.<br>
<br>
The use of AI for writing commit messages is arguably in scope of QEMU&#39;=
s<br>
AI policy given that is part of &quot;the contribution&quot;, but it is les=
s serious<br>
there, since commit messages don&#39;t have a copyright implication on what=
 we<br>
host &amp; distribute.<br>
<br>
More important is that the commit messages are accurate and well written.<b=
r>
LLMs have a tendancy to be overly verbose about irrelevant stuff, and of<br=
>
course the well known danger of hallucinating nonsense. IME that makes it<b=
r>
challenging to benefit from an LLM, due to review &amp; re-writing overhead=
s<br>
you then incurr to validate and fix their output.<br></blockquote><div><br>=
</div><div>Yea, the commit messages llm would generate is &#39;do function =
X&#39; and I&#39;d then</div><div>fill it in from there, changing everythin=
g except X.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
I&#39;d be wary of relying on an AI to extract and report on authorship of<=
br>
code. Accuracy is important there since it implies copyright ownership<br>
associations. Likewise a Signed-off-by tag should be added by humans<br>
only since it is a statement they are complying with the DCO policy.<br></b=
lockquote><div><br></div><div>I&#39;d be verifying everything done. Verific=
ation is relatively easy, extraction is</div><div>the hard part. And the ra=
nge of people it could be is tiny, so I&#39;d know if it</div><div>was maki=
ng stuff up, or had gone off the rails...=C2=A0 And I&#39;d have it add som=
ething</div><div>like &#39;Supposed-author: &#39; that I&#39;d change once =
I verified it. That&#39;s ugly grunt work,</div><div>but ugly grunt work I =
can do in an hour or two rather than the dozens of hours</div><div>it usual=
ly takes me to do the extraction...</div></div></div></blockquote><div><br>=
</div><div>So, claude looks likeit&#39;s doing a passing fair job at this w=
ork. I plan on submitting</div><div>a patch series for one of the minor fil=
es in the coming weeks (depending on</div><div>how much time I can find to =
work on it). Any guidance you can give me up front?</div><div><br></div><di=
v>Before I submit, I plan on auditing every single change to make sure clau=
de</div><div>didn&#39;t introduce anything that&#39;s not in bsd-user&#39;s=
 blitz branch. Make sure the authors</div><div>are correct to the same leve=
l that I&#39;ve been doing so far. And make sure I&#39;ve rewritten</div><d=
iv>all the commit messages.</div><div><br></div><div>One question I have, s=
hould include these lines<br>=C2=A0 =C2=A0 =F0=9F=A4=96 Generated with [Cla=
ude Code](<a href=3D"https://claude.com/claude-code" target=3D"_blank">http=
s://claude.com/claude-code</a>)<br>=C2=A0 =C2=A0 Co-Authored-By: Claude &lt=
;<a href=3D"mailto:noreply@anthropic.com" target=3D"_blank">noreply@anthrop=
ic.com</a>&gt;<br></div><div>it is adding to the commit messages or not? Cl=
aude generated this as a series of</div><div>commits from the blitz branch =
to the master branch, but didn&#39;t actually generate</div><div>any new co=
de or fix any bugs. I&#39;m happy to include them if you want, but also</di=
v><div>am weary about setting of a knee-jerk reaction that would be unhelpf=
ul since</div><div>it&#39;s responding to the &#39;slop&#39; worries and no=
t the merits of the current work.</div><div><br></div><div>Comments?</div><=
/div></div></blockquote><div><br></div><div>To not clutter up the mailing l=
ist, here&#39;s the changes. They are identical to what&#39;s in the qemu-b=
sd-user blitz branch. I&#39;ve not curated the commit messages yet (they ar=
e what claude produced, but there&#39;s no copyright issues with commit mes=
sages), but plan on doing so since glancing over them right now I do see a =
few minor issues that need to be tweaked.</div><div><br></div><div><a href=
=3D"https://github.com/bsdimp/qemu/tree/bsd-user-claude">https://github.com=
/bsdimp/qemu/tree/bsd-user-claude</a></div><div><br></div><div>git diff mas=
ter..bsd-user-claude --stat<br>=C2=A0bsd-user/bsd-misc.c =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 | 222 +++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++<br>=C2=A0bsd-user/bsd-mis=
c.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 386 ++++++++++++++++++++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++<br>=
=C2=A0bsd-user/freebsd/os-syscall.c | =C2=A057 ++++++++++++++++++++++++++<b=
r>=C2=A0bsd-user/meson.build =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 1 +=
<br>=C2=A0bsd-user/qemu-bsd.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A015=
 +++++++<br>=C2=A0bsd-user/syscall_defs.h =C2=A0 =C2=A0 =C2=A0 | =C2=A067 +=
++++++++++++++++++++++++++++++<br>=C2=A0common-user/safe-syscall.S =C2=A0 =
=C2=A0| =C2=A0 2 +-<br>=C2=A0meson.build =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A020 ++++-----<br>=C2=A08 files changed,=
 759 insertions(+), 11 deletions(-)</div><div><br></div><div>The last two a=
re cherry-picks of something I wrote myself. The meson.build is because ino=
tify is now in libc, and I don&#39;t know how to express it. so I figured i=
f I did it wrong, somebody would help :).</div><div><br></div><div>Thanks i=
n advance for any feedback you can provide.</div><div><br></div><div>Warner=
=C2=A0</div></div></div>

--000000000000727cc40649e0d159--

