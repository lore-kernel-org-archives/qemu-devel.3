Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15E96D40D0D
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 23:53:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8TMm-0007tY-CZ; Tue, 05 Nov 2024 18:53:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1t8TMk-0007t5-6u
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 18:53:42 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1t8TMh-0001Cb-Ph
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 18:53:41 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-723db2798caso2780046b3a.0
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 15:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1730850817; x=1731455617;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UQVgbsUtxLiQKI1uE3WLCiVYvtOBpf7Btl2AaQyf7aY=;
 b=IzfEcHR+tuOrZkRNfPhpeOJoy8i36X7j9z3qj1xk02Fj0V5/khrIfn9EF4SiNO90hK
 G1wpPUu9so9eUPBgv436g6tn8iXajqn2RLyS4QO8wL5qI9Hvcfwd5gmCUJu7noCsst5d
 v0L1W/bTJf/oiF5Tbjye+B7nKonDyDx3tdSp/r0BTXZOIam7D7q477/ApNUnJHuC+aic
 6vLlCbjbYfIU9RccniaCaW8BG/w+qLTSKLOWGd0lETv35/SKdZXN+/+O2AeEbdyhDMW0
 L2FkK6BJ+yfp23vNy4EYOOb6NWiGqCIZ+gFF5Ph3B+RnQBVy8EbTBQv6lxz+rB/5AT34
 G+DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730850817; x=1731455617;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UQVgbsUtxLiQKI1uE3WLCiVYvtOBpf7Btl2AaQyf7aY=;
 b=QLWV5FjKoeTO1fcY0O/rW6JiMru85jaTw0ESzdGf/6SGfEbLXee9UxCeZCNPw3MMJA
 esQ8bnbCykLb9aHmO63FfU+CAmlgaq3K6GA00oDNml2/aCb5n6LRGlzqTCPHxUE/+S2I
 FUSO6bOOjibbUc9oJoatjJ9SLYGWLIEdQBb+BiSj94nhxQV37VKUYmY0avzfUz5flV5V
 CGMVQ2Jfyr2lvvn6l9d6XjFl5MIL70cEvnCsoa3tkeXMFMRGiv8+e5m6wF6pn4OVKRDG
 weAYiK2LQ/zscPYI0faIz1Wl5CILOIpKVvopXDHiYoaG6jLtLKc1DkeeN6D7KnEU2QF7
 xNzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNK4XfoQL6xLvlqqwOzBT/pqwHvGd+AnZ3xGuUA8mp0oFFpIaPGOQXVVkDwcBPfv11aM1vhdlpi5I0@nongnu.org
X-Gm-Message-State: AOJu0Yw3yEUSgUpBdTcwrztpgHk38gBz0zUhNjQCsypG/nBTt3ayRhC2
 UNigvuFHCk+7VxGMZHbI4dINVMfYG2MxGlWr9yUZyl/tx1clDcaZ+ieQ4tUaljFtHIEZFnVNagU
 secsaquor26TW+palof8JKV9aq2DziGGZExuJTmrpVLfJsoxNLcE=
X-Google-Smtp-Source: AGHT+IG98sZb9huyh8iYQU4t+gmD7VYlhoHe4U1k0NNUX8ojV91w5etLJMqhBrY9isRMUFwjJUKXHv4bMv2N5Pd2Tc4=
X-Received: by 2002:a05:6a21:339b:b0:1db:d7c3:475a with SMTP id
 adf61e73a8af0-1dbd7c34771mr11849905637.4.1730850817576; Tue, 05 Nov 2024
 15:53:37 -0800 (PST)
MIME-Version: 1.0
References: <20241024200031.80327-1-iii@linux.ibm.com>
 <20241024200031.80327-5-iii@linux.ibm.com>
 <CANCZdfrhzc-HZabUjkAMTgcHR0+6OQPxNshkQfMYD4wbNcm=wQ@mail.gmail.com>
 <74ef513603500e76330c2735803d5e1402406f4a.camel@linux.ibm.com>
 <10571acb-fb5a-4288-8236-4a95b4247829@linaro.org>
 <9a11ba28e4979c10152d3d696ab31b23e8bbf27a.camel@linux.ibm.com>
In-Reply-To: <9a11ba28e4979c10152d3d696ab31b23e8bbf27a.camel@linux.ibm.com>
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 5 Nov 2024 16:53:25 -0700
Message-ID: <CANCZdfrTQ7tnqiDTBsvbexg180H6u71Ec67JQobYyATpSD4_3A@mail.gmail.com>
Subject: Re: [PATCH 4/8] user: Introduce host_interrupt_signal
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>, 
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Kyle Evans <kevans@freebsd.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000024323a0626331cb0"
Received-SPF: none client-ip=2607:f8b0:4864:20::432;
 envelope-from=wlosh@bsdimp.com; helo=mail-pf1-x432.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--00000000000024323a0626331cb0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 3:49=E2=80=AFPM Ilya Leoshkevich <iii@linux.ibm.com>=
 wrote:

> On Tue, 2024-11-05 at 22:30 +0000, Richard Henderson wrote:
> > On 11/5/24 15:50, Ilya Leoshkevich wrote:
> > > On Tue, 2024-11-05 at 08:39 -0700, Warner Losh wrote:
> > > > On Thu, Oct 24, 2024 at 2:00=E2=80=AFPM Ilya Leoshkevich
> > > > <iii@linux.ibm.com>
> > > > wrote:
> > > > > Attaching to the gdbstub of a running process requires stopping
> > > > > its
> > > > > threads. For threads that run on a CPU, cpu_exit() is enough,
> > > > > but
> > > > > the
> > > > > only way to grab attention of a thread that is stuck in a long-
> > > > > running
> > > > > syscall is to interrupt it with a signal.
> > > > >
> > > > > Reserve a host realtime signal for this, just like it's already
> > > > > done
> > > > > for TARGET_SIGABRT on Linux. This may reduce the number of
> > > > > available
> > > > > guest realtime signals by one, but this is acceptable, since
> > > > > there
> > > > > are
> > > > > quite a lot of them, and it's unlikely that there are apps that
> > > > > need
> > > > > them all.
> > > > >
> > > > > Set signal_pending for the safe_sycall machinery to prevent
> > > > > invoking
> > > > > the syscall. This is a lie, since we don't queue a guest
> > > > > signal,
> > > > > but
> > > > > process_pending_signals() can handle the absence of pending
> > > > > signals.
> > > > > The syscall returns with QEMU_ERESTARTSYS errno, which arranges
> > > > > for
> > > > > the automatic restart. This is important, because it helps
> > > > > avoiding
> > > > > disturbing poorly written guests.
> > > > >
> > > > > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > > > > ---
> > > > >   bsd-user/signal.c     | 12 ++++++++++++
> > > > >   include/user/signal.h |  2 ++
> > > > >   linux-user/signal.c   | 11 +++++++++++
> > > > >   3 files changed, 25 insertions(+)
> > > > >
> > > > > diff --git a/bsd-user/signal.c b/bsd-user/signal.c
> > > > > index a2b11a97131..992736df5c5 100644
> > > > > --- a/bsd-user/signal.c
> > > > > +++ b/bsd-user/signal.c
> > > > > @@ -49,6 +49,8 @@ static inline int sas_ss_flags(TaskState *ts,
> > > > > unsigned long sp)
> > > > >           on_sig_stack(ts, sp) ? SS_ONSTACK : 0;
> > > > >   }
> > > > >
> > > > > +int host_interrupt_signal =3D SIGRTMAX;
> > > > > +
> > > > >
> > > >
> > > >
> > > > I'd be tempted to use SIGRTMAX + 1 or even TARGET_NSIG. 127 or
> > > > 128
> > > > would
> > > > work and not overflow any arrays (or hit any bounds tests) I'd
> > > > likely
> > > > use SIGRTMAX + 1,
> > > > though, since it avoids any edge-cases from sig =3D=3D NSIG that
> > > > might be
> > > > in the code
> > > > unnoticed.
> > > >
> > > > Now, having said that, I don't think that there's too many (any?)
> > > > programs we need
> > > > to run as bsd-user that have real-time signals, much less one
> > > > that
> > > > uses SIGRTMAX,
> > > > but stranger things have happened. But it is a little wiggle room
> > > > just in case.
> > > >
> > > > Other than that:
> > > >
> > > > Reviewed-by: Warner Losh <imp@bsdimp.com>
> > >
> > > Thanks for the suggestion, I'll use SIGRTMAX + 1 in v2.
> >
> >
> > That can't be right -- SIGRTMAX+1 is not a valid signal.
> >
> >
> > r~
>
> I have to admit I didn't look into this too deeply, but I ran the
> following experiment on a FreeBSD 14.1 box:
>
>     /usr/include $ grep -R SIGRTMAX .
>     ./sys/signal.h:#define  SIGRTMAX        126
>
>     $ sleep 100 &
>     $ kill -126 %1
>     [1]   Unknown signal: 126     sleep 100
>
>     $ sleep 100 &
>     $ kill -127 %1
>     [1] + Unknown signal: 0       sleep 100
>
> Clearly, something is wrong - at least with the shell - but at the
> same time the signal delivery seems to have occurred.
>
> Warner, does the above look normal to you?
>

Oh! I understand.... I thought there was a gap above SIGRTMAX. It
sure looks like there is. However, 0177 (127) is used to signal that
the process is STOPPED, so can't be used. This is why SIGRTMAX
is 126 and not 127. There's room in sigset_t, but that's not sufficient.
And it has to be an actual signal we send, not just a flag.

So forget I said anything. This was a silly idea. If we find any real thing
that's using SIGRTMAX, we'll cope.

Warner

--00000000000024323a0626331cb0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Nov 5, 2024 at 3:49=E2=80=AFP=
M Ilya Leoshkevich &lt;<a href=3D"mailto:iii@linux.ibm.com">iii@linux.ibm.c=
om</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">On Tue, 2024-11-05 at 22:30 +0000, Richard Henderson wrote:<br>
&gt; On 11/5/24 15:50, Ilya Leoshkevich wrote:<br>
&gt; &gt; On Tue, 2024-11-05 at 08:39 -0700, Warner Losh wrote:<br>
&gt; &gt; &gt; On Thu, Oct 24, 2024 at 2:00=E2=80=AFPM Ilya Leoshkevich<br>
&gt; &gt; &gt; &lt;<a href=3D"mailto:iii@linux.ibm.com" target=3D"_blank">i=
ii@linux.ibm.com</a>&gt;<br>
&gt; &gt; &gt; wrote:<br>
&gt; &gt; &gt; &gt; Attaching to the gdbstub of a running process requires =
stopping<br>
&gt; &gt; &gt; &gt; its<br>
&gt; &gt; &gt; &gt; threads. For threads that run on a CPU, cpu_exit() is e=
nough,<br>
&gt; &gt; &gt; &gt; but<br>
&gt; &gt; &gt; &gt; the<br>
&gt; &gt; &gt; &gt; only way to grab attention of a thread that is stuck in=
 a long-<br>
&gt; &gt; &gt; &gt; running<br>
&gt; &gt; &gt; &gt; syscall is to interrupt it with a signal.<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; Reserve a host realtime signal for this, just like it&#=
39;s already<br>
&gt; &gt; &gt; &gt; done<br>
&gt; &gt; &gt; &gt; for TARGET_SIGABRT on Linux. This may reduce the number=
 of<br>
&gt; &gt; &gt; &gt; available<br>
&gt; &gt; &gt; &gt; guest realtime signals by one, but this is acceptable, =
since<br>
&gt; &gt; &gt; &gt; there<br>
&gt; &gt; &gt; &gt; are<br>
&gt; &gt; &gt; &gt; quite a lot of them, and it&#39;s unlikely that there a=
re apps that<br>
&gt; &gt; &gt; &gt; need<br>
&gt; &gt; &gt; &gt; them all.<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; Set signal_pending for the safe_sycall machinery to pre=
vent<br>
&gt; &gt; &gt; &gt; invoking<br>
&gt; &gt; &gt; &gt; the syscall. This is a lie, since we don&#39;t queue a =
guest<br>
&gt; &gt; &gt; &gt; signal,<br>
&gt; &gt; &gt; &gt; but<br>
&gt; &gt; &gt; &gt; process_pending_signals() can handle the absence of pen=
ding<br>
&gt; &gt; &gt; &gt; signals.<br>
&gt; &gt; &gt; &gt; The syscall returns with QEMU_ERESTARTSYS errno, which =
arranges<br>
&gt; &gt; &gt; &gt; for<br>
&gt; &gt; &gt; &gt; the automatic restart. This is important, because it he=
lps<br>
&gt; &gt; &gt; &gt; avoiding<br>
&gt; &gt; &gt; &gt; disturbing poorly written guests.<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; Signed-off-by: Ilya Leoshkevich &lt;<a href=3D"mailto:i=
ii@linux.ibm.com" target=3D"_blank">iii@linux.ibm.com</a>&gt;<br>
&gt; &gt; &gt; &gt; ---<br>
&gt; &gt; &gt; &gt; =C2=A0=C2=A0bsd-user/signal.c=C2=A0 =C2=A0 =C2=A0| 12 +=
+++++++++++<br>
&gt; &gt; &gt; &gt; =C2=A0=C2=A0include/user/signal.h |=C2=A0 2 ++<br>
&gt; &gt; &gt; &gt; =C2=A0=C2=A0linux-user/signal.c=C2=A0 =C2=A0| 11 ++++++=
+++++<br>
&gt; &gt; &gt; &gt; =C2=A0=C2=A03 files changed, 25 insertions(+)<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; diff --git a/bsd-user/signal.c b/bsd-user/signal.c<br>
&gt; &gt; &gt; &gt; index a2b11a97131..992736df5c5 100644<br>
&gt; &gt; &gt; &gt; --- a/bsd-user/signal.c<br>
&gt; &gt; &gt; &gt; +++ b/bsd-user/signal.c<br>
&gt; &gt; &gt; &gt; @@ -49,6 +49,8 @@ static inline int sas_ss_flags(TaskSt=
ate *ts,<br>
&gt; &gt; &gt; &gt; unsigned long sp)<br>
&gt; &gt; &gt; &gt; =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0on_sig_stack(ts=
, sp) ? SS_ONSTACK : 0;<br>
&gt; &gt; &gt; &gt; =C2=A0=C2=A0}<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; +int host_interrupt_signal =3D SIGRTMAX;<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; I&#39;d be tempted to use SIGRTMAX=C2=A0+ 1 or even TARGET_N=
SIG. 127 or<br>
&gt; &gt; &gt; 128<br>
&gt; &gt; &gt; would<br>
&gt; &gt; &gt; work and not overflow any arrays (or hit any bounds tests) I=
&#39;d<br>
&gt; &gt; &gt; likely<br>
&gt; &gt; &gt; use SIGRTMAX=C2=A0+ 1,<br>
&gt; &gt; &gt; though, since it avoids any edge-cases from sig =3D=3D NSIG =
that<br>
&gt; &gt; &gt; might be<br>
&gt; &gt; &gt; in the code<br>
&gt; &gt; &gt; unnoticed.<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; Now, having said that, I don&#39;t think that there&#39;s to=
o many (any?)<br>
&gt; &gt; &gt; programs we need<br>
&gt; &gt; &gt; to run as bsd-user that have real-time signals, much less on=
e<br>
&gt; &gt; &gt; that<br>
&gt; &gt; &gt; uses SIGRTMAX,<br>
&gt; &gt; &gt; but stranger things have happened. But it is a little wiggle=
 room<br>
&gt; &gt; &gt; just in case.<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; Other than that:<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; Reviewed-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.co=
m" target=3D"_blank">imp@bsdimp.com</a>&gt;<br>
&gt; &gt; <br>
&gt; &gt; Thanks for the suggestion, I&#39;ll use SIGRTMAX + 1 in v2.<br>
&gt; <br>
&gt; <br>
&gt; That can&#39;t be right -- SIGRTMAX+1 is not a valid signal.<br>
&gt; <br>
&gt; <br>
&gt; r~<br>
<br>
I have to admit I didn&#39;t look into this too deeply, but I ran the<br>
following experiment on a FreeBSD 14.1 box:<br>
<br>
=C2=A0 =C2=A0 /usr/include $ grep -R SIGRTMAX .<br>
=C2=A0 =C2=A0 ./sys/signal.h:#define=C2=A0 SIGRTMAX=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 126<br>
<br>
=C2=A0 =C2=A0 $ sleep 100 &amp;<br>
=C2=A0 =C2=A0 $ kill -126 %1<br>
=C2=A0 =C2=A0 [1]=C2=A0 =C2=A0Unknown signal: 126=C2=A0 =C2=A0 =C2=A0sleep =
100<br>
<br>
=C2=A0 =C2=A0 $ sleep 100 &amp;<br>
=C2=A0 =C2=A0 $ kill -127 %1<br>
=C2=A0 =C2=A0 [1] + Unknown signal: 0=C2=A0 =C2=A0 =C2=A0 =C2=A0sleep 100<b=
r>
<br>
Clearly, something is wrong - at least with the shell - but at the<br>
same time the signal delivery seems to have occurred.<br>
<br>
Warner, does the above look normal to you?<br></blockquote><div><br></div><=
div>Oh! I understand.... I thought there was a gap above SIGRTMAX. It</div>=
<div>sure looks like there is. However, 0177 (127) is used to signal that</=
div><div>the process is STOPPED, so can&#39;t be used. This is why SIGRTMAX=
</div><div>is 126 and not 127. There&#39;s room in sigset_t, but that&#39;s=
 not sufficient.</div><div>And it has to be an actual signal we send, not j=
ust a flag.<br></div><div><br></div><div>So forget I said anything. This wa=
s a silly idea. If we find any real thing</div><div>that&#39;s using SIGRTM=
AX, we&#39;ll cope.</div><div><br></div><div>Warner</div></div></div>

--00000000000024323a0626331cb0--

