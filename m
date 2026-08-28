Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CBA1C61DBD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 09:52:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wztFx-0002h1-Va; Fri, 28 Aug 2026 05:52:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1wztFw-0002gY-SL
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 05:52:16 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1wztFu-0003qi-UN
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 05:52:16 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-c160420289bso112868166b.0
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 02:52:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787910733; cv=none;
 d=google.com; s=arc-20260327;
 b=hf3QZoeUp3HVWtxNVDKfdMx+dg6DP2ELzM/0rNlfem812yAgH0Z5FrRJcTQSprIEaO
 dja/cIi25p8oHJUajly0UyYq5Yvr9Tu0g1Nf8PtOaQ3ORxEhnzVhKTnJ61PFkTPHeXyN
 reYFddSrrmHkr1V6NTbRfW/y8EpyZ7XHi6YsAKSt0WhnxiLqd+gC90yyxeTHBr09jSBS
 qlVGmhTgXEns4HflbvtIG9pN1t8iCuNFUpoPssUbysLfhG2CgGwPWOzs0b79/qfDuAjP
 2GD4TEwTxJnwwH4v4O6p52y1dWoiINmgt3Mu+VfO+k9YzUmaEB+vuv+GREvJTXkk13jN
 TRDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
 :mime-version:dkim-signature;
 bh=IcIjNrUAkd4ujMAOwdVdWFS8R76eSaZH4WFCI7a3bNY=;
 fh=9mwyWOpK54iJC8aLtzCKDeGN9smrR+H4CobDsaMoCBU=;
 b=YgtBrcvcFRu9EdD0K+7qpg9u7YfYJ9bL3dKAux4zHqwkLH/jjD/UCVz8Av5GfXoI5i
 yL0JgguDGeRvLl9DFmEsJyiULs5n1ZVT8D3GSWaQK64X3UbZ4DJy2V8zfUwg00n/2WQ0
 ah7O/sTrVNpXtxLMAvw/ohSxTVhW0LCP00kRkej6d6QRTImPMHH7fOg1yAuZW3H/mQEZ
 yf5Ms5K6SPDrlY7gR4eessMZ/A3ej9rGHE7GFAICjTrBXibubGsuxXKPqeDqVZqEVPyF
 6gFuN8bbYxD5As4RDrALD+CEouV12udzNEr2PyHDJim1Vs3aeGC7UiS9qagvmNbAFGxv
 qxCA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787910733; x=1788515533; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:reply-to
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IcIjNrUAkd4ujMAOwdVdWFS8R76eSaZH4WFCI7a3bNY=;
 b=chcItkNQ4IAWPvsCTFq5OwiAyC28VrfUII7Apc1Sg69WUCFI9fhB61iPdeQTFFjYuX
 Y8qEbmblC/dHDiak6vfIsJyj42IjTAyQs4Huh1EDMBn5tzjL8ye9RPqgRG2GOLQeaDLe
 HtCmSs7ukBkvSTlh6Ja/nxNUXryxwbQmg1r7QNLNqQTxwon2OAYPjuix0RsLwIu7TBH3
 tomdT69NqfwBoQnzLjBetgyg7E/IAy4YYnLBKg1Pg54NqWExIDw+TdC7fmoJAZiRo7wY
 Ahm/sEiTNkmGbOSm/swG1E+1f97tiKuOIPv6pYCJ9rEXzhO4LPwwtZfmwZCFGAVkQQuJ
 HHNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787910733; x=1788515533;
 h=content-type:cc:to:subject:message-id:date:from:reply-to
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=IcIjNrUAkd4ujMAOwdVdWFS8R76eSaZH4WFCI7a3bNY=;
 b=QpeySeSHMhGPeJbvxuLTrPtEZERST1Gua6ktFAs9H91b0YuKfxlnvNTmTYR6BCf/v8
 T9Huw7vvFTTzJkIKEKlOPGNp8dro1s5eEl3UND9iTQBBzcsvqSwP+zU5r3NqILB62/BV
 o3neNZeNXzgy87ApQmZtAZdZVZTLP6FdKmiLfdJuY4BTn8ZpHSybRn75bor0cxm2qFC6
 hENe73NUuOd53XuzkDqUwCOWk8xjtPUaSfzjuuG2QFztcxTbUeT5iy2QkFjZS4VSYvgh
 +iuX1jZMwduVlVdDIGkzl+Dy8m7JSVsI9GY7X8YH7tGpshYKoml8l95d2NaV8jJklVIF
 rsew==
X-Gm-Message-State: AFuF++nSIAmy+QQCamgYf6eA5JaegR38GHsSbb1c7hqA6Opkf5tuusHq
 98avTKy0vV8glQVeJ8Y3MZ3umh0GTMgwv1RfBapkLBBJDHEydxufsX7HQwR7JT6dX0MqTbFn9BB
 53ukTKGkP7BGvUS82thSNTRJo4WnOs9w=
X-Gm-Gg: AR+sD13L+kS3OyK5sCwFRWqkpUIlsWpLVCyyVyjtI8coEWq9KfqX9qTmM+60HgYkIo9
 x8YPMQDusQz6wgAttqUEfklbNzXlO23xkEfqiIFTHDPg8iBMYQrwWc6hJ/dUu7nndX41lvmgD6R
 WDCmL5FGE4+IbSjQjo0dCE9BbplJectntqqscpredeL/AT3eOSuk/uPtWkr3le+XDX+yiBcEIiK
 wfcSM306sDfZRUfty86S2Eb4jEx2oqzE4KVgPIhyCuoRetTwgI43gWXXmcNmg1SQZQlQppbUf/Z
 UTgnX3lGl5eyRlUbmD4vILlENu4WOoIckpd7fN6Lcmt7Ig==
X-Received: by 2002:a17:906:4fd2:b0:c15:e8c8:340 with SMTP id
 a640c23a62f3a-c255741a367mr337707566b.23.1787910733116; Fri, 28 Aug 2026
 02:52:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260724000948.234657-1-pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20260724000948.234657-1-pierrick.bouvier@oss.qualcomm.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Fri, 28 Aug 2026 17:51:59 +0800
X-Gm-Features: AcwNN1WjvWZmRn1AF7aRX8NJBF-OGf3o-v15QMyyRa8WVRy6vtf0YVDu2JLGZ6s
Message-ID: <CAE2XoE8g0nAJPoJvjZGR_KpEAo+C+S7+QTdZGhagBQE_diDXcw@mail.gmail.com>
Subject: Re: [PATCH 00/27] single-binary: implement dynamic filtering for
 machine types
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Bernhard Beschow <shentey@gmail.com>, 
 Anton Johansson <anjo@rev.ng>, Alistair Francis <alistair@alistair23.me>, 
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Content-Type: multipart/alternative; boundary="000000000000233bba065a1868d3"
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=luoyonggang@gmail.com; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_KAM_HTML_FONT_INVALID=0.01 autolearn=ham autolearn_force=no
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

--000000000000233bba065a1868d3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026 at 8:11=E2=80=AFAM Pierrick Bouvier <
pierrick.bouvier@oss.qualcomm.com> wrote:
>
> Now that we can link a single-binary with at least two targets (arm,
aarch64),
> we want to make sure that we expose the same set of machines (later
devices and
> cpus) than target binaries. For that, we implemented a static filtering
based on
> target interfaces that each machine will implement to declare which
targets have
> this machine.
>
> However, we discovered that this static filtering is not enough. Indeed,
some
> machines and devices do not depend only on target, and their presence can
depend
> on Kconfig or host/target combination. Thus, our static approach can't
work, and
> we need something more flexible.
>
> This series adds a new TYPE_TARGET_SPECIFIC, that declare a single
function
> bool is_available(void). From there, any machine type (and later devices
and
> cpus) can implement it to override their presence for each target.
> We first replace the existing static mechanism with this, and once done,
we
> cleanup all the old interface. One nice benefit is that we can get rid of
> config/targets/*.c files, which saves duplication.


  About target-filtering, we already have

enum {
    QEMU_ARCH_ALPHA =3D       (1UL << SYS_EMU_TARGET_ALPHA),
    QEMU_ARCH_ARM =3D         (1UL << SYS_EMU_TARGET_ARM) |
                            (1UL << SYS_EMU_TARGET_AARCH64),
    QEMU_ARCH_I386 =3D        (1UL << SYS_EMU_TARGET_I386) |
                            (1UL << SYS_EMU_TARGET_X86_64),
    QEMU_ARCH_M68K =3D        (1UL << SYS_EMU_TARGET_M68K),
    QEMU_ARCH_MICROBLAZE =3D  (1UL << SYS_EMU_TARGET_MICROBLAZE),
    QEMU_ARCH_MIPS =3D        (1UL << SYS_EMU_TARGET_MIPS) |
                            (1UL << SYS_EMU_TARGET_MIPSEL) |
                            (1UL << SYS_EMU_TARGET_MIPS64) |
                            (1UL << SYS_EMU_TARGET_MIPS64EL),
    QEMU_ARCH_PPC =3D         (1UL << SYS_EMU_TARGET_PPC) |
                            (1UL << SYS_EMU_TARGET_PPC64),
    QEMU_ARCH_S390X =3D       (1UL << SYS_EMU_TARGET_S390X),
    QEMU_ARCH_SH4 =3D         (1UL << SYS_EMU_TARGET_SH4) |
                            (1UL << SYS_EMU_TARGET_SH4EB),
    QEMU_ARCH_SPARC =3D       (1UL << SYS_EMU_TARGET_SPARC) |
                            (1UL << SYS_EMU_TARGET_SPARC64),
    QEMU_ARCH_XTENSA =3D      (1UL << SYS_EMU_TARGET_XTENSA) |
                            (1UL << SYS_EMU_TARGET_XTENSAEB),
    QEMU_ARCH_OR1K =3D        (1UL << SYS_EMU_TARGET_OR1K),
    QEMU_ARCH_TRICORE =3D     (1UL << SYS_EMU_TARGET_TRICORE),
    QEMU_ARCH_HPPA =3D        (1UL << SYS_EMU_TARGET_HPPA),
    QEMU_ARCH_RISCV =3D       (1UL << SYS_EMU_TARGET_RISCV32) |
                            (1UL << SYS_EMU_TARGET_RISCV64),
    QEMU_ARCH_RX =3D          (1UL << SYS_EMU_TARGET_RX),
    QEMU_ARCH_AVR =3D         (1UL << SYS_EMU_TARGET_AVR),
    QEMU_ARCH_HEXAGON =3D     (1UL << SYS_EMU_TARGET_HEXAGON),
    QEMU_ARCH_LOONGARCH =3D   (1UL << SYS_EMU_TARGET_LOONGARCH64),
    QEMU_ARCH_ALL =3D         UINT32_MAX,
};

Can we use this to do target filtering instead? And we can extend this to
maximal uint128_t to support maximal 128 targets in future, so it's not a
burden to use it as a enum

and for arm or mips we can use QEMU_ARCH_ARM QEMU_ARCH_MIPS  to support
multiple targets in a single integer.



--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000233bba065a1868d3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div><br></div><div><br>On Fri, Jul 24, 2=
026 at 8:11=E2=80=AFAM Pierrick Bouvier &lt;<a href=3D"mailto:pierrick.bouv=
ier@oss.qualcomm.com" target=3D"_blank">pierrick.bouvier@oss.qualcomm.com</=
a>&gt; wrote:<br>&gt;<br>&gt; Now that we can link a single-binary with at =
least two targets (arm, aarch64),<br>&gt; we want to make sure that we expo=
se the same set of machines (later devices and<br>&gt; cpus) than target bi=
naries. For that, we implemented a static filtering based on<br>&gt; target=
 interfaces that each machine will implement to declare which targets have<=
br>&gt; this machine.<br>&gt;<br>&gt; However, we discovered that this stat=
ic filtering is not enough. Indeed, some<br>&gt; machines and devices do no=
t depend only on target, and their presence can depend<br>&gt; on Kconfig o=
r host/target combination. Thus, our static approach can&#39;t work, and<br=
>&gt; we need something more flexible.<br>&gt;<br>&gt; This series adds a n=
ew TYPE_TARGET_SPECIFIC, that declare a single function<br>&gt; bool is_ava=
ilable(void). From there, any machine type (and later devices and<br>&gt; c=
pus) can implement it to override their presence for each target.<br>&gt; W=
e first replace the existing static mechanism with this, and once done, we<=
br>&gt; cleanup all the old interface. One nice benefit is that we can get =
rid of<br>&gt; config/targets/*.c files, which saves duplication.</div><div=
><br></div><div><br></div><div>=C2=A0 About target-filtering, we already ha=
ve=C2=A0<div><br>enum {<br>=C2=A0 =C2=A0 QEMU_ARCH_ALPHA =3D =C2=A0 =C2=A0 =
=C2=A0 (1UL &lt;&lt; SYS_EMU_TARGET_ALPHA),<br>=C2=A0 =C2=A0 QEMU_ARCH_ARM =
=3D =C2=A0 =C2=A0 =C2=A0 =C2=A0 (1UL &lt;&lt; SYS_EMU_TARGET_ARM) |<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 (1UL &lt;&lt; SYS_EMU_TARGET_AARCH64),<br>=C2=A0 =C2=
=A0 QEMU_ARCH_I386 =3D =C2=A0 =C2=A0 =C2=A0 =C2=A0(1UL &lt;&lt; SYS_EMU_TAR=
GET_I386) |<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (1UL &lt;&lt; SYS_EMU_TARGET_X86_64)=
,<br>=C2=A0 =C2=A0 QEMU_ARCH_M68K =3D =C2=A0 =C2=A0 =C2=A0 =C2=A0(1UL &lt;&=
lt; SYS_EMU_TARGET_M68K),<br>=C2=A0 =C2=A0 QEMU_ARCH_MICROBLAZE =3D =C2=A0(=
1UL &lt;&lt; SYS_EMU_TARGET_MICROBLAZE),<br>=C2=A0 =C2=A0 QEMU_ARCH_MIPS =
=3D =C2=A0 =C2=A0 =C2=A0 =C2=A0(1UL &lt;&lt; SYS_EMU_TARGET_MIPS) |<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 (1UL &lt;&lt; SYS_EMU_TARGET_MIPSEL) |<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 (1UL &lt;&lt; SYS_EMU_TARGET_MIPS64) |<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (1UL &lt;&lt; SYS_EMU_TARGET_MIPS64EL),<br>=C2=A0 =C2=A0 QEMU_ARCH_P=
PC =3D =C2=A0 =C2=A0 =C2=A0 =C2=A0 (1UL &lt;&lt; SYS_EMU_TARGET_PPC) |<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 (1UL &lt;&lt; SYS_EMU_TARGET_PPC64),<br>=C2=A0 =C2=
=A0 QEMU_ARCH_S390X =3D =C2=A0 =C2=A0 =C2=A0 (1UL &lt;&lt; SYS_EMU_TARGET_S=
390X),<br>=C2=A0 =C2=A0 QEMU_ARCH_SH4 =3D =C2=A0 =C2=A0 =C2=A0 =C2=A0 (1UL =
&lt;&lt; SYS_EMU_TARGET_SH4) |<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (1UL &lt;&lt; SYS_=
EMU_TARGET_SH4EB),<br>=C2=A0 =C2=A0 QEMU_ARCH_SPARC =3D =C2=A0 =C2=A0 =C2=
=A0 (1UL &lt;&lt; SYS_EMU_TARGET_SPARC) |<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (1UL =
&lt;&lt; SYS_EMU_TARGET_SPARC64),<br>=C2=A0 =C2=A0 QEMU_ARCH_XTENSA =3D =C2=
=A0 =C2=A0 =C2=A0(1UL &lt;&lt; SYS_EMU_TARGET_XTENSA) |<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 (1UL &lt;&lt; SYS_EMU_TARGET_XTENSAEB),<br>=C2=A0 =C2=A0 QEMU_AR=
CH_OR1K =3D =C2=A0 =C2=A0 =C2=A0 =C2=A0(1UL &lt;&lt; SYS_EMU_TARGET_OR1K),<=
br>=C2=A0 =C2=A0 QEMU_ARCH_TRICORE =3D =C2=A0 =C2=A0 (1UL &lt;&lt; SYS_EMU_=
TARGET_TRICORE),<br>=C2=A0 =C2=A0 QEMU_ARCH_HPPA =3D =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(1UL &lt;&lt; SYS_EMU_TARGET_HPPA),<br>=C2=A0 =C2=A0 QEMU_ARCH_RISCV =
=3D =C2=A0 =C2=A0 =C2=A0 (1UL &lt;&lt; SYS_EMU_TARGET_RISCV32) |<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 (1UL &lt;&lt; SYS_EMU_TARGET_RISCV64),<br>=C2=A0 =C2=A0 Q=
EMU_ARCH_RX =3D =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(1UL &lt;&lt; SYS_EMU_TAR=
GET_RX),<br>=C2=A0 =C2=A0 QEMU_ARCH_AVR =3D =C2=A0 =C2=A0 =C2=A0 =C2=A0 (1U=
L &lt;&lt; SYS_EMU_TARGET_AVR),<br>=C2=A0 =C2=A0 QEMU_ARCH_HEXAGON =3D =C2=
=A0 =C2=A0 (1UL &lt;&lt; SYS_EMU_TARGET_HEXAGON),<br>=C2=A0 =C2=A0 QEMU_ARC=
H_LOONGARCH =3D =C2=A0 (1UL &lt;&lt; SYS_EMU_TARGET_LOONGARCH64),<br>=C2=A0=
 =C2=A0 QEMU_ARCH_ALL =3D =C2=A0 =C2=A0 =C2=A0 =C2=A0 UINT32_MAX,<br>};<br>=
<br>Can we use this to do target filtering instead? And we can extend this =
to maximal uint128_t to support maximal 128 targets in future, so it&#39;s =
not a burden to use it as a enum</div><div><br></div><div>and for arm or mi=
ps we can use=C2=A0<span style=3D"background-color:transparent">QEMU_ARCH_A=
RM</span><span style=3D"background-color:transparent">=C2=A0</span><span st=
yle=3D"background-color:transparent">QEMU_ARCH_MIPS</span><span style=3D"ba=
ckground-color:transparent">=C2=A0 to support multiple targets in a single =
integer.</span></div><div><br></div></div><div><br></div><div><br>--<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=E6=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=BD=97=
=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=A0 sincerely,<br>Yonggang Luo</di=
v></div>
</div>

--000000000000233bba065a1868d3--

