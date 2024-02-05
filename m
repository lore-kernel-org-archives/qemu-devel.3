Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8668FC4828F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 03:01:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWpES-00026n-09; Sun, 04 Feb 2024 22:01:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rWpEO-00024a-De; Sun, 04 Feb 2024 22:01:12 -0500
Received: from mail-ua1-x92a.google.com ([2607:f8b0:4864:20::92a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rWpEM-0007G6-Pt; Sun, 04 Feb 2024 22:01:12 -0500
Received: by mail-ua1-x92a.google.com with SMTP id
 a1e0cc1a2514c-7d2e16b552dso2155130241.1; 
 Sun, 04 Feb 2024 19:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707102069; x=1707706869; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3LNgssURtU2eL15SG/1cplyUyt+T0ldXgnI28rz2gxo=;
 b=ILEKIRgkuK/pxBYwBeGRk1SvkLNPGKtrxUsGjaf+OHT9wKoJC2vXTheAfq0PVFu9No
 i2dEjK35AVFOPQc7SJ1Jfcv6OuyqEAz5PBR7vcFsDTuI4zEnCSuFI02Ccs67QmiPgNov
 C7+2VhizAN2ZgKXbZGvg+8MuPfclBpMlX+gypH117DzLD+Ou8iwpN80VQpv50xJjrvwl
 uh+9urfXAkCU/joFe3crQjBE53GzkC/n9V5kRnH31+isihl1v8u2Bc+p5hknYn7CqGqM
 SUP1pSOEIWyMZruLN9yJ4HyIdQRFBVj5rqGdXH6T2rgZ5kj/D2MkY02sx6q4HdWviPr1
 jipg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707102069; x=1707706869;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3LNgssURtU2eL15SG/1cplyUyt+T0ldXgnI28rz2gxo=;
 b=YJGm8so+AitMhHEjo64NGAaRCJBq+1OQkSBUVopjunomoPIfHXHOFp1qmS/JyRySqq
 xNYV6KTqkR+OaFHOC92qpz0TMNIT+ibdap3SI0Hb+DId/vPhx2uC89KMcO2v59cc1mX0
 Di9xxpgtP06La722jYuLGE0rhlFDBGnOQ8G8GLHOae8xL4oc6Haijig6RwRgR1lCckeL
 JyzO9QJjZGEgNThIZ/nwNUSP19rWTIt1aqTXkZWu5SogxAoOTqghYK7agSHVYSrNYYMW
 9tWqAZEGh4aXbBXcmpKYYhELUekDhwEBe5fucqCrUiSoLV0E1vJMFxxpIYcae/PMLQOl
 s2pg==
X-Gm-Message-State: AOJu0Yycramp+I3SBzdX6YYM976M/3UiMtf0RWGj8coOzyKmWCf1W/+8
 npnnJ+kvF/F3EyadgDCEvGSXKiXweUfww9y5ko9PWOqhc7ow5JEZrobRkFvvzmZJcR/tez/ffXf
 yNO3Cms4FCsbfKIWwVFPE6JAJ3T27UY+bwws=
X-Google-Smtp-Source: AGHT+IFLEx+0ob65SRoUJ1e20nmpdKXHtyh3UQtPknFyxCx5k1nCsycrGfYV+65tquhSTPiuP9Q/fyyvdQYLyJ8txNM=
X-Received: by 2002:a67:cf4a:0:b0:46d:1a19:26f1 with SMTP id
 f10-20020a67cf4a000000b0046d1a1926f1mr3103298vsm.34.1707102069261; Sun, 04
 Feb 2024 19:01:09 -0800 (PST)
MIME-Version: 1.0
References: <20240122221529.86562-1-dbarboza@ventanamicro.com>
 <20240122221529.86562-7-dbarboza@ventanamicro.com>
In-Reply-To: <20240122221529.86562-7-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 5 Feb 2024 13:00:43 +1000
Message-ID: <CAKmqyKNO=r9PJqMf-VAJ99L0=1iHKXm56OKgpxO-KBcsqgX00A@mail.gmail.com>
Subject: Re: [PATCH 6/7] hw/riscv/virt.c: use g_autofree in virt_machine_init()
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92a;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92a.google.com
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
> Move 'soc_name' to the loop, and give it g_autofree, to avoid the manual
> g_free().
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/virt.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index f8278df83f..710fbbda2c 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -1356,7 +1356,6 @@ static void virt_machine_init(MachineState *machine=
)
>      RISCVVirtState *s =3D RISCV_VIRT_MACHINE(machine);
>      MemoryRegion *system_memory =3D get_system_memory();
>      MemoryRegion *mask_rom =3D g_new(MemoryRegion, 1);
> -    char *soc_name;
>      DeviceState *mmio_irqchip, *virtio_irqchip, *pcie_irqchip;
>      int i, base_hartid, hart_count;
>      int socket_count =3D riscv_socket_count(machine);
> @@ -1376,6 +1375,8 @@ static void virt_machine_init(MachineState *machine=
)
>      /* Initialize sockets */
>      mmio_irqchip =3D virtio_irqchip =3D pcie_irqchip =3D NULL;
>      for (i =3D 0; i < socket_count; i++) {
> +        g_autofree char *soc_name =3D g_strdup_printf("soc%d", i);
> +
>          if (!riscv_socket_check_hartids(machine, i)) {
>              error_report("discontinuous hartids in socket%d", i);
>              exit(1);
> @@ -1393,10 +1394,8 @@ static void virt_machine_init(MachineState *machin=
e)
>              exit(1);
>          }
>
> -        soc_name =3D g_strdup_printf("soc%d", i);
>          object_initialize_child(OBJECT(machine), soc_name, &s->soc[i],
>                                  TYPE_RISCV_HART_ARRAY);
> -        g_free(soc_name);
>          object_property_set_str(OBJECT(&s->soc[i]), "cpu-type",
>                                  machine->cpu_type, &error_abort);
>          object_property_set_int(OBJECT(&s->soc[i]), "hartid-base",
> --
> 2.43.0
>
>

