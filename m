Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F07CBC3DA64
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 23:19:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZIaP-0001Dl-W8; Wed, 31 Jul 2024 19:18:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1sZIaO-0001DE-4W
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 19:18:24 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1sZIaL-0000V2-Pj
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 19:18:23 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2cfdafdb914so960662a91.2
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 16:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1722467900; x=1723072700;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XZvp4NEoHp+8Af1sqo4lSfk2q8TGuS6H3VFLlsPLY0Y=;
 b=isgSX7A2YRfFfh0uXSTIm5/b0LjnT5Veq52+4hwDkIjvyuhjih56UvMoK26BNHkobQ
 WYoMOPBtZo2afY6EM/IwJuOrJWAf1JUlzwYPXuhmAMEzEm9z4vjfV8PLpuKx4g3Ktmkt
 aTR54/S/JVUL+zG+zcI0AB3gFpWtlf1NIhMzHACZUkwj6bZ+jR/ujw/o+pQQEIock+bq
 DZWS1UI9dgSaXFz9ZBrE7Zk8n9mHpnoBXerYAhGf0mowJrPSCsNa8JfoMsyNyczXalmB
 GZaL2Il+cOfEvDXxkybbEmr2vLJ6YUj+Ha7e5WGjXteKMNlUWBeHEhnj2aNtAPVT7tDg
 GvQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722467900; x=1723072700;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XZvp4NEoHp+8Af1sqo4lSfk2q8TGuS6H3VFLlsPLY0Y=;
 b=c/hTbIJLZNZg0888hk43APrHsQJ/7Fp8OrXBrGz50Nb99Dg7Qfj9N7POK/o/11Oc6j
 lWxNFB7fFGYm5untA5Jm0bgk7SZVktMvK/X0M5T4uS+Xm6S5UYizLwCIE4ApWvqRjdXh
 3ljekKLIlgiRTf7WZc+HiUzk0KzGQJxjrwVI3z+DwPYCIjYwWvXM8gEcsE4eo0YxstDG
 Qz1NLeoVoG9DPtDfFqpGnb1d3uKgJ2xzy3busDmWeKh28iwuCSdvY84HhMo5xWbvl0r6
 MSgUt71rtPJmuWYCvw7pd2ZuS1OBD64muKaqtNrV4nRCVjJ+wyiyrIe004Vs5nba1TFH
 byTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnsQezndL/E0MEoTugS0QKpNpEQyf1pvrJY7vE1l+TAenijHcR1Cv0rAkWogFyFKUhl3l6TFcPDRX4@nongnu.org
X-Gm-Message-State: AOJu0YzSERFMPHPG6i+geGicp0kVB0y2/Pr+v1gU2jXAYfl0XnjxXpb/
 sG3DECX+5Y7IVHlUFrG4XopPZh5VliPgfu4BFfQk80a/mlzcRkUTg2tB7wtn5g9md7RGSyotN4w
 fFLdD8QDpXKP+8UJgq4NsSPr72Y1qsdISoqfGzw==
X-Google-Smtp-Source: AGHT+IEmekiRCIiOm4g0W8NEJ0h8B//z/OpeK/ZldPSF6SOtxAX3sBSrrfISxaIO0ogGUfgbsgzuwhDzvjq6QzTMQzU=
X-Received: by 2002:a17:90b:4a07:b0:2c8:65cf:e820 with SMTP id
 98e67ed59e1d1-2cfe7751d73mr986348a91.2.1722467899739; Wed, 31 Jul 2024
 16:18:19 -0700 (PDT)
MIME-Version: 1.0
References: <20240731144532.5997-1-iii@linux.ibm.com>
 <CANCZdfpw7iDr4fBmsuukA5aVzcWBgCX09DVngg1RYHtv832zQQ@mail.gmail.com>
 <248e99db-61ea-4996-a3fa-efc15824451b@linaro.org>
In-Reply-To: <248e99db-61ea-4996-a3fa-efc15824451b@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Wed, 31 Jul 2024 17:18:08 -0600
Message-ID: <CANCZdfrDu7p4wrBHOB0-R0fi=GomyH=NP0sMnE9vkq0Q_39Rag@mail.gmail.com>
Subject: Re: [PATCH] bsd-user/main: Allow setting tb-size
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, Kyle Evans <kevans@freebsd.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000004d3003061e934ff6"
Received-SPF: none client-ip=2607:f8b0:4864:20::102e;
 envelope-from=wlosh@bsdimp.com; helo=mail-pj1-x102e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

--0000000000004d3003061e934ff6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 3:42=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philmd=
@linaro.org>
wrote:

> On 31/7/24 23:21, Warner Losh wrote:
> > On Wed, Jul 31, 2024 at 8:45=E2=80=AFAM Ilya Leoshkevich <iii@linux.ibm=
.com
> > <mailto:iii@linux.ibm.com>> wrote:
> >
> >     While qemu-system can set tb-size using -accel tcg,tb-size=3Dn, the=
re
> >     is no similar knob for qemu-bsd-user. Add one in a way similar to h=
ow
> >     one-insn-per-tb is already handled.
> >
> >
> > Cool! Are you using bsd-user and need this for some reason? Or is this
> > purely theoretical? Is there a larger context I can read about somewher=
e?
>
> Trying to keep user interface parity between linux/bsd.
>
> Ideally this duplication should be unified in common-user/.
>

I'd love that.

Anyway, both of these patches queued to my branch


> > I'll merge it either way (so none of the above is a criticism, I'm
> genuinely
> > curious) , but I don't get too many bsd-user fixes and this one is
> unusual.
> >
> >     Suggested-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org
> >     <mailto:philmd@linaro.org>>
> >     Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com
> >     <mailto:iii@linux.ibm.com>>
> >     ---
> >       bsd-user/main.c | 9 +++++++++
> >       1 file changed, 9 insertions(+)
>
>

--0000000000004d3003061e934ff6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jul 31, 2024 at 3:42=E2=80=AF=
PM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linaro.org">phi=
lmd@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">On 31/7/24 23:21, Warner Losh wrote:<br>
&gt; On Wed, Jul 31, 2024 at 8:45=E2=80=AFAM Ilya Leoshkevich &lt;<a href=
=3D"mailto:iii@linux.ibm.com" target=3D"_blank">iii@linux.ibm.com</a> <br>
&gt; &lt;mailto:<a href=3D"mailto:iii@linux.ibm.com" target=3D"_blank">iii@=
linux.ibm.com</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0While qemu-system can set tb-size using -accel tcg,=
tb-size=3Dn, there<br>
&gt;=C2=A0 =C2=A0 =C2=A0is no similar knob for qemu-bsd-user. Add one in a =
way similar to how<br>
&gt;=C2=A0 =C2=A0 =C2=A0one-insn-per-tb is already handled.<br>
&gt; <br>
&gt; <br>
&gt; Cool! Are you using bsd-user and need this for some reason? Or is this=
<br>
&gt; purely theoretical? Is there a larger context I can read about somewhe=
re?<br>
<br>
Trying to keep user interface parity between linux/bsd.<br>
<br>
Ideally this duplication should be unified in common-user/.<br></blockquote=
><div><br></div><div>I&#39;d love that.</div><div><br></div><div>Anyway, bo=
th of these patches queued to my branch</div><div>=C2=A0</div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">
&gt; I&#39;ll merge it either way (so none of the above is a criticism, I&#=
39;m genuinely<br>
&gt; curious) , but I don&#39;t get too many bsd-user fixes and this one is=
 unusual.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Suggested-by: Philippe Mathieu-Daud=C3=A9 &lt;<a hr=
ef=3D"mailto:philmd@linaro.org" target=3D"_blank">philmd@linaro.org</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:philmd@linaro.org" tar=
get=3D"_blank">philmd@linaro.org</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Signed-off-by: Ilya Leoshkevich &lt;<a href=3D"mail=
to:iii@linux.ibm.com" target=3D"_blank">iii@linux.ibm.com</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:iii@linux.ibm.com" tar=
get=3D"_blank">iii@linux.ibm.com</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0---<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user/main.c | 9 +++++++++<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A01 file changed, 9 insertions(+)<br>
<br>
</blockquote></div></div>

--0000000000004d3003061e934ff6--

