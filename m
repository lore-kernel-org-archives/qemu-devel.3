Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D9DCD116E2
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 05:12:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vPwCk-0005Lv-V0; Mon, 01 Dec 2025 00:12:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1vPwCM-0005Im-5N
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 00:11:45 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1vPwCI-0006TX-G9
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 00:11:41 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-298145fe27eso60808055ad.1
 for <qemu-devel@nongnu.org>; Sun, 30 Nov 2025 21:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1764565896; x=1765170696; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=j+wN0pHsQOi35Wj8PmTtUZZxChUvqrMjrS/WbHnmhaY=;
 b=d5+l/7B2QN3+E6J9H7UMGY7sNlgevYYCCQUxiOPAT+1P6n8btAG9xzOefHtCwi9wFJ
 AnvklHlKATJXTO+NM7yNOc9dULhPMykuBJOnyZiWYk3QhUcFf2oIy1uCkrjtOEw+02nB
 05YkwMc98ABUWHJOrS2jjMuKgpqBdV8hSj/lGs24neExdKDVEoaoUjQvYz2rmIRa5CoS
 d1nI86UMig1N7SfjN99T8qFziQilhfB+uOnJ10i4lnfesstem7DkkmKoGjvmg0KGF8X4
 oHNmz/XmlnPr6gNxyLOq4em61vGCQh/Zkkl/e6hCwjp2RXrISW63Yi/AfDeEa7vtjg1e
 eCQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764565896; x=1765170696;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j+wN0pHsQOi35Wj8PmTtUZZxChUvqrMjrS/WbHnmhaY=;
 b=WCeAjM8mmzFnIArmyia5FalbRHwf1LSeoeEhHuYKV0Qtrx6tQYIGqAqVV7YoNIMD+l
 d3Fu9r8mWJbwD3MVyhxM0qM94knvLIktQFggIY9Thxmn7ciAOaDpl30JEXffs/0dpeAb
 ZBD21PjpvhglRrJeaXJVaONHVJxrFqgN7x5s50d4V0cF5xYTERdpPOk3MydRCsh50qWl
 2kKdYGa49aLlT0txcLev4kiot1NLG7f/os3Dbq3JuIC50fGTKwNmGyKoEX2AZt5wisSZ
 fOessCl28mwwk6rQJLLsDYcMK2PURMsobR8885qjmouCJBcnRyEfnSiPdgVxQQtX49X2
 Kf8w==
X-Gm-Message-State: AOJu0YzA7JFzWH9u7pcwdYHQB94uyg7DTlCbcihJLl4UqYoARVX8N9RM
 K05Z/9RtHHsL5oc5xLMWFRg2c3+7/vORvDWiVlR3bRPqkadZyXN9AYrTpDk1iqoMEJ77cQ2zD85
 t5Rfo6Ou37B6U8L7KmHgfYUtOOzh4GJUGvP2gCWDLRBTGEtSH+W1RjBg=
X-Gm-Gg: ASbGncsTJalD4ugMjwuJKkd2lyqB6mfg2RlIYmITDcJsbsfnLMMWc5OXZZIbX1kEfft
 dZ2pD1fuIGvrZ5JbszZdF/dPr2pvUBzELeujDY8a1bkIME/hDM8yxtC8lllch14z/NHbNlDlf9T
 aO03zjqo7pHkdMM5KD8rbMvgdYq8nJKOoPY9M1zpKXri7l0cmxFSqHmok8o6tG9Zbqeo3oZjT+9
 9105x85x6yqRzqK5BwO2fdv5+KF2bc+cDPT62u3+zuHLJ0/T9oiqwgppIBa+Il6dya9P74kO31l
 DeuyL9Y2
X-Google-Smtp-Source: AGHT+IER7Tfo0p8Cp72g8aqV0EivXiWxUMux2TnXBXhozIszMeZq2xWRKJq6kzJF5i0tdCJigco1k4vpywJyem5eMBk=
X-Received: by 2002:a05:7022:a8e:b0:119:e56b:c75a with SMTP id
 a92af1059eb24-11cb6835484mr15306937c88.31.1764565896181; Sun, 30 Nov 2025
 21:11:36 -0800 (PST)
MIME-Version: 1.0
References: <20251107023136.89181-1-jay.chang@sifive.com>
In-Reply-To: <20251107023136.89181-1-jay.chang@sifive.com>
From: Jay Chang <jay.chang@sifive.com>
Date: Mon, 1 Dec 2025 13:11:25 +0800
X-Gm-Features: AWmQ_bm_N0sOhG15C-fjt9iyeD87ioTyZSRjGo9fZxhyejyQ5_O014elguXlHes
Message-ID: <CACNNAjP+Nhay5hE22nFnR6z5nHiyQGKqENg128+rTv5B3cv0eQ@mail.gmail.com>
Subject: Re: [PATCH v2] target/riscv: Support Smpmpmt extension
To: qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Frank Chang <frank.chang@sifive.com>
Content-Type: multipart/alternative; boundary="0000000000006cc91d0644dd035b"
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=jay.chang@sifive.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--0000000000006cc91d0644dd035b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Gentle ping on this patch.

Thanks,
Jay Chang

On Fri, Nov 7, 2025 at 10:31=E2=80=AFAM Jay Chang <jay.chang@sifive.com> wr=
ote:

> The Smpmpmt extension provides a mechanism to control memory attributes
> at the granularity of PMP (Physical Memory Protection) registers, similar
> to how Svpbmt controls memory attributes at the page level.
>
> Version 0.6
>
> https://github.com/riscv/riscv-isa-manual/blob/smpmpmt/src/smpmpmt.adoc#s=
vpbmt
>
> Signed-off-by: Jay Chang <jay.chang@sifive.com>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Reviewed-by: Frank Chang <frank.chang@sifive.com>
>
> ---
> v2:
>     Place smpmpmt in the correct riscv,isa order.
>
> Signed-off-by: Jay Chang <jay.chang@sifive.com>
> ---
>  target/riscv/cpu.c                |  2 ++
>  target/riscv/cpu_cfg_fields.h.inc |  1 +
>  target/riscv/pmp.c                | 12 ++++++++++++
>  target/riscv/pmp.h                |  1 +
>  4 files changed, 16 insertions(+)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index ae8b721e55..0760ee7d9e 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -203,6 +203,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
>      ISA_EXT_DATA_ENTRY(smcsrind, PRIV_VERSION_1_13_0, ext_smcsrind),
>      ISA_EXT_DATA_ENTRY(smdbltrp, PRIV_VERSION_1_13_0, ext_smdbltrp),
>      ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
> +    ISA_EXT_DATA_ENTRY(smpmpmt, PRIV_VERSION_1_12_0, ext_smpmpmt),
>      ISA_EXT_DATA_ENTRY(smrnmi, PRIV_VERSION_1_12_0, ext_smrnmi),
>      ISA_EXT_DATA_ENTRY(smmpm, PRIV_VERSION_1_13_0, ext_smmpm),
>      ISA_EXT_DATA_ENTRY(smnpm, PRIV_VERSION_1_13_0, ext_smnpm),
> @@ -1262,6 +1263,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[]
> =3D {
>      MULTI_EXT_CFG_BOOL("svinval", ext_svinval, false),
>      MULTI_EXT_CFG_BOOL("svnapot", ext_svnapot, false),
>      MULTI_EXT_CFG_BOOL("svpbmt", ext_svpbmt, false),
> +    MULTI_EXT_CFG_BOOL("smpmpmt", ext_smpmpmt, false),
>      MULTI_EXT_CFG_BOOL("svrsw60t59b", ext_svrsw60t59b, false),
>      MULTI_EXT_CFG_BOOL("svvptc", ext_svvptc, true),
>
> diff --git a/target/riscv/cpu_cfg_fields.h.inc
> b/target/riscv/cpu_cfg_fields.h.inc
> index a154ecdc79..b1096da664 100644
> --- a/target/riscv/cpu_cfg_fields.h.inc
> +++ b/target/riscv/cpu_cfg_fields.h.inc
> @@ -57,6 +57,7 @@ BOOL_FIELD(ext_svadu)
>  BOOL_FIELD(ext_svinval)
>  BOOL_FIELD(ext_svnapot)
>  BOOL_FIELD(ext_svpbmt)
> +BOOL_FIELD(ext_smpmpmt)
>  BOOL_FIELD(ext_svrsw60t59b)
>  BOOL_FIELD(ext_svvptc)
>  BOOL_FIELD(ext_svukte)
> diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
> index 3ef62d26ad..52a7677683 100644
> --- a/target/riscv/pmp.c
> +++ b/target/riscv/pmp.c
> @@ -165,6 +165,18 @@ static bool pmp_write_cfg(CPURISCVState *env,
> uint32_t pmp_index, uint8_t val)
>                            "ignoring pmpcfg write - invalid\n");
>          } else {
>              uint8_t a_field =3D pmp_get_a_field(val);
> +
> +            if (!riscv_cpu_cfg(env)->ext_smpmpmt) {
> +                /* If smpmpmt not supported, clear the MTMATCH bit */
> +                val &=3D ~PMP_MTMATCH;
> +            } else if ((val & PMP_MTMATCH) =3D=3D PMP_MTMATCH) {
> +                /*
> +                 * If trying to set reserved value (0x3) for MT field,
> +                 * preserve the original MT field from current config.
> +                 */
> +                val =3D (val & ~PMP_MTMATCH) |
> +                    (env->pmp_state.pmp[pmp_index].cfg_reg & PMP_MTMATCH=
);
> +            }
>              /*
>               * When granularity g >=3D 1 (i.e., granularity > 4 bytes),
>               * the NA4 (Naturally Aligned 4-byte) mode is not selectable
> diff --git a/target/riscv/pmp.h b/target/riscv/pmp.h
> index 271cf24169..467fb6b4b1 100644
> --- a/target/riscv/pmp.h
> +++ b/target/riscv/pmp.h
> @@ -29,6 +29,7 @@ typedef enum {
>      PMP_WRITE =3D 1 << 1,
>      PMP_EXEC  =3D 1 << 2,
>      PMP_AMATCH =3D (3 << 3),
> +    PMP_MTMATCH =3D (3 << 5),
>      PMP_LOCK  =3D 1 << 7
>  } pmp_priv_t;
>
> --
> 2.48.1
>
>

--0000000000006cc91d0644dd035b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><br>Gentle=C2=A0<span class=3D"gmail-il">ping</span=
>=C2=A0on this patch.<br><br>Thanks,<br>Jay Chang</div><br><div class=3D"gm=
ail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On F=
ri, Nov 7, 2025 at 10:31=E2=80=AFAM Jay Chang &lt;<a href=3D"mailto:jay.cha=
ng@sifive.com">jay.chang@sifive.com</a>&gt; wrote:<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">The Smpmpmt extension provides a mechani=
sm to control memory attributes<br>
at the granularity of PMP (Physical Memory Protection) registers, similar<b=
r>
to how Svpbmt controls memory attributes at the page level.<br>
<br>
Version 0.6<br>
<a href=3D"https://github.com/riscv/riscv-isa-manual/blob/smpmpmt/src/smpmp=
mt.adoc#svpbmt" rel=3D"noreferrer" target=3D"_blank">https://github.com/ris=
cv/riscv-isa-manual/blob/smpmpmt/src/smpmpmt.adoc#svpbmt</a><br>
<br>
Signed-off-by: Jay Chang &lt;<a href=3D"mailto:jay.chang@sifive.com" target=
=3D"_blank">jay.chang@sifive.com</a>&gt;<br>
Reviewed-by: Daniel Henrique Barboza &lt;<a href=3D"mailto:dbarboza@ventana=
micro.com" target=3D"_blank">dbarboza@ventanamicro.com</a>&gt;<br>
Reviewed-by: Frank Chang &lt;<a href=3D"mailto:frank.chang@sifive.com" targ=
et=3D"_blank">frank.chang@sifive.com</a>&gt;<br>
<br>
---<br>
v2:<br>
=C2=A0 =C2=A0 Place smpmpmt in the correct riscv,isa order.<br>
<br>
Signed-off-by: Jay Chang &lt;<a href=3D"mailto:jay.chang@sifive.com" target=
=3D"_blank">jay.chang@sifive.com</a>&gt;<br>
---<br>
=C2=A0target/riscv/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 2 ++<br>
=C2=A0target/riscv/cpu_cfg_fields.h.inc |=C2=A0 1 +<br>
=C2=A0target/riscv/pmp.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 | 12 ++++++++++++<br>
=C2=A0target/riscv/pmp.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 1 +<br>
=C2=A04 files changed, 16 insertions(+)<br>
<br>
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c<br>
index ae8b721e55..0760ee7d9e 100644<br>
--- a/target/riscv/cpu.c<br>
+++ b/target/riscv/cpu.c<br>
@@ -203,6 +203,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {<br>
=C2=A0 =C2=A0 =C2=A0ISA_EXT_DATA_ENTRY(smcsrind, PRIV_VERSION_1_13_0, ext_s=
mcsrind),<br>
=C2=A0 =C2=A0 =C2=A0ISA_EXT_DATA_ENTRY(smdbltrp, PRIV_VERSION_1_13_0, ext_s=
mdbltrp),<br>
=C2=A0 =C2=A0 =C2=A0ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_sme=
pmp),<br>
+=C2=A0 =C2=A0 ISA_EXT_DATA_ENTRY(smpmpmt, PRIV_VERSION_1_12_0, ext_smpmpmt=
),<br>
=C2=A0 =C2=A0 =C2=A0ISA_EXT_DATA_ENTRY(smrnmi, PRIV_VERSION_1_12_0, ext_smr=
nmi),<br>
=C2=A0 =C2=A0 =C2=A0ISA_EXT_DATA_ENTRY(smmpm, PRIV_VERSION_1_13_0, ext_smmp=
m),<br>
=C2=A0 =C2=A0 =C2=A0ISA_EXT_DATA_ENTRY(smnpm, PRIV_VERSION_1_13_0, ext_smnp=
m),<br>
@@ -1262,6 +1263,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] =
=3D {<br>
=C2=A0 =C2=A0 =C2=A0MULTI_EXT_CFG_BOOL(&quot;svinval&quot;, ext_svinval, fa=
lse),<br>
=C2=A0 =C2=A0 =C2=A0MULTI_EXT_CFG_BOOL(&quot;svnapot&quot;, ext_svnapot, fa=
lse),<br>
=C2=A0 =C2=A0 =C2=A0MULTI_EXT_CFG_BOOL(&quot;svpbmt&quot;, ext_svpbmt, fals=
e),<br>
+=C2=A0 =C2=A0 MULTI_EXT_CFG_BOOL(&quot;smpmpmt&quot;, ext_smpmpmt, false),=
<br>
=C2=A0 =C2=A0 =C2=A0MULTI_EXT_CFG_BOOL(&quot;svrsw60t59b&quot;, ext_svrsw60=
t59b, false),<br>
=C2=A0 =C2=A0 =C2=A0MULTI_EXT_CFG_BOOL(&quot;svvptc&quot;, ext_svvptc, true=
),<br>
<br>
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_field=
s.h.inc<br>
index a154ecdc79..b1096da664 100644<br>
--- a/target/riscv/cpu_cfg_fields.h.inc<br>
+++ b/target/riscv/cpu_cfg_fields.h.inc<br>
@@ -57,6 +57,7 @@ BOOL_FIELD(ext_svadu)<br>
=C2=A0BOOL_FIELD(ext_svinval)<br>
=C2=A0BOOL_FIELD(ext_svnapot)<br>
=C2=A0BOOL_FIELD(ext_svpbmt)<br>
+BOOL_FIELD(ext_smpmpmt)<br>
=C2=A0BOOL_FIELD(ext_svrsw60t59b)<br>
=C2=A0BOOL_FIELD(ext_svvptc)<br>
=C2=A0BOOL_FIELD(ext_svukte)<br>
diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c<br>
index 3ef62d26ad..52a7677683 100644<br>
--- a/target/riscv/pmp.c<br>
+++ b/target/riscv/pmp.c<br>
@@ -165,6 +165,18 @@ static bool pmp_write_cfg(CPURISCVState *env, uint32_t=
 pmp_index, uint8_t val)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0&quot;ignoring pmpcfg write - invalid\n&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint8_t a_field =3D pmp_get=
_a_field(val);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!riscv_cpu_cfg(env)-&gt;ext_=
smpmpmt) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* If smpmpmt not =
supported, clear the MTMATCH bit */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 val &amp;=3D ~PMP_=
MTMATCH;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if ((val &amp; PMP_MTMATC=
H) =3D=3D PMP_MTMATCH) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* If trying =
to set reserved value (0x3) for MT field,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* preserve t=
he original MT field from current config.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 val =3D (val &amp;=
 ~PMP_MTMATCH) |<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (env=
-&gt;pmp_state.pmp[pmp_index].cfg_reg &amp; PMP_MTMATCH);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * When granularity g &gt;=
=3D 1 (i.e., granularity &gt; 4 bytes),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * the NA4 (Naturally Align=
ed 4-byte) mode is not selectable<br>
diff --git a/target/riscv/pmp.h b/target/riscv/pmp.h<br>
index 271cf24169..467fb6b4b1 100644<br>
--- a/target/riscv/pmp.h<br>
+++ b/target/riscv/pmp.h<br>
@@ -29,6 +29,7 @@ typedef enum {<br>
=C2=A0 =C2=A0 =C2=A0PMP_WRITE =3D 1 &lt;&lt; 1,<br>
=C2=A0 =C2=A0 =C2=A0PMP_EXEC=C2=A0 =3D 1 &lt;&lt; 2,<br>
=C2=A0 =C2=A0 =C2=A0PMP_AMATCH =3D (3 &lt;&lt; 3),<br>
+=C2=A0 =C2=A0 PMP_MTMATCH =3D (3 &lt;&lt; 5),<br>
=C2=A0 =C2=A0 =C2=A0PMP_LOCK=C2=A0 =3D 1 &lt;&lt; 7<br>
=C2=A0} pmp_priv_t;<br>
<br>
-- <br>
2.48.1<br>
<br>
</blockquote></div>

--0000000000006cc91d0644dd035b--

