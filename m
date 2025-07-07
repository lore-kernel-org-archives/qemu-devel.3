Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1503C83F07
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Jul 2025 09:56:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uYiZM-00064D-FE; Mon, 07 Jul 2025 05:55:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1uYiZC-0005yE-Pk
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 05:55:19 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1uYiZ9-0001ea-Bz
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 05:55:17 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-31223a4cddeso2040874a91.1
 for <qemu-devel@nongnu.org>; Mon, 07 Jul 2025 02:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1751882112; x=1752486912; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=I0lWxCuSdZhkBEpyYwpPli8lAS8pJfEEvO4/hcithWE=;
 b=L1Xs/n9wCCyAFu+LCHWouhSbgRTLx6gT+zRpLjEgVBZTERd7+IZyCmH5p8N6+mFnqd
 3TQkXSW96DVOfcQnMFLoBHdpIxPUQIiABk1K47Y4vcAT33knVHLZDoVilkk9gg0tkKis
 fWnjCnpcMmlp0S1USkXDhPGdGNnyuqTjBHayZgSXPoC72LNSOLoH99Vt/NCfe5zbfOc1
 1CY0AMGOO0PKxAuNK8bvrJbUy4aH5F+lTMPgPmPbCUMVcW8QAiSemVKAxJMyLWBbxwjG
 bNBXZc3ZCV9tMqunFqVi4wjYMDYH+PC0DGGYn5Bt3i+gQpiOKr1pkmgWpVjMPF8nHbFb
 UBcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751882112; x=1752486912;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=I0lWxCuSdZhkBEpyYwpPli8lAS8pJfEEvO4/hcithWE=;
 b=Tdf7LUfBmNB6u9vlQ5FQnoRtiu+2vb9rco1xBdsIkA6bM8DFgXoC5Kga6jYl2NO0KN
 OhOmNvId00YHgw9L7q2v/6s9SPGocoYHyNZLNzcVQ5fCPDzWzYmeDSt3uTW/4yD+NgZj
 5yftiG3TXYaPHannIGAHs7dXCHXlaiat5mYzn6oEspAG/gL/QKtHOXrHQGlimIFUlDkr
 Rmel11TMNCOL5e+KJzlFoNUoSerFjvSD4BEdNoGSI/6WdCTLGZHjiJ8hl2QP4PJhKUak
 WlXpLc8Auhx6KdcmDwakuESEgnvXz/1PoO4fdw61e76xuZYIHPCqpRuNDaAncc3JN+dq
 +RmQ==
X-Gm-Message-State: AOJu0YzdHUvgBwhofEpivqnPsqAZIj1H9upPOiKl3mBtV/js06rJLAns
 IJfLm9XJWKZXtOFG4hBPS9BjcDaNBig6cpOMyeFjsLDv7vxR+jaN3pQ17HRCGXvx6u9FzAT6Inu
 1R1BbHu/lUlbvoMO/IyxV5Z3dM6mypS8H/SZso9UZpg==
X-Gm-Gg: ASbGncu4zhQK5joGxZcfcQsSKN5vbcBEXTVRMfj57arLJfS7VTNtBrbty5b4hH+4h0t
 QTbwTmMLYYmb6Bg360P8vxHYvSwKfU2YI1mWQ0Q6ULuvQMy9ZbtaG/KEQAJo7E7J9HKKstuiCMI
 QK8ZNjdjHXKvDxAgxUxWTMKNLCiLY5wLPepWprgfhfgsbYDNX2cfY/mVVA
X-Google-Smtp-Source: AGHT+IHODomgLflxvXGYp54DtO0E8MXK312N+HLvMNz8+KWuzuRQ7JsIX1pNmtneN1inwVUdG7zc4MfU3kJpT1J5H1Y=
X-Received: by 2002:a17:90b:3903:b0:311:abba:53c0 with SMTP id
 98e67ed59e1d1-31aadcf4fb0mr18390793a91.9.1751882111803; Mon, 07 Jul 2025
 02:55:11 -0700 (PDT)
MIME-Version: 1.0
References: <20250701030021.99218-1-jay.chang@sifive.com>
 <20250701030021.99218-3-jay.chang@sifive.com>
 <c8a2beb3-6a66-4d63-ac0b-e88c4dc53d64@lanxincomputing.com>
In-Reply-To: <c8a2beb3-6a66-4d63-ac0b-e88c4dc53d64@lanxincomputing.com>
From: Jay Chang <jay.chang@sifive.com>
Date: Mon, 7 Jul 2025 17:55:00 +0800
X-Gm-Features: Ac12FXyVMFfTCgB1R5lnsiKO5VGAqFL2eBopXjvCTotGoHyfPLjtPGuq3GELlAY
Message-ID: <CACNNAjMxpTxhPOgzi+TFTt14BSByvbo2jcWB5dNXXapPuFC7Bg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] target/riscv: Restrict midelegh access to S-mode
 harts
To: Nutty Liu <liujingqi@lanxincomputing.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Frank Chang <frank.chang@sifive.com>
Content-Type: multipart/alternative; boundary="000000000000f68e56063953d623"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=jay.chang@sifive.com; helo=mail-pj1-x1030.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--000000000000f68e56063953d623
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I intended to separate the S-mode and M-mode handling.
Do you think this change could improve performance?

Thanks,
Jay Chang

On Tue, Jul 1, 2025 at 11:46=E2=80=AFAM Nutty Liu <liujingqi@lanxincomputin=
g.com>
wrote:

> On 7/1/2025 11:00 AM, Jay Chang wrote:
> > RISC-V AIA Spec states:
> > "For a machine-level environment, extension Smaia encompasses all added
> > CSRs and all modifications to interrupt response behavior that the AIA
> > specifies for a hart, over all privilege levels. For a supervisor-level
> > environment, extension Ssaia is essentially the same as Smaia except
> > excluding the machine-level CSRs and behavior not directly visible to
> > supervisor level."
> >
> > Since midelegh is an AIA machine-mode CSR, add Smaia extension check in
> > aia_smode32 predicate.
> >
> > Reviewed-by: Frank Chang <frank.chang@sifive.com>
> > Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> > Signed-off-by: Jay Chang <jay.chang@sifive.com>
> > ---
> >   target/riscv/csr.c | 7 +++++--
> >   1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> > index 0e0ad37654..74ec0e1c60 100644
> > --- a/target/riscv/csr.c
> > +++ b/target/riscv/csr.c
> > @@ -374,8 +374,11 @@ static RISCVException aia_smode(CPURISCVState *env=
,
> int csrno)
> >   static RISCVException aia_smode32(CPURISCVState *env, int csrno)
> >   {
> >       int ret;
> > +    int csr_priv =3D get_field(csrno, 0x300);
> >
> > -    if (!riscv_cpu_cfg(env)->ext_ssaia) {
> > +    if (csr_priv =3D=3D PRV_M && !riscv_cpu_cfg(env)->ext_smaia) {
> > +        return RISCV_EXCP_ILLEGAL_INST;
> > +    } else if (!riscv_cpu_cfg(env)->ext_ssaia) {
>
> +    if ((csr_priv =3D=3D PRV_M && !riscv_cpu_cfg(env)->ext_smaia) ||
> +        (!riscv_cpu_cfg(env)->ext_ssaia)) {
>
> Would the above code be better ?
> Otherwise,
> Reviewed-by: Nutty Liu<liujingqi@lanxincomputing.com>
>
> Thanks,
> Nutty
>
> >           return RISCV_EXCP_ILLEGAL_INST;
> >       }
> >
> > @@ -5911,7 +5914,7 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] =3D =
{
> >       [CSR_MVIP]     =3D { "mvip",     aia_any, NULL, NULL, rmw_mvip   =
 },
> >
> >       /* Machine-Level High-Half CSRs (AIA) */
> > -    [CSR_MIDELEGH] =3D { "midelegh", aia_any32, NULL, NULL, rmw_midele=
gh
> },
> > +    [CSR_MIDELEGH] =3D { "midelegh", aia_smode32, NULL, NULL,
> rmw_midelegh },
> >       [CSR_MIEH]     =3D { "mieh",     aia_any32, NULL, NULL, rmw_mieh
>  },
> >       [CSR_MVIENH]   =3D { "mvienh",   aia_any32, NULL, NULL, rmw_mvien=
h
>  },
> >       [CSR_MVIPH]    =3D { "mviph",    aia_any32, NULL, NULL, rmw_mviph
> },
>

--000000000000f68e56063953d623
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I intended to separate the S-mode and M-mode handling.<br>
Do you think this change could improve performance?<br><br>Thanks,<br><div>=
Jay Chang</div></div><br><div class=3D"gmail_quote gmail_quote_container"><=
div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jul 1, 2025 at 11:46=E2=80=AFA=
M Nutty Liu &lt;<a href=3D"mailto:liujingqi@lanxincomputing.com">liujingqi@=
lanxincomputing.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">On 7/1/2025 11:00 AM, Jay Chang wrote:<br>
&gt; RISC-V AIA Spec states:<br>
&gt; &quot;For a machine-level environment, extension Smaia encompasses all=
 added<br>
&gt; CSRs and all modifications to interrupt response behavior that the AIA=
<br>
&gt; specifies for a hart, over all privilege levels. For a supervisor-leve=
l<br>
&gt; environment, extension Ssaia is essentially the same as Smaia except<b=
r>
&gt; excluding the machine-level CSRs and behavior not directly visible to<=
br>
&gt; supervisor level.&quot;<br>
&gt;<br>
&gt; Since midelegh is an AIA machine-mode CSR, add Smaia extension check i=
n<br>
&gt; aia_smode32 predicate.<br>
&gt;<br>
&gt; Reviewed-by: Frank Chang &lt;<a href=3D"mailto:frank.chang@sifive.com"=
 target=3D"_blank">frank.chang@sifive.com</a>&gt;<br>
&gt; Reviewed-by: Alistair Francis &lt;<a href=3D"mailto:alistair.francis@w=
dc.com" target=3D"_blank">alistair.francis@wdc.com</a>&gt;<br>
&gt; Signed-off-by: Jay Chang &lt;<a href=3D"mailto:jay.chang@sifive.com" t=
arget=3D"_blank">jay.chang@sifive.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0target/riscv/csr.c | 7 +++++--<br>
&gt;=C2=A0 =C2=A01 file changed, 5 insertions(+), 2 deletions(-)<br>
&gt;<br>
&gt; diff --git a/target/riscv/csr.c b/target/riscv/csr.c<br>
&gt; index 0e0ad37654..74ec0e1c60 100644<br>
&gt; --- a/target/riscv/csr.c<br>
&gt; +++ b/target/riscv/csr.c<br>
&gt; @@ -374,8 +374,11 @@ static RISCVException aia_smode(CPURISCVState *en=
v, int csrno)<br>
&gt;=C2=A0 =C2=A0static RISCVException aia_smode32(CPURISCVState *env, int =
csrno)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int ret;<br>
&gt; +=C2=A0 =C2=A0 int csr_priv =3D get_field(csrno, 0x300);<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 if (!riscv_cpu_cfg(env)-&gt;ext_ssaia) {<br>
&gt; +=C2=A0 =C2=A0 if (csr_priv =3D=3D PRV_M &amp;&amp; !riscv_cpu_cfg(env=
)-&gt;ext_smaia) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return RISCV_EXCP_ILLEGAL_INST;<br>
&gt; +=C2=A0 =C2=A0 } else if (!riscv_cpu_cfg(env)-&gt;ext_ssaia) {<br>
<br>
+=C2=A0 =C2=A0 if ((csr_priv =3D=3D PRV_M &amp;&amp; !riscv_cpu_cfg(env)-&g=
t;ext_smaia) ||<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 (!riscv_cpu_cfg(env)-&gt;ext_ssaia)) {<br>
<br>
Would the above code be better ?<br>
Otherwise,<br>
Reviewed-by: Nutty Liu&lt;<a href=3D"mailto:liujingqi@lanxincomputing.com" =
target=3D"_blank">liujingqi@lanxincomputing.com</a>&gt;<br>
<br>
Thanks,<br>
Nutty<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return RISCV_EXCP_ILLEGAL_INST=
;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; @@ -5911,7 +5914,7 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] =3D=
 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0[CSR_MVIP]=C2=A0 =C2=A0 =C2=A0=3D { &quot;mv=
ip&quot;,=C2=A0 =C2=A0 =C2=A0aia_any, NULL, NULL, rmw_mvip=C2=A0 =C2=A0 },<=
br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Machine-Level High-Half CSRs (AIA) */<br>
&gt; -=C2=A0 =C2=A0 [CSR_MIDELEGH] =3D { &quot;midelegh&quot;, aia_any32, N=
ULL, NULL, rmw_midelegh },<br>
&gt; +=C2=A0 =C2=A0 [CSR_MIDELEGH] =3D { &quot;midelegh&quot;, aia_smode32,=
 NULL, NULL, rmw_midelegh },<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0[CSR_MIEH]=C2=A0 =C2=A0 =C2=A0=3D { &quot;mi=
eh&quot;,=C2=A0 =C2=A0 =C2=A0aia_any32, NULL, NULL, rmw_mieh=C2=A0 =C2=A0 =
=C2=A0},<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0[CSR_MVIENH]=C2=A0 =C2=A0=3D { &quot;mvienh&=
quot;,=C2=A0 =C2=A0aia_any32, NULL, NULL, rmw_mvienh=C2=A0 =C2=A0},<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0[CSR_MVIPH]=C2=A0 =C2=A0 =3D { &quot;mviph&q=
uot;,=C2=A0 =C2=A0 aia_any32, NULL, NULL, rmw_mviph=C2=A0 =C2=A0 },<br>
</blockquote></div>

--000000000000f68e56063953d623--

