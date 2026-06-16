Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87B46CD8CA8
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 03:24:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZKOb-0004SX-29; Mon, 15 Jun 2026 23:23:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZKOY-0004SC-Gy
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 23:23:22 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZKOW-0004Bv-P2
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 23:23:22 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-68f36e1663cso6873923a12.3
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 20:23:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781580199; cv=none;
 d=google.com; s=arc-20240605;
 b=U+ECJPQZsbLelcuGRoks/IL5m/4qA/2loDz9SIFgw01wRDP38KFwWJrqoRkUgj5s7M
 9P5IGyn9xUBA2XgKwaaXPRSegAW2r7PYzH5wrIClh3RQQyPvbEhDuFn+SLk3E9Sendtf
 ftJxmSgWPLhpiG/Ai34flivjDERgm5jQEcNcojFV3b+7XqsPiBMV05ZGH59FBh1bsyZq
 TMp6Yg9LKKKrbnrI/mdv3ffNHCl7Ri3FLEDWstzoW2zhiQQ71Uq4YRqrMwtpvKzC6DLH
 Cs93W8mGm8TwIasExA5VNK9x2Aby2lVzCev8Bz6IvZE2IMRjLuAtqJ+8fwQJhB50UNOm
 rDUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=o2Z2xEWOBlSFmesIitEHCJ1aKsohbF3cWDR5xCgzxuc=;
 fh=y/39rxWsHsSIhiCgFyox46bvYsAfNaBS3wRFv9pkMrs=;
 b=M4kbKKT8E9Ig4QW/3kQyjq62G83DuzzztnxYQkibFPYDmXRiGVpMYexbDcZ4xbrL2E
 c5C+v7rzVEbjGL3ViS6vg2mQmngwMrNINaNOsQLYmbAIJDC1rDRmGmceSusrW2wQNY4v
 c1ooh8cQ5rfNdGRAZeA/ARXkXXaJsgoLUtAtwscOQZNgrhpBsTOThaBZVrTrwq1eggOw
 EMCXsyZDcsXC/aLvOjp9DHlcSrm6bBZzUCVkpOFU7dIUTyWg120pBkG0OMqGrW+IgaYT
 kb9onkFxyW/8xUghlVRpIYF9P2qt3EGNKlnXG6jrwZG0u1rHEFsiRsGFzmphIwmBx58a
 wvkg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781580199; x=1782184999; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o2Z2xEWOBlSFmesIitEHCJ1aKsohbF3cWDR5xCgzxuc=;
 b=Erj0hI7JHjfLSJzAajA3n2YmeCaH+RO8V/loOjRdbR7+EgssYsb5cX0x9BepXe5RA0
 aol3Dn8ijhj0nFngzHxb/+P/lzy7Fjgn/iu7ixnS3ykk18oJiCih3VUcHsK/yAXUOBCD
 Z5z1pPPffSUSr6EzkKc4Z8FZ34cFL24OsqYdsNDlJRy6eG/K3xv+VTUae+0oNKNdzJfD
 f3mStvr+PE7JPnhQzA+2RpHGxaRLzOiUjkpTn7QcmrkHYYgRjyGJI6K/RbDBY/L5Ykz7
 AoG3BevAE+LiUooJG4wkyhc7folf2EmUqm+yrg5T1d4urunVFC5A4E5jX2IrDb7Ua4Dp
 LfUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781580199; x=1782184999;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=o2Z2xEWOBlSFmesIitEHCJ1aKsohbF3cWDR5xCgzxuc=;
 b=tKFjuo6cZZOYG0I3AyAWoEmyzBaiYYZdtCJND5Zo6+/Yh9EXXAtrrcNXfYyId1Hd6C
 HK1bKy5i9C9DSPiGhYbWl/td/dIuqK9t5PlXu+ONyVUOYroGV1lydCgGZ14hpoFKPRei
 zGHUTnH8ywQfGw1OvObw8SLDLxoCV1QiY6S74fD7mfRtPZRs9gOZHWa7QueUDFfTlinT
 VKfjSrsYugf0TwM9xWzLjQQURSc4hq26pKc6EJlILGbwfBQlehTpL8zk6p6rE989dDM6
 3GBHX73CaytGsQHNPuBZfG5A/UpAOoS4C1ArYGERgcB8EOv2L0ZQoW3ZM2CBiP8COt9H
 3VyA==
X-Gm-Message-State: AOJu0YxoEckulYH8trAU4i1T5/ZNuhO75C1TeNMt6JkfbLcQ8g3FikuQ
 GWBCZV+zGXmuQCiV/wfDsuGHdnuxWMbvwseuPXBfQj/OF7CjqfJmWMqmUNclYRuvUNwjwE2S3+i
 qz+v1DCfgh/S+VBAnV0V/huhoAxnzQ6I=
X-Gm-Gg: Acq92OGjihJ0wB8aJbZVjP5rmNHqSAFXHxHkDf6jp51eEioRmdHDQ4oI11rUkOjU3ZT
 HCtWU067UdeP5LKdsUNdcGjJPIa9gh/5N/bwsThocK3C/YDw3Nucu9R0Z2U2UIWNDchiCDmKClQ
 s3zfsNzdITG5UH7DMwCCzgbTwGnMx9O4ZrIUfFZkTcozuOc6Sj/McRWl0EUI1Alt6fbeohhDRb9
 Sg8+oWSs4itRTYuxxBs0ooV9XS84EdhrPMKBP/5aKARXVi+gkEWwvgHCB+rNmgWZX0+66ZHr+kk
 A+wljrWXseovXWai1/2q/Z2H9JFDW3ShRgS8oXF5MHKDs6ya
X-Received: by 2002:a05:6402:5208:b0:691:956a:cf72 with SMTP id
 4fb4d7f45d1cf-6950874c0a7mr769622a12.17.1781580198588; Mon, 15 Jun 2026
 20:23:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260615203734.954428-1-daniel.barboza@oss.qualcomm.com>
 <20260615203734.954428-14-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260615203734.954428-14-daniel.barboza@oss.qualcomm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 16 Jun 2026 13:22:51 +1000
X-Gm-Features: AVVi8Cf4z7TQoLZ5xaj2sgMUkciOAJ9xCSVN_OuR-tVoy8rifVTJX0ueZaykFDA
Message-ID: <CAKmqyKPzA5gEq3U_rzY9KNML=Mj15kLcYw26AhDzxFAEVM7_Nw@mail.gmail.com>
Subject: Re: [PATCH 13/13] hw/riscv: add create_fdt_socket_cpu_sifive()
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com, 
 Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x534.google.com
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

On Tue, Jun 16, 2026 at 6:39=E2=80=AFAM Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
> This sifive_u only helper shares DT code with other boards.  The idea is
> to reduce code repetition while keeping sifive_u characteristics in
> place.
>
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/fdt-common.c         | 11 +++++++++++
>  hw/riscv/sifive_u.c           | 24 +++---------------------
>  include/hw/riscv/fdt-common.h |  4 ++++
>  3 files changed, 18 insertions(+), 21 deletions(-)
>
> diff --git a/hw/riscv/fdt-common.c b/hw/riscv/fdt-common.c
> index 70168ad657..b27ff13bca 100644
> --- a/hw/riscv/fdt-common.c
> +++ b/hw/riscv/fdt-common.c
> @@ -189,3 +189,14 @@ void create_fdt_socket_cpus(void *fdt, RISCVCPU *soc=
ket_harts,
>                                         is_32_bit);
>      }
>  }
> +
> +void
> +create_fdt_socket_cpu_sifive(void *fdt, char *clust_name,
> +                             int cpu_id, int socket_id,
> +                             int socket_hartid_base, uint32_t *phandle,
> +                             uint32_t *intc_phandles)
> +{
> +    create_fdt_socket_cpu_internal(fdt, clust_name, NULL, cpu_id,
> +                                   socket_id, socket_hartid_base,
> +                                   phandle, intc_phandles, false, false)=
;
> +}
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index 27c1a74d99..0c6e4204cb 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -145,12 +145,9 @@ static void create_fdt(SiFiveUState *s, const MemMap=
Entry *memmap,
>      qemu_fdt_add_subnode(fdt, clust_name);
>
>      for (cpu =3D ms->smp.cpus - 1; cpu >=3D 0; cpu--) {
> -        int cpu_phandle =3D phandle++;
>          nodename =3D g_strdup_printf("/cpus/cpu@%d", cpu);
> -        char *intc =3D g_strdup_printf("/cpus/cpu@%d/interrupt-controlle=
r", cpu);
> -        g_autofree char *core_name =3D NULL;
> -
>          qemu_fdt_add_subnode(fdt, nodename);
> +
>          /* cpu 0 is the management hart that does not have mmu */
>          if (cpu !=3D 0) {
>              if (is_32_bit) {
> @@ -162,25 +159,10 @@ static void create_fdt(SiFiveUState *s, const MemMa=
pEntry *memmap,
>          } else {
>              riscv_isa_write_fdt(&s->soc.e_cpus.harts[0], fdt, nodename);
>          }
> -        qemu_fdt_setprop_string(fdt, nodename, "compatible", "riscv");
> -        qemu_fdt_setprop_string(fdt, nodename, "status", "okay");
> -        qemu_fdt_setprop_cell(fdt, nodename, "reg", cpu);
> -        qemu_fdt_setprop_string(fdt, nodename, "device_type", "cpu");
> -        qemu_fdt_setprop_cell(fdt, nodename, "phandle", cpu_phandle);
> -
> -        intc_phandles[cpu] =3D phandle++;
> -
> -        qemu_fdt_add_subnode(fdt, intc);
> -        qemu_fdt_setprop_cell(fdt, intc, "phandle", intc_phandles[cpu]);
> -        qemu_fdt_setprop_string(fdt, intc, "compatible", "riscv,cpu-intc=
");
> -        qemu_fdt_setprop(fdt, intc, "interrupt-controller", NULL, 0);
> -        qemu_fdt_setprop_cell(fdt, intc, "#interrupt-cells", 1);
>
> -        core_name =3D g_strdup_printf("%s/core%d", clust_name, cpu);
> -        qemu_fdt_add_subnode(fdt, core_name);
> -        qemu_fdt_setprop_cell(fdt, core_name, "cpu", cpu_phandle);
> +        create_fdt_socket_cpu_sifive(fdt, clust_name, cpu, 0, 0,
> +                                     &phandle, intc_phandles);
>
> -        g_free(intc);
>          g_free(nodename);
>      }
>
> diff --git a/include/hw/riscv/fdt-common.h b/include/hw/riscv/fdt-common.=
h
> index 3af9d5c3fd..2d6b9a5d03 100644
> --- a/include/hw/riscv/fdt-common.h
> +++ b/include/hw/riscv/fdt-common.h
> @@ -26,4 +26,8 @@ void create_fdt_socket_cpus(void *fdt, RISCVCPU *socket=
_harts,
>                              int socket_hartid_base, uint32_t *phandle,
>                              uint32_t *intc_phandles, bool numa_enabled,
>                              bool is_32_bit);
> +void create_fdt_socket_cpu_sifive(void *fdt, char *clust_name,
> +                                  int cpu_id, int socket_id,
> +                                  int socket_hartid_base, uint32_t *phan=
dle,
> +                                  uint32_t *intc_phandles);
>  #endif
> --
> 2.43.0
>
>

