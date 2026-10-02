Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22B52CA5FD4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 06:57:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCXCU-0002ua-0Y; Fri, 02 Oct 2026 02:57:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1xCXC9-0002tu-To; Fri, 02 Oct 2026 02:56:38 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1xCXC7-0007DB-Da; Fri, 02 Oct 2026 02:56:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=uEjjZRjGprSk6W69X+bM9xAaPS2prssTHh98tixdw/k=; b=jimyTiEJ9Mmcc1e
 ANtE2G/s/83SG/ySw9CJvrfj203NwUiLJokEznS4fc8f+anW22lJ08lLIR82ll9NSjujp075PyNlI
 AjYgDz8u0sxGKAjXpjyBdy0OinuXE2lwuh+mOid1KdZgZ9m4bypWsyKRF0EkRIPdwo0VGm65ozC3k
 XQ=;
Date: Fri, 2 Oct 2026 09:02:11 +0200
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org, 
 Chao Liu <chao.liu@processmission.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Sunil V L <sunilvl@ventanamicro.com>, Zhao Liu <zhao1.liu@intel.com>,
 Bibo Mao <maobibo@loongson.cn>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-riscv@nongnu.org, 
 Weiwei Li <liwei1518@gmail.com>, Brian Cain <brian.cain@oss.qualcomm.com>
Subject: Re: [PATCH v3 039/114] target/riscv: preserve signed XLEN semantics
 without target_long
Message-ID: <ar9WZip2Q2G0qvQI@hive.localdomain>
References: <20260923131635.1894-1-luoyonggang@gmail.com>
 <20260923131635.1894-40-luoyonggang@gmail.com>
 <0a2a9b0f-82cb-427b-a24e-4d0656601212@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0a2a9b0f-82cb-427b-a24e-4d0656601212@oss.qualcomm.com>
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 02/10/26, Philippe Mathieu-Daudé wrote:
> (reducing huge Cc list a bit)
> 
> On 23/9/26 15:15, Yonggang Luo wrote:
> > - Mask pointer-masked addresses with extract64/sextract64 at
> >    runtime XLEN instead of a target_long arithmetic shift.
> > - Pass vector vx scalars as int64_t after sextract64 from the
> >    helper tl slot so RV32 keeps bit 31 as the sign bit.
> > - Leave every target_ulong helper argument unchanged.
> 
> I'm not a RISCV expert but have the feeling some target_long_bits()
> should be riscv_cpu_mxl_bits() instead (or something else), as it
> depends in which state the CPU is running.
> 
> Helpers having @env passed as argument could infer locally.

I wouldn't be surprised if that's the case, although I'm personally a
bit scared of riscv_cpu_mxl_bits() since it returns 128 for MXL_128, so
if it's not used carefully or on clear MXL_[32|64] paths you could easily
get UB.

> 
> > 
> > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> > ---
> >   target/riscv/internals.h            | 12 ++++++++----
> >   target/riscv/tcg/vector_helper.c    | 21 +++++++++++----------
> >   target/riscv/tcg/vector_internals.c |  2 +-
> >   target/riscv/tcg/vector_internals.h |  9 +++++----
> >   4 files changed, 25 insertions(+), 19 deletions(-)
> > 
> > diff --git a/target/riscv/internals.h b/target/riscv/internals.h
> > index 1ee7e99e988..0844867246d 100644
> > --- a/target/riscv/internals.h
> > +++ b/target/riscv/internals.h
> > @@ -214,6 +214,7 @@ static inline target_ulong adjust_addr_body(CPURISCVState *env,
> >   {
> >       RISCVPmPmm pmm = PMM_FIELD_DISABLED;
> >       uint32_t pmlen = 0;
> > +    unsigned kept;
> >       bool signext = false;
> >       /* do nothing for rv32 mode */
> > @@ -235,13 +236,16 @@ static inline target_ulong adjust_addr_body(CPURISCVState *env,
> >       signext = riscv_cpu_virt_mem_enabled(env, is_virt_addr);
> >       pmlen = riscv_pm_get_pmlen(pmm);
> > -    addr = addr << pmlen;
> > -    /* sign/zero extend masked address by N-1 bit */
> > +    /*
> > +     * Drop the top pmlen bits of XLEN. Do not rely on target_ulong
> > +     * shift wrap; common-system target_ulong is always 64 bits.
> > +     */
> > +    kept = target_long_bits() - pmlen;
> >       if (signext) {
> > -        addr = (target_long)addr >> pmlen;
> > +        addr = sextract64(addr, 0, kept);
> >       } else {
> > -        addr = addr >> pmlen;
> > +        addr = extract64(addr, 0, kept);
> >       }
> >       return addr;
> > diff --git a/target/riscv/tcg/vector_helper.c b/target/riscv/tcg/vector_helper.c
> > index 0d1e4e09646..0b78a733ce4 100644
> > --- a/target/riscv/tcg/vector_helper.c
> > +++ b/target/riscv/tcg/vector_helper.c
> > @@ -1248,7 +1248,7 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,        \
> >           ETYPE s2 = *((ETYPE *)vs2 + H(i));                               \
> >           ETYPE carry = vext_elem_mask(v0, i);                             \
> >                                                                            \
> > -        *((ETYPE *)vd + H(i)) = DO_OP(s2, (ETYPE)(target_long)s1, carry);\
> > +        *((ETYPE *)vd + H(i)) = DO_OP(s2, (ETYPE)sextract64(s1, 0, target_long_bits()), carry);\
> >       }                                                                    \
> >       env->vstart = 0;                                                     \
> >       /* set tail elements to 1s */                                        \
> > @@ -1325,7 +1325,7 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1,          \
> >           ETYPE s2 = *((ETYPE *)vs2 + H(i));                      \
> >           ETYPE carry = !vm && vext_elem_mask(v0, i);             \
> >           vext_set_elem_mask(vd, i,                               \
> > -                DO_OP(s2, (ETYPE)(target_long)s1, carry));      \
> > +                DO_OP(s2, (ETYPE)sextract64(s1, 0, target_long_bits()), carry));      \
> >       }                                                           \
> >       env->vstart = 0;                                            \
> >       /*
> > @@ -1609,7 +1609,7 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,   \
> >               continue;                                               \
> >           }                                                           \
> >           vext_set_elem_mask(vd, i,                                   \
> > -                DO_OP(s2, (ETYPE)(target_long)s1));                 \
> > +                DO_OP(s2, (ETYPE)sextract64(s1, 0, target_long_bits())));                 \
> >       }                                                               \
> >       env->vstart = 0;                                                \
> >       /*
> > @@ -2050,7 +2050,7 @@ GEN_VEXT_VV(vnmsub_vv_w, 4)
> >   GEN_VEXT_VV(vnmsub_vv_d, 8)
> >   #define OPIVX3(NAME, TD, T1, T2, TX1, TX2, HD, HS2, OP)             \
> > -static void do_##NAME(void *vd, target_long s1, void *vs2, int i)   \
> > +static void do_##NAME(void *vd, int64_t s1, void *vs2, int i)   \
> >   {                                                                   \
> >       TX2 s2 = *((T2 *)vs2 + HS2(i));                                 \
> >       TD d = *((TD *)vd + HD(i));                                     \
> > @@ -2246,7 +2246,7 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1,               \
> >       for (i = env->vstart; i < vl; i++) {                             \
> >           ETYPE s2 = *((ETYPE *)vs2 + H(i));                           \
> >           ETYPE d = (!vext_elem_mask(v0, i) ? s2 :                     \
> > -                   (ETYPE)(target_long)s1);                          \
> > +                   (ETYPE)sextract64(s1, 0, target_long_bits()));                          \
> >           *((ETYPE *)vd + H(i)) = d;                                   \
> >       }                                                                \
> >       env->vstart = 0;                                                 \
> > @@ -2397,12 +2397,12 @@ GEN_VEXT_VV_RM(vsaddu_vv_h, 2)
> >   GEN_VEXT_VV_RM(vsaddu_vv_w, 4)
> >   GEN_VEXT_VV_RM(vsaddu_vv_d, 8)
> > -typedef void opivx2_rm_fn(void *vd, target_long s1, void *vs2, int i,
> > +typedef void opivx2_rm_fn(void *vd, int64_t s1, void *vs2, int i,
> >                             CPURISCVState *env, uint8_t vxrm);
> >   #define OPIVX2_RM(NAME, TD, T1, T2, TX1, TX2, HD, HS2, OP)          \
> >   static inline void                                                  \
> > -do_##NAME(void *vd, target_long s1, void *vs2, int i,               \
> > +do_##NAME(void *vd, int64_t s1, void *vs2, int i,               \
> >             CPURISCVState *env, uint8_t vxrm)                         \
> >   {                                                                   \
> >       TX2 s2 = *((T2 *)vs2 + HS2(i));                                 \
> > @@ -2410,7 +2410,7 @@ do_##NAME(void *vd, target_long s1, void *vs2, int i,               \
> >   }
> >   static inline void
> > -vext_vx_rm_1(void *vd, void *v0, target_long s1, void *vs2,
> > +vext_vx_rm_1(void *vd, void *v0, int64_t s1, void *vs2,
> >                CPURISCVState *env,
> >                uint32_t vl, uint32_t vm, uint8_t vxrm,
> >                opivx2_rm_fn *fn, uint32_t vma, uint32_t esz)
> > @@ -2427,7 +2427,7 @@ vext_vx_rm_1(void *vd, void *v0, target_long s1, void *vs2,
> >   }
> >   static inline void
> > -vext_vx_rm_2(void *vd, void *v0, target_long s1, void *vs2,
> > +vext_vx_rm_2(void *vd, void *v0, int64_t s1, void *vs2,
> >                CPURISCVState *env,
> >                uint32_t desc,
> >                opivx2_rm_fn *fn, uint32_t esz)
> > @@ -2468,7 +2468,8 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1,    \
> >                     void *vs2, CPURISCVState *env,          \
> >                     uint32_t desc)                          \
> >   {                                                         \
> > -    vext_vx_rm_2(vd, v0, s1, vs2, env, desc,              \
> > +    vext_vx_rm_2(vd, v0, sextract64(s1, 0, target_long_bits()), \
> > +                 vs2, env, desc,                          \
> >                    do_##NAME, ESZ);                         \
> >   }
> > diff --git a/target/riscv/tcg/vector_internals.c b/target/riscv/tcg/vector_internals.c
> > index b490b1d3989..95327052666 100644
> > --- a/target/riscv/tcg/vector_internals.c
> > +++ b/target/riscv/tcg/vector_internals.c
> > @@ -81,7 +81,7 @@ void do_vext_vv(void *vd, void *v0, void *vs1, void *vs2,
> >       vext_set_elems_1s(vd, vta, vl * esz, total_elems * esz);
> >   }
> > -void do_vext_vx(void *vd, void *v0, target_long s1, void *vs2,
> > +void do_vext_vx(void *vd, void *v0, int64_t s1, void *vs2,
> >                   CPURISCVState *env, uint32_t desc,
> >                   opivx2_fn fn, uint32_t esz)
> >   {
> > diff --git a/target/riscv/tcg/vector_internals.h b/target/riscv/tcg/vector_internals.h
> > index 5681b818153..da093d561eb 100644
> > --- a/target/riscv/tcg/vector_internals.h
> > +++ b/target/riscv/tcg/vector_internals.h
> > @@ -201,20 +201,20 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1,          \
> >                  do_##NAME, ESZ);                           \
> >   }
> > -typedef void opivx2_fn(void *vd, target_long s1, void *vs2, int i);
> > +typedef void opivx2_fn(void *vd, int64_t s1, void *vs2, int i);
> >   /*
> >    * (T1)s1 gives the real operator type.
> >    * (TX1)(T1)s1 expands the operator type of widen or narrow operations.
> >    */
> >   #define OPIVX2(NAME, TD, T1, T2, TX1, TX2, HD, HS2, OP)             \
> > -static void do_##NAME(void *vd, target_long s1, void *vs2, int i)   \
> > +static void do_##NAME(void *vd, int64_t s1, void *vs2, int i)       \
> >   {                                                                   \
> >       TX2 s2 = *((T2 *)vs2 + HS2(i));                                 \
> >       *((TD *)vd + HD(i)) = OP(s2, (TX1)(T1)s1);                      \
> >   }
> > -void do_vext_vx(void *vd, void *v0, target_long s1, void *vs2,
> > +void do_vext_vx(void *vd, void *v0, int64_t s1, void *vs2,
> >                   CPURISCVState *env, uint32_t desc,
> >                   opivx2_fn fn, uint32_t esz);
> > @@ -224,7 +224,8 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1,    \
> >                     void *vs2, CPURISCVState *env,          \
> >                     uint32_t desc)                          \
> >   {                                                         \
> > -    do_vext_vx(vd, v0, s1, vs2, env, desc,                \
> > +    do_vext_vx(vd, v0, sextract64(s1, 0, target_long_bits()), \
> > +               vs2, env, desc,                            \
> >                  do_##NAME, ESZ);                           \
> >   }
> 

