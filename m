Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 864B6CA1002
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Sep 2025 08:41:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uu5VP-0001DT-Js; Thu, 04 Sep 2025 04:39:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@zevorn.cn>)
 id 1uu5VO-0001CX-83; Thu, 04 Sep 2025 04:39:42 -0400
Received: from [115.124.28.59] (helo=out28-59.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@zevorn.cn>)
 id 1uu5VE-0006t8-AM; Thu, 04 Sep 2025 04:39:41 -0400
Received: from 10.13.14.160(mailfrom:chao.liu@zevorn.cn
 fp:SMTPD_---.eXFRmBL_1756974909 cluster:ay29) by smtp.aliyun-inc.com;
 Thu, 04 Sep 2025 16:35:10 +0800
Message-ID: <46df01bf-8885-4834-bf51-8bc304f2aa47@zevorn.cn>
Date: Thu, 4 Sep 2025 16:35:09 +0800
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
 <eimd6dqomns6jqkh4rnma42lxlzlroyibbgm32yb7oztljensy@gw4u4flnwpwo>
From: Chao Liu <chao.liu@zevorn.cn>
In-Reply-To: <eimd6dqomns6jqkh4rnma42lxlzlroyibbgm32yb7oztljensy@gw4u4flnwpwo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.28.59 (deferred)
Received-SPF: pass client-ip=115.124.28.59; envelope-from=chao.liu@zevorn.cn;
 helo=out28-59.mail.aliyun.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01,
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

On 2025/9/4 13:05, Nicholas Piggin wrote:
> On Wed, Sep 03, 2025 at 09:52:01PM +0800, Chao Liu wrote:
>> From: Chao Liu <chao.liu@yeah.net>
> 
>> +static void gen_ldst_stride_main_loop(DisasContext *s, TCGv dest, uint32_t rs1,
>> +                                      uint32_t rs2, uint32_t vm, uint32_t nf,
>> +                                      gen_tl_ldst *ld_fn, gen_tl_ldst *st_fn,
>> +                                      bool is_load)
>> +{
>> +    TCGv addr = tcg_temp_new();
>> +    TCGv base = get_gpr(s, rs1, EXT_NONE);
>> +    TCGv stride = get_gpr(s, rs2, EXT_NONE);
>> +
>> +    TCGv i = tcg_temp_new();
>> +    TCGv i_esz = tcg_temp_new();
>> +    TCGv k = tcg_temp_new();
>> +    TCGv k_esz = tcg_temp_new();
>> +    TCGv k_max = tcg_temp_new();
>> +    TCGv mask = tcg_temp_new();
>> +    TCGv mask_offs = tcg_temp_new();
>> +    TCGv mask_offs_64 = tcg_temp_new();
>> +    TCGv mask_elem = tcg_temp_new();
>> +    TCGv mask_offs_rem = tcg_temp_new();
>> +    TCGv vreg = tcg_temp_new();
>> +    TCGv dest_offs = tcg_temp_new();
>> +    TCGv stride_offs = tcg_temp_new();
>> +
>> +    uint32_t max_elems = MAXSZ(s) >> s->sew;
>> +
>> +    TCGLabel *start = gen_new_label();
>> +    TCGLabel *end = gen_new_label();
>> +    TCGLabel *start_k = gen_new_label();
>> +    TCGLabel *inc_k = gen_new_label();
>> +    TCGLabel *end_k = gen_new_label();
>> +
>> +    MemOp atomicity = MO_ATOM_NONE;
>> +    if (s->sew == 0) {
>> +        atomicity = MO_ATOM_NONE;
>> +    } else {
>> +        atomicity = MO_ATOM_IFALIGN_PAIR;
>> +    }
>> +
>> +    tcg_gen_addi_tl(mask, (TCGv)tcg_env, vreg_ofs(s, 0));
>> +
>> +    /* Start of outer loop. */
>> +    tcg_gen_mov_tl(i, cpu_vstart);
>> +    gen_set_label(start);
>> +    tcg_gen_brcond_tl(TCG_COND_GE, i, cpu_vl, end);
>> +    tcg_gen_shli_tl(i_esz, i, s->sew);
>> +    /* Start of inner loop. */
>> +    tcg_gen_movi_tl(k, 0);
>> +    gen_set_label(start_k);
>> +    tcg_gen_brcond_tl(TCG_COND_GE, k, tcg_constant_tl(nf), end_k);
>> +    /*
>> +     * If we are in mask agnostic regime and the operation is not unmasked we
>> +     * set the inactive elements to 1.
>> +     */
>> +    if (!vm && s->vma) {
>> +        TCGLabel *active_element = gen_new_label();
>> +        /* (i + k * max_elems) * esz */
>> +        tcg_gen_shli_tl(mask_offs, k, get_log2(max_elems << s->sew));
>> +        tcg_gen_add_tl(mask_offs, mask_offs, i_esz);
>> +
>> +        /*
>> +         * Check whether the i bit of the mask is 0 or 1.
>> +         *
>> +         * static inline int vext_elem_mask(void *v0, int index)
>> +         * {
>> +         *     int idx = index / 64;
>> +         *     int pos = index  % 64;
>> +         *     return (((uint64_t *)v0)[idx] >> pos) & 1;
>> +         * }
>> +         */
>> +        tcg_gen_shri_tl(mask_offs_64, mask_offs, 3);
>> +        tcg_gen_add_tl(mask_offs_64, mask_offs_64, mask);
>> +        tcg_gen_ld_i64((TCGv_i64)mask_elem, (TCGv_ptr)mask_offs_64, 0);
>> +        tcg_gen_rem_tl(mask_offs_rem, mask_offs, tcg_constant_tl(8));
> 
> Could this be faster with tcg_gen_andi_tl(mask_offs_rem, mask_offs, 7)?
> 

This is a good catch! I'll include this change in the next patch version.


>> +        tcg_gen_shr_tl(mask_elem, mask_elem, mask_offs_rem);
>> +        tcg_gen_andi_tl(mask_elem, mask_elem, 1);
>> +        tcg_gen_brcond_tl(TCG_COND_NE, mask_elem, tcg_constant_tl(0),
>> +                          active_element);
>> +        /*
>> +         * Set masked-off elements in the destination vector register to 1s.
>> +         * Store instructions simply skip this bit as memory ops access memory
>> +         * only for active elements.
>> +         */
>> +        if (is_load) {
>> +            tcg_gen_shli_tl(mask_offs, mask_offs, s->sew);
>> +            tcg_gen_add_tl(mask_offs, mask_offs, dest);
>> +            st_fn(tcg_constant_tl(-1), (TCGv_ptr)mask_offs, 0);
> 
> One more small thing. This is implementing load and store instructions,
> yet there are these ld_fn and st_fn, which makes it a bit confusing.
> Calling them something like read_vreg / write_vreg might help make them
> a bit clearer.
> 

I think the current names are okay? After splitting the vector and mask access
code into smaller functions, it's already much easier to read. Let's review the
next patch version first, then decide if we need to change the names.

> I also suggest try to split the at generation of access for the vector
> data and mask registers to see if you can split them into helper
> functions. That could make this function smaller and a bit nicer to
> review.
> 

Get, I'll split the check for vext_elem_mask() and the Load/Store of the vector
register into separate sub-functions to make review easier.

Thanks,
Chao

