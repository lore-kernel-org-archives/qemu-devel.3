Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B9FEC19F32
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 01:42:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tq0FU-0003eY-8M; Wed, 05 Mar 2025 20:42:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tq0FS-0003dp-2X
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 20:42:06 -0500
Received: from mail-ua1-x934.google.com ([2607:f8b0:4864:20::934])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tq0FQ-0007wL-6C
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 20:42:05 -0500
Received: by mail-ua1-x934.google.com with SMTP id
 a1e0cc1a2514c-86b9b1def28so95702241.3
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 17:42:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741225323; x=1741830123; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I+QUAMxKOz4zfJ17xHGP3xsg5q/Py85YYAh5vc9CNUE=;
 b=HJcJ1SYX6pUXcLuyVpZwMBZe8euWhBiJ/hHUVjEfUXCqxsT9jPKYxB2cgDAdsdr2UB
 xPdPjZlJKplahOZzCFEpPPVqs+koIKXNaRpXRHRLOY1Hfytz+ueaxm+tjZVKtO4CHKCb
 Eyla8Uc2VOH3qjqQ4oikU+ZIR22eKzEXxi73iZJPRXl5zuPE4tV8Wj0jjRDaKKb5pH2q
 Xm3dLgPQIMJ0rD0dBJxidQsOU30YIyUaIfr+AeWNuUCNDfaqoYL9HklGYMSISh0v1/z/
 Xwz7d0TuyTt7eCelIMC6MhOIdsq+b9fX5jWJhGI+W586kss+7o9nrhzJ/jRd7F0eP+FN
 lE8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741225323; x=1741830123;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I+QUAMxKOz4zfJ17xHGP3xsg5q/Py85YYAh5vc9CNUE=;
 b=W7jp0bYqbi1B082SwTwriR0TRMo1xliFN7RLTVw6P/Q9ZMlnSD5twNnd1yL4nsDufy
 EsrGeiM+OqNbexo3bZbqWjhdKDmwliYVZBVnyy4sO6LzNgSkFWroIuV6Sg5oCISKFXy9
 JhHFTiqYRhRwGKUsNYf/g/QYgTfYUc9aNBzfFOhOua0Mu6p1pMbip8U6GzRp3gIDlOT3
 uOkZ5UZsuO4SmbW1vOXy2EYekJ42UdvWFVCFBAw9eNpddSVwPYO1GXwaq+rERPVp+55r
 mHRa8EBcVdM26xPzom3L5gvJZAt5Vr/terRV6My7/G31HeUOladpXBzqHRKCw41idVZp
 uaJA==
X-Gm-Message-State: AOJu0YyunHiwMnxHqmcuTWSJJLw6qXLirqbTbvJjUhSoSLPEb1wRAEkj
 ipMgbroK+j3GGDp2OqIV28RerNWrbMmMdfpfPdX5E5guquIztdbdESn4HDoBPPUbPguTXwVdRTy
 hfdI4SZO4M9z0mScjTAXcou5UPJk=
X-Gm-Gg: ASbGncux2yRaHlIebfy3YkJhuxlC+Ij7kl63iBG60/YaA9sihwLXRW4YR7TVIRVsrYD
 GD/eeI4QTkx/qwB3W38gNod0CzTKKnAqb2hGdWcbRUNPjKtco/AdKUH2vf/mQatx1dHPkB9wO/j
 /Yt+IILf6g33l2YwJJ9IZOZQGRBPtxECI2BN5b16VbpBU28kib+hAlJkNj
X-Google-Smtp-Source: AGHT+IGiaNduV+NxdKgZZWWyi2u01LG17ugTsp6wJPnG23uOmZ1TRQvLfiQgWXLngmWDXAH2/KyyTAGPSVBUhpV3qgw=
X-Received: by 2002:a05:6102:5113:b0:4bb:e1c9:80b4 with SMTP id
 ada2fe7eead31-4c2e2427f83mr3968458137.0.1741225322985; Wed, 05 Mar 2025
 17:42:02 -0800 (PST)
MIME-Version: 1.0
References: <20250218165757.554178-1-pbonzini@redhat.com>
 <20250218165757.554178-6-pbonzini@redhat.com>
In-Reply-To: <20250218165757.554178-6-pbonzini@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 6 Mar 2025 11:41:37 +1000
X-Gm-Features: AQ5f1Jp7sNUD5GCZfK4cXlLEMikqHzSO0XoZA_Cj0-231pIzu-zyYMtmIgrNLrM
Message-ID: <CAKmqyKMBMDtkHrRCvypbumOW9qfZiN9LQF=V1Zn_tgSV6F3v6Q@mail.gmail.com>
Subject: Re: [PATCH 5/7] target/riscv: update max_satp_mode based on QOM
 properties
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::934;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x934.google.com
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

On Wed, Feb 19, 2025 at 2:59=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> Almost all users of cpu->cfg.satp_mode care only about the "max" value
> satp_mode_max_from_map(cpu->cfg.satp_mode.map); convert the QOM
> properties back into it.  For TCG, consult valid_vm[] instead of
> the bitmap of accepted modes.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.h         |  1 -
>  hw/riscv/virt-acpi-build.c | 14 +++++---------
>  hw/riscv/virt.c            |  5 ++---
>  target/riscv/cpu.c         | 27 ++++++++++-----------------
>  target/riscv/csr.c         |  9 +++++++--
>  5 files changed, 24 insertions(+), 32 deletions(-)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 97713681cbe..f9b223bf8a7 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -911,7 +911,6 @@ void riscv_cpu_register_gdb_regs_for_features(CPUStat=
e *cs);
>  target_ulong riscv_new_csr_seed(target_ulong new_value,
>                                  target_ulong write_mask);
>
> -uint8_t satp_mode_max_from_map(uint32_t map);
>  const char *satp_mode_str(uint8_t satp_mode, bool is_32_bit);
>
>  /* Implemented in th_csr.c */
> diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
> index 2b374ebacbf..1a92a84207d 100644
> --- a/hw/riscv/virt-acpi-build.c
> +++ b/hw/riscv/virt-acpi-build.c
> @@ -261,7 +261,6 @@ static void build_rhct(GArray *table_data,
>      uint32_t isa_offset, num_rhct_nodes, cmo_offset =3D 0;
>      RISCVCPU *cpu =3D &s->soc[0].harts[0];
>      uint32_t mmu_offset =3D 0;
> -    uint8_t satp_mode_max;
>      bool rv32 =3D riscv_cpu_is_32bit(cpu);
>      g_autofree char *isa =3D NULL;
>
> @@ -282,8 +281,7 @@ static void build_rhct(GArray *table_data,
>          num_rhct_nodes++;
>      }
>
> -    if (!rv32 && cpu->cfg.satp_mode.supported !=3D 0 &&
> -        (cpu->cfg.satp_mode.map & ~(1 << VM_1_10_MBARE))) {
> +    if (!rv32 && cpu->cfg.max_satp_mode >=3D VM_1_10_SV39) {
>          num_rhct_nodes++;
>      }
>
> @@ -343,20 +341,18 @@ static void build_rhct(GArray *table_data,
>      }
>
>      /* MMU node structure */
> -    if (!rv32 && cpu->cfg.satp_mode.supported !=3D 0 &&
> -        (cpu->cfg.satp_mode.map & ~(1 << VM_1_10_MBARE))) {
> -        satp_mode_max =3D satp_mode_max_from_map(cpu->cfg.satp_mode.map)=
;
> +    if (!rv32 && cpu->cfg.max_satp_mode >=3D VM_1_10_SV39) {
>          mmu_offset =3D table_data->len - table.table_offset;
>          build_append_int_noprefix(table_data, 2, 2);    /* Type */
>          build_append_int_noprefix(table_data, 8, 2);    /* Length */
>          build_append_int_noprefix(table_data, 0x1, 2);  /* Revision */
>          build_append_int_noprefix(table_data, 0, 1);    /* Reserved */
>          /* MMU Type */
> -        if (satp_mode_max =3D=3D VM_1_10_SV57) {
> +        if (cpu->cfg.max_satp_mode =3D=3D VM_1_10_SV57) {
>              build_append_int_noprefix(table_data, 2, 1);    /* Sv57 */
> -        } else if (satp_mode_max =3D=3D VM_1_10_SV48) {
> +        } else if (cpu->cfg.max_satp_mode =3D=3D VM_1_10_SV48) {
>              build_append_int_noprefix(table_data, 1, 1);    /* Sv48 */
> -        } else if (satp_mode_max =3D=3D VM_1_10_SV39) {
> +        } else if (cpu->cfg.max_satp_mode =3D=3D VM_1_10_SV39) {
>              build_append_int_noprefix(table_data, 0, 1);    /* Sv39 */
>          } else {
>              g_assert_not_reached();
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 241389d72f8..2394fc71df4 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -236,10 +236,10 @@ static void create_fdt_socket_cpus(RISCVVirtState *=
s, int socket,
>      uint32_t cpu_phandle;
>      MachineState *ms =3D MACHINE(s);
>      bool is_32_bit =3D riscv_is_32bit(&s->soc[0]);
> -    uint8_t satp_mode_max;
>
>      for (cpu =3D s->soc[socket].num_harts - 1; cpu >=3D 0; cpu--) {
>          RISCVCPU *cpu_ptr =3D &s->soc[socket].harts[cpu];
> +        int8_t satp_mode_max =3D cpu_ptr->cfg.max_satp_mode;
>          g_autofree char *cpu_name =3D NULL;
>          g_autofree char *core_name =3D NULL;
>          g_autofree char *intc_name =3D NULL;
> @@ -251,8 +251,7 @@ static void create_fdt_socket_cpus(RISCVVirtState *s,=
 int socket,
>              s->soc[socket].hartid_base + cpu);
>          qemu_fdt_add_subnode(ms->fdt, cpu_name);
>
> -        if (cpu_ptr->cfg.satp_mode.supported !=3D 0) {
> -            satp_mode_max =3D satp_mode_max_from_map(cpu_ptr->cfg.satp_m=
ode.map);
> +        if (satp_mode_max !=3D -1) {
>              sv_name =3D g_strdup_printf("riscv,%s",
>                                        satp_mode_str(satp_mode_max, is_32=
_bit));
>              qemu_fdt_setprop_string(ms->fdt, cpu_name, "mmu-type", sv_na=
me);
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 2d06543217a..ce71ee95a52 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -387,7 +387,7 @@ static uint8_t satp_mode_from_str(const char *satp_mo=
de_str)
>      g_assert_not_reached();
>  }
>
> -uint8_t satp_mode_max_from_map(uint32_t map)
> +static uint8_t satp_mode_max_from_map(uint32_t map)
>  {
>      /*
>       * 'map =3D 0' will make us return (31 - 32), which C will
> @@ -453,15 +453,13 @@ static void set_satp_mode_default_map(RISCVCPU *cpu=
)
>      /*
>       * Bare CPUs do not default to the max available.
>       * Users must set a valid satp_mode in the command
> -     * line.
> +     * line.  Otherwise, leave the existing max_satp_mode
> +     * in place.
>       */
>      if (object_dynamic_cast(OBJECT(cpu), TYPE_RISCV_BARE_CPU) !=3D NULL)=
 {
>          warn_report("No satp mode set. Defaulting to 'bare'");
> -        cpu->cfg.satp_mode.map =3D (1 << VM_1_10_MBARE);
> -        return;
> +        cpu->cfg.max_satp_mode =3D VM_1_10_MBARE;
>      }
> -
> -    cpu->cfg.satp_mode.map =3D cpu->cfg.satp_mode.supported;
>  }
>  #endif
>
> @@ -1180,8 +1178,8 @@ static void riscv_cpu_satp_mode_finalize(RISCVCPU *=
cpu, Error **errp)
>      bool rv32 =3D riscv_cpu_is_32bit(cpu);
>      uint8_t satp_mode_map_max;
>
> -    /* The CPU wants the OS to decide which satp mode to use */
> -    if (cpu->cfg.satp_mode.supported =3D=3D 0) {
> +    if (cpu->cfg.max_satp_mode =3D=3D -1) {
> +        /* The CPU wants the hypervisor to decide which satp mode to all=
ow */
>          return;
>      }
>
> @@ -1200,14 +1198,14 @@ static void riscv_cpu_satp_mode_finalize(RISCVCPU=
 *cpu, Error **errp)
>                      (cpu->cfg.satp_mode.supported & (1 << i))) {
>                      for (int j =3D i - 1; j >=3D 0; --j) {
>                          if (cpu->cfg.satp_mode.supported & (1 << j)) {
> -                            cpu->cfg.satp_mode.map |=3D (1 << j);
> -                            break;
> +                            cpu->cfg.max_satp_mode =3D j;
> +                            return;
>                          }
>                      }
> -                    break;
>                  }
>              }
>          }
> +        return;
>      }
>
>      satp_mode_map_max =3D satp_mode_max_from_map(cpu->cfg.satp_mode.map)=
;
> @@ -1237,12 +1235,7 @@ static void riscv_cpu_satp_mode_finalize(RISCVCPU =
*cpu, Error **errp)
>          }
>      }
>
> -    /* Finally expand the map so that all valid modes are set */
> -    for (int i =3D satp_mode_map_max - 1; i >=3D 0; --i) {
> -        if (cpu->cfg.satp_mode.supported & (1 << i)) {
> -            cpu->cfg.satp_mode.map |=3D (1 << i);
> -        }
> -    }
> +    cpu->cfg.max_satp_mode =3D satp_mode_map_max;
>  }
>  #endif
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index afb7544f078..78db9aeda57 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -1862,8 +1862,13 @@ static RISCVException read_mstatus(CPURISCVState *=
env, int csrno,
>
>  static bool validate_vm(CPURISCVState *env, target_ulong vm)
>  {
> -    uint64_t mode_supported =3D riscv_cpu_cfg(env)->satp_mode.map;
> -    return get_field(mode_supported, (1 << vm));
> +    bool rv32 =3D riscv_cpu_mxl(env) =3D=3D MXL_RV32;
> +    RISCVCPU *cpu =3D env_archcpu(env);
> +    int satp_mode_supported_max =3D cpu->cfg.max_satp_mode;
> +    const bool *valid_vm =3D rv32 ? valid_vm_1_10_32 : valid_vm_1_10_64;
> +
> +    assert(satp_mode_supported_max >=3D 0);
> +    return vm <=3D satp_mode_supported_max && valid_vm[vm];
>  }
>
>  static target_ulong legalize_xatp(CPURISCVState *env, target_ulong old_x=
atp,
> --
> 2.48.1
>
>

