Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18924CA1015
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Sep 2025 07:01:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uu3xJ-0006ZL-SW; Thu, 04 Sep 2025 03:00:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@zevorn.cn>)
 id 1uu3xH-0006Yp-0p; Thu, 04 Sep 2025 03:00:23 -0400
Received: from [115.124.28.65] (helo=out28-65.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@zevorn.cn>)
 id 1uu3xC-0002A5-4a; Thu, 04 Sep 2025 03:00:22 -0400
Received: from 10.13.14.160(mailfrom:chao.liu@zevorn.cn
 fp:SMTPD_---.eXDIV52_1756968952 cluster:ay29) by smtp.aliyun-inc.com;
 Thu, 04 Sep 2025 14:55:53 +0800
Message-ID: <cf85034b-5f37-4b28-840b-2982a540eade@zevorn.cn>
Date: Thu, 4 Sep 2025 14:55:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] target/riscv: Generate strided vector loads/stores
 with tcg nodes.
To: Nicholas Piggin <npiggin@gmail.com>
Cc: richard.henderson@linaro.org, paolo.savini@embecosm.com,
 ebiggers@kernel.org, dbarboza@ventanamicro.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org, Chao Liu <chao.liu@yeah.net>
References: <cover.1756906528.git.chao.liu@zevorn.cn>
 <bcb383174cf82be8116685273e271cdbdda28a59.1756906528.git.chao.liu@zevorn.cn>
 <lzyoldc5srfkz33clacyjwdrvhyfjyjhn3bhyepo7hv32tsm6t@ogvkrjid23lv>
From: Chao Liu <chao.liu@zevorn.cn>
In-Reply-To: <lzyoldc5srfkz33clacyjwdrvhyfjyjhn3bhyepo7hv32tsm6t@ogvkrjid23lv>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.28.65 (deferred)
Received-SPF: pass client-ip=115.124.28.65; envelope-from=chao.liu@zevorn.cn;
 helo=out28-65.mail.aliyun.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
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


On 2025/9/4 12:37, Nicholas Piggin wrote:
> On Wed, Sep 03, 2025 at 09:52:01PM +0800, Chao Liu wrote:
>> From: Chao Liu <chao.liu@yeah.net>
>>
>> This commit improves the performance of QEMU when emulating strided vector
>> loads and stores by substituting the call for the helper function with the
>> generation of equivalent TCG operations.
>>
>> PS:
>>
>> An implementation is permitted to cause an illegal instruction if vstart
>> is not 0 and it is set to a value that can not be produced implicitly by
>> the implementation, but memory accesses will generally always need to
>> deal with page faults.
>>
>> So, if a strided vector memory access instruction has non-zero vstart,
>> check it through vlse/vsse helpers function.
> 
> [...]
> 
>>  typedef void gen_helper_ldst_stride(TCGv_ptr, TCGv_ptr, TCGv,
>>                                      TCGv, TCGv_env, TCGv_i32);
>>  
>>  static bool ldst_stride_trans(uint32_t vd, uint32_t rs1, uint32_t rs2,
>>                                uint32_t data, gen_helper_ldst_stride *fn,
>> -                              DisasContext *s)
>> +                              DisasContext *s, bool is_load)
>>  {
>> -    TCGv_ptr dest, mask;
>> -    TCGv base, stride;
>> -    TCGv_i32 desc;
>> +    if (!s->vstart_eq_zero) {
>> +        TCGv_ptr dest, mask;
>> +        TCGv base, stride;
>> +        TCGv_i32 desc;
>>  
>> -    dest = tcg_temp_new_ptr();
>> -    mask = tcg_temp_new_ptr();
>> -    base = get_gpr(s, rs1, EXT_NONE);
>> -    stride = get_gpr(s, rs2, EXT_NONE);
>> -    desc = tcg_constant_i32(simd_desc(s->cfg_ptr->vlenb,
>> -                                      s->cfg_ptr->vlenb, data));
>> +        dest = tcg_temp_new_ptr();
>> +        mask = tcg_temp_new_ptr();
>> +        base = get_gpr(s, rs1, EXT_NONE);
>> +        stride = get_gpr(s, rs2, EXT_NONE);
>> +        desc = tcg_constant_i32(simd_desc(s->cfg_ptr->vlenb,
>> +                                          s->cfg_ptr->vlenb, data));
>>  
>> -    tcg_gen_addi_ptr(dest, tcg_env, vreg_ofs(s, vd));
>> -    tcg_gen_addi_ptr(mask, tcg_env, vreg_ofs(s, 0));
>> +        tcg_gen_addi_ptr(dest, tcg_env, vreg_ofs(s, vd));
>> +        tcg_gen_addi_ptr(mask, tcg_env, vreg_ofs(s, 0));
>> +        mark_vs_dirty(s);
>> +        fn(dest, mask, base, stride, tcg_env, desc);
>> +        return true;
> 
> Most of the lines changed here should just be indenting the
> existing code into the 'if' branch. So maybe to split the patch
> up a little and make less churn, you could do patch 1 that moves
> this code into a function like gen_call_helper_ldst_stride().
> 
> Then after patch 2 it would be
> 
>     if (!s->vstart_eq_zero) {
>         /* vstart != 0 helper slowpath */
>         gen_call_helper_ldst_stride(vd, rs1, rs2, data, fn, is, is_load);
>         return true;
>     }
> 
>     [...]
> 

Good idea. I've given it a try, and splitting out the
gen_call_helper_ldst_stride() into a separate patch is also very convenient for
review.

I'll include this change in the next version of the patch.

>> +    }
>> +
>> +    TCGv dest = tcg_temp_new();
>> +
>> +    uint32_t nf = FIELD_EX32(data, VDATA, NF);
>> +    uint32_t vm = FIELD_EX32(data, VDATA, VM);
>> +
>> +    /* Destination register and mask register */
>> +    tcg_gen_addi_tl(dest, (TCGv)tcg_env, vreg_ofs(s, vd));
>> +
>> +    /*
>> +     * Select the appropriate load/tore to retrieve data from the vector
>                                       ^^^^ store
> 

get~

> [...]
> 
>> @@ -899,7 +1165,7 @@ static bool ld_stride_op(DisasContext *s, arg_rnfvm *a, uint8_t eew)
>>  {
>>      uint32_t data = 0;
>>      gen_helper_ldst_stride *fn;
>> -    static gen_helper_ldst_stride * const fns[4] = {
>> +    static gen_helper_ldst_stride *const fns[4] = {
>>          gen_helper_vlse8_v, gen_helper_vlse16_v,
>>          gen_helper_vlse32_v, gen_helper_vlse64_v
>>      };
> 
> This probably comes from my patch, just remove the hunk to
> reduce patch size. Ditto for any other stray "cleanups".
> 
>> @@ -915,7 +1181,7 @@ static bool ld_stride_op(DisasContext *s, arg_rnfvm *a, uint8_t eew)
>>      data = FIELD_DP32(data, VDATA, NF, a->nf);
>>      data = FIELD_DP32(data, VDATA, VTA, s->vta);
>>      data = FIELD_DP32(data, VDATA, VMA, s->vma);
>> -    return ldst_stride_trans(a->rd, a->rs1, a->rs2, data, fn, s);
>> +    return ldst_stride_trans(a->rd, a->rs1, a->rs2, data, fn, s, true);
>>  }
>>  
>>  static bool ld_stride_check(DisasContext *s, arg_rnfvm* a, uint8_t eew)
>> @@ -933,23 +1199,13 @@ GEN_VEXT_TRANS(vlse64_v, MO_64, rnfvm, ld_stride_op, ld_stride_check)
>>  static bool st_stride_op(DisasContext *s, arg_rnfvm *a, uint8_t eew)
>>  {
>>      uint32_t data = 0;
>> -    gen_helper_ldst_stride *fn;
>> -    static gen_helper_ldst_stride * const fns[4] = {
>> -        /* masked stride store */
>> -        gen_helper_vsse8_v,  gen_helper_vsse16_v,
>> -        gen_helper_vsse32_v,  gen_helper_vsse64_v
>> -    };
> 
> I gave you an old patch without the stores done, sorry. You
> just need to pass the store helper fn through here similarly
> as for loads (i.e., this hunk should just be the one liner
> change to add extra 'is_load=false' argument to the
> ldst_stride_trans() call.).
> 
> Thanks,
> Nick

get~


