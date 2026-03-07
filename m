Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D77AF55113
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 23:22:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vz0xl-0004Np-Ly; Sat, 07 Mar 2026 18:21:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aerosound161@gmail.com>)
 id 1vz0xi-0004Na-0m
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 18:21:34 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aerosound161@gmail.com>)
 id 1vz0xf-0004YO-Vk
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 18:21:33 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2ae46b9c70dso28672115ad.1
 for <qemu-devel@nongnu.org>; Sat, 07 Mar 2026 15:21:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772925690; cv=none;
 d=google.com; s=arc-20240605;
 b=M+GLd7Ovw+uAYVIzjjosAIMIMH1QdRJhWWO0Twjo6nCy/oMR2PCBs+PZm/EIJTwu/f
 8qPgYTU0s4BzMd8qjuR2KffwoZrz2t1ZNU+pjrdxgWi2yYZk0LdGd6z5Ve0Sol76a/RX
 NwJCb9HAHdjIWCv72RqvGw5WojM5/SvWxBjZO+GL2N2W5NIF09SPj1IteMI+kRiRVZ21
 3RnLuLiCIBIW8U0/AIJ3wyx16QhUlQjKUFDBWs492N6X1PNf0xS2d9P/oLbim/6gE9qc
 rOmJs4TWnM6/B7zxYZ2vYmm9KtuOlbL4YuFp8LZANFN5baePEp8BzQoNyi5c3PPJMOIV
 7Qww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=fkG+fZ2bkgWrzTicTQGN3xQcqflkEoZS6BCPEKOl+vA=;
 fh=zor/fgeKRkKXjRFxKi3agqJ25If3F/u5M32dOhhNDqw=;
 b=M8czvC5JrsHYIwqefQTVpo32VbWHVomjnq+pExwd0TdM7pPdv+rfYLrp6DuzuFlC+4
 hT71Mlaei/C9XG3gxZIZPMn3mjMiIbgV7OcOlB5J4TbgMaSkCzVFPDoyTmrJbUpdRrGt
 JVf77VGL6ojf/HS90u9P1GDcn1U9NnhOiOoZB8aQuL3EyWpMZh06k8z3o/ItEu3qlq7J
 5uRJwr+2UE+TldqVled0nICYFNcyWbMG/5pIMr4WryK3IHwOJsOmxoks3E1fVH6P1yEO
 G3iOvwo3xuIaBw5xjHuB7hKSt/PKZoCothKm3M46KJubSaKfyKz2EGWNxCVWRbqrroqf
 obXA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772925690; x=1773530490; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fkG+fZ2bkgWrzTicTQGN3xQcqflkEoZS6BCPEKOl+vA=;
 b=EBVe1ywPpi+2XZ9VAkqHl9RJ3yPG6q9n8dsj4OkLlppHb3aYYgmhecUNV/zxyLyuC4
 wSmAecSrNvhCiU0a1tNy1PDEo83+5rN7jgL86ZhM0eSeSvmdCb9W8F+v8N4NzU0CHYb4
 tnditNzBneBOa9y3+frblSB8pgzLlzfkCaHHxgfdmenWkWwFZNiadHQeb9MKJ/U2hzKn
 r/c/0bEtgC/cCyfnkGU3J+cGQMby+Qf6/G8NnKIvtedUy8kCR81jOly24wV/Zi99RaYJ
 oUV06ke6uNVQN4jt6YPr7F95azCdZKvxL/lnf6IfYY4KErOo4sP+c6urIn9SnCcaTahu
 wAXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772925690; x=1773530490;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fkG+fZ2bkgWrzTicTQGN3xQcqflkEoZS6BCPEKOl+vA=;
 b=WzcfqB2KyC7D7S9vrRqjmORQsgKkZ3fjH0HcvWmTTPZUnA8n+xbE6W2qiBTKug1Ts3
 aN2fk74b8S1sBiY8zNRzdySmQpclEmd9w+SO9Vyh6Om/vUFS+CVpo1SlqLIuzRL9cqQT
 WdRXWx3MVy5Lk3bj4Ube/idEZdlt2ddRMXsVXa43EOnkawMVOP8VbbLcxDoT1oV417FR
 JloM92E0BQZDwaIV2rmDs3xu0/Kj66qJnOAhw0+y19cOMZG73O+UGUnYfvvdHlk4jSfb
 oJqN1UcyCHJpXRuW38hWrRqVr+owP7GoKX9Ltsf/+/SQADsLDkgPQWG7I3k4hSRSZqFI
 PhGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUj9UkUkg+g7Aed3mCGXXBLd/8X6JARafasBPtAPgdKrxhEO2LKN/Xkf+9eJWEP0Yxh7c/3ydXM/qgb@nongnu.org
X-Gm-Message-State: AOJu0YyFOlktqdfVPyze8nz18GSODpwPsuasxZAQmjhJTeuaPiPBsNLe
 VaoQC6cmV4FKz0zR0zwbeYO7NxxIHMEsnvYrphKZwi0UbG1Wa9qgAoEzMAPnllxSVajk0TVK/e1
 RSprSOGfGMnTLNH88cECausVFYiRjZ74=
X-Gm-Gg: ATEYQzwGRshf8W1MRtqi5Ra9+PN3Lk11U7sRvsfU3N4Ns0kLxvwGAgLBedGgryQrlC2
 gCD5Y/yeAKyyJQufV2BG0QO91SrPCorYmIKQR/4QHfr6mM7GOgZgmo0N33I0t3C9mBN0dnmQ/uH
 FSg4gEVuXwrSjQP34lvwZ6apEpud3+vZX+0QA88GIL0kcXThddbOvVUNDbI8bl4siHpK2DCaD7V
 IetU1tSUdAk8MUbwaOwtbKdR6b+vM/IrHlQVvWSzhvEK8c0rxzQGt+Ko9ZcyMB4Puu27yR8Z0uw
 /veEK6x6cbUzjBhMC99Nu1h+AcWNh0pt36sFsg==
X-Received: by 2002:a17:902:f60a:b0:2ae:4d6b:b2c7 with SMTP id
 d9443c01a7336-2ae82963a20mr64277325ad.9.1772925689657; Sat, 07 Mar 2026
 15:21:29 -0800 (PST)
MIME-Version: 1.0
References: <CAHxyR9KTC0QzbSYQTAqpBxnyEWJG9+xMGENHps4vfJEPR16Dww@mail.gmail.com>
 <9abb752c-8f26-408e-b6d3-4d4cc2fb86b0@redhat.com>
 <CAHxyR9LgW-MY8PWs_hpGUh=AiYNfD-W8FirmkGMO1Xguby4Lxg@mail.gmail.com>
 <2787739.lGaqSPkdTl@bywater>
In-Reply-To: <2787739.lGaqSPkdTl@bywater>
From: Ammar Yasser <aerosound161@gmail.com>
Date: Sun, 8 Mar 2026 01:21:18 +0200
X-Gm-Features: AaiRm53UmJeRCq3XVpplxgswBzEm2ix-DMF8RwdAxeyBavxAohAx1wflypNHQzQ
Message-ID: <CAHxyR9KK=AcqjxYh7gSG2bBw4bcLbyEgVFL86sUKt-2Z_uxrYg@mail.gmail.com>
Subject: Re: GSoC virtio-rtc project
To: Francesco Valla <francesco@valla.it>
Cc: "mvaralar@redhat.com" <mvaralar@redhat.com>,
 "sgarzare@redhat.com" <sgarzare@redhat.com>, qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000f1fc94064c776d3d"
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=aerosound161@gmail.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
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

--000000000000f1fc94064c776d3d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Francesco

Thanks for your guidance,
Note that some of the phases highlighted can be discussed or thought of
before the project starts, but will be revisited to a greater depth when
the project starts if we didn't fully converge on them. If we do, then the
planning phases should be on the shorter end of the range.

My core assumption is that there are two parts to the clock. The part that
does the basic state keeping, hardware interaction and so on.. and the part
that interprets that state into UTC, or TAI.. etc. that being said, here's
my thought process for how we might structure the project:


1- Define the basic code structure for the device, what are its parameters
and how it interacts with QEMU, how it takes inputs from multiple VMs and
what are the basic data structures it uses for book keeping and so on (1~2
weeks)

2- Come up with a basic design for a clock and explore the core questions.
like what state it keeps internally, how and when does this state change,
what syscalls will it make to actually read the time, how the code would
handle different architectures, how would cross timestamping work, and how
would a typical translation layer from the fundamental state to one of the
clock types in the spec look like (1~2 weeks)

3- Implement the core state of the clock + develop a strong test suite (2
weeks)

4- Pick one clock type and implement its full features (alarms, cross
timestamping with VIRTIO_RTC_COUNTER_ARM_VCT
and VIRTIO_RTC_COUNTER_X86_TSC), preferably the UTC_SMEARED clock as its
the one with the most complexity. It's always expected that there might be
some aspects that will balloon in time, so committing to finishing the most
complex clock fully would help clear a lot of ambiguity. (2 weeks)

5- Write the QEMU glue code (1 week)

6- Test the clock developed at phase 4 with QEMU end-to-end on arm and
x86_64, report any issues (1 week)

7- Complete as many as possible of the other clock types after sorting them
by priority (till the end of the program)

Let me know if this plan sounds or if it contains any gaps!

Some of the questions i have to gauge priorities are:

- Which matters more ? full spec coverage on a single architecture, or
partial but consistent coverage across all architectures?
- Are there any architectures that we should think of supporting apart from
arm and x86_64 ?
- Based on your experience, where do you believe the majority of the
complexity will come from ?

Thanks in advance
Ammar



On Tue, 3 Mar 2026 at 23:42, Francesco Valla <francesco@valla.it> wrote:

> Hello Ammar,
>
> On luned=C3=AC 2 marzo 2026 at 23:53, Ammar Yasser wrote:
> > Hello maintainers
> >
> > Re-introducing myself in case you missed my email to the mailing list.
>
> I *did* lost your first e-mail, so thank you for writing this one.
>
> > I'm Ammar, a software engineer working with Linux kernel and
> virtualization.
> > I'm interested in contributing to QEMU for GSoC 2026, particularly the
> > virtio-rtc vhost-user device project. If accepted, this would be my
> second
> > GSoC participation. I participated in 2024 with KubeVirt, which was my
> > original introduction to QEMU.
> >
> > I have the following questions in order to formulate a successful
> proposal:
> >
> > 1. What would you like to see from a successful proposal ? The current
> > points i am studying and plan to include in mine are:
> >
> > - an overview of the RTC device spec
> > - how it would interact with QEMU
> > - some of the rust data types and enums we would introduce for requests=
,
> > different error types.. etc
> > - a breakdown for some of the RTC C implementations that currently exis=
t
> in
> > QEMU (allwinner, aspeed, goldfish.. etc), and what ideas can we borrow
> from
> > them in our rust implementation
> >
> > I am leaving out implementation specific details out of the current
> phase.
> > Let me know if this sounds appropriate
> >
>
> I'd include some details on how you intend to perform the activity (e.g.:
> how
> to split and order the various tasks).
>
> > 2. I am looking for issues I can tackle to familiarize myself with the
> > vhost-device repo and how one device is structured. Any ones you have
> that
> > are relevant to the project or you think are important in general?
> >
>
> No preferences there, please select the one(s) you think appropriate.
>
> > Thanks in advance
> >
> > Ammar
> >
> >
>
> Regards,
>
> Francesco
>
>
>

--000000000000f1fc94064c776d3d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hey Francesco<div><br>Thanks for your guidance,<br>Note th=
at some of the phases highlighted can be discussed or thought of before the=
 project starts, but=C2=A0will be revisited to a greater depth when the pro=
ject starts if we didn&#39;t fully converge on them. If we do, then the pla=
nning=C2=A0phases should be on the shorter end of the range.</div><div><br>=
</div><div>My core assumption is that there are two parts to the clock. The=
 part that does the basic state keeping, hardware interaction and so on.. a=
nd the part that interprets that state into UTC, or TAI.. etc. that being s=
aid, here&#39;s my thought process for how we might structure the project:<=
/div><div><br></div><div><br></div><div>1- Define the basic code structure =
for the device, what are its parameters and how it interacts with QEMU, how=
 it takes inputs from multiple VMs and what are the basic data structures i=
t uses for book keeping=C2=A0and so on (1~2 weeks)</div><div><br></div><div=
>2- Come up with a basic design for a clock and explore the core questions.=
 like what state it keeps internally, how and when does this state change, =
what syscalls will it make to actually read the time, how the code would ha=
ndle different architectures, how would cross timestamping work, and how wo=
uld a typical translation layer from the fundamental state to one of the cl=
ock types in the spec look like (1~2 weeks)</div><div><br></div><div>3- Imp=
lement the core state of the clock=C2=A0+ develop a strong test suite (2 we=
eks)</div><div><br></div><div>4- Pick one clock type and implement its full=
 features (alarms, cross timestamping with=C2=A0VIRTIO_RTC_COUNTER_ARM_VCT =
and=C2=A0VIRTIO_RTC_COUNTER_X86_TSC), preferably the UTC_SMEARED clock as i=
ts the one with the most complexity. It&#39;s always expected that there mi=
ght=C2=A0be some aspects that will balloon in time, so committing to finish=
ing the most complex clock fully would help clear a lot of ambiguity. (2 we=
eks)</div><div><br></div><div>5- Write the QEMU glue code (1 week)</div><di=
v><br></div><div>6- Test the clock developed at phase 4 with QEMU end-to-en=
d on arm and x86_64, report any issues (1 week)</div><div><br>7- Complete a=
s many as possible of the other clock types after sorting them by priority =
(till the end of the program)</div><div><br></div><div>Let me know if this =
plan sounds or if it contains any gaps!<br></div><div><br></div><div>Some o=
f the questions i have to gauge priorities are:</div><div><br></div><div>- =
Which matters more ? full spec coverage on a single architecture, or partia=
l but consistent coverage across all architectures?</div><div>- Are there a=
ny architectures that we should think of supporting apart from arm and x86_=
64 ?</div><div>- Based on your experience, where do you believe the majorit=
y of the complexity will come from ?</div><div><br></div><div>Thanks in adv=
ance</div><div>Ammar</div><div><br></div><div><br></div></div><br><div clas=
s=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_att=
r">On Tue, 3 Mar 2026 at 23:42, Francesco Valla &lt;<a href=3D"mailto:franc=
esco@valla.it">francesco@valla.it</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">Hello Ammar,<br>
<br>
On luned=C3=AC 2 marzo 2026 at 23:53, Ammar Yasser wrote:<br>
&gt; Hello maintainers<br>
&gt; <br>
&gt; Re-introducing myself in case you missed my email to the mailing list.=
<br>
<br>
I *did* lost your first e-mail, so thank you for writing this one.<br>
<br>
&gt; I&#39;m Ammar, a software engineer working with Linux kernel and virtu=
alization.<br>
&gt; I&#39;m interested in contributing to QEMU for GSoC 2026, particularly=
 the<br>
&gt; virtio-rtc vhost-user device project. If accepted, this would be my se=
cond<br>
&gt; GSoC participation. I participated in 2024 with KubeVirt, which was my=
<br>
&gt; original introduction to QEMU.<br>
&gt; <br>
&gt; I have the following questions in order to formulate a successful prop=
osal:<br>
&gt; <br>
&gt; 1. What would you like to see from a successful proposal ? The current=
<br>
&gt; points i am studying and plan to include in mine are:<br>
&gt; <br>
&gt; - an overview of the RTC device spec<br>
&gt; - how it would interact with QEMU<br>
&gt; - some of the rust data types and enums we would introduce for request=
s,<br>
&gt; different error types.. etc<br>
&gt; - a breakdown for some of the RTC C implementations that currently exi=
st in<br>
&gt; QEMU (allwinner, aspeed, goldfish.. etc), and what ideas can we borrow=
 from<br>
&gt; them in our rust implementation<br>
&gt; <br>
&gt; I am leaving out implementation specific details out of the current ph=
ase.<br>
&gt; Let me know if this sounds appropriate<br>
&gt; <br>
<br>
I&#39;d include some details on how you intend to perform the activity (e.g=
.: how<br>
to split and order the various tasks).<br>
<br>
&gt; 2. I am looking for issues I can tackle to familiarize myself with the=
<br>
&gt; vhost-device repo and how one device is structured. Any ones you have =
that<br>
&gt; are relevant to the project or you think are important in general?<br>
&gt; <br>
<br>
No preferences there, please select the one(s) you think appropriate.<br>
<br>
&gt; Thanks in advance<br>
&gt; <br>
&gt; Ammar<br>
&gt; <br>
&gt; <br>
<br>
Regards,<br>
<br>
Francesco<br>
<br>
<br>
</blockquote></div>

--000000000000f1fc94064c776d3d--

