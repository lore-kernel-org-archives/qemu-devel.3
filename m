Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E00BDC624A4
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 14:08:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x12fh-00023a-PI; Mon, 31 Aug 2026 10:07:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x12fh-00023S-61
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 10:07:37 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x12ff-0006DK-5k
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 10:07:36 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-c250f28f1cdso551442166b.0
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 07:07:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788185253; cv=none;
 d=google.com; s=arc-20260327;
 b=Xe0P1AOWUQo8V2181wF+3KQBwNCbblDdSGXXraBlIDtNHrYnm3VW7h8z1Uu/KHv0Kp
 iWWjfd8CskSwNekJVHjNiMFOHsnLIfW6/anVx8NeGRgxwmYAQYnYOdux1j2+M/CXOBzP
 0HXFEhryC29Ig4pwRm/UO222himK7aDjM8bVwyMou2wcjCqLxf1dSD97LZ7o2IgJsge4
 JS88tW24iIVCo/SnJA7CFztkWdfkMqpCRqx2ozRQ9pXaz4X0lo8XTw7gHoG9eqU8FGId
 i0QrHoyBgMax7k4b7LUSsEHbzwdSQaB67WEI09zjcgRoW62bIsVFAhZAPbdQUXH1f1ic
 PgvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
 :mime-version:dkim-signature;
 bh=bTG1ah6ofY0wulld+MskS/4dQpfX9pvTix7fVy2y+gU=;
 fh=9mwyWOpK54iJC8aLtzCKDeGN9smrR+H4CobDsaMoCBU=;
 b=fWexl9R33wUAS3XDOsnoqiSGWAb4NNNubI30xQfxZkLjArSSruzAA4lQh26crAsK89
 BQIMvrt3oDTFHhESRaBL/IwJpXVpvK0eDpZduzbSSfbgGUQ7KH2NyVShVNlwjphOIkaA
 8kjf1QeRM9F8h/lQm6KihJLRbSqhs9L6vu0hrfChf5oqrVh4amI7I+u9edszPXwpAtlQ
 tB2W02rItDcLNeJE/UVApzUXKFWbQSElMpZRFeSjS56bpTX/QEI3Fd0igDpU74TBay7/
 DiNNpt1ATsldwBD2SpbeuU3++6njqRFO6YQwDlFXgDPFp687NdEaZtCNuzY81HsDr3pg
 eRvw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788185253; x=1788790053; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:reply-to
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bTG1ah6ofY0wulld+MskS/4dQpfX9pvTix7fVy2y+gU=;
 b=QLescBXJYk5stw91Om5Qutuc3mMIoznaok57D3rANS/SLlawwwYPodGs5fhTSrts0H
 OzbQrZpM4RKlChpYnfCGducXZIY63RfEylzYH4rolUPKjRzL6cEDtkfHKrkQFQ0gYKU5
 5oHn2FJPyPtou4EV14oX8ONsEXTZ16L2OOo+1zOFCG6BGOzJG2mZDIKCfeGhqsfcYpiK
 Doul8h2lytwg0PoO4/7JyHCeqQb81hLHpQYDc0RgEJ5cQ7t/uMTZAPs3RaYwV7qF3uXJ
 DL7iGTtEF1Zdw/eS1J2wtnQDWblXutqgo/KjkT0othiXTrPmQwmJbMfc7Q3HZT/riMc1
 mrxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788185253; x=1788790053;
 h=content-type:cc:to:subject:message-id:date:from:reply-to
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=bTG1ah6ofY0wulld+MskS/4dQpfX9pvTix7fVy2y+gU=;
 b=knu3dN3HII/DSeHat6JG2O+Lc/mk213bXQNxmu35IJiOgXFmigbt9FMY3jWc3DfY4L
 5BENV3pEZ4Il8FP8nzZMCFIWC/vhYWUqf4I6oUEgSN1dRQ0GxwFhxG+LYj5STTGyojB5
 ybFGX8L0enPPx0gjC5tRafZmYu+JW0ImaevgtkqroOA4Wycp7C8to+R2ItdvXUEsQqBi
 X73GOB5Le9OTWPHAF7FfCFjJt6IE9FqGp0E3Hq97/uaje21N6v/hKjeRmO4GCfisL/IE
 ibRwj0uFiLmMQgILKjT05K1lXynKeyg7OappNePqJ8cWxOmublrKHljlkYGw1QSfAkNV
 yIRg==
X-Gm-Message-State: AFuF++kU8z43J2A9ET4bE6uT0rQ1mb7Cxsi4mKa/oBF7T3wD/HUwGRGJ
 4UTKU0ALTYhnEyfwMYtduthymqHFh95CvIVTPMNAHiXysZXZa9pVBITl5ysibyH2DMZ3sUnw4Bk
 Ms9eMZHcwMTwkVTYzfCuBflyhYaIL+78=
X-Gm-Gg: AR+sD10/h/xPG+qaOko84VlwE8LlOVrEAcr+xZaniraceIZu2kzDq3pCKQMk4PfHu0L
 ZbDjZWw9LKAhI7TEW68bLOR297l73VdWYUeI2IuUw6zBkmu3KpUB0StVxeIADvusKZ4eEp+EeRj
 wmCUyUpMsanF3KjgY9AZMWWtTZXVIjbmIP8vQXLvB9lZiMVqP4+RVq2wA004+ueNedTj1vq8TbY
 UVbC+2bOEmH35TojLheIUKSp+XrDuqUl3SbEvMH9CgmdErF4IJUEp6knveDpiwJKBkfmiGj9VC7
 Z1DiOPAuG4iGZyniaJ7lWaO5y5tsv+REMd7t5G+LUH8X
X-Received: by 2002:a17:907:3e8d:b0:c24:6985:d7a1 with SMTP id
 a640c23a62f3a-c2556da9d6fmr1776563166b.7.1788185253153; Mon, 31 Aug 2026
 07:07:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260724000948.234657-1-pierrick.bouvier@oss.qualcomm.com>
 <20260724000948.234657-4-pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20260724000948.234657-4-pierrick.bouvier@oss.qualcomm.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Mon, 31 Aug 2026 22:07:20 +0800
X-Gm-Features: AcwNN1Xs_9LeUBvOAE0x4YSgMMdi5a_bB03hIC4HrxiWyerX8IOoUdYPBv2jmGQ
Message-ID: <CAE2XoE8jht9TP8OrTGAZNfALOTBECz+_2dRtKzmjwwf5kur2Jw@mail.gmail.com>
Subject: Re: [PATCH 03/27] target-info: add target_riscv32 and
 target_base_riscv
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Bernhard Beschow <shentey@gmail.com>, 
 Anton Johansson <anjo@rev.ng>, Alistair Francis <alistair@alistair23.me>, 
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Content-Type: multipart/alternative; boundary="000000000000ce91ec065a585284"
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=luoyonggang@gmail.com; helo=mail-ej1-x631.google.com
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
Reply-To: luoyonggang@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--000000000000ce91ec065a585284
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026 at 8:11=E2=80=AFAM Pierrick Bouvier <
pierrick.bouvier@oss.qualcomm.com> wrote:
>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>  include/qemu/target-info.h | 16 +++++++++++++++-
>  target-info.c              | 16 ++++++++++++++++
>  2 files changed, 31 insertions(+), 1 deletion(-)
>
> diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
> index 6c5b714288e..88ccef2a988 100644
> --- a/include/qemu/target-info.h
> +++ b/include/qemu/target-info.h
> @@ -99,10 +99,24 @@ bool target_ppc64(void);
>   */
>  bool target_s390x(void);
>
> +/**
> + * target_base_riscv:
> + *
> + * Returns whether the target architecture is RISC-V 32-bit or 64-bit.
> + */
> +bool target_base_riscv(void);
> +
> +/**
> + * target_riscv32:
> + *
> + * Returns whether the target architecture is RISC-V 32-bit.
> + */
> +bool target_riscv32(void);
> +
>  /**
>   * target_riscv64:
>   *
> - * Returns whether the target architecture is riscv64
> + * Returns whether the target architecture is RISC-V 64-bit.
>   */
>  bool target_riscv64(void);
>
> diff --git a/target-info.c b/target-info.c
> index 04c69c41f8a..7ac2260b182 100644
> --- a/target-info.c
> +++ b/target-info.c
> @@ -94,6 +94,22 @@ bool target_s390x(void)
>      return target_arch() =3D=3D SYS_EMU_TARGET_S390X;
>  }
>
> +bool target_base_riscv(void)
> +{
> +    switch (target_arch()) {
> +    case SYS_EMU_TARGET_RISCV32:
> +    case SYS_EMU_TARGET_RISCV64:
> +        return true;
> +    default:
> +        return false;
> +    }

This can be improved by using  (TARGET_ARCH_BITMASK(target_arch()) &
QEMU_ARCH_RISCV

TARGET_ARCH_BITMASK should be a new macro in base-arch-defs.h
#define TARGET_ARCH_BITMASK(sys_emu) 1UL << (sys_emu)


And the enum in base-arch-defs.h can be update with this emu, so once the
sys_emu maximal >32 still works in future.

> +}
> +
> +bool target_riscv32(void)
> +{
> +    return target_arch() =3D=3D SYS_EMU_TARGET_RISCV32;
> +}
> +
>  bool target_riscv64(void)
>  {
>      return target_arch() =3D=3D SYS_EMU_TARGET_RISCV64;
> --
> 2.43.0
>
>


--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000ce91ec065a585284
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Fri, Jul 24, 2026 at 8:11=E2=80=AFAM Pierrick B=
ouvier &lt;<a href=3D"mailto:pierrick.bouvier@oss.qualcomm.com">pierrick.bo=
uvier@oss.qualcomm.com</a>&gt; wrote:<br>&gt;<br>&gt; Signed-off-by: Pierri=
ck Bouvier &lt;<a href=3D"mailto:pierrick.bouvier@oss.qualcomm.com">pierric=
k.bouvier@oss.qualcomm.com</a>&gt;<br>&gt; ---<br>&gt; =C2=A0include/qemu/t=
arget-info.h | 16 +++++++++++++++-<br>&gt; =C2=A0target-info.c =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 16 ++++++++++++++++<br>&gt; =C2=A02=
 files changed, 31 insertions(+), 1 deletion(-)<br>&gt;<br>&gt; diff --git =
a/include/qemu/target-info.h b/include/qemu/target-info.h<br>&gt; index 6c5=
b714288e..88ccef2a988 100644<br>&gt; --- a/include/qemu/target-info.h<br>&g=
t; +++ b/include/qemu/target-info.h<br>&gt; @@ -99,10 +99,24 @@ bool target=
_ppc64(void);<br>&gt; =C2=A0 */<br>&gt; =C2=A0bool target_s390x(void);<br>&=
gt;<br>&gt; +/**<br>&gt; + * target_base_riscv:<br>&gt; + *<br>&gt; + * Ret=
urns whether the target architecture is RISC-V 32-bit or 64-bit.<br>&gt; + =
*/<br>&gt; +bool target_base_riscv(void);<br>&gt; +<br>&gt; +/**<br>&gt; + =
* target_riscv32:<br>&gt; + *<br>&gt; + * Returns whether the target archit=
ecture is RISC-V 32-bit.<br>&gt; + */<br>&gt; +bool target_riscv32(void);<b=
r>&gt; +<br>&gt; =C2=A0/**<br>&gt; =C2=A0 * target_riscv64:<br>&gt; =C2=A0 =
*<br>&gt; - * Returns whether the target architecture is riscv64<br>&gt; + =
* Returns whether the target architecture is RISC-V 64-bit.<br>&gt; =C2=A0 =
*/<br>&gt; =C2=A0bool target_riscv64(void);<br>&gt;<br>&gt; diff --git a/ta=
rget-info.c b/target-info.c<br>&gt; index 04c69c41f8a..7ac2260b182 100644<b=
r>&gt; --- a/target-info.c<br>&gt; +++ b/target-info.c<br>&gt; @@ -94,6 +94=
,22 @@ bool target_s390x(void)<br>&gt; =C2=A0 =C2=A0 =C2=A0return target_ar=
ch() =3D=3D SYS_EMU_TARGET_S390X;<br>&gt; =C2=A0}<br>&gt;<br>&gt; +bool tar=
get_base_riscv(void)<br>&gt; +{<br>&gt; + =C2=A0 =C2=A0switch (target_arch(=
)) {<br>&gt; + =C2=A0 =C2=A0case SYS_EMU_TARGET_RISCV32:<br>&gt; + =C2=A0 =
=C2=A0case SYS_EMU_TARGET_RISCV64:<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0ret=
urn true;<br>&gt; + =C2=A0 =C2=A0default:<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =
=C2=A0return false;<br>&gt; + =C2=A0 =C2=A0}<br><br>This can be improved by=
 using =C2=A0(TARGET_ARCH_BITMASK(target_arch()) &amp; QEMU_ARCH_RISCV<br><=
br>TARGET_ARCH_BITMASK should be a new macro in base-arch-defs.h<br>#define=
 TARGET_ARCH_BITMASK(sys_emu) 1UL &lt;&lt; (sys_emu)<br><br><br>And the enu=
m in base-arch-defs.h can be update with this emu, so once the sys_emu maxi=
mal &gt;32 still works in future.<br><br>&gt; +}<br>&gt; +<br>&gt; +bool ta=
rget_riscv32(void)<br>&gt; +{<br>&gt; + =C2=A0 =C2=A0return target_arch() =
=3D=3D SYS_EMU_TARGET_RISCV32;<br>&gt; +}<br>&gt; +<br>&gt; =C2=A0bool targ=
et_riscv64(void)<br>&gt; =C2=A0{<br>&gt; =C2=A0 =C2=A0 =C2=A0return target_=
arch() =3D=3D SYS_EMU_TARGET_RISCV64;<br>&gt; --<br>&gt; 2.43.0<br>&gt;<br>=
&gt;<br><br><br>--<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=E6=AD=A4=E8=87=B4<=
br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=A0 since=
rely,<br>Yonggang Luo</div>

--000000000000ce91ec065a585284--

