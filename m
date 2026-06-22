Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53CE3CDB46B
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 09:00:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbaVb-0001jL-C2; Mon, 22 Jun 2026 04:59:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1wbaVY-0001jA-OL
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 04:59:56 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1wbaVU-0004rZ-0n
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 04:59:56 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8DxBOl6+ThqGYsWAA--.52275S3;
 Mon, 22 Jun 2026 16:59:38 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJCxWeB0+ThqR9CuAA--.4364S3;
 Mon, 22 Jun 2026 16:59:34 +0800 (CST)
Subject: Re: [PATCH 3/4] target/loongarch: translate LVZ CSR and trap
 instructions
To: SignKirigami <prcups@krgm.moe>, qemu-devel@nongnu.org
Cc: Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
References: <cover.1779171125.git.prcups@krgm.moe>
 <QcvEHw3eQdWKrgUEx8sb2A@krgm.moe>
 <a2c3c1e6-ea1d-e889-808c-d7cb95de150d@loongson.cn>
 <PpT5ef17QAWEJFKjwZZgyQ@krgm.moe>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <2a55567c-9cae-e54d-0835-6f88e751275b@loongson.cn>
Date: Mon, 22 Jun 2026 16:56:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <PpT5ef17QAWEJFKjwZZgyQ@krgm.moe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxWeB0+ThqR9CuAA--.4364S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj9fXoW3KF13ZryktF4rXw4UKrW7trc_yoW8AF15to
 WUGr17JF4rJr15AF1DG34qqw4jv34UCr47GFyDZw1DZF4Ut342yr15Jrn5Za1fGF1jgry8
 GFyxJ3WruFW3Wwnxl-sFpf9Il3svdjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8wcxFpf
 9Il3svdxBIdaVrn0xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3
 UjIYCTnIWjp_UUUY47kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI
 8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
 Y2AK021l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14
 v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8j-
 e5UUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.97,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 2026/6/22 下午4:39, SignKirigami wrote:
> On 2026年5月26日星期二 中国标准时间 12:07:35，Bibo Mao wrote：
>>
>> On 2026/5/26 上午11:50, SignKirigami wrote:
>>> 在 2026年5月22日星期五 中国标准时间 11:16:39，Bibo Mao 写道：
>>>>
>>>> On 2026/5/19 下午2:30, SignKirigami wrote:
>>>>> Signed-off-by: SignKirigami <prcups@krgm.moe>
>>>>> Signed-off-by: Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
>>>>> ---
>>>>>     target/loongarch/disas.c                      |   4 +
>>>>>     target/loongarch/insns.decode                 |  11 +
>>>>>     .../tcg/insn_trans/trans_privileged.c.inc     | 225 +++++++++++++++++-
>>>>>     target/loongarch/tcg/translate.c              |   6 +-
>>>>>     target/loongarch/translate.h                  |   2 +
>>>>>     5 files changed, 240 insertions(+), 8 deletions(-)
>>>>>
>>>>> diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
>>>>> index 3249ab7ac6..cae416266b 100644
>>>>> --- a/target/loongarch/disas.c
>>>>> +++ b/target/loongarch/disas.c
>>>>> @@ -698,6 +698,10 @@ INSN(tlbfill,      empty)
>>>>>     INSN(tlbclr,       empty)
>>>>>     INSN(tlbflush,     empty)
>>>>>     INSN(invtlb,       i_rr)
>>>>> +INSN(gcsrrd,       r_csr)
>>>>> +INSN(gcsrwr,       r_csr)
>>>>> +INSN(gcsrxchg,     rr_csr)
>>>>> +INSN(hvcl,         i)
>>>>>     INSN(cacop,        cop_r_i)
>>>>>     INSN(lddir,        rr_i)
>>>>>     INSN(ldpte,        j_i)
>>>>> diff --git a/target/loongarch/insns.decode b/target/loongarch/insns.decode
>>>>> index 3089d42044..2ade384081 100644
>>>>> --- a/target/loongarch/insns.decode
>>>>> +++ b/target/loongarch/insns.decode
>>>>> @@ -493,6 +493,17 @@ bgeu            0110 11 ................ ..... .....     @rr_offs16
>>>>>       csrxchg           0000 0100 .............. ..... .....     @rr_csr
>>>>>     }
>>>>>     
>>>>> +#
>>>>> +# LVZ (LoongArch Virtualization) instructions
>>>>> +#
>>>>> +{
>>>>> +  gcsrrd            0000 0101 .............. 00000 .....     @r_csr
>>>>> +  gcsrwr            0000 0101 .............. 00001 .....     @r_csr
>>>>> +  gcsrxchg          0000 0101 .............. ..... .....     @rr_csr
>>>>> +}
>>>>> +
>>>>> +hvcl             0000 0000 0010 1011 1 ...............    @i15
>>>>> +
>>>>>     iocsrrd_b        0000 01100100 10000 00000 ..... .....    @rr
>>>>>     iocsrrd_h        0000 01100100 10000 00001 ..... .....    @rr
>>>>>     iocsrrd_w        0000 01100100 10000 00010 ..... .....    @rr
>>>>> diff --git a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
>>>>> index 2094d182ac..0cb629e5d7 100644
>>>>> --- a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
>>>>> +++ b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
>>>>> @@ -39,6 +39,10 @@ GEN_FALSE_TRANS(lddir)
>>>>>     GEN_FALSE_TRANS(ertn)
>>>>>     GEN_FALSE_TRANS(dbcl)
>>>>>     GEN_FALSE_TRANS(idle)
>>>>> +GEN_FALSE_TRANS(gcsrrd)
>>>>> +GEN_FALSE_TRANS(gcsrwr)
>>>>> +GEN_FALSE_TRANS(gcsrxchg)
>>>>> +GEN_FALSE_TRANS(hvcl)
>>>>>     
>>>>>     #else
>>>>>     
>>>>> @@ -69,8 +73,25 @@ static bool set_csr_trans_func(unsigned int csr_num, GenCSRRead readfn,
>>>>>         return true;
>>>>>     }
>>>>>     
>>>>> +static bool set_gcsr_trans_func(unsigned int csr_num, GenCSRRead readfn,
>>>>> +                                GenCSRWrite writefn)
>>>>> +{
>>>>> +    CSRInfo *csr;
>>>>> +
>>>>> +    csr = get_gcsr(csr_num);
>>>>> +    if (!csr) {
>>>>> +        return false;
>>>>> +    }
>>>>> +
>>>>> +    csr->readfn = (GenCSRFunc)readfn;
>>>>> +    csr->writefn = (GenCSRFunc)writefn;
>>>>> +    return true;
>>>>> +}
>>>>> +
>>>>>     #define SET_CSR_FUNC(NAME, read, write)                 \
>>>>>             set_csr_trans_func(LOONGARCH_CSR_##NAME, read, write)
>>>>> +#define SET_GCSR_FUNC(NAME, read, write)                \
>>>>> +        set_gcsr_trans_func(LOONGARCH_CSR_##NAME, read, write)
>>>>>     
>>>>>     void loongarch_csr_translate_init(void)
>>>>>     {
>>>>> @@ -85,14 +106,28 @@ void loongarch_csr_translate_init(void)
>>>>>         SET_CSR_FUNC(TVAL,  gen_helper_csrrd_tval, NULL);
>>>>>         SET_CSR_FUNC(TICLR, NULL, gen_helper_csrwr_ticlr);
>>>>>         SET_CSR_FUNC(MSGIR, gen_helper_csrrd_msgir, NULL);
>>>>> +    SET_CSR_FUNC(GSTAT, NULL, gen_helper_csrwr_gstat);
>>>>> +    SET_CSR_FUNC(GTLBC, NULL, gen_helper_csrwr_gtlbc);
>>>>> +    SET_CSR_FUNC(GINTC, NULL, gen_helper_csrwr_gintc);
>>>>> +
>>>>> +    SET_GCSR_FUNC(ESTAT, NULL, gen_helper_gcsrwr_estat);
>>>>> +    SET_GCSR_FUNC(ASID, NULL, gen_helper_gcsrwr_asid);
>>>>> +    SET_GCSR_FUNC(PGD, gen_helper_gcsrrd_pgd, NULL);
>>>>> +    SET_GCSR_FUNC(TCFG, NULL, gen_helper_gcsrwr_tcfg);
>>>>> +    SET_GCSR_FUNC(TVAL, gen_helper_gcsrrd_tval, NULL);
>>>>> +    SET_GCSR_FUNC(TICLR, NULL, gen_helper_gcsrwr_ticlr);
>>>>>     }
>>>>>     #undef SET_CSR_FUNC
>>>>> +#undef SET_GCSR_FUNC
>>>>>     
>>>>>     static bool check_csr_flags(DisasContext *ctx, const CSRInfo *csr, bool write)
>>>>>     {
>>>>>         if ((csr->flags & CSRFL_READONLY) && write) {
>>>>>             return false;
>>>>>         }
>>>>> +    if ((csr->flags & CSRFL_GUEST_READONLY) && ctx->guest_mode && write) {
>>>>> +        return false;
>>>>> +    }
>>>>>         if ((csr->flags & CSRFL_IO) && translator_io_start(&ctx->base)) {
>>>>>             ctx->base.is_jmp = DISAS_EXIT_UPDATE;
>>>>>         } else if ((csr->flags & CSRFL_EXITTB) && write) {
>>>>> @@ -110,12 +145,17 @@ static bool trans_csrrd(DisasContext *ctx, arg_csrrd *a)
>>>>>         if (check_plv(ctx)) {
>>>>>             return false;
>>>>>         }
>>>>> -    csr = get_csr(a->csr);
>>>>> +    csr = ctx->guest_mode ? get_gcsr(a->csr) : get_csr(a->csr);
>>>>>         if (csr == NULL) {
>>>>>             /* CSR is undefined: read as 0. */
>>>>>             dest = tcg_constant_tl(0);
>>>>>         } else {
>>>>>             check_csr_flags(ctx, csr, false);
>>>>> +        if (ctx->guest_mode && (csr->flags & CSRFL_GSPR)) {
>>>>> +            gen_helper_gspr(tcg_env);
>>>>> +            gen_set_gpr(a->rd, tcg_constant_tl(0), EXT_NONE);
>>>>> +            return true;
>>>>> +        }
>>>>>             dest = gpr_dst(ctx, a->rd, EXT_NONE);
>>>>>             readfn = (GenCSRRead)csr->readfn;
>>>>>             if (readfn) {
>>>>> @@ -137,12 +177,17 @@ static bool trans_csrwr(DisasContext *ctx, arg_csrwr *a)
>>>>>         if (check_plv(ctx)) {
>>>>>             return false;
>>>>>         }
>>>>> -    csr = get_csr(a->csr);
>>>>> +    csr = ctx->guest_mode ? get_gcsr(a->csr) : get_csr(a->csr);
>>>>>         if (csr == NULL) {
>>>>>             /* CSR is undefined: write ignored, read old_value as 0. */
>>>>>             gen_set_gpr(a->rd, tcg_constant_tl(0), EXT_NONE);
>>>>>             return true;
>>>>>         }
>>>>> +    if (ctx->guest_mode && (csr->flags & CSRFL_GSPR)) {
>>>>> +        gen_helper_gspr(tcg_env);
>>>>> +        gen_set_gpr(a->rd, tcg_constant_tl(0), EXT_NONE);
>>>>> +        return true;
>>>>> +    }
>>>>>         if (!check_csr_flags(ctx, csr, true)) {
>>>>>             /* CSR is readonly: trap. */
>>>>>             return false;
>>>>> @@ -170,28 +215,35 @@ static bool trans_csrxchg(DisasContext *ctx, arg_csrxchg *a)
>>>>>         if (check_plv(ctx)) {
>>>>>             return false;
>>>>>         }
>>>>> -    csr = get_csr(a->csr);
>>>>> +    csr = ctx->guest_mode ? get_gcsr(a->csr) : get_csr(a->csr);
>>>>>         if (csr == NULL) {
>>>>>             /* CSR is undefined: write ignored, read old_value as 0. */
>>>>>             gen_set_gpr(a->rd, tcg_constant_tl(0), EXT_NONE);
>>>>>             return true;
>>>>>         }
>>>>> +    if (ctx->guest_mode && (csr->flags & CSRFL_GSPR)) {
>>>>> +        gen_helper_gspr(tcg_env);
>>>>> +        gen_set_gpr(a->rd, tcg_constant_tl(0), EXT_NONE);
>>>>> +        return true;
>>>>> +    }
>>>>>     
>>>>>         if (!check_csr_flags(ctx, csr, true)) {
>>>>>             /* CSR is readonly: trap. */
>>>>>             return false;
>>>>>         }
>>>>>     
>>>>> -    /* So far only readonly csrs have readfn. */
>>>>> -    assert(csr->readfn == NULL);
>>>>> -
>>>>>         src1 = gpr_src(ctx, a->rd, EXT_NONE);
>>>>>         mask = gpr_src(ctx, a->rj, EXT_NONE);
>>>>>         oldv = tcg_temp_new();
>>>>>         newv = tcg_temp_new();
>>>>>         temp = tcg_temp_new();
>>>>>     
>>>>> -    tcg_gen_ld_tl(oldv, tcg_env, csr->offset);
>>>>> +    if (csr->readfn) {
>>>>> +        GenCSRRead readfn = (GenCSRRead)csr->readfn;
>>>>> +        readfn(oldv, tcg_env);
>>>>> +    } else {
>>>>> +        tcg_gen_ld_tl(oldv, tcg_env, csr->offset);
>>>>> +    }
>>>>>         tcg_gen_and_tl(newv, src1, mask);
>>>>>         tcg_gen_andc_tl(temp, oldv, mask);
>>>>>         tcg_gen_or_tl(newv, newv, temp);
>>>>> @@ -212,6 +264,11 @@ static bool gen_iocsrrd(DisasContext *ctx, arg_rr *a,
>>>>>         TCGv dest = gpr_dst(ctx, a->rd, EXT_NONE);
>>>>>         TCGv src1 = gpr_src(ctx, a->rj, EXT_NONE);
>>>>>     
>>>>> +    if (ctx->guest_mode) {
>>>>> +        gen_helper_gspr(tcg_env);
>>>>> +        return true;
>>>>> +    }
>>>>> +
>>>>>         if (check_plv(ctx)) {
>>>>>             return false;
>>>>>         }
>>>>> @@ -225,6 +282,11 @@ static bool gen_iocsrwr(DisasContext *ctx, arg_rr *a,
>>>>>         TCGv val = gpr_src(ctx, a->rd, EXT_NONE);
>>>>>         TCGv addr = gpr_src(ctx, a->rj, EXT_NONE);
>>>>>     
>>>>> +    if (ctx->guest_mode) {
>>>>> +        gen_helper_gspr(tcg_env);
>>>>> +        return true;
>>>>> +    }
>>>>> +
>>>>>         if (check_plv(ctx)) {
>>>>>             return false;
>>>>>         }
>>>>> @@ -400,6 +462,10 @@ static bool trans_dbcl(DisasContext *ctx, arg_dbcl *a)
>>>>>         if (check_plv(ctx)) {
>>>>>             return false;
>>>>>         }
>>>>> +    if (ctx->guest_mode) {
>>>>> +        gen_helper_gspr(tcg_env);
>>>>> +        return true;
>>>>> +    }
>>>>>         generate_exception(ctx, EXCCODE_DBP);
>>>>>         return true;
>>>>>     }
>>>>> @@ -410,9 +476,154 @@ static bool trans_idle(DisasContext *ctx, arg_idle *a)
>>>>>             return false;
>>>>>         }
>>>>>     
>>>>> +    if (ctx->guest_mode) {
>>>>> +        gen_helper_gspr(tcg_env);
>>>>> +        return true;
>>>>> +    }
>>>>> +
>>>>>         tcg_gen_movi_tl(cpu_pc, ctx->base.pc_next + 4);
>>>>>         gen_helper_idle(tcg_env);
>>>>>         ctx->base.is_jmp = DISAS_NORETURN;
>>>>>         return true;
>>>>>     }
>>>>> +
>>>>> +static bool trans_gcsrrd(DisasContext *ctx, arg_gcsrrd *a)
>>>>> +{
>>>>> +    TCGv dest;
>>>>> +    const CSRInfo *csr;
>>>>> +    GenCSRRead readfn;
>>>>> +
>>>>> +    if (check_plv(ctx)) {
>>>>> +        return false;
>>>>> +    }
>>>>> +    if (!avail_LVZ(ctx) || ctx->guest_mode) {
>>>>> +        return false;
>>>>> +    }
>>>>> +
>>>>> +    csr = get_gcsr(a->csr);
>>>>> +    if (csr == NULL) {
>>>>> +        dest = tcg_constant_tl(0);
>>>>> +    } else {
>>>>> +        dest = gpr_dst(ctx, a->rd, EXT_NONE);
>>>>> +        if (csr->flags & CSRFL_GSPR) {
>>>>> +            tcg_gen_movi_tl(dest, 0);
>>>>> +        } else {
>>>>> +            readfn = (GenCSRRead)csr->readfn;
>>>>> +            if (readfn) {
>>>>> +                readfn(dest, tcg_env);
>>>>> +            } else {
>>>>> +                tcg_gen_ld_tl(dest, tcg_env, csr->offset);
>>>>> +            }
>>>>> +        }
>>>>> +    }
>>>>> +    gen_set_gpr(a->rd, dest, EXT_NONE);
>>>>> +    return true;
>>>>> +}
>>>>> +
>>>>> +static bool trans_gcsrwr(DisasContext *ctx, arg_gcsrwr *a)
>>>>> +{
>>>>> +    TCGv dest, src1;
>>>>> +    const CSRInfo *csr;
>>>>> +    GenCSRWrite writefn;
>>>>> +
>>>>> +    if (check_plv(ctx)) {
>>>>> +        return false;
>>>>> +    }
>>>>> +    if (!avail_LVZ(ctx) || ctx->guest_mode) {
>>>>> +        return false;
>>>>> +    }
>>>>> +
>>>>> +    csr = get_gcsr(a->csr);
>>>>> +    if (csr == NULL) {
>>>>> +        gen_set_gpr(a->rd, tcg_constant_tl(0), EXT_NONE);
>>>>> +        return true;
>>>>> +    }
>>>>> +    if (!check_csr_flags(ctx, csr, true)) {
>>>>> +        return false;
>>>>> +    }
>>>>> +    if (csr->flags & CSRFL_GSPR) {
>>>>> +        gen_set_gpr(a->rd, tcg_constant_tl(0), EXT_NONE);
>>>>> +        return true;
>>>>> +    }
>>>>> +
>>>>> +    src1 = gpr_src(ctx, a->rd, EXT_NONE);
>>>>> +    writefn = (GenCSRWrite)csr->writefn;
>>>>> +    if (writefn) {
>>>>> +        dest = gpr_dst(ctx, a->rd, EXT_NONE);
>>>>> +        writefn(dest, tcg_env, src1);
>>>>> +    } else {
>>>>> +        dest = tcg_temp_new();
>>>>> +        tcg_gen_ld_tl(dest, tcg_env, csr->offset);
>>>>> +        tcg_gen_st_tl(src1, tcg_env, csr->offset);
>>>>> +    }
>>>>> +    gen_set_gpr(a->rd, dest, EXT_NONE);
>>>>> +    return true;
>>>>> +}
>>>>> +
>>>>> +static bool trans_gcsrxchg(DisasContext *ctx, arg_gcsrxchg *a)
>>>>> +{
>>>>> +    TCGv src1, mask, oldv, newv, temp;
>>>>> +    const CSRInfo *csr;
>>>>> +    GenCSRRead readfn;
>>>>> +    GenCSRWrite writefn;
>>>>> +
>>>>> +    if (check_plv(ctx)) {
>>>>> +        return false;
>>>>> +    }
>>>>> +    if (!avail_LVZ(ctx) || ctx->guest_mode) {
>>>>> +        return false;
>>>>> +    }
>>>>> +
>>>>> +    csr = get_gcsr(a->csr);
>>>>> +    if (csr == NULL) {
>>>>> +        gen_set_gpr(a->rd, tcg_constant_tl(0), EXT_NONE);
>>>>> +        return true;
>>>>> +    }
>>>>> +    if (!check_csr_flags(ctx, csr, true)) {
>>>>> +        return false;
>>>>> +    }
>>>>> +    if (csr->flags & CSRFL_GSPR) {
>>>>> +        gen_set_gpr(a->rd, tcg_constant_tl(0), EXT_NONE);
>>>>> +        return true;
>>>>> +    }
>>>>> +
>>>>> +    src1 = gpr_src(ctx, a->rd, EXT_NONE);
>>>>> +    mask = gpr_src(ctx, a->rj, EXT_NONE);
>>>>> +    oldv = tcg_temp_new();
>>>>> +    newv = tcg_temp_new();
>>>>> +    temp = tcg_temp_new();
>>>>> +
>>>>> +    readfn = (GenCSRRead)csr->readfn;
>>>>> +    if (readfn) {
>>>>> +        readfn(oldv, tcg_env);
>>>>> +    } else {
>>>>> +        tcg_gen_ld_tl(oldv, tcg_env, csr->offset);
>>>>> +    }
>>>>> +    tcg_gen_and_tl(newv, src1, mask);
>>>>> +    tcg_gen_andc_tl(temp, oldv, mask);
>>>>> +    tcg_gen_or_tl(newv, newv, temp);
>>>>> +
>>>>> +    writefn = (GenCSRWrite)csr->writefn;
>>>>> +    if (writefn) {
>>>>> +        writefn(oldv, tcg_env, newv);
>>>>> +    } else {
>>>>> +        tcg_gen_st_tl(newv, tcg_env, csr->offset);
>>>>> +    }
>>>>> +    gen_set_gpr(a->rd, oldv, EXT_NONE);
>>>>> +    return true;
>>>>> +}
>>>>> +
>>>>> +static bool trans_hvcl(DisasContext *ctx, arg_hvcl *a)
>>>>> +{
>>>>> +    if (!avail_LVZ(ctx)) {
>>>>> +        return false;
>>>>> +    }
>>>>> +    if (!ctx->guest_mode) {
>>>>> +        return false;
>>>>> +    }
>>>>> +    tcg_gen_movi_tl(cpu_pc, ctx->base.pc_next);
>>>>> +    gen_helper_hvcl(tcg_env, tcg_constant_i32(a->imm));
>>>>> +    ctx->base.is_jmp = DISAS_NORETURN;
>>>>> +    return true;
>>>>> +}
>>>>>     #endif
>>>>> diff --git a/target/loongarch/tcg/translate.c b/target/loongarch/tcg/translate.c
>>>>> index 124dce6269..15c83ef72d 100644
>>>>> --- a/target/loongarch/tcg/translate.c
>>>>> +++ b/target/loongarch/tcg/translate.c
>>>>> @@ -122,12 +122,16 @@ static void loongarch_tr_init_disas_context(DisasContextBase *dcbase,
>>>>>         CPULoongArchState *env = cpu_env(cs);
>>>>>         DisasContext *ctx = container_of(dcbase, DisasContext, base);
>>>>>     
>>>>> +    ctx->guest_mode = (ctx->base.tb->flags & HW_FLAGS_GUEST_MODE) != 0;
>>>>>         ctx->page_start = ctx->base.pc_first & TARGET_PAGE_MASK;
>>>>>         ctx->plv = ctx->base.tb->flags & HW_FLAGS_PLV_MASK;
>>>>>         if (ctx->base.tb->flags & HW_FLAGS_CRMD_PG) {
>>>>>             ctx->mem_idx = ctx->plv;
>>>>> +        if (ctx->guest_mode) {
>>>>> +            ctx->mem_idx += MMU_GUEST_IDX;
>>>>> +        }
>>>>>         } else {
>>>>> -        ctx->mem_idx = MMU_DA_IDX;
>>>>> +        ctx->mem_idx = ctx->guest_mode ? MMU_GUEST_DA_IDX : MMU_DA_IDX;
>>>>>         }
>>>>>     
>>>>>         /* Bound the number of insns to execute to those left on the page.  */
>>>>> diff --git a/target/loongarch/translate.h b/target/loongarch/translate.h
>>>>> index 8aa8325dc6..db0650e713 100644
>>>>> --- a/target/loongarch/translate.h
>>>>> +++ b/target/loongarch/translate.h
>>>>> @@ -26,6 +26,7 @@
>>>>>     #define avail_FP_DP(C)  (FIELD_EX32((C)->cpucfg2, CPUCFG2, FP_DP))
>>>>>     #define avail_LSPW(C)   (FIELD_EX32((C)->cpucfg2, CPUCFG2, LSPW))
>>>>>     #define avail_LAM(C)    (FIELD_EX32((C)->cpucfg2, CPUCFG2, LAM))
>>>>> +#define avail_LVZ(C)    (FIELD_EX32((C)->cpucfg2, CPUCFG2, LVZ))
>>>>>     #define avail_LAM_BH(C) (FIELD_EX32((C)->cpucfg2, CPUCFG2, LAM_BH))
>>>>>     #define avail_LAMCAS(C) (FIELD_EX32((C)->cpucfg2, CPUCFG2, LAMCAS))
>>>>>     #define avail_LSX(C)    (FIELD_EX32((C)->cpucfg2, CPUCFG2, LSX))
>>>>
>>>> static void loongarch_tr_init_disas_context(DisasContextBase *dcbase,
>>>>                                                CPUState *cs)
>>>> {
>>>>
>>>>        if (FIELD_EX64(env->cpucfg[2], CPUCFG2, LSX)) {
>>>>            ctx->vl = LSX_LEN;
>>>>        }
>>>>        if (FIELD_EX64(env->cpucfg[2], CPUCFG2, LASX)) {
>>>>            ctx->vl = LASX_LEN;
>>>>        ctx->cpucfg1 = env->cpucfg[1];
>>>>        ctx->cpucfg2 = env->cpucfg[2];
>>>>        ctx->cpucfg3 = env->cpucfg[3];
>>>> }
>>>>
>>>> There may be some problem with cpucfg configuration, for example host
>>>> has LASX/LSX feature, however vCPU is configured with LASX/LSX feature
>>>> disabled. With the upper piece of code, ctx->cpucfg1 comes from host
>>>> feature setting instead.
>>>>
>>>> Regards
>>>> Bibo Mao
>>>>
>>> When in guest mode, executing cpucfg will cause a gspr exception and exit to
>>> host mode, so these data may not be used.
>> It influences resules of avail_LASX(c), macro avail_LASX(c) of
>> host/guest should be different.
>>
>> #define avail_LASX(C)   (FIELD_EX32((C)->cpucfg2, CPUCFG2, LASX))
>>
>> Here ctx->cpucfg2 = env->cpucfg[2]; they comes from env->cpucfg[2] both.
>> so that avail_LASX(C) will be the same for both host/guest.
>>
>> Regards
>> Bibo Mao
> cpucfg value of L2 guest is set by L1 vmm and saved by L1 kernel, and it's hard
> to get the value when not executing cpucfg command and trigger a gspr
> exception. So, you may regard ctx->cpucfg as an ability to support these
> function by L0 host.
yes, it is, you can discard this issue. With LoongArch HW LVZ design, 
there is only FPU capability display from cpucfg, however no FPU 
enabling with hypervisor.

When executing instruction without hw LASX/LSX supported, illegal FPU 
instruction comes from HW in host mode. And if host supports LASX/LSX 
however VM does not support, it is SW hypervisor to inject illegal FPU 
instruction exception. HW will not inject such exception if it runs in 
VM mode.

Regards
Bibo Mao
> 
> Regards
> SignKirigami
>>>
>>> Regards
>>> SignKirigami
>>>>> @@ -66,6 +67,7 @@ typedef struct DisasContext {
>>>>>         TCGv zero;
>>>>>         bool la64; /* LoongArch64 mode */
>>>>>         bool va32; /* 32-bit virtual address */
>>>>> +    bool guest_mode;
>>>>>         uint32_t cpucfg1;
>>>>>         uint32_t cpucfg2;
>>>>>         uint32_t cpucfg3;
>>>>>
>>>>
>>>>
>>>
>>>
>>>
>>
>>
> 
> 
> 


