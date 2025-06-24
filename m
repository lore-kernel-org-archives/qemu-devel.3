Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83445C77B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 03:12:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTu5H-0007bw-Pz; Mon, 23 Jun 2025 23:12:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1uTu5F-0007Ya-Py
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 23:12:29 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1uTu5E-000352-05
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 23:12:29 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-313a188174fso3773306a91.1
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 20:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1750734746; x=1751339546; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=a8WABByH5fUTCtQw5whMIskkE+MdZh/jm0wbwSTvqsk=;
 b=X1eeUHbJYqrRO6Bi0AN1EmcipU7MUdh1uaz0ZBsq0uQ/YbUr7ZJLvRjSMQkP2CPJ93
 G+2MRkSrsom7UzcuJs3LMZRbCMyhIjNwScon9EnSOGz4nsnz/ak0/8KERp9Rpi4qYkRn
 UEjUJobTPHBj5ho8vbb5NKeCqHDO2jIBYVUkDhFMPFGsz1q/x7XWJaepYSwmsqR09CtQ
 NuMiP20p47MnifYP6X5c/5UY8qC2E+ch3G/X4O9c7HeqYur24oGUimGS/iMZgCpx1ke8
 0ZmzK8Lvck8wA+QdkL+LXsOpHJabGpbUb74DzvxgHEkvXRMZwrnQ1eljPtvh4mIOIElm
 8ihA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750734746; x=1751339546;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=a8WABByH5fUTCtQw5whMIskkE+MdZh/jm0wbwSTvqsk=;
 b=pWfiOprk0Q8mfhF86YPW6XStijh4ijlHS+AVjHYSQ+ab6qbOnmjQDCij0WoE4WYvmU
 9/51f70m2fikjM+F1k/cv1asFP9hwvO3l83uSvZP/46feVWYboFuLlBHDm+zJ9fU4AkI
 6PZkrF8dGTd2YIKtfB/ou+ePmLJDO8MJrkRWkF4F3Qp1wuVjZOSR7uRRndeMW7uaS29i
 l5WLZCCDegYUT2HzvBZQ6hZXT/bu59HpnvtnOW4OjK3Rab3nkmKsXKNMZ4+qL/7ZzIgJ
 7AGxOLvWMhg/MJE0u4Qf6GwZUwLkZ1A+aYp6x2d+9GJBubZchzbp4Cmp92lqYMxNCgI8
 MngQ==
X-Gm-Message-State: AOJu0YzWxDuYoR4I8gQyA/s/oJhNRVQdx8p3pWiWcGVbav6UAEobUVXI
 pc83xXWyaIGqY/gdjeT+80RmJcsc33YDPON35DTRdhUEP2PSJP+XNlMbu6ihmT1wDijSXp0elgd
 lSP6nWKvrTM7CfcMZ6JYiC+bfYrRtq8QTNIj/GXvnAWD0NZiAijCxd48=
X-Gm-Gg: ASbGncuAcVA7QGWZj8c4pWkQseD4eS2f+irNoubmyDSM8NaRW3xvqeKi0nPAvr8FV6c
 CMKD843ziN9YIxEYUP1iN4h5guQqkJcXtohPaTMHTY1OoPq5rrhAWyrLdKpJDwkRoXmKYVtEL5q
 ay/t+P/qImo08sUfdLfKCi9ze4ofpzIF/fZ3SfuWCp7Ns0NgUlikjlBKAN
X-Google-Smtp-Source: AGHT+IFJhPwFzG0ihnslUC5QBWZd983snHwoSyEBz9+0kyf7EiOa3oPkzWa7KdB8oIPx03/boAp7z02/duU2supmUmQ=
X-Received: by 2002:a17:90b:5586:b0:312:e73e:cded with SMTP id
 98e67ed59e1d1-315ccd7261emr2794155a91.16.1750734745753; Mon, 23 Jun 2025
 20:12:25 -0700 (PDT)
MIME-Version: 1.0
References: <20250401103344.84257-1-jay.chang@sifive.com>
In-Reply-To: <20250401103344.84257-1-jay.chang@sifive.com>
From: Jay Chang <jay.chang@sifive.com>
Date: Tue, 24 Jun 2025 11:12:14 +0800
X-Gm-Features: AX0GCFu6Gti6niGyiSDlG2TCXm8MS5Be-sWZYVyAdtav8G2GPxjCBlliwlt6EOY
Message-ID: <CACNNAjP_h4Z2QZZHJXryqsFNSENyLbhZ-ArLFjosChFzou3_kQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] target/riscv: Restrict mideleg/medeleg/medelegh
 access to S-mode harts
To: qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Frank Chang <frank.chang@sifive.com>
Content-Type: multipart/alternative; boundary="0000000000009dff2c063848b299"
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=jay.chang@sifive.com; helo=mail-pj1-x102d.google.com
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

--0000000000009dff2c063848b299
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Gentle ping on this patch.

Thanks,
Jay Chang

On Tue, Apr 1, 2025 at 6:34=E2=80=AFPM Jay Chang <jay.chang@sifive.com> wro=
te:

> RISC-V Privileged Spec states:
> "In harts with S-mode, the medeleg and mideleg registers must exist, and
> setting a bit in medeleg or mideleg will delegate the corresponding trap
> , when occurring in S-mode or U-mode, to the S-mode trap handler. In
> harts without S-mode, the medeleg and mideleg registers should not
> exist."
>
> Add smode predicate to ensure these CSRs are only accessible when S-mode
> is supported.
>
> Reviewed-by: Frank Chang <frank.chang@sifive.com>
> Signed-off-by: Jay Chang <jay.chang@sifive.com>
> ---
>  target/riscv/csr.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 7948188356..975d6e307f 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -5783,8 +5783,8 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] =3D {
>                            NULL,                read_mstatus_i128
>  },
>      [CSR_MISA]        =3D { "misa",       any,   read_misa,    write_mis=
a,
>                            NULL,                read_misa_i128
>   },
> -    [CSR_MIDELEG]     =3D { "mideleg",    any,   NULL, NULL,   rmw_midel=
eg
>  },
> -    [CSR_MEDELEG]     =3D { "medeleg",    any,   read_medeleg,
> write_medeleg },
> +    [CSR_MIDELEG]     =3D { "mideleg",    smode,   NULL, NULL,
>  rmw_mideleg   },
> +    [CSR_MEDELEG]     =3D { "medeleg",    smode,   read_medeleg,
> write_medeleg },
>      [CSR_MIE]         =3D { "mie",        any,   NULL, NULL,   rmw_mie
>  },
>      [CSR_MTVEC]       =3D { "mtvec",      any,   read_mtvec,   write_mtv=
ec
>  },
>      [CSR_MCOUNTEREN]  =3D { "mcounteren", umode, read_mcounteren,
> @@ -5792,7 +5792,7 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] =3D {
>
>      [CSR_MSTATUSH]    =3D { "mstatush",   any32, read_mstatush,
>                            write_mstatush
>  },
> -    [CSR_MEDELEGH]    =3D { "medelegh",   any32, read_zero, write_ignore=
,
> +    [CSR_MEDELEGH]    =3D { "medelegh",   smode32, read_zero, write_igno=
re,
>                            .min_priv_ver =3D PRIV_VERSION_1_13_0
>   },
>      [CSR_HEDELEGH]    =3D { "hedelegh",   hmode32, read_hedelegh,
> write_hedelegh,
>                            .min_priv_ver =3D PRIV_VERSION_1_13_0
>   },
> --
> 2.48.1
>
>

--0000000000009dff2c063848b299
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><br>Gentle=C2=A0<span class=3D"gmail-il"><span clas=
s=3D"gmail-il">ping</span></span>=C2=A0on this patch.<br><br>Thanks,<br>Jay=
 Chang</div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=
=3D"ltr" class=3D"gmail_attr">On Tue, Apr 1, 2025 at 6:34=E2=80=AFPM Jay Ch=
ang &lt;<a href=3D"mailto:jay.chang@sifive.com">jay.chang@sifive.com</a>&gt=
; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">RISC-V =
Privileged Spec states:<br>
&quot;In harts with S-mode, the medeleg and mideleg registers must exist, a=
nd<br>
setting a bit in medeleg or mideleg will delegate the corresponding trap<br=
>
, when occurring in S-mode or U-mode, to the S-mode trap handler. In<br>
harts without S-mode, the medeleg and mideleg registers should not<br>
exist.&quot;<br>
<br>
Add smode predicate to ensure these CSRs are only accessible when S-mode<br=
>
is supported.<br>
<br>
Reviewed-by: Frank Chang &lt;<a href=3D"mailto:frank.chang@sifive.com" targ=
et=3D"_blank">frank.chang@sifive.com</a>&gt;<br>
Signed-off-by: Jay Chang &lt;<a href=3D"mailto:jay.chang@sifive.com" target=
=3D"_blank">jay.chang@sifive.com</a>&gt;<br>
---<br>
=C2=A0target/riscv/csr.c | 6 +++---<br>
=C2=A01 file changed, 3 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/target/riscv/csr.c b/target/riscv/csr.c<br>
index 7948188356..975d6e307f 100644<br>
--- a/target/riscv/csr.c<br>
+++ b/target/riscv/csr.c<br>
@@ -5783,8 +5783,8 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] =3D {<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0NULL,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 read_mstatus_i128=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0},<br>
=C2=A0 =C2=A0 =C2=A0[CSR_MISA]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D { &quot;misa&=
quot;,=C2=A0 =C2=A0 =C2=A0 =C2=A0any,=C2=A0 =C2=A0read_misa,=C2=A0 =C2=A0 w=
rite_misa,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0NULL,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 read_misa_i128=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }=
,<br>
-=C2=A0 =C2=A0 [CSR_MIDELEG]=C2=A0 =C2=A0 =C2=A0=3D { &quot;mideleg&quot;,=
=C2=A0 =C2=A0 any,=C2=A0 =C2=A0NULL, NULL,=C2=A0 =C2=A0rmw_mideleg=C2=A0 =
=C2=A0},<br>
-=C2=A0 =C2=A0 [CSR_MEDELEG]=C2=A0 =C2=A0 =C2=A0=3D { &quot;medeleg&quot;,=
=C2=A0 =C2=A0 any,=C2=A0 =C2=A0read_medeleg, write_medeleg },<br>
+=C2=A0 =C2=A0 [CSR_MIDELEG]=C2=A0 =C2=A0 =C2=A0=3D { &quot;mideleg&quot;,=
=C2=A0 =C2=A0 smode,=C2=A0 =C2=A0NULL, NULL,=C2=A0 =C2=A0rmw_mideleg=C2=A0 =
=C2=A0},<br>
+=C2=A0 =C2=A0 [CSR_MEDELEG]=C2=A0 =C2=A0 =C2=A0=3D { &quot;medeleg&quot;,=
=C2=A0 =C2=A0 smode,=C2=A0 =C2=A0read_medeleg, write_medeleg },<br>
=C2=A0 =C2=A0 =C2=A0[CSR_MIE]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D { &quot;=
mie&quot;,=C2=A0 =C2=A0 =C2=A0 =C2=A0 any,=C2=A0 =C2=A0NULL, NULL,=C2=A0 =
=C2=A0rmw_mie=C2=A0 =C2=A0 =C2=A0 =C2=A0},<br>
=C2=A0 =C2=A0 =C2=A0[CSR_MTVEC]=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D { &quot;mtvec=
&quot;,=C2=A0 =C2=A0 =C2=A0 any,=C2=A0 =C2=A0read_mtvec,=C2=A0 =C2=A0write_=
mtvec=C2=A0 =C2=A0},<br>
=C2=A0 =C2=A0 =C2=A0[CSR_MCOUNTEREN]=C2=A0 =3D { &quot;mcounteren&quot;, um=
ode, read_mcounteren,<br>
@@ -5792,7 +5792,7 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] =3D {<br=
>
<br>
=C2=A0 =C2=A0 =C2=A0[CSR_MSTATUSH]=C2=A0 =C2=A0 =3D { &quot;mstatush&quot;,=
=C2=A0 =C2=A0any32, read_mstatush,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0write_mstatush=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0},<br>
-=C2=A0 =C2=A0 [CSR_MEDELEGH]=C2=A0 =C2=A0 =3D { &quot;medelegh&quot;,=C2=
=A0 =C2=A0any32, read_zero, write_ignore,<br>
+=C2=A0 =C2=A0 [CSR_MEDELEGH]=C2=A0 =C2=A0 =3D { &quot;medelegh&quot;,=C2=
=A0 =C2=A0smode32, read_zero, write_ignore,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0.min_priv_ver =3D PRIV_VERSION_1_13_0=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
=C2=A0 =C2=A0 =C2=A0[CSR_HEDELEGH]=C2=A0 =C2=A0 =3D { &quot;hedelegh&quot;,=
=C2=A0 =C2=A0hmode32, read_hedelegh, write_hedelegh,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0.min_priv_ver =3D PRIV_VERSION_1_13_0=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
-- <br>
2.48.1<br>
<br>
</blockquote></div>

--0000000000009dff2c063848b299--

