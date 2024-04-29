Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97A05C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 08:28:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1MLi-0004QP-Kq; Mon, 29 Apr 2024 04:26:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1s1MLf-0004PR-HT; Mon, 29 Apr 2024 04:26:55 -0400
Received: from out30-97.freemail.mail.aliyun.com ([115.124.30.97])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1s1MLX-0001Lb-5Q; Mon, 29 Apr 2024 04:26:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1714379197; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
 bh=RKs5luUhDjRIy8Gfru3cowUOzj3JjkEHMuDQOo3EJBA=;
 b=V17pD5F81x8TZH3w43mLYwTMfFb2iG6OYSW3JIgTW/vZH3v/riRoMPGETBocNagOFlcDNVFeqhFipFH82KtPOfRJlePfEy7cDlHQqjtVWwydky0plPo/Bnwmiqe7qsGnf0QbQqrgBg0Y7kCKU7nvRpICilb7IwigYZ3VbJZ8uXY=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R121e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033068173054;
 MF=eric.huang@linux.alibaba.com; NM=1; PH=DS; RN=11; SR=0;
 TI=SMTPD_---0W5U51Ys_1714379195; 
Received: from 30.21.185.170(mailfrom:eric.huang@linux.alibaba.com
 fp:SMTPD_---0W5U51Ys_1714379195) by smtp.aliyun-inc.com;
 Mon, 29 Apr 2024 16:26:36 +0800
Message-ID: <3312833f-57d0-4365-a6ca-b46902b61832@linux.alibaba.com>
Date: Mon, 29 Apr 2024 16:26:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] target/riscv: Implement dynamic establishment of
 custom decoder
From: Huang Tao <eric.huang@linux.alibaba.com>
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 zhiwei_liu@linux.alibaba.com, dbarboza@ventanamicro.com,
 liwei1518@gmail.com, bin.meng@windriver.com, alistair.francis@wdc.com,
 palmer@dabbelt.com, Christoph Muellner <christoph.muellner@vrull.eu>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20240314092158.65866-1-eric.huang@linux.alibaba.com>
 <CAKmqyKP+=Q4oup1mpWskykfgE3HZRJpaVX_JTk=0=jU_TkgsUQ@mail.gmail.com>
 <c9fb4c6e-9eae-4302-82cf-b02eacce6d9d@linux.alibaba.com>
In-Reply-To: <c9fb4c6e-9eae-4302-82cf-b02eacce6d9d@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.97;
 envelope-from=eric.huang@linux.alibaba.com;
 helo=out30-97.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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


On 2024/4/29 15:58, Huang Tao wrote:
>
> On 2024/4/29 11:51, Alistair Francis wrote:
>> On Thu, Mar 14, 2024 at 7:23 PM Huang Tao 
>> <eric.huang@linux.alibaba.com> wrote:
>>> In this patch, we modify the decoder to be a freely composable data
>>> structure instead of a hardcoded one. It can be dynamically builded up
>>> according to the extensions.
>>> This approach has several benefits:
>>> 1. Provides support for heterogeneous cpu architectures. As we add 
>>> decoder in
>>>     RISCVCPU, each cpu can have their own decoder, and the decoders 
>>> can be
>>>     different due to cpu's features.
>>> 2. Improve the decoding efficiency. We run the guard_func to see if 
>>> the decoder
>>>     can be added to the dynamic_decoder when building up the 
>>> decoder. Therefore,
>>>     there is no need to run the guard_func when decoding each 
>>> instruction. It can
>>>     improve the decoding efficiency
>>> 3. For vendor or dynamic cpus, it allows them to customize their own 
>>> decoder
>>>     functions to improve decoding efficiency, especially when 
>>> vendor-defined
>>>     instruction sets increase. Because of dynamic building up, it 
>>> can skip the other
>>>     decoder guard functions when decoding.
>>> 4. Pre patch for allowing adding a vendor decoder before 
>>> decode_insn32() with minimal
>>>     overhead for users that don't need this particular vendor decoder.
>>>
>>> Signed-off-by: Huang Tao <eric.huang@linux.alibaba.com>
>>> Suggested-by: Christoph Muellner <christoph.muellner@vrull.eu>
>>> Co-authored-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
>>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> Do you mind rebasing this on
>> https://github.com/alistair23/qemu/tree/riscv-to-apply.next?
>>
>> Alistair
>
> I will rebase this patch on the latest riscv-to-apply.next.
>
> Thanks
>
I successfully applied this patch to the latest riscv-to-apply.next 
branch. I wonder what error you met on applying this patch to 
riscv-to-apply.next, so I can fix my patch.

Thanks

>>> ---
>>> Changes in v4:
>>> - fix typo
>>> - rename function
>>> - add 'if tcg_enable()'
>>> - move function to tcg-cpu.c and declarations to tcg-cpu.h
>>>
>>> Changes in v3:
>>> - use GPtrArray to save decode function poionter list.
>>> ---
>>>   target/riscv/cpu.c         |  1 +
>>>   target/riscv/cpu.h         |  1 +
>>>   target/riscv/tcg/tcg-cpu.c | 15 +++++++++++++++
>>>   target/riscv/tcg/tcg-cpu.h | 15 +++++++++++++++
>>>   target/riscv/translate.c   | 31 +++++++++++++++----------------
>>>   5 files changed, 47 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>>> index c160b9216b..17070b82a7 100644
>>> --- a/target/riscv/cpu.c
>>> +++ b/target/riscv/cpu.c
>>> @@ -1132,6 +1132,7 @@ void riscv_cpu_finalize_features(RISCVCPU 
>>> *cpu, Error **errp)
>>>               error_propagate(errp, local_err);
>>>               return;
>>>           }
>>> +        riscv_tcg_cpu_finalize_dynamic_decoder(cpu);
>>>       } else if (kvm_enabled()) {
>>>           riscv_kvm_cpu_finalize_features(cpu, &local_err);
>>>           if (local_err != NULL) {
>>> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
>>> index 3b1a02b944..48e67410e1 100644
>>> --- a/target/riscv/cpu.h
>>> +++ b/target/riscv/cpu.h
>>> @@ -457,6 +457,7 @@ struct ArchCPU {
>>>       uint32_t pmu_avail_ctrs;
>>>       /* Mapping of events to counters */
>>>       GHashTable *pmu_event_ctr_map;
>>> +    const GPtrArray *decoders;
>>>   };
>>>
>>>   /**
>>> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
>>> index ab6db817db..c9ab92ea2f 100644
>>> --- a/target/riscv/tcg/tcg-cpu.c
>>> +++ b/target/riscv/tcg/tcg-cpu.c
>>> @@ -853,6 +853,21 @@ void riscv_tcg_cpu_finalize_features(RISCVCPU 
>>> *cpu, Error **errp)
>>>       }
>>>   }
>>>
>>> +void riscv_tcg_cpu_finalize_dynamic_decoder(RISCVCPU *cpu)
>>> +{
>>> +    GPtrArray *dynamic_decoders;
>>> +    dynamic_decoders = g_ptr_array_sized_new(decoder_table_size);
>>> +    for (size_t i = 0; i < decoder_table_size; ++i) {
>>> +        if (decoder_table[i].guard_func &&
>>> +            decoder_table[i].guard_func(&cpu->cfg)) {
>>> +            g_ptr_array_add(dynamic_decoders,
>>> + (gpointer)decoder_table[i].riscv_cpu_decode_fn);
>>> +        }
>>> +    }
>>> +
>>> +    cpu->decoders = dynamic_decoders;
>>> +}
>>> +
>>>   bool riscv_cpu_tcg_compatible(RISCVCPU *cpu)
>>>   {
>>>       return object_dynamic_cast(OBJECT(cpu), TYPE_RISCV_CPU_HOST) 
>>> == NULL;
>>> diff --git a/target/riscv/tcg/tcg-cpu.h b/target/riscv/tcg/tcg-cpu.h
>>> index f7b32417f8..ce94253fe4 100644
>>> --- a/target/riscv/tcg/tcg-cpu.h
>>> +++ b/target/riscv/tcg/tcg-cpu.h
>>> @@ -26,4 +26,19 @@ void riscv_cpu_validate_set_extensions(RISCVCPU 
>>> *cpu, Error **errp);
>>>   void riscv_tcg_cpu_finalize_features(RISCVCPU *cpu, Error **errp);
>>>   bool riscv_cpu_tcg_compatible(RISCVCPU *cpu);
>>>
>>> +struct DisasContext;
>>> +struct RISCVCPUConfig;
>>> +typedef struct RISCVDecoder {
>>> +    bool (*guard_func)(const struct RISCVCPUConfig *);
>>> +    bool (*riscv_cpu_decode_fn)(struct DisasContext *, uint32_t);
>>> +} RISCVDecoder;
>>> +
>>> +typedef bool (*riscv_cpu_decode_fn)(struct DisasContext *, uint32_t);
>>> +
>>> +extern const size_t decoder_table_size;
>>> +
>>> +extern const RISCVDecoder decoder_table[];
>>> +
>>> +void riscv_tcg_cpu_finalize_dynamic_decoder(RISCVCPU *cpu);
>>> +
>>>   #endif
>>> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
>>> index ea5d52b2ef..bce16d5054 100644
>>> --- a/target/riscv/translate.c
>>> +++ b/target/riscv/translate.c
>>> @@ -37,6 +37,8 @@
>>>   #include "exec/helper-info.c.inc"
>>>   #undef  HELPER_H
>>>
>>> +#include "tcg/tcg-cpu.h"
>>> +
>>>   /* global register indices */
>>>   static TCGv cpu_gpr[32], cpu_gprh[32], cpu_pc, cpu_vl, cpu_vstart;
>>>   static TCGv_i64 cpu_fpr[32]; /* assume F and D extensions */
>>> @@ -117,6 +119,7 @@ typedef struct DisasContext {
>>>       bool frm_valid;
>>>       /* TCG of the current insn_start */
>>>       TCGOp *insn_start;
>>> +    const GPtrArray *decoders;
>>>   } DisasContext;
>>>
>>>   static inline bool has_ext(DisasContext *ctx, uint32_t ext)
>>> @@ -1120,21 +1123,16 @@ static inline int insn_len(uint16_t first_word)
>>>       return (first_word & 3) == 3 ? 4 : 2;
>>>   }
>>>
>>> +const RISCVDecoder decoder_table[] = {
>>> +    { always_true_p, decode_insn32 },
>>> +    { has_xthead_p, decode_xthead},
>>> +    { has_XVentanaCondOps_p, decode_XVentanaCodeOps},
>>> +};
>>> +
>>> +const size_t decoder_table_size = ARRAY_SIZE(decoder_table);
>>> +
>>>   static void decode_opc(CPURISCVState *env, DisasContext *ctx, 
>>> uint16_t opcode)
>>>   {
>>> -    /*
>>> -     * A table with predicate (i.e., guard) functions and decoder 
>>> functions
>>> -     * that are tested in-order until a decoder matches onto the 
>>> opcode.
>>> -     */
>>> -    static const struct {
>>> -        bool (*guard_func)(const RISCVCPUConfig *);
>>> -        bool (*decode_func)(DisasContext *, uint32_t);
>>> -    } decoders[] = {
>>> -        { always_true_p,  decode_insn32 },
>>> -        { has_xthead_p, decode_xthead },
>>> -        { has_XVentanaCondOps_p,  decode_XVentanaCodeOps },
>>> -    };
>>> -
>>>       ctx->virt_inst_excp = false;
>>>       ctx->cur_insn_len = insn_len(opcode);
>>>       /* Check for compressed insn */
>>> @@ -1155,9 +1153,9 @@ static void decode_opc(CPURISCVState *env, 
>>> DisasContext *ctx, uint16_t opcode)
>>> ctx->base.pc_next + 2));
>>>           ctx->opcode = opcode32;
>>>
>>> -        for (size_t i = 0; i < ARRAY_SIZE(decoders); ++i) {
>>> -            if (decoders[i].guard_func(ctx->cfg_ptr) &&
>>> -                decoders[i].decode_func(ctx, opcode32)) {
>>> +        for (guint i = 0; i < ctx->decoders->len; ++i) {
>>> +            riscv_cpu_decode_fn func = 
>>> g_ptr_array_index(ctx->decoders, i);
>>> +            if (func(ctx, opcode32)) {
>>>                   return;
>>>               }
>>>           }
>>> @@ -1202,6 +1200,7 @@ static void 
>>> riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
>>>       ctx->itrigger = FIELD_EX32(tb_flags, TB_FLAGS, ITRIGGER);
>>>       ctx->zero = tcg_constant_tl(0);
>>>       ctx->virt_inst_excp = false;
>>> +    ctx->decoders = cpu->decoders;
>>>   }
>>>
>>>   static void riscv_tr_tb_start(DisasContextBase *db, CPUState *cpu)
>>> -- 
>>> 2.41.0
>>>
>>>

