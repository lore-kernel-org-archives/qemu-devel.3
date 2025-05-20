Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 950B0C3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 09:00:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHIoi-00036w-2s; Tue, 20 May 2025 04:59:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1uHIog-00036X-2J; Tue, 20 May 2025 04:59:18 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1uHIob-0007GJ-BF; Tue, 20 May 2025 04:59:15 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2320e53167dso31757975ad.3; 
 Tue, 20 May 2025 01:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747731550; x=1748336350; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PXmfsoToG8zDFHlkBLrJtcgVzVxtuNXwxm38JwXxDv0=;
 b=S6evVoviCHC3DNeWwkJqlll+WG2IPzRH8U1cYm/OGd/g9U3FmAkWPw8BN8vWWMVWR/
 iHwzIQnMXhE854do+mWHaV6qM1INnKW39RbBSIfFceyIml5f4DEOnvYO25BWMRxfjiYt
 NQWBBT5YRoTU9iIUL/dSSnSTnXMwVybkiT7OLw0RHIbKnJr4cY6cLHQdnu3TvjECMVh3
 PhQQrO5Rzty16nPG8Slp25tbCwme1yWcMuOGctL0D4ERuRIallP1mevpwZv/zDsRbJxk
 h/Cst0OS8Y8QMlStfgfrmXPKoMuEpwOczj32SBu+3grQWE0iT3RpOZ3SD1RwNHTUbNH2
 ZgkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747731550; x=1748336350;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PXmfsoToG8zDFHlkBLrJtcgVzVxtuNXwxm38JwXxDv0=;
 b=sSyQhH1u18EC52RnpYJQc4IAVTcXe3RIJUEazL3T9arswt73Gjv0ZXngMJsOCf8ZXq
 y1Pywuh+V1uNTKkSAa//uybJ2Dk1wQuTyl/0KzwxDHGHbZInEsGwystC2NiK6MQ2guMp
 QI8+BNzYwNXyorJqJB8FiLhgQ8a3RYZPtmopNJvfq8ELr200tnx/GOoZhwWKcVKg83kI
 759eJZQ6bpmsPvJW8aOshWHg4YSp1M28Xw2SwnuOAoReEcdTYoHx7E6zHbFyPIKlx4me
 xjzbHCwk2ZW5NtAjXcm+eKejrLt5VHUpPr0o++AKu5zo5SYcWagjTb17h0Pz8+Xj8hjX
 b5Nw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUv0FNc7TxS0m+5H6LX+GeZmXRGPjrefTSpWaZM3ebqgZF6zYnMdk9laFt5q1UelbeH7ouSZXQJUQ==@nongnu.org,
 AJvYcCWsw7OglpQEwQxvbcbrUaBrLdZsJiZD97JoJrSMjm3QA4HnyVr9KYrtYKydJBbrX351BX4iUu6cJNnBZQ==@nongnu.org
X-Gm-Message-State: AOJu0YyNzsgSfOYnuvmFXo9JJNZOTSrMHYdT1G2K3vp+M/AnYanJGjNP
 o/TtbFzW1Ld1OTlMyyKfPIFpXaMKxRcrISWX8ZJaPp8E9LfXX6xpML2HBt42mY9CI+uos8iXr+K
 7uRdDlayD3wxyMKJttgSl+w42OnEX9S0=
X-Gm-Gg: ASbGncsAUYxEwq9vnQHpYa/Iqb3im0FMa7Q8Alps3eWcqRpYyOLs2HZkYAfLQpUBVzK
 sfGk9jK75vlRlcVoDQwcODcLEmPZPyDixF+TthG7T9dwkOF63JcTR/15lACh9dqMOMuGXfeKHme
 h8JOmXudUqgotswpBc4aPPjKqzemKni/4=
X-Google-Smtp-Source: AGHT+IE/C3e7mLcKT+QLorbh4JRV8i0pgDeMQGL/RLAFOzAOz7RKP/NsrydHjZkQ6Cdp5gv2X1FRr/G3+xtJ5fJTFPI=
X-Received: by 2002:a17:903:46c6:b0:224:10a2:cad5 with SMTP id
 d9443c01a7336-231d43dcae5mr249045825ad.10.1747731550455; Tue, 20 May 2025
 01:59:10 -0700 (PDT)
MIME-Version: 1.0
References: <20250513141448.297946-1-chigot@adacore.com>
 <20250513141448.297946-3-chigot@adacore.com>
 <3314f721-9c5e-479b-9fcc-3b8a021efde9@linaro.org>
 <CAFEAcA8vKNkfKgp_Yymo9NA1=E2XJYXAMTgO3z6q6DHgqkAwRw@mail.gmail.com>
In-Reply-To: <CAFEAcA8vKNkfKgp_Yymo9NA1=E2XJYXAMTgO3z6q6DHgqkAwRw@mail.gmail.com>
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Tue, 20 May 2025 09:58:56 +0100
X-Gm-Features: AX0GCFufR3sFExf75WKEOarNbJYPI8XJJ56TCTvYmgc6P1qd08gyAOR-sHVC2jU
Message-ID: <CAJy5ezoCOG+N5dQ9z0zCmd3YX1sE0ZJwQp=G1iRdkGf3V=aLpg@mail.gmail.com>
Subject: Re: [PATCH 2/4] hw/intc/arm_gic: introduce a first-cpu-index property
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>, qemu-devel@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-arm@nongnu.org,
 alistair@alistair23.me, Frederic Konrad <konrad.frederic@yahoo.fr>
Content-Type: multipart/alternative; boundary="0000000000003a4db706358d763a"
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--0000000000003a4db706358d763a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 19, 2025 at 5:26=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org>
wrote:

> On Tue, 13 May 2025 at 16:39, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.=
org>
> wrote:
> >
> > On 13/5/25 16:14, Cl=C3=A9ment Chigot wrote:
> > > From: Frederic Konrad <konrad.frederic@yahoo.fr>
> > >
> > > This introduces a first-cpu-index property to the arm-gic, as some SO=
Cs
> > > could have two separate GIC (ie: the zynqmp).
> > >
> > > Signed-off-by: Cl=C3=A9ment Chigot <chigot@adacore.com>
> > > ---
> > >   hw/intc/arm_gic.c                | 2 +-
> > >   hw/intc/arm_gic_common.c         | 1 +
> > >   include/hw/intc/arm_gic_common.h | 2 ++
> > >   3 files changed, 4 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
> > > index d18bef40fc..899f133363 100644
> > > --- a/hw/intc/arm_gic.c
> > > +++ b/hw/intc/arm_gic.c
> > > @@ -59,7 +59,7 @@ static const uint8_t gic_id_gicv2[] =3D {
> > >   static inline int gic_get_current_cpu(GICState *s)
> > >   {
> > >       if (!qtest_enabled() && s->num_cpu > 1) {
> > > -        return current_cpu->cpu_index;
> > > +        return current_cpu->cpu_index - s->first_cpu_index;
> >
> > Note, CPUState::cpu_index is meant for accelerators code and shouldn't
> > be used in hw/ (in particular because it vary when using hotplug).
>
> Mmm. I think my ideal solution for that would be that we
> put the CPU index into the MemTxAttrs (requester_id, perhaps
> with some extra flag that it's not a PCI requester ID).
> Then every device that's looking at current_cpu to figure
> out which CPU actually called it would be able to stop
> doing that. We'd still have the "OK, so what number does
> the GIC think this CPU is?" question, though.
>
> For telling the GIC which CPUs it has connected to it, my
> instinct is to say that ideally we'd have the GIC have
> something like an array of link properties, and the board
> or SoC code passes the GIC a pointer to each CPU in the
> order it wants them to be.
>
> But that would be quite a bit of fiddling around to achieve,
> so I think I'm OK with the approach in this patch, especially
> since the GICv2 is pretty well obsolete at this point.
>
> (GICv3 also assumes "starting from zero", in several places
> where it loops from 0 to s->num_cpu calling qemu_get_cpu().
> Link properties is probably what I'm going to end up doing with
> the GICv5 design.)
>
> One note: if you add a new property to the GIC, please
> also add documentation of it to the "QEMU interface" comment
> in include/hw/intc/arm_gic.h.
>
>
>
Yes, I agree with Peter.

Another option is to have the GIC expose a per-cpu MR for the GICC
interfaces.
We would need to map these onto a per-cpu address-space. I think this is
the way
it works on real HW GICv2 with a per-cpu AMBA port. A problem with this
approach
is that it (in QEMU) doesn't scale very well to other GIC's with large
numbers of cores.
So the side-band signals with CPU index in memtxattrs sounds good to me!

Cheers,
Edgar

--0000000000003a4db706358d763a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, May 19,=
 2025 at 5:26=E2=80=AFPM Peter Maydell &lt;<a href=3D"mailto:peter.maydell@=
linaro.org">peter.maydell@linaro.org</a>&gt; wrote:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">On Tue, 13 May 2025 at 16:39, Philippe =
Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linaro.org" target=3D"_blan=
k">philmd@linaro.org</a>&gt; wrote:<br>
&gt;<br>
&gt; On 13/5/25 16:14, Cl=C3=A9ment Chigot wrote:<br>
&gt; &gt; From: Frederic Konrad &lt;<a href=3D"mailto:konrad.frederic@yahoo=
.fr" target=3D"_blank">konrad.frederic@yahoo.fr</a>&gt;<br>
&gt; &gt;<br>
&gt; &gt; This introduces a first-cpu-index property to the arm-gic, as som=
e SOCs<br>
&gt; &gt; could have two separate GIC (ie: the zynqmp).<br>
&gt; &gt;<br>
&gt; &gt; Signed-off-by: Cl=C3=A9ment Chigot &lt;<a href=3D"mailto:chigot@a=
dacore.com" target=3D"_blank">chigot@adacore.com</a>&gt;<br>
&gt; &gt; ---<br>
&gt; &gt;=C2=A0 =C2=A0hw/intc/arm_gic.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 | 2 +-<br>
&gt; &gt;=C2=A0 =C2=A0hw/intc/arm_gic_common.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0| 1 +<br>
&gt; &gt;=C2=A0 =C2=A0include/hw/intc/arm_gic_common.h | 2 ++<br>
&gt; &gt;=C2=A0 =C2=A03 files changed, 4 insertions(+), 1 deletion(-)<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c<br>
&gt; &gt; index d18bef40fc..899f133363 100644<br>
&gt; &gt; --- a/hw/intc/arm_gic.c<br>
&gt; &gt; +++ b/hw/intc/arm_gic.c<br>
&gt; &gt; @@ -59,7 +59,7 @@ static const uint8_t gic_id_gicv2[] =3D {<br>
&gt; &gt;=C2=A0 =C2=A0static inline int gic_get_current_cpu(GICState *s)<br=
>
&gt; &gt;=C2=A0 =C2=A0{<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!qtest_enabled() &amp;&amp; s-&gt;n=
um_cpu &gt; 1) {<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return current_cpu-&gt;cpu_index;<br=
>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return current_cpu-&gt;cpu_index - s=
-&gt;first_cpu_index;<br>
&gt;<br>
&gt; Note, CPUState::cpu_index is meant for accelerators code and shouldn&#=
39;t<br>
&gt; be used in hw/ (in particular because it vary when using hotplug).<br>
<br>
Mmm. I think my ideal solution for that would be that we<br>
put the CPU index into the MemTxAttrs (requester_id, perhaps<br>
with some extra flag that it&#39;s not a PCI requester ID).<br>
Then every device that&#39;s looking at current_cpu to figure<br>
out which CPU actually called it would be able to stop<br>
doing that. We&#39;d still have the &quot;OK, so what number does<br>
the GIC think this CPU is?&quot; question, though.<br>
<br>
For telling the GIC which CPUs it has connected to it, my<br>
instinct is to say that ideally we&#39;d have the GIC have<br>
something like an array of link properties, and the board<br>
or SoC code passes the GIC a pointer to each CPU in the<br>
order it wants them to be.<br>
<br>
But that would be quite a bit of fiddling around to achieve,<br>
so I think I&#39;m OK with the approach in this patch, especially<br>
since the GICv2 is pretty well obsolete at this point.<br>
<br>
(GICv3 also assumes &quot;starting from zero&quot;, in several places<br>
where it loops from 0 to s-&gt;num_cpu calling qemu_get_cpu().<br>
Link properties is probably what I&#39;m going to end up doing with<br>
the GICv5 design.)<br>
<br>
One note: if you add a new property to the GIC, please<br>
also add documentation of it to the &quot;QEMU interface&quot; comment<br>
in include/hw/intc/arm_gic.h.<br>
<br><br></blockquote><div><br></div><div>Yes, I agree with Peter.</div><div=
><br></div><div>Another option is to have the GIC expose a per-cpu MR for t=
he GICC interfaces.</div><div>We would need to map these onto a per-cpu add=
ress-space. I think this is the way</div><div>it works on real HW GICv2 wit=
h a per-cpu AMBA port. A problem with this approach</div><div>is that it (i=
n QEMU) doesn&#39;t scale very well to other GIC&#39;s with large numbers o=
f cores.</div><div>So the side-band signals with CPU index in memtxattrs=C2=
=A0sounds good to me!</div><div><br></div><div>Cheers,</div><div>Edgar</div=
><div><br></div><div><br></div></div></div>

--0000000000003a4db706358d763a--

