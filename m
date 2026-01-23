Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E412D778BE
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 22:14:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjPQC-00004r-2r; Fri, 23 Jan 2026 17:14:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1vjPQA-0008UL-3A
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 17:14:26 -0500
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1vjPQ7-0004p9-Sb
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 17:14:25 -0500
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-c2dc870e194so1103211a12.2
 for <qemu-devel@nongnu.org>; Fri, 23 Jan 2026 14:14:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769206462; cv=none;
 d=google.com; s=arc-20240605;
 b=RDfoqrlHl2MkOAyuEedwo0B4cYX3gXCpFmlHB6vFArioynA8vTcv4wxTQ9REE2U4pa
 St5KzkP5VEGTgsdVjPsZicDH0oHMIYlwUXhjJEumfS0u/FPhRtcFuS6BaewDmaIiJ7mW
 flZSO4kr2aXIMDKSHDtA3kDQ3W4KBxtP4y7hsJWZoLkg5y54Z1HdvIAhVE5TxU6GgFSX
 brUXVQNXK3ug3h1ECTYEJkNfCuPQ65gyVjS6EbN8F69aBFG0Gmend32cMrWaLhFYDKqt
 BdhACYhyZ6Ib5tgysXDl9pHrIVwHDrP0WACdXXpvIyemiZw3yR6oBdQbw8730hETns2B
 5sNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=e5kK6DjeuPbPb39mHjNTWyM4Ri09t3afYqZ3XeyWtC4=;
 fh=OaZOujuEcsqfMPOoWJX+2txSTJrjsFD82KtWtzNLuAg=;
 b=Wiw/2KzBFP0wwLiy/x5AcPvhdVny0/gCjwjx8gUZrBMSb5LyFEJUHBTER++nTxY2fe
 psavXAYCzDcbKjP2QF24QrOJHrIKHuExHyFDXmRbPujZPnQpyI7FpsyqRhnCagchDaSJ
 E2XFgtqZSTqHgP42+xv/1jsIeuzpMvWMpxIjhyHHVnAoE7db06i62q1TVhQPXifjXjwB
 cc6Ap8r3A6rpUtrkaQlm0P7bQkA3N+kUuXHrSXZQwbyx5+gYjTprD75g862YP0cNqiwn
 LgiHDhED9aJ3AsuVLznQSK3PzPMQ27ksHMZwqw+Fk2HtRSLvUXH03apIargdrG0MJCtD
 Idvg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1769206462; x=1769811262;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=e5kK6DjeuPbPb39mHjNTWyM4Ri09t3afYqZ3XeyWtC4=;
 b=QcGDm779dWpUdAKd7RpgGEJATYoCuVZkArdwcOjBacjmIyFULjBvvS0WAHCzD7k+OH
 pSZlIC9UIx2lCKWvxUwso38bK39auWgtadiFRk12A+CDnZV8wt6Kppujbul0VnBS29i4
 cofwqay0Hk1OVNys0xwsXdsEa631+Nxy0QD0J8nYj5yNCH3pYnbC1KfLtOan2bhkBEEe
 DicKmftNaQ1xMICoV4Jb/JYDIgPEagrqR2+FsAY5vsGYbcjUqiHQ6GYMUSyNdRjHzbaY
 x+r00o68vehoyPVT7BNUW1DODWIYJdScF0EKDX7V5SUhoHq/5AfgWgN6hdV/ToC05R/L
 m2Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769206462; x=1769811262;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e5kK6DjeuPbPb39mHjNTWyM4Ri09t3afYqZ3XeyWtC4=;
 b=FIc5KrzAoge8PfwnTNxlprx01V6rA8gzfQj/OVdo0/r6OUvhR/3ttR8c3XE8x1eSBB
 e9UiWH8zcqN4z+2xRy9sK1hJjDyDjCBT5EdHvXlanlbtFNK7kBYy+1g6OKrFGMkAxM0l
 oVCWmmjgmIWwImwWOBr0AnfIs2NWzPutr2XCJdtzJTTLEwhUBEPs/1KF7UCujh05vDh7
 uk7uToRQjNVLP+NvTWle+vLHqi7iR7xYRCciwGn55F/c6a3KHRW5bbomYsCc6YJ4vPal
 i+9qj4gINevj337ShhqSUCKm2kWgm6b4dThG9cJvuCNxnglSIeptdm6igGJJQx4NNID0
 aVMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYFEHpKXEvFd0mXQOpVXE6DbjaEuca4DNrwtKr66B4NW7gkAOtuLd1N2DTr5zQUy7R6FHmeCsFbHsL@nongnu.org
X-Gm-Message-State: AOJu0YzBzKLx1cAF1mIZjSeB0/QpD4gaklU4A8nWlYGhBCDSve/J2c2x
 ZZz925oWcYq6svQ+AHW5fZqfcr3VfFGTMKaeIB8qYJCF8yh/M8IQFgvDIGKtMy0x/QWsA6UYs9g
 A4rv1uADH6SFMWZJEEWSCesCEqekuaqvAu/ccjXaz+w==
X-Gm-Gg: AZuq6aKtD91niyj6LHkpCBPXlIIxUNTWcQympKfBi96Ug6cYznSWzFIViXC8qIHn3VX
 BfGYADjyzyLwBziLxvR1S6az2X9DL3Km6AENp/+6nZ9jhrqDywQ4+JNN9odza9x5+bvSvus5MJE
 Wgf/Q9dFx574EAA13ItJdo6QUkzt2qo0wKENqyEe0tq+QNICxLe+dluGPQbeBpHPuJ/IouySRiP
 e+Zb2tvXpgQZ+dvOQgZQoBvC81aZzQzVPeI8doAw32XR3fS5YuFg1mKcLQkNNJrrZPGaig=
X-Received: by 2002:a17:90a:e7ce:b0:340:d511:e164 with SMTP id
 98e67ed59e1d1-3536894c447mr3656106a91.19.1769206462163; Fri, 23 Jan 2026
 14:14:22 -0800 (PST)
MIME-Version: 1.0
References: <20260123145750.1200879-1-alex.bennee@linaro.org>
 <20260123145750.1200879-9-alex.bennee@linaro.org>
 <CANCZdfo3yz=aC-EOxd2LYBX=tf=RQTY6ibCpj-fCfGHZtH6WTw@mail.gmail.com>
 <aXOok4KRTvgwx7GJ@redhat.com>
In-Reply-To: <aXOok4KRTvgwx7GJ@redhat.com>
From: Warner Losh <imp@bsdimp.com>
Date: Fri, 23 Jan 2026 15:14:10 -0700
X-Gm-Features: AZwV_QjsfTp_T3HFcZ1W-Nqadljd0UcwC3aWdYwHtp6soIVxfNLMXdFZQlf8IRw
Message-ID: <CANCZdfoXfeBh5For_Cag+191GkjDtsqBNZ4LU1g2DYepkYoaBw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 08/16] MAINTAINERS: be realistic about *-user
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Joe Perches <joe@perches.com>, John Snow <jsnow@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000b63a450649157acd"
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

--000000000000b63a450649157acd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 23, 2026 at 9:58=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com>
wrote:

> On Fri, Jan 23, 2026 at 08:12:33AM -0700, Warner Losh wrote:
> > On Fri, Jan 23, 2026 at 8:00=E2=80=AFAM Alex Benn=C3=A9e <alex.bennee@l=
inaro.org>
> wrote:
> >
> > > We should reflect the current status so users don't have unrealistic
> > > expectations of how quickly things can get reviewed and merged.
> > >
> > > Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> > >
> >
> > Reviewed-by: Warner Losh <imp@bsdimp.com>
>
> snip
>
> > A lot of the upstreaming work that's stalled would be ideal to tell
> claude
> > to do,
> > but I'm unsure the project's stance on using claude to move code, and g=
it
> > log
> > 5 different trees to get the original author(s) of the code and make
> > trivial compile
> > tweaks.
>
> The critical thing we don't want is such tools making changes to the
> contents of source files.
>
> Automating the moving around of files is a non-issue.
>
> The use of AI for writing commit messages is arguably in scope of QEMU's
> AI policy given that is part of "the contribution", but it is less seriou=
s
> there, since commit messages don't have a copyright implication on what w=
e
> host & distribute.
>
> More important is that the commit messages are accurate and well written.
> LLMs have a tendancy to be overly verbose about irrelevant stuff, and of
> course the well known danger of hallucinating nonsense. IME that makes it
> challenging to benefit from an LLM, due to review & re-writing overheads
> you then incurr to validate and fix their output.
>

Yea, the commit messages llm would generate is 'do function X' and I'd then
fill it in from there, changing everything except X.


> I'd be wary of relying on an AI to extract and report on authorship of
> code. Accuracy is important there since it implies copyright ownership
> associations. Likewise a Signed-off-by tag should be added by humans
> only since it is a statement they are complying with the DCO policy.
>

I'd be verifying everything done. Verification is relatively easy,
extraction is
the hard part. And the range of people it could be is tiny, so I'd know if
it
was making stuff up, or had gone off the rails...  And I'd have it add
something
like 'Supposed-author: ' that I'd change once I verified it. That's ugly
grunt work,
but ugly grunt work I can do in an hour or two rather than the dozens of
hours
it usually takes me to do the extraction...

Warner

--000000000000b63a450649157acd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jan 23,=
 2026 at 9:58=E2=80=AFAM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berr=
ange@redhat.com">berrange@redhat.com</a>&gt; wrote:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">On Fri, Jan 23, 2026 at 08:12:33AM -070=
0, Warner Losh wrote:<br>
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
ly takes me to do the extraction...</div><div><br></div><div>Warner=C2=A0</=
div></div></div>

--000000000000b63a450649157acd--

