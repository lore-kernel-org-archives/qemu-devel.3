Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FC8ACD5BB1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 16:54:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRv2F-00053m-Mf; Tue, 26 May 2026 12:53:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wRv28-000531-7S
 for qemu-devel@nongnu.org; Tue, 26 May 2026 12:53:36 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wRv24-0001Yb-P2
 for qemu-devel@nongnu.org; Tue, 26 May 2026 12:53:35 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-36a7bbb9698so2437458a91.2
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 09:53:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779814396; cv=none;
 d=google.com; s=arc-20240605;
 b=RrbsqBibqRbwe2k7dGS6QwhVcz6OEkBXc3RTyM+3AQP6czF4UPx5/0ji97I2ViS5ur
 ED6gF/ct2NjQCh2FYDUpkwZI8iIGgBkUr1k5f26noADTHW9u9Wo4njRtiUeFfuJA5UDN
 Z8Q7RD+Ju+YO+spogMOSdDcQrou7D04npLWqQrUPxQEPi9w+lTT/U9sBSgkHIt/Y73el
 qjw4Hlq9VKEOYsYVnz+ItXNpKBFOTa+Tqv10V4n6V75L9MEom+96dIVnmfOUx0UimVW5
 IQH9/2nOC3Ah87KJNpUC+DUdjaBzQr1il9eR3005B/1I0VPXWNq9LzZs4MalCGBYg29S
 qyHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=mSQYLIRLyxbj4oGNaJxinz2w0pVgxwjAAOHIfE4y/HU=;
 fh=H/IZ07pC+iNkLxrlI2gKRh6o6s0Eeq7oehTVHOpdVFs=;
 b=aRB9adrWpjhKwKXXJZZH3/xPQ9VWsHQnQ0K9ynBOVg0+fPbV3159eRyDaVezTLNUER
 wmJNgGTi/UwXaXiIafe2imDXxJUatxkTb+nesY4Ye46dVm9r34jSoJdY0dMB680bOyQN
 g5vn1RVXahyVG6cTwscUTxY5PkzVrIHYaOatV7dxwSbjDAoeYmoznNU4Zt9E8cmwWlvY
 imBGEd2P8i33Vy4JCytW5HTL5NA+MmZUmNABhpzrVaB9R4fCGNHd1kZ+83urfkP/ny1n
 7xasfkKhEzHdkRdpE2dB1zOF8wgdjeboMVhXshC94NQDxosM0TvuI9NHNGcELx0xmM7n
 7a8A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1779814396; x=1780419196;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mSQYLIRLyxbj4oGNaJxinz2w0pVgxwjAAOHIfE4y/HU=;
 b=SQDkw9my7R7RIvxowXeSsBs7WwiKIelRN3A4Hjev+5s/aoRxJrZVp1meZtA2xT4HHt
 PIO2+41NSgwb9sbEA6UIDtl+QrfUMAgXSiWIjYTHEbT23FN+/XYjn6B+KDNuFF1KGDFC
 2CgxENWjplOUuYYRopViRDBrk9EsR7i2IsBPGy5xMHsqCzwxqbom3wAIwspiMRc1D9GO
 qhRgjPSn7nS9NGMQCe9rXdpX5NBudNTMfrI5knynYTukchpGVBmTE2N6Nb8X0R8/ctQP
 eFS2elvpJwrWj8eVdszR1LbxP09bJg0zEYS9MERYQqEduyXrrwAEhBKXiIXeGk+z8K+H
 D2uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779814396; x=1780419196;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mSQYLIRLyxbj4oGNaJxinz2w0pVgxwjAAOHIfE4y/HU=;
 b=GQ8QcMW6zb1pi2ThHybo0xV+UK75CJLkdwFuV4IeApdKq7j3C5dVaYMJYuym4uunnb
 bfqq6GDhQfxBIHO5Vmqsi1FCNT72vuFU3t3IsZIGOHOTM9+DfFPnq4m9tJXaXPQP4V8A
 Nvt8QrkHxVfxF1zcKIH/5n02FiPca3qvAvLY0ami1APXtTG43/gPdoolHJGBxGbYbVb4
 hEATXp1OYwmchs0MEenxi/OsHTw/Tqh0lgLbOYBvCjx4kewj60sTPMmMvo1r1GwvBp3q
 xwOrDUwGC9NPdztj8AuZcELvIxoo6GFvy7gjF/fGyAG6rg95hC9nFvYOZlGS34sLyND5
 Y3hA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Cr8AMxrSEnVMrOBHtlRHRqh1WByYLln2hQtoL1TS96ytJBHEfZRk8ZXszbqmSU7TBwurV7LVBxsTN@nongnu.org
X-Gm-Message-State: AOJu0YxLx6YGh/QYqLyuB8rFNK1qj6xHVhw1XXNppjDTZTbnO8JknjWw
 bWlpAu77a7avxfMrNAe9I0r4adNTNZqiFGnwIvZfuSBMO9tD76GP41Bf+uyT2U1eA0crhIk57wf
 yKxN/fJLLlTWeNNgcagUs1WpxOC1YKzL6jutN1TpLpg==
X-Gm-Gg: Acq92OHR9i86ueuHZxPywqBJ2zNB1qzrHvlvv+g+tx3pCtyFT/PYy/MZOVjiK0yac6a
 WS6U19/Ja6d93j+UQgGBJVdvd9bIX2PVc3uFaCDNw7m7RgGa3a5qgYua/LVqjtVx3uwPERvKkri
 T/iyi88sEjFaerZcvKvh84WB19XNs54EN39UU8+GBdaA5GXsAG8NiKW/78gpfbzkzNfUw3nCx09
 3PcKhndV6Dy3v4qXHVKOLES0I8pq73eq9EFhxTwgyliWT/D7NT8giFPB4l7kITTnsWqFtYPfWpt
 4PbvXVg=
X-Received: by 2002:a17:90b:38cc:b0:361:45df:102 with SMTP id
 98e67ed59e1d1-36a6765b589mr18578982a91.17.1779814395774; Tue, 26 May 2026
 09:53:15 -0700 (PDT)
MIME-Version: 1.0
References: <CANCZdfr6xs9n8sF8AXVWVu9i2_rViKErrMHAVbopnaor4uCN6A@mail.gmail.com>
 <875x8g1pmi.fsf@draig.linaro.org>
 <CANCZdfqT7r9jcTuiwe3=CcjRExL-FP1msx-Q8ftQM5amJ_t0YQ@mail.gmail.com>
 <1795fc9c-f82e-40f1-aab6-ec24ad02a918@linaro.org>
 <CANCZdfp=mCp89NdwVzy-tEo=FNiEu6_H79r5vFRD0-Nk=Cx54Q@mail.gmail.com>
 <b2cfb0cf-bec5-49ca-add2-20fed4c36250@linaro.org>
In-Reply-To: <b2cfb0cf-bec5-49ca-add2-20fed4c36250@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 26 May 2026 10:53:04 -0600
X-Gm-Features: AVHnY4Ij2A51uokAExTlQvhq3_lfQ_9HbFHJ5rlx1xAxE1L5XpaMA7OpX703-EY
Message-ID: <CANCZdfqYEvaMs0-dng5khm9Oo7TOJNnYNv_O0KbwT6EfY8npkQ@mail.gmail.com>
Subject: Re: Question about tb_flush()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 QEMU Developers <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000d3979b0652bb5476"
Received-SPF: none client-ip=2607:f8b0:4864:20::1035;
 envelope-from=wlosh@bsdimp.com; helo=mail-pj1-x1035.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

--000000000000d3979b0652bb5476
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2026 at 8:44=E2=80=AFAM Philippe Mathieu-Daud=C3=A9 <philmd=
@linaro.org>
wrote:

> On 26/5/26 16:39, Warner Losh wrote:
> > On Tue, May 26, 2026 at 1:53=E2=80=AFAM Philippe Mathieu-Daud=C3=A9 <
> philmd@linaro.org>
> > wrote:
> >
> >> On 24/5/26 18:57, Warner Losh wrote:
> >>> On Sun, Feb 1, 2026 at 7:54=E2=80=AFAM Alex Benn=C3=A9e <alex.bennee@=
linaro.org>
> >> wrote:
> >>>
> >>>> Warner Losh <imp@bsdimp.com> writes:
> >>>>
> >>>>> OK. I've updated bsd-user fork from last year to yesterday. I had o=
ne
> >>>> question.
> >>>>>
> >>>>> I see that we've gone from tb_flush() to queue_tb_flush(). Why was
> >> that?
> >>>> And is it a drop in?
> >>>>> FreeBSD's fork has this in the thread creation:
> >>>>>
> >>>>>       /*
> >>>>>        * If this is our first additional thread, we need to ensure =
we
> >>>>>        * generate code for parallel execution and flush old
> >> translations.
> >>>>>        * Do this now so that the copy gets CF_PARALLEL too.
> >>>>>        */
> >>>>>       if (!(cpu->tcg_cflags & CF_PARALLEL)) {
> >>>>>           cpu->tcg_cflags |=3D CF_PARALLEL;
> >>>>>           tb_flush(cpu);
> >>>>>       }
> >>>>>
> >>>>> I think the right thing to do is to just change this to
> >>>> queue_tb_flush(cpu), and that compiles. I'd like to get some
> >> confirmation,
> >>>> though.
> >>>>> Did I parse the changes right?
> >>>>
> >>>> Yes, because ultimately we use safe work which:
> >>>>
> >>>>    * Schedules the function @func for execution on the vCPU @cpu
> >>>> asynchronously,
> >>>>    * while all other vCPUs are sleeping.
> >>>>
> >>>
> >>> So I've done this in the latest blitz branch. I encountered one
> gotcha. I
> >>> replaced it in the one place, but that didn't work too well. I finall=
y
> >>> tracked down the issue: I had implemented the change in only one plac=
e
> >>> instead of the three required locations. I also had to bring the
> >>> begin_parallel_context() function over from linux-user. I like
> >>> user-internal.h that's in linux user. What is your touchstone for
> >> deciding
> >>> where that code belongs in it? I'd like to do the same in bsd-user on=
ce
> >> my
> >>> upstream focus shift to refinement of blitz and maybe my next cool
> thing
> >>> there.
> >>
> >> All common code should go under common-user/ and include/user/.
> >>
> >
> > Great! I look forward to growing this directory.. But I was trying to
> ask a
> > slightly
> > different question: What belongs in user-internal.h? What's the current
> > rubric
> > for linux-user in that regard?
>
> We try to have cross-subsystem APIs exposed in include/. When we need to
> share some structure / method only within a single subsystem, we do not
> expose the prototype via include/ and add a local header.
>
> So linux-user/linux-user-internal.h should only contains things to share
> within linux-user/, and not related to bsd-user.
>

It's slightly related to bsd-user since my intention was to create a
bsd-user/user-internal.h since I liked the design. So I was curious what
linux-user's process for deciding where to put different things since
there's
several include files now. I understand the qemu.h being too wide a net and
wanting to limit what's in there (bsd-user has a decade of refactoring to
catch
up with there). I'm trying to understand the choices linux-user has made to
use
them as a baseline for future bsd-user refactoring. The things that are in
there
now don't seem to have an obvious unifying thread to them. Is this
documented
somewhere, or just in the different commits for the files?

Warner

--000000000000d3979b0652bb5476
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, May 26,=
 2026 at 8:44=E2=80=AFAM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:=
philmd@linaro.org">philmd@linaro.org</a>&gt; wrote:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">On 26/5/26 16:39, Warner Losh wrote:<br=
>
&gt; On Tue, May 26, 2026 at 1:53=E2=80=AFAM Philippe Mathieu-Daud=C3=A9 &l=
t;<a href=3D"mailto:philmd@linaro.org" target=3D"_blank">philmd@linaro.org<=
/a>&gt;<br>
&gt; wrote:<br>
&gt; <br>
&gt;&gt; On 24/5/26 18:57, Warner Losh wrote:<br>
&gt;&gt;&gt; On Sun, Feb 1, 2026 at 7:54=E2=80=AFAM Alex Benn=C3=A9e &lt;<a=
 href=3D"mailto:alex.bennee@linaro.org" target=3D"_blank">alex.bennee@linar=
o.org</a>&gt;<br>
&gt;&gt; wrote:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com" target=
=3D"_blank">imp@bsdimp.com</a>&gt; writes:<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; OK. I&#39;ve updated bsd-user fork from last year to y=
esterday. I had one<br>
&gt;&gt;&gt;&gt; question.<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; I see that we&#39;ve gone from tb_flush() to queue_tb_=
flush(). Why was<br>
&gt;&gt; that?<br>
&gt;&gt;&gt;&gt; And is it a drop in?<br>
&gt;&gt;&gt;&gt;&gt; FreeBSD&#39;s fork has this in the thread creation:<br=
>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 * If this is our first addi=
tional thread, we need to ensure we<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 * generate code for paralle=
l execution and flush old<br>
&gt;&gt; translations.<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 * Do this now so that the c=
opy gets CF_PARALLEL too.<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!(cpu-&gt;tcg_cflags &am=
p; CF_PARALLEL)) {<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cpu-&gt;tcg_cf=
lags |=3D CF_PARALLEL;<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tb_flush(cpu);=
<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; I think the right thing to do is to just change this t=
o<br>
&gt;&gt;&gt;&gt; queue_tb_flush(cpu), and that compiles. I&#39;d like to ge=
t some<br>
&gt;&gt; confirmation,<br>
&gt;&gt;&gt;&gt; though.<br>
&gt;&gt;&gt;&gt;&gt; Did I parse the changes right?<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Yes, because ultimately we use safe work which:<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 * Schedules the function @func for execution =
on the vCPU @cpu<br>
&gt;&gt;&gt;&gt; asynchronously,<br>
&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 * while all other vCPUs are sleeping.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; So I&#39;ve done this in the latest blitz branch. I encountere=
d one gotcha. I<br>
&gt;&gt;&gt; replaced it in the one place, but that didn&#39;t work too wel=
l. I finally<br>
&gt;&gt;&gt; tracked down the issue: I had implemented the change in only o=
ne place<br>
&gt;&gt;&gt; instead of the three required locations. I also had to bring t=
he<br>
&gt;&gt;&gt; begin_parallel_context() function over from linux-user. I like=
<br>
&gt;&gt;&gt; user-internal.h that&#39;s in linux user. What is your touchst=
one for<br>
&gt;&gt; deciding<br>
&gt;&gt;&gt; where that code belongs in it? I&#39;d like to do the same in =
bsd-user once<br>
&gt;&gt; my<br>
&gt;&gt;&gt; upstream focus shift to refinement of blitz and maybe my next =
cool thing<br>
&gt;&gt;&gt; there.<br>
&gt;&gt;<br>
&gt;&gt; All common code should go under common-user/ and include/user/.<br=
>
&gt;&gt;<br>
&gt; <br>
&gt; Great! I look forward to growing this directory.. But I was trying to =
ask a<br>
&gt; slightly<br>
&gt; different question: What belongs in user-internal.h? What&#39;s the cu=
rrent<br>
&gt; rubric<br>
&gt; for linux-user in that regard?<br>
<br>
We try to have cross-subsystem APIs exposed in include/. When we need to<br=
>
share some structure / method only within a single subsystem, we do not<br>
expose the prototype via include/ and add a local header.<br>
<br>
So linux-user/linux-user-internal.h should only contains things to share<br=
>
within linux-user/, and not related to bsd-user.<br></blockquote><div><br><=
/div><div>It&#39;s slightly related to bsd-user since my intention was to c=
reate a</div><div>bsd-user/user-internal.h since I liked the design. So I w=
as curious what</div><div>linux-user&#39;s process for deciding where to pu=
t different things since there&#39;s</div><div>several include files now. I=
 understand the qemu.h being too wide a net and</div><div>wanting to limit =
what&#39;s in there (bsd-user has a decade of refactoring to catch</div><di=
v>up with there). I&#39;m trying to understand the choices linux-user has m=
ade to use</div><div>them as a baseline for future bsd-user refactoring. Th=
e things that are in there</div><div>now don&#39;t seem to have an obvious =
unifying thread to them. Is this documented</div><div>somewhere, or just in=
 the different commits for the files?</div><div><br></div><div>Warner</div>=
<div>=C2=A0</div></div></div>

--000000000000d3979b0652bb5476--

