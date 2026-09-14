Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4491AC88E73
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 21:16:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6E2U-0001AS-Mr; Mon, 14 Sep 2026 17:16:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1x6E2O-0001AD-Ut
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 17:16:30 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1x6E2N-0002TD-4z
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 17:16:28 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 d9443c01a7336-2d747f01363so18250355ad.2
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 14:16:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789420585; cv=none;
 d=google.com; s=arc-20260327;
 b=HuQmijESsQeXQwKtTfpg5/MeTAyBRXt6ONFFOYg/79WhJaT03fzsEvExcATRqvq7gc
 exdEQ543fkFITdm2Sl/Kvtw4LYKcqLIcdUVf13HTyh90l0I0QamtGO+TURaNmQ9D0Maz
 lVYVhu7Uri9xwBtFB3128xK6rlGfvB7tvOTiUxij8WgxkXSfuKE4p1lgeywcTZY7BoxQ
 NL9qr7S3IXDdMpqMhYqd7qS/xBbb5vldlMsm2cW/GD0OgPpEWIcARud2JXLadwAlAdle
 k6RAUaFpwHLJwHIVFDkv21iv8GPAAyVBA2Iy8MKuI40kvgipDEhnYDwku4tI8LHMS4v4
 kbAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=elxhjnpz4yXnh5StbOwK1KG7AOdHq0VjbgMAW4/yHFI=;
 fh=1Jp0KdhqtyfxbCjclbABrQtBrJrCg/j6MU64w81r97g=;
 b=n1zzr0YhQGvak2iG2Hireolk1le1k0eweC0L3N0H/SMisNEuFD2IQKf1fo95TjgqGa
 LowR5n8DI0fs8J1DxNKwby7BnnonPLT0KEOD1aS0V5kz5p2u9QPKmxIWGv9havEp3vac
 OUy1bzk0gMYn7rgxvCXClwH/icPdANZI0KkvLmLBdq3qQjsp61lZvl83JSucDWl6eSI6
 VukcZisoFe5Oy4fTxfPXESa+W5KFSXWId5mLF2riC2c+XyDFYmRtbRbTP9BpdUN26p1m
 gzk4ic19XgCaxUM2hQ6sGZJjfqx4+CPIagGQ7qg4gRCs4T4zYAplddBEHFQlYK2aMa4o
 fNoQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789420585; x=1790025385; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=elxhjnpz4yXnh5StbOwK1KG7AOdHq0VjbgMAW4/yHFI=;
 b=bdU5seZ4NMS6Nq6VD9m6p3MUBhYIq9MDYij44q/vDgaaFCW7KYSgcKce/ML3RRqc71
 MOA5vDqDg6SgDH4IzdUBmt853RF9kQsMiZ5+ew0V3acKZ06EZNjAUHxNcLSaGSnixdkk
 8FA333oluEWdsIQhkyaB1T5idYu52rmn29zYfXNjRwpxNPEmT5e/gpkE3APdSptOOTRu
 ulB5qsFZmANH8THKPuYWHp+gHnWmODZV82Ca3q6YhZhgKiPs1uosDXwBpfzloy+aOzkk
 nefu0uFWdot8aBtztN9p4r/Ie4sCFJxS0/rvQsRwPm67V9fipNkOY6lhOQUkhh9u5jVC
 nlPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789420585; x=1790025385;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=elxhjnpz4yXnh5StbOwK1KG7AOdHq0VjbgMAW4/yHFI=;
 b=yUDuDhXsA/KkO7wlGzqZoDh2HcdS9h/RAWaZKK3E8vewKCNlgzDn/3fJvcoyJ41qUs
 2RfyV/2wnle27iV4wEHqfu40RKhJ9Z5RfviZnkbUPBmuwllEplW8DFWtzUEpdWSb3/fL
 dL3CwZtoM+cthZNYKsW6ANnG+dtXNHacnOmKxs7wNb4zjX4O5Bq5TBpUnyqU4jo5abTP
 iACMKW+sSHGzip7991tOT2FbQvdFsBB6Pr5j+G99xWvvQReO6ETiCO3BSP79aRbzl/Dh
 /SwtB73zJUrYDYl0hukxfUAOgzLdF5WZEtl8FtsfT4/uuFEET66iZPjUbFioQsdQyzbz
 AUhQ==
X-Gm-Message-State: AFuF++k9I6RxAZZMEW3S28rAX0vOIiBwAEF9qNIWXSq6dqWswvceCWNX
 EUTg3VYOx7cZw6g7mDi2J7NJol2JzkUa72pw6mS6fF/dIbRbzYEMNaHLjhO2gY8qFi/WJ3DbyY7
 W90JBhkVL0vSw9YtTdzGm9On53w4kYbA=
X-Gm-Gg: AYBFou2DUxQDbTv2vzWaJXQnQ2m3DuHTWCFTI1WAS/n5soGDBaEPoGsM3ES/v4vpeqa
 9ezscQXKbK2AfX+Dz0Wh5dBZ2zBIbsE0bEh/dGQIgSAMkRs7NBQdPQ0yzoEjzXWXjfxmbFe+0ey
 e9DAA1HfhTxeHjmZMmOhsH5e+HSef2n8FiBih/fq1zTHeLV2gqQEFWGHRKUaRmIXPg9NJWiTJEq
 rwMnowNP6MMbxCagAgms6qsQEZkZ9e9O0qxrvg6eciV/GrokJ5+0qm8iJ3+Qkeh31aJkVVLBMp8
 rb30HIZVVYRwamVXfSGPjoqPH5KRgOeu36GNNSm2+2GHtH8UIhkHfpK1CxGbBGityJijnKVkGdc
 LS/EuJ5iheDY=
X-Received: by 2002:a17:902:e54b:b0:2cc:6018:f030 with SMTP id
 d9443c01a7336-2dd6c6e9828mr81663365ad.14.1789420585044; Mon, 14 Sep 2026
 14:16:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260911220825.143115-1-ltaylorsimpson@gmail.com>
 <20260911220825.143115-6-ltaylorsimpson@gmail.com>
 <CAJ+KCYPhm7+Zb613g41pL2NiyP3e=63NjGsWnyf8MkKkeZoW3A@mail.gmail.com>
In-Reply-To: <CAJ+KCYPhm7+Zb613g41pL2NiyP3e=63NjGsWnyf8MkKkeZoW3A@mail.gmail.com>
From: Taylor Simpson <ltaylorsimpson@gmail.com>
Date: Mon, 14 Sep 2026 15:16:13 -0600
X-Gm-Features: AcwNN1ULPxCWbiS_LejQsfCXP-j64DalwXjL1HJQblZ_AZdd_ZgWRHmLF3kRx9o
Message-ID: <CAATN3NprNYrQWdn21H4LnyQE88FxMxWLuTKgKgfxtALZ2nsueA@mail.gmail.com>
Subject: Re: [PATCH v2 05/10] Hexagon (tests/tcg/hexagon) Add tests for vreg
 multiple writes
To: Marco Liebel <marco.liebel@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, brian.cain@oss.qualcomm.com, 
 matheus.bernardino@oss.qualcomm.com, sid.manning@oss.qualcomm.com, 
 richard.henderson@linaro.org, philmd@oss.qualcomm.com, ale@rev.ng, 
 anjo@rev.ng
Content-Type: multipart/alternative; boundary="0000000000005350d6065b77f2c7"
Received-SPF: pass client-ip=2607:f8b0:4864:39::10;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-pj2-x10.google.com
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

--0000000000005350d6065b77f2c7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 1:02=E2=80=AFPM Marco Liebel <marco.liebel@oss.qual=
comm.com>
wrote:

> On Fri, Sep 11, 2026 at 5:08=E2=80=AFPM Taylor Simpson <ltaylorsimpson@gm=
ail.com>
> wrote:
> >
> > Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> > ---
> >  tests/tcg/hexagon/multiple-writes.c | 46 +++++++++++++++++++++++++++++
> >  tests/tcg/hexagon/meson.build       |  2 +-
> >  2 files changed, 47 insertions(+), 1 deletion(-)
> >
> > diff --git a/tests/tcg/hexagon/multiple-writes.c
> b/tests/tcg/hexagon/multiple-writes.c
> > index 4305903547 <(430)%20590-3547>..b93f2ab32e 100644
> > --- a/tests/tcg/hexagon/multiple-writes.c
> > +++ b/tests/tcg/hexagon/multiple-writes.c
> > @@ -199,6 +199,49 @@ static int test_post_increment3(void)
> >      return sig;
> >  }
> >
> > +static int test_vreg_legal_predicated(void)
> > +{
> > +    int sig;
> > +
> > +    asm volatile(
> > +        "r0 =3D #0\n"
> > +        "r1 =3D ##1f\n"
> > +        "memw(%1) =3D r1\n"
> > +        "r2 =3D #7\n"
> > +        "r3 =3D #13\n"
> > +        "p0 =3D cmp.eq(r2, r3)\n"
> > +        "{\n"
> > +        "    if (p0) v0 =3D v1\n"
> > +        "    if (!p0) v0 =3D v2\n"
> > +        "}\n"
> > +        "1:\n"
> > +        "%0 =3D #23\n"
> > +        : "=3Dr"(sig)
> > +        : "r"(&resume_pc)
> > +        : "r0", "r1", "r2", "r3", "p0", "v0", "v1", "memory");
> > +
> > +    return sig;
> > +}
> > +
> > +static int test_vreg_illegal(void)
> > +{
> > +    int sig;
> > +
> > +    asm volatile(
> > +        "r0 =3D #0\n"
> > +        "r1 =3D ##1f\n"
> > +        "memw(%1) =3D r1\n"
> > +        ".word 0x1e0361e0    /* { v0 =3D v1 */\n"
> > +        ".word 0x1e03e2e0    /*   v0 =3D v2  } */\n"
> > +        "1:\n"
> > +        "%0 =3D r0\n"
> > +        : "=3Dr"(sig)
> > +        : "r"(&resume_pc)
> > +        : "r0", "r1", "memory");
> > +
> > +    return sig;
> > +}
> > +
>
> Would it be useful to add a mixed predicated/unconditional test as well?
>
> Such as:
> if (p0) v0 =3D v1
> v0 =3D v2
>

Yes, will do.

Taylor

--0000000000005350d6065b77f2c7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Sep 14,=
 2026 at 1:02=E2=80=AFPM Marco Liebel &lt;<a href=3D"mailto:marco.liebel@os=
s.qualcomm.com">marco.liebel@oss.qualcomm.com</a>&gt; wrote:<br></div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">On Fri, Sep 11, 2026 at 5:08=
=E2=80=AFPM Taylor Simpson &lt;<a href=3D"mailto:ltaylorsimpson@gmail.com" =
target=3D"_blank">ltaylorsimpson@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Signed-off-by: Taylor Simpson &lt;<a href=3D"mailto:ltaylorsimpson@gma=
il.com" target=3D"_blank">ltaylorsimpson@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 tests/tcg/hexagon/multiple-writes.c | 46 +++++++++++++++++++++++=
++++++<br>
&gt;=C2=A0 tests/tcg/hexagon/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =
2 +-<br>
&gt;=C2=A0 2 files changed, 47 insertions(+), 1 deletion(-)<br>
&gt;<br>
&gt; diff --git a/tests/tcg/hexagon/multiple-writes.c b/tests/tcg/hexagon/m=
ultiple-writes.c<br>
&gt; index <a href=3D"tel:(430)%20590-3547" value=3D"+14305903547" target=
=3D"_blank">4305903547</a>..b93f2ab32e 100644<br>
&gt; --- a/tests/tcg/hexagon/multiple-writes.c<br>
&gt; +++ b/tests/tcg/hexagon/multiple-writes.c<br>
&gt; @@ -199,6 +199,49 @@ static int test_post_increment3(void)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 return sig;<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt; +static int test_vreg_legal_predicated(void)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 int sig;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 asm volatile(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;r0 =3D #0\n&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;r1 =3D ##1f\n&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;memw(%1) =3D r1\n&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;r2 =3D #7\n&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;r3 =3D #13\n&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;p0 =3D cmp.eq(r2, r3)\n&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;{\n&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;=C2=A0 =C2=A0 if (p0) v0 =3D v1\n&q=
uot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;=C2=A0 =C2=A0 if (!p0) v0 =3D v2\n&=
quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;}\n&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;1:\n&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;%0 =3D #23\n&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 : &quot;=3Dr&quot;(sig)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 : &quot;r&quot;(&amp;resume_pc)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 : &quot;r0&quot;, &quot;r1&quot;, &quot;r=
2&quot;, &quot;r3&quot;, &quot;p0&quot;, &quot;v0&quot;, &quot;v1&quot;, &q=
uot;memory&quot;);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return sig;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int test_vreg_illegal(void)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 int sig;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 asm volatile(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;r0 =3D #0\n&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;r1 =3D ##1f\n&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;memw(%1) =3D r1\n&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;.word 0x1e0361e0=C2=A0 =C2=A0 /* { =
v0 =3D v1 */\n&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;.word 0x1e03e2e0=C2=A0 =C2=A0 /*=C2=
=A0 =C2=A0v0 =3D v2=C2=A0 } */\n&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;1:\n&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;%0 =3D r0\n&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 : &quot;=3Dr&quot;(sig)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 : &quot;r&quot;(&amp;resume_pc)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 : &quot;r0&quot;, &quot;r1&quot;, &quot;m=
emory&quot;);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return sig;<br>
&gt; +}<br>
&gt; +<br>
<br>
Would it be useful to add a mixed predicated/unconditional test as well?<br=
>
<br>
Such as:<br>
if (p0) v0 =3D v1<br>
v0 =3D v2<br></blockquote><div><br></div><div>Yes, will do.</div><div><br><=
/div><div>Taylor</div><div>=C2=A0</div></div></div>

--0000000000005350d6065b77f2c7--

