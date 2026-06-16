Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90EB0CD98DA
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 02:42:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZJjm-0001Xn-4o; Mon, 15 Jun 2026 22:41:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZJjk-0001Wg-4b
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 22:41:12 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZJji-00011X-JA
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 22:41:11 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-693c69b97e7so4030966a12.2
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 19:41:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781577668; cv=none;
 d=google.com; s=arc-20240605;
 b=PsAg4LnOhHcVgrjAjh8COmVPHUu0PzEN4xCQm/ln5ZCLXlTBsKrPjcmoZhgZ3dU9FE
 ynCNg9jz91y0WcRRnDmdNyB+1hMSjVIIAceTvKfuqybMQ4OkJbkbB/i/OOjx/+W/DAkX
 2/roca9O6ZJ5RE2+w58Zo8pXfmyGJCaAC53ONKmPnsWTKHxDNeLMeTNhqV4HLO98DPV7
 JTd4UbZO9KRGF19ThDJ0hzT5BUMLF7F+jOUYBNo2b0hKHjmjUT7dDLPFbkFCfBO6E+P4
 +rH/M35isoeraoUXErxXJ4rk4NCQKKIQcAmhctg0vy109fP7PTOXtR813CFemggMtvml
 p4FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ez7+L26DUwFYKt7C5CcuAdR1zyp//HQR6Woig/CwNNs=;
 fh=y/39rxWsHsSIhiCgFyox46bvYsAfNaBS3wRFv9pkMrs=;
 b=Z9p8Zc/wIFA/BzgPEbGnh6cAPRtwHVqCfbmhPFHveI9wxxyT+Vr1VumlZg5BMytJCI
 DU9/L6jQexTL79UXPj5zZ7pRatRAbKfHCEKcetbcwqUICfds4hH36qYAnYsIsi/yxV1I
 R40ODDF9P3gizEmHxVTsdJx7AcvyJKd7IZpJc1Akp2MLMQSPvYUhek/Ygc9ITu9s2qfv
 RYqu4VEYkhlGP6HnK23QVPPqGyO3Ly87wIaKyGJzbcXXlBu41VqjC00divJyughduN1m
 NXEy5njaX1IEqs+q6VkRG6/Sg87y+IAJ1rNi6QLs4RTCB6paGFGXdQ73OO/liquadpuT
 cB9A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781577668; x=1782182468; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ez7+L26DUwFYKt7C5CcuAdR1zyp//HQR6Woig/CwNNs=;
 b=WAolvup7Wc6+KdKQ2UQKZTYROg6Wm1cpdEwUrwyg1ibiyNkmzvIthfopL49MvASBfQ
 ujgLKBl241EhzmYQRfW0qk87R0VRRNexUwPV4WBbV0IbRO6v1UHRyNHG0cAeWnRNMr34
 VG6Abhxi1LGUPCa2NzGxYcGwFNPL+xNz9cobZ1ICXjemfMpWY3tKebfGzmWKFX984nJd
 5c3fWFz0c3Q+z0otqy61fiQiKDKsYY1YdCIa0DO8g2pPfe5h8PmK3mGY4LgtMrAW8wkn
 jshLUGdp481akX2ZsQ7ZQgsnWJXNHNt/t11sXYDTIYLPMpgmNxYSIocmvNyq1y00bpQF
 xMcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781577668; x=1782182468;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ez7+L26DUwFYKt7C5CcuAdR1zyp//HQR6Woig/CwNNs=;
 b=D4jnCAxkDrtaMkhOP/jcD+U0VPB+KLDd3NxAi6qZ6VrjazkTvClCGHbjAFEFRSU+W6
 M3lrxp0o8o5SkR9pFn+NbweyQausjHq7lLccSpwk8WH5BZc+WN0jji72ZsI6+V32oEVd
 4+Fnc8M4VhemyQ7LIpOYbTsYB4ZMyy5l6oG9cPcveom0bpgfZs30dlIzAWIQCgJIo+8F
 ysLIlQBPDEuR2ViWVMuEEWTKYDbZxylIyeCpJ8Yw49ANvqTjJYGxbm+Y9x1Mq1HSCzZg
 wTFuUfl1t+ntNRS2DdRQaznslVL3vazvHcVv0cJTNuYFb2pdG8IS+ya8EDDqFmL795cd
 wBSA==
X-Gm-Message-State: AOJu0YxS7hvKLJTvA6uZqVZQbH14wahODx2npQMO07PLkel4Bp62L02r
 Y6t45zN5LB3VsQhgS3YFbuUrTlrazY+L8Jd7QxpZwtv8f3P+kmVZHogK5XOVEqnkeHTY2WiO6j3
 FdXpUP1194jlkpfoM7r387mYj3HaPs/4=
X-Gm-Gg: Acq92OE6AXjiCO97ECa/XfEQqBz249ornXHNID0B7liJCIYxKKIZVsgWd71sTE+rvM9
 J8zltvqjjHQwO1uEY8ib7Hjlx+4TEMI9zgVhbQ5HyRwVdp4O1dX5nOt6LXMo/dxV3YsXOT08F+B
 OEhBsoWXnLgDVPIQ9fYk3Y5UGdOcD4LG/baVzaO8hBWZZ03VjIpcmn6tFayb54ON+z0xBUn7mZk
 1dZ2aW7z/a7yjGAp8NUYdbtMXTmfJbGz4BRImYJW4gcH4LcIpwBLJaXP9DoIgmd4p5wZpaLsDRL
 6ntMF7qPgkipy8TVWRhAAOrU/xsF0cqAH4OiPw==
X-Received: by 2002:a05:6402:4416:b0:683:1cc8:84ae with SMTP id
 4fb4d7f45d1cf-695086f27eemr880054a12.7.1781577668284; Mon, 15 Jun 2026
 19:41:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260615203734.954428-1-daniel.barboza@oss.qualcomm.com>
 <20260615203734.954428-2-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260615203734.954428-2-daniel.barboza@oss.qualcomm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 16 Jun 2026 12:40:41 +1000
X-Gm-Features: AVVi8CfTALMzDr_Lxn-Zv1hcSmF1TmdZEYi6BrqJiwxmm_H_DKj1k64cS-Jm5fE
Message-ID: <CAKmqyKNKTqK+RPbGb1D1ciGOTDN+as8W4OO0_V_0VGqjsnUvpw@mail.gmail.com>
Subject: Re: [PATCH 01/13] hw/riscv/sifive_u.c: add a FDT phandle to cpu-intc
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
> We're assigning a 'cpu_phandle' phandle to the cpu-intc phandle field.
> Make it more in line with the other boards by assigning both a
> cpu_phandle and a intc phandle.
>
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/sifive_u.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index 6a637e3b86..3abbd6c823 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -187,8 +187,10 @@ static void create_fdt(SiFiveUState *s, const MemMap=
Entry *memmap,
>          qemu_fdt_setprop_string(fdt, nodename, "status", "okay");
>          qemu_fdt_setprop_cell(fdt, nodename, "reg", cpu);
>          qemu_fdt_setprop_string(fdt, nodename, "device_type", "cpu");
> +        qemu_fdt_setprop_cell(fdt, nodename, "phandle", cpu_phandle);
> +
>          qemu_fdt_add_subnode(fdt, intc);
> -        qemu_fdt_setprop_cell(fdt, intc, "phandle", cpu_phandle);
> +        qemu_fdt_setprop_cell(fdt, intc, "phandle", phandle++);
>          qemu_fdt_setprop_string(fdt, intc, "compatible", "riscv,cpu-intc=
");
>          qemu_fdt_setprop(fdt, intc, "interrupt-controller", NULL, 0);
>          qemu_fdt_setprop_cell(fdt, intc, "#interrupt-cells", 1);
> --
> 2.43.0
>
>

