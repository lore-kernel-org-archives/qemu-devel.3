Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F0ADD690F9
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 11:31:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGcjh-0001WR-9h; Thu, 28 Nov 2024 06:31:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1tGcje-0001Va-QF; Thu, 28 Nov 2024 06:31:02 -0500
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1tGcjd-0001hA-5K; Thu, 28 Nov 2024 06:31:02 -0500
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2ffc016f301so7201481fa.1; 
 Thu, 28 Nov 2024 03:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732793458; x=1733398258; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=U9bqZyYOye/wOoISkyZN7ldNmHr3u0oRFeDi943v78A=;
 b=XI9r73VBdgxdzTFjZGtoTfmfrnNUvA6o9nXGEOPu7HaAXlCqtkw9hIertdMC+oZBka
 mL6ifRyKyiJVMw9pnbUznM0Mdo5rHD/o61IFoXIvnETHTtn7YQheF9WzjZdO8RvMwqt/
 yombnUZqhxmSjm1quxj4mXM9FDFy/uTi+rNox8VLghkj1OH2cmDAASsdov1aM1UF7pXj
 X/jJwkVdaNSXuxY9xTMpH16fULbtfY7igOmEi/amYP1d2KJUkTxFVrLfSBWOGsHeWckc
 JKTXF+76Jk7MhXIh+7EBzpLDpG1qtlF//Gxr8tuISQZsLbNjDx2VOV922npWJfZCGcGw
 2g5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732793458; x=1733398258;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=U9bqZyYOye/wOoISkyZN7ldNmHr3u0oRFeDi943v78A=;
 b=HlehHkNWLsC9m78Ut3qUv1p2EV4xg6R1dL6wsY/d/cDT25HUDt7lW6ZReBFejyDVvk
 Negv8naIaUSxKbdNtnLp5cC/LjYzqWgB9yBD9NGpEDkEp4qELq++aFM2gRPrXSnIBdYF
 ZtQGC8StVGLZYXGVOi0650oJbfQhOWVNT4kXI5J9oQ+PLu9JJ0HnDBiDrXLwFFHok4xo
 eHG5IN8L1rbDEnb4dHvkUHIiV3ukdCzTUijKgVXduPygU4UraqMlstg+RAIFDgUDAqWu
 msEed7hjaDpGNdXkdpR29NYSkTOcntq/mDP1tElpgOthYcGdmvn/PTV7sxpdeGK87Oy2
 CqHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnAzXA1Npme7Y1vfpQsSHCd5H+losMCO3kN0fXOrWs/0SHsgzeu2MXDWmkJVmOmwQI3nlj5rrSC8GV3w==@nongnu.org,
 AJvYcCX/TxSZK/gZ7m0cOr26nuS9GAxso0FquMR1nrUOX35Hv7evoQ7GbrzrWLfxWZLhW1JxtrCIrSRGP672@nongnu.org
X-Gm-Message-State: AOJu0YxGMPoLcpbOadfSJYVmxlUTa2FvFHq1bMlc2AQUDXD6WYVy2xlj
 nNYAi98n/qo+ryLxI+sCyBSaQ+gFmR994wzoLw44f61XEItD+KCBcflnhvBprBvOVvRcCKmCI2r
 /PB3mKkMCtutyrgmDvMTC4fqOqzI=
X-Gm-Gg: ASbGncsowNigVz2mqpbmFXQW15pu/0EoxTXInD3J5zo+bbRM81QCVvG5sE4VPg+hyHc
 v2KqIkdaFh2IheaCwzCqmzlEbzUjeu9U=
X-Google-Smtp-Source: AGHT+IEc8StZH9ff0hsh9NLncWG5wLuMo3TqBHNlb2j9CsDQ/F9ndE4aDCnIir/rfO4zb5TLmKbb4tCvNNGOECkcJa4=
X-Received: by 2002:a05:651c:1591:b0:2ff:de6d:aee6 with SMTP id
 38308e7fff4ca-2ffde6dafcfmr15512141fa.23.1732793457527; Thu, 28 Nov 2024
 03:30:57 -0800 (PST)
MIME-Version: 1.0
References: <20241127053523.397378-1-baturo.alexey@gmail.com>
 <20241127053523.397378-7-baturo.alexey@gmail.com>
 <33ee1415-7f72-488d-bbf6-cf55e6d0a601@linaro.org>
In-Reply-To: <33ee1415-7f72-488d-bbf6-cf55e6d0a601@linaro.org>
From: Alexey Baturo <baturo.alexey@gmail.com>
Date: Thu, 28 Nov 2024 14:30:46 +0300
Message-ID: <CAFukJ-BC5tSeNF8kDZJ6=JbAmwq=GijZb3T+M+OJsmRuokRK3Q@mail.gmail.com>
Subject: Re: [PATCH v11 6/7] target/riscv: Apply pointer masking for
 virtualized memory accesses
To: Richard Henderson <richard.henderson@linaro.org>
Cc: zhiwei_liu@linux.alibaba.com, dbarboza@ventanamicro.com, 
 liwei1518@gmail.com, alistair23@gmail.com, frank.chang@sifive.com, 
 palmer@dabbelt.com, Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu, 
 kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000815aa80627f76a03"
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=baturo.alexey@gmail.com; helo=mail-lj1-x231.google.com
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

--000000000000815aa80627f76a03
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Richard,

Thanks for the suggestions. I'll wait for a week or for extra comments on
this series and would send a new fixed one.
Thanks again!

=D1=81=D1=80, 27 =D0=BD=D0=BE=D1=8F=D0=B1. 2024=E2=80=AF=D0=B3. =D0=B2 19:0=
8, Richard Henderson <
richard.henderson@linaro.org>:

> On 11/26/24 23:35, baturo.alexey@gmail.com wrote:
> > From: Alexey Baturo <baturo.alexey@gmail.com>
> >
> > Signed-off-by: Alexey Baturo <baturo.alexey@gmail.com>
> > ---
> >   target/riscv/cpu.h                      |  2 ++
> >   target/riscv/cpu_helper.c               | 19 +++++++++++++++++++
> >   target/riscv/insn_trans/trans_rvh.c.inc | 11 +++++++++++
> >   target/riscv/translate.c                |  4 ++++
> >   4 files changed, 36 insertions(+)
> >
> > diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> > index 11e3a6d647..6bbd9c6c25 100644
> > --- a/target/riscv/cpu.h
> > +++ b/target/riscv/cpu.h
> > @@ -634,6 +634,7 @@ FIELD(TB_FLAGS, BCFI_ENABLED, 28, 1)
> >   /* If pointer masking should be applied and address sign extended */
> >   FIELD(TB_FLAGS, PM_PMM, 29, 2)
> >   FIELD(TB_FLAGS, PM_SIGNEXTEND, 31, 1)
> > +FIELD(TB_FLAGS, PM_VPMM, 32, 2)
>
> (1) tb_flags is only 32 bits wide, and this overflows.
>
> (2) All of the logic for HSV/HLV is in op_helper.c, so there's no point i=
n
> doing this
> masking inline.  Do it in helper_hyp_* instead, possibly reusing pieces o=
f
> adjust_addr
> from vector_helper.c.
>
>
> r~
>

--000000000000815aa80627f76a03
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Richard,<div><br></div><div>Thanks for the suggestions.=
 I&#39;ll wait for a week or for extra comments on this series and would se=
nd a new fixed one.</div><div>Thanks again!=C2=A0</div></div><br><div class=
=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr=
">=D1=81=D1=80, 27 =D0=BD=D0=BE=D1=8F=D0=B1. 2024=E2=80=AF=D0=B3. =D0=B2 19=
:08, Richard Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.org">=
richard.henderson@linaro.org</a>&gt;:<br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">On 11/26/24 23:35, <a href=3D"mailto:baturo.alexey@gm=
ail.com" target=3D"_blank">baturo.alexey@gmail.com</a> wrote:<br>
&gt; From: Alexey Baturo &lt;<a href=3D"mailto:baturo.alexey@gmail.com" tar=
get=3D"_blank">baturo.alexey@gmail.com</a>&gt;<br>
&gt; <br>
&gt; Signed-off-by: Alexey Baturo &lt;<a href=3D"mailto:baturo.alexey@gmail=
.com" target=3D"_blank">baturo.alexey@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0target/riscv/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 ++<br>
&gt;=C2=A0 =C2=A0target/riscv/cpu_helper.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0| 19 +++++++++++++++++++<br>
&gt;=C2=A0 =C2=A0target/riscv/insn_trans/trans_rvh.c.inc | 11 +++++++++++<b=
r>
&gt;=C2=A0 =C2=A0target/riscv/translate.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 4 ++++<br>
&gt;=C2=A0 =C2=A04 files changed, 36 insertions(+)<br>
&gt; <br>
&gt; diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h<br>
&gt; index 11e3a6d647..6bbd9c6c25 100644<br>
&gt; --- a/target/riscv/cpu.h<br>
&gt; +++ b/target/riscv/cpu.h<br>
&gt; @@ -634,6 +634,7 @@ FIELD(TB_FLAGS, BCFI_ENABLED, 28, 1)<br>
&gt;=C2=A0 =C2=A0/* If pointer masking should be applied and address sign e=
xtended */<br>
&gt;=C2=A0 =C2=A0FIELD(TB_FLAGS, PM_PMM, 29, 2)<br>
&gt;=C2=A0 =C2=A0FIELD(TB_FLAGS, PM_SIGNEXTEND, 31, 1)<br>
&gt; +FIELD(TB_FLAGS, PM_VPMM, 32, 2)<br>
<br>
(1) tb_flags is only 32 bits wide, and this overflows.<br>
<br>
(2) All of the logic for HSV/HLV is in op_helper.c, so there&#39;s no point=
 in doing this <br>
masking inline.=C2=A0 Do it in helper_hyp_* instead, possibly reusing piece=
s of adjust_addr <br>
from vector_helper.c.<br>
<br>
<br>
r~<br>
</blockquote></div>

--000000000000815aa80627f76a03--

