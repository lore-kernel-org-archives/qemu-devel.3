Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 515C3C88E72
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 21:19:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6E4f-0001jC-O1; Mon, 14 Sep 2026 17:18:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1x6E4a-0001iw-1i
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 17:18:44 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1x6E4V-0002ag-3g
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 17:18:41 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 98e67ed59e1d1-396ccdaea75so879303a91.1
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 14:18:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789420718; cv=none;
 d=google.com; s=arc-20260327;
 b=AcMg9Ln3wQ4LsAG0qlWqZx84qo47us+C/z/ZW+mXNhA1J3unShXi7B/2REJEXHI/LL
 3Jp9Fx+EHIJdmZeW6AalqtKd0cTeLEzeHSQADF3XzuEhkfRDj9A4KCyAcMJ2CXU/X4En
 Z5yDKpveutTrhuZwEsh5KTTX+o5vr+2Xt/XJsPLrywqcllXKiDVgmT/25c4E6cT46EpN
 G3ca2dBYbU04R2a/pusdRUZ3y/rSWKV/kwYaLCDholF+18gkcGPqB+9+YFjQF+h9xN7L
 JmHbQUMgRMVyNUyqfnseenJDhfzDIpUzcDfSlRXJFcNEdrs5zQSLdS3+zjWyCF0gpJRA
 i/OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=MWKgxSGOizxN17CfofhoG7VH8jhExWWTaWaF1B17p6Y=;
 fh=1Jp0KdhqtyfxbCjclbABrQtBrJrCg/j6MU64w81r97g=;
 b=Mzg25R5Q2o7D8vkKxHEJRgsCE2hGiP8u+EOAV3X+9HxiJPRsdATB1assO2NJGT/IUY
 3CjvQx9xEbUs7BkY5dsBbHZdIExr347LLqjC2h1OQ2Z/nyg6YtNtVWCgIqE/TMg8JTZ/
 BT6+KetSTsVv4KSU4wTqrDN88Dt/Fz75SFGam5Zi/hL9O3goPkP2JuoGuygqfLHc6gMx
 B7bfgpMwHdRtdGsoizRePXBWcoSTCTVJxlis95SHz8ln2GLPHmx12NF/GFNQrcOVwgRG
 OGa8CQ/NDv8049ofv15ActVQrBhiHGbxZssVggUqLoT9QoZGu3y6Gizno/+GHTlPFXqC
 DBRA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789420718; x=1790025518; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=MWKgxSGOizxN17CfofhoG7VH8jhExWWTaWaF1B17p6Y=;
 b=pwiduPWYnr8Y+6WU7d/BMZIg3G20V55/cFY8ZXXkv1xhSqAbDQyjvtW2G+7/zyqaGG
 YyTxrVOb9hyZywbFK6+EsGV+GrG1GpwT+0yzlJvaogK90PaojuTikxxMB1mgZnQa5+G2
 RoGfD7tAGHVTS+dfbPq2toId1whuhLUWTrGiPcyodq5KpEC+AISTWY9xCmTk9t7/zT7Y
 sALN1GMA4eDm8I/fVEDgOloxkgbChMJNUmpv2spMUs84eJNl51xlGA50YxAUZVQPXl+6
 Pcf0+MuoAZvqRUr8s1NC+p0RboVWz5hcjrLINwAwSPukOMDclhbjxoVWcDw/ZihC9d5F
 3ZnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789420718; x=1790025518;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=MWKgxSGOizxN17CfofhoG7VH8jhExWWTaWaF1B17p6Y=;
 b=YxnFBzvZPqkEQI73DMaNDufo7PZJzWTS1ua2g74FMc5e9n/wDJjLy9A5lZU9pgO6so
 AUC1lOFr8MrfyXqPNCYCnyR4/DjYqAtMx27/X6gfXhs5gK9O3MwHo/cmFNleKIHUrrQy
 SZh+gQobwx9JmI+GU/JyZyLhP8UStQ6imxBhls0qPYqAhH+eQhTJb37BWrJDlhuPV7hc
 26Be39fEH3pTVcohuVjkdWet6JdXq3e3FBhEPB3m0BeICFrH3QjQAzl25zrQoHmrYq+f
 zgAwjfcJJb95Yu9nyWvKDxsRQTqXIvsoRXwk2Y50vQZqbs1Ma+RtP88k+7KOhmCEA5aF
 TohA==
X-Gm-Message-State: AFuF++lzDvfkWhPOnPAK9F2zgnxNnv+92jQ8D7a2TLEMmL0oDaPc2EP2
 qsOvhfexhKW/mPKcrBk7MYdsDScqnwCR4ccJ60HzprPuFNYwU/l0lJwuNJHZW27S4UGQMlR9Q5K
 mMTaQqb4dsAfPvIQ7EUtVhE8z1jkg1Ts=
X-Gm-Gg: AYBFou2GRsW2uhRFV6DSam26I3h/v3UF8lVJ7NgDbdzwTg4hgMwWAOTJxu50QoRYjsX
 0COVlYVrmbSpGR3ge2moE/nKva5Copj8LSh2gWa1bRa8j+B601gX1TlGAXjFhXfQgE9GcBf8+Yx
 UxPDrXnW6PShgnrg2zYzO9GFXYk6URlxF+SQEkvGju4ncoGdzveAbjFbn/QqYsJHWfCk6st+56A
 G+SvPF01WOuGzOGkeeRuPZkEiyppo57S/OtOUXtaFJfFgWfoV/kXOLxyM393tcO+bHBDC4Ali87
 LEsvqZC480b3S+1p1DKd27qnPqSaAfATro7KithK3E2v3u8HzQ4vcJHu3k39CCiIxOOfby9nuFo
 fhLV8lNkg0mSgS9z9WHS0Lg==
X-Received: by 2002:a17:90b:2682:b0:398:9bd3:d6d4 with SMTP id
 98e67ed59e1d1-39dfe15eccamr1196438a91.14.1789420717752; Mon, 14 Sep 2026
 14:18:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260911220825.143115-1-ltaylorsimpson@gmail.com>
 <20260911220825.143115-9-ltaylorsimpson@gmail.com>
 <CAJ+KCYNtwp-dBgaBnxVt7=wW6BOSUif2HLoOcg0M=97PP75BQQ@mail.gmail.com>
In-Reply-To: <CAJ+KCYNtwp-dBgaBnxVt7=wW6BOSUif2HLoOcg0M=97PP75BQQ@mail.gmail.com>
From: Taylor Simpson <ltaylorsimpson@gmail.com>
Date: Mon, 14 Sep 2026 15:18:26 -0600
X-Gm-Features: AcwNN1WJFctM8ZYD5tm0ReDebWFitZ6bG8iBNQQcfVCYJ2NRgcKau7TmaQ1Tsyo
Message-ID: <CAATN3No3iJPp1RfT4=GeBECe3oY6zGamSUuHRa_b32O4qfphBQ@mail.gmail.com>
Subject: Re: [PATCH v2 08/10] Hexagon (target/hexagon) Check for greg
 multiwrite in analyze_packet
To: Marco Liebel <marco.liebel@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, brian.cain@oss.qualcomm.com, 
 matheus.bernardino@oss.qualcomm.com, sid.manning@oss.qualcomm.com, 
 richard.henderson@linaro.org, philmd@oss.qualcomm.com, ale@rev.ng, 
 anjo@rev.ng
Content-Type: multipart/alternative; boundary="0000000000003c4525065b77fa5b"
Received-SPF: pass client-ip=2607:f8b0:4864:39::10;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-pj2-x10.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_KAM_HTML_FONT_INVALID=0.01 autolearn=ham autolearn_force=no
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

--0000000000003c4525065b77fa5b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 1:55=E2=80=AFPM Marco Liebel <marco.liebel@oss.qual=
comm.com>
wrote:

> On Fri, Sep 11, 2026 at 5:08=E2=80=AFPM Taylor Simpson <ltaylorsimpson@gm=
ail.com>
> wrote:
> >
> > Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> > ---
> >  target/hexagon/translate.h | 11 +++++++++--
> >  target/hexagon/translate.c |  8 ++++++++
> >  2 files changed, 17 insertions(+), 2 deletions(-)
> >
> > diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
> > index 815eecb60a..f469452daa 100644
> > --- a/target/hexagon/translate.c
> > +++ b/target/hexagon/translate.c
> > @@ -575,6 +575,8 @@ static void clear_pkt_ctx(DisasContext *ctx)
> >      bitmap_zero(ctx->predicated_regs, TOTAL_PER_THREAD_REGS);
> >  #ifndef CONFIG_USER_ONLY
> >      ctx->greg_log_idx =3D 0;
> > +    bitmap_zero(ctx->gregs_written, NUM_GREGS);
> > +    bitmap_zero(ctx->qregs_multi_write, NUM_GREGS);
>
> Should this be `*g*regs_multi_write` and not `*q*regs_multi_write`?
>

Yes, I caught this when fixing the test-functional failures Brian pointed
out.

Taylor

--0000000000003c4525065b77fa5b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Sep 14,=
 2026 at 1:55=E2=80=AFPM Marco Liebel &lt;<a href=3D"mailto:marco.liebel@os=
s.qualcomm.com">marco.liebel@oss.qualcomm.com</a>&gt; wrote:<br></div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr">On Fri, Sep 1=
1, 2026 at 5:08=E2=80=AFPM Taylor Simpson &lt;<a href=3D"mailto:ltaylorsimp=
son@gmail.com" target=3D"_blank">ltaylorsimpson@gmail.com</a>&gt; wrote:<br=
>&gt;<br>&gt; Signed-off-by: Taylor Simpson &lt;<a href=3D"mailto:ltaylorsi=
mpson@gmail.com" target=3D"_blank">ltaylorsimpson@gmail.com</a>&gt;<br>&gt;=
 ---<br>&gt; =C2=A0target/hexagon/translate.h | 11 +++++++++--<br>&gt; =C2=
=A0target/hexagon/translate.c | =C2=A08 ++++++++<br>&gt; =C2=A02 files chan=
ged, 17 insertions(+), 2 deletions(-)<br>&gt;<br>&gt; diff --git a/target/h=
exagon/translate.c b/target/hexagon/translate.c<br>&gt; index 815eecb60a..f=
469452daa 100644<br>&gt; --- a/target/hexagon/translate.c<br>&gt; +++ b/tar=
get/hexagon/translate.c<br>&gt; @@ -575,6 +575,8 @@ static void clear_pkt_c=
tx(DisasContext *ctx)<br>&gt; =C2=A0 =C2=A0 =C2=A0bitmap_zero(ctx-&gt;predi=
cated_regs, TOTAL_PER_THREAD_REGS);<br>&gt; =C2=A0#ifndef CONFIG_USER_ONLY<=
br>&gt; =C2=A0 =C2=A0 =C2=A0ctx-&gt;greg_log_idx =3D 0;<br>&gt; + =C2=A0 =
=C2=A0bitmap_zero(ctx-&gt;gregs_written, NUM_GREGS);<br>&gt; + =C2=A0 =C2=
=A0bitmap_zero(ctx-&gt;qregs_multi_write, NUM_GREGS);<div><br></div><div>Sh=
ould this be `<b>g</b>regs_multi_write` and not `<span style=3D"background-=
color:transparent"><b>q</b>regs_multi_write`?</span></div></div></blockquot=
e><div><br></div><div>Yes, I caught this when fixing the test-functional fa=
ilures Brian pointed out.</div><div><br></div><div>Taylor</div><div>=C2=A0<=
/div></div></div>

--0000000000003c4525065b77fa5b--

