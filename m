Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25AD1FE5202
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 11:17:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGEWj-0004i2-RA; Fri, 24 Apr 2026 07:16:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wGEWf-0004hL-9T
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 07:16:49 -0400
Received: from mail-vs1-xe42.google.com ([2607:f8b0:4864:20::e42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wGEWc-00009D-3j
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 07:16:49 -0400
Received: by mail-vs1-xe42.google.com with SMTP id
 ada2fe7eead31-610e2e8f57dso2760444137.0
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 04:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777029401; x=1777634201; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=n8q+GhBrHqxOeTDw3DSptB5nw7mK3eds+ahUErjebcI=;
 b=Y839nRGkOrXgUWZpIohBinB1VpQlNvvbepdBCVaIx/O3rnwyZi1plaN3jSKUt4Q1V1
 99fvNxNLJUtMCT87xd8ecHRjbDK91kwCUPMaxZUFxtcId2fzWw1MKLMOlDRtxBEN+ju2
 KFk55V5D/lFl8ZY32iCs3JvS3/Fat8TP4sH3oAFKJJLbk7Ne3jMD9utj+1dInpo60jS9
 xpFrdtDWjTbRLGpC7SqeoC02IZdcTtJ2RqGsQDhLuHKugTiQYLfm6OZ7ojgNHysc5Wl4
 JLjeo4xjGP27FZvWUd3W4kaCpc9w0GxA5MZhB8HasD9MDymNIfSiZUUgLVzmOqDX+dmf
 8X5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777029401; x=1777634201;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=n8q+GhBrHqxOeTDw3DSptB5nw7mK3eds+ahUErjebcI=;
 b=CAI9XVqmuK/fTfTYDJY7LGjUaSs/VTBmnj3tZhqiNA6zpQ73+jcSPAztzH4M3l533m
 MeFD5MtltFg5wc9yaxBw2S8z6YwNlaqX7ccuhUx2k6efJyf3Q/9Prd4NY2kmWrpBwn8+
 rrcv/Jzdl1xrQ8vO6zD62fwW2UsPm69Q+e0DioMtmpIyCM+dObe9K7GrFqQaBYWp8PRA
 vHf2gyKaK/Iop78W0zC6qzYO3+0Cn7KUGtQ3uzeLSkBytpkEUmPxSC+w/1/o7UbK60af
 hMyTt0GhnJDVLR/LGL0239/ccEChbozEuBv5jUbcgwVOm5aL46NELiL0ukUNmKwTgNhn
 hvNA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+JUNRWmIL+j8p4CTBvt1aHmdz5claBwcG3CONE+SVQ6OzNQ1w+V7EpCnJG80pFWAJNPB2JSD4AE0Nq@nongnu.org
X-Gm-Message-State: AOJu0YziQibNBP57GWjVXRxQMbDieXsoWu/WKjMshzWCcJCSuBosw+VR
 nRpjdQPi0uNS6y7E6vCamOJ20/7ogiwj7A1/zTZDKUdyJ9Js0MCWhlpz
X-Gm-Gg: AeBDieubHIFoQqNJYhRxVZTJ01lLcslO7ycDU4796Ty79GkBBpEAvFWiC8q0wTRbw5U
 RseGPYot16V81SnfP5rUHasXiVgBsnzLmpg8+4stkuiVHr7X9vlP7cCrEnxTIKffdmlpXasbPku
 CTbrulGfpn/Q8GFHl+hU0yH6dHvfWxe6MStYXKKsbKWL8X5VXxFJSQ+fbOPXWTIRBMiRDEav7vY
 S7lPOTJ45HbI0CSOZkT62OyObRtZwHE4uUMcjLoecIZggSomQo3vj+mSxRShakQqQIu9A2euXOB
 rM8GA3EwTZMSdd0bu6/hD7QusL5BC3Dj9QydZcnKb6fXJ8PuQffXSs+vRLM1I6xm2Qp49pgeS89
 d5pPvIuPfygwCqToR+duDSMkiLMXzPkbCO3HoA0k03EQI0Xsd6G3/f5LRR1hlUiKxlxfw/Y0u+3
 0Ai/QWciuTniD5F3tt6o8xJfN32BppEkpPfK6rXBjjRj2XrdhzyagaXVKywxrLGoowRMdg4yYvE
 mF4BTn6vMY=
X-Received: by 2002:a05:6102:509e:b0:611:82b:a59c with SMTP id
 ada2fe7eead31-616f8069807mr12380501137.21.1777029401248; 
 Fri, 24 Apr 2026 04:16:41 -0700 (PDT)
Received: from ZEVORN-PC.localdomain ([162.244.208.119])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-617455b52bcsm10957303137.3.2026.04.24.04.16.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2026 04:16:39 -0700 (PDT)
Date: Fri, 24 Apr 2026 19:16:22 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, 
 Paolo Savini <paolo.savini@embecosm.com>, Nicholas Piggin <npiggin@gmail.com>, 
 Eric Biggers <ebiggers@kernel.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: Re: [PATCH v10 1/2] target/riscv: Use tcg nodes for strided vector
 ld/st generation
Message-ID: <aerNiVGqCosK4Pi_@ZEVORN-PC.localdomain>
References: <cover.1776437127.git.chao.liu.zevorn@gmail.com>
 <8ab885ce490cede31b8e9e7f6a67295c1aa353f7.1776437127.git.chao.liu.zevorn@gmail.com>
 <5dac7eb5-9535-49de-83a4-c1c2ebf0c16c@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5dac7eb5-9535-49de-83a4-c1c2ebf0c16c@oss.qualcomm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::e42;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-vs1-xe42.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Thu, Apr 23, 2026 at 09:24:09AM -0300, Daniel Henrique Barboza wrote:
> Hi Chao,
> 
> On 4/17/2026 11:49 AM, Chao Liu wrote:
> > This commit improves the performance of QEMU when emulating strided vector
> > loads and stores by substituting the call for the helper function with the
> > generation of equivalent TCG operations.
> > 
> > PS:
> > 
> > An implementation is permitted to cause an illegal instruction if vstart
> > is not 0 and it is set to a value that can not be produced implicitly by
> > the implementation, but memory accesses will generally always need to
> > deal with page faults.
> > 
> > So, if a strided vector memory access instruction has non-zero vstart,
> > check it through vlse/vsse helpers function.
> > 
> > Signed-off-by: Paolo Savini <paolo.savini@embecosm.com>
> > Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > Tested-by: Eric Biggers <ebiggers@kernel.org>
> > Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> > ---
> >   target/riscv/insn_trans/trans_rvv.c.inc | 354 ++++++++++++++++++++++--
> >   1 file changed, 337 insertions(+), 17 deletions(-)
> > 
> > diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
> > index 5b72926b3c..4cf3643cbd 100644
> > --- a/target/riscv/insn_trans/trans_rvv.c.inc
> > +++ b/target/riscv/insn_trans/trans_rvv.c.inc
> > @@ -16,6 +16,7 @@
> >    */
> >   #include "tcg/tcg-op-gvec.h"
> >   #include "tcg/tcg-gvec-desc.h"
> > +#include "tcg/tcg-temp-internal.h"
> >   #include "internals.h"
> >   static inline bool is_overlapped(const int8_t astart, int8_t asize,
> > @@ -872,15 +873,290 @@ static bool st_us_mask_check(DisasContext *s, arg_vsm_v *a, uint8_t eew)
> >   GEN_VEXT_TRANS(vlm_v, MO_8, vlm_v, ld_us_mask_op, ld_us_mask_check)
> >   GEN_VEXT_TRANS(vsm_v, MO_8, vsm_v, st_us_mask_op, st_us_mask_check)
> > +/*
> > + * MAXSZ returns the maximum vector size can be operated in bytes,
> > + * which is used in GVEC IR when vl_eq_vlmax flag is set to true
> > + * to accelerate vector operation.
> > + */
> > +static inline uint32_t MAXSZ(DisasContext *s)
> > +{
> > +    int max_sz = s->cfg_ptr->vlenb << 3;
> > +    return max_sz >> (3 - s->lmul);
> > +}
> > +
> > +static inline uint32_t get_log2(uint32_t a)
> > +{
> > +    assert(is_power_of_2(a));
> > +    return ctz32(a);
> > +}
> > +
> > +typedef void gen_tl_ldst(TCGv, TCGv_ptr, tcg_target_long);
> > +
> > +static void gen_ldst_vreg(DisasContext *s, TCGv_i64 dest_offs, TCGv_i64 addr,
> > +                          gen_tl_ldst *ld_fn, gen_tl_ldst *st_fn, bool is_load)
> > +{
> > +    MemOp atomicity = (s->sew == 0) ? MO_ATOM_NONE : MO_ATOM_IFALIGN_PAIR;
> > +    TCGv_ptr dest_ptr = tcg_temp_new_ptr();
> > +    TCGv_i64 vreg = tcg_temp_new_i64();
> > +    tcg_gen_trunc_i64_ptr(dest_ptr, dest_offs);
> > +
> > +    if (is_load) {
> > +        tcg_gen_qemu_ld_tl(vreg, addr, s->mem_idx, MO_LE | s->sew | atomicity);
> > +        st_fn(vreg, dest_ptr, 0);
> 
> So I'm not sure how we missed this for this long hehehe but this won't build
> for riscv32-softmmu:
> 
> 
> In file included from ../target/riscv/translate.c:1207:
> ../target/riscv/insn_trans/trans_rvv.c.inc: In function ‘gen_ldst_vreg’:
> ../target/riscv/insn_trans/trans_rvv.c.inc:904:28: error: passing argument 1 of ‘tcg_gen_qemu_ld_i32’ from incompatible pointer type [-Werror=incompatible-pointer-types]
>   904 |         tcg_gen_qemu_ld_tl(vreg, addr, s->mem_idx, MO_LE | s->sew | atomicity);
>       |                            ^~~~
>       |                            |
>       |                            TCGv_i64 {aka struct TCGv_i64_d *}
> In file included from ../target/riscv/translate.c:22:
> /home/dbarboza/work/qemu/include/tcg/tcg-op.h:50:30: note: expected ‘TCGv_i32’ {aka ‘struct TCGv_i32_d *’} but argument is of type ‘TCGv_i64’ {aka ‘struct TCGv_i64_d *’}
>    50 | tcg_gen_qemu_ld_i32(TCGv_i32 v, TCGv a, TCGArg i, MemOp m)
> 
> 
> The issue here is that you're using tcg_gen_qemu_ld_tl() with a TCGv_i64 arg.
> This works normally in a 64 bit but, for a riscv32 build, tcg_gen_qemu_ld_tl
> will default to tcg_gen_qemu_ld_i32 (from tcg-op.h):
> 
Oh, I was too focused on the riscv64 implementation before.
Thanks for helping compile and test!

> #if TARGET_LONG_BITS == 32
> typedef TCGv_i32 TCGv;
> #define tcg_temp_new() tcg_temp_new_i32()
> #define tcg_global_mem_new tcg_global_mem_new_i32
> #define tcgv_tl_temp tcgv_i32_temp
> #define tcg_gen_qemu_ld_tl tcg_gen_qemu_ld_i32  <=========
> #define tcg_gen_qemu_st_tl tcg_gen_qemu_st_i32
> 
> 
> Given that vreg is a TCGv_i64 what would work here is use tcg_gen_qemu_ld_i64 directly.
> But note that this code needs to work for 32 bits too, therefore I'm not sure if vreg
> should be fixed in 64 bits like we're doing here.
> 
> I suggest using vreg as 'TCGv" and then initiating it via "tcg_temp_new()".
> This will create either a i32 or a i64 var depending on the build target.
> You can then keep using tcg_gen_qemu_ld_tl().
> 
Yes, you're right. I'll fix it in the next version and make sure the full CI passes.

Thanks,
Chao

> Note that this is not the only build error I caught and there might be others
> similars.  You'll have to test the patch building with riscv32-softmmu to
> address all of them.
> 
> 
> Thanks,
> Daniel
> 
> 
> 
> 
> > +    } else {
> > +        ld_fn(vreg, dest_ptr, 0);
> > +        tcg_gen_qemu_st_tl(vreg, addr, s->mem_idx, MO_LE | s->sew | atomicity);
> > +    }
> > +    tcg_temp_free_ptr(dest_ptr);
> > +    tcg_temp_free_i64(vreg);
> > +}
> > +
> > +/*
> > + * Check whether the i bit of the mask is 0 or 1.
> > + *
> > + * static inline int vext_elem_mask(void *v0, int index)
> > + * {
> > + *     int idx = index / 64;
> > + *     int pos = index % 64;
> > + *     return (((uint64_t *)v0)[idx] >> pos) & 1;
> > + * }
> > + *
> > + * And
> > + *
> > + * if (vext_elem_mask(v0, i) != 0) {
> > + *     goto label;
> > + * }
> > + */
> > +static void gen_check_vext_elem_mask(DisasContext *s, TCGLabel *label,
> > +                                     TCGv_i64 mask_offs)
> > +{
> > +    TCGv_i64 temp = tcg_temp_new_i64();
> > +    TCGv_ptr ptr = tcg_temp_new_ptr();
> > +    TCGv_i64 elem = tcg_temp_new_i64();
> > +
> > +    tcg_gen_shri_tl(temp, mask_offs, 3);
> > +    tcg_gen_trunc_i64_ptr(ptr, temp);
> > +    tcg_gen_add_ptr(ptr, ptr, tcg_env);
> > +
> > +    tcg_gen_ld8u_i64(elem, ptr, 0);
> > +    tcg_gen_andi_tl(temp, mask_offs, 7);
> > +    tcg_gen_shr_tl(elem, elem, temp);
> > +    tcg_gen_brcond_i64(TCG_COND_TSTNE, elem, tcg_constant_i64(1), label);
> > +
> > +    tcg_temp_free_i64(temp);
> > +    tcg_temp_free_ptr(ptr);
> > +    tcg_temp_free_i64(elem);
> > +}
> > +
> > +static void gen_vext_set_elems_1s(TCGv dest, TCGv_i64 mask_offs, int sew,
> > +                                  gen_tl_ldst *st_fn, bool is_load)
> > +{
> > +    if (is_load) {
> > +        TCGv_ptr ptr = tcg_temp_new_ptr();
> > +        tcg_gen_shli_tl(mask_offs, mask_offs, sew);
> > +        tcg_gen_add_tl(mask_offs, mask_offs, dest);
> > +        tcg_gen_trunc_i64_ptr(ptr, mask_offs);
> > +        st_fn(tcg_constant_tl(-1), ptr, 0);
> > +        tcg_temp_free_ptr(ptr);
> > +    }
> > +}
> > +
> > +/*
> > + * Simulate the strided load/store main loop:
> > + *
> > + * for (i = env->vstart; i < env->vl; env->vstart = ++i) {
> > + *     k = 0;
> > + *     while (k < nf) {
> > + *         if (!vm && !vext_elem_mask(v0, i)) {
> > + *             vext_set_elems_1s(vd, vma, (i + k * max_elems) * esz,
> > + *                               (i + k * max_elems + 1) * esz);
> > + *             k++;
> > + *             continue;
> > + *         }
> > + *         target_ulong addr = base + stride * i + (k << log2_esz);
> > + *         ldst(env, adjust_addr(env, addr), i + k * max_elems, vd, ra);
> > + *         k++;
> > + *     }
> > + * }
> > + */
> > +static void gen_ldst_stride_main_loop(DisasContext *s, TCGv dest, uint32_t rs1,
> > +                                      uint32_t rs2, uint32_t vm, uint32_t nf,
> > +                                      gen_tl_ldst *ld_fn, gen_tl_ldst *st_fn,
> > +                                      bool is_load)
> > +{
> > +    TCGv_i64 addr = tcg_temp_new_i64();
> > +    TCGv base = get_gpr(s, rs1, EXT_NONE);
> > +    TCGv stride = get_gpr(s, rs2, EXT_NONE);
> > +
> > +    TCGv i = tcg_temp_new();
> > +    TCGv i_esz = tcg_temp_new();
> > +    TCGv k = tcg_temp_new();
> > +    TCGv k_esz = tcg_temp_new();
> > +    TCGv k_max = tcg_temp_new();
> > +    TCGv_i64 mask_offs = tcg_temp_new_i64();
> > +    TCGv_i64 dest_offs = tcg_temp_new_i64();
> > +    TCGv_i64 stride_offs = tcg_temp_new_i64();
> > +
> > +    uint32_t max_elems = MAXSZ(s) >> s->sew;
> > +
> > +    TCGLabel *start = gen_new_label();
> > +    TCGLabel *end = gen_new_label();
> > +    TCGLabel *start_k = gen_new_label();
> > +    TCGLabel *inc_k = gen_new_label();
> > +    TCGLabel *end_k = gen_new_label();
> > +
> > +    /* Start of outer loop. */
> > +    tcg_gen_mov_tl(i, cpu_vstart);
> > +    gen_set_label(start);
> > +    tcg_gen_brcond_tl(TCG_COND_GE, i, cpu_vl, end);
> > +    tcg_gen_shli_tl(i_esz, i, s->sew);
> > +
> > +    /* Start of inner loop. */
> > +    tcg_gen_movi_tl(k, 0);
> > +    gen_set_label(start_k);
> > +    tcg_gen_brcond_tl(TCG_COND_GE, k, tcg_constant_tl(nf), end_k);
> > +
> > +    /*
> > +     * If we are in mask agnostic regime and the operation is not unmasked we
> > +     * set the inactive elements to 1.
> > +     */
> > +    if (!vm && s->vma) {
> > +        TCGLabel *active_element = gen_new_label();
> > +        /* (i + k * max_elems) * esz */
> > +        tcg_gen_shli_tl(mask_offs, k, get_log2(max_elems << s->sew));
> > +        tcg_gen_add_tl(mask_offs, mask_offs, i_esz);
> > +
> > +        /*
> > +         * Check whether the i bit of the mask is 0 or 1.
> > +         * If it is 0, set masked-off elements;
> > +         * otherwise, directly load/store the vector register.
> > +         */
> > +        gen_check_vext_elem_mask(s, active_element, mask_offs);
> > +
> > +        /*
> > +         * Set masked-off elements in the destination vector register to 1s.
> > +         * Store instructions simply skip this bit as memory ops access memory
> > +         * only for active elements.
> > +         */
> > +        gen_vext_set_elems_1s(dest, mask_offs, s->sew, st_fn, is_load);
> > +
> > +        tcg_gen_br(inc_k);
> > +        gen_set_label(active_element);
> > +    }
> > +
> > +    /*
> > +     * The element is active, calculate the address with stride:
> > +     * target_ulong addr = base + stride * i + (k << log2_esz);
> > +     */
> > +    tcg_gen_mul_tl(stride_offs, stride, i);
> > +    tcg_gen_shli_tl(k_esz, k, s->sew);
> > +    tcg_gen_add_tl(stride_offs, stride_offs, k_esz);
> > +    tcg_gen_add_tl(addr, base, stride_offs);
> > +
> > +    /* Calculate the offset in the dst/src vector register. */
> > +    tcg_gen_shli_tl(k_max, k, get_log2(max_elems));
> > +    tcg_gen_add_tl(dest_offs, i, k_max);
> > +    tcg_gen_shli_tl(dest_offs, dest_offs, s->sew);
> > +    tcg_gen_add_tl(dest_offs, dest_offs, dest);
> > +
> > +    /* Load/Store vector register. */
> > +    gen_ldst_vreg(s, dest_offs, addr, ld_fn, st_fn, is_load);
> > +
> > +    /*
> > +     * We don't execute the load/store above if the element was inactive.
> > +     * We jump instead directly to incrementing k and continuing the loop.
> > +     */
> > +    if (!vm && s->vma) {
> > +        gen_set_label(inc_k);
> > +    }
> > +    tcg_gen_addi_tl(k, k, 1);
> > +    tcg_gen_br(start_k);
> > +
> > +    /* End of the inner loop. */
> > +    gen_set_label(end_k);
> > +
> > +    tcg_gen_addi_tl(i, i, 1);
> > +    tcg_gen_mov_tl(cpu_vstart, i);
> > +    tcg_gen_br(start);
> > +
> > +    /* End of the outer loop. */
> > +    gen_set_label(end);
> > +
> > +    return;
> > +}
> > +
> > +/*
> > + * Set the tail bytes of the strided loads/stores to 1:
> > + *
> > + * for (k = 0; k < nf; ++k) {
> > + *     cnt = (k * max_elems + vl) * esz;
> > + *     tot = (k * max_elems + max_elems) * esz;
> > + *     for (i = cnt; i < tot; i += esz) {
> > + *         store_1s(-1, vd[vl+i]);
> > + *     }
> > + * }
> > + */
> > +static void gen_ldst_stride_tail_loop(DisasContext *s, TCGv dest, uint32_t nf,
> > +                                      gen_tl_ldst *st_fn)
> > +{
> > +    TCGv i = tcg_temp_new();
> > +    TCGv k = tcg_temp_new();
> > +    TCGv tail_cnt = tcg_temp_new();
> > +    TCGv tail_tot = tcg_temp_new();
> > +    TCGv tail_addr = tcg_temp_new();
> > +
> > +    TCGLabel *start = gen_new_label();
> > +    TCGLabel *end = gen_new_label();
> > +    TCGLabel *start_i = gen_new_label();
> > +    TCGLabel *end_i = gen_new_label();
> > +
> > +    uint32_t max_elems_b = MAXSZ(s);
> > +    uint32_t esz = 1 << s->sew;
> > +
> > +    /* Start of the outer loop. */
> > +    tcg_gen_movi_tl(k, 0);
> > +    tcg_gen_shli_tl(tail_cnt, cpu_vl, s->sew);
> > +    tcg_gen_movi_tl(tail_tot, max_elems_b);
> > +    tcg_gen_add_tl(tail_addr, dest, tail_cnt);
> > +    gen_set_label(start);
> > +    tcg_gen_brcond_tl(TCG_COND_GE, k, tcg_constant_tl(nf), end);
> > +
> > +    /* Start of the inner loop. */
> > +    tcg_gen_mov_tl(i, tail_cnt);
> > +    gen_set_label(start_i);
> > +    tcg_gen_brcond_tl(TCG_COND_GE, i, tail_tot, end_i);
> > +
> > +    /* store_1s(-1, vd[vl+i]); */
> > +    st_fn(tcg_constant_tl(-1), (TCGv_ptr)tail_addr, 0);
> > +    tcg_gen_addi_tl(tail_addr, tail_addr, esz);
> > +    tcg_gen_addi_tl(i, i, esz);
> > +    tcg_gen_br(start_i);
> > +
> > +    /* End of the inner loop. */
> > +    gen_set_label(end_i);
> > +
> > +    /* Update the counts */
> > +    tcg_gen_addi_tl(tail_cnt, tail_cnt, max_elems_b);
> > +    tcg_gen_addi_tl(tail_tot, tail_cnt, max_elems_b);
> > +    tcg_gen_addi_tl(k, k, 1);
> > +    tcg_gen_br(start);
> > +
> > +    /* End of the outer loop. */
> > +    gen_set_label(end);
> > +
> > +    return;
> > +}
> > +
> >   /*
> >    *** stride load and store
> >    */
> >   typedef void gen_helper_ldst_stride(TCGv_ptr, TCGv_ptr, TCGv,
> >                                       TCGv, TCGv_env, TCGv_i32);
> > -static bool ldst_stride_trans(uint32_t vd, uint32_t rs1, uint32_t rs2,
> > -                              uint32_t data, gen_helper_ldst_stride *fn,
> > -                              DisasContext *s)
> > +static
> > +bool gen_call_helper_ldst_stride(uint32_t vd, uint32_t rs1, uint32_t rs2,
> > +                                 uint32_t data, gen_helper_ldst_stride *fn,
> > +                                 DisasContext *s)
> >   {
> >       TCGv_ptr dest, mask;
> >       TCGv base, stride;
> > @@ -904,11 +1180,66 @@ static bool ldst_stride_trans(uint32_t vd, uint32_t rs1, uint32_t rs2,
> >       return true;
> >   }
> > +static bool ldst_stride_trans(uint32_t vd, uint32_t rs1, uint32_t rs2,
> > +                              uint32_t data, gen_helper_ldst_stride *fn,
> > +                              DisasContext *s, bool is_load)
> > +{
> > +    if (!s->vstart_eq_zero) {
> > +        /* vstart != 0 helper slowpath */
> > +        return gen_call_helper_ldst_stride(vd, rs1, rs2, data, fn, s);
> > +    }
> > +
> > +    TCGv dest = tcg_temp_new();
> > +
> > +    uint32_t nf = FIELD_EX32(data, VDATA, NF);
> > +    uint32_t vm = FIELD_EX32(data, VDATA, VM);
> > +
> > +    /* Destination register and mask register */
> > +    tcg_gen_addi_tl(dest, (TCGv)tcg_env, vreg_ofs(s, vd));
> > +
> > +    /*
> > +     * Select the appropriate load/store to retrieve data from the vector
> > +     * register given a specific sew.
> > +     */
> > +    static gen_tl_ldst * const ld_fns[4] = {
> > +        tcg_gen_ld8u_tl, tcg_gen_ld16u_tl,
> > +        tcg_gen_ld32u_tl, tcg_gen_ld_tl
> > +    };
> > +
> > +    static gen_tl_ldst * const st_fns[4] = {
> > +        tcg_gen_st8_tl, tcg_gen_st16_tl,
> > +        tcg_gen_st32_tl, tcg_gen_st_tl
> > +    };
> > +
> > +    gen_tl_ldst *ld_fn = ld_fns[s->sew];
> > +    gen_tl_ldst *st_fn = st_fns[s->sew];
> > +
> > +    if (ld_fn == NULL || st_fn == NULL) {
> > +        return false;
> > +    }
> > +
> > +    mark_vs_dirty(s);
> > +
> > +    gen_ldst_stride_main_loop(s, dest, rs1, rs2, vm, nf, ld_fn, st_fn, is_load);
> > +
> > +    tcg_gen_movi_tl(cpu_vstart, 0);
> > +
> > +    /*
> > +     * Set the tail bytes to 1 if tail agnostic:
> > +     */
> > +    if (s->vta != 0 && is_load) {
> > +        gen_ldst_stride_tail_loop(s, dest, nf, st_fn);
> > +    }
> > +
> > +    finalize_rvv_inst(s);
> > +    return true;
> > +}
> > +
> >   static bool ld_stride_op(DisasContext *s, arg_rnfvm *a, uint8_t eew)
> >   {
> >       uint32_t data = 0;
> >       gen_helper_ldst_stride *fn;
> > -    static gen_helper_ldst_stride * const fns[4] = {
> > +    static gen_helper_ldst_stride *const fns[4] = {
> >           gen_helper_vlse8_v, gen_helper_vlse16_v,
> >           gen_helper_vlse32_v, gen_helper_vlse64_v
> >       };
> > @@ -924,7 +1255,7 @@ static bool ld_stride_op(DisasContext *s, arg_rnfvm *a, uint8_t eew)
> >       data = FIELD_DP32(data, VDATA, NF, a->nf);
> >       data = FIELD_DP32(data, VDATA, VTA, s->vta);
> >       data = FIELD_DP32(data, VDATA, VMA, s->vma);
> > -    return ldst_stride_trans(a->rd, a->rs1, a->rs2, data, fn, s);
> > +    return ldst_stride_trans(a->rd, a->rs1, a->rs2, data, fn, s, true);
> >   }
> >   static bool ld_stride_check(DisasContext *s, arg_rnfvm* a, uint8_t eew)
> > @@ -958,7 +1289,7 @@ static bool st_stride_op(DisasContext *s, arg_rnfvm *a, uint8_t eew)
> >           return false;
> >       }
> > -    return ldst_stride_trans(a->rd, a->rs1, a->rs2, data, fn, s);
> > +    return ldst_stride_trans(a->rd, a->rs1, a->rs2, data, fn, s, false);
> >   }
> >   static bool st_stride_check(DisasContext *s, arg_rnfvm* a, uint8_t eew)
> > @@ -1281,17 +1612,6 @@ GEN_LDST_WHOLE_TRANS(vs8r_v, int8_t, 8, false)
> >    *** Vector Integer Arithmetic Instructions
> >    */
> > -/*
> > - * MAXSZ returns the maximum vector size can be operated in bytes,
> > - * which is used in GVEC IR when vl_eq_vlmax flag is set to true
> > - * to accelerate vector operation.
> > - */
> > -static inline uint32_t MAXSZ(DisasContext *s)
> > -{
> > -    int max_sz = s->cfg_ptr->vlenb * 8;
> > -    return max_sz >> (3 - s->lmul);
> > -}
> > -
> >   static bool opivv_check(DisasContext *s, arg_rmrr *a)
> >   {
> >       return require_rvv(s) &&
> 

