Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D438DC982EE
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 12:15:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8cuQ-0006KJ-Ah; Mon, 21 Sep 2026 08:14:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x8ctE-0006Cs-Jx
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 08:13:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x8ct9-0007JE-VE
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 08:12:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789992767;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7+JD3mTi86sGhaSBsgRZ6NB7AtTEF5bZ4v5vaNAjYtI=;
 b=I3wygmee6aGMB5nOkSKzSu17QMB4ZJGsASc61Dd5gdxkv/PQ9cCrfmB9zlfVlwGeNGlJ0k
 3IEBq7LovYH8D2W2kGLi/9ep1icqBI00lJ95RGpuw9jDMrWZb1SkLe3Gsfj6o8JDKf3+xC
 stHuUtqgPnKrgYwhhfLAvbp0j/ExTXw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-ZJ0XkTzKNpSP3PQVmEMeZA-1; Mon, 21 Sep 2026 08:12:45 -0400
X-MC-Unique: ZJ0XkTzKNpSP3PQVmEMeZA-1
X-Mimecast-MFC-AGG-ID: ZJ0XkTzKNpSP3PQVmEMeZA_1789992764
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-4843227cfcfso2289458f8f.1
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 05:12:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789992764; cv=none;
 d=google.com; s=arc-20260327;
 b=JH1RoYKp5DHPjqcCZVJ/Fgtb/kYWO6CLxgjVppRTYn8dU5DyqDixUgq0RAIQGlFoFy
 FqnPWMYiGiqAP0W88pz0veXb/PGizwi9WZVmUeeNkkyBvdSlTH14gmQ9OylCOkgClvYH
 eN3LZM+r6KlDPbLdPMr8XanE8d0xKUM2d6r6JxjGpZT+HSufYZaXrHxY6b0sf/wBGUqR
 SOLjqPI9yP1Kb8XBe+vD9Scj+GwfNZ3SjV6jX/G2UbStgOpwF0nJ4MgoH2ufIgNA2CX/
 7RgJ4FzG1f/QTwqoqsENB/eI0AFyJZmxbcZbICIUknk8tH2t2V0YpKcDTYLWDADw5ZvB
 +i1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=7+JD3mTi86sGhaSBsgRZ6NB7AtTEF5bZ4v5vaNAjYtI=;
 fh=4m7tIYVnUNdurO22ikN6uxqzC3ThfZyafZBO6DbVofw=;
 b=kCfLpFpFZPORBwB84T8Xk6VXNdrgMmygtHavGJ4lAjxzPdDWd1eOlS9DovZKwSjnkw
 zXWlcOzF9BX9JGSSKvOXCWH2xsE7YvmTpKesvfa6/RxIerHlz33dc4fyDkM1P+jn2Zof
 Y9LZVmnK+IybQUlCTFPqZONbhmE9w+v7OKqUeZp4fJ1nluaQLa069s95MGNTTn+UFzAc
 yxgo9NNTURlvnPhlAI9Ur/lgprZEC2XImH32j7kyaRTJNteLmP8DF3HtXOWAUuLWoCnP
 ivYGyTXUdXTjELAxHhn7a4fzykrzWGKDpb+VV9bN4fZf5uIFbWQ2ajtb4XxpxEq+KZwA
 t8tw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789992764; x=1790597564; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=7+JD3mTi86sGhaSBsgRZ6NB7AtTEF5bZ4v5vaNAjYtI=;
 b=EJKSXGJTMH50uren/cgbYOCaIJbq7cjjGJ6QXhUAi4qMDEoQzFCve50TdWhkPyKW+q
 kOuWAquJgZ+9LDqEsiKtI+fjEazUpxgn2UsYcOA+PzjRTcQ6FhrZkamF4j66hotBp9Ai
 g+h3j/8MM6xeD4W+P5PZdW4CXBXjlebOeJ97qV/s6M4SkseLZdgu85ZpY5eBGIo8+6n6
 3nil5+kkNiABAV5Q14/40UpimQ595MDgAD/90tQWxOKnnxwB4Ky3gH0KUM5ZFMH5XfMA
 99B8jFNuDQqifkeCZYHD3Is80FW39iftAZPRWhFqnMdYUmiZUyhAdrg7c21UyuG08Koz
 FbyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789992764; x=1790597564;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=7+JD3mTi86sGhaSBsgRZ6NB7AtTEF5bZ4v5vaNAjYtI=;
 b=fwtNU76wlKLhPNsfzPEmXwVmVFCw7JTAuZM6E2g5JvW9DlEjGhFU95ARRQ2h1x2TSr
 15vnQI5g1j5TAKUYZXK6lA82kVlpCnFZPW1hyREKDVO45r18hrc4Fvx6AbvbPvwjfS3f
 aDK4ht3Om2nHzPUeqWfh2p/DbDiS4I1oHWlQn4HpyyESLc2fB7cAi2Dx3oSdDGSva9u9
 CHOAA0eH8up2ffRGAZKaOGx/C89DDgGTKJ85wh3OZEMHyDeYQCgAls82z/NB1wxU/CUz
 kAQz88lDO0mxE06CpF/ABN02BhUBaeOPojmrrbVNuXMXpcivHXsjJCeVafrnsDV+j0QD
 wEsQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByRJt5aumUJOyM5x7eAKahkesxhnG1Om3OeJkZyshZk9u9yi7DG2wzmuy3uynRbw4v77II9ySmYX6+5@nongnu.org
X-Gm-Message-State: AFuF++lnxQs/67PR2Cx+/HcajhSrX7CaF3QhoftAdqegQSTa+Hp0cW2+
 aYm/cFPZN1ThjEW02mtB7urjjyOmffqBq5nqfTPl//VaLb8AUX4bX3A+2AUjNTiN5Voy6ovhRBe
 ddWKlROBwY0xs+AQHL/Ek5hVJLFPq6WAmhb7zNkGwtFK2UPpcAQJrV+cfNiKgxb7cSgCKUuPg82
 mAjr8pnIdqDoBrKbMb1pZp9W7bN61EFEw=
X-Gm-Gg: AYBFou1oyZiwshM10oNk2gVzEvPWUKDxpaoV5toPSfqBKYk4OoDIwR6c4bvZk+y4L/9
 IUBcNS4cX6yCQDYeh5Cbxtip1RLK5LBDMh2ECK4GJD6AxMXrUiy2kh1CSJ17bg+RJeVN1qEjlhY
 Pb87e1pPqXdZaMNz/5M2XpUPa87r7UNaMovGXDAKuV68ODoqczP6/XUSuOCQtMpZ2cNb9NB1GtD
 AJfLbzxLXQUJ9e9XQjZKD0Eg7enXdZzHhnYUMEwW4iqTAZg1obHSuu3R+EgBQ==
X-Received: by 2002:a05:6000:2083:b0:488:5468:c23a with SMTP id
 ffacd0b85a97d-4885468c35amr9283598f8f.17.1789992764360; 
 Mon, 21 Sep 2026 05:12:44 -0700 (PDT)
X-Received: by 2002:a05:6000:2083:b0:488:5468:c23a with SMTP id
 ffacd0b85a97d-4885468c35amr9283498f8f.17.1789992763447; Mon, 21 Sep 2026
 05:12:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260921075251.12831-1-pbonzini@redhat.com>
 <20260921075251.12831-4-pbonzini@redhat.com>
 <878q4v0wle.fsf@draig.linaro.org> <arEQ0knroQ3NDDBA@redhat.com>
In-Reply-To: <arEQ0knroQ3NDDBA@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 21 Sep 2026 14:12:32 +0200
X-Gm-Features: AcwNN1W2wWqM_M2qPSgNZW8msTGsT9c4OoGsf3KZPE3fDmtrTJQdQangeSUba7k
Message-ID: <CABgObfanWMyrLnBzM=_c6HgKFXO9Stu5WR6YU6dpSCLjS6Nr2A@mail.gmail.com>
Subject: Re: [PATCH 3/4] AGENTS.md: let agents know what the participation
 rules are
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 qemu-devel <qemu-devel@nongnu.org>, "Michael S . Tsirkin" <mst@redhat.com>, 
 Alistair Francis <alistair.francis@wdc.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, 
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Warner Losh <imp@bsdimp.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000d0f98f065bfd2ad7"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
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

--000000000000d0f98f065bfd2ad7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il lun 21 set 2026, 13:11 Daniel P. Berrang=C3=A9 <berrange@redhat.com> ha
scritto:

> > > +### No automated posting
> > > +
> > > +Agents **must not** use any API, CLI, or web UI automation to:
> > > +
> > > +- Interact on the QEMU mailing lists
> > > +- Create, edit, or close **issues ("work items")**
> > > +- Post **comments** on merge requests, issues or commits
> > > +- Open or update **merge requests (MRs)**.  QEMU does not use merge
> requests anyway.
> > > +
> >
> > Are we considering project agents (such as the stsquad-bot) exempt from
> > this policy? I'm not sure what a normal agent can do via the API as it
> > wouldn't have the project level access the stsquad-bot needs.
>
> At least a user's agent can likely bulk file work items without elevated
> access privs, as we've seen by the several slop-bombs we've had.
>
> I'd add a footnote for that along the lines of:
>
>  'Official project agents whose code is maintained under
> gitlab.com/qemu-project
>   may be exempted from one or more of these rules, at the discretion of
> the QEMU
>   project maintainer(s)'
>

Sure.

> > +### No AI-written text must reach maintainers
> > > +
> > > +These rules apply when publishing AI-assisted work to GitLab or the
> mailing list:
> > > +
> > > +- **AI-written cover letters and commit messages are banned**.  Thes=
e
> are
> > > +  easy to recognize and waste reviewers' time.
> > > +- **AI-generated responses to reviewer comments are banned**. This
> undermines
> > > +  the human-to-human interaction fundamental to code review.
> > > +- **AI-written issue ("work item") descriptions or comments are
> banned**. These
> > > +  are verbose and waste triagers' time.
> > > +  - An exception is made for issues for defects detected by automate=
d
> or
> > > +    semi-automated tooling, including fuzzers and LLM-assisted defec=
t
> > > +    detection.  Such issues must be reviewed by a human before
> creation,
> > > +    must be created by a human and communication with maintainers mu=
st
> > > +    be done by a human, but including the verbatim tool output in th=
e
> > > +    issue description is explicitly allowed.
>
> I kind of want to eliminate this exception. IMHO from the bugs we're
> getting, I think human's are often putting very little effort into
> reviewing the tools output, such that it is largely a box ticking
> exercise to claim they've reviewed it.
>
> If we removed the exception, and required humans to write up the
> finding of the fuzzer/detect detection in human language, that
> may do a better job of getting people to engage in more critical
> thinking rather than rubber stamping the tool output.
>
> It would limit the ability of people bulk file 50+ tickets in a day.
>

I think that's the problem, namely not realizing there's someone on the
other side.

LLM write-ups are essentially the same as patents, they look like English
but they're not; and the verbosity of the write-ups is sometimes a curse
and sometimes a blessing. There is a tension between having a simple
description of the issue and an unopinionated one. The fix is not always
trivially obvious, and sometimes the "executive summary" from the LLM
points in the wrong direction=E2=80=94I have no expectation that human repo=
rters
will be any better at not misleading me.

In fact I'd rather like us to introduce an explicit rule that a person/
> tool must not file more than about 5 tickets in a single day, without
> prior approval from maintainers, so we don't get bombarded at such a
> high rate.
>

Sure, that's a good idea. Even 5 per month...

Paolo


>
> With regards,
> Daniel
> --
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
>
>

--000000000000d0f98f065bfd2ad7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il lun 21 set 2026, 13:11 Daniel=
 P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com">berrange@redha=
t.com</a>&gt; ha scritto:</div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">
&gt; &gt; +### No automated posting<br>
&gt; &gt; +<br>
&gt; &gt; +Agents **must not** use any API, CLI, or web UI automation to:<b=
r>
&gt; &gt; +<br>
&gt; &gt; +- Interact on the QEMU mailing lists<br>
&gt; &gt; +- Create, edit, or close **issues (&quot;work items&quot;)**<br>
&gt; &gt; +- Post **comments** on merge requests, issues or commits<br>
&gt; &gt; +- Open or update **merge requests (MRs)**.=C2=A0 QEMU does not u=
se merge requests anyway.<br>
&gt; &gt; +<br>
&gt; <br>
&gt; Are we considering project agents (such as the stsquad-bot) exempt fro=
m<br>
&gt; this policy? I&#39;m not sure what a normal agent can do via the API a=
s it<br>
&gt; wouldn&#39;t have the project level access the stsquad-bot needs.<br>
<br>
At least a user&#39;s agent can likely bulk file work items without elevate=
d<br>
access privs, as we&#39;ve seen by the several slop-bombs we&#39;ve had.<br=
>
<br>
I&#39;d add a footnote for that along the lines of:<br>
<br>
=C2=A0&#39;Official project agents whose code is maintained under <a href=
=3D"http://gitlab.com/qemu-project" rel=3D"noreferrer noreferrer" target=3D=
"_blank">gitlab.com/qemu-project</a><br>
=C2=A0 may be exempted from one or more of these rules, at the discretion o=
f the QEMU<br>
=C2=A0 project maintainer(s)&#39;<br></blockquote></div></div><div dir=3D"a=
uto"><br></div><div dir=3D"auto">Sure.</div><div dir=3D"auto"><br></div><di=
v dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">
&gt; &gt; +### No AI-written text must reach maintainers<br>
&gt; &gt; +<br>
&gt; &gt; +These rules apply when publishing AI-assisted work to GitLab or =
the mailing list:<br>
&gt; &gt; +<br>
&gt; &gt; +- **AI-written cover letters and commit messages are banned**.=
=C2=A0 These are<br>
&gt; &gt; +=C2=A0 easy to recognize and waste reviewers&#39; time.<br>
&gt; &gt; +- **AI-generated responses to reviewer comments are banned**. Th=
is undermines<br>
&gt; &gt; +=C2=A0 the human-to-human interaction fundamental to code review=
.<br>
&gt; &gt; +- **AI-written issue (&quot;work item&quot;) descriptions or com=
ments are banned**. These<br>
&gt; &gt; +=C2=A0 are verbose and waste triagers&#39; time.<br>
&gt; &gt; +=C2=A0 - An exception is made for issues for defects detected by=
 automated or<br>
&gt; &gt; +=C2=A0 =C2=A0 semi-automated tooling, including fuzzers and LLM-=
assisted defect<br>
&gt; &gt; +=C2=A0 =C2=A0 detection.=C2=A0 Such issues must be reviewed by a=
 human before creation,<br>
&gt; &gt; +=C2=A0 =C2=A0 must be created by a human and communication with =
maintainers must<br>
&gt; &gt; +=C2=A0 =C2=A0 be done by a human, but including the verbatim too=
l output in the<br>
&gt; &gt; +=C2=A0 =C2=A0 issue description is explicitly allowed.<br>
<br>
I kind of want to eliminate this exception. IMHO from the bugs we&#39;re<br=
>
getting, I think human&#39;s are often putting very little effort into<br>
reviewing the tools output, such that it is largely a box ticking<br>
exercise to claim they&#39;ve reviewed it.<br>
<br>
If we removed the exception, and required humans to write up the<br>
finding of the fuzzer/detect detection in human language, that<br>
may do a better job of getting people to engage in more critical<br>
thinking rather than rubber stamping the tool output.<br>
<br>
It would limit the ability of people bulk file 50+ tickets in a day.<br></b=
lockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">I think=
 that&#39;s the problem, namely not realizing there&#39;s someone on the ot=
her side.</div><div dir=3D"auto"><br></div><div dir=3D"auto">LLM write-ups =
are essentially the same as patents, they look like English but they&#39;re=
 not; and the verbosity of the write-ups is sometimes a curse and sometimes=
 a blessing. There is a tension between having a simple description of the =
issue and an unopinionated one. The fix is not always trivially obvious, an=
d sometimes the &quot;executive summary&quot; from the LLM points in the wr=
ong direction=E2=80=94I have no expectation that human reporters will be an=
y better at not misleading me.</div><div dir=3D"auto"><br></div><div dir=3D=
"auto"><div class=3D"gmail_quote gmail_quote_container"><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
In fact I&#39;d rather like us to introduce an explicit rule that a person/=
<br>
tool must not file more than about 5 tickets in a single day, without<br>
prior approval from maintainers, so we don&#39;t get bombarded at such a<br=
>
high rate.<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=
=3D"auto">Sure, that&#39;s a good idea. Even 5 per month...</div><div dir=
=3D"auto"><br></div><div dir=3D"auto">Paolo=C2=A0</div><div dir=3D"auto"><b=
r></div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container">=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
<br>
With regards,<br>
Daniel<br>
-- <br>
|: <a href=3D"https://berrange.com" rel=3D"noreferrer noreferrer" target=3D=
"_blank">https://berrange.com</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0~~=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 <a href=3D"https://hachyderm.io/@berrange" rel=3D"noreferrer=
 noreferrer" target=3D"_blank">https://hachyderm.io/@berrange</a> :|<br>
|: <a href=3D"https://libvirt.org" rel=3D"noreferrer noreferrer" target=3D"=
_blank">https://libvirt.org</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ~~=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://entangle-photo.org" rel=3D"n=
oreferrer noreferrer" target=3D"_blank">https://entangle-photo.org</a> :|<b=
r>
|: <a href=3D"https://pixelfed.art/berrange" rel=3D"noreferrer noreferrer" =
target=3D"_blank">https://pixelfed.art/berrange</a>=C2=A0 =C2=A0~~=C2=A0 =
=C2=A0 <a href=3D"https://fstop138.berrange.com" rel=3D"noreferrer noreferr=
er" target=3D"_blank">https://fstop138.berrange.com</a> :|<br>
<br>
</blockquote></div></div></div>

--000000000000d0f98f065bfd2ad7--


