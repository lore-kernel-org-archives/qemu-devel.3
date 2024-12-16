Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F449E7717F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 12:15:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tN9zI-000146-R6; Mon, 16 Dec 2024 07:14:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1tN9zH-00013E-Ad; Mon, 16 Dec 2024 07:14:11 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1tN9zE-00081v-R6; Mon, 16 Dec 2024 07:14:10 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5d3d143376dso5864269a12.3; 
 Mon, 16 Dec 2024 04:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734351246; x=1734956046; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FNDxWqgFsGnWmRg1i9qY2ULYE2ALkrCOmLnQdvdwU6k=;
 b=Fl5y9urFB/QoBKDOKsUAtOEPOX56Ek3MKHQY79Ef5/588zhdWIj1iKeYpzYma1m1Wd
 9d2z3u7iVljIQl/PRymiPMwHIaLD2keQN0VbZkbIPuf2Ovb/43tb4KzCOzp0/Qo5GxdS
 KHlsgMMKMouqfYYxbu4d/HLRPYtTm3OEAIaqlDy7AW0VPZTgdm1tPBUFX7r/IUVNjG6G
 oF3sUrqmGKvMlKx3NczaSKCBkNSO/XY7Za1G+esHGkmM22TbWG+CuBv19FYiBgGVujSw
 oYM58CT2S1VhfVRxlcyJgEzfU59jySTBE2xuVWHldlQ9X8VlMAu+JhWqRa7QNzVPvJPU
 wZfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734351246; x=1734956046;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FNDxWqgFsGnWmRg1i9qY2ULYE2ALkrCOmLnQdvdwU6k=;
 b=wBg4S6BzKkvSgvQXyNamdtuYcMYPDvafUggF2JBNxepUN4/NE7MX+KjCPyuZ50bfWZ
 vgoNhAkEvnokJDiwn9w1FMqWBooqVGoCpmx5xHWRbQboZdhm9Ha1nRJEKJY4KrRmST5D
 NsGOp/b6kFVwwd0JSId8XGCamcYOJV6emtXIZ3ae5oH2EyiATqtD+/fXaNoWrz2YI6c3
 Dlvg/JFma7+ZzqSjn4rX0Pn9PtHoc0V/iEBNpcrH85onG+PlXs1o+KMJ5XEd7qFeM8WH
 KnF3DFCEuTGlJLA5rmgpNwYlJEinQVDCYkGmrcBH63sG2oxHFUGCTk4dHV6qy0LN3Z/G
 FsTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDqGbK3uO3GceAj63AWlFizoXaSDWQCSXEpIXQ/7MbNgsT6SuXFV6gai9de5VPJFVUQV+WqrwDdsSlyQ==@nongnu.org,
 AJvYcCW7J/55SEd+8UK1YFuUqX0NFHsabsqruvo8qa6RtqpUNnHmHTSylG56U6VsJuSf6Tym6GKP1ZMcyeyo@nongnu.org
X-Gm-Message-State: AOJu0YxOCj36RtGVZNZDHHwo5clb1QYSK6oDFHbJpAK7mBSyRydot8Ai
 /KvGGzR6J3GFK7rBN1C/00ZKihTVUVBLv9YiAOn3KlKQl4ZiAOiLIPLToOYpWSRqJw190iD/IGR
 F6WbZkeiXaMl8un/eCqwIakLsEOA=
X-Gm-Gg: ASbGnctVfTN4Iv2WkYQf44Voa1HUj33jBBYRgp7J4gDYi0vjFYf57HLsWhbJ50Z9Qd8
 iJ5L72amS/M8f8E74AjgksoZ66Or17VZLClKcEw==
X-Google-Smtp-Source: AGHT+IEK0N40SMWBroWHewoUVrHNyWu9tRfYcp5unYtNm5L1hjseze+O95Vb9gpwIMgJZCv2vPEYKowGrlAkDqkU6Kg=
X-Received: by 2002:a05:6402:5213:b0:5d0:8664:9f56 with SMTP id
 4fb4d7f45d1cf-5d63c30bb5cmr13089661a12.11.1734351245797; Mon, 16 Dec 2024
 04:14:05 -0800 (PST)
MIME-Version: 1.0
References: <20241205112304.593204-1-baturo.alexey@gmail.com>
 <20241205112304.593204-8-baturo.alexey@gmail.com>
 <69de5c69-1583-4a0f-9db6-c61e721adbe1@ventanamicro.com>
In-Reply-To: <69de5c69-1583-4a0f-9db6-c61e721adbe1@ventanamicro.com>
From: Alexey Baturo <baturo.alexey@gmail.com>
Date: Mon, 16 Dec 2024 15:13:54 +0300
Message-ID: <CAFukJ-Dwfg33GuXs9oqe0D5KqGBtBydn9AQ6p96iD6vSi_akHQ@mail.gmail.com>
Subject: Re: [PATCH v12 7/7] target/riscv: Enable updates for pointer masking
 variables and thus enable pointer masking extension
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: richard.henderson@linaro.org, zhiwei_liu@linux.alibaba.com, 
 liwei1518@gmail.com, alistair23@gmail.com, frank.chang@sifive.com, 
 palmer@dabbelt.com, Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu, 
 kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000ebf27d0629621d72"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=baturo.alexey@gmail.com; helo=mail-ed1-x536.google.com
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

--000000000000ebf27d0629621d72
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

Indeed this series doesn't include the *Supm* extension, but it's mandatory
for RVA23U64.
As for the *Supm* itself, if I get it right, I don't think it should be
always-on, unless the proper profile is selected.
I think we might need to add extra flags like *ext_supm* and *ext_sspm*.
Then, to avoid adding extra checks to the existing code, I think we could
enable *Ssnpm* or *Smnpm* or both somewhere during the initialization if
*Supm* is set. And do the same for *Sspm*.
From what I see right now in the code, there's no mention of RVA23, so
maybe we could just add some fields for the missing extensions and support
them later, when RVA23 support is implemented.
Personally, I'd like to do this in a separate patch after these ones are
merged.

What do you think?

Thanks

=D1=87=D1=82, 12 =D0=B4=D0=B5=D0=BA. 2024=E2=80=AF=D0=B3. =D0=B2 12:48, Dan=
iel Henrique Barboza <
dbarboza@ventanamicro.com>:

>
>
> On 12/5/24 8:23 AM, baturo.alexey@gmail.com wrote:
> > From: Alexey Baturo <baturo.alexey@gmail.com>
> >
> > Signed-off-by: Alexey Baturo <baturo.alexey@gmail.com>
> >
> > Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> >   target/riscv/cpu.c | 6 ++++++
> >   1 file changed, 6 insertions(+)
> >
> > diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> > index 4e80dcd2e6..fd3ea9ce76 100644
> > --- a/target/riscv/cpu.c
> > +++ b/target/riscv/cpu.c
> > @@ -186,11 +186,14 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
> >       ISA_EXT_DATA_ENTRY(smaia, PRIV_VERSION_1_12_0, ext_smaia),
> >       ISA_EXT_DATA_ENTRY(smcntrpmf, PRIV_VERSION_1_12_0, ext_smcntrpmf)=
,
> >       ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
> > +    ISA_EXT_DATA_ENTRY(smmpm, PRIV_VERSION_1_13_0, ext_smmpm),
> > +    ISA_EXT_DATA_ENTRY(smnpm, PRIV_VERSION_1_13_0, ext_smnpm),
> >       ISA_EXT_DATA_ENTRY(smstateen, PRIV_VERSION_1_12_0, ext_smstateen)=
,
> >       ISA_EXT_DATA_ENTRY(ssaia, PRIV_VERSION_1_12_0, ext_ssaia),
> >       ISA_EXT_DATA_ENTRY(ssccptr, PRIV_VERSION_1_11_0, has_priv_1_11),
> >       ISA_EXT_DATA_ENTRY(sscofpmf, PRIV_VERSION_1_12_0, ext_sscofpmf),
> >       ISA_EXT_DATA_ENTRY(sscounterenw, PRIV_VERSION_1_12_0,
> has_priv_1_12),
> > +    ISA_EXT_DATA_ENTRY(ssnpm, PRIV_VERSION_1_13_0, ext_ssnpm),
>
> I just realized that we're not adding "ext_supm":
>
> "Supm Pointer masking, with the execution environment providing a means
> to select PMLEN=3D0 and PMLEN=3D7 at minimum."
>
> IIUC this is always enabled in the code so this would be a flag that woul=
d
> be always enabled, i.e. it would be a ISA_EXT_DATA_ENTRY that defaults to
> "has_priv_1_13". "sscounterenw" is an example of this kind of extension.
>
> If that's really the case I believe you can add "supm" in this patch or
> maybe
> a new patch right after. We need to advertise support for "supm" for RVA2=
3
> anyway.
>
>
> Thanks,
>
> Daniel
>
>
> >       ISA_EXT_DATA_ENTRY(sstc, PRIV_VERSION_1_12_0, ext_sstc),
> >       ISA_EXT_DATA_ENTRY(sstvala, PRIV_VERSION_1_12_0, has_priv_1_12),
> >       ISA_EXT_DATA_ENTRY(sstvecd, PRIV_VERSION_1_12_0, has_priv_1_12),
> > @@ -1490,9 +1493,12 @@ const RISCVCPUMultiExtConfig
> riscv_cpu_extensions[] =3D {
> >       MULTI_EXT_CFG_BOOL("zvfh", ext_zvfh, false),
> >       MULTI_EXT_CFG_BOOL("zvfhmin", ext_zvfhmin, false),
> >       MULTI_EXT_CFG_BOOL("sstc", ext_sstc, true),
> > +    MULTI_EXT_CFG_BOOL("ssnpm", ext_ssnpm, false),
> >
> >       MULTI_EXT_CFG_BOOL("smaia", ext_smaia, false),
> >       MULTI_EXT_CFG_BOOL("smepmp", ext_smepmp, false),
> > +    MULTI_EXT_CFG_BOOL("smmpm", ext_smmpm, false),
> > +    MULTI_EXT_CFG_BOOL("smnpm", ext_smnpm, false),
> >       MULTI_EXT_CFG_BOOL("smstateen", ext_smstateen, false),
> >       MULTI_EXT_CFG_BOOL("ssaia", ext_ssaia, false),
> >       MULTI_EXT_CFG_BOOL("svade", ext_svade, false),
>
>

--000000000000ebf27d0629621d72
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Daniel,<div><br></div><div>Indeed this series doesn&#39=
;t include the <b>Supm</b> extension, but it&#39;s mandatory for RVA23U64.<=
/div><div>As for the <b>Supm</b> itself, if I get it right, I don&#39;t thi=
nk it should be always-on, unless the proper profile is selected.</div><div=
>I think we might need to add extra flags like <b>ext_supm</b> and <b>ext_s=
spm</b>. Then, to avoid adding extra checks to the existing code, I think w=
e could enable <b>Ssnpm</b> or <b>Smnpm</b> or both somewhere during the in=
itialization if <b>Supm</b> is set. And do the same for <b>Sspm</b>.</div><=
div>From what I see right now in the code, there&#39;s no mention of RVA23,=
 so maybe we could just add some fields for the missing extensions and supp=
ort them later, when RVA23 support is implemented.</div><div>Personally, I&=
#39;d like to do this in a separate patch after these ones are merged.</div=
><div><br></div><div>What do you think?</div><div><br></div><div>Thanks</di=
v></div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"lt=
r" class=3D"gmail_attr">=D1=87=D1=82, 12 =D0=B4=D0=B5=D0=BA. 2024=E2=80=AF=
=D0=B3. =D0=B2 12:48, Daniel Henrique Barboza &lt;<a href=3D"mailto:dbarboz=
a@ventanamicro.com">dbarboza@ventanamicro.com</a>&gt;:<br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex"><br>
<br>
On 12/5/24 8:23 AM, <a href=3D"mailto:baturo.alexey@gmail.com" target=3D"_b=
lank">baturo.alexey@gmail.com</a> wrote:<br>
&gt; From: Alexey Baturo &lt;<a href=3D"mailto:baturo.alexey@gmail.com" tar=
get=3D"_blank">baturo.alexey@gmail.com</a>&gt;<br>
&gt; <br>
&gt; Signed-off-by: Alexey Baturo &lt;<a href=3D"mailto:baturo.alexey@gmail=
.com" target=3D"_blank">baturo.alexey@gmail.com</a>&gt;<br>
&gt; <br>
&gt; Reviewed-by: Alistair Francis &lt;<a href=3D"mailto:alistair.francis@w=
dc.com" target=3D"_blank">alistair.francis@wdc.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0target/riscv/cpu.c | 6 ++++++<br>
&gt;=C2=A0 =C2=A01 file changed, 6 insertions(+)<br>
&gt; <br>
&gt; diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c<br>
&gt; index 4e80dcd2e6..fd3ea9ce76 100644<br>
&gt; --- a/target/riscv/cpu.c<br>
&gt; +++ b/target/riscv/cpu.c<br>
&gt; @@ -186,11 +186,14 @@ const RISCVIsaExtData isa_edata_arr[] =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0ISA_EXT_DATA_ENTRY(smaia, PRIV_VERSION_1_12_=
0, ext_smaia),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0ISA_EXT_DATA_ENTRY(smcntrpmf, PRIV_VERSION_1=
_12_0, ext_smcntrpmf),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12=
_0, ext_smepmp),<br>
&gt; +=C2=A0 =C2=A0 ISA_EXT_DATA_ENTRY(smmpm, PRIV_VERSION_1_13_0, ext_smmp=
m),<br>
&gt; +=C2=A0 =C2=A0 ISA_EXT_DATA_ENTRY(smnpm, PRIV_VERSION_1_13_0, ext_smnp=
m),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0ISA_EXT_DATA_ENTRY(smstateen, PRIV_VERSION_1=
_12_0, ext_smstateen),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0ISA_EXT_DATA_ENTRY(ssaia, PRIV_VERSION_1_12_=
0, ext_ssaia),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0ISA_EXT_DATA_ENTRY(ssccptr, PRIV_VERSION_1_1=
1_0, has_priv_1_11),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0ISA_EXT_DATA_ENTRY(sscofpmf, PRIV_VERSION_1_=
12_0, ext_sscofpmf),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0ISA_EXT_DATA_ENTRY(sscounterenw, PRIV_VERSIO=
N_1_12_0, has_priv_1_12),<br>
&gt; +=C2=A0 =C2=A0 ISA_EXT_DATA_ENTRY(ssnpm, PRIV_VERSION_1_13_0, ext_ssnp=
m),<br>
<br>
I just realized that we&#39;re not adding &quot;ext_supm&quot;:<br>
<br>
&quot;Supm Pointer masking, with the execution environment providing a mean=
s<br>
to select PMLEN=3D0 and PMLEN=3D7 at minimum.&quot;<br>
<br>
IIUC this is always enabled in the code so this would be a flag that would<=
br>
be always enabled, i.e. it would be a ISA_EXT_DATA_ENTRY that defaults to<b=
r>
&quot;has_priv_1_13&quot;. &quot;sscounterenw&quot; is an example of this k=
ind of extension.<br>
<br>
If that&#39;s really the case I believe you can add &quot;supm&quot; in thi=
s patch or maybe<br>
a new patch right after. We need to advertise support for &quot;supm&quot; =
for RVA23<br>
anyway.<br>
<br>
<br>
Thanks,<br>
<br>
Daniel<br>
<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0ISA_EXT_DATA_ENTRY(sstc, PRIV_VERSION_1_12_0=
, ext_sstc),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0ISA_EXT_DATA_ENTRY(sstvala, PRIV_VERSION_1_1=
2_0, has_priv_1_12),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0ISA_EXT_DATA_ENTRY(sstvecd, PRIV_VERSION_1_1=
2_0, has_priv_1_12),<br>
&gt; @@ -1490,9 +1493,12 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensio=
ns[] =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0MULTI_EXT_CFG_BOOL(&quot;zvfh&quot;, ext_zvf=
h, false),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0MULTI_EXT_CFG_BOOL(&quot;zvfhmin&quot;, ext_=
zvfhmin, false),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0MULTI_EXT_CFG_BOOL(&quot;sstc&quot;, ext_sst=
c, true),<br>
&gt; +=C2=A0 =C2=A0 MULTI_EXT_CFG_BOOL(&quot;ssnpm&quot;, ext_ssnpm, false)=
,<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0MULTI_EXT_CFG_BOOL(&quot;smaia&quot;, ext_sm=
aia, false),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0MULTI_EXT_CFG_BOOL(&quot;smepmp&quot;, ext_s=
mepmp, false),<br>
&gt; +=C2=A0 =C2=A0 MULTI_EXT_CFG_BOOL(&quot;smmpm&quot;, ext_smmpm, false)=
,<br>
&gt; +=C2=A0 =C2=A0 MULTI_EXT_CFG_BOOL(&quot;smnpm&quot;, ext_smnpm, false)=
,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0MULTI_EXT_CFG_BOOL(&quot;smstateen&quot;, ex=
t_smstateen, false),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0MULTI_EXT_CFG_BOOL(&quot;ssaia&quot;, ext_ss=
aia, false),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0MULTI_EXT_CFG_BOOL(&quot;svade&quot;, ext_sv=
ade, false),<br>
<br>
</blockquote></div>

--000000000000ebf27d0629621d72--

