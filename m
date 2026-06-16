Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6AD8CD98D2
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 03:18:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZKJa-0002q4-8E; Mon, 15 Jun 2026 23:18:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZKJX-0002jG-F8
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 23:18:11 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZKJV-0002wO-EP
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 23:18:11 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-69165354c87so5162072a12.3
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 20:18:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781579887; cv=none;
 d=google.com; s=arc-20240605;
 b=TPXou4yWlpEImxAlIRiafuNQnObjnuS6u5hHFkV0V5Ri5+1tAPZGXpheHZ1TnoV5IQ
 tANHIXi7VAx71j/XCF4eAbSozAsTNtG9I4t7BZihCYHSV7OkvnfJpOqJHx+iEC6v0eAH
 pRFpYNXVAwO5OnBu/D6Gskdl5bgX7ZNqDz0swB5mBGkU56Yj2abEcxF1hZwdCxEBdhbH
 QIldCeSDkiOGisOqRTveS7u9vXnbK7BR2n3ew7/eGSbd4Zo75YPk9I2Chf1MkJPqhN2/
 1Jx34CLPWo2sQkemuHV2FwFC2kzncRt5KHjlQ0+6Emm/nNw1RnWOOYbUg5ANAYIN4uMt
 l0uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=28Us3OtjLsZPjxnsnqSSJ2z18NlJpoQ18PAbwK0xbUg=;
 fh=y/39rxWsHsSIhiCgFyox46bvYsAfNaBS3wRFv9pkMrs=;
 b=AKXvnIFJo66w/s6DrM9nEKZsBk0QXGfCNiIFpjH12gBWl67fEVvlShU4CGD/UzrLFQ
 4OE/MZAVzvBpesdcXBg3sDSfa44zO0ts8q4ceBLIKsSoabbGE8ITHjfLa1jadOoR4AJf
 KYK5oUuNAtM5qaoAmr/X8pqlRBR0TheoA/9JOMgcpwXo40evAA4zVURxMtEKbfM7jyLG
 +bIjlGtd1w2GDLB0AIIM8K5+0P1GJ/GDsmAcGpWCXWlnrW8M+eXJn/kvsfedLr80okP3
 6AOXGTfLEGhmuyVt8xOKuZjBfxukjlnAbWEpr3KZ4lm8r1b0E5/SO5Ye6fD4Wg+L9crj
 W+tA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781579887; x=1782184687; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=28Us3OtjLsZPjxnsnqSSJ2z18NlJpoQ18PAbwK0xbUg=;
 b=lz7uqt+e7eIwmIPzvfnNyw7Y5hAbkFPikFCId6E1nGYN4DkewNwK0SAiPsXN2Lcj3O
 1u6c1guKt2KWf8LA/1WLTpru/67/PxzA2Vby6UoFL2DyqjFGsDXn+lrbqnwPn4O4K5d1
 zQkD2cIRcOj8kF3D87q7zA+GssvSBj3kMJJfhXX/NzkVHPGwumYySE5HRqAHiAirQUVh
 +ekI87zRm6hbU/XrI+TDmiDvmDulhypJGPp4lQSFrJ6Bo9/xltXYij8HdPvhcKUC0ahk
 J73cVfi0DK2Fs+Yb3m0f/xkvMZuVgxzgul3kXpXYNbKY6Lmq5qy76kHdO7wvhFU3b2Zj
 5WLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781579887; x=1782184687;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=28Us3OtjLsZPjxnsnqSSJ2z18NlJpoQ18PAbwK0xbUg=;
 b=jy//6TrKCSC91Q0UgszzmTQwYgKh6/f83qVrETtPGHbH1uZF7PwuKoUVnWd+RJiB0N
 4vU7s9Hnqjf1AzcgtqRAvoC6ihBRZqlM6APHQn3HfZ8TYUt2L/gbw7qnRaoZ4TLiR4R3
 9LPy0POr5YIRFsjChZr/9c9ICZknZxzKiCDMDTYogUYZsNbqQcBVigB3pBFjSVK42+L4
 pql5eFl0yurzCT3q9C6gW6ki4mRFRexuvRHDHuNbTHQQ8ESDY5RWuhALxVXFNVN2APXV
 4++otnzcfw2JKa+XjhCZhudCzH9lgQc0EGT5JoqM5nUOtHSbO7IuNVIQdQ77xivn+Ury
 XZTg==
X-Gm-Message-State: AOJu0Yzh1SL1FAEg11GCpuVrvYQ91K19AahKrcxvklNGVNm+G5ccyvtG
 GWRSdwoyjYKaN5+PzWrZknSXK3mmB5Rkzl1oUx/IID+1QzV+pZp5UfKpwqTlR3E/w0JgDYNMQo+
 NzjfCZCWoI5aJVVy56aQxUCOG9ZGdDt8=
X-Gm-Gg: Acq92OHNj9cg4HCLgA7VgY6J0dbQD/mC3deESUYk+HRyjr3IQq/UBwrLZkehANH3Ecl
 t86TkvRnemBBfolRMVjlweWubIHzrvEJ8Scrs6dyuDipDNiAtxUE66/UuM4Dg4w7FFyzf7+P24D
 aj+bfeX1GxcruMyU0TBaxFpWPPG9DJpdWBxJg/rT6NsBjTXqtke3pqLEXuxEo/sT0DRctXLqRyP
 8ven/tfTmekn/63MhRfHnYj3y52dCx462RpvUSHQVAgkdzFOxND1kg933aAjAChNL5+oZhNibxO
 kmSp2h+aNtqPDbsW6KV678YDfLYCo1LjSZ+l1g==
X-Received: by 2002:a05:6402:51c6:b0:68d:d511:4a9f with SMTP id
 4fb4d7f45d1cf-695087ce2d9mr769887a12.18.1781579886774; Mon, 15 Jun 2026
 20:18:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260615203734.954428-1-daniel.barboza@oss.qualcomm.com>
 <20260615203734.954428-11-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260615203734.954428-11-daniel.barboza@oss.qualcomm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 16 Jun 2026 13:17:39 +1000
X-Gm-Features: AVVi8CfXvRy27KNs_aVlEeYRTmMlEvNF-RYuCAQ8gaz4XIsbcYtKzHbe0fycCI0
Message-ID: <CAKmqyKN-Sy77vbEVMj2S_63152Xbjg_uGUhbphbQt6wa2zHG6g@mail.gmail.com>
Subject: Re: [PATCH 10/13] hw/riscv: add create_fdt_socket_cpus()
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com, 
 Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x529.google.com
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

On Tue, Jun 16, 2026 at 6:42=E2=80=AFAM Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
> Consolidate the creation of CPUs socket FDT in a helper that can be
> shared across all boards.
>
> The code was basically moved from the function with the same name from
> 'virt.c', with additional bits to create the cluster subnode beforehand.
>
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/fdt-common.c         | 74 +++++++++++++++++++++++++++++++
>  hw/riscv/virt.c               | 83 +++--------------------------------
>  include/hw/riscv/fdt-common.h |  7 +++
>  3 files changed, 87 insertions(+), 77 deletions(-)
>
> diff --git a/hw/riscv/fdt-common.c b/hw/riscv/fdt-common.c
> index 02ac9ddcd8..6c795409a4 100644
> --- a/hw/riscv/fdt-common.c
> +++ b/hw/riscv/fdt-common.c
> @@ -93,3 +93,77 @@ void fdt_create_cpu_socket_subnode(void *fdt, uint64_t=
 timebase_frequency)
>      qemu_fdt_setprop_cell(fdt, "/cpus", "#address-cells", 0x1);
>      qemu_fdt_add_subnode(fdt, "/cpus/cpu-map");
>  }
> +
> +void create_fdt_socket_cpus(void *fdt, RISCVCPU *socket_harts,
> +                            int socket_id, int num_harts_socket,
> +                            int socket_hartid_base, uint32_t *phandle,
> +                            uint32_t *intc_phandles, bool numa_enabled,
> +                            bool is_32_bit)
> +{
> +    g_autofree char *clust_name =3D NULL;
> +    uint32_t cpu_phandle;
> +
> +    clust_name =3D g_strdup_printf("/cpus/cpu-map/cluster%d", socket_id)=
;
> +    qemu_fdt_add_subnode(fdt, clust_name);
> +
> +    for (int cpu =3D num_harts_socket - 1; cpu >=3D 0; cpu--) {
> +        RISCVCPU *cpu_ptr =3D &socket_harts[cpu];
> +        int8_t satp_mode_max =3D cpu_ptr->cfg.max_satp_mode;
> +        g_autofree char *cpu_name =3D NULL;
> +        g_autofree char *core_name =3D NULL;
> +        g_autofree char *intc_name =3D NULL;
> +
> +        cpu_phandle =3D (*phandle)++;
> +
> +        cpu_name =3D g_strdup_printf("/cpus/cpu@%d", socket_hartid_base =
+ cpu);
> +        qemu_fdt_add_subnode(fdt, cpu_name);
> +
> +        if (satp_mode_max !=3D -1) {
> +            g_autofree char *sv_name =3D NULL;
> +            sv_name =3D g_strdup_printf("riscv,%s",
> +                                      satp_mode_str(satp_mode_max, is_32=
_bit));
> +            qemu_fdt_setprop_string(fdt, cpu_name, "mmu-type", sv_name);
> +        }
> +        riscv_isa_write_fdt(cpu_ptr, fdt, cpu_name);
> +
> +        if (cpu_ptr->cfg.ext_zicbom) {
> +            qemu_fdt_setprop_cell(fdt, cpu_name, "riscv,cbom-block-size"=
,
> +                                  cpu_ptr->cfg.cbom_blocksize);
> +        }
> +
> +        if (cpu_ptr->cfg.ext_zicboz) {
> +            qemu_fdt_setprop_cell(fdt, cpu_name, "riscv,cboz-block-size"=
,
> +                                  cpu_ptr->cfg.cboz_blocksize);
> +        }
> +
> +        if (cpu_ptr->cfg.ext_zicbop) {
> +            qemu_fdt_setprop_cell(fdt, cpu_name, "riscv,cbop-block-size"=
,
> +                                  cpu_ptr->cfg.cbop_blocksize);
> +        }
> +
> +        qemu_fdt_setprop_string(fdt, cpu_name, "compatible", "riscv");
> +        qemu_fdt_setprop_string(fdt, cpu_name, "status", "okay");
> +        qemu_fdt_setprop_cell(fdt, cpu_name, "reg",
> +                              socket_hartid_base + cpu);
> +        qemu_fdt_setprop_string(fdt, cpu_name, "device_type", "cpu");
> +        if (numa_enabled) {
> +            qemu_fdt_setprop_cell(fdt, cpu_name, "numa-node-id", socket_=
id);
> +        }
> +        qemu_fdt_setprop_cell(fdt, cpu_name, "phandle", cpu_phandle);
> +
> +        intc_phandles[cpu] =3D (*phandle)++;
> +
> +        intc_name =3D g_strdup_printf("%s/interrupt-controller", cpu_nam=
e);
> +        qemu_fdt_add_subnode(fdt, intc_name);
> +        qemu_fdt_setprop_cell(fdt, intc_name, "phandle",
> +                              intc_phandles[cpu]);
> +        qemu_fdt_setprop_string(fdt, intc_name, "compatible",
> +                                "riscv,cpu-intc");
> +        qemu_fdt_setprop(fdt, intc_name, "interrupt-controller", NULL, 0=
);
> +        qemu_fdt_setprop_cell(fdt, intc_name, "#interrupt-cells", 1);
> +
> +        core_name =3D g_strdup_printf("%s/core%d", clust_name, cpu);
> +        qemu_fdt_add_subnode(fdt, core_name);
> +        qemu_fdt_setprop_cell(fdt, core_name, "cpu", cpu_phandle);
> +    }
> +}
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 6641b60131..33775a61fd 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -231,77 +231,6 @@ static void create_pcie_irq_map(RISCVVirtState *s, v=
oid *fdt, char *nodename,
>                             0x1800, 0, 0, 0x7);
>  }
>
> -static void create_fdt_socket_cpus(RISCVVirtState *s, int socket,
> -                                   char *clust_name, uint32_t *phandle,
> -                                   uint32_t *intc_phandles)
> -{
> -    int cpu;
> -    uint32_t cpu_phandle;
> -    MachineState *ms =3D MACHINE(s);
> -    bool is_32_bit =3D riscv_is_32bit(&s->soc[0]);
> -
> -    for (cpu =3D s->soc[socket].num_harts - 1; cpu >=3D 0; cpu--) {
> -        RISCVCPU *cpu_ptr =3D &s->soc[socket].harts[cpu];
> -        int8_t satp_mode_max =3D cpu_ptr->cfg.max_satp_mode;
> -        g_autofree char *cpu_name =3D NULL;
> -        g_autofree char *core_name =3D NULL;
> -        g_autofree char *intc_name =3D NULL;
> -        g_autofree char *sv_name =3D NULL;
> -
> -        cpu_phandle =3D (*phandle)++;
> -
> -        cpu_name =3D g_strdup_printf("/cpus/cpu@%d",
> -            s->soc[socket].hartid_base + cpu);
> -        qemu_fdt_add_subnode(ms->fdt, cpu_name);
> -
> -        if (satp_mode_max !=3D -1) {
> -            sv_name =3D g_strdup_printf("riscv,%s",
> -                                      satp_mode_str(satp_mode_max, is_32=
_bit));
> -            qemu_fdt_setprop_string(ms->fdt, cpu_name, "mmu-type", sv_na=
me);
> -        }
> -
> -        riscv_isa_write_fdt(cpu_ptr, ms->fdt, cpu_name);
> -
> -        if (cpu_ptr->cfg.ext_zicbom) {
> -            qemu_fdt_setprop_cell(ms->fdt, cpu_name, "riscv,cbom-block-s=
ize",
> -                                  cpu_ptr->cfg.cbom_blocksize);
> -        }
> -
> -        if (cpu_ptr->cfg.ext_zicboz) {
> -            qemu_fdt_setprop_cell(ms->fdt, cpu_name, "riscv,cboz-block-s=
ize",
> -                                  cpu_ptr->cfg.cboz_blocksize);
> -        }
> -
> -        if (cpu_ptr->cfg.ext_zicbop) {
> -            qemu_fdt_setprop_cell(ms->fdt, cpu_name, "riscv,cbop-block-s=
ize",
> -                                  cpu_ptr->cfg.cbop_blocksize);
> -        }
> -
> -        qemu_fdt_setprop_string(ms->fdt, cpu_name, "compatible", "riscv"=
);
> -        qemu_fdt_setprop_string(ms->fdt, cpu_name, "status", "okay");
> -        qemu_fdt_setprop_cell(ms->fdt, cpu_name, "reg",
> -            s->soc[socket].hartid_base + cpu);
> -        qemu_fdt_setprop_string(ms->fdt, cpu_name, "device_type", "cpu")=
;
> -        riscv_socket_fdt_write_id(ms, cpu_name, socket);
> -        qemu_fdt_setprop_cell(ms->fdt, cpu_name, "phandle", cpu_phandle)=
;
> -
> -        intc_phandles[cpu] =3D (*phandle)++;
> -
> -        intc_name =3D g_strdup_printf("%s/interrupt-controller", cpu_nam=
e);
> -        qemu_fdt_add_subnode(ms->fdt, intc_name);
> -        qemu_fdt_setprop_cell(ms->fdt, intc_name, "phandle",
> -            intc_phandles[cpu]);
> -        qemu_fdt_setprop_string(ms->fdt, intc_name, "compatible",
> -            "riscv,cpu-intc");
> -        qemu_fdt_setprop(ms->fdt, intc_name, "interrupt-controller", NUL=
L, 0);
> -        qemu_fdt_setprop_cell(ms->fdt, intc_name, "#interrupt-cells", 1)=
;
> -
> -        core_name =3D g_strdup_printf("%s/core%d", clust_name, cpu);
> -        qemu_fdt_add_subnode(ms->fdt, core_name);
> -        qemu_fdt_setprop_cell(ms->fdt, core_name, "cpu", cpu_phandle);
> -    }
> -}
> -
>  static void create_fdt_socket_aclint(RISCVVirtState *s,
>                                       int socket,
>                                       uint32_t *intc_phandles)
> @@ -693,6 +622,7 @@ static void create_fdt_sockets(RISCVVirtState *s,
>      g_autofree uint32_t *intc_phandles =3D NULL;
>      int socket_count =3D riscv_socket_count(ms);
>      bool numa_enabled =3D riscv_numa_enabled(ms);
> +    bool is_32_bit =3D riscv_is_32bit(&s->soc[0]);
>
>      fdt_create_cpu_socket_subnode(ms->fdt,
>          kvm_enabled() ? kvm_riscv_get_timebase_frequency(&s->soc->harts[=
0]) :
> @@ -702,18 +632,17 @@ static void create_fdt_sockets(RISCVVirtState *s,
>
>      phandle_pos =3D ms->smp.cpus;
>      for (socket =3D (socket_count - 1); socket >=3D 0; socket--) {
> -        g_autofree char *clust_name =3D NULL;
>          hwaddr memaddr =3D s->memmap[VIRT_DRAM].base +
>                           riscv_socket_mem_offset(ms, socket);
>          uint64_t memsize =3D riscv_socket_mem_size(ms, socket);
>
>          phandle_pos -=3D s->soc[socket].num_harts;
>
> -        clust_name =3D g_strdup_printf("/cpus/cpu-map/cluster%d", socket=
);
> -        qemu_fdt_add_subnode(ms->fdt, clust_name);
> -
> -        create_fdt_socket_cpus(s, socket, clust_name, phandle,
> -                               &intc_phandles[phandle_pos]);
> +        create_fdt_socket_cpus(ms->fdt, (&s->soc[socket])->harts, socket=
,
> +                               s->soc[socket].num_harts,
> +                               s->soc[socket].hartid_base,
> +                               phandle, &intc_phandles[phandle_pos],
> +                               numa_enabled, is_32_bit);
>
>          create_fdt_socket_memory(ms->fdt, memaddr, memsize,
>                                   socket, riscv_numa_enabled(ms));
> diff --git a/include/hw/riscv/fdt-common.h b/include/hw/riscv/fdt-common.=
h
> index 27020e69c6..3af9d5c3fd 100644
> --- a/include/hw/riscv/fdt-common.h
> +++ b/include/hw/riscv/fdt-common.h
> @@ -9,6 +9,8 @@
>  #ifndef RISCV_VIRT_FDT_H
>  #define RISCV_VIRT_FDT_H
>
> +#include "target/riscv/cpu.h"
> +
>  void *create_board_device_tree(const char *model, const char *compatible=
,
>                                 int *fdt_size);
>  void create_fdt_socket_memory(void *fdt, hwaddr addr, uint64_t size,
> @@ -19,4 +21,9 @@ void create_fdt_socket_clint(void *fdt, hwaddr addr, ui=
nt64_t size,
>                               int socket_id, uint32_t *intc_phandles,
>                               int num_harts, bool numa_enabled);
>  void fdt_create_cpu_socket_subnode(void *fdt, uint64_t timebase_frequenc=
y);
> +void create_fdt_socket_cpus(void *fdt, RISCVCPU *socket_harts,
> +                            int socket_id, int num_harts_socket,
> +                            int socket_hartid_base, uint32_t *phandle,
> +                            uint32_t *intc_phandles, bool numa_enabled,
> +                            bool is_32_bit);
>  #endif
> --
> 2.43.0
>
>

