Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EC3CC5B543
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 03:12:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKTgp-0000s9-9g; Wed, 28 May 2025 23:12:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uKTgn-0000rW-6J; Wed, 28 May 2025 23:12:17 -0400
Received: from mail-vk1-xa2b.google.com ([2607:f8b0:4864:20::a2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uKTgk-0001YN-Tn; Wed, 28 May 2025 23:12:16 -0400
Received: by mail-vk1-xa2b.google.com with SMTP id
 71dfb90a1353d-52edc9ad68aso164339e0c.0; 
 Wed, 28 May 2025 20:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748488332; x=1749093132; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IN5Ub5STD3lUD6Eadw+k5IGgzuzFosvvJNPv1qkGSMI=;
 b=Bmj2HLpkXOcptnpRpOtMJV5kgYzL1j+KgqvueC8AzOvuR2tRPVIlCk9g9T5uOspLAR
 4a8JoWd0dR8NExY4hzhjL4u9nHB9x7zrA2ja6bBi3N9YDhd5CXlWehQw9rjAiC5hxDCV
 ZM//9jpvEG9BQo+9uPMa5NR35ps6UXE+cqTAMqAPrAxpHW3Cb5wCh1OQadxUM4ZkJQD4
 KT3nERKGC2sfBqx6mo3cLd1Z17TqUV71x+jXacEx1B8RMXNn0WwgwuLsIPTqssO/N67E
 55+MX94eXcURwpIrgFzvVbPWSiz4DgDcj9LLZg01kq/2z+T6/8ZgQ402WL3+ZNEM4kp/
 G0sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748488332; x=1749093132;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IN5Ub5STD3lUD6Eadw+k5IGgzuzFosvvJNPv1qkGSMI=;
 b=KjbQ7cK96u83merxUAP+dFTco/osictvlMq87lBQOmlDG1T+uZ06+RgJA9FgEtNAoz
 WY2Lg4MaUso0hZLtBbGIGFy/5t4XmGr5pvEKsU9u4EDNUTRivnVgr+ZcCZOkCXammfub
 sNlD2xxtbkcfbV0M69rGnvGo6ckaRVODaTMIOKDppkifnZ5PTFbMEgfYFz9hOqIl65dX
 /IrwlHNv5ovvQ8TG+XIpFZrUCm4LXgS3SpIQxcDRfUekGhpsbmEiiHuJak6REsi50LUV
 CpakCZGIavO50/JGcHOBSPnet1wMNOEiRblTugNdxQ9dQ4Ue7w8uwocH+OMSVyTPKC7E
 I5ow==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmmMxKGPGTc+FdSzf3aX8Ka0TjupfHVpjcIZ40+ALc6cdWlehwUDsRSragd4AUbSk6n+Jb0yXqWlPG@nongnu.org
X-Gm-Message-State: AOJu0YxXX5T9KVjX8CNx8OTd2S7pvPdiWupBH/q6q1FLbC/2tiLDA4m4
 T4fG0DsZgWzYJ2A4RkoKDxjzJOklE9ayw7iLehIydoKwh9yj8upf4PO1bESQi0u4fvBZnzcNxui
 d5aAtgy6vdefhTWYVf6cmjL8LPjOKWBh27g==
X-Gm-Gg: ASbGncukjScOQp7vIPE4jhn8bQkK2kBjJF6gNhv/XavVEbIgznSM8adW+G41K9mD4xP
 A82zeZUBtwPXB6AsYgDBOlV67zxSJMFhEAKoLxhS8ED+O2UwcvJTvglRyxLmMCdXtE09huFN/px
 +d3eGQP/HKRpKFfv7pB+Ls2NLxzqo5B8Xpl0WZq3aI54OKr2bThuWY3zXvktJ80BE=
X-Google-Smtp-Source: AGHT+IHUHDFMT7waReGOCuPTv1h6Js1MNK3RWmZyStUGFLxbkuaKTt12MH5jex01gDnTXfpBCKJAkYtq8UzKc7YfRMM=
X-Received: by 2002:a05:6122:d9b:b0:526:1ddc:6354 with SMTP id
 71dfb90a1353d-52f2c310e57mr14173288e0c.0.1748488332359; Wed, 28 May 2025
 20:12:12 -0700 (PDT)
MIME-Version: 1.0
References: <20250520172336.759708-1-dbarboza@ventanamicro.com>
 <20250520172336.759708-4-dbarboza@ventanamicro.com>
In-Reply-To: <20250520172336.759708-4-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 29 May 2025 13:11:46 +1000
X-Gm-Features: AX0GCFshPU625s5KyIQEbXBGKTy72Be8TUSfPswd72hYk9wXkcmjCGUdDDv2duI
Message-ID: <CAKmqyKP6LEWOviTX+ayVcFpfdSP+yEwkw6XP2dki8C036xvR1Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] target/riscv: add profile->present flag
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com, 
 ajones@ventanamicro.com, bjorn@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2b;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2b.google.com
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

On Wed, May 21, 2025 at 3:24=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Bj=C3=B6rn reported in [1] a case where a rv64 CPU is going through the
> profile code path to enable satp mode. In this case,the amount of
> extensions on top of the rv64 CPU made it compliant with the RVA22S64
> profile during the validation of CPU 0. When the subsequent CPUs were
> initialized the static profile object has the 'enable' flag set,
> enabling the profile code path for those CPUs.
>
> This happens because we are initializing and realizing each CPU before
> going to the next, i.e. init and realize CPU0, then init and realize
> CPU1 and so on. If we change any persistent state during the validation
> of CPU N it will interfere with the init/realization of CPU N+1.
>
> We're using the 'enabled' profile flag to do two distinct things: inform
> cpu_init() that we want profile extensions to be enabled, and telling
> QMP that a profile is currently enabled in the CPU. We want to be
> flexible enough to recognize profile support for all CPUs that has the
> extension prerequisites, but we do not want to force the profile code
> path if a profile wasn't set too.
>
> Add a new 'present' flag for profiles that will coexist with the 'enabled=
'
> flag. Enabling a profile means "we want to switch on all its mandatory
> extensions". A profile is 'present' if we asserted during validation
> that the CPU has the needed prerequisites.
>
> This means that the case reported by Bj=C3=B6rn now results in
> RVA22S64.enabled=3Dfalse and RVA22S64.present=3Dtrue. QMP will recognize =
it
> as a RVA22 compliant CPU and we won't force the CPU into the profile
> path.
>
> [1] https://lore.kernel.org/qemu-riscv/87y0usiz22.fsf@all.your.base.are.b=
elong.to.us/
>
> Reported-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
> Fixes: 2af005d610 ("target/riscv/tcg: validate profiles during finalize")
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.h            | 15 +++++++++++++++
>  target/riscv/riscv-qmp-cmds.c |  2 +-
>  target/riscv/tcg/tcg-cpu.c    | 11 +++--------
>  3 files changed, 19 insertions(+), 9 deletions(-)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index b56d3afa69..82ca41d55b 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -82,7 +82,22 @@ typedef struct riscv_cpu_profile {
>      struct riscv_cpu_profile *s_parent;
>      const char *name;
>      uint32_t misa_ext;
> +    /*
> +     * The profile is enabled/disabled via command line or
> +     * via cpu_init(). Enabling a profile will add all its
> +     * mandatory extensions in the CPU during init().
> +     */
>      bool enabled;
> +    /*
> +     * The profile is present in the CPU, i.e. the current set of
> +     * CPU extensions complies with it. A profile can be enabled
> +     * and not present (e.g. the user disabled a mandatory extension)
> +     * and the other way around (e.g. all mandatory extensions are
> +     * present in a non-profile CPU).
> +     *
> +     * QMP uses this flag.
> +     */
> +    bool present;
>      bool user_set;
>      int priv_spec;
>      int satp_mode;
> diff --git a/target/riscv/riscv-qmp-cmds.c b/target/riscv/riscv-qmp-cmds.=
c
> index d0a324364d..ad8efd180d 100644
> --- a/target/riscv/riscv-qmp-cmds.c
> +++ b/target/riscv/riscv-qmp-cmds.c
> @@ -121,7 +121,7 @@ static void riscv_obj_add_profiles_qdict(Object *obj,=
 QDict *qdict_out)
>
>      for (int i =3D 0; riscv_profiles[i] !=3D NULL; i++) {
>          profile =3D riscv_profiles[i];
> -        value =3D QOBJECT(qbool_from_bool(profile->enabled));
> +        value =3D QOBJECT(qbool_from_bool(profile->present));
>
>          qdict_put_obj(qdict_out, profile->name, value);
>      }
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index af202c92a3..396fac0938 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -840,16 +840,11 @@ static void riscv_cpu_check_parent_profile(RISCVCPU=
 *cpu,
>                                             RISCVCPUProfile *profile,
>                                             RISCVCPUProfile *parent)
>  {
> -    const char *parent_name;
> -    bool parent_enabled;
> -
> -    if (!profile->enabled || !parent) {
> +    if (!profile->present || !parent) {
>          return;
>      }
>
> -    parent_name =3D parent->name;
> -    parent_enabled =3D object_property_get_bool(OBJECT(cpu), parent_name=
, NULL);
> -    profile->enabled =3D parent_enabled;
> +    profile->present =3D parent->present;
>  }
>
>  static void riscv_cpu_validate_profile(RISCVCPU *cpu,
> @@ -910,7 +905,7 @@ static void riscv_cpu_validate_profile(RISCVCPU *cpu,
>          }
>      }
>
> -    profile->enabled =3D profile_impl;
> +    profile->present =3D profile_impl;
>
>      riscv_cpu_check_parent_profile(cpu, profile, profile->u_parent);
>      riscv_cpu_check_parent_profile(cpu, profile, profile->s_parent);
> --
> 2.49.0
>
>

