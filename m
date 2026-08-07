Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4195EC5AC7C
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 08:50:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsGHP-0006ec-Ta; Fri, 07 Aug 2026 04:50:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1wsGHO-0006eG-DV
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 04:50:14 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1wsGHL-0008TV-Tb
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 04:50:14 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-38f620399a0so2796152a91.2
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2026 01:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1786092610; x=1786697410; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=fGU/cJyoc/islJ5EownOTbwV5mrm3IJSiRFWsUERS08=;
 b=HGRATSNk01uWPHtRivIkj7qATFzNqyUpxyU8O/VZ/31EK1HMUzV71IZhipwYyxYblq
 Z0oSChAD82eOAym65kcYcQS2nlS/DBAehrzgc28V0IMVPWDdGPDwHcI5YboD7lde1iai
 wafut7jQsSGoAfwfkE6TrkS7PG5rJjBU0Es6kdmrJs60Xy4uHrnG1hs6NOBWGc2QFPOh
 wvxnAn0nw2qOUP0iUFFwdNry5CjQk9Him+BPA6DOfKeiM0GdBDQU+YSSwgPUIHV9k1E/
 e5L9stQqRS55bV5E4gTxUFA1Lfc1SbD+tW5sqG2r6No0c9MIUkfb7QMeITHikvz5cDOJ
 mX+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786092610; x=1786697410;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=fGU/cJyoc/islJ5EownOTbwV5mrm3IJSiRFWsUERS08=;
 b=RkzgG6TDoJ7KcmiM+AL0Lj0N+TaLvM5aj++hsC/Vu+AcCYAcd4bWMm0zmcCiVNW9Bg
 RUmelAUWflXwk+PHhHmGmA9ivoRUsWFphwdJ8QxqJrsz2XMWCcDe39Gj6eu1kCdSnm0L
 4VW5w5LD0YMZq323LELRb8My0SsSjhoBq6tct8LN6jDwL7ypbmxDL5UThx6pqD2xxMRj
 aHfUsRwqg9B5zAk/+7niuj69lppunQlSal/zabyq1vvmI/c9xftF6xRrphwxk97F3G40
 wQFD0JADUo6vPOBcDEPW65+3prL73UnWmGAS+Ev5FJPVKkeootqAK79DFm1/xbfeET7k
 4GpA==
X-Gm-Message-State: AOJu0Yw2X9gifVZk0fyEFdVKPmV1gujgYfgISk/zI69XzyIxMz33dGQ9
 daWmUNZY2e0Ppmhapgh7i/ZvPzfZBx+uPztP2HctnL40M7ucU7bB/ywBhjhGuvnqdTA=
X-Gm-Gg: AR+sD13ir/Cj4aIfGIhWytVJOYAjwVbyp12EAYhIqXChw0XC43B/BvBKaCI9Lqf54F+
 lEsWUUYyhZKYOl8qpHjMBXLnHECkvETwTb00lUgpBahg300GSUlTnuVS/RJ0RK8rbJHeqNdnFsC
 dWosTJ2fpVk6Pa0WJaYOLDaPGlR/Y1tWjDCXmzmE/l+k/Rw/fAxmEwYRa1VjUDGKCNyeEgqPeXA
 HPx4IMxs5vPAIwWC48xitCcidS/x6wkydwx9zkTIKTNvHda5huTSNniFJ5GoArYKI81pGWkM4x2
 NLKSYHgUiqCCEvJbrhC9GcsJlFWD/m7jxHLDdeHNdo1pFSyg/N/Lb9ei3bX738luNrDjOEbCjqZ
 UgMCFQWq8HAe57F2BosOcwDkPKH49NBS73ufo9hOpIVRE8396kycmjqhlYTF4n4dxuXNujXi0DE
 D/mnjQYHA/k0HGXYcT193Mv3v7obkohFuFB1hy2N1mXJ2LLFtKm4IRgNI1zZvNHfQj20X/TzEXS
 RtQG5cttIY/f8VX5MvE2bElOpoVYLHUZb8=
X-Received: by 2002:a17:90a:da83:b0:38e:500:3975 with SMTP id
 98e67ed59e1d1-3903c5d82a3mr20194934a91.18.1786092609619; 
 Fri, 07 Aug 2026 01:50:09 -0700 (PDT)
Received: from sifive.com ([136.226.240.165]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39085dbf82csm4004261a91.1.2026.08.07.01.50.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 01:50:09 -0700 (PDT)
Date: Fri, 7 Aug 2026 16:50:02 +0800
From: Max Chou <max.chou@sifive.com>
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>, Frank Chang <frank.chang@sifive.com>
Subject: Re: [PATCH 3/5] target/riscv: rvv: Add SiFive custom int8 matmul
 instructions
Message-ID: <anWYFy7730o4auCV@sifive.com>
References: <20260721122034.1567146-1-max.chou@sifive.com>
 <20260721122034.1567146-4-max.chou@sifive.com>
 <537a0ac1-8970-4ffc-934d-293d44f159c0@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <537a0ac1-8970-4ffc-934d-293d44f159c0@oss.qualcomm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=max.chou@sifive.com; helo=mail-pj1-x1029.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 2026-08-06 18:13, Daniel Henrique Barboza wrote:
> 
> 
> On 7/21/2026 9:20 AM, Max Chou wrote:
> > From: Frank Chang <frank.chang@sifive.com>
> > 
> > Add the 8 SiFive custom int8 matrix-multiply vector instructions:
> > sf.vqmacc{u,,us,su}.4x8x4 and sf.vqmacc{u,,us,su}.2x8x2. Each name
> > suffix encodes the signedness of vs1/vs2.
> > The 4x8x4 forms multiply-accumulate a 4x8 by 8x4 int8 tile into a
> > 4x4 int32 result; the 2x8x2 forms use a 2x8 by 8x2 tile producing a
> > 2x2 int32 result. Both Xsfvqmaccqoq/Xsfvqmaccdod extensions are
> > gated on vlenb >= 32, sew == 8 and vm == 1, per the SiFive Int8
> > Matrix Multiplication Extensions Specification.
> > 
> > Signed-off-by: Frank Chang <frank.chang@sifive.com>
> > Signed-off-by: Max Chou <max.chou@sifive.com>
> > ---
> 
> One thing that caught my attention is adding what is, at least for now,
> a vendor specific helper in vector_helper.c which is a common code
> helper.  Existing vendor extensions in QEMU doesn't do that, at least
> from what I can see.
> 
> All this said, I have a suspicion that the code for this extension will
> be re-used in zvldot/zvbdot, so keeping this helper in vector_helper.c
> is ok to me.
> 
> 

Hi Daniel,

I believe we can move the vendor helper to the new helper file at v2.
Additionally, we can extract the common part into vector_helper.c or
vector_internal.h for related ISA extensions in the future.

In fact, I’m preparing the upstream patchset for Zvdota/Zvbdota
extensions and will send it after a release tag is added to the
riscv-isa-manual repository.

Thanks,
rnax

> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> 
> 
> >   MAINTAINERS                                 |  7 ++
> >   target/riscv/cpu_cfg.h                      |  5 ++
> >   target/riscv/helper.h                       | 10 +++
> >   target/riscv/meson.build                    |  1 +
> >   target/riscv/tcg/insn_trans/trans_xsf.c.inc | 98 +++++++++++++++++++++
> >   target/riscv/tcg/translate.c                |  3 +
> >   target/riscv/tcg/vector_helper.c            | 74 ++++++++++++++++
> >   target/riscv/xsf.decode                     | 30 +++++++
> >   8 files changed, 228 insertions(+)
> >   create mode 100644 target/riscv/tcg/insn_trans/trans_xsf.c.inc
> >   create mode 100644 target/riscv/xsf.decode
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 97dcc78ded..94cd63eeba 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -389,6 +389,13 @@ F: target/riscv/XVentanaCondOps.decode
> >   F: target/riscv/insn_trans/trans_xventanacondops.c.inc
> >   F: disas/riscv-xventana*
> > +RISC-V SiFive (Xsf*) extensions
> > +M: Max Chou <max.chou@sifive.com>
> > +L: qemu-riscv@nongnu.org
> > +S: Supported
> > +F: target/riscv/xsf.decode
> > +F: target/riscv/tcg/insn_trans/trans_xsf.c.inc
> > +
> >   RENESAS RX CPUs
> >   R: Yoshinori Sato <yoshinori.sato@nifty.com>
> >   S: Orphan
> > diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> > index 211d0708ba..d6db1cfb7c 100644
> > --- a/target/riscv/cpu_cfg.h
> > +++ b/target/riscv/cpu_cfg.h
> > @@ -51,6 +51,11 @@ static inline bool has_xthead_p(const RISCVCPUConfig *cfg)
> >              cfg->ext_xtheadmempair || cfg->ext_xtheadsync;
> >   }
> > +static inline bool has_xsf_p(const RISCVCPUConfig *cfg)
> > +{
> > +    return cfg->ext_xsfvqmaccdod || cfg->ext_xsfvqmaccqoq;
> > +}
> > +
> >   #define MATERIALISE_EXT_PREDICATE(ext) \
> >       static inline bool has_ ## ext ## _p(const RISCVCPUConfig *cfg) \
> >       { \
> > diff --git a/target/riscv/helper.h b/target/riscv/helper.h
> > index 542b7c264f..4234f46271 100644
> > --- a/target/riscv/helper.h
> > +++ b/target/riscv/helper.h
> > @@ -1358,3 +1358,13 @@ DEF_HELPER_1(ssamoswap_disabled, void, env)
> >   /* Zalrsc SC write probe */
> >   DEF_HELPER_FLAGS_3(sc_probe_write, TCG_CALL_NO_WG, void, env, tl, tl)
> > +
> > +/* SiFive Custom int8 Matrix-Multiply */
> > +DEF_HELPER_5(sf_vqmaccu_4x8x4, void, ptr, ptr, ptr, env, i32)
> > +DEF_HELPER_5(sf_vqmacc_4x8x4, void, ptr, ptr, ptr, env, i32)
> > +DEF_HELPER_5(sf_vqmaccus_4x8x4, void, ptr, ptr, ptr, env, i32)
> > +DEF_HELPER_5(sf_vqmaccsu_4x8x4, void, ptr, ptr, ptr, env, i32)
> > +DEF_HELPER_5(sf_vqmaccu_2x8x2, void, ptr, ptr, ptr, env, i32)
> > +DEF_HELPER_5(sf_vqmacc_2x8x2, void, ptr, ptr, ptr, env, i32)
> > +DEF_HELPER_5(sf_vqmaccus_2x8x2, void, ptr, ptr, ptr, env, i32)
> > +DEF_HELPER_5(sf_vqmaccsu_2x8x2, void, ptr, ptr, ptr, env, i32)
> > diff --git a/target/riscv/meson.build b/target/riscv/meson.build
> > index 42d0f6d538..c06526adb2 100644
> > --- a/target/riscv/meson.build
> > +++ b/target/riscv/meson.build
> > @@ -6,6 +6,7 @@ gen = [
> >     decodetree.process('XVentanaCondOps.decode', extra_args: '--static-decode=decode_XVentanaCodeOps'),
> >     decodetree.process('xmips.decode', extra_args: '--static-decode=decode_xmips'),
> >     decodetree.process('xlrbr.decode', extra_args: '--static-decode=decode_xlrbr'),
> > +  decodetree.process('xsf.decode', extra_args: '--static-decode=decode_xsf'),
> >   ]
> >   riscv_ss = ss.source_set()
> > diff --git a/target/riscv/tcg/insn_trans/trans_xsf.c.inc b/target/riscv/tcg/insn_trans/trans_xsf.c.inc
> > new file mode 100644
> > index 0000000000..1677352689
> > --- /dev/null
> > +++ b/target/riscv/tcg/insn_trans/trans_xsf.c.inc
> > @@ -0,0 +1,98 @@
> > +/*
> > + * RISC-V translation routines for the SiFive vendor extensions (xsf*)
> > + *
> > + * Copyright (c) 2023 SiFive, Inc.
> > + *
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> > + */
> > +
> > +
> > +/*
> > + * SiFive Xsfvqmaccdod/Xsfvqmaccqoq custom int8 matrix-multiply extensions
> > + */
> > +static bool sf_int8_matmul_check(DisasContext *s, arg_rmrr *a)
> > +{
> > +    return require_rvv(s) &&
> > +           vext_check_isa_ill(s) &&
> > +           s->vstart_eq_zero &&
> > +           (s->cfg_ptr->vlenb >= 32) &&
> > +           (s->sew == MO_8) &&
> > +           (a->vm == 1);
> > +}
> > +
> > +static bool sf_int8_matmul_4x8x4_check(DisasContext *s, arg_rmrr *a)
> > +{
> > +    /*
> > +     * vd  has EMUL=2*LMUL
> > +     * vs2 has EMUL=LMUL
> > +     * vs1 has EMUL=1
> > +     * vd must not overlap vs1
> > +     */
> > +    return sf_int8_matmul_check(s, a) &&
> > +           (s->cfg_ptr->ext_xsfvqmaccqoq) &&
> > +           (s->lmul <= 2) &&
> > +           require_align(a->rd, s->lmul + 1) &&
> > +           require_align(a->rs2, s->lmul) &&
> > +           require_align(a->rs1, 0) &&
> > +           require_noover(a->rd, s->lmul + 1, a->rs2, s->lmul) &&
> > +           !is_overlapped(a->rd, 1 << MAX(s->lmul + 1, 0), a->rs1, 1);
> > +}
> > +
> > +static bool sf_int8_matmul_2x8x2_check(DisasContext *s, arg_rmrr *a)
> > +{
> > +    /*
> > +     * vd  has EMUL=LMUL
> > +     * vs2 has EMUL=LMUL
> > +     * vs1 has EMUL=1
> > +     * vd must not overlap vs1
> > +     */
> > +    return sf_int8_matmul_check(s, a) &&
> > +           (s->cfg_ptr->ext_xsfvqmaccdod) &&
> > +           require_align(a->rd, s->lmul) &&
> > +           require_align(a->rs2, s->lmul) &&
> > +           require_align(a->rs1, 0) &&
> > +           !is_overlapped(a->rd, 1 << MAX(s->lmul, 0), a->rs1, 1);
> > +}
> > +
> > +static bool sf_int8_matmul_op(DisasContext *s, arg_rmrr *a, uint8_t seq)
> > +{
> > +    static gen_helper_gvec_3_ptr * const fns[8] = {
> > +        gen_helper_sf_vqmaccu_4x8x4, gen_helper_sf_vqmacc_4x8x4,
> > +        gen_helper_sf_vqmaccus_4x8x4, gen_helper_sf_vqmaccsu_4x8x4,
> > +        gen_helper_sf_vqmaccu_2x8x2, gen_helper_sf_vqmacc_2x8x2,
> > +        gen_helper_sf_vqmaccus_2x8x2, gen_helper_sf_vqmaccsu_2x8x2,
> > +    };
> > +
> > +    /*
> > +     * The helper raises an illegal-instruction exception when vl is not a
> > +     * multiple of the tile size; save the opcode so mtval/stval report the
> > +     * faulting instruction if that exception is thrown.
> > +     */
> > +    decode_save_opc(s, 0);
> > +
> > +    tcg_gen_gvec_3_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, a->rs1),
> > +                       vreg_ofs(s, a->rs2), tcg_env,
> > +                       s->cfg_ptr->vlenb, s->cfg_ptr->vlenb, 0, fns[seq]);
> > +
> > +    finalize_rvv_inst(s);
> > +
> > +    return true;
> > +}
> > +
> > +#define GEN_SF_INT8_MATMUL_TRANS(NAME, CHECK, SEQ)       \
> > +static bool trans_##NAME(DisasContext *s, arg_rmrr *a)   \
> > +{                                                        \
> > +    if (CHECK(s, a)) {                                   \
> > +        return sf_int8_matmul_op(s, a, SEQ);             \
> > +    }                                                    \
> > +    return false;                                        \
> > +}
> > +
> > +GEN_SF_INT8_MATMUL_TRANS(sf_vqmaccu_4x8x4,  sf_int8_matmul_4x8x4_check, 0)
> > +GEN_SF_INT8_MATMUL_TRANS(sf_vqmacc_4x8x4,   sf_int8_matmul_4x8x4_check, 1)
> > +GEN_SF_INT8_MATMUL_TRANS(sf_vqmaccus_4x8x4, sf_int8_matmul_4x8x4_check, 2)
> > +GEN_SF_INT8_MATMUL_TRANS(sf_vqmaccsu_4x8x4, sf_int8_matmul_4x8x4_check, 3)
> > +GEN_SF_INT8_MATMUL_TRANS(sf_vqmaccu_2x8x2,  sf_int8_matmul_2x8x2_check, 4)
> > +GEN_SF_INT8_MATMUL_TRANS(sf_vqmacc_2x8x2,   sf_int8_matmul_2x8x2_check, 5)
> > +GEN_SF_INT8_MATMUL_TRANS(sf_vqmaccus_2x8x2, sf_int8_matmul_2x8x2_check, 6)
> > +GEN_SF_INT8_MATMUL_TRANS(sf_vqmaccsu_2x8x2, sf_int8_matmul_2x8x2_check, 7)
> > diff --git a/target/riscv/tcg/translate.c b/target/riscv/tcg/translate.c
> > index 9684dbe752..41e3dd2fe2 100644
> > --- a/target/riscv/tcg/translate.c
> > +++ b/target/riscv/tcg/translate.c
> > @@ -1216,10 +1216,12 @@ static uint32_t opcode_at(DisasContextBase *dcbase, target_ulong pc)
> >   #include "decode-xthead.c.inc"
> >   #include "decode-xmips.c.inc"
> >   #include "decode-xlrbr.c.inc"
> > +#include "decode-xsf.c.inc"
> >   #include "insn_trans/trans_xthead.c.inc"
> >   #include "insn_trans/trans_xventanacondops.c.inc"
> >   #include "insn_trans/trans_xmips.c.inc"
> >   #include "insn_trans/trans_xlrbr.c.inc"
> > +#include "insn_trans/trans_xsf.c.inc"
> >   /* Include the auto-generated decoder for 16 bit insn */
> >   #include "decode-insn16.c.inc"
> > @@ -1240,6 +1242,7 @@ const RISCVDecoder decoder_table[] = {
> >       { has_xthead_p, decode_xthead},
> >       { has_XVentanaCondOps_p, decode_XVentanaCodeOps},
> >       { has_xlrbr_p, decode_xlrbr},
> > +    { has_xsf_p, decode_xsf },
> >   };
> >   const size_t decoder_table_size = ARRAY_SIZE(decoder_table);
> > diff --git a/target/riscv/tcg/vector_helper.c b/target/riscv/tcg/vector_helper.c
> > index e321ca2616..a9b5d861dc 100644
> > --- a/target/riscv/tcg/vector_helper.c
> > +++ b/target/riscv/tcg/vector_helper.c
> > @@ -5871,3 +5871,77 @@ GEN_VEXT_INT_EXT(vsext_vf2_d, int64_t, int32_t, H8, H4)
> >   GEN_VEXT_INT_EXT(vsext_vf4_w, int32_t, int8_t,  H4, H1)
> >   GEN_VEXT_INT_EXT(vsext_vf4_d, int64_t, int16_t, H8, H2)
> >   GEN_VEXT_INT_EXT(vsext_vf8_d, int64_t, int8_t,  H8, H1)
> > +
> > +/* SiFive Custom int8 Matrix-Multiply */
> > +#define SF_QOP_SUU_B int32_t, uint8_t, uint8_t, int32_t, int32_t
> > +#define SF_QOP_SUS_B int32_t, uint8_t, int8_t, int32_t, int32_t
> > +#define SF_QOP_SSU_B int32_t, int8_t, uint8_t, int32_t, int32_t
> > +#define SF_QOP_SSS_B int32_t, int8_t, int8_t, int32_t, int32_t
> > +
> > +/*
> > + * vd may overlap vs2, we need to allocate an additional vd array
> > + * to save temporary results of vd and write them back at the end.
> > + */
> > +#define GEN_VEXT_SF_INT8_MATMUL(NAME, TD, T1, T2, TX1, TX2,           \
> > +                                HD, HS1, HS2, ROWS, COLS, TILE_SIZE)  \
> > +void HELPER(NAME)(void *vd, void *vs1, void *vs2,                     \
> > +                  CPURISCVState *env, uint32_t desc)                  \
> > +{                                                                     \
> > +    int it, il, in, im, ivd, ivs1, ivs2;                              \
> > +    TD *vds;                                                          \
> > +                                                                      \
> > +    if (env->vl % TILE_SIZE) {                                        \
> > +        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC()); \
> > +        return;                                                       \
> > +    }                                                                 \
> > +                                                                      \
> > +    VSTART_CHECK_EARLY_EXIT(env, env->vl);                            \
> > +                                                                      \
> > +    vds = g_malloc0(sizeof(TD) *                                      \
> > +                    ROWS * ROWS * (env->vl / TILE_SIZE));             \
> > +                                                                      \
> > +    for (it = 0; it < (env->vl / TILE_SIZE); it++) {                  \
> > +        for (il = 0; il < ROWS; il++) {                               \
> > +            for (in = 0; in < ROWS; in++) {                           \
> > +                ivd = ROWS * ROWS * it + ROWS * il + in;              \
> > +                vds[ivd] = *((TD *)vd + HD(ivd));                     \
> > +                for (im = 0; im < COLS; im++) {                       \
> > +                    ivs1 = il * COLS + im;                            \
> > +                    ivs2 = TILE_SIZE * it + im * ROWS + in;           \
> > +                    T1 s1 = *((T1 *)vs1 + HS1(ivs1));                 \
> > +                    T2 s2 = *((T2 *)vs2 + HS2(ivs2));                 \
> > +                    vds[ivd] += (TX1)s1 * (TX2)s2;                    \
> > +                }                                                     \
> > +            }                                                         \
> > +        }                                                             \
> > +    }                                                                 \
> > +                                                                      \
> > +    for (it = 0; it < (env->vl / TILE_SIZE); it++) {                  \
> > +        for (il = 0; il < ROWS; il++) {                               \
> > +            for (in = 0; in < ROWS; in++) {                           \
> > +                ivd = ROWS * ROWS * it + ROWS * il + in;              \
> > +                *((TD *)vd + HD(ivd)) = vds[ivd];                     \
> > +            }                                                         \
> > +        }                                                             \
> > +    }                                                                 \
> > +                                                                      \
> > +    env->vstart = 0;                                                  \
> > +    g_free(vds);                                                      \
> > +}
> > +
> > +RVVCALL(GEN_VEXT_SF_INT8_MATMUL, sf_vqmaccu_4x8x4,  SF_QOP_SUU_B,
> > +        H4, H1, H1, 4, 8, 32)
> > +RVVCALL(GEN_VEXT_SF_INT8_MATMUL, sf_vqmacc_4x8x4,   SF_QOP_SSS_B,
> > +        H4, H1, H1, 4, 8, 32)
> > +RVVCALL(GEN_VEXT_SF_INT8_MATMUL, sf_vqmaccus_4x8x4, SF_QOP_SUS_B,
> > +        H4, H1, H1, 4, 8, 32)
> > +RVVCALL(GEN_VEXT_SF_INT8_MATMUL, sf_vqmaccsu_4x8x4, SF_QOP_SSU_B,
> > +        H4, H1, H1, 4, 8, 32)
> > +RVVCALL(GEN_VEXT_SF_INT8_MATMUL, sf_vqmaccu_2x8x2,  SF_QOP_SUU_B,
> > +        H4, H1, H1, 2, 8, 16)
> > +RVVCALL(GEN_VEXT_SF_INT8_MATMUL, sf_vqmacc_2x8x2,   SF_QOP_SSS_B,
> > +        H4, H1, H1, 2, 8, 16)
> > +RVVCALL(GEN_VEXT_SF_INT8_MATMUL, sf_vqmaccus_2x8x2, SF_QOP_SUS_B,
> > +        H4, H1, H1, 2, 8, 16)
> > +RVVCALL(GEN_VEXT_SF_INT8_MATMUL, sf_vqmaccsu_2x8x2, SF_QOP_SSU_B,
> > +        H4, H1, H1, 2, 8, 16)
> > diff --git a/target/riscv/xsf.decode b/target/riscv/xsf.decode
> > new file mode 100644
> > index 0000000000..bb585046ab
> > --- /dev/null
> > +++ b/target/riscv/xsf.decode
> > @@ -0,0 +1,30 @@
> > +#
> > +# RISC-V translation routines for the SiFive vendor extensions
> > +#
> > +# Copyright (c) 2023 SiFive, Inc.
> > +#
> > +# SPDX-License-Identifier: GPL-2.0-or-later
> > +
> > +# Fields:
> > +%rs2       20:5
> > +%rs1       15:5
> > +%rd        7:5
> > +%vm        25:1
> > +
> > +# Argument sets:
> > +&rmrr      vm rd rs1 rs2                           !extern
> > +
> > +# Formats:
> > +@r_vm_1    ......  . ..... ..... ... ..... ....... &rmrr vm=1 %rs2 %rs1 %rd
> > +
> > +# *** Xsfvqmaccqoq: SiFive custom int8 matrix-multiply (4x8x4 tile) ***
> > +sf_vqmaccu_4x8x4    111100 1 ..... ..... 010 ..... 1011011 @r_vm_1
> > +sf_vqmacc_4x8x4     111101 1 ..... ..... 010 ..... 1011011 @r_vm_1
> > +sf_vqmaccus_4x8x4   111110 1 ..... ..... 010 ..... 1011011 @r_vm_1
> > +sf_vqmaccsu_4x8x4   111111 1 ..... ..... 010 ..... 1011011 @r_vm_1
> > +
> > +# *** Xsfvqmaccdod: SiFive custom int8 matrix-multiply (2x8x2 tile) ***
> > +sf_vqmaccu_2x8x2    101100 1 ..... ..... 010 ..... 1011011 @r_vm_1
> > +sf_vqmacc_2x8x2     101101 1 ..... ..... 010 ..... 1011011 @r_vm_1
> > +sf_vqmaccus_2x8x2   101110 1 ..... ..... 010 ..... 1011011 @r_vm_1
> > +sf_vqmaccsu_2x8x2   101111 1 ..... ..... 010 ..... 1011011 @r_vm_1
> 

