Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D198CC6B1A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 08:19:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGuCG-00072o-Du; Wed, 14 Oct 2026 04:18:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1xGuC9-00072M-UA
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 04:18:42 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1xGuC6-0001eQ-To
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 04:18:41 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8BxrtLSOs9q8a8VAA--.63316S3;
 Wed, 14 Oct 2026 16:18:26 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJBx5czIOs9qbCYsAA--.540S2;
 Wed, 14 Oct 2026 16:18:18 +0800 (CST)
Subject: Re: [PATCH v5 20/23] target/loongarch: translate LVZ guest TLB
 instructions
To: SignKirigami <prcups@krgm.moe>, qemu-devel@nongnu.org
Cc: Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
References: <cover.1791514848.git.prcups@krgm.moe>
 <626719625c086992885e28b019c0db2e33e2f79a.1791514848.git.prcups@krgm.moe>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <61f1f5a9-09df-2ddf-a434-737a65cada91@loongson.cn>
Date: Wed, 14 Oct 2026 16:19:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <626719625c086992885e28b019c0db2e33e2f79a.1791514848.git.prcups@krgm.moe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJBx5czIOs9qbCYsAA--.540S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxCFy7Jr4kAr1fZFWruw4UAwc_yoWrtFy5pr
 12yr1UCr48trZ7Xas8tan8AF98Ar4Iv3W2va43twn5X3y8XF1qyr48t3yYkFW8Xw1kXrWY
 vF4jk34jkrW7tabCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1Ek
 sDUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.783,
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



On 2026/10/9 上午11:05, SignKirigami wrote:
> Decode, disassemble and translate GTLBSRCH, GTLBRD, GTLBWR, GTLBFILL,
> GTLBCLR and GTLBFLUSH for host LVZ execution.
> 
> Signed-off-by: SignKirigami <prcups@krgm.moe>
> Signed-off-by: Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
> ---
>   target/loongarch/disas.c                      |  6 ++
>   target/loongarch/insns.decode                 |  7 +++
>   .../tcg/insn_trans/trans_privileged.c.inc     | 60 +++++++++++++++++++
>   3 files changed, 73 insertions(+)
> 
> diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
> index 2436c9eec3..6425dea17c 100644
> --- a/target/loongarch/disas.c
> +++ b/target/loongarch/disas.c
> @@ -700,6 +700,12 @@ INSN(tlbfill,      empty)
>   INSN(tlbclr,       empty)
>   INSN(tlbflush,     empty)
>   INSN(invtlb,       i_rr)
> +INSN(gtlbclr,      empty)
> +INSN(gtlbflush,    empty)
> +INSN(gtlbsrch,     empty)
> +INSN(gtlbrd,       empty)
> +INSN(gtlbwr,       empty)
> +INSN(gtlbfill,     empty)
>   INSN(cacop,        cop_r_i)
>   INSN(lddir,        rr_i)
>   INSN(ldpte,        j_i)
> diff --git a/target/loongarch/insns.decode b/target/loongarch/insns.decode
> index 4612af9433..cbcc30c31f 100644
> --- a/target/loongarch/insns.decode
> +++ b/target/loongarch/insns.decode
> @@ -499,6 +499,13 @@ bgeu            0110 11 ................ ..... .....     @rr_offs16
>     gcsrxchg          0000 0101 .............. ..... .....     @rr_csr
>   }
>   
> +gtlbclr          0000 01100100 10000 01000 00000 00001    @empty
> +gtlbflush        0000 01100100 10000 01001 00000 00001    @empty
> +gtlbsrch         0000 01100100 10000 01010 00000 00001    @empty
> +gtlbrd           0000 01100100 10000 01011 00000 00001    @empty
> +gtlbwr           0000 01100100 10000 01100 00000 00001    @empty
> +gtlbfill         0000 01100100 10000 01101 00000 00001    @empty
This series instruction for gtlbxxx is not used by KVM, I suggest 
removing these instruction. It make things complicated.

Regards
Bibo Mao
> +
>   iocsrrd_b        0000 01100100 10000 00000 ..... .....    @rr
>   iocsrrd_h        0000 01100100 10000 00001 ..... .....    @rr
>   iocsrrd_w        0000 01100100 10000 00010 ..... .....    @rr
> diff --git a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
> index 37b7ef13dc..ae481aa83f 100644
> --- a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
> +++ b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
> @@ -42,6 +42,12 @@ GEN_FALSE_TRANS(idle)
>   GEN_FALSE_TRANS(gcsrrd)
>   GEN_FALSE_TRANS(gcsrwr)
>   GEN_FALSE_TRANS(gcsrxchg)
> +GEN_FALSE_TRANS(gtlbclr)
> +GEN_FALSE_TRANS(gtlbflush)
> +GEN_FALSE_TRANS(gtlbsrch)
> +GEN_FALSE_TRANS(gtlbrd)
> +GEN_FALSE_TRANS(gtlbwr)
> +GEN_FALSE_TRANS(gtlbfill)
>   
>   #else
>   
> @@ -339,6 +345,15 @@ static bool trans_tlbsrch(DisasContext *ctx, arg_tlbsrch *a)
>       return true;
>   }
>   
> +static bool trans_gtlbsrch(DisasContext *ctx, arg_gtlbsrch *a)
> +{
> +    if (check_plv(ctx) || !avail_LVZ(ctx) || is_guest_mmu_idx(ctx->mem_idx)) {
> +        return false;
> +    }
> +    gen_helper_tlbsrch(tcg_env, tcg_constant_i32(1));
> +    return true;
> +}
> +
>   static bool trans_tlbrd(DisasContext *ctx, arg_tlbrd *a)
>   {
>       if (check_plv(ctx)) {
> @@ -393,6 +408,51 @@ static bool trans_tlbflush(DisasContext *ctx, arg_tlbflush *a)
>       return true;
>   }
>   
> +static bool trans_gtlbrd(DisasContext *ctx, arg_gtlbrd *a)
> +{
> +    if (check_plv(ctx) || !avail_LVZ(ctx) || is_guest_mmu_idx(ctx->mem_idx)) {
> +        return false;
> +    }
> +    gen_helper_tlbrd(tcg_env, tcg_constant_i32(1));
> +    return true;
> +}
> +
> +static bool trans_gtlbwr(DisasContext *ctx, arg_gtlbwr *a)
> +{
> +    if (check_plv(ctx) || !avail_LVZ(ctx) || is_guest_mmu_idx(ctx->mem_idx)) {
> +        return false;
> +    }
> +    gen_helper_tlbwr(tcg_env, tcg_constant_i32(1));
> +    return true;
> +}
> +
> +static bool trans_gtlbfill(DisasContext *ctx, arg_gtlbfill *a)
> +{
> +    if (check_plv(ctx) || !avail_LVZ(ctx) || is_guest_mmu_idx(ctx->mem_idx)) {
> +        return false;
> +    }
> +    gen_helper_tlbfill(tcg_env, tcg_constant_i32(1));
> +    return true;
> +}
> +
> +static bool trans_gtlbclr(DisasContext *ctx, arg_gtlbclr *a)
> +{
> +    if (check_plv(ctx) || !avail_LVZ(ctx) || is_guest_mmu_idx(ctx->mem_idx)) {
> +        return false;
> +    }
> +    gen_helper_tlbclr(tcg_env, tcg_constant_i32(1));
> +    return true;
> +}
> +
> +static bool trans_gtlbflush(DisasContext *ctx, arg_gtlbflush *a)
> +{
> +    if (check_plv(ctx) || !avail_LVZ(ctx) || is_guest_mmu_idx(ctx->mem_idx)) {
> +        return false;
> +    }
> +    gen_helper_tlbflush(tcg_env, tcg_constant_i32(1));
> +    return true;
> +}
> +
>   static bool trans_invtlb(DisasContext *ctx, arg_invtlb *a)
>   {
>       TCGv rj = gpr_src(ctx, a->rj, EXT_NONE);
> 


