Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 467D5C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 02:40:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgZFf-0002EI-Up; Sun, 05 Jul 2026 22:40:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wgZFd-0002Bn-W1
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 22:40:06 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wgZFc-0007bG-2Q
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 22:40:05 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-698b899b4c8so2195956a12.0
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 19:40:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783305601; cv=none;
 d=google.com; s=arc-20260327;
 b=VGRKj8VqxgQN2lbc7Mbr2iYxtEc7fprY5LX0Nn9WDbqGTdVdlaJiA7hAEdXOabz6Bk
 idon6wkC7Tqh27GRCdZTjlCAyS+JdilpAzsZEWCXP7TDGhXVOQ1r52pQ8ww4NTG0Rcov
 a9nNs/t+/MQxaGLg1cSBIc7CbRPqbI0uptHD5q4qY6/jY/yXjwuKDWV40+cq87TkkHCl
 WwCDiNJMoOVEG5n7MHp8MSVcvMVzAXdNZ+vRRVCYW2PLOhpBBabWei4YjI477hvTq2Al
 /EbRg6ZwxMiGd0lEseyCoHjoT+B35RFnQEBjhM71algFC+hm2U4lk0Xq1tTr1YQ6/lRd
 9ORA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=yjk0asO8W1etPqSVINFVAHitNTeccYjA0bM83IdqgzQ=;
 fh=9ZBm7Jeorp9wSVPYF5AiPBCRDB4kcVwmpribd+uGcX8=;
 b=S50mkdr1MXwK7vfIASSH/BjvsH5vra9Fg3xMEzV2WSD5XfHbQiocGLoU/4rgHxeP6e
 3yWXyxKmhaC7nLQ2rqLpBo3v2rY0XfDAWoemjWlaEcZbEXyeOUMrxlyOYMJ8Lk/iPJIS
 RXRy7d/qTN19Y9/evrkSbzhwqLIa7aI3fVJjn7lHv+2FZKzfV/BOIig4FZO8/Ms1uvuf
 F06v/8zY4qKHqKSEwlWRxa4W0vrI2MiZkuNRi1hgfX1fheIu68Vpu6BVCFUSgDks5QAh
 jd4I1ahp38A8abyI4FbRHwiKdPN5u9O2fH/7jZ3CCzPJRMUwbXIB/lPzItI/yp8UGcL6
 i4NQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783305601; x=1783910401; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yjk0asO8W1etPqSVINFVAHitNTeccYjA0bM83IdqgzQ=;
 b=GibZ2FBB7To/mO5B1VDTOPvj1q3nNIVs/bO9DNsDZ8ML4QlR1W7/x0jlZwxiXNOc/S
 2cvBfx9ySqhvVQrnNGW/xtUu4qg5KY7dnp9q9RRo0yZKGx7iTuI2TvE0iDIsXqPDHNHw
 gxPL7g7/dXUlnuTergTIhK6o4hmyS/XupPYd/9RDcGvHltU2CH2QIF/bXVALHxUtpXIH
 OWI1xMrV6qchlSGKrfOc84J6SzDR2e2tFgN5Kv/VLBKOPCgGeXUSEAooiYumt9c/CaXh
 P/187PI9J7LfOQJRyVSSGrIb5pOkN7sqECzVwWqc/7n9i4nNlKawxLWTtMbR+2VwbnIX
 054Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783305601; x=1783910401;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yjk0asO8W1etPqSVINFVAHitNTeccYjA0bM83IdqgzQ=;
 b=mvJEonlgfTvEJ3GbJ9bdOejew49GQMEz8q0U737A78hKfNshm5kiRD6+NxstASZFLh
 3GTjsTpefjrxY9HEyol+lCJ29M1eTnztAxEQr1CLVi8GGoV12znDaeQpx/xiXeV5Kf0a
 YsH/HWzLdzqMH3xH0eJswhhngQOFl6AsKduXFczO4QlqmK8RpamgnXPJ3Qi218xjWQHK
 WKCvNduU5hfhPn2wUXe0LsdtW/QslIsOvAYbYkZqksrywHnrxSeR3GNa3VoCuo/hxkmk
 eMFz15Cm+irwFDOK9t8WHkZw2SgVE4JDQwIyiazzcXUZ/2OcAn7QIJDn430EaCIEeQmF
 qJ7Q==
X-Gm-Message-State: AOJu0Ywfg84XO2mp4C6dsYS2+PzSmUPgNtweUonxjKYvBmGDrsg7cHfu
 3jOgUB3+vl2rucT9dxxPpeIZ4nxYixq6OpTVxV9pGPbk8iZ0MPeAevJRC0AIBBzxta6tHwI4Khe
 AA1/PI9G0eMj5ol59/8OHQlT078Gfd2Q=
X-Gm-Gg: AfdE7cnVEIFZHcIks/251Dq1hJ+FnaQInV8y4BEqWhxD2mBaLDfg0t2Jmn1lwsZrtaZ
 C9MsUrYi5VrSGvgnFXTFjLL2+/xyy8FPmrDikZh3rP9Sd4wOBl1p1ArfaFgSjiw+bPRVcutThz8
 WHq5qk93DX86xNmyKtkvoltiiL/NMA1ENHmr3s0CMUPbGPDvbdSghjZ5LXbhGeW7vdrZfXu8pA3
 Rz0cJBT5anIXnZ/T0TeidNAkvyWYG13dA6EBk+Xv8QY+p+cwLfNe8JmbW/4djUwusAKv3ya39Pl
 /91MzfM3rvC6V5t3yg9xr4KQsI23g7ufncgGNQ==
X-Received: by 2002:a05:6402:458b:b0:698:3b7c:7e2a with SMTP id
 4fb4d7f45d1cf-69a1a3b219cmr2692149a12.34.1783305601037; Sun, 05 Jul 2026
 19:40:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260630104350.748267-1-frank.chang@sifive.com>
 <20260630104350.748267-4-frank.chang@sifive.com>
In-Reply-To: <20260630104350.748267-4-frank.chang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 6 Jul 2026 12:39:34 +1000
X-Gm-Features: AVVi8Cdla-Raj98pRMhUalAwwgXIttizX9E9qpANzlRmGlF7_M20w1uzSpaw5FM
Message-ID: <CAKmqyKPXJvgx1Aq-223FB4cDcKj9sBKD_4RFN4rnKQW-hfVsUQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] target/riscv: Support raising misaligned
 exceptions for vector loads/stores
To: frank.chang@sifive.com
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, 
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>,
 Max Chou <max.chou@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x533.google.com
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

On Tue, Jun 30, 2026 at 8:46=E2=80=AFPM <frank.chang@sifive.com> wrote:
>
> From: Frank Chang <frank.chang@sifive.com>
>
> When the Zicclsm extension is not enabled, raise misaligned load/store
> exceptions for misaligned accesses from vector load/store instructions.
>
> We will skip the host fast-path and fall back to the slow TLB-path to
> raise misaligned load/store exceptions for the misaligned accesses when
> Zicclsm extension is disabled.
>
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> Reviewed-by: Max Chou <max.chou@sifive.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/insn_trans/trans_rvv.c.inc | 18 +++++--
>  target/riscv/vector_helper.c            | 65 +++++++++++++++++++------
>  2 files changed, 65 insertions(+), 18 deletions(-)
>
> diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_=
trans/trans_rvv.c.inc
> index 23262b1d036..a22e2cae6ce 100644
> --- a/target/riscv/insn_trans/trans_rvv.c.inc
> +++ b/target/riscv/insn_trans/trans_rvv.c.inc
> @@ -1191,26 +1191,38 @@ static bool ldst_whole_trans(uint32_t vd, uint32_=
t rs1, uint32_t nf,
>       * Use the helper function if either:
>       * - vstart is not 0.
>       */
> -
>      bool use_helper_fn =3D !s->vstart_eq_zero;
>
>      if (!use_helper_fn) {
>          uint32_t size =3D s->cfg_ptr->vlenb * nf;
>          TCGv_i64 t8 =3D tcg_temp_new_i64();
>          MemOp atomicity =3D MO_ATOM_NONE;
> +        MemOp alignment =3D MO_UNALN;
> +
> +        /*
> +         * If Zicclsm is disabled, require alignment based on element si=
ze.
> +         * Use MO_ALIGN_* based on log2_esz (0 =3D MO_UNALN, 1 =3D MO_AL=
IGN_2, etc).
> +         */
> +        if (!s->cfg_ptr->ext_zicclsm) {
> +            alignment =3D log2_esz << MO_ASHIFT;
> +        }
> +
>          if (log2_esz =3D=3D 0) {
>              atomicity =3D MO_ATOM_NONE;
>          } else {
>              atomicity =3D MO_ATOM_IFALIGN_PAIR;
>          }
> +
>          for (int i =3D 0; i < size; i +=3D 8) {
>              TCGv addr =3D get_address(s, rs1, i);
>              if (is_load) {
> -                tcg_gen_qemu_ld_i64(t8, addr, s->mem_idx, MO_LEUQ | atom=
icity);
> +                tcg_gen_qemu_ld_i64(t8, addr, s->mem_idx,
> +                                    MO_LEUQ | atomicity | alignment);
>                  tcg_gen_st_i64(t8, tcg_env, vreg_ofs(s, vd) + i);
>              } else {
>                  tcg_gen_ld_i64(t8, tcg_env, vreg_ofs(s, vd) + i);
> -                tcg_gen_qemu_st_i64(t8, addr, s->mem_idx, MO_LEUQ | atom=
icity);
> +                tcg_gen_qemu_st_i64(t8, addr, s->mem_idx,
> +                                    MO_LEUQ | atomicity | alignment);
>              }
>              if (i =3D=3D size - 8) {
>                  tcg_gen_movi_i32(cpu_vstart, 0);
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index e321ca26161..e28d8a3d9fd 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -199,20 +199,34 @@ static inline void vext_set_elem_mask(void *v0, int=
 index,
>      ((uint64_t *)v0)[idx] =3D deposit64(old, pos, 1, value);
>  }
>
> +static inline MemOpIdx vext_make_memop_idx(CPURISCVState *env, size_t si=
ze)
> +{
> +    int mmu_idx =3D riscv_env_mmu_index(env, false);
> +    MemOp memop =3D size_memop(size) | mo_endian_env(env);
> +
> +    if (!riscv_cpu_cfg(env)->ext_zicclsm) {
> +        memop |=3D MO_ALIGN;
> +    }
> +
> +    return make_memop_idx(memop, mmu_idx);
> +}
> +
>  /* elements operations for load and store */
>  typedef void vext_ldst_elem_fn_tlb(CPURISCVState *env, abi_ptr addr,
>                                     uint32_t idx, void *vd, uintptr_t ret=
addr);
>  typedef void vext_ldst_elem_fn_host(void *vd, uint32_t idx, void *host);
>
> -#define GEN_VEXT_LD_ELEM(NAME, ETYPE, H, LDSUF)             \
> +#define GEN_VEXT_TLB_LD_ELEM(NAME, ETYPE, H, LDSUF)         \
>  static inline QEMU_ALWAYS_INLINE                            \
>  void NAME##_tlb(CPURISCVState *env, abi_ptr addr,           \
>                  uint32_t idx, void *vd, uintptr_t retaddr)  \
>  {                                                           \
>      ETYPE *cur =3D ((ETYPE *)vd + H(idx));                    \
> -    *cur =3D cpu_##LDSUF##_data_ra(env, addr, retaddr);       \
> +    MemOpIdx oi =3D vext_make_memop_idx(env, sizeof(ETYPE));  \
> +    *cur =3D cpu_##LDSUF##_mmu(env, addr, oi, retaddr);       \
>  }                                                           \
> -                                                            \
> +
> +#define GEN_VEXT_HOST_LD_ELEM(NAME, ETYPE, H, LDSUF)        \
>  static inline QEMU_ALWAYS_INLINE                            \
>  void NAME##_host(void *vd, uint32_t idx, void *host)        \
>  {                                                           \
> @@ -220,20 +234,27 @@ void NAME##_host(void *vd, uint32_t idx, void *host=
)        \
>      *cur =3D (ETYPE)LDSUF##_p(host);                          \
>  }
>
> -GEN_VEXT_LD_ELEM(lde_b, uint8_t,  H1, ldub)
> -GEN_VEXT_LD_ELEM(lde_h, uint16_t, H2, lduw_le)
> -GEN_VEXT_LD_ELEM(lde_w, uint32_t, H4, ldl_le)
> -GEN_VEXT_LD_ELEM(lde_d, uint64_t, H8, ldq_le)
> +GEN_VEXT_TLB_LD_ELEM(lde_b, uint8_t,  H1, ldb)
> +GEN_VEXT_TLB_LD_ELEM(lde_h, uint16_t, H2, ldw)
> +GEN_VEXT_TLB_LD_ELEM(lde_w, uint32_t, H4, ldl)
> +GEN_VEXT_TLB_LD_ELEM(lde_d, uint64_t, H8, ldq)
>
> -#define GEN_VEXT_ST_ELEM(NAME, ETYPE, H, STSUF)             \
> +GEN_VEXT_HOST_LD_ELEM(lde_b, uint8_t,  H1, ldub)
> +GEN_VEXT_HOST_LD_ELEM(lde_h, uint16_t, H2, lduw_le)
> +GEN_VEXT_HOST_LD_ELEM(lde_w, uint32_t, H4, ldl_le)
> +GEN_VEXT_HOST_LD_ELEM(lde_d, uint64_t, H8, ldq_le)
> +
> +#define GEN_VEXT_TLB_ST_ELEM(NAME, ETYPE, H, STSUF)         \
>  static inline QEMU_ALWAYS_INLINE                            \
>  void NAME##_tlb(CPURISCVState *env, abi_ptr addr,           \
>                  uint32_t idx, void *vd, uintptr_t retaddr)  \
>  {                                                           \
>      ETYPE data =3D *((ETYPE *)vd + H(idx));                   \
> -    cpu_##STSUF##_data_ra(env, addr, data, retaddr);        \
> +    MemOpIdx oi =3D vext_make_memop_idx(env, sizeof(ETYPE));  \
> +    cpu_##STSUF##_mmu(env, addr, data, oi, retaddr);        \
>  }                                                           \
> -                                                            \
> +
> +#define GEN_VEXT_HOST_ST_ELEM(NAME, ETYPE, H, STSUF)        \
>  static inline QEMU_ALWAYS_INLINE                            \
>  void NAME##_host(void *vd, uint32_t idx, void *host)        \
>  {                                                           \
> @@ -241,10 +262,15 @@ void NAME##_host(void *vd, uint32_t idx, void *host=
)        \
>      STSUF##_p(host, data);                                  \
>  }
>
> -GEN_VEXT_ST_ELEM(ste_b, uint8_t,  H1, stb)
> -GEN_VEXT_ST_ELEM(ste_h, uint16_t, H2, stw_le)
> -GEN_VEXT_ST_ELEM(ste_w, uint32_t, H4, stl_le)
> -GEN_VEXT_ST_ELEM(ste_d, uint64_t, H8, stq_le)
> +GEN_VEXT_TLB_ST_ELEM(ste_b, uint8_t,  H1, stb)
> +GEN_VEXT_TLB_ST_ELEM(ste_h, uint16_t, H2, stw)
> +GEN_VEXT_TLB_ST_ELEM(ste_w, uint32_t, H4, stl)
> +GEN_VEXT_TLB_ST_ELEM(ste_d, uint64_t, H8, stq)
> +
> +GEN_VEXT_HOST_ST_ELEM(ste_b, uint8_t,  H1, stb)
> +GEN_VEXT_HOST_ST_ELEM(ste_h, uint16_t, H2, stw_le)
> +GEN_VEXT_HOST_ST_ELEM(ste_w, uint32_t, H4, stl_le)
> +GEN_VEXT_HOST_ST_ELEM(ste_d, uint64_t, H8, stq_le)
>
>  static inline QEMU_ALWAYS_INLINE void
>  vext_continuous_ldst_tlb(CPURISCVState *env, vext_ldst_elem_fn_tlb *ldst=
_tlb,
> @@ -398,7 +424,16 @@ vext_page_ldst_us(CPURISCVState *env, void *vd, targ=
et_ulong addr,
>      probe_pages(env, addr, size, ra, access_type, mmu_index, &host, &fla=
gs,
>                  true);
>
> -    if (flags =3D=3D 0) {
> +    bool misaligned =3D addr & (esz - 1);
> +
> +    /*
> +     * Allow the host fast-pash when:
> +     *   1. Page permission/pmp/watchpoint are checked and we have a con=
tigous
> +     *      host mapping.
> +     *   2. Zicclsm is enabled or load/store is not a misaligned access.
> +     * Otherwise, we will fall back to the slow TLB-path.
> +     */
> +    if (flags =3D=3D 0 && (riscv_cpu_cfg(env)->ext_zicclsm || !misaligne=
d)) {
>          if (nf =3D=3D 1) {
>              vext_continuous_ldst_host(env, ldst_host, vd, evl, env->vsta=
rt,
>                                        host, esz, is_load);
> --
> 2.43.0
>
>

