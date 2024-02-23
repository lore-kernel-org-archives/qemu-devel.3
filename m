Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EEABC48BC4
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 04:34:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdNGR-000722-Vx; Thu, 22 Feb 2024 23:34:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rdNGO-00071n-FJ
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 23:34:20 -0500
Received: from mail-vk1-xa34.google.com ([2607:f8b0:4864:20::a34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rdNGN-0000ub-2f
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 23:34:20 -0500
Received: by mail-vk1-xa34.google.com with SMTP id
 71dfb90a1353d-4d051349124so82992e0c.2
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 20:34:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708662857; x=1709267657; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JAcC19M6kdOWNd9j+msaEeihBzE1KfPTxWh8Cr9aJ5Q=;
 b=mtWJro9gggjEu7eEDg/V5UvyggHMAJo1eqEkldD/KjCr2pEK8EuG/ux3E6Dh4tHNs9
 c131a7lskGajmwhiGFQyRR3qZ1ujk1XbXEIydpwK50lUQlmbZT91z7xLt+V4iVOxHORA
 LaeM+qAb5IDt/U05aCli/cXLs94HpkOOkqIYjmBJuiwYg86xTxT01ygXxb9RokfsnrNf
 UKuvlbJmFfP7W+C84DNosC/UA9r+En0FWN7u7sVITj7R+/YXDnt3SPio8WgO+hUtFHNc
 BL+CBq81COC8O5mpEO445i0bnPr1gd2DCBqJ2RgI3vHmwFWURp9z2Dw1t0cWUbI4hnfN
 6/tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708662857; x=1709267657;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JAcC19M6kdOWNd9j+msaEeihBzE1KfPTxWh8Cr9aJ5Q=;
 b=lkHlk5irjg/DGX380PUHk9tfZc4O1TptNvZKGPz5himKEaYLuUPJaDaxU1NCWlcgE1
 0MrKHfCqX0Dv5WTxpwvk22S7ByBzxDjtOI+tfVSm4GOdstylkCB+kKNjppui2weqvsgA
 gQrxN46FgaMj9lUgjReefsZaLsJFLz3bA2NwD/gtv9Hgx8xWkwaCJWDeZIy05PrUYKek
 QkOFwH4OAGfEYKgjPt5wreRq3Ogt/88z3nHY0CYt3MU2VJkYL5Qaayi5xwxFolpR1A/P
 YXXZEE4hiss/MNiiagtG+2Dq1psyJ7SsSBDjNK54RaFeGweWx+FEyraY/Hg4iTiKzxyP
 eiWA==
X-Gm-Message-State: AOJu0YygvMO+7jFOJxwaf0K2CeIFbHO5v3/iq2EK69OlPCMqTmsQcS+T
 8DDnHbCmbE5enpyrCDNLdHmsfs80BKNhx3walJUA6mkNqOIyZl/J9hSZh7PfSGSz2FJboYxx+F6
 Lv4qWn4Z7QDGhvLGJgmKG1FLy/xo=
X-Google-Smtp-Source: AGHT+IEOldC6TwBmWovC4quj0ZnuH52wmOJn06K1h6fYq8D9HbpH9qw1f5WDmgyibCj4FWGzNVKkhoRD+beOSkceDOs=
X-Received: by 2002:a1f:5583:0:b0:4ca:80c5:752e with SMTP id
 j125-20020a1f5583000000b004ca80c5752emr985079vkb.5.1708662857208; Thu, 22 Feb
 2024 20:34:17 -0800 (PST)
MIME-Version: 1.0
References: <180d236d-c8e4-411a-b4d2-632eb82092fa@list.ru>
In-Reply-To: <180d236d-c8e4-411a-b4d2-632eb82092fa@list.ru>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 23 Feb 2024 14:33:50 +1000
Message-ID: <CAKmqyKOO+yVgsjzeLm6ForGEwU0T_S_K0P7_a6tok2SHK43LdA@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: fix ACPI MCFG table
To: X512 <danger_mail@list.ru>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a34;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa34.google.com
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

On Tue, Feb 20, 2024 at 2:10=E2=80=AFAM X512 via <qemu-devel@nongnu.org> wr=
ote:
>
> MCFG segments should point to PCI configuration range, not BAR MMIO.
>
> Signed-off-by: Ilya Chugin <danger_mail@list.ru>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>   hw/riscv/virt-acpi-build.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
> index fb8baf64f6..fe01b626ea 100644
> --- a/hw/riscv/virt-acpi-build.c
> +++ b/hw/riscv/virt-acpi-build.c
> @@ -558,8 +558,8 @@ static void virt_acpi_build(RISCVVirtState *s,
> AcpiBuildTables *tables)
>       acpi_add_table(table_offsets, tables_blob);
>       {
>           AcpiMcfgInfo mcfg =3D {
> -           .base =3D s->memmap[VIRT_PCIE_MMIO].base,
> -           .size =3D s->memmap[VIRT_PCIE_MMIO].size,
> +           .base =3D s->memmap[VIRT_PCIE_ECAM].base,
> +           .size =3D s->memmap[VIRT_PCIE_ECAM].size,
>           };
>           build_mcfg(tables_blob, tables->linker, &mcfg, s->oem_id,
>                      s->oem_table_id);
> --
> 2.42.1
>
>

