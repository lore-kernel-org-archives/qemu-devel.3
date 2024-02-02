Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A9FCC48286
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 02:10:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVj0H-0000cP-Nn; Thu, 01 Feb 2024 21:10:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rVj0G-0000bw-93; Thu, 01 Feb 2024 21:10:04 -0500
Received: from mail-vs1-xe35.google.com ([2607:f8b0:4864:20::e35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rVj0E-00062R-FV; Thu, 01 Feb 2024 21:10:04 -0500
Received: by mail-vs1-xe35.google.com with SMTP id
 ada2fe7eead31-46b3359f5efso684451137.3; 
 Thu, 01 Feb 2024 18:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706839801; x=1707444601; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AcTynJ2u8r9wEWjB+EAHYDZ+SAJqbZtbK0UuIuWZYb4=;
 b=euqUffDsdEmDrkEoSYEZ+of4WF0rCLEm+YQOLDVygaU0dN/mhAB02Wd5jnzDPzc8io
 mGQ7yWuEUdudb5dQd+Vuy/6vNszmgW0je1YMIYcKQrqOIx6U+JX7sgcZ4+xHYSnjC2XS
 RBWQw9IVsZ1Li8WmaP+o/zu6YyysYbD3egoG2UlwI7IL4RWsgedBpOAEAmafzWRrtwlN
 Deb1nwACznVLh7xhb0NP092MlHASFeBwICYP6blEyNjx4PDkFh3AX2TIfx6D30NjUsiL
 N3E6mlxcaArB72ATZnchEDVHoDgwVOubzcZzebO/7ljvf55jkb0e7hhrZYCmir1m/PqL
 oGwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706839801; x=1707444601;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AcTynJ2u8r9wEWjB+EAHYDZ+SAJqbZtbK0UuIuWZYb4=;
 b=YwIvq23Gc875jdvMhqo2JDJRIvqJ8YGeDPJhulHURUqJbjTOfSgZ9paTX0DsqStIqu
 rp8oNka91ViTT+tOF877t5nCo1EU02l2MFPmqgTpjdoTQf+RO3NIDC2p++YKD864mbeq
 VkhqmH1H6qomJcamMAsFKnxfvqSIoe6DvFQ0TO1lMWzts3924rPqLj0cUz4lvPY841kK
 XRYqUAqSagtjvkkgf8oDamhDrPgnpTQURq1zqNg6Id+Ak0L/jZnhXQ9F2+K5O3GdX6o9
 UTfSXOrNJkcRYpiOF3Uq+s8teBrqJuq1QUZ8YlP0lCFMApE8x4F9WyOQnX+x/V8ek9kM
 CSmA==
X-Gm-Message-State: AOJu0YyOVzbSIX1D9JTzyAD5UeWmhfxZLTDdUk1MtJFrN6M6rgjqcWrI
 DDVJFXKIlvTW5WwvxDvaVdLaU0eWv9r1CmwaffkdGkr5QNt7osEmz3u5EiCuwW77l2mYOKJpXlO
 HvBtdKb6DqxDLNMfFfQ1XNoyeZcdfEU4ToIc=
X-Google-Smtp-Source: AGHT+IGmcxMhjLL2w5t5iNa2MnSCZp2DSVpugoPxYdeIwqe6+Ipi5y6WLk5rboiFIofaDQr4i4HdBK0fut1556qLxE0=
X-Received: by 2002:a05:6102:214e:b0:46b:2e8:4ada with SMTP id
 h14-20020a056102214e00b0046b02e84adamr796599vsg.18.1706839800720; Thu, 01 Feb
 2024 18:10:00 -0800 (PST)
MIME-Version: 1.0
References: <20240131182430.20174-1-palmer@rivosinc.com>
In-Reply-To: <20240131182430.20174-1-palmer@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 2 Feb 2024 12:09:34 +1000
Message-ID: <CAKmqyKP6hFn9EJ_LzW-ogqErjBgZaeXp4+5sT0932T18fobU+g@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: Report the QEMU vendor/arch IDs on virtual CPUs
To: Palmer Dabbelt <palmer@rivosinc.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e35;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe35.google.com
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

On Thu, Feb 1, 2024 at 5:33=E2=80=AFAM Palmer Dabbelt <palmer@rivosinc.com>=
 wrote:
>
> Right now we just report 0 for marchid/mvendorid in QEMU.  That's legal,
> but it's tricky for users that want to check if they're running on QEMU
> to do so.  This sets marchid to 42, which I've proposed as the QEMU
> architecture ID (mvendorid remains 0, just explicitly set, as that's how
> the ISA handles open source implementations).
>
> Link: https://github.com/riscv/riscv-isa-manual/pull/1213

This has been accepted now :)

> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> ---
>  target/riscv/cpu.c          | 16 ++++++++++++++++
>  target/riscv/cpu_vendorid.h |  3 +++
>  2 files changed, 19 insertions(+)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 8cbfc7e781..1aef186f87 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -415,6 +415,9 @@ static void riscv_any_cpu_init(Object *obj)
>      cpu->cfg.ext_zicsr =3D true;
>      cpu->cfg.mmu =3D true;
>      cpu->cfg.pmp =3D true;
> +
> +    cpu->cfg.mvendorid =3D QEMU_MVENDORID;
> +    cpu->cfg.marchid =3D QEMU_MARCHID;
>  }
>
>  static void riscv_max_cpu_init(Object *obj)
> @@ -432,6 +435,8 @@ static void riscv_max_cpu_init(Object *obj)
>      set_satp_mode_max_supported(RISCV_CPU(obj), mlx =3D=3D MXL_RV32 ?
>                                  VM_1_10_SV32 : VM_1_10_SV57);
>  #endif
> +    cpu->cfg.mvendorid =3D QEMU_MVENDORID;
> +    cpu->cfg.marchid =3D QEMU_MARCHID;
>  }
>
>  #if defined(TARGET_RISCV64)
> @@ -445,6 +450,8 @@ static void rv64_base_cpu_init(Object *obj)
>  #ifndef CONFIG_USER_ONLY
>      set_satp_mode_max_supported(RISCV_CPU(obj), VM_1_10_SV57);
>  #endif
> +    cpu->cfg.mvendorid =3D QEMU_MVENDORID;
> +    cpu->cfg.marchid =3D QEMU_MARCHID;
>  }
>
>  static void rv64_sifive_u_cpu_init(Object *obj)
> @@ -569,6 +576,8 @@ static void rv128_base_cpu_init(Object *obj)
>  #ifndef CONFIG_USER_ONLY
>      set_satp_mode_max_supported(RISCV_CPU(obj), VM_1_10_SV57);
>  #endif
> +    cpu->cfg.mvendorid =3D QEMU_MVENDORID;
> +    cpu->cfg.marchid =3D QEMU_MARCHID;
>  }
>
>  static void rv64i_bare_cpu_init(Object *obj)
> @@ -591,6 +600,8 @@ static void rv64i_bare_cpu_init(Object *obj)
>  #ifndef CONFIG_USER_ONLY
>      set_satp_mode_max_supported(RISCV_CPU(obj), VM_1_10_SV64);
>  #endif
> +    cpu->cfg.mvendorid =3D QEMU_MVENDORID;
> +    cpu->cfg.marchid =3D QEMU_MARCHID;
>  }
>  #else
>  static void rv32_base_cpu_init(Object *obj)
> @@ -603,6 +614,8 @@ static void rv32_base_cpu_init(Object *obj)
>  #ifndef CONFIG_USER_ONLY
>      set_satp_mode_max_supported(RISCV_CPU(obj), VM_1_10_SV32);
>  #endif
> +    cpu->cfg.mvendorid =3D QEMU_MVENDORID;
> +    cpu->cfg.marchid =3D QEMU_MARCHID;
>  }
>
>  static void rv32_sifive_u_cpu_init(Object *obj)
> @@ -672,6 +685,9 @@ static void rv32_imafcu_nommu_cpu_init(Object *obj)
>      cpu->cfg.ext_zifencei =3D true;
>      cpu->cfg.ext_zicsr =3D true;
>      cpu->cfg.pmp =3D true;
> +
> +    cpu->cfg.mvendorid =3D QEMU_MVENDORID;
> +    cpu->cfg.marchid =3D QEMU_MARCHID;
>  }
>  #endif
>
> diff --git a/target/riscv/cpu_vendorid.h b/target/riscv/cpu_vendorid.h
> index 96b6b9c2cb..486832cd53 100644
> --- a/target/riscv/cpu_vendorid.h
> +++ b/target/riscv/cpu_vendorid.h
> @@ -7,4 +7,7 @@
>  #define VEYRON_V1_MIMPID        0x111
>  #define VEYRON_V1_MVENDORID     0x61f
>
> +#define QEMU_VIRT_MVENDORID     0
> +#define QEMU_VIRT_MARCHID       42

These aren't used. I think you meant to reference this from the CPU
init functions

Alistair

> +
>  #endif /*  TARGET_RISCV_CPU_VENDORID_H */
> --
> 2.43.0
>
>

