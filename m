Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15C41CD5BB1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 14:40:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRswl-0003cD-OX; Tue, 26 May 2026 10:39:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wRswi-0003bv-I1
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:39:52 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wRswf-0006Yv-An
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:39:51 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2be75f658f3so54528245ad.1
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 07:39:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779806386; cv=none;
 d=google.com; s=arc-20240605;
 b=KhLbxqeNSyn9MFTSWk9GoctusrgwWwl4rhSMO1dVXrLD6JlC7TWy9SH5pKsQeKtlss
 EPI12IBWR/K89qNHihQ41eO/7hYM9Rkx8QS/9GXsnO/SyuHBR7AK5cvoWpE3bzcwN3te
 bAaeNssepI51g2WuHmMk8sfMjeuo01vV37Tinaq1luv9KYmtet53O/p7lookqNRA7wrw
 vptJ6nQtApAS8LbaBBKMahbaroM3bpj8y9WA79hm/qUebGSuaWZGjwp4BCKRuKfjkGTS
 cn94E5Tttg8lp2hV3K/ggTDwX1YULaHKHgnb0+To5wQdHDd/ym3tbwsNHTCh4xLmh3mW
 2Fzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=3qZRhSPRSsCAAgZhbiVpMXGCD0KuME3Ah8i+pfcm4B4=;
 fh=i7n7yFxVJwI9pZ8YevroTv1Xgfs6QvvDuaANtvA+rTY=;
 b=XlvUvcfr4lXPk6CN11wzLE2gsWQfwraY5cDTwuB1Jy2zKj0bYNcHz10jMaJb0ZjHnu
 HFfghwBOQRGcCSWkouFbjuyWQcRwJmt3mK8AtXTA6Px1VvrPNDx9zumDEBmK5Psq81BQ
 HCAqvM6kpR3KaMkfOkw8lr+afxlm8lHC+MLj/j36fBi+3XOw4cUjjS9cU+vJ6NxI+uG+
 EHvj7dhQRffTColBK6AeoE5ifo4V0qm9gDnp2E54D9z9e+H+cN3iRLdOsnPs2h0IxK1a
 3oDFlwFknBzoKgvLof7aIa1FdsF7cR/Ou7hAWo/e/VP00fIOBAMbLnS7Luip82f/i801
 JxAw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1779806386; x=1780411186;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3qZRhSPRSsCAAgZhbiVpMXGCD0KuME3Ah8i+pfcm4B4=;
 b=ZrdNRvqmJxdHQM8blPhIRje+jKAnrnE5MoznwsQCrqXPXjcAGBG8rWpAYQthPYQFzY
 aUMJy/F7r/1yZnqC43z5rnOXVUsS2WP8TXps9f5QFQSazkLIMfsKVWjfwnA7FJRZfjez
 9OeAQ3UxOYFeXg0r9Vx127F91y5IIHDgdcRaaKa++2pPmcnQYrgBbJBAqBS1V9Ps9jQN
 oXaCre+sbz0YFIvTh4zXZFH7gfp0bO7Upca7r2TvUbwWegh5u2tQQG5Av8zUoJuqdKBi
 DANXetxX4a2+SBrckozNrgN4LCo4w9xGnqWOzWM2McRG4XdL2uAUXa0jxOHD0ZNKBdFh
 TYaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779806386; x=1780411186;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3qZRhSPRSsCAAgZhbiVpMXGCD0KuME3Ah8i+pfcm4B4=;
 b=Q0bGBEW1oUZDvUaiTWpPy/uhnnQyKLQlloxYHkv2/DsY0Rjrs4K8fNVbrQcm01CUKZ
 RsmlczkzmiYLzctDB2w9IwaRv1wPYGKnerpj82w7XfTmTtqOFzaZKIkT7sLD29goKYus
 hiVg9IFJyR3cA8KNlw0OqfQgYMKnYokNRQBI5cr+50cc8D5FE5p0+e61x58bjj5LDKUK
 EqvINjz0gA1xAF8XVPK/AborehL5ld3+hgjVicoz0+1qlPlg/h2K4SD3u/Y32uCoZnG5
 cgL6NusVTmzMsRXMt1i2e43cDM+LuZH4k7qJAHgReqZJIicAm5hrLHazx/TaUTQeXEmg
 YN5w==
X-Forwarded-Encrypted: i=1;
 AFNElJ9UIzjrEmC4KrQglmxgK5LNbZyWnOe4SJ4VPdj6WVsjpTR8LishEOxkvpsUqI1HBT7fJf+OIsIEaq6D@nongnu.org
X-Gm-Message-State: AOJu0YzCaj1/de4UmaS38fWYinHHuK9NVcd/zQ/8kMISQ7G9Wpt+hCj4
 OkH6E5hlJa49PiGeABizytuboaSx+gnHeQfOlVEybFzWVYBdhm+EIUvA/0qu7qAKRs0LB2ORItY
 UV1KeMrNsPYs3lCGrxAx1Mxj1tJLp4bfj0YRgT9QF3Q==
X-Gm-Gg: Acq92OFO1axGzlgYY5eLpNFmQK3luSqc8F0WrN4ML0qKkMTaeOK3OlTb0+IhJ6eHXlR
 wUlxHIQ7nmukfJzJypsbMIwpxWSHCa0VQNMLX/t1aXFgIdXsclIqSBBQ98rTswisNAXjCbALyi0
 LriYlX/YLenLrrruWL03FY/7mwUduUcspx/OJpqgFo/E4FH4Dvc04Gdz7gtHfeF/3qpLpvmD4nB
 dRhsbDt8XFtaFPYmmzl/6GRlfq7JPtQlA02GJhF2pFB+XyQkkQxniidbFDovod5Ab+wLDAWhPVv
 M5kLOBE=
X-Received: by 2002:a17:903:240a:b0:2bc:cb56:123a with SMTP id
 d9443c01a7336-2beb0701cf6mr196887105ad.15.1779806386197; Tue, 26 May 2026
 07:39:46 -0700 (PDT)
MIME-Version: 1.0
References: <CANCZdfr6xs9n8sF8AXVWVu9i2_rViKErrMHAVbopnaor4uCN6A@mail.gmail.com>
 <875x8g1pmi.fsf@draig.linaro.org>
 <CANCZdfqT7r9jcTuiwe3=CcjRExL-FP1msx-Q8ftQM5amJ_t0YQ@mail.gmail.com>
 <1795fc9c-f82e-40f1-aab6-ec24ad02a918@linaro.org>
In-Reply-To: <1795fc9c-f82e-40f1-aab6-ec24ad02a918@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 26 May 2026 08:39:35 -0600
X-Gm-Features: AVHnY4IYl4pk5jZNcq6Rx2ngl9Y_P7FbgYvhU2_HYC1f9g53XqxeXom_RETiHCY
Message-ID: <CANCZdfp=mCp89NdwVzy-tEo=FNiEu6_H79r5vFRD0-Nk=Cx54Q@mail.gmail.com>
Subject: Re: Question about tb_flush()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 QEMU Developers <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="0000000000006b24530652b97797"
Received-SPF: none client-ip=2607:f8b0:4864:20::62a;
 envelope-from=wlosh@bsdimp.com; helo=mail-pl1-x62a.google.com
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

--0000000000006b24530652b97797
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2026 at 1:53=E2=80=AFAM Philippe Mathieu-Daud=C3=A9 <philmd=
@linaro.org>
wrote:

> On 24/5/26 18:57, Warner Losh wrote:
> > On Sun, Feb 1, 2026 at 7:54=E2=80=AFAM Alex Benn=C3=A9e <alex.bennee@li=
naro.org>
> wrote:
> >
> >> Warner Losh <imp@bsdimp.com> writes:
> >>
> >>> OK. I've updated bsd-user fork from last year to yesterday. I had one
> >> question.
> >>>
> >>> I see that we've gone from tb_flush() to queue_tb_flush(). Why was
> that?
> >> And is it a drop in?
> >>> FreeBSD's fork has this in the thread creation:
> >>>
> >>>      /*
> >>>       * If this is our first additional thread, we need to ensure we
> >>>       * generate code for parallel execution and flush old
> translations.
> >>>       * Do this now so that the copy gets CF_PARALLEL too.
> >>>       */
> >>>      if (!(cpu->tcg_cflags & CF_PARALLEL)) {
> >>>          cpu->tcg_cflags |=3D CF_PARALLEL;
> >>>          tb_flush(cpu);
> >>>      }
> >>>
> >>> I think the right thing to do is to just change this to
> >> queue_tb_flush(cpu), and that compiles. I'd like to get some
> confirmation,
> >> though.
> >>> Did I parse the changes right?
> >>
> >> Yes, because ultimately we use safe work which:
> >>
> >>   * Schedules the function @func for execution on the vCPU @cpu
> >> asynchronously,
> >>   * while all other vCPUs are sleeping.
> >>
> >
> > So I've done this in the latest blitz branch. I encountered one gotcha.=
 I
> > replaced it in the one place, but that didn't work too well. I finally
> > tracked down the issue: I had implemented the change in only one place
> > instead of the three required locations. I also had to bring the
> > begin_parallel_context() function over from linux-user. I like
> > user-internal.h that's in linux user. What is your touchstone for
> deciding
> > where that code belongs in it? I'd like to do the same in bsd-user once
> my
> > upstream focus shift to refinement of blitz and maybe my next cool thin=
g
> > there.
>
> All common code should go under common-user/ and include/user/.
>

Great! I look forward to growing this directory.. But I was trying to ask a
slightly
different question: What belongs in user-internal.h? What's the current
rubric
for linux-user in that regard?

Warner

--0000000000006b24530652b97797
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, May 26,=
 2026 at 1:53=E2=80=AFAM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:=
philmd@linaro.org">philmd@linaro.org</a>&gt; wrote:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">On 24/5/26 18:57, Warner Losh wrote:<br=
>
&gt; On Sun, Feb 1, 2026 at 7:54=E2=80=AFAM Alex Benn=C3=A9e &lt;<a href=3D=
"mailto:alex.bennee@linaro.org" target=3D"_blank">alex.bennee@linaro.org</a=
>&gt; wrote:<br>
&gt; <br>
&gt;&gt; Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com" target=3D"_blank=
">imp@bsdimp.com</a>&gt; writes:<br>
&gt;&gt;<br>
&gt;&gt;&gt; OK. I&#39;ve updated bsd-user fork from last year to yesterday=
. I had one<br>
&gt;&gt; question.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; I see that we&#39;ve gone from tb_flush() to queue_tb_flush().=
 Why was that?<br>
&gt;&gt; And is it a drop in?<br>
&gt;&gt;&gt; FreeBSD&#39;s fork has this in the thread creation:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 /*<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0* If this is our first additional th=
read, we need to ensure we<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0* generate code for parallel executi=
on and flush old translations.<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0* Do this now so that the copy gets =
CF_PARALLEL too.<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 if (!(cpu-&gt;tcg_cflags &amp; CF_PARALLEL=
)) {<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu-&gt;tcg_cflags |=3D CF_P=
ARALLEL;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tb_flush(cpu);<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; I think the right thing to do is to just change this to<br>
&gt;&gt; queue_tb_flush(cpu), and that compiles. I&#39;d like to get some c=
onfirmation,<br>
&gt;&gt; though.<br>
&gt;&gt;&gt; Did I parse the changes right?<br>
&gt;&gt;<br>
&gt;&gt; Yes, because ultimately we use safe work which:<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0* Schedules the function @func for execution on the vC=
PU @cpu<br>
&gt;&gt; asynchronously,<br>
&gt;&gt;=C2=A0 =C2=A0* while all other vCPUs are sleeping.<br>
&gt;&gt;<br>
&gt; <br>
&gt; So I&#39;ve done this in the latest blitz branch. I encountered one go=
tcha. I<br>
&gt; replaced it in the one place, but that didn&#39;t work too well. I fin=
ally<br>
&gt; tracked down the issue: I had implemented the change in only one place=
<br>
&gt; instead of the three required locations. I also had to bring the<br>
&gt; begin_parallel_context() function over from linux-user. I like<br>
&gt; user-internal.h that&#39;s in linux user. What is your touchstone for =
deciding<br>
&gt; where that code belongs in it? I&#39;d like to do the same in bsd-user=
 once my<br>
&gt; upstream focus shift to refinement of blitz and maybe my next cool thi=
ng<br>
&gt; there.<br>
<br>
All common code should go under common-user/ and include/user/.<br></blockq=
uote><div><br></div><div>Great! I look forward to growing this directory.. =
But I was trying to ask a slightly</div><div>different question: What belon=
gs in user-internal.h? What&#39;s the current rubric</div><div>for linux-us=
er in that regard?</div><div><br></div><div>Warner</div></div></div>

--0000000000006b24530652b97797--

