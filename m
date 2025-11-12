Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4DAACCFA1A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 04:32:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJ2Wf-0006hZ-HZ; Tue, 11 Nov 2025 23:32:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vJ2Wd-0006QQ-Ey
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 23:32:07 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vJ2WU-00055l-FJ
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 23:32:00 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-6418b55f86dso467300a12.1
 for <qemu-devel@nongnu.org>; Tue, 11 Nov 2025 20:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762921917; x=1763526717; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ziZqvF67nLcLVJqIbpq+9tLEFSJtVU/AqKzeqaL6SZU=;
 b=iTt1PuOqcYkFpruFyBI1yR7wMe/mGg1FYor1A2NYuLdmFTD8RlRdZnQGSqDJPNL+WK
 pS7NgbdV/7PtWbbwo26aEtap2maUzWG6Tbwpo5N5+8M98sFZOV4Uketakw0RWXoKCb3z
 sOZhMM7Efuofck1MdvcqqEIwwSXmO2iRVbm2Hx6qNybYE9F5RpggRUQTf4vRBcQNz4mC
 c7YHMlTAjfd8UQaWg75olGAbIZYqjGfC3efK5o1XzpqP/J5s+oDrZAUd/p18IGJ/2ZTs
 GcMkAxd/T3KllGdIxxNK6oYzR/Fuk2DRzM4YPB/Vr+tP5rTxmN8Ph63A/c1K3Im59run
 2Hkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762921917; x=1763526717;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ziZqvF67nLcLVJqIbpq+9tLEFSJtVU/AqKzeqaL6SZU=;
 b=PFf8r+vtYUMBhHuzk800e3lTfHibRR6wbB1ttC5l6HCRYUL8FB5L/GQKW9IPhqJyVa
 9X1v8Ra7Qvohk+DfBd8F2lDxoOQPJhpaevxCN3rmivQULhuWSnnkUF8PjbLXRBHj/yVG
 EsVtBVz5Rt8d1YWrZkyyQnIsU2XQb5GioAqql2poqo3hjS/7pe/N+kqE4nij7ZQvchk9
 4bFlDOgKe/Kq6YBBxKkLzadvuKfLxcd5EdnCKIqJYwDPNS5M4CCRaesTDSPFryXt8cdl
 XhB8b1nolAfCgUP8NOzZYMwzcCAhwopKmhvYo02HkBNyVlpeCWNt/6Arov/XYBM8iPbq
 63iQ==
X-Gm-Message-State: AOJu0YzI8twI/zpRFgAC6vEQITcX99EpiM9TzFIFkVf0S+rnCDf/xfJT
 qyFpdbN+HOJW0sEUxrWJA+C2A1MJyrHdq4CBZbqsUYCsdFUCzYgqs8ojqPvdmXhXHPdK5dFuS33
 RalVIbBEKgRtN3QFw72yseu5K3L36y/c=
X-Gm-Gg: ASbGncsTgx3sLdytEmQkLCifFbPvbrfxeUkQrEsgs99z3i3GIytZHSgXo5X0T+lk/LA
 3o7VYjS9cXkqOrgCZ94HyFt0cPSoiVRQYxGkVAAw5/MmHPdMVszYj1cv2+s876JLnKvWxPGICHa
 2XpHgoXp1C5hBkME3ff14/oT00sylYXglvoYwsvrFEfuUdkn61Q7crBzKnQ8qTrOGy5fFdX4YrT
 kwCmp/AxTH2R90WPdPjB3h2hQjFTq9F7tKC1zRpOHehnPqZ5757BbtC/zIZ6bbpWRI27OEo3szB
 0ElXqB8ovNfFSaE=
X-Google-Smtp-Source: AGHT+IHDGd9vz1nmw/oElBP3ANJXnMdcvpR2mGaaaY6zkh2OaBBxx0Q4lOA7bIssPxSPbenskn3QiuGFB+8qXjtXQm4=
X-Received: by 2002:a17:907:7f8d:b0:b5c:753a:a4d8 with SMTP id
 a640c23a62f3a-b7331c0c8bemr141788366b.62.1762921916669; Tue, 11 Nov 2025
 20:31:56 -0800 (PST)
MIME-Version: 1.0
References: <20250918061911.904-1-zhiwei_liu@linux.alibaba.com>
 <20250918061911.904-3-zhiwei_liu@linux.alibaba.com>
In-Reply-To: <20250918061911.904-3-zhiwei_liu@linux.alibaba.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 12 Nov 2025 14:31:30 +1000
X-Gm-Features: AWmQ_bnzbJUxTAjR0gsNYe4TixxYZewWSGbsgCbpiX_V2HsveOS9nE-pdrjHvIo
Message-ID: <CAKmqyKM9rGk+b6q_6mfwP_RL-GMhgiKZhRC_QJtgKvA394aeSQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] target/riscv: Implement core SMMPT lookup logic
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, palmer@dabbelt.com, 
 alistair.francis@wdc.com, dbarboza@ventanamicro.com, liwei1518@gmail.com, 
 Huang Tao <eric.huang@linux.alibaba.com>,
 TANG Tiancheng <lyndra@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52d.google.com
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

On Thu, Sep 18, 2025 at 4:21=E2=80=AFPM LIU Zhiwei <zhiwei_liu@linux.alibab=
a.com> wrote:
>
> This patch introduces the core implementation for the Memory Protection T=
able
> (MPT) walk, which is the central mechanism of the SMMPT extension.
>
> A new file, `riscv_smmpt.c`, is added to encapsulate the MPT logic. It
> implements the `smmpt_lookup()` function, which performs a multi-level
> page table-like walk starting from the physical address specified in the
> `mptppn` CSR field. This walk determines the access permissions (read,
> write, execute) for a given physical address.
>
> The implementation supports various SMMPT modes (SMMPT34, SMMPT43, etc.) =
and
> correctly handles leaf and non-leaf entries, including reserved bit
> checks. Helper functions for parsing MPT entries and converting access
> permissions are also included in the new `riscv_smmpt.h` header.
>
> Co-authored-by: Huang Tao <eric.huang@linux.alibaba.com>
> Co-authored-by: TANG Tiancheng <lyndra@linux.alibaba.com>
> Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
> ---
>  target/riscv/meson.build   |   1 +
>  target/riscv/pmp.h         |   3 +
>  target/riscv/riscv_smmpt.c | 274 +++++++++++++++++++++++++++++++++++++
>  target/riscv/riscv_smmpt.h |  15 ++
>  4 files changed, 293 insertions(+)
>  create mode 100644 target/riscv/riscv_smmpt.c

This patch fails to build:

../target/riscv/cpu_helper.c:1092:12: error: static declaration of
=E2=80=98get_physical_address_pmp=E2=80=99 follows non-static declaration
1092 | static int get_physical_address_pmp(CPURISCVState *env, int
*prot, hwaddr addr,
     |            ^~~~~~~~~~~~~~~~~~~~~~~~
In file included from ../target/riscv/cpu.h:183,
                from ../target/riscv/cpu_helper.c:23:
../target/riscv/pmp.h:88:5: note: previous declaration of
=E2=80=98get_physical_address_pmp=E2=80=99 with type =E2=80=98int(CPURISCVS=
tate *, int *,
hwaddr,  int,  MMUAccessType,  i
nt)=E2=80=99 {aka =E2=80=98int(struct CPUArchState *, int *, long unsigned =
int,  int,
MMUAccessType,  int)=E2=80=99}
  88 | int get_physical_address_pmp(CPURISCVState *env, int *prot, hwaddr a=
ddr,
     |     ^~~~~~~~~~~~~~~~~~~~~~~~
ninja: build stopped: subcommand failed.

Alistair

>
> diff --git a/target/riscv/meson.build b/target/riscv/meson.build
> index a4bd61e52a..e85b534a64 100644
> --- a/target/riscv/meson.build
> +++ b/target/riscv/meson.build
> @@ -29,6 +29,7 @@ riscv_system_ss =3D ss.source_set()
>  riscv_system_ss.add(files(
>    'arch_dump.c',
>    'pmp.c',
> +  'riscv_smmpt.c',
>    'debug.c',
>    'monitor.c',
>    'machine.c',
> diff --git a/target/riscv/pmp.h b/target/riscv/pmp.h
> index 271cf24169..d9c5e74345 100644
> --- a/target/riscv/pmp.h
> +++ b/target/riscv/pmp.h
> @@ -85,6 +85,9 @@ void pmp_update_rule_nums(CPURISCVState *env);
>  uint32_t pmp_get_num_rules(CPURISCVState *env);
>  int pmp_priv_to_page_prot(pmp_priv_t pmp_priv);
>  void pmp_unlock_entries(CPURISCVState *env);
> +int get_physical_address_pmp(CPURISCVState *env, int *prot, hwaddr addr,
> +                             int size, MMUAccessType access_type,
> +                             int mode);
>
>  #define MSECCFG_MML_ISSET(env) get_field(env->mseccfg, MSECCFG_MML)
>  #define MSECCFG_MMWP_ISSET(env) get_field(env->mseccfg, MSECCFG_MMWP)
> diff --git a/target/riscv/riscv_smmpt.c b/target/riscv/riscv_smmpt.c
> new file mode 100644
> index 0000000000..b7b47c5ae1
> --- /dev/null
> +++ b/target/riscv/riscv_smmpt.c
> @@ -0,0 +1,274 @@
> +/*
> + * QEMU RISC-V Smmpt (Memory Protection Table)
> + *
> + * Copyright (c) 2024 Alibaba Group. All rights reserved.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "riscv_smmpt.h"
> +#include "pmp.h"
> +#include "system/memory.h"
> +
> +typedef uint64_t load_entry_fn(AddressSpace *, hwaddr,
> +                               MemTxAttrs, MemTxResult *);
> +
> +static uint64_t load_entry_32(AddressSpace *as, hwaddr addr,
> +                              MemTxAttrs attrs, MemTxResult *result)
> +{
> +    return address_space_ldl(as, addr, attrs, result);
> +}
> +
> +static uint64_t load_entry_64(AddressSpace *as, hwaddr addr,
> +                              MemTxAttrs attrs, MemTxResult *result)
> +{
> +    return address_space_ldq(as, addr, attrs, result);
> +}
> +
> +typedef union {
> +    uint64_t raw;
> +    struct {
> +        uint32_t v:1;
> +        uint32_t l:1;
> +        uint32_t rsv1:5;
> +        uint32_t perms:24;
> +        uint32_t n:1;
> +    } leaf32;
> +    struct {
> +        uint32_t v:1;
> +        uint32_t l:1;
> +        uint32_t rsv1:8;
> +        uint32_t ppn:22;
> +    } nonleaf32;
> +    struct {
> +        uint64_t v:1;
> +        uint64_t l:1;
> +        uint64_t rsv1:8;
> +        uint64_t perms:48;
> +        uint64_t rsv2:5;
> +        uint64_t n:1;
> +    } leaf64;
> +    struct {
> +        uint64_t v:1;
> +        uint64_t l:1;
> +        uint64_t rsv1:8;
> +        uint64_t ppn:52;
> +        uint64_t rsv2:1;
> +        uint64_t n:1;
> +    } nonleaf64;
> +} mpte_union_t;
> +
> +static inline bool mpte_is_leaf(uint64_t mpte)
> +{
> +   return mpte & 0x2;
> +}
> +
> +static inline bool mpte_is_valid(uint64_t mpte)
> +{
> +    return mpte & 0x1;
> +}
> +
> +static uint64_t mpte_get_rsv(CPURISCVState *env, uint64_t mpte)
> +{
> +    RISCVMXL mxl =3D riscv_cpu_mxl(env);
> +    bool leaf =3D mpte_is_leaf(mpte);
> +    mpte_union_t *u =3D (mpte_union_t *)&mpte;
> +
> +    if (mxl =3D=3D MXL_RV32) {
> +        return leaf ? u->leaf32.rsv1 : u->nonleaf32.rsv1;
> +    }
> +    return leaf ? (u->leaf64.rsv1 << 5) | u->leaf64.rsv2
> +                : (u->nonleaf64.rsv1 << 1) | u->nonleaf64.rsv2;
> +}
> +
> +static uint64_t mpte_get_perms(CPURISCVState *env, uint64_t mpte)
> +{
> +    RISCVMXL mxl =3D riscv_cpu_mxl(env);
> +    mpte_union_t *u =3D (mpte_union_t *)&mpte;
> +
> +    return (mxl =3D=3D MXL_RV32) ? u->leaf32.perms : u->leaf64.perms;
> +}
> +
> +static bool mpte_check_nlnapot(CPURISCVState *env, uint64_t mpte, bool *=
nlnapot)
> +{
> +    RISCVMXL mxl =3D riscv_cpu_mxl(env);
> +    mpte_union_t *u =3D (mpte_union_t *)&mpte;
> +    if (mxl =3D=3D MXL_RV32) {
> +        *nlnapot =3D false;
> +        return true;
> +    }
> +    *nlnapot =3D u->nonleaf64.n;
> +    return u->nonleaf64.n ? (u->nonleaf64.ppn & 0x1ff) =3D=3D 0x100 : tr=
ue;
> +}
> +
> +static uint64_t mpte_get_ppn(CPURISCVState *env, uint64_t mpte, int pn,
> +                             bool nlnapot)
> +{
> +    RISCVMXL mxl =3D riscv_cpu_mxl(env);
> +    mpte_union_t *u =3D (mpte_union_t *)&mpte;
> +
> +    if (nlnapot) {
> +        return deposit64(u->nonleaf64.ppn, 0, 9, pn & 0x1ff);
> +    }
> +    return (mxl =3D=3D MXL_RV32) ? u->nonleaf32.ppn : u->nonleaf64.ppn;
> +}
> +
> +/* Caller should assert i before call this interface */
> +static int mpt_get_pn(hwaddr addr, int i, mpt_mode_t mode)
> +{
> +    if (mode =3D=3D SMMPT34) {
> +        return i =3D=3D 0
> +            ? extract64(addr, 15, 10)
> +            : extract64(addr, 25, 9);
> +    } else {
> +        int offset =3D 16 + i * 9;
> +        if ((mode =3D=3D SMMPT64) && (i =3D=3D 4)) {
> +            return extract64(addr, offset, 12);
> +        } else {
> +            return extract64(addr, offset, 9);
> +        }
> +    }
> +}
> +
> +/* Caller should assert i before call this interface */
> +static int mpt_get_pi(hwaddr addr, int i, mpt_mode_t mode)
> +{
> +    if (mode =3D=3D SMMPT34) {
> +        return i =3D=3D 0
> +            ? extract64(addr, 12, 3)
> +            : extract64(addr, 22, 3);
> +    } else {
> +        int offset =3D 16 + i * 9;
> +        return extract64(addr, offset - 4, 4);
> +    }
> +}
> +
> +static bool smmpt_lookup(CPURISCVState *env, hwaddr addr, mpt_mode_t mod=
e,
> +                         mpt_access_t *allowed_access,
> +                         MMUAccessType access_type)
> +{
> +    MemTxResult res;
> +    MemTxAttrs attrs =3D MEMTXATTRS_UNSPECIFIED;
> +    CPUState *cs =3D env_cpu(env);
> +    hwaddr mpte_addr, base =3D (hwaddr)env->mptppn << PGSHIFT;
> +    load_entry_fn *load_entry;
> +    uint32_t mptesize, levels, xwr;
> +    int pn, pi, pmp_prot, pmp_ret;
> +    uint64_t mpte, perms;
> +
> +    switch (mode) {
> +    case SMMPT34:
> +        load_entry =3D &load_entry_32; levels =3D 2; mptesize =3D 4; bre=
ak;
> +    case SMMPT43:
> +        load_entry =3D &load_entry_64; levels =3D 3; mptesize =3D 8; bre=
ak;
> +        break;
> +    case SMMPT52:
> +        load_entry =3D &load_entry_64; levels =3D 4; mptesize =3D 8; bre=
ak;
> +    case SMMPT64:
> +        load_entry =3D &load_entry_64; levels =3D 5; mptesize =3D 8; bre=
ak;
> +    case SMMPTBARE:
> +        *allowed_access =3D ACCESS_ALLOW_RWX;
> +        return true;
> +    default:
> +        g_assert_not_reached();
> +        break;
> +    }
> +    for (int i =3D levels - 1; i >=3D 0 ; i--) {
> +        /* 1. Get pn[i] as the mpt index */
> +        pn =3D mpt_get_pn(addr, i, mode);
> +        /* 2. Get mpte address and get mpte */
> +        mpte_addr =3D base + pn * mptesize;
> +        pmp_ret =3D get_physical_address_pmp(env, &pmp_prot, mpte_addr,
> +                                           mptesize, MMU_DATA_LOAD, PRV_=
M);
> +        if (pmp_ret !=3D TRANSLATE_SUCCESS) {
> +            return false;
> +        }
> +        mpte =3D load_entry(cs->as, mpte_addr, attrs, &res);
> +        /* 3. Check valid bit and reserve bits of mpte */
> +        if (!mpte_is_valid(mpte) || mpte_get_rsv(env, mpte)) {
> +            return false;
> +        }
> +
> +        /* 4. Process non-leaf node */
> +        if (!mpte_is_leaf(mpte)) {
> +            bool nlnapot =3D false;
> +            if (i =3D=3D 0) {
> +                return false;
> +            }
> +            if (!mpte_check_nlnapot(env, mpte, &nlnapot)) {
> +                return false;
> +            }
> +            base =3D mpte_get_ppn(env, mpte, pn, nlnapot) << PGSHIFT;
> +            continue;
> +        }
> +
> +        /* 5. Process leaf node */
> +        pi =3D mpt_get_pi(addr, i, mode);
> +        perms =3D mpte_get_perms(env, mpte);
> +        xwr =3D (perms >> (pi * 3)) & 0x7;
> +        switch (xwr) {
> +        case ACCESS_ALLOW_R:
> +            *allowed_access =3D ACCESS_ALLOW_R;
> +            return access_type =3D=3D MMU_DATA_LOAD;
> +        case ACCESS_ALLOW_X:
> +            *allowed_access =3D ACCESS_ALLOW_X;
> +            return access_type =3D=3D MMU_INST_FETCH;
> +        case ACCESS_ALLOW_RX:
> +            *allowed_access =3D ACCESS_ALLOW_R;
> +            return (access_type =3D=3D MMU_DATA_LOAD ||
> +                    access_type =3D=3D MMU_INST_FETCH);
> +        case ACCESS_ALLOW_RW:
> +            *allowed_access =3D ACCESS_ALLOW_RW;
> +            return (access_type =3D=3D MMU_DATA_LOAD ||
> +                    access_type =3D=3D MMU_DATA_STORE);
> +        case ACCESS_ALLOW_RWX:
> +            *allowed_access =3D ACCESS_ALLOW_RWX;
> +            return true;
> +        default:
> +            return false;
> +        }
> +    }
> +    return false;
> +}
> +
> +bool smmpt_check_access(CPURISCVState *env, hwaddr addr,
> +                        mpt_access_t *allowed_access, MMUAccessType acce=
ss_type)
> +{
> +    bool mpt_has_access;
> +    mpt_mode_t mode =3D env->mptmode;
> +
> +    mpt_has_access =3D smmpt_lookup(env, addr, mode,
> +                                  allowed_access, access_type);
> +    return mpt_has_access;
> +}
> +
> +/*
> + * Convert MPT access to TLB page privilege.
> + */
> +int smmpt_access_to_page_prot(mpt_access_t mpt_access)
> +{
> +    int prot;
> +    switch (mpt_access) {
> +    case ACCESS_ALLOW_R:
> +        prot =3D PAGE_READ;
> +        break;
> +    case ACCESS_ALLOW_X:
> +        prot =3D PAGE_EXEC;
> +        break;
> +    case ACCESS_ALLOW_RX:
> +        prot =3D PAGE_READ | PAGE_EXEC;
> +        break;
> +    case ACCESS_ALLOW_RW:
> +        prot =3D PAGE_READ | PAGE_WRITE;
> +        break;
> +    case ACCESS_ALLOW_RWX:
> +        prot =3D PAGE_READ | PAGE_WRITE | PAGE_EXEC;
> +        break;
> +    default:
> +        prot =3D 0;
> +        break;
> +    }
> +
> +    return prot;
> +}
> diff --git a/target/riscv/riscv_smmpt.h b/target/riscv/riscv_smmpt.h
> index 74dcccf4be..0d0597f8eb 100644
> --- a/target/riscv/riscv_smmpt.h
> +++ b/target/riscv/riscv_smmpt.h
> @@ -9,6 +9,9 @@
>  #ifndef RISCV_SMMPT_H
>  #define RISCV_SMMPT_H
>
> +#include "cpu.h"
> +#include "exec/mmu-access-type.h"
> +
>  typedef enum {
>      SMMPTBARE =3D 0,
>      SMMPT34   =3D 1,
> @@ -18,4 +21,16 @@ typedef enum {
>      SMMPTMAX
>  } mpt_mode_t;
>
> +typedef enum {
> +    ACCESS_ALLOW_R =3D 0b001,
> +    ACCESS_ALLOW_X =3D 0b100,
> +    ACCESS_ALLOW_RX =3D 0b101 ,
> +    ACCESS_ALLOW_RW =3D 0b011,
> +    ACCESS_ALLOW_RWX =3D 0b111,
> +} mpt_access_t;
> +
> +int smmpt_access_to_page_prot(mpt_access_t mpt_access);
> +bool smmpt_check_access(CPURISCVState *env, hwaddr addr,
> +                        mpt_access_t *allowed_access,
> +                        MMUAccessType access_type);
>  #endif
> --
> 2.25.1
>
>

