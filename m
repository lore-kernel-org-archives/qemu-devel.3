Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E8E2C5DF8C
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 04:38:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwuXY-0000op-P7; Thu, 20 Aug 2026 00:38:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <54weasels@gmail.com>)
 id 1wwuXX-0000oS-Lz
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 00:38:07 -0400
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <54weasels@gmail.com>)
 id 1wwuXV-0002VX-Cs
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 00:38:07 -0400
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-44ae14b4fd6so814305fac.2
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 21:38:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787200684; cv=none;
 d=google.com; s=arc-20260327;
 b=lFc/LrhLasMFkuz+7kQT1BjGvQtvvJo0Sav6uPXaO7ZH8zWWB3ZMDVi23D4uZro+7J
 4mf2Q5XM3dEREYnzXn+i0lg3PfsqU4O3/5ikORuGGXs9UeC/CA8iLvWSGe0ajYKyMoLO
 IZxJXGp7vP3kDb5FxSUbVGXeaVP0CN5zrqwvT2jDdUr4vdd3bAzr1yS26M86wq3YRpN0
 wTglPQFlC6gZFZEEopdL33734yX7oHxGfVUxj4NOmiTp/iclm3M3zLEbrgHh1WV35fcc
 K6AyzC82r/0TpXjph7j+GtBhujcOXNhHXEgRZ+jqwyJTsLDiZsKta0ADklWQjFv7uP6r
 Xdlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=O+SJ4ouO8DER862HmtBQSJ0QwR/GgCYHEpXacXbpjgY=;
 fh=LOst6OIdEaBMuurtzYNBHMLjQ7N+6u1lDyAAXE75Ms4=;
 b=K12sm216ui+4LPO4S5arlAZRF/0e1LFtM3xxPC2Z1ZG3ykBaHVisXtVLG/jAy8/5Ol
 YCZBq8Yrp9jKBzXQUvXNZdM/kFP2+s9Q/z9mLzJ/9kym0CdP0VwIv0rmvwMby7TMkbI+
 YyBKkf+sguhOkNp1hQqLYJ7AtjI1GU1KRJvuetevkGTusV5DMzDE4b0Mh4LAXf7IeaV0
 YtWSeD99iRzXSDD5MFwrcJkZ12VqNJNVXBlBKs9zniVoV3ja7Sx1duWoeq9oZs1Qb86T
 hM9c+d0WtiJTVOX0sM746bmbrndtjDCQ3pGrrrtoR5JvvDvp99XK1AOGKSuiCcFx37Lc
 iegg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787200684; x=1787805484; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=O+SJ4ouO8DER862HmtBQSJ0QwR/GgCYHEpXacXbpjgY=;
 b=mCEipcrgOS9iaD2sRipaQMSK7DK/xlCEWrTX3UwHw5uniI3LKGjrR9zhhqQuFM2oV9
 OF9MzACrHRYV5IBmBj4Naej1OIKrmK7tTixss4u1MuZpX4WqdA7arYgR5DNB9oe1PjSA
 cJX6gs7egBMdqNu/oHIAsXHVXYil6HX+siYfL43Wg1yai0SIODUVhtzVNqsoe8LuPwZ+
 0Cxc/pB0+p9cKAFpsB741zT3hzg8IqE+hGKl3qQFWzk0ZiZRkEt1iIPOZ6vJtMP4VM6K
 g4ifyyu+8KyeaNTbEtuSmh6nuL9ucFYbPOxFGDSWKvtf+NEkJv+rah4nvH5ylo57Va6D
 A3RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787200684; x=1787805484;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=O+SJ4ouO8DER862HmtBQSJ0QwR/GgCYHEpXacXbpjgY=;
 b=MbrboYcZJlcAht+Pjsp1qZTpj61L8SXCa/E6FimoAs4MDKtUffO6Yf7WyFCI6Dr1d2
 upyQFyRoQx3zFd6emNkdXdIxbAQCq10Fh8Xwnu4mDjWLz8B2Mgg1aYhK11kTagDiLfVu
 OEeS5yz50iWtMvWp/tt8cOKF7al2FXP5i1DtSD24HxYL8GuQz+SgZ7hCRoarWKMun49M
 g0AMxdL9xOJNl4N/I7E3j2fawchPPMTuPjUL/BJyI64AHkJrB0EYMKf0arxxIni1frHy
 Y8KMI+vW05ehFDG/yO8SOPcdurew9YREWau4J5FFH+Z8xSvdwU7QfVDzO/DofaHBcFJ8
 zuCg==
X-Gm-Message-State: AOJu0YzHEgovyIYktloG5GP6XpPToYQ4z6rWPgnG8kxlda/WXyjhv5CH
 fHq3KKPFOKu+Wsg0bk1x7bP1YjCdDSR2vGabipbe0GgIjPlwlj/EkEIVm//+yVFy61zuYNc52Kh
 hlJFN7QfCuIwdgwVSBk9yFfRC3i6tvlo=
X-Gm-Gg: AR+sD13hKZzZOEBmteKg9lMZajYEBvhjhuj3rSYarqcuGJPOKGRupP3Vz0Zg0UVjO6o
 NOos+71AF6HwnuenN4kiSLOOgiy0JijXoy+KPOLQSbe5fJl1uRqk3mQ3a0+leH3/NIUu4S46gsD
 d1Mgr3Ry6bHFkFO2J0TDD5D4FPMz6RcN0+5vhLQB9D09kVsH7np491bDJSWC31bR8nr8CIeB25W
 Fd8RMOopN593hcGUKP/JihtawYIekuAaDQYTPvnYk3Fn/D+fr1EhA8uCLX/qfZ2qwtCb9u90Ams
 ++A7V3k3P9FNz3D3Rfn1QAZBFS3vzii1QtIsPNj74wS8QQ==
X-Received: by 2002:a05:6870:c210:b0:45e:caa2:4ea with SMTP id
 586e51a60fabf-462f653f83cmr10421660fac.6.1787200683673; Wed, 19 Aug 2026
 21:38:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260818022225.31801-1-54weasels@gmail.com>
 <20260818022225.31801-3-54weasels@gmail.com>
 <a9c04b36-c217-c0f7-0328-70c89d5ca667@eik.bme.hu>
In-Reply-To: <a9c04b36-c217-c0f7-0328-70c89d5ca667@eik.bme.hu>
From: Purr Box <54weasels@gmail.com>
Date: Wed, 19 Aug 2026 21:37:52 -0700
X-Gm-Features: AcwNN1UsLAB72LUlqjzB4aFmEe0CnyOvRDu1y69P6mGXh3QkRmBYHYZ9k3QqOOs
Message-ID: <CAFWf6u-D2WJA01gz=eHgwShtt9si3_R-7FJvfTPDRNQFyt17EA@mail.gmail.com>
Subject: Re: [PATCH v4 2/6] target/m68k: Fix fsave/frestore for 68881 FPU
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, laurent@vivier.eu
Content-Type: multipart/alternative; boundary="000000000000e48e5f065973154d"
Received-SPF: pass client-ip=2001:4860:4864:20::2a;
 envelope-from=54weasels@gmail.com; helo=mail-oa1-x2a.google.com
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

--000000000000e48e5f065973154d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Zoltan,

Thanks for the review!
I've refactored the logic for v5. I removed the redundant M68040 checks in
frestore (keeping just the FIXME), and streamlined fsave so that it
uniformly checks for M68K_FEATURE_FPU, writing an IDLE frame (0x41000000)
for the 68040 and a NULL frame (0x00000000) for the 68881/68882.
Also, thanks for the tip on the Context: tag. I've updated my script to
inject it below the --- separator in the .patch files so it stays off the
permanent git commit log while remaining visible to reviewers.

I'll wait a bit longer to see if there are comments on the rest of the
series before spinning new patches.

Dan.

On Tue, Aug 18, 2026 at 3:52=E2=80=AFAM BALATON Zoltan <balaton@eik.bme.hu>=
 wrote:

> On Mon, 17 Aug 2026, 54weasels wrote:
> > High level description:
> > The 68881/68882 FPUs require fsave/frestore instructions to read/write
> state frames. QEMU only fully implemented this for the 68040. The Sun-3
> uses a 68881 FPU, and the boot ROM executes `fsave` to probe FPU presence=
.
> This patch adds basic 68881 FPU state frame handling (NULL frame) to
> accurately simulate an idle FPU state.
> >
> > Impact on existing functionality:
> > Fixes FPU detection for 68881/68882 across all M68k boards without
> affecting 68040 specific state logic.
>
> Comments such as the next Context: should go below the --- as everything
> before that is part of the commit message. In QEMU a Context: tag is not
> commonly used so I think you want this as a comment not part of the
> commit message.
>
> > Context: This patch was originally submitted as part of the monolithic
> Sun-3 Machine Emulation series (
> https://patchew.org/QEMU/20260503015756.99176-1-54weasels@gmail.com/) and
> has been split into atomic components.
> > ---
> > target/m68k/translate.c | 20 ++++++++++++++++----
> > 1 file changed, 16 insertions(+), 4 deletions(-)
> >
> > diff --git a/target/m68k/translate.c b/target/m68k/translate.c
> > index 138c89d3e5..bdf619883c 100644
> > --- a/target/m68k/translate.c
> > +++ b/target/m68k/translate.c
> > @@ -5364,11 +5364,19 @@ DISAS_INSN(frestore)
> >         gen_exception(s, s->base.pc_next, EXCP_PRIVILEGE);
> >         return;
> >     }
> > -    if (m68k_feature(s->env, M68K_FEATURE_M68040)) {
> > +    if (m68k_feature(s->env, M68K_FEATURE_M68040) ||
> > +        m68k_feature(s->env, M68K_FEATURE_FPU)) {
>
> M68020+ (including M68040) has FPU set so no need to keep that test and
> can be replaced with M68K_FEATURE_FPU.
>
> >         SRC_EA(env, addr, OS_LONG, 0, NULL);
> > -        /* FIXME: check the state frame */
> > +        if (m68k_feature(s->env, M68K_FEATURE_M68040)) {
> > +            /* FIXME: check the state frame */
> > +        } else {
>
> What about M68060 or other CPUs with built-in FPU? As none of these do
> anything maybe the if/else is not needed and can just keep the FIXME
> comment?
>
> > +            /*
> > +             * 68881/68882 FRESTORE: read the state frame
> > +             * (NULL frame is 4 bytes)
> > +             */
> > +        }
> >     } else {
> > -        disas_undef(env, s, insn);
> > +        disas_undef_fpu(env, s, insn);
> >     }
> > }
> >
> > @@ -5383,8 +5391,12 @@ DISAS_INSN(fsave)
> >         /* always write IDLE */
> >         TCGv idle =3D tcg_constant_i32(0x41000000);
> >         DEST_EA(env, insn, OS_LONG, idle, NULL);
> > +    } else if (m68k_feature(s->env, M68K_FEATURE_FPU)) {
> > +        /* 68881/68882 FSAVE: always write NULL frame */
> > +        TCGv null_frame =3D tcg_constant_i32(0x00000000);
> > +        DEST_EA(env, insn, OS_LONG, null_frame, NULL);
>
> Same comment as above about CPUs with FPU. Maybe there should be only one
> block for M68K_FEATURE_FPU replacing M68K_FEATURE_M68040 and a switch for
> setting the frame value?
>
> Regards,
> BALATON Zoltan
>
> >     } else {
> > -        disas_undef(env, s, insn);
> > +        disas_undef_fpu(env, s, insn);
> >     }
> > }
> > #endif
> >
>

--000000000000e48e5f065973154d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Zoltan,<br><br>Thanks for the review!<div>I&#39;ve refa=
ctored the logic for v5. I removed the redundant M68040 checks in frestore =
(keeping just the FIXME), and streamlined fsave so that it uniformly checks=
 for M68K_FEATURE_FPU, writing an IDLE frame (0x41000000) for the 68040 and=
 a NULL frame (0x00000000) for the 68881/68882.<br>Also, thanks for the tip=
 on the Context: tag. I&#39;ve updated my script to inject it below the ---=
 separator in the .patch files so it stays off the permanent git commit log=
 while remaining visible to reviewers.<br><br>I&#39;ll wait a bit longer to=
 see if there are comments on the rest of the series before spinning new pa=
tches.<br><br>Dan.</div></div><br><div class=3D"gmail_quote gmail_quote_con=
tainer"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Aug 18, 2026 at 3:52=
=E2=80=AFAM BALATON Zoltan &lt;<a href=3D"mailto:balaton@eik.bme.hu">balato=
n@eik.bme.hu</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">On Mon, 17 Aug 2026, 54weasels wrote:<br>
&gt; High level description:<br>
&gt; The 68881/68882 FPUs require fsave/frestore instructions to read/write=
 state frames. QEMU only fully implemented this for the 68040. The Sun-3 us=
es a 68881 FPU, and the boot ROM executes `fsave` to probe FPU presence. Th=
is patch adds basic 68881 FPU state frame handling (NULL frame) to accurate=
ly simulate an idle FPU state.<br>
&gt;<br>
&gt; Impact on existing functionality:<br>
&gt; Fixes FPU detection for 68881/68882 across all M68k boards without aff=
ecting 68040 specific state logic.<br>
<br>
Comments such as the next Context: should go below the --- as everything <b=
r>
before that is part of the commit message. In QEMU a Context: tag is not <b=
r>
commonly used so I think you want this as a comment not part of the <br>
commit message.<br>
<br>
&gt; Context: This patch was originally submitted as part of the monolithic=
 Sun-3 Machine Emulation series (<a href=3D"https://patchew.org/QEMU/202605=
03015756.99176-1-54weasels@gmail.com/" rel=3D"noreferrer" target=3D"_blank"=
>https://patchew.org/QEMU/20260503015756.99176-1-54weasels@gmail.com/</a>) =
and has been split into atomic components.<br>
&gt; ---<br>
&gt; target/m68k/translate.c | 20 ++++++++++++++++----<br>
&gt; 1 file changed, 16 insertions(+), 4 deletions(-)<br>
&gt;<br>
&gt; diff --git a/target/m68k/translate.c b/target/m68k/translate.c<br>
&gt; index 138c89d3e5..bdf619883c 100644<br>
&gt; --- a/target/m68k/translate.c<br>
&gt; +++ b/target/m68k/translate.c<br>
&gt; @@ -5364,11 +5364,19 @@ DISAS_INSN(frestore)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gen_exception(s, s-&gt;base.pc_next, =
EXCP_PRIVILEGE);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
&gt;=C2=A0 =C2=A0 =C2=A0}<br>
&gt; -=C2=A0 =C2=A0 if (m68k_feature(s-&gt;env, M68K_FEATURE_M68040)) {<br>
&gt; +=C2=A0 =C2=A0 if (m68k_feature(s-&gt;env, M68K_FEATURE_M68040) ||<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 m68k_feature(s-&gt;env, M68K_FEATURE_FPU)=
) {<br>
<br>
M68020+ (including M68040) has FPU set so no need to keep that test and <br=
>
can be replaced with M68K_FEATURE_FPU.<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SRC_EA(env, addr, OS_LONG, 0, NULL);<=
br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* FIXME: check the state frame */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (m68k_feature(s-&gt;env, M68K_FEATURE_=
M68040)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* FIXME: check the state f=
rame */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
<br>
What about M68060 or other CPUs with built-in FPU? As none of these do <br>
anything maybe the if/else is not needed and can just keep the FIXME <br>
comment?<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* 68881/68882 FRESTOR=
E: read the state frame<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* (NULL frame is 4 by=
tes)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0} else {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 disas_undef(env, s, insn);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 disas_undef_fpu(env, s, insn);<br>
&gt;=C2=A0 =C2=A0 =C2=A0}<br>
&gt; }<br>
&gt;<br>
&gt; @@ -5383,8 +5391,12 @@ DISAS_INSN(fsave)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* always write IDLE */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TCGv idle =3D tcg_constant_i32(0x4100=
0000);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DEST_EA(env, insn, OS_LONG, idle, NUL=
L);<br>
&gt; +=C2=A0 =C2=A0 } else if (m68k_feature(s-&gt;env, M68K_FEATURE_FPU)) {=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* 68881/68882 FSAVE: always write NULL f=
rame */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 TCGv null_frame =3D tcg_constant_i32(0x00=
000000);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 DEST_EA(env, insn, OS_LONG, null_frame, N=
ULL);<br>
<br>
Same comment as above about CPUs with FPU. Maybe there should be only one <=
br>
block for M68K_FEATURE_FPU replacing M68K_FEATURE_M68040 and a switch for <=
br>
setting the frame value?<br>
<br>
Regards,<br>
BALATON Zoltan<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0} else {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 disas_undef(env, s, insn);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 disas_undef_fpu(env, s, insn);<br>
&gt;=C2=A0 =C2=A0 =C2=A0}<br>
&gt; }<br>
&gt; #endif<br>
&gt;<br>
</blockquote></div>

--000000000000e48e5f065973154d--

