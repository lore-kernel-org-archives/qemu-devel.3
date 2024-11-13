Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A4FFD637A6
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 18:39:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBIGr-0002xv-Qq; Wed, 13 Nov 2024 13:39:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <randrianasulu@gmail.com>)
 id 1tBIGp-0002rO-3l
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 13:39:15 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <randrianasulu@gmail.com>)
 id 1tBIGn-0004AI-C0
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 13:39:14 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-21116b187c4so58690885ad.3
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2024 10:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731523151; x=1732127951; darn=nongnu.org;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=P0AqjmHnxjCtqHcQptKVy39KhylOCq1OHt0nxEWEUM8=;
 b=EALTc2M4op4rClAUEAOO4f1SBSf4i2y7M95VHt2lJ+O7jLDc3TbTCxvVyTId/RWC7O
 C/nB+vPlOFspy3eP582nkIWvOyL1oPbcEFxSMBkMWpiSe2DSFZTPSKu/AcGAz5kTZyjb
 ualvLtwWorOd2xVzw1O2JdoTDc1li8MgqkAyeed9OLh4jJ2mm73dbyXm6EfcCD8OZx9T
 mFHeLiVJ75l9bfDYVmPGmCTJytTuYwZHLUaqhhpfkT9TxVvG8QshRXY5wYmpp7mzMz/s
 m8JGyj9ERoxDIvEejyfxkSpWho0aVEpxLIExb48vfursrPVIAXvaPKxWEZ/CK9b6f+pK
 zzAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731523151; x=1732127951;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=P0AqjmHnxjCtqHcQptKVy39KhylOCq1OHt0nxEWEUM8=;
 b=I0popfA6rWtd19UNJRZ14ksff+xutJfk9cT0VMfhetKIzl+Cd0gd+LmM6gU4ldxt7l
 7a4rHPK0gmDfU0kuXmp3nJauMACv68RdI7ZBMqsEYZyCBOkl2xz+3wpZzwvVccczaKDd
 YWyNINmgQ/dbimUtIZD21D5UTg+vQpIkGC6ZEizZ35WM8asQCs2RihePyeRzi5oA625C
 B6+oQ4jrtNmjaGvCvBJC7QrdFiMY4tJnZn3uS5IIkxZrMCLYs3gN84I8iV1xCyo9sBrr
 gAg2vx2vSdm0ocHA9PQLHCPn3LfGZUnRDLGolvSfy3wbtHtCBcjuyJJJXYWj5omkvSyr
 YYFg==
X-Gm-Message-State: AOJu0YzsHmmpwD4GIiCJp/VJxr0PEX3X3E1GtAAet3ZSP9U/n5LSxGjJ
 JjFkGe8Pzc+UzogmDaaXuRIjWFdjstW0RYAN5M0QG382LhnVGMZrfhIqObhX9DjmwzMVCbKIv7K
 G76KGSwMiO5D2hwXfRE2ssmdfDzM/6750zaw=
X-Google-Smtp-Source: AGHT+IGTe69xN5jAeDYiwtAo7HEs3cvOWH3BfQKKE4xX/WWjFQog0HGujCZ2izuiRsQH5AKv2Ihdot8gXUYy/Ao+7I4=
X-Received: by 2002:a17:902:ea09:b0:20b:7388:f74 with SMTP id
 d9443c01a7336-21183d10a61mr295426085ad.12.1731523151272; Wed, 13 Nov 2024
 10:39:11 -0800 (PST)
MIME-Version: 1.0
References: <CA+rFky6jM9gKvgvy5BTR9CLOOAv+KycZORiu=3udwrFCZAE=6g@mail.gmail.com>
In-Reply-To: <CA+rFky6jM9gKvgvy5BTR9CLOOAv+KycZORiu=3udwrFCZAE=6g@mail.gmail.com>
From: Andrew Randrianasulu <randrianasulu@gmail.com>
Date: Wed, 13 Nov 2024 21:47:47 +0300
Message-ID: <CA+rFky6iNKWpjrn1kXoJTooF7ZFKVhz0cqu+34EWwjfM8XcF0Q@mail.gmail.com>
Subject: Re: qemu-systems-sparc can't do 1152x900 ?
To: QEMU <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="0000000000005a23320626cfa679"
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=randrianasulu@gmail.com; helo=mail-pl1-x633.google.com
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

--0000000000005a23320626cfa679
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 9:20=E2=80=AFPM Andrew Randrianasulu <
randrianasulu@gmail.com> wrote:

> Was trying to figure out if my glitches at [1] due to wrong resolution
> tried to start
> qemu like this:
>
> qemu-system-sparc -g 1152x900
> qemu-system-sparc: Unsupported resolution: 1152 x 900
>
> ow?
>
> in source
>
> hw/sparc/sun4m.c (git commit f0cfd067867668870931c9411d96cd518564b7a8)
>
>            if (!(graphic_width =3D=3D 1024 && graphic_height =3D=3D 768) =
&&
>                 !(graphic_width =3D=3D 1152 && graphic_height =3D=3D 900)=
) {
>                 error_report("Unsupported resolution: %d x %d",
> graphic_width,
>                              graphic_height);
>                 exit(1);
>             }
>
> may be && should be || ?
>

ah, was looking at wrong part of code ...

still, according to this

 https://docs.oracle.com/cd/E19620-01/805-4441/6j4761v2i/index.html
"S24 Frame Buffer Screen Resolutions
The S24 frame buffer in the SPARCstation(TM) 5 supports three different
screen resolutions. You may select a screen resolution other than the
default value. This is performed at the ok prompt."

there should be 1152x900

I thought I misremember  what was TCX, but

https://docs.oracle.com/cd/E19620-01/805-4441/6j4761v2h/index.html

tcx is the UNIX device name for the S24 Frame Buffer.



> [1] - https://gitlab.com/qemu-project/qemu/-/issues/2674
>

--0000000000005a23320626cfa679
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Nov 13, 2024 at 9:20=E2=80=AF=
PM Andrew Randrianasulu &lt;<a href=3D"mailto:randrianasulu@gmail.com">rand=
rianasulu@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex"><div dir=3D"ltr"><div>Was trying to figure out if my gli=
tches at [1] due to wrong resolution tried to start</div><div>qemu like thi=
s:</div><div><br></div><div>qemu-system-sparc -g 1152x900<br>qemu-system-sp=
arc: Unsupported resolution: 1152 x 900</div><div><br></div><div>ow?</div><=
div><br></div><div>in source</div><div><br></div><div>hw/sparc/sun4m.c (git=
 commit f0cfd067867668870931c9411d96cd518564b7a8)<br></div><div><br></div><=
div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 if (!(graphic_width =3D=3D 102=
4 &amp;&amp; graphic_height =3D=3D 768) &amp;&amp;<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 !(graphic_width =3D=3D 1152 &amp;&amp; g=
raphic_height =3D=3D 900)) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 error_report(&quot;Unsupported resolution: %d x %d&quot;, gra=
phic_width,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0graphic_height);<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(1);<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 }</div><div><br></div><div>may be &amp;&amp; shoul=
d be || ?</div></div></blockquote><div><br></div><div>ah, was looking at wr=
ong part of code ...</div><div><br></div><div>still, according to this</div=
><div><br></div><div>=C2=A0<a href=3D"https://docs.oracle.com/cd/E19620-01/=
805-4441/6j4761v2i/index.html">https://docs.oracle.com/cd/E19620-01/805-444=
1/6j4761v2i/index.html</a></div><div>&quot;S24 Frame Buffer Screen Resoluti=
ons<br>The S24 frame buffer in the SPARCstation(TM) 5 supports three differ=
ent screen resolutions. You may select a screen resolution other than the d=
efault value. This is performed at the ok prompt.&quot;</div><div><br></div=
><div>there should be 1152x900</div><div><br></div><div>I thought I misreme=
mber=C2=A0 what was TCX, but<br></div><div><br></div><div><a href=3D"https:=
//docs.oracle.com/cd/E19620-01/805-4441/6j4761v2h/index.html">https://docs.=
oracle.com/cd/E19620-01/805-4441/6j4761v2h/index.html</a></div><div><br></d=
iv><div>tcx is the UNIX device name for the S24 Frame Buffer.</div><div><br=
></div><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><di=
v dir=3D"ltr"><div><br></div><div>[1] - <a href=3D"https://gitlab.com/qemu-=
project/qemu/-/issues/2674" target=3D"_blank">https://gitlab.com/qemu-proje=
ct/qemu/-/issues/2674</a></div></div>
</blockquote></div></div>

--0000000000005a23320626cfa679--

