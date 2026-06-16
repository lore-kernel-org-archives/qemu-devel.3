Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EABDCD98DA
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 03:16:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZKHY-0001cX-VH; Mon, 15 Jun 2026 23:16:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZKHX-0001Z8-Bx
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 23:16:07 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZKHV-0002O4-Lv
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 23:16:07 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-bec43ee8ff0so567570866b.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 20:16:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781579764; cv=none;
 d=google.com; s=arc-20240605;
 b=EF0VeMqU2EcU6Y6uyADMkN9Bvqs4PKZhnpf7kF5crg5TMtNXI/6ZkpWJxAKur11SEZ
 8QvfQp0SWIJ4CQJddpa6RakAeCljGTlF+xKmCRILzrAKHPOHMl7p+a+ZJtvIXsULPJvz
 e9f3GR+l8B6MCL26XaOWRkhWy2oeiCPcXJXHFgr2wE8lU8O59bYk1Uw5Rw7MBaZYA/y2
 MZXoBLqfliEEM1HmwjGGp5R/rttUdevz666P+VqW/9L83giJjhG4RddEdwZaFoaWr0oN
 1P8T4nAQQhRKFN6HCXvKz+UazgatnvrbZRfVXb84gGZwAj+je/wDr5iqYkyWuSFePi7/
 2+QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=X6K3/nxqWW72ckKxzv6eA0AgH3KjHYa6C6CTempCJfI=;
 fh=y/39rxWsHsSIhiCgFyox46bvYsAfNaBS3wRFv9pkMrs=;
 b=bwSmzOT1q61odaq946Bss1xkdSDkJ3HzFre1umc23Y+p//ZAs8qE9cYiThPRrW35Uq
 HZPdLgzK35fPPwA+TjpjpGUGRxWW9w+GYd5UnCVwRuOb8h+isGLXJmjtUTpHz8TZXnvn
 sLanwAr+wk3S2RptM00UUlJdVeMwciY3+SYN4ejhyNkdAkas5aQRPE4wRFdQVxIzeIgS
 tWEkMuDT3J18nkkT7emkoF9Ia5yx81SBzNJbb0pCAnQ/UBMfl0lgG5nTKqrBYlBKWyiD
 wMVu//ii2vNPqQnnZzk7rQcDrtFi4UvxkA7M5tsFKTgVpxwU0jkgf6OzO/95XXkAicKo
 f8sQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781579764; x=1782184564; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X6K3/nxqWW72ckKxzv6eA0AgH3KjHYa6C6CTempCJfI=;
 b=fdTNvm+zSJ2N9kjXjZkx2MgXK5HpnVeZ9Rn9QCI6Y7PcVVZFq4Ctja6cFfW19jwLAI
 lyW0JNTQT+R+zn4p8VtTE4MerB/XxyJjQ/D+4udWc51A9yYRslZlblkVZtI2f/2BVT47
 nPCC/eOXpq2h4CbygMHoqaUvTGz/qfGc2GvA9sJzVAOKC6Tyo1wRqVQr1l+Jw/us3Cfe
 VY6n+ROeCKmU+BZVsW7AvVj+rqD29kczmwiCdoxFM5PSw243Xu5OjtH/OqUNGlKrxcBZ
 UgDguMyaqgVCzHSd15uQCz7opkDGF2hp0jkqMCVE3AQe5AzLujr44Byc4MJJJFjex88G
 KDbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781579764; x=1782184564;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=X6K3/nxqWW72ckKxzv6eA0AgH3KjHYa6C6CTempCJfI=;
 b=jDS+b+ky4UChJ2zbD0giucoHxhSY5euowqXnlrmjsMuM4UvLAK4FilirlPzsiG1pRD
 nO5K3sSnqCwAopoa1/OT7d3UlNYyAKXA1hWY6ZL+kcsxYehNF2ecHNIJJrts5BaidhV3
 iZvIDQeg8ooPHBFDTHKIQzUtXgLKroj8utzRnf6ciZC/ZoW4YjEUFOd4WN4lKI9Qu+Ht
 HN27DLw1G8Ljck7jQvqjNYnTuaN7L7palY5nIiVED6FM9uzL/yps5YCqTHOEZ9K/Z9Gu
 gvnO7Ar3fwSMXvoWdwwghR/Uw5eInWva1hxshDLfk5XAhTk35JmKL2F8OXGYtPqmseE7
 swWg==
X-Gm-Message-State: AOJu0Yyr5m8Ay+moi3IbYlm3B8DZ6JNq6XygOkbBv1TcwGE6cyf/d3m2
 3DREevTLXAu5M2LdCvCYCOhGZl8B7l50S/pEmwZka1hygSjKxPzgCkYQdesG9/0qO3IgsEmGbAV
 6ShuoZlhTCxXzIuPrMm065lyG5qQ8r1s=
X-Gm-Gg: Acq92OHVBF+g9toVxMpi4dxOTSEWDWKfSw9Tf7190xWNvGPz5dlUwgvotceNbFsxsXW
 +6nwQ1n9fgBnsoe/Pauq5tvGZdonO7HxHjqxfRtcR14CvOpoUY72WhlqvY8tj0Ndf2ycyvddDn+
 lwne3ZtL0QE8EuQlVXe9zOu/NMZjet+NJBYVa5rrBYiHWGmS5YLAtO6r3R7qMbbSEZ5pRqr7e5c
 WLwADrlUZAjDoFdJUUA209kQ9gHzzBqZxYwa3Ku1/sV9ALYPMrhbTb8NDeqX+qWGu7OAWUq0mue
 exQGVFBYHk6Cp1ebQz4Gs9c9r0C0ETkMvkDTdtVpmpmMdrMW
X-Received: by 2002:a17:907:1caa:b0:bd5:1ad4:cd73 with SMTP id
 a640c23a62f3a-c0416d02af1mr126698166b.2.1781579763798; Mon, 15 Jun 2026
 20:16:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260615203734.954428-1-daniel.barboza@oss.qualcomm.com>
 <20260615203734.954428-9-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260615203734.954428-9-daniel.barboza@oss.qualcomm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 16 Jun 2026 13:15:36 +1000
X-Gm-Features: AVVi8Cdx5vlHO0GaGm1eP3g5kFIyyx8igaBd_db5hWvCBn3FVzsgY-J86LyRGCo
Message-ID: <CAKmqyKM-7RL5-z+dyNp7RVKxvjZ-oXJAchXr3OhfAaAxzLLiUQ@mail.gmail.com>
Subject: Re: [PATCH 08/13] hw/riscv/sifive_u.c: add cpu-map,
 cluster and core DTs
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com, 
 Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x631.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Jun 16, 2026 at 6:40=E2=80=AFAM Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
> We want to consolidate the CPU socket FDT creation into a single helper.
> 'virt' and spike has the same code but sifive_u does not have cpu-map,
> cluster and core subnodes.
>
> These subnodes are present in other boards even in single socket configs
> without NUMA.  This is a strong indicator that their presence doesn't
> hurt a NUMA-less board like sifive_u.
>
> Add these DTs to make the FDT standardization straightforward.
>
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/sifive_u.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index 9a791b36d6..a4265fed0f 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -109,6 +109,7 @@ static void create_fdt(SiFiveUState *s, const MemMapE=
ntry *memmap,
>          "sifive,plic-1.0.0", "riscv,plic0"
>      };
>      g_autofree uint32_t *intc_phandles =3D g_new0(uint32_t, ms->smp.cpus=
);
> +    g_autofree char *clust_name =3D NULL;
>
>      fdt =3D ms->fdt =3D create_board_device_tree("SiFive HiFive Unleashe=
d A00",
>          "sifive,hifive-unleashed-a00", &s->fdt_size);
> @@ -143,11 +144,17 @@ static void create_fdt(SiFiveUState *s, const MemMa=
pEntry *memmap,
>          CLINT_TIMEBASE_FREQ);
>      qemu_fdt_setprop_cell(fdt, "/cpus", "#size-cells", 0x0);
>      qemu_fdt_setprop_cell(fdt, "/cpus", "#address-cells", 0x1);
> +    qemu_fdt_add_subnode(fdt, "/cpus/cpu-map");
> +
> +    clust_name =3D g_strdup_printf("/cpus/cpu-map/cluster%d", 0);
> +    qemu_fdt_add_subnode(fdt, clust_name);
>
>      for (cpu =3D ms->smp.cpus - 1; cpu >=3D 0; cpu--) {
>          int cpu_phandle =3D phandle++;
>          nodename =3D g_strdup_printf("/cpus/cpu@%d", cpu);
>          char *intc =3D g_strdup_printf("/cpus/cpu@%d/interrupt-controlle=
r", cpu);
> +        g_autofree char *core_name =3D NULL;
> +
>          qemu_fdt_add_subnode(fdt, nodename);
>          /* cpu 0 is the management hart that does not have mmu */
>          if (cpu !=3D 0) {
> @@ -173,6 +180,11 @@ static void create_fdt(SiFiveUState *s, const MemMap=
Entry *memmap,
>          qemu_fdt_setprop_string(fdt, intc, "compatible", "riscv,cpu-intc=
");
>          qemu_fdt_setprop(fdt, intc, "interrupt-controller", NULL, 0);
>          qemu_fdt_setprop_cell(fdt, intc, "#interrupt-cells", 1);
> +
> +        core_name =3D g_strdup_printf("%s/core%d", clust_name, cpu);
> +        qemu_fdt_add_subnode(fdt, core_name);
> +        qemu_fdt_setprop_cell(fdt, core_name, "cpu", cpu_phandle);
> +
>          g_free(intc);
>          g_free(nodename);
>      }
> --
> 2.43.0
>
>

