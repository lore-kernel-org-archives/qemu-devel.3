Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 562F9E77180
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 09:54:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKwvW-000832-GI; Tue, 10 Dec 2024 04:53:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tKwvN-00082M-5Y
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 04:53:01 -0500
Received: from mail-vk1-xa2a.google.com ([2607:f8b0:4864:20::a2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tKwvC-0001uT-44
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 04:52:54 -0500
Received: by mail-vk1-xa2a.google.com with SMTP id
 71dfb90a1353d-518911908b0so167285e0c.0
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 01:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1733824368; x=1734429168;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EW24HPJsMhBMR+V2YAuOgQK05+8WhHNOiyO+UPdl7Ro=;
 b=eBCENuo3S+FKTPbaKMBOOQlFlllCeSu0r/JaYb+QNHI+/zPmQi3F2r7JSvEcZhW82i
 gemnaZQ9rt/3w8YE/zIQXHJIJsEUgiJsDI2evz4afI0Nfg6NCeiJgbuGisjsA3+Ut4pZ
 0g9RXzzT7k/+RfvzO49a1Y2b+X7mXP0ZNqJw0O1El2ZBf8VIejp4KHTDbfGlSieUBGgf
 hIUKTMMgbLap57kyolANFDjgMd0l5kvn+JAYB8G/3FawbWV70ypvaOzCwgCEpsGJKmOU
 xFXW0nD5SRGBVPwsVJ2O7wTHGpEoUA1AtHuRgFhS5/m/3vu8tpc3F7GJhWysfjMbBtMA
 vFXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733824368; x=1734429168;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EW24HPJsMhBMR+V2YAuOgQK05+8WhHNOiyO+UPdl7Ro=;
 b=gs/QB4oL6at0lL3z6DofyY9UbrWbM6Okt+giulD19D/PjSATZd0Bof/VrtabTYriS8
 s5EsFwDJTs6y8+YDTwdry2CualyYGydRXU9XlhVfndnZRPMvLTJD4c5MkfgVic+kW1aL
 /nIgbH6XAqX9z1Z+XyH3tbiMoju+Kp+PDGLqycH2CPrsRF9466jIMvNYU4ZEL5qzXivI
 ZhluLCVn9BTa78HB1xtEr1DKMswvUJwFZIJ7A8fpK+6mXmYt46TIwb98liz2CRFoQOAF
 hUOiz7o0ktoYP7dYpWRUycBG7jkWb8iIBpC6KDsetN1H0eAIN0KvTlLUmm061Uo5EPYz
 Ue5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwvuSpAnnjINykE/AnCDQmG0JusQj2vnkkP+haDTWNXkDQ4CikFTs6a6PhqYtFbQXvo5UBiV73VSF+@nongnu.org
X-Gm-Message-State: AOJu0YzRDwYPwYOG9z9GHflZnlVElpSHnaofsc4MPC1aSVFX+OPWA2zZ
 dt4cTldMbjQon2Dq/ON6re89Nfki6MGR7bmplsQ9ndVFwd56eZPCOPNbNDm02Bv/Cs7wF43X1ID
 Ni1LM5f5Mh3bORDno+fmRu7PYKQAzJFb92Rdh
X-Gm-Gg: ASbGncvEb5rprIHS2XhCsUZ9vobd0bSWiPaGTWf+EJTltG5wAOUyTuChYqvUH3qeqFb
 8a5yNH+duJaSgw7BJvXLkZoU+AdieeYauTEk=
X-Google-Smtp-Source: AGHT+IF5bfdLVTGrTdJmiXzsHyrvrUVfUjXJM+s4xxFPuip0QGwiASWXtMGpedGHo+OVjyKyesX+r6Luq57KPXlX/7k=
X-Received: by 2002:a05:6122:2895:b0:518:8d54:567f with SMTP id
 71dfb90a1353d-5188d546d3emr2047733e0c.6.1733824368142; Tue, 10 Dec 2024
 01:52:48 -0800 (PST)
MIME-Version: 1.0
References: <20241209203629.74436-1-phil@philjordan.eu>
 <20241209203629.74436-4-phil@philjordan.eu>
 <c401b320-b382-4887-82bc-0252dd9f8c98@linaro.org>
 <0aa33648-5a30-4302-bf7a-f31cab0b327e@ddn.com>
In-Reply-To: <0aa33648-5a30-4302-bf7a-f31cab0b327e@ddn.com>
From: Phil Dennis-Jordan <phil@philjordan.eu>
Date: Tue, 10 Dec 2024 10:52:37 +0100
Message-ID: <CAAibmn0zwbsniR2bLcvhqTuTdPZTRkQPDv9v9==gyMpPNELLLA@mail.gmail.com>
Subject: Re: [PATCH 03/11] i386/hvf: Don't send signal to thread when kicking
To: Roman Bolshakov <rbolshakov@ddn.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Cameron Esfahani <dirty@apple.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Alexander Graf <agraf@csgraf.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000009105e80628e77171"
Received-SPF: neutral client-ip=2607:f8b0:4864:20::a2a;
 envelope-from=phil@philjordan.eu; helo=mail-vk1-xa2a.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

--0000000000009105e80628e77171
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue 10. Dec 2024 at 10:21, Roman Bolshakov <rbolshakov@ddn.com> wrote:

> On 10.12.2024 04:22, Philippe Mathieu-Daud=C3=A9 wrote:
> > On 9/12/24 21:36, phil@philjordan.eu wrote:
> >> From: Phil Dennis-Jordan <phil@philjordan.eu>
> >>
> >> This seems to be entirely superfluous and is costly enough to show up =
in
> >
> > So the pthread_kill(cpu->thread, SIG_IPI) is entirely superfluous?
> >
> >> profiling. hv_vcpu_interrupt() has been demonstrated to very reliably
> >> cause VM exits - even if the target vCPU isn't even running, it will
> >> immediately exit on entry.
> >>
> >> Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
> >> ---
> >>   target/i386/hvf/hvf.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
> >> index 3b6ee79fb2..936c31dbdd 100644
> >> --- a/target/i386/hvf/hvf.c
> >> +++ b/target/i386/hvf/hvf.c
> >> @@ -214,7 +214,7 @@ static inline bool
> >> apic_bus_freq_is_known(CPUX86State *env)
> >>     void hvf_kick_vcpu_thread(CPUState *cpu)
> >>   {
> >> -    cpus_kick_thread(cpu);
> >> +    cpu->thread_kicked =3D true;
> >>       hv_vcpu_interrupt(&cpu->accel->fd, 1);
> >>   }
> >
> SIG_IPI is macOS crutch handled in XNU kernel that was essential until
> Phil submitted proper kick support with hv_vcpu_interrupt().
>
> Ah yes, perhaps it allowed exit from hv_vcpu_run(). hv_vcpu_run_until()
definitely does not exit early upon receiving SIG_IPI (USR1).

--0000000000009105e80628e77171
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><br></div><div><br><div class=3D"gmail_quote"><div dir=3D=
"ltr" class=3D"gmail_attr">On Tue 10. Dec 2024 at 10:21, Roman Bolshakov &l=
t;<a href=3D"mailto:rbolshakov@ddn.com">rbolshakov@ddn.com</a>&gt; wrote:<b=
r></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border=
-left:1px #ccc solid;padding-left:1ex">On 10.12.2024 04:22, Philippe Mathie=
u-Daud=C3=A9 wrote:<br>
&gt; On 9/12/24 21:36, <a href=3D"mailto:phil@philjordan.eu" target=3D"_bla=
nk">phil@philjordan.eu</a> wrote:<br>
&gt;&gt; From: Phil Dennis-Jordan &lt;<a href=3D"mailto:phil@philjordan.eu"=
 target=3D"_blank">phil@philjordan.eu</a>&gt;<br>
&gt;&gt;<br>
&gt;&gt; This seems to be entirely superfluous and is costly enough to show=
 up in<br>
&gt;<br>
&gt; So the pthread_kill(cpu-&gt;thread, SIG_IPI) is entirely superfluous?<=
br>
&gt;<br>
&gt;&gt; profiling. hv_vcpu_interrupt() has been demonstrated to very relia=
bly<br>
&gt;&gt; cause VM exits - even if the target vCPU isn&#39;t even running, i=
t will<br>
&gt;&gt; immediately exit on entry.<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Phil Dennis-Jordan &lt;<a href=3D"mailto:phil@philj=
ordan.eu" target=3D"_blank">phil@philjordan.eu</a>&gt;<br>
&gt;&gt; ---<br>
&gt;&gt; =C2=A0 target/i386/hvf/hvf.c | 2 +-<br>
&gt;&gt; =C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c<br>
&gt;&gt; index 3b6ee79fb2..936c31dbdd 100644<br>
&gt;&gt; --- a/target/i386/hvf/hvf.c<br>
&gt;&gt; +++ b/target/i386/hvf/hvf.c<br>
&gt;&gt; @@ -214,7 +214,7 @@ static inline bool <br>
&gt;&gt; apic_bus_freq_is_known(CPUX86State *env)<br>
&gt;&gt; =C2=A0 =C2=A0 void hvf_kick_vcpu_thread(CPUState *cpu)<br>
&gt;&gt; =C2=A0 {<br>
&gt;&gt; -=C2=A0=C2=A0=C2=A0 cpus_kick_thread(cpu);<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 cpu-&gt;thread_kicked =3D true;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hv_vcpu_interrupt(&amp;cpu-&gt;acce=
l-&gt;fd, 1);<br>
&gt;&gt; =C2=A0 }<br>
&gt;<br>
SIG_IPI is macOS crutch handled in XNU kernel that was essential until <br>
Phil submitted proper kick support with hv_vcpu_interrupt().<br>
<br>
</blockquote></div></div><div dir=3D"auto"><div dir=3D"auto"><span style=3D=
"color:rgb(0,0,0);font-family:&#39;-apple-system&#39;,&#39;helveticaneue&#3=
9;;font-size:15px;font-style:normal;font-weight:400;letter-spacing:normal;t=
ext-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;text=
-decoration:none;display:inline!important;float:none">Ah yes, perhaps it al=
lowed exit from hv_vcpu_run(). hv_vcpu_run_until() definitely does not exit=
 early upon receiving SIG_IPI (USR1).</span></div><div dir=3D"auto"><span s=
tyle=3D"color:rgb(0,0,0);font-family:&#39;-apple-system&#39;,&#39;helvetica=
neue&#39;;font-size:15px;font-style:normal;font-weight:400;letter-spacing:n=
ormal;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0=
px;text-decoration:none;display:inline!important;float:none"><br></span></d=
iv></div><div dir=3D"auto"><br></div>

--0000000000009105e80628e77171--

