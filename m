Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF9AFC44524
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 08:49:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wljgU-000250-N6; Mon, 20 Jul 2026 04:49:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harsh.prateek.bora@gmail.com>)
 id 1wljgL-0001zs-Rj
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 04:49:08 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <harsh.prateek.bora@gmail.com>)
 id 1wljgI-00045N-PX
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 04:49:00 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-c15ca7a7ca9so687662966b.0
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 01:48:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784537337; cv=none;
 d=google.com; s=arc-20260327;
 b=h6ON0L448wcneVQ70G15fwcKp9U/KC4V7wGe+A3VC+d7voTzy+2KiRm9qExfrzI3is
 NMio6+owwS82z47bOARlew/L7Gr+JOX5RocixAnd5ruArhOypm7FzkuJlME7jKRutvFR
 ERtdgTma1B3EYk3UAHacrTtVyVZ5Oqq8CNwdI1YLlgEwLu2G0lYW/kGUd0d4BcghilIP
 EoVOHB6gOO6tx4YnyMEW2dgZLJ48+NzkLTnpaxzODGg6zsCv9iRmCo1hyjPar6d5ZQXy
 j1MFmQ1BcPyAXdrsTnR1gTRKBPk7r8zq4i9e5SwsPCTw8dPDJfJAzRcNGFYEfUT4ehKL
 Sk9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=rm8z9NYOGt/sbJGAZGsuA6m49jiXeXGY3jUyy1j/Cc8=;
 fh=73W7Ai9r/ud1TUtB+afMqkPQHTtJWUNcu/T9z3b7Rms=;
 b=fQj9Z+ePirzM9u6bEBRPeXVbAYptA8EdnDI45Yc4nlA+DJLWr74XeopHC6rVB3JHxx
 c1eixBJFgM9AQD43y4m9Xj8o0Y18V6i1UADChmw80pA7o/bBDr8ZLQPX5/6EDs1YNozt
 2DUYiZHNCDvqtiv5jbi/KhMz05aB+wcD0c5BRcRANOqfQcc3vq/xPCAINwg7Z3Xva7yB
 TfO4+IizKO+1XkKlAHVg3f8Ni2yKOO4sWKv18UU4tk7g9Uow9BJgzfXBg+YRLPRS5PHn
 07W0tqzuZELjIDFXEJvLN0j4DGsb3lfhC/2qIHepp10zsQYWIH+SMfVhyDmtvI/m8h3D
 bIxA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784537337; x=1785142137; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=rm8z9NYOGt/sbJGAZGsuA6m49jiXeXGY3jUyy1j/Cc8=;
 b=c7v95CA4AyRBIy9jn04rZCnF2R3+Dnu8T91iFEPX5Ht92SEyD+3pCqLazUTMR971Ey
 B1MTL+zEDyP54Vr3es6wcQsgXiHpSm6qi6lM2gT0CFVSOuKA0nIQpL8MeJ/EqY4X5Q9Z
 1Tkhwy3q0R7MV+tObDsL9O+8AGEuTNKlJuqiRemQtk6DklTD6B7CSuSXzRc0rAdHiUfK
 Hcc6oKH8RyKPsqU4ytpIFbAKIRgxHytAiqPEdn2VEkl2UM3JSLR9iFx4te5VUXaT9XMw
 cqj4TCmZS8mdIVNxf+4QFpWkdtW1vHOsSdfSR0GBQTrCyu7MSXGDLiIzR//Q74d4+e6X
 H0bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784537337; x=1785142137;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=rm8z9NYOGt/sbJGAZGsuA6m49jiXeXGY3jUyy1j/Cc8=;
 b=A5pIMtZdhYuQsfrjMMizkqb3wf6KDt4GeUpYlo5ViPZkSRTZC9OkUb32TKoo29C8jm
 dhYgUmShxeK70r9GG5XacZN759VF8F2W+1O8mVoSjNbYnTRpvb+udQ143rJTi+B2mq/p
 /dfI9RFatzPssXsbgjDnMVUdAvK00WbaVnQdd6TxcE9ZfZjd/AnJ+aE8aJPUGbR4Xdjc
 bxjtezz+a3T25Z/2xBsLcxCJpEJAKvR3A3193xWZW8YhQudjJXfPVP/Yx95nN51FdV+A
 iv4bq0xJPkFOlEpXQ5sZ3ncRuLC7d4qvOCKiG3lU4M9BdXC2/4b8oqjj7G6qU+WCWYkH
 l89w==
X-Gm-Message-State: AOJu0Yytfrwiam/7Ypu9F0BtpB9OtRX1MxXDn99plTca05I29D3JsLlk
 bHIlXfcfiWbbJ34HK/xAXOMIJIf1KSJbBgVE+A/0J2pNwZBOW0WNXX9FE/fp7fVyGHNHkyVc1ZV
 Pc6sJodZKcJKo6khLe+dtcJ8eBjD6ktY=
X-Gm-Gg: AfdE7ck7S2Xg96V0Crev9kimgXXKfN21jYdl/Ks48JiFFqlckCbdE+iazKOFreW0iFA
 bWX2XZ6j2zkURL7QZAFF9i/szGFsLzxulBVi23JpbxC26NoblGqAVDNMGKakv5Je0M6qH+Xxf35
 Gwg77XKMMqQ5cRMlWq2TuySEoA0YN0s8To6Tj1QSBfpU8OBVr+PBSh7jZlek5YdrI3rkO57gsrL
 h6vo09f8O6jg1XfLlAIdklZpJcup+s/pejY4hPylNkNZIwKz2B+HO0+F5Rgo5LCKvfvdRJ8413U
 uyh9rcSi9rznxczbnnIQFWaHGD6nJXE=
X-Received: by 2002:a17:906:eece:b0:c0d:cd71:6463 with SMTP id
 a640c23a62f3a-c16b46b6474mr542387666b.16.1784537336531; Mon, 20 Jul 2026
 01:48:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260709095056.1803725-1-peter.maydell@linaro.org>
 <20260709201237.46ba7f2d-72-amachhiw@linux.ibm.com>
 <CAFEAcA8__tL8Dh5XwAK_GifA2boh1uMfL_eZgMTFvyMq15hLwA@mail.gmail.com>
In-Reply-To: <CAFEAcA8__tL8Dh5XwAK_GifA2boh1uMfL_eZgMTFvyMq15hLwA@mail.gmail.com>
From: Harsh Prateek Bora <harsh.prateek.bora@gmail.com>
Date: Mon, 20 Jul 2026 14:18:43 +0530
X-Gm-Features: AUfX_mzBYFsGb_kiv4ETnPppPta-YU_azIP-8E44N_xcrAtTcyOeePoPgceJde4
Message-ID: <CAEuJdmrG_rRsivvfhEsVV+7y-q=NZ0L6hzxXPdgWGmX7OOLaHg@mail.gmail.com>
Subject: Re: [PATCH] target/ppc: Remove unused helper_lscbx()
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Nicholas Piggin <npiggin@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>, 
 Glenn Miles <milesg@linux.ibm.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>
Content-Type: multipart/alternative; boundary="000000000000084fe0065706fa80"
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=harsh.prateek.bora@gmail.com; helo=mail-ej1-x62a.google.com
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

--000000000000084fe0065706fa80
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Peter,

I am travelling till July end.
If it's urgent, Could you please take it via your next PR or I can take it
via next PPC PR in August.

Thanks
Harsh

On Mon, 20 Jul, 2026, 2:10=E2=80=AFpm Peter Maydell, <peter.maydell@linaro.=
org>
wrote:

> Ping: this has been reviewed, is somebody on the ppc side
> going to pick it up ?
>
> thanks
> -- PMM
>
> On Thu, 9 Jul 2026 at 15:46, Amit Machhiwal <amachhiw@linux.ibm.com>
> wrote:
> >
> > On 2026/07/09 10:50 AM, Peter Maydell wrote:
> > > The helper_lscbx() function isn't called anywhere.  It used to be
> > > used by the PPC 601 CPU support; we removed that in commit 005b69fdcc
> > > in 2022 but missed this helper function.
> > >
> > > Fixes: 005b69fdcc ("target/ppc: Remove PowerPC 601 CPUs")
> > > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > > ---
> > > This came to my attention because Coverity reported a
> > > "shifts into sign bit" issue in the function: CID 1663681
> > > ---
> > >  target/ppc/helper.h     |  1 -
> > >  target/ppc/mem_helper.c | 28 ----------------------------
> > >  2 files changed, 29 deletions(-)
> >
> > "git grep lscbx" returns only the declaration in helper.h and the
> > definition in mem_helper.c -- no TCG translator references, no
> > gen_lscbx, nothing in translate.c. Confirmed dead code with zero
> > callers. Thanks for the cleanup.
> >
> > Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> >
> > Thanks,
> > Amit
> >
> > >
> > > diff --git a/target/ppc/helper.h b/target/ppc/helper.h
> > > index e99c8c824b..6b2d19a3ad 100644
> > > --- a/target/ppc/helper.h
> > > +++ b/target/ppc/helper.h
> > > @@ -54,7 +54,6 @@ DEF_HELPER_FLAGS_2(dcbzl, TCG_CALL_NO_WG, void, env=
,
> tl)
> > >  #endif
> > >  DEF_HELPER_FLAGS_2(icbi, TCG_CALL_NO_WG, void, env, tl)
> > >  DEF_HELPER_FLAGS_2(icbiep, TCG_CALL_NO_WG, void, env, tl)
> > > -DEF_HELPER_5(lscbx, tl, env, tl, i32, i32, i32)
> > >
> > >  #if defined(TARGET_PPC64)
> > >  DEF_HELPER_4(DIVDEU, i64, env, i64, i64, i32)
> > > diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
> > > index 119dc1df23..787ba2cdec 100644
> > > --- a/target/ppc/mem_helper.c
> > > +++ b/target/ppc/mem_helper.c
> > > @@ -367,34 +367,6 @@ void helper_icbiep(CPUPPCState *env, target_ulon=
g
> addr)
> > >  #endif
> > >  }
> > >
> > > -/* XXX: to be tested */
> > > -target_ulong helper_lscbx(CPUPPCState *env, target_ulong addr,
> uint32_t reg,
> > > -                          uint32_t ra, uint32_t rb)
> > > -{
> > > -    int i, c, d;
> > > -
> > > -    d =3D 24;
> > > -    for (i =3D 0; i < xer_bc; i++) {
> > > -        c =3D cpu_ldub_data_ra(env, addr, GETPC());
> > > -        addr =3D addr_add(env, addr, 1);
> > > -        /* ra (if not 0) and rb are never modified */
> > > -        if (likely(reg !=3D rb && (ra =3D=3D 0 || reg !=3D ra))) {
> > > -            env->gpr[reg] =3D (env->gpr[reg] & ~(0xFF << d)) | (c <<=
 d);
> > > -        }
> > > -        if (unlikely(c =3D=3D xer_cmp)) {
> > > -            break;
> > > -        }
> > > -        if (likely(d !=3D 0)) {
> > > -            d -=3D 8;
> > > -        } else {
> > > -            d =3D 24;
> > > -            reg++;
> > > -            reg =3D reg & 0x1F;
> > > -        }
> > > -    }
> > > -    return i;
> > > -}
> > > -
> > >
> /************************************************************************=
*****/
> > >  /* Altivec extension helpers */
> > >  #if HOST_BIG_ENDIAN
> > > --
> > > 2.43.0
>
>

--000000000000084fe0065706fa80
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Hi Peter,<div dir=3D"auto"><br></div><div dir=3D"auto">I =
am travelling till July end.</div><div dir=3D"auto">If it&#39;s urgent, Cou=
ld you please take it via your next PR or I can take it via next PPC PR in =
August.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Thanks=C2=A0</di=
v><div dir=3D"auto">Harsh</div></div><br><div class=3D"gmail_quote gmail_qu=
ote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, 20 Jul, 2026, =
2:10=E2=80=AFpm Peter Maydell, &lt;<a href=3D"mailto:peter.maydell@linaro.o=
rg">peter.maydell@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-l=
eft:1ex">Ping: this has been reviewed, is somebody on the ppc side<br>
going to pick it up ?<br>
<br>
thanks<br>
-- PMM<br>
<br>
On Thu, 9 Jul 2026 at 15:46, Amit Machhiwal &lt;<a href=3D"mailto:amachhiw@=
linux.ibm.com" target=3D"_blank" rel=3D"noreferrer">amachhiw@linux.ibm.com<=
/a>&gt; wrote:<br>
&gt;<br>
&gt; On 2026/07/09 10:50 AM, Peter Maydell wrote:<br>
&gt; &gt; The helper_lscbx() function isn&#39;t called anywhere.=C2=A0 It u=
sed to be<br>
&gt; &gt; used by the PPC 601 CPU support; we removed that in commit 005b69=
fdcc<br>
&gt; &gt; in 2022 but missed this helper function.<br>
&gt; &gt;<br>
&gt; &gt; Fixes: 005b69fdcc (&quot;target/ppc: Remove PowerPC 601 CPUs&quot=
;)<br>
&gt; &gt; Signed-off-by: Peter Maydell &lt;<a href=3D"mailto:peter.maydell@=
linaro.org" target=3D"_blank" rel=3D"noreferrer">peter.maydell@linaro.org</=
a>&gt;<br>
&gt; &gt; ---<br>
&gt; &gt; This came to my attention because Coverity reported a<br>
&gt; &gt; &quot;shifts into sign bit&quot; issue in the function: CID 16636=
81<br>
&gt; &gt; ---<br>
&gt; &gt;=C2=A0 target/ppc/helper.h=C2=A0 =C2=A0 =C2=A0|=C2=A0 1 -<br>
&gt; &gt;=C2=A0 target/ppc/mem_helper.c | 28 ----------------------------<b=
r>
&gt; &gt;=C2=A0 2 files changed, 29 deletions(-)<br>
&gt;<br>
&gt; &quot;git grep lscbx&quot; returns only the declaration in helper.h an=
d the<br>
&gt; definition in mem_helper.c -- no TCG translator references, no<br>
&gt; gen_lscbx, nothing in translate.c. Confirmed dead code with zero<br>
&gt; callers. Thanks for the cleanup.<br>
&gt;<br>
&gt; Reviewed-by: Amit Machhiwal &lt;<a href=3D"mailto:amachhiw@linux.ibm.c=
om" target=3D"_blank" rel=3D"noreferrer">amachhiw@linux.ibm.com</a>&gt;<br>
&gt;<br>
&gt; Thanks,<br>
&gt; Amit<br>
&gt;<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/target/ppc/helper.h b/target/ppc/helper.h<br>
&gt; &gt; index e99c8c824b..6b2d19a3ad 100644<br>
&gt; &gt; --- a/target/ppc/helper.h<br>
&gt; &gt; +++ b/target/ppc/helper.h<br>
&gt; &gt; @@ -54,7 +54,6 @@ DEF_HELPER_FLAGS_2(dcbzl, TCG_CALL_NO_WG, void,=
 env, tl)<br>
&gt; &gt;=C2=A0 #endif<br>
&gt; &gt;=C2=A0 DEF_HELPER_FLAGS_2(icbi, TCG_CALL_NO_WG, void, env, tl)<br>
&gt; &gt;=C2=A0 DEF_HELPER_FLAGS_2(icbiep, TCG_CALL_NO_WG, void, env, tl)<b=
r>
&gt; &gt; -DEF_HELPER_5(lscbx, tl, env, tl, i32, i32, i32)<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 #if defined(TARGET_PPC64)<br>
&gt; &gt;=C2=A0 DEF_HELPER_4(DIVDEU, i64, env, i64, i64, i32)<br>
&gt; &gt; diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c<br=
>
&gt; &gt; index 119dc1df23..787ba2cdec 100644<br>
&gt; &gt; --- a/target/ppc/mem_helper.c<br>
&gt; &gt; +++ b/target/ppc/mem_helper.c<br>
&gt; &gt; @@ -367,34 +367,6 @@ void helper_icbiep(CPUPPCState *env, target_=
ulong addr)<br>
&gt; &gt;=C2=A0 #endif<br>
&gt; &gt;=C2=A0 }<br>
&gt; &gt;<br>
&gt; &gt; -/* XXX: to be tested */<br>
&gt; &gt; -target_ulong helper_lscbx(CPUPPCState *env, target_ulong addr, u=
int32_t reg,<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t ra, uint32_t rb)<br>
&gt; &gt; -{<br>
&gt; &gt; -=C2=A0 =C2=A0 int i, c, d;<br>
&gt; &gt; -<br>
&gt; &gt; -=C2=A0 =C2=A0 d =3D 24;<br>
&gt; &gt; -=C2=A0 =C2=A0 for (i =3D 0; i &lt; xer_bc; i++) {<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 c =3D cpu_ldub_data_ra(env, addr, GE=
TPC());<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 addr =3D addr_add(env, addr, 1);<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* ra (if not 0) and rb are never mo=
dified */<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (likely(reg !=3D rb &amp;&amp; (r=
a =3D=3D 0 || reg !=3D ra))) {<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;gpr[reg] =3D (=
env-&gt;gpr[reg] &amp; ~(0xFF &lt;&lt; d)) | (c &lt;&lt; d);<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (unlikely(c =3D=3D xer_cmp)) {<br=
>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (likely(d !=3D 0)) {<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 d -=3D 8;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 d =3D 24;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg++;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg =3D reg &amp; 0x1F=
;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; -=C2=A0 =C2=A0 }<br>
&gt; &gt; -=C2=A0 =C2=A0 return i;<br>
&gt; &gt; -}<br>
&gt; &gt; -<br>
&gt; &gt;=C2=A0 /**********************************************************=
*******************/<br>
&gt; &gt;=C2=A0 /* Altivec extension helpers */<br>
&gt; &gt;=C2=A0 #if HOST_BIG_ENDIAN<br>
&gt; &gt; --<br>
&gt; &gt; 2.43.0<br>
<br>
</blockquote></div>

--000000000000084fe0065706fa80--

