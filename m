Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03E39C48286
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 02:58:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWpB9-0006v4-JK; Sun, 04 Feb 2024 21:57:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rWpB8-0006qe-8l; Sun, 04 Feb 2024 21:57:50 -0500
Received: from mail-vs1-xe31.google.com ([2607:f8b0:4864:20::e31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rWpB6-0006i5-NO; Sun, 04 Feb 2024 21:57:49 -0500
Received: by mail-vs1-xe31.google.com with SMTP id
 ada2fe7eead31-46d103dcbbfso200184137.0; 
 Sun, 04 Feb 2024 18:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707101867; x=1707706667; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gE1bY3Bo7lm2hO1swUesC9QOTBBfTqTESn7nn0mEH0o=;
 b=WP82g0md3nml1iSi47TxR0xSxnqrfGdvLuA71IGQFy7BWUA144DypD2HWIawEIU/K2
 7KU8Kf6Fuf7+a60zZcIwxcyzp+cDkcCDN1bZkK2RpiY6yXelCqiWXv9bUYKnl6M2xA52
 HQWhLCAIUu4dEv1HRaH1l4+y46am/CW4nitKjT10E4/wPqNtzEflb3ULbobpueSrE4m6
 QAr4eF1TTT7GRLL/pVvnOyVKeeUL5z1TecReN0/uaSuYMeGwXRS8tgZWb1/U8k4FHVWJ
 qyj3EDIabbGujjcZRvVCpfAo6CWZjr9PZ3d7XOBPNWPVDZJcb1nnz0pBKG1MeOSDysCA
 cQiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707101867; x=1707706667;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gE1bY3Bo7lm2hO1swUesC9QOTBBfTqTESn7nn0mEH0o=;
 b=PeQ8T0ErziZ5ZIR92TSaSVli0B+gNmE1x2p9nebjEJflPpLkrqnR4TrEU5sDAGLsii
 MvqksU18jQqJTvzvnnHZPCkB2S84gR7RiDgrY4E5W43ziPwonAbyj5M+PW3+RBL1yro6
 Q/EGDXQm39ZOP68PHWH9wf+nMgAKaFlgCO40fYQnyIHpm4HhcLucW+npxqcuOwTX+dYc
 45Z0luvumj26EATuL5ry9jZrPuY3duNCzitoeWVG34Auni3m8M7Nd0SkEVp25hbQvIM1
 6BzUYF6r4VultGxlzOcvU05xZCtC4lpCg4DU97G58u7Np2N6Nz/JbmpSqlM7tQqOrSOk
 WKhQ==
X-Gm-Message-State: AOJu0YzC6z3NIsGCmb0j9hy7wwXvig6qGwl9vP/5qyjZsbLYIS0luynv
 i3HgWg8P3fowUkBF/dhcZHwsoILNAsBCiGsBk4Aqu+bwX04Z4KNuq6UvlCzFFyoc983qR2QlI7x
 gYbcCPGnb7aAIW/6RB8rtAgolhng=
X-Google-Smtp-Source: AGHT+IFaeRM3jgZzPfxY6WmAeRj0Te18zrl1QGnInU2opuNB2b84aEJV9jDDPuJ1GVu/lLGoxKL/T9v8dpsRpTBZjRI=
X-Received: by 2002:a05:6102:214e:b0:46b:2e8:4ada with SMTP id
 h14-20020a056102214e00b0046b02e84adamr5455012vsg.18.1707101867285; Sun, 04
 Feb 2024 18:57:47 -0800 (PST)
MIME-Version: 1.0
References: <20240122221529.86562-1-dbarboza@ventanamicro.com>
 <20240122221529.86562-2-dbarboza@ventanamicro.com>
In-Reply-To: <20240122221529.86562-2-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 5 Feb 2024 12:57:21 +1000
Message-ID: <CAKmqyKPBihDR1c5vSZ_WYF6Mu3FJ+KmYnjLJ_HrSVNZmjpywaA@mail.gmail.com>
Subject: Re: [PATCH 1/7] hw/riscv/virt-acpi-build.c: fix leak in build_rhct()
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e31;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe31.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Jan 23, 2024 at 8:16=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> The 'isa' char pointer isn't being freed after use.
>
> Issue detected by Valgrind:
>
> =3D=3D38752=3D=3D 128 bytes in 1 blocks are definitely lost in loss recor=
d 3,190 of 3,884
> =3D=3D38752=3D=3D    at 0x484280F: malloc (vg_replace_malloc.c:442)
> =3D=3D38752=3D=3D    by 0x5189619: g_malloc (gmem.c:130)
> =3D=3D38752=3D=3D    by 0x51A5BF2: g_strconcat (gstrfuncs.c:628)
> =3D=3D38752=3D=3D    by 0x6C1E3E: riscv_isa_string_ext (cpu.c:2321)
> =3D=3D38752=3D=3D    by 0x6C1E3E: riscv_isa_string (cpu.c:2343)
> =3D=3D38752=3D=3D    by 0x6BD2EA: build_rhct (virt-acpi-build.c:232)
> =3D=3D38752=3D=3D    by 0x6BD2EA: virt_acpi_build (virt-acpi-build.c:556)
> =3D=3D38752=3D=3D    by 0x6BDC86: virt_acpi_setup (virt-acpi-build.c:662)
> =3D=3D38752=3D=3D    by 0x9C8DC6: notifier_list_notify (notify.c:39)
> =3D=3D38752=3D=3D    by 0x4A595A: qdev_machine_creation_done (machine.c:1=
589)
> =3D=3D38752=3D=3D    by 0x61E052: qemu_machine_creation_done (vl.c:2680)
> =3D=3D38752=3D=3D    by 0x61E052: qmp_x_exit_preconfig.part.0 (vl.c:2709)
> =3D=3D38752=3D=3D    by 0x6220C6: qmp_x_exit_preconfig (vl.c:2702)
> =3D=3D38752=3D=3D    by 0x6220C6: qemu_init (vl.c:3758)
> =3D=3D38752=3D=3D    by 0x425858: main (main.c:47)
>
> Fixes: ebfd392893 ("hw/riscv/virt: virt-acpi-build.c: Add RHCT Table")
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/virt-acpi-build.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
> index 26c7e4482d..fb8baf64f6 100644
> --- a/hw/riscv/virt-acpi-build.c
> +++ b/hw/riscv/virt-acpi-build.c
> @@ -196,7 +196,7 @@ static void build_rhct(GArray *table_data,
>      RISCVCPU *cpu =3D &s->soc[0].harts[0];
>      uint32_t mmu_offset =3D 0;
>      uint8_t satp_mode_max;
> -    char *isa;
> +    g_autofree char *isa =3D NULL;
>
>      AcpiTable table =3D { .sig =3D "RHCT", .rev =3D 1, .oem_id =3D s->oe=
m_id,
>                          .oem_table_id =3D s->oem_table_id };
> --
> 2.43.0
>
>

