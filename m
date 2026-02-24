Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FF26F3C9AD
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 16:09:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuuyg-0006sA-Cu; Tue, 24 Feb 2026 11:09:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vuuyc-0006rd-UV
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 11:09:36 -0500
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vuuyb-0003YI-1w
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 11:09:34 -0500
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-354c67da885so4743774a91.3
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 08:09:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771949371; cv=none;
 d=google.com; s=arc-20240605;
 b=AsHgWgUa6IXGrU3WBJSYmHj4y3R/IaI1Vd2NeSHmTL8wQb58hPFvAvNAcG+yqF4tGN
 CYWdwfayT71AqToAR7gGNz/LzWs8z0JJ1fsQRLuSSI6DFeGRxSQslCFwf02Pi0rUM7lp
 QoL7ZCoOhr/T+FMCK022qey5FmkBoFw0Ch77yMYWNPRI1095l2WMOXlAcJ55t3o+PcjF
 GwrcARulZe034WhreUvTUsAK8M6fW2Fb47bkdSc1Uz+cCSnotD2s0oELmynerEgCEgBb
 8WFrQtPWmeieX37LFMyF4X+WqdmACmuO9b+9FfW4gPMVNQHCJkT6HA3RejnIP7G4fB6B
 286A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=motxCK9yDFPIaQvbXIzaV3OCNQZ3ww1nprdEgekDRwc=;
 fh=1CYvNObfo4jq90HtGYf42Wh+iAUT/qO8Wac6PonGhMA=;
 b=IserecDzOUjUAfOvozf/fo+6BhEtWkiw74dW0NUp2eti88SGUcpsRoaa4bJVGb1B61
 WOY7QxecPbGyWuuI+FeLHkR5Js3yD3FWrp7cHUVr3Dy8NBBNSSpPLs+7CP/3tds584oq
 GQiNV7Eo6FaXUPevs8PGGBxkbm/Ot3yvU9ZNg1+wOXVIiocwTUt92zPDSziusvKiIKEb
 GDiXKDBrNez74ceEMiz1Ee9NhYW82vH42Opz6WBvrNYkhPhZ5KC/1/qgO7odpG3V51Xz
 nd/adB2QM9UJ5xDIjzAAN9+celCe+cR8zdaoeDy2AMTMeQ4aK/TL70YwTGTL7MEX+DNk
 u1ng==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771949371; x=1772554171; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=motxCK9yDFPIaQvbXIzaV3OCNQZ3ww1nprdEgekDRwc=;
 b=CuD1pUirdWK+sq+3kVBn//Cszue4ndqCAMgBWYWhWsMkLS8wf1z7TNtXfMxWNZxlQL
 CbUQT35kb43abHSLwmbrnXanQV8RXlVp+6gBmYIYgOvDbfhXHqYIlQ9iDGIlZWcp0kHD
 IT9EZhu4yfaLdOFG6/k1lIS3uKE0UJdZCZFDZ0uxHlOJNwjXPWIeSvm1isCXT1aaJOB9
 bXOl/QQVau5Av5/ve/DCMIzribe8jO9meTUx+Npfh93wgoyPZeGVsLYByynrLeJHY9qj
 eipHUxQf0PmqSCSfGAATUkAA+aSdkk6krqFWvkfZzTxGPi0qfebVA+e2tDAbggnaE1ZV
 voSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771949371; x=1772554171;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=motxCK9yDFPIaQvbXIzaV3OCNQZ3ww1nprdEgekDRwc=;
 b=SVsIGqX5dnrd196IYMIXhtOV5hRHiJpL8ydXBIeDo/qM1OtB8d10kVtWb70XCM9cE0
 ZWiOT/dI68gaJqwPxSmKwpx+ig4e1FUeWMKj5JsnfuJex3S5zViO0N+9kR8wfNYVFETF
 OzPN6517cVFM80MklOAwnc2Xe/3KV+yMePzKGJ/g5hLyfHQV8Oi8511UBobs/olpzqMQ
 4wGxZ38cYpeGEC5PWletrCDhnxOVhA1COoDjuo0y/EmdTxHRMnSTEELXbiFS3YuTwMMQ
 nAytPvLtkNwgLSDGA/RDpRgennu1ABRkg1gXR2NT4ihiZFvc+PQhe0tEVKLNIO6NGELj
 QQkA==
X-Gm-Message-State: AOJu0YxdQOOHYYGon5GlpWlrAykdyNs+xAlW3qLMXGgqd/L4VliaiHyM
 TW6fV5zeSGSkTdaN174Sf3E1xs6baFPYeL2lVxnGVnxrtCkN37o/h6aMcj6CBxG5RTipNPeAuvo
 9/z9p57vTjeD4aZ/FiCXPWaQnfv3UCvI=
X-Gm-Gg: ATEYQzzKKZ6Lxdv3vEgRvMtfpEXEiSxYLl6L7zxEDPosnfrCqrYkcZJWH6w/DiaFuZz
 usCI8n4Dm/96Z6KrE+9TuMG4jh8djNTeglidG7UP+tYhqT350x8nHPttPNh9OZN+BkRLyEX9gA0
 +LPLMPUNghUOvsc/Vbsji7HgufEKEVWTySQ3kTHL7xPPtHnHdh4E/9CV23oX1s6/000QMR6Lyrf
 nqyq8e+L3ZjB2KMC3vAVH+faP26yTWbWlhCGnP6vPGne6u611BPNpel+jJK36dUT7QX0OgDh73C
 h9+DOSqYOycffMFe5CoHMpGYHP8h2LB1FqiVBq0c
X-Received: by 2002:a17:90a:e187:b0:34c:a29d:992f with SMTP id
 98e67ed59e1d1-358ae8d612fmr9952604a91.31.1771949371243; Tue, 24 Feb 2026
 08:09:31 -0800 (PST)
MIME-Version: 1.0
References: <20260217212245.95321-1-ltaylorsimpson@gmail.com>
 <20260217212245.95321-5-ltaylorsimpson@gmail.com>
 <aZ2mJz01cxh7PdLy@hive.localdomain>
In-Reply-To: <aZ2mJz01cxh7PdLy@hive.localdomain>
From: Taylor Simpson <ltaylorsimpson@gmail.com>
Date: Tue, 24 Feb 2026 09:09:20 -0700
X-Gm-Features: AaiRm50xB4UGt5yxJ1oMZtRi3fz0K5AugLslAgmDCucC9eU-ttSlL3_4H3CQUv8
Message-ID: <CAATN3Nqb5zN8r2twoDLp3eaBYXOmemO6dzhLTXuw+EVfm0jYxg@mail.gmail.com>
Subject: Re: [PATCH v3 4/8] Hexagon (target/hexagon) Introduce
 tag_rev_info.c.inc
To: Anton Johansson <anjo@rev.ng>
Cc: qemu-devel@nongnu.org, brian.cain@oss.qualcomm.com, 
 matheus.bernardino@oss.qualcomm.com, sid.manning@oss.qualcomm.com, 
 marco.liebel@oss.qualcomm.com, richard.henderson@linaro.org, 
 philmd@linaro.org, ale@rev.ng
Content-Type: multipart/alternative; boundary="000000000000d5432e064b941cce"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-pj1-x1036.google.com
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

--000000000000d5432e064b941cce
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 24, 2026 at 6:20=E2=80=AFAM Anton Johansson <anjo@rev.ng> wrote=
:

> On 17/02/26, Taylor Simpson wrote:
> > From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
> >
> > Table that records which CPU revision introduced or removed
> > for each opcode
> >
> > Co-authored-by: Brian Cain <brian.cain@oss.qualcomm.com>
> > Co-authored-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> > Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> > Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> > ---
> >  target/hexagon/tag_rev_info.c.inc | 613 ++++++++++++++++++++++++++++++
> >  1 file changed, 613 insertions(+)
> >  create mode 100644 target/hexagon/tag_rev_info.c.inc
> >
> > diff --git a/target/hexagon/tag_rev_info.c.inc
> b/target/hexagon/tag_rev_info.c.inc
> > new file mode 100644
> > index 0000000000..11c90f86ad
> > --- /dev/null
> > +++ b/target/hexagon/tag_rev_info.c.inc
> > @@ -0,0 +1,613 @@
> > +/*
> > + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> > + */
> > +
> > +#ifndef HEXAGON_TAG_ARCH_TABLE_H
> > +#define HEXAGON_TAG_ARCH_TABLE_H
> > +
> > +struct tag_rev_info { HexagonVersion introduced, removed; };
> > +
> > +static const struct tag_rev_info tag_rev_info[XX_LAST_OPCODE] =3D {
> > +    [A5_ACS] =3D { .introduced =3D HEX_VER_V55, .removed =3D HEX_VER_N=
ONE },
>
> ...
>
> > +
> > +    [A7_clip] =3D { .introduced =3D HEX_VER_V67, .removed =3D HEX_VER_=
NONE },
> > +    [A7_croundd_ri] =3D { .introduced =3D HEX_VER_V67, .removed =3D
> HEX_VER_NONE },
> > +    [A7_croundd_rr] =3D { .introduced =3D HEX_VER_V67, .removed =3D
> HEX_VER_NONE },
> > +    [A7_vclip] =3D { .introduced =3D HEX_VER_V67, .removed =3D HEX_VER=
_NONE },
> > +    [F2_dfmax] =3D { .introduced =3D HEX_VER_V67, .removed =3D HEX_VER=
_NONE },
> > +    [F2_dfmin] =3D { .introduced =3D HEX_VER_V67, .removed =3D HEX_VER=
_NONE },
> > +    [F2_dfmpyfix] =3D { .introduced =3D HEX_VER_V67, .removed =3D
> HEX_VER_NONE },
> > +    [F2_dfmpyhh] =3D { .introduced =3D HEX_VER_V67, .removed =3D HEX_V=
ER_NONE
> },
> > +    [F2_dfmpylh] =3D { .introduced =3D HEX_VER_V67, .removed =3D HEX_V=
ER_NONE
> },
> > +    [F2_dfmpyll] =3D { .introduced =3D HEX_VER_V67, .removed =3D HEX_V=
ER_NONE
> },
> > +    [J2_callrh] =3D { .introduced =3D 0x73, .removed =3D HEX_VER_NONE =
},
> > +    [J2_jumprh] =3D { .introduced =3D 0x73, .removed =3D HEX_VER_NONE =
},
>
> I assume you missed HEX_VER_V73 here
>

Good catch!  Fixed.


>
> With that fixed
>
> Reviewed-by: Anton Johansson <anjo@rev.ng>
>

--000000000000d5432e064b941cce
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Feb 24,=
 2026 at 6:20=E2=80=AFAM Anton Johansson &lt;<a href=3D"mailto:anjo@rev.ng"=
>anjo@rev.ng</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">On 17/02/26, Taylor Simpson wrote:<br>
&gt; From: Matheus Tavares Bernardino &lt;<a href=3D"mailto:matheus.bernard=
ino@oss.qualcomm.com" target=3D"_blank">matheus.bernardino@oss.qualcomm.com=
</a>&gt;<br>
&gt; <br>
&gt; Table that records which CPU revision introduced or removed<br>
&gt; for each opcode<br>
&gt; <br>
&gt; Co-authored-by: Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.qualco=
mm.com" target=3D"_blank">brian.cain@oss.qualcomm.com</a>&gt;<br>
&gt; Co-authored-by: Taylor Simpson &lt;<a href=3D"mailto:ltaylorsimpson@gm=
ail.com" target=3D"_blank">ltaylorsimpson@gmail.com</a>&gt;<br>
&gt; Signed-off-by: Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.qualcom=
m.com" target=3D"_blank">brian.cain@oss.qualcomm.com</a>&gt;<br>
&gt; Signed-off-by: Taylor Simpson &lt;<a href=3D"mailto:ltaylorsimpson@gma=
il.com" target=3D"_blank">ltaylorsimpson@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 target/hexagon/tag_rev_info.c.inc | 613 ++++++++++++++++++++++++=
++++++<br>
&gt;=C2=A0 1 file changed, 613 insertions(+)<br>
&gt;=C2=A0 create mode 100644 target/hexagon/tag_rev_info.c.inc<br>
&gt; <br>
&gt; diff --git a/target/hexagon/tag_rev_info.c.inc b/target/hexagon/tag_re=
v_info.c.inc<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..11c90f86ad<br>
&gt; --- /dev/null<br>
&gt; +++ b/target/hexagon/tag_rev_info.c.inc<br>
&gt; @@ -0,0 +1,613 @@<br>
&gt; +/*<br>
&gt; + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.=
<br>
&gt; + * SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt; + */<br>
&gt; +<br>
&gt; +#ifndef HEXAGON_TAG_ARCH_TABLE_H<br>
&gt; +#define HEXAGON_TAG_ARCH_TABLE_H<br>
&gt; +<br>
&gt; +struct tag_rev_info { HexagonVersion introduced, removed; };<br>
&gt; +<br>
&gt; +static const struct tag_rev_info tag_rev_info[XX_LAST_OPCODE] =3D {<b=
r>
&gt; +=C2=A0 =C2=A0 [A5_ACS] =3D { .introduced =3D HEX_VER_V55, .removed =
=3D HEX_VER_NONE },<br>
<br>
...<br>
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 [A7_clip] =3D { .introduced =3D HEX_VER_V67, .removed =
=3D HEX_VER_NONE },<br>
&gt; +=C2=A0 =C2=A0 [A7_croundd_ri] =3D { .introduced =3D HEX_VER_V67, .rem=
oved =3D HEX_VER_NONE },<br>
&gt; +=C2=A0 =C2=A0 [A7_croundd_rr] =3D { .introduced =3D HEX_VER_V67, .rem=
oved =3D HEX_VER_NONE },<br>
&gt; +=C2=A0 =C2=A0 [A7_vclip] =3D { .introduced =3D HEX_VER_V67, .removed =
=3D HEX_VER_NONE },<br>
&gt; +=C2=A0 =C2=A0 [F2_dfmax] =3D { .introduced =3D HEX_VER_V67, .removed =
=3D HEX_VER_NONE },<br>
&gt; +=C2=A0 =C2=A0 [F2_dfmin] =3D { .introduced =3D HEX_VER_V67, .removed =
=3D HEX_VER_NONE },<br>
&gt; +=C2=A0 =C2=A0 [F2_dfmpyfix] =3D { .introduced =3D HEX_VER_V67, .remov=
ed =3D HEX_VER_NONE },<br>
&gt; +=C2=A0 =C2=A0 [F2_dfmpyhh] =3D { .introduced =3D HEX_VER_V67, .remove=
d =3D HEX_VER_NONE },<br>
&gt; +=C2=A0 =C2=A0 [F2_dfmpylh] =3D { .introduced =3D HEX_VER_V67, .remove=
d =3D HEX_VER_NONE },<br>
&gt; +=C2=A0 =C2=A0 [F2_dfmpyll] =3D { .introduced =3D HEX_VER_V67, .remove=
d =3D HEX_VER_NONE },<br>
&gt; +=C2=A0 =C2=A0 [J2_callrh] =3D { .introduced =3D 0x73, .removed =3D HE=
X_VER_NONE },<br>
&gt; +=C2=A0 =C2=A0 [J2_jumprh] =3D { .introduced =3D 0x73, .removed =3D HE=
X_VER_NONE },<br>
<br>
I assume you missed HEX_VER_V73 here<br></blockquote><div><br></div><div>Go=
od catch!=C2=A0 Fixed.</div><div>=C2=A0</div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">
<br>
With that fixed <br>
<br>
Reviewed-by: Anton Johansson &lt;<a href=3D"mailto:anjo@rev.ng" target=3D"_=
blank">anjo@rev.ng</a>&gt;<br>
</blockquote></div></div>

--000000000000d5432e064b941cce--

