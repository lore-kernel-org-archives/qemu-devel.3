Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D336AC5AD49
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 04:23:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOU27-0004NO-Ix; Mon, 09 Jun 2025 00:22:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uOU0a-0004JW-I9; Mon, 09 Jun 2025 00:21:19 -0400
Received: from mail-vk1-xa35.google.com ([2607:f8b0:4864:20::a35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uOU0Y-0001Ml-Ar; Mon, 09 Jun 2025 00:21:16 -0400
Received: by mail-vk1-xa35.google.com with SMTP id
 71dfb90a1353d-53082f1ac34so1158503e0c.3; 
 Sun, 08 Jun 2025 21:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749442872; x=1750047672; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kra0+ZGnz6eZ/VYDHoTAiWa1HciiE69IkFZbru0VOcc=;
 b=letGbTtxZ6h6ANiDzYhzhldMUIU7F4a6oKZGU1SZ6xQElvFS68+qIz331shjFJ4jD0
 +HSaRGvlOXv/hXMMgkg9viaIiQ7GsgDrsy91Y7KevjmX0Ln5PUsuUqHCZtEWVlV3azyo
 yEIb9AOfXbLJlF7QNl/RScWl4EhMNmNEa4NgqHbMrXEMIyYHgvVqQT0N4CNiukMD94Kr
 bpzJhvG+fBXYRyyVQPx8LlYEDVyJaU/EsgJD5q/rVtAvTgTXSidVWLa4Mm8aMLV3lrJ6
 FGTH+lhy231RRsX3xwNf0V2XLW3gr2XDxVBoDQ74FSLtEIW1RCVKAERxdK/vMNWv6kGD
 rswQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749442872; x=1750047672;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kra0+ZGnz6eZ/VYDHoTAiWa1HciiE69IkFZbru0VOcc=;
 b=lCI47g2E3fYEBDC9j/NCrsA54MVFKEnSbdCLu4e/nvyhRP/dKPm0p5wBctMKr9wvF+
 IrETp7m08V9PiwAuZop/5c2PF1IopK7/08YXwIgRs2451hNQW/+rJEp4N+ByX6ce5K/r
 oKdfe9BM7tuDQU+GfURGWXcZn/U+cumfZoZBIl0rz/4TANlpu9VJmQcep+E1EgkNCt6m
 9LF4K84eWQGb1tyWBmmAWDY8tSRKdrDZmfSxY0U19q5YK1dtrHFsF3Brx57zUIEHbEtI
 Q3EtbUUp9OV/DCZ65Kz/3N04ddnk3tx9rajHyE0K+a9OOQhNWpID+x+NqytEuiRFSPFW
 6BRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0/ZHF/qO5kR9hSW7i0PlYEMcgWLqD/GjdHDlPE0lYf39FMD8VzlEB/GyzyKqeyY7R2y5NKRs0uZNg@nongnu.org,
 AJvYcCW6EWYAKq68y31TehScDe4dN45L8dwYslBamsVm1es+gvZVt/ajAuQVo+frr4j0fPQuIMh9lyGJhFbeag==@nongnu.org
X-Gm-Message-State: AOJu0YzBkt3ltJwfQwPqBLWeqjnHF60mVvofxPK7TR0fKTcbpf4KOs8U
 YDLwhXTCpIWFMuUIVE1eK+5RHs2pfruu5sS6bmAWUslsmAzRXHdJwRMWRVVD+o71VlG9ZeGa0oI
 G9Ee091Gdz1ixFvugPdbtevQysgl4zL+cdw==
X-Gm-Gg: ASbGncvH+ryqOvLTa1EF01ER8lZ5chPsk6E+zHsga2/BYf91QPfjvAglSG/BFQt4HLm
 lrioz63f0eMZOuGUWS62SclhHfMVHXhgTfZj6ZslsEzZgQIysqS+LRq48mjsv3HFpyVb72TbCBt
 oAJAtcSaTJK5ps8bPbH7AsevcOoZnShRVhbG9NyeXmVtUJq7BDSEX7hBlef8m+dlOZOZVz1+pNt
 A==
X-Google-Smtp-Source: AGHT+IEFaHtVP6hm3LqujuNZiTL6tuuj/UaAXG7CzqceUszLINWLKu/xHK+rnMoUppxNKIX1SeHj9u0hMNJ+Cdys5SE=
X-Received: by 2002:a05:6122:1e14:b0:520:61ee:c815 with SMTP id
 71dfb90a1353d-530e48c0441mr8045529e0c.10.1749442872144; Sun, 08 Jun 2025
 21:21:12 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1749224867.git.chao.liu@yeah.net>
In-Reply-To: <cover.1749224867.git.chao.liu@yeah.net>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 9 Jun 2025 14:20:46 +1000
X-Gm-Features: AX0GCFvqC4w30xvklVr_TkpAgY1VcnLOkfi2q-YmtWo0UYdVVUUnb1IP0h2KLy0
Message-ID: <CAKmqyKMvMkEAdB=f4zDcZPg+xoXL-qtjDS1+FfnozqOcpNG=ng@mail.gmail.com>
Subject: Re: [PATCH v5 0/1] fix the way riscv_plic_hart_config_string() gets
 the CPUState
To: Chao Liu <chao.liu@yeah.net>
Cc: dbarboza@ventanamicro.com, palmer@dabbelt.com, 
 zhiwei_liu@linux.alibaba.com, alistair.francis@wdc.com, liwei1518@gmail.com, 
 zhangtj@tecorigin.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a35;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa35.google.com
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

On Sat, Jun 7, 2025 at 12:12=E2=80=AFPM Chao Liu <chao.liu@yeah.net> wrote:
>
> Hi,
>
> Thanks to Daniel's testing, I have fixed this bug.
>
> PATCHv5:
>
> The differences are as follows:
>
> ```
> @@ -790,10 +790,11 @@ static void sifive_u_soc_realize(DeviceState *dev, =
Error **errp)
>      MemoryRegion *mask_rom =3D g_new(MemoryRegion, 1);
>      MemoryRegion *l2lim_mem =3D g_new(MemoryRegion, 1);
>      char *plic_hart_config;
> -    int hartid_base =3D 1;
>      int i, j;
>
>      qdev_prop_set_uint32(DEVICE(&s->u_cpus), "num-harts", ms->smp.cpus -=
 1);
> -    qdev_prop_set_uint32(DEVICE(&s->u_cpus), "hartid-base", hartid_base)=
;
> +    qdev_prop_set_uint32(DEVICE(&s->u_cpus), "hartid-base", 1);
>
> ...
> @@ -829,7 +829,7 @@ static void sifive_u_soc_realize(DeviceState *dev, Er=
ror **errp)
>
> -    plic_hart_config =3D riscv_plic_hart_config_string(hartid_base, ms->=
smp.cpus);
> +    plic_hart_config =3D riscv_plic_hart_config_string(0, ms->smp.cpus);
> ```
>
> s->u_cpus use (ms->smp.cpus - 1), but plic_hart_config use ms->smp.cpus,
> so the same hartid-base should not be used.
>
> Therefore, we should keep the original implementation here.
>
> PS:
>
> During my testing, I encountered a small issue, although riscv64_tuxrun p=
assed
> the test, it still displayed a timeout. When I removed my patch,
> the result was still the same.
>
> PATCH v4:
>
> Rebasing this on
> https://github.com/alistair23/qemu/tree/riscv-to-apply.next
>
> PATCH v3:
>
> Use cpu_by_arch_id() instead of qemu_get_cpu(), when registering gpio in
> sifive_plic_create().
>
> PATCH v2:
>
> During plic initialization, CPUSate is obtained by traversing qemu_get_cp=
u(),
> which was an early design flaw (see PATCH v1 reviewed).
>
> A better approach is to use riscv's hartid for indexing via the cpu_by_ar=
ch_id()
> interface.
>
> PATCH v1 (Reviewed):
> https://lore.kernel.org/qemu-riscv/416e68f4-bf12-4218-ae2d-0246cc8ea8ec@l=
inaro.org/T/#u
>
> --
> Regards,
> Chao
>
> Chao Liu (1):
>   hw/riscv: fix PLIC hart topology configuration string when not getting
>     CPUState correctly
>
>  hw/intc/sifive_plic.c      | 4 ++--
>  hw/riscv/boot.c            | 4 ++--
>  hw/riscv/microchip_pfsoc.c | 2 +-
>  hw/riscv/sifive_u.c        | 2 +-
>  hw/riscv/virt.c            | 2 +-
>  include/hw/riscv/boot.h    | 2 +-
>  6 files changed, 8 insertions(+), 8 deletions(-)

Thanks!

Applied to riscv-to-apply.next

Alistair

>
> --
> 2.49.0
>

