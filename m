Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CADEFC5AC67
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 06:05:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtfYW-0007Oh-Kt; Tue, 11 Aug 2026 02:01:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yvyas1991@gmail.com>)
 id 1wtfYU-0007ME-RN
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 02:01:42 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yvyas1991@gmail.com>)
 id 1wtfYR-0002gd-RL
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 02:01:42 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-5b2a73d5fc3so349535e87.1
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 23:01:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786428097; cv=none;
 d=google.com; s=arc-20260327;
 b=Z12qudMUMke/PG9Frrd/pN+SlE2s8CBt1GY2ujh2Uzis81YkXCTVZ5ZMAvH17e2UEV
 PRrEUJQsPeaC7s3yJtqtGY+cAdQYWwJm/4biup8hN5RC49MmpjNtNZYQsQKs+FXKCx+i
 ygBPpZvxcBehfSxuJeCDb8USFTLRdYToVKBiXP6guPQgt3zzOMou/s6SIJgJ5LSUQQ9l
 CRMF2xgn4Hmo1LRZPCblAouedzMFoXmkLGKyp1/5533Kb4jBeBEKNFGhSjEXKxtPZjpT
 wmTBU+0v4QVsU8P6j5Y5Dd9KXKwC28O7hImLa2EaFOzhMGxXoqq8PSqTWFSz0wAK9vpU
 IObw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=vpgKNiGOMTZceGl2WM1zyeNBNxqInSIMw/YuUsKyWWA=;
 fh=1O6OeZJ71i2QteYjjAHk4KEgXohMD/RVRtzAClAww6U=;
 b=ixQWiW2Xn4hHRoB32OYDaGZ/hAgnjzug4mHHDIPOxH5qOE4JDIE+9VrSJ0Fk+mdlMx
 QFVGf87XVXvmy+ZGzdjDorNkZaAU7c58NluUGjisyVwgXMGYmUbJu80lf3lCRwO4LLJr
 UbODztwtyIUAY48zltMZw1/R6cU6yRlSPBfb6kK2B5nWbd5ZIOPwZQyd94OfmF1wCHBJ
 vuP04BcRQ8zRLfBZiNISaLUNf/RBgM7OUZFJeATVC4bk0rJHBo5Y2E44IuYV8ZJUWoJM
 CXFeCuV80pjAwoZUVtwDRmlOH2z25dOu25SQw+iO1NsEiUmOM9aZ4o7BOloyY6omUSn3
 D1CQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786428097; x=1787032897; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=vpgKNiGOMTZceGl2WM1zyeNBNxqInSIMw/YuUsKyWWA=;
 b=M7iZ+oJvy3A97jim7lS2eG7pOdmcJjrWbGjF640EQp5KeIjBwgsBTP+DQWqLrrjI5k
 YnL7SSniHB2kiHa/Ea2j3bmlhEZL+E3iBavzSf0CURTuEm87m0jvyq2bywL4EeLsUnjL
 0NALbnG7CuAArl0SWCRb6sMOZXhyKih4ItGt5SLm8HBe93XucVkGS9MuY4sHEl13rdTh
 nh/9PMaIm8myeLuEa47sO60uzPW+mrXael1bYsn4FsE+sM07eGPwmVX+mp3N9vS3G8oD
 iSbMMZSSnk45D1tu0TqveWAPoAP1PaFRfs7B92K7nl60YnYjwxEdCj3r6wvtVBE2uIpg
 q4Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786428097; x=1787032897;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=vpgKNiGOMTZceGl2WM1zyeNBNxqInSIMw/YuUsKyWWA=;
 b=E630yaynWTm7d2iPfAl59eAo3ZRLWIVNyzrsn4qI1NJr5ZjI6PvwBql4ZVYi5En3uK
 xhVmxdehPgjqsTsMXz65M+Apd+KU0O+LzLGjMHjX/j+95XVIvWgVmIaDJG0CREDd+scs
 cODm+Bg3wBHlLmmoihXPqftMj9RoD/ApPv3+WKh3TC1EuhOasAZdgRvZvMQQjdPbPkcn
 LmeVJw4N7LEqxfyhz3/MEzFZ0SAbwS+Rut+1hOKdSd0NvvCwWvSVCyXscjPYXadun/i8
 Pe9HsDGOH4716VI7GoPEEHj+IqFAPyId2DmLrg4B9NMfR4kI5/6Pk0Fr/c/rKk3pygdA
 gDvg==
X-Gm-Message-State: AOJu0YxplcKgTLGwipx0G6WDjKNGOV8SnjThjc8ygqfQl7STEKd03VMH
 e5r9lqX0fwyT93CZLXOF7/LJUa43vP7qhVzRjryAvrmQHADYmjwTBFFnHBjP5yT/PdU0cm78TlJ
 FbZd+wIc55LrxE2CF4eeoGasVN320ZaY=
X-Gm-Gg: AR+sD12iSYClbC9UdpswZsAiP+Y0oZzhVF5OwUkmvLShK7gnHk8FscDwtp0ikrqzTg9
 ARpvIPp1vxOBlIFYbKYE3Qhc48rnnTon1TyAG+N29YB09uuWd++76Fh1c9EbZ+jBYj116RSEvoB
 EFNINHKu3Ug2bVWJyPLG7u5jZR64UDj2QC9zfefC1eIJr9zPyzYu8ZWSSlYyoh++99rOK6NdXtZ
 0c4BQ4oSeDXBZ6JgkJEPAJnKOuqKQVgeit/N9oyO1VHU1OnBAe6BVZHw7jbn2vu9dJa2WZ/TadA
 RP2HgbgJtFOjx+MiFAs1fv+/JwP/gAqhfZ9CJPmyZF6nj/48zhWS00InvAAbQ5bmQnE6tgjYI3K
 j
X-Received: by 2002:a05:6512:251f:b0:5ae:cf48:bd37 with SMTP id
 2adb3069b0e04-5b4485f2620mr133091e87.1.1786428097287; Mon, 10 Aug 2026
 23:01:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260805171453.25940-1-yvyas1991@gmail.com>
 <a15bda83-a711-4f34-802c-42c6b389962b@linux.ibm.com>
In-Reply-To: <a15bda83-a711-4f34-802c-42c6b389962b@linux.ibm.com>
From: Yogesh Vyas <yvyas1991@gmail.com>
Date: Tue, 11 Aug 2026 11:31:23 +0530
X-Gm-Features: AUfX_mw42Hm8GlY9PeO-8tp0OwapYGGdvU6FnsM_r30BksKeIHw9XLQo-D0f_ko
Message-ID: <CAJOT6qNGeGQ1GXN99UuT4RiHP-9eoHhBgECrwmkWxK+PzvMzfA@mail.gmail.com>
Subject: Re: [PATCH 1/1] tcg: defer tb_flush when initial region alloc fails
To: Chinmay Rath <rathc@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 anushree.mathur@linux.ibm.com, Nicholas Piggin <npiggin@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Content-Type: multipart/alternative; boundary="00000000000027d74e0658bf3499"
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=yvyas1991@gmail.com; helo=mail-lf1-x130.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--00000000000027d74e0658bf3499
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Chinmay,

Thank you for your response.
No, It appears tcg_region_reset_all() always succeeds in giving at least
one region to each live context as n_ctxs <=3D region.n, and the hotplug pa=
th
does one flush and retry, therefore should not cause a repeating alloc
failure.

Regards,
Yogesh Vyas

On Mon, 10 Aug, 2026, 16:27 Chinmay Rath, <rathc@linux.ibm.com> wrote:

> Hi Yogesh,
>
> Thanks for coming up with this solution ! It looks good to me. I had a
> doubt though.
> After tb_flush_pending is set, tcg_region_reset_all() allocates new
> region to all the contexts. Is there a possibility of region not being
> allocated here as well and the loop repeating ?
>
> Thanks,
> Chinmay
>
> On 8/5/26 22:44, Yogesh Vyas wrote:
> > Under MTTCG, busy vCPUs can temporarily exhaust the fixed code-gen
> > region pool by holding multiple regions. A newly registered vCPU
> > thread that then fails tcg_region_initial_alloc() currently hits
> > g_assert and aborts QEMU =E2=80=94 seen during vCPU hotplug on ppc64 TC=
G
> > (virt-type=3Dqemu) with a large maxcpus.
> > Instead of asserting, mark the context with tb_flush_pending. The
> > first tcg_tb_alloc() returns NULL so the existing tb_gen_code path
> > queues a tb_flush; tcg_region_reset_all() then repacks the pool and
> > the new thread obtains a region on retry.
> > This mirrors the graceful exhaustion handling already used by the
> > runtime tcg_region_alloc() path.
> >
> > Reported-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
> > Closes: https://gitlab.com/qemu-project/qemu/-/work_items/2984
> > Signed-off-by: Yogesh Vyas <yvyas1991@gmail.com>
> > ---
> >   include/tcg/tcg.h |  9 +++++++++
> >   tcg/region.c      | 15 ++++++++++++++-
> >   tcg/tcg.c         | 12 ++++++++++++
> >   3 files changed, 35 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
> > index 7669dc1c2d..8a05e3af7b 100644
> > --- a/include/tcg/tcg.h
> > +++ b/include/tcg/tcg.h
> > @@ -381,6 +381,15 @@ struct TCGContext {
> >       /* Threshold to flush the translated code buffer.  */
> >       void *code_gen_highwater;
> >
> > +    /*
> > +     * Set when this context (a newly registered vCPU thread) could no=
t
> be
> > +     * given an initial code-gen region because the region pool was
> > +     * momentarily exhausted by other busy vCPUs. Rather than aborting=
,
> the
> > +     * thread defers a tb_flush: the next tcg_tb_alloc() forces a flus=
h
> +
> > +     * retry, which resets the region pool and reclaims slack for this
> thread.
> > +     */
> > +    bool tb_flush_pending;
> > +
> >       /* Track which vCPU triggers events */
> >       CPUState *cpu;                      /* *_trans */
> >
> > diff --git a/tcg/region.c b/tcg/region.c
> > index 5d4be1453b..1200947385 100644
> > --- a/tcg/region.c
> > +++ b/tcg/region.c
> > @@ -393,7 +393,20 @@ bool tcg_region_alloc(TCGContext *s)
> >   static void tcg_region_initial_alloc__locked(TCGContext *s)
> >   {
> >       bool err =3D tcg_region_alloc__locked(s);
> > -    g_assert(!err);
> > +
> > +    /*
> > +     * The region pool can be momentarily exhausted when many busy
> vCPUs have
> > +     * each grabbed several regions during translation. A newly starte=
d
> vCPU
> > +     * thread that cannot get its initial region must not abort QEMU:
> instead
> > +     * flag a deferred tb_flush. The thread's first tcg_tb_alloc() wil=
l
> force a
> > +     * flush + retry (tcg_region_reset_all() resets region.current and
> > +     * re-packs the live contexts), which reclaims that slack and
> assigns this
> > +     * context a region. This mirrors the graceful runtime path in
> > +     * tcg_tb_alloc()/tcg_region_alloc().
> > +     */
> > +    if (err) {
> > +        s->tb_flush_pending =3D true;
> > +    }
> >   }
> >
> >   void tcg_region_initial_alloc(TCGContext *s)
> > diff --git a/tcg/tcg.c b/tcg/tcg.c
> > index 1e77f2365a..ea66fb6f84 100644
> > --- a/tcg/tcg.c
> > +++ b/tcg/tcg.c
> > @@ -1830,6 +1830,18 @@ TranslationBlock *tcg_tb_alloc(TCGContext *s)
> >       TranslationBlock *tb;
> >       void *next;
> >
> > +    /*
> > +     * A newly started vCPU thread that could not obtain its initial
> region
> > +     * (region pool momentarily exhausted) deferred a flush. Trigger i=
t
> now:
> > +     * returning NULL makes the caller queue a tb_flush and retry, whi=
ch
> > +     * resets the region pool and gives this context a valid region. D=
o
> this
> > +     * before touching code_gen_ptr, which is not yet valid for this
> context.
> > +     */
> > +    if (unlikely(s->tb_flush_pending)) {
> > +        s->tb_flush_pending =3D false;
> > +        return NULL;
> > +    }
> > +
> >    retry:
> >       tb =3D (void *)ROUND_UP((uintptr_t)s->code_gen_ptr, align);
> >       next =3D (void *)ROUND_UP((uintptr_t)(tb + 1), align);
>

--00000000000027d74e0658bf3499
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"auto"><div>H=
i Chinmay,=C2=A0</div><div dir=3D"auto"><br></div><div>Thank you for your r=
esponse.</div><div dir=3D"auto">No, It appears  tcg_region_reset_all() alwa=
ys succeeds in giving at least one region to each live context as n_ctxs &l=
t;=3D region.n, and the hotplug path does one flush and retry, therefore sh=
ould not cause a repeating alloc failure.</div><div><br></div><div><div dir=
=3D"ltr">Regards,<div>Yogesh Vyas</div></div></div></div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, 10 Aug, 20=
26, 16:27 Chinmay Rath, &lt;<a href=3D"mailto:rathc@linux.ibm.com" target=
=3D"_blank">rathc@linux.ibm.com</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">Hi Yogesh,<br>
<br>
Thanks for coming up with this solution ! It looks good to me. I had a <br>
doubt though.<br>
After tb_flush_pending is set, tcg_region_reset_all() allocates new <br>
region to all the contexts. Is there a possibility of region not being <br>
allocated here as well and the loop repeating ?<br>
<br>
Thanks,<br>
Chinmay<br>
<br>
On 8/5/26 22:44, Yogesh Vyas wrote:<br>
&gt; Under MTTCG, busy vCPUs can temporarily exhaust the fixed code-gen<br>
&gt; region pool by holding multiple regions. A newly registered vCPU<br>
&gt; thread that then fails tcg_region_initial_alloc() currently hits<br>
&gt; g_assert and aborts QEMU =E2=80=94 seen during vCPU hotplug on ppc64 T=
CG<br>
&gt; (virt-type=3Dqemu) with a large maxcpus.<br>
&gt; Instead of asserting, mark the context with tb_flush_pending. The<br>
&gt; first tcg_tb_alloc() returns NULL so the existing tb_gen_code path<br>
&gt; queues a tb_flush; tcg_region_reset_all() then repacks the pool and<br=
>
&gt; the new thread obtains a region on retry.<br>
&gt; This mirrors the graceful exhaustion handling already used by the<br>
&gt; runtime tcg_region_alloc() path.<br>
&gt;<br>
&gt; Reported-by: Anushree Mathur &lt;<a href=3D"mailto:anushree.mathur@lin=
ux.ibm.com" rel=3D"noreferrer" target=3D"_blank">anushree.mathur@linux.ibm.=
com</a>&gt;<br>
&gt; Closes: <a href=3D"https://gitlab.com/qemu-project/qemu/-/work_items/2=
984" rel=3D"noreferrer noreferrer" target=3D"_blank">https://gitlab.com/qem=
u-project/qemu/-/work_items/2984</a><br>
&gt; Signed-off-by: Yogesh Vyas &lt;<a href=3D"mailto:yvyas1991@gmail.com" =
rel=3D"noreferrer" target=3D"_blank">yvyas1991@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0include/tcg/tcg.h |=C2=A0 9 +++++++++<br>
&gt;=C2=A0 =C2=A0tcg/region.c=C2=A0 =C2=A0 =C2=A0 | 15 ++++++++++++++-<br>
&gt;=C2=A0 =C2=A0tcg/tcg.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 12 ++++++++++=
++<br>
&gt;=C2=A0 =C2=A03 files changed, 35 insertions(+), 1 deletion(-)<br>
&gt;<br>
&gt; diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h<br>
&gt; index 7669dc1c2d..8a05e3af7b 100644<br>
&gt; --- a/include/tcg/tcg.h<br>
&gt; +++ b/include/tcg/tcg.h<br>
&gt; @@ -381,6 +381,15 @@ struct TCGContext {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Threshold to flush the translated code bu=
ffer.=C2=A0 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0void *code_gen_highwater;<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +=C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* Set when this context (a newly registered vCPU =
thread) could not be<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* given an initial code-gen region because the re=
gion pool was<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* momentarily exhausted by other busy vCPUs. Rath=
er than aborting, the<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* thread defers a tb_flush: the next tcg_tb_alloc=
() forces a flush +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* retry, which resets the region pool and reclaim=
s slack for this thread.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 bool tb_flush_pending;<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Track which vCPU triggers events */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0CPUState *cpu;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* *_trans */<br>
&gt;=C2=A0 =C2=A0<br>
&gt; diff --git a/tcg/region.c b/tcg/region.c<br>
&gt; index 5d4be1453b..1200947385 100644<br>
&gt; --- a/tcg/region.c<br>
&gt; +++ b/tcg/region.c<br>
&gt; @@ -393,7 +393,20 @@ bool tcg_region_alloc(TCGContext *s)<br>
&gt;=C2=A0 =C2=A0static void tcg_region_initial_alloc__locked(TCGContext *s=
)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bool err =3D tcg_region_alloc__locked(s);<br=
>
&gt; -=C2=A0 =C2=A0 g_assert(!err);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* The region pool can be momentarily exhausted wh=
en many busy vCPUs have<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* each grabbed several regions during translation=
. A newly started vCPU<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* thread that cannot get its initial region must =
not abort QEMU: instead<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* flag a deferred tb_flush. The thread&#39;s firs=
t tcg_tb_alloc() will force a<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* flush + retry (tcg_region_reset_all() resets re=
gion.current and<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* re-packs the live contexts), which reclaims tha=
t slack and assigns this<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* context a region. This mirrors the graceful run=
time path in<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* tcg_tb_alloc()/tcg_region_alloc().<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 if (err) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;tb_flush_pending =3D true;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0void tcg_region_initial_alloc(TCGContext *s)<br>
&gt; diff --git a/tcg/tcg.c b/tcg/tcg.c<br>
&gt; index 1e77f2365a..ea66fb6f84 100644<br>
&gt; --- a/tcg/tcg.c<br>
&gt; +++ b/tcg/tcg.c<br>
&gt; @@ -1830,6 +1830,18 @@ TranslationBlock *tcg_tb_alloc(TCGContext *s)<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0TranslationBlock *tb;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0void *next;<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +=C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* A newly started vCPU thread that could not obta=
in its initial region<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* (region pool momentarily exhausted) deferred a =
flush. Trigger it now:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* returning NULL makes the caller queue a tb_flus=
h and retry, which<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* resets the region pool and gives this context a=
 valid region. Do this<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* before touching code_gen_ptr, which is not yet =
valid for this context.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 if (unlikely(s-&gt;tb_flush_pending)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;tb_flush_pending =3D false;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 retry:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0tb =3D (void *)ROUND_UP((uintptr_t)s-&gt;cod=
e_gen_ptr, align);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0next =3D (void *)ROUND_UP((uintptr_t)(tb + 1=
), align);<br>
</blockquote></div>
</div>
</div>

--00000000000027d74e0658bf3499--

