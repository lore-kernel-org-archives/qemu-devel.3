Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74732CC6B1A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 09:56:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGvi2-0005ru-7K; Wed, 14 Oct 2026 05:55:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1xGvi0-0005rm-1q
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 05:55:40 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1xGvhx-0003gV-5Z
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 05:55:39 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8DxjdKPUc9qj7cVAA--.62858S3;
 Wed, 14 Oct 2026 17:55:27 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJCxPs+KUc9qCTAsAA--.27216S2;
 Wed, 14 Oct 2026 17:55:24 +0800 (CST)
Subject: Re: [PATCH v5 15/23] target/loongarch: add LVZ to invtlb
To: SignKirigami <prcups@krgm.moe>, qemu-devel@nongnu.org
Cc: Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
References: <cover.1791514848.git.prcups@krgm.moe>
 <e864669d1a8d97f6d70677ef43ce925eef7ed4a8.1791514848.git.prcups@krgm.moe>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <c0d7b38d-cd8b-e363-1051-d2f68dbe417c@loongson.cn>
Date: Wed, 14 Oct 2026 17:56:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <e864669d1a8d97f6d70677ef43ce925eef7ed4a8.1791514848.git.prcups@krgm.moe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxPs+KUc9qCTAsAA--.27216S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3Wr1Uuw43Kr1kCry7AFWrWFX_yoWxJFWkpr
 W7Crs8KFW0k397X3WfJan0gr1UJa1UKw4xX3WSq34SkwsrJr9Y9r1qyw4a9FyrAw45Wr4I
 yayYvw1jgFyUWFgCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
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
> Add op 0x9, 0xa-0xf to instruction invtlb to support vm level 1.
> 
> Signed-off-by: SignKirigami <prcups@krgm.moe>
> Signed-off-by: Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
> ---
>   .../tcg/insn_trans/trans_privileged.c.inc     | 34 +++++++++++++
>   target/loongarch/tcg/tlb_helper.c             | 51 ++++++++++++++++---
>   2 files changed, 77 insertions(+), 8 deletions(-)
> 
> diff --git a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
> index 493ed7f24b..00e8f61e42 100644
> --- a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
> +++ b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
> @@ -328,6 +328,10 @@ static bool trans_invtlb(DisasContext *ctx, arg_invtlb *a)
>           return false;
>       }
>   
> +    if (!avail_LVZ(ctx) && a->imm > 0x6) {
> +        return false;
> +    }
> +
>       switch (a->imm) {
>       case 0x0:
>       case 0x1:
> @@ -352,6 +356,36 @@ static bool trans_invtlb(DisasContext *ctx, arg_invtlb *a)
>           gen_helper_invtlb_page_asid_or_g(tcg_env, rj, rk,
>                                            tcg_constant_i32(0));
>           break;
> +    case 0x9:
> +    case 0x10:
> +    case 0x11:
> +    case 0x12:
> +    case 0x13:
> +    case 0x14:
> +    case 0x15:
> +    case 0x16:
> +        //TODO: refine 0x9-0x16
> +        gen_helper_invtlb_all(tcg_env, rj, tcg_constant_i32(0),
> +                              tcg_constant_i32(0));
> +        break;
> +    case 0xa:
> +        gen_helper_invtlb_all_g(tcg_env, rj, tcg_constant_i32(1),
> +                                tcg_constant_i32(1));
> +        break;
> +    case 0xb:
> +        gen_helper_invtlb_all_g(tcg_env, rj, tcg_constant_i32(0),
> +                                tcg_constant_i32(1));
> +        break;
> +    case 0xc:
> +        gen_helper_invtlb_all_asid(tcg_env, rj, tcg_constant_i32(1));
> +        break;
> +    case 0xd:
> +        gen_helper_invtlb_page_asid(tcg_env, rj, rk, tcg_constant_i32(1));
> +        break;
> +    case 0xe:
> +        gen_helper_invtlb_page_asid_or_g(tcg_env, rj, rk,
> +                                         tcg_constant_i32(1));
> +        break;
>       default:
>           return false;
>       }
> diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
> index 60c7193283..c02b7c2472 100644
> --- a/target/loongarch/tcg/tlb_helper.c
> +++ b/target/loongarch/tcg/tlb_helper.c
> @@ -599,9 +599,18 @@ void helper_tlbflush(CPULoongArchState *env, uint32_t vm_level)
>   void helper_invtlb_all(CPULoongArchState *env, target_ulong info, uint32_t op,
>                          uint32_t to_guest)
>   {
> +    uint16_t gid = to_guest ? (info & 0xff) : get_tgid(env);
> +
> +    if (to_guest && env_vm_level(env) == VM_LEVEL1) {
> +        do_raise_exception(env, EXCCODE_IPE, GETPC());
> +    }
> +
> +    to_guest |= env_vm_level(env) == VM_LEVEL1;
> +
>       for (int i = 0; i < LOONGARCH_TLB_MAX; i++) {
> -        env->tlb[i].tlb_misc = FIELD_DP64(env->tlb[i].tlb_misc,
> -                                          TLB_MISC, E, 0);
> +        LoongArchTLB *tlb = &env->tlb[i];
> +        if ((op == 0 && to_guest == 0) || tlb_entry_matches_gid(tlb, gid))
> +            tlb->tlb_misc = FIELD_DP64(tlb->tlb_misc, TLB_MISC, E, 0);
>       }
>       tlb_flush(env_cpu(env));
>   }
if gtlb instruction is removed, I think helper_invtlb_xxx APIs can be 
simplified and remove parameter to_guest.

Regards
Bibo Mao
> @@ -609,11 +618,19 @@ void helper_invtlb_all(CPULoongArchState *env, target_ulong info, uint32_t op,
>   void helper_invtlb_all_g(CPULoongArchState *env, target_ulong info, uint32_t g,
>                            uint32_t to_guest)
>   {
> +    uint16_t gid = to_guest ? (info & 0xff) : get_tgid(env);
> +
> +    if (to_guest && env_vm_level(env) == VM_LEVEL1) {
> +        do_raise_exception(env, EXCCODE_IPE, GETPC());
> +    }
> +
> +    to_guest |= env_vm_level(env) == VM_LEVEL1;
> +
>       for (int i = 0; i < LOONGARCH_TLB_MAX; i++) {
>           LoongArchTLB *tlb = &env->tlb[i];
>           uint8_t tlb_g = FIELD_EX64(tlb->tlb_entry0, TLBENTRY, G);
>   
> -        if (tlb_g == g) {
> +        if (tlb_g == g && tlb_entry_matches_gid(tlb, gid)) {
>               tlb->tlb_misc = FIELD_DP64(tlb->tlb_misc, TLB_MISC, E, 0);
>           }
>       }
> @@ -624,13 +641,19 @@ void helper_invtlb_all_asid(CPULoongArchState *env, target_ulong info,
>                               uint32_t to_guest)
>   {
>       uint16_t asid = info & R_CSR_ASID_ASID_MASK;
> +    uint16_t gid = to_guest ? ((info >> 16) & 0xff) : get_tgid(env);
> +
> +    if (to_guest) {
> +        do_raise_exception(env, EXCCODE_IPE, GETPC());
> +    }
> +    to_guest |= env_vm_level(env);
>   
>       for (int i = 0; i < LOONGARCH_TLB_MAX; i++) {
>           LoongArchTLB *tlb = &env->tlb[i];
>           uint8_t tlb_g = FIELD_EX64(tlb->tlb_entry0, TLBENTRY, G);
>           uint16_t tlb_asid = FIELD_EX64(tlb->tlb_misc, TLB_MISC, ASID);
>   
> -        if (!tlb_g && (tlb_asid == asid)) {
> +        if (!tlb_g && tlb_asid == asid && tlb_entry_matches_gid(tlb, gid)) {
>               tlb->tlb_misc = FIELD_DP64(tlb->tlb_misc, TLB_MISC, E, 0);
>           }
>       }
> @@ -640,12 +663,19 @@ void helper_invtlb_all_asid(CPULoongArchState *env, target_ulong info,
>   void helper_invtlb_page_asid(CPULoongArchState *env, target_ulong info,
>                                target_ulong addr, uint32_t to_guest)
>   {
> -    int asid = info & 0x3ff;
> +
> +    uint16_t asid = info & R_CSR_ASID_ASID_MASK;
> +    uint16_t gid = to_guest ? ((info >> 16) & 0xff) : get_tgid(env);
>       const LoongArchTLB *tlb;
>       tlb_match func;
>   
> +    if (to_guest && env_vm_level(env)) {
> +        do_raise_exception(env, EXCCODE_IPE, GETPC());
> +    }
> +    to_guest |= env_vm_level(env);
> +
>       func = tlb_match_asid;
> -    tlb = loongarch_tlb_search_cb(env, addr, asid, func, to_guest, 0);
> +    tlb = loongarch_tlb_search_cb(env, addr, asid, func, to_guest, gid);
>       if (tlb) {
>           invalidate_tlb(env, tlb - env->tlb, to_guest);
>       }
> @@ -654,13 +684,18 @@ void helper_invtlb_page_asid(CPULoongArchState *env, target_ulong info,
>   void helper_invtlb_page_asid_or_g(CPULoongArchState *env, target_ulong info,
>                                     target_ulong addr, uint32_t to_guest)
>   {
> -    int asid = info & 0x3ff;
> +    uint16_t asid = info & R_CSR_ASID_ASID_MASK;
> +    uint16_t gid = to_guest ? ((info >> 16) & 0xff) : get_tgid(env);
>       const LoongArchTLB *tlb;
>       tlb_match func;
>   
>       func = tlb_match_any;
> +    if (to_guest) {
> +        do_raise_exception(env, EXCCODE_IPE, GETPC());
> +    }
> +    to_guest |= env_vm_level(env);
>       tlb = loongarch_tlb_search_cb(env, addr, asid, func,
> -                                  to_guest, 0);
> +                                  to_guest, gid);
>       if (tlb) {
>           invalidate_tlb(env, tlb - env->tlb, to_guest);
>       }
> 


