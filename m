Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9292DC79F9F
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 11:29:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4cxV-0001Ml-RK; Thu, 10 Sep 2026 07:28:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ralerrdirsardx@gmail.com>)
 id 1x4cxT-0001MW-L2
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 07:28:47 -0400
Received: from mail-yx2-x10.google.com ([2607:f8b0:4864:41::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ralerrdirsardx@gmail.com>)
 id 1x4cxR-00057N-CV
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 07:28:47 -0400
Received: by mail-yx2-x10.google.com with SMTP id
 00721157ae682-85d46e4cdccso21195137b3.1
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 04:28:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789039724; cv=none;
 d=google.com; s=arc-20260327;
 b=M8LcYM8g1Q5edjfbCBMURWMsPMT+dR/OEQ2wiwn0XfimHBrOVH+xnmqJray8B+DfzN
 gEjqxGbFKmKGFcAxS0lSXrXnAF+PmY9FRzcrkihmkAuVr1Qx0wC1iwAGGUE7xr3Vr6JU
 UlJP6jo4StUnxsoUuJX8ciMIqN0wGczf2FzouySMnNQgM8zJ8rWeGezxapJDbnl6ARIC
 aykT2II1q6jX6mNtlRTEtG0vJup1jX/zZ5nYb26yJNqSVnyH/mPmADG3CbEK4GPUr7Nn
 Tvzmn3d1lx/pKVKxrSR2H7tCDBwA3qpzaa8QyGSB9vaee8AFXnLkFpIh+ee5Qfvi+Xsq
 jHFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=7CYlEXhxrbN1V+HqCtjMsEEY3uXOXpQNCt5rvC2QGYY=;
 fh=qUOFTwWG+G+YmxTz+HxoQUPJX6AFWbaPYrnquSe1BBk=;
 b=Bsk8NDSimlXbsk8UHOpZ/DfJAhSw5mrAoyX5nnny3zmtz9SGLEgLsx7ovL7jjnmTdw
 +cozFe/Wt7ViVYAvH2QyyFmOSyeaRP8aOKkDUPfUXROr20ss+pPe0xZ+BvBNbYe7mCJA
 LhypgaTQrNf6SDDLDuhp98TqqMQvs5+tumaGRbRjaBqzc9PgrRA4BY3dSxrv3Nm5newY
 IwKSIF9CceaPyBbQik6NVOaQeAYBnY3NwZXKFqbtjiXv+cdvzWuMF8+LwdTwmk03qsVb
 F1peS2iLTmXxmbjtUOM0vJiSDUDf7k3hDmfaAvVgPiuPxu+GqpJ48G90c2h607+t7GC/
 U2tA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789039724; x=1789644524; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=7CYlEXhxrbN1V+HqCtjMsEEY3uXOXpQNCt5rvC2QGYY=;
 b=qabgt9b0fcj94OIBu06e7fBdgPJauRr6jv6DMiu4I9IKVrqjNp4/U7L4DpF+BpaQaN
 qTlPeFhuMqPui9zZbVSxDVFAGWHpfYPxQvhrj0NWD2HM92EWk2+t2qWPi5YxNiQkv0Zx
 If0Q7fo6XeT6ExBSnWjIyOIT7Edb1Z/bo7wePee1JQG8tGHrpr9vr9LWNW4QlEehOmuM
 L+JLr41INqLz7cT87p+FjKIXVKMkWAz2e5n5AmTBxFUPMRVtN79esmapxAeZNi6kHidI
 s/7JzFpWOoDQij5LFinHvrT75ocDqwZB4abAYNAmqOzupvqPocfT9MWMKj9IZZWbu/AH
 Bvuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789039724; x=1789644524;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=7CYlEXhxrbN1V+HqCtjMsEEY3uXOXpQNCt5rvC2QGYY=;
 b=WZYYJsFSS9Q6DXIlrbIG+UFAdTGSBb3e28FOxC0KY3nq97MSHZPh5miD2aCkGWoW3/
 v/mpgNlA2mAdx6xazzxTmqJi+VbDmjyhi4i+9Mv5/LFIKw1CWcEQC+FCnDu3F6smgSiq
 j4+yALzacpAW1hpSGGaLwFWFGiF4olSOwoKkBgxoy9ERmL8azuzPnN0aRM7jJ4eT91bD
 6tswrvvULwbiqA25qNRTUrsKc3drUfcrRZEU0yRD1Kdcm97HJKZasjrrMGgonLwidz4H
 RvN47BXvULXhMWZzMdoJ5F69YpYm1CnFarPFLXhDL0AQdm8sDOh7ZvfazzAO+nn/wh30
 beVA==
X-Gm-Message-State: AFuF++mWMdfCZebiVA82fDs8/pqOsYovSygBsTQfcF6IFOfHoxz57F/y
 TLXFwp8xsi0onQPmVfEhGyjPbT4RO85/Cx53D+u1FuNj3sYqvad+oM9n5IJ2e9b1y6CFK68lDSm
 IqdFzy0JI8FiaAkn9nHTZz11qTuFtxU3HmnpXgotePQ==
X-Gm-Gg: AYBFou08DYdEBd8NaNdo5qKXZ49kgeUvHtl5qxgD7ah2rL7hhn1JTbkkZZ8LIDCCGG4
 2iccuNfmRT58aZfrA74IG2L1FLXOl1xdpWyyRLfTyDbC2zN+4Qeij+G6PqMNl1uoVjg4E5B9+ub
 1qyH5chI7VJNV/ymtDc8yz/XdpJ1FmyjFTFYa/GIqXC5GxIH/gcj+9KrQufOEHVgQJdAUD8lZg/
 vPqn1jl1SSNk/lZxn/tJcYGq8MezKzw4LDzKpGGXkurUkgd2UNCPOSnDc2ex3xqpYteaXzQAb9r
 KpDu6xIxlafBRNh6eswl6EFz3J4Tof9fYRV5AJl0kcYZghlkI9GARsBDYff313HLL5o80ubNuF0
 auCioERTfz16B
X-Received: by 2002:a05:690c:314:b0:880:2544:faec with SMTP id
 00721157ae682-8802544fd0dmr40531627b3.5.1789039723960; Thu, 10 Sep 2026
 04:28:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260826171655.117679-1-ralerrdirsardx@gmail.com>
In-Reply-To: <20260826171655.117679-1-ralerrdirsardx@gmail.com>
From: Artemii Mashanov <ralerrdirsardx@gmail.com>
Date: Thu, 10 Sep 2026 14:28:32 +0300
X-Gm-Features: AcwNN1XEdxf6xfKwhSBY5kgS6-5xhH0eGEyB6Du0v9c8VxYrbQSKwNrA2iTEz9E
Message-ID: <CAGHp__Z_2O94ZQhzQVy12FOc+M6URY1UNQPY-Qy=Pv9S7amdzQ@mail.gmail.com>
Subject: Re: [PATCH] target/i386/tcg: zero FXSAVE FOP and reserved slot bytes
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org
Content-Type: multipart/alternative; boundary="0000000000003c5e9b065b1f452d"
Received-SPF: pass client-ip=2607:f8b0:4864:41::10;
 envelope-from=ralerrdirsardx@gmail.com; helo=mail-yx2-x10.google.com
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

--0000000000003c5e9b065b1f452d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Gentle ping on this patch from August 26. Could you please take a look when
you have time?

Patch archive
<https://www.mail-archive.com/qemu-devel@nongnu.org/msg1220122.html>

I'm happy to address any feedback.

Thanks


=D1=81=D1=80, 26 =D0=B0=D0=B2=D0=B3. 2026=E2=80=AF=D0=B3. =D0=B2 20:16, Art=
emii Mashanov <ralerrdirsardx@gmail.com>:

> TCG's do_xsave_fpu() omitted writing the FOP field and the reserved
> bytes (10..15) of each x87 register slot. Those parts of
> the destination buffer retained their previous contents.
>
> The reserved bytes of all eight slots are zeroed. TCG does not
> yet track the actual FOP value, this patch stores a fixed zero instead.
>
> Add a regression test in tests/tcg/x86_64/fxsave.c. It fills the
> FXSAVE area with 0xcc, executes FNINIT and FXSAVE64, then verifies that
> FOP and all reserved slot bytes are zero.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3522
>
> Signed-off-by: Artemii Mashanov <ralerrdirsardx@gmail.com>
> ---
>  target/i386/tcg/fpu_helper.c     |  3 ++
>  tests/tcg/x86_64/Makefile.target |  1 +
>  tests/tcg/x86_64/fxsave.c        | 66 ++++++++++++++++++++++++++++++++
>  3 files changed, 70 insertions(+)
>  create mode 100644 tests/tcg/x86_64/fxsave.c
>
> diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
> index b812125efa..9a2be488ef 100644
> --- a/target/i386/tcg/fpu_helper.c
> +++ b/target/i386/tcg/fpu_helper.c
> @@ -2601,6 +2601,7 @@ static void do_xsave_fpu(X86Access *ac, target_ulon=
g
> ptr)
>      access_stw(ac, ptr + XO(legacy.fcw), env->fpuc);
>      access_stw(ac, ptr + XO(legacy.fsw), fpus);
>      access_stw(ac, ptr + XO(legacy.ftw), fptag ^ 0xff);
> +    access_stw(ac, ptr + XO(legacy.fpop), 0);
>
>      /* In 32-bit mode this is eip, sel, dp, sel.
>         In 64-bit mode this is rip, rdp.
> @@ -2613,6 +2614,8 @@ static void do_xsave_fpu(X86Access *ac, target_ulon=
g
> ptr)
>      for (i =3D 0; i < 8; i++) {
>          floatx80 tmp =3D ST(i);
>          do_fstt(ac, addr, tmp);
> +        access_stw(ac, addr + 10, 0);
> +        access_stl(ac, addr + 12, 0);
>          addr +=3D 16;
>      }
>  }
> diff --git a/tests/tcg/x86_64/Makefile.target
> b/tests/tcg/x86_64/Makefile.target
> index c48767fef8..0f8f48b1a5 100644
> --- a/tests/tcg/x86_64/Makefile.target
> +++ b/tests/tcg/x86_64/Makefile.target
> @@ -20,6 +20,7 @@ X86_64_TESTS +=3D test-1648
>  X86_64_TESTS +=3D test-2175
>  X86_64_TESTS +=3D cross-modifying-code
>  X86_64_TESTS +=3D fma
> +X86_64_TESTS +=3D fxsave
>  TESTS=3D$(MULTIARCH_TESTS) $(X86_64_TESTS) test-x86_64
>  else
>  TESTS=3D$(MULTIARCH_TESTS)
> diff --git a/tests/tcg/x86_64/fxsave.c b/tests/tcg/x86_64/fxsave.c
> new file mode 100644
> index 0000000000..d08a4e8a0e
> --- /dev/null
> +++ b/tests/tcg/x86_64/fxsave.c
> @@ -0,0 +1,66 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + * See https://gitlab.com/qemu-project/qemu/-/issues/3522
> + */
> +
> +#include <stdint.h>
> +#include <stdio.h>
> +#include <string.h>
> +
> +#define FXSAVE_FOP_OFFSET      6
> +#define FXSAVE_X87_OFFSET      32
> +#define FXSAVE_SLOT_SIZE       16
> +#define FXSAVE_RESERVED_START  10
> +#define FXSAVE_NUM_SLOTS       8
> +
> +struct fxsave_area {
> +    uint8_t raw[512];
> +} __attribute__((aligned(16)));
> +
> +_Static_assert(sizeof(struct fxsave_area) =3D=3D 512,
> +                "FXSAVE area must be exactly 512 bytes");
> +
> +static uint16_t u16_le(const uint8_t *p)
> +{
> +    uint16_t v;
> +    memcpy(&v, p, sizeof(v));
> +    return v;
> +}
> +
> +int main(void)
> +{
> +    struct fxsave_area area;
> +    uint16_t fop;
> +
> +    memset(&area, 0xcc, sizeof(area));
> +
> +    __asm__ volatile(
> +        "fninit\n\t"
> +        "fxsave64 %0"
> +        : "+m" (area)
> +        :
> +        : "memory"
> +    );
> +
> +    fop =3D u16_le(&area.raw[FXSAVE_FOP_OFFSET]);
> +    if (fop !=3D 0) {
> +        fprintf(stderr, "FOP: expected 0, got 0x%04x\n", (unsigned)fop);
> +        return 1;
> +    }
> +
> +    for (int slot =3D 0; slot < FXSAVE_NUM_SLOTS; slot++) {
> +        int base =3D FXSAVE_X87_OFFSET + slot * FXSAVE_SLOT_SIZE;
> +        for (int b =3D FXSAVE_RESERVED_START; b < FXSAVE_SLOT_SIZE; b++)=
 {
> +            uint8_t val =3D area.raw[base + b];
> +            if (val !=3D 0) {
> +                fprintf(stderr,
> +                        "Slot %d byte %d (offset %d): expected 0x00, "
> +                        "got 0x%02x\n",
> +                        slot, b, base + b, (unsigned)val);
> +                return 1;
> +            }
> +        }
> +    }
> +
> +    return 0;
> +}
> --
> 2.54.0
>
>

--0000000000003c5e9b065b1f452d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><p class=3D"gmail-isSelectedEnd"><span>Hi,</span></p><p cl=
ass=3D"gmail-isSelectedEnd"><span>Gentle ping on this patch from August 26.=
 Could you please take a look when you have time?</span></p><p class=3D"gma=
il-isSelectedEnd"><a href=3D"https://www.mail-archive.com/qemu-devel@nongnu=
.org/msg1220122.html"><span>Patch archive</span></a></p><p class=3D"gmail-i=
sSelectedEnd"><span>I&#39;m happy to address any feedback.</span></p><p><sp=
an>Thanks</span></p><br></div><br><div class=3D"gmail_quote gmail_quote_con=
tainer"><div dir=3D"ltr" class=3D"gmail_attr">=D1=81=D1=80, 26 =D0=B0=D0=B2=
=D0=B3. 2026=E2=80=AF=D0=B3. =D0=B2 20:16, Artemii Mashanov &lt;<a href=3D"=
mailto:ralerrdirsardx@gmail.com">ralerrdirsardx@gmail.com</a>&gt;:<br></div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex">TCG&#39;s do_xsave_fpu()=
 omitted writing the FOP field and the reserved<br>
bytes (10..15) of each x87 register slot. Those parts of<br>
the destination buffer retained their previous contents.<br>
<br>
The reserved bytes of all eight slots are zeroed. TCG does not<br>
yet track the actual FOP value, this patch stores a fixed zero instead.<br>
<br>
Add a regression test in tests/tcg/x86_64/fxsave.c. It fills the<br>
FXSAVE area with 0xcc, executes FNINIT and FXSAVE64, then verifies that<br>
FOP and all reserved slot bytes are zero.<br>
<br>
Resolves: <a href=3D"https://gitlab.com/qemu-project/qemu/-/issues/3522" re=
l=3D"noreferrer" target=3D"_blank">https://gitlab.com/qemu-project/qemu/-/i=
ssues/3522</a><br>
<br>
Signed-off-by: Artemii Mashanov &lt;<a href=3D"mailto:ralerrdirsardx@gmail.=
com" target=3D"_blank">ralerrdirsardx@gmail.com</a>&gt;<br>
---<br>
=C2=A0target/i386/tcg/fpu_helper.c=C2=A0 =C2=A0 =C2=A0|=C2=A0 3 ++<br>
=C2=A0tests/tcg/x86_64/Makefile.target |=C2=A0 1 +<br>
=C2=A0tests/tcg/x86_64/fxsave.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 66 +++++++++++=
+++++++++++++++++++++<br>
=C2=A03 files changed, 70 insertions(+)<br>
=C2=A0create mode 100644 tests/tcg/x86_64/fxsave.c<br>
<br>
diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c<br=
>
index b812125efa..9a2be488ef 100644<br>
--- a/target/i386/tcg/fpu_helper.c<br>
+++ b/target/i386/tcg/fpu_helper.c<br>
@@ -2601,6 +2601,7 @@ static void do_xsave_fpu(X86Access *ac, target_ulong =
ptr)<br>
=C2=A0 =C2=A0 =C2=A0access_stw(ac, ptr + XO(legacy.fcw), env-&gt;fpuc);<br>
=C2=A0 =C2=A0 =C2=A0access_stw(ac, ptr + XO(legacy.fsw), fpus);<br>
=C2=A0 =C2=A0 =C2=A0access_stw(ac, ptr + XO(legacy.ftw), fptag ^ 0xff);<br>
+=C2=A0 =C2=A0 access_stw(ac, ptr + XO(legacy.fpop), 0);<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* In 32-bit mode this is eip, sel, dp, sel.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 In 64-bit mode this is rip, rdp.<br>
@@ -2613,6 +2614,8 @@ static void do_xsave_fpu(X86Access *ac, target_ulong =
ptr)<br>
=C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; 8; i++) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0floatx80 tmp =3D ST(i);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0do_fstt(ac, addr, tmp);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 access_stw(ac, addr + 10, 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 access_stl(ac, addr + 12, 0);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0addr +=3D 16;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
diff --git a/tests/tcg/x86_64/Makefile.target b/tests/tcg/x86_64/Makefile.t=
arget<br>
index c48767fef8..0f8f48b1a5 100644<br>
--- a/tests/tcg/x86_64/Makefile.target<br>
+++ b/tests/tcg/x86_64/Makefile.target<br>
@@ -20,6 +20,7 @@ X86_64_TESTS +=3D test-1648<br>
=C2=A0X86_64_TESTS +=3D test-2175<br>
=C2=A0X86_64_TESTS +=3D cross-modifying-code<br>
=C2=A0X86_64_TESTS +=3D fma<br>
+X86_64_TESTS +=3D fxsave<br>
=C2=A0TESTS=3D$(MULTIARCH_TESTS) $(X86_64_TESTS) test-x86_64<br>
=C2=A0else<br>
=C2=A0TESTS=3D$(MULTIARCH_TESTS)<br>
diff --git a/tests/tcg/x86_64/fxsave.c b/tests/tcg/x86_64/fxsave.c<br>
new file mode 100644<br>
index 0000000000..d08a4e8a0e<br>
--- /dev/null<br>
+++ b/tests/tcg/x86_64/fxsave.c<br>
@@ -0,0 +1,66 @@<br>
+/*<br>
+ * SPDX-License-Identifier: GPL-2.0-or-later<br>
+ * See <a href=3D"https://gitlab.com/qemu-project/qemu/-/issues/3522" rel=
=3D"noreferrer" target=3D"_blank">https://gitlab.com/qemu-project/qemu/-/is=
sues/3522</a><br>
+ */<br>
+<br>
+#include &lt;stdint.h&gt;<br>
+#include &lt;stdio.h&gt;<br>
+#include &lt;string.h&gt;<br>
+<br>
+#define FXSAVE_FOP_OFFSET=C2=A0 =C2=A0 =C2=A0 6<br>
+#define FXSAVE_X87_OFFSET=C2=A0 =C2=A0 =C2=A0 32<br>
+#define FXSAVE_SLOT_SIZE=C2=A0 =C2=A0 =C2=A0 =C2=A016<br>
+#define FXSAVE_RESERVED_START=C2=A0 10<br>
+#define FXSAVE_NUM_SLOTS=C2=A0 =C2=A0 =C2=A0 =C2=A08<br>
+<br>
+struct fxsave_area {<br>
+=C2=A0 =C2=A0 uint8_t raw[512];<br>
+} __attribute__((aligned(16)));<br>
+<br>
+_Static_assert(sizeof(struct fxsave_area) =3D=3D 512,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;FXSAVE area =
must be exactly 512 bytes&quot;);<br>
+<br>
+static uint16_t u16_le(const uint8_t *p)<br>
+{<br>
+=C2=A0 =C2=A0 uint16_t v;<br>
+=C2=A0 =C2=A0 memcpy(&amp;v, p, sizeof(v));<br>
+=C2=A0 =C2=A0 return v;<br>
+}<br>
+<br>
+int main(void)<br>
+{<br>
+=C2=A0 =C2=A0 struct fxsave_area area;<br>
+=C2=A0 =C2=A0 uint16_t fop;<br>
+<br>
+=C2=A0 =C2=A0 memset(&amp;area, 0xcc, sizeof(area));<br>
+<br>
+=C2=A0 =C2=A0 __asm__ volatile(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;fninit\n\t&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;fxsave64 %0&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 : &quot;+m&quot; (area)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 :<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 : &quot;memory&quot;<br>
+=C2=A0 =C2=A0 );<br>
+<br>
+=C2=A0 =C2=A0 fop =3D u16_le(&amp;area.raw[FXSAVE_FOP_OFFSET]);<br>
+=C2=A0 =C2=A0 if (fop !=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr, &quot;FOP: expected 0, got 0x%=
04x\n&quot;, (unsigned)fop);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 1;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 for (int slot =3D 0; slot &lt; FXSAVE_NUM_SLOTS; slot++) {<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 int base =3D FXSAVE_X87_OFFSET + slot * FXSAVE=
_SLOT_SIZE;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (int b =3D FXSAVE_RESERVED_START; b &lt; F=
XSAVE_SLOT_SIZE; b++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint8_t val =3D area.raw[base + =
b];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (val !=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr,<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &quot;Slot %d byte %d (offset %d): expected 0x00, &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &quot;got 0x%02x\n&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 slot, b, base + b, (unsigned)val);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 return 0;<br>
+}<br>
-- <br>
2.54.0<br>
<br>
</blockquote></div>

--0000000000003c5e9b065b1f452d--

