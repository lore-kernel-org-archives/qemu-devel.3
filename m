Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04991C48286
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 03:00:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWpDn-00010u-QA; Sun, 04 Feb 2024 22:00:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rWpDl-0000yI-DV; Sun, 04 Feb 2024 22:00:33 -0500
Received: from mail-vk1-xa2f.google.com ([2607:f8b0:4864:20::a2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rWpDj-00078Z-OJ; Sun, 04 Feb 2024 22:00:33 -0500
Received: by mail-vk1-xa2f.google.com with SMTP id
 71dfb90a1353d-4c01c53efe5so435838e0c.2; 
 Sun, 04 Feb 2024 19:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707102030; x=1707706830; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BMAEtdSR744ai5RLEUVVCNdEPtj/m9Eolqt67R1BYy8=;
 b=nTi48Z4L7nZk6DAwRKB3U10F3/MoFx09kh0eoquRUqYiQ/JcX9LRAmbws99v3rXTGJ
 OATAa/qyit828vPuCt4/JpqfasU1cNqFDbfwTP5trjo6lt3LKZ9t6xwOZ7b0foz2K7Fz
 pCck38EbGvqSif/9ML/9avtHzae8lF1bY161R2RltJ1BB34cZEJVDsimJjm68omyTezK
 NVkWOYANPlE65KXlNG0MLOjlbiqJ72dIa1fVT2xZo/u7xDJge42uV113PCZ9Tu8zmHJj
 8kJirP7Cb2R31J/geeL0APUQAYhAAK9faGX4KKICs//cxivr14bNJCmBLZBY8hE05klA
 lUlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707102030; x=1707706830;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BMAEtdSR744ai5RLEUVVCNdEPtj/m9Eolqt67R1BYy8=;
 b=UVxe8I50Ukr8p+IbVoMuRqug8IAYwJtPzu4neTuxz9wCMNYb9gV+v0Ykt1xcfDEPE5
 rMQrfKy/qaNXhs0TBL+dn5KxLKgcpoNEcZie3Q/IQUNRPKzr2VjzRpo6HGUVfCXvyN04
 0/kMDQEh/b26apK3dJHyKbXg1z+sCi9WFbVCHW06ljT1x7zTfzTCDmhZ5z4Xzc+DP5YM
 57lEdypwrVWGVOV5i0oqe3MfBYDPHJcEb49HemG2u1fiYNfMbqXQF6rpxsx4wgiCjL7C
 y98NKh3jb4kW0xEM4bIsnD7yOU2UzwLUIkGosB4/14SHFgDMjTTAqKN/ujejc6b2I+gx
 VSYg==
X-Gm-Message-State: AOJu0YyrD9HqZZkNjFxWReCUsARWoHP4q7iQEKQJdMozgEbgo0HkyVjB
 bZ9gOzBEMLv8N/DKnS8KYEKe73HfkJQjT1Xo4AP3ol7/QdakqZPzChkuVSV+usbwCPpt0+iNuL9
 nJZOdGbrqN60sTB76F5HDexiJE9g=
X-Google-Smtp-Source: AGHT+IGoh7HAx+qtMXnTINp7vKcApRAcHacTl8lMz7MGy9RU2CBQMNgoiX85fgKvDvQ3bFK8SBfMoIqM2wVt6fqaAmM=
X-Received: by 2002:a05:6122:4a0f:b0:4c0:ab8:d7d0 with SMTP id
 ez15-20020a0561224a0f00b004c00ab8d7d0mr6541386vkb.12.1707102029435; Sun, 04
 Feb 2024 19:00:29 -0800 (PST)
MIME-Version: 1.0
References: <20240122221529.86562-1-dbarboza@ventanamicro.com>
 <20240122221529.86562-6-dbarboza@ventanamicro.com>
In-Reply-To: <20240122221529.86562-6-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 5 Feb 2024 13:00:02 +1000
Message-ID: <CAKmqyKPMxDpJ3eA-GN+k2TdTzaCFFSTX_PErJsfMSoqB7sUM9g@mail.gmail.com>
Subject: Re: [PATCH 5/7] hw/riscv/virt.c: use g_autofree in create_fdt_virtio()
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2f;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2f.google.com
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

On Tue, Jan 23, 2024 at 9:38=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Put 'name' declaration inside the loop, with g_autofree, to avoid
> manually doing g_free() in each iteration.
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/virt.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index d0f402e0d5..f8278df83f 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -820,12 +820,12 @@ static void create_fdt_virtio(RISCVVirtState *s, co=
nst MemMapEntry *memmap,
>                                uint32_t irq_virtio_phandle)
>  {
>      int i;
> -    char *name;
>      MachineState *ms =3D MACHINE(s);
>
>      for (i =3D 0; i < VIRTIO_COUNT; i++) {
> -        name =3D g_strdup_printf("/soc/virtio_mmio@%lx",
> +        g_autofree char *name =3D  g_strdup_printf("/soc/virtio_mmio@%lx=
",
>              (long)(memmap[VIRT_VIRTIO].base + i * memmap[VIRT_VIRTIO].si=
ze));
> +
>          qemu_fdt_add_subnode(ms->fdt, name);
>          qemu_fdt_setprop_string(ms->fdt, name, "compatible", "virtio,mmi=
o");
>          qemu_fdt_setprop_cells(ms->fdt, name, "reg",
> @@ -840,7 +840,6 @@ static void create_fdt_virtio(RISCVVirtState *s, cons=
t MemMapEntry *memmap,
>              qemu_fdt_setprop_cells(ms->fdt, name, "interrupts",
>                                     VIRTIO_IRQ + i, 0x4);
>          }
> -        g_free(name);
>      }
>  }
>
> --
> 2.43.0
>
>

