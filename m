Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D89DD778BD
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 22:10:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjPLa-00050a-VO; Fri, 23 Jan 2026 17:09:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1vjPLZ-0004vR-2M
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 17:09:41 -0500
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1vjPLW-00041k-1F
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 17:09:40 -0500
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-34c27d14559so1715458a91.2
 for <qemu-devel@nongnu.org>; Fri, 23 Jan 2026 14:09:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769206176; cv=none;
 d=google.com; s=arc-20240605;
 b=MgU12kWPw4VPW3x0fVF508rhEq8l00Or0JNAPDIOr8Dg/kaqVD4ITwOO0380cFe98D
 AaXPsR+N2IUgWP86LyytgBgj+OJmxby822Z7S2s1zbOg+lbhTflxtbjqEZhA3ZrMoyU/
 Yf3990zAnvsmb2eNkIxfyiN6ZpBUxKzCUQeFtteLm0/w+TuiE6IT2hcELh5vNYbF8xms
 r+W3AFOSrJZZPqlrrgtWlgbfpREcNAJ3VxNOjx0Xin5RIjTo7pNavn8OOeXHjQHzlz8H
 QYyFaRIgsf4621Z/0oarBmrcgD7NrI/eSZGjmH2NF3d6xLeBcnscijeDitJgG76Fma47
 A0ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=C/mU86odNW7o31VGptPeRnTOS0yYRPk0/yNRaHOgpo4=;
 fh=3LdeVfFkXZ8KZnJIYZf+RTsD39aqJqF4PE72kElcBbw=;
 b=IcLbTVGViIfp2QNl1cHvTP0DXwNTrZsqSGdY8nTxRohiDopE+yakDaTMs6+KntUtGF
 G+izXCTscFT1RNtiDfhII5Fu5f5YuI8oMuTrGX25HPn0mliqu8NHONt59eXNOndisPWY
 3MQ8oDI8mxbWBYACA66I4hp4oCkxECkwow7oXiBGtZF+oimulVd1tD8gRd6fB1/ljNuA
 ImKTBi9Mx3Q8GVCYfyxt6PeU+lgr4HsTn2wp2KKTy26ORdxzIIlXZswusDv6c/BXYcYa
 iFeNw3jfxg9F0LyHif8m/qZDFKQk8SsWMFovtvXjMGBk3X8z3MdfdUv6dH/KbJk+nGuw
 6iWQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1769206176; x=1769810976;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=C/mU86odNW7o31VGptPeRnTOS0yYRPk0/yNRaHOgpo4=;
 b=3GRb0j2ARLXCTjFge08CDU/v1wLldMCQNP3ISRfP3CKgtOviadV6l3bD+Edf5Cse/Y
 F8Z2wGD/KjPxHk1MlYpAUPKhl7NNqE66DFCH3ReSpQcsFpmHfPTDZ1mnxVoZF4lAx5tG
 XE8yDlfwYsFNW32fYHsJKTELtgQhtAVtS6zdP90NA7mqnJ61+/BhBytmnZTYIJ8T1Rzy
 HAHPwK67IbgIQrjflVyQNgKv8UQugB8fnwLElNgaoU6Mm+LxwjT1IfK/5OaMSElzpaVZ
 5LsvUlen6Rxpq4QZnNQdFJNeXh+219C8ojbID4pLtobM4jZkqeMNFIUw8UrCMYt42kzj
 c2vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769206176; x=1769810976;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C/mU86odNW7o31VGptPeRnTOS0yYRPk0/yNRaHOgpo4=;
 b=EF9BIOmv0KLeskwqqZJcdExH6vX6oXCtk0xYk7gA+dwM1K+haVVzZdXlNyl5bJQ+jx
 iVAsLJMI4I5sJdAxBLsp+zn2NQTQS4QKL7/VH+HVG7/m/gDdIBHm8gwO1pnc6GAjoqts
 BbsYOsrpgMD7QUwhAQOerS3sKr8xAabZSP77SvhXpNZzWAXNqLcg3DTEmRec+7duhD1N
 H0uTFnjSS68XBzbBGcRpQV8HfhM+vV6N8JpR40y+SAWnWJu+pF4axZX7nj3ih6rlT+Tg
 9jtXdf0J9XWg5VBWlNndShjRDD9GraAtYYA+xnp5I0akHuFuv4gnBCBb//A/BKOEqAIb
 hKqg==
X-Gm-Message-State: AOJu0YxFoj0kB87Jn6HghwZuc1jIw7vNyYxrcSe/ttbW3umtZAGTz0qr
 Abto8YNdcTcrl/lVhZQJ3GHiyzD+hC1AhqUwCgCfnv5bHvUYLF4lxdwMjx3s475tibyN9yPkkpE
 nxQhySuotukn59fmYHciGdd0AMQwtiLazNdxhf/7fCQ==
X-Gm-Gg: AZuq6aJ8cri5FwkVM5T0ZUHF8tzEct8Zxc85NBGQ5EauDrbZuuGyu5BLhOMD11GyrDE
 /MW+0O4Ee2DDelGA8vZ/fYxadVHV2bWEDHbPMc9nuBeK0a50G3QTNb9g3pd53yW+grcBXWVe33I
 +chZEIce4FYtzQ+V5KMu7vKNM384Ki33e8pfe6hBdlLoSginWe/MIAQFyJ544FmhL28MI59RU9t
 fl5ggP8v/wQO1ak/rwMqmRm/SW3YskqFn+RHeKZOD1ByI8h+Zy9E1fZMWOUJSkeyviclBbCvBSW
 +YC6fg==
X-Received: by 2002:a17:90b:3d89:b0:34c:fe7e:850c with SMTP id
 98e67ed59e1d1-353670155camr3165116a91.1.1769206176153; Fri, 23 Jan 2026
 14:09:36 -0800 (PST)
MIME-Version: 1.0
References: <20260123145750.1200879-1-alex.bennee@linaro.org>
 <20260123145750.1200879-9-alex.bennee@linaro.org>
 <CANCZdfo3yz=aC-EOxd2LYBX=tf=RQTY6ibCpj-fCfGHZtH6WTw@mail.gmail.com>
 <87343wmhki.fsf@draig.linaro.org>
In-Reply-To: <87343wmhki.fsf@draig.linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Fri, 23 Jan 2026 15:09:24 -0700
X-Gm-Features: AZwV_Qiqs3qToD9fWhhDXcaKl9qgVEBeAF3IPFMFBBKUY7GPecIXM4YrobD9-lo
Message-ID: <CANCZdfpFZ6uwSURZOJgRFRXh=+xngi2CUVj-PMpg860O4x_Avw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 08/16] MAINTAINERS: be realistic about *-user
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Joe Perches <joe@perches.com>, 
 John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000aa12500649156970"
Received-SPF: none client-ip=2607:f8b0:4864:20::1029;
 envelope-from=wlosh@bsdimp.com; helo=mail-pj1-x1029.google.com
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

--000000000000aa12500649156970
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 23, 2026 at 9:15=E2=80=AFAM Alex Benn=C3=A9e <alex.bennee@linar=
o.org> wrote:

> Warner Losh <imp@bsdimp.com> writes:
>
> (Cc sniping Paolo/Peter/Markus for AI discussion)
>
> > On Fri, Jan 23, 2026 at 8:00=E2=80=AFAM Alex Benn=C3=A9e <alex.bennee@l=
inaro.org>
> wrote:
> >
> >  We should reflect the current status so users don't have unrealistic
> >  expectations of how quickly things can get reviewed and merged.
> >
> >  Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> >
> > Reviewed-by: Warner Losh <imp@bsdimp.com>
> >
> >  ---
> >
> >  [AJB] I realise this is a slightly provocative patch but given how
> >  widely used *-user is downstream we should be clear about the current
> >  state and hopefully encourage those who rely on it to step-up.
> >
> > For the bsd-user case this is likely correct. We run hot and cold about
> being
> > proactive at fixing things, and we've been somewhat cold for a while no=
w.
> >
> > Part of the problem is that this submission process is very very
> heavyweight
> > compared to other projects I contribute to. Not sure what to do about
> that since
> > there's a reluctance to move away from it. Or alternatively, I'm someho=
w
> making
> > it too hard.
>
> We have discussed in the past allowing maintainers to directly submit
> their PRs via GitLab which would be beneficial from a testing point of
> view. To move this forward someone needs to propose the changes to our
> policy documents so it can be discussed and merged.
>
> However we still expect patches to go onto the mailing list for
> review. The greybeards (like myself ;-) are very wedded to the inline
> email workflow but if we could keep that interface while making use of
> the GitLab UI for those that grew up knowing only the web maybe we could
> make the project more friendly to new contributors.
>
> I'd be interested in knowing where the pain points are for you because
> modern tools like b4 make some of the grind (collecting tags and
> applying patches from ML) a lot easier.
>

I've tried setting up b4 before. I'll have to try again.


> Usually the most difficult thing is getting email setup so you can
> git-send-email or git-publish.
>

The most difficult part for me is 'where the heck did google hide the
password
junk today' so I can turn on a password, do the submission, then kill the
password.
I really wish I could do OTP sometimes.


> > A lot of the upstreaming work that's stalled would be ideal to tell
> claude to do,
> > but I'm unsure the project's stance on using claude to move code, and
> git log
> > 5 different trees to get the original author(s) of the code and make
> trivial compile
> > tweaks.
>
> There was some discussion at the maintainers summit about relaxing the
> rules on AI submission for "mechanical" changes but it ran into the
> weeds without any firm conclusion. We could certainly revisit it.
>

Yea, it's not even mechanical changes. It's copying the work from one tree
to another
after that forked tree has been merged to the latest upstream... There's no
creativity
here at all. I'd be happy just having to write the commit messages... the
hard part is
the datamining to see who wrote things, and splitting out out function by
function
with dependencies for easy review...


> I think the concern about potential license pollution is a valid one but
> this is more of a concern for "novel" changes made by AI. I've been more
> relaxed on my personal FLOSS projects where I have allowed AI
> contributions but made it clear that the submitter is expected to
> understand whats going on. But being personal projects they are less
> likely to be spammed to death by AI slop PRs which seems to be a growing
> problem in the wider ecosystem.
>

Yea. we have a github pull request open, and we have problems from time to
time,
but have been swift to close ai chatbots and other slop we get.

Warner


> >
> > Warner
>
> --
> Alex Benn=C3=A9e
> Virtualisation Tech Lead @ Linaro
>

--000000000000aa12500649156970
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jan 23,=
 2026 at 9:15=E2=80=AFAM Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee=
@linaro.org">alex.bennee@linaro.org</a>&gt; wrote:<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">Warner Losh &lt;<a href=3D"mailto:imp@bs=
dimp.com" target=3D"_blank">imp@bsdimp.com</a>&gt; writes:<br>
<br>
(Cc sniping Paolo/Peter/Markus for AI discussion)<br>
<br>
&gt; On Fri, Jan 23, 2026 at 8:00=E2=80=AFAM Alex Benn=C3=A9e &lt;<a href=
=3D"mailto:alex.bennee@linaro.org" target=3D"_blank">alex.bennee@linaro.org=
</a>&gt; wrote:<br>
&gt;<br>
&gt;=C2=A0 We should reflect the current status so users don&#39;t have unr=
ealistic<br>
&gt;=C2=A0 expectations of how quickly things can get reviewed and merged.<=
br>
&gt;<br>
&gt;=C2=A0 Signed-off-by: Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.benne=
e@linaro.org" target=3D"_blank">alex.bennee@linaro.org</a>&gt;<br>
&gt;<br>
&gt; Reviewed-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com" target=
=3D"_blank">imp@bsdimp.com</a>&gt;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 ---<br>
&gt;<br>
&gt;=C2=A0 [AJB] I realise this is a slightly provocative patch but given h=
ow<br>
&gt;=C2=A0 widely used *-user is downstream we should be clear about the cu=
rrent<br>
&gt;=C2=A0 state and hopefully encourage those who rely on it to step-up.<b=
r>
&gt;<br>
&gt; For the bsd-user case this is likely correct. We run hot and cold abou=
t being<br>
&gt; proactive at fixing things, and we&#39;ve been somewhat cold for a whi=
le now.<br>
&gt;<br>
&gt; Part of the problem is that this submission process is very very heavy=
weight<br>
&gt; compared to other projects I contribute to. Not sure what to do about =
that since<br>
&gt; there&#39;s a reluctance to move away from it. Or alternatively, I&#39=
;m somehow making<br>
&gt; it too hard.<br>
<br>
We have discussed in the past allowing maintainers to directly submit<br>
their PRs via GitLab which would be beneficial from a testing point of<br>
view. To move this forward someone needs to propose the changes to our<br>
policy documents so it can be discussed and merged.<br>
<br>
However we still expect patches to go onto the mailing list for<br>
review. The greybeards (like myself ;-) are very wedded to the inline<br>
email workflow but if we could keep that interface while making use of<br>
the GitLab UI for those that grew up knowing only the web maybe we could<br=
>
make the project more friendly to new contributors.<br>
<br>
I&#39;d be interested in knowing where the pain points are for you because<=
br>
modern tools like b4 make some of the grind (collecting tags and<br>
applying patches from ML) a lot easier.<br></blockquote><div><br></div><div=
>I&#39;ve tried setting up b4 before. I&#39;ll have to try again.</div><div=
>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
Usually the most difficult thing is getting email setup so you can<br>
git-send-email or git-publish.<br></blockquote><div><br></div><div>The most=
 difficult part for me is &#39;where the heck did google hide the password<=
/div><div>junk today&#39; so I can turn on a password, do the submission, t=
hen kill the password.</div><div>I really wish I could do OTP sometimes.</d=
iv><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; A lot of the upstreaming work that&#39;s stalled would be ideal to tel=
l claude to do,<br>
&gt; but I&#39;m unsure the project&#39;s stance on using claude to move co=
de, and git log<br>
&gt; 5 different trees to get the original author(s) of the code and make t=
rivial compile<br>
&gt; tweaks.<br>
<br>
There was some discussion at the maintainers summit about relaxing the<br>
rules on AI submission for &quot;mechanical&quot; changes but it ran into t=
he<br>
weeds without any firm conclusion. We could certainly revisit it.<br></bloc=
kquote><div><br></div><div>Yea, it&#39;s not even mechanical changes. It&#3=
9;s copying the work from one tree to another</div><div>after that forked t=
ree has been merged to the latest upstream... There&#39;s no creativity</di=
v><div>here at all. I&#39;d be happy just having to write the commit messag=
es... the hard part is</div><div>the datamining to see who wrote things, an=
d splitting out out function by function</div><div>with dependencies for ea=
sy review...</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
I think the concern about potential license pollution is a valid one but<br=
>
this is more of a concern for &quot;novel&quot; changes made by AI. I&#39;v=
e been more<br>
relaxed on my personal FLOSS projects where I have allowed AI<br>
contributions but made it clear that the submitter is expected to<br>
understand whats going on. But being personal projects they are less<br>
likely to be spammed to death by AI slop PRs which seems to be a growing<br=
>
problem in the wider ecosystem.<br></blockquote><div><br></div><div>Yea. we=
 have a github pull request open, and we have problems from time to time,</=
div><div>but have been swift to close ai chatbots and other slop we get.</d=
iv><div><br></div><div>Warner</div><div>=C2=A0</div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">
&gt;<br>
&gt; Warner <br>
<br>
-- <br>
Alex Benn=C3=A9e<br>
Virtualisation Tech Lead @ Linaro<br>
</blockquote></div></div>

--000000000000aa12500649156970--

