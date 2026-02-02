Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D71DE7FDF0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 22:03:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn1w0-0002Dq-V1; Mon, 02 Feb 2026 16:58:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1vn1vz-0002DP-7b
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 16:58:15 -0500
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1vn1vw-0000Yf-PD
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 16:58:14 -0500
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-3530715386cso3554645a91.2
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 13:58:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770069489; cv=none;
 d=google.com; s=arc-20240605;
 b=K+nrN2qzPWUTlpEBN+O/Q6BGDSXHtsExRseV9pIKAllHVq+X03Il5qiKxJFH6GwQVi
 gvo2jZE4xtbNUh4GkZwudhxutpK5X5bdXWNhqhuoAgMnc8D5Lx51itcStv/xliKpF9Wj
 ze5r3tyIHEz8S9tFUB/98MnnGukBN7ERVxJNxOMCR+AD3x2WOL8UmRTpt8EAtTqtc7DT
 qw+ufbv+fATaWJbsFN0ViZd5EHPdScr76P5Q3APUhWuNh0ohF8008M59DKTDQwv0YIG9
 Czy/P0Iw2VFQTxS76tuto7+Yk2MgjxMZjxuAjHF8Ji9rytpOXNu18WHNhdqvkOPODj/B
 oU0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=jax2ikWOvLX5emBWcODUTM6/17NzqTdmhD3KY93G/jc=;
 fh=V895JFIOPN+GQ3DMZfuojE9L3pOtA2qWwEemx+T4W5g=;
 b=Da2uzRHDctN+S70b/UUcfw+pCcx0lgN4381/+tZC83jptS/oDM3zcY41RJQYyfG+cc
 wFZUAClbrhkgQCVTguRdiNJJFl0bWbFn6rbSG9FP4TiYx4GghKpsE70iqIMYcisdvfLX
 311Gh7rCVTKDkTxhSdX9zmmhAsGZT4bcIMuOOdCUg/zIdhDvSEgW6KEVS0VXEnBlVEwh
 +7VS2vRoNCpwfmg0/9qk3vtO5FsEKqZHTWLfKliO84QKIUewuLqr/P/O/gWdyJ94U6dM
 Mb2/mmkc55DI4cmXZJKcxFmzJnj2SpN5S+c7cg66gxrOArTFSJWChG3+iDDy5lFGEWB/
 1Z0Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1770069489; x=1770674289;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jax2ikWOvLX5emBWcODUTM6/17NzqTdmhD3KY93G/jc=;
 b=K7XNnJH2CaYsHPDnxn0KdS0izmuQerSQMhIoPtzElgblYUVulqiswQHcwufpOogb8p
 jbfiopLA7w26UX6KxKf4te3THOVvHAMB79mLD3oZ+e/RsNWjgvZIktKFaAXALbBRJRYo
 ok+I3CYJYoYLW1m0i1lOyV+XMnojEcnhOLbLYJvQ3B38/qu7AWtJmX6Kend24cODCEf+
 BOlGEKo9KKUcN9fqBjmPJT6pIUvu3415Q+5gF6omtIT3a4+oOd8tNSq0nCbb084SPh4e
 a2msRaGsrVEHn9NmyTP391vOBZA2tR96Ji+3+uVQr0O2oWGWuTlaHBL/SHDVs9Gh9NqL
 U/WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770069489; x=1770674289;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jax2ikWOvLX5emBWcODUTM6/17NzqTdmhD3KY93G/jc=;
 b=k4bgVP3pJ5INLyYjqONhz8Eh/rFy69W6VTc81UEG/9TGljKR7HymauIU7rUlmHjW5C
 jdDV6CN8dwdPvH/NqbuJ7QclYDq4H4TJzlnTZXV6PSxctM06zQcMCscGF2YqBWMQX15S
 Scu6HvnF7H+0gVeUbPG1s4ez/nUMP324CIUgmrW4Zq0rfSPSfJW1Qz0WrAJ7ddOYeSTl
 z7g6/yLm5jPVb6xSE/3yA+AFu2DoROxkeceFshAjfpJHYMRUuKjQXPMt4iQALpnWkQad
 PdBxTerqkhfotJ8p8k7R7WlnY0jkHKKcRuKC2Wh1uR6IemKMod8udC+dct0/dr9Dw4ke
 Le8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXn41/l+PNN1WiFywKRWPEcd6nQwtMTIiZLgPTT4TuvEAzw/12GELMWcNwlVf5fu5pGBqtYl1iw0FQl@nongnu.org
X-Gm-Message-State: AOJu0YwNmbTA6a3KjiZEPlqKfh+T70sOUw+/Lswk8axY2Xup1X47jCB5
 yov6WvmAYMQSZu9DBcJxZtuDKI8o9IwzZMKFVMR2qj9+WMRYMyUWdCI1pw0zxqthek0Zmm8paYU
 6biVnKxqB+qHPmZptzJEjRmF48b333464YeIFoWEAMA==
X-Gm-Gg: AZuq6aIFz0VM9zazIqInAYLHaX9+tDyeUXfyP/AtDQlkOwIeQqnZaQVj6ZnJrCWlXjk
 VEn/vtHlVDImyC+i37558AELquzCthQtfFzL6fl/6TslU4PkYbPQl+8RDyP83AK7nVqqQUSibQW
 8EYGeWw/rE48PzdgQ3xpbZz+XscenoCCklTTb4GduS8pm1PWkn2b7/P3V17WfN+qbIvHDTsaddd
 w88WWvhS5WL8L+QbYggpDlK9iN8cjjCIKhcbkMYUQGZYNXs2G9ohemDcumuEylG9JMLinA=
X-Received: by 2002:a17:90a:c106:b0:340:b908:9665 with SMTP id
 98e67ed59e1d1-3543b3cf58amr10571908a91.37.1770069489254; Mon, 02 Feb 2026
 13:58:09 -0800 (PST)
MIME-Version: 1.0
References: <20260123145750.1200879-1-alex.bennee@linaro.org>
 <20260123145750.1200879-9-alex.bennee@linaro.org>
 <CANCZdfo3yz=aC-EOxd2LYBX=tf=RQTY6ibCpj-fCfGHZtH6WTw@mail.gmail.com>
 <aXOok4KRTvgwx7GJ@redhat.com>
 <CANCZdfoXfeBh5For_Cag+191GkjDtsqBNZ4LU1g2DYepkYoaBw@mail.gmail.com>
In-Reply-To: <CANCZdfoXfeBh5For_Cag+191GkjDtsqBNZ4LU1g2DYepkYoaBw@mail.gmail.com>
From: Warner Losh <imp@bsdimp.com>
Date: Mon, 2 Feb 2026 14:57:57 -0700
X-Gm-Features: AZwV_Qit5lqfXjdg9NIBUme4ymCBsqWFRFMXtCLtC62zb9FG1Oxirv7fukLAE3w
Message-ID: <CANCZdfqBKMt5qxfrEhudTbrkMzKRzVATuTWXnRnPttVj6UZ5HA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 08/16] MAINTAINERS: be realistic about *-user
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Joe Perches <joe@perches.com>, John Snow <jsnow@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000002294d10649de6b89"
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

--0000000000002294d10649de6b89
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Just to follow up....

On Fri, Jan 23, 2026 at 3:14=E2=80=AFPM Warner Losh <imp@bsdimp.com> wrote:

>
>
> On Fri, Jan 23, 2026 at 9:58=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange=
@redhat.com>
> wrote:
>
>> On Fri, Jan 23, 2026 at 08:12:33AM -0700, Warner Losh wrote:
>> > On Fri, Jan 23, 2026 at 8:00=E2=80=AFAM Alex Benn=C3=A9e <alex.bennee@=
linaro.org>
>> wrote:
>> >
>> > > We should reflect the current status so users don't have unrealistic
>> > > expectations of how quickly things can get reviewed and merged.
>> > >
>> > > Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> > >
>> >
>> > Reviewed-by: Warner Losh <imp@bsdimp.com>
>>
>> snip
>>
>> > A lot of the upstreaming work that's stalled would be ideal to tell
>> claude
>> > to do,
>> > but I'm unsure the project's stance on using claude to move code, and
>> git
>> > log
>> > 5 different trees to get the original author(s) of the code and make
>> > trivial compile
>> > tweaks.
>>
>> The critical thing we don't want is such tools making changes to the
>> contents of source files.
>>
>> Automating the moving around of files is a non-issue.
>>
>> The use of AI for writing commit messages is arguably in scope of QEMU's
>> AI policy given that is part of "the contribution", but it is less serio=
us
>> there, since commit messages don't have a copyright implication on what =
we
>> host & distribute.
>>
>> More important is that the commit messages are accurate and well written=
.
>> LLMs have a tendancy to be overly verbose about irrelevant stuff, and of
>> course the well known danger of hallucinating nonsense. IME that makes i=
t
>> challenging to benefit from an LLM, due to review & re-writing overheads
>> you then incurr to validate and fix their output.
>>
>
> Yea, the commit messages llm would generate is 'do function X' and I'd th=
en
> fill it in from there, changing everything except X.
>
>
>> I'd be wary of relying on an AI to extract and report on authorship of
>> code. Accuracy is important there since it implies copyright ownership
>> associations. Likewise a Signed-off-by tag should be added by humans
>> only since it is a statement they are complying with the DCO policy.
>>
>
> I'd be verifying everything done. Verification is relatively easy,
> extraction is
> the hard part. And the range of people it could be is tiny, so I'd know i=
f
> it
> was making stuff up, or had gone off the rails...  And I'd have it add
> something
> like 'Supposed-author: ' that I'd change once I verified it. That's ugly
> grunt work,
> but ugly grunt work I can do in an hour or two rather than the dozens of
> hours
> it usually takes me to do the extraction...
>

So, claude looks likeit's doing a passing fair job at this work. I plan on
submitting
a patch series for one of the minor files in the coming weeks (depending on
how much time I can find to work on it). Any guidance you can give me up
front?

Before I submit, I plan on auditing every single change to make sure claude
didn't introduce anything that's not in bsd-user's blitz branch. Make sure
the authors
are correct to the same level that I've been doing so far. And make sure
I've rewritten
all the commit messages.

One question I have, should include these lines
    =F0=9F=A4=96 Generated with [Claude Code](https://claude.com/claude-cod=
e)
    Co-Authored-By: Claude <noreply@anthropic.com>
it is adding to the commit messages or not? Claude generated this as a
series of
commits from the blitz branch to the master branch, but didn't actually
generate
any new code or fix any bugs. I'm happy to include them if you want, but
also
am weary about setting of a knee-jerk reaction that would be unhelpful sinc=
e
it's responding to the 'slop' worries and not the merits of the current
work.

Comments?

Warner

--0000000000002294d10649de6b89
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Just to follow up....</div><br><div class=
=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr=
">On Fri, Jan 23, 2026 at 3:14=E2=80=AFPM Warner Losh &lt;<a href=3D"mailto=
:imp@bsdimp.com">imp@bsdimp.com</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div dir=3D"ltr"><br></di=
v><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On F=
ri, Jan 23, 2026 at 9:58=E2=80=AFAM Daniel P. Berrang=C3=A9 &lt;<a href=3D"=
mailto:berrange@redhat.com" target=3D"_blank">berrange@redhat.com</a>&gt; w=
rote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Fri, Ja=
n 23, 2026 at 08:12:33AM -0700, Warner Losh wrote:<br>
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
ude Code](<a href=3D"https://claude.com/claude-code">https://claude.com/cla=
ude-code</a>)<br>=C2=A0 =C2=A0 Co-Authored-By: Claude &lt;<a href=3D"mailto=
:noreply@anthropic.com">noreply@anthropic.com</a>&gt;<br></div><div>it is a=
dding to the commit messages or not? Claude generated this as a series of</=
div><div>commits from the blitz branch to the master branch, but didn&#39;t=
 actually generate</div><div>any new code or fix any bugs. I&#39;m happy to=
 include them if you want, but also</div><div>am weary about setting of a k=
nee-jerk reaction that would be unhelpful since</div><div>it&#39;s respondi=
ng to the &#39;slop&#39; worries and not the merits of the current work.</d=
iv><div><br></div><div>Comments?</div><div><br></div><div>Warner</div></div=
></div>

--0000000000002294d10649de6b89--

