Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EE5DEFCE58
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 03:19:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxzET-0000s5-7y; Wed, 04 Mar 2026 22:18:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vxzES-0000rp-7L
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 22:18:36 -0500
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vxzEQ-0000zR-KA
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 22:18:35 -0500
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-b9372552059so1037712866b.1
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 19:18:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772680713; cv=none;
 d=google.com; s=arc-20240605;
 b=afRHvJ6iBkwR5ml/RwNKcjSdQCAGk+KeoVUIgi64atSZZ2BYI87c6GfxhBd57Ywqfy
 nnvJDaFuQBA2PgFGV1vYQ8hbxxjXxpqf09XcUP5seOTgWlfmN1m44AMe85t6gZENCSI6
 gDcu85n0bWe+P4Rz3Qu10F1i9VAPgZsBLHsN/prjCPhJMbP9WI0veuQMel48YdScpqp7
 np86moHm9/H05XCvhDhNVQduMmM2mPUDAOhbh9fymSr4wPHYd2vcLqwWiYwP6x9E+aev
 ZzKE3jcT5rrL5Q7MgHMl77yQlDbx1aeD0oYOowzY/LNK+EdO024fRojuOGQFVpIeeb7k
 lHtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=RZ9SueSaOP+HPQ4J59QeGSz17z/BstirkdtlH1uRrLY=;
 fh=bWymoCQQYbMHe/WVa4MGCVBkyVOUobjMdsRMeROUKP4=;
 b=dExEQQnKCi3COS3WS3kjEG5ry7CbSbT8JPhEJIRmYrTSg/GWffY7ueLNGkUengfqVo
 yBDHWDQ5/gm/0WA/5nm+cin10qH/vlxWXTYxEhlrhHFBYB9t9X2L6FM3r5UuEmmMNl1w
 GzWQNO6kJSiuURtpgJtX25CeXY3AOoBf0J4mSt5FY6hdJj1RYmE+iXLgY9NCbrudm3FT
 5VJneGNYc9cIVHEx2y1qNhnIzOM9XRE3IF3VI92NgOwHNtWYL/wpJZGxCmytKMM/9ynb
 6wg3v+4uC3dM4bNIR2C76jXvP7Q5ZKFM59scqQW8mFSBqniwpwjTRQ7+dKPl7UQWhRqv
 Q1GA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772680713; x=1773285513; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RZ9SueSaOP+HPQ4J59QeGSz17z/BstirkdtlH1uRrLY=;
 b=bW4uCwRqyrR8RO9+0DvpPq37bm+ww0UvSsoaAAt2AU/A/bRbaYRr4+Cbg1dnD/U83x
 70zqhuc+NxAsRj34pLNHk8uGTnhHRtl7Ydz0P7ztRNzZ+FtnU0r2xdvj/K4Cqk4/2wBr
 XoJ6If1GjHFLmpNElPNX1MRUHV5c4oVNz6Z3YtzSyGc+k6hILGlnAJO4LrUUngUiJCn2
 u+TvmoAluIJa/Lf8H4GTmGFcMRBx37KlR0HvgLw2Y0C/FIduZHdFTCfyiaAcTIBjnT16
 TWzUYmIztQsO3RIZ89mb7zMe3GNKnnZhasO6yLwohJIgAVRzh7sXOf/yTyH3F6VU25jU
 cpZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772680713; x=1773285513;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RZ9SueSaOP+HPQ4J59QeGSz17z/BstirkdtlH1uRrLY=;
 b=wgLK5sjxkUS2ZvPE4apjnzZCPM8YTME24ymq/pWwD3KK5yY98Qj1bPDS9/Q3O0nOoW
 L7hEGXRW26A53gqiuZKHyNTLi2IBGoB5JfI7p6uZUn+pOlU2CrNyQO/1fEc5KaEJ5UWx
 E3FCZ4sPO6xiNvEzGDOSVuNMm07vmEqD718pyeohGBxQxJJGp/ZMWY60egwc6GcH4x2r
 qaJlirtafJPdz4HQqvgZTj5GW7mOhja+/fJMPXlQiHaf6KxhMx//rHB6OL/aWSdqQIct
 XDeqKil6mqVZsTBxsOHArN6pexM6q/AECpgCKxd/HoAqPEZvJiEn9awArm6aXucdJkCK
 qPQA==
X-Gm-Message-State: AOJu0YytS6+B+Dadwr8qTsOVaZsD57wAv9+xGR9yxI2cEyQhoHld+l+N
 wZKK8tEGkRERVzCJMW5yhqzpIdDWzB1PoGVicsooXE2rOT31e6sre4DOM8Lgi7e0yTQQaisyJYg
 RZTdiWZBg2TNdZmqMEl4TgVUlESNjYjc=
X-Gm-Gg: ATEYQzzzsEsZgX/HBVDHPZd6DtgL4VeX1SSZuUI4C+f90okHK+SNFNqwoDqiOaNkMfe
 U//pbjJ+v3i+5cqYP0CtoPHssS6Tg9sWN6ixzXfijMnPx49DIRtTORNldBiBced09dxhI7vrd7N
 aFntoLikZgNvgJQxyUpxkmMPXYyJzYrxJpBl9FROx5k/0LNrJyNWWRlAI9otqe/HZPeACRlNECS
 amYW/VDuqW8U/w7M0IpUax6wyVoMi6A2zcPYjris6cD5K84XC0yl2NoVzokia25IipZC1dP2a5Z
 n4ZRMrUJSuQ000Ezy5xp6J50kCG+oVGWe0nFGQ==
X-Received: by 2002:a17:906:ef06:b0:b73:8639:334a with SMTP id
 a640c23a62f3a-b93f11efe06mr250504166b.13.1772680712914; Wed, 04 Mar 2026
 19:18:32 -0800 (PST)
MIME-Version: 1.0
References: <20260227232838.23392-1-philmd@linaro.org>
In-Reply-To: <20260227232838.23392-1-philmd@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 5 Mar 2026 13:18:06 +1000
X-Gm-Features: AaiRm51Bwl9wNEETey4KjRBQFLmIArVosB7CTxnoA2KcFsxwP_pN6j3_X6mFTJU
Message-ID: <CAKmqyKPBtet+2HuXKV20aS6ktYnrqYhZJak7xyM2rKqXV71wzQ@mail.gmail.com>
Subject: Re: [PATCH] hw/riscv: Remove deprecated 'riscv,
 delegate' device-tree property
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Alistair Francis <alistair.francis@wdc.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Conor Dooley <conor@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Weiwei Li <liwei1518@gmail.com>, 
 qemu-riscv@nongnu.org, Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Anup Patel <anup.patel@oss.qualcomm.com>, devel@lists.libvirt.org, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x62e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Sat, Feb 28, 2026 at 9:29=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> The "riscv,delegate" DT property was added in QEMU 7.0 as part of
> the AIA APLIC support.  The property changed name during the
> review process in Linux and the correct name ended up being
> "riscv,delegation". The incorrect name was added as alias, and
> deprecated in v9.1 (commit 38facfa8432), so can be removed for
> v11.0.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> Binary file pc-bios/opensbi-riscv32-generic-fw_dynamic.bin matches
> Binary file pc-bios/opensbi-riscv64-generic-fw_dynamic.bin matches
> ---
>  docs/about/deprecated.rst       | 11 -----------
>  docs/about/removed-features.rst | 11 +++++++++++
>  hw/riscv/virt.c                 |  9 ---------
>  3 files changed, 11 insertions(+), 20 deletions(-)
>
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 1d5c4f3707c..cc5502e5394 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -494,17 +494,6 @@ versions, aliases will point to newer CPU model vers=
ions
>  depending on the machine type, so management software must
>  resolve CPU model aliases before starting a virtual machine.
>
> -RISC-V "virt" board "riscv,delegate" DT property (since 9.1)
> -''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
> -
> -The "riscv,delegate" DT property was added in QEMU 7.0 as part of
> -the AIA APLIC support.  The property changed name during the review
> -process in Linux and the correct name ended up being
> -"riscv,delegation".  Changing the DT property name will break all
> -available firmwares that are using the current (wrong) name.  The
> -property is kept as is in 9.1, together with "riscv,delegation", to
> -give more time for firmware developers to change their code.
> -
>  x86 "isapc" board use of modern x86 CPUs (since 10.2)
>  '''''''''''''''''''''''''''''''''''''''''''''''''''''
>
> diff --git a/docs/about/removed-features.rst b/docs/about/removed-feature=
s.rst
> index 41bec8b8e38..0a62e87ee35 100644
> --- a/docs/about/removed-features.rst
> +++ b/docs/about/removed-features.rst
> @@ -1232,6 +1232,17 @@ converting to using TCG plugins they should contac=
t the qemu-devel
>  mailing list.
>
>
> +Firmware, ACPI, Device Tree
> +---------------------------
> +
> +RISC-V "virt" board "riscv,delegate" DT property (removed in 11.0)
> +''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
> +
> +The "riscv,delegate" DT property was added in QEMU 7.0 as part of
> +the AIA APLIC support.  The property changed name during the review
> +process in Linux and the correct name ended up being "riscv,delegation".
> +
> +
>  System emulator devices
>  -----------------------
>
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index bbce2fb6671..a1c323e66df 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -666,15 +666,6 @@ static void create_fdt_one_aplic(RISCVVirtState *s, =
int socket,
>          qemu_fdt_setprop_cells(ms->fdt, aplic_name, "riscv,delegation",
>                                 aplic_child_phandle, 0x1,
>                                 VIRT_IRQCHIP_NUM_SOURCES);
> -        /*
> -         * DEPRECATED_9.1: Compat property kept temporarily
> -         * to allow old firmwares to work with AIA. Do *not*
> -         * use 'riscv,delegate' in new code: use
> -         * 'riscv,delegation' instead.
> -         */
> -        qemu_fdt_setprop_cells(ms->fdt, aplic_name, "riscv,delegate",
> -                               aplic_child_phandle, 0x1,
> -                               VIRT_IRQCHIP_NUM_SOURCES);
>      }
>
>      riscv_socket_fdt_write_id(ms, aplic_name, socket);
> --
> 2.52.0
>
>

