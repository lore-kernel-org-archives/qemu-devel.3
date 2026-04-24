Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABAAAFE5205
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 10:34:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGDrO-0000U3-MT; Fri, 24 Apr 2026 06:34:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wGDrM-0000Tf-Ld
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 06:34:08 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wGDrK-0000L4-Tx
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 06:34:08 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-670ab084a39so11681130a12.3
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 03:34:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777026844; cv=none;
 d=google.com; s=arc-20240605;
 b=Lwly0FSTlIlmRxO5D/fUM8mEkjUtOX8U3WnJ319xmAPLkgLmKTpw3nC2rkrcBevMHD
 vZ/s2xnRF93XyZMmB+B2hK2/g/roAKEx4U+Q8+iHPe6P7qQf38mWNn5ies2bLtyCVm9Q
 EkSqMmZIE8vbsqc/C8A7tHq85Jmv+gbHf6tdgWeiNrSsU1Hy+UFmi6UHFazPrs4W6IUt
 7F7CcXbeEm65CN1FkIGwMvUN74+mfoOstsbWAE4xONJfeuyAjVy9BXgx6GVzWdZTRkwV
 2qpID9ENCCXoEfhwnyXAmSJe6a1BwL9u4kqghWVkcqG9fK8XlrFL87K+TzZCJ3ducX3u
 UgpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=0q/e1S8MIpq0h1rBDk+OOjc6i4t6ilyHopIJ4dyDW+Y=;
 fh=QOBaKncngRIpqiuM55UWyc2lc0/XtsevYkrTH44B9Zw=;
 b=MaKxFSJBCRaaTVtdy2aL/AoePS1+sAeRg8zDbInAOFIQ+e3FyyjLJY8e+gdXi7/h0K
 4J3yFZ8kriOelGeWHEXgeLvxA7PCDBjQxTDxcJRuaVvxLxVk8inAB8+OhmBfWE/S2mE7
 HaVNRdumgq1zf0myVqZb9OgwkfmPBH3fvQ0F9jFldcQPyDPKhSQYv5Gok027u/Hzw7zO
 AGb+N4tROxHG6STni53VInOgkFI8AdzQW2/fd+/vsBrwV1DbobdsbJrf7M8FGojrLJgA
 9VFbD3yDCd+VrRHcyM8iOKm+iM36UMTgClWEb9IMi/1VyGtdvNT9HdFI4R3orUmv9Uzd
 42KA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1777026844; x=1777631644; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0q/e1S8MIpq0h1rBDk+OOjc6i4t6ilyHopIJ4dyDW+Y=;
 b=OOb2Er4mz4JSu5ZN5jgH2/rnNKMiZ04oXAReGcvRhqdTkyxmZEht4E7AKDjSp+n5wh
 NprEOcEzXfwIczL3TWJ5Br64VIrkV+y9meyOmXY4ypBoOqmQrdFb1Fw1sjfaU9pSA5n2
 E/tR68UfW5w2QR1I9PQhA26L7qXMsQwRYX2nBUE3/o47jeZaHmhEE9hzlBtQwDYtHrp+
 RrUzRrDeZfYDlXl3R9oV6QiSDbOc1dpIb9c1DGwH1waLperzJlNaPBPNwVQYe9rOi6dt
 6WGlXJky/LW0V82Cn+O7iNWUUaDdVHcWSKBZUJnWZY/oMK0eh3HVCcLPt0+kf46mfWhV
 Xo2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777026844; x=1777631644;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0q/e1S8MIpq0h1rBDk+OOjc6i4t6ilyHopIJ4dyDW+Y=;
 b=FQazVapCUohmZILsc2+/DgBg+692Kc7xM6IlheTdWMJPcG3f/GQIQvD4Jvuppjfnw5
 a/uxxy8gFbqCSBZGyZg/IsxGA7NWwDhKiX4BSBNgBYj97eQV4RTtuH251gNr3oiBLbpI
 jKsQPHTRgUrKhgN38b018is/tv81wEDzUiWJLfBoGlM34SKZ1yeeYV+PMd2XlGTWheys
 qW5YT1sT4vVlrQaFrX+b9fNvX5bA+ySRGJFmCbY+OMxxlA9t0nQhP+Kw1oUmjRatOIA1
 5Bk/kKV/nG43PMT2UnDcdXgjfWeBUwTrKKhmbLYB2rdXDsseVCkF7+WaDnNXtdGwrktK
 6nbA==
X-Gm-Message-State: AOJu0YzV4ALywpp21F90Wm1BEX0S8QScx0IsmdhFcADSfC1ASGWtk3lc
 L/OjXxhDRYRXKLhCIdMVE6kMoe0SsWGmsEMdAVqzHwJR19iYpKWwfSLoZe88Xh5a2jn/vG181eA
 anLYzA2rnj4VAdz0tFx270KUJj4VtxKVlOXFRq/1E9A==
X-Gm-Gg: AeBDieuU5FFmjM8xp6e8FRBUsLrIQZae0i4F9bkYN0l6/erCXG+fp/9qj49LuViFvnF
 FJcEDxOR/MYPsYf6thWVK/BmoAnhGCKPA8Pd9/d1pW54v8gQHPnEHTyOLBZeC3qPJWTzipyCkg4
 5anQ8iWbqEiAiR4TzhC5jGv1+ACCa7X3jaYxBGKBiDAnGqvZUC/x0DPNL/ad6S4qz+Dzt8Zmx+e
 l+n80Nr7lK3yafJxYliGuVG8Y+9Cr+cySbkbvcRx+IuJ1RDXpUz+wo3p+MYWz7xjmWYvKjD5qE0
 2VkVsFLIoLJxe4wgKx3CdEWMYKZGcOA=
X-Received: by 2002:a05:6402:26d2:b0:670:f35a:c0b2 with SMTP id
 4fb4d7f45d1cf-672bfdc9340mr15337263a12.14.1777026843784; Fri, 24 Apr 2026
 03:34:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260424042946.3875690-1-frank.chang@sifive.com>
 <CAFEAcA-5EdfWd2qZ5kjmHkMxSNWXveOUmEOGyYLQmFtHwS0-Qw@mail.gmail.com>
In-Reply-To: <CAFEAcA-5EdfWd2qZ5kjmHkMxSNWXveOUmEOGyYLQmFtHwS0-Qw@mail.gmail.com>
From: Frank Chang <frank.chang@sifive.com>
Date: Fri, 24 Apr 2026 18:33:52 +0800
X-Gm-Features: AQROBzB_DOSJN2RoJIP389k9YEvgj4OnB8YE5oy03V8uPkHK0u188PnqNwChiY4
Message-ID: <CAE_xrPgqZumBE9+kqikeuNO5QCEeRb=RS77Hfe0xPNKWW=NTPg@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] Add the implied rules for G and B extensions
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, 
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000c7cbc20650324d1c"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=frank.chang@sifive.com; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--000000000000c7cbc20650324d1c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 24, 2026 at 4:18=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org>
wrote:

> On Fri, 24 Apr 2026 at 05:30, <frank.chang@sifive.com> wrote:
> >
> > From: Frank Chang <frank.chang@sifive.com>
> >
> > Add the implied rules for G and B extensions to enable the implied
> > extensions.
> >
> > Changelog:
> >   v3: Keep riscv_cpu_validate_g() and riscv_cpu_validate_b() but remove
> >       the auto-enables as the implied extensions can be enabled by the
> >       implied rules.
> >
> >   v2: Remove riscv_cpu_validate_g() and riscv_cpu_validate_b() as the
> >       implied extensions can be enabled by the implied rules.
> >
> > Frank Chang (1):
> >   target/riscv: Add standard B extension implied rule
> >
> > Jim Shu (1):
> >   target/riscv: Add the implied rule for G extension
>
> Reminder to riscv folks -- please put "target/riscv" or
> similar in the subject of your cover letter, so that people
> who aren't interested in riscv patches can skip over it
> rather than wondering which of the many possible areas
> of QEMU "G and B extensions" might be talking about...
>
> thanks
> -- PMM
>

Agh, sorry for missing that.
I read the mail after sending out another patchset:
https://lore.kernel.org/qemu-devel/20260424102800.24022-1-frank.chang@sifiv=
e.com/

I will fix it in the later patchsets.
Sorry for the disturbance

Regard,
Frank Chang

--000000000000c7cbc20650324d1c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Apr 24,=
 2026 at 4:18=E2=80=AFPM Peter Maydell &lt;<a href=3D"mailto:peter.maydell@=
linaro.org">peter.maydell@linaro.org</a>&gt; wrote:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">On Fri, 24 Apr 2026 at 05:30, &lt;<a hr=
ef=3D"mailto:frank.chang@sifive.com" target=3D"_blank">frank.chang@sifive.c=
om</a>&gt; wrote:<br>
&gt;<br>
&gt; From: Frank Chang &lt;<a href=3D"mailto:frank.chang@sifive.com" target=
=3D"_blank">frank.chang@sifive.com</a>&gt;<br>
&gt;<br>
&gt; Add the implied rules for G and B extensions to enable the implied<br>
&gt; extensions.<br>
&gt;<br>
&gt; Changelog:<br>
&gt;=C2=A0 =C2=A0v3: Keep riscv_cpu_validate_g() and riscv_cpu_validate_b()=
 but remove<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0the auto-enables as the implied extensions c=
an be enabled by the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0implied rules.<br>
&gt;<br>
&gt;=C2=A0 =C2=A0v2: Remove riscv_cpu_validate_g() and riscv_cpu_validate_b=
() as the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0implied extensions can be enabled by the imp=
lied rules.<br>
&gt;<br>
&gt; Frank Chang (1):<br>
&gt;=C2=A0 =C2=A0target/riscv: Add standard B extension implied rule<br>
&gt;<br>
&gt; Jim Shu (1):<br>
&gt;=C2=A0 =C2=A0target/riscv: Add the implied rule for G extension<br>
<br>
Reminder to riscv folks -- please put &quot;target/riscv&quot; or<br>
similar in the subject of your cover letter, so that people<br>
who aren&#39;t interested in riscv patches can skip over it<br>
rather than wondering which of the many possible areas<br>
of QEMU &quot;G and B extensions&quot; might be talking about...<br>
<br>
thanks<br>
-- PMM<br></blockquote><div><br></div><div>Agh, sorry for missing that.</di=
v><div>I read the mail after sending out another patchset:</div><div><a hre=
f=3D"https://lore.kernel.org/qemu-devel/20260424102800.24022-1-frank.chang@=
sifive.com/">https://lore.kernel.org/qemu-devel/20260424102800.24022-1-fran=
k.chang@sifive.com/</a><br><br></div><div>I will fix it in the later patchs=
ets.</div><div>Sorry for the disturbance</div><div><br></div><div>Regard,</=
div><div>Frank Chang=C2=A0</div></div></div>

--000000000000c7cbc20650324d1c--

