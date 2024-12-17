Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AA12E7716A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 06:14:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNQqI-0000X3-Ku; Tue, 17 Dec 2024 01:14:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tNQqH-0000Wa-JR; Tue, 17 Dec 2024 01:14:01 -0500
Received: from mail-vs1-xe32.google.com ([2607:f8b0:4864:20::e32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tNQqB-0003kt-IY; Tue, 17 Dec 2024 01:14:01 -0500
Received: by mail-vs1-xe32.google.com with SMTP id
 ada2fe7eead31-4afd56903b7so1244126137.1; 
 Mon, 16 Dec 2024 22:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734416033; x=1735020833; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=khBxrOTKQW5K/58hBJ2Y00S1axY0O3nr7DBinCJk10w=;
 b=UNRI61wq6NJpwf7L9UwqSqp8GxYgUVGLaTswFnoLFyYpfiu0E6RCsQI0MMSPdLylm0
 oWOHqIE1TXUjRdGfdcORVpTeuXr3a6n74HN15JSwmTwywKx91YpbNZx+hFKqa3HDNIEY
 6+b3/3GJatfD/9OSkx2h1PzGbJ0XYSZC5RDSv2ST0T6Fn9+PosPW8YSNkvIsZBUzm463
 O/YY0rSHu0If1tQWa7xgp/BtthbozJ53vHZUovGX03W5POzRh7nt2K8QK17zGTiXtr4s
 obX6XUqaNx5JYiqbs7yZi8GRZlP7Fvfmg5a6uCqO4GN3ZNrN8ZLYazN6IDINgD00Y745
 aQWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734416033; x=1735020833;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=khBxrOTKQW5K/58hBJ2Y00S1axY0O3nr7DBinCJk10w=;
 b=NxbMEQ8cDlWJl/H79jcf0coA9HdLlPaLcI5ObtIu4PegXdKadwgQ9bIfvVH0O95BiD
 b8qAaqz2SKU+diogwh36psDuLdNJi78uQR+MFp0N75AIaAJz3mfzUwpAkNRsDPKGuYKu
 2BKTSVrtilTcPE2Fp6LtlThBdKXpHpcVGk6Yh7O7utg8QxPWUw9upWBEqvWAI6CB+zyj
 LL06jUmElGm4UK6t75jRg96nPCVDna4InnA4VjDDkqzlEjCXBA9Naqv5OAWpBJv5ZDM8
 vbhGPcJooqmH2kHmWrEZ/zEQXCwjeLAipkJktPVBxQboT40W0nmDrvut2LazKcw/RRNc
 XqXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgXxdgIIQHXGRhDglz7+8X7WWycafBdGtRhE52DJorwCzeLaB1oUZ6vbBFEhl1VvpFmLKUS2zEXw1+5w==@nongnu.org,
 AJvYcCWsGTOJqL4viXY400JFvuhwYkaqGJRnkdvQfJJt9luW+9QJYt18ADB9e9y6LL39aaMo3tiif0RqigaQ@nongnu.org
X-Gm-Message-State: AOJu0YztnG2UzKDsZR6ZG2VkExHD3ZDX3ttKWgCoPvb0tCVCk4tSyLY1
 rKCLOvV446xqRVRQK4Dbo2ivkoqla1S50jEIoYeABph+Ixuo9ifuGBkMYnq0nY/45C3pprdxKSv
 LuB3iflIIYGnfXUw5OQXdnkIeIa6cZQ==
X-Gm-Gg: ASbGncvZe+tVzVPc2YmzrZt2y6HeLCcAgS3ggocW2M+asqOGcw7SDhISLgw+/efDh6I
 rI+ACkL4baZ9icq2xWG4e28xVbwA57oAgxhd4B0eVdWpLjt2BNxWIpEHUonRp+vUFll+p
X-Google-Smtp-Source: AGHT+IEAa+gsGMnExcerKvNRk1s+d238IT21xJzhcEaSPRCUEJdlSp3hyhPts/2CapRaSutjVYTzh0veUkpodLv0708=
X-Received: by 2002:a05:6102:3ed4:b0:4af:adb2:5133 with SMTP id
 ada2fe7eead31-4b25db64772mr15845984137.23.1734416032813; Mon, 16 Dec 2024
 22:13:52 -0800 (PST)
MIME-Version: 1.0
References: <20241216121907.660504-1-baturo.alexey@gmail.com>
 <20241216121907.660504-7-baturo.alexey@gmail.com>
In-Reply-To: <20241216121907.660504-7-baturo.alexey@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 17 Dec 2024 16:13:26 +1000
Message-ID: <CAKmqyKMSmjJ5953vDcyDzwoYrk1CpBgYZ2yoGxQ80CYdXevhcQ@mail.gmail.com>
Subject: Re: [PATCH v13 6/7] target/riscv: Apply pointer masking for
 virtualized memory accesses
To: baturo.alexey@gmail.com
Cc: richard.henderson@linaro.org, zhiwei_liu@linux.alibaba.com, 
 dbarboza@ventanamicro.com, liwei1518@gmail.com, frank.chang@sifive.com, 
 palmer@dabbelt.com, Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu, 
 kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e32;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe32.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Mon, Dec 16, 2024 at 10:19=E2=80=AFPM <baturo.alexey@gmail.com> wrote:
>
> From: Alexey Baturo <baturo.alexey@gmail.com>
>
> Signed-off-by: Alexey Baturo <baturo.alexey@gmail.com>
> ---
>  target/riscv/cpu.h           |  1 +
>  target/riscv/cpu_helper.c    | 18 +++++++++++++++
>  target/riscv/internals.h     | 44 ++++++++++++++++++++++++++++++++++++
>  target/riscv/op_helper.c     | 16 ++++++-------
>  target/riscv/vector_helper.c | 21 -----------------
>  5 files changed, 71 insertions(+), 29 deletions(-)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 38231fe21e..536ad20fdd 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -773,6 +773,7 @@ bool riscv_cpu_is_32bit(RISCVCPU *cpu);
>
>  bool riscv_cpu_virt_mem_enabled(CPURISCVState *env);
>  RISCVPmPmm riscv_pm_get_pmm(CPURISCVState *env);
> +RISCVPmPmm riscv_pm_get_virt_pmm(CPURISCVState *env);
>  uint32_t riscv_pm_get_pmlen(RISCVPmPmm pmm);
>
>  RISCVException riscv_csrr(CPURISCVState *env, int csrno,
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 480d2c2c8b..471d8d40a1 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -260,6 +260,24 @@ RISCVPmPmm riscv_pm_get_pmm(CPURISCVState *env)
>      return pmm;
>  }
>
> +RISCVPmPmm riscv_pm_get_virt_pmm(CPURISCVState *env)
> +{
> +    RISCVPmPmm pmm =3D PMM_FIELD_DISABLED;
> +#ifndef CONFIG_USER_ONLY
> +    int priv_mode =3D cpu_address_mode(env);
> +    if (priv_mode =3D=3D PRV_U) {
> +        pmm =3D get_field(env->hstatus, HSTATUS_HUPMM);
> +    } else {
> +        if (get_field(env->hstatus, HSTATUS_SPVP)) {
> +            pmm =3D get_field(env->henvcfg, HENVCFG_PMM);
> +        } else {
> +            pmm =3D get_field(env->senvcfg, SENVCFG_PMM);
> +        }
> +    }
> +#endif
> +    return pmm;
> +}
> +
>  bool riscv_cpu_virt_mem_enabled(CPURISCVState *env)
>  {
>      bool virt_mem_en =3D false;
> diff --git a/target/riscv/internals.h b/target/riscv/internals.h
> index ddbdee885b..017f33af1f 100644
> --- a/target/riscv/internals.h
> +++ b/target/riscv/internals.h
> @@ -142,4 +142,48 @@ static inline float16 check_nanbox_h(CPURISCVState *=
env, uint64_t f)
>  /* Our implementation of CPUClass::has_work */
>  bool riscv_cpu_has_work(CPUState *cs);
>
> +/* Zjpm addr masking routine */
> +static inline target_ulong adjust_addr_body(CPURISCVState *env,
> +                                            target_ulong addr,
> +                                            bool is_virt)

Maybe is_virt_addr to be clear it's an address and not hypervisor virtulisa=
tion.

> +{
> +    if (riscv_cpu_mxl(env) =3D=3D MXL_RV32) {
> +        return addr;
> +    }
> +    RISCVPmPmm pmm =3D PMM_FIELD_DISABLED;

Same comment about mixed code and declarations and some newlines would
be great :)

> +    if (is_virt) {
> +        pmm =3D riscv_pm_get_virt_pmm(env);
> +    } else {
> +        pmm =3D riscv_pm_get_pmm(env);
> +    }
> +    if (pmm =3D=3D PMM_FIELD_DISABLED) {
> +        return addr;
> +    }
> +    uint32_t pmlen =3D riscv_pm_get_pmlen(pmm);
> +    bool signext =3D false;
> +    if (!is_virt) {
> +        signext =3D riscv_cpu_virt_mem_enabled(env);
> +    }
> +    addr =3D addr << pmlen;
> +    /* sign/zero extend masked address by N-1 bit */
> +    if (signext) {
> +        addr =3D (target_long)addr >> pmlen;
> +    } else {
> +        addr =3D addr >> pmlen;
> +    }
> +    return addr;
> +}
> +
> +static inline target_ulong adjust_addr(CPURISCVState *env,
> +                                       target_ulong addr)
> +{
> +    return adjust_addr_body(env, addr, false);
> +}
> +
> +static inline target_ulong adjust_addr_virt(CPURISCVState *env,
> +                                            target_ulong addr)
> +{
> +    return adjust_addr_body(env, addr, true);
> +}

Otherwise looks good

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> +
>  #endif
> diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
> index eddedacf4b..20e5bd5088 100644
> --- a/target/riscv/op_helper.c
> +++ b/target/riscv/op_helper.c
> @@ -472,7 +472,7 @@ target_ulong helper_hyp_hlv_bu(CPURISCVState *env, ta=
rget_ulong addr)
>      int mmu_idx =3D check_access_hlsv(env, false, ra);
>      MemOpIdx oi =3D make_memop_idx(MO_UB, mmu_idx);
>
> -    return cpu_ldb_mmu(env, addr, oi, ra);
> +    return cpu_ldb_mmu(env, adjust_addr_virt(env, addr), oi, ra);
>  }
>
>  target_ulong helper_hyp_hlv_hu(CPURISCVState *env, target_ulong addr)
> @@ -481,7 +481,7 @@ target_ulong helper_hyp_hlv_hu(CPURISCVState *env, ta=
rget_ulong addr)
>      int mmu_idx =3D check_access_hlsv(env, false, ra);
>      MemOpIdx oi =3D make_memop_idx(MO_TEUW, mmu_idx);
>
> -    return cpu_ldw_mmu(env, addr, oi, ra);
> +    return cpu_ldw_mmu(env, adjust_addr_virt(env, addr), oi, ra);
>  }
>
>  target_ulong helper_hyp_hlv_wu(CPURISCVState *env, target_ulong addr)
> @@ -490,7 +490,7 @@ target_ulong helper_hyp_hlv_wu(CPURISCVState *env, ta=
rget_ulong addr)
>      int mmu_idx =3D check_access_hlsv(env, false, ra);
>      MemOpIdx oi =3D make_memop_idx(MO_TEUL, mmu_idx);
>
> -    return cpu_ldl_mmu(env, addr, oi, ra);
> +    return cpu_ldl_mmu(env, adjust_addr_virt(env, addr), oi, ra);
>  }
>
>  target_ulong helper_hyp_hlv_d(CPURISCVState *env, target_ulong addr)
> @@ -499,7 +499,7 @@ target_ulong helper_hyp_hlv_d(CPURISCVState *env, tar=
get_ulong addr)
>      int mmu_idx =3D check_access_hlsv(env, false, ra);
>      MemOpIdx oi =3D make_memop_idx(MO_TEUQ, mmu_idx);
>
> -    return cpu_ldq_mmu(env, addr, oi, ra);
> +    return cpu_ldq_mmu(env, adjust_addr_virt(env, addr), oi, ra);
>  }
>
>  void helper_hyp_hsv_b(CPURISCVState *env, target_ulong addr, target_ulon=
g val)
> @@ -508,7 +508,7 @@ void helper_hyp_hsv_b(CPURISCVState *env, target_ulon=
g addr, target_ulong val)
>      int mmu_idx =3D check_access_hlsv(env, false, ra);
>      MemOpIdx oi =3D make_memop_idx(MO_UB, mmu_idx);
>
> -    cpu_stb_mmu(env, addr, val, oi, ra);
> +    cpu_stb_mmu(env, adjust_addr_virt(env, addr), val, oi, ra);
>  }
>
>  void helper_hyp_hsv_h(CPURISCVState *env, target_ulong addr, target_ulon=
g val)
> @@ -517,7 +517,7 @@ void helper_hyp_hsv_h(CPURISCVState *env, target_ulon=
g addr, target_ulong val)
>      int mmu_idx =3D check_access_hlsv(env, false, ra);
>      MemOpIdx oi =3D make_memop_idx(MO_TEUW, mmu_idx);
>
> -    cpu_stw_mmu(env, addr, val, oi, ra);
> +    cpu_stw_mmu(env, adjust_addr_virt(env, addr), val, oi, ra);
>  }
>
>  void helper_hyp_hsv_w(CPURISCVState *env, target_ulong addr, target_ulon=
g val)
> @@ -526,7 +526,7 @@ void helper_hyp_hsv_w(CPURISCVState *env, target_ulon=
g addr, target_ulong val)
>      int mmu_idx =3D check_access_hlsv(env, false, ra);
>      MemOpIdx oi =3D make_memop_idx(MO_TEUL, mmu_idx);
>
> -    cpu_stl_mmu(env, addr, val, oi, ra);
> +    cpu_stl_mmu(env, adjust_addr_virt(env, addr), val, oi, ra);
>  }
>
>  void helper_hyp_hsv_d(CPURISCVState *env, target_ulong addr, target_ulon=
g val)
> @@ -535,7 +535,7 @@ void helper_hyp_hsv_d(CPURISCVState *env, target_ulon=
g addr, target_ulong val)
>      int mmu_idx =3D check_access_hlsv(env, false, ra);
>      MemOpIdx oi =3D make_memop_idx(MO_TEUQ, mmu_idx);
>
> -    cpu_stq_mmu(env, addr, val, oi, ra);
> +    cpu_stq_mmu(env, adjust_addr_virt(env, addr), val, oi, ra);
>  }
>
>  /*
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index 37c6c198a5..a0093bcc9c 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -105,27 +105,6 @@ static inline uint32_t vext_max_elems(uint32_t desc,=
 uint32_t log2_esz)
>      return scale < 0 ? vlenb >> -scale : vlenb << scale;
>  }
>
> -static inline target_ulong adjust_addr(CPURISCVState *env, target_ulong =
addr)
> -{
> -    if (riscv_cpu_mxl(env) =3D=3D MXL_RV32) {
> -        return addr;
> -    }
> -    RISCVPmPmm pmm =3D riscv_pm_get_pmm(env);
> -    if (pmm =3D=3D PMM_FIELD_DISABLED) {
> -        return addr;
> -    }
> -    int pmlen =3D riscv_pm_get_pmlen(pmm);
> -    bool signext =3D riscv_cpu_virt_mem_enabled(env);
> -    addr =3D addr << pmlen;
> -    /* sign/zero extend masked address by N-1 bit */
> -    if (signext) {
> -        addr =3D (target_long)addr >> pmlen;
> -    } else {
> -        addr =3D addr >> pmlen;
> -    }
> -    return addr;
> -}
> -
>  /*
>   * This function checks watchpoint before real load operation.
>   *
> --
> 2.39.5
>

