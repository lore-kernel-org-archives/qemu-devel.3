Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A028F36B9B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 01:37:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wB0nY-00088G-Pc; Thu, 09 Apr 2026 21:36:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wB0nW-00087o-A5
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 21:36:38 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wB0nU-0001F6-4p
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 21:36:38 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-b982b0889d8so205423966b.2
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 18:36:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775784994; cv=none;
 d=google.com; s=arc-20240605;
 b=jO7iqX9eqjR6/l20hpeqjwV5v1DKWrQNLnWU6jHG5bQNAkjd2g/SPeMoFfKKyMY44A
 MzaNH1WUMxNndZ6J6zL6dgwlVWZqvl8cPBGInECNHANLoKEuwgSYJ9Gdj8Khd12wJjlg
 HLjG1JwjuKsi/FhTj+k1t4wGmfSUntdw2xFMg60OVlbOwMCplX+W3kiZiJEgBIw882L/
 AVzCh1415bg4fhHCl0y//k8YjLwfLu7ugwPv2gBWhJTem4mO8fXhh4LaAj3UW40xeCAw
 XMC51IskGfXDb2M9kiS5PZ36rITQlAnS8C+jzIPv7zPK2yAomPRozLegeYvxngtMI0x6
 B29g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=tGDHPv2KtHevCmzz0FTTj4qFv8sYfv+ejK+QThaIROE=;
 fh=cWfiSq/oFyTN/DKvcJSgQUgJ4u5YSKmpf6by/WUOfgI=;
 b=FRo+bWrhmcbZZAl11vE9ReQwO4zoZjO2NtSkvQE617p4JhyCOqgb6f+jjIrmAEm+ot
 lxYZV6TnY5maTPX95YZWngykHawUIi6NiTTXpzMlx9cIjynmvus2sYIJXTUW0CL8UDtT
 kUCx9ffTmXUDqME0VhnbgA5ep8t3u/uQ49411HIf6iet0K53+xO+zUgygPMsmvUZGiqQ
 Ty1QqVaMeDTISUvFW9XnuUr6RvRVqWyVA9/vOAiwYNE4lii18Eu6/1D/IwMSh7JnlmOa
 sEB5pEvymTG2T2XOx0WVe6GO1bGrKDtXUJrVJnlbIs9t4vys/3fzuappMnYaRPO5juRP
 nl/A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775784994; x=1776389794; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tGDHPv2KtHevCmzz0FTTj4qFv8sYfv+ejK+QThaIROE=;
 b=IRuFLwJSEk1enKLHrV/w6LOTLwAIVchkKpahSBfgM2E3iF9HeZLECn2tuhJzzlSI6/
 c7JFeqhIvst/yWGANEtBnQM9AzH2lJTGJ09UxYvwpDGwKhDKF25usrDc0bjlzigmS3ty
 NnG0i/CbIN+8y9JX9B/j8XRADrtOOV5nspbdOO+/ala6t4fD193MZm8/roCwGGtRcNsx
 CFpwaozYObw50ce67+pp3zhLuBjyITYdoNE6/LlW/eRnRc91cy2WF6uLNTx7bDFFu3Ox
 IFdvk7zT5ZQQUVbswzQuAPnIAS1dgaoqHfoV1j3T94waI3xNqc2TfHDHUSbK+HvZIEeo
 iRcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775784994; x=1776389794;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tGDHPv2KtHevCmzz0FTTj4qFv8sYfv+ejK+QThaIROE=;
 b=RRp9GifSQ+T6CpEwUYwJDJHOUiMDxjZCA0ZTEIV1EPzapfbZBo0sR4dPhcZ/BSYWTW
 SiWFjNdyJBHnUYzw87+PHNCXaAHuCMe8i7aVpI61Aksl8EOtpxDt+ICyMRCktceS4BsD
 re08zerKoDcEuKiNv0NoE/mPduX0pPscmmw/C1rVALh0aPQR+5iq1DNhCC2QWPkqF0aP
 KY3RoJ/oMAz/lFMOwcX4sDrUbAOrv3NkAmjZwk2m/OiBQH61M/FwG6zcgLRbp55AJrqf
 +Eo8FvjR3ISU/wVndHjFcfzTAwPMAZKz9gn13g7kwWxDLsvSco3whN1hRoaXi/KXUS2b
 5sfw==
X-Gm-Message-State: AOJu0YwcTgkcUwG6JUAoN05BBXx+48N2Ukpr5FDtlzSXtyD/7KxVjqog
 J/yA/IjF7TMJvcxMbEDPevhCI9e5U2N5x91TEanuq5j+K/UX4NS8+sVKumgP3FZcHxlFkRVO2iR
 ha3cBQkCavy4eVjJ9h2DUx0JyYI9u6Jo=
X-Gm-Gg: AeBDiev4ql6VyDGV3ErqBdBSuEcmaM6y2CUdAJq/UEa+DUrg3FNNIHx1a5h6mov+24s
 1aPAd6SB5wBO8JjTEf7Q7XF/7yTLEnnfv99ZlrehzMHuasNhhLs5DDrHr7EvxTzbcfnMnAfM9FF
 HuYtTxD4LGl1mRtuGPQACOW1RVqQYKpg+hhDxTRnjevaeCKZuc6aNMgR14FN0uU65ZCBB0MwRSy
 jwaDap2ruRnXxFMhJCJpME3xn8/RZydVU7NhNfPPT8pKj4feskj/+BJOa5HEig8+p46vNL43hID
 UanLzqMNgo3ydfDVfBaf7MUpzo/40Z9FH7qS7zcNaTkF3vws
X-Received: by 2002:a17:907:1609:b0:b98:5b2:77f7 with SMTP id
 a640c23a62f3a-b9d7248ababmr79969366b.12.1775784993878; Thu, 09 Apr 2026
 18:36:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260408140635.42546-1-zhiwei_liu@linux.alibaba.com>
 <20260408140635.42546-3-zhiwei_liu@linux.alibaba.com>
In-Reply-To: <20260408140635.42546-3-zhiwei_liu@linux.alibaba.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 10 Apr 2026 11:36:06 +1000
X-Gm-Features: AQROBzDHHsIxb35Ho5tn-yp6GatJ7zLt6v2_lqT-pSh99twIheCyhnTXjGhZLGs
Message-ID: <CAKmqyKOCRdD5cUvux6W9Z_9fMXiZ0g5s1n6iWp7RkTmZBGvHXw@mail.gmail.com>
Subject: Re: [PATCH v5 2/6] target/riscv: Implement core SMMPT lookup logic
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, chao.liu.zevorn@gmail.com, 
 palmer@dabbelt.com, daniel.barboza@oss.qualcomm.com, liwei1518@gmail.com, 
 Huang Tao <eric.huang@linux.alibaba.com>,
 TANG Tiancheng <lyndra@linux.alibaba.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x629.google.com
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

On Thu, Apr 9, 2026 at 12:07=E2=80=AFAM LIU Zhiwei <zhiwei_liu@linux.alibab=
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
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  target/riscv/cpu_helper.c  |   5 +-
>  target/riscv/meson.build   |   1 +
>  target/riscv/pmp.h         |   3 +
>  target/riscv/riscv_smmpt.c | 274 +++++++++++++++++++++++++++++++++++++
>  target/riscv/riscv_smmpt.h |  15 ++
>  5 files changed, 295 insertions(+), 3 deletions(-)
>  create mode 100644 target/riscv/riscv_smmpt.c
>
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index dd6c861a90..e3361fadae 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -1089,9 +1089,8 @@ void riscv_cpu_set_mode(CPURISCVState *env, target_=
ulong newpriv, bool virt_en)
>   * @access_type: The type of MMU access
>   * @mode: Indicates current privilege level.
>   */
> -static int get_physical_address_pmp(CPURISCVState *env, int *prot, hwadd=
r addr,
> -                                    int size, MMUAccessType access_type,
> -                                    int mode)
> +int get_physical_address_pmp(CPURISCVState *env, int *prot, hwaddr addr,
> +                             int size, MMUAccessType access_type, int mo=
de)
>  {
>      pmp_priv_t pmp_priv;
>      bool pmp_has_privs;
> diff --git a/target/riscv/meson.build b/target/riscv/meson.build
> index 3842c7c1a8..bd1c2e8fad 100644
> --- a/target/riscv/meson.build
> +++ b/target/riscv/meson.build
> @@ -34,6 +34,7 @@ riscv_system_ss =3D ss.source_set()
>  riscv_system_ss.add(files(
>    'arch_dump.c',
>    'pmp.c',
> +  'riscv_smmpt.c',
>    'debug.c',
>    'monitor.c',
>    'machine.c',
> diff --git a/target/riscv/pmp.h b/target/riscv/pmp.h
> index 467fb6b4b1..1ed574227c 100644
> --- a/target/riscv/pmp.h
> +++ b/target/riscv/pmp.h
> @@ -86,6 +86,9 @@ void pmp_update_rule_nums(CPURISCVState *env);
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

There is no guarantee in C that these bit fields are packed and laid
out like you are expecting

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

So this cast

> +
> +    if (mxl =3D=3D MXL_RV32) {
> +        return leaf ? u->leaf32.rsv1 : u->nonleaf32.rsv1;

and these accesses are not valid.

On some platforms this will work, but on others it won't

See the notes here
https://en.cppreference.com/w/cpp/language/bit_field.html for more
details

Alistair

