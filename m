Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 692F7CD98D2
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 03:24:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZKOx-0004Xx-Bb; Mon, 15 Jun 2026 23:23:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZKOn-0004WL-0E
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 23:23:42 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZKOl-0004E6-77
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 23:23:36 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-68bfcf11050so6900786a12.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 20:23:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781580213; cv=none;
 d=google.com; s=arc-20240605;
 b=Ye3TXUAWbXMBfXcH5k659czwdsN4JS9oLG9X0t93soWdNQt67NWAfXXJB3asV9DoNy
 AGPak7Oodo+2DJTiy4Ie/cXLKTghDG7aHUn/U67b79D85n5FkOgy4GMIqnUgil+S60Bq
 dIRfjKSAdTiH0o/jmNc3OKvYUYtbwJfY4ji4Ht5sIxLCnMdHG86duGDJNvXVPrsOQqYp
 vsKbc63L8XFr0xcDHtzpQ8ivRCrLRebebledr/nSGcnvuLTmQsVDfZgg2UbCItruJ+np
 Ioboe3BV5sXbeqLT9gjXdpttSE7PJgiJAHcIWOX0jpq9uiUksZDzGeDt3vdAqfTsxiKH
 u08w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=/5KJBQHmfcBZubyPXnk0J0w+KOK4+S3up8ZJszqWFZ4=;
 fh=y/39rxWsHsSIhiCgFyox46bvYsAfNaBS3wRFv9pkMrs=;
 b=ItQAa0ieqHKgEvxPjfKcecir+MuhcNewr8qCb9hSbOrpjO6GRipkMq435AlHdG19sm
 f/eM63hAT8g2/4UDBrQkv05+QXefu+/AG3r9ZAepIocLKgFTExCzt1DkDMq91mFFO6An
 wJ4yooJLTwB2mBPCFt0Cm496oyQfQKKXa3ki4V68YqujGHiyKPHeTywJbGRU7naANaRx
 mYPntUwDrWWpGCjEp1zq3+rMIiLg2RDYybyvOzaj/QX5qUw4+6bxkLeh3+SF7aPQRHGx
 1NLjioK/9oxJBizrYopB0eTS/Q5ReI/Kumw2nW+L2rQ48whX8L1qSTAdgXrkorC2TvYv
 ohtg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781580213; x=1782185013; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/5KJBQHmfcBZubyPXnk0J0w+KOK4+S3up8ZJszqWFZ4=;
 b=OwAGw/Mwb5+HpMTxp2wp+YwDaGT7SrDYXKVSdmZFvFQ4ZecvQ3aBFUqeczQpjprcDp
 5D3noB/EioJtEzSySKo1n2/v4TQ1Xy8PrW865dK7Qp9jdHJU6M5TlgRpyYhmx0JylntK
 7EEOqPdiv6jcPkGrQRd2wgY8ba5wt2EIQCzuJv0xR0uhIrG6jtfr9n+1xTvYpndjeD33
 wFPIJkMPYYUTuKBxrJpahjpNZM/3QlSH8rlqMbSrJbsCg30h3HfReeU1TfG2cqze6tVU
 RXhhdHVETTVozdRLTNHevSnwERM2gUTd/WFlYgaRhqkMzjOKJj8YwGTwZ+PiM3lJGHTc
 hehQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781580213; x=1782185013;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/5KJBQHmfcBZubyPXnk0J0w+KOK4+S3up8ZJszqWFZ4=;
 b=M7VTcDHOwc7W+hlJhlC65IAiBzY77Z5OHXU1ZKYn1EMHxpr3yKDQ+yCUuB+Ty4LDIj
 2BqhgVvF8wBQPRc0O2HgRt4XTbrqijrCv/+NE5JCY+9MjlQUQ/Cskdx+X8MwS174KU78
 fVbYTc55WqeSuNKdmpq5ici2/9v5u+xWwc0M5QtHNQ/gmhqMa0TCyHxesAsPB9iP/dLB
 rols5u1dRdkqqFMSDcRcMvw0UmLntBBieezcdb1LuElZst2fxJCihypt70TMjLHzTZvZ
 ThvtF6Ey5vdlED9EqCEQ2mEirrXfp0zX2Obs+sdw3xmcu0c+TLMvg/thkGFw2R1j9KjO
 A5vA==
X-Gm-Message-State: AOJu0Yzgms4LuZ08e7XearcDeGg7Z84Fd1PpE9mJgKKjWrxlKVeVifHU
 FkRaNVrZnB+hdtphaYDJGOKcZq9L0CrZlG0Wepv0F+ifgyzm0m+c0zFJqljMS3AHKksYUkLtYI0
 rmLP6Rr05pIMOu2PVlOZ+fA2s1dmMMig=
X-Gm-Gg: Acq92OH7Wz63UKoxQupUNfcV4gn8z3vXsik8/Xz6e2XC3u9JTj5MSXdY4EEPTiIzX1P
 gVxfQOQUfO6NnN17xX61nq1CxRSYB4FCQ/BN3SZUiLtEhYTAqzg3kZPlNvIHzA9+PO9usiiZ/y6
 xGaawhHlf5FZ/Qy9P9nDuFEEZ/3TSkz9R0Xbe9muxPcsU94Rc/sKsFx2EQIzdvvGEmre1L1pgsb
 U2sZHHZZt8lS5hocvYaWgX4oZ+jTdOAWuH+Uc4yc05x0g4h1prhre7cVUqm1z39hDVPvQv3b2N3
 CKcAyGaovdF8Q+kMikfyDfiPdcizUajv1T7Sow==
X-Received: by 2002:a05:6402:3485:b0:691:703d:2279 with SMTP id
 4fb4d7f45d1cf-6950874d21bmr843828a12.24.1781580213407; Mon, 15 Jun 2026
 20:23:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260615203734.954428-1-daniel.barboza@oss.qualcomm.com>
 <20260615203734.954428-13-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260615203734.954428-13-daniel.barboza@oss.qualcomm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 16 Jun 2026 13:23:06 +1000
X-Gm-Features: AVVi8CdHZ3v3hPtQ77kB3BQXTsAnxn2puOwF3oISpm-0zNefWn0R62JSJf5fol0
Message-ID: <CAKmqyKNM_SQhf+UDZpNW0OrJKceBO6fZgny8W9=7OpuNdy7AzQ@mail.gmail.com>
Subject: Re: [PATCH 12/13] hw/riscv/fdt_common.c: create
 create_fdt_socket_cpu_internal()
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com, 
 Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x531.google.com
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
> The sifive_u board does not share the same CPU socket FDT bits from the
> other boards.  In particular the riscv,isa creation is done using either
> CPU0 from soc.e_cpus.harts, and for all other CPUs soc.u_cups.harts is
> used.
>
> It would be too cumbersome to add all these details in the common code
> so we're going to add a special sifive_u only helper that shares the
> common bits with the common helper used by the other boards.
>
> create_fdt_socket_cpu_internal() contains the common bits shared between
> the sifive_u board and the rest.
>
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/fdt-common.c | 108 +++++++++++++++++++++++++-----------------
>  1 file changed, 65 insertions(+), 43 deletions(-)
>
> diff --git a/hw/riscv/fdt-common.c b/hw/riscv/fdt-common.c
> index 6c795409a4..70168ad657 100644
> --- a/hw/riscv/fdt-common.c
> +++ b/hw/riscv/fdt-common.c
> @@ -94,28 +94,29 @@ void fdt_create_cpu_socket_subnode(void *fdt, uint64_=
t timebase_frequency)
>      qemu_fdt_add_subnode(fdt, "/cpus/cpu-map");
>  }
>
> -void create_fdt_socket_cpus(void *fdt, RISCVCPU *socket_harts,
> -                            int socket_id, int num_harts_socket,
> -                            int socket_hartid_base, uint32_t *phandle,
> -                            uint32_t *intc_phandles, bool numa_enabled,
> -                            bool is_32_bit)
> +static void
> +create_fdt_socket_cpu_internal(void *fdt, char *clust_name, RISCVCPU *cp=
u_ptr,
> +                               int cpu, int socket_id, int socket_hartid=
_base,
> +                               uint32_t *phandle, uint32_t *intc_phandle=
s,
> +                               bool numa_enabled, bool is_32_bit)
>  {
> -    g_autofree char *clust_name =3D NULL;
> -    uint32_t cpu_phandle;
> -
> -    clust_name =3D g_strdup_printf("/cpus/cpu-map/cluster%d", socket_id)=
;
> -    qemu_fdt_add_subnode(fdt, clust_name);
> -
> -    for (int cpu =3D num_harts_socket - 1; cpu >=3D 0; cpu--) {
> -        RISCVCPU *cpu_ptr =3D &socket_harts[cpu];
> +    g_autofree char *cpu_name =3D NULL;
> +    g_autofree char *core_name =3D NULL;
> +    g_autofree char *intc_name =3D NULL;
> +    uint32_t cpu_phandle =3D (*phandle)++;
> +    bool is_sifive_u =3D cpu_ptr =3D=3D NULL;
> +
> +    cpu_name =3D g_strdup_printf("/cpus/cpu@%d", socket_hartid_base + cp=
u);
> +
> +    /*
> +     * The sifive_u board has an exclusive satp and riscv,isa
> +     * schema that can't be shared with other boards, so part
> +     * of the CPU FDT creation (i.e. the /cpus/cpu@N subnode)
> +     * is still being done by the board.
> +     */
> +    if (!is_sifive_u) {
>          int8_t satp_mode_max =3D cpu_ptr->cfg.max_satp_mode;
> -        g_autofree char *cpu_name =3D NULL;
> -        g_autofree char *core_name =3D NULL;
> -        g_autofree char *intc_name =3D NULL;
> -
> -        cpu_phandle =3D (*phandle)++;
>
> -        cpu_name =3D g_strdup_printf("/cpus/cpu@%d", socket_hartid_base =
+ cpu);
>          qemu_fdt_add_subnode(fdt, cpu_name);
>
>          if (satp_mode_max !=3D -1) {
> @@ -140,30 +141,51 @@ void create_fdt_socket_cpus(void *fdt, RISCVCPU *so=
cket_harts,
>              qemu_fdt_setprop_cell(fdt, cpu_name, "riscv,cbop-block-size"=
,
>                                    cpu_ptr->cfg.cbop_blocksize);
>          }
> +    }
>
> -        qemu_fdt_setprop_string(fdt, cpu_name, "compatible", "riscv");
> -        qemu_fdt_setprop_string(fdt, cpu_name, "status", "okay");
> -        qemu_fdt_setprop_cell(fdt, cpu_name, "reg",
> -                              socket_hartid_base + cpu);
> -        qemu_fdt_setprop_string(fdt, cpu_name, "device_type", "cpu");
> -        if (numa_enabled) {
> -            qemu_fdt_setprop_cell(fdt, cpu_name, "numa-node-id", socket_=
id);
> -        }
> -        qemu_fdt_setprop_cell(fdt, cpu_name, "phandle", cpu_phandle);
> -
> -        intc_phandles[cpu] =3D (*phandle)++;
> -
> -        intc_name =3D g_strdup_printf("%s/interrupt-controller", cpu_nam=
e);
> -        qemu_fdt_add_subnode(fdt, intc_name);
> -        qemu_fdt_setprop_cell(fdt, intc_name, "phandle",
> -                              intc_phandles[cpu]);
> -        qemu_fdt_setprop_string(fdt, intc_name, "compatible",
> -                                "riscv,cpu-intc");
> -        qemu_fdt_setprop(fdt, intc_name, "interrupt-controller", NULL, 0=
);
> -        qemu_fdt_setprop_cell(fdt, intc_name, "#interrupt-cells", 1);
> -
> -        core_name =3D g_strdup_printf("%s/core%d", clust_name, cpu);
> -        qemu_fdt_add_subnode(fdt, core_name);
> -        qemu_fdt_setprop_cell(fdt, core_name, "cpu", cpu_phandle);
> +    qemu_fdt_setprop_string(fdt, cpu_name, "compatible", "riscv");
> +    qemu_fdt_setprop_string(fdt, cpu_name, "status", "okay");
> +    qemu_fdt_setprop_cell(fdt, cpu_name, "reg",
> +                          socket_hartid_base + cpu);
> +    qemu_fdt_setprop_string(fdt, cpu_name, "device_type", "cpu");
> +    if (numa_enabled) {
> +        qemu_fdt_setprop_cell(fdt, cpu_name, "numa-node-id", socket_id);
> +    }
> +    qemu_fdt_setprop_cell(fdt, cpu_name, "phandle", cpu_phandle);
> +
> +    intc_phandles[cpu] =3D (*phandle)++;
> +
> +    intc_name =3D g_strdup_printf("%s/interrupt-controller", cpu_name);
> +    qemu_fdt_add_subnode(fdt, intc_name);
> +    qemu_fdt_setprop_cell(fdt, intc_name, "phandle",
> +                          intc_phandles[cpu]);
> +    qemu_fdt_setprop_string(fdt, intc_name, "compatible",
> +                            "riscv,cpu-intc");
> +    qemu_fdt_setprop(fdt, intc_name, "interrupt-controller", NULL, 0);
> +    qemu_fdt_setprop_cell(fdt, intc_name, "#interrupt-cells", 1);
> +
> +    core_name =3D g_strdup_printf("%s/core%d", clust_name, cpu);
> +    qemu_fdt_add_subnode(fdt, core_name);
> +    qemu_fdt_setprop_cell(fdt, core_name, "cpu", cpu_phandle);
> +}
> +
> +void create_fdt_socket_cpus(void *fdt, RISCVCPU *socket_harts,
> +                            int socket_id, int num_harts_socket,
> +                            int socket_hartid_base, uint32_t *phandle,
> +                            uint32_t *intc_phandles, bool numa_enabled,
> +                            bool is_32_bit)
> +{
> +    g_autofree char *clust_name =3D NULL;
> +
> +    clust_name =3D g_strdup_printf("/cpus/cpu-map/cluster%d", socket_id)=
;
> +    qemu_fdt_add_subnode(fdt, clust_name);
> +
> +    for (int cpu =3D num_harts_socket - 1; cpu >=3D 0; cpu--) {
> +        RISCVCPU *cpu_ptr =3D &socket_harts[cpu];
> +
> +        create_fdt_socket_cpu_internal(fdt, clust_name, cpu_ptr, cpu,
> +                                       socket_id, socket_hartid_base,
> +                                       phandle, intc_phandles, numa_enab=
led,
> +                                       is_32_bit);
>      }
>  }
> --
> 2.43.0
>
>

