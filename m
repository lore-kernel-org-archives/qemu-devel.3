Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E7F6CD5BB1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 14:02:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRsM7-0006Ht-C1; Tue, 26 May 2026 10:02:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wRsM5-0006GI-Pf
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:02:01 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wRsM3-0008AG-5r
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:02:01 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-c827313dac0so5186323a12.1
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 07:01:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779804117; cv=none;
 d=google.com; s=arc-20240605;
 b=ZBdU2tpMzG/4Y7d8PzZTq7RW3xBdW7CjC5c7EY7p558Xq5cprNQdXxfyUYueZ+ROst
 S02f6jzuZDwjWe3F3j3NdzlX2IiViVs4+g/j9TpzPuraJx+mDXgmNXO91f7IHq9hYRR7
 AB71pv0XRUCWR3+1KrUvXOc3RdfZNdyhepiqcrlpsuIY46hkIdHDBNeZOUAsYOtyOiRV
 poKS9Kaw/bM3G0PQd8xc8yThItbfoACC0eSMVFFUA7Fm3jpbpPCNuwDiSQdMO5fjn8fN
 ver/VFB5h+fK63q3fXIWmF4vDottYOGvtG5mZIL14uNB1+Vu2ekRMhh/oGqF5i8QiJWJ
 hk0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=4nrtbJp1RnwyYAQqSDFBjMposO3NP/wdFsMl3fVXHiY=;
 fh=ad/3fmeB6ZBiXBBpwBMDo5D2uwtDzHziUf1c7git1k8=;
 b=OFshH0nKbTaVfUYnlTHMWimf+sMCjQ4ZefIymKgZom9gkBUCxUBa5yqVinPsbUsum4
 1EvsuaUJM1n3uuSQqTdbxkw4hw4ykrGptk5OUWzjoUsw53ETtlaTbIcCv9k2klljt/Mw
 kYDC2QGNgiyOUFYhwO0LV+Pjuzti50apF5X0BvosBWq5BgC0F2ZC2MuAxQJ4o3vbTQ07
 maHOcCmw4ovfqWK1teXlxsvZslX4JbHMGohMOeut3q7w0Z/VcMQG+HAtbaaNZAKw39i2
 p3yHcHjFJgLNUQCUnuDb4z3gvwxOupKxcyuT0Th+n1DpUiJBDfsdoxUsRVa0jrYvAvKl
 q/UQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1779804117; x=1780408917;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4nrtbJp1RnwyYAQqSDFBjMposO3NP/wdFsMl3fVXHiY=;
 b=scyoPUQiCRn28VE8TFrY/8AFfA3w2JmZ72MvXNxkywr8khsE/FSbkPt716gvRjhSnM
 tN8rnct8e6uwAaGNRKvN1Lstw3dlszu+PKGWBd4zNzxBqNndF/Te5byTypyARboU7WDS
 x2jlhhjuEnwYtElTdRB51gMdzLpPYKRwpZ648uHAUCfWAQh9tSn2/g/uSTrUv5enrsoK
 ABfva0HJ4Wa0627m0CN+G9Ew+zj3pm574EV15zkURQhQN5y8F/xz+fybEGlzEx1uWCVT
 91kXrZVL3M8C97OrVOs+YUsCZ8SJFPLojr2GsOro0IFfA7kLqCOXaBoXJetxJ6o9TNa7
 wAmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779804117; x=1780408917;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4nrtbJp1RnwyYAQqSDFBjMposO3NP/wdFsMl3fVXHiY=;
 b=LQiGJURaTT1UXz0+PzNLUJ11K7nGUKRb3GdFWv/RxM2UqQhmmaFxSPQon6t40Ok7BZ
 kJdl0wryDny73Y3NCn7ZFVvqqnK3vttQavfgSMb9k+JAgkB7tWUZKJUpz0xExUqwPADR
 aDAbYz2C6gtTMRAD0N6GbIeReB+r9xpcWE297V7mJhcTUliRsAIjEprArLpO5OsR5VAX
 gBUkupPx59eO8LzM8ViEV9obt75aNbbtrsBIkqSiJnA2G0dwngU/2HJb7bTCdYV/wBh6
 Ui/D9ajxBjBGdEzP4oeFhWu8DuJiU4nY6bwRObkXAm+PZQcsWHRE0Gp3sU8K5TDfz5G1
 SubQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ96EvXDDdURIvbfyhDNE1yBH0WbAiV9p06j5viFOXOmh/e0kgyLXzdnBJGPPBjd8oJqdQMS4+svBGWL@nongnu.org
X-Gm-Message-State: AOJu0YwtFFgEeKfmyCVFrVjiRQDAOK0yQwmgZak8OSVYEU32phEvcAx2
 G6nJkERscEydx7XuH4mGKBmD2ohWWvmyeSpskDtemt0Cvy6WIFelHFz0M/yqPwkfScbJr2Qy8E6
 e/KhaZ/MFaPYSfeoZ0axNxbxqgWsCPBsyR5scuXpfzCGSMSPpgMLS
X-Gm-Gg: Acq92OE8bQ2qhdVxnEiNGkWViDxAizK23kopBpzdoVcmpdknmK55kNqu3HeMllNDNbb
 soXRiCAXss++ZNVLGp9d1ReCbvFW6VfveCeuVFRaN4J2xV1jAs97ZxsQBScXwl6Tyud02BmQ4D6
 gGcjgSCTOaCq2Oo6q2+tizql/6Wp0DE0duo7Lp5SZZt4BGWtgNY6FHAiuXLdLeG6mYhtqY3XtAT
 vrTL8KblCNjFvGKsAF7lyB2P/WHniDGEcCSuEkrUlIuRHn4wplNrseK7U6r6+vXhQSt9pzmDdVN
 M163CMOzcdcPpgcMgfH7wunwmSGQVJLBxLrl
X-Received: by 2002:a05:6a21:68e:b0:35d:cc9a:8bc1 with SMTP id
 adf61e73a8af0-3b329806c52mr14613534637.27.1779804115372; Tue, 26 May 2026
 07:01:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260524083329-mutt-send-email-mst@kernel.org>
 <f0bc9023-28c4-4685-b0cc-fc7ad4e6d371@redhat.com>
 <CAFEAcA9wMRFJWrjGHcd2nfhgXovyuS=dDJvCXWZkgmD_eez27A@mail.gmail.com>
 <CABgObfYSy-sctHcUW3hPxQZ8ZGOYHLi3HaW+FrEQ9kKitMAVZg@mail.gmail.com>
 <e875fb45-9697-a6d0-fbe0-d0531eb2c911@eik.bme.hu>
 <CAJSP0QWt_xB9a7UG3nved=m_5-Qmxy8qeAofh4c1M3a6qJanMQ@mail.gmail.com>
In-Reply-To: <CAJSP0QWt_xB9a7UG3nved=m_5-Qmxy8qeAofh4c1M3a6qJanMQ@mail.gmail.com>
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 26 May 2026 08:01:43 -0600
X-Gm-Features: AVHnY4LJFv1WRjscxQPvpw-sovSfx_rRmF3aJAaWtQVMDrps16EkV6zUs7t0jL8
Message-ID: <CANCZdfo9VJtj3ZPhnnLNB5OOhoEQEDvCjVQcdXp2gV-_7ru_oQ@mail.gmail.com>
Subject: Re: on ai generated and code provenance
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 qemu-devel <qemu-devel@nongnu.org>, "Hajnoczi, Stefan" <stefanha@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000111b1d0652b8f0da"
Received-SPF: none client-ip=2607:f8b0:4864:20::52a;
 envelope-from=wlosh@bsdimp.com; helo=mail-pg1-x52a.google.com
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

--000000000000111b1d0652b8f0da
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2026, 7:24=E2=80=AFAM Stefan Hajnoczi <stefanha@gmail.com> =
wrote:

> On Tue, May 26, 2026 at 7:28=E2=80=AFAM BALATON Zoltan <balaton@eik.bme.h=
u> wrote:
> > On Tue, 26 May 2026, Paolo Bonzini wrote:
> > > Il mar 26 mag 2026, 10:23 Peter Maydell <peter.maydell@linaro.org> ha
> > > scritto:
> > >
> > >>> Personally I think QEMU's
> > >>> policy is fine but we should start introducing exceptions, possibly
> > >>> including large contributions with pre-authorization (but not
> > >>> pre-approval) from the maintainer.
> > >>
> > >> I want to note that [...] while we were essentially in the "blanket
> ban"
> > >> state anyway, there was no particular need to have the discussion
> about
> > >> other reasons we might also want to be restrictive or cautious about
> AI
> > >> contributions, but those other reasons and viewpoints don't go away
> > >> automatically with the legal one.
> > >>
> > >> I have quite a lot of sympathy with the rationale behind the Zig
> policy,
> > >> for instance: https://kristoff.it/blog/contributor-poker-and-ai/ I
> spend
> > >> quite a lot of time reviewing patches for things which are features =
I
> don't
> > >> necessarily personally care about. I'm happy with doing that for oth=
er
> > >> people who are hopefully learning and gaining something from the
> process;
> > >> I'm much less interested in reviewing a mountain of LLM-generated
> patches.
> > >>
> > >
> > > I agree and that's a good argument for pre-discussion with the
> maintainers.
> > > It would anyway be the right thing to do for large contributions, but
> it's
> > > even more important with AI given the different balance between
> contributor
> > > and reviewer.
> >
> > I think the real problem is people who don't know what they are doing y=
et
> > use an AI to generate a patch and submit it anyway. Reviewers are then
> > flooded with nonsense that they have to look at to find out if there's
> > anything useful in it which takes their time from doing more useful
> > things. So the policy should make clear that we don't accept patches
> > generated by AI that no human has read and understood before submission
> > and adding a S-o-b should also mean (besides that the submitter made su=
re
> > there's no copyright infringement) that that person has knowledge about
> > the patch and is willing to correct it. Then reviewers can just bounce =
AI
> > nonsense back to the conrtibutor or ignore it if they don't reply (or
> > reply with more AI nonsense suggesting they don't know what the patch
> does
> > so can't correct it). I think that's the real fear that has led to the =
AI
> > ban and the copyright issues were just a convenient excuse. Maybe
> > clarifying this in the policy could be done although there will always =
be
> > people who ignore documents. So maybe what we want is no direct
> submission
> > of AI generated patches without at least a human inbetween who has
> already
> > reviewed tha patch before sending it to the list.
>
> That sounds reasonable.
>

I agree.

And for large submission we can have a smaller limit for AI or other poorly
explained code.

Warner

>

--000000000000111b1d0652b8f0da
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, May 26, 2026, 7:24=E2=80=
=AFAM Stefan Hajnoczi &lt;<a href=3D"mailto:stefanha@gmail.com">stefanha@gm=
ail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On Tue, May =
26, 2026 at 7:28=E2=80=AFAM BALATON Zoltan &lt;<a href=3D"mailto:balaton@ei=
k.bme.hu" target=3D"_blank" rel=3D"noreferrer">balaton@eik.bme.hu</a>&gt; w=
rote:<br>
&gt; On Tue, 26 May 2026, Paolo Bonzini wrote:<br>
&gt; &gt; Il mar 26 mag 2026, 10:23 Peter Maydell &lt;<a href=3D"mailto:pet=
er.maydell@linaro.org" target=3D"_blank" rel=3D"noreferrer">peter.maydell@l=
inaro.org</a>&gt; ha<br>
&gt; &gt; scritto:<br>
&gt; &gt;<br>
&gt; &gt;&gt;&gt; Personally I think QEMU&#39;s<br>
&gt; &gt;&gt;&gt; policy is fine but we should start introducing exceptions=
, possibly<br>
&gt; &gt;&gt;&gt; including large contributions with pre-authorization (but=
 not<br>
&gt; &gt;&gt;&gt; pre-approval) from the maintainer.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; I want to note that [...] while we were essentially in the &q=
uot;blanket ban&quot;<br>
&gt; &gt;&gt; state anyway, there was no particular need to have the discus=
sion about<br>
&gt; &gt;&gt; other reasons we might also want to be restrictive or cautiou=
s about AI<br>
&gt; &gt;&gt; contributions, but those other reasons and viewpoints don&#39=
;t go away<br>
&gt; &gt;&gt; automatically with the legal one.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; I have quite a lot of sympathy with the rationale behind the =
Zig policy,<br>
&gt; &gt;&gt; for instance: <a href=3D"https://kristoff.it/blog/contributor=
-poker-and-ai/" rel=3D"noreferrer noreferrer" target=3D"_blank">https://kri=
stoff.it/blog/contributor-poker-and-ai/</a> I spend<br>
&gt; &gt;&gt; quite a lot of time reviewing patches for things which are fe=
atures I don&#39;t<br>
&gt; &gt;&gt; necessarily personally care about. I&#39;m happy with doing t=
hat for other<br>
&gt; &gt;&gt; people who are hopefully learning and gaining something from =
the process;<br>
&gt; &gt;&gt; I&#39;m much less interested in reviewing a mountain of LLM-g=
enerated patches.<br>
&gt; &gt;&gt;<br>
&gt; &gt;<br>
&gt; &gt; I agree and that&#39;s a good argument for pre-discussion with th=
e maintainers.<br>
&gt; &gt; It would anyway be the right thing to do for large contributions,=
 but it&#39;s<br>
&gt; &gt; even more important with AI given the different balance between c=
ontributor<br>
&gt; &gt; and reviewer.<br>
&gt;<br>
&gt; I think the real problem is people who don&#39;t know what they are do=
ing yet<br>
&gt; use an AI to generate a patch and submit it anyway. Reviewers are then=
<br>
&gt; flooded with nonsense that they have to look at to find out if there&#=
39;s<br>
&gt; anything useful in it which takes their time from doing more useful<br=
>
&gt; things. So the policy should make clear that we don&#39;t accept patch=
es<br>
&gt; generated by AI that no human has read and understood before submissio=
n<br>
&gt; and adding a S-o-b should also mean (besides that the submitter made s=
ure<br>
&gt; there&#39;s no copyright infringement) that that person has knowledge =
about<br>
&gt; the patch and is willing to correct it. Then reviewers can just bounce=
 AI<br>
&gt; nonsense back to the conrtibutor or ignore it if they don&#39;t reply =
(or<br>
&gt; reply with more AI nonsense suggesting they don&#39;t know what the pa=
tch does<br>
&gt; so can&#39;t correct it). I think that&#39;s the real fear that has le=
d to the AI<br>
&gt; ban and the copyright issues were just a convenient excuse. Maybe<br>
&gt; clarifying this in the policy could be done although there will always=
 be<br>
&gt; people who ignore documents. So maybe what we want is no direct submis=
sion<br>
&gt; of AI generated patches without at least a human inbetween who has alr=
eady<br>
&gt; reviewed tha patch before sending it to the list.<br>
<br>
That sounds reasonable.<br></blockquote></div></div><div dir=3D"auto"><br><=
/div><div dir=3D"auto">I agree.</div><div dir=3D"auto"><br></div><div dir=
=3D"auto">And for large submission we can have a smaller limit for AI or ot=
her poorly explained code.</div><div dir=3D"auto"><br></div><div dir=3D"aut=
o">Warner</div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_cont=
ainer"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-=
left:1px #ccc solid;padding-left:1ex"></blockquote></div></div><div dir=3D"=
auto"><div class=3D"gmail_quote gmail_quote_container"><blockquote class=3D=
"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding=
-left:1ex">
</blockquote></div></div></div>

--000000000000111b1d0652b8f0da--

