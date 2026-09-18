Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 225BDC982DA
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 15:14:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7aHO-0002zs-3R; Fri, 18 Sep 2026 11:13:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <54weasels@gmail.com>)
 id 1x7aHL-0002yn-5U
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 11:13:32 -0400
Received: from mail-oo2-x2b.google.com ([2607:f8b0:4864:31::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <54weasels@gmail.com>)
 id 1x7aHI-0007TO-Ih
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 11:13:30 -0400
Received: by mail-oo2-x2b.google.com with SMTP id
 006d021491bc7-6c2613d8157so362745eaf.2
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2026 08:13:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789744407; cv=none;
 d=google.com; s=arc-20260327;
 b=XTA/wI6YMtpBj3c84S36CV3FQfA37APVa8ZNzt9pXhgnpOP5TfBQjN1pwA9OGijiwQ
 e8ZixnfwnilaI1jSK42nGZESOfgWclgW6HzxpovhGwzyrwiafOQPQUjjYB1zqBHe56yt
 dVhYCx88834Kfh758UEb+Ajm4jPjBiwamZvFfDVZ+kXRiNXqWX6qyykLRORSQSa7kNU1
 ulBqHx8efPiPMO+P9qroA1Fgnag6GDm56Uo3pCg+r9FYwMrh9Zh4LjihRAkjes126/w8
 8rWirYb9L3Klrc3rHWbAw6SR6BSdTQqnvOxnc6mEZUxjZzi434/1vQBGZjpLcLRCudGw
 S/vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=qpvd7hPcv6nW9ewfZE7lzopb4vf8RJuvkdODvedUOcs=;
 fh=6czfcAJfDmmN3XL32rileFAc4KWn6CYOehApDowJF/Q=;
 b=sgdS6Ekfjum9OgL+9I8dslFyb6uL8Am2STsyB7HPpjvLa/y/fvfsbbTrvpG56oTQdp
 JKAgihvo6dpKh6n1m+6hJqkVxGnYkI3HfxDihKnqbuDeY3aGCTH7viL8w0+gBLkRD7/k
 Rd1ZABlwB6Q0/rZt/4iFS78slwTXPqE3HkcDmp5VryadirzWaNuL8Rwfw74/srchYNUu
 N17T//ojjsiGG0to0RSduhdGNC7HRKs4Tp32o3fKTNeoPQMfs2e9XZd7ePiJQ9BCdhV8
 C5VLhPapriXh43hEnlqkbAkg4rMD8xGQ2MPmSLUwZQMlQOzOhOro7SBGhoiDc1KfDS6Z
 dXpg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789744407; x=1790349207; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=qpvd7hPcv6nW9ewfZE7lzopb4vf8RJuvkdODvedUOcs=;
 b=qWCjbS5WEO7JdQ+miP2sxv1exbQsDWyfR6oZ5A0erShzO4vS35cuf+TOZ3/rKHVvDV
 rTA0yLJdQy5qLG/oBZgnat0UeJJp/EGZBNSZiJF7K8HkOmytKMooCi8h04uWPOsso09y
 yvQrbg2Uu2A5bRi6bUkyptQ5jbEdp+B2PEtIor06NfsF6AsHPGOJ6nYDOC9sqsNVcYJ6
 W1fTf2Rw6tOXD91keCq5g3WNOj5/TyST35jKU/3A7ltQDbiwODJ9/GvvyK7gzkbkAbw1
 yhlfOHzdnQQhpJizg3WKSl943+qQgt3m9D2q8mwFdMSKU4xl/Pj8Nuuaz0fC7FYb3L+K
 reZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789744407; x=1790349207;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=qpvd7hPcv6nW9ewfZE7lzopb4vf8RJuvkdODvedUOcs=;
 b=03KqT350LtYgAmLusw/juvq/agKlgptQJZYd3oZlkEz0Cc6Drk8hqWZAXmEOhaQyN8
 IdN0tDCmw5e7bCSbH2Qu2vg+9SEuidPJIN7q5fR35cl5QM1AwQiby2dJUR1hZuFVBMzs
 L6SS2A7wslzYYJz78nu4MKA23V7vMrZx6eDrfyKwbp0pmPbpW/K0ntLKuyp0yrtbYIW/
 O7EDoo+uBQeUXYuVyNyRxr/J/g9+ZUARqQNEJ82KvXaxdCoxCZqhmJikyNDTASCdP1cR
 wg9zS1Qvn8w2W8k2SskqkSDHHhmPHy8DWLgjgME4ShLZOnDkco3Bxv3fmvs2zsGORANJ
 vFrA==
X-Gm-Message-State: AFuF++kcfShvuwvHvDAfm5mxWwOLxhhzG9ZgbOP1UknHMU9s/BQmUf47
 PI7x3UqYhOEE4Bv/zxpCjKI5y31QxW14bchm7Gqhdr09TfOjFlyWOXv8J+lW5CHACTxGhgS+y+S
 IBvZo8+WxGApgP7ITyngBWvu5PYgaaJk=
X-Gm-Gg: AYBFou2ICQIN4dRF+OpKcvb+1J+oZChdJqAYz4moPe82H1dpkqRh2Km+BzXIyS7g578
 iTh6vBb3EgdTHMEswZenBqj7ggS0Bj+WHs2M785MHOPjjClFEysCQzwstVYgxT688kWmDar9kKT
 9aTdiTUFCgQlXJNgcMH2wuz6H7dGLy3G62pUowtWU8f3ojEif+aedmny5aMovMd/nAfhW+ZSBKR
 8HBTznTgUmtH5+2/xEpboEVaWG5ADpd8ehbLUYEwachBViDLTc1oNVivc16RawAriQiM7cI4KYe
 EZ7+xtbqc7ZO03411fC9lNHlDCNmwJogMqmoCJAumGqPAz5pnw8Rtl4xaczuCcDbSKA=
X-Received: by 2002:a05:6820:c90:b0:6b1:39b1:80ee with SMTP id
 006d021491bc7-6ca9a849aaamr2523547eaf.24.1789744322130; Fri, 18 Sep 2026
 08:12:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260903044626.24453-1-54weasels@gmail.com>
 <CAFWf6u8rjCECp+cdP21kfB7QUYff3crQiE1v5DnHXcMVzWan9w@mail.gmail.com>
 <8310b400-544e-4ed5-8eb6-e0797a924a8d@ilande.co.uk>
In-Reply-To: <8310b400-544e-4ed5-8eb6-e0797a924a8d@ilande.co.uk>
From: Purr Box <54weasels@gmail.com>
Date: Fri, 18 Sep 2026 08:11:51 -0700
X-Gm-Features: AcwNN1WXx5JzkVmXqLPLSvOLvcSt5v_FyvY8F1guSc0kupcdHckx6CqWVISkkX8
Message-ID: <CAFWf6u86nFtQNfD=NFwUPamRKpt+EJg0vYhc1AALkGHJwtqZ+w@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] Implement missing functionality and hooks in m68k
 to support upcoming Sun-3 implementation
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, laurent@vivier.eu, 
 BALATON Zoltan <balaton@eik.bme.hu>
Content-Type: multipart/alternative; boundary="0000000000008f40cc065bc3522c"
Received-SPF: pass client-ip=2607:f8b0:4864:31::2b;
 envelope-from=54weasels@gmail.com; helo=mail-oo2-x2b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, SPF_HELO_NONE=0.001,
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

--0000000000008f40cc065bc3522c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you very much in advance! I'm looking forward to getting sun3
supported.

Dan.

On Fri, Sep 18, 2026 at 6:32=E2=80=AFAM Mark Cave-Ayland <
mark.cave-ayland@ilande.co.uk> wrote:

> On 09/09/2026 19:54, Purr Box wrote:
>
> > Gentle ping on this series. v5 addresses Zoltan's review feedback from
> v4 (fsave
> > simplification, NMI edge-trigger rationale, added Signed-off-by). Would
> appreciate
> > any review when you have a chance.
>
> Apologies for the delay: I will have quick look through the series over
> the next few
> days, although I suspect I'd need to defer to Laurent's greater 68k
> knowledge here.
>
> > Dan.
> >
> > On Wed, Sep 2, 2026 at 9:46=E2=80=AFPM 54weasels <54weasels@gmail.com
> > <mailto:54weasels@gmail.com>> wrote:
> >
> >     This series adds M68020/030-specific features to the m68k target th=
at
> >     are required by the Sun-3 machine (series C) and its PROM/SunOS
> guests:
> >
> >        1/6: CAAR register stub for 68020/030 cache control
> >        2/6: fsave/frestore fix for 68881 (non-68040) FPU frames
> >        3/6: Edge-triggered NMI semantics for Level 7 interrupts
> >        4/6: Function code extraction during TLB fills
> >        5/6: Custom MMU intercept hook for Sun-3 transparent translation
> >        6/6: Physical Bus Error and M68020 Format 0xB stack frames
> >
> >     Changes since v4:
> >        - Added Signed-off-by to all patches.
> >        - Patch 2/6 (fsave): Addressed Zoltan's review =E2=80=94 replace=
d
> redundant
> >          M68040||FPU check with just M68K_FEATURE_FPU, removed
> unnecessary
> >          if/else in frestore, moved Context: below --- separator.
> >        - Patch 3/6 (NMI): Addressed Zoltan's review =E2=80=94 nmi_pendi=
ng cannot
> be
> >          replaced by testing pending_level =3D=3D 7. The flag captures =
the
> edge
> >          transition (level < 7 =E2=86=92 7) required by Motorola's NMI
> specification,
> >          while pending_level only reflects the current interrupt level.
> >          Testing pending_level alone would produce level-triggered
> behavior,
> >          firing on every interrupt check rather than once per edge.
> >        - Rebased on current master.
> >
> >     54weasels (6):
> >        target/m68k: Add dummy CAAR register
> >        target/m68k: Fix fsave/frestore for 68881 FPU
> >        target/m68k: Fix NMI pending for Level 7 interrupts
> >        target/m68k: Extract Function Codes during TLB fills
> >        target/m68k: Implement custom MMU intercept hook
> >        target/m68k: Implement Physical Bus Error and Stack
> >
> >       target/m68k/cpu.c       |   4 +-
> >       target/m68k/cpu.h       |  21 ++++-
> >       target/m68k/helper.c    | 130 ++++++++++++++++++++++++++++-
> >       target/m68k/op_helper.c | 175
> ++++++++++++++++++++++++++--------------
> >       target/m68k/translate.c |  30 ++++---
> >       5 files changed, 280 insertions(+), 80 deletions(-)
> >
> >     --
> >     2.50.1 (Apple Git-155)
>
>
> ATB,
>
> Mark.
>
>

--0000000000008f40cc065bc3522c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thank you very much in advance! I&#39;m looking forward to=
 getting sun3 supported.<div><br></div><div>Dan.</div><div></div></div><br>=
<div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"=
gmail_attr">On Fri, Sep 18, 2026 at 6:32=E2=80=AFAM Mark Cave-Ayland &lt;<a=
 href=3D"mailto:mark.cave-ayland@ilande.co.uk">mark.cave-ayland@ilande.co.u=
k</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>On 09/09/2026 19:54, Purr Box wrote:<br>
<br>
&gt; Gentle ping on this series. v5 addresses Zoltan&#39;s review feedback =
from v4 (fsave <br>
&gt; simplification, NMI edge-trigger rationale, added Signed-off-by). Woul=
d appreciate <br>
&gt; any review when you have a chance.<br>
<br>
Apologies for the delay: I will have quick look through the series over the=
 next few <br>
days, although I suspect I&#39;d need to defer to Laurent&#39;s greater 68k=
 knowledge here.<br>
<br>
&gt; Dan.<br>
&gt; <br>
&gt; On Wed, Sep 2, 2026 at 9:46=E2=80=AFPM 54weasels &lt;<a href=3D"mailto=
:54weasels@gmail.com" target=3D"_blank">54weasels@gmail.com</a> <br>
&gt; &lt;mailto:<a href=3D"mailto:54weasels@gmail.com" target=3D"_blank">54=
weasels@gmail.com</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0This series adds M68020/030-specific features to th=
e m68k target that<br>
&gt;=C2=A0 =C2=A0 =C2=A0are required by the Sun-3 machine (series C) and it=
s PROM/SunOS guests:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 1/6: CAAR register stub for 68020/030 cache=
 control<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 2/6: fsave/frestore fix for 68881 (non-6804=
0) FPU frames<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 3/6: Edge-triggered NMI semantics for Level=
 7 interrupts<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 4/6: Function code extraction during TLB fi=
lls<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 5/6: Custom MMU intercept hook for Sun-3 tr=
ansparent translation<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 6/6: Physical Bus Error and M68020 Format 0=
xB stack frames<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Changes since v4:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 - Added Signed-off-by to all patches.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 - Patch 2/6 (fsave): Addressed Zoltan&#39;s=
 review =E2=80=94 replaced redundant<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 M68040||FPU check with just M68K_FEA=
TURE_FPU, removed unnecessary<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if/else in frestore, moved Context: =
below --- separator.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 - Patch 3/6 (NMI): Addressed Zoltan&#39;s r=
eview =E2=80=94 nmi_pending cannot be<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 replaced by testing pending_level =
=3D=3D 7. The flag captures the edge<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 transition (level &lt; 7 =E2=86=92 7=
) required by Motorola&#39;s NMI specification,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 while pending_level only reflects th=
e current interrupt level.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Testing pending_level alone would pr=
oduce level-triggered behavior,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 firing on every interrupt check rath=
er than once per edge.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 - Rebased on current master.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A054weasels (6):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 target/m68k: Add dummy CAAR register<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 target/m68k: Fix fsave/frestore for 68881 F=
PU<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 target/m68k: Fix NMI pending for Level 7 in=
terrupts<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 target/m68k: Extract Function Codes during =
TLB fills<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 target/m68k: Implement custom MMU intercept=
 hook<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 target/m68k: Implement Physical Bus Error a=
nd Stack<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0target/m68k/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0=
|=C2=A0 =C2=A04 +-<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0target/m68k/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0=
|=C2=A0 21 ++++-<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0target/m68k/helper.c=C2=A0 =C2=A0 | 130 ++++=
++++++++++++++++++++++++-<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0target/m68k/op_helper.c | 175 ++++++++++++++=
++++++++++++--------------<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0target/m68k/translate.c |=C2=A0 30 ++++---<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A05 files changed, 280 insertions(+), 80 delet=
ions(-)<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0-- <br>
&gt;=C2=A0 =C2=A0 =C2=A02.50.1 (Apple Git-155)<br>
<br>
<br>
ATB,<br>
<br>
Mark.<br>
<br>
</blockquote></div>

--0000000000008f40cc065bc3522c--

