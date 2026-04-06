Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F120EFB5164
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2026 20:55:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9qxt-0008T0-0l; Mon, 06 Apr 2026 16:54:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1w9qxm-0008R0-Pg
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 16:54:27 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1w9qxl-0002Za-33
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 16:54:26 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-82cebbdbdccso2204179b3a.1
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2026 13:54:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775508863; cv=none;
 d=google.com; s=arc-20240605;
 b=Ia5ufVbGdVFhdNXOj1YOk73EPIZnlU+4atEnVptNWXob9x2BAC7yXPPE48OpBCSz7j
 K4x/NypyqYCvo4uAvUHUrwOpShidEMxAgWdrdFyvu788C2Dxn0nC46enQ3xVHo3eUxm/
 DJ9I886T+RoH7vEXOwCw41Hw11+snEn0ojlz76hpbWRXYDK93WJ7xY6QtH2c7JQpC6/V
 eX5x7vuW3JuJmRPSNP2FnAmjHKIhX1nXVPUm3errwoIoZlk9JfQSAMYCj84Dx9apJ7mw
 Yuu23fAxZ1xvAg5Az0cqXrG0iy4njOVxyYIubBTeetyQ9T1FcBLXEDEnwy4biEWoNQuW
 GUxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=It7XPTxGJIt1zpo5VAjDRNzS4zZN4oOoDLzgExgJZ5g=;
 fh=5xmop6/JUtrXbp4VpMQbGgS0CMc2aVIDvaYA7TqNm2Q=;
 b=bAi8oqlDYOlgwyW4WvotXk+vpfxQWRCHQMPP1bgQo8Qvo3AP7YpfrhikOdlCFT9T4i
 lgRWgOT91iDeLVRcx55OYm+aCSX5WTlcQs2V4NYFpZ9rJqGvtXaH4PAmH45SUJr9kA0C
 7JwJpmqUrn+Y9ubfHC8NKg/F1KoxvkrwWi/lsEpIPKb/wgM0JosFV/WO8l94VWX2TZ0D
 E4sliFaVwaoZ7HAlDuXIDd7iKXoDDYSuPPHuCt0wHdQ8bMuQUEL4cb+twUIkdELWjikH
 qPY0+07PfvblOFiNMRIS9IryuoycJTCvo8JvXnaVNtKmwRwbg9bYIoMZvwqkmyTAwimH
 kFLQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775508863; x=1776113663; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=It7XPTxGJIt1zpo5VAjDRNzS4zZN4oOoDLzgExgJZ5g=;
 b=YEd5pwEUemJXvxFLEA+v2QQYlzpQFKNZlKftN9nGhmMVADSgzWEP9is3+ruWuiT2R4
 pfAlyEFgYH9wdD5JI3wqPY9arS9BZtnBdNb2FAbskqwr1/iPJIw4b6XdtbdtrK8FW8eM
 4It3TcYOW0uUP9cuPPaonBTvSEoKwko4fA53/ii+79iinV+tCTqqNEDfErgRe/oYleUU
 9HZPmGXGibHF2AagshgKIjq+Uv7L+ttrwMx1IM/JeBrxsmOr9zlKDdvt4Cgf9FaiLVgi
 toAK8sNBA1Qwwxfm3BCR7uV68Rcyqc+rIxPEy8MfZ58alY3T77DZhN66rRGCNPJwfLh7
 pcDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775508863; x=1776113663;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=It7XPTxGJIt1zpo5VAjDRNzS4zZN4oOoDLzgExgJZ5g=;
 b=QeDJNWzdzd8uufJNj5n0XeevSsyzk4c1LgbhhWZLJyqQ+/Baz6LN6UR/k6zbQOdSJf
 SCdhYRgV96x264v+WABh22iMlr6i6d7kM7NENf1W4X7vACh0mIbu7aBBhgPwRBsF8ph/
 zXBzIE1F22K75rURVs8LHxfKligX70IV1Ad/KlLV7rS/kyoCYapl/evgpF8xAF896WX0
 Jd1ONkGiernRz7yeDxv+/XLJT2fkogTl5zawzzv6EPCN5DkUt8/9uEZ+7DNry4y+aIoz
 LEaWuySE/Exk3E6MEew98NXwvvr3ZB8fnE/SFFdFx+tPtk92LxLVIpgCZODBpINHGHQL
 IEHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVoamHbVPiq3kBnFAmBvgumNtJDCM0yJLqkspw6dtGJg7Wp5RZeBq1X5dvra2gkPzOpAVRfwvxzBons@nongnu.org
X-Gm-Message-State: AOJu0Yyh+bsd0x2WZYKTPeAiR7jghtGQbQrpsluAVDfN3rpHpAsXMJFk
 14f4L9PhnQZz3UQUlQt/Z05YQ0U0MHWlIXKHJOVdIHHaX927gKi0OEbs/v8nnJs20j+TOmHcDuv
 toC7m7GJOIjJK8rddcY1EdxSaiuaAo68=
X-Gm-Gg: AeBDietD5BeMKAhUerwE6UBEYRymwCBsJrLP/RnU+W5Pm9P3pFxuyFJ8Q0p73g3kl/8
 gtiKFh5lPkmflBxtw1hXNJG5DNEKgItGADkIgR3LD06jYMzKWnwHmxWc9ZgsJf3nLrboDxZPuFk
 lS6s/jGoofByhcQbPIorAKOUSLhBq6V4P4lACAec0zeJ02GlBrJZApwvssBFejXu13SKyyG+9Br
 hfkgQsfUqAmKtcwCp9J3UAVY324xeGMl+/zgbY0cJ+CmvUa4VlMheQAvkV3omvWBg2801QPGMui
 eatFB33986DDjrbiy9pfcMeC0EbXcd1DHxz0kSs=
X-Received: by 2002:a05:6a00:4b07:b0:82a:7931:d3dd with SMTP id
 d2e1a72fcca58-82d0032c0fcmr14207919b3a.22.1775508862786; Mon, 06 Apr 2026
 13:54:22 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1775122853.git.matheus.bernardino@oss.qualcomm.com>
 <453a9e248b8c2af50cf89912121605db07792dd5.1775122853.git.matheus.bernardino@oss.qualcomm.com>
 <051a28b0-a67e-4da4-a13f-ed88a69bd629@linaro.org>
 <CABrGZ+EggQ7+m3aDTx_b+wRRcwW5LzWbM=EBrW1q3Q6kOGxDUQ@mail.gmail.com>
In-Reply-To: <CABrGZ+EggQ7+m3aDTx_b+wRRcwW5LzWbM=EBrW1q3Q6kOGxDUQ@mail.gmail.com>
From: Taylor Simpson <ltaylorsimpson@gmail.com>
Date: Mon, 6 Apr 2026 14:54:11 -0600
X-Gm-Features: AQROBzBRgumF6IQjOheHQ3bv140Cgx3b8ytSyMc6HwnoeJc01T3Ywb9-NySI3Q4
Message-ID: <CAATN3Noj4Ua8fSWJ9MCrLF-R-KHjNZOWHj0rFgAR9N+nQf_Rig@mail.gmail.com>
Subject: Re: [PATCH v2 06/16] target/hexagon: add v68 HVX IEEE float
 arithmetic insns
To: Matheus Bernardino <matheus.bernardino@oss.qualcomm.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 ale@rev.ng, 
 anjo@rev.ng, brian.cain@oss.qualcomm.com, marco.liebel@oss.qualcomm.com, 
 philmd@linaro.org, quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Content-Type: multipart/alternative; boundary="0000000000000fe1b4064ed0df6f"
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-pf1-x433.google.com
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

--0000000000000fe1b4064ed0df6f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 6, 2026 at 12:02=E2=80=AFPM Matheus Bernardino <
matheus.bernardino@oss.qualcomm.com> wrote:

> On Fri, Apr 3, 2026 at 6:47=E2=80=AFPM Richard Henderson
> <richard.henderson@linaro.org> wrote:
> >
> > On 4/2/26 20:47, Matheus Tavares Bernardino wrote:
> > > +++ b/target/hexagon/mmvec/hvx_ieee_fp.c
> > > @@ -0,0 +1,69 @@
> > > +/*
> > > + *  Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiarie=
s.
> > > + *
> > > + *  SPDX-License-Identifier: GPL-2.0-or-later
> > > + */
> > > +
> > > +#include "qemu/osdep.h"
> > > +#include "hvx_ieee_fp.h"
> > > +
> > > +#define DEF_FP_INSN_2(name, rt, a1t, a2t, op) \
> > > +    uint##rt##_t fp_##name(uint##a1t##_t a1, uint##a2t##_t a2, \
> > > +                           float_status *fp_status) { \
> > > +        float##a1t f1 =3D make_float##a1t(a1); \
> > > +        float##a2t f2 =3D make_float##a2t(a2); \
> > > +        return (op); \
> > > +    }
> > > +
> > > +#define DEF_FP_INSN_3(name, rt, a1t, a2t, a3t, op) \
> > > +    uint##rt##_t fp_##name(uint##a1t##_t a1, uint##a2t##_t a2, \
> > > +                           uint##a3t##_t a3, float_status *fp_status=
)
> { \
> > > +        float##a1t f1 =3D make_float##a1t(a1); \
> > > +        float##a2t f2 =3D make_float##a2t(a2); \
> > > +        float##a3t f3 =3D make_float##a3t(a3); \
> > > +        return (op); \
> > > +    }
> >
> > Why are you using uint32_t and make_float instead of declaring with
> float32 in the first
> > place?
>
> The helper functions receive raw bit values from the HVX vector
> registers via the generated TCG code. The idea behind using
> uint32_t/uint16_t in the signatures is to make the raw-bits interface
> explicit, since make_float* is essentially a no-op cast. But I can
> change to float32 if that's preferable.
>

That will be better.  Go all the way back to the sf/hf/bf fields in
MMVector and change the types to float32/float16/bfloat16.  The code will
be much cleaner.

Taylor

--0000000000000fe1b4064ed0df6f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Apr 6, =
2026 at 12:02=E2=80=AFPM Matheus Bernardino &lt;<a href=3D"mailto:matheus.b=
ernardino@oss.qualcomm.com">matheus.bernardino@oss.qualcomm.com</a>&gt; wro=
te:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Fri, Apr =
3, 2026 at 6:47=E2=80=AFPM Richard Henderson<br>
&lt;<a href=3D"mailto:richard.henderson@linaro.org" target=3D"_blank">richa=
rd.henderson@linaro.org</a>&gt; wrote:<br>
&gt;<br>
&gt; On 4/2/26 20:47, Matheus Tavares Bernardino wrote:<br>
&gt; &gt; +++ b/target/hexagon/mmvec/hvx_ieee_fp.c<br>
&gt; &gt; @@ -0,0 +1,69 @@<br>
&gt; &gt; +/*<br>
&gt; &gt; + *=C2=A0 Copyright (c) Qualcomm Technologies, Inc. and/or its su=
bsidiaries.<br>
&gt; &gt; + *<br>
&gt; &gt; + *=C2=A0 SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt; &gt; + */<br>
&gt; &gt; +<br>
&gt; &gt; +#include &quot;qemu/osdep.h&quot;<br>
&gt; &gt; +#include &quot;hvx_ieee_fp.h&quot;<br>
&gt; &gt; +<br>
&gt; &gt; +#define DEF_FP_INSN_2(name, rt, a1t, a2t, op) \<br>
&gt; &gt; +=C2=A0 =C2=A0 uint##rt##_t fp_##name(uint##a1t##_t a1, uint##a2t=
##_t a2, \<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0float_status *fp_status) { \<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 float##a1t f1 =3D make_float##a1t(a1=
); \<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 float##a2t f2 =3D make_float##a2t(a2=
); \<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return (op); \<br>
&gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; +<br>
&gt; &gt; +#define DEF_FP_INSN_3(name, rt, a1t, a2t, a3t, op) \<br>
&gt; &gt; +=C2=A0 =C2=A0 uint##rt##_t fp_##name(uint##a1t##_t a1, uint##a2t=
##_t a2, \<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint##a3t##_t a3, float_status *fp_status=
) { \<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 float##a1t f1 =3D make_float##a1t(a1=
); \<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 float##a2t f2 =3D make_float##a2t(a2=
); \<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 float##a3t f3 =3D make_float##a3t(a3=
); \<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return (op); \<br>
&gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt;<br>
&gt; Why are you using uint32_t and make_float instead of declaring with fl=
oat32 in the first<br>
&gt; place?<br>
<br>
The helper functions receive raw bit values from the HVX vector<br>
registers via the generated TCG code. The idea behind using<br>
uint32_t/uint16_t in the signatures is to make the raw-bits interface<br>
explicit, since make_float* is essentially a no-op cast. But I can<br>
change to float32 if that&#39;s preferable.<br></blockquote><div><br></div>=
<div>That will be better.=C2=A0 Go all the way back to the sf/hf/bf fields =
in MMVector and change the types to float32/float16/bfloat16.=C2=A0 The cod=
e will be much cleaner.=C2=A0</div><div><br></div><div>Taylor</div><div><br=
></div></div></div>

--0000000000000fe1b4064ed0df6f--

