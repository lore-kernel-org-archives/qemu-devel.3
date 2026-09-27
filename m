Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0257AC9832F
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 20:34:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAvYl-0006cy-SF; Sun, 27 Sep 2026 16:33:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1xAvYg-0006cq-8g
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 16:33:15 -0400
Received: from mail-pz2-x2a.google.com ([2607:f8b0:4864:3b::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1xAvYd-0005Np-K8
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 16:33:14 -0400
Received: by mail-pz2-x2a.google.com with SMTP id
 d2e1a72fcca58-883a16b758dso21838b3a.1
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 13:33:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790541189; cv=none;
 d=google.com; s=arc-20260327;
 b=KdC2reynoFc88zfM4Rm5p4KdEPWIRk6pzyyPMJJIP1s4fblZQc6UElkQBdFAmKhCbt
 LUzcI/fZLhSJrgldUHBR+3bXcLEpBDXleDup9YyJgSkOvwpTykF4cd3Ecdx6BASuM2zU
 2Z2KJcxE7F4jhdkgroSRUp+V1d6uKC8D/E85Pfo1wIUQEshVICdV2JXNl/9eI1JeRbpm
 ey7vKCbOWsMia1qVlsR05F53kp/+cU5Akgwb7U85iAUCgSyI/ZbebRdxBwJ+A5lJsu6R
 XSdM7pkI1N21U5eUTwa67+8f02F1MyJsuBHT60BS4ssmWZu3gsBmji/BuanBZUWQVT46
 pEvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=LmiAhYoAzMlMCCHzqR0iDegGO+JM5hOLSU7wUEzIe5I=;
 fh=c35z3VH4CHQwBTzlGjvgfMJH6NPf0YEMm/crc/VDn88=;
 b=og1vm4Ed23hfsM1g5Jio/UrB4NCbBCfrsqnWRHAvozSuW2vsqlSd7f1za3+5huVf7O
 j5IqLiBTQ0JohWcsqfAz5+eS5YLhrC90F8ktOhT79kuIZpvypaRTFCHCFASvnZ7zOqhn
 Zfx9vxDsl8PpoONM1bixR5AH2w/cD5CiFf0CeCxoD3rKdEFE1C4PDAjGjOZQCSdNyKnO
 MBigJgrXZzxVCfQTnHWeeM+l2Xe1Ofo1F1dMXsIP/iP9F5tUVKvJu2q5NGFLb3XLdZJE
 0uj2qKz/GIoxmd+HK5uJoaquo1HjBGsXQyLYpXe2Fd9ZqrPL6Dg2LopUoH0iaksIwGdI
 5wBg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1790541189; x=1791145989;
 darn=nongnu.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=LmiAhYoAzMlMCCHzqR0iDegGO+JM5hOLSU7wUEzIe5I=;
 b=PjE2ZEqUm1AJ+9ccozWIwhKzJzBE/82e4DHk2CrOqonsGbRq8mKw6H6asjC95kAx5U
 CCxPIbsr3h8MBLGEeg8uVbwScKtDN+SM+2ki8YDd0vxm7VpEr0u4EKTyQqbiYETQg65s
 XT/jhtOHCJZ9VsrgyhZxUB32Y9TWV6IvP0pArXNSevdiyLnHSeJIj/bAMmyPMEf7oJDI
 EL3879x+sblODSVdnvo5NEBLM3n2moZcwnphNKAzqDLub+CTIHQv8rPVYRrA/2GWHayJ
 w1jFEM8nkNaGDS1bIps5SaU2SRPKcNn4SdO3Djjrfb67CNKSoeuUiLO1lLYouodIZ47d
 D1Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790541189; x=1791145989;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=LmiAhYoAzMlMCCHzqR0iDegGO+JM5hOLSU7wUEzIe5I=;
 b=zDQQ9Osf4tIlvKyntj5TUseR2HFQMFQkh9g/0KSPV1mxVTjz8ZPFoQ+/i6vflGKSin
 3IFsTOinu35OXitq7No651AO2yjd0t5dSsmv4VVf9uIIi16HasvPNSHHdh4rV3S4OScB
 FpwIfS1wMeAHC3JPGiy7hcsEfqeTXCAEF9NaW4Ex8RzvZDJAzeHv8QtarySDkZOgnANx
 OR8BFeNN8XkagLhSB0Pa6WOxKEeEe9apsJdQQ/HZOSf8yTuUAlpmib/vLHWvha34E43l
 1KGUD8op1DlXi9lv6CtqhFzkbria049YhUqNH4GSvi1m+gwO2nV+Sm1GSYeDSsd13n9X
 jv+Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBz+Ry+H/veFnBRjbID5GNTZfR03C98GKIRh495ExVs6SYNwMveXiGNpGU/wqItD4k9Zzfe9y4ywGaUQ@nongnu.org
X-Gm-Message-State: AFuF++kzjMV5pfyDL4h7EICqRTKJ/8Z+NGhR8ekzXbrJ+N0/EGdzvqL8
 4Lgb7cw2tmKkh69HdRREcnaiJGXvdSiaziKrZgGqQmd54kF3ooluEU+OqesBbqafnHN292FYgAP
 xrFuBAwH9fngGSLfbm5yAp+IVaiZ4wI9TcOINzsVTKQ==
X-Gm-Gg: AYBFou30/HHWtAnCSEJvCBqpa2Dn62dIU1cuDeJUp7qWT3reyKXxEIg2SVjYoUgND+5
 qduga3iOANUAcvaPXdHENoZdO3WZeN9ltwE9cEFvFOmwB3GGOca18mFhbvT8WN5Ptg155aozxEo
 L7EzSwa2hLfRuE5ftofhtPHeOgPgmN4XgJF9H5WHRD7yrQH3zSwj0l+bI1fOOD1PkNP5oVCEUMO
 lE9xAzqeKls8kPNSwIRu/AC2WpVlX9qel9pZj8ppxXR9xRtCQX9C5h7gfekInhVuF7wNIn3aIrt
 udeX+NlcBxiNb+ClqVSPhQDOR/IsCysZ12yMLitDBG3x5WWGp/hiFbkn
X-Received: by 2002:a05:6a00:4501:b0:880:89cd:8c99 with SMTP id
 d2e1a72fcca58-88089cd8e2emr3765867b3a.25.1790541189253; Sun, 27 Sep 2026
 13:33:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260921075251.12831-1-pbonzini@redhat.com>
 <20260927123441-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260927123441-mutt-send-email-mst@kernel.org>
From: Warner Losh <imp@bsdimp.com>
Date: Sun, 27 Sep 2026 14:32:57 -0600
X-Gm-Features: AclHuK91ncCJvNSQjGTSLf5NaJtKSVL5vGMvF0v0K-ZxYWRHCJE_TD3rO8ulWDE
Message-ID: <CANCZdfqF6YBNXjOq4XQ8KJqwhkr=jDb9jUAsbtTf27z8MgaNww@mail.gmail.com>
Subject: Re: [RFC PATCH v3 0/4] docs/devel, AGENTS.md: a completely new policy
 on AI-generated contributions
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Alistair Francis <alistair.francis@wdc.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000008a9d94065c7cdb2a"
Received-SPF: none client-ip=2607:f8b0:4864:3b::2a;
 envelope-from=wlosh@bsdimp.com; helo=mail-pz2-x2a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

--0000000000008a9d94065c7cdb2a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 27, 2026 at 10:39=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com=
> wrote:

> On Mon, Sep 21, 2026 at 09:52:47AM +0200, Paolo Bonzini wrote:
> > WARNING: this is *intentionally* a full U-turn from the previous policy
> > and discussions.  This is not a refusal of the arguments presented in
> > those discussions.  Also, it is still a request for comments.
> >
> > I've explained in v2 my reason to "try something else".  On one hand
> > attempting to introduce small carve-outs did not work due the
> impossibility
> > of reaching a widespread consensus on this topic.  On the other hand,
> > some contributors have been posting AI-generated patches or even larger
> > series, most likely in good faith as they predated the introduction
> > of an AGENTS.md file.  This shows that AI can be used for useful work
> > on QEMU, ranging from small incremental improvements to new device
> models.
> >
> > This is not a free-for-all, which is not a good idea either.  Maintaine=
rs
> > will want to apply their own considerations (see [1] for a good list),
> > and contributors should take into account the maintainers' preferences.
> >
> > This is an attempt at building a process for contributions that use AI,
> > heeding Conservancy's advice to not shun contributors or maintainers
> > belonging to either camp, and keeping in mind that maintainer burnout
> > is the one thing we have to avoid.  Some of these processes already
> > existed, but the possibility of AI contribution makes it all more
> > important to write them down for everyone.
> >
> > There was not much discussion in the previous version.  I tried to rein
> > in some of the language that allowed too wide interpretations, to apply
> > the changes that were suggested, and to clarify those choices that drew
> > more remarks.
> >
> > As usual, the text including the commit messages is informed by
> discussion
> > with plenty of people, mentioned in the Cc trailers of patch 1.
> >
> > Paolo
>
>
>
> Something that we maybe should do, is to ask that
> agent does not repeat, verbatim, code from outside
> of qemu.
>
> would not help in 100% of cases but hey.
>

In a similar vain, do we want to call out *NOT* adding reviewed by: claude
or similar?
(assuming I'm up on the consensus view). I don't recall seeing this in the
changes so far.

Warner


> > v2->v3:
> > - remove parser example, replace with "adaptations of existing code"
> > - when LLMs are used for boilerplate, "highly recommend" disclosure
> >   for "non-trivial, functional code".  The idea here is to avoid
> >   having to disclose using AI to apply e.g. changes related to
> >   automatic code review, and leaving people some leeway.
> > - clarify split between DCO (legal right to submit code in general)
> >   and AI-used-for acknowledging that the submitter cannot audit LLM
> >   output against e.g. the training data.
> > - clarify the defense-in-depth/swiss-cheese approach to limit the
> >   risk of copyright violations from LLM output
> > - mention that pre-arrangement is not an entirely new concept
> > - mention that maintainers can demand larger changes than for
> human-written code
> > - do not mention inclusion of the prompt
> > - add checkpatch.pl hunk, changing the phrasing of "no AI" lint
> > - rebase AGENTS.md on top of existing file, split
> > - drop CLAUDE.md/GEMINI.md symlinks, already done via .claude/.gemini
> >
> > [1]
> https://lore.kernel.org/qemu-devel/CAFEAcA860fF_+ffk=3DcXiYyFoQo0wCSUJ6b=
=3D7nVLLCwKhP6Nwxw@mail.gmail.com/
> >
> > Paolo Bonzini (4):
> >   docs/devel: relax policy on AI-generated contributions
> >   AGENTS.md: add final instructions
> >   AGENTS.md: let agents know what the participation rules are
> >   AGENTS.md: make the human part of the design process
> >
> >  docs/devel/code-provenance.rst |  71 +-----------
> >  docs/devel/index-process.rst   |   1 +
> >  docs/devel/llm-usage.rst       | 202 +++++++++++++++++++++++++++++++++
> >  AGENTS.md                      | 137 +++++++++++++++++++---
> >  scripts/checkpatch.pl          |   5 +-
> >  5 files changed, 336 insertions(+), 80 deletions(-)
> >  create mode 100644 docs/devel/llm-usage.rst
> >
> > --
> > 2.55.0
>
>

--0000000000008a9d94065c7cdb2a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Sun, Sep 27,=
 2026 at 10:39=E2=80=AFAM Michael S. Tsirkin &lt;<a href=3D"mailto:mst@redh=
at.com">mst@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">On Mon, Sep 21, 2026 at 09:52:47AM +0200, Paolo Bonzi=
ni wrote:<br>
&gt; WARNING: this is *intentionally* a full U-turn from the previous polic=
y<br>
&gt; and discussions.=C2=A0 This is not a refusal of the arguments presente=
d in<br>
&gt; those discussions.=C2=A0 Also, it is still a request for comments.<br>
&gt; <br>
&gt; I&#39;ve explained in v2 my reason to &quot;try something else&quot;.=
=C2=A0 On one hand<br>
&gt; attempting to introduce small carve-outs did not work due the impossib=
ility<br>
&gt; of reaching a widespread consensus on this topic.=C2=A0 On the other h=
and,<br>
&gt; some contributors have been posting AI-generated patches or even large=
r<br>
&gt; series, most likely in good faith as they predated the introduction<br=
>
&gt; of an AGENTS.md file.=C2=A0 This shows that AI can be used for useful =
work<br>
&gt; on QEMU, ranging from small incremental improvements to new device mod=
els.<br>
&gt; <br>
&gt; This is not a free-for-all, which is not a good idea either.=C2=A0 Mai=
ntainers<br>
&gt; will want to apply their own considerations (see [1] for a good list),=
<br>
&gt; and contributors should take into account the maintainers&#39; prefere=
nces.<br>
&gt; <br>
&gt; This is an attempt at building a process for contributions that use AI=
,<br>
&gt; heeding Conservancy&#39;s advice to not shun contributors or maintaine=
rs<br>
&gt; belonging to either camp, and keeping in mind that maintainer burnout<=
br>
&gt; is the one thing we have to avoid.=C2=A0 Some of these processes alrea=
dy<br>
&gt; existed, but the possibility of AI contribution makes it all more<br>
&gt; important to write them down for everyone.<br>
&gt; <br>
&gt; There was not much discussion in the previous version.=C2=A0 I tried t=
o rein<br>
&gt; in some of the language that allowed too wide interpretations, to appl=
y<br>
&gt; the changes that were suggested, and to clarify those choices that dre=
w<br>
&gt; more remarks.<br>
&gt; <br>
&gt; As usual, the text including the commit messages is informed by discus=
sion<br>
&gt; with plenty of people, mentioned in the Cc trailers of patch 1.<br>
&gt; <br>
&gt; Paolo<br>
<br>
<br>
<br>
Something that we maybe should do, is to ask that<br>
agent does not repeat, verbatim, code from outside<br>
of qemu.<br>
<br>
would not help in 100% of cases but hey.<br></blockquote><div><br></div><di=
v>In a similar vain, do we want to call out *NOT* adding reviewed by: claud=
e or similar?</div><div>(assuming I&#39;m up on the consensus view). I don&=
#39;t recall seeing this in the changes so far.</div><div><br></div><div>Wa=
rner</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">
&gt; v2-&gt;v3:<br>
&gt; - remove parser example, replace with &quot;adaptations of existing co=
de&quot;<br>
&gt; - when LLMs are used for boilerplate, &quot;highly recommend&quot; dis=
closure<br>
&gt;=C2=A0 =C2=A0for &quot;non-trivial, functional code&quot;.=C2=A0 The id=
ea here is to avoid<br>
&gt;=C2=A0 =C2=A0having to disclose using AI to apply e.g. changes related =
to<br>
&gt;=C2=A0 =C2=A0automatic code review, and leaving people some leeway.<br>
&gt; - clarify split between DCO (legal right to submit code in general)<br=
>
&gt;=C2=A0 =C2=A0and AI-used-for acknowledging that the submitter cannot au=
dit LLM<br>
&gt;=C2=A0 =C2=A0output against e.g. the training data.<br>
&gt; - clarify the defense-in-depth/swiss-cheese approach to limit the<br>
&gt;=C2=A0 =C2=A0risk of copyright violations from LLM output<br>
&gt; - mention that pre-arrangement is not an entirely new concept<br>
&gt; - mention that maintainers can demand larger changes than for human-wr=
itten code<br>
&gt; - do not mention inclusion of the prompt<br>
&gt; - add <a href=3D"http://checkpatch.pl" rel=3D"noreferrer" target=3D"_b=
lank">checkpatch.pl</a> hunk, changing the phrasing of &quot;no AI&quot; li=
nt<br>
&gt; - rebase AGENTS.md on top of existing file, split<br>
&gt; - drop CLAUDE.md/GEMINI.md symlinks, already done via .claude/.gemini<=
br>
&gt; <br>
&gt; [1] <a href=3D"https://lore.kernel.org/qemu-devel/CAFEAcA860fF_+ffk=3D=
cXiYyFoQo0wCSUJ6b=3D7nVLLCwKhP6Nwxw@mail.gmail.com/" rel=3D"noreferrer" tar=
get=3D"_blank">https://lore.kernel.org/qemu-devel/CAFEAcA860fF_+ffk=3DcXiYy=
FoQo0wCSUJ6b=3D7nVLLCwKhP6Nwxw@mail.gmail.com/</a><br>
&gt; <br>
&gt; Paolo Bonzini (4):<br>
&gt;=C2=A0 =C2=A0docs/devel: relax policy on AI-generated contributions<br>
&gt;=C2=A0 =C2=A0AGENTS.md: add final instructions<br>
&gt;=C2=A0 =C2=A0AGENTS.md: let agents know what the participation rules ar=
e<br>
&gt;=C2=A0 =C2=A0AGENTS.md: make the human part of the design process<br>
&gt; <br>
&gt;=C2=A0 docs/devel/code-provenance.rst |=C2=A0 71 +-----------<br>
&gt;=C2=A0 docs/devel/index-process.rst=C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 docs/devel/llm-usage.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0| 202 +++++++=
++++++++++++++++++++++++++<br>
&gt;=C2=A0 AGENTS.md=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 | 137 +++++++++++++++++++---<br>
&gt;=C2=A0 scripts/<a href=3D"http://checkpatch.pl" rel=3D"noreferrer" targ=
et=3D"_blank">checkpatch.pl</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
=C2=A05 +-<br>
&gt;=C2=A0 5 files changed, 336 insertions(+), 80 deletions(-)<br>
&gt;=C2=A0 create mode 100644 docs/devel/llm-usage.rst<br>
&gt; <br>
&gt; -- <br>
&gt; 2.55.0<br>
<br>
</blockquote></div></div>

--0000000000008a9d94065c7cdb2a--

