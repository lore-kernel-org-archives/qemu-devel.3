Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25B95C369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 00:10:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAHUi-0004Yz-4Q; Wed, 30 Apr 2025 20:09:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uAHUU-0004YU-0v; Wed, 30 Apr 2025 20:09:27 -0400
Received: from mail-vk1-xa2a.google.com ([2607:f8b0:4864:20::a2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uAHUR-00036I-BN; Wed, 30 Apr 2025 20:09:25 -0400
Received: by mail-vk1-xa2a.google.com with SMTP id
 71dfb90a1353d-52403e39a23so239579e0c.2; 
 Wed, 30 Apr 2025 17:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746058161; x=1746662961; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VGWR287rk502mpJ6eDFxHsRwyQheGXy8VqqD8Scs9jk=;
 b=VaFo+6g6Im37ygdbWwGzDpSoJRMduOfzBTc3CjiMkIqOSlAlPTY+sq7cDXHYycE9O9
 L4g7/ec7ghiTWzitljvi2JpA2rxTkKNm9sF9gNEmVL3SeFc5OTcxxV0QKb7eF2ODIF5j
 PlQ/JiM+ZbyhDtBE2U1qH8Z9MtfBqEQ/JDbX9HFQJNw9jqzGb2PzAQt7+AW6zHn2BbX0
 7hkuSbNe3vNcBmlqq7u3KA0kyIgzHL+/mfg1fB2ynithktgR/jQrzwr4V8YCEr6LOznU
 GHMMAbisxVoNkLD/E4b5WDD91O5pvBbG28OWhT5L3PEcsPV75mZxzebjNA7jAaoZ48SS
 pw/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746058161; x=1746662961;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VGWR287rk502mpJ6eDFxHsRwyQheGXy8VqqD8Scs9jk=;
 b=wbeMH7QJqlc20NXTUdQzuWvA2UbpL7QcQYiJ6cw5L7o19RCU2yqxpNkt/8Kp5BF/A3
 4mwEo/cxT75nF7SfzNP9xPhEwiwt60aWAKDaohX2PfU9YqQ0YPpDQ4ESU43A7a7xyMzt
 GIccEn45uLISo8D1h5bTJLa7N75vNjyie28fUgpfs2bbFZtuBBvfRr5S5Lf+ioAKdro5
 MGfgSAloLKCXO6VW3+Cd+acOrjflBi5FtLMawAJrX2rg19fwWvVUpFdiiQK5SarLHM5I
 dVdWY5OD3p/Dw+VbQfnUV0rPYtpVXrDqo9z/leY+IiQgEc+PCEyTWxaU7XE6UQLQyv1o
 RVxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjaAPejvrjgGwCQ0uC4Eh+EbXKb2//IDzRL1NKkQPetpNltqf/cUwg/VxflxKCt658UyDjZW821RIC@nongnu.org
X-Gm-Message-State: AOJu0Yw36ub4ylfo03J7vr7BmZN1Lqxrk4Punxukiv0x5n5rex6CjBoR
 26fkgOhZiD4Sl4ZNEKy0CLB8IzyQG+D7s1ENS6JmP/7Qt4BMP0jLKXVlUBTEbqxH61+wccXecC9
 XJPiCWOI5hsoA+o8ZRPpfQZLW2io=
X-Gm-Gg: ASbGnct6reQEYQhc3JRx4WI5USN57ZEpWk7Q322R3tjemA//eDhjulePFHnDn/ADpgH
 mhF4yz6ia9/rcdEtFSQCr9DmyWcsvfbpZPJd0fZIa5W4cNmvP8SZeyg2KereAW33TVtxr5NktZP
 GBLhcN3+UGH8xPEazqbZ4EXl7zHkTIsgb2L2eKdkh9dnfOgfRieJ8q
X-Google-Smtp-Source: AGHT+IFd9yvqRTRw/iuGnri8XpI7A+lJxD7nD1PbabWRv1DE00Hcyjbya/y+qKZnHDCkbVPFnj7iMq9Vfq+bBBYF1Jc=
X-Received: by 2002:a05:6122:2512:b0:520:62ce:98ed with SMTP id
 71dfb90a1353d-52acd84c18bmr4813758e0c.6.1746058161303; Wed, 30 Apr 2025
 17:09:21 -0700 (PDT)
MIME-Version: 1.0
References: <20250429125811.224803-1-dbarboza@ventanamicro.com>
 <20250429125811.224803-6-dbarboza@ventanamicro.com>
In-Reply-To: <20250429125811.224803-6-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 1 May 2025 10:08:55 +1000
X-Gm-Features: ATxdqUGg-4FePNMes3p0zZIGWwQZhNMHM5BaPKljqxncVci8Ruwtc4ANCculgNg
Message-ID: <CAKmqyKOzOhFauavabidxZgkZUsr3e6RukaWCNCwtW3tVN0P06w@mail.gmail.com>
Subject: Re: [PATCH v2 5/9] hw/riscv/virt.c: use s->memmap in create_fdt() path
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com, 
 joel@jms.id.au
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2a;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2a.google.com
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

On Tue, Apr 29, 2025 at 11:01=E2=80=AFPM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> create_fdt(), create_fdt_flash() and create_fdt_fw_cfg() can access the
> memmap via their RISCVVirtState pointers.
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/virt.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
>
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 37f8abdd1c..5f31c95955 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -995,7 +995,7 @@ static void create_fdt_rtc(RISCVVirtState *s, const M=
emMapEntry *memmap,
>      }
>  }
>
> -static void create_fdt_flash(RISCVVirtState *s, const MemMapEntry *memma=
p)
> +static void create_fdt_flash(RISCVVirtState *s)
>  {
>      MachineState *ms =3D MACHINE(s);
>      hwaddr flashsize =3D s->memmap[VIRT_FLASH].size / 2;
> @@ -1010,11 +1010,11 @@ static void create_fdt_flash(RISCVVirtState *s, c=
onst MemMapEntry *memmap)
>      qemu_fdt_setprop_cell(ms->fdt, name, "bank-width", 4);
>  }
>
> -static void create_fdt_fw_cfg(RISCVVirtState *s, const MemMapEntry *memm=
ap)
> +static void create_fdt_fw_cfg(RISCVVirtState *s)
>  {
>      MachineState *ms =3D MACHINE(s);
> -    hwaddr base =3D memmap[VIRT_FW_CFG].base;
> -    hwaddr size =3D memmap[VIRT_FW_CFG].size;
> +    hwaddr base =3D s->memmap[VIRT_FW_CFG].base;
> +    hwaddr size =3D s->memmap[VIRT_FW_CFG].size;
>      g_autofree char *nodename =3D g_strdup_printf("/fw-cfg@%" PRIx64, ba=
se);
>
>      qemu_fdt_add_subnode(ms->fdt, nodename);
> @@ -1145,7 +1145,7 @@ static void finalize_fdt(RISCVVirtState *s)
>      create_fdt_rtc(s, s->memmap, irq_mmio_phandle);
>  }
>
> -static void create_fdt(RISCVVirtState *s, const MemMapEntry *memmap)
> +static void create_fdt(RISCVVirtState *s)
>  {
>      MachineState *ms =3D MACHINE(s);
>      uint8_t rng_seed[32];
> @@ -1172,7 +1172,8 @@ static void create_fdt(RISCVVirtState *s, const Mem=
MapEntry *memmap)
>       * The "/soc/pci@..." node is needed for PCIE hotplugs
>       * that might happen before finalize_fdt().
>       */
> -    name =3D g_strdup_printf("/soc/pci@%lx", (long) memmap[VIRT_PCIE_ECA=
M].base);
> +    name =3D g_strdup_printf("/soc/pci@%lx",
> +                           (long) s->memmap[VIRT_PCIE_ECAM].base);
>      qemu_fdt_add_subnode(ms->fdt, name);
>
>      qemu_fdt_add_subnode(ms->fdt, "/chosen");
> @@ -1184,8 +1185,8 @@ static void create_fdt(RISCVVirtState *s, const Mem=
MapEntry *memmap)
>
>      qemu_fdt_add_subnode(ms->fdt, "/aliases");
>
> -    create_fdt_flash(s, memmap);
> -    create_fdt_fw_cfg(s, memmap);
> +    create_fdt_flash(s);
> +    create_fdt_fw_cfg(s);
>      create_fdt_pmu(s);
>  }
>
> @@ -1719,7 +1720,7 @@ static void virt_machine_init(MachineState *machine=
)
>              exit(1);
>          }
>      } else {
> -        create_fdt(s, s->memmap);
> +        create_fdt(s);
>      }
>
>      if (virt_is_iommu_sys_enabled(s)) {
> --
> 2.49.0
>
>

