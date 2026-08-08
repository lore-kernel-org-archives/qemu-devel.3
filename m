Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22667C5AD2C
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Aug 2026 08:23:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wscKE-0007nC-Jq; Sat, 08 Aug 2026 04:22:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yvyas1991@gmail.com>)
 id 1wscKB-0007mm-7n
 for qemu-devel@nongnu.org; Sat, 08 Aug 2026 04:22:35 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yvyas1991@gmail.com>)
 id 1wscK8-0007Ua-Vj
 for qemu-devel@nongnu.org; Sat, 08 Aug 2026 04:22:34 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-5b2a73d5fc3so37184e87.1
 for <qemu-devel@nongnu.org>; Sat, 08 Aug 2026 01:22:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786177350; cv=none;
 d=google.com; s=arc-20260327;
 b=MYDd7tnZdWKOHVoBKOUehQWg2u4vBO1OoLhY8f6RvqpyzmSI8IOsx9hLLdYCxMMYl6
 pRkzpmyarl/wxTCS1i5HxvJajp5YnePON7fXmEvMxbMpe1Uk0BCwt+zaxSfyUwyn85Pl
 0lUgmKxNJYHoB69SA+fBiYtmjoLGPVQnfcsUnP38kihA4yV54Mx8kj5XIfaII5/TVR8A
 YYr5p/C/eCZraXG9P2tHFnIuRDd5A9D5f8NUMZCO/NJ7rtbnKym0nxFk3SRYpeV66DRa
 SSPwWMpBhZEO88olDKS0pYV4x49UZG8zIxoHFbpUegYK1gZh7B3ub9g6aI4m3EuSbejy
 hjig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=vymxRlcevaKIn8Dv+G8ViOExZEmdmE1bL2VTiV0Tx9M=;
 fh=eS6ZNs+nHsf34ZoA9jPI7v+nCcrrECGdUq/08OhQbEw=;
 b=Wwjm4MvloKj+ocbixf+x7Jejrl9dSRqzkkfKjZ+rFmj2tVu6EXh2TfIO1vwnyeBRod
 YfeKsIn4NDeme1LF3HKvhmzXpMHysVEQEF7QhPf3fPJR0e/a4OnXoW15zrdifImm/pkh
 4Iulq3hOtb7piZpXm5RtGJz9yD+FHEwl97HRvs+QNuUg7Y6ifGjbk6m+KoCCWdF2Q8n1
 yxwmMjroUZO32JdqDvDNqVdcVCzAr1P0rC53BPMsWxzoJJNAChgPEyoSSA3u0E4SCbN0
 +RDSESAJdlYHQ8t6pHJDD0ywabCKNpvbMu0tj1SzGodqK1r2uJVU8WANrq0updKly0PY
 AMGw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786177350; x=1786782150; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=vymxRlcevaKIn8Dv+G8ViOExZEmdmE1bL2VTiV0Tx9M=;
 b=VNnH8LbEj1jyqgrIR0X2GuP6pgA7iJg3IsVV9dCcrROUEdgCcqMW7LAEuThFvgCAWn
 H3PEMIf8f64jJTSsfIlA9dNAGHens0/jxxT6XrxL38stxXzzAS1a9Rq7R6dQ5LT7UMmV
 m3nJtUBegz1N2BrikPvd/9uxoXICsJFkKklVXfGjI/FqzAAmT8ZMm43AtldvkwH5SZGo
 dizTL1qzeKWxod5A2dPjIaDepG7+/7sgKx0Ke2tt2bx9gdohQLjft55cage/ju+BFjqS
 auYCxzVHhsvOOY0CiH1gB+ee3hnDYFR7v00jgBAVzKcFoqVs1qaUszu9WhTm8OtLeziw
 EmKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786177350; x=1786782150;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=vymxRlcevaKIn8Dv+G8ViOExZEmdmE1bL2VTiV0Tx9M=;
 b=b9AjsrDjMZrHh2+GYmvN7yGHzAPeNtxuw4fUb0GDoXwot7DoI2J7ukP2PLRSFxxRC2
 DJL8o+JoVMKAdl8luqNJNdX1Y+C1qmsM+LKB/b+MFrKy5HP4YTRrGAJAAS0/9lErWVqV
 g/JvIC9pSZALzxbtf/qYgvd6lHtcKGkHWjVXAWfE7PqGaN5B1er0GhtdvSKcWdkopXWY
 ohn/d/UaDvPmshN6awYgF15tHuf37FHVlOWOg5s/1vMVBReMC48tndWmJZOTIwOKZNka
 ThbB+vvC11ffzsSIEFbftgB/THQ9HezA9Ycj7Agu3C2b/Ii/LG+8g8rKRrUvOEl4ac26
 bhsQ==
X-Gm-Message-State: AOJu0YyYlnLym09WI8zGtmGTEz0aeNKYwDpchYBkr3TUBk7c7vqHnws2
 mh2e3IQmEITEcTfKc92y4Hfd8i/dMRWjjrol5Mb8aFhHGGWaBMx6xVnEY7yLHdkgmE4fG1ziWzc
 MawOkJI74JonFHM4WnTmGWZh8kvCqOV46Cp+B
X-Gm-Gg: AR+sD124CORfIGyiAmhKaobo5tVYqwPjG8MeDIlWROQ3k89RIMAAEEYJx6uGzZMV7FY
 hjz5QnRisou7IFE4MAgUkpsXnP7YATKsBk8Et01bBnjhKlhGUtfg3ybuh8b0f3dsN0qMtmDs4NO
 fNzeYzek8SmUxMBCYZxETN3PUTAlvv1fOxklmw7PV9e5AtJIDJ//bQrSUIKCRQD7fO0ZqYQauM8
 K+w/32WpArOwfYneqVd7HLdQTGxC6o6xx1WyU9jRSx/MMHm4NnyvgnAStQufdmE/WOh5+goVN5g
 UuQOc52rKLtLXvnZiiYWT287RDLteIQvW27I/s1ssNmVjySfKxqfyoA5S/C/JEPBw5IrZ976Kvx
 VHe+cI68cseSxAYyokXCq1o93peSivhsavw==
X-Received: by 2002:a05:6512:1156:b0:5ae:b2df:c11a with SMTP id
 2adb3069b0e04-5b2f4ae101emr3912867e87.0.1786177350129; Sat, 08 Aug 2026
 01:22:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260805171453.25940-1-yvyas1991@gmail.com>
In-Reply-To: <20260805171453.25940-1-yvyas1991@gmail.com>
From: Yogesh Vyas <yvyas1991@gmail.com>
Date: Sat, 8 Aug 2026 13:52:18 +0530
X-Gm-Features: AUfX_myfeJs9IhWlpYEwMamFdBZQywOQQJcGX7q1yHcOIjVyUf1EJOfOTBubu_8
Message-ID: <CAJOT6qM=4xu9WEsJzvaW0XjtUh-TGoGLZ13DEhPaR8bT-9ma4Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] tcg: defer tb_flush when initial region alloc fails
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Chinmay Rath <rathc@linux.ibm.com>, anushree.mathur@linux.ibm.com, 
 Nicholas Piggin <npiggin@gmail.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>
Content-Type: multipart/alternative; boundary="00000000000075db55065884d282"
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=yvyas1991@gmail.com; helo=mail-lf1-x12f.google.com
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

--00000000000075db55065884d282
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Richard, Chinmay,

Could you please share your review comments on this patch?

Regards,
Yogesh Vyas

On Wed, 5 Aug, 2026, 22:45 Yogesh Vyas, <yvyas1991@gmail.com> wrote:

> Under MTTCG, busy vCPUs can temporarily exhaust the fixed code-gen
> region pool by holding multiple regions. A newly registered vCPU
> thread that then fails tcg_region_initial_alloc() currently hits
> g_assert and aborts QEMU =E2=80=94 seen during vCPU hotplug on ppc64 TCG
> (virt-type=3Dqemu) with a large maxcpus.
> Instead of asserting, mark the context with tb_flush_pending. The
> first tcg_tb_alloc() returns NULL so the existing tb_gen_code path
> queues a tb_flush; tcg_region_reset_all() then repacks the pool and
> the new thread obtains a region on retry.
> This mirrors the graceful exhaustion handling already used by the
> runtime tcg_region_alloc() path.
>
> Reported-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
> Closes: https://gitlab.com/qemu-project/qemu/-/work_items/2984
> Signed-off-by: Yogesh Vyas <yvyas1991@gmail.com>
> ---
>  include/tcg/tcg.h |  9 +++++++++
>  tcg/region.c      | 15 ++++++++++++++-
>  tcg/tcg.c         | 12 ++++++++++++
>  3 files changed, 35 insertions(+), 1 deletion(-)
>
> diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
> index 7669dc1c2d..8a05e3af7b 100644
> --- a/include/tcg/tcg.h
> +++ b/include/tcg/tcg.h
> @@ -381,6 +381,15 @@ struct TCGContext {
>      /* Threshold to flush the translated code buffer.  */
>      void *code_gen_highwater;
>
> +    /*
> +     * Set when this context (a newly registered vCPU thread) could not =
be
> +     * given an initial code-gen region because the region pool was
> +     * momentarily exhausted by other busy vCPUs. Rather than aborting,
> the
> +     * thread defers a tb_flush: the next tcg_tb_alloc() forces a flush =
+
> +     * retry, which resets the region pool and reclaims slack for this
> thread.
> +     */
> +    bool tb_flush_pending;
> +
>      /* Track which vCPU triggers events */
>      CPUState *cpu;                      /* *_trans */
>
> diff --git a/tcg/region.c b/tcg/region.c
> index 5d4be1453b..1200947385 100644
> --- a/tcg/region.c
> +++ b/tcg/region.c
> @@ -393,7 +393,20 @@ bool tcg_region_alloc(TCGContext *s)
>  static void tcg_region_initial_alloc__locked(TCGContext *s)
>  {
>      bool err =3D tcg_region_alloc__locked(s);
> -    g_assert(!err);
> +
> +    /*
> +     * The region pool can be momentarily exhausted when many busy vCPUs
> have
> +     * each grabbed several regions during translation. A newly started
> vCPU
> +     * thread that cannot get its initial region must not abort QEMU:
> instead
> +     * flag a deferred tb_flush. The thread's first tcg_tb_alloc() will
> force a
> +     * flush + retry (tcg_region_reset_all() resets region.current and
> +     * re-packs the live contexts), which reclaims that slack and assign=
s
> this
> +     * context a region. This mirrors the graceful runtime path in
> +     * tcg_tb_alloc()/tcg_region_alloc().
> +     */
> +    if (err) {
> +        s->tb_flush_pending =3D true;
> +    }
>  }
>
>  void tcg_region_initial_alloc(TCGContext *s)
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index 1e77f2365a..ea66fb6f84 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -1830,6 +1830,18 @@ TranslationBlock *tcg_tb_alloc(TCGContext *s)
>      TranslationBlock *tb;
>      void *next;
>
> +    /*
> +     * A newly started vCPU thread that could not obtain its initial
> region
> +     * (region pool momentarily exhausted) deferred a flush. Trigger it
> now:
> +     * returning NULL makes the caller queue a tb_flush and retry, which
> +     * resets the region pool and gives this context a valid region. Do
> this
> +     * before touching code_gen_ptr, which is not yet valid for this
> context.
> +     */
> +    if (unlikely(s->tb_flush_pending)) {
> +        s->tb_flush_pending =3D false;
> +        return NULL;
> +    }
> +
>   retry:
>      tb =3D (void *)ROUND_UP((uintptr_t)s->code_gen_ptr, align);
>      next =3D (void *)ROUND_UP((uintptr_t)(tb + 1), align);
> --
> 2.54.0
>
>

--00000000000075db55065884d282
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div>Hi Richard, Chinmay,</div><div dir=3D"auto"><br></di=
v><div dir=3D"auto">Could you please share your review comments on this pat=
ch?</div><div><br></div><div data-smartmail=3D"gmail_signature"><div dir=3D=
"ltr">Regards,<div>Yogesh Vyas</div></div></div></div><br><div class=3D"gma=
il_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On We=
d, 5 Aug, 2026, 22:45 Yogesh Vyas, &lt;<a href=3D"mailto:yvyas1991@gmail.co=
m">yvyas1991@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1e=
x">Under MTTCG, busy vCPUs can temporarily exhaust the fixed code-gen<br>
region pool by holding multiple regions. A newly registered vCPU<br>
thread that then fails tcg_region_initial_alloc() currently hits<br>
g_assert and aborts QEMU =E2=80=94 seen during vCPU hotplug on ppc64 TCG<br=
>
(virt-type=3Dqemu) with a large maxcpus.<br>
Instead of asserting, mark the context with tb_flush_pending. The<br>
first tcg_tb_alloc() returns NULL so the existing tb_gen_code path<br>
queues a tb_flush; tcg_region_reset_all() then repacks the pool and<br>
the new thread obtains a region on retry.<br>
This mirrors the graceful exhaustion handling already used by the<br>
runtime tcg_region_alloc() path.<br>
<br>
Reported-by: Anushree Mathur &lt;<a href=3D"mailto:anushree.mathur@linux.ib=
m.com" target=3D"_blank" rel=3D"noreferrer">anushree.mathur@linux.ibm.com</=
a>&gt;<br>
Closes: <a href=3D"https://gitlab.com/qemu-project/qemu/-/work_items/2984" =
rel=3D"noreferrer noreferrer" target=3D"_blank">https://gitlab.com/qemu-pro=
ject/qemu/-/work_items/2984</a><br>
Signed-off-by: Yogesh Vyas &lt;<a href=3D"mailto:yvyas1991@gmail.com" targe=
t=3D"_blank" rel=3D"noreferrer">yvyas1991@gmail.com</a>&gt;<br>
---<br>
=C2=A0include/tcg/tcg.h |=C2=A0 9 +++++++++<br>
=C2=A0tcg/region.c=C2=A0 =C2=A0 =C2=A0 | 15 ++++++++++++++-<br>
=C2=A0tcg/tcg.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 12 ++++++++++++<br>
=C2=A03 files changed, 35 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h<br>
index 7669dc1c2d..8a05e3af7b 100644<br>
--- a/include/tcg/tcg.h<br>
+++ b/include/tcg/tcg.h<br>
@@ -381,6 +381,15 @@ struct TCGContext {<br>
=C2=A0 =C2=A0 =C2=A0/* Threshold to flush the translated code buffer.=C2=A0=
 */<br>
=C2=A0 =C2=A0 =C2=A0void *code_gen_highwater;<br>
<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* Set when this context (a newly registered vCPU threa=
d) could not be<br>
+=C2=A0 =C2=A0 =C2=A0* given an initial code-gen region because the region =
pool was<br>
+=C2=A0 =C2=A0 =C2=A0* momentarily exhausted by other busy vCPUs. Rather th=
an aborting, the<br>
+=C2=A0 =C2=A0 =C2=A0* thread defers a tb_flush: the next tcg_tb_alloc() fo=
rces a flush +<br>
+=C2=A0 =C2=A0 =C2=A0* retry, which resets the region pool and reclaims sla=
ck for this thread.<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 bool tb_flush_pending;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0/* Track which vCPU triggers events */<br>
=C2=A0 =C2=A0 =C2=A0CPUState *cpu;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* *_trans */<br>
<br>
diff --git a/tcg/region.c b/tcg/region.c<br>
index 5d4be1453b..1200947385 100644<br>
--- a/tcg/region.c<br>
+++ b/tcg/region.c<br>
@@ -393,7 +393,20 @@ bool tcg_region_alloc(TCGContext *s)<br>
=C2=A0static void tcg_region_initial_alloc__locked(TCGContext *s)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0bool err =3D tcg_region_alloc__locked(s);<br>
-=C2=A0 =C2=A0 g_assert(!err);<br>
+<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* The region pool can be momentarily exhausted when ma=
ny busy vCPUs have<br>
+=C2=A0 =C2=A0 =C2=A0* each grabbed several regions during translation. A n=
ewly started vCPU<br>
+=C2=A0 =C2=A0 =C2=A0* thread that cannot get its initial region must not a=
bort QEMU: instead<br>
+=C2=A0 =C2=A0 =C2=A0* flag a deferred tb_flush. The thread&#39;s first tcg=
_tb_alloc() will force a<br>
+=C2=A0 =C2=A0 =C2=A0* flush + retry (tcg_region_reset_all() resets region.=
current and<br>
+=C2=A0 =C2=A0 =C2=A0* re-packs the live contexts), which reclaims that sla=
ck and assigns this<br>
+=C2=A0 =C2=A0 =C2=A0* context a region. This mirrors the graceful runtime =
path in<br>
+=C2=A0 =C2=A0 =C2=A0* tcg_tb_alloc()/tcg_region_alloc().<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 if (err) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;tb_flush_pending =3D true;<br>
+=C2=A0 =C2=A0 }<br>
=C2=A0}<br>
<br>
=C2=A0void tcg_region_initial_alloc(TCGContext *s)<br>
diff --git a/tcg/tcg.c b/tcg/tcg.c<br>
index 1e77f2365a..ea66fb6f84 100644<br>
--- a/tcg/tcg.c<br>
+++ b/tcg/tcg.c<br>
@@ -1830,6 +1830,18 @@ TranslationBlock *tcg_tb_alloc(TCGContext *s)<br>
=C2=A0 =C2=A0 =C2=A0TranslationBlock *tb;<br>
=C2=A0 =C2=A0 =C2=A0void *next;<br>
<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* A newly started vCPU thread that could not obtain it=
s initial region<br>
+=C2=A0 =C2=A0 =C2=A0* (region pool momentarily exhausted) deferred a flush=
. Trigger it now:<br>
+=C2=A0 =C2=A0 =C2=A0* returning NULL makes the caller queue a tb_flush and=
 retry, which<br>
+=C2=A0 =C2=A0 =C2=A0* resets the region pool and gives this context a vali=
d region. Do this<br>
+=C2=A0 =C2=A0 =C2=A0* before touching code_gen_ptr, which is not yet valid=
 for this context.<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 if (unlikely(s-&gt;tb_flush_pending)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;tb_flush_pending =3D false;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 retry:<br>
=C2=A0 =C2=A0 =C2=A0tb =3D (void *)ROUND_UP((uintptr_t)s-&gt;code_gen_ptr, =
align);<br>
=C2=A0 =C2=A0 =C2=A0next =3D (void *)ROUND_UP((uintptr_t)(tb + 1), align);<=
br>
-- <br>
2.54.0<br>
<br>
</blockquote></div>

--00000000000075db55065884d282--

