Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A2DFC0218A
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 01:41:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcx4D-0003GS-1v; Tue, 28 Jan 2025 20:40:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tcx4B-0003C7-3U; Tue, 28 Jan 2025 20:40:31 -0500
Received: from mail-ua1-x932.google.com ([2607:f8b0:4864:20::932])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tcx49-00044Q-6M; Tue, 28 Jan 2025 20:40:30 -0500
Received: by mail-ua1-x932.google.com with SMTP id
 a1e0cc1a2514c-85c529e72bcso1215631241.0; 
 Tue, 28 Jan 2025 17:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738114827; x=1738719627; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2D9o2+czZxP14WHRAWScDdFh5qIbfwgdjW+waklIuDw=;
 b=BnFXXH4ib+SSffta/rdcEEUb0akcbYfFtlYBN4d3vv2IrPIprcCmZ9kou2HDwD88Y2
 Z0ukm7XAVx6WZ0mDqBZf7lAHHnyvhHG7nWyHpyBAdSbMfO2f50JLCMjcy5ErrSLoK2eK
 1/xAKpDGlLLfTGqrQAjFaf6b9EbuXCiSHM7PpUiB6FbxmO3cDoWup+u7Jl0xZ+lZsQ9W
 w9nATdsYJd4w12MJwqENK9O8jSYQ5ptEoha1dhxADY6It6y80E/YijSZ6G56FQM7d5qM
 0y3b29nroiXlP7ZscaxII8LWJeEZdYw4ENory4GH9SopGGmL1VQ5DqWFvH/nAOFxMCot
 bxdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738114827; x=1738719627;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2D9o2+czZxP14WHRAWScDdFh5qIbfwgdjW+waklIuDw=;
 b=xPIGF7UeHDFBzvwiLBqb6+MnGP5ZsGdaEn51aoRQ0Xu89W+xr+IlRD67naD0Vznq7X
 bJuNyPjBGxGFRE/mXNAjp2U4oz8zHcXB0IZhykOWXt4d2Z6O+XcteCq6K+7yqaW8rkD/
 WqHSgOw4kuNt477TNyDuRd3iC0BleODyym7743RgN0CBfwDdAficTVevAHHyj1mXmgSz
 GT5wcfgEAOb/fNLI13qtuac3uLIzd5TnI0nRgwWeV4gPJoTZw3KmhaVlOx96ut6MR99b
 NMJTFBQVIDl/1bQbnc63p0HcArcV6SfP8tqVaZhKHx68+Kk6LCbwpCRWg5Tib4wZyzBK
 3u8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVoCxEpsoFVXT7JBr83LviLX8vfkKu10H/LkvTd4ssMKp33B4UeUGGd+sl8LX6Pwu2NieHnVhhm8tq@nongnu.org
X-Gm-Message-State: AOJu0Yxx2A8hRYV+RftixLgZj1uegSR6aqLPltkgj7uLCTSoS53vGdK9
 OwPJE6pflhEEx64khz2ycCaEq9xpBcWPgyNVdVcArWK3fCAh+xZuI7CyU2dMdKh2EVPykS3MBNR
 ayCA64fsATkxFVyzRRMRsQVdlA+md0g==
X-Gm-Gg: ASbGncuI/FLMC2cttOMksMCm7MrhZu3xJott6zIVYVqSD/N1t04UXTpHEtfeA8VrbLm
 Q2ja5C+D2sV2AfGHDAUAgkh5mUgrZ2w6OGZOoAYab7EwQ4U4JcB/P3yVOZ8xw6ZbHqNzAjzE/DV
 OPCyO1I8WfGAHyMVjRujrfbCqXaA==
X-Google-Smtp-Source: AGHT+IF7ni2tyUzQpVh0E1ngv74dm/6E+7euikYTw5fq3k+6Mic6ZHldW2a/aNKiZ4NXQ9MwXr6U5AmV7ymX59fWkxo=
X-Received: by 2002:a05:6102:3c84:b0:4af:f892:e9f0 with SMTP id
 ada2fe7eead31-4b9a4f86a16mr1165164137.14.1738114827632; Tue, 28 Jan 2025
 17:40:27 -0800 (PST)
MIME-Version: 1.0
References: <20250121170626.1992570-1-dbarboza@ventanamicro.com>
 <20250121170626.1992570-2-dbarboza@ventanamicro.com>
In-Reply-To: <20250121170626.1992570-2-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 29 Jan 2025 11:40:01 +1000
X-Gm-Features: AWEUYZmGDJ2PfkAmmSuYmyQN0Mn4AA54CZXcYtMWMARD49v2ORsGjZs5HY-flhM
Message-ID: <CAKmqyKPspAHSo7vrq3hp_Ys6vfXdk5M1QoNMNmTngQhufDcjpQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] target/riscv/debug.c: use wp size = 4 for 32-bit
 CPUs
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::932;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x932.google.com
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

On Wed, Jan 22, 2025 at 3:07=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> The mcontrol select bit (19) is always zero, meaning our triggers will
> always match virtual addresses. In this condition, if the user does not
> specify a size for the trigger, the access size defaults to XLEN.
>
> At this moment we're using def_size =3D 8 regardless of CPU XLEN. Use
> def_size =3D 4 in case we're running 32 bits.
>
> Fixes: 95799e36c1 ("target/riscv: Add initial support for the Sdtrig exte=
nsion")
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/debug.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/target/riscv/debug.c b/target/riscv/debug.c
> index f6241a80be..9db4048523 100644
> --- a/target/riscv/debug.c
> +++ b/target/riscv/debug.c
> @@ -478,7 +478,7 @@ static void type2_breakpoint_insert(CPURISCVState *en=
v, target_ulong index)
>      bool enabled =3D type2_breakpoint_enabled(ctrl);
>      CPUState *cs =3D env_cpu(env);
>      int flags =3D BP_CPU | BP_STOP_BEFORE_ACCESS;
> -    uint32_t size;
> +    uint32_t size, def_size;
>
>      if (!enabled) {
>          return;
> @@ -501,7 +501,9 @@ static void type2_breakpoint_insert(CPURISCVState *en=
v, target_ulong index)
>              cpu_watchpoint_insert(cs, addr, size, flags,
>                                    &env->cpu_watchpoint[index]);
>          } else {
> -            cpu_watchpoint_insert(cs, addr, 8, flags,
> +            def_size =3D riscv_cpu_mxl(env) =3D=3D MXL_RV64 ? 8 : 4;
> +
> +            cpu_watchpoint_insert(cs, addr, def_size, flags,
>                                    &env->cpu_watchpoint[index]);
>          }
>      }
> --
> 2.47.1
>
>

