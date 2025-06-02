Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A248CC54FB3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 06:19:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uLyQs-0000zE-Ux; Mon, 02 Jun 2025 02:14:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uLy79-0002jA-U6; Mon, 02 Jun 2025 01:53:54 -0400
Received: from mail-vs1-xe2e.google.com ([2607:f8b0:4864:20::e2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uLy6z-0000DJ-QZ; Mon, 02 Jun 2025 01:53:38 -0400
Received: by mail-vs1-xe2e.google.com with SMTP id
 ada2fe7eead31-4e47c2a9cdcso3088265137.1; 
 Sun, 01 Jun 2025 22:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748843594; x=1749448394; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vPuEJZPFTvmnnxKx2qBHy+u2/akhfMU6ZEJbyKzkVEY=;
 b=eoe4hd7XGVWRthQRVt9KhAv/Uz8i6V5KvtjslkIdqmoh5NF2N4DdyK6dsnpcSRdCQD
 atVOpCEhaDxuxGtOzhMEXvqLhOwbKGFmcHAQyVbttrgbdPZNSHfyFabnf7TutUwGDmpi
 TkpPu8OvpHbPht3c4WA0Ii2fB/s8Q1LxlMI0k6sepIUC0QFBAiq8aeAYmel5caY1PJXQ
 YDXOAdS4ExVnhadesWwx1cWVKvH5PqvmTVMsbNJLbRWh4k5cD+ylaF24h8x47zQ24i8k
 AG+NRlaZdJknPEoyIlcy+4v6VAqlO3qa7fy6ulWiLtD1WuQVectf3yhMSPAwuNHL3QAv
 SRtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748843594; x=1749448394;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vPuEJZPFTvmnnxKx2qBHy+u2/akhfMU6ZEJbyKzkVEY=;
 b=tQmUYr8CVdwQPS/YbnGtTmR2zDl1Lbujdqk4VdJurrJJY/L9LxePE0mZGQZYmtC8Qy
 7wLvsaaORA3lr4YjRkz2aIpINyJS7r8/ijISro9bo9TfeoOwE2l8vBGbmFF5DoTe5wXy
 xNFgWS7+8lffrdo+qlLSnfvIlvKRyZjE1nsUdh6pwhN8CK2XNcHY5sI2oDakVP2uvFCy
 DiM6l4nQ+/HFOYJ472kExOtQewJYVjlZjFXUpxtz3PDEW1XLEUPvyZF4uhFgi6RKWBPB
 8jz8Avrj7VAEVhq30pKuNgMmn9alqAZhcQ5Mjp56diZ6KwW4Ks62CQVZGpW3C3Xw8e47
 uMrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHCIb/n+pt6ezwYazcVxFcZIwtvcmbG7MbVHgvfAmPQUFPqgD21doLQGvNkUlKyBUb5We2JmpCP1Du@nongnu.org,
 AJvYcCWN++s+1u/OTvJp1NkiP5DRgo1g3EPJ4TNN3PxkF3XQSgvIxF7i3pytmx8gbhE5hgCtOgD/LqqWoLSBaA==@nongnu.org
X-Gm-Message-State: AOJu0YyzqnjJqqYJxucwvswR4o2nONL9nmSAKkx8aDSZc8npl++rvQdH
 z2Po9PDUhsgEZ+uHATEMyINNra3mdvgwkYCz8riQK0ID71iFVL/jlxr1QMs8WDOZzwuAFYzBPzw
 tN2fkFX7x0D7XNbtbVsSPr7cxcA3LG4xrdQ==
X-Gm-Gg: ASbGncu/B2sjv9IWQLUHiICkxsNG4TKBdfl5OssfovjsClGldwuhfjDxePWr7uTpdbm
 +uLj0YYg7TfTHj4jaADP7vsTAT+iAHhThumeQoVJVErqjtkrs7dacBCkhGfdI6GqZZsO5p6LKOI
 h7hCLZzbm2FjtFr6PERI3yai54PpupOV8exjqAFqy5CSyswZIi5q/Lb9ezq3JAWjd5YL8mPW5kz
 A==
X-Google-Smtp-Source: AGHT+IHkfLpNxawnsvQX/0zOjlRXg5naoTXoj1q1+tPVeUbb5ytsMKTXFJc9wSlEL+hr3gQ73nyLJSzwkDrFyxR/XG0=
X-Received: by 2002:a05:6122:90d:b0:530:602c:4d4c with SMTP id
 71dfb90a1353d-5309366e9d4mr3733761e0c.1.1748841936246; Sun, 01 Jun 2025
 22:25:36 -0700 (PDT)
MIME-Version: 1.0
References: <20250425122212.364-1-wangran@bosc.ac.cn>
In-Reply-To: <20250425122212.364-1-wangran@bosc.ac.cn>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 2 Jun 2025 15:25:10 +1000
X-Gm-Features: AX0GCFu7GN67J9nyoP51AwJFrIHtQgAVNt95OLCi3-pjsfNbIWzahP2NTPjEypI
Message-ID: <CAKmqyKOzwxUSWPr5sO3+drHbG=cjmeG6u+EeTPFosnOHkHLFUw@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] target/riscv: Add BOSC's Xiangshan Kunminghu CPU
To: Ran Wang <wangran@bosc.ac.cn>
Cc: 3543977024@qq.com, palmer@dabbelt.com, alistair.francis@wdc.com, 
 liwei1518@gmail.com, dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, 
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2e;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2e.google.com
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

On Fri, Apr 25, 2025 at 10:22=E2=80=AFPM Ran Wang <wangran@bosc.ac.cn> wrot=
e:
>
> From: Huang Borong <3543977024@qq.com>
>
> Add a CPU entry for the Xiangshan Kunminghu CPU, an open-source,
> high-performance RISC-V processor. More details can be found at:
> https://github.com/OpenXiangShan/XiangShan
>
> Note: The ISA extensions supported by the Xiangshan Kunminghu CPU are
> categorized based on four RISC-V specifications: Volume I: Unprivileged
> Architecture, Volume II: Privileged Architecture, AIA, and RVA23. The
> extensions within each category are organized according to the chapter
> order in the specifications.
>
> Signed-off-by: Yu Hu <huyu@bosc.ac.cn>
> Signed-off-by: Ran Wang <wangran@bosc.ac.cn>
> Signed-off-by: Borong Huang <3543977024@qq.com>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu-qom.h |  1 +
>  target/riscv/cpu.c     | 64 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 65 insertions(+)
>
> diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
> index 1ee05eb393..75f4e43408 100644
> --- a/target/riscv/cpu-qom.h
> +++ b/target/riscv/cpu-qom.h
> @@ -55,6 +55,7 @@
>  #define TYPE_RISCV_CPU_VEYRON_V1        RISCV_CPU_TYPE_NAME("veyron-v1")
>  #define TYPE_RISCV_CPU_TT_ASCALON       RISCV_CPU_TYPE_NAME("tt-ascalon"=
)
>  #define TYPE_RISCV_CPU_XIANGSHAN_NANHU  RISCV_CPU_TYPE_NAME("xiangshan-n=
anhu")
> +#define TYPE_RISCV_CPU_XIANGSHAN_KMH    RISCV_CPU_TYPE_NAME("xiangshan-k=
unminghu")
>  #define TYPE_RISCV_CPU_HOST             RISCV_CPU_TYPE_NAME("host")
>
>  OBJECT_DECLARE_CPU_TYPE(RISCVCPU, RISCVCPUClass, RISCV_CPU)
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index ee20bd7ca2..1fde2769bf 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -3171,6 +3171,70 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
>          .cfg.max_satp_mode =3D VM_1_10_SV39,
>      ),
>
> +    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_XIANGSHAN_KMH, TYPE_RISCV_VENDOR_CPU=
,
> +        .misa_mxl_max =3D MXL_RV64,
> +        .misa_ext =3D RVG | RVC | RVB | RVS | RVU | RVH | RVV,
> +        .priv_spec =3D PRIV_VERSION_1_13_0,
> +
> +       /*
> +        * The RISC-V Instruction Set Manual: Volume I
> +        * Unprivileged Architecture
> +        */
> +       .cfg.ext_zicntr =3D true,
> +       .cfg.ext_zihpm =3D true,
> +       .cfg.ext_zihintntl =3D true,
> +       .cfg.ext_zihintpause =3D true,
> +       .cfg.ext_zimop =3D true,
> +       .cfg.ext_zcmop =3D true,
> +       .cfg.ext_zicond =3D true,
> +       .cfg.ext_zawrs =3D true,
> +       .cfg.ext_zacas =3D true,
> +       .cfg.ext_zfh =3D true,
> +       .cfg.ext_zfa =3D true,
> +       .cfg.ext_zcb =3D true,
> +       .cfg.ext_zbc =3D true,
> +       .cfg.ext_zvfh =3D true,
> +       .cfg.ext_zkn =3D true,
> +       .cfg.ext_zks =3D true,
> +       .cfg.ext_zkt =3D true,
> +       .cfg.ext_zvbb =3D true,
> +       .cfg.ext_zvkt =3D true,
> +
> +       /*
> +        * The RISC-V Instruction Set Manual: Volume II
> +        * Privileged Architecture
> +        */
> +       .cfg.ext_smstateen =3D true,
> +       .cfg.ext_smcsrind =3D true,
> +       .cfg.ext_sscsrind =3D true,
> +       .cfg.ext_svnapot =3D true,
> +       .cfg.ext_svpbmt =3D true,
> +       .cfg.ext_svinval =3D true,
> +       .cfg.ext_sstc =3D true,
> +       .cfg.ext_sscofpmf =3D true,
> +       .cfg.ext_ssdbltrp =3D true,
> +       .cfg.ext_ssnpm =3D true,
> +       .cfg.ext_smnpm =3D true,
> +       .cfg.ext_smmpm =3D true,
> +       .cfg.ext_sspm =3D true,
> +       .cfg.ext_supm =3D true,
> +
> +       /* The RISC-V Advanced Interrupt Architecture */
> +       .cfg.ext_smaia =3D true,
> +       .cfg.ext_ssaia =3D true,
> +
> +       /* RVA23 Profiles */
> +       .cfg.ext_zicbom =3D true,
> +       .cfg.ext_zicbop =3D true,
> +       .cfg.ext_zicboz =3D true,
> +       .cfg.ext_svade =3D true,
> +
> +        .cfg.mmu =3D true,
> +        .cfg.pmp =3D true,
> +
> +        .cfg.max_satp_mode =3D VM_1_10_SV48,
> +    ),
> +
>  #ifdef CONFIG_TCG
>      DEFINE_RISCV_CPU(TYPE_RISCV_CPU_BASE128, TYPE_RISCV_DYNAMIC_CPU,
>          .cfg.max_satp_mode =3D VM_1_10_SV57,
> --
> 2.34.1
>

