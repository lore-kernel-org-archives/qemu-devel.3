Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21287EEA853
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 00:14:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqgpI-0004tW-16; Thu, 12 Feb 2026 19:14:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vqgpG-0004tO-Mo
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 19:14:26 -0500
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vqgpF-0001wf-5n
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 19:14:26 -0500
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-354a18c48b5so308316a91.1
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 16:14:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770941663; cv=none;
 d=google.com; s=arc-20240605;
 b=eWpd8MDgn0OWpC83O3hPfYcPr8cS9RzQhJGx4E7+CguBFyuhrF0Dm6Of/sUQUx/JyB
 J93PiWTL+z9edZhDkf4NdUIVfGCHCz7TbiteG2hsCZXm+o6A51WFnKxShSYWKQFP/8D1
 vz56SiR/XbREQ5Vza2o+7El9ANvkoPy8kysDf6Xvi3GdZVG6l7q5wWcYp70AvCnnhscg
 moerxgYatUfaDJhbk4FtKXqWi7dGYNakj+MKtAu9jlgpGqtK2Q6aYLaIlMHbtN1HWXPo
 ASbaYxwL63ETCEa93iCioGAnizFpwTvsJjjXYxr1Q4mkNMLiFJ4qS+bq5+oZocfOv7+j
 h/tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=iHEueidKqqFKDAE5TPNC5mROpyAXuvgIUaghldWGZC4=;
 fh=+xTFvPcXpKGNIxGuDO2FBnnaNlKzlt6Je4MiFNde8Gk=;
 b=N/t/6iGHr3EDphlaxz4oLGMfw1rWclBSadvTL2ofesbM5s0lpGz6ZXaWv5wSBFeGYf
 oqWDuf5EhdV3+I4N858dSY4GxKYaGjvtL9zQSRrJ6wZ72zjSMR+vVxJAT4hNtcvFqh3o
 OQwPRrP08WFNK4j2OcSwYoWBi8Y53ABkr2Gq7sMzL+spnwUuvXhdpAkhDPzeyOiMCh9q
 vAoiUPpZuLwIZNhR1ggE6wVGu8b9KEQt/DHqsiKeILA70nTjgMnUxJHuEiaowr5JM3CY
 2PvBTH0Hg+VoCZFMdIr5IvIqT+f/+egEsH+dJDfrLLqmV9DMlCsWFXuQk0B6xsUspCF7
 c/mw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770941663; x=1771546463; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iHEueidKqqFKDAE5TPNC5mROpyAXuvgIUaghldWGZC4=;
 b=dmH2Ptq/6umcdO9UEvtC+5ZIXxy8NldmJtSiJENquxtv2bxcN9ejdUiyiO38ulKGS3
 k6YPl88CSMZcbhpimX1vbqlHe6PWgYW8n6IRB2EiA0VYAY8vm+6MuyBkj0bNv3yqCPVd
 eI+t5T0w/q5VnthNm5ueyJo21Lcl9nJ1vmq4b0kXhz7DANhN5hjzYiOxg2OpLAC0sg56
 kC0q8J+13iG9wMA6dCnd6Yf8OyZZdVZLV25ZAJvuLxKNRF5gzIVB+iJWGeDir9gmBQHm
 TkWR8sFCHtyIQu4F/0aa7PvViGVhFqc1EQ1xG12zLydpRbVldxFn4FsW8oUzZPZWXmwb
 3TQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770941663; x=1771546463;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iHEueidKqqFKDAE5TPNC5mROpyAXuvgIUaghldWGZC4=;
 b=kxV/cP3HNQUUiS7MtGMOfmiCcb1txt2ETf6+AlbKqxArz1nVLqvHsKhHgG1tC4FNcs
 EWCz8FyGpGgdhsJRRKbQUO/w9FYKxSEhtDfsMk1OHBbV/g99gZFVhI/xxTOpwduCX921
 Ge9sPtNlrXqZojVYNqsvNIJnpUyXOAAZtsTtXgkUqJL1ctw45SVUMEMkgMBDEVYhSbbL
 c1KyKs0/S4AMCh2xBaSoqmJbHiBJFuEZhBc7g542uWY8A/dmX/Aptyv3TwQju6wUXDK7
 tK/3Y5/u3E5VrCQVD/tz0Cob9rYn7h2YILlTJP76IR+ML/15Xull/ZzjZB+Kqi71RUKv
 tkjQ==
X-Gm-Message-State: AOJu0Yx/VhH5cCf4mVXkxJLTr346hHibfNorF4G7pUbGrib4P2omv6R6
 1AcyN23I1HuaE1+S3LN5/I1u12M0No0daNAnHwp5pMpZhXkXPwcFt9vaOFMqxqZsULdOvDnUw1Y
 ONnOgxLtT2M0DYcgK4vyod4L9MuxNPds=
X-Gm-Gg: AZuq6aIL5JNjC9KA9QJQv+KAW7FfPc7+g5PMFzi2TvwGnx69IHXOd960FesTXtmTVRx
 0zIlWqz+bH90M8sMehijd4hqf6NnYVUoC6x50+qU+H5X6IsMOis2y9GhIzsygsKQYtnXufaA/Lo
 iNoZrdEtGCX7JUOp5trt2zGEc23gRYJmdlm+XfF4G1QwkIbnCnXQqrhOQE2OR05vvYDcrSt3PF7
 yMranglYrE8yvhg4f0/UyayDaYnKZ93OomwK2+9DJQhlJuRp6/IYdo0tY8JrkWEAtYb10AY3X/U
 Y/KGZ9oBJmgO/F0oR2DaldgYwM0i3wlMKwhGHeQ=
X-Received: by 2002:a17:90b:5703:b0:343:6d82:9278 with SMTP id
 98e67ed59e1d1-356a7a8b5d9mr774795a91.30.1770941663328; Thu, 12 Feb 2026
 16:14:23 -0800 (PST)
MIME-Version: 1.0
References: <20260212033435.3598-1-ltaylorsimpson@gmail.com>
 <20260212033435.3598-5-ltaylorsimpson@gmail.com>
 <998e5fe3-9f13-416c-927f-f037eacbc0b7@linaro.org>
In-Reply-To: <998e5fe3-9f13-416c-927f-f037eacbc0b7@linaro.org>
From: Taylor Simpson <ltaylorsimpson@gmail.com>
Date: Thu, 12 Feb 2026 17:14:12 -0700
X-Gm-Features: AZwV_Qj6rK5KgEK4k05tm682Fw9VJsypNv3399H8jYQumXeb20kr4GFx3NyCWZE
Message-ID: <CAATN3NqWDWSj4nyi9w42bYTCvm3mnYcKKECqVsGH87gqF6d4XQ@mail.gmail.com>
Subject: Re: [PATCH 4/8] Hexagon (target/hexagon) Introduce tag_rev_info.c.inc
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, brian.cain@oss.qualcomm.com, 
 matheus.bernardino@oss.qualcomm.com, sid.manning@oss.qualcomm.com, 
 marco.liebel@oss.qualcomm.com, philmd@linaro.org, ale@rev.ng, anjo@rev.ng
Content-Type: multipart/alternative; boundary="000000000000c2bbe4064aa97c6c"
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

--000000000000c2bbe4064aa97c6c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 12, 2026 at 4:52=E2=80=AFPM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 2/12/26 13:34, Taylor Simpson wrote:
> > From: Matheus Tavares Bernardino<matheus.bernardino@oss.qualcomm.com>
> >
> > Table that records which CPU revision introduced or removed each opcode
> >
> > Co-authored-by: Brian Cain<brian.cain@oss.qualcomm.com>
> > Co-authored-by: Taylor Simpson<ltaylorsimpson@gmail.com>
> > Signed-off-by: Brian Cain<brian.cain@oss.qualcomm.com>
> > Signed-off-by: Taylor Simpson<ltaylorsimpson@gmail.com>
> > ---
> >   target/hexagon/tag_rev_info.c.inc | 61 ++++++++++++++++++++++++++++++=
+
> >   1 file changed, 61 insertions(+)
> >   create mode 100644 target/hexagon/tag_rev_info.c.inc
> >
> > diff --git a/target/hexagon/tag_rev_info.c.inc
> b/target/hexagon/tag_rev_info.c.inc
> > new file mode 100644
> > index 0000000000..ed7fb68aaf
> > --- /dev/null
> > +++ b/target/hexagon/tag_rev_info.c.inc
> > @@ -0,0 +1,61 @@
> > +/*
> > + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> > + */
> > +
> > +#ifndef HEXAGON_TAG_ARCH_TABLE_H
> > +#define HEXAGON_TAG_ARCH_TABLE_H
> > +
> > +struct tag_rev_info { int introduced, removed; };
> > +
> > +static const struct tag_rev_info tag_rev_info[XX_LAST_OPCODE] =3D {
> > +    [A7_clip] =3D { .introduced =3D 0x67, .removed =3D 0x0 },
> > +    [A7_croundd_ri] =3D { .introduced =3D 0x67, .removed =3D 0x0 },
> > +    [A7_croundd_rr] =3D { .introduced =3D 0x67, .removed =3D 0x0 },
>
> Any reason not to use enum HexagonVersion?
>
> r~
>

Good call.  I will change this.

Thanks,
Taylor

--000000000000c2bbe4064aa97c6c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Feb 12,=
 2026 at 4:52=E2=80=AFPM Richard Henderson &lt;<a href=3D"mailto:richard.he=
nderson@linaro.org">richard.henderson@linaro.org</a>&gt; wrote:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">On 2/12/26 13:34, Taylor Si=
mpson wrote:<br>
&gt; From: Matheus Tavares Bernardino&lt;<a href=3D"mailto:matheus.bernardi=
no@oss.qualcomm.com" target=3D"_blank">matheus.bernardino@oss.qualcomm.com<=
/a>&gt;<br>
&gt; <br>
&gt; Table that records which CPU revision introduced or removed each opcod=
e<br>
&gt; <br>
&gt; Co-authored-by: Brian Cain&lt;<a href=3D"mailto:brian.cain@oss.qualcom=
m.com" target=3D"_blank">brian.cain@oss.qualcomm.com</a>&gt;<br>
&gt; Co-authored-by: Taylor Simpson&lt;<a href=3D"mailto:ltaylorsimpson@gma=
il.com" target=3D"_blank">ltaylorsimpson@gmail.com</a>&gt;<br>
&gt; Signed-off-by: Brian Cain&lt;<a href=3D"mailto:brian.cain@oss.qualcomm=
.com" target=3D"_blank">brian.cain@oss.qualcomm.com</a>&gt;<br>
&gt; Signed-off-by: Taylor Simpson&lt;<a href=3D"mailto:ltaylorsimpson@gmai=
l.com" target=3D"_blank">ltaylorsimpson@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0target/hexagon/tag_rev_info.c.inc | 61 +++++++++++++++++++=
++++++++++++<br>
&gt;=C2=A0 =C2=A01 file changed, 61 insertions(+)<br>
&gt;=C2=A0 =C2=A0create mode 100644 target/hexagon/tag_rev_info.c.inc<br>
&gt; <br>
&gt; diff --git a/target/hexagon/tag_rev_info.c.inc b/target/hexagon/tag_re=
v_info.c.inc<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..ed7fb68aaf<br>
&gt; --- /dev/null<br>
&gt; +++ b/target/hexagon/tag_rev_info.c.inc<br>
&gt; @@ -0,0 +1,61 @@<br>
&gt; +/*<br>
&gt; + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.=
<br>
&gt; + * SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt; + */<br>
&gt; +<br>
&gt; +#ifndef HEXAGON_TAG_ARCH_TABLE_H<br>
&gt; +#define HEXAGON_TAG_ARCH_TABLE_H<br>
&gt; +<br>
&gt; +struct tag_rev_info { int introduced, removed; };<br>
&gt; +<br>
&gt; +static const struct tag_rev_info tag_rev_info[XX_LAST_OPCODE] =3D {<b=
r>
&gt; +=C2=A0 =C2=A0 [A7_clip] =3D { .introduced =3D 0x67, .removed =3D 0x0 =
},<br>
&gt; +=C2=A0 =C2=A0 [A7_croundd_ri] =3D { .introduced =3D 0x67, .removed =
=3D 0x0 },<br>
&gt; +=C2=A0 =C2=A0 [A7_croundd_rr] =3D { .introduced =3D 0x67, .removed =
=3D 0x0 },<br>
<br>
Any reason not to use enum HexagonVersion?<br>
<br>
r~<br></blockquote><div><br></div><div>Good call.=C2=A0 I will change this.=
</div><div><br></div><div>Thanks,</div><div>Taylor</div><div>=C2=A0</div></=
div></div>

--000000000000c2bbe4064aa97c6c--

